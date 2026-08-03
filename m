Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76A6C55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:36:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C4B10E054;
	Mon,  3 Aug 2026 13:36:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="erELjXkd";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CFF410E054
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785764160;
 bh=JTJhPk572PVGJDshQzn2xjCt+P6e2tpxEvXRAPlQVUw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=erELjXkdKVMPbweTp3EbOCovzA0xArQZ19x/UO/+S1gczwh6jmPLDHgfz8XPN7SZV
 qSN1zV2I9D8pLKN0qAH1FtCNWt6oTppSlLg2dz4t1sJQVMx4Ymp5X+cYmN36QMfgDV
 bG7TfkF1gkSILAe1damcNj8lOuRS4EgGzFEyIW1FrJWtsEMGCMvf3gOOWSQLm0Scki
 EPNzKrTWFODk/N6kc70bvr3d/rwDPxdWrysj9NJRS95gC1cKWGeJLB1OHq1xJREQ8h
 8AE4KgrXi8OmfvJU8+jxsWyG2LC/s6BPEc1GLn94yBo77nG2H3ToFWQkwmmoQgyux+
 +NoPKhXwZ8L8g==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C4B0817E0908;
 Mon, 03 Aug 2026 15:35:59 +0200 (CEST)
Date: Mon, 3 Aug 2026 15:35:55 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/panthor: use local variables for firmware
 interface counts
Message-ID: <20260803153555.70ca46de@fedora1.home>
In-Reply-To: <20260803124807.27094-1-osama.abdelkader@gmail.com>
References: <2125ea5a-d878-4032-9338-d0cd0970ccfa@arm.com>
 <20260803124807.27094-1-osama.abdelkader@gmail.com>
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

On Mon,  3 Aug 2026 14:48:06 +0200
Osama Abdelkader <osama.abdelkader@gmail.com> wrote:

> panthor_fw_init_ifaces() validates the firmware interface group count
> before iterating over the CSG interfaces. panthor_init_csg_iface() does
> the same for the per-group stream count before iterating over the CS
> interfaces.
> 
> Store those validated counts in local variables and use the locals as the
> loop bounds. This avoids reading the same control interface fields twice
> and makes it explicit that the loops use the values that were just
> validated.
> 
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> ---
> v2:
> - Reword as an optimization/cleanup instead of a firmware trust-boundary fix.
> - Drop the Fixes and stable tags.
> 
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

We need a comment to explain the READ_ONCE(), otherwise new readers
(and given my inability to remember things, I consider myself a new
reader after 2 weeks :-)) will keep wondering why we're forcing the
compiler to read the memory only once. IIUC, that's here to protect
against self-modifying control sections, so maybe say that. Or if we
consider that the FW is trusted/sure, drop the READ_ONCE()...

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

