Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FBC606A337
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Y6g743+R;
	dkim=fail reason="signature verification failed" header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=DrtAx6L9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD0F10ED43;
	Tue, 24 Nov 2026 07:27:29 +0000 (UTC)
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de
 [85.215.255.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA16A10ED10
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795505178; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=q6SJfTzfqprZYrgKsjzLeq49n1EwhAQRgizro9+K5esUxEOx0G43J5fyVJ5d9BjQnr
 RtP4FrUlFS5Kimgyvq9sASavJlKP3ItH0Crb+UNdsLeIcqeuwuz+dNR5BWchGCIJwVJt
 2qfGlbSJyGqUcRTshIbAtswZ/xTq6Ub1atO0IlVQbvV+OsJzg08jrIE0gVLgzZcv0ZUS
 B3YhCi6mywVGyOufXBSz+FGbOK4pBgnEZs8So3Isy6rANvBezYtxrLZCpZrYqF90odJ/
 v5ax3EqL32kd+ornB3YB4wFDRE/7ZAgSLeWgUvd7i4olQqlpNZ/YF2IufiIE4QbUqhLE
 yitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505178;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=a8tT1IHZ/9bnUeOSg8CevW7PO23hEqXdhqumUHaN6cc=;
 b=KtSl0BSqZ2gateMzLu96RLyWf4L8ofQVX5jOnYmYvAL6NIjmCFqClRmRSHBREH9Bkd
 MzJ0Gz1PY9Vw6SxMklGR3ROyfIWMoW31FpfT/5r7hRuqz/2uBt/sENDOYteKuOdTD1Dm
 TOxL+X2uhbJAqInCfpC09WlC7ZDnNFH73XWf5VNfpHZi0K9vtTFKhKYnv5GAn2WMSNHG
 0SoI6CNliRDF6M+QCEay2lJ3am+3Oc/BZBvK6uwi6DSV637xxdwXMAMLga22DS8T+rPD
 Idealv/wxhM5yR4leRSGCf/1TUowCsxHkLe+ABy3acDccaKFQNNZ0C4NXvZzU3YutXu2
 Gb3g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505178;
 s=strato-dkim-0002; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=a8tT1IHZ/9bnUeOSg8CevW7PO23hEqXdhqumUHaN6cc=;
 b=Y6g743+R6atTH1Bs99pXFNWSa3562WXL2uIoA5xO0x2FhxF+zGf+zgObT2TImNfsNT
 P+4pUKqcVZT/c0Fcg2/jc7aFGTW4MsN8IVQiLG3DzGuIf0MkWilyCo3d6+SxPEN6sN2X
 MCjOkcVqU3KlE9yzhmqcxHTfbmqTpGbsmf4bEtOORCgYq0iy36UInElx/BY7Nt7w5vZX
 h2fUwXjFnA0sZi62m04+/6Sf/z8UiHbLOwHY+zXNsnwF2K0LYJgcfUjiUDU0ZBvE4MTI
 6dmETfoI1D/c+cyg27opmzOwWU0th2mSSWJ8F0Wp9X3sDJobxlFng4YLRQnzpk5OWjMM
 Rb3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505178;
 s=strato-dkim-0003; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=a8tT1IHZ/9bnUeOSg8CevW7PO23hEqXdhqumUHaN6cc=;
 b=DrtAx6L9aiM0luEU9dC+6uFoApLVFOJ1cxmTwwLyvyImtCtpXJfWFsN2OfWyoGGSg7
 atmRqGZWjRV0QGxqGnCw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box by smtp.strato.de (RZmta 55.6.3 AUTH)
 with ESMTPSA id Qb56a22AO7QH1HQ
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 24 Nov 2026 08:26:17 +0100 (CET)
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
Subject: [PATCH v2 12/20] drm/panel: td043mtea1: Attach DT backlight
Date: Tue, 24 Nov 2026 08:25:52 +0100
Message-ID: <163581590b662ebc7a12ccac3cc191b9a3ed4240.1795505160.git.hns@goldelico.com>
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

Connect the TPO TD043MTEA1 DRM panel to its backlight described in
Device Tree by calling drm_panel_of_backlight() during probe. Without
this association, the panel does not control the DT backlight.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Explain the DT backlight lookup performed by drm_panel_of_backlight().
      Commit-message review assisted by ChatGPT; code unchanged.

 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
index b18af526b54c5..cb2fa393591c8 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
@@ -450,6 +450,10 @@ static int td043mtea1_probe(struct spi_device *spi)
 		return ret;
 	}
 
+	ret = drm_panel_of_backlight(&lcd->panel);
+	if (ret)
+		return ret;
+
 	ret = sysfs_create_group(&spi->dev.kobj, &td043mtea1_attr_group);
 	if (ret < 0) {
 		dev_err(&spi->dev, "failed to create sysfs files\n");
-- 
2.56.0

