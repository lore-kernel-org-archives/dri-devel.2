Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6314606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVchp0/w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 595B8112055;
	Wed, 18 Nov 2026 21:46:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FB5111204F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:46:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD4DF63EF2;
 Wed, 18 Nov 2026 21:46:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795038372;
 b=U2RRlYd/jgBAVflnzxa1eeNr/jv8JqH50al/LFymeEau6VH9HH6S6nAp1RRZZ3TRGqb8
 Clrt95iOdY07NnweNfIOmzYUZuuWja1XFj+YYWgi8ruHJz0+PIj7CV/TyuwzU4kbyw0h7
 OFeXGGgqc8eq5qOhbY6hxwgOwiurGA/aIfbD6M32cEeN9Ege2kTME1jXWSiyLCSAMNDal
 I35upFRGvAc+hfzuSfUJLdxy4e2X9XMJQxWyt10QGS0jS5ql4mp+ykgMgDTr3VhzDzc7P
 LUxtEAS/EvvrE8jyOkNznl+MMWcRkU7TcOINDI/oa0+SzUwF8aYIL2kk7o1S1g0mHUw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795038372;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=PLbFsZjlW9Fgd0b7uazzqvhlWAMluE6KMHEmsSBUhsY=;
 b=KxNPn8luUb+MDZ0dx5PE6ZfVWqfq//AgFvGZGwRFmiUXIEtOQ5SIDJMme+z5UX9WG4qp
 HlovW8hjG7BDXnImULC+8+2DNWk+tBNnJ/Ybz+QRJrEkJndeTTyQOBRh2/hZx3Tn2KAhJ
 2gSnpahf+iYirbTBfz4Mh/PQX9M5NuWfE9s4293ag+B8FIJ9Nw5ZMjrTd5rpwUH4ilMx6
 iyw149yxAZlqeixeizlNeEiPmtXE3JuAKQqRy6G5Q5VHWUw4ZT09xE3ZkyWqaMol5eQsP
 TnUKl8C8YgY1AViuVLPdc1hx4B2g7YOuzdmo5JAsEqukPnffDVOZVxI9hT2xnthfevA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 031241F000C4;
 Wed, 18 Nov 2026 21:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795038372;
 bh=PLbFsZjlW9Fgd0b7uazzqvhlWAMluE6KMHEmsSBUhsY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=WVchp0/w4K2OY6jU1p2fTFghGq6MXmIxpnh/AInNa6mdAhxpBXFDcvz1MbORjbPrT
 XxiDgJUv2Q/ndcO3uiVPGRGUezI0GBZIAq0FVE11b8izFrR52xpRqGKPniZcTVYTGn
 d3Mg2EV7wjot1XAoTAcl8ccFbm7q62VAsoBESLiRk0VZp92KCmjKCOnbvC+Fu0PhDx
 1yCPcBP1Zjqf5pTS+kGnVAie6Aq+X/1dHtQ9h2yaZ7SCFNTNGjbyVvF6YcmEYTCDAk
 Jueh7ncrBxeGLFsR/9k3HEe4w8lSbFQ4BDTi6m/0XuUJDXGtLYM/NLOrM/gwz0TEzk
 pHFFZiEbH+UPQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 768344AFCF;
 Wed, 18 Nov 2026 21:46:11 +0000 (UTC)
From: Joachim Eastwood via B4 Relay
 <devnull+joachim.eastwood.gmail.com@kernel.org>
Date: Wed, 18 Nov 2026 22:45:28 +0100
Subject: [PATCH 1/4] drm/bridge: synopsys: dw-hdmi-qp: Propagate the bus
 format to the bridge input
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261118-dw-hdmi-qp-bridge_attach-v1-1-e370920bc7f3@gmail.com>
References: <20261118-dw-hdmi-qp-bridge_attach-v1-0-e370920bc7f3@gmail.com>
In-Reply-To: <20261118-dw-hdmi-qp-bridge_attach-v1-0-e370920bc7f3@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alexey Charkov <alchark@gmail.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Joachim Eastwood <joachim.eastwood@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795038370; l=1192;
 i=joachim.eastwood@gmail.com; s=20260701; h=from:subject:message-id;
 bh=nDJvSyZzGdE5qngozS/m2hFt6NKpTw1uO/xm8cw5j3s=;
 b=JFd+Zi0dC98JQcizj9hNwpmDvrJlcpUfvhPeVkS2AWTJFlVRJpK98ox/5bgN8QespKtpcmmpM
 tOKQMAg02ILBPLPcTg/EUCrZ005csilIyVwrppOhgIXsgRm7EEs5Kme
X-Developer-Key: i=joachim.eastwood@gmail.com; a=ed25519;
 pk=ZN/8xWtdYaSd5oEfloYSZ1a+/ri0n0VZqjlEeHlbXFU=
X-Endpoint-Received: by B4 Relay for joachim.eastwood@gmail.com/20260701
 with auth_id=846
X-Original-From: Joachim Eastwood <joachim.eastwood@gmail.com>
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
Reply-To: joachim.eastwood@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Joachim Eastwood <joachim.eastwood@gmail.com>

Propagate the output format to the input, so the negotiated format is
available no matter what follows the bridge. There is no functional
change when dw-hdmi-qp is the last bridge, as the glue already uses the
output format in that case.

Signed-off-by: Joachim Eastwood <joachim.eastwood@gmail.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 9842209288369..eed249aca1e23 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -1026,6 +1026,7 @@ static void dw_hdmi_qp_bridge_hpd_disable(struct drm_bridge *bridge)
 
 static const struct drm_bridge_funcs dw_hdmi_qp_bridge_funcs = {
 	.atomic_get_output_bus_fmts = drm_atomic_helper_bridge_get_hdmi_output_bus_fmts,
+	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,

-- 
2.56.0


