Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E2FC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF6410EDB2;
	Tue, 11 Aug 2026 21:54:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hoTmSkBW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7315910EDB1
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 21:54:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9775A600AE;
 Tue, 11 Aug 2026 21:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C99E1F000E9;
 Tue, 11 Aug 2026 21:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786485278;
 bh=z4aCfofncXy7MEe18CHDcD1m8wB6/yqG8Lxpw7kbLn8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hoTmSkBW6MF2IoVTb3kl65DcSRFfe/gl0IzlgIjsr5R8wb98KMnftRFBois0cbnwF
 hmPaoPVORoHHV6ZuRbUCHeaHR110lPJ4Y2NG9fGonSV0IjFJwhcmx/PuKWk83fU64W
 b7EG38SaUW8UDTwJT4uUM+RsZ7fmCgPDBaa2sCsgdWHd9eavx7K/bcewVMh1g3W/Yu
 aKJsPWn/wIgQxIGdhgcVze5RgrXgLwW3/BIvdYuPBv7NhwNEFOF1VslRsRXZ/t9Ifw
 r3BLEZmq9z36ftSJgUSdHpeZsfYZoAkngPf5lentN0lDS3uJtMpM7jou+PMemaoZ74
 /cGhQlMOl9Uuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/11] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260811-claude-fixes-v5-7-3d692c9e98c2@collabora.com>
References: <20260811-claude-fixes-v5-0-3d692c9e98c2@collabora.com>
 <20260811-claude-fixes-v5-7-3d692c9e98c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 21:54:37 +0000
Message-Id: <20260811215438.2C99E1F000E9@smtp.kernel.org>
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
- [Medium] The debugfs reset knob silently ignores manual reset requests if=
 the GPU is idle or if the kernel is built without CONFIG_PM, returning suc=
cess without performing the requested reset.
--

--- Patch [7]: [PATCH v5 07/11] drm/panfrost: Add debugfs knob for manually=
 triggering a GPU reset ---
commit b4df81709774bfc91adda2d5d8e8a0109269e143
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Add debugfs knob for manually triggering a GPU reset

This commit adds a debugfs knob to manually trigger a GPU reset. This is
intended to help test potential races between the GPU reset sequence and
other parts of the code accessing HW registers.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm=
/panfrost/panfrost_device.c
> index 52f4b8c6a05fe..5b66173c75b9b 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c

[ ... ]

> +static int reset_set(void *data, u64 val)
> +{
> +	struct panfrost_device *pfdev =3D
> +		container_of(data, struct panfrost_device, base);
> +	int ret;
> +
> +	ret =3D pm_runtime_get_if_in_use(pfdev->base.dev);
> +
> +	if (ret > 0) {
> +		panfrost_device_schedule_reset(pfdev);
> +		flush_work(&pfdev->reset.work);
> +		pm_runtime_put(pfdev->base.dev);
> +	}
> +
> +	return 0;

[Severity: Medium]
Will this silently ignore the manual reset request when the GPU is idle or =
if
CONFIG_PM is disabled?

If pm_runtime_get_if_in_use() returns <=3D 0, such as 0 when the device is =
idle
or -EINVAL when the kernel is built without CONFIG_PM, the reset is bypasse=
d.
However, the function still returns 0 (success).

This could cause test scripts writing to this debugfs file to become flaky =
or
unreliable, as they will falsely assume the GPU was reset. Would it be bett=
er
to return an error code when the reset is skipped?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-claude-fix=
es-v5-0-3d692c9e98c2@collabora.com?part=3D7
