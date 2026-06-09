Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613B5CD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 18:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE4CA10E5B0;
	Tue,  9 Jun 2026 18:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qaJnOM4x";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CCA010E5B0;
 Tue,  9 Jun 2026 18:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jmQG5WeeSfeQ4cMKQ+NS5lS+P+mvFzUDCDF4Y0YvZF4=; b=qaJnOM4xPbHRuRrA/5QhuyqXHT
 wioW2PB9MmIR2QLo77PGoDvfr+ictJoxPSLT/QZjD6bsNqfkL2bqt6rTL+dheMHsMnmoazrGhQ4Xq
 0o586vrmwRQCh0mF0oAkLmSOV6KsTsOCbjQJt5VPrjUvCjbyxbM1McFV6KW7qI01QHp45/Y77vs95
 cUoG4SX2evcoqrSl6MLoC+uEqVbU26jWNngzJ97UXJ3fmNKp2VhBtDBSJTbF8FKDs5HQXoagkG0D3
 qxRL6ws+ZNIZ3vTUpQlU9HI55lkDtsS9Wc2cJ0GUHRBdRWgzo0e5lldN5FQ3lJNQkaFv0YK/Xl4e9
 SM4geRnA==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wX0rj-00F6Ah-JX; Tue, 09 Jun 2026 20:07:55 +0200
Message-ID: <23cc1a03-39a6-4cc3-86ca-0d7c914ee40d@Igalia.com>
Date: Tue, 9 Jun 2026 11:07:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] drm/amd/display: use
 drmm_writeback_connector_init()
To: Alex Hung <alex.hung@amd.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
 <20260505-wb-drop-encoder-v5-2-42567b7c7af2@oss.qualcomm.com>
 <27db214f-b57b-45ab-8deb-da2aa8efb9d7@amd.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <27db214f-b57b-45ab-8deb-da2aa8efb9d7@amd.com>
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

Ping @Dmitry - is there any progress with this patch set?

Thanks,
John.

On 5/26/26 11:46, Alex Hung wrote:
> Will allocating wbcon with drmm_kzalloc before calling 
> amdgpu_dm_wb_connector_init be more memory-safe as below?
>
>
> @@ -5790,7 +5791,8 @@ static int 
> amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>          link = dc_get_link_at_index(dm->dc, i);
>
>          if (link->connector_signal == SIGNAL_TYPE_VIRTUAL) {
> -            struct amdgpu_dm_wb_connector *wbcon = kzalloc_obj(*wbcon);
> +            struct amdgpu_dm_wb_connector *wbcon =
> +                drmm_kzalloc(adev_to_drm(adev), sizeof(*wbcon), 
> GFP_KERNEL);
>
>              if (!wbcon) {
>                  drm_err(adev_to_drm(adev), "KMS: Failed to allocate 
> writeback connector\n");
> @@ -5799,7 +5801,6 @@ static int 
> amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
>
>              if (amdgpu_dm_wb_connector_init(dm, wbcon, i)) {
>                  drm_err(adev_to_drm(adev), "KMS: Failed to initialize 
> writeback connector\n");
> -                kfree(wbcon);
>                  continue;
>              }
>
> On 5/4/26 18:24, Dmitry Baryshkov wrote:
>> The driver uses drm_writeback_connector_init() instead of its drmm
>> counterpart, but it doesn't perform the job queue cleanup (neither
>> manually nor by calling drm_writeback_connector_cleanup()). On the
>> contrary, the drmm_writeback_connector_init() function ensures the
>> proper cleanup of the job queue.
>>
>> Use drmm_plain_encoder_alloc() to allocate simple encoder and
>> drmm_writeback_connector_init() in order to initialize writeback
>> connector instance.
>>
>> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
>> Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> ---
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  2 +-
>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 18 
>> +++++++++++++-----
>>   2 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index e96a12ff2d31..2ac64495cdb7 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -10683,7 +10683,7 @@ static void dm_set_writeback(struct 
>> amdgpu_display_manager *dm,
>>           return;
>>       }
>>   -    acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
>> +    acrtc = to_amdgpu_crtc(crtc_state->base.crtc);
>>       if (!acrtc) {
>>           drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
>>           kfree(wb_info);
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>> index 110f0173eee6..fdc3da40452f 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>> @@ -169,7 +169,6 @@ static const struct drm_encoder_helper_funcs 
>> amdgpu_dm_wb_encoder_helper_funcs =
>>     static const struct drm_connector_funcs 
>> amdgpu_dm_wb_connector_funcs = {
>>       .fill_modes = drm_helper_probe_single_connector_modes,
>> -    .destroy = drm_connector_cleanup,
>>       .reset = amdgpu_dm_connector_funcs_reset,
>>       .atomic_duplicate_state = 
>> amdgpu_dm_connector_atomic_duplicate_state,
>>       .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>> @@ -188,17 +187,26 @@ int amdgpu_dm_wb_connector_init(struct 
>> amdgpu_display_manager *dm,
>>       struct dc *dc = dm->dc;
>>       struct dc_link *link = dc_get_link_at_index(dc, link_index);
>>       int res = 0;
>> +    struct drm_encoder *encoder;
>> +
>> +    encoder = drmm_plain_encoder_alloc(&dm->adev->ddev, NULL,
>> +                       DRM_MODE_ENCODER_VIRTUAL, NULL);
>> +    if (IS_ERR(encoder))
>> +        return PTR_ERR(encoder);
>> +
>> +    drm_encoder_helper_add(encoder, 
>> &amdgpu_dm_wb_encoder_helper_funcs);
>> +
>> +    encoder->possible_crtcs = 
>> amdgpu_dm_get_encoder_crtc_mask(dm->adev);
>>         wbcon->link = link;
>>         drm_connector_helper_add(&wbcon->base.base, 
>> &amdgpu_dm_wb_conn_helper_funcs);
>>   -    res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
>> +    res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
>>                           &amdgpu_dm_wb_connector_funcs,
>> -                        &amdgpu_dm_wb_encoder_helper_funcs,
>> +                        encoder,
>>                           amdgpu_dm_wb_formats,
>> -                        ARRAY_SIZE(amdgpu_dm_wb_formats),
>> - amdgpu_dm_get_encoder_crtc_mask(dm->adev));
>> +                        ARRAY_SIZE(amdgpu_dm_wb_formats));
>>         if (res)
>>           return res;
>>
>

