Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D32EC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ACC910E638;
	Wed,  8 Jul 2026 17:35:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="dY0JpsDT";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A61D10E4B5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783532117; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=j57xiw5gBZ3ISXdrCXkJM83me5csvjYEBMRpjYp2+H8tBuUa/ucMoaMm6PVMGKJ4wa1FaEKp1XIOq/sJKI6yvjxVxxQxvsSP1g64iXgcNmSWVrw483qrZrz/nDq7sWQShbIK9LX+4NvThRVfJV0YPfnIEErllKIKuV6nwkUlQB4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783532117;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MN+/pCt7HlUdRnnMFSDW76Ip6VHjfwc/YeBpH5RZ7Rs=; 
 b=bilwU6Y+zvS2KOjKVWbtMf3Vv5+xM6T3uQraxlbxnIS30dQb5Jrb74w/cjPBRiDEm7g7o3lPZxj0MFxlx5XvcOF4jcMNjxyw0RdUQLurOSzWVtZmZ+c0B4/vLiEU1T1PydRbXMfnSDMzl6SJIz4ti8FwmjVWenrXceSi/9bDNzE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783532117; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=MN+/pCt7HlUdRnnMFSDW76Ip6VHjfwc/YeBpH5RZ7Rs=;
 b=dY0JpsDTXZ69QDzauHnsRhzFHduBwYeAzf6v4004kheCPu8cYIU29vrROq2/WYfw
 1J4pp/AH7kwu4lLXVEhJxKO0JfsjT0PxsTNoGvYxun3AiHbdyYwsTdy5Cp0ttZiDKE5
 tmujY6wvOFrLDwM9Jv7kDZwjXAJdnrUmgH8EvtWc=
Received: by mx.zohomail.com with SMTPS id 1783532115402945.6183609354152;
 Wed, 8 Jul 2026 10:35:15 -0700 (PDT)
Message-ID: <18739a62-c5f5-4e33-b636-2368687fffa1@collabora.com>
Date: Wed, 8 Jul 2026 19:35:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/21] drm/vkms: Introduce support for post-blend color
 pipeline
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?=
 <nfraprado@collabora.com>
References: <20251223-mtk-post-blend-color-pipeline-v3-0-7d969f9a37a0@collabora.com>
 <20251223-mtk-post-blend-color-pipeline-v3-20-7d969f9a37a0@collabora.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20251223-mtk-post-blend-color-pipeline-v3-20-7d969f9a37a0@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi,

On 23.12.25 19:01, Ariel D'Alessandro wrote:
> From: "Nícolas F. R. A. Prado" <nfraprado@collabora.com>
>
> Introduce a post-blend color pipeline with the same colorop blocks as
> the pre-blend color pipeline.
>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>   drivers/gpu/drm/vkms/tests/vkms_config_test.c |  70 ++++++++++-------
>   drivers/gpu/drm/vkms/vkms_colorop.c           | 103 ++++++++++++++++++++++++++
>   drivers/gpu/drm/vkms/vkms_composer.c          |   5 +-
>   drivers/gpu/drm/vkms/vkms_config.c            |   5 +-
>   drivers/gpu/drm/vkms/vkms_config.h            |  29 +++++++-
>   drivers/gpu/drm/vkms/vkms_crtc.c              |   6 +-
>   drivers/gpu/drm/vkms/vkms_drv.c               |   7 +-
>   drivers/gpu/drm/vkms/vkms_drv.h               |   6 +-
>   drivers/gpu/drm/vkms/vkms_output.c            |   3 +-
>   9 files changed, 202 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> index 1e4ea1863420f..ec1d84ae508ad 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> @@ -84,6 +84,7 @@ struct default_config_case {
>   	bool enable_writeback;
>   	bool enable_overlay;
>   	bool enable_plane_pipeline;
> +	bool enable_crtc_pipeline;
>   };
>   
>   static void vkms_config_test_empty_config(struct kunit *test)
> @@ -109,22 +110,38 @@ static void vkms_config_test_empty_config(struct kunit *test)
>   }
>   
>   static struct default_config_case default_config_cases[] = {
> -	{ false, false, false, false },
> -	{ true, false, false, false },
> -	{ true, true, false, false },
> -	{ true, false, true, false },
> -	{ false, true, false, false },
> -	{ false, true, true, false },
> -	{ false, false, true, false },
> -	{ true, true, true, false },
> -	{ false, false, false, true },
> -	{ true, false, false, true },
> -	{ true, true, false, true },
> -	{ true, false, true, true },
> -	{ false, true, false, true },
> -	{ false, true, true, true },
> -	{ false, false, true, true },
> -	{ true, true, true, true },
> +	{ false, false, false, false, false },
> +	{ true, false, false, false, false },
> +	{ true, true, false, false, false },
> +	{ true, false, true, false, false },
> +	{ false, true, false, false, false },
> +	{ false, true, true, false, false },
> +	{ false, false, true, false, false },
> +	{ true, true, true, false, false },
> +	{ false, false, false, true, false },
> +	{ true, false, false, true, false },
> +	{ true, true, false, true, false },
> +	{ true, false, true, true, false },
> +	{ false, true, false, true, false },
> +	{ false, true, true, true, false },
> +	{ false, false, true, true, false },
> +	{ true, true, true, true, false },
> +	{ false, false, false, false, true },
> +	{ true, false, false, false, true },
> +	{ true, true, false, false, true },
> +	{ true, false, true, false, true },
> +	{ false, true, false, false, true },
> +	{ false, true, true, false, true },
> +	{ false, false, true, false, true },
> +	{ true, true, true, false, true },
> +	{ false, false, false, true, true },
> +	{ true, false, false, true, true },
> +	{ true, true, false, true, true },
> +	{ true, false, true, true, true },
> +	{ false, true, false, true, true },
> +	{ false, true, true, true, true },
> +	{ false, false, true, true, true },
> +	{ true, true, true, true, true },
>   };
>   
>   KUNIT_ARRAY_PARAM(default_config, default_config_cases, NULL);
> @@ -142,7 +159,8 @@ static void vkms_config_test_default_config(struct kunit *test)
>   	config = vkms_config_default_create(params->enable_cursor,
>   					    params->enable_writeback,
>   					    params->enable_overlay,
> -					    params->enable_plane_pipeline);
> +					    params->enable_plane_pipeline,
> +					    params->enable_crtc_pipeline);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
>   
>   	/* Planes */
> @@ -174,6 +192,8 @@ static void vkms_config_test_default_config(struct kunit *test)
>   	crtc_cfg = get_first_crtc(config);
>   	KUNIT_EXPECT_EQ(test, vkms_config_crtc_get_writeback(crtc_cfg),
>   			params->enable_writeback);
> +	KUNIT_EXPECT_EQ(test, vkms_config_crtc_get_default_pipeline(crtc_cfg),
> +			params->enable_crtc_pipeline);
>   
>   	vkms_config_for_each_plane(config, plane_cfg) {
>   		struct vkms_config_crtc *possible_crtc;
> @@ -381,7 +401,7 @@ static void vkms_config_test_invalid_plane_number(struct kunit *test)
>   	struct vkms_config_plane *plane_cfg;
>   	int n;
>   
> -	config = vkms_config_default_create(false, false, false, false);
> +	config = vkms_config_default_create(false, false, false, false, false);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
>   
>   	/* Invalid: No planes */
> @@ -406,7 +426,7 @@ static void vkms_config_test_valid_plane_type(struct kunit *test)
>   	struct vkms_config_encoder *encoder_cfg;
>   	int err;
>   
> -	config = vkms_config_default_create(false, false, false, false);
> +	config = vkms_config_default_create(false, false, false, false, false);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
>   
>   	plane_cfg = get_first_plane(config);
> @@ -487,7 +507,7 @@ static void vkms_config_test_valid_plane_possible_crtcs(struct kunit *test)
>   	struct vkms_config_plane *plane_cfg;
>   	struct vkms_config_crtc *crtc_cfg;
>   
> -	config = vkms_config_default_create(false, false, false, false);
> +	config = vkms_config_default_create(false, false, false, false, false);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
>   
>   	plane_cfg = get_first_plane(config);
> @@ -506,7 +526,7 @@ static void vkms_config_test_invalid_crtc_number(struct kunit *test)
>   	struct vkms_config_crtc *crtc_cfg;
>   	int n;
>   
> -	config = vkms_config_default_create(false, false, false, false);
> +	config = vkms_config_default_create(false, false, false, false, false);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
>   
>   	/* Invalid: No CRTCs */
> @@ -529,7 +549,7 @@ static void vkms_config_test_invalid_encoder_number(struct kunit *test)
>   	struct vkms_config_encoder *encoder_cfg;
>   	int n;
>   
> -	config = vkms_config_default_create(false, false, false, false);
> +	config = vkms_config_default_create(false, false, false, false, false);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
>   
>   	/* Invalid: No encoders */
> @@ -554,7 +574,7 @@ static void vkms_config_test_valid_encoder_possible_crtcs(struct kunit *test)
>   	struct vkms_config_encoder *encoder_cfg;
>   	int err;
>   
> -	config = vkms_config_default_create(false, false, false, false);
> +	config = vkms_config_default_create(false, false, false, false, false);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
>   
>   	crtc_cfg1 = get_first_crtc(config);
> @@ -600,7 +620,7 @@ static void vkms_config_test_invalid_connector_number(struct kunit *test)
>   	struct vkms_config_connector *connector_cfg;
>   	int n;
>   
> -	config = vkms_config_default_create(false, false, false, false);
> +	config = vkms_config_default_create(false, false, false, false, false);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
>   
>   	/* Invalid: No connectors */
> @@ -623,7 +643,7 @@ static void vkms_config_test_valid_connector_possible_encoders(struct kunit *tes
>   	struct vkms_config_encoder *encoder_cfg;
>   	struct vkms_config_connector *connector_cfg;
>   
> -	config = vkms_config_default_create(false, false, false, false);
> +	config = vkms_config_default_create(false, false, false, false, false);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
>   
>   	encoder_cfg = get_first_encoder(config);
> diff --git a/drivers/gpu/drm/vkms/vkms_colorop.c b/drivers/gpu/drm/vkms/vkms_colorop.c
> index dd6120434690e..6c4a6cb186564 100644
> --- a/drivers/gpu/drm/vkms/vkms_colorop.c
> +++ b/drivers/gpu/drm/vkms/vkms_colorop.c
> @@ -102,6 +102,91 @@ static int vkms_initialize_plane_color_pipeline(struct drm_plane *plane,
>   	return ret;
>   }
>   
> +static int vkms_initialize_crtc_color_pipeline(struct drm_crtc *crtc,
> +					       struct drm_prop_enum_list *list)
> +{
> +	struct drm_colorop *ops[MAX_COLOR_PIPELINE_OPS];
> +	struct drm_device *dev = crtc->dev;
> +	int ret;
> +	int i = 0, j = 0;
> +
> +	memset(ops, 0, sizeof(ops));
> +
> +	/* 1st op: 1d curve */
> +	ops[i] = kzalloc(sizeof(*ops[i]), GFP_KERNEL);
> +	if (!ops[i]) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret = drm_crtc_colorop_curve_1d_init(dev, ops[i], crtc, supported_tfs,
> +					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto err_colorop_init;
> +
> +	list->type = ops[i]->base.id;
> +	list->name = kasprintf(GFP_KERNEL, "Color Pipeline %d", ops[i]->base.id);
> +
> +	i++;
> +
> +	/* 2nd op: 3x4 matrix */
> +	ops[i] = kzalloc(sizeof(*ops[i]), GFP_KERNEL);
> +	if (!ops[i]) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret = drm_crtc_colorop_ctm_3x4_init(dev, ops[i], crtc, DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto err_colorop_init;
> +
> +	drm_colorop_set_next_property(ops[i - 1], ops[i]);
> +
> +	i++;
> +
> +	/* 3rd op: 3x4 matrix */
> +	ops[i] = kzalloc(sizeof(*ops[i]), GFP_KERNEL);
> +	if (!ops[i]) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret = drm_crtc_colorop_ctm_3x4_init(dev, ops[i], crtc, DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto err_colorop_init;
> +
> +	drm_colorop_set_next_property(ops[i - 1], ops[i]);
> +
> +	i++;
> +
> +	/* 4th op: 1d curve */
> +	ops[i] = kzalloc(sizeof(*ops[i]), GFP_KERNEL);
> +	if (!ops[i]) {
> +		ret = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret = drm_crtc_colorop_curve_1d_init(dev, ops[i], crtc, supported_tfs,
> +					     DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto err_colorop_init;
> +
> +	drm_colorop_set_next_property(ops[i - 1], ops[i]);
> +
> +	return 0;
> +
> +err_colorop_init:
> +	kfree(ops[i]);
> +
> +cleanup:
> +	for (j = 0; j < i; j++) {
> +		drm_colorop_cleanup(ops[j]);
> +		kfree(ops[j]);
> +	}
> +
> +	return ret;
> +}
> +
>   int vkms_initialize_plane_colorops(struct drm_plane *plane)
>   {
>   	struct drm_prop_enum_list pipeline;
> @@ -119,3 +204,21 @@ int vkms_initialize_plane_colorops(struct drm_plane *plane)
>   
>   	return 0;
>   }
> +
> +int vkms_initialize_crtc_colorops(struct drm_crtc *crtc)
> +{
> +	struct drm_prop_enum_list pipeline;
> +	int ret;
> +
> +	/* Add color pipeline */
> +	ret = vkms_initialize_crtc_color_pipeline(crtc, &pipeline);
> +	if (ret)
> +		return ret;
> +
> +	/* Create COLOR_PIPELINE property and attach */
> +	ret = drm_crtc_create_color_pipeline_property(crtc, &pipeline, 1);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index d4f87a2aa3359..621f008b165a6 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -495,7 +495,10 @@ static void blend(struct vkms_writeback_job *wb,
>   			blend_line(plane[i], y, crtc_x_limit, stage_buffer, output_buffer);
>   		}
>   
> -		apply_lut(crtc_state, output_buffer);
> +		if (crtc_state->base.color_pipeline_enabled)

AFAICS you could just use crtc_state->base.state->plane_color_pipeline 
here - that should allow you to drop "[PATCH v3 11/21] drm/crtc: Track 
crtc color pipeline client cap in drm_crtc_state"

Regards

> +			color_transform(crtc_state->base.color_pipeline, output_buffer);
> +		else
> +			apply_lut(crtc_state, output_buffer);
>   
>   		*crc32 = crc32_le(*crc32, (void *)output_buffer->pixels, row_size);
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
> index 8788df9edb7ca..a65c3638eff4d 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
> @@ -34,7 +34,8 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_create);
>   struct vkms_config *vkms_config_default_create(bool enable_cursor,
>   					       bool enable_writeback,
>   					       bool enable_overlay,
> -					       bool enable_plane_pipeline)
> +					       bool enable_plane_pipeline,
> +					       bool enable_crtc_pipeline)
>   {
>   	struct vkms_config *config;
>   	struct vkms_config_plane *plane_cfg;
> @@ -56,6 +57,7 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
>   	if (IS_ERR(crtc_cfg))
>   		goto err_alloc;
>   	vkms_config_crtc_set_writeback(crtc_cfg, enable_writeback);
> +	vkms_config_crtc_set_default_pipeline(crtc_cfg, enable_crtc_pipeline);
>   
>   	if (vkms_config_plane_attach_crtc(plane_cfg, crtc_cfg))
>   		goto err_alloc;
> @@ -454,6 +456,7 @@ struct vkms_config_crtc *vkms_config_create_crtc(struct vkms_config *config)
>   
>   	crtc_cfg->config = config;
>   	vkms_config_crtc_set_writeback(crtc_cfg, false);
> +	vkms_config_crtc_set_default_pipeline(crtc_cfg, false);
>   
>   	list_add_tail(&crtc_cfg->link, &config->crtcs);
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
> index 8f7f286a4bdd7..e12e4065f01f0 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h
> @@ -61,6 +61,7 @@ struct vkms_config_plane {
>    * @link: Link to the others CRTCs in vkms_config
>    * @config: The vkms_config this CRTC belongs to
>    * @writeback: If true, a writeback buffer can be attached to the CRTC
> + * @default_pipeline: If true, CRTC will be created with the default pipeline.
>    * @crtc: Internal usage. This pointer should never be considered as valid.
>    *        It can be used to store a temporary reference to a VKMS CRTC during
>    *        device creation. This pointer is not managed by the configuration and
> @@ -71,6 +72,7 @@ struct vkms_config_crtc {
>   	struct vkms_config *config;
>   
>   	bool writeback;
> +	bool default_pipeline;
>   
>   	/* Internal usage */
>   	struct vkms_output *crtc;
> @@ -205,7 +207,8 @@ struct vkms_config *vkms_config_create(const char *dev_name);
>   struct vkms_config *vkms_config_default_create(bool enable_cursor,
>   					       bool enable_writeback,
>   					       bool enable_overlay,
> -					       bool enable_plane_pipeline);
> +					       bool enable_plane_pipeline,
> +					       bool enable_crtc_pipeline);
>   
>   /**
>    * vkms_config_destroy() - Free a VKMS configuration
> @@ -314,6 +317,30 @@ vkms_config_plane_set_default_pipeline(struct vkms_config_plane *plane_cfg,
>   	plane_cfg->default_pipeline = default_pipeline;
>   }
>   
> +/**
> + * vkms_config_crtc_get_default_pipeline() - Return if the CRTC will
> + * be created with the default pipeline
> + * @crtc_cfg: CRTC to get the information from
> + */
> +static inline bool
> +vkms_config_crtc_get_default_pipeline(struct vkms_config_crtc *crtc_cfg)
> +{
> +	return crtc_cfg->default_pipeline;
> +}
> +
> +/**
> + * vkms_config_crtc_set_default_pipeline() - Set if the CRTC will
> + * be created with the default pipeline
> + * @crtc_cfg: CRTC to configure the pipeline
> + * @default_pipeline: New default pipeline value
> + */
> +static inline void
> +vkms_config_crtc_set_default_pipeline(struct vkms_config_crtc *crtc_cfg,
> +				      bool default_pipeline)
> +{
> +	crtc_cfg->default_pipeline = default_pipeline;
> +}
> +
>   /**
>    * vkms_config_plane_attach_crtc - Attach a plane to a CRTC
>    * @plane_cfg: Plane to attach
> diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
> index 9a7db1d510222..60c372c0ce2d8 100644
> --- a/drivers/gpu/drm/vkms/vkms_crtc.c
> +++ b/drivers/gpu/drm/vkms/vkms_crtc.c
> @@ -10,6 +10,7 @@
>   #include <drm/drm_vblank.h>
>   #include <drm/drm_vblank_helper.h>
>   
> +#include "vkms_config.h"
>   #include "vkms_drv.h"
>   
>   static bool vkms_crtc_handle_vblank_timeout(struct drm_crtc *crtc)
> @@ -202,7 +203,7 @@ static const struct drm_crtc_helper_funcs vkms_crtc_helper_funcs = {
>   };
>   
>   struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_plane *primary,
> -				   struct drm_plane *cursor)
> +				   struct drm_plane *cursor, struct vkms_config_crtc *crtc_cfg)
>   {
>   	struct vkms_output *vkms_out;
>   	struct drm_crtc *crtc;
> @@ -228,6 +229,9 @@ struct vkms_output *vkms_crtc_init(struct drm_device *dev, struct drm_plane *pri
>   
>   	drm_crtc_enable_color_mgmt(crtc, 0, false, VKMS_LUT_SIZE);
>   
> +	if (vkms_config_crtc_get_default_pipeline(crtc_cfg))
> +		vkms_initialize_crtc_colorops(crtc);
> +
>   	spin_lock_init(&vkms_out->lock);
>   	spin_lock_init(&vkms_out->composer_lock);
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
> index dd1402f437736..39195540fe2b1 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -55,6 +55,10 @@ static bool enable_plane_pipeline;
>   module_param_named(enable_plane_pipeline, enable_plane_pipeline, bool, 0444);
>   MODULE_PARM_DESC(enable_plane_pipeline, "Enable/Disable plane pipeline support");
>   
> +static bool enable_crtc_pipeline;
> +module_param_named(enable_crtc_pipeline, enable_crtc_pipeline, bool, 0444);
> +MODULE_PARM_DESC(enable_crtc_pipeline, "Enable/Disable CRTC pipeline support");
> +
>   static bool create_default_dev = true;
>   module_param_named(create_default_dev, create_default_dev, bool, 0444);
>   MODULE_PARM_DESC(create_default_dev, "Create or not the default VKMS device");
> @@ -232,7 +236,8 @@ static int __init vkms_init(void)
>   		return 0;
>   
>   	config = vkms_config_default_create(enable_cursor, enable_writeback,
> -					    enable_overlay, enable_plane_pipeline);
> +					    enable_overlay, enable_plane_pipeline,
> +					    enable_crtc_pipeline);
>   	if (IS_ERR(config))
>   		return PTR_ERR(config);
>   
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index bdeb52623f4d6..1688c885f2285 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -229,6 +229,7 @@ struct vkms_output {
>   };
>   
>   struct vkms_config;
> +struct vkms_config_crtc;
>   struct vkms_config_plane;
>   
>   /**
> @@ -287,10 +288,12 @@ void vkms_destroy(struct vkms_config *config);
>    * @crtc: uninitialized CRTC device
>    * @primary: primary plane to attach to the CRTC
>    * @cursor: plane to attach to the CRTC
> + * @crtc_cfg: CRTC configuration
>    */
>   struct vkms_output *vkms_crtc_init(struct drm_device *dev,
>   				   struct drm_plane *primary,
> -				   struct drm_plane *cursor);
> +				   struct drm_plane *cursor,
> +				   struct vkms_config_crtc *crtc_cfg);
>   
>   /**
>    * vkms_output_init() - Initialize all sub-components needed for a VKMS device.
> @@ -325,5 +328,6 @@ int vkms_enable_writeback_connector(struct vkms_device *vkmsdev, struct vkms_out
>   
>   /* Colorops */
>   int vkms_initialize_plane_colorops(struct drm_plane *plane);
> +int vkms_initialize_crtc_colorops(struct drm_crtc *crtc);
>   
>   #endif /* _VKMS_DRV_H_ */
> diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
> index 86ce07a617f52..a0856ba90ac24 100644
> --- a/drivers/gpu/drm/vkms/vkms_output.c
> +++ b/drivers/gpu/drm/vkms/vkms_output.c
> @@ -34,7 +34,8 @@ int vkms_output_init(struct vkms_device *vkmsdev)
>   		cursor = vkms_config_crtc_cursor_plane(vkmsdev->config, crtc_cfg);
>   
>   		crtc_cfg->crtc = vkms_crtc_init(dev, &primary->plane->base,
> -						cursor ? &cursor->plane->base : NULL);
> +						cursor ? &cursor->plane->base : NULL,
> +						crtc_cfg);
>   		if (IS_ERR(crtc_cfg->crtc)) {
>   			DRM_ERROR("Failed to allocate CRTC\n");
>   			return PTR_ERR(crtc_cfg->crtc);
>
-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

