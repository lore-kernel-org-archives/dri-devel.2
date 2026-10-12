Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD54CA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:21:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C96810E614;
	Mon, 12 Oct 2026 10:21:31 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 031AE10EFA4;
 Mon, 12 Oct 2026 10:21:24 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8OoMX1468537; Mon, 12 Oct 2026 11:21:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=C
 y8n4XuuIghEBpMqyBtRMtfdIVXhDq5hh3HMWVUuAAw=; b=FHTMhYQ0tRIUv2y1Q
 FidR2vsGtNRArHRQxIlOzhtYJ72AWWx6bq9q4ISJm0xEOyijRgK11z8IjUApPhSV
 EW0KpoKAWxqPi3ZwggXKLGOHpL3DKG56R9yfB59OuOv31XUeA4RxEAxIX3IhzFHU
 1GUNmqXwv6rPZhBccYwc1+kNE/1iqZz4OAj3sDYSENVZt9LnThrPXGb7jKD1le2N
 dpvqlTdx1xoQ7O+lPly3+vTcZoDVYNTRYRLcB+WOZizwN5z6IwGlFQhBKAJ0oG6X
 LWuFosMELNg3L6yneT7F6wUr9Lo6XHCo3oMBh+gmN+ho9dUkSeXxWwxI2ekC5hju
 Kmd7g==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4h7bmp97jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2026 11:21:12 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 12 Oct
 2026 11:21:10 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 12 Oct 2026 13:20:58 +0300
Subject: [PATCH v2 2/2] drm/imagination: Don't include MMU defines outside
 of MMU code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261012-b4-include-mmu-defines-only-in-mmu-code-v2-2-8aec58777ab6@imgtec.com>
References: <20261012-b4-include-mmu-defines-only-in-mmu-code-v2-0-8aec58777ab6@imgtec.com>
In-Reply-To: <20261012-b4-include-mmu-defines-only-in-mmu-code-v2-0-8aec58777ab6@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791800468; l=661;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=lnnnIzrs8v1sTqKWnBmXP0wQ5buykuCp3eWFfVKChxs=;
 b=7/+M+R57VePg+x9X8/+o7635vBGf8mYiQUpUs7J7zxr1n7vzZEWn4uRQKwNuWeg+Yk4tkPq0U
 rWRjIwAre+iAOJHawdOz3VMh4M7h4qqfUYPQlY8gCBn7I/VDxaX8nwT
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0MSBTYWx0ZWRfX1oPuUEJRfQRm
 q080t0bpzbftv94ArXicdFRXe9XDd1i8FaUyzhUHvzXmj0xpI/6Pi7jGJu9L3Pc5rse1kPxO9Bz
 ReqclRlhXiY6Jm5DVM7CIIrEqca0enIDMJ9AlDGj16DrEtkSXHwutOzssBiiaaHNbFglCrZ9PGk
 KVg12Ft467zyWVWV6Qv1oxDSEMNH683PyhO8yeZB5Ad4iVR82E2nSYVSdIaLZLZ+zjw7eppP+L9
 PdzykObLC5VmT2VS1jc+3IiCvmRKs2xis+yWpC6h6byGpHkk+R8XpuIwnYlAA8L/J6x+b0Ro/6g
 mYoxfgZWoBUUs0MoROs5Ut5WbtWyWNusCdIq8gRY4imFECw15OKA32fcsyrEJxNJw4fCIS6/F9t
 WyNluIniM3cpyYShrMz0a2zLqPyhtzsn1UYr7tpXYAJRDKi9GLaTzagXURNV9zmdA+dwdrfIRz/
 Zt4b98dej/atYVVMXmw==
X-Proofpoint-GUID: zuusnF4pVnwEDsi5TIxKjzCX39RpcW5z
X-Authority-Analysis: v=2.4 cv=QpDLTlyd c=1 sm=1 tr=0 ts=6accb498 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=jECmF5wTsQ93kalXHlwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: zuusnF4pVnwEDsi5TIxKjzCX39RpcW5z
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0MSBTYWx0ZWRfX+a2AIwzi1Pje
 24Ldfwxail26IpIBLguCvfn0Cp5ZqHBvm9QAQ9+jD8B4eu7lvOzvFiRtOu8h79l+02IYBta+XC2
 /PvnH2o/x0Iu+lPM3uST2FJRcn7e8xk=
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

From: Alessio Belle <alessio.belle@imgtec.com>

Usage of Rogue MMU defines is already confined within pvr_mmu.c.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_vm.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_vm.h b/drivers/gpu/drm/imagination/pvr_vm.h
index b0528dffa7f1..266d39f5c444 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.h
+++ b/drivers/gpu/drm/imagination/pvr_vm.h
@@ -4,8 +4,6 @@
 #ifndef PVR_VM_H
 #define PVR_VM_H
 
-#include "pvr_rogue_mmu_defs.h"
-
 #include <uapi/drm/pvr_drm.h>
 
 #include <linux/types.h>

-- 
2.43.0

