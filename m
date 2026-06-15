Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C181CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07BF10E388;
	Mon, 15 Jun 2026 11:21:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LCkSoz/E";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012055.outbound.protection.outlook.com
 [40.107.200.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 267A510E388;
 Mon, 15 Jun 2026 11:21:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuaXwtTxLD8gQVk4kpQrO70SASGB8JMX7N8/aIwHjL6dLYktOBGMmn6Ad42NwyUQiRkogFdPuhR8D437PutdI1Q0gRvhIf1djAiu8xFddpBoQrRis9Je52WM4S6uqCSRSeHEIcKt9g9omg1C+eUT+Uq8FNBMdZ+G/VFBTEO6rFQsi+sL8yvISF3kLTnpw6kBRCm3vszUsCZ7vbWbPkqjrI/NAsm43QNAQfH1YH1+s8kTQYoWY5UiQ60ejUvrlRPmlldSh5MfrIqFBLAQ2eA6LrI+5wqIsyxPgNOCSaplkBajBMU21Wxi5N4O6ZwjPbEfNmeaOqGOrI91DTw7VBEP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bihx2wcNTIr+E4xFU6aCuSRPi+ZN6BsunqqdwTNY4tw=;
 b=PPAA112htLgFWJv8Gtq+JN8+RP4r0YpdXeRwxZBGCxazIqtsb4eOqjDH9g8OzHqDdjfoIICxhTi55wNbZU7APerkLlD+cSJqsBAFrcu4Z7FjmOPWWjF0x7UdB5xPB90ptoGsdmUWHp/pyiIixZLgVtF/QAbMX1BaE1aCdRwaALg39+L32TYtbWQdhM1z+GeGeJAWtNGnLpmdUU4QvRM05l/B1SWq1qQKmH3saM4h+gdkjhW5QT5KPskmMiNBmPqAJ0H+hLOrPj8vddFTLJ5Cq8/ulmBRFpVzOjDc32ByzxFcDvuniw8b7JJlI3OW3XQcZGsES+MlkkreYih9ofzoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bihx2wcNTIr+E4xFU6aCuSRPi+ZN6BsunqqdwTNY4tw=;
 b=LCkSoz/EuuS4dKfoACUmHNc44YRyfR7qpphWTNr22rudbFWWy4nhHDTIsy3CO0B722cJpq4+eFRJcW6V0nIuOLd931P4hMmH0OIJn96uJQRl1H0z63rR908vXTi766ylsNyehPfIbScoud0wXXNm/0PJFPhjMJLR3ZuPY0ggfMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 11:21:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Mon, 15 Jun 2026
 11:21:36 +0000
Message-ID: <1622273f-ab4f-427c-979b-833d0045d6c6@amd.com>
Date: Mon, 15 Jun 2026 13:21:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/18] drm/amdgpu: implement SVM range GPU mapping core
To: "Huang, Honglei" <honghuan@amd.com>, Huang Rui <ray.huang@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Cc: Xiaogang Chen <xiaogang.chen@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jenny Liu <Jenny-Jing.Liu@amd.com>, Zhu Lingshan <lingshan.zhu@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Junhua Shen <Junhua.Shen@amd.com>,
 Yiru Ma <yiru.ma@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260612090928.29682-1-ray.huang@amd.com>
 <20260612090928.29682-8-ray.huang@amd.com>
 <7d073e2b-0a7c-4e42-a67d-32817596d238@amd.com>
 <2a93e0a5-dd7b-4d63-ba1b-3d24d1b59a27@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <2a93e0a5-dd7b-4d63-ba1b-3d24d1b59a27@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0922.namprd03.prod.outlook.com
 (2603:10b6:408:107::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8120:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b6bae1-c497-4ff1-06da-08decad0433d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: m3NR1DncIXu2XD26lz+EVaiQcZKuz2gA9DQ0L9YhH6KpOHg7qOV4NT/z3ogQbr3vHAaQwWV6ukseUXDRBXsLwTArxKQ8kBCJMlvd9NsJq6E1suoUrKURKR60PbgLRXLw5kOjmNj7o1i9CY9RII+tlM4QBobg+hdN+j411fUZdlkMhnWblSA7QfQQlQnBIXIeUniaNBaWlonzLk5GZUzSnug4HAjlAr+STccV93oRAgHoXHyHe/NuVgRfG23ts5UaqWhsB1nRsOtJsYh29y/M/sovHABeJaQ0kBTWJPr+D4UgPODx1VHcbqC/ObytD+2gno6udv5EbQroh8BKeE7ncTkncQANmv7Kjabu+Amdf8jx5onfGBjbqylfYIKl54hp8RZOzEJjHStlPsRqGT3kaR3AfTzVTfm4EbB2oRQ+08+bVTb5uD1cQH+3o6va55axn+taUAoHRRzycXw2Xjw4eOLKNmY8JGwBb7mmrERHCBoD/FIfKbaf2pLRis2uD81O5Jagjdllsc4s0Rjn4BF7gUhmJA66jWAuPJV1I6ghwvG/pM3MEOJUwPOXUdw3iQqWx2t7jSawJIKbvz3x8MR9632BXLyYe4p3DpG7fdB0s/e08PTn8L9q0EL5SsUDjaYXeT062MEce7GMqiUZsi99Px0EoUdBDtn5SgN+CS6+GI+ldTNjKuoiRmvjux4bq4qb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDRaY284TXNFem90aDJxbkswa2NNemt6R1hkWHlvQ1FIMHk4enh6OU9wdjZt?=
 =?utf-8?B?SXpDc1FqTGRzOXp0RFRTajJqY1ZtdFkyN21WTXZIZTJGN28rR01hem9qY0py?=
 =?utf-8?B?V0JCQ2dFUDZ5VFZ4NUdGRVRNQXBQVWYrQ3lUaW5XaHJlajd3VlB1eGZjNDNx?=
 =?utf-8?B?eURUOGVEQ3RQZ0dHVGNQTjN2YU5ldEVpcHFxQ21qa1g3cWFVZy9neDlRMzkr?=
 =?utf-8?B?KzNqOWhja0JyckkxUG0yY055Q3NDWjdkeitYNG5ZQmlsT3lqMnUreG05Yktw?=
 =?utf-8?B?MWJqR3BuU0NWTDlLS1IzTFllNFhNWUNtNEgwY1hZVStQWVRwRTBnakhVTlhI?=
 =?utf-8?B?enlNb0k3TzEydWo2NVlrN1ByOWluR2ZNSUxKeEtUT1ltdDNHUXd6WDFKQ2Iz?=
 =?utf-8?B?aWpRbDRVcGlPTG1sQ1YzOENxZ3oyeERhMWRoNUx5QjlZcCtmZ3l1amlhd0tt?=
 =?utf-8?B?RkE5dkRlTXM1VW5qd3h4R3cxKzRRTndzU0JVQ3VOZURrNEQ4akhQVFh3dHpp?=
 =?utf-8?B?N2t1SU9GTjJ1ODNTRURsUElTeVFqdTRRU3RkZmsxdzBOdVBaYmxxcFVGQ1VZ?=
 =?utf-8?B?cHdUL29QQ3BlUmUxenZrNTJkaW9hVnBKWjBiMXMyWVRwYnFQUTM4K2ZnK2hW?=
 =?utf-8?B?bnVzUEtTSUthajBWNDJGWURYa0szQmQvNjZrV1hheHRYbTMyeS9UQXorVGpD?=
 =?utf-8?B?Wm5xQm9Zc0U3WWhxWjU0TFdHTnI3dnF1NFk5RWdjdlhTQi8wUk5IU3NkRUZN?=
 =?utf-8?B?aFM4MFBVN0pmNWdYNVFNZ1N1eHkzQi90WFQ1U0VJVGUrU1VwUUlobFMvTmhL?=
 =?utf-8?B?L2M0V0hRcUkyRUgzYWhZeDdNb012eVVrVnVEb3M5Qm13N25uV2xVbXBveitD?=
 =?utf-8?B?bDBnQVl1bTU2bC9ZM1hOam13ak8xWlJodzRsTmJRcnVGaCtBTjlXbWtaWm5V?=
 =?utf-8?B?bjIzQ0hwNjQ1UXhCQ29rWWJOMC9RenZlNjlGLzZ3b2xpVU9lUmZtdzNFTHYy?=
 =?utf-8?B?bkFScFo3MFliOEVveElSVS96SDNRUDhqUXI0OUNFWUdOZzFlbHZwcVZCVE9V?=
 =?utf-8?B?aHYzMGs0SEZaREdIV0YzeGQxaFhsRzk3ekdZU2VJOVE5UjR2NzV5RnYvdWFq?=
 =?utf-8?B?RXlWRVJ3RnVrQSsydWxiVE9BS21kR3g4NlhTTldJNlk0M29nL1F5T2hvUGRT?=
 =?utf-8?B?TmZPZnpWTE9mMmc3bTRmcFRyVExFY2JmWXU4NVdsL0dlNzBDLzRrK3VIRXFP?=
 =?utf-8?B?REFnMllVem5hZVU1M29nVEQ1NjFZSEJ2ZU9vUjBzaGdFUW4wb0ZmaDFMOWZF?=
 =?utf-8?B?UTA3SGNTaGltN3hpQm9lOVVsU21WbjJsUXUwclppd1F2L1RoNXZvbHZUT25n?=
 =?utf-8?B?b3RJSnVlTEthSmUwSlpncWd5WmxYRlExdlNtVjJqSVBuZlUzTU0rdkJ1UHF0?=
 =?utf-8?B?ejQvQWxSZklSSk5oUFhZa1dxSnVnajlzWkNXd0dlUzdhazZ0OFNVMXdyWUxy?=
 =?utf-8?B?S0I1RVo5SXI1TVYyVys0cnVKM3ZSa3dTRW5pUGN5a0l4QTQ3VWxLWTh2Y3Bz?=
 =?utf-8?B?Z0p2ZlZ4akVVM0hOLzJ5WHVSVDZ1ODNWWnBZb3Z3V0tmbytUdENiSjhxNmhR?=
 =?utf-8?B?em81NW5ZeS9hcVRQTHZ6YUJsRzVUb3VGb0NKK2tUcW1JdEtoeHBQU3pwbFdo?=
 =?utf-8?B?R3pKdFZJeGhMM2lHZXhYSzc0WmprL3hIb1Q1Q3FYRFJkZ3ZWN2x0OENjeERE?=
 =?utf-8?B?ZEJHeVVKNG42QmRzT01vVklnWFZXRWgzSHozK3BCMXRnZUtCU2ZpTVFPbzdk?=
 =?utf-8?B?S3gxQzRxVk95UDVwcGZVYzRaOWpCUlFja1g1VkZSRjVDdzJNZVM1VE52Y1Zp?=
 =?utf-8?B?ZEhobWhySURZNXB6aWVVd2xwUjl2eUFVQkVCQ0lHbXRUa1NaLzlYYmk3bCtL?=
 =?utf-8?B?UThsZjl6RGZBbWhpT3hUM2xGM1B4bEpjSkFrcDhJWStGbzhVZ2pIZGhBaElT?=
 =?utf-8?B?Q3N2VHFPcUpNako3c2g1NXM5Z0pGNzgzSFdQcHVmdG5vbXNvK2svZTFLWjZw?=
 =?utf-8?B?Q1RUNU5xVFJSdnhuQkdQbUJ5ZzdYcW1QcUpVbTFhSGk2RExaWmhLd0ljOWxy?=
 =?utf-8?B?QUo4OVBPM1NCclB4TFJMbXAvOWtTLytNc01naFR5cGxpeXUyb3RzOGZCMkpY?=
 =?utf-8?B?L3kraTd1RDdsU0RMWFFsaXI5SC9EcTBZQ3dHWDVJaVpvc3VmckRlUFF6eFg3?=
 =?utf-8?B?RldzL3lyNFRLUWd1NTdxb3dHdmxqU2VJY3BZMmFvUi9UeStyTDBGZmpOVDNr?=
 =?utf-8?Q?gO2/ykieT8NqGCEhr2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b6bae1-c497-4ff1-06da-08decad0433d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 11:21:36.6057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWnzMOtF1yvCW6MePIypIK1sfaneA2M+CbQN89ZNpb0MBLoI3C0XEFjhyqBovYY9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8120
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



On 6/12/26 17:07, Huang, Honglei wrote:
> 
> 
> On 6/12/2026 8:21 PM, Christian König wrote:
...
> On the SVM and BO overlap issue: if planning to mirror xe is acceptable?

I'm not sure yet but I don't think so.

We have a mixture of engines which can do page faults (3D, SDMA) and engines which can't (multimedia).

We most likely will need a way to completely separate the mapping from each other.

Maybe lower address range for SVM mappings and higher one for BO mappings? But IDK if that will be sufficient for ROCm.

Regards,
Christian.

> 
> And maybe need some modificaitons in amdgpu vm, may I know the next step/design?
> 
> Regards,
> Honglei
> 


