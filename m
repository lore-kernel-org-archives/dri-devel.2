Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F92FC0340
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B56FA10E335;
	Thu, 23 Apr 2026 14:56:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="kIGMoAzR";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010002.outbound.protection.outlook.com
 [52.101.193.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC8710E335
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:56:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKXoWdo+vtYu2lUUSY/1cCwNTAsx5fEEe3KtatWtyE6XdNK9ntjKcBmj5rt4YgutZuOQ5653gk3svKMBzhZDUU+86vexz/aFqsM24fS1GnnBnQ80am0D229XFnB5wdC38K1I7ahbIu25sSPHsHD6tDjNy++ZiLQQu1YZKLwF3o2b0DtL9rta01OC5PyY+/gbrnOD2a9/thkRQCrhTbC6eQpskms3cHmvl2Q/dt5lAn1vCtsvr/5SKAOCkdo6pdayuZqVOfRslld1Ami0AqSTM7wGCkrQnLI+RRoG3EMa8Zrjq4Je+MiLYSiJiZWsBtAORWN9oPNWbEIlquaZYJqD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=en5qN/Q29XmCZ38J4kkTMK+hE8BtrColF2+RXvZWc0U=;
 b=iwc8d+l6SbsM/YKHsDg56jAXwX+8WmlHku4+uSdvK5Xb9zJE/dk/vJr3Oo8OVgvDWfYANTuVq9Mnjqu+ADzS0S+1xkyNeJFDFpgkIbuIWTnm5hXr7uhN7V4TCDt1R7sf19sYNJtHoOwuRpbX4l8L2D6CV7A3ENiFux71+inNe7yh1WPqD60l//vaRXqM9sWliaFWcKBvkWqsat/tOdLHRIE2LpvTuWZZrTr9OnJt6ss8WNdKmAQQRSVi1kFdGMR3XO47xO43s1sS7u8cFeD9V3dT+riVZ+c1M0Arg2nKvoDhiuk76QE/k/QUkIFnjj2LF8cW9GorFEy1a/WZYmKlSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en5qN/Q29XmCZ38J4kkTMK+hE8BtrColF2+RXvZWc0U=;
 b=kIGMoAzRsONxUIb70dHjyJFjEhtyoZIeTvJhlrF8NzcyC8XqdALfZOq4V0dlFgfbqlEzAun9lHZrvhmi9Bq7z7mEW307BZA671hXI9TYMzB6EL+DaZQkN8F7wBTLBQABoWQJHcXBsay7JSP9L2HJEfZqSPnnOXHXVmSXAExBeR5fP1ptDiaG+aODKZjTg2NaoRYSze/yeoAR5hDwycbIw5E+Kz4egQLfn1VcerVsXMjqU/kyCMxxiktCZoN/Ulw5sYCrt6meQJpUFuZBZHCwOfEtl/BMdm3xw8fEq8+BcL4gi6UaGETwjDOmtySqS+dgK+EvbEwBpRbYJ+rqu4uf+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Thu, 23 Apr
 2026 14:56:22 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9846.019; Thu, 23 Apr 2026
 14:56:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 23:56:17 +0900
Message-Id: <DI0ME6AUZU3I.3DZ9D495O0Z62@nvidia.com>
Cc: <jhubbard@nvidia.com>, <ecourtney@nvidia.com>, <joelagnelf@nvidia.com>,
 <apopple@nvidia.com>, <ttabi@nvidia.com>, <zhiw@nvidia.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <aliceryhl@google.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: nova: update mailing list
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260423124649.38793-1-dakr@kernel.org>
In-Reply-To: <20260423124649.38793-1-dakr@kernel.org>
X-ClientProxiedBy: TYCPR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:405:2::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 719d4d29-fa19-4288-f18c-08dea1487af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: kNi6LjDoOY9De8UrWancOglFEwOyTALhiJIUzIe3yVilL0Av/9QZKJTsJOQDWsUgXRrOtM3gCCtXHwtoY2Q+IyOK1VzvfE0wNDHLLa2u8NkA+PI4Lgq3H6wzq4X2Lof3slK8k6eYqNHoe5Mji028k8FpfMlvl/L2Il9dDZYFgMQtHdCvBF2Z48FNOeiPTsad6hXYS8KqWdvmd/a1BlzWOzVnGfE7QBWEqI/wz5ii3Yv38BoKsb3ul7qqYhSxsN0IBjY2IiC8Sl/52d5P4ODqbUfk0zKCXeEaYYXNRF3mlFnYtOWMfyjt4P/FajqeKdVg55LDNEe0ETYSDFPG3VKUz78NrUVcM+1sonzaGntTqjirLsUk0yv4yX6UoOvLjB9+UzT0a6biETg8n6YfSDKq04tW3C8Ejd2S1dm30ikbgmQHDzuqStjsxPpURyEmQKIDYJ40KXDVsmz7Eu880cyIfM6np4Saldi1aNa819DnhuOQ1pyjlO6oZTanYshtHsec1mI6QeCmHWSw7qtRriUX+P3gKr98/4BpDKR/z2xj890gIulaefe/g99c3GLd2M50fObdkSjl2/1b0m0YhMNGwmmSQlBxaecgQYU1ChxY8iVRFIsiLZ+pJOBiQ1qM7ZR3smVb7Jev0O1RfHbN0Xu/zh6vsGq8+WK2etzL5W6AX4R4/A+DRQZBVvku5jsuOw+2Q+cUm8UOD9J5lvXrP0P/M/G3Mi2F7UYybySoDfgreL4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhuaUVPczExNUxXcmdhRkZnRWNIR2w5MkxmTkFDYmU1VG05SHloeUFYdS9l?=
 =?utf-8?B?VDVJQklvR1kvc0FXV1dLQmVLMGRQS1Rid3pQejl4NHdJWnBJNERZWEx0amJT?=
 =?utf-8?B?cnIrSFhzQUIxUERBNENNcmlKZm44YmpoN3Y4S1Q5dFJtNDZpU1NTQnVLOVdG?=
 =?utf-8?B?dW9JVW52USs5OFlKdG1WK0dKaWJZaWcweGM0N05ibnVSclp1ZTA3K1E1OUlZ?=
 =?utf-8?B?TVlLMnVCUGlVeHQrM2FZLzRpSERIb2xaWWJpQWE0d2xQUXlyT25vOTlHRUUx?=
 =?utf-8?B?NVRCNkZ3S055YjlMSjFvVU5Wc1ZHeTBXSlM0S043eEx6Yk91YnJJUysyKzQv?=
 =?utf-8?B?QnZZZGcrYlc3amFWOEFJa2FlNk1PaWVNeXpObWZ0U2s3TkdYcjR4NGNRWGMv?=
 =?utf-8?B?Nzh2UVh5MkVVdm5xa1R5U0RDaVRzSjNaaXVEVWJKZnBmWGRsWkVJS0pkN2lj?=
 =?utf-8?B?VDNwTzIzTEZ0L2dxazV6aCtVYzdaZlk2SHBXdThlTWVmaUJVcVhhcWcvTmVn?=
 =?utf-8?B?VG1Sblg4bEFQcTJVMTZ2ZzIrWUpIYWU0NndYanFyS1pWdk1PUzY3R0JhWlZW?=
 =?utf-8?B?em1ZK1JXMXI2cnhBL280ZlNRMTl6MXBacExHWlJTamREbGw2cUkwZjR4RTBE?=
 =?utf-8?B?T3R1N3dNN1M3WjF0aEwrdFNRZitnZjB6MHRuWHVpc2lTWUFNbUY1Q3hjVU1K?=
 =?utf-8?B?czJ2bm5uTVRIbWlwZ2dGS3M1NFNCTzBXcVd2WU1OZnJlRkxZZjRCL1JKa0VU?=
 =?utf-8?B?MnBIWkt6WitLRGhDcExNanNJQ2dMQVljRkNRNW9zNGUwRlZmWjFmNzZxUnJo?=
 =?utf-8?B?UGRTYURHUnkxQ3lkb1I4Wmswem9OSEtsbldvWmx0azk2Zmhvdy9sam50WEZT?=
 =?utf-8?B?b29NWHlUNmd4TnV1bHo1ZXYyZnI3YU02YzRSQm1ydUs2WHRQTlNHQUcza1Vh?=
 =?utf-8?B?UWxQMUJFUkMvNXJYYitLWmYwS2lUa3d1eHd6aXFicUllcnFaaHFqWFBlMS9R?=
 =?utf-8?B?ZFFyMzdwQmcrK3dUcUZuWUd5Q3RNbllvTHRNTXFYaERRTzBuZVV0VHhiRE43?=
 =?utf-8?B?d0wrWHdjanhma3dYU2svMEYzblk1Mm5ncTlkVUkyZjhyeHA4YmJsOHdSNVpF?=
 =?utf-8?B?Y05aaGp6THJCcVJwYW1aQUFhZ0NpVDZaYy92amIxQ1M5T3FqNE9tQ2pvbTNq?=
 =?utf-8?B?Vk9uOGdSMjJxcS91UFAxNWtDWlNqWkhDR0dUdjgvdTZrOTlxSXdKc1l6Y29y?=
 =?utf-8?B?ZXJlTnVHMzNrdDM4eS9xeW9XTzF4ZUM3VlBIRWtvdHkxYjFjeHVqZzlUcjNo?=
 =?utf-8?B?RWtKa1JsWHIydTdmUHVGd1MzeXl4dEJQQkFLVkVSZkxwcSt5ZmZJckJHMUtp?=
 =?utf-8?B?VWYyemIrMVJKQjBEOWJ5SFVmS01ZNW52SzhMNWx1TUl3OTN0cGVpR3hnN0ls?=
 =?utf-8?B?MGt4aFlCQ3NXT2FzcFpHU01OZHVHUDB6M2w2d1pqbkZyZTRwRGNtRkpsdFF5?=
 =?utf-8?B?MmE3akdzaS85WkRuRmVhblB5Umlac0FjNHJ3TnNUUGhrVnk5MHNPZnV1a0E4?=
 =?utf-8?B?c1NYNjBQOE5yaXhSUEVUU2RlellUWnJ3ckNQWitoeGViSFM0MER0NVhQSFRy?=
 =?utf-8?B?QlBEZFozSk9LemhSd2lIZzkvNkNzU010ODRFdFd4T0xhVmsvcDd5eGFTd0Jj?=
 =?utf-8?B?YlRLSDVSZ3h4Q2Jhb0taU1hpRGhvakFPYlBiQWRSQWlPQk9mMDBJS3dNQWw2?=
 =?utf-8?B?clR1Q3RFd1Yrd0kxVGNrUm56ZnVua3lQaHM1RVdOelhUZ0Mwekg4ZmxmRFlR?=
 =?utf-8?B?aTJFYXRnb0FaRjB3TDRDOXJ0dTdrbFFYWGRtQUFFd0FBMVd0eFZFQ3hyb3VQ?=
 =?utf-8?B?WWNhM2tjV2xlamYwTzhzeHQ0M29CL0l1amxJck5sajM5YmQ2V1g5WjAzekpx?=
 =?utf-8?B?NW5uTHFuNGV5akpqL3Y3MFNEVXBpZ0lTdzRmZHAva0o4ZWZoTGNGZ0dDMXJZ?=
 =?utf-8?B?cHJXMFIyUUpZY2NNcHU5SXZsTVplNjRxRDlZUkRGUHI5MjIxU2RHclNqK3Mv?=
 =?utf-8?B?VERFSi8yWnFLWnRYaDkxY0dhZUVCSnJGTmNSVENpNmFJR1BNRmpjZktnSDZz?=
 =?utf-8?B?cHFjUzIyMzc0M2tJMi9VdzdWZnhLQ3JGY2tTbDc1M0tMMkhwd0ZHZ0RSbjBT?=
 =?utf-8?B?VVhVQ25HSFNGQlRDUG9BcHBBa1ZFZVNvVVE1TXplKytocFhJWkdBL1VIRWFv?=
 =?utf-8?B?Y3RRRVJyNkR4QkpFUzl5M2tDSFE0WFNrTkYrNmY4cksyR2JucTV2OG5ST1N0?=
 =?utf-8?B?WGNuY1N4dVhTakxGbERVSXJWcU5UdW5UOU5SMmR4QjZRVU9FaC9SMDZjUGJk?=
 =?utf-8?Q?GOeHY6rCeHYkWiT3Et9SORCsqhmYA8zlsih+xc8pWjFnP?=
X-MS-Exchange-AntiSpam-MessageData-1: hRAXt9oCFX351Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719d4d29-fa19-4288-f18c-08dea1487af7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 14:56:21.7073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWxydtN/luf4xu8TGIXYppq4+eX1nl++nPFEBzXCGPITlVnYk4vE4q9NDVzwtkFAsdnUzGV3e/tdUe3duWxEZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
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

On Thu Apr 23, 2026 at 9:46 PM JST, Danilo Krummrich wrote:
> The nouveau mailing list has some issues (e.g. with stripping Cc entries
> from replies when using notmuch + b4 based workflows).
>
> Besides that, having a separate mailing list for nova also helps to
> better distinguish nova from nouveau and makes it easier to track
> nova-specific discussions.
>
> Replace the nouveau mailing list with the new nova-gpu@lists.linux.dev
> mailing list for both nova-core and nova-drm, and remove the patchwork
> entries, since those are bound to the nouveau mailing list and not used
> by nova anyway.
>
> Link: https://lore.kernel.org/all/bc2517c2-6772-4cbd-8fd7-6dbdcdd13eab@nv=
idia.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Alexandre Courbot <acourbot@nvidia.com>
