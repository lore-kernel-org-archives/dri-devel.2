Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAAAC982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 354A610E3FF;
	Mon, 21 Sep 2026 18:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GofDL9sR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5D510E3FF
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 18:22:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E9BF4017F;
 Mon, 21 Sep 2026 18:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E19A1F000FF;
 Mon, 21 Sep 2026 18:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790014949;
 bh=11RwB3c6QWVY/+H6SRJm2EfWY6ZRPTbVLBQktL1ZFR4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GofDL9sR1hfGUzQSJsyAwBtWkgbbWwIW+NOliA+1w20eYG+TelwjvsXa8+PiGYobr
 CaZuyelQk8VGAtwzb+jv9wQGVoYzxrUsZdqkKrqouOzKMq8UZeD9eLjBmMMWaziI10
 0uwaW0V+G0HsskTeW2nOX4ETWG9TyPCnPCnGFqb858nYig8jwUZjATAmBBDi2z+ISF
 q5eSo94bhLaqNAmmd2xw17R9GsJmbi/RFKl70jDelzuG4aOBSd9RusiQ0FE7uwprWF
 0UlOCuPrBP5C2RlzN8jIFvwGya16Hp2gmYX++A4ESkxCUjccD5RkeNKzNCQYvXj9fz
 pFZznom5eLdgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/19] dt-bindings: iommu: qcom,iommu: Add MSM8952
 IOMMU to SMMUv2 compatibles
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dmitry.torokhov@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, lee@kernel.org,
 linux-input@vger.kernel.org
In-Reply-To: <20260921-msm8952-initial-support-v3-8-b96fd3fe298b@mainlining.org>
References: <20260921-msm8952-initial-support-v3-0-b96fd3fe298b@mainlining.org>
 <20260921-msm8952-initial-support-v3-8-b96fd3fe298b@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 18:22:28 +0000
Message-Id: <20260921182228.9E19A1F000FF@smtp.kernel.org>
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
> Add MSM8952 compatible string with "qcom,msm-iommu-v2" as fallback
> for the MSM8952 IOMMU which is compatible with Qualcomm's secure
> fw "SMMU v2" implementation.
>=20
> Signed-off-by: Muzaffer Kadir <muzafferkadir@mainlining.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-msm8952-in=
itial-support-v3-0-b96fd3fe298b@mainlining.org?part=3D8

