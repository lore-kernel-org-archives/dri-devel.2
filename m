Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7BCC5DF7D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8DA510E8E0;
	Wed, 19 Aug 2026 00:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Hz8RVHAz";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1324D10E8E0
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 00:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787097733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gUqJG69YbmkVqa7BJeUUv+0NNdL/7u3t7EUGaMdcZdg=;
 b=Hz8RVHAzOqEdetfDG4N4ZHy//tpZIzGf7ff/0kONMkpL6YHgW952yjjotY3BDIxVhuj3gT
 HouMaEczZ9x8p8uXUWtNX/mwLYV9y9B/CbbU2VmsDJIAmjg0PXRdcmu5aNWx8ADj4LsYBt
 KnMPgz7+1LaMiKR+cjH5Uet2aU2oa58=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-YCkVhTkpM2C3PEU_UGg-ZA-1; Tue, 18 Aug 2026 20:02:11 -0400
X-MC-Unique: YCkVhTkpM2C3PEU_UGg-ZA-1
X-Mimecast-MFC-AGG-ID: YCkVhTkpM2C3PEU_UGg-ZA_1787097731
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so38430385a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 17:02:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097731; x=1787702531;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gUqJG69YbmkVqa7BJeUUv+0NNdL/7u3t7EUGaMdcZdg=;
 b=RAaZJWdZDNq5epfJQ8obW50kanh07AQRRWCcc2ebJuBu9k0IzefMkbOi7sm6m34K24
 v1a9GLIhE4fAPHbshlcpqt/nSgBuraV63x7OYq5jx0EU8tisdYPNviVYPMB60NSdDiyM
 nrMbvFbRVvZz6FXV7uDM14WRa4Bo538AvD+gHAnJfUzxF67RzNEHJAxAQcSvStpgc30g
 l24AkesB3qQNPmWz4CZpo5CHNgbWbp26ki7xgiTgwLtpMEFWBG6EictF6BSKX1kw0kGB
 joLYyc1fA8XXVRYZY57N+TMCW50toDUmbmSDhf9ViIxutOP6rFXKkEtAGGCafdyl6ZrR
 HwFg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq3/VHDmk2fyztZLBzbObPvULMWO1Tn5DAqm4LuWnR1TwyJLZQ0weRnypoUWknFF7MH17g4onv66ts=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+AjzNu5Ivm7el45O389X8hJ7XCY97dR8/cBuGFJoltXCT/h2r
 qK9e1wIeKQ4Ai1h3UUSvGo/npPOZQZ9hZzOT/0VYbJW4k4kFHK6xFpsQvFssKsqM0ygs6jIDoQS
 y3O8f1M54zpNN46oknui4BCaWVKogoAGEmgFlydYOBC7LMvm/rJKyIpevUlIf2xMv1tSPvQ==
X-Gm-Gg: AR+sD13KdJljzyrMLMO2HDJOaK+URGMm56hrarEfQ9vq38y5+PSx/iqod9mW6TSd6WD
 49fVG35LW6D0huyi5rJi47gPNcKx9lBcDxHvBAY5q9E7AcMmyV0jeY5U7VKKVGMmqccjyWYkiU8
 AfALP65msr/Gh66ZH9bNzFJVJT/MZKCrX84HTazKdCmVxJP4YlNGWrXI1bk7OwM0xdlU0szJ1cz
 gp3gEGjKB1lJ3pX4AAcEVGMSTUNbzgVLpE1Z+rwwrNTs6C9S5uW/XdC3nNIkDFxkSm5Ji6zTs5O
 4pWj+PztUgiet5IRNpXW+4uOpJKoVU1cWgGlBGXTD5Inyg/bbvOV1MigEWEHRS25TRooeldW
X-Received: by 2002:a05:620a:2986:b0:936:9253:897a with SMTP id
 af79cd13be357-9371e430b4cmr101027585a.9.1787097731236; 
 Tue, 18 Aug 2026 17:02:11 -0700 (PDT)
X-Received: by 2002:a05:620a:2986:b0:936:9253:897a with SMTP id
 af79cd13be357-9371e430b4cmr101019085a.9.1787097730662; 
 Tue, 18 Aug 2026 17:02:10 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9372059ae63sm12749885a.46.2026.08.18.17.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 17:02:09 -0700 (PDT)
Message-ID: <6244a95cc925d8b0f3c01ac000ca56dad246305b.camel@redhat.com>
Subject: Re: [PATCH v4 0/2] drm/nouveau: NVAC (MCP79) stability: MSI rearm
 and a NULL crtc guard
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Date: Tue, 18 Aug 2026 20:02:08 -0400
In-Reply-To: <178688574400.522643.6695278742335367229@gmail.com>
References: <178688574400.522643.6695278742335367229@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E24lQK3WnevAlyoMGWEpviQgsK0DTtc-fzF38tt5yWs_1787097731
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

First patch looks fine, I sent a new patch series to address the issue
pointed out by patch 2, as it was a bit of a bandaid around a larger
issue.

Will push the first patch in just a moment

On Sun, 2026-08-16 at 15:09 +0200, Marek Czernohous wrote:
> From: Marek Czernohous <marek@czernohous.de>
>=20
> This is v4 of two NVAC (MCP79) stability fixes.=C2=A0 v3 went out on 11
> June
> and has had no replies:
>=20
> =C2=A0
> https://lore.kernel.org/all/20260611124535.527275-1-mczernohous@gmail.com=
/
>=20
> Nothing in either patch changed.=C2=A0 Same diffs, same reasoning, same
> trailers.=C2=A0 The reason this is a v4 and not a ping is that 2/2 no
> longer
> applies to mainline, so a ping would have pointed at a series nobody
> can
> test.
>=20
> What moved was somebody else's context, not this code.
> Commit 5164f7e7ff8e ("drm: Rename struct drm_atomic_state to
> drm_atomic_commit") changed the callback signature, so
> nv50_sor_atomic_disable() now takes a struct drm_atomic_commit
> *state.
> 2/2 is rebased onto that by hand.=C2=A0 1/2 applies unchanged and is
> byte-identical to v3.
>=20
> Both bugs are still live in c21bb4193868.=C2=A0 dispnv50/disp.c:1568 stil=
l
> does nv50_head(nv_encoder->crtc) with no NULL check, and there is no
> guard anywhere in the function.=C2=A0 Immediately below it, :1570 takes
> nv50_outp_get_old_connector() and :1572 dereferences the result
> without
> checking it.
>=20
> 1/2 drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)
>=20
> =C2=A0=C2=A0=C2=A0 NVAC re-arms MSI through the MMIO mirror of PCI config=
 space,
> which
> =C2=A0=C2=A0=C2=A0 is unreliable on this IGP.=C2=A0 A missed re-arm leave=
s the interrupt
> =C2=A0=C2=A0=C2=A0 line dead, submission times out and the GPU looks hung=
 until
> =C2=A0=C2=A0=C2=A0 reboot.=C2=A0 Give NVAC its own pci func that re-arms =
through real
> =C2=A0=C2=A0=C2=A0 config space, the way commit 5112abc6a433 ("drm/nouvea=
u/pci/g92:
> =C2=A0=C2=A0=C2=A0 Fix rearm") already did for g92.=C2=A0 Only NVAC is sw=
itched, because
> =C2=A0=C2=A0=C2=A0 that is the part this was validated on.
>=20
> 2/2 drm/nouveau/kms: guard NULL crtc in nv50_sor_atomic_disable()
>=20
> =C2=A0=C2=A0=C2=A0 Restore the NULL check that
> =C2=A0=C2=A0=C2=A0 commit f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove
> =C2=A0=C2=A0=C2=A0 (nv_encoder->crtc) checks in ->disable callbacks") rem=
oved, as a
> =C2=A0=C2=A0=C2=A0 drm_WARN_ON_ONCE() rather than a silent return, since =
a NULL crtc
> =C2=A0=C2=A0=C2=A0 here is a state-tracking inconsistency worth seeing.=
=C2=A0 The guard
> is
> =C2=A0=C2=A0=C2=A0 hoisted above the backlight teardown so the old connec=
tor is only
> =C2=A0=C2=A0=C2=A0 used after it has been checked; without that the oops =
would just
> =C2=A0=C2=A0=C2=A0 move a few lines down.
>=20
> Testing.=C2=A0 The MSI change continues to run here on the Mac mini as a
> daily driver, and Fab Stz confirmed it independently on an iMac9,1.
> Both Tested-by tags are carried over unchanged from v3; the
> diffs they were given are the diffs sent here, apart from the
> mechanical
> rebase of 2/2.=C2=A0 For v4 I rebuilt 2/2 with
> CONFIG_DRM_NOUVEAU_BACKLIGHT
> set to y and to n, because the patch splits the #ifdef block in two
> and
> that is where a change of this shape tends to break.
>=20
> If something about the shape of the series is what is holding it up,
> I
> would rather hear that than keep rebasing it.
>=20
> Marek Czernohous (2):
> =C2=A0 drm/nouveau/pci: use config-space MSI rearm on MCP79/MCP7A (NVAC)
> =C2=A0 drm/nouveau/kms: guard NULL crtc in nv50_sor_atomic_disable()
>=20
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/disp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 30 +++++++++++++---
> =C2=A0.../gpu/drm/nouveau/include/nvkm/subdev/pci.h |=C2=A0 1 +
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/device/base.c |=C2=A0 2 +-
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/pci/Kbuild=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c=C2=A0=C2=A0 | 35
> +++++++++++++++++++
> =C2=A05 files changed, 63 insertions(+), 6 deletions(-)
> =C2=A0create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/pci/mcp79.c
>=20
>=20
> base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86

