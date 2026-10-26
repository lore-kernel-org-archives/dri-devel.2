Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498DE606A326
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F4n0CBhU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2BDB10F0F1;
	Mon, 26 Oct 2026 19:17:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD2810E429;
 Mon, 26 Oct 2026 19:17:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 19CC660A96;
 Mon, 26 Oct 2026 19:17:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793042239;
 b=zhEj0wSvD9+j6a/pz7Z5qCOUV2rejkNv61mJMheqvcN/+Bmp+j4eVpGeCDT7ttOZ8XoS
 mW8DTpvtpHX+jXBxjP2YpzZzYkzDpUzr5bUfCjHu9lbXykOG5b96keOe6DPGowbebUuHB
 yvIO2GTBABJYWpF3gEa3OLuYIk4NvzWaI++V2WSevitL3r9x+idT3dFgCjMKqJXT0QUTx
 rVvR2hGNnagIkxfoKAsGvVUNJrYXEUH0hQR+BkYd1jWF2lWQdpGSwjq18y+kD9SiRgdqN
 52c/8dNVNAby8GsVqoxM2OIh/0wlHY8rtxrqu+sDtyUjZM/ETPaDYyvqFs6/trLhTdQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793042239;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=m6JQuiiAvAgYD5P15vse2J1auiyKgGQSXV7w3Qubaxs=;
 b=Yf7SugHUK4bD9uJW7S8Nj4M5PeZ8D6qYHc65Fj8xWV1F8Aqy2hDiabPy/3CDGbqcmRCg
 5tDXT+8GSqKhq6SSmHEAaQwo19Pkpv9//UfWzT/7pMBnTpcTo2UqhZZRNl6gt7xb0OiTw
 3UeaPC2Km0tNQ9tIzlsVWhd3IMwmc0uh1OMWhyzjm4irycEfhkIsKltxDHo/3QyXI92zm
 e4h5u0r8KGJuft17keIndR51QszwqUDyhW1uS7dpz2cLDuli2nVQbrDe5Kkdv5no06Q5L
 5RU9FuplcaoWSEUW5YJnRAM2zUEdzP89NgPiM3UyB22uELmpScs1djdcAizkrd5KGvA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B5A661F031E6;
 Mon, 26 Oct 2026 19:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793042239;
 bh=m6JQuiiAvAgYD5P15vse2J1auiyKgGQSXV7w3Qubaxs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=F4n0CBhUCYnGNj1cWqi28pTIOvZsA3SKRhrT0hZ4hWuJL9mAUB4S6qORi4bG8+EUD
 eavjIO/7EDVEcVzWa1Y3fCY9Q6bIwE2dJIYH4inRDMAO/cVSxwFpU8ibD+FkoAESdF
 14kES7EBwkmfo+ZJLMBwQ3GTsIaT/7xqir8CQsVd+GccEaP2lFRCSk7pprq8zC5Mc8
 MRorNYvxJeuiZHef7JnGPP/8uG7pE30IiMb+fGoTtLMU6SrMS0d0wOcRIIMUG0372X
 njqwcfz6muWND44UH6nwUvbQlbTHNQY/WRhX88tYx1aBluXAKJf4pn7SKKOQGnH6GL
 /M33KTTWLIsgQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id DC2D244E58;
 Mon, 26 Oct 2026 19:17:16 +0000 (UTC)
From: Xi Zhang via B4 Relay <devnull+xz.ca.cn.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 16:16:54 -0300
Subject: [PATCH 6/8] drm/msm/dpu: workaround res re-assignment issues by
 pairing enc/crtc
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-msm-dpu-res-clean-v1-6-f46130a8a717@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793042236; l=1740;
 i=xz.ca.cn@gmail.com; s=20261026; h=from:subject:message-id;
 bh=3eiBb0uy0PBNKjp2IH6yVXShmpVfE6rEzfXROTQjPv0=;
 b=ycxSfaEHnf/r9SC/zlyhmgTTleLJJJn92cKvzii6Bit0CyIas1C355iPIhMAqv0NA6PlhVHZC
 dulUR+CXhM7DEBZrrlKO277amomkcrzgmo04Y0S7FeLxt7KmbuRk4vy
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

Consider the scenario with 4 crtcs, 3 encoders/displays are
connected. DPU resources is nearly maxed-out, and mode set is
performed on a display which has acquired many dpu resources.
A new crtc is selected by kernel drm for the mode set,
and during atomic_check, the previous crtc won't have a chance
to release its old resources from global_state before the new
crtc tries to allocate new ones. Leading to atomic_check failure.

By having the same crtc for encoder when possible, during
atomic_check each individual crtc will always be able to release
old resources before allocating new ones.

Signed-off-by: Xi Zhang <xz.ca.cn@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..13099d6e3ac9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -879,9 +879,18 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
 		}
 	}
 
-	/* All CRTCs are compatible with all encoders */
-	drm_for_each_encoder(encoder, dev)
-		encoder->possible_crtcs = (1 << dev->mode_config.num_crtc) - 1;
+	/* All CRTCs are compatible with all encoders.
+	 * Nevertheless, if enough CRTCs are available, pair up crtc/encoder
+	 * for better resource re-assignments during atomic_check
+	 * from userspace mode set.
+	 */
+	i = 0;
+	drm_for_each_encoder(encoder, dev) {
+		if (dev->mode_config.num_crtc >= num_encoders)
+			encoder->possible_crtcs = 1 << i++;
+		else
+			encoder->possible_crtcs = (1 << dev->mode_config.num_crtc) - 1;
+	}
 
 	return 0;
 }

-- 
2.55.0


