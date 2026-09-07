Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C628CC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0582910E7BD;
	Mon,  7 Sep 2026 12:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CcYXzorz";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011049.outbound.protection.outlook.com
 [40.93.194.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0185810E7BD;
 Mon,  7 Sep 2026 12:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7Sgrz5JzD5apPLnV2e9jtoItlR3ML2FOYEgd38068n/k0BZDsX7lQZmqQzTmwpzRsKGuewV+fLjQ2rKEol+8zU1b3+MBTPYaK420LDU0XEvut+NOb2/UAZ8phkEiYaH2ecuMFSWQvWH0zuyQd5rTzcoLtMBoJwhKKjPszVmS3wQKnlIHNabE2HXrL+TDhSeaxg8Uw+ci2Jo4itqfnZBr0iyaxduPp1vbVqsHWguIyaSjhozVnHtok1WbNdtxL2bJTxBtRzBoaZqDvFoe7LhP+oThQN8SNMPqIwxIJFi+Jxx8J4fe2GI8DxtWiQ5dq7/o/uD2mKlZBheHdIR8pncvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ndvA/0pLRXfdPHvfT8FEERdBeCgpPCmHNdN97LCvAk=;
 b=XkoSKd6uigbjgQQUw4nqOqttxacvG3juwUjVWsFx6cRPK3E6SC3Fk5Ec+e9/2EFqIYFMBqF2jyWHyU9GNUH0z1V5Xsgq5YD2ohhLG6+StIWIyct7c9CRGOq9LzJksNipPDsG9RLI7sspf9crbC00HA7T9U1+wescJBU0TcF9sbs0IfLqjd8PA5EJUylhTFV/GxnYyt18t6pvWl3c5W4nbSBOsnDHqu8p9FNduOc3oajhUgTi6vt+VpwL2dLVDQ+NVTfOhiFxvVCJM32UmQ7Iz1pZ2n2kwQZYoVkcXbzH6LMSuLID6f6DaQ3ox+dRlWWsqc0GfXHmpwP6pO6RiGj0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ndvA/0pLRXfdPHvfT8FEERdBeCgpPCmHNdN97LCvAk=;
 b=CcYXzorzYJPsdJjDHUclRWQ4DQjGYrUMULkG0X+heelPnR29Nb80fejcs7pYlOtU6J8NLBKbUJI8XNUauGLB29RDEJYnZj7u1pvIYMWEWzCgUHaIuMPhNdX2yLILz4Eb75OlUAH3WWSy4RZb8FfaFsUkG4AuT6XAj2Lig4ru010=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB999098.namprd12.prod.outlook.com (2603:10b6:408:353::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Mon, 7 Sep
 2026 12:04:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 7 Sep 2026
 12:04:21 +0000
Message-ID: <c0f0b76b-fc3d-4473-83d7-ad820efcbbbc@amd.com>
Date: Mon, 7 Sep 2026 14:04:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: keep freed VM mappings on clear failure
To: oushinnyo <oushinnyo@163.com>, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Harish.Kasiviswanathan@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260905023151.90699-1-oushinnyo@163.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260905023151.90699-1-oushinnyo@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:36e::25) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB999098:EE_
X-MS-Office365-Filtering-Correlation-Id: b0389df3-f5ab-48ad-5a84-08df0cd826e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3hJUntDG53PvM9ofT/6AvyJ4S3AGsArc1CKtZqDmdBlmF0E3nUGBdav+x64F9ljExCLsxD8E5JcIduy+gITKpD/Ar+66MRJfxAUaD6hthjLNa+h0OWZq1/8m0i3S9ogLlvC/9ndRrWZMiruJRZprtcp/J78xn0WJ/kyq3dS6LCTwzYhic0bhkJc40d5xJL8SUV0la+kv4DBBPGwMfJgprwShtGGQKWXKqDayavgrPBv8SRXH1RJLd9b7igFDiPoyZP6o/KCqMSZfSaZvlUCXk7F/B2rwEgb0zOvzGY1P8iGX0ikVYjA3grLDK3JH+lzlXZ25qoJMGJ2qUBSSco7Q2laKcOwftCzKVZIOpAShTa6AnBg2LzNwNaii/5HTSXIPhxjgDOcdbXqT0wONs5zaXhKu/izWNoxlobycMqfHcB7F5sfNneVJo29yK5Q/0ioSNAn1tgYiLgoWb/jmR12sO66drdb/bJSMTy2JkNE/jyywAZBXqwbQjvpzgDavIZ00ECn54TmenMa0rkpg7ByuAGjYuwCl3tA86fYMGofdfEk+qUGze6D1pTRqM6LICDU1pad5OV320Km8q6u5Uin+XqiPLSmDi5pKS0XU0fz7eqG34mnDgWnvTar4lZGQXcBUp6TqnebOM8axtOnrR+QphHAcgCvxFpLbkg3neIPafKo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkU4cEp4VmVNWHFzYWhWOER0YWsyajcvUXJITGRETy96T1ZBL3BhRDZPUHli?=
 =?utf-8?B?ZU5GTzZlU21Yc3JxWUpsaUJqd3lVMUd4RStkVVVWTTFoTGo2Rk5oL2o0cnk3?=
 =?utf-8?B?Y3FnYnQxR093ZmhOelhiNnF1WVJocXVFZGt6LzlFQnFOZUVrTTM4Y1BESVN5?=
 =?utf-8?B?WG94eGdVMlR6bml3ZGppT1M0MnBQdjZ2N0pTaFh0ZWNBNkRTTzY0SkxwckJY?=
 =?utf-8?B?RCs5YUdBWmg0bkRITHl6RE1idXdocjl1bEJDamlkcjRZRWd5aHNrdmRuYzND?=
 =?utf-8?B?U2srQlFTVlhpbGFLWmJjc01MYUVtMlpzbXRlZTBvSU4xTGhvc2RRcEF4aVhD?=
 =?utf-8?B?c2ROT3dOL2JHZkJ1WVk4V0tOUTZCWkFFK2ZXb0xGOTdtK2ZzSElTbVc1ekVX?=
 =?utf-8?B?Y2xTYTdJQ3hSSGllYmNaUkdCSk5qa3p3UjdZYUVLc1pTbVFac3U3eUVTTkg5?=
 =?utf-8?B?Uk1taEJCdlZGMFAwU1FacDhmL1RkZ2ovdkhnMUMwRnVhdS92bjh0dHFlbXJk?=
 =?utf-8?B?TzcvNklPeVJOUllNNzZRL3RZRE8wZjE3SmtXUXAwL3ZuclFtRUpwTVJET2V1?=
 =?utf-8?B?VDcva2hhZSt3RWdiV2x4ZWwwWHJJejhhUHJ0bVB1dXVoeTJRT0V2WStJaHlq?=
 =?utf-8?B?OUdvRC9tWk5aQkY5RUcxdkVpRzZ4OHRrbm50N3pMMVdibUVJNDhwY1pQU0xV?=
 =?utf-8?B?NW9yb29LdFpjK3RxSFdURkR0aEVnRVhIWm5yNUUyOHo0Uk9jalhEUkFpalRq?=
 =?utf-8?B?Z2lNTkpZQ0hvSm1IN3F2WHAyQnFSb2ZiK1d5d085TmdXVGFsUHV4NFE3YXVk?=
 =?utf-8?B?SUVVSXRNYlFaVDgycWt3K1dibnQyNmIvTzc3Tk9Id3J1RmhTaHpQUlBVY3Zy?=
 =?utf-8?B?VnNMdUZGaUREYVZYYW5KbmRZNXo0MWNEUkRYcXBTOTA3dGNFWUoxVVA3VXVs?=
 =?utf-8?B?eHlNSk1VTkxzcjZoTzJCV0t5QjZJeXJjWXF1bXNDNHRXdkI3YWhuK2J2Sldo?=
 =?utf-8?B?SS81eFF5MGp4Ni9lUGVDVklKV0dDSlhzb2RWVlRvT3FGM0YxNHM4K2tzaXRy?=
 =?utf-8?B?UTY1akxxaGJmTS9JRjRJQWlBMnJsa1hnUWlZUnF0aVk3VG9wL1ZhVkJRb29u?=
 =?utf-8?B?T2dhdUE4ZGVJYk5SWUYwb2Foam8xVlBmcXZENk9iNzRBQThnRDh6MWllRGJU?=
 =?utf-8?B?dytsaEdjRERCeHVSdTlRTlFSN1kzRjZrVkNoMUVoTy9OYXFVNTZ1WGxtR1pq?=
 =?utf-8?B?d3hWbXV1SjFRdjJrbVd3QzhhdUN3ZGRpOTA5QStpcERwbG9KdDZDQVRaRjZP?=
 =?utf-8?B?ZHNPVTI0TDFqL1ovYmpzQXZnc29VOHl0VDRGcy9LSUJlZ2MvN2huaGwvOHNH?=
 =?utf-8?B?MGRzZGVvVjllTG1yOUxrL0t4eDJ4K0ZUR1dIS3VJYnFJOHJ3WEJ4S1o3alZO?=
 =?utf-8?B?WHBOMUhiU1JPUmJtWmtJQkQ5UTZhVEZrQkpPcmNHTisrc3M2MU03cE5PNnFZ?=
 =?utf-8?B?dkJMd0VSL29jd05KUEhRa0plZXVYZUZMZjdhUkRrUllpdXh6dVNYYXhYY1pX?=
 =?utf-8?B?SjJXbXFCOEJtWFBBTFFFMWx5TTNzb3hZT1dYdENRV1BaT0UrSS9WeWM1UXVo?=
 =?utf-8?B?cXYrN0paQ1UrTU9tMUdWRURXZzVQS3BnaldmdTlnMDN5STNXbFhVcndmUXl1?=
 =?utf-8?B?N213ZTdnWnlHaFpnR2MxWnVVSmx6OUR4TDQwQ3phRWx6UmdZdURuWUNBUXY0?=
 =?utf-8?B?ZXVSNjhkeld4TGpSRzl0ZnViNzg5TTZQdmNobWIrTFY5UWhYT0wwcEVOdWV3?=
 =?utf-8?B?Nk03VWF4RXBJVG5DaW8zbnFQWHp2LzE5Q1NoT2pYOHNDeUFzakJobDlWYk1a?=
 =?utf-8?B?cENDNXpFMzlVeXdGOFVteU1sYStXUG1WMHJBK0VXVWYwdS9jeXRtdldTVS9F?=
 =?utf-8?B?N2lTOW9UTngrMFdvekQwR3hkaFN0MFE0a0JkZ2Zac21MWmJVS3VqWk9VR2dv?=
 =?utf-8?B?UmE2ZFc5NmdnWTgrbTlHN2pWZDBLOGVKLzNRVFRKNDAybWpPdkxockZOdWRV?=
 =?utf-8?B?ZjNwOENsRTdwbGZ6S21Nd0k3WHJxZjNiMENsbVBCZjYvdUtWVHpManBLNEw2?=
 =?utf-8?B?dVdzbDYxQmlXMjc4eDlMdTY3RituQzBHNEwra24vMzVJakwraDBHU0ZZRTQ1?=
 =?utf-8?B?U0tqRitMZHg1UXVRM1MzcUZqeCtyenNTeHpzNlRQTU55aG9SSWQ0SEFocDBS?=
 =?utf-8?B?Q01uUHRGdEl0N0FQSXIvN0Mzc2NVbjJFY2xWL1ZvQ3lPOFUrVzBCVmNsbWds?=
 =?utf-8?Q?muICWBHVhiB1Et9Bv/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0389df3-f5ab-48ad-5a84-08df0cd826e4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 12:04:21.6023 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u5/a7Anw4QS3R7cTSqA7UguEC58Bgxa+4wFPvYi9Gei9atYm19AKauIuJ9XxX9Su
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999098
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

On 9/5/26 04:31, oushinnyo wrote:
> amdgpu_vm_clear_freed() removes a mapping from vm->freed before
> clearing its page table entries. If amdgpu_vm_update_range() fails,
> the mapping is currently freed even though the PTE update might not
> have completed.
>
> This is particularly problematic with CPU VM updates. Waiting for an
> earlier submission is interruptible, so a signal can abort the wait
> before any PTE is cleared. The old mapping then exists neither in the
> VA tree nor on the freed list, allowing a later VM update to reuse the
> virtual address while an earlier submission still references it.

That would be indeed problematic, where exactly do you see that? Do you have a test case for this?
> Put the mapping back on vm->freed on every update error. This keeps the
> pending clear operation alive and makes later VM updates retry it before
> installing new PTEs. It also covers partial CPU or SDMA updates
> conservatively.

Clear NAK to that approach.

Freed up areas of the page tables must be cleared when that function is called or otherwise we run into tons of problems reverting previous changes to the housekeeping structures.

The only valid reason this function can fail is because the device is hot removed and in that case it doesn't matter any more what we do here.

Regards,
Christian.

> 
> Fixes: b4d42511b7f2 ("drm/amdgpu: Support page table update via CPU")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: oushinnyo <oushinnyo@163.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 47cde5459469..e20905d2d90c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1606,11 +1606,12 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>                 r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
>                                            &sync, mapping->start, mapping->last,
>                                            0, 0, 0, NULL, NULL, &f);
> -               amdgpu_vm_free_mapping(adev, vm, mapping, f);
>                 if (r) {
> +                       list_add(&mapping->list, &vm->freed);
>                         dma_fence_put(f);
>                         goto error_free;
>                 }
> +               amdgpu_vm_free_mapping(adev, vm, mapping, f);
>         }
> 
>         if (fence && f) {
> --
> 2.25.1
> 

