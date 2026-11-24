Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D87606A334
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=FPCCTua1;
	dkim=fail reason="signature verification failed" header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=+jAyDf5q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFAF10ED82;
	Tue, 24 Nov 2026 07:27:33 +0000 (UTC)
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de
 [81.169.146.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 954A910E221
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:26:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795505174; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=aVMZq2aA4paRGrZre+BQk8rtHFWnjoo4xmk/6fYITawlv0xsl6JZQi75t8Jpgg2qr/
 RSgVv22lumOuXEF40OB70aivTjdZfyV2KeHSXsSIg1g+cwf4iin5vlU98XY7uzsfl5A8
 5sok5uQjHQeqdNt5uMok5/a5znFV4W8EbUhcGf6bxgTVgr4LCiJjsvhIP6xLqO9VwRAl
 LQoK+NrC3d8s+nzA3MFdeRA1klEyA3bOSaxTvS382peFQDXYE7jp1I6QnTNddHsioZPg
 /t+KpdZirzoTjhw1zGRfjKD6QZShXTwsQAC++nU2JjjJfpSy7nem5+hE1vK0B/RiImv4
 a7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505174;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=fsG/cb1SFdTpwbZba5DZbm5tdFhUsr4K7XbXBN0VQ1M=;
 b=OtneZ4Kh3qegj5LZQX0tayQiuJbGJM5fQQ7igI0k9doE++Yld/Ya3EBzjsRdJ8iFRo
 1ZN+L+CdugYLdoz2OAsaP966f/k52X1//9kPZLgwCG/dMmW3mMfYRudQboI1OCb4C1R+
 aanyyc9aEFTMGIHba8RVTOiILU3ia2RVqlEYDecH9TP0NUnhav8ikoRQN0NfhJ62FR3M
 mmy9MeTvUEWaVurDqt+ecIaXvb7ripkdUGa4e05H2wu6gJK1i6Pn/hflISf/kxGMj/Jw
 JpCMR7tNLNmq3m5U6iC6yLGxY1pZkZ71ENlLopR9ixdb/H6HsPDeXYTLYv05KpGLOiqr
 /9oQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505174;
 s=strato-dkim-0002; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=fsG/cb1SFdTpwbZba5DZbm5tdFhUsr4K7XbXBN0VQ1M=;
 b=FPCCTua1pAXZDyqEk/kKrOuUKTpay15WdzNHD/NNA024Sg7+XLJj6JDbzo7nBDljco
 WAMu3NSaIusKwP+JgSX11ssYgy+CDoy/fpKE77mxCLWybSRzZjHHVjd/OKEXOF0Ew/2S
 9l0bODVNwPGGHvljs/NxVVKAsceEAaBpEGOqWCa9ifqJHzStVLanAfMxEmjIArHnEDCJ
 jnjnPataADNPp7HZJsLDaP03ZwJM/eOvdtkGxe9qzHG2YZiG+2Ko1LDkRe5axxJx9Eh7
 Op+etpep+A63cZPcZbT5TKwswpY1/ch9NlXtJLowA5xUFkebL+j4r7aTGbX5pswDztqQ
 u1FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505174;
 s=strato-dkim-0003; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=fsG/cb1SFdTpwbZba5DZbm5tdFhUsr4K7XbXBN0VQ1M=;
 b=+jAyDf5qshztbVQMVLZQymw6VyPta0x1nuBSoiAg4Gq+Ha5Wyhml76un2wv/8PU/d/
 Lk57Kl+Y5y2nbYYrM+DQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box by smtp.strato.de (RZmta 55.6.3 AUTH)
 with ESMTPSA id Qb56a22AO7QD1HK
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 24 Nov 2026 08:26:13 +0100 (CET)
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
Subject: [PATCH v2 08/20] dt-bindings: mfd: twl4030: Document 64-cycle PWM
Date: Tue, 24 Nov 2026 08:25:48 +0100
Message-ID: <8e0c47487add0fa1bc0dad9b1bceef5ebf8071d4.1795505160.git.hns@goldelico.com>
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

Document the optional ti,twl4030-pwm-frame-64 property for the
TWL4030 PWM controller. It selects the 64-clock-cycle frame instead
of the default 128-cycle frame, doubling the output frequency and
reducing duty-cycle resolution.

The selection is explicit because the driver does not know the PWM
input clock rate and cannot derive the hardware frame length from a
consumer-requested period. The shorter frame can reduce PWM LOW
intervals during startup mode detection of LED drivers such as the
TI TPS61160/61.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Revised commit message to focus on the binding and the reason
      for explicit 64-cycle frame selection.
    - Commit-message review assisted by ChatGPT.

 Documentation/devicetree/bindings/mfd/ti,twl.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index 9cc3e4721612e..f458f0d80f2cd 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -396,6 +396,15 @@ properties:
       '#pwm-cells':
         const: 2
 
+      ti,twl4030-pwm-frame-64:
+        type: boolean
+        description:
+          TWL4030 only; not supported by TWL6030 PWM.
+          Select the short 64-clock-cycle PWM frame instead of the
+          default 128-cycle frame, doubling the PWM frequency. Required
+          for dimming inputs requiring short PWM low intervals during
+          startup mode detection (e.g. TI TPS61160/61).
+
     required:
       - compatible
       - '#pwm-cells'
-- 
2.56.0

