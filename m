Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6C4CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E2810E41C;
	Mon, 12 Oct 2026 10:21:31 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A299910EF99;
 Mon, 12 Oct 2026 10:21:24 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8OoMW1468537; Mon, 12 Oct 2026 11:21:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=CvTP7Ycy87hvYwRSyfy+WYO
 qPaUcP9swGQ54Z7sEvjo=; b=eKrZhyHwYbH6UB3xiW+31G0aHcI2Ci0fMmPG/vi
 BEwHTYml81eRAPbxkl0H7l6sk8Mw/yYiE5/kJ9+9HrnKWMcEsXZcezpIeOw9pc5z
 RyViIuR7WJZOdje1epWWJg5CxOY+DjGYO8+3aO0QJAbKJUlysnlwJPgxGywJpMpn
 pPFCp+esReOOlshCv30DO1woO7SA9MTygRZ71gcyXi0KAPVOa8xY8CQcl+FenI00
 QhXif0sEwDoaIi+RPWdhwdBprEpnS858vgaJHDu/a3wrymyZI9X2Smz7qgtxLAKp
 YX4a8JMYMm8CuEpyn5T5quFMBKjUNBlTkyJwH1Ttjk1vaNQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4h7bmp97je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2026 11:21:09 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 11:21:08 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH v2 0/2] drm/imagination: MMU defines updates and improvements
Date: Mon, 12 Oct 2026 13:20:56 +0300
Message-ID: <20261012-b4-include-mmu-defines-only-in-mmu-code-v2-0-8aec58777ab6@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIi0zGoC/5WOQQ6CMBBFr0K6dkxbjIIr72FYQDuFMbQ1LSUSw
 t0teAKXb/7L/7OyiIEwsnuxsoAzRfIugzwVTA2t6xFIZ2aSyyuvSw7dBcipMWkEaxNoNOQwgnf
 jkoPjpnwOW1HWVcXNzShkue0dsvk5lp7Nj2PqXqimvX43BoqTD8vxyix27//VWQAHWQtstdEoy
 +5Btp9QnZW3rNm27Qth7uO18QAAAA==
X-Change-ID: 20260930-b4-include-mmu-defines-only-in-mmu-code-a139880f7fce
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791800468; l=1470;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=wOiKe2JJUQz58pJt33mw7llsYXXrPSQVdEOyJrD06rE=;
 b=GS28WmsZEIXBcqX4BgQ+bQMJk628MXWSS5OdkM+u9LJ1Eav0gJ3/Smv7UvdyKq1awjidMDKFj
 jLeh+eF3uxMBhe24Y11Fbjwe6eQt5HBCOHJN2qHsokdjE4W8iS695qS
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MSBTYWx0ZWRfX0Dw7Pz5ysJ1S
 PvgAChqJ78wMbNwuTdhzTfuM9f7Gudc5W2wwMssO77WrfLInx9itXB8VqqL/D5OtYJa//jXZoUX
 rU6PG8YXqPFjdx+D81kMD0WxAPABY9Zxt2miR9L7xjedMry+2n02aKuDrq+XzZ25qykWG0jKZZS
 bISVybkLKL49YSxWTiAOt1BkapJ6W7zHIdsQFrvKH5azGRmrMoeNIVT2tRk/XyGlzv3qHRQ32rT
 iiW4zTqCot3fSRnhHm1kTM4/c48l86g054YCQePzhm0UmbBAczpeO4EAjJJyUCndCKIx6Q0wnf7
 aUNhO/yjIM6w8h48tox6JQDmHMwxvuIf2TwTPQHWOQuKkWsQIsE7kNgM5ytISqbgXOVFRHTX4ZB
 rNwaytjLeiyDOkSyxOntCuJKObxkPL55DgIvNNdq1iC0GH3CmxUqRliRV6vNfTGcEER8XP+RliH
 VeyRWwZePkSvQjinZGQ==
X-Proofpoint-GUID: ZAGC6du4-wibZQ4ygWljX34rpIr5ZYOq
X-Authority-Analysis: v=2.4 cv=QpDLTlyd c=1 sm=1 tr=0 ts=6accb495 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=ZgQMqL77xtEQzMyY3PEA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: ZAGC6du4-wibZQ4ygWljX34rpIr5ZYOq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MSBTYWx0ZWRfX7vvHwaArz0fx
 hOcP+9qQHEnI+ekjVnaP3miVosDKzqJk1KrO6xDdf+H6oFmvZlJ7dL9WXJN7f7N30rmQEytyDiA
 pb5C7enSAmen2sbUi/KntWIAOIxI4XQ=
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

- Restrict the inclusion of MMU defines to MMU code.
- Refactor MMU defines to use kernel style and access.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
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
 drivers/gpu/drm/imagination/pvr_rogue_mmu_defs.h | 239 +++++++++++------------
 drivers/gpu/drm/imagination/pvr_vm.h             |   2 -
 3 files changed, 151 insertions(+), 181 deletions(-)
---
base-commit: 6e375de99d0c420169481fcd36064177ab55b09d
change-id: 20260930-b4-include-mmu-defines-only-in-mmu-code-a139880f7fce

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

