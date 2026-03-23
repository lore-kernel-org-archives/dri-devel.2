Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D11DEC01C9
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 11:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA84210E0C7;
	Mon, 23 Mar 2026 11:19:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 4D6C910E0C7
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 11:19:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA0ED1684
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:19:01 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 9CF613F885
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:19:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 11:18:58 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: correct firmware related messages
Message-ID: <acEhous5pz_fxSpi@e142607>
References: <20260323081132.3217646-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260323081132.3217646-1-christianshewitt@gmail.com>
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

On Mon, Mar 23, 2026 at 08:11:32AM +0000, Christian Hewitt wrote:
> Some English language corrections to firmware messages. No
> functional changes.
> 
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index a64ec8756bed..349bb6b0e7bf 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -580,7 +580,7 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  
>  	if (hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_PROT) {
>  		drm_warn(&ptdev->base,
> -			 "Firmware protected mode entry not be supported, ignoring");
> +			 "Firmware protected mode entry is not supported, ignoring");
>  		return 0;
>  	}
>  
> @@ -749,7 +749,7 @@ static int panthor_fw_load_entry(struct panthor_device *ptdev,
>  
>  	if ((iter->offset % sizeof(u32)) ||
>  	    (CSF_FW_BINARY_ENTRY_SIZE(ehdr) % sizeof(u32))) {
> -		drm_err(&ptdev->base, "Firmware entry isn't 32 bit aligned, offset=0x%x size=0x%x\n",
> +		drm_err(&ptdev->base, "Firmware entry is not 32-bit aligned, offset=0x%x size=0x%x\n",
>  			(u32)(iter->offset - sizeof(u32)), CSF_FW_BINARY_ENTRY_SIZE(ehdr));
>  		return -EINVAL;
>  	}
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
