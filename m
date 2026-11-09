Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BB606A330
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=UV4zqCPH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E504110E845;
	Mon,  9 Nov 2026 11:45:28 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3FCC10E845;
 Mon,  9 Nov 2026 11:45:22 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6A97OPRb2046631; Mon, 9 Nov 2026 11:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=irG90fauHo+0sxPX4/6DXZ3
 VbObB3qleZnxDyg6JX1k=; b=UV4zqCPHfSIkzAHnTAeZ10OhW+KjwM9IWsSZGf3
 ku7LdhuH6QLFM+LhMeiP6TlnoICss09QQljjv+25gRJJ4WAefz709mPSDw7hIhKn
 LM1OvbebfZYS/rmX+fvneag4wO2TJKaDNLHwtgV4WkH4CGfJaOjx1Jm6j9JzSVsb
 6H6sx42BlVVPUOEhSOz4VcOz/Fz0OTjfvnEQffa3qIdd9OyPfB69TGPBATZCc6b1
 nQ/qhkaMz8AVEZk4UsoY4ZDY+acXRVXAN1kzU2bThd4I9LXhMcIeiUXfOdJF3zBC
 BVcw0bQJgPCQu0Z4+c7Uah9VzKz3hAgzVUyKIRiGyLyP41Q==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hsvxx1g4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Mon, 09 Nov 2026 11:45:12 +0000 (GMT)
Received: from [127.0.1.1] (172.25.5.26) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 11:45:10 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH v4 0/2] drm/imagination: MMU defines updates and improvements
Date: Mon, 9 Nov 2026 13:44:50 +0200
Message-ID: <20261109-b4-include-mmu-defines-only-in-mmu-code-v4-0-20a857dcbbbb@imgtec.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADKy8WoC/5XOTW7DIBAF4KtErEPFjx1DVr1HlQUMQ0IUQ2RsK
 5bluxc7Uqqqm3T5mKfvMZOMXcBMjruZdDiGHFIsodrvCFxMPCMNrmQimDgwLRm1FQ0RboND2rY
 DdehDxExTvE3lsL1BKkfDpVaK+cYDkqLdu9J8bEtfp2fOg70i9Cu/Ni4h96mbtq+MfO39f3Xkl
 FGhORrnHQppP0N77hE+ILVknR3FC+aMi/dhUWBlEGrVNI2xhz+w/IE5q96HZYG91qKuuLbKwi9
 4WZZva6I8NKMBAAA=
X-Change-ID: 20260930-b4-include-mmu-defines-only-in-mmu-code-a139880f7fce
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794224710; l=2051;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=6RDFas5RD6WjDcSw2Arfda599rDAkM+c4RDwOfRkiu8=;
 b=eCHYenkwkXCOcBAwrp3D+O325SAS9LOfiBtvnzsaG4C4s6xDqvizerFM7bDjHSL/U4c079AVP
 Ri8lWM9UPCCCEdyj4llTQ8rPG2IXQSU8mC2r5z2pocXOueMCfpE1hnk
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0NiBTYWx0ZWRfX0xi4EHBtvT1N
 nofIm7oczSHU5lR7N1N+6n1+9MLplnrxJQWCXzT5nnQ7saPRMUxbfZfvVazcWy0c8bRafZAH0E6
 er0TLFASy0SOpm0VP9Rb7WZJteCX+z0=
X-Proofpoint-ORIG-GUID: ijNWrFzLBlw0WqJhymLJuv1_a3B_wyVh
X-Authority-Analysis: v=2.4 cv=H+JOUOYi c=1 sm=1 tr=0 ts=6af1b248 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=h_3jC4m0AyQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=e5mUnYsNAAAA:8 a=aErvwOJsbcN-9OlzexIA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0NiBTYWx0ZWRfXzgoyf79BfTKV
 aiuj/lZERcSAKTjBQZrVc+/j/XsMxG77cYe3IMeNjLdBXzXxebRuTAPA1TVfcEUHFO7HX+ykwP4
 Z5BPUhn3Wg1QL6AQJf+7ZGtuv7K64e+1Qy8H/QlcvcPiqnqhi0yNuyAQmQd0Hj3JJYxu2iwEg77
 B2cgdkjwIuEGcQqmYI/1npQ6OlS6tItRDORtwTfG0QexB4K6l4TGK9fGtlZFlZv58JNPoDzG4UM
 lr9qXONk/kmUDpzUYOuiwcdcx+3PcjqNLKsMas/QVONzH4f9X4TCNCXaXXIGV+EFX8tSizRRhlb
 lekrfi+eJALAZa7988XxZq6uqDUkeZNcctRLZ9bLvVoSzBAFGVJrPuv1XwYaIMuFeFG9LnrFNY2
 x5LWqshiPoMNJRBqQv7dZlXKOlorPDvETTdhB2zZGEUPLBYxjUYHgbR82Hrt8Ey9lUTjMXOyfop
 mI/lKuj62uwFtvZOKyw==
X-Proofpoint-GUID: ijNWrFzLBlw0WqJhymLJuv1_a3B_wyVh
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

- Restrict the inclusion of MMU defines to MMU code.
- Refactor MMU defines to use kernel style and access.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Reviewed-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
Reviewed-by: Gyeyoung Baek <gye976@gmail.com>
---
Changes in v4:
- Added "Reviewed-by" tags to the commits.
- Link to v3: https://patch.msgid.link/20261104-b4-include-mmu-defines-only-in-mmu-code-v3-0-f9925419b8bc@imgtec.com

Changes in v3:
- Added ROGUE_MMUCTRL_VADDR_[PC|PD|PT]_INDEX_SHIFT defines.
- Updated the cover letter with the "Reviewed-by" tags.
- Rebased onto a more recent drm-misc-next.
- Link to v2: https://patch.msgid.link/20261012-b4-include-mmu-defines-only-in-mmu-code-v2-0-8aec58777ab6@imgtec.com

Changes in v2:
- Update the pvr_page_table_l2_entry_raw_set() description to better reflect the general changes.
- Link to v1: https://patch.msgid.link/20260930-b4-include-mmu-defines-only-in-mmu-code-v1-0-291eadfde23b@imgtec.com

To: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

---
Alessio Belle (2):
      drm/imagination: Switch to kernel-style MMU defines and access
      drm/imagination: Don't include MMU defines outside of MMU code

 drivers/gpu/drm/imagination/pvr_mmu.c            |  91 ++++-----
 drivers/gpu/drm/imagination/pvr_rogue_mmu_defs.h | 244 +++++++++++------------
 drivers/gpu/drm/imagination/pvr_vm.h             |   2 -
 3 files changed, 156 insertions(+), 181 deletions(-)
---
base-commit: 49f40f15d20f5b4073d517da7efbcea079f1b9e3
change-id: 20260930-b4-include-mmu-defines-only-in-mmu-code-a139880f7fce

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

