Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B32F588F0
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7131910E6E6;
	Mon, 20 Apr 2026 16:19:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P8KADZI1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FD6010E6E6
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776701948; x=1808237948;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=9WCaWT1uDDnVbHnYE/bKi6RTzJIo5ibhmjljjeuufuY=;
 b=P8KADZI10l0UNzthls9LPvZaHi9KV9aWOuAgNxtes19kh3l+0ky50WoU
 Ux/62Zs3IP4Q2yxtC1XM3l8J6HpVAskf64BifNj2Puhvj5s6Z+YjRoQul
 VWveYoVBx5meA4src7K3jY3YNUVW+KdI1cDGr3pTyMD47VGxosi+Aq2+w
 55dpssn+q6H+lENOl/D92dY/IHk78/DEpqBYg68HMeb4kvl0wmz7KmDp6
 Lc73AtYMi4Jjw2kFKeUYMu64cWKJgSuva8fmBixDk9MbR2fptDaZIAKbV
 A4SaG/7UM15vljVIVmh+URR7yChrbviWC7EXmsFrpJh+uyR4KLvQ0NjsX Q==;
X-CSE-ConnectionGUID: 71q5P7sJStCr/0bjKyM3Qw==
X-CSE-MsgGUID: 8Uevqk65TMaIcIoKSq15YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="76786333"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="76786333"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 09:19:07 -0700
X-CSE-ConnectionGUID: tUbecKS0R8GanHV116mIPg==
X-CSE-MsgGUID: McHq/mSiS9+07DjgwDZ2eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; d="scan'208";a="225272466"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.133])
 ([10.245.244.133])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Apr 2026 09:19:05 -0700
Message-ID: <c9ce94ae6c7956d63ca51f6e979100ec713f68f2.camel@linux.intel.com>
Subject: Re: [PATCH] drm/gpuvm: take refcount on DRM device
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Matthew Brost
 <matthew.brost@intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann	 <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 20 Apr 2026 18:19:02 +0200
In-Reply-To: <DHY2RPB300R2.1XXG87NPYFRCI@kernel.org>
References: <20260416-gpuvm-drm-dev-get-v1-1-f3bc06571e73@google.com>
 <544c97fe296f39da35e5349ba1fc0af05f2ff643.camel@linux.intel.com>
 <DHVOJ6ILGSLK.3OWKA4RV2HB5C@kernel.org>
 <215f305ff04ddf8a426871e895aaf520b02e89bf.camel@linux.intel.com>
 <DHY2RPB300R2.1XXG87NPYFRCI@kernel.org>
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

On Mon, 2026-04-20 at 17:08 +0200, Danilo Krummrich wrote:
> On Mon Apr 20, 2026 at 11:28 AM CEST, Thomas Hellstr=C3=B6m wrote:
> > I agree with your reasoning here, but current fact is that most (if
> > not
> > all) holders of a drm device reference (files, pagemaps, dma-bufs)
> > currently also hold a module reference to protect against this, and
> > drm_gpuvm would be an outlier.
>=20
> I'm not convinced; if the DRM device has the requirement to not
> outlive the
> module it is associated with, then the DRM device code has to take
> care of this
> requirement, and not every caller of drm_dev_get().
>=20
> Besides that, if GPUVM holds the module reference count on behalf of
> the DRM
> device, it has the same effect that you rightfully point out below --
> it breaks
> rmmod.
>=20
> > To fix this properly (lifting that requirement) one could introduce
> > a
> > drm device count in the module and have the module exit function
> > wait
> > for it to become zero, *and* that the code that did the last
> > decrement
> > finished executing.
> >=20
> > https://patchwork.freedesktop.org/patch/712146/?series=3D163298&rev=3D1
>=20
> This looks like a reasonable fix to me. And it makes me conclude that
> we
> basically agree on everything. :)

Yes, unless we'd want to do a similar wait for gpuvms before returning
from the close() callback: If we assume all GPUVMs are tied to an open
drm file, that would conceptually be nicer IMO but I agree if gpuvm
drivers implement something like the above per-driver device count,
that would be unnecessary.

Thanks,
Thomas


>=20
> Regarding the reference count in the meantime, it remains that
> omitting it does
> not solve the underlying problem, i.e. I still think it is
> orthogonal.
>=20
> > Or one could also have the drm device hold a reference count on the
> > driver module, but that would block unloading without previous
> > unbind
> > which is not typical driver behaviour and would likely be seen as a
> > regression.
