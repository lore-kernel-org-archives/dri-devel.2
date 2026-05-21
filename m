Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF117CD5BB1
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 23:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2F310E548;
	Thu, 21 May 2026 23:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="leLMRULa";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C1FB10E548;
 Thu, 21 May 2026 23:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wRtXt66sED+LRbOBMHZl3brvZIn9DKbJCWMeOJ6Vffw=; b=leLMRULaqwzbCD9zryXtxwwgzR
 V8k6cb0e/f5H0+809xfH/7jkkHhpBIPV0cDkFd4oYwT+eqgzov6F3Pw2eZc7CNXtmstfCEkdDN+53
 HQnOyNVrZT5JCw3C+FVfOGHTUFfKcVGLqNj8lCBKwEn7bLgSEdm+IrjHmv3DI6wQSBoQ6HxTdAOrW
 +ocA03kuC2OLG/P50t8UkWE1Yp6CJg02ZzlxO1ZrxSJ9+dzkXmYvG8cIxOlvrFm8E27mVHVqAbmMW
 7owAL6mSMN4oKhBQ3K/GwNo9j1h2LDtXs7sgmdZL7y61PytOwmdPrlyeaLUL5keoQFGK0GJ7Ydy19
 BF+hDvVg==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wQCqa-004b06-BX; Fri, 22 May 2026 01:30:36 +0200
Message-ID: <6fc90fd0-cf88-4c58-b285-83bfdb26acb8@Igalia.com>
Date: Thu, 21 May 2026 16:30:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] drm: writeback: Modify writeback init helpers
To: Suraj Kandpal <suraj.kandpal@intel.com>, freedreno@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-list@raspberrypi.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: abhinav.kumar@linux.dev, tzimmermann@suse.de,
 marijn.suijten@somainline.org, laurent.pinchart+renesas@ideasonboard.com,
 dave.stevenson@raspberrypi.com, tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com,
 Louis Chauvet <louis.chauvet@bootlin.com>, kernel-dev@igalia.com
References: <20260521053708.1475129-1-suraj.kandpal@intel.com>
 <20260521053708.1475129-3-suraj.kandpal@intel.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20260521053708.1475129-3-suraj.kandpal@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/20/26 22:37, Suraj Kandpal wrote:
> The writeback connector init helpers (drm_writeback_connector_init,
> drm_writeback_connector_init_with_encoder, drmm_writeback_connector_init
> and drmm_writeback_connector_init_with_encoder) require access to the
> parent drm_connector object as well as the drm_writeback_connector
> object itself. So, pass in the top level drm_connector and traverse
> down to drm_writeback_connector rather than passing in the lower level
> object and traversing back up. Even where such is not the case, update
> to use the top level object for consistency across the interface.
>
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> ---
> v3 -> v4:
> - Update subject line for consitency (John)
> - Update commit message across commits for consitency (John)
> - Rename writeback to wb_connector in rcar_du_crtc for clarity (John)
>
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  2 +-
>   .../drm/arm/display/komeda/komeda_wb_connector.c   |  5 +----
>   drivers/gpu/drm/arm/malidp_mw.c                    |  2 +-
>   drivers/gpu/drm/drm_writeback.c                    | 14 ++++++--------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |  2 +-
>   .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    |  3 +--
>   drivers/gpu/drm/vc4/vc4_txp.c                      |  2 +-
>   drivers/gpu/drm/vkms/vkms_writeback.c              |  4 ++--
>   include/drm/drm_writeback.h                        |  4 ++--
>   9 files changed, 16 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index 6fb8cb4d520c..bb4945f01616 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> @@ -202,7 +202,7 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
>   
>   	drm_connector_helper_add(&wbcon->base, &amdgpu_dm_wb_conn_helper_funcs);
>   
> -	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base.writeback,
> +	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
>   					    &amdgpu_dm_wb_connector_funcs,
>   					    encoder,
>   					    amdgpu_dm_wb_formats,
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index fa2f63c142cd..85b34375d275 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -135,7 +135,6 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>   {
>   	struct komeda_dev *mdev = kms->base.dev_private;
>   	struct komeda_wb_connector *kwb_conn;
> -	struct drm_writeback_connector *wb_conn;
>   	struct drm_display_info *info;
>   	struct drm_encoder *encoder;
>   
> @@ -151,8 +150,6 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>   
>   	kwb_conn->wb_layer = kcrtc->master->wb_layer;
>   
> -	wb_conn = &kwb_conn->base.writeback;
> -
>   	formats = komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
>   					       kwb_conn->wb_layer->layer_type,
>   					       &n_formats);
> @@ -170,7 +167,7 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>   
>   	encoder->possible_crtcs = drm_crtc_mask(&kcrtc->base);
>   
> -	err = drmm_writeback_connector_init(&kms->base, wb_conn,
> +	err = drmm_writeback_connector_init(&kms->base, &kwb_conn->base,
>   					    &komeda_wb_connector_funcs,
>   					    encoder,
>   					    formats, n_formats);
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index 6842c73f27b9..c6d11c7af1e4 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -228,7 +228,7 @@ int malidp_mw_connector_init(struct drm_device *drm)
>   
>   	encoder->possible_crtcs = drm_crtc_mask(&malidp->crtc);
>   
> -	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector.writeback,
> +	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector,
>   					    &malidp_mw_connector_funcs,
>   					    encoder,
>   					    formats, n_formats);
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index 7bf9f6374712..9a3037d11009 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -242,7 +242,7 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>    * a custom encoder
>    *
>    * @dev: DRM device
> - * @wb_connector: Writeback connector to initialize
> + * @connector: Drm connector which contains the writeback connector to initialize
>    * @enc: handle to the already initialized drm encoder
>    * @con_funcs: Connector funcs vtable
>    * @formats: Array of supported pixel formats for the writeback engine
> @@ -267,13 +267,12 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>    * Returns: 0 on success, or a negative error code
>    */
>   int drm_writeback_connector_init(struct drm_device *dev,
> -				 struct drm_writeback_connector *wb_connector,
> +				 struct drm_connector *connector,
>   				 const struct drm_connector_funcs *con_funcs,
>   				 struct drm_encoder *enc,
>   				 const u32 *formats, int n_formats)
>   {
> -	struct drm_connector *connector =
> -		drm_writeback_to_connector(wb_connector);
> +	struct drm_writeback_connector *wb_connector = &connector->writeback;
>   	int ret;
>   
>   	ret = drm_connector_init(dev, connector, con_funcs,
> @@ -322,7 +321,7 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
>    * a custom encoder
>    *
>    * @dev: DRM device
> - * @wb_connector: Writeback connector to initialize
> + * @connector: Drm connector containing the writeback connector to initialize
You have most other equivalent entries saying 'Drm connector which 
contains'. Would be good to keep them all consistent. Personally, I 
think this one is simpler. Especially later when you have things like 
"connector which contains connector whose job...".

Plus, DRM should be DRM not Drm.

With those fixed (and consistent wording across the patches):
Reviewed-by: John Harrison <John.Harrison@Igalia.com>


>    * @con_funcs: Connector funcs vtable
>    * @enc: Encoder to connect this writeback connector
>    * @formats: Array of supported pixel formats for the writeback engine
> @@ -338,13 +337,12 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
>    * Returns: 0 on success, or a negative error code
>    */
>   int drmm_writeback_connector_init(struct drm_device *dev,
> -				  struct drm_writeback_connector *wb_connector,
> +				  struct drm_connector *connector,
>   				  const struct drm_connector_funcs *con_funcs,
>   				  struct drm_encoder *enc,
>   				  const u32 *formats, int n_formats)
>   {
> -	struct drm_connector *connector =
> -		drm_writeback_to_connector(wb_connector);
> +	struct drm_writeback_connector *wb_connector = &connector->writeback;
>   	int ret;
>   
>   	ret = drmm_connector_init(dev, connector, con_funcs,
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> index 69eb2f85dec3..4dee524d1270 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> @@ -136,7 +136,7 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
>   
>   	drm_connector_helper_add(&dpu_wb_conn->base, &dpu_wb_conn_helper_funcs);
>   
> -	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base.writeback,
> +	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base,
>   					   &dpu_wb_conn_funcs, enc,
>   					   format_list, num_formats);
>   
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index 39be854c465a..6b27307941a4 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -201,7 +201,6 @@ static const u32 writeback_formats[] = {
>   int rcar_du_writeback_init(struct rcar_du_device *rcdu,
>   			   struct rcar_du_crtc *rcrtc)
>   {
> -	struct drm_writeback_connector *wb_conn = &rcrtc->wb_connector.writeback;
>   	struct drm_encoder *encoder;
>   
>   	encoder = drmm_plain_encoder_alloc(&rcdu->ddev, NULL,
> @@ -216,7 +215,7 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
>   	drm_connector_helper_add(&rcrtc->wb_connector,
>   				 &rcar_du_wb_conn_helper_funcs);
>   
> -	return drmm_writeback_connector_init(&rcdu->ddev, wb_conn,
> +	return drmm_writeback_connector_init(&rcdu->ddev, &rcrtc->wb_connector,
>   					     &rcar_du_wb_conn_funcs,
>   					     encoder,
>   					     writeback_formats,
> diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
> index 8a4afa6a1eec..c762b93738d3 100644
> --- a/drivers/gpu/drm/vc4/vc4_txp.c
> +++ b/drivers/gpu/drm/vc4/vc4_txp.c
> @@ -601,7 +601,7 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
>   
>   	drm_connector_helper_add(&txp->connector,
>   				 &vc4_txp_connector_helper_funcs);
> -	ret = drmm_writeback_connector_init(drm, &txp->connector.writeback,
> +	ret = drmm_writeback_connector_init(drm, &txp->connector,
>   					    &vc4_txp_connector_funcs,
>   					    encoder,
>   					    drm_fmts, ARRAY_SIZE(drm_fmts));
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index 64d524d2168f..9341533b0325 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -170,7 +170,6 @@ static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
>   int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
>   				    struct vkms_output *vkms_output)
>   {
> -	struct drm_writeback_connector *wb = &vkms_output->wb_connector.writeback;
>   	int ret;
>   
>   	ret = drmm_encoder_init(&vkmsdev->drm, &vkms_output->wb_encoder,
> @@ -183,7 +182,8 @@ int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
>   
>   	drm_connector_helper_add(&vkms_output->wb_connector, &vkms_wb_conn_helper_funcs);
>   
> -	return drmm_writeback_connector_init(&vkmsdev->drm, wb,
> +	return drmm_writeback_connector_init(&vkmsdev->drm,
> +					     &vkms_output->wb_connector,
>   					     &vkms_wb_connector_funcs,
>   					     &vkms_output->wb_encoder,
>   					     vkms_wb_formats,
> diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> index 702141099520..c6960c7e634e 100644
> --- a/include/drm/drm_writeback.h
> +++ b/include/drm/drm_writeback.h
> @@ -78,13 +78,13 @@ drm_writeback_to_connector(struct drm_writeback_connector *wb_connector)
>   }
>   
>   int drm_writeback_connector_init(struct drm_device *dev,
> -				 struct drm_writeback_connector *wb_connector,
> +				 struct drm_connector *connector,
>   				 const struct drm_connector_funcs *con_funcs,
>   				 struct drm_encoder *enc,
>   				 const u32 *formats, int n_formats);
>   
>   int drmm_writeback_connector_init(struct drm_device *dev,
> -				  struct drm_writeback_connector *wb_connector,
> +				  struct drm_connector *connector,
>   				  const struct drm_connector_funcs *con_funcs,
>   				  struct drm_encoder *enc,
>   				  const u32 *formats, int n_formats);

