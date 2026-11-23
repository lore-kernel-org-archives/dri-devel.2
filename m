Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB058606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NxaAZuj4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5552010E4C9;
	Mon, 23 Nov 2026 12:38:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B771110E4C9
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795437494; x=1826973494;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=noXsiV34IzHrnUGMjWMJk9K0TE4u0xXSkekc5W2Cx7U=;
 b=NxaAZuj4zofRryDmdfOjOflh7rmEtix/+O+CpIbq9Zzf5IXaHInA9N+A
 LBoFb1Jvh4fBAF2dQz1/++uoN8WwgOx90imgLMI2MM1AK7U1NfofZtCpk
 ZEp+y6v56b9+ck445JdCM07rKYn+r8r8QqZ/ENKHette4YPKnujxm2EDz
 Jqz+061INAHFr4sod7kSdFlQPmVXfl8cV1O3v02nmz5iozZxQuhJ6bEIj
 J8gUh0ApwA3qa11kk1QV9fGjkhhbzQAqoA5f8sFghHYVbOpmK7rWPYIUo
 cVFqw+rrfHooXneA2mtVx2p7iRumJ1DcQFuFdNYdltNJOQLM/t1hLIBhI g==;
X-CSE-ConnectionGUID: 7TSPFfX6SLKAmxDYQCVwbw==
X-CSE-MsgGUID: 1LAdCwtRQLG0x7/cTjQjWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4141055"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4141055"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 04:38:13 -0800
X-CSE-ConnectionGUID: VkO5xzvHQgerGP59zkgMEQ==
X-CSE-MsgGUID: 9FKoM4l4T/ak9kNjYPh1EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11649063"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.38])
 ([10.217.180.38])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 04:38:12 -0800
Message-ID: <d9b91e95-243d-4e3c-92b0-0355dca59a63@linux.intel.com>
Date: Mon, 23 Nov 2026 13:38:09 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add Dawid Osuchowski as Intel VPU maintainer
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, linux-kernel@vger.kernel.org
References: <20261123122007.2580451-1-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
In-Reply-To: <20261123122007.2580451-1-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23-Nov-26 13:20, Dawid Osuchowski wrote:
> Add myself as a new accel/ivpu driver maintainer.
> 
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bcade5bfbafe..0afa391498d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8198,6 +8198,7 @@ F:	include/linux/power/smartreflex.h
>   DRM ACCEL DRIVERS FOR INTEL VPU
>   M:	Karol Wachowski <karol.wachowski@linux.intel.com>
>   M:	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> +M:	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Supported
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
