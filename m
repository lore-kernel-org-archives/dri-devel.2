Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECFCC5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45CB210E16D;
	Fri, 31 Jul 2026 14:54:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HE7KUako";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2F0610E16D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:54:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 341C542B9B;
 Fri, 31 Jul 2026 14:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F5FC1F000E9;
 Fri, 31 Jul 2026 14:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785509645;
 bh=1J69KhrZi+tCUCTcy0KQGCVDYT0irf6FmuwqoFPRASE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HE7KUakoPHqF/jJchSfHyZVglb2stswvwg9SFFTnxJV1Ce362pfu8smnPr5il6VZg
 wJJ99NXPd7nqvcc8GrZbbheT5M9nHjuk8XwbI8+oQUW0/Y8yogB5oCEeZurx1FuGpl
 XYIOcDGNv1KreKU39qtXkK4Ws9v8xu9g+EW9+d0DXrcHCS9L/07IGv0hqVD9ABoH2S
 26uwVrY1TxAlEoFSk2c6Wr2F9zyHa8ftHKIWJdzGa5g6nLQ8/RCeEfN9cDjb5FgAXt
 pWQKlOOER2mV6Aj9C1VOQvY5HemaKciEw1vprloTQPw6bbqQa5kS5U3HHX6z68mWe7
 bzZIV3bE6A0mQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wpocc-00000000Xpm-2yrU;
 Fri, 31 Jul 2026 16:54:02 +0200
Date: Fri, 31 Jul 2026 16:54:02 +0200
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
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata helpers
Message-ID: <amy3CuqWFS8ra89r@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-7-clamor95@gmail.com>
 <akeHfV45fs_wabFl@hovoldconsulting.com>
 <CAPVz0n1groC-4MxU-sjyPEDHYWqAweyBmVNC+iX4mVa_D3SnDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1groC-4MxU-sjyPEDHYWqAweyBmVNC+iX4mVa_D3SnDA@mail.gmail.com>
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

On Tue, Jul 14, 2026 at 04:32:40PM +0300, Svyatoslav Ryhel wrote:
> пт, 3 лип. 2026 р. о 12:57 Johan Hovold <johan@kernel.org> пише:
> >
> > On Wed, Jun 17, 2026 at 11:00:23AM +0300, Svyatoslav Ryhel wrote:
> > > The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are used
> > > only in lm3533_device_setup(), which in turn is only called by
> > > lm3533_device_init(). Incorporate their code directly into
> > > lm3533_device_init() to simplify driver readability.
> >
> > Again, this isn't needed. Why are you removing abstraction that improve
> > readability?
> >
> 
> Adding helpers to wrap custom regmap wrappers seems redundant. Regmap
> operations are pretty self explanatory without need in one-time-use
> helpers.

They are clearly not as easy to read so this obscures what is being done
and makes lm3533_device_init() harder to read.

Johan
