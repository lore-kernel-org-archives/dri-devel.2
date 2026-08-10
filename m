Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE95C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA4510E7A0;
	Mon, 10 Aug 2026 10:49:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hBtxRDsW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2390310E7A0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 10:49:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3A7DB600AB;
 Mon, 10 Aug 2026 10:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AE71F000E9;
 Mon, 10 Aug 2026 10:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786358995;
 bh=RaJC7eVD/36NvdnYJwCwQ4K3pxBaVZu1wRfSuJdGsOg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hBtxRDsWG6DEw5xYp9ulLnip7mZHLQExr/EKAJlj+5OXGJvi5IXZK57LPN6+WpIDL
 jzUHXYKRRkgNf6AwmpyVfe2bzMGC1D9+UC9xzfzpXwLcNCrLmvsh4n6T2OsJ29zOpV
 1Q84W4PCiq/4emuyqHTroEtNv7j83dAV1v34ahncRCTNycXPZ9md4+7E84PFoZC6pm
 TX2Bj5DC+pUaVaUqWDcyRymbrlXGG4R13MMZUz0Tz6bO9on65oc2AUFyEOAquoP20G
 7Zdh5FdxxWWrDIdyF4ggcVXDCxBLhfF64NwAfZ3Uh6NQA9iY3Nb4HYSUSxZZiCqJv4
 LSUeZa9fL3yew==
Date: Mon, 10 Aug 2026 11:49:51 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Julian Braha <julianbraha@gmail.com>
Cc: lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
 rdunlap@infradead.org, duje@dujemihanovic.xyz,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH] backlight: ktd2801: fix unmet dependency on GPIOLIB
Message-ID: <anmszwHSUVcZ3Dbk@aspen.lan>
References: <20260719024902.151710-1-julianbraha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719024902.151710-1-julianbraha@gmail.com>
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

On Sun, Jul 19, 2026 at 03:49:02AM +0100, Julian Braha wrote:
> LEDS_EXPRESSWIRE depends on GPIOLIB, so its selector, BACKLIGHT_KTD2801
> also needs to ensure GPIOLIB is enabled. Otherwise:
>
> WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
>   Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=n]
>   Selected by [y]:
>   - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]
>
> This unmet dependency was found by kconfirm, a static analysis tool for
> Kconfig.
>
> Fixes: d95963e309bc ("backlight: ktd2801: Depend on GPIOLIB")
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
