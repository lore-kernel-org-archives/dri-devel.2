Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98054606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emoPdwvk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE66F10EBDD;
	Fri, 13 Nov 2026 01:34:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E12F10EBDD
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:34:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AED0460D2C;
 Fri, 13 Nov 2026 01:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392071F000C4;
 Fri, 13 Nov 2026 01:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794533684;
 bh=G5cPLHOu/smKxDh4BisWUuxZ6D1fTrgjFUJHvQzy3hQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=emoPdwvkLBONAGCp2qv4dSeBe6bs+xomGXwKneQ24hq8oV3bmjOrNTOoDvdbR5Q5+
 u8vCt0ZR/9gsLJq6keG3/FiXe8MD7T8Kye2RbAJUAnB+VKx9l3RM34GL42D+xVxXPT
 OwE8SYdCcYbFHvLy0dpgvC4qFR5JYUsHo11hoRQGAnyRYjGw9g7awh5uebrWkStGKk
 b4sNLb/OMP9hBeGjLd4/9E2SIkkbAg1jY7TJQB85z+n3rmtWR1RsUHooPMQ3a/WtI+
 2xrWuIeYRLjg62fOhefsgzYMTiQrDl+WTeAZN6F2IWogicTcgG1uleIUx0mUZe8A42
 ZvdiJUkkxXDQg==
Message-ID: <sashiko-outbox-212066@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/12] arm64: dts: qcom: sm6350-lena: Enable PM7250B
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-pdx213-upstream-3-v4-7-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-7-4b01c50a821c@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:34:43 +0000
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
- [High] arm64: dts: qcom: Signed-off-by trailer uses handle instead of
  real name
--

commit 77c2a693eb35ea890a4be634ad96dc8d86e34270
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Enable PM7250B
>
> Enable PM7250B and some components on it for the Xperia 10 III.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
Documentation/process/submitting-patches.rst requires a known real human
name in the Signed-off-by trailer and Author header rather than a handle or
pseudonym, as required by the Developer's Certificate of Origin. Could this
be updated to use a real name?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pdx213-ups=
tream-3-v4-0-4b01c50a821c@erebion.eu?part=3D7
