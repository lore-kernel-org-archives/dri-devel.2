Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B4606A325
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SL5K22rg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5C310E124;
	Sat, 21 Nov 2026 07:55:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EAFA10E124
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 07:55:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0AE87437BA;
 Sat, 21 Nov 2026 07:55:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795247748;
 b=FP2fgZaqFMxmhTlhTendliqSaVeV86qaA0irYnUEbU6dT+2343uL8ylFerpWIU+K70UM
 Yw0POsZlNuORAApGrFFL6r3v6qPCyMSdiQr2UYw0XWMCCuOPWXVGa2ZMRibLM9sTfbDZH
 MaTYKWGNEWYHLGKYCW0TbbZeAPJHbHi107C11GpIeQy9UWcEFCDvmVhhKss7HPKcwbeG+
 1ezIv8GM9xDsP0WRJiQc5YotYfyqrS7fwioR+KmP3lJ4cwO+pdgR68LQ9vKRAAmpV70Cm
 eSXiFHXDUa2MXLmQu/9x6kKYgdymJUsNryElOXvYQrP2zZ92gbd63zVQXn9qOBgZ4qw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795247748;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=qXfZdfLbYngiwneMT5/oAhiJpL1DMcXjDGugDTBA9xM=;
 b=a+so0Eu6rxehvHn7QI3FnWjDGo8wRzhulO512rqM1g26abCqWVgofNozcyi1MfbMapmf
 7MO9K/rHSsHQqY91t1unZx62YrWfha2mtI+n6/vNNi3ie8BndujsdNmGD+LqCQbigXB0h
 pwIrh+UbItcCdd1t7F1ZIYK4nVvMTOXSyxipbGk7fq4bgQ5E5JS+njx1TTT55iwEE3glj
 m+dZNESoAJ6QKANPw2F29mV1ATkc6oyMTg+fg3Re1J/+zZzsSPBxZBCvDNJtcsWDn5nQl
 qnQt5lIxU2EC12IcxLJls80XegSIacl7Z4MdmCYftmAPpbNz5gQfXsMvyvFpvZ3MIgQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 65DD21F000C0;
 Sat, 21 Nov 2026 07:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795247748;
 bh=qXfZdfLbYngiwneMT5/oAhiJpL1DMcXjDGugDTBA9xM=;
 h=From:Date:Subject:To:Cc:Reply-To;
 b=SL5K22rgxZLW1OwxV3ayv6ff/hpTPZLsxCIYRV2kOyzS43RPBDKApAXhsOvCgdeKr
 q61xEGRfR71dmdJQTklRxbIj6VzNJXzQPmi1kHDf07J0jfMq0R3MKRX1GGwH52oSeW
 tPIn0Hj4m8W4lrwZj4LmbspQJMFPb6yfMdaXP8ijiSQtxnp77Ycq6DF9zoL1Qio3lb
 rgvJHZovUTJtcLpHkBpvRgGyO132DZJ+isnt7hLzikZ3zCokApY1/x65fMJX5GzoxM
 VXpMuuYnkZ2oL+6vFMfzxn+dfGKl48znegPt23GwiRN4+ARWLDznADl3EABgBEBjIu
 iBDfltPHN8wEw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B8FBC4BB50;
 Sat, 21 Nov 2026 07:55:47 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Sat, 21 Nov 2026 07:55:48 +0000
Subject: [PATCH] drm/rockchip: vop2: Give each RK3588 video port its own
 cluster
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261121-vop2-axi-primary-v1-1-8d5c74905207@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ5EQBBA0atIracS1QuDq4hFa4WSoFM9hIi7a
 2P5Fv+fEFiFA5TJCcqbBFnmCPok4AY794zSRoNJTUZkCLfFG7S7oFeZrB5YfKlzjU3bImeImVf
 uZP8vq/p1WJuR3e/5wHXdfoi3WXQAAAA=
X-Change-ID: 20261121-vop2-axi-primary-971fcba0d98e
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Damon Ding <damon.ding@rock-chips.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795247747; l=2484;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=UR8Iq6V+Z+wSboGx6S1Fg+4yyPj7jK+nIZtEYEItTcg=;
 b=BzumBlQkZjOG0TMxnd3EtaRuRxZfKAHpRClLRwaJBDZUqFH4KPBUDGCnKKSnEDXOiwOrH/jJL
 6sQahfkkNrbBNjoPQ8VYFezMHCfJgh8R52jxwiRw3NBZ8PTHffQuEGm
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

Damon Ding asked for POST_BUF_EMPTY to be fixed in the layer setup, and
Chaoyi Chen pointed out that a video port's layers must stay on one AXI
port. On RK3588 Cluster0/1 fetch through AXI0 and Cluster2/3 through
AXI1. Each video port takes the first free primary window, so VP0 and
VP2 get Cluster0 and Cluster1, both on AXI0. A 4K120 and a 4K60 XR24
primary need about 6 GB/s there, one port delivers about 4.5 GB/s, and
VP0 underflows in every frame. aclk_vop at 750 or 850 MHz is the same.

On RK3588 give VP N Cluster N as primary plane. Boards without VP1 now
get Cluster2 instead of Cluster1 as VP2's primary. RK3568 and RK3576 are
unchanged.

Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Tested on Orange Pi 5, HDMI 4K120 + DP 4K60, v7.3 plus local HDMI FRL and
750 MHz aclk_vop (not in mainline): 7207 bad frames in 60 s before, 0 after.
Applies with Chaoyi Chen's 8K series [1]: VP0 keeps Cluster0 and Cluster1.

[1] https://lore.kernel.org/all/20261116084555.1061-4-kernel@airkyi.com/

Developed with Claude (Anthropic), which wrote the code and the commit
message. I reviewed every change.
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
index 76d151b8bc52..303d9b987a7c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
@@ -2583,6 +2583,12 @@ static bool vop2_is_mirror_win(struct vop2_win *win)
 	}
 }
 
+/* RK3588 primary per video port; Cluster0/1 on AXI0, Cluster2/3 on AXI1. */
+static const u8 rk3588_vp_primary[] = {
+	ROCKCHIP_VOP2_CLUSTER0, ROCKCHIP_VOP2_CLUSTER1,
+	ROCKCHIP_VOP2_CLUSTER2, ROCKCHIP_VOP2_CLUSTER3,
+};
+
 static int vop2_create_crtcs(struct vop2 *vop2)
 {
 	const struct vop2_data *vop2_data = vop2->data;
@@ -2655,6 +2661,10 @@ static int vop2_create_crtcs(struct vop2 *vop2)
 			if (!(win->data->possible_vp_mask & BIT(vp->id)))
 				continue;
 
+			if (vop2->version == VOP_VERSION_RK3588 &&
+			    win->data->phys_id != rk3588_vp_primary[vp->id])
+				continue;
+
 			if (vop2_is_mirror_win(win))
 				continue;
 

---
base-commit: c408466a4dfaee4b12587e926c5b85e68c8b3c40
change-id: 20261121-vop2-axi-primary-971fcba0d98e

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


