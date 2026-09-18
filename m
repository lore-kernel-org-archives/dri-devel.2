Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B52C982DC
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE0410F2B6;
	Fri, 18 Sep 2026 10:06:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="Uc9geHOW";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91AC10F2B6;
 Fri, 18 Sep 2026 10:06:37 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68I9dSFH1687136; Fri, 18 Sep 2026 11:06:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=nyyGsfICKl6UDLxHVBbtG+s
 /iFbvRwCynaXlMznokAU=; b=Uc9geHOWuZF2fyTJHYILnEG0/DYdBbZsgFKl1uo
 Xyeq4KkAvqkrNxz8RkwAOTB7q2Bqf+gCHtWfP5qvt4rxVxVgeWcE8byPZP/woVWy
 nBa/z9JEem5Bq0JScGyb/MAgkP8KZWzUqQXoJZGSoAo6ApgbqwYfSwqlXhCgKGuI
 jWvUmwCpqyU8eTHqJ6SSDtqESWv2rcVarKs1W+JOyKicdhLz6VdWfmEwgRqbdIVm
 bKZPy4Du2Jfa8YAqmnfEZYpIe3jGQPTm4wFyMW+lU7XffYlLavPs4Z/ghkETP7Wr
 uS9FVYMCUnZ1GKBAlRVKD+0S6x1/wtlJaPOFoEV1cCw32Cg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtung34-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Sep 2026 11:06:28 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 18 Sep
 2026 11:06:24 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Subject: [PATCH v2 0/2] Fixes for map() path
Date: Fri, 18 Sep 2026 15:35:38 +0530
Message-ID: <20260918-mmu_fix-v2-0-f7c004fbe203@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPIMrWoC/2WMQQ7CIBAAv9LsWcwWUkw9+Y+mMRSXdg8UA5VoG
 v4u9upxJpPZIVFkSnBtdoiUOXFYK8hTA3Yx60yCH5VBotTYoxTev+6O30L1UhlrNDqNUOtnpKq
 P0zBWXjhtIX6OcW5/9v+RW4HCdp2Ryk0Xa6Yb+3kje7bBw1hK+QLd3Ww0nwAAAA==
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1119;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=1N1UiEuWEXFSvrW9p/wemXb0rx97+jCEHhcSTl2f/hI=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBqrQ0ebJSXEVWJVwO6aR/vdouqbqZp3nl5WR9Yj
 bkNLRQeFhaJAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCaq0NHgAKCRDQJndZfgLx
 cHuAD/9FwWX0Fu+NThEhsBfd2CsKqDnHfbIsyoFxudScFmxRupIZSPv+abAoZ4UixXhuYsOekCT
 7olu7JEfLYV6PAY9KDlojdJrMYyyGt/F5zb3+aMzbAThnGwskeRBlCYG2C7aM/Fn9Shv4F2vw7V
 rxlakoOXYjomttavVGV01pPvMpluy+rVdKiBKkrU8elb7DpnWH5qf5DhZ05t9HFFQZ3N0DtQw3s
 ygw1/ABNiM1WVTJ4XFTXZh4Oqe8ly19Q2U3Ne3F7/l4JxrVXpsoMIjNWsrKQfqoidd2SYF4PO4w
 GrsmjjnffJAMOff8KQJY2CDlureDINTF3OagqCMJ2DdwCY0pGEUj1EizWBnazeqPN26fIMKeEcg
 zG9X3U2Zbyp2lhvEPEAWM+7WaEsXABU4UgQtmXqq4lkXv2OJZzAB+YhpbZUIuUFBKr+2mNWKy8k
 a5L2Xd2lTQh5KpZ6oXUD9OpBFh3+qyew/5V3DIeGeaa4L8GkpWoT/0fV4Gknhja+x6qQkUblBH9
 51zxqPZA1UM1BSxqy5YgS6URrelVutXL0Bg9MzUdwq813FQ7fHo+CojI8w+pSsINllyWE1XbQJc
 OSzHZjy1+/X/3plnFZNgV8y/Zd7aNqaHr1rV6Q3wctJcY8XdqF5Wy1lFO5sjCpzrEMY3Urky2cJ
 6eOZWCiE5yjSKGQ==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Originating-IP: [172.25.128.225]
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aad0d24 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=BHDeEogJK7FFARuNjgwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: 1aUS79igIN_EReuu2YoqF3ZR47tVKuhO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE0MCBTYWx0ZWRfX498bckPkHNxr
 rlAL5absY3EhjKUT34ML0X1Z0U+Sfwvvbp9PvsLqvfH/weIYRZTvKDUF2Ooxvl5pax0hplsTMNY
 /DqhDJc1l4HsB0Sbnk4tw7+Kr50gs03wookaKyPCTFbJMLChIMCP9ber/yVPfFtVEKeLsWcKInA
 VzKGKXH9yQ7OCmkXsdj5mEE2i3uIMa6UvQgwhFTGfZ+80j8vqU5rLAHms2DFvAwVpN0xQJlCSE/
 9H9lSx1NLpmNkqSXSkEHvaSDVW4ejjQZJX6hk9Pis/38fSD3ujhmTnGeC34T6JUsO06jmaEAyYt
 ijyQb8ufw08DpQdVK8ZUGOVQCqpQi5pks/dgKcT3olKK6dc1w315c4OmOmqVsjsofEAFr4w/CkD
 Zz3oFGIO1xtJaJJlmUJPK9iyB0zHCzDr25iMQsZaEuIWx7AQMwHQoZYso9D6llxBah/I/xxGezl
 z0LBvasKMdrIJrR0StQ==
X-Proofpoint-GUID: 1aUS79igIN_EReuu2YoqF3ZR47tVKuhO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE0MCBTYWx0ZWRfX0V8uQR5rFFYN
 1i4ZefTJPnR4utcqLdS4rm65n3dBJPidhR4aHZ1nwUKYf1Pm4e9eLZHAymvoD4FECI71Vc79j8t
 LBvIPfHu4s++ScqsueNlX8tafr/YLFw=
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

Two changes in map() path fix a kernel crash and a map failure.

Patch 0 fixes error path handling which triggers a kernel crash.

Patch 1 fixes prealloc page table memory requirement for a mapping
which led to map failure due to running out of page table space.

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Changes in v2:
- Update as per Alessio's feedback.
- Fixed variable name in the description. Move the error message to a new line.
- Link to v1: https://lore.kernel.org/r/20260902-mmu_fix-v1-0-c55a23fb7cab@imgtec.com

---
Brajesh Gupta (2):
      drm/imagination: Propagate map failures correctly from pvr_mmu_map_sgl()
      drm/imagination: Fix page count for page table for map() interface

 drivers/gpu/drm/imagination/pvr_mmu.c | 19 ++++++++++++-------
 drivers/gpu/drm/imagination/pvr_mmu.h |  2 +-
 drivers/gpu/drm/imagination/pvr_vm.c  |  4 ++--
 3 files changed, 15 insertions(+), 10 deletions(-)
---
base-commit: bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb
change-id: 20260902-mmu_fix-3923aca60f60

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

