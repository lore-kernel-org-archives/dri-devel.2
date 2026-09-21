Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7E5C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEFFE10E8E9;
	Mon, 21 Sep 2026 18:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HWA65oIb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C2F310E8E9
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:21:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F3B7940517;
 Mon, 21 Sep 2026 18:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9561F000FF;
 Mon, 21 Sep 2026 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790014895;
 bh=tl/SN7niuliyPiFDiKzUFi/iUVdUbwbZFtPxhW0NIdw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HWA65oIbxE4RZkAbMFHsqauaTwoPJ/okdY3sxMqhA0fF/OHlpzNMZ+7O+FyxbtGII
 9K4doNboA0a7QJz3IMlVsVpuGNSxfXE1nsuVAgp7Shhd9B1+BBPp/NsMhMfbfjHNNB
 pwSuK+YVET/HyEMZdLMOZkrnvaelIB0u93RJQMaxDgbOBAZLyTu7QdL2i172NreXdA
 Vfy3G7kxzwwMrBz2y5hcj7cNztL2WDaN/c/zVqRNjJKuB9SePt37YUnj5yk7/WdWDw
 D8AzbXXqD7beUarkZ3B2DrvSappftJ8Zj32P16Vf8CtbiM4eAWe+8S9rxxMHA97fHL
 IxM60iSZ0HxJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/19] dt-bindings: firmware: qcom,scm: Document
 MSM8952 SCM
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: linux-clk@vger.kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org,
 robh@kernel.org, devicetree@vger.kernel.org, lee@kernel.org,
 dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com,
 linux-input@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-11-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-11-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:21:34 +0000
Message-Id: <20260921182135.4A9561F000FF@smtp.kernel.org>
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
> Document the scm compatible for msm8952 SoC.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D11

