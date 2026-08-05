Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C64C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C21CB10EEA1;
	Wed,  5 Aug 2026 14:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hTfYHyCZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50A410EEA1
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 14:09:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E27B418DD;
 Wed,  5 Aug 2026 14:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058AE1F000E9;
 Wed,  5 Aug 2026 14:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785938982;
 bh=FaKSOv78ie33tb3qwMISduHCPj+r7eKFgA5ki95jYvI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hTfYHyCZu/ykgJvF2fqKN/oB7v3mG335UZgoOHo3w54DYucmdZY28E9t5W23xx+2X
 ekL5IKKvhcMb3x/l7MA2Xrt1lzZqAQN+LyIfIz7dpmGGUoRfTr8xNfVK1N+vrGqDsQ
 ocqW/9tICTjdYlkDeqn9q9uUJdMiPmIbZSA9jrQIs+uQPQ3mL9LxkRVselvXUWkEOU
 +8mVdVUqheJCGIIecw9MuIqjIQkFL4/KMYmj3Wa2I9x1iZfJwRX2k7wq9qyrPUygjt
 iBuKxfOiKIE5OPM21XWha8erWqmWfP9937zE8rRqkCA4LNpJUZB/tYxR/uefXpzOrb
 8M7Pa+4gWxGsg==
Date: Wed, 5 Aug 2026 09:09:41 -0500
From: Rob Herring <robh@kernel.org>
To: Max Pedraza <maximpedraza@gmail.com>
Cc: Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Boot logo supplied by the device tree
Message-ID: <20260805140941.GA495716-robh@kernel.org>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804225617.264861-1-maximpedraza@gmail.com>
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

On Wed, Aug 05, 2026 at 12:56:11AM +0200, Max Pedraza wrote:
> This series lets the logo be described by the device tree instead: a node
> compatible with "linux,boot-logo-clut224" under /chosen supplies the image in
> the same paletted format the built-in CLUT224 logos already use, and the kernel
> prefers it over the built-in ones when it is present and enabled. If the
> node is absent or disabled, nothing changes.

Why is this linux specific? Don't people want to do a splash screen in 
u-boot or other firmware?

> 
> The image can come from the node itself (patches 1-2) or from a reserved
> memory region the bootloader filled in (patches 4-5), because the image and
> its placement are independent axes of variation. One board sold to several
> customers wants several device trees differing in the logo. One customer
> with several products built on that board, with different panels, wants the
> same logo placed differently on each: there the image belongs in a shared
> binary and only the placement belongs in the device tree. Patch 3 adds that
> placement.
> 
> We have been carrying a cruder version of this downstream on an AM335x
> product since 2020, across a handful of board revisions, and it has removed
> a real maintenance burden for us. This is an attempt to find out whether
> something along these lines is wanted upstream, and if so in what shape --
> hence RFC.
> 
> The v1 discussion turned on the obvious objection, that a bitmap is not
> hardware and the device tree is not where it belongs. Geert pointed out that
> configuration which is not hardware description goes under /chosen, and that
> Open Firmware, which the device tree descends from, already carried a boot
> logo in that spirit as the oem-logo variable under /options. The node has
> moved to /chosen accordingly, which is also where simple-framebuffer nodes
> live, for the same reason: they describe what firmware handed over rather
> than what the hardware is.

What does /options/oem-logo look like? Why can't that be used?

> Patches 4 and 5 are separable; the series is useful without them if the
> reserved memory path is thought to be one mechanism too many.

If you are going to put it in memory, why not just draw it into the 
simple-framebuffer?

Rob
