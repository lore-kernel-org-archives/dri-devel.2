Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF40CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D1210EE19;
	Wed, 17 Jun 2026 06:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lH7GSFc+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098C010EE12;
 Wed, 17 Jun 2026 06:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781677615; x=1813213615;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zR1nJnoLjqvQrhg/jKxvHUu/vdS1Qm/wTgP/TWCK9pc=;
 b=lH7GSFc+s7vMlR+SGAYz7367wZZpIr2xbh4+TjVyl7QmUxlqAy++VLZH
 IZlYN1E0444s9o4I5PE4EgGd5vbWgnEpLSkxEZa0AIlM6rUdptr8f4baG
 X1eVOoqyFt54IoCZDXaqrD5NPfV8vOLP3URnFCtxXqmemSSpuNQ+zVnNT
 2RUf4aJi3SmFsQo1NsEjoywdii3tJQoi2JEYEX6on8HzfRiLNsdLl41kR
 WPQw/ychuzCiyMVTlTmviWq5caFpc+2See+c3B9kxA2gqZhdPY0zI4Hfo
 E9sP5BcNTeJ+f7kwdh/yOF0quDQsxKup5mt6nJXRE4IECPFo1NEUgHUGu w==;
X-CSE-ConnectionGUID: vgtvQi7mQWqwSeigQM4gPw==
X-CSE-MsgGUID: 1wmdS2ASREeMffk10hv+mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93029384"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="93029384"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 23:26:54 -0700
X-CSE-ConnectionGUID: CBg9umjjRH2UuKHjDZ2blg==
X-CSE-MsgGUID: d2f0PuEcTsqvNi3LZ20mtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="248059448"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 23:26:51 -0700
Date: Wed, 17 Jun 2026 08:26:47 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
 kuba@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 dev@lankhorst.se, zachary.mckevitt@oss.qualcomm.com,
 rodrigo.vivi@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, mallesh.koujalagi@intel.com
Subject: Re: [PATCH v3 3/4] drm/xe/ras: Add support for error threshold
Message-ID: <ajI-JwsLcVWoUiqj@black.igk.intel.com>
References: <20260604184849.1011985-1-raag.jadav@intel.com>
 <20260604184849.1011985-4-raag.jadav@intel.com>
 <4d3720e1-1268-4a17-a8f8-f03e82aa1c5b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d3720e1-1268-4a17-a8f8-f03e82aa1c5b@intel.com>
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

On Mon, Jun 15, 2026 at 01:47:02PM +0530, Tauro, Riana wrote:
> On 05-06-2026 00:16, Raag Jadav wrote:
> > System controller allows getting/setting per counter threshold, which it
> > uses to raise error events to the driver. Get/set it using the respective
> > mailbox command.

...

> > +	xe_dbg(xe, "[RAS]: get counter threshold %u for %s %s\n", *threshold,
> > +	       comp_to_str(counter->common.component), sev_to_str(counter->common.severity));
> 
> "get threshold" to be consistent with <operation> <value> <component>
> <severity>
> and other prints

I thought "counter threshold" was the correct[1] terminology?

Raag

[1] https://lore.kernel.org/intel-xe/ahgNW0Z9eQmQzGzY@black.igk.intel.com/
