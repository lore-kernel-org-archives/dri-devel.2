Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46C606A32C
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=15VaDmhP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B413710E5B9;
	Mon,  2 Nov 2026 10:35:37 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C054C10E5B9
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 10:35:31 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 90698C8F446;
 Mon,  2 Nov 2026 10:36:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8363060750;
 Mon,  2 Nov 2026 10:35:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 56F11103290E8; Mon,  2 Nov 2026 11:35:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793615728; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZXbvapQaNImbXR9QF5KkcIq1gPNTKOhj+WrRUaDSC14=;
 b=15VaDmhPbzpFpCxilWGbI42dOv4srUFUJq26JhYFL3LzPcTApz/JsW3mpJ7QYdqnY8m1Oq
 6VXfb6peEGSTSB1vt3GkfO0CEJWJm8VKegQK3DzGtJCpxzJZ8EQcFMv7wyQ44s5lZ2bu8M
 /DTsOlT5BCeqbjfd6pLnTVtxmovqJGishKRDO9tZmJqWweH1xAZwaKLZRMRAcKlzuGBRRw
 YcV0R1vBk/KhcXsdkpnUWNYj0SjhwDon2f9qyfZdkoftBTFjf2t/Kuevlfv1BtAzQrJzY0
 dlF9Uict4ErdnNT7OztAFl5HIjxa88NOqukg3mfXqhYZ7e26eXOUql2gB7PEoA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jessica Zhang <jesszhan0024@gmail.com>
In-Reply-To: <cover.1789994813.git.osama.abdelkader@gmail.com>
References: <cover.1789994813.git.osama.abdelkader@gmail.com>
Subject: Re: [PATCH v7 0/3] drm/panel: Use managed helpers in DSI panels
Message-Id: <179361572393.120902.4850008963645944900.b4-ty@b4>
Date: Mon, 02 Nov 2026 11:35:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Mon, 21 Sep 2026 15:17:54 +0200, Osama Abdelkader wrote:
> This series converts straightforward DRM panel drivers to the managed
> MIPI DSI attach and panel add helpers, dropping the corresponding manual
> detach/remove calls from remove paths. Split by driver family/vendor to
> keep the changes reviewable.
> 
> Patches 2, 4 and 5 of v4 (Samsung, Himax/Ilitek and display vendor
> panels) are already in drm-misc-next and are not resent here.
> 
> [...]

Applied, thanks!

[1/3] drm/panel: Use devm_mipi_dsi_attach in BOE panels
      commit: f872d4e3a2ae6bdd8d88a4c19844b3ec851f2549
[2/3] drm/panel: Use managed helpers in Novatek and Raydium panels
      commit: 9ebe0565cf49ddaaefe136a0513ce31b7bf01c2c
[3/3] drm/panel: Use managed helpers in assorted panels
      commit: 525b076e340a9d37abaa1d34141669f96307698d

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


