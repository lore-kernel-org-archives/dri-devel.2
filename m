Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F21C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 19:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BBD210F0D6;
	Thu, 17 Sep 2026 19:59:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PVA6JGWy";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E786B10F0D6
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 19:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789675164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyk2K5+RCGfchw1Ej2mt2PF4h78M1vV4ssckCb7zVJA=;
 b=PVA6JGWyaXAZbAUpeXEZFKHSJYiOu5rpyVgYupj/cchliRnBW0kcs7G/tn48C/DdszGgWe
 AZ/zzWxpseWs61hxjKUcInKKUY66EA1kKkOaNoWZniJoyRpFUGIWy78xan1yv9fjNviN8u
 ZoJSnpuc5uEDvYr7g7IukUSP8pIUW3c=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-uSyPWYn4Okmmqm7b_9vDFw-1; Thu, 17 Sep 2026 15:59:22 -0400
X-MC-Unique: uSyPWYn4Okmmqm7b_9vDFw-1
X-Mimecast-MFC-AGG-ID: uSyPWYn4Okmmqm7b_9vDFw_1789675161
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91064f6e75bso1719446d6.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675161; x=1790279961;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/9aXv8uRrrDfO592gJdgz9hZv2sNMllIL5UBHr09UAU=;
 b=oVqDtmaZnl098Iurv+tX5yJiLLPuzmFafzB3JnYTY6wLKlitTTSBW3mZlghDY5oiJ/
 Cbm69WjmDdeMdaOUww1L8CeX0WmXQuRF6EpfZJuBrIfSF0HtdaLbHvtVHqhT6z5HQF4q
 td/YJ/HofKM4ii3CIFi2rUxAz834y+j+JUjzaIjl/zaUjTAqo9RmrWuc/A2zo/5f5tm1
 jTw2jSNrIrTO09YtlZq87yn0WtVklaKD/51yuS+MNl4JhXYWNOxwCav3KBK1D8MVLG+j
 xn5eWJXzt7DCs6maZQPejbUWLJQ8H2Lq8Tcjbmly7nLpJlA3lMx53KjXk8mPI7uZYMGN
 DibA==
X-Gm-Message-State: AFuF++kFBzLIDUhCqYM/8UJ2fdQ5UajjfKOjlUHdeqGSurnhg7GBq5+7
 HUx5du1GMVlSj7Z3S8LwjCQENj7QWSiOsviCVQg8ESw8kNu8NMx8svsdfan3pNRq+TewtFJN0Xb
 iSuhaaxN2We78DBJM+lPxnzpYaT0yJw6v/Ptgz6MW9NNKq9GOCOSicoVW3BUUE/hDFy2oAA==
X-Gm-Gg: AYBFou2I7lqPltnuG61EoWrLDa4k8bwEkQe9HqMwscfjEHnrZ/Cvm9rM/ziqTT7eo/V
 l126vuymtX3J4BJyvMm9DCdEmsiZvQXNHKMdFJPifRfqslF2w9DF1fvgOezZZrOUz3CVuF4d/1q
 bCgj55JXuPohXhyOvdToOwugLKiy7ToBJ6OvbrzVaob+0tGaa1kRAfV5LNTSETETBZ9/IhF+vQH
 j3rzg4YtUKMRMRG0+Igk8kpyY0l0pnB07UTzndrxooNhZJY/WDReDEokIOc+pNnil+spikx+4dJ
 iW781DtMBjw2PmGtOPPrQTHfdc28IxJKS0+VZFNM10owFF6efWe8F19wa9+BkcAf9rvB0ZMI
X-Received: by 2002:a05:620a:800e:b0:937:1097:feb8 with SMTP id
 af79cd13be357-93bdc70b6b7mr2618985a.24.1789675161525; 
 Thu, 17 Sep 2026 12:59:21 -0700 (PDT)
X-Received: by 2002:a05:620a:800e:b0:937:1097:feb8 with SMTP id
 af79cd13be357-93bdc70b6b7mr2616085a.24.1789675161049; 
 Thu, 17 Sep 2026 12:59:21 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93b78243f77sm542694385a.25.2026.09.17.12.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 12:59:20 -0700 (PDT)
Message-ID: <495954974fdaf275d65ea8ae1b76f8e496c09b79.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/nouveau/dmem: pin VRAM for the whole registered
 range
From: lyude@redhat.com
To: moonafterrain@outlook.com, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Andrew Morton
 <akpm@linux-foundation.org>, Balbir Singh	 <balbirs@nvidia.com>, Mary
 Guillemard <mary@mary.zone>, Mohamed Ahmed	
 <mohamedahmedegypt2001@gmail.com>, James Jones <jajones@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
Date: Thu, 17 Sep 2026 15:59:19 -0400
In-Reply-To: <20260817-nouveau-fixes-v1-1-f518d0c735f3@outlook.com>
References: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
 <20260817-nouveau-fixes-v1-1-f518d0c735f3@outlook.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TL0P7XTI-Jf0PyXrrM_U3OQGGcmUUgj_ddxlCvdvwyU_1789675161
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Mon, 2026-08-17 at 14:50 +0800, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
>=20
> Commit c32287471077 ("gpu/drm/nouveau: enable THP support for GPU
> memory
> migration") grew the device-private region that
> nouveau_dmem_chunk_alloc() registers from DMEM_CHUNK_SIZE to
> DMEM_CHUNK_SIZE * NR_CHUNKS, but left the VRAM buffer object backing
> that
> region at DMEM_CHUNK_SIZE.
>=20
> nouveau_dmem_page_addr() returns chunk->bo->offset plus the page's
> offset
> within the registered region, so every page past the first chunk
> resolves
> to VRAM outside the buffer object.
>=20
> Size the buffer object to the region it backs.
>=20
> Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU
> memory migration")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_dmem.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 9442ec6e1f6c..356ff8f3c1b8 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -325,8 +325,8 @@ nouveau_dmem_chunk_alloc(struct nouveau_drm *drm,
> struct page **ppage,
> =C2=A0=09chunk->pagemap.ops =3D &nouveau_dmem_pagemap_ops;
> =C2=A0=09chunk->pagemap.owner =3D drm->dev;
> =C2=A0
> -=09ret =3D nouveau_bo_new_pin(&drm->client,
> NOUVEAU_GEM_DOMAIN_VRAM, DMEM_CHUNK_SIZE,
> -=09=09=09=09 &chunk->bo);
> +=09ret =3D nouveau_bo_new_pin(&drm->client,
> NOUVEAU_GEM_DOMAIN_VRAM,
> +=09=09=09=09 DMEM_CHUNK_SIZE * NR_CHUNKS,
> &chunk->bo);
> =C2=A0=09if (ret)
> =C2=A0=09=09goto out_release;
> =C2=A0

