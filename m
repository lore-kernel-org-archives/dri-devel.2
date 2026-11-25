Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1456606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=q2Uujm96
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C39D10E209;
	Wed, 25 Nov 2026 10:04:04 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D94310E209
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:03:58 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 73A7DC2F4E0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:04:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A0B0F60480;
 Wed, 25 Nov 2026 10:03:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0FBE311E69C2F; Wed, 25 Nov 2026 11:03:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795601036; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=sTN+qvc7xCX3cggRlBV8dqr4F6FnoJ9KcbUquUQE+pI=;
 b=q2Uujm96HZSej2CSWmINxToXXffqLO1n1b8JmM0IMTK9SCSz1AwtUC6JmpTefyIgr0FCcj
 qo9X/9s1aCG0OMTYBI3aDpLmll+U4tAVSw6Do/AaMEwCwcB+v459f+HvU7S1jHj7J5Q6H1
 RWEoG1rV5KTldSLzRc7Sk9w+tsBOlWv6vWmsZY6CdyNATdXFt7mScPt3OyZ5oey3L0NgBo
 SQOY1zZyPDO+ZyRfG6IR9pVBC3ajqIRXUjj2O4QkRcgTN7icuCmcmYl0T2rYA53mwy2ze7
 SJMqC/xNOD1+8of3R0oybSJt+hpCIzpvWGmatJYA+XoKJZ84iDAV2EwVifpWSw==
Message-ID: <57bb208d-e220-4ae0-94bb-5e873d138f92@bootlin.com>
Date: Wed, 25 Nov 2026 11:03:54 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 7/8] drm/dp: Move eDP sink link rates reading helper out
 of i915
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
References: <20261118-feat_move_i915_helper-v1-0-652177f3107a@bootlin.com>
 <20261118-feat_move_i915_helper-v1-7-652177f3107a@bootlin.com>
 <sashiko-outbox-220759@kernel.org>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-220759@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/18/26 11:53, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] drm/i915/dp: HBR2 quirk in intel_edp_set_sink_rates() skips
>    fallback
> --
> 
> commit b3bcea937e62f9aba672f8e2782fab0f2b184dbd
> Author: Kory Maincent <kory.maincent@bootlin.com>
> 
> drm/dp: Move eDP sink link rates reading helper out of i915
> 
> This commit moves the eDP DP_SUPPORTED_LINK_RATES reading logic from i915
> into a generic drm_dp_read_edp_sink_rates() helper.

...

>>   
>>   	/*
>>   	 * Use DP_LINK_RATE_SET if DP_SUPPORTED_LINK_RATES are available,
>>   	 * default to DP_MAX_LINK_RATE and DP_LINK_BW_SET otherwise.
>>   	 */
>> -	if (intel_dp->num_sink_rates)
>> +	if (num_sink_rates)
>>   		intel_dp->use_rate_select = true;
>>   	else
>>   		intel_dp_set_sink_rates(intel_dp);
> 
> [Severity: Medium]
> Can this leave intel_dp->num_sink_rates as 0 on platforms with
> QUIRK_EDP_LIMIT_RATE_HBR2 if DP_SUPPORTED_LINK_RATES only lists rates
> above 540000 kHz?
> 
> Previously, rates above 540000 kHz were filtered out before checking
> intel_dp->num_sink_rates, so an empty filtered list fell back to
> intel_dp_set_sink_rates().  Now num_sink_rates is checked before the
> following intel_dp_rate_limit_len() call clamps intel_dp->sink_rates:
> 
> drivers/gpu/drm/i915/display/intel_dp.c:intel_edp_set_sink_rates() {
> 	...
> 	if (num_sink_rates)
> 		intel_dp->use_rate_select = true;
> 	else
> 		intel_dp_set_sink_rates(intel_dp);
> 	...
> 	if (intel_dp->num_sink_rates && intel_has_quirk(display, QUIRK_EDP_LIMIT_RATE_HBR2))
> 		intel_dp->num_sink_rates = intel_dp_rate_limit_len(intel_dp->sink_rates,
> 								   intel_dp->num_sink_rates,
> 								   540000);
> }
> 
> When all entries in DP_SUPPORTED_LINK_RATES exceed 540000 kHz, this sets
> intel_dp->use_rate_select to true, skips intel_dp_set_sink_rates(), and
> then reduces intel_dp->num_sink_rates to 0, triggering drm_WARN_ON() in
> intel_dp_get_common_rates() and breaking eDP link training.

There is indeed maybe a small case where this can happen.
I will fix it in next version.

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

