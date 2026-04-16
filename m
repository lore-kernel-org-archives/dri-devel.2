Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420F7F8D77A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 20:44:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F22F10E272;
	Thu, 16 Apr 2026 20:44:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="rFtBnyCi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA4E10E272;
 Thu, 16 Apr 2026 20:44:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 386216012A;
 Thu, 16 Apr 2026 20:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5276BC2BCAF;
 Thu, 16 Apr 2026 20:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776372280;
 bh=6GeKs/s7rJKJFX9BZErk1hHWiUzAkzToyuz89aINyFc=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=rFtBnyCi414LpKn7tloLw/ZjyjWhxAqruxwakcjNmFrS58i8VlEJWL9cJccB4GrAg
 6LfR5dU5iKV2DhvGrru8F6+8vdV7H0lMgHtBGm1XEEpk1IyCKT0/hol1HRRDwH3vat
 +lrqWZcgf/v4Gd74DpOrVnvXc55TSjYSpR6nowZE1vE6nwR6fDPH3MiZijzKGBKC9y
 47yiwpkjH+MZcXe5hIKsr6oeKknP19NpbSO8biXd3HETwoZ4WL082RJVX+QStMsDA9
 OnwJPGEEj9rccc55aaJ2k/+LglSe/XBrA4Bf1n85Q6YLJCO+ekFlTRnbjKRGXid6K+
 N29T1fAM+Tu6A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 22:44:37 +0200
Message-Id: <DHUVF2NYOGWV.2DQ3FJIPDF4B1@kernel.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Gupta, Saurabhg" <saurabhg.gupta@intel.com>, "Zuo, Alex"
 <alex.zuo@intel.com>, "Brost, Matthew" <matthew.brost@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "aliceryhl@google.com" <aliceryhl@google.com>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
To: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] drm/gpuvm: Do not prepare NULL objects
References: <20260130191953.61718-2-jonathan.cavitt@intel.com>
 <DHUUHT136HPP.1L7OL7DR568Q6@kernel.org>
 <CH0PR11MB54449980CA120479A4ACC019E5232@CH0PR11MB5444.namprd11.prod.outlook.com>
In-Reply-To: <CH0PR11MB54449980CA120479A4ACC019E5232@CH0PR11MB5444.namprd11.prod.outlook.com>
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

On Thu Apr 16, 2026 at 10:23 PM CEST, Jonathan Cavitt wrote:
> Question for the future:
> Is Lankhorst, Maarten a proper maintainer for this component?=20

Maarten is one of the drm-misc tree maintainers.

DRM is a bit special in this regard compared to other kernel subsystems, as=
 DRM
also allows non-maintainers to push to development trees. Yet, those develo=
pment
trees still need to be run by someone and those people are the tree maintai=
ners.

Additionally, there are people maintaining the individual components, drive=
rs,
etc. and those are usually the people with the strongest domain knowledge.

Patches should be sent to both the tree maintainers and the component
maintainers.

> If not, is there a list I can reference to determine who the proper
> maintainers I should be contacting are?

Absolutely, everything is documented in the MAINTAINERS file in the kernel =
tree.

The best way to figure out who to send patches to is to use
./scripts/get_maintainer.pl. The script should provide you with the full li=
st of
all relevant maintainers and reviewers for your patch.

Additionally, it also outputs people who have been involved in the correspo=
nding
component and may be worth Cc'ing as well.

If you run it for your patch you should get the output below.

I hope this helps!

- Danilo

--

	$ ./scripts/get_maintainer.pl ./20260130_jonathan_cavitt_drm_gpuvm_do_not_=
prepare_null_objects.mbx
	Danilo Krummrich <dakr@kernel.org> (maintainer:DRM GPUVM,blamed_fixes:1/1=
=3D100%)
	Matthew Brost <matthew.brost@intel.com> (reviewer:DRM GPUVM)
	"Thomas Hellstr=C3=B6m" <thomas.hellstrom@linux.intel.com> (reviewer:DRM G=
PUVM,blamed_fixes:1/1=3D100%)
	Alice Ryhl <aliceryhl@google.com> (reviewer:DRM GPUVM)
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com> (maintainer:DRM DRIV=
ERS AND MISC GPU PATCHES)
	Maxime Ripard <mripard@kernel.org> (maintainer:DRM DRIVERS AND MISC GPU PA=
TCHES)
	Thomas Zimmermann <tzimmermann@suse.de> (maintainer:DRM DRIVERS AND MISC G=
PU PATCHES)
	David Airlie <airlied@gmail.com> (maintainer:DRM DRIVERS)
	Simona Vetter <simona@ffwll.ch> (maintainer:DRM DRIVERS)
	"Christian K=C3=B6nig" <christian.koenig@amd.com> (blamed_fixes:1/1=3D100%=
)
	Boris Brezillon <boris.brezillon@collabora.com> (blamed_fixes:1/1=3D100%)
	dri-devel@lists.freedesktop.org (open list:DRM GPUVM)
	linux-kernel@vger.kernel.org (open list)
	DRM GPUVM status: Supported
