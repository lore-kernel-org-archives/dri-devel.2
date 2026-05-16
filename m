Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68680CD4F21
	for <dri-devel@archiver.kernel.org>; Sat, 16 May 2026 15:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5D2710E184;
	Sat, 16 May 2026 15:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lmw9Zgdp";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010042.outbound.protection.outlook.com
 [52.101.193.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72D4D10E1B7;
 Sat, 16 May 2026 15:01:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9LTxhdwb1bSHr1wDr5Hk51V8STJbqoLr6hA4AzX5uQwWS3ZIp1pOCqUa/ilOauQbkyUbgu0fEOEYqM7s/DJGD//IsaO1LLm7WNr9SAca/hTv8nIu4uJu/0IPkPQVBHaoN/G9eS0iPgB+yg7CEJEfGS6J5A6fClQGfeC7RYbYc4gQTfhzzftDb5PFQdX6mc6B2hU0USJKPi/yK4i+Tftsnns+rFH5RD119TCWyZG5faLnHEKixhxDs7nnBbjuq1gqHgBLayHvZOhPNmKOASsbrUNQ9pnkFDlCNB8PveeRFHqfXvRQT4BipvGfICHXk2vgFhxqjm2TiyynW98ipZkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyG2EnKA/SktDjIT+Ui9wwYn4momPSal+tWcdqtEOfg=;
 b=F5IJAj22qBTVCqXUenItmij3YeLdS+AvQtF+qDLGmCHohAACDz3vb3R5W8l9k9Ju9NLosWfe5vevOHUndvAErcA+HL/sh85EccB/43u0C1oTBV1WPe0reOnFiA2IdTFIilBtttoch4H8dL5BxOZ9YahC2/dVYKnGKkzXMNDAuN6mlppTy6jRz6rW6bmUbGuFKSqwEPEkRxh2AzSIuBRzdeyZLqzVbtxhAjVF7cR2h7BFCaj5mWvdQ4N3u3UrG/gIS7De2vui09Lm0Fw06yFlfbmCoCQ7JNzkx++sxWKIaWW1+BUqEL4Nn0VsHr6FBO8ElSz7IMM5uhxwy1ac5igXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyG2EnKA/SktDjIT+Ui9wwYn4momPSal+tWcdqtEOfg=;
 b=Lmw9Zgdpm5eE5kfGgKHPCQHr5RILcvcbQHhevhHalnIBVypkE8MNBzfKreRHNh8wxpuyjKfMFmkxoWEV+K1E1urDONtHYDg4Gdxd4RSKCci10aHJpE3uPqrAOg85tuu+tKlNqMAK3L/iOaUtEExSdES/AYlsN9UV7Mk1ZkxUtR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) by
 BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Sat, 16 May
 2026 15:01:51 +0000
Received: from DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c]) by DS4PR12MB9612.namprd12.prod.outlook.com
 ([fe80::5e55:25ea:365c:f99c%5]) with mapi id 15.21.0025.020; Sat, 16 May 2026
 15:01:51 +0000
Message-ID: <33465492-458c-4a50-b035-ca546ec810c0@amd.com>
Date: Sat, 16 May 2026 11:01:47 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix UML build guards for x86_64-only code
To: Alex Deucher <alexdeucher@gmail.com>, Alex Hung <alex.hung@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, harry.wentland@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel test robot <lkp@intel.com>
References: <20260514170139.335618-1-alex.hung@amd.com>
 <CADnq5_MZ=S-b3smHdHA_0_+hZq92Y66oKO=KCfzoG79F_fardA@mail.gmail.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <CADnq5_MZ=S-b3smHdHA_0_+hZq92Y66oKO=KCfzoG79F_fardA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:408:141::14) To DS4PR12MB9612.namprd12.prod.outlook.com
 (2603:10b6:8:278::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR12MB9612:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 009d8b66-5998-47a7-be6d-08deb35c0f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: 9tJbD9oNBB6x+WAIfWmJ273lM10r2AM/FrIoMN47KG4D6RBdRjUcyLCf6MbT4/Eb5kXwoYbF8baC0aU+3JkDqlOJayoC1G4GFDDM8REwf/9BUxEqIM++1xit158DXQvDLhqf6yn5zTLGrP6OtEjI/VCcrD7SFZH+eiDdMQBdfes6vT+wTEp5gCPEsA81A0UivVS+rOhPM12OI2ccI1YI98QbSFujEUPbbCFKANzzmGw0Ua77mHzTWteGai36MJdrt7FrzblrI0Mz+FQZdAgMaYnxf8znnNnn6GNAsy9h1zwNG0iPEjNDW/EWFa0U028mpIEvq9kHSAWig/d83TdjSm5XBtVoDiALQFI8fMerI0GlZxmWjVba5mSLVh+4s1v+L5zFm90x25hUf057BPc81U6nSixL/etmNXqPSkybEEZp0ReENn1TiZaHdNwbgvZbupE2rDC2WGAsx0dfMWzw19o4XL9L9DRADv82ZJNraxueA9UQ16R8/UZ75Z9oatoqfMcnWTfRPZZ2ypCDlvXvVlGcte+SlT3X2L5MEYqwq9ncLu8VGNjek9Mff3yEhxi63/TnG9KkdiTtap1H/88Node3dAX7/7R1xmEtfobn+R8562bF7SnEB5NkggoFM+jWA+nVOXrT7Q9ScDxCjCcaafdLFAmMgVPchUqtMWlSJhwN+2nxsWn0VcGo028xcPiP2Wv/2GUpEouypDEV7JQOgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR12MB9612.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXF3YTkrelNBK3VIeUJNSHdaTDlvdTROY0o5bUtIK0lHSkpEaVlYNUFubkpT?=
 =?utf-8?B?enRjTUN4cGcwcE1VNUcybU9iVUFHYmFMT3cwWW5LQ3V6c2ZBc2s1Rjd4YitJ?=
 =?utf-8?B?VkIzU0lVZEQ2S3V5L0FHWWw3TEVaVGxSRG1WNVdrTGVyVmFZTGxyV2dtUDZy?=
 =?utf-8?B?cHpqNnhnYytHL1JWbGRHdEkxU3NyZkYyUk5FTHZLN3hMdURXa1lOVUEwSnhl?=
 =?utf-8?B?RTFXc3Q0THRFTUJTMzVYZnBYT0huTW9wczNWdmxjRld3ZjdKZUJYQXdTcU8y?=
 =?utf-8?B?cEZNdDdBdFl2Y2dHbkVDSkFDUmlIdEhWR2ZmVDFxMDVqN2tyTzVqT1U4WDlD?=
 =?utf-8?B?QTB2bitQdFcyMEE1N2xneWduelEzWG9IR29WR1Nybk4vUkQxbkVFK2lVcDBX?=
 =?utf-8?B?NEkzalpnZjluVi9tSnZFY1NQTDhFSVBWcFoyc2NCazNtbkU5YXExZ2d6MGt5?=
 =?utf-8?B?a0tkRjEvZDBvd0JtUVZnVHZuaHJIN2NsMlpxeXd4OVBaQzRSNFdOb2N6aVl5?=
 =?utf-8?B?QzZDRG5XbTIyQnNSWDRZaEQrcitBaDBlWkJkdm9LT2gycWRHWHA4dUZEeVlX?=
 =?utf-8?B?cVZsaEJIaWJJT0ZqaS9idkIwOWMzR3lBTGtQOVU1T2ZvSDlWWWY2SmRzRkdp?=
 =?utf-8?B?bXFkN1dOZmlwcGxrekRlNkQrMyt1aG1mSUU0REkyVVdTa2RsUjd6QVQvYkdT?=
 =?utf-8?B?cGdZOTJDTnlqdjVudFE3bU9TeEJ6bGRBRDlnV2VzMVpaRFA4a044R2s3SHJK?=
 =?utf-8?B?OVAzZnhONVV4OTNNL1NYaXRqL3pIWUF5YzgwNXdhbDlEL0xjdFBIK0x2dXd6?=
 =?utf-8?B?U2RkaUlZcUdNb1lZVVFOZnhDU0Z4RGhDSDhiVnRiQlZndkdlQ0xUcXlJYlVB?=
 =?utf-8?B?OVRnTW85aTVaVkx3K0xPSlA3T3lJdDg4NjdZY1VxM3ZEWm9YNlRFVis2elBR?=
 =?utf-8?B?RFZsNEFBK0djT1VTSFRwYU4xSG84SXh0amR0VDFDbFhqVWFnVFp4aHRUZEhK?=
 =?utf-8?B?M3VUaWZaUUg3M2loWW1qdm52cmFEeUlIVzJRWFJ1VzFPRFJpcllWanlVVWtz?=
 =?utf-8?B?RDVtYXBKdmVnbVJBbjE1bCtJVGQ2ZWY5M1hLRVo2bjN2NmRhZFFOcGtmT2hW?=
 =?utf-8?B?cEdGeHp1SVQ4aEVWNDNNMjN5TU9aUE1xd3doT056MUZ4SHNRUlcvbjdiN292?=
 =?utf-8?B?TlRVVGQ1TzZEQkJpV2dhRi8wOTRKSnY3ZFNkVFc4NG05SXB0a2hGUzY0NXBT?=
 =?utf-8?B?eWtMUHpqWXdmSG1FL2FlUW1KSGhtY0NHTkxZUVlqY0RVcnRFNjlXSndNVzdt?=
 =?utf-8?B?NjZmUjg1cmNoNTlIQzZ6K3dQUEJQbnRhUUk4NldVaWFtWkhWQnFRM01vT0hT?=
 =?utf-8?B?WUNlcktKQURoUURIMTV5cGUyck4yd1V6TkJ2ZDV0VzdVWGpyR0hmWllxNkRJ?=
 =?utf-8?B?anBid0ZTOFN1WExuL2pHSTNpTmkrS2IrYnZNa0w0dlI3VGx0N1pPdURFZVZv?=
 =?utf-8?B?ekUya1pVZVpVSnQyWWpXcFZNT0JMZ2dmdjhxZ3VTTzduaEhva0RFZ1dRd21S?=
 =?utf-8?B?Q3pYcHVQL0d5d1ZlZE9SOUZVbDg1bzE5cG81aTVlWnUwdlpKRjNqMGRxRHgr?=
 =?utf-8?B?RVFMbkxxM25tM1BpMW1uaGFkVGJ3R3JjQ2tDTTZiaUpjMHIxYXBqZDdPcDJU?=
 =?utf-8?B?SXlYMDlaU0lUV0VmM1c2QWE2eVozQ2UvWTFET1lZQ2JtcXdjYnlteGpnTndO?=
 =?utf-8?B?YXJlblkxaWluaFZmK2JKSTBFVnhlclpYQ1V6RFU0cjNNdkVwNXgyV3k1TE9j?=
 =?utf-8?B?ZEZmNG84TFJobTRRSVExcktnRlNha2NvSUFaUXM5RVpiNGZGalptb0ZyVEFR?=
 =?utf-8?B?b3JBNXlhb3gvUGZ2R3RJUHYrNWRNMytvOEo3OEJsT3pkTElubmJkcDdMVzM0?=
 =?utf-8?B?UDR1WWI3WnFRcURrclg2cEtSREJDNDhpSERnT05Ock9WWGwvYzA3SmhXY0xT?=
 =?utf-8?B?dThMZEJnVjB1NThUODZENnBQTC84N21tZ2U4NWk0RTlUbit5TGhaNUExRWRF?=
 =?utf-8?B?SlRBaHdub1Y0RHFJT1FzajBDNmRiVUNLWGIvcGR3b3FmVW9DOWMvdUhjRk1h?=
 =?utf-8?B?bWZzM1dnRHZBN0p2SlhFc3ZVMnJ1cEhUUEtDSk1SWmQ0OUNPMXR5L1JRdUZh?=
 =?utf-8?B?UlRKYmsrbmtzd1BMR29mV3gzU20zZ3VJdG1JZ3VOWkZlQ1BwdDRrZENMek9k?=
 =?utf-8?B?SEtucytPeHRRekJxbVRtOVEvTFAxZmwwUWZvUGtqeFBJZ0FIOU1zbUVHZEox?=
 =?utf-8?B?R1FKb3E5UThQcjB5Uk9zajRzNjBBcjFDcllqalM4U2I2VmtydWNndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 009d8b66-5998-47a7-be6d-08deb35c0f4e
X-MS-Exchange-CrossTenant-AuthSource: DS4PR12MB9612.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 15:01:51.0740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zDVF50TplpMBJMdKt1y79S0Z3EtX76BucWV3MssA4+eC4uVUv1IVRg53J+8y1aCwSJ1EehCJdy+5auAaTUR7Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
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


On 2026-05-14 13:19, Alex Deucher wrote:
> On Thu, May 14, 2026 at 1:03 PM Alex Hung <alex.hung@amd.com> wrote:
>> cpu_data().topo.apicid and kfd_fill_iolink_info_for_cpu() rely on
>> x86-specific structs not present on UML. The kfd_topology.c and
>> kfd_crat.c were guarded by CONFIG_X86_64 alone, causing build
>> failures when CONFIG_DRM_AMDGPU is selected on UML.
>>
>> Update guards to '#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)'
>> to ensure x86_64-only paths are excluded on UML builds.
>>
>> Fixes: e6b71bcdc409 ("drm/amdgpu: Remove UML build exclusion from Kconfig")
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202605140506.TI8zPIBG-lkp@intel.com/
>> Cc: Harry Wentland <harry.wentland@amd.com>
>> Assisted-by: Copilot:Claude-Sonnet-4.6
>> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 6 +++---
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 2 +-
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index a1087c13f241..cf7b1b038d5f 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> @@ -1821,7 +1821,7 @@ static int kfd_fill_mem_info_for_cpu(int numa_node_id, int *avail_size,
>>          return 0;
>>   }
>>
>> -#ifdef CONFIG_X86_64
>> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>>   static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
>>                                  uint32_t *num_entries,
>>                                  struct crat_subtype_iolink *sub_type_hdr)
>> @@ -1880,7 +1880,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>>          struct crat_subtype_generic *sub_type_hdr;
>>          int avail_size = *size;
>>          int numa_node_id;
>> -#ifdef CONFIG_X86_64
>> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>>          uint32_t entries = 0;
>>   #endif
>>          int ret = 0;
>> @@ -1945,7 +1945,7 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
>>                          sub_type_hdr->length);
>>
>>                  /* Fill in Subtype: IO Link */
>> -#ifdef CONFIG_X86_64
>> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>>                  ret = kfd_fill_iolink_info_for_cpu(numa_node_id, &avail_size,
>>                                  &entries,
>>                                  (struct crat_subtype_iolink *)sub_type_hdr);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> index 46db0d65d242..87e13f021457 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
>> @@ -2349,7 +2349,7 @@ static int kfd_cpumask_to_apic_id(const struct cpumask *cpumask)
>>          first_cpu_of_numa_node = cpumask_first(cpumask);
>>          if (first_cpu_of_numa_node >= nr_cpu_ids)
>>                  return -1;
>> -#ifdef CONFIG_X86_64
>> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>>          return cpu_data(first_cpu_of_numa_node).topo.apicid;
>>   #else
>>          return first_cpu_of_numa_node;
>> --
>> 2.43.0
>>
