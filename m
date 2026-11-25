Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51AB606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=ZHeQaYSG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE87210FA4B;
	Wed, 25 Nov 2026 08:55:36 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70DD010FA4B
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 08:55:30 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C57E773E;
 Wed, 25 Nov 2026 09:52:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795596775;
 bh=dESCZsbPGPxc8wE1cEHC62NnZt0wMuGIc1HwquYJ9fc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZHeQaYSG4Sg8uG8pijSRWImxtkXvFJip4ruHLR4PWrINxxKmKfuhtjJdhfubrSM/m
 jmoWyrDFAdJUq5UfkKVDOTaKwIL/mQcHTHk03/4zyUmRt9zM57RzDhGqmo3DjcbsMI
 Clw2Zk7GHn07JOsSO8W7RqE4u/clpHZ8x3uu3Nk4=
Message-ID: <ff6aeb12-270e-4959-838a-260bed0fb336@ideasonboard.com>
Date: Wed, 25 Nov 2026 10:55:24 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/42] drm/atomic_sro: Create drm_atomic_sro_state
 container
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
 <20261120-drm-state-readout-v9-13-a67c2b45b8ec@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261120-drm-state-readout-v9-13-a67c2b45b8ec@kernel.org>
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
> The SRO infrastructure needs a state container to collect the readout
> states for all KMS objects. Unlike drm_atomic_commit which tracks old
> and new states for atomic commits, this container only holds a single
> state per object: the one read out from the hardware.
> 
> Create struct drm_atomic_sro_state with arrays for planes, CRTCs,
> connectors, and private objects, along with accessors to get and set
> individual object states within it.
> 
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/Makefile                   |   1 +
>   drivers/gpu/drm/drm_atomic_state_readout.c | 491 +++++++++++++++++++++++++++++
>   include/drm/drm_atomic_state_readout.h     |  51 +++
>   3 files changed, 543 insertions(+)
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 2c6bc093a923..e94b77497514 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -32,10 +32,11 @@ endif
>   # Enable -Werror in CI and development
>   subdir-ccflags-$(CONFIG_DRM_WERROR) += -Werror
>   
>   drm-y := \
>   	drm_atomic.o \
> +	drm_atomic_state_readout.o \
>   	drm_atomic_uapi.o \
>   	drm_auth.o \
>   	drm_blend.o \
>   	drm_bridge.o \
>   	drm_cache.o \
> diff --git a/drivers/gpu/drm/drm_atomic_state_readout.c b/drivers/gpu/drm/drm_atomic_state_readout.c
> new file mode 100644
> index 000000000000..c00631800234
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_atomic_state_readout.c
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_state_readout.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_print.h>
> +#include <linux/module.h>
> +#include <linux/sched/mm.h>
> +
> +#include "drm_internal.h"
> +#include "drm_crtc_internal.h"
> +
> +struct __drm_atomic_sro_plane {
> +	struct drm_plane *ptr;
> +	struct drm_plane_state *state;
> +};
> +
> +struct __drm_atomic_sro_crtc {
> +	struct drm_crtc *ptr;
> +	struct drm_crtc_state *state;
> +};
> +
> +struct __drm_atomic_sro_connector {
> +	struct drm_connector *ptr;
> +	struct drm_connector_state *state;
> +};
> +
> +struct __drm_atomic_sro_private_obj {
> +	struct drm_private_obj *ptr;
> +	struct drm_private_state *state;
> +};
> +
> +struct drm_atomic_sro_state {
> +	struct drm_device *dev;
> +	struct __drm_atomic_sro_plane *planes;
> +	struct __drm_atomic_sro_crtc *crtcs;
> +	struct __drm_atomic_sro_connector *connectors;
> +	unsigned int max_connector_index;
> +	struct __drm_atomic_sro_private_obj *private_objs;
> +	unsigned int num_private_objs;

The private_objs makes me feel a bit uneasy. You add to private_objs 
array dynamically, without any check for the array size. An extra call 
to drm_atomic_sro_set_private_obj_state() will write over the array.

If you're sure that can never happen, fine for me.

  Tomi

