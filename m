Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F86FC531F7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E051810E5FE;
	Thu, 23 Jul 2026 16:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="NnosTmB+";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C900310E0AC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 16:32:19 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 9F2951A11BD;
 Thu, 23 Jul 2026 16:32:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 748A46038D;
 Thu, 23 Jul 2026 16:32:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9EABB11C1122F; 
 Thu, 23 Jul 2026 18:32:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784824337; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=BarVgAGGeOvcPeeUBNpcflLHNBqaoPcGJM6mqXgOooc=;
 b=NnosTmB+6RyUpm4Md8ka5qAY+JH17gCvkyFwghVkSgSMzX7yH48jm8qYNYc+CpwnaEcqN5
 H5N3Y5e2vp5QnaooGHygoEnIXvgF7a2CKETgjWoUhJjM9d221ttk1QNdX/jadjslkxCGfj
 vvSRPWj2VrOI2dziKelRTlgmukPLiPa7khpsKTU27pQXXYLmBZ39uw27qHJoejg+Imz4A3
 LHiqL8JVVbi7k7YdlcsVmKQfDUgB8f6DdeGlMlglNkQ9rmsLk4DIsHKfuUPBKxDXfm6sX+
 q2/w38R0tgL5Morc1dWR5wwji6hOferv3lMpQ9NZK3YTQhrcuvZV647eZOPNYg==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Thu, 23 Jul 2026 18:31:49 +0200
Subject: [PATCH 1/2] dt-bindings: display: simple: Add Ampire
 AM-800480N3TZQW-00H
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-support-am-800480n3tzqw-00h-v1-1-6a4ae0575a19@bootlin.com>
References: <20260723-support-am-800480n3tzqw-00h-v1-0-6a4ae0575a19@bootlin.com>
In-Reply-To: <20260723-support-am-800480n3tzqw-00h-v1-0-6a4ae0575a19@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784824328; l=1016;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=/9wQhNpMRLbleeKLSRQV39PTddwcffZxQnPG9IReTP0=;
 b=yADaO0pzjUcifVvpUMJXtAEoCNvf2KtNfDAwCboRylnA2wXtGR3MZiye+0OvJECHuNEyinS5v
 RGA6wv8d5N0DASIgp/uSHNFCIULPcghnEjhMT8/KRrdk5YYgn0CLWJB
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
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

Add compatible for the AM-800480N3TZQW-00H from Ampire Co. Ltd.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 Documentation/devicetree/bindings/display/panel/panel-simple.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 21453f0d7ce2..3d1cc11ba3aa 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -37,6 +37,8 @@ properties:
       - ampire,am-480272h3tmqw-t01h
         # Ampire AM-800480L1TMQW-T00H 5" WVGA TFT LCD panel
       - ampire,am-800480l1tmqw-t00h
+        # Ampire AM-800480N3TZQW-00H 5" WVGA TFT LCD panel
+      - ampire,am-800480n3tzqw-00h
         # Ampire AM-800480R3TMQW-A1H 7.0" WVGA TFT LCD panel
       - ampire,am800480r3tmqwa1h
         # Ampire AM-800600P5TMQW-TB8H 8.0" SVGA TFT LCD panel

-- 
2.55.0

