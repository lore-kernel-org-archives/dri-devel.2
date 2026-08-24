Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E98BC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 21:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE36910E2F0;
	Mon, 24 Aug 2026 21:58:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CAkFJmmH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8D010E2F0
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 21:58:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E39B44017;
 Mon, 24 Aug 2026 21:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9CB1F000E9;
 Mon, 24 Aug 2026 21:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787608719;
 bh=40sdXIu6h6LUpla7LNm5GxyYMn6eR37uG90qATXqqBI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CAkFJmmHPVFcOp6xu96+TayNw0QmKS4dezlljtZsTiaIp1Uq0v+K+5rVKKzHCEFAq
 dYNs0GlhEeG6VSsDGJQS+nazQNuSL/usUKI+QLiWyFd/SUIEZ6gprz6OIbGsYJCCb5
 e/DfgOoIfo82mVb1W37WX0Y2zBI2R306hTOQ526+xits83SVMNpJw05u8fctq4Lp9d
 53w/q0Yk9WCWMY1YX3vOfxCI663OKxBP/8B0AGVGrWJnpl5czkOgiRgLmlxFBC4V1k
 IpFxSU42yFFtLZ8vUqSnTzCGrF4JDuURCrnAvYU38sVedo6SY7/+UKo9fH4RFn2DMr
 rmmg90Xk6dXcw==
Date: Mon, 24 Aug 2026 16:58:38 -0500
From: Rob Herring <robh@kernel.org>
To: GuoHan Zhao <zhaoguohan@kylinos.cn>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>, dri-devel@lists.freedesktop.org,
 Oded Gabbay <ogabbay@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/5] accel/ethosu: check DMA mask setup
Message-ID: <20260824215838.GC50486-robh@kernel.org>
References: <20260717061145.1478139-1-zhaoguohan@kylinos.cn>
 <20260717061145.1478139-2-zhaoguohan@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717061145.1478139-2-zhaoguohan@kylinos.cn>
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

On Fri, Jul 17, 2026 at 02:11:41PM +0800, GuoHan Zhao wrote:
> dma_set_mask_and_coherent() can fail when platform DMA operations do not
> support the requested 40-bit address mask. Ignoring the error leaves the
> previous DMA configuration in place. Probe then continues without ensuring
> that DMA addresses are suitable for the NPU.
> 
> Return the error so the driver does not bind with an unsupported DMA
> configuration.

Read the documentation. dma_set_mask_and_coherent() will not fail for 
mask >32.

Rob
