Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC95C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E3810F419;
	Fri, 24 Jul 2026 15:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="gbdxT7RS";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9316C10F419
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 15:33:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 390781684;
 Fri, 24 Jul 2026 08:33:20 -0700 (PDT)
Received: from [10.1.25.28] (e122027.cambridge.arm.com [10.1.25.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFB333F59E;
 Fri, 24 Jul 2026 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784907204; bh=+o0beotL8y7MpoUYTdG8kGqiQRANLNh8KSu6dK3sUD4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=gbdxT7RSlMondLOm+8arR7st4y0YBRCP46a33GUv92ekwRouGDhF/xa1SRfsTU602
 gXlwr8clgVpRAQTbVHZyoyPkg3Ukwp0K1G1mWr3obY/yI3wwhgrkf619misqa/qSqg
 CRdRPlqJtjKfvf4WpXRznw7wVeAixSOR/yeen1/4=
Message-ID: <2c8bd414-097b-41a9-95e0-87b146ef3f26@arm.com>
Date: Fri, 24 Jul 2026 16:33:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: reject firmware sections with oversized data
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260716143939.21903-1-osama.abdelkader@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260716143939.21903-1-osama.abdelkader@gmail.com>
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

On 16/07/2026 15:39, Osama Abdelkader wrote:
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

Reviewed-by: Steven Price <steven.price@arm.com>

I'll apply this to drm-misc-fixes.

Thanks,
Steve

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

