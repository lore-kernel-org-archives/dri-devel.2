Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34168C982FA
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:21:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6989410E93A;
	Mon, 21 Sep 2026 18:21:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FCUj7Qyt";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A5C010E3FF
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:21:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 439CA60008;
 Mon, 21 Sep 2026 18:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D521F00893;
 Mon, 21 Sep 2026 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790014897;
 bh=/godxLzqsZ6qnaUy/9kWZB8iyX6LFxBi0v0sV2WiCkI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FCUj7Qyt+igw1RAsPqKzrinleLlh8lM9zrfmlZjYaRDdvEdgrQqsBmMl6F5L/a0dB
 OQ281+2McTyci1EVh4AwklL3k4yL4J8f+he6rTTrQyiqf47FJdWdw3sWKWwvVv5nkS
 BiiiygF7eskMPBmmGHLFFuI6Bi+Mti6AIAyhEuo/2rUdz7VAVAAEoF2GfRwczQupmG
 UeDBqdRAgcLbbZ6cv2a7Zbwck59UgzxW7ClrNyYySRkliHSdTiIE+IX7t0MmVJ2c+d
 b0hfMhaSjA8sbqHm08E3Kp1EDar0bL5Xn+pN7fP+Gq4GIhfHIfHGNcLNOS1QAaCiAN
 i+SIdp1UcRv4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/19] dt-bindings: nvmem: Add compatible for MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org,
 lee@kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-msm8952-initial-support-v3-3-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-3-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:21:36 +0000
Message-Id: <20260921182136.64D521F00893@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

> From: Muzaffer Kadir <muzafferkadir@mainlining.org>
>=20
> Document the QFPROM block found on MSM8952.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D3

