Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEFCC43602
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 16:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878C510EFA1;
	Wed,  1 Jul 2026 16:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wc0vRORD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC7510EFBB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 16:16:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E0B566001D;
 Wed,  1 Jul 2026 16:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261AE1F000E9;
 Wed,  1 Jul 2026 16:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782922587;
 bh=ULDk0dKlNaYCc4UU7uCB1fvspUD39sUqTgZWe4uD7Kk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wc0vRORD2MCCStZboly9uAHihvzPNd+m5QJiSJSD+lwellSixuAwumOoBjIZQEy7g
 H5k2VUzX90W3OyJIpVrRec1pRxd5OH1ruMGNIDhkc/NARcD11i1pY5biDYBvCzCs1K
 ff1c8WsiJItmlPvVY9kaDznrxDrwGOMIJrg3fEPLxrsIlqOgbi8RdVOOJIBYTLoBlJ
 Xzu1HK7UrtRDE+z1JlvHRoUgXkUT2xdE/m/zJsyyceTrYkoqojKjT8aS6SBMJgwOJ2
 b+bakV8+xDWVrrtqv6DnKH8eOfoqx9FGoJmLbfb/iSCvBlfv7ZbX5COhD7G5dMk3Jy
 3dHJCPJhuc9Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/11] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-s390@vger.kernel.org, devicetree@vger.kernel.org,
 "Vasily Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org,
 "Alexander Gordeev" <agordeev@linux.ibm.com>, robh@kernel.org,
 "Heiko Carstens" <hca@linux.ibm.com>, conor+dt@kernel.org
In-Reply-To: <20260701-tegra-vpr-v3-3-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-3-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:16:26 +0000
Message-Id: <20260701161627.261AE1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Typo `maxitems` instead of `maxItems` in device tree binding schema.
--

commit b966754e5a0b2701616e733b8013eb6ace1487ef
Author: Thierry Reding <treding@nvidia.com>

dt-bindings: gpu: host1x: Document memory-regions for NVDEC

The video protection region is a reserved memory region that can be used
for secure video playback. NVDEC can access this region to decode images
into securely.

Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml in p=
roperties.memory-region-names:

>   memory-region-names:
>     items:
>       enum: [ framebuffer, protected ]
>     minItems: 1
>     maxitems: 2

[Severity: Low]
Is this regression a typo with maxitems? Should it be camelCase like
maxItems?

It looks like the lowercase version either disables maximum length validati=
on
for the memory-region-names array or breaks meta-schema evaluation when a
developer or CI system runs the make dt_binding_check target.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D3
