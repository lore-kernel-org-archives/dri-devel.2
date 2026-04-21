Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2920EF327A8
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 06:20:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 857CD10E189;
	Tue, 21 Apr 2026 06:20:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WtqCOW7b";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011070.outbound.protection.outlook.com [52.101.57.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D509210E189;
 Tue, 21 Apr 2026 06:20:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O7j0Vb5ZlV/tmeUBwuGaOOKnpS6xGzZSOjf2rDCPuaeYep/il2UHfECUvNmBPb9/V9YbeEsBXM/biXQhK5THUaD/tbtmLvbB1FMJZdLwF7WkXfZCL6BcGoS72zldkt6HS0sgym68VYXQpv3eezkwIFWqDW7KFf2I3JAqinVEndrtuuxtFh4V9VtY8G1v+FhyCu1wf1ZmucuV50ENCTd7ga8filoM9yzDXd9xDtiHw/OJcQhQKkMDVLkvSsR4y/MKX3fgVOOeUYN+gOtkNUaqpAcfSVDYHuokocWb9aixNdBN5DUpQ42Us9H+CAiJbbLr/O6YNSZHPQfT2OgsEjenag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tYzT7rQQUoUSViwMUZQYUcGWRgkVcWgu+WVih7MpJZs=;
 b=RdxlcrHNJi5k8X0TtAfNRVEf/35MywKvLMTrSmw5azf2+S3Lyt4LRj0gB5SzIqpExlhSJw5iZ63uRv2kA/AKOqmh6UHYphLNNMXBHb7UklUHlP/2AhDDP3mg3vlgc8vVDiUKbJoO5LC4dUx4J0vGFWhbkdubVnt0naAC/Pqx80rlBixKq1PPRJHlz2Xebjaq0Ixzz0L5h05Y/4rwwpLe/ILAou5V4VB9SnaZgSxT6cVDp69Fz3877mfOlTvZoJN4qqJtRfmnaCzQa03+psgfqY+QZR9EU+ePMAh566EKkFoWLkVK0Z0Ct5lL5siyaYtNO1VTYzaSsN/2UkT/PHRWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tYzT7rQQUoUSViwMUZQYUcGWRgkVcWgu+WVih7MpJZs=;
 b=WtqCOW7bLN9/0JqmIfSXJDImaW2vW3620FmfAay4iNX0dBTpM958qbjXsIOiu6ilYlT3HsCzqc8+XeoXGyDSHxergP7ynL+x7oRDXFFgj1kxrxCU0hg2dIMUj7EiYuAEalJSXuEjAbm0cHdZoyuvbhKu+m5yEXvIaQOH+LAPVlY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 06:20:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 06:20:01 +0000
Message-ID: <3d19f4c4-5173-4879-b2ee-7bdfb8aeee53@amd.com>
Date: Tue, 21 Apr 2026 08:19:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/POC PATCH 01/12] drm/amdgpu: add SVM UAPI definitions
To: Matthew Brost <matthew.brost@intel.com>
Cc: "Huang, Honglei1" <honghuan@amd.com>, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Oak.Zeng@amd.com, Jenny-Jing.Liu@amd.com,
 Philip.Yang@amd.com, Xiaogang.Chen@amd.com, Ray.Huang@amd.com,
 Lingshan.Zhu@amd.com, Junhua.Shen@amd.com, rodrigo.vivi@intel.com,
 thomas.hellstrom@linux.intel.com, dakr@kernel.org, aliceryhl@google.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260420120739.1811731-1-honglei1.huang@amd.com>
 <20260420120739.1811731-2-honglei1.huang@amd.com>
 <cda09d5d-4cca-46a1-8625-fe9fa687e5a2@amd.com>
 <50d13ae3-be27-4b79-91ef-e1b386054943@amd.com>
 <54bb7286-2ffb-47f0-b37d-83b5c39ad9a0@amd.com>
 <aeZPBoJVTqOKd4bq@gsse-cloud1.jf.intel.com>
 <e494689d-f126-4be8-8337-f04be1abd12a@amd.com>
 <aecGNdso+EB/Aip5@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <aecGNdso+EB/Aip5@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f717c4-520e-477c-1d90-08de9f6e04fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: yrYiSVcqJRIHIFjA/eBF/Guwb1gSWMEIaejVI0H3KJh5kIPqN/kg1Cfbjf2nVqwk6Uy+We/0lTujFHhqrlAX4lTXc1hMmkmo05U2qj9AMxV0vz58pI9Xvuq5vK2bXCY0B8lPmgZnsm64QfjoeJUZB+TuaROTSkjESZJMVDgOXNNfVy2zYQZivVTgl7Cm4AKMm+T6TH4TRvCRFzrEcRUcjBMTgVRSiTFnlNGdIcMoOXW7POb+HrJTetXpNYvQZ3+dbGgB3tU8JbJ+CDv++ryZo8zltKR7yCvrItoDFypU3Ccqp9jsFjUXrChCSqU8X9+ZR7YGGjVYKxuvxaPmvHZmD2Are2+Rg4RI5ClYI2tpoiFcDaLfu2A5SHmwRTUUcytx4vueaQ6sBL8DDQQivCrMBZAugIG+Oz4apDeoWqjKto1MxwBm/MpKxwae8FJBzNIFbLoh9YWs1HZu3AguPmSx9KDY+AdrkyfHHPSvAIrdbBdrIev0SLyiXYNQzWdwhOygQg3NIo935YfKkXO5akzv3DCMpGU6E/+HcpInmciZWMnF4U3T4MzA8nwzkqnfpWD1ML9eIEA9KGBls4vORAfGSVEsN2RUR/ohLFomBFWBmsDfxSZPkJ/6IwhJVFuLWA4Z9Ka4WCTduxBF2gwcXU8VuEgCppSmYyo6UFG3uly5W6fq3spPbSenQ4PWAjAUJSQsULVSLy5JxVxDBvxNBihUWQDXQ/OP3ltpg0WOt1yKemM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGMraEJqaHlvSEJvL3FHQ25kNU9icEs2QTlZSE9mdWhBVkRRUjJNSDNueEZu?=
 =?utf-8?B?R3lmZHBrUVI0TWFjZ1pXMHArbWFOWmxpL0ZiMkMvRnJxbC9ZdEd1cXhwRTV4?=
 =?utf-8?B?cVQzbmF4Z0cvTW44QzQ3aVE1OE9PaWRvbkZDMkwxeWNMVzNIektMblBzd0M0?=
 =?utf-8?B?ZnRPdUJpZG5mczFldVh3VVFCa3I3SjlKVitBLzRKbWYrMnVmTzhsRXVnOG0z?=
 =?utf-8?B?aDYxNzd6QkpWbjFOM0EydXltci9mbTJuOG9DT1UvZTViZ1Y0dUJ4elZyMG1p?=
 =?utf-8?B?TU5VTm1GYVFhTWpzTTQxMkJlbmpVaEpCK1EvMndoS29mUUVTc3NXWmJRaGc2?=
 =?utf-8?B?UGVuU2VtYXlJWHZVNUNVYUVQdUNRMXRiU3JZaGUvd0tUWUFTOEEwSXNFRWFG?=
 =?utf-8?B?UlN2Yjc5b0ZkekMvUUlPZkhJR3MzZ3Jyd1BFckRkSnZMMlZTVnBiZnBVRnZh?=
 =?utf-8?B?YmxqLytPWVUxY1Z1UnhOSWlKYzVkSkJKZG04b3BFMDhaUkVpaUZWemliSE1Y?=
 =?utf-8?B?bnh1USs4M0owRkVCakpiY25oMFVVSTRocDdId1M0YS9aSFlqVDBQazVyNnZz?=
 =?utf-8?B?RmdGTS93S3BNY3RpUGZyZXVKT2JnSWJxY3k5TUp5aEREakVzdVY0SFBUMXhm?=
 =?utf-8?B?MzEyRWVLQVF3N1BNMWFUZ3VzTnBQL1JVNEQ2WmtVU0w5dTcrUDFpa0tiSTNr?=
 =?utf-8?B?a2xYdTV6bVZrZ25UT0lSMllKV1NlSWRXVVZTZnlUVG80WEJNbitCd3BwMWt4?=
 =?utf-8?B?eXlWOGljSVJvRVE4NTFOSUROR2dSODBSaGpmaEllUXo3RFc4VG15cGViQmtQ?=
 =?utf-8?B?TlBiR1pnUW84QXhTTDZxbUFMOHF4V1V2WFRLN0UvL0V6UUd2emxWWjY2V3Bj?=
 =?utf-8?B?enJybDN4c2pPVkRvUk5Hd0dEMDA1eEFJQXVaaGdlOGdZOEFYL21ESFJDb1Ra?=
 =?utf-8?B?Y2pVZUZsMFcrbmd3bzR5Nk53b0lMbUxQQVlqM2pWSE9nVHVGMElzaW52QUFZ?=
 =?utf-8?B?ZWllc0xJWk8vR21oWHFYRFpVTmRUV2p0NHFXQTFxN2hObzFTWXZLQ21YcDZM?=
 =?utf-8?B?aG41VUsreWpSSWFkM1pCT3VheTdUdm5VSFhxVmdpQ252T2ZsUkxVOXRhRkQ5?=
 =?utf-8?B?cEx2ZFk5MC83MktXL2I4ZjhnZnlEeGtocGxJTmU5ZVJOcEhSYUpmTk9YbTd5?=
 =?utf-8?B?R0N5ZXNLMGVHamRjRmg4YldvaFlaT3kwRjRja1lQb3lkSHY2ODB3a0FMdmtp?=
 =?utf-8?B?aExZeHFVRnNEOUJHaER2dnlTMkF4d1E2ZjFEejRvQXlSbS9yMkRvN3JsbElH?=
 =?utf-8?B?Z3V4cjVNWUJsNmx5SE1sSjFnL2M2Uno0bWl5aEhTUFJmZGZ2UU9qRWVJVmFq?=
 =?utf-8?B?RE94cVI4UVVNWlYvZ0lvdW1hSzI2ZEpzTVBGZjU1b25OS0plcnVWcWdmUldY?=
 =?utf-8?B?WXBMTGc4YmdWRWkvbmMzcDljMTQ4R0pOdHBpVHQ2dXR4NTFjdFhVekJtdmp4?=
 =?utf-8?B?NFRjeHhTWDNJc0lZN0V3RDZVUGNLeWJQcjd2dFJ2bGVGT0orZEZmU1BWV2FY?=
 =?utf-8?B?THpGU1I0ckRabldPSU0vTGdNQXN1RkNPbk94M0NXMENmMGJuSUpCK0lUUXJr?=
 =?utf-8?B?bzFsVWkrZGZTTUlpNW80T3llU3Z4RUlTZWFuSWR6VXNNWkhuNzM1OGlwdThz?=
 =?utf-8?B?Rzl1clprRTVaMlpOMzA3NG5OaC9lNzQ0WHNGU2lDTHZNV3AwYXRTQkwwRDRV?=
 =?utf-8?B?Z0xLVk1QaTZib2dwRHlKV2lyU1ZERnpwelRnMEwzVUErY2RiS2t6QUNtT1Nz?=
 =?utf-8?B?dEVSODROaFFaZHpmN0s1TEZWcUxBSkd6NHNJMk96TjRzMDNkb1VYTmJWanF6?=
 =?utf-8?B?RzNDSEFtT1pjTGVBa3lkb2ZjQUN4Z0w1R0hZR0NCeHc0eElJYVV2M3VINUpL?=
 =?utf-8?B?WEp4RHNwV3YrVTV2aENqTkh1bmNvTVFnakJJTGN1M25ML1A0L2M5UnNnaDVI?=
 =?utf-8?B?c0lYbmx0ZXhyS052dTNQc0QycXNYeVJDbGs2Nkp6VjRHa3hBMFZKc1FGdFFy?=
 =?utf-8?B?MjF3eEJqeU54ckNtTXlHQmZleFV1aUk4WVVKQ2toeGNsblhtd29meUZoS2pF?=
 =?utf-8?B?RXJ0b2ozQWljcTVCbkZ3ZzZwT1lPYUQyUXIxYkdrZDNrNTJRUUFEMjlNMWRw?=
 =?utf-8?B?TXowNm9EenJTbXBLcXlVanh2TWVmK2VmRUNmcnF6MDBDTEc4bUdza0tYU2t1?=
 =?utf-8?B?Z1BjWnhBcjYvMFBFUUxZMTd2NXNEcWJqQVQwUWttcHdsN21kaWg2WFhZRyt6?=
 =?utf-8?Q?a2BjpstS0qegRXE7sa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f717c4-520e-477c-1d90-08de9f6e04fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 06:20:01.4620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXFNnbVMVufe6MRsgNDuuij/5qNJYapGB/JFypInPHhTUQFkHJM4pXamGU/Zg4or
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
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

On 4/21/26 07:08, Matthew Brost wrote:
> On Mon, Apr 20, 2026 at 08:07:38PM +0200, Christian König wrote:
>> On 4/20/26 18:06, Matthew Brost wrote:
>>> On Mon, Apr 20, 2026 at 05:37:43PM +0200, Christian König wrote:
>>>> On 4/20/26 15:30, Huang, Honglei1 wrote:
>>>>> On 4/20/2026 8:15 PM, Christian König wrote:
...
>> Either you set the information per-device and then each device only gets the information if it needs to migrate the page to it's own local memory or you have global information.
>>
>> So why does a device fd needs to know about remote pgmap?
>>
> 
> Simplest example:
> 
> Devices A and B. The user sets the preferred placement to Device A.
> Device B faults first, and Device B moves memory to Device A via remote
> pull and can access locally via P2P, scale-up, etc. Avoid a double
> bounce once Device A faults.

So you basically tell the device as soon as you want to access this VA please push the underlying memory away to a different device?

I didn't thought that would be a valid use case. As far as I can see the only thing you avoid is updating your page tables on the faulting device twice.

Thanks for the explanation, that was absolutely not obvious. Going to discuss that with the team on the next meeting.

Christian.

> 
> Matt
