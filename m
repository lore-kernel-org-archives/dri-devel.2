Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C4A10A3D7F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 11:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 477A310E9BE;
	Thu, 26 Mar 2026 11:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="FaX23d+e";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ECE410E9CD
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 11:59:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1774526345; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=eibIxsY4jbugMMsUsRzfo4YlKvNyygN1G/z8U3/IkGyIh8Zq0DkQhFwzN4tw5pi+hEU0gh5jdWnl2z78AMpnuEn2NsjfJO/AjvITE58ayAf9z2v4DsrSNNP3tasAgHD6TlCrTncyfu6cQIgf2sRZWnj9sTxmV1CwuSf1xUmvNN4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1774526345;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Ul3Elmvarjeo2F5dZsfHqeijZFTBr3ip2K2uSBcgO+g=; 
 b=E/1m/krGiAxQ4hNv/5Mpn4vgVj5fFNbwsCMTFv0u41/ZCLamFFB9qv+Xvse2/lTguR/ApgPRASdggCk4N2A1UNyNMtEI0SiNy815MXaBW8sPXVVVPQjUN92Ki87TR0vCnOxVBfKOgrlsjggAPj1XtZ5YBkpWahI2ewD3DbWdg9k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774526345; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=Ul3Elmvarjeo2F5dZsfHqeijZFTBr3ip2K2uSBcgO+g=;
 b=FaX23d+eST4NvBkpuAforAXC1w55gz/e6Ca5LBk3is7dXSXr9k1BIT/VPol8QgIu
 +dOHKibJ4DnlVUQM9Bagr2q1Ws43B6EOTWcy4O9+xOMyAXEs/wPBnFMYTQTdjoibHd0
 yrEdWG4ZlahccvvmnXiakw2qLuzG79LoXwr8otCM=
Received: by mx.zohomail.com with SMTPS id 1774526344009716.8538221987557;
 Thu, 26 Mar 2026 04:59:04 -0700 (PDT)
Date: Thu, 26 Mar 2026 11:58:59 +0000
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
Message-ID: <acUfZmYoDA_ZKVBk@sobremesa>
References: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
 <20260320164158.487406-3-biju.das.jz@bp.renesas.com>
 <ab25E0kTBA4EjZ3Y@sobremesa>
 <TY3PR01MB11346F3DF5ACB55B5FE8DC96F864CA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346DD20F7E2AB23A54A274B864DA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <acLFYNHPODCYArCk@sobremesa>
 <TY3PR01MB11346F913241559462D109F2D8656A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3PR01MB11346F913241559462D109F2D8656A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
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

On 26.03.2026 08:55, Biju Das wrote:
> Hi Adrian,
>
> > -----Original Message-----
> > From: Adrián Larumbe <adrian.larumbe@collabora.com>
> > Sent: 24 March 2026 17:11
> > Subject: Re: [PATCH v2 2/4] drm/panfrost: Drop redundant optional clock checks in runtime PM
> >
> > On 21.03.2026 14:16, Biju Das wrote:
> > > Hi Adrián Larumbe,
> > >
> > > Thanks for the feedback.
> > >
> > > > -----Original Message-----
> > > > From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On Behalf
> > > > Of Biju Das
> > > > Sent: 20 March 2026 21:32
> > > > Subject: RE: [PATCH v2 2/4] drm/panfrost: Drop redundant optional
> > > > clock checks in runtime PM
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: dri-devel <dri-devel-bounces@lists.freedesktop.org> On
> > > > > Behalf Of Adrián Larumbe
> > > > > Sent: 20 March 2026 21:20
> > > > > Subject: Re: [PATCH v2 2/4] drm/panfrost: Drop redundant optional
> > > > > clock checks in runtime PM
> > > > >
> > > > > Hi Biju,
> > > > >
> > > > > On 20.03.2026 16:41, Biju wrote:
> > > > > > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > >
> > > > > > The clk_enable() and clk_disable() APIs already handle NULL
> > > > > > clock pointers gracefully — clk_enable() returns 0 and
> > > > > > clk_disable() returns immediately when passed a NULL or optional
> > > > > > clock. The explicit if
> > > > > > (pfdev->bus_clock) guards around these calls in the runtime
> > > > > > suspend/resume paths are therefore unnecessary. Remove them to simplify the code.
> > > > > >
> > > > > > Reviewed-by: Steven Price <steven.price@arm.com>
> > > > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > > > > > ---
> > > > > > v1->v2:
> > > > > >  * Collected tag
> > > > > > ---
> > > > > >  drivers/gpu/drm/panfrost/panfrost_device.c | 12 ++++--------
> > > > > >  1 file changed, 4 insertions(+), 8 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > > > b/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > > > index dedc13e56631..01e702a0b2f0 100644
> > > > > > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > > > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > > > @@ -429,11 +429,9 @@ static int panfrost_device_runtime_resume(struct device *dev)
> > > > > >  		if (ret)
> > > > > >  			goto err_clk;
> > > > > >
> > > > > > -		if (pfdev->bus_clock) {
> > > > > > -			ret = clk_enable(pfdev->bus_clock);
> > > > > > -			if (ret)
> > > > > > -				goto err_bus_clk;
> > > > > > -		}
> > > > > > +		ret = clk_enable(pfdev->bus_clock);
> > > > > > +		if (ret)
> > > > > > +			goto err_bus_clk;
> > > > > >  	}
> > > > >
> > > > > It seems clk_prepare_enable() can also deal with NULL clock device
> > > > > pointers gracefully, so maybe you could also do away with pointer checks in panfrost_clk_init?
> > > >
> > > > This is the only check and no need to print rate for optional clk.
> > > > That is the reason I have not touched this.
> > > >
> > > > 	if (pfdev->bus_clock) {
> > > > 		rate = clk_get_rate(pfdev->bus_clock);
> > > > 		dev_info(pfdev->base.dev, "bus_clock rate = %lu\n", rate);
> > > >
> > > > 		err = clk_prepare_enable(pfdev->bus_clock);
> > > > 		if (err)
> > > > 			goto disable_clock;
> > > > 	}
> > >
> > > The above block is good for optional clock.
> > >
> > > Otherwise, there will be 2 checks for optional clk.
> > >
> > > One here:
> > >
> > > if (pfdev->bus_clock) {
> > > 	rate = clk_get_rate(pfdev->bus_clock);
> > > 	dev_info(pfdev->base.dev, "bus_clock rate = %lu\n", rate); }
> > >
> > > and one inside the clk_prepare_enable():
> > >
> > > err = clk_prepare_enable(pfdev->bus_clock);
> > >
> > > Please let me know your thoughts.
> >
> > You're right, it's probably best to leave it the way it is.
>
> If you are happy with the series, can you please merge it?

Will do, I'll add my Rb's and let you know when it's merged.

> Cheers,
> Biju

Adrian Larumbe
