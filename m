Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B231D606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bC/Pmr2j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B4410E7CA;
	Thu, 29 Oct 2026 08:03:12 +0000 (UTC)
Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A27610E720
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 23:39:01 +0000 (UTC)
Received: by mail-wr2-f1.google.com with SMTP id
 ffacd0b85a97d-48e3465b262so518838f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793230739; x=1793835539; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mUL9IvXJL2MT47NNFUWayhQpuNRP/QLpFWYDoVd8+3Y=;
 b=bC/Pmr2joeJoeC+gKP0Y4XfoQ1/g7BpLuTk5G85vEIwOOxu6Elp3AWR44fWvZFtRsy
 NiBC1zudoqfVydEnoTTEpE2Lcbej3O437KDxd1XaOTWco5rPttRmGBwEMyCkqi9pvu4K
 I/KwNI7RTS/M6NJ+V5Hf056tTRX/a5D9xwWgsxykj3kakMEnt+GX1mCRM11Wpi5jGcEC
 yoXTJ6Auzjdl4iu3XTdmMajXqH4LP/nMQpE+p3Q4/qzfjtoEGb1NAGthHQkeuv38wECU
 KzSrzUj90NwVYilP13xXN3u9Yx0PJSvtiDMeNPUOIqObcfeHi9nXbTDidGRGz0YibyIr
 zMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793230739; x=1793835539;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mUL9IvXJL2MT47NNFUWayhQpuNRP/QLpFWYDoVd8+3Y=;
 b=M7BXvPdaQ2SsuH+9KIl4p2u04F6rtcOv3fTmbqxTExTb6pLBD8nn9WO3staNqeXFf8
 UAIDmwZG/UJP8f2lj7AH6TDIWj7OYsQd4QmcpZRLUnla9Ws6y7PtrFpFMYKcWQjzRlZR
 dVn8QbVba8lKeTaPKeAV+GyCBjDB6PICETmYwvcLplJAOmM6cOjEAxAtqwnf+BplVF2n
 J4O1yC/K5/mhkh22OsDF2LlwE6LPyKfuI+hDr5TXIJFQRw/5orNa+z5Gpd5aI2bOLuIg
 Jtr5PbroXFbqHx7dkGzb5r/xxq8wCrW7YME4So6MonNk/GehoQUrz/+flWLt3+KkvuSH
 /ztQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzC72KAc6XYaIvB2tUngDxHlJ3UJdJYwf71CrbFLYnN6GpwwxwO8Vil/xZ+hHVTco8vuaObvWrkDdw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLmg9TD+hyKoLK1bg0q0RcyzUlycNneyecw/gOe8IZlRRcU8NRP
 uepnZ5FnZFXFy7avQJOmFpIixiuEo/z3xFwxO+Sd4+oDtO+wpvtvzbvD
X-Gm-Gg: AYBFou3VAeJqn/SFpIGNVIa8E+7+vq6iB516Cf8s48k/7/5S5b9NFULYGTjLAFama94
 MUVcrikFLkfeccRe7GCi4Z4wzG+5pf/LugGp/hM7MkYigSHyFcm4d46ofnXjQ2cL7gr8PTOk3WR
 inOZuGxVChcH2ETfCoGGMLut05Sbnn/ntuCSlooh0MAFPwDgay35NYfwLSL/vlKeEQwU1sG07dw
 PjqJ/kMWcdwvHIWighUrGjA7+mhesBS6fcpQlbnuMQzcCkzteIfrAYDAgtA0PSJW4w9n4RCna80
 dm0lCnbMYZsR5xIIwV1APJZW/frhC2ctSl+J0FxCGfwMf1qtlXK7tYUGvwj+/6uSOe0nW5nHMxP
 Xj8ltLcH/FZwT1Dn7XHsGOiev1mdYHpe48uA/KW+ODoJs+xQ5kgMLmer29lW9mWQKWaqDHAP8ge
 AYWVyjv1dFxHbZ3AT2ik3AwBIP+8fY3mcKwMsDC9tiOsCtbvLSM2r+7iYSueZVAbh/7e1pA11BL
 I8Ocy8Q5WKXGSxBxadAPB9EoTOTW9lk4C0I+v2RlRLCTMXMhEA2mPgmUJQyeQrUnhlGy0Aa9JIW
 eV9jZE1S7AF93tgnWJKJXr6WmosMo1e527iX
X-Received: by 2002:a05:6000:26d0:b0:487:baa:aa6b with SMTP id
 ffacd0b85a97d-48e5d5df440mr7815534f8f.43.1793230739292; 
 Wed, 28 Oct 2026 16:38:59 -0700 (PDT)
Received: from [192.168.1.12] ([31.94.68.191])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb90dsm29192908f8f.22.2026.10.28.16.38.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 16:38:57 -0700 (PDT)
Message-ID: <86cccaa4-62ac-4834-bc74-1755436b5be2@gmail.com>
Date: Wed, 28 Oct 2026 23:38:55 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amd/display: report synced Apple 5K tiles to
 PowerPlay for MCLK switch
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <3ff4ef96-9c59-4e8d-a0da-92a1ac6f5ba1@gmail.com>
 <CADnq5_Nn7+baU=Rdaa8QzOCo64H=ch9HeDaEwtmbQwW0kP00nQ@mail.gmail.com>
Content-Language: en-US
From: Richard Lane <richardlanedev@gmail.com>
In-Reply-To: <CADnq5_Nn7+baU=Rdaa8QzOCo64H=ch9HeDaEwtmbQwW0kP00nQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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

On 27/10/2026 18:26, Alex Deucher wrote:
> On Tue, Oct 27, 2026 at 5:41 AM Richard Lane <richardlanedev@gmail.com> wrote:
>>
>> When driving both 2560x2880 tiles of an Apple 5K iMac panel, Display
>> Core's program_timing_sync() already aligns both CRTCs in hardware
>> during dc_commit_streams() because the two streams share identical
>> timings.
>>
>> However, on DCE < 12 (iMac15,1 through Polaris-based iMac19,1), Display
>> Core leaves pp_display_cfg.all_displays_in_sync unset. Because PowerPlay
>> is not informed that the two streams have synchronized vertical blanking
>> intervals, SMU7 prevents MCLK switching at idle or causes modeset
>> underflows.
>>
>> Report all_displays_in_sync = true to PowerPlay after committing both
>> tiled streams so SMU7 knows the tiles blank simultaneously and can
>> safely downclock MCLK at idle.
>>
>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 548f975c7324..384a81371f80 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4788,6 +4788,19 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
>>         mutex_lock(&dm->dc_lock);
>>         dc_exit_ips_for_hw_access(dm->dc);
>>         WARN_ON(!dc_commit_streams(dm->dc, &params));
>> +       /*
>> +        * DCE < 12 leaves all_displays_in_sync unset; report synchronized
>> +        * Apple 5K tiles to PowerPlay after commit so SMU7 can downclock MCLK
>> +        * at idle without modeset underflows.
>> +        */
>> +       if (params.stream_count == 2 &&
>> +           params.streams[0]->link->tiled_peer == params.streams[1]->link) {
> 
> This should be made generic for any combination of displays with
> identical timings.
> 
> Alex
> 

I have changed it to the following to make it generic:

	if (params.stream_count > 1 &&
	    dm->dc->current_state->stream_status[0].timing_sync_info.group_size ==
	    params.stream_count) {

Richard

>> +               struct dm_pp_display_configuration *pp_cfg =
>> +                       &dm->dc->current_state->pp_display_cfg;
>> +
>> +               pp_cfg->all_displays_in_sync = true;
>> +               dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg);
>> +       }
>>
>>         bool frl_stream_found = false;
>>
>> --
>> 2.55.0

