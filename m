Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9A2CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 23:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1932B112315;
	Fri,  9 Oct 2026 23:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eNc3HzeV";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F83911231F
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 23:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791588237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdLXwKy4rMVRiAcn1ajTN/XCnaFe6z5Qy+Wx1ZS4ezs=;
 b=eNc3HzeVCFSAiM9FA1Qxy8f3DWDsuFuNvJW+/xr0HnbSled0QsMCXnpXW0m2iV5KlwbjRn
 +6KA1Kg2pImli83ARBGIUokOIQ3GLPriCO2mL7rK6KbnYLE2YPdj6M4E0Hm4kFMWea2KI+
 pKXigQQYFtrPqKllQtFWV1Aagp1r884=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-6R-7r-ISPXeWgoib1GG1jA-1; Fri, 9 Oct 2026 23:23:56 +0000
X-MC-Unique: 6R-7r-ISPXeWgoib1GG1jA-1
X-Mimecast-MFC-AGG-ID: 6R-7r-ISPXeWgoib1GG1jA_1791588236
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53397b6e05aso5385121cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 16:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791588236; x=1792193036;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=itTUK0qBJAobOiyoWxRrJ2RE7+6HMxd85fVudqmm2Kg=;
 b=m505jP+5nnwnYT/EM5c9Gun54WDwHafOYfhcSaOtLPEDEPbpeAW3jv6q8Cc9IrS2DR
 eRNGNrAr902mlcyGx2q4Ck5R7auRs7MJ3RByp92dd/OLdfBB+Qcw/r2ile9ulYBvCXds
 GAKB+Iw2y94I62IU0vnUtGCLKLl0Y2T3fZ57A1cQym9M7ZQWSuCgw/+P1OScfFzH9jfW
 DhPgVAk+aPvyZnz0JWH3d4f9qGzoxY6Kyu1jmYo0gl1nIZWAcvrVJHYmRHlPQBzz9m3o
 roZaY7Tu+Tu700FIso0dgbWwOfFI13YUPCtW0UoUcRzQndP13r+wlIOo9CXrfTpFzGen
 G6xA==
X-Gm-Message-State: AFq9FYJOBfvtaRxEzcv6js9K2YSzAo+tlNcedBX8MVwAGpmx7GTIE/8h
 4qfc/DGBZS9cgctq8BxUbLfpuTVgmWp0wEW8k5FxEQzlhz6cJ580p7x2b0nUA9kapgMLHkP5I5J
 b4LzBeDj4KaC9MwD3UgYhD4Er1swn6Ia7H2Bnl01OdHEiSTEJfaIxA4SKi7IP4A0hRbLM5w==
X-Gm-Gg: AYBFou1qshWqQTWVUuhL6tcdFKU9wXnA8q7Rv8ypD0i+wHRHLhJs2qs6yhJA9Hht821
 NPJXi8T7JBe2XFwZn1bE2kaxVBTHYzB7B3QoAAKfDLlNpCd/QiqVENGtmeCl9x5b4Ltp4qvBtUl
 APpjy/MCN1PQg2t17VekYek5WgbsEVlIgDmg+AKQSfgMAVULlCfj94+7mmbUGEs3virpjPFtTZS
 AQ76Af9pB0rSZDoAk8L7J4fw4WopBOT+hXb3EMPt4tFFjhQw3g3iKSJ6BrSHT5SBwhI4o3FtQ29
 TQuB/jlYcwojpoVmlWaM3NmanZrDyyfA4YzWDKe1EthEA7tO208SoEQKh+rmQjJl6JizXIk=
X-Received: by 2002:a05:622a:4c0f:b0:535:384d:68ac with SMTP id
 d75a77b69052e-5359facfcbamr53929081cf.13.1791588235689; 
 Fri, 09 Oct 2026 16:23:55 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0f:b0:535:384d:68ac with SMTP id
 d75a77b69052e-5359facfcbamr53928871cf.13.1791588235223; 
 Fri, 09 Oct 2026 16:23:55 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b277938sm29237071cf.0.2026.10.09.16.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 16:23:53 -0700 (PDT)
Message-ID: <4200b4cefe4868fc3ca085d01957446ebfdc53e9.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/nouveau/sw: prevent NULL deref of disp in
 vblank methods
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
Date: Fri, 09 Oct 2026 19:23:52 -0400
In-Reply-To: <929077046827f363bc32f6f59e760de27a48b5ff.camel@redhat.com>
References: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
 <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-1-7e057f6aeba0@gmail.com>
 <929077046827f363bc32f6f59e760de27a48b5ff.camel@redhat.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6mLP-j-jq9kcBi-z-xIPu5gqHc9fVpRqJ--0lbhr0I8_1791588236
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

Bah - sorry I keep doing this :), could you add a fixes tag for this
and respin it before I push it?

On Fri, 2026-10-09 at 19:22 -0400, lyude@redhat.com wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>=20
> Will push to drm-misc-next in a moment
>=20
> On Wed, 2026-08-12 at 23:00 +0800, Zhenhao Wan wrote:
> > The NV50 and GF100 software-class vblank methods
> > nv50_sw_chan_mthd()
> > and gf100_sw_chan_mthd() evaluate "data < device->disp-
> > > vblank.index_nr"
> > to validate the requested vblank head before allowing its notifier.
> >=20
> > On a headless card the display subdevice is absent:
> > nvkm_subdev_disable()
> > (strap-driven from devinit) and the -ENODEV path of the
> > NVKM_LAYOUT_ONCE
> > device constructor both leave device->disp =3D=3D NULL while the device
> > continues to probe and still registers a render node
> > (DRIVER_RENDER).
> > An
> > unprivileged client holding a /dev/dri/renderD* fd can then create
> > a
> > software channel and push method 0x0408 (NV50) / 0x040c (GF100),
> > which
> > dereferences the NULL device->disp and oopses the kernel.
> >=20
> > The channel constructors nv50_sw_chan_new() and gf100_sw_chan_new()
> > already tolerate an absent display ("for (i =3D 0; disp && ...)"), so
> > no
> > vblank notifier is ever registered on such a card and the method
> > handlers
> > are the only path that assumes disp is present. Guard the
> > dereference
> > with the same disp NULL test the constructors already use.
> >=20
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > Assisted-by: Claude:claude-opus-5
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c | 2 +-
> > =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c=C2=A0 | 2 +-
> > =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> > b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> > index 0171cdf6f639..4cf8cd120c76 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> > @@ -72,7 +72,7 @@ gf100_sw_chan_mthd(struct nvkm_sw_chan *base, int
> > subc, u32 mthd, u32 data)
> > =C2=A0=09=09chan->vblank.value =3D data;
> > =C2=A0=09=09return true;
> > =C2=A0=09case 0x040c:
> > -=09=09if (data < device->disp->vblank.index_nr) {
> > +=09=09if (device->disp && data < device->disp-
> > > vblank.index_nr) {
> > =C2=A0=09=09=09nvkm_event_ntfy_allow(&chan-
> > > vblank.notify[data]);
> > =C2=A0=09=09=09return true;
> > =C2=A0=09=09}
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> > b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> > index 0cfb1eaae6de..b202e11238a5 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> > @@ -69,7 +69,7 @@ nv50_sw_chan_mthd(struct nvkm_sw_chan *base, int
> > subc, u32 mthd, u32 data)
> > =C2=A0=09case 0x0400: chan->vblank.offset =3D data; return true;
> > =C2=A0=09case 0x0404: chan->vblank.value=C2=A0 =3D data; return true;
> > =C2=A0=09case 0x0408:
> > -=09=09if (data < device->disp->vblank.index_nr) {
> > +=09=09if (device->disp && data < device->disp-
> > > vblank.index_nr) {
> > =C2=A0=09=09=09nvkm_event_ntfy_allow(&chan-
> > > vblank.notify[data]);
> > =C2=A0=09=09=09return true;
> > =C2=A0=09=09}

