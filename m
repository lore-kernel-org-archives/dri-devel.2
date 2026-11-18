Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF98606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8Ze3CRl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18DF5112051;
	Wed, 18 Nov 2026 21:46:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145D0112048
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:46:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B8E4F475FA;
 Wed, 18 Nov 2026 21:46:12 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795038372;
 b=Ll+EVPKJd1Ewpuz4JHGyYqsuQRK+UvHBwfLOgy5BqCrltlbc6BpkdD7eekISp3uW0sgF
 1gEN5jQY6uny0Vo33snuhqyYaansOBS0PobFbQollB2mWTKOV97Bo4ncYGRbsaTXR1ASv
 Y6UlhkLw0kQgqRnlOgDw9Zrg1mHQufgwGwP0vbbN58DqRdOjXjV8AhqdqsdW0sFzn7o5W
 7eORVB2nbDw+JxrtgN81uT5ZocZwebUxCrwmsNOiwOYOwqwB+zuS2102hCO+Q3TOFJNSS
 /YIv7Ug6Otfy9J4rrYdsZoiUqKZSK8hn3jj05uCSsYLPLITCsZNCUpQGYBMb49KTsog==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795038372;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=g8hJUW8k9/1y8X5MN/eBod+qYzDutxNpSrziYxNcDJA=;
 b=E+SJIY6HEgSdhcrSR7XkXsQMEsPzpTAP1u5ZaXSQXMbpA4IDwfGd4T4g/s11s86EOTWq
 pg8S/LDWzwdexFJuCatN+9J93f8ot/V4dkUhhI+OJKfvYhmE9f79wBJGPQUWoCIr3efvD
 jCf+1bMOkY/8AGG4Sav2VTunEETFTHAzRRlN8uLd0V//la/S1NHhIYZ2UV73h/9OAu39P
 EIj+WTPbAdruN892fG19XcKqqugKFB4pnCq/z5LYfT28wiEYXxuKqALUwrT/x6QbUFNiZ
 O8PRntdMiprNDKt+EQn4qQjyNYXO0uJAMGTfR8LrSN4Yv6ZFBDjLAEWDXNwQbqVUq/g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 033421F000C5;
 Wed, 18 Nov 2026 21:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795038372;
 bh=g8hJUW8k9/1y8X5MN/eBod+qYzDutxNpSrziYxNcDJA=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=Y8Ze3CRlrapT3GDGqoIprf601f9nnV7pwErsiND8pxKn45KbT8O0gBBHwR7FXmJpW
 Iq2KjIHS5wN9GQkJBAaqXhUZrF5MRBaGcGGZZ7//TBH8bbRgWGQJLIdtV+YRJRzcll
 CrjClB1141qD6BOr4ni9bYFWcOin4owi7kCWTBqFqSSmNm4m9tDaGSGlo2ewvmnqQl
 33vKzUqZt5drEaxm4L2oN7IW2rQT9Je4r0xfl67fg7lMZkwegsVYzm25E29M45wdwc
 y+khZXrD5EI0BYxfETfZnXzvRwSb7rkzlwcE6k2ZjrjUnpjBatd7iCrTUhuJr6PGYu
 5FBmPB3A2WIfA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 5BAA54AFC3;
 Wed, 18 Nov 2026 21:46:11 +0000 (UTC)
From: Joachim Eastwood via B4 Relay
 <devnull+joachim.eastwood.gmail.com@kernel.org>
Subject: [PATCH 0/4] drm/bridge: dw-hdmi-qp: Fix HDMI output on H96 MAX V58
 board
Date: Wed, 18 Nov 2026 22:45:27 +0100
Message-Id: <20261118-dw-hdmi-qp-bridge_attach-v1-0-e370920bc7f3@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrDtgjAr2KqWUcTKaEWptkv6Ae
 PfGuvwW760QJahEOBcrBHlr1MecYU4FsKd5FFSXDVVZtcaYBt0HvbsrPhfsg7pRbpQSsUey3NW
 WamJrIedLkEG///Xleji++kk47T/Yth+yBfWofAAAAA==
X-Change-ID: 20261115-dw-hdmi-qp-bridge_attach-a3c943a4ac33
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795038370; l=2393;
 i=joachim.eastwood@gmail.com; s=20260701; h=from:subject:message-id;
 bh=qLDl2nOQQVy/m8nqNSlwQuyIrbStxrYBTQwCyzrBpCs=;
 b=9dyeCuuLG9wmnoYux4WxkNLUiH/3VxZsRlAZiQq7Of6UPXjvjnq681SJWBJZwNzeHKI4J6H57
 45SuEbxG8ooDUEymXbnp91+IX4hdQOQVwwN3iOJMajIb+kq8tuIjfGH
X-Developer-Key: i=joachim.eastwood@gmail.com; a=ed25519;
 pk=ZN/8xWtdYaSd5oEfloYSZ1a+/ri0n0VZqjlEeHlbXFU=
X-Endpoint-Received: by B4 Relay for joachim.eastwood@gmail.com/20260701
 with auth_id=846
X-Original-From: Joachim Eastwood <joachim.eastwood@gmail.com>
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

This patch series is an attempt to fix the broken HDMI out on the H96
MAX V58 board. On this board the on-chip DDC controller doesn't manage
to read the EDID from the connected monitor. The root cause of this is
not known. I attempted enable pull-ups and lower the DDC speed but it
makes no difference. So the solution is to use a i2c-gpio driver on the
same DDC pins.

It was noted in the original submission of H96 MAX V58 [1] that HDMI was
untested but was assumed to be working. This is not the case, and
Armbian have had a similar workaround for this problem for some time.

Patch 1: Propagate bus format to the bridge input. Without this the 
	 output would be disabled when dw-hdmi-qp attaches to connector.
Patch 2: Attach dw-hdmi-qp to next bridge in the chain. This allows the
	 driver chain to use properties from the hdmi-connector. For
	 example the ddc-i2c-bus needed by H96 MAX V58.
Patch 3/4: Fix HDMI by using i2c-gpio for DDC and enable HDMI sound.

I used AI assistance (Claude) to write the two first patch so please
give them a critical review. I am not very familiar with the DRM subs
system. So please provide some guidance if this approach is wrong.

Patches tested on both H96 MAX V58 and NanoPi M6. No regressions
observed on NanoPi M6.

Also note that there is no schematics for H96 MAX V58 so it's not
possible to see where they screwed up the design. No other board in
mainline require this type of workaround.

Based on drm-misc-next.

[1]: https://lore.kernel.org/all/20250108-rk3588-h96-max-v58-v2-0-522301b905d6@gmail.com/

Signed-off-by: Joachim Eastwood <joachim.eastwood@gmail.com>
---
Joachim Eastwood (4):
      drm/bridge: synopsys: dw-hdmi-qp: Propagate the bus format to the bridge input
      drm/bridge: synopsys: dw-hdmi-qp: Attach the next bridge in the chain
      arm64: dts: rockchip: use i2c-gpio for hdmi ddc on rk3588-h96-max-v58
      arm64: dts: rockchip: enable hdmi sound on rk3588-h96-max-v58

 .../arm64/boot/dts/rockchip/rk3588-h96-max-v58.dts | 30 +++++++++++++++++++--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       | 31 ++++++++++++++++++++++
 2 files changed, 59 insertions(+), 2 deletions(-)
---
base-commit: 17a180572ca50c8d38f3aa47d6fc81ce7c5594da
change-id: 20261115-dw-hdmi-qp-bridge_attach-a3c943a4ac33

Best regards,
--  
Joachim Eastwood <joachim.eastwood@gmail.com>


