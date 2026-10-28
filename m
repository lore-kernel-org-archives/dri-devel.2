Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B606606A31D
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bw7HXkHU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F5F10E688;
	Wed, 28 Oct 2026 15:51:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id DADFC10E688
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 15:51:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2309F1756
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:51:09 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 098D63F673
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 08:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793202672; bh=QHIk/uWzcHH5EhNGbfwfN7gO5R91eIxjJbKUe2LX8Uc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bw7HXkHUqW+g+r78yBdcnPIblKzh4FaILf60hIJexG9vce8gjjN9dGXXtdMxG31Mj
 oQ7rSFVQL2bERimAnLUZ4z6WsUZdGg3FM/u+9I00UeznQKIPUyMfnGC8LltL4DiEbl
 OCalmm/N70Dz320VCgd4tV59rdzcuyGbFy71inWw=
Date: Wed, 28 Oct 2026 15:51:10 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: Re: [PATCH v1 01/27] drm/panthor: Ignore -EOPNOTSUPP for
 shader-present nvmem lookup
Message-ID: <auIZ7rtnOPVXnFHw@e142607>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-2-karunika.choo@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260922204535.2850094-2-karunika.choo@arm.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 22, 2026 at 09:44:55PM +0100, Karunika Choo wrote:
> When CONFIG_NVMEM is disabled, reading the optional "shader-present"
> nvmem cell can return -EOPNOTSUPP.
> 
> Treat this the same as the cell being absent so panthor can continue
> probing on platforms that do not provide shader-present fuses through
> nvmem.
> 
> Fixes: c40b50c3cfbe ("drm/panthor: Implement reading shader_present from nvmem")
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

I will probably pick some fixes from this series and apply them regardless.

Best regards,
Liviu

> ---
> v1:
> - Picked up R-bs from Boris and Steve
> - Added Fixes tag
> 
>  drivers/gpu/drm/panthor/panthor_hw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
> index 7e315708ca7ca..4c96573b649a1 100644
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
