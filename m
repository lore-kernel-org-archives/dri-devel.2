Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52019606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FxhZ8dMN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F1B510EA24;
	Fri, 27 Nov 2026 12:42:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D916A10EA0D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795783359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69WYYzr2raKy4GZhRJJIx91GBcacgavIFPmAXCyscrM=;
 b=FxhZ8dMNRFJddkaS4emlkmU1scupNF+NqbLXfCh5JUks5P6wdtOPkzBHg0tsKia1AOEO1I
 D0YNkjoK6/5KnqjpU8aACQ171MG0uBidyaOReK19Xh2n5RwoL6xljf9eKM+7rBeuPCwj6l
 dOlEN031h6WB+DWN7KKeFFFR3xcCiYQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-nJGmg4-pOE218GOONX9GKA-1; Fri, 27 Nov 2026 12:42:37 +0000
X-MC-Unique: nJGmg4-pOE218GOONX9GKA-1
X-Mimecast-MFC-AGG-ID: nJGmg4-pOE218GOONX9GKA_1795783356
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4bb6bbc025aso62077855e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:42:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795783356; x=1796388156;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=69WYYzr2raKy4GZhRJJIx91GBcacgavIFPmAXCyscrM=;
 b=yjYh8uufH/9NLS464M7uFOWZ4acvQo8LRK7IsM62dLT+LLWythcce/OTd2fR4SKjdM
 WV+ibJYVh+NMbtK0M+34RJENzUOrlhp6x1RxkoLa992bo0wIDW1MNpun+TTRru8eVxCJ
 /uo4DzYLplqbN8hfYdkh2xT6ZC05bhqn4jUJ2KIdAC5Sykwt+Geer03yhn6yqdIK749v
 BCQMjcT34QRK3kfJ4fKbuK9jg9EbHn3Sa7AF7g4EiNDjgtG6TuwWZQrXYCGmSjhKg8xX
 3iNGmsA85qt0/18JqcZR5z3no2rtzIHiR3AZ/28U5wP9lyHU/S8GfL12yoRqRIcupuGr
 n3IQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFMDGqcFw8bVK/skRQneCpZWfb/Jb1mfEUgBp4VvTnsEjxLAC7L/0Mq03S6ybXU+PaRwxjnd8KnOFc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/UFTTeZvrPhxtBQTl597/MJ2eg1kIXl8udJjNrRJJEh495td1N
 DLqvq2zRQ2tZWdbE/iH04pgFNMxUIRyZ+lHUe6Qxgs3/W3JWTbzRKgOv2QlGqL25HIJXBz36gEr
 cLuLIVXaoBfLGrvfGGp1pHBX5NVRLJptFpHFDucNSSLUtY9LzNEMmPZGdyO8mSUL/QIaqQw==
X-Gm-Gg: AZFdTZfvJ9H7eMsM1k05xW8D0OE+MGf3qCwkwqCH+xX8tlxDfwoECmJNTDuMWa/JEsY
 wvOQx/4U/YuDX3171QqLj+gfOcTZMkcVh9wZoNJQnY4lUj74b5Z10m28weFPSnDJ3g/ndmzReV4
 xBqdSWqVdfKQoCt8ajxx4yEQAv9etmKWq06Runuj0xjpQn2/gZyKWsWaCQla3mN2BW3V5BFI08c
 E8+wMQjqZP7qp8NYoIbd6tEBqa/R5SuJ5FaIxxVxRtKqDaABp9m/u9f7lwTyGTHVUqULQ/o6+wE
 Bq7NzAdoHoKgi22MJnaC0b5QRGwk3bVqykbzdxAs0V1zIwxK+IFDisTPtwN80aLDe0gUwt2Iz7Z
 fEG0o20LRHXbqEYQZs3tio6W/nbwgzhEq5SlufG/5Ix9CWMldmAGa7fnOHSefdZk+B3OdfuG3Wu
 hMOVlU4GosT9AqZ31f+tU+
X-Received: by 2002:a05:600c:3ba9:b0:4a2:1050:aff with SMTP id
 5b1f17b1804b1-4bb8881c741mr568979965e9.6.1795783356043; 
 Fri, 27 Nov 2026 04:42:36 -0800 (PST)
X-Received: by 2002:a05:600c:3ba9:b0:4a2:1050:aff with SMTP id
 5b1f17b1804b1-4bb8881c741mr568979345e9.6.1795783355534; 
 Fri, 27 Nov 2026 04:42:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9?
 ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8538b09bsm1250929405e9.4.2026.11.27.04.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 04:42:35 -0800 (PST)
Message-ID: <1084ab13-d5c9-4154-b314-c7513b533c50@redhat.com>
Date: Fri, 27 Nov 2026 13:42:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/panic: Simplify QR error correction exponent
 reduction
To: peder.bergan@gmail.com, Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261126-perf-drm-panic-qr-v1-0-51856937dc4d@gmail.com>
 <20261126-perf-drm-panic-qr-v1-3-51856937dc4d@gmail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20261126-perf-drm-panic-qr-v1-3-51856937dc4d@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PMUNiLdG2jXiZW_o381oUbssCh-JpOVG2jbdU7PUQoU_1795783356
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
> Reed-Solomon error correction reduces the sum of two GF(256) exponents
> modulo 255 for each generator coefficient. Both exponents are below
> 255, so the sum needs at most one subtraction.
> 
> Use a conditional subtraction for the reduction. In the x86-64
> userspace benchmark, this replaces a multiply-and-shift sequence with
> a comparison and conditional moves. On top of the first two patches,
> the change saved about 32 us per version-40 encode with raw input and
> 31 us with a URL.

Thanks for your contribution.
This code is executed only once when a panic occurs, so optimizations 
are clearly not a priority.
But this series looks good, and keep the code simple.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
> ---
>   drivers/gpu/drm/drm_panic_helper_qr.rs | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_helper_qr.rs b/drivers/gpu/drm/drm_panic_helper_qr.rs
> index 1d96ae855052a..4ba2e3de5a6b6 100644
> --- a/drivers/gpu/drm/drm_panic_helper_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_helper_qr.rs
> @@ -569,7 +569,10 @@ fn error_code_for_blocks(&mut self, offset: usize, size: usize, ec_offset: usize
>               }
>               let log_lead_coeff = usize::from(LOG_TABLE[lead_coeff]);
>               for (u, &v) in tmp[i + 1..].iter_mut().zip(self.poly.iter()) {
> -                *u ^= EXP_TABLE[(usize::from(v) + log_lead_coeff) % 255];
> +                // Both exponents are below 255, so at most one subtraction is needed.
> +                let sum = usize::from(v) + log_lead_coeff;
> +                let index = if sum >= 255 { sum - 255 } else { sum };
> +                *u ^= EXP_TABLE[index];
>               }
>           }
>           self.data[ec_offset..ec_offset + self.ec_size]
> 

