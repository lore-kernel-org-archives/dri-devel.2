Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF51ECA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B5E10EAA0;
	Wed,  7 Oct 2026 10:38:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EmhTfLOa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630E310E620
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 10:38:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E76540175;
 Wed,  7 Oct 2026 10:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60901F0089B;
 Wed,  7 Oct 2026 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791369512;
 bh=51/I6UasrxXsjSjZf/L5+Qcf+I23zh6koE+gEtHZSic=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EmhTfLOaHY3wrON3yIVtbQPTzBCnnoXmxWKitYpH0C0PY6ohea9tqMx4tPB6a8w3N
 buzKk1ihCc0vS1JoblBdvfyUJX3UfbahpN5WB+IYCkDumNWC7idZ0/u5cf1rVZZt92
 SjobDCeBzMeCu3WRmIC8CB66aHZqxq8csbD+JeaGKBGT3Amw5aI5YP4s3hyhuX3uGq
 UXnXDoVVCdcdL2loEkbu3NMkX/UgVhN3QXAt4zmafN6U/XPz5H5G9x0FlPwT5C6JRJ
 IFK1eZzl5Q4caZ5f4XygCZYoznlJvC/2TQ5TCjigMx1D7/KnIGB9Z+o9gmBDIZV/eP
 PlNg5tQiy2ITg==
Message-ID: <sashiko-outbox-162864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling
To: "Andrzej Kacprowski" <andrzej.kacprowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261007102414.2661045-1-andrzej.kacprowski@linux.intel.com>
References: <20261007102414.2661045-1-andrzej.kacprowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:38:31 +0000
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
- [High] accel/ivpu: IRQ disable depth leak in FW_TEST mode due to unbalanc=
ed disable_irq()
--

commit 03c00af9f26af13756e29777951597b1aedc577d
Author: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

accel/ivpu: Improve IVPU_TEST_MODE_FW_TEST handling

When driver is operating in IVPU_TEST_MODE_FW_TEST debug mode
it should boot the firmware, but skip communication with
the firmware. There is no need to enable interrupts or send messages.
The output of the firmware test will be available in the
firmware log.

> diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
> index 647684219e9d3..d66abf645e7b9 100644
> --- a/drivers/accel/ivpu/ivpu_drv.c
> +++ b/drivers/accel/ivpu/ivpu_drv.c

[ ... ]

> @@ -487,6 +484,9 @@ int ivpu_boot(struct ivpu_device *vdev)
>  		return ret;
>  	}
> =20
> +	if (ivpu_test_mode & IVPU_TEST_MODE_FW_TEST)
> +		return 0;
> +

[Severity: High]
Does this early return cause an IRQ disable depth leak?

Since ivpu_boot() skips the call to enable_irq() when IVPU_TEST_MODE_FW_TEST
is enabled, it breaks the enable/disable symmetry.

Later, during teardown paths like ivpu_prepare_for_reset(), disable_irq()
is called unconditionally:

drivers/accel/ivpu/ivpu_drv.c:ivpu_prepare_for_reset() {
    ...
    disable_irq(vdev->irq);
    ...
}

Calling disable_irq() without a matching enable_irq() increments the disable
depth on each suspend/resume cycle. If the user dynamically disables FW_TEST
mode via sysfs, subsequent enable_irq() calls will only decrement the
accumulated depth by 1, leaving the physical interrupt permanently disabled.

>  	ret =3D ivpu_wait_for_ready(vdev);
>  	if (ret) {
>  		ivpu_err(vdev, "Failed to boot the firmware: %d\n", ret);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007102414.2661=
045-1-andrzej.kacprowski@linux.intel.com?part=3D1
