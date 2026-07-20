Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E0B4C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 22:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5536110E203;
	Mon, 20 Jul 2026 22:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="bCDho1KK";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A035310E203
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 22:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784585783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EC8yNHjTDXyuwDYD6Gak8bNS/hg5PwjNliAg5IrJPg8=;
 b=bCDho1KKfUEBEpxTjBj7iYNsX/TtUhbPZwhRXN6h5hHVujx4I0d25wlKDg5SQAReYxF1El
 3HZLf93Q1SpD0bLwJ+mq8X4ks/DN6yw8ASbEQr8f4fz+EX97C05NZ5tF3NpRHEEUSVJJFg
 VHaqG4zrzXLAzMDbcc2OveOvJlJQrfc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-6RBHSvLXOrmPE2dk--T6Nw-1; Mon, 20 Jul 2026 18:16:21 -0400
X-MC-Unique: 6RBHSvLXOrmPE2dk--T6Nw-1
X-Mimecast-MFC-AGG-ID: 6RBHSvLXOrmPE2dk--T6Nw_1784585781
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91931144870so1507336585a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:16:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784585781; x=1785190581;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EC8yNHjTDXyuwDYD6Gak8bNS/hg5PwjNliAg5IrJPg8=;
 b=Yh/jcl7SP6bxtURIM+wvzi6YK1jrFzLZHM+CaTVpHL4fDNstbbalXk1UnWO1k9B6Pe
 E7jbQT+BXCdqgyGcZoC5Dho4ijY7MXcwpZy/9Q1IeHs66r9LKfOMVYG0ZW2t4xfG21MF
 MP3oz+OrJz9wkp5ikhojeggVFJpTX1ESxV5UA0MJZUfOlUhatVd+znVGZ2zKuHVmrcfW
 VKKOJOFqS0h5i8wJVeCW1p672olv4ZRRmxYjp7gzap/CUnvC9H7eqVrP5N2KrqKxGp9i
 dQ3BpogG+p6ZoGmoyV6C+p12C9x631/b7GGYwlVH42fIfVJLidOaAZ0suztqk0zPfn0Y
 FzEg==
X-Gm-Message-State: AOJu0Yys150soD4NDnErelohkA6yrHhvruh44heUoKgZyuh1DJeZcx28
 accidFdrBQYOpjDe0FM3VskZEwBujwfnDZ88Ahs9OJueJ22cY+CDl/8QmjXhfSMXfSWNqiHsLvT
 CUC5RBJw5mzReN1gMiKY7vgHciQMLcrRQ65gKGwjLS10uTqkBBVZbPWYLoSg8q4iEseK4Rw==
X-Gm-Gg: AfdE7cnRXbm2/VM+PHJxmigJQG0C2HtwaIeRoFvNt1g8N9dYAzL7Hu673ooHLsZoGtv
 z7C3ioaM2MnD0jq61Qe06E0pq6aJuUE1V7qur7W1s9Jl9GK6DNrG4Srz+F8pN5N3oUW4Nvg/vDA
 OIx6Vmii5Df6HidPbBd8iSbylRViCKM3sPjn8DjeCLvuFo6D+4esEp19nkBpInHOOAiRQHnlWOI
 XnyAxceIlumndEPox96GKVWA1qbh7hQZ6Jdju8teZ3BBTUbC7DuiIY08nlHnTyc12Gu1v1sF7c2
 k/IrBdMpw1BgqC/80G5L8VZ7YNsjz4hQKUgFgROZMZLmcc0dJkMOECAXLHfTG23axsZ+5RXg
X-Received: by 2002:a05:620a:708a:b0:92e:fd2c:6a21 with SMTP id
 af79cd13be357-930b3ed4e6bmr1576935785a.27.1784585780743; 
 Mon, 20 Jul 2026 15:16:20 -0700 (PDT)
X-Received: by 2002:a05:620a:708a:b0:92e:fd2c:6a21 with SMTP id
 af79cd13be357-930b3ed4e6bmr1576932885a.27.1784585780256; 
 Mon, 20 Jul 2026 15:16:20 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b52fa8dfsm970105485a.11.2026.07.20.15.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 15:16:19 -0700 (PDT)
Message-ID: <147d6760338f314016bf4f5c0b33b5c5d08d9d3a.camel@redhat.com>
Subject: Re: [PATCH 0/6] drm/nouveau: GSP telemetry via RUSD, and fdinfo
 telemetry exposure
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Mary
 Guillemard <mary@mary.zone>, Milos Tijanic	 <mtijanic@nvidia.com>,
 nouveau@lists.freedesktop.org
Date: Mon, 20 Jul 2026 18:16:18 -0400
In-Reply-To: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y_iHk4au3SlOMzutRASOtqyfbol-GNaDCyxuxWLZjBY_1784585781
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

(just for other nouveau maintainers, e.g. danilo, I'm currently
planning on looking at this during this week. Already started reviewing
some of this, slightly underestimated how much I had to review :)

On Wed, 2026-07-15 at 01:14 +0400, Mohamed Ahmed wrote:
> On the GSP firmware, nouveau reports nothing about the GPU. The GSP
> owns
> the sensors, so the legacy nvkm therm/clk/volt hwmon paths never run,
> and
> monitoring tools have no data to read.
>=20
> GSP on later firmware does publish all of it through a stable
> interface.
> It maintains a shared-memory region called "RM User Shared Data"
> (RUSD),
> which the firmware fills with all the relevant sensor readings like
> power,
> temperatures, clocks, and many others. Consuming it needs only two
> internal subdevice controls: INIT_USER_SHARED_DATA to register the
> buffer,
> and SET_DATA_POLL to tell the GSP which data groups to poll and how
> often.
>=20
> This series makes nouveau a RUSD client and exposes the data through
> two
> main surfaces:
>=20
> =C2=A0 - hwmon, for the values that map onto standard channels: GPU and
> memory
> =C2=A0=C2=A0=C2=A0 temperature, GPU/board/VRAM power, power cap.=20
>=20
> =C2=A0 - sysfs, under /sys/class/drm/cardN/device/rusd/, for everything
> hwmon
> =C2=A0=C2=A0=C2=A0 has no channel type for: clocks, utilisation, pstate, =
throttle
> reason,
> =C2=A0=C2=A0=C2=A0 ECC counters, PCIe error counters, and everything expo=
sed to
> hwmon as
> =C2=A0=C2=A0=C2=A0 well. One value per file according to sysfs convention=
.
>=20
> Polling is demand-driven. GSP polls a group only while a client is
> reading
> it, and a group idles off after 10s after the last read. Polling
> costs
> power, so nothing is polled unless someone is looking. A section that
> has
> not been polled yet, or that the board does not support, reads -
> ENODATA.
>=20
> The sysfs interface is documented in
> Documentation/ABI/testing/sysfs-driver-nouveau.
>=20
> While the original scope was RUSD support only, monitoring tools
> needed
> two extra additions to complete the picture:
>=20
> =C2=A0 - VRAM size and usage on sysfs (patch 5): since this series adds a
> sysfs
> =C2=A0=C2=A0=C2=A0 interface for nouveau, it's better to expose VRAM metr=
ics there
> rather
> =C2=A0=C2=A0=C2=A0 than force monitoring apps to pull in libdrm for the G=
ETPARAM
> memory
> =C2=A0=C2=A0=C2=A0 ioctls.
>=20
> =C2=A0 - fdinfo (patch 6): nouveau implemented none at all, and monitorin=
g
> apps
> =C2=A0=C2=A0=C2=A0 could not show per-process GPU and memory usage. It no=
w reports
> =C2=A0=C2=A0=C2=A0 per-client memory and per-engine busy time, accounted =
from the
> DRM
> =C2=A0=C2=A0=C2=A0 scheduler that the EXEC/VM_BIND path already uses.
>=20
> Limitations, caveats, and additional considerations or questions:
>=20
> =C2=A0 - RUSD needs r570 or newer GSP firmware; r535 does not have the
> needed
> =C2=A0=C2=A0=C2=A0 controls. Pre-GSP and r535 behavior is identical to wh=
at it was:
> the
> =C2=A0=C2=A0=C2=A0 rusd/ group is not created, and hwmon keeps its curren=
t behavior.
>=20
> =C2=A0 - This is all read-only telemetry. Clock, voltage, or power contro=
l
> is
> =C2=A0=C2=A0=C2=A0 through other interfaces out of scope of this series.
>=20
> =C2=A0 - The sysfs interface exposed here should be stable and valid for
> nova
> =C2=A0=C2=A0=C2=A0 as well. RUSD is stable and only grows more fields wit=
h newer GSP
> =C2=A0=C2=A0=C2=A0 firmware (e.g., fan telemetry gets added in r580), so =
it is
> possible
> =C2=A0=C2=A0=C2=A0 to keep the same interface as we use newer firmware or=
 as we move
> to
> =C2=A0=C2=A0=C2=A0 nova and any potential considerations should be ironed=
 out before
> this
> =C2=A0=C2=A0=C2=A0 gets merged and the interface gets frozen.
>=20
> =C2=A0 - amdgpu offers a single binary blob with all the telemetry
> embedded in
> =C2=A0=C2=A0=C2=A0 addition to the sysfs sensor files. This series curren=
tly only
> exposes
> =C2=A0=C2=A0=C2=A0 sensor files, but it is possible to add a similar bina=
ry for a
> v2.
> =C2=A0=C2=A0=C2=A0 This mainly offers a more efficient way to read the te=
lemetry as
> =C2=A0=C2=A0=C2=A0 clients would read only a few files instead of reading=
 all of
> them.
>=20
> =C2=A0 - The last two patches don't depend on RUSD and work on every GPU.
> But
> =C2=A0=C2=A0=C2=A0 they are here because they complete the sensor telemet=
ry story. I
> am
> =C2=A0=C2=A0=C2=A0 happy to split them into their own series if that is p=
referred.
>=20
> Userspace WIP work built on this sysfs surface exists in form of
> nouveau
> backends for nvtop, LACT, and a NVK HUD:
>=20
> =C2=A0 - nvtop: https://github.com/mohamexiety/nvtop/tree/nvtop-nouvtop
>=20
> =C2=A0 - LACT: https://github.com/mohamexiety/LACT/tree/lnouvct
>=20
> =C2=A0 - NVK HUD:
> =C2=A0=C2=A0=C2=A0 https://gitlab.freedesktop.org/mesa/mesa/-/merge_reque=
sts/39898
>=20
> None of these are merged yet and exist for testing only. Upstreaming
> will
> begin when this series gets merged and the interface is stable.
>=20
> Mohamed Ahmed (6):
> =C2=A0 drm/nouveau/gsp: vendor the RUSD header
> =C2=A0 drm/nouveau/gsp: add RUSD telemetry support
> =C2=A0 drm/nouveau: add GSP hwmon support
> =C2=A0 drm/nouveau: expose RUSD telemetry via sysfs
> =C2=A0 drm/nouveau: expose global VRAM size and usage via sysfs
> =C2=A0 drm/nouveau: expose per-client GPU usage via fdinfo
>=20
> =C2=A0.../ABI/testing/sysfs-driver-nouveau=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 167 ++++++
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/nouveau/Kbuild=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../gpu/drm/nouveau/include/nvkm/subdev/gsp.h |=C2=A0 33 ++
> =C2=A0.../drm/nouveau/include/nvkm/subdev/rusd.h=C2=A0=C2=A0=C2=A0 | 114 =
++++
> =C2=A0.../gpu/drm/nouveau/include/nvrm/nvtypes.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 3 +
> =C2=A0drivers/gpu/drm/nouveau/nouveau_abi16.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 16 +
> =C2=A0drivers/gpu/drm/nouveau/nouveau_chan.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/gpu/drm/nouveau/nouveau_drm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 22 +
> =C2=A0drivers/gpu/drm/nouveau/nouveau_drv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 29 +
> =C2=A0drivers/gpu/drm/nouveau/nouveau_exec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0drivers/gpu/drm/nouveau/nouveau_gem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +
> =C2=A0drivers/gpu/drm/nouveau/nouveau_hwmon.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 375 ++++++++++---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_sched.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 87 +++
> =C2=A0drivers/gpu/drm/nouveau/nouveau_sched.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 11 +
> =C2=A0drivers/gpu/drm/nouveau/nouveau_sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 311 ++++++++++
> =C2=A0drivers/gpu/drm/nouveau/nouveau_sysfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 10 +
> =C2=A0.../drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c |=C2=A0 26 +
> =C2=A0.../drm/nouveau/nvkm/subdev/gsp/rm/r535/rm.c=C2=A0 |=C2=A0=C2=A0 1 =
+
> =C2=A0.../nouveau/nvkm/subdev/gsp/rm/r570/Kbuild=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
> =C2=A0.../nvkm/subdev/gsp/rm/r570/nvrm/rusd.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 303 ++++++++++
> =C2=A0.../drm/nouveau/nvkm/subdev/gsp/rm/r570/rm.c=C2=A0 |=C2=A0=C2=A0 1 =
+
> =C2=A0.../nouveau/nvkm/subdev/gsp/rm/r570/rusd.c=C2=A0=C2=A0=C2=A0 | 531
> ++++++++++++++++++
> =C2=A0.../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h=C2=A0=C2=A0 |=C2=A0=C2=
=A0 7 +
> =C2=A024 files changed, 1990 insertions(+), 81 deletions(-)
> =C2=A0create mode 100644 Documentation/ABI/testing/sysfs-driver-nouveau
> =C2=A0create mode 100644
> drivers/gpu/drm/nouveau/include/nvkm/subdev/rusd.h
> =C2=A0create mode 100644 drivers/gpu/drm/nouveau/nouveau_sysfs.c
> =C2=A0create mode 100644 drivers/gpu/drm/nouveau/nouveau_sysfs.h
> =C2=A0create mode 100644
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/rusd.h
> =C2=A0create mode 100644
> drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/rusd.c

