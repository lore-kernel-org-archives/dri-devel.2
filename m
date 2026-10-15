Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6F5CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:11:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE5FB112195;
	Thu, 15 Oct 2026 08:11:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9920F112173
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:11:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7207B6020C;
 Thu, 15 Oct 2026 08:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2CE01F000C5;
 Thu, 15 Oct 2026 08:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792051871;
 bh=mnWOUDkQLV3Av4+g55vLFJlXne4ByhZDpLd9WR/Ui/k=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=I4ZZkk6ERm3d5XGJh24T3znZBA8Br68VNaTztrQoYcxY+9ztRtoVZ1nYU8qmEZ8jy
 mqLumGBrFPtB1kRgl0G77I3m1G/Wl0qBwlvCMzyj+ft5LM0TnGkO2Q+YizYvZseV4B
 W1R0pqgPEMQ3NK9KMbNOEOSvF2WA8doo8Qu/cO4DF3AAFg0yxEiptOULULmo8bz7x7
 GcOoD9EZaF5+D46ZJHvBjTvz5rZp/cZjnApedXcJ0ugnxoEteeZ1CZak/j/0XVhFwA
 +4dmW58KCFCBDDHv7lh2Mf2FzrqNAh7hlegmgS85ITFdgd27g1JQOIrLH5+0aXFkYN
 YtVJ2UF8q5WPA==
Message-ID: <sashiko-outbox-172448@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/radeon: retry UVD v1 init on failure after resume
To: ukrainer8 <kolomiiec@gmail.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261013175753.37344-1-kolomiiec@gmail.com>
References: <20261013175753.37344-1-kolomiiec@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 08:11:10 +0000
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
- [High] drm/radeon: system hang due to unclocked UVD register access on cl=
ock setup failure
--

commit 9840a4a45eacb2033c0f3f3ceb29f75910196145
Author: ukrainer8 <kolomiiec@gmail.com>
Subject: drm/radeon: retry UVD v1 init on failure after resume

This commit introduces a retry loop for UVD v1 initialization during resume,
as the ring test can sometimes fail due to racing with hardware. On failure,
it stops UVD, waits 20ms, and retries the initialization steps up to 3 time=
s.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1867
Link: https://bugs.launchpad.net/bugs/1865130

> --- a/drivers/gpu/drm/radeon/uvd_v1_0.c
> +++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
> @@ -158,24 +158,45 @@ int uvd_v1_0_init(struct radeon_device *rdev)
>  {
>  	struct radeon_ring *ring =3D &rdev->ring[R600_RING_TYPE_UVD_INDEX];
>  	uint32_t tmp;
> -	int r;
> +	int r, retry;
> +
> +	/* after resume the first ring test can race with the hardware; retry */
> +	for (retry =3D 0; retry < 3; retry++) {
> +		/* raise clocks while booting up the VCPU */
> +		if (rdev->family < CHIP_RV740)
> +			r =3D radeon_set_uvd_clocks(rdev, 10000, 10000);
> +		else
> +			r =3D radeon_set_uvd_clocks(rdev, 53300, 40000);
> +		if (r)
> +			drm_warn(&rdev->ddev, "radeon: raising UVD clocks failed (%d), attemp=
t %d\n",
> +				 r, retry + 1);

[ ... ]

> +		if (!r)
> +			break;
> =20
> -	ring->ready =3D true;
> -	r =3D radeon_ring_test(rdev, R600_RING_TYPE_UVD_INDEX, ring);
> -	if (r) {
> -		ring->ready =3D false;
> -		goto done;
> +		uvd_v1_0_stop(rdev);
                ^^^^^^^^^^^^^^^^^^^
[Severity: High]
Is it safe to call uvd_v1_0_stop() when radeon_set_uvd_clocks() fails?

If clock setup fails, r is non-zero, and the loop bypasses the break
condition to unconditionally call uvd_v1_0_stop().

This function performs MMIO writes to UVD registers like UVD_RBC_RB_CNTL:

drivers/gpu/drm/radeon/uvd_v1_0.c:uvd_v1_0_stop() {
	/* force RBC into idle state */
	WREG32(UVD_RBC_RB_CNTL, 0x11010101);
    ...
}

Accessing these registers when the UVD IP block is unclocked can cause a PCI
bus master abort and lead to a hard system hang. Should there be a check to
ensure clocks are successfully raised before attempting to stop the hardwar=
e?

> +		if (retry < 2)
> +			mdelay(20);
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013175753.3734=
4-1-kolomiiec@gmail.com?part=3D1
