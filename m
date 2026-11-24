Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99119606A6A3
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=fROvGnzB;
	dkim=fail reason="signature verification failed" header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=H5IWVszY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1E010ED18;
	Tue, 24 Nov 2026 07:27:27 +0000 (UTC)
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de
 [81.169.146.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 388FD10ED45
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795505169; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=bIiaZG0aB1A8EglnZPzLotr0APPVW+C+JttAhWgICeK1uivIxOxrQ3tY3MQ2NmCbSq
 5MK0e+w6jhhlBqw3diP5fp9kEtkvG9L1JRX2l8cLJaddsIqTo8K5hpds2e4Hf2GTfFz4
 uQcmzSwFw4Ug5txQ8lN/B+HCLwiH/64z2ztYX0pvnRgLPkkeQdGF5Fbn28R1OrXrd7yn
 2k5nQZvCDncZjPGC2JoVdAYNmN2bLNBaYMy9Nd0KniZvAsoSTB752DXCduiwkeaAzhQL
 oVwycnJekINI2m3gDW/iz69h0pqiphtUEeFI24tkg/7nPLeHOKud8q2hxazd2kgBpVCG
 7kZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505169;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=d9xpumlCbgaIU/3xB5JAGANrE1Hm+hxXtNW2reVreRs=;
 b=aPabauCX+WGDUQJXlMAX03F/Wb+Sq18WrA4ZCBukx9c4PduStiynt6VO5IPt+MoffQ
 uGsdWN7JRBa6lNOuKgoMx1ZfI1Ibfcsm6PckPJz+abSD0KSCVbp9wVprM3eBFxtFMiMK
 YVQk7oQgel4f+0xqBaXULmf/kHeUJCLE9nh2iy7LgeLeTyg7OzG7WIdZWIpkqWcISxqa
 7oXnvi6jmBw2FS8NX3r7vPlrGjR1iweiZTRwWxgzkAj1f8eVqptrGh8f8/k74iY3JVWw
 M5YW3BIYJSamSuPZDcjLnAMLuKW7tqtTAZ9FZY/olSbwjXi46NEO9qggp+z9lfhTc8Lt
 UT5g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505169;
 s=strato-dkim-0002; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=d9xpumlCbgaIU/3xB5JAGANrE1Hm+hxXtNW2reVreRs=;
 b=fROvGnzByh/J1FZLbReBn/Lsyo2c8cGB6I99GEWTrbblCQl7YqqUXVTvepg1IGzivx
 paENMFItZfi/1hp17JvbIx082Xux6CtV0zaZylkpeDrVX9aghrPqzh/AFR5AnjqAWREv
 7ytbW64OB/7xGE0wzGknonmpya0LLnlmtkIsr2RmmGHi3oJYKOz1g6hlf6jqJwcI/y9a
 YhkzsY6/2WaTWBQeiAt/SoDJqogD7f5//hbUVWQpN75u6fr9EUBPeGyWxMyW4AfTp+1l
 XGn2PBqaNfllfHm6I2e0389zqNl87Xu5+pXZkceigSaB2z/YZAeMWwjN3jg7mKs1hZO2
 M8Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505169;
 s=strato-dkim-0003; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=d9xpumlCbgaIU/3xB5JAGANrE1Hm+hxXtNW2reVreRs=;
 b=H5IWVszYs9rjCq5iy4gaYkFOMYQqGb46RRw6KMSLbr9oqCLpTNyDiHhtUuXTimbx50
 ZZ+KaIYgQul+9842OgBg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box by smtp.strato.de (RZmta 55.6.3 AUTH)
 with ESMTPSA id Qb56a22AO7Q81HF
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 24 Nov 2026 08:26:08 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Helge Deller <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org,
 kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 04/20] dt-bindings: sound: pcm1754: Describe PCM1773
Date: Tue, 24 Nov 2026 08:25:44 +0100
Message-ID: <a92d44c4ba920358003d475d4cac7541af037f41.1795505160.git.hns@goldelico.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend the PCM1754 device tree binding to describe the related
PCM1773 stereo DAC.

Add the ti,pcm1773 compatible string and an optional enable-gpios
property for the PCM1773 power-down input. The format-gpios property
selects the hardware audio format.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - The standalone PCM1773 binding from V1 was replaced by an
      extension of the existing PCM1754 binding. Address Krzysztof
      Kozlowski's request to use current bindings and validate the
      schema, as well as the DT validation failures reported by
      Rob Herring's bot.
    - Add the rationale for the compatible and optional enable GPIO to
      the commit message.
    - Commit-message review assisted by ChatGPT.

 .../devicetree/bindings/sound/ti,pcm1754.yaml          | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,pcm1754.yaml b/Documentation/devicetree/bindings/sound/ti,pcm1754.yaml
index a757f737690c1..ee2ebd819db00 100644
--- a/Documentation/devicetree/bindings/sound/ti,pcm1754.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,pcm1754.yaml
@@ -4,10 +4,10 @@
 $id: http://devicetree.org/schemas/sound/ti,pcm1754.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Texas Instruments PCM1754 Stereo DAC
+title: Texas Instruments PCM1754/PCM1773 Stereo DAC
 
 description:
-  The PCM1754 is a simple stereo DAC that is controlled via hardware gpios.
+  The PCM1754 and PCM1773 are stereo DACs controlled through hardware pins.
 
 maintainers:
   - Stefan Kerkmann <s.kerkmann@pengutronix.de>
@@ -19,12 +19,18 @@ properties:
   compatible:
     enum:
       - ti,pcm1754
+      - ti,pcm1773
 
   vcc-supply: true
 
   '#sound-dai-cells':
     const: 0
 
+  enable-gpios:
+    maxItems: 1
+    description:
+      GPIO used to control the PCM1773 power-down input (/PD)
+
   format-gpios:
     maxItems: 1
     description:
-- 
2.56.0

