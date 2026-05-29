Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F6ACD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 13:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4733110FEE4;
	Fri, 29 May 2026 13:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mLOeNaY+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12E6010FEE4
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 13:10:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BB1104040C;
 Fri, 29 May 2026 13:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5F21F00893;
 Fri, 29 May 2026 13:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780060242;
 bh=tC9HqkQy8s8fCowmxdJQZ9JYQ14fcgNVnaNweKmAX5U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=mLOeNaY+LFPu3SP40WdO2KaINV+FYH004qBTmn1FtKJB81vr3GaeMS+zXZ2GLc+7g
 Jb6Y2Fzb6OXFGL9y16tZdu1odcIA8Atb87zT6MhQVOL1gwDsa5JEEsM/vsH6CpBbNZ
 6jXOArmVUaFWwm300UxV0flUbB4hP8IzDnFecLWxP+re32gb/Rab7G+RvvaUvSSNLZ
 QT8cVVWpcT4PrlCJPeISJV0SDOXxHdyJSK7lSRV8ONlcrmfF7DsauYAVdzennX+qUG
 IXWcnDLuiLQB81wMlInxRv7f36RnEfu1wqtz2YOVrThqQr1wDtWWP9AD850L0BNa2k
 kynlbPBjctgqA==
Date: Fri, 29 May 2026 14:10:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mfd: lm3533: Convert to use OF bindings
Message-ID: <20260529141031.62703eff@jic23-huawei>
In-Reply-To: <CAPVz0n1u0z35rP8vUKjAzW_mrPm9yeMjK_-nKbyctUvQik6ECw@mail.gmail.com>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-3-clamor95@gmail.com>
 <20260528155001.2bcb7003@jic23-huawei>
 <CAPVz0n0qCekQVGGyAyBuYv+RKC6bpydYBLJNGfPrgTYjtOJOuA@mail.gmail.com>
 <20260529100819.1823ebb3@jic23-huawei>
 <CAPVz0n0VHdUo5oHdALgcerLsykdz-2n7c+jxYHrMOV7Ra5x_qQ@mail.gmail.com>
 <20260529114828.5a87c732@jic23-huawei>
 <CAPVz0n1u0z35rP8vUKjAzW_mrPm9yeMjK_-nKbyctUvQik6ECw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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


> > > > > >         if (device_property_present(dev, "ti,resistor-value-ohm"))
> > > > > >                 ret = device_property_read_u32();
> > > > > >                 if (ret) //corrupt property in some fashion
> > > > > >                         return ret;
> > > > > >         } else {
> > > > > >                 //set default
> > > > > >         }
> > > > > > If there is no default then check it unconditionally.  
> > > > >
> > > > > default value is LM3533_ALS_RESISTOR_MIN and if no property is present
> > > > > clamp will ensure that als->r_select will be set to
> > > > > LM3533_ALS_RESISTOR_MIN  
> > > >
> > > > I don't see that default in the binding doc and relying in the 0 being clamped
> > > > isn't particularly readable - I'd set it explicitly.
> > > >  
> > >
> > > Oh, ye, my bad. Schema enforces one of props to be present and if pwn
> > > is present then resistor is ignored. What if I move resistor reading,
> > > clamping and conversion under !als->pwm_mode check? Then resistor must
> > > be present and hence must be checked unconditionally.  
> >
> > Sounds good.
> >  
> > >
> > > Additionally, I can comment original lm3533_als_setup with #if 0
> > > #endif then git formatting will be much cleaner and easier to review,
> > > and once we all come to result I will just remove entire commented
> > > block and Lee can pick clean commits.  
> >
> > No don't do that.  If you flatten the two helpers as a precursor patch
> > then the changes in here will be easier to review anyway.
> >  
> 
> By "flatten the two helpers" you mean incorporate
> lm3533_als_set_input_mode and lm3533_als_set_resistor into
> lm3533_als_setup first and then convert it to use DT? I am asking,
> just to be sure.
> 

yes

> > > > > > > @@ -852,25 +825,28 @@ static int lm3533_als_probe(struct platform_device *pdev)
> > > > > > >       indio_dev->channels = lm3533_als_channels;
> > > > > > >       indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
> > > > > > >       indio_dev->name = dev_name(&pdev->dev);
> > > > > > > -     iio_device_set_parent(indio_dev, pdev->dev.parent);  
> > > > > >
> > > > > > I'm not sure why this was there in the first place.  Hence not sure if it
> > > > > > is safe to remove.
> > > > > >  
> > > > >
> > > > > This is directly related to OF conversion. The iio_device_set_parent
> > > > > bound indio_dev to parent, and it causes problems with OF now since
> > > > > als output has its own node and binding it to parent if wrong. Same
> > > > > story for backlight and leds btw.  
> > > >
> > > > Is there any risk anyone was using the canonical path to get to the iio dev?
> > > > /sys/bus/platform/devices/..../iio\:deviceX
> > > > This is technically an ABI change be it a subtle one.
> > > >  
> > >
> > > Linux kernel has no users of this driver, and it is in "stale" state
> > > for more then 2 years (maybe even longer). I have cc'd Johan Hovold.
> > >
> > > https://lore.kernel.org/lkml/ZmBcvtLCzllQDWVX@hovoldconsulting.com/
> > >
> > > This this 2 y. o. discussion and there were no actions ore movements.
> > > I assume this driver in its current form has no more users. This does
> > > not mean that it cannot be revived though.  
> >
> > So, just to check, are you a user of this code or is this more trying to
> > help out with old code?
> >  
> 
> I am not insane enough to get myself into all this conversion if I did
> not need it. This is one of 2 remaining gaps in support of LG
> P880/P895 I own and support. I would really like to finally mainline
> all the patches I have locally since maintaining them becomes quite
> troublesome with time and additional patches layering on top.

Excellent! There are some odd people out there who do start on this
sort of thing despite no personal use case :)

Jonathan



