Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF9606A880
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPijFNvz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0933710F2FF;
	Mon, 16 Nov 2026 23:02:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0221310F2FF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:02:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4256F628E0;
 Mon, 16 Nov 2026 23:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E421F000C4;
 Mon, 16 Nov 2026 23:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794870153;
 bh=f3o26bIzfyne16hL8JnKeMhCi5MH3p/6srBSWEJzAhg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RPijFNvz1K2MUzLKGrPdRh0Fe0yA4j0QJdazTblb2lHDwZVh/bPVNCW+V/YEWSzRj
 uID6jUEgLOi+bovlXyus0RYTYLqFROesu6dNnl6Jm/+nHY0MiLc9YsJfZS6uabqFg3
 7/aTOLSYzV1Mn8SF1WNKu/rCRUg+O+pryNE7E/3nEyj+ko2ji/58pNceudTS6hABIJ
 h8lJrqcEQeu7ogTvFJaK3AHTB2iK8fo6yLk2JosWyKjx0v/oQrmXzKwMS5fF9IXM2G
 M9x+apwoUH7wANTtmkx5mexKY3iW6Cmx9mCkBJPQsLiPjDQlPAW0XNK7SSIYB9FHHL
 1UWxMlnKblB5A==
Message-ID: <sashiko-outbox-217837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/12] arm64: dts: qcom: sm6350-lena: Add PM6150L
 thermals
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-pdx213-upstream-3-v5-11-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-11-7318a19806eb@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:02:32 +0000
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] arm64: dts: qcom: sm6350-lena: handle used in Author and
  Signed-off-by
--

commit d20fc6eadec7147c231c438c85d32c1e09b43db8
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Add PM6150L thermals
>
> Configure the thermals for the PA_THERM1, MSM_THERM, PA_THERM0,
> CAM_FLASH_THERM and QUIET_THERM thermistors connected to
> PM6150L.
>
> Due to hardware constraints we can only register 4 zones with
> pm6150l_adc_tm, the other 2 we can register via generic-adc-thermal.
>
> RFC_CAM_THERM is intentionally omitted for now and will have to be
> added once it is clear how it should be added.
>
> The trip points can really only be considered as placeholders, more
> configuration with cooling etc. can be added later.
>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
Both the commit Author and the Signed-off-by trailer use the handle
"erebion" instead of a real human name, which does not meet the
Developer's Certificate of Origin requirements in
Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-pdx213-ups=
tream-3-v5-0-7318a19806eb@erebion.eu?part=3D11
