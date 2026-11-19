Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E38606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 05:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kIVMi7qe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1803710E508;
	Thu, 19 Nov 2026 05:22:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6713510E6E5
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 05:21:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F3B9459A4;
 Thu, 19 Nov 2026 05:21:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795065706;
 b=Urq1xsMHLAzmugV7mMUCshKTNesOijscDSYbB4h6oly1YVHXYl4UFIrScGfhoEpSJeA/
 EV3yGwE6gibqsPtlA2PO3GYFhtSUvMW7c4IljV3PrpoDycMFHoLq2rIF2ROZjUQYwt3Qh
 5Pc/kMfq4XxA8IBjyZss6oml7eg96YzQuj4RJIyN2qAgUArh85KzR1GbDeZRhk+xw+uhs
 tVcsik5CCf7okLsrXOFrZopD4Yx4yu0bSIM6EwP9MPKN8olyqE6pZc8mhaR9Sq5AFdtX3
 HNF3evt85yJILY+jeYO6VzhJ3ZcDSCJpYV73iz1D4pw7qByoQdwF4z0RUQgRfhpyZVg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795065706;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Sea7z+n5pZZqi+t3TzaXiTFzXOh2A7iP/dngPcAdtLM=;
 b=t2/iBnIUYUfP3zLqEtuwzuGZiFTSEGLxPtXEtx8x14BwZqOrL9WpHSSZPiDjqnR7eL0l
 DdVvewSLACQK1gG8OuDKpRMNwkqw1v/50zbaQ+WYhumCSw6vCeyFWRvhHITtoKn49RCmu
 wiMfDnicrmT4leRN8tL/0QLYT+j2e8hUqh6hTSk+wBczULDgbJktKAWdUeBwgiSSJrKRZ
 XrPnnW0h1zh363bOhbcN+7r6vALtPtbrMHVTwrTzrCAl2OhHqt4jAB6H6T/QqN74JBYnr
 cHWkt3Hh3FxxMcVjGt840Sq3/8atnbPSVoe/BngxlPQg6ofwM+ev3xbI6vIovAlIARA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 008091F000CB;
 Thu, 19 Nov 2026 05:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795065706;
 bh=Sea7z+n5pZZqi+t3TzaXiTFzXOh2A7iP/dngPcAdtLM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=kIVMi7qeV7R4TMNgc/Fr3H5FM0sDS8GDvK4aKJ7IAuYTTJFojDIz1WiB1jUDyvaQ3
 Kby5+5X8X6574p09Mdc8Mzm5R0Q9bp/Y1vO5uWlQTSyeKzc+M5NJrhhu5aXTzgw3Ms
 lErobWZJw6PgZwcIHNpi6ogGZC2gBmVD6IkB/oPOiQHDrx/oTKldFtGkUrbi1SAaSf
 l/n5BaDGYMdJEx07FRzECiB/irUGS9wcRYEjwMNAoTRS4Bq4DCuhceRueYhu3vusgG
 vC9VHDdS/mCZeOHo43xGwpVywXEUxOL5F1dK0oesy28OX3pcv9gO8g+XDbBIS1LP3u
 Bkhg1dG+tGEmw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 7CC8F4B102;
 Thu, 19 Nov 2026 05:21:43 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 05:21:44 +0000
Subject: [PATCH v4 3/8] drm/rockchip: vop2: Fix the HDMI sync polarity on
 RK3588
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-vop2-fixes-v4-3-4b8f5e7148c9@gmail.com>
References: <20261119-vop2-fixes-v4-0-4b8f5e7148c9@gmail.com>
In-Reply-To: <20261119-vop2-fixes-v4-0-4b8f5e7148c9@gmail.com>
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
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795065702; l=1551;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=y/BLNj95neZ1kNSGI9NFsr8jsXQo+g+IgIthS+l+Duk=;
 b=0qcKw8upSrWwQ8ZwYNtXRiuBPfNZd2/78sN+W/kwWn5wJf2395l6zxYIq3H7fHd7F5A73Ge9U
 0HF/gIGeYyIA5uVSUAcyJE0xTnGgqnZrPlh99x/pnx2lJq89gmP3/6F
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

rk3588_get_hdmi_pol() is passed the POLFLAG bits of the mode but tests
them as DRM mode flags, so the HDMI sync polarity bits in GRF_VO1_CON0
come out wrong: +HSync/+VSync modes get one of them set and
-HSync/-VSync modes none.

The bits are set for a negative sync. Test the POLFLAG bits instead.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Reviewed-by: Damon Ding <damon.ding@rock-chips.com>
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index f340aba5bfd1..3e654cb99ddf 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -1683,12 +1683,13 @@ static u32 rk3588_get_mipi_port_mux(int vp_id)
 		return 0;
 }
 
-static u32 rk3588_get_hdmi_pol(u32 flags)
+/* The sync polarity bits in GRF_VO1_CON0 are set for a negative sync */
+static u32 rk3588_get_hdmi_pol(u32 polflags)
 {
 	u32 val;
 
-	val = (flags & DRM_MODE_FLAG_NHSYNC) ? BIT(HSYNC_POSITIVE) : 0;
-	val |= (flags & DRM_MODE_FLAG_NVSYNC) ? BIT(VSYNC_POSITIVE) : 0;
+	val = (polflags & BIT(HSYNC_POSITIVE)) ? 0 : BIT(HSYNC_POSITIVE);
+	val |= (polflags & BIT(VSYNC_POSITIVE)) ? 0 : BIT(VSYNC_POSITIVE);
 
 	return val;
 }

-- 
2.55.0


