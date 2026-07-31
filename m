Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9F9C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA29310E22C;
	Fri, 31 Jul 2026 14:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GnPU6xko";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4876A10E22C
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:39:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A9B5600C3;
 Fri, 31 Jul 2026 14:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1F71F000E9;
 Fri, 31 Jul 2026 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785508782;
 bh=ryPqQ3wPmCBEPuGEr6/KTKvRORIV9Tt/Y/mcOa0Awic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GnPU6xkoCSSVpSd9iPfsPBPZCeAS+4H/65Muv9K6QtU0IZw0TWPIWncaa0SGtheuS
 fTBmVUq65ERZCUU4zP2C0rFB3Nrm4U/8NWZ3Liia20PL5BdBl2RJwaWYmvoFwp8aGu
 JWOY7oAtUj3zCBbS11A6El3u3UQxIIK+rn5KBbyvSLNNDIUNRC/8zB0k1UItgMT/as
 D+R4qB1UJKMOT9Y4NyLbdySxnHTNXEwt6ygWDnRdImiQYlqY5YIehRr0Dk6OXUyJbo
 aTbaMg/eBW56zuXqd0PyyGTgxmLyPtfgwbLFDD3YLxoSwnK0FMz3rc6G2JsEpvwNGJ
 4dHJWkcIgNUtQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wpoOh-00000000XLr-3kZN;
 Fri, 31 Jul 2026 16:39:39 +0200
Date: Fri, 31 Jul 2026 16:39:39 +0200
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
Subject: Re: [PATCH v5 01/14] dt-bindings: leds: Document TI LM3533 LED
 controller
Message-ID: <amyzq2XEhiOH28DD@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-2-clamor95@gmail.com>
 <akeFmMQ_S1Y18hlu@hovoldconsulting.com>
 <CAPVz0n23=F2Q2fSJJx1E_mST2zhomKcvhKtOy-Af3aoq-pZ-Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n23=F2Q2fSJJx1E_mST2zhomKcvhKtOy-Af3aoq-pZ-Zw@mail.gmail.com>
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

On Tue, Jul 14, 2026 at 04:27:08PM +0300, Svyatoslav Ryhel wrote:
> пт, 3 лип. 2026 р. о 12:49 Johan Hovold <johan@kernel.org> пише:

> > > +            light-sensor {
> >
> > Doesn't the binding (or dts) checker complain about this node not having
> > an address?
> >
> 
> No it does not

Thanks for confirming.

Johan
