Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14538C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:27:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43B6210E242;
	Wed, 16 Sep 2026 09:27:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KxlsKd9D";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45C2210E99B
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 09:27:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B03D60234;
 Wed, 16 Sep 2026 09:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C7F1F000FF;
 Wed, 16 Sep 2026 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789550835;
 bh=7L/dBuwC/LCncorqUmBiBPEI/nqSHfIDCw4avwp2hRY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KxlsKd9D75q4P1papf9K7j6IA4uhFJRU+ZPwhp4fY2GrrPN8kGDJCA1b6r1E/a431
 qymTivRi/i9uPPit+DQ2mx1vJCCyHsxJ3o1IPOCfhGbLuw6TWBX1spkhVeqod2bmz6
 r8c4PnMwuY2U8XPxjQUrModSIbFoxZFgge3ULSp73mvbNEkVwvDtvW22BRm+GO2AV2
 dgOyobM9UtC0LgRDHRrj0DdYlECOq8b9ckc0V/kA7FEnLi+/Z50Czu4EdmErv/rgSq
 cvLmEt0iKwKHHCSwtI2xyeQqHDMb1kmu8lbfBoq9DS2CofVmQyymc5OWCalIbSvysU
 74FiKaniytr3g==
Received: from johan by xi.lan with local (Exim 4.99.5)
 (envelope-from <johan@kernel.org>) id 1x6lv6-00000005xhO-2LeK;
 Wed, 16 Sep 2026 11:27:12 +0200
Date: Wed, 16 Sep 2026 11:27:12 +0200
From: Johan Hovold <johan@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Boris Breyillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
 =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: add missing
 pm_runtime_dont_use_autosuspend() calls
Message-ID: <aqpg8KHXwr2lNK9Q@hovoldconsulting.com>
References: <20260916075051.1353-1-joshua.crofts1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916075051.1353-1-joshua.crofts1@gmail.com>
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

On Wed, Sep 16, 2026 at 07:50:51AM +0000, Joshua Crofts wrote:
> panfrost_remove() and panfrost_probe() disable PM runtime on teardown or
> failure but don't call the pm_runtime_dont_use_autosuspend() function,
> causing potential resource leaks.

No, as I've explained repeatedly elsewhere, it does not cause any
resource leaks. [1][2]

The autosuspend setting leaks if you will, but that only matters in the
theoretical corner case of someone rebinding a different driver (which
will soon also taint the kernel).

So don't exaggerate the impact, this is essentially just a cleanup,
which is fine in itself.

> Add the missing function calls.
> 
> Found using Coccinelle.
> 
> Fixes: 5c0c825ae4c6 ("drm/panfrost: Replace DRM driver allocation method with newer one")
> Cc: <stable@vger.kernel.org>

And it does not need to be backported.

> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Johan

[1] https://lore.kernel.org/all/aqpd3viN1UoZBkgL@hovoldconsulting.com/
[2] https://lore.kernel.org/linux-iio/aow51Nk-cet9qaUQ@hovoldconsulting.com/
