Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE72C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F70610E6BF;
	Thu,  9 Jul 2026 12:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rBf1JQ8e";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DB210E6BF
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKC1LJueU8CNf1iqOPEL4sqg0fxDoO8fHg0vB/uo6z255hwfcadouVrcTEFpVC1pi+g0YGfcbhEQdVAbvll8GYz/Bfu3BnLR/AG9R13F/UgO3N8/TcRI+LOZKug+88oFxUi7zpE44AtblpspMk2wY4oZGPrXUCcJ8iO/ThbXAaAQyaI2nJMTkcBghp9fEHSN2eVbYElqJpfTQUUbnlfFqHXTgklj514vmnIbpWQJ+XwvF2LVEnWgQc2Wa3YB8J/E/D29vfXpjNtjQ0zi3PsblGwLgUZpQYuCTbwbcSc+leaabAF7x90d36C/dhCEsXstlhgzGcVFfzLdTe3NSRAwbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJjPFqnwTcNxmaa66xIsasP/5r01xAS1TR9ddN1MHgU=;
 b=LunMZbRRgRNPu4j+64Byxmgh/l5UH2JXdI7tSH9iHUlkiJjo3wM9oeGgOeo//EVYYtte9W0APA2cwQRrB+iroTvkP9W6jcV+m/XmBDCyp1O9StPVDBd7Nc6Zc/4UR7Wps+lz2kiz3xSDJOXHbTLYkxMO4jWbEYdcdKMS/l7E5e7OhTQv7XCGDXcp7LxgsfG74Z/Ho6oRKW8Vvm1cgXg+Q90gcO80ZrUhpO3GQ1CWitWYxH9X/PXS9MMYVpSAjKpc+0ym2el0HP5GNbkleJ9m0NjrEQJ6kpzkYWtmgUlA7XRFD4KkWkWH6HEwThg7LJ3vmy4FLYe4x9KmVO24lUzaPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJjPFqnwTcNxmaa66xIsasP/5r01xAS1TR9ddN1MHgU=;
 b=rBf1JQ8elMHX2yY38Rop0aV4LJJUNdyUMR9p4cbwi+detONSU66THJVH04GZdyCw6JeglChLvjIggzWmgxMFl3T0KVlg1LRD8mjp5GvUECTguZZT7cWZKMAWfKVQBuiOV0MQrZ5L+HP7Le/meOd4R2x7vNjrswyRc9Ri+VP5zOZyTB7EKTiDDMxAG+IV9AHJxZIaFHt/b+ymqHLh45+laXnR4v7sQJhDBI2AAUSmZUUjYTojmYfvEX2CNh3beNFgSXedBMjfFd65S8nk/1JmiEAG92j5vAn8mtcQw83FDHx12wjYpIHg9qxyLLbjh1WWWXEgwKA9zS8sgIVNYFRzng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.16; Thu, 9 Jul 2026 12:34:47 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 12:34:47 +0000
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jul 2026 21:34:43 +0900
Message-Id: <DJU1LQG3VOX8.39VWHFH4K7EKS@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, "Danilo Krummrich" <dakr@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Eliot
 Courtney" <ecourtney@nvidia.com>, "John Hubbard" <jhubbard@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] gpu: nova-core: Add public driver API to nova-core
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alistair Popple" <apopple@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260709085204.565159-1-apopple@nvidia.com>
 <20260709085204.565159-2-apopple@nvidia.com>
In-Reply-To: <20260709085204.565159-2-apopple@nvidia.com>
X-ClientProxiedBy: OS3PR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:604:de::21) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffd57a1-cd29-4845-8a61-08deddb6765e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10070799003|11062099010|18002099003|22082099003|11063799006|56012099006|6133799003|7136999003|4143699003;
X-Microsoft-Antispam-Message-Info: ob+A47PpNsI6bkBxVYdGjif+QK2d+tIyAlYkcXhzrCg2JVGUM7IWBqUfymV2WARD8jmO4UjB7YGATiSnsxwBSDrn8XZTcVF6ZwaAjN5qiHCUAlAeNGHfc/XTUyIt2EsSrHQaQ4Pr8qQzs2tROnZ/DfU+Tohh0rf7WLkopk1TqeBPjLIvQWQTIDFK0NN9H4N+K5fToOmOTFiGejqx+lyfEGRFVOs6ZCzAN0dvc44mJwOT9o1qPUNjemqQaAaH4ERXvqQ3ptlf7tXD48M1E0eJS0pu4/5kMjJ22B8Y48x3WNYki/7eI1L0r/6py6epO2MgVOIvlPt4nQ00Ufw2Wih6G0LTmCjzETpvTAFswoZE3MIUjeI9tkgsG1Kh9oQv1t/Q2OI7KyIzO++aF6Wnt8MKKu5ErE0MZMK19OuCM8/9Bw1oFyQqjHHFzLkLIORSRJLN4ePgxjPMFD6PMgakAHIM6O6l/ORl+/i3KMvoMaiEc1w+xKxSkAE8EtU5BpuyNuQrKzXjDaB0mr/3tVw55ugTsI+xtxL3Z/mK2TcXrwcxg2to6y1Fe7pcugLV/lWywUQneAXvGrPyTPFT2ATbEh7ZPhxyY1ZsVhTTlQgdSKgfs67g0R9lsIgqE2+MiItwobgM/aE43G1P8uhHOH8HsXEmJzkQPUBoEv01076iPS953Tw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10070799003)(11062099010)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(7136999003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGRjTWFTSldVdXpVd0pRRlBBMVI3RDZWOTAzUVhNeGZJWVNJR0tFakJEZDIz?=
 =?utf-8?B?R1YxUXJaVXh0eHdEajM5UUVRRnYreG90cmRERk55c3ZyS1laVjZrZU1sb3JT?=
 =?utf-8?B?bkRJTm1GV2FoWTBIYnVsLy9Qa3ZKcTBLUGFTWk5JTXpQekZUL21kMUJwWG54?=
 =?utf-8?B?S2hrVlh1azluY2xvRDlPY3dMZHZ4dXJkeDhxNlEvSVdpNExBSURwYXRuR3FG?=
 =?utf-8?B?RCtjV3hOVXQvRmVHRjRQVXB5MWd6S1hBY05OdHRHTlg2Z09BSngvOXp3RVo1?=
 =?utf-8?B?OFFWM1R4UTJCWlVSN2ZvVHkwNy9UNmNTb3Z0NzVpUmlPaDN4RG82TkJLSSs4?=
 =?utf-8?B?VDBXeTVUTEJicTFiNEFyakpDdWd4Ylh3QUFjMTZhUjZ2dVhhaDduY0s4Nm4y?=
 =?utf-8?B?NDdqOXRZcnF0azgrcmRyQXZhU05KZm1WU1JBY25reUVhSHVoVVNTNGxrMklY?=
 =?utf-8?B?aXR6QXdpcnVpaWYxaFFCUXEvRzkxcjFHNFpYZkl2Snl0Qll1d0d5VnhCeVNy?=
 =?utf-8?B?VnlWcU4wWFplRGc0d2NKNW5yWTBxVDhwRzlwOHNKU3JodTVwUGc3c1NxeTRM?=
 =?utf-8?B?ZzNrVWE1OG9WQUV4V3FLNU9qcmZRVWZsdzU5ZEhyS1BuZ09IQ1pmUlU3dVcv?=
 =?utf-8?B?MXpzRE9EaVl2SW9UNDB4VjdLbS9vVXYxRElHanhWQ0pKb3M3cFpEOE1MSFZi?=
 =?utf-8?B?cDZuUUJIZEdNaG1sdUR1eFA4TDBNSVQrNVVjaTQ2K3FYMTVWemFoU0VlWFox?=
 =?utf-8?B?bHZlREVieCtqL0FFcnBPNlFxNTNENVdpSTVrR2xwMFlvbFBaK1BkM295Nkgz?=
 =?utf-8?B?SHBzVE8wZ0lZczhyQjF3d3V2QXVJL0lveWcySXZLZzVXTFh3VXJseEFHaFNM?=
 =?utf-8?B?OWlOTzFnZFF0L0t1RkhYS1l1UkFna3hUelVlOXE5M282b1FJY2xXYlJQODRG?=
 =?utf-8?B?VW54cVhXbWJKTTlnK0NqU0JldzlwYTBpSzZxc1JsZVM4L3BOOExYUytsWm9w?=
 =?utf-8?B?VC9TS1c5dFY4YklJVGlpUC9FZHI5SmRoR0NqbExwd21xQUJYb0Z6K05ZMHlW?=
 =?utf-8?B?TlI4dzljRVVzTzIrV1RTWjlRSTQ4dGRYNnI3ZmFVcWZZUFhCM2F6Z1FSak5t?=
 =?utf-8?B?cGo4YmtNVnlsMG9ma3h2emFDWDV5M0NsTzNINTdGdzZvU1FCcngrV1hCU2Vl?=
 =?utf-8?B?Yk5jUlhPVjk4U3VwaGdOZk0reDBsd2xWZEJaUE1ENjV6SmlwRW01UGZIVzNo?=
 =?utf-8?B?NktFWDZEbWpmeFowUmxGM1hwUWxLMXhOU1JRdVc5QjRacTZLTVBUb0NLcklx?=
 =?utf-8?B?QVdHdHpNQ3BXdkE1Qy9JNXo3aG40dk9mZWxxRS9aNDhhYkpZTWl3bCtPTElZ?=
 =?utf-8?B?SXBibnVmTVREeEZtMlNlbXJMdU5rdzhpczNGSjBrcko0cUFtVUYzTVo3dWto?=
 =?utf-8?B?VEFaNktWUnN0RGpLVnpkSWZTUXd3ZzYxMFUwUkhGV01icitQZko2M0tsQU9G?=
 =?utf-8?B?T2t0bmsrc3Y3T0VUanJKZTFKNXpUdnNydWhlU1RqN05pRXF5Zk52Ni9pOWQ3?=
 =?utf-8?B?RlpBWXJpTllPTXFRS2I5RUpnclNBYjhjQ1Q5THZrYUJ1Zk0xVTEvS2EvMFZq?=
 =?utf-8?B?b2doKzBFOFNwZXdaa0kwalF0UlVQdGZyTjhscVprcXNEd2JHNzZFb0xrTTQv?=
 =?utf-8?B?OXBsdmlnRFYwNC83Q252c0c3UkhoQjlmOEl3TXV6SnI0OWRlYmVjYVl3bFI3?=
 =?utf-8?B?WmFTWkxYY0M1RU1YM3RmNEU5RVRsdDIzeW1XbzBXcHNoV1BkMld0T1JZYlZH?=
 =?utf-8?B?akwveVhOMWpqd1BqYUtGcGI3REtZQTlnaDA3VVlFTlFyS1pXNCtoaHZ0N3dJ?=
 =?utf-8?B?cUl3WUhpaTFwSzFpMG91Uk9MNTI0ZitXTkdmOW1PWlVnVGZ5Zzc2UjJ5SU45?=
 =?utf-8?B?Q1Q2eXBveW5OQ08vN0l6SmduaHBsQ3B1elI4T3ZvMkZsSHRSc1JtRE5kNTVx?=
 =?utf-8?B?K2hSb05xbjBGVmNqelpnNVhmMWR3SFVXeFN2VHhLQzlkOE9zZ09vUHFIV0U2?=
 =?utf-8?B?UURVS0lHOVZHYjE4NkN3bDB1aGVQcjk5Z1dtTW4xay9BZTlrclpVQnBhalNO?=
 =?utf-8?B?S0dBMG0rM1kreWtVcHcydFphaENEZkl1ME1Oa2xtc1JyUTExaCsrMHg4NU9k?=
 =?utf-8?B?dStzWEpvWVd2NDBIdGZlakdIZTExN1c2aHJiNk1XTisvMkdaQVhpSWN2QW43?=
 =?utf-8?B?MkV5ZFd5ak5PN09JQ1NMYzJJRi9xVVlwZXRuM0ZhZVpZa2FzdVlZWXQ2L2JE?=
 =?utf-8?B?MkQxU3RORmdpREhtZUpDTG1pbWhyTkd5OEdiT1dTSVdPZGFnZFJ3ZU42S3dz?=
 =?utf-8?Q?LEo7+yF8YKnyiMoYDLEk0CCuHdVPGEus/g00xXluMN6O5?=
X-MS-Exchange-AntiSpam-MessageData-1: cfY2KpO0Hl0CLQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffd57a1-cd29-4845-8a61-08deddb6765e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 12:34:47.5412 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBokNDMMUpc2iEzVHVi9+mto72qJ32r4FTsjuHq+b3/7O7d1+E0KtDfQI73nhxZJ1Bt71f8MqSRDZq5EFcYrOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723
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

On Thu Jul 9, 2026 at 5:52 PM JST, Alistair Popple wrote:
<...>
> @@ -86,15 +90,31 @@ fn probe<'bound>(
>                  // (`try_pin_init!()` initializes fields in declaration =
order), lives at a pinned
>                  // stable address, and is dropped after `gpu` (struct fi=
eld drop order).
>                  gpu <- Gpu::new(pdev, unsafe { &*core::ptr::from_ref(bar=
) }),
> -                _reg: auxiliary::Registration::new(
> -                    pdev.as_ref(),
> -                    c"nova-drm",
> -                    // TODO[XARR]: Use XArray or perhaps IDA for proper =
ID allocation/recycling. For
> -                    // now, use a simple atomic counter that never recyc=
les IDs.
> -                    AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
> -                    crate::MODULE_NAME,
> -                    (),
> -                )?,
> +
> +                _reg: {
> +                    // SAFETY: `gpu` is initialized before this expressi=
on is evaluated
> +                    // (`try_pin_init!()` initializes fields in declarat=
ion order), lives at
> +                    // a pinned stable address, and is dropped after `_r=
eg` (struct field
> +                    // drop order).
> +                    let gpu =3D unsafe {
> +                        Pin::new_unchecked(&*core::ptr::from_ref(gpu.as_=
ref().get_ref()))
> +                    };

Your v1 had a=20

    // TODO: Use `&gpu` self-referential pin-init syntax once available.

Can we preserve it?
