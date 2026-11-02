Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944EF606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tm56MSOi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B453910ED45;
	Mon,  2 Nov 2026 11:50:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5740D10ED45
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 11:49:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 607F360EF3;
 Mon,  2 Nov 2026 11:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F009E1F00A16;
 Mon,  2 Nov 2026 11:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793620193;
 bh=eRBjC/mF5gtbPh8kLR/A7+5ox6V8qiY16ivdmTWNtWY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Tm56MSOigLShCUEsCOkXSViXkwpceVfrKSlbzoZ5bZI5PtEwADSwOLrvTsPTIJdSQ
 26NEqhSnuR3awINyVskUnMJRx9aJFlbWNyt82sAslj9sfPf1ryDAaWpeRGqDnyT3l7
 HHk0P0d8Iz2T3K0G5c8xc8mTYYYPG5OTMecAEHTgJpIhMg5EZOiGEnuZmdomgFMkMd
 PGlHCF7sa3KRXEJWVjJsyR/MgPN5HimjxFzrV8xX9HL2p3HEeNjFQiw4QAp23QJUWI
 MKDQYU9NNTNoBMBGoYVf76H5T19gO7aDhhppiS/Kn17Ctw6sUMeK+WDAyo9+5ORx5J
 Z4IfaXfOOfcTQ==
Message-ID: <sashiko-outbox-193351@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/etnaviv: Keep busy jobs alive in the hangcheck
To: "Christian Gmeiner" <christian.gmeiner@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261102-etnaviv-compute-hangcheck-v1-1-1f81dd1806a2@igalia.com>
References: <20261102-etnaviv-compute-hangcheck-v1-1-1f81dd1806a2@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:49:52 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] drm/etnaviv: missing kernel-parameters.txt entry for hang_max_ms pa=
rameter
--

commit d016b8a43dc381c8473158580794cfa7c242820a
Author: Christian Gmeiner <cgmeiner@igalia.com>

drm/etnaviv: Keep busy jobs alive in the hangcheck

This commit checks VIVS_HI_IDLE_STATE in the scheduler timeout handler to
keep jobs alive while non-FE/MC hardware units are busy, up to a new
hang_max_ms module parameter limit.

> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_sched.c b/drivers/gpu/drm/et=
naviv/etnaviv_sched.c
> index 3cc50d697c891..cef1ed33ff919 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_sched.c
> @@ -17,6 +17,9 @@ static int etnaviv_job_hang_limit =3D 0;
>  module_param_named(job_hang_limit, etnaviv_job_hang_limit, int , 0444);
>  static int etnaviv_hw_jobs_limit =3D 4;
>  module_param_named(hw_job_limit, etnaviv_hw_jobs_limit, int , 0444);
> +static unsigned int etnaviv_hang_max_ms =3D 30000;
> +module_param_named(hang_max_ms, etnaviv_hang_max_ms, uint, 0644);
> +MODULE_PARM_DESC(hang_max_ms, "Time a busy job may run without front-end=
 progress (ms, 0 =3D no extension)");

[Severity: Low]
Should this new hang_max_ms module parameter (etnaviv_hang_max_ms in
drivers/gpu/drm/etnaviv/etnaviv_sched.c), which can also be set on the kern=
el
command line at boot as etnaviv.hang_max_ms=3D, be documented in
Documentation/admin-guide/kernel-parameters.txt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-etnaviv-co=
mpute-hangcheck-v1-1-1f81dd1806a2@igalia.com?part=3D1
