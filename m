Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3802AC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 22:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3945E10E631;
	Fri, 21 Aug 2026 22:09:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="K+cJ1sKb";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AB9C10F3D5
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 22:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787350155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cFfIR5UhN2LkGl7j0eqOn1txdEZUB1CTMDtNAizxGGM=;
 b=K+cJ1sKbFA7dQLj+maKJfspB/3LDi4DfOy8sBkKBfQ07plUa2YlwlPhnPNaeEhlkHfa0de
 7J4Ai6kFrhR58mzOgIfNwTeX00/1XtWPhy4i+VWCSQNoMVbKW7I0xA4r0XthJ9ju4nzh6q
 NyIKOiX/RHipmcNwIz4Y3xIa+K6eCI0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-e8e8z7aFM5O1Fjwfj0-RHA-1; Fri, 21 Aug 2026 18:09:14 -0400
X-MC-Unique: e8e8z7aFM5O1Fjwfj0-RHA-1
X-Mimecast-MFC-AGG-ID: e8e8z7aFM5O1Fjwfj0-RHA_1787350153
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936d067836eso156184785a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787350153; x=1787954953;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cFfIR5UhN2LkGl7j0eqOn1txdEZUB1CTMDtNAizxGGM=;
 b=M3E2ZonU33TApwtfFBdNGOKYJ5/28VZfO6WiVzwE8TDdfYYW6lwJmu2K2lFLmrIS+r
 dWbcxD5qMLa4uEHVp4KF7kCa3SaWisDx1Axo4fHVSL6x6kMzbLVwhzyVV+JB79ofSWF9
 e7g6TylTcl1ZuQVcGqaJNv43zYOUPN1zNBl35wUWKds5NLZtm9e7dEtSOK9/l7v+ZHNv
 0MHQTnRtjCBzp6geQ0srpy0Sawjzd0KqFlSjJZD7h8VSK0EA11pWB9EVs8CKfrXE1e8A
 OcBk1wAqR0fkRL+dXvzqNi3kArfmlKu/16ILTI1tpt3T4lvk8/snBbFUMlW4DGlItD5B
 YUSw==
X-Gm-Message-State: AFuF++k9kSqZj8949L4qy3zntZJEE7FD2hPaV9zVhAXPhSbmsee8SLi/
 zPwG9XEIqtrSt5SZg2fTGpSHiMoh+R7yEPV+3zMDnTUFPn0/yt8vrv1nUCjzrP5Nyqwdu7wKS9x
 4sCVJDYfZxpsYNtlEqlAlAO7erjW5eXPgHqbFARx8fSNcYpZOeKMj1gvNL1nvLWDHDecexQ==
X-Gm-Gg: AR+sD137EzPXbXMMKzpHTjdhmiGs/Zk8mSwk/aCY5HqqFXBQVmOhyPvRxx1WTcgvuTo
 AQmivsQGGqut2GCsJJiyFor1sMaEx9w2NF/R9+7ApH1ry+vLDs5ItdygUxnvgFzC+5vFKHPmcvw
 EN+q67Ig6FbY2D61Adm10NhnntoerRv/YGiQXNg6s37gQ6RK5s1bG4tBjR1p9j1KhUjPgNmdk/G
 4nGsnw1trQhkQsPxhhXvx07XO0gavG3y1lxRLEe2zCH54DM3tngu+UyDscnogExjmzdoCmcQl2N
 ennSPkQKW1kpKiIKf84YPLF8GIGQ+Wl3x+IkCOpEinNIFeiEoRSovwYYXuzeoyEqE9BkPCpX
X-Received: by 2002:a05:620a:29cf:b0:936:4c33:67f with SMTP id
 af79cd13be357-93739540c2dmr867038085a.19.1787350153371; 
 Fri, 21 Aug 2026 15:09:13 -0700 (PDT)
X-Received: by 2002:a05:620a:29cf:b0:936:4c33:67f with SMTP id
 af79cd13be357-93739540c2dmr867031685a.19.1787350152909; 
 Fri, 21 Aug 2026 15:09:12 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93749afc53bsm8846485a.21.2026.08.21.15.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 15:09:12 -0700 (PDT)
Message-ID: <2e733db917cf5a478fe65022f4708030acab384e.camel@redhat.com>
Subject: Re: [PATCH v2 00/10] nouveau: assorted display fixes (GB20x, r570
 DP_CONFIG_STREAM, HF-EEODB EDIDs)
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, 	nouveau@lists.freedesktop.org
Date: Fri, 21 Aug 2026 18:09:11 -0400
In-Reply-To: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
References: <20260820164929.17117-1-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MJbGxKJzrIDz7XenzuDQwxazWVg_ipq00KHAy5eW4q4_1787350153
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

Thinking about it more - we should probably cc patches 1-8 to stable.
Mind doing that on the next respin?

(unsure if you have done this before or not, but
https://drm.pages.freedesktop.org/maintainer-tools/committer/getting-starte=
d.html
dim is a good tool for fixes, if you have the commit a patch fixes you
can just run `dim fixes $COMMIT` and it will spit out a tag + some CCs.
I usually drop all but the stable cc, which gets a nice little comment
added on the side indicating which kernel version to backport against.

On Thu, 2026-08-20 at 20:49 +0400, Mohamed Ahmed wrote:
> Several fixes for GSP-driven displays consisting of four independent
> groups. These were created as part of ongoing HDMI 2.1 bring up and
> display handling clean-up work, so some of them are not issues now
> (e.g., the 2.147GHz pixel clock cap) but fixing them is required to
> get
> advanced features such as FRL, DSC, VRR, etc working properly.
>=20
> The v1 review asked for the RM vs register programming split to be
> made
> explicit instead of growing more per-chip code inside the RM layer,
> so
> patches 1-3 do that first. No functional change, and then each GB20x
> fix
> (patches 4-8) supplies its hook from a new engine/disp/gb202.c.
>=20
> Changes in v2:
> - Rebased onto drm-misc-next.
>=20
> - New patches 1-3: move the GSP path's direct MMIO helpers to
> =C2=A0 engine/disp/ and route them through a per-chip nvkm_disp_func.gsp
> hook
> =C2=A0 table. GB20x now has its own gb202_disp_new() instead of display-
> class
> =C2=A0 checks in rm/r535/disp.c.
>=20
> - Patch 4 (was 1+2): merged. Dropped a stray .frl_train reference
> that
> =C2=A0 broke the build, no longer drops .scdc, and fixed an undefined
> shift
> =C2=A0 when packing byte 3 of each infoframe data word.
>=20
> - Patch 5 (was 3): the GCP subpack write is now a masked write so
> =C2=A0 SB1_CTRL keeps its hardware-controlled default.
>=20
> - Patch 6 (was 4): the vcpi hook returns its control status like the
> =C2=A0 other RM API entries instead of WARN_ONs under the HAL.
>=20
> - New patch 7: the head-state readback fix is split out. The core
> channel
> =C2=A0 state mirror uses a 0x800 per-head stride on GB20x, fixing scanout
> pos
> =C2=A0 and timings readback for heads >=3D 1.
>=20
> - Patch 8 (was 5): reworked onto the new hook table. The low-latency
> =C2=A0 vector is exposed as a second DISP interrupt instance by the r570
> =C2=A0 engine index translation and re-armed after servicing.
>=20
> - Patch 9 (was 6): the two HI methods are pushed as one method pair,
> and
> =C2=A0 the class-header defines stay offset-sorted.
>=20
> - Patch 10 (was 7): OF EDIDs now go through
> drm_edid_connector_update(),
> =C2=A0 and all firmware provided EDIDs (OF, ACPI, VBIOS embedded) are
> =C2=A0 validated with drm_edid_valid(). ACPI reads are bounded by the
> length
> =C2=A0 _DDC actually returned. Fixed a runtime-PM reference leak when the
> RM
> =C2=A0 EDID read fails. No raw struct edid is kept anymore and all the ol=
d
> =C2=A0 raw struct edid consumers are converted to the new API (the SPWG
> =C2=A0 dual-link byte is cached at EDID-set time as there is no new drm
> API
> =C2=A0 alternative for it). get_modes() re-syncs the EDID property only
> when
> =C2=A0 the probe helper cleared it.
>=20
> - Commit messages reworded throughout.
>=20
> Link to v1:
> https://lore.kernel.org/all/20260814235705.59132-1-mohamedahmedegypt2001@=
gmail.com/
>=20
>=20
> Mohamed Ahmed (10):
> =C2=A0 drm/nouveau/disp: move GSP head-timing ISR and vblank helpers to
> =C2=A0=C2=A0=C2=A0 tu102.c
> =C2=A0 drm/nouveau/disp: move the GSP HDMI GCP AVMute write to engine/dis=
p
> =C2=A0 drm/nouveau/disp: route GSP-RM display MMIO through nvkm_disp_func
> =C2=A0=C2=A0=C2=A0 hooks
> =C2=A0 drm/nouveau/disp: fix HDMI vendor infoframes on GB20x
> =C2=A0 drm/nouveau/disp: fix HDMI GCP AVMute register offsets on GB20x
> =C2=A0 drm/nouveau/gsp: use per-version DP_CONFIG_STREAM params on r570
> =C2=A0=C2=A0=C2=A0 firmware
> =C2=A0 drm/nouveau/disp: fix head state readback on GB20x
> =C2=A0 drm/nouveau/gsp: fix vblank interrupts on GB20x
> =C2=A0 drm/nouveau/dispnv50: program pixel clocks above 2.147GHz on GB20x
> =C2=A0 drm/nouveau: honor HF-EEODB EDIDs by converting to struct drm_edid
>=20
> =C2=A0drivers/gpu/drm/nouveau/dispnv04/dfp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/disp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> =C2=A0drivers/gpu/drm/nouveau/dispnv50/headca7d.c=C2=A0=C2=A0 |=C2=A0 21 =
+-
> =C2=A0.../drm/nouveau/include/nvhw/class/clca7d.h=C2=A0=C2=A0 |=C2=A0=C2=
=A0 4 +
> =C2=A0.../drm/nouveau/include/nvkm/engine/disp.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/nouveau/nouveau_acpi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 21 +-
> =C2=A0drivers/gpu/drm/nouveau/nouveau_acpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 10 +-
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.c=C2=A0=C2=A0 | 147 +++++=
+++++----
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.h=C2=A0=C2=A0 |=C2=A0 12 =
+-
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/device/base.c |=C2=A0 10 +-
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/Kbuild=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/ga102.c=C2=A0 |=C2=A0 16 +-
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/gb202.c=C2=A0 | 192
> ++++++++++++++++++
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/head.h=C2=A0=C2=A0 |=C2=A0=C2=
=A0 3 +
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/ior.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/priv.h=C2=A0=C2=A0 |=C2=A0 20 =
++
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/disp/tu102.c=C2=A0 |=C2=A0 81 +++++=
++-
> =C2=A0.../nouveau/nvkm/subdev/gsp/rm/r535/disp.c=C2=A0=C2=A0=C2=A0 | 121 =
++++++-----
> =C2=A0.../nouveau/nvkm/subdev/gsp/rm/r570/disp.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 64 ++++++
> =C2=A0.../drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c |=C2=A0=C2=A0 9 +
> =C2=A0.../nvkm/subdev/gsp/rm/r570/nvrm/disp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h=C2=A0=C2=A0 |=C2=A0=C2=
=A0 5 +
> =C2=A022 files changed, 637 insertions(+), 113 deletions(-)
> =C2=A0create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c

