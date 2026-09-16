Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC9FC982C3
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3E9C10EB6A;
	Wed, 16 Sep 2026 14:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RRbWmF4p";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C74D10E8F4
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:26:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5FD2D6053A;
 Wed, 16 Sep 2026 14:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838521F00899;
 Wed, 16 Sep 2026 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789568790;
 bh=G2diwEhhfbntTHq2imLXbTwmhACiPiz0HrIR7BPSfGo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RRbWmF4pHhjcaJmP6mNLzHbrIoL5a59jwJaW1gxprKss9fSeCpYuUPSuank2mTuLx
 IfRzxhiRkxkUcX2QAoKBbAhv8cKKC3yEXIwEgoF+aTupxM1+O4Z36Dbqr51XbVLT6e
 C4Sl4Ryq0HEpQ0xNW2m9YmHoC+1dP9viok93NAacoiC+etd7xXPHsV1YE2YLPRu4aM
 7YbJI7SjTEtC6eAtnE4qDmgAlCyWD7sYNq7mfXWrDy3LOFm+m3H8SOxpMk37stat1Q
 9zrC0GSyfStTtjhZpB2YDphiuFv/3hkKqDiRkyRhM2tEipJ0HmWVasMB7usZHaCWfC
 o/SeZFcUJ/A8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/19] dt-bindings: mfd: qcom,tcsr: Add compatible
 for MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, mfd@lists.linux.dev, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 lee@kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-9-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-9-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:26:29 +0000
Message-Id: <20260916142629.838521F00899@smtp.kernel.org>
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
> Document the qcom,tcsr-msm8952 compatible.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D9

