Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D839C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD8988C11;
	Mon, 21 Sep 2026 18:37:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Eo57eAbt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D73488C11
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:37:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD5FB416F8;
 Mon, 21 Sep 2026 18:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6E31F000FF;
 Mon, 21 Sep 2026 18:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790015842;
 bh=ndQUE6YHU2ixXOwk4QYgdxWp4lpHVDloKpYUcVkUmWg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Eo57eAbtiFX4ZzqmWE/Z33h3nunHgHkkZ6DQFtAnGAvAng8yIqNtM1bWC88ZPz2BD
 YWVjEgVgCz9ZB/+nLKc4YqVxwoE9NNSqPZAGrG7ExgQaR728juur+h62BpqOMv2lLj
 LLU3Hk3cXx4wDozjCECiyyh6dkc7nMggQRGvRFfydszEVDdjkEDlWqdZanI9yHiaXH
 ZpGWNlapXzwnPunCyo5HhpUsTjn/HqsKyXIlQaAgKDYm8zmeab7U/kKQwGgHmqx7Nw
 0zhJFmTjvbPFLISssFFV7cNzqKg/9Q2QV15Vr4aClz0FVnneTUa9q0YNejcVYsGVg3
 nqAi4uCT9QZgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/19] arm64: dts: qcom: generalmobile-shamrock: new
 device
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com,
 linux-clk@vger.kernel.org, mfd@lists.linux.dev, conor+dt@kernel.org,
 lee@kernel.org, robh@kernel.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-19-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-19-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:37:21 +0000
Message-Id: <20260921183722.2F6E31F000FF@smtp.kernel.org>
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
> Add General Mobile Shamrock (GM 5 Plus). Shamrock is designed
> similar to L9300. Downstream reference is [1].
>=20
> [1] https://github.com/Asderdd/android_kernel_generalmobile_shamrock/blob=
/cm-14.1/arch/arm/boot/dts/qcom/msm8952-l9300.dtsi
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D19

