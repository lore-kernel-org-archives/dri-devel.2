Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F634C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 22:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F3510EDD2;
	Tue,  8 Sep 2026 22:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jFwH4Hns";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B885910EDD2
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:19:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8ACD4404D5
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 22:19:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446E21F00A3A;
 Tue,  8 Sep 2026 22:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788905964;
 bh=qEEHYA/Hwv8QN6hVrSHGNsyJUz4u09eozdoEdsERxzQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jFwH4HnsYo5+8WuIdS73EapxtUNrZ0PkJz2c2lVGzxPCVwb4eJglpiLj8AGk4tOQ0
 zGgSz+rJh4leX876Ww/QIcke0qaIREmk/VMUI8IBqa1ix/KQFALNSvLfWo+Oehzzcg
 5O6X4A4pJ0UCbix0yBBNfmzk3D3tI/dVn89YiBh6LT9BrsQ/+t/5K0DRxKSvM1ZkNF
 bmOWpY5saPf0AlxV8Gji23h8ZATjiBF1Alpf2cg7jDgyB0VEHryNLuiHjmCYEPhEf7
 3sAVGI+0ipI+Ac8Pefwzz/QrDdiHZ4aPjNXfA5jaMeGn+7eXRI/QH1GujeHM6w3pWj
 XCqSh8VzlilYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/22] accel: ethosu: Ensure suspended on removal
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908-ethosu-fixes-v3-2-490fe215286f@kernel.org>
References: <20260908-ethosu-fixes-v3-0-490fe215286f@kernel.org>
 <20260908-ethosu-fixes-v3-2-490fe215286f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 22:19:23 +0000
Message-Id: <20260908221924.446E21F00A3A@smtp.kernel.org>
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
- [High] The patch evaluates the return value of `pm_runtime_get_if_active(=
)` as a boolean, which fails to handle the `-EINVAL` error case and causes =
an unbalanced usage counter decrement when Runtime PM is disabled.

Pre-existing issues:
- [High] In `ethosu_perfmon_stop_locked()`, the return value of `pm_runtime=
_get_if_active()` is checked with a boolean NOT operator, misinterpreting t=
he `-EINVAL` error as success, leading to unpowered hardware access and an =
unbalanced PM usage counter.
- [High] The IRQ handler accesses hardware registers without checking the d=
evice's runtime PM state, risking a system crash if clocks are disabled.
--

commit 501f3ec67feb35539595151a43ef4d9ff0c26ca3
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Ensure suspended on removal

If device removal occurs before an auto-suspend timeout occurs, the suspend
is cancelled and the device will be left with clocks running. This patch
makes the remove() callback force a suspend if the device is currently acti=
ve.

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -387,6 +387,10 @@ static void ethosu_remove(struct platform_device *pd=
ev)
> =20
>  	drm_dev_unregister(&ethosudev->base);
>  	ethosu_job_fini(ethosudev);
> +
> +	if (pm_runtime_get_if_active(&pdev->dev))
> +		pm_runtime_put_sync_suspend(&pdev->dev);

[Severity: High]
Does evaluating the return value of pm_runtime_get_if_active() as a boolean
fail to handle the -EINVAL error case?

If Runtime PM is disabled, pm_runtime_get_if_active() returns -EINVAL, which
evaluates to true here. Could this cause an unbalanced usage counter decrem=
ent
that corrupts the device PM state, and potentially power off the device
prematurely?


While reviewing this, I noticed a couple of related pre-existing issues in
the subsystem.

In drivers/accel/ethosu/ethosu_perfmon.c:ethosu_perfmon_stop_locked():

> 	if (!pm_runtime_get_if_active(ethosu->base.dev)) {
> 		ethosu->perfmon_state.active =3D NULL;
> 		return;
> 	}

[Severity: High]
This is a pre-existing issue, but does using a boolean NOT operator on the
return value of pm_runtime_get_if_active() misinterpret the -EINVAL error
as success?

If Runtime PM is disabled, -EINVAL evaluates as non-zero (so !(-EINVAL) is
false), bypassing this abort condition. Could this lead to reading PMU
registers without clocks, causing an asynchronous external abort (bus fault)
that crashes the system, as well as dropping a PM reference that was never
acquired?


In drivers/accel/ethosu/ethosu_job.c:ethosu_job_irq_handler():

> static irqreturn_t ethosu_job_irq_handler(int irq, void *data)
> {
> 	struct ethosu_device *dev =3D data;
> 	u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);

[Severity: High]
This is a pre-existing issue, but does this IRQ handler access hardware
registers without checking the device's runtime PM state?

Any spurious or delayed interrupt firing during the suspended state could
trigger this path. Does unconditionally reading NPU_REG_STATUS upon entry
risk a bus fault and kernel panic if the device clocks are disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-ethosu-fix=
es-v3-0-490fe215286f@kernel.org?part=3D2
