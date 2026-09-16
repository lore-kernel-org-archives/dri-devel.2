Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C148C982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A56D510E17A;
	Wed, 16 Sep 2026 14:31:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mfjsBf4Z";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BBD10EB6E
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:31:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6DE13602CB;
 Wed, 16 Sep 2026 14:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958041F000FF;
 Wed, 16 Sep 2026 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789569091;
 bh=QziSslsWsBG40yrzelNbceDEATCdWN2Iwkt7b7xhN5U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mfjsBf4ZFrpejdigNxvebcphZ4Yc4p0T9Fp2FBW9cAiS9g5zGFMCHlBFdLA3k6UpE
 e+30Omqfd1HQLRnLeB7VaOsRjxT5vSZpfUKapuFpB5IRS06yY9bABLwdj7ULxXnxN8
 Bu9N4qd/ifmW62h2f/sWLC3r8kxmKUiEAJz6rkGz6lCItaeox7VL1dZv+MwgP1CDS5
 vFncoSAVHlSvKaM20Cs3vJY4upaKNjtYX/CmhcyAEmzgZRbjyMh/zKSlkp+ASGXw3i
 yBey7F4x/gM3hZV01KmCQqKtpAwdI2OP13M3Jf3g6RIZ2d51BCpB+iUefHjf9vUEsD
 mwjhLDsugGeXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/19] dt-bindings: thermal: tsens: Add MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, lee@kernel.org,
 linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, conor+dt@kernel.org,
 linux-clk@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-15-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-15-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:31:30 +0000
Message-Id: <20260916143130.958041F000FF@smtp.kernel.org>
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
> Add compatible string for tsens block found in MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D15

