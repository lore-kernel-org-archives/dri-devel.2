Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F323C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0111210F698;
	Fri, 14 Aug 2026 15:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XUeOZ7nR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AF6F10F698
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:44:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F129600C3;
 Fri, 14 Aug 2026 15:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6071F000E9;
 Fri, 14 Aug 2026 15:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786722245;
 bh=oH6Itit7sXpXdfxkFH4iS60KRx+5GjvAWa6hE67W5g0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XUeOZ7nRi1ZnTrZwkJxwUeNU7iRp+MeMv4z6P6VHnFUtOBjSvpAegyufy1PW2+CvU
 SAwY7q7VKepdikJoJOrgEUAGhl6j71WZE7j7RpZeY4OLmvDGTgpiwmyhl30jSmJlN3
 isF1rFBItkYA4Kpxj63pqQ51BH62aKZb6yMBC9CNCfhiQNWrSub3NQWziwAy355Wq5
 GCNpmm9MB97pIawXK0caVXakUtbFugfOgwo/EkMihCcTNsPRiR6sFx1By0ddE85YDt
 es8TQ4fHOIRZVkz6SJY5h5RYGhC1L2qn+5VenmxmOKXXO1ulYwklxIOS1gySyq1tdb
 8jRY26n2y391A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/10] arm64: tegra: Hook up VPR to host1x
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, robh@kernel.org,
 linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, media-ci@linuxtv.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260814-tegra-vpr-v5-9-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-9-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:44:04 +0000
Message-Id: <20260814154405.4B6071F000E9@smtp.kernel.org>
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
> The host1x needs access to the VPR region, so make sure to reference it
> via the memory-region property.
>=20
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D9

