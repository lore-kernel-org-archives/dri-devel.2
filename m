Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497A606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lPstk6bS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD5210F48A;
	Mon, 16 Nov 2026 23:00:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED39910F48A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:00:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D63D8459D8;
 Mon, 16 Nov 2026 23:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7968F1F000C7;
 Mon, 16 Nov 2026 23:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794870014;
 bh=l9dupyilK2kUIywdtAJzDg+QskeK5iZcBPdqB1Hyg0M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lPstk6bSVJyWebrhsSmV/4gX6lLaGQgU/Df/oOM4GxxrasNFtQIgZAdubseChTazE
 NoNxuzCdpjDLfkrk+Gzd+ih8JkrHHTW1Z6nKakn1zcaQnHA6br7qFNDpiYS9n1l93q
 JOrNFceRUHzJ2UZclDglzJjJowQFdZrtcXwvgLQUfzfIyRwtNnZ0LKq/8vaFq7Dpdu
 NKOjsNxwrM4YsMBA+Z+Tas9tAqE8akO21pwLVjRV0/VUaF6XyylemZ9sm+cjItA3Kd
 Qvpwe9twyWBumezaAnJBxkTeSKxfnwGdtbKFo4mNpNRs0kv3umCpgLOe5QCQR6ZVrb
 TeoDhEpytt1hQ==
Message-ID: <sashiko-outbox-217832@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/12] arm64: dts: qcom: sm6350-lena: Add PMK8350
 thermals
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-pdx213-upstream-3-v5-10-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-10-7318a19806eb@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:00:14 +0000
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

commit 740c0daeec4b7b67f69c91c933b4ac4150f59402
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Add PMK8350 thermals
>
> Configure the thermals for the xo-thermal thermistor connected to
> PMK8350.
>
> The trip points can really only be considered as placeholders, more
> configuration with cooling etc. can be added later.
>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
The Signed-off-by trailer and commit Author field use the single-word
handle "erebion" instead of a real name.  Under the Developer's
Certificate of Origin in Documentation/process/submitting-patches.rst,
patches must be signed off using a known real-name identity rather than a
pseudonym or handle.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-pdx213-ups=
tream-3-v5-0-7318a19806eb@erebion.eu?part=3D10
