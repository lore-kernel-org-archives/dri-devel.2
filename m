Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642E1C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7B510F0EA;
	Thu, 17 Sep 2026 20:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VaEE3QFd";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C6510F0E2
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789675203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eTELubisesq0lEcB0pdFlOHAfxJaSpxoU32OmenWaKQ=;
 b=VaEE3QFddsRhW4eqc4YyD6e+4ClXuPNHJH1NdgVXEsAM+Vh1ivzQeokVV6wdCMNSTUGMLP
 yd9o0r+6MQPcDS3XmzqVASlahHCzBFQQ88K68kMmc/3lV2FFXqw0W43N2GOCRHA2nw9662
 2JRjQkfAsG8IHyDFG1qLrtc66GNox4g=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-lKRSro5_NNeMjKjF4nvXvg-1; Thu, 17 Sep 2026 16:00:02 -0400
X-MC-Unique: lKRSro5_NNeMjKjF4nvXvg-1
X-Mimecast-MFC-AGG-ID: lKRSro5_NNeMjKjF4nvXvg_1789675202
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5328412a7aaso28485451cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 13:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675202; x=1790280002;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QKJHwYoHwtxGXYRY1vkeptYjZQfzNjxi9ZIJDlWS3xE=;
 b=LIEl/t89vhiHdjooOAXQ/P/PiFYkvnZGjZzQVI5JIIDBxTSqzboikjCvMWL4p2UXLt
 Qn02vRO/5pg41+/rdqvlmyudzc/gl8UEvVCDtDzkON5v1QiWgjedkodEcUn2VWD6+4VR
 lBgCeYoKPHNJJuIXuqALQFRoluQt5fs1HS9639jprR49jhKYdmlgVlpceInlgrL6XQQc
 NS0f8jKqnx9p+8SEUwbIg2ZoLd3neW6qnHV0B0mJBNbiEKyIsokAItSRTWesfPd9RhVM
 GW04QUYqXm3kBXhKLh5VgHqTaLZOFMnP/G0zVRad89CTIxJiLHFyZWfSZ4ihdqKqDX5n
 tDAQ==
X-Gm-Message-State: AFuF++lfyMtEDxxCzd1dGgKO34yYfmKANKZSYm58sbjZffgOSGDRYxNH
 CPC2Los9QQULig/d7r+a6t3EEKVgfPRgD/5YLHM0AbFUPXow0NFWGYj0mJRv0THpT1TQAqUQhcc
 z1TLelWxQ5JxVpou/mwdjtPIkeVsGCbkDg2B8fxsqNCd2NaglnVRPpl9uAS1GV8L6UlBKdg==
X-Gm-Gg: AYBFou0FyeqHJJVYMc1fH9ymXeTq2X5l2Lquovk0p6AqKlwM+88sF8vgkWG5cK3mrmY
 K8+lG1ag2uHycw4JkpuDlREzxwXwDFsrmGhmTNhEl7DR3Li/RpaMK2VF1cz+lMcK3INsAIdeXji
 +JR4dg2KB/v8QKbQIiUUfl1odVPVW+Vw8gnb6ISh2348pTl8cyn9ymrYZwrYaDbqmZca9TWQzHX
 1ucuJllJ+NDQvDVOcqNnaxm0CoTv7lffKJbjhcBmq/vUF6HFnLJu0TPhxP+GXH9kF1e5erw+Aw9
 NplWbkZwkOQOMoqLXRGpGMvKkaAGQw7f3OP5iGn0ZJlfpBQg9B2FQSPMiLQofYMa/KIlIjfb
X-Received: by 2002:a05:622a:389:b0:530:dcc7:aede with SMTP id
 d75a77b69052e-5329e3d16c9mr5804091cf.30.1789675201627; 
 Thu, 17 Sep 2026 13:00:01 -0700 (PDT)
X-Received: by 2002:a05:622a:389:b0:530:dcc7:aede with SMTP id
 d75a77b69052e-5329e3d16c9mr5803511cf.30.1789675200978; 
 Thu, 17 Sep 2026 13:00:00 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532620843dfsm59146421cf.22.2026.09.17.12.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 12:59:59 -0700 (PDT)
Message-ID: <41bd4250f6833a7aa8de54b84e182ce922281d24.camel@redhat.com>
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
Date: Thu, 17 Sep 2026 15:59:58 -0400
In-Reply-To: <20260817-nouveau-fixes-v1-1-f518d0c735f3@outlook.com>
References: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
 <20260817-nouveau-fixes-v1-1-f518d0c735f3@outlook.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Thgn0DLQYDwd0_xo9-V7LJ9o3UjV41LP6kIMcbpLVS0_1789675202
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

Will push patch 1 to drm-misc-fixes in just a moment

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

