Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D0606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SWWXYpO9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F3110E804;
	Mon, 23 Nov 2026 15:58:34 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CA4D10E804
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:58:29 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4ad6219f7d8so2778638f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795449507; x=1796054307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=E7V1Mp8qcb2Pgn8vLfudKigHDe8jvtrjrih2NQ7mefs=;
 b=SWWXYpO9tVBLm05dEYXn4YUQwhhBJcuoAz+jdHgb+jyvEGJXAWe607rkY5Rj6Id0TG
 nuz6JoTcm+3qSFZp2JNSAGgO5WKvObG2rqfqBITQntAeuuN4wBa9iWSPjU59tRs8X5er
 4ZD3WB6h14KWOdtyQE5v+n1aK8k0T5sP8x0XD2BUbSMzUHzIEMKfPjo0BkrOwDziFRUt
 aOFPjh1maiNTHtiHJj+c6YqTQqkgV4F5jy8PgXF5mGa6bY3bP4dzSPJp0eyR5VlFicZ6
 jvDJkmy4kwzTOQsTT3S+ynCj0mwF6JUNBJw5B6Ggb5Iy1dDBUNQyi2BJfCd+jN5U/uEB
 QVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795449507; x=1796054307;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:references:in-reply-to:message-id:date:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E7V1Mp8qcb2Pgn8vLfudKigHDe8jvtrjrih2NQ7mefs=;
 b=JcLnQTvx3hUQ2iJqWexTR3DYAynHRqTJozYAShmCzKqDpKDZZNvRkwj93y0/RmkkQ5
 CV4Fz95hKqjoEsSMVJrupOfxq5fIcpCsEPej4NmaZ71XTey+Ol57zn+zXlHxt8kjYpTa
 yAjcj4dAiureBpqChCKR/W+kIljygfIhBX11k4yuxyENyaXwcMx+7ZMQ17qqjQltMkZu
 +LhtWTQTtkFi3hdr/suiJD0BbWdgGvtfmSZ7X13Rk65bfk6daQvjScP30ZSQnnRVGRux
 gNdd1RtuCWiooEVaKvOv1ckwZ6l5mO2J1dTbLnCKV4YyNDaQ1GjjUnu2m72rDni+OZZF
 jYHg==
X-Forwarded-Encrypted: i=1;
 AL+hErF3E0osmZlilnFTm7dhna3DbbcavhUeEXV0UnLRwpQ+pN9JB9bYLKKLnSLihj7D0JlJGTqFmS5onU8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+TWqMn3IvUJazth5MPhknSeAg7NLCVsShNVIT2lqnGnIYSn/Tr
 GO2iLMOSdqmYp1Qj+7+KhK0a65jjdxttbuQhyPbt0/ALGblTMknYKAql
X-Gm-Gg: AZFdTZfJqru9yzMD4e10+2CZzO2VQNQfzYcCmsjrZhERLzLQf/7WvpazhZHA8Ym8shK
 UG5HdsoULEyZTcno34dFuzR1/XAuaeMthNUsDmWueA+COnYIdKslMDhVkaECUbckJseqIoAXKdl
 krkHFHoYHIGHPcaKJ9veXRDlTPdLidarGiHfjdYLBvGwDgR3K5wNoNu/ZcOcFRJ176iH8nu9YQ6
 E65QZSed0hXdpjbOGXKsL4E6ZmpDIZw8cQylqMFou2qy2/pa/FqBoOsHAJtYg5It+Kc4RAnyb4v
 nUVLEeX/xgBBgOtoLzgEt7Vw93KmpDbe33WNmQ6AMBP8rvPKPoNqG7SgZ3bufaEA53+kg8Ti5SO
 MEKV9Vesassj4tEi8iujt6ELWAH73L6j1q0XH7airVUx/K03WUc7R2mmuZ/UFyWv/1QNT2GjKbv
 qizHw7+NlShCh8C2/KMXNnwWVHban4yp+fnkw85k5bDTfFkczgK8tJPzaVbPhnERTMMRYD9CEXc
 opynTz+qi2vXPY2Y+9EQfjhcLQek4GDo0d/i5x46V2QPACwSdqDJHX1vOobjpK+8v/gvgvHBJfm
 plko+LfHbuObcMEsYJhWI4Ksx972MGW1d9d0wSq45+bvicJutwVWlmE=
X-Received: by 2002:a05:600c:5307:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4bb888283d8mr232622925e9.17.1795449507258; 
 Mon, 23 Nov 2026 07:58:27 -0800 (PST)
Received: from ArchOarora ([2001:19f0:6c01:2c43:5400:5ff:fef6:1b30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906cdcc1sm175808205e9.2.2026.11.23.07.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 07:58:26 -0800 (PST)
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
Subject: Re: [PATCH v6 34/43] drm/vkms: Rename vkms_connector_init to
 vkms_connector_init_static
Date: Mon, 23 Nov 2026 16:58:05 +0100
Message-ID: <awRiOQv8H-nI8bpq@Oarora>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120-vkms-all-config-v6-34-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
 <20261120-vkms-all-config-v6-34-78ace90f4fc1@bootlin.com>
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

On Fri, Nov 20, 2026 at 06:59:16PM +0100, Louis Chauvet wrote:
> With the introduction of dynamic connectors we will have two way of
> initializing a VKMS connector. Rename the current function to clarify
> the case.
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> ---
>  drivers/gpu/drm/vkms/vkms_connector.c | 5 ++---
>  drivers/gpu/drm/vkms/vkms_connector.h | 6 +++---
>  drivers/gpu/drm/vkms/vkms_output.c    | 2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
> index f5e99e77e84f..64d79b778551 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.c
> +++ b/drivers/gpu/drm/vkms/vkms_connector.c
> @@ -75,9 +75,8 @@ static void vkms_connector_static_cfg_release(struct drm_device *dev, void *res)
>  	vkms_config_connector_put(connector->cfg);
>  }
>  
> -
> -struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
> -					   struct vkms_config_connector *connector_cfg)
> +struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
> +						  struct vkms_config_connector *connector_cfg)
>  {
>  	struct drm_device *dev = &vkmsdev->drm;
>  	struct vkms_connector *connector;
> diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
> index 89d7f3a15d6e..61a8dd55d7f7 100644
> --- a/drivers/gpu/drm/vkms/vkms_connector.h
> +++ b/drivers/gpu/drm/vkms/vkms_connector.h
> @@ -23,15 +23,15 @@ struct vkms_connector {
>  };
>  
>  /**
> - * vkms_connector_init() - Initialize a connector
> + * vkms_connector_init_static() - Initialize a connector
>   * @vkmsdev: VKMS device containing the connector
>   * @connector_cfg: Connector's configuration
>   *
>   * Returns:
>   * The connector or an error on failure.
>   */
> -struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
> -					   struct vkms_config_connector *connector_cfg);
> +struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
> +						  struct vkms_config_connector *connector_cfg);
>  
>  /**
>   * vkms_trigger_connector_hotplug() - Update the device's connectors status
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 7783a2f6d343..2b0f7a8a80b5 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -97,7 +97,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>  		struct vkms_config_encoder *possible_encoder;
>  		unsigned long idx = 0;
>  
> -		connector_cfg->connector = vkms_connector_init(vkmsdev, connector_cfg);
> +		connector_cfg->connector = vkms_connector_init_static(vkmsdev, connector_cfg);
>  		if (IS_ERR(connector_cfg->connector)) {
>  			DRM_ERROR("Failed to init connector\n");
>  			return PTR_ERR(connector_cfg->connector);
> 
> -- 
> 2.56.0
>

Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
