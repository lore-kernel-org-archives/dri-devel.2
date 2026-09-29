Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98486CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D7E10EEBF;
	Tue, 29 Sep 2026 13:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oC5mJiXY";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E1910EEBF
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szTQlvEWRt9zkUUAangwu6pKag+UgAnhcHGctRzVvB+WLcrMVH8bg8ptiefux9S+yrJwHn2u9KlxXX51qXCT6xUk6mllQinXQXUm0dOz9O2NzoM/YbafGVcqQAQxwUTyGtaCoqsZOi7pUNwdYdKz4qIVLXWSYEShnsR3ysiP3HN6y87Wqk7SXmwLLafUjz81EI5Hp4uvMFPjwVgM9h76UdYwRaySWmzeo8UjbAS9VAafVRWFp79slpWHeYkZJom/OHFSbCLfQxCDHT2JshlxQKeIJnUdSN7eUyKG0L+QZ0e2XO8/84G5jvEI25iLw8GxbcjrdI6qYWB3ENyXTWPw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7phmc2Ras8wYtNuA2aGaXoRhmLXYMT28um5iz9vep0Y=;
 b=FTHKzbsiBPh1VAxappde7SB2oRCBpJg21UMfIcNv48ZTEcCDAVe0sIBUXsqeeujOQUdwH68lXYa8hZLPouqQaDNUnDLH2PAxUl8UsLoI8Gzq7qATdNhu2DDIkr86fSLKV9GAn8Lc6K4RNMBLsvxNv3ItmONilVTe6m12biFostMpYB5FeqTbaU9SRHVz9qYpWNDBCoGJ6CkTcEPAkR/SBn5owchCvlWvbbEu95rKlmPSpsoorCyfNkvUlg4PRfuwggR55ckWTUb1EFj0lULrqhw32VWnI+Xq0xheHeJalXkl2h6YPQOTFijGIdzpEhg701Ml9aYGPXWPL986lfArZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7phmc2Ras8wYtNuA2aGaXoRhmLXYMT28um5iz9vep0Y=;
 b=oC5mJiXY17wh9wnsmYi2HsoB0qM6gqnrg39wBgFWa8jljGg/LUtM+gllMfWioaoG6W0gLMU3Z469ooEVfKZWiBjaWGgM2VGujPPQiKs3+HKK74/Nl0+L5l8MaHc7G/gBNzWxm8YY7WWDcH6ZO6FJtwTsuRYeqgiOgNAEHn1tC5o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB432622.namprd12.prod.outlook.com (2603:10b6:8:70b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 13:32:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 13:32:13 +0000
Message-ID: <3f00c8e4-b52d-4b8f-9eb1-30c05b02eb30@amd.com>
Date: Tue, 29 Sep 2026 15:32:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-buf/dma-fence: Mark two callbacks as deprecated
To: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260923150308.1294592-2-phasta@kernel.org>
 <3983b2de-b6ee-4674-be22-9ecb2525a055@amd.com>
 <469d5deb2ef644b5d77d21bc2d700443f00c0b4d.camel@mailbox.org>
 <c400f12a-04db-45eb-853b-629f19e3060e@amd.com>
 <a4655e4ab7a2477b75351a0e83b98e0cb0396fdb.camel@mailbox.org>
 <c7d9c659-d903-456f-87f2-d75aafb8de3b@amd.com>
 <7b8942e29f6c714979415a59b42af450afa101e4.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7b8942e29f6c714979415a59b42af450afa101e4.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB432622:EE_
X-MS-Office365-Filtering-Correlation-Id: d51b86d2-2ab2-439f-3da1-08df1e2e1205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 9iLSe4as7lZ2YRQIC1/Xj8vm2tLptMzTBspSW5iYXupeBZBxw0GJGIm03qG70S1lhQPvD/0TyMLQIPblCPo/7avc3IZYh2eHUDvdHKSMd0UH9QBBtETNuqFk+p6HzrsbTsmfSdnuyWhXzOFibgpwKo5urRpezRa4TGlkSuwK7G8Ybz5QnF7ijeSWmFwo0otYsdo+E7jFGy9oRUGBZ4feyiw1whkFS5MaQL2MJ8VpJor2yt4cXOo5656xJRwaIIHx+3BR8vQJ5oIVqEZC5fvPf1qPdZbCM9XQnNNPtKfTJRtFHr9L+DwyREYtfkRYMV3tA7lD6TE2lyu6OxralFiATPC/IouZSfmUfOJptH9eqd3D1jIxtJDNxA3gfoiEvNHllel0IfQMl8tzOsIfikq1/qXdeDzcU3HhaCbstMQs7mCAAY123JZZAuuMc3/90i5w1N6PFQwY1xUEH80aolQFkOlrVH54u7pKNOrQoqs9nN5fZhZijbclrSTt34nPCG2VhsBME9QVZsQoOOgl7Kfbp61F+QrnOcu35NLtYWWlr/at6+4QZ7eYUKNh7DnJ4+hr9XFYF82gGA3zQjk2TZAnH2H2DX3IYYPlgq9xuo72+fv31ysa1XWaMx1Qw0GvdtUyZ7FTUbdNo5VV7fRGof7YWJHcwNU0Kad7Xif067D/108=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEEyWDRKK3g4SEppUnNKVmx2WnhocWUwOVIyeWxKbFkxSUxvRXBHUTN5djFQ?=
 =?utf-8?B?MVUyMFBya1cxMS9zYTM1dkRabWY1b21RVU9aYmsvendHOGIrR2Q5Vm50QXZL?=
 =?utf-8?B?THBBZUFabnJVdkZDeWlUb1hDVmRBcGx1SUVMSE9jZWN0UXhsZGd3alJiMEwy?=
 =?utf-8?B?K3pGa3l1amZVTFF2Wm83L0J6b2t4d2w2dm11V1E4TUEzbmNwekxLS1Y1cGFm?=
 =?utf-8?B?UlRmNzI3UC9OZ0pnVHJIVzhlRlZ3UllvTkVuc08zcmNvVktOV3F4cHRDdTFG?=
 =?utf-8?B?V3RMMEFRR2VnbC9XVmZhVWtoMVdaZS82SVpQNmlQRHV5eVZZMU5SWXJESVd3?=
 =?utf-8?B?UWwvRUJGV2hqTDlXbWRtNi9aTlZ0L0VXcnlSY01OQmRPL1VhUTkxZ1FzTUI4?=
 =?utf-8?B?Q1F4THU3U1VTVTczc1pPVkFqUWRkSFUxc0pHanBCZ1pWRW9sQ3FuTk5nZEVE?=
 =?utf-8?B?cHRQV1ZteFJPeDVXamFCNW96Smc4ZFVoaTVRWnhKVUdrQkpxa3FIVEhZV092?=
 =?utf-8?B?Y0VWcXRvbWQxaG1EM21lOTZ0Y0JUaGZyTGNVak5iNWttY0VRMVF3VzY3UHI1?=
 =?utf-8?B?Wm1FbGdlZ1ZEVlRPZHRwbU1jdnErUGYvRXh3b2ZUV01pZUVuWXpUYzVmc0xF?=
 =?utf-8?B?TzcrVWpYMU9naG94WmhUcVJqdXJTWU1aTWhlMzYySDhocVA2cUEyN2lkOWUx?=
 =?utf-8?B?ckVzaEZURkhMSTJFb0lZWEpIWjNyVnIzSCtLWHB6S3hLS3VEVjFxcFpuZTFa?=
 =?utf-8?B?S3ZETCtpK3JNRWdIRUNtdzF2ZDM5bVFaVk9USllLN1VHY09KOVRWRTZyOGRV?=
 =?utf-8?B?Tlg5WDRuUWkzWEt5KzZXdEdjQS80Qi9xTkRia3pMeWQxamYxSnN6S3ZRN2o3?=
 =?utf-8?B?S01QREFOTkRXYklsWTR6ajRRSm5saHJYbm9NT3laVWs1dkxzV3p6YVlIT294?=
 =?utf-8?B?T2ROKzVPRUtPdTZmKzB3QUlGakdFSmszS2ZtY21OaXRVQm1BbS92RDZvMks2?=
 =?utf-8?B?dUQvZmNwNTM3RzdxczJRbDhwMW1BWkZmOG1QTUtGa3JwR0pINENKZ0lrUnRo?=
 =?utf-8?B?TkpqemxBOTVjZmpxOVF4bjYzOVpZc0dVNGkzZFk2Q3VVZTdIV0c2endGbkZB?=
 =?utf-8?B?Yy9Va0ZoYzZpMFgxcUpmOHJmY2dLMGQ1emlRMXp1cGtvdHQvVmJHUFZYUlJV?=
 =?utf-8?B?YU9kT0hvMTM1SVJ3OTlHVFJaMnY4RCtRa0ptaEFjaUg2Unp1NjdvcEFYZHUr?=
 =?utf-8?B?YVBQVmJWRmRsV05vSHRDcXNmS2Y3TExPSFNCUWQxeEFnQlBENFZDdzdGVDZ2?=
 =?utf-8?B?b3hzTkEveFpkYmFyc2oySDd5VENuZG9oOUlDNGJoWWZaUms0KzJNR3R5enE3?=
 =?utf-8?B?UjRlS0l0Y0hnQS9IckZJQzJnVXdQOC9CenNZRnI4dzhYUFZZc0lDdlB1QmVL?=
 =?utf-8?B?cjQwUXE0RFlTVGhaRDZjQzFMSlh4Wko5VGpRWnZWZ3l2MDBCZ25JSWV2ZHFt?=
 =?utf-8?B?VFp0cnNNT2hoblllL0Y5L3hWVkJvVHh5ZitPTkpRTGtnc2lyT1RrMVV2RWR6?=
 =?utf-8?B?dFdzTFNRL2VVSE9xZFFPcHY3MDYrOEFDUE14ajV2TE5XbURHYjk5SkZRVzFQ?=
 =?utf-8?B?QVFVSk1qTFM1ZllzZDVGaHp5RUZQQ3dNQ0svbExQYW8vZjlrZ1ZNS2gwVEhp?=
 =?utf-8?B?aGxINmxzQWtLUmMvNkpjTVp2TnFGVlliM0xwVEJKeGFzNXA4dFRWUFlVV3Rj?=
 =?utf-8?B?SjdiYkV0T2RxNkVjdExNVEpLVnVOTkl0SUtsMWJ0V2RpNDRzczBJVnJQZ1ZW?=
 =?utf-8?B?ZFBOVzhtQW1RaG5HWjBIZDBJYktFVUlhN2JxazAyL2lIVm5JVTg0THE2Q1lz?=
 =?utf-8?B?bnVMa0FJbThSYm5aSTl4SjhFS0tuWG1LNElpRTU2WldBY1grWXlYK3ptMktG?=
 =?utf-8?B?UnMwODhqTnl0LzBTeXZaQU9GZ3ZSc1BQVUg5RGlCbjVCazhNQXliTlFpYmly?=
 =?utf-8?B?S0E1SllnZzRxQW0xR1JtSEZYZ0d0NGRjb1FIUS9BSGg1Ti9sRjlidmxUWFpC?=
 =?utf-8?B?M3UwdlRUMk5lN0hYUzZ2TEdzS2szcTJUV21WbDJyTVNtVlVud3Y3em5wcjJE?=
 =?utf-8?B?Smx4RmhJcCtZTmhvWWVLTzNpNFE4dk00NCtpMmYzSi9iTlV4OHJ4T2FLSFZq?=
 =?utf-8?B?K0pWRHZqTmNYOTlUMjVBWHB5Y2x1SGQ0WlZLY0VrdkJEVmF0OEVCbm9zU3oy?=
 =?utf-8?B?c0hiWlhJQVpFTFIvYjNEUzVQRjlOK0hRK1VLVjZkdjdFUWF3N3o0OFJBQnFx?=
 =?utf-8?Q?mniXML6yt0j1FvDO1A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d51b86d2-2ab2-439f-3da1-08df1e2e1205
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 13:32:13.1202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gi07lCqEqvUpYAw+u8M2/E9c1zTXTFGQQOKAmyz+JODDYrvuVTBXujARQjYhg0Cr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB432622
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

On 9/25/26 10:42, Philipp Stanner wrote:
> On Fri, 2026-09-25 at 10:21 +0200, Christian König wrote:
>> Some problems like the locking design are still WIP, but we are
>> slowly moving towards that.
> 
> The question will be whether we can reach common ground with that one.

I haven't had a chance to look into your alternative to using RCU, but you mentioned that you found a solution to the problem on the RUST side so it sounded to me that we at least have a path forward.

>>
>> But some problems like parts of the dma_fence uAPI are unfixable
>> without time travel.
> 
> I would be especially interested in learning about who the party is
> that apparently is spinning on dma_fence_is_signaled(), supposedly
> preventing us from getting the memory ordering right.

Well there isn't spinning on it. It's just that in a SMP system it takes some time for state to transfer between CPU cores and that communication channel often becomes a bottleneck.

By implementing the is_signaled callback you avoid that device->CPU core A->CPU core B signaling making things much more responsive.

Even on ancient drivers like radeon people start to complain when the is_signaled callback is removed, so it is definitely necessary.
> Also learning more about the users that definitely *need* ops-
>> signaled() and ops->enable_signaling() would be interesting. drm_sched
> users cannot make use of these, since the sched-fence does not pass the
> request through to the hardware fence.
> 
> So who are the users? Parties like Nouveau implement these callbacks,
> but it's not clear whether they actually need them.

The eviction fence and KFD fence in amdgpu as well as the preemption fence in XE and i915 depend on that to note whenever somebody starts depending on the fence.

Additional to that I just last week have talked with some Qualcomm folks who desperately want device to device signaling without waking up the CPU. The enabling_signaling callback is necessary for that as well.

For Nouveau I think that it is pretty much pointless to implement those callbacks, but I'm not 100% sure.

Regards,
Christian.

> 
> (btw, funnily enough, with the Rust-fence design we finally have the
> ability to fully support all callbacks with or without a scheduler,
> since the need for an intermediate fence disappeared)
> 
> 
> P.

