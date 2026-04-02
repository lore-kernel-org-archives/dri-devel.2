Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D602CC6B03
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 06:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE21D10F126;
	Thu,  2 Apr 2026 06:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="aQHRcxNL";
	dkim-atps=neutral
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC4410F126
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 06:32:58 +0000 (UTC)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6322uhro1560187; Thu, 2 Apr 2026 06:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0TMDo1
 53CzWYPLoXX4LQewPecE4crDKSu3JXOnmkkug=; b=aQHRcxNLdbhcHaOkDLq8N8
 WdsTQchKOxEoyd1aMi4khg2jc8+MkQmzOB7K7x7IRtDSk9gtqVuAi70/0jVeXWgV
 AE6quDLVvtwA0esZmL1P8sP5S5+mhSMv6jTnOdlxVQchUF2aeuCBWVEDSk2B9k8f
 OABRBMbgHZq4M60gwC1YIgszkDzY2ZO2bI0PT39KX7XixnG93Q7JePBqdJw92y8x
 t4Q/8/xNJJh2mKghKAmj6iqeiaxiKQw5Q0r6pVNq+lWJ0aoGDFKwLV5IhVhq2zOh
 YemfVXV6nZUjiwLeccwE9ju9nEHlQF29qmLBLMD6d0n3IRgFf/UBHy+lAWbaRppA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnujbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 06:32:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6325a5OP021713;
 Thu, 2 Apr 2026 06:32:47 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sass3vp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 06:32:47 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6326Wksb23200410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Apr 2026 06:32:47 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D1A8058053;
 Thu,  2 Apr 2026 06:32:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ACB6D5805D;
 Thu,  2 Apr 2026 06:32:41 +0000 (GMT)
Received: from [9.124.211.187] (unknown [9.124.211.187])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  2 Apr 2026 06:32:41 +0000 (GMT)
Message-ID: <687b02d6-7bf7-4d40-b6d5-7ed627ed5f34@linux.ibm.com>
Date: Thu, 2 Apr 2026 12:02:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] selftests/mm: hmm-tests: don't hardcode THP size to
 2MB
To: Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org
Cc: zenghui.yu@linux.dev, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
 david@kernel.org, jgg@ziepe.ca, leon@kernel.org,
 linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org,
 dri-devel@lists.freedesktop.org, balbirs@nvidia.com
References: <20260331063445.3551404-1-apopple@nvidia.com>
 <20260331063445.3551404-3-apopple@nvidia.com>
Content-Language: en-IN
From: Sayali Patil <sayalip@linux.ibm.com>
In-Reply-To: <20260331063445.3551404-3-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 4X0aRbdByxN6rVrirDnZ3yUrCSbbLMeP
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69ce0d91 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=Ikd4Dj_1AAAA:8 a=LQv_0jpOlx7rUgCL860A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA1NCBTYWx0ZWRfX4V5E8imXBwy4
 GYN3lXKp56QjI9xZpGaaAtbkJv3OACX34+sw3glCV2lYhu39nJqzZG587QQbre0XDXFPMGgbwA5
 6dnLanmDvsj7lfSfm2WsHlQYUKplJzSDK779fAZWTNZKp0ELMprRjjiK+Wy2UK7DRZNK+HrWcZw
 tXkJy1tzWlhpvWAt/hs2lOaE3w3s9MbecVNX8CBzFAyk7mrqMnQ25EFhs3KfezsyOj1/gi5zbua
 axVAIcmwfkiTawwgKxBvlqf5Z9gbLzDZj9Ce/EaosVXTNLicKWhimeA/ur6jaltIFNNhk7RDydm
 vuOmz2p7KjJNP4gv8IGuw9JyA4zQpG4oj1zVop31L+QYxTZDH5hT0VbI30v85XUwgH6ty4Lvn49
 Y8nG6bnh+ha8ibkn6oM+KP9dqwd1Ssf83WjVdRyHTQOUyFCDlp3KcDvEZZioT5herF3eY2BHotu
 05yEL8aKlQFZQw30bNw==
X-Proofpoint-ORIG-GUID: Gb506S43fRUA46xUofpLS-Zj9GZH9vgD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020054
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>



On 31/03/26 12:04, Alistair Popple wrote:
> Several HMM tests hardcode TWOMEG as the THP size. This is wrong on
> architectures where the PMD size is not 2MB such as arm64 with 64K base
> pages where THP is 512MB. Fix this by using read_pmd_pagesize() from
> vm_util instead.
> 
> While here also replace the custom file_read_ulong() helper used to
> parse the default hugetlbfs page size from /proc/meminfo with the
> existing default_huge_page_size() from vm_util.
> 
> [1] https://lore.kernel.org/linux-mm/8bd0396a-8997-4d2e-a13f-5aac033083d7@linux.dev/
> 
> Fixes: fee9f6d1b8df ("mm/hmm/test: add selftests for HMM")
> Fixes: 519071529d2a ("selftests/mm/hmm-tests: new tests for zone device THP migration")
> Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
> Closes: https://lore.kernel.org/linux-mm/8bd0396a-8997-4d2e-a13f-5aac033083d7@linux.dev/
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>   tools/testing/selftests/mm/hmm-tests.c | 83 +++++---------------------
>   1 file changed, 16 insertions(+), 67 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> index e8328c89d855..788689497e92 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c
> @@ -34,6 +34,7 @@
>    */
>   #include <lib/test_hmm_uapi.h>
>   #include <mm/gup_test.h>
> +#include <mm/vm_util.h>
>   
>   struct hmm_buffer {
>   	void		*ptr;
> @@ -548,7 +549,7 @@ TEST_F(hmm, anon_write_child)
>   
>   	for (migrate = 0; migrate < 2; ++migrate) {
>   		for (use_thp = 0; use_thp < 2; ++use_thp) {
> -			npages = ALIGN(use_thp ? TWOMEG : HMM_BUFFER_SIZE,
> +			npages = ALIGN(use_thp ? read_pmd_pagesize() : HMM_BUFFER_SIZE,
>   				       self->page_size) >> self->page_shift;
>   			ASSERT_NE(npages, 0);
>   			size = npages << self->page_shift;
Can we handle the case where read_pmd_pagesize() returns 0? Currently, 
it’s passed to ALIGN(), which could produce unexpected results if 0 is 
returned. Perhaps we can add a fallback to 2MB in that case.

> @@ -728,7 +729,7 @@ TEST_F(hmm, anon_write_huge)
>   	int *ptr;
>   	int ret;
>   
> -	size = 2 * TWOMEG;
> +	size = 2 * read_pmd_pagesize();
>   
>   	buffer = malloc(sizeof(*buffer));
>   	ASSERT_NE(buffer, NULL);
> @@ -744,7 +745,7 @@ TEST_F(hmm, anon_write_huge)
>   			   buffer->fd, 0);
>   	ASSERT_NE(buffer->ptr, MAP_FAILED);
>   
> -	size = TWOMEG;
> +	size /= 2;
>   	npages = size >> self->page_shift;
>   	map = (void *)ALIGN((uintptr_t)buffer->ptr, size);
>   	ret = madvise(map, size, MADV_HUGEPAGE);
> @@ -770,54 +771,6 @@ TEST_F(hmm, anon_write_huge)
>   	hmm_buffer_free(buffer);
>   }
>   
> -/*
> - * Read numeric data from raw and tagged kernel status files.  Used to read
> - * /proc and /sys data (without a tag) and from /proc/meminfo (with a tag).
> - */
> -static long file_read_ulong(char *file, const char *tag)
> -{
> -	int fd;
> -	char buf[2048];
> -	int len;
> -	char *p, *q;
> -	long val;
> -
> -	fd = open(file, O_RDONLY);
> -	if (fd < 0) {
> -		/* Error opening the file */
> -		return -1;
> -	}
> -
> -	len = read(fd, buf, sizeof(buf));
> -	close(fd);
> -	if (len < 0) {
> -		/* Error in reading the file */
> -		return -1;
> -	}
> -	if (len == sizeof(buf)) {
> -		/* Error file is too large */
> -		return -1;
> -	}
> -	buf[len] = '\0';
> -
> -	/* Search for a tag if provided */
> -	if (tag) {
> -		p = strstr(buf, tag);
> -		if (!p)
> -			return -1; /* looks like the line we want isn't there */
> -		p += strlen(tag);
> -	} else
> -		p = buf;
> -
> -	val = strtol(p, &q, 0);
> -	if (*q != ' ') {
> -		/* Error parsing the file */
> -		return -1;
> -	}
> -
> -	return val;
> -}
> -
>   /*
>    * Write huge TLBFS page.
>    */
> @@ -826,15 +779,13 @@ TEST_F(hmm, anon_write_hugetlbfs)
>   	struct hmm_buffer *buffer;
>   	unsigned long npages;
>   	unsigned long size;
> -	unsigned long default_hsize;
> +	unsigned long default_hsize = default_huge_page_size();
>   	unsigned long i;
>   	int *ptr;
>   	int ret;
>   
> -	default_hsize = file_read_ulong("/proc/meminfo", "Hugepagesize:");
> -	if (default_hsize < 0 || default_hsize*1024 < default_hsize)
> +	if (!default_hsize)
>   		SKIP(return, "Huge page size could not be determined");
> -	default_hsize = default_hsize*1024; /* KB to B */
>   
>   	size = ALIGN(TWOMEG, default_hsize);
>   	npages = size >> self->page_shift;
> @@ -1606,7 +1557,7 @@ TEST_F(hmm, compound)
>   	struct hmm_buffer *buffer;
>   	unsigned long npages;
>   	unsigned long size;
> -	unsigned long default_hsize;
> +	unsigned long default_hsize = default_huge_page_size();
>   	int *ptr;
>   	unsigned char *m;
>   	int ret;
> @@ -1614,10 +1565,8 @@ TEST_F(hmm, compound)
>   
>   	/* Skip test if we can't allocate a hugetlbfs page. */
>   
> -	default_hsize = file_read_ulong("/proc/meminfo", "Hugepagesize:");
> -	if (default_hsize < 0 || default_hsize*1024 < default_hsize)
> +	if (!default_hsize)
>   		SKIP(return, "Huge page size could not be determined");
> -	default_hsize = default_hsize*1024; /* KB to B */
>   
>   	size = ALIGN(TWOMEG, default_hsize);
>   	npages = size >> self->page_shift;
> @@ -2106,7 +2055,7 @@ TEST_F(hmm, migrate_anon_huge_empty)
>   	int *ptr;
>   	int ret;
>   
> -	size = TWOMEG;
> +	size = read_pmd_pagesize();
>   
>   	buffer = malloc(sizeof(*buffer));
>   	ASSERT_NE(buffer, NULL);
> @@ -2158,7 +2107,7 @@ TEST_F(hmm, migrate_anon_huge_zero)
>   	int ret;
>   	int val;
>   
> -	size = TWOMEG;
> +	size = read_pmd_pagesize();
>   
>   	buffer = malloc(sizeof(*buffer));
>   	ASSERT_NE(buffer, NULL);
> @@ -2221,7 +2170,7 @@ TEST_F(hmm, migrate_anon_huge_free)
>   	int *ptr;
>   	int ret;
>   
> -	size = TWOMEG;
> +	size = read_pmd_pagesize();
>   
>   	buffer = malloc(sizeof(*buffer));
>   	ASSERT_NE(buffer, NULL);
> @@ -2280,7 +2229,7 @@ TEST_F(hmm, migrate_anon_huge_fault)
>   	int *ptr;
>   	int ret;
>   
> -	size = TWOMEG;
> +	size = read_pmd_pagesize();
>   
>   	buffer = malloc(sizeof(*buffer));
>   	ASSERT_NE(buffer, NULL);
> @@ -2332,7 +2281,7 @@ TEST_F(hmm, migrate_partial_unmap_fault)
>   {
>   	struct hmm_buffer *buffer;
>   	unsigned long npages;
> -	unsigned long size = TWOMEG;
> +	unsigned long size = read_pmd_pagesize();
>   	unsigned long i;
>   	void *old_ptr;
>   	void *map;
> @@ -2398,7 +2347,7 @@ TEST_F(hmm, migrate_remap_fault)
>   {
>   	struct hmm_buffer *buffer;
>   	unsigned long npages;
> -	unsigned long size = TWOMEG;
> +	unsigned long size = read_pmd_pagesize();
>   	unsigned long i;
>   	void *old_ptr, *new_ptr = NULL;
>   	void *map;


Can we please handle the case where read_pmd_pagesize() returns 0, 
wherever its used?
Also, looking at the code, since we are changing size, shouldn’t the 
offsets[] values in migrate_remap_fault and migrate_partial_unmap_fault 
be adjusted accordingly? Right now they are fixed at {0, 512KB, 1MB}.

> @@ -2498,7 +2447,7 @@ TEST_F(hmm, migrate_anon_huge_err)
>   	int *ptr;
>   	int ret;
>   
> -	size = TWOMEG;
> +	size = read_pmd_pagesize();
>   
>   	buffer = malloc(sizeof(*buffer));
>   	ASSERT_NE(buffer, NULL);
> @@ -2593,7 +2542,7 @@ TEST_F(hmm, migrate_anon_huge_zero_err)
>   	int *ptr;
>   	int ret;
>   
> -	size = TWOMEG;
> +	size = read_pmd_pagesize();
>   
>   	buffer = malloc(sizeof(*buffer));
>   	ASSERT_NE(buffer, NULL);

While reviewing the code, I noticed that the benchmark_thp_migration 
testcase also hardcodes the size to 2MB. Can we handle this as well?

I’ve updated it to use read_pmd_pagesize(), with a fallback to 2MB if it 
returns 0.
Additionally, I am capping the maximum number of THPs in benchmark tests 
to avoid integer overflow (e.g., when thp_size * 128 > INT_MAX on 16MB 
PMD-sized THP systems). Compute the maximum number of THPs at runtime as 
INT_MAX / thp_size and use the smaller of this value and 128 for the 
largest benchmark buffer.

diff --git a/tools/testing/selftests/mm/hmm-tests.c 
b/tools/testing/selftests/mm/hmm-tests.c
index 788689497e92..c1c9204dc667 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -2756,8 +2756,15 @@ static inline int run_migration_benchmark(int fd, 
int use_thp, size_t buffer_siz
  TEST_F_TIMEOUT(hmm, benchmark_thp_migration, 120)
  {
  	struct benchmark_results thp_results, regular_results;
-	size_t thp_size = 2 * 1024 * 1024; /* 2MB - typical THP size */
+	size_t thp_size = read_pmd_pagesize();
  	int iterations = 5;
+	size_t max_thps, num_thps;
+
+	if (!thp_size)
+		thp_size = TWOMEG;
+
+	max_thps = INT_MAX / thp_size;
+	num_thps = (max_thps > 128) ? 128 : max_thps;

  	printf("\nHMM THP Migration Benchmark\n");
  	printf("---------------------------\n");
@@ -2765,23 +2772,23 @@ TEST_F_TIMEOUT(hmm, benchmark_thp_migration, 120)

  	/* Test different buffer sizes */
  	size_t test_sizes[] = {
-		thp_size / 4,      /* 512KB - smaller than THP */
-		thp_size / 2,      /* 1MB - half THP */
-		thp_size,          /* 2MB - single THP */
-		thp_size * 2,      /* 4MB - two THPs */
-		thp_size * 4,      /* 8MB - four THPs */
-		thp_size * 8,       /* 16MB - eight THPs */
-		thp_size * 128,       /* 256MB - one twenty eight THPs */
+		thp_size / 4,      /* Quarter THP */
+		thp_size / 2,      /* half THP */
+		thp_size,          /* single THP */
+		thp_size * 2,      /* two THPs */
+		thp_size * 4,      /* four THPs */
+		thp_size * 8,       /* eight THPs */
+		thp_size * num_thps,       /* max THPs without overflow */
  	};

  	static const char *const test_names[] = {
-		"Small Buffer (512KB)",
-		"Half THP Size (1MB)",
-		"Single THP Size (2MB)",
-		"Two THP Size (4MB)",
-		"Four THP Size (8MB)",
-		"Eight THP Size (16MB)",
-		"One twenty eight THP Size (256MB)"
+		"Small Buffer",
+		"Half THP Size",
+		"Single THP Size",
+		"Two THP Size",
+		"Four THP Size",
+		"Eight THP Size",
+		"Large Buffer"
  	};

  	int num_tests = ARRAY_SIZE(test_sizes);
-- 
Thanks,
Sayali
