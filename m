Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950EAC61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:18:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F8310EDAD;
	Wed, 26 Aug 2026 17:18:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4kNUYo6Z";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86BA110EDAD
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXkdGpjXffq250Haur7gfZBaZUcbUA6PRkSwwz3WPTleiZfgzzH94lMQCHggwxpD+LI0LNSHRUodtBew5OuU0ZSSO7xtXtieSxk4+46JzsfAa9nFBO0iwm0Zd6GQagvpmRVr9uwFfJ+Nr4dQEKtezwjjZfEWxoq/m4MiGgUg+D9UKNeRTdXvTL0dqRXcTpsqMVwGZJOQW83RvbwZf/MmFU3ouYcWWfylud12pTUfbm3Z0daC1Tr+cK76fLJIvBcFPjJe6Mw84CzHZ6TiU7jHXr2uy4Z+PBjbxfnxxVd2IljliQ2c8z9fmu1DcnYLkw+4u4kXz0T2MBKU21D4syzAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JX/uuB1G0D4nsos9oSWb6QkVq1JWxKOzzKHnBC94oU=;
 b=TjO8Mg5hQu47gnFYU5R8e49aV1t4vnqqOHb/jq2xJlZRNCAE7Jnfstvpmors3g0qErWBln+fGc1eajgpzhNu8GT19j0Y4E2GGDub9L6G/RbU/QIwApDUUJv/Rnu80T5cV4Hs10WP8flNsRpgDBBkMsgimAxmrCxtYqNK/Wt4mkeTRfgtGiM/Igk1lNevx8cyIuVYDGLahpgr9OXjgmHETA4nbD1/aing9l53273TToRmyZjEM+QIeNu+fCB6SgMb2mJ5fEo008ss8bJ42kZoo3YEGXqrG0o93gCd9z2/TFcZOaIAi8Bea4Cr1ZOgC8C9DTwg6zLoUuldy37gvo3jTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=kaitmazov.com smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JX/uuB1G0D4nsos9oSWb6QkVq1JWxKOzzKHnBC94oU=;
 b=4kNUYo6ZfJ4q6q3+TUJcSRKvbufHfyImH/vFP0mWXgeF3JQ++FBdQ7FgIQUdThTWQBeMeFBBfp1XouNYW3rq+y40TkDpDAZainGbGOg4WEZcacgy6x5itJwsvzndYtJudf/J5tQnj1plTmcjicoNjGSYTn3sTXXfURyMeA4s/Xs=
Received: from MW4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:303:8f::7)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 17:18:22 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::26) by MW4PR03CA0002.outlook.office365.com
 (2603:10b6:303:8f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 17:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 17:18:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 12:18:21 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 26 Aug 2026 12:18:20 -0500
Message-ID: <61586ab4-bbc4-2795-c4c0-1a0299aeea66@amd.com>
Date: Wed, 26 Aug 2026 10:18:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] accel/amdxdna: refuse an I/O memory mapping of an
 imported BO
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, "Taimuraz
 Kaitmazov" <taimuraz@kaitmazov.com>, Min Ma <mamin506@gmail.com>, Oded Gabbay
 <ogabbay@kernel.org>
CC: Sumit Semwal <sumit.semwal@linaro.org>, Max Zhen <max.zhen@amd.com>,
 "Sonal Santan" <sonal.santan@amd.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <linaro-mm-sig@lists.linaro.org>, "Liang, Wendy" <Wendy.Liang@amd.com>
References: <20260813164700.43960-1-taimuraz@kaitmazov.com>
 <20260813164700.43960-2-taimuraz@kaitmazov.com>
 <5933effe-ef28-9838-1dd5-dc904be0a3bd@amd.com>
 <87c9bb85-2514-44ac-a976-e24526c7f76e@amd.com>
 <a782e2ad-d12a-66c8-447c-725d8e66593d@amd.com>
 <4aaae413-ea6d-4865-be67-f352ee23aa4b@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <4aaae413-ea6d-4865-be67-f352ee23aa4b@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 50702b05-150e-4cfb-aa14-08df039607c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|56012099006|4143699003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MO2VTC9M3E5fof+mfkhHFhOLPzyeUZ7JV4nPFpzggpshcRAg0Tfg6UhT13NMKGssY3CqU+h0h+VPKQPLpczA9Si7N4sopH2DCufRXwd9v1eRDdoHj5zu4QZyoysrwLRvjl9VMchzptq69CX24NHBn2kyFfoK3XY0k7nksSZNw67qLYCGrwHWcH//hTmU50S1MZL1ZGGhixipdBKm4ZwFwygaaRSj2gQ5fCVRKafU8rELeo/e4EkKnRF+NKHx6zW5u/XxzPCXpeRPXAFbcKadgiYr66QIgTFWtV63fVPfAw8smgHT4dRdmkWT8CXJh4fe4Y4oFSvtyA8V6eOzH47jFwKPVgrCwc/h8qvjo67A/RWaoqZDfexvR7c8Ce7C7yHw+VNTuHMIcY9SJbF0wB3kzCZnuCUIGdq4VtcYRxMxKVLH01fcgjnU1+XHKGxCMm6FfJwqEvew0TtPEGLQR9tjV9uimi071vNeXB6TSiGIaGLOHsW2Plxr5ET58nJSHPGvT7ZFr2js4ozBAa1hcoLuGsp40JRho1Qi1gHcyZbTDGQENc550luXHCk1DbBwo9+dXpP5PFubyMfUL+LGrXVLIHO2DcEEvw+7iEy5qUJuZ3WUvpJ89rVyprpM8Tl2OYS4+o2fsXoQJjeI7WW2pD0H8VLlPFf8mc1wnbSTGbRsh0b4uV3RqgdblYGn2fQw71jTgZTNeD+acTVgzQmlCHtPAg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DInbD85+WRZO2r7WQ+BGbO+IXWXlH+L+6VNPqfg5joo7FU/1zNwWxVByO60SWdvZDfmME1cdkETZXvuDbl5Ic3ukHlS4KjYJzm5T07nkdq8b0Is0E2sVp2bIw1eOBxtMGJopWERFH9/+hdaLmvWXVcdvhPaOQITBUGf7jEGulFuEWTXHHTTws29+g4WmitqtG/XTpWM7b9gAEvCJn5IEHjzjwAjKPU6P09xwEjyiV3sVm913SIQ+BlDL4N6rhF3qsyAzx2PBOfTGiM6feDGAzt0brYg1v+ifObslnfIO+nzNVFnmH7LwPrvHwHnOkcEjrP4LhjpWc8CJugzuwx7wWAKKq61K4+CQfDYB/4+lsM8RFkYuGmXjZvr+LMkKTGdUfwRhvJ0+VZhVu0ltLvNaKAUSeNEPE23BIWFe4BQM4AJbULV1U0NP1uhGe9gyoVuV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 17:18:21.9390 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50702b05-150e-4cfb-aa14-08df039607c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
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


On 8/26/26 01:37, Christian König wrote:
> On 8/24/26 18:08, Lizhi Hou wrote:
>> On 8/24/26 07:06, Christian König wrote:
>>> On 8/17/26 19:53, Lizhi Hou wrote:
>>>> On 8/13/26 09:46, Taimuraz Kaitmazov wrote:
>>>>> amdxdna_gem_obj_vmap() takes whatever dma_buf_vmap() returns and only
>>>>> rejects a NULL vaddr. iosys_map is discriminated by is_iomem, so an
>>>>> exporter answering with an I/O mapping leaves a void __iomem pointer in
>>>>> abo->mem.kva, which amdxdna_cmd_set_error() memsets and memcpys through.
>>>>>
>>>>> amdxdna_drm_va_tbl takes a dmabuf_fd, so such a BO can be any exporter's
>>>>> buffer. amdgpu cannot reach this: its .pin forces GTT for a non peer to
>>>>> peer attachment like ours. An exporter on drm_gem_prime_dmabuf_ops has
>>>>> no .pin, and drm_gem_ttm_vmap() answers iomem for a VRAM resident
>>>>> object, so an NPU paired with nouveau or radeon does.
>>>>>
>>>>> Refuse the mapping. vmw_gem_vmap() does the same; unlike that one this
>>>>> path is reachable from an unprivileged ioctl, so it does not warn.
>>>>>
>>>>> Signed-off-by: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
>>>>> ---
>>>>>     drivers/accel/amdxdna/amdxdna_gem.c | 10 ++++++++--
>>>>>     1 file changed, 8 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/amdxdna_gem.c
>>>>> index 1f190b319bb..b66ec9e4828 100644
>>>>> --- a/drivers/accel/amdxdna/amdxdna_gem.c
>>>>> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
>>>>> @@ -683,10 +683,16 @@ static int amdxdna_gem_obj_vmap(struct drm_gem_object *obj, struct iosys_map *ma
>>>>>           dma_resv_assert_held(obj->resv);
>>>>>     -    if (is_import_bo(abo))
>>>>> +    if (is_import_bo(abo)) {
>>>>>             ret = dma_buf_vmap(abo->dma_buf, map);
>>> Mhm, why does amdxdna a vmap in the first place? For some workaround?
>> This is used for flushing the imported BO before. Based on our discussion before, the driver should not flush imported BO, so this becomes a invalid case.
>>
>> On the other hand, vmap on a io_mem should not happen. So I suggested to move the check to amdxdna_gem_vmap() for an extra check.
> Oh my, you should not use a vmap to flush CPU caches even if you own that GEM buffer! That is as buggy as it can be and most likely doesn't work 100% reliable.

We know that it would be problem on non-x86 architectures. And currently 
the device is X86 only. Is flushing through vmap buggy on x86 as well?

To make the flush running on all architectures,  I can remove the vmap 
completely here and only use drm_clflush_pages. Does this sound right?

>
> What is the complete command submission flow here?

So the submission flow is roughly:  alloc bo -> mmap BO -> write BO 
content (and flush CPU cache by user space runtime) -> submit/wait io 
command.


Thanks,

Lizhi

>
> Regards,
> Christian.
>
>>
>> Thanks,
>>
>> Lizhi
>>
>>> Usually DMA-buf only provides that framebuffer emulation scanout inside the kernel.
>>>
>>> On the other hand as far as I can see that here should work correctly.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>> -    else
>>>>> +        /* Callers use mem.kva as an ordinary kernel address. */
>>>>> +        if (!ret && map->is_iomem) {
>>>>> +            dma_buf_vunmap(abo->dma_buf, map);
>>>>> +            return -EOPNOTSUPP;
>>>>> +        }
>>>> Thanks for the fix. The 'is_iomem' check should be moved to amdxdna_gem_vmap() to cover all the cases.
>>>>
>>>> Lizhi
>>>>
>>>>> +    } else {
>>>>>             ret = drm_gem_shmem_object_vmap(obj, map);
>>>>> +    }
>>>>>         if (ret)
>>>>>             return ret;
>>>>>         if (!map->vaddr)
