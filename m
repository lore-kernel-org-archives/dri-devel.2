Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F95F606A889
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EsunEpnm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC32D10FED0;
	Thu, 12 Nov 2026 08:50:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0C710FEFF;
 Thu, 12 Nov 2026 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794473443; x=1826009443;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=0cRgJukoLH2zcawqnkWfRnoUqNVumfa7QuGwwa1GPRY=;
 b=EsunEpnmaWJZoLPbBvq2d5Wvuw7s9MntahZSXomkz0o/wBZocHciLelY
 BYToU35ikKzNO/x/1jg4w4ByjOEXmwBaUGALeS0BMS8pYzLi4sIiy5b5n
 w4VM2J/5RNjyNQTRDgHAD1tLebrHXLn52JiMdoUOQ7Wxjh9h6Q7Pe6zDz
 1GHKn7SfCDbYUjPb46ffGqvRcEaildMT5tNXNCGQit7k935PyYesR55ZE
 GGLi7yitCM2NRCHnzUSQBzF97oQVa7fDeesqevMwDaMgIRog7UckSYE+a
 wHCeZELXCbUgZbssjWi9PI2fL2LnwT6vaWlLnlKgGFMms9XMHLE3I9Fc7 w==;
X-CSE-ConnectionGUID: 8boP//zcQCmJaTBUVf0eRA==
X-CSE-MsgGUID: rgpfu5YsT62s2WBOc1DFIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3133789"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3133789"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 00:50:39 -0800
X-CSE-ConnectionGUID: MuP2Eu1ATFG/FmKFf3ww/g==
X-CSE-MsgGUID: f6JZawhnSeCE6YlmyoFGYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; d="scan'208";a="10378908"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.13])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2026 00:50:36 -0800
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <IA1PR11MB641869284E0505A68FF8E8E5FA712@IA1PR11MB6418.namprd11.prod.outlook.com>
References: <20260816014552.14969-1-krishna.prabhakaran@intel.com>
 <179439387311.199148.11937438921736048164@jlahtine-mobl>
 <IA1PR11MB641869284E0505A68FF8E8E5FA712@IA1PR11MB6418.namprd11.prod.outlook.com>
Subject: Re: [PATCH v2] drm/i915/dmabuf: avoid global wbinvd on dma-buf import
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>, "Vivi,
 Rodrigo" <rodrigo.vivi@intel.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>, "Auld,
 Matthew" <matthew.auld@intel.com>,
 "thomas.hellstrom@linux.intel.com" <thomas.hellstrom@linux.intel.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
To: "Prabhakaran, Krishna" <krishna.prabhakaran@intel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
Date: Thu, 12 Nov 2026 10:50:33 +0200
Message-ID: <179447343321.19032.17914586221108159466@jlahtine-mobl>
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

Quoting Prabhakaran, Krishna (2026-11-12 07:29:14)
> > No bug opened for issue, no exact hardware config described, no dmesg
> > logs.
> >
> > Also, if you import a new dma-buf too frequently, probably shouldn't
> > do that.
>=20
> This feedback was on v2, but it still applies to v4. The setup is an ARL-=
S host running multiple VMs, with all VM's playing video. A persistent audi=
o glitch was heard during the playback. Here's a perf call tree captured fr=
om the host QEMU process during video playback indicating that this was sta=
rving the QEMU processing thread.
>=20
> virtio_gpu_resource_flush                     45.45%
>   i915_gem_execbuffer2_ioctl
>     i915_gem_do_execbuffer
>       eb_validate_vmas
>         i915_vma_pin_ww
>           i915_vma_get_pages

This is already a point where you have fallen off the hot path and you
should really look into your application code or virtio gpu code to
optimize it to stay on the hot path (try_qad_pin succeeds).

You should not be importing a new DMA-BUF per frame, but should instead
keep recycling existing ones. If you keep using new buffers, you will be
finding more and more hot spots in the code as a fresh BO (DMA-BUF or
not) each frame is going to take a hit on the performance no matter
what. It's not how you're supposed to write applications.

>             i915_gem_object_get_pages_dmabuf   36.65%
>               wbinvd_on_all_cpus               35.95%
>                 on_each_cpu_cond_mask
>                   smp_call_function_many_cond  35.92%  (29.74% self)
>                     __wbinvd                    7.38%  (self)
>=20
> This profiling data is what motivated the patch.

This profiling data is not that interesting in itself because it's
for a very suboptimal usage scenario of the uAPI.

How do the numbers look like after the patch applied? It's the
relative improvement of i915_gem_object_get_pages_dmabuf()
that is of interest between baseline and this patch applied.

Regards, Joonas
