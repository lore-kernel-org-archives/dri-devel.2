Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8C606A32C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 00:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Keu4QhE8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CB810F28A;
	Tue, 24 Nov 2026 00:34:36 +0000 (UTC)
Received: from mail-oi2-f0.google.com (mail-oi2-f0.google.com [74.125.231.192])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3A210F28A
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 00:34:30 +0000 (UTC)
Received: by mail-oi2-f0.google.com with SMTP id
 5614622812f47-57e49da0b8dso24179b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 16:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795480470; x=1796085270; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6crECWKKQv2zAsDKPQ3Smbpft+Vpc6B0Dn2GFB4AR8c=;
 b=Keu4QhE8pfqEJQdb7jaEe995qoxi29qpAuPc1BkLCWS3e470Q5D2tNYCcLkzTuqVdZ
 MX71A6QW7WOGodn0F+S+my4/pqRFi9WWl5NJ6YyrfLINtVn0tNviYV0UjG5bdMMxHZY1
 vXs197p8l5vtOVMgXgnQOeJTgPNkZexI0j4lD6XHnqi5ffyak/5SeJtLLFvLN72fZLOI
 1//TzKmSO1AWqW91lVhIOiL5oaDdLogdUYleZdLyKOgLH682HZYK62fi2Sb2iDJhqx4G
 JIOUU+KIpotYFxN6fbWYFRjgN6G4iev23+Uqh/qo2+C5pPJEMzGvxX00k+0JuyDR6Yas
 TsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795480470; x=1796085270;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6crECWKKQv2zAsDKPQ3Smbpft+Vpc6B0Dn2GFB4AR8c=;
 b=2Rm27m6EVni+pZ9XRwe4+bAkd4PxGSyz4AMroLP08aKEhp95hZ6qtkfEKg+lujfb7x
 Z6VrAQMsruApR8qMfutOamXq/Z84ExRtT/jZv0BcU73ZM0Cxgapa07+P+e9brtH28UmF
 Zs4CyBJm4fLndiP7cyklHCqB/qFZalLBgpkjg90K5KtR/4bt0EGibYh/fRIrctqLiSJ+
 232zYNmVg18nY/uaAeeO9E8kAsoWs14L/TTgglp0V6hcrhsXm92bPNOsUcbT9x80aA6p
 6a+1q6CJroARcjanLdGZiqh+1d7Erp7EJPCkf4Lroa+c/j7D1/RuJE9J/+AlthWjDY0e
 unVw==
X-Gm-Message-State: APuU4Z872Ca92vSgoBm1EjMVJ/LO3DenhUi9lWojYI+Ii585YwOsKmFv
 OBYAUp4l/L/UihNYZoXZ3B4Atjd9nbSa/6wPQqRa0Atus7uDJBAh7S9xqaHgp1AA2zEBDQ==
X-Gm-Gg: AZFdTZex3zI9zctUcuCCF1a/l/jrf7h2hfGZstdHq8HGt2v0M/R0jrhnmXRlBJHw5ja
 B+qykZXONTf7Ce1CrUeXXMsttwdrrt/y27X/rxCBAOFjlvkIFiH+YkNeDXRuyTroca3c8e4cnBu
 zI4SlHXfk/uBd70RdPa+4XtFuE+7IgNlczruu1wxNfH/LJ7sYsR6MIcrjs1vYqsx3EJ2xaIvBgd
 dAqC5Ty3Zt1QFYLEyIqVL3CBCN96neF1neff/h22eGCPCRac9p8iDAWeo9jwcXq6byMjxsz8M5U
 +w2zqDPa4NLe51EihZYUYd8nICdD3c6QPg989fL9IxqeSEhOL0Wc2abzyrbdtG9iOJTcmCiCAWu
 SNgw5FRphnZEsbnPGkvEGqDtrBAhYEB/6iXJ9mmlS8FVwW74q32zaaxIaCP9BHNsQpiu9DP7JX7
 XOA3rpH0fmrK/pC5fszqHBUSqywVYssGYgfGtbU1ACZ8t6zcQkv2rds2faB95p4r1kqDOAYGuPB
 7xD2FbnSHErZFKSKxhTOq7fXIXkBhMvQbezvAvshJi6b/COzz7fNDk+QOjWdPWMMQyJhpt43v8Y
 KL3HEzGYySBziFqMDC1kJI0A4FbjkgMG0dsxrbJ7HW3xaw==
X-Received: by 2002:a05:6808:50a4:b0:4fb:c2dd:c7a5 with SMTP id
 5614622812f47-57a0bb863e2mr10864879b6e.31.1795480469686; 
 Mon, 23 Nov 2026 16:34:29 -0800 (PST)
Received: from ?IPV6:2600:8804:5716:d800::d500? ([2600:8804:5716:d800::d500])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a347636b9sm10287193b6e.7.2026.11.23.16.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 16:34:29 -0800 (PST)
Message-ID: <6e5b4d8f-3270-43ad-9a2e-b7f37110dfe0@gmail.com>
Date: Mon, 23 Nov 2026 18:34:28 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/mediatek: ovl: Report coverage blending on older SoCs
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20261120-rbrue-suez-mtk-ovl-coverage-v1-1-35040085fc37@gmail.com>
 <sashiko-outbox-226021@kernel.org>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <sashiko-outbox-226021@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/26 2:15 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [High] drm/mediatek: ovl: mtk_ovl_layer_config() sets OVL_CON_AEN on
>    XRGB formats
> --
>
> commit ecc63cbd272ca62ff2a9d686e47d8eb659dfe660
> Author: Ryan Brue <ryanbrue.dev@gmail.com>
>
> drm/mediatek: ovl: Report coverage blending on older SoCs
>
> This commit sets .blend_modes = BIT(DRM_MODE_BLEND_COVERAGE) on MT2701,
> MT8167, MT8173, and MT8183 OVL driver data to eliminate the DRM plane
> init warning when exposing alpha formats without a blend mode property.
>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>> index 5445870716f94..81a4143f294d5 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> [ ... ]
>
>> @@ -667,6 +663,7 @@ static const struct mtk_disp_ovl_data mt2701_ovl_driver_data = {
>>   	.gmc_bits = 8,
>>   	.layer_nr = 4,
>>   	.fmt_rgb565_is_0 = false,
>> +	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE),
>>   	.formats = mt8173_formats,
>>   	.num_formats = ARRAY_SIZE(mt8173_formats),
>>   };
>> @@ -677,6 +674,7 @@ static const struct mtk_disp_ovl_data mt8167_ovl_driver_data = {
>>   	.layer_nr = 4,
>>   	.fmt_rgb565_is_0 = true,
>>   	.smi_id_en = true,
>> +	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE),
>>   	.formats = mt8173_formats,
>>   	.num_formats = ARRAY_SIZE(mt8173_formats),
>>   };
>> @@ -686,6 +684,7 @@ static const struct mtk_disp_ovl_data mt8173_ovl_driver_data = {
>>   	.gmc_bits = 8,
>>   	.layer_nr = 4,
>>   	.fmt_rgb565_is_0 = true,
>> +	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE),
>>   	.formats = mt8173_formats,
>>   	.num_formats = ARRAY_SIZE(mt8173_formats),
>>   };
>> @@ -695,6 +694,7 @@ static const struct mtk_disp_ovl_data mt8183_ovl_driver_data = {
>>   	.gmc_bits = 10,
>>   	.layer_nr = 4,
>>   	.fmt_rgb565_is_0 = true,
>> +	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE),
>>   	.formats = mt8173_formats,
>>   	.num_formats = ARRAY_SIZE(mt8173_formats),
>>   };
>> @@ -704,6 +704,7 @@ static const struct mtk_disp_ovl_data mt8183_ovl_2l_driver_data = {
>>   	.gmc_bits = 10,
>>   	.layer_nr = 2,
>>   	.fmt_rgb565_is_0 = true,
>> +	.blend_modes = BIT(DRM_MODE_BLEND_COVERAGE),
>>   	.formats = mt8173_formats,
>>   	.num_formats = ARRAY_SIZE(mt8173_formats),
>>   };
> [Severity: High]
> Does advertising BIT(DRM_MODE_BLEND_COVERAGE) on these SoCs cause
> mtk_ovl_layer_config() to set OVL_CON_AEN on opaque formats such as
> DRM_FORMAT_XRGB8888?
>
> DRM_MODE_BLEND_PREMULTI is 0 while DRM_MODE_BLEND_COVERAGE is 1.  When
> .blend_modes was 0, state->base.pixel_blend_mode stayed at 0, so
> mtk_ovl_layer_config() only set OVL_CON_AEN when has_alpha was true:
>
> drivers/gpu/drm/mediatek/mtk_disp_ovl.c:mtk_ovl_layer_config() {
>      ...
> 	unsigned int blend_mode = state->base.pixel_blend_mode;
>      ...
> 		if (blend_mode || state->base.fb->format->has_alpha)
> 			con |= OVL_CON_AEN;
>      ...
> }
>
> With state->base.pixel_blend_mode now initialized to
> DRM_MODE_BLEND_COVERAGE (1), blend_mode is non-zero and OVL_CON_AEN is
> always set.  Because these older OVL blocks map XRGB8888 to
> OVL_CON_CLRFMT_ARGB8888 and do not support OVL_CONST_BLEND, enabling
> OVL_CON_AEN makes the hardware read the X byte from memory as per-pixel
> alpha, reintroducing the XRGB scanout regression fixed by 995d4d558eea
> ("drm/mediatek: ovl: Fix XRGB format breakage for blend_modes unsupported
> SoCs").
>
> Checking whether ovl->data->blend_modes includes
> BIT(DRM_MODE_BLEND_PIXEL_NONE) instead of testing blend_mode as a boolean
> would preserve OVL_CON_AEN behavior on coverage-only SoCs.
>

Thanks. DRM_MODE_BLEND_PREMULTI is 0, so with the coverage-only property 
the default blend mode becomes non-zero and mtk_ovl_layer_config() would 
set OVL_CON_AEN for XRGB planes on these SoCs, undoing 995d4d558eea. My 
test only looked at ARGB planes, which is why the registers matched, and 
the commit message's "both are non-zero" was wrong, my bad.

v2 will only look at the blend mode where the OVL supports premultiplied 
blending, the same test mtk_ovl_fmt_convert() uses, so these SoCs keep 
enabling alpha blending for formats with alpha only.
