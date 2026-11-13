Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5354F606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 01:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WRR2ojiX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9AEB10E54B;
	Fri, 13 Nov 2026 01:29:07 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2394510E6DE
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:29:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EB08260AA2;
 Fri, 13 Nov 2026 01:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A8D1F000C4;
 Fri, 13 Nov 2026 01:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794533340;
 bh=gE7e4FF5yMDLgn26rdIlGJVy1D3mQODC6XJ5Rlg3uh0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WRR2ojiX9QMfZMg14kmVEXQo2mUNQ5vpFsObv1PT1JpZRBhwcuzv/cQwnN32BL1FT
 e0rUbTD8mDGTpM+HDLOaZA0Qe5VWEFEqW5AU2j06DrDQYSW+arqkh+wirZ1Eho5UfK
 rRrDdrW5VxA846l+rhDboanbs9lrtotKG9V77Y4dCuJGAjGGkrp4GgWSxeUXwZQOah
 RhmoVhqv9l3Ot0DwLvxovd8Z3FkkudTCECNRreJcUsUIy1bhUwwcP9MIjN3ifoJBEP
 b6OG4GcmdRpUy3Fk3jIKYa/lXKbC9Ge+XY9a+dWCO6nUbAwRRXSZsucloT+x+8y4SF
 v6T6FNSxLXHOQ==
Message-ID: <sashiko-outbox-212055@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/12] arm64: dts: qcom: sm6350-lena: rename
 touch-en-regulator
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261113-pdx213-upstream-3-v4-2-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
 <20261113-pdx213-upstream-3-v4-2-4b01c50a821c@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:28:59 +0000
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
- [High] arm64: dts: qcom: single-word handle used in Signed-off-by
  trailer
--

commit d12bf1b1dee33b26a5800faa94f2b6f60f9599de
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: rename touch-en-regulator
>
> rename touch-en-regulator -> regulator-touch-en, to
> keep any future fixed-regulator sorted together
>
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
Both the Author header and the Signed-off-by trailer use the single-word
handle "erebion" instead of a full real name, which does not satisfy the
Developer's Certificate of Origin requirements in
Documentation/process/submitting-patches.rst.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-pdx213-ups=
tream-3-v4-0-4b01c50a821c@erebion.eu?part=3D2
