Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08556606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I17tR/ta
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B9A10F4BB;
	Mon, 16 Nov 2026 23:01:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 553C210F4AF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:01:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CDAD86300B;
 Mon, 16 Nov 2026 23:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448001F000C9;
 Mon, 16 Nov 2026 23:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794870086;
 bh=8tc6jN4g7OSP88WbM7d+wPupEtt6JwuDiM5fSzoOlE8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I17tR/taHKzrmrXSBN9S2WM2OQzj/g1vNI9Xi338vlQYmgDZOGTEK0eFfD1mQhy5q
 p9GAqnxWWG0i6NN+XbEqx9olsbRJF4nFAk3yXvUd+A6dlY+UCpDdDf+Jk4jb7wwGp8
 KmD9SUo8Dpw3lAUmtr8f2RrKrBQmE3kbcV3HT9sSzQoFqYNjxbJItv4PAbLKg1UnD7
 ReBMaE76c1bUzB9crzwansMa/gTTr6CEt80QM5qH+/qr1Y766N7lgZtEu9VorUKNcZ
 qhOXmICr7z/hPpuO9duQovRHk2JcaoNcdZ1fYZGhZxVsfmkc81zobt40b/AcF5aNVU
 R6KwpH3Xc02QQ==
Message-ID: <sashiko-outbox-217835@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/12] arm64: dts: qcom: sm6350-lena: Enable PMK8350
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-pdx213-upstream-3-v5-8-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-8-7318a19806eb@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:01:25 +0000
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
- [High] arm64: dts: qcom: invalid handle in Signed-off-by trailer
--

commit 653bcdb19432d3b2792a7f5615a893fd67bfe22e
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Enable PMK8350
>
> Configure and enable nodes for PMK8350 on the Xperia 10 III.
>
> The phone has two PMICs which have a PON block, disable the PMK8350
>  PON and keep the PM6350 PON, as only one should be enabled.
>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
Per Documentation/process/submitting-patches.rst, the Developer's
Certificate of Origin requires a real human name in the Author header
and Signed-off-by trailer rather than a single-word handle or username.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-pdx213-ups=
tream-3-v5-0-7318a19806eb@erebion.eu?part=3D8
