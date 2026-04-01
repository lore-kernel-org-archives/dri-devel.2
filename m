Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554EBD3517B
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 12:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CFA310E345;
	Wed,  1 Apr 2026 12:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lkCX4spe";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3311B10E345
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 12:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775047507; x=1806583507;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=Dlm8u1M9Y25VFWBj4wxzmFiwOI2m8boBhF6KqF1/Csc=;
 b=lkCX4speR13G5adySTkkupLRRXEwEgww3/RKuuWyOGJB9PU5735DBCMF
 5/lOI+aySOSPsbEeIfOpeuHNn9LZHPKWX7NEuy42+Ga/IOPRGULmIBbU6
 Cls7S2h8Ie+39L8l+h/Nj0SqAU9aCn2WmleqjI6F3TwZ9H7Zg50YQ4ruR
 PwrW3g2v4HqAf/8x+pWA/D0moKX4fPrdOtlUD2wwN/RBicsDsxfKH9Mc5
 1Ffv9UN4YFlfEWOYveNgX4B3C+I93WmD6otkYrYUuG2cOzU+LvwG1uGrG
 1zc1mj/BhkSgDlwaZpNcucUK1NvH+ZlQAV8pmiqh+EDSJgpoEmQAR5dct A==;
X-CSE-ConnectionGUID: DwtFWW1HRZq8WJL9jse+6A==
X-CSE-MsgGUID: cBQA0mPBRCaf+CwMFz3h+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="75963176"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="75963176"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 05:45:06 -0700
X-CSE-ConnectionGUID: yNEaq/s1SI2BIt62UL8L2w==
X-CSE-MsgGUID: RBJEc1KBQYmduxzbAf9YsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; d="scan'208";a="220013842"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.246.152])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2026 05:45:03 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, ysato@users.sourceforge.jp,
 dalias@libc.org, arnd@arndb.de
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] arch/sh: Drop CONFIG_FIRMWARE_EDID from defconfig files
In-Reply-To: <808dcd39-ed04-4288-9b21-55b47354de17@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260401083242.214492-1-tzimmermann@suse.de>
 <b7c978f9728c1a1197e90a98bcec5e8e4dc7e7ec.camel@physik.fu-berlin.de>
 <808dcd39-ed04-4288-9b21-55b47354de17@suse.de>
Date: Wed, 01 Apr 2026 15:45:00 +0300
Message-ID: <8a7e78415ac5d83ae220125b32fd68a4e629eca4@intel.com>
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

On Wed, 01 Apr 2026, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> Am 01.04.26 um 10:46 schrieb John Paul Adrian Glaubitz:
>> My SH7785LCR board does have a DVI output as well as a Silicon Motion SM-501 video
>> chip though, so I think it should be able to perform EDID in general. Or is the
>> protocol actually tied to the x86 architecture? What about monitors on a PowerPC
>> workstation, for example? Does EDID not work there at all?
>
> Yes, your system can fetch the EDID via the Linux driver. But 
> FIRMWARE_EDID is a special feature where the EDID gets delivered by the 
> boot loader. This has always only been possible on x86 or with EFI.

And then there's the completely separate CONFIG_DRM_LOAD_EDID_FIRMWARE
config to allow loading the EDID through the kernel firmware loader. Not
confusing or misleading at all. ;D

BR,
Jani.


-- 
Jani Nikula, Intel
