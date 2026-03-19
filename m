Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA9F1088E5C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 00:34:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDD410E03C;
	Thu, 19 Mar 2026 00:34:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LwQZRSYD";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011005.outbound.protection.outlook.com
 [40.93.194.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9A710E03C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 00:34:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tSYpTdu/39donCEgcC8fO3S1Jzi18YQfHovbHq3mYn63bimjHpIZA/JyObbEIcnVSr3bkAwGmyWcK1Z32v43zbKZ80YNDJveXCrDqGWH5ZOgaSGJUN5z0BVVw4UlxYZIIWkAHktf6qrClNiSm3CvXr9gEk3surnMW8hgrEN6J0KxiUBbTcqF3RGLfTfpRcUVP4j616cXpR+qpmfFrerZCDlAd5jCR1MCrn18w1MJhH+1G6vW90gV7iPzuWqFghrfTUC+elLu02vF4vZZYERPZLCDcjavEEjQryhBWUmf/Qc9r9wnEbxNSNXDNRate6x8trf4ZXglcx/o8LRZE0QQGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0n9WFDezT2J6T5nSVd3cMJvTTy9VstVSzQWVfo7BdA=;
 b=x1+8cc1GaSiaMntpitoJqj4+wNaeMEJvJafevberayvxuYqd7pAdjN7shQ7FgE20RoFvTLkoHN/f1MZF/UuW1lqrpXv9CjCQBa/8Tqd1oCLrqZb79VXMUPMQuZXYNjxzCjSQjgRIw/8WpXfzMAD5tD5FbFp18j9mibC8slDKtkjnpSYMuTSvB35Eyk/AG44CnwPAAemPj8NYi57v5Qwx6tkYERF7LUZEpuaXuoo1E2SVU5HiyOMtegGWId8BXIqdgoMqpcuPkiHBwkrY4UwBFzryZXSeFuF+HYpxXVBmLGkErbT2BrgcLafSGNJ3Wdl+vxHD4Mw4HYpyuhXLt8D3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0n9WFDezT2J6T5nSVd3cMJvTTy9VstVSzQWVfo7BdA=;
 b=LwQZRSYDTN7JK7o+c2SwxnxiS3Ye8jQivLlygyHNvG92N+KmXbiPSyC5SICBDb96f2EjLHZ88YDggzX11tJCO+0Zs9okwJwkN76YE//p6D5Tw4FyPPhADWgyuDLg5XGtIeF/QBPocb9zrKhNoEi83x6eJf1qVPeVH8uLwwjgld2Ynz8opsoOMHj9GL+9NHVDcA/lit0ywcSuanspVZb8Hq9jOQLLakW5/DucLBh1i9qkKsGVG5/jW1T4LX7OYOCS5mAxugGIGei6lPAfYgtXeP7ZMZ6FwOv63nzQHjTl1DUkLkmoyJI1PPan/Yd6OzZw1a/wlUQMdIfbHlPV5V7twA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 00:34:15 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 00:34:15 +0000
Message-ID: <7841c3e7-f97c-4c37-b981-4fc81319e0bd@nvidia.com>
Date: Wed, 18 Mar 2026 17:34:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] gpu: nova-core: gsp: add mutex locking to Cmdq
To: Alexandre Courbot <acourbot@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alistair Popple <apopple@nvidia.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Zhi Wang <zhiw@nvidia.com>
References: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
 <20260318-cmdq-locking-v5-5-18b37e3f9069@nvidia.com>
 <DH60IMOXP3O2.26EAXOW3BC7S4@nvidia.com>
 <DH6ALL1W4RRK.3H921XS11SXE9@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DH6ALL1W4RRK.3H921XS11SXE9@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:334::21) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|MN2PR12MB4126:EE_
X-MS-Office365-Filtering-Correlation-Id: 35be3d63-6bb8-4f3f-ed23-08de854f3fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: As2R445UFKAT75igbdcbqyQ0YuWq+G7767G8q5At1ejycVdz2kJglm4GotOA1utOsHChKFFVcSJnoqvVRFoHK6EtRYAYMod09o6ztGHsYBZbxQSScNwoozfwKXwrcIBwy+fkA4/vp4kqw1FYm+0HprmrUz3EFE0l0EtYXFMfL3yawY1sMEG48ZL9cc6IHi8N47CCFco/1y+88JnrrIo8ag+TaNJbBvIMjOuQe2qBed8T1/LKAZT0eon3eP+ub4HaSW5PFJ+ZSwjsj5BmQUtrorjDvb8XCmm5OexmLdA8IYYGSwoooQXBdYWb67UrFvZLt3442DnHCtz55b+KGmpTioGDHCDM9k1njxdKdvdHljkwiMNoOt/XaMVQeqYGZyo0Lg4rGCVGbh42rfXpE1X85QCz/JmZAhXlpMW8XrLAAlUUtC1v/8ffzx/Q1hDAxzLVIDh/GN7U2SD+SHFPL1qitwQ4tEHUkhOV+c3vrj+X50iWhFfyMNAzpDq8tp9YnCEMsodbGRpnSrnJy4LOF8CpyFN7FpHw+I/m9NUjZTDUGt0Sh7H3d+c14BlNmx+ME4b//p9gy4t8ENIkctMOKHymw/IYUfrqvkVBP5gvlfgJQv7yC5RQyC8IVHI95Nq/l0niX6RMpEDl1T4LLSi7K1Dlccaqfexk39JKcxdbS+1YA8J80zpi2fVKqRQuAYOG4VijSChumLWIesb/3d2YXrPj5KkDg2BfKDWYyEFDAh08JWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qlo5R0I1YjR5MWwzK3dNV1JYRDBaNzBIejd2T1hBSmJaSzFDRlZoYkdLNXBE?=
 =?utf-8?B?ZWFpZzJmRWxNakwzL2V4WTJIQ0FEcXE2NXprVm52dWRBc21HVVBTdlplSWlz?=
 =?utf-8?B?cFBTZzhNejd4ellRcEFweHlQdzA5REZ3VUkwWXBsbjZKZXRFTmF5Nm5lL28x?=
 =?utf-8?B?NVY2QUFrZjN4dC82cXV6OW5zTHJEMGxQcDU3NmxkWEdIS0xUUHB1UXdRSUNl?=
 =?utf-8?B?Z1JOOTRnQ1pJMjUvSi9pTjVycGQ5bUIxRHMxdk9Yc3Y2djBOa2grU3V6ZzQz?=
 =?utf-8?B?NGV6MjBsRFhWanNUUkZ3Y2M1T2xpejR5ZmZJckswYmRDS2pTN1o0YzhOYTI1?=
 =?utf-8?B?V2N4QmJWRll5YzJQSW5LTk9EQ0lZUFZtMlNnMFUwaVlRRFpjbXRoVnA3OXo1?=
 =?utf-8?B?cFVFamtzK1ZxVkJPakllUW5yQ3hBYlRQYnRhYUk2Q011ckxWbG4vWXo3VUZS?=
 =?utf-8?B?dmZJd3NGUGdoaktLZFJCcTRSVWxFWXdvQ3VVWHQxSXROaUhWd0RtR2NxZG9Y?=
 =?utf-8?B?emxuOFZ5a1R0YkxmZjdnTFZNUDljd09VU3ZlSzhIY0NiM0pRMVlpNmVMYkM2?=
 =?utf-8?B?dStPQkxmcVBJbldTZW9JbllNZEwwWStGbXBEM0hlRHFPU05iYVJDbTJLK0pi?=
 =?utf-8?B?VC9rZjhkdTBXWlJJbHVhU01Fbjk4R2taZUtNRjdwS1VxQWp5R0F5TTIzdFFB?=
 =?utf-8?B?VW9QOExKNGFld3FXZlQvM29CcVRwV2E4alRiclRtVmVHMWJZeE1pcis4RTI3?=
 =?utf-8?B?WGV5VUt4eVpUSkhVMFhVVFpZOHUrSkN6WVRqT0pQZjhCMUx3eDZFclVDQmhl?=
 =?utf-8?B?bm1TR3Z5TklJaWk2bVp4RXRmOFFSUXFJd1FBa1lLU2ZwR2J3T016MWxtMS8z?=
 =?utf-8?B?Zzg5NXBBZnRtOUJKZWsrR0Q3MWNKbHlHYTZwa2xpTUFqUzExQmhubC9QYWwr?=
 =?utf-8?B?dkQ2azBZMCsvQXJEdGtFYW14TDRjQ0dDWCtLVU5oSGNqMjIrTnYyWDBJd2ll?=
 =?utf-8?B?eVd4eVcwcFRScnRTcFM0MFJ3eXozNnNMallmYktJeUVHYTY2Rkk0QWNwVkpU?=
 =?utf-8?B?YUdzTUU1SldHcUZ3dFBIWEltb21oWUx2MUVBVCtMQXVYMkFkYTVxNXJXek9G?=
 =?utf-8?B?b0lrMW5EVDhLY3FaWms0VWppcGo3bXpoVjlPVS9HWUVNQ3luMlJrdFV1VXkx?=
 =?utf-8?B?eWZtaENvVy9iaUVJc2lyaWZKSXZHNmRDdGhuQUV3RTAvR1Y5ek42NUdrYk9o?=
 =?utf-8?B?NDMvTlQ3Qi9DM1ZaZUZSVFRGTVRTSzRkeW9RcHJWaTJzWUN6Nzk5UGZzMmtr?=
 =?utf-8?B?eG9nZUdaTHdWRzgreTlNTFh3ZzhhTTdWNGdHeVg5V25yU1pxUUdjWTdOOVJx?=
 =?utf-8?B?eGhuRmwxeUNuT2hwWlNkVU8yVTR5dks3NzFqN2JCMm5SV3Y2Y0RaaGlTeUZ0?=
 =?utf-8?B?WVdZMHYrYVY3VjV1eEU2YmV4WklNUFJENnRNUXEydmtueXVMNktKRU9hYmpN?=
 =?utf-8?B?SUQ5SDNMYm1BVkplT2tqVVBsekUzbllBUGlaQVN3ekpCMnFJWVNUMWY2S3lv?=
 =?utf-8?B?MFE4SlNLNzFYdUpmaWppajBVT09JZVVkVHZQbFY4NkMxTWRka21yRFZ5M25h?=
 =?utf-8?B?T3NPbVRzRC9Oc0EzMEZDbitTN0lWNG56UDkwUUIzUE1GVHlROFB6a29IaUVt?=
 =?utf-8?B?V3dqcUxMMnJXNkVjOTNrYXM5ZnQ1b0ZWOUJhWldHNkFSUnhNRGZpaDdFRGwx?=
 =?utf-8?B?YTB3eFQ4N0d5eXFoM0NzVHQzZTNhdTJUU2pXRTAwMk9QY0VsdlVrZXM1T1h6?=
 =?utf-8?B?Tll2TU1qMXZ4UXREd1ZxalRlOGlReVc0SEx4NmFNNmROd1E5K3FLMHE0MEZ5?=
 =?utf-8?B?Wm9MTjZaSHMyU2tBRzRiczVkcXg4YXhNejgrV25YbGNiSjFzbmxVR3F6b0wv?=
 =?utf-8?B?UWRKOWY3THk4R0lIbGE0M011bmpubXNmOXlTRW5SSXBzTk1PVllGVWw4YkFJ?=
 =?utf-8?B?VFJuZTJBVGFMU1RRZnllaTdHdGNEZzk4RUliNjE3NXRYU1dqNHFtYTN4K0xQ?=
 =?utf-8?B?akxEQ2MzWDdQR0hCeFJXMDB2QXFXenpXOCtqWUx2cDdUNlByNG8yKy9HditD?=
 =?utf-8?B?d0oyY0dxbVZHVEYwZkdsRW1zdVJMcGNKTlpIWFBVblpkaDB2VGdwNEFHQWdR?=
 =?utf-8?B?cHd5MWcrbjFUOC9nUC95NHJ4eSsxWW5LTjEzWDlnSnVwd2tGdU1lQTBYZlk2?=
 =?utf-8?B?YVZveDdGL1ZjQmNnRmVXUU1yVk8ycHBCYi90d0Vnc1YrOHdaWGdMRTVNWGdD?=
 =?utf-8?B?Q2xiS2ZydGxFczhwWStFeEJkdnhqUCtmUC85Q3dBZnN3a1ZDQUVKdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35be3d63-6bb8-4f3f-ed23-08de854f3fe1
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 00:34:15.5513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VlzCA1DtzRdn944/r098eknu4zbeUg1vl2mluImQ+HMKOIaZFRsZGHaeQWO3BLmPVgJjaTA8CQDAlnm6kuHc4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
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

On 3/18/26 4:21 PM, Alexandre Courbot wrote:
> On Thu Mar 19, 2026 at 12:27 AM JST, Alexandre Courbot wrote:
>> On Wed Mar 18, 2026 at 1:07 PM JST, Eliot Courtney wrote:
>> <snip>
>>> +    /// Returns the DMA handle of the command queue's shared memory region.
>>> +    pub(crate) fn dma_handle(&self) -> DmaAddress {
>>> +        self.inner.lock().gsp_mem.0.dma_handle()
>>> +    }
>>
>> Just noticed that we now need to lock to get the DMA handle. It's
>> inconsequential in practice but a bit inelegant.
>>
>> Since the DMA handle never changes, and is only ever needed during
>> initialization, I think I will just insert a patch before this one that
>> adds a `pub(super) dma_handle` member to `Cmdq`. That way we only need
>> to obtain the handle at construction time and can get rid of this
>> method, which keeps the public API focused on message handling.
>>
>> No need to resend, I will apply this patch on top of mine and merge.
> 
> Actually let's fix that afterwards, what I proposed above would
> introduce code that hasn't undergone review, and doesn't reduce the
> number of patches in the series so doesn't bring any benefit. I'll merge
> the series as-is for now.

For what it's worth, this avoided an email from me, to the effect of
"there is no such thing as a quick locking fixup, don't do this".

So, good. :)

thanks,
-- 
John Hubbard

