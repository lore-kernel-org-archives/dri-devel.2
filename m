Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DFBCC61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 18:39:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F91510F147;
	Thu, 27 Aug 2026 18:39:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RMUuz6Qg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E62E10F135;
 Thu, 27 Aug 2026 18:39:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 01B9B600D4;
 Thu, 27 Aug 2026 18:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBF31F000E9;
 Thu, 27 Aug 2026 18:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787855949;
 bh=EvBq/kNRfDxcmBT3ja2tn8zjCkM8bMbxUf+xWihzM1s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RMUuz6QgkkkWd+l8Ves2deOk7qxLzRUFvETSeYORVc4ouyYFpsf4mHUeE9PJ7kR0G
 cFx99ZzIQlM2GnBdTrLDOMEQPF/jG8AsSoDpdj0Eq74xoXkjsYg1/OIGAMMUvvg8Ve
 r5/0yLSCbz2qJSm3NsQrDQsfqZLklKC8vrGvIVPnsLjakr9I4/US/84eqiSbfNbsGg
 Hr9nC/SJWFwUiTWUBXi6xXX7u0iZviMGUzsfGyyr+teDCHVrd6mqiA+ROhlMxcWEwr
 uaY31U+Du4vCyC1QjEEbCe7ZfSAwXEh3PBZmvYFfiETJ3Pn+Xp6YMQUXruotCOs+St
 CbUxDSg6+pi7Q==
Date: Thu, 27 Aug 2026 20:39:06 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: christian.koenig@amd.com
Cc: thomas.hellstrom@linux.intel.com, dakr@kernel.org, 
 ecourtney@nvidia.com, matthew.brost@intel.com, nat@pixelcluster.dev, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 01/10] dma-buf: Add reference counting to dma_resv
Message-ID: <apCDdNYCBcymcEF-@zenone.zhora.eu>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-2-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827124910.2245-2-christian.koenig@amd.com>
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

> +/**
> + * dma_resv_put - release a reference to a reservation object
> + * @obj: the reservation object
> + *
> + * Decrements the reference count on the dma_resv object. When the reference
> + * count reaches zero, the object is cleaned up with dma_resv_fini() and freed

except that you have removed dma_resv_fini() :-)

Probably you want to say that the object is cleaned up by
dma_resv_release()?

Andi

> + * if it was allocated by dma_resv_alloc().
> + */
> +void dma_resv_put(struct dma_resv *obj)
> +{
> +	if (obj)
> +		kref_put(&obj->refcount, dma_resv_release);
>  }
> -EXPORT_SYMBOL(dma_resv_fini);
> +EXPORT_SYMBOL(dma_resv_put);
