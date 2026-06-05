Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FA4CD6E79
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 12:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13C9211A7E9;
	Fri,  5 Jun 2026 12:17:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="sbw9YP3T";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 058A911A7E6
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 12:17:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4CDB4CF9
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 05:17:17 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 69A503F7D8
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 05:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780661842; bh=n0x8+FGL5EB3lueMGJs2SlV+B6iWu4TkRtDg1ecnhL8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sbw9YP3T63j3hyCGRytCmI6nP6Dp+ky67dPK4lfbs858JlUnlc9XZJHI11zIKNVBb
 BlNqHmy8b6frAreFF5WgC7StN+EsCWRSq4/xElmRf1mfNBuzXNCh4rQ28JzF8EUKg3
 3H3T7aL6QN3hn9dVXtOwrq2AbWefEW5/77kZJwk4=
Date: Fri, 5 Jun 2026 13:17:20 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Gustavo Kenji =?utf-8?B?TWVuZG9uw6dh?= Kaneko <kaneko.dev@pm.me>
Cc: dri-devel@lists.freedesktop.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/arm/komeda: fix ignored clk_prepare_enable()
 return value in resume
Message-ID: <aiK-UDx8OZMnK-2j@e142607>
References: <20260531052945.65117-1-kaneko.dev@pm.me>
 <20260531052945.65117-2-kaneko.dev@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260531052945.65117-2-kaneko.dev@pm.me>
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

On Sun, May 31, 2026 at 05:30:02AM +0000, Gustavo Kenji Mendonça Kaneko wrote:
> komeda_dev_resume() calls clk_prepare_enable() without checking the
> return value. If the clock fails to enable, the function returns 0
> (success) while IRQs are enabled and IOMMU is connected on potentially
> unclocked hardware, causing undefined behavior on resume.
> 
> Propagate the error from clk_prepare_enable() and return early on
> failure to prevent hardware access without a valid clock.
> 
> This issue was found by code review without access to Komeda hardware.

Hello,

There is nothing wrong with the content of this patch, but I would like
if anyone wants to fix these kind of problems to at least be thorough.

komeda_dev_suspend() is also ignoring the errors coming from
clk_disable_unprepare() and both fuctions before this patch always return 0,
so in komeda_drv.c we can sometimes ignore the return value. If we add
an extended version of this patch then we should also do proper error
handling in komeda_drv.c

Best regards,
Liviu


> 
> Signed-off-by: Gustavo Kenji Mendonça Kaneko <kaneko.dev@pm.me>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index 5ba62e637a61..9aad1d1d28ec 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -313,7 +313,11 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
>  
>  int komeda_dev_resume(struct komeda_dev *mdev)
>  {
> -	clk_prepare_enable(mdev->aclk);
> +	int err;
> +
> +	err = clk_prepare_enable(mdev->aclk);
> +	if (err)
> +		return err;
>  
>  	mdev->funcs->enable_irq(mdev);
>  
> -- 
> 2.54.0
> 
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
