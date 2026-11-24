Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AA6606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N5cKNniJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E2910E84A;
	Tue, 24 Nov 2026 10:48:59 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ACE910E84A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:48:53 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so42539335e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 02:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795517332; x=1796122132; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BQWm+RaJP4cvkyTJMqTUs+AJFoZOLPdvH4gKpxS4kaE=;
 b=N5cKNniJh8M2xrfnr8gal9b/ahsiYQdAhyMNNJMi9qfEZOsvgO/wuZ0KAGOnI/5nvb
 7TiuehjpHw5Y+1to4hQFIKBMohYSufzFR/l7q3HnF3bFUro7tR6WHab+1bwMt0/IjqId
 hNuFd5776n/nC0KBbCqUTEwKUmwkxvCB0RJV2g6/gODcy6Pf5XIe/j40XSVkkuvGVLMI
 KlTa4Uon5L9FLSFfVtAZBuWe0T1N0JD0cDXCdCv5cW3wK822XylYkPpmwuAYS1QjsW1H
 cjpMn9UGN/++HNLoDAUUq9YYeI2TjqKbmlMa5megUgm7eLNzMrKudXjFp47lc6qAiSSM
 VhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795517332; x=1796122132;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BQWm+RaJP4cvkyTJMqTUs+AJFoZOLPdvH4gKpxS4kaE=;
 b=BFe+J0k0eFztZUCCWUakPQGGfGkgKzJS9FG9/Kj/t4urcITy77CB7WhqicYucbzFB6
 RcUSdZgUHg44g94AT5PcmrftDRileLzJAV3q/SscoDXHksFPnGywQDnQGlLHNgJTFmCo
 piTF52mwbYqFCBoyiAPcGTINXBvVDBJPTJoO0IfGOTyJxq735aCKBlnhfKEntixiGLYT
 JVz55yUQLyEe3vXBMZSbw94nS/z9UKH9UzaL8glIQYjUofAbtEjnVXit/fR5IfnEkK2F
 hVC5lJu6hgHQZCZdmkFBTPa8JHtTkGvelVydYRFoEATiXsaTj7ZR3xLUDp7Gba98IRdf
 wcOg==
X-Forwarded-Encrypted: i=1;
 AL+hErGvpptl35/s97KfSer/qwFg/CWFjJbosWA2KvuImoRSegVO1soDbqlLrdcwWbfo90kRXKTMztPyqaw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9HL33mYsIRB493579ORo1CVtIKLE9jcU1qoREXSOe991drhb2c
 QF56Laqmsebg0yfFPI6jlDQHC5gfOMUum+PkNsLpA8leCKSue8MyzzzR
X-Gm-Gg: AZFdTZfEvVjRx9iyzNA96MCnq04D05pBzvGZCPK0gpgcSmwWX+sEB0tJd0DqVnca8Cx
 1487hWpFGAZaGVuuKYk01AcYMjYFOMRPJMGES9IYj8fIaqOpUOFuB5PATrDy/fuVij+8ms4E3Yr
 22EA2PjC6lCWgHekDlKA5pSH8wgdo7efwuQslyL2twQj1NwLOhDIInv7Y+JPw3TJwAsv3s+BEhE
 eNBrFt9N5pjEDnHG1I0/LJ4mqX8HmK/9JP4VZw09h+pyjqQL9uTZZjGNjDzRfwYfOYW6dTxVGNy
 4hSracp8Hb8oan8YDgZvmIU8qvPv068WsAPSEilENc8wzzZswN5QKbWdZKdOGFfqrWSdGl7NK1O
 sdWhgintCD1emZmLS3Rp98QIiVsPyePy0BD/3rWEoSzoaQ2icInnJyWOl1QYa9rjKql+X2ZYifx
 FMkVYxEIE2JB4bIQ+zyNUEN76Laiam4QBuBzfKySQxmas+pI3ePObRg2UxiuBo4EJ2qejKiOe0n
 Dnu/BiWxbRPi1m7UWy/5xl/vJhZNA5N30vI63sb8qjZckAwsFoqW0Qs88EGlTfGtuovtmxEbd1r
 kAYtq7wCWOvQDtKfQQmj8YP90uXgwLQM4Q==
X-Received: by 2002:a05:600c:4f4e:b0:4bb:6c71:b268 with SMTP id
 5b1f17b1804b1-4bb8882672fmr303322955e9.6.1795517331573; 
 Tue, 24 Nov 2026 02:48:51 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884b7515sm585521185e9.13.2026.11.24.02.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 02:48:49 -0800 (PST)
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
Subject: Re: [PATCH v6 05/43] drm/blend: Get a rotation name from its bitfield
Date: Tue, 24 Nov 2026 11:48:33 +0100
Message-ID: <awVrWZkluWav6Jg9@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-5-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-5-78ace90f4fc1@bootlin.com>
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

On Fri, Nov 20, 2026 at 06:58:47PM +0100, Louis Chauvet wrote:
> Extract the rotation/reflection name table and expose the
> DRM_ROTATION_FMT()/DRM_ROTATION_FMT_ARGS() helpers to print a
> human-readable rotation mask.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/drm_blend.c | 19 ++++++++++---------
>  include/drm/drm_blend.h     | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index d17ae964fb21..b62f1db9c311 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -256,6 +256,15 @@ int drm_plane_create_alpha_property(struct drm_plane *plane)
>  }
>  EXPORT_SYMBOL(drm_plane_create_alpha_property);
>  
> +static const struct drm_prop_enum_list rotation_props[] = {
> +	{ __builtin_ffs(DRM_MODE_ROTATE_0) - 1,   "rotate-0" },
> +	{ __builtin_ffs(DRM_MODE_ROTATE_90) - 1,  "rotate-90" },
> +	{ __builtin_ffs(DRM_MODE_ROTATE_180) - 1, "rotate-180" },
> +	{ __builtin_ffs(DRM_MODE_ROTATE_270) - 1, "rotate-270" },
> +	{ __builtin_ffs(DRM_MODE_REFLECT_X) - 1,  "reflect-x" },
> +	{ __builtin_ffs(DRM_MODE_REFLECT_Y) - 1,  "reflect-y" },
> +};
> +
>  /**
>   * drm_plane_create_rotation_property - create a new rotation property
>   * @plane: drm plane
> @@ -294,14 +303,6 @@ int drm_plane_create_rotation_property(struct drm_plane *plane,
>  				       unsigned int rotation,
>  				       unsigned int supported_rotations)
>  {
> -	static const struct drm_prop_enum_list props[] = {
> -		{ __builtin_ffs(DRM_MODE_ROTATE_0) - 1,   "rotate-0" },
> -		{ __builtin_ffs(DRM_MODE_ROTATE_90) - 1,  "rotate-90" },
> -		{ __builtin_ffs(DRM_MODE_ROTATE_180) - 1, "rotate-180" },
> -		{ __builtin_ffs(DRM_MODE_ROTATE_270) - 1, "rotate-270" },
> -		{ __builtin_ffs(DRM_MODE_REFLECT_X) - 1,  "reflect-x" },
> -		{ __builtin_ffs(DRM_MODE_REFLECT_Y) - 1,  "reflect-y" },
> -	};
>  	struct drm_property *prop;
>  
>  	WARN_ON((supported_rotations & DRM_MODE_ROTATE_MASK) == 0);
> @@ -309,7 +310,7 @@ int drm_plane_create_rotation_property(struct drm_plane *plane,
>  	WARN_ON(rotation & ~supported_rotations);
>  
>  	prop = drm_property_create_bitmask(plane->dev, 0, "rotation",
> -					   props, ARRAY_SIZE(props),
> +					   rotation_props, ARRAY_SIZE(rotation_props),
>  					   supported_rotations);
>  	if (!prop)
>  		return -ENOMEM;
> diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
> index bebbb77a8f21..f000b10a16e7 100644
> --- a/include/drm/drm_blend.h
> +++ b/include/drm/drm_blend.h
> @@ -43,6 +43,40 @@ static inline bool drm_rotation_90_or_270(unsigned int rotation)
>  
>  #define DRM_BLEND_ALPHA_OPAQUE		0xffff
>  
> +/**
> + * DRM_ROTATION_FMT - printf format string describing a rotation bitmask
> + *
> + * To be used together with DRM_ROTATION_FMT_ARGS(), e.g.:
> + *
> + *	seq_printf(m, "rotation=" DRM_ROTATION_FMT "\n",
> + *		   DRM_ROTATION_FMT_ARGS(state->rotation));
> + *
> + * The result names every set bit, separated by single spaces, and ends
> + * with the raw value in parentheses, e.g.:
> + *
> + *	rotate-90 reflect-x (0x00000012)
> + *
> + * The trailing raw value ensures the output is never empty and never
> + * ends with a space, even when no bit is set.
> + */
> +#define DRM_ROTATION_FMT "%s%s%s%s%s%s(0x%08x)"
> +
> +/**
> + * DRM_ROTATION_FMT_ARGS - printf arguments for DRM_ROTATION_FMT
> + * @rot: rotation bitmask (DRM_MODE_ROTATE_* | DRM_MODE_REFLECT_*)
> + *
> + * Evaluates @rot several times: only pass a variable or an expression
> + * without side effects.
> + */
> +#define DRM_ROTATION_FMT_ARGS(rot) \
> +	((rot) & DRM_MODE_ROTATE_0)   ? "rotate-0 "   : "", \
> +	((rot) & DRM_MODE_ROTATE_90)  ? "rotate-90 "  : "", \
> +	((rot) & DRM_MODE_ROTATE_180) ? "rotate-180 " : "", \
> +	((rot) & DRM_MODE_ROTATE_270) ? "rotate-270 " : "", \
> +	((rot) & DRM_MODE_REFLECT_X)  ? "reflect-x "  : "", \
> +	((rot) & DRM_MODE_REFLECT_Y)  ? "reflect-y "  : "", \
> +	(rot)
> +
>  int drm_plane_create_alpha_property(struct drm_plane *plane);
>  int drm_plane_create_rotation_property(struct drm_plane *plane,
>  				       unsigned int rotation,
> 
> -- 
> 2.56.0
>

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
