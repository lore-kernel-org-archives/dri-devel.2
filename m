Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4045FC88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:45:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A6F10E6B8;
	Sat, 12 Sep 2026 08:45:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gTIEUS8L";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B2A210E6B8
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:45:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE88960209;
 Sat, 12 Sep 2026 08:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52CE1F00893;
 Sat, 12 Sep 2026 08:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202710;
 bh=FfX/IPSpkPQUJ5D5APA5+Eo9jCOJBw5wUj2YbvAu0YQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gTIEUS8LEbJNdlctwDpm+RKw3wx6SRh08Cl2KUZzoznwoGglnauSpKZVz/53gp8ou
 kKqjtkMBNsQYXyQFHUbmMVnFM4k5yk6Pnjt4x1TaPplrMUrrCIpGln3LI3PYrtyJAR
 ASCBL0CIzb++E4/0MYWUP17ke4Zqv2l5QBCygMAPeCXJwvdhFsXwFkT6+4+nYutd0q
 zu2zBV8uPqdqPgOqMyn6l2fFmZ/FX2FOcBiKd5yQlfHwop1xRXEMeMqRUp6dHdKs5U
 2AS3KSEM4WFergRNca2e3qaMwWCszZVFAZYKf/JdPfEgF0xTxp74RJU97vPPdZgTDu
 +kZaBh6DflJyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/20] dt-bindings: clock: qcom: Add MSM8952 global
 clock controller
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: conor+dt@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
 lee@kernel.org, robh@kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org
In-Reply-To: <20260912-msm8952-initial-support-v1-1-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-1-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:45:09 +0000
Message-Id: <20260912084509.E52CE1F00893@smtp.kernel.org>
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
> Add a device tree binding to describe clocks, resets and power domains
> provided by the global clock controller on MSM8952 SoC.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D1

