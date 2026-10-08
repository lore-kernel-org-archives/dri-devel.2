Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49796CA6017
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 22:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5B910EA50;
	Thu,  8 Oct 2026 22:18:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="egWzQCG4";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD9F210E155
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 22:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791497923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WtbOZ4eCfsngvv2Aa3m2P0rWvfn9a/Va6ZO3mHSay2Q=;
 b=egWzQCG4fvh8OON0V13BaEHWrXHMquXBCuqlmzYjeEz5fnJb0K7ky9X9zUEEKL2kgKzpBN
 mdUDYnUvptgKfqi9eLZ28gRncyH0lHAHE/U3B+TYCD7Hm20mQ75WrbCsrAB08B9eFgsd2k
 kjtIuaVFnZ8rVfRhEobFgkdu2ABoGDo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-IvV_3dHbNw2LeapTTqPjGw-1; Thu, 08 Oct 2026 18:18:39 -0400
X-MC-Unique: IvV_3dHbNw2LeapTTqPjGw-1
X-Mimecast-MFC-AGG-ID: IvV_3dHbNw2LeapTTqPjGw_1791497919
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9104eedb5b0so167483686d6.0
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 15:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791497919; x=1792102719;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=S516mKsihJvGMAbQN1NJPExU5zniQAE3QbqOLbNkeRI=;
 b=awK6B1j/zPskpvh5bMFbxIN8llA8o2GDJkKjC/1/o88lahe6F/iGPLxp7vBLsCfcHI
 Emfpoc9Z4UK93bOw/NT6mHw8O6xysx6pAoeXD4YUmQy60/eo4+TlLXT9QB5HacQkCuxg
 ksmN7qatzlbttuNH074p/urwZ61YgvfX/7SzL51ULOeCgP/DZIzZPv2M+5dET4r7omvJ
 lVaWEXmgjNR9vDvxTOCDrxEnj0JQCjn/XVxsZFSE46ExYjhjt1SUCHacUlzkqz/1geh0
 4qyrasjGW2fktWF/bGYNRdI8Ya/ytiUhSE7bveX1Z/mlPDTh+WUtvlmwEcvpgB1bf42K
 4HgQ==
X-Gm-Message-State: AFq9FYI/ce4aeGZFSXbzuHt1DCctZ+kE/f+1jn/0mmC9cw+fXZI67lj4
 zFsfdcxvTDY98mj46S57oGrPjP/hCfTB9HyF9Zqe75D0aHtvWFG2nKTXS+cLP1xId+LFHlkqYP3
 Gpa2p8E+Ta9dCdRXgDM7RXDeG9Oaje3oyz9MWlbBncrum1J4IFQoPnx96iSINaCUowP4JGA==
X-Gm-Gg: AYBFou3PHh5gjzOxvp9X5DNts6r3Kxu3iNRxoJBqAYnfZmOtz8JFxVFhPzqU9cxihX/
 s/xDfpotFhGovmywsm8FAjwd+/10Ut+kqwbuXsV9Mpx1oqXKGnh0r/uj6E2Hu8HgcsgEJd+uuWn
 Cq7iZhm67ytskV2cn17BB7zPWll7Ho6x2u+mWg8f0GqjQaspGkMru243Zi0fAtUt+nXbcLEnHUy
 7UO3zPfNNW54iaUAvb78cmToOcrJK9WaY5ypoywz6tntL+w/wBXPxCxpTJqJm6bczyoPj7oYBcS
 pBkUkeKsbvhj9ucGWaieF+1R2Gbux22nAE5IS3o01akha+n7MxlLaG0/00L81x0OhbwLCiI=
X-Received: by 2002:a05:6214:451f:b0:919:952d:3b86 with SMTP id
 6a1803df08f44-91b557e0914mr2148796d6.49.1791497919102; 
 Thu, 08 Oct 2026 15:18:39 -0700 (PDT)
X-Received: by 2002:a05:6214:451f:b0:919:952d:3b86 with SMTP id
 6a1803df08f44-91b557e0914mr2148316d6.49.1791497918471; 
 Thu, 08 Oct 2026 15:18:38 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91b5501757bsm1712146d6.13.2026.10.08.15.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 15:18:37 -0700 (PDT)
Message-ID: <d601d2ee6e47fe1b624697cf5b0f4129c97b62d2.camel@redhat.com>
Subject: Re: [PATCH 1/3] drm/nouveau: Fix NULL pointer dereferences in
 GETPARAM ioctl
From: lyude@redhat.com
To: jim.cromie@gmail.com, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dave Airlie	
 <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 18:18:37 -0400
In-Reply-To: <20261002-my-fixups-v1-1-a83d20f9d3fe@gmail.com>
References: <20261002-my-fixups-v1-0-a83d20f9d3fe@gmail.com>
 <20261002-my-fixups-v1-1-a83d20f9d3fe@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: m1GruDCju1mVztHJBeVhxGL0PJNTTqe4EtYsbiFuqNc_1791497919
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

On Fri, 2026-10-02 at 12:09 -0600, Jim Cromie via B4 Relay wrote:
> From: Jim Cromie <jim.cromie@gmail.com>
>=20
> When hardware or firmware initialization fails, the graphics engine
> (gr) or device functions may remain NULL. Attempting to access these
> during the GETPARAM ioctl (e.g., NOUVEAU_GETPARAM_GRAPH_UNITS)
> results
> in a kernel NULL pointer dereference, causing a crash when userspace
> (GNOME/Mesa) attempts to probe the device.
>=20
> Add safety checks for 'gr', 'gr->func', and 'nvkm_device->func' in
> the
> ioctl handler. Return -ENODEV to signal the missing hardware state to
> userspace, and use NV_ERROR_ONCE to provide diagnostic proof in the
> kernel log without risking a console flood.
>=20
> NOTE:
>=20
> I encountered these crashes while booting unrelated code (in
> dynamic-debug) on real HW.=C2=A0 There was also some fwupd updates around
> this time, so it could all be transient/unreproducible.=C2=A0 But it did
> happen, and could happen again in unforseen circumstances.
>=20
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_abi16.c | 25 +++++++++++++++++++++-=
-
> --
> =C2=A01 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> index 4542d5f4ded8..cb1810dee8e5 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -306,7 +306,12 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
> =C2=A0=09=09getparam->value =3D 1;
> =C2=A0=09=09break;
> =C2=A0=09case NOUVEAU_GETPARAM_GRAPH_UNITS:
> -=09=09getparam->value =3D nvkm_gr_units(gr);
> +=09=09if (gr && gr->func) {
> +=09=09=09getparam->value =3D nvkm_gr_units(gr);
> +=09=09} else {
> +=09=09=09NV_ERROR_ONCE(drm, "GETPARAM_GRAPH_UNITS: no
> gr engine or func\n");
> +=09=09=09return -ENODEV;
> +=09=09}
> =C2=A0=09=09break;
> =C2=A0=09case NOUVEAU_GETPARAM_EXEC_PUSH_MAX: {
> =C2=A0=09=09int ib_max =3D getparam_dma_ib_max(device);
> @@ -315,11 +320,23 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
> =C2=A0=09=09break;
> =C2=A0=09}
> =C2=A0=09case NOUVEAU_GETPARAM_VRAM_BAR_SIZE:
> -=09=09getparam->value =3D nvkm_device->func-
> >resource_size(nvkm_device, NVKM_BAR1_FB);
> +=09=09if (nvkm_device && nvkm_device->func && nvkm_device-
> >func->resource_size) {
> +=09=09=09getparam->value =3D
> +=09=09=09=09nvkm_device->func-
> >resource_size(nvkm_device, NVKM_BAR1_FB);
> +=09=09} else {
> +=09=09=09NV_ERROR_ONCE(drm, "GETPARAM_VRAM_BAR_SIZE:
> no device func\n");
> +=09=09=09return -ENODEV;
> +=09=09}

For both of these I would just invert the conditionals like this:

if (!nvkm_device ||
    !nvkm_device->func ||
    !nvkm_device->func->resource_size) {
=09NV_ERROR_ONCE(drm, "blah blah");
=09return -ENODEV;
}


> =C2=A0=09=09break;
> =C2=A0=09case NOUVEAU_GETPARAM_VRAM_USED: {
> -=09=09struct ttm_resource_manager *vram_mgr =3D
> ttm_manager_type(&drm->ttm.bdev, TTM_PL_VRAM);
> -=09=09getparam->value =3D
> (u64)ttm_resource_manager_usage(vram_mgr);
> +=09=09struct ttm_resource_manager *vram_mgr =3D
> +=09=09=09ttm_manager_type(&drm->ttm.bdev,
> TTM_PL_VRAM);
> +=09=09if (vram_mgr) {
> +=09=09=09getparam->value =3D
> (u64)ttm_resource_manager_usage(vram_mgr);
> +=09=09} else {
> +=09=09=09NV_ERROR_ONCE(drm, "GETPARAM_VRAM_USED: no
> vram mgr\n");
> +=09=09=09return -ENODEV;
> +=09=09}
> =C2=A0=09=09break;
> =C2=A0=09}
> =C2=A0=09case NOUVEAU_GETPARAM_HAS_VMA_TILEMODE:

