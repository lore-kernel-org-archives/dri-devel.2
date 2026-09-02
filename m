Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A679C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90F8810E49E;
	Wed,  2 Sep 2026 08:45:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Mh5r5vfg";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013038.outbound.protection.outlook.com
 [40.93.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A45B10E49E
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 08:45:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbSXCrTPtRtLn9O+70VAbeYx9hi/k6JbuEJK9JPm+zBi6cqUlmpf6+WxpVneti6uA+Kq6rif5TKdyKzObRmL3BihUm/sJh0vIjyslXSs/cg5Z2KgFyq4vUJ4zVuP7fR07MYzYbMBDp3mAjnLpFOspo7/lEnVephm44qcmne68yHOx5uJodWgTdRtwH7hAjgIV+MbzwFro2/Rs6Qn0eZHsfzQnCfHEQdWg3srFhRNbW69b2a0JwTAW4das1dEFLCXTUcMltTE9VmjX6smAUtpuSp7VafvycbNTPVCh4dr45U8KbRWwbyGx03hjM3lQmpQcsWDdy7WH9OWW6leNmwn9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFwcXpdpffCKkO1q264Uttv42OLseUMigXrFKMMvB/g=;
 b=rynXD6NadByLftJVeX9qdW9t43TE0kp2bYP73fUR1kB+Ct9sY7iAC3VNh/W/zVwJxdFBQbK2WsyBIyekbU4+6nDpMiV7nfhCVu9DPOFoiPrSSlGD9OFTy2dcNTZkWLbX02wn9CmTu0XbDv3s7Fj35huDUiYZmpBWnV1niPWOrHB/ERXjxkSxmOCJVbuIsgKS+5xMyIeMfS8ElRISKVc8VSSyaSagFQwiijQ7exDXzsK1M90YP2g7/2xeSVcszH3AZoqvFpkMfYMGXpRxOcJLawzx2CKRqa1qUKHLN8Y32kO5q1276ho/qeQGqTnLbfPi1mvW9PpGYmBs/KERekJ83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFwcXpdpffCKkO1q264Uttv42OLseUMigXrFKMMvB/g=;
 b=Mh5r5vfgLXu/PvuX8QcsicvH4C4ezHxIQQKIotCa04rgL1ZeKrNQH84QGLbgJ0hJSWgOT77t9Z5Yq4iF1mWWZWSaXmb4A+c2eJRdCSNCvjEKsVvMWV/9aGORc1US4AUn0xwpoJ2TRIH5kUmv1yIfrXjRPtpbo+tCBfdhpcZKqfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:45:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 08:45:06 +0000
Message-ID: <aae19599-2ba8-41fd-b3a9-b1f80107f563@amd.com>
Date: Wed, 2 Sep 2026 10:44:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
To: Leon Romanovsky <leon@kernel.org>
Cc: David Hu <dhu@x6u.co>, sumit.semwal@linaro.org, alex@shazbot.org,
 ankita@nvidia.com, chriscli@google.com, david.laight.linux@gmail.com,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, jgg@ziepe.ca,
 jmoroni@google.com, kevin.tian@intel.com, kpberry@google.com,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org, viursachi@google.com,
 xuehaohu@google.com
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
 <20260902073936.GR24140@unreal>
 <aed39f83-6340-4fe9-890c-6d5f340c97d6@amd.com>
 <20260902083232.GT24140@unreal>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260902083232.GT24140@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR15CA0039.namprd15.prod.outlook.com
 (2603:10b6:208:237::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e469cd-dcd1-45af-9cac-08df08ce7ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YCfQNFpuxEtSUDwTS6mR0rCOTcg4RuEfMX4D4gf8Y6rRftbwrJA2D0XV1KC++LCzgU0hI/W9DnrJctLQnUqBE/FWvQ4ry2QAhUcfgbKplGV9DZHNqf81sgCjwJ/eIA9838Q2omgw/rnSDgqtGYp67skjOuVZR0gsr82XKdsQ7MbQ8x9J+zXRNgsfQ3HCl/pwx/lGpHWHRFTEnQQ4dVzQsrh3odMaOKEaF8/r2C4PYT1mYex+0wHXqGAV2tNfKmNAMXcVeOQl2OrW37s36ec+K1zkyT0U/b3PzcOW4yZb5XNN4YOpFd6HFTQdD9DU7cjouUB7m94mdH/qh56PYk+GuobaEb7BAtsPzCSjg8YrTyS7zeGiHML5vx5ochsFILb9EzJm5yIJ8BK3OzmC6+9mH21SUkrP47kPQMWTfuIxQ0DUv0TNoBKzGjWM2ONGqRVvFd/nVhDNY8VH641rPw1IV2PJXHq/yRBOUJUNM1Yy5aPzSnHQ/3sufNG+URADYYUYi+d+NheGxKE7jDR4h0942LHn4HpFQMUkcCnUZjDF5MtPseUywEbvY7oxlCMaOH113ncIuzmzVA2XXfILicuBh3mOcoC438JBpGuhoL5pjjVwavurodh0ErrC1lTfpn53
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YSs3U25SZWFtdlZJQlRpTXNDUWFONlVLVkppeUNMejVJcUFSUnYzSW91K3Fl?=
 =?utf-8?B?L1pYQU93ZlpmNTd3YXkxZ3FvM0lPSUFDL0lVRkIvVlNkYkxlLzkybThsOEs0?=
 =?utf-8?B?dFhlTDRmbUVHSkZQOTl2UnZuNW1KS0NwSzFaS3JDK0duUFd1UjF1bzBZQ0Fk?=
 =?utf-8?B?N05XSU92THFQZFJsTGtZN0tac1NKN280L0NsVjZ6YVJaTnRiWVgrMlQ5QTJk?=
 =?utf-8?B?VjU5Y1ZjSi9QVjAxU1lwMnBIRmhtemU4VElaSFFwdlZBR2pEclVndUg5UU05?=
 =?utf-8?B?cjlKQm5Da1RwWWEyZXI1anVvVm1UNFlGZjkrbmN1UElVT2Q5UUFSR2JjbFpp?=
 =?utf-8?B?TmNYQ0FyWWRQb2YxNFFqN21zVmpyQkJCTHRqdVgrelY0YTlORGdEVjFqSFZW?=
 =?utf-8?B?MUh1cFQ5aE9PbHg1K2czdG5vYzdiRk55RHEwVWxyaHV1SUo1TXJnVzJPa1Ew?=
 =?utf-8?B?R2xld2NkNGxZVjE0emphSFdaZnRkTUVWSklTMys3a0tQWERxSVpwNGViNDFl?=
 =?utf-8?B?SUU3dVlSdnhnTFdQcTRpRjM4aHppNWNvYThvTDlJQ1RWdWtkcXVvV2lYc3VS?=
 =?utf-8?B?bHJ6WmxsbVl2SytUQ3pRMkNBMUxESE1wbHAyelBUazFVamQxa2pVZjgyLzk1?=
 =?utf-8?B?Z1dEZDdINXBsYUZuNG9ickFGa1F6clg5WHh6VEFnTklUSlNaYzdBd1lnTUdP?=
 =?utf-8?B?WFkyQS8yMVRjQzFib1ZiWFl2bnhBWkpjR2lRdmo3aGJYTjU3ZTYwbU9qVzR2?=
 =?utf-8?B?SWNBSFV6cjI5dWdPc0dyZ1hIMmUrQXhvT2xMWGxIY0JmT2czVDN3UmpBWGEy?=
 =?utf-8?B?OEdhSkYvWmsrOXVPNEtRQlhEWTFSZ2hZMVp0anZwUkFFVDVKMEEwZS8wY045?=
 =?utf-8?B?S1JoSlFERWdIT2tUTyt6MXJ5TndVaXlNVHBSUDVTRWdodnRFZ2xaV1FFdmc0?=
 =?utf-8?B?UjB3aC9kMC8wcEo5aEcyekZESVJnOVlYWmkvdUhtRzZhMUIvZHJkQW04d1VQ?=
 =?utf-8?B?SnFUVnFudXE5UDdTcTlNWWVWejhwMWI1U21wbXhvTituaS9odXhPSUE4V3dO?=
 =?utf-8?B?WjBVVjZkMlFrZzJ3NHo3QllwSG5peGI1Vyt1NTZFd2RjQVpsdS83WDNxUyt6?=
 =?utf-8?B?RXp5ZjJJeHJzSCtLWkc1ZUFheks2bjhEMmRQWDZVZTdjNEUvVWdwSEhSTWhy?=
 =?utf-8?B?OWJFQXRjQkpmM05lOW4xRzQ3a1BwSHFVbURQb0gyWnpLWXRTM01MSGR6RUFw?=
 =?utf-8?B?OGpma3ptRk5CR2V3N2hBRjlNUkxKV05vK1RPRVNORjJlQ255WDZnWUthbGcv?=
 =?utf-8?B?NHllSzN1SUhIVjJoUlhwOUxwKzFDdElUSzJMektpYWVLTmUwejJWb1J2eHRn?=
 =?utf-8?B?OVVvVkc4VFBkaWhuLzE3RTF3WllQTTlVMlprNXp0aFlUcnBOdCtyWFRyMVVP?=
 =?utf-8?B?L0d4VU0wVVFCbXhmQzFra29DSmJ5NG1QWGZxRHZTU0o1THJ4SUdYZTA0eHVX?=
 =?utf-8?B?bmJvMVBKc1FQcGNYenAxU1JBWGpmbVBBMDlxVU9NelpVSm5vN1Q2ZDZwNU10?=
 =?utf-8?B?OXNyZVBEaWhUTW90Z2t0MjZrK0tUNENTd0kvaFN1RXk5NFFzaWVFTWhmNnpt?=
 =?utf-8?B?azBrajFLZ1NjbTR3YmVTUVg3cFBXK3BSeUZHTFBxQ1o0Q1UxRXM2VUllTDRS?=
 =?utf-8?B?ZDhmaHRUcXZMdldHNUk0eFZ2S21LVWY4eHZERHdONVFTcFZteEFwQmNGK09q?=
 =?utf-8?B?Zms1N3k0M0dqMnJmSFphMitZVmMzUElESXgxeXl5Zzk2Q1ZOdFFtRlJuRlBV?=
 =?utf-8?B?bmZXOE5hQmtVNGhFc3FBNXRlRWxhckpDeVRoRktiUVJwOGZsb0RvUGVRaDM1?=
 =?utf-8?B?NS9rRUdqMUcrcGFyUXQ0WVNxcjZZcVI2ampGZ3pXcUUyVXZPdUcxSTFrRS9U?=
 =?utf-8?B?Z0lzUzBYR1pzYUtYRS9jZ2M3RUVhKzJjYmRxMmdHRVdnYXNVc09PSXFlM050?=
 =?utf-8?B?cENESkhGTHpKOEZvUkNNOHJXSUlkdUV0L2l5Q0VjUkQzWDMyajZEK1dSUHA0?=
 =?utf-8?B?UVgxNUozZkNxTzdUSDhYY0RBcmxXL1I3YXpPT3d0bTd1ZExqaXZqRUpRSlg5?=
 =?utf-8?B?cnZ0S1ZRdUhXa3owYjA4N1FSajh3SmJ5SjJib2p4MmN2S25ySzdFOEZNYU9U?=
 =?utf-8?B?UFJkeUtNdExIdlBUVGcrS29mYUt4S1l2bmRieWlpb1Ixa0Nqa0xZSEdqejAw?=
 =?utf-8?B?M1RIMnlsOGJDQVovT3VPWjlsK2I4czlBODBFVWNxYUxvZnNmTTVvKzdlSzVS?=
 =?utf-8?Q?DIyhrde+10JwxuX5ou?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e469cd-dcd1-45af-9cac-08df08ce7ca4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:45:05.9474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19K05qF5jtsWNcuezCGjxOLmXFB2h9McFmjgsJvg2LjJNqa2DZ/hUpFq30fiLHSJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990
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

On 9/2/26 10:32, Leon Romanovsky wrote:
> On Wed, Sep 02, 2026 at 09:56:06AM +0200, Christian König wrote:
>> On 9/2/26 09:39, Leon Romanovsky wrote:
>>> On Wed, Sep 02, 2026 at 09:00:46AM +0200, Christian König wrote:
>>>> On 9/1/26 19:08, David Hu wrote:
>>>>> From: David Hu <xuehaohu@google.com>
>>>>>
>>>>> This series address two related issues in scatter-gather mapping,
>>>>> specifically for the MMIO based dma-buf mapping. The fixes ensure
>>>>> sgt mapping is correct, and proper for large MMIO regions.
>>>>>
>>>>> Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
>>>>> (Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
>>>>> phys vec to sgt)
>>>>> https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/
>>>>>
>>>>> Patch 2 Splits sgl by largest page aligned chunk
>>>>> (Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
>>>>> https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/
>>>>
>>>> *sigh* such issues are exactly the reason why I didn't wanted the dma-mapping stuff inside DMA-buf. That clearly doesn't belong here.
>>>
>>> And this is why so many in the kernel community want to get rid of SG
>>> lists. It would be great if DMA-BUF could also eliminate the need to
>>> convert to an SGL, like Jason proposed.
>>>
>>> The DMA layer no longer needs SGL. These bugs belong to the DMA-BUF layer,
>>> which is the one that depends on it.
>>
>> I'm all fine using an array/xarray of dma_addr_t in DMA-buf, just phys_vec is a clear no-go.
> 
> You are proposing the same thing as an SGL, just in a different format.

Yes, because that is the right thing todo as far as I can see.

> It does not address the issue that dma_addr_t is expected to hold a DMA
> address, while that is not always the case. For example, in the P2P case,
> the addresses are not DMA addresses.

Yes they are. They must be DMA addresses because that is the only thing the importer needs to do it's DMA.

It can be that those are DMA addresses on private interconnects between devices, but it should *never* be a phys_addr_t because that is limited to the address space the CPU can see.

> Jason's proposal:
> https://lore.kernel.org/all/0-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com/

Yeah, I have commented quite a bit on that.

Regards,
Christian.

> 
> Thanks
> 
>>
>> Regards,
>> Christian.
>>
>>>
>>> Thanks
>>
>>

