Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A33C44515
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:11:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E4410F38E;
	Thu, 16 Jul 2026 16:11:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="m3nD08oj";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D3D10F38E
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 16:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784218303;
 bh=EeJG6i8FQ9x+3Q+k+4Wemjp63iHAulxRHU2HGhD3XYg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=m3nD08ojnKwsVuhEI7u4R3vDJpaOjCA42FKDAx82px7QkjTjEL/viE0rAK1ww1QxI
 UsvwTQbo7JzBcabWvzCqj52r6SpUw/3g+KdxgzdOu20bqheUJDIGImC7X2HVxFRuaD
 j8sI+FTsWVi30n1TTVZlw/cu9boLwo6iQOMEyHH/MWsrEOtkIXrVDttI09JlQA9QIk
 PZQtBmSGHwQRPaSqOUp9hiriT7PcLh34cHZI6WA8bJY7wU2Oj6o18wb7xqBkNJw9lP
 PXDXFYsBxCRCRj2nsxclfvvcC926QrKIxzLFkCsPipDMwkWvIw5WC5jj/L5DePO63B
 RcGccIYV/RbMA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id BF17C17E0177;
 Thu, 16 Jul 2026 18:11:42 +0200 (CEST)
Date: Thu, 16 Jul 2026 18:11:37 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: reject firmware sections with oversized data
Message-ID: <20260716181137.5005eb02@fedora-2.home>
In-Reply-To: <20260716143939.21903-1-osama.abdelkader@gmail.com>
References: <20260716143939.21903-1-osama.abdelkader@gmail.com>
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

On Thu, 16 Jul 2026 16:39:38 +0200
Osama Abdelkader <osama.abdelkader@gmail.com> wrote:

> In panthor_fw_load_section_entry(), the data size to copy is calculated
> without validating it against the allocated section_size:
> 
>     section->data.size = hdr.data.end - hdr.data.start;
> 
> If a crafted firmware sets data.size larger than the allocated memory,
> this could cause a heap buffer overflow in panthor_fw_init_section_mem()
> 
>     memcpy(section->mem->kmap, section->data.buf, section->data.size);
> 
> Additionally, if the section->data.size exceeds the BO size, could this
> memset underflow the size calculation, leading to a massive out-of-bounds
> zeroing of kernel memory?
> 
>     memset(section->mem->kmap + section->data.size, 0,
>            panthor_kernel_bo_size(section->mem) - section->data.size);
> 
> Reject section entries whose initial data is larger than the section size.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 986151681b24..a338c4f0a7f5 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -545,6 +545,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  	struct panthor_fw_binary_section_entry_hdr hdr;
>  	struct panthor_fw_section *section;
>  	u32 section_size;
> +	u32 data_size;
>  	u32 name_len;
>  	int ret;
>  
> @@ -595,6 +596,13 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  		return -EINVAL;
>  	}
>  
> +	section_size = hdr.va.end - hdr.va.start;
> +	data_size = hdr.data.end - hdr.data.start;
> +	if (data_size > section_size) {
> +		drm_err(&ptdev->base, "Firmware corrupted, section data exceeds section size\n");
> +		return -EINVAL;
> +	}
> +
>  	name_len = iter->size - iter->offset;
>  
>  	section = drmm_kzalloc(&ptdev->base, sizeof(*section), GFP_KERNEL);
> @@ -603,7 +611,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  
>  	list_add_tail(&section->node, &ptdev->fw->sections);
>  	section->flags = hdr.flags;
> -	section->data.size = hdr.data.end - hdr.data.start;
> +	section->data.size = data_size;
>  
>  	if (section->data.size > 0) {
>  		void *data = drmm_kmalloc(&ptdev->base, section->data.size, GFP_KERNEL);
> @@ -626,7 +634,6 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  		section->name = name;
>  	}
>  
> -	section_size = hdr.va.end - hdr.va.start;
>  	if (section_size) {
>  		u32 cache_mode = hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_MASK;
>  		struct panthor_gem_object *bo;

