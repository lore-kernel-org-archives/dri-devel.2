Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90552CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 23:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE64C11231F;
	Fri,  9 Oct 2026 23:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZlM3Ws5I";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5DB611231F
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 23:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791588287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c13MuhXT24Rb6zhv5dO/7ybzw4u9qtSVSio9SfsGxY4=;
 b=ZlM3Ws5IfnsCQCizY6qRFl5t6hagStNqRdibxqr0YixRC9PqeYY4FoaYxeBrSDn1UNU560
 ebQI0Fw7n4U2HhRPv0WXLeoS8T9EO9bdfPoFX+bAh9KvS7hwfsNNGYzMSQ+dUE4jLgqLhH
 8hwKjgkeSYkBgfp+SJQ0Aw8VfOIQqyA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-oyBi2VLWPCGf2XgdgiNrIg-1; Fri, 9 Oct 2026 23:24:45 +0000
X-MC-Unique: oyBi2VLWPCGf2XgdgiNrIg-1
X-Mimecast-MFC-AGG-ID: oyBi2VLWPCGf2XgdgiNrIg_1791588285
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so42143685a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 16:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791588285; x=1792193085;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T5sL1IN+vEe3uRvA6b5GRf1/o9Y8z+Hb4XnuY1HXzNs=;
 b=Du8Xr1tsDR2Iih+zWRlFlkMxKyJb/QaYskGKsm59yUtA9ADjIg4l0zCE17xmjVCUdK
 p0W/mqhXgI361Gcm6EGTLSNak/ywskxKwyjYCHCsrBRc5XEuvclvX7VCWhw3qwL8b6fA
 u4YRjBtUAxyb08HbhSkMYakSy5T86amP5cSvnWOUAbeTzFtiLjvZcT8+M95tlb05/GxC
 TF7HvTZDC2VtsPQNCPZPwMMItv0HZZgK/vz1OfTjj+v52BRVjifT6ZAiXD08bcuu++Qh
 /Bw6wb8Tgd4GLuDRrAgATlmITWoz+Z6vNVw9fjCwHA/XgQ4Kgr52Tx0pGCiKxHBLIPeW
 ZHNA==
X-Gm-Message-State: AFq9FYLKLP+LO5mOJaRytsvPuIRaq6KLTWJd5gPBp3N3aUA/+meOdd0o
 xbURKLsGvC8JhExxnnrNSWBIdTJ125K6QJ2xVRHaX7gjV17krs9OmCaAB7bGKWBhWpJqvgcUN/a
 UQwdYYBSxTfg3KRFYzRUOScvPfsVzqdXc69b1xCXoZEsz2BB0Vfk/0R1YbZMOtBJqfkesEA==
X-Gm-Gg: AYBFou2AuofQI9OfRufaZIFMtFyDiZXzANn2pCFGUVemVwvFnyH0dwIMKV/vizgGf/t
 BOP0RfxNayPXRZ/YBh0d7rMsyKyYi7By9pzHrDH5hhLeF4WLjgOAETNXhsE094uPQThgmRQKmYQ
 jOHC60WAW04y4pGfVzrXSbMYsJdps8eKdEjeShnGkXHagh2Po4zrmjIIdwaOdvJVS+ffU4hT+ly
 dsPn7wVMuuAJCfleR+TCKMKxsjPsi6m/O8TpImGeavxLpfzRg6oo2yaqIWMXW4JMXzy3nr7rcec
 43pBwyDemMLDb3Socw7pvmNTO2IKV9DoHCPrrc4ROsj5JOplSYLbj/8oSUunCMUpjwywbUk=
X-Received: by 2002:a05:620a:a419:20b0:93e:c12c:f145 with SMTP id
 af79cd13be357-93ec12d06ddmr330166885a.79.1791588285219; 
 Fri, 09 Oct 2026 16:24:45 -0700 (PDT)
X-Received: by 2002:a05:620a:a419:20b0:93e:c12c:f145 with SMTP id
 af79cd13be357-93ec12d06ddmr330165185a.79.1791588284801; 
 Fri, 09 Oct 2026 16:24:44 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb98e3a33sm297469885a.40.2026.10.09.16.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 16:24:44 -0700 (PDT)
Message-ID: <a6f23983895d0d09b9c2c6a02160c5e3949a6a81.camel@redhat.com>
Subject: Re: [PATCH 2/2] drm/nouveau: prevent NULL deref of gr in
 GETPARAM_GRAPH_UNITS
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
Date: Fri, 09 Oct 2026 19:24:43 -0400
In-Reply-To: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-2-7e057f6aeba0@gmail.com>
References: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
 <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-2-7e057f6aeba0@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ansTRhzEpmejsRO-bGDdxpx0943R58A5AbT0tF4HiXk_1791588285
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

Since this kind of relies on driver initialization having already
failed (which I'm sure breaks many other things we haven't found yet)
I'm going to push this to drm-misc-next

On Wed, 2026-08-12 at 23:00 +0800, Zhenhao Wan wrote:
> nouveau_abi16_ioctl_getparam() fetches the graphics engine with
> gr =3D nvxx_gr(drm) (i.e. drm->nvkm->gr) and, for the
> NOUVEAU_GETPARAM_GRAPH_UNITS parameter, passes it straight to
> nvkm_gr_units(), which dereferences gr->func with no NULL check.
>=20
> When graphics-engine construction returns -ENODEV, NVKM treats it as
> an
> optional absent engine: the NVKM_LAYOUT_ONCE device constructor
> deletes
> the subdevice, leaves device->gr =3D=3D NULL and continues probing, and
> Nouveau still registers a render node. An unprivileged client holding
> a
> /dev/dri/renderD* fd can then issue DRM_IOCTL_NOUVEAU_GETPARAM with
> NOUVEAU_GETPARAM_GRAPH_UNITS and oops the kernel on the NULL gr.
>=20
> Report 0 units when gr is absent. This matches nvkm_gr_units()
> itself,
> which already returns 0 when the engine exposes no units callback.
>=20
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_abi16.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> index 291203121f0c..dd3f8d386377 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
> @@ -306,7 +306,7 @@ nouveau_abi16_ioctl_getparam(ABI16_IOCTL_ARGS)
> =C2=A0=09=09getparam->value =3D 1;
> =C2=A0=09=09break;
> =C2=A0=09case NOUVEAU_GETPARAM_GRAPH_UNITS:
> -=09=09getparam->value =3D nvkm_gr_units(gr);
> +=09=09getparam->value =3D gr ? nvkm_gr_units(gr) : 0;
> =C2=A0=09=09break;
> =C2=A0=09case NOUVEAU_GETPARAM_EXEC_PUSH_MAX: {
> =C2=A0=09=09int ib_max =3D getparam_dma_ib_max(device);

