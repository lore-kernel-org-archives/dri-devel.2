Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92541606A33B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=etvDY/LC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43BB910F28B;
	Tue, 27 Oct 2026 07:14:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B418010E03A;
 Tue, 27 Oct 2026 07:14:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B56540065;
 Tue, 27 Oct 2026 07:14:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793085283;
 b=ZpBv6/cvPdHKVoCm77XJAdiesrhEMCZUQ13eRZ4Uygm+VhsQzvSJyDerSuonjf41V33n
 CqwDip2A3q289deLxa5JvEi1zbPYqwSAt7oTjNpQL56P1sA8br/VNvgoheR+/4FXBJeny
 lx1dbYWJXozB5/DQOXapsIiFx+1u+NS5K3JgcqV+d9+jFnqBgcIAXesl1KuM5r3zO/9MA
 kvfz/uXqn8LM0VuHqjG2PnGa9bjmRhZAAmsNfJZP4yMnNR22uzPDR7M1mY81IZxKXbD/S
 YKFu5H8A5VUf59f2vaHFp5SPqy7uo8l8xPOHczZmPG0bTf+6muaz5G+OtIqrZCcc2ZA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793085283;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=IeXaEIo0pAGnp8fs4VLNab68hQRjd+l9K399DfqFryk=;
 b=nVCbHtFC0fIebGLF1kG64UgzumEAubiLrryPV8R7nbIU5e51tuvnkTqglEjG7wY8NgO9
 WX+UCx7EkI/7RnIkzk+h+LAm5oONRABwqOKOc/BHuxU7b5uCzFWa+dluvRNkBFTgMR9ns
 s5M0paSu0dDZf8qXxN0f2dcb69yh61TPpAuTLAwmg9XyBnKVMwiVqkJF7qqA8B3K3pqNp
 lSwOyD9sqg+Air7ebjKFy8jKwT8qRnJZzECNJbjbJCqkQ/hSDGiKLUulWuXlfIF6XZkXZ
 HgFtNlwQjkeQYJ/FWiICyZ/Y1skXTX91/C5qfIiqDMtJFnahppcdrAd1HGgvyiJ6f4w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 959A01F031E0;
 Tue, 27 Oct 2026 07:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793085283;
 bh=IeXaEIo0pAGnp8fs4VLNab68hQRjd+l9K399DfqFryk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=etvDY/LC8qMmGy6vtWgheDAr8RPZ0AMBj0r0ARxDHTXwUbr4Ebcdg0AVWNe3WIR3D
 urbqh1aXEFOassHNG+rXA9ukpNfv66ZpzpI/hKbdnUfKUuT1wOslk2olq0nJoc5nAl
 csXNHDiKR8qcDgAyzzzlQcHoOUIbbOwsan30QuJGsNpymHw7lV0rzcJ0o66UmyD3aF
 RsE8LvBL7B4euNZM+1+G12WQbv0iTF8KHr5+/eJYv2atairQVfmceq1UQxdQxn73mu
 QWZeP3K7witxY/J2PgdQZ4If02j3dy2mE4eXytHPYULepCrdEHfSwOr50OaPTAG/SH
 yYVJF6xqyMjkQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2A4D945014;
 Tue, 27 Oct 2026 07:14:42 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Tue, 27 Oct 2026 12:44:36 +0530
Subject: [PATCH v4 3/5] drm/msm/a6xx: Factor out the common BCM list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-adreno-a620-v4-3-b0095e028c76@brar.si>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793085280; l=1585;
 i=patches@brar.si; h=from:subject:message-id;
 bh=XKW/3wqWkpV9U6TbTOCzER6M6DepQLoeu6Dsp0lQK/c=;
 b=UATGICwhaM+VynziqpGJXd7w/6gymuJoI6jp2/3+UMP9DFSIfAiz80ay6Wy1Qlgpb/S5LeJOc
 sgWf6JVakHeD6+ctr/tIPPG2fAZgpb7QaCrsG90mBchin3J3sgsJmnV
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

The A690 entry carries a list of the Bus Clock Managers it votes for
(SH0, MC0 and ACV) which is the same for other A6xx GPUs. Move it to a
shared array so that more entries can refer to it instead of repeating
it.

No functional change.

Signed-off-by: Ishu Brar <patches@brar.si>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 4ef2bd6e7ad2..c4d332f48f6f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -736,6 +736,17 @@ static const struct adreno_reglist a702_hwcg[] = {
 	{}
 };
 
+static const struct a6xx_bcm a6xx_bcms[] = {
+	{ .name = "SH0", .buswidth = 16 },
+	{ .name = "MC0", .buswidth = 4 },
+	{
+		.name = "ACV",
+		.fixed = true,
+		.perfmode = BIT(3),
+	},
+	{ /* sentinel */ },
+};
+
 static const struct adreno_info a6xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
@@ -985,16 +996,7 @@ static const struct adreno_info a6xx_gpus[] = {
 			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020200,
 			.prim_fifo_threshold = 0x00010000,
-			.bcms = (const struct a6xx_bcm[]) {
-				{ .name = "SH0", .buswidth = 16 },
-				{ .name = "MC0", .buswidth = 4 },
-				{
-					.name = "ACV",
-					.fixed = true,
-					.perfmode = BIT(3),
-				},
-				{ /* sentinel */ },
-			},
+			.bcms = a6xx_bcms,
 		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },

-- 
2.56.0


