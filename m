Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1FF606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GuH8sBKl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0C8E10E511;
	Wed, 18 Nov 2026 10:25:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FBA610FAA6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:25:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F02A4091F;
 Wed, 18 Nov 2026 10:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA0D1F000C5;
 Wed, 18 Nov 2026 10:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794997524;
 bh=Df+0/9CDDaQBlQ4MEuuMNU+iH9WEWKATgpiyQ1cv5JU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GuH8sBKlZw/g2dKhxluKxSlXtdWY7QEQmOVOHFjcnOpYoheMChuhvmstVBHz25SlB
 27Vour7kp72b8oc9EfVl2QeEItImNXSKOpiKqvNtCj3tDalj4xhAaHFou7JfedXbzv
 A0WaECF0DQ17f0AY9wxhtdm6+oyFSvDRn5sBznS4F+v1cTG/xZN/76f8LRQb1oT+aP
 411M1X4v7ZdiQcAx28rTzz+basaPNWxuDmtP9c5E0mbCF0VOjCREpHo4C1LZQYqSr+
 Dcs80O0LEgLr7sAgxv/dEBvYBOAPgm+YFhLuODDgSsx9yQ2zw8wdMiAsTXCytQJi3W
 awsWY6myoy0KA==
Message-ID: <sashiko-outbox-220687@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/rocket: Fix up sched array handling on open and
 close
To: "Tomeu Vizoso" <tomeu@tomeuvizoso.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261118101901.253550-1-tomeu@tomeuvizoso.net>
References: <20261118101901.253550-1-tomeu@tomeuvizoso.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:25:23 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] accel/rocket: use-after-free of DRM scheduler in
  rocket_remove() [1]
--

commit 60150dc55a394b4ae585de44cc1ea51f813c0a96
Author: Tomeu Vizoso <tomeu@tomeuvizoso.net>

accel/rocket: Fix up sched array handling on open and close

This commit drops the WARN_ON() when drm_sched_entity_init() fails in
rocket_job_open(), and reorders rocket_job_close() to destroy the scheduler
entity before freeing the scheduler array.

Link: https://lore.kernel.org/all/20260826113538.42111-1-sidong.yang@furios=
a.ai/
Link: https://lore.kernel.org/all/20260826113538.42111-2-sidong.yang@furios=
a.ai/

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 7b798a90bc492..454d465a39e37 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -572,7 +572,7 @@ int rocket_job_open(struct rocket_file_priv *rocket_p=
riv)
>  				    DRM_SCHED_PRIORITY_NORMAL,
>  				    scheds,
>  				    rdev->num_cores, NULL);
> -	if (WARN_ON(ret))
> +	if (ret)
>  		kfree(scheds);
>  	else
>  		rocket_priv->scheds =3D scheds;

[Severity: Critical]
This problem wasn't introduced by this patch, but can unbinding a Rocket NPU
core while a file descriptor is open cause a use-after-free of the DRM
scheduler [1]?

rocket_job_open() initializes rocket_priv->sched_entity with pointers to
rdev->cores[core].sched.  If a core is unbound while the file descriptor
remains open, rocket_remove() calls rocket_core_fini() -> drm_sched_fini()
without synchronizing against open file descriptors or active entities.  A
subsequent job submission then dereferences the torn-down scheduler in
drm_sched_job_arm():

CPU0                                CPU1
rocket_job_open()
  scheds[i] =3D &rdev->cores[i].sched
  drm_sched_entity_init(..., scheds, ...)

rocket_remove()
  rocket_core_fini()
    drm_sched_fini()
                                    rocket_ioctl_submit()
                                      ...
                                        drm_sched_job_arm()
                                          drm_sched_entity_select_rq()
                                          sched =3D entity->rq->sched  <-- =
use-after-free

[1] https://sashiko.dev/#/bug/linux-57e50ba5-1b02-4d94-b63e-d7208e41bab0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118101901.2535=
50-1-tomeu@tomeuvizoso.net?part=3D1
