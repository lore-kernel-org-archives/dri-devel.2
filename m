Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEB4FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 08:10:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9754D10EA6A;
	Tue, 28 Apr 2026 08:10:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QurhIEsY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F5A10E09A;
 Tue, 28 Apr 2026 08:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777363833; x=1808899833;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=WzG9NeUJ9MAqO55tX19xs/F++pLlzg4Pb+Qbg/U4dTk=;
 b=QurhIEsYV5oZgvDYuPIbrmA3kq969J6nN9WZ0Bxi53qpUjaRP9BVFf6I
 fnsH6t1rOtBIa1jYe5URy700K+e2UF5rTacpP1oIqu+NRSZGvNlE3DgPi
 q+1WnQGxAd6APx9LT/XP1R48MkoNGVf97kguAUL8kOT8Gx0umj04Q9jG0
 qaTAFa1Cjcl7kv+AVZPJjPSQyOCmIxB7LkWpairuYoT6CXWI4vOp4oqLh
 FgVZYw8VdFPfOy8wt3yw/2psiK374sU3LMk0Ds2tBHSqjykK+jDSvFH6F
 xTPjueCITMuwT20D+xLzTXy/5c/266QXogr7rjN1Xp0XtGWDm6+r37pkV A==;
X-CSE-ConnectionGUID: CKP18vIPTA6nAtFJ70t7Vw==
X-CSE-MsgGUID: tegxtZbTTJyZVICPPu85vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="88960780"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="88960780"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 01:10:33 -0700
X-CSE-ConnectionGUID: ayZSej1IS/WHpis7HTLL8w==
X-CSE-MsgGUID: FaN76geAS8iuP2xl6TMYJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; d="scan'208";a="229530090"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.208])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 01:10:31 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Marc <marclecussano@gmail.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [BUG] xe: Lunar Lake hard freeze on USB-C DP-altmode (MSI MPG
 272URX), TC1 PHY pageflip deadlock, no kernel error before lockup
In-Reply-To: <CAF3NygikxYLtJzcjajSV4o68bjJ-9aPczPqzaHo_=r1OPoeaew@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <CAF3NygikxYLtJzcjajSV4o68bjJ-9aPczPqzaHo_=r1OPoeaew@mail.gmail.com>
Date: Tue, 28 Apr 2026 11:10:29 +0300
Message-ID: <2333cf303ab747e96172a6890efe0902f166585d@intel.com>
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

On Sun, 19 Apr 2026, Marc <marclecussano@gmail.com> wrote:
>   Thanks for any pointers =E2=80=94 happy to file at
>
>   https://gitlab.freedesktop.org/drm/xe/kernel/-/issues if preferred.

Yes, please. See [1].

BR,
Jani.


[1] https://drm.pages.freedesktop.org/intel-docs/how-to-file-i915-bugs.html


--=20
Jani Nikula, Intel
