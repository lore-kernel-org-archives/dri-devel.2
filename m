Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A575BC61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:59:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0881410E1C8;
	Tue, 25 Aug 2026 13:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zUW2/ZNt";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B835210E1C8
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 13:59:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nVm8R9B8UP4/WK6xMMTb8nII7gnsGQ0a51dLUoV/IPGfSiNfFDSEkDgLEDXNLTfw6uQTTxJ6RR17KH6f2Z8lRmwBfzHyIpaVZfxY69uVav1hPkJS3mQwaR10idrPDUorD3GKmWqm9qFc6jnYt1ZQoP1tDylFR98vaUYqwDDqfwKW6xmhcFrNOCeYNsJY9Kkub8WKM3lzfe80IRY8YlH0mVVFEcubkkzoL0+frNtzTRNOEp3Cqp1JXMnINrHhhl3t82a2cnyC8Qe9NpMi5FzBTY7r5ajmAFCSQSZ3hGJV+m/UhZkjf9w5xDESmckIcgokfP7LfObm3nASr4KHphmx9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFT0YDVq7u4Bt0Kd2ifUXeVOq3C3XDD6gnPJlMcTPj0=;
 b=VWr+gWU0Ser9JEN3x/ahjdT0nAktsPIk+0ZfIB0cdGR/1XZOMA+YNGH/vIBFUsm+JlrJnmsQ4ZCGjAMrILFg6d/Wrqy6lQWpRdRM4ncmPXZSlqPjD9smNYLTCGP8mPo46cV9iKEmCPyvBbBNAB5nAYQQSoERUVW8O6PLfPq2AmuHSeFQbegEn8w6EfhEqYFHsE5j9TnUImDLFbHUodS/TouGkOaGhjonzUGtllpN1lZgw/KSERpe+6Zq79FALltrBRTtit68ixO0qLYpaR//WnqPF2H+PmFMXptH52UWF3+wQTT4XUFgWaPjByep1afSFe9eCI7p6A3VY6unDKhsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFT0YDVq7u4Bt0Kd2ifUXeVOq3C3XDD6gnPJlMcTPj0=;
 b=zUW2/ZNtF40tqylPByFXhL6Sovj+CgLN4sxhiYYBAmPxBZSJFapnGyOVLJHAIr9lheIfIGUZUSo1WwegiotT9UqRqAxsIHinQhW4ifqKg/AYfT9MC9R6DH7Sbuj5GuT4ndtkvl7lxnCKPEVFkj4vru2fbUehQs6KXxXMnIo50Fg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 13:59:45 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Tue, 25 Aug 2026
 13:59:45 +0000
Message-ID: <8fdf21c6-94e9-4994-b92f-5213525f3d16@amd.com>
Date: Tue, 25 Aug 2026 15:59:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/15] accel/qda: Add DMA-backed GEM objects and memory
 manager integration
To: rob.clark@oss.qualcomm.com
Cc: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Bharath Kumar <quic_bkumar@quicinc.com>,
 Chenna Kesava Raju <quic_chennak@quicinc.com>,
 srinivas.kandagatla@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 llvm@lists.linux.dev, iommu@lists.linux.dev, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-9-69a02e9090d4@oss.qualcomm.com>
 <7030a8f8-f320-4b09-b2de-2c8e897409f8@amd.com>
 <CACSVV00MubttbkVJgMommPMorf67yqn7D1kfwpxVUZ0t-6au8Q@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CACSVV00MubttbkVJgMommPMorf67yqn7D1kfwpxVUZ0t-6au8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0131.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ffaab4f-5b47-4484-ac44-08df02b11e19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|23010399003|376014|10067099003|56012099006|6133799003|3023799007|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: xsQ+yCnbEnKclJdBACqI7fm25gCk9ZVTlhoQ6FU+7j8m5ymJpcKyEi1KLwIdedw7pLf4OvNNtttCoMjBsaDaQJunjkg0qwWBa/7WQ8iEs79o5VF+TX0hMGIKQJtOxtpATH43Vf1r1AIn3ufzk7Ux0ybYiGePN/LAXn6Lji5aA8vCZjZGTT4NkPjBz3E++kkwi8XIXoCQyspiAnTpPvxtd3x3M9mk9m4R5ie8sGg1cr1a8YHNQkUh1xRJP3deB1f5omYbP0Uc+aKgWY8JYecQJwDU6u5GVF9wmaZ3JXuSf7DmRE4Nat9KKAU4jxiX8xOkHLfOkMMiHRQi3Tm3Q7oozRvurHfPix9NrYwjvHz3fCNuQfvbDu6ddYuwI105+b3omTlLauVU9z7tpzoO5We+ClVzNWNm+anE52fGthm0urCTRPYal9Y30bqmi93i3aq6S8S2gcU9beCpKf7m4VvsMS7L17OGeEnxfX9fKDG1KaMpRskiBoiXTiHlBAFjZSxYuWovNWDeKBGnemTqEZR7RVKjyff9mtWVREY6BCguGa+twOyX5mwBqZ3LnRLjTp+SPw6otif7KM1c65FCAQb22xAje9MEAvOB99ayxzaMA192y4nEiVIvQ/gsaCNlaSUHHdRgnYpqQJiaxLNljrhgZdSm0NZCwEt+u4G7iHs1u60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVNZVmJ0RU1aMjExUGVPbVJQdkoraDhmOWIzaWZlSjFiQ1R1Ymc1dXlVRjBY?=
 =?utf-8?B?OEJiK0podTMwWFZFV2lFMndkUSttZm1sL1lDRlJ2elUyVnJNZnFtR2p4SVNM?=
 =?utf-8?B?THppTHVudGpud252bVMyV1o0cTVOZnJWNmVxNkh1RkZKL0tYVHBoN3daZ2NZ?=
 =?utf-8?B?ZlFJOGtJRDcvS2p5dXl6YkJXME9oVHNJOHUvMjNwVE5GbFl2RitZRUhwRkN4?=
 =?utf-8?B?UGxoRHBvcGUwRm50bkZ4a0plMjFaay9iWTRNWHQzWFZFbWdBNmc3dkM4TFVr?=
 =?utf-8?B?Ly91TU9iQUM4dmxtSGVOWm5CakNKaWVVRXM3OFZSRnhuTjJVSnhhY21JNnZo?=
 =?utf-8?B?elVCU3JlUHZZR2w3TWZKWGt6dnJpTm9KYU1LS01kZzJwYXlwQ3dlVnI4djRN?=
 =?utf-8?B?aHROWjk1c1pDNjI2Smp4ZHJqSHVndUVDMHhzYWtEb2xPL04xZlZEQndLM0xm?=
 =?utf-8?B?a3pUU2RpbHp4SGc2bUx1UUh5RjhOTEVjTlY3NW1LTUtxcGtpR2ZpTWJQNnRO?=
 =?utf-8?B?NERLejR3cVNFQ0lJcTF1ZmNQY2xiZmNQbk10a2VWL0ozNXY2cUk2NzZacE1E?=
 =?utf-8?B?OUwwSGdzdVQwQnZoWS9NdmNjUW55aXhMRkFrTllvU05UbkxwbzE0UnhldldF?=
 =?utf-8?B?MG9QNkFRZWliRlZRb2JUalN2eTlJSE43ZGJWOUMzUlJiYncrQ0RxZkNaUHJQ?=
 =?utf-8?B?ZmZacVZCRmY1YThaalBmejhXS1ZqMEo0UGRhU1A2UndCK2MxR1JIdkVaOHFF?=
 =?utf-8?B?cXd2M2ZKaU1McEpabDlMVjR1S3E1Y20vUGh2QXZhTE85dUMrUFRWYVB1WEVu?=
 =?utf-8?B?RWdKell0ejN5MkZDcG4va1VKTkZoREN3SHlQRVJacmFaRjdzQ2RWSG9Rd0c5?=
 =?utf-8?B?dGlsSmpWSFE1bnJ4S2tJaHljQjRjTUdhSWxKTURTTjk2TGJXc3phbnZJMzlm?=
 =?utf-8?B?VStRa01SZ0tQRmRNRlN4L1hhZnlOVDQ3Q1VlaUZBWHdPb3RhSUVUSlVsM0xR?=
 =?utf-8?B?N0YzYU4wZkNTZ2hvR1NyZkpJZE04WXkzbXI1dE1PRmh0V0xUb3R6UWM5Mkpa?=
 =?utf-8?B?OW16ckI2S2k5bmluTEdUSFNzSkhocjRmRWxCclJGT2lkb2lhR2NYeit4NVgw?=
 =?utf-8?B?WEtncWZNVkw2Zk1NRVRtTmVvbThlRFA1MGVvVDZ5US9GUFVKSFpvK1FMSFNn?=
 =?utf-8?B?bGdoUGkzQTdjcjh2QXN4NTY4UVFrT3NwNXVmYmZkV0h2ZFIxWlVUcVVDQVVW?=
 =?utf-8?B?SWpxV29qdGwvclN3VDArU0NNRkFrVXpxUUZjczJIcHhTcVBxWnRMTFd0djQy?=
 =?utf-8?B?UEo2NXNMbmtPQ1h3ei9xZEgrbmh3ckQ3SmRGcHNvVlU1TW1MZ25IeFl0RDJF?=
 =?utf-8?B?cER1UlFuR2h3Q2pXWVlwdjNZYzAzRHRSLzRaTHhYVC9zZThYQURtUlVzTVdk?=
 =?utf-8?B?TzJQNjdTNVhYTXJxK0NVaEIyVUcxUmZiUFQ0elRHNFRDOG1PNUdnUVBtbmxH?=
 =?utf-8?B?dEVOWHJncHlUWWp1NE1TZUE0TktObDFVU0d3Wk5HTFdQZStXZ09PMU1hSGVv?=
 =?utf-8?B?SkdGSHA5RE5hbGl4Yi9jOCtXem4wbVQ3ZXhmUCtjeGhqcHJhTlhHb0FYa0Qr?=
 =?utf-8?B?N2tjVWNoeFNDa0hNM1pwcjFIZlI4TGEyaHFTTU9uK2QzY1kvS2JmdE1yVEVk?=
 =?utf-8?B?SHdqMHlNTEpMRUpOZFhjZ2xOdS9yZlN3T3FSVTE0S1F5MytTYWhvVWh6MzJ1?=
 =?utf-8?B?cnNkWHVabHZJVUpqNkdQRXI4d2JCbG9SMHlRMURaeUF5eVRNbzVmd2xwY2RU?=
 =?utf-8?B?bEhCZzdOZmdOWmQ1YWlqbFZUSVhNcm0zcDRKeG83RnFuaTBMUTdwbWRwVElw?=
 =?utf-8?B?YlVteldsb2JhYVNSdGRpTjVSM2hwblRmbWNTL2YvVnpxbVhWTE5wZmppY3VL?=
 =?utf-8?B?ZGRJSHJFY2x0cHZ1TWNYWlJFcTNpR1dqK3BxNXExNzdJdzlOMVovbkpBVHFC?=
 =?utf-8?B?MXhKKytVZ21ETHYxOVltcFBMTGF6UTF1eFdLUFdwSytGZDlqWGhiMHhLUUZY?=
 =?utf-8?B?d0FxbU02SDBFaEpsWDkvaEd2TFo5OEY1ZS9XRzA3OXBWbExqOVl0RGhuVlBY?=
 =?utf-8?B?cWNBTGcxMFhaZG9ZTVYzSmpDTWpCMC95WHFYREFpNTdwLzErUnc5ci9CaFZ3?=
 =?utf-8?B?Q2N2aGg2YVdWOVdXQTAzZWQyZElLcitZSVFmK3EvdExvNlc2bG1EcjRVaFov?=
 =?utf-8?B?YXlOUElJUnpnSXBWQ2swRFZ2bXZyZmJtU0Q4TEpzRnRRc01YVUxDNlB1bVhR?=
 =?utf-8?Q?pyNYxlYRkElLzGYcxq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ffaab4f-5b47-4484-ac44-08df02b11e19
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:59:44.9212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Gx+SpSJEuiXfwVDHzreR4fyZDxaNd+ekIMRf7mw5Koa7sRqg3etoEL5/nRNNZeW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962
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

On 8/24/26 17:07, Rob Clark wrote:
> On Mon, Aug 24, 2026 at 7:31 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> On 8/17/26 06:47, Ekansh Gupta wrote:
>>> Introduce DMA-coherent buffer management for the QDA driver, wiring
>>> together the GEM subsystem, the IOMMU memory manager, and a DMA
>>> allocation backend.
>>>
>>> qda_gem.c / qda_gem.h
>>>   Implements the GEM object lifecycle for QDA buffers. Each buffer is
>>>   represented by a qda_gem_obj which embeds a drm_gem_object and
>>>   carries the kernel virtual address, DMA address, and a pointer to
>>>   the IOMMU device that performed the allocation. The .free callback
>>>   delegates to the memory manager, and the .mmap callback uses
>>>   dma_mmap_coherent() via the DMA backend.
>>>
>>> qda_memory_dma.c / qda_memory_dma.h
>>>   DMA coherent allocation backend. qda_dma_alloc() calls
>>>   dma_alloc_coherent() on the CB device and encodes the stream ID
>>>   (SID) in the upper 32 bits of the returned DMA address, following
>>>   the Qualcomm FastRPC convention for IOMMU address space tagging.
>>>   qda_dma_free() strips the SID prefix before calling
>>>   dma_free_coherent().
>>>
>>> qda_memory_manager.c
>>>   Adds process-to-device assignment: each DRM file (process) is
>>>   assigned one IOMMU context bank device for the lifetime of the
>>>   session. qda_memory_manager_assign_device() first checks whether
>>>   the process already has a device (reusing it with a refcount
>>>   increment), then falls back to claiming an unassigned device.
>>>   qda_memory_manager_alloc() and qda_memory_manager_free() delegate
>>>   to the DMA backend after resolving the correct CB device for the
>>>   calling process.
>>
>> Oh, stuff like that is usually a pretty big NO-GO now.
>>
>> AMD has made the same mistake with KFD and it resulted in a massive chaos.
>>
>> The DRM file is the driver context your process uses and even if there are multiple DRM files for the same PID you should absolute *NOT* share anything between them.
>>
>> The general rule of thumb is to not attach anything to the process using the DRM file descriptor.
> 
> A couple other things to keep in mind:
> 
> 1. drm device fd can be passed across processes
> 2. virtgpu/virglrenderer drm native ctx is a single process that opens
> the drm device file N times on behalf of N guest userspace processes.
> 
> All that to say, Christian is right here.. drm_file is your context,
> pgtables should be attached to the drm_file (potentially via
> drm_gpuvm.. which you perhaps want to use).

Some additional points you should probably keep in mind:

1. In some configurations the DRM fd is not opened by the application but rather by the display server. So you see for example X/XWayland opening the fd.

2. For gdb plugins you now seriously want to use pidfd_getfd() to grab the DRM fd from the debugged process into your debugger process.

Hacks with the PID or TGID are something which needs in deep review for correctness.

Regards,
Christian.

> 
> BR,
> -R
> 
>> Regards,
>> Christian.
>>
>>>
>>> qda_drv.c / qda_drv.h
>>>   qda_file_priv gains an assigned_iommu_dev pointer and a pid field.
>>>   The .postclose callback decrements the IOMMU device refcount and
>>>   clears the process assignment when the last reference is dropped.
>>>
>>> Assisted-by: Claude:claude-sonnet-5
>>> Signed-off-by: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
>>> ---
>>> Changes in v2:
>>> - Adapt to the dynamically-sized device array introduced in patch 07
>>>   (kcalloc'd from DT node count, replaces fixed QDA_IOMMU_DEVICES_MAX)
>>> - Protect register/unregister with the process_assignment_lock mutex so
>>>   the device-assignment and device-registration paths are serialised
>>> - No functional changes requested by reviewers on this patch
>>> ---
>>>  drivers/accel/qda/Makefile             |   2 +
>>>  drivers/accel/qda/qda_drv.c            |   4 +
>>>  drivers/accel/qda/qda_drv.h            |   4 +
>>>  drivers/accel/qda/qda_gem.c            | 134 ++++++++++++++++++
>>>  drivers/accel/qda/qda_gem.h            |  52 +++++++
>>>  drivers/accel/qda/qda_memory_dma.c     |  82 +++++++++++
>>>  drivers/accel/qda/qda_memory_dma.h     |  17 +++
>>>  drivers/accel/qda/qda_memory_manager.c | 239 ++++++++++++++++++++++++++++++++-
>>>  drivers/accel/qda/qda_memory_manager.h |  30 +++++
>>>  9 files changed, 559 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/accel/qda/Makefile b/drivers/accel/qda/Makefile
>>> index b658dad35fee..a46ddceecfc5 100644
>>> --- a/drivers/accel/qda/Makefile
>>> +++ b/drivers/accel/qda/Makefile
>>> @@ -8,7 +8,9 @@ obj-$(CONFIG_DRM_ACCEL_QDA)   := qda.o
>>>  qda-y := \
>>>       qda_cb.o \
>>>       qda_drv.o \
>>> +     qda_gem.o \
>>>       qda_ioctl.o \
>>> +     qda_memory_dma.o \
>>>       qda_memory_manager.o \
>>>       qda_rpmsg.o
>>>
>>> diff --git a/drivers/accel/qda/qda_drv.c b/drivers/accel/qda/qda_drv.c
>>> index e1fd8bfa12d7..2b14dab95507 100644
>>> --- a/drivers/accel/qda/qda_drv.c
>>> +++ b/drivers/accel/qda/qda_drv.c
>>> @@ -21,6 +21,7 @@ static int qda_open(struct drm_device *dev, struct drm_file *file)
>>>       if (!qda_file_priv)
>>>               return -ENOMEM;
>>>
>>> +     qda_file_priv->pid = current->pid;
>>>       qda_file_priv->qda_dev = qda_dev_from_drm(dev);
>>>       file->driver_priv = qda_file_priv;
>>>
>>> @@ -31,6 +32,9 @@ static void qda_postclose(struct drm_device *dev, struct drm_file *file)
>>>  {
>>>       struct qda_file_priv *qda_file_priv = file->driver_priv;
>>>
>>> +     if (qda_file_priv->assigned_iommu_dev)
>>> +             qda_memory_manager_release_device(qda_file_priv->assigned_iommu_dev);
>>> +
>>>       kfree(qda_file_priv);
>>>       file->driver_priv = NULL;
>>>  }
>>> diff --git a/drivers/accel/qda/qda_drv.h b/drivers/accel/qda/qda_drv.h
>>> index 690a833d732b..2fe58f3efec0 100644
>>> --- a/drivers/accel/qda/qda_drv.h
>>> +++ b/drivers/accel/qda/qda_drv.h
>>> @@ -24,6 +24,10 @@
>>>  struct qda_file_priv {
>>>       /** @qda_dev: Back-pointer to device structure */
>>>       struct qda_dev *qda_dev;
>>> +     /** @assigned_iommu_dev: IOMMU device assigned to this process */
>>> +     struct qda_iommu_device *assigned_iommu_dev;
>>> +     /** @pid: Process ID for tracking */
>>> +     pid_t pid;
>>>  };
>>>
>>>  /**
>>> diff --git a/drivers/accel/qda/qda_gem.c b/drivers/accel/qda/qda_gem.c
>>> new file mode 100644
>>> index 000000000000..66e78013a726
>>> --- /dev/null
>>> +++ b/drivers/accel/qda/qda_gem.c
>>> @@ -0,0 +1,134 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>> +#include <drm/drm_gem.h>
>>> +#include <drm/drm_prime.h>
>>> +#include <drm/drm_print.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/dma-mapping.h>
>>> +#include "qda_drv.h"
>>> +#include "qda_gem.h"
>>> +#include "qda_memory_manager.h"
>>> +#include "qda_memory_dma.h"
>>> +
>>> +/**
>>> + * qda_gem_free_object() - Free a GEM object and its associated resources
>>> + * @gem_obj: DRM GEM object to free
>>> + */
>>> +void qda_gem_free_object(struct drm_gem_object *gem_obj)
>>> +{
>>> +     struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(gem_obj);
>>> +     struct qda_dev *qdev = qda_dev_from_drm(gem_obj->dev);
>>> +
>>> +     if (qda_gem_obj->virt && qdev->iommu_mgr)
>>> +             qda_memory_manager_free(qdev->iommu_mgr, qda_gem_obj);
>>> +
>>> +     drm_gem_object_release(gem_obj);
>>> +     kfree(qda_gem_obj);
>>> +}
>>> +
>>> +/**
>>> + * qda_gem_mmap_obj() - Map a GEM object into userspace
>>> + * @drm_obj: DRM GEM object to map
>>> + * @vma: Virtual memory area to map into
>>> + *
>>> + * Return: 0 on success, negative error code on failure
>>> + */
>>> +int qda_gem_mmap_obj(struct drm_gem_object *drm_obj, struct vm_area_struct *vma)
>>> +{
>>> +     struct qda_gem_obj *qda_gem_obj = to_qda_gem_obj(drm_obj);
>>> +     int ret;
>>> +
>>> +     /* The fake offset is only used to find the object, not to index it */
>>> +     vma->vm_pgoff = 0;
>>> +
>>> +     ret = qda_dma_mmap(qda_gem_obj, vma);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct drm_gem_object_funcs qda_gem_object_funcs = {
>>> +     .free = qda_gem_free_object,
>>> +     .mmap = qda_gem_mmap_obj,
>>> +};
>>> +
>>> +/**
>>> + * qda_gem_alloc_object() - Allocate a new QDA GEM object
>>> + * @drm_dev: DRM device
>>> + * @aligned_size: Size of the object in bytes (must be page-aligned)
>>> + *
>>> + * Return: Pointer to the new GEM object, or ERR_PTR on failure
>>> + */
>>> +struct qda_gem_obj *qda_gem_alloc_object(struct drm_device *drm_dev, size_t aligned_size)
>>> +{
>>> +     struct qda_gem_obj *qda_gem_obj;
>>> +     int ret;
>>> +
>>> +     qda_gem_obj = kzalloc_obj(*qda_gem_obj);
>>> +     if (!qda_gem_obj)
>>> +             return ERR_PTR(-ENOMEM);
>>> +
>>> +     ret = drm_gem_object_init(drm_dev, &qda_gem_obj->base, aligned_size);
>>> +     if (ret) {
>>> +             kfree(qda_gem_obj);
>>> +             return ERR_PTR(ret);
>>> +     }
>>> +
>>> +     qda_gem_obj->base.funcs = &qda_gem_object_funcs;
>>> +     qda_gem_obj->size = aligned_size;
>>> +
>>> +     return qda_gem_obj;
>>> +}
>>> +
>>> +void qda_gem_cleanup_object(struct qda_gem_obj *qda_gem_obj)
>>> +{
>>> +     drm_gem_object_release(&qda_gem_obj->base);
>>> +     kfree(qda_gem_obj);
>>> +}
>>> +
>>> +int qda_gem_create_handle(struct drm_file *file_priv, struct drm_gem_object *gem_obj, u32 *handle)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret = drm_gem_handle_create(file_priv, gem_obj, handle);
>>> +     drm_gem_object_put(gem_obj);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +/**
>>> + * qda_gem_create_object() - Allocate and initialize a GEM object with DMA backing
>>> + * @drm_dev: DRM device
>>> + * @iommu_mgr: Memory manager to use for DMA allocation
>>> + * @size: Requested size in bytes
>>> + * @file_priv: DRM file private data for process association
>>> + *
>>> + * Return: Pointer to the base DRM GEM object on success, ERR_PTR on failure
>>> + */
>>> +struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
>>> +                                          struct qda_memory_manager *iommu_mgr, size_t size,
>>> +                                          struct drm_file *file_priv)
>>> +{
>>> +     struct qda_gem_obj *qda_gem_obj;
>>> +     size_t aligned_size;
>>> +     int ret;
>>> +
>>> +     aligned_size = PAGE_ALIGN(size);
>>> +     if (!aligned_size)
>>> +             return ERR_PTR(-EINVAL);
>>> +
>>> +     qda_gem_obj = qda_gem_alloc_object(drm_dev, aligned_size);
>>> +     if (IS_ERR(qda_gem_obj))
>>> +             return ERR_CAST(qda_gem_obj);
>>> +
>>> +     ret = qda_memory_manager_alloc(iommu_mgr, qda_gem_obj, file_priv);
>>> +     if (ret) {
>>> +             qda_gem_cleanup_object(qda_gem_obj);
>>> +             return ERR_PTR(ret);
>>> +     }
>>> +
>>> +     return &qda_gem_obj->base;
>>> +}
>>> diff --git a/drivers/accel/qda/qda_gem.h b/drivers/accel/qda/qda_gem.h
>>> new file mode 100644
>>> index 000000000000..afd7c9b49549
>>> --- /dev/null
>>> +++ b/drivers/accel/qda/qda_gem.h
>>> @@ -0,0 +1,52 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>> + */
>>> +#ifndef __QDA_GEM_H__
>>> +#define __QDA_GEM_H__
>>> +
>>> +#include <linux/dma-mapping.h>
>>> +#include <drm/drm_device.h>
>>> +#include <drm/drm_gem.h>
>>> +#include "qda_memory_manager.h"
>>> +
>>> +/**
>>> + * struct qda_gem_obj - QDA GEM buffer object
>>> + *
>>> + * Represents a GEM buffer object that can be allocated by the driver
>>> + * or imported from another driver via DMA-BUF.
>>> + */
>>> +struct qda_gem_obj {
>>> +     /** @base: DRM GEM object base — must be first member */
>>> +     struct drm_gem_object base;
>>> +     /** @iommu_dev: IOMMU context bank device that performed the allocation */
>>> +     struct qda_iommu_device *iommu_dev;
>>> +     /** @virt: Kernel virtual address of the allocated DMA memory */
>>> +     void *virt;
>>> +     /** @dma_addr: DMA address (with SID encoded in upper 32 bits) */
>>> +     dma_addr_t dma_addr;
>>> +     /** @size: Size of the buffer in bytes */
>>> +     size_t size;
>>> +};
>>> +
>>> +/**
>>> + * to_qda_gem_obj - Cast a drm_gem_object pointer to qda_gem_obj
>>> + * @gem_obj: Pointer to the embedded drm_gem_object
>>> + */
>>> +#define to_qda_gem_obj(gem_obj) container_of(gem_obj, struct qda_gem_obj, base)
>>> +
>>> +/* GEM object lifecycle */
>>> +struct drm_gem_object *qda_gem_create_object(struct drm_device *drm_dev,
>>> +                                          struct qda_memory_manager *iommu_mgr,
>>> +                                          size_t size, struct drm_file *file_priv);
>>> +void qda_gem_free_object(struct drm_gem_object *gem_obj);
>>> +int qda_gem_mmap_obj(struct drm_gem_object *gem_obj, struct vm_area_struct *vma);
>>> +
>>> +/* Internal helpers (also used by PRIME import) */
>>> +struct qda_gem_obj *qda_gem_alloc_object(struct drm_device *drm_dev, size_t aligned_size);
>>> +void qda_gem_cleanup_object(struct qda_gem_obj *qda_gem_obj);
>>> +
>>> +/* Utility functions */
>>> +int qda_gem_create_handle(struct drm_file *file_priv, struct drm_gem_object *gem_obj, u32 *handle);
>>> +
>>> +#endif /* __QDA_GEM_H__ */
>>> diff --git a/drivers/accel/qda/qda_memory_dma.c b/drivers/accel/qda/qda_memory_dma.c
>>> new file mode 100644
>>> index 000000000000..7072ed8edf0b
>>> --- /dev/null
>>> +++ b/drivers/accel/qda/qda_memory_dma.c
>>> @@ -0,0 +1,82 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>> +#include <linux/slab.h>
>>> +#include <linux/dma-mapping.h>
>>> +#include "qda_drv.h"
>>> +#include "qda_gem.h"
>>> +#include "qda_memory_dma.h"
>>> +
>>> +/*
>>> + * The DSP identifies the IOMMU context bank from the upper bits of the address,
>>> + * so the stream ID is folded into every address handed to it. The DMA API only
>>> + * ever sees the plain 32-bit address, which is why the context bank devices are
>>> + * created with a 32-bit DMA mask.
>>> + */
>>> +static dma_addr_t get_actual_dma_addr(struct qda_gem_obj *gem_obj)
>>> +{
>>> +     return gem_obj->dma_addr - ((u64)gem_obj->iommu_dev->sid << 32);
>>> +}
>>> +
>>> +static void setup_gem_object(struct qda_gem_obj *gem_obj, void *virt,
>>> +                          dma_addr_t dma_addr, struct qda_iommu_device *iommu_dev)
>>> +{
>>> +     gem_obj->virt = virt;
>>> +     gem_obj->dma_addr = dma_addr;
>>> +     gem_obj->iommu_dev = iommu_dev;
>>> +}
>>> +
>>> +static void cleanup_gem_object_fields(struct qda_gem_obj *gem_obj)
>>> +{
>>> +     gem_obj->virt = NULL;
>>> +     gem_obj->dma_addr = 0;
>>> +     gem_obj->iommu_dev = NULL;
>>> +}
>>> +
>>> +/**
>>> + * qda_dma_alloc() - Allocate DMA coherent memory for a GEM object
>>> + * @iommu_dev: Pointer to the QDA IOMMU device structure
>>> + * @gem_obj: Pointer to GEM object to allocate memory for
>>> + * @size: Size of memory to allocate in bytes
>>> + *
>>> + * Return: 0 on success, negative error code on failure
>>> + */
>>> +int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
>>> +               struct qda_gem_obj *gem_obj, size_t size)
>>> +{
>>> +     dma_addr_t dma_addr;
>>> +     void *virt;
>>> +
>>> +     virt = dma_alloc_coherent(iommu_dev->dev, size, &dma_addr, GFP_KERNEL);
>>> +     if (!virt)
>>> +             return -ENOMEM;
>>> +
>>> +     dma_addr += ((u64)iommu_dev->sid << 32);
>>> +     setup_gem_object(gem_obj, virt, dma_addr, iommu_dev);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +/**
>>> + * qda_dma_free() - Free DMA coherent memory for a GEM object
>>> + * @gem_obj: Pointer to GEM object to free memory for
>>> + */
>>> +void qda_dma_free(struct qda_gem_obj *gem_obj)
>>> +{
>>> +     dma_free_coherent(gem_obj->iommu_dev->dev, gem_obj->size,
>>> +                       gem_obj->virt, get_actual_dma_addr(gem_obj));
>>> +
>>> +     cleanup_gem_object_fields(gem_obj);
>>> +}
>>> +
>>> +/**
>>> + * qda_dma_mmap() - Map DMA memory into userspace
>>> + * @gem_obj: Pointer to GEM object containing DMA memory
>>> + * @vma: Virtual memory area to map into
>>> + *
>>> + * Return: 0 on success, negative error code on failure
>>> + */
>>> +int qda_dma_mmap(struct qda_gem_obj *gem_obj, struct vm_area_struct *vma)
>>> +{
>>> +     return dma_mmap_coherent(gem_obj->iommu_dev->dev, vma, gem_obj->virt,
>>> +                              get_actual_dma_addr(gem_obj), gem_obj->size);
>>> +}
>>> diff --git a/drivers/accel/qda/qda_memory_dma.h b/drivers/accel/qda/qda_memory_dma.h
>>> new file mode 100644
>>> index 000000000000..99352a99dc33
>>> --- /dev/null
>>> +++ b/drivers/accel/qda/qda_memory_dma.h
>>> @@ -0,0 +1,17 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/*
>>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>> + */
>>> +
>>> +#ifndef __QDA_MEMORY_DMA_H__
>>> +#define __QDA_MEMORY_DMA_H__
>>> +
>>> +#include <linux/dma-mapping.h>
>>> +#include "qda_memory_manager.h"
>>> +
>>> +int qda_dma_alloc(struct qda_iommu_device *iommu_dev,
>>> +               struct qda_gem_obj *gem_obj, size_t size);
>>> +void qda_dma_free(struct qda_gem_obj *gem_obj);
>>> +int qda_dma_mmap(struct qda_gem_obj *gem_obj, struct vm_area_struct *vma);
>>> +
>>> +#endif /* __QDA_MEMORY_DMA_H__ */
>>> diff --git a/drivers/accel/qda/qda_memory_manager.c b/drivers/accel/qda/qda_memory_manager.c
>>> index b1a80ee77c35..d47c7419e11d 100644
>>> --- a/drivers/accel/qda/qda_memory_manager.c
>>> +++ b/drivers/accel/qda/qda_memory_manager.c
>>> @@ -1,14 +1,26 @@
>>>  // SPDX-License-Identifier: GPL-2.0-only
>>>  // Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>>
>>> +#include <linux/refcount.h>
>>>  #include <linux/slab.h>
>>> +#include <linux/spinlock.h>
>>> +#include <drm/drm_file.h>
>>> +#include <drm/drm_print.h>
>>>  #include "qda_drv.h"
>>> +#include "qda_gem.h"
>>>  #include "qda_memory_manager.h"
>>> +#include "qda_memory_dma.h"
>>> +
>>> +static void iommu_device_free(struct kref *ref)
>>> +{
>>> +     kfree(container_of(ref, struct qda_iommu_device, ref));
>>> +}
>>>
>>>  static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
>>>  {
>>>       int i;
>>>
>>> +     mutex_lock(&mem_mgr->process_assignment_lock);
>>>       for (i = 0; i < mem_mgr->num_devices; i++) {
>>>               struct qda_iommu_device *iommu_dev = mem_mgr->devices[i];
>>>
>>> @@ -16,9 +28,215 @@ static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
>>>                       continue;
>>>
>>>               mem_mgr->devices[i] = NULL;
>>> -             kfree(iommu_dev);
>>> +             kref_put(&iommu_dev->ref, iommu_device_free);
>>>       }
>>>       mem_mgr->num_devices = 0;
>>> +     mutex_unlock(&mem_mgr->process_assignment_lock);
>>> +}
>>> +
>>> +static void init_iommu_device_fields(struct qda_iommu_device *iommu_dev)
>>> +{
>>> +     spin_lock_init(&iommu_dev->lock);
>>> +     refcount_set(&iommu_dev->users, 0);
>>> +     kref_init(&iommu_dev->ref);
>>> +     iommu_dev->assigned_pid = 0;
>>> +     iommu_dev->assigned_file_priv = NULL;
>>> +}
>>> +
>>> +static struct qda_iommu_device *find_device_for_pid(struct qda_memory_manager *mem_mgr,
>>> +                                                 pid_t pid)
>>> +{
>>> +     struct qda_iommu_device *found_dev = NULL;
>>> +     unsigned long flags;
>>> +     int i;
>>> +
>>> +     for (i = 0; i < mem_mgr->num_devices; i++) {
>>> +             struct qda_iommu_device *iommu_dev = mem_mgr->devices[i];
>>> +
>>> +             if (!iommu_dev)
>>> +                     continue;
>>> +
>>> +             spin_lock_irqsave(&iommu_dev->lock, flags);
>>> +             if (iommu_dev->assigned_pid == pid) {
>>> +                     found_dev = iommu_dev;
>>> +                     refcount_inc(&found_dev->users);
>>> +                     kref_get(&found_dev->ref);
>>> +                     spin_unlock_irqrestore(&iommu_dev->lock, flags);
>>> +                     break;
>>> +             }
>>> +             spin_unlock_irqrestore(&iommu_dev->lock, flags);
>>> +     }
>>> +
>>> +     return found_dev;
>>> +}
>>> +
>>> +static struct qda_iommu_device *assign_available_device_to_pid(struct qda_memory_manager *mem_mgr,
>>> +                                                            pid_t pid,
>>> +                                                            struct drm_file *file_priv)
>>> +{
>>> +     struct qda_iommu_device *selected_dev = NULL;
>>> +     unsigned long flags;
>>> +     int i;
>>> +
>>> +     for (i = 0; i < mem_mgr->num_devices; i++) {
>>> +             struct qda_iommu_device *iommu_dev = mem_mgr->devices[i];
>>> +
>>> +             if (!iommu_dev)
>>> +                     continue;
>>> +
>>> +             spin_lock_irqsave(&iommu_dev->lock, flags);
>>> +             if (iommu_dev->assigned_pid == 0) {
>>> +                     iommu_dev->assigned_pid = pid;
>>> +                     iommu_dev->assigned_file_priv = file_priv;
>>> +                     selected_dev = iommu_dev;
>>> +                     refcount_set(&selected_dev->users, 1);
>>> +                     kref_get(&selected_dev->ref);
>>> +                     spin_unlock_irqrestore(&iommu_dev->lock, flags);
>>> +                     break;
>>> +             }
>>> +             spin_unlock_irqrestore(&iommu_dev->lock, flags);
>>> +     }
>>> +
>>> +     return selected_dev;
>>> +}
>>> +
>>> +static struct qda_iommu_device *get_process_iommu_device(struct qda_memory_manager *mem_mgr,
>>> +                                                      struct drm_file *file_priv)
>>> +{
>>> +     struct qda_file_priv *qda_priv;
>>> +
>>> +     if (!file_priv || !file_priv->driver_priv)
>>> +             return NULL;
>>> +
>>> +     qda_priv = (struct qda_file_priv *)file_priv->driver_priv;
>>> +     return qda_priv->assigned_iommu_dev;
>>> +}
>>> +
>>> +/**
>>> + * qda_memory_manager_assign_device() - Assign an IOMMU device to a process
>>> + * @mem_mgr: Pointer to memory manager
>>> + * @file_priv: DRM file private data for process association
>>> + *
>>> + * On success the caller owns a reference on the device and must release it
>>> + * with qda_memory_manager_release_device().
>>> + *
>>> + * Return: 0 on success, negative error code on failure
>>> + */
>>> +int qda_memory_manager_assign_device(struct qda_memory_manager *mem_mgr,
>>> +                                  struct drm_file *file_priv)
>>> +{
>>> +     struct qda_file_priv *qda_priv;
>>> +     struct qda_iommu_device *selected_dev = NULL;
>>> +     int ret = 0;
>>> +     pid_t current_pid;
>>> +
>>> +     if (!file_priv || !file_priv->driver_priv)
>>> +             return -EINVAL;
>>> +
>>> +     qda_priv = (struct qda_file_priv *)file_priv->driver_priv;
>>> +     current_pid = qda_priv->pid;
>>> +
>>> +     mutex_lock(&mem_mgr->process_assignment_lock);
>>> +
>>> +     if (qda_priv->assigned_iommu_dev) {
>>> +             ret = 0;
>>> +             goto unlock_and_return;
>>> +     }
>>> +
>>> +     selected_dev = find_device_for_pid(mem_mgr, current_pid);
>>> +
>>> +     if (selected_dev) {
>>> +             qda_priv->assigned_iommu_dev = selected_dev;
>>> +             goto unlock_and_return;
>>> +     }
>>> +
>>> +     selected_dev = assign_available_device_to_pid(mem_mgr, current_pid, file_priv);
>>> +
>>> +     if (!selected_dev) {
>>> +             drm_dbg_driver(file_priv->minor->dev, "No context bank available for PID %d\n",
>>> +                            current_pid);
>>> +             ret = -EBUSY;
>>> +             goto unlock_and_return;
>>> +     }
>>> +
>>> +     qda_priv->assigned_iommu_dev = selected_dev;
>>> +
>>> +unlock_and_return:
>>> +     mutex_unlock(&mem_mgr->process_assignment_lock);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +/**
>>> + * qda_memory_manager_release_device() - Release a process assignment
>>> + * @iommu_dev: Device previously obtained from qda_memory_manager_assign_device()
>>> + *
>>> + * Drops the caller's reference. Once the last process using the device is
>>> + * gone the assignment is cleared so the device can serve another process.
>>> + */
>>> +void qda_memory_manager_release_device(struct qda_iommu_device *iommu_dev)
>>> +{
>>> +     unsigned long flags;
>>> +
>>> +     if (refcount_dec_and_test(&iommu_dev->users)) {
>>> +             spin_lock_irqsave(&iommu_dev->lock, flags);
>>> +             iommu_dev->assigned_pid = 0;
>>> +             iommu_dev->assigned_file_priv = NULL;
>>> +             spin_unlock_irqrestore(&iommu_dev->lock, flags);
>>> +     }
>>> +
>>> +     kref_put(&iommu_dev->ref, iommu_device_free);
>>> +}
>>> +
>>> +static struct qda_iommu_device *get_or_assign_iommu_device(struct qda_memory_manager *mem_mgr,
>>> +                                                        struct drm_file *file_priv)
>>> +{
>>> +     struct qda_iommu_device *iommu_dev;
>>> +     int ret;
>>> +
>>> +     iommu_dev = get_process_iommu_device(mem_mgr, file_priv);
>>> +     if (iommu_dev)
>>> +             return iommu_dev;
>>> +
>>> +     ret = qda_memory_manager_assign_device(mem_mgr, file_priv);
>>> +     if (ret)
>>> +             return NULL;
>>> +
>>> +     iommu_dev = get_process_iommu_device(mem_mgr, file_priv);
>>> +     if (iommu_dev)
>>> +             return iommu_dev;
>>> +
>>> +     return NULL;
>>> +}
>>> +
>>> +/**
>>> + * qda_memory_manager_alloc() - Allocate memory for a GEM object
>>> + * @mem_mgr: Pointer to memory manager
>>> + * @gem_obj: Pointer to GEM object to allocate memory for
>>> + * @file_priv: DRM file private data for process association
>>> + *
>>> + * Return: 0 on success, negative error code on failure
>>> + */
>>> +int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr, struct qda_gem_obj *gem_obj,
>>> +                          struct drm_file *file_priv)
>>> +{
>>> +     struct qda_iommu_device *selected_dev;
>>> +
>>> +     selected_dev = get_or_assign_iommu_device(mem_mgr, file_priv);
>>> +     if (!selected_dev)
>>> +             return -EBUSY;
>>> +
>>> +     return qda_dma_alloc(selected_dev, gem_obj, gem_obj->size);
>>> +}
>>> +
>>> +/**
>>> + * qda_memory_manager_free() - Free memory for a GEM object
>>> + * @mem_mgr: Pointer to memory manager
>>> + * @gem_obj: Pointer to GEM object to free memory for
>>> + */
>>> +void qda_memory_manager_free(struct qda_memory_manager *mem_mgr, struct qda_gem_obj *gem_obj)
>>> +{
>>> +     qda_dma_free(gem_obj);
>>>  }
>>>
>>>  /**
>>> @@ -31,13 +249,21 @@ static void cleanup_all_memory_devices(struct qda_memory_manager *mem_mgr)
>>>  int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
>>>                                      struct qda_iommu_device *iommu_dev)
>>>  {
>>> -     if (mem_mgr->num_devices >= mem_mgr->max_devices)
>>> -             return -ENOSPC;
>>> +     int ret = 0;
>>>
>>> +     mutex_lock(&mem_mgr->process_assignment_lock);
>>> +     if (mem_mgr->num_devices >= mem_mgr->max_devices) {
>>> +             ret = -ENOSPC;
>>> +             goto out;
>>> +     }
>>> +
>>> +     init_iommu_device_fields(iommu_dev);
>>>       iommu_dev->id = mem_mgr->num_devices;
>>>       mem_mgr->devices[mem_mgr->num_devices++] = iommu_dev;
>>>
>>> -     return 0;
>>> +out:
>>> +     mutex_unlock(&mem_mgr->process_assignment_lock);
>>> +     return ret;
>>>  }
>>>
>>>  /**
>>> @@ -52,14 +278,16 @@ void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
>>>  {
>>>       int i;
>>>
>>> +     mutex_lock(&mem_mgr->process_assignment_lock);
>>>       for (i = 0; i < mem_mgr->num_devices; i++) {
>>>               if (mem_mgr->devices[i] == iommu_dev) {
>>>                       mem_mgr->devices[i] = NULL;
>>>                       break;
>>>               }
>>>       }
>>> +     mutex_unlock(&mem_mgr->process_assignment_lock);
>>>
>>> -     kfree(iommu_dev);
>>> +     kref_put(&iommu_dev->ref, iommu_device_free);
>>>  }
>>>
>>>  /**
>>> @@ -80,6 +308,7 @@ int qda_memory_manager_init(struct qda_memory_manager *mem_mgr, int max_devices)
>>>
>>>       mem_mgr->num_devices = 0;
>>>       mem_mgr->max_devices = max_devices;
>>> +     mutex_init(&mem_mgr->process_assignment_lock);
>>>
>>>       return 0;
>>>  }
>>> diff --git a/drivers/accel/qda/qda_memory_manager.h b/drivers/accel/qda/qda_memory_manager.h
>>> index 7e38c8a18284..0949c0c213f6 100644
>>> --- a/drivers/accel/qda/qda_memory_manager.h
>>> +++ b/drivers/accel/qda/qda_memory_manager.h
>>> @@ -7,25 +7,44 @@
>>>  #define __QDA_MEMORY_MANAGER_H__
>>>
>>>  #include <linux/device.h>
>>> +#include <linux/kref.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/refcount.h>
>>> +#include <linux/spinlock.h>
>>> +#include <drm/drm_file.h>
>>>
>>>  /* Forward declarations */
>>>  struct qda_dev;
>>> +struct qda_gem_obj;
>>>
>>>  /**
>>>   * struct qda_iommu_device - IOMMU device instance for memory management
>>>   *
>>>   * Represents a single IOMMU-enabled device managed by the memory manager.
>>>   * Each device can be assigned to a specific process session.
>>> + *
>>> + * The object outlives its registration: open files keep a reference through
>>> + * @ref, so a device can be unregistered while a process still holds it.
>>>   */
>>>  struct qda_iommu_device {
>>>       /** @dev: Pointer to the underlying device */
>>>       struct device *dev;
>>>       /** @qdev: Back-pointer to the parent QDA device */
>>>       struct qda_dev *qdev;
>>> +     /** @assigned_file_priv: DRM file private data for the assigned process */
>>> +     struct drm_file *assigned_file_priv;
>>>       /** @id: Unique identifier assigned by the memory manager */
>>>       u32 id;
>>>       /** @sid: Stream ID for IOMMU transactions */
>>>       u32 sid;
>>> +     /** @assigned_pid: Process ID of the process assigned to this device */
>>> +     pid_t assigned_pid;
>>> +     /** @users: Number of open files sharing this device */
>>> +     refcount_t users;
>>> +     /** @ref: Reference count controlling when the object is freed */
>>> +     struct kref ref;
>>> +     /** @lock: Spinlock protecting concurrent access to device */
>>> +     spinlock_t lock;
>>>  };
>>>
>>>  /**
>>> @@ -42,6 +61,8 @@ struct qda_memory_manager {
>>>       int num_devices;
>>>       /** @max_devices: Capacity of the @devices array */
>>>       int max_devices;
>>> +     /** @process_assignment_lock: Mutex protecting process-to-device assignments */
>>> +     struct mutex process_assignment_lock;
>>>  };
>>>
>>>  int qda_memory_manager_init(struct qda_memory_manager *mem_mgr, int max_devices);
>>> @@ -51,5 +72,14 @@ int qda_memory_manager_register_device(struct qda_memory_manager *mem_mgr,
>>>                                      struct qda_iommu_device *iommu_dev);
>>>  void qda_memory_manager_unregister_device(struct qda_memory_manager *mem_mgr,
>>>                                         struct qda_iommu_device *iommu_dev);
>>> +int qda_memory_manager_assign_device(struct qda_memory_manager *mem_mgr,
>>> +                                  struct drm_file *file_priv);
>>> +void qda_memory_manager_release_device(struct qda_iommu_device *iommu_dev);
>>> +
>>> +int qda_memory_manager_alloc(struct qda_memory_manager *mem_mgr,
>>> +                          struct qda_gem_obj *gem_obj,
>>> +                          struct drm_file *file_priv);
>>> +void qda_memory_manager_free(struct qda_memory_manager *mem_mgr,
>>> +                          struct qda_gem_obj *gem_obj);
>>>
>>>  #endif /* __QDA_MEMORY_MANAGER_H__ */
>>>
>>

