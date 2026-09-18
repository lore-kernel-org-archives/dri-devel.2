Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1213FC982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:05:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EB3C10E979;
	Fri, 18 Sep 2026 18:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Xt0Hf/2O";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F39F10E979
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 18:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789754730;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oprrZIAjlpFsvHJfs+zMLP7oKhVuy9HKJ3yJD5IzrmM=;
 b=Xt0Hf/2OgNjNciV1SOE2kQCHNs2TeQCqjGM04nLOX6ox6Ypgb64w91z9UBN71TkV19CoSc
 uK2jTGDLbQZ2kZzig2ZThclIwVlDiujSE626jlaITBtMQA7g0RiPXmY1khASewF8BNaJLi
 iAvn7L1a1E+HNwSiIpR/hdaRrwW/Adg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-nR_ZCW0rO0SwfHldYJe2qw-1; Fri, 18 Sep 2026 14:05:29 -0400
X-MC-Unique: nR_ZCW0rO0SwfHldYJe2qw-1
X-Mimecast-MFC-AGG-ID: nR_ZCW0rO0SwfHldYJe2qw_1789754727
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9393ac4961fso155944985a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 11:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789754727; x=1790359527;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8MrzAMtxqLSmsHZdu6tZejw7G1EUBpmA2nrahp3/aZ0=;
 b=XuNKHr9BITFE30lJtVdspmbSDvpofwHB1ilYvRDEWe+m9MWRWRh/nmhSb8Y69e5/9k
 s6yaft4LpYaFAZVEkmuAxRtYRp42AHaCKJrhMD69Ad45McaCVN6E/P342C4xJrU3aMIP
 jcYopzq2fmjQr7s59wtc0ZnmNdSj/qOQOw5xXV0spSSb/tEhl0JmNPVPAh9ysRcxDMFo
 ulDAeS3wXgatLg0xjzUhTRJQjSUmHOGQvnuLz9Dvdn9NQH49WgOMDWk3UeVCka+tx2fR
 gBJnkb1GJswHIDVZLVBLbtDyC8T2qktzGqhGKiQi9dI6fEvoB7edafqr3IVtp1CcTFvs
 31nA==
X-Gm-Message-State: AFuF++lufFs6qw7DZ5XYbuvc73d92IPwetcoksiZcFfe0ALUEMji+h5Q
 ShIBmQf/vrfWKwmQsJeAqESJAjrzPkacgnWTxlYJRv2I2GC3I+92lTRav5GqkET9/ZGfBWMG+wZ
 QjVi9YBrzf04Pb4yjH0fYJrwr5nnZHx9yb3KjmyybXk35ycg7UVoBfv/87ItU6ZQ/eREWCQ==
X-Gm-Gg: AYBFou2NSjPZomXLWL17WF1CwaqS+SgH1lhQFlmHW6VTiYneY9LMh9J6GrJ9nkvEeVz
 Ude5YM6LQlt1AsD+Kne8OY/5pK0F4R+hrkjIhjoI9C5VJZOy8T6fgZ6CTx52gmeL3ynzuHWvfJj
 BYHlOSIAImYdE5HNH7c4YISgewjQIM2aJDez7sP2YDsr4zYvDBwXmbzZhjgsFEURgBEDVaT2hKj
 dBgPQD3Fq0KdQmEf+doF7mg0oY5+HnhJh8u6dewguq2U+Fh9ngOltcEWQX870qj+5s6PpkusekC
 gLkZMzyirpzMLTjfUnkmyGT6R+IrTKoZRBsseHoNi3KYUoJmVAcf5p0+/x/wiiTPwc1yhydB
X-Received: by 2002:a05:620a:178d:b0:93b:d7a2:dd36 with SMTP id
 af79cd13be357-93bdca3f401mr534881285a.70.1789754727275; 
 Fri, 18 Sep 2026 11:05:27 -0700 (PDT)
X-Received: by 2002:a05:620a:178d:b0:93b:d7a2:dd36 with SMTP id
 af79cd13be357-93bdca3f401mr534873585a.70.1789754726696; 
 Fri, 18 Sep 2026 11:05:26 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93beda709b1sm3179785a.7.2026.09.18.11.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 11:05:26 -0700 (PDT)
Message-ID: <fa3a44fa852c8fd3b86eeb7e03ba87692056fc3e.camel@redhat.com>
Subject: Re: [PATCH v3 1/4] drm/nouveau/clk: fix list cursor use after loop
 in nvkm_clk_ustate_update
From: lyude@redhat.com
To: Francesco Magazzu <postadelmaga@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, Karol
 Herbst	 <kherbst@redhat.com>
Date: Fri, 18 Sep 2026 14:05:25 -0400
In-Reply-To: <20260918131620.405133-2-postadelmaga@gmail.com>
References: <20260918131620.405133-1-postadelmaga@gmail.com>
 <20260918131620.405133-2-postadelmaga@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VdVBFkLwGE8eDph7WkNBiJZ4BYiQwDGoK9_0H9oMC74_1789754727
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

Will push to drm-misc-fixes in just a moment, thank you for the fixes!

On Fri, 2026-09-18 at 15:16 +0200, Francesco Magazzu wrote:
> From: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> If list_for_each_entry() exits without hitting a break then "pstate"
> is
> not a valid pstate pointer.=C2=A0 Introduce a "found" variable instead.
>=20
> The check is reachable from userspace: nvkm_clk_ustate_update() takes
> the
> pstate id straight from the 'pstate' debugfs file, so requesting an
> id
> that is not in clk->states - or any id at all when the perf tables
> are
> broken and the list is empty - makes the pstate->pstate !=3D req test
> dereference the list head cast to a struct nvkm_pstate, which is an
> out-of-bounds read.
>=20
> Fixes: 7c8565220697 ("drm/nouveau/clk: implement power state and
> engine clock control in core")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> [Francesco: rebased on drm-misc-next, expanded the commit message]
> Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
> ---
> This is Dan's 2022 patch, reposted with his authorship restored as
> asked
> in the review of v2.=C2=A0 The diff is byte for byte what he sent; the
> commit
> message keeps his original two sentences and adds a paragraph on how
> the
> check is reached from userspace.
> Link: https://lore.kernel.org/dri-devel/YvSkKAdk8Pe0g2K9@kili/
>=20
> =C2=A0drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c | 7 +++++--
> =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> index 572e63846..5da82db71 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
> @@ -473,6 +473,7 @@ static int
> =C2=A0nvkm_clk_ustate_update(struct nvkm_clk *clk, int req)
> =C2=A0{
> =C2=A0=09struct nvkm_pstate *pstate;
> +=09bool found =3D false;
> =C2=A0=09int i =3D 0;
> =C2=A0
> =C2=A0=09if (!clk->allow_reclock)
> @@ -480,12 +481,14 @@ nvkm_clk_ustate_update(struct nvkm_clk *clk,
> int req)
> =C2=A0
> =C2=A0=09if (req !=3D -1 && req !=3D -2) {
> =C2=A0=09=09list_for_each_entry(pstate, &clk->states, head) {
> -=09=09=09if (pstate->pstate =3D=3D req)
> +=09=09=09if (pstate->pstate =3D=3D req) {
> +=09=09=09=09found =3D true;
> =C2=A0=09=09=09=09break;
> +=09=09=09}
> =C2=A0=09=09=09i++;
> =C2=A0=09=09}
> =C2=A0
> -=09=09if (pstate->pstate !=3D req)
> +=09=09if (!found)
> =C2=A0=09=09=09return -EINVAL;
> =C2=A0=09=09req =3D i;
> =C2=A0=09}

