Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2F606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 05:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXsOf7Ft
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB2710E353;
	Sun, 22 Nov 2026 05:51:03 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2300110E2C8
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 05:50:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F420E600E4;
 Sun, 22 Nov 2026 05:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8367B1F000C4;
 Sun, 22 Nov 2026 05:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795326656;
 bh=XpCuWs9YhEHE4baMXis3OYDoIlVU4dY5vvhiD8CrTRE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TXsOf7Ft1iGykLIl9ekkchzqkADyBTENLOlqpZ6EPQcwp090qhxB5TocvLsmK14zt
 HB1rKdNUS8Kw/bMAL0h97/qEbVPSrEK37VVtUoUYZbwIr6bqj8Ww+KtKc8njXy1wJb
 1wU/Awsn1R1Xd9Es2ChgQJ1PQ9zSQT7KBB/q2m/zUQsPFKGN79/hvEDA1Wqud/v58b
 Y+DMtGnOO3Umcoy6X+SAyQGuMfpDiKcGbjEIzEbXtMN19RY146CpEY6Oumw6GEP89i
 oPnpxscobTOFen/Amq/FE2unCV5c3o8Tvk3YXXTcuoGu8FMmWuVaMHT9JWViS2HdOk
 wXdGk7GMljMXw==
Message-ID: <sashiko-outbox-227746@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/2] drm/tyr: add GPU reset infrastructure
To: =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org
Cc: ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261122-tyr-reset-impl-v9-1-ed42d8f513ec@onurozkan.dev>
References: <20261122-tyr-reset-impl-v9-0-ed42d8f513ec@onurozkan.dev>
 <20261122-tyr-reset-impl-v9-1-ed42d8f513ec@onurozkan.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 05:50:56 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/tyr: prepared clocks leaked on error in
  TyrPlatformDriver::probe()
--

commit 4717fa42d015d47181768a9ad839f18566adf1c5
Author: Onur =C3=96zkan <work@onurozkan.dev>

drm/tyr: add GPU reset infrastructure

This commit adds asynchronous GPU reset handling on a dedicated ordered
workqueue with an SRCU-based hardware access gate, and wires ResetHandle
into TyrDrmRegistrationData.

Link: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/28

> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 557f2ec0a7673..370ab512617c9 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
[ ... ]
> @@ -171,8 +153,11 @@ fn probe<'bound>(
>                  _reg <- unsafe { drm::Registration::new(
>                      pdev.as_ref(),
>                      unreg_dev,
> -                    pin_init!(TyrDrmRegistrationData {
> +                    try_pin_init!(TyrDrmRegistrationData {
>                          pdev,
> +                        // SAFETY: The registration is owned by platform=
 driver data,
> +                        // so reset work is drained before borrowed data=
 expires.
> +                        reset <- reset::ResetHandle::new(pdev, iomem.as_=
arc_borrow()),
>                          fw: firmware,
>                          clks <- new_mutex!(Clocks {
>                              core: core_clk,

[Severity: Medium]
Does this leak the prepared and enabled clocks if reset::ResetHandle::new()
fails?

Clk::drop() only calls clk_put(), and disable_unprepare() is only called by
Clocks::drop().  Because core_clk, stacks_clk and coregroup_clk are held as
bare Clk and OptionalClk variables until clks is initialized after reset, a
failure in ResetHandle::new() (or earlier in probe() after prepare_enable())
drops the clocks before Clocks is constructed, leaving them prepared and
enabled and triggering a warning in clk_put().  Wrapping the clocks in
Clocks right after prepare_enable() would ensure they are disabled and
unprepared on any subsequent probe error.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-tyr-reset-=
impl-v9-0-ed42d8f513ec@onurozkan.dev?part=3D1
