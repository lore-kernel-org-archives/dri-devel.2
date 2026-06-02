Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430A6CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 14:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BD6A113A21;
	Tue,  2 Jun 2026 14:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bdv/8kjZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20D8113A21
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 14:06:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 094F96001A;
 Tue,  2 Jun 2026 14:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481F71F00893;
 Tue,  2 Jun 2026 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780409170;
 bh=jjkON13fuXPua8qhknMzbj0t+F8+cBDpmMJLaAHfpt4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bdv/8kjZHcHOa++NveCq8QUeOX+VUa6c3IH4/LJsrMwwnlqduTsXJI8EK6vpGiYfD
 TSPo8ZO2NAK5ZlGElKZQwlK8MmFpnnlVaN2KSFMt/7bouHU6+DiaEXncnPWfMsS2pz
 ZzVkSUWlOej5wsF6moEGkgFnVVYYiSOMqLS4YBLc0T+MfWK9VRDZx54FuOeoEh//hi
 KOK1sZfp+dyWqx777OOjJ4xP1SUZHzAMwax7WZbCDiFPsTkx0ADGEWnZ3Y1NXcyc6i
 VdY23ykWAGnocLGnSr9sTTke5xSWg72cVRUtiothsWt09Imqp2VRMVZ9Auop8Dy1fj
 pd/sOvb5Qy0Cw==
Date: Tue, 2 Jun 2026 15:06:04 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 10/11] video: backlight: lm3533_bl: Implement
 backlight_scale property
Message-ID: <ah7jTGHj6c6aJ1RO@aspen.lan>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-11-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601151831.76350-11-clamor95@gmail.com>
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

On Mon, Jun 01, 2026 at 06:18:30PM +0300, Svyatoslav Ryhel wrote:
> Since the device supports linear and non-linear modes, implement the
> backlight_scale property to describe this state.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

Thanks!

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
