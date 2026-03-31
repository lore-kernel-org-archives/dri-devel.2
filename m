Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CBA109B46C
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB7010E966;
	Tue, 31 Mar 2026 13:30:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SVQihlVr";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B9F10E966
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 13:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i359L3D6i+HcMXyh7JMK+wS69mVOpTxBPeKoAIfOEIk=; b=SVQihlVrDV+mImQS+zqwV5GqBG
 zHZc6GikB74xu2e1/OzY9w4cWhLU5MC1c9OH3U84g4BP4065nkdTPUUqFOGWOZzOqCwnxfIuZP8Sa
 yKOTNBtouyby3G6WbaziuWINLF/nQzTeGuiPz0XICyuA7lvyN/EYxlZgf8KtjlrnFR9a/IL0Ce3uY
 Ynnu4HsHDy3knWfaKyqATqQ4DoPKeXTI4TgNBN3TtNht7CawVjzmtjujKW7ta462zH0DCkPypWxQ3
 1QCf656/WoKFcCStDncSeJRJai/S5CFb+2PT6C9gPg9rpjNa5LYC09kWn8x+pQNj9ACBB1ClU7TMm
 ldyhYMyA==;
Received: from [189.89.58.122] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1w7ZAS-009TFX-Jk; Tue, 31 Mar 2026 15:30:04 +0200
Message-ID: <1cf672d8-f08e-4760-acb2-e0dd5c09ef87@igalia.com>
Date: Tue, 31 Mar 2026 10:30:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] drm/vc4: Clean-up UAPI header inclusion
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Iago Toral <itoral@igalia.com>, Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Boris Brezillon <bbrezillon@kernel.org>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
References: <20260330-vc4-misc-fixes-v1-0-92defc940a29@igalia.com>
 <20260330-vc4-misc-fixes-v1-6-92defc940a29@igalia.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260330-vc4-misc-fixes-v1-6-92defc940a29@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 30/03/2026 14:51, Maíra Canal wrote:
> "uapi/drm/vc4_drm.h" is already included through "vc4_drv.h". Therefore,
> remove its direct inclusion from several files.
Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> Suggested-by: Melissa Wen <mwen@igalia.com>
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/vc4/vc4_bo.c        | 1 -
>   drivers/gpu/drm/vc4/vc4_drv.c       | 2 --
>   drivers/gpu/drm/vc4/vc4_gem.c       | 1 -
>   drivers/gpu/drm/vc4/vc4_plane.c     | 2 --
>   drivers/gpu/drm/vc4/vc4_render_cl.c | 1 -
>   drivers/gpu/drm/vc4/vc4_validate.c  | 1 -
>   6 files changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> index 9377e58f9bc256ea81e19cc442d04139feec20fe..2161761b1f2215c3ce7054caf21019d4be5c70d9 100644
> --- a/drivers/gpu/drm/vc4/vc4_bo.c
> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
> @@ -22,7 +22,6 @@
>   #include <drm/drm_print.h>
>   
>   #include "vc4_drv.h"
> -#include "uapi/drm/vc4_drm.h"
>   
>   static const struct drm_gem_object_funcs vc4_gem_object_funcs;
>   
> diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
> index a14ecb7694613f15df3cfdb0195825d961fe1707..616caf9d9915b9ed7f614d6f0339fa6ee2cb80e3 100644
> --- a/drivers/gpu/drm/vc4/vc4_drv.c
> +++ b/drivers/gpu/drm/vc4/vc4_drv.c
> @@ -41,8 +41,6 @@
>   
>   #include <soc/bcm2835/raspberrypi-firmware.h>
>   
> -#include "uapi/drm/vc4_drm.h"
> -
>   #include "vc4_drv.h"
>   #include "vc4_regs.h"
>   
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> index ab3c6d5d4eb446804877d6b8da01c3a9f65800df..e231c906709c1b15bd19e3f478ad86048700ba55 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -33,7 +33,6 @@
>   #include <drm/drm_print.h>
>   #include <drm/drm_syncobj.h>
>   
> -#include "uapi/drm/vc4_drm.h"
>   #include "vc4_drv.h"
>   #include "vc4_regs.h"
>   #include "vc4_trace.h"
> diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
> index 91d499fefba2189131ff96270a9b001d694ab2ae..a81bad3519ccf3e8056a2ae37ddcfeccc2306a14 100644
> --- a/drivers/gpu/drm/vc4/vc4_plane.c
> +++ b/drivers/gpu/drm/vc4/vc4_plane.c
> @@ -26,8 +26,6 @@
>   #include <drm/drm_gem_atomic_helper.h>
>   #include <drm/drm_print.h>
>   
> -#include "uapi/drm/vc4_drm.h"
> -
>   #include "vc4_drv.h"
>   #include "vc4_regs.h"
>   
> diff --git a/drivers/gpu/drm/vc4/vc4_render_cl.c b/drivers/gpu/drm/vc4/vc4_render_cl.c
> index edc471e71c0eb1729c0dcf823ca6c9e0a7e207ed..c264d21bc3fe357ec28048760243b27b3dc26b1b 100644
> --- a/drivers/gpu/drm/vc4/vc4_render_cl.c
> +++ b/drivers/gpu/drm/vc4/vc4_render_cl.c
> @@ -37,7 +37,6 @@
>   
>   #include <drm/drm_print.h>
>   
> -#include "uapi/drm/vc4_drm.h"
>   #include "vc4_drv.h"
>   #include "vc4_packet.h"
>   
> diff --git a/drivers/gpu/drm/vc4/vc4_validate.c b/drivers/gpu/drm/vc4/vc4_validate.c
> index 545c4c3608f5683209ea1462d61d9d0dd68d0bd7..7f2fadfde7a8ee63a531a98474a8447b37faaac1 100644
> --- a/drivers/gpu/drm/vc4/vc4_validate.c
> +++ b/drivers/gpu/drm/vc4/vc4_validate.c
> @@ -45,7 +45,6 @@
>   
>   #include <drm/drm_print.h>
>   
> -#include "uapi/drm/vc4_drm.h"
>   #include "vc4_drv.h"
>   #include "vc4_packet.h"
>   
>

