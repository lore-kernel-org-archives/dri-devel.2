Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C790C55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 19:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D38710E32A;
	Sun,  2 Aug 2026 19:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IGVicfUI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C4210E32A
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 19:57:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B1511407C1;
 Sun,  2 Aug 2026 19:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325651F000E9;
 Sun,  2 Aug 2026 19:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785700656;
 bh=2FBnVorze0mGUMFhKixNlw0OLeUgjg1WcovYGQUNhYc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IGVicfUI034aLZprr4H9yVgrVI4h7PadJhcG7/gUz84EjmB4LnuUI8SFdKrubjxKb
 slSeoEP0N0VyQwV0wt8dxozRxL5Q0ghXKWshBGKSw6XjzOQUjzMQp0rUIsgrldDDzz
 Yq+c4ZZz5qG0VfvgNJWjqF+O05zUs9gezi5rX92nIV1rDoF0zWKmoM4/314D8ZKwjJ
 HixQsGdkdSWgzSMWG84bbcVBwWKwBy5nmA91SE4gOLl9oXeptqOdbTkealwCduUC7d
 NV0dnqxjheTjivV7j0qAlYEFRdyKicKSM1kpVv9CdY8244Ssr3WOPNNNMzdGoJInUt
 Wym4Ya/zT/KFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: Correct white-space style
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 dlemoal@kernel.org, linux-ide@vger.kernel.org, robh@kernel.org,
 mfd@lists.linux.dev, conor+dt@kernel.org, lee@kernel.org, cassel@kernel.org
In-Reply-To: <20260801195613.235430-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260801195613.235430-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 19:57:35 +0000
Message-Id: <20260802195736.325651F000E9@smtp.kernel.org>
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

> Correct a few white-space issues, like double space after '=3D' or before
> bracket '{' characters, which will be flagged by dt-check-style.  No
> functional changes.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801195613.2354=
30-2-krzysztof.kozlowski@oss.qualcomm.com?part=3D1

