Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACBDF53D9A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 20:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F205010E0D6;
	Mon, 16 Mar 2026 20:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kORMXp2L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C4C10E05E;
 Mon, 16 Mar 2026 20:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773693380; x=1805229380;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=aN4FDeeozV915IKSfzJljt0wfVpcUnBOND4duNeTi1E=;
 b=kORMXp2LSssUxQw/irqbiyoTMkLJyVgvAU1z3nQWdLelT9ZPjfV24X3e
 RSNSFY/vKde174lM7T0REQnO3CWDhZWlrCO9kCHhxI6OwgDuxLaxKRr0z
 wlPR+GoBrS82NAG8dGH/hs91R0W/r7YfoyR7vV5W7SpPHkk4UiFVuQGC6
 lT2IyYnaXz6H0Zl7tjP01FeroTrkq4kw2ckDvXiMUSQrNz4SYa6C7LIRT
 3do7ZvbK2WcoF+71i3b4sVYViNtZLj8vCAM5jPT6o9SoWuCXxw6L2l3CH
 RNAuYr5h6iWnCYu+cGGF4sUuiqmGqrt4+qWsvBqSMf4PPMTt6ubJxydve A==;
X-CSE-ConnectionGUID: lw+1Ia4sSvCuu8T8hh4BxA==
X-CSE-MsgGUID: Y29/JweYRVGDXA29rtXokg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="78614797"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="78614797"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 13:36:19 -0700
X-CSE-ConnectionGUID: KtxU9sQOTR+jB9XDFrijpA==
X-CSE-MsgGUID: CAT5i3AmS3WAEeuciXRtRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221279918"
Received: from zzombora-mobl1.ger.corp.intel.com (HELO [10.245.244.233])
 ([10.245.244.233])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 13:36:18 -0700
Message-ID: <942eef488f5b6c75b7961547a5e8200f1f8799ad.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] drm: Provide a drm_dev_release_barrier() function
 to wait for device release callbacks
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org
Date: Mon, 16 Mar 2026 21:36:14 +0100
In-Reply-To: <99d0cdb184b5e67634f8306da0ffd7ffce2f041b.camel@linux.intel.com>
References: <20260316162002.13479-1-thomas.hellstrom@linux.intel.com>
 <20260316162002.13479-2-thomas.hellstrom@linux.intel.com>
 <9a5f1dab-eeba-477a-84cc-8e565b9c5de6@amd.com>
 <99d0cdb184b5e67634f8306da0ffd7ffce2f041b.camel@linux.intel.com>
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

On Mon, 2026-03-16 at 21:10 +0100, Thomas Hellstr=C3=B6m wrote:
> On Mon, 2026-03-16 at 18:42 +0100, Christian K=C3=B6nig wrote:
> > On 3/16/26 17:20, Thomas Hellstr=C3=B6m wrote:
> > > If helper components, like for example drm_pagemap hold
> > > references
> > > to
> > > drm devices, it's typically possible for the drm driver module to
> > > be
> > > unloaded without that reference being dropped,=20
> >=20
> > That is an extremely bad idea to begin with, drm_devices should
> > reference the module who issued them.
>=20
> They typically don't. If that were the case you wouldn't be able to
> rmmod a module and have device cleanup happen:
>=20
> module_exit();
>=20
> pci_unregister_driver()-><starts device removal>
> devm_release()-><drop drm device reference>
> drmm_release()
> ...
> <module unloads>
>=20
> I was under the impression that this was the behaviour of most device
> drivers and also drm drivers if display isn't enabled.
> (used to work with xe but doesn't anymore for unknown reason).

FWIW, it's display and mei taking an additional reference on the xe
module. Otherwise rmmod triggers an implicit unbind just as expected.

/Thomas
