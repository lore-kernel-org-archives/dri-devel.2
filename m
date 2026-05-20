Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AEDCD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 08:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA4410EF93;
	Wed, 20 May 2026 08:36:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Ec3Tdbmv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C100810EF93
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779266210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bKCOj9ctJvrcgjU6TqlSQaQ7SYSoxCFQc2iMU4O21Y4=;
 b=Ec3TdbmvZj55r+Ip/Z4PYrd9/hTCgiOaoZUsZuQr1HiF5zDaKHCoh7VrCA5r3jIy/p8Kuu
 yESYHcfu/hUJBGjnIxZIDfeEIA7xn0Ir7Kj+D3f+af1SuaCPZ4A4MYDPvP++uXQ7smwmdQ
 vSFIv6S/SFKIlEqEefyDb1/AKM4YhPE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-BnHQU9PoP9C4zqk9WZ5dUw-1; Wed, 20 May 2026 04:36:49 -0400
X-MC-Unique: BnHQU9PoP9C4zqk9WZ5dUw-1
X-Mimecast-MFC-AGG-ID: BnHQU9PoP9C4zqk9WZ5dUw_1779266208
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48fdc746a8bso22599045e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 01:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779266207; x=1779871007;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKCOj9ctJvrcgjU6TqlSQaQ7SYSoxCFQc2iMU4O21Y4=;
 b=liIMrrgdG889EZdGirb1nFkiLGaIHqYSiYm6ga506MJKt0Zbt5IjrEVrDdNtN7njmG
 wldKaqrzljeaiHleTDHI9fjpxrYVR+0K4ZdZ+90GvtzM0SDLyOsLSbRKsSa/LjJL8z56
 Zxc79qZ1Rth/Nc5G8mKcnL8tFpB/08bO2d8bRvAvUaoFFlUjebIkiDsLVQaJM1Ixle4v
 7IRa+FMcNZncsxRmNg6Ln0Jn5Aj2KSMdQhO+LlEL1kIdr+aOn/mJfAjI07NB4B/r/LDa
 zFRQdkaKoYDRTgRthUOncUOpVIvl+ubKLIvf5BnNfXflEcOrNLWvV9c0MHC1mIl6BlXW
 tUVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mVF8/PjfWwYGlApDns/bsHJldUJyS1KwSJZU4SsxBJwheYtCKDzROXseF02FzhzClItxqSTwtCLw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhZA+oWctkVdnbGN5ucg+IgpPRJ5fJFQ57znHF0QpU4Qhcp+ig
 43KUEiPKEsjEB3aoW+ASwXFpkzwffkStgXeZYByqXmcAViX3GAVNEKHpyrd4iRuWbYLuAcO1Bwn
 Y09/L2psI3KVtuxC00/iy6kImKt4ysX00bowytcNzuIqIWnBZe/wPozjf3jhITIO+EIwUKg==
X-Gm-Gg: Acq92OFIqK4KUatQRYuHjooWr4HjynLkLwzeGulcQxGQZHeU+Vh4fTaEXZBJZicu7Pf
 T7cOdmfa9boHM2/PigmdQmF7Y0U6B00TZsBbBGGAn/Pu6uy5FfZqG9Z12tbMcVX5y3F3jT4KMvd
 piFbA7q+1SCeozO2FbNtFAZyqas+PxPlONFDPq5ASCGfs8AJdSShgOZcLn5FExLD2sO5ZxRz90Y
 xu8PSJiImpPZgRXsWaPJsqiXvnJeeyk2KN5rXy6isY83sRirPzJReLXuNUPUZY63Ag+1zBJsWRu
 wQQbjLd/APgEmMSE1OAADC+t3omlzScMQAKg/LED/YQ8Vp5FtqDYjzmrcl8xEUcCeuwpQY2jQ80
 HCkw4JSIG1RY8OgjV2Hn2WASm9Pzsj+KnxfJMqsEamkD/pC48WmDuRE707tLsojH+Ah01o+lvy1
 w6OFQNTfctXSRMbLU=
X-Received: by 2002:a05:600c:858d:b0:48f:e230:80a3 with SMTP id
 5b1f17b1804b1-48fe6514c31mr278323355e9.33.1779266207547; 
 Wed, 20 May 2026 01:36:47 -0700 (PDT)
X-Received: by 2002:a05:600c:858d:b0:48f:e230:80a3 with SMTP id
 5b1f17b1804b1-48fe6514c31mr278323075e9.33.1779266207096; 
 Wed, 20 May 2026 01:36:47 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fffb9aac4sm501908955e9.9.2026.05.20.01.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 01:36:46 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org, David
 Airlie <airlied@gmail.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Nicolas Frattaroli
 <nicolas.frattaroli@collabora.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/8] drm/display: hdmi: Add common TMDS character rate
 constants
In-Reply-To: <20260520-yellow-panther-of-dew-de32eb@penduick>
References: <20260519144712.1418302-1-javierm@redhat.com>
 <20260519144712.1418302-2-javierm@redhat.com>
 <78506dc5f7ff02a2bdd05de1170a1cb3e33e1abe@intel.com>
 <875x4iy1em.fsf@ocarina.mail-host-address-is-not-set>
 <20260520-yellow-panther-of-dew-de32eb@penduick>
Date: Wed, 20 May 2026 10:36:45 +0200
Message-ID: <8733zmxysi.fsf@ocarina.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zNSJVLFH1f0QhXe4zOrgS5u_isTaZ8IcrljWi4-4sZs_1779266208
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
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

Maxime Ripard <mripard@kernel.org> writes:

> On Wed, May 20, 2026 at 09:40:17AM +0200, Javier Martinez Canillas wrote:
>> Jani Nikula <jani.nikula@intel.com> writes:
>> 
>> Hello Jani,
>> 
>> > On Tue, 19 May 2026, Javier Martinez Canillas <javierm@redhat.com> wrote:
>> 
>> [...]
>> 
>> >>  
>> >> +/* HDMI spec TMDS character rate limits (in Hz) */
>> >> +#define DRM_HDMI_TMDS_CHAR_RATE_MIN	25000000
>> >> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_0	165000000
>> >> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_3	340000000
>> >> +#define DRM_HDMI_TMDS_CHAR_RATE_MAX_2_0	600000000
>> >
>> > Usually everything in DRM is in kHz, and Hz is the exception.
>> >
>> 
>> That is correct but in this case these constants are to be used with the
>> HDMI helpers. Both struct drm_connector_hdmi_state.tmds_char_rate and
>> the struct drm_bridge_funcs.hdmi_tmds_char_rate_valid() callback expect
>> the TMDS char rate to be defined in Hz.
>> 
>> If we define these in kHz, it means that drivers will have to * 1000 at
>> every call site.
>
> As long as the unit is obvious from the name, I think we'll be fine, and

Yes, I agree.

> we can even have both Hz and kHz defines if we want to.
>
>> > I'm also not sure the 1_0, 1_3, and 2_0 really help anyone reading the
>> > code. I won't remember what they mean in Hz or kHz, and I'll have to
>> > look them up every single time.
>> >
>> 
>> I discussed this with Maxime before posting the patches since I wondered
>> the same. He suggested that the max TMDS character rate was linked to the
>> HDMI spec versions and that it would be more readable to name it using
>> the spec version rather than the resolution.
>
> As usual, it's both the spec and hardware capabilities. But some like
> the HDMI 1.3/1.4 max is used to know where to setup the scrambler for
> example, and is used everywhere.
>
> I still think it has value, but we don't have to force anyone to use
> them either.
>
> I'd prefer to use the DRM_HDMI_$SPEC_TMDS_CHAR_RATE_MAX_HZ though
>

Ok, I'll change it in v2.

>> The other naming I suggested was:
>> 
>> /* HDMI spec TMDS character rate limits (in Hz) */
>> #define DRM_HDMI_TMDS_CHAR_RATE_MIN		 25000000
>> #define DRM_HDMI_TMDS_CHAR_RATE_74_25MHZ	 74250000
>> #define DRM_HDMI_TMDS_CHAR_RATE_148_5MHZ	148500000
>> #define DRM_HDMI_TMDS_CHAR_RATE_297MHZ		297000000
>> #define DRM_HDMI_TMDS_CHAR_RATE_MAX_1_4		340000000
>
> Honestly, I'm not sure if it's worth defining if we'll have the
> frequency in the define name.
>

Fair. I think is still worth it but I agree with your opinion that
having the $SPEC in the name makes more sense.

> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

