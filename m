Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A7606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9+M1HgV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8937E10EA2B;
	Mon, 16 Nov 2026 22:55:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92E6610EA2B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:55:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D09C4496A;
 Mon, 16 Nov 2026 22:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8351F000C4;
 Mon, 16 Nov 2026 22:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794869748;
 bh=4DZmLB3M1DLobOYk987m6k+lY7VG7Hne8WiBB90d7L4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E9+M1HgVD2by20XHU2g68zBgQ+gNJp28tAw7YJOzWt5jHPbFtPNKTWocyq8VdUnHS
 iubOM2D0wJkDJzC1A/6hXIHVKUqqxOrCZqqXjgtgHMAK3Zoyd9VlsLAU2Qm9bcsYBo
 etROXQ/4bBKNcmnWz63BeHMA+TwIcVsLByTAixH7vvqmoC2PdVPOkVOLwAx30dShsC
 iTEnKWbkEuM7bvlZLa+BdtWf0SJKDk+1zdn35RLEv/9QKEOl96OxUuSnPq+0CS8jCO
 E1l46qOuwarw2AMb7vm0BnPnRDAGNCFkv9K6oakTt1qSz2aZHn18lZP+XFCdtgS2Pv
 PybExSCg7SRWQ==
Message-ID: <sashiko-outbox-217822@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/12] arm64: dts: qcom: sm6350-lena: Add
 qcom,rmtfs-mem node
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-pdx213-upstream-3-v5-3-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-3-7318a19806eb@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 22:55:47 +0000
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
- [High] arm64: dts: qcom: sm6350-lena: Signed-off-by uses handle
  instead of real name
--

commit 22ff41be0c77265e49ea053288034f41745039c3
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Add qcom,rmtfs-mem node
>
> Adds the qcom,rmtfs-mem node required for the modem
>
> Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
The Author header and Signed-off-by trailer use a single-word handle
("erebion") instead of a real human name.  Under the Developer's
Certificate of Origin in Documentation/process/submitting-patches.rst,
patches must be authored and signed off using a known real name rather
than a pseudonym or handle.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-pdx213-ups=
tream-3-v5-0-7318a19806eb@erebion.eu?part=3D3
