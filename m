Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B39D606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMxQlnXy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 792BE10EAB5;
	Mon, 16 Nov 2026 22:56:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437D110EAB5
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:55:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F5AE61178;
 Mon, 16 Nov 2026 22:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D983E1F000C5;
 Mon, 16 Nov 2026 22:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794869749;
 bh=2cFXEzTLFLHVZsm2IQnE4l9oixZDTYOk5uX/pLu7wY8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iMxQlnXyOQ2EkfAhMkKULXTENqkelCdGE9x3EgJtSHre5OT3RID9kUbUa1rTkBwbP
 EM7v+hZ3cQgF+j+78gfO22ogabNJyaozWi0NQdkqeY4Rphnv1GjCrKXDXRvf74Yw8y
 DSZjuVX0fz0Psjci4ol6vGk5ILZqQsvcWMO1p7bcc70XBYBhyDcacAZzzNLVLAZUmX
 6akbMoFhJJOcYDLLY1R3l0vJG4qzpc3b5U1k7di5pCZrQrz9//IfTL7KojMQpZg0Ep
 UouOfTa27NyKMs3LPIjyNBwqHaKfBDp0B8HGW6wykjZB+P/qNrFAU0R8s0ouPcfnEv
 JRYv+rpCYBjtw==
Message-ID: <sashiko-outbox-217823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/12] arm64: dts: qcom: sm6350-lena: rename
 touch-en-regulator
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-pdx213-upstream-3-v5-2-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-2-7318a19806eb@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 22:55:48 +0000
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
- [High] arm64: dts: qcom: single-word handle used in Signed-off-by
  trailer
--

commit 32e61d61a3221dfc85f81717ef77d401f268134b
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: rename touch-en-regulator
>
> rename touch-en-regulator -> regulator-touch-en, to
> keep any future fixed-regulator sorted together
>
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
Could the Author header and Signed-off-by trailer be updated to use a full
real human name instead of the single-word handle "erebion"?  Per
Documentation/process/submitting-patches.rst, the Developer's Certificate
of Origin requires a known real name and does not permit pseudonyms or
handles.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-pdx213-ups=
tream-3-v5-0-7318a19806eb@erebion.eu?part=3D2
