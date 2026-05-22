Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE95CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC1DB10F55C;
	Fri, 22 May 2026 13:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="G0d18tSL";
	dkim-atps=neutral
X-Greylist: delayed 1738 seconds by postgrey-1.36 at gabe;
 Fri, 22 May 2026 13:02:01 UTC
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA41110F55C
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
 from:content-type:reply-to; bh=J5RJHoSNuWSt7X/qWWuD0nqDl1wz0DoB1HUcmFQ98RU=; 
 b=G0d18tSLxzUXkkkaCTT0DfGxsFZ+679GWPXm33atbcr3aD9gaW/gs8pbk69t68LhTxh4QU5rq6H
 ZD1C8TBYgRXnbyC5wDFNqFHvZxsh2Rf/s/fuJVnm+Z01YQ3IaNcoDALEdZIF0s7O4jIDb3jTBEqag
 1ZVm1cJH09VYysIOqkYW+n7aQkBqIjbPwmuJQw7126sxnRpVugMa8TxNnAkyfnnOAu+rQoZImTIBs
 sn2oq6IfemVcjhKakZkq8XRihhCJVAdQN9Z1JlfqU0YgewznXP0KFxIyKG4nulufcAdOuDz/1OXs7
 R0vGVQWaco5ul0P3X5zdRFUQPJDL+TKXT/HQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
 by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
 id 1wQP3e-00GSRL-0z; Fri, 22 May 2026 20:32:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation);
 Fri, 22 May 2026 20:32:54 +0800
Date: Fri, 22 May 2026 20:32:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Akhil R <akhilrajeev@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>,
 Aaron Kling <webgeek1234@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: tegra - Don't touch bo refcount in host1x bo
 pin/unpin
Message-ID: <ahBM9lBhn1VoXOn6@gondor.apana.org.au>
References: <20260515-host1x-bocache-leak-v1-0-a0375f68aeab@nvidia.com>
 <20260515-host1x-bocache-leak-v1-2-a0375f68aeab@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-host1x-bocache-leak-v1-2-a0375f68aeab@nvidia.com>
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

On Fri, May 15, 2026 at 11:34:52AM +0900, Mikko Perttunen wrote:
> Since commit "gpu: host1x: Allow entries in BO caches to be freed",
> host1x_bo_pin() and host1x_bo_unpin() handle the bo's refcount
> themselves. .pin/.unpin callbacks should not adjust it.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/crypto/tegra/tegra-se-main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
