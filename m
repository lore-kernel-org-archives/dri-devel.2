Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACFFCD342C
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 10:30:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5F310E3C6;
	Mon,  4 May 2026 10:30:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HCg1h+tu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99AC110E3C6;
 Mon,  4 May 2026 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777890635; x=1809426635;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=sTazwSjmYttTNRbWgqabPhFUJLDyFME2KhuOLmOKwz8=;
 b=HCg1h+tuS6D34BbwY2tKgZbORAqBrDmNaebWk9req1lFMEu9XK4uXqnV
 I9nC4U23uy8GQGo8zni7Apf9AqvWxlR47dpZcl97HLORuMtNVR9dSMm6w
 C3gYQk5ocJvUbtYFu2tqhcYvkptokkDcw2FgLkhfNySe0tfixWd30n8eq
 fEReN5MeFHIqPIATQ/A6F0aARN/QFMVmdgfwFVHNvvZBs5sEtAVBHJ9vh
 pk1eSoKRQs553OLhLEIG7IkCjhgVV5Ba0V6G+zhnoit1H6NUCVcTfQUN/
 nb/BivFLQhjh/3DLp1ZSg00V3Rf2I6tRmURAHxcm1ycGUVbMR2zX2X00+ g==;
X-CSE-ConnectionGUID: y/9ZnlIDT6aesU8tN+FZ7Q==
X-CSE-MsgGUID: rHY3LIvKQYGG7kzsbjjE6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78677631"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; d="scan'208";a="78677631"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 03:30:35 -0700
X-CSE-ConnectionGUID: 7xWd9ivJSPaZ4rC+Q+mKdg==
X-CSE-MsgGUID: iDMyX4RTTXS1oKd63l1LwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; d="scan'208";a="237254936"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.157])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 03:30:32 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Simon Ser <contact@emersion.fr>, Ville =?utf-8?B?U3lyasOkbMOk?=
 <ville.syrjala@linux.intel.com>
Cc: Vidith Madhu <vmadhu@nvidia.com>, dri-devel@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, xorg-devel@lists.x.org
Subject: Re: Native DisplayID support in core DRM
In-Reply-To: <nNHAgq_075xcIstZgSRJ0LASnvNd7FP6D2XfBPVa3SyjPX1nErxrrRqEIcd4nO7a0WY-pvrTS9NOR_ESqsHGsbpuLNRBGdzyn6-Vi-QSyPQ=@emersion.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <55f5affb-e8f5-7f8e-fce6-47c5b379d557@nvidia.com>
 <aeaJlED2e1ZXsLlt@intel.com>
 <nNHAgq_075xcIstZgSRJ0LASnvNd7FP6D2XfBPVa3SyjPX1nErxrrRqEIcd4nO7a0WY-pvrTS9NOR_ESqsHGsbpuLNRBGdzyn6-Vi-QSyPQ=@emersion.fr>
Date: Mon, 04 May 2026 13:30:29 +0300
Message-ID: <faf56da55c4a67edc2474134eb335bbd874f684b@intel.com>
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

On Thu, 30 Apr 2026, Simon Ser <contact@emersion.fr> wrote:
> The big one here is the "EDID" blob property exposed by KMS. We can't just put
> a DisplayID blob in there, that would break user-space. We'll need a new
> property.

I think the big question is what do we do with the EDID property when we
encounter a display with native DisplayID.

The VESA E-DDC spec says the host should try DisplayID first, and not
read the EDID if a DisplayID is found. However, if we only update the
DisplayID property and not the EDID property, I think that'll be a
regression.

So maybe we need to read both DisplayID and EDID, contrary to what the
E-DDC spec says. Obviously that means slower detection overall, for all
displays, old and new. Especially if there are errors reading DisplayID,
which you'd expect with old displays.

There's an additional catch. The E-DDC spec says the capabilities in the
DisplayID don't need to be a strict superset of the capabilities in the
EDID. The idea is that the DisplayID is for new hosts, and the EDID is
for legacy and max interoperability. But if we read both and aim for no
regressions, we'll have to expose a union of the capabilities.

Strict adherence to spec isn't exactly what EDID is known for. We're
likely to encounter displays where the DisplayID and EDID contradict
each other, and we'll have to mediate between them.

And what userspace does with all of this is a mess of its own...


BR,
Jani.


-- 
Jani Nikula, Intel
