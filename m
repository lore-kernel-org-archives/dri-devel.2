Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D9CBCA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4794D10F31F;
	Wed, 30 Sep 2026 11:44:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="quGJGZRd";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450AB10F31E;
 Wed, 30 Sep 2026 11:44:12 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB8rAK3264227; Wed, 30 Sep 2026 12:43:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=C
 y8n4XuuIghEBpMqyBtRMtfdIVXhDq5hh3HMWVUuAAw=; b=quGJGZRdBPJyGZkSI
 gD2BSck7E+Pg3eAo9gDbbLwDQQK56kBwaINfkfkgZrzj8Im3X5OSlkUbHgQ9RzyL
 JC7Y042nk0Tzi0fJfhiTECkMEC7+GTib01Yym31iNADnOnqKv9mmH01RIa0Ky8pf
 budSUfXRJUKvG2YdiUjGshX1+ZdjwdpifG2D9EG5NTP2KEl1a27g+R2IwyKTk9Kk
 hCJATz1IXaCNHWe1ePeqVEccglnOzJsdMJVvLMDaZERoTfbkCkWgOU+NIUzWZ6QZ
 wFgSs+mjC2j4W1RQQMX4mndIuYYZLmsJzlfqQgsaopjbLlHSfthej8JuRQKl5ve0
 aI4Ig==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4gx64t3h67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Sep 2026 12:43:58 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.18) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 12:43:56 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 30 Sep 2026 14:43:35 +0300
Subject: [PATCH 2/2] drm/imagination: Don't include MMU defines outside of
 MMU code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-2-291eadfde23b@imgtec.com>
References: <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-0-291eadfde23b@imgtec.com>
In-Reply-To: <20260930-b4-include-mmu-defines-only-in-mmu-code-v1-0-291eadfde23b@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790768633; l=661;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=lnnnIzrs8v1sTqKWnBmXP0wQ5buykuCp3eWFfVKChxs=;
 b=DmsP9nIrqdmbsuf89U4vYL3M7nSVTVYLJTfBD+vFkz9dcqvrcasph8NR8yjq4o1dMtOAu8Bor
 rQf2at41btdDI5Ruu1gcxboUoi4U2UEGXiSl6dtvmzzyPp2BPcymKlS
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.18]
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0NiBTYWx0ZWRfX373Bv3iNUGxQ
 MjTO8SMnLaZ1U4UkAfW7iH0mwwfhU6kLXoAg80uiEn9B09MQD5v66daAPoBjKezD+qmbidRPd9T
 imLGpEB84Ojd28nuguLTFTQfVn5/fPg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0NiBTYWx0ZWRfX+n0WVuNHMXsT
 VBIReteFONwCHglcJYvpdrBRkK9hpI7QcBvxOVG5trVQu7jIPhkmJ3dJHxXIa4pdx/IS/vLBEk4
 SVsV3o+wZOP25P79JdxXoFIsITPOCOeWI2vJLwGbUjYrhTNdf6ToD0A/KiruCl/E8r/mK0r7HjW
 NELvFQCOVs4GjEEtHiWc1vJrp11MfU39JRfi4aMpmcsPb/vrPBtp6GSzDEtTRxIt7DIIlC/Kh3+
 P+a+O683Bu7bi3T1OFJRO3wd9jwSwHU+0OyUHwURaudzLKxJ3fZUVuOBfFT4J1uSB3/bHXK6Lt8
 AKIVir1itaF427bB4dxHQ68xjKgTKworjoNQmat/UwUTvm0LhdMpqQdxHwKUZ11e4w91minL37x
 PaesyCql6AnOGF3JNBAAArPZbEZ0Yyw4gr6wvZyDgZCjY32WmopT3pm91EoVkBbAtUaDwglaPT/
 KP8sJBROXrZgbMdcq6g==
X-Proofpoint-GUID: HJWUXxVfPjyzHJkYsL9WP492M7ATWw3w
X-Proofpoint-ORIG-GUID: HJWUXxVfPjyzHJkYsL9WP492M7ATWw3w
X-Authority-Analysis: v=2.4 cv=OasNnRTY c=1 sm=1 tr=0 ts=6abcf5fe cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=sVS2Dey4ZWMA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=jECmF5wTsQ93kalXHlwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

