Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9A8C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 08:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C264B10EB84;
	Mon, 14 Sep 2026 08:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Qi0J/t4V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF13B10EB84
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:41:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 136BF6020A;
 Mon, 14 Sep 2026 08:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BCB1F000FF;
 Mon, 14 Sep 2026 08:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789375261;
 bh=kr1SuryfDRuzBx1ibQPd91EIDufogM//0N8p5VfBB5o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qi0J/t4VGk24O1rZLo6QkZzMcTxcLr+XCxh8u19hj3opxgyCPd7r7VgRvAmsLmipK
 7i2Hhu/Nc5U43zKj7psLQElK9+gTKvBEiK2XLsY6Qr/UnowwlqxGIJGyziBelJ72XN
 EBzFldeNgcppP5hxk1Cf2+03re/Xm3SEynwletW+n+KgRK6HULuYuKnhy2+sz6P89X
 gRL2RwMmcPVOAIGab7eZOZ2/yxWw6NF4bf7+D4fa32Wpw0QbOrybHfDZEY6nB/pOdM
 nlzi5RRelo46ShHxfzi3goF53XQbOP/0ADuSAHvcIXHh7jFJO6p+Rkv4J9u07ZRkFF
 IK+2vmZTQiofA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/ivpu: Move register poll timeouts to vdev->timeout
To: "Karol Wachowski" <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914082649.891871-1-karol.wachowski@linux.intel.com>
References: <20260914082649.891871-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 08:41:01 +0000
Message-Id: <20260914084101.95BCB1F000FF@smtp.kernel.org>
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
- [Medium] Setting microsecond poll timeouts to -1 to disable them results =
in a finite 71.5-minute timeout instead of an infinite wait, violating the =
read_poll_timeout API.
--

commit 6c5311f9650a7506bd940962ab4f3fafb765f71e
Author: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>

accel/ivpu: Move register poll timeouts to vdev->timeout

This patch moves the register poll timeouts into the vdev->timeout
structure. This allows the driver to adjust these timeouts based on
platform type, such as increasing MMU timeouts by 10x on FPGA.

[ ... ]

> diff --git a/drivers/accel/ivpu/ivpu_hw.c b/drivers/accel/ivpu/ivpu_hw.c
> index 647dc045c231a..613bcdbc364cc 100644
> --- a/drivers/accel/ivpu/ivpu_hw.c
> +++ b/drivers/accel/ivpu/ivpu_hw.c
> @@ -99,13 +99,19 @@ static void wa_init(struct ivpu_device *vdev)
>  static void timeouts_init(struct ivpu_device *vdev)
>  {
>  	if (ivpu_test_mode & IVPU_TEST_MODE_DISABLE_TIMEOUTS) {
> +		/* in milliseconds */
>  		vdev->timeout.boot =3D -1;
>  		vdev->timeout.jsm =3D -1;
>  		vdev->timeout.tdr =3D -1;
>  		vdev->timeout.inference =3D -1;
>  		vdev->timeout.autosuspend =3D -1;
>  		vdev->timeout.d0i3_entry_msg =3D -1;
> +		/* in microseconds */
> +		vdev->timeout.mmu_reg =3D -1;
> +		vdev->timeout.mmu_queue =3D -1;
> +		vdev->timeout.pwr_island_status =3D -1;

[Severity: Medium]
When initializing the microsecond timeouts in timeouts_init(), is it intend=
ed
to set these fields to -1?

The read_poll_timeout() macro expects a timeout_us value of 0 to indicate
that it should wait indefinitely. Because the timeout_us argument is typica=
lly
handled as an unsigned 32-bit integer, passing -1 results in a value of
0xFFFFFFFF.

Instead of completely disabling the timeout as the
IVPU_TEST_MODE_DISABLE_TIMEOUTS flag implies, wouldn't this result in
read_poll_timeout() calculating a finite deadline of roughly 4294 seconds
(71.5 minutes)?

Should these microsecond timeouts be set to 0 instead of -1 to properly
instruct read_poll_timeout() to wait forever?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914082649.8918=
71-1-karol.wachowski@linux.intel.com?part=3D1
