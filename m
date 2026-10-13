Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C06CC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:44:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 648A010F696;
	Tue, 13 Oct 2026 09:43:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B862710F696
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:43:50 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9AA7169C
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:43:46 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 0666C3F7B4
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791884630; bh=NvpLVMdJax3SN0J99Py6TeKJe6+SZcjABcJxWLxyEhg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QWa/BhwMAxUp2SbujlKnlnOqkPspzLqnsUXvYshbv0RjolQGVga4yUrjk80cnpAYO
 a14LzMRjjqI+jq1j+f9As+R2+xUwnK+iBvpLovR+VaWPlf0BQv6OG+Sg+9bwORD/BT
 8K+bPOOIrNU6YTRcg3v7mmBrFGysQbI8HCYXnbxQ=
Date: Tue, 13 Oct 2026 10:43:38 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Erik Faye-Lund <erik.faye-lund@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Karunika Choo <karunika.choo@arm.com>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] odrm/panthor: fix immortalis condition
Message-ID: <as39SlIbaPfwfsUJ@e142607>
References: <20261013093150.4186117-1-erik.faye-lund@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013093150.4186117-1-erik.faye-lund@arm.com>
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

On Tue, Oct 13, 2026 at 11:31:50AM +0200, Erik Faye-Lund wrote:
> Exactly 10 cores is also valid for an Immortalis configuration,
> according to the public documentation:
> 
> https://support.arm.com/compute-ip/immortalis-g715
> 
> So let's report this G715 with 10 cores as Immortalis as well, as long
> as it supports the ray-intersection feature. This matches what we do for
> more recent GPUs as well.
> 
> Fixes: 3b1dc21d6d80 ("drm/panthor: Add support for Mali-Gx15 family of GPUs")

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 7e315708ca7c..ea1e222ef121 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -136,7 +136,7 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
>  	case GPU_PROD_ID_MAKE(10, 7):
>  		return "Mali-G610";
>  	case GPU_PROD_ID_MAKE(11, 2):
> -		if (shader_core_count > 10 && ray_intersection)
> +		if (shader_core_count >= 10 && ray_intersection)
>  			return "Mali-G715-Immortalis";
>  		else if (shader_core_count >= 7)
>  			return "Mali-G715";
> -- 
> 2.47.3
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
