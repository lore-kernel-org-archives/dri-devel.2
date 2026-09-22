Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B29C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B62D10E695;
	Tue, 22 Sep 2026 10:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="idYzpS6A";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21FC710E695;
 Tue, 22 Sep 2026 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072157; x=1821608157;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=OSd4djI2Od9MmVAuT2omP4zq0v6dVb6/UQgKD1vfLvk=;
 b=idYzpS6ABfbeL1ckuYk+Dj5nF4WIs3jn9S2D5+fJVZvkzkMOfkmvZdh/
 N1KqKrjeG/TcUkPmXSQ0hHTZDskKxnCPMEctgFi5WgGg/nha5BBFW+Ytg
 VY7pSSQo7/JraAN7/VNnZMrkCHfry+j1bpx+YiXYyNWnjIGn//j03YLRM
 UXueYROHxv1kzDIaN2qkRbD5wnuNExvOYzg+EcN5gFuU2lFI9jyAH/CgN
 /rz1lEW6sop1gCYJTyLDB1K+XAJuOiQXf8AcTuIARhzNiciF0X2TQhowG
 ll9BtQuKgUBMluJSvSW78Hn/M+yTXSxTFq0B8bDK0JnKVSDRv01/pq4id w==;
X-CSE-ConnectionGUID: ezpByZSjT32IrilNy8jDAg==
X-CSE-MsgGUID: MWLfrlcBTDKijSmftOE22Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="89584250"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="89584250"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:15:42 -0700
X-CSE-ConnectionGUID: qZP7mBLKS7m0/LHe2iVP4A==
X-CSE-MsgGUID: zUu/thz3RGaZh6pNgJHSNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="269598131"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.71])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:15:40 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: fix incorrect RCU teardown order
In-Reply-To: <026cf5c2-585d-4171-b27f-74cd01e81b02@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260903113621.54660-1-christian.koenig@amd.com>
 <87116b9512796cf3ac2db310aa320f94a87a96e4@intel.com>
 <026cf5c2-585d-4171-b27f-74cd01e81b02@amd.com>
Date: Tue, 22 Sep 2026 13:15:37 +0300
Message-ID: <83460db11dbe17d056df27e0e088f0ffec98ae50@intel.com>
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

On Tue, 22 Sep 2026, Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> Because of that I have an exception from my manager to use my gmail
> account to send patches with a "Reply-To: christian.koenig@amd.com" in
> the header.

Do you have sendemail.from in git config set to your AMD address? That
should allow you to send patches from wherever, and have the AMD address
show up as author.

If you look at Ville's patches for instance [1], they always have the
From: in the patch body, and git am uses that for the author.

HTH,
Jani.


[1] https://lore.kernel.org/r/20260909161730.12969-2-ville.syrjala@linux.in=
tel.com


--=20
Jani Nikula, Intel
