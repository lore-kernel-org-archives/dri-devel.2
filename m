Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1926C44500
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19B4210F732;
	Fri,  3 Jul 2026 09:44:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AbNex+b9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F98110F732
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 09:44:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A11E560051;
 Fri,  3 Jul 2026 09:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9881F00A3A;
 Fri,  3 Jul 2026 09:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783071866;
 bh=g84Zki9ut8BoJRtesayIjwjtg5cf3L/XXhsEbFb1vBQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AbNex+b9+HGTx0UYbFnxDe+8LXC1LOM7a5Dp6ADn7Rj61dFAbJto4sQyu03tVXVxY
 Hk2F5KAEg6raT3YLL4SsX2KyN41Wr8JHcrQQ6N759Sm3+jY2tqlPewxj8LfWGXsRd9
 n14yC0imK2lizCcrEgGEyS8X/L4BPS02RNzTqsrDWJJgl+DSzFpmtVz2o+ZEinyAdF
 YOH0aorEA+JlbDhbmXxiGRmd2G3R6SZCAL9kXf4yj51g5UZO4dQjlfXXadmgr0MKcE
 NHB5XHQ+DqoS+NtHIcuUEuZnW233+y/5Ddi4qKgmpgkJgSvz17IYR+UfURGCk8yFJ3
 d2KASztUXSM8Q==
Received: from johan by xi.lan with local (Exim 4.99.3)
 (envelope-from <johan@kernel.org>) id 1wfaRb-00000000Z8E-2ewT;
 Fri, 03 Jul 2026 11:44:23 +0200
Date: Fri, 3 Jul 2026 11:44:23 +0200
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
Message-ID: <akeEd0GcHSqScGIl@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-3-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-3-clamor95@gmail.com>
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

On Wed, Jun 17, 2026 at 11:00:19AM +0300, Svyatoslav Ryhel wrote:
> Remove driver-specific regmap wrappers in favor of using regmap helpers
> directly.

The commit message should explain why you think this is a good idea.

Based on a quick look you lose the errnos that were logged on errors and
also the register debugging provided by those helpers.

Johan
