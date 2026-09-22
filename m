Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E8AC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8FC410EE73;
	Tue, 22 Sep 2026 20:59:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X1sVwmHn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C972010EE73
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 20:59:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 94EAB418A0;
 Tue, 22 Sep 2026 20:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5648C1F000FF;
 Tue, 22 Sep 2026 20:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790110749;
 bh=yqld41u7Ov/CSxYFoU8dMtpwVeoLVbG11l+WX5KXcMw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X1sVwmHnDMaT8eTTiriutAY5ji81n13PBXkNU7oabi/5WH8UNEt5qRB14y0xBXLOV
 nHBDigjH7zV001m3TA7qp9i0yRVVzecUu73OHZUjO+Rf0pzjJ4JnaYEHm+G1kEGlWf
 X9WK4+9Co9ZGrCRIvvSCEdpZ9M8SFLkQBdRnhZrh83bU1e92xfavqHf+cqOKFa8b7M
 0+O43B9loL42W6QMvk9HXoWdyHNcjFPQkQd8FsP96tLqBSgNRwftGh66K2DF5+Y9mf
 lAihIbxywPOCKCi5CtZbUBq5FjInjHYd9viaMvER71BeP6GEw8PAD6oQHeTWPsowsK
 UicekGaXj4H0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/27] drm/panthor: Add AM_SYSTEM platform driver
To: "Karunika Choo" <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260922204535.2850094-12-karunika.choo@arm.com>
References: <20260922204535.2850094-1-karunika.choo@arm.com>
 <20260922204535.2850094-12-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 20:59:08 +0000
Message-Id: <20260922205909.5648C1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] gpu: out-of-bounds 64-bit access on 32-bit AM_SYS_IRQ registers
- [High] pm: missing clock re-enablement in panthor_system_suspend() error =
path
- [Medium] driver: missing MODULE_DEVICE_TABLE prevents module autoloading
- [Medium] pm: missing hibernation callbacks in panthor_system_pm_ops
--

commit c920f013092a669426d1524348fe769140c7f85d
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Add AM_SYSTEM platform driver

This commit introduces a small AM_SYSTEM platform driver for Mali v15 AM
systems. It provides GPU-wide control, managing shared clock and regulator
resources, and performs the initial GPU reset sequence during probe.

> diff --git a/drivers/gpu/drm/panthor/system/panthor_system_drv.c b/driver=
s/gpu/drm/panthor/system/panthor_system_drv.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/panthor/system/panthor_system_drv.c
[ ... ]
> +static int __panthor_system_reset(struct panthor_system *sdev, u32 cmd)
> +{
> +	u64 val;
> +
> +	/* Clear stale RESET_COMPLETED IRQs before issuing reset */
> +	gpu_write64(sdev->iomem, AM_SYS_IRQ_CLEAR, AM_SYS_IRQ_RESET_COMPLETED);

[Severity: High]
Does this code perform an out-of-bounds access? The AM_SYS_IRQ registers
such as AM_SYS_IRQ_CLEAR (at 0x4C) appear to be 32-bit registers. Using
gpu_write64 splits the access across two 32-bit registers, which might
clobber the adjacent register at 0x50 with the upper 32 bits.

> +
> +	gpu_write(sdev->iomem, AM_SYS_COMMAND, cmd);
> +
> +	return read_poll_timeout(gpu_read64, val,
> +				 (val & AM_SYS_IRQ_RESET_COMPLETED),
> +				 AM_SYS_RESET_SLEEP_US, AM_RESET_TIMEOUT_US, false,
> +				 sdev->iomem, AM_SYS_IRQ_RAWSTAT);

[Severity: High]
Can this similarly cause unintended side-effects? AM_SYS_IRQ_RAWSTAT (at
0x40) is also a 32-bit register. Using gpu_read64 will read from both
0x40 and 0x44, which might not be safe for hardware registers.

> +}
> +
> +static int panthor_system_reset(struct panthor_system *sdev)
> +{
> +	int ret;
> +
> +	ret =3D __panthor_system_reset(sdev, AM_SYS_CMD_SOFT_RESET);
> +	if (ret) {
> +		dev_err(sdev->dev, "SOFT_RESET failed, attempting HARD_RESET");
> +
> +		ret =3D __panthor_system_reset(sdev, AM_SYS_CMD_HARD_RESET);
> +		if (ret) {
> +			dev_err(sdev->dev, "HARD_RESET failed");
> +			return -EIO;
> +		}
> +	}
> +
> +	gpu_write64(sdev->iomem, AM_SYS_IRQ_CLEAR, AM_SYS_IRQ_RESET_COMPLETED);

[Severity: High]
As mentioned above, should this use the 32-bit gpu_write instead of
gpu_write64 to avoid clobbering the register at 0x50?

> +
> +	return 0;
> +}
> +
> +static int panthor_system_suspend(struct device *dev)
> +{
> +	struct panthor_system *sdev =3D dev_get_drvdata(dev);
> +
> +	panthor_system_clk_suspend(sdev);
> +	return panthor_system_regulator_suspend(sdev);

[Severity: High]
What happens if the regulator suspension fails? The function will return
the error directly, but the clock has already been suspended.=20

The PM core might interpret the error to mean the device is still in the
RPM_ACTIVE state, but the hardware is physically unclocked. Could this
cause bus faults or system crashes on subsequent accesses?=20

Should the clock be re-enabled in the error path?

> +}
[ ... ]
> +static const struct dev_pm_ops panthor_system_pm_ops =3D {
> +	.suspend =3D pm_runtime_force_suspend,
> +	.resume =3D pm_runtime_force_resume,
> +	.runtime_suspend =3D panthor_system_suspend,
> +	.runtime_resume =3D panthor_system_resume,
> +};

[Severity: Medium]
Does this code handle hibernation correctly? The panthor_system_pm_ops
structure manually assigns .suspend and .resume but leaves the hibernation
callbacks (.freeze, .thaw, .poweroff, .restore) undefined.=20

During system hibernation or hybrid sleep, the PM core might skip freezing
or restoring the device. Should this use DEFINE_RUNTIME_DEV_PM_OPS or
SYSTEM_SLEEP_PM_OPS to wire all required sleep callbacks?

> +
> +static const struct of_device_id panthor_system_dt_match[] =3D {
> +	{ .compatible =3D "arm,mali-gen5-am-system" },
> +	{}
> +};

[Severity: Medium]
Is the MODULE_DEVICE_TABLE declaration missing here? Without exporting
the match table via MODULE_DEVICE_TABLE(of, panthor_system_dt_match),
the module will not have the necessary aliases generated, which prevents
udev from automatically loading the module when the compatible hardware
is detected.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204535.2850=
094-1-karunika.choo@arm.com?part=3D11
