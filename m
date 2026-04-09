Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F49EA3C55
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17EF10E7E4;
	Thu,  9 Apr 2026 12:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M2IAl2WF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36E310E7E6
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 12:38:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B4DE441D8;
 Thu,  9 Apr 2026 12:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931EFC19424;
 Thu,  9 Apr 2026 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775738292;
 bh=d1+Vn1+nmxQUEpEEZem6yPloSUx3IAA5s3+3Sci+Ir0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M2IAl2WFlmirhF6vkuPjE6CbkOOQke4RMNkNasosllkTXMB0eoDY8D6cOPPPKsWPK
 AlIDQ+RyMTqhs61avp173c3TxXaIQw4KEsnIs0qR+vbKe2zLOWWdhOd+3vjRbL1cXc
 WKAT2RYWanJA6tX6O7yjwINYgQDeE42lfWvnrItEV3Pl2JCq9Z6quKO0RacCoDhanK
 JRZQOtpaT4Icsk3goBrvmhsuJCKPiPpLO4qMMbIkgtVqkncIlemTDiEBFg5Cg4koWr
 WctFfznlq21DLOPmSmFsTvJ+iNK6XMaJhu343AZCN3jKr12yPD4ZSliNVG3Njwoc9N
 eskYmSGFg+x/A==
Date: Thu, 9 Apr 2026 14:38:07 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>
Cc: janusz.krzysztofik@intel.com, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-media@vger.kernel.org,
 gaoxiang17@xiaomi.com, sumit.semwal@linaro.org
Subject: Re: [PATCH] dma-buf: fix order of trace and fput
Message-ID: <adedTCplYHeJPVKP@zenone.zhora.eu>
References: <20260408122437.1364-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408122437.1364-1-christian.koenig@amd.com>
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

Hi Christian,

> @@ -845,9 +845,8 @@ void dma_buf_put(struct dma_buf *dmabuf)
>  	if (WARN_ON(!dmabuf || !dmabuf->file))
>  		return;
>  
> -	fput(dmabuf->file);
> -
>  	DMA_BUF_TRACE(trace_dma_buf_put, dmabuf);
> +	fput(dmabuf->file);

funny, I just found out I sent the exact same patch, just few
minutes later :-) [*]

Andi

>  }

[*] https://lore.kernel.org/all/20260408123916.2604101-2-andi.shyti@kernel.org/
