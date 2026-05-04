Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B046FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 14:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCD9B10E3B4;
	Mon,  4 May 2026 14:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="HL5GL0jh";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4331710E3B4
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 14:51:19 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 0A9BF1A3506;
 Mon,  4 May 2026 14:51:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D090F5FD5F;
 Mon,  4 May 2026 14:51:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C2E5411AD2AF0; 
 Mon,  4 May 2026 16:51:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777906276; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=r9T7bUyGzyoRVnfKSGbxar4GZSx1vKcnwh8pHU4ippQ=;
 b=HL5GL0jhE9hANfIi6ToH9PM2OWe1L4GeEego7aeusW8VgXQdKS/1uMW7S8o8YCUkEvE8Pd
 bLdW8I9Tha4gF3TFMcTni0uKGkhImeDf2+LoA4SOUiJqYI1kZ7rBRJqtjYd1jXkXGPDZiK
 YULCIN7U/uARlCylAiBGOpealK9DaJtnjUIBfUs5eQ4TKAZNnTZ5/546ZwONu/4FAabAur
 1mki7Wbv7UEgBvd7vsC+EpK1HeQCO+AunaIohYOSz2mhzw5QpEzLetJnlE8qcP31I/5eOd
 6xtsIC5dOJLhjBTDq+sca7RENfXDxfU4PxNdOxZ7/80q9jPcJntmfPKtR3tLvQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Jyri Sarha <jsarha@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Kory Maincent <kory.maincent@bootlin.com>
Cc: Bajjuri Praneeth <praneeth@ti.com>, stable@vger.kernel.org, 
 thomas.petazzoni@bootlin.com, Russell King <linux@armlinux.org.uk>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
In-Reply-To: <20260428090457.121894-1-kory.maincent@bootlin.com>
References: <20260428090457.121894-1-kory.maincent@bootlin.com>
Subject: Re: [PATCH v2] drm/bridge: tda998x: Use __be32 for audio port OF
 property pointer
Message-Id: <177790627096.423270.11432502656902185390.b4-ty@b4>
Date: Mon, 04 May 2026 16:51:10 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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


On Tue, 28 Apr 2026 11:04:56 +0200, Kory Maincent wrote:
> of_get_property() returns a pointer to big-endian (__be32) data, but
> port_data in tda998x_get_audio_ports() was declared as const u32 *,
> causing a sparse endianness type mismatch warning. Fix the declaration
> to use const __be32 *.

Applied, thanks!

[1/1] drm/bridge: tda998x: Use __be32 for audio port OF property pointer
      commit: 2a46a9356ba7b1bdd741c8b41e5374edcd960557

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>

