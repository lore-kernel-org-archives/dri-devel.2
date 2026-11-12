Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A98606A8A4
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nM2p2EIy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F7110FCD3;
	Thu, 12 Nov 2026 08:33:23 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FAF610FC7A
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:33:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A78B863E00;
 Thu, 12 Nov 2026 08:33:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794472391;
 b=Cl/+97nCA1h8i8VgsOOtbvbtjUdvJKYOEU+semB1YK9rtFKEG9wWFA47/kk4uFcMh5Ar
 6kRLHnREcuntx8sC6836pfdp/S/PF6iO+W+lquF4v2EWHg7LeQbij6Uo6Dfh5fEjSl2az
 Ro0NT/6TdyQQUm3PA6kqcZb0yWcJfgjB2kCmmszLWeM3hE8bmsEDMvsKIe4eD3Tkv5Ji1
 T8c3dix4e3OUyhm6TQxVWiRi31nZY75KPEyXvhulyw3ru1mX8i8NEfgxboroAXp231wbT
 i1ayAWanM4wJ/g50tvsVNRLPpX+HTyxmuCbhQ9kv4LqiEoGZiGvp8ow7F/fVaikhN9g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794472391;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=dHj51gMQ8uQhwkQpY2b4D9/D/MpMtRNQyvnnTdQLIJ0=;
 b=AIIio3y2Zt9DH8Nk/uXDrXKSP9660sNgQXYAg8OGKYISVyq6QP9KnBQ/2DPiHUy2BOrb
 lEhdbFA5qI2W2sgyD6M76P/G4R6mD0MhT0F++Rn3UgnKoAVVoN1dE62uq5xo+CNCOZ/w8
 CcXuflHqnC3nojH/TC3z8FWWUd1js3b8Tw/0lai7K9Ku6ReljggdqRMXzGOoEm/sPcecm
 zF7zsN2xRTkjiKrwP1e/pqqhC8s7gdi2puejyCA3u8GKZhpaetJ9e8VSSYdttnYdMNXkc
 AqpaE6BLFeKbBB9uMrjHjKKuMUfWA6dQWyuTeu+5GGWp2aF3RMaju23CILfVNS1nd1Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 180051F00A0D;
 Thu, 12 Nov 2026 08:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794472391;
 bh=dHj51gMQ8uQhwkQpY2b4D9/D/MpMtRNQyvnnTdQLIJ0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=nM2p2EIyQbYw6w4tzyFZccWyqHZsgK07vS+589h3zb8usjVHBhwhVs16rEC1zzuCt
 U4v/FVMkMlpTClna8YVsuSPk89I0foVAKkjvNIiARh0tnLdEy4ZkBExlCglLTqWyeu
 7+Bx0RBTXdlV5D8d8sZfvrbptE0EeUJoHfUOgP6h4nE9PUjkTB/Xuoqt+c5Po+Z7ur
 /p3GSgFPNwj/Pz4DzjXUAT4zWSH4GxlB1ypI6tPpixHjvPKGCPwohrYUQ3Vp4bbUNX
 SI5Aw30k2dM12/ZzEP3Xe2Pk9+P0dzDUnLKx/ck5NGz39UjZ5s1sdXUs5vwpHJN3Bw
 qruPCeXWeC4yg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id EEDB5493C6;
 Thu, 12 Nov 2026 08:33:06 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 08:33:13 +0000
Subject: [PATCH v2 9/9] drm/rockchip: vop2: Fix the AFBC offsets of a
 source that starts inside a superblock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261112-vop2-fixes-v2-9-8218c1cf8ac8@gmail.com>
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
In-Reply-To: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794472385; l=3183;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=NK+8Rm2INnnfeJa9OAQjLE/uLIeTJ3MOciFQGunaOiA=;
 b=ERQHyJ9mru3JgMuiW7seaQd/zSoJEeU3ViTogqMI2QQLi0rUy54OLXDZSEIQ/RqSjPOhLxEmA
 yG5JhwK2z2kBoOBkPrDdinC+TBgqvztb+0jd9F6+GD56YpmsQWYkMBI
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

The AFBC decoder of a window takes the position of the source in the
framebuffer (AFBC_PIC_OFFSET), the number of superblock columns to
decode (AFBC_TILE_NUM) and the offset of the first pixel inside its
superblock (the transform offset). For a source that doesn't start at
x = 0:

- The tile number only counts the superblocks of the source width, one
  short when the source starts inside a superblock and ends inside
  another one.
- The transform offset is the whole x position, truncated to the 8 bit
  field, instead of the position in the superblock (16 pixels wide, or
  32 with AFBC_FORMAT_MOD_BLOCK_SIZE_32x8 on RK3576).

Count the superblock columns from the first one the source touches, and
take the x offset in the superblock, like the vendor kernel does for the
not mirrored cases. The X mirrored and rotated cases are left as they are.

Fixes: 604be85547ce ("drm/rockchip: Add VOP2 driver")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 259e30ebb9cb..0e16b665ccac 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -439,7 +439,7 @@ static bool vop2_half_block_enable(struct drm_plane_state *pstate)
 }
 
 static u32 vop2_afbc_transform_offset(struct drm_plane_state *pstate,
-				      bool afbc_half_block_en)
+				      bool afbc_half_block_en, u32 block_w)
 {
 	struct drm_rect *src = &pstate->src;
 	struct drm_framebuffer *fb = pstate->fb;
@@ -487,7 +487,7 @@ static u32 vop2_afbc_transform_offset(struct drm_plane_state *pstate,
 		ty = act_yoffset;
 		break;
 	case DRM_MODE_REFLECT_Y:
-		tx = act_xoffset;
+		tx = act_xoffset % block_w;
 		ty = bottom_crop_line_num - act_yoffset;
 		break;
 	case DRM_MODE_ROTATE_90:
@@ -499,7 +499,7 @@ static u32 vop2_afbc_transform_offset(struct drm_plane_state *pstate,
 		ty = vir_width - width - act_xoffset;
 		break;
 	case 0:
-		tx = act_xoffset;
+		tx = act_xoffset % block_w;
 		ty = act_yoffset;
 		break;
 	}
@@ -1816,7 +1816,8 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		if (fb->modifier & AFBC_FORMAT_MOD_YTR)
 			afbc_format |= (1 << 4);
 
-		afbc_tile_num = ALIGN(src_w, block_w) / block_w;
+		/* Superblock columns the source covers, the first one partly */
+		afbc_tile_num = ALIGN(src_w + (src->x1 >> 16) % block_w, block_w) / block_w;
 
 		/*
 		 * AFBC pic_vir_width is count by pixel, this is different
@@ -1867,7 +1868,7 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 			vop2_win_write(win, VOP2_WIN_AFBC_PLD_OFFSET, yrgb_mst);
 		}
 
-		transform_offset = vop2_afbc_transform_offset(pstate, half_block_en);
+		transform_offset = vop2_afbc_transform_offset(pstate, half_block_en, block_w);
 		vop2_win_write(win, VOP2_WIN_AFBC_HDR_PTR, yrgb_mst);
 		vop2_win_write(win, VOP2_WIN_AFBC_PIC_SIZE, act_info);
 		vop2_win_write(win, VOP2_WIN_TRANSFORM_OFFSET, transform_offset);

-- 
2.55.0


