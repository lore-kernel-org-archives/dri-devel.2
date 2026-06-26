Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61ACCD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 10:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF13410F561;
	Fri, 26 Jun 2026 10:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jby4GSSL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6F410F55F
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 10:21:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7F1CC40E04;
 Fri, 26 Jun 2026 10:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BEB1F000E9;
 Fri, 26 Jun 2026 10:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782469299;
 bh=YzX/MLAta5+or8FOVzZwpdDah+/ccMdWjuTIgvsyxos=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jby4GSSLB3FQDlGlwLgAbSFvKzA84V2ayaAzuo4FElROdQkFtzmg9+xj7HfktefBd
 A3Ag69eHgHl59FZNUjUDQgXF2ya0XmU5X/peuZWK5CnsBMetj4Tbk1avoaC/gxQECj
 yHVV2+Fj2qem8RNVtN0/Cg4FFhIRAOmdDFdx5+OROMwh166qy58kv6Ad1z0u7RdZvn
 mEAOeMtkQCBoPwrg/h6QHGcBWYslYbEM/nC7Ddkpgj40ZG+/J0zo88ahI/iRIe77HY
 QxEDo7ZMOE65bF+2tl/fEUzJ3/2Jrfk8DR3rYmQfAGH3kKMA4aVUJjareuS7FmcJoR
 9YtGaj1aLYs4Q==
Date: Fri, 26 Jun 2026 12:21:35 +0200
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
Subject: Re: [PATCH 1/4] dt-bindings: display: tegra: Make non-vm registers
 optional
Message-ID: <20260626-unnatural-thick-iguana-88ab9e@quoll>
References: <20260622-host1x-nohv-v1-0-65bc682a617f@nvidia.com>
 <20260622-host1x-nohv-v1-1-65bc682a617f@nvidia.com>
 <20260625-hospitable-antelope-of-diversity-f3456d@quoll>
 <NWz2vh3HRYqBDySgTFAF_g@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <NWz2vh3HRYqBDySgTFAF_g@nvidia.com>
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

On Thu, Jun 25, 2026 at 06:17:39PM +0900, Mikko Perttunen wrote:
> On Thursday, June 25, 2026 5:34=E2=80=AFPM Krzysztof Kozlowski wrote:
> > On Mon, Jun 22, 2026 at 05:22:50PM +0900, Mikko Perttunen wrote:
> > > Host1x can be used without accessing the hypervisor or common
> > > registers. Adjust the bindings to make them optional.
> >=20
> > You still have these registers in the hardware, so it is not optional,
> > not flexible. IOW, DTS represents the view of real hardware for the
> > software, and that hardware still has this address space regardless if
> > OS should use it or not.
> >=20
> > Otherwise you need to provide better background here.
> >=20
> > Best regards,
> > Krzysztof
> >=20
> >=20
>=20
> The intent is that the vm-only version is used in situations where the
> other register regions are not available to software. Typically that
> means running as a virtual machine, and the hypervisor owns the non-vm
> register regions and doesn't pass them to the guest.
>=20
> Since the guest runs under the hypervisor, its view of 'real hardware'
> is what the hypervisor is exposing to it -- in this case with just the
> "vm" register region.
>=20
> I'll add further explanation along above lines to the commit message
> if you're OK with it.

Yeah, it's fine. Please extend the commit msg to make it more obvious.

Best regards,
Krzysztof

