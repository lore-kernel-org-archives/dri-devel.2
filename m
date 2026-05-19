Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666BECD4F54
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 22:02:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6961A10EE8D;
	Tue, 19 May 2026 22:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="S0UyVQbv";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0490610E3F4
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779228117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yX/FeS6p1ggTWK2cFLIbTmgp46Xg7x9+qqW6hrD7F0s=;
 b=S0UyVQbvnO0VnPchUYjaOQOf+4iy7mEbqjr+3HV/Tlz4oTI6wW1Y1lwhcU6pzAmDYfWFXZ
 3nespU/pEhna1vowsGFONSz+YyxA86EJrpvlyryoT8cjD/GrvJMkapow2dZ9UaUZI6m1Mn
 i7lY0vh578m1nRc7sbhQCyigyVGo4e8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-3FwTPqhtO8qzIqRrV8fAiQ-1; Tue, 19 May 2026 18:01:55 -0400
X-MC-Unique: 3FwTPqhtO8qzIqRrV8fAiQ-1
X-Mimecast-MFC-AGG-ID: 3FwTPqhtO8qzIqRrV8fAiQ_1779228112
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-90d6fe98316so968853885a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 15:01:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779228112; x=1779832912;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yX/FeS6p1ggTWK2cFLIbTmgp46Xg7x9+qqW6hrD7F0s=;
 b=OADYtjRAbVFA7gcvaRgYEpD5tXLqrEcLxgx7RB6S7gDS6t+ItaVm+Iayf7lCmu85Z9
 IrGvNHtFxelXJgfyONlDR98sRFi5s92c5baag2eEzanHV8WUKC9x0zHBGkl+Jfy3qqLQ
 aPvmAorlyUMydhD09GGvrFSBCCRzcZj7z2/dvfmp7HhX7dj4dDMBUE/p9fgmjY0pg8Zl
 tMCTBWrBNwCbpQTfnuMOhrxfdvvEMdz2KAC16bMOyU4Zf7Vr5kgJiI0JyI8DekHoEEe+
 wWTXzzDNzsGXcN2Ex340zX9gbASvHYP3JEMD31Zue8GUDSY1DupNA239fBc1fqyTVcDH
 MdQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ArMgDgk5Y7apsRfCFFgBEJe5pK9fklBmQb3QPVTysBQ2OlABQPObQEFOyuwQxG67fIaXwL90HltM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIbikWO6BsETUJa5pGIb83ljHW2szMyiOIumn8j6vdLXlK+CFC
 s60pTd/6e974vO0Jrd1pWe46CsnVrMvH6lVSQaX2burqmi/YcG4Lnj3aPc/23qs+gbL5ZcZKw/f
 LNGsNk6LPihOGrc5tFNC3x4+6FnIvjLpmCxsFFnuMKe3Z0RzGVfDgVVAAkgS7tlOfYg4AMA==
X-Gm-Gg: Acq92OHF5Uc4wsYLHqvRkW/K3gsJ3jOyW0/Ec4OiNM1PPmBeVA772Iti5X5qFjRUfZb
 TRLsrwDsqb6vkiN9eBMhksrSnhzNPJH630RU5ZJDGJB0Si5XFuC2OZfp4Zk2SpwenG037cuyhMA
 dQc6OU/pfYzhtyhrslBxCNTe8noeOVGnFtG+4I6muDXNxp6tCJLpHdAIYFbCvJtRbGqZsbmKPOa
 5y9caoEM2RnmAjDZKlDzCyaE77D/cZBAiFDKMLFnYPFHzbd8RH9jPLk+aG6yjPMOA7nft4M0CTN
 oRvBuC2/xLbfJWrQ9RbGGnY4H3X+YxmJ3HNyoCMuxATpNZ2Hue2XrJlsXfCGweOjHEaBdW+7lvQ
 PvrVqpX2PHJ3CTAkgMg==
X-Received: by 2002:a05:620a:170c:b0:910:5637:4bec with SMTP id
 af79cd13be357-911cd1752admr3279951385a.18.1779228108221; 
 Tue, 19 May 2026 15:01:48 -0700 (PDT)
X-Received: by 2002:a05:620a:170c:b0:910:5637:4bec with SMTP id
 af79cd13be357-911cd1752admr3279853985a.18.1779228095704; 
 Tue, 19 May 2026 15:01:35 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910ba36d137sm1948054085a.1.2026.05.19.15.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 15:01:34 -0700 (PDT)
Message-ID: <4037b4a4c1768f5f28c7ae1c5dfb2913e675d6ab.camel@redhat.com>
Subject: Re: [PATCH 0/2] drm/nouveau: nv04 FIFO cleanup + recovery for Tesla
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org
Cc: Danilo Krummrich <dakr@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Marek Czernohous <marek@czernohous.de>
Date: Tue, 19 May 2026 18:01:34 -0400
In-Reply-To: <20260513175014.96599-1-marek@czernohous.de>
References: <20260513175014.96599-1-marek@czernohous.de>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TkTxL-rWaZtF41TSrDx88URUwB1A1CLQGuraM06dpLM_1779228112
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

Hey! I truly apologize for asking, and thank you tremendously in
advance if the answer is no. But I had to check since I haven't seen
you around before, and these are unusually long commit messages:

These patches were written by a person correct? If not, you need to
follow the coding assistants guidelines here:

https://docs.kernel.org/process/coding-assistants.html

On Wed, 2026-05-13 at 19:50 +0200, Marek Czernohous wrote:
> Hi all,
>=20
> Two-patch series for the legacy nv04_fifo path covering Tesla
> (MCP77/MCP79 and G80-GT218). Daily-driven on the reference NVAC
> hardware (Apple Mac mini Late 2009, GeForce 9400M) since 2026-05-05.
>=20
> Patch 1 demotes a benign CACHE_ERROR that fires once per Mesa session
> start on Tesla GPUs. The Mesa NV50 userspace driver issues a method-
> 0x0060 / data-0xbeef02xx binding probe that recovers cleanly via
> nv04_fifo_swmthd(), but currently logs at error level on every X or
> Wayland session, dominating dmesg noise on this hardware class. This
> clears the channel for patch 2 to identify real faults from noise.
>=20
> Patch 2 adds a two-tier fault-recovery path for Tesla FIFO faults:
>=20
> =C2=A0 Tier 1 (per fault). Look up the channel via nvkm_chan_get_chid,
> =C2=A0 call nvkm_chan_error(chan, true), fire tracepoint
> =C2=A0 nouveau:fifo_chan_killed. Idempotent through the existing
> =C2=A0 chan->errored short-circuit.
>=20
> =C2=A0 Tier 2 (sliding window). When the per-fifo fault count in a
> =C2=A0 configurable window reaches the threshold, schedule a worker that
> =C2=A0 calls drm_dev_wedged_event(drm, DRM_WEDGE_RECOVERY_REBIND, NULL)
> =C2=A0 and fires tracepoint nouveau:fifo_dev_wedged. Worker context is
> =C2=A0 needed because kobject_uevent_env may sleep.
>=20
> Motivation: Fermi+ gets channel-kill and device-wedge automatically
> through nvkm_runl_rc; Tesla was feature-frozen before the DRM wedge
> uAPI existed. Three observable consequences on the reference
> hardware:
>=20
> =C2=A0 1. Silent state corruption (channel produces wrong output after a
> =C2=A0=C2=A0=C2=A0=C2=A0 fault, no notice to userspace).
> =C2=A0 2. Observability gap (no counters, tracepoints, or wedge event,
> =C2=A0=C2=A0=C2=A0=C2=A0 only dmesg).
> =C2=A0 3. Repeated-fault loop (the log-and-reset cycle repeats forever on
> =C2=A0=C2=A0=C2=A0=C2=A0 a persistently faulting channel instead of killi=
ng it).
>=20
> Validation. A debugfs fault-injector (kept on a separate
> DO-NOT-MERGE branch, not part of this submission) was used to drive
> both Tier-1 and Tier-2 paths through their full state space. Phases
> 1-5 of the test plan were exercised that way. Phase 6 (no manual
> injection, real workload soak) ran 2026-05-05 through 2026-05-13:
> one organic DRM_WEDGE_RECOVERY_REBIND event was captured on
> 2026-05-05 09:08; the rest of the soak was fault-free.
>=20
> Companion userland tool nouveau-pstate-daemon v0.2.0 [1] subscribes
> to the WEDGED=3Drebind uevent in log-only mode and was used to confirm
> end-to-end propagation through udev.
>=20
> Module parameters:
>=20
> =C2=A0 nouveau.fifo_wedge_count=C2=A0=C2=A0=C2=A0=C2=A0 (uint, 0..32, def=
ault 10)
> =C2=A0 nouveau.fifo_wedge_window_ms (uint, 100..600000, default 60000)
>=20
> Setting fifo_wedge_count=3D0 disables Tier-2 entirely while keeping
> Tier-1 channel-kill active.
>=20
> A note on MAINTAINERS. The series adds a new file
> drivers/gpu/drm/nouveau/nvkm/engine/fifo/recover.c. The change is
> covered by the existing nouveau MAINTAINERS section
> (drivers/gpu/drm/nouveau/), so no MAINTAINERS update is included.
> checkpatch.pl flags this as a hint; it is not load-bearing.
>=20
> This is a follow-up to the April 9 NVAC stability series [2], which
> is still awaiting review. The two patches here are independent of
> that series and apply against current Linus master.
>=20
> [1] https://github.com/hibbes/nouveau-pstate-daemon=C2=A0(v0.2.0)
> [2]
> https://lore.kernel.org/dri-devel/20260409-nouveau-nvac-stability-series
>=20
> Marek Czernohous (2):
> =C2=A0 drm/nouveau/fifo/nv04: filter benign CACHE_ERROR from Mesa NV50
> bind
> =C2=A0=C2=A0=C2=A0 probe
> =C2=A0 drm/nouveau/fifo: add recovery path for Tesla
> cache_error/dma_pusher
>=20
> =C2=A0.../drm/nouveau/include/nvkm/engine/fifo.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 12 ++
> =C2=A0.../include/trace/events/nouveau_fifo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 58 +++++++++
> =C2=A0drivers/gpu/drm/nouveau/nouveau_drm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 29 +++++
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/fifo/Kbuild=C2=A0=C2=A0 |=C2=A0=C2=
=A0 1 +
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/fifo/base.c=C2=A0=C2=A0 |=C2=A0=C2=
=A0 3 +
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/fifo/nv04.c=C2=A0=C2=A0 |=C2=A0 29 =
++++-
> =C2=A0.../gpu/drm/nouveau/nvkm/engine/fifo/priv.h=C2=A0=C2=A0 |=C2=A0 10 =
++
> =C2=A0.../drm/nouveau/nvkm/engine/fifo/recover.c=C2=A0=C2=A0=C2=A0 | 121
> ++++++++++++++++++
> =C2=A08 files changed, 257 insertions(+), 6 deletions(-)
> =C2=A0create mode 100644
> drivers/gpu/drm/nouveau/include/trace/events/nouveau_fifo.h
> =C2=A0create mode 100644
> drivers/gpu/drm/nouveau/nvkm/engine/fifo/recover.c
>=20
>=20
> base-commit: 1f63dd8ca0dc05a8272bb8155f643c691d29bb11

