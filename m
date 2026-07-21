Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3694FC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C8110EA7F;
	Tue, 21 Jul 2026 15:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="oG7hUABv";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CFDF10E35B
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:02:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tz3eizL1MJWSJlWglOkStVp7shPpsEFSSpVrMiYqlGuTN0gsHKqxMYnvBkhbgwj6WHZW0TmWtOxuV6fjhH7PLI4Uuz70kNntI7ZAVRfRFJAvNtchX/Rk+FofBTjEt6xshJzn0sP0zywtcCrya3IqQLdgY5qtN+Quq0IF5Dg85R6yEwo+kojNksqGeTpDz5bSldpZpb5LS4Us+zBuUcA7+mAtiDF3mgTjZ5HEhzOCMLZqN0KrrZ8adI7bIltTP0KBIZmBnwCLJYEamcUe9yW9EqpsEE32L/DIQlxnNLI5nOQKQ6QgY3IwWd68FzeFEqKoXymvy4/0W8bIfKUTmh+Jmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prAwQ9b/CRpKCsNH/z9VRfw+zE0A0wczNtRBZQMq3KY=;
 b=QDaF7szFgzdRv1EE50rkt1hnt1ViL0uDhfVgCpX1KGjvbiogheKaumeQiPym3plZa6EoTHKYwW/xlceTgsBXGMO09VG8gGVZ39em4CeYhgayMTYTT6NULPkc/Fiy5zw/lN8u8ys/COPaMCKGd4wuGTSadgXC77JrvB5iUtwcS1ALLtzoBvUMtAHdRouOLB4VGGy4yzb+vZWDnRMWafyqDefrAD2hgPiB+Ti6ywsY1q8adimoK9tc4xfmfs9g/j24Ho3CDLJRewFyUCsal5w+LpgwVw5T+pQiiEO2Caj83Z60cnD7Z5NukMyl5V5oSgLia/1khaDJvMSlJdaaaSvKTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prAwQ9b/CRpKCsNH/z9VRfw+zE0A0wczNtRBZQMq3KY=;
 b=oG7hUABvXcHiP3meW5Yq/GrU5IxV3rRaV3CTJc2ZIGjK+z9YNv+RyuN5PYMlyGK6dbNQDmCXuFc7FXhIwgeZs+dq2Kzbc2omOM0aKwI/+6YE7q1AVdDj5IJfZ1wohVKdXbezB4o8oHQB6Bp4IAOEyAYs0WhMLTcRT1HE0vBZscraDnjPMffy29yZfjvln7h7rB+sWuXu05NR7aBFuDO90QoYKnwG+KV3isPe2yqaZvPQpscdL3J5zi+jGkK13aSjotGVZKWeWBCrdiwFcZh9lBXV2ftv8KzAEEj7OnAMZHGMJHA8qcDY9Dlp8RV8s/BpRZbqIX92ziYs9UrMnwtXsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8993.namprd12.prod.outlook.com (2603:10b6:610:17b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 15:02:09 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 15:02:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 08:02:02 -0700
Message-Id: <DK4C92FSD0VC.3SXDWMMZQMC6W@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 0/8] rust: io: register: allow paths for relative
 register bases
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
 <DK4BO8HWCEPO.3VN9LIY5UQXKJ@garyguo.net>
In-Reply-To: <DK4BO8HWCEPO.3VN9LIY5UQXKJ@garyguo.net>
X-ClientProxiedBy: KL1PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:820:f::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8993:EE_
X-MS-Office365-Filtering-Correlation-Id: 23de37b9-caf7-4914-3033-08dee7390953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +vgb+WTse4WbDiWWiEo3WcyLTYp0fb3kJbnovBAd6aboz2MsPVr1TTkMhIXeDbM2PkBWwtUdTzWk+0aRV5hLGs8b2c7LTk+dCgQdKX29W9GRs977OnHjDDR8DPTeonMaoiFqXJdwSTmzeEaRcp/wPE6x5LGf52zoUNKrwAVaofxW9QeiKBD3uT1aTTS0wA8jgbef+7rt71SZeNF44RB0nA9/pgi7N+x04zO/DpP/0r/zNbOGi+Ci9HeRYL7H6EF4nDQHIGFgFccj/L5NVdfoYSQVSzrU4HZ3pb8MLIiYxtafr4JwDyfmUbnPrxSlQkHNhrJ/nInsY/USHRQEINHdW2V4pKRcyAfCnOOUAP61psKmIhBjte1jEmiESpCHk8t/h/7g8ZAyNH/iUpf5flsHf74lEgPxGeu283ADK2VfCGwWoJ4JyUJ9MldmXN8vAEHTcJ+HMx+R8nj9DWFhax6yY8Y1ous5recyOCtcV1lhv7C23yBWw6KKMA1b7g1LW4xeLXTxqHPrzJ7Z4m9Z/HVoUbD1VagZ8xsoGorDAnghbV0aO3KW/3AYAKNK1Lx7v4M8hkBeiGDftNnLb+Xabz3UZVjse0V8oK7Y+wO8HSYZPdfflfggRoduRvef39RVVmO9v+/DzKOTlLwMwVWiBflqgBL1Eog5ZPS5jy5vexREfzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0NsQ3EweTBmTFM4cnNVT0lxV3JwdG85eVlYZXMwanUrc0cxTmh3SWRsUWpO?=
 =?utf-8?B?Y1N4UEZRWURkMllWbHpuRWh6bXBJYmVRc2V6VGZ0OGJWRlBCU3dPVmdhL2dp?=
 =?utf-8?B?YTRncHVaR2lsQ3h0dTQ1NHVNN3I5NU9iZHpMYXEybTY4Q1lwVjN3dXRKa0Q2?=
 =?utf-8?B?MDhyTG5RcHorUmdmMldRSkszSkZTaDUycHF0TmFpSTR5b3ZoV3NGbzBUajVx?=
 =?utf-8?B?UjVGOXY2OElqT3Qxc25aNGJNeS92VkhNVUt6cWdLRkJBaG1zckozNDdUQVYv?=
 =?utf-8?B?dzRIT0E3alpqNFFLcFRiN1cvZmEzSjVKbDZLcXNPUnBxSUtSMVVHcHVOcmxQ?=
 =?utf-8?B?WXluV0IyWEZsOVdFdzZvUzhpeE1DNzJ3RkcvMXd0SDc0NnBtRmE3SnN3c3gr?=
 =?utf-8?B?djhENzhZZklOOGZKbEV4cFNzcjBsdUEwZS8vN1VaUTM2THZiR2dTQ1lPZUhr?=
 =?utf-8?B?UG1IaUt2cnY5ZjRnUCt0YmlwZUFJNFJQK3B1bnRKL3JZV0hKYXEvdUwwUWts?=
 =?utf-8?B?R1p2SkhTeUo3VXEyYVNIOE5MbVlRbnZpMjdLQzlGUUVTZmtVZi9SZW1hYzJq?=
 =?utf-8?B?R0NPQ3ZkeWZJVUYxdHlPWndPMmVoWlZYeFJMNkpOZVh2U0Q2R3FqRWY3WWhY?=
 =?utf-8?B?T2t5V0pqdFRvTk1aeUZCRDFqT0ZLMUllaFNzM2NGTm5LdTdHemJldUlpc3ZJ?=
 =?utf-8?B?TUxZTWJRK2poVHRWb2ZaVU1PeVUxTWJiQlMra1ptQ1VHNXJOSDhudTB0d1V6?=
 =?utf-8?B?Y3RSZUVrdk9Yd3ZIakY3eUhycTVadnlSd3ZQVGg3MUlDeTlIK2x0TDFQVXNL?=
 =?utf-8?B?ZmVXZ3JrUDN4bE81a0UzMjFlVnZUUjcyTTNBNUNoODFoeGpjWkpjSGF3TXVS?=
 =?utf-8?B?RkVWWCtUc25PQzRKdGMxMXhPMlE2Y1RQUGd3V0t5OUJKQ0g3MzI4cjJic3V3?=
 =?utf-8?B?cmtGNE1hbTg5YmkvWjZMMTU2UkxGdnBwSW1yaU9lRVR4TjZCcGwzWjhTWTdK?=
 =?utf-8?B?R1pxb3Zld05XaG9xMzdtOE15OW9JaGNGdlpQZHdYUUg4d1dIOWY1cnNac1BO?=
 =?utf-8?B?bFdrR2pMVHNTWjFMR2lrSUo1QUk1ZnpJRWFYS085emgwekEvaXNkcjJSclNJ?=
 =?utf-8?B?ZCtjREcwdGV3ZU1GQk1FVUdpRmZNRmhBVCs4UzUwNWEyU09tWTdJREJRVUhF?=
 =?utf-8?B?U3dqa3NFRHZTdmdGUThlT0pXRi84YlEvWTA3RC9FZ1E5UFlPOFNHNDVBUVNh?=
 =?utf-8?B?WWNmL3NKSmJ2c0Uzc0RtUVpaaVBiL29ZZElMdWR1RUdUYUYxOS9HZnpvOXN0?=
 =?utf-8?B?WFRUaFZ2QW1YTUJWdFlFaU9acHRLK1IyKzh3QkV2ZkhLL1lRVk5WVEtYa2c0?=
 =?utf-8?B?MFFqak5nYU14ZFBvNnI3R2txQU5peCtwUHExYlpLV1pPR2lDTWRDaTJvVFll?=
 =?utf-8?B?RTJQTFJjQ2lrTGVYeUVTTzBUQ2MwQXNPOENjZ3R6dUNsakZ2REFjbXdNeFhj?=
 =?utf-8?B?RmI4VlYyZmtTaTlCZnlsM0c1RndoQ1RDeDRUNWlsNnVLanYrVFdzcSsrbkpQ?=
 =?utf-8?B?V25CeEx1MnZhMkl1LzVYK3BUSXhMdUlJcGowVjZYSVY4VDd4dEZLcnVnLzBE?=
 =?utf-8?B?ZFJkUHdUcVRTK3VSRWFWSkphUUhTTlpTWWZSUmVoSGdDam5OaCt4RXlyZzZ0?=
 =?utf-8?B?aHdoYjBKdDFMVDhUdUZqWjdXSkhnWHZxbUNnaEc2Yys2TlpMYUNGZVlld0Ex?=
 =?utf-8?B?eDZwUDRMdW1RK3U5Rm40cE9Bc1B2UWVYdjg5RUtJS1RtVEFMTmFIREFvWHdQ?=
 =?utf-8?B?ZUM4S0xKdmo5MHpzbjhLQjBjUXNWeWVUVEc4dS9iWjFoOGJnbHVIZ0RmOEIr?=
 =?utf-8?B?ajZCVitOUmx1ZVIzU1hraGw2dVBJMmRGNjFnb0tYR1hVZnFnMDFZN2ZWRmll?=
 =?utf-8?B?c3dYR3RYOUpJNjgwUDA5djAvWjczUXhqWS9EajdyRVR1QktzMkZ1S0hpMkxx?=
 =?utf-8?B?N1dZTTJXcVh2SnFHRG90aFR0QndLQk9La09Xa1FkNmZUbGVmTmhoTzliSktL?=
 =?utf-8?B?aUl0WXlWRGFMdjVZdHNMTVp4T0FEWUV0YnFwS0lOZXRQcTc1VlMwby9pNUZS?=
 =?utf-8?B?UEVTb2pva1pkZTI5TTZOUXF2c2M5MmtldVdEZndGcnZsUHY2TG9Gam52cG9T?=
 =?utf-8?B?eHAvdmlDRWpBZU9VeHRGN0JzS2pTUGx5N1k4R1gxZzM5bnNKNk8zSHlrU2RN?=
 =?utf-8?B?eWZoT0F4T2xMU2RoTDdjVW9yVGFKL2hhTzBzUFlPK1BCcU85aXkrdjlqaTQ4?=
 =?utf-8?B?VzhnbmljRmMvcVR6QW1RdkZpY3QrWndQRnBZNE0reGhmcUxhRjl2Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23de37b9-caf7-4914-3033-08dee7390953
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 15:02:09.0170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MOZ4h1CZY/qRtgvSAJgkhHKIw0syEmrGzRywFA62qih4JhfQeblrkcUEVWExIF6EyhCLgANnS/v4TlLuPChhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8993
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

On Tue Jul 21, 2026 at 7:34 AM PDT, Gary Guo wrote:
> On Tue Jul 21, 2026 at 12:00 PM BST, Alexandre Courbot wrote:
>> The register! macro currently accepts an identifier as the base of a
>> relative register. This requires base types declared in other modules to
>> be imported into the module containing the register declaration, rather
>> than allowing a qualified path to be used directly, which is arbitrarily
>> limiting.
>>
>> This series allows path to be used as relative register bases. Since a
>> `path` fragment cannot be followed by `+` in declarative macros, the
>> `Base + Offset` and `Base + Alias` forms are replaced with `Base:
>> Offset` and `Base: Alias`, inducing a syntax change.
>>
>> The first two patches clean up the macro's internal dispatch and
>> arguments in preparation for the change. Patches 3-6 gradually add
>> support for the new syntax and update docs and examples, while
>> preserving the old syntax. Patch 7 updates Nova to use the new syntax,
>> and patch 8 removes support for the now unused old syntax.
>>
>> The series is structured this way so the Nova update and deprecated
>> syntax removal can be merged separately, as otherwise the whole series
>> would need to go through drm-rust.
>
> I would like to avoid adding new features to relative registers as I aspi=
re to
> get rid of them entirely with typed registers.

This is a fix rather than a new feature. Relative register bases should
have been captured as a path since the beginning.

I'll be glad to remove relative registers entirely if projections can
cover their use-case better, but I would not withhold a fix while a
replacement is not visible yet.
