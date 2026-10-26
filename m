Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF930606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djfriWTx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1873610F13F;
	Mon, 26 Oct 2026 20:26:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A0810F136;
 Mon, 26 Oct 2026 20:26:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3D1FB60416;
 Mon, 26 Oct 2026 20:26:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793046366;
 b=WsrRc44hwIMaqHSSHD+kSx0ZLapHL1uZonFR7jikkcVvOXKza8m5aUnzpBcdfgOWmKYG
 BY4le1TedPKJ0DaesKnIRKaNxDt7VDtwZChJO9s/npwbGUyR4tSlBt6AFVkFU9yvfAqrH
 nAhvi/bGwk0kEr2R9VY77rShd0zf8X5xJLjKq93UZn+nlljZYzsl5Vl3Qw+8/Ggy7h7ug
 2k9NEQZL30WHBVSwAF57gayIG2dillWz3kcBQlJy6gS29yhP4jh9xwyye3or2xqFdx2tf
 Bp7TyoKsDg7XXEqMo992UFD2XnVBhrSf044s49tttK967wX19Kx0+cNemKaJmfTBUkA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793046366;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=AMG9sxbvuyqKKrh9G6VfifX0j5tmi3Rlx9Q91YUxWY4=;
 b=wirWaOnRON1jdzvALReIGje44foR3JlozoN6T6cYOx1eXNfnQNiT5zedTVK2k9gtNvPP
 2yY0JSl/ElEFKHX7+QVXtqzstwCqHSBClXVo0LVcQ8bWGqUsS34y6lmpZbo3hHOjm8rge
 /wYIbTobU/84/rx7XxvkLHpLJrUWRQPpOgPQauBmsV+a7ll7ee+Oa7rFKajPL/2sC+icv
 ncN09S/eOSEqdevcl1nI/jsGaKrhoVNfllG4BUPk6ExdPxjIt3zBocGhZkpcBZZGZxieF
 WSHdFZmMQvApxDATkglF/Gpj0CHq/yc2NJC1SyPf7soUKgJ9QZyn1AJTNjRmkiABceA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 7A68C1F031E1;
 Mon, 26 Oct 2026 20:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793046366;
 bh=AMG9sxbvuyqKKrh9G6VfifX0j5tmi3Rlx9Q91YUxWY4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=djfriWTxMoZ8TW800FFm0gVo5f2xJ+RhnSmY3ORWREn7eXFqjuVo94zpTwJU8cW8b
 AEVASDyafXQnPB8Uh4ioMx9x51CgOu01OVxISe0fK+v8C8onBvgdD1Y9Z0+cCjdM29
 4iIagEAw21C+Tlrn9CmhSx2KSyMtaDUVXaaIVB+WtGK1W4vHlobfmNvI2Q81gwbmtl
 /VNtBURcXmRTcgwUPhAHCeOTYfZofqYo6RLUIyC3C38sMQfOKlP8zCz/nRlixQvEYO
 hu3kq0BKHgyimUBVOwdbe95yUXx5G5wi8fg7llR6QJ9flzJrZPEjfqnzUr334a683G
 8O8TPluS4DgtA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id F00F344E99;
 Mon, 26 Oct 2026 20:26:04 +0000 (UTC)
From: Xi Zhang via B4 Relay <devnull+xz.ca.cn.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 17:25:45 -0300
Subject: [PATCH v2 4/6] drm/msm/dpu: Match setup_dither cleanup to the way
 it was set up
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-msm-dpu-res-clean-v2-4-3d864435186e@gmail.com>
References: <20261026-msm-dpu-res-clean-v2-0-3d864435186e@gmail.com>
In-Reply-To: <20261026-msm-dpu-res-clean-v2-0-3d864435186e@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Xi Zhang <xz.ca.cn@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793046364; l=1544;
 i=xz.ca.cn@gmail.com; s=20261026; h=from:subject:message-id;
 bh=i8W21Uwim0c1+zeph5hx6bDBWdsis2GxB2oH6BEEkww=;
 b=euKQ8P4qZyAu2dx4tItsfmlM/IJot2mVulrG4mVSxuASX2xKy1XyWLOa7VkLDFzhCk8fR2qdD
 /MbwySbCj91Dkv0VseguSPHw0//cMrQ+k0rXv8jzl8mWfiN89+ytO69
X-Developer-Key: i=xz.ca.cn@gmail.com; a=ed25519;
 pk=aRUll5L3eJbwG8Y4BO9uySKGzm+Uy+Ccei9prnRVZRs=
X-Endpoint-Received: by B4 Relay for xz.ca.cn@gmail.com/20261026 with
 auth_id=1328
X-Original-From: Xi Zhang <xz.ca.cn@gmail.com>
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
Reply-To: xz.ca.cn@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Xi Zhang <xz.ca.cn@gmail.com>

Cleanup hw_pp->ops.setup_dither with NULL for all PINGPONGs,
matching the way it was setup during enable.

Signed-off-by: Xi Zhang <xz.ca.cn@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index d967deb34c77..acea64ebd24e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1320,7 +1320,7 @@ static void _dpu_encoder_virt_enable_helper(struct drm_encoder *drm_enc)
 	if (dpu_enc->disp_info.intf_type == INTF_DSI &&
 			!WARN_ON(dpu_enc->num_phys_encs == 0)) {
 		unsigned bpc = dpu_enc->connector->display_info.bpc;
-		for (i = 0; i < MAX_CHANNELS_PER_ENC; i++) {
+		for (i = 0; i < ARRAY_SIZE(dpu_enc->hw_pp); i++) {
 			if (!dpu_enc->hw_pp[i])
 				continue;
 			_dpu_encoder_setup_dither(dpu_enc->hw_pp[i], bpc);
@@ -2306,8 +2306,10 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
 		}
 	}
 
-	if (phys_enc->hw_pp && phys_enc->hw_pp->ops.setup_dither)
-		phys_enc->hw_pp->ops.setup_dither(phys_enc->hw_pp, NULL);
+	if (dpu_enc->disp_info.intf_type == INTF_DSI)
+		for (i = 0; i < ARRAY_SIZE(dpu_enc->hw_pp); i++)
+			if (dpu_enc->hw_pp[i] && dpu_enc->hw_pp[i]->ops.setup_dither)
+				dpu_enc->hw_pp[i]->ops.setup_dither(dpu_enc->hw_pp[i], NULL);
 
 	if (dpu_enc->cwb_mask)
 		dpu_encoder_helper_phys_setup_cwb(phys_enc, false);

-- 
2.55.0


