Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204F4C624D6
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 05:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 169BB10E23F;
	Sat,  5 Sep 2026 05:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=leemhuis.info header.i=@leemhuis.info header.b="CF2JNQbH";
	dkim-atps=neutral
X-Greylist: delayed 429 seconds by postgrey-1.36 at gabe;
 Sat, 05 Sep 2026 05:44:20 UTC
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [185.244.194.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E96E010E23F;
 Sat,  5 Sep 2026 05:44:20 +0000 (UTC)
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
 by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hcMXj2NXKz9H0w;
 Sat,  5 Sep 2026 07:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
 s=key2; t=1788586629;
 bh=PxQ/ligeBpT6KN/47W3IbN7XtDCK1Y2sGdAzdrZX00w=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CF2JNQbH3di016p9tfQifkIzqTp+/jzz3Jih6Bj+RbwvB/RrvomYIs2WC2UNN16im
 6fd8yaDJooeBOCtOrqjUnf2aVFK0KffDfOR57v/qMvzN8EJdhiN2gdc7/34F+0S75r
 23RujXz84MwTaPV2c/v1Xc5Ok+dZTbnzxM96s3a13WwAYnDNp++Xu6kRGeDcFyxE6C
 Hhz3H6QzIyg9VAgGpK9EnpnQH3gpy3b1QuJN45MthM8Nxu9s2og5h2v/aeoTEtbPmb
 6YI4yiEn6rA0Bn5S5HSLTW3nmGwQgHg81GlQv3h6XxrwELHDIjW/T6I8kl0p5xjtKd
 ewYPQFYNZ28jw==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
 by relay01-mors.netcup.net (Postfix) with ESMTPS id 4hcMXj1gqDz7yXm;
 Sat,  5 Sep 2026 07:37:09 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by policy02-mors.netcup.net (Postfix) with ESMTPS id 4hcMXh2kr9z8svX;
 Sat,  5 Sep 2026 07:37:08 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
 by mxe9fb.netcup.net (Postfix) with ESMTPSA id 8DC505FA2D;
 Sat,  5 Sep 2026 07:36:59 +0200 (CEST)
Authentication-Results: mxe9fb;
 spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=linux@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info>
Date: Sat, 5 Sep 2026 07:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/gem: Add callback for when handle count goes to 0
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Felix.Kuehling@amd.com
Cc: Mukul Joshi <mukul.joshi@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mark Brown <broonie@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 rust-for-linux@vger.kernel.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20260831183311.1090131-1-alexander.deucher@amd.com>
 <20260831183311.1090131-2-alexander.deucher@amd.com>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: de-DE, en-US
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 MEK4
In-Reply-To: <20260831183311.1090131-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178858662003.1872299.15447474853113409037@mxe9fb.netcup.net>
X-NC-CID: xmDBnZDUQ27kMJfbFoGneDMfwun2n0SNgG+rh/W/aMiFmDJt6d0=
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

On 8/31/26 20:33, Alex Deucher wrote:
> From: Mukul Joshi <mukul.joshi@amd.com>
> 
> Add an optional callback for driver-specific cleanup when the GEM
> handle of an object is freed. This will be used by AMDGPU to enable
> freeing of memory exported to other nodes in a UALink pod once all
> user mode references are gone.
> 
> The callback is called outside the object_name_lock and before
> releasing the reference count on the GEM object

This showed up in -next yesterday and afaics broke build on arm64 and
x86_64 for me with the following error from rust:

"""
>> error[E0063]: missing field `handle_free` in initializer of `drm_gem_object_funcs`
>>    --> rust/kernel/drm/gem/mod.rs:265:58
>>     |
>> 265 |     const OBJECT_FUNCS: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
>>     |                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `handle_free`
>> 
>> error: aborting due to 1 previous error
>> 
>> For more information about this error, try `rustc --explain E0063`.
>> make[2]: *** [rust/Makefile:799: rust/kernel.o] Error 1
>> make[1]: *** [/builddir/build/BUILD/kernel-7.3.0-build/kernel-next-20260904/linux-7.3.0-0.0.next.20260904.221.vanilla.fc43.aarch64/Makefile:1442: prepare] Error 2
>> make: *** [Makefile:256: __sub-make] Error 2
"""
Full log:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-43-aarch64/10951622-next-next-all/builder-live.log.gz

Reverting this change and 2/3 from this set fixed the problem for me.

Ciao, Thorsten
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |  9 +++++++++
>  drivers/gpu/drm/drm_gem.c               |  5 ++++-
>  include/drm/drm_gem.h                   | 11 +++++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f754a4a3a1c22..0d579517c03ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -386,6 +386,14 @@ static int amdgpu_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_str
>  	return drm_gem_ttm_mmap(obj, vma);
>  }
>  
> +static void amdgpu_gem_object_handle_free(struct drm_gem_object *gobj)
> +{
> +	struct amdgpu_bo *aobj = gem_to_amdgpu_bo(gobj);
> +
> +	amdgpu_ualink_revoke_exported_memory(aobj);
> +
> +}
> +
>  const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
>  	.free = amdgpu_gem_object_free,
>  	.open = amdgpu_gem_object_open,
> @@ -395,6 +403,7 @@ const struct drm_gem_object_funcs amdgpu_gem_object_funcs = {
>  	.vunmap = drm_gem_ttm_vunmap,
>  	.mmap = amdgpu_gem_object_mmap,
>  	.vm_ops = &amdgpu_gem_vm_ops,
> +	.handle_free = amdgpu_gem_object_handle_free
>  };
>  
>  static bool amdgpu_gem_are_domains_valid(u32 domains)
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index e3ed684ddcf29..6a86bd2a0343e 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -354,8 +354,11 @@ void drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
>  	}
>  	mutex_unlock(&dev->object_name_lock);
>  
> -	if (final)
> +	if (final) {
> +		if (obj->funcs->handle_free)
> +			obj->funcs->handle_free(obj);
>  		drm_gem_object_put(obj);
> +	}
>  }
>  
>  /*
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 8a704f6a65c15..95d8ae6f85df7 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -227,6 +227,17 @@ struct drm_gem_object_funcs {
>  	 */
>  	size_t (*rss)(struct drm_gem_object *obj);
>  
> +	/**
> +	 * @handle_free:
> +	 *
> +	 * This callback is called when the GEM handle count goes down to 0.
> +	 * It is currently used by AMDGPU driver to release their exported BO
> +	 * handles.
> +	 *
> +	 * This callback is optional.
> +	 */
> +	void (*handle_free)(struct drm_gem_object *obj);
> +
>  	/**
>  	 * @vm_ops:
>  	 *

