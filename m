Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7C9606A327
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Hb1kiuP6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B11F10F590;
	Tue,  3 Nov 2026 13:24:08 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68FDD10E4D6;
 Tue,  3 Nov 2026 13:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=al9jeRonG4/hoikeY2NUneQQfJfyUF4ObMXYC8ucnxOULeMah+4LTK7PBzk/RBZVw7lStUOGuSfid44lZHvoSpUQ6syEo6jbZLOjeVfE3ihtoWpTvKQGkIUi9/rrCghRMlYIujouJbOizObqnZpSuyniRtgxJWe5rHkIlrUMJuIKslm/A71ZJ+bZlhs3Vh3I3kAQeA8GHiFq2DqHM0lVp3Y/sVld+dDTJETIGBiQ3SCvwRNe2XCHFclaEOIYXdnA7ekVFCm2AukDNp8HqBiPpcvv5byUUTYzzl+Rt71nW/CM4fjKe54x2TMm/37KEQlxONxZ0XRP0Nw8vJQnZOvNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpzUI0s0yBs2pJcAxiTObU1oc15Ra6O/XdGVqFDlpTI=;
 b=d8/1h/kGxCSdYmbu/tGqjYMjpjZ21BCNX9rxwow3pfkxpDVk5C6jdQ3yYQmcQrd8gEaPE1dmIzHJie02ujP04GPq/lpRND2r32aZX7QQhaRgusLlyulgKkZpdMqj4FWWeE6P2hVwfcObsgt8UK7rGXmKWZDKvh9MS8f5BYEB4XV3/1lo2FdKg7Wg8mKO5K+itC0sCEGhl7VWQbrvQ9jQP+Fnn9KUmlZ61mDlFoPG52t3oPs5OHqX0vjRj/lN0u+cUrIk316A+lFzl8HDl15WFZE/qsHmv0W3E6Qkd0qACr7bIfs5rZo51VNigijAJbBVBwIzebn7MX5tHI0/wpc88Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpzUI0s0yBs2pJcAxiTObU1oc15Ra6O/XdGVqFDlpTI=;
 b=Hb1kiuP6sjcmbbxJfplUe7Gm4HTO1lVzgs6qBzQoUiWM6cKAzdHDDLFkoA6OmuU2ZeGvS/X5eGq/NyfMsFpNWiclvZQkT+Ea5pGdiohK/TXA/x+8AO+tCf5Po3UuVtvOIA4dvC138tc6EhP2dm9RYZX5lBGmkcAJZ1DxM+t8h/c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by CH3PR12MB7739.namprd12.prod.outlook.com (2603:10b6:610:151::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 13:23:59 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%4]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 13:23:58 +0000
Message-ID: <b32ccb67-0e02-467a-8c29-2ac4c815390d@amd.com>
Date: Tue, 3 Nov 2026 18:53:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
To: Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20261021121813.1820345-1-arunpravin.paneerselvam@amd.com>
 <78a6d58b-4fa2-4325-a4c3-3cd732c15288@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <78a6d58b-4fa2-4325-a4c3-3cd732c15288@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0201.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b2::9) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|CH3PR12MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: bb64ad87-918b-4a27-96c6-08df39adb794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|261102123227099003|56012099006|261021121427099003|261022105027099003|4143699003|11063799006|261009223027099003|261028144727099003|261022075727099003|261026121527099003|261026140227099003|261022113327099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: WJxeNTCPIjQtMGNSb2TCUIHQwizDXlMOk93YY7U63s5ClVXjLEnKKWPcMxBEDxxYIUuXzye40odY7AdOOr1nj0vCmlpJ5fDs0u1gYH8vWhZNv9dVDs8xuBMwtCao2/W68o9dMPC7/fpNLvFTYYGdy9Tt5cJuAxxAwX+g5tPNiyUKODmaKN/PxL57B3uvKf3xtxjru2cXdYvvmzEO4rHB5Z+DRTcPLjZbJCmzRCrm3bOYXhcC7EiON5AQfhEQtBzoa7+5Ps2YTCqp7FaU0DZPBK8kXHEeiFNir9b8zFH2KXqcf1at+eOrBmSeZrzQHzzsPbooI9OwACs24jp1BSlbbj9nkM8ur+w8DoAiV6ejzW/BOfQZ2638BcYHm9XryL/pEytnayDByrtnxau/FoywXt7qizqfAr6ABDDW783v4yGjmugQBf4gVfDdqgFPQMTDR3BHiQvVpfOnwpVpqit3snClDWycQKZ9wXZO74jW+4V4mXqhrWW8tySPGX+PNEO6T8v3FypehqME0DbE5qJdwB9vJ7tqTGTMfB5nm9hI91I2ZW2FOFd1G1XF880vQ15Hn/hamVGZkhETENmqPVjFkyi0+GZ2XRMjY7RqGCwfqd8nHHaPZ96CDjRMiiEHLt8g5LhkzOv5Uv5AmZwdGxvN00YyVuC3HfpUWyKcKQLr2lc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(261102123227099003)(56012099006)(261021121427099003)(261022105027099003)(4143699003)(11063799006)(261009223027099003)(261028144727099003)(261022075727099003)(261026121527099003)(261026140227099003)(261022113327099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGNRUWUyM0hZaGUrYys5T0w1T3g5QmZ0cTlsRnB5TjRPMVdiYjIrd3dmTGQ0?=
 =?utf-8?B?am9lS0VMZmdyUkpqL2pOL1ZrY0pOZ2FCNU42V0h5ZXpzSEFXemkxb2xxQlhk?=
 =?utf-8?B?RHZseitXY1VyT1hxb0Q3eVFQWTRTNFVWeVRyMWsyNVl5Sk1mRFdzdCthL0Yv?=
 =?utf-8?B?eTBUQXZYNXI2bHlmUVZVODVkczVyWGVLTHJGYkhWTkhxb3ViKzJkaFJVa2I4?=
 =?utf-8?B?QWNGQUU0QzBPWFhhaFgrZWsybWdaMk9nRVZnTFBZZ1pHR1Ywb01nVFpKSmYy?=
 =?utf-8?B?cjJWVEdwQllhekZXSkpXNDRhVU9vbmszQmFOREthQVNQMUNtUk1oZkIrMUg3?=
 =?utf-8?B?TnFWdmdNYTlxc004dldxVFVtbTZmS2pIeHJMWUVtcjhybGtQcHlkN1B1bXFG?=
 =?utf-8?B?VkpVNDI4Um1ZU3dMVTVoMlZrdUd3WjdaRlJOSU5IOUJoUDVaYUVnK3lBMURV?=
 =?utf-8?B?MVlZOFYrQ2JNeFVVc2RwRzgzdWliRTMvUnRRZ1AvcHR1UW5OSHovVGMxeGVq?=
 =?utf-8?B?NXJ3YlRWYW0zVFl2ZWlUck5IeWlvNlpFbzIxODY0aUwyVUx0b2NHUXNqZHcw?=
 =?utf-8?B?aW1VYktBaGgrOTR4ZDZPQjhheHNWTUN3d1Q5dlFiSnpCV3E4TVRUS0hyNDF1?=
 =?utf-8?B?bWFiUGZLTWZ3b3ZUbXlmNE80ZnBsYkpmZWtlN0p1UEZHbFF0a2YyZ3g2b2R4?=
 =?utf-8?B?NHhad3Q1b2M4UGJQQjBKaXNLRjZRSXF1UDR2K1NXNHJoUkh2V1NoNzRtOHFk?=
 =?utf-8?B?akoyTXVVUStPdUIyNk5RMldaRzdGNGpWOWc0RTFXd2o3WWJ5QnpQU05GUnE0?=
 =?utf-8?B?WXlNZXZ0MzRQRnRDR1p5NExvMlh4d2VuK01FaCs0WTZVNnBMSEV0ZStuc1Qy?=
 =?utf-8?B?RE1hOGdZZXlua1k1TnZpQkQwN2lvSzRROC9VTEQwelJLZFZjcWloTFZGeEhY?=
 =?utf-8?B?OWJNWG9mNU45ZTU4WUJXVUhIMlBjNVM2eVhuNlk2ZHltU3lmdU1ZZElJSXNM?=
 =?utf-8?B?KzNodjVBVUJPOWhUOGVVZXIzdytJdEtJY0d1dlhIZVQ4dDB2N2ZyZ0luSjl0?=
 =?utf-8?B?R1ArL2VRbkUxWFNzdFRHRVk2eXdFamd3UGozZE53SktSNitzR0NoZFNKbHBY?=
 =?utf-8?B?MklhWVNuamlyTE9qNi9TWmMwaHNkUlNob3VtbVl3eHZyeVVtWkxieVRacTJL?=
 =?utf-8?B?ZEdFRGhweEtxM2lyaXh6L2llcHFadm9ZTy9IZGQzSHoyYkFuQVZGY1k1QVpr?=
 =?utf-8?B?cGs2N0p4N3JoMHRaWVMzMkp1U1d4aURmUm1objRDZ2Q4Z2lkUUwrM1RxbUJC?=
 =?utf-8?B?eG1PcVJuZ0Q3bjQwUkl5NC9sTjlHMC9VWHdaRjZUSmpGVzQyS2Q0UytoUDZH?=
 =?utf-8?B?TTFLRnI2Q2VXUk16Y2dZMHUzWFMzS2dlSzI3ejV2U0ZCMmdOby8zQk5zZlNX?=
 =?utf-8?B?T2Q2R21FWldJbkR4K2x0RjZYc0w4SG9pUzk5c1JYWU9ubkJScGhtTzU3NjFl?=
 =?utf-8?B?M2hKcmx1OVRZZFl4aFNKbWl4UDk1Y2VUQXhSV1lJaVdHY2VKbnlEM1lFSWd5?=
 =?utf-8?B?V2RhWUNjT2pmQm1ydU1SNmJLaU9KejEzN2hYMFd1dDVjU3pSZHJaUG5rMHFI?=
 =?utf-8?B?OVRKMTJTMGVWTmxMcGJIdVRCSXJGeFV4TDdKQTN2dGM4OWo3RWNQdlZ6bVpH?=
 =?utf-8?B?V25EQ0gwaHJ2ZnFSNUgxQW1XOUs1OWxtOWZ6WXFMK1h2MGNZbS9zbzZldVdV?=
 =?utf-8?B?WVpaM3NaWDMrVjVaQjNlT21xaWpNbHh2aVhMSDJsWklucEZGamoybTZuYm5r?=
 =?utf-8?B?R1FmZ1RHL3NJamttc0pQdXdVRlZoMXN5MVE5YXp1UHlzblJmQ1ZoUHVHWlpr?=
 =?utf-8?B?L2tFSytsVjRGTDRNYUdRUjlra0F2YUd2WHFJYWo5Y24rN2dDeXFzSzN2NGJV?=
 =?utf-8?B?R01nNWFLVDg3amtZRUtNRC81ZUFPMmN1Yng3a1FqM2tESnpNM2FxYWNEWTRS?=
 =?utf-8?B?bVhkczRNeG0yVWRKL0MvdkF5dnZFbnFmMGpwNzJXc0Z0bWhqUXNjQWRCTUw0?=
 =?utf-8?B?Z1Y5eXI2VElUbVZXdnU2dzJTVUEybWtFTFZyWTNWMklXdHNkbndGakJTS1FP?=
 =?utf-8?B?bVV2N2hNR1h4aSt2WGF2YUs0RnByNmZRSTU2T2pFVTI1Ykp3MW1LSEQwVlox?=
 =?utf-8?B?MzNGRWxkRTNNWnhJdWdHYVgra0o1anhhN1RQckZxc3dUMmdLVmdEM0RsR2RU?=
 =?utf-8?B?Qkpwcy9NbDd3bGZFSm5JdmphY1d3d2xEZVVTdERzZWMzZWY4cklVZFJyYUtG?=
 =?utf-8?B?dkZrLzlMMllSVGdWN0trNVZrWjdIbzZ6aldiNUdRTmlxWEdFQXBzdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb64ad87-918b-4a27-96c6-08df39adb794
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 13:23:58.5493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ziq3FgN+mvChBRBAKqjIu3oDJMM6zYkR2qMrcvCIPWkODf3AX7w/7q4oXyxUR/MkmcJajc9itbO71PPXXCEZ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7739
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Matthew,

On 10/21/2026 6:19 PM, Matthew Auld wrote:
> On 21/10/2026 13:18, Arunpravin Paneer Selvam wrote:
>> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>
>> Range-restricted allocations (the visible-VRAM aperture) skip
>> dirty_steer_window() and reach __alloc_range_bias() with no clear/dirty
>> eligibility guard, so a dirty allocation freely splits clear extents 
>> (and
>> vice versa), interleaving the two classes until no large same-class run
>> survives and a 4K scanout pin fails with -ENOSPC. Use a two-pass range
>> search instead: block_incompatible() rejects opposite-class blocks in 
>> the
>> strict pass and relaxes only when the strict pass returns -ENOSPC, so a
>> request still succeeds when only opposite-class space remains. A KUnit
>> regression test covers the interleaving pattern and fails without the
>> guard.
>>
>> v2: the strict pass can split a block and then reject both children, so
>>      a split no longer implies a compatible block exists. Sashiko 
>> reported
>>      the resulting leaked splits; fix as suggested by Matthew:
>>   - Push the parent back on the DFS stack after each split and merge it
>>     back with unsplit_block() if both children are still free.
>>   - Make block_incompatible() judge free blocks only (split nodes keep a
>>     stale clear bit) and take the requested order, so mixed blocks that
>>     can hold a compatible block are descended instead of skipped.
>>   - Extend the KUnit test with a coalesced mixed block and a check that
>>     a rejected split is merged back.
>>
>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>> decoupled dirty tracker")
>> Assisted-by: LLM
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
This version brought back a DAL CI failure. when the range allocator 
wanted a clear (or dirty) block, it would split a mixed block to look 
for a pure one, throw away the mixed halves, and then use unsplit_block 
to join them again.
Doing this on every allocation was costly: even though the merge 
cascades back up through all levels, repeating this split-and-unsplit on 
every allocation added enough overhead on the display hot path that a 
large scanout buffer
eventually failed with -ENOSPC (igt@kms_plane@plane-panning-bottom-right 
on Radeon RX 9070 XT).

This change relaxes the rule for range allocations only: we just take a 
mixed block as it is (the caller clears it if needed), so the first pass 
never splits and never has to undo a split. Large same-class blocks stay 
whole,
so contiguous space is preserved and fragmentation goes down. The 
behaviour is still correct, unsplit_block is no longer needed, and a 
KUnit test reproduces the problem (it fails without the fix and passes 
with it).

Could you please just review v3 of this patch?. It is a bit urgent as we 
need it to land the base dirty-tracker patch on our internal branch.

Thanks,
Arun.
>
> Are you just going to push this one by itself?

