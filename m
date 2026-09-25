Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990BAC9830D
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 09:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB91C10F9A6;
	Fri, 25 Sep 2026 09:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RXpTfNQ3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5700C10F9A6;
 Fri, 25 Sep 2026 09:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790329315; x=1821865315;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pinOX8WRyr3ERKakIVV56UL40/ntXRmy6CdeaaIRHKs=;
 b=RXpTfNQ3YKzUMkWG8iMMXKxN2dXl5Nw6M8qGyfUclqogeZJxnj9Bffzw
 ziJ70mzSE5ZwoPK8m2uPHR7+RrA5tsFTPZcLkGj+EURzqOGaULv24ybqd
 5jMCsJB6BqeY/MmFEdLEZYddJwGJhBJ1JkXp45EVVOQ6oDht2whG0OYmy
 BG96adTuV/HJIwcKVF9lmj9shuYKEtbLznqfmrSBk9SoDp+IQ4WA01ftH
 ZwzciKYU1eEWrXOhdxqnBa1guYC9QEWqS5kCrOZLlJ79jd74n8dnu4HvX
 lfNkPHuDAFyDT7COLsiDLFun5xmRcTBjK/Fvmh2X9Qi39bdPcWCIeJPy6 w==;
X-CSE-ConnectionGUID: A55rCrVUTEun+aa/ShaiSg==
X-CSE-MsgGUID: bHZGNGgdRpq+IdfJnC7kpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="108602586"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="108602586"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 02:41:54 -0700
X-CSE-ConnectionGUID: 3ShRyZ7aRBGJlskZZuKMvg==
X-CSE-MsgGUID: QsoZh8iATzmcCbfUS82mXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="278057352"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.27])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 02:41:48 -0700
Date: Fri, 25 Sep 2026 12:41:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aniket Limaye <a-limaye@ti.com>
Cc: Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Nirujogi Pratap <pratap.nirujogi@amd.com>, Bin Du <bin.du@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, vigneshr@ti.com, nm@ti.com,
 u-kumar1@ti.com, lianfeng.ouyang@starfivetech.com,
 Ritwick.Sharma@arm.com, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/3] i2c: designware: Add TI TDA54 I2C support
Message-ID: <arZB2s3HOBgSRuE4@ashevche-desk.local>
References: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925-tda54-upstream-i2c-v3-0-544d74e992ff@ti.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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

On Fri, Sep 25, 2026 at 12:26:27PM +0530, Aniket Limaye wrote:
> Add new compatible and update driver to support Synopsys Advanced I2C
> Controller (DWC_i2c [0]) present on TI TDA54 SoC. This is needed since
> this controller differs from the existing designware i2c (DW_apb_i2c
> [1]) in its register offsets and some register definitions.
> 
> The new compatible updates driver logic due to changes in register
> definitions:
> 
> - The new register offsets are handled by first refactoring the driver
>   to use a map of register IDs to their offsets.
> - Similarly, also update the driver to use an updated CON-register
>   bitfield definition.
> - Interrupts are acknowledged by writing a bitmask to a single CLR_INTR
>   register instead of reading N dedicated CLR_* registers;
>   i2c_dw_ack_intr() picks the right method based on dev->flags.
> - One HCNT/LCNT register pair is shared between standard and fast speed
>   instead of having one pair each; i2c_dw_write_timings() writes
>   whichever value set matches the configured speed.
> - No COMP_PARAM_1 register, so FIFO depth and high-speed-mode support
>   can't be autodetected: FIFO depth now comes from the required
>   snps,tx-fifo-depth/snps,rx-fifo-depth DT properties, and the
>   high-speed capability check is skipped.
> - No defined CON.RESTART_EN bit; treat it as always set.
> - TDA54 SoC does not support SMBus, so skip accesses to those registers.
> 
> [0]: DWC_i2c_reference.pdf
> [1]: DW_apb_i2c_databook.pdf

Still doesn't look good. The current register layout may be left as is. What
you need is translate it in the respective regmap callbacks in case we are
enumerated on the different IP. Also possible to have a different regmap
config for the different HW where you translate them only in one place.

-- 
With Best Regards,
Andy Shevchenko


