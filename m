Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582B1CA9EBB
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 23:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B468011231E;
	Fri,  9 Oct 2026 23:14:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hkAbjL7J";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 386A211231E
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 23:14:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C72160211;
 Fri,  9 Oct 2026 23:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0B61F000FF;
 Fri,  9 Oct 2026 23:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791587686;
 bh=7YkitWBz1HsBgQxmIof28ZoWZ2SSt6Ty4j9hUZhDX8c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hkAbjL7JduQ1k5Em62kg2DxuVRnTAAO0SjeybUvIzd4la4TkqcjazUfa3AmPL0UMP
 oLGhZMA8kffLCdWQeAbAr1E/C2sXiEtZ9MWmPUM2Ot0zt2pLni0+uNGqe5O1dwVak7
 uTpFJiDmKm5gyhGjwsobH3vDyFIUhvXRbIBza9Ojomn48xVpk5ZcrB5q8xYOuA3a1J
 H9fgf3muq4Eg6xi29VhjOzjUXu+5blMnI2wKIJcS7lNVpqjgIM/4eTG+fM4okRCQhA
 ZR+DGai0/V+Lg9uXlnekNvGV5GWMJQGrFMb90EyvRgddSoFZCzIzEOXI2mdAtOThBj
 XaCUYqfG79dHQ==
Message-ID: <sashiko-outbox-166179@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 17/19] accel/amdxdna: Enable AIE4 firmware logging to
 DRAM
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261009225343.3079074-18-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261009225343.3079074-1-yidong.zhang@amd.com>
 <20261009225343.3079074-18-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 23:14:45 +0000
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
- [High] amdxdna: DMA Use-After-Free of fw_log_buf on hardware start failure
--

commit 399dd24d5b4823ad10e211886f1046c8d43ff630
Author: David Zhang <yidong.zhang@amd.com>

accel/amdxdna: Enable AIE4 firmware logging to DRAM
   =20
This commit allocates a DRAM buffer for firmware logging and configures the
device to use it with a less verbose log level.

> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie=
4_pci.c
> index 7f4238f76bc22..e09d24d85cdfa 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
[ ... ]
> @@ -953,6 +998,8 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
>  	if (ret)
>  		return ret;
> =20
> +	aie4_alloc_fw_log_buffer(xdna->dev_handle);
> +
>  	ret =3D aie4_pf_hw_start(xdna->dev_handle);
>  	if (ret)
>  		goto free_work_buf;
> @@ -960,6 +1007,7 @@ static int aie4_pf_init(struct amdxdna_dev *xdna)
>  	return 0;
> =20
>  free_work_buf:
> +	aie4_free_fw_log_buffer(xdna->dev_handle);

[Severity: High]
Can this lead to a use-after-free of the DMA buffer if the hardware fails to
start?

During aie4_pf_hw_start(), aie4_config_fw() is called which instructs the
firmware to begin asynchronously DMA-ing logs into fw_log_buf.

If a subsequent step in aie4_pf_hw_start() fails (such as
aie4_restore_power_mode() timing out), the error path attempts to stop the
firmware via aie4_fw_stop().

However, if the PSP teardown inside aie_psp_stop() also times out:

aie_psp_stop() {
    ...
    ret =3D psp_exec(psp, reg_vals);
    if (ret)
        drm_err(psp->ddev, "release tmr failed, ret %d", ret);
}

It returns without successfully halting the active firmware. We then reach
this error path in aie4_pf_init() and free fw_log_buf back to the page
allocator.

Does the active firmware continue writing logs into this freed memory?

>  	aie4_free_work_buffer(xdna->dev_handle);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009225343.3079=
074-1-yidong.zhang@amd.com?part=3D17
