Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F457CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A027C1125EE;
	Fri, 16 Oct 2026 07:15:35 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7D11125EE;
 Fri, 16 Oct 2026 07:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8fXC+8U6PSKRRvLTwiB7iVI5OKNbR86gpxd8X88ZAY8Xbx7jlzjN3G+qCyzxcC9yg41F8+bkBFl0HK4XvZUerVtrIlYKIbj6X8V3tyCC++CuPfLSBZFGZ9Ktqe4lVtuD1AICah2RGl3Q1pNysUz/VO6OlBAkRhYkzYXRPl2OcnZ43mb3qNjGLv0Np+M/kKlUpkbQcnpaKz5ynvQs0GDVWYPmX4z4AkcNBCnTNLWf1VZu1VCH0i4Kzp9FRoJXk1BwYd5kOlnqA4avGW0TQVOYbSNJMonsnkl2MXu4R/kHMtmEBFcHSSnQ3jX3WN+aBHcZ0a7qAzbjHqh7DMi6U8wgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85jJd8Z6KFRxAUBiivkFtcLWKGyF71tWy+Xv/QF+bT0=;
 b=QkuqvG9bKujOz+cC/SIabTuCtkSpsl+bIs4qaHQJnygVX1bYPRrDMNgga4/SatpsiSC6aCaHgOHwBWbNBvOhe59KjkIEFPrWP781Ps3h1pu1LyF8T9FK/oUJlMKT9UUIOm6DjIEAf8jBWLV8QHaI2/QJCl62v0nJXefAgNrw/Jb2A678FlG1g/0t67xt4M4rpncstIAa8L2pmGl5oGZgB/oLVrpSZj4tyU9NkkQH0ObwGEGMFNiTPVwgXFNK/lIda9NMs/VCWMejGegKB2NNNkl9xJShDnds37o+fIB4fq/oQ3N2q/Md77795PbkITNDQX5i212758PzuVS8V+gDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85jJd8Z6KFRxAUBiivkFtcLWKGyF71tWy+Xv/QF+bT0=;
 b=VFK4wE8l3ZG/Ucie6BlU89hBCvDQBbQHO85eZWlNcnOMnUgn2E/6c63Qed/Z2nu39bdmInXu7g36amhoFytwRoAaenwygHlIPEgBQnk9kEcRhDFQeeo4X0r1Bzsq+sdaFeZ6ZR9Rb/NoZJndktvO5MX48Hv21QViGcQf3I0k9NUrEET1mm35A4T4J1j5k1jv2OKUFLqNHm/lkPra5HOgRwR916WA0baLCsLimavyWsy5izdfilvfaF4/3vXicToetEUDgqKk3v3GOdaWPaGYLAe0g5RbhxQcvEf4zpukMBsTsiQcz2JOn6Sij5TiUmfIHkKA7RcJT+lEOnisR79ZzA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 07:15:24 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 07:15:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 16:15:20 +0900
Message-Id: <DM62T4RN38EX.2RMVNDEJV9T5U@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v9 8/9] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-8-0d6cca376cff@nvidia.com> <aryYkkB9j14xnWo3@yury>
 <DLTA93JE6VF2.37UGB3SWU6ID6@nvidia.com> <ase7IBtZjQsPVWSN@yury>
 <DM0D75ZTTQXJ.2XADVI38UGH7C@nvidia.com> <atDclcwHGykChUim@yury>
In-Reply-To: <atDclcwHGykChUim@yury>
X-ClientProxiedBy: TY6PR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::18) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: ba498fdc-e726-4d55-b327-08df2b553ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|376014|7416014|23010399003|11063799006|4143699003|56012099006|22082099003|18002099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: Sv/dv6D21XwD7qILl3DVZbm/QwAHZMMgOTmhEgrT8sA7gjxi6OD1qRJyh9bCV4rHF8QrEzA/kVl8YyVn01yImMu4DwCLe45GRyddEch/eLH9LXs8eTyLAHpcwW08H4dXBfgOMZcRuZQaN+BZyK/0fhNDC0oL6T+4iaZX+sryPdpbhTSWdwpGxe9OtCfo/u9SqnAFnKtVa8bbYBDCDcrGcQULaZuXY44enF5hvTKoIFMomLvTsQDf+iy18B+YzSaEAnJrPG5BcxwueRM50wEBo+YvLpcGe4lyhmJi2hq1ReKLabFxhy69toKrNLxVPtcUH1L0Kj2ueIVGm0smTuzz9RXSnIP+P/ZzFqG5urKCN4RIKLQI4dKkJSMdfyjNat9z30uvaJJBBaT3+DH6R0Gtx5+BIxj9AoIE4YF+8xeAxMP1jbI8XfjoXhLVAQ/Yj2U8tiyLv0IkTc296Iv8xBsm0TpzesTU86A4MEyolgPnGIqTFKfh9/RWqVTaNxPbiIyg5htQw39RhuS9NIgoWK+9RSLQlJyslazmxZBhGbSN37vAV9AWL0hhegx7XqqsZXHv39Lxfe5nb8D75lXxj0o8PDED0K9nDSA1fzQPlhpMCeqVXIAjH7PLSNbgPHmqRWQSENhubU9w34g+w1EDpCpdOKqxKh377waGdCteKtgKSc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFV0K2t3dmxxSmlGYWlyYWFzVDk5bHBhclBQYkdlcG9wWjZKQUdqTmJ2YW5U?=
 =?utf-8?B?UngrQmhiT29xVTNFZEI5N0FYdnIzZnZ3UjdNNVFXblpVT2lTY3NkNmd6V1dq?=
 =?utf-8?B?NDBBVG1aOTVCRHlFVmE4SWFuSUtnVllJOVh6eW1qbFlLeFFXenBXK243bVRp?=
 =?utf-8?B?VDFscHhXTWJSMnN0Wm90YVF5K01mZjlhM0Z2RWNGZy84aG1NZUdINVI4S2R2?=
 =?utf-8?B?QnV6SXczWWFqMkFac1o4Y3pBV3RFMFA5L3RDOHM5ek9PUlliVEduVDUxVk94?=
 =?utf-8?B?WmdTbkRDK25rQVdySHIxTUk3T0tOUy90V3hORkZZZm1mSDNXQ2FMTWhDckxY?=
 =?utf-8?B?WUR5N0RBM3Fqcmg0VkRMVUpheFdjRXFadFlQR0tMM2hZQlZKM0xQdTE4aUhx?=
 =?utf-8?B?QjFkZUp2NWEzcWJZZ2x6eDZWdXdDQW1LSjJ1NExoSUdMOTVIMkE5Z0w3N3Ev?=
 =?utf-8?B?enovMVRXZ3oxeDVtRjI1ZzBBajRyaldtbVJ5L0MxQlFKNlg0Y3kxZm1LdW5p?=
 =?utf-8?B?OTlZcmZwK3JwdGdMVGtmYklrK24yZkdWMDh6d2d1KzVNWTFPdmMxNEpyc3RH?=
 =?utf-8?B?b05tTkJUelBYSlM3ajNjd2F4cUlOZm9oOERFdmtCTkptQmtNVmtkSmViOEZj?=
 =?utf-8?B?NkM3YnFDL1p6YnFoNnkwQ1NoeDFPUVhiWkV6eUdEYkJhTDFDZTdPUExzRjZ0?=
 =?utf-8?B?ZnhIZzZUUk02M3FHRnRmSTUzbzY5aUFSZlRHVitDTTBGL05jSk5uVFoxcUx6?=
 =?utf-8?B?bnQzejFsU05FSkZEV2NnclhjbjIyb1A1TTBYSlliYk9YQW43b0FUdHNTcmFL?=
 =?utf-8?B?RkdtcGJ5V3pzV0E2aHpibkZYSldRdWIvejVHN3lBNk9CeVlNRW5BckFtRnNM?=
 =?utf-8?B?ZDEybGdJVG8xcGRveHJLdUp0UmcxMFRHM0hONjU4b2pqU3hjWk9jeDJZUURV?=
 =?utf-8?B?OUtMckN3YWt5bysxQWc4eXlpVXI0Z1ZpNjA0TDNZVGI4dXhlMWF2Z3pRODZ1?=
 =?utf-8?B?NEtYdkFMV1BzMUJOUnRoS3JYQ09YQUJMZzNNY2VXak9RWEJDbk13VEgyeTJn?=
 =?utf-8?B?c00zM0lCVkdVekMvZHpGcjJwOVdId2U5NUxMZERNb0R5Q3oxSDF5L0pZMEsr?=
 =?utf-8?B?YVZMV2hoaWNtdUJyZjZOYjhTWXlYVWpMc3ptQTFsakRjOUtHckZsZ3d1KzJU?=
 =?utf-8?B?YlIzUVlkM2wwWkdYL1RTa2xsYmdVaG9KQ2FFRWlvU2RYSXVuSk1kei94QnFp?=
 =?utf-8?B?MXRuaHpCY3dhSEwxK3RJamZHbzNvZThockhyOStoUksrMGdCTytEYVJqaGow?=
 =?utf-8?B?Q1BZVTAwVU55Z3BSNGhoZ2tGcm15QXRHbG92Qi90bHdUS1RyOXAzSXpKb2ls?=
 =?utf-8?B?TndSbjFKVXVCcmdtNm1zRkYxeTk2V1daK2lwbWJZNU4yTE1oMW9IcGR0QnEz?=
 =?utf-8?B?TkxpQVB1dlBmVC9NSVM5QVpaaGQ4NUNxNzdnLzd6M0lUWHFXVkJNZmVxNllX?=
 =?utf-8?B?WGNkazNOWWY2MHBla0QxQ0hrU1hXNGZWZVc4dm5ORG82V1ZjUjNzUmd5Yjkx?=
 =?utf-8?B?NXRWK1lNbS9HYVFFdm51NVgyeElBaHVMNGpoVUdHamFNQ1llOCs5ZzN1d3RR?=
 =?utf-8?B?OWhncFRSaFRubjBhd1NDcVhvc01xOC9QYVhaVkNkRU5lR0hXZVJhNmVmRktK?=
 =?utf-8?B?YWR3ckY2bGlhRmFBK3RYZVVYeVVBWlFQOHpDeGhtLzBsdkFCT3U0dHB4a3hM?=
 =?utf-8?B?eWVQUWlFVC9kUE9NN1FrRTJIVFpTVk8wMk5aYTNwazFsUm5jeHh4REd0TERo?=
 =?utf-8?B?cnlRbVVTOWNhTmNaYTZjTVh1Tnp3YjNNMmFMSGVVdlg5bFpOMTBVYk9sY2FR?=
 =?utf-8?B?QW5sL0FyM2pycFgvWW1tQzdJZWdtMjRub2RaUnUyRnh6eDZidWd4U21YdWhO?=
 =?utf-8?B?SjZsUVlRUmpUNGVkL0ZJeVBDdktJcmRjaTE5OXh4TWRVR0VPNWdXb1N5K2Jh?=
 =?utf-8?B?czRPSTZ5c1VNc3VqL2hqUGNqbEpIaUg0dlczMzdMR0tja2hTT3JIcUh1TVlL?=
 =?utf-8?B?YUZMWTdJUEtyNmFYc2R4QmZINkdLTnJucXZVK3htNU5ZOGJmK1J4djR3RXIw?=
 =?utf-8?B?Ny9zUHhQY2hhSlVhUlFiMlNySDl1UldXTm5nUDd1UklWZ2MwV1lWU3JNTzY3?=
 =?utf-8?B?Vkp0MDdadWN3K0FJODdZVFowUk16SEI0OW1RKzVNZ1RyYVRIRmRHckhzcmdo?=
 =?utf-8?B?blNSTjZGNEZxZ2o5SjhHRTJzVU5kY0M0VGtXb3NUNmdFUUJBS2d5UllBVmxN?=
 =?utf-8?B?U2lFdHZ6WTFMVGZ3ZSsrMFZFcnVZUTM4YWphTTBNRWhvdVhVREtZOUFnRkVT?=
 =?utf-8?Q?7RBzuw2chTbG1uf8iOdjkpf1QMNHK3QoeAiDQQvZbvsJK?=
X-MS-Exchange-AntiSpam-MessageData-1: O1zefFXfLkoYOA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba498fdc-e726-4d55-b327-08df2b553ee3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 07:15:23.9392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNzvzn5fdd5LZUPn3+aGNoQKvqBu5gYGkEEIp0X3lrvGLoQ6kFw27tcYKxQxeBVmgr9LASI+8vR3ydxg1XCTPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709
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

On Thu Oct 15, 2026 at 11:00 PM JST, Yury Norov wrote:
[...]
>> As it turns out we would never perform a zero-sized malloc, even for a
>> zero-sized bitmap. `IdPool` is backed by a `BitmapVec`, which up to
>> `usize::BITS` uses an inline member as backing storage. So we would
>> never call `bitmap_zalloc` with a value of 0, making the safety concern
>> moot.
> =20
> OK. Then please remove the 0-length alloc with the following re-alloc
> example from the patch. use 1-bit allocation, as an extreme value, if
> needed.

Sure, I will update the example.
