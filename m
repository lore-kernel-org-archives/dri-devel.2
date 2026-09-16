Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E655C982C3
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F1C10EA53;
	Wed, 16 Sep 2026 14:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jf54z07L";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059EB10EA53
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 14:28:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C28BA40111;
 Wed, 16 Sep 2026 14:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A051F000FF;
 Wed, 16 Sep 2026 14:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789568901;
 bh=4Ua0Sb0AU0yYVVorf+Eo5eHEeLu186qR55bCEvdTfHY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jf54z07L54csh+edTnSJgZEDriJvvm3UMhCZhGA7WeF8B164ScaUkzCRwbKJU6jlZ
 ZUkPOiRbVYdA0lQkGDF+TjTZX2hG5fPkYIxejSr8ohqH/yo3803EfcMSkRY8vqKKbr
 tfhEZp7qehD3aanwWMJfgKwYHyblPtG9qu/CY1O43Jrabk+36kv1a3eez/KqAji1j4
 CwEdGir6ZaGvr13ZjZq7Ia2U926dG+JBjFrijgtGpr2F++2Q9A+S2vRyIJNWbQktNK
 5A9yfUsoCHLZtP5wSiaue2nxTwUOkOoMZuRjFHbnjvzFBNH7DM1NoVScNV6NkqzW9E
 d9bVTNHHa3QXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/19] dt-bindings: iommu: qcom,iommu: Add MSM8952
 IOMMU to SMMUv2 compatibles
To: "Muzaffer Kadir" <muzafferkadir@mainlining.org>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev, lee@kernel.org,
 linux-input@vger.kernel.org
In-Reply-To: <20260916-msm8952-initial-support-v2-8-798c2602dde1@mainlining.org>
References: <20260916-msm8952-initial-support-v2-0-798c2602dde1@mainlining.org>
 <20260916-msm8952-initial-support-v2-8-798c2602dde1@mainlining.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 14:28:20 +0000
Message-Id: <20260916142821.46A051F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-msm8952-in=
itial-support-v2-0-798c2602dde1@mainlining.org?part=3D8

