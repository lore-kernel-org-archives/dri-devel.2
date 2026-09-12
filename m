Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5212C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF9810E6B3;
	Sat, 12 Sep 2026 08:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AwqfsQSn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D5710E6B3
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:43:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2EE1F60229;
 Sat, 12 Sep 2026 08:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558841F00893;
 Sat, 12 Sep 2026 08:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202606;
 bh=v64bmT+cyd0qVHY50C42iHjtQZxXRShQEMFyaVISt7s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AwqfsQSnincZSakTDhW2BU/TleMF+04GiKFXzu5RUqx6XP/kbiWhRfz0FjeI2dTW5
 5m3p+XcIA2zd0XGaXUaxP2j1M9v8tHC0TS7y8k/CaGASP/VTG1IrZoeo/kE+YQkyY6
 rzIJjEVK7aoJp8RPJjmW4UCr+vFgn40v3sR/teh1iNrV7aPUO/h4hD5xD3LIfQuT68
 4oGu62OJg+nm791um3RRZemSpcqX71kq65AUaT8+l9bIzws0o+8+xeRpbczzaeEd2s
 EldlM93xvaJ1Hiu8Pk2NbNH7rUbQs9i9ST9FcllJuEt9vrjgECyz3C1w7E038uji4f
 atDSB1yu27KEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 15/20] soc: qcom: ubwc: Add UBWC config for MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, lee@kernel.org,
 mfd@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org,
 dmitry.torokhov@gmail.com
In-Reply-To: <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-15-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:43:25 +0000
Message-Id: <20260912084326.558841F00893@smtp.kernel.org>
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
> MSM8952 uses Adreno 405 and predates ubwc just like MSM8939.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D15

