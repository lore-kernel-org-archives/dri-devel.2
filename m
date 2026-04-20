Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76543F5A8A6
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 18:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4ED910E72E;
	Mon, 20 Apr 2026 18:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aVklxapU";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D879710E72E;
 Mon, 20 Apr 2026 18:23:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykTQ0xx/J6AlZJPhAypTTWZEyPLqH9GZXTYEQRQjboNTV0on+w+Y2go0uCOROcDQ3qbbdw7BdL53VNO2mB7IbM1W79zI03XWYs9MnSR9jdo/M0satBsdwM7xZLajA7U8DFQ7Alt4Qj3gYj9KUTbr4X95uszP7bVpd1hpZBzQlFlYno2Tx2wIg5vZKkzTXT0oK84WK5+SZMrtMvMMMzZACs19j/gdhVjY0Qr10IPsNA67UflFJYjRn7ijHMqUil8jZbOh6adElmPUWh5003JyT8X6xH6daCgJ99hTsvyQhOPDIi5pOO4T1xjiRnUJvC595abnRTwf3+JvkrvLIxX85g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxOgpKjjt8TWNx/SV020ObmmN9i7c7qsAEBB6TW5ozs=;
 b=GPUWu2hTW/qTjU2rBpCRanQjUgncDN5lDKtp+aGMQ16i+ZgIhT8PdCgzPWZeCHZu9WWJ/O/tlDfcRpsgMWNiY/Ej04Q7kZvAh3e9R2NqqtiONg4wAtQkww50QnFnlzWUB8v7HWA8e9YNSln0Bwy0Vke6C3OpY77TSwEI51dYu1I1Fr5vZVsVpnZY2p6YZrLnQP4XnboMTSZ8L4oAklh/CCY2jYMvJQm4Rgl160/D4405NYnFxGPpP2CIe/33aaEh5fxQHaYFrKB+5lfq6/oY5+0ac0+hgF6Zr/di4Kbm0tmIkgOghfF741MipzMDfMvOv+q8AlGJHGelolBa2O420g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxOgpKjjt8TWNx/SV020ObmmN9i7c7qsAEBB6TW5ozs=;
 b=aVklxapU45WVMd0hzK8BzjrVCW1nMbv6IxyevB1+o8NP6+tLNEWTOXW3EQ/YVGI3QUX2R1rzEVkeoZV4buFRMimkEnh7avxX2j2DCXlWyPX1nslr1GzBUk6EU/aXdNW1rsN8NkllabKJ4aTb9kpwkpAZE6caiURoMPailWNJpy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 18:23:26 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 18:23:26 +0000
Message-ID: <7eb86bbd-d875-474c-a052-176f6d00ad79@amd.com>
Date: Mon, 20 Apr 2026 20:23:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/amdgpu: consolidate SDMA trap IRQ handler
To: Alex Deucher <alexdeucher@gmail.com>, Giovanna Uchoa <giovannauchoa@usp.br>
Cc: alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260420032858.10286-1-giovannauchoa@usp.br>
 <CADnq5_P2+OqDtmhwOAuM9QsOFi8D45QA+=XOCqJ1vbMbjVQJCg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_P2+OqDtmhwOAuM9QsOFi8D45QA+=XOCqJ1vbMbjVQJCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0299.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::34) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: fcfc757c-8c12-4794-1a29-08de9f09e9c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: JW8upGkTPqiwGB57AUl8/KhLSVEmoTOAObq5i2L1CKlq5KuF4vjZTS2hnzUdIu4YKwYA9tRx3O9WpncN7vKu6bG60IAzxdsxz+B/OhB+35xDMi2JSwul6b/F4b9wQKN9ZuCUzkEJ4GKCDhhQJgaICOaIzs5Cx+gmhPmS+kSLpRoSy5D4rx1xolz3rdCBLJlxEwYPGZYo9YrTN3ZYYhimWKcR7ISJoKT70pKrqW+hsbINWFNCUqCF31usT/ptl3nMBrWwCnKDS7p6OvLwo+hKqdg+o+gbSq2kquvjc+TP21OUwKohIlhsitqieq6PWw1XxIKVKHL3RWuJ/ns4aSu5+CC/HU6BiWcXEBZTnoISe1ZYqh234n6OL/FW0v9fwI8GppiYCmkX8HoQcR1VdlNONPur6hwi1ooY2wdO/2z7ShFHru1j85dLqXuEmAeZG0T1MacyysS+fvrorC+a81rw/3yWjZtKRPqgQr43Ehq2LvaYl6+JOhEuhy5r1OXli76dk+1r+MEn+J+sEYh0d7DKsDiGJbBNZPgJ0j5Zvz/J4PhCLpQS5y4ptCc+u+LD7XTDIAG1oBCurg36unsqzxe94G/UjjGEZIuCGkuPRj6kGlnI3CGWTp5iD5qkfeItDDsyo1/A+MzblCfhFEiYGQMTXz0tiNWLg1Pw7NRhf7ej5dTnbubgaAcBa6gTeGFhBB157syaCorbI/W/cE0mGH56/q643BYVqIa7xVFhtCaU7FM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkpjaE9rVURMbUdBeXgxUzlsU1RHbkhjYnEwSHlOeTZMZmVmNzBra0s4M2pu?=
 =?utf-8?B?bCtYS2RXM21ZQk1rY09ZTWNua1hoOFFyRjR4bU0zVVZlRTlXelQrS1M3UDZP?=
 =?utf-8?B?WXRMZnhCSU1ON0xPbUtjL2NLNkVnWVN5QUcvUjZQZFFpcGxVczRlS2tsOEpK?=
 =?utf-8?B?NWhSNlNsbGhhT0FwcmFMRVpTaElaeUxNQ0dtUWhvNi9DNzcwNWU0d1FCQWd3?=
 =?utf-8?B?OGhob2c1Vm40aFdpU0FmV0ZVZFhZUkNPWFBpYjFndU9GZW5FUTVnVjBpVFRa?=
 =?utf-8?B?cjZtZHhqR2EyVndkdnpqeEN6SjAzL25kMUZlQ0o0YXJsMkVQTU5CdDkyZGdo?=
 =?utf-8?B?S3lJdmd4ZUVoQi9iUXhuN3J2eE1pZmtJVTc5UXhNcnNTeUxyTnVabndUZXlk?=
 =?utf-8?B?ZGdJc0Vsd3BKaHNhRm5JZTV6dkNDUmdaeTIyWmdUQmRJZ1VZd29ER25Oei9S?=
 =?utf-8?B?MXRPT1BXMkozeGtFY1lQYlhNVFU1QjVNdXpkelZ0a2d0R1hwdW1aQXVoSW1t?=
 =?utf-8?B?VU9UZTRkUXhid084dUxydFNHSk52R2JaS2FnTzlBTUVhM01sZUlqMzhXc0JZ?=
 =?utf-8?B?SGNVVnQxU04raG0wZ2ZSU2VESUhBN3hpb0MzRTV2TllGR1BJQ2VSYXBRSkhD?=
 =?utf-8?B?WnpORE5RZW9EME5WNDhMTFBzOU56UElWdnRETjVkbHRvalZoc2hNUzJjZDJN?=
 =?utf-8?B?UkVlWEtWUjdHcFpQb28wUnBYUkF5NXd0WUx3ZU0vZi9tdlc1VHNmS2JHUWg3?=
 =?utf-8?B?K0hRZFpxR09DUGFWMkNUdFhMS1JrLy90ekhCYWVwdHNKeU9ySmlyMVRtRVJo?=
 =?utf-8?B?aTlSRDFnM1E4a2NIaUcwaVQvZXNZTThYcmNxYlY4S3VwM3hiWFBUR0JiN1h6?=
 =?utf-8?B?WXJ2dWh0aXNFeC9iNzRmVFRLTEFkNHMrQkIrZ0xweFR0MjdYb1Nlc25uZkM1?=
 =?utf-8?B?VlgwU1FETHZYNmdXNFAxbE00dGRpby9CK0VibVpmTEgwNVpKa0JEWUx6WFlo?=
 =?utf-8?B?bWhXNmVHbmpjRmtoMjltMWtIN2RTaDR1d05QTXg2SXJ1VW5rQ1FxUGpERXZn?=
 =?utf-8?B?cWF2aHdnZXc5K3hHcWlOUW42RWN0SHB3cUJPdWpjSzU3aWxFbEFreWV2dE1s?=
 =?utf-8?B?VmJJQmZhc1FnV3N2ZjJjcGVva0lMR1hocFd5am5iejBHQmtqa0tWTHVCQmFh?=
 =?utf-8?B?elJ6YVlCWTdlWEJXMm83dHlISlhYeVR1c1BWQUE5OCtDV0FBZUVyZkhPQ0JZ?=
 =?utf-8?B?bGN1NnRhTldQeVdIMVBqSXlUeG1aTWdjS1JWeWxmczlZcDhMNC9qamxGRzJn?=
 =?utf-8?B?L3MrL3o3VG5YZklrelFsck1ScWR4ZFJpNWpiQ1N2ZytndVNqS0FHUWsyakly?=
 =?utf-8?B?ZUxMVVNXNXlDMmtreUc1ZVhvSUdJUmI1aE1zeFZ6Q3JSdWhXZksvU29GUjdk?=
 =?utf-8?B?WkREM0xYWWhNUkI3UnpScmxIdmdZTis2RHJoaVlGWTQyeWMxdjloME8yUE5D?=
 =?utf-8?B?UThWeVhTSEx1bXpPRkFtaW5sQkM1TDdOVWs2QjR6VjJ0aUszbjVCYkVwVDFp?=
 =?utf-8?B?WWZUSUQ1ZHp6eEM1UHMyeGRSNHdFTlJoaEFpM0NoRGdlZ1NEN1pzc0g3aWdw?=
 =?utf-8?B?YnpMTUZ4VVpQRk05a01SbEYwczY5clQ1eFNJdGdsK2NRWndIa2Q1Z3hXcjUx?=
 =?utf-8?B?Rkg5UXY3WHRXdXRKR2dFY3JLWGdlZ2g2TjJxUjBDdThUaEN6T0JGa2x0OU9t?=
 =?utf-8?B?WWtUQ3NPR2hFR3VjNzVINDR1aFI4VExJVzBqQjNMbmg5d2JOYVZjZVRob2k2?=
 =?utf-8?B?ZnNrRVl5c0JiTEtSN0JWNUJ4YWFKdFpMRVNJdGpCOHNNRWxENnpydS9yVkRS?=
 =?utf-8?B?SXhCb0hnYUpYYi9HUjMyYm5kVlpZZG92aGxaUmdoTFc4OE5YQi9wYzg3MmE3?=
 =?utf-8?B?Y1VJZDdRZUhscU9qbVdTZTR0VnFIdFU5cFowT05FVFNZeHRrWmFwa2JrV2R5?=
 =?utf-8?B?bDJsMTNraENuNDdEK0l5MHJwL3BkcWF2V1VGaFlQTXFmWDVMQmVzRHNDQTdu?=
 =?utf-8?B?NjkweWlTM1NoS0FUTTBKSGZ4VXhmVW5CdHJPdlFZL3hIVVRPdWZvZzR6VE1E?=
 =?utf-8?B?VU4zYW5XZmNScW14d3hmRUFmTzJnUkJ4RkQydVFob0hsSE16NStKZGtsZExp?=
 =?utf-8?B?VG5zYXZqdDJ4VzRVdFhMYmhZcTU3NEFBNHNRQzhEdVJybDlZQmpRcHlGeHdj?=
 =?utf-8?B?RFE2SHo5dWcvS3JZWWV6N0tDUWZRRFhLbWp1NHVFZy9nR3AzOER2WXluOCt5?=
 =?utf-8?Q?mXbPPnTEmjqca+220n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcfc757c-8c12-4794-1a29-08de9f09e9c7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 18:23:26.1338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJCBGoPjBtb4TlLO2AkCq5Hdtl7E3feVZN0ogjJUuXEgjSs/woyakChBxeUo9BCz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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

Wait a second Alex, this patch actually doesn't make sense at all.

The code is only common for a subset of SDMA engines and so shouldn't be moved into a common handler.

Regards,
Christian.

On 4/20/26 20:18, Alex Deucher wrote:
> Applied.  Thanks!
> 
> Alex
> 
> On Mon, Apr 20, 2026 at 9:09 AM Giovanna Uchoa <giovannauchoa@usp.br> wrote:
>>
>> Move the amdgpu_sdma_process_trap_irq handler from version-specific
>> implementations (cik_sdma, sdma_v2_4, sdma_v3_0) to the common SDMA
>> module (amdgpu_sdma). This eliminates code duplication and centralizes
>> the trap interrupt handling logic, which is identical across all SDMA
>> versions.
>>
>> Update the trap_irq_funcs in each version-specific module to reference
>> the common handler implementation.
>>
>> Signed-off-by: Giovanna Uchoa <giovannauchoa@usp.br>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 ++++++++++++++++++++++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ++
>>  drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 43 +-----------------------
>>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 42 +----------------------
>>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 42 +----------------------
>>  5 files changed, 47 insertions(+), 124 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> index 321310ba2..4f15334ce 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
>> @@ -147,6 +147,47 @@ int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
>>         return 0;
>>  }
>>
>> +int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
>> +                                    struct amdgpu_irq_src *source,
>> +                                    struct amdgpu_iv_entry *entry)
>> +{
>> +       u8 instance_id, queue_id;
>> +
>> +       instance_id = (entry->ring_id & 0x3) >> 0;
>> +       queue_id = (entry->ring_id & 0xc) >> 2;
>> +       DRM_DEBUG("IH: SDMA trap\n");
>> +       switch (instance_id) {
>> +       case 0:
>> +               switch (queue_id) {
>> +               case 0:
>> +                       amdgpu_fence_process(&adev->sdma.instance[0].ring);
>> +                       break;
>> +               case 1:
>> +                       /* XXX compute */
>> +                       break;
>> +               case 2:
>> +                       /* XXX compute */
>> +                       break;
>> +               }
>> +               break;
>> +       case 1:
>> +               switch (queue_id) {
>> +               case 0:
>> +                       amdgpu_fence_process(&adev->sdma.instance[1].ring);
>> +                       break;
>> +               case 1:
>> +                       /* XXX compute */
>> +                       break;
>> +               case 2:
>> +                       /* XXX compute */
>> +                       break;
>> +               }
>> +               break;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  static int amdgpu_sdma_init_inst_ctx(struct amdgpu_sdma_instance *sdma_inst)
>>  {
>>         uint16_t version_major;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> index 2bf365609..ca4fd94ac 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
>> @@ -203,6 +203,9 @@ int amdgpu_sdma_process_ras_data_cb(struct amdgpu_device *adev,
>>  int amdgpu_sdma_process_ecc_irq(struct amdgpu_device *adev,
>>                                       struct amdgpu_irq_src *source,
>>                                       struct amdgpu_iv_entry *entry);
>> +int amdgpu_sdma_process_trap_irq(struct amdgpu_device *adev,
>> +                                    struct amdgpu_irq_src *source,
>> +                                    struct amdgpu_iv_entry *entry);
>>  int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
>>                                bool duplicate);
>>  void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> index 120da838a..1bf1af633 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>> @@ -1141,47 +1141,6 @@ static int cik_sdma_set_trap_irq_state(struct amdgpu_device *adev,
>>         return 0;
>>  }
>>
>> -static int cik_sdma_process_trap_irq(struct amdgpu_device *adev,
>> -                                    struct amdgpu_irq_src *source,
>> -                                    struct amdgpu_iv_entry *entry)
>> -{
>> -       u8 instance_id, queue_id;
>> -
>> -       instance_id = (entry->ring_id & 0x3) >> 0;
>> -       queue_id = (entry->ring_id & 0xc) >> 2;
>> -       DRM_DEBUG("IH: SDMA trap\n");
>> -       switch (instance_id) {
>> -       case 0:
>> -               switch (queue_id) {
>> -               case 0:
>> -                       amdgpu_fence_process(&adev->sdma.instance[0].ring);
>> -                       break;
>> -               case 1:
>> -                       /* XXX compute */
>> -                       break;
>> -               case 2:
>> -                       /* XXX compute */
>> -                       break;
>> -               }
>> -               break;
>> -       case 1:
>> -               switch (queue_id) {
>> -               case 0:
>> -                       amdgpu_fence_process(&adev->sdma.instance[1].ring);
>> -                       break;
>> -               case 1:
>> -                       /* XXX compute */
>> -                       break;
>> -               case 2:
>> -                       /* XXX compute */
>> -                       break;
>> -               }
>> -               break;
>> -       }
>> -
>> -       return 0;
>> -}
>> -
>>  static int cik_sdma_process_illegal_inst_irq(struct amdgpu_device *adev,
>>                                              struct amdgpu_irq_src *source,
>>                                              struct amdgpu_iv_entry *entry)
>> @@ -1270,7 +1229,7 @@ static void cik_sdma_set_ring_funcs(struct amdgpu_device *adev)
>>
>>  static const struct amdgpu_irq_src_funcs cik_sdma_trap_irq_funcs = {
>>         .set = cik_sdma_set_trap_irq_state,
>> -       .process = cik_sdma_process_trap_irq,
>> +       .process = amdgpu_sdma_process_trap_irq,
>>  };
>>
>>  static const struct amdgpu_irq_src_funcs cik_sdma_illegal_inst_irq_funcs = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> index 93ec52c1f..545077897 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>> @@ -1035,46 +1035,6 @@ static int sdma_v2_4_set_trap_irq_state(struct amdgpu_device *adev,
>>         return 0;
>>  }
>>
>> -static int sdma_v2_4_process_trap_irq(struct amdgpu_device *adev,
>> -                                     struct amdgpu_irq_src *source,
>> -                                     struct amdgpu_iv_entry *entry)
>> -{
>> -       u8 instance_id, queue_id;
>> -
>> -       instance_id = (entry->ring_id & 0x3) >> 0;
>> -       queue_id = (entry->ring_id & 0xc) >> 2;
>> -       DRM_DEBUG("IH: SDMA trap\n");
>> -       switch (instance_id) {
>> -       case 0:
>> -               switch (queue_id) {
>> -               case 0:
>> -                       amdgpu_fence_process(&adev->sdma.instance[0].ring);
>> -                       break;
>> -               case 1:
>> -                       /* XXX compute */
>> -                       break;
>> -               case 2:
>> -                       /* XXX compute */
>> -                       break;
>> -               }
>> -               break;
>> -       case 1:
>> -               switch (queue_id) {
>> -               case 0:
>> -                       amdgpu_fence_process(&adev->sdma.instance[1].ring);
>> -                       break;
>> -               case 1:
>> -                       /* XXX compute */
>> -                       break;
>> -               case 2:
>> -                       /* XXX compute */
>> -                       break;
>> -               }
>> -               break;
>> -       }
>> -       return 0;
>> -}
>> -
>>  static int sdma_v2_4_process_illegal_inst_irq(struct amdgpu_device *adev,
>>                                               struct amdgpu_irq_src *source,
>>                                               struct amdgpu_iv_entry *entry)
>> @@ -1159,7 +1119,7 @@ static void sdma_v2_4_set_ring_funcs(struct amdgpu_device *adev)
>>
>>  static const struct amdgpu_irq_src_funcs sdma_v2_4_trap_irq_funcs = {
>>         .set = sdma_v2_4_set_trap_irq_state,
>> -       .process = sdma_v2_4_process_trap_irq,
>> +       .process = amdgpu_sdma_process_trap_irq,
>>  };
>>
>>  static const struct amdgpu_irq_src_funcs sdma_v2_4_illegal_inst_irq_funcs = {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> index 3fde9be74..b3eab4e11 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>> @@ -1373,46 +1373,6 @@ static int sdma_v3_0_set_trap_irq_state(struct amdgpu_device *adev,
>>         return 0;
>>  }
>>
>> -static int sdma_v3_0_process_trap_irq(struct amdgpu_device *adev,
>> -                                     struct amdgpu_irq_src *source,
>> -                                     struct amdgpu_iv_entry *entry)
>> -{
>> -       u8 instance_id, queue_id;
>> -
>> -       instance_id = (entry->ring_id & 0x3) >> 0;
>> -       queue_id = (entry->ring_id & 0xc) >> 2;
>> -       DRM_DEBUG("IH: SDMA trap\n");
>> -       switch (instance_id) {
>> -       case 0:
>> -               switch (queue_id) {
>> -               case 0:
>> -                       amdgpu_fence_process(&adev->sdma.instance[0].ring);
>> -                       break;
>> -               case 1:
>> -                       /* XXX compute */
>> -                       break;
>> -               case 2:
>> -                       /* XXX compute */
>> -                       break;
>> -               }
>> -               break;
>> -       case 1:
>> -               switch (queue_id) {
>> -               case 0:
>> -                       amdgpu_fence_process(&adev->sdma.instance[1].ring);
>> -                       break;
>> -               case 1:
>> -                       /* XXX compute */
>> -                       break;
>> -               case 2:
>> -                       /* XXX compute */
>> -                       break;
>> -               }
>> -               break;
>> -       }
>> -       return 0;
>> -}
>> -
>>  static int sdma_v3_0_process_illegal_inst_irq(struct amdgpu_device *adev,
>>                                               struct amdgpu_irq_src *source,
>>                                               struct amdgpu_iv_entry *entry)
>> @@ -1601,7 +1561,7 @@ static void sdma_v3_0_set_ring_funcs(struct amdgpu_device *adev)
>>
>>  static const struct amdgpu_irq_src_funcs sdma_v3_0_trap_irq_funcs = {
>>         .set = sdma_v3_0_set_trap_irq_state,
>> -       .process = sdma_v3_0_process_trap_irq,
>> +       .process = amdgpu_sdma_process_trap_irq,
>>  };
>>
>>  static const struct amdgpu_irq_src_funcs sdma_v3_0_illegal_inst_irq_funcs = {
>> --
>> 2.53.0
>>

