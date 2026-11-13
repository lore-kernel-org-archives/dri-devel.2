Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C6606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6oMxvgW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECBF910E72A;
	Fri, 13 Nov 2026 01:34:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4280910E72A
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:33:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 127774470E;
 Fri, 13 Nov 2026 01:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAEA81F000C4;
 Fri, 13 Nov 2026 01:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794533638;
 bh=Uoh7dg63E82q3+ebfIK3PvhxV0FtQcqWOF0pfPzYoKU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V6oMxvgWo1wiRe/SgBcikLS9TKANr4oioDsz88VwmNTKSikFNG4JT9zalmhbOlVn3
 IiYzzEd+BL+he9ebeFnpSbRKKJR8j0hnnuq1erTQ4K6+vmdVRChNO8DpWCeEpyyMr4
 cr83uvpypF23vHC9HGEQPhnv25sUOU4rPBBMoAwsVMJ/6gHy4DmwerM0S3oy/N+8tM
 MrXYtoVOuOGfYQWh7O/tTcY3jtsZglmaulZZKw6q0hZUoPnMVSWyN3N/UvllQVDkpX
 g37hHpWBdr20GemPE3NZ1NQYt+l3eFcwo7Gadc7MdfT4Mg+cbJo9tACoWTjXagAB96
 gkJcSEXdP1SlA==
Message-ID: <sashiko-outbox-212064@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/12] arm64: dts: qcom: sm6350-lena: Add PM7250B
 thermals
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-pdx213-upstream-3-v4-9-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-9-4b01c50a821c@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:33:57 +0000
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

commit 35567a569045cf43924fdde8c95265a9820a48bb
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
Should the Author header and Signed-off-by trailer use a real name instead =
of
the handle "erebion"?  Documentation/process/submitting-patches.rst requires
a real human name for the Developer's Certificate of Origin and does not
allow pseudonyms or handles.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pdx213-ups=
tream-3-v4-0-4b01c50a821c@erebion.eu?part=3D9
