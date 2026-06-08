Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6116CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4176010F685;
	Mon,  8 Jun 2026 16:06:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="HefauTVU";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B7BF710F685
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:06:42 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6363E201B;
 Mon,  8 Jun 2026 09:06:37 -0700 (PDT)
Received: from [10.57.28.93] (unknown [10.57.28.93])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D7E63FD88;
 Mon,  8 Jun 2026 09:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780934802; bh=4TVd+FPhUWGa/XCX0CLqCRT2+tOLqtqx9WCwAD634gY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=HefauTVUZavGNb/19w2Yx0UiagnGIKG2AqF4iKkPsRZ7pnrUDuJiQcm169oH0xN+u
 F1tlyn2QO6g4x0CBgrgqbNMvyByFnSC4rKubW8nAoF+QF0ESzyH4y1/KTjFHw0t5hl
 2ZeMuES5R98GM08CE8jtlNgP3VZRwKMq64/z2ghg=
Message-ID: <e7520150-df05-4d25-9d0e-297fc26c5553@arm.com>
Date: Mon, 8 Jun 2026 17:06:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/18] drm/panthor: Ignore -EOPNOTSUPP for
 shader-present nvmem lookup
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-2-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260528150546.3168527-2-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
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

On 28/05/2026 16:05, Karunika Choo wrote:
> When CONFIG_NVMEM is disabled, reading the optional "shader-present"
> nvmem cell can return -EOPNOTSUPP.
> 
> Treat this the same as the cell being absent so panthor can continue
> probing on platforms that do not provide shader-present fuses through
> nvmem.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Do we need a fixes too?

Fixes: c40b50c3cfbe ("drm/panthor: Implement reading shader_present from
nvmem")

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 7e315708ca7c..4c96573b649a 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.c
> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
> @@ -182,7 +182,7 @@ static int overload_shader_present(struct panthor_device *ptdev)
>  					      &contents);
>  	if (!ret)
>  		ptdev->gpu_info.shader_present = contents;
> -	else if (ret == -ENOENT)
> +	else if (ret == -ENOENT || ret == -EOPNOTSUPP)
>  		return 0;
>  	else
>  		return dev_err_probe(ptdev->base.dev, ret,

