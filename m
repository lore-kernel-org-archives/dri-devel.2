Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5857C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC18810EFE2;
	Mon, 14 Sep 2026 16:11:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ToHrbJEE";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 118B610EFE3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 16:11:55 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hk9Bw0QDVzKmJK;
 Mon, 14 Sep 2026 18:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789402312; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1UfaGhIpy5Dvplr02p7iGkuX5llX7tHIRnfdWIDMHk=;
 b=ToHrbJEENCgOEfJyfWdKXB2x30h/Ie7TMrCCZLnvGg8S26C0ge0xgGj34jlVtppfGRR5x3
 gnb5OMHMyf9r1Bn8vE0UGyfZZbTaKwbdkRZLf7X1ChJbM1cR4Iijq7umCFum5FLIfgBRvd
 5m5yjU2NHtFOa+BYdHZs+JC3o1KsUj3KODXdpQKjy01mYjR9FHntDXBJit4mUdNT3lSm9i
 PRHrwCdK7RAUY4gzrIGCbu3GNWWOONpDBIk5ruC3Rx/RrgIfYVDzmHDWwwNSKrRTVSi31y
 mssjCHaSGx4QiJjcO0B9n7J0/22p2wXygz5FpmV5Vcok/OKXD0aFvmJ5ZkSz5A==
Message-ID: <c57cd3daf458e1868aa468f6e426ac0220c615a8.camel@mailbox.org>
Subject: Re: [PATCH] drm/sched: Remove useless BUG_ON()
From: Philipp Stanner <phasta@mailbox.org>
To: Philipp Stanner <phasta@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>,  Danilo Krummrich	 <dakr@kernel.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>, Maarten
 Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Mon, 14 Sep 2026 18:11:48 +0200
In-Reply-To: <20260625120151.1757146-2-phasta@kernel.org>
References: <20260625120151.1757146-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: ui38oy8szfpqbw8udhqb7fyzigdkn3ph
X-MBO-RS-ID: 47d6b421d68e00cc370
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, 2026-06-25 at 14:01 +0200, Philipp Stanner wrote:
> BUG_ON() should not be used anymore since it crashes the entire
> kernel.
> Its remaining usage is in drm_sched_job_arm() to check the entity
> pointer. If that pointer is NULL, however, the problem will become
> visible through a respective NULL pointer exception anyways.
>=20
> There is no advantage in crashing the kernel as a whole.
>=20
> Remove the BUG_ON().
>=20
> Signed-off-by: Philipp Stanner <phasta@kernel.org>

Can someone review this?


P.

> ---
> =C2=A0drivers/gpu/drm/scheduler/sched_main.c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> b/drivers/gpu/drm/scheduler/sched_main.c
> index d2ca01b31ee4..4e1b6e79ae19 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -637,7 +637,6 @@ void drm_sched_job_arm(struct drm_sched_job *job)
> =C2=A0	struct drm_gpu_scheduler *sched;
> =C2=A0	struct drm_sched_entity *entity =3D job->entity;
> =C2=A0
> -	BUG_ON(!entity);
> =C2=A0	drm_sched_entity_select_rq(entity);
> =C2=A0	sched =3D container_of(entity->rq, typeof(*sched), rq);
> =C2=A0
