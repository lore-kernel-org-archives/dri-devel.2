Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16D6C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D96510E0FE;
	Thu, 17 Sep 2026 21:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="dkXTfZBv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDCF610E0FE
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 21:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789679606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04R2pZSwG+OaBUsHlvhl9TEuvS7EQ6VAEsVarWVXYVE=;
 b=dkXTfZBvZKJpPHmZ1/WHTVgV1oJrkA8WskKiptghNg1SDmPol/x8/OUxHgy4fCT2bAOher
 r6LwmZONTz1NiqvdkMFomru+Vu+kc/ew8rJwN+HGSz0auO5lmJwGVfsT7uNVuFfoN6HkPE
 rp6mlpKXhSDmSvIDyGDVZqqSm73BYHk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-f1MmhMS4Ob2n4tWdXMKpZA-1; Thu, 17 Sep 2026 17:13:24 -0400
X-MC-Unique: f1MmhMS4Ob2n4tWdXMKpZA-1
X-Mimecast-MFC-AGG-ID: f1MmhMS4Ob2n4tWdXMKpZA_1789679604
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so10956985a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789679604; x=1790284404;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+1WRQ3xpv0F4/rm47tzzwq3oGBSMX7i9LTQrQwZCVGM=;
 b=RGj9lOspd19p5h2MwOU+aYtJ1Qz0g17TNSAsoA26eEEMl8YXUmp29poCav9mQ2ppUv
 R0DsY2cau7Tn2laGEYKKNAxF9yJnVNknITIlvjbIIUvAUVmQJuQGCXMPMimf0ewQ9esf
 UfEftORglS5TLKUS3kWlWNrJMUxnR5WRlz3q9MuxpeW1uIOWhjsuf7Kcz+NabseklRcR
 WQic9G9q+qBwsAsRhZzmdIUM3tDOzzQz9NuZcHlPdcWqSK3+FS2kqVBVWR4wkaeLoDmH
 4MdDd8Lw6Y5xA9a+LBGd6Qy9dd89BKizuoAoA8b8YvSy/8DNc/zeGQBB8Vn0sNBN22Wo
 zqxA==
X-Gm-Message-State: AFuF++mptvs5VMyGNM25aKFxgYq/lPGoL4V74UVlzr13PvKscQSILiA2
 WKfEQhPlqFgQWeOE1Skrcr2BQ8HZPG8OBgde/2gWViU6tnt0DaWbT8ksudtynGb3swiHZUNYKBO
 d3zU69sEqxTyQMMuqAEnGGbpVYizmpEo/WN2c16w/LHE0nmjIZauEpLYjjTq8TQca0A1slA==
X-Gm-Gg: AYBFou2no2/ti2Tv03bKciaYh/nLot9OYdI2KTw25aQqRbHByOCagOeRMHRRmAC2Ko6
 ZOCs2zbOT6XYFl93b9txjpIIbnUPRcl7OEiU5GmOGdef01oS0RRCKprmj3JbvcHoiq+OoYcHDQz
 +/f6lM55a6UaGqNNZsKUePgoiLNayPZI58YFioDdNxGeNGqj6irB7bUT96MWyqC5MfFLRkWMYFz
 dMpaiQrdEww/iMPRWVWuSFBRwprvaL9p2tF/iRtoE8V9Mr0ysdWg0LjzVP+hw/79KQZXlySuPQt
 kGWe2Er0kUz3WVUisXcQ6l7jIIVIpBxctyuddqiBy1RTeoS6sbikaDUYWNdS8gfvBHxlehCu
X-Received: by 2002:a05:620a:4103:b0:938:e23a:2ce9 with SMTP id
 af79cd13be357-93bdc6d5f01mr40255285a.16.1789679603875; 
 Thu, 17 Sep 2026 14:13:23 -0700 (PDT)
X-Received: by 2002:a05:620a:4103:b0:938:e23a:2ce9 with SMTP id
 af79cd13be357-93bdc6d5f01mr40251785a.16.1789679603464; 
 Thu, 17 Sep 2026 14:13:23 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93b7821d231sm558697385a.21.2026.09.17.14.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:13:22 -0700 (PDT)
Message-ID: <d6d916ceab76de14541a087c092cecf895c82164.camel@redhat.com>
Subject: Re: [PATCH v2 3/4] drm/nouveau/device: don't use the pstate cursor
 after the loop
From: lyude@redhat.com
To: Francesco Magazzu <postadelmaga@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
 Karol Herbst <kherbst@redhat.com>
Date: Thu, 17 Sep 2026 17:13:21 -0400
In-Reply-To: <20260712123616.1180830-4-postadelmaga@gmail.com>
References: <20260712123616.1180830-1-postadelmaga@gmail.com>
 <20260712123616.1180830-4-postadelmaga@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TKHqcnV7scThZgltxaOayrXjDAckilQ4tqTP4PNQsrQ_1789679604
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
> nvkm_control_mthd_pstate_attr() looks up the pstate at the index
> supplied
> by userspace by walking clk->states, and then keeps using the
> list_for_each_entry cursor after the loop.=C2=A0 This is not triggerable
> today:
> the function already rejects args->v0.state >=3D clk->state_nr before
> the
> loop, and clk->state_nr is kept in sync with the number of entries on
> clk->states, so the lookup always breaks on a real entry.
>=20
> Should the loop ever run to completion, the cursor would point at the
> list
> head rather than at a pstate, and the pstate->base.domain[] read and
> the
> walk of pstate->list that follow would read past it.=C2=A0 Rather than
> leave
> that trap in place, track whether the entry was found and return -
> EINVAL if
> it was not, like the other lookup failures in this function.
>=20
> No functional change.
>=20
> Signed-off-by: Francesco Magazzu <postadelmaga@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c | 8 +++++++-
> =C2=A01 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
> index f2e9a0626..28702741a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/ctrl.c
> @@ -74,6 +74,7 @@ nvkm_control_mthd_pstate_attr(struct nvkm_control
> *ctrl, void *data, u32 size)
> =C2=A0=09const struct nvkm_domain *domain;
> =C2=A0=09struct nvkm_pstate *pstate;
> =C2=A0=09struct nvkm_cstate *cstate;
> +=09bool found =3D false;
> =C2=A0=09int i =3D 0, j =3D -1;
> =C2=A0=09u32 lo, hi;
> =C2=A0=09int ret =3D -ENOSYS;
> @@ -104,10 +105,15 @@ nvkm_control_mthd_pstate_attr(struct
> nvkm_control *ctrl, void *data, u32 size)
> =C2=A0
> =C2=A0=09if (args->v0.state !=3D
> NVIF_CONTROL_PSTATE_ATTR_V0_STATE_CURRENT) {
> =C2=A0=09=09list_for_each_entry(pstate, &clk->states, head) {
> -=09=09=09if (i++ =3D=3D args->v0.state)
> +=09=09=09if (i++ =3D=3D args->v0.state) {
> +=09=09=09=09found =3D true;
> =C2=A0=09=09=09=09break;
> +=09=09=09}
> =C2=A0=09=09}
> =C2=A0
> +=09=09if (!found)
> +=09=09=09return -EINVAL;
> +
> =C2=A0=09=09lo =3D pstate->base.domain[domain->name];
> =C2=A0=09=09hi =3D lo;
> =C2=A0=09=09list_for_each_entry(cstate, &pstate->list, head) {

