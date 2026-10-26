Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D32606A31D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 18:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=raspberrypi.com header.i=@raspberrypi.com header.a=rsa-sha256 header.s=google header.b=KLuGUXBH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3588F10E353;
	Mon, 26 Oct 2026 18:20:07 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A245010E353
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 18:20:00 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-4a77dcc4ca0so1582443fac.2
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:20:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793038800; cv=none;
 d=google.com; s=arc-20260327;
 b=Z2Cw1bwXzvz8npx06Y//BtGMni8olr3/gw0rUILd4ZIkVwPo6dkT20Q/1wlq1CBUI2
 hjNZRQoPh6UWt5Ifzi2lyY9JfR3/FUQ+0+picowgyPb7X7aC1o9/c8uvJN30wRQwjr4E
 ATMN9FFxOHgmG4tBH6P5KzB4kHXMTEEJuap5CRIe5/pLukJ6mAezwfAStSzFbuwOD2zC
 Cc2yVzOn2z5bDhyC3QX9ZJDY+p6cp694JO5oyBtSLJvDEcoN6R9CiIXlpYZ86T9g6Vz+
 Dc3qv0Lx76Xy/THtf2WzP8QCUtA0m1SatRhuc22n3611oca76IAyLKxdPq1OrwR0VRyp
 FDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=WA5AxzH89R1SOTsw3YYXHEoBQlAVi2xqh5J2QmPmhV8=;
 fh=+c2URaRTaGObUUrT/eBdBW9gT89wJdTV7ZJhQhRnPcA=;
 b=q8EVR394ulz4DmW4sFOPxsiDWT/OGKNvtW3VJYP120lmYf6AlLaJwZcaCINnvAFXPZ
 5SLWDgM3eAUfTMliBqy1sR/VV72XtnwwY/yS7eI7jHTWXrj6tMwCCYZ1mtSlaoH+bSGr
 YWONuLMUWVdDJnMRs9/hamudcYh2y9wAChr86xEUk2eVXQhUZYifokIKIZlnAEQT68mZ
 M2LMvfQ4T0iyxqSLxYvFhfiR+L/uw89c7tXn2x4JydkMEmDsONKrdjGNKv4rkeYpRCRQ
 2UpFmcn8imTv5MmjWoTAk2KQ4CB0Ri4iBhg+lwuz1ihMKhsRdXzBZbU5fCNb3C/bvyCb
 Wdqw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raspberrypi.com; s=google; t=1793038800; x=1793643600;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WA5AxzH89R1SOTsw3YYXHEoBQlAVi2xqh5J2QmPmhV8=;
 b=KLuGUXBHLKFNCrlUKdQPQAoIwupM3JBGFAGR/LjcncgcKRZnh2vTXL5nxuPl2UpMqB
 4lVQTanjKHoYEkxYBNju9F9L7FQYH0Y9acff47k5QdtkH9uJXsFnHYOz7AVg+GwyKpv0
 UPUZMnYhc0K4YknWHJf8Mt1FNa7MI6+ICmH8R93oAz+IC2alZcUeqD4z+NqwsvaRCLbS
 lVcJkfOS67m1NKrqJnV7af7D22gFutfz+0udzTALTBRlFBwM7gZ3GJsilAZ65WE1EgfO
 tQoj8cPB9hnT60z34PqAL9l5yLp6vf+rW3Uq1zAt7nasI90AB77LrlxS0SxZKKut/m0T
 8XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793038800; x=1793643600;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WA5AxzH89R1SOTsw3YYXHEoBQlAVi2xqh5J2QmPmhV8=;
 b=b3R4oFVQ67GIC2yJYLHJ+nFKT928ky/9ejHpJ7dXpIyvCGi52PGD1BwtKcpG+stDb0
 n51Y1eo3hxag5RXJfKCIBHqZN/v4i5uX9hnsnjzTRItviZknJBchQK9Dg6U56ZdzLDtq
 pYBX3iiIMJ5ncDnoRDOODvFgkWm/R7lBhfTvIpKHyCCQILagE+B1eqismQu4dEooTUKT
 ZuGxHd220sBTPIsnup7MaUYN1HLlcsvoVtYCBO65pODd5mwpHvrZQXF6g6ETWaT/b0qx
 wsGEOc0HbkYCaFkdGJdEjRioDf9c8G4G/dJzHB5AsTjhWosnVyi6JzrNv38ygZg1bXo5
 wYQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGjldZ7VjjG3t12uXJbz+Xa4G88xK0hwPw8PihN0Z5N3eyCg3KnM/PihnpyBHy+6nhG1t/AFvEHtE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLVuzE5Bgm/hjepS7Re0YxUfR13yvbGphmxNDYfHtbuZFftfxY8
 7D3xCkT7qEkQyXRGYjAdAaai1ez2sqkssaj7gWxqmJqCaF9S1Sgn0Y6xty9KkrFJynxINsuNn63
 FHEeNHkOi40UE6Q1Mq4vocN2piijKRHkQW+m9nhsRvQ==
X-Gm-Gg: AYBFou3L7mBcFATBA25LIhfj6fuOJq2611a0NRU4T4WitUpN6bPP3JBS8TA4tbhcMmT
 lvxdcmdKEvdzwJzJYTNzdIV8JWAwFoW9Reu0CIwhiJoGW9j8ISaykkrAzLrHDeur0hvKMVczXPX
 EkhMmlmxwq+3Z2f8/TIaVPWEEuAh3Pr5CRPeu8ApgtgJHIy++vu0CJiKLNNGJkPkG4tSUnH42gL
 K8baPQnOLURODn92GE7Zz9s1CwS+l+QrGEt6q7KMCfiOQNAVtMgkjQBpgXxy6Ll38lpz8LOhdH3
 j5w/HSocJAEqxiKu7ZNZHrHDA45h/egpgcebw334cpjMTY/THzAhSGUnOVBbBXWnL54P49LimKw
 /2KoSWS8sZNVQ9IWIQ5pneDADZ2gjVT1QFYWlZNhjHx3OJys6gu4W7p4yAVWSJ0cDCE4czpGGbn
 SzEzVhZCRC+5gztWhvqsGMzPNt1uUHDt1CFaGrXpTRmNel9mTDcnljxA==
X-Received: by 2002:a05:6871:d3:b0:494:75ba:c6d2 with SMTP id
 586e51a60fabf-4a83f4a1680mr5146584fac.13.1793038799703; Mon, 26 Oct 2026
 11:19:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019174930.7237-1-henryzhang62@gmail.com>
 <20261019174930.7237-4-henryzhang62@gmail.com>
In-Reply-To: <20261019174930.7237-4-henryzhang62@gmail.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Mon, 26 Oct 2026 18:19:42 +0000
X-Gm-Features: AclHuK9tlTBZJu7ULazzmt-h2nMwB_CPhUkhsXOT5jfzH2rY1dSineF5A9oA7q0
Message-ID: <CAPY8ntAyrZO5Oi5hxDfSKHdSFpJTR29J8kUDCL7Au0QCXR0iLg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/vc4: dsi: Serialize host transfers
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

On Mon, 19 Oct 2026 at 18:55, Henry Zhang <henryzhang62@gmail.com> wrote:
>
> vc4_dsi_host_transfer() fills the command FIFOs and the TXPKT registers
> and waits on a single completion without any locking. Two callers
> sending at the same time, for example a panel driver and a backlight
> update, can overwrite each other's packets, and the timeout recovery
> added in the previous patch could reset the block under a transfer
> that is still in flight.
>
> Hold a mutex for the whole host transfer, including the recovery.
>
> Signed-off-by: Henry Zhang <henryzhang62@gmail.com>

Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>

> ---
>
> Notes:
>     New in v2 (Sashiko review).
>
>  drivers/gpu/drm/vc4/vc4_dsi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 2d985bc..627adf0 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c
> @@ -25,6 +25,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
>  #include <linux/io.h>
> +#include <linux/mutex.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> @@ -595,6 +596,8 @@ struct vc4_dsi {
>          */
>         struct clk *pixel_clock;
>
> +       /* Serializes host transfers, including the recovery after a timeout. */
> +       struct mutex transfer_lock;
>         struct completion xfer_completion;
>         int xfer_result;
>         int irq;
> @@ -1434,6 +1437,8 @@ static ssize_t vc4_dsi_host_transfer(struct mipi_dsi_host *host,
>         u32 disp0_ctrl;
>         ssize_t ret;
>
> +       guard(mutex)(&dsi->transfer_lock);
> +
>         ret = vc4_dsi_transfer(dsi, msg);
>         if (ret != -ETIMEDOUT)
>                 return ret;
> @@ -1911,6 +1916,7 @@ static int vc4_dsi_dev_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
>         struct vc4_dsi *dsi;
> +       int ret;
>
>         dsi = devm_drm_bridge_alloc(&pdev->dev, struct vc4_dsi, bridge, &vc4_dsi_bridge_funcs);
>         if (IS_ERR(dsi))
> @@ -1918,6 +1924,9 @@ static int vc4_dsi_dev_probe(struct platform_device *pdev)
>         dev_set_drvdata(dev, dsi);
>
>         dsi->pdev = pdev;
> +       ret = devm_mutex_init(dev, &dsi->transfer_lock);
> +       if (ret)
> +               return ret;
>  #ifdef CONFIG_OF
>         dsi->bridge.of_node = dev->of_node;
>  #endif
> --
> 2.47.3
>
