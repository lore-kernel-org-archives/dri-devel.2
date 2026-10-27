Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E1606A339
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4athBve
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F0410F278;
	Tue, 27 Oct 2026 07:14:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D8A10E370;
 Tue, 27 Oct 2026 07:14:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E9CC344037;
 Tue, 27 Oct 2026 07:14:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793085283;
 b=eiDAg0zO9DAIrxFMl9BgCi06iv73JhTlCHSmLxTOSyi7/q3TwYR+F8eNHMBREHsoMuOR
 JD8mXy7UIUgHu+r5wnHJqx8NthDoAo9Qg/3TH17pxMLPSdv/MuU7Lys0FBbiRpovS/NSn
 QEOYGyWnbfsATpb/CxLMpDy+mKcWhwIUnfN2553QcjLHCfrCnJ2Zk6oys/0Pz5M8m9oL8
 olJgxW4YEyNDp+n+QbwIh6Ml3HT8Am/WpqCK12wWZpn14eRRc21NOCHgyyTxJGUoG6JUh
 T/M2v1RUR6MiyhXhaT519tP2MGwCRgPdo1LREtV9PPW4t5iT2IqUFFs2T+s/CXgmKFQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793085283;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=QEOkViwPvA+ovkRTT/O+7cSGGL37fIKYHlGUm9vQRrQ=;
 b=vEdKmTY3l/QPtMN9Tc+Ajk91u6TZUGGGg/b52HC20qAYtEJE0M/lP1ydVJR2jK++1ycT
 ZY6TvKlNg8e0zsLtcPFkPyXNB0PVSUw4u48KucKfpeh3aiDIknmJ852Lh+RxRlSAh755h
 7g9VXqgdgj5/a13OmZd4ocP5oPNqSTpF6GgagXnrcg01cM/YyaEJvk63ARz5dayB5R2uH
 CQ1FpzL65FbBt7WadGCgtDEQNcsqRCEyvXp43Ll2yRr7wUux3eFo8Y6RYodyhujQJcTdJ
 Iudb4HjHB4EOG1GAeYW8CZEKT3ccs/UIR50/djPAaYNAOEAYi9gHVN22qrrTL4RwNfA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 9F3311F031E1;
 Tue, 27 Oct 2026 07:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793085283;
 bh=QEOkViwPvA+ovkRTT/O+7cSGGL37fIKYHlGUm9vQRrQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=l4athBveir4fPeSUZnyBiCTRrGGf+aZCol1IQznLES2Jb5KsNxrVXlCIyVoHcdYho
 V+zlNgQZGwjhachlERr3gl3Z8SHuOYjYHIBSV8KtwOWHM5qOfMtvfFFa6C90EwDHpM
 Cbig8sVK6dJ7Uy0DJD1mPKRKJS1WDUtRWxWqHtFDykPuuo+HsgCmVp4d2OIiq7EzYs
 ZwALa105FN2CKF1W9h8hvWBZwEtOxOIfiQ2UrxTqaEKXI50Uo35zHphf6xMTAQx10d
 piCHtA2VwNEaxLYNM8R94otVHU7dBPAWc8tbEwvZSlcsOQ6AO+TFmuUvAV7N++MQLM
 F2vUaU/KTPVIg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 33F8045018;
 Tue, 27 Oct 2026 07:14:42 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Tue, 27 Oct 2026 12:44:37 +0530
Subject: [PATCH v4 4/5] drm/msm/adreno: Add Adreno 620
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-adreno-a620-v4-4-b0095e028c76@brar.si>
References: <20261027-adreno-a620-v4-0-b0095e028c76@brar.si>
In-Reply-To: <20261027-adreno-a620-v4-0-b0095e028c76@brar.si>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793085280; l=1990;
 i=patches@brar.si; h=from:subject:message-id;
 bh=75tuVdfu66JoRRPxrf3B1Fh+ea+aX99Qpqxz70g0Nuw=;
 b=jjb6PgPudbzoq870ERCEhEKcDebLaVZ+wVHcWIiWdt+lvQnduiwga36o4RhYdClF+7y2gnG4h
 VgSEfOQAxoTCJrRoKRqZqwWCkuhdxpIKLC0hqjXdJCGGH3+p8byxOgn
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
Content-Transfer-Encoding: 7bit
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
Reply-To: patches@brar.si
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ishu Brar <patches@brar.si>

Add the catalog entry for the Adreno 620 (chip id 0x06020000) found in
the Snapdragon 765/765G/768G (SM7250). It is an A650 derivative and
uses its SQE and GMU firmware and protect table, together with the A620
zap shader.

The speed-bin fuse values map to the OPP bins as in the downstream
"lito" devicetree: fuse 0 is the default bin and fuse 132 and 115 are
the two alternate ones.

The GMU clock gating mode is 0x00020202, which is what the downstream
driver programs on every A6xx except the A612 and A615 family. Use the
shared list of Bus Clock Managers so that the GMU bandwidth table is
generated from the bandwidth levels of the GPU OPP table.

Signed-off-by: Ishu Brar <patches@brar.si>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index c4d332f48f6f..6cdc3f5a2583 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -954,6 +954,32 @@ static const struct adreno_info a6xx_gpus[] = {
 			{ 169, 2 },
 			{ 180, 1 },
 		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x06020000),
+		.family = ADRENO_6XX_GEN3,
+		.fw = {
+			[ADRENO_FW_SQE] = "a650_sqe.fw",
+			[ADRENO_FW_GMU] = "a650_gmu.bin",
+		},
+		.gmem = SZ_512K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			  ADRENO_QUIRK_HAS_HW_APRIV,
+		.funcs = &a6xx_gpu_funcs,
+		.zapfw = "a620_zap.mbn",
+		.a6xx = &(const struct a6xx_info) {
+			.hwcg = a620_hwcg,
+			.protect = &a650_protect,
+			.gbif_cx = a640_gbif,
+			.gmu_cgc_mode = 0x00020202,
+			.prim_fifo_threshold = 0x00010000,
+			.bcms = a6xx_bcms,
+		},
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 132, 1 },
+			{ 115, 3 },
+		),
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x06020100),
 		.family = ADRENO_6XX_GEN3,

-- 
2.56.0


