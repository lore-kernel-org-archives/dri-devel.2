Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CB606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bdybQofj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F0210E5C8;
	Fri, 27 Nov 2026 12:42:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C4A10E5C8
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795783332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtKiZFj6Ka7y5JG1hKNNq0d21tsqo0FM1O+R6HYWx5Q=;
 b=bdybQofjok/CkY3Y80g3znOGhlGxqpH+DMc+eugTtXO3/ka4vehF7V+5PoRD8Z56Wa07IV
 aaOz/f14XUx1FVUd6Ck/G6gLqfeASSLG8sQZkoVKTmiXBZrEuGhRg2XWGfRrH958sQBrl4
 LYk5FbdGXl5Lp9sgjtKJeXlTqLKF1fc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-SvzsNhgsMsyrf48dGmAm2A-1; Fri, 27 Nov 2026 12:42:08 +0000
X-MC-Unique: SvzsNhgsMsyrf48dGmAm2A-1
X-Mimecast-MFC-AGG-ID: SvzsNhgsMsyrf48dGmAm2A_1795783327
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4bb8ae35aeaso66521715e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795783327; x=1796388127;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VtKiZFj6Ka7y5JG1hKNNq0d21tsqo0FM1O+R6HYWx5Q=;
 b=KiwlPOAi5jSivKHzSCWmONqt+gsYJAsUmAz5r7+WlddUWYSeQycLjHK9cwmsO6CWZc
 sZbUWrGmS1dfbNQAjGOPR8KSR5yS3lcccBPmbBaPUgpe6EHla/jDhwdWcT3xO4lRk55H
 o0W7FNNqIaBVTTVXazXEWBfPT+9TXxadS8rHmYgZBZzJyR2nwxOjKBUMwEQO7Af06/gK
 qhv5PoQ6KTlVb+5epod+RonQ6AbCTCUYEiMpA+wN620a5KinO8UJQxYZE1pZdfcqR9RD
 UkfdRvWw2UtWfhb5OG6IC9GyPeqaGpe8SgikWhzUSt3lDzEUwzmcNm7MsnIk9RCtvcPm
 bW8Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGzxUq+CRwKM1E7pIh/jjx2Aia7/L4eetnfWn41drcci9pmusYzg3QM40aNG0e0fxB8N5FUlODL7IE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8aoKORYpT1FtXSYEnugEy8slmjOfAptfdAfpbQoallA0PrWIen
 J/Ztlm9cWZIRX65kvNx4zpgsmiMEKaOnRIhSX9N7HmR8vRsAGj8vDcomAYHpWsWwbrhkp61IkkT
 kxZamRx9pRocN6n9JLRW4QetlrJ3FcMBnG0kHnifecVRsYLzRLSMUcueltSOZoREDPs5cNg==
X-Gm-Gg: AZFdTZfejxLtK49gU1/edDsBrEOLcwcSWavOKDHppA5L7Mvl189qXLY7cg1oYRmTief
 QW6v23T57cO9GhzYf8nHAvBvu+wbUu0/57ep9OS8whb2KBeAW0svC9ZNFI+TCVxAXz6476oXso/
 K8wItm8nnn2jlE165JmhOugZV8+HP2Zd1O3r6YzsLW2/lcRSCpremMtDia+1r06g9xIwKo8Syvv
 VIIN0si4hvShYMOCgaWNOI5qH1sku/5jOF/dWiEyjGoy62MNNj7ChD8smh1ujqEqTDo4HnFFUKJ
 MR1zQ4uWpIDQ7P6eVbeoMj2WP7Yy+viWEPniTC1xr6we39B9WkSln7/4ltzY0Tx594s6XfGwjb1
 HCnBjXRSN9/XM6oCXDfa7zkiOeAXzKK0/h4JPNi+0iXsKzwFQlGLXGnczLH1n08wZA8yULAibxl
 cK2rmYpg==
X-Received: by 2002:a05:600c:4e02:b0:4bb:8636:dd7d with SMTP id
 5b1f17b1804b1-4bb88817f77mr489726725e9.24.1795783326726; 
 Fri, 27 Nov 2026 04:42:06 -0800 (PST)
X-Received: by 2002:a05:600c:4e02:b0:4bb:8636:dd7d with SMTP id
 5b1f17b1804b1-4bb88817f77mr489726405e9.24.1795783326379; 
 Fri, 27 Nov 2026 04:42:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9?
 ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8533579csm593732225e9.2.2026.11.27.04.42.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 04:42:06 -0800 (PST)
Message-ID: <4ccdd654-f8af-4e51-a8ac-ae7f68f0db07@redhat.com>
Date: Fri, 27 Nov 2026 13:42:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/panic: Apply the QR mask while drawing data
 modules
To: peder.bergan@gmail.com, Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261126-perf-drm-panic-qr-v1-0-51856937dc4d@gmail.com>
 <20261126-perf-drm-panic-qr-v1-2-51856937dc4d@gmail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20261126-perf-drm-panic-qr-v1-2-51856937dc4d@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DKoB4YHHSF8MhVJxK1V5zDPQeZeLx2GkM7R5IW4bw3A_1795783327
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
> After placing data and remainder modules, apply_mask() scans the whole
> image to invert the unreserved modules covered by checkerboard mask 0.
> Data placement already visits every unreserved module once.
> 
> Apply mask 0 while drawing each data module and each zero-valued
> remainder module. This removes the separate image pass and its buffer
> read-modify-write operations. The format information still advertises
> mask 0.
> 
Thanks for your contribution.
This code is executed only once when a panic occurs, so optimizations 
are clearly not a priority.
But this series looks good, and keeps the code simple.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>
> ---
>   drivers/gpu/drm/drm_panic_helper_qr.rs | 35 +++++++++++-----------------------
>   1 file changed, 11 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_helper_qr.rs b/drivers/gpu/drm/drm_panic_helper_qr.rs
> index c6ed395c05bd2..1d96ae855052a 100644
> --- a/drivers/gpu/drm/drm_panic_helper_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_helper_qr.rs
> @@ -691,12 +691,6 @@ fn set(&mut self, x: u8, y: u8) {
>           self.data[off] = v;
>       }
>   
> -    /// Invert a module color.
> -    fn xor(&mut self, x: u8, y: u8) {
> -        let off = y as usize * self.stride as usize + x as usize / 8;
> -        self.data[off] ^= 0x80 >> (x % 8);
> -    }
> -
>       /// Draw a light square at (x, y) top left corner.
>       fn draw_square(&mut self, x: u8, y: u8, size: u8) {
>           for k in 0..size {
> @@ -864,37 +858,31 @@ fn next_available(&self, x: u8, y: u8) -> (u8, u8) {
>           (x, y)
>       }
>   
> +    /// Draw an unreserved module with checkerboard mask 0.
> +    fn draw_data_module(&mut self, x: u8, y: u8, bit: bool) {
> +        let invert = (x ^ y) % 2 == 0;
> +        if !(bit ^ invert) {
> +            self.set(x, y);
> +        }
> +    }
> +
>       fn draw_data(&mut self, data: impl Iterator<Item = u8>) {
>           let (mut x, mut y) = (self.width - 1, self.width - 1);
>           for byte in data {
>               for s in 0..8 {
> -                if byte & (0x80 >> s) == 0 {
> -                    self.set(x, y);
> -                }
> +                self.draw_data_module(x, y, byte & (0x80 >> s) != 0);
>                   (x, y) = self.next_available(x, y);
>               }
>           }
> -        // Set the remaining modules (0, 3 or 7 depending on version).
> -        // because 0 correspond to a light module.
> +        // The remaining modules encode zero before masking.
>           while !self.is_last(x, y) {
>               if !self.is_reserved(x, y) {
> -                self.set(x, y);
> +                self.draw_data_module(x, y, false);
>               }
>               (x, y) = self.next(x, y);
>           }
>       }
>   
> -    /// Apply checkerboard mask to all non-reserved modules.
> -    fn apply_mask(&mut self) {
> -        for x in 0..self.width {
> -            for y in 0..self.width {
> -                if (x ^ y) % 2 == 0 && !self.is_reserved(x, y) {
> -                    self.xor(x, y);
> -                }
> -            }
> -        }
> -    }
> -
>       /// Draw the QR code with the provided data iterator.
>       fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
>           // First clear the table, as it may have already some data.
> @@ -905,7 +893,6 @@ fn draw_all(&mut self, data: impl Iterator<Item = u8>) {
>           self.draw_version_info();
>           self.draw_data(data);
>           self.draw_maskinfo();
> -        self.apply_mask();
>       }
>   }
>   
> 

