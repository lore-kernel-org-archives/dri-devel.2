Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB6BC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:17:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D01E10EC89;
	Wed, 29 Jul 2026 15:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VooQpCrP";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69C8910EC7B
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785338224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bvjfqhSyqGanu+o7Vd023AUOeIFl1b0hrPEjWiCBsMY=;
 b=VooQpCrPQioGor9gjkPPLXbIlO8YiO5wBU75Bc/d/Pl1EztMN6lh3jwtGT0qVpHfT6OYEt
 qaRrE3U0vAoBsf0Cmnwxe8PkVx1ij0ssvtngaPQE06lSNskh4dPpq6GvYIPXlJtrQpcGQM
 iyWpG0atI2t/tOQuJlBx8tI0urP0E94=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-DP3MSwaGMB2p70M35TchXQ-1; Wed, 29 Jul 2026 11:17:01 -0400
X-MC-Unique: DP3MSwaGMB2p70M35TchXQ-1
X-Mimecast-MFC-AGG-ID: DP3MSwaGMB2p70M35TchXQ_1785338221
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955843c6cdso12515385e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785338220; x=1785943020;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bvjfqhSyqGanu+o7Vd023AUOeIFl1b0hrPEjWiCBsMY=;
 b=VoR6A9J1BV8bCQMKyQ9lnVA6WnZ11X0SirmrUYyMDzglBpKRR/i8yOUW7uGdmRVTcl
 ACdXM4c0gE7mjOea354fvJB/lJAB9dllqJ0oEa1CclqRr/ABC0/B7ag90rW459j4IKzB
 E3osbpSAH+oHNfpi12PVkq/ibCVgiLLBu3Ft14OJzL45lQspvpLSTVxOmw8xtcE1gZuU
 RVZTTv6aOgbotyHkD0JYs07/08ojTAm5MFf9hFzirFn6BGu5pqS6vziz8RDViRXoDCb2
 vC8MhhKUtWfghoiEGApbcm+D2RXnvcBBa3HoeBQ0mQPoWit7E48liJaMDNKpAaiOKAx2
 6THQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8zF80E17Bxroaxdfh7mu2fG7NS7gBpYutVIqWomE5itWYRCGrGkRMBl88muXKosBaJcMy8vgQEak=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmA7wSOIl+M6V/E4oibUismQcm2WIFQCswWO+bh6uSOKYASIyn
 kQpPWiEFjB1DPWa7xe7PzotH+YEvwwz3JuHvfKXYEs0PdVVKOW3i7+5vydNPXKF7ale/HaL+ni3
 nVljQbrUMqEPFJ0FZcLpdL/zOLcwgEaQkJ/I+bX0tphPU5iUTQEouQQeIj4lxFC2Kxbk/Sg==
X-Gm-Gg: AR+sD11CtylghArUDYMatPcMkLcQOaXMfypg6JGFfsBYb+I3MOhuw7bYOBGw+JXLFrh
 gHXMu3r0teo/63t46W2G0K0OizgOq3GAWUjjzW+/cjCGkZamG8gpE3qtvIv81vmjYUCceJF+h8g
 jWbh5imtm7KFmkUK74K/xS4ry3Q2J6+T/C2r4SL/cGpWgzSyPS73bvTS2P5/Q8Jip5owKOsCqEU
 BtvMdQ3N0diY19jUuaCIMPojvh8H2aoKYsQfRADAjekaYE18cn76LZAqTfOOHMMkr1lk4M1Kpvc
 K5lz2XvyHWJLUoSIg1Bl3fbjQmtteZgGSAoNEnGQ8tl0lSLzzQSr7kCwwmiJosPYxadH7T3zDKA
 GoUNDMW8/HcPGD7Mv+KyqT/nlXCEfvSR7782s22ZGhG5DWA==
X-Received: by 2002:a05:600c:8b6c:b0:493:ee2b:c876 with SMTP id
 5b1f17b1804b1-496c6591a94mr78297785e9.35.1785338220408; 
 Wed, 29 Jul 2026 08:17:00 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6c:b0:493:ee2b:c876 with SMTP id
 5b1f17b1804b1-496c6591a94mr78296945e9.35.1785338219161; 
 Wed, 29 Jul 2026 08:16:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9b4:d000:c3c5:df83:3a33:2c51?
 ([2a01:e0a:9b4:d000:c3c5:df83:3a33:2c51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b0f2ddsm8683100f8f.20.2026.07.29.08.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 08:16:58 -0700 (PDT)
Message-ID: <b05568d9-476e-4903-a988-1ff72bcc33b1@redhat.com>
Date: Wed, 29 Jul 2026 17:16:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] drm/log: Fix out-of-bounds read on empty message
 length
To: oushixiong1025@163.com
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Shixiong Ou <oushixiong@kylinos.cn>
References: <20260729084520.688087-1-oushixiong1025@163.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260729084520.688087-1-oushixiong1025@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: llnshZKlDsSd2OjZ1XyCiZuu-v1-6ek3KO1eCHSmMyQ_1785338221
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

On 29/07/2026 10:45, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
> 
> drm_log_draw_kmsg_record() accesses s[len - 1] to strip the trailing
> newline, but len is unsigned int. If len is 0, the subtraction wraps
> to UINT_MAX, causing an out-of-bounds read.
> 
> Add an early return when len is 0.

Thanks, for your contribution

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>   drivers/gpu/drm/clients/drm_log.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index e3e02c84a4cf..294b3be1a6b3 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -162,6 +162,9 @@ static void drm_log_draw_kmsg_record(struct drm_log_scanout *scanout,
>   {
>   	u32 prefix_len = 0;
>   
> +	if (!len)
> +		return;
> +
>   	if (len > TS_PREFIX_LEN && s[0] == '[' && s[6] == '.' && s[TS_PREFIX_LEN] == ']')
>   		prefix_len = TS_PREFIX_LEN + 1;
>   

