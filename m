Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D062DC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A5910E144;
	Wed, 15 Jul 2026 10:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="otAW6xSV";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 35C2410E144
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 10:43:07 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A95B152B
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 03:43:02 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 4C9303F7B4
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784112186; bh=aa3pG2P5vQO0i02r0jp442RpbvJBP4nam9HCCrn4gJ0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=otAW6xSVx4YC7rOMXb0A3S+sTOyNX29mEfUi6PkZiibRDtaarCM3gv9OqMztRGKse
 lch37dd3z490VjH1dRIdq3OKNqHwJ26ybjw+Bs+lSr9uDrWeCZ56fxjykIaxfyVcyR
 q+OEfbXzmBRcbOweEGj5S51N7Joq0Ybg6j4B9fbo=
Date: Wed, 15 Jul 2026 11:42:54 +0100
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
Subject: Re: [PATCH] drm/panthor: return error on truncated firmware
Message-ID: <aldkLnuKwCx4rc7k@e142607>
References: <20260714163056.22329-1-osama.abdelkader@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714163056.22329-1-osama.abdelkader@gmail.com>
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

On Tue, Jul 14, 2026 at 06:30:55PM +0200, Osama Abdelkader wrote:
> panthor_fw_load() detects truncated firmware images, but jumps to the
> common cleanup path without setting ret. If no previous error was recorded,
> the function can return 0 and treat the invalid firmware as successfully
> loaded.
> 
> Set ret to -EINVAL before leaving the truncated-image path.
> 
> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Thanks for the fix!

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 986151681b24..39fff094ebb5 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -829,6 +829,7 @@ static int panthor_fw_load(struct panthor_device *ptdev)
>  	}
>  
>  	if (hdr.size > iter.size) {
> +		ret = -EINVAL;
>  		drm_err(&ptdev->base, "Firmware image is truncated\n");
>  		goto out;
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
