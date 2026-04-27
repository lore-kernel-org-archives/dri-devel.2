Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBBCFF8850
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 05:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043AE10E106;
	Mon, 27 Apr 2026 05:32:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="FkBTAHHB";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2AD10E106
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 05:32:31 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R4eXbq2475091; Mon, 27 Apr 2026 06:32:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=5YjTKXeS/huq0NccY5GvqGx
 Q6YuGs2TdKAZrpVhOjEQ=; b=FkBTAHHBXe5B9mNVq2rwEtR4EVPyuyOdugr0OQP
 SWohyB2fkgrag24WeNVZ3O57jUUT5XujxuBhe3cPGw4EQ2UKGnO96mfvrb/y2ezt
 oZAaRjM3+8yK4s71rNUtwCJf4lHt8/Lzgo6Wa9mAevkNnxH4xJtkY7aeBxLVopCP
 SnDWNFiDvlHh1jWEBLcaen0+PtcMWekaSXmi1fm9wl92yBmQCdgDPYwGt2RyXBVA
 T/2aJ9rpLxrY2AlPXMIXQpGOLkbSjPeK9n6ULFHPp25mIhF1QP9ES3k/WaSqsbzI
 KSoWm7r4oSNG/LAL3BFQwKbmPFjhfwNQRXcLw2VDtN48PzA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4drnpxhdhx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 06:32:13 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 27 Apr
 2026 06:32:09 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Subject: [PATCH v3 0/2] drm/imagination: FW trace bug fix and configuration
 update
Date: Mon, 27 Apr 2026 11:01:36 +0530
Message-ID: <20260427-ftrace_fix-v3-0-e081530759a8@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALj07mkC/22MywqDMBAAf0X23JRku9HaU/+jlCLJRnPwQSKhR
 fz3Rk8VepyBmQUiB88RbsUCgZOPfhwyXE4FmK4ZWhbeZgaUWEpSlXBzaAy/nH8LbZkqi0RXIyE
 HU+Cs99njmbnzcR7DZ38ntdm/m6SEFLVjx6omXWNz9307szmbsYftk/CnRTq0mFstFZXOaSytP
 rTrun4Bs4QgMOEAAAA=
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777267929; l=840;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=Ob9cPBZKPD9VuINPtPCn3pll/oS5J290Fzk1wkdZk5c=;
 b=dQ8yAArsgY8qe5j6yHl3qs5n1cIn+KY5z9kAVJICZp84mFynxAyfYD2Y7PLE7uh8msgxWAHcj
 qyr3p41FB6lCJks/Abd+10XZZ0720MlscU8HVCT1mh3qSmqwCdkIvl4
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA1NiBTYWx0ZWRfX7Dn+flidcFoA
 zHvAH4Rn4+boSvG113+oph4niIt+U94GBKHqA7HEzLJjkM85ar34Pa+uAYyJFFN4BypIQg0y9qm
 ff2UQSSMZoX1kSP+ma8GvaJwYd6TQgwv7txzE+uuVAEha7TYoapA1btGsrGnSIwEkeqFwWMvRkJ
 5CkEMBc4LiKzTAcjA31KzWG1v9gb46EoFR+u6I3ZkEuqbKLwKBPi8q09g38fOaC6VTXOcz8LV2d
 oXa5Z7NQpEESJ4p6BuKj1a6ApeKjY6pcpbESuLJbW3rOL9qGCysSdGpNNqPnLC76J4KM6oKeV9I
 XC7Ba78XLq7639GHjg3jhvquBnryXCsWt4wlGgCIlxaisvPW6BVNDsz7wDbBnOMcEP0cG7vSrWC
 M9kQaIPoOErTyvt4dbwiuWv4ci06mCR0DGGZKPfe5OQ1garrVkneekCjNA2j7ro5UTmqDUVCKid
 WsoN9aKGo8ghDI2eDAQ==
X-Authority-Analysis: v=2.4 cv=G9gs1dk5 c=1 sm=1 tr=0 ts=69eef4dd cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=Z6cX24XRCVU5nlZxIyQA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: WYI7Th4GQFyyaLt7tM06vzPTO69Hw-2a
X-Proofpoint-ORIG-GUID: WYI7Th4GQFyyaLt7tM06vzPTO69Hw-2a
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

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Changes in v3:
- Fixed typo in v2 update of commit description.
- Link to v2: https://lore.kernel.org/r/20260424-ftrace_fix-v2-0-50146ff526d5@imgtec.com

Changes in v2:
- Fixed the name of module param in commit description for 2nd patch.
- Link to v1: https://lore.kernel.org/r/20260417-ftrace_fix-v1-0-9fefe194592a@imgtec.com

---
Brajesh Gupta (2):
      drm/imagination: Fix segfault when updating ftrace mask
      drm/imagination: Restrict init_fw_trace_mask module param to read only

 drivers/gpu/drm/imagination/pvr_fw_trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 3bce3fdd1ff2ba242f76ab66659fff27207299f1
change-id: 20260417-ftrace_fix-5de47d2448c0

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

