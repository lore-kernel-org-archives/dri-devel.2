Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C031606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZIckwPby
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0C8E112AF2;
	Fri, 20 Nov 2026 14:35:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5AEA112B02
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 14:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795185304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PttDiclza9AIWquWpENwIDPE7a6gtcFVbDNgaC+t2sg=;
 b=ZIckwPbylA9hN7BcEw9dhIewdlsK/EdqsNLF4P0IUPrMmK7oSOR7uC8gDNVBwSbRLhqA3M
 XLN0WFWSiOWVdMQT2Vre7ZmowH/B0rWEnItKUD8rK62eGnhDHpRWYAu8uEBcnrLzjil1tr
 AKDV/pdFnEcuf7jSwYedwZoMPYOBtCI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-QOEnV_gBPrC7Jc7AytHzQg-1; Fri, 20 Nov 2026 14:35:02 +0000
X-MC-Unique: QOEnV_gBPrC7Jc7AytHzQg-1
X-Mimecast-MFC-AGG-ID: QOEnV_gBPrC7Jc7AytHzQg_1795185302
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6b6fb975053so1025521a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 06:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795185302; x=1795790102;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PttDiclza9AIWquWpENwIDPE7a6gtcFVbDNgaC+t2sg=;
 b=AxhDgbfPR4dweJPULd/UW71JdVdjPmyYRMF6Igr3hDQGxkuOHNpPQES4cZyFuNCShs
 5YfeWQ5azmvQXeAc70/a6vNl+0n6/zIlb2UmxES8igER999fVIFtjv2DSqbnKGnhFwuM
 zqh98dsL9/FdSmc6LYFwu4WH+3YS7Wss0zr/yg7rxdPE7/Li8Tp0J57qEUrn/q3TtJJS
 l1A53MUij2ElSNNolYJ0nDXLuaW/3D6O+ED1K0TNi62cGz3CtXDSY4tZ0tj7VLM6gt+k
 Mlvex2LbX6JpVl4G7KaKh8qD58TCPhyYU/aet7sAvfnwrE0UER/q2w6wi0zTnCo4WFGU
 WBOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHF4bhnwVL3g4+itxn3dj84sszPH+eGcXc86ZuQVbzeRGWfxJaEtfxxDBRcLCYDzuDCHXrISSJ5uxw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+BoB/2pvkPcccBahc/cjQfbOc7z53NgjYFsxHr/ZaRuuoOM7Yz
 ZwLU2+IFd2zujkh8VA0pz8V45Ro3denIAVCgRGMThcgecnqU1iULaOURPN/e6GgW0nEOAmeZrci
 mA4yJWO0xGZckkBFJbYCPAQEx8ICsXSYdyDs+3yLUtNsTqz2qFupWlXdxvHsgSJbzwjoa3g==
X-Gm-Gg: AZFdTZfIHpW5LvQ+OWg631pQAAD91Pc4gRE1aG+IT99kqSR/EsXSe0X8btTcpnEwSSL
 77aMbi4NgK126MbnYyCze2Hldv9Klaz46C3OuZRTXFV6qzaA6phbDKnG0AH7JWiLaYrlrZehGs/
 jWV9iYcNkk2ivKVPGi8t447LxEN454mzlQBVIRosz95lCJRive+TT6KT+O6MHw3aIbPMHZp6dlh
 8gTRo9dL1Eb/jIl3lj9u2NRaKqz/Rtsr/l8FcwmEjj0K+xojQI9fH7eyzR4eiphgslsBSTSfvOZ
 xClELWooHsd8url7QJP49j0LPYWSh5QUhTKPQJg+hidNqIugWVBrrOt6QoeMhjQp8nG6iqS4oCD
 s8G9gJIhrR1yn21cdCZ9NL5T6mQsTKWxpzWTtkeIm3RmpO3ybV7wvAgo5F3gzL3d22BYsjA2JzJ
 Fq/J5H2N4z7jpl8iEHo9vi
X-Received: by 2002:a05:6402:895:b0:6ba:ad4:2c43 with SMTP id
 4fb4d7f45d1cf-6ba37c7a76fmr1882688a12.5.1795185301787; 
 Fri, 20 Nov 2026 06:35:01 -0800 (PST)
X-Received: by 2002:a05:6402:895:b0:6ba:ad4:2c43 with SMTP id
 4fb4d7f45d1cf-6ba37c7a76fmr1882673a12.5.1795185301389; 
 Fri, 20 Nov 2026 06:35:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9?
 ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba36e355easm1185033a12.3.2026.11.20.06.35.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Nov 2026 06:35:00 -0800 (PST)
Message-ID: <dc4518d6-c62c-428a-94a2-39c84cafc83a@redhat.com>
Date: Fri, 20 Nov 2026 15:34:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panic: Bring back the kmsg screen fixes lost in a
 merge
To: Devin Wittmayer <lucid_duck@justthetip.ca>,
 Javier Martinez Canillas <javierm@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 desobei <desobei@outlook.com>, luyuantao <luyuantao@kylinos.cn>
References: <20261119191038.146963-1-lucid_duck@justthetip.ca>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20261119191038.146963-1-lucid_duck@justthetip.ca>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -a-RKSdJo4_GLiVsLEpuodSPYKPu7pfAjug0YJjx6go_1795185302
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

On 11/19/26 20:10, Devin Wittmayer wrote:
> Commit b537d87d2632 ("drm/panic: Fix the loop that causes kmsg to not
> display correctly") and commit 1ba640563843 ("drm/panic: Fix kmsg screen
> hang on a long log line") changed the old panic file. By the time they
> reached drm-fixes, that code had moved into the helper library, and the
> merge left the helper as it was.
> 
> So the panic screen that prints the kernel log hangs again on a long
> log line, and the machine never reboots. The helper's KUnit suite hangs
> the same way.
> 
> Make both changes in the helper.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

So I'll push it again to drm-misc-next.

-- 

Jocelyn
> 
> Fixes: 5c3d323984fd ("drm/panic: Move panic display code into helper library")
> Reported-by: desobei <desobei@outlook.com>
> Closes: https://lore.kernel.org/all/PH7PR19MB6658FDBDD012399C6E8D330FAF792@PH7PR19MB6658.namprd19.prod.outlook.com/
> Tested-by: desobei <desobei@outlook.com>
> Cc: luyuantao <luyuantao@kylinos.cn>
> Signed-off-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> ---
> Both were lost in merge 1c3b1398f1cf. My other fix in that pull, for
> the panic screen setting, made it through.
> 
> Panics with a long line in the log, on drm-misc-fixes:
> 
>                                without this    with this
>      QEMU, 40 panics           all hang        all reboot
>      AMD mini PC, 8 panics     all hang        all reboot
> 
> Panics with nothing long in the log reboot either way.
> 
>   drivers/gpu/drm/drm_panic_helper.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_panic_helper.c
> index 8913c3d22e8d..385a07ed314b 100644
> --- a/drivers/gpu/drm/drm_panic_helper.c
> +++ b/drivers/gpu/drm/drm_panic_helper.c
> @@ -513,7 +513,8 @@ VISIBLE_IF_KUNIT int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer
>   	const struct font_desc *font = get_default_font(sb->width, sb->height, NULL, NULL);
>   	struct drm_rect r_screen = DRM_RECT_INIT(0, 0, sb->width, sb->height);
>   	struct kmsg_dump_iter iter;
> -	char kmsg_buf[512];
> +	/* the size printk formats one record into, too big for the stack */
> +	static char kmsg_buf[2048];
>   	size_t kmsg_len;
>   	struct drm_panic_line line;
>   	int yoffset;
> @@ -530,10 +531,15 @@ VISIBLE_IF_KUNIT int drm_panic_helper_draw_screen_kmsg(struct drm_scanout_buffer
>   	drm_panic_helper_fill(sb, &r_screen, bg_color);
>   
>   	kmsg_dump_rewind(&iter);
> -	while (kmsg_dump_get_buffer(&iter, false, kmsg_buf, sizeof(kmsg_buf), &kmsg_len)) {
> +	while (yoffset >= 0 && kmsg_dump_get_buffer(&iter, false, kmsg_buf,
> +	       sizeof(kmsg_buf), &kmsg_len)) {
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

