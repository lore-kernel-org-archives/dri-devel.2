Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6945E606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrhOs93A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 992DF10E3D9;
	Mon, 16 Nov 2026 22:55:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0170010EA2B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:55:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B03994153F;
 Mon, 16 Nov 2026 22:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5177E1F000C4;
 Mon, 16 Nov 2026 22:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794869722;
 bh=6ILmD6WJ5SOGZ9tLOSg8rzTcRhAmn9GqK1te8apL6CI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MrhOs93A5dYEPQhPF0rndRJAdi3y2zw4CblfveLXP+xsOTdjq1u7iVPfMV/I5NeCk
 jVhdc+Jn/llPDfXSJ8Iw3ce1/7huVxbADAKaGTxhuEvzbYXtSvp2SR7TWXAvBYjKkj
 2VS7TuMu6NnR0nLqfcpCedo/V6GrYI1XA6d2rmi5azeE6X3g6u5mASHaaNE1jlKibR
 8WNLpmmjS5JYLLhyqzlk+T4ziy6V0/vpgTX/IiJhDSFj1FijUcgMqQ5UD9u0EKB6z0
 ghMnIgTz8PdbDfLt6PaNfgCwEPTSZACjy56n1x12PI9L3NUnLpisuRj9oQaNwvtt9M
 aDVm/x3ocnw4w==
Message-ID: <sashiko-outbox-217820@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/12] arm64: dts: qcom: sm6350-lena: Add flash LED
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-pdx213-upstream-3-v5-1-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-1-7318a19806eb@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 22:55:21 +0000
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
- [High] arm64: dts: qcom: username handle used in Signed-off-by and
  Author fields
--

commit 200bfc01220f58fe7a2271ce6cb6b0cc0d743227
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Add flash LED
>
> Add a node for the camera flash LED found on the Xperia 10 III
>
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
As reported by Bjorn Andersson on v2 [1], the Author and Signed-off-by
fields use the single-word handle "erebion" instead of a real human name,
which does not satisfy the Developer's Certificate of Origin requirements
in Documentation/process/submitting-patches.rst.

[1] https://lore.kernel.org/r/arnF0u2F9ipfnNP-@zenbook

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-pdx213-ups=
tream-3-v5-0-7318a19806eb@erebion.eu?part=3D1
