Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B28606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=a3KaLGJt;
	dkim=fail reason="signature verification failed" header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=h3aJvplq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D655310ED98;
	Tue, 24 Nov 2026 07:28:38 +0000 (UTC)
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de
 [85.215.255.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B48A810ED42
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795505166; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=Jw1B75AZR9r37pV72wMrabDcm66aq2L5065KPSA7+H3MAYiJokwL8WkpOc9nz+yebw
 R52KxSfyLCxevdO0Vh8pWaopgVt/J02yGiDaBIB6s78KG8Cw2ECT9wwXtQy/Cs6YFWBP
 52n6H5Tmf3gt/V4h9LdxzvISaAR3h5L0YUZrrykv4jFZTsERFEVmePoddeefHXt3x8Qi
 Q6vfLOD7VIcAX+wmBGJ03w2GTeQI7X7EWk4X0hZ1TjO8IIA9us1kXkQ9wJ+sDLZet9v1
 /fr9JZG3lUVFuwOFPdrTWsPfGYBo97jxKTpKajsmHyBbA62ig030qEZYxeUInLca+gva
 ghTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505166;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=gAIN7iE4u/BQ8emUvIO6sNS6XCYcMUaeapeftYIyo6s=;
 b=jaC9A0CwwPT26qXZECMleSSd86xcXk5Mftx5phl5RznaJES9XY4Oqdo5LBu/C0RFhe
 rWTsfelWx9RZx9/mXcw1MEII7a8U+91QH9/PgjLwgawrjUooBBBgfVyEExMgSCbMlArI
 lMg+XWZs3fEyJ4NJeAl0iwqMsaxRnaSc1WA4Qd6g5+cVE3ZZw5affwnQWPx8liomLWHd
 XIuTDJjF4VCjY1m7deqIvYEtb5alALG/dLXWpsgRlZMeeS93qumVRRadmZwvCVbtlKyr
 /ikXjkqlBmfRFsI/TMtODweKq6fVI1XrojjSB00/JUfhc8x5SVBu9Sq3JOLlvuyBK3g6
 0bHQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505166;
 s=strato-dkim-0002; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=gAIN7iE4u/BQ8emUvIO6sNS6XCYcMUaeapeftYIyo6s=;
 b=a3KaLGJtVvMLsOwdQZUYs+7gK4y5yMMC88fm09lTN7l6NG9gu8eI8W2icosjN3MpA2
 bj6C07vlxiYwLcPYf5IkR78Iqaoz41qwEoq8WUwjURKL22gWnOuuuLOfP+HjN9KNrTaE
 Lei5ojY3O7JlF8Hc1MihqnTEvrTrPZzGN5IoK7krNf4CFQvSh+R5yxJUvoaRqaz1Yz9y
 3xagrdTDB3n0mDS1sZE14Sn+jRVds2NJ3y1yPheBCRhVQt2KRPv+oFiMFrMj/s+zUYTF
 LHIAzqKyk2qD+bUdyyGEfw1Wkhjx+3NfNr4ib/LP/UazcxgirFOK+s1ooMG1J/EIxaXo
 BulA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505166;
 s=strato-dkim-0003; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=gAIN7iE4u/BQ8emUvIO6sNS6XCYcMUaeapeftYIyo6s=;
 b=h3aJvplqETdwNO8kY5RutWsO9gupBKll+2yH2AoQUGLuJZB0vkQ0wtDTAaen7gHL8k
 5hFyXlXfUyNF6mSyn3Cg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box by smtp.strato.de (RZmta 55.6.3 AUTH)
 with ESMTPSA id Qb56a22AO7Q51HC
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 24 Nov 2026 08:26:05 +0100 (CET)
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
Subject: [PATCH v2 01/20] dt-bindings: gpio: twl4030: Document REGEN GPIO
Date: Tue, 24 Nov 2026 08:25:41 +0100
Message-ID: <21030cf6957c49c8114829970cf64c2638050220.1795505160.git.hns@goldelico.com>
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

Document the optional ti,use-regen property for the TWL4030 GPIO
controller. It exposes the REGEN power-management output through the
GPIO controller so that device tree consumers can control it using a
GPIO specifier.

The property is opt-in to preserve the existing GPIO numbering for
systems that do not use REGEN as a GPIO.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Replaces the former REGEN regulator binding following Mark Brown's
      recommendation to model the control signal as a GPIO and
      Krzysztof Kozlowski's binding review.
    - Expand the binding commit message to explain why REGEN exposure is
      opt-in and how consumers use it.
    - Commit-message review assisted by ChatGPT.

 Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml b/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml
index 96d50d14c0710..25ba4328ac2d0 100644
--- a/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml
@@ -47,6 +47,10 @@ properties:
     type: boolean
     description: Enables LEDA and LEDB outputs if set
 
+  ti,use-regen:
+    type: boolean
+    description: Enables the REGEN output as a GPIO if set
+
 additionalProperties: false
 
 examples:
-- 
2.56.0

