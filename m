Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696C1C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 761F410FAD2;
	Fri,  4 Sep 2026 11:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J+MkjO9Q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0962310FAD2
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 11:53:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BA18A41E73;
 Fri,  4 Sep 2026 11:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0924C1F00A3D;
 Fri,  4 Sep 2026 11:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788522834;
 bh=9MvvEevaebnk0LNal3y1+rSwrnqS1mDIBJl9BcYOPhI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J+MkjO9Q8BJq/aXTwuXz5fJW9B22ZxzieXMTfOA9T1zcvwK5EzsSUWD6g9JAYy1im
 a7jozp+HCGaufy0Ykot62cz46aswKEd8gs1U2Mf9aCeRKJ+qkIJqU+ZCaQEJjPY7jC
 b5Bf0UoszDlma1nvVaqwIOX/Me8Fxu+kw88lZxK0QpmtfMXKZ/CD9467oLoiZpCErV
 o2T5P5csDCN4wTkgqUr3YzR2X6UJxjYH2g7Ra70ObWFxqC5BVl9lEHxtQZoh9fHRSW
 DIB8xppmD5W9VQ3AqU0zKc7hD40hXjrLecfpHGWKLGpk/BW8H6FVcnAxKLtygFof9o
 P4hcjLnh8+rHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/12] arm64: tegra: Add VPR placeholder node on
 Tegra264
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, conor+dt@kernel.org,
 devicetree@vger.kernel.org, media-ci@linuxtv.org,
 linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, robh@kernel.org,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260904-tegra-vpr-v6-12-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-12-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 11:53:53 +0000
Message-Id: <20260904115354.0924C1F00A3D@smtp.kernel.org>
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

> From: Thierry Reding <treding@nvidia.com>
>=20
> This node contains two sets of properties, one for the case where the
> VPR is resizable (in which case the VPR region will be dynamically
> allocated at boot time) and another case where the VPR is fixed in size
> and initialized by early firmware.
>=20
> The firmware running on the device is responsible for updating the node
> with the real physical address for the fixed VPR case and remove the
> properties needed only for resizable VPR. Similarly, if the VPR is
> resizable, the firmware should remove the "reg" property since it is no
> longer needed.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D12

