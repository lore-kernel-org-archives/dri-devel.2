Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDCFC982C1
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 17:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 630DB10E3FD;
	Wed, 16 Sep 2026 17:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RvXt4WOZ";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7855E10E3FF
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 17:25:22 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d3931so8671095e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789579521; x=1790184321; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0doTaXzV/w8IQT4ZiZuatHsziHZ5r643yvXjLE62Mno=;
 b=RvXt4WOZhfgrjo6QuxsbXAtT8Lf8SmqiPGhG32uSXdUf5S4rWG+g5uTmJzdQy6fueD
 ywFRYq43MfvFlWM6XibbmGx5zFmqN9ATIGACfJLcStWkXihpeIM1c83NvSPT6vO6jHmW
 c3ZcKe2yfcTA25lzSVjagvnK6S4Q4bVsry3GYJSADsNZtcKncVmbsS5prTHQsca/SBQ3
 Xylvvk4cwBd/gLxIiKPZ5exj0EZlLnhDDJQsKzdAWbUVwFiNERmvZuV9l7SwZDmx3VfQ
 HjYTJt4U7SJDmhmgRvBMmdjqMftHtIeG9spcYnE8VREyZQkaP4bDSWJzEu1wSP6bTl4C
 CtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789579521; x=1790184321;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0doTaXzV/w8IQT4ZiZuatHsziHZ5r643yvXjLE62Mno=;
 b=RMtr9QgI8E1DBSIH33/PuhqhuMY77XyMHnZdfTzz++tKGDAJFO/n54z+b5/lkNBbeb
 xBJWWS/I0cBZI9nzlZXMkWGOUSxc8ULpfF1kLpaA6niS7LvbsYWfY6GawNLzq33g+P6M
 s+I7mPzDpb8GhFfR6FsW+8L8UcZT9OxB0ngnA0EDK3N+a5E+5r+fLrsWfXV48+aR6lLT
 WYiKgDwAZgC+CBPbXnyKJyo6v/MQi3Z2d1gIKGYbtf2AM7UdU7eE5pa4TfyJjcshVXc2
 j/LCA6T1YE17mEOMMlI6HFTdOHFbTU4KRP4wEce6pYDftBfVJNVV1g9Ye5wC4JSKLqMT
 J5pw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2EhBZmomZndLWIksdPB0yWanVmx8/B+duBOiCdNX/vY5P56JDtCM74Q6EK8euSeyYWLfMFLvbqdU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l5uCgInp05UyX9QeY27861lJYzqfcu2AqevpkUPtN2BKal+g9H
 bpzUKGaWVch1DlE+0T/SyTQdJJ/rKkibzjQQd6vli/JGzXPmQ6oFEgdZ
X-Gm-Gg: AYBFou3N+i+2WZk+buOUVnIXU0i971xT7DIR7hv0x2ItCgefGwIYjcP/OEsfOlGOmo9
 zlJUFxJLQGgSNBHT7pARr5e5cDOk3JjfZN8JDFW7rp+r5AYnnCJ2IuDh2l1KKkzSzv4mXvougvW
 /84n2eBrrWC6lOqgduDA0YVkgvNVO6EQlWtkprQw4X5uwdlnGb11EXwBKt5q9gGGh7S9NDHWDaF
 gnjC0VwkRjaSG6kKXOfC0Sjvis+AgWxN6N6Skr/9xuw4JlgL/vLdg+3e2/uwfO8Gb0Df+gm2qLp
 LRQMbhOLWaGtCQtNOnDyAJGf4EHK1/EEJjhcIurXwghiFxLzY4QWvG7s9JWCvSedEG5P2ErkS8Y
 tVaj8oDczIOnugIhovSjZptfKGxD+H3ywQVBIkZUlV5vJc0aO0ZQqXWO+mPfVW4YDAtzJ0q4Mnx
 gsh3KXXXH5jzkw5lC3+b85ciTwX+i9CtD/M4ZLA9V0q1X3jffwTE1GitTtBSEFBknnc2PHJYPWO
 +YBLAFX7m2+g03gFuOWKtvgOluCB5ij
X-Received: by 2002:a05:600c:1d0d:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-49eb72f3835mr41594715e9.9.1789579520496; 
 Wed, 16 Sep 2026 10:25:20 -0700 (PDT)
Received: from osama ([156.223.29.202]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fe7esm8546312f8f.6.2026.09.16.10.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 10:25:19 -0700 (PDT)
Date: Wed, 16 Sep 2026 19:25:16 +0200
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] drm/panel: simple: Use managed helpers in
 panel-simple
Message-ID: <aqrQ_BDn67QXG94p@osama>
References: <20260915145935.60397-1-osama.abdelkader@gmail.com>
 <20260915145935.60397-5-osama.abdelkader@gmail.com>
 <DLGKRRWANR4E.1AG4LI99DCJ2F@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLGKRRWANR4E.1AG4LI99DCJ2F@bootlin.com>
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

Hello Luca,

Thanks for the reply.

On Wed, Sep 16, 2026 at 09:50:35AM +0200, Luca Ceresoli wrote:
> Hello Osama,
> 
> On Tue Sep 15, 2026 at 4:59 PM CEST, Osama Abdelkader wrote:
> > Use the managed panel add helper in panel-simple and drop the manual
> > panel remove call from the remove path.
> >
> > Keep the MIPI DSI attach and detach manual, since panel-simple's
> > remove callback also unprepares/disables the panel and releases the
> > DDC adapter; deferring the detach to devm would run it after that
> > cleanup instead of before, changing the teardown order.
> >
> > Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> 
> Thanks for continuing the cleanup.
> 
> However there is still some confusion in how you are sending patch series:
> 
>  * You sent the patches to various recipients including mailing lists
>    (which is OK), but did not send the cover letter to mailing lists. I got
>    the cover and it only has me in To: and nobody in Cc:.
> 

I see, I used:
git send-email --to-cmd='scripts/get_maintainer.pl --no-rolestats' --to=luca.ceresoli@bootlin.com v6-000*
get_maintainer.pl doesn't return maintainer for the cover letter.
Thanks for the notice, will fix that.

>  * You sent two iterations the same day without an explanation; this is
>    normally a confusing behaviour, which makes sense only rarely and for a
>    very good reason which is clearly explained in reply to the previous
>    revision (e.g. "sorry, this series is broken, ignore it, sending a fixed
>    one very soon")
>

Sorry for the confusion, once I sent v5 sashiko-bot caught couple of issues
including compile errors, that's why I was in rush to fix that.

>  * The panel-simple patch disappeared in v6, why? (see next question)
>

There was a concern from sashiko-bot on v5 that the devm_ changes in panel-simple
may lead to use-after-free window, that's why I excluded patch 4 in v6.
I have to write that in changelog, yes.

>  * The Changelog for v6 (not visible on mailing lists) is overly verbose,
>    so I didn't even try reading it. Please use oneliners or so. And in case
>    you did, don't uncritically copy-paste AI slop. Think about your readers
>    and te minimum info they need.

I see, I took sashiko report copy/paste. It's too verbose, will clean it up
and summarize it in next version.

> 
> I think I already suggested using b4 to send your patches, which would
> handle the mechanical aspects for you. It prevent issues like the first
> bullet above.

I will try it, I just didn't use it before and didn't want to make something
wrong so tried to stick to git send-email.

> 
> Can you please send a v7 with the above fixed, as well as the changelog
> made concise (including the v5 and v6 entries)? I'll be glad to review
> that.
>

Sure, thanks.
 
> Kind regards,
> Luca
>

Kind regards,
Osama
 
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 15 ++++-----------
> >  1 file changed, 4 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index c95964ba25a9..02d21dde5766 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -737,7 +737,9 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
> >  		goto disable_pm_runtime;
> >  	}
> >
> > -	drm_panel_add(&panel->base);
> > +	err = devm_drm_panel_add(dev, &panel->base);
> > +	if (err)
> > +		goto disable_pm_runtime;
> >
> >  	return panel;
> >
> > @@ -785,7 +787,6 @@ static void panel_simple_remove(struct device *dev)
> >  {
> >  	struct panel_simple *panel = dev_get_drvdata(dev);
> >
> > -	drm_panel_remove(&panel->base);
> >  	panel_simple_shutdown(dev);
> >
> >  	pm_runtime_dont_use_autosuspend(dev);
> > @@ -6540,7 +6541,6 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
> >  {
> >  	const struct panel_desc_dsi *desc;
> >  	struct panel_simple *panel;
> > -	int err;
> >
> >  	panel = panel_simple_probe(&dsi->dev);
> >  	if (IS_ERR(panel))
> > @@ -6551,14 +6551,7 @@ static int panel_simple_dsi_probe(struct mipi_dsi_device *dsi)
> >  	dsi->format = desc->format;
> >  	dsi->lanes = desc->lanes;
> >
> > -	err = mipi_dsi_attach(dsi);
> > -	if (err) {
> > -		struct panel_simple *panel = mipi_dsi_get_drvdata(dsi);
> > -
> > -		drm_panel_remove(&panel->base);
> > -	}
> > -
> > -	return err;
> > +	return mipi_dsi_attach(dsi);
> >  }
> >
> >  static void panel_simple_dsi_remove(struct mipi_dsi_device *dsi)
> 
> 
> 
> 
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
