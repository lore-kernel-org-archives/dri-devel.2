Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510D4CD4851
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 08:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA40A10E109;
	Thu, 14 May 2026 08:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="efcop+x3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1039010E109;
 Thu, 14 May 2026 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778746415; x=1810282415;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gJgWgxdwkrHpP0tZCqS/Dzie4eikLFlevwmPkEuiNNo=;
 b=efcop+x34zSZNTxbBpzt9ic6K+fKLKuM0AuGkJ7glq3th+xmOjSYibPc
 jBurylXa21QSIJdjpA8K/sMMC2AHWdY0TS49iTNdufOuoa22sPcpIC0Jz
 xpnk7DauvkfG5dJrPgmCG4FHUY2weFYguav3CTSgIe6WakIOcQ8dfNVRN
 lVR+YYsBBJ1MBp5wRec9zZsFTINQhicEtYHZH4OE8EiAWqVe/LmR1CPOS
 Ke0P1uG3SVrmKHN2ubyXYUfla4CCdXlhsv4pT34hG216xiWfO6FQSBAMs
 sBCRtd+5viB4AUGRL9lLr41mISelutSP+IJAwKNVi7HMEwD5Oib05UzBK g==;
X-CSE-ConnectionGUID: yX6zwCXOQGGnyhCiErh6aQ==
X-CSE-MsgGUID: whizmiUNSq+rbs+2TqXMOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79855222"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="79855222"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 01:13:34 -0700
X-CSE-ConnectionGUID: oauRKe5OQUWv37N92gfF2A==
X-CSE-MsgGUID: v9/n7y2bQBSWDYuzlMrLTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; d="scan'208";a="242318220"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 01:13:31 -0700
Date: Thu, 14 May 2026 10:13:27 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com, andrealmeid@igalia.com,
 christian.koenig@amd.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 tzimmermann@suse.de, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com
Subject: Re: [PATCH v5 4/5] drm/xe: Handle PUNIT errors by requesting
 cold-reset recovery
Message-ID: <agWEJ8OqaNumks2C@black.igk.intel.com>
References: <20260512132614.1793083-7-mallesh.koujalagi@intel.com>
 <20260512132614.1793083-11-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512132614.1793083-11-mallesh.koujalagi@intel.com>
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

On Tue, May 12, 2026 at 06:56:19PM +0530, Mallesh Koujalagi wrote:
> When PUNIT (power management unit) errors are detected that persist across
> warm resets, mark the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET
> and notify userspace that a complete device power cycle is required to
> restore normal operation.
> 
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

Reviewed-by: Raag Jadav <raag.jadav@intel.com>
