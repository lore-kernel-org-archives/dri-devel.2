Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E115606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=O1eRNzIu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 476AA10F37D;
	Tue, 24 Nov 2026 09:28:46 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84CAE10F37D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 09:28:39 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so54741545e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 01:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795512518; x=1796117318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CzKgPvM79v6jsfljA7yM9iAbIcPsktxf49AuQD8Felg=;
 b=O1eRNzIuewecGSlhbnwx5zlftyMN/4GSfoKjO4UWgngR6+ka62AUwZBtGLZLp9AUdo
 zyiLqwLFCaNKdR6Q1/fY2cG9De+KkfOd2Mo+Zdy860eC1PgfHu7JJ8/JBKizidVYCMQ7
 3V5/Jj6+uuwpDAGjz9FtgoTTqg9DNERHPXxMFk+F+Lv3nAqryaU9D9nlV+/m18B9iUlj
 efoIn3tx/Ck0y/VyFIArEm88bYt+zAsVR64mmYWk25TNTUzbGsqxknqwXmvDKTMxlPfG
 umg5jRhKiXrb84cO/fr9fubOntH2q7BFwbQosUwCaMP4t22fleCbm9wF6QVUzkf4jiYd
 mqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795512518; x=1796117318;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CzKgPvM79v6jsfljA7yM9iAbIcPsktxf49AuQD8Felg=;
 b=benGC3m46kDls7tSRMZ+BAWe1pyyFPMW9qvCTPjNp4R9UkuXqoIejrKZd8CoiXMBay
 xGD1TzvXhaSl+uSadrLHiYsUYOXk199mBGL8Y8xBQggl+D98SSyhNp12jjj2Z9JELxuD
 Xc8a806LSfA6ni5y/YNAxCE2MWGqZiQGdaai8FTEpHKo79QhBFpPJpbSb36gqY3dra0Z
 NSoFNeQOZv52L6FsDGg0U3Qs5G3byxTfWbX0Xxj9MD1Rwq2cqHB1XDw6c7kceucXsMZn
 2tHPcZ7TUfmHb0v21HDYLAavTnKMl+Y5LUiRI18VTlCD99SjKjUY4wnIimesKa0JtW7e
 UrkQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHUnivCDO7CC8nHrYa5vRZV6WIbBLO5cuvgVi37Ld8hHrHPLEP2j1PdERHxmel5k/C99n36GvpuC7Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+jpfslUY0ZNO1JveISZzvfFGR+MTxgQB3gnzopUi2O6y1mB7Pz
 Z0MIkG7o7lecAjbil/CIVCNzee1Me7Rr/CbKFlqlFakIZfHt5ggLFfjZ
X-Gm-Gg: AZFdTZdzFM/JFASztaiIh8UT1vG+mld/DQHDAHvND32WruPlyZvAqLlDFJG7/8/qxfi
 fV7nTTktnY/KcvY9shSBdPFUIShH5yALNmeMY5sm219nyJyYrDswQlhi2scr5NJqiPmgNSd1//W
 L/MoeJAsAltmVJbTQSr6OhPNYrElRw7OB0t3uaw+cq34Q6/YfzvqRzx5MW3+ZT/lEk2PGApYgw3
 AivHEecbXB5IV5IhuQxsl4J3UlLvviPMaME2I1EKsu9OGuFYFVQa8a92uRsUB5+7qX294mIXHVl
 ID1wd+hbgth86uULWdpEujzcwyNMrKP3ZsssP6WlDKrFLRCZhkeMWpm93ePmVhwLKqr1ef0nv3k
 VWb7e17hhKjZ36b9BdIdw/ILMlRUmjG7tqu+rqOHVH/tMXXWhJ52DXWrgvG505hqCgI/FU4ngWy
 4UcwgWL/yl8cG+vFVsSaMdCGLDtfqamfb+M/bUeI1xJG5NB2T7rYXjLRn9DQF41NHO5Et5OzUzp
 Zd2VrWxzPSVxEVdEhR3LGbXPC4VM1mtU+XXRcRoAzYiCC7CXktT58qEd+0YKp8rmwY2L5Px7mGG
 SL5QFmdfh8iUD4atIc7xarQ1P29+4Koccw==
X-Received: by 2002:a05:600c:6749:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb8881099cmr275531005e9.12.1795512517667; 
 Tue, 24 Nov 2026 01:28:37 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf61e8sm28275775f8f.11.2026.11.24.01.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:28:36 -0800 (PST)
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
 llvm@lists.linux.dev,
 =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito@redhat.com>
Subject: Re: [PATCH v6 04/43] drm/drm_mode_config: Add helper to get plane
 type name
Date: Tue, 24 Nov 2026 10:28:20 +0100
Message-ID: <awVWbUPDh_7UHoay@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-4-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-4-78ace90f4fc1@bootlin.com>
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

On Fri, Nov 20, 2026 at 06:58:46PM +0100, Louis Chauvet wrote:
> Create and export a helper to display plane type using the property
> string. This could be used to display debug information in VKMS.
> 
> Reviewed-by: José Expósito <jose.exposito@redhat.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/drm_mode_config.c | 16 ++++++++++++++++
>  include/drm/drm_mode_config.h     |  3 +++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index c1e993a78702..0d814424c698 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -419,6 +419,22 @@ static const struct drm_prop_enum_list drm_plane_type_enum_list[] = {
>  	{ DRM_PLANE_TYPE_CURSOR, "Cursor" },
>  };
>  
> +/**
> + * drm_get_plane_type_name - return a string for plane type name
> + * @type: plane type to compute name of
> + *
> + * Returns: The name of the plane type. "(unknown)" if type is not a known
> + * plane type.
> + */
> +const char *drm_get_plane_type_name(enum drm_plane_type type)
> +{
> +	if (type >= 0 && type < ARRAY_SIZE(drm_plane_type_enum_list))
> +		return drm_plane_type_enum_list[type].name;
> +	else
> +		return "(unknown)";
> +}
> +EXPORT_SYMBOL(drm_get_plane_type_name);
> +
>  static int drm_mode_create_standard_properties(struct drm_device *dev)
>  {
>  	struct drm_property *prop;
> diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
> index 084517beb924..545a5b684acc 100644
> --- a/include/drm/drm_mode_config.h
> +++ b/include/drm/drm_mode_config.h
> @@ -30,6 +30,7 @@
>  #include <linux/llist.h>
>  
>  #include <drm/drm_modeset_lock.h>
> +#include <drm/drm_plane.h>
>  
>  struct drm_file;
>  struct drm_device;
> @@ -1011,4 +1012,6 @@ int drm_mode_config_create_initial_state(struct drm_device *dev);
>  void drm_mode_config_reset(struct drm_device *dev);
>  void drm_mode_config_cleanup(struct drm_device *dev);
>  
> +const char *drm_get_plane_type_name(enum drm_plane_type type);
> +
>  #endif
> 
> -- 
> 2.56.0
>

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
