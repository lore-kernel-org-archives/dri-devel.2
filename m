Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A506C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B1D10E274;
	Mon, 31 Aug 2026 10:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="R2yUv4xG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC2C10E7EC;
 Mon, 31 Aug 2026 10:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788171381; x=1819707381;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=kVAoX+HVNzgKEtZ7qU0DNVH3RIR12QbP1w4BE7w9bVI=;
 b=R2yUv4xGRJZgXWyrbWr5WXc8dfAKiEZ4oA4vbLaadbMYVdkesgZn9Mjx
 QxtekH0BgJ93Tpd3Gg1S/FrqRzZMImPYehSzzxXO6JleKKBdVPv4+6j2Q
 03DVw6LoWOC9NUUQYKJCEOs7ozkt6rFcCSsynqb1COo6skKzMP1//AVQ6
 NmKzRib8a4og79VYIbsZNp2/AzQ9rqVZpArooyFxfvW+SAJZj5FnRdb2Z
 SxtOD7vkpMOwwyJbKAqUqcxDs69iMP7QvHK/blJ9ZZoAhYgrNpXHmyT1S
 DxQxhYst3oNi3vI8q1O9aHouNP4ziMDRSlnheIH6cCeaCi6OKtvLhUIii g==;
X-CSE-ConnectionGUID: aGNJ4YhwTnO46H96z6kJMQ==
X-CSE-MsgGUID: gTvRc5VVTNCB0NYl1mWFbA==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="99176670"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; d="scan'208";a="99176670"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:16:21 -0700
X-CSE-ConnectionGUID: AH8Hfps+Sk6uy2FxGwfT3w==
X-CSE-MsgGUID: NfKjpzBYTZCb+xZDycrEDw==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.41])
 ([10.245.244.41])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 03:16:18 -0700
Message-ID: <772d17307920288d82c55518322d2b65686fcd25.camel@linux.intel.com>
Subject: Re: [PATCH v5 0/4] drm: Add common drm_work_fence/drm_user_fence
 helpers and convert XE
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, Matthew Brost
 <matthew.brost@intel.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Mika Kuoppala
 <mika.kuoppala@linux.intel.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org
Date: Mon, 31 Aug 2026 12:16:16 +0200
In-Reply-To: <20260831054154.107602-1-srinivasan.shanmugam@amd.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
 <20260831054154.107602-1-srinivasan.shanmugam@amd.com>
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

On Mon, 2026-08-31 at 11:11 +0530, Srinivasan Shanmugam wrote:
> When a GPU dma-fence signals, drivers often need to perform work that
> cannot run in IRQ context. This pattern is currently open-coded in
> multiple drivers.
>=20
> This series introduces two layered helpers:
>=20
> Patch 1 introduces drm_work_fence =E2=80=94 a generic embeddable base
> structure
> that handles the dma-fence-callback-to-workqueue pattern. Any driver
> needing deferred fence work can use this directly.
>=20
> Patch 2 introduces drm_user_fence =E2=80=94 a thin layer on top of
> drm_work_fence that adds kthread_use_mm() support for drivers that
> need
> to access userspace memory when a fence signals.
>=20
> Patch 3 converts XE to use drm_user_fence. XE continues to write a
> fence completion value to a userspace VA using the new helper.
>=20
> Patch 4 adds optional per-signal compare functionality to
> drm_user_fence.
> When cmp_addr is set, the worker is called only if the value at
> cmp_addr
> satisfies the configured comparison. This enables AMDGPU's EOP
> eventfd
> per-signal filtering without open-coding the read+compare pattern.
>=20
> A follow-on patch (not in this series) will wire AMDGPU's render-node
> EOP eventfd signaling path to drm_work_fence.
>=20
> v5:
> =C2=A0- Split drm_user_fence into drm_work_fence (generic) and
> drm_user_fence
> =C2=A0=C2=A0 (MM-borrowing subclass) per Matthew Brost's suggestion.
> =C2=A0- Add per-signal compare functionality
> (drm_user_fence_set_compare())
> =C2=A0=C2=A0 per Christian K=C3=B6nig's suggestion.
> =C2=A0- Use mmput_async() instead of mmput() to avoid potential deadlock
> in
> =C2=A0=C2=A0 MMU notifier release path. (Sashiko review)
>=20
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org

I think the get_user() and put_user() of 64-bit values in drm (driver
common) code is not safe for typical use-cases on 32-bit systems. For
xe we officially don't (yet at least) support 32-bit systems so hence
the code is a bit sloppy but for drm helpers I'm not sure we can get
away with this. At least not without some form of warning or assert.

I think to make 32-bit systems 64-bit user-fence safe, we would need to
user pin_user_pages() combined with cmpxchg64() and a similar cmpxchg
operation on the user-space side.

Thanks,
Thomas





>=20
> Srinivasan Shanmugam (4):
> =C2=A0 drm: Add drm_work_fence helper
> =C2=A0 drm: Add drm_user_fence helper
> =C2=A0 drm/xe: Convert xe_user_fence to drm_user_fence
> =C2=A0 drm: Add per-signal compare functionality to drm_user_fence
>=20
> =C2=A0drivers/gpu/drm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/gpu/drm/drm_user_fence.c=C2=A0=C2=A0 | 147 ++++++++++++++++=
++++++
> =C2=A0drivers/gpu/drm/drm_work_fence.c=C2=A0=C2=A0 | 195
> +++++++++++++++++++++++++++++
> =C2=A0drivers/gpu/drm/xe/xe_sync.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
149 ++++++++++++----------
> =C2=A0drivers/gpu/drm/xe/xe_sync.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 2 +
> =C2=A0drivers/gpu/drm/xe/xe_sync_types.h |=C2=A0=C2=A0 1 -
> =C2=A0drivers/gpu/drm/xe/xe_vm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0include/drm/drm_user_fence.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
115 +++++++++++++++++
> =C2=A0include/drm/drm_work_fence.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 76 +++++++++++
> =C2=A09 files changed, 619 insertions(+), 69 deletions(-)
> =C2=A0create mode 100644 drivers/gpu/drm/drm_user_fence.c
> =C2=A0create mode 100644 drivers/gpu/drm/drm_work_fence.c
> =C2=A0create mode 100644 include/drm/drm_user_fence.h
> =C2=A0create mode 100644 include/drm/drm_work_fence.h
