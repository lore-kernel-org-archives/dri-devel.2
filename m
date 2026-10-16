Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6385CCC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CAAD112886;
	Fri, 16 Oct 2026 15:34:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37FCB112886
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 15:34:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E5D86020F;
 Fri, 16 Oct 2026 15:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0201F000C4;
 Fri, 16 Oct 2026 15:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792164866;
 bh=mlOYbo7iGOPtVfH/DvviYNz8oYevBD3I9W5NPxI7LIk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Gq64chItWM79+NU7vbfsULvRvZs02ZYdpWJd5gtWM9hQ/vK6G8ZNTCfxYpsNlympX
 AZVL08bpFK8zcru2oy3pA12DRzLdcQdnberdW/ZKd22HyZdYX7DDLlFdpRrupf5kQ2
 j1jz3gKWvbdmrsxQxSFFnhlPWrLOdWYHMc1pjM/WiqnpwLcoBoOlbqslHpS8FpDmii
 UHWoiBpGIafdYvcSmc8lIpruqXYCQ3VaEdGkq8P2sRCkNOprgGJU/66DWqZnuYInLl
 GER3f6dMEhaJueejxDDaypLU6CvoByqaSUu71LUSo/gxS7yPHbimPEoul7/OMHhfWz
 j1wutRbP2OFrA==
Date: Fri, 16 Oct 2026 16:34:21 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 3/4] mfd: aat2870: Convert to use OF bindings
Message-ID: <atJD_ZI7JyJY0PIc@aspen.lan>
References: <20261013180933.487013-1-clamor95@gmail.com>
 <20261013180933.487013-4-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013180933.487013-4-clamor95@gmail.com>
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

On Tue, Oct 13, 2026 at 09:09:32PM +0300, Svyatoslav Ryhel wrote:
> Conversion of the AAT2870 driver to use OF bindings requires a few complex
> changes that should be done simultaneously.
>
> The AAT2870 essentially provides two functions via child devices:
> backlight and regulators. Both functions are fairly self-sufficient and
> may not be populated on the final board. Consequently, the MFD
> registration API was replaced with of_platform_populate(), and each
> sub-device was given its own compatible string.
>
> Additionally, aat2870-core utilizes an enable GPIO. Obtaining this GPIO
> was converted to use modern gpiod/OF helpers, allowing the redundant
> aat2870_enable() and aat2870_disable() helpers to be removed.
>
> The aat2870-regulator driver was updated to register each of the four LDOs
> from a dedicated OF node using modern regulator framework.
>
> The aat2870-backlight driver was changed to populate all required
> properties from a dedicated Device Tree node. Its channel map was updated
> to use u8 instead of int. Furthermore, because the maximum current is now
> parsed as an absolute value rather than an enum entry, the calculation and
> application of the maximum current were updated accordingly.
>
> All of the changes above allow platform data to be removed entirely.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

For backlight:
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
