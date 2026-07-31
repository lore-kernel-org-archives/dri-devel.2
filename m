Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA658C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 14:38:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20DAF10E219;
	Fri, 31 Jul 2026 14:38:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F2OIJ/c2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE74F10E219
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:38:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D4F7417D9;
 Fri, 31 Jul 2026 14:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7AB1F000E9;
 Fri, 31 Jul 2026 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785508719;
 bh=JQiPASeI+iTk/iM+gPxiK5b1Sn7IYzuuwj7/KQy1pNk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=F2OIJ/c2wlmtSr+JDjj7YQ4RcoXEofmSmIDQB6qVzdbRBjw8aTCXQmBbdCMQlynu6
 AYjO8hygFXtRNpgU3jNGD33VyI+U3oN4yqFn4OsPl5OiSX0hXTxfGt/kz5F57pJBEp
 cKasEF5p9lIwGwdQnqJq1dalK7jw3oOScIcU5AK6mpHUjW5GAhNH4VqajksOzaKXdk
 nR/NE4CRKGdaMEyOIgVxer3UlWLlwKNdracL7t+dg4U20T69/RRjeDlcQpwgdwg0Li
 UMs8XMCbGNBysAeSgiEMEXwB7HPNZcKgHvHF+isJVxY0V1NQhisZtwrfUGcW5YBEmQ
 jIUaIpfOeXXTg==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wpoNh-00000000XKw-0VDc;
 Fri, 31 Jul 2026 16:38:37 +0200
Date: Fri, 31 Jul 2026 16:38:37 +0200
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
Subject: Re: [PATCH v5 02/14] mfd: lm3533: Remove driver specific regmap
 wrappers
Message-ID: <amyzbWTFRpCxeHCY@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-3-clamor95@gmail.com>
 <akeEd0GcHSqScGIl@hovoldconsulting.com>
 <CAPVz0n1aYREgo9Mqb2fioQKTKa478rhMYPJJjcUagjCGNTzMgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1aYREgo9Mqb2fioQKTKa478rhMYPJJjcUagjCGNTzMgw@mail.gmail.com>
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

On Tue, Jul 14, 2026 at 04:26:49PM +0300, Svyatoslav Ryhel wrote:
> пт, 3 лип. 2026 р. о 12:44 Johan Hovold <johan@kernel.org> пише:
> >
> > On Wed, Jun 17, 2026 at 11:00:19AM +0300, Svyatoslav Ryhel wrote:
> > > Remove driver-specific regmap wrappers in favor of using regmap helpers
> > > directly.
> >
> > The commit message should explain why you think this is a good idea.
> >
> 
> Removing custom wrappers over standard regmap helpers is always a good
> idea, that is self explanatory.

No, and especially not if you're removing functionality.

> > Based on a quick look you lose the errnos that were logged on errors and
> > also the register debugging provided by those helpers.
> >
> 
> That is not true, regmap helpers will provide logging and you should
> not include debug stuff into the final submitted driver unless you
> have a extremely valid justification for this, debug logs should have
> been removed once the driver development was completed.

The regmap logging is a compile-time thing (added after the driver was
merged), and not equivalent to what the driver provides currently.

The driver also currently relies on these helpers for logging errnos.

Johan
