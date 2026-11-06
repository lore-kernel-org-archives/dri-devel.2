Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD59606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jX/neGOv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33E0610E999;
	Fri,  6 Nov 2026 00:08:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03413112A28;
 Fri,  6 Nov 2026 00:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793923712; x=1825459712;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=GAhIFHGgpK+/gmBI+fcdZaWTlP9imu2O5XRQejhlP+w=;
 b=jX/neGOv/fxToonkwkjabDyPWmdV/niN6+Ah1vCuycIuwpBJdnEQLwKR
 RoAic1z17rDpzazp/IsjGSYDa9L3yNuB9RnLPd98QYEC6JWB3MkND0nqP
 ffR2us//F6SUtWo7Q+Yeh8EIZVgWfN5R+lQtPI52We2Iha+XQdq7jYxcQ
 Zj/ODQtreMYTlqsmRV+5HYAdmfdxrlaM4/9k8a+OhWR4IqKaCQxNjLfh8
 ZyXHyqpAvhwRuD1GXbebzFjDhMVo5BlXC5yGjm2YGgi9Ri6TWWSgJIneU
 GyeeTclAUyO7Guwh74wTQwI7i+MxSDxYzGU4aRQi+5GzIl6jOUqfX9B97 Q==;
X-CSE-ConnectionGUID: 6Kx19berRsWIbMS6AHpjPQ==
X-CSE-MsgGUID: T2ZoL13GRyWxCszNmQV0rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2627820"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2627820"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 16:08:32 -0800
X-CSE-ConnectionGUID: ygkoJBd1Q+G5xaFU4G0jiA==
X-CSE-MsgGUID: 6YxtbCpxT2a2eRnnR1X8ZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7023944"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.110.106])
 ([10.125.110.106])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 16:08:31 -0800
Message-ID: <3dc05c1e-fe02-475b-a525-7c53081e816a@intel.com>
Date: Thu, 5 Nov 2026 16:08:30 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Nasty console and xe driver interactions
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Zack Rusin <zack.rusin@broadcom.com>, dri-devel@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>,
 intel-gfx <intel-gfx@lists.freedesktop.org>, intel-xe@lists.freedesktop.org
References: <5e79d3c0-5b2c-4e6c-ba38-3b723daf7109@intel.com>
 <atDXDlI-EhrA791a@intel.com> <d4d5302f-9768-4122-bbab-4384ef7aa9fe@intel.com>
 <atD66da36wMZ0gie@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <atD66da36wMZ0gie@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/15/26 09:10, Rodrigo Vivi wrote:
>> BTW, "xe.force_probe=!*" on the command-line also gets the output back
>> to normal.
> the force probe proves that we can still probe safely, but apparently
> on my first attempt I missed the fact that pcim_enable_device will
> touch the device and register a pci_disable_device that might
> clear stuff and mess with the VGA fb...
> 
> Perhaps if we move just one step over:
> 
> https://github.com/rodrigovivi/linux/
> commit/616cd8c1b4d4414cd1f7ad56fa5d8abd36d7968d

So I gave this exact commit a go. It still seems to have the same basic
problems. I put the missing "ptl_guc_70.bin" file in place, but it just
moved over to needing the "huc" and went back to the no console
behavior. I added the "huc" and the "gsc", which seems to make the
driver happier, but the screen has garbage. Looks like I may be missing
one of those MEI drivers.

But, still, the driver seems to be rather aggressive about killing the
console even before it is working itself:

> [    0.672748] xe 0000:00:02.0: vgaarb: deactivate vga console
> [    0.673227] xe 0000:00:02.0: [drm] Running in SR-IOV PF mode
> [    0.676750] xe 0000:00:02.0: [drm] Tile0: GT0: Using GuC firmware from xe/ptl_guc_70.bin version 70.72.1
> [    0.914206] xe 0000:00:02.0: [drm] Tile0: GT0: ccs1 fused off
> [    0.914213] xe 0000:00:02.0: [drm] Tile0: GT0: ccs2 fused off
> [    0.914214] xe 0000:00:02.0: [drm] Tile0: GT0: ccs3 fused off
> [    0.935645] xe 0000:00:02.0: [drm] Tile0: GT1: Using GuC firmware from xe/ptl_guc_70.bin version 70.72.1
> [    0.937939] xe 0000:00:02.0: [drm] Tile0: GT1: Using HuC firmware from xe/ptl_huc.bin version 10.3.3
> [    0.938382] xe 0000:00:02.0: [drm] Tile0: GT1: Using GSC firmware from xe/ptl_gsc_1.bin version 105.0.2.1397
> [    0.938855] xe 0000:00:02.0: [drm] Tile0: GT1: can't init GSC proxy due to missing mei component
> [    0.959120] xe 0000:00:02.0: [drm] Tile0: GT1: vcs1 fused off
> [    0.959139] xe 0000:00:02.0: [drm] Tile0: GT1: vcs2 fused off
> [    0.959150] xe 0000:00:02.0: [drm] Tile0: GT1: vcs3 fused off
> [    0.959159] xe 0000:00:02.0: [drm] Tile0: GT1: vcs4 fused off
> [    0.959168] xe 0000:00:02.0: [drm] Tile0: GT1: vcs5 fused off
> [    0.959177] xe 0000:00:02.0: [drm] Tile0: GT1: vcs6 fused off
> [    0.959186] xe 0000:00:02.0: [drm] Tile0: GT1: vcs7 fused off
> [    0.959195] xe 0000:00:02.0: [drm] Tile0: GT1: vecs1 fused off
> [    0.959205] xe 0000:00:02.0: [drm] Tile0: GT1: vecs2 fused off
> [    0.959214] xe 0000:00:02.0: [drm] Tile0: GT1: vecs3 fused off
> [    1.024100] [drm] Initialized xe 1.1.0 for 0000:00:02.0 on minor 0

BTW, I am building the "xe" driver in. It's causing all kinds of fun
problems, like needing to manually add xe firmware to my initrd.

Maybe the:

	config DRM_XE_DISPLAY
	        bool "Enable display support"
	        depends on DRM_XE && DRM_XE=m && HAS_IOPORT

DRM_XE=m dependency is biting me. Is it stealing the console before it
knows it can actually display something?

