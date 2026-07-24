Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744F4C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED7910E471;
	Fri, 24 Jul 2026 21:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="j56e5YdY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6758210E471
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 21:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=VKPr7vt+/ZwyDQp920dmlLEI+tbeADMcslQoDZaKawA=; b=j56e5YdYvT7826UljtTaiBw8Ah
 pIysMN0gWd+XV30RwwsxCBP88ljLT6uvgE8fiW8ac4k1rjwUsnV+HMPQr6zT/8J3K+yboVokhlx2s
 mEXxf+iPO1l9zr8WSMytt7Z9IWM4x8Du+QsG5vnzComhkw+FURyvNTb8ZxHKkO2PicbR7ZTKNjuiZ
 +q6fLldOeq+Y3lcz51Yj0fbvu9q7844JT0ZDHu+wF3Vr3dxlWVGf6CzCs8NEjqdxLk0/H9uVG9aF8
 zCxDKLSUd3pAUxqDdEIxaOXMg2vadHgNO6Pin/eomuZi/CYGXxER2J2trCwa/kjt42uBvvR6tvyJP
 Q4fPYsCw==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wnNPK-00597v-9P; Fri, 24 Jul 2026 23:26:14 +0200
Message-ID: <c05bed0f-81aa-4e55-820a-cc72c1715c43@Igalia.com>
Date: Fri, 24 Jul 2026 14:26:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/8] drm/amd/display: use
 drmm_writeback_connector_init()
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260723003205.330362-1-John.Harrison@Igalia.com>
 <20260723003205.330362-4-John.Harrison@Igalia.com>
 <20260723005320.BE8621F000E9@smtp.kernel.org>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20260723005320.BE8621F000E9@smtp.kernel.org>
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

On 7/22/26 17:53, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Medium] Mismatched object lifetimes in KUnit test causes Use-After-Free when DRM device is torn down.
>
> Pre-existing issues:
> - [High] The struct dc_writeback_info allocated dynamically in dm_set_writeback() is leaked on every successful writeback job setup.
> --
>
> --- Patch [3]: [PATCH v8 3/8] drm/amd/display: use drmm_writeback_connector_init() ---
> commit 4cc9223584993bb5748e535854c7b5fb0eba8f0d
> Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>
> drm/amd/display: use drmm_writeback_connector_init()
>
> The driver uses drmm_writeback_connector_init() to ensure proper job queue
> cleanup. It also allocates a simple encoder using drmm_plain_encoder_alloc()
> for the writeback connector.
>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 289da9d00b056..ff7b21830fce9 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -5048,7 +5048,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
>>   		return;
>>   	}
>>   
>> -	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
>> +	acrtc = to_amdgpu_crtc(crtc_state->base.crtc);
>>   	if (!acrtc) {
>>   		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
>>   		kfree(wb_info);
> [Severity: High]
> This isn't a bug introduced by this patch, but does dm_set_writeback() leak
> the dynamically allocated wb_info struct on success?
>
> When userspace configures a writeback job, wb_info is allocated dynamically
> using kzalloc_obj(). It is then passed to dc_stream_add_writeback():
>
> 	dc_stream_add_writeback(dm->dc, crtc_state->stream, wb_info);
>
> 	acrtc->wb_conn = wb_conn;
> 	drm_writeback_queue_job(wb_conn, new_con_state);
>
> However, dc_stream_add_writeback() copies the contents by value into an array
> (stream->writeback_info[...] = *wb_info) but does not take ownership of the
> pointer.
>
> The function then returns without ever calling kfree(wb_info) on the success
> path, which seems to result in a memory leak on every successful writeback
> job setup.
>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>> index 9e7bad4d6ed0c..2bb86218e80b0 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> [ ... ]
>
>> @@ -197,17 +196,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
>>   	struct dc *dc = dm->dc;
>>   	struct dc_link *link = dc_get_link_at_index(dc, link_index);
>>   	int res;
>> +	struct drm_encoder *encoder;
>> +
>> +	encoder = drmm_plain_encoder_alloc(&dm->adev->ddev, NULL,
>> +					   DRM_MODE_ENCODER_VIRTUAL, NULL);
>> +	if (IS_ERR(encoder))
>> +		return PTR_ERR(encoder);
>> +
>> +	drm_encoder_helper_add(encoder, &amdgpu_dm_wb_encoder_helper_funcs);
>> +
>> +	encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(dm->adev);
>>   
>>   	wbcon->link = link;
>>   
>>   	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
>>   
>> -	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
>> +	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
>>   					    &amdgpu_dm_wb_connector_funcs,
>> -					    &amdgpu_dm_wb_encoder_helper_funcs,
>> +					    encoder,
>>   					    amdgpu_dm_wb_formats,
>> -					    ARRAY_SIZE(amdgpu_dm_wb_formats),
>> -					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
>> +					    ARRAY_SIZE(amdgpu_dm_wb_formats));
> [Severity: Medium]
> Can this conversion to drmm_writeback_connector_init() cause a use-after-free
> in the KUnit tests during DRM device teardown?
>
> In the KUnit test dm_test_wb_connector_init_success(), the mock DRM device is
> allocated via dm_kunit_alloc_adev() (which registers a KUnit cleanup action).
> The test object wbcon is then allocated using kunit_kzalloc():
>
> 	wbcon = kunit_kzalloc(test, sizeof(*wbcon), GFP_KERNEL);
> 	KUNIT_ASSERT_NOT_NULL(test, wbcon);
>
> 	ret = amdgpu_dm_wb_connector_init(dm, wbcon, 0);
>
> Because KUnit cleanup actions run in LIFO order, when the test completes, it
> first frees wbcon via kfree(), and then tears down the mock DRM device.
>
> The device teardown triggers the drmm cleanup action registered by this patch
> (drm_writeback_connector_cleanup), which will dereference the already-freed
> wbcon to lock job_lock and iterate job_queue.
The KUnit issue is actually not something introduced by this patch. It 
is pre-existing and is broken for many tests. The above change is 
actually required in order to fix the writeback specific issue (together 
with a change to the KUnit test code). See 
https://patchwork.freedesktop.org/series/171029/ for the general KUnit 
fixes. The writeback specific one will be fixed with yet another rev of 
this patch set.

John.

>

