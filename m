Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF0E606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oWkkhing
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E103D10E1A0;
	Thu, 22 Oct 2026 12:26:47 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA48510E1A0
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCyrJwn9xZPVbY3BhKOV4zbHZfogu86Kq6sOnf9RTvco1DYYy7ypftOIffE187VG9DZZfWTObj2xYubb2UVjhoswQ5lwiucTww+K53D5vTYaRZ7B0oES4NOgKZ+JjJIysDEsRXr73/F5Za6H87Anbz5s/kLkowzG8Em2CRhd/C4r2oDYFTGD8eZP1DZBH06ZtRl0ArfZOmnymHglvHFv2uJBi/65Kkv8LsxR+8pEOeiv7a0mdZDdQbvtxku2DuJ5alEDID9kZYEqB97mqHgD9+F4csm8pqcz+BuKSf+MNBbbQ/bDrxSkKKdxhPeZHgwXyFSp6RHNaks1wSgALhWH0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOefd6k+NFCbfCkfEo1k7OaGQiDwLvUPzLygZtT/7cs=;
 b=W79sAQm2b0Ki0ojQnb6nV4iyiPY1cSNkUROS+bFb9ZnkgQ7Srn+1pMzJ0JKiQBH7xFusoVbjMc7CEslLT28o1gVhHfQc8si/AH/sacN6Spmc/LsgIvltQvixK+FpsYOMCpfEKrNt3fmQ//dT15zVVCOAdJEOpTzhvPDwY/t2+O7Xf6DrINWeHkKXX6V8AW5/02Hg+XtD3PEl6wn7g5M9KHtHE8CH2luMb+yiwjc2S/zHHHWgIe0xJiVHPgawKNCkq1WoWSq++sTnN1LAuJMBnUZOIJktjM6R+5VCLw/TunZXZvy5AHxJHf8pcJkVt0wRdLCxVByKt7hTDuYFJRL0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOefd6k+NFCbfCkfEo1k7OaGQiDwLvUPzLygZtT/7cs=;
 b=oWkkhingT8ySPltDZP1mj6RbcJk2FDzw+VOjeJzA9vllTinr6KSx/mUyoW7gkn03WSFepCmKT5rAMl08jjl+NXbi9p1nE0wE0K8tReDGvpBF4tC8OLwLj76+v9DoKdrQuWofgl8l/3EUdkvexaWrPI2SEjcP45qj+rJ8UErRZjs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV2PR12MB332773.namprd12.prod.outlook.com (2603:10b6:408:3b4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 12:26:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 12:26:38 +0000
Message-ID: <bcb4f2fd-dec9-4d2f-869e-a1578843ab84@amd.com>
Date: Thu, 22 Oct 2026 14:26:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf: Add DMA_BUF_IOCTL_SET_RELEASE_EVENTFD
To: Val Packett <val@invisiblethingslab.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Philipp Stanner <phasta@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20261021093533.1990028-1-val@invisiblethingslab.com>
 <6e45ae81-0319-4857-a96e-159509c1b140@amd.com>
 <a1057af1-2390-41c0-ac57-4ab9ef0fe31d@invisiblethingslab.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <a1057af1-2390-41c0-ac57-4ab9ef0fe31d@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:408:142::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV2PR12MB332773:EE_
X-MS-Office365-Filtering-Correlation-Id: c7376ce5-ab9d-4478-ee3f-08df3037b7e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /bOFNHgbC7iJH5Um5N8oNN/+JLJIUnM7+CmH7C68EDn34OgtN0LmSLRcjeefMoVZZJdMPjVC2E64gBzILgNGlogfihJmo0F33oRHF/giixPzbbqA2uVNUXJismFFy3XkJ/jDglgxKy73syaw2+bjKVSojfxDUixDUg4oSUCGSphbvz7yewGlKzqrJuJPJqzZJRl18jDDMVqYz2zreh6Qll16he921g5+pX/4ti3lalUetioYidcaOXYisb8a26/A/orohD03Z1fxEyYV3QKo/fRfEzceKJWzv1+nn6FacH0maLwMBMzbvyilEqCO0SXk3mMcnUQq9EiJ4l9zbbgiPZwiEvZhcShm3vlM+dTyD04XBC1JfE17tOlif3z0cN9ydFMOEV/99MLACuqBdKks0YcFHecObI9bkhUKC0AdbNRoYupD4U3rPSHF9TT3Q2cRpNRCgY0Us6AH0YlPX5PTnO+3icYdgLNDlt3XFQbu5B63Z3lr6otF4DfxGpR42RW7VydHbJWCC9vJvXG5FGm7gx9GEHqTalLYiFYow6KjDCAPuSdgVcj1/rX/hvWQY8WSmJ6/bm6Wgx3m/LbuEjwygmOojhAloQMxqtdvnUGQ4jkjSdrdlMX6nxHvplrxwV1ShgdxTc+wcmQwj76bWDLWKL05KZzk+xh0bVo/laKs0Zs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(261021121427099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWRFbnc1R0JuSXl2SlFHWXF4N2pRSEczMGNDd1RQaTRaWStkNlFhZ2ZCcHIv?=
 =?utf-8?B?UXNFaHlzdEtKUE11UExwUnBSVENPMlNOc0JXYzFyQ3owUS9sdUQyWW5WaHBS?=
 =?utf-8?B?T0xuL0ZoeWV5d0ttK0RaRTRmZmU5WGJFVGZZM3BlNXpvdHVGYWxBd3Z6RHQy?=
 =?utf-8?B?VVRtR2psMHVTb2puWFg4TmF6TGhpOGs2WnlWckMrenpheGFsMjV1SXpmVytk?=
 =?utf-8?B?cFdQbHIrRWRIbGZLRXZVbDl4RjNiYlpKdFJuSDJyNUFnelRDOGIxS1d0Vmk5?=
 =?utf-8?B?aWoydGxVaEtwSlVUVUlmNklNbU90azAwUTBFL2ZvRGtLRnhvaTZGdG5CYy80?=
 =?utf-8?B?OWVsay9adjB3a2NsUUJKZ09ZRGNxTEkvN29ybFRXSkZCR29hK2RFeWwvSk9i?=
 =?utf-8?B?VERJSmVFMVIyT3NBRGRwVHMxRVFER1ZWb2dOTzFhWHV4clEreENORXVvV0pM?=
 =?utf-8?B?NnllQlY5YVFCOHkvUE9xc1Q4UVQ1TXBOWWZ2VFQrUUlaK1hhb0hkRXpHZW5u?=
 =?utf-8?B?VFZtSTk2SXF4aHBqOEozMkErd3pjYkU3c1pUbzZuYUdvTEJiRjYwQzlhS0Ja?=
 =?utf-8?B?WDZNdGlhMXVKYWUyN0tweGJ0b0pPa2xIYlFEQkg0a0VQK2RCL3pCWGhXYzNE?=
 =?utf-8?B?TUdULys5RU5BdEJuT0s5ckNXVUgxc2RtYUU3STdsL0J6dy9QTXNqcjRsbkhw?=
 =?utf-8?B?elkyaGpnUEtRLzQ1c3JvLzNIZWg0ai82ZTdEUXUxQWtYYmE0UDBwbnorNGht?=
 =?utf-8?B?WHk4SWdlTkJZbVUrV0VNMTRJYVVvdlJWVktWeEpmQ3BDVFVad3BsN0l6Um16?=
 =?utf-8?B?WUpocS9UTmd0QlVMeml6UTVNRzZQY0E3eW91MTFvRXIvU2ZOamp5KzhHMTBY?=
 =?utf-8?B?dU9ybEwwbzBXQVN1Vmh1SklRWHFZb2srcGw0clQ1YmRKdkRMb3FPcWpoTEVr?=
 =?utf-8?B?MEtZUE01bmFyTFcwRjhhaVFlWHIwMlluZGRxRmhxcWo2SnRFOVlNdnZocStI?=
 =?utf-8?B?Z3g3ZWVEUDFMUlV1U3pUTnFvbVhIdVhOc3Niem9sQWxiMU4vbHg4eHlKY24x?=
 =?utf-8?B?a3Z6YVdkZTZNbW1Kam1rMUN5VFJpa3hOREFLVVZvMFo4djVUcnJNV2Z0SURY?=
 =?utf-8?B?T203MWRvWnhyLzEvNVJOeEVtdjVwSC9NOGVET1JFKzZ6RXY3VmJQUmFvVVVG?=
 =?utf-8?B?bFQ3ejBYK0s3TEo5Ukg4bmdiYWdJYzJHZkxqd3J0amxQK3R2ZnlyTnVXTi9O?=
 =?utf-8?B?cnlzSUFlRzIycVNudVExZTFJK0Z6cmNLRS9CWngzcTNEdStNWkJSSFNGcHF1?=
 =?utf-8?B?cUhBSzR0LzNrYWJycTRtZnYwU0orUlV4NjZKaWRjUUxzVXZSYUR6S2NhUTdQ?=
 =?utf-8?B?bTVCN3M0aDliM0RmK0NZNHJtM1pTLzlRQUNoMnlYaWo0ZWFoK2RMWWR2U2Zt?=
 =?utf-8?B?bzcrcUI3bXNFR3RycG5SUTk1U2ZjelB6NWMwbGRkclE5SVVDcXg3K3J0UW5R?=
 =?utf-8?B?T0NrM296Mjdmd3ZBNm05dTNyK29hY2o1RXk3U2NQZGN1SFFRM3lSd2xZdVVD?=
 =?utf-8?B?dnFkdGxaZzRCRWFKMERpUW51ZGxIcGVNeDBmWUJCMzNtbGtBaWJGUGFEZmQx?=
 =?utf-8?B?NnRWSjM3UE4xTjV2L3ltRWNjMmFaODl2aUJGVWRsL1pDbFg3RTYxQkRmK01i?=
 =?utf-8?B?RWlyWmJBMmRiU09NUTl0Tndudm9jVHpmaDVVeEx1aDBva1lvbUdPWDJLRHNM?=
 =?utf-8?B?R01lR0U4RURmQzlNcU1jdElDenJ5Q0cyRHN2SFc4N3VDUTVQamNOREVSUXA3?=
 =?utf-8?B?WnVpaUg2R2xOYzNSNm5RUjN2eW04T1FCb3JoVTQzbzdEc0UwWE9meDUrcGtF?=
 =?utf-8?B?enN2N1Z5bGNUZjlsWnpUaFhlVHRleXFIaEcvMjIyRldpMHd5QnNxWlIzNm1n?=
 =?utf-8?B?d2lSdDl3STV0TExKSjN1a1Z2VnUzVWhFMnBBMTFlVUtJWVpMLzMxMW9vUW5B?=
 =?utf-8?B?SjU1ZFUrOUpkMDBsNTNWckRTamRXd2tzcFRGNjZXTlY2UTUrakp2YTZhajVa?=
 =?utf-8?B?bnc2d1lGYXRmdVJFQnE5M3NOUjRZeDBZc0lwRkpGbUZjTXgxMVZSN2ZHUXp5?=
 =?utf-8?B?M1Y0NDgxelBYczJpZEdFdnZqbzZYSHpVcHIzV3NHdXpDWTRUT085VE9mOHov?=
 =?utf-8?B?Z3FSbEo3SHRsU09aeU0ycTFZSStaSUs1MXBHc1JuSFhrQ245VXpjVnV6NmMv?=
 =?utf-8?B?RlB6eWVON3IwTGhCNDJVS1R1b1RSUlpyTVJGUmkxNnZyaHhUSDJQYUI0eVBu?=
 =?utf-8?Q?nKuaGYj/r5jzZsAgUF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7376ce5-ab9d-4478-ee3f-08df3037b7e7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 12:26:37.9700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsn8brhv/zbhh1IzzmziwOw6Arxdebij8BosNbrQ0hbe2ip5kp0LaxKQFKvyD9QB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB332773
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/21/26 22:16, Val Packett wrote:
> 
> On 10/21/26 10:43 AM, Christian König wrote:
>> [..]
>>> The buffer lifecycle coordination we need this for applies to KVM as well
>>> and it generally doesn't make sense to have this as a provider-specific
>>> thing since it's not related to the provider in any way, it's just
>>> something we want from dmabufs in general.
>> I wouldn't put that on the DMA-buf file descriptor where basically anybody can mess with it. That is just an recipe for trouble.
>>
>> The better approach seems to be putting it into the udmabuf_ioctl(), so that from the very beginning you add the eventfd which signals when the udmabuf is released.
>>
>> If we need that for more implementations than just udmabuf, we can potentially add it to dma_buf_export_info so that exporters can provide the eventfd file descriptor directly on creation.
> 
> Well, we already need it with both udmabuf and gntdev-dmabuf..
> 
> Involving the exporter sounds really annoying when it's not something exporter dependent really.. What if the policy is just "only one eventfd ever" i.e. the first call of the ioctl succeeds but later calls on the same dmabuf return an error?

No, exactly that is what I'm trying to avoid.

Nobody except the original creater should be able to insert an eventfd here.

Regards,
Christian.

> That should remove the concern about one user messing with another's events (and avoid the concurrent replacement issue sashiko-bot warned about)..
> 
> Thanks,
> ~val
> 

