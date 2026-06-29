Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE6EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55E5510E0F4;
	Mon, 29 Jun 2026 21:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="SFrAqTJ7";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D8910E0F4
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 21:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=izJizNDApY+23qEKEsJqU5rP1tPC0fkmJ33zLpRJmnQ=; b=SFrAqTJ7BMFqGLN0W6511uUc3O
 dGUp0SuxPckwiPx54jXtsK60AUfIkMakANrx7sTOmVqiDTu2tQocDaZEXQq83gECAW7S2xl24krhG
 OHCdwMeRL0ConKLGKEbv+/M3wOVLoHz45rrIJu9i53iiPC/x77H7yRmznCPUMAwMNtR3F37wLi0JS
 N963gj2vebAF63jF5e3CaCl3JRepUt0gpfvhYrLXnDREuvqnmSx3WxZsxFtFpIFZpJ2FDruf4GiMR
 4/kjRF2nyViu342xIdfndoQc3vM0Mk+J/nPWMr4VTcMxk27rZS4dPebYVI5Vr0Eq53VllxL4xGSnn
 SMcwqUwA==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1weJRY-006nmn-1q; Mon, 29 Jun 2026 23:23:04 +0200
Message-ID: <a27c27aa-8323-4730-bfa6-26b1ae38f784@Igalia.com>
Date: Mon, 29 Jun 2026 14:22:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/9] drm/amd/display: use
 drmm_writeback_connector_init()
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: sashiko-reviews@lists.linux.dev, dri-devel@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com
References: <20260612-wb-drop-encoder-v6-3-9f3a54f81310@oss.qualcomm.com>
 <20260612185828.C0D241F00A3E@smtp.kernel.org>
 <e98e6632-20a1-4e76-a6e5-916066c7438a@Igalia.com>
 <eieq74qmqkkrgovktpon6umq2an3l6xmih2gqxjqtawmtvnesl@zpxepcxb3hm6>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <eieq74qmqkkrgovktpon6umq2an3l6xmih2gqxjqtawmtvnesl@zpxepcxb3hm6>
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

On 6/16/26 00:42, Dmitry Baryshkov wrote:
> On Mon, Jun 15, 2026 at 11:27:12AM -0700, John Harrison wrote:
>> On 6/12/26 11:58, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>>
>>> New issues:
>>> - [High] Dangling drmm cleanup action on writeback connector initialization error path leads to Use-After-Free, and possible build failure with drmm_kfree.
>>>
>>> Pre-existing issues:
>>> - [High] Pre-existing memory leak of `wb_info` and sleeping in atomic context in `dm_set_writeback()`.
>>> --
>>>
>>> commit 946e1af8401710237d25526b5d87b4357eceb542
>>> Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>>
>>> drm/amd/display: use drmm_writeback_connector_init()
>>>
>>> The patch converts the driver to use drmm_writeback_connector_init() and
>>> drmm_plain_encoder_alloc() to ensure proper cleanup of the writeback
>>> connector instance and its job queue.
>>>
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> [ ... ]
>>>> @@ -11086,7 +11086,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
>>>>    		return;
>>>>    	}
>>>> -	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
>>>> +	acrtc = to_amdgpu_crtc(crtc_state->base.crtc);
>>> [Severity: High]
>>> This is a pre-existing issue, but does dm_set_writeback() allocate memory
>>> using GFP_KERNEL in an atomic context?
>>>
>>> It appears that wb_info is allocated using kzalloc_obj() earlier in this
>>> function, which implicitly uses GFP_KERNEL. However, this function is called
>>> from amdgpu_dm_atomic_commit_tail(), which is an atomic context where sleeping
>>> functions are forbidden.
>>>
>>> Additionally, dc_stream_add_writeback() copies the contents of wb_info by
>>> value, but the originally allocated pointer seems to never be freed before
>>> dm_set_writeback() returns. Does this introduce a memory leak every time a
>>> writeback job is queued?
>>>
>>>>    	if (!acrtc) {
>>>>    		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
>>>>    		kfree(wb_info);
>>> [ ... ]
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
>>> [ ... ]
>>>> @@ -188,17 +187,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
>>>>    	struct dc *dc = dm->dc;
>>>>    	struct dc_link *link = dc_get_link_at_index(dc, link_index);
>>>>    	int res = 0;
>>>> +	struct drm_encoder *encoder;
>>>> +
>>>> +	encoder = drmm_plain_encoder_alloc(&dm->adev->ddev, NULL,
>>>> +					   DRM_MODE_ENCODER_VIRTUAL, NULL);
>>>> +	if (IS_ERR(encoder))
>>>> +		return PTR_ERR(encoder);
>>>> +
>>>> +	drm_encoder_helper_add(encoder, &amdgpu_dm_wb_encoder_helper_funcs);
>>>> +
>>>> +	encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(dm->adev);
>>>>    	wbcon->link = link;
>>>>    	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
>>>> -	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
>>>> +	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
>>>>    					    &amdgpu_dm_wb_connector_funcs,
>>>> -					    &amdgpu_dm_wb_encoder_helper_funcs,
>>>> +					    encoder,
>>>>    					    amdgpu_dm_wb_formats,
>>>> -					    ARRAY_SIZE(amdgpu_dm_wb_formats),
>>>> -					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
>>>> +					    ARRAY_SIZE(amdgpu_dm_wb_formats));
>>> [Severity: High]
>>> If drmm_writeback_connector_init() fails internally after successfully calling
>>> drmm_connector_init(), will it leave the drmm_connector_cleanup_action
>>> registered?
>> I'm not following this one. everything that drmm_writeback_connector_init()
>> does has a check on the return code and only if everything works does it
>> register the cleanup function as the last action. So how do you get a
>> dangling anything?
>>
>>> The caller, amdgpu_dm_initialize_drm_device(), appears to handle this failure
>>> by attempting to free the connector using drmm_kfree(). Since drmm_kfree()
>>> requires a dev argument, will this missing argument result in a build failure?
>> Bizarre that it is complaining about something in a totally different patch.
>>
>>> More importantly, since drmm_kfree() frees the memory but does not unregister
>>> actions, will the managed resource list later execute
>>> drmm_connector_cleanup_action on the already-freed pointer, resulting in a
>>> use-after-free when the DRM device is torn down?
>> Isn't this just lying? The whole point of drmm_kfree() is surely that it
>> does unregister the cleanup of the allocation?
> The question is not about freeint the memory, but about unrolling the
> connector registration. I'll take a look later whether Sashiko is
> hallucinating or not
Any updates on this patch set?

I think sashiko is hallucinating at least some of the above. The comment 
about drmm_kfree not unregistering is definitely bogus - because 
drmm_kfree certainly should unregister the cleanup action for the 
allocation being freed. Or maybe it is simply confused and is actually 
meaning the unregister action for wbconn->base rather than for wbconn 
itself. In which case, obviously it is not going to unregister the 
cleanup action for a different object entirely.

And presumably it is meaning "drm_writeback_connector_cleanup" when it 
says "drmm_connector_cleanup_action", given that the latter does not 
exist! But as already noted, that cleanup action is registered as the 
very last operation in the init sequence. So if the action has been 
registered then there will be no cleanup or roll back required because 
everything has succeeded. And at unload time, actions are run in reverse 
order of registration so the connector cleanup action will be run before 
the wbconn memory is freed.

John.


>
>>>>    	if (res)
>>>>    		return res;

