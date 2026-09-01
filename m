Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D54EC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B53BF10EC04;
	Tue,  1 Sep 2026 08:52:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VSTEdYk0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A282D10EC04
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:52:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5FBBD419BC;
 Tue,  1 Sep 2026 08:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25731F000E9;
 Tue,  1 Sep 2026 08:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788252749;
 bh=0qUADuyYfWc5hfxXFgbA/wqGqLqYo6kqKOfvczFuS3k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VSTEdYk0Nq1nev2m8Eru9JX9lWM6ddJRMfoRugXlGW0DlhjsFzKNDaWdIgvYMwit/
 qgEoTWkIB0L9VCbmLWUz0iPvo22nagL7csM/cQdtIXj7xHPSWWedRiItnQTWIHmI+2
 VdFGvaQ8QKXjfKNvpA0OfGcremq1u6PQsnrcbVhBMIZlVWKB7FKi6cm23JuXw5ywAb
 1Jwk6ybVIS23a9vOnEU2gPY61f5Ghx4j6198vTyBnELCoDXCzOKscTg3cxEu/YvFam
 gkp6OdGXzpnwyDssKMX0VESirnXPf4WaByyhQnXzhBb7ECzhdqq7iH+LHPMlkGxBE3
 f385Rr+0SChjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: display: bridge: simple: document
 Chrontel CH7218A
To: "Xilin Wu" <sophon@radxa.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260901-q8b-dts-v1-2-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-2-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:52:28 +0000
Message-Id: <20260901085228.F25731F000E9@smtp.kernel.org>
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

> The Chrontel CH7218A is a DisplayPort 1.4 to HDMI 2.1 protocol converter.
>=20
> The device contains an embedded microcontroller and on-chip flash. It
> automatically boots its firmware and requires no host-side configuration
> for the on-board use case, so it can be represented by the simple bridge
> binding.
>=20
> Document the chrontel,ch7218a compatible.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-q8b-dts-v1=
-0-7de0b6a73d08@radxa.com?part=3D2

