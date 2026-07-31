Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A985BC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D006010F2CF;
	Fri, 31 Jul 2026 15:18:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CkodmYSs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EA1E10F2CF
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 15:18:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58FBE6004E;
 Fri, 31 Jul 2026 15:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080EE1F000E9;
 Fri, 31 Jul 2026 15:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785511117;
 bh=8VpTkr4DQGJg1eGBe9qqD14xMAfZLna6BfxP2pjcrGA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CkodmYSsbMWGnK2GEAqRlirwlKGlzq+ALm3zzV809VZbenZ8mVIryF8if3+OXUDXT
 uJ8K83V1p5Gpy+mBXoY/jA2Ls/hws66H8Nz1EhxCkFeDJ5GG2uyXUdxO1IVDRjgbgy
 8dKCxbmfnBasSFp+hk6R+YxwLlrqs3Bb0rs81+S/4qbL7/UIaipQxMmilWa7S/0REE
 pTEtpv7zWWbyganScFBvmsA3r+hkZASk6cCELviljCZcX6fQrSdRLUOWV1pY7m8MaN
 kQ8QayPde2gHPSki6rRMRfdP7kwHi6vKxQu7sFo4cA+sEaaQg6+Vmo37n37jjNQvrX
 P0fFhEY2y4dqg==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wpp0M-00000000YMu-2PuH;
 Fri, 31 Jul 2026 17:18:34 +0200
Date: Fri, 31 Jul 2026 17:18:34 +0200
From: Johan Hovold <johan@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 00/14] mfd: lm3533: convert to OF bindings, improve
 support
Message-ID: <amy8ygTAV49s2C4z@hovoldconsulting.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
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

On Fri, Jul 31, 2026 at 02:36:18PM +0300, Svyatoslav Ryhel wrote:
> Convert LM3533 to OF bindings, add missing VIN supply, add support for
> setting mapping mode and LED sources based on device tree. 
> 
> ---

> Changes in v6:
> 
> - expanded commit message in OF conversion commit
> - restored original comment regarding PWM mode of ALS
> - switched to FIELD_PREP macro in core for helper flattening

You seem to have ignored many issues pointed out in v5 so please go back
and review those comments again.

Johan
