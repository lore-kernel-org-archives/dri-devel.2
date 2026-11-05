Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ACC606A329
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FjuY+LHc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5071B10E2A2;
	Thu,  5 Nov 2026 08:50:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69AC310E2A2
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793868638; x=1825404638;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ebgMAXz6qQ6CnacPqrFOr7UMQUkOxp9GpGMGpv84fzw=;
 b=FjuY+LHc/+ccizui6IEDmyMh8K8FO4El3TE+5ukjVyPKktkiBMR89cZv
 VAhLkOxCZdx4pV9HQdFBrPBcrnECmY659/jxHH4UCpYtWVnmK8TMJIfax
 jnuN+AIwbVe+NxiueerxqVCLhqeUmGwJZHg8jKHnl55eC4FLauRbvhAXX
 41f/iPbL4sWVh1uJQ2bF5HHLe63VHEa8catYLpMlQHBVgbf0bUboQJi4X
 SZ61kua8sm/5+fBItv6LdhgJH0VjhGJdz1tOcO3bZgdSW8oCarFGvTWcT
 3/FmV4XmDTs6a6hKzRscR5SbgdU0GcFDshf5w2wp/gM1k7xWkJlvaNFhS A==;
X-CSE-ConnectionGUID: b6MUraY8TtWg8zsXfuZ2hQ==
X-CSE-MsgGUID: OQ9qCOOjR6O4OAoxgooGXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2666380"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2666380"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 00:50:37 -0800
X-CSE-ConnectionGUID: cZSMxdkqT3qa/KNAQY867A==
X-CSE-MsgGUID: zvg6eovNQ3q8tTnybjqR7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7022207"
Received: from soc-pf6038af.clients.intel.com (HELO [10.217.180.114])
 ([10.217.180.114])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2026 00:50:35 -0800
Message-ID: <66e787cc-ab00-48eb-9f9f-e6496832e73e@linux.intel.com>
Date: Thu, 5 Nov 2026 09:50:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Replace profiling frequency debugfs with test
 mode bit
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com, dawid.osuchowski@linux.intel.com
References: <20261103094215.1245113-1-andrzej.kacprowski@linux.intel.com>
 <9676db68-3dd6-4ade-bc50-74c4e1172b07@oss.qualcomm.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
In-Reply-To: <9676db68-3dd6-4ade-bc50-74c4e1172b07@oss.qualcomm.com>
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 03-Nov-26 17:55, Jeff Hugo wrote:
> On 11/3/2026 2:42 AM, Andrzej Kacprowski wrote:
>> Remove the profiling frequency debugfs control.
>> Add IVPU_TEST_MODE_PROF_FREQ_HIGH to select
>> PLL_PROFILING_FREQ_HIGH during driver initialization.
>> High frequency profiling is for debugging purposes
>> and it can be set at initialization time - there is
>> no need to control it via debugfs.
>>
>> Signed-off-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
> Reviewed-by: Jeff Hugo <jeff.hugo@oss.qualcomm.com>

Thanks, applied to drm-misc-next.
