Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A63E60A6F57
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPTu127c
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 043C010E292;
	Tue, 10 Nov 2026 07:19:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA88610EE50
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 07:18:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 28A78637B1;
 Tue, 10 Nov 2026 07:18:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794295132;
 b=PIdjL5nDWgrZ9ihdTzC+wIhIHQky9A6h77g6lJIj8QKW3mDl7cOVwgfeWN/OnGDCBLpW
 5ZfVUlb71QLdZeWJ3gySRJAfPAlMwXa4oYRvk/uL5NVKRMYDZpjBpgAQO1stqYfGfgOMC
 NTJznIdgYqopCVKy9rKcuseNpcqqjsIY7vI8fZNUVNwBpapCSEaHBNJkMUFfBxhsemMut
 VAGzrTYSGkmkt2PGJdCEHQe0sAWM1dvUlCEZlfju3krXUBDeJXsy0Dr2HUDpt0Sk5myo9
 0QyRT8sdXMXIZY7z/dWuibMuzpYPeHfV9JqBpkBDYfz4mokcZkxVYCYNxpa99/8cFFQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794295132;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=X2gumZ72gCa5mDhobP/qDnauongyiSO7DDc0Uq/gTtA=;
 b=weX/GW4B6uVLC0NXDcLRmsKNNMTSG4q1mPDBEplvd0ag+8zooJDlP0NQjq9OAzflIMco
 0c0dZBmPvfztxVIhDCAHp8UBYmfXBKcEiUEWGKujxv89z0uipXwHpcs2lJ1+BjyF72I9v
 m0YKoOZuFqn7nBXw2iXyB6C2bDUwVGcEj1U56SIrrP4TKKZzCmFyTbbUkcrKSLIZrVz4f
 iI/ZswVyH5iULIlNFpnt4BYNVctLnyW8aLN7MW9vwiJxmWe0XHCJ8rK6SKJF4CwK75Yrc
 u7ebDTkWKvCYvprtLW13jdqv8r0Q/7IYXreyc/t1wvASfn1qllaAJgtB4dA/mk/BhsA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id AE9B01F00900;
 Tue, 10 Nov 2026 07:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794295132;
 bh=X2gumZ72gCa5mDhobP/qDnauongyiSO7DDc0Uq/gTtA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=UPTu127csa65S4MF7axeYgMKsLAAjvarjep+F5qRwsgzelY7MG81KHUE4pUpRmqpG
 eyWMcLwRvtAjF5BbE3xqUoQJH8DZd+DikrBF768Fp6a0FG8JxyXdbw9uce6oZ4EyHi
 +fsUm2eDG1x3O2KwRyrCHeD7keXSozKAckBFPDl6tc+4PKKw/yzltw7EwiZWxfA00G
 0qlBqSLxn7Y4yxKCzZ1y+wTz0s1kOzPznh+aRTRzD3NP8e64rSK/PKgdb3PUO5erQf
 Kt2PAgdX4CDivQidiDvjFENYkYoc8iYEty27UjCmePVPUgzHRzHLTVFnDDUPSB66rM
 e+xp7Xe4vL1lA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 3FB4C489D1;
 Tue, 10 Nov 2026 07:18:50 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 07:18:56 +0000
Subject: [PATCH 8/8] drm/rockchip: vop2: Fix the AFBC offsets of a source
 that starts inside a superblock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-vop2-fixes-v1-8-d336e9dd90d3@gmail.com>
References: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
In-Reply-To: <20261110-vop2-fixes-v1-0-d336e9dd90d3@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794295129; l=2213;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=Z5XfF2nsYcotAweg654B6mvuS3zpVj/f+2xNB/MTWGs=;
 b=rWMJW3meaRAT2SDZPbZW89VwvWdgRqpSz2+s9aUUSf7UtPXPtZPUbF8MeNdmuKygJeiCabiD7
 t4aMFOmel0xCYngzbJGZJM5md+9lCSLgY2cUk7UDDL3ock25CW2GBH7
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
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
  field, instead of the position in the 16 pixel wide superblock.

Count the superblock columns from the first one the source touches, and
take the x offset in the superblock, like the vendor kernel does for the
not mirrored cases. The X mirrored and rotated cases are left as they are.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 9ad138457204..dfb76bfbc358 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -486,7 +486,7 @@ static u32 vop2_afbc_transform_offset(struct drm_plane_state *pstate,
 		ty = act_yoffset;
 		break;
 	case DRM_MODE_REFLECT_Y:
-		tx = act_xoffset;
+		tx = act_xoffset & 0xf;
 		ty = bottom_crop_line_num - act_yoffset;
 		break;
 	case DRM_MODE_ROTATE_90:
@@ -498,7 +498,7 @@ static u32 vop2_afbc_transform_offset(struct drm_plane_state *pstate,
 		ty = vir_width - width - act_xoffset;
 		break;
 	case 0:
-		tx = act_xoffset;
+		tx = act_xoffset & 0xf;
 		ty = act_yoffset;
 		break;
 	}
@@ -1577,7 +1577,8 @@ static void vop2_plane_atomic_update(struct drm_plane *plane,
 		if (fb->modifier & AFBC_FORMAT_MOD_YTR)
 			afbc_format |= (1 << 4);
 
-		afbc_tile_num = ALIGN(src_w, block_w) / block_w;
+		/* Superblock columns the source covers, the first one partly */
+		afbc_tile_num = ALIGN(src_w + (src->x1 >> 16) % block_w, block_w) / block_w;
 
 		/*
 		 * AFBC pic_vir_width is count by pixel, this is different

-- 
2.55.0


