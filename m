Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7BC606A33E
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ImQUjrQW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0772510F0F7;
	Mon, 26 Oct 2026 19:17:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A991410E38A;
 Mon, 26 Oct 2026 19:17:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 740A3444EC;
 Mon, 26 Oct 2026 19:17:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793042238;
 b=JTRLRJIk7z2fCldhJD4Uogypc9O1KXNKtw4iCHe7ueUZ1V2w8XU9A0J/103In5lpDZEy
 OOZL/U9IbrYYO8Tdz5SqmOyJdLGZFV6O6RmoMWAMPSAw+oDr3j9PcnBEm26DSH1CZP2MU
 KWI4O2wNEFppWAvkr3NclhTCkdFDcN+mfuLssx58nilg9nYPRpbHBFVG0Y/RBN8x99g8B
 rIrA9vVJiTDr9jxLpJRoNhNHBn5Eyyapo7PySFArojssGdvdiu/YZXMFPMsLaHraGc++O
 +zrgsMgq97Zw+QBU+qwG97yAbCa9ynLnkVx6rKeQBFoLF9El8rgtpIOAOPKbwYtSwVQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793042238;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=imHYWeksaXBeFcKIQhEzRRVpKwqiW8IhQO4lvWkfRAQ=;
 b=S0Ptqa1fu8k+j94Fp6USwXt3U11wUFAsM+bXrLZSmp803jTyjfPoRTZbCHIODZd9HWpf
 f7Cs9sicJH6JqVeKwlTh5CXWnruI9jm+M5Jn+8xQJpd1t5hoQR7rQxXjkfS1UN791d0lT
 XYJS6zbQowDF5Vz80VbUKEYkbqspBQ+UqMGZPlpw0INtgEgMiyKjykpNbt6QGE+z+Vr2c
 vo6dKKkSTUZKvBJLXAB/VwUximuXGICzat67dKG6W6zZUfnmmHHNnCd50jzZc9hXgkfQR
 ZXG+ANwd7atjyFVcWlXRSAp5qU2LiOfo+ASJaEXZlQJS/Ps71qLh2g5xZqbJg8qRXYw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 473EB1F031E5;
 Mon, 26 Oct 2026 19:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793042238;
 bh=imHYWeksaXBeFcKIQhEzRRVpKwqiW8IhQO4lvWkfRAQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ImQUjrQWIT5yxySQ9F6i4rgRybDcEGn+Yf2njEH846y1rZ+b0EBPY0t/rwD5qABct
 BLLoaE7K5zYNvG1k3bYNLdcyuCDRjDeZJM9GdVZfVGsLU1pGoJDq6a2dG+P1rB1QCN
 l4b0jIAJV3kDD3Ic8vUj+g2GMSToy6I/+3UbYH/4bTCg0WPye1DRe9B3PPLiM9yrnP
 ub+4K51q6rd6yflZN/SMCgVYfq43w2zzGPH0ymYbqGKw9H5fO+5oaAjXbZv8C3cc4Y
 uQaHRmZT9S146LwimJ998iLamfxsRkB327tQxVjgK78voOi8Ke0HhZAetGr6y49Ty/
 F6QV6yBK+xvhA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C503744E50;
 Mon, 26 Oct 2026 19:17:16 +0000 (UTC)
From: Xi Zhang via B4 Relay <devnull+xz.ca.cn.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 16:16:52 -0300
Subject: [PATCH 4/8] drm/msm/dpu: Match setup_dither cleanup to the way it
 was set up
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-msm-dpu-res-clean-v1-4-f46130a8a717@gmail.com>
References: <20261026-msm-dpu-res-clean-v1-0-f46130a8a717@gmail.com>
In-Reply-To: <20261026-msm-dpu-res-clean-v1-0-f46130a8a717@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793042236; l=1544;
 i=xz.ca.cn@gmail.com; s=20261026; h=from:subject:message-id;
 bh=1MTlWjU8pVgLZ2rHuiYomfqUUR1f16R7qSP8TFUAGH4=;
 b=c2qs/hJFZZl9PaH5Ju7lHaFTIqtDMA0PCv6Gctd3IRZemFZK4sX92/W2tsMZk59NdnPHi5pVs
 zNe817nnNZcCqzQrJo5bvdiv2SU7B6zFb6i/PI83h0WQ3BPW6ccAiBz
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
index 0ab151369c99..7d092398fc99 100644
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
@@ -2303,8 +2303,10 @@ void dpu_encoder_helper_phys_cleanup(struct dpu_encoder_phys *phys_enc)
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


