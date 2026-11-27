Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D19606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 11:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=I6tLc4Zb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B0A1127F9;
	Fri, 27 Nov 2026 11:20:37 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA2E41127F9
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:20:30 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 73D78BA;
 Fri, 27 Nov 2026 12:17:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795778274;
 bh=D9yHvGYE2mRfS76rEL3c+wCJXooZEaX9VALLMTkVC0A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=I6tLc4ZbByObnvCMhRmzyVk92AZo4fiMg9rU4QM0/R1visYBgKxXrd73cCGHQr2dK
 Om4BFPrGF7qp544oXe4z7hdpSJqwjgqr4vjkUiqWI5JwZ+KWpFedrIvqWk7LDhuB2W
 Vig85MI0uJDZANz6B1EOpgN1nbDkD1B6JIpXgXJ8=
Message-ID: <144b784f-2487-465f-8399-69a7393f55da@ideasonboard.com>
Date: Fri, 27 Nov 2026 13:20:24 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 16/36] drm/atomic-state-helper: Provide comparison
 macros
To: Maxime Ripard <mripard@kernel.org>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
 <20261127-drm-state-readout-v10-16-0259582d45a8@kernel.org>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261127-drm-state-readout-v10-16-0259582d45a8@kernel.org>
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

On 27/11/2026 11:52, Maxime Ripard wrote:
> In order to make the implementation of atomic_sro_compare_state easier
> and reduce the boilerplate, introduce a set of STATE_CHECK_* macros to
> compare state field values depending on their type.
> 
> Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>   drivers/gpu/drm/drm_atomic_state_readout_helper.c |  30 +++
>   include/drm/drm_atomic_state_readout_helper.h     | 220 ++++++++++++++++++++++
>   2 files changed, 250 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_readout_helper.c b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
> index c2bb7b47126c..f9808c8271a5 100644
> --- a/drivers/gpu/drm/drm_atomic_state_readout_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_readout_helper.c
> @@ -1069,5 +1069,35 @@ void drm_atomic_helper_sro_install_state(struct drm_atomic_sro_state *state)
>   		state->private_objs[i].state = NULL;
>   		state->private_objs[i].ptr = NULL;
>   	}
>   }
>   EXPORT_SYMBOL(drm_atomic_helper_sro_install_state);
> +
> +/**
> + * drm_atomic_helper_print_state_mismatch - report a state comparison mismatch
> + * @p: printer to report through
> + * @name: human-readable name of the object (e.g. plane or CRTC name)
> + * @field: name of the mismatching field
> + * @format: printf-style format string describing the mismatch
> + *
> + * Helper used by atomic_sro_compare_state implementations and the
> + * STATE_CHECK_* macros to report a field-level mismatch between the
> + * committed state and the state read back from hardware.
> + */
> +void __printf(4, 5)
> +drm_atomic_helper_print_state_mismatch(struct drm_printer *p,
> +				       const char *name,
> +				       const char *field,
> +				       const char *format, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +
> +	va_start(args, format);
> +	vaf.fmt = format;
> +	vaf.va = &args;
> +
> +	drm_printf(p, "%s configuration mismatch in %s %pV\n", name, field, &vaf);
> +
> +	va_end(args);
> +}
> +EXPORT_SYMBOL(drm_atomic_helper_print_state_mismatch);
> diff --git a/include/drm/drm_atomic_state_readout_helper.h b/include/drm/drm_atomic_state_readout_helper.h
> index 315a54141249..c4111fd825f0 100644
> --- a/include/drm/drm_atomic_state_readout_helper.h
> +++ b/include/drm/drm_atomic_state_readout_helper.h
> @@ -1,14 +1,17 @@
>   /* SPDX-License-Identifier: GPL-2.0-or-later */
>   
>   #ifndef DRM_ATOMIC_SRO_HELPER_H_
>   #define DRM_ATOMIC_SRO_HELPER_H_
>   
> +#include <linux/string_choices.h>
> +
>   struct drm_atomic_commit;
>   struct drm_atomic_sro_state;
>   struct drm_device;
>   struct drm_gem_dma_object;
> +struct drm_printer;
>   
>   struct drm_gem_dma_object *
>   drm_atomic_helper_sro_create_gem_dma_object(struct drm_device *dev,
>   					    dma_addr_t dma_addr, size_t size);
>   
> @@ -36,6 +39,223 @@ struct drm_atomic_sro_state *
>   drm_atomic_helper_sro_build_state(struct drm_device *dev,
>   				  struct drm_atomic_commit *commit);
>   int drm_atomic_helper_sro_readout_state(struct drm_device *dev);
>   void drm_atomic_helper_sro_install_state(struct drm_atomic_sro_state *state);
>   
> +void __printf(4, 5)
> +drm_atomic_helper_print_state_mismatch(struct drm_printer *p,
> +				       const char *name,
> +				       const char *field,
> +				       const char *format, ...);
> +
> +#define STATE_CHECK_BOOL(r, p, n, sa, sb, f)				\
> +	do {								\
> +		static_assert(__same_type(sa->f, sb->f),		\
> +			      __stringify(f) " field types don't match"); \
> +		static_assert(__same_type(sa->f, bool),			\
> +			      __stringify(f) " is not a bool");		\
> +		if (sa->f != sb->f) {					\
> +			drm_atomic_helper_print_state_mismatch(p,	\
> +							       n,	\
> +							       __stringify(f), \
> +							       "expected %s, got %s", \
> +							       str_yes_no(sa->f), \
> +							       str_yes_no(sb->f)); \
> +			r = false;					\
> +		}							\
> +	} while (0)
> +
> +#define STATE_CHECK_DISPLAY_MODE(r, p, n, sa, sb, f)			\
> +	do {								\
> +		static_assert(__same_type(sa->f, sb->f),		\
> +			      __stringify(f) " field types don't match"); \
> +		static_assert(__same_type(sa->f, struct drm_display_mode), \
> +			      __stringify(f) " is not a drm_display_mode structure"); \
> +		if (!drm_mode_equal(&sa->f, &sb->f)) {			\

This has the problem that we can't recreate the state from HW fully, and 
picture_aspect_ratio causes a check failure (so I saw a failure when 
setting mode with HDMI_PICTURE_ASPECT_4_3). I'm not sure if flags might 
also cause failures.

  Tomi

