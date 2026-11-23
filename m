Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D2606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HtPo1etC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEB4010E034;
	Mon, 23 Nov 2026 13:30:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D9310E034
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 13:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795440636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQXAfHWveCmdLSz3URl19N541Pjxo0PecFC7ymUqELE=;
 b=HtPo1etC6mj9jiDEzk+ShmN43aUIa2zOSZyb6zS3kL5FSN4WoXevWgg+KngZWGCHqqMyGJ
 jWk2vlHkVDBmR9M7BFH3Ow3yyqiiRV8pe5+IuPRksLUaAvjtdJgeomuEVJsb8l7pgU6z3R
 lMOYzClNPhxRcalUeAi96qrz9pqDUZc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-ju50aalBOGagM9b-HV-BqA-1; Mon, 23 Nov 2026 13:30:33 +0000
X-MC-Unique: ju50aalBOGagM9b-HV-BqA-1
X-Mimecast-MFC-AGG-ID: ju50aalBOGagM9b-HV-BqA_1795440632
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c504991a35eso329775666b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 05:30:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795440632; x=1796045432;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qQXAfHWveCmdLSz3URl19N541Pjxo0PecFC7ymUqELE=;
 b=wZ83WaOb0I02M8i4h7OVSrgS5qB8NKalvnJ0gyOwxNQpNITAMKXCjTVO47ud8yk60F
 ayTyuV+3msu45qUIbsyUr/jwav6EFYM+yJG6hh5lU+WRmPCr2hGCfqFOO3Ttn6R5ZCtt
 0ectx8U8MWyYpHp2JX4fMrzZAagzG7eQbcQCmHMnt4yzmJz8oHBz2ZfX4q3EMlUiWrTk
 07r/rt6lTaFK/ovd3RpO3MMeZwkwJegcF8aoPhCupHbjQDNrYthvN8AmWLMji1iUmKAQ
 LyffifiE0z+b+hcOhsjd49BkB0Xuvd8saN09TfRzEhQ63qnXBvIl8iJ6U+HqFPKC6gRb
 DxnA==
X-Forwarded-Encrypted: i=1;
 AL+hErGbFkz9Udy6z2GRrx0b/dB1wj9EHQqAi8ymPVNjURNvGISd7rXqqmzJjNMYq+/XoZ8qlnxJPkQaqOw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z90TQX8O7zNELv6axOws0XK1nm6mv7Adfg7xd6bRqcA/K2a7Niw
 gZn4a09YWGVoUDY/E6vqboObafJX8Xgvifje/OGGJXMWKevlJ+VXX4wOPT6iuZxhs2omQ8psTzf
 v/mXlGuC9ictVdARzcdNEUJgLmnIwGGMaYc+sJPEm7B+Kd3u8YMrMGlmRAy2KPnvZihn11Q==
X-Gm-Gg: AZFdTZcrlMBlmHi97H0Vy41S//eFZklw/LslPK0UrEVnYUV0zSJvwkS3OC6SSNQ0CQo
 v2MH9zVTDRexFbxas1xF0t4ziVdugQj7q8m0fyz/gR3jFLvJgpWRDh1fLiDlHx9Q8CoPwVosYbV
 IC29tclYpSTmhkwMLTTnA+aj7LdQ54T+gdJL2V7YLoTgoJiDSAw6MHZ7GFL/rGiZZwbTDucXpGl
 B9nsfn1g0Z3BCCv0h3ANedi28YwODvgxn0Da6HF0CdNKfWk8Les4Fk/g2n6Cs4+mJlT31Mq4tdi
 YmGhDgB6j6l8aNpsL8vtREzjL8EDfnHAFcAeTYnbsSQxs/+wI49Rrv7vI81WgDlWMO5dDQASFVi
 ykXs1Tmj0//EvJRYDc2RlZXzgxKoUbHgiOzvqQ88U7evWpNIWHPhxd1HGysdjAGyWtgf/xkOE15
 TV4IRB0Q==
X-Received: by 2002:a17:907:6089:b0:c4d:f63:642 with SMTP id
 a640c23a62f3a-c513a99e69bmr1071147266b.33.1795440632514; 
 Mon, 23 Nov 2026 05:30:32 -0800 (PST)
X-Received: by 2002:a17:907:6089:b0:c4d:f63:642 with SMTP id
 a640c23a62f3a-c513a99e69bmr1071144666b.33.1795440632158; 
 Mon, 23 Nov 2026 05:30:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9?
 ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513aea28f4sm418217466b.33.2026.11.23.05.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:30:31 -0800 (PST)
Message-ID: <dbbc50fd-1c02-4085-a142-0fe10b0103b8@redhat.com>
Date: Mon, 23 Nov 2026 14:30:29 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ast: Add an option to disable Write-Combine
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20261120155821.119377-1-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20261120155821.119377-1-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HGgpKikjAnREc7MMXiLm401OwQtvF7Ucl-pRFP5E6c4_1795440632
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

On 11/20/26 16:57, Thomas Zimmermann wrote:
> WC-mapped video memory presumably has PCI I/O bursts that interfere
> with real-time tasks. Seen on AST2600 hardware.
> 
> Add an Kconfig option to ast for vmapping the video memory uncached
> if CONFIG_RT=y. If set, video-memory access is slower, but avoids
> I/O bursts on the PCI us. Mirrors a similar change to mgag200 in
> commit b593ea940623 ("drm/mgag200: Add an option to disable
> Write-Combine").

Ok, so ast also is affected by this issue.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: f2fa5a99ca81 ("drm/ast: Convert ast to SHMEM")
> Cc: <stable@vger.kernel.org> # v6.2+
> ---
>   drivers/gpu/drm/ast/Kconfig  |  9 +++++++++
>   drivers/gpu/drm/ast/ast_mm.c | 13 +++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ast/Kconfig b/drivers/gpu/drm/ast/Kconfig
> index 242fbccdf844..f2c99e99b5b4 100644
> --- a/drivers/gpu/drm/ast/Kconfig
> +++ b/drivers/gpu/drm/ast/Kconfig
> @@ -14,3 +14,12 @@ config DRM_AST
>   	 is bound to the driver. These GPUs are commonly found
>   	 in server chipsets.
>   
> +config DRM_AST_DISABLE_WRITECOMBINE
> +	bool "Disable Write Combine mapping of VRAM"
> +	depends on DRM_AST && (PREEMPT_RT || COMPILE_TEST)
> +	help
> +	  The VRAM of AST GPUs is mapped with Write-Combine to improve
> +	  performances. This can interfere with real-time tasks; even if they
> +	  are running on other CPU cores than the graphics output.
> +	  Enable this option only if you run real-time tasks on a server with
> +	  Aspeed graphics.
> diff --git a/drivers/gpu/drm/ast/ast_mm.c b/drivers/gpu/drm/ast/ast_mm.c
> index 0bc140319464..cc882d2c172d 100644
> --- a/drivers/gpu/drm/ast/ast_mm.c
> +++ b/drivers/gpu/drm/ast/ast_mm.c
> @@ -74,6 +74,18 @@ int ast_mm_init(struct ast_device *ast)
>   {
>   	struct drm_device *dev = &ast->base;
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +#if defined(CONFIG_DRM_AST_DISABLE_WRITECOMBINE)
> +	resource_size_t base;
> +	u32 vram_size;
> +
> +	base = pci_resource_start(pdev, 0);
> +
> +	vram_size = ast_get_vram_size(ast);
> +
> +	ast->vram = devm_ioremap(dev->dev, base, vram_size);
> +	if (!ast->vram)
> +		return -ENOMEM;
> +#else
>   	resource_size_t base, size;
>   	u32 vram_size;
>   
> @@ -89,6 +101,7 @@ int ast_mm_init(struct ast_device *ast)
>   	ast->vram = devm_ioremap_wc(dev->dev, base, vram_size);
>   	if (!ast->vram)
>   		return -ENOMEM;
> +#endif
>   
>   	ast->vram_base = base;
>   	ast->vram_size = vram_size;
> 
> base-commit: 7d502136b31169f6b5575f7f89c3da60cdf7891d

