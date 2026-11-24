Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7039B606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JOU7hONV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DADE010E23A;
	Tue, 24 Nov 2026 13:52:52 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 079CD10E23A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:52:45 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6b894a5ce3dso6140932a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 05:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795528364; x=1796133164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HZKKQf4VXfezngqUfgj7MhmoCUm8tU6EzL5wE2W3U7c=;
 b=JOU7hONVRbFNXOukU+qrWZmepxxfEOwpFsiHh/EdU9dTx+1lkm1X6uocv20jztiQ1m
 6odiAEDz43LW1aWGv8xuf2CJ7KkVuROe28uT3zCx0dn+omkMGkLyz/cB5ZXCauLMASwK
 R0ak61rVWWYKwPCYFncUuyUIlsXfp+MJa/qO95Kz3PUzaL/icsOL8bnL2xHXOUFnmRXw
 1IhUj+fenbO+Xz85Y/7ZOk7/JCWB4bYyNWWfPhGyfcAQ2n8Nni41htmO6XoPPTxs+7VX
 dnjUJVtC7C53iOMy4RcBoMkyUA3hRHZMZL7rtjvZJG9KG4fyz2MPvyl1VzWMsyREbqzg
 VgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795528364; x=1796133164;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HZKKQf4VXfezngqUfgj7MhmoCUm8tU6EzL5wE2W3U7c=;
 b=zmWHNxhkvKbzHFr7LCwm4Ln57s771TZHbl866ysRxBQJLuq3f1p6xESMUK2FMh+pgA
 8R6lUvP6iUddboDOAUuqCOwujnbB21SO4P1XYguZjmBcVWrT3936jMQ7INV5jcynD7LD
 4WY+y6j/OPGPZ8aCF5NDDFjhJsEHTkHQw+mYv5n7Egvgpl2XRb6B3h+rU0wLuMxMecgu
 4H0Db2lZAFU7AXR1Kr3qJxPzxf38wY/nC+fSvXgC2I5uP7z1oFLxndV2T/ljj/dypGJv
 03eUtBPki/2H6q1LW7uC33OU3Dr0s/0gpbuEIjs3jrls5QcCuYBesiXjgLYbqCzSPqNt
 QDRA==
X-Forwarded-Encrypted: i=1;
 AL+hErFOvjRQMNqHnk2enYXkd0IOTpeb/rcOrhdeI7hvbt4vYEY6exJHCXYyAYA2lOd1Jjay6mKhnm4WKF8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9dGUptujQoldqxrxhbIesuNfNRHkwm14qvf5sbP0Y8K35XXaQI
 Zq7BpcIdrRX/Q0sS0s1qOnJCZkWshg+P+OSqWXJPvD6ynArdg8RZAhla
X-Gm-Gg: AZFdTZcQNchybghiELMvzgzJrUtZv5TGZAh5UYRcwsXsPnuQzFi8q+i5Gf++UfKe8MH
 b7/yHzxNfRg2mM5FDSO7GTh5OgWB4AyFfTNozUAq5253XKHT+ZloqiofsHTBIynPecE+Zuub9mp
 A5jzZCA3OjVvWkEWafZuUw9WMmMYoE8Z68wo86J9joLoVbKFAWWNSSPws/58wapwzv3wcO3f1va
 070UMUdvwzx/XdAVrK1IKTy3l+SDF9N8BUxWugCpwRVccpTVxV6frAPWmh1KC4XiscEYsWC9iNU
 izjbkBDD/a37VMXX2gkv/yv3CQsMKOEVER1SI36Gv5nLbdb0by6Oq+5OF98YobINvBYKe+dQ3fE
 Xb483WXmSHJQvruqcpIW2Q7OyZ7A/g5roChdF09wf7caBz2N0QoiBYmhzCD7qM4OFyXGciYa/9a
 fJndxg/G2QbX6M80RBq3doEJEntHR84LLhwb9XRT61LdEGYP+KHm5nRAOmreBw/p3kBKkCvRq/U
 kQfiHZKhBRHdhSXGdKCc3xnJD8U7qsvERskxHZwGjnxIggzuiCCzyvizVbNc75/7H20ryNru8Rs
 BhchHenUAqrnIXeVWyl5tLgzUYYfgrEZuEPwAiMq18uZ9XOyefi6
X-Received: by 2002:a05:6402:3222:b0:6b8:7e86:3e90 with SMTP id
 4fb4d7f45d1cf-6ba654bcff6mr8479709a12.38.1795528364057; 
 Tue, 24 Nov 2026 05:52:44 -0800 (PST)
Received: from ArchOarora ([95.179.249.152]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba37109b55sm6582079a12.32.2026.11.24.05.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:52:43 -0800 (PST)
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
Subject: Re: [PATCH v6 07/43] drm/drm_color_mgmt: Expose
 drm_get_color_encoding_name
Date: Tue, 24 Nov 2026 14:52:28 +0100
Message-ID: <awWVztVSyL8uOIzt@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-7-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-7-78ace90f4fc1@bootlin.com>
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

On Fri, Nov 20, 2026 at 06:58:49PM +0100, Louis Chauvet wrote:
> drm_get_color_encoding_name can be useful to display debug information
> outside drm core. Export it so it could be used for VKMS
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/drm_color_mgmt.c    | 2 +-
>  drivers/gpu/drm/drm_crtc_internal.h | 2 --
>  include/drm/drm_color_mgmt.h        | 2 ++
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
> index e4e31bc0153e..de219c23322f 100644
> --- a/drivers/gpu/drm/drm_color_mgmt.c
> +++ b/drivers/gpu/drm/drm_color_mgmt.c
> @@ -496,7 +496,7 @@ const char *drm_get_color_encoding_name(enum drm_color_encoding encoding)
>  
>  	return color_encoding_name[encoding];
>  }
> -EXPORT_SYMBOL_IF_KUNIT(drm_get_color_encoding_name);
> +EXPORT_SYMBOL(drm_get_color_encoding_name);
>  
>  /**
>   * drm_get_color_range_name - return a string for color range
> diff --git a/drivers/gpu/drm/drm_crtc_internal.h b/drivers/gpu/drm/drm_crtc_internal.h
> index 3492787c3697..f3a3ffd358dc 100644
> --- a/drivers/gpu/drm/drm_crtc_internal.h
> +++ b/drivers/gpu/drm/drm_crtc_internal.h
> @@ -38,7 +38,6 @@
>  #include <linux/err.h>
>  #include <linux/types.h>
>  
> -enum drm_color_encoding;
>  enum drm_color_range;
>  enum drm_connector_force;
>  enum drm_mode_status;
> @@ -121,7 +120,6 @@ int drm_mode_destroy_dumb_ioctl(struct drm_device *dev,
>  				void *data, struct drm_file *file_priv);
>  
>  /* drm_color_mgmt.c */
> -const char *drm_get_color_encoding_name(enum drm_color_encoding encoding);
>  const char *drm_get_color_range_name(enum drm_color_range range);
>  
>  /* IOCTLs */
> diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
> index 5140691f476a..133ca77d91c7 100644
> --- a/include/drm/drm_color_mgmt.h
> +++ b/include/drm/drm_color_mgmt.h
> @@ -113,6 +113,8 @@ enum drm_color_range {
>  	DRM_COLOR_RANGE_MAX,
>  };
>  
> +const char *drm_get_color_encoding_name(enum drm_color_encoding encoding);
> +
>  int drm_plane_create_color_properties(struct drm_plane *plane,
>  				      u32 supported_encodings,
>  				      u32 supported_ranges,
> 
> -- 
> 2.56.0

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
