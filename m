Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE495606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MrENpHxa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DCB10F154;
	Mon, 16 Nov 2026 22:56:55 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFDE610F48A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:56:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6170260E7B;
 Mon, 16 Nov 2026 22:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFF61F000C4;
 Mon, 16 Nov 2026 22:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794869808;
 bh=06M6HxmxXCU1LMfcTdMASF41o20ftyzynlk79luknW4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MrENpHxaFcwU+n0h7tqUu0qZFVtOIsBUcX1Ea4QTaL/BsZ00QZqYAYNK5aIBa1+ju
 u3roa4BpGdG7cafsQ/gq32I127morF8CzQTj5vKuVGwf6W9FideS+BrL5JjRQmVw/y
 aGY1hB5YfygPMwpYPxSFwD3/lTpBY/q3fnMKWJ4F7MprL6Y85EuWHdgwBKgBS44m8a
 /e3yWB5bMY1/uMvxhYxz2Pt0mg5f3Si0FNIx7JyT8r4Y6cVQVVsEO0urMVh2fCz839
 Yz4ezoUpu1iI0qgc7Gu+mOACxPFIr8r2f4gYSlaHL2biRZ/0huiVf03Ux2F7MLNBND
 9bDjfw0P0ZUew==
Message-ID: <sashiko-outbox-217826@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/12] arm64: dts: qcom: sm6350-lena: Enable ADSP,
 CDSP, IPA & MPSS
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-pdx213-upstream-3-v5-4-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-4-7318a19806eb@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 22:56:47 +0000
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
- [High] arm64: dts: qcom: Signed-off-by uses handle erebion instead of
  real name
--

commit 1d93b9305fce0e29369cefb160a67dae64e8d0d8
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP, IPA & MPSS
>
> Enable the ADSP, CDSP, IPA and MPSS (Modem) nodes for the Xperia 10 III.
>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
The Author and Signed-off-by lines use the handle "erebion" rather than a
real name, which does not meet the Developer's Certificate of Origin
requirements in Documentation/process/submitting-patches.rst.  Could this
be updated to use a full legal name?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-pdx213-ups=
tream-3-v5-0-7318a19806eb@erebion.eu?part=3D4
