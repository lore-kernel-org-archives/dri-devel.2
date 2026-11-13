Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6A7606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DbVLUNBM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B449F10E6B3;
	Fri, 13 Nov 2026 01:51:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93BD010E6B3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:51:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 63C9B41849;
 Fri, 13 Nov 2026 01:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188C71F000C4;
 Fri, 13 Nov 2026 01:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794534662;
 bh=novKq1OxOw0oIDwG/zfIOYXbREIwByAud43VwuRJoTs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DbVLUNBMA2PqCqL5bplgH+6OJEno2/Aob5Qj4YHnypW+ZV6OJyzG6Vf1xj+vvv3dC
 JFTVw5UY/U23Yw51VUW2gebtZ4VDvPo8DAPn0VHX8566I4gb4vsRCE/bzmsP5KmfCZ
 ABjK6xS3LDH+9xQ5Pu9fDDn13/nbnTpdg/YrAI9THeJSk9b2HXpDyGXe2Dmn1F6Wnf
 d7xtocI6ovIxwBBYV64KWKsi0yKL7VU9MbXS3mho35zttMRj8bHKCKHiqARKsmF6MA
 ipvuBiHxA+Yg2l5E2X8Y/N7SwzSJMezik78TtiuyO1yQf5nYivnb1S8WIR5V2xMYX+
 LU9daxAVPPYyQ==
Message-ID: <sashiko-outbox-212075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/12] arm64: dts: qcom: sm6350-lena: Enable Bluetooth
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-pdx213-upstream-3-v4-5-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-5-4b01c50a821c@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:51:01 +0000
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

commit a88dbe84a474608356cf7418da893f73d6055164
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Enable Bluetooth
>
> Configure the required regulators for Bluetooth and enable it on the
> Xperia 10 III.
>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
Could the Author header and Signed-off-by trailer use a real full name
instead of the handle "erebion"?  Documentation/process/submitting-patches.=
rst
requires a real human name to certify the Developer's Certificate of Origin.

Also, this isn't a bug, but the commit message says it configures the
regulators for Bluetooth, whereas the PM6350 and PM6150L regulators are
already defined in the board DTS and this patch only references their
phandles in the bluetooth node.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pdx213-ups=
tream-3-v4-0-4b01c50a821c@erebion.eu?part=3D5
