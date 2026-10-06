Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4028CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:56:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BA5010E04D;
	Tue,  6 Oct 2026 09:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q4xn/b42";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35E9610E04D
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 09:56:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C0A7840751;
 Tue,  6 Oct 2026 09:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D999F1F000FF;
 Tue,  6 Oct 2026 09:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791280617;
 bh=AleYvG/qq8AFQ+xETaiTdk8DrGfhb9/hI1aqS/R4jxM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Q4xn/b42sovP3gmwYnSwgeQmC5kz6pxAhQrc8udqr/1e3D/IMfo3ktg9Na6UAH1bJ
 6lLvvsap7sWw4PZ946I+FVXPYBIUbUPTp/87dqWluvS7mV7IjoNvyXgkretQiKX91z
 tnOfvqPjon8/99vc+aG2KW4VJrr5Linqb0Xn64shBx6Lv75hkp2q4DG2LU2l84YwkU
 O5fZG/m99eKn1pyoiqefHqdt+yiBibJU0rItAfYEj0A5zfOXlji8mDTOX7cNoCNJgN
 ZB1rt/k2G8gHOF4VCWXmnlspYgFq9dzCncCh+TH4ro1aZ/bSy8dNyshYWOi5KifTCZ
 eYWI6NFy19TLg==
Date: Tue, 6 Oct 2026 10:56:53 +0100
From: Daniel Thompson <danielt@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] backlight: lm3630a: Cancel delayed work before
 destroying workqueue
Message-ID: <asTF5StelmN4BQxo@aspen.lan>
References: <20261003030439.599330-1-mhun512@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003030439.599330-1-mhun512@gmail.com>
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

On Fri, Oct 02, 2026 at 11:04:39PM -0400, Myeonghun Pak wrote:
> The interrupt handler queues delayed work to read the interrupt status.
> After free_irq() stops the producer, this work can still be waiting on its
> timer. destroy_workqueue() cannot drain delayed work that has not yet been
> queued by its timer, so the timer can outlive both the workqueue and the
> devm-allocated chip containing the work.
>
> Cancel the delayed work synchronously after freeing the IRQ and before
> destroying the workqueue. This also waits for any running status read to
> finish before the chip's resources are released.
>
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
>
> Fixes: 0c2a665a648e ("backlight: add Backlight driver for lm3630 chip")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>


Daniel.
