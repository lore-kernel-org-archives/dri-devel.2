Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719BCC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 07:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1E4110E137;
	Wed, 15 Jul 2026 07:13:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Toa4B1qb";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C125310E137
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 07:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784099623;
 bh=pZa09brkd10z0oCV2TZgsc4riiw/UWtjrPZPAyM989Q=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Toa4B1qbr4LtURg6wVyLmoFj1Qmtt9V0gr8pDUkw7yeSTbn6PX3geR3OGu3zBwUSE
 kwbcY0Kn1JVt2yT9K21cKxNQArjeZgMvIZxxmL1HjVt451Jd0lEs0E+a6h4Q2lDGQQ
 MzZX2ShMU4fz4rtFlFZjZm6GsKsushHtoLabkKC/Vhn1dT7rNeP8gxTom1H0n+OtMI
 XCQAiY+j5QwSUb+mbVcOOauTl0p+NfJrf38Zwx6yyKB7eUmWhQ5N+6ybY2PatPDLiG
 bzO21tH4a72Db8bIkpwXLJojUWbz2BFkQj4TBKg9XPHb5FsEoKJtAFkqgAsq8CA6KW
 e39fs6ayy+InA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CBF0B17E071A;
 Wed, 15 Jul 2026 09:13:42 +0200 (CEST)
Date: Wed, 15 Jul 2026 09:13:38 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Heiko Stuebner
 <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: return error on truncated firmware
Message-ID: <20260715091338.537b6ff8@fedora-2.home>
In-Reply-To: <20260714163056.22329-1-osama.abdelkader@gmail.com>
References: <20260714163056.22329-1-osama.abdelkader@gmail.com>
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

On Tue, 14 Jul 2026 18:30:55 +0200
Osama Abdelkader <osama.abdelkader@gmail.com> wrote:

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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

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

