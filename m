Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D72606A331
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dg7/Xeet
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7DB010E1C4;
	Mon, 16 Nov 2026 23:11:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C10810E1C4
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:11:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B4936254E;
 Mon, 16 Nov 2026 23:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E842F1F000C4;
 Mon, 16 Nov 2026 23:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794870695;
 bh=k9mH2XB4VJ/aPR76VgexMnLrUk6Rb8O/7a77Qs8WdfA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dg7/Xeet2z+E6jr/Ho8xBqERoLEh2yPrPMoHVgkwNIvgvkDqizM/hXnfFEOxxovtx
 u07g2cJacCjQz46S7vQaAIyR9jx3VFXy66NB4TfUoz5nsdLq3w1xt/V2xyrkF2duwb
 N95pGp0JeG+JA0BIbCx23n2yE9mXbV2fga93Kdl0PtNk+d359qlDxSCySYilIBktN5
 zWX4OeWvd9Y3bE38RrsocsSF+9z4oJOF97h8uj/1sO+RefgYXXf0utf++w4JsulhiU
 PweniA2/9Upa4b9AMdZHpi6kAyq0qX/p1a03OOUKkqXCqAl2fP+3Cxj98zOPpq+fbw
 gB3UXJNjE4BuA==
Message-ID: <sashiko-outbox-217853@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/12] arm64: dts: qcom: sm6350-lena: Enable Bluetooth
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-pdx213-upstream-3-v5-5-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-5-7318a19806eb@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:11:34 +0000
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

commit 6f602bc892584af0dccb910664565f3b596a7794
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Enable Bluetooth
>
> Configure the required regulators for Bluetooth and enable it on the
> Xperia 10 III.
>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
The Author header and Signed-off-by trailer use a single-word handle
("erebion") rather than a full human name, which does not meet the
Developer's Certificate of Origin requirements in
Documentation/process/submitting-patches.rst.

Also, the commit message says it configures the required regulators,
whereas the regulator nodes (pm6350_l11, pm6350_l7, pm6150l_l2, and
pm6150l_l10) are already defined in this file and the patch instead
configures UART1 with its pinctrl states and wires up the bluetooth child
node.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-pdx213-ups=
tream-3-v5-0-7318a19806eb@erebion.eu?part=3D5
