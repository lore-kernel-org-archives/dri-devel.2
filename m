Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B641FCD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 13:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F74C10F16F;
	Tue,  2 Jun 2026 13:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SDtmw7I1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C66210F16F
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 13:55:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B95A6012B;
 Tue,  2 Jun 2026 13:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F1E1F00898;
 Tue,  2 Jun 2026 13:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780408524;
 bh=sljko7EGYJT4k2cGwdNNUTr7psxvYPFJ2CYPrG4x8K4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=SDtmw7I1dRJY72MHNFC/5ewuFKIusLhI+OZIs2LoF8eqkO/svskqMP9rsjmOFCSMj
 Tn+EBLjNbmqFtujEASxcouZVZSsAACAfqrmLjsg5rYelX67jTrETWuGTonTcJ8eGWb
 Yn0HJod1OLFTedRuuLEOANxcpH/nSB7QFSGo8mPh9HOV+ifz0MKmmBJJ3JpZ0EJtha
 wTNSuMqq5MF+TWdy3n0qEiwxnUNA/OR7ckG1Ki9r1/EPx/to3eLCHVK6ScEvdxqxxc
 iXPG6CtQZDEo/QRcIJglZqqc5nyxFRBcTox73A/4j33KHB1ywZn4DSPHYIHjLPi0nK
 ldx3E8h8+0BGA==
Date: Tue, 2 Jun 2026 14:55:17 +0100
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
Subject: Re: [PATCH v3 08/11] video: backlight: lm3533_bl: Improve linear
 sysfs logic
Message-ID: <ah7gxfiJn6wLRoA6@aspen.lan>
References: <20260601151831.76350-1-clamor95@gmail.com>
 <20260601151831.76350-9-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601151831.76350-9-clamor95@gmail.com>
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

On Mon, Jun 01, 2026 at 06:18:28PM +0300, Svyatoslav Ryhel wrote:
> Simplify the sysfs logic of the linear property by switching to a macro
> and a ternary operator.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

With the change to regmap_assign_bits():

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
