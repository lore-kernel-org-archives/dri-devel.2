Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F61C61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0AE010EC9E;
	Wed, 26 Aug 2026 10:23:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dgphAT/q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC0310EC9E
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 10:23:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E8BB760A5B;
 Wed, 26 Aug 2026 10:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90431F00AC4;
 Wed, 26 Aug 2026 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787739783;
 bh=LCFF0OKX7+aWdo3GWy8LuhCwooP9TtJsXhf+3xfy+wA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dgphAT/qTQskufkJEZlDQPRBMkuGyeCwibGLm3BOt3yKoswIkj7Zt8dpd5xMHvn/j
 IfqFc+Q1zApK6obcTC5Y/FifPPl40uTxED4gS8zAnybRRWMcmgyUZGIT6LNn+kCKlL
 aHbF6i2ySUyWU6HkJirE8p4USFLRl6j9Xsg24JgaU8w0KdQWXcjnhAX1Y4sXaZLlWG
 QOliOxiIIZijy7+31fyCqS862cMOnKim5JrislDMKvSjAisWO5Qyw+9NVRIvc9V9kW
 XObffeBJ5pQxLESZsEGE4NNFNEiXSSkTkpcc8d3MZtoSyni7pXDZIOepNb1ZFyiiiS
 jIMhoCerpsXpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: Drop redundant white-space around values
 in <>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org, lee@kernel.org,
 media-ci@linuxtv.org, mfd@lists.linux.dev, Frank.Li@kernel.org,
 robh@kernel.org, imx@lists.linux.dev, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260826102044.142986-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 10:23:02 +0000
Message-Id: <20260826102302.E90431F00AC4@smtp.kernel.org>
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

> Correct a few white-space issues around <>, which will be flagged by
> dt-check-style.  No functional changes.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826102044.1429=
86-2-krzysztof.kozlowski@oss.qualcomm.com?part=3D1

