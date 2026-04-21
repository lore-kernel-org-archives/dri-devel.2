Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9D9F8FA61
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 11:54:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B12310E887;
	Tue, 21 Apr 2026 11:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lm/DFZOJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC23510E887;
 Tue, 21 Apr 2026 11:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776772467; x=1808308467;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=iCgphbDcBdNyS1sSqpE8VpK1xeMLyIcHxuNcGysEPt0=;
 b=lm/DFZOJ9/YqyFnSwfCyAoXGchv8AonNfk9YHqjHlwxY8mpqD2DbKtZF
 PX0umWqtgQx0BWmBzxRzP2CI8ef803VRtg7Oor3KebJ3bzN1pyAM2N6mq
 3DiGeRJ3+Sxe3GbeKqf2VWoTfrPTsmZKVs0WT06YtcaqmkSNXTxerH1Hj
 NxIED4ay0LByLvacXZp89Ng86BMfbICDZKS/fYPT8ryyf1OMJlmja6nPL
 qLaLogsIxYHypxVIM8t4jy7cByDf/7d/+NQJKeXZ5yvlgdXQHQXhu8ddj
 6JncI0ezUygWS2/6cd6WfyrbHD3Q4qYVbfiqg9kMVFNTExhLXmZm5zNDa Q==;
X-CSE-ConnectionGUID: h/7h1XyiT5yhD84CCnIZ3w==
X-CSE-MsgGUID: vez0jMHIShOqfUSvgyDBeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="76733435"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="76733435"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 04:54:26 -0700
X-CSE-ConnectionGUID: VubRT5JtSDiNCWy/slIh2A==
X-CSE-MsgGUID: SpkNe7dCSlS+hlep7bO+tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; d="scan'208";a="231127258"
Received: from cliu5-mobl.gar.corp.intel.com (HELO [10.125.160.168])
 ([10.125.160.168])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Apr 2026 04:54:26 -0700
Message-ID: <d551bc50-e14d-4664-8df3-8fdd377e09c8@linux.intel.com>
Date: Tue, 21 Apr 2026 04:54:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix zero-size GDS range init on RDNA4
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <bug-221376-2300@https.bugzilla.kernel.org/>
 <20260420215717.223372-1-arjan@linux.intel.com>
 <34718f21-712a-4161-98e0-079dd9390ae6@amd.com>
Content-Language: en-US
From: Arjan van de Ven <arjan@linux.intel.com>
In-Reply-To: <34718f21-712a-4161-98e0-079dd9390ae6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 4/20/2026 11:42 PM, Christian König wrote:
> On 4/20/26 23:57, arjan@linux.intel.com wrote:
>>
>> RDNA4 (GFX 12) hardware removes the GDS, GWS, and OA on-chip memory
>> resources. The gfx_v12_0 initialisation code correctly leaves
>> adev->gds.gds_size, adev->gds.gws_size, and adev->gds.oa_size at
>> zero to reflect this.
>>
>> amdgpu_ttm_init() unconditionally calls amdgpu_ttm_init_on_chip() for
>> each of these resources regardless of size. When the size is zero,
>> amdgpu_ttm_init_on_chip() forwards the call to ttm_range_man_init(),
>> which calls drm_mm_init(mm, 0, 0). drm_mm_init() immediately fires
>> DRM_MM_BUG_ON(start + size <= start) -- trivially true when size is
>> zero -- crashing the kernel during modprobe of amdgpu on an RX 9070 XT.
> 
> Mhm in general not a bad idea, but we are having tons of GFX 12 systems in our test machines and nothing is crashing there.
> 
> We are clearly missing something here. Is that on an upstream kernel or something backported?
> 

the reported oops/etc say 6.18.22 so that does not sound like something crazy backported

(https://bugzilla.kernel.org/show_bug.cgi?id=221376)


