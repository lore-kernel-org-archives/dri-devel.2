Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D46C5B572
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 01:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1318010E127;
	Sat, 15 Aug 2026 01:57:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lzZFlhvF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A901610E127
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 01:57:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47996423DC;
 Sat, 15 Aug 2026 01:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CD61F000E9;
 Sat, 15 Aug 2026 01:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786759058;
 bh=9zVksnQyuPy07Sp7sNksTJnIRmmkQHtYXS8UklOtV60=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=lzZFlhvFFzT7JNr11cvMu4yCeFnhSny1TroFsX2oiTWNjfDTiOEZTqJqGWdEGU9rl
 bby36qoqoQ7Dw1aAMu2RPox6lSE6bOg/yzO+JvRmbGCoafKNJ0Fj0SXVsjJQ1pW2eF
 m+nubQelGmT9gTU8c4s7PXn4h/8J9HBYXoEa19sEbQ4tmPqm+TkVJAVkGC5gihMOLY
 VpNX9kFcIFqTWesxMGNL/WOKYDO8/Inbh1NhPtTa210nFttRUEfbP4joyQT4vCQFFM
 wBDXl5J0nQsvaYB/47BTntXz7YNNTk/l4XwRL6pVNnbapp3t8tN3Oy3UGaUvTV9lKO
 GuH0WGA90Z54g==
Date: Sat, 15 Aug 2026 02:57:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Daniel Thompson
 <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Pavel Machek
 <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold
 <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 08/14] mfd: lm3533: Convert to use OF bindings
Message-ID: <20260815025717.05a1bbfd@jic23-huawei>
In-Reply-To: <20260811191132.GA1072730@google.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
 <20260731113632.158440-9-clamor95@gmail.com>
 <20260811191132.GA1072730@google.com>
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

On Tue, 11 Aug 2026 20:11:32 +0100
Lee Jones <lee@kernel.org> wrote:

> Jonathan,
> 
> IIO ack please, mate.

Oops. Not sure why I failed to notice the IIO parts in these other patches.

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> #for-iio

Thanks for the poke!

Jonathan

