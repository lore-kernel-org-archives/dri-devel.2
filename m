Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607ADC54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE1D710E952;
	Tue, 28 Jul 2026 15:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Jsdau/+x";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D7E7C10E952
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 15:17:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48306169E
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 08:17:22 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 2658A3F66F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785251846; bh=dZ8qagvGKJMyPa0EnzkJtY2emQs3MSkWMyx5Z+Vj9P0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jsdau/+xL4PxOGKT8B2k2DAhOnBaBMBg6jUF2iuAONexJ5YZ+S1vASlOz8PTKf6rI
 vsBmnWQCDLxF3lEyYw0vduRprfCo/ZW37VzeeHXostNCqg8glP7GTH8jLljOEk/gRh
 Sp5DoBa5EbcQV3eJ71OnswMagGeK6CjpQGr8SUig=
Date: Tue, 28 Jul 2026 16:17:14 +0100
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
Subject: Re: [PATCH] drm/panthor: snapshot firmware interface counts before
 loops
Message-ID: <amjH-v6-2POzmj1q@e142607>
References: <20260720135518.17927-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720135518.17927-1-osama.abdelkader@gmail.com>
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

On Mon, Jul 20, 2026 at 03:55:18PM +0200, Osama Abdelkader wrote:
> The firmware exposes the global group count and per-group stream count in
> the shared control interface. These values are validated before being used
> as loop bounds, but the memory is shared with the MCU firmware and can be
> changed after validation.

Again, you're making statements that need to be proven here. How is MCU
firmware going to change the content of the memory shared with the driver?

> 
> Read each count once with READ_ONCE() and use the validated snapshot as the
> loop bound. This keeps the loop bounds consistent with the validation and
> prevents the compiler from reloading a firmware-controlled count during
> iteration.

As an optimisation I'm fine with it, so:

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index e2fcbd639c3c..6e6da98d795e 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -959,6 +959,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
>  	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
>  			   ((u64)csg_idx * glb_iface->control->group_stride);
> +	u32 stream_num;
>  	unsigned int i;
>  
>  	if (iface_offset > shared_section_sz ||
> @@ -972,8 +973,8 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>  	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va,
>  						 sizeof(*csg_iface->output));
>  
> -	if (csg_iface->control->stream_num < MIN_CS_PER_CSG ||
> -	    csg_iface->control->stream_num > MAX_CS_PER_CSG)
> +	stream_num = READ_ONCE(csg_iface->control->stream_num);
> +	if (stream_num < MIN_CS_PER_CSG || stream_num > MAX_CS_PER_CSG)
>  		return -EINVAL;
>  
>  	if (!csg_iface->input || !csg_iface->output) {
> @@ -990,7 +991,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>  		}
>  	}
>  
> -	for (i = 0; i < csg_iface->control->stream_num; i++) {
> +	for (i = 0; i < stream_num; i++) {
>  		int ret = panthor_init_cs_iface(ptdev, csg_idx, i);
>  
>  		if (ret)
> @@ -1015,6 +1016,7 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
>  {
>  	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
>  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> +	u32 group_num;
>  	unsigned int i;
>  
>  	if (!ptdev->fw->shared_section->mem->kmap)
> @@ -1034,17 +1036,17 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
>  		return -EINVAL;
>  	}
>  
> -	if (glb_iface->control->group_num > MAX_CSGS ||
> -	    glb_iface->control->group_num < MIN_CSGS) {
> +	group_num = READ_ONCE(glb_iface->control->group_num);
> +	if (group_num > MAX_CSGS || group_num < MIN_CSGS) {
>  		drm_err(&ptdev->base, "Invalid number of control groups");
>  		return -EINVAL;
>  	}
>  
> -	for (i = 0; i < glb_iface->control->group_num; i++) {
> +	for (i = 0; i < group_num; i++) {
>  		int ret = panthor_init_csg_iface(ptdev, i);
>  
>  		if (ret)
>  			return ret;
>  	}
>  
>  	drm_info(&ptdev->base, "CSF FW using interface v%d.%d.%d, Features %#x Instrumentation features %#x",
> -- 
> 2.43.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
