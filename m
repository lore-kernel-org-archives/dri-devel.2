Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D7DC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 10:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91BC10EB6E;
	Wed, 29 Jul 2026 10:38:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="b0xMjSIZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0C7110EB6E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 10:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:Date:Cc:To:
 From:Subject:Message-ID:From:Reply-To;
 bh=CzWdkDBUO23WPA9eDnkD5lVNphAZDOuwjctA8Qh6eNE=; b=b0xMjSIZ+V8t02AIivaLXmZK5y
 rmtyvL3UFcUW+OijbX0lsrfNc5nAsJ/6llnzaPcdXz9V+Z4vFCjlp+ASDm8Q/bJHggsP/v6AKKV1+
 60zdZVtvdlcBxHJhIXkbgzUaGI3OsGPyGSfz1qrii+nOYKdIMAJFYwnwMKmTcZf4VqZdjnnzmJNd+
 9pTtBHTjBGnOjm/LbSgEsV0BhWCCuZF/vNUW//c5QJbNgOKShJz96vbVeyMXfwnYwtg2NwxC8/SUP
 yJ+a/a5MVOdh9Od9NNPatsBM7UMYkoRUcW2KwD8x65Bt/YhEgOw6jImMnhaXyA2nkUw/BCSSUeLV6
 ILg/PqFw==;
Received: from [159.147.19.205] (helo=[192.168.0.17])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wp1gW-007Rs9-0n; Wed, 29 Jul 2026 12:38:48 +0200
Message-ID: <f580c161a074eb1d30646afd24bbd4e4657c44f0.camel@igalia.com>
Subject: Re: [PATCH 0/2] drm/v3d: Fix system freezes by serializing the GPU
 reset
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org
Date: Wed, 29 Jul 2026 12:38:37 +0200
In-Reply-To: <20260728-v3d-order-global-reset-v1-0-e47be838158d@igalia.com>
References: <20260728-v3d-order-global-reset-v1-0-e47be838158d@igalia.com>
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

Good catch!

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>

El mar, 28-07-2026 a las 23:09 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> V3D exposes several independent hardware queues, but it only has a
> single,
> global reset. Therefore, when a job times out in one queue, the
> timeout
> handler has to stop, reset and restart the schedulers of every other
> queue
> as well. As each scheduler queues its timeout work on the system
> workqueue,
> those handlers run concurrently and can interfere with each other.
>=20
> This can be reproduced on a Raspberry Pi 4 or 5 by running glmark2-
> wayland,
> which keeps the CL queues busy, while a second application triggers a
> GPU
> reset in the CSD queue every 0.5 seconds. The failure is non-
> deterministic,
> but it usually shows up after a dozen resets: the DRM scheduler warns
> about
> a credit imbalance in one of the CL queues,
>=20
> =C2=A0=C2=A0=C2=A0 WARNING: CPU: 2 PID: 43 at
> drivers/gpu/drm/scheduler/sched_main.c:102
> drm_sched_run_job_work+0x238/0x4d0 [gpu_sched]
>=20
> and, from that point on, the UI freezes and the machine is unusable.
>=20
> The DRM scheduler already provides the synchronization that this kind
> of
> hardware needs: an ordered workqueue passed as drm_sched_init()'s
> @timeout_wq parameter, which guarantees that the timeout handlers of
> the
> different schedulers are executed sequentially. Patch 1 gives all of
> the
> V3D queues such a workqueue. Patch 2 removes `reset_lock`, which only
> ever covered the driver's callback and is made redundant by the
> ordered
> workqueue.
>=20
> Only patch 1 is Cc'ed to stable, in order to keep the backport
> minimal.
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> ---
> Ma=C3=ADra Canal (2):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Serialize the scheduler timeout h=
andlers
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 drm/v3d: Remove the now-redundant reset lo=
ck
>=20
> =C2=A0drivers/gpu/drm/v3d/v3d_drv.h=C2=A0=C2=A0 |=C2=A0 8 ++++----
> =C2=A0drivers/gpu/drm/v3d/v3d_gem.c=C2=A0=C2=A0 |=C2=A0 3 ---
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c | 13 ++++++++-----
> =C2=A03 files changed, 12 insertions(+), 12 deletions(-)
> ---
> base-commit: 48a570c964d8e37d353381e4195106277e17f5cb
> change-id: 20260728-v3d-order-global-reset-7736b445e0b8
>=20
>=20

