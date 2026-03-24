Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A709F54ADB
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:10:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DCF110E61D;
	Tue, 24 Mar 2026 17:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="KKeIm6my";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9084F10E61D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 17:10:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774372240; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=iytQaQs3gv96JIS/OcqVGSHjDWqtBg262TSbPPw5MVuFCZ5mcf0aN8o1QrqR0BrmjFcHA8eYdnC3f2R6kx/NwltbMiGF8RqJGsZ+ovtSsIWHu9K7pqjhYoyvr5+lnlvNNmLa+wYVcdhN5gFrstmszB+GqL9XLXFD0BYy8KCc11A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774372240;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6ZPh6G4xAhBxLEgqYKHOD5pZKFxipudSIXmd95nLbpA=; 
 b=jXIF2UNUNEqPYsGdgN7zlD4/+OitfpHa5Vt6sD6C934veRzoCeWnyxVty15yIq0VIBXM6+IuXQCDpkuxrNt3c3MzAd8vk7RXDchZLJB6eEqLFGxx+Nos4K2gof+5EvvkZ3NGy+EkYy5w3BoHfu1I5IHUY//M0fcisMXyTYfrRvw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774372240; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=6ZPh6G4xAhBxLEgqYKHOD5pZKFxipudSIXmd95nLbpA=;
 b=KKeIm6mya6qSyZBdYGoBe70P6AEdtROJIWQV9OAC271FvAYPQICMZ2iQjS+JY76i
 vtjAonZQxSRneMjy2tXZSWhp9HUZf4D7V4TkLiE8diY6f76SbYe/TVNAW+2Vm9B0zy+
 /BSz44H5JmUcXgCBN816XW5LihgRLm5XFj+0D5mQ=
Received: by mx.zohomail.com with SMTPS id 1774372237643335.5512115778221;
 Tue, 24 Mar 2026 10:10:37 -0700 (PDT)
Date: Tue, 24 Mar 2026 17:10:32 +0000
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] drm/panfrost: Drop redundant optional clock
 checks in runtime PM
Message-ID: <acLFYNHPODCYArCk@sobremesa>
References: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
 <20260320164158.487406-3-biju.das.jz@bp.renesas.com>
 <ab25E0kTBA4EjZ3Y@sobremesa>
 <TY3PR01MB11346F3DF5ACB55B5FE8DC96F864CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346DD20F7E2AB23A54A274B864DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3PR01MB11346DD20F7E2AB23A54A274B864DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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

On 21.03.2026 14:16, Biju Das wrote:
> Hi Adrián Larumbe,
>
> Thanks for the feedback.
>
> > -----Original Message-----
> > From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of Biju Das
> > Sent: 20 March 2026 21:32
> > Subject: RE: [PATCH v2 2/4] drm/panfrost: Drop redundant optional clock checks in runtime PM
> >
> >
> >
> > > -----Original Message-----
> > > From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf Of
> > > Adrián Larumbe
> > > Sent: 20 March 2026 21:20
> > > Subject: Re: [PATCH v2 2/4] drm/panfrost: Drop redundant optional
> > > clock checks in runtime PM
> > >
> > > Hi Biju,
> > >
> > > On 20.03.2026 16:41, Biju wrote:
> > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > >
> > > > The clk_enable() and clk_disable() APIs already handle NULL clock
> > > > pointers gracefully — clk_enable() returns 0 and clk_disable()
> > > > returns immediately when passed a NULL or optional clock. The
> > > > explicit if
> > > > (pfdev->bus_clock) guards around these calls in the runtime
> > > > suspend/resume paths are therefore unnecessary. Remove them to simplify the code.
> > > >
> > > > Reviewed-by: Steven Price <steven.price@arm.com>
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > ---
> > > > v1->v2:
> > > >  * Collected tag
> > > > ---
> > > >  drivers/gpu/drm/panfrost/panfrost_device.c | 12 ++++--------
> > > >  1 file changed, 4 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > b/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > index dedc13e56631..01e702a0b2f0 100644
> > > > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > @@ -429,11 +429,9 @@ static int panfrost_device_runtime_resume(struct device *dev)
> > > >  		if (ret)
> > > >  			goto err_clk;
> > > >
> > > > -		if (pfdev->bus_clock) {
> > > > -			ret = clk_enable(pfdev->bus_clock);
> > > > -			if (ret)
> > > > -				goto err_bus_clk;
> > > > -		}
> > > > +		ret = clk_enable(pfdev->bus_clock);
> > > > +		if (ret)
> > > > +			goto err_bus_clk;
> > > >  	}
> > >
> > > It seems clk_prepare_enable() can also deal with NULL clock device
> > > pointers gracefully, so maybe you could also do away with pointer checks in panfrost_clk_init?
> >
> > This is the only check and no need to print rate for optional clk. That is the reason I have not
> > touched this.
> >
> > 	if (pfdev->bus_clock) {
> > 		rate = clk_get_rate(pfdev->bus_clock);
> > 		dev_info(pfdev->base.dev, "bus_clock rate = %lu\n", rate);
> >
> > 		err = clk_prepare_enable(pfdev->bus_clock);
> > 		if (err)
> > 			goto disable_clock;
> > 	}
>
> The above block is good for optional clock.
>
> Otherwise, there will be 2 checks for optional clk.
>
> One here:
>
> if (pfdev->bus_clock) {
> 	rate = clk_get_rate(pfdev->bus_clock);
> 	dev_info(pfdev->base.dev, "bus_clock rate = %lu\n", rate);
> }
>
> and one inside the clk_prepare_enable():
>
> err = clk_prepare_enable(pfdev->bus_clock);
>
> Please let me know your thoughts.

You're right, it's probably best to leave it the way it is.

Cheers,
Adrian

> Cheers,
> Biju
>
> >
> > Cheers,
> > Biju
> > >
> > > Other than that,
> > >
> > > Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > >
> > > >  	panfrost_device_reset(pfdev, true); @@ -464,9 +462,7 @@ static int
> > > > panfrost_device_runtime_suspend(struct device *dev)
> > > >  	panfrost_gpu_power_off(pfdev);
> > > >
> > > >  	if (pfdev->comp->pm_features & BIT(GPU_PM_RT)) {
> > > > -		if (pfdev->bus_clock)
> > > > -			clk_disable(pfdev->bus_clock);
> > > > -
> > > > +		clk_disable(pfdev->bus_clock);
> > > >  		clk_disable(pfdev->clock);
> > > >  		reset_control_assert(pfdev->rstc);
> > > >  	}
> > > > --
> > > > 2.43.0
> > >
> > >
> > > Adrian Larumbe
