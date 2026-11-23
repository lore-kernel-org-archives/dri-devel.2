Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5532606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4IgqoSrH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A84E10E589;
	Mon, 23 Nov 2026 09:07:16 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011059.outbound.protection.outlook.com
 [40.93.194.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E960010E76E;
 Mon, 23 Nov 2026 09:07:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dhfKQchremZ/wmnxC/IjW/axcnCDdvWd7XBlfMEXnlt1OyBTVIygzSHfgTcuxeIKQa2JbOAIq48t3xYvQqrsU3400ZDIkvYYhfwqYOYzLBO2rxrz2b3OVxDN4/rXCb3gTb4kRM7CleEuE3rRKhcGm4ZoInHON4LSAkKlGgTOfWt+jrBOVSHN5TjJcl2Jz+tCM1aet1tcqz476xw0FrZuQgRv11wyaqQwkwbegRF1L0A8+3mCK0lmXBrmSldMQyUxi4o1zlMjH7rY0ML1ec33SrNrBfs6J9rcTOm2agiBPL8Qc+04VIdT7+EiPX8cdlA3VA31+esfWp7RO+gMydg8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8swlrxvhmxn6Cpwl9g6LDv0B0qhkNF30+Kx6QZ2vu2w=;
 b=xYX5/4h0O/ZDCRwmdgYeyLT4oP4SURkyeuko3y0wbVnLpdHVRN0NZlBDpbUwxg7g1GacmcYvQHuq9gqOA+/k+kRKBWps2ifow3NSl6GdCifvbJRRYX/hXMjms5tJhFVRwWOlyubpIRS9casYtK2ZdzvGIE9b3DnW+kpUbcLfCZWECzsVO6LWxFoGKW0bTM6r8uIxz97efme7oIZ+DWaGpREX+hWu1BRHNokDgX52BqigORvV3VQiav7VVHIDZpJF3R67OEx0GEsvZ/ioon/W7bSSNqoWK7VT76CkYdTT+rFth946xmjAzv3Si5t0gHVP/oCwWG0q4Le8nfog19vayg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8swlrxvhmxn6Cpwl9g6LDv0B0qhkNF30+Kx6QZ2vu2w=;
 b=4IgqoSrHvXiRvvYHLcHR+PCTG+q47Cg4dvzBn5DXXpZcp1/jlccu1cmyaEc0zafwbH+Da2vkHEeJxfbBh0IG9CiucYp0Wo3JO0PIzwltK2cQgVJ+FNhjkCvhQLwCY3ejt1BmZj2YN0Bj4a2v/2UrmVeQswiRnl0RsKig37225lo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:07:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:07:01 +0000
Message-ID: <c7a81b11-73de-49dd-b38d-76aabf193dc5@amd.com>
Date: Mon, 23 Nov 2026 10:06:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/amdgpu: Initialize r in VM and TTM buffer
 helpers
To: Ian Rogers <irogers@google.com>, Alex Deucher
 <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Elkin Cruz <elkin@google.com>
References: <20261122045319.18651-1-irogers@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261122045319.18651-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e6204fd-a98b-4474-8a8b-08df49412249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261102123227099003|11063799006|56012099006|10067099003|260925021911599003|260925021311599003|260925022911599003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: E3e3+4BSkV0Ti+yCGLT6WeI4nCvdHkPoBs/yZmOfgMRspLadhz5jgEye3Z+il3opCb8IPQitdKPuch9ZBNK9QA3eAokUb93G6xncTBYthbS0FqcyipAvlE5+KLa+J6pCLaBxwZpVUyKBlj6X0aHG1SrxCi8WM3PQKD7F7IjJXoZ70En1bsV5pEmboCkSONGSRKVQpzrY+JDtxPCKDoe3vSBPDOQuIZNtdL0Tk9s6izzBjd0Ka17AC9w/11fRTDa4HpJWkrXjMaLXYgwmMTxrCyC/SBKgzf5exepqqD8dcU2XNfl89Q5dahzpdVBhu1TrwYCV+ZLe9ZfNNPsWi+QxO8fBg3GZauhNBUBjnmA1MY7Gzn0HuNJTJEw9B0Ks3v62NJbFrmx9KktOA8UrzsjNaY/n5a9pPoQL3wTW9RPiN65FIFKUtJTFk89tv8MSaePtLXYnyayeNWQdKan9xov4rS1jmFF84yeLJg8sh1ML7cMjRHJ8NP5ifemxyVkhTukZNAKBS4/7HV8w03intxLOzKGgueMMFwqPysn7FSXr8aX25z+clkRkg5u3hEotuzXVJXro2xOKwmisnBzu2cWtkiGNfv/nQAlLyPCKfhCmyuV4lcQ7B1FkWJuV+z0Nq4NG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(10067099003)(260925021911599003)(260925021311599003)(260925022911599003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFlVVWw4Y1E1dEM4ZDl5SXJaMWNRZ0g5d0FjZ1FFN2NlUDFuc084SVhHZDdZ?=
 =?utf-8?B?OURwb3F6Mjd5OGtYRmRCcHF6NCtoZkFJOHBTaEFSTW5uWG9xMlFNTmE4MHZp?=
 =?utf-8?B?L2xSNS9RYVFzV2dxLzk2VVVkNzROUjhjYmJNR0VuZFhsaDNWTXVJeVAwMUJX?=
 =?utf-8?B?dmNVSDlRT251NjBSZTdqN1lKNVNKZS9NR3VWUW5NWFRtV3luNTN2eGZKWmVk?=
 =?utf-8?B?S2lZdFlwQ2NORUs5MTR3L1BmRDhFVGVkbk95QzlrcWpxd0VLeVdqNkdpTTJz?=
 =?utf-8?B?b2J0TVhROW9STTYxcGFVZjEzMWhSMTBLL2lMdC9Ub01uOGlWY2g4QmZ4V21Y?=
 =?utf-8?B?RHJqTU80S01MN0ZZK0VXUTZWMnlCZmFiU1M0REV0NnZhQnFWaTVOTXB1ZUQr?=
 =?utf-8?B?NGJPcTF4STVkTXFQRUJCNzhEYWNvTzNSS0ZiMHhCb1BiUnAvQzdscWhwMGcv?=
 =?utf-8?B?TXVpWUtCK0VBTVhVYXJGaXFjT096akRRZDZQNUJveGR5VUtzekZrbk4zMUMy?=
 =?utf-8?B?Z2loaHVJN1VML2lMOVV5UU5QUUhaTE5wSWcxQVUrNkdYMEJvdlZXc0IwZUNH?=
 =?utf-8?B?NVRUUThnYThlWlVJbldFaDY0ZnMyNm94cEZWZHFLTGhGeHBnV0lIbTJIM2dj?=
 =?utf-8?B?SkI1QTFRQlIrN2ZSRHR0M3pPRjFlazNDeFpicnUzUUNBMUI3NVNMQXh3SVBv?=
 =?utf-8?B?S01ZK0RwZFg3YVp2OWxPWVRhSkoxTWhHUUV2UlJUL2RPZm1kOHFLVVBCQVNj?=
 =?utf-8?B?VHNUaktzME85eGtzYnFZdmV0Wmd2ZVZHTVNlYmN2bEs0YjNHUWRkRDE1K1dF?=
 =?utf-8?B?bFFuOElTVGJNaVgva2V4Qm4vdElPS3dPWTZ3TXBDUG9qVDcwVC9Ibkp2b25x?=
 =?utf-8?B?M2pqSzVJTld0bFJhWGFuQkd3V1VwYUxHYTFkRTd2Y25CanNtNld1L2o0aTcx?=
 =?utf-8?B?MWpSUUVoSkRUQ3hnWVZEQTdJd05MYk0vblhibFAxMkFnd0tjOFhEU09hSkRF?=
 =?utf-8?B?UGhnekltUnNaVVFpLzdKaUcwSmwvVk9DZjQ5T2NwcGQ5enJEY3FoWFphZmhk?=
 =?utf-8?B?NURIYUlMY0U3Rm5PcUREV09GRFAzRFVrMkhXWVZqMDlWbzVZekw5UTRrVjlN?=
 =?utf-8?B?ZC9MSnREaDJ3S3ZPdTdjSG44RjBwWS9hYlFhQXI3ZHdpZ1l1MUV6ZFZSV2hw?=
 =?utf-8?B?RHlPUkhGTUZYbnFsSWpqZ2hGZ2Z0NFZ2TnBac0gyTTJMRXlYcnFGMzJkRVlY?=
 =?utf-8?B?ZW5DTHJmaGJMeUZjc1FwdzM2clZ0Y3JPREVrWTVoNmxDM28rQXpXRDdtZVdZ?=
 =?utf-8?B?K2d2MW1YTUVTeFl3emppbHpWSUNYbmdicWJlbGJqc1JqK3kvMWc2R2M2UXRo?=
 =?utf-8?B?WUYxeWIveVVMeEphOE1LK2VmMnJvQnZPYVRiTVJTMGlTSHBJYndINk5mY05P?=
 =?utf-8?B?MmdsK2svTGpNSFkzNzRMU3RwSnN0b0FJUGVTaU52TVBxVlNocHhBeXVrcWRE?=
 =?utf-8?B?bjk4Lzk5dGh3ZkhFRDFneTM2YVMxY3phU0dvbjdHYUowT1djMXBYVEN1QWdC?=
 =?utf-8?B?K2hrdGtxbjAwNDk5UVlqeWlXSElKVWViQU9EM29EQ0Y2U3QxNDBKeWpVRFJ3?=
 =?utf-8?B?NzZ5ZEQzdjZpVFlNanVRZExaa3B3YndwU1JoRmtTVmhxeGR6ZzR6NWtBdk1H?=
 =?utf-8?B?U1FYZVBTRlluWUFRNkdycTBSdHkwMkxvSHljTkxVWC9XVHFjbUJ4Ky9ublZG?=
 =?utf-8?B?RnBmZTRDYnZ2TVdxTkxVWmJaUnVUbjc0VHBrMDJsZFRpd2hNMlZxcXlYZTF2?=
 =?utf-8?B?UkEwTVh4RG9XQTBlS1ZKb0o3Tld2ZHZyQURsQWQ5SFYvbWM1ak82bFl5Qm56?=
 =?utf-8?B?SVh1VURyaHdxNm5jZ3kwdUhTalVvN3NNTUUzNFpZYzk0UFNXQWhHNEc3VDhN?=
 =?utf-8?B?cDN5c1ZET3l2bCtPVVFZTkpXVzJGcDZkQkNZbHNlZUNCajJXemFIY3FuWkZp?=
 =?utf-8?B?dGRjdWhSOWQxWE9YV2FOcjJSd2p3MEZtNGpYUVFXbHVzMmswemNxYW9samJn?=
 =?utf-8?B?a2JTVk1XQXpLRlUyTkhCdlZ2d3VYQ3o4Z3Bua2pNOGpqMHdtbzRRN1FhRTVp?=
 =?utf-8?B?T0RlQmJqU0dBK3g1RFBzVXAzQnBVN09DTDVPcUxVWEE3d3Rub1lhdnptZWtD?=
 =?utf-8?B?ZWtOc3pNUmJLYUw4dnZCY1MweHVwTjNmU2pWZXQzSFdvY0pGTGN1dnF4eXhk?=
 =?utf-8?B?Mlp4eWtUWVZIaVpIa3A1NUpsVHN1ZEF5d0dubC9FQmFwUHpGNWY4aXZZeFFj?=
 =?utf-8?Q?PCPkxRZ4iQ8GhPcLY6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6204fd-a98b-4474-8a8b-08df49412249
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:07:00.9580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iV5J9fmOR3UtMlAa9ESXMMOopfXBjUiaYIDRwjLWl4qIGm4nQ5hx/3Uq0q2RlH0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by: Christian König <christian.koenig@amd.com> for both patches.

Alex will probably pick the patches up, if not please ping me again.

Regards,
Christian.

On 11/22/26 05:53, Ian Rogers wrote:
> Two fixes in drm/amdgpu for uninitialized return-value regressions
> found via Clang -Wconditional-uninitialized on an x86_64
> allyesconfig build:
> 
> 1. Set r = 0 in the 'else if (!bo)' branch of amdgpu_vm_bo_update().
> 2. Set r = 0 right after the while loop before 'error:' in
>    amdgpu_ttm_clear_buffer().
> 
> Build-tested with LLVM=1 W=1 (-Werror) and -Wconditional-uninitialized;
> not runtime-tested on AMDGPU hardware.
> 
> v2:
>   - Keep 'int r;' uninitialized at declaration in both functions so
>     future missing-assignment paths are not masked; instead set 'r = 0;'
>     inside 'else if (!bo)' in patch 1/2 and directly before 'error:' in
>     patch 2/2 (Christian König).
> 
> v1: https://lore.kernel.org/r/cover.1795106955.git.irogers@google.com
> 
> Ian Rogers (2):
>   drm/amdgpu: initialize r in amdgpu_vm_bo_update()
>   drm/amdgpu: initialize r in amdgpu_ttm_clear_buffer()
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 1 +
>  2 files changed, 3 insertions(+)
> 

