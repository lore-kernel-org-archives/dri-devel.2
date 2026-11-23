Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB9D606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=piM12w8/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DF510E541;
	Mon, 23 Nov 2026 16:12:38 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B66410E541
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:12:31 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4bb666304fdso39961875e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795450350; x=1796055150; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q8nYEbLZ2llq6j+JAuDJiblDLINgvbNEzxuytFyLiig=;
 b=piM12w8/R3xKlKs7MWUNMOZV8eZt1FC6L4X1BwL0YRHN3Cc6BAzFIXyKR6v+TaGc7l
 KQIuXJF+tNxqCzTencd34u/0OZuCJ2QnGSbJTpU9RSdgudOGLGHWGBrfgZ/axKX66uQq
 C8tYXEoberakHli9A75vS7Ikubt2NqGLZ4tEsNG6R8/R4hWy2xJ6XTJiv7vmvPZYLffn
 FWm6HsCbhNaRKI3MnaurqnEGTzA40269agiTGMCeQWDBPmF3dxZXGo4CsAkBmxX7lMiv
 7YgvVxP6Twr2QGpW2Ts3hEOZ7qgP5uAKKdTHGj+RJWtxpADptSOHHId1j/Q7t484L750
 RAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795450350; x=1796055150;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q8nYEbLZ2llq6j+JAuDJiblDLINgvbNEzxuytFyLiig=;
 b=vXOIaCISRA2ekxhoXGojxXwxftlU5e6uwvTiAEv+mPF84/0Vwwdm3g7+/CNqM/qGm6
 QizFcrXmLX4stz7BSSMOmN4f5ZwhPhox43k9SbIIWpIfsIYzG9FgHEkLek+GXN+FksUg
 NgmmYfjqj4cE/vR79HflB3c866T5jcI2MogJYn6b5T97YIMRnnPTr28E6fFue0J5+kfB
 b7sx4S/2feHMpcCQHPofIcO2Q8MpOk3vccV4Vo5k+YYXYSLcC+EAe0HdRHH8WuxbwJeU
 aXl6uRuoC6TQlz9JZNX3q1hZQNWGd0dQUs4rBPEmyOlVBgF7JNSbE/3mme8ZyQO373J4
 TMow==
X-Forwarded-Encrypted: i=1;
 AL+hErGf546zsS1K57M7Z7yroMF22zoAOWb4H775IeDDtMVrFBnZ37P85wuiFGh2vgoGtkRKsDIV77bXOu8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8syixKWtv4D47lLRqYxp2jnqpcT5DYfibrhl1K9+8OXFX01tXg
 dMDshay/GIe9KM2avjSWChYphJI2cyYwucCZQrhBDepAuOzwaZ4LcLSxV3yNvnrswqxy1g==
X-Gm-Gg: AZFdTZfmbLUW1Ae/+EwD6ugeAKVZd9JBBg7UTxSYdkgZg5UmIfYMEMRShY6VkdiMVih
 uQAXfwORVbcaP8MwfbJmr2J5UxSJknJigAOgTRUh2Bn0lBHYyEPifCjbZrYXLY0n0r+rIIL9jMw
 6aI0qSCHwJkXutdhwf5szmK8CV4KRduNaAtK0H5w0BvmhU1FEg+ZGeqx4/7ysSeq4HLaEAIW7M9
 TEEdRw6mVZgkdQkjTIs0K/QxrQSLMHVnNrH497MPuxlXPKb7Z7GDhHc11vHVS5Sq+plkslQT18Q
 gdc5rQWdY+UzHsHULzSjpC5vq6xrwlMwStbYVsZJRFSm/57CO848PbNXPuzwQLUr6ykJhhwPaCS
 8pbEJwuc7URp88vjeKZim+P/Bge/xc9v9QM1Q2IuztWfV0PJ8i+YxxnqtNuGge7T4eYC6dW82dp
 jIb1QEtf0nz/zHo/PFQA+LMZihybMS4lyziYOLE+JMqza2fMdBOEwkosF6tUaNQhKtZebCQ4Xd5
 dA7R0PUq60xeTZ+nt/o+NNu2kz46Fzpazof+/+zN5m7wl4adtNB+BD3fw0kwfaGVaMf65flPtY3
 IWxfby6qrIVpEgKxQ1/sdg/dO3Jljp1cZQ==
X-Received: by 2002:a05:600c:848a:b0:4a2:1960:6fa with SMTP id
 5b1f17b1804b1-4bb887fb678mr237295105e9.4.1795450350202; 
 Mon, 23 Nov 2026 08:12:30 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9066e34esm201819645e9.3.2026.11.23.08.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 08:12:29 -0800 (PST)
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
Subject: Re: [PATCH v6 32/43] drm/vkms: Introduce connector type
Date: Mon, 23 Nov 2026 17:12:08 +0100
Message-ID: <awRlnGwi30MkhfyZ@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-32-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-32-78ace90f4fc1@bootlin.com>
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

On Fri, Nov 20, 2026 at 06:59:14PM +0100, Louis Chauvet wrote:
> In order to emulate connector-specific behavior, add the connector type
> to the connector configuration.
> 
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/tests/vkms_config_test.c |  5 +++++
>  drivers/gpu/drm/vkms/vkms_config.c            |  3 +++
>  drivers/gpu/drm/vkms/vkms_config.h            | 24 ++++++++++++++++++++++++
>  drivers/gpu/drm/vkms/vkms_connector.c         |  2 +-
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> index a43dff511fc3..257ba0342034 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> @@ -137,6 +137,7 @@ static void vkms_config_test_default_config(struct kunit *test)
>  	struct vkms_config *config;
>  	struct vkms_config_plane *plane_cfg;
>  	struct vkms_config_crtc *crtc_cfg;
> +	struct vkms_config_connector *connector_cfg;
>  	int n_primaries = 0;
>  	int n_cursors = 0;
>  	int n_overlays = 0;
> @@ -211,6 +212,10 @@ static void vkms_config_test_default_config(struct kunit *test)
>  
>  	/* Connectors */
>  	KUNIT_EXPECT_EQ(test, vkms_config_get_num_connectors(config), 1);
> +	vkms_config_for_each_connector(config, connector_cfg) {
> +		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_type(connector_cfg),
> +				DRM_MODE_CONNECTOR_VIRTUAL);
> +	}
>  
>  	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 963e32d5adf7..291c0330bc56 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -651,6 +651,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
>  		seq_printf(m, "\tstatus=%s\n",
>  			   drm_get_connector_status_name(
>  				   vkms_config_connector_get_status(connector_cfg)));
> +		seq_printf(m, "\ttype=%s\n",
> +			   drm_get_connector_type_name(vkms_config_connector_get_type(connector_cfg)));
>  	}
>  
>  	return 0;
> @@ -984,6 +986,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
>  
>  	connector_cfg->config = config;
>  	connector_cfg->status = connector_status_connected;
> +	vkms_config_connector_set_type(connector_cfg, DRM_MODE_CONNECTOR_VIRTUAL);
>  	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
>  	kref_init(&connector_cfg->refcnt);
>  
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 9d0a0087c9da..88429e01089b 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -138,6 +138,7 @@ struct vkms_config_encoder {
>   * struct vkms_config_connector
>   *
>   * @link: Link to the others connector in vkms_config
> + * @type: Store the type of connector using DRM_MODE_CONNECTOR_* values
>   * @config: The vkms_config this connector belongs to
>   * @status: Status (connected, disconnected...) of the connector
>   * @possible_encoders: Array of encoders that can be used with this connector
> @@ -150,6 +151,7 @@ struct vkms_config_connector {
>  	struct list_head link;
>  	struct vkms_config *config;
>  
> +	int type;
>  	enum drm_connector_status status;
>  	struct xarray possible_encoders;
>  
> @@ -371,6 +373,28 @@ vkms_config_plane_set_default_pipeline(struct vkms_config_plane *plane_cfg,
>  }
>  
>  /**
> + * vkms_config_connector_get_type() - Return the connector type
> + * @connector_cfg: Connector to get the type from
> + */
> +static inline int
> +vkms_config_connector_get_type(const struct vkms_config_connector *connector_cfg)
> +{
> +	return connector_cfg->type;
> +}
> +
> +/**
> + * vkms_config_connector_set_type() - Set the connector type
> + * @connector_cfg: Connector to set the type to
> + * @type: New connector type
> + */
> +static inline void
> +vkms_config_connector_set_type(struct vkms_config_connector *connector_cfg,
> +			       int type)
> +{
> +	connector_cfg->type = type;
> +}
> +
> +/*
>   * vkms_config_plane_get_default_rotation() - Get the default rotation for a plane
>   * @plane_cfg: Plane to get the default rotation from
>   *
> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
> index 11e313440225..f5e99e77e84f 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -88,7 +88,7 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
>  		return ERR_PTR(-ENOMEM);
>  
>  	ret = drmm_connector_init(dev, &connector->base, &vkms_connector_funcs,
> -				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
> +				  vkms_config_connector_get_type(connector_cfg), NULL);
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> 
> -- 
> 2.56.0
>

Reviewed-by Oarora Etimis <oaroraetimis@gmail.com>
