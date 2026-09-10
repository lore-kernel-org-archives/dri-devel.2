Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4B2C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E541010E27C;
	Thu, 10 Sep 2026 14:06:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HQbQBE3S";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E6610E27C
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 14:06:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC97D60202;
 Thu, 10 Sep 2026 14:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B591F000FF;
 Thu, 10 Sep 2026 14:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789049192;
 bh=g1LxwTgpYFNZEHQDmeS6XR82COxB2wINTdd76rmn4vM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HQbQBE3Sp2Z1toTEurJrkDPxOu+Hd2Y0g6UyESX16c/6EenWyOJeNJPY3ngZvBzTw
 VXBY34FsqHxqlHe0cWraSrHh+kCjD+ig/BoM/uvS8VrKrVjsAygiJqvq1B0I3t49Yj
 KULXpCc1Xak/cbLu6L2T8JLeNvl36E/8r0Q0U1D/DxciBq7338EyuTyhW59NtKBAJr
 ddDoeCbgQIPS3yW0Zt0FKcTv8kf684umKiKEiEzlfcCLQk1bZ8gLm8OwMrzOQ257oU
 ELmd8VsmvhUD6A6CMUSd8ZAhIEK0QVl6GB2Pmw7ueRoE6on2rFJpbGPbq0yuxLPy6V
 mZYVUcKzffljQ==
Date: Thu, 10 Sep 2026 15:06:25 +0100
From: Lee Jones <lee@kernel.org>
To: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 00/14] mfd: lm3533: convert to OF bindings, improve
 support
Message-ID: <20260910140625.GD1051768@google.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
 <178904903999.1172658.13303214372114400299.b4-ty@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178904903999.1172658.13303214372114400299.b4-ty@b4>
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

On Thu, 10 Sep 2026, Lee Jones wrote:

> On Fri, 31 Jul 2026 14:36:18 +0300, Svyatoslav Ryhel wrote:
> > Convert LM3533 to OF bindings, add missing VIN supply, add support for
> > setting mapping mode and LED sources based on device tree.
> 
> Applied, thanks!
> 
> [01/14] dt-bindings: leds: Document TI LM3533 LED controller
>         commit: 0747740a123b844a87f7b86977845ccaca15362b
> [02/14] mfd: lm3533: Remove driver specific regmap wrappers
>         commit: f022c47f4843462cd02f1163f624631f7f4e409e
> [03/14] mfd: lm3533: Remove extern from shared functions in the header
>         commit: 06ea59b4135ed6c999bc33daca1abf51071f5f53
> [04/14] mfd: lm3533: Pass only regmap and light sensor presence to child devices
>         commit: f6420210fbaf563de34c769f4a408790523bc36c
> [05/14] iio: light: lm3533-als: Remove redundant pdata helpers
>         commit: 948c42932e0b696de11a2aee69a81d8a6f83dd12
> [06/14] mfd: lm3533-core: Remove redundant pdata helpers
>         commit: cdc9de135bc4bac7b7a344e76bef8e7e6cfb3e16
> [07/14] mfd: lm3533: Use dev_groups in struct device_driver
>         commit: d172f3814461c91db5af71fb628601af8389a3ee
> [08/14] mfd: lm3533: Convert to use OF bindings
>         commit: 5669316d7055325d981b5a37f574299c848af581
> [09/14] mfd: lm3533: Add support for VIN power supply
>         commit: 4a2300981a68c8f6ef5c667d6f81667c4036b269
> [10/14] mfd: lm3533: Set DMA mask
>         commit: 95a968ec7c31d70d4e38840409c3983ca7cac937
> [11/14] video: backlight: lm3533_bl: Improve logic of sysfs functions
>         commit: 92992a77a4c471064cec8398310c3f9486340c16
> [12/14] video: backlight: lm3533_bl: Set initial mapping mode from DT
>         commit: 879dd08125dbec68ea0d5b624aa8c42175232637
> [13/14] video: backlight: lm3533_bl: Implement backlight_scale property
>         commit: 0077e5ed836a01a0c82f23b91afdd38e42ace8b8

Submitted for build testing.

I'll send out a pull-request once that passes.

Note to self: ib-mfd-backlight-iio-leds-7.4

-- 
Lee Jones
