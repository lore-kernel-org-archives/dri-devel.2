Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E2606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=C+C0EwvW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E864F10E15C;
	Tue,  3 Nov 2026 22:12:31 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 055C310E15C;
 Tue,  3 Nov 2026 22:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=x84ot11ZHk8kmM1pFcELFVBbhxlp1ehogrcHxTfRDVY=; t=1793743945; x=2109103945; 
 b=C+C0EwvWTziOdJOSTX1fVaBvYI75VTPbmuVupYcUIUsxclU+jiGca3aFLNw9ROxFnLawjNYLWPP
 RdmUYA9ggCca4/6YUHNd0Avp1Sm7AhvaGFqHQzg/MkowRs0GCitfKZfODEo/HDadlbXHMP3bLRDLq
 IRZlOqHldbcZUvINSW35dMqDZSakqL939lEWKtXCnbD1W/rD+hQYcvKORYfr8y+JdSYCBKHdgvm5e
 9ZFl/C6ghSxeWyARCBoELaTG67pv1wNIb7qzI/3zfgar8L6mVeD/NjuBBcycKoPxDDLenpTCa2ZSL
 hzdl5B6HBnIZgccp+rFedjPSjIw6EoibGvXw==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xOMjs-001enn-GI; Tue, 03 Nov 2026 23:12:20 +0100
Message-ID: <a359e88a-8afb-4aa5-bb5c-264ae56c4ee1@Igalia.com>
Date: Tue, 3 Nov 2026 14:12:12 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] drm: writeback: Refactor drm_writeback_connector
 structure
To: "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "kernel-list@raspberrypi.com" <kernel-list@raspberrypi.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Cc: "Shankar, Uma" <uma.shankar@intel.com>,
 "Murthy, Arun R" <arun.r.murthy@intel.com>,
 "abhinav.kumar@linux.dev" <abhinav.kumar@linux.dev>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>, "sean@poorly.ru"
 <sean@poorly.ru>,
 "marijn.suijten@somainline.org" <marijn.suijten@somainline.org>,
 "laurent.pinchart+renesas@ideasonboard.com"
 <laurent.pinchart+renesas@ideasonboard.com>,
 "dave.stevenson@raspberrypi.com" <dave.stevenson@raspberrypi.com>,
 "tomi.valkeinen+renesas@ideasonboard.com"
 <tomi.valkeinen+renesas@ideasonboard.com>,
 "kieran.bingham+renesas@ideasonboard.com"
 <kieran.bingham+renesas@ideasonboard.com>,
 "louis.chauvet@bootlin.com" <louis.chauvet@bootlin.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 Liviu Dudau <liviu.dudau@arm.com>
References: <20260714042805.77934-1-suraj.kandpal@intel.com>
 <20260714042805.77934-2-suraj.kandpal@intel.com>
 <fef90473-9572-4bbe-8cd3-8e2ef3a16469@Igalia.com>
 <DS4PPFE901A304FE19EA821D66BE3B9E3B1E3692@DS4PPFE901A304F.namprd11.prod.outlook.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <DS4PPFE901A304FE19EA821D66BE3B9E3B1E3692@DS4PPFE901A304F.namprd11.prod.outlook.com>
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

On 11/3/26 00:30, Kandpal, Suraj wrote:
>> -----Original Message-----
>> From: John Harrison <John.Harrison@Igalia.com>
>> Sent: 18 July 2026 01:10
>> To: Kandpal, Suraj <suraj.kandpal@intel.com>; freedreno@lists.freedesktop.org;
>> dri-devel@lists.freedesktop.org; kernel-list@raspberrypi.com; amd-
>> gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org; intel-
>> xe@lists.freedesktop.org; intel-gfx@lists.freedesktop.org
>> Cc: Shankar, Uma <uma.shankar@intel.com>; Murthy, Arun R
>> <arun.r.murthy@intel.com>; abhinav.kumar@linux.dev;
>> tzimmermann@suse.de; sean@poorly.ru; marijn.suijten@somainline.org;
>> laurent.pinchart+renesas@ideasonboard.com;
>> dave.stevenson@raspberrypi.com; tomi.valkeinen+renesas@ideasonboard.com;
>> kieran.bingham+renesas@ideasonboard.com; louis.chauvet@bootlin.com;
>> kernel-dev@igalia.com; Liviu Dudau <liviu.dudau@arm.com>
>> Subject: Re: [PATCH v6 1/7] drm: writeback: Refactor drm_writeback_connector
>> structure
>>
>> On 7/13/26 21:27, Suraj Kandpal wrote:
>>> Some drivers cannot work with the current design where the connector
>>> is embedded within the drm_writeback_connector such as Intel and some
>>> drivers that can get it working end up adding a lot of checks all
>>> around the code to check if it's a writeback conenctor or not, this is
>>> due to the limitation of inheritance in C.
>>> To solve this move the drm_writeback_connector within the
>>> drm_connector and remove the drm_connector base which was in
>>> drm_writeback_connector. Make this drm_writeback_connector a union
>>> with hdmi connector to save memory and since a connector can never be
>>> both writeback and hdmi it should serve us well.
>>> Do all other required modifications that come with these changes along
>>> with addition of new function which returns the drm_connector when
>>> drm_writeback_connector is present.
>>> Modify drivers using the drm_writeback_connector to allow them to use
>>> this connector without breaking them.
>>> The drivers modified here are amd, komeda, mali, vc4, vkms, rcar_du,
>>> msm
>>>
>>> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
>>> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
>>> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
>>> Reviewed-by: John Harrison <John.Harrison@Igalia.com>
>>> ---
>>> v5 -> v6:
>>> - Rebase on latest kernel
>>>
>>> v4 -> v5:
>>> - Remove more unnecessary wrapping of drm_writeback_to_connector()
>>> (John)
>>>
>>> v3 -> v4:
>>> - Use drm_writeback_to_connector() wherever possible (John)
>>> - Do not wrap line where not needed (John)
>>>
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
>>>    .../display/amdgpu_dm/amdgpu_dm_connector.c   |  4 +-
>>>    .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  8 +--
>>>    .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  6 +-
>>>    .../gpu/drm/arm/display/komeda/komeda_kms.h   |  6 +-
>>>    .../arm/display/komeda/komeda_wb_connector.c  |  8 +--
>>>    drivers/gpu/drm/arm/malidp_crtc.c             |  2 +-
>>>    drivers/gpu/drm/arm/malidp_drv.h              |  2 +-
>>>    drivers/gpu/drm/arm/malidp_hw.c               |  6 +-
>>>    drivers/gpu/drm/arm/malidp_mw.c               |  8 +--
>>>    drivers/gpu/drm/drm_atomic_uapi.c             |  2 +-
>>>    drivers/gpu/drm/drm_writeback.c               | 28 ++++----
>>>    .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   |  3 +-
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 14 ++--
>>>    drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h |  4 +-
>>>    .../gpu/drm/renesas/rcar-du/rcar_du_crtc.h    |  6 +-
>>>    .../drm/renesas/rcar-du/rcar_du_writeback.c   | 16 +++--
>>>    drivers/gpu/drm/vc4/vc4_txp.c                 | 12 ++--
>>>    drivers/gpu/drm/vkms/vkms_composer.c          |  2 +-
>>>    drivers/gpu/drm/vkms/vkms_drv.h               |  2 +-
>>>    drivers/gpu/drm/vkms/vkms_writeback.c         | 13 ++--
>>>    include/drm/drm_connector.h                   | 69 +++++++++++++++++--
>>>    include/drm/drm_writeback.h                   | 66 +-----------------
>>>    24 files changed, 150 insertions(+), 141 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index 1726eb6a3c63..427a8a52d256 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -4885,7 +4885,7 @@ static void dm_set_writeback(struct
>> amdgpu_display_manager *dm,
>>>    			      struct drm_connector *connector,
>>>    			      struct drm_connector_state *new_con_state)
>>>    {
>>> -	struct drm_writeback_connector *wb_conn =
>> drm_connector_to_writeback(connector);
>>> +	struct drm_writeback_connector *wb_conn = &connector->writeback;
>>>    	struct amdgpu_device *adev = dm->adev;
>>>    	struct amdgpu_crtc *acrtc;
>>>    	struct dc_writeback_info *wb_info;
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>>> index 91affbdb2d6c..a1faf9f3670e 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>>> @@ -894,7 +894,7 @@ static inline void amdgpu_dm_set_mst_status(uint8_t
>> *status,
>>>    #define to_amdgpu_dm_connector(x) container_of(x, struct
>>> amdgpu_dm_connector, base)
>>>
>>>    struct amdgpu_dm_wb_connector {
>>> -	struct drm_writeback_connector base;
>>> +	struct drm_connector base;
>>>    	struct dc_link *link;
>>>    };
>>>
>>> diff --git
>>> a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>>> index 88f938a8f24f..d48d764eae63 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
>>> @@ -1368,11 +1368,9 @@ create_stream_for_sink(struct drm_connector
>> *connector,
>>>    		aconnector = to_amdgpu_dm_connector(connector);
>>>    		link = aconnector->dc_link;
>>>    	} else {
>>> -		struct drm_writeback_connector *wbcon = NULL;
>>>    		struct amdgpu_dm_wb_connector *dm_wbcon = NULL;
>>>
>>> -		wbcon = drm_connector_to_writeback(connector);
>>> -		dm_wbcon = to_amdgpu_dm_wb_connector(wbcon);
>>> +		dm_wbcon = to_amdgpu_dm_wb_connector(connector);
>>>    		link = dm_wbcon->link;
>>>    	}
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>>> index 3ee31634549e..18ef4ce73b46 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>>> @@ -205,9 +205,9 @@ int amdgpu_dm_wb_connector_init(struct
>>> amdgpu_display_manager *dm,
>>>
>>>    	wbcon->link = link;
>>>
>>> -	drm_connector_helper_add(&wbcon->base.base,
>> &amdgpu_dm_wb_conn_helper_funcs);
>>> +	drm_connector_helper_add(&wbcon->base,
>>> +&amdgpu_dm_wb_conn_helper_funcs);
>>>
>>> -	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon-
>>> base,
>>> +	res = drmm_writeback_connector_init(&dm->adev->ddev,
>>> +&wbcon->base.writeback,
>>>
>> &amdgpu_dm_wb_connector_funcs,
>>>    					    encoder,
>>>    					    amdgpu_dm_wb_formats,
>>> @@ -219,8 +219,8 @@ int amdgpu_dm_wb_connector_init(struct
>> amdgpu_display_manager *dm,
>>>    	 * Some of the properties below require access to state, like bpc.
>>>    	 * Allocate some default initial connector state with our reset helper.
>>>    	 */
>>> -	if (wbcon->base.base.funcs->reset)
>>> -		wbcon->base.base.funcs->reset(&wbcon->base.base);
>>> +	if (wbcon->base.funcs->reset)
>>> +		wbcon->base.funcs->reset(&wbcon->base);
>>>
>>>    	return 0;
>>>    }
>>> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
>>> b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
>>> index e8cb782a6f8e..6611920c45fb 100644
>>> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
>>> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
>>> @@ -213,7 +213,7 @@ void komeda_crtc_handle_event(struct komeda_crtc
>> *kcrtc,
>>>    		struct komeda_wb_connector *wb_conn = kcrtc->wb_conn;
>>>
>>>    		if (wb_conn)
>>> -			drm_writeback_signal_completion(&wb_conn->base,
>> 0);
>>> +			drm_writeback_signal_completion(&wb_conn-
>>> base.writeback, 0);
>>>    		else
>>>    			drm_warn(drm, "CRTC[%d]: EOW happen but no
>> wb_connector.\n",
>>>    				 drm_crtc_index(&kcrtc->base));
>>> @@ -269,9 +269,9 @@ komeda_crtc_do_flush(struct drm_crtc *crtc,
>>>    	if (slave && has_bit(slave->id, kcrtc_st->affected_pipes))
>>>    		komeda_pipeline_update(slave, old->state);
>>>
>>> -	conn_st = wb_conn ? wb_conn->base.base.state : NULL;
>>> +	conn_st = wb_conn ? wb_conn->base.state : NULL;
>>>    	if (conn_st && conn_st->writeback_job)
>>> -		drm_writeback_queue_job(&wb_conn->base, conn_st);
>>> +		drm_writeback_queue_job(&wb_conn->base.writeback,
>> conn_st);
>>>    	/* step 2: notify the HW to kickoff the update */
>>>    	mdev->funcs->flush(mdev, master->id, kcrtc_st->active_pipes); diff
>>> --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
>>> b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
>>> index 83e61c4080c2..9c34302782c0 100644
>>> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
>>> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
>>> @@ -53,8 +53,8 @@ struct komeda_plane_state {
>>>     * struct komeda_wb_connector
>>>     */
>>>    struct komeda_wb_connector {
>>> -	/** @base: &drm_writeback_connector */
>>> -	struct drm_writeback_connector base;
>>> +	/** @base: &drm_connector */
>>> +	struct drm_connector base;
>>>
>>>    	/** @wb_layer: represents associated writeback pipeline of komeda */
>>>    	struct komeda_layer *wb_layer;
>>> @@ -139,7 +139,7 @@ struct komeda_kms_dev {
>>>    static inline bool is_writeback_only(struct drm_crtc_state *st)
>>>    {
>>>    	struct komeda_wb_connector *wb_conn = to_kcrtc(st->crtc)-
>>> wb_conn;
>>> -	struct drm_connector *conn = wb_conn ? &wb_conn->base.base :
>> NULL;
>>> +	struct drm_connector *conn = wb_conn ? &wb_conn->base : NULL;
>>>
>>>    	return conn && (st->connector_mask ==
>> BIT(drm_connector_index(conn)));
>>>    }
>>> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
>>> b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
>>> index c1bedbaa26f9..848ac37a76e4 100644
>>> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
>>> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
>>> @@ -53,7 +53,7 @@ komeda_wb_encoder_atomic_check(struct
>> drm_encoder *encoder,
>>>    		return -EINVAL;
>>>    	}
>>>
>>> -	wb_layer = to_kconn(to_wb_conn(conn_st->connector))->wb_layer;
>>> +	wb_layer = to_kconn(conn_st->connector)->wb_layer;
>>>
>>>    	/*
>>>    	 * No need for a full modested when the only connector changed is
>>> the @@ -151,7 +151,7 @@ static int komeda_wb_connector_add(struct
>>> komeda_kms_dev *kms,
>>>
>>>    	kwb_conn->wb_layer = kcrtc->master->wb_layer;
>>>
>>> -	wb_conn = &kwb_conn->base;
>>> +	wb_conn = &kwb_conn->base.writeback;
>>>
>>>    	formats = komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
>>>    					       kwb_conn->wb_layer->layer_type,
>> @@ -183,9 +183,9 @@
>>> static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>>>    		return err;
>>>    	}
>>>
>>> -	drm_connector_helper_add(&wb_conn->base,
>> &komeda_wb_conn_helper_funcs);
>>> +	drm_connector_helper_add(&kwb_conn->base,
>>> +&komeda_wb_conn_helper_funcs);
>>>
>>> -	info = &kwb_conn->base.base.display_info;
>>> +	info = &kwb_conn->base.display_info;
>>>    	info->bpc = __fls(kcrtc->master->improc->supported_color_depths);
>>>    	info->color_formats =
>>> kcrtc->master->improc->supported_color_formats;
>>>
>>> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c
>>> b/drivers/gpu/drm/arm/malidp_crtc.c
>>> index ebe8e1078777..4402c1de8c69 100644
>>> --- a/drivers/gpu/drm/arm/malidp_crtc.c
>>> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
>>> @@ -421,7 +421,7 @@ static int malidp_crtc_atomic_check(struct drm_crtc
>> *crtc,
>>>    		u32 new_mask = crtc_state->connector_mask;
>>>
>>>    		if ((old_mask ^ new_mask) ==
>>> -		    (1 << drm_connector_index(&malidp->mw_connector.base)))
>>> +		    (1 << drm_connector_index(&malidp->mw_connector)))
>>>    			crtc_state->connectors_changed = false;
>>>    	}
>>>
>>> diff --git a/drivers/gpu/drm/arm/malidp_drv.h
>>> b/drivers/gpu/drm/arm/malidp_drv.h
>>> index bc0387876dea..aa5599467d27 100644
>>> --- a/drivers/gpu/drm/arm/malidp_drv.h
>>> +++ b/drivers/gpu/drm/arm/malidp_drv.h
>>> @@ -32,7 +32,7 @@ struct malidp_drm {
>>>    	struct drm_device base;
>>>    	struct malidp_hw_device *dev;
>>>    	struct drm_crtc crtc;
>>> -	struct drm_writeback_connector mw_connector;
>>> +	struct drm_connector mw_connector;
>>>    	wait_queue_head_t wq;
>>>    	struct drm_pending_vblank_event *event;
>>>    	atomic_t config_valid;
>>> diff --git a/drivers/gpu/drm/arm/malidp_hw.c
>>> b/drivers/gpu/drm/arm/malidp_hw.c index 9b845d3f34e1..5a7bd27d3718
>>> 100644
>>> --- a/drivers/gpu/drm/arm/malidp_hw.c
>>> +++ b/drivers/gpu/drm/arm/malidp_hw.c
>>> @@ -1315,15 +1315,15 @@ static irqreturn_t malidp_se_irq(int irq, void
>> *arg)
>>>    	if (status & se->vsync_irq) {
>>>    		switch (hwdev->mw_state) {
>>>    		case MW_ONESHOT:
>>> -			drm_writeback_signal_completion(&malidp-
>>> mw_connector, 0);
>>> +			drm_writeback_signal_completion(&malidp-
>>> mw_connector.writeback,
>>> +0);
>>>    			break;
>>>    		case MW_STOP:
>>> -			drm_writeback_signal_completion(&malidp-
>>> mw_connector, 0);
>>> +			drm_writeback_signal_completion(&malidp-
>>> mw_connector.writeback,
>>> +0);
>>>    			/* disable writeback after stop */
>>>    			hwdev->mw_state = MW_NOT_ENABLED;
>>>    			break;
>>>    		case MW_RESTART:
>>> -			drm_writeback_signal_completion(&malidp-
>>> mw_connector, 0);
>>> +			drm_writeback_signal_completion(&malidp-
>>> mw_connector.writeback,
>>> +0);
>>>    			fallthrough;	/* to a new start */
>>>    		case MW_START:
>>>    			/* writeback started, need to emulate one-shot mode
>> */ diff --git
>>> a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
>>> index a4c6a00c0941..4c77a459c241 100644
>>> --- a/drivers/gpu/drm/arm/malidp_mw.c
>>> +++ b/drivers/gpu/drm/arm/malidp_mw.c
>>> @@ -212,7 +212,7 @@ int malidp_mw_connector_init(struct drm_device
>> *drm)
>>>    	if (!malidp->dev->hw->enable_memwrite)
>>>    		return 0;
>>>
>>> -	drm_connector_helper_add(&malidp->mw_connector.base,
>>> +	drm_connector_helper_add(&malidp->mw_connector,
>>>    				 &malidp_mw_connector_helper_funcs);
>>>
>>>    	formats = get_writeback_formats(malidp, &n_formats); @@ -229,7
>>> +229,7 @@ int malidp_mw_connector_init(struct drm_device *drm)
>>>
>>>    	encoder->possible_crtcs = drm_crtc_mask(&malidp->crtc);
>>>
>>> -	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector,
>>> +	ret = drmm_writeback_connector_init(drm,
>>> +&malidp->mw_connector.writeback,
>>>    					    &malidp_mw_connector_funcs,
>>>    					    encoder,
>>>    					    formats, n_formats);
>>> @@ -244,8 +244,8 @@ void malidp_mw_atomic_commit(struct drm_device
>> *drm,
>>>    			     struct drm_atomic_commit *old_state)
>>>    {
>>>    	struct malidp_drm *malidp = drm_to_malidp(drm);
>>> -	struct drm_writeback_connector *mw_conn = &malidp-
>>> mw_connector;
>>> -	struct drm_connector_state *conn_state = mw_conn->base.state;
>>> +	struct drm_writeback_connector *mw_conn = &malidp-
>>> mw_connector.writeback;
>>> +	struct drm_connector_state *conn_state = malidp-
>>> mw_connector.state;
>>>    	struct malidp_hw_device *hwdev = malidp->dev;
>>>    	struct malidp_mw_connector_state *mw_state;
>>>
>>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c
>>> b/drivers/gpu/drm/drm_atomic_uapi.c
>>> index 1050dddadb17..a5c11832ff64 100644
>>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>>> @@ -1514,7 +1514,7 @@ static int prepare_signaling(struct drm_device
>> *dev,
>>>    		f[*num_fences].out_fence_ptr = fence_ptr;
>>>    		*fence_state = f;
>>>
>>> -		wb_conn = drm_connector_to_writeback(conn);
>>> +		wb_conn = &conn->writeback;
>>>    		fence = drm_writeback_get_out_fence(wb_conn);
>>>    		if (!fence)
>>>    			return -ENOMEM;
>>> diff --git a/drivers/gpu/drm/drm_writeback.c
>>> b/drivers/gpu/drm/drm_writeback.c index 6ba3833a93ca..f93c936643bb
>>> 100644
>>> --- a/drivers/gpu/drm/drm_writeback.c
>>> +++ b/drivers/gpu/drm/drm_writeback.c
>>> @@ -95,8 +95,9 @@ static const char
>> *drm_writeback_fence_get_driver_name(struct dma_fence *fence)
>>>    {
>>>    	struct drm_writeback_connector *wb_connector =
>>>    		fence_to_wb_connector(fence);
>>> +	struct drm_connector *connector =
>>> +drm_writeback_to_connector(wb_connector);
>>>
>>> -	return wb_connector->base.dev->driver->name;
>>> +	return connector->dev->driver->name;
>>>    }
>>>
>>>    static const char *
>>> @@ -193,7 +194,7 @@ static int __drm_writeback_connector_init(struct
>> drm_device *dev,
>>>    					  struct drm_encoder *enc, const u32
>> *formats,
>>>    					  int n_formats)
>>>    {
>>> -	struct drm_connector *connector = &wb_connector->base;
>>> +	struct drm_connector *connector =
>>> +drm_writeback_to_connector(wb_connector);
>>>    	struct drm_mode_config *config = &dev->mode_config;
>>>    	struct drm_property_blob *blob;
>>>    	int ret = create_writeback_properties(dev); @@ -275,7 +276,7 @@ int
>>> drm_writeback_connector_init(struct drm_device *dev,
>>>    				 struct drm_encoder *enc,
>>>    				 const u32 *formats, int n_formats)
>>>    {
>>> -	struct drm_connector *connector = &wb_connector->base;
>>> +	struct drm_connector *connector =
>>> +drm_writeback_to_connector(wb_connector);
>> FYI: I missed this before but drm_writeback_connector_init needs to be
>> removed. The whole point of Dmitry's patch set is to switch to drmm instead of
>> drm init/alloc functions. I don't think it really affects this patch set much. But I
>> believe the last version of the i915/Xe writeback support was still using the
>> manual memory management interface via this function. That will need
>> updating to use the drmm version.
>>
> I think from the last revision of Dmitry's patch series we are currently not use drmm versions
> At least for now
>
> Regards,
> Suraj Kandpal
>
Yeah, the drmm route was proving too complex. Too many tangles too 
unravel all at once. It still seems like a better way to go, but that 
can wait until later. Getting something functional landed now and 
polishing it later is better than never getting anything merged at all.

John.

