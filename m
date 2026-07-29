Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C3DC54FDF
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 21:24:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9574A10E4AF;
	Wed, 29 Jul 2026 21:24:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gK9XdN17";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B45610E2DE;
 Wed, 29 Jul 2026 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=NlAIwGtgFUDthsMkLBSqC+8ZDzTAilxZLPSzL/QwiWo=; b=gK9XdN17Px8Z/dBviZlyjLF5+Y
 RQcq6YgGXjJc5VmYpqFspaDEhofquOG5ABMZ8U3kjPjjNv2kcvvDdiLK+WRtS/pgXhHIfjnyoPDzo
 u9HSTu1P0ZE3H1cognIR6ogGSYmK9uIscbdFafFDhbs8KJjrATFuSqZCrE0pldWJi+5sUDMn3Omv1
 RM87+WHYlSy5NUtZ/EAEsFoNO49HcpFBc0ZDrmnOlEBTGdJz1Qo4BeagMnkojtfYfCCGepj/23hHS
 cIaiFooQ7dDqbLLORSRUVDKAUFs0rYTf7t0yJ/akwLiQZnLUs8wSnYDGn6itdOGxyH/oeQlASDWUu
 4jfS07TQ==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wpBlE-007gTv-6P; Wed, 29 Jul 2026 23:24:20 +0200
Message-ID: <9143dbcd-84ff-4210-9c8a-8054e5dc6bf9@Igalia.com>
Date: Wed, 29 Jul 2026 14:24:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix use-after-free bugs in KUnit tests
To: Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Harry Wentland <harry.wentland@amd.com>
References: <20260723233548.580891-1-John.Harrison@Igalia.com>
 <b43b52a3-9577-4e39-94db-75fd7f62c3ad@amd.com>
 <0dcfdc1a-cae8-403b-acff-01cc65bb0846@Igalia.com>
 <37d52d4e-7f4c-4467-83b5-99ccf6f73558@amd.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <37d52d4e-7f4c-4467-83b5-99ccf6f73558@amd.com>
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

On 7/24/26 14:36, Alex Hung wrote:
> On 7/24/26 15:09, John Harrison wrote:
>> On 7/24/26 12:37, Alex Hung wrote:
>>> Reviewed-by: Alex Hung <alex.hung@amd.com>
>>>
>>> With two comments:
>>> 1. There is a minor conflicts on include
>>> 2. The following code seems to have the same patterns (passing to 
>>> drmm_* functions). Do they need to be changed too?
>> None of those functions exist in my tree. Which might also explain 
>> the include conflict. I'm using drm-tip fetched the same day I posted 
>> the patch. Should I be basing the patch on a different tree?
>
> My bad. My local branch contains additional patches.
>
> I will create a patch for this four additional changes. Thanks for 
> pointing this out.
Can this patch be merged? It would be good to get the existing issues fixed.

Thanks,
John.

>
>>
>> John.
>>
>>
>>>
>>>
>>> --- drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>> amdgpu_dm_connector_test.c
>>> +++ drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>> amdgpu_dm_connector_test.c
>>> @@ -3645,7 +3645,7 @@ static struct dm_test_stream_ctx 
>>> *dm_test_stream_ctx_alloc(struct kunit *test)
>>> DRIVER_MODESET);
>>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
>>>
>>> -       ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx- 
>>> >aconnector), GFP_KERNEL);
>>> +       ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx- 
>>> >aconnector), GFP_KERNEL);
>>>         KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
>>>         KUNIT_ASSERT_EQ(test,
>>>                 drmm_connector_init(ctx->drm, &ctx->aconnector->base,
>>> @@ -3903,7 +3903,7 @@ static void 
>>> dm_test_poll_dac_load_returns_cached(struct kunit *test)
>>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>         adev = drm_to_adev(drm);
>>>
>>> -       aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>> GFP_KERNEL);
>>> +       aconnector = drmm_kzalloc(drm, sizeof(*aconnector), 
>>> GFP_KERNEL);
>>>         KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>         KUNIT_ASSERT_EQ(test,
>>>                 drmm_connector_init(drm, &aconnector->base,
>>> @@ -3950,7 +3950,7 @@ static struct amdgpu_dm_connector 
>>> *dm_test_reg_connector(struct kunit *test)
>>> DRIVER_MODESET);
>>>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>
>>> -       aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>> GFP_KERNEL);
>>> +       aconnector = drmm_kzalloc(drm, sizeof(*aconnector), 
>>> GFP_KERNEL);
>>>         KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>         KUNIT_ASSERT_EQ(test,
>>>                 drmm_connector_init(drm, &aconnector->base,
>>> @@ -4405,7 +4405,7 @@ dm_test_modes_ctx_alloc(struct kunit *test, 
>>> int connector_type)
>>>         ctx->drm = dm_test_alloc_drm(test);
>>>         ctx->aconnector = dm_test_add_connector(test, ctx->drm, 
>>> connector_type);
>>>
>>> -       ctx->aenc = kunit_kzalloc(test, sizeof(*ctx->aenc), 
>>> GFP_KERNEL);
>>> +       ctx->aenc = drmm_kzalloc(ctx->drm, sizeof(*ctx->aenc), 
>>> GFP_KERNEL);
>>>         KUNIT_ASSERT_NOT_NULL(test, ctx->aenc);
>>>         KUNIT_ASSERT_EQ(test,
>>>                         drmm_encoder_init(ctx->drm, 
>>> &ctx->aenc->base, NULL,
>>>
>>>
>>> On 7/23/26 17:35, John Harrison wrote:
>>>> When running the KUnit tests with memory debugging enabled, a bunch of
>>>> use-after-free errors are hit. These are due to using KUnit managed
>>>> memory for the test objects but then giving them over to DRM managed
>>>> objects. The KUnit stuff is deallocated first and when the DRM side
>>>> calls its clean up helpers, it hits memory that has been freed 
>>>> already.
>>>>
>>>> NB: There is still a use-after-free bug in the writeback tests.
>>>> However, fixing that requires driver side changes as well as test side
>>>> changes. Those changes are part of:
>>>>    https://patchwork.freedesktop.org/series/152420/
>>>>
>>>> Signed-off-by: John Harrison <John.Harrison@Igalia.com>
>>>> CC: Alex Hung <alex.hung@amd.com>
>>>> CC: Harry Wentland <harry.wentland@amd.com>
>>>> ---
>>>>   .../tests/amdgpu_dm_connector_test.c          | 37 
>>>> ++++++++++---------
>>>>   .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |  3 +-
>>>>   .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |  5 ++-
>>>>   3 files changed, 24 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>> amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/ 
>>>> tests/amdgpu_dm_connector_test.c
>>>> index 0a5d439f66c3..93a854d4fdfa 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>> amdgpu_dm_connector_test.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>> amdgpu_dm_connector_test.c
>>>> @@ -12,6 +12,7 @@
>>>>   #include <drm/drm_crtc.h>
>>>>   #include <drm/drm_edid.h>
>>>>   #include <drm/drm_kunit_helpers.h>
>>>> +#include <drm/drm_managed.h>
>>>>   #include <drm/drm_mode_object.h>
>>>>   #include <drm/drm_property.h>
>>>>   #include <linux/hdmi.h>
>>>> @@ -1449,7 +1450,7 @@ static void 
>>>> dm_test_funcs_reset_sets_defaults(struct kunit *test)
>>>>                              DRIVER_MODESET);
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), 
>>>> GFP_KERNEL);
>>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>>         drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>>>> @@ -1488,7 +1489,7 @@ static void 
>>>> dm_test_funcs_reset_edp_abm_level(struct kunit *test)
>>>>                              DRIVER_MODESET);
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), 
>>>> GFP_KERNEL);
>>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>>         drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>>>> @@ -1526,7 +1527,7 @@ static void 
>>>> dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
>>>>                              DRIVER_MODESET);
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), 
>>>> GFP_KERNEL);
>>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>>         drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>>>> @@ -1568,7 +1569,7 @@ static void 
>>>> dm_test_atomic_dup_state_copies_fields(struct kunit *test)
>>>>                              DRIVER_MODESET);
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), 
>>>> GFP_KERNEL);
>>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>>         drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>>>> @@ -2359,8 +2360,8 @@ static void setup_panel_type_fixture(struct 
>>>> kunit *test,
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->drm);
>>>>       fixture->adev = drm_to_adev(fixture->drm);
>>>>   -    fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture- 
>>>> >aconnector),
>>>> -                        GFP_KERNEL);
>>>> +    fixture->aconnector = drmm_kzalloc(fixture->drm, 
>>>> sizeof(*fixture->aconnector),
>>>> +                       GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
>>>>       fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), 
>>>> GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
>>>> @@ -2554,9 +2555,9 @@ static void 
>>>> dm_test_update_subconnector_dp_with_sink(struct kunit *test)
>>>>                              DRIVER_MODESET);
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>>> GFP_KERNEL);
>>>> +    aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>> -    link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
>>>> +    link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, link);
>>>>         drmm_connector_init(drm, &aconnector->base, 
>>>> &dm_test_connector_funcs,
>>>> @@ -2598,9 +2599,9 @@ static void 
>>>> dm_test_update_subconnector_dp_no_sink(struct kunit *test)
>>>>                              DRIVER_MODESET);
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>>> GFP_KERNEL);
>>>> +    aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>> -    link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
>>>> +    link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, link);
>>>>         drmm_connector_init(drm, &aconnector->base, 
>>>> &dm_test_connector_funcs,
>>>> @@ -2641,9 +2642,9 @@ static void 
>>>> dm_test_update_subconnector_non_dp_noop(struct kunit *test)
>>>>                              DRIVER_MODESET);
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>>> GFP_KERNEL);
>>>> +    aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>> -    link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
>>>> +    link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, link);
>>>>         drmm_connector_init(drm, &aconnector->base, 
>>>> &dm_test_connector_funcs,
>>>> @@ -2657,7 +2658,7 @@ static void 
>>>> dm_test_update_subconnector_non_dp_noop(struct kunit *test)
>>>>         link->dpcd_caps.dongle_type = 
>>>> DISPLAY_DONGLE_DP_HDMI_CONVERTER;
>>>>       aconnector->dc_link = link;
>>>> -    aconnector->dc_sink = kunit_kzalloc(test, sizeof(*aconnector- 
>>>> >dc_sink), GFP_KERNEL);
>>>> +    aconnector->dc_sink = drmm_kzalloc(drm, sizeof(*aconnector- 
>>>> >dc_sink), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
>>>>         update_subconnector_property(aconnector);
>>>> @@ -2804,7 +2805,7 @@ static struct amdgpu_dm_connector 
>>>> *dm_test_add_connector(struct kunit *test,
>>>>   {
>>>>       struct amdgpu_dm_connector *aconnector;
>>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>>> GFP_KERNEL);
>>>> +    aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>>         KUNIT_ASSERT_EQ(test,
>>>> @@ -3103,7 +3104,7 @@ static struct dm_test_panel_ctx 
>>>> *dm_test_panel_ctx_alloc(struct kunit *test)
>>>>       KUNIT_ASSERT_NOT_NULL(test, prop);
>>>>       ctx->drm->mode_config.panel_type_property = prop;
>>>>   -    ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx- 
>>>> >aconnector), GFP_KERNEL);
>>>> +    ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx- 
>>>> >aconnector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
>>>>       KUNIT_ASSERT_EQ(test,
>>>>           drmm_connector_init(ctx->drm, &ctx->aconnector->base,
>>>> @@ -3112,7 +3113,7 @@ static struct dm_test_panel_ctx 
>>>> *dm_test_panel_ctx_alloc(struct kunit *test)
>>>> drm_object_attach_property(&ctx->aconnector->base.base, prop,
>>>>                      DRM_MODE_PANEL_TYPE_UNKNOWN);
>>>>   -    ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), 
>>>> GFP_KERNEL);
>>>> +    ctx->link = drmm_kzalloc(ctx->drm, sizeof(*ctx->link), 
>>>> GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->link);
>>>>       ctx->aconnector->dc_link = ctx->link;
>>>>   @@ -3376,14 +3377,14 @@ static struct dm_test_fill_ctx 
>>>> *dm_test_fill_ctx_alloc(struct kunit *test)
>>>>                                  DRIVER_MODESET);
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
>>>>   -    ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx- 
>>>> >aconnector), GFP_KERNEL);
>>>> +    ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx- 
>>>> >aconnector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
>>>>       KUNIT_ASSERT_EQ(test,
>>>>           drmm_connector_init(ctx->drm, &ctx->aconnector->base,
>>>>                       &dm_test_connector_funcs,
>>>>                       DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
>>>>   -    ctx->conn_state = kunit_kzalloc(test, sizeof(*ctx- 
>>>> >conn_state), GFP_KERNEL);
>>>> +    ctx->conn_state = drmm_kzalloc(ctx->drm, sizeof(*ctx- 
>>>> >conn_state), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->conn_state);
>>>>       ctx->stream = kunit_kzalloc(test, sizeof(*ctx->stream), 
>>>> GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, ctx->stream);
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>> amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/ 
>>>> tests/amdgpu_dm_kunit_helpers.c
>>>> index 58615cdbe854..7d5e3823b33b 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>> amdgpu_dm_kunit_helpers.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>> amdgpu_dm_kunit_helpers.c
>>>> @@ -8,6 +8,7 @@
>>>>   #include <kunit/test.h>
>>>>   #include <linux/module.h>
>>>>   #include <drm/drm_kunit_helpers.h>
>>>> +#include <drm/drm_managed.h>
>>>>     #include "dc.h"
>>>>   #include "core_types.h"
>>>> @@ -127,7 +128,7 @@ struct amdgpu_dm_connector 
>>>> *dm_kunit_alloc_connector(struct kunit *test,
>>>>   {
>>>>       struct amdgpu_dm_connector *aconnector;
>>>>   -    aconnector = kunit_kzalloc(test, sizeof(*aconnector), 
>>>> GFP_KERNEL);
>>>> +    aconnector = drmm_kzalloc(adev_to_drm(adev), 
>>>> sizeof(*aconnector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, aconnector);
>>>>         if (adev)
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>> amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/ 
>>>> amdgpu_dm_wb_test.c
>>>> index b43bc244487e..3454cf371414 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
>>>> @@ -12,6 +12,7 @@
>>>>   #include <drm/drm_fourcc.h>
>>>>   #include <drm/drm_framebuffer.h>
>>>>   #include <drm/drm_kunit_helpers.h>
>>>> +#include <drm/drm_managed.h>
>>>>   #include <drm/drm_mode.h>
>>>>   #include <drm/drm_modes.h>
>>>>   #include <drm/drm_writeback.h>
>>>> @@ -266,7 +267,7 @@ static void 
>>>> dm_test_wb_get_modes_returns_modes(struct kunit *test)
>>>>                              DRIVER_MODESET | DRIVER_ATOMIC);
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), 
>>>> GFP_KERNEL);
>>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>>         drmm_connector_init(drm, connector, 
>>>> &dm_wb_test_connector_funcs,
>>>> @@ -301,7 +302,7 @@ static void 
>>>> dm_test_wb_get_modes_bounded_by_max(struct kunit *test)
>>>>                              DRIVER_MODESET | DRIVER_ATOMIC);
>>>>       KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>>>>   -    connector = kunit_kzalloc(test, sizeof(*connector), 
>>>> GFP_KERNEL);
>>>> +    connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>>>>       KUNIT_ASSERT_NOT_NULL(test, connector);
>>>>         drmm_connector_init(drm, connector, 
>>>> &dm_wb_test_connector_funcs,
>>>
>>
>

