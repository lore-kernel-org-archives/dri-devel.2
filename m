Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01A0C4450A
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D1710E057;
	Tue, 14 Jul 2026 19:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Vn25SvdN";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A4D10E057
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 19:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784056605; x=1815592605;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vwEUmzthtgXtBV3gviih/x4BpS1vwgxMWy4IoVbq670=;
 b=Vn25SvdNqwRgPOuvCIjTHAy+ibkJtZZKR+KPIWNJ3Nv+2LRh+BtoHipZ
 09LDx/SV/JEDeluaC9g13g5mlW6YAIzi5ZP6kLYUWzHVAyjjAihd6hw/F
 7HaQVxx/6X8H1Evq6kbNVXPk5zq9n0CTzEe4Q3MDRo1qbaGmctDfmgi7L
 6p6VSp8i27105Myl0bj6A14LUFtt6m2fKswlyxIiHyA1yzIWD7vNDrkFF
 j/Z42X4HilLx1wUMG+Se/cjIxyCd+OElSAsDRVBw924Gc8/HnwgU+3S5v
 HgOD+/8eoaYn7/iDTcqCBnti5PiQxm1H+7ij3bGL1aWYaHkg60ottaCrR w==;
X-CSE-ConnectionGUID: 6BzFN80jSsGHMNGCcwcfOA==
X-CSE-MsgGUID: Sj51LITIT4GIVPlV+senqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84732412"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="84732412"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 12:16:45 -0700
X-CSE-ConnectionGUID: Pc3ozczLRQK/CP7exILsDQ==
X-CSE-MsgGUID: XQVqW0MwR4ybMGmuIeD89Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="259786700"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.44])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 12:16:43 -0700
Date: Tue, 14 Jul 2026 22:16:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Panagiotis Gravias <graviaspanagiotis1@gmail.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, namcao@linutronix.de,
 tomasz.unger@yahoo.pl, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging/fbtft: Remove prohibited space before close
 parenthesis
Message-ID: <alaLGAYrBYkP_x5T@ashevche-desk.local>
References: <20260714190958.219437-2-graviaspanagiotis1@gmail.com>
 <20260714190958.219437-4-graviaspanagiotis1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714190958.219437-4-graviaspanagiotis1@gmail.com>
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

On Tue, Jul 14, 2026 at 10:09:40PM +0300, Panagiotis Gravias wrote:
> Fix checkpatch error: "space prohibited before that close parenthesis"
> in the define_fbtft_write_reg macro.

NAK.

-- 
With Best Regards,
Andy Shevchenko


