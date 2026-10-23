Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C86B606A331
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOP3W1+X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8111510E5D3;
	Fri, 23 Oct 2026 08:49:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D3D10E5CD;
 Fri, 23 Oct 2026 08:49:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5AD4B60A90;
 Fri, 23 Oct 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792745344;
 b=OJG96vslcaSapPFMWpTNRnHGO8ozHQLeSZQZcR0lsPkFU24qhY64LEUUAu0cQZ0Nfi0t
 dmA6T3p2e1Yy2GdDAuWcNUAxJs2XMOL/Ezjz6z65XLmoCV5iBLx7qUX7OnhfK8zlO8Uns
 NRuLWJOihitwva7n0cVHTFbVf/4mM82p+M0G9E9lpu38ZgH5eyPJOuA+zcuUJVrpEqmYr
 z/DmuZY5mhydbQgTdsEtTxBdp55DgPib+xFNq2IwIyFvzuZZRhwxFQeSVBUqsY7R/35Ug
 5adrjqHCmjcKnmhnox+HFkzlwlFHRj/6fsAj4GrPEXkvlh6kfX+ecGyXOdQoBQNIYyw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792745344;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=VC9nYWlngLoo0ikksJdWqMZri11D3jtQull+TR9q83U=;
 b=UuQAYlS5Ky75kAWpbFyyTt1wuctTPrgFQ1WN1E+cmECVhp7NTL9C1O/bizo3bRRrp/A8
 U0XyatAJbpPDw4Vtn+7R7WIHpXOG6aW4HUpV5aqCi3Cahz13Uw2dKK2CcBu1jhvR1TLNO
 F1h04cBP26nxHNksILIme9AmF652pqXarZQyUdZp0+/indeBrwe3pAPm65uJpWe4vX67v
 W5X6JIuVyP0PnFY7q5we0o9k0CRZ2XaPDAPopEtZM9zafHeL4ZN43X2nVb5ebbt3dmX10
 3tg91XeaFJSgaTKXBv2jEdDuAfo09NtvQRvf+psfjAWmCFCwJjbu+G9h1WtYhsIl3Hg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id F2ACC1F031E1;
 Fri, 23 Oct 2026 08:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792745344;
 bh=VC9nYWlngLoo0ikksJdWqMZri11D3jtQull+TR9q83U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=bOP3W1+XtnZULebPv1WwtFfZ6Yc2QQ9zHsdnxF85OnAK6ivTSPKojZ4zbPfzuVAkx
 0bKqaf4N9bER+deu8V1pMUW+xoCI4N4iVvqZKDSAsGutYquWtSVB74PLkzKo6Pj3Dv
 h6eQERK7mhiMhgttEhMHU0pB7V5PUSOCRrT4YNVuJYz8AzF5Mgl4Kx82Y+KVY+bYGZ
 KkW8qk/RU13lzC/27FqtR+hDW4efYto9P3J8TMdGWfEGWsGZK4o3nv7ImYAxvGzuq0
 ouBztNBYxhf4boaAongYUPdEFaAaKrIzFgf4mgvSiEIbPMbiC2XZscQVhX6/zNSvtn
 M8LE41GvKCfww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 8313F44445;
 Fri, 23 Oct 2026 08:49:02 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 23 Oct 2026 14:19:02 +0530
Subject: [PATCH v2 4/4] drm/msm/adreno: Add Adreno 620
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-adreno-a620-v2-4-1d654c3f52d5@brar.si>
References: <20261023-adreno-a620-v2-0-1d654c3f52d5@brar.si>
In-Reply-To: <20261023-adreno-a620-v2-0-1d654c3f52d5@brar.si>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792745340; l=2351;
 i=patches@brar.si; h=from:subject:message-id;
 bh=tU61s/7XnImqnoXanHZtlX9L/8bbUJ87V/QXf+2mrqI=;
 b=OG6UaA9YwE3jmVOZ0IRBLIxk82gnLtPxhTtMjMEkVUhl1vSTVzrmwhVpXvvAMrBh2xa1Wwae1
 XDeSEWgm/KKBtxQn9doZl9UHBq9NAeGvqTYqEgHU/fsinYx/+kRMyH8
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
driver programs on every A6xx except the A612 and A615 family. List the
SH0/MC0/ACV bus clock managers like the other A6xx and A7xx parts do, so
the bandwidth table is generated from the OPP table once it carries
bandwidth votes; until then the table added earlier in this series is
used. The bus widths are the ones the other parts use.

Signed-off-by: Ishu Brar <patches@brar.si>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 4ef2bd6e7..bea11ba6c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -943,6 +943,41 @@ static const struct adreno_info a6xx_gpus[] = {
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
+			.bcms = (const struct a6xx_bcm[]) {
+				{ .name = "SH0", .buswidth = 16 },
+				{ .name = "MC0", .buswidth = 4 },
+				{
+					.name = "ACV",
+					.fixed = true,
+					.perfmode = BIT(3),
+				},
+				{ /* sentinel */ },
+			},
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


