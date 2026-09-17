Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7734C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 14:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D921410E71A;
	Thu, 17 Sep 2026 14:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l+8Z6gO2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F1010E71A
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:43:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 86B204339E;
 Thu, 17 Sep 2026 14:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0926C1F000FF;
 Thu, 17 Sep 2026 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789656226;
 bh=QdUZWXsKvcOvHfEy+mtQzWtHJEVn/m76pLn4a3Nx09k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l+8Z6gO2dJhITHSzSnooP8YrNF/EYTaH0m9LMvCgFSkcLafpDujNAiZbxafSX0uWt
 ih69kFb3+cbwKOOIGpcS+DoiC4ZDWnPJVWIoiK7AWlw+hzTnVDKtm3vws53My45C1Q
 gjWYDlLm2WkIa7p/1/BxzpvnzZTIPfyhEZvCG3SvdgAwF+gvUHFey8R4sDwZo2GFzx
 nzyaWDrfqwbR/qQ3vgAIUQIJgpXvPEpv4lWmkyLJrf6UAoF4nQPasn/r5jeBMwg1US
 jL5MeFuuiBdt7dzIqUsdkjy1rL6oeKQdV3TJc7tL6UBnOS7ZG6vrfUM0ZBeAZ0+3PV
 GaaOBDFknGGOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: Expand flow lists to block lists
To: "Daniel Matyas" <matyasdaniel006@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, dmitry.torokhov@gmail.com,
 conor+dt@kernel.org, robh@kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20260917144028.459053-1-matyasdaniel006@gmail.com>
References: <20260917144028.459053-1-matyasdaniel006@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:43:45 +0000
Message-Id: <20260917144346.0926C1F000FF@smtp.kernel.org>
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

> Running dt_bindings_check returned:
> [error] string value is redundantly quoted with any quotes (quoted-string=
s)
>=20
> The files used quotation marks in flow lists because the strings had
> commas and these commas were interpreted as separators. Convert flow
> style lists to block style lists, so that there is no problems with the
> commas.
>=20
> Signed-off-by: Daniel Matyas <matyasdaniel006@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917144028.4590=
53-1-matyasdaniel006@gmail.com?part=3D1

