Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EA8CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE251122AD;
	Fri,  9 Oct 2026 21:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="DBU7BPTI";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECCCF1122B4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 21:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791581216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UibXxip+la5KHyH36kq6Z3BNIvqAoJ3dfaJsKYYfVc0=;
 b=DBU7BPTI50Vw7Xf2Rac1J399TT1DKLGfxcn+0cH0PfFaZYV39a32nVsldEBV5b6MSHWmij
 gECar3QTFbRaH84kWeho46Rm8mMZuRmqL7xy8s0kqk08Yd28V2KxtymGmfyiZREGTyAh4I
 3C1sEUQsVJkWpbwkvqTzR71Le8mymxo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-2mQfzQPyN0ag1BGkWfdrWg-1; Fri, 9 Oct 2026 21:26:55 +0000
X-MC-Unique: 2mQfzQPyN0ag1BGkWfdrWg-1
X-Mimecast-MFC-AGG-ID: 2mQfzQPyN0ag1BGkWfdrWg_1791581214
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53397338004so4000711cf.2
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 14:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791581214; x=1792186014;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZxvkTxUcJf7CaZriMxWB3wlk03saYsRAfT3CN9F3Ggk=;
 b=BSh3YER7of5nKAwxgisgM8vMR6q5VV0G/TqM1gsZQT9Bc66PvMk9gnAtUWXpr3eawV
 bPIC2K9W5toSIsd+MEh6CamEKo8VvZLmgSB0sFTytEGqkAwpfge5tVJxDKclx5mxpZzs
 PtZguVthLoZ3F+syJix6SoJbCGfwZhy3vzwcCPMywN+tRJl4Td+7BKbkVjiUqvqQHyCJ
 qLn0Q+8O/zeenscgZH8ScwumYnrk8XHNcueANIENSxc7ptWfLrulTPIjkIrTitS0JJdE
 1b7sZNasp9x+iPnxqcH7ylcEOg88cRPq1kmhr73pNDDICoGCJiLj3c5t9N1u9jHvqi8f
 fGQw==
X-Gm-Message-State: AFq9FYLMTs1DBdAjAUrkM51Q9+muaBeM0MVZQo6tfcwVnrIdTodeYYoI
 EYjDJod9dmUafiUfrS+2uIuvTWB45mtfrHDEtDwDrAP/95M+uS02h1SMpBlFj+JoVQ9qFPSYeF7
 n+U3Fo1GbjZn7cpO1if3Y/dPD+BuTMww9zA3HfeYmwHJyAr33YOlREDYP6j9Bj0wT7JsPrg==
X-Gm-Gg: AYBFou0aBAPR8uFaR5SMjhGXtqji0Fd3Hw19JUuhOCbnBkXOgnRktZLN8YolCPh1IkZ
 QEaHYOYO+ckuRkGdMWx2WrqQTpMjxvl8KRfUR9NbE+rCTFY7lzMTWwIhXrBGb/WRMJDEdCw0Vq5
 SoUmMet2hchM099i5c3L2G0FWEQTCPduKs2GnO1tjoMJmEqX62RqnNxLQ6NsrkxeoX7XNm1t9pg
 TSNwqMeR4XvLjmgZXZKPn6Umy2bi+GKLTPgxcDodrFiXhRxVljuV06mcLK8Cyb5zXGmsdGhixwc
 R3+nCquiajSli/0egKoSg9rQyHbrZ1lMdxJo65Fqbai+dQP17Igql4bDk7wzvduV819s3MI=
X-Received: by 2002:a05:622a:343:b0:535:209a:2789 with SMTP id
 d75a77b69052e-5359fae42c4mr54673781cf.27.1791581214249; 
 Fri, 09 Oct 2026 14:26:54 -0700 (PDT)
X-Received: by 2002:a05:622a:343:b0:535:209a:2789 with SMTP id
 d75a77b69052e-5359fae42c4mr54673491cf.27.1791581213810; 
 Fri, 09 Oct 2026 14:26:53 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b7c0214sm27166781cf.25.2026.10.09.14.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 14:26:53 -0700 (PDT)
Message-ID: <fa0cc152304b5a387b1a074454ded7f9c540cc57.camel@redhat.com>
Subject: Re: [PATCH v2 3/3] nouveau: Fix NULL dereference in
 nvkm_gsp_gcx_ready()
From: lyude@redhat.com
To: jim.cromie@gmail.com, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dave Airlie	
 <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Date: Fri, 09 Oct 2026 17:26:52 -0400
In-Reply-To: <20261009-my-fixups-v2-3-839e2bbe514d@gmail.com>
References: <20261009-my-fixups-v2-0-839e2bbe514d@gmail.com>
 <20261009-my-fixups-v2-3-839e2bbe514d@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 83e8Uv-1JBd2ioVtAQRxhi-8kFKLHA0BRkcs4f1t_Oo_1791581214
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

On Fri, 2026-10-09 at 11:44 -0600, Jim Cromie via B4 Relay wrote:
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
> =C2=A0drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h | 2 +-
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/device/user.c | 2 +-
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c=C2=A0=C2=A0=C2=A0 | =
2 +-
> =C2=A03 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> index ed5c6e0e68d3..933f13ed2a50 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> @@ -274,7 +274,7 @@ struct nvkm_gsp {
> =C2=A0static inline bool
> =C2=A0nvkm_gsp_rm(struct nvkm_gsp *gsp)
> =C2=A0{
> -=09return gsp && (gsp->fws.rm || gsp->fw.img);
> +=09return gsp && gsp->rm && (gsp->fws.rm || gsp->fw.img);
> =C2=A0}
> =C2=A0
> =C2=A0#include <rm/rm.h>
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
> index e475d0e8fa7b..ea895f04293a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/base.c
> @@ -51,7 +51,7 @@ nvkm_gsp_intr_stall(struct nvkm_gsp *gsp, enum
> nvkm_subdev_type type, int inst)
> =C2=A0int
> =C2=A0nvkm_gsp_gcx_ready(struct nvkm_gsp *gsp)
> =C2=A0{
> -=09if (!gsp->rm->api->gsp->gcx_ready)
> +=09if (!nvkm_gsp_rm(gsp) || !gsp->rm->api->gsp->gcx_ready)
> =C2=A0=09=09return NV_DEVICE_GC6_READY | NV_DEVICE_GCOFF_READY;
> =C2=A0
> =C2=A0=09return gsp->rm->api->gsp->gcx_ready(gsp);

