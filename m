Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DC0CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 23:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19CF410EB5A;
	Fri,  9 Oct 2026 23:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hRK8LJUg";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 715E010EB5A
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 23:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791588135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=90QDk9UsK++TfeFt53Yn4L9GDOFPMNUxZr70RksJ3Wo=;
 b=hRK8LJUgvYLlCucJ4nAynAi03Gsms65dAx1FmdKRiMmMekOb0fWggjkcGe9lhm1yfXyC3r
 SnnYWqZ+2t2G+Tiqr6xBbfsXA7853UvpalNcA6ELLHNPso+YpYNev5Yy3zO5xGy0akLqtZ
 F52pKgjo9vZlNQ9yjCEMPjX/xOWHYPc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-8M3I7c2uO1eAOubnwIMXrg-1; Fri, 9 Oct 2026 23:22:14 +0000
X-MC-Unique: 8M3I7c2uO1eAOubnwIMXrg-1
X-Mimecast-MFC-AGG-ID: 8M3I7c2uO1eAOubnwIMXrg_1791588134
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a3f673221so55862285a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 16:22:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791588134; x=1792192934;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MOkSafKPWfgergQn1PH0zCTo27W7O5llrWCsPU5yGRE=;
 b=d51g3jf84/6dFKP1BH+7kJjW4OcKs/wYjSUcyaybBG3X6RZanVhdcPKQwVwqsBeZBE
 ZeCs7SfUsSN5RhNrkAbYLEMsj4ZOAbgg/N1aIzAvPiQbe+QimjIoxjfUpm0nCYRNBr7i
 ZtavSVh8i628eZAymT9qIGrkhiHzaJWtLSKrqOYVj/iA3ofWIwtltfB8xsEnxdv5ABne
 dPBhBTmkmak1NNGg9s+m81EVW/3sdUEVOsVwuaI74D0fmjNu/szfQ9PCRb4Liarix+MI
 C8SFl1IEXIG///ELIYbZlCmpRyuxNufcPTG/W4KEZ1541ro5E84ZFnSYK9oAWrztlDWw
 JN8Q==
X-Gm-Message-State: AFq9FYJIduPcZB8Wjme2Ps0a1csfy5uHZCCHwgLzqJSXJLObCaQ0mM6K
 juLFZSbFZvL81w9v91ZZJkodGb3t9H4i7G9WtNSEJ6r913tA6oG0olqT0LCUWYF6TH0JgPzxfxm
 AfW4s9pHDDP3x0hPINTRdjxmtU87bKe0dKH2x1irlBiq+UeZdL1BEltzjm5DMxpMrmzojzA==
X-Gm-Gg: AYBFou27daZf57ZnKpMg6s44lGDFOWMdwZ4xRGcQzfgMDRPPe3mykgVuYHFYgnrRCBf
 JQNmfvExNHAtDkFgT8TQZHGigLvpgM0VC8OfjBXYTd42myn4rj5uR90arLEcFmVChcXJcd9zSas
 DdUN/aB2WWYMeGx8v/aAaD0aE/X9MYQQ4hGlINgEfDe4Nw9bJV6Dshm6a68gJiiK+xKfa452OsH
 1kiRF8+HLLQ2DhoKB9BwT0Joyitt9pOBtTorUe3wBoXg3aQtA/psIBhqGGb8ikSphVQrrx39pg2
 1Neaf9te/Suhv92hzySksbx9Vqg6APNkUnwyUy0GNxQyJ5hQkzkIBkGUgobYngXJ5QL+1rw=
X-Received: by 2002:a05:620a:178e:b0:93c:57da:4ef0 with SMTP id
 af79cd13be357-93ebd2916eamr545877785a.56.1791588133669; 
 Fri, 09 Oct 2026 16:22:13 -0700 (PDT)
X-Received: by 2002:a05:620a:178e:b0:93c:57da:4ef0 with SMTP id
 af79cd13be357-93ebd2916eamr545873585a.56.1791588133188; 
 Fri, 09 Oct 2026 16:22:13 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb984889fsm300130785a.13.2026.10.09.16.22.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 16:22:12 -0700 (PDT)
Message-ID: <929077046827f363bc32f6f59e760de27a48b5ff.camel@redhat.com>
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
Date: Fri, 09 Oct 2026 19:22:11 -0400
In-Reply-To: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-1-7e057f6aeba0@gmail.com>
References: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
 <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-1-7e057f6aeba0@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MvQ2Qs0e4CVXlNI_yrMx1vOGRTZRsXBPsGohf3UIuzg_1791588134
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

Will push to drm-misc-next in a moment

On Wed, 2026-08-12 at 23:00 +0800, Zhenhao Wan wrote:
> The NV50 and GF100 software-class vblank methods nv50_sw_chan_mthd()
> and gf100_sw_chan_mthd() evaluate "data < device->disp-
> >vblank.index_nr"
> to validate the requested vblank head before allowing its notifier.
>=20
> On a headless card the display subdevice is absent:
> nvkm_subdev_disable()
> (strap-driven from devinit) and the -ENODEV path of the
> NVKM_LAYOUT_ONCE
> device constructor both leave device->disp =3D=3D NULL while the device
> continues to probe and still registers a render node (DRIVER_RENDER).
> An
> unprivileged client holding a /dev/dri/renderD* fd can then create a
> software channel and push method 0x0408 (NV50) / 0x040c (GF100),
> which
> dereferences the NULL device->disp and oopses the kernel.
>=20
> The channel constructors nv50_sw_chan_new() and gf100_sw_chan_new()
> already tolerate an absent display ("for (i =3D 0; disp && ...)"), so
> no
> vblank notifier is ever registered on such a card and the method
> handlers
> are the only path that assumes disp is present. Guard the dereference
> with the same disp NULL test the constructors already use.
>=20
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c | 2 +-
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c=C2=A0 | 2 +-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> index 0171cdf6f639..4cf8cd120c76 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
> @@ -72,7 +72,7 @@ gf100_sw_chan_mthd(struct nvkm_sw_chan *base, int
> subc, u32 mthd, u32 data)
> =C2=A0=09=09chan->vblank.value =3D data;
> =C2=A0=09=09return true;
> =C2=A0=09case 0x040c:
> -=09=09if (data < device->disp->vblank.index_nr) {
> +=09=09if (device->disp && data < device->disp-
> >vblank.index_nr) {
> =C2=A0=09=09=09nvkm_event_ntfy_allow(&chan-
> >vblank.notify[data]);
> =C2=A0=09=09=09return true;
> =C2=A0=09=09}
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> index 0cfb1eaae6de..b202e11238a5 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
> @@ -69,7 +69,7 @@ nv50_sw_chan_mthd(struct nvkm_sw_chan *base, int
> subc, u32 mthd, u32 data)
> =C2=A0=09case 0x0400: chan->vblank.offset =3D data; return true;
> =C2=A0=09case 0x0404: chan->vblank.value=C2=A0 =3D data; return true;
> =C2=A0=09case 0x0408:
> -=09=09if (data < device->disp->vblank.index_nr) {
> +=09=09if (device->disp && data < device->disp-
> >vblank.index_nr) {
> =C2=A0=09=09=09nvkm_event_ntfy_allow(&chan-
> >vblank.notify[data]);
> =C2=A0=09=09=09return true;
> =C2=A0=09=09}

