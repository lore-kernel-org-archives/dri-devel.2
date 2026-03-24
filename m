Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769AEF54AD0
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 16:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E31B310E759;
	Tue, 24 Mar 2026 16:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="OoMZU82k";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B0FB110E759
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 16:06:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57C6E14BF
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:06:39 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 AB7453F915
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 09:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1774368404; bh=lVEq5SLYEo9et+7IEXr9LNJ4hIWnqSmCAvvglpZyIto=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OoMZU82kxbiP8GZLpZMqlPBgK5DPqX3aE4XTtqCWxSqCLFLihSz6EBJPTIYB37EzS
 UQkSJ7sBrH2xY4qdIJ+0/9M3G0fBU/NX/8adJ8VgfiEfWGyC5K2HEmosomyNrewDLZ
 aRB3HIenXDHs+T60kR7xDg7rxhU+9+JpKwQ6QuAk=
Date: Tue, 24 Mar 2026 16:06:36 +0000
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
Message-ID: <acK2jA36UhlEIKkM@e142607>
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

Pushed to drm-misc-next.

Best regards,
Liviu

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
