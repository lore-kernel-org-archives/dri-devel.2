Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EA5CA9EBE
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 21:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7829910EB0D;
	Fri,  9 Oct 2026 21:25:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="csCpMrMK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD33210EB50
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 21:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791581098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dl+DXyQwo+U7WhmX8/zjimRnBT3mFrwSzm2SztqXAbU=;
 b=csCpMrMKd7cKJTS/pkRnWTeM1r3XVSJM86/EVMO+xeOhnlmvPPalu5EksYWJcjPn1M15/W
 lAGVeElg6PWTAHf3Ikw6wa1tDCcwgfraFYeAGP6307sw1JlroKqTbAHn4AY5eiIhU1osSh
 a3p64tlPzpQqVUh0swaUPiNchFFnMIw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-TAi0Oj0mOhy7gIeQ67avpg-1; Fri, 9 Oct 2026 21:24:50 +0000
X-MC-Unique: TAi0Oj0mOhy7gIeQ67avpg-1
X-Mimecast-MFC-AGG-ID: TAi0Oj0mOhy7gIeQ67avpg_1791581090
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-535066512b0so3746471cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 14:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791581090; x=1792185890;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=z1Eu7EYQ+rpvHDotJhitil0lY6JFZjt2dgRaITNxGdo=;
 b=bYElmF6NCwuZ4HrVh4H0pG1LPm1jiDIx1k8steAMCAaTk324rS8eDrZLVOeP3/zG6Y
 IKbeKGY7PRtLspmBTgeAkAxQ30nhEDjdOZWR8RgdgNdXQ67Bav2cGPgdYc56o87Oaud6
 ep4EeHtg6/Qj1ifgTyRz6VSiwPtmb4TfXay+RXg5qJQKRDhaJ333UySm6fITwKzDODUA
 RIffZDC6Byg+TdEDDzJ+acp3XvZouaYj9nq5FPPgPTnNVFTiusdkMDkjzE2YBnRCbZic
 vR7qOIqw6sLyPISE6jFe9uyHvWB2lzPeMIZtc7oN7CXPSw5PQYQ4dbPxf0SXMn+ZZiyP
 dGHA==
X-Gm-Message-State: AFq9FYJFtuK/LmxqIqcbJfkJr0Jo3qEaJcQLJdtU2QHMUcr9XS1MABvz
 cTjCWmsMrNI4oF9AurznejhDaX4cV/z8bowsMJlLeHAs3V/kqHfkyYaplXPP2sgC1y7E0Am0vnO
 CB74uq39rZWSM9EhhlaTkcMFgkFP5ujozmOdiM4MemBTih3n60Uo81nLMr1OA/E+2yhpG2w==
X-Gm-Gg: AYBFou0DSawKwIhfk3sazhQYXCuB1xu5ts598KTq9JMuUwGpZpdEOlTYF3OcgCbtpQm
 6L9OCz3nxyb2RhJawwkztWgaF7z0ShTERm//6ucUit5tCtL95aUziW9BZdxj3ZJ1ckatpf0MLQq
 pNLSm1ATya37R4ooHAr+rPuEIw0jAOSHXlhDgclBbs/yVHSWtbuWndxvFRQcxwUq/HBozIcM4Zw
 b2Nwh9hjpcNvsAjxJwrUozvvZVFCANmHzIElYk7U8YWekBAh3bmssMUyrnW3+s8Zl++NEow2x5r
 s/n9bLUvj+qvVvdBvLpr5T2f3HXZg6Y8TXyMs8U1tFBsUssDo1L9JXnFCseYeKuUsRcO++8=
X-Received: by 2002:a05:622b:97:20b0:535:a5f8:a5c9 with SMTP id
 d75a77b69052e-535a5f8b5bemr28650991cf.73.1791581089904; 
 Fri, 09 Oct 2026 14:24:49 -0700 (PDT)
X-Received: by 2002:a05:622b:97:20b0:535:a5f8:a5c9 with SMTP id
 d75a77b69052e-535a5f8b5bemr28650791cf.73.1791581089326; 
 Fri, 09 Oct 2026 14:24:49 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b7324c9sm27569011cf.12.2026.10.09.14.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 14:24:48 -0700 (PDT)
Message-ID: <7b1398c5deadc0225332b6259a278d4436973d8f.camel@redhat.com>
Subject: Re: [PATCH v2 1/3] nouveau: Fix NULL pointer dereferences in
 GETPARAM ioctl
From: lyude@redhat.com
To: jim.cromie@gmail.com, Danilo Krummrich <dakr@kernel.org>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dave Airlie	
 <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Daniel Campos Ramos <Capitain_Jack@yahoo.com>
Date: Fri, 09 Oct 2026 17:24:47 -0400
In-Reply-To: <20261009-my-fixups-v2-1-839e2bbe514d@gmail.com>
References: <20261009-my-fixups-v2-0-839e2bbe514d@gmail.com>
 <20261009-my-fixups-v2-1-839e2bbe514d@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zdFkMKaOfe6pmqFq0CqFCiZI-B3Gopx6_Wsa5Ol9Z8U_1791581090
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

On Fri, 2026-10-09 at 11:44 -0600, Jim Cromie via B4 Relay wrote:
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
> @Capitain_Jack tested the error path in v1 by deleting the FW

I can just fix this up before pushing but JFYI - if you put comments
below the --- that's down below, they will show up in the email but not
the commit message.

Either way -

Reviewed-by: Lyude Paul <lyude@redhat.com>

>=20
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> Tested-by: Daniel Campos Ramos <Capitain_Jack@yahoo.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_abi16.c | 22 ++++++++++++++++++++--
> =C2=A01 file changed, 20 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> index 4542d5f4ded8..3f130cd4fbcd 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -306,6 +306,11 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
> =C2=A0=09=09getparam->value =3D 1;
> =C2=A0=09=09break;
> =C2=A0=09case NOUVEAU_GETPARAM_GRAPH_UNITS:
> +=09=09if (!gr || !gr->func) {
> +=09=09=09NV_ERROR_ONCE(drm, "GETPARAM_GRAPH_UNITS: no
> gr engine or func\n");
> +=09=09=09return -ENODEV;
> +=09=09}
> +
> =C2=A0=09=09getparam->value =3D nvkm_gr_units(gr);
> =C2=A0=09=09break;
> =C2=A0=09case NOUVEAU_GETPARAM_EXEC_PUSH_MAX: {
> @@ -315,10 +320,23 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
> =C2=A0=09=09break;
> =C2=A0=09}
> =C2=A0=09case NOUVEAU_GETPARAM_VRAM_BAR_SIZE:
> -=09=09getparam->value =3D nvkm_device->func-
> >resource_size(nvkm_device, NVKM_BAR1_FB);
> +=09=09if (!nvkm_device || !nvkm_device->func ||
> !nvkm_device->func->resource_size) {
> +=09=09=09NV_ERROR_ONCE(drm, "GETPARAM_VRAM_BAR_SIZE:
> no device func\n");
> +=09=09=09return -ENODEV;
> +=09=09}
> +
> +=09=09getparam->value =3D
> +=09=09=09nvkm_device->func-
> >resource_size(nvkm_device, NVKM_BAR1_FB);
> =C2=A0=09=09break;
> =C2=A0=09case NOUVEAU_GETPARAM_VRAM_USED: {
> -=09=09struct ttm_resource_manager *vram_mgr =3D
> ttm_manager_type(&drm->ttm.bdev, TTM_PL_VRAM);
> +=09=09struct ttm_resource_manager *vram_mgr =3D
> +=09=09=09ttm_manager_type(&drm->ttm.bdev,
> TTM_PL_VRAM);
> +
> +=09=09if (!vram_mgr) {
> +=09=09=09NV_ERROR_ONCE(drm, "GETPARAM_VRAM_USED: no
> vram mgr\n");
> +=09=09=09return -ENODEV;
> +=09=09}
> +
> =C2=A0=09=09getparam->value =3D
> (u64)ttm_resource_manager_usage(vram_mgr);
> =C2=A0=09=09break;
> =C2=A0=09}

