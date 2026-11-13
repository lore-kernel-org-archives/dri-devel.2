Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F86606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mUe4snAL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0D0110E7F3;
	Fri, 13 Nov 2026 13:43:28 +0000 (UTC)
Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF0AA10EBEE
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:15:39 +0000 (UTC)
Received: by mail-wm2-f5.google.com with SMTP id
 5b1f17b1804b1-4a35e178418so1425095e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794528938; x=1795133738; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7/bS5xYsjMkVnYMzljD0H/p8sgP2J5T4P4gKE/iJBI4=;
 b=mUe4snALMNDdRctpiJYsSSXiZ5pf2c/XfO4IZdJ/Y6xgMen+eBDVDVDl5RpC8J5tko
 3AVpWkAmAOaaghcDfuzca9FXGVU/kTmbKXBmAMCYjYJfl8uy0GwH+J4rnOmWzpk9v0rQ
 GZMT77Kku/eheEG2WH/bNZMNi4EEyjyWzz2HenlZh3Z2kpwCAwJTSbL54yijiL9sj3i0
 e1qjvSpwOXc4uPfNIc7Bbkm+rG4jD04cyrZeBfquFxMkBMXkxFvgnHfNbwmUFNol2VH4
 gs9euvG5jHpCusQ/9z2Gv6n3fWxr9MtYFm5uRBOm3wjUGIZLKVmmYkNiKx8kw+Ep9e9w
 ylhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794528938; x=1795133738;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7/bS5xYsjMkVnYMzljD0H/p8sgP2J5T4P4gKE/iJBI4=;
 b=HPlv7jeoBCSXHxBzEUy45n8QdMMGHYZDqYqN6YOUSLAagFMzPstYQk2tD56PA3Uaqq
 fRHwL23qaHVLG7igkTH1jYoXyJSpNxxoOoKiihIrCOu8ocROEw30Em6znoZALhi7+pPV
 sUW8Y0O6/5RyIhUGfZFSirei1GxNf15LBE/FYiERtbEOlHcyTHyKmLNwUfMJsIi+MIuc
 MFbu1AtWPLL+bjqGP0gCljElWtC120ff1Id6FIcF0Cot7xup6a6TQ7s0+lpq4AL/kohR
 DqM3TJ0pIktj3K/YRbQY04Q7vSLHEXBY9ODe0wKJ/YKsU+Ow9J7uA6Wi1maCKh6UETxC
 T4sA==
X-Forwarded-Encrypted: i=1;
 AL+hErE0li/k6hZNHRimVMmeS66cYOnQfX2B5vx7hwwyA7es1DXPZFD4xK6VT170oR+5i1ZHkfAT25jkJnQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/+FB6izxEXeWeisKbS7j7w3we0xUW//IdBxfLeWBKqJKoblUtx
 t12BtiXYm7ymUm1Sj8keDJvedcEuKhD1VYFjb2To2XQNwu0UbZpPiyxj
X-Gm-Gg: AYBFou03sDz7eI1Nr3Db639gRaj7O3LOAuf7MdgYeZo115BghIoEly2AEb0Jx1sAXFh
 BlF2uWjbzkd/x78CT4gGw9BP6XesRua52P4LtQAAkfsTvuKnDO3FtXEr/bAZ2ns90qVSjLsFBD8
 4wAK8zgQhMp9QkyxuBMCvQ7+JtbNnZyCco3wNPMzBFkueDTkUrdl/5Q8cSTR3xnpxln4dTd3DmY
 H19kANV9BJklr3ANJgFNAvih4bg4s44wGbR919o7IMU5uE2AowupEV/5qymUVIXBSVdhFdd4o4j
 dpCP//MQTRcInNmcja7WO8UJjje0ZDlBqN7aBIIt1+bC3sxZo3f+UDs745G2SxMdohsCCGBvMwx
 eism09bivtYQnSD2eFbyrFgary45L9ZJ6h2juOgpWw5XCqRMQl8otneCTLFhfWSG4IwI26Ar+fG
 xZskPBHphPK2aW2gY4vnG5/OHsoZ8mD0oobf7MI/vlt/QiIPZ1hSAVwWM5EJh2v1G4RGUS2K6vo
 Mk/VXl89bylLEjAaQ/ZhhnBu+Qqb9/6qhiXp0DMScKU/ZEjU5rD9pu6WjOXfLUEbUFhHoJtlDBK
 +mfELKBmYa3Ce/e37UBmqaX+o37050MUYZJ4
X-Received: by 2002:a05:600c:8b66:b0:4a4:7a8d:c436 with SMTP id
 5b1f17b1804b1-4bb55c5f567mr16787315e9.11.1794528937859; 
 Thu, 12 Nov 2026 16:15:37 -0800 (PST)
Received: from [192.168.1.7] ([31.94.68.191]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb52bab8bbsm52641475e9.13.2026.11.12.16.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 16:15:35 -0800 (PST)
Message-ID: <b9f69d90-73ef-4a22-a347-0d70f014a7de@gmail.com>
Date: Fri, 13 Nov 2026 00:15:33 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amd/display: report synced displays to
 PowerPlay for MCLK switch
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <8eb61179-c5b8-41df-a466-8b5c388b6b41@gmail.com>
 <CADnq5_OrGuMJT4Tvt+wktPzTYEopdkCjyqq8sSdvJou40-HoKw@mail.gmail.com>
 <a6093dab-c38d-4dad-af3b-7173a6eaa78c@gmail.com>
 <CADnq5_MRA2bQG5x9xiGAT5ddh0jHMqg=u2OhCPvJxPr3ddTurA@mail.gmail.com>
Content-Language: en-US
From: Richard Lane <richardlanedev@gmail.com>
In-Reply-To: <CADnq5_MRA2bQG5x9xiGAT5ddh0jHMqg=u2OhCPvJxPr3ddTurA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/11/2026 19:59, Alex Deucher wrote:
> On Tue, Nov 10, 2026 at 1:49 PM Richard Lane <richardlanedev@gmail.com> wrote:
>>
>> On 09/11/2026 20:34, Alex Deucher wrote:
>>> On Mon, Nov 2, 2026 at 3:31 AM Richard Lane <richardlanedev@gmail.com> wrote:
>>>>
>>>> When driving multiple displays or tiled panels with identical timings
>>>> (such as the two 2560x2880 tiles of an Apple 5K iMac panel), Display
>>>> Core's program_timing_sync() aligns the CRTCs into a timing sync group
>>>> in hardware during dc_commit_streams().
>>>>
>>>> However, on DCE < 12, Display Core leaves
>>>> pp_display_cfg.all_displays_in_sync unset. Because PowerPlay is not
>>>> informed that the streams have synchronized vertical blanking intervals,
>>>> SMU7 prevents MCLK switching at idle or causes modeset underflows.
>>>>
>>>> If all active streams belong to the same timing sync group
>>>> (timing_sync_info.group_size == params.stream_count), report
>>>> all_displays_in_sync = true to PowerPlay after committing the streams so
>>>> SMU7 can safely downclock MCLK at idle.
>>>>
>>>
>>> Looking at this a little deeper, the function bw_calcs() in
>>> dce_calcs.c already calculates all_displays_in_sync using the helper
>>> all_displays_in_sync().  Can you look into this and figure out why
>>> that is not working as expected?  My concern with this patch is that
>>> DCE and DCN have different logic for handling mclk switching so I'm
>>> not sure it's safe to call dm_pp_apply_display_requirements() directly
>>> from common code.
>>>
>>> Thanks,
>>>
>>> Alex
>>
>> Moving it to dce_clk_mgr.c and using resource_are_streams_timing_synchronizable() also works. Is that a solution?
> 
> I think that would be preferred, but in general, why doesn't the
> current flow I described work?  The function bw_calcs() dce_calcs.c
> already calculates the all_displays_in_sync flag using the helper
> all_displays_in_sync().  Is all_displays_in_sync() not checking
> something properly or is the overall call timing wrong such that
> all_displays_in_sync() can't properly calculate whether all of the
> displays are synced at the point that it gets called?
> 
> Alex
> 

I think this could be limited to DCE 6,8,10 rather than DCE < 12 as in these
cases DC uses dce100_validate_bandwdith() which doesn't call bw_calcs() and
dce_pplib_apply_display_requirements() in dce_clk_mgr.c so
pp_display_cfg->all_displays_in_sync is unset.

Richard

>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
>> @@ -31,6 +31,7 @@
>>  #include "dmcu.h"
>>  #include "core_types.h"
>>  #include "dal_asic_id.h"
>> +#include "resource.h"
>>
>>  /*
>>   * Currently the register shifts and masks in this file are used for dce100 and dce80
>> @@ -319,8 +320,17 @@ static void dce_pplib_apply_display_requirements(
>>         struct dc_state *context)
>>  {
>>         struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
>> +       int j;
>>
>>         dce110_fill_display_configs(context, pp_display_cfg);
>> +       pp_display_cfg->all_displays_in_sync = pp_display_cfg->display_count > 1;
>> +       for (j = 1; j < context->stream_count; j++) {
>> +               if (!resource_are_streams_timing_synchronizable(
>> +                           context->streams[0], context->streams[j])) {
>> +                       pp_display_cfg->all_displays_in_sync = false;
>> +                       break;
>> +               }
>> +       }
>>
>>         if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
>>                 dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
>>
>> Richard
>>
>>>
>>>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
>>>> ---
>>>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
>>>>  1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> index 74cd88d8d580..b4531383437e 100644
>>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>>> @@ -4777,6 +4777,16 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
>>>>         dc_exit_ips_for_hw_access(dm->dc);
>>>>         WARN_ON(!dc_commit_streams(dm->dc, &params));
>>>>
>>>> +       if (params.stream_count > 1 &&
>>>> +           dm->dc->current_state->stream_status[0].timing_sync_info.group_size ==
>>>> +           params.stream_count) {
>>>> +               struct dm_pp_display_configuration *pp_cfg =
>>>> +                       &dm->dc->current_state->pp_display_cfg;
>>>> +
>>>> +               pp_cfg->all_displays_in_sync = true;
>>>> +               dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg);
>>>> +       }
>>>> +
>>>>         bool frl_stream_found = false;
>>>>
>>>>         for (i = 0; i < params.stream_count; i++) {
>>>> --
>>>> 2.55.0
>>

