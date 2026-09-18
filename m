Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98C7C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 18:21:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D7410F4B0;
	Fri, 18 Sep 2026 18:21:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="i0/kmMTe";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF7F610F4B0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 18:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789755675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/1tWvAWMwG+jeahQKpHn1GFF3Dz4eA11II+ymDKsVo=;
 b=i0/kmMTeEKWFkKsxMol9IAbJeEbhA1dx2ig0/wKKz4ffBs835za5DgtylaS6u5GD0JcpBU
 Md3h9uzPbxHr84GvJUSLw0qfOVAvvXMQ8F91BLaGaoVkaz/xigxV1do/hokal400Ahf3+o
 o7II8ad6H4OOjpJAIDjD7kAbQE1LJY0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-kYA8WJWoNmeKdNLp1GGjDQ-1; Fri, 18 Sep 2026 14:21:13 -0400
X-MC-Unique: kYA8WJWoNmeKdNLp1GGjDQ-1
X-Mimecast-MFC-AGG-ID: kYA8WJWoNmeKdNLp1GGjDQ_1789755673
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91054f537f9so22812196d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 11:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789755673; x=1790360473;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2S6whF13bO6Q8rMa62A4PVjJyOAlHhvbqnUwD5kAdIE=;
 b=WQXbalm9KI334thbq8sRmtOf2K9jyLBm2g1XbwgXXEl9XbOzfrINk6ILlpQPhdJHnm
 aLHpGFDEoJv0amOBLXx5F+REq3hn24HFvjff3gQ5aj8/2DBbOYhBr6CovlFXeJXrUfw4
 fP4l4LrUR6k5QyH4EilXaRa+OmKu/skLbmZVgIlgHCHJjuOrK5sg/Vse1rYbzX+CmXxi
 XdAmTMDxVU0k5BhB6bGbNyknfKC+PlX3SvyOTmO999RdJnuDVu49yOa5n7tJKreFASiy
 +WQuxQbAqk5LnHBAjU9vyaRMtawDgqBRYqJKJzzFfMkBjf2v1Czn3tSODGrUav0gXLHi
 I8XA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQcKVIRQwsHVX3LOwWSIkxaCDo1haArGhDYJFnbVz8sD732VwsomM4CxXrC5N5tAXJuxXgiAyJN+k=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mQKNJgW7gLxurKOhYK2PBq3n6dynEYf4gC2VpcsJ0vITtlPFgr
 ALJJuNxJvtX0+eNCzKZ91uN8MDRkCbkWb54Rk7HShHfJNcfxI8Y1tVXX3+Say1k2nqOgOjIdP5d
 lDVGnhrhI/0S0t8X1o38ufT6DWEQWM4O82CFOJNjSbIKoaJTQBYr+8Fcbd9aRsCcsLOWguhnxds
 uRfQ==
X-Gm-Gg: AYBFou1LDP0K1wdHcqVP2qJjQHMklPet9UPMqlVVaZfU2sTghF2IKpjgNY9GcrCjhlf
 bmxusJFuiNe7UwWEv+cM18X5fn6crpVPQerJWaQUtV37AlOoiNeg0qK2wam3p1vhFcUv2Q8y+IV
 IfwcwpYiaMXDToFcOg7N6YppWnsILIJkrwUQdmbUWTybakgyF0087+M3zQoLw2RawH9VUIhFoES
 hmJ3NqOT/191JdiffWZrlCJbPgoweFigZJV4GgQcuk3k0QrjJffvu10q1WnRseEoM0QUpfi5yjK
 0119U9cwydRNCidcWBci6gRqSOrYk8XJdWOc44SqLegRrZzzkQeOur92UlE8Odaz9miBoZcn
X-Received: by 2002:a05:6214:20ad:b0:907:be64:6b76 with SMTP id
 6a1803df08f44-91254e8dfc5mr49888406d6.12.1789755672484; 
 Fri, 18 Sep 2026 11:21:12 -0700 (PDT)
X-Received: by 2002:a05:6214:20ad:b0:907:be64:6b76 with SMTP id
 6a1803df08f44-91254e8dfc5mr49887826d6.12.1789755671848; 
 Fri, 18 Sep 2026 11:21:11 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91260a85c7bsm1762376d6.32.2026.09.18.11.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 11:21:10 -0700 (PDT)
Message-ID: <f8a34420ac2bfadda23ef6812933ae64510972e4.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau/disp: don't reject HDMI config on cards
 without SCDC
From: lyude@redhat.com
To: Tano Dzhinski <tano.dzhinski@gmail.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Giuseppe Ranieri <giuseppe@ranieri.dev>, David Airlie
 <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Fri, 18 Sep 2026 14:21:09 -0400
In-Reply-To: <20260917215114.1136715-1-tano.dzhinski@gmail.com>
References: <20260917135051.47683-1-tano.dzhinski@gmail.com>
 <20260917215114.1136715-1-tano.dzhinski@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8b8y20qiKzffxyZFoI-CK2vO3JptcBz7A8Rp9xJsXjI_1789755673
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

Will push to drm-misc-fixes in just a moment, thank you!

On Thu, 2026-09-17 at 21:51 +0000, Tano Dzhinski wrote:
> From: Giuseppe Ranieri <giuseppe@ranieri.dev>
>=20
> nv50_hdmi_enable() passes the sink's SCDC capability from its EDID
> straight through to nvif_outp_hdmi(). On pre-Maxwell-2 cards there is
> no
> hdmi->scdc callback, so nvkm_uoutp_mthd_hdmi() rejects the whole
> configuration with -EINVAL, and nv50_hdmi_enable() returns before
> hdmi->ctrl() runs and before the AVI and VSI infoframes are sent.
>=20
> The result on such a card driving an SCDC-capable HDMI 2.0 sink is
> that
> HDMI audio silently stops working. Video is unaffected, and nothing
> is
> logged, which makes the failure hard to attribute.
>=20
> SCDC is optional, and the hdmi->scdc() call further down is already
> guarded against a missing callback. Requesting it on a card that
> cannot
> do it need not invalidate the rest of the HDMI configuration, so drop
> that term from the condition and let the existing guard skip SCDC
> alone.
>=20
> Fixes: 6c6abab20b99 ("drm/nouveau/disp: add output hdmi config
> method")
> Signed-off-by: Giuseppe Ranieri <giuseppe@ranieri.dev>
> Co-authored-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> Signed-off-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> Tested-by: Tano Dzhinski <tano.dzhinski@gmail.com>
> ---
> v2: restore Giuseppe Ranieri's original authorship and Signed-off-by
> =C2=A0=C2=A0=C2=A0 (he posted this fix to the nouveau list on 2026-01-17,
> =C2=A0=C2=A0=C2=A0 https://ratatoskr.run/nouveau/2026/01/16963412), per L=
yude's
> =C2=A0=C2=A0=C2=A0 review of v1. Added Co-authored-by and Tested-by.
> =C2=A0=C2=A0=C2=A0 Tested on GK104 (GTX 670MX) with BenQ PD2700U and EW27=
90U.
>=20
> =C2=A0drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> index 377d0e0cef84..9887b3898505 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> @@ -253,8 +253,7 @@ nvkm_uoutp_mthd_hdmi(struct nvkm_outp *outp, void
> *argv, u32 argc)
> =C2=A0
> =C2=A0=09if (!ior->func->hdmi ||
> =C2=A0=09=C2=A0=C2=A0=C2=A0 args->v0.max_ac_packet > 0x1f ||
> -=09=C2=A0=C2=A0=C2=A0 args->v0.rekey > 0x7f ||
> -=09=C2=A0=C2=A0=C2=A0 (args->v0.scdc && !ior->func->hdmi->scdc))
> +=09=C2=A0=C2=A0=C2=A0 args->v0.rekey > 0x7f)
> =C2=A0=09=09return -EINVAL;
> =C2=A0
> =C2=A0=09if (!args->v0.enable) {

