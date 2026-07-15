Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18CDC44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 12:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 420BB10E126;
	Wed, 15 Jul 2026 12:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="M4IKk3GA";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E649810E126
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 12:40:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784119208; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=baLqQDNLRjzh+brdn4GNpg7BrcJePw1t9WaYcJkc/E+DfIx4meyCtRorc8YDznyhFvmojEuYeQQMPMOoBZpfX62i7giDtRd4YZJ0FeolCsRQqd7KoYMQrBEHtrq3llJEr+iI73x/Z+LRCAvQujRcVJXveZgSdS6oYIuLUsNZfXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784119208;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=+I1b/owU/yq2us4KQX29FdI6Z7kCdnxHxEnOX13hBXA=; 
 b=T3l+tjjAwXKyeid9FFn2ushKV7v5XskiGWA4cOFlXz7EC5EXStEbyfgTJhYLy0Ak78Dq9UMotGvEkKdnYvDAR1S2AOukb1wjHWpkjKGwKkpjt8VdoLxSnndMqgY3oDC5DWdmHvC5C2NEuFqgWNf9Ny/P8eHBTbZjnyRjKvYqnOE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784119208; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=+I1b/owU/yq2us4KQX29FdI6Z7kCdnxHxEnOX13hBXA=;
 b=M4IKk3GA88LOD64gS2yEudsUSEFTE+b5CUAJbKd5jvU+rcCNiA9gPFERfUebrpvJ
 +w0Gdkauh1t1pwR6cWIZwnEFK4fm/QP0mS8pChp+G5k3Bj4cCCaw9btr3Lfh5XypTx2
 o4UV3E+k2yD95IN2GG4yFPVBdul63AR6f6N4aLW0=
Received: by mx.zohomail.com with SMTPS id 1784119205798338.3895518709709;
 Wed, 15 Jul 2026 05:40:05 -0700 (PDT)
Date: Wed, 15 Jul 2026 13:40:01 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Check debugfs GEM lock initialization
Message-ID: <ald_i92r4A1wc3MQ@sobremesa>
References: <20260713082912.321021-1-lilinmao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260713082912.321021-1-lilinmao@kylinos.cn>
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

Reviewed-by: Adrián Larumbe <adrian.larumbe@collabora.com>

On 13.07.2026 16:29, Linmao Li wrote:
> drmm_mutex_init() can fail while registering the managed cleanup action.
> When that happens, drmm_add_action_or_reset() destroys the mutex before
> returning the error. Continuing initialization would therefore leave the
> debugfs GEM object list with an unusable lock.
> 
> Propagate the error as is already done for the other managed mutexes in
> panthor_device_init().
> 
> Fixes: a3707f53eb3f ("drm/panthor: show device-wide list of DRM GEM objects over DebugFS")
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> ---
>  drivers/gpu/drm/panthor/panthor_device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
> index 0b25abebb803..9687c59de350 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.c
> +++ b/drivers/gpu/drm/panthor/panthor_device.c
> @@ -182,7 +182,10 @@ int panthor_device_init(struct panthor_device *ptdev)
>  		return ret;
>  
>  #ifdef CONFIG_DEBUG_FS
> -	drmm_mutex_init(&ptdev->base, &ptdev->gems.lock);
> +	ret = drmm_mutex_init(&ptdev->base, &ptdev->gems.lock);
> +	if (ret)
> +		return ret;
> +
>  	INIT_LIST_HEAD(&ptdev->gems.node);
>  #endif
>  
> -- 
> 2.25.1
> 

Adrian Larumbe
