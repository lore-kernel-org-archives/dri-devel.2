Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C285C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA5E10E102;
	Fri, 14 Aug 2026 09:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J2Gi1Qeg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F86B10E102
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 09:22:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7FB91414DB;
 Fri, 14 Aug 2026 09:22:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260041F000E9;
 Fri, 14 Aug 2026 09:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786699344;
 bh=/BE5TBGxjSVANRjvlpPQ+jBGmT/P99F+2F3AmRMyMRI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=J2Gi1Qeg9af4pXA15rxLOYF98Mv79l2nNHVq3SFuXK/xWrrjdtu6XXbSzSBTAhdjE
 jOX5m0k4LAh/uKg0oNsf5pftVzGwMoOVRGacwJHrsH7GGjkO2xiO4/UZwf2gKAezsu
 KvkwvIf2k0aFatQnPDoyzlptCWl+TJ5fwO0gvrQoQRibByUFN3IDq/shJ5Jb5vtSe6
 +IwG98Av+lTQaF4hLQmz/fQe0DOcefvng/bnYVSHDHEhMBweejgK2iBUw640wG33TI
 Uq9QCr8TpofGVRuYFg80mEVltk/vDK2EnGQ0K33UCYtW5zB5xGiCRzburH6cmIQ91S
 TD2IcHVtQeLzA==
Date: Fri, 14 Aug 2026 11:22:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim de With <wf@dewith.io>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <20260814-peculiar-mega-mandrill-3a3148@quoll>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
 <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>
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

On Wed, Aug 12, 2026 at 09:21:47PM +0200, Wim de With wrote:
> +	props = (typeof(props)){
> +		.type = BACKLIGHT_RAW,
> +		.brightness = brightness,
> +		.max_brightness = max_brightness,
> +		.power = BACKLIGHT_POWER_ON,
> +		.scale = BACKLIGHT_SCALE_NON_LINEAR,
> +	};
> +
> +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ocp8178,
> +					    &ocp8178_bl_ops, &props);
> +	if (IS_ERR(bl))
> +		return dev_err_probe(dev, PTR_ERR(bl),
> +				     "failed to register backlight\n");
> +
> +	platform_set_drvdata(pdev, bl);
> +	backlight_update_status(bl);
> +
> +	dev_dbg(dev, "probed, brightness=%u/%u\n", brightness, max_brightness);

You should not have probe success messages even as debug. It's not
printing anything useful as brightness is fixed (comes from DTB) and
devices appear in sysfs thus you can check them. Printing debug probe
success messages applies for core SoC drivers which might fail before
reaching initramfs mount and starting init.

Best regards,
Krzysztof

