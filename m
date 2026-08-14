Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12655C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A7C10F694;
	Fri, 14 Aug 2026 15:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QdwB/bIU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70DDF10F694
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 15:41:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AACFE60120;
 Fri, 14 Aug 2026 15:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35931F00A3A;
 Fri, 14 Aug 2026 15:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786722092;
 bh=44S4lkUYqvw1YWxAfIu8ptu2+8w9BuSAtJbFKJdAek0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QdwB/bIU10wtEggZhP8ftu2Gdb2fd5jS/i7T6a80fKVV6OBRZKB2ru2n2Ptt3Dpbf
 fIn59cNn8U2b838/1lCRiepjNOPW/IFz2+GWaZHZ2I8Q45Qkhhe4NjxI3CG+Z4ypBH
 UAL3AKSj4bwSVECytaqXx6p6NRisEOuXr/bXs+IcTn5C/r5UtX9EmuQBYug+ohrN4b
 s/n4G37j5OWPw337tYUWnme7ja27hNE3pTw4WltqPp24pEoEjgNjcL3TNSX2G/j1Hi
 058YGKrkJJmBEj+Wpb5D0pvuNUZIs3mmPUOf3VEbrtL0Qyp4nGYbLhCnWWs353gQe+
 Z6jEVYrivJfMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/10] arm64: tegra: Add VPR placeholder node on
 Tegra264
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-s390@vger.kernel.org,
 "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, robh@kernel.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, media-ci@linuxtv.org,
 dri-devel@lists.freedesktop.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260814-tegra-vpr-v5-10-71832b5d0246@nvidia.com>
References: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
 <20260814-tegra-vpr-v5-10-71832b5d0246@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:41:31 +0000
Message-Id: <20260814154131.C35931F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-tegra-vpr-=
v5-0-71832b5d0246@nvidia.com?part=3D10

