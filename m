Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33861606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MdTCJzSN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EE1710E5CC;
	Wed,  4 Nov 2026 18:14:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C95E10E590
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793816033; x=1825352033;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=74C0lRi052w7XxeI1SvriNweGqUEi9UZQ/GAQjGwYw0=;
 b=MdTCJzSNVOp/QjijFHi3kkEuNDYGXxNhfCJI+SSi48KMXeLa53Dub+Cf
 hZ5rx9trXHbxFw/cXfVbI1cz00hLj2gn/h1t/kisEArTjWPNBdDn/oaRI
 ChksWonofCbbhj/X5qAEM+4iDsXbNrbGCcKsS6R9IFHvmG57VD76SslfT
 9G3DrUj1hKZFBsmmXuq+8C1bbJebrM4UCw5bwGVkQbYowLkRA0zg/7sTW
 Dsjm8nx7jBGvbi5nMiqmWQNbygM9co2KaJeBEhkKIYpJ5KnARWgD+6HF4
 KrIJKYn/TS5AwGya1xLr0d8SnonaVqAbTNytWGZT9qvPlk0XLeSN/a/zq A==;
X-CSE-ConnectionGUID: DnkmFHWRTG+Lm3vpcCOmRQ==
X-CSE-MsgGUID: hFpUeCyDSOyrHVal0SGXpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2611242"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2611242"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:13:50 -0800
X-CSE-ConnectionGUID: 9BYdewLtSHeHkD/HYNE8JQ==
X-CSE-MsgGUID: /e5HVzdvQYaR74qIx1Hu2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6939307"
Received: from nhadzic-mobl.ger.corp.intel.com (HELO [10.246.16.206])
 ([10.246.16.206])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:13:48 -0800
Message-ID: <fdf68dde-569d-48f5-be5b-0e18261c7c20@linux.intel.com>
Date: Wed, 4 Nov 2026 19:13:46 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Limit SSIDs to 128 on all generations
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com
References: <20261104082920.859706-1-karol.wachowski@linux.intel.com>
 <c7f834be-ab48-41f4-a860-2978eeadb225@oss.qualcomm.com>
Content-Language: en-US
From: "Wachowski, Karol" <karol.wachowski@linux.intel.com>
In-Reply-To: <c7f834be-ab48-41f4-a860-2978eeadb225@oss.qualcomm.com>
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

On 04-Nov-26 18:41, Jeff Hugo wrote:
> On 11/4/2026 1:29 AM, Karol Wachowski wrote:
>> Some generations support only 128 SSIDs, while the KMD configured 256
>> CD table entries and allowed user contexts up to SSID 130. Align the
>> limit across all generations.
> 
> When I read this, I have the question, why limit to 128 for all 
> generations when I assume some generations support more than 128. Would 
> that not be a handicap for users on the gen(s) which can utilize more? 
> It seems like the justification for applying this lowest common 
> denominator across everything is not quite clear to an outsider.
> 
>> Limit the CD table to 128 entries and the user SSID range to 2-127, so
>> root can create 126 contexts and non-root users 64. Also fix the off by
>> one SSID bounds checks against the CD table size.

Hi,

The commit message could have been clearer. Before this patch the driver 
allowed 128 user contexts (MIN_SSID + 128). Now the limit is 128 SSIDs 
in total, which leaves 126 user contexts.

So the real cost is 2 contexts for root. Non-root stays at 64.
In return the SSID range, the CD table size and the bounds checks all 
match. Testing gets simpler, because we can check exact limits instead 
of loose minimums. The userspace interface also becomes consistent, with 
the same limits everywhere.

I'll add this to the commit message in v2.

Thanks,
Karol

>>
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> 

