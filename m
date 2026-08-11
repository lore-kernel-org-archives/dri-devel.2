Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FA9C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F47210E124;
	Tue, 11 Aug 2026 21:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ChjBhG2q";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EEF110E124
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786482933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CasrwAeU4zNExmdvqxolJrRbP1xj2cuvMnUIVD1Umt8=;
 b=ChjBhG2q/QKnqbiKanQiAyc8XMgl97Uia+PK+zAV03lCxhvqwHZUSo5CXQLCQ5zj2pIsv0
 FkYMNsz43hlUwmcDM3vcXZYPE3TI7yCwCZrK2JiW7mwqZznyixqXyWtCsskmVNeLRVX6kf
 s+w/e7SbzQ7ceWhqveY37hU1zwizP90=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-Z5Vma-4QM8Ofa4ltJzLdug-1; Tue, 11 Aug 2026 17:14:24 -0400
X-MC-Unique: Z5Vma-4QM8Ofa4ltJzLdug-1
X-Mimecast-MFC-AGG-ID: Z5Vma-4QM8Ofa4ltJzLdug_1786482863
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9349c5af52bso69149085a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786482863; x=1787087663;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ouhsGoLziLRHCm+hWwEcaYZBRlXQpJLyEgr0LCF275A=;
 b=LxHf1d63wFjaSr+stmHV8L22Z/4p4sIZ5UxBGwalcxY9CF4LQ2F+TNUWI2n0P38Z9v
 7tm5ZMc7ANu+TOCuMx1tnmhfZHVgqO6vYXEVhxcSS/svsfrzV7y+qTNrUN6lBM4ozLMN
 Pr+akoKsrehl13LG4pE1t3yeyRx740RjEx01hxZx/BesUH07I1tbRvlaPI+6kuN0vb3/
 iSOnHCJmNqKEHT1DrUzsP9KJ2Pl8dJVrWBfs6eD6NpBaZFNafg7uEacrP2VlCcf18Zay
 /RvI6zqvFj8+T1KxRIXQvfhIdPr2ieXxLZK0hbCPksiDZ79Z03GB1MImft3c2LUK50tX
 wb1Q==
X-Gm-Message-State: AOJu0YxYttP2W6XBIQQMXPw2mfTTTN8bbVkkHPgqxtQwFE10yJqdmX9P
 i6bwglXfGF9wYmW24g7AXMEPiYsy+KGdw31qRCQQHN6sJbphxinu78Q7JfLn8kgRD0WQhvpQNow
 /eRPu33v8gJ81nF+xB0ul/6Uwg+YJfQcQfxPURAKKpzRJttgelwFu0w3pt8RzBcFukHhTkw==
X-Gm-Gg: AR+sD10T6Bf4oq3ushfyXCeul/+6q8wyVHWnPkKmasgonBuOOhru4ZnBldsAOWLCj5p
 ehlock/nfA9E78I7IU+mmQWz0vW8SFcqxzpVpBD2tZqh29sQ1BQ0inDpEx1j492ArkPHNLz1GSX
 LEGuXt3z7HU9wHtOgFXLpjh40qTvnVELzeW6bWLfOPhxdlYeNILsO2GFPUIIgm/9fAbH2+68nQq
 MIW1I8jYHxwVrWlje7rI6PNskV1blwKkrT7ukploDUsYpa4/gjZT6Xrv3GYEfD0cgKE3iV3JK1v
 TDiGD0ss737lEBOe+yoCbfwoxsaeIs5HlJQhLfeKqIbIW2ZldKHpLwtkIfBQWhsH/A1PAzIf
X-Received: by 2002:a05:620a:25cf:b0:930:a718:bafb with SMTP id
 af79cd13be357-936b3a4201dmr39431185a.10.1786482863528; 
 Tue, 11 Aug 2026 14:14:23 -0700 (PDT)
X-Received: by 2002:a05:620a:25cf:b0:930:a718:bafb with SMTP id
 af79cd13be357-936b3a4201dmr39428185a.10.1786482863056; 
 Tue, 11 Aug 2026 14:14:23 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936a848e7ecsm196988185a.11.2026.08.11.14.14.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 14:14:22 -0700 (PDT)
Message-ID: <a24ff71ff94630ec818477ce6c590215ac3839e0.camel@redhat.com>
Subject: Re: [PATCH 2/2] drm/nouveau/dmem: fix callocated underflow on large
 folio split
From: lyude@redhat.com
To: Zhenhao Wan <whi4ed0g@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Andrew Morton
 <akpm@linux-foundation.org>, Balbir Singh	 <balbirs@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
Date: Tue, 11 Aug 2026 17:14:21 -0400
In-Reply-To: <20260811-b4-nouveau-dmem-thp-fixes-v1-2-2cdf9860af2a@gmail.com>
References: <20260811-b4-nouveau-dmem-thp-fixes-v1-0-2cdf9860af2a@gmail.com>
 <20260811-b4-nouveau-dmem-thp-fixes-v1-2-2cdf9860af2a@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s8YXQzP8qj7LpHfsuy-T-cRLDvM3qmpDyCPj-5hD2GA_1786482863
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

This patch looks suspiciously human written (or at the very least, the
commit message sure does). FWIW: if the code wasn't itself generated by
an LLM, it's fine by me to avoid adding the tag. Most of us are
concerned about generated LLM code that gets submitted, not human
written code written to fix a legitimate issue that an LLM managed to
help find. If we were concerned about the latter, I think anything
sashiko touched would end up having an assisted-by tag on it :).

Either way, this whole patch series is:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Issue looks quite legitimate, fix seems fine to me.

On Tue, 2026-08-11 at 22:28 +0800, Zhenhao Wan wrote:
> nouveau_dmem_folio_free() drops chunk->callocated once per freed
> folio,
> while a large (compound) device-private folio is only counted once
> when
> it is allocated.=C2=A0 When such a folio is split, the mm core invokes
> ->folio_split() (nouveau_dmem_folio_split()) once for each new
> sub-folio, but the hook only fixes up the sub-folio metadata and
> leaves
> chunk->callocated unchanged.
>=20
> Each resulting sub-folio is later freed separately, so after a split
> the single allocation (+1) is met by N frees (-N), leaving
> chunk->callocated short by N-1.=C2=A0 On the first split/free cycle it
> underflows: WARN_ON(!chunk->callocated) fires, the unsigned counter
> wraps and never returns to zero, so the chunk can no longer be
> reclaimed (nouveau_dmem_fini() also warns on the leaked count).
>=20
> Account for the new sub-folio in the split hook, under the same lock
> as
> nouveau_dmem_folio_free(), so the count stays balanced.
>=20
> Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU
> memory migration")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_dmem.c | 14 ++++++++++++++
> =C2=A01 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index d2abee3efb9a..ad4570c50be7 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -279,11 +279,25 @@ static vm_fault_t
> nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
> =C2=A0
> =C2=A0static void nouveau_dmem_folio_split(struct folio *head, struct
> folio *tail)
> =C2=A0{
> +=09struct nouveau_dmem_chunk *chunk;
> +=09struct nouveau_dmem *dmem;
> +
> =C2=A0=09if (tail =3D=3D NULL)
> =C2=A0=09=09return;
> =C2=A0=09tail->pgmap =3D head->pgmap;
> =C2=A0=09tail->mapping =3D head->mapping;
> =C2=A0=09folio_set_zone_device_data(tail,
> folio_zone_device_data(head));
> +
> +=09/*
> +=09 * The split hands out a new independently-freeable folio
> that will
> +=09 * later be released via nouveau_dmem_folio_free(); account
> for it so
> +=09 * chunk->callocated stays balanced.
> +=09 */
> +=09chunk =3D nouveau_page_to_chunk(&head->page);
> +=09dmem =3D chunk->drm->dmem;
> +=09spin_lock(&dmem->lock);
> +=09chunk->callocated++;
> +=09spin_unlock(&dmem->lock);
> =C2=A0}
> =C2=A0
> =C2=A0static const struct dev_pagemap_ops nouveau_dmem_pagemap_ops =3D {

