Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3C7CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 13:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9D110E0D5;
	Fri, 16 Oct 2026 13:27:34 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D9B10E0D5
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 13:27:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99A15439A1;
 Fri, 16 Oct 2026 13:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5562B1F000C4;
 Fri, 16 Oct 2026 13:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792157247;
 bh=kAkuDSgoIlUJHZV61jJnIDmNc5oXDAg3p+X4vEgNQLE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CcQbk9j8sWQ86KgDtwWfMBITM+p9zxKyfdp3exHsY/pvOXIIpnCwWzBuEkUMjphnt
 Gb+orU7i5QRzDOwkxwNjB7rSvpnkoqxPMFc5yBl9RQFt5kcK5BT5VgDJ0GbcPrlUEA
 VpiJV9ZAvfd7QOwDLqD18zGccpNv4DmxvqkMqOZPAapdIPr+UIU47rtGbmJtv5Cz0c
 /uBV4xRneA912R2qZFxXeO1MPB0BjBaF2y2CBi+Vq2yYZfzO8h/ujcF6EUV3GLweDj
 HCr/4k59wnDt9X0B9nJj1y/ZLxFUeywc9BbSx/Fs3dh6QEj5CBJdD4uezeUMK/rBNm
 Oj5MtXVXh/3BQ==
Date: Fri, 16 Oct 2026 08:27:26 -0500
From: Rob Herring <robh@kernel.org>
To: Aryan Sinha <sinha.aryan03@gmail.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] accel: ethosu: Fix kernel-doc for
 ethosu_gem_cmdstream_create()
Message-ID: <20261016132726.GH5059-robh@kernel.org>
References: <20261016101554.14231-1-sinha.aryan03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016101554.14231-1-sinha.aryan03@gmail.com>
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

On Fri, Oct 16, 2026 at 03:45:49PM +0530, Aryan Sinha wrote:
> The comment documents an exclusive_vm argument the function never had, and
> leaves out data. Swap the two so the list matches the signature.
> 
> Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
> ---
>  drivers/accel/ethosu/ethosu_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Why are you sending this again after 4 days?

Rob
