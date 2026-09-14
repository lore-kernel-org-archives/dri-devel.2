Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35319C88E73
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B3310F2A8;
	Mon, 14 Sep 2026 21:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Y46RVFAj";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C5710F2A8
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 21:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789421481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EsmO2zfEEKb36HKkQkCui6azWFUjL6ObkO4dSpEE9uc=;
 b=Y46RVFAjTdsmKCANOCyqEYPYnn58JZ0fwGDMQGFvbpiw5+ucNJp+neTbpSMpfAFSQGMGoG
 4Xec6bj+gfwg/tFcTWECIYrlVjzoARQZUPi4lScMfNpI3JJtRXOQsof8O/GbX5WjZL6AAh
 ViKcrJRT18w2T3PyY8nBmDxplDEBV94=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-1PQjx71kNs6MDAYmBvUd4g-1; Mon, 14 Sep 2026 17:31:20 -0400
X-MC-Unique: 1PQjx71kNs6MDAYmBvUd4g-1
X-Mimecast-MFC-AGG-ID: 1PQjx71kNs6MDAYmBvUd4g_1789421480
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-982fcdd9b01so186869241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 14:31:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789421480; x=1790026280;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mSH/LADfNS5wRI0PeO6aTM3mQmTKjHC2Ckp9c3le0T0=;
 b=CrQJIwqps6nWHmIltYrGtqCvb5ewBcg09pHFltQxsyvG508OyIl5SjpEk+V36tr15u
 DZw2mn/+J5X+qmTyEdFoB3NmJd7VBRb1ErT12doixb4LuBUebHjsmUZSKnUQ6HWZ8VOx
 rJYVbI8P/tuvbWULF3OP7QzjwAC8wxjzlImrsWETytgBO9dbfCoC2uEKaqv8tWIdPPp6
 bRxIjOR+P+8JpChY6f95SSPbfqZOuycTMUqA6nQtAbvz7O3m4uO1bzZ6Bf/xnQo6Vall
 sbSLHarKoDr/WtQm7o+WkDClsT+K51DQaTOsQ16UDQ44n5RPHO/iiAS8M0QbjQKcvI7X
 /EWQ==
X-Gm-Message-State: AFuF++loAJIVyVIFqW6pwF5ifCcrwz3H4K3Dk1MRaPMXJcvcEs2QN1Dz
 IdkY2tsFL6Odk9Lt64FT+/lQRDwfl000h97Ym0AgcaSJ8qrxuVjZm2EgSUePf4ogEa8lvBTdzmR
 Sgbcw2aSiRCrlIcYn7e7Kmq0YJcWTjvi3Vld0+oU4BquiKS7uV/kpuX+X+e1G8DbYZqFw+g==
X-Gm-Gg: AYBFou1eQbIPdkwR0bWM9x6pabXwdETQLzurD/c4UTT2DHfdZfmtz//Uh6RWnjHtvNs
 bUmZU3Szi7aaeHRXwN+3KjB7awUKgaIlQO1rPY+l9DJuNupSB+lw3+3Z0MKJYzO2FzXgCRMhDoE
 YLOCBheZ1Cw6mxZ4o0I/8rLwxw5vjtv78c9G8opvqkpIaGXKZy0cY5sIA+vo+aVVQ3KZWykPGNq
 yvlzdys0WZKPYXnD3zcYRorSi1VBnWbSsQywjVpzW/xoIdtU2EsC7gSiR+TPcM6B0bcaKHJXVZX
 pdAIcMIUfKbF7kPpgEGe81jEAAqx8OdeLfruZ4qbyGTYEwXw/QNmaJBqv7N/LiYc8EU34Hel
X-Received: by 2002:a05:6102:54a9:b0:79a:7895:c36a with SMTP id
 ada2fe7eead31-79b5c700594mr4686134137.13.1789421479566; 
 Mon, 14 Sep 2026 14:31:19 -0700 (PDT)
X-Received: by 2002:a05:6102:54a9:b0:79a:7895:c36a with SMTP id
 ada2fe7eead31-79b5c700594mr4686037137.13.1789421478991; 
 Mon, 14 Sep 2026 14:31:18 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f2032d4sm104280926d6.5.2026.09.14.14.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 14:31:18 -0700 (PDT)
Message-ID: <3bc92cd6aa88e52c2645b00b97c9d75a112b5d16.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau: validate required NET_img regions
From: lyude@redhat.com
To: Slavin Liu <bolin.liu@seu.edu.cn>, dakr@kernel.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 14 Sep 2026 17:31:17 -0400
In-Reply-To: <20260913125228.110071-1-bolin.liu@seu.edu.cn>
References: <20260913125228.110071-1-bolin.liu@seu.edu.cn>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WKu70jzKzAAWZEdd3z1KNB8zfKlVPbJFt-A4z2vZKz8_1789421480
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

Hi. What bug are you fixing here?

On Sun, 2026-09-13 at 20:52 +0800, Slavin Liu wrote:
> The NET_img parser can finish without all FECS and GPCCS regions.
> Reject missing required regions before computing their data
> addresses,
> and release the firmware on both validation and ACR loading failures.
>=20
> Detected by static analysis and reviewed with AI-assisted source
> auditing.
>=20
> Fixes: c4bdac754ca0 ("drm/nouveau/gr/ga102: initial support")
> Assisted-by: LLM
> Signed-off-by: Slavin Liu <bolin.liu@seu.edu.cn>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c | 12 +++++++++---
> =C2=A01 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c
> index 2b51f1d0c281..bfd1e00537b8 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/gr/ga102.c
> @@ -317,6 +317,11 @@ ga102_gr_load(struct gf100_gr *gr, int ver,
> const struct gf100_gr_fwif *fwif)
> =C2=A0=09=09}
> =C2=A0=09}
> =C2=A0
> +=09if (!fecs_inst || !fecs_data || !gpccs_inst || !gpccs_data)
> {
> +=09=09ret =3D -EINVAL;
> +=09=09goto out_firmware;
> +=09}
> +
> =C2=A0=09ret =3D nvkm_acr_lsfw_load_bl_sig_net(subdev, &gr-
> >fecs.falcon, NVKM_ACR_LSF_FECS,
> =C2=A0=09=09=09=09=09=C2=A0=C2=A0=C2=A0 "gr/fecs_", ver, fwif-
> >fecs,
> =C2=A0=09=09=09=09=09=C2=A0=C2=A0=C2=A0 fw->data + fecs_inst-
> >data_offset,
> @@ -324,7 +329,7 @@ ga102_gr_load(struct gf100_gr *gr, int ver, const
> struct gf100_gr_fwif *fwif)
> =C2=A0=09=09=09=09=09=C2=A0=C2=A0=C2=A0 fw->data + fecs_data-
> >data_offset,
> =C2=A0=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fecs_data-
> >data_size);
> =C2=A0=09if (ret)
> -=09=09return ret;
> +=09=09goto out_firmware;
> =C2=A0
> =C2=A0=09ret =3D nvkm_acr_lsfw_load_bl_sig_net(subdev, &gr-
> >gpccs.falcon, NVKM_ACR_LSF_GPCCS,
> =C2=A0=09=09=09=09=09=C2=A0=C2=A0=C2=A0 "gr/gpccs_", ver, fwif-
> >gpccs,
> @@ -333,12 +338,13 @@ ga102_gr_load(struct gf100_gr *gr, int ver,
> const struct gf100_gr_fwif *fwif)
> =C2=A0=09=09=09=09=09=C2=A0=C2=A0=C2=A0 fw->data + gpccs_data-
> >data_offset,
> =C2=A0=09=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpccs_data-
> >data_size);
> =C2=A0=09if (ret)
> -=09=09return ret;
> +=09=09goto out_firmware;
> =C2=A0
> =C2=A0=09gr->firmware =3D true;
> =C2=A0
> + out_firmware:
> =C2=A0=09nvkm_firmware_put(fw);
> -=09return 0;
> +=09return ret;
> =C2=A0}
> =C2=A0
> =C2=A0static const struct gf100_gr_fwif

