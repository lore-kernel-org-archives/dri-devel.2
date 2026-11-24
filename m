Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DCA606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GeIoL4Ov
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEE710E315;
	Tue, 24 Nov 2026 14:12:24 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E6410E315
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:12:18 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c50aaad19fbso506509566b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 06:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795529537; x=1796134337; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=a2jTjAttfP/k6A0fA1FgjeitHCs9Uab3ZxcInWTSuWk=;
 b=GeIoL4OvAgPAmdVysYXAG2MYqj8UeLCjE12E1UrQ5XFe9v/1wEE7SFfobbNnYQKGnn
 pX3ae65tqru+REk1VAa9iNXOYtlJQo/rjFkGFER/vRtIO8HE2XUrHeYF0yD2KqhdGeXo
 3t2xYOoYtNI2aHJCw01uG8jdPuIGmvh0GZxraWu4t1yfP3gUq4lk6rTb54MThzK7LZx1
 R7HzbcQUp4Q8abD3JKe2dHfLBATKlVJjDGQrBdnfqIda7NaV9B6Q+32PpCATg2rCWEsW
 jyWeyaBq27amHRVKvNLgEAhu5qwnmVBmEodVJeIZsK/HeNU5vD8ABQEfXKeCXIsd90aS
 kPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795529537; x=1796134337;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a2jTjAttfP/k6A0fA1FgjeitHCs9Uab3ZxcInWTSuWk=;
 b=CW1cpGhN/a+mnjVTxOe++CgbE+o3oDBFSwMsPoWpLpPpLVG0TWw0QjwoGr1lUOd7Mt
 4KddYrKtTFQraK6MrXu1LEWxkhbX1rvMbXwEpNM/ZnRp4jMSBpRGgakJ0M+Iah71h6pd
 +oJGpf7EXNs95zNYhFUDqrEjbOyeiiSP/r5RjTVCqqs/ucG2J0wloWY/F0FB/XB+75jw
 cUfSADZJ9hxFlyxZFYYA3K+/Avn0rkcR8c7iNDjxb8hrEkXbEUTX5QvGCy/5gC0CYvLW
 my4jjRhXwFRZDOroQQnP8sTX4zWOtJp0pbpPhoxu9YMXcXOXZgirq3hsvigmZRLSkgjM
 bZIw==
X-Forwarded-Encrypted: i=1;
 AL+hErGTkbVjKXVQvWmRKpQ5WVFTP9kd/MUj0Mp6BuP0Zd7ky34OU+hADDGt9PGjqPjmjYU+QZaoKTrJWYo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/rFba3VcYKnAauuNrQk+miwmYpYX1P1YNRS2417eCHDADUgNGF
 9JstgHyLFcFClTI7JytiwDPOmbJ25KUO3HXbYB6jBkLWdNheB5i99rVq
X-Gm-Gg: AZFdTZeP7tQ7P47NQt8xinInEutg3dEHWfUJr+GKbKGhcYtJQ0BEf+DSdxpYAhtjNTy
 KCO3qWxBmnlmRpMfKxaYCFhwn9Q3DQxLARK5G46PI0ELVK2WkCGtP0IBUCCnS5jGWeUiSGdAKlk
 Lso14xkNMeiUy5ABk0S+zBuJevbJQmEI+xbarKxz5hKrcIO8kv613hCK/FvyhqnaCVHoX/S1/O8
 zxlUR4Z4sGKfzMsPZmYqqyje0CKaoh+KrCzK35AXcAUBcKYTvLmfiF6ZMn31u7Idrr/NjtKK9hw
 nuOyf7P/tLzWGioUMn1AGGm/J/xAa25hHtp6j9Dt5POkzkzZllCK7Oz7xkNvWkJl9DGgl6j8Oyx
 MogJo/cbWkzwwCf/1TiyK3vi0+Hno8XvwVDr2329k0QtR8LAMKvaoPtLB6GYQpY6+JYNUBbireT
 QqrUAOl+Zu5e4U0+eipavUUB1rvMZvAqvs7saWmemkbcjJhADBUrTZvj4DK8g8DBVu8np7DfXwR
 g0jp8y4hz1aliQVBR0fSujrRDRIIJrTOv+BsGZZZkE16lTulti8H5DT/tazAvXhjCEQa7eW9y1N
 8mNYHiVDLeSg4HGtPi8lcqj9IJGHeaE=
X-Received: by 2002:a17:906:26cd:b0:c41:26b8:c49c with SMTP id
 a640c23a62f3a-c513a5db1d6mr934692166b.10.1795529536866; 
 Tue, 24 Nov 2026 06:12:16 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513ae8db37sm520054266b.35.2026.11.24.06.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:12:16 -0800 (PST)
From: Oarora Etimis <oaroraetimis@gmail.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Melissa Wen <melissa.srw@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 jose.exposito89@gmail.com, Jonathan Corbet <corbet@lwn.net>,
 Harry Wentland <harry.wentland@amd.com>,
 Lucas De Marchi <demarchi@kernel.org>,
 Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com,
 victoria@system76.com, thomas.petazzoni@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>,
 llvm@lists.linux.dev
Subject: Re: [PATCH v6 10/43] drm/drm_atomic_state_helper: Properly load
 default value for rotation
Date: Tue, 24 Nov 2026 15:11:59 +0100
Message-ID: <awWbIh471dkjKGII@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-10-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-10-78ace90f4fc1@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 06:58:52PM +0100, Louis Chauvet wrote:
> Currently, the default rotation is always DRM_MODE_ROTATE_0 for all planes.
> Some planes may have a rotation property, and the property may specify a
> different default value and supported values.
> 
> This is not an issue for "fixed" configurations, but with the introduction
> of VKMS configuration, some plane may only support 90° and 180°
> rotations, so the reset state of the plane was wrong (forced to 0°).
> 
> Fixes: ab2dd990f4ab ("drm: Add __drm_atomic_helper_crtc_state_reset() & co.")
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 267f44330629..13e848abb33c 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -32,6 +32,7 @@
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_framebuffer.h>
> +#include <drm/drm_mode_object.h>
>  #include <drm/drm_plane.h>
>  #include <drm/drm_print.h>
>  #include <drm/drm_vblank.h>
> @@ -231,6 +232,11 @@ void __drm_atomic_helper_plane_state_init(struct drm_plane_state *plane_state,
>  
>  	plane_state->plane = plane;
>  	plane_state->rotation = DRM_MODE_ROTATE_0;
> +	if (plane->rotation_property &&
> +	    !drm_object_property_get_default_value(&plane->base,
> +						   plane->rotation_property,
> +						   &val))
> +		plane_state->rotation = val;
>  
>  	plane_state->alpha = DRM_BLEND_ALPHA_OPAQUE;
>  
> 
> -- 
> 2.56.0
> 

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
