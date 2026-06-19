Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137B3CD98E6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 07:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D154610F46F;
	Fri, 19 Jun 2026 07:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="Q7SYXtir";
	dkim-atps=neutral
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5698210E0EA;
 Fri, 19 Jun 2026 02:03:10 +0000 (UTC)
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 5F041278B0;
 Fri, 19 Jun 2026 04:03:08 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ash5nrCy94Sf; Fri, 19 Jun 2026 04:03:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1781834587; bh=IT0W0Uuv93bQks2y1A9gHcgTFoSBWnQ1Xkhp54muBww=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Q7SYXtirwE4pM37WY8qcr07QvMqMTery1aFg708OPqsl57OuiJQ7WogpjzJ4TTZ2F
 KM0IKx/umi6im1cQxRsnnEg+nJ6X++CINklQMhaUj4hGDkCV529nQfKdZYuIe57ifo
 Sj0p4aiMYoPLpRZVsAEgx6X0Ll4WTuQBZDik+Dv2/RvT7JTb/5Xvy7xlSGpCMP/XJb
 FnSDxkYO9/tieZ62xMb3dK7C5fGowZWrjFK8xbUTq+NsRPV9fEKoCWrPWGxVAiVxEu
 H5muc4x0klGNn2KWPCDlC/byp0AlnhLnqSTVBudQ9HgfPTyD1+XxVXy7bweJcYxeLE
 0856SuD8nNkPQ==
Message-ID: <1f24aee4-8588-4d54-ba5a-cc5e9c002a54@disroot.org>
Date: Thu, 18 Jun 2026 19:03:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: set MSA MISC1 bit 6 when using VSC
 SDP for DCE 11.x
To: Alex Deucher <alexdeucher@gmail.com>, Leorize <leorize+oss@disroot.org>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: linux-kernel@vger.kernel.org, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260519030624.51613-1-leorize+oss@disroot.org>
 <20260519030624.51613-2-leorize+oss@disroot.org>
 <CADnq5_MrUaLRP70hwb5YGawjfft9qUaH4h_t4TQ17AEgAwj3ww@mail.gmail.com>
From: Leorize <leorize+oss@disroot.org>
Content-Language: en-US
In-Reply-To: <CADnq5_MrUaLRP70hwb5YGawjfft9qUaH4h_t4TQ17AEgAwj3ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 19 Jun 2026 07:13:40 +0000
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

Friendly ping. Should I resend this patch?

On 5/26/26 7:52 AM, Alex Deucher wrote:
> @Leo (Sunpeng) Li
> , @Wentland, Harry
>
> Can you take a look at this?
>
> On Tue, May 19, 2026 at 3:19 AM Leorize <leorize+oss@disroot.org> wrote:
>> When BT.2020 colorimetry is selected, the driver sends information using
>> VSC SDP but does not set "ignore MSA colorimetry" bit on older GPUs with
>> DCE-based IPs. This causes certain sinks to prefer colorimetry
>> information in DP MSA, resulting in terrible color rendering ("dull"
>> colors) when HDR is enabled.
>>
>> This commit wires up the MISC1 bit 6 for GPUs with DCE 11.x based IPs to
>> correctly configure sinks to ignore colorimetry information in MSA,
>> resolving the color rendering issue.
>>
>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4849
>> Assisted-by: oh-my-pi:GPT-5.5
>> Signed-off-by: Leorize <leorize+oss@disroot.org>
>> ---
>>  .../drm/amd/display/dc/dce/dce_stream_encoder.c   | 15 ++++++++++++++-
>>  .../drm/amd/display/dc/dce/dce_stream_encoder.h   |  3 ++-
>>  2 files changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
>> index ed407e779c12..2c3a20d35fe9 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
>> @@ -271,7 +271,6 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
>>         bool use_vsc_sdp_for_colorimetry,
>>         uint32_t enable_sdp_splitting)
>>  {
>> -       (void)use_vsc_sdp_for_colorimetry;
>>         (void)enable_sdp_splitting;
>>         uint32_t h_active_start;
>>         uint32_t v_active_start;
>> @@ -334,6 +333,16 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
>>         if (REG(DP_MSA_MISC))
>>                 misc1 = REG_READ(DP_MSA_MISC);
>>
>> +       /* For YCbCr420 and BT2020 Colorimetry Formats, VSC SDP shall be used.
>> +        * When MISC1, bit 6, is Set to 1, a Source device uses a VSC SDP to indicate the
>> +        * Pixel Encoding/Colorimetry Format and that a Sink device shall ignore MISC1, bit 7,
>> +        * and MISC0, bits 7:1 (MISC1, bit 7, and MISC0, bits 7:1, become "don't care").
>> +        */
>> +       if (use_vsc_sdp_for_colorimetry)
>> +               misc1 = misc1 | 0x40;
>> +       else
>> +               misc1 = misc1 & ~0x40;
>> +
>>         /* set color depth */
>>
>>         switch (hw_crtc_timing.display_color_depth) {
>> @@ -499,6 +508,10 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
>>                                 hw_crtc_timing.h_addressable + hw_crtc_timing.h_border_right,
>>                                 DP_MSA_VHEIGHT, hw_crtc_timing.v_border_top +
>>                                 hw_crtc_timing.v_addressable + hw_crtc_timing.v_border_bottom);
>> +       } else {
>> +               /* DCE-only path */
>> +               if (REG(DP_MSA_MISC))
>> +                       REG_WRITE(DP_MSA_MISC, misc1);   /* MSA_MISC1 */
>>         }
>>  }
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
>> index 342c0afe6a94..88d6044904d1 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
>> @@ -96,7 +96,8 @@
>>
>>  #define SE_COMMON_REG_LIST(id)\
>>         SE_COMMON_REG_LIST_DCE_BASE(id), \
>> -       SRI(AFMT_CNTL, DIG, id)
>> +       SRI(AFMT_CNTL, DIG, id), \
>> +       SRI(DP_MSA_MISC, DP, id)
>>
>>  #define SE_DCN_REG_LIST(id)\
>>         SE_COMMON_REG_LIST_BASE(id),\
>> --
>> 2.54.0
>>
