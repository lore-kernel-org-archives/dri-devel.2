Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E077606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NLAdGMi2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F43710EA07;
	Mon, 16 Nov 2026 13:59:27 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D9A10F1E6
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:59:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KpkAJPiuXWZZAE18LjAPUbTQthibgaR/4kCCXkBXtA90S6g1+t8oacKOwL/LB3kymZDU80I3AFw17Sc8siOswvLRrFTiVCYLVzUOVeSVo+OTfayiGKKSufpjp5LyujK80ZT/Hc1ilDlK0fpR+EjfjL5cVTUVIFTY7XLEKOfOauX13pLQCZFEq8oWPyRzYzDBw/9t2mL4347Wydf90sCtyd7lutx+1EE6tySFaXSBgLfpmvpUn0vp7vFAzJF0UESd8yxmJCWyKqaTs4QE93bJdgjs9Pzh/b5cKhGkFrZegPmadAI+TRm2UAhTyexYbBRhzGxM0biZbwKJFt7vUOe8eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TexCL98d8syyucLMDMKp/F1oiNWlvQpNweM5cB0/3M=;
 b=cd+VUDF6chXn3rPHzc3/WKJj3M23MLRAcpO33x8ZoJCwwPikrNpV33Iy5aEinODyfC0DNBPs9vxPLZWMb/tLR0oV9Ry0EJFynfgTVd4kOms4/cABrm7r7Hp0UHFCA5zSb/0ZWMBl4SwW0lFYxFgadcwDtSMMWmckzBPakEpAKKvzUNVkPD5TV81RIwTjqOnHxVSUX7ijJ9JLLwis+9UP6IygezcfNGZc4x3N/1GoOE8r7q+V/qBqCr/8ZWWXZcJFiaJIWoYr3He2kcypuBBV1NS6mjmkbwEu1KtxhXrLL15WG/9E57/e0ZC4rfiQnCLkcTWEwvgFIO5S3feyFbFTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TexCL98d8syyucLMDMKp/F1oiNWlvQpNweM5cB0/3M=;
 b=NLAdGMi2IQqFOJINENpGVQzNCf49Ynyn2UzjDLgUxt1aK+I3I3W3Z1ANIjh/D6IpzryNNdk4tve+1NLSLpMqSEc9hyRvrETuLawCjlzVBw4BSZxuDZ5oWoB5J72lmvZwhdYdBZPzDnWyw3q3nnAE9Y26MzgoWIg7rnoscOlhk9h5k+2jokVhieQ0tERHoYNh6Nm9EpxlTVQDJARSSE9RiAmwOPvLMAhfKIn81UcGdOncI09HSScPdWLqwcGrOdgirkeFBy9zOCHw8iL6nWNbjx3V3OPCp6+tEEd2nBY+fmNPSg0KmFYAr6CBiumFggsBvrjpH5NLWVmNX8uvQolbBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:59:12 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 13:59:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Nov 2026 22:59:08 +0900
Message-Id: <DMWOT6PLCRCS.APUPR6L0XX3M@nvidia.com>
Cc: "Gary Guo" <gary@garyguo.net>, <aliceryhl@google.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] gpu: nova-core: use pin-init self-referential
 support
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20261111161935.750047-1-dakr@kernel.org>
 <20261111161935.750047-2-dakr@kernel.org>
 <DMWH39UWW4KZ.1C5B2M4W1V3CF@nvidia.com>
 <DMWM4KAYL7PT.2ECY3BSNIA2P@garyguo.net>
 <DMWNA84XI432.TJG95PPPMGPR@kernel.org>
In-Reply-To: <DMWNA84XI432.TJG95PPPMGPR@kernel.org>
X-ClientProxiedBy: OS7PR01CA0086.jpnprd01.prod.outlook.com
 (2603:1096:604:25b::19) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 5176153b-5ea5-4b11-216f-08df43e9ca9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|1800799024|376014|7416014|10067099003|56012099006|11063799006|4143699003|261021135927099003|261022075727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: guMq1ElUNuUOMcbnV0qnix+VAJMo2+rbIHQegT0P6ublzBReQDfEQL2XdT9g21kPs4WhOkxVLsl1NWMr2qcliLJ+Qu6Ccgp0lWjXLAroU7SAHAHx9eBATHges3iGvmntMa1OkMKoqpfpXl7LT7htozObV31MAgasLlA8sXTebVGz3N/QtVHN6Sx5qpKE7XCHQc2YfD9Hf5HNzyu+O1ElP1xE4w5ICkwCs6Iop8uHjXn95V6+9lyJve96Sc/O7QUyvae1V/J3CC6xPndGo15E5V+bZHpdqixuGw0kjjDAE3sX1gpXZx86UxFkg+Ko0dXCM28c77Ig5fpCHwNdoQAmMOiW4WUbUE5lODbwqMj0I3wD9Uv9gC8idFP+GEPcsU9reX9D+L9JIBsiFuwj/oBshLem7XKQyrG9O2Fm5qpAkPe+SMY6PZbZopIYt5C6GJ8d5g1ei4XIPUjenKRqfYoHYcbqssH8HU0GsjuH2twWJSMzyXjW4Ii1LRpr1K+TwFb/W1Ci8viKCqr+a+TJVD0uDgxURyfkPoQZjrlCS1KjuanPuYIT8oR262Cu2xQxsVHH3/xMqbTjcw46GupLMOVxAnnWo6SI7ePJneAM2St55ralg3ujTRS68162Fxx76aWfVQ1a4LMc/pq4pZIVHvsXLGTRxC9oXpk597aVy46Gykg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(7416014)(10067099003)(56012099006)(11063799006)(4143699003)(261021135927099003)(261022075727099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUw0NUdHUDAwVDExdzV6ZWU0Nkp3VEhkYWFOTldyUUYwRk5WYjZ0ZHdCOVBJ?=
 =?utf-8?B?UGlqeVRMM3N0Skp3cDlGYlk0ZGZ5alVWTXNKUEhiOVVaaXkrWkZrTCsrYkhU?=
 =?utf-8?B?K0FFNjZhWXRTRW44NUx5c3R6N2JXc1NzejhwWW1IZUJJVlNFd1Zvbnlxbloy?=
 =?utf-8?B?Q3pCWWRZVVA1S094am9iTlJ5VWhNRzdMeW92cEUxK0xzYXpjU1ZZSjNKdlpn?=
 =?utf-8?B?dkVMWmJDVnQyTVJxemhSQ1NTR3V5eWZGUW5lUmxjMlRiRDdiYm85MThRKzEw?=
 =?utf-8?B?ZFZnbGdzNVFQeFpJM1JVMW5BcVZ1eUpva0FVbjRaSm5iTS9wM2ZKNHg5MG1P?=
 =?utf-8?B?TkUxdDhDUVluYkVmd0xZSjRkbjRiVUFWY3d2QmlQbUtXdlM5TUpkS0M0V2F1?=
 =?utf-8?B?VTMyeGxNYlpyR2J6dTFReWdpZ1BVTy9VYm9pNkFWR0MvTHdwc2JUbmpiV1hl?=
 =?utf-8?B?aXVZaHl1ZmluUmo2KzNJSC9nZFNRbHlWeGo2K2wrQXNXRXM4NVBtMUk2WVFn?=
 =?utf-8?B?ZDZSNU4xNGVqWHlLMHRuR1AxbWYwOVpGdzFoWFNYbnBvVHhWTDBVbTJPUDlB?=
 =?utf-8?B?U3FYNUh1dlAwWS94VFpkZjF4bUdDVzduME9ZMG9xVGFaemJ5cUVseDZoSURI?=
 =?utf-8?B?anFDZ3BOQ1M0NTNkT0cyamsvTkZMalVRNGtGaVVtL0YwaCsrVkFjbGZHMnRD?=
 =?utf-8?B?K09LMnhxWERXUHB2SkNlSHdXNWY5NDE1cmtxTFFXb3NWZTBpOEdLOUhlU0dx?=
 =?utf-8?B?TFJrcm03djJmUU54cUx2NXRxNkhBSTZ6ZVJUbDZyaks3ekdUeWx2Q1VHVGtm?=
 =?utf-8?B?aktLOGUwOHRqbktFTzBGRHdsbXJtdCtjOGdMU0hSeWJzWFo0YkJxZlZQdEZv?=
 =?utf-8?B?blo3Qmt5Slk0QjRncXRPZ1ZWMGQxRmRVRmdNRkFaa201UzZZb1l5SElRZ2ty?=
 =?utf-8?B?WTRWSERCeXpEbStGMkRlNW00dzNYZVQ1NEwzOWV3UGNpRzd2U0JtMVJtS01N?=
 =?utf-8?B?TTFBUnluTjZYSTJXV25CRGw5Uk4rdU4zeXg3WklBZmJHZkozOU1Db0RVRzRB?=
 =?utf-8?B?Q0ppTCtlbllFYm1QRFFBVTZGT3V6MkY1M21hblQ4VlFaaGdDNERVRmI1Yll2?=
 =?utf-8?B?ZlZYWGVDemlwWnh6US9XSlZIelBoQU1vN0h6NTRLV2NNK0VqODRRSlhkYVVm?=
 =?utf-8?B?dWpDdWNEdFhRTDVaQnVlaUVPelZRTWRoRGRwTlJDQ3RnWlY5WVJjc3Z1citT?=
 =?utf-8?B?QXAwNXlmQlBGRzFEbzBETGV1VkI3R0Y0aTRoN3p6RUlaN2hSUlg4NlZnd2l2?=
 =?utf-8?B?STAwOFd1dkx2UnJHZGhDUkhZNFhTelE1WGo4R2ZFM0JaajVManU3UVZRQVBn?=
 =?utf-8?B?VWgyemUxdWJNNkJuRmg3RjRvd3hOY0tIKzB0VGx3RFE0UUVma3paVUxSakFT?=
 =?utf-8?B?eEsyaWNjcDNXbW1zUExXbGM2RUo1ZUNrT0lSUE5QRDBCQkJ3MVROU2cvSjJ6?=
 =?utf-8?B?bE9acXlxR2VSVGNyWkMyd1lDRUFvcEVqc2xqZFJMekxBOUprdVNYMzd1V0pu?=
 =?utf-8?B?cjUrR0JKc0JKdVB3TEVydnNFWVJjeVVQNndldTQzL3MzZmxraHgzMTJPYjVw?=
 =?utf-8?B?eldLaW0reHhjei9pSDNleDhtamxIckIxRVRXa0lSVzhiektKQ3k1dkxOZVQw?=
 =?utf-8?B?U244Vm94SGJ6MnIySk1KSXBXclFPekVUK0licitwMHRBTm1PeWlxYmhSVTgx?=
 =?utf-8?B?ZVNJTHJjK2V0OWUzcGdqb0ZxN3hEL1dOWnJ5UVdwUUJwcHY0ZXNOUG5nandz?=
 =?utf-8?B?UFBGbW1GNSs3VzBRRjBhTTZ3QVo3Z29FQ2lGRjVNSit4YmhlVjNYd3NhaWg5?=
 =?utf-8?B?SWJVZERtRnJhLzBxYUVzT0VudWdmNGlGTnVQVXBHVTVtaWtmc3B1UkU2dFdl?=
 =?utf-8?B?L2xJSHBPb2h2MVptMFZsQ29mZ3J0dmtJa2tHUFdDUlJWczRCMVhwTzNDSGdx?=
 =?utf-8?B?SEhadjg4SGFJYmJzVy9UbUpXYmE5RXoxVFRIMXBST0FzcER0R1Z4K2dZeXQz?=
 =?utf-8?B?a3NHL2FxVW5CMHJHWmxRcGZaSVcwNXd3WmZHUGtIZlg3TzZEYUk5cWNBSE5n?=
 =?utf-8?B?OXprUFBHRG1ob1RJL2c3TEdDQTFDQWlGZHRvWDdQYXVpeFRlRTc3dUhhc2lM?=
 =?utf-8?B?Q1lOY0UrOHl3cmVKVi9sVGVvY1Nnc2R4NEtma2tTbCtFUndFekFqTjNKRGNZ?=
 =?utf-8?B?Qk1GYTNKT0dwNnZERHRpWkVhVHR2eW5NR0RzbVFzb1JibzhuckpSazdET25o?=
 =?utf-8?B?WlJzNGR3cnBhU2FON1dLT1F0UWpIdUdNT2s3V2tZeG5UakJrVUZITlc1bGFo?=
 =?utf-8?Q?LeYdMIm2C9A9fF2F/vIukPDVo49mSVHQ/jEEefyVKisxF?=
X-MS-Exchange-AntiSpam-MessageData-1: L761wtWtakK+kw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5176153b-5ea5-4b11-216f-08df43e9ca9e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:59:12.0225 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I1eYRurS794gXpyz7QPIpwroXBQ/5YRTu9y/NN8NPlNN4L+Pa3yoM8BiJ/6jpPHsj9pguHxzFHSLKgHo6RQ2+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 16, 2026 at 9:47 PM JST, Danilo Krummrich wrote:
> On Mon Nov 16, 2026 at 12:52 PM CET, Gary Guo wrote:
>> On Mon Nov 16, 2026 at 7:56 AM GMT, Alexandre Courbot wrote:
>>> On Thu Nov 12, 2026 at 1:19 AM JST, Danilo Krummrich wrote:
>>> <...>
>>>>  drivers/gpu/nova-core/gsp/cmdq.rs     | 16 ++++++--
>>>>  drivers/gpu/nova-core/gsp/cmdq/gmc.rs |  9 +++--
>>>>  drivers/gpu/nova-core/gsp/cmdq/rpc.rs | 11 +++---
>>>
>>> The changes to these files look like they are a change on their own;
>>> they are not using the self-referential support but rather change how
>>> the queue lock is acquired. It should probably be a separate patch
>>> before the rest (which would be the last patch of the series).
>>
>> This is actually integral due to variances, as the existing code more or=
 less
>> relies on cmdq being covariant unsafely. Pin-init is going to enforce th=
at so it
>> needs to be updated to use existential lifetime to make cmdq actually co=
variant.
>
> Yes, those changes are related to the use of self-referential pin-init. W=
e could
> technically introduce the with_inner_locked() helper separately, but that=
 seems
> excessive and creates unnecessary churn.

Indeed, thanks for the clarification. With that cleared,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
