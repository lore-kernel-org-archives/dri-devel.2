Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C667C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 06:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA91A10E5E5;
	Sat, 12 Sep 2026 06:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="WOeEfcpF";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="kUmk15fQ";
	dkim-atps=neutral
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3273010E5E5
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 06:52:28 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 0B4207A009B;
 Sat, 12 Sep 2026 02:52:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Sat, 12 Sep 2026 02:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1789195946; x=
 1789282346; bh=2mKKiQO9zpo513ebYoXsjxDsShdmIQsmiSfHdP5Kuwk=; b=W
 OeEfcpF2CserbKBFBqwfGzoEVFzmFwt6Xee+pVLHWhHJy2p83GBI4113eRlu/AkB
 eOqn7tl79HBnf/svoO+LKD1lDw20C1SEZfyBn8EcuIi260cn1c4zIdMPpsFIobxK
 aMZyhOgRfMxb+qmoTugxZ3xmsRwHYwb/IoXo7kWhN2fqct+2WgPKwbvZCGj0l+Dc
 xNvOZV/chGFTFvhZ2iDS2Yt5vCkDfRQ6Ys5d8OuS3/fJVXHPsZ+7HLzeL9vhz3i3
 NEFEy1ofsfW99qzO4s0U30HA4We6BBBniFF2eml/suTc3+z4oLW0y0oMPqsOEBOF
 ifYDRLCH6LiHj30nqrUCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1789195946; x=1789282346; bh=2
 mKKiQO9zpo513ebYoXsjxDsShdmIQsmiSfHdP5Kuwk=; b=kUmk15fQ444zlWr7O
 6iUTtv7WXpcUaCfqExLOJqtwB7+ONzzFYC8SDNhlDK5n0euAXC4v4fpfgggNyc5d
 A+FZqlYZy3MTJjE6CN0fQ9bMafPrRGazi82IjFamzINSqUwavLRoeyLUJ/vVfV+7
 Z8FlkD8Hcy6EfVksMiqU2H4TP+l6nJPJfgPuYRD7Km7PrB0DFQQ4Ap2Bqqk09gaD
 f8Eo3RLv+3SpV0PptFc1Tut83BgfT1swJ+ubE9gB+AAaEIkoavWG9d2PNVpqXz+W
 lmiu96ODDqK42TrhB+6ZlBBEOh6pF4M+WaB2cmkJ3F5Abxzvs3ojOaRDaLEwDMQ0
 PE5rQ==
X-ME-Sender: <xms:qvakahLG7Zsq5uNUPDMSaT4ek3_NXWN1r7F8uuCC6ELIXMpLHvSurg>
 <xme:qvakakGDXDKobHizHc6pVMmm3PvW0UEARRXSr-_kul8my8LOq48SHyHhrpmjtEUUa
 539aGWO-8reCCVDD4GUhfQ3C9UHfC6C0h4aeZGvsJVXFAl3zKElPKKo>
X-ME-Received: <xmr:qvakagL0_HgHN0AUaUkk0yrxa3UK23GxWY_PUoj2V9u03R7acjD7ISc2uN8dnStnqqsqikQw5A>
X-ME-Proxy-Cause: dmFkZTEu1UivQs0afaRwUSouQVT9fA+dkflD6xboTnJ8/VAbYbVKvUN4MK/f41UbmxFFxr
 Ze/lAcGl5aaDrgNdh5RizAYp6gZ1Fmr3KCjz7zHDD4cOn39vzVmTzK5WxaodNDQGOkfvgV
 TdFpznrAgjbTayTTszyCWlN72zMOkFQpdze8A+hMde794s2VEYQ8toT2zFE5mRrYgzN6+t
 tk2rE/tKTqe3b+QIO1iV7bQxdgYWyGe9yctTl5iCm6FOwVGrXz7LH6jTkXm+ksK0e2c6Ew
 aHyzLoG7vkGqykDqvyMzIEE3oCVwgpZfOgFBq2VtY2d5nhXH0wGpaJHM0aFW6G+GK5/an7
 ABdJM2mkn8coI7hbY5QaeQJJcbb6abS31gkUBP1Df2UTH5O+bK+tcVlG34lPX6IM9EMARG
 qdkIZ/9s4Ena7Mxqnq9A7v9P8MhDgn8OqlJPoM5mR7gboWWNSVsxjsFHptXLEPpI8M5Axs
 aaxkL/GEs9YLYxT1kddzJd/13YSn6bvWjjINzPidBffWTVXf+YFnptR8pGDNakp4CANzRA
 2YnuMmaInjfz6OhZPl4fCEMBKy+oGx5X70msLejX3SzJATH98c0imNiGID2a3y0SJYjA88
 FaMNspF4xqoPbZSrmYmgO9jvvuEdRbobE/K4SyMnFrUpMoy7dAcZw1IWJ16A
X-ME-Proxy: <xmx:qvakag66OLaKw9Mh6dSSjuUw5FhWMmYvJXokf6FDYbOyj9xihJrprQ>
 <xmx:qvakapn7_GOEco6BnXD6Se98J9a8U1hLs06-D8mCXpWmPJrFWeu1_Q>
 <xmx:qvakalQsbcHIRTdJDk5RL20kdoWFmtD9r3_vpg7X2jK2HSQKH_mLUw>
 <xmx:qvakamiakQEKK9BP8gE6NFARkJA_cWs6z9-QGyEeHwcX1fx0I7Ps0Q>
 <xmx:qvakam7eErEAITfYNKGO5ocLRS-CxPbbxrViPKIEVUWcnJwDNl1x9jgI>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 02:52:18 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v12 07/14] dt-bindings: power: rockchip: allow resets in a
 power domain node
Date: Sat, 12 Sep 2026 18:50:46 +1200
Message-ID: <20260912065053.1519165-8-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912065053.1519165-1-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Some domains do not come up in a usable state on their own and need their
resets cycled once power is on. The RK3576 NPU domains are one
case: without it the first access after power-on takes an async SError.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/power/rockchip,power-controller.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
index b41db576f..83741f048 100644
--- a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
@@ -136,6 +136,13 @@ $defs:
           A number of phandles to clocks that need to be enabled
           while power domain switches state.
 
+      resets:
+        maxItems: 1
+        description:
+          A phandle to a reset that needs to be cycled once the power domain has
+          been switched on, for domains whose logic does not come up in a usable
+          state by itself.
+
       domain-supply:
         description: domain regulator supply.
 
@@ -216,6 +223,7 @@ examples:
                     reg = <RK3399_PD_IEP>;
                     clocks = <&cru ACLK_IEP>,
                              <&cru HCLK_IEP>;
+                    resets = <&cru SRST_A_IEP>;
                     pm_qos = <&qos_iep>;
                     #power-domain-cells = <0>;
                 };
-- 
2.43.0

