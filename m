Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA164606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=OlNtePyd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7BF10EC01;
	Mon,  2 Nov 2026 08:21:46 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012002.outbound.protection.outlook.com
 [40.107.200.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D910D10EC01
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:21:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPKb9jwWkWIr70xsp9ksDJY3UnbYyFCGtCsIdFQj0nbZFNbpAwMzw9B0oM42I7WARCBO0p/QfMucrX0m6HIkNcACB6umMb8u7WhTMq3+Ixki0Jlds51vI5YHkgIkKYod6nktCwwZsMOoeLyNDEvn3fVbNiBYphvbMCoJrGZ4yCRZ82TPBdxBFhHi49cXHZzqgx496OcdXMnlpSrSerSaHLmPRAWry3fbaFYK+0qwJ9CVujY+IhjFaBWcvSfEmcJbgw7bFoFQpOk3lHNdXvn6ZPY7N0jeEBrLjM7yUHdEye/ZdF4y1MhuwTAMKaMgVt1Z7JMXzR1lDtGb+ldo36Ryhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgAECrPxCDihEIhhzCzItgrQLvPPNEcG1lVh2uC3oQo=;
 b=aQg8mLx4vysIPLlM6kyB/qK/EiKhPZfqGEtLdjzANN3ni5hVKzROodKxXI+UW3RDo3qT63RNC2H3eIfPOJ4DO1mnxCGY4v7Pjr+Y90rYsW/R3gXTkcZaYsljSe69+hMW33u/0HX10ALNRozLQBzYQNvwNhPCbY6K14Zl3IgloiH+ou/9vmzilootdznycVzXD3i9vW3mp0161cDi/68wQNHk4FAIz5HSNaXXfP7ZraT9x4P+AHVmW1UIkHNmmrnA+DqN/2BShkbUSWSQSk2QU9s8790Cc3kPf8tHsWAfyzTNUBzPUb4c1oRbFMZfGEeogJForZyPBJlcjreRs1M/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgAECrPxCDihEIhhzCzItgrQLvPPNEcG1lVh2uC3oQo=;
 b=OlNtePyd/dRNma1R5IVBLa3iqz9dbAgtMrH87ZgOpnKk/T4LeywxQ1vnsakXMBEpsx7Zzbh5zp+nyNRVF5eyVIRDZXpVB2aYR7Ln3+gTy7acjKkZwGMIl3lTvCvrlYXLnkid6hqZzA709VuKaJz25fvG89iI6VwB5tM7ZYirNysll0KjTxytbei/mU2C6qkCN6w7ijUTJpojIMAa92in5Yq2ZR9sDWL4BHITpPwzZ3HJL3fVk/ks6BfKvqD18DO2AFqM3OR6D7BMo5/uJDi9W3y6OG6H8SOvei8UY04+X9F8nodGZ6HIts9qmeREn2I4pxB1dPZPEuuqsoKzvca7YQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 08:21:32 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 08:21:32 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 17:21:29 +0900
Message-Id: <DMKKV1J4QREH.3STUO5UXGPVL7@nvidia.com>
Cc: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 2/2] gpu: nova-core: use cv! for constant casts
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20261013-cv-v5-0-113a538dfaef@nvidia.com>
 <20261013-cv-v5-2-113a538dfaef@nvidia.com>
In-Reply-To: <20261013-cv-v5-2-113a538dfaef@nvidia.com>
X-ClientProxiedBy: TY6PR01CA0012.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ec6ef8-3730-4777-9745-08df38ba4d5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|23010399003|10070799003|18002099003|22082099003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: d9Y99m7HvkKcTPWNlHXU2XVRzH+Pwy17fvbtCq/1z1v/8XRIi7X69r8ys2vUQOW27coiozIt9GM0L0EINQRDi1OqUQAKoG7agsXr4GhKI1eh54gqYOEOmj5CwB71TZKVCWiPqRADQDUVON4E0paG+nHcageVSvrDYYzGniRwwxxLF2U3nV6Ws15kovazxz1p9vbobH+9wooxGJ9gWM2gvmibSPSJ/pNbvTXq+n7OjjKlTLTgtvVoQAy+N6ibGlZ0jLOstDp/3I0jccT0GAFwvv+bvmsP113AjL4aLKelzz7YelXhDsf7eWbqslUbhfL2w2uUFta/mlVDOGSA40uB+48FiUTJuiZ86J59p2T9tmdHNdTVcSNxGUhTXwc52iTqIjEGrHASowjoDp9lJPwHFmXWimnwnPfEGtbV4KpMh0ginwDmFPrDnXEXvIV6rL+g1/TOUTu5Fr26BbJErOeIYhPX1BsEMalRQdzy4Fb/BETde+r1Rl4BRFaNHZt7QDWiC4dE9t8WjaqGu3hIYafUzSWFbM1yF+vYeTWurXCsNm3UjYTgs2360xgs+mhvBbhuY+uiM73i0x61ErHfilTPkyL0qkci8uX945N+QiB10eNX4bfw4CCpDFwRUZdD6PVNwJxWRyJZYUyM7Go+cLHj9tkgQKsXlbAZqFulj8AZCkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10070799003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG4wUXNXSTBNWFd2ZEZpV1JjcHBuZTFBUCtNcVUwQkZ6R3ZkSmM4NUN1ZEZS?=
 =?utf-8?B?MmJMYmJ4SHd0UktaMDNpM1FDTzBjbTNrRlRlZzJoQU0ydjJkZVFVNTFQRG5Z?=
 =?utf-8?B?QmZpNXU4NWtkbE5ZK0JQZDFxZzlzT2VsNzE5NlhuNHJHY1Z1ZExNUzFkOGRO?=
 =?utf-8?B?OXRBNWJnbExQbGREMjc4TzNXSUxzeVVPMHFURVBZUnB2RVFtQkZjR2tiUjNu?=
 =?utf-8?B?c3pQQ2NLZHMrNExMMkRMQm0rc2FoMWhGNURNUklKZ0VhWlY3VGNzVElGc2xx?=
 =?utf-8?B?UTRZSEcvdERyOTMxRjBNLzhub3Y5N1JIME9oelRYTCtocWxNTjZYOGIyV3pB?=
 =?utf-8?B?K1l0amRqdkJjMit4ejVnaWhtb2pQb0VBWFNBRXhvS3NVZ3VqQ1IyYytCV2Uw?=
 =?utf-8?B?UUEzbG9QNzNLVUd5ejdnVE9DdUhKRkcyVWJpN3ltcHdoMlArbUsvWWl2U0pP?=
 =?utf-8?B?VzY2emRvMEJIbnh1d09JV2dzZGM1cjB4TytIU21kYnVVZVI4cVF5U0tITHoy?=
 =?utf-8?B?SVFBeW9FcHNMRjFSZWsvYVBUTHJjcnlyRzNTeGJ0UXVselRaWWtIRDIwOFRS?=
 =?utf-8?B?dFFwYWlMeGZPUko3VW95b2ZtOTdWNEEvL09WRXd2TkJNWUUyb3JJZlZmSUwr?=
 =?utf-8?B?ZkpPdlYyajFHWUZHV08va2hqNzFocWROeDgrSWE5c0J5dXpZa0NubVBlRmFw?=
 =?utf-8?B?SnpnYkM2Y0l3NWVPUmdaVm5ORTdNMHVTQkd4SVozTWovY1NxSkkybFZJWGY5?=
 =?utf-8?B?UWYwZ05obUx2VVJsVXBFbDRHOEcrMDdSWW5kZmQzNnY1MTc0VFRlNVpidHAv?=
 =?utf-8?B?WVR3cWxFV2FIVVRPTEZwczhCem1QL3pLYWx0djRFK3lyUURsYTZwUjBBWGtE?=
 =?utf-8?B?NWl6aGcrTVNmcUFzTHJqUTU3dHdXTjEzVmtKLzRkbWFIL3UzV2RRSXd5WUln?=
 =?utf-8?B?YVZTVlp5ZkNUMzcvdjdPSGhWdGVJTHNvRkl3dndZUGpOVjlnUVBUaWF1a3BU?=
 =?utf-8?B?RFQ1M2hZc0RTWkhjbFBVb1ZBREwySm9icm1xZHBkbyswRUVoOGhyOVcvZENa?=
 =?utf-8?B?aEZ6SUNkWWRZcTN1MkVVOFU0VmkwZ0pLR0dHS05iN2xJK3MxMGN5b0Q2U0I5?=
 =?utf-8?B?cmJwMjJxMW5KQ253SEMwdVU3bmx2YUhBMlBYbTVsQlljS3h3WXcyNHVoN3ZF?=
 =?utf-8?B?WHhVcjNKNUhsK1Z4YjFYMUtOd1JESVdIZHRLODFuam91NmdkclBQK1NpbFlH?=
 =?utf-8?B?T3JOMFcwcTQ1cDlRVThKd1JRWjF0L091bC8wSXZkN21tSDh4MXBQbmFaT3ZR?=
 =?utf-8?B?Z2FoMG1vUFRUczhEa2o2dXJNSGkrc0pSQ0IyWENGSTMxbVJralp5cDQ0SlFU?=
 =?utf-8?B?bmk0NFp3akhhaXh1Z2tvNkYwNzNiNkJkZG94WEdWa2l5SW5jekE1cVVZUHFX?=
 =?utf-8?B?SmxTSllld3F4M1pORGxJU0gvelZKOVR4VUhtQUtZcWFXRWtpM3RLZ0wxczB3?=
 =?utf-8?B?bjdZV1lwOU1zQ2xCTTJHTHczeHBBWExHVHRTTHUvVHVPcmdORW5DR1k5ejJO?=
 =?utf-8?B?c3NFYjhYQzhXWG9jZENxcE96cm93ejBKOXU0cVNEVHpvcFQxRzlmRWw0Zmts?=
 =?utf-8?B?cDhmRzVwRXduTEZ1Q0NQMUxsbHNiZE1uLytPRWlWTURoUmVkRnRpWWtNM3g5?=
 =?utf-8?B?ZFhmMlNoN2dqbVlNY0U5eXFFUkJtbjdHSmg3Q0FDSEoxWXhBVGdzVGxWU2lv?=
 =?utf-8?B?dTlOcUZHQkFvalRSRDNQajFGbFh0dlVEUE5vM3ZGNFBHdURqK09zT01oZSti?=
 =?utf-8?B?QUxEREFYK010TTBpVGI1T253ODV3Wkg2MFVHOEJBTHp0dFdkMjB3bjc5TFJ3?=
 =?utf-8?B?alAySzJrWHNjQ3QvSUlrc0hSMnlnbEo0U2pyMzB6clBSd2VrOTZacEZydWRv?=
 =?utf-8?B?aDF3bkgvL0tCUWNhVGViRFpVZExDQnRpWTU5Nmc4YmMrOUR5bnJ3dzYycEts?=
 =?utf-8?B?aDZkZk5BOE5YOGlWS1lramRXajQwMHoxK2lqZzRkUlBKcFgzSHdIeXFaY3FK?=
 =?utf-8?B?TElXWE5pOTNZcHdpL1poajN2Tm1yNXI1amdpV3hrUVovNHVjS3MzV1NodkpQ?=
 =?utf-8?B?VlFubElPSnJqRXMxd0pKeThZSFJONis3T0c0MWE5c0R4NlJtVTJ4UHBXZDRi?=
 =?utf-8?B?T0FvaWRGa3RkMG5XTitERldPMUVvaEY1OHVmeWwrZHZaR2YvbmlNekxkTE9s?=
 =?utf-8?B?V0tBdGptMHduTm5FWk8zNXpUQWFXQ2thS0Z3b29qenB5TTZZUDI2dDVlUlRz?=
 =?utf-8?B?TUtyalJMMnRCbWczNTFwNkljbjhqR0NFVWJ2aXQ0amFkc3RGcWJqdWpnaE50?=
 =?utf-8?Q?eIrTFDIBfFcZ8TMarNNEIVIgPNki52N52QEw7JmyKrvOc?=
X-MS-Exchange-AntiSpam-MessageData-1: UKyZKDSSBNNpMQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ec6ef8-3730-4777-9745-08df38ba4d5f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 08:21:32.4127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8/lKJE4D++AfAaSBhfJmClrZaxbRuroV4/TYBcvGSkNy5Gpu3/zytbGxxVLOEHWUwHhK4ejloPrx94+tZHlew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Oct 13, 2026 at 2:58 PM JST, Eliot Courtney wrote:
> The new `cv!` macro allows safe casting of constant expressions in a
> const context. Update code in nova-core to use it.
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Pushed to drm-rust-next, thanks!
