Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CA8CA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A4C10FF5C;
	Fri,  9 Oct 2026 07:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AQ10x1FW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AA0910FF5C
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 07:59:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9229E602C3;
 Fri,  9 Oct 2026 07:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43EF1F000FF;
 Fri,  9 Oct 2026 07:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791532779;
 bh=/af2zvV+ZuNG3llyemOs4w3R4jH7oTw34EaZ8L23g3c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AQ10x1FWPmUDFeo8OsBBhN2diHNoCFaToEEfNKTTVpsTKehvZ2ZTrwgg0xbbkZR0l
 KiOAyV51PAuhZA7WtpUI16Msbym4EP9nZWFRVcp+rQRRHMUlRt+OV4mxzgJ66+ulK/
 1A79BPB35DBsFM/8KqdeYTVI8wTXf2R9pyrWHi/+OQGxVNlEPorOMZ/fXWa7OBME0q
 RLZUa7IYVSntwzPyqQSriF3bybmkVlz6CxwYHZcTaZLx9mUlR+4dXcZhD12Br6sYKg
 0ubL2fUerD7pCKjW6Fo5hGiqZJseZRoyqB1oBnCYTyeE9UjHgPJlFfEmuybH47qNCD
 7moGZDupJ0hgA==
Message-ID: <sashiko-outbox-165048@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: bridge: simple: document
 Chrontel CH7218A
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 conor+dt@kernel.org, linux-gpio@vger.kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261009-q8b-dts-v2-1-eda11e5dea8b@radxa.com>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-1-eda11e5dea8b@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:59:38 +0000
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

> The Chrontel CH7218A is a DisplayPort 1.4 to HDMI 2.1 protocol converter.
>=20
> The device contains an embedded microcontroller and on-chip flash. It
> automatically boots its firmware and requires no host-side configuration
> for the on-board use case, so it can be represented by the simple bridge
> binding.
>=20
> Document the chrontel,ch7218a compatible.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Tested-by: Daniele Briguglio <hello@superkali.me>
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-q8b-dts-v2=
-0-eda11e5dea8b@radxa.com?part=3D1

