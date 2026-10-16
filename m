Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9448CCF2C3
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 21:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B888D10E09A;
	Fri, 16 Oct 2026 21:09:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18DF610E09A
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 21:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792184989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h0qksnsO83V4fm5WG/41JKqf/QyvNW2rkxwNDprb2Xo=;
 b=XZvPrumE3vmsQGETj9rX36O/HpZZmCdspSawxHN/kZJ4RMNdaEfqCrJhrdf4XOakzMMqu+
 XAPFRuIkfCtIr+cO/Y5inTkvtPqSwGXSszij5mYigEjzjZxeyGOtftwVVaYE8GqoF35iMu
 m+HikPdn0QD4AJj25TU2OZGlQwyB7ZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-SBsEDCEXP1OdBpXzohAhyA-1; Fri, 16 Oct 2026 21:09:47 +0000
X-MC-Unique: SBsEDCEXP1OdBpXzohAhyA-1
X-Mimecast-MFC-AGG-ID: SBsEDCEXP1OdBpXzohAhyA_1792184986
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a009f82bedso2515895e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 14:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792184986; x=1792789786;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h0qksnsO83V4fm5WG/41JKqf/QyvNW2rkxwNDprb2Xo=;
 b=piEZV0ZTHP2JlOwM+zw+GMaPye+b+x1ykJhmKY7fWEDiaKu9UXwqKbPNvf3ltuROXb
 3tx/csYkcxQkEY32Nzr78OzXDR6ezn5Ay1NI8NuX7/tUs2EUur8gYwEJya2C6dCKoDAR
 VlbcE+KVBNpSrYhBrlRVWmMDWbpjAR4YbVSJ/L26N8PQpyWDPK/Ipdx6H719BVMTivxw
 9Nga1sjFi6Vi2B//0uUcqKai7gRz9iIEioWMC5hLQpGf5/YULPR6Q2uh2FenpM35QXvu
 XlUZqc1WYVtKZnI7QODXKjeB5eK3uIA+pA/7XmLkgTB01d0+kZYu0W1F9cBhpUxdCyAb
 RukA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUaa7KUwwNQetr3jwdY9O6ssDr2GH3uvApHIAmkWioscmh/X3Vc1tKRCMeSDiiyNXsQofEMs9O0QE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLmP+iLnjEDSTclRIBeNM5e3t7TCxyzF/V353z02MOiReUBrD+H
 bDfehg3qPLRxvwlTlH7dLeVSta4sDmnrUNQvGGknnpiwjq30yoVbNje8S2hN2ymM2ZZ5WnAE7mz
 GT42TfUATb4MUzDmjzgFCLBRJ3HTa5fdYYi+4O5pXA5oqzqpQ6vNcybioXqm8HTx//r4VHQ==
X-Gm-Gg: AYBFou0Jwb7PC1ygwrmxH3eg/Y7V7ySoXsO9LBCvs+OitGExSuIEdCH2G1OOTn7Ts7/
 5j5Cqzskj5NUFn9bhGTkXHL/2LOMk9cftRf8mA9BYy8fDYNe3sAzdi+EFjDKMqHKoNoceu1vJ0G
 IKaC0uj2KmyDIpYArEQZQ+naOZoBnbi8QBElt3luRYBizkrNuCJ3isyF/2ov3+MTpQDy9C341cj
 Q+Y73oIyirDPtVlxUXzgHJVYbfKlrrVuqoEjkmvEXH4Y3ozPvbaygnuKDDwgyzEl5tI87BcYin7
 FxOCoz5iqFmmF+yf6PPust/yc05GmBdJCSIYPjnaOKmHYrOLrX/WAx4SUtLc85VlP+PrtxyWy7E
 +3O/GnkL4/g504b801HRq/RY929T2yU1sc01M+8ij4xuX+H0=
X-Received: by 2002:a05:600c:6217:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4a1d7600654mr22700995e9.22.1792184986449; 
 Fri, 16 Oct 2026 14:09:46 -0700 (PDT)
X-Received: by 2002:a05:600c:6217:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4a1d7600654mr22700745e9.22.1792184986118; 
 Fri, 16 Oct 2026 14:09:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9?
 ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cca26dc8sm57458935e9.3.2026.10.16.14.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 14:09:43 -0700 (PDT)
Message-ID: <8e525023-dc47-416e-a3fe-c5e6c5660ca5@redhat.com>
Date: Fri, 16 Oct 2026 23:09:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panic: Fix kmsg screen hang on a long log line
To: Devin Wittmayer <lucid_duck@justthetip.ca>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 luyuantao <luyuantao01@163.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261016052722.60051-1-lucid_duck@justthetip.ca>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20261016052722.60051-1-lucid_duck@justthetip.ca>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GahnXsZGc-rw5SChm-QrwybdWj4LgdC8Jb_zekhtgMQ_1792184986
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
> The kmsg panic screen reads the log back one chunk at a time. A record
> that does not fit in a chunk comes back empty without moving on, so the
> screen asks for it again forever and the panic never finishes. Every
> oops logs the list of loaded modules, and on my machine that list does
> not fit.
> 
> Read into a buffer the size printk formats one record into, and stop if
> a read still comes back empty.

Thanks for investigating this issue.
That looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

I'm sorry, I probably forgot to push [1], so I will push both patches 
next week if no other comments.

[1] https://lore.kernel.org/all/20260126100732.365-1-luyuantao01@163.com/

Best regards,

-- 

Jocelyn
> 
> Fixes: 54034bebb22f ("drm/panic: Add a kmsg panic screen")
> Cc: stable@vger.kernel.org
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> ---
> I usually work on Wi-Fi drivers, so this is new ground for me. While I
> was testing a fix for a Wi-Fi driver crash, my test machine froze after
> the crash where it should have rebooted, and stayed that way until I
> power cycled it. Working out why led me here.
> 
> To reproduce, with the kmsg screen and panic=10 on a display driver with
> panic support, as root:
> 
>    printf "%600s\n" "" | tr ' ' x > /dev/kmsg
>    echo c > /proc/sysrq-trigger
> 
> Before this patch the panic never gets to its reboot.
> 
> QEMU, 10 runs each, on drm-misc-fixes and drm-misc-next (bochs) and
> 6.12.113 (simpledrm):
> 
>                                       before    after
>    one 600 char line                  hangs     reboots
>    same, then 400 short lines         hangs     reboots
>    one record of 300 short lines      hangs     reboots
>    oops with 24 modules loaded        hangs     reboots
>    plain panic                        reboots   reboots
> 
> amdgpu, 2 runs each, Arch's source and config, before and after:
> 
>    6.18.52, the two commands above    hangs     reboots
>    6.18.52, one record of 300 lines   hangs     reboots
>    6.18.52, oops                      hangs     reboots
>    7.2.6, kmsg screen set, oops       hangs     reboots
> 
> luyuantao's patch [1] stops reading once the screen is full, so it only
> helps the second row. With both on drm-misc-fixes, every row reboots.
> 
> The buffer is shared, like the QR code buffers; a panic only draws from
> one CPU. In drm-misc-next this code is in drm_panic_helper.c, where the
> same change was tested.
> 
> [1] https://lore.kernel.org/all/20260126100732.365-1-luyuantao01@163.com/
> 
>   drivers/gpu/drm/drm_panic.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index e576c4791861d..29b1487de7ae0 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -556,7 +556,8 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   	struct kmsg_dump_iter iter;
> -	char kmsg_buf[512];
> +	/* the size printk formats one record into, too big for the stack */
> +	static char kmsg_buf[2048];
>   	size_t kmsg_len;
>   	struct drm_panic_line line;
>   	int yoffset;
> @@ -574,6 +575,10 @@ static void draw_panic_screen_kmsg(struct drm_scanout_buffer *sb)
>   		char *start;
>   		char *end;
>   
> +		/* a record that does not fit comes back empty, every time */
> +		if (!kmsg_len)
> +			break;
> +
>   		/* ignore terminating NUL and newline */
>   		start = kmsg_buf + kmsg_len - 2;
>   		end = kmsg_buf + kmsg_len - 1;
> 
> base-commit: 324fac81f365fc123247f9c8a52cb66ebd93b5e5

