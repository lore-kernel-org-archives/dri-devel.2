Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD72606A897
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TXeSsEu4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0591A10E6DE;
	Fri, 13 Nov 2026 01:29:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBA4E10E6DE
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:29:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7929A417B0;
 Fri, 13 Nov 2026 01:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7DD1F000C5;
 Fri, 13 Nov 2026 01:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794533381;
 bh=qbsYeeiLbyQOTRSDakpkIbCYrFVqKgt7jDsatt2o3OE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TXeSsEu4BV1Yz/j2nuWNjcC2BzLU5ajQB4ZAJW6nAbTFqlqhwlL8sR8g+2FfOzCDU
 Cf0e4XSgqAdeq710W3QjU6ndvCE8LYjybIHB7RDfH1RQUfFzM2x5DyZoOJUV6cwhZL
 7r9GWkyF9w8rnbwvVzOYmrs33w/MdlaIUuERma/1yOZuCMlY1vNwGCqoWiZn1fC0Oa
 /ZUpwIThDmnCsRK/LTL7jwwoXCCUwEw8mEWosozGNoWpE7Kv7UaO/dwPz0YLhO6Ez/
 nX0+eqTvCs3L9wpZuS567OZH/VOZM3wsHAo31JPXv3ZKY3BirY5TAcujqbkoegPHm1
 6O4i8Skipuw0w==
Message-ID: <sashiko-outbox-212056@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/12] arm64: dts: qcom: sm6350-lena: Enable wifi
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-pdx213-upstream-3-v4-6-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-6-4b01c50a821c@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:29:40 +0000
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
- [High] arm64: dts: qcom: Signed-off-by and Author use handle instead
  of real name
--

commit 24a3b1f3ecac1502767c6ab922369282c14e2622
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Enable wifi
>
> Configure regulators and enable it for the Xperia 10 III
>
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
Both the Author header and the Signed-off-by trailer use the single-word
handle "erebion".  The Developer's Certificate of Origin in
Documentation/process/submitting-patches.rst requires a full real name
rather than a pseudonym or handle, so both fields need to be updated to
use a real name.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pdx213-ups=
tream-3-v4-0-4b01c50a821c@erebion.eu?part=3D6
