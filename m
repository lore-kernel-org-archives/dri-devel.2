Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA99C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE37510F748;
	Fri,  3 Jul 2026 09:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GWluniAe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E9D710F748
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 09:57:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EDB966001A;
 Fri,  3 Jul 2026 09:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFC41F000E9;
 Fri,  3 Jul 2026 09:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783072639;
 bh=B/+ZhFAiwNqtyruFpGe8RK10LPI08f58/qvAauSKt6Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GWluniAe58J2LgwEA+NCudTqAfLwinS1hgxERTFFOUxhynpg6iOHwko/W0wy+aWZ+
 +ehMlptLnTJpqj9P/k9DYnniLjB1+5dJBuXlbxQ3sMWh2FXTC1hSfiGA9CrVgPp5vp
 URGO/rHv9MF4oIaq7TvYxp0G7FipyDNvLpRhZBZhb0H5dUA2lQdTzZzznF4NLlHtFy
 my+7bbwnvq75nh0YGbCXkM9nDNA6EvfJu0Vo6ZezjPMHM6OYeJk+7I4pPENY8dOTox
 rlG++P62SLr4jNhIJlwHXOR9GL3cX+hMHq8IvNeAzBe/VyTWL4B/LQQplWpdV59DUt
 Q0UVTfA5rXXxA==
Received: from johan by xi.lan with local (Exim 4.99.3)
 (envelope-from <johan@kernel.org>) id 1wfae5-00000000i2b-0qxo;
 Fri, 03 Jul 2026 11:57:17 +0200
Date: Fri, 3 Jul 2026 11:57:17 +0200
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
Message-ID: <akeHfV45fs_wabFl@hovoldconsulting.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
 <20260617080031.99156-7-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617080031.99156-7-clamor95@gmail.com>
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

On Wed, Jun 17, 2026 at 11:00:23AM +0300, Svyatoslav Ryhel wrote:
> The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are used
> only in lm3533_device_setup(), which in turn is only called by
> lm3533_device_init(). Incorporate their code directly into
> lm3533_device_init() to simplify driver readability.

Again, this isn't needed. Why are you removing abstraction that improve
readability?

Johan
