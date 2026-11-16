Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC7606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=FXF+522x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC58610E4D2;
	Mon, 16 Nov 2026 23:49:42 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 108D310E4C2;
 Mon, 16 Nov 2026 23:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=oCqWdQIGQCOZzitmtkFA20dx2a1EGHx/cd5A2O/wl08=; t=1794872976; x=2110232976; 
 b=FXF+522x5LmbZdb868r22riAmfrpfSDV6678o2iV+CFQ94jK1p4G5RxV3EWakhkJ1PO7+nPe7wp
 nwrImJNg+Ag2W8fiQ0Se1hW8RaTApgA2+q3vSbBhzecXTHck8Ax8ZZGad9bgsBwV7xCFcCzXrE2fP
 5PPKu6gkFDkDWHrN6F7uVL1Trt6WlArfln+xnYJ9GqDlj04cILH0nkTcMSSxC5sOkjF++Oc7cTX5K
 8I+AJCPy+W517dzqycU8d7LvNi3CAqg+6x0WrCHO548rUQWfsgfik2T9SNal4l2XFzETuLbcVFyrE
 mseFgTF2ktDstcYyQqXZz0PuQj26SBCdRTew==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xT6Rx-00000000OPS-0jp6; Tue, 17 Nov 2026 00:49:25 +0100
Message-ID: <57bcef5c-363a-4269-a38d-474e331e37c0@Igalia.com>
Date: Mon, 16 Nov 2026 15:49:16 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/10] drm: renesas: rcar-du: embed the writeback
 encoder in rcar_du_crtc
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Mihail Atanassov <mihail.atanassov@arm.com>, Eric Anholt <eric@anholt.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Brian Starkey <brian.starkey@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
References: <20261111-wb-drop-encoder-v8-0-62948ed87d13@oss.qualcomm.com>
 <20261111-wb-drop-encoder-v8-4-62948ed87d13@oss.qualcomm.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20261111-wb-drop-encoder-v8-4-62948ed87d13@oss.qualcomm.com>
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 16:42, Dmitry Baryshkov wrote:
> drm_writeback_connector_init() hides the encoder inside struct
> drm_writeback_connector, which is the only reason that structure carries
> an encoder at all. Every other writeback user already owns its encoder.
>
> Embed the encoder in the driver's own structure and register the
> connector with drm_writeback_connector_init_with_encoder(), so that the
> encoder can be dropped from drm_writeback_connector.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
It would be good to at least get an ack from someone at Renesas, but the 
patch looks good to me. The changes align with the equivalent changes to 
other drivers and the overall aim of the patch set.

Reviewed-by: John Harrison <John.Harrison@Igalia.com>

> ---
>   drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h     |  2 ++
>   .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 29 +++++++++++++++++-----
>   2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
> index 8857926e109a..d8b1dcab8dea 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
> @@ -44,6 +44,7 @@ struct rcar_du_vsp;
>    * @vsp: VSP feeding video to this CRTC
>    * @vsp_pipe: index of the VSP pipeline feeding video to this CRTC
>    * @writeback: the writeback connector
> + * @encoder: the writeback encoder
>    */
>   struct rcar_du_crtc {
>   	struct drm_crtc crtc;
> @@ -74,6 +75,7 @@ struct rcar_du_crtc {
>   	unsigned int sources_count;
>   
>   	struct drm_writeback_connector writeback;
> +	struct drm_encoder encoder;
>   };
>   
>   #define to_rcar_crtc(c)		container_of(c, struct rcar_du_crtc, crtc)
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index 0a3108965591..a1271fec9874 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -172,6 +172,10 @@ static int rcar_du_wb_enc_atomic_check(struct drm_encoder *encoder,
>   	return 0;
>   }
>   
> +static const struct drm_encoder_funcs rcar_du_wb_enc_funcs = {
> +	.destroy = drm_encoder_cleanup,
> +};
> +
>   static const struct drm_encoder_helper_funcs rcar_du_wb_enc_helper_funcs = {
>   	.atomic_check = rcar_du_wb_enc_atomic_check,
>   };
> @@ -199,16 +203,29 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
>   			   struct rcar_du_crtc *rcrtc)
>   {
>   	struct drm_writeback_connector *wb_conn = &rcrtc->writeback;
> +	struct drm_encoder *encoder = &rcrtc->encoder;
> +	int ret;
> +
> +	drm_encoder_helper_add(encoder, &rcar_du_wb_enc_helper_funcs);
> +	encoder->possible_crtcs = drm_crtc_mask(&rcrtc->crtc);
> +
> +	ret = drm_encoder_init(&rcdu->ddev, encoder, &rcar_du_wb_enc_funcs,
> +			       DRM_MODE_ENCODER_VIRTUAL, NULL);
> +	if (ret)
> +		return ret;
>   
>   	drm_connector_helper_add(&wb_conn->base,
>   				 &rcar_du_wb_conn_helper_funcs);
>   
> -	return drm_writeback_connector_init(&rcdu->ddev, wb_conn,
> -					    &rcar_du_wb_conn_funcs,
> -					    &rcar_du_wb_enc_helper_funcs,
> -					    writeback_formats,
> -					    ARRAY_SIZE(writeback_formats),
> -					    1 << drm_crtc_index(&rcrtc->crtc));
> +	ret = drm_writeback_connector_init_with_encoder(&rcdu->ddev, wb_conn,
> +							encoder,
> +							&rcar_du_wb_conn_funcs,
> +							writeback_formats,
> +							ARRAY_SIZE(writeback_formats));
> +	if (ret)
> +		drm_encoder_cleanup(encoder);
> +
> +	return ret;
>   }
>   
>   void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,
>

