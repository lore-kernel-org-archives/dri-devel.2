Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D45C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F4E10E54A;
	Tue, 22 Sep 2026 04:27:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="pjSIkwDt";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C5E610E194;
 Tue, 22 Sep 2026 04:27:20 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M3WVSr4082733; Tue, 22 Sep 2026 05:27:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=pLa6N/2zmss8lVwXEuURUDe
 9X9nAg76NLwpevcgOH/c=; b=pjSIkwDtm6QeiexGU06wzTvnNmRXTLIvAn42x8V
 4NWuEeOALHbO4FOpf1YUBjkD7cL6/8XX4tZbJ5kQljCJgTsDzg8Jsb7yZKDuLKxa
 3DQKXco3H9Zuq/3FVfGby+DIlMtfDahDRSagSmmFFU3Rmm7EwJMUyaj1zM0FYChY
 npKCV8IDCLlaD72S5C+Ogymv0iYVRXNeSzbDPwmvHK6svzL+UOHp6fAaxy9RS6W+
 jr1w8rZpWhgVhAyjxkxsw8ePKnQfGUPXLkbqhqUvu+l9jpievzbmtD1LIDhMFhr9
 a03FZadjQan4XqO8UL2biSoXDqyvHZGuo3Bu8JXG/vmRIWA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gsgnq22jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 05:27:09 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.122) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 22 Sep
 2026 05:27:05 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Subject: [PATCH v4 0/2] Fixes for map() path
Date: Tue, 22 Sep 2026 09:56:54 +0530
Message-ID: <20260922-mmu_fix-v4-0-12f1a871456a@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI4DsmoC/3XMQQ7CIBCF4asY1mKGoS3WlfcwxgCFlgWtgUo0T
 e8u7UZN4/JN5vsnEk1wJpLTbiLBJBfd0OdR7HdEd7JvDXVN3gQBK6gBqfePm3VPymvkUssKbAU
 kf9+Dyee1dLnm3bk4DuG1hhNbrttGYhSoLkuJ3CqhpTo7345GH/TgyRJJ+AXZ8QMxQys0QGGVQ
 eAbyP9AnqFQvBFcGgsF+4HzPL8Bv9uY9REBAAA=
X-Change-ID: 20260902-mmu_fix-3923aca60f60
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485;
 i=brajesh.gupta@imgtec.com; h=from:subject:message-id;
 bh=Cd2miGRR4el77uw24hQTKCn5r/NhG677q6QO24o9ffg=;
 b=owEBbQKS/ZANAwAKAdAmd1l+AvFwAcsmYgBqsgOXh+Q4fqDHtfpiD0V/MfChn4L1lxtqk4CvQ
 XHT2FD8KM6JAjMEAAEKAB0WIQSQIkZAwD1cxcAsz3LQJndZfgLxcAUCarIDlwAKCRDQJndZfgLx
 cO1fD/9bq9H2UFRcKefzbWcEWhJeWm8qhsxy2BOLYcHKxWtMGQiybIcVj7z86FIpgytBmaFr3jJ
 53w/nXmZglMrJClSkP3nOgUwzS11ymevlPLZs7dg0yd0ChVaSrbFMppyzoyOX3L4J+8G6V5A6f4
 4Pe97yvengWLD45foHjVrWlbkU/RopL/BWmZH7ED020JTVS9/tXqImRyofDZc99uudiX0yGPqbJ
 1vR4g4evbNSDRiTGyDVSODLGN+maYihhJJNZBjG8SzBwLbah+Ww0nBioNCkR2E3FdVUdHfTMvS+
 7ZTfkal79BksMofQzfy/P+09i+a99fpC+ChH1hwwX+P/+YvFSfSM8EjpYsuP6/nqcL5ufSy7QfG
 kA/OOZIhI172j9IChdWhVV4UYj/b6kpvg3NLv8JxYVYY2Nh1i/Fw2T3X4kt8hmfeFJnvhPbpz/0
 09O+gDL0RLhJ4t+PmYhOI0p+UKqHV7lX+IaIJfappRgdUuJdHudpy2jGwkvZQ/xVbmtCtI0im3f
 V/mpjxAo061ZF1g8h086Ho+ucKtG2F876puq6eSw/vP/u9QxznwkTjWseJ3CO/hTAnSkvkydwS4
 4FbfKhGvBJI+fHgpU2UhApLGX20KdARadFZAP7diiLgfamDG6qKZdihPdj2T1BL0H5BVWdS8sri
 A50Labu7UvrVumg==
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=openpgp;
 fpr=05BAA300FD5C580EFD3F8D2F073292BAD0D39671
X-Originating-IP: [172.25.128.122]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MCBTYWx0ZWRfX+PpZnEY07ixF
 LheB3B4ic+JnQzAKtZOoYUnT6UPI8KOpp1j8hwDwEsa9O530d0tmfjh666sKexGtATJ3xTSBXTv
 4n0HtnnOBnrfkez6b6ylETYqyzYKQ4N2m+yoApgyLVtCtx3YMFgoD/efQ6UiwguxclNEeaNQoJj
 uqTDbelHqEuj4SKBNuwKhBT7ntD1WNSjPhiBrPCzjLe1bAsvHgEJRmDO/cXKgylvqWDDXCyV2lj
 3AYQ2PjVSkgpDnQNV3i145BqkkSsRYlHEj/6lqE8kyMm3Y06pv6UibFgjtmHPKAZu+5WiLouG9t
 37v21zfzCaSYOaS1Fq2C0ERHO0igkbJB1VXFsnYotKxLVQrQbLFNfAV989/5fGXvMBiH5BjTe45
 R2mdXbK9nrTD5JyOUtlK2IEr+vQwoY4EuMDk/qgnI73qTOk0trvWnz779Ye5Qf7MCC4ZeuGXF0b
 NoJGciwYV9J1V1HzLXQ==
X-Proofpoint-ORIG-GUID: OQzug5UnEdts7ROjoSRBq7mvCoCrQ3wm
X-Authority-Analysis: v=2.4 cv=fYs4WEQF c=1 sm=1 tr=0 ts=6ab2039d cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ofw6MtmsdEsA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=BHDeEogJK7FFARuNjgwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: OQzug5UnEdts7ROjoSRBq7mvCoCrQ3wm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MCBTYWx0ZWRfX5ECIa9MGcsO6
 8AySr/tQjxnoONJEeJHsomANLNDOYUfKcNxDIryJcY577Kvu/EvCFRra8ihYig2TjTELmm9NtSs
 vJzkecDByOrVtBo5iNkNxjCbWEm9bJs=
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
Changes in v4:
- Fixed trailers in commit message.
- Updated example of the issue in patch 2 commit message.
- Link to v3: https://lore.kernel.org/r/20260918-mmu_fix-v3-0-7b3d73aef041@imgtec.com

Changes in v3:
- Fix the description update suggested for patch 1 in v2.
- Link to v2: https://lore.kernel.org/r/20260918-mmu_fix-v2-0-f7c004fbe203@imgtec.com

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

