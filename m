Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF03ECD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1559A10E33D;
	Fri, 26 Jun 2026 10:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H9wvkJY/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4296210E33D
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 10:26:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 823CB60098;
 Fri, 26 Jun 2026 10:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B56A1F000E9;
 Fri, 26 Jun 2026 10:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782469567;
 bh=zNvNIOP+lA+Tu8EL824I1I9M5mhvmoXbh5ASrZCn7mo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=H9wvkJY/3byFOViyxOid8+vl+SuEU6XbFgMfE5Kx+E2wHQYTE7zIofEN7S8tq2ZK8
 kIGhIrlDySw50wA6u2Aif5FbF9GXefslwlrwqRsIts8SmM9XrCRQ+bGDtXl9yzXCDL
 YDX0C8rv3pbJEI6+Gk0E4GyVofRmEVP+Srb4+CZgzKwm+8HqYRgZ7EF00/xU+1G1jU
 04EETzd3wRIJ5rr3D34NTBtf1tUc6I1W47JroPm/WMa4YjlJTxwdpPJ3Pjkwtk0vHO
 YLSIWkmJiCCiO/ulSCrwNXFwC0jjK2rldL5IPuwxNgkomYNZ/gKa1Dfm24gIi6MQxw
 K46CS12YOskUA==
Date: Fri, 26 Jun 2026 12:26:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: display: tegra: Add channel/syncpoint
 range properties
Message-ID: <20260626-sceptical-aardvark-from-mars-cedf81@quoll>
References: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
 <20260622-host1x-nohv-v1-2-65bc682a617f@nvidia.com>
 <20260625-poetic-heavy-vulture-7baabb@quoll>
 <Np88My8kTE-rRphOw0a-Ew@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Np88My8kTE-rRphOw0a-Ew@nvidia.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, Jun 25, 2026 at 06:26:43PM +0900, Mikko Perttunen wrote:
> On Thursday, June 25, 2026 5:36=E2=80=AFPM Krzysztof Kozlowski wrote:
> > On Mon, Jun 22, 2026 at 05:22:51PM +0900, Mikko Perttunen wrote:
> > > Channels and syncpoints available may be limited when other system
> >=20
> > What are channels and syncpoints?
>=20
> Very host1x-specific hardware resources. Somewhat close to GPU channels
> and semaphores / fences if you're familiar with those.
>=20
> >=20
> > > components are using them. Add properties nvidia,channels and
> > > nvidia,syncpoints to limit the range of usable channels and/or
> > > syncpoints.
> >=20
> > Why isn't this deducible from the compatible?
>=20
> When Host1x is partitioned, the hypervisor (or other software entity
> with access to the non-vm host1x register regions) can configure which
> channels and syncpoints are available to each partition arbitrarily.

So you will have different boards for the same SoC with different
values?

>=20
> How that partitioning was done is not discoverable through hardware
> directly, so we need to pass that information through device tree.
>=20
> >=20
> > Also, nvidia,channels is too broad/generic. This is not ADC, right? And
> > channels is a common term in IIO. And in few other cases.
>=20
> It's not ADC. Yes, it's a common term in a lot of contexts. I can call
> it nvidia,host1x-channels if you prefer but that seems a bit redundant
> given the context.

host1x is indeed poor, but maybe there is some way to be a bit more
descriptive? message-channels?

Best regards,
Krzysztof

