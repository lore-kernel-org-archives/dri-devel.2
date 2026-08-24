Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C925C5DF94
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:49:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB5210E1CD;
	Mon, 24 Aug 2026 21:49:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jTJfD7JP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A4F10E1CD
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 21:49:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 788FE437EC;
 Mon, 24 Aug 2026 21:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3843B1F000E9;
 Mon, 24 Aug 2026 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787608194;
 bh=8Y8tZ2yPkr4eQp29NxFMS96y/9nHRbndwJB2IImZV/I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jTJfD7JPczCoAwBQ/gC69/NBh6dq7TxqxsLBOnFlpNuChbA0lUnPGmLyUK6ofWnQ3
 nligsvcnPjWoDWiw8TBtD/ma/+DK4i8amIpv1k9z+tWvzwfoouRV0vTHYxd+FjqHS7
 Lk513FEK8mv8nrX0Ots+A8lYMO7vSa7CeUbb0Bsw3sBOAsLrUnwHMwHynUX3YhDGQ6
 +Zs3WWfF2zedV+wJkmWSWe93r7LbVyo+jrpqbwG9DTG/Qgg2kMGA3Xi41vzQ8uLY1k
 HswIq9e3dGyXwiDWQ2M+dfkiuZgRbHYjugYv30IRKabfYKjkj600uNiQD8337iaDcz
 Q3fEBzj9s8wUA==
Date: Mon, 24 Aug 2026 16:49:53 -0500
From: Rob Herring <robh@kernel.org>
To: zhaoguohan@kylinos.cn
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] accel/ethosu: check MMIO mapping errors in probe
Message-ID: <20260824214953.GB50486-robh@kernel.org>
References: <20260716065219.931088-1-zhaoguohan@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716065219.931088-1-zhaoguohan@kylinos.cn>
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

On Thu, Jul 16, 2026 at 02:52:19PM +0800, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> devm_platform_ioremap_resource() returns an error pointer when the register
> resource cannot be mapped. ethosu_probe() stores it and continues until
> initialization dereferences it through MMIO accessors.
> 
> Return the mapping error before initializing the device.
> 
> Fixes: 5a5e9c0228e6 ("accel: Add Arm Ethos-U NPU driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
>  drivers/accel/ethosu/ethosu_drv.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Rob

