Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FA0C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5B010E856;
	Thu, 17 Sep 2026 21:16:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gf91patZ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD13B10E856
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 21:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789679760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U30+X8b8VCQRj2XuUuDWhtkaw9kybNJuopyq3kL9/18=;
 b=gf91patZFfZSg9Z3zLiGY8AgGOwfZGOVlWSNxs0dDZD7RY/gXMw+l5uqijpX7TyHhN8zNB
 dxwHTsOEggKiRKTsVVb2lVV4fa7kj3BBoV3mULUmirYQ2Hx6zmmEUlC1irY7qcj64Rnw1P
 kUqRL7WTzSp7yH2XlYN8LXEDdm1gYb4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-F0crp-sRPjadeQQGcEdm6g-1; Thu, 17 Sep 2026 17:15:58 -0400
X-MC-Unique: F0crp-sRPjadeQQGcEdm6g-1
X-Mimecast-MFC-AGG-ID: F0crp-sRPjadeQQGcEdm6g_1789679758
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52fb8f67601so215141cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:15:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789679758; x=1790284558;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OtRNevT1H99BcwMOJOoJJC1/helgpSitXQyz+o5WM/M=;
 b=HEAVytgGyarP4uNEo4AbUhOoN2/6TtKM49KZ8RfG1YfZVe83AbYu9LREV+OGqIRKBM
 Bl1Iagk3jiqi+PnEYhjtVMduOywsbeivJBLJx1SjFRCQAvP1Ew30svAyjcvqgWp1cnSP
 vSl1fLVZJJqqkpFg5kHLSGI/WT7+8zwjJs6DF3jvZ39Lyxo524WLC8oBhmIY7xTmefAK
 Uqn/UcB4HPXmBWaw/sAeRoy9hLbKajpxKTPNty9cTsB0U5W0MAbZmNyR3PMjS78gzk9U
 J8ovRMMiU3R2hCAAjTBJMSxUsxlG6NV3jbtwcjvA+0N3ig+apWsOWZ+Z3TB2ysEa7tFu
 Z6Uw==
X-Gm-Message-State: AFuF++mtbOo6LXPi9r3XJ5Ie3tutCPIvU0I3Ix8d/VkOzN+2/wfmKLXa
 liY9S4Ph8OLVPTSnr+6OKfk3p3fzdxtVuoUT0RfYRedKGS+jwuBfwMImqhYJ5ad1ewkAWXUo6Qp
 Su80Z/9shVKtxREvYFkInviia9OUf2QQrOk0VHIhtwA03djJRo68po3y9pWaLVCB7o7PjIg==
X-Gm-Gg: AYBFou2YFQMKndtdDYqvo3Xum0RZhWq0NklkOUtpPB/hKxluVD0k5YdC6XCSUXnPJIS
 Wrr9uI0JwEnVR/s0U9J5tXl2JIPxUBxBouzaBChRfFA2iKaS5z4f53avCEwu9dJqoWdHdG8hAr1
 kZVMdE+WjZzIeOQDlQWhtpaD/NOmgpzZlETYFKMfIzYkveDB4KA/8dWiHnToF4GoKaBuiOZtxuF
 DYkyKLac4Sab/gbfdkfjS3B4Ls9b0kbhfO4JSGhwXIQUgGoxgJ+Wh5joLyztgIWr4FpGEbGsswD
 0ytwDDUThhyo9lI8ZGYnrAC9s0aAVX4xgbugNxtYaONOTXRAOgNEnQzP3/4Xo6Ku7HqOkDer
X-Received: by 2002:a05:622a:448:b0:532:8827:a9bd with SMTP id
 d75a77b69052e-5329e49522fmr8782711cf.39.1789679757583; 
 Thu, 17 Sep 2026 14:15:57 -0700 (PDT)
X-Received: by 2002:a05:622a:448:b0:532:8827:a9bd with SMTP id
 d75a77b69052e-5329e49522fmr8781941cf.39.1789679756871; 
 Thu, 17 Sep 2026 14:15:56 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532620b0c44sm59939841cf.26.2026.09.17.14.15.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:15:56 -0700 (PDT)
Message-ID: <9442921931d5c4b78d4345ff87b51b8e6e668d2c.camel@redhat.com>
Subject: Re: [PATCH v2 2/4] drm/nouveau/clk: don't use the pstate cursor
 after the loop
From: lyude@redhat.com
To: Francesco Magazzu <postadelmaga@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Karol Herbst <kherbst@redhat.com>
Date: Thu, 17 Sep 2026 17:15:55 -0400
In-Reply-To: <20260712123616.1180830-3-postadelmaga@gmail.com>
References: <20260712123616.1180830-1-postadelmaga@gmail.com>
 <20260712123616.1180830-3-postadelmaga@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M7b2hrM6iRtNxoFgMRG92jvHkFuPGbCr7o1rIX0wZHc_1789679758
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

On Sun, 2026-07-12 at 14:36 +0200, Francesco Magazzu wrote:
> nvkm_pstate_prog() walks clk->states looking for the entry at index
> 'pstatei' and then keeps using the list_for_each_entry cursor after
> the
> loop.=C2=A0 This is not triggerable today: every caller clamps the index
> against clk->state_nr before calling, so the loop always breaks on a
> real
> entry.=C2=A0 It is safe by virtue of what the callers happen to do, not b=
y
> anything the function itself checks.
>=20
> Should a caller ever pass an index that is not on the list, the
> cursor
> would point at the list head rather than at a pstate, and the
> pstate->base.domain[] and pstate->fanspeed accesses that follow would
> read
> past it.=C2=A0 Rather than leave that trap in place for the next caller,
> track
> whether the entry was found and return -EINVAL if it was not.
>=20
> No functional change.
>=20
> Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 8 +++++++-
> =C2=A01 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> index 42f3709e0..4d546b07f 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> @@ -270,13 +270,19 @@ nvkm_pstate_prog(struct nvkm_clk *clk, int
> pstatei)
> =C2=A0=09struct nvkm_fb *fb =3D subdev->device->fb;
> =C2=A0=09struct nvkm_pci *pci =3D subdev->device->pci;
> =C2=A0=09struct nvkm_pstate *pstate;
> +=09bool found =3D false;
> =C2=A0=09int ret, idx =3D 0;
> =C2=A0
> =C2=A0=09list_for_each_entry(pstate, &clk->states, head) {
> -=09=09if (idx++ =3D=3D pstatei)
> +=09=09if (idx++ =3D=3D pstatei) {
> +=09=09=09found =3D true;
> =C2=A0=09=09=09break;
> +=09=09}
> =C2=A0=09}
> =C2=A0
> +=09if (!found)
> +=09=09return -EINVAL;
> +
> =C2=A0=09nvkm_debug(subdev, "setting performance state %d\n",
> pstatei);
> =C2=A0=09clk->pstate =3D pstatei;
> =C2=A0

