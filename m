Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3D8CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3921D10F4E2;
	Wed,  7 Oct 2026 13:18:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="EYFuzXCb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE37110F599
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 13:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791379077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3oBOZq9RtKAbT/TMUl/7ikCCKk20Q3D1Efbu3QClthQ=;
 b=EYFuzXCbC30cNFfibWqok5ntPSoMuGyH/ybVgQh2+s+IPZwYQLXjrgG4uHhTuUwevNSwmq
 8eAUpEgIfnI8+2uFDoziH4CkWhCAGDxunyM62EX8VanGmBfx6oa8JQqcQj4Al8+3ga1b8/
 ahODNI9ClNILEylQg1IZIh6DOHBecSU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-tPiyuXUCOP-jlQAsnTJRfg-1; Wed, 07 Oct 2026 09:17:55 -0400
X-MC-Unique: tPiyuXUCOP-jlQAsnTJRfg-1
X-Mimecast-MFC-AGG-ID: tPiyuXUCOP-jlQAsnTJRfg_1791379074
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso15159015e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 06:17:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791379074; x=1791983874;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3oBOZq9RtKAbT/TMUl/7ikCCKk20Q3D1Efbu3QClthQ=;
 b=QysOjZ/EgaShdnvRdWRv4Sk1yIjSR21oxGT1SaaOFFlkH7JhtmWRLLN8XLXZYJb9vS
 6vmUtz03TfIMj5P0JrBPP7tGN+9o4Fn4H+A+leD2PfJxgk7pqjK9s4C/TZdrZ0Rxh9Q/
 bPSd3aYh3SsSrilIg2IWIOEktxDOu5FMqvciarJEj/h5T30UPxpkoA7wCNnjR7l9oj78
 sS3TZObwESH3bEXPKxsaCRuZE7z6GXSjqqiisHQN86IM8yoaDEoQw9W/SjCA0XRMJP3D
 vAFpjRXf5AajI6VQzpuD1I4sgVGZaSF7kk6gh60BBqySuxs/bxeO7qA8lVz6txZfZ4mD
 GzAA==
X-Gm-Message-State: AFuF++maATGPZDoeRYzEMwsmaw4eFnXOqId2kK7TBPvAAr303TS461k1
 hjEfkaidDRc0IAAU5ZmYLRJ1mwY6313XIuCEfkpQQQxLFKe3ptJXThXBnG9GN4G4kzy9xScD0Vv
 AT3Vr+EnTfJ5cWSOiOUQDkrzNfyrXAYrzF84Id7oojMXdDth+x7HAHxNUfDUXcnUz3BIIhQ==
X-Gm-Gg: AYBFou1UJdHNJeYHug3FQYCAn1q+sx/xdpQGTuZ6rr2f/9Tzdmhowm9V2IEy8HsVsNJ
 dEMDcXBUgl5JMCPEW2C1YNMOXEXfLaIYsrXBpkjfh3PGbPSeRWhq3Es/kMsS9nuvLYdFmXuxo9Q
 lFel5UhPPU5B7JcYQlerlJLDJHlhdO1vYAfTt+NjT8IockAHskZHZVwBZDD9HSV4tZyQnxnplbh
 wr7SqytUNGWrapG2uqiTfObRrdE/U//gcXXtI6QYZtdBoUE+H78Kg3Rd+BZvO0hsMMLC7HtbC7d
 iQMUU8JqrvRLvK4tmy2zdFHaaB9E08NrKMemQLYzD9/bAO9NmTnP/9DCv94WBwSTdLQKr0/GfwD
 2pfna03q1LEh0vqwdnLHwGgnFfyheb99N+k9M5fbPRRhbDL8s
X-Received: by 2002:a05:600c:5646:b0:49d:2589:d8e9 with SMTP id
 5b1f17b1804b1-4a178a25222mr80543245e9.11.1791379074190; 
 Wed, 07 Oct 2026 06:17:54 -0700 (PDT)
X-Received: by 2002:a05:600c:5646:b0:49d:2589:d8e9 with SMTP id
 5b1f17b1804b1-4a178a25222mr80541655e9.11.1791379072603; 
 Wed, 07 Oct 2026 06:17:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9?
 ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71c0b60fsm5378202f8f.8.2026.10.07.06.17.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 06:17:51 -0700 (PDT)
Message-ID: <24ad6178-2f3b-4f84-91b5-c1f4fb92a21b@redhat.com>
Date: Wed, 7 Oct 2026 15:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panic: allow overriding panic QR code URL
To: Nahida Buer <me@nahida.im>
Cc: dri-devel@lists.freedesktop.org,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20261002203140.121165-1-me@nahida.im>
 <20261002222021.149450-1-me@nahida.im>
 <c4da60aa-bbbb-4afa-bd86-6516d14f5809@redhat.com>
 <CAEEzyciisJgZgx4PZQbEEkUUKRMpiAsmmsW9JfQzwCCDx4xZKA@mail.gmail.com>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CAEEzyciisJgZgx4PZQbEEkUUKRMpiAsmmsW9JfQzwCCDx4xZKA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fwb9_UzTOqp8OSf8ZMeoSGLdKt11nM69nCyuGecJCYw_1791379074
X-Mimecast-Originator: redhat.com
Content-Language: en-US, fr
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 10/3/26 01:03, Nahida Buer wrote:
> Thanks for the review.
> 
> My motivation was slightly different from disabling the URL when the
> configured endpoint is untrusted or unavailable. I wanted to keep the
> URL QR mode while allowing the same kernel image to use a different
> reporting endpoint depending on the deployment.
> 
> It also allows enabling the compressed URL mode without rebuilding the
> kernel. With an empty CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL, the QR code
> contains the raw kmsg. Supplying drm.panic_qr_url= at boot instead
> switches it to the URL format, where the kmsg is compressed with zlib.
> 
> This could be useful for a distribution or a locally built kernel image
> used on multiple systems: the image can keep a neutral/default
> configuration, while individual systems can opt into a specific panic
> report collector and compressed QR payload at boot time.
> 
> panic_screen=user or panic_screen=kmsg only disables the URL QR mode;
> it does not provide a way to keep that mode while changing or enabling
> the reporting endpoint.
> 
> The parameter is read-only after initialization, so it only selects the
> endpoint at boot/module load time.
> 
> If keeping the URL fixed at build time is intentional policy for DRM
> panic, though, I'm fine with dropping the patch.

After thinking more about this, I prefer to keep the URL fixed at build 
time.
I hope it won't refrain you from contributing again.

Best regards,

-- 

Jocelyn
> 
> Jocelyn Falempe <jfalempe@redhat.com> 于2026年10月3日周六 06:56写道：
>>
>> On 10/3/26 00:20, 纳西妲 · Nahida wrote:
>>> The base URL used for the panic QR code is currently fixed at build time
>>> by CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL. Changing the panic report
>>> endpoint therefore requires rebuilding the kernel.
>>>
>>> Add a drm.panic_qr_url module parameter to allow overriding the URL at
>>> boot or module load time, while keeping the Kconfig value as the
>>> default.
>>>
>>> Keep the parameter read-only after initialization so the panic path can
>>> access it without additional synchronization.
>>>
>>> Expose the configured URL to the DRM panic helper through an internal
>>> getter so the helper can use the runtime value when generating the QR
>>> code.
>>
>> The code looks good, but I think it shouldn't be allowed to change this
>> setting at boot time.
>> You can already set the drm_panic screen to "user" or "kmsg" in the
>> kernel command line if you don't trust the default URL, or if the URL is
>> no more reachable.
>> It introduces some complexity, and I don't really see the benefit.
>>
>> Best regards,
>>
>> --
>>
>> Jocelyn>
>>> Assisted-by: LLM
>>> Signed-off-by: 纳西妲 · Nahida <me@nahida.im>
>>> ---
>>> v2:
>>> - Grow the formatted URL buffer to accommodate the maximum 255-byte
>>>     runtime base URL.
>>> - Reject unexpectedly truncated formatted URLs.
>>> - Test the maximum-length runtime URL.
>>>
>>> v1: https://lore.kernel.org/r/20261002203140.121165-1-me@nahida.im
>>>
>>> Tested on x86_64:
>>> - Full modular build with DRM=m and DRM_KMS_HELPER=m.
>>> - QEMU/virtio-gpu runtime override with a non-empty Kconfig default URL.
>>> - QEMU/virtio-gpu runtime fallback to the Kconfig default URL.
>>> - QEMU/virtio-gpu runtime override with an empty Kconfig default URL.
>>> - QEMU/virtio-gpu raw kmsg QR fallback with no configured URL.
>>> - QEMU/virtio-gpu runtime override with a 255-byte base URL.
>>>
>>>    drivers/gpu/drm/Kconfig              |  9 +++++----
>>>    drivers/gpu/drm/drm_panic.c          |  9 +++++++++
>>>    drivers/gpu/drm/drm_panic_helper.c   | 17 +++++++++++------
>>>    drivers/gpu/drm/drm_panic_internal.h |  4 ++++
>>>    4 files changed, 29 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>>> index 61111d50b..3d9d421f0 100644
>>> --- a/drivers/gpu/drm/Kconfig
>>> +++ b/drivers/gpu/drm/Kconfig
>>> @@ -111,10 +111,11 @@ config DRM_PANIC_SCREEN_QR_CODE_URL
>>>        string "Base URL of the QR code in the panic screen"
>>>        depends on DRM_PANIC_SCREEN_QR_CODE
>>>        help
>>> -       This option sets the base URL to report the kernel panic. If it's set
>>> -       the QR code will contain the URL and the kmsg compressed with zlib as
>>> -       a URL parameter. If it's empty, the QR code will contain the kmsg as
>>> -       uncompressed text only.
>>> +       This option sets the default base URL to report the kernel panic. If
>>> +       it's set the QR code will contain the URL and the kmsg compressed with
>>> +       zlib as a URL parameter. If it's empty, the QR code will contain the
>>> +       kmsg as uncompressed text only. It can be overridden with the
>>> +       drm.panic_qr_url=<url> kernel parameter.
>>>          There is a demo code in javascript, to decode and uncompress the kmsg
>>>          data from the URL parameter at https://github.com/kdj0c/panic_report
>>>
>>> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
>>> index 9fe97c4ed..463544f71 100644
>>> --- a/drivers/gpu/drm/drm_panic.c
>>> +++ b/drivers/gpu/drm/drm_panic.c
>>> @@ -49,6 +49,15 @@ MODULE_LICENSE("GPL");
>>>    static uint panic_qr_version = CONFIG_DRM_PANIC_SCREEN_QR_VERSION;
>>>    module_param(panic_qr_version, uint, 0644);
>>>    MODULE_PARM_DESC(panic_qr_version, "maximum version (size) of the QR code");
>>> +static char panic_qr_url[256] = CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL;
>>> +module_param_string(panic_qr_url, panic_qr_url, sizeof(panic_qr_url), 0444);
>>> +MODULE_PARM_DESC(panic_qr_url, "base URL of the QR code in the panic screen");
>>> +
>>> +const char *drm_panic_get_qr_url(void)
>>> +{
>>> +     return panic_qr_url;
>>> +}
>>> +EXPORT_SYMBOL_GPL(drm_panic_get_qr_url);
>>>    #endif
>>>
>>>    static enum drm_panic_type drm_panic_type = -1;
>>> diff --git a/drivers/gpu/drm/drm_panic_helper.c b/drivers/gpu/drm/drm_panic_helper.c
>>> index 8913c3d22..b0ea0b4e8 100644
>>> --- a/drivers/gpu/drm/drm_panic_helper.c
>>> +++ b/drivers/gpu/drm/drm_panic_helper.c
>>> @@ -609,17 +609,20 @@ static void drm_panic_helper_qr_exit(void)
>>>        stream.workspace = NULL;
>>>    }
>>>
>>> -static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned int qr_version)
>>> +static int drm_panic_helper_get_qr_code_url(u8 **qr_image, unsigned int qr_version,
>>> +                                         const char *qr_url)
>>>    {
>>>        struct kmsg_dump_iter iter;
>>> -     char url[256];
>>> +     char url[512];
>>>        size_t kmsg_len, max_kmsg_size;
>>>        char *kmsg;
>>>        int max_qr_data_size, url_len;
>>>
>>>        url_len = snprintf(url, sizeof(url), "%s?a=%s&v=%s&z=",
>>> -                        CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL,
>>> -                        utsname()->machine, utsname()->release);
>>> +                        qr_url, utsname()->machine, utsname()->release);
>>> +
>>> +     if (url_len >= (int)sizeof(url))
>>> +             return -E2BIG;
>>>
>>>        max_qr_data_size = drm_panic_helper_qr_max_data_size(qr_version, url_len);
>>>        max_kmsg_size = min(MAX_ZLIB_RATIO * max_qr_data_size, QR_BUFFER1_SIZE);
>>> @@ -686,8 +689,10 @@ static int drm_panic_helper_get_qr_code_raw(u8 **qr_image, unsigned int qr_versi
>>>
>>>    static int drm_panic_helper_get_qr_code(u8 **qr_image, unsigned int qr_version)
>>>    {
>>> -     if (strlen(CONFIG_DRM_PANIC_SCREEN_QR_CODE_URL) > 0)
>>> -             return drm_panic_helper_get_qr_code_url(qr_image, qr_version);
>>> +     const char *qr_url = drm_panic_get_qr_url();
>>> +
>>> +     if (qr_url[0])
>>> +             return drm_panic_helper_get_qr_code_url(qr_image, qr_version, qr_url);
>>>        else
>>>                return drm_panic_helper_get_qr_code_raw(qr_image, qr_version);
>>>    }
>>> diff --git a/drivers/gpu/drm/drm_panic_internal.h b/drivers/gpu/drm/drm_panic_internal.h
>>> index fe6d514a0..f33552265 100644
>>> --- a/drivers/gpu/drm/drm_panic_internal.h
>>> +++ b/drivers/gpu/drm/drm_panic_internal.h
>>> @@ -14,6 +14,10 @@ struct drm_device;
>>>
>>>    #ifdef CONFIG_DRM_PANIC
>>>
>>> +#if IS_ENABLED(CONFIG_DRM_PANIC_SCREEN_QR_CODE)
>>> +const char *drm_panic_get_qr_url(void);
>>> +#endif
>>> +
>>>    /**
>>>     * drm_panic_lock - protect panic printing relevant state
>>>     * @dev: struct drm_device
>>>
>>> base-commit: 54e61ea6c492d69a1717018826d8340810c812eb
>>
> 

