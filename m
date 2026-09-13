Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45277C88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 12:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831B410E8D0;
	Sun, 13 Sep 2026 12:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Atud9ZO1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FDB10E8D0
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 12:34:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0121D60E0C;
 Sun, 13 Sep 2026 12:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB0C1F000FF;
 Sun, 13 Sep 2026 12:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789302898;
 bh=Zdh2LU3F7Skw/QyBZEFbG5PG0Y8VX4TxCECvpcnLg2Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Atud9ZO1r9u6Yd8P+UsyvzUNkHjlyoQ4tRjG4H1Dx9WmxBTY9EFUvORzdEk4L81xI
 +ahFAMspMYS/umCB/0ol/2jhhVuqsQ8BuvgwZ1ZvMO4577lnsHOiBvmfyUJQilF0k6
 YB/SVj7LvoLR5tjsg9XQWyfLCxO78Cmq8ojB7OS//xpcaeNnLhg0+htLeNFxTebY1d
 1h6My5X/cCudUNpaZyQg4HKofEzQBha6ip1oAr1LuiVHdbgI5YlnXAZL/PbmWyIsoR
 J9Tq/qznuRjzniKUriUuHxumwonJrtMcdTrqqlhRITqqsvKhsOgRFQ+ndalKWQ09KY
 KD+PVO6a6rTsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: leds: Use consistent indentation in the
 example
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 conor+dt@kernel.org, robh@kernel.org, linux-leds@vger.kernel.org,
 lee@kernel.org
In-Reply-To: <20260913123301.100129-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260913123301.100129-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 12:34:57 +0000
Message-Id: <20260913123458.5FB0C1F000FF@smtp.kernel.org>
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

> Correct indentation in the examples to consistent 2- or 4-spaces
> indentation to fix dt-check-style warnings ("example 0
> [indent-consistent] indent mismatch ...").  Preferred is 4-spaces, but
> re-indenting entire example just for that is too much churn.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913123301.1001=
29-2-krzysztof.kozlowski@oss.qualcomm.com?part=3D1

