Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB50DC982C3
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7A910E35B;
	Wed, 16 Sep 2026 14:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VbrRMEXd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 347BF10E35B
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:27:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AB88960008;
 Wed, 16 Sep 2026 14:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB01D1F000FF;
 Wed, 16 Sep 2026 14:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789568848;
 bh=VgWgxD/Ryi0YERIij1GbIYj9gs+Qkza8E2sDyBNSAE0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VbrRMEXdakRTbOGi8PfA1B2WA9cQnTl8l3aUuT7Y9FDAb6QJyBsl6/0/ER0/WEyFM
 soIe80934osQq8nWlzJpfJ7fr9PrhM3HvqXVgAP+BPAyMX7YhybnBDnZ/mWmux7DT0
 OEmad8AKNQYQJya86030nBvf5TiL+sLx/E2YpkncyKoXRMqYgQqB7lKNRzWdhTusng
 VOIb2l7iGrMD5t1n/H4aZQnImrW7UVGndzZAj9PDkM0+w0mq9Rve0eYgbjm/O44DYw
 y0A9XQXYig3lEQBQKBVPTHtKc3ZTzRL6wBEX2mMfItU5dpSgbWyyFIX4WgH2mDcmxf
 +XI1Rv1Jvu97Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952
 compatible
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 dri-devel@lists.freedesktop.org, mfd@lists.linux.dev, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org,
 lee@kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-5-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-5-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:27:27 +0000
Message-Id: <20260916142727.CB01D1F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D5

