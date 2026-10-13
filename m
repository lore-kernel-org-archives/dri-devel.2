Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB70CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 21:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50FA410E954;
	Tue, 13 Oct 2026 21:12:01 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F0610E954
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:11:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XETfERaQBsPY0XFA/xebWadP/MXJnoPomj/2sPY12zNln5rz6p0r3QIRFQsfcp/K4pz+zjAuWxIg72u8+R8yIVS2UBZT7jvefPXf0II+mPkgTezTnhVCvQhnwIYeDQAcFoSTepHK7L9N+otXpP1T7zKgoTjJSBs57jxmb2ye4DrYOqjAus8cIe6e4Rss/iej8+g402NBRHbLZfAwu7clvLX9U4YB440F+QJvdT+flrB4IQNP5iA7z6CmKdX7QYE49eggGz7j52LPf5ukChPgnqf2tctrWRevu6bGMInj9LUvba+ItL9xSQv4CYrrRWppfwBYpn4X+jZwrZo2xdTFbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUI2xC9rHkUOv6/vUJ4MXb0p/l1tcZbr/it3b6gXXxE=;
 b=AxSwGSi0OsK0+2wMC7ZmWRWpHlDNR4I8rw+fpH7fQH9b1AP/xrAu+mFfkMCJcRvBIf5Y2nYf2VAkIt6xRGt9q0nW9SsL4wEV3DK+S9CiaLREPwu45eXhzRd+UzWid3pOfIUyADYxLq2umG6UO6IQKgMyE9t+rvY+Ou9i5vWJfKNCfhDDzVUTFmEfgl/t6EJl3u+xfA+zzTvEmNq1QJjiqvYt2tFGHPj8Q8UYJoyKJZop8nU2bUoyRNE5p9W3LTXB5x3Ry6bEGt3Kgp/7MUMCG0Seg8tQCfF1r+Jmz5CyT9pa2/L8O4pgpgC7Cc1eMpY4navYdBf3WZS8n2kpkwM7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUI2xC9rHkUOv6/vUJ4MXb0p/l1tcZbr/it3b6gXXxE=;
 b=vngMrzNwq6yTgOZfiGXnsQNp0SKHz+A5CQ9A/Iite63WdZKRD6zrsbteoaRe2QxfJVwyd3nq6vkVsBtpE9IfZq1+/FxGDAhI05/XgCx2xDqUL5/0pBvnaQJ3oCK7urRP3zgS2Ef2+LbnEG4UpqfAQYUmG6rGqwqGakG0rnGjkyc=
Received: from PH8PR22CA0022.namprd22.prod.outlook.com (2603:10b6:510:2d1::17)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 21:11:50 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::34) by PH8PR22CA0022.outlook.office365.com
 (2603:10b6:510:2d1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 21:11:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 21:11:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 16:11:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 16:11:43 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 16:11:43 -0500
Message-ID: <160b6982-7d87-547c-9d84-cb689b35f04f@amd.com>
Date: Tue, 13 Oct 2026 14:11:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V1] accel/amdxdna: Serialize HMM range faults on one umap
Content-Language: en-US
To: Matthew Brost <matthew.brost@intel.com>, Max Zhen <max.zhen@amd.com>
CC: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
 <dri-devel@lists.freedesktop.org>, <mario.limonciello@amd.com>,
 <karol.wachowski@linux.intel.com>, <linux-kernel@vger.kernel.org>,
 <sonal.santan@amd.com>, "Zhang, yidong" <yidong.zhang@amd.com>
References: <20261012203139.2573687-1-lizhi.hou@amd.com>
 <7a29937c-b591-40fc-95cf-021799ea52a7@amd.com>
 <as21qsFsf9HepYok@gsse-cloud1.jf.intel.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <as21qsFsf9HepYok@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb42618-580a-4168-2707-08df296e993e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: ipBnHtJZn8QZvKtoucMbybkZB879OMADirkbqWTHlrauCMFBjHDT47CSGUFcn0550TeTLCwwnSgb0h7IzG0ge/FvgFw7D5ms6lePIYjJ0ZxafBsFaQrX2IFX9+ZfCPmgrlF0coBdToc5zAyMuEG5G0ul21w8rGENHPv941883P/wBIHrR7cwxdK1Pu0/ZtJzJvpMrnjJhLvx3/iIBbMriSSp68+S+JuI4XV/9dKeZ2lx57JekAPxYTVZtuwlXrfGq03CEXanFdBHjPMlS/jowdfLFi/xjLyAijt3NfbBfo11JiFvb4Uk/Amzoenp9G9q+rqj8mMeWrHQGhs+gfuxa/2JUeN8EPopWWg98BRChk3hDIk0Hj+MbTumr4zEs6ptBZxQonO5h5oPiBUoYxI9MUtlyOSdj8wrhuNE+tIisVkhHYcD/oeoboa1mpMPMgfE6o2JGiKpIWLHmPOiX6E+rbQdPMG8sREtajidphGkbMqVmAJSSVBprI6PmALWfqJkbekXgmacTi2YQ89DO+3m5Ya5QGBinB9Ldel/0/rap5o3hR+MozNqYrGaON2Ce3SMV/9MrYnvsCpe1bVRcOwBlxTsY0X2mAa8/biNrkodvkiNmKnfgdP7taw747zIPk+mFiQ8e5WC7CZb/Ot996zHig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A8e+6YXCR1U2vUydc5/oTd6RDHVvIPQhMCNPs1cx7acwgVi8lU4g1Cphmzgf2WAN6suu2Ra1nbiAleSjl/WyG2EEMz+NXt+Gqy3+yK4em4EmKD+3P6J3SnK9d4nWIDoG2W/IQB17/tFE7y8bjs27EsLI1qYjm0au7kIwi6IoDDrhHfre48yoZ37qNAP2erbba2LYfoYaILQyFu0tC+1Pr4cEP/mkK77aKnCV824zBs5egYJyTtsXYvaCQH5hRVqNA6c9QYnM2yeRZ6hK7Fk6x4CX0PyAaHyLXaXrNPme1vEuys6S4Dj0GyIvDSAetNdAexb4WQKnv3VqB346aaEpY0z6pjwV7rvSewGnckZxLFNrkc3j5ClW9kmOfCgbBP5eeWsJ2+JJfiF2adgGjVTEmr6fsjGae7IPsCf6yCdwwGpw+a3eUK7fhkK2SCEzB8tA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 21:11:50.2992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb42618-580a-4168-2707-08df296e993e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
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

The patch looks clean.  I pull it on top of latest drm-misc-next and run 
some regression tests. It works fine too. :)

Lizhi

>
> Improper HMM or abuse affects the entire kernel, hence we should
> converge.
>
> Please consider the AI suggestions (last 3 patches) instead of open
> coding this.
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
