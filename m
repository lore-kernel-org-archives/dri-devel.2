Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F1E1C43327
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A91410E3A7;
	Fri, 26 Jun 2026 13:00:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="St8tXqum";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D4310E3A7
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:00:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A71F6439BA;
 Fri, 26 Jun 2026 13:00:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8B01F000E9;
 Fri, 26 Jun 2026 13:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782478848;
 bh=JXjYrqcfd9r/Im9QezGkVyuRX1sLS7OXYa8fX1qaoyU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=St8tXqumJfv5s7Yu4IWKZ1inBGGjRhKNt2FxRkUNl0SEP6wDsCbTIFMQWCZG3x70c
 cNUXzQKUxTY+0LtKVl9vhViLpTWb0zKT/ev9XXuFBAMbUnZ0heWsGuWc7O4VGcut/N
 n3xN2lIzHED042oFtQk6od5adaSXUGVTreBUvUN2INlC/qXiZcvDc0oUpFBmCsTJ9T
 cfR2Gpv5Oz9N46HC8Z/S1yYBCDyoWZYKib/eGqbyMZtgBSHPEry1Cr9AhOlZNjAmZi
 UyZtBNDPyrb/oZKA2ooTQndPQMg+mYLk+U2RcWen1n4p4Hd/Q1HDQomGx4YI/BhvHC
 oAwTXKmdrn8Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: drm/display: drm_dp_mst_topology_mgr_set_mst:
 error path after DPCD   write failure leaks MST branch device reference
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260626125117.37153-1-vulab@iscas.ac.cn>
References: <20260626125117.37153-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 13:00:48 +0000
Message-Id: <20260626130048.6C8B01F000E9@smtp.kernel.org>
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
- [High] The patch introduces a permanent, unrecoverable memory leak of the=
 MST branch device by clearing the `mgr->mst_primary` pointer without decre=
menting its reference count.
--

commit ecf0dbf046159857ec56d411e54fc1853de6778c
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: drm/display: drm_dp_mst_topology_mgr_set_mst: error path after DPCD wr=
ite failure leaks MST branch device reference

This commit attempts to fix an issue in the DPCD write failure path of=20
drm_dp_mst_topology_mgr_set_mst() by clearing the mgr->mst_primary pointer=
=20
before unlocking.

> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/=
drm/display/drm_dp_mst_topology.c
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
>  			goto out_unlock;
> +		}

[Severity: High]
Does clearing this pointer without dropping its reference permanently leak=
=20
the MST branch device?

When drm_dp_add_mst_branch_device() returns mstb earlier in this function,=
=20
it has an initial topology_kref of 1.

Shortly after, drm_dp_mst_topology_get_mstb(mgr->mst_primary) increments th=
e=20
reference count to 2.

If drm_dp_dpcd_write_byte() fails, this patch sets mgr->mst_primary =3D NUL=
L=20
and jumps to out_unlock.

At out_unlock, drm_dp_mst_topology_put_mstb(mstb) is called once,=20
decrementing the reference count to 1.

Because mgr->mst_primary was set to NULL, future calls to disable MST=20
(such as drm_dp_mst_topology_mgr_set_mst(..., false)) won't be able to=20
find the primary branch device to clean up the final reference, which means=
=20
the struct drm_dp_mst_branch object will be permanently leaked.

> =20
>  		/* Write reset payload */
>  		drm_dp_dpcd_clear_payload(mgr->aux);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626125117.3715=
3-1-vulab@iscas.ac.cn?part=3D1
