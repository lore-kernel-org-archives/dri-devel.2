Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C2BCC6B3A
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:15:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10FE011230E;
	Thu, 15 Oct 2026 11:15:03 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 869F810E283
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:14:56 +0000 (UTC)
Received: by linux.microsoft.com (Postfix, from userid 1127)
 id 2BCFD20B7167; Thu, 15 Oct 2026 04:14:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BCFD20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1792062892;
 bh=ZL8nnzLUNTL3zUNbmnNPodXug8ZfJ0H1444W1zzr2cs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bIdLe+45NxF3LMB7moWQ16meOloiGVDORQo+RUgsoDWgoK5MfoJM/jdFSuCSkDsm3
 nDzCu+FhmdMykPlYAdvtbzpdw58zgwBVG+EL15bYygPl4ppKbcEHM0WED2+R8hEz6Q
 q4s3H7yABfDW6o5ovTw6ztIPpNbjJjlDd1EAtYyk=
Date: Thu, 15 Oct 2026 04:14:52 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 24/75] drm/hyperv: Switch to
 drm_atomic_helper_connector_create_state
Message-ID: <atC1rBMREaDZN79W@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-24-586c9c026823@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-24-586c9c026823@kernel.org>
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

On Wed, Oct 14, 2026 at 07:26:47PM +0200, Maxime Ripard wrote:
> The hyperv connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_connector_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index 523d1c7ea072..da399cb951a5 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -64,11 +64,11 @@ static const struct drm_connector_helper_funcs hv_drm_connector_helper_funcs = {
>  };
>  
>  static const struct drm_connector_funcs hv_drm_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = drm_connector_cleanup,
> -	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_create_state = drm_atomic_helper_connector_create_state,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
>  static inline int hv_drm_conn_init(struct hv_drm_device *hv)
> 
> -- 
> 2.55.0

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
