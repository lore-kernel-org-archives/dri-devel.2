Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845A7C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2F8A10EC34;
	Mon, 14 Sep 2026 09:00:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X4+ebFjX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A69C710EC34
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:00:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B1F53601DE;
 Mon, 14 Sep 2026 09:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C53D1F00893;
 Mon, 14 Sep 2026 09:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789376447;
 bh=6Ggf9etN3h3Z8c0+oFo3dZxRiB/oFlfiF6c+oTTDVzM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X4+ebFjXU2tQTnhK5wG9AFk1t9aOiZz/v1s9RBBNuwUicSPTiHpLRFWS+QeLPgp29
 EiaSz9BVbHGWJSlOCwlovRe7hnIiwrvbsKLxItCCQXnt5E1hUq+km7EGN0CKHWIvV7
 U3rnUnuJSzwtV/JDp0AaSuMSOWAB8svovEqgsfbF0VfHcbcyA4rpC0Y/3tQGinc31n
 6gINGMt/UkCliGZqfur7guqx8B1Iv9N6r/d6EuLikDaA8WjpGEVw0WS3ChopP1cXwm
 yFxguYeZEtqD5MJkp0/DTLyXbukL6TzSq7mt07lXVsWxpm2C9k/92abZVBDKvg/9uk
 STPHCC9a2fSnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] accel/ivpu: Move register poll timeouts to
 vdev->timeout
To: "Karol Wachowski" <karol.wachowski@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260914084503.895042-1-karol.wachowski@linux.intel.com>
References: <20260914084503.895042-1-karol.wachowski@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 09:00:46 +0000
Message-Id: <20260914090047.4C53D1F00893@smtp.kernel.org>
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
- [Medium] Assigning -1 to microsecond timeouts in IVPU_TEST_MODE_DISABLE_T=
IMEOUTS creates a finite ~71-minute timeout rather than an infinite wait.
--

commit 73e55519ec65b6a56b9989c4bbb3ea1e656f8c4b
Author: Tomasz Rusinowicz <tomasz.rusinowicz@intel.com>

accel/ivpu: Move register poll timeouts to vdev->timeout
   =20
Use the vdev->timeout structure for register poll timeouts. This allows
adjusting those timeouts depending on the platform type.
For FPGA set MMU timeouts to 10x.

Link: https://lore.kernel.org/dri-devel/20260914082649.891871-1-karol.wacho=
wski@linux.intel.com/T/#u

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
Will this assignment result in a finite 71-minute timeout instead of an
infinite wait?

These timeout fields are passed to REGV_POLL_FLD() later on. For example,
in ivpu_mmu_reg_write_cr0():

    return REGV_POLL_FLD(IVPU_MMU_REG_CR0ACK, VAL, val, vdev->timeout.mmu_r=
eg);

REGV_POLL_FLD() passes this value as a u32 timeout_us parameter down to
read_poll_timeout(). When -1 is cast to u32, it becomes 4294967295.

Unlike wait_event_timeout(), read_poll_timeout() explicitly requires 0 to
wait indefinitely. Passing 4294967295 to read_poll_timeout() means it will
loop for ~71.58 minutes before returning -ETIMEDOUT.

Could we assign 0 to these microsecond timeouts instead when
IVPU_TEST_MODE_DISABLE_TIMEOUTS is active?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914084503.8950=
42-1-karol.wachowski@linux.intel.com?part=3D1
