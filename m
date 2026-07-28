Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A9B9C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 794FC10E5A3;
	Tue, 28 Jul 2026 15:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="vTQ6PwFg";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1264E10E5A3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 15:13:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 727EC1A9A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 08:13:01 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 5183C3F66F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785251585; bh=dNUDuI1pWJWA0MvVa+UypasPomGd1aQYtrd9nXUXhlQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vTQ6PwFgd3/2qbbMIRFAzIZPiwGlJ4fQK+urUjD9k2gxgGJZqh6sTlR40ahhwE824
 xqlIFM3bhzOowutswYLuUtpnQz/lplPJnm2305lZolwd/6kpjmlJr525IOBti4HKTQ
 7VbEJL7fB8l2476Ea/NUDD6PxzdVtqJGW/53obAI=
Date: Tue, 28 Jul 2026 16:12:53 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: fix firmware control interface bounds checks
Message-ID: <amjG9WVZrb6v92_h@e142607>
References: <20260720134435.13377-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720134435.13377-1-osama.abdelkader@gmail.com>
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

On Mon, Jul 20, 2026 at 03:44:35PM +0200, Osama Abdelkader wrote:
> panthor_init_cs_iface() and panthor_init_csg_iface() validate firmware
> control interface offsets with 32-bit arithmetic and the size of the host
> wrapper structures. The offsets are derived from firmware-provided strides,
> so the arithmetic can wrap before the bounds check, and the host wrapper
> size is not the size of the firmware control interface being mapped.

How can the offsets wrap with the firmware-provided strides? It's not like
the firmware provides arbitrarily large strides.

> 
> Use 64-bit arithmetic for the computed offsets and validate against the
> actual firmware control interface structure sizes with subtraction-based
> bounds checks. Also validate that the shared section is large enough for
> the global control interface before using it.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index eee2bc7e8541..e2fcbd639c3c 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -897,15 +897,16 @@ static int panthor_init_cs_iface(struct panthor_device *ptdev,
>  	struct panthor_fw_csg_iface *csg_iface = panthor_fw_get_csg_iface(ptdev, csg_idx);
>  	struct panthor_fw_cs_iface *cs_iface = &ptdev->fw->iface.streams[csg_idx][cs_idx];
>  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> -	u32 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> -			   (csg_idx * glb_iface->control->group_stride) +
> +	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> +			   ((u64)csg_idx * glb_iface->control->group_stride) +
>  			   CSF_STREAM_CONTROL_OFFSET +
> -			   (cs_idx * csg_iface->control->stream_stride);
> +			   ((u64)cs_idx * csg_iface->control->stream_stride);
>  	struct panthor_fw_cs_iface *first_cs_iface =
>  		panthor_fw_get_cs_iface(ptdev, 0, 0);
>  
> -	if (iface_offset + sizeof(*cs_iface) >= shared_section_sz)
> +	if (iface_offset > shared_section_sz ||
> +	    sizeof(*cs_iface->control) > shared_section_sz - iface_offset)
>  		return -EINVAL;
>  
>  	spin_lock_init(&cs_iface->lock);
>  	cs_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
> @@ -955,11 +956,13 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>  	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
>  	struct panthor_fw_csg_iface *csg_iface = &ptdev->fw->iface.groups[csg_idx];
>  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> -	u32 iface_offset = CSF_GROUP_CONTROL_OFFSET + (csg_idx * glb_iface->control->group_stride);
> +	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
> +			   ((u64)csg_idx * glb_iface->control->group_stride);
>  	unsigned int i;
>  
> -	if (iface_offset + sizeof(*csg_iface) >= shared_section_sz)
> +	if (iface_offset > shared_section_sz ||
> +	    sizeof(*csg_iface->control) > shared_section_sz - iface_offset)
>  		return -EINVAL;
>  
>  	spin_lock_init(&csg_iface->lock);
>  	csg_iface->control = ptdev->fw->shared_section->mem->kmap + iface_offset;
> @@ -1011,12 +1014,16 @@ static u32 panthor_get_instr_features(struct panthor_device *ptdev)
>  static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
>  {
>  	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
> +	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
>  	unsigned int i;
>  
>  	if (!ptdev->fw->shared_section->mem->kmap)
>  		return -EINVAL;
>  
> +	if (sizeof(*glb_iface->control) > shared_section_sz)
> +		return -EINVAL;
> +
>  	spin_lock_init(&glb_iface->lock);
>  	glb_iface->control = ptdev->fw->shared_section->mem->kmap;
>  
>  	if (!glb_iface->control->version) {
> -- 
> 2.43.0
> 

I'm OK with the general content of the patch, so:

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu


-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
