Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D2ECC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0112510E26F;
	Tue, 13 Oct 2026 16:36:54 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012046.outbound.protection.outlook.com [52.101.53.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83A5D10E26F
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 16:36:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOXRNqTSnmNa9BX7tMh67ugD+e8Mv78iOYWniEmPxfEBiVPGQHA23u+hGg7bw4kZK7S3fVMSNWZAah+oNQJcvec8lFB3g/DjVRZfjxTSeAZAfugdtNvp0Iu3bsldA56AB6/6imnvcfD9/LvtonRRUt+ZTYf5JU15uOFrVApC0T47C3zgdna9Ocp2Tc+yuX+YasDiVb60ajrWVLWry6o/xVHKAhCVUKIuHtismcitOkcdNIfCUPOEkKt74LAnM74pChYxcZSgBK8zBJYLQjIATimZtLGSSUNq/+RDbiaVaf8lzBL9DFZvdkfeoMikrxLQvTePHdzb92PaN7YTfiGd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93/kBz2ZgMrbuySBgQwccQLwf4fJR+bkKPAGHb4MBEk=;
 b=Hph4NpShzGlMtzzuz7rVG/+74DWTIIy3CfULpDrfN8nKj7PWgphf+IjfVxbTDCWE8TGPqtBKslDQjJ00lUlw8Uguvn6yt7OyRsmGDoFdnDDn+ci/F16uuVxauoL4vFNfcrOpsMv5tdAvsg56LGX7zisWPk5qLgOeqS7Cp6f0gqS+/f9+0JL74YgqNiKe+zX+oc5g5YrieO+7yHcu4uwu5Y/kiGnmV9QydSS1TPFQQaWBFSD9W1mn8QoaKK5fuN7LgnsEuXlZL1r+U5+XKTFu0eqMmZyXDz81tin0uSxf8PMCBRli6IuBkx7st0Hi0UP6r2Z39ZHNVBpVFaj4YgaAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93/kBz2ZgMrbuySBgQwccQLwf4fJR+bkKPAGHb4MBEk=;
 b=MAIiF084bG4+C8ef15wwDugXyUZONXGv/NOm83+DD7J/Scyg7b5z0+Kr3YxppTf5dDRZiQ6CcD2vhHkwA2TBIMgPY1/LlpNpeDH+Gq9vXpSeKXmN/hy+5y05XCTMT/wkRzIGSpoWXphXsoHKbUkboEDtzWznyeJIkzkHmE3y7G8=
Received: from SJ0PR03CA0110.namprd03.prod.outlook.com (2603:10b6:a03:333::25)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Tue, 13 Oct
 2026 16:36:39 +0000
Received: from BY1PEPF0002695A.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::5b) by SJ0PR03CA0110.outlook.office365.com
 (2603:10b6:a03:333::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 13
 Oct 2026 16:36:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0002695A.mail.protection.outlook.com (10.167.244.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 16:36:38 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 11:36:32 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 11:36:31 -0500
Message-ID: <75d7c27a-66f1-80cf-1aec-895828592e66@amd.com>
Date: Tue, 13 Oct 2026 09:36:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Serialize HMM range faults on one umap
Content-Language: en-US
To: Matthew Brost <matthew.brost@intel.com>, Max Zhen <max.zhen@amd.com>
CC: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>
References: <20261012203139.2573687-1-lizhi.hou@amd.com>
 <7a29937c-b591-40fc-95cf-021799ea52a7@amd.com>
 <as21qsFsf9HepYok@gsse-cloud1.jf.intel.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <as21qsFsf9HepYok@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695A:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: d0bb7ee7-2af8-43c8-800a-08df294827a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|10067099003|261009223027099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: c48v0L9rqBTRjogRXeSVyrl2B0E0USr27mfjjVdLCqmEMEE1fBkndHuP9As3nIS6k+P+YgqXKdp5nWSHiK8aL+jF7MoLdQmoJ1IHnfG8imyr2zZa4i25j+zkJUMr1rrHULeZybAOVhyp83eqSxfe1Ko8pj7H5IS/lZ/W/ljxEls+nQjVbJ2v9V66Bc5Sa1RW2XFuTYJJC9VJplVM/d4jpLPXlH+VXW4CvgrC0c0U+GdQ5UdhsriF3ucVBbEsma0vgx0n48dR8gX9CnhpOTNeoKeqn5dlugPmhNuUVWuEVY1/qvs2k7PG60tg/yWeSELaX6i4DsCdyd5k1HhvkjIjIaGVVWlLO2RCzZ+CPjhGgqxrWww30+2+M5bg+6FXXbDDHL85vJuVDqn6Ms29T5HaMzcjFY+6TyWXggrJi5TRhoxiJjaEBegU3YwRsl4CfyFxHf32ldagOyuEzfpXR47onk+m9pbgPw9Pb01vp7L4NvNtElhCmuT9sCp7MGh8mnbQzvqcQ5ZqxjV28pwzFNQUbF4IK45GIcVFt8y1P//nSKpuj1uXemQZ+UrOwp8NItEgUapYtrvwmgwCtLOvoMa2/JYLVLWu8D49K3ccTAGDX1KKslJtvj1IvJ/qnQ33oSMBfnAxbE34np6PDO3vwfHdmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(261009223027099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DStQUYy4DzpjsFHhAN38Twqv61VDHLjCMlMWwtaVzGxZMX8tgCaRMZ4Ml9d3Cy8/UfWQx2WOJSc9bxJeJT3FAxj8od8CSb3UOYeRvpKk/7x6tqf0V0J1vVGi2ekKxJuO6cwRpc/gsH5E1A1srWh9Ganzz4bVKc99aS3iw+FfoAc+zMeU+lYTr5l51cIpvbP60iP/xxaWS0PgaPM3IDTNjKL5er03yBsfrOPC81R6Yy2sMypXE1DYQo1W9eqPw9Ms7hXW4IRE4s3jLaTumdC2ak/V8+zxOeGpqmr316okGPbGrJqCYsohaJCsM5U+PEF1nE9a7HjM2wqtHXHdPZLO6qUorZIOV6oEpJdum0/DDjxd0Bpotg53pQBrDSsCyrcH60Js9BaCX72tewkk4Egzmd7x3nU+NhCfdAo5IoMx2BHtnSzX6rjSVN2U6wwIJhDI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 16:36:38.8419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bb7ee7-2af8-43c8-800a-08df294827a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950
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


On 10/12/26 21:38, Matthew Brost wrote:
> On Mon, Oct 12, 2026 at 09:10:15PM -0700, Max Zhen wrote:
>>
>> On 10/12/2026 Mon 13:31, Lizhi Hou wrote:
>>> Two hardware contexts can submit jobs that use the same GEM object while
>>> a user mapping is invalid. aie2_cmd_submit() drops the reservation and
>>> notifier_lock before aie2_populate_range(), and that function takes a
>>> reference on the first invalid umap without clearing invalid until the
>>> fault returns. Both submissions then call
>>> hmm_range_fault_unlocked_timeout() on the same struct hmm_range. That
>>> structure is not safe for concurrent callers. The calls write
>>> notifier_seq and hmm_pfns[] at the same time, so mmu_interval_read_retry()
>>> can see the other call's sequence, miss an invalidation, and clear
>>> invalid. The job is then pushed while the pages may already be gone.
>>> Give each umap its own mutex and hold it from the fault through the retry
>>> check and the store that clears invalid. notifier_lock is dropped before
>>> this mutex is taken, and the fault drops mmap_lock before notifier_lock
>>> is taken again.
>>>
>>> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
>>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> Reviewed-by: Max Zhen <max.zhen@amd.com>
> I was browsing dri-devel and this hmm interaction annoyed me enough to
> ask my AI to fix this and converge properly on a DRM framework:
>
> https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commits/local_dev/amd_hmm_cleanup
>
> Improper HMM or abuse affects the entire kernel, hence we should
> converge.
>
> Please consider the AI suggestions (last 3 patches) instead of open
> coding this.

Sure. Using gpusvm interfaces would be great. I will patch these on my 
system and see how it works.

In the meanwhile, for back porting, will it still worth to merge this 
patch?


Also, we are working on aie4 hardware support which also relies on hmm. 
Thus, aie2_populate_range() will be renamed to amdxdna_populate_range() 
and moved to amdxdna_gem.c.

https://lore.kernel.org/dri-devel/20261009225343.3079074-16-yidong.zhang@amd.com/

As a great enhancement, would it be ok to put your last patch on top of 
aie4 patches?


And this patch in aie4 series tried to fix the same issue been pointed 
out by your second patch.

https://lore.kernel.org/dri-devel/20261009225343.3079074-15-yidong.zhang@amd.com/

Does it look ok to you? ("Fixes" tag needs to be added).


Thanks a lot,

Lizhi

>
> Matt
>
>>> ---
>>>    drivers/accel/amdxdna/aie2_ctx.c    | 7 ++++++-
>>>    drivers/accel/amdxdna/amdxdna_gem.c | 2 ++
>>>    drivers/accel/amdxdna/amdxdna_gem.h | 1 +
>>>    3 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
>>> index d927c8c9d557..4db67a789c34 100644
>>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>>> @@ -1155,19 +1155,24 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
>>>    		return -EFAULT;
>>>    	}
>>> +	mutex_lock(&mapp->lock);
>>>    	ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
>>> -	if (ret)
>>> +	if (ret) {
>>> +		mutex_unlock(&mapp->lock);
>>>    		goto put_mm;
>>> +	}
>>>    	down_write(&xdna->notifier_lock);
>>>    	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
>>>    		up_write(&xdna->notifier_lock);
>>> +		mutex_unlock(&mapp->lock);
>>>    		amdxdna_umap_put(mapp);
>>>    		mmput(mm);
>>>    		goto again;
>>>    	}
>>>    	mapp->invalid = false;
>>>    	up_write(&xdna->notifier_lock);
>>> +	mutex_unlock(&mapp->lock);
>>>    	amdxdna_umap_put(mapp);
>>>    	mmput(mm);
>>>    	goto again;
>>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
>>> index f14484bc31ec..37bfa5058095 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>>> @@ -318,6 +318,7 @@ static void amdxdna_umap_release(struct kref *ref)
>>>    	struct amdxdna_umap *mapp = container_of(ref, struct amdxdna_umap, refcnt);
>>>    	mmu_interval_notifier_remove(&mapp->notifier);
>>> +	mutex_destroy(&mapp->lock);
>>>    	kvfree(mapp->range.hmm_pfns);
>>>    	kfree(mapp);
>>>    }
>>> @@ -402,6 +403,7 @@ static int amdxdna_hmm_register(struct amdxdna_gem_obj *abo,
>>>    		goto free_pfns;
>>>    	}
>>> +	mutex_init(&mapp->lock);
>>>    	down_write(&xdna->notifier_lock);
>>>    	if (list_empty(&abo->mem.umap_list))
>>>    		abo->mem.uva = addr;
>>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.h b/drivers/accel/amdxdna/amdxdna_gem.h
>>> index 9b4aa21a37c9..456a537eb68c 100644
>>> --- a/drivers/accel/amdxdna/amdxdna_gem.h
>>> +++ b/drivers/accel/amdxdna/amdxdna_gem.h
>>> @@ -19,6 +19,7 @@ struct amdxdna_umap {
>>>    	struct kref			refcnt;
>>>    	bool				invalid;
>>>    	bool				unmapped;
>>> +	struct mutex			lock; /* protect range */
>>>    };
>>>    struct amdxdna_mem {
