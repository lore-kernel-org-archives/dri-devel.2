Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CC4C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:19:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39D3610F198;
	Fri, 31 Jul 2026 07:19:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="GuXFYXGz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28AE10F198
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 07:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785482379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CHdEKoHtgVBqNRMda5c2tqE6/+0bl8VSMMMLDCwYELw=;
 b=GuXFYXGzk94Jv+v4/TIqFqbRBp+cLNa4jVA2bdEBo33baUZJnLPmjI0WlFTvNQXe69Ka0t
 zviNHDwd7Q6k29HhnQPxKpbrpPouN/LKGFJbQqcrWmCagnutc2Mo2Mz/uPUcpeKO98so0p
 vMYk8s7ZAdxxBQYn0iuPx18tUWXTeH0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-fgb1_m1wM3ORBDOQJ8j3iQ-1; Fri, 31 Jul 2026 03:19:32 -0400
X-MC-Unique: fgb1_m1wM3ORBDOQJ8j3iQ-1
X-Mimecast-MFC-AGG-ID: fgb1_m1wM3ORBDOQJ8j3iQ_1785482371
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-69cd6606b19so607853a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 00:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785482371; x=1786087171;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CHdEKoHtgVBqNRMda5c2tqE6/+0bl8VSMMMLDCwYELw=;
 b=Ng8KM9AhhLEFC7hVGYcEjY9lwaIm2c4TIyvSPCk1p7RFS/KUHq4qGmp2QHmGakO9ru
 UM6+bM9UThhHGF/xNsJK0WaKTq7uc38LcTbrtxSkDY1yWuIUpwqAT0AZnyRzE6ovcnR2
 FyISyJria1I7MFbjYyJIEUR4+SDFsIMza1fO3oWBGglyAhKhX5GPhlpO4ZS4XuCxiwJq
 +hhqZE7H2/U69MqhyIGIv+/2Y7iLF7Xk1IToAqBZ1gu0D+CLcRzgsgOPsXNpmGh3E3xG
 QAOg/wapSBrfyTH7+zmzniWaXzokxnZrbko2ie205M4uSX3F+2kMoiczuSGo6tpVX/q3
 pCOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgEc5p01CWqrPzAKYqofkCVbYC8EXJyMUmoffIugmFt7pZrCi1yirygt0r9TYeWurTr83Q2DqpTZs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwvyFbMVcm0+QqOtfpsi50dnBBWkJGagAj274kXp+CYUbAzwrnp
 p4h3W/rnsC2TKEHxDqZwZ7fTIl7Mq/1AUqJNWk505VPe4IR0xdEfcawdLU/Epvkt5FsJutvH32y
 4SU1/JOk0kOLdqYlRf7iACoXiPKHafyp++XJCN0yF86OUCaQ9j3wE0/bCTMfByIM1AHDjTA==
X-Gm-Gg: AR+sD11ZlmjJ+F5eqRdBf0gI8Smh70FZW+fsR4/vIIQdMOQKl9G4YWt8VlDrCwEqU5t
 uZo45in2kLb3CNLsP9GMg/i8whzo/t3o7VeXx9vyCJvOxVq7w9YrYDlN52+DWROaogyfjcCctyH
 wkH6SCpBx6H34LhyBPWo33NjcoC/mrw4Um6jaR65rDmXDVfXo4Qeuzus3w3VuB0J4srIE6tOUv8
 6mguoL5vvFzz6m5XgxixdNQDV5zH+PQLRUdO3lSsP0Lpf756rpAIdEh2rrmbeeCZP4gtt1xBtEx
 YYMho4qmpS/sIli8Mejo1DIAOxWIG5p7x5ufX0Ka6bm27U345viPCogdMg3Yal7rjmdJLspQJXp
 FW5b9bbO+5BHUx2YZNXvNgmcAasTWbTNyP0btrP2ekZ6wjQ==
X-Received: by 2002:a05:6402:26cb:b0:6a0:8877:fa54 with SMTP id
 4fb4d7f45d1cf-6a0984eef9cmr425758a12.17.1785482371276; 
 Fri, 31 Jul 2026 00:19:31 -0700 (PDT)
X-Received: by 2002:a05:6402:26cb:b0:6a0:8877:fa54 with SMTP id
 4fb4d7f45d1cf-6a0984eef9cmr425741a12.17.1785482370925; 
 Fri, 31 Jul 2026 00:19:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9b4:d000:c3c5:df83:3a33:2c51?
 ([2a01:e0a:9b4:d000:c3c5:df83:3a33:2c51])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c6551cbsm373196a12.20.2026.07.31.00.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 00:19:30 -0700 (PDT)
Message-ID: <e50cb7f0-a98c-4bdc-99ff-09ad9c653334@redhat.com>
Date: Fri, 31 Jul 2026 09:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/log: Fix division by zero when scale module
 parameter is 0
To: oushixiong1025@163.com
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
References: <20260730014440.66323-1-oushixiong1025@163.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260730014440.66323-1-oushixiong1025@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dyVU38d-zrLkjsQWMe3EoOgl85XK1iwpwJm4B8Svbas_1785482371
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
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

On 30/07/2026 03:44, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> The scale module parameter can be set to 0 via kernel command line.
> When scale is 0, scaled_font_h and scaled_font_w become 0, causing
> a division by zero in the rows/columns calculation.
> 
> Since the scale module parameter is read-only (0444 permissions), it
> cannot be changed at runtime via sysfs. Clamp it to 1 once in
> drm_log_register().

Thanks, it looks good to me

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
> v2->v3:
>     Clamp scale once in drm_log_register() instead of introducing a
>     drm_log_scale() helper, since scale is read-only at runtime.
> 
> v1->v2:
>     Introduce a drm_log_scale() helper.
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index 294b3be1a6b3..46004abd4e61 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -424,6 +424,9 @@ void drm_log_register(struct drm_device *dev)
>   {
>   	struct drm_log *new;
>   
> +	if (!scale)
> +		scale = 1;
> +
>   	new = kzalloc_obj(*new);
>   	if (!new)
>   		goto err_warn;
> --
> 2.25.1
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
> 

