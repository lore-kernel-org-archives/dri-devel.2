Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B25C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF07110E1C2;
	Tue, 30 Jun 2026 09:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pTSAv86M";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF4510E1C2
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:20:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1275360008;
 Tue, 30 Jun 2026 09:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393B21F000E9;
 Tue, 30 Jun 2026 09:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
 s=korg; t=1782811200;
 bh=P8y26ICau+Zq5nbRu9rFDpHLmiN9lzN8YryMUBW4Z8g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=pTSAv86MxiMhodCWxanIEFDXajdaw9kKMMAvHEU73DCrhG7+mnBvVResPe4mgebXr
 c7XNC3u+9iar1gPM5/MH3SBlueeV0XoKt+oCP+UTr77JX4q+2ZxJso/SzltJVCllyn
 LvwBEEMAYnTzsp0hYbxFfbg8SC4LOJWCNHQ87sMg=
Date: Tue, 30 Jun 2026 11:19:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: thierry.reding@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jonathanh@nvidia.com, WenTao Liang <vulab@iscas.ac.cn>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/tegra: fix host1x_bo_pin leak in tegra_dc_pin
 error path
Message-ID: <2026063044-multiple-lion-95fe@gregkh>
References: <20260628150228.47948-1-vulab@iscas.ac.cn>
 <6iIwnfniQ6-oslWmeLae0A@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6iIwnfniQ6-oslWmeLae0A@nvidia.com>
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

On Mon, Jun 29, 2026 at 02:59:05PM +0900, Mikko Perttunen wrote:
> On Monday, June 29, 2026 12:02 AM WenTao Liang wrote:
> > When map->chunks > 1 triggers an error, the function jumps to unpin
> > before storing the current map in state->map[i]. The unpin loop only
> > cleans up previously pinned planes (indices 0 through i-1), so the
> > current mapping returned by host1x_bo_pin is never released via
> > host1x_bo_unpin.
> > 
> > Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> > Fixes: c6aeaf56f468 ("drm/tegra: Implement correct DMA-BUF semantics")
> 
> This patch changes the code around the line, but doesn't look like it's
> the origin of the bug. Rather, I think commit
> 
>   49f821919bb9d45de7f1cde6072de01d36235b5d
> 
> is the origin.
> 
> Aside from that,
> 
> Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>

I did not suggest this, so please do not accept this patch.
