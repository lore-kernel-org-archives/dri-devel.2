Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6224C79FB6
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC65110E6AE;
	Sat, 12 Sep 2026 08:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i0M7bZFG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3AB10E47C
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:51:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0C580601F1;
 Sat, 12 Sep 2026 08:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314901F00893;
 Sat, 12 Sep 2026 08:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789203084;
 bh=NVs8FkDQrv9XcaZ0C0mhTjpNGSaoxVuE8Bk8aJ2CN54=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i0M7bZFGq2k7JxKpdSkSAk6LbjVqJcx18CGiRiXwo1oEKUlznn9KeXfKLlltQGBLY
 4+Z+8oLd30jE+OkeREXpHxo6w5bA+xpnkkXLwF+B7gchI1krDAb5TMWFkY/srgCRw6
 KzPy0wB/a2SjttklfsUx8tzDL7RZc+wiczcfI27EsIIthBkjdl54kQ6OI4WDQn2sQ2
 5o66RzFaNT/zcm26DeAjjmKg5/9viyKxRa7NeFLt8ktgJiq5lPeuJL7gNFCB7OA2Lm
 K6fCgU98V60KiNN8lCaG/SOpNB3x+KwyocAPvny70Bf8z3tRv3N7GFmkyVn2uamTm8
 tiuPjkkWmi8OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 16/20] dt-bindings: thermal: tsens: Add MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, lee@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-input@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-16-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-16-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:51:23 +0000
Message-Id: <20260912085124.314901F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D16

