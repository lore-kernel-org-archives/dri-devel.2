Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AC3C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 08:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2FD610E0B9;
	Mon, 24 Aug 2026 08:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ejV3QtHd";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EF210E0B9
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 08:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787559089; x=1819095089;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=BVhfHpH9iMolJMglLSc0h4FGRwI+hd4Z872A/A5+htU=;
 b=ejV3QtHdXh0+IG8nij1b9EIRSkG9yFbAPmiFUHIHgx64o/Kel7qHyMZ9
 jNWVX7PM2GYWHnHoYVE7gngAPxBIy26hHNqSatQMKBDucNrHQMuC5x5Z1
 Lhlg7+yGgnIco89QeImGUmMKZOlwmOzJ7/pysuac1hWncz9WCWL2nbHhe
 lx/I6KWVRg072ciXH8v+gPtgg+Lb7nEpqozU8CAspIlBav8GGuz9kA5RI
 1lbiFnMozO3oyljQ1sT3zIc2WWW1PfkCvOmFbXS+IBwszSoZ+kqHsmFlm
 RGPnP+u0rZJinM/iMNvCWHmQYoLIt+whXdoRRvahVfn7bklXaQmUvcZY1 A==;
X-CSE-ConnectionGUID: qRBzgQFwTLeFIW6pItf2bg==
X-CSE-MsgGUID: FBeq6/NlQNGKxNDemZMEMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="105540183"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="105540183"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 01:11:29 -0700
X-CSE-ConnectionGUID: RD2I6ZhcQUSLzGFQZnU6kQ==
X-CSE-MsgGUID: yTEt/9CNS1OhIEjGuAh8QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; d="scan'208";a="263215533"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.44])
 ([10.217.180.44])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2026 01:11:27 -0700
Message-ID: <7813eba9-cea7-4c00-9062-0d4b961792a6@linux.intel.com>
Date: Mon, 24 Aug 2026 10:11:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/2] drm: add drm_warn_ratelimited() and convert
 ivpu to use it
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com
References: <20260820104811.803146-1-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <20260820104811.803146-1-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 20-Aug-26 12:48, Dawid Osuchowski wrote:
> This patch set adds drm_warn_ratelimited() to the DRM print helpers
> and updates the ivpu driver to use the warning-level variant instead
> of err-level logging. The new helper matches the existing rate-limited
> logging pattern and gives drivers a consistent way to emit warning
> messages without spamming the kernel log.
> 
> This change improves logging correctness and consistency for drivers
> that need rate-limited warnings.
> 
> 
> Dawid Osuchowski (2):
>    drm/print: add drm_warn_ratelimited logging macro
>    accel/ivpu: Use drm_warn_ratelimited macro
> 
>   drivers/accel/ivpu/ivpu_drv.h | 2 +-
>   include/drm/drm_print.h       | 3 +++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> 
> base-commit: 063019ac51afffda4ab3d658701b086caa0c8e9e

Thanks.
Applied to drm-misc-next.
