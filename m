Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D61606A333
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=iWHR2nAJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4512710F1D5;
	Mon,  9 Nov 2026 11:45:29 +0000 (UTC)
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA99810F1CE;
 Mon,  9 Nov 2026 11:45:22 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.12/8.18.1.12) with ESMTP id
 6A974jbA2011149; Mon, 9 Nov 2026 11:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=S
 +cihBqre+ip67XqiAlKJyMohumc16dEHAeqx65RHtE=; b=iWHR2nAJOq9xDQwOw
 QA4AKQRV6wrhAVHdawhl+FfBl4/0DJB+4zUgFpoxtRUheltitA9OT7v3KO2lHB2Y
 j0A6M/Sw3jNzlwLjiEqX9h2iGU7TyPHpcPUt+HLT7eIjNBgRTrom5TumOLVcrcqm
 S/kpH/uxqOYPsQ7l7u2HP0KfFImi1kX4+phlAINyu6U+EaUlEWj0UD45K2CzwHRo
 6Lx1tqZsB3jOm4Nt4DPlgW7elFxOx5lX7mjgpw1mBWdCk0pi9Do6XsZrhQDy8fpy
 3isFeEn2MPmqNWLF5sW/zzSXk8D6qkt1P0DDkRyK/pTwMMP0cd5NYYKc2bS9eCLh
 BmYEg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4hsvxx1g4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT
 key_exchange=secp384r1); Mon, 09 Nov 2026 11:45:15 +0000 (GMT)
Received: from [127.0.1.1] (172.25.5.26) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 11:45:13 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Mon, 9 Nov 2026 13:44:52 +0200
Subject: [PATCH v4 2/2] drm/imagination: Don't include MMU defines outside
 of MMU code
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261109-b4-include-mmu-defines-only-in-mmu-code-v4-2-20a857dcbbbb@imgtec.com>
References: <20261109-b4-include-mmu-defines-only-in-mmu-code-v4-0-20a857dcbbbb@imgtec.com>
In-Reply-To: <20261109-b4-include-mmu-defines-only-in-mmu-code-v4-0-20a857dcbbbb@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794224711; l=763;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=HmdOHqEPUHo6/L27pUBhfUrm7QwsiA795cywkd2hZz0=;
 b=8BP1Wy2KV0dwR+E4WPMuo52g4DzHQ8PpZoxyiSlVYFnhSxEh0jA1MmI3pvwhbCzrBbrNZECmj
 RwPQgy9PiQ2CdUEaXWvIBscJpDodUGM3n6owXGku35N7ouUbwJrnxCt
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA0NiBTYWx0ZWRfX06p49ul9MMVL
 p/w0AwEjzvgvqSoR+DjEOz0RDCyAV8VDuQB2r8Bh+xrQBXIRkKmcOafibrjefgGqlEXefzoIDZc
 w6y6humubHFmBdtVKaATP2zPlCS3hO8=
X-Proofpoint-ORIG-GUID: cy240uhJM4f0qw3cXg0OOPQiMT-fLWk4
X-Authority-Analysis: v=2.4 cv=H+JOUOYi c=1 sm=1 tr=0 ts=6af1b24b cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=h_3jC4m0AyQA:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=pGLkceISAAAA:8 a=jECmF5wTsQ93kalXHlwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA0NiBTYWx0ZWRfXz9ZMYwCg5Isw
 qA1BNjAp4R10hH4JB827JbXxUpud/vptOiWuHU+i+cT7jDCkvjDmtCXy1j4gNNeBk4nvMxgUC6V
 B+VbYIxFXuzmeADV7PIbBb0gVS1axxw6AIZ8pQ+1Hn19mZ39l7doh8GcnMPI5s5nzAioAtLt0G3
 s6D9QdebPf36AbMn44LDstZWLajUUjC2A4soCkPpufCzIJrqFGx0EpLkFyBygUDYzgq3upxS1oi
 s9yBPVq4g3iZzK45LJhLX/EMWZkok+uNAtDoTiWLkF259WtKVaPmMUh8ucMcr8QdoBRdqt0bxXC
 fbIsLToP9ftcpoGM4B5070vM1Wit9ztawIEWs++E1ZKrAUyT49Bpd27pDUmIWUZqa89+Gy8ASxb
 ttBjzjgxLW9dAFAAR/DFgvEActbKAJA/3Pg5effb7fW79HZlCsi/jW2XBsxicdDjk7rgXjjHq2E
 vMT9BFKnfzJsJZp5nfw==
X-Proofpoint-GUID: cy240uhJM4f0qw3cXg0OOPQiMT-fLWk4
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

From: Alessio Belle <alessio.belle@imgtec.com>

Usage of Rogue MMU defines is already confined within pvr_mmu.c.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
Reviewed-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
Reviewed-by: Gyeyoung Baek <gye976@gmail.com>
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

