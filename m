Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16BDC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 07:11:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63C110E447;
	Tue, 22 Sep 2026 07:11:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cIrAwURH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E866610E447
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 07:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=N1RMjuCYShKvsW38p3ZwjiVkJFslUoUykUgeboZtKgg=; b=cIrAwURHbEd/mfJI3J1ClpnQdp
 KeQTsUQSam5J+BMBGcIBY8IhCzOB1tmbQtAA4jOaudZCZTU9bGSEnqVlOseAN3kj4rv/UTEltPGXc
 V4K8l/w8FcPc40hUCXfOBQciHazHfFC5XuuC4th4e7zhZr7F7vquKH8JKrb3mq/s/pgimpbMGmw2n
 9aMSpIBLlcte6iB2GZoU1lMo4eNZZ59Bb6YiKRQ5N1k83rDVy7q5YJUpAkAAQlb3LeuLjtR3CA5an
 6S9Q+Y5lgh8qqLL0NiKCBpe7jIF9CgV9zzh6ktdaLMduqD75o8ihdrW0Y5IwgAmYR6eUd7Umvk+sf
 lyfUA5DA==;
Received: from [159.147.214.108] (helo=[192.168.0.17])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x8uf5-005UGj-61; Tue, 22 Sep 2026 09:11:30 +0200
Message-ID: <7cfcb7c8fdcb032cc582b1319f4b6334a5c3da1a.camel@igalia.com>
Subject: Re: [PATCH 0/2] drm/v3d: Skip perfmon serialization when it cannot
 be observed
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Tue, 22 Sep 2026 09:11:20 +0200
In-Reply-To: <20260921-v3d-quick-exit-perfmon-serialize-v1-0-e58aea1075e2@igalia.com>
References: <20260921-v3d-quick-exit-perfmon-serialize-v1-0-e58aea1075e2@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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

Hi Ma=C3=ADra,

this looks good to me. I suggested to amend the docs for last_hw_fence
to make more explicit how this MR affects it. Otherwise this is:

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>=20

El lun, 21-09-2026 a las 18:24 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> The V3D core has a single set of performance counters. So that a
> perfmon
> only counts the jobs it is attached to, a job carrying a non-global
> perfmon waits for every job still in flight, and while it is in
> flight
> every later job waits for it. Knowing what is in flight requires
> every
> job to merge its finished fence into a per-queue accumulator.
>=20
> That accumulator is maintained unconditionally, so a client pays a
> fence
> merge on every job even when no dependency can ever be built out of
> it.
> This series turns the bookkeeping off in the two cases where that
> holds:
>=20
> =C2=A0 1. No perfmon is alive on the device, which is the common case
> since
> =C2=A0=C2=A0=C2=A0=C2=A0 perfmons only exist while userspace runs a perfo=
rmance query;
>=20
> =C2=A0 2. A global perfmon is set and the job carries no perfmon of its
> own.
> =C2=A0=C2=A0=C2=A0=C2=A0 A global perfmon counts concurrent activity from=
 every job, so
> =C2=A0=C2=A0=C2=A0=C2=A0 nothing has to wait. Jobs carrying their own per=
fmon stay
> tracked,
> =C2=A0=C2=A0=C2=A0=C2=A0 since the global perfmon may be cleared before t=
hey run and only
> =C2=A0=C2=A0=C2=A0=C2=A0 one of them can be programmed in the HW at a tim=
e.
>=20
> Both share the same trade-off: a job that goes unrecorded never
> carries a
> perfmon, so the only cost is that the first job measured after
> tracking
> resumes may overlap it. Considering the use cases of performance
> monitors
> and that it will only affect the first job, it's a reasonable
> compromise
> to make for the average case.
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> ---
> Ma=C3=ADra Canal (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Skip perfmon serialization while =
the device has no
> perfmon
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Skip perfmon serialization while =
a global perfmon is
> set
>=20
> =C2=A0drivers/gpu/drm/v3d/v3d_drv.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++=
++++
> =C2=A0drivers/gpu/drm/v3d/v3d_perfmon.c |=C2=A0 8 ++++++--
> =C2=A0drivers/gpu/drm/v3d/v3d_submit.c=C2=A0 | 19 ++++++++++++-------
> =C2=A03 files changed, 25 insertions(+), 9 deletions(-)
> ---
> base-commit: 402491eefc5ea9a40e19b08dccf0c045aec4efc2
> change-id: 20260921-v3d-quick-exit-perfmon-serialize-9e9e8ceac587
>=20
>=20

