Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B54606C83E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iprGMWYA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52FFD1126C5;
	Fri, 13 Nov 2026 16:39:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A1791126C4
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:39:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91ED36292A;
 Fri, 13 Nov 2026 16:39:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794587960;
 b=fbaKO7NdIOYUyQ/4+G/mI1f7bmunKNnZgg/5ca2nb9Qq+EbArTXv72XbUhHAV/lskmD6
 Yt/pVpVaIlGs2al8S1T9fUZKvec7N+0PenYilK+7Z3O4VloWtb8TdF+yoJ/DQRjGg2eg8
 w/bm56W2V7Jbgk1UxdW+CYPpMrjWYdr3xkRmqCAa1WM0q/HG+8TJKHSYiKjAd/Oe5kVWe
 n+FsJzXKWBBqQQN/36z9B1E6tSiNDrOYkyF5fZQd/Ivf9Rw1SRtE4qr2V0lH8LiBXM/ax
 ZEAvsgH9+BHpkXovMOGM5B42rYkOogbMXec6VRBTTTzty3YsNqrG0el1zDieCH4MQ0Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794587960;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=FNxftrXL1E2FSc0xpVv1WeFG1GOkl5gZQCa/93IkA6I=;
 b=joRXcN8XVDIhLIdr3f8YJodxqKnsJgckv5MV41pN1Rz3DIT3PE9naCxY/UFyhjGsb8ow
 tg1BWik/RizHq5mXMfhw5G2lt7zbIrrpj8hCsbSw23PEvDMEB+xOgsmi33MTKdsb8XkYd
 YQzfTIpnS+Gi6Le5Pw8e54Mhb6MHvYoFVGm91RPWs0UggtOivzrPbyyN0hub/rPmbbJYw
 zqc67StPPwMq+mK24rZ22B6XgGCCgcvIuz0oeDdW6pEjkC2CzM4iv2HXLW5xNOVRLzoZQ
 EBp2yLZ7nnQrXpJvjX0zFrq2omgwTrJe4zWyD37GrEgJdeRj27gQjmFJgvZP9ffAFOQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 3F6A71F000C8;
 Fri, 13 Nov 2026 16:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794587960;
 bh=FNxftrXL1E2FSc0xpVv1WeFG1GOkl5gZQCa/93IkA6I=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=iprGMWYAA6D+FVel2n88O5jgqqWGNZNWvqHFCcuQBUF04QwFuQ2tKv/26h+MAi6wz
 Iaje3q2lAcnBfId5mzwZW3eTY1L66WY44v3QLJA6yojUgHg+xL0hbq4ra05TgWns2n
 I1Y9ckQQf6A4UMTyT4jGmQgsV3D/p8Jva/2NFCuALeTTKzWMY1Al5PueTvRCbbhz5n
 bhabgosgAh5tpqBsA8iuIWoMqePMgTWW3klksLDP/4ijEflbTOLgBp0Uz5i532Pv6n
 ywekMynVMkrh8uhWzvwY14vdXJvBnKqzJIukLXYbzAWdjG23pZWqBTmWXZwQR82wzy
 PpHUm9SNPqXNQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C6985499BD;
 Fri, 13 Nov 2026 16:39:18 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 16:39:21 +0000
Subject: [PATCH v3 4/8] drm/rockchip: vop2: Fix the HDMI sync polarity bit
 order on RK3588
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-vop2-fixes-v3-4-08ae37e83b5c@gmail.com>
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
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794587957; l=1424;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=UGsUFXw5YCEmRTpiw/otu9BINYjzUVbOqG/Y9ftnmx4=;
 b=6Dmcvc9cKlPBL5ogCbcn9fM+YHzcY68rXAT61AwNeTTAOlVNuJLADIMDaq1o8ZWo8lib94SxW
 b48ZjBNy9qPAy7ZL0AWu90nR+lgltj7uWvUY7PlTIkKGQLoRzeIY9NK
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

In GRF_VO1_CON0 the HDMI vsync polarity bit comes before the hsync one
(bits 5 and 6 for HDMI0, 7 and 8 for HDMI1), but rk3588_get_hdmi_pol()
puts hsync first. Modes with mixed sync polarities go out with both
syncs inverted: the HDMI controller sees 1920x1080@144 +HSync -VSync
as -HSync +VSync in VIDEO_INTERFACE_STATUS0.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index 3e654cb99ddf..6d08988d7007 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -1683,13 +1683,13 @@ static u32 rk3588_get_mipi_port_mux(int vp_id)
 		return 0;
 }
 
-/* The sync polarity bits in GRF_VO1_CON0 are set for a negative sync */
+/* GRF_VO1_CON0: vsync bit below the hsync bit, each set for a negative sync */
 static u32 rk3588_get_hdmi_pol(u32 polflags)
 {
 	u32 val;
 
-	val = (polflags & BIT(HSYNC_POSITIVE)) ? 0 : BIT(HSYNC_POSITIVE);
-	val |= (polflags & BIT(VSYNC_POSITIVE)) ? 0 : BIT(VSYNC_POSITIVE);
+	val = (polflags & BIT(VSYNC_POSITIVE)) ? 0 : BIT(0);
+	val |= (polflags & BIT(HSYNC_POSITIVE)) ? 0 : BIT(1);
 
 	return val;
 }

-- 
2.55.0


