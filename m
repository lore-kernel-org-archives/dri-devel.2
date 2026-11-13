Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3E1606A885
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=liHHypdb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F7521126BD;
	Fri, 13 Nov 2026 16:39:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A059B1126BD
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:39:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8927B40A78;
 Fri, 13 Nov 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794587959;
 b=pxtisLY8NTsy762MMvDnwTI14w3Pa53mGQZFD7Ekk3H27zeE3BCWVAVn404Q9by1+zL1
 pP7XLxOCxZB2nUIeAUoe1uaYhSwAP7BYXKwo3LN3vYEUAeU6qABvjbKnXwVFPcz8e5sDs
 wtTn/KLe3wJ31zsZJ4WK7EmxSDJ7hbdX2gL+ZLwr7RS8TBXVrQ4jRw/bBrjD2A2XithbG
 NqZ41K3V4hOeEd11sYjXwOkrO/fKNriHcKgMNo8wmGbrNHKqzCfrYrTTSDFGYT0Kr3UkK
 +uabgI0zRZXiXUzpxZTRMIQodeGsf828ToecN3Ovd6WW9IKExuBmYawVuAqIxrD5wBQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794587959;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=7zpkorwus004YyxUUcOl7JyvlAtNECWRC9I0Q9NEaTU=;
 b=L5DDuBqwUf1gjAJhzQ9JjcpTiarLCAljJBh2vjfVvkIdQawNZoDMchJKBZwX9TB0GtF/
 jMWchb2ViMHlQuUbrNnVUxND8yeqD7SuLNixQaU0L8s9I1YTa+IdbCaUJtZjnFgXV7n0R
 NrV+7trpbUp0NSAQ/1t9bsN7SbLgw1DU1u1sPiqgIp88x4hXOKsSM1Hacm3RsWOH1xnGQ
 PulSYHp78VSK9R8yLL4OtYukOvyZuv+f3G8K7wW08O0bgc8UlT3+yE/PvbpvamMI/7ETn
 SFJUW2127vB3TzkZZzuzKCUCTbfD2QRLHe5W8DutmrmAmjOeReBq4jo5vNweTMJVdjQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id E4D5B1F000C7;
 Fri, 13 Nov 2026 16:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794587959;
 bh=7zpkorwus004YyxUUcOl7JyvlAtNECWRC9I0Q9NEaTU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=liHHypdbqq+1mNlpkUHAmBMwR4jXHGgNoLdOCknNBNSjX82KbNJa0z8IAGsMe1PPO
 pq6F5z0XnrNsTQeq4zIA3GftwSNx5IfzDRi/XSRLLUojmzEvZI25cQYKO58yzEw4e+
 zw7WUtPGMHxWbcza+ib+hVop3MWwdTEMzoWdaMNb72a597mj9kyIJ1q1DgzWoZxORX
 XEI6vaF0DeAm4MmQWw6Xrj6oHFA00MQOse5VKLbdgh29ze/jCxxB574honn7IHmNZI
 9Aw+awQ2X4B2nECwO/tgG7Fz4Vt4JWLp9RqhynUnR+gbaFOemltFXc+y2ozqxXowFD
 hhfnEnTuZDRFA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 77359499AA;
 Fri, 13 Nov 2026 16:39:18 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:39:18 +0000
Subject: [PATCH v3 1/8] drm/rockchip: vop2: Take the UV plane address from
 the second GEM object
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-vop2-fixes-v3-1-08ae37e83b5c@gmail.com>
References: <20261113-vop2-fixes-v3-0-08ae37e83b5c@gmail.com>
In-Reply-To: <20261113-vop2-fixes-v3-0-08ae37e83b5c@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Damon Ding <damon.ding@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794587957; l=1358;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=NyEom6Ygar2g2E7rLCqTeR+IWUlMO87YHp3qaA5pe+8=;
 b=CJPvsRb+FeVzYc8gP6W0cF136DeokOuAD1BCNIGfE8dNt1REZCVnpFJ49KJgBJlBuQBo0FjL6
 Jatlf+XM37dA1SJ3GZlKWla6xcQrmz2pBEgjBC4I6zKcqAZy83iSe60
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
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
Reply-To: aiyengar1990@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arun Iyengar <aiyengar1990@gmail.com>

vop2_plane_atomic_update() takes the chroma plane address from
fb->obj[0]. The planes of a framebuffer can be in different GEM objects
(ADDFB2 with two handles, e.g. NV12M from a V4L2 decoder), and the
window then fetches the chroma plane from the luma buffer.

Use fb->obj[1] for formats with more than one plane.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-206550@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 76d151b8bc52..e8ef83d6924b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -1369,7 +1369,8 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		if ((pstate->rotation & DRM_MODE_REFLECT_Y) && !afbc_en)
 			offset += fb->pitches[1] * ((pstate->src_h >> 16) - 2) / vsub;
 
-		rk_obj = to_rockchip_obj(fb->obj[0]);
+		if (fb->format->num_planes > 1)
+			rk_obj = to_rockchip_obj(fb->obj[1]);
 		uv_mst = rk_obj->dma_addr + offset + fb->offsets[1];
 	}
 

-- 
2.55.0


