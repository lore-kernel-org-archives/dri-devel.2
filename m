Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E705C88E73
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 08:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 431E910FACB;
	Tue, 15 Sep 2026 08:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="UhxTuDRK";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D23310FAE7;
 Tue, 15 Sep 2026 08:04:18 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F6YX3C2004284; Tue, 15 Sep 2026 09:04:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=MqnkhrEECCI0olLRahm1wuL
 5//hXevtCEX0ibgxGSvE=; b=UhxTuDRKynaZ4j2kjiJ4zyjTE7E9zeZh8F6cef8
 56rsPojFuXLJfwxCw0PIiR3Tf2Nak4hqHGdyXydrzyOsQePh+bUVt66gVjEwPs0g
 bUX129iIrv8fY2Loyo+2o+HL8kAgfWhUs6+mLW0MWkiCbMGu0/P2o8oZ63mLRAX/
 C2bGGRyxZ8JrA+91+qF+HYWPKxZsqfG10JVvsySAeGn2SgO+//B67DDX5v/NLT6V
 mCPUz3scgCL9xKusy+hvhw38ftUwWxGLoDYrpXRk3YrLr54fJeLsJnzE6JYqSf4C
 LumXIKduapYs4sXxr5Z5fjWMGBhpkbY4mCyWsrBT2sZGanA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gmxtujca6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 09:04:04 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.88) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 15 Sep
 2026 09:04:02 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Subject: [PATCH 0/2] drm/imagination: Firmware interface cleanup
Date: Tue, 15 Sep 2026 11:03:44 +0300
Message-ID: <20260915-b4-do-not-map-if-structs-unnecessarily-v1-0-a0e2ccee154a@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOD7qGoC/yXNTQ6CMBBA4auQWTsJECTFqxgX/Rl0jE5JpyUaw
 t2tuvw2722glJgUTs0GiVZWjlLRHRrwNytXQg7V0Lf92E7dgG7AEFFixqddkGfUnIrPikWEPKn
 axI83BjJmNC4cTZigxpZEM79+o/Plby3uTj5/67DvH2BuF+GKAAAA
X-Change-ID: 20260914-b4-do-not-map-if-structs-unnecessarily-de8868bd58d9
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789459442; l=829;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=2QHwNegqTYNEhFn3uRl/78zEGrvHKNKw3w3xL2Ook/c=;
 b=Pks2u9Z6IQoFSXXuxAMR2kWbiH2CVkuxan/bt5gOYtoKwbVPdPTqcPd7Db6aCiLYcz6sBgyBj
 dIdMvJrBJU6Bk44xHVlWrWgmrg4D9vtFcEjwMRknXM6QoKP5VjLmNt7
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.88]
X-Authority-Analysis: v=2.4 cv=Se9i5fRu c=1 sm=1 tr=0 ts=6aa8fbf4 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=YP7Kpn5otooA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=nOyVeRINTYQrkHNToBwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: St5zqxhleYfyVmPltJRh32UECYD8dWsx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDExNSBTYWx0ZWRfX8ja8LId8KMtc
 hInrUTmiZttSd+uvfhngLqQ2VKHhwn66NbmX6szqdZF0Ml3yvLde5+thHiAtCIepq+Q/f5sJDgJ
 ndEsWgsPdOOonQya4fZ/hLO5datln6XDKGKRjnoHTceVwTW1HeuaWLoyGMvCTloScKsGCF66+2f
 UkHAR1vznuSaZjyblpnWUkqN3WSDwsWsND2ZFQrIxbD4TLQkd6TJtm5AKf+vPLErujWr4W4lbqu
 ROBt6z1ww5/wi/rqryKjx0bvdl4EyDqRlsIvGpB9lT2BU0dHNEaf9+HPZpEnJ97j8OUq3Ma/jWj
 OC5epk5MmxzUJ9bLEB115KrDJJpQN8Dw3JPwaMQ6RV38Wjk5z1ONTMSlQwz3f4mRBdjXoFixZsK
 zU71OitFGj3AVJKqN64J6y/Yf8Aj69IeN6IhDHezP1JB7hd3KEw4zGfulh0OGT8uUDt4yQd8oaz
 ppQusQeLSwxlW/OWzFA==
X-Proofpoint-GUID: St5zqxhleYfyVmPltJRh32UECYD8dWsx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDExNSBTYWx0ZWRfX7jWjAZmf9QT7
 ADjaoYawS0sqcRk0MZHVIEmMyvRR+1+OX3gyCU6VLr6ELpUbTfII34VdYA/kucNfNoUNsC3dlXY
 Z+wn5UcSPj09bE8ZxB3UrIm/0m+S68A=
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

Series contains cleanup commits targeted to FW interface.
    - Firmware connection ctl moved in the same place as the other
      firmware ctl structures.
    - Remove unnecessary structure mapping.

Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Alessio Belle (2):
      drm/imagination: Treat FW connection ctl like other interface structures
      drm/imagination: Don't map FW interface structures unnecessarily

 drivers/gpu/drm/imagination/pvr_fw.c | 130 ++++++++++++++++++++---------------
 drivers/gpu/drm/imagination/pvr_fw.h |  18 ++---
 2 files changed, 80 insertions(+), 68 deletions(-)
---
base-commit: bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb
change-id: 20260914-b4-do-not-map-if-structs-unnecessarily-de8868bd58d9

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

