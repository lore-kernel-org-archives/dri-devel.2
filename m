Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E0EC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7541E10F092;
	Thu, 23 Jul 2026 10:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SabaAzNG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E70B010F08E;
 Thu, 23 Jul 2026 10:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784804279; x=1816340279;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=0PB8su4G1eKB3XSVsRlqMqnAWMu6CGAlZtiLWpDi2hM=;
 b=SabaAzNGf3Y7B/MRkj+ITmh05yMLnqL5Yub/WdDEVB1Gej0BTRsCuSdQ
 ouWhfJlHxvA97RN25xPS1FfHKI6qfKgBIZzd2ul/CeaXDvxOlNaYNeKEk
 jN8bJPDxpuj6l3xTQWPW+WkjSE17Su6CdpV135ZjsQv3E0y/66HQJL4GI
 b2+cLN8t+yhtcLjlFF0lPyLrZ5M8qOke+mXF6Wv1N+E/vYUo+ZJi0r3KX
 9D0H3mC02ro7adltSgnm5huaPGGJ2JVLdRhq1z6MwJS8+fh5Khv3h9NHf
 c5cYOrgb1nVr3Gr+CnuKOy82dSooyTpq2Ih9PZGmEZ/HadaHlq5KvNBhI A==;
X-CSE-ConnectionGUID: WxKJRzHmR+23vF9FQ7vSKQ==
X-CSE-MsgGUID: 081tIxW7SjyVMjkpPYGPzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96113651"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="96113651"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:57:58 -0700
X-CSE-ConnectionGUID: 2LQHdUVxS4+fz/ihjmAW1w==
X-CSE-MsgGUID: hfuB00ZnRPS9EGoBj6BHrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="282893467"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:57:55 -0700
Date: Thu, 23 Jul 2026 12:57:52 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v11 0/3] Introduce cold reset recovery method
Message-ID: <amHzsHmNSH84SZ92@black.igk.intel.com>
References: <20260720101815.526813-5-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720101815.526813-5-mallesh.koujalagi@intel.com>
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

On Mon, Jul 20, 2026 at 03:48:16PM +0530, Mallesh Koujalagi wrote:
> Add support for handling errors that require a complete
> device power cycle (cold reset) to recover.
> 
> Certain error conditions leave the device in a persistent hardware
> error state that cannot be cleared through existing recovery mechanisms
> such as driver reload or PCIe reset. In these cases, functionality can
> only be restored by performing a cold reset.
> 
> To support this, the series introduces a new DRM wedging recovery
> method, DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)). When a device is wedged
> with this method, the DRM core notifies userspace via a uevent that a cold
> reset is required. This allows userspace to take appropriate action to
> power-cycle the device.

This one looks like to good to go.

Chris? André? Can you please help review so we can merge it?

Raag
