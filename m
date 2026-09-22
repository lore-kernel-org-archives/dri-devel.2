Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD5EC982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5C010E686;
	Tue, 22 Sep 2026 09:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="d6G3i3aF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7199510E663;
 Tue, 22 Sep 2026 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790069499; x=1821605499;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=43XnE4r/TAqVDuKvl/kOwfZAXAm+MITYr2qzpEvuA4Q=;
 b=d6G3i3aFVVFH/w89tyWSSErUbuAsyBGVmRvfnpzX0GkFGIJalLdh2Xu7
 IuYWx4cq+D9+520fUi8NU7TV//nIayruN363HSL3D9T3z2D1nHoF9JDsM
 6iK8PT/GHP8oyXwEb/uduAfcd3iTLLjK4KrxMDj0ql2H1S2SL+oXHr7LO
 uWWs+33AAUXV3BAaOYRc6RYn66ybr7X93CHDq9KHwqmd6mihs8IIzyMNc
 tw+tnWa410CbdeasYu7sHeRJ7rYQOgfFQTOQvM85slsPuQ3we52vt3vMg
 gLhyK5woaxrQLNt96tqW7Po0w4GIjfuGmVqh91vabQ/m6gVSxnGP9F/NV w==;
X-CSE-ConnectionGUID: OtG5K584Rlui7kY4eR8aWQ==
X-CSE-MsgGUID: sJnI/riaRbyjwbds67rZ5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89790349"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="89790349"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 02:31:38 -0700
X-CSE-ConnectionGUID: SPSuerpNRNy/C5xBv5NIqw==
X-CSE-MsgGUID: nd54ZIJ9SL2Cu5e1RO2U9Q==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.71])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 02:31:36 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: christian.koenig@amd.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: fix incorrect RCU teardown order
In-Reply-To: <20260903113621.54660-1-christian.koenig@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260903113621.54660-1-christian.koenig@amd.com>
Date: Tue, 22 Sep 2026 12:31:34 +0300
Message-ID: <87116b9512796cf3ac2db310aa320f94a87a96e4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 03 Sep 2026, "Christian K=C3=B6nig" <ckoenig.leichtzumerken@gmail.c=
om> wrote:
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Christian, this was already merged, but it's flagged by checkpatch with
From/Signed-off-by mismatch. I see that you've sent a bunch of patches
like this recently. Please configure git to add the same From: as your
Signed-off-by, or set the Signed-off-by to your From.

Though I don't understand how e.g. commit 643f9c6d862e ("MAINTAINERS:
change TTM maintainers to Natalie and Arun") got the AMD address as
author, even though the patch has gmail [1].


BR,
Jani.


[1] https://lore.kernel.org/all/20260915154804.605772-1-christian.koenig@am=
d.com/

--=20
Jani Nikula, Intel
