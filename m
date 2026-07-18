Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC1CC44521
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86AED10E77E;
	Mon, 20 Jul 2026 07:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="Hs7ICPbW";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BDxbqMtb";
	dkim-atps=neutral
Received: from flow-a2-smtp.messagingengine.com
 (flow-a2-smtp.messagingengine.com [103.168.172.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C607810E50E
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 03:21:34 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailflow.phl.internal (Postfix) with ESMTP id 7EDB51380146;
 Fri, 17 Jul 2026 23:12:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Fri, 17 Jul 2026 23:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784344332; x=
 1784347932; bh=UCG8fvidilzM1GejavT5xbtTJbTNjNFqZ35DfgSLpyo=; b=H
 s7ICPbWclADpKzM7SOzxdMS85tIMoFCS+H9Oa91PI3V7Lq8NqdxUxsHyaNGFcDuP
 pjfw3IVtoW6eRUeGPKtbzbZp+o5Xv3vcDyKuIo7hiTXjjpZnGJhyuELMEG/AKE9V
 aYbc4cGDCaUhtf6mEhTwKrJ4Ik6KOJyoVP9yerqgpJqBRaFyBWnfNFib6WO0aNd3
 N+mBCGk8R7r+GJQYcuM9AoJ2lXaY0uFNa9X4qCcP5f4Kd0/2JlvTOBrSQsFCOFhw
 wOPNzX1S6h062zjLiGEGBk9NQxrJF92qR7KPwVerbaMQ3Tk2T67AnEu2NfZrEr30
 5sllP42BFgr/RnkUD2j/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784344332; x=1784347932; bh=U
 CG8fvidilzM1GejavT5xbtTJbTNjNFqZ35DfgSLpyo=; b=BDxbqMtbmsBBiSeAM
 dGLaRH6CPZ0yoQDomAEpebDoi/Y4YvyOf+NY/HUJh/Z4KvWAe1SLfig8QfV1Z2Uf
 GiEQLIHUt+/LrEgKi7x3xYkCogKsMK+m6e6ZvxzjL+HNyTz41U1n0TLRsZYRWDeP
 ozwKWF+ghgPaTUgNf28WUTX7NxgRLa+dN2lAtwXHgT4UdTMwk30kXX521quMSCf3
 EAxTQtqjGFu2UbdTcSoDDJcTC3x2ElZny3p8Sfg07Dnh9K+uT0TNV5GAxzao+Bi1
 HuzArY1GrI5r8PVIB1ADjOtJM2411p77wkycsaI1lqCgdHPwwmUTFO8leNpVoV4w
 nrr9w==
X-ME-Sender: <xms:DO9aapvVOgbUTUgH6BElG7TyZwDd4zneFI6kvmkL8V6cwsbLJxqxxw>
 <xme:DO9aai3p6KEMxEEmVZhJFgsGin3v3EHXALB-GrPRik1i0NL9QUvyVHGy6unxzwqB7
 jJmEN22KT27ds7YNTtuPPoY7BuBuw_FX4zb5Uwy2xEDcMF2tvUHY70>
X-ME-Received: <xmr:DO9aat7D36sbXY1a5xN5gKs7iTH-SinjJafuiggLpTOkV704px5yfmkq-m6hMFTSrseul8UUOyrZC3QR-ys>
X-ME-Proxy-Cause: dmFkZTEMX89gCC44dqObrbulQ/I2vRcOyTSU2dL37a8Nf+rFxjy5PE8WS5gpE9RXw7+0PS
 yxUIuQ6gupe5zEJJchZQE4bKfFbHmQL7INM15u9ExRdXgkO57kNGwURGa++uDEBsULgTHI
 t0ZbzRzarKEWrP6K0r8ac4f1j9EfeJOBqZIOuHi65D2zEb8+Hr9A3pyCOeN8z68LWwn2cR
 nBEqlZGvm1NlJl0MtKgrU7cphGYeMLoNKly7LudZuf9EOf4mYb3xk/iIY0lHGtBrmlZsu6
 7UYsbLPlBovD5Ne0jETTe/ihY/4xpQnFOtQR8dx/YbbAYNmrYk14/xo0JBShoHg0ykTltN
 c20LUTZ8LOiSlZ0WWvVhsPpriaKAEy/uzGovc5fgwebH+vAoRmLlr0iSthV0tEFsniH7EX
 I+D/UAPw3cHw4AcjmZD3+QM/3RNcEHquVRYTFa5/iOvQxeDyvz1ag7o+zc1DGMoxTIVfmQ
 D2pbnsLDBQ+ZwkV6Fb22XDcGG/SXUHryD/tC9CN//PkJe4n6U0/COHGwkzOlycvpczsaEs
 YERPVyFRxBmpaXq3OTAuEXufkJyJ4CNzxKkA0Z2uGE198R9bUgu3TiVI6A+aF4HO3oLOKr
 DWXNSg20RkOs7I8cpuGoT0qQCVaDX8OURUBN1fbezcwOZeIhO9MG3zKtcGnA
X-ME-Proxy: <xmx:DO9aasOKuepXKVDbh_ReX_VbNhj8Fnso9BvgvvTKo9aEnXub_BYJiw>
 <xmx:DO9aapFLnkTDBtUIusGvDO3Yct7NYQhWXzhUp3L04xVk0hiT791wMw>
 <xmx:DO9aao0asoH_mPysJyPgBm6Yqtt6Ure3NYL3w3iKZSufeM2u3ktJng>
 <xmx:DO9aaoGZ0ULR5TqytRXDXk7u3p4jdvW5rTSYGIfParUSHgmCYplE5Q>
 <xmx:DO9aarisc9wLea6u51EEq6R0mAHq4N__d3XfBleGAvOUE9Qzhqdeear->
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 23:12:04 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org
Cc: chaoyi.chen@rock-chips.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v2 1/8] dt-bindings: npu: rockchip: add rockchip,
 rk3576-rknn-core
Date: Sat, 18 Jul 2026 15:11:39 +1200
Message-ID: <20260718031146.3368811-2-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718031146.3368811-1-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

Document the RK3576 NPU core: add rockchip,rk3576-rknn-core to the
compatible enum.  The RK3576 has no NPU SRAM supply, so make sram-supply
required only for rockchip,rk3588-rknn-core via an allOf/if-then instead
of dropping it from the shared required list (which would have weakened
validation for RK3588).

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 .../bindings/npu/rockchip,rk3588-rknn-core.yaml      | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a490..985cde6b2 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -21,6 +21,7 @@ properties:
 
   compatible:
     enum:
+      - rockchip,rk3576-rknn-core
       - rockchip,rk3588-rknn-core
 
   reg:
@@ -75,7 +76,16 @@ required:
   - resets
   - reset-names
   - npu-supply
-  - sram-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-rknn-core
+    then:
+      required:
+        - sram-supply
 
 additionalProperties: false
 
-- 
2.43.0

