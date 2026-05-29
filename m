Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EB1CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 13:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA60C10FEF8;
	Fri, 29 May 2026 13:16:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iqHySili";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4B2E10E1E8
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 13:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780060594; x=1811596594;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=RDLFfO96q0LZEUpB2IpbV9Eq7mclwd2pfWi/Bt297h4=;
 b=iqHySilib5dsQaeRXtCZ6+CJS+bReV90lc9c2Y7EVwxiYeE+BiTCqH1e
 JjwxRymo5Ed1cWoII3Na4UPwvBHjDlcx3L1NwQ4gvjeBtbp2BfnRmT5qS
 W4v+/+pL31E1nbOtxBnJYjjFWGchkZHFlzsSasiokmFSAXNgi99Uw3MqM
 KSYGY3UIOfWbqfQroAL3S5GjJ9OGqeGEuy3DuvH/hy+q+M+gVV0sT2ERU
 ipPGIwvHPrGsPeV+aFQ//hB2oQexrJvgHQwqU032jTyXx8Wx31oXVZizC
 eMDAO12+WGzUn63PJXfMFXdipqhbpMM5NXwmX8/WLJfT+szTOyVNucxmt Q==;
X-CSE-ConnectionGUID: YVSMHsYnRZyvU7X+2J42zw==
X-CSE-MsgGUID: xLVNjrxJTpiG1HOxdW86pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84770987"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="84770987"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 06:16:33 -0700
X-CSE-ConnectionGUID: 7BhnJ4t5Q+SCUC7L2tViGA==
X-CSE-MsgGUID: KQ4ZYgHUTGOitXPajVyRgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="266718958"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.147])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 06:16:31 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 dri-devel@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>
Subject: Re: [PATCH v2] IGT: Add a luminance test
In-Reply-To: <20260528055035.1514478-1-superm1@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260528055035.1514478-1-superm1@kernel.org>
Date: Fri, 29 May 2026 16:16:28 +0300
Message-ID: <64f91a9dbdc55fab36379c008fa47a462e41bf99@intel.com>
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

On Thu, 28 May 2026, "Mario Limonciello (AMD)" <superm1@kernel.org> wrote:
> This will make sure that luminance can be changed from DRM master
> and that it stays in sync with sysfs.

Please send to igt-dev.

BR,
Jani.

-- 
Jani Nikula, Intel
