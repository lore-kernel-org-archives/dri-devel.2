Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6579F436BB
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:19:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B77C10EA80;
	Fri, 17 Apr 2026 16:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="P2zP/QpZ";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B074E10EA80
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:19:14 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 816CA1A332B;
 Fri, 17 Apr 2026 16:19:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5503360497;
 Fri, 17 Apr 2026 16:19:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D0F5D10460880; 
 Fri, 17 Apr 2026 18:19:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776442748; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=9vpZodVeN7UXoBo6/VnGgIBCiZDDEXQexZLXoOkS3eM=;
 b=P2zP/QpZ/371HZTOIkmk5j+S9p4CkBQkah3MjqhH0+4HMr81TJjTiS/yaZJG91r/euAzeT
 gdU4dkHnaRIq0rCYQ71PvgKkKBVwD5MnHgKde0GK0dgijTqh8i4zkDCyOTvTb9hwmBDUQZ
 ggl+Oz68rfFSl4FOPCuQqVs0Jrnm6+ZAFGteS/g0C3usxlcLGoALDED5PjQ2Vl8u2EOfMm
 07w2jAmmJoOXwpv8C43wNaXDaV5LMcXVhNuXY3ey53r5m/F85HQx+pMd2Q2tyiamuYODzR
 eV8bwF5n2ctw7tMGmktgXLQHZHjHIwfnFq6d5EXpcWoYG90ssDk5wb2/hRvP/g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 18:19:03 +0200
Message-Id: <DHVKE9YSS22L.27G2WXWHP0DGK@bootlin.com>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH] drm/bridge: tda998x: Use __be32 for audio port OF
 property pointer
Cc: "Bajjuri Praneeth" <praneeth@ti.com>, "kernel test robot"
 <lkp@intel.com>, <thomas.petazzoni@bootlin.com>, "Russell King"
 <linux@armlinux.org.uk>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
To: "Kory Maincent" <kory.maincent@bootlin.com>, "Jyri Sarha"
 <jsarha@ti.com>, "Russell King" <rmk+kernel@armlinux.org.uk>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260417155545.1069280-1-kory.maincent@bootlin.com>
In-Reply-To: <20260417155545.1069280-1-kory.maincent@bootlin.com>
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

On Fri Apr 17, 2026 at 5:55 PM CEST, Kory Maincent wrote:
> From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
>
> of_get_property() returns a pointer to big-endian (__be32) data, but

Where is this stated? of_get_property() is declared as:

| extern const void *of_get_property(const struct device_node *node,
| 				const char *name,
| 				int *lenp);
(https://elixir.bootlin.com/linux/v7.0/source/include/linux/of.h#L365-L367)

I don't see __be32 mentioned there.

> port_data in tda998x_get_audio_ports() was declared as const u32 *,
> causing a sparse endianness type mismatch warning. Fix the declaration
> to use const __be32 *.
>
> Fixes: 7e567624dc5a4 ("drm/i2c: tda998x: Register ASoC hdmi-codec and add=
 audio DT binding")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202604172257.Imo6GOH9-lkp@i=
ntel.com/

Wrong link?

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
