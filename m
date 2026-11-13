Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE829606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hvkJFuMV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26D5310FCA9;
	Fri, 13 Nov 2026 01:35:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5751123B3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:35:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 390EB40A44;
 Fri, 13 Nov 2026 01:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12A71F000C4;
 Fri, 13 Nov 2026 01:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794533701;
 bh=iuEH0iwZU/W/lcNweviPOVHKVlL3rSG3rdk2Qd+zQXE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hvkJFuMVDeP1FhyHKIpJ/0m6U0wo93y+Sz8xZ9tNBl8GjwB0mIOhQJqhTX1Wu9cwb
 dAi/iwajHd7u+timZhfqv8qf2JuAUr8b47YE8LxcnNA3xmyOO2FYndike5c4difXIa
 kOhmEu00RI51mW2S7Eu2sCLBP+zQapvf8ov9AKNidkN7dBv3CLGXVwwfSZ/S2/6E69
 XTgoNrxbbu1yfNs+aV8fyXUhX/F1/2yCtqywD1mUOs1m6JZQFSFYqyNVlvhuGPN+TB
 6H3JvKsvH2WgNZyX+m+kTAiGkG2hr4B9nM2CBWHfnhW8DR4PLjNDAk5Yu+8JlVfU99
 xG0U45SR1iOgw==
Message-ID: <sashiko-outbox-212068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/12] arm64: dts: qcom: sm6350-lena: enable
 remaining i2c busses
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-pdx213-upstream-3-v4-12-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-12-4b01c50a821c@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:35:00 +0000
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
  Signed-off-by
--

commit fe7e98e46dac6038a81f144f88f59c95001cffd5
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: enable remaining i2c busses
>
> Enable all i2c busses where something is connected on this phone. Add
> comments as placeholders for which components are still missing.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
The Author and Signed-off-by fields use the handle "erebion" rather than a
full real name.  Under Documentation/process/submitting-patches.rst and the
Developer's Certificate of Origin, patches cannot be merged without a
sign-off using a known real identity.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pdx213-ups=
tream-3-v4-0-4b01c50a821c@erebion.eu?part=3D12
