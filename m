Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1869A606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=QELhkOKf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D15510E5D3;
	Tue, 17 Nov 2026 14:04:41 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBAED10E5D3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 14:02:39 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id BA1421A162D;
 Tue, 17 Nov 2026 14:02:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 7EBC75FC81;
 Tue, 17 Nov 2026 14:02:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B5C5C11BC0026; Tue, 17 Nov 2026 15:02:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1794924154; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=b04uqxVDpz8zEbV+fF30g6nJC0Jr18R4LW3IW7YULo4=;
 b=QELhkOKfXX1Gqrl+qpI1IL9xiHqLyRWue2LR5252YbNJgsRXa3ObMYeKely38VyTFi+jHK
 yHUn9G6xDAbHxtAvCGHAGJHb9dtMBj2b2eMncpbs64NaVr7rzrS0dd04j1XZa4gXg/RzhB
 YrRV7RUfUJwtHvoEKB1x+NxcFM1dPzR13+tE7XrCdDeFei2VtL8RMHr5D141NNwzdFHtIU
 oxoMk+gwxi+peG0RMQ1ATC481Zcp87Ud10cVzjCIcneIiRf8lG25GSw5dl+1BS6bmLTiaz
 4naqOINCK/l56AbLPt4lLLkgIIEBKLOvqAcOMA1aJfx2gDen974Nj0Ym9zgp2A==
Message-ID: <15c2236a-cd41-4f8d-b6ee-bb56f98f9916@bootlin.com>
Date: Tue, 17 Nov 2026 15:02:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] drm: writeback: rename
 drm_writeback_connector_init_with_encoder()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Harrison <John.Harrison@igalia.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
References: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
 <20261111-wb-drop-encoder-v8-6-62948ed87d13@oss.qualcomm.com>
From: Louis Chauvet <louis.chauvet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261111-wb-drop-encoder-v8-6-62948ed87d13@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/26 01:42, Dmitry Baryshkov wrote:
> Rename drm_writeback_connector_init_with_encoder() to
> drm_writeback_connector_init() and adapt its interface to follow
> drmm_writeback_connector_init(). Drop references to the "custom encoder"
> from the documentation since it's now the only way to specify the
> encoder to the writeback connector.
> 
> Reviewed-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c    | 10 +++++-----
>   .../drm/arm/display/komeda/komeda_wb_connector.c    |  8 ++++----
>   drivers/gpu/drm/arm/malidp_mw.c                     |  8 ++++----
>   drivers/gpu/drm/drm_writeback.c                     | 21 +++++++++------------
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c | 10 +++++-----
>   drivers/gpu/drm/vc4/vc4_txp.c                       |  8 ++++----
>   include/drm/drm_writeback.h                         | 10 +++++-----
>   7 files changed, 36 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index e0ef23f692d4..dde02b2b018b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> @@ -262,11 +262,11 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
>   
>   	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
>   
> -	res = drm_writeback_connector_init_with_encoder(&dm->adev->ddev, &wbcon->base,
> -							&wbcon->encoder,
> -							&amdgpu_dm_wb_connector_funcs,
> -							amdgpu_dm_wb_formats,
> -							ARRAY_SIZE(amdgpu_dm_wb_formats));
> +	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
> +					   &amdgpu_dm_wb_connector_funcs,
> +					   &wbcon->encoder,
> +					   amdgpu_dm_wb_formats,
> +					   ARRAY_SIZE(amdgpu_dm_wb_formats));
>   	if (res) {
>   		drm_encoder_cleanup(&wbcon->encoder);
>   		return res;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index 7b795e1c5705..ea4589b00ee0 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -186,10 +186,10 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>   		return err;
>   	}
>   
> -	err = drm_writeback_connector_init_with_encoder(&kms->base, wb_conn,
> -							wb_encoder,
> -							&komeda_wb_connector_funcs,
> -							formats, n_formats);
> +	err = drm_writeback_connector_init(&kms->base, wb_conn,
> +					   &komeda_wb_connector_funcs,
> +					   wb_encoder,
> +					   formats, n_formats);
>   	komeda_put_fourcc_list(formats);
>   	if (err) {
>   		drm_encoder_cleanup(wb_encoder);
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index 889d0d1db85d..3669d10540bf 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -239,10 +239,10 @@ int malidp_mw_connector_init(struct drm_device *drm)
>   		return ret;
>   	}
>   
> -	ret = drm_writeback_connector_init_with_encoder(drm, &malidp->mw_connector,
> -							&malidp->mw_encoder,
> -							&malidp_mw_connector_funcs,
> -							formats, n_formats);
> +	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
> +					   &malidp_mw_connector_funcs,
> +					   &malidp->mw_encoder,
> +					   formats, n_formats);
>   	kfree(formats);
>   	if (ret) {
>   		drm_encoder_cleanup(&malidp->mw_encoder);
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index 683da368e339..89c36f1414ce 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -165,8 +165,7 @@ static void delete_writeback_properties(struct drm_device *dev)
>   }
>   
>   /**
> - * __drm_writeback_connector_init - Initialize a writeback connector with
> - * a custom encoder
> + * __drm_writeback_connector_init - Initialize a writeback connector
>    *
>    * @dev: DRM device
>    * @wb_connector: Writeback connector to initialize
> @@ -241,8 +240,7 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>   }
>   
>   /**
> - * drm_writeback_connector_init_with_encoder - Initialize a writeback connector with
> - * a custom encoder
> + * drm_writeback_connector_init - Initialize a writeback connector
>    *
>    * @dev: DRM device
>    * @wb_connector: Writeback connector to initialize
> @@ -269,11 +267,11 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>    *
>    * Returns: 0 on success, or a negative error code
>    */
> -int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
> -					      struct drm_writeback_connector *wb_connector,
> -					      struct drm_encoder *enc,
> -					      const struct drm_connector_funcs *con_funcs,
> -					      const u32 *formats, int n_formats)
> +int drm_writeback_connector_init(struct drm_device *dev,
> +				 struct drm_writeback_connector *wb_connector,
> +				 const struct drm_connector_funcs *con_funcs,
> +				 struct drm_encoder *enc,
> +				 const u32 *formats, int n_formats)
>   {
>   	struct drm_connector *connector = &wb_connector->base;
>   	int ret;
> @@ -290,7 +288,7 @@ int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
>   
>   	return ret;
>   }
> -EXPORT_SYMBOL(drm_writeback_connector_init_with_encoder);
> +EXPORT_SYMBOL(drm_writeback_connector_init);
>   
>   /**
>    * drm_writeback_connector_cleanup - Cleanup the writeback connector
> @@ -320,8 +318,7 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
>   }
>   
>   /**
> - * drmm_writeback_connector_init - Initialize a writeback connector with
> - * a custom encoder
> + * drmm_writeback_connector_init - Initialize a writeback connector
>    *
>    * @dev: DRM device
>    * @wb_connector: Writeback connector to initialize
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index a1271fec9874..a88408124758 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -217,11 +217,11 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
>   	drm_connector_helper_add(&wb_conn->base,
>   				 &rcar_du_wb_conn_helper_funcs);
>   
> -	ret = drm_writeback_connector_init_with_encoder(&rcdu->ddev, wb_conn,
> -							encoder,
> -							&rcar_du_wb_conn_funcs,
> -							writeback_formats,
> -							ARRAY_SIZE(writeback_formats));
> +	ret = drm_writeback_connector_init(&rcdu->ddev, wb_conn,
> +					   &rcar_du_wb_conn_funcs,
> +					   encoder,
> +					   writeback_formats,
> +					   ARRAY_SIZE(writeback_formats));
>   	if (ret)
>   		drm_encoder_cleanup(encoder);
>   
> diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
> index 642953cba25f..6ffc54d23d48 100644
> --- a/drivers/gpu/drm/vc4/vc4_txp.c
> +++ b/drivers/gpu/drm/vc4/vc4_txp.c
> @@ -601,10 +601,10 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
>   
>   	drm_connector_helper_add(&txp->connector.base,
>   				 &vc4_txp_connector_helper_funcs);
> -	ret = drm_writeback_connector_init_with_encoder(drm, &txp->connector,
> -							encoder,
> -							&vc4_txp_connector_funcs,
> -							drm_fmts, ARRAY_SIZE(drm_fmts));
> +	ret = drm_writeback_connector_init(drm, &txp->connector,
> +					   &vc4_txp_connector_funcs,
> +					   encoder,
> +					   drm_fmts, ARRAY_SIZE(drm_fmts));
>   	if (ret)
>   		return ret;
>   
> diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> index 879ca103320c..958466a05e60 100644
> --- a/include/drm/drm_writeback.h
> +++ b/include/drm/drm_writeback.h
> @@ -137,11 +137,11 @@ drm_connector_to_writeback(struct drm_connector *connector)
>   	return container_of(connector, struct drm_writeback_connector, base);
>   }
>   
> -int drm_writeback_connector_init_with_encoder(struct drm_device *dev,
> -				struct drm_writeback_connector *wb_connector,
> -				struct drm_encoder *enc,
> -				const struct drm_connector_funcs *con_funcs, const u32 *formats,
> -				int n_formats);
> +int drm_writeback_connector_init(struct drm_device *dev,
> +				 struct drm_writeback_connector *wb_connector,
> +				 const struct drm_connector_funcs *con_funcs,
> +				 struct drm_encoder *enc,
> +				 const u32 *formats, int n_formats);
>   
>   int drmm_writeback_connector_init(struct drm_device *dev,
>   				  struct drm_writeback_connector *wb_connector,
> 

