Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4395D606D81F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=MC4f5n9s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62B3910EE12;
	Tue,  3 Nov 2026 01:15:01 +0000 (UTC)
Received: from mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 257A010E75F
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 01:14:54 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=PyNL8gjp2rq2sflEJRFFy9EFUqOqYvXNTkbF/sF6yYo=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793668493; v=1; x=1794273293;
 b=MC4f5n9sJZ6mm6oZD+v/UCG/sSCrKLL6V+5YnIUYPvaU+YORHCpptHP1ktcWwKwm5aMHfk6x
 6VrCnF/bUiMJ1UqEO4j9hiHmpBxvaVyCan4Q01+wRvMObAd7JkCgAutCn/lzxaZcsayH54XUyBP
 MDcj3H0cbiolN+bG/QuzG8moLObRtgsaiShoNJlLxFx+rzwmRZ7YTVwY28Pw2kLjF+Ktoe+kUxh
 4TjQ33iPfScT9lsjwGL5LUJYIuWs1aRRoQf5ZxpB9ntys/xCyiburCj4WTZGBOMTF4JEIjDoV2Z
 fC2FwKuy2id8WHIVDOAMnEiAKEzN2FU0bl9EJ8aQeBZLg==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id b8699ddd40b28f71;
 Tue, 03 Nov 2026 01:14:52 +0000
X-Mizu-Trace-ID: b8699ddd40b28f71
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Val Packett <val@packett.cool>, Maximilian Luz <luzmaximilian@gmail.com>,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/msm/a6xx: Add GMU_SP_RF_CONTROL registers
Date: Mon,  2 Nov 2026 22:13:52 -0300
Message-ID: <20261103011358.65398-4-val@packett.cool>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103011358.65398-1-val@packett.cool>
References: <20261103011358.65398-1-val@packett.cool>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These registers are used in the a680 hwcg init sequence downstream.
Add them to the XML register list in preparation for importing said
sequence.

Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
index 786fd7d2f674..11d57cb52ede 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
@@ -42,6 +42,8 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 
 	<reg32 offset="0x1a880" name="GPU_GMU_GX_SPTPRAC_CLOCK_CONTROL"/>
 	<reg32 offset="0x1a881" name="GMU_GX_SPTPRAC_POWER_CONTROL"/>
+	<reg32 offset="0x1a883" name="GMU_GX_GMU_SP_RF_CONTROL_0"/>
+	<reg32 offset="0x1a884" name="GMU_GX_GMU_SP_RF_CONTROL_1"/>
 	<reg32 offset="0x1b400" name="GMU_CM3_ITCM_START"/>
 	<reg32 offset="0x1c400" name="GMU_CM3_DTCM_START"/>
 	<reg32 offset="0x1cbf0" name="GMU_NMI_CONTROL_STATUS"/>
-- 
2.56.0

