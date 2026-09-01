Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65A3C61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E60A10EC0B;
	Tue,  1 Sep 2026 08:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZUv5dWZ5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A155510EC0B
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:55:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 82B3E41998;
 Tue,  1 Sep 2026 08:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086671F000E9;
 Tue,  1 Sep 2026 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788252943;
 bh=ErhXmupPt7A2xSQ140Y/QaiDhmSBsAqA5t9Yk3loy6w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZUv5dWZ5ksL1X8IcavwNQLjcDuZk26Tu4iJ79ONg9PGf3OS8A20e54bk2bv3epnK4
 fYREmF+25K93fv+BI5pjrOPRrkwuhzgpl6tP6okX2PV8T3sY2y/ryF4d2yxINRPm85
 +TFKoJH/1TyMqZrsU+leM8piz5cwu2UIlkApS+6EWj0mwcSp9U4K6RGlhYp4Z2oS4e
 kg+fAoO8FzXnP0KRkapEI0bAMBeHnu25y/R8CNS2UOiGE6eEYtV1NLcoMZbnU9QFDT
 uFXoXuB/NAMTFoYe7sNeaXbUgzqHoFos1GFoVYi9IEPiOGPbmAXwB26rwcnNRY46/X
 s8l/PyG9Tedvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: pinctrl: qcom,sc8280xp-tlmm: allow
 gpio-line-names
To: "Xilin Wu" <sophon@radxa.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
References: <20260901-q8b-dts-v1-0-7de0b6a73d08@radxa.com>
 <20260901-q8b-dts-v1-5-7de0b6a73d08@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 08:55:42 +0000
Message-Id: <20260901085543.086671F000E9@smtp.kernel.org>
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

> The SC8280XP TLMM GPIO controller exposes 230 GPIO lines. Allow boards to
> provide descriptive names for these lines and constrain the list to the
> number of GPIOs exposed by the controller.
>=20
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-q8b-dts-v1=
-0-7de0b6a73d08@radxa.com?part=3D5

