Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FA5C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EDDD10E675;
	Tue, 22 Sep 2026 08:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AeySXJ1B";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 651F010E675
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:13:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4FAC760213;
 Tue, 22 Sep 2026 08:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46651F000FF;
 Tue, 22 Sep 2026 08:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790064807;
 bh=1Q8GiMw0LVwZDNcTqiB3kPUJXrqPMft/MvgEzE6X2hs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AeySXJ1BeIhD4sjyMjlTo+2khmUZCN+PvUwWwdFH9Vv3K1hMijE/5fKbXY3YAf7iv
 BfEMp1NLgdvrX9KyHrvwpGOtmazswEsKc0My9nFjRVTrXLfZT/mmjnc2Shat8TQjbs
 AzrQxkL5rwbvsVhR9m0gARdyKnvVR+2aK0uu0EO2I1/rLSe0rg4wiFp8rBpwBWBAoT
 6MJGQD4en1B5emJIrnu2XRZmcnxMa1FiiimK1xEkfSA8GAN5DHQGFqUoA8Rt1fqf+T
 hHj+aL3tQM/O+vCp0Bi48FoYd4uwcrklAfG0272RnyMAod+IXqo+l2BnPMjS09EmwM
 4DNUFeQnictLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/11] accel/rocket: restore the NPU clock boot rate
 before powering the cores down
To: "Igor Paunovic" <royalnet026@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260922080114.44662-9-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
 <20260922080114.44662-9-royalnet026@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:13:26 +0000
Message-Id: <20260922081326.B46651F000FF@smtp.kernel.org>
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
- [High] kexec: missing hardware quiesce and DMA halt in rocket_shutdown
--

commit a41629401e441e7353babe8449ad03dc39082ce0
Author: Igor Paunovic <royalnet026@gmail.com>

accel/rocket: restore the NPU clock boot rate before powering the cores down

This commit records the initial NPU clock rate at probe and restores it dur=
ing
runtime suspend when the last core goes away. It also introduces a shutdown
hook to restore the rate before system reboot or kexec, ensuring the hardwa=
re
does not fault when the domain is subsequently powered back on.

> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
[ ... ]
> +/*
> + * A kexec hands the next kernel whatever rate is set here, and that ker=
nel
> + * will power the islands up before it looks at the clock.
> + */
> +static void rocket_shutdown(struct platform_device *pdev)
> +{
> +	struct rocket_device *rdev =3D dev_get_drvdata(&pdev->dev);
> +	int core;
> +
> +	if (!rdev)
> +		return;
> +
> +	core =3D find_core_for_dev(&pdev->dev);
> +	if (core >=3D 0)
> +		rocket_npu_restore_boot_rate(&rdev->cores[core]);

[Severity: High]
Does this code leave the hardware executing active jobs and performing DMA?

If the system reboots or executes a kexec while the NPU is actively
executing a job, lowering the clock rate here does not halt the hardware or
stop active jobs. Because this is a platform device, there is no automatic
bus-master clearing.

Can this lead to the NPU continuing to perform asynchronous DMA into memory
while the new kernel boots, potentially causing memory corruption or fatal
bus faults?

Should the driver explicitly halt jobs, mask DMA, and reset the core (for
example, via rocket_core_reset) before returning from this shutdown hook?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922080114.4466=
2-1-royalnet026@gmail.com?part=3D8
