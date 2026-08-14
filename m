Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4A0C5DF70
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E9210E2F7;
	Sun, 16 Aug 2026 14:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=dewith.io header.i=@dewith.io header.b="OtnwFJCd";
	dkim-atps=neutral
Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B157E10E02D
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 17:58:24 +0000 (UTC)
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by meve.dewith.io (Postfix) with ESMTPSA id 7005F238C4;
 Fri, 14 Aug 2026 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default; 
 t=1786730302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d3OSKF+fc/ftZbxaCIXYwiQoEpv2eaHUd9Rrn/IRaEk=;
 b=OtnwFJCdkB/JV32wn9xNz0UbCuMmNsNrbQarOg6Y/1KFOMEevIJXoBBKhFSyEm7axIK+7l
 NT3P8pz+5qbGSpCzxKY/2UQoZ0WpbboVQnJIgNYSVrnmkxgFdomGBPIweEBQv8e8sQtoT/
 ckYMgOpFOxxRjroRjFh95PqFMkfytmE=
Date: Fri, 14 Aug 2026 19:57:58 +0200
From: Wim de With <wf@dewith.io>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <an9XJmcXq_EUjY5y@dewith.io>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
 <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>
 <20260814-peculiar-mega-mandrill-3a3148@quoll>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-peculiar-mega-mandrill-3a3148@quoll>
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:05:11 +0000
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

On Fri, Aug 14, 2026 at 11:22:15AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Aug 12, 2026 at 09:21:47PM +0200, Wim de With wrote:
> > +	props = (typeof(props)){
> > +		.type = BACKLIGHT_RAW,
> > +		.brightness = brightness,
> > +		.max_brightness = max_brightness,
> > +		.power = BACKLIGHT_POWER_ON,
> > +		.scale = BACKLIGHT_SCALE_NON_LINEAR,
> > +	};
> > +
> > +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ocp8178,
> > +					    &ocp8178_bl_ops, &props);
> > +	if (IS_ERR(bl))
> > +		return dev_err_probe(dev, PTR_ERR(bl),
> > +				     "failed to register backlight\n");
> > +
> > +	platform_set_drvdata(pdev, bl);
> > +	backlight_update_status(bl);
> > +
> > +	dev_dbg(dev, "probed, brightness=%u/%u\n", brightness, max_brightness);
> 
> You should not have probe success messages even as debug. It's not
> printing anything useful as brightness is fixed (comes from DTB) and
> devices appear in sysfs thus you can check them. Printing debug probe
> success messages applies for core SoC drivers which might fail before
> reaching initramfs mount and starting init.

Clear, will fix in v3.

Regards,
Wim
