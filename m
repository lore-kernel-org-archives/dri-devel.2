Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06908C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F5D810E2EB;
	Wed,  1 Jul 2026 06:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQhsHdSj";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012000.outbound.protection.outlook.com
 [40.93.195.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94C2210E2EB;
 Wed,  1 Jul 2026 06:40:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iwvc4JCkbcjIB1IDaRTs5ZdF+gaxum33WXlEHi4U8ViO+T/JqZ/g2gTaRWAPOXsCzcWvOraxxWIU4L4d/Mc6ahLso+nfzbnGU5NJ95d5Xaf4vgCDBBesZ5LWCIf3io2Sh2egEW07/FcWvG2nP6LR5i0/A/jHzNZ0nAj5H+WidKy6gJvTdhDZe2W+Uap5I/YoZtl5R49/vmoYlPlAZ+AoU6eRyK2/OPtTIAepTNQjRe86/q2w/HYb3Q6TkHpWeZJQTfJbP+Ou96kWlMj5mNwn0S6b+qj/puE90wXcjMrxIBI7KMdycAzqIZXa9mqlDrog/cXR7kMTofi058VTWGJxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3l9KgbX7O+ft9V5WMYItiodV/Asu2ampB+EP4K0jI8=;
 b=aIwah77rpkAB/h80/F80GlDYv7gOD6iDn+z6TvbHifLou0CnFOMkcpxXQ4MCYtCQxHV4dB7SNSi9DDvbSoW54MYUJnkYrPmOURn6DH4uTIUhNu271GLQ0SB++6fMdScl4ntoNglFYb2pDHwCYlZsiMKKAY/YwjVQzzn1fkii4yHk1QMcX+yfjvTFU9ZA3u2EVOGTiecINzbcjBMCH/ejPq/oyxgawLMvcPtWeECMrikRtVjPBuQqymrYbYHqW82InJNTSvRj/5M5W4Fi7xCxSVl3m23S7BZsRBQ1E8OG+jTm4L3KaquX9k8FvE3tmifUoJwwuc1/8bNeLQUSBck2ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3l9KgbX7O+ft9V5WMYItiodV/Asu2ampB+EP4K0jI8=;
 b=pQhsHdSjblU5R/QE3dwnuadaeb9wl0p8lmTfOB9MIBn/qGEvHhIzgY6ydXIu37p6ikMyJTyKJPRIObLEoxHNCkMxOrLhhdFcVtWfyw9UV1VhKmMfd7+cM9PijWjXwJJXrF6Tmnc86dZx9dyb/N2f0H3io+oLg3NgbdruhjMNz382Px6lF3FzuaX0dli2wyshpkAoOrsXXTtSCtNqiN4C9VG1+vg+8vc4TCHHF4wbd4cFVGw8A0Vto0b6zQ+KnltDNm4lcPFVqUpyr9Sjs/d/ACJgioqu0cWpeKscoCLG6/9JSVunlfT3X4Wt1tSvHhc5u0VbrnQjxZG/T/JwMRi/Gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 06:40:09 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 06:40:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 15:40:03 +0900
Message-Id: <DJN11TU8HWWQ.2Q8I0KT7DUEG0@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 11/13] gpu: nova-core: gsp: pass GspBootContext mutably
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-11-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-11-5539d8469590@nvidia.com>
X-ClientProxiedBy: DU2PR04CA0041.eurprd04.prod.outlook.com
 (2603:10a6:10:234::16) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA0PR12MB4463:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4b67f4-e0a9-43e8-fd3b-08ded73b986c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|23010399003|366016|1800799024|921020|22082099003|18002099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: l0tYUQQdjt3oURaz7bpkzbyl+Mp41jNF+jwJOr7SQKpB3eG4AdP0wX3QVe6SEKeqZXOK1x4Gkunv1lfORXP9w80cFAa3CcuZAO6miGhLYq4+AAcuj6ZvUntR8M4Pa8sLYhOJYgBYTVa4aT1t9YMunTwlRczW2Kvp3vv3dFBKehRNd/k6rx4l05Ol7bNJoCAkbmD6QBfqeGcVzTqEjGtrgUVfupu6yjDRRv+Z5JuEsZgqJzt57MfUDtLvQ9yPCy/GMF62FPHde2hA7F2irb2oznSWCBYimQ8Y7FxRQfsHKfQGAWPJmY0Rg1qLaIIM0bMQzfQEyYfSWnkFOURhOxHv6tmLzNXe7115fTcyfNAnT1bzvhCIcpKqQIl/Rkp2LCOP4SL0OHK+bgmHXBej5hIg6rinoxfUA+CU9TtiSQb70yeo6rrPGZzV93ak94n8IqJb3AKrh46n6Jcwtm4nfsUR1Eo37ceFFmlclW5f+HXe0MwrTLFlSCo2aOyDj1gujxOTff2tEUcf2pnBpTS3RFpbaPUpEFrPeRMI8egr4GHdo7ly5RXxeMqJL2dmQT88x7R+hmayZOx4IBHXh93uBOpIDDM/Qoo6hcKIEGI+IGXc0f9dgb5dLQev3Bbr8oNwSylUFP3++M23DG8SLKekWHlxBO6UuovgdsWjWynSfC2ZOmZGeLFkzxUoFBRFTI0/4ZFjh0bfvlpXO/cHmSrwtnh2Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(23010399003)(366016)(1800799024)(921020)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3FpcW45aThnRFFSZVRPeFZFYVVEaW1ZTmI2K0JUdTVRLzVPamVIS0pmMGtD?=
 =?utf-8?B?Rnl2RDFDS1ZZMGJMc21vZnIxTDFOLzBRZXZhalo3K01ZeHNJNC9nNU4vdmhG?=
 =?utf-8?B?eVlQSkpDSEU2NWxKc0Z1MDdtSzlGQnlFeGRySjlSdmRkZFJFM1RYN0JnY3JF?=
 =?utf-8?B?ZVYvZFdYT0ZldTI3bUQ0Zi9HUTg1SU1XY2FFVFlJQXVKREpFNFg3R3BPSkhY?=
 =?utf-8?B?WFE2cHlSVm5WWWxrbm80UnZpQTFDNzlTOW1pSHVJd1F1ZEtkWnlBMDEvL2Q2?=
 =?utf-8?B?K1BYTTVLSWpLbzVyMnlhOE1ncEs3RUJXM3B4eEV4UXV0TG9BVkNtT1M4OXhu?=
 =?utf-8?B?WU1UTnJmd2xsb3U1S2IvVWRjUDJORzBwWEU4RStKTkNkeWc1Y3hPZXpqQldM?=
 =?utf-8?B?UlZWMWVXUkFnNzVKZGRmVlM2cE9CU1UrK3Z0aUlYcVhSOEJFR1Z3SWFTU3RS?=
 =?utf-8?B?eGxnSVlDT0RReVNXcmxqczBjM2xhcTRFb29wZXpJS2FGaEl4SVF4QlhEWStZ?=
 =?utf-8?B?MkZPNGFKRXpvUG1QVUI3MXRzUERtTUhmY0kvd1hMdzh5UU5Tck5YY2RFNzZQ?=
 =?utf-8?B?RFU0TzhERU1MYjBXektFYzc4WndZeUN2REhLVjJ5UTJ4ekk2RXhpMHNvWXAy?=
 =?utf-8?B?ZklsblR2cDR2d1M2bVVoQTNFUjVPZ1hvM1JIajFTNTE4S1RsOEcrVFF2RDhx?=
 =?utf-8?B?Y3BJTGxtajAzdWhzZXQvdGloU0JkYnNaTHp1ZXJqZ09jdmUzV0RvdzlpdWJ4?=
 =?utf-8?B?bjlabFoxRmRFRUsyVTJqS08yYk4wZGJ0YklOanc3Q05CRjR5MngrQWdyQXRw?=
 =?utf-8?B?R0wzSUVWRzYzUU1CdmN1QW5BZmI3N2xKMHp4V0M2aEdMd01ONVM0MCtNRi9F?=
 =?utf-8?B?NXNCZnRBN2E2S2F4Mlphd0JySElMNnc2emtkS01MYitvZ1RpRlYxd21NZUsw?=
 =?utf-8?B?eGhKZUNVaWhHYWluMzFaaFRLdkROZGY5WEpiT2JQNHNTSWZxaHowM0RNWWVH?=
 =?utf-8?B?NmZCWlNaNysycEZ6VDZLWHcyaVh0TmFRVUhyREVwTUxtdVVVNkw3WGVtR3FV?=
 =?utf-8?B?T3lLcUNyOFIrcUp6N2NnWVVtMGxGOVl6UUk1WkxucWFJMWZZRC9USUMvTU1s?=
 =?utf-8?B?dzZWWWVwS2toZGVaTE92eGVTZldNUXJCcTljb3ArMjU5Y0UyVW1sYkVOcmlz?=
 =?utf-8?B?UFlPdjBabGtXNDRIdmRSaTRpbTZZR3lvTEFUVmVRUUIza1M4cStycUkxSy9v?=
 =?utf-8?B?M1BYang5RUdUWlZDN0lwa0lnZFhKVVg0c2gxVUNBaWxWRmN3V1cyMENUSVRS?=
 =?utf-8?B?MG9FbVdxSDFpVEh5MHQxZTNNY1NPT244U2RxOENucDhRRjhvcVpydm1NQVpV?=
 =?utf-8?B?aWI5eFM4MDB1UUV6U1dydDRBN1JpL2ozNkNZNEFpakFYOTlMTmdRbTE5aTFh?=
 =?utf-8?B?RkJUR0t0V0lhLzlWWDRnUzRUZGIwZUNjL2tzSmdoeG1DaGtnTzJvUHhHY3Uv?=
 =?utf-8?B?M3N2NXFIZHgvVEYwY2cvU1BtRFJWc1g4U1RYbXhWZ1VHOXF3VmZjdVI1aUJ6?=
 =?utf-8?B?SFphUjZqT0hiYlVPTHQ2Z1lDSk1pdWNKaHBLM082SlJWclYvMDR0SC9QZzE5?=
 =?utf-8?B?QzNrZnl6ZjJ6SEIwYTV5UmgvSjlzRDJ5Nm5oYTJpZ29PNnQrYnFKNUFlL3hh?=
 =?utf-8?B?MldBR290SzJNbkZIQzFFbWRqSFV3Z29XZ0F2SmtYWE1uK2JHaTNTaHhWU0Ir?=
 =?utf-8?B?TldGVkRTY0RDRnB6Z1cwRWFIekhBcmNtaW9OUUV2eFJlTk9EaCs1NmNORGd4?=
 =?utf-8?B?cUdjbE5wZTdrRjdqQnkyY21oTCtocThNaGg4WkxDa1NDTnFYaGIza1FoMmky?=
 =?utf-8?B?LzJEeld4Rk9XZmZMeUswVDFQT2lFbmRGY0JGWFlDUkpQME9KWWJ1S0hxQyt5?=
 =?utf-8?B?SThTWmZKQnpZdWU5MnpyUVI5K1VmNVBnSlFaRFVFM0NmeE95eUt6T2ExLy9R?=
 =?utf-8?B?V2h0VEhxb2NJTDI2UFFVKysvc0cxNnYxUDhFUFJReExCR2ZmRTFoVnRXaU5Z?=
 =?utf-8?B?d1hQR1VVZTB6Z0lkTE1DOExhdUVQdk40QzQ5bkR6VlFhWUFsU3RwM1R1ZFlu?=
 =?utf-8?B?Q0ZCWmZtYnVMOExaT3R6MndYcXNhdFJkdzdDMnkyajRLU3BxcVhjZWh6d2x0?=
 =?utf-8?B?aXRCZllBbUNrT3dSdjF1RVVjbXQybVdHTXNNcXRjVmVCNGgzL2pmVW9WaWFX?=
 =?utf-8?B?d1d1Zk1MUzJ5S3lYci8za28zcDBNK1IxNVdXVFBhbDI1T2NpRHBpVG1TMGky?=
 =?utf-8?B?NWdWT3JxS3E5RXBVd2lkbGlVTHFldmt6dWZ3S290d01JYmpoL2IwNitvOFFK?=
 =?utf-8?Q?B2GUBIQgFeDpjo1NCX79G7Ops+8FE6nSxKz6qgJZjnBvt?=
X-MS-Exchange-AntiSpam-MessageData-1: bJHyS6b63NU7+g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4b67f4-e0a9-43e8-fd3b-08ded73b986c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 06:40:09.5176 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBmFKBgmhte+e7HSDOVfLPjB+HRE/9x8VZS/VLs0ZahHsplWwkfHPT0m86iGXsS1AAMAiqEUJsGQT1GMpeZ0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
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
> We want to move the `Fsp` instance into `Gpu`, which will require
> passing it as a mutable reference in `GspBootContext`, since
> `Fsp::boot_fmc` is a mutable method. In order to use the mutable
> references it contains, `GspBootContext` must also be mutable.
>
> We will also follow up by making some methods of the `Falcon`s mutable,
> which also requires passing them as mutable references.
>
> Thus, make the `GspBootContext` passed to `Gsp::boot` and `Gsp::unload`
> mutable, and pass mutable references to it to the GSP boot HAL methods.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

