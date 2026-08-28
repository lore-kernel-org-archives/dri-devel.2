Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EEAC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 05:24:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0E110E453;
	Fri, 28 Aug 2026 05:23:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="gQl/xuB0";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 995DC10E453;
 Fri, 28 Aug 2026 05:23:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgfQaVM8Y1PWy87xdCh4U8gQh3DUy2IirWjCtCSifPGL0RPeoj1XeJ+UyAonwGcd1dAmvPsRzEhbyKHNoPFubzOdc252ohezl29ah+HWGPcwNRxKKRXt7/NpRjWA/GZuyI3X3g0IbWlD8C34m0uRnV5x0s7uLKIsoQkYAyEkdh4MgbZRdLRLHqJe95gcCPZdnGoRbaMLsT3Utlgsv8EvR0hjhFH2WRgJfLm0oXZGv+ATXit4ClGg5NcaHZOFYLfcozRFhhqvuwW+V5QdPQ/Iz/f88A00Y76gNkGYat2hpKAIKSNevIaOuZx6pgsFkIXFhBjcW73oJsQ/E1ewU0Q8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebwKn8K7TDhmoFECHENNKh0j6juhDADpMc+0QEYdPJY=;
 b=yIUfyrg5BS3L8x/8EcuefykXEsQnm9KX9fJZej0srN9CQhW82bYm9S6eoQ+1p30b4b9wZ/DTXsmKa4GMgha8+WdvIvzy7qWftx+nDun5af1easlN10UeXGycLuT4H++5cd6/hfM9Hy/Pv5xQoy6NLAEuKBMQOvEDNcmSpdnAzSLijajazAjK/+tVW50SWnC4zScFQCFUIAZ/T9irMOIauTpj8pEDkEWwNT8N/GlNilq3NhwkJF9y9ZUuaP+Wn+KNLcMjaDSFu05OvR6S359ati3pQc76PWdptN9Cmiw2wjTbl/dE20f0j3uzzPZo7ZLALM5qj8cYx6UmEQsPWnxvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebwKn8K7TDhmoFECHENNKh0j6juhDADpMc+0QEYdPJY=;
 b=gQl/xuB03lrBQGQeWntlY6meAjoovyOXLFbtnvHz4xxL349m2QhdJFnn1yiHQHEZv0wysL0eOGUI4VLtIh3c6oy3jbPYvbWQl0PA3EsIL7NX3U0hRua5mBZ0lK1sUvtrhIthf1frNOKGvP1SNOwfzpyB1zebGuhOVDcDRMf+4oXWEOfCeKLp9DV+T3AIva3hafVxkryFfAtaQQFNi+b9mWQycfpSm5uBDIiKnDXyvfU8Kld6M7c1XiopYUJ9HjQKzxSbkBB6mNlDyq9ioHp1BgbmHRpNGr25b+AUWAeHU9odCqnTnUscU4zYXhgKfxjiWc4kgLXzIdEPmWM8CgzVAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 05:23:55 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 05:23:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 14:23:51 +0900
Message-Id: <DL0BR314U4Q3.PMFAV27Q6EM8@nvidia.com>
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v8 07/12] rust: sizes: implement SizeConstants for
 Alignment
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-7-bc74c77d0214@nvidia.com>
 <DL0BIY2CGYQ3.TY18JERIWOUK@nvidia.com>
In-Reply-To: <DL0BIY2CGYQ3.TY18JERIWOUK@nvidia.com>
X-ClientProxiedBy: TY4P286CA0092.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::8) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 87eba84d-ffbf-4c91-50c9-08df04c48db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|10070799003|1800799024|23010399003|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ghV2t+3sRUMU+xxssxzzsoRyWJfglmSzqpWckERCZ5TCOqyyDWLFsbPUXXsLBV0/NvLlOhYX+gXBwAdfjnkMahqqrus+rm1cg0M43/scHty7pAOADiO0CSpBFZZH0rHsNo6oeeDBtc/jtkaDL3rBpgJfO9Rj3u41Cb0xZOOdtMuOdgFa1JjM/LFcpBaV0naDog5DejLBseARqlE5BzbVHWXsfgKKubKhHZkOJgdAKpydFhuWWCTDDsY1WJzawRg7RsmZBSJkzwSZLTegtIMspWtV+5XW3MiJEgGqkRjyyLgGqpGQrckgu4oNFszeDNfGWbvB7l4mfHuVls57cyscgdhVF8J3O8FywwrhDJJmjkDXLwQA4HxYfuqvLDt2lPfEz60esQ/HN6J/e9jLv8z6fj1yXkxNw2sJsr32/QDqGVY5mEy9XaamBCoR7h26fMSE1LOeklnEBUH0CT8oXy+LpnM7UQwslsQ3a4g0CwDQeCn9pFLs2OK6n0v+cVbcf0I8WUEZDk51c7doIX2MB6RBoleMpBa7rL7yjwCrB4ref4rnejmkEZ9YjYqGVKTIE+3ebHhK+DyZUQBSiLQTgitAsWVaPQ0rQwHuyTbnCmPnLelzMgjE7mqyjTHxGGRU734pbFqRiqW2XNI8zQzI8au8iyiVO68zxs+/OR6/VtjSpXc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NndyQktsMWhPcXNib2U2Q0h5SUtQVmU0UEJxcUtSTWswZW44NFFBR2o1M3Q4?=
 =?utf-8?B?UWxSZWtTWUduaWJIZklNbE1heG5iNnZNeUJrWFVsdUZQaGh1WnBPVVZzQkN5?=
 =?utf-8?B?c1RYUG1rNS9KL3NTd0ZYMS9MS2pCSzJpS25CTnd2dkQxZ1VwbXJHY29Camhv?=
 =?utf-8?B?NkxIOXkwaExmZEpESG82TVR5Y2poNW9vSHJjdTM1STc1T0hoN0h6ZWtzcXBQ?=
 =?utf-8?B?NXlud3VTVTRiOVV0NCthZWhrVWk4dEhlRDBHeWNqcjRyRGlVNk5ZSDZpWVFq?=
 =?utf-8?B?MlVSajdaQTQvdnc2dzlEWEJoMUVoYlJhNVNOQ2xPOGEvcFIrSTA5dEsyRmJD?=
 =?utf-8?B?OXVaampwVHJ5enlrT3hmUE5EcEplNjg5K0hpUmFURDgyOGY3NEs5OVlGSi9G?=
 =?utf-8?B?eWxHVUZPVjdjTFI0YndWcEY0Z2FrQkY2azRZd2lDQXV2UnFHSTZFSktoV1Bo?=
 =?utf-8?B?NmY1eG1JcUo3d3V5TWpaY2tVOGRyT0k5amtZNGNBLzlkaEl5U2RsMWgxU1d1?=
 =?utf-8?B?NkVKWVpyYUpnanlTYk53TjRZMTlzNkFUUFJ4WmdMZHp1R0poMXBkNW54VVlE?=
 =?utf-8?B?VklvQ1V2SDdJeFdRUDlUZHFvR0Z2YW8wcEM5ZGVPTVIwZGY3aG1udWRsYnor?=
 =?utf-8?B?S0RWMkFiVDcvRkdRRXdiT3kwNFY1MGNQMWFmalFaVjJyR3VpTmhtYTVvZEdO?=
 =?utf-8?B?QlZzNFR2ZFBDZUVzRDdGNWVZbjBRS3dFYUgxMHZnZDhacTBoVExxTVptSjhZ?=
 =?utf-8?B?VmJSQkI1WEd6U0pEVDJlVCs2YlFFZ01QZ2xaRlJXSUlCWGNtcngzVTRaRGFU?=
 =?utf-8?B?Zk1XNjA0eTFDWXN2ZFRjNmV3UGp1OFBGWDFwc1hrZlBNd3pKWmdZSTJ4R3lO?=
 =?utf-8?B?MjNlTWdpaXBkSE11Q1VOSlBpVGFZZzNJN0N1MUN6UHdwcHQyaXBXdUN6V2hC?=
 =?utf-8?B?UmRpbjliMmd5WDNkblQwUjIrV1Rtc0lMdVRRN1FzdGVnc0ZMbnBhdlNpRkV1?=
 =?utf-8?B?RE14WmZVSGlyZmlUNTQ5SnBqQnRaYVlKYkdzSjRyTHZuQjV5VVJkUHlzZUlx?=
 =?utf-8?B?ek9VUmlTdDJNdVJXS1FTSjJ5UkVSVGJSTWZLQXBvR0haUjE4aU1DZWZYZWxS?=
 =?utf-8?B?MUV1QTNCOGtBcHNjY3VTUThMSXhISHZHMmhUTlIwS014WE5nWlVUWGVvelJG?=
 =?utf-8?B?WkdNZVVDODlGT2lZeVN3Z210UlhoaDZKQW5nY01hd0w5QnRBcUtzSTExV3Jx?=
 =?utf-8?B?YU9ZL0FtMU5HeWVFWHQ1V0krNXFnSFRNZDl3NjFHYmoxV2FQRWtnUnlPUjZF?=
 =?utf-8?B?ZUIvMitlQTBoaWgzM3ZUdUdWRTZxYlZtaWhtL2hXOUlxd0FELzR6UHVRR2dL?=
 =?utf-8?B?aFdIaTdYSWpJYXRYNGxKS1pXZGdkOS9xKzZqQjhpSWxGalVnNHlHdWZMZ0RB?=
 =?utf-8?B?bENDVmE5ZFAwR1VLUGpHaUJrOGxmU25wZ0dzQmJQWjlxM2psbUpWTm5oQkdM?=
 =?utf-8?B?bWNYTTFKYlBkTWhRMEg4aVlBakQ4T29CMCtnRlEwZUl6a3VXNG1QdTNTcHFs?=
 =?utf-8?B?dzVKcUtNUzQrQTR1b29ibWRLM0JYZ3pSNTZwRkJJd1lwRTg0cjdscDdhQTBR?=
 =?utf-8?B?Q2NlTUx3NXozTjR1T09DZ2RvZG5IREprN29Kd3ZjZmtReHpVdlZ0cUJRT3kx?=
 =?utf-8?B?anRKRHJQOE5RSHFZUmxkOE9KcnMyYzZGSUJSaDIwSy82QzhyMXNJeldQdDU2?=
 =?utf-8?B?Y1BLdFBEZlBlcXNRMSs5YmRGQjMrUVc5ZXNhMkYvRU5PUnRibjNoOHBpQmtj?=
 =?utf-8?B?TForakRjTkEvdTBrQUZnbFBMYVRDenRSVkEzclQwQ1NJQUlOTjlGU2JZN3Zm?=
 =?utf-8?B?UnpreEVmSDNCRHowaTVrdDZOaG1uc3JpOEF1OWQyeENVQU1hV1FEWUEzQjRp?=
 =?utf-8?B?TjFLSmJzNDBOeTJlT0RMbjd3MGpUekdIS2lOL3RHcVNLTjE4NmJ2QWdFRGtD?=
 =?utf-8?B?L1BZTXZub0piZFp2MDdsNzU1TU9BZjZ4Q3FNRlZVNFliSCsvYldwWWt6Qk9n?=
 =?utf-8?B?NDhUZXNENGlwUWNpQ2FEL0FDcGg1UmsrbENiaERhV0x6SHp3ZTBUTTYwK0lX?=
 =?utf-8?B?aUVlUHZ1eVpVcDhNOEE0ZkEwcElOZVZxK3JjeEtpU0VLTS9jaUNJVVUrOWxh?=
 =?utf-8?B?ZUxoK3FBVmpwQWx1RElhY0VtVHZNdkJWU0xLWXdjZVdyNjk5ZS9IaHRzTlZl?=
 =?utf-8?B?UXc2Vm1OdnFEZjhnZ0hXazUzZEFUNlYrU29md2FyL1pUMldxbTVHN2JHdTdm?=
 =?utf-8?B?Nk9LYWVnMFhvTGFjeFYyYjBPajBaTzVtTno5MkNaU1czSExUd0dmS0k0MlR4?=
 =?utf-8?Q?qoTsaS5oOA0SOuSVm0iwTIYxrrzSQUjLqmVLo/ES6SsE7?=
X-MS-Exchange-AntiSpam-MessageData-1: smGQE44mHfGXHw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87eba84d-ffbf-4c91-50c9-08df04c48db7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 05:23:54.8923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4bVV+f7Is4OYVCDmfkmnhnFw1fuAUtNNV/qHtRPD0TGqdIs3Z3nxZNoVv6Cy6E4QzekzzYapm7Asj5cejVEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472
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

On Fri Aug 28, 2026 at 2:13 PM JST, Alexandre Courbot wrote:
> On Thu Aug 27, 2026 at 4:28 PM JST, Eliot Courtney wrote:
>> Currently, constructing an alignment is quite verbose:
>>
>> `Alignment::new::<8>()`
>>
>> It's unfortunate because it disincentivizes using it at interface
>> boundaries. Implement `SizeConstants` for `Alignment` so we can write
>> e.g. `Alignment::SZ_8` instead.
>>
>> Link: https://lore.kernel.org/an4xDp29VX8Am0uR@yury
>
> What's the context for the link? Is this a `Suggested-by`?

Was trying to show the context for the motivation for this change
(verbosity). But I can remove this if this is not how you use 'Link:'.

>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

