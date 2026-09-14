Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C02C88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FC410E156;
	Mon, 14 Sep 2026 14:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fvJ148GQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35FD210E156
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 14:56:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 243BA60142;
 Mon, 14 Sep 2026 14:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EC61F000FF;
 Mon, 14 Sep 2026 14:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789397796;
 bh=MA2WtBrFyssGbOhwT5Bd549t6Vsu8dFSWm2RcaGEjZk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fvJ148GQ7KdJv8lCPrR5w7g0oZKebmixuBZc+kMV75a3/7njtZy2c/BG36dq9hJ+e
 ++EH27IaWo8qJP6cVsYgPunMNLK76ukoFmqNgJzX05hIpduGNzzjorMmP7MEEUHbYv
 80z/qBbXPo9E+kPdJCeCYqs05rkLFbm1Qc4wDkq+KlnIBxW088SiGX5jlj59yx1B++
 8HkGRv1IQ3nCoTBOuPUm6IQ2UfmyelGIeff3SJtEaJx3BplG2Vxq8rhYK6PLHunNXT
 txzlb5mwmZHG4ItVYkbNEkoxBEcvBQ64uTAB7BxGzHib7sbnmrF391/pxGnY6/DygD
 buvur+EKMfdPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: check ras and obj before dereference
To: "Dmitriy Chumachenko" <Dmitry.Chumachenko@cyberprotect.ru>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914143303.90614-1-Dmitry.Chumachenko@cyberprotect.ru>
References: <20260914143303.90614-1-Dmitry.Chumachenko@cyberprotect.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 14:56:36 +0000
Message-Id: <20260914145636.A6EC61F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] amdgpu_ras_global_ras_isr and amdgpu_ras_reset_gpu dereference ras=
 without checking if it is NULL.
--

commit 968ac5f5bc519258a8c9858799f60257d1c4fa96
Author: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>

drm/amdgpu: check ras and obj before dereference

This patch adds NULL checks for the ras and obj pointers in
nbio_v7_9_handle_ras_controller_intr_no_bifring() before dereferencing them.
This prevents a hard-IRQ context crash during the initialization window whe=
re
the fatal-error interrupt is enabled but the RAS context is not fully creat=
ed.

> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd=
/amdgpu/nbio_v7_9.c
> index bdfd2917e3cab..def02993b7cfd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> @@ -535,7 +535,7 @@ static void nbio_v7_9_handle_ras_controller_intr_no_b=
ifring(struct amdgpu_device
>  						RAS_CNTLR_INTERRUPT_CLEAR, 1);
>  		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL, bif_doorbell_i=
ntr_cntl);
> =20
> -		if (!ras->disable_ras_err_cnt_harvest) {
> +		if (ras && !ras->disable_ras_err_cnt_harvest && obj) {

[Severity: High]
This isn't a bug introduced by this patch, but while this change fixes the =
NULL
pointer dereference here, it looks like there are similar vulnerabilities in
other interrupt handlers during this same initialization window.

If the ATHUB interrupt fires when the RAS context is unavailable, its handl=
er
delegates to amdgpu_ras_global_ras_isr(), which fetches the RAS context via
amdgpu_ras_get_context() but unconditionally dereferences it:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:amdgpu_ras_global_ras_isr() {
    ...
    ras->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
    ...
}

It then calls amdgpu_ras_reset_gpu(), which also uses the ras pointer witho=
ut
a NULL check:

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:amdgpu_ras_reset_gpu() {
    ...
    if (atomic_cmpxchg(&ras->in_recovery, 0, 1) =3D=3D 0) {
    ...
}

Both direct dereferences will cause a hard-IRQ context kernel panic if ras =
is
NULL. Should these paths also include a check for the RAS context?

>  			/*
>  			 * clear error status after ras_controller_intr
>  			 * according to hw team and count ue number

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914143303.9061=
4-1-Dmitry.Chumachenko@cyberprotect.ru?part=3D1
