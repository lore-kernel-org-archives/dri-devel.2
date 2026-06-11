Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8967FCD98C6
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 06:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDC1A10ECEB;
	Thu, 11 Jun 2026 06:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gb1Yvi23";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6820C10ECEB
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 06:18:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D100E60208
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 06:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698821F00893;
 Thu, 11 Jun 2026 06:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781158701;
 bh=f3zV1gvGtei2/jVpLL2Axwm3F6+gjDhcdGYSzX+B6hU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gb1Yvi23pi5Gryrvfi3iRQd7EgTaGXQFzufjOR9uPpjH1MdI4G5SM53i1ymBvaY8T
 1GyUhHPI2YJrPxycw6LnuSN0ajQ5BXsZVRlz0XQ+g++W6gdL81Foh2Qtdb1DtkNZnV
 mllsHD+FoTcB9RIDv7SdAnBFwQiRj4vSI1oPUdcNaSCuUXXLfhokI7EXzNAmNy7pgj
 ATSv+8OPEDwdlb7Ypq+c8oxX+cT3ZrHCgC5pqFNFbyXGHn3ZVCjUGDhi0Oxb7Z/DCX
 iLO4Wbheg8Onw98zGc2S5sWI6S+4PivtD4WL4G1xQCjv3HqDXQgl1Xw0bFJsmM6lPI
 cwdYGQNGLsl+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/msm/mdp4: keep the bus clock enabled while a
 CRTC is active
To: "Alexandre MINETTE via B4 Relay" <devnull+contact.alex-min.fr@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-1-22925600e4f2@alex-min.fr>
References: <20260611-mainline-fix-mdp4-blue-screen-sending-v1-v1-1-22925600e4f2@alex-min.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:18:21 +0000
Message-Id: <20260611061821.698821F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Sleeping functions called from atomic context.
- [High] Unbalanced reference counting on AXI clock enable failure leads to=
 premature clock disable for active CRTCs.

Pre-existing issues:
- [High] Failure to enforce IOMMU requirement by allowing a NULL VM fallbac=
k in drm_gpuvm conversion.
--

commit f1ffff35bea0debf56db480bb3da6443ad42c41a
Author: Alexandre MINETTE <contact@alex-min.fr>
Subject: drm/msm/mdp4: keep the bus clock enabled while a CRTC is active

This patch keeps the AXI/bus clock enabled for the lifetime of each active
CRTC to avoid temporary MDP4 disable paths gating the bus clock while
scanout is still running.

> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c b/drivers/gpu/drm/=
msm/disp/mdp4/mdp4_crtc.c
> index e8066f9fd5343..9e53c9d956ca8 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c
> @@ -271,6 +271,7 @@ static void mdp4_crtc_atomic_disable(struct drm_crtc =
*crtc,
> =20
>  	mdp_irq_unregister(&mdp4_kms->base, &mdp4_crtc->err);
>  	mdp4_disable(mdp4_kms);
> +	mdp4_crtc_bus_put(mdp4_kms);

[Severity: High]
Does calling mdp4_crtc_bus_put() here introduce a sleeping lock into an ato=
mic
context?

CRTC atomic disable callbacks execute in an atomic context where sleeping is
forbidden, but mdp4_crtc_bus_put() acquires a mutex lock.

[ ... ]

> @@ -295,6 +296,7 @@ static void mdp4_crtc_atomic_enable(struct drm_crtc *=
crtc,
>  		return;
> =20
>  	mdp4_enable(mdp4_kms);
> +	mdp4_crtc_bus_get(mdp4_kms);

[Severity: High]
Similarly, does this introduce sleeping calls into the atomic enable path?

mdp4_crtc_bus_get() uses both mutex_lock() and clk_prepare_enable(), which
may sleep.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/m=
sm/disp/mdp4/mdp4_kms.c
> index 809ca191e9de7..4c60b49fb7842 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
> @@ -118,6 +118,39 @@ static long mdp4_round_pixclk(struct msm_kms *kms, u=
nsigned long rate,
[ ... ]
> +void mdp4_crtc_bus_get(struct mdp4_kms *mdp4_kms)
> +{
> +	int ret =3D 0;
> +
> +	mutex_lock(&mdp4_kms->clock_lock);
> +
> +	if (!mdp4_kms->crtc_bus_count)
> +		ret =3D clk_prepare_enable(mdp4_kms->axi_clk);
> +
> +	if (!ret)
> +		mdp4_kms->crtc_bus_count++;
> +
> +	mutex_unlock(&mdp4_kms->clock_lock);
> +
> +	WARN_ON(ret);
> +}
> +
> +void mdp4_crtc_bus_put(struct mdp4_kms *mdp4_kms)
> +{
> +	mutex_lock(&mdp4_kms->clock_lock);
> +	if (!mdp4_kms->crtc_bus_count)
> +		goto unlock;
> +
> +	mdp4_kms->crtc_bus_count--;

[Severity: High]
Could this result in unbalanced reference counting and premature clock disa=
ble?

If clk_prepare_enable() fails in mdp4_crtc_bus_get(), crtc_bus_count is not
incremented, but the error isn't propagated since the function returns void.
If a subsequent CRTC successfully enables the clock, the counter becomes 1.

Later, when the first (failed) CRTC is disabled, mdp4_crtc_bus_put() will
unconditionally decrement crtc_bus_count to 0 and disable the clock. This
steals the reference belonging to the second active CRTC, leaving it scanni=
ng
out with its bus clock disabled.

[ ... ]

While reviewing this file, I noticed a pre-existing issue in mdp4_kms_init(=
):

drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c:mdp4_kms_init() {
    ...
	vm =3D msm_kms_init_vm(mdp4_kms->dev, NULL);
	if (IS_ERR(vm)) {
		ret =3D PTR_ERR(vm);
		goto fail;
	}

	kms->vm =3D vm;
    ...
}

[Severity: High]
This is a pre-existing issue, but does this bypass the IOMMU requirement if
msm_kms_init_vm() returns NULL?

The DRM subsystem requires IOMMU support for drm_gpuvm and does not support
fallback modes. Since msm_kms_init_vm() might return NULL when IOMMU is
unavailable, checking only IS_ERR(vm) allows driver initialization to proce=
ed
with a NULL VM instead of failing with an error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-mainline-f=
ix-mdp4-blue-screen-sending-v1-v1-0-22925600e4f2@alex-min.fr?part=3D1
