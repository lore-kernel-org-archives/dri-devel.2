Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78231C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 19:50:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D7110EE5A;
	Tue, 22 Sep 2026 19:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="g4cwaddM";
	dkim-atps=neutral
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4308710EE54
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 19:50:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790106651; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C6UMJ0g70qPdjXQYBY5vGSIsnl7uJv9ZAUkIkKTyqLLm6mel3h5ve5zQW/QfWpg7GNdSL7svjBfgVSZ9cxg//mkj5I6EAV4m80Su+Xx9gkuLOh1k1s1dIPGmo/vSB0XpiwwCA/0+6VizdzCN9AKA5nlh20pc14XFQxYn0YgJIfs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790106651;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7kRrFNaa0VL0AJwl+dtEwA1iZbYUSRM7gtSXJLbDmIQ=; 
 b=TgfUuJwpNpqvbspXB2VirQF1L4fMvc9TnSkmmpiXuEFvwICXpL61EGXTzjw0n9bUQ0Eb37x81sXfnJoH4PYKZ/eSJ1DUAkOz5sUTNFv+CE//EHm1e/HSwwasp0/rjjG8sMd9VPaCXTRptoENKYvg/euxfHz/9loCc9LKQ5FhDFM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790106651; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=7kRrFNaa0VL0AJwl+dtEwA1iZbYUSRM7gtSXJLbDmIQ=;
 b=g4cwaddMGLisPIAM7kq3MqaH5Ygsxr3jnuGNsRnMeErReTpde9xMO2fEafEGbJ5m
 dIJxgjtTaRvCkPYdhR1v4XRLyqD0xyNSWdRhV9gQi905c+HCL2EMu91tDDYlozTzM46
 NtvLs9DDsaewQYxmfzF7l7CR43ifDXqp6967jwOs=
Received: by smtp.zohomail.com with SMTPS id 1790106650436526.1793456892476;
 Tue, 22 Sep 2026 12:50:50 -0700 (PDT)
Date: Tue, 22 Sep 2026 20:50:44 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v9 05/16] drm/panfrost: Consolidate device clock
 management and reset
Message-ID: <arGH9jPcHhDqZSIH@sobremesa>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-5-e588feaa61ef@collabora.com>
 <20260914104500.6e32c6cd@fedora-21.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260914104500.6e32c6cd@fedora-21.home>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.95.26
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

On 14.09.2026 10:45, Boris Brezillon wrote:
> On Sat, 12 Sep 2026 00:28:06 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Gather all clock enables and disables into a single function to avoid
> > repetitions between driver init/fini and device resume/suspend, since
> > these clocks are always handled in bulk.
> > 
> > Also do clk (un)prepares and dis/enables at the same time, since the
> > clk_prepare_* family of functions can simply increase the refcnt of
> > an already prepared clock.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Two nits below.
> 
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_device.c | 118 +++++++++++++----------------
> >  1 file changed, 52 insertions(+), 66 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > index b3a53504bd01..2fcbd223204c 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -34,10 +34,46 @@ static void panfrost_reset_fini(struct panfrost_device *pfdev)
> >  	reset_control_assert(pfdev->rstc);
> >  }
> >  
> > -static int panfrost_clk_init(struct panfrost_device *pfdev)
> > +static int panfrost_clk_enable(struct panfrost_device *pfdev, bool enable_ace_clock)
> 
> I don't want to have a flag added for each new clock we decide to keep
> enabled on RPM suspend, so how about s/enable_ace_clock/on_resume/?
> Also, since it's enabling more than one clk, I'd go
> s/panfrost_clk_enable/panfrost_clks_enable/.

I agree with you. I was thinking if new clocks also had different needs in the future,
maybe we could pass an array of option clocks but at this point it's pure make-believe.

> >  {
> >  	int err;
> > +
> > +	err = clk_prepare_enable(pfdev->clock);
> > +	if (err)
> > +		return err;
> > +
> > +	err = clk_prepare_enable(pfdev->bus_clock);
> > +	if (err)
> > +		goto disable_clock;
> > +
> > +	if (enable_ace_clock) {
> > +		err = clk_prepare_enable(pfdev->bus_ace_clock);
> > +		if (err)
> > +			goto disable_bus_clock;
> > +	}
> > +
> > +	return 0;
> > +
> > +disable_bus_clock:
> > +	clk_disable_unprepare(pfdev->bus_clock);
> > +disable_clock:
> > +	clk_disable_unprepare(pfdev->clock);
> > +
> > +	return err;
> > +}
> > +
> > +static void panfrost_clk_disable(struct panfrost_device *pfdev, bool disable_ace_clock)
> 
> Similarly, I'd go s/disable_ace_clock/on_suspend/ and
> s/panfrost_clk_disable/panfrost_clks_disable/.

Noted.

Adrian Larumbe
