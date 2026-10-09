Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618C8CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:58:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F2210FF55;
	Fri,  9 Oct 2026 07:58:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ei99OhWi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A911E10FF55
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 07:58:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 79DB242DD6;
 Fri,  9 Oct 2026 07:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5701F000FF;
 Fri,  9 Oct 2026 07:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791532692;
 bh=B77fDqZHTn3Qv92/KM5DHEl/rBqMN2XlVGStZIk489c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ei99OhWiGFIVkC7z7IcOuRvQcSVivaeZOn1zw0nsrra8br/VRjdy8GWHWRnPhqKAc
 61eG6fJXtE884Q96JZbSf+fTKBvaifyOtLgz8lIFRJkPWIOfTK5QOVEYxBkhTEBPZZ
 C0LH6vqfE9yMNlygyunUkTtecymkGMy9nPsAW180ieiu3VBo+mB25G8/haF/3JYvAv
 AnJmzXRFgesbdXK9X2SsVi++5FlrZXsdV1Bl8GKR3u53XXctH6tQXvRbvM2JWl9/e6
 cja2ZbF+frEcXBNXn4UCMmv2fPFtCEz310jacC+eDkx/eOuUes/y+qoHz1w47CwXre
 zXqpzTDqrYcRg==
Message-ID: <sashiko-outbox-165044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/bridge: simple: add Chrontel CH7218A
To: "Xilin Wu" <sophon@radxa.com>
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 linux-gpio@vger.kernel.org
In-Reply-To: <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
References: <20261009-q8b-dts-v2-0-eda11e5dea8b@radxa.com>
 <20261009-q8b-dts-v2-2-eda11e5dea8b@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 07:58:11 +0000
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

> The Chrontel CH7218A automatically boots its embedded firmware and
> operates without host-side configuration.
>=20
> Add the CH7218A to the simple bridge driver and expose its output as an
> HDMI Type-A connector.
>=20
> Tested-by: Daniele Briguglio <hello@superkali.me>
> Signed-off-by: Xilin Wu <sophon@radxa.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009-q8b-dts-v2=
-0-eda11e5dea8b@radxa.com?part=3D2

