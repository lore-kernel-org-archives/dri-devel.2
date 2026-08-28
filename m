Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5B4C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 21:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F5310F48A;
	Fri, 28 Aug 2026 21:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OBD2Pv5h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0450B10F48A
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 21:12:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61B1B60055;
 Fri, 28 Aug 2026 21:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E292F1F000E9;
 Fri, 28 Aug 2026 21:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787951546;
 bh=h5xqe550BxtxAadb7Cm2LB2rmEsOWpMnMVLSFs3dt4g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OBD2Pv5howPY5Ksa7r9H99Zw9dmQGT1MuD5y+rpfceTQkTn4hfirDwhIgb0LH4ISN
 OmBp+p/rzQkkWKlP17fMOoVqOAwiaxlWp2l0oQH9eAgEqJQws07XraRR43SJDTRSi/
 sdhHkJNmdUSer69xC9v8Vm92w9Is4wqHVkHiXNBGRpIGnXKEjhNBVzNPr7x8j+WGcq
 dOXm7dLviI4BtMc0o9LBBszTAADfDjgf6ZKvdmafq8B3kUI74R+2McwtvVUeV2Q68j
 nubB0qgTqALxqJqh0/0e/4AjY8W5f1XTEMEOgJIQm4JJ5s2vIkfpB2qRBD/hOKWWOX
 RgPO7D0d1ihVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/17] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828-claude-fixes-v7-11-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
 <20260828-claude-fixes-v7-11-72a13b2c125d@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 21:12:25 +0000
Message-Id: <20260828211225.E292F1F000E9@smtp.kernel.org>
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

New issues:
- [Medium] Incorrect handling of pm_runtime_get_if_in_use() return value in=
 reset_set() leading to usage count underflow.

Pre-existing issues:
- [High] Incorrect handling of pm_runtime_get_if_in_use() return value in p=
anfrost_gpu_get_latest_flush_id() causing unsafe MMIO reads and PM underflo=
w.
--

commit 6c0954bdc79e7702d546ce41292da37dbd1a90e1
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Add debugfs knob for manually triggering a GPU reset

This patch adds a debugfs file for manually triggering a GPU reset to aid
in testing potential races between the reset sequence and hardware register
access.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index d8acae9b8cfac..b6a48ae0d3a61 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
[ ... ]
> @@ -600,9 +601,43 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) =3D {
>  };
> =20
>  #ifdef CONFIG_DEBUG_FS
[ ... ]
> +static int reset_set(void *data, u64 val)
> +{
> +	struct panfrost_device *pfdev =3D
> +		container_of(data, struct panfrost_device, base);
> +
> +	if (pm_runtime_get_if_in_use(pfdev->base.dev)) {

[Severity: Medium]
When pm_runtime_get_if_in_use() is called while runtime PM is disabled=20
(such as during driver unbind or system suspend), it returns -EINVAL.

Since -EINVAL evaluates to true in this condition, does this cause the=20
block to execute without a successful get?

If so, could this regression lead to an unbalanced pm_runtime_put() call=20
at the end of the block and a PM usage counter underflow?

> +		panfrost_device_schedule_reset(pfdev);
> +		flush_work(&pfdev->reset.work);
> +		pm_runtime_put(pfdev->base.dev);
> +	}
> +
> +	return 0;
> +}
[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but looking at a similar=20
pre-existing pattern in drivers/gpu/drm/panfrost/panfrost_gpu.c:

panfrost_gpu_get_latest_flush_id() {
	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_FLUSH_REDUCTION)) {
		if (pm_runtime_get_if_in_use(pfdev->base.dev)) {
			flush_id =3D gpu_read(pfdev, GPU_LATEST_FLUSH_ID);
			pm_runtime_put(pfdev->base.dev);
			return flush_id;
		}
	}
	...
}

If pm_runtime_get_if_in_use() returns -EINVAL during system suspend or=20
teardown when disable_depth > 0, does this condition also evaluate to true?=
 =20

Could this result in an unsafe MMIO read on potentially powered-off=20
hardware, followed by another unbalanced usage count decrement?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-claude-fix=
es-v7-0-72a13b2c125d@collabora.com?part=3D11
