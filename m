Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CCACCF2C3
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 21:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9891910E2C3;
	Fri, 16 Oct 2026 21:19:00 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7401110E233
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 21:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792185533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woZGOP8aKQUsneT0FV1kzo/CsHwMXqUAtAl9xKcNL6c=;
 b=K+LG4MXltg/dViMeTzbQ2YHIXlWan3nNUJH2sANczD2aL0GzUlOiuEULDYoY+HFKYL8cNX
 uS4my7iAjk03/TXO98pvhyynaV+qAznEQQUPCs2c3DtQrzyjDAmZvH/krEJNxhoRs0uKhy
 Kdszjdknpn/9Sz8i0EctBww0RzX4dGU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-fA1gLIb6PfSGXa-QAeVfKQ-1; Fri, 16 Oct 2026 21:18:52 +0000
X-MC-Unique: fA1gLIb6PfSGXa-QAeVfKQ-1
X-Mimecast-MFC-AGG-ID: fA1gLIb6PfSGXa-QAeVfKQ_1792185531
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so2013825e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 14:18:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792185531; x=1792790331;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=woZGOP8aKQUsneT0FV1kzo/CsHwMXqUAtAl9xKcNL6c=;
 b=rsolq4IReqBEhj/t4CX0ZQUy3M2XNAfeaY3Z609uqV7315Lf8FDVO3KuI5X2uuWo7f
 sdcNAIM5yHxeBOET3gDO5/KefRL8/Ii9pCmTAC8QdYU2qp1zTCzuwBPAtcs347X6HEvJ
 BpSOoysLl9I1MTShv/Qmtp4jSgFqKVoyy2tv1ULKQYXEImzZCrlaTrw7Wsu6APw9pMDr
 vhno54VUkqej+OJiAql3eA5giH123CEAu9pjd22ezBmMIBV9turBoWas6RcXd2tSMFbV
 c903sZO4g54e5r8C7VVpT36u0XRO1YNTF8WAv4AxCPMD8zhfEmQ7hGcMpEOOn8CHq8Lw
 uUFw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwK8ib9Nu8zgxH1/tJ/q1AYAqLo89HcsBii+s1zw5t/9/NZ7I8Sx/Mo+cqvIxhywbD4A/ssxBcuKwM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKn4m18uRFhoOapLt/tUtvZO46gKCuZPQReeErKof5WZ31H13Rt
 lGm+il6EYsQH71GDXjjoSZKYMvFWdPfkk9ckL37wSto+JXy4SIB6MrsbJhclYD/SH87YxDPwgS9
 e6h0xCbzz1XBrMnRrF7XouEeNNT3yT5k1+SZmcSPCF8Sf83cOIPj5ktTnP7I3q2gcrZCx3Q==
X-Gm-Gg: AYBFou06nimDGDHYt1Gpf+DXz1xGp+5J8xSbNii+trQDNmXtjWM1bQz4v3x82/H3g+x
 Jfn2/VyKQIg6hKq8ovO3/lKT3fKXAjDRAFVSbUXXTQHyoFJvlVAq4BsVwY4gqFnQIOghDL825kn
 5OQ98S+zqQNdxrmbRNjj/A0XennXUgXx71yguLSI30gPq5vfqRuteAHmTisLFwkQhChJ1PS8GhO
 2vXz1Yndvo9FRoqxn3hj+yJlHxuDDks5S9k4ki8L3uieVIPaRLcbM/dT+8DNxd3UiaZDg45vTy4
 UJvDQxe6WZDeVDLoRkiXqxdSaSYO/WII5I/K1+uxOFDHtfZL2xq8Db3lthHLFgux1dxmrVBWgma
 wZaZHL0KsqduiH2tyTqMBfu8SwKOglE2gMOnAbjOtpASRALs=
X-Received: by 2002:a05:600c:4f4c:b0:4a0:1723:2d8e with SMTP id
 5b1f17b1804b1-4a1d75ac2a7mr27794065e9.2.1792185530489; 
 Fri, 16 Oct 2026 14:18:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4f4c:b0:4a0:1723:2d8e with SMTP id
 5b1f17b1804b1-4a1d75ac2a7mr27792545e9.2.1792185529311; 
 Fri, 16 Oct 2026 14:18:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9?
 ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce33ad3fsm66306545e9.5.2026.10.16.14.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 14:18:47 -0700 (PDT)
Message-ID: <f651c7f8-9651-4d9b-bde8-3c0de767a66f@redhat.com>
Date: Fri, 16 Oct 2026 23:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/panic: Accept a trailing newline in panic_screen
To: Devin Wittmayer <lucid_duck@justthetip.ca>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261016052722.60051-1-lucid_duck@justthetip.ca>
 <20261016052722.60051-2-lucid_duck@justthetip.ca>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20261016052722.60051-2-lucid_duck@justthetip.ca>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 467xOTxkW4RwUsL5Y0XCevl7exeCjNzsBQMhSMc4aPM_1792185531
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

On 10/16/26 07:27, Devin Wittmayer wrote:
> Setting the panic screen through sysfs with echo fails with EINVAL,
> because the value ends in a newline. Ignore it when matching.

Thanks it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Fixes: e85e9ccf3f84 ("drm/panic: Report invalid or unsupported panic modes")
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> ---
> QEMU, 10 runs each, on drm-misc-fixes and drm-misc-next:
> 
>                                       before    after
>    write of "user\n"                  refused   takes
>    write of "bsod\n"                  refused   refused
>    drm.panic_screen=user at boot      takes     takes
> 
> amdgpu, 2 runs each, 7.2.6 with Arch's source and config:
> 
>    echo user                          refused   takes
> 
>   drivers/gpu/drm/drm_panic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 29b1487de7ae0..7847b38ba9aab 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -839,7 +839,7 @@ static int drm_panic_type_set(const char *val, const struct kernel_param *kp)
>   	unsigned int i;
>   
>   	for (i = 0; i < ARRAY_SIZE(drm_panic_type_map); i++) {
> -		if (!strcmp(val, drm_panic_type_map[i])) {
> +		if (sysfs_streq(val, drm_panic_type_map[i])) {
>   			drm_panic_type = i;
>   			return 0;
>   		}

