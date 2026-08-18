Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789D8C5DF81
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD3B10E079;
	Tue, 18 Aug 2026 19:49:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="lR4EKqGT";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=valla.it header.i=@valla.it header.b="E60QJm7E";
	dkim-atps=neutral
X-Greylist: delayed 618 seconds by postgrey-1.36 at gabe;
 Tue, 18 Aug 2026 19:49:57 UTC
Received: from delivery.antispam.mailspamprotection.com
 (delivery.antispam.mailspamprotection.com [185.56.87.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3173210E079
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 19:49:57 +0000 (UTC)
ARC-Seal: i=1; cv=none; a=rsa-sha256;
 d=outgoing.instance-europe-west4-tvch.prod.antispam.mailspamprotection.com;
 s=arckey; t=1787082597; 
 b=C0XI56sdu843R1evuZcUhuy9OtoPbyDisTXnGig4E8fguf+8l/Ea5jZxO0H1CeFpCbr5s14RF3
 SYE9iNInQuLn7JwBMRAf5krVPV7kHJsNtpHwwgHm8yXKj2ymRWAvQ3q56ENQFfBns6l+OMHny/
 JajgDIrkfuraSwKjVoDgAo73jLfQ7pFyWzjFecZBbFihaPjJvOANWhPF2yYWKrl3yfwO7X/y+X
 yhl30llzsf/irGQEZPURAxRkaKmh+NwpR3DZt91u/0b/eiW841snkIoDdgmxGuYP72Pc5DmflO
 RsaUHCvE5dn44KOp5cNoUYVCT5g65liNna0nzJ/mroP8sw==;
ARC-Authentication-Results: i=1;
 outgoing.instance-europe-west4-tvch.prod.antispam.mailspamprotection.com;
 smtp.remote-ip=35.214.173.214; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed;
 d=outgoing.instance-europe-west4-tvch.prod.antispam.mailspamprotection.com;
 s=arckey; t=1787082597; 
 bh=wHP5KBg/oNB+Ay6wTp7lvz/U/sVkCZYQHiydgCUUv2U=;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
 b=NjP3zoALansz5DSApQNRH1A1V9HWBNYCn3UcaMAhm5M1wMqiqGVRnLrYsYGHIcMvw0GSIwfJQS
 m1Mh7RLHHcJBigSGdpRjOB2INgYHd5FIvSPiz7q60DwHePkwwMbSdMyyEINbOnRLM9gHCKPepa
 kHjCQFil/rRZAvkXLtjck8xTY1TnoVtuVIKK4Wm96OFpGBb2U8mnJjQOU4y/S3m8Iz19PP6qYr
 L14MITIJALUitwF2A66irmylESeOgXVvigCLzNUBFAPtqmwH9xE0Fec2aPUXMrNH4+9SWdbaS6
 wF8LlR7j738nGkDO49x9Uq68cDh9P6FaGEtJdzFzoBPdFg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
 :Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
 :From:Date:Reply-To:List-Unsubscribe;
 bh=3pmtWH4eFsI2qfj6Txsmu/hKvSWq+vceDLJCUvd8CW0=; b=lR4EKqGTUYVEgyv7W30H8kIaT6
 gL3AIYC89s2J0hazin+ONkl/v7k1bsrFkM1EnglpT2ljkd42MMyYbgB6ThrPDd2cNs3GI/yNWmKkV
 4ngLnc2XGT3VJR6Sc3ebzMYV8onhLPa4TCk3w2d63n/Xk2xnDFlyleiexGXE0LEyhnLU=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214]
 helo=esm19.siteground.biz)
 by instance-europe-west4-tvch.prod.antispam.mailspamprotection.com with
 esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384 (Exim 4.99.5)
 (envelope-from <francesco@valla.it>) id 1wwPep-00000004UZm-3GUS
 for dri-devel@lists.freedesktop.org; Tue, 18 Aug 2026 19:39:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
 s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
 list-subscribe:list-post:list-owner:list-archive;
 bh=3pmtWH4eFsI2qfj6Txsmu/hKvSWq+vceDLJCUvd8CW0=; b=E60QJm7ENkgKZRD25VMjMR5TCA
 BMleotmG9NUp+WMpOPuG5hWFGzU1LzEzMVpbJbCSeDa1EYhxUTyib9fNgyFW+pbxbzVY+t0H/nh7T
 Z72DDAU7DLcZfH3vTwgWH7OXMa3SMTy0+lbww/2s/NYLslfbAkqDDuLhR0sWfqpkxbRw=;
Received: from [87.5.139.196] (port=60131 helo=bywater)
 by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.5) (envelope-from <francesco@valla.it>)
 id 1wwPeV-00000000Fh4-2goh; Tue, 18 Aug 2026 19:39:15 +0000
Date: Tue, 18 Aug 2026 21:39:13 +0200
From: Francesco Valla <francesco@valla.it>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Maxime Ripard <mripard@kernel.org>, 
 Helge Deller <deller@gmx.de>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
Message-ID: <aoSygH8JSXFrivOA@bywater>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros>
 <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat>
 <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
 <20260812-neon-asp-of-completion-e9349e@houat>
 <CAEUXW=H-o+fqBjH1UQG7=UTm5x1a9Cj++XJM7twvFU4vJC4UrQ@mail.gmail.com>
 <20260814155325.GB516994@ravnborg.org>
 <CAEUXW=Ffs+WKsQrNc3zjwtfAO=FKTf_7jQFovD+yjmD_yJuY2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEUXW=Ffs+WKsQrNc3zjwtfAO=FKTf_7jQFovD+yjmD_yJuY2Q@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 7590a7fdef1e3d3ac838eb8da61eb77f
X-AntiAbuse: ID - 7590a7fdef1e3d3ac838eb8da61eb77f
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1wwPep-00000004UZm-3GUS-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-tvch.prod.antispam.mailspamprotection.com; 
 iprev=pass (214.173.214.35.bc.googleusercontent.com)
 smtp.remote-ip=35.214.173.214; 
 auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
 dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
 arc=none
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

Hi Màxim,

On Tue, Aug 18, 2026 at 12:48:21AM +0200, Màxim Pedraza Padilla wrote:
> Hi Sam,
> 
> Thank you -- that's a useful pointer, and it settles the question of how
> a splash should be drawn without fbcon: a DRM client at
> drm_client_setup(), next to drm_log, not a drm_fb_helper hook.
> 
> Francesco's series is genuinely inspiring work, and it would be very
> useful to me if it could take a CLUT224 image -- unfortunately it can't.
> It only accepts an uncompressed 24-bit RGB888 BMP, whereas our logo is
> paletted, which is what keeps it small: 17 KiB for 800x480 rather than
> around a megabyte. So as it stands the format doesn't line up with what
> we carry.

Format concerns are - in addition to lack of time to work on it - what
is keeping me from sending a new revision. Any kind of compression would
need to be unwinded - probably on a per-pixel basis - making the
required CPU time unreasonable for large images (at least if boot time
optimization is the ultimate goal - linke in my case).

Of course, on "low-resolution" displays the size-vs-time tradeoff might
be the sweet spot - but the target here was to being as much generic as
possible.

> 
> Reading it did make the distinction clearer to me, though. drm_splash
> *draws* an image into a fresh buffer, which means a first modeset and the
> blanking that comes with it. What our hardware leaves us with is a
> framebuffer U-Boot has already drawn and a CRTC still scanning it out, so
> for our case the natural thing is to *adopt* that state rather than
> redraw it -- which is what hardware state readout does, with no redraw
> and no flicker.
> 
> Where drm_splash is the right tool is the case with no state to adopt --
> Falcon boot, where U-Boot proper never runs, or a handover where the
> buffer doesn't survive. I'll follow Francesco's series for that.

My typical embedded setup is exactly that one - Falcon boot, a simple
boot logic inside the SPL, and possibly no initramfs. I find this to be
the most portable solution, as it does not require complex drivers and
handover logic in the bootloader.

In case you decide to take my series for a re-spin, feel free to ask if
something is unclear.

> Thanks again -- it helped me draw the line between the two.
> 
> Max

Reagrds,

Francesco

