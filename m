Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AE5606A33D
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgpy95vn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C1510F4B3;
	Mon, 16 Nov 2026 23:03:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E4C10F4D3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:03:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 131C262574;
 Mon, 16 Nov 2026 23:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809951F000C5;
 Mon, 16 Nov 2026 23:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794870181;
 bh=wpk3Ypurmggg9iK2k6sIEmjNtTljWEYjQF8mHG4sbMY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lgpy95vnlFf7Mbye8LpOyA5jYF+ZFrHaWYRHrwfcCvhH3vNfqj4s4VlwraS2rNXph
 taKnb9/I8oUpN9bolMqgHyXeLSyDjGTkO3N653sWI0VQ2xvut3tWs+06JNJ+NyDUbU
 BLu9wi/y+bUdKgVs/5VQuKrnliKWjid38qNS1W00MddZ07hJSPzyFNSJjWhdkNPzYz
 TS/jfoKOEKR7o7oH3oONwht6ci8g5p+mxy6aeOkmcnzQkhEy3qOq3B5gq1TkB3hR2f
 jdqHv55nWDOKTfUFyCHkFMcaiDRfzH/ROvZl2TAiw4K1Mv1UCgIr4O4B991Z8dUH83
 OEYI6hFF6/3sA==
Message-ID: <sashiko-outbox-217839@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/12] arm64: dts: qcom: sm6350-lena: Add PM7250B
 thermals
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-pdx213-upstream-3-v5-9-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-9-7318a19806eb@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:03:01 +0000
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
- [High] arm64: dts: qcom: handle used instead of real name in
  Signed-off-by trailer
--

commit cb7d77f20d3e8fe16d92844a1db347a543c4c968
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Add PM7250B thermals
>
> Configure the thermals for the chg-skin-thermal and conn-therm thermistor=
s connected to
> PM7250B.
>
> The trip points can really only be considered as placeholders, more
> configuration with cooling etc. can be added later.
>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
The Author header and Signed-off-by trailer use a handle ("erebion")
instead of a full real name.  Under the Developer's Certificate of Origin
in Documentation/process/submitting-patches.rst, patches must be signed
off using a known identity (a real name, not a pseudonym or handle).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-pdx213-ups=
tream-3-v5-0-7318a19806eb@erebion.eu?part=3D9
