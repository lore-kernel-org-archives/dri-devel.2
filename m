Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F1D606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=cbpX9+m2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B3671128FA;
	Fri, 27 Nov 2026 09:46:41 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5241128FA
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:46:35 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 729B2BA;
 Fri, 27 Nov 2026 10:43:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795772639;
 bh=uqz5d6wMfKLAiqN0yEh2WmQiuiS79sHlKEU0BRxsarc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=cbpX9+m2a1fGWhe5TN1ave7G5NBJu5OUQvKMAGHAx7VSM+709icIfjLQnFjSmzNif
 0R6J1XiQbqxtCKb+cYxGSqD6mk85dWbeVqtkzmDvXPfcibq89Y0ExRhNzYCR71qTtS
 6BLS4cK5d2lKk9ptzSHf3w+Z0KhLuBRX7xqdbDDI=
Message-ID: <2f4dc371-0015-457f-9cd4-8aaf47a7032b@ideasonboard.com>
Date: Fri, 27 Nov 2026 11:46:30 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/42] drm/atomic_sro: Create documentation
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20261120-drm-state-readout-v9-0-a67c2b45b8ec@kernel.org>
 <20261120-drm-state-readout-v9-16-a67c2b45b8ec@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261120-drm-state-readout-v9-16-a67c2b45b8ec@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 20/11/2026 14:55, Maxime Ripard wrote:
> The SRO infrastructure has grown to span multiple files and hooks
> but lacks an overview section explaining the overall design and how
> drivers should integrate with it.
> 
> Add a DOC: overview section to drm_atomic_state_readout.c describing the
> various SRO phases and how drivers wire up the callbacks.
> 
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   Documentation/gpu/drm-kms-helpers.rst      | 17 ++++++++++++++
>   drivers/gpu/drm/drm_atomic_state_readout.c | 37 ++++++++++++++++++++++++++++++
>   2 files changed, 54 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
> index d64f941d34f5..b75bde712faf 100644
> --- a/Documentation/gpu/drm-kms-helpers.rst
> +++ b/Documentation/gpu/drm-kms-helpers.rst
> @@ -80,10 +80,27 @@ Atomic State Helper Reference
>   -----------------------------
>   
>   .. kernel-doc:: drivers/gpu/drm/drm_atomic_state_helper.c
>      :export:
>   
> +.. _drm_atomic_sro:
> +
> +Atomic State Read-Out
> +---------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_atomic_state_readout.c
> +   :doc: overview
> +
> +Atomic State Read-Out Reference
> +--------------------------------
> +
> +.. kernel-doc:: include/drm/drm_atomic_state_readout.h
> +   :internal:
> +
> +.. kernel-doc:: drivers/gpu/drm/drm_atomic_state_readout.c
> +   :export:
> +
>   GEM Atomic Helper Reference
>   ---------------------------
>   
>   .. kernel-doc:: drivers/gpu/drm/drm_gem_atomic_helper.c
>      :doc: overview
> diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm/drm_atomic_state_readout.c
> index dbffbb839e51..67a90202d698 100644
> --- a/drivers/gpu/drm/drm_atomic_state_readout.c
> +++ b/drivers/gpu/drm/drm_atomic_state_readout.c
> @@ -14,10 +14,47 @@
>   #include <linux/sched/mm.h>
>   
>   #include "drm_internal.h"
>   #include "drm_crtc_internal.h"
>   
> +/**
> + * DOC: overview
> + *
> + * The atomic State Read-Out (SRO) infrastructure allows drivers to
> + * initialize the KMS atomic state from the hardware state left by the
> + * firmware at boot, rather than programming a new state. This enables
> + * flicker-free boot (also called "fastboot" by i915): if the
> + * firmware already configured the display, the first userspace
> + * modeset can be skipped when the requested mode matches.

It's kind of implied above, but maybe worth writing it out: SRO also 
allows the driver to keep the displays enabled (without changing 
anything) until the userspace does the modeset.

Other than that:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

> + * The SRO lifecycle has two phases. The first phase is the readout
> + * itself: at driver registration time, each KMS object (CRTCs, planes,
> + * connectors, bridges, private objects) has its
> + * atomic_sro_readout_state hook called to populate a
> + * &struct drm_atomic_sro_state from hardware registers.
> + *
> + * The hardware may have been programmed with a configuration that
> + * the driver doesn't support. The readout hooks are then expected
> + * to return a negative error code, and the state initialization
> + * will fall back to the regular path.
> + *
> + * The second phase is the installation. Once all states have been read
> + * out, &drm_mode_config_helper_funcs.atomic_sro_install_state walks
> + * through the &struct drm_atomic_sro_state and assigns each readout
> + * state as the object's current state. Before doing so, it calls the
> + * optional atomic_sro_install_state hook on each object. This gives
> + * drivers a chance to acquire the resources needed to keep the hardware
> + * state active, such as power domains, clocks, or interrupts. This hook
> + * cannot fail.
> + *
> + * Drivers integrate with SRO by implementing the readout hooks in their
> + * object funcs vtables and setting the
> + * &drm_mode_config_funcs.atomic_sro_readout_state,
> + * &drm_mode_config_helper_funcs.atomic_sro_install_state, and
> + * &drm_mode_config_helper_funcs.atomic_sro_build_state callbacks.
> + */
> +
>   static unsigned int atomic_readout = DRM_ATOMIC_READOUT_ENABLED;
>   module_param_unsafe(atomic_readout, uint, 0400);
>   MODULE_PARM_DESC(atomic_readout,
>   		 "Enable Hardware State Readout (0 = disabled, 1 = enabled, 2 = ignore missing compares, 3 = ignore missing readouts and compares, default = 1)");
>   
> 

