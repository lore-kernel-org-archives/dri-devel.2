Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC52C55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9387510E6ED;
	Mon,  3 Aug 2026 16:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ovCWdIhM";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C0DE10E6ED
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 16:05:40 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47f6981d244so181440f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785773138; x=1786377938; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Orw1gQutvOkZopO7ifTGK4f+dabsbqDeP0c5VLSqs1g=;
 b=ovCWdIhMNerQjo05huIc54muNRpSOPFlpZWbRA6SYCxbI1q5JyI0uXLYFMaHwCitPM
 tWzppodtIbAtTm281qfmSt9CIp+gNFJud70x+eElhg9UmXpnIfN9tS2kfnqoCuT11nao
 UsKBiHNTJEZCnUFgY+o5MSh/Po3Aiw+35neZuvJ9Sq7cf+UaVeX39AlKvgMLXBp+bRRl
 YFlc6uRU1RFFJZ4T7VJDbXzTDn+cVCBkvNDVtQoATotWRB/A/FsvsO9i5eieXztBj4Tb
 LUhU6pfX910n0Gl0Llg3DjPgOzCU/nVWzAXGnu7uTuI7mrtNgljD20l+Ic8fWKDCIq5j
 vt4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785773138; x=1786377938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Orw1gQutvOkZopO7ifTGK4f+dabsbqDeP0c5VLSqs1g=;
 b=iNFKgvo2oefmDZBsqjz+O32RF6Xv7wYVD8aliY/5+wDFi8bvZlMg3l2q3+E9XLguhU
 Wmpc2Z17MC2E8awcRTwB1pa5TlmEJfFVu28FKdMW5cLDWdXHpZyiLAtQHC+6xG9iqPK/
 FPgHm0JMBkpwvt8TR9fW+4DSTX6ly/67yn4pqilgbOVxh85SBuMdqlqRUHxxvh3J195/
 H+2YUUzyiIWCedSzDBcUobxckgDm7gsj53kfU7kwv/hdW8q9jDj9J+I9x2gKMakvmVpP
 kcwHTz6nKH6R4gZ0505Aghzvpi1PmtOR32K5HJRlBtrIP3aNAR/tpufulHkWm1JXkJk1
 sJkg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKd5yRWhZwbI4OiuOlbmWYliCOwvdZkSrlTFl9xxNz4xb9DLL3qrtlS3X35Fo3J9J0X+Z+mRah9LI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyznPE0KgVjoOgLaDYrp8BvZU0n1izNFG/IGKbXXwtnC8+Gb7jF
 mk1jIdRUvOG7YUoUIiLfIpblcurEphZDyxwyjyAOLyYiAjaeXuuadwoI
X-Gm-Gg: AR+sD12Vm/IdYtG4bnKeHnyAn0QurQAeh1CTZH66PTc/sPb5jK93xlXykyI6lxaMw4y
 eRjJm+1PVqMMWq/8k1auVMtPz483IdNA5X+6NGyhe5v1p9R2QcJllbRlLBYd5z14DesdbQHrtig
 Ao6QZkoWA3sgY6vkToG/iqyVm+vk41B62jOSoshgjJdnCu6N1r2lYGqOYjTZbMRzfEameWJKFv2
 nx4//yZF8nEBilyC9LpueYi/sHgzDu65EVDkigGfnYKUmYBB7k8NlSGQrrMhELr30Xoz8skgZpE
 HIN0PpxqH0k4WJoIov0wefPs4ymslb9JTjIVL5Kuedu5IsfFgohy92+I5nBSiOW3rBmThi6ytm1
 hFqME3AGXhjgkj4SF1oMCZhlp78drqc31+REAsa76tKeRcsmZEo+9fy97JTeFcmbbMEkTUXyMyD
 VuY/9zlD9OM+vJ9MnlIGVE22k5dpJFmck4jebabGvv9X/3ZrIlPLgt96WAT++HClYDWMvDiQYl5
 e6FLniO3GS5cSzqoKhk4oS2PGL5/WnOKxUoo79OvBXL7apeox63aLufLeSiUJrjArxZ
X-Received: by 2002:a05:6000:61e:b0:47f:4d11:3472 with SMTP id
 ffacd0b85a97d-47fd72a00e1mr15561662f8f.1.1785773138178; 
 Mon, 03 Aug 2026 09:05:38 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B85F300A5CC0DBDABDC4661.dsl.pool.telekom.hu.
 [2001:4c4e:1b85:f300:a5cc:dbd:abdc:4661])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd458b73asm31953719f8f.29.2026.08.03.09.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:05:37 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org, alchark@gmail.com,
 chaoyi.chen@rock-chips.com, krzk@kernel.org, will@kernel.org,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v4 5/6] arm64: dts: rockchip: rk3576: add NPU (RKNN)
 nodes
Date: Mon,  3 Aug 2026 18:05:21 +0200
Message-ID: <20260803160521.14621-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803094125.3285895-6-gahing@gahingwoo.com>
References: <20260803094125.3285895-1-gahing@gahingwoo.com>
 <20260803094125.3285895-6-gahing@gahingwoo.com>
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

Hi Jiaxing,

Following on from my note on 4/6, since a v5 is coming anyway: rknn_core_0
as written here does not validate against the binding 1/6 installs. 1/6
adds the compatible and the conditional sram-supply, so every other
constraint in rockchip,rk3588-rknn-core.yaml still describes RK3588 only.

I put your node through dt-validate (dtschema 2026.6) against the binding
with 1/6 applied, macros resolved to plain numbers and everything else
left as you wrote it:

  npu@27700000 (rockchip,rk3576-rknn-core): clocks: [...6 entries...] is too long
  npu@27700000 (rockchip,rk3576-rknn-core): clock-names: ['aclk', 'hclk',
      'npu', 'pclk', 'aclk_cbuf', 'hclk_cbuf'] is too long
  npu@27700000 (rockchip,rk3576-rknn-core): power-domains: [[2, 7], [2, 8]] is too long
  npu@27700000 (rockchip,rk3576-rknn-core): resets: [[1, 20]] is too short
  npu@27700000 (rockchip,rk3576-rknn-core): reset-names: ['srst_a'] is too short

The last two are the ones easy to miss: the binding writes only
"resets: maxItems: 2", and dtschema fills in minItems from maxItems, so a
single reset is a hard failure rather than a permitted subset.

The v4 changelog says the reg entries were cut to the three the binding
defines after running dtbs_check, so I suspect that run predates the CBUF
clocks and the second power domain going in.

The fix is the same allOf shape you already used for sram-supply. This is
the diff I tested, on top of 1/6:

--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@
   clocks:
-    maxItems: 4
+    minItems: 4
+    maxItems: 6

   clock-names:
+    minItems: 4
     items:
       - const: aclk
       - const: hclk
       - const: npu
       - const: pclk
+      - const: aclk_cbuf
+      - const: hclk_cbuf
@@
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2

   resets:
+    minItems: 1
     maxItems: 2

   reset-names:
+    minItems: 1
     items:
       - const: srst_a
       - const: srst_h
@@ allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3576-rknn-core
+    then:
+      properties:
+        clocks:
+          minItems: 6
+        clock-names:
+          minItems: 6
+        power-domains:
+          minItems: 2
+        resets:
+          minItems: 1
+          maxItems: 1
+        reset-names:
+          maxItems: 1
+    else:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          maxItems: 4
+        power-domains:
+          maxItems: 1
+        resets:
+          minItems: 2
+        reset-names:
+          minItems: 2

With that, your node validates clean, and the RK3588 example in the
binding still passes, so nothing loosens for the existing SoC - the else
branch pins it back to exactly what it has today. Take it as a starting
point rather than a finished patch; the DT maintainers may well want the
per-SoC clock list spelled out differently.

Separately, and this one spans 3/6 and 5/6: the resets you add to the
power-domain@ nodes have no binding at all. Same test, against
Documentation/devicetree/bindings/power/rockchip,power-controller.yaml:

  power-controller (rockchip,rk3576-power-controller): power-domain@7:
      Unevaluated properties are not allowed ('resets' was unexpected)

$defs/pd-node there defines reg, clocks, domain-supply, pm_qos and
#power-domain-cells, and every nesting level is unevaluatedProperties:
false. So 3/6 teaches the driver to read a property the schema does not
admit; that patch needs a binding change of its own, before or alongside
it.

For what it is worth I did check the DOMAIN_M_O_R_G to DOMAIN_M_O_R_G_W
rename in 2/6 against mainline, and you are right that DOMAIN_RK3576 is
its only user, so nothing else moves.

None of this touches RK3588, so it does not change what I said about the
tag on 4/6 - just worth folding into the same v5 rather than finding it
in a v6.

Thanks,
Igor
