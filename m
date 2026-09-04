Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70CBC624D3
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 10:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E91910FA9C;
	Fri,  4 Sep 2026 10:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q3OhGg6K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A8D10FA9C
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 10:56:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8143418B6;
 Fri,  4 Sep 2026 10:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148C21F00ADE;
 Fri,  4 Sep 2026 10:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788519406;
 bh=3xtslc2D80gdBYd6ip6x8G/YBhaOiLglQojQPTnbmMA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q3OhGg6K34/+jhZrqZoAJEn6lx79LB7yIU/lbBPQxhtXT4TAjfeXTCAmdwH31HCB5
 OQfuIiICwKunFAe5I+YehQayhJAgv6YJ4ItqKxluA5OMt64wYTAs6Bonx4sgIa1C1L
 HwCHS8xHBf6BTxTwf0A80q1qsXzeX+ux3Btcjt1B6bcQkdBvTHwb1cHdoP8qZzZu9T
 bCkMvHbXOpYaDA+ZEli59zSNTuQX/MvP2vr+AWWNz5yckoJhqSgLlINDCMs6agmyh2
 wDOn6PdVtIAvjPNGBjcVeRe3Vqjfp8WDXwjrPavgduSoXRhpTWu+a7IlJhxlfEQCR8
 y0dON4JR0pNdw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/12] dt-bindings: display: tegra: Document memory
 regions
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 robh@kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, media-ci@linuxtv.org,
 conor+dt@kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-trace-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260904-tegra-vpr-v6-2-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-2-79042cfa8de5@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 10:56:45 +0000
Message-Id: <20260904105646.148C21F00ADE@smtp.kernel.org>
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
> Add the memory-region and memory-region-names properties to the bindings
> for the display controllers and the host1x engine found on various Tegra
> generations. These memory regions are used to access firmware-provided
> framebuffer memory as well as the video protection region.
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-tegra-vpr-=
v6-0-79042cfa8de5@nvidia.com?part=3D2

