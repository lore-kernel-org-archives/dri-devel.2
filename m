Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB688606A323
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=hI3fx5KS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A4D112064;
	Thu, 29 Oct 2026 08:08:05 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26219112064
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:07:59 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261029080757euoutp014213cbc58613014b70c5c77c6b69213a~i8aGJF5eD2842928429euoutp01o
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:07:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261029080757euoutp014213cbc58613014b70c5c77c6b69213a~i8aGJF5eD2842928429euoutp01o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793261277;
 bh=KbmqhuuVTr4I/rFjLF6bkUlnaFuOWYpE9EokGVjMu2Q=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=hI3fx5KSrynTlh9U5DWXqUPwTLV/Y+yLzp71MmdSMfHdk9h+tnVg+Upv4sQN9NqCs
 F9YWv2AS1ZffdDxuR7RkWZzpkkP9yrG9aa6zJ/NmMPl7qHIALK8l92tn0Ivl69R9dV
 oxybyR4rI/vRo+381YieXVCg4GYY2+cu0Km3UqlY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261029080757eucas1p29a2b9c805d1f31981b4a106f9777c9bd~i8aF1C6Hv2581125811eucas1p2C;
 Thu, 29 Oct 2026 08:07:57 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261029080756eusmtip1db621864afb35e4c85aa1c1abae870ea~i8aFWp-Wj2048420484eusmtip1A;
 Thu, 29 Oct 2026 08:07:56 +0000 (GMT)
Message-ID: <ef0683f4-b14e-430f-8b28-8e1851ad3cf2@samsung.com>
Date: Thu, 29 Oct 2026 09:07:56 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
To: Alessio Belle <Alessio.Belle@imgtec.com>
Cc: "lkp@intel.com" <lkp@intel.com>, Luigi Santivetti
 <Luigi.Santivetti@imgtec.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Frank Binns <Frank.Binns@imgtec.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "airlied@gmail.com"
 <airlied@gmail.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <29ed7e87285e39dfcb87c07d3c8a17361277f878.camel@imgtec.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261029080757eucas1p29a2b9c805d1f31981b4a106f9777c9bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260810102037eucas1p2f68492f185b4e411aafa83d5d15d0499
X-EPHeader: CA
X-CMS-RootMailID: 20260810102037eucas1p2f68492f185b4e411aafa83d5d15d0499
References: <CGME20260810102037eucas1p2f68492f185b4e411aafa83d5d15d0499@eucas1p2.samsung.com>
 <20260810-fix_imagination-v3-1-e512359722fc@samsung.com>
 <29ed7e87285e39dfcb87c07d3c8a17361277f878.camel@imgtec.com>
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/28/26 15:43, Alessio Belle wrote:
> Hi Michal,
> 
> On Mon, 2026-08-10 at 12:20 +0200, Michal Wilczynski wrote:
>> The build fails on RISC-V using GCC because `SIZE_CHECK(struct
>> rogue_fwif_hwrtdata, 384)` expects 384 bytes, but the compiler generates
>> a 336-byte structure.
>>
>> This is due to an alignment conflict: the inner member `cleanup_state`
>> requires 64-byte alignment, but the outer struct is explicitly marked
>> `__aligned(8)`.
>>
>> While GCC on ARM64 implicitly pads the size to a multiple of 64, GCC on
>> RISC-V strictly respects the 8-byte outer alignment, resulting in a size
>> mismatch.
>>
>> Fix this by aligning the entire structure to 64 bytes, which resolves
>> the contradiction and forces the correct 384 byte size on all
>> architectures.
>>
>> Fixes: a26f067feac1 ("drm/imagination: Add FWIF headers")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202512131851.1WNXk3BC-lkp@intel.com/
>> Reviewed-by: Luigi Santivetti <luigi.santivetti@imgtec.com>
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>> Changes in v3:
>> - Cleaned up the changelog section by removing the accidental b4
>>   "EDITME" template from v2.
>> - No changes to the code or commit message.
>> - Rebased patch on latest master.
>>
>> Changes in v2:
>> - Expanded the commit message to properly explain the root cause of the
>>   GCC alignment conflict on RISC-V vs ARM64, based on v1 feedback.
> 
> Sorry to bother again on this. All versions have the same commit message as the
> original. Do you still have the updated message that I think was meant to be
> sent in v2? Or are you fine with me making these changes to the commit message
> (+ rewrap) before applying this?
> 
> - "The build fails on RISC-V using GCC" -> "Sparse (W=1) builds fail"
> - "While GCC on ARM64" -> "While a non-sparse build"
> - "GCC on RISC-V strictly respects" -> "a sparse build strictly respects"
> - "on all architectures" -> "on all builds"
> 
> Thanks,
> Alessio
> 

Hmm I was sure the commit text was changed last time, anyway will fix
and resend thanks !


Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>
