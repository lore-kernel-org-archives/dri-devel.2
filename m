Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837E8C4453D
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 02:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D228F10E50C;
	Thu, 23 Jul 2026 02:56:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="b4x9oMuP";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013023.outbound.protection.outlook.com
 [40.93.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E6810E50C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 02:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdpRuvsdgtouBKxRVEvXwsIJICMyBNRK4ZvZh8DD055Vvr1hSLt0Xk5/naYlUrHkMmLyf/5R1GvWt1QG2M+4xoskC5vgZmcXZ8w4KsJyz4QUzWtGIkMsciR/Fa75m8Hvm2q8yQusTBfbB7VpUGN1WKkxOIhD2zmt+MULcfMzxnABatPoEfyGD7gpEOr+R96RfJZQI4RrYPsX+Qaepu53OuL5aGBhokbkSfnqngt+ZZ+ajo4lVlw6AzYFcrVwPkodFgn02ICybwlvqWu+M0CIZAezpPvRDewaQA983Z+rPLu1h+33ZqynZWoYOq3Sfveo2Hmvb1YwcX6JZbs7UQGJqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHOxlRcoB+a9qGArXn3jiA2Lwft0n/DIXiEdIobKRNI=;
 b=D6WiXnOHGvtd4akE7vx4ZwToqLOACg62AjU9w7Tiim2LoMyGkGq5axgWhPdK7RcnRshUJfmcRmgz0cy3FjzIsHvW7RMUVC3AsSloPM+jh4lkNAS2ycpdEisMUkmIhc8VHj8ujE732pnYoRJC71EsXLy/nmCdIj5P6te7RIBkD4p/JiTxh7fkROkXALh9xn0Mq381716AJuRNDGnze31y99py1Z4QZs9Zw69tIsEAJK9OoWTLs6XEXvHgwTsAvPnZ4J5NLvwfRwhmpA6ejTCMczJJ7b85WBdWsOTnsNZMKFMp+/GY3DLqXmTgHSDmPGtjBQDUS2wL7LTTePfF66yAAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHOxlRcoB+a9qGArXn3jiA2Lwft0n/DIXiEdIobKRNI=;
 b=b4x9oMuPH+Mrplxp2GHg9ShqZcSyhn4hHHFJjC61SMlHPziMdNJVylc0Hy+QIjyyhY8Eb17T1c6tDXWUJFSzvI3IPhq5w69/8xI1j4x/t4VIXADSAPBjGR5xwgWNi5imtJCtdpNJG1K2pJJx3M7zq5QdTWrmd5mEjiB8aOoK7OfjNVoLsPNYw/q8hdCb7tgjvO1tRb26oRT/o3lCR5S5MRH3p0kq9tlEeEYtSeOAEHWUnSUmHHYfw10egStEPFpJ8MPYjUx4gptsSgRqRQyWvmxjhwI8PVOdGwjmJrpRGBfNAvehfm66sAJNXPLIJPwHxA3DZnE1xsMG0U6AeltWPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 02:56:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 02:56:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 11:56:03 +0900
Message-Id: <DK5M2AUTHL6C.21Z6JOV2SBK3M@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 03/10] gpu: nova-core: gsp: ensure lifetime for FMC
 boot DMA allocations
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
 <20260703-blackwell-fixes-v2-3-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-3-8e3d8bc32bb9@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0034.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc4a538-b0ac-49a2-ae3f-08dee865f0e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|10070799003|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 8AlsK2mGREZSLbeRR9sD+djuSL376kj7cTRHP7tbUPqBHbn/ngcdLNO4WBvJs/vPw3Oarbp1aU9XLHgH9hov7rozmjiuJ2fd1sxJNsDLFDxP+eF4FogtoKPvnvy84Aea63faHRgKx2xrJY7KNqpkhrKLj+UDr7Xq/EBHUVqRH297wiQwpkOwVLfiE7yPQU+xjWE5oxaYSZhuW/OQ+w6zypb9xCGGGxOh3ZD1og/Iv5CJ+ZKSP027uKHca96i5SFGbj36F4dILMj8tDbu2jGeTHfKEj23AZWdPNocaZ5vI1bRpPjlTzHrmmkA/vb+QzpStm/7ein+MwbEQfmKRgCVeLlSlre90+pvc+VnAeh1OG/b7HhUfs4AsTqNIZGwXUY9WNXaJ6+n5nKMjjLAaUCwuAel7GZsuBzNWW86XV6vgIzmVV/J5ps3e7UnG4rXhxdYByI0EmWKmPUG5WH7KbzaUMgrmYKmZ4SPj33MRKmLwD8IKex34tVXIAl6sUb2AjjLwd8nH63UWHrX8vHY3JLXDWhfFfHLyZCY7+n6CHG48ZxjHfsK1P2Ib2a+UP7BCaHpyYOKBewl7b11UFjadtYOVtrGvlEVo9PJBT4e/hZPaiUb0Gq3DBaF+1v3mXdbopaFmG0nj3AGxqULg/7yLNbaD25TKGhQWZG2KpLRGqyUH08=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnEwdmdWbWNBa0lJUXU2blN0alVRaEozaE9oaVA0OU5qZUFKMzFQbk5FNnFF?=
 =?utf-8?B?VkpyN2hmWGt1blc4bHBlYUJ0ajYrVW5kOFZnVkkydWs0aDQxdjBIQ1I4d20x?=
 =?utf-8?B?VWtndkY2TFErK01yWXdyWkhCd1ZDM0JTWkVIYWNxeFh3L0l5ejhrZ0JuTEVZ?=
 =?utf-8?B?UWRYeDRJTkpjVU5la25tRFdLQ3ZhWk9nV21OUlhJRlhWWEVNdGlkWXZ1WTFP?=
 =?utf-8?B?RlpkcWwxQndDTmxVUmJCK1JYUVdoOENRMXhRZDhWUnpHV1JsVUUwWk9adElW?=
 =?utf-8?B?aVI1MWlYWFhkbURINmEreUFlK2NrUmE2dDBjQThOdFo5VjA0TkpDUy95WDkz?=
 =?utf-8?B?SGs1a0dNVXFEdlA4QzNMcDJ4V3ppRlRmQUl6cWY5YWxOMG1maFN2Y3VmWkpS?=
 =?utf-8?B?OXZFN2FSVEppQks2RHZySk9xMFZ2bnhIRndhWVZRcWxXRTZ0dTlKY082NzBj?=
 =?utf-8?B?dUliUm42dThYZU9NSk5yZG5vYVhpSEhQRW12TVR3WTltQjAvRWRNU24yS3RO?=
 =?utf-8?B?QzVJYkVlelRLQ2s1NmZ6ekozdE94N09IYWNMUm9scGM2SjQ3L3g5OGQveTRD?=
 =?utf-8?B?Q1F1V3ZwTDJLQTVOVU5XYkxza254bENheDdlcyttK0IyQzJpdFJhaFNneVdW?=
 =?utf-8?B?UFRDcDREWDhNamxpRXhVSjZON05mSzI0NFlBUjlMY2lRVGZqSjhHYjNzTW1t?=
 =?utf-8?B?eklycndWOHpWaDlhdjI4d0ZoVFdLbzVkZUNxWTVpRktPN093T0djWXVUZlZu?=
 =?utf-8?B?ZEVPVUMrNnN1amoyTVJ3Ymp2UFh2U3pqQklJS28rTWUzZWY1aUdpWUJnMWgy?=
 =?utf-8?B?UUh0Q3c0OFdFNExUN1FQZ01Zcm9Hd1g4dVAzdUh6OWNLbXJKcjNLK1lQVTQr?=
 =?utf-8?B?RGFwaTRmNURKQm5ZSm5Zc3QyT0wwa2VWbXJFSGc3QUtkbnk1dSsvZnZ0dUxL?=
 =?utf-8?B?N0U0aU16UEZQWmZZRFgyMmZMUVNRVVpVbFRQUW1temZtelVTOVVLNzB1UkVX?=
 =?utf-8?B?MkovcHFqV2dNQWc0VVdJMHhURjAzTVZCaEMyYkVldDJ1UURPbXI2NHo5cmdN?=
 =?utf-8?B?Mk5XQmdqdGJqYUlFYjc4aDlZanlQbm9RbG5xZENXOHFKbTlDR09acjdMWlZU?=
 =?utf-8?B?RXNyVzFqUDhNeHpPekdzMit2dEpIS2NNd2xGWnYxb3hBYjV5b1NSUzF0aVB4?=
 =?utf-8?B?dnpFS0pnSTAwbjA2MUhTZHlMSU5KNmpIbDl5N2NuTllNWEFubkR2YnRCUGlB?=
 =?utf-8?B?Nm5WblluUDdOMVIzaUlvSnlFODVWMHZBbnR5a3RhOERNRXQyZm9lTDRVVTVO?=
 =?utf-8?B?QlAyVkJkM0NVOVgvQVJnb0tPdms2bis1S1hsOGUwb2JDenB4ZVNIaGxrZzJs?=
 =?utf-8?B?Z1k2ZkVTK3dRY3c0ZmtpTjhLaHlnY2ozR01QYXk0RjRoMy9OUGRac1VCV3dD?=
 =?utf-8?B?YWd6ZVViUUVSTlBPa1BoMFJ4NWwrd0Fmb1hHOEk5alRPUlIwR1dvdjZJWERG?=
 =?utf-8?B?dlpDTFBDUEJ3Z1JoOXhnUytHMEdXb1FvVWREeFBnV1pnY05ZVXFMUit4Ymdn?=
 =?utf-8?B?TlhtOFE0dmNGUUxKUGlrcGNtNHl2ellHWm50UGtBQTlaL0dITzVXdU1vaTQv?=
 =?utf-8?B?Z0pDUDhLeU14MUp0bVczdEU0Qkt2NVRGUXdCMnpvQjFrNXFaQ3IxcEp3VjlK?=
 =?utf-8?B?QjhyVHBsc0RRV2lycTRja2NlYkVqRHQwWjM4b2lvaU10Q3JBajV1eGxlQW1m?=
 =?utf-8?B?eFhRc3RhQ204d3RLb3ZWSnBFWEtZTTBVYnRkd3F5RitMRnBZSGdlZWZaT1hP?=
 =?utf-8?B?akJWL0kvdzJySml5L2JVTVdvZEVqUkNHcEdQejNPWlpEQzJvV1JGYjhXdlpm?=
 =?utf-8?B?S3ByMG5WK0hhaWd4OWRaU3FuVDZOcThSL0ZGYkVhTUpvVHRuYy9qakZ2aytW?=
 =?utf-8?B?TzEwR2RPMFVyL3pBSmc0d01MV0toSmt6TThOcU9SSXB0bkZqS2lJcWJLUlBW?=
 =?utf-8?B?QXQyZGdRSE5pQ2lZa2lvLzZvc0grWis4MWhCSnJDM200RGlLbGo5WlRWSld2?=
 =?utf-8?B?RW8wWXNSSytmODVValpobTdWMWpjbE9mTWRLTHluanpnckVqYVZSbnQzaUtR?=
 =?utf-8?B?QUg5S2N4OXFIT2tpMk5sN3VmemhLclppc29ETGVQREEyaHE3U3pHQ3FzRVow?=
 =?utf-8?B?Z3NGZi9ZVHdKcXJwY1pBUEVvWCtYVHFzMEo1RFhKUE5GMjNjM0hCWktUeERO?=
 =?utf-8?B?QVlOM0NzL0E5WlBjaldaVFdxRUZEaERzRkQ1NElUOHBnNmQzYWMraXpoVjVK?=
 =?utf-8?B?eXNCalZxcHI0QzNLblVCbEZHL0ZqcldWc0RaaGdlMUloRTQ1V25SWUVKSFJj?=
 =?utf-8?Q?X/t1N1b6vRTvNvh2/UVacouve73wtSPdVz/cgkw9DX4ub?=
X-MS-Exchange-AntiSpam-MessageData-1: q/n9nRpcuyQkpw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc4a538-b0ac-49a2-ae3f-08dee865f0e2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 02:56:06.5229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xC/dgSDOokBbgDq4bvhQMt6VwzU3Fg6oMAz/wHmHeB8zCeVYWDxDlEZyPdBM0a85DEMsgQouHJNqkF7ql1LVYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
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

On Fri Jul 3, 2026 at 7:22 PM JST, Eliot Courtney wrote:
> Currently, `FmcBootArgs` takes DMA handles directly, rather than
> references to the `Coherent` for them. This is error prone, so instead
> store lifetime'd references to the `Coherent` allocation.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Pushed to drm-rust-next, thanks!
