Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7DBCD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 13:06:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E2110FEDE;
	Fri, 29 May 2026 13:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ofBjPNZ+";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010060.outbound.protection.outlook.com
 [40.93.198.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37AD210FEDE
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 13:06:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMFhdSMsK6iNkxe/ujzVQ0iCE77eKynHDuct6gn4XUGpsVxAJ6hRmWNwR8AJPPAzB2mqUb7CmZWXiokvS2KrJvoGhAYa2TJ4sA4bPNGo7FJe3/egz/o7B7qmtZN2n6kJ+I3lAZi3TB9sSQnK8LrdBxv/G0W2j/hrCngdhMLtLMUwH9QE0XkShZK1ADVsGyBLXnkg4Q+F56E8R3pbfyOv3EReSqO/llTVmwP/vK3AXqxeQ+/qm2qBupomDeLq9XVzdyw60uqBgJWLQ1xNaN54qtRbCGcR4O/T6qOwljLSthVtSvBbC9+zTDfwoTsHn44OZTvBYjNgn9j0KYUOASEdyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGovr8e7JGF0Y8v24mgYp5yzFT/jeRXRfK6TF/UsWUs=;
 b=OXcS2e5M9R46X5DwwL7VgLJxP+Z6KySZBrjaG6fN2q2SCuHhjSxvLlt469N+Mg8Ju1ZoP7OCZCyGooxZuM46uultjGjkZqL7AuXmjJCOuccwylMJlICNEb+QBs1oRHpsIxR14/BSxuamRarSyKTihX5PKapjHulPoD9lZx5b4FN/yVEZsM5ZIuxBCMMQ58mW8C4EwCONtpBkKXhwXNk0vig+Xaxyz8M+pfwWLPGR02PsNNtSBRYXOeDZZnlRsWyUtr/6EKDqlX6qZAF7FOigixx1LFV1moafonnSBs7seDBeZ8kpEy3//T0JVrGAjX6889+PGizMXodjGIMe4jU9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGovr8e7JGF0Y8v24mgYp5yzFT/jeRXRfK6TF/UsWUs=;
 b=ofBjPNZ+3qOTjNEctpx0kCi3UCLigdRn+rvJZEpOL9imV8cgCw5vLz967xuVF/STZCOtnGJaTy35ekRhdyOTd6p2Ijm0QzaGuCFwH0VEkfsWl59gnUoxKni25L6//b6JGYgdY1uPR8vOKjTEbLQSEWjLYyXNh2N+QVGUE+z5sR4W7BBIzMzmdMMWJSMm0wctSE2pVytn7NgOFJVo40xbGPWQOfOBOuA6TrWHvwwCDu9avtMnLk44BDyiyzlS/jLe9QCRDj4pk1cmX0HO3X7UWie9+4G4KYZj0xMGtxFEvFLjhoqNox1wC4B2hGuMDZ5YIzYnHmknn8OormrgvB0UuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 13:06:04 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 13:06:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 29 May 2026 22:06:00 +0900
Message-Id: <DIV6LCOK15E6.FZ075NKGV621@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Eliot Courtney" <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v7 0/4] gpu: nova-core: run unload sequence upon unbinding
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260529-nova-unload-v7-0-678f39209e00@nvidia.com>
 <DIV48XH2KKI4.1AI7LJQBHVGM3@kernel.org>
In-Reply-To: <DIV48XH2KKI4.1AI7LJQBHVGM3@kernel.org>
X-ClientProxiedBy: TY4PR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 00dcadb3-0684-4241-a704-08debd8309f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|4143699003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: Pqrl130HP1TYimzqMZo64PxaWGG67RYIH/Q+4fyKqf/sSReeDCjo/lg1hn4ls/uIskxX7zVX/AYsrOC4Q5I2shbwH4bBJb9szGZAgt8Rtd9vBGPCvBqvePcBzq5Z7FBh534wDHNWdo8K7QYdVfU924zjFxEiMABl80p5vOKc2AH4TLh9PUNekwjNCKiApn87T4YW7aEpH4nzVxUflC/iXLlB+ejW5z+6qROubZATJ9nn4LFbYuUlpxRJZw+vM1DCCRxhznY1Zc665UE4/XJG170PH2j20ucGmztFPjFVPcuAE96AviYPMkiPSJcHCsfVY37EwjsmaQbJ+KAARzYs1WzAwdsSi1n07l4wW9FIoLQpjx7EvazfRQ8DXPqx7AYPOv9iWrzHLD48hohj9IHiMoRvgrxnO2N12heHIHuFLcTQ6AVpb8Y6QclFuYIgXtuIWlJwHcwqYJtdIGLuXvSCw33rG8fdR8afuIUDUriTMwddlJ87Gc2oWFAe4BIffXpxvBGyROtUgHT6bQroxY3qNqUKZ6FSPGitkZURZZ5qWBPoSwBW71u8VJAGg+gOcXvS6ISdSp3hEVGWuytGP+OIXquQ0h+Pf3fYFQe8NktIscrRXDcUGMb4qQq5W0G5vH8GzfhnAUBOOcZlGiT5C0fikhaupoKGerdLr3rv6KMAPp20N/q5igAI71RRM4QXhTgzjd2ONu5EcHSsLp+1p7kunA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(4143699003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHp6U3VhQmMrS3hrbXZVdUw3M0tOMXR3WHo0NVI3R09LVXhNYzMvZW1hRUxw?=
 =?utf-8?B?ZGFuQkZsV1lFR0dmbFovUlhKMzZLdXl0MXlNUmxlakc1RjJTYjRDVk5wdkhF?=
 =?utf-8?B?SE5JTURZTVlGeldlakI3dG4reHM1SkhhWWtCNnJOSEJlRmdzZDNWMEFabzJj?=
 =?utf-8?B?L3QzUTNtQU0yNTVKRUg1Q0FGMTRJWllnQVpSSkJ6N090VzE1S1BiTXMwZVh6?=
 =?utf-8?B?eG9yMEtpbXJhL1RtdHlTVnNheDQ5ZUxPaWFUaVNtSGs2b2todmw0bDQxZkVW?=
 =?utf-8?B?Y1R1UlJ6akI2ak5tSEdPSVpPTUp4c3JoK3kxeUpvTE00UzZ5WkZiTUtpV25o?=
 =?utf-8?B?UVJmemFTbUdPRkVvQ1dkNHd4L1hGMUlVR0hWU01keEFCUktmQURkSjRZaUIy?=
 =?utf-8?B?aUJtV3ZLSE5KQU1UUEFjazVZRjI1ZFBxcWpnUi9HZjlmVzlZaE8rbVppeSs3?=
 =?utf-8?B?MEhJcWtFeEhpbXVMRXFnVVNZMlMvS0NkbWNMcUJFUGNVRWlxZHd4bWJsdkxF?=
 =?utf-8?B?a0ZaQ1lGcGEyMUdaRjJzNG5DdkJBRFk2S0IvTzQ0enhSRTFRZ3F3RldUNUUz?=
 =?utf-8?B?VUJFdzBOa0RRVjF4VThGcEd0elZMbEJGUE9rNXZvNHZtRkZGcGVlZmR5Q0JC?=
 =?utf-8?B?b29IZVJxRzhFbjNqUkI1WFh0M3RKYUVuK04wM1FVRVpXamR5cmxzekl6MUZQ?=
 =?utf-8?B?WVIycFd5WEVVb1VyVDNNNk4rdzArRWRvOFA3L01BcHF1OW9QU0FUU09CcUVj?=
 =?utf-8?B?NTdQWFlHWVRxUXYyOVduSWc2RHlZbWwzbEJWeFE4Q1JOeUlIZys3UUNPVksz?=
 =?utf-8?B?eitlT0prQjNjWnpQQ0w3NCtubWdrSCt6NzVWYVRxS2tKc3UzZHMrTTZLQTZh?=
 =?utf-8?B?bjFPY0owWm9KUnFJcWFzQ1gyUUxhQmVmVU5haG00QzFpckJNK0U3dkhGNDNE?=
 =?utf-8?B?MnNIb3IwSEVuSnpHVUtIZzBIb1B5TlYrYVcwS1Y1UC9CWThBNURSSmFuSDV0?=
 =?utf-8?B?RzVUVkoyRDVGRVN0MndveVQrM2ZCRHpSS3FqMGdoWlQwMnZFUlkwTU5DSWZ2?=
 =?utf-8?B?SVAvRHdJVVo3cVV2bU9CWkg1cWhBSjFuSkROWC9rSjBmNjAwUytPeWRtSTUz?=
 =?utf-8?B?cjNLM2JvaTVJblFjTGFUY1I1T3dzdEhsT20wSDFVMHdGQ1U4VXZqakxJKyto?=
 =?utf-8?B?WWdqaklVZW5hSjBmeUp1TnR2MXdOU1pic05XN21WdVZiSVdScnpJL0k1cnBj?=
 =?utf-8?B?RE00MVQyaDBlTml5dWgyQnN2N3ZtMDBndEZJaWRKdUQ1RVJnbWF5T20wMWNv?=
 =?utf-8?B?ZTBFL0lyQ3JTMGdSNThuTXcyMExOa1ZxM3prVlNER1pRaFdqQmF1VTgxUnp6?=
 =?utf-8?B?TFpqWTh6aUVrOXErYlNFbmtnMEo4R0dOMmVicExsdlFHZURKRS84QmtKMi9r?=
 =?utf-8?B?b3MyS0RTUE1McFp6UVNZNjNWZyt6UVFkWVRxT1J5SnJBaFZEV2owZE5jeU5G?=
 =?utf-8?B?NnZmOWVaenUvSkZFVEd6b0l5NVROMFFSOEN6SWQ0L0Q1czJQa1owcUZKU20r?=
 =?utf-8?B?aG5UeVlweVYyN3FSaHpRNzZZWFdsejNhMlBDQllIOWxaSTRrSFZSNjlKeElI?=
 =?utf-8?B?cnlFQzhENWdnbDltKzJjUzFXTjhVVktUV2twNTAxaFdJV2NHdDdUeUVodmlw?=
 =?utf-8?B?MkFDbC8zbzhwSnBmdnBpSXVNM3ZXejRhQ1ppRDV3Vml3OEwyeFhJTmV5R0l4?=
 =?utf-8?B?bVdXdU80azVxb0ZqUkN2Y00vbWRQRUZFdDNZZE1xMEIrRlNPZjF1NXdINjNW?=
 =?utf-8?B?K1NuQW1ST0lCN2pqNkRCV29pYnZxYlVOdjc4OWJhbUZsZDhNMW92L0owT2ph?=
 =?utf-8?B?YzJubEVzV0RqNmpJZTQ2OTFhNW1kcENieElEYmFnL2s2dXY5N0gzOGpqeGcz?=
 =?utf-8?B?dWZ1UXJyK29DZ09GdnNmSnoxRUdacWUxSDFMei9vN2oveDZJYUhuOHRDZzZV?=
 =?utf-8?B?dGhXL0NIR2VSTnlWQ2tjczFlbUhPdzNSRWoyeGVtVEJDSThiRXIxRWFMelJU?=
 =?utf-8?B?eEplMEV1OUxsa21YYnpKQ1NMSVkyUmNtcnJ0SUNHUkdoYlVYZTBTS3Z2L0Fu?=
 =?utf-8?B?UGFHRU5HMGduZUpzenpIcUpvVjlubFdWVFpqMGtxYXBheXpnTWdUTEh3TWFN?=
 =?utf-8?B?THVCSFl6WmpPQUVqSWJBMWIxM0NwKzBnUEwyV3dsV2VUUTJNSWRKUHRtUi9M?=
 =?utf-8?B?dlkwUEZYaXZnUkt1bmhlZ3hTSG1YV2F6bk9LTEFqOGxzRXVTd2NPVU0zcWtU?=
 =?utf-8?B?WXI0NTBRbFFQN3JZR0c4eER3aFkxdDQ0RHIwRDM1b01xL3RjaVFTUFNUbHZt?=
 =?utf-8?Q?ulDP+2hWWm96x1IFdYWVhHzUqO6zBx2TKepvBZ0myy1Ac?=
X-MS-Exchange-AntiSpam-MessageData-1: q12BRfIj/GZ4fQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00dcadb3-0684-4241-a704-08debd8309f1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 13:06:04.3010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrWwZwYrdbX1TZYj7PGt34er6M2tgOzcDuPRNrhiM6v0NxJ3GQlqUqyoEW7UQUVQi0M1HpJCZdH4MN7vMA2Svw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
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

On Fri May 29, 2026 at 8:15 PM JST, Danilo Krummrich wrote:
> On Fri May 29, 2026 at 9:33 AM CEST, Alexandre Courbot wrote:
>> Alexandre Courbot (4):
>>       gpu: nova-core: gsp: move chipset-specific parts of the boot proce=
ss into a HAL
>>       gpu: nova-core: send UNLOADING_GUEST_DRIVER GSP command upon unloa=
ding
>>       gpu: nova-core: run Booter Unloader and FWSEC-SB upon unbinding
>>       gpu: nova-core: gsp: run the unload bundle if Gsp::boot() fails
>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>
> NIT: There's a few places with Result<()> instead of just Result that cou=
ld be
> cleaned up (including the moved code).

Oops, I don't know why I always write them this way. I've fixed locally
and will apply upon push if a v8 is not needed, thanks!
