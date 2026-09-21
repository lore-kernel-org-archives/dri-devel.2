Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19BDEC982F7
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C069E10E99B;
	Mon, 21 Sep 2026 18:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hCM5jMah";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4601A10E991
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:25:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 26C2441725;
 Mon, 21 Sep 2026 18:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7192E1F00893;
 Mon, 21 Sep 2026 18:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790015121;
 bh=ldPfOGDHEqy0DlvoBCEvjq6kprrJml9/imvyraCti+s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hCM5jMah4fMaUAPaTEtWW7+M0v7w7HUvU7JGRKKa41RQUMydnVu7qQqc1r5aPb7Se
 TRCuBQ26LjYVqprAZCTbGpUcCprOQAv97Lg0b6WHvvi/tLTJioJJC4mHOASqO12V5N
 ujU7uizDyIt8rKt5VUrp8vH1Xtz2JKmUgq1zthj+RShvSJcOHoxwpmgF/d/Bu3k9Cs
 cbHTOnB29jA3CgtKywiRkn8dbEdtxrA/xYRq9YfjwCu8tO7PZNyXBGktQ9VitWtyOW
 zDmCKB0XDul0bUVR+CCj5Do+ZBwHxA5Sec7JAHhGK2srYXyMi3u+ODQrcqjfNRghhn
 jWrfdveasJgIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/19] dt-bindings: clock: qcom: Add MSM8952 global
 clock controller
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
 dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, mfd@lists.linux.dev,
 robh@kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-1-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-1-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:25:20 +0000
Message-Id: <20260921182520.7192E1F00893@smtp.kernel.org>
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
> MSM8952 GCC driver is mainly based on MSM8939 GCC driver.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D1

