Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7953FCA5FE4
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 01:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A022110E727;
	Sat,  3 Oct 2026 01:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UNSV69ug";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E54010E721
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 01:34:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1261260D8B;
 Sat,  3 Oct 2026 01:34:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936601F00893;
 Sat,  3 Oct 2026 01:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790991270;
 bh=BjRgoBS2zlrpMQjXP2vHaFVmlUIr5/jWPMIigW3KGcY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UNSV69ugCRjmOY7VA2R3DJEeu1V0F6Ysqi2jDjjB5AwVJhyGu4/+KMrSr7bNhQXlo
 9c9kHgSBu13dkhg5zZKoVylH85S5DZeZlsccqdfSmumkqLlp7SHsCI8OBffAFCAkoN
 7/BMTArGnKuPZe0B3EuIKLldRE5rY17ziy42rkiCXDRIcxAyP0wkEz0HBF+S2XYpWa
 mR7Ln+xUeOuDpYqpphn0bJ8PPldSastibv0havRvXOOk2ok0sVTs24M3iqrybPGakS
 DsUrW0VwMBafCVx84poUNfhqnbRjLwt+jdagKJ/D7lq/VuiQPcBA9TaHmn2Yll5O1d
 t83N+O+SAlR+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] drm/msm: let the kms drivers clean up a failed
 kms_init()
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261003-msm-kms-destroy-fixes-v1-4-e062b7dae77f@oss.qualcomm.com>
References: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
 <20261003-msm-kms-destroy-fixes-v1-4-e062b7dae77f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:34:30 +0000
Message-Id: <20261003013430.936601F00893@smtp.kernel.org>
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
- [High] drm/msm: NULL pointer dereference in snapshot worker due to invert=
ed teardown order
--

commit 5b99326f79a79593a3cb18892305a7e107cff364
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm: let the kms drivers clean up a failed kms_init()

A failed priv->kms_init() or ->hw_init() is cleaned up by the ->destroy()
callback, which makes ->destroy() responsible for tearing down a KMS in
any state between "not initialised at all" and "fully initialised". The
kernel convention is the opposite: a function which fails undoes its own
steps, and the teardown only ever sees a fully set up object.

> diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
> index f3e39c3907a93..f65774b04c6fa 100644
> --- a/drivers/gpu/drm/msm/msm_kms.c
> +++ b/drivers/gpu/drm/msm/msm_kms.c
[ ... ]
> @@ -344,9 +348,10 @@ int msm_drm_kms_init(struct device *dev, const struc=
t drm_driver *drv)
>  err_destroy_event_threads:
>  	msm_drm_kms_destroy_event_threads(kms);
>  err_destroy_kms:
> -	msm_disp_snapshot_destroy(ddev);
>  	if (kms->funcs)
>  		kms->funcs->destroy(kms);
> +err_destroy_snapshot:
> +	msm_disp_snapshot_destroy(ddev);
> =20
>  	return ret;
>  }

[Severity: High]
Does this inverted teardown order cause a NULL pointer dereference in the
snapshot worker?

If an error occurs after kms_init() succeeds in msm_drm_kms_init() (for
example, if drm_vblank_init() fails), the error path jumps to
err_destroy_event_threads. If a concurrent IOMMU fault or underrun triggers
msm_disp_snapshot_state() at this time, it queues the snapshot work.

With this patch, the teardown order is swapped so that
kms->funcs->destroy(kms) is called before msm_disp_snapshot_destroy(ddev).
The destroy() callback (such as dpu_kms_destroy() calling
_dpu_kms_hw_destroy()) tears down the hardware and sets pointers like
dpu_kms->catalog =3D NULL.

When msm_disp_snapshot_destroy() is subsequently called, it invokes
kthread_destroy_worker(), which flushes the worker and executes the pending
snapshot work. The snapshot work calls kms->funcs->snapshot(), which then
dereferences the nulled hardware state, resulting in a kernel oops in
dpu_kms_mdp_snapshot() when reading cat->ctl_count.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-msm-kms-de=
stroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com?part=3D4
