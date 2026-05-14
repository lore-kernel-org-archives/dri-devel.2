Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9B0CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 13:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D047D10E3BA;
	Thu, 14 May 2026 13:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="R5tH0WKB";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B422410E3BA
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:16:44 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD0F5244B;
 Thu, 14 May 2026 06:16:38 -0700 (PDT)
Received: from [10.1.37.28] (e122027.cambridge.arm.com [10.1.37.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C8CB3F836;
 Thu, 14 May 2026 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778764603; bh=XlQXNhbEfTr01dBzOIt2YI+/ViFio1iF/QMxPWRbPzE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=R5tH0WKBoMTBO5UI7SJd/dQs8FJ7FF+9n8d3mFdgWH+hAbV3psXfthFEhdBOyDXLq
 OeV/Dc7lcuRsC2vEiRYWvm42tmeVCttsAlUj0J9Z2npAGimsSw01JbTJ8bWZTPZLmk
 gumAnP0vz7GxVlRoTkqGl6RoGppepG5O3T5Ti6q8=
Message-ID: <5ab2d07c-74a4-4a2c-b145-6ed7b0060944@arm.com>
Date: Thu, 14 May 2026 14:16:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drm/panthor: Driver-wide xxx_[un]lock ->
 [scoped_]guard replacement
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20260513-panthor-guard-refactor-v1-0-f2d8c15a97ce@collabora.com>
 <20260513-panthor-guard-refactor-v1-1-f2d8c15a97ce@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260513-panthor-guard-refactor-v1-1-f2d8c15a97ce@collabora.com>
Content-Type: text/plain; charset=UTF-8
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

On 13/05/2026 17:58, Boris Brezillon wrote:
> Right now panthor is mixed bag of manual locks and guards. Let's
> make that more consitent and thus encourage new submissions to go
> for guards.

I'm fine with encouraging guards for future code - but I'm a little wary
of a big change like this - it's hard to review it and check that
everything works the same. And it's a little dubious that the mechanical
refactoring produces more readable code in some cases.

That said I asked my friendly AI bot...

[...]

> @@ -3142,48 +3126,44 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>  	LIST_HEAD(remaining_vms);
>  	LIST_HEAD(vms);
>  
> -	mutex_lock(&ptdev->reclaim.lock);
> -	list_splice_init(&ptdev->reclaim.vms, &vms);
> +	scoped_guard(mutex, &ptdev->reclaim.lock)
> +		list_splice_init(&ptdev->reclaim.vms, &vms);
>  
>  	while (freed < nr_to_scan) {
>  		struct panthor_vm *vm;
>  
> -		vm = list_first_entry_or_null(&vms, typeof(*vm),
> -					      reclaim.lru_node);
> -		if (!vm)
> -			break;
> -
> -		if (!kref_get_unless_zero(&vm->base.kref)) {
> -			list_del_init(&vm->reclaim.lru_node);
> -			continue;
> +		scoped_guard(mutex, &ptdev->reclaim.lock) {
> +			vm = list_first_entry_or_null(&vms, typeof(*vm),
> +						      reclaim.lru_node);
> +			if (vm && !kref_get_unless_zero(&vm->base.kref)) {
> +				list_del_init(&vm->reclaim.lru_node);
> +				vm = NULL;
> +			}
>  		}
>  
> -		mutex_unlock(&ptdev->reclaim.lock);
> +		if (!vm)
> +			break;

... and it said the above has changed behaviour.

In the !kref_get_unless_zero() case you now assign vm = NULL which then
leads to the 'break' case above. Previously we 'continue'd.

Thanks,
Steve
