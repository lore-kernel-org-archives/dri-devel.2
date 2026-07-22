Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3230C4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 069D310EC8A;
	Wed, 22 Jul 2026 07:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eo+xn6dF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD71910EC8A
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:05:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A446443A28
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0148C1F000E9;
 Wed, 22 Jul 2026 07:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784703942;
 bh=Y915cQZhE7GPpNp92gZc1Lxo3IQr04a2RYnCcUZU5QM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=eo+xn6dF6SUbj8/4ArCf+KImBZQWQgEsHw+ActywUjKgNaoPxJeNckV8sLrVvB7Ae
 dZkM5gtU8frMYhZLJ8k7Yx7NOr8e7xSPhhn92fkyVBUGClXdDqmTO+jQ3mTuoRNj33
 KfcqWf8Fs6ZiCicbwhPo+MBI+6OxrEUSRwjGY9RB7+uUqY5JCi3IVblUGExr7Y5ncf
 dRtCxw5XRxC28E2S6gXQiXvpzn7Cj9zqz/6Pp8uzkh1TVqOwPH2tTW0N6XkeukXYXP
 diIeF6ZrjkpJP8Fp9xzDgoRBFds1VroAZHyP9iU1xmog3aH++9yenhd5Kr3oaVwWAn
 UsgxGKO7uyfRA==
Message-ID: <0a44675f-1371-49e9-b5cd-1053836c88f5@kernel.org>
Date: Wed, 22 Jul 2026 09:05:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: use proper context for logging
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260722063210.1144266-1-jirislaby@kernel.org>
 <20260722065145.EC2431F000E9@smtp.kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260722065145.EC2431F000E9@smtp.kernel.org>
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

On 22. 07. 26, 8:51, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] NULL pointer dereference when logging errors in `dce112_get_pix_clk_dividers` and `dcn3_get_pix_clk_dividers`.
> --
> 
> --- Patch [1]: [PATCH] drm/amd/display: use proper context for logging ---
> commit 67013b697b017867bb1c1e61f13b863b96364c5e
> Author: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> 
> drm/amd/display: use proper context for logging
> 
> This commit fixes a NULL pointer dereference in get_ss_info_from_atombios()
> by temporarily redefining DC_LOGGER to use clk_src->base.ctx->logger. The
> calc_pll_cs->ctx context is uninitialized at that time since it is only set
> later by calc_pll_max_vco_construct().
> 
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1271175
> Closes: https://lore.kernel.org/all/a9ee54e6-2413-4156-9bde-d528ae3c63a3@kernel.org/
> Fixes: 1296423bf23c ("drm/amd/display: define DC_LOGGER for logger")
> 
>> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>> index ecb8493ec5233..d3f7aa853e3a6 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
>> @@ -1513,6 +1513,10 @@ static const struct clock_source_funcs dce110_clk_src_funcs = {
>>   	.get_dp_dto_frequency_100hz = get_dp_dto_frequency_100hz
>>   };
>>   
>> +/* calc_pll_cs->ctx is set only after get_ss_info_from_atombios(), unlike clk_src->base */
>> +#pragma push_macro("DC_LOGGER")
>> +#undef DC_LOGGER
>> +#define DC_LOGGER CTX->logger
> 
> [Severity: High]
> This is a pre-existing issue, but does a similar NULL pointer dereference
> exist in dce112_get_pix_clk_dividers() and dcn3_get_pix_clk_dividers()
> during their error paths?
> 
> It appears dce112_clk_src_construct() does not call
> calc_pll_max_vco_construct(), leaving calc_pll_cs->ctx as NULL. If invalid
> parameters are passed (like requested_pix_clk_100hz == 0), the error path
> invokes DC_LOG_ERROR() which dereferences calc_pll_cs->ctx->logger:
> 
> drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c:dce112_get_pix_clk_dividers() {
>          DC_LOGGER_INIT();
> 
>          if (pix_clk_params == NULL || pll_settings == NULL
>                          || pix_clk_params->requested_pix_clk_100hz == 0) {
>                  DC_LOG_ERROR(
>                          "%s: Invalid parameters!!\n", __func__);
>                  return (uint32_t)-1;
>          }
>          ...
> }
> 
> A similar error path exists in dcn3_get_pix_clk_dividers().
> 
> Since DC_LOG_ERROR() relies on the same uninitialized context pointer,
> could this trigger a crash similar to the one being fixed here if these
> functions encounter invalid parameters?

Occurs likely to me. Someone involved in the driver has to look as the 
logic is really intertwined.

thanks,
-- 
js
suse labs
