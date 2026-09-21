Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5AAC982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:22:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA7F10E90A;
	Mon, 21 Sep 2026 18:22:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="egUYGUDK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4836310E90A
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:22:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 307B74064A;
 Mon, 21 Sep 2026 18:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8168F1F000FF;
 Mon, 21 Sep 2026 18:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790014923;
 bh=BzFzzH9wb1qfFQVPGQLgHolj3tumQOjpjc6bGa5E39c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=egUYGUDKEL4adWsIOp0cj08vSxmjki9tPxqsE3JuyBc+CrP4vmVBqYGl3j/Ciraer
 i/0H+tyW6Xwvrmq3trgoGy+edgByue+ziOJosrsWTMjv0utBPtFlrnkwGEEOIY4EXi
 nfygZCfxP8JEJWEgIvO1t2VWJToAPEwV2YxuV1YY+Jwqinbaya8+xBK1JgZubJB+vA
 zdrVTFhx6Bev08SoDgfPE7lql8gudniEi4PelUv6IilzAo6rr6tRn8fNjtQ9/qpTnt
 tW8iaCwMeB+WveXeG+ggatGBnMxe9BjaPK0e1i3QqOs8pGWumfRWDFpgwXgeWdSNnp
 bsAf6cYtyj1Ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/19] dt-bindings: mmc: sdhci-msm: Add MSM8952
 compatible
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, dmitry.torokhov@gmail.com, robh@kernel.org,
 lee@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, linux-input@vger.kernel.org, mfd@lists.linux.dev
In-Reply-To: <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-5-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:22:02 +0000
Message-Id: <20260921182202.8168F1F000FF@smtp.kernel.org>
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
> MSM8952 platform.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D5

