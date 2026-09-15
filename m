Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 985EBC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB0010EBD8;
	Tue, 15 Sep 2026 16:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jPteS5vi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64BCE10EB01;
 Tue, 15 Sep 2026 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789490635; x=1821026635;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=SMkOx9gK9qzyOfgjR5uRghpGFA5qikwbfZzFZr1cCNk=;
 b=jPteS5vi/MDdKrvoJXDeF17HruSBQ18N6+Z6x+2ubfLPsAY7i+AXkM5H
 oGhrxmsmi9Fsk8uonULzZBJGgAOyCUO5W3cvhP9v6EPaq6v0ZvcgaQlkC
 onbViWShsefBj7Pd+BtIS/pXZyklsanFX+nZ3Cezo68hdxno3dk5PdL0p
 m8qf1DS6mNQVGrJWy6tSnhqdYp0xPtLBYFMGhyzAl4mqsH9tk15/djOFQ
 D/qV8GDN68wgDpagzD/RKeAgLz0n9Pd0Ze5qs3Qs2xvuUaap9p0uQJ0wq
 lhfGJkAKBYE/0jNRyZlfXn/8GxOU4Ogw/vt+d7pG4advA3v9vpKHavmIH Q==;
X-CSE-ConnectionGUID: /rWnCGenQ4WtqYJ3G62Seg==
X-CSE-MsgGUID: 4SzZP/hmQzKql/i7Zal/zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89706644"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89706644"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 09:43:55 -0700
X-CSE-ConnectionGUID: mEXtx4c6ThaXufpH7j8csQ==
X-CSE-MsgGUID: kCOmFT7fSYigXViEwjtpow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="266850777"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.243])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 09:43:53 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "Roper, Matthew D" <matthew.d.roper@intel.com>
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
In-Reply-To: <145460bc090d7406d03f1335feaadb07172cff20.camel@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260914215746.272721-2-alan.previn.teres.alexis@intel.com>
 <683c9836e408389852f6e6e956cc6862b1429b2a@intel.com>
 <145460bc090d7406d03f1335feaadb07172cff20.camel@intel.com>
Date: Tue, 15 Sep 2026 19:43:51 +0300
Message-ID: <f52c0b78ddae61cf668c89708b48ad82ba5f95dc@intel.com>
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

On Tue, 15 Sep 2026, "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com> wrote:
> On Tue, 2026-09-15 at 10:34 +0300, Nikula, Jani wrote:
>> On Mon, 14 Sep 2026, Alan Previn <alan.previn.teres.alexis@intel.com> wrote:
> alan:snip
>> >  int xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val, u32 timeout_us,
>> > -		   u32 *out_val, bool atomic)
>> > +		   u32 *out_val)
>> >  {
>> > -	return __xe_mmio_wait32(mmio, reg, mask, val, timeout_us, out_val, atomic, true);
>> > +	u32 read;
>> > +	int ret;
>> > +
>> > +	ret = poll_timeout_us(read = xe_mmio_read32(mmio, reg), (read & mask) == val,
>> > +			      10, timeout_us, false);
>> 
>> You probably do need to let the callers pass in the wait too. 10 us wait
>> with a long timeout is going to be pretty bad.
>> 
>> 
> alan: okay - perhaps i can make every caller pass in a polling-wait thats a fraction of their wait time.
> (as a starting point since i dont know what's the expected behavior of every caller).
> so perhaps something like "timeout_us << 4" (i.e. 1/16th) but pass in 10 us if its anything smaller than that
> (i.e. smaller than 16 usec).

I think you need to talk to the xe maintainers, really.

BR,
Jani.


-- 
Jani Nikula, Intel
