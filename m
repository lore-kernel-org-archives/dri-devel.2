Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48A1CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 14:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E7910F2D4;
	Thu, 28 May 2026 14:54:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FZiTAqL5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA2E10F2D4
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 14:54:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D38796020A;
 Thu, 28 May 2026 14:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A4F1F000E9;
 Thu, 28 May 2026 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779980068;
 bh=PDEl4kKPc6iIqexxaYFEcgJVGHLTcyA6Gc83lceYzh8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=FZiTAqL55iNX2zlVq96qXv++ZhTH/cMMAlVouWHSt60HcngXMDVTplKN/6Zdf4XW6
 3RrCDhttq7DrsxzajbV2n7lRI1DgUjIne1EsgRx7fIERVKHk3z68G01nPIYqny9gYl
 uXyNy3Xdk+O0GmQM2Ve45girjhplwDtuA/dgY0Y/bJ7ZVAqKRF/sSiTQ9t/Dfii1rv
 G1LKVu3Xb6XCjQ5jvAk6sGKvRpwmDiQo4e5QarP5uOJft2h60GPkY0pQ5Q5ivPs/yp
 Kma1FTJJIND11XzU6sc6o7LajDjGiZExDDrTNq8/szb9BwxOc9IThbQchufOEqgdot
 JB0a99ICbsnXQ==
Date: Thu, 28 May 2026 15:54:16 +0100
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
Subject: Re: [PATCH v2 1/6] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <20260528155416.26cc42ad@jic23-huawei>
In-Reply-To: <20260528135123.103745-2-clamor95@gmail.com>
References: <20260528135123.103745-1-clamor95@gmail.com>
 <20260528135123.103745-2-clamor95@gmail.com>
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

On Thu, 28 May 2026 16:51:18 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Document the LM3533 - a complete power source for backlight, keypad and
> indicator LEDs in smartphone handsets. The high-voltage inductive boost
> converter provides the power for two series LED strings display backlight
> and keypad functions.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---


The light sensor binding looks fine to me. I didn't check the rest.

Reviewed-by: Jonathan Cameron <jic23@kernel.org> #for light sensor

