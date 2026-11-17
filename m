Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD8606AF52
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=czmzT0/D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A18510F6F4;
	Tue, 17 Nov 2026 13:07:41 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9D52810F6F4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:07:35 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1216)
 id 05C9120B716A; Tue, 17 Nov 2026 05:07:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05C9120B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1794920855;
 bh=UmMOuYk7GOgGO2Uj4xQY5WbziGT48+mQLZEv3mhfCMM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=czmzT0/DkQB0vju00M9RFTeQzxKqWXCbMxz2JaSeZaZ6I7fcF++uRG8Q9AoX4sGBT
 8XaBtqnVqxZKbejYXdtwoYbZqGvuFSYK1HU5mrObVumJMU65drppsawQo3e7njGxd9
 XfCRVBG1frThCDr7H23ZoPOw7MjwCt2t8bUQee1g=
Date: Tue, 17 Nov 2026 08:07:34 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 11/64] drm/hyperv: Switch to
 drm_mode_config_create_initial_state
Message-ID: <avxRlhKfNlW3nVWB@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-11-0bb471f4d1e0@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-drm-no-more-config-reset-v2-11-0bb471f4d1e0@kernel.org>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 11:30:27AM +0100, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
> 
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
> 
> Switch to drm_mode_config_create_initial_state().
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

> ---
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index 759952f4ff19..73938303e663 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -500,9 +500,7 @@ int hv_drm_mode_config_init(struct hv_drm_device *hv)
>  
>  	ret = drm_vblank_init(dev, 1);
>  	if (ret)
>  		return ret;
>  
> -	drm_mode_config_reset(dev);
> -
> -	return 0;
> +	return drm_mode_config_create_initial_state(dev);
>  }
> 
> -- 
> 2.56.1
> 
