Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BE9F433FE
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA0410E822;
	Thu, 16 Apr 2026 07:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Wp4EN7fh";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46E1510E822
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776324296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RNbS7ThI/KngVwjbltueUrz2p8wYZX8d68X+Q0YBdA=;
 b=Wp4EN7fhxSI5OdkbCvtzjccewrFPZ4y24P2LypKBPsDa1GACfUCUDbUFLMsOL90q+atJB6
 qIZavmXkVuL7eos6Qh9frcDR8U0RacqFQ1o5R66E4Z9ZB4mu71W0pbHoNGufN4enlLNmqC
 ChvE/Uu2FpXmblNrrGjh61ygeQCvMoM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-PXxgJ1_7Psq5UcWzibAUAg-1; Thu, 16 Apr 2026 03:24:54 -0400
X-MC-Unique: PXxgJ1_7Psq5UcWzibAUAg-1
X-Mimecast-MFC-AGG-ID: PXxgJ1_7Psq5UcWzibAUAg_1776324294
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so63012475e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776324293; x=1776929093;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0RNbS7ThI/KngVwjbltueUrz2p8wYZX8d68X+Q0YBdA=;
 b=tZrHnBwI8Dg3eZB7ic9XCuJW8gpYHvhJ5pKDjd0shwsZPkKOg8Jc05cLUFwNX48lmq
 zuWHgc7FjtbeiZI1GpdVAWEU1GUsUOACVf+fNap9n+816ju5zrQt0Nc8IGpxDHJDUaxu
 HvovXzCbIE+3zAfliF6Vn8BiuMPGAWKsbmhYf2brlX1olM5sghahzfYbrulJyjyMrhlV
 C4LjKxkDgPgeZMb+xJ6OxI56xkkHg92vYQSYwCXFWvMKmsGf2355eabtR0gTKlUsAn6V
 WdRiXH+M09BtzOGP2LhisCKIUq+yvjul2I9Nyzf0dXnwOiiw7SwynPrdoC+zEyosvvq4
 ECXg==
X-Gm-Message-State: AOJu0Yx6Wiq4tXWU0xmKhNWDGSW1ppQbDhGBr/CU/hwoDaGd4l98BuqB
 1zPPX1AaveO/fHxywwLYK1VetT5lVzQheh8YJdYfzPa4IaT/pOGFH4qhBWTCXZeyQZCfLD2cvAw
 5vXzRMK5KtZWP45NtfFputQSvEKe8T5qdA9cZFYhHY8f07aLgGHHm0CC5H//3kSpwfvIZug==
X-Gm-Gg: AeBDieuIAhlJVSxPoO1qlUk/PihLzFTmGxkb85v0ShIcZS+iwqQWBHJ3OlFNNjd+69G
 vuoJI0qXqgih5AKhe0/dEzcpOVl0GjAE4a1ab0VFMwYHQhw2WmpdmAplcVajdmBHuW5j6aamHh4
 BeSzybiQ0XahMkFc3rPw8MdIhN87gSCveCKvEQXelXWtfJ/hhpfDK3r+BmxIRhPeUabrkD7wQSL
 M2hlMf7y6pnhsnl1YxSgChpMO8O9N7vRStgHFwD+o0W1iYaRWQnNQTcgjRn1NrPVK8vzLyCfAzm
 maD8KdV9m0dsbLgGveN/V/iN/hgi3MUeR6I01PYJ+key/wwMZyjY26saQzbBFAFskAhtx71wRqa
 GrwOg3qLdEA6e2laz0V7HG0ZfqoMiqV+hie7SDY9c9mGQXiQZyerKDoXSJMSIcg==
X-Received: by 2002:a05:600c:3b86:b0:488:aa3d:faca with SMTP id
 5b1f17b1804b1-488f71cef13mr5894505e9.18.1776324293643; 
 Thu, 16 Apr 2026 00:24:53 -0700 (PDT)
X-Received: by 2002:a05:600c:3b86:b0:488:aa3d:faca with SMTP id
 5b1f17b1804b1-488f71cef13mr5894075e9.18.1776324293155; 
 Thu, 16 Apr 2026 00:24:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62?
 ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f57da2aesm53872245e9.0.2026.04.16.00.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 00:24:52 -0700 (PDT)
Message-ID: <e92dd74b-3d11-4b59-9e8c-8f33f62bb487@redhat.com>
Date: Thu, 16 Apr 2026 09:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] drm/ast: Remove traces of DRM_FORMAT_RGB888 handling
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org
References: <20260414070522.33943-1-tzimmermann@suse.de>
 <20260414070522.33943-3-tzimmermann@suse.de>
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260414070522.33943-3-tzimmermann@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iOFK_F8VuG489pGfnFhoVS_Iyz8gPCvXRD0lnxvlFN8_1776324294
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

On 14/04/2026 09:02, Thomas Zimmermann wrote:
> There's some incomplete handling for DRM_FORMAT_RGB888 in the mode-
> setting code. It was added by ast's original commit, which imported
> the code from the user-space Xorg driver. But the hardware doesn't
> support 24-bit pixel sizes. Hence remove the traces of RGB888 from
> ast.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>   drivers/gpu/drm/ast/ast_mode.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index c150b83aaca7..49585fd16267 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -155,7 +155,6 @@ static void ast_set_vbios_color_reg(struct ast_device *ast,
>   	case 2:
>   		color_index = HiCModeIndex;
>   		break;
> -	case 3:
>   	case 4:
>   		color_index = TrueCModeIndex;
>   		break;
> @@ -765,7 +764,6 @@ static int ast_crtc_helper_atomic_check(struct drm_crtc *crtc,
>   	case DRM_FORMAT_RGB565:
>   		ast_state->std_table = &vbios_stdtable[HiCModeIndex];
>   		break;
> -	case DRM_FORMAT_RGB888:
>   	case DRM_FORMAT_XRGB8888:
>   		ast_state->std_table = &vbios_stdtable[TrueCModeIndex];
>   		break;

