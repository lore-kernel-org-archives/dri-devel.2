Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D4EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 172A689E47;
	Mon, 29 Jun 2026 13:04:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cPkAAQWv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1761089E47;
 Mon, 29 Jun 2026 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782738282; x=1814274282;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=roUq0HgZG2spQtmWxczSIxhaz13hGW5+fW0oDsAWTqA=;
 b=cPkAAQWv/ushLS+UeB74ZLlP73gc4uqKVdbaOFo+yF4p5/rzoFI6g6r8
 xG21wQw5W/Xkf9Rjy97vYh29CHPyPDN0+Ut2ZWnIzPtfTGjPtqtz0VIoG
 P5a+SkINUs1Qfp4z6wBao7vNAo0PzUPcjNJ2jMwqBJN7eb3HjV4dlF0rX
 X3MD5Q0azhmZI3WFXyb6cnCVA6eSjIn8RXI9FoRsPCkLtoPPXFwQ5iMge
 zVQVutPJp3Bf/JAelwYVxCCa+ExuRuUpYlanYAuTxWW1joutSXbcry5XG
 KBUK/NZPIyPJeTNMyfMPSYxvn5HatyxrIdI49alK1i5b1GVMOlEOluwHR g==;
X-CSE-ConnectionGUID: 3JFvISr9SGSmhu50Drq5Zw==
X-CSE-MsgGUID: k3J/mznQR4elDRe+dRiQPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="83474567"
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="83474567"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 06:04:20 -0700
X-CSE-ConnectionGUID: IwiEzdBrSuqY5afV3Yz3UQ==
X-CSE-MsgGUID: fSOm1UQaT2qxvSdmnuWphw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,232,1774335600"; d="scan'208";a="250255687"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.200])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2026 06:04:17 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260628140327.46842-1-vulab@iscas.ac.cn>
References: <20260628140327.46842-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] drm/i915: fix kref leak in __live_active_setup error
 path
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: jonathan.cavitt@intel.com, tzimmermann@suse.de, kees@kernel.org,
 matthew.brost@intel.com, vulab@iscas.ac.cn, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
To: WenTao Liang <vulab@iscas.ac.cn>, airlied@gmail.com,
 jani.nikula@linux.intel.com, rodrigo.vivi@intel.com, simona@ffwll.ch,
 tursulin@ursulin.net
Date: Mon, 29 Jun 2026 16:04:12 +0300
Message-ID: <178273825261.121848.1051842737561955544@jlahtine-mobl>
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

Quoting WenTao Liang (2026-06-28 17:03:27)
> When heap_fence_create fails, the early error path calls kfree(active)
> directly instead of __live_put(active), bypassing the kref_put path that
> would call i915_active_fini for proper resource teardown. This skips
> cleanup of the i915_active state while the initial kref from kref_init
> remains unbalanced.

Is this AI generated? It hardly makes sense. The object was just allocated
and initialized, unbalanced kref which will be freed is not going to be
issue here at all.

Did you actually look at i915_active_fini?

Real reason to fix this would be to avoid the debug_object tracking to
get out of sync. That should be in the commit message and not some
generic high level description that can be read from the code
change itself.

> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
> Fixes: 5361db1a33c7 ("drm/i915: Track i915_active using debugobjects")
> Cc: stable@vger.kernel.org

In any case, we wouldn't put Fixes and especially not Cc: stable code
for selftests which need special Kconfig to build and modparams to run.

Regards, Joonas
