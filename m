Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277AEC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 13:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B216010E0AC;
	Sun, 28 Jun 2026 13:43:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zo8RGC8A";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF2C910E0AC
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 13:43:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1D06A43D35;
 Sun, 28 Jun 2026 13:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94F71F000E9;
 Sun, 28 Jun 2026 13:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782654222;
 bh=+/ZZHvvoY1O2yD44dsv6ckKCqltMNrQsxTO6sUP7pCU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Zo8RGC8A8JGHO6KzpxKfL5FkMYhZxjnbj+4icpv+F+J967WC2vpV00J1nW2VCruq+
 6Xw7fYGbCqoEhdIr8ZqDASbzqncoDT/EiYCQrmDczu/8MJDBchfZGlIf7bNS8nhBAb
 vNspngW2Mknv7M0aBxSill8LnHsEjHTcOtXrD+fV+yk5YhzqsXOP2oQhUPhTyGxklm
 DGyT443il93WofsHMxccR/xXknxt+/KPhIc5oEi+gtHMY4pZxkQ+UUk8ZBxF9fegld
 XdMagPfrJuEAHk9yN7Rto7P26+/xJuq0B3iamk84M0Xu8pwvdklvu5gS0eerwGwHj8
 r4+y3kj+DJ7qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/display: fix MST branch device refcount leak on
 DPCD write failure
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260628133344.46188-1-vulab@iscas.ac.cn>
References: <20260628133344.46188-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 13:43:41 +0000
Message-Id: <20260628134341.C94F71F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Permanent memory leak of the initial `drm_dp_mst_branch` device =
on DPCD write failure.
- [Medium] Inconsistent MST state leading to a kernel warning in `drm_dp_ms=
t_topology_queue_probe()` and silent functional breakage.
--

commit 169a81a07028ce3444674cdec29dcdd6268008f7
Author: WenTao Liang <vulab@iscas.ac.cn>

    drm/display: fix MST branch device refcount leak on DPCD write failure
   =20
    drm_dp_add_mst_branch_device initializes mstb with refcount 1, and
    drm_dp_mst_topology_get_mstb increments it to 2. When
    drm_dp_dpcd_write_byte fails, out_unlock performs only one
    drm_dp_mst_topology_put_mstb, leaving the other reference stored in
    mgr->mst_primary. Since MST was not successfully enabled, no disable pa=
th
    will clean it up.
   =20
    Suggested-by: Greg KH <gregkh@linuxfoundation.org>
    Fixes: 7a3cbf590e63 ("drm/mst: Some style improvements in drm_dp_mst_to=
pology_mgr_set_mst()")
    Cc: stable@vger.kernel.org
    Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
> index 4de36fda05440..6a8c9dc217e53 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -3681,8 +3681,10 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_=
mst_topology_mgr *mgr, bool ms
>  					     DP_MST_EN |
>  					     DP_UP_REQ_EN |
>  					     DP_UPSTREAM_IS_SRC);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			mgr->mst_primary =3D NULL;

[Severity: Medium]
Does clearing mgr->mst_primary here cause a permanent memory leak?

Since drm_dp_mst_topology_get_mstb() previously incremented the refcount to=
 2,=20
clearing this pointer without first calling drm_dp_mst_topology_put_mstb()
leaves one reference orphaned. When the code jumps to out_unlock, it will d=
rop
the remaining reference (down to 1), but the memory will never be freed.

Furthermore, any subsequent cleanup calls to=20
drm_dp_mst_topology_mgr_set_mst(..., false) will also fail to clean it up
because they expect to find the pointer in mgr->mst_primary.

[Severity: Medium]
Does this also leave the manager in an inconsistent state?

Earlier in drm_dp_mst_topology_mgr_set_mst(), mgr->mst_state is set to true.
If the DPCD write fails and we clear mgr->mst_primary without reverting
mgr->mst_state to false, we end up with mst_state =3D=3D true but
mst_primary =3D=3D NULL.

If a driver later calls drm_dp_mst_topology_queue_probe(), would it trigger
this warning due to the mismatched state?

    if (drm_WARN_ON(mgr->dev, !mgr->mst_state || !mgr->mst_primary))

Additionally, it seems future attempts to enable MST would silently return
success because the early check (mst_state =3D=3D mgr->mst_state) would eva=
luate
to true without configuring the hardware.

>  			goto out_unlock;
> +		}
> =20
>  		/* Write reset payload */
>  		drm_dp_dpcd_clear_payload(mgr->aux);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628133344.4618=
8-1-vulab@iscas.ac.cn?part=3D1
