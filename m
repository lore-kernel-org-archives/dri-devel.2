Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F48C982D2
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD91D10E5B8;
	Thu, 17 Sep 2026 16:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.b="A3Je9w+i";
	dkim-atps=neutral
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03D2410E4F6
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GwjPfRohhdWMpNDZekXkVDZdt75rLGMNzzHtRMExuBY=; b=A3Je9w+iD07MWNN8j9eztQJoil
 BYEq1pcUSFXqR16AQAU/69grvIs6rok2mujtdNf0UD9lHtib294AHSDW+1XDs6Nm3odOmy6ZuZCiD
 6Fyr2IxPv6q/3C22Ri/nfZoILQrD7DerLfu0e8qNBQMo51JwvPWblKYUVNAPIXaGAPEw=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (envelope-from <alexeymin@minlexx.ru>)
 id 1x7FDZ-0000000Bw3I-1fKx; Thu, 17 Sep 2026 19:44:17 +0300
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
Date: Thu, 17 Sep 2026 19:43:05 +0300
Subject: [PATCH v2 3/9] dt-bindings: display: novatek,nt36672a: Add 5 new
 panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-nt36672a-panels-v2-3-f8de8be5b86f@minlexx.ru>
References: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
In-Reply-To: <20260917-nt36672a-panels-v2-0-f8de8be5b86f@minlexx.ru>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: David Heidelberg <david@ixit.cz>, Joel Selvaraj <foss@joelselvaraj.com>, 
 Chintan Patel <chintanlike@gmail.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 phone-devel@vger.kernel.org, Alexey Minnekhanov <alexeymin@minlexx.ru>
X-Mailer: b4 0.16.0
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

Document 5 new panels used in 4 different smartphones produced by
Xiaomi and ASUS:

 * Shenchao panel used in Xiaomi Redmi Note 7 (xiaomi-lavender), the
  exact model string is unknown
 * Tianma TL063FVMC43-02 for Xiaomi Redmi Note 6 Pro (xiaomi-tulip)
 * Tianma TL063FVMCA01-00 for Xiaomi Redmi Note 7 (xiaomi-lavender)
 * Tianma TL060FVXS16-00 for Xiaomi Mi A2 smartphone (xiaomi-jasmine)
 * TXD TXDI600YANPA-43V3 Asus Zenfone Max Pro M1 (asus-x00td)

Signed-off-by: Alexey Minnekhanov <alexeymin@minlexx.ru>

---
v2:
 * changed description to mention several panels instead of one
 * fixed alphabetical ordering of compatible strings
 * changed vendor prefix of TXD: "txd" -> "txdkj"
---
 .../devicetree/bindings/display/panel/novatek,nt36672a.yaml   | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
index 5d16d85117254..62ec3294b9b68 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
@@ -10,10 +10,8 @@ maintainers:
   - Sumit Semwal <sumit.semwal@linaro.org>
 
 description: |
-  The nt36672a IC from Novatek is a generic DSI Panel IC used to drive dsi
-  panels.
-  Right now, support is added only for a Tianma FHD+ LCD display panel with a
-  resolution of 1080x2246. It is a video mode DSI panel.
+  The NT36672A IC from Novatek is a generic DSI Panel IC used to drive dsi
+  panels. Currently supports 6 panel models for 5 different smartphones.
 
 allOf:
   - $ref: panel-common.yaml#
@@ -22,7 +20,12 @@ properties:
   compatible:
     items:
       - enum:
+          - shenchao,fhdplus-video
           - tianma,fhd-video
+          - tianma,tl060fvxs16-00
+          - tianma,tl063fvmc43-02
+          - tianma,tl063fvmca01-00
+          - txdkj,txdi600yanpa-43v3
       - const: novatek,nt36672a
     description: This indicates the panel manufacturer of the panel that is
       in turn using the NT36672A panel driver. This compatible string

-- 
2.55.0

