Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085CEC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425AF10F2B9;
	Fri, 31 Jul 2026 14:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YlY9V6Z6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD31510F2BC
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:43:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9723B43242;
 Fri, 31 Jul 2026 14:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 722C01F00A3A;
 Fri, 31 Jul 2026 14:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785509015;
 bh=GNY36rin3dwLur+0LRzxKLX3kZHncZvjakN/xZMe7+o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YlY9V6Z6kU1oDHrFwCbqNs5bVFZkOKRc5FU8HOVMEQz47vfb2XZ/Dx2ZHik8o5VJC
 U+TpIt/MiJHYMnhSKHK/rATf6ZGsO87Wfm86Dw1Tk42/Dlm3aASAYP0FERPL98OOUs
 fI8HiF1AD8GsHmwAklfoyFjydG43UJ5b+8P1Gh7Ma0hN9XZypyfmORKpIfvez2M6AY
 xxtIIT/I9fTkgW2o6EU1hE2PTI0NRWhGXE6YZquWg1cT0LQDXXbBTTB3PGAFoKVDYl
 MrDeXGL2fYMPfWFYJDIDnghs4O/Z56haE4GrzTg/4GG6N/VnR8SEAa8Em74w2/kSV1
 +ZNKw1+nHusAg==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wpoST-00000000XdU-17IA;
 Fri, 31 Jul 2026 16:43:33 +0200
Date: Fri, 31 Jul 2026 16:43:33 +0200
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
Subject: Re: [PATCH v5 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
Message-ID: <amy0lU289vvQzslO@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-5-clamor95@gmail.com>
 <akeF_VrijPbebz3I@hovoldconsulting.com>
 <CAPVz0n1+wrq+g3p3UTc3hzHcsz8k02=QsvmseBD45d+SoSFsBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1+wrq+g3p3UTc3hzHcsz8k02=QsvmseBD45d+SoSFsBw@mail.gmail.com>
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

On Tue, Jul 14, 2026 at 04:28:24PM +0300, Svyatoslav Ryhel wrote:
> пт, 3 лип. 2026 р. о 12:50 Johan Hovold <johan@kernel.org> пише:
> >
> > On Wed, Jun 17, 2026 at 11:00:21AM +0300, Svyatoslav Ryhel wrote:
> > > Instead of passing the entire lm3533 core data structure, only pass the
> > > regmap and the light sensor presence flag to child devices.
> >
> > Again, why?
> >
> 
> Because none of the child cells needs entire parents private
> structure, regmap is all that is used.

Just because you can do something doesn't necessarily mean you should.

Johan
