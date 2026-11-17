Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D104E606A330
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=itJSOg8A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D3210EA99;
	Tue, 17 Nov 2026 08:22:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C556110EA99;
 Tue, 17 Nov 2026 08:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794903736; x=1826439736;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=oDBWfWxuyuXCs7svJ3CMQY+hoTNFGtkSXN+3KpjIDic=;
 b=itJSOg8A8j2MbO2Seec1ecku5wltac3zmt/G6TYYfg8OhS+QxWSs2uaM
 NrDLCuNwWA3wYw1D4L8dXWxObUZmUz1FW0nZ6xIS3CdTXGy3ojT6Si788
 cKgEnD6grMJkk3RTEevRaLDZ4SoQjljNIqfMJRUjp6z6nqS9rsikR7d+e
 xENtoFc7fp+dzgDCEQi0u03C3f+SWafFoplyhRdWyWGIvfCFbWU34CBSU
 zq5mfayIFXWAxeAUpPYgJvH/VNAd43aK9eJ/GogjK03M7TrFUjXfQMHht
 cH/1HDoYcM40KIv2aDSZNdZ4F9tgW7h3OTzSzGMtQEgi/h5kF15fFxAyc w==;
X-CSE-ConnectionGUID: iEGJKoZUQFWKtDi0WnEgbw==
X-CSE-MsgGUID: zoYTOuQiQTy/tYuEus/UkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3701175"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3701175"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 00:20:42 -0800
X-CSE-ConnectionGUID: 4KmUuLCjTM+rIDZU49LxUQ==
X-CSE-MsgGUID: lcn6PfM5Qx+zmu3znnkgSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9906183"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.6])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 00:20:37 -0800
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e97d0efc-a6de-4060-be48-c2ca128461b1@amd.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
 <20261109135549.4128280-15-mika.kuoppala@linux.intel.com>
 <e97d0efc-a6de-4060-be48-c2ca128461b1@amd.com>
Subject: Re: [PATCH 14/20] drm/xe/eudebug: Add userptr vm pread/pwrite
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, gustavo.sousa@intel.com,
 jan.maslak@intel.com, dominik.karol.piatkowski@intel.com,
 rodrigo.vivi@intel.com, andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Simona Vetter <simona@ffwll.ch>,
 Dominik Grzegorzek <dominik.grzegorzek@intel.com>
To: Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>, intel-xe@lists.freedesktop.org
Date: Tue, 17 Nov 2026 10:20:34 +0200
Message-ID: <179490363459.14567.17741084775869143840@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Quoting Christian K=C3=B6nig (2026-11-16 15:17:02)
> On 11/9/26 14:55, Mika Kuoppala wrote:
> > Implement debugger vm access for userptrs.
> >=20
> > When bind is done, take a ref to the current task so that
> > we know from which vm the address was bound. Then during
> > debugger pread/pwrite we use this target task as
> > parameter to access the debuggee vm with access_process_vm().
> >=20
> > This is based on suggestions from Simona, Thomas and Joonas.
>=20
> At AMD we had a legthly discussion if such an interface would be necessar=
y for AMDs debugger interface and came to the conclusion that it is *NOT* a=
 good idea to have this.

I'd like to refer to our 2024 December discussion on review of v3 of
this series[1].

Quoting myself from the end:

	"It seems like the peek/poke access to userptr is the big remaining open
	where opinions differ, so maybe we should first focus on aligning on it.
	It impacts both core dumping and interactive debugging."

Then from same series review, we took Sima's suggestions[2] to be
implemented. About one year later in 2025 December we got your
review comments[3] for series v6:

	"But from a ten mile high view it looks sane to me now."

And quoting myself:

	"Understandable and thanks for the high level check, we'll continue with t=
he
	current direction then."

So given v4 (which you gave above "looks sane to me" included pretty much
exactly this patch [4], I'm bit surprised to be starting to reiterate what
feels like our discussion from [1].

I'm hoping we can agree to a disagree here. ROCm maybe doesn't need
interface like this due to requirement of ptrace_attach(), GPU address
=3D=3D CPU address and no kernel initiated core dumps. We want to avoid
those limitations in our architecture as discussed in [1].

After you very much seemed to agree in the direction on [3], we've
spent 2 years incrementally addressing all the other comments in 7 new
series versions. Thus I'm not really a big fan of reiterating the original
discussion, so excuse me for being bit irritated here.

> process_vm_readv() and process_vm_writev() interfaces already allow a deb=
ugger to access userptr resources completely without the need of PTRACE_ATT=
ACH.

That is correct. However as discussed earlier the access implemented
here is for reading memory from ppGTT, not the CPU address space. For
readv/writev userspace driver would have to maintain all ppGTT layouts
in CPU address space and that'll simply not fit as discussed in [1]
amongst the other reasons.

This exact same access will be needed when doing core dumps and capturing
the ppGTT contents during crash by kernel, when there is no GDB involved.
I don't see any value in diverging the memory access path for interactive
debug and core dumps.

I don't know if ROCm has plans for supporting core dumps without GDB
involved, but we definitely want to have that ability. And in [1] we
seemed to agree on the usefulness.

> Especially since this interface here allows to bypass all the extra secur=
ity checks otherwise applied to such an action it should probably not be so=
mething allowed upstream.

To recap. No security is bypassed, access happens as if GPU did the
access. If the address is not in ppGTT, there's no access to it. So
access given here is equal to access gained submitting a blitter copy
command to copy the data using a context with the same ppGTT. Code
comments were added to explain to eliminate Sashiko false positives.

Unfortunately, we can't actually rely on the RCS/CCS/BCS engines
making forward progress on current gen hardware as hardware may be
stalled due to numerous pending page-faults. Especially when doing
core dumps.

Regards, Joonas

[1] https://lore.kernel.org/intel-xe/173392197322.40386.1225274149499860645=
3@jlahtine-mobl.ger.corp.intel.com/
[2] https://lore.kernel.org/intel-xe/Z1q3F81k2TkUzKW7@phenom.ffwll.local/
[3] https://lore.kernel.org/intel-xe/176520185138.24350.8954844301177099832=
@jlahtine-mobl/
[4] https://lore.kernel.org/intel-xe/20250808104356.3294210-11-mika.kuoppal=
a@linux.intel.com/
