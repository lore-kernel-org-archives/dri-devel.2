Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFF9CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 06:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DC4D10ED7C;
	Mon,  8 Jun 2026 06:31:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AWBv+Sqg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F50A10ED75;
 Mon,  8 Jun 2026 06:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780900291; x=1812436291;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=awuMcxbXTMkZ+PyLY0+vB3624tO1jtfSCHJ8tXoxTS8=;
 b=AWBv+SqgkzL6y8zXslktHKjkUOSfvwGL6vX6ucoSaTuwvh2fx3UHtPPg
 2TS9i2FJ+ly2CkpO4ncFZY2OqVisZEEtGLMcCRdHhOYO9pD8WInvpcdlD
 kdB1yb6583Pe+vNK0rrAV1I6Pe7+KrTErDGfDrgBS0e27jpbIOy7wwIIv
 jFYiRgrRD1kOej0a1uSudppeOsLXsHk1MoanEAudMOps15iYArK6xBj/B
 Q+/MDlvOeL09ZMtnsW7Tahqr/EetjL43xFc6iVF+UE36bTfqSheAhJSeZ
 z8xcMgKfLKjD/dsLbQU4iEVu6a0Qf4gkgUClu9OYmzObN+ZdAJ+CWKUlG g==;
X-CSE-ConnectionGUID: qPVOEchxQZucF5jAPVti4Q==
X-CSE-MsgGUID: t6SAl4N3Qi+b87jnXvlf2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81373033"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="81373033"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2026 23:30:57 -0700
X-CSE-ConnectionGUID: A6n/4EdHQWu+bMNOrVccOA==
X-CSE-MsgGUID: rItbTfQJTL2/9PYrU89ndA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="242479400"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2026 23:30:53 -0700
Date: Mon, 8 Jun 2026 08:30:51 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v7 3/6] drm/doc: Document DRM_WEDGE_RECOVERY_COLD_RESET
 recovery method
Message-ID: <aiZhm1wCzTGNk4X-@black.igk.intel.com>
References: <20260605122544.1021695-8-mallesh.koujalagi@intel.com>
 <20260605122544.1021695-11-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260605122544.1021695-11-mallesh.koujalagi@intel.com>
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

On Fri, Jun 05, 2026 at 05:55:47PM +0530, Mallesh Koujalagi wrote:
> When ``WEDGED=cold-reset`` is sent, it indicates that the device has
> encountered an error condition that cannot be resolved through other
> recovery methods such as driver rebind or bus reset, and requires a
> complete device power cycle to restore functionality.

...

> +    if [ -e "$PCI_DEVS/$dev" ]; then
> +        echo "Done: $dev is back online."
> +    else
> +        echo "WARNING: $dev did not re-appear after reset."

... after "rescan".

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
