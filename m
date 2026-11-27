Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AB4606A32A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PyX7h/6p
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1C7B10E5B3;
	Fri, 27 Nov 2026 12:41:31 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C845B112A8C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795783283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n6sjtzia/9qVvozEkPywWapR6k1Ealc6KRJ9DwbhjUM=;
 b=PyX7h/6pE2MXEgqfbgdhdSlOBfS7PTJlRc/2S+ruAj/SZAz/EwEaHL1g7DRzZ/FL/ErZhY
 /3f2RWXIObx+YLge6zGyJRbutOXJ+Kf+MDJpuQeOVpks6/PLB1WKzt0EPvwgFa6LmL6ZVT
 Wz2RVqJgt4Dxt88OkpqttT91gQWgxcY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-1B2ta0AqPraobR-wFJ-MbA-1; Fri, 27 Nov 2026 12:41:22 +0000
X-MC-Unique: 1B2ta0AqPraobR-wFJ-MbA-1
X-Mimecast-MFC-AGG-ID: 1B2ta0AqPraobR-wFJ-MbA_1795783281
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e0461e040so6315012f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795783281; x=1796388081;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n6sjtzia/9qVvozEkPywWapR6k1Ealc6KRJ9DwbhjUM=;
 b=iHGb1s5doirWGHeh4pGMW+JFBkIqTdpXq6U05tORAZ930EpvxA2upz91bJbtx+aYf4
 TZIxen+AYfEBAhrd+M+mbUW/lD2vjGJhcRVkvN6BFRkspdE0h/qsscx4D8NdSO+miz29
 nXGqS5JdUsEHDS6dEwmDpOfOtecrVdEZ3IrLMINEcd559/xJK8ZDWBg41tQdiIy1BxqH
 qN2V36Zoi71Li7V+bufmK0MAXLfF6WfBPkA80jPDDng82yVBAiZL8qiZfRSe6JBz8bgk
 KKkYCTAu11+cmcOik2tDwFhG9IFR4h6uPgbNGJcVjhUCG1fzOrR/vSgmLpLbH5Prv3Uo
 vIgw==
X-Forwarded-Encrypted: i=1;
 AL+hErFo79QjrZm68VHW04WwXPivVA7iPswM+4zu7bs7JUnE/nxg9nPZSZC6zaXj2Jr5wx5OtvYdIFFEE8g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/QSFUQsCjDzaq84Q+g7kXtWUlvQ9ckkQF9WwxIjcCwDI1mxLU5
 zSBALZuji27jVbqIbtPDe9cUSlJZjF3nBlGg/yuH7v1xoSAjM226tAESKIzECIm6S354+ivwe2R
 kcfPZ9DCADGUTEWRRczEBOak+zd+LiAgN5QfOfACVF5A+TWW7CGSsqU6C6qvZC1oiZ836SA==
X-Gm-Gg: AZFdTZe3JudVprday63XqjNpTAp6R/9PFGY06D7cW0J5qi/JgqdPopV7jZG3uXcmPDg
 A1N1wUdRDiEFYgCxBdzxB2zzzY72Jsa7e5PA29NoVc/uvxNjZ/nkc8CGte+2VeBJB/On8rp6VXC
 uqxwmVLRcmIgJ9Sqzf/y/ElG1pv7fi+AjZMCWPh1dDJy6mzTyPOiMyZtx4aHpiB8yoFMqTBORk9
 +XbN1uYLS4n3B0nel5dtiJAbZ0p326bvB6HGxEhImozOY/xG0aOncT8JgCZJJb9TWbdwyhrpeg/
 oZJ7H8Zs9y4VATyDbeYxnJfZYm/Wq9bPzW5mSeSzFo/4JLbbu6a/0+qedww104A26qlApkelri3
 VPlXWEHxCyGqm5rdgOBtEVIV1RpxR+3T8WdN5Jzznt9tm1bFT+6Ke4+x5FkxJrJnYDDsB34VKi/
 vW16O7amTFdRseZL4IYQPR
X-Received: by 2002:a05:6000:2607:b0:48f:bb92:c5a7 with SMTP id
 ffacd0b85a97d-4abb0c5d665mr48588265f8f.9.1795783281235; 
 Fri, 27 Nov 2026 04:41:21 -0800 (PST)
X-Received: by 2002:a05:6000:2607:b0:48f:bb92:c5a7 with SMTP id
 ffacd0b85a97d-4abb0c5d665mr48588225f8f.9.1795783280861; 
 Fri, 27 Nov 2026 04:41:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9?
 ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c340df4sm53695095f8f.55.2026.11.27.04.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 04:41:20 -0800 (PST)
Message-ID: <ba9b59dc-1e4e-4a59-8354-e4ec0de4ef1d@redhat.com>
Date: Fri, 27 Nov 2026 13:41:16 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/panic: Check QR alignment centers one axis at a
 time
To: peder.bergan@gmail.com, Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261126-perf-drm-panic-qr-v1-0-51856937dc4d@gmail.com>
 <20261126-perf-drm-panic-qr-v1-1-51856937dc4d@gmail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20261126-perf-drm-panic-qr-v1-1-51856937dc4d@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2LK83Lb7gdUKEcpMYfH4HkDtzHzgg9n0-WX9bRM_a10_1795783281
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 17:53, Peder Bergan via B4 Relay wrote:
> From: Peder Bergan <peder.bergan@gmail.com>
> 
> is_alignment() scans pairs of alignment centers each time it tests
> whether a module is reserved. At version 40 there are seven centers
> per axis, so a lookup can visit 49 pairs.
> 
> Each center covers a five-module span, and adjacent centers are at
> least 12 modules apart. Find the unique matching center on each axis
> and apply the existing finder-pattern exclusion to that pair. The
> lookup now needs at most 14 center tests.

Thanks for your contribution.
This code is executed only once when a panic occurs, so optimizations 
are clearly not a priority.
But this series looks good, and keeps the code simple.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
> ---
>   drivers/gpu/drm/drm_panic_helper_qr.rs | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_helper_qr.rs b/drivers/gpu/drm/drm_panic_helper_qr.rs
> index 4941731fb60fa..c6ed395c05bd2 100644
> --- a/drivers/gpu/drm/drm_panic_helper_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_helper_qr.rs
> @@ -746,17 +746,14 @@ fn draw_alignments(&mut self) {
>   
>       fn is_alignment(&self, x: u8, y: u8) -> bool {
>           let positions = self.version.alignment_pattern();
> -        for &ax in positions.iter() {
> -            for &ay in positions.iter() {
> -                if self.is_finder(ax, ay) {
> -                    continue;
> -                }
> -                if x >= ax - 2 && x <= ax + 2 && y >= ay - 2 && y <= ay + 2 {
> -                    return true;
> -                }
> -            }
> -        }
> -        false
> +        // Centers are at least 12 modules apart, so their five-module spans are disjoint.
> +        let Some(&ax) = positions.iter().find(|&&center| x.abs_diff(center) <= 2) else {
> +            return false;
> +        };
> +        let Some(&ay) = positions.iter().find(|&&center| y.abs_diff(center) <= 2) else {
> +            return false;
> +        };
> +        !self.is_finder(ax, ay)
>       }
>   
>       // Timing pattern: 2 dotted line between the finder patterns.
> 

