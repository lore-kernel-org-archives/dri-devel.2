Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72B6606A8A2
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Cspv4sm2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 030EE10F74D;
	Tue, 17 Nov 2026 14:09:39 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012002.outbound.protection.outlook.com [40.107.209.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B0E10F74D;
 Tue, 17 Nov 2026 14:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0nTgxW6ThVyTtD2DdqQc6s4mELkC0l9KEFTxcnO3BhJcrWD87Gz74hQmJ1MhzUvNmfxZCoYbpZGwavJXBDEpDrMddbzxn3qtmCMIT6klek1J+315oX+Gz7tyRxYco3RFFmEh/EucuEU3vKdKRbLJDdVOXlN3HecXV1+ZfQxavZbAp/8wk65qdFWntt6zlmkEsW7MgIA9WxMQAsnMGHkNBEIiMoo6qk3EOgk92c5U3D6MQGZcH5FftIJIvVJ85hpYTo/z0pevjo2fOjIwr5lRXbE/RSoZv25MB976wAMfMhKbtgpLx+ge8+0uexpr7RVDCP40bLiuM002bwpoeY8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3Vx7uevgbBvBijXPW7Cqn2bU92ncp7Zx4VTRQ/H8GI=;
 b=MoRDf3YTMreTAKMRLBjAlAWosJcwcTU97fIRnsmWCZRhehZhzF0HS+3LdCvSa2LjydYvJEfRbUmEk6cf563Quu2D0PjqPmDOFOcrTWEw/YhJN18ffi87LykZ0ao4cvrQ7euMcUieKL67iiwEvarqAj6L+YphE5pxzhaz2M5wKmLAvddmGoi48qEmuwY4PWd3y8Cltj68wxaoeuoqY1NvABS4XqDRvAnz+dxlnOW3AqJ4U5V0j5Rej4n1RKhHaHMsl5E89F8piBeW4L0YXBA/ADyHf/Xabr0ddK4nSEIhOcD/1PH6rGgjB5tfxKizFRgjBP/eIUc7nisj71ieWz4v7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3Vx7uevgbBvBijXPW7Cqn2bU92ncp7Zx4VTRQ/H8GI=;
 b=Cspv4sm2niLKkt0o8j7zNfh29H/1T1FBtbCe2tCEGJR5rOHWnm13Cu4J/5rCoIeFGT+KZtnfozZ4wVeEmEf2haNZUFv00mmMFPUORtImfJjJv9nsYfRhKKZyVdAg7G2Q9PD7QfMzLk/Ueu6x8aLk70FupDbckDu7y9MS06jTcZCIpu1ZB+XXPk6oZYEhWH7fwGvJldUVB2zTD68MAIpbo1BC5juxNrc4uqHd+ZYS3JiCRIZu58K4eBUkiD58eKC8/oou9ntcbcy2kubZ+LyG9UXHnRPvXQITs6UBpu1nKbFMe0ABe7mZV8b4V7S5bzrU8C7hsB/iky1hkPrRCFzfXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 MW6PR12MB8949.namprd12.prod.outlook.com (2603:10b6:303:248::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:09:23 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 14:09:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 23:09:18 +0900
Message-Id: <DMXJNIU3BIOR.3K9YLK44LPFDY@nvidia.com>
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
Subject: Re: [PATCH v12 2/2] gpu: nova-core: add ChannelIdPool
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261112-chid-v12-0-49ad43286dad@nvidia.com>
 <20261112-chid-v12-2-49ad43286dad@nvidia.com>
 <DMXJHYY9ZTRO.3G2LTK1PPDIV7@nvidia.com>
In-Reply-To: <DMXJHYY9ZTRO.3G2LTK1PPDIV7@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0046.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::10) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|MW6PR12MB8949:EE_
X-MS-Office365-Filtering-Correlation-Id: 01168e5e-f7f6-4be5-5432-08df44b4613c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|1800799024|366016|376014|7416014|261026121527099003|261022113327099003|261022075727099003|4143699003|11063799006|56012099006|10067099003|18002099003|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info: XNFVY6rQVhc6B1kulN7vXlZe7JrVb93M3x3p/e4ubwqfBN3quVOzonbiwUhcZDqcgzqJWCW7wzboTBxzV3+nMvz0cFWxSMMeEcNPKhR6cFIqPOS/yOnd4hgNhWfLCBl9z13hH205OYjfTDNqU++rzDY+cmzmMGan+ptmI1/VtEZnL2ikf1MRdIDcPWApfBvZXqhY8XOg8ZY81zJyJHXa9aXerQ65kaFrwYBfM5XJj2q5H7/nsnjnPMe+HRbD8JQo1XN09JWvwwQMJFZkbuviI7S9fGvnIcyzLNDSYf8ZE1SnFeIe81VEExeH4fVvybRrQbctqyOLic8HsoTUEfHG4AH15eLcrZSsay07DRAaQ1jNh3K8EozTXulpow7v335z1zKniYGYTzZHedmFEQEqLsrW8cQ4Hkv3p3DOLoSciAg59mVL5454wVelJSv7DYpGzEMAmf7nFV00HPvxIqzk1Tvm+chMazM0CfQhUfQcnhZIM3+hRHiedz2uXTkvEsLn2hdrx+QiIDM8iRjKUp/daFsa//IDGBjcvpeaAAPEFwqzxY383x0sdPttO4lvQNhcazZ2sPKk4590FYQWM/6Lab7E2Mx72YmX9mSAzumA96q+QJVjNVP7eEy2y32luaKrdadf3RyjLAqb1mi9c9cvcbtd1H8td6soFATE+6bB1BY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(1800799024)(366016)(376014)(7416014)(261026121527099003)(261022113327099003)(261022075727099003)(4143699003)(11063799006)(56012099006)(10067099003)(18002099003)(261009223027099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cC9mMDRUUEFZNmlKMGZPdy9Ndmdwdm03VnNrS2hGRjRvMGhmNTNIUENxa0s5?=
 =?utf-8?B?NjRxUE41WkpyNW9ydXkyQkM0V1hQdnU3Yi9ORkxtVStxZW9lOWlGajM2TitF?=
 =?utf-8?B?eC83cEtXbDh4bFAxZjZOVGc3YzU1Y0tlNlg1eFZjVU9lek5oUEV6anp4Z1Rz?=
 =?utf-8?B?ZzRiejA4RkJKc0duVDlra2txN3RISU9IUUVhRFV1Y3FubENiV3lKZDdOekhr?=
 =?utf-8?B?NHVGMU9EamVHanZtQmowT1lPSCtxNzhZaHdSN0x0TTdmaENnbmVRSXQxUUhp?=
 =?utf-8?B?Z1hsTW5hWUFZT1dRbWtxY3k3am1IVnNsQ0JTNEpuMkpvL3gySFNTV0VvaFJj?=
 =?utf-8?B?YTdmL2tDdXJ0RE5EcjVtTk03WTg4Y0hSMFFxUG43cjhuUkdNMFlYTzZZM3Y2?=
 =?utf-8?B?Sml0MndpNVd6b3lyazBKaWFIM2FaUUJKZ2FwUCtEdW1EUlhCYm44REpuMmlW?=
 =?utf-8?B?ZHZYOU5PaFBwOHVXSVkxM0x2Y2dLQWRLWXgyWHlRWktIZTZMaDFOaDJZVzlE?=
 =?utf-8?B?bW9YZm1JQWxpS0huTmQ2ZGdVTHhFMm9KT0dJNlR5MXp0MDIweVBOOU9jWlNW?=
 =?utf-8?B?cll4RmxxQmhKdGdrSTVuNXp0UXZybjNkaGxxMldGbG1vSkMvMFIzWklVYWVs?=
 =?utf-8?B?cHYvNzlqV1NCTmtaWDY2VWtYTjFZTWVhYS9SdTg5T3p6Ukl6RHNYNENDUjhF?=
 =?utf-8?B?OXZJV1RmeE1TV0l4NWRHNXZNaEh0M2x5Qm1KV291QW93VnJIdEVDQUpSWjRt?=
 =?utf-8?B?UWJnRHdrVDhob1hPdjY0MDVvWHQ4NlZDejd3R3VUaDZXMTdXT3p3OVRnemFi?=
 =?utf-8?B?TEdmbnVTMDlwcnhhM1FNQ1JzYkNrNXhqWWtrYlEvV3gxUUozSDZuWVpzWXRy?=
 =?utf-8?B?Wm9CRi9GamR0NklDUnQ0UDlsOTA3Z3VPbTJ2cEVNaGE5azFya1hzOHRhNW4r?=
 =?utf-8?B?b3R3YTMraERLQnZadFEybllORGRMUGx3NEVXOFJrRk1QR0kwdHFCWWZLU2pL?=
 =?utf-8?B?Vi96MEhYc0Nqa1oySDR4eEw1VTNlNDBYaXhLVlA2RElLR1lXdDF2aVI3OGpM?=
 =?utf-8?B?eXlUQTZWK1F2emsyaWRHTVRuaElqeHN0ZVdZOS9kK1pEVFdQSStDeXJTYmRN?=
 =?utf-8?B?eFJ5MzFJMS8yRFV6aGhBbzB3UmVIUUxJK1BBWHZXaHdXYU5wb05JZWpIRFdM?=
 =?utf-8?B?bTBBN3h1T0VqaHFEcTFWZThXRVFmamhkb0NZME0ySTAvZjZTUkZ2aWljRE15?=
 =?utf-8?B?cEF2SWZVU1podEVYOVg0TGgyaVZlMkNia3J0VnRaUzZvMnJXNThxVGZsMmRF?=
 =?utf-8?B?OHFkNnN0Q2JabDlxMFVGckZkb1FDcFBwanhVRmpmWEFoazZSc0ZCdUlFR2Zq?=
 =?utf-8?B?UXhGcXJObUNnZld0Y0szUVdaSDh4U3ZTZFBHTDJCS0l4dTdrR2sxTEVaTVFT?=
 =?utf-8?B?NDJyWldXZlBOVnFHMTlpWEVsQld5Rjh2SjA0czZsUmFHWFBPaVgvSE0xajEv?=
 =?utf-8?B?bDlEZnpiaW1tcHdyajArKzhvNnBqNkxWTmp4OVB3eTZpSmlyUm5ZRWx3OXIw?=
 =?utf-8?B?TExGS3dXR1BkR0g5TllIUk1MVEF3b1V3K2dOV3IxSVVOeGJ2MExpNzczeW54?=
 =?utf-8?B?QXlSY1U2bnQ1QXcyUWhKTlF4Z2dQVlFJTWpwdENmTWdFcStPT1JmblI1ZjF3?=
 =?utf-8?B?YzF1NVZYbTdBU0JRa3p0SXR6SWNqZjREVEc4d2wyVnpnZmtIZXlUY1lXNFJR?=
 =?utf-8?B?Nk5JQ2llUmk0dkNzWjJUTDBoOUhjMi96YTV6amRWWHF0UGJrY2cwNVNyZTdo?=
 =?utf-8?B?enViNUJCeVRpem10N0l4NVlsUGtQcVo5MExscGhYNWVnQnVRMm83MkxONEhW?=
 =?utf-8?B?ZnJ6QzhtdzZUam1QRDRXNkFOZ1FpR1Y2cHJTK1ZQT2lpRmhweXNWc2lhTysv?=
 =?utf-8?B?bVQwc3o5V21RdGQ1MG83Y3Jtd2dpUGxHaDJVUjREd3BURHphKzhHMzUwdkpw?=
 =?utf-8?B?MVRXZ1hZalNHQTc5RURncklDYnc1SDFER2tkQmJUZDAvR2NLTHV3U2wzdk1C?=
 =?utf-8?B?TDg3TE9xNjcwZzRTSG0rdythYU0vZ01HNHpxV0JYbzRQNU9sb242U2NzZ2RL?=
 =?utf-8?B?bFV6TkZYOVlZeVA5dXl4ZWZac0dicjVKTWorcEdlR2FPNDBPZEh5YWQxdldV?=
 =?utf-8?B?Q1RSTGk5TWhsSmEwc3ZUb0dJR0E5dzBiZXV0TFl6b1pCdFdiTWhJTzlmNFp3?=
 =?utf-8?B?Rm1HM2FzWVJOMXJwYzRJNWlzcU5kY0s2ZVBFRG5xZlJCcFFMT2d6bHpPcWZ0?=
 =?utf-8?B?NkZYZTFacEh3UTF5ajBQcjJsTUVld1JlQTY3Tm14aUR3cmFFMHJ5dmJiZm1N?=
 =?utf-8?Q?A2r/9cBrpYz1cm1qndzPx86Dri31rDaq67TU/eieUhJ5M?=
X-MS-Exchange-AntiSpam-MessageData-1: iUUxO814XlA3Aw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01168e5e-f7f6-4be5-5432-08df44b4613c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:09:23.0482 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6gVLSMAxy+54kiVClbAF+X1UbHx2WxQE2XZPBYQPJE0JCkywP3Y4TEeROSbFYR6Uo/VpU/wGaa9DpvMrXFgIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8949
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

On Tue Nov 17, 2026 at 11:02 PM JST, Alexandre Courbot wrote:
> On Thu Nov 12, 2026 at 9:37 PM JST, Eliot Courtney wrote:
>> Add `ChannelIdPool` which adds automatic tracking and releasing of
>> channel IDs on top of `IdPool`. This is necessary for apportioning
>> ranges of channel IDs to be used in e.g. vGPU.
>>
>> Channel IDs are allocated as a contiguous sequence with a specific
>> length and sometimes a specific alignment [1] for vGPU. The ID space is
>> small (limited to 2048) and allocation is not on a hot path, so a
>> bitmap-backed `IdPool` is a better fit than IDA/xarray (which allocate a
>> single ID within a range, not a contiguous sequence) or a maple tree
>> (where aligned allocation needs an alloc_range()+erase() retry loop that
>> essentially reimplements bitmap_find_next_zero_area()) [2]. It is
>> also faster than maple tree [3].
>>
>> Link: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@n=
vidia.com/ # [1]
>> Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@=
nvidia.com/ # [2]
>> Link: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.=
com/ # [3]
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>
> This series looks ready to apply, but one question below:
>
>> +#[kunit_tests(nova_core_channel)]
>> +mod tests {
>> +    use super::*;
>> +    use kernel::sizes::SizeConstants;
>> +
>> +    #[test]
>> +    fn chid_reservation() -> Result {
>> +        let pool =3D KBox::pin_init(ChannelIdPool::new(cv!(2048)), GFP_=
KERNEL)?;
>> +
>> +        let first =3D pool.reserve_ids(cv!(48), Alignment::SZ_1)?;
>> +        assert_eq!(0, first.start);
>> +        assert_eq!(48, first.len());
>> +        assert_eq!(48, first.end);
>
> I could simplify this into
>
>     assert_eq!(0..48, *first);
>
>> +
>> +        let second =3D pool.reserve_ids(cv!(48), Alignment::SZ_1)?;
>> +        assert!(first.end <=3D second.start || second.end <=3D first.st=
art);
>> +
>> +        let first_start =3D first.start;
>> +        drop(first);
>> +        assert_eq!(
>> +            first_start,
>> +            pool.reserve_ids(cv!(48), Alignment::SZ_1)?.start
>> +        );
>> +        Ok(())
>> +    }
>> +
>> +    #[test]
>> +    fn chid_reservation_drop() -> Result {
>> +        let pool =3D KBox::pin_init(ChannelIdPool::new(cv!(8)), GFP_KER=
NEL)?;
>> +
>> +        let a =3D pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
>> +        let b =3D pool.reserve_ids(cv!(3), Alignment::SZ_1)?;
>> +        let c =3D pool.reserve_ids(cv!(2), Alignment::SZ_1)?;
>> +        assert_eq!(0, a.start);
>> +        assert_eq!(3, b.start);
>> +        assert_eq!(6, c.start);
>
> And these ones into:
>
>     assert_eq!(0..3, *a);
>     assert_eq!(3..6, *b);
>     assert_eq!(6..8, *c);
>
> Most of the tests could be changed to be done on ranges, which have the
> benefit of checking the first and last indices, as well as the length in
> one go and provide better coverage. I have done the change locally and
> checked that it worked. Would you be ok if I converted all the relevant
> `assert_eq!` statements upon applying?

Yes absolutely no worries. Thanks!
