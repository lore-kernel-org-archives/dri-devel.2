Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58658C982C3
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B930E10E1D7;
	Wed, 16 Sep 2026 14:27:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AY8EcLqg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19B0710E1D7
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:27:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 92E2760234;
 Wed, 16 Sep 2026 14:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CF31F000FF;
 Wed, 16 Sep 2026 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789568832;
 bh=eFwzOxf+cncUKdIQUWKHRxFXQ0Kn/v8AGmd6pRlnur4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AY8EcLqgKoNCNw0EHhUlkDDWraf/YrOMsCqG6PpEKMvFU7cgJYOOjZubQ0iGbrGt1
 VdU0sPThTULNivgOu/CqpCIIj/Im9zVMzRCCXVbESkBFO1W8ewD345GvAJ2jZgfGsT
 rPkqdnW3l0TWO3RyzvtnU/TNsR1W60FTspo0nnpC3W0mIajHMF1gCdzzjtm6q80TJX
 05OXeRYRJ8qIBpeHZtSY7VS2Uf+zxBCbOMtbCoGmd0dRnFIyqLGDxDOi5sac7Z0Rzy
 rLvSWbem0DVXcuu+oAvf9WCgTJvALd5L5Dwin4G8heeMbgia2YPEcDkPojUtJbro8W
 vI/8F4vDfY9iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/19] dt-bindings: nvmem: Add compatible for MSM8952
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: lee@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org,
 dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org, robh@kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-3-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-3-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:27:11 +0000
Message-Id: <20260916142711.B7CF31F000FF@smtp.kernel.org>
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
> Document the QFPROM block found on MSM8952.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D3

