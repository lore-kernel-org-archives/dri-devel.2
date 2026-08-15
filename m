Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C9DC5B572
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 01:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D03710E0FE;
	Sat, 15 Aug 2026 01:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W+WLRV4F";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AAC910E0FE
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 01:50:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D9C3760008;
 Sat, 15 Aug 2026 01:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978641F000E9;
 Sat, 15 Aug 2026 01:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786758610;
 bh=ypH4yKyAk/pJH123N3O/sqv1uP1nyrfrsBdWm0d36VY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=W+WLRV4F20VcooCsrC8/7Cjf03Th7CgOf9PWVDkOwkqzxFXAy/lQRYYV4ep1Tm+pI
 iyEubOSK3u519Ncr9ERMyBnnUYKeN1ll98sfOCYhRhaxoi8HbqmW6/6rOeuuuvcIa9
 WbEmQ9DCl4kogtdd6QtzBhzOqqKMi4VpQecMoP9aNHb6Xo0lSYDkHpqSCxJbVVxd96
 RVDgSEBOoZAX5RKAAs1PSen88QHww8B49HeKo1EtwaQL18lWpwnAcxg2LA1rinLtX5
 eRM6Ugk6pDyKMt/DOfhTm4le/yV6dtlCKFlXM8f0Hdt5PuJBJI3hgwBHfsaYqujSkG
 myj9GG5mDPmKw==
Date: Sat, 15 Aug 2026 02:49:49 +0100
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
 linux-iio@vger.kernel.org, mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 02/14] mfd: lm3533: Remove driver specific regmap
 wrappers
Message-ID: <20260815024949.110c2ef9@jic23-huawei>
In-Reply-To: <20260731113632.158440-3-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
 <20260731113632.158440-3-clamor95@gmail.com>
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

On Fri, 31 Jul 2026 14:36:20 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> Remove driver-specific regmap wrappers in favor of using regmap helpers
> directly.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/iio/light/lm3533-als.c      | 79 +++++++++++++----------------


Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
