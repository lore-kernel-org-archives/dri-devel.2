Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C69C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:43:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC7210E6B4;
	Sat, 12 Sep 2026 08:43:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NDyzL3gn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7293110E6B4
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:43:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D58D41529;
 Sat, 12 Sep 2026 08:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900331F00893;
 Sat, 12 Sep 2026 08:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202613;
 bh=6W93l0LA+Wr92moPYXHt5bMfk3oNvleu26sDIfzvBFg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NDyzL3gnqPxzfgvqLitoNBrQk0Ia3+TwUKwoF4IwJBPOdwZZtz+TnXen1iOjdFcUw
 LUc8e2otYd4eAAB5tD3s2NrO9O9b/xgU7QiBvLlao7S34kBr/5iSfuy2tC/83YUwOk
 UCPcv2uuANJWdyJqtE1pV8Ce/g8XztorgzoTaxjd2DUeXygFgFEOF70onERKqKApKN
 qg0h1/Vh06gcTSBhDIG0Pa4+AtDYh66LRAEiU7D+iZ3Nuz3l7IfcWfrYnJg7uchHc5
 B0PEWczNcduX8IKTKrdF8KyLN+3t+XQdFXA+BAAnfdpzGZ8w8euHWnOI76DCH553Hm
 55jIRp1sOi1cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/20] dt-bindings: mmc: sdhci-msm: Add MSM8952
 compatible
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com, mfd@lists.linux.dev, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, lee@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260912-msm8952-initial-support-v1-5-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-5-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:43:32 +0000
Message-Id: <20260912084332.900331F00893@smtp.kernel.org>
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
> Document the compatible string for the SDHCI controller on the
> msm8952 platform.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D5

