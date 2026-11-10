Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C870606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mchR/GdC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C51810E07E;
	Tue, 10 Nov 2026 16:23:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03EF310E07E
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 16:22:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BA576144B;
 Tue, 10 Nov 2026 16:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D141F0089F;
 Tue, 10 Nov 2026 16:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794327773;
 bh=uGDVLR8RgtSJv2JHpEX4P+ELRkFtLFUNawHssyKv93I=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=mchR/GdCRb8T/bMo2wVHP7o6p6KcMPCU6Rwvokjf/xvVwq9Hvy4rHGazauRZ/9czV
 yPfX1CtA5bFdrOSdvctteUJtDoc9dhtOGApgq9r9dAJR77ysvMmWwxbPa3nypF/x8z
 oITnC6pBXfI2rwBGqUXXwd67TKk0j6jJtfIRDQWK8an8W8wYFUyunXUz0Ir91A8BT+
 vTG5zAWkoj0QJkukbyiCvIdHv/RFXD4TOEDdyjW1ucejvGKDKDeNVAxVnZEymbkG8D
 Nf4c0ApDNWVK3fR9gQJn0YFMchVwg7kxm9IAACp6ki1/+tImHWgo14qaYtl5YH2jrE
 +bRwDoNL237vQ==
Message-ID: <sashiko-outbox-207359@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 28/28] drm/panthor: Reset partitions before starting
 arbitration
To: "Karunika Choo" <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261110153907.3241978-29-karunika.choo@arm.com>
References: <20261110153907.3241978-1-karunika.choo@arm.com>
 <20261110153907.3241978-29-karunika.choo@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 16:22:52 +0000
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
- [Medium] drm/panthor: adev->pc[i] left set on partition_ensure_reset()
  failure
--

commit 872e2f2e631e5b4428bb12ac09aefb750b611c43
Author: Karunika Choo <karunika.choo@arm.com>

drm/panthor: Reset partitions before starting arbitration

This commit ensures each partition is brought into the RESET state with
interrupts masked during partition control initialization before starting
arbitration.

> diff --git a/drivers/gpu/drm/panthor/arbitration/panthor_partition_contro=
l.c b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
> index 3b472403f49d1..2c0f8dc0b3bfb 100644
> --- a/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
> +++ b/drivers/gpu/drm/panthor/arbitration/panthor_partition_control.c
[ ... ]
> @@ -429,6 +479,10 @@ static int partition_control_init(struct panthor_arb=
itration *adev, int i)
> =20
>  	adev->pc[i] =3D pc;
> =20
> +	ret =3D partition_ensure_reset(pc);
> +	if (ret)
> +		return ret;

[Severity: Medium]
Should adev->pc[i] be assigned only after partition_ensure_reset()
succeeds?

When partition_ensure_reset() fails, panthor_arbitration_probe() unwinds
via panthor_partition_control_term(), which iterates over non-NULL
adev->pc[i] entries and runs window_close() and partition_state_wait() on
the partition that just failed reset recovery, triggering WARN_ON() and
an extra 5-second timeout.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110153907.3241=
978-1-karunika.choo@arm.com?part=3D28
