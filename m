Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F54C5B56D
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20A0810EAB5;
	Tue, 11 Aug 2026 07:26:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e1HiHCn4";
	dkim-atps=neutral
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07A3810E13A
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 22:46:18 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-44cb057311bso99424fac.0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786401977; x=1787006777; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6vKSn7IJifBrXS/CY6LXzOgG31cv6satHmdZfKI7Lkg=;
 b=e1HiHCn4DI+dFW6BK9O0oLJZ1dThEdpMDWyMjQ1rcBeRSbbigzqN1F17BBX1DQX1NH
 LzygdlKcF5YhVelDS+LW/IlIYubsbqUIAbpjVe3lP6Zwx+eZ/cNXEPYtiJ9c0Nd+IGQs
 Ro2O0RtWFJIN/t9EVlnioTUCA8BsboNekPp0JQqc47EolDv3WxoBfD7Dk+0CZ+atnI0L
 S6rqVYIZunnbrXr+L9wcJ9hZ2snkIfSHOKRiwtXpeHL35ajb+LK5bETrtqPBDdp2H6Dz
 PA5PMWyQ+zO+BFuNYngKmSmoPXAbqQR0GuWop/wfXmU0Dv8EtiVToI3T+FI0LVGjWQ2p
 4y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786401977; x=1787006777;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6vKSn7IJifBrXS/CY6LXzOgG31cv6satHmdZfKI7Lkg=;
 b=ImBpEq2Q/MNF2ZKTjO8NA2vg/ulmigT6g6179WrbEZgkhivzXsgDxCNtVXYr/V9+yG
 5xPA8VGwn+2avEKWD2oPQbKVN4PXRKlLz27vYea7wc6G2s+9ouQAVek4Mci9vMdWmRvZ
 M1M1AL6f8jvgTEeWCuzDeIncz0v0x3Z/hqhyjVVIP3YqCjn3pcafYTCT19hYK7F0rXk5
 JeLbDNlxljJwep5W66T5liu0y7XWwUErKgKGUB894HbTl40tBQT/WlfyGwg6iJ2pGOG8
 Bq18MmwEY58JNOk7Kf2MtRMJFnvQm1D/NYzlAlh58cAt5+dkP7z+usmyjHP2sZSvNyST
 3LKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPp28uBEugzm9rpJeWgwHGayMQenUcthlXeLBa+iJCSnOYPHqugzTVFno0M/SKf+EBbVsTG0QakhY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9ZuMQRj1X/Iu3iko8jPoR8mUc/kxIXcawB7TYRY2Q4pv4eV1O
 ksBOgFUsb1DVHFn4Gb+cDSuzXoH2GVY4mJQ+Hjyj3vllhFR3crKRJRiJ
X-Gm-Gg: AR+sD13NSlcag3NHxHdF7/jC1M4GV2Nwfp38XkbEk+0VITtzJG9y/FCsIQOyhzjSC2z
 bmLzhX2Pzvx7c4p0A3BXppc9kUQ41SyWiwXBdv2lr7NtONSZD8WUReSW37l07WyUWyRMtThdwyw
 lMRNBvN3rtxvDXagnek3LEKTzta5uiAzWipnuvoz/EJVVVSZI+mJnqcef/fzzv3BqZ3yclbADVQ
 jgi7Je+iRb+3rZ3V551fe4gz5eI3HxrhR7TPo8sOBLiWOwBPr3DRIAf6+4HU3nk9nyvYANsy3ft
 XZZ6vKdOqBYQxtYZlPczW2OUhlFHVXOdCK7Sww8LZBqdj+Q83n8FKowNsPNCdmiucyAoOSvw9Jg
 Vr4CgT/OCKchp1xm2uNSQjvvk4MQMnCThfO3Lvp48ib5dPngHUXYRkqKENjBnL+hjB/Ujai9+Db
 jAX/mw7pa0YFpJwA8RMMB38/tNk0BPYd9y3nlS5Mm54Sm5iZUG/S/cBvF321IlSjwLjA==
X-Received: by 2002:a05:6870:6120:b0:448:c946:9ae1 with SMTP id
 586e51a60fabf-4599eebfa44mr24566861fac.18.1786401977177; 
 Mon, 10 Aug 2026 15:46:17 -0700 (PDT)
Received: from gmail.com ([108.243.219.47]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-459f1a88ef6sm9276831fac.8.2026.08.10.15.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 15:46:15 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:46:12 -0500
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>, 
 Linus Walleij <linusw@kernel.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panel: samsung-s6d16d0: Use mipi_dsi_*_multi(); fix
 minor bugs
Message-ID: <anoquszHQ6LAMPbF@gmail.com>
References: <20260807-mipi-dsi-s6d16d0-multi-v1-1-c6179f6f3c98@gmail.com>
 <3aaca93e-ea45-4a57-9532-7fb95f23c4fa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3aaca93e-ea45-4a57-9532-7fb95f23c4fa@linaro.org>
X-Mailman-Approved-At: Tue, 11 Aug 2026 07:26:09 +0000
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

On Mon, Aug 10, 2026 at 11:57:06AM +0200, Neil Armstrong wrote:
> > +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = to_mipi_dsi_device(s6->dev) };
> 
> Ok why not keeping the original:
> 
> 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(s6->dev);
> 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
> 
> 
> It's much easier to read, for me at least, but I won't block it...
> 
> >   	/* Enter sleep mode */
> > -	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
> > -	if (ret) {
> > -		dev_err(s6->dev, "failed to enter sleep mode (%d)\n", ret);
> > -		return ret;
> > -	}
> > +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> 
> Add a comment you ignore the the dsi_ctx.accum_err and it's fine
 
> You could write:
> 
> 	if (dsi_ctx.accum_err) {
> 		gpiod_set_value_cansleep(s6->reset_gpio, 1);
> 		regulator_disable(s6->supply);
> 	}
> 
> 	return dsi_ctx.accum_err;

Thanks for the review, Neil. Will address all three in v2.

On the intermediate dsi variable, I prefer inlining it to keep one fewer
variable in scope, but I see the readability argument. Will revert it.
-- 
Thanks,
Akash
