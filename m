Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCF4C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:32:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0D4710E1E3;
	Mon, 10 Aug 2026 10:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ABA2w8pi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190D910E1E3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 10:32:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00DEE43FB7;
 Mon, 10 Aug 2026 10:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2126D1F000E9;
 Mon, 10 Aug 2026 10:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786357971;
 bh=cC7gqPvLUlkLwbGKdwL24vXRm9gmd31IDrCvA4drtl0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ABA2w8pip6RKbD4CUQt2E1r0p6YZ5V2YFzSD010Mb/ThhGSVDmLCI/MasIcolqLRZ
 T1vSAIiBF64Lj6iQxVosa3lg4lb2IgNM38N0gO17nHbDPCABaG2LR/nI01vpjbDxWO
 FM3OjQVEbo84TQ8leWSywNiEu0Pge6lV7y1sAMJZ2ZMwCVBCbMrGpEaDtOu+tAD82Z
 /lAtRBn09bVHnk2jZGvXmdjcBTiv2QqqyAYvt+FTxF9G+k6yxf56m43lEV537XMAJ6
 OO9ga3afrkurhf2P7QBp5x/U8K9SNIkORgZd+2GHVME/e+0soZdzf7JpFJQr+vOfTb
 vNKOWaiXS9Qxw==
Date: Mon, 10 Aug 2026 11:32:47 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>,
 stable@vger.kernel.org, Junjie Cao <junjie.cao@linux.dev>
Subject: Re: [PATCH v3 3/3] backlight: aw99706: Honor the core blank state in
 update_status()
Message-ID: <anmoz-Of5W-pjz-6@aspen.lan>
References: <20260804030255.1934470-1-junjie.cao@intel.com>
 <20260804030255.1934470-4-junjie.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804030255.1934470-4-junjie.cao@intel.com>
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

On Tue, Aug 04, 2026 at 11:02:55AM +0800, Junjie Cao wrote:
> From: Junjie Cao <junjie.cao@linux.dev>
>
> update_status() passes props.brightness straight to the hardware and
> ignores the power/blank state tracked by the core. Writing 4 to the
> bl_power sysfs attribute or blanking the framebuffer therefore leaves
> the backlight lit.
>
> Use backlight_get_brightness(), which returns 0 while the device is
> blanked.
>
> Fixes: 147b38a5ad06 ("backlight: aw99706: Add support for Awinic AW99706 backlight")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
