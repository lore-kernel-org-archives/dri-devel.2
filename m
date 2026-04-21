Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB91EF8FA79
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 13:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38EBC10E1E1;
	Tue, 21 Apr 2026 13:39:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="OtQqbwni";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB63210E1DB;
 Tue, 21 Apr 2026 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=d4coqLmDeSBTj2Mfkit/DcKkXNF6qndD5pA24CRWzdA=; b=OtQqbwniAUx0H2nsFwhOYx7UKE
 hHyaWLufTmGBd26WkpiX8TPVRZR4z9JxO0G8EvrXZJl+kn7FeNxsBoKGoy66FQmhLkXCN/zEM5Yyv
 VFMuq2xuB+FmmFDPpEoTXbEkr5g4n4X8FXTB234BraeBXpEJu9Zu7jnRJfhdTombc7+ut/wQZo53p
 pPnaOVbamjamQEUSkO7vA0bE2dK9OMssyLN3RqddKjTau4i4jiI/+WK8u3vnVppbrd6nJqSbkkbje
 o/+Ltxrz+xZxCkXZu0z9G5m1LBO43nRYF8BprFVbUp3EwUjjyBcJDkdCp0ImLD8m+TB3th7ZbmBH/
 3Fx5Y5QQ==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wFBKH-001rGv-4M; Tue, 21 Apr 2026 15:39:41 +0200
Message-ID: <38d36d94-d4f9-4b61-8c06-197f31f1f4cc@igalia.com>
Date: Tue, 21 Apr 2026 10:39:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/amd/display: use a separate helper to translate
 degamma curves
To: "Kovac, Krunoslav" <kkovac@amd.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, harry.wentland@amd.com,
 simona@ffwll.ch, siqueira@igalia.com, sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Alex Hung
 <alex.hung@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, pekka.paalanen@collabora.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-dev@igalia.com
References: <20260414220237.184289-1-mwen@igalia.com>
 <20260414220237.184289-3-mwen@igalia.com>
 <c030e9fc-d88e-47f9-afd7-9a4a0a53f4d3@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <c030e9fc-d88e-47f9-afd7-9a4a0a53f4d3@amd.com>
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



On 16/04/2026 16:22, Kovac, Krunoslav wrote:
> Thanks Melissa for following up.
> I like the changes themselves, just some clarifications.
> We do have a LUT with predefined HW curve, but it has some 
> limitations: it cannot be used with subsampled 4:2:0/4:2:2 formats and 
> it affects the linearity of color space in which HW scaler operates. 
> In your case, we use the LUT after tone mapping in 3D LUT; that LUT 
> doesn't have predefined curve. So it's not uncommon that we need to 
> program our own degamma.

Hi Kruno,

Right, I reviewed this part in the cover letter after checking my notes 
that there is a hw curve for degamma, but not for shaper, blend and 
post-blend re-gamma, right? I forgot to correct this info here.
I wasn't aware about the subsampled limitation.

>
> The motivation for the new segment distribution is best explained with 
> an 8-bit sRGB case. Input has 256 possible values and HW LUTs have 256 
> points. Ideally in this case we'd use the LUT as basically plain 
> indexing with no interpolation. The new distribution accomplishes 
> this, it aligns 256 HW points with 256 possible inputs. Due to float 
> representations of input, it's not aligned perfectly, but LERP-ing 
> between two HW entries where input is always within small epsilon from 
> one of entries doesn't materially change things.
I'll rewrite commit messages to include this explanation too.
Thanks for sharing these details.

Melissa
>
> On 4/14/2026 17:55, Melissa Wen wrote:
>> In newer DCN families, there is no hw predefined curves. So, when
>> setting predefined TFs to gamm_corr, shaper, blend and regamma, the
>> driver resorts to the color modules and program those predefined curves
>> using LUTs. The driver is using the same LUT segmentation when
>> translating EOTF and inverse EOTF to hw points by using the same color
>> management helper to translate curve to hw points, however, LUT
>> representing EOTF may not follow the same region/segment distributions
>> of inverse EOTF. This is causing banding on blend when PQ predefined
>> curve is set. Use different helpers when linearizing and delinearizing.
>> This is the first step to fix banding but already mitigates the issue by
>> increase the number of points per segment from 8 to 16.
>>
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>> ---
>>   .../gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c    | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c 
>> b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>> index b45ceb570a5c..17d54aadb5e1 100644
>> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
>> @@ -493,9 +493,8 @@ bool dcn32_set_mcm_luts(
>>       if (plane_state->blend_tf.type == TF_TYPE_HWPWL)
>>           lut_params = &plane_state->blend_tf.pwl;
>>       else if (plane_state->blend_tf.type == 
>> TF_TYPE_DISTRIBUTED_POINTS) {
>> -        result = 
>> cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
>> -                                 &plane_state->blend_tf,
>> - &dpp_base->regamma_params, false);
>> +        result = 
>> cm3_helper_translate_curve_to_degamma_hw_format(&plane_state->blend_tf,
>> + &dpp_base->regamma_params);
>>           if (!result)
>>               return result;
>>   @@ -551,9 +550,8 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
>>       if (plane_state->in_transfer_func.type == TF_TYPE_HWPWL)
>>           params = &plane_state->in_transfer_func.pwl;
>>       else if (plane_state->in_transfer_func.type == 
>> TF_TYPE_DISTRIBUTED_POINTS &&
>> - cm3_helper_translate_curve_to_hw_format(plane_state->ctx,
>> - &plane_state->in_transfer_func,
>> -                            &dpp_base->degamma_params, false))
>> + 
>> cm3_helper_translate_curve_to_degamma_hw_format(&plane_state->in_transfer_func,
>> + &dpp_base->degamma_params))
>>           params = &dpp_base->degamma_params;
>>         dpp_base->funcs->dpp_program_gamcor_lut(dpp_base, params);
>

