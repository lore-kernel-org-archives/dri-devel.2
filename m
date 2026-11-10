Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE9A60A5BC4
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n43XdIf0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09F0910F719;
	Tue, 10 Nov 2026 14:26:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BDC10F719
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 14:25:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BCD4618A6;
 Tue, 10 Nov 2026 14:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E471F0089F;
 Tue, 10 Nov 2026 14:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794320752;
 bh=eocJ/BJFKCzReR2kMsyo/NNQvF2KawhzUzCKi156cHU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=n43XdIf0wblWzIHqQ19s4xMXtulN7Xa1StlSYYg1NkzE+ARYKX2jtg2o8EXJkiJMA
 OJph3KowisMnd9ihM/ZkBLEy3uWi0ydPPqSfjcgAg0UIs11CWg5mN+LK4POVHz6Xlw
 SElgIJd7IrFkLpsnrHbGT25UjwhTSVF8g0Av+5gGxGuot4VeDj3q36n7tBNceUJS7Z
 ddOhYsY7/5PkEHnm5uTjqIfGhKymirUYlbgot3Bw042VLAwLzVOK7pu9lCfGYSXhAs
 NqWm0r7TL3bhDl37mXcyPlhzmXKWR7ffXw7F8zSpczuDEO46tsHqDTWwPNx55ibVZt
 51Va1pwMyk/Wg==
Message-ID: <sashiko-outbox-207189@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sched: Switch the default policy to "fair"
To: "Tvrtko Ursulin" <tvrtko.ursulin@igalia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261110141455.28739-1-tvrtko.ursulin@igalia.com>
References: <20261110141455.28739-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 14:25:51 +0000
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
- [High] drm/sched: ZERO_SIZE_PTR dereference in drm_sched_init() [1]
--

commit 50f60e38bc825925735e0e6bb31a4a450af5bbc2
Author: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

drm/sched: Switch the default policy to "fair"

This commit changes the default DRM GPU scheduler policy from FIFO to
fair and updates the sched_policy module parameter description.

> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 99252674e2668..a030061d0390c 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -83,13 +83,13 @@
>  #define CREATE_TRACE_POINTS
>  #include "gpu_scheduler_trace.h"
> =20
> -int drm_sched_policy =3D DRM_SCHED_POLICY_FIFO;
> +int drm_sched_policy =3D DRM_SCHED_POLICY_FAIR;

[Severity: High]
This problem wasn't introduced by this patch, but can drm_sched_init()
dereference ZERO_SIZE_PTR on sched->sched_rq [1] when
args->num_rqs is 0 under DRM_SCHED_POLICY_FAIR?

drivers/gpu/drm/scheduler/sched_main.c:drm_sched_init() {
	...
	sched->num_rqs =3D drm_sched_policy !=3D DRM_SCHED_POLICY_FAIR ?
			 args->num_rqs : 1;
	sched->sched_rq =3D kzalloc_objs(*sched->sched_rq, args->num_rqs);
	if (!sched->sched_rq)
		goto Out_check_own;

	for (i =3D DRM_SCHED_PRIORITY_KERNEL; i < sched->num_rqs; i++) {
		sched->sched_rq[i] =3D kzalloc_obj(*sched->sched_rq[i]);
	...
}

When args->num_rqs is 0, it passes the upper-bound check against
DRM_SCHED_PRIORITY_COUNT, and kzalloc_objs() returns ZERO_SIZE_PTR while
sched->num_rqs is overridden to 1 for the fair policy, causing the loop
to dereference sched->sched_rq[0].  Should kzalloc_objs() use
sched->num_rqs instead of args->num_rqs?

[1] https://sashiko.dev/#/bug/linux-5fb1fd33-7544-4ca1-bec8-2b20739ac0dd

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110141455.2873=
9-1-tvrtko.ursulin@igalia.com?part=3D1
