Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257D1C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 05:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6125710E0CD;
	Fri,  7 Aug 2026 05:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IAyy4CCM";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010000.outbound.protection.outlook.com [52.101.56.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB9B10E0CD;
 Fri,  7 Aug 2026 05:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV/fyInIJhJmq40htdSMciGED3tLCZqZUfu8zSAR59CAzm0KGmeUmwhAlI0WaSFR2tT7ovlTec5KWbyeCxyQW/dvidMZMbVbvR8UAHszTx4XTIrlFytOJ2B7668chU/7sR2oWybf2G3c789ZgtMogHosIqpVsdsnSQe686jPv4zF9NU6vknCsOnAGFrTP34Bjj3lQyYYOgtI52YxLsMKntT+IsJVuYOmFazxn1ROv1nquCiceKlcIWRLEiVkE+8ZWsjhFuOEqEc5+voJefK1IT+M2i3w1ww9iw3CXSaNHrs/foaekpx/IKm1SsL7nGsYzbVC9TdRUxgQzSstWhm77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/eHAJqk/jy6euDHsV+Kt/veOAlK9QH5PUhPEYSnStc=;
 b=Ur1Sgv9B0xL6XXaN1cDX9F1io6LkJZgw0I1xa43tEYH+YnhDvvkQbYqSux+c9eN/BJWvRIjpVfJeACCqHXXscth714AXnPcTHwfYsYGULixzI4EPJCs9hkaucxGMstw1UPZY2Fp5VLJLjrQf8t6hGlU3ETC95TUp4kjgbcI+SRQKwrWvQl1ybeSdZvJThuhuJ4UYr5iyua1zN31kbyx3M9L8J9AioYthejRN0bJkdLXrOYTysJsy4GdovO1An3+K1ukNDAP9vTQ9U6Ln8l6FWvfjjcjJgoWTSJArfzRwNL04EyiShiUl4A+LU3MLZABZSi0De5JgMWWr5rEinC8TeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/eHAJqk/jy6euDHsV+Kt/veOAlK9QH5PUhPEYSnStc=;
 b=IAyy4CCM6piEBV68pdhgwZ9Jx0F4sDlscCuUyWWL4VGkHGlVRjuNHP+XuST5kjcCyTqkett0+qO7pZjWNoJEQve70kqA5fPYzST52rWFVV4MYjqlPmHJrchNkRDCyuA9oepJ1//flZ+FXbQKWfWFFbjXRWhnHcmNyzJx3zlShxKCiNwLolInf4YTySKOVmGjFOUOxCX49O7vL0WhkWhGcILnpFDh2ALtbuH+AqrJv6DbfgaZdXTbqQnKn7gACJncLA29s20Jb2Gz0c8bE2CEzMTvGl/yEYIUKZ7uGfMXQeJWXA9AKwnurQuD4OcMnaG+v3XKhLEU7ezzgQokIolKhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 05:39:21 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0292.022; Fri, 7 Aug 2026
 05:39:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 14:39:17 +0900
Message-Id: <DKIGXGJ5AQ77.23M6T9W3W741Y@nvidia.com>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 01/12] rust: io: add Region::try_subregion
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Yury Norov" <yury.norov@gmail.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-1-ff3e84a75dac@nvidia.com>
 <DKGY508IDAS4.9E9983YWQ2F5@garyguo.net>
In-Reply-To: <DKGY508IDAS4.9E9983YWQ2F5@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0105.jpnprd01.prod.outlook.com
 (2603:1096:405:378::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f4222fa-5364-4ef5-492b-08def4463b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|376014|7416014|921020|18002099003|22082099003|10067099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4HVULx1f1x93KaIVkK0GX7emwcGTmiacRlIL+qJoRQVFxKTJTZCyYcxEIi2YS4PONEtfR5w1RWdmSVTEIk557i4eUHKE+KHgLSvTSgsFsL7enJZvJxaAFJt2555nsaH+BhXsjqz084r53xATNa7rMC4wsURg7yvQIGMeeUJJ8RemGmghG2JhDzxw6g64FHSX+tcj4bmYnKH0fdxqp7kK7d85DeeWHsk16QZN4o1FzH146GYsm30OGoQVJf5XCm58CHVmn9QeC4pXyTFPewfrHyXFlgiw0zdTctSQyqaX5Qkmn904oB0b6W4lNEeIrNHXSRYDzfHpf4CPgNrwwKoFfu/XQIQ6Jt2KON1JOef87xXpk+1UBg2/kzhcB/Ct8PaHQdJIq6cmApqS3vxJPySma/L4U11rBifccNnnupwjqzb8K3H5H4YlIzeOSfVrPZDV3ia7ZVwa8n35/fN+WHGgOYloasxEQjamfa3KEMAlaMhGolMJfJOD7yyWZyu0y4URiKDtylAATt30J4GA7MeS6Ua7vhSaTPg1ajzVJ0GkH8yLp7apun+GHKMxRhTcRZPz2IWi8GUyg2bn2HZsMoQwKNuCSegiYouiC2TsjD034t1aPcydNrkb2ovdGh8sphTurUNxVmRLOfp03L0F8cm+GVZ5Kd2ZV8J8QYufWnOnI5pfJmNTdYE760q4DhgU919rgMgoFUfs9gsNV653zVXfng==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(376014)(7416014)(921020)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVplR04xdDA2TXF6b0gvcVlzb2FWQVdGcHZ6L3NtNkNsbFpzZHR6NFBKUWhu?=
 =?utf-8?B?b2Vhc3ZjTmlUeTljWk5yZk9zY1haRTBTc2FxODRYL3d0NzE4aHpPVkcwaitU?=
 =?utf-8?B?c1VlWVZvRHM2WFlrcXFPOVBNaWJwOWpYTWtnei9KblVNMnZyR09admJYTThs?=
 =?utf-8?B?Y2dSRGpMUEFmTXdWYmpBS1BtTURNVnQveFFZRXZoald3VEdBQVBtOXNxQjdX?=
 =?utf-8?B?Tm92Myt1ZGlVSnBFbTNSYWhLR2hUMWExOWlHSUplZzVMdFlrNHNUMVZkVTdO?=
 =?utf-8?B?SkVDbGlXbnBheGIwcFNac3REekwvakduME12RXk4dnFGemFHYXhuOFI1MDEz?=
 =?utf-8?B?YXl5bGxlczJuck9YZ0REVFZEcUJIVEJ0VkJpVDJsNEJtYUVQTUErNU1oWGhJ?=
 =?utf-8?B?Y0pSNldQRlh4T3FlZkVxSTlnTTVJY3BEdEkwbmdObjFkb2FERHkwb0hrK2NG?=
 =?utf-8?B?NlZUbHZpZGE0aHJjSnBuUE5yeVRSK2hDOXVPTEJSUE0xbVJDQjR3NTU3eWdR?=
 =?utf-8?B?a2lXcUZLVzdJUWN1Sm9MaEtnTlhDQXN6MHZEMGR6eit1eE4zTDAwVUk0ODlT?=
 =?utf-8?B?MDRHRURheGFZbk5qZGRrVUxOMWxNOFZ5bktiU1V4V09pR1Q2KzdyMFV1STNU?=
 =?utf-8?B?elFjeEVNME5tME1hNlIybk1vbWhPOWE1a2ZkL3JjTHFYWjdPVFhvaTNicUV5?=
 =?utf-8?B?ZE1nYUZUTkU5Zkcydmh5c2laV1J2R0xVZk5uWmpLSXdLdkpueUp6NWk1Nmk4?=
 =?utf-8?B?aEhCWmo1N3FFWm5TK0hFOUdjK2pRSVZaazJ3WmJwWDUzdUR5K2dDS0lMV1hN?=
 =?utf-8?B?dURKZmFCZzQ2cUdDcHVSdUVGRDhMTDFacGtQd1NJaFVkSDVHSUpHTVF1KzQz?=
 =?utf-8?B?bjIwZzFaeE5vcDNrM2svM3hOYTJaOGt0SjFlMkhLQUc0d1JMVmkxdnp5RXo1?=
 =?utf-8?B?Q0ZnV0FuYmlIalE5T045OG42bmVobXk0SFhaQStzTGJIbXRMU1cxYVRoMDMz?=
 =?utf-8?B?c2YvRGZtK0JHYmkrd1lSamZaRHl0aW5lQ2ozTTVWdlA5S3dOMjQxZmNvbFYy?=
 =?utf-8?B?Nm1GREMxc21hQUR6TWdKRHByUGhUcDN2aDNRMWdLdkpFd3dRbTU2ckVuYVJL?=
 =?utf-8?B?b1dKMHhCV3pnZ3IwREJrM1ZaNWxOVTZjVjZtUml0RG8rbXRpN1pUK3h1cGFw?=
 =?utf-8?B?ai9TMS9WTmZuVGE0bXViZlNIUnozNnZ3TkpmWFBsV2o0b0RmcHJDa21iS1Nj?=
 =?utf-8?B?a3A2UlpFajVpcWdWVjhsRnMrbTkxSi9NRWQzS3FHOEN0N3JzbG5QdVhoOUFi?=
 =?utf-8?B?bForT0U2Z0l2dDBvNUxldXl2T3JwZGs3b3U4RXJSb0pZL3VzZGVyelRVdEp0?=
 =?utf-8?B?VG9BV0pJdU01R3F1MGFrbkpLMVR5eHVGWmRqNlVpZTNidkNTd3ovU01ZL0kz?=
 =?utf-8?B?MUFwby9ZK1AwY2ZFWHlSNzYyMElGb3dqNkNUK1lmcElmbVY1VzgyK3BWRGkw?=
 =?utf-8?B?M2Q2L1QvM3lhQlRVZ3NOaXIrM0NmK0tmTDI2RHE5cmZqZGxicFYrc0tJdnRp?=
 =?utf-8?B?cURJVWxEc2VsNG1tcmIyK3VJVmp2bTNCNHR1Q1piYXg1cDM1ZFpNRXcrSFBN?=
 =?utf-8?B?c1NXREYyRXR3N0xMSUlCUGdObnp2MlpCSk9pdUMrMmRtSjVJUXBCb1VZWmti?=
 =?utf-8?B?RUUzR0d1RmNWY1N6WDlkTG1lbmN2WURSZFEwKzQ2VlhrczQ2emRkaThXL1VG?=
 =?utf-8?B?YjhDUDhBY2Voak5mZExJSkovcU9YRUw4YTMzNEJidksyNDBWR0xjYVJuWGIv?=
 =?utf-8?B?TUp6YUlLYnFLYnJLTGNYRjBQTUk3MVZNOElrZDdIWElkelF3Wk5BSUE0djR1?=
 =?utf-8?B?YmdoMFFnbGtNK2pyaDFTeUxNczYwRU1KeDBpZy80bWxTVkRianoyN3VNc3ov?=
 =?utf-8?B?dEVBdlZZRXI3UGsyQ05aQVY2WDFWQ0NDKzRRN3RLV3NPSEZ0aVZqT3F3L2hE?=
 =?utf-8?B?b2IxdXZUTmlWRUU0Z0xGdkdSRDhiekFpMmdMTXNibmZNLy9WUlQwU0JVR2x3?=
 =?utf-8?B?dWVsbnp3Qm1rNFZCTXJwUXVBcmJiWnV4QWJPZlhVb3RRWnlENFJGb2ZuVzdo?=
 =?utf-8?B?blRCNi94TlZqeC9TQm56TGpoL09ZcDJTOW82ZHF1RWdLZ1VlOFZkcDcyKzdN?=
 =?utf-8?B?SmJ2UlIxUWVvUEtEOFFCdTNXYlVXTUFSbG1zUkw5ZHl1Yktxd2F0c0ZXR2VY?=
 =?utf-8?B?TG5RQk5wVmdOWEl1OHdUWDZ5WFk2UWUzVWc1MFhsQXBKaGJpTzFWMkRLNmZv?=
 =?utf-8?B?MC9YZFllSTU1V2VHdTRLcnBzQkhQL0NwUi9icW42UXNNSzdCbldjQVprT0or?=
 =?utf-8?Q?T+TNFROYiOeu7mHTZkfu2zKixJSFnLKhEA+TEdRcEkmbH?=
X-MS-Exchange-AntiSpam-MessageData-1: ne7ynCEGOmxuQw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4222fa-5364-4ef5-492b-08def4463b3b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 05:39:21.3202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DANxhlaRTcwt3Ywg1hGWIu8sDwpNONnD4ngPc3D613lBY9aGlTtKTZ6nCtIuu79UrSJCYKOL4ZdJaBIqFUh5DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
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

On Wed Aug 5, 2026 at 7:43 PM JST, Gary Guo wrote:
> On Wed Aug 5, 2026 at 6:44 AM BST, Eliot Courtney wrote:
>> Add a helper to get a subregion of an IO view fallibly.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/io.rs | 31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
>
> Looks like the case where you need this don't actually require a `Region`
> (dynamically sized type) but rather a fixed size window?
>
> In that case the next version of
> https://lore.kernel.org/rust-for-linux/20260721-typed_register-v1-0-452d7=
2b60262@garyguo.net/
> will contain what you need.

Yeah you are right. I think a previous version I was working on needed
runtime lengths. But yes it should work with your compile time
subregion stuff.
