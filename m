Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B66C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:41:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09CD410F730;
	Fri, 11 Sep 2026 23:41:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F1/wXTWT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E90810F730
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:41:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B558E600AA;
 Fri, 11 Sep 2026 23:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F65B1F000FF;
 Fri, 11 Sep 2026 23:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789170067;
 bh=xdpGpBauhuZkiMTqIleJIXEo6G1FXrqW5FlB5lOTMiQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F1/wXTWTritAey8Eff9LHCd/R+OSF9SokwpBPjMjaP3MvFZsd1xkBV4EbWcIwRtqk
 BQzIee9OpjJxHdFkKkMJqHItiWzukgWW70C+dI53fNwfYGtanbzjTB1AUL+gWqvWB3
 QKP3OnPqUn/CV8l3KNxS6MJj75uPlGmikYx9ta44APoaPY4IuM9Ll4i+HBq/l+2GuQ
 33ZqyIOOEuODVnb9OQTrUVjGUr4SsP6aJsb1JmY06JVYYAEvX3gPtwiv0Ugkmzu7n8
 c76U7PzRhDW4Xz0KErm6JvvXcqDjzw5NDaye//bZnfkJCfkZ/nNlV0DsvH5ZFkUbrp
 Z+VlUvArkwbbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 11/16] drm/panfrost: Move perfcnt GPU disable
 sequence into a helper
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-claude-fixes-v9-11-e588feaa61ef@collabora.com>
References: <20260912-claude-fixes-v9-0-e588feaa61ef@collabora.com>
 <20260912-claude-fixes-v9-11-e588feaa61ef@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 23:41:06 +0000
Message-Id: <20260911234107.3F65B1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free of pfdev->perfcnt in GPU interrupt handler on devic=
e unbind due to devres cleanup order.
--

commit 62f6a919f812a1a1e64197b8f8a6a6d6f4790287
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Move perfcnt GPU disable sequence into a helper
   =20
This commit factors out the performance counter hardware disable sequence i=
nto a
new helper function panfrost_perfcnt_hw_disable() to reduce repetition.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index 7020c0192e189..f71534e741b65 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -35,6 +35,16 @@ struct panfrost_perfcnt {
>  	struct completion dump_comp;
>  };
> =20
> +static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
> +{
> +	gpu_write(pfdev, GPU_PERFCNT_CFG,
> +		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> +	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> +}
> +
>  void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
>  {
>  	complete(&pfdev->perfcnt->dump_comp);

[Severity: High]
This isn't a bug introduced by this patch, but can this dereference of
pfdev->perfcnt in panfrost_perfcnt_clean_cache_done() lead to a
use-after-free during device unbind?

The allocation order in panfrost_device_init() establishes a devres LIFO fr=
ee
order that could cause this:

panfrost_device.c:panfrost_device_init() {
    ...
    err =3D panfrost_gpu_init(pfdev);
    // Registers GPU IRQ via devm_request_irq()
    ...
    err =3D panfrost_perfcnt_init(pfdev);
    // Allocates pfdev->perfcnt via devm_kzalloc()
    ...
}

Because devres cleans up in LIFO order, on device unbind, pfdev->perfcnt is
freed before the GPU IRQ handler is unregistered.

Additionally, panfrost_device_fini() temporarily un-suspends the device, wh=
ich
unmasks the hardware interrupts via panfrost_device_reset(), and then calls
panfrost_gpu_fini(). While panfrost_gpu_fini() powers off the hardware, it
does not mask the interrupts.

If the shared IRQ line fires during this window, or if reading GPU_INT_STAT
returns 0xFFFFFFFF because power domains are off, panfrost_gpu_irq_handler()
will execute, pass the state & GPU_IRQ_CLEAN_CACHES_COMPLETED check, and ca=
ll
panfrost_perfcnt_clean_cache_done().

Would this result in a use-after-free when accessing
pfdev->perfcnt->dump_comp?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-claude-fix=
es-v9-0-e588feaa61ef@collabora.com?part=3D11
