Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7A8C55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CFB910E604;
	Mon,  3 Aug 2026 14:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="M6itl3Ns";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 68A9510E604
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:38:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4C7E143D
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 07:37:58 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 B98E73F632
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 07:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785767883; bh=myIJN7qk85z7FqQofK3r/8NHttuSxMUwSKGXvlxKYyc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M6itl3NscRon6qUxdINGMflxZyu3kvGHY/khCU0GrMGnoUwOw7x3BX8NHXmutC87e
 pteZL4LvJNcf28Llsmo6lupi3UvmO27LlZAFqO2xlKRjK1WXsnvBy+BZzdLh3lKLiM
 x3cOblynk7/UeXlM1lLQh0IGzzbJRe1jssOzBVjU=
Date: Mon, 3 Aug 2026 15:37:52 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/panthor: use local variables for firmware
 interface counts
Message-ID: <anCnwPrkXjPLjoil@e142607>
References: <20260803153555.70ca46de@fedora1.home>
 <20260803141149.68182-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803141149.68182-1-osama.abdelkader@gmail.com>
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

On Mon, Aug 03, 2026 at 04:11:49PM +0200, Osama Abdelkader wrote:
> The firmware exposes the global group count and per-group stream count in
> the shared control interface. These values are validated before being used
> as loop bounds.
> 
> Read each count once with READ_ONCE() and store it in a local variable.
> This avoids reading the same control section field twice and makes it
> explicit that the loop uses the same value that passed validation
> to protect against self-modifying control sections.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
> v3:
> - Add comments explaining the READ_ONCE() usage.
> 
>  drivers/gpu/drm/panthor/panthor_fw.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 8411c468bdac..b2ccb81f280c 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -954,6 +954,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
>  	u64 iface_offset = CSF_GROUP_CONTROL_OFFSET +
>  			   ((u64)csg_idx * glb_iface->control->group_stride);
> +	u32 stream_num;
>  	unsigned int i;
>  
>  	if (iface_offset > shared_section_sz ||
> @@ -967,8 +968,13 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>  	csg_iface->output = iface_fw_to_cpu_addr(ptdev, csg_iface->control->output_va,
>  						 sizeof(*csg_iface->output));
>  
> -	if (csg_iface->control->stream_num < MIN_CS_PER_CSG ||
> -	    csg_iface->control->stream_num > MAX_CS_PER_CSG)
> +	/*
> +	 * To protect against self-modifying control sections
> +	 * take a single snapshot from the control section so validation and
> +	 * iteration use the same value.
> +	 */
> +	stream_num = READ_ONCE(csg_iface->control->stream_num);
> +	if (stream_num < MIN_CS_PER_CSG || stream_num > MAX_CS_PER_CSG)
>  		return -EINVAL;
>  
>  	if (!csg_iface->input || !csg_iface->output) {
> @@ -986,7 +992,7 @@ static int panthor_init_csg_iface(struct panthor_device *ptdev,
>  		}
>  	}
>  
> -	for (i = 0; i < csg_iface->control->stream_num; i++) {
> +	for (i = 0; i < stream_num; i++) {
>  		int ret = panthor_init_cs_iface(ptdev, csg_idx, i);
>  
>  		if (ret)
> @@ -1010,6 +1016,7 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
>  {
>  	struct panthor_fw_global_iface *glb_iface = &ptdev->fw->iface.global;
>  	u64 shared_section_sz = panthor_kernel_bo_size(ptdev->fw->shared_section->mem);
> +	u32 group_num;
>  	unsigned int i;
>  
>  	if (!ptdev->fw->shared_section->mem->kmap)
> @@ -1035,13 +1042,18 @@ static int panthor_fw_init_ifaces(struct panthor_device *ptdev)
>  		return -EINVAL;
>  	}
>  
> -	if (glb_iface->control->group_num > MAX_CSGS ||
> -	    glb_iface->control->group_num < MIN_CSGS) {
> +	/*
> +	 * To protect against self-modifying control sections
> +	 * take a single snapshot from the control section so validation and
> +	 * iteration use the same value.
> +	 */
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
