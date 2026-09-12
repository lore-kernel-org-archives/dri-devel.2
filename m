Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC16AC88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 08:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A3B410E679;
	Sat, 12 Sep 2026 08:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="koamoVVC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BBAB10E679
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 08:47:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CDEA140C44;
 Sat, 12 Sep 2026 08:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED371F000FF;
 Sat, 12 Sep 2026 08:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789202855;
 bh=8Vy94n9WwOHWb2dNmZDjMBQp4y4nlxN2R5dyHYszS6Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=koamoVVCjUx4KW2l08ly9n32D+FmGqd/1F3CuAY7osoX49luiEzmcrDiLDhVGjRZ6
 t/ma9nicqHXPEb3exS+wwwwIeCiZRAhk1uzz30C3sIhVwSbuP63g0Kvz1EcW1ea0p6
 1giVWfMSpTvqPKOwE4ROVxdDizW9KqgV9LBUYXdfncjPNBGi6TNqoCt+yQ65M0OL3z
 /Av2QYvlN3fm0Bbz1/+eTfYMUmGSRa5TLZfp0DSx8V7SEVNlNNMo+LvoNX3JzE3b3P
 O3JLAix7XIb1XAiDBO5k1nJeVX6vUuqE5IIFUI+pSlKEjkWf6cRRWteBD3pKo4YW8m
 ZCYwRBAO1pMGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/20] dt-bindings: display/msm: qcom, mdp5: Add
 MSM8952 compatible
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, linux-clk@vger.kernel.org, robh@kernel.org,
 linux-input@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com,
 mfd@lists.linux.dev
In-Reply-To: <20260912-msm8952-initial-support-v1-10-0e742578b524@mainlining.org>
References: <20260912-msm8952-initial-support-v1-0-0e742578b524@mainlining.org>
 <20260912-msm8952-initial-support-v1-10-0e742578b524@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 08:47:34 +0000
Message-Id: <20260912084735.2ED371F000FF@smtp.kernel.org>
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
> Add the compatible for the MDP5 found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912-msm8952-in=
itial-support-v1-0-0e742578b524@mainlining.org?part=3D10

