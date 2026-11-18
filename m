Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12E606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=T9zV66cW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A684910FF12;
	Wed, 18 Nov 2026 18:10:42 +0000 (UTC)
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C5410FF12
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:10:36 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-705cb6ceebaso1113144eaf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:10:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795025435; cv=none;
 d=google.com; s=arc-20260327;
 b=a3ZzuOqSdECm334wJZwkugt5fe2mKZ/d4ByNtbf7gpwBrrwXrRUDdM6L5zD06YNkKU
 t64rzHjIuAkZMNGmXPct7Mxpo3Cmz1PjAiG2MGNCRnQiu2yO4Y0y92YtGIcKjuYqY6hg
 cWX5No0RRJEBB2wtzW8GQWZ1+jdNNnz85jQO3spXX36fNDml8OORpJi0AyOJOW/Puua0
 2eZLpp4Sw99uLfWM+X0DzJpPmgw1/hu+b7C6d4pLmUpsLm59Lr1IqBoSt9lyWudsOuAK
 PMzg8zTbRgleSCK9//hVtIFgCNCgMxiRR1mbAuyoux2HroDYiDV/3IPxX8+WzcBBRkcE
 M/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uolXzpBiYugNP3qN288JOAr4dwNEE10S3HaS//txyFE=;
 fh=wwjClUP4O120bd60SjOSzjaqbcXhV6cNGMjDVhsuxEo=;
 b=EZ36rk9WyuJtBA1xaxTiPoNW5I68xFFv6a4IiybevS7FJ9wAHUVhbw0Y7Eclnck5TB
 m8V0wKE8q0zRInObZALCt+CopFv+gPDjtQXOZMYVaOWgzuTmi5Q7pcmnKwM6lRVDkYOI
 gmjf+PPD4CjU9Vdp6w1pOA2pNfQw7ygTiHizBI1EWGgqX+WLVRUSwkP7XfR/k2/kv+oY
 1js5MAN1lQoQW51oAA/ha5qzNvyjiGC78tJb5Akf4Loeapx0ZffFUoPIy3XW6COLJd5a
 eSY68BlkpdOqqqEBKqsud9XvlSx+HkV5X3eW7lFF3m0eZFm3Ya99VP/fDar775ywSqAg
 5ryQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1795025435; x=1795630235;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uolXzpBiYugNP3qN288JOAr4dwNEE10S3HaS//txyFE=;
 b=T9zV66cWbffqrWPlIJa8Kc0Hruv+2zMc7pbiISblaWRu/NFZJCOKTdBiAb5ON4dHSe
 INeVnYnWZKzOAPw8xBZgchkWqq1BRdUvTfPK799yKzD3GDUSpFyywaux7rcGvGOFV6qy
 edJS96jMDI32AhMTxlVpmiMS3T9Mv8f7F8adnBDs6Z7YCwDiD43aHRsTCoduVQyEZMpV
 V/c7Gtw7fONbZHzChjDg0tsDttWsfBKohSx+pvZzNfE3V+nOExAI/GwxAmSUWcqCNS5p
 CKC+9V/IIP0hhF38U1bJBVjyVwpZOlxPbkByV94IILDl3mPBH9Q5fmUTjXGu8DIOo0LT
 MrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795025435; x=1795630235;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uolXzpBiYugNP3qN288JOAr4dwNEE10S3HaS//txyFE=;
 b=DZ58YabuXI32U5//kb4l7+3ydqgUt3Z2C4mMA2JHYNXaA8gEpGo+fYWSPA/oRouQ55
 DvLdbER6sukKWjwV9LHEe//9WIgAvIPxbiwS3UkS4qMfVQ3GHFCfGR+ycAmgDCARSUA4
 vlRnEZfZdBQSJXfnA7aFS5KUJBp2L9nKU49QCK1xwF0tARpjENYvNKtcIVkmzL0P20f1
 J8xpZJ2CRaQP6DMtSrHPC3WJIQp7AY8xJNeqa3xQagPdI0iLLHsXoIjsBJFqWYGaT4qI
 qNxM28l5Y0e3qI2u2HFudZWR1cbegQPl1FwFmCQFb/2SsQxZidNsfcBfyTSyUmMjL3tv
 vI0g==
X-Forwarded-Encrypted: i=1;
 AL+hErHnbxhg4n8s020OlqMaMJ2ZUCYIoowzrWl7Y0aVckGBmvgOmhG+Vspd81YaDemobcWDfeGW6Gn9yrA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8KDi5ITBRb5/iojgmi2kNu1kGYM8vR1UmkfEdixP51QP/ZpIHY
 z1EatogZGuss/6hl3MCkemobhdr2rRn5VhcN+6/YB1y9EPAFW9Fl6QiA1Gmla1QRYJKExLBmhmQ
 EfyU5KuDHLJFqPMAyhpHeYzbXDRMfhfm4Hg2l1yiK1g==
X-Gm-Gg: AYBFou23ptCgh3fa6luBhdoOtnQS5FYNBcq/NVBnbAVp1ysO4FQrvgxZ2VwPEhgjTja
 7DY17LFyNXfqwhpos5cC4rg/a2VyyInWG9OasWiJzDgB5UCQCTeb9ICCnawb5pIZk7+iS5RKLdq
 gJACrltxcGaCHZcJLz4uvk5F8smmuzt0jBNrJZ8aPAxA11VMzTsf3iX1u/hQ270BgPG4HEFa4uR
 ZrDmB4a4OPcDSvCM6CAvz9EvEcpBC++YogBroquVDiJac/cr02OCJMOgT6ESn5IXOlb53t43GVh
 RNIsCrwfw1MhNryl2fxqHLKDRUHA0QGo6jKNOyqBXSYPoLPPYMcfgveYfEN+ijDyU7LHS+T3xkX
 exV9tBoWzBqXCIqbvAmGfXSYiLvW9ZTE7GvEhGasP6R2UIlvXZi33ecZ5NC2hFg2CiFnAb/cFTj
 0SwXrN/QNWwvRJU2ppJWicqkZeki22SZlIfYKkKwfXn/DBesb6Y2r37w==
X-Received: by 2002:a05:6820:16a0:b0:71b:187f:1d05 with SMTP id
 006d021491bc7-71b187f2097mr2537838eaf.68.1795025435512; Wed, 18 Nov 2026
 10:10:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028164539.3471833-1-henryzhang62@gmail.com>
 <20261028164539.3471833-2-henryzhang62@gmail.com>
In-Reply-To: <20261028164539.3471833-2-henryzhang62@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 18 Nov 2026 18:10:18 +0000
X-Gm-Features: AclHuK-V5dWIJh-3U7G0PyQp4ktkynFwmoHaphdoRy6ojuMQSX3jJwE03wIEwh8
Message-ID: <CAPY8ntA1CtSqtDzW-eziAzmLPZPbtWGpxBtYv0gCGMPNobcZWQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] drm/vc4: dsi: Set the transfer result before
 completing the transfer
To: Henry Zhang <henryzhang62@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 at 16:46, Henry Zhang <henryzhang62@gmail.com> wrote:
>
> On an HSTX timeout the interrupt handler completes the transfer and
> only then sets xfer_result to -ETIMEDOUT. The waiter, which may run on
> another CPU, can wake up and read xfer_result in between, still 0 from
> the start of the transfer, and report the timed-out transfer as a
> success.
>
> Set xfer_result first. complete() orders the store before the wake-up.
>
> Fixes: 4078f5757144 ("drm/vc4: Add DSI driver")
> Signed-off-by: Henry Zhang <henryzhang62@gmail.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>  drivers/gpu/drm/vc4/vc4_dsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 5ed3c35ee..aa2b46fb0 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -1526,8 +1526,8 @@ static irqreturn_t vc4_dsi_irq_handler(int irq, void *data)
>                 complete(&dsi->xfer_completion);
>                 ret = IRQ_HANDLED;
>         } else if (stat & DSI_PORT_BIT(INT_HSTX_TO)) {
> -               complete(&dsi->xfer_completion);
>                 dsi->xfer_result = -ETIMEDOUT;
> +               complete(&dsi->xfer_completion);
>                 ret = IRQ_HANDLED;
>         }
>
> --
> 2.47.3
>
