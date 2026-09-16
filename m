Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F1BC982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1B6E10E5A7;
	Wed, 16 Sep 2026 14:27:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h5Uqvsg+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E765310E5A7
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:27:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF1BF43AA8;
 Wed, 16 Sep 2026 14:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E1C1F00893;
 Wed, 16 Sep 2026 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789568869;
 bh=o9aI7w25aC9N0w0QyhQFz+Ff5xtQGpHAAEAfCW3AYiU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h5Uqvsg+RQyEHPaxQJ72C2tUD0iLqQxtVVinY62GtOClT44Iq9USRXX8YtehqwVha
 NLWvzkbjNkvCDXnhFYeTA/1P1/BHsHJZVQbbIxAjIJkSftRURdM1sGVMxhIVxpOtrs
 utzU+h/OsMOY3LSspnY4BgWvO+AbuQCiym4JN3iQCUeN3yhqy+1vtmW4vPDnN0ZDnE
 myKNYNe2A8oY1E+K5zEmJYRzR/R0yfJDe8QQdp2NBOMC605T6Jb0TriQ1XShEDxaNI
 kWSB4am6PpQRTbaEzeQLU/S7zb6Y4ZRTFtbAS8C8cvgm7mIsx5wh6FLGhoyGE7pEIZ
 6rQP1+42TdIuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/19] dt-bindings: firmware: qcom,scm: Document
 MSM8952 SCM
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: conor+dt@kernel.org, robh@kernel.org, mfd@lists.linux.dev,
 linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260916-msm8952-initial-support-v2-11-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-11-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:27:48 +0000
Message-Id: <20260916142749.12E1C1F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D11

