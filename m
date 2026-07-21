Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD07C4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8233810EB3F;
	Tue, 21 Jul 2026 20:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="TVBywImP";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D28D10E3CA
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784666449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXgX0uNO+WJdsVZ7unE8kmr92+eVG9rapgaFoCHjavU=;
 b=TVBywImPc3+4ycBFbFFq0V7THQWAfUQEhZWvv7CxXAgSrxmqXWfXMgrpdvSRBSbXfyODOg
 Gj/RNns0qA4u8vQndnhP+g+ug3wTQb9fPLr+Gs11/l5eDP3D/ZegQFoJMuOcV+tIDxN9wJ
 Y6L5CK/zj0P9sCOR6BsbPR0uDHdefTk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-Ia5QQsHQMiSpYnILjLZ4SQ-1; Tue, 21 Jul 2026 16:40:46 -0400
X-MC-Unique: Ia5QQsHQMiSpYnILjLZ4SQ-1
X-Mimecast-MFC-AGG-ID: Ia5QQsHQMiSpYnILjLZ4SQ_1784666446
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so319393041cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784666446; x=1785271246;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gXgX0uNO+WJdsVZ7unE8kmr92+eVG9rapgaFoCHjavU=;
 b=iEAgXxx6PDGX9NzMlQuGAShCBMl6imVN6i4tHY8YsPTr+SL16wmAiUkCmr+zYdNjW/
 kB4nv9O68SIrOVEBQyAWVqJnUDCz6it3BWYM89CcLYesco7Idd8GnWh1xvr6nbQqlHLm
 ZdjJ/jH5rn4h6k/oAt5ly9cYJ6ysn/6kOiHj6xDPWisiPJoGKPvLqyI8URQjxFWWgdLe
 ugP5ItXYhkI2wMRHVTF7D532Ic72sEaE0ictHFIIy2wjWM89YN/NcOVaqJUPBWzbEahT
 qERVF3dvCRN2jek/g9Sq8jYpKMZymlLE7ejOnLIhJXK5xvJUQn8sXVrMXerT6uN0K6rg
 oL6g==
X-Gm-Message-State: AOJu0YyPPqK7lAH2BRJr1V9DzhhqUeHw9JqdRW//m0AwU5yttUMr/T/K
 CAdelnQPe/8Q8ffYoewL+DZG4Mjp0RmWmsUETdJe3dDb+s7cNct2BmeR5hqAV4KTSliQEwfE98r
 Tl8FZhxSTcNZ3RgPUNzkKD5VM3JMDow98lE2hcukJ26PG1BlTrrJAaPkc/Hz77fFXfhocoQ==
X-Gm-Gg: AfdE7clMJ1X98n15u1xbx33/JeL3YdrhA+CqQhv+o1YFju0USohpGB/ncPzYjWhOU6A
 Bm7QEHUqkqq/+BZlHKJsC8JdctBC1D1v17TyW4FwPiJzTXVBXrliLI90qr5ddy5QNS+jAs9/S7h
 1tPNqK4ZVXjvLt36/jEgw1dFKqYkdx7tZ13+7kUI2Gt/8pWJ67iT/9L0K1BmvDLOtRMvOMtDkln
 VYLI1wMr3IoCzzM29LjkVygeTJzAxz02R8t6dMHS9rZ9EJoVVbWwVcI54mrgjDx/EVM92gQ6iVq
 svQqtnKWhEC/xymaiwwsrdoJ3dD5HpaaMsiQc3kWKSz7gwnje2mfC1ksjBfCKpliPvTjJwoR
X-Received: by 2002:a05:622a:1e11:b0:51c:88b:d7e3 with SMTP id
 d75a77b69052e-5213c8e3864mr187389101cf.3.1784666445664; 
 Tue, 21 Jul 2026 13:40:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1e11:b0:51c:88b:d7e3 with SMTP id
 d75a77b69052e-5213c8e3864mr187388891cf.3.1784666445181; 
 Tue, 21 Jul 2026 13:40:45 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba9e19f6sm4502016d6.27.2026.07.21.13.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:40:44 -0700 (PDT)
Message-ID: <d17afcac57059fc5effc786321ac43cc6d0b2c30.camel@redhat.com>
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
Date: Tue, 21 Jul 2026 16:40:43 -0400
In-Reply-To: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: M4XFLBVHEBC1Gd0Lovdc89oFprBPwdq-WqDZlyphgAc_1784666446
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

With the various nits addressed or responded to, for the whole series:

Reviewed-by: Lyude Paul <lyude@redhat.com>

(I assume with you moving stuff into nvkm I might need to re-review
later, but that's fine with me)

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

