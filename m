Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA3EC44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 16:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9931610E9F9;
	Mon,  6 Jul 2026 16:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="krdw+o6S";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4553E10E3DE;
 Mon,  6 Jul 2026 16:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7guCZdTD2KAERz8f6MPx3Klbbmu2md0ZZwoWL4nEApU=; b=krdw+o6SiF86wGukpkdCg723JC
 Wm6xOUm6oOfBYk3+ZOem8KIP5ugPm+GZvAdWCcGg2KqKBR4PXXvweAQNZBjKCIPEYXSkw6pTGrnwm
 Denu+4/x0rTy00y70Xmutt9C85sr7lwu5XeMTey21CRdJQwqP0pUaOypX+amjG8QkySVT9Js1kIh/
 nBCu7mbB/muzjTPOvUOTN+7vrkiFd8ehIKyBIrmJi/9KbJdQ2bSY0rU8X5nYS0at3H2rQcpzjMz12
 6mKu33XOAPtO1i68diKTyOM5DIdbMY1FhlVF/SthmJqPtBac90bif6f81ie29rBawlTZDY3ni6fv2
 AMajf0gQ==;
Received: from d209-89-236-181.abhsia.telus.net ([209.89.236.181]
 helo=atmagalia) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wgmNd-009psZ-UQ; Mon, 06 Jul 2026 18:41:14 +0200
Date: Mon, 6 Jul 2026 10:41:04 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 John Harrison <John.Harrison@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Alex Hung <alex.hung@amd.com>
Subject: Re: [PATCH v6 2/9] drm/amd/display: use drmm allocation for
 writeback connector
Message-ID: <akvOKjElA-gfEk_E@atmagalia>
References: <20260612-wb-drop-encoder-v6-0-9f3a54f81310@oss.qualcomm.com>
 <20260612-wb-drop-encoder-v6-2-9f3a54f81310@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612-wb-drop-encoder-v6-2-9f3a54f81310@oss.qualcomm.com>
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

On 06/12, Dmitry Baryshkov wrote:
> Currently memory used for writeback connectors isn't freed on driver
> unbinding, leaking the memory. Use drm_device-memory allocation
> function for the writeback connector, making sure that the memory is
> freed on the driver unbinding.
> 
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Suggested-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ece581609cf7..436562e32e63 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -91,6 +91,7 @@
>  #include <drm/drm_fourcc.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_eld.h>
> +#include <drm/drm_managed.h>
>  #include <drm/drm_mode.h>
>  #include <drm/drm_utils.h>
>  #include <drm/drm_vblank.h>
> @@ -5807,7 +5808,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  		link = dc_get_link_at_index(dm->dc, i);
>  
>  		if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
> -			struct amdgpu_dm_wb_connector *wbcon = kzalloc_obj(*wbcon);
> +			struct amdgpu_dm_wb_connector *wbcon = drmm_kzalloc_obj(adev_to_drm(adev), *wbcon);
>  
>  			if (!wbcon) {
>  				drm_err(adev_to_drm(adev), "KMS: Failed to allocate writeback connector\n");
> @@ -5816,7 +5817,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>  
>  			if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
>  				drm_err(adev_to_drm(adev), "KMS: Failed to initialize writeback connector\n");
> -				kfree(wbcon);
> +				drmm_kfree(wbcon);

Hi Dmitry,

It looks like drmm_kfree is missing one parameter. It looks like it
should be something like this:


  drmm_kfree(&adev->ddev, wbcon);


If I missed a new series where you address this issue, please ignore
this comment.

Thanks

>  				continue;
>  			}
>  
> 
> -- 
> 2.47.3
> 

-- 
Rodrigo Siqueira
