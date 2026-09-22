Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02A7C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABE3E10EBEE;
	Tue, 22 Sep 2026 08:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xz5MJybl";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF4210E73F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:11:22 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99dso4002477a91.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 23:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790057482; x=1790662282; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NlAU1cyZsGgVwNObzTYZB5CmWtYF2TFVXhpno3VWcwI=;
 b=Xz5MJyblBB9YyRy40DWspB+DpMWFJRczRYjiPEzkKaQMWtVI9Z0Gn05HLz/GARF2Qw
 fgByQSuCuLULKag1FZFPg1sMQbijEH/BA3gQ6Iw8A4Uk0n183ieFbmgqvnSkYI3Eg1Cf
 rK2i/kAnJ6EwUHRvXg5AC3cSltwTj1skSuMAgJF+l5P7U7vZzVduIUt3i+CPOx8VatBE
 J+3tHYPRD9Gu9FSqzyzgP4oMrKcRWsNTSz90OkCu6pO+ALTTwCF7dt2bc+fIYeWbNzOk
 d7PSmPwyx4/RszLWGBwQM8tfdtGrqFVFOvgda65S1BjHW3cdlEMhX3pMotAxwQ0uX+tv
 b9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790057482; x=1790662282;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NlAU1cyZsGgVwNObzTYZB5CmWtYF2TFVXhpno3VWcwI=;
 b=j/6Nm866Vo1reh2jEMTleMdlDAI+DpuBaScaXJYPWoX4tstYY8f9gDKxzqYaJnug4k
 lUW+7KmRJfo/Bno2rvbnFfLh/h2L2fpMGAJX9vdgUeOo0ssN7OQYE87RduEAVvDrmrX6
 XHJueJ+nQJK3tNEoMflmcssfkuMQiuLW4OTt48QWh+25nd6wBdAW5eZbctoxEad5h6iP
 u1YqoYTOY8fI/OdyVMVd4XmIitrXg0mBbVzKhPQ8VUzaJnSqsv6jaDva9IRvfd76hZMr
 5no8QfIIjOypaxt826V//Q21EmeJ/AnZ57ejOvufHuhV9eHQ81OiiqqIGu3JhjGPI+KI
 MVNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx95/dXuCQEg/PPO8dKLHulYsSTDzq0dOhHBqfBVUZCbQx+IVcWeOnP6MybkxKwDFwK9ffo4QUNBcs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nF2vJfudZRmexAEspwtr8QNF6HitoYQ1YkCK7HpsuQdxdhmoTE
 tW+7Ha3/GYmjgdFxI2u53uqVFRVzyEJTlTrxQXa62laPCqQyDSaPFhED
X-Gm-Gg: AYBFou22Os/5yBpEGQsGMyHdFppNqonrwGLXHYEbwUDzMDZmOkbYb8k9mdszy8GlQxm
 eyd+sGpTSwW95uuOrAlSLoRTcpJ7JPRY8+AkjbdzIKyiuuSrrWsCVJuBMnrrWCdXZMtZC3Jr6tO
 v08yOYXEY8+9Opp+g+JQI0wqOXY4tTIGnPmhFa1KNjKNtjyybIJzhf8vWYlP+PFNEPNXvo9Yl+U
 xI3wKUnxhczaXkLngR1gfypkjT6eMy7KDQmjQdV0m/JFctZ1abVOilMcUA84CB3zLzqbfC5TSRg
 CykpihuhaEUVi820dTc8BBFL2jVt6zBPvdBnMCWx3tOrmk9WK1iDbd1E4Q3xPz1uFOrRuO6ARfd
 3grn243Y32FCoLXUWVAEP50WteIC7xoqDQZ4BgLIXY/0JQdgwNfDZIDvyVlJpBw4ZzWSW1CA7HV
 RVgW+R+aWVVbrC8jPYG0CPq5uLNNAPhc0DCXgZJwVlDyQYSvUIn5SLDurPThELgiizl/F/N5E=
X-Received: by 2002:a17:90b:4c02:b0:39d:f5b1:e365 with SMTP id
 98e67ed59e1d1-3a073112c1cmr146819a91.25.1790057481645; 
 Mon, 21 Sep 2026 23:11:21 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a06e5a14a8sm1659901a91.11.2026.09.21.23.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 23:11:20 -0700 (PDT)
Date: Tue, 22 Sep 2026 14:10:28 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, Hans de Goede <hansg@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Minas Harutyunyan <hminas@synopsys.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 linux-phy@lists.infradead.org, 
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [RFC PATCH 2/5] ata: libahci_platform: Adapt the return value
 changed for disabled blob
Message-ID: <arIbwfsrA3PlSWNW@inochi.infowork>
References: <20260922024724.191412-1-inochiama@gmail.com>
 <20260922024724.191412-3-inochiama@gmail.com>
 <f0db06a2-08e4-4013-96cb-c6754f673126@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0db06a2-08e4-4013-96cb-c6754f673126@kernel.org>
X-Mailman-Approved-At: Tue, 22 Sep 2026 08:40:51 +0000
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

On Tue, Sep 22, 2026 at 12:23:54PM +0900, Damien Le Moal wrote:
> On 9/22/26 11:47, Inochi Amaoto wrote:
> > Check EOPNOTSUPP for disabled helper function as the change in phy core.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/ata/libahci_platform.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
> > index 6e072d681341..3e8ddbeb49b3 100644
> > --- a/drivers/ata/libahci_platform.c
> > +++ b/drivers/ata/libahci_platform.c
> > @@ -371,11 +371,11 @@ static int ahci_platform_get_phy(struct ahci_host_priv *hpriv, u32 port,
> >  
> >  	rc = PTR_ERR(hpriv->phys[port]);
> >  	switch (rc) {
> > -	case -ENOSYS:
> > +	case -EOPNOTSUPP:
> >  		/* No PHY support. Check if PHY is required. */
> >  		if (of_property_present(node, "phys")) {
> >  			dev_err(dev,
> > -				"couldn't get PHY in node %pOFn: ENOSYS\n",
> > +				"couldn't get PHY in node %pOFn: EOPNOTSUPP\n",
> 
> I do not see the point in printing an error code name. Instead, let's make the
> error message more sensible. Something like:
> 
> 	dev_err(dev, "Node %pOFn: PHY not supported\n", node);
> 
> Or
> 
> 	dev_err(dev, "PHY not supported on node %pOFn\n", node);
> 

Thanks, I will take this.

Regards,
Inochi

> >  				node);
> >  			break;
> >  		}
> 
> 
> -- 
> Damien Le Moal
> Western Digital Research
