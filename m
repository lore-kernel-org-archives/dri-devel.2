Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D10D7CA6017
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 22:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE8810E155;
	Thu,  8 Oct 2026 22:19:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FK+UDDe8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 056A710E155
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791497994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q26pHtJq5AW1BVb5JdpMBhNJVBPJeWS+ScAq8jhsGho=;
 b=FK+UDDe8Jrzv5rxtAflypj6Ied7V0XHZsWu4e0CVngsIGm1jCTEddxeUHphybM/H+DlI9z
 M0qRQ5n8Ymbta2InxkwBmyNSs2xZ7GyNclFNQMvcIfDzjiKykO4D09CqgcVaGJ3EAewaCG
 cW2Rzq2li9lVkxUh5IBnbkPqiYO13qY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-P0qy7SUhOCiEEeKW-YDaDA-1; Thu, 8 Oct 2026 22:19:53 +0000
X-MC-Unique: P0qy7SUhOCiEEeKW-YDaDA-1
X-Mimecast-MFC-AGG-ID: P0qy7SUhOCiEEeKW-YDaDA_1791497992
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caf6c528aso955622785a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 15:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791497992; x=1792102792;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GjfKe0UMSMorT3desuNDK/FRCwDViDwkhbHy5Q186yc=;
 b=VW2pw2Sltx5OGbS7MaiTnWpk5sHS4RICXc0cmWOIdlYOD0g43zh8NiXCNbK60eeAeJ
 2oYwH5lZgwINBaNPAK9L1LcjbsCUYFvo4nAihPfCalvO53MSOCI5JW681PFeYPsBVnRW
 GQ2/BZyO29Vp3vPqvwUIHbMUeIBPQKiU+GobM1wrnZbQLHXlP3VNwUoDRiIBAgpIa+LM
 pKgq3cyC+IindFD3YMQ+/MALFsZaWNOlDVuu9bedOX9R18spcLS19AKcYa0ZjL3KZdmH
 22l1QJPUfpxCvn/rtMUnDm1jbc0S9F4LZdEDJYsKQhT5Yc1g2pxnqUjCKOvL9KCAK3XI
 HQMw==
X-Gm-Message-State: AFuF++kqST9ewpOvI2oV6AwgIwwgmAF1vuP2dKpE4MBc1FTxZNdboZHJ
 6nHTVh9Ev8Wl54tgbXT/JMWrVj0FLB/FZlJe5baqMU9T5dmJG0V7p2WF3DXJ9ufpCha33TgfWY9
 L3tMSXso6fQAhH05BZs054nT+QbsOhbvdt3ljgJPPTH5iVYwCVv5nP/1ZaWLEepJfEeYX7Q==
X-Gm-Gg: AYBFou1bNsXFgE7LqEEc4Q0rkdl6JoA2ToHkwEvSFxHfZn0BJjpbPUydR/UiwAq9he0
 44iRo7GdDV6hY5W0VJIrgL7kG1jaawTs2WFLWvZAtKzipdJlUru8oIyyokx/Y4WdXx90oOWspr+
 gAnywZjCjY+JXBFahuaOkUvK4b8FJ3y5QjqFoov3RaftmQXqpeoyyHZpVOnnJMLLKMHZ9RvLUOA
 Fvq+xFqVEXIV8vqk/ShbTLUwLhbyMQsqbXblpbTPbIN3A38zAIbgPVzTP1oGO6W68ARI+pqWtjG
 lqI/XELTt7toCDfVreuBKIWVSqaHL6qoHLVhhwmu48Jxb5n1zgmrhFiD8CGdSJytEWmLfnA=
X-Received: by 2002:a05:620a:198d:b0:93e:942f:b8ae with SMTP id
 af79cd13be357-93ebd1dfff5mr2778485a.26.1791497992319; 
 Thu, 08 Oct 2026 15:19:52 -0700 (PDT)
X-Received: by 2002:a05:620a:198d:b0:93e:942f:b8ae with SMTP id
 af79cd13be357-93ebd1dfff5mr2774485a.26.1791497991653; 
 Thu, 08 Oct 2026 15:19:51 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb986c350sm38274685a.22.2026.10.08.15.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 15:19:51 -0700 (PDT)
Message-ID: <778d3018e596c0be1db309b5e36aa361db89c9bb.camel@redhat.com>
Subject: Re: [PATCH 3/3] drm/nouveau/gsp: Fix NULL dereference in
 nvkm_gsp_gcx_ready()
From: lyude@redhat.com
To: jim.cromie@gmail.com, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dave Airlie	
 <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 18:19:50 -0400
In-Reply-To: <20261002-my-fixups-v1-3-a83d20f9d3fe@gmail.com>
References: <20261002-my-fixups-v1-0-a83d20f9d3fe@gmail.com>
 <20261002-my-fixups-v1-3-a83d20f9d3fe@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s8C4zMJaH4D_w1JZvh6aTPMXvvodz9B1tkRUW_N-4e0_1791497992
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

Will push to drm-misc-fixes in a moment, thanks!

On Fri, 2026-10-02 at 12:09 -0600, Jim Cromie via B4 Relay wrote:
> From: Jim Cromie <jim.cromie@gmail.com>
>=20
> Commit cb4c7603678c ("drm/nouveau/gsp/r570: Add support for
> INTERNAL_GCX_ENTRY_PREREQUISITE") hooked nvif_device_gcx_ready() into
> nouveau_pmops_runtime_suspend() to consult GSP before runtime
> suspend.
>=20
> On GPUs running without GSP-RM (e.g. Volta GV100, NvGspRm=3D0, or
> missing
> GSP firmware blobs), device->gsp is instantiated but gsp->rm remains
> NULL. nvkm_udevice_gcx_ready() checked "!gsp" instead of verifying
> nvkm_gsp_rm(gsp), allowing non-RM instances to invoke
> nvkm_gsp_gcx_ready(). nvkm_gsp_gcx_ready() then unconditionally
> dereferenced gsp->rm->api, causing a kernel oops:
>=20
> =C2=A0 RIP: 0010:nvkm_gsp_gcx_ready+0x10/0x30 [nouveau]
> =C2=A0 Code: ... 48 8b 87 70 0e 00 00 <48> 8b 40 18 ...
> =C2=A0 RAX: 0000000000000000 RDI: ffff8c9555fca000
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 nvkm_udevice_mthd+0xa5/0x150 [nouveau]
> =C2=A0=C2=A0 nvkm_ioctl+0xcc/0x1d0 [nouveau]
> =C2=A0=C2=A0 nvif_object_mthd+0x110/0x1e0 [nouveau]
> =C2=A0=C2=A0 nvif_device_gcx_ready+0x36/0x60 [nouveau]
> =C2=A0=C2=A0 nouveau_pmops_runtime_suspend+0x39/0x140 [nouveau]
>=20
> Instruction decode shows `mov rax, [rdi+0xe70]` loads gsp->rm (0x0),
> and `<48> 8b 40 18` (`mov rax, [rax+0x18]`) faults accessing rm->api.
>=20
> Fix by:
> 0. Checking !nvkm_gsp_rm(gsp) in nvkm_udevice_gcx_ready() so non-RM
> =C2=A0=C2=A0 devices report GC6/GcOff ready and bypass the GSP call entir=
ely.
> 1. Guarding gsp and gsp->rm in nvkm_gsp_gcx_ready() before inspecting
> =C2=A0=C2=A0 gsp->rm->api->gsp->gcx_ready.
>=20
> Fixes: cb4c7603678c ("drm/nouveau/gsp/r570: Add support for
> INTERNAL_GCX_ENTRY_PREREQUISITE")
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/device/user.c | 2 +-
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c=C2=A0=C2=A0=C2=A0 | =
2 +-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
> index f78e6b9b4292..d469437eb991 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
> @@ -201,7 +201,7 @@ nvkm_udevice_gcx_ready(struct nvkm_udevice *udev,
> void *data, u32 size)
> =C2=A0=09} *args =3D data;
> =C2=A0=09int ret =3D -ENOSYS;
> =C2=A0
> -=09if (!gsp) {
> +=09if (!nvkm_gsp_rm(gsp)) {
> =C2=A0=09=09args->v0.ready =3D NV_DEVICE_GC6_READY |
> NV_DEVICE_GCOFF_READY;
> =C2=A0=09=09return 0;
> =C2=A0=09}
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
> index e475d0e8fa7b..9e07d67dcb0f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
> @@ -51,7 +51,7 @@ nvkm_gsp_intr_stall(struct nvkm_gsp *gsp, enum
> nvkm_subdev_type type, int inst)
> =C2=A0int
> =C2=A0nvkm_gsp_gcx_ready(struct nvkm_gsp *gsp)
> =C2=A0{
> -=09if (!gsp->rm->api->gsp->gcx_ready)
> +=09if (!gsp || !gsp->rm || !gsp->rm->api->gsp->gcx_ready)
> =C2=A0=09=09return NV_DEVICE_GC6_READY | NV_DEVICE_GCOFF_READY;
> =C2=A0
> =C2=A0=09return gsp->rm->api->gsp->gcx_ready(gsp);

