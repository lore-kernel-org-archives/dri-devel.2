Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47546C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 20:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD6B10E0FB;
	Mon, 10 Aug 2026 20:26:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B6zbm0Ww";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709A110E0FB
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 20:26:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9010E600AF;
 Mon, 10 Aug 2026 20:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 377BCC19425;
 Mon, 10 Aug 2026 20:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786393596;
 bh=+rRZGWkOPwgSd/A3Gd2WBWuoa56lNnyZ5hnzluMF+3I=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=B6zbm0WwgZG+zH0XtSyPcDPZGK59sqRXAeZE9H38zbCdef8DKtQmPNupikf1iLvj6
 joLYzPcjAaOdRRU7zH0e0TCC1cUDuZhCY4oFBjrfD3vUKztA67BgV/sShkJaYg3EQO
 tkyi9rfdV3Ur+KVeDVAH7+8IqjPlvI7kQGWZus0wBXLkqNcBPjRVN81Rr0dSGSxQtH
 6fs9Xh4JOUbakqfLWiS6vmizTtlIzaPngJNAwzDIFBxt0iXummCI5LDffBT/vgPOaF
 ydNHwSkscZiWNgveVdXmM2sxdEygIZT7NWqybd3tQaCWLYSAr8QzdCJZVnkPjTSmxt
 u2W+/z+m231Gg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 109BAC5AD7B;
 Mon, 10 Aug 2026 20:26:36 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 10 Aug 2026 23:16:19 +0300
Subject: [PATCH] dt-bindings: gpu: arm,mali-utgard: add mt6572
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-6572-dt-mali-v1-1-fb908627bf23@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0MDXTNTcyPdlBLd3MScTF2LJEvjJENTy0SD5FQloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loA1qQsdXAAAAA=
X-Change-ID: 20260810-6572-dt-mali-8b93b159a0ce
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786393594; l=1015;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=w9n8g0GvmLHdo4ZTDe8Qbd8jCW9LIeOjEpTJ03K8T3A=;
 b=Wl4b7fBK2XQcGb9Kc4Pqrn9gaLffzHfZKwfl+k10TPwS5Q3Y5WE+9SGFjVRrpTZpsY/d731yr
 uFMh1XUT+M7Bp5ULqe8NWew9WYkdx+wB/eRSn4u3ghdHyY5Eun7sMYb
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
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
Reply-To: rva333@protonmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Roman Vivchar <rva333@protonmail.com>

Add a compatible string for the mt6572 Mali-400 MP1 GPU.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
index c8d0d9192d92..6bdbab82126c 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
@@ -27,6 +27,7 @@ properties:
               - allwinner,sun8i-h3-mali
               - allwinner,sun8i-r40-mali
               - allwinner,sun50i-a64-mali
+              - mediatek,mt6572-mali
               - rockchip,rk3036-mali
               - rockchip,rk3066-mali
               - rockchip,rk3128-mali

---
base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
change-id: 20260810-6572-dt-mali-8b93b159a0ce

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


