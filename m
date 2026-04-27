Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395A5FF885E
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 11:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C7510E29A;
	Mon, 27 Apr 2026 11:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aHNVOTof";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F37D10E29A
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777290247; x=1808826247;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=Z5b1O9yrhWObNHRT9Q7Vrv8z158YKgJy0kzRx4N3wh0=;
 b=aHNVOTofwIWeTOmtu+jtzn3nGYpsWnYQG8JTgJ9Ytn+haWT38AWLov/z
 M5N78EfrLAsDLCdAFCnUO1fKT+xRBS4i26s9zZzNe83fHosagfoMEw+1G
 z4uX4iwJNVXy/Yj+imEqUf84XgeNTRf50iiaWgtPaqOkYUDgRMYuqVErZ
 MXQjQFATsHo31o/1hpRoqGxMss8JUGkqjviiyADqWNDztWg6/U+j4hdd/
 KRw+qN/8vR/Dlo05CmAdqJcsvHgHl5WmVnS/IvrhH4uBTEdugbxdwSQS6
 bLevwDYBsmETZCIQbQ1+ouX8jv+ASyG1mhP8PCs7yCZxBpkgXNP5T2E6L w==;
X-CSE-ConnectionGUID: QpBPstjnQ+KspgvVpX7UeQ==
X-CSE-MsgGUID: 3JUUmqXYSwGUPgukIwGZ2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="89554119"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="89554119"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 04:44:06 -0700
X-CSE-ConnectionGUID: N8fHVskVQ7C47MsCXSafsA==
X-CSE-MsgGUID: EXlR1YHMQ8CFujcdt5vm6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="233887836"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO [10.245.244.36])
 ([10.245.244.36])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 04:44:04 -0700
Message-ID: <13be208e3b31ef1e6697551b72901f92e17bb950.camel@linux.intel.com>
Subject: Re: [PATCH] drm/gpuvm: take refcount on DRM device
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Matthew Brost
 <matthew.brost@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 27 Apr 2026 13:44:00 +0200
In-Reply-To: <ae8RbMocX2KBivpE@google.com>
References: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
 <544c97fe296f39da35e5349ba1fc0af05f2ff643.camel@linux.intel.com>
 <DHVOJ6ILGSLK.3OWKA4RV2HB5C@kernel.org>
 <215f305ff04ddf8a426871e895aaf520b02e89bf.camel@linux.intel.com>
 <DHY2RPB300R2.1XXG87NPYFRCI@kernel.org>
 <c9ce94ae6c7956d63ca51f6e979100ec713f68f2.camel@linux.intel.com>
 <ae8RbMocX2KBivpE@google.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Mon, 2026-04-27 at 07:34 +0000, Alice Ryhl wrote:
> On Mon, Apr 20, 2026 at 06:19:02PM +0200, Thomas Hellstr=C3=B6m wrote:
> > On Mon, 2026-04-20 at 17:08 +0200, Danilo Krummrich wrote:
> > > On Mon Apr 20, 2026 at 11:28 AM CEST, Thomas Hellstr=C3=B6m wrote:
> > > > I agree with your reasoning here, but current fact is that most
> > > > (if
> > > > not
> > > > all) holders of a drm device reference (files, pagemaps, dma-
> > > > bufs)
> > > > currently also hold a module reference to protect against this,
> > > > and
> > > > drm_gpuvm would be an outlier.
> > >=20
> > > I'm not convinced; if the DRM device has the requirement to not
> > > outlive the
> > > module it is associated with, then the DRM device code has to
> > > take
> > > care of this
> > > requirement, and not every caller of drm_dev_get().
> > >=20
> > > Besides that, if GPUVM holds the module reference count on behalf
> > > of
> > > the DRM
> > > device, it has the same effect that you rightfully point out
> > > below --
> > > it breaks
> > > rmmod.
> > >=20
> > > > To fix this properly (lifting that requirement) one could
> > > > introduce
> > > > a
> > > > drm device count in the module and have the module exit
> > > > function
> > > > wait
> > > > for it to become zero, *and* that the code that did the last
> > > > decrement
> > > > finished executing.
> > > >=20
> > > > https://patchwork.freedesktop.org/patch/712146/?series=3D163298&rev=
=3D1
> > >=20
> > > This looks like a reasonable fix to me. And it makes me conclude
> > > that
> > > we
> > > basically agree on everything. :)
> >=20
> > Yes, unless we'd want to do a similar wait for gpuvms before
> > returning
> > from the close() callback: If we assume all GPUVMs are tied to an
> > open
> > drm file, that would conceptually be nicer IMO but I agree if gpuvm
> > drivers implement something like the above per-driver device count,
> > that would be unnecessary.
>=20
> Just to confirm, it sounds like no changes to my patch are required
> here?

I guess not, Although in the end it currently just moves one potential
bug to another, but as long as people involved are aware, that's OK
from my POW.

Thanks,
Thomas


>=20
> Alice
