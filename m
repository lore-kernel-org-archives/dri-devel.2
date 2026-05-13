Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819BDCD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0FA410EFBD;
	Wed, 13 May 2026 18:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J0duXNXH";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C31A10EFBD
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:33:54 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so33876965e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778697232; x=1779302032; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fiTNYVNzm2EWJXlIasqEdyA9slSNwJ07VhnNecnrUKs=;
 b=J0duXNXHoj/7/XwxSz2MXXe3IcV7zy8ZpEgcevBZPbfTEdfX2tgvW6Vh6N3Unu02os
 0TDyDQJYt5wmUHqLKy+0IqY7rRT0RP9fRdABapr19k8pvwN8dnwrGlijsbJk28jAe5+/
 Tutyt3jLLPR8qF3qxgDWICYN3litrQRz8bOtn20SEfTQAThKvnJ7B5qhoWsyg6O4zDKN
 T/yojZVEtkM6umM8u4SgXMtBwlUidNXwvfp1k4rbmU0wvYevi+ghsdQFKfFi1UgcmfsB
 Jq0gaFAlpku3EkY/sxesQIjBFe03bPtu4Bt4L0CvCL8ycT+RMDB5sgufEx1uqJ9NgKho
 P+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778697232; x=1779302032;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fiTNYVNzm2EWJXlIasqEdyA9slSNwJ07VhnNecnrUKs=;
 b=SML5R1A+FiGUSxNgJXTHvvWhoSPY1r/a21zSkY9GRtcsfP2aOIpPPgu7w3jqr5vQc+
 Mj3C3yhx/g0cQLkjG0ZgENHomPN7TiM1NAhOPzpkvKlch+6WzN/knJGiT349Y6U6VrTH
 ZiVbxUmtP9B0MoOZiSz4BxqOOG+lSqtYNthDMiM5fSMpCHo2xTOlnONHKnC0eHX6oBZ2
 j7/x3ykErHWGtHByFOBp/419m1CguOOA95Aa7ROnnAe3peHBrdcrRn+5r2bz1urveV0i
 s3R8lnhxnlhOvAsbfktwndnTNMIwWIa+VAiSQGwrUsKpxs5pRcTFZi96MbeFBFCmAMJm
 s+QA==
X-Gm-Message-State: AOJu0YwUZkr+QU/omnqzgt1H0EC/zx+iCLm5DLb8e2M6gW/hv/hkV7rO
 PLEqzh5PB8LoL5+OzYRuNcerccedaE47ynN4pjhVe1k5JixidFWrURL6
X-Gm-Gg: Acq92OF0jw9AQoH9Aci/Y8Yp6laIi6UvSw15y9oAo40akawoFhXW8uG0XZswglSaomv
 7M8PqgVSfsG3VMxSYeTVNafkb9rT0ngIUhIWLBmDCIKKzDS32qr+M4nl6GAKLF7fqqnsxqXnGaE
 ghSU/ZtP5DgbGBocPkPj+ibFpCTxKly5sDsRnIYtcnC25/p8k0N/rYVs5X5GoaXaLVMV0bP8DE1
 hIHK95aT9BbHXjgTigB3mU2BFZyVvlF0Rh9zR2wRdEj1vX06nbZBJ638u2mc/7iBV/qAeIuVXfL
 f1OnLsm7fe3qi+dvA4cJDt90LzTmQDnzskDLuilxaQFwvfRUtm3OexT9hC3JODfv4+ALLyKm0sq
 tVjj1Nzh0w14xDLajsAb8HJ3RZU9LZ/ziMxw0UR0in3IFYCFvse0XXEYdHvNhRYSzOLaZ0h7zDd
 N7LUtoSfvpMOmI2irJdcDdVEXNXP1uz+AbSMidY+T69OfqSE4kccvJPWd2hw==
X-Received: by 2002:a05:600c:3f0f:b0:48e:60a3:220a with SMTP id
 5b1f17b1804b1-48fc99a1af8mr65251675e9.0.1778697232515; 
 Wed, 13 May 2026 11:33:52 -0700 (PDT)
Received: from [10.247.142.6] ([129.234.0.190])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd769141fsm772355e9.32.2026.05.13.11.33.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 11:33:52 -0700 (PDT)
Message-ID: <2e80f456-a208-4cf7-9ab8-739a8314b275@gmail.com>
Date: Wed, 13 May 2026 19:33:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/imx: Fix three kernel-doc warnings in dcss-scaler.c
To: laurentiu.palcu@oss.nxp.com, l.stach@pengutronix.de,
 maarten.lankhorst@linux.intel.com, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, airlied@gmail.com,
 alexander.deucher@amd.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, me@brighamcampbell.com
References: <20260406180013.2442096-1-yiconghui@gmail.com>
From: Yicong Hui <yiconghui@gmail.com>
Content-Language: en-US
In-Reply-To: <20260406180013.2442096-1-yiconghui@gmail.com>
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

On 06/04/2026 7:00 pm, Yicong Hui wrote:
> Fix the following W=1 kerneldoc warnings by adding the missing parameter
> descriptions for @phase0_identity and @nn_interpolation in
> dcss_scaler_filter_design() and @phase0_identity in
> dcss_scaler_gaussian_filter()
> 
> Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:173 function parameter 'phase0_identity' not described in 'dcss_scaler_gaussian_filter'
> Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:270 function parameter 'phase0_identity' not described in 'dcss_scaler_filter_design'
> Warning: drivers/gpu/drm/imx/dcss/dcss-scaler.c:270 function parameter 'nn_interpolation' not described in 'dcss_scaler_filter_design'
> 
> Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
> Signed-off-by: Yicong Hui <yiconghui@gmail.com>
> ---
>   drivers/gpu/drm/imx/dcss/dcss-scaler.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/imx/dcss/dcss-scaler.c b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> index 32c3f46b21da..5c7f8d952ec1 100644
> --- a/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> +++ b/drivers/gpu/drm/imx/dcss/dcss-scaler.c
> @@ -166,6 +166,7 @@ static int exp_approx_q(int x)
>    * dcss_scaler_gaussian_filter() - Generate gaussian prototype filter.
>    * @fc_q: fixed-point cutoff frequency normalized to range [0, 1]
>    * @use_5_taps: indicates whether to use 5 taps or 7 taps
> + * @phase0_identity: whether to override phase 0 coefficients with identity filter
>    * @coef: output filter coefficients
>    */
>   static void dcss_scaler_gaussian_filter(int fc_q, bool use_5_taps,
> @@ -262,7 +263,9 @@ static void dcss_scaler_nearest_neighbor_filter(bool use_5_taps,
>    * @src_length: length of input
>    * @dst_length: length of output
>    * @use_5_taps: 0 for 7 taps per phase, 1 for 5 taps
> + * @phase0_identity: whether to override phase 0 coefficients with identity filter
>    * @coef: output coefficients
> + * @nn_interpolation: whether to use nearest neighbor instead of gaussian filter
>    */
>   static void dcss_scaler_filter_design(int src_length, int dst_length,
>   				      bool use_5_taps, bool phase0_identity,

Hello!

Is there any further feedback or progress on this patch?

Thank you!
Yicong
