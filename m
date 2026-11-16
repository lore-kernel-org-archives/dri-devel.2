Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8E606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oMA2l/Rz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2565A10F4C3;
	Mon, 16 Nov 2026 23:06:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22CA610F4C5
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 23:06:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DDFB44679C;
 Mon, 16 Nov 2026 23:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2981F000C5;
 Mon, 16 Nov 2026 23:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794870363;
 bh=Rxr7OTQcA4EUHlDwXdExhumTReS9XtWftQ6u/ViBj68=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oMA2l/RzoL/RWzXvluOXxldYUJlYcVDrPJUIbmxU/AJD8AIilFuQyOgHtRUpxKPoA
 B3yuz3b7TWeSHoadT9k4kT5WzjC2+BP9sALpgAL9MWCnNtyX4xRSq/FYLq47Y8aZuG
 gsklc0RkQxMGqZr81YgJXEVWEDdBpY9czx02M3QT7e7gqup4CeW+X/HN91sATpRsG2
 tqqkGHyeS3j1DU13rJGtq9kaxkt+FqMzi407m7F9452qM4qMq7fiEX4WS3UMTiirIn
 y2VNnUJzlZHXfe3QTSqn1sH2Zrq2ZkGsvBy1+5Cy/HSaUqA0HitpiUURh377I9A40T
 lCtY2wkzD1RyA==
Message-ID: <sashiko-outbox-217847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/12] arm64: dts: qcom: sm6350-lena: Enable PM7250B
To: erebion <erebion@erebion.eu>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116-pdx213-upstream-3-v5-7-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
 <20261116-pdx213-upstream-3-v5-7-7318a19806eb@erebion.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 23:06:03 +0000
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

commit bce0793330bff87c0fe7378b4881d3cb7b3eea46
Author: erebion <erebion@erebion.eu>

> arm64: dts: qcom: sm6350-lena: Enable PM7250B
>
> Enable PM7250B and some components on it for the Xperia 10 III.
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: erebion <erebion@erebion.eu>

[Severity: High]
Documentation/process/submitting-patches.rst requires a real human name in
the Author header and Signed-off-by trailer rather than a handle or
pseudonym ("erebion").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-pdx213-ups=
tream-3-v5-0-7318a19806eb@erebion.eu?part=3D7
