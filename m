Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFEF606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIkoJpqD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2358110E12E;
	Tue,  3 Nov 2026 16:02:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4AF10E12E
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 16:02:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FDDB4061D;
 Tue,  3 Nov 2026 16:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DC01F000C1;
 Tue,  3 Nov 2026 16:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793721729;
 bh=1nfdoyXYnctxGNCE2Ss/rlfo9RRJiLI3UzJUYs04hMc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mIkoJpqD5rdbNJFjfKkQImVXK7sybSTfms5UJ68Ls9xhNcw3jMU2zamxiClH1CXyf
 u6Ll8Oh5qlNz2GOZYq583Ga8OkAMmKNLGw4iBBGxK31yP6JZ6X1YmYpy2YC4hiuvEU
 MjqnLDjx5qmBT2NG8H3Ob7cv76pTh5ndRs/RVUORW28GRmMnt3CVE7SfeW9AvqVpOc
 nfxxcfanJRsa8wBPm3incF5VaG2ySA2HfDeIn++U/DHDcHswlFA+zGMcppsNiR8+G4
 GFKO4Eifdg5OFdsdH4cP+EmfOYjzAuqaI75uDmKNaDpIpqKWSXZGxKjCU996dqM5Z8
 9ajkLnGVPwfJg==
Message-ID: <sashiko-outbox-195688@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/3] media: i2c: ov13b10: add an I2C device ID table
To: "Seifelden Abdelmonem" <saif.elden.hatim@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261103155313.114347-2-saif.elden.hatim@gmail.com>
References: <20261103155313.114347-1-saif.elden.hatim@gmail.com>
 <20261103155313.114347-2-saif.elden.hatim@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:02:08 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] media: i2c: ov13b10: positional initializer used in ov13b10_i2c_ids
--

commit 21e45a243d633457ccb952eaf0648a9a4b43242c
Author: Seifelden Abdelmonem <saif.elden.hatim@gmail.com>

media: i2c: ov13b10: add an I2C device ID table

This commit adds an I2C device ID table to the ov13b10 driver so that it
can bind to I2C clients instantiated by name without an ACPI companion,
such as on AMD ISP4 platforms.

> diff --git a/drivers/media/i2c/ov13b10.c b/drivers/media/i2c/ov13b10.c
> index 242a958341267..d33fb70328946 100644
> --- a/drivers/media/i2c/ov13b10.c
> +++ b/drivers/media/i2c/ov13b10.c
> @@ -1706,6 +1706,12 @@ static const struct acpi_device_id ov13b10_acpi_id=
s[] =3D {
>  MODULE_DEVICE_TABLE(acpi, ov13b10_acpi_ids);
>  #endif
> =20
> +static const struct i2c_device_id ov13b10_i2c_ids[] =3D {
> +	{ "ov13b10" },

[Severity: Low]
This isn't a bug, but should the new entry in ov13b10_i2c_ids in
drivers/media/i2c/ov13b10.c use a named initializer ({ .name =3D "ov13b10" =
})
instead of a positional initializer to follow I2C subsystem conventions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155313.1143=
47-1-saif.elden.hatim@gmail.com?part=3D1
