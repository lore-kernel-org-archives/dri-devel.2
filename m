Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A18C54EFC
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7DDD10E55A;
	Tue, 28 Jul 2026 08:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lynxeye.de header.i=@lynxeye.de header.b="rUtIv+OL";
	dkim-atps=neutral
X-Greylist: delayed 436 seconds by postgrey-1.36 at gabe;
 Tue, 28 Jul 2026 08:45:28 UTC
Received: from webhost05.keymachine.de (webhost05.keymachine.de [62.141.54.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D46510E55A;
 Tue, 28 Jul 2026 08:45:28 +0000 (UTC)
Received: from webhost05.keymachine.de (localhost.localdomain [127.0.0.1])
 by webhost05.keymachine.de (Postfix) with ESMTP id AE73370E048D;
 Tue, 28 Jul 2026 10:38:10 +0200 (CEST)
Received: from [192.168.178.25] (a89-182-118-83.net-htp.de [89.182.118.83])
 by webhost05.keymachine.de (Postfix) with ESMTPSA id 2EBA070E0196;
 Tue, 28 Jul 2026 10:38:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lynxeye.de; s=default; 
 t=1785227889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81HvKd6cQcQNld413wIgebh1EDGetMtXAHNc862H7QU=;
 b=rUtIv+OLmFd9VD1Gl1CX3kDw9Bc8GNUtY3wh3R4cQ2AXlp9bKx2efqMreAj4npiXtV7QeH
 VqITBVYDRziOegYg1twl+J/yH/naN3CxU2voQtV9kD4rW+Ap8viytdvQdlRtYP5wqrKzHC
 3YGcNcMsF+i4OQqAB6UZ08F8uy3Ifut1PaVCQZrr9IftJy6stNYH5BIbh2k5d7U1R6ZW3v
 5iWkWMNLvOIPxgzXp1Hwq6DBKKSZoTd9prsRHmK3jhw/+NqvgC8/TNYXVK2B7fVZd26zKh
 hdUem3kXYg4NWruieP6DkRS/IwDt3R/l/GTs6N60C8Vf0tNjRnYJVT6sDzLtUQ==
Message-ID: <67fe34eebafe657b3221ac39838440b294c60444.camel@lynxeye.de>
Subject: Re: [PATCH RFC] drm/nouveau: Use write-combined maps for coherent
 on Tegra
From: Lucas Stach <dev@lynxeye.de>
To: webgeek1234@gmail.com, Lyude Paul <lyude@redhat.com>, Danilo Krummrich	
 <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,  Simona Vetter
 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Faith Ekstrand <faith.ekstrand@collabora.com>
Date: Tue, 28 Jul 2026 10:38:08 +0200
In-Reply-To: <20260725-tegra-coherent-wc-v1-1-dfdcc929c21b@gmail.com>
References: <20260725-tegra-coherent-wc-v1-1-dfdcc929c21b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
MIME-Version: 1.0
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

Am Samstag, dem 25.07.2026 um 18:28 -0500 schrieb Aaron Kling via B4
Relay:
> From: Faith Ekstrand <faith.ekstrand@collabora.com>
>=20
> On Tegra devices, uncached maps traslate to device memory, causing
> unaligned accesses by userspace resulting in a SIGBUS. Instead, use
> write-combined maps to ensure proper access.
>=20
This is not only an issue on Tegra. All ARM64 platforms translate
uncached to device memory, which does not support unaligned access. So
the issue could happen in the same way when connecting a discrete GPU
to a ARM64 platform with PCIe support.

I would argue that there is no downside to always using write combined
memory for coherent buffers. You gain potentially faster writes while
the only issue is that writes may get delayed visibility at the device
side. However, I don't think anyone uses coherent buffers to modify the
content from the CPU side while the device is operating on the buffer.
For all regular use-case the memory barrier in FIRE_RING() will make
sure that the buffered writes are visible to the device before the
commands using the buffer are made visible to the device.

Regards,
Lucas

> Signed-off-by: Faith Ekstrand <faith.ekstrand@collabora.com>
> Co-developed-by: Aaron Kling <webgeek1234@gmail.com>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> This patch is marked RFC because there is not complete confidence that
> the change is correct. Without this change, nouveau can easily hit
> sigbus errors in Android UI rendering via nvk or running vulkan deqp
> tests on Tegra. Changing coherent maps to use write-combined stops the
> crashing, but it is unknown what the performance impact is, if any.
> ---
>  drivers/gpu/drm/nouveau/nouveau_sgdma.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_sgdma.c b/drivers/gpu/drm/no=
uveau/nouveau_sgdma.c
> index fa3b4ebf38a83..10f6ef1c541bd 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_sgdma.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_sgdma.c
> @@ -72,9 +72,12 @@ nouveau_sgdma_create_ttm(struct ttm_buffer_object *bo,=
 uint32_t page_flags)
>  	struct nouveau_sgdma_be *nvbe;
>  	enum ttm_caching caching;
> =20
> -	if (nvbo->force_coherent)
> -		caching =3D ttm_uncached;
> -	else if (drm->agp.bridge)
> +	if (nvbo->force_coherent) {
> +		if (drm->client.device.info.platform =3D=3D NV_DEVICE_INFO_V0_SOC)
> +			caching =3D ttm_write_combined;
> +		else
> +			caching =3D ttm_uncached;
> +	} else if (drm->agp.bridge)
>  		caching =3D ttm_write_combined;
>  	else
>  		caching =3D ttm_cached;
>=20
> ---
> base-commit: 1a1757b76427f6201bfe0bf1bea9f7574f332a93
> change-id: 20260725-tegra-coherent-wc-19941d1a5a60
>=20
> Best regards,
