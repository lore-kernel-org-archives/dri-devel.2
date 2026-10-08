Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DD7CA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0345C10E757;
	Thu,  8 Oct 2026 07:56:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="fMr/M945";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C295710E751
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791446158;
 bh=oytHofmUsmOmYjWHOOvTsgnG1UiObfAk8X2HNycb7pY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fMr/M945EQAvKNpaZfjiq3lkEcl9RypSRzLM+p+FZvRUD22i3eZ02dTGoZVszwQob
 n/mjGJ58RK0DddanS5RKROKbgHRExS4FQ6ULlVLJhst5kyQ+a5rwmRrKuiuHBBHsAO
 ZB7RYcg8i/CqgeRrDNkV3VbCpxoFOWubk6Jwrl3tcWX2Nu5fS3Tyo3zSdJUpxTyoxB
 FJqvhR27juW7ceJywgAi9/qpmLjIdj/w1lLldz9Rg1Z3IENQZG/nTVqUf65gNoIMUU
 dAT/ol25HXGhsqdQcGLvWEbdrWNfAFWkOJ/KxHK/ZVJNhEkGSQMJW1BmLWpJ7rQEX+
 /tfu0qwwrxkqQ==
Received: from fedora-61.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7C0ED17E0371;
 Thu, 08 Oct 2026 09:55:57 +0200 (CEST)
Date: Thu, 8 Oct 2026 09:55:11 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Akash Goel
 <akash.goel@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Fix TOCTOU race between GROUP_REGISTERED
 check and erase
Message-ID: <20261008095511.70710ea2@fedora-61.home>
In-Reply-To: <20261007181220.2418060-1-osama.abdelkader@gmail.com>
References: <20261007181220.2418060-1-osama.abdelkader@gmail.com>
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

On Wed,  7 Oct 2026 20:12:19 +0200
Osama Abdelkader <osama.abdelkader@gmail.com> wrote:

> panthor_group_destroy() checks the GROUP_REGISTERED mark and then calls
> xa_erase() without holding the xarray lock across both. If the handle is
> destroyed by another thread in between, and a concurrent GROUP_CREATE
> reuses the freed ID, the first destroy erases and releases the new,
> still-initializing group, leading to a use-after-free in
> panthor_group_create().
> 
> Do the mark check and erase atomically under xa_lock().
> 
> Fixes: eec7e23d848d ("drm/panthor: Prevent potential UAF in group creation")

The fix looks legit, but I wonder how the bug was found. If this was
found with the help of a tool (AI or static code analyzer), this should
be reflected with an `Assisted-by` tag (see [1]).

With the relevant Assisted-by tag, this is

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

[1]https://docs.kernel.org/process/coding-assistants.html

> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
> index 0493858e55d7..a343c5180e01 100644
> --- a/drivers/gpu/drm/panthor/panthor_sched.c
> +++ b/drivers/gpu/drm/panthor/panthor_sched.c
> @@ -3770,12 +3770,18 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
>  	struct panthor_group_pool *gpool = pfile->groups;
>  	struct panthor_device *ptdev = pfile->ptdev;
>  	struct panthor_scheduler *sched = ptdev->scheduler;
> -	struct panthor_group *group;
> +	struct panthor_group *group = NULL;
>  
> -	if (!xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
> -		return -EINVAL;
> +	/*
> +	 * Check the mark and erase the entry atomically, so a concurrent
> +	 * destroy + create can't make us erase a group that's still being
> +	 * initialized and happens to reuse the same handle.
> +	 */
> +	xa_lock(&gpool->xa);
> +	if (xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
> +		group = __xa_erase(&gpool->xa, group_handle);
> +	xa_unlock(&gpool->xa);
>  
> -	group = xa_erase(&gpool->xa, group_handle);
>  	if (!group)
>  		return -EINVAL;
>  

