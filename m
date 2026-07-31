Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C12C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD1C810F1A9;
	Fri, 31 Jul 2026 07:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qsC/IMAQ";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B52FA10F1A9
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:32:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31A5520E3;
 Fri, 31 Jul 2026 00:32:11 -0700 (PDT)
Received: from [10.57.87.104] (unknown [10.57.87.104])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E002A3F7B4;
 Fri, 31 Jul 2026 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785483135; bh=8nwexrU4GojqLqHdgsDjR3BOBw10uMNk9zy3a9FhJsY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qsC/IMAQx7/QuBSaJS9n/MUCxlDhQZgCzjZ1yJXCH6FQnCsrX4uWgEdxYSyyqyvKZ
 9ZlVx9dKEeKQ7oZyNPNkmHwMrs2foBDqi3Kyr7/IUCHnylUUykbsPfgF6EwlQ24jDl
 MJ1cCyZf1Q6YxDm94CKbdy7xtYF8G5JY1tYms+YU=
Message-ID: <0d6db1e7-3892-423d-b01d-b126dccadd90@arm.com>
Date: Fri, 31 Jul 2026 08:32:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: fix firmware control interface bounds checks
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260720134435.13377-1-osama.abdelkader@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260720134435.13377-1-osama.abdelkader@gmail.com>
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

On 20/07/2026 14:44, Osama Abdelkader wrote:
> panthor_init_cs_iface() and panthor_init_csg_iface() validate firmware
> control interface offsets with 32-bit arithmetic and the size of the host
> wrapper structures. The offsets are derived from firmware-provided strides,
> so the arithmetic can wrap before the bounds check, and the host wrapper
> size is not the size of the firmware control interface being mapped.
> 
> Use 64-bit arithmetic for the computed offsets and validate against the
> actual firmware control interface structure sizes with subtraction-based
> bounds checks. Also validate that the shared section is large enough for
> the global control interface before using it.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

As Liviu pointed out some of this seems a bit unlikely, but I don't
disagree with any of the changes, so:

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,
Steve

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

