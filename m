Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7E5C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A0110EB82;
	Tue, 22 Sep 2026 06:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ecUmEAjP";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FD6410EB87;
 Tue, 22 Sep 2026 06:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790059605; x=1821595605;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=yPlIafrpnAyWQ6dzKtmbn4aRjT+0Imp8WqIlko9zOJM=;
 b=ecUmEAjPcCA4f1FVERg5pIRdNiUmu6Zlw70fUkj9fjYqtFJhwuZsUh40
 6xg79Zi3ZqKZFZAFWT6SyCXWXIGvC+l4bIrdqFXWlO7G4g2W9u0p4K3uK
 npZOlo7uFIPzxiSCzcz3poXEl7ie6f15Lbw/izigUyp6ZAa0bIHbgGnrM
 JJQihbujDGQELBAgdQvg7TnHXkc0/S2k48pgmNknmwrK2D25LQbrpbp7X
 iJMwGhQyK12gg1AjK49Z6LkjZhk/k4qcQ90bsFwexo5DnPm9KxLAPUhK6
 XaDDkvtDkGxwCu2ybq3xVa0BUGdruZ8e+ROV77Y9fkLibAVBmDcY7xuEB Q==;
X-CSE-ConnectionGUID: FkRbRT6qQ5yi6NwziM8dkg==
X-CSE-MsgGUID: Qgjl7xiOSMGhJ/6loI0tkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="116155749"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="116155749"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 23:46:44 -0700
X-CSE-ConnectionGUID: 2NX+KT+/ROaGkJ9fn/2s3Q==
X-CSE-MsgGUID: P3NALla7T9C4U/dsO9+pqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="273168760"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.25])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 23:46:42 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <PH8PR11MB8040EFAAE8210F2C6B53AC1BF4842@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <20260630223946.2107382-1-jia.yao@intel.com>
 <20260630225349.984AB1F000E9@smtp.kernel.org>
 <178290749714.224587.15234445443946207851@jlahtine-mobl>
 <178292444166.273574.16738251742448073960@jlahtine-mobl>
 <PH8PR11MB8040EFAAE8210F2C6B53AC1BF4842@PH8PR11MB8040.namprd11.prod.outlook.com>
Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Roper,
 Matthew D" <matthew.d.roper@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
To: "Yao, Jia" <jia.yao@intel.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Date: Tue, 22 Sep 2026 09:46:39 +0300
Message-ID: <179005959984.27165.4749331452130832177@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
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

Quoting Yao, Jia (2026-09-21 20:33:03)
> Hi @Lahtinen, Joonas,
>=20
> The key is LSC_CHICKEN_BIT_0 is a global register.
>=20
> Even we use per-client,  we should consider the following cases:
>=20
> 1. Should conflicting configurations within a client be rejected?
> I recommend the first setting should be latched.

From uAPI perspective it would be simpler to set this at the DRM client
level at once. However we don't seem to have such uAPI in active use
currently (all drm_noop) so you'd have to compare the complexity between
indirectly setting it at DRM client level by first created context or
adding such an uAPI to set it explicitly per client.

> 2. Should conflicting configurations across different clients be rejected?
> I think the latter setting can cover previous one.

DRM clients need to be indepenent from the driver perspective,
we can't do that.

The whole point of making it per DRM client is that given the
impacted SKU only has 1 CCS engine. We have the address space
matching requirement between CCS and RCS, so when both CCS and
RCS are running, we know they belong to the same DRM client and
thus they will not conflict with the WA mode. And if only one of
them is running, there can be no conflict either as it's just one
context.

> Even like this, still can't cover all the race condition.

Which race conditions do you think would remain? We definitely
have to eliminate any race conditions to land this.

Regards, Joonas
