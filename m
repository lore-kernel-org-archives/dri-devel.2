Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D72C79F82
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 00:57:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0242A10FB65;
	Sat,  5 Sep 2026 00:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k3RoQB3d";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73C710FB65
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:57:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A40D260209
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 00:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB221F00A3D;
 Sat,  5 Sep 2026 00:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788569855;
 bh=FzoxEqEq9VdIEy1CfplSp52Ho0UiaKidYhhcEsxpXvs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k3RoQB3dv26UW5xy7teeFRPgaHtymYFAAE6RI+Pp0yhRVHCQNwAfWwvoyREl0tqgz
 /REs0Vqz8rqD0SlNR5xOFMglp9BmZCRQch2dIdMDqZm+S15Rvy4CUrMl2Wfhiu6kgt
 CbO82HSSbx5mWEgg037rkXFjb/SNd3avzOlEEfnngEGVRb7mepzoSbWo6GDKJ0rSyB
 bpBJahscbUAjOow24bTG/RfvLJLRZYFq1/cnvtW1FQ66EoKNAHjz7pcUS0ZK6ED57L
 Zm+foXlXBSQpkgEKTx5MKfRoVL7UmhoL9eIubu7OVEolsuYcwA9QtabUPEhpzevcAu
 o8QQfz/oYtaOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/19] accel: ethosu: Suspend after initialization
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904-ethosu-fixes-v2-1-3767738756a4@kernel.org>
References: <20260904-ethosu-fixes-v2-0-3767738756a4@kernel.org>
 <20260904-ethosu-fixes-v2-1-3767738756a4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:57:34 +0000
Message-Id: <20260905005735.3AB221F00A3D@smtp.kernel.org>
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

Pre-existing issues:
- [High] IRQ handler accesses hardware registers while device may be suspen=
ded.
--

commit db83f58315d24bc892c6b008ce7d120f57ecaff1
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Suspend after initialization

The initial runtime-PM reference is held only while initializing the NPU.
Release it synchronously from ethosu_init() after the final hardware
access, before registering the DRM device.

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index 8108622de258f..df76253d01a64 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -338,6 +338,8 @@ static int ethosu_init(struct ethosu_device *ethosude=
v)
>  		 ethosudev->npu_info.sram_size / 1024,
>  		 ethosudev->npu_info.pmu_counters);
> =20
> +	pm_runtime_put_sync_suspend(ethosudev->base.dev);

[Severity: High]
This isn't a bug introduced by this patch, but does putting the device into
an immediate synchronous suspend here expose a vulnerability in the interru=
pt
handler?

Looking at ethosu_job_irq_handler() in drivers/accel/ethosu/ethosu_job.c:

static irqreturn_t ethosu_job_irq_handler(int irq, void *data)
{
	struct ethosu_device *dev =3D data;
	u32 status =3D readl_relaxed(dev->regs + NPU_REG_STATUS);
	...
}

The hardirq handler accesses hardware registers unconditionally without
verifying the device's PM state.

If a spurious interrupt occurs while the device is in the RPM_SUSPENDED
state (where clocks are disabled via ethosu_device_suspend()), could
reading NPU_REG_STATUS cause a Synchronous External Abort?

The PM subsystem guidelines mandate using pm_runtime_get_if_active() in
IRQ handlers to prevent accessing powered-off hardware registers.

> +
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-ethosu-fix=
es-v2-0-3767738756a4@kernel.org?part=3D1
