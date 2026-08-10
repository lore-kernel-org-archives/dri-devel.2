Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81FBC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC30210E74D;
	Mon, 10 Aug 2026 08:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="nqEdNM6S";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A88A10E73B
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:53:33 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260810085331euoutp02900721d2a8a9f0df05e824a29b7bf125~KZbCzCnrs2552025520euoutp02X
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:53:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260810085331euoutp02900721d2a8a9f0df05e824a29b7bf125~KZbCzCnrs2552025520euoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1786352011;
 bh=Jfs1r6rrM0YDkS4/IQJOpMMB4FuY2S1pjTMPpIdGReI=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=nqEdNM6SPdGN4nhZFVGKFLtV8+La49xe1qH9gz13zgRue1vKaS/oKeOn63sCyq6z4
 mbXvnCPh+OLXWauialRYNAtGFcmMGS1rPQzmtNB5zrFQ+wXFAry9xA0BU1WV8vKXoa
 ZIzyDaJuip39Q4YUT7aMdM1zaYvuWXosZLjuV9lk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260810085331eucas1p19d5524b6b6be32222b3bc7f3e47f289d~KZbCD3aoj2027320273eucas1p1h;
 Mon, 10 Aug 2026 08:53:31 +0000 (GMT)
Received: from [192.168.1.44] (unknown [106.210.136.40]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260810085330eusmtip15b67a4f25d004e395285f9983231e854~KZbBVToZB1467214672eusmtip1Y;
 Mon, 10 Aug 2026 08:53:30 +0000 (GMT)
Message-ID: <223e0d51-9c2a-4938-b304-5d49d5984d37@samsung.com>
Date: Mon, 10 Aug 2026 10:53:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes
To: Alessio Belle <Alessio.Belle@imgtec.com>
Cc: "lkp@intel.com" <lkp@intel.com>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "simona@ffwll.ch" <simona@ffwll.ch>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Frank Binns
 <Frank.Binns@imgtec.com>, "maarten.lankhorst@linux.intel.com"
 <maarten.lankhorst@linux.intel.com>, "mripard@kernel.org"
 <mripard@kernel.org>, "airlied@gmail.com" <airlied@gmail.com>
Content-Language: en-US
From: Michal Wilczynski <m.wilczynski@samsung.com>
In-Reply-To: <1be61852213cc616eadc60941512862deddd12c7.camel@imgtec.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260810085331eucas1p19d5524b6b6be32222b3bc7f3e47f289d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260805193726eucas1p122ba1e7c33d06a993a985637e909bd41
X-EPHeader: CA
X-CMS-RootMailID: 20260805193726eucas1p122ba1e7c33d06a993a985637e909bd41
References: <CGME20260805193726eucas1p122ba1e7c33d06a993a985637e909bd41@eucas1p1.samsung.com>
 <20260805-fix_imagination-v2-1-7391a13c891f@samsung.com>
 <1be61852213cc616eadc60941512862deddd12c7.camel@imgtec.com>
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



On 8/8/26 11:27, Alessio Belle wrote:
> Hi Michal,
> 
> Did you mean to make any changes to this patch? Because apart from the stub
> changelog, everything else seems the same as in v1.

Hi Alessio,

Yes, the only intended change for v2 was expanding the commit message
based on the feedback from v1 [1].

I completely missed replacing the "EDITME" template in the changelog
section, sorry.

Let me know if you'd like me to send a v3 just to clean up the changelog
block, or if you're fine taking it as-is.

[1] - https://lore.kernel.org/all/09a1028b03d614ffedc49dee24eee51578fa0d96.camel@imgtec.com/

Best regards,
-- 
Michal Wilczynski <m.wilczynski@samsung.com>

> 
> Thanks,
> Alessio
> 
> On Wed, 2026-08-05 at 21:37 +0200, Michal Wilczynski wrote:
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
>> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
>> ---
>> Changes in v2:
>> - EDITME: describe what is new in this series revision.
>> - EDITME: use bulletpoints and terse descriptions.
>> - Link to v1: https://lore.kernel.org/r/20251222-fix_imagination-v1-1-0ac80a2ff317@samsung.com
>> ---
>>  drivers/gpu/drm/imagination/pvr_rogue_fwif.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/imagination/pvr_rogue_fwif.h b/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
>> index 172886be4c820a32ae1b08d62bf0814250f2a9bd..1ba2a167a38b31911e0846923e4dc70626f5ca65 100644
>> --- a/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
>> +++ b/drivers/gpu/drm/imagination/pvr_rogue_fwif.h
>> @@ -2170,7 +2170,7 @@ struct rogue_fwif_hwrtdata {
>>  	bool geom_caches_need_zeroing __aligned(4);
>>  
>>  	struct rogue_fwif_cleanup_ctl cleanup_state __aligned(64);
>> -} __aligned(8);
>> +} __aligned(64);
>>  
>>  /*
>>   ******************************************************************************
>>
>> ---
>> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
>> change-id: 20251222-fix_imagination-8ef0c94122c4
>>
>> Best regards,
> 

