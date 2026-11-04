Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CF5606A32D
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imgtec.com header.i=@imgtec.com header.a=rsa-sha256 header.s=dk201812 header.b=FLLAmSbF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1177010E845;
	Wed,  4 Nov 2026 11:24:47 +0000 (UTC)
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A588610FCD9;
 Wed,  4 Nov 2026 11:24:40 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4B7sdC2268075; Wed, 4 Nov 2026 11:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=C
 y8n4XuuIghEBpMqyBtRMtfdIVXhDq5hh3HMWVUuAAw=; b=FLLAmSbFsshjO+w9b
 vkmPt7wnyRuGZpaMTqUnRvkQJE3R7yvutqJQwvjCLjkTeG2mSCFVG6V+XQ59VJHj
 1RuyLaKA+uJKOw2UlRG6W9xy8CDELX7h+yer/dKVhLaFMIXMg5QCnwo2OkR3d6WL
 gAmYS+B09+z6isxGhcFgbnTGuK66ZmJA65nrgN9kc36dTt5C5P/fVDgiz9tcHwKf
 12nv2TMBsT8S3/RA7jDVCxijmg8b5FpQxCWAASJhuYQG+wdrCr/no0mISZ4d1seW
 Ch0Eb44a4GSeWpxP90crqXmGZ0Jgy1kr+VbyZcGt+m7kU+eoiYeCws+rc40Yfv6C
 zai1A==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4hr3j6r0e5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Nov 2026 11:24:33 +0000 (GMT)
Received: from [127.0.1.1] (172.25.10.190) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 4 Nov
 2026 11:24:32 +0000
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 4 Nov 2026 13:24:06 +0200
Subject: [PATCH v3 2/2] drm/imagination: Don't include MMU defines outside
 of MMU code
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-b4-include-mmu-defines-only-in-mmu-code-v3-2-f9925419b8bc@imgtec.com>
References: <20261104-b4-include-mmu-defines-only-in-mmu-code-v3-0-f9925419b8bc@imgtec.com>
In-Reply-To: <20261104-b4-include-mmu-defines-only-in-mmu-code-v3-0-f9925419b8bc@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793791470; l=661;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=lnnnIzrs8v1sTqKWnBmXP0wQ5buykuCp3eWFfVKChxs=;
 b=maNgxK4HjxuN3JQI/zUt7iz4jxstRMB4FLiRi52oYCfVe6hhnZ7gPYLzCXd36MDGld4j48iqh
 C7AQthwGbm4ADv0gSWEwulfToHBnAGS42EMJK02g2bwGf0YcBKQqE+r
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Proofpoint-GUID: kfcBWbp05Iha1ujfh8xI7hznedRYVHyx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA0NSBTYWx0ZWRfX6HajDSmrvVfI
 XWtP445MlaTJJko1WFQRSc9/eNluzYRezoj4MQkDK8Gh7nJ3+Z3//h8PYtfqpmzQA0Cp28aqX8H
 T/fbQAfV264906qGdA+xNT7m1mM7km0=
X-Proofpoint-ORIG-GUID: kfcBWbp05Iha1ujfh8xI7hznedRYVHyx
X-Authority-Analysis: v=2.4 cv=DtnDa2/+ c=1 sm=1 tr=0 ts=6aeb15f1 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=Y9E4qlbPYa4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=jECmF5wTsQ93kalXHlwA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA0NSBTYWx0ZWRfXzwAWXAbMLcOg
 QdjoDeugoUMRdNaD0mKDtQpJoelwIrXssPJS1W7z9OPRioGyZXA475TOR3QsBcyIfCHRWXn1UF3
 eTtMgf9C1hiBq/SecczMSlgSk3CoeGxdSNKAsUiIzFiyJHWiO8KndY9zfP/zVBCMKVx3ASdLSFh
 CY/b3PBcWiIDpxFFuCQvR21d3sSFulZn1V0nPfVjcFs9vEHKKymEowlk9nvr6XxpPOOTiEcitd6
 a4attEg6NmjqF8baDncaRsQGTQE8yy0OUnFvG7ZsW2AKk+wi6wsnfXzoqDaCXun/X16pmyPCJdU
 KSbC/myH5yhu9tA2ocFD9xPIalhHPZ8fG96kVvwzv8bTYALC1FL7uJm5ks7ChIoEV57Gz+xLfU/
 XOeJCUfk272WvDjs6v6R1Ryf7i1mG00/ZDIuW+AOJte4XHzNlb3QaMBhspQ1SzXXtelkhslsWCq
 N7e0ycdrIT6P0t6Ay/A==
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

