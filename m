Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83249CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 13:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D694310F3FE;
	Mon,  8 Jun 2026 13:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MHTfEQ6f";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B4410F3FE
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 13:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1780926331;
 bh=brvNZ3N1a0wz6pV7iprlWHZAsadEk5qYF40ZXnPqob4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MHTfEQ6fyjTAM5NwRStV79DWhT5X68KQMMgAFnW5l7+BQ2qRpch4inYhMsTFfoEGE
 R8iyLwx+H7Rv30LJrfA0VYns2zYHe97MoX6wgUX4CE5WIs6POyB0nchNXlA4pGz7wO
 tjDfCGQ3gxVGt76rawwyFCxjMcZdnAx+exi6kvoS8SoUd/GjLGwlRThSsxQhoYb7Zk
 LjoBqQBmX5OXBU6z/vshJkNkBWbNYVvCqg99uvcYAHdFYGybCPD5BN74AE2SzIzPPH
 7AfcVRLkLnZzVfQHg8TDmPxqCYeRVsEpON+5wgbOCOgc66D+kc5FWtwjrBD34WiFgb
 QP9vKjOrOU9nA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3D36D17E0191;
 Mon,  8 Jun 2026 15:45:31 +0200 (CEST)
Date: Mon, 8 Jun 2026 15:45:26 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/18] drm/panthor: Derive MMU AS register addresses
 from base and stride
Message-ID: <20260608154526.750c1a42@fedora-2.home>
In-Reply-To: <20260528150546.3168527-7-karunika.choo@arm.com>
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-7-karunika.choo@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu, 28 May 2026 16:05:34 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 48127313332f..9a64f977d28c 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -36,6 +36,7 @@
>  #include "panthor_gpu.h"
>  #include "panthor_gpu_regs.h"
>  #include "panthor_heap.h"
> +#include "panthor_hw.h"
>  #include "panthor_mmu.h"
>  #include "panthor_mmu_regs.h"
>  #include "panthor_sched.h"
> @@ -57,7 +58,7 @@ struct panthor_as_slot {
>   */
>  struct panthor_mmu {
>  	/** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
> -	void __iomem *iomem;
> +	void __iomem *iomem[MAX_AS_SLOTS];

Can we move the iomem field to panthor_as_slot?

>  
>  	/** @irq: The MMU irq. */
>  	struct panthor_irq irq;
