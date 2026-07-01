Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658E1C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 03:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92A0F10E2D0;
	Wed,  1 Jul 2026 03:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="UpdWsuk1";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D490610E2D0;
 Wed,  1 Jul 2026 03:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fw4XPk2nnPAbUhTfiIkdN0Nh+L7t+vrOBgi4MjtDf4KOrimDDjI8XYqkNVJRXxFAXPJqOo0iFvlAEOuH29BRSnivdd3uK9+zjVGofe/n6e+SxGintFe+adVsxJeCj7gGimjv9b5E0dFQ3ZqFClg8apO2DOLbUUBccuKX6uV1dNqZz8f/PBGJQIZTqtal67yROLMcukcxlKDDO84NOhje8+tElnfD+WHYmNy2833Gtdou+kz5EBicnf9oL/htRQ7w/0U7sJdu2vx9ytiW1xDMHPmbbJuiWYMmZM/uYjEAUwvF2jJ/qmnypWo83y7kI9KAeCIDIMrLT894Ulx9I5JBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boBZArJFsGT2fseysC3a4mIyKVE8l6fvU/2urTbY4Zs=;
 b=HhmiyeJfJPb//9nTlCgffQ75MR8YzKW+tFeLos4gKPKIf0SGNFTNfdeFTNuvR4zECJf7433OUwacEj/NYTLSV7xRsr1AWmMKzc8fV2Wmvgkjds3MzqmCrexElf08LHqVpNy3nUO1wEX6yRF1m/mVIr/HPKCZqXQskszJfMjHHyp0S4eZfbR1p23UhC6iiWj7f5oVP8k+1MCCHDUl72FUQHfsg3PgyKjvzjuRO6e9u0xTo7pnhwJ5GiOSb/dFFpEMuCYicSpoHVM4h4Wiwtziwquw5kB2KIzLCjaF2ch3AMetfLhSRcY437ngFQGrj1RtpKa5BV9RXWtuY9WCPfrP5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boBZArJFsGT2fseysC3a4mIyKVE8l6fvU/2urTbY4Zs=;
 b=UpdWsuk1UaqEPHNp9uB9AMP5Ydw3L4hGD5oqzANFhQQCMj04xQ/s3W8swyOl6RkUbDTQZor87kj2V/KwyHNXvdKYHIOXXORrUEv4oYJ7VJZCsCOizEFU6w/3+TdQSKa2iyWwEsZk66p0BD4cV2IxAON6vw3CcEn3hP2nnYFfHg1cXJs+4Mfu8pe6hw4xqIMeZuCyQkHN8P/yH8v6c8QDhxuMjodHVlIFm1OG3shvEWo4xfdmdnRnIOPIzp0x2si38hIM32PNDqWmX1D/FvPT3oB+nX7VboSAol5a58QC8LEFzOnTmwzRsVatQ8fjuE6aShcVSl+uHXkeSImz0f2ZAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CY8PR12MB8363.namprd12.prod.outlook.com (2603:10b6:930:7a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 03:57:59 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:57:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 12:57:55 +0900
Message-Id: <DJMXLORVMH8F.3G6UIF4P2CSZ@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 04/13] gpu: nova-core: gsp: pass GspBootContext to
 unload methods
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-4-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-4-5539d8469590@nvidia.com>
X-ClientProxiedBy: TYCP301CA0065.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CY8PR12MB8363:EE_
X-MS-Office365-Filtering-Correlation-Id: d3525dba-1249-4c0f-949c-08ded724f0c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|7416014|366016|1800799024|921020|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jvIy8jZVYAJxPNZyBhdwFYtFMFc5SIA7BsCHvigDxacj4uzNpPY44MxcLWag6NcdB9Ro1/UHlHUh5NxwlLv3gzsIUw3cwjz25OYgRj33M9ECL5I3jVBwPZwAtfy6lm4RhqZv+ilnLmD2Idezc8p4XTb0nx9ukqu02Ob8HoRf98sUNwyhLHmInHm6x359qe++Rmi9QHUOVFAM31d6LqNbfUFYfQVWz5mGIIHtRWXj/wTLdpwuU/W/lQ5qzAdig3iKYLqaXRzC8uwuOAFfLlnxfpA8s00DF7PSyIkgNr0asiHlm3OCxuzbv5ScC9ufuDXu7RwzRbOgWOyCi6XrvYQQ3NuOagdR7aN6zudcolYPmchVmytr+He2b8hLRE/M5AhsJfJIOGwU1fMPcS26XUNqJvbyE/prCKyNkA7Mgc0orBVd+ru6xRviun9+UC7x/qW5zYCc24dup1ZpqtD9/l7IQ9skj0m1oqODmdrhH1XGWFzr4YCUuMLTM0+QMWaiCYKwwzDOxP7+G46RZLulzGfzd6jlFt3kRD0k2yA7M/Vmj7/wez7cnmdLT34jLW5gvaWx+wEWIO0JSeofPVLujyODuf5nJg/mGiV1LNIxKbhmpn0ruNPL3kTLSTLzapcXGvhdhn24nIqeuCcr8R2rt+BeAnoqldmwK2O3m2mXJjKEaILtKySnQdeRcJNKGM3H9pfBVuaqcj6eYzQlSbNpu/8+DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(366016)(1800799024)(921020)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG02QVRpSWswVmtONFBaZ253N2g5QU1Ka1hjOGRUNnBWb0ZJZkxnem9hMjdG?=
 =?utf-8?B?ZEpGSWNabzJqMEZ4dzNaNXRRYjdRWUM1Q1VHci9hb3djSEJpdDRkMDNSdXEv?=
 =?utf-8?B?VmNsbGlxUmVRUndQUFpNRzRKNkZmZHlJbkdwSG1GNzQ5SXFvV1hOVnlIend6?=
 =?utf-8?B?alJnN21nUk1yd3kvR25Vd0lTV3JsVUw0em9BdHpmUUk2dnhWVmFnd2dURmdW?=
 =?utf-8?B?dFhReWc3eW45bCtUbWNsVmdPeGZJb0tIeURudTRTVENPOXFIemNSUFR1ZGdW?=
 =?utf-8?B?QUwyN3hUQlkyNUZJL0VCZGRIMXZXZVpjUGRVaWszeVp5NVluUEJzaVR0dWJl?=
 =?utf-8?B?Y0w0N1VFdFRTRzZKZURQYkFzeWFxa1M2Rm1XNVlkRkFVcTBUSkVYdHJsR21N?=
 =?utf-8?B?SFUwYmxrWnRSZHNBLys3cGZzRW43WFhYQVJNQ2drcHRiYmxKTFk5VTlBRURh?=
 =?utf-8?B?dDNRa1FkNWx4UGtJSGNqbzd4WXhTelRnOXRUdjlobVRsckRHVjJFNVFqaTBO?=
 =?utf-8?B?VnczWHA3M21mdkF5M0NYSzA1ZzFJRlZYYXZwYU9VZGxkL2lpajh6YTVSeEZS?=
 =?utf-8?B?eEs2N01oLzk0bERQRWhzcXZlWGRMbDExaENldm1YZXZZRHZudlBUamtGRFls?=
 =?utf-8?B?WkFxdDllTDhBdzZydkNkWjQ3SGdJcjk4QXR3VWVaTGE3OS8wK0EyeGdVNjRa?=
 =?utf-8?B?cmtTc1FRa1dRcnltcEtIWmdoMjNqWVR3T2xMYVFTNWM2akEyYWVXa3Bxbzll?=
 =?utf-8?B?amd6NVFueGovRnVUUFVYSEdYMmNMQ2lWRHpyQ3JReDNvRThzdlU5NkJ5c29L?=
 =?utf-8?B?cTRQa3B1L2EzMVZWMHY3T0NhdHpGTVFHcGpxeC9BNDJ2c3dDOHRSbGIvc1U2?=
 =?utf-8?B?NmtFL29pT0ZqWE4wNEFvNkx2ZjQ2WFE0YnFTekozeE8xYUNPemREOUxDSHN5?=
 =?utf-8?B?RWlHakFCQktQdjlpY25wRDVwVDcrMzNHejI5M1VaaEVKdENsWU5ZU3A2VThr?=
 =?utf-8?B?QkM3WTFoOWRZSEpNS2JaUUkyV2pQaGhpYTNJK0hpNzJNZlY3TDZ4TU9OYW9p?=
 =?utf-8?B?ZEJKZ1pmb09BVmd5YlJPQVdJZ2phRkQxbGY3NlB1eUJDSnRSSzR1S0lqV1Yx?=
 =?utf-8?B?U0NKZmU3OVE3WE9uYVg5WE1zSnRrckdvUWsvcCs4OTJQRktXdVRlRzk3Sks3?=
 =?utf-8?B?QW90cCtUTlhDaWlsRHRoRWk2enRHYlliQTVxbmwrZTI1VFJSWEJFcHNmREt1?=
 =?utf-8?B?T2F3VktnTklWWGJYZXBRZ1ZLdUE5NlM1TVJTZW0vZVkzd296SktmNGg3QWN3?=
 =?utf-8?B?ZzQ1T0dHa05oaGNicVBqdWZrK2VLOHpldkMxMnc0Zk9EbHkxSGNPSXhSLzk5?=
 =?utf-8?B?R3RHNzZ4Mkp4Vmk0b0pHenF0VHFSa2tZWVh3eEJicEthdGoyb05SWnNEakE3?=
 =?utf-8?B?bU1sL0ZsM05PNjJLR1JsdmdIZEg4QXpmcHcxYXJIWStuNU0xbUFlVTlISGYy?=
 =?utf-8?B?aHloc0xxZExMelNZdzR3OEl6STVydVRQa1ZodEszdDEyU1lER2hhM0lzSUhn?=
 =?utf-8?B?Ni9BNlMvSHYxcWkzWEFuS3k5NDhFS08yL2NGK21lNFh6b3A4TTNHM2tBRVJ5?=
 =?utf-8?B?eHJuMzdXdGIyWkJWTGtrbDV5aXBtTEl2aUtUYmlvcWVJMUU2VnVCZmZ5bWhr?=
 =?utf-8?B?Q1lMekNJM0x5dC9DOUpCcnNOa3ZIci93VGdBNkRyR0l0NUh6VCsyK1c2SHpr?=
 =?utf-8?B?QVZSL0RCVDhoM1VEWWNjNDFJMzEzSlY5ZnEydGhBUEI2bXpJREgrelNOQXFG?=
 =?utf-8?B?cUVwMlBKb2w4RmU2UTlJWllzbWYwZVdsV2VXZHVHSUpMdXpxdlIzL3FTcVNC?=
 =?utf-8?B?N1FkcEIzOXU5YVpaMkRpYWRYYmNDV2ttamxqeXRlZktUc3NSRFd6eHFRRVRm?=
 =?utf-8?B?V1RFRjJPTlI3cXFLa0o3T2xZSVhTVkFQRFJMeEdqaFNQYnZTTjFWaEplSTF3?=
 =?utf-8?B?eGpSUStxbVhCcDlLdkNOZ3Yrcm9OcEJNRFB2ZXd1TnFpTzZ4UFpVQ2hTQ0xy?=
 =?utf-8?B?cS90bXUzMkEyV1lKVDV5b3BhSmhMelZQeWIxNjFWUEpZQkZ0dlhEdXdPRkFR?=
 =?utf-8?B?OUJGOG5LSWZXQ3lSSlhINnRpWkRMNzB6V2ZxeEdzSUJuelRBdkpvczJ0aG1Y?=
 =?utf-8?B?cC90QWEzMkxpQVhoeFZqWlQyK1VVK2czSTFTSkJacXBHSkI4Ri91WXRVRGpD?=
 =?utf-8?B?MUFuMXBHeVVhK1FtWmk4aFc4dDIycVc1UkZYS21OQjBWWitMRTJ1T3gzZUZw?=
 =?utf-8?B?RFpXdVVxVXlSSWVpc2ZYUmJjaHMzMWZPNU15U0Nib01vREZzcExrdjJzUmx3?=
 =?utf-8?Q?QQ4tEBF+pLNvPFGdvcYdznDhsPlhVAC+Popp5qBBoEjda?=
X-MS-Exchange-AntiSpam-MessageData-1: uyffrm3RS6sCPg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3525dba-1249-4c0f-949c-08ded724f0c1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:57:59.3096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVZX30vttlygf7r0qo0tbg3Y2H8Pg4WnaAxkGLYlDX2HNymWeeKeti5BkxYkgz1G48rgmVQw+3/Cgk3z/Z60KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8363
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

On Mon Jun 29, 2026 at 11:09 PM JST, Alexandre Courbot wrote:
> `GspBootContext` contains the resources required to boot the GSP. As it
> turns out, this is also the context required for unloading it.
>
> Reflect that fact by replacing the arguments of `Gsp::unload` and
> `UnloadBundle::run` with the `GspBootContext`. This symmetry between
> `Gsp::boot` and `Gsp::unload` will also be convenient when we want to
> make these methods generic over the boot context corresponding to the
> boot method used.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

