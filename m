Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3766C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2908810E11F;
	Fri, 14 Aug 2026 16:09:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ravnborg.org header.i=@ravnborg.org header.b="VKJxlyjc";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="+bcLyjFz";
	dkim-atps=neutral
X-Greylist: delayed 964 seconds by postgrey-1.36 at gabe;
 Fri, 14 Aug 2026 16:09:33 UTC
Received: from mailrelay-egress4.pub.mailoutpod2-cph3.one.com
 (mailrelay-egress4.pub.mailoutpod2-cph3.one.com [46.30.211.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047AF10E11F
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 16:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786722807;
 x=1787327607; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=ETAbJekTKq7/C0E0ng0HA47FjvDztMKRhBFG1L/c6jc=;
 b=VKJxlyjce8chAlpqGFSW/zNF8pWL3vDuk0YSwhK6YgmGt2OXN8WEr2zwOMfPHeGaUbTZ9uTdPoxpr
 DpRSSBchSXxPo/30t6XuzVG2+lAvB6T9cdjcgMZTwIiy3eC+n/he9zq3IWsPoCeT1umGfGmbdO9dxi
 NZ4E5I50WtnCQjKbOddPSrKiR680Q5AYKgpky6oLvMppvNP/RAV7izR56xlkZg3guJGoemXVKD/KxJ
 Qu/6cSl96lIbwY1cI2FeLPSkaOZWiWmgOMPX+Wu4Anud/GRKqtdriPJ5ICWCdCgxvakwnXvOpur70D
 mRyeWJKu9A9UrsIke7H/zcGVXtRmocQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786722807;
 x=1787327607; d=ravnborg.org; s=ed1;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=ETAbJekTKq7/C0E0ng0HA47FjvDztMKRhBFG1L/c6jc=;
 b=+bcLyjFzFfdoZAOUcbMvrKbcCe6MFYUHe9j2rfTpKkEa4DRTGsQ6XsN68ja6gNvJWTk//jAKcjZEb
 OZAmEViBQ==
X-HalOne-ID: 489b43a4-97f8-11f1-8842-5fcedd255746
Received: from ravnborg.org (unknown [2a00:fd01:81e9:6100:119c:2d17:fdc1:9930])
 by mailrelay5.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
 id 489b43a4-97f8-11f1-8842-5fcedd255746;
 Fri, 14 Aug 2026 15:53:26 +0000 (UTC)
Date: Fri, 14 Aug 2026 17:53:25 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: =?iso-8859-1?Q?M=E0xim?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, Helge Deller <deller@gmx.de>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, Francesco Valla <francesco@valla.it>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
Message-ID: <20260814155325.GB516994@ravnborg.org>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros>
 <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat>
 <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat>
 <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
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

Hi Maxim.

> On doing it through KMS: you are right, and the follow-up series should be
> a DRM client alongside drm_log rather than a hook in drm_fb_helper. I will
> rework it that way before posting it.

Take a look at:
https://lkml.iu.edu/2605.1/03465.html

The work Francesco Valla did seems to overlap a lot with what you
suggest.

From the intro mail:

"
in a nutshell, the splash DRM client can draw a splashscreen using:

- the BMP image supplied by the EFI BGRT;
- a BMP image loaded as firmware (either built-in or loaded from the
filesystem);
- a colored background.
"

	Sam
