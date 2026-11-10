Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F78606A320
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SyWWJnKd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E10910F959;
	Wed, 11 Nov 2026 08:23:47 +0000 (UTC)
Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF65B10F2C7
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 18:49:54 +0000 (UTC)
Received: by mail-wm2-f6.google.com with SMTP id
 5b1f17b1804b1-4a1d25d7d5dso8456525e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 10:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794336593; x=1794941393; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qPkf5Dn97yVQ7A3K9LckCKOS5iiqVVbPOk75NoRmJew=;
 b=SyWWJnKdy1naqlFKklERlAcSDZ+S8ReQDAfYsCkvlar9uhKp++meRU/6uAhwaFalao
 sFY/9eHHZIN68HtAceT8UoZyAG6LeSZmHGX2lH70QlWx65eCalRrWhNIGXv4woPHgBMJ
 VmDkWBHaXlDteb5MaJTtrdrXRaHM74zPIr8AoFT0PQvfDu/BZzsIbxknweNcRQRq3xqE
 lhZKO2/NMo02ojTal0cIDYYWLNZNGaaLG607eg+YicbDyAWKxrsxaK4hzzlEVdAb6WPH
 0sBV8vdfSfT2vSaesgXUxfLRDf/tL5nxh8Sci/j5w6IshSthef0WNPyeGOoX4UWu0+Tg
 Hmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794336593; x=1794941393;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qPkf5Dn97yVQ7A3K9LckCKOS5iiqVVbPOk75NoRmJew=;
 b=eqEOtetYxmJ2q1yDw0RfwgzLZfMu3c1/xgY29txLOrIwupNviiPG4N3UO6GzgcB5b5
 eJMhFfzpE6tDQVlx8ZOR22P29JocFWFcG9CEuBej7EQx2O72kpN0LeQzYoGGZ5rqD114
 kFSC/uLWqqUnYsvfUtU1SZ5NHVcVEyu/9nIu6ABO7BJRBZ9Xf8eGVU2cqjMP6mAiK02N
 v2AirSPLblPA5U4Ww8KxBoubIH9i3oXbLEw5aiF/WFvcQM4gd6lDMD4KAuqvwMbUOlS8
 31bfGddwRtupoeh2WuxiFzCCk+EelgOh2/Cq9W+lv2d2Y+uFkKyH6/wvGzj/2S2pBT9P
 OLTA==
X-Forwarded-Encrypted: i=1;
 AL+hErF9cOj3XO1LV025LLqHE3rDeVdzdv4HFDTaO0pHVa7Q7FJUXn+4adnuDcW7EgV04KPhtb0zhX9R7dM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/e5pN0Www/cUmv3nXU96hM9vcmqhrfZTj6fdgD9FXZgcGLmI3E
 hk8Z7ywYoraOo3Hk9BrbcKGsP/A8SofobYApP5+dZvr27Swex1lEdBRX
X-Gm-Gg: AYBFou31sQ/0xoW+9FmpTglBGSLKqsKGszcsO8n/dECZqM9pycYpJgj1IK+G3Rarvyu
 SKACe0uUFcVRhnDWlFgWC0f/DTplx9tY53oLCe9nwcjiS1rvxqdaLSrqPxw5sSgQ7mZ5v/7k5Ad
 LKgFLA9WumC06ItA79U5Tq/FYZoLJz1ZaCYpr60sKvpd7TTjdnLI5db8IV1+n0bOQXMR+DeVfSt
 ZiVgVSC/dOBKWKIJ08ofKsAT7SiEhDmpg4/5Euum9woRAeUs+gegQKsBW/r2FrT85HcJsyyUAZe
 UDnSsBpc5p8jf//g2Y5LPgaCr9E2lfKxxv6gqni7xOVni2hINwt+O0HcX6nKSfaLYbqzAl6PGr/
 8e0+7q1OBwaGDhw8Ttd88Vky7QDgJAWTtF2BYqcDlirywT6Ks3Ncdi1i8toiXu6CwaGvn2j5GO9
 4tcPz1h7/kjYb/NN18maVxj6Fgt/lSDJR97Fws9LaSAgTgehV+NRuf1I90NCf/iNHD09ZStmBdv
 x47pwKE0T6MoEmVocmYohjVxgLFgwjsb3JQsMmFFcZLD8KM6Cocd1gOVpGB6QdeRpYAVQrGqG4O
 +LPCbAqHVDu+w85CnXjqbf8gz8nzA/lUMAGyZvZG1wi4zLKU440Ssakh
X-Received: by 2002:a05:600c:3544:b0:4a2:1655:87e2 with SMTP id
 5b1f17b1804b1-4ba0938dbf9mr328175e9.19.1794336593063; 
 Tue, 10 Nov 2026 10:49:53 -0800 (PST)
Received: from [192.168.1.7] ([31.94.68.191]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba023a1fcfsm34094085e9.4.2026.11.10.10.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2026 10:49:50 -0800 (PST)
Message-ID: <a6093dab-c38d-4dad-af3b-7173a6eaa78c@gmail.com>
Date: Tue, 10 Nov 2026 18:49:48 +0000
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
Content-Language: en-US
From: Richard Lane <richardlanedev@gmail.com>
In-Reply-To: <CADnq5_OrGuMJT4Tvt+wktPzTYEopdkCjyqq8sSdvJou40-HoKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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

On 09/11/2026 20:34, Alex Deucher wrote:
> On Mon, Nov 2, 2026 at 3:31 AM Richard Lane <richardlanedev@gmail.com> wrote:
>>
>> When driving multiple displays or tiled panels with identical timings
>> (such as the two 2560x2880 tiles of an Apple 5K iMac panel), Display
>> Core's program_timing_sync() aligns the CRTCs into a timing sync group
>> in hardware during dc_commit_streams().
>>
>> However, on DCE < 12, Display Core leaves
>> pp_display_cfg.all_displays_in_sync unset. Because PowerPlay is not
>> informed that the streams have synchronized vertical blanking intervals,
>> SMU7 prevents MCLK switching at idle or causes modeset underflows.
>>
>> If all active streams belong to the same timing sync group
>> (timing_sync_info.group_size == params.stream_count), report
>> all_displays_in_sync = true to PowerPlay after committing the streams so
>> SMU7 can safely downclock MCLK at idle.
>>
> 
> Looking at this a little deeper, the function bw_calcs() in
> dce_calcs.c already calculates all_displays_in_sync using the helper
> all_displays_in_sync().  Can you look into this and figure out why
> that is not working as expected?  My concern with this patch is that
> DCE and DCN have different logic for handling mclk switching so I'm
> not sure it's safe to call dm_pp_apply_display_requirements() directly
> from common code.
> 
> Thanks,
> 
> Alex

Moving it to dce_clk_mgr.c and using resource_are_streams_timing_synchronizable() also works. Is that a solution?

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -31,6 +31,7 @@
 #include "dmcu.h"
 #include "core_types.h"
 #include "dal_asic_id.h"
+#include "resource.h"
 
 /*
  * Currently the register shifts and masks in this file are used for dce100 and dce80
@@ -319,8 +320,17 @@ static void dce_pplib_apply_display_requirements(
 	struct dc_state *context)
 {
 	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
+	int j;
 
 	dce110_fill_display_configs(context, pp_display_cfg);
+	pp_display_cfg->all_displays_in_sync = pp_display_cfg->display_count > 1;
+	for (j = 1; j < context->stream_count; j++) {
+		if (!resource_are_streams_timing_synchronizable(
+			    context->streams[0], context->streams[j])) {
+			pp_display_cfg->all_displays_in_sync = false;
+			break;
+		}
+	}
 
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
 		dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);

Richard

> 
>> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 74cd88d8d580..b4531383437e 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -4777,6 +4777,16 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_commit *state,
>>         dc_exit_ips_for_hw_access(dm->dc);
>>         WARN_ON(!dc_commit_streams(dm->dc, &params));
>>
>> +       if (params.stream_count > 1 &&
>> +           dm->dc->current_state->stream_status[0].timing_sync_info.group_size ==
>> +           params.stream_count) {
>> +               struct dm_pp_display_configuration *pp_cfg =
>> +                       &dm->dc->current_state->pp_display_cfg;
>> +
>> +               pp_cfg->all_displays_in_sync = true;
>> +               dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg);
>> +       }
>> +
>>         bool frl_stream_found = false;
>>
>>         for (i = 0; i < params.stream_count; i++) {
>> --
>> 2.55.0

