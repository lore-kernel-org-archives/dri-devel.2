Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3BA109879A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F216C10E15F;
	Fri, 20 Mar 2026 15:22:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="MPEkOwkB";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E63D10E15F
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 15:22:47 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62K7v2rA3934120; Fri, 20 Mar 2026 15:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=e3Kni6VjSRzzU4wLkMcMFGQ
 Ys+ElUyTvcN9BiZt063s=; b=MPEkOwkBU7+f+VISEEnJdk3biVOSwUcvvUBa647
 5lkb8Ssm3BJxzAzw59rQxZEmietGr4ZNUyKu3sR2hGm8xs88IyZYFSJPQ0lL43A8
 /60qJigqz3ilJHd7ZF97PsGRLDq/2bnRrYmDVnKou5SCZmC/t5/VtSx155Q6sOFs
 7+vl9WuPXAOmcstbGx4m4EsgNpFPNXAcAznd1FsvHR0NTDA1ZjwdNbo2Vh5FwiUs
 amhKac452UolWk/eAm3vYZkDOk5EAm7lzelTnlhTSItM5q0bkPBTUZzLcssVVYmo
 86M6v1YqelpOuUamddB+oD2TAQfCmlTqK9Yok3Ba/6TS8Kw==
Received: from hhmail02.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4cw0mwdjs3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Mar 2026 15:22:24 +0000 (GMT)
Received: from HHMAIL03.hh.imgtec.org (10.44.0.121) by HHMAIL02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 20 Mar
 2026 15:22:23 +0000
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (172.25.4.249) by HHMAIL03.hh.imgtec.org (10.44.0.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 20 Mar 2026 15:22:23 +0000
From: Matt Coster <matt.coster@imgtec.com>
Subject: [PATCH v2 0/2] drm/imagination: GPU_ID-related cleanups
Date: Fri, 20 Mar 2026 15:22:11 +0000
Message-ID: <20260320-bvnc-cleanup-v2-0-49c3c1453289@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACRmvWkC/3XMQQ7CIBCF4as0sxYDiNC46j1MFy0O7SQWGqhE0
 3B3sXuX/0vet0PCSJjg1uwQMVOi4GvIUwN2HvyEjB61QXKpueSajdlbZp84+NfKlNJouNbaKAP
 1skZ09D64e197prSF+Dn0LH7rHygLxpm72Fa0VyXciB0t04b2bMMCfSnlC1dguBWpAAAA
X-Change-ID: 20260206-bvnc-cleanup-446e70666747
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Frank Binns <frank.binns@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Matt
 Coster" <matt.coster@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310;
 i=matt.coster@imgtec.com; h=from:subject:message-id;
 bh=gsPAdkSd32VlIfsr+n7EM7n83d9uKbvwDSGK6ehg7nc=;
 b=owGbwMvMwCFWuUfy8817WRsYT6slMWTuTdO7sDG4fZ2zipTzeiuTiXceqkqVRMUI1307H9948
 2Cv/WSujlIWBjEOBlkxRZYdKyxXqP1R05K48asYZg4rE8gQBi5OAZgI2zWG/zmiose4FWbtXsV8
 LE93gtrpiIXvGySe8qt+NeSoeZnyYSrD/5RM1vX/naqtVUqPPbBPnGUY/VNw2e2jGbu6H7GqfP6
 ixgoA
X-Developer-Key: i=matt.coster@imgtec.com; a=openpgp;
 fpr=05A40CFCE7269D61D97100A1747F0A9036F90DFA
X-Originating-IP: [172.25.4.249]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEyMiBTYWx0ZWRfX6aKUGVHDQ/EN
 eQ4Fp6NHW1oY6aLNplXzgVeUGF4oLD6B73hluAsNA0mLVeg0D1eHo27UbpCCJil2GIkqgg5JoHe
 cL3kjmadMg5T0fZr4BuzK/albt4XFLNvYe5ja/RG507q72fet1Z56TLsNJ0OLhVyFWeh/pYfxbw
 2kEANUiLGj7B624SElvKWfxCaHVSVnJZ/XIV9plCfzGdEGyG/5XQVEHM+kzAenkjBMPgDV4qr5u
 uwJlmgVzDaW4DGA+HrQf42aGuGWCVEbuitkYV1Gn9kgd3ud+oyOuEOC0hk6LbD5y38cJXmSZ3mk
 wQOYMG26X5docMqbkW9r8C+oNWsJA/Xe/3XfegJRTtMaLwzdPiu7Isg+F/EqcMrz9ogpHoW27Hh
 ur/xqRsQN1qGUcNcaRpxE+xOtOwneZGh5IgtO07GDqqG4VQnL/tjlx6ary5PLi72RSlVMpcTTHD
 hMWgVcUWbT72s5h75mw==
X-Authority-Analysis: v=2.4 cv=JaexbEKV c=1 sm=1 tr=0 ts=69bd6630 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Ylr_HOfL8O8A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=3zver3X6ONxOFJZMfJgA:9 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: IP4BmVQJ94uxPXCASrn8zy01JOoeHYe_
X-Proofpoint-ORIG-GUID: IP4BmVQJ94uxPXCASrn8zy01JOoeHYe_
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

Just a couple quick QoL improvements around GPU_IDs.

The first patch touches the UAPI, but is not intended to introduce any
functional changes; it simply codifies the existing documented layout of
packed BVNC fields as a series of GENMASKed macros.

Signed-off-by: Matt Coster <matt.coster@imgtec.com>
---
Changes in v2:
- Add _CONST variant of PVR_PACKED_BVNC() for use in case statements.
  This fixes the build issue reported by the test bot[1][2] (P1)
- Simplify the change made to pvr_fw_validate() (P2)
- Link to v1: https://patch.msgid.link/20260206-bvnc-cleanup-v1-0-f3c818541fbe@imgtec.com

[1]: https://lore.kernel.org/r/202602070204.PjaKNSpZ-lkp@intel.com/
[2]: https://lore.kernel.org/r/202602070500.zo0DrH6U-lkp@intel.com/

---
Matt Coster (2):
      drm/imagination: Define packed BVNCs in the uapi
      drm/imagination: Add PVR_GPU_ID_FMT to format pvr_gpu_id

 drivers/gpu/drm/imagination/pvr_device.c | 10 +++----
 drivers/gpu/drm/imagination/pvr_device.h | 49 +++++++++++++++-----------------
 drivers/gpu/drm/imagination/pvr_fw.c     |  9 ++----
 include/uapi/drm/pvr_drm.h               | 14 ++++-----
 4 files changed, 38 insertions(+), 44 deletions(-)
---
base-commit: fbef867cf6614178bc6afd15ee15f85cddf19eab
change-id: 20260206-bvnc-cleanup-446e70666747

