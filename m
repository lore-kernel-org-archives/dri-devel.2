Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F33ACA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9BDF10E3FA;
	Wed,  7 Oct 2026 16:30:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TMsi2snt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2A3810E3FA
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 16:30:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B4064187A;
 Wed,  7 Oct 2026 16:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E3A31F000FF;
 Wed,  7 Oct 2026 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791390639;
 bh=TrxUyJ+WfSrScHNMWeI4SIXn8SHwIk1so/sbQiBhSZM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TMsi2sntB8G86S/EyXGONlhLriW1jCb/lqWV9HF34LAQoz1l3C5UwnfXUkrpRF/RX
 ADME13bat1l2bYwj3UOAbRY8O3ae5Qf4SDChvZ0xONzm/6+AXj67s173S8uXPNImFy
 sKGlXZiiW+RCkoxfUWukjuGcg2HMKQ+HIy/nxjfj3Do7MZ79d4izBx/3z3In1VhLh8
 k9uE0siCl/6u+ANm1t17ePrDTZz/koU3Qg3jlx3wvVWq3a3tWI7xt5rqnxP7aOWvaw
 rZpJvWSenynFnjHVarvE0Ldf+Q8yofFnnLnVRon0DToPkhgAwyr9g8/sPruu/th+BI
 nq1dcPqUKO9FQ==
Message-ID: <sashiko-outbox-163195@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling
To: "Andrzej Kacprowski" <andrzej.kacprowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261007161323.2737682-1-andrzej.kacprowski@linux.intel.com>
References: <20261007161323.2737682-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 16:30:38 +0000
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
- [High] accel/ivpu: PM runtime autosuspend loop in FW_TEST mode
--

commit e12f731149f041dc1d9f11e61a8bd4c155f14399
Author: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling

This commit modifies ivpu_boot() to exit early when IVPU_TEST_MODE_FW_TEST
is enabled, bypassing post-boot initialization. This avoids sending an IPC
message that was timing out since the firmware boot is not fully waited for
in this mode.

> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 0f215392d42de..fee1dde0b7467 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c
> @@ -498,6 +498,9 @@ int ivpu_boot(struct ivpu_device *vdev)
>  	ivpu_ipc_enable(vdev);
> =20
>  	if (!ivpu_fw_is_warm_boot(vdev)) {
> +		if (ivpu_test_mode & IVPU_TEST_MODE_FW_TEST)
> +			return 0;
> +

[Severity: High]
Does this early return shift the IPC timeout into the runtime PM autosuspend
path?

If driver probe succeeds because of this early return, PM runtime autosuspe=
nd
will be enabled. After the autosuspend delay, won't
ivpu_pm_runtime_suspend_cb() unconditionally attempt to send an IPC message?

drivers/accel/ivpu/ivpu_pm.c:ivpu_pm_runtime_suspend_cb() {
    ...
	ret_d0i3 =3D ivpu_jsm_pwr_d0i3_enter(vdev);
	if (ret_d0i3)
		ivpu_err(vdev, "Failed to prepare for d0i3: %d\n", ret_d0i3);
    ...
	if (!is_idle || ret_d0i3) {
		ivpu_err(vdev, "Forcing cold boot due to previous errors\n");
		atomic_inc(&vdev->pm->reset_counter);
		ivpu_dev_coredump(vdev);
		ivpu_pm_prepare_cold_boot(vdev);
	}
    ...
}

Since the firmware is unresponsive in IVPU_TEST_MODE_FW_TEST mode, this
IPC message will inevitably time out. Could this lead to an inescapable
background loop of timeouts, coredumps, and resets?

>  		ret =3D ivpu_pm_dct_init(vdev);
>  		if (ret)
>  			goto err_disable_ipc;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007161323.2737=
682-1-andrzej.kacprowski@linux.intel.com?part=3D1
