Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5869CCD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 09:40:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CDED10E098;
	Mon, 25 May 2026 09:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KO39SrHQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B0BA10E084;
 Mon, 25 May 2026 09:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779702005; x=1811238005;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=Pb8ZxQLNtSWGEc+bq65SJao1sGnUBNpWPTxHc1Pbs1c=;
 b=KO39SrHQ/CJjX+WdBUsgSZAPkM7gB7dhe/EMkI2K2g9rO4v4Z3KGyreK
 hmLr+wUZ0Czuf/7jYdzHeqiiO8JVXpSFb/YyAq92S39uLgzRw8U/NcTJa
 f5xJtbuclLNtPqbuWLDzJikRj9NWZiwH8zp9Z6MhKOm4ER/cTJzyuk6+f
 Gfcrw/Oo062svXp+jQu0/MlTMtrR4dMXv6bkJBJCcs2bhwH9DZulhUxRI
 Eo7QPALG0oynXVRISSzcy3swfyOhrs92laFVUh0IMfkynQyci1bhuzHc/
 37nBepT+T7PdXytUTbe52ezt/aFPrfxkcwVj1MdSrn5b412VAuZ4lGm6l A==;
X-CSE-ConnectionGUID: 8rfbNAaNTwae6lLxpwn2Gg==
X-CSE-MsgGUID: WGiq7rKsQXmbOxJgwQmMiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="80375622"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="80375622"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 02:40:05 -0700
X-CSE-ConnectionGUID: 9KGJoRI7Tz6kKYzesS1/IA==
X-CSE-MsgGUID: DgFjbGTLThq4/L2V7xvC9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="245836079"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.245.216])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 02:40:02 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maarten Lankhorst <dev@lankhorst.se>, "Borah, Chaitanya Kumar"
 <chaitanya.kumar.borah@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, intel-xe@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, Chandra Konduru
 <chandra.konduru@intel.com>, dri-devel@lists.freedesktop.org, Matt Roper
 <matthew.d.roper@intel.com>
Subject: Re: [PATCH] drm/intel/display: Add support for pipe background
 color (v4)
In-Reply-To: <f1f09a62-b36e-4ddf-b42c-dad300a72aef@lankhorst.se>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260505200133.636584-2-dev@lankhorst.se>
 <a734e41d-3665-402b-a56a-43fd4f8819ff@intel.com>
 <fef9056c-460e-4a49-bed8-f2882109e886@linux.intel.com>
 <090aca95-975d-4564-8b44-30df139800b5@intel.com>
 <f1f09a62-b36e-4ddf-b42c-dad300a72aef@lankhorst.se>
Date: Mon, 25 May 2026 12:39:58 +0300
Message-ID: <a24f9d8ecff945b2cdc032ae95bdc834ee9c248a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, 22 May 2026, Maarten Lankhorst <dev@lankhorst.se> wrote:
> Den 2026-05-18 kl. 12:47, skrev Borah, Chaitanya Kumar:
>> I will leave the name change up to your discretion. The i915 CI needs a re-run, though.
>> 
>> With the typo and checkpatch issues fixed, LGTM.
>> 
>> Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>> 
>
> Addressed and renamed the functions.
> Pushed!

Please do not change patches while applying.

It's only okay to tweak commit messages, whitespace and maybe comments,
but function renames need a new version on the list. There are no
exceptions.

Commit e2d57ceaa72d ("drm/intel/display: Add support for pipe background
color (v4)") in the tree says it's v4 and references this patch, but
they're not the same.


BR,
Jani.

-- 
Jani Nikula, Intel
