Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7A0C9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 704D610E25A;
	Fri, 25 Sep 2026 09:39:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gD9VLXNv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 210E610E250;
 Fri, 25 Sep 2026 09:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=Raqg+OkBW0ybdlQNfJimrz0RehwkGgR6F0gW6V36HrI=; b=gD9VLXNv06X0b+CpkATgqJOEu4
 jMkEvUmkSjuY2bC5mPHAhGYQdn87HHEL3/aSSGWOgVB/qhBE5JEHAgutMA1Pc6Hn2JkVhFAZFuU+1
 +DqMbjdGp2I6pMLJxWOLv3oadCo9GIPMlSMAhXHGYtR7GrBfsK6eXTfVZjiMDWg2hK90u/GB7Nj8h
 p4cY7V0Ssb7vfDxZnV/PQHgcYSZWOs/cvcaNQavAihTAYfGlxbGy7bGnMqv4jnQ01n3g4Lt2Nkv5W
 stQr9h2EjWVL5wli+e8SRwq9RdTti3dXqcunQJXIG0xqNunqTkImyL0rjePKqe3uECeM+5tOJpVk2
 xsuRpgeA==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xA2P3-0074x9-Uc; Fri, 25 Sep 2026 11:39:37 +0200
Message-ID: <ac484238-b994-4c20-991e-95efa3756af3@igalia.com>
Date: Fri, 25 Sep 2026 10:39:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: remove unused adev parameter from
 amdgpu_vm_pt_free_list
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
References: <20260925-amdgpu_vm_pt_free_list_args-v1-1-f6f1c644c878@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260925-amdgpu_vm_pt_free_list_args-v1-1-f6f1c644c878@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 25/09/2026 09:54, Thadeu Lima de Souza Cascardo wrote:
> Since commit b6c4f90b3819 ("drm/amdgpu: sync page table freeing with tlb
> flush") simplified amdgpu_vm_pt_free_dfs into amdgpu_vm_pt_free_list, it
> does not need adev as it already finds the target PTs on the
> tlb_flush_waitlist.

It also looks like accessing adev from the params is idiomatic in this 
code so:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 3 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 4 +---
>   3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index bb04101b0fb5..d090bbbdc00d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1252,7 +1252,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		tlb_cb = NULL;
>   	}
>   
> -	amdgpu_vm_pt_free_list(adev, &params);
> +	amdgpu_vm_pt_free_list(&params);
>   
>   error_free:
>   	kfree(tlb_cb);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index d32183cd9e0f..5d9063e71268 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -613,8 +613,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>   			  uint64_t start, uint64_t end,
>   			  uint64_t dst, uint64_t flags);
>   void amdgpu_vm_pt_free_work(struct work_struct *work);
> -void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
> -			    struct amdgpu_vm_update_params *params);
> +void amdgpu_vm_pt_free_list(struct amdgpu_vm_update_params *params);
>   
>   #if defined(CONFIG_DEBUG_FS)
>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index e43a60d09808..af0d95fa8965 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -551,13 +551,11 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>   /**
>    * amdgpu_vm_pt_free_list - free PD/PT levels
>    *
> - * @adev: amdgpu device structure
>    * @params: see amdgpu_vm_update_params definition
>    *
>    * Free the page directory objects saved in the flush list
>    */
> -void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
> -			    struct amdgpu_vm_update_params *params)
> +void amdgpu_vm_pt_free_list(struct amdgpu_vm_update_params *params)
>   {
>   	struct amdgpu_vm_bo_base *entry, *next;
>   	bool unlocked = params->unlocked;
> 
> ---
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
> change-id: 20260924-amdgpu_vm_pt_free_list_args-1eed6131aab5
> 
> Best regards,
> --
> Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 

