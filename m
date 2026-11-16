Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3D5606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0kAgZ1E
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB1C10EC12;
	Mon, 16 Nov 2026 22:56:14 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C9EF10EC12
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:56:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3630246431;
 Mon, 16 Nov 2026 22:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C075E1F000C5;
 Mon, 16 Nov 2026 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794869767;
 bh=CdLf9z4Qx4cZyXQgg7UtU+1+YKPETkvFINGdM4Quv/c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U0kAgZ1EkWlQgyT3KHgylCM3Q/5ivaEkI7C1XYNDjTwbPxo/tY8N2S0Xi8CrHZ0mt
 dmNqk0yULzObsXdqjdS7ZT79nZK+JstFsZltyf+w9YAxD22sKGmnJvfkVIullldsor
 L8GoO4tbWWJ6FgOOCRd4gPlWk+NT2q+8CqhDjtawpDLr1nd5AZbvOuGtrWStCJQocR
 ix1LtzFE2KgSz42LX7Pht2zGDqLoRi4wpw1j4nPuXFFK+rk/1VdmdUsDZVxxAosGVC
 c6pwkQ1pENi0DPUFRaaJMYeEpnJfmhd1FQltI5XVJ6koHs3cwXscdnoAcX3btp6ues
 jvrPcGptgVm8w==
Message-ID: <sashiko-outbox-217825@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/12] arm64: dts: qcom: sm6350-lena: Enable wifi
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-pdx213-upstream-3-v5-6-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-6-7318a19806eb@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 22:56:06 +0000
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

commit 69b3f383982805a38e5e9161e90e92403fe51a58
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Enable wifi
>
> Configure regulators and enable it for the Xperia 10 III
>
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
Could the Author header and Signed-off-by trailer be updated to use a
real human name instead of the handle "erebion"?

Documentation/process/submitting-patches.rst requires a real name for the
Developer's Certificate of Origin and does not allow pseudonyms or
handles.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-pdx213-ups=
tream-3-v5-0-7318a19806eb@erebion.eu?part=3D6
