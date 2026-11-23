Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB96606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ONDVTAn1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B45810E04B;
	Mon, 23 Nov 2026 11:05:18 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDD910E04B
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 11:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iAAA4/fOuDM4DvHlx54qDcvJmLa8OCGd4mDvONK6B4eY99aLfL//v8fhAEWBtqhpFYvIXPXjPCKArcbH/AcXmnN6Nhhz2mQSqm9cJsvHcWcg9L6qCdUE+uhYmI9n8Ecq/JDnJitC4MjsB/UEhsOXsgtNdA0yJfNeu3BDo8talSOpW13CKr7budI4XmWG3xoqUusaN5DLtAzyKJ8ppDd0tdF2MWEIHKPUGmPstR9kTToXvOOYJC3ThDnRFVYdMv52H3m9ZkHYFRgOJFuFIpI7ROpxgEIYcPx9pH/R01cio/Qh1gn4Mx336sBszTMoJFSj3uiC4i7WLTX8bgg/zQc8cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTWLjUmRZpoYJu0xedJr+LIH0ymN5uS4bRrMOHkqFq8=;
 b=XuMlMeIsJmFAYgywhhkFSfEnfzkjCbUqnAY6+WKNXUuGgtqgDvZPNWW7pzjjHl6fVcWLrO7BpDNCbOkoFl6oULwASpAGRjRFhfnsauhdxWanpxv2usSkjldzPDMN1t9A2JxKWhDP7b15YaOkjBj2yTLLH1z0sWXya5C1ZTjSqsPE4/baBZp2Hosg1GtfNbv8Xycyb5EyLXuSqzjcdfbPEpn6NzQMuOpm9G/EgzIbe5Z+Iiyogtyq3wgUgUMwVYTOtmuBU9CRHqUIjgKdv5cAeWwN6UuSMjou8jYfRMjNuMrMBW7DvYou7BIszDLpButP/5twJsV5ZqNDcNPFFT+UpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTWLjUmRZpoYJu0xedJr+LIH0ymN5uS4bRrMOHkqFq8=;
 b=ONDVTAn1P7x3NQDQxRHh4DTS3V8xrIEVI6GGP/QAR3tXeZOhnoY8tYQMtd4ywgR08qYaI+YkwJG9gu/HFEN6hFkgIwtRQormYl1LQubo02+KuAnzbD6RCEopSTVeqOV20PZM8VhMHX12jiIcsoJszr5ZGGStDsF6CUnxfaLQg0k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PR12MB9598.namprd12.prod.outlook.com (2603:10b6:610:2ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 11:05:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 11:05:06 +0000
Message-ID: <c844403b-8c07-4a37-a988-85d2548bb674@amd.com>
Date: Mon, 23 Nov 2026 12:04:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: About NUMA support in drmsvm helpers
To: "Huang, Honglei" <honghuan@amd.com>,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: Simona Vetter <simona@ffwll.ch>, Alex Deucher
 <alexander.deucher@amd.com>, "Kuehling, Felix" <felix.kuehling@amd.com>,
 Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org,
 Honglei Huang <honglei1.huang@amd.com>
References: <316c1d61-f297-41ad-95d1-43aaa67c9696@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <316c1d61-f297-41ad-95d1-43aaa67c9696@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::28) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PR12MB9598:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3ddb1c-77fc-4021-2ae8-08df4951a15f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261102123227099003|261022105027099003|261021121427099003|261028144727099003|261026140227099003|11063799006|56012099006|10067099003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: t+gyO+m+ERw1ihGbCokVV4qSNklGstAFOSJiA6PgjnV3Khyv6cUCIDSz50UHxm3cTPtH7y9b4aIAigtTkIkfzj4WYgK9SvGe5PoS+emB/pantZinQyYHQD4ML4gHPEkjEmXUTum93eN3HwzEw+s5ozBrXD7rNQVl5BoIJXKVRd5m8RjQyvfg80ro38q0w9vcHW9N91HRG0w/Y4Nqm5VwUq/cnfxuyh5bChKGEXl/o+Y8Gh+OGqmwO/tm0sOAX3N2MBRi/LVyRdOpiuS27pjzK/CFYvzdomx6iLyQD8kkXtGo4Zvo2jqifMsstVPMaOpwS7CZiYkaMbMQv8ASsoq2/9Lwar4OJ0vuMDNcENQHyFOdf0OM1WKnlGDOOF0R+1Q37+L/DSZpJlTWW0XPmhig3E/zDEppx4Vlpu/vfZWt2H9D++IiuBbiiVVLRwPPR4vZnw5M2jW2FXP8yWkuQT/6scLde2DopDO/JD+bAXsLm5MmWfgj+4V9evyLkHvnxcvptAuYtfiyAARWjr/LhAhKfuMrE3MktmrBeO+FwTnEQ92b3+gk4i+KK5+psdkFTdS9HhAEo8QAfEMM7QH0epjG2Alhx1HuTtEp2gYVsliLKkq1zJ7u6xEqlRWpqfoQl2Bc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261102123227099003)(261022105027099003)(261021121427099003)(261028144727099003)(261026140227099003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEpJZFhDSXNoQTZJTnZWQWdXZGJ3L3NPZU9YT2hKbTFaRWwvNWtvbUtjb1NJ?=
 =?utf-8?B?MXhTVHo4MnRDdFFjNUY3a3JvMWtMdkYycnRtb2Z2ano5aTNBR0taSG83MDFw?=
 =?utf-8?B?dVR6U0plMzk4VnFBY3JMSDZGUTdFVGRCR0ltYTVxS1o0ajEwRk5GWXRWNFQ5?=
 =?utf-8?B?bWtPOXFDTm9jaXNPck84aXN1cDlxSWpneG00WmxIbmNWa0JaTUlUVGFERHE1?=
 =?utf-8?B?ZjhoVGhyWVVUWE5ZRXcrMTdoWnJMamp4dDdKMGFsS1cvODNlTGI2RzVUTWov?=
 =?utf-8?B?WVZJS1pvVTJvQjM3MW1UYmp2Qlk4YVh5WW8wVDUwOFpYVkgwMHplc3BsWXY2?=
 =?utf-8?B?WVR6blRqZ3hkcUZ2WlVDbW9ZS2htY1IwV3pFQlczK2l0Q3VQQjd5bDNPZlZZ?=
 =?utf-8?B?N2ZxWEx2Q3VjaU1JUGpBZW5jUFBuOUlEWHBYUVFlYzY3bHBJK05ZVDlrTGFF?=
 =?utf-8?B?N2JncHY3WnlrNENTRjQ3YjRER2R5UE5YZE1aZHhqZDZDL284WkZ4ZmZQY3NK?=
 =?utf-8?B?aGpXSDJNYkl0U0xPRGtYN29zbVBEcWxxMzVQZ1A4MUNiVk9BNFhBZDlPQThs?=
 =?utf-8?B?YU1PMjd5UktNNFZkZjFUL25ISm96THczRFdheW1OMm9WbWdYcytKalJNYnhE?=
 =?utf-8?B?UURpdXVmSmV0WUFWRjloMkx6VzBSaS9IQXZVN1VzQitsSURRSk5kNlVnbnFv?=
 =?utf-8?B?M2gyVVNNUmIwcVZpYWNsSjBVQy9PSHh6SmROMTMzSWRxTEVseVZ1elV6OUdV?=
 =?utf-8?B?K1ZFaDVOc212d3Z1bjBLYlo1dE5GNDdvOU0vK1JPTTFzWXNHUXFpM1diNWE4?=
 =?utf-8?B?YWhaU2Z0U0R6ZzRSa3UzNFZHa0E1b3Q3YUdKaGltajdqaDlBZDZ1eCtBdHQ5?=
 =?utf-8?B?Yy9QNXhMc3cyTEFQSzJKS01GS1VkaWk1bVNXNTlFQklLQnowbkpUYkFVMTRv?=
 =?utf-8?B?MlFJVmF4WVo2VGpkTi9FWkpvMVlkVUtabDltaHdHSytpM3R6UmNpc2x2cFNw?=
 =?utf-8?B?L1RRMkcvcGR1aHAzdjVkc2lHTm15dFBWNGlsYjJhYWNkc0VpZTJqUHFPN2I0?=
 =?utf-8?B?WHkzNCsybFBreW5qMTQ5MXc5bjU0WStoUDRTM0d0UEhIQlVWOHNBV05zczlN?=
 =?utf-8?B?Y2pSVWxBQzh5NVNpSjU2ZFNqMC9EQjRPWk1DMVI0bUJON3k3cGdaeXFlOU8z?=
 =?utf-8?B?MUNZdmtqREtxR0lYS00rVXdtOXlTUnFOeVdZZUxKcEU3emN5ZFdNcE5WQ0Ix?=
 =?utf-8?B?RDVQdXlqd0EzOWZLWFBGdWtLSUNnSUVBazNrMnpvYldtaUtJUWwxQ245cGNN?=
 =?utf-8?B?a2ltUEVyc25Qb2txNk5JbTJ6Z1gza2ZhQ2NBZUhOdmxQRVIySVpUQXVnMVZR?=
 =?utf-8?B?aHh2UWhkZUtqMFdiLzZXck4xTWtBbEk0RVJUOWRSazBOdlc3TUU4TkJUNWtF?=
 =?utf-8?B?bG9FdExNOHpIL25wM3BoTmdyeEFxRy9WRUFka3RtQlR1S1M1SitrTnlkaGdQ?=
 =?utf-8?B?SWxsUTk3dEdqNnhXVmtuVUVvTkIwOUpneExNVWM5ME5ZOUw1dEVZNUZXUjBp?=
 =?utf-8?B?ZHdXSXp5aEdxcTkwazNMRHMrOTBMQTE0aUpIaUEvOXdnditlZFVWTU1hQjJh?=
 =?utf-8?B?QnpMYlhOSFBybzBUSElJbXRoOGpyQTVCc1NPYWxDZXhZb0ZzNEs2Yk5ERzlN?=
 =?utf-8?B?TG5LeGI3YytaNlc1N3AvL0NmZmkwWW9VanY5MVNpMWxOYXFScnQ5dVRPamxz?=
 =?utf-8?B?RkN4dFVLWmh5MExLaFJYRnNjU2JTRzlUT2JMQU80dkpDVEp3OWlCWnIwdkJC?=
 =?utf-8?B?NmFNWTAvUnkrZ2FpT3E4eDZvUnlRQ0hoNFBrYytnWDdzVmtkMzVFVWlrRGNj?=
 =?utf-8?B?cHhSZUFSd0J6TUp3RGFpemd3TWtBODJXbnpkVjlTaUlzMGFtTFFHUGdlMTFy?=
 =?utf-8?B?MXZqT1o0MWVhMDlPeFJRbGhPODdiWU5mWStWazVCUkdkS1JHU3k4UUMwMUlJ?=
 =?utf-8?B?eTNSTjhvQ1lBNHNaSGxJQ0lFMVdZbEVVV2Q5eXk3VFZLRmJtSUdRMG4zbzJa?=
 =?utf-8?B?YUZXM0cyMm1rNGJZb3FHeE9LWlh3a2Z6Z3R6UHZHSWRyQ09XNlVaRjZ3Q0tP?=
 =?utf-8?B?eU9WVjd3YmlFQ1FhY1Y0WGhZU1dHM0VuMk5XbE8yc2RpRStPWjBsQjlOUmlM?=
 =?utf-8?B?cFBRS3NSNVhMYTB2SlAyMUF6MEp0RzJsRUJ1ckFzNjhJQkdIL05PNTFtb0tJ?=
 =?utf-8?B?RjVyejUzTTlFU3FuYm1XMDYvQXA4NVJmMUV0MFFaRlFjV2s1ZEZ2L3Y5KzRs?=
 =?utf-8?Q?/mDB3yriptBrk9iN2i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3ddb1c-77fc-4021-2ae8-08df4951a15f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 11:05:06.1202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dMNc9tRBFjf0AhUoVRHHMVrsZ5XfT94FUWAqofvJ2n+jMNFQeFWxFKwMxe9acyj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9598
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

Hi Honglei,

On 11/23/26 11:44, Huang, Honglei wrote:
> 
> Hi all,
> 
> A NUMA issue is found in another thread in [1]
> 
> We also encountered a similar issue, performance drop occurs when NUMA balance is enabled.
> 
> And there is one more thing about NUMA:
> The current amdgpu drmsvm can specify system memory as a destination, but not a specific CPU NUMA node.

Yeah I think that is by design. the NUMA node a page ends up when being migrated back from VRAM to system memory should be determined by the original backing store/address space and not the driver who migrates it back.

In other words when applications said that it wants their buffers to be placed on node X it is not up to the driver to mess with that.

> This has impact on some platforms like MI300A that feature unified memory for CPU and GPU.  We did a test for 2GB memory accessing in node
> 0 and node 3. GPU read/write bandwidth averaged about 2.78 TB/s with local pages and 103 GB/s with remote pages, it differs a lot.
> 
> There is a requirement from AMD HIP to specify certain SVM memory to specific NUMA nodes. But KFD also can not support NUMA fully. So the HIP runtime have to use linux NUMA facilities to move memory to the correct NUMA node, this could lead to unnecessary ram to ram migration.
> And it also can not solve VRAM to RAM evict to error NUMA node issue.
> 
> Would it make sense for drm_gpusvm helpers to let a caller pass a preferred NUMA node by interface? An explicit destination node for migration to system memory.

I think we just need to make sure that the NUMA preferences of the process and any setting specified by madvise() and co are taken into account.

Regards,
Christian.

> 
> [1]: https://lore.kernel.org/all/b32fb02a-68b4-4db9-83dd-254147dbf215@kernel.org/
> 
> Regards,
> Honglei

