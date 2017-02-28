
import java.util.ArrayList;
import java.util.List;

/**
 * 
 * @author Kenneth Cheng @2014
 * 
 */
public class StringCompare {

	public static int distence(String a, String b) {
		int[][] matrx = getMatrix(a, b);
		return matrx[a.length()][b.length()];
	}

	/**
	 * compare two string and return the difference
	 * @param ori
	 * @param compare
	 * @return
	 */
	public static List<String> compare(String ori, String compare) {
		boolean isSwap = false;
		String a = ori;
		String b = compare;
		int lengthA = a.length();
		int lengthB = b.length();
		// row for the short String,colume for longer,if not then swap
		if (lengthB < lengthA) {
			// swap
			isSwap = true;
			String swap = "";
			swap = a;
			a = b;
			b = swap;
			swap = null;
			lengthA = a.length();
			lengthB = b.length();
		}

		String[] arrayA = new String[lengthA];
		String[] arrayB = new String[lengthB];
		int[][] matrx = getMatrix(a, b);

		// init array
		for (int i = 0; i < lengthA; i++) {
			String tempA = a.substring(i, i + 1);
			arrayA[i] = tempA;
		}

		for (int i = 0; i < lengthB; i++) {
			String tempB = b.substring(i, i + 1);
			arrayB[i] = tempB;
		}

		int nextI = a.length();
		int nextJ = b.length();
		StringBuffer SBA = new StringBuffer();
		StringBuffer SBB = new StringBuffer();

		// the end comes when next position to the first grid in matrix which
		// present as matrix[0][0];
		while (!(nextI == 0 && nextJ == 0)) {
			// when the search path have already comes at the the first row,the
			// next position is the left grid
			if (nextI == 0) {
				// left
				SBA.append("_");
				SBB.append(arrayB[nextJ - 1]);
				nextI = 0;
				nextJ = nextJ - 1;
				continue;
			}
			// when the search path have already comes at the the first
			// colum,the next position is the up grid
			if (nextJ == 0) {
				// up
				SBA.append(arrayA[nextI - 1]);
				SBB.append("_");
				nextI = nextI - 1;
				nextJ = 0;
				continue;
			}

			//get the current String a and b to compare
			String A = arrayA[nextI - 1];
			String B = arrayB[nextJ - 1];

			int i = matrx[nextI][nextJ];
			if (A.equals(B)) {
				//the next position is the upleft grid from current position
				nextI = nextI - 1;
				nextJ = nextJ - 1;
				SBA.append(A);
				SBB.append(B);
			} else {
				//compare the left ,up ,upleft grid and choose the minimize grid.The priority sink to upleft ,up and left gradually.
				int index = 0;
				int left = 0;
				int up = 0;
				int upLeft = 0;
				int tempRst = 0;

				if (nextI == 0 || nextJ == 0) {
					if (nextI == 0) {
						// first row in matrix
						left = matrx[0][nextJ - 1];
						up = -1;
						upLeft = -1;
						tempRst = left;
					} else {
						// first colume in matrix
						left = -1;
						up = matrx[nextI - 1][0];
						upLeft = -1;
						tempRst = up;
					}
				} else {
					left = matrx[nextI][nextJ - 1];
					up = matrx[nextI - 1][nextJ];
					upLeft = matrx[nextI - 1][nextJ - 1];
					tempRst = Math.min(Math.min(upLeft, up), left);
				}

				if (tempRst == left) {
					index += 1;
				}

				if (tempRst == up) {
					index += 2;
				}

				if (tempRst == upLeft) {
					index += 4;
				}

				switch (index) {
				case 1:
					// left
					nextI = nextI;
					nextJ = nextJ - 1;
					SBA.append("_");
					SBB.append(B);
					break;
				case 2:
					// up
					nextI = nextI - 1;
					nextJ = nextJ;
					SBA.append(A);
					SBB.append("_");
					break;
				case 3:
					// up
					nextI = nextI - 1;
					nextJ = nextJ;
					SBA.append(A);
					SBB.append("_");
					break;
				case 4:
					// midleft
					nextI = nextI - 1;
					nextJ = nextJ - 1;
					SBA.append(A);
					SBB.append(B);
					break;
				case 5:
					// midleft
					nextI = nextI - 1;
					nextJ = nextJ - 1;
					SBA.append(A);
					SBB.append(B);
					break;
				case 6:
					// midleft
					nextI = nextI - 1;
					nextJ = nextJ - 1;
					SBA.append(A);
					SBB.append(B);
					break;
				case 7:
					// midleft
					nextI = nextI - 1;
					nextJ = nextJ - 1;
					SBA.append(A);
					SBB.append(B);
					break;
				}
			}
		}

		List<String> results = new ArrayList<String>();
		if (isSwap) {
			results.add(reverseSort(SBB.toString()));
			results.add(reverseSort(SBA.toString()));
		} else {
			results.add(reverseSort(SBA.toString()));
			results.add(reverseSort(SBB.toString()));
		}

		return results;
	}

	public static String reverseSort(String str) {
		String str2 = "";
		for (int i = str.length() - 1; i > -1; i--) {
			String temp = String.valueOf(str.charAt(i));
			str2 += temp;
		}
		return str2;
	}

	private static int[][] getMatrix(String a, String b) {
		int lengthA = a.length();
		int lengthB = b.length();
		int[][] matrix = new int[lengthA + 1][lengthB + 1];
		String[] arrayA = new String[lengthA];
		String[] arrayB = new String[lengthB];

		// init matrix
		matrix[0][0] = 0;

		// init array
		for (int i = 0; i < lengthA; i++) {
			String tempA = a.substring(i, i + 1);
			arrayA[i] = tempA;
			matrix[i + 1][0] = i + 1;
		}

		for (int i = 0; i < lengthB; i++) {
			String tempB = b.substring(i, i + 1);
			arrayB[i] = tempB;
			matrix[0][i + 1] = i + 1;
			// System.out.println(tempB);
		}

		// calculate matrix value
		for (int i = 1; i <= lengthA; i++) {
			for (int j = 1; j <= lengthB; j++) {
				String tempAi = arrayA[i - 1];
				String tempBj = arrayB[j - 1];
				// System.out.println("ai:" + tempAi + "  " + "bj:" + tempBj);
				if (tempAi.equals(tempBj)) {
					// LD(i,j)=LD(i-1,j-1)
					matrix[i][j] = matrix[i - 1][j - 1];
				} else {
					//  LD(i,j)=Min(LD(i-1,j-1),LD(i-1,j),LD(i,j-1))+1
					int minT = matrix[i - 1][j - 1];
					minT = Math.min(minT, matrix[i - 1][j]);
					minT = Math.min(minT, matrix[i][j - 1]);
					matrix[i][j] = minT + 1;
				}
 
			}
		}
		return matrix;
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		String testA = "s";
		String testB = " ";
		// System.out.println(StringCompare.distence(testA, testB));
		List<String> result = StringCompare.compare(testA, testB);
		System.out.println(result.get(0));
		System.out.println(result.get(1));
	}
}
