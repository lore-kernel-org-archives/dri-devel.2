Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95B606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JCaaKZzU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76B8210F8B9;
	Tue, 24 Nov 2026 22:51:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E60310F8BB
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 22:51:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 23FAC628D7;
 Tue, 24 Nov 2026 22:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A165A1F000E0;
 Tue, 24 Nov 2026 22:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795560692;
 bh=ePpLXPUQhbbP/99/Z2KF0U3aolcJ/xjOUuODXkB0R8E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JCaaKZzU0m+YfFR1Fv/q96UrgtUPPO+5jQGxrHI8pJd9KXxILoM+wVjDUE6adE1+t
 Mwaw0Dljo1P6k828iLR9jZlAYRDMM+hIemeqFAfCfRsSG65Sp70HhrErt8eLkZci0r
 fsBiZsVgFApp4kPihxTPKavN1PxGS8oL7RwONmMFfuDnu3HIDPpD3t1Qy4pIUxr9g8
 +Qj6O7PJ2ZHQioJQZBmJWixYPinMPOGm+fUxeG+iSDC+S2DpHIlM8/P/PzCZi9Wtt1
 hRl2yJ65x+NM5UTvDVWTKbunbibMx43JonqgZVzk1NM2xbInhFn4Xm3ulIZCj6eq34
 oduv7ppdb0jhQ==
Message-ID: <sashiko-outbox-232162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dpu: sc8180x: restore dp_phy_intf_sel on
 runtime resume
To: "Robert Ijtsma" <robertijtsma@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261124-drm-msm-dpu-sc8180x-resume-v1-1-a6201f43136d@gmail.com>
References: <20261124-drm-msm-dpu-sc8180x-resume-v1-1-a6201f43136d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:51:32 +0000
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
- [Critical] drm/msm/dpu: double-free in drm_atomic_private_obj_fini()
  [1]
--

commit 6e0b86c0584c21b562d2cf301710555950956e94
Author: Robert Ijtsma <robertijtsma@gmail.com>

drm/msm/dpu: sc8180x: restore dp_phy_intf_sel on runtime resume

This commit factors out dpu_kms_setup_dp_phy_intf_sel() and invokes it
from both dpu_kms_hw_init() and dpu_runtime_resume() so that
MDP_DP_PHY_INTF_SEL is restored across runtime PM and s2idle resume.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/ms=
m/disp/dpu1/dpu_kms.c
> index 1b6286dccfc00..31166e7e65985 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c

[ ... ]

> @@ -1246,8 +1256,7 @@ static int dpu_kms_hw_init(struct msm_kms *kms)
>  	 * the INTF <->DP relationship isn't static anymore, this needs to be
>  	 * configured through the DT.
>  	 */
> -	if (of_device_is_compatible(dpu_kms->pdev->dev.of_node, "qcom,sc8180x-d=
pu"))
> -		dpu_kms->hw_mdp->ops.dp_phy_intf_sel(dpu_kms->hw_mdp, (unsigned int[])=
{ 1, 2, });
> +	dpu_kms_setup_dp_phy_intf_sel(dpu_kms);
> =20
>  	dpu_kms->hw_intr =3D dpu_hw_intr_init(dev, dpu_kms->mmio, dpu_kms->cata=
log);
>  	if (IS_ERR(dpu_kms->hw_intr)) {

[Severity: Critical]
This problem wasn't introduced by this patch, but can a failure in
dpu_kms_hw_init() cause a double free in drm_atomic_private_obj_fini()
[1]?

When dpu_kms_hw_init() fails (for example in _dpu_kms_mmu_init()), its
error path calls _dpu_kms_hw_destroy(), which invokes
drm_atomic_private_obj_fini(&dpu_kms->global_state):

drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c:dpu_kms_hw_init() {
    ...
err_pm_put:
	pm_runtime_put_sync(&dpu_kms->pdev->dev);
error:
	_dpu_kms_hw_destroy(dpu_kms);

	return rc;
}

The error returns to msm_drm_init(), whose err_msm_uninit path calls
msm_drm_uninit() -> msm_drm_kms_uninit() -> dpu_kms_destroy() ->
_dpu_kms_hw_destroy(dpu_kms) a second time, calling
drm_atomic_private_obj_fini() again on the already-finalized
dpu_kms->global_state.

[1] https://sashiko.dev/#/bug/linux-6c17bd8a-d5d5-4727-8390-902b349b7fd0

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-drm-msm-dp=
u-sc8180x-resume-v1-1-a6201f43136d@gmail.com?part=3D1
