Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A52CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FC211235A;
	Thu, 15 Oct 2026 14:31:29 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012038.outbound.protection.outlook.com [52.101.43.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80E66112373;
 Thu, 15 Oct 2026 14:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBYu+mPooJtGcJ9NP7V3g1sigEzrTfLP+jnzMNnRwWQvkaTM41kNO3UggWQnRYU+7fByJbzJPkFXrxf95wXsAvNv/ifVIZA2y6HjZvuU+SsLEI56mBo1xdmeTW4+tSSknqaNrl7v72116+WUF6b57gHuU8lisa/WTE/JA3JoTNLv7Dj2Bme2cHYCXrwexb8KXtKKiRuW7kbFMWdVGaBjHgC+SJ8MAAxLLPL/v1h8OqVLw0UI05RwGdSvjAyZcczh+PfkPcdBnKVdrx/dcl8yN3F0J+cIrMUsEYH5e/y9aQ5zuK94fzYLi8+7bSua+A+tXpmj3FFwwoL5OapZIiJq6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8jy7zEfkhoZ1jZI0v8eHHWGAO6jsjQFjNvVImES27o=;
 b=H6IdJyGwMs9v9JuL0oi1L3ipsC7fpN40tSMEgPDmVCw/8zxSTjBeOkTBwpRhSdFp4Ba9GLdBnRDpV1C989qwVT5F/TjWRb2YKWM0Z0sr9DBpvNK/XBnvSeouzxVVIoZhMckZWIzoymB497OtjuZQuNoqMhleeV1ZNFtSt32bRhndJRbO+8kh15fEtYLuZmS4Ap0Nh83XntHgjtirfo0viTOFxLfM5BbyVSsQjBae4dSMEneso8629z83O8oJiUNj5r4JWfytEQ4GLaWPbgLdq347t+ktmGebklYNCCHr3hJMpSKflhQyzkKBnAHzsq71TnHDcYkyHlJDhO/GELlxeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8jy7zEfkhoZ1jZI0v8eHHWGAO6jsjQFjNvVImES27o=;
 b=FamcP30L4PtirD4imBOpx99n+rF+pgKAGYSqGA+ydWpZY6DXeYekyTZdwfKANPB1NHkwDVTgPudl3YD5tazHyrYXLTTR+GW9PrmTCtSFnKdafIEujtcRgdxTML2ZPIMd+pkuVkoud13ezyhTDNXV0u4ZhvvFpP+8Fre0PHX7uioioHG8EYCdGyA3Jui1pjQfVeNF50qjDaSornLUWxkGQpAJ3Uo5ilPGZGho0Yq2s0MMJ8de6I1B00cAsCvub3RDmj7i+u9oRjvPexHsj7Zwha6IQIKvYjnS6Pl8gKskyFbXWWp1AUQ7Ivn/hF0D4BUlp2jNUL4TykeCalxuLfLDsg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 14:31:18 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 14:31:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 23:31:14 +0900
Message-Id: <DM5HGCAYF808.3RMKJPV9C0XYS@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 8/8] gpu: nova-core: add NVKV GSP_INIT schemas
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-8-f04504c262c2@nvidia.com>
 <DLYJTG5QTTLF.1LPXNI4K9UU87@nvidia.com>
In-Reply-To: <DLYJTG5QTTLF.1LPXNI4K9UU87@nvidia.com>
X-ClientProxiedBy: TYCP286CA0158.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::9) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1b019d-3b53-4aad-4b60-08df2ac8f96d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|376014|1800799024|7416014|10067099003|22082099003|18002099003|13003099007|3023799007|11063799006|261009223027099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: S8pgEZojC3Mgcd8nnLg9W59fIJzT+VbnaxiLkEn2zl4dMTiMOuW5oNDFJBNcenGOdpqjVuEZfIsBJMyaLF/cv6aoYivq1CYuf+qamNwIq09p6Nyao8iz8dTDwF4mJCkVPm7/NTxfF2PZP0wRnRUESKRw0it7j5LdezUgV20KLZGCujXeDEe7YnZ9Vz2tIUHoaxTOYFypdfYfZGUGoRaph0o5ph0noSaxR2z62CEsGYScD3rd0LCy79+In1R9PIlctOnOkmzlEv88D3LsgfOeOJU98SGrXqYHYTnqFw1bdtDvTqPzWiNE0OYf87EC7GmsD1o3knC7CBAnrwmcXzVbd1d3x/s3s6DFRClUpCRBcWbh4JwYVfcm+N2VY5DguG6kF+uzgykKMzmajWlDmCyr9A3eU3+VbekEOrHd89qDgbJIDoqVfOw7HBNHlWjzupbJmSJWOswpIrOY5Bjz5vSHakfuKC42QwYFyQGQpYH/fvhebUsVhXxjBXj9Z4mQAcYZULg4FZsVInUfX2oxOAHwld8TNZC7JlsYtThmOrD1nfTZ/aFRX/dJqQqp+Eda+YcEYyuP5Mz1Obx9XiYEAdfDgKIqIyT4ACHwYgNG5/xG1MVeMtZVa+iKCNmeC0g5llrqgeiBu59qgUPxjnJntAf/J0FJJkxyxi0fJ3TsF/Zv/dA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(376014)(1800799024)(7416014)(10067099003)(22082099003)(18002099003)(13003099007)(3023799007)(11063799006)(261009223027099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm1UZW5HcFYwdU9sSHFkZXdDNms5bFVmNDN4dHNMcHRFUHVpUExJU0FhT0gw?=
 =?utf-8?B?eEZBVFI1WFJGOXZwMm9zTWFYL1djUXdFaUhnSTZKTDhCanFkc2craS9qNlZm?=
 =?utf-8?B?c2x0QkgvbmtabE9id1M0S2hKQy9ETERIU3ZxTzZ3RzRKZzZoSUNQTENOUTNj?=
 =?utf-8?B?S3dua2VFVmgrS3pESFJwY2JjSE1LaGROUS9yQXFhbVF0TEhaY1lEZ0FXK2NR?=
 =?utf-8?B?QTE5b1JTWTVPdGcyQitDRlZVWVUxUlFKR0pXZjVYSlFGM1ZjY3dYNmp3Wlhx?=
 =?utf-8?B?Q3lOVm9wb0gxdkh5bW1NMTE1LzZBU0c1bjFwT0p6MEFmOUx4NFBaYVBrN3Rl?=
 =?utf-8?B?eEFqbmpWeW1hVDZDRGVvYThRUmRDVTZZQW5FNzYycy9aSlpaSm5RRjZlOVFE?=
 =?utf-8?B?U1RKdStwVWNDRDRydThCTnhlSXMwMm9BYzB2NnBLRWM1SVI0OEFRRmowbVRB?=
 =?utf-8?B?NTJNYUdIR1VqQzRzUzR5UldMelJ5Mld0MVhTR0xwamlnaGJEMzVtcDJEUDJG?=
 =?utf-8?B?UnVMODIvcjlIdm16VVZZT0tXeFVDajM1UlFtV1RNVjdrdXRURkxYbmMrUlkv?=
 =?utf-8?B?RFNHNWVrSXVCZU1wRVhUS28yYkxJUHdRdXVwdk9ra1NXWVRRbVZJR2Z5QUtw?=
 =?utf-8?B?M3hqVTh0K2k4ZUk2ZFA3N2FITlFUeHhEMWwvblhyUWhvYStCbFJsdm1VL1J1?=
 =?utf-8?B?bXh4c0FvUG5paEc2Y0Rnak1BMElaOFJSMDloUDZmOUVJa0Y3bXJBcnRyeXdm?=
 =?utf-8?B?UWpyem5HVG5PMlVEaDFSMUR2R2pqOU8rSzk4NFlnWWVlL3NoVmhFUnNoOU00?=
 =?utf-8?B?Sm9nMlVnZEVIbmhiQW9jSFhiQmx1d0xINE9CamorQjBWUXBraGRlUWVMTHJu?=
 =?utf-8?B?NjBsSDZTSlJZVCs4bmtTS055T2ZqS0tQaXhhY3lLanFnbWlHTU1yeStsVER3?=
 =?utf-8?B?dSt2akZ6STBSUDJXYUZGTEh6SEdGaUZ3OCsyelZQWWJ2blFaTDRWTXFzbmxj?=
 =?utf-8?B?aDBlbnIwZXJWVStGNlN2VW5RbkYvRm01YnZjQmJYa0JUYWxEZGJBNXRsRUZi?=
 =?utf-8?B?V3dZcFcwN24yeXk2dXoraXpNQm9pcTZpajJETnY2alN3WU9ONnBpRXd1OFJ6?=
 =?utf-8?B?MW53M2tlZ0RYUzR5Z3U1NTRxRUQxZlZ5cDIzOU5NVkFrMGZLbVJnUzlvTkhP?=
 =?utf-8?B?TjJmdGtzeDZVR0tRQXZScllOaFRhbEVvTE9jc2tYdlFkek9FVGY0ZHRUQURa?=
 =?utf-8?B?cTEvY0NUU01ibWx6cTRIN3NlSWR0S1lMY0lrWGFnN3U5b1FuR3dxVUtDcXZR?=
 =?utf-8?B?UmZZSlFsN21PcktZTUZCZmh6VzhseEMzdENYNnc1RU00ekNzUi9kRGhTa1lI?=
 =?utf-8?B?bmdzc2pUMnJTc3FacDE2S0s3a3ZMRzVraWRmRlpPWHR4Y2JrbEtJdDZwd2JG?=
 =?utf-8?B?MHFQZW9CdXNmNWNraHZsYjRzQXRDcUFsZzRvS01UblAvVVZpOFlXV0RWc08v?=
 =?utf-8?B?M0Vjc1lrU1RnU2dTc0ptZVhlYmVLNURlWEQ5LzcxOUZZUXVod01maTVncnVn?=
 =?utf-8?B?elZZelFqUHJZSlhpYzNUUXpPZW1uQUNTL012Y0s4ZE1nUzZaZVFIS24zaXNF?=
 =?utf-8?B?MDFva3dKblhMMTk0aHluY2ljTGNYTENyTTQrTWVpVCs4QzEwVjNGOXN0Rit4?=
 =?utf-8?B?RkFJRnpRSFN6T3k0M1dTcGFaaWFua3NNdHEyK2loUWVkNENKWndqMWJJaTlS?=
 =?utf-8?B?Q1U1dElVMlZ1dnZuam1CRS84MXU3RlpBMWlFQXhDQWRzc0VQWURmSk1yZ0hi?=
 =?utf-8?B?dTBDWVFRRTQ5V2h2RW1IdWdTZExaejFDc2krcW91SkVxY3VkbFZlTkt3Q1dp?=
 =?utf-8?B?dTNmZm4zbjNkMGNSSzlrZUQzTFQzanNEeHZPU1ZLeDdzMGpkcGNueEpHYkFi?=
 =?utf-8?B?dUV2SG1QdzNZTnNjMWFYR3J1dnFYNzBTNU9oNXkxcS9ZQWVZSUVMMzhnN3JL?=
 =?utf-8?B?VnRkYzdmVGxITDhkVVpISDRjTUl3QURnbVlxOHo5N1RnRGQ5MXNqWXRpbXB0?=
 =?utf-8?B?U3VzZVFHR3Z1dWMvdGxMeVg3TTA2dnNZVjI5c0RkVkRMTngyeUVlVGQwUHdL?=
 =?utf-8?B?YjdyWk5LdjNjK05sNFBaVXZ2NWZBd1dmTEY4MDFaTTc1UzlKYkpGTTczVlhW?=
 =?utf-8?B?cEx2M3RIdGdNRjYwSzlYMUgyUHRUTU5ucDgyTGVVOXV0MmxTYWZwejJjQnE3?=
 =?utf-8?B?YkpyVFFaaTBoekxoZFBGS2lzdlN2bHFMWmJURURDRjJFUDVoVnZyVDczWERZ?=
 =?utf-8?B?OUZHSlN3aXFyRUk5NjJTL0xncmV5bHA5bkhOdEYyUEVWOWhKc1BCQjV5YVUx?=
 =?utf-8?Q?+YwZGIi3Houiika2QtzBorp0qUX7SS4+4yk8FNxZ+sOcP?=
X-MS-Exchange-AntiSpam-MessageData-1: ok9W8/U/LDiwcA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1b019d-3b53-4aad-4b60-08df2ac8f96d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 14:31:17.8567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OlMZoeqQkRrNwPzb8choVH2mo0ix6SpEW7MYssgaOZvGRSQIZwVklYmUBnFtu41AfrN12mYTl+3/cqb8bBmyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
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

On Wed Oct 7, 2026 at 7:53 PM JST, Alexandre Courbot wrote:
[...]
>> +impl RegKey {
>> +    // Define the Key IDs read/written by GSP.
>> +    const REGKEY_NAME_KEY: KeyId =3D 0x3070;
>> +    const REGKEY_VALUE_U32_KEY: KeyId =3D 0x3071;
>
> I guess the `REGKEY` prefix is unneeded here since it's the name of the
> wrapping type. If we want a common prefix, let's use `KEY`, e.g.
> `KEY_NAME`? Although we might not even need these at all - please see my
> last comment on this patch.

Removed the constants here as you suggested.

>
>> +}
>> +
>> +impl Encodable for KVVec<RegKey> {
>> +    fn encode(&self, encoder: &mut Encoder) -> Result {
>> +        for regkey in self {
>> +            regkey.encode(encoder)?;
>> +        }
>> +        Ok(())
>> +    }
>> +}
>> +
>> +nvkv_encode! {
>> +    /// SR-IOV virtual function information.
>> +    struct VfInfo {
>> +        total_vfs: Key<u32, { Self::VF_TOTAL_VFS_KEY }>,
>> +        first_vf_offset: Key<u32, { Self::VF_FIRST_VF_OFFSET_KEY }>,
>> +        flags: Key<u64, { Self::VF_FLAGS_KEY }>,
>> +        first_bar0_address: Key<u64, { Self::VF_FIRST_BAR0_ADDRESS_KEY =
}>,
>> +        first_bar1_address: Key<u64, { Self::VF_FIRST_BAR1_ADDRESS_KEY =
}>,
>> +        first_bar2_address: Key<u64, { Self::VF_FIRST_BAR2_ADDRESS_KEY =
}>,
>> +    }
>> +}
>> +
>> +impl VfInfo {
>> +    // Define the Key IDs read/written by GSP.
>> +    const VF_TOTAL_VFS_KEY: KeyId =3D 0x0080;
>> +    const VF_FIRST_VF_OFFSET_KEY: KeyId =3D 0x0081;
>> +    const VF_FLAGS_KEY: KeyId =3D 0x1003;
>> +    const VF_FIRST_BAR0_ADDRESS_KEY: KeyId =3D 0x1050;
>> +    const VF_FIRST_BAR1_ADDRESS_KEY: KeyId =3D 0x1051;
>> +    const VF_FIRST_BAR2_ADDRESS_KEY: KeyId =3D 0x1052;
>> +}
>
> That's a bit of boilerplate. Ideally we would have this `#[nvkv(key =3D
> value)]` notation (without the bidirectional feature) you mentioned in
> [1] that takes the literal value and defines a constant to access it,
> but I guess that's more rework than we want for now.
>
> [1] https://lore.kernel.org/DLIHSKKUVP7V.153Z4TTEYFL3Y@nvidia.com

Yes, I think that's a bigger rework where we have the macro generate the
schema types. We could consider that later IMO.

>
>> +
>> +nvkv_encode! {
>> +    /// Payload of the `GSP_INIT` command.
>> +    // TODO: expect() doesn't work here due to Self:: reference, fixed =
in 1.97.0
>> +    // https://github.com/rust-lang/rust/pull/154377
>> +    #[cfg_attr(not(CONFIG_KUNIT), allow(dead_code))]
>> +    struct GspInitRequest {
>> +        pci_device_id: Key<u32, { Self::PCI_DEVICE_ID_KEY }>,
>> +        pci_sub_device_id: Key<u32, { Self::PCI_SUBDEVICE_ID_KEY }>,
>> +        pci_revision_id: Key<u32, { Self::PCI_REVISION_ID_KEY }>,
>> +        pci_config_mirror_base: Key<u32, { Self::PCI_CONFIG_MIRROR_BASE=
_KEY }>,
>> +        pci_config_mirror_size: Key<u32, { Self::PCI_CONFIG_MIRROR_SIZE=
_KEY }>,
>> +        host_arch: Key<HostArch, { Self::HOST_ARCH_KEY }, u32>,
>> +        bus_device_func: Key<u64, { Self::NV_DOMAIN_BUS_DEVICE_FUNC_KEY=
 }>,
>> +        regkeys: KVVec<RegKey>,
>> +        vf_info: Option<VfInfo>,
>> +    }
>> +}
>> +
>> +impl GspInitRequest {
>> +    // Define the Key IDs read/written by GSP.
>> +    const PCI_DEVICE_ID_KEY: KeyId =3D 0x0001;
>> +    const PCI_SUBDEVICE_ID_KEY: KeyId =3D 0x0002;
>> +    const PCI_REVISION_ID_KEY: KeyId =3D 0x0003;
>> +    const PCI_CONFIG_MIRROR_BASE_KEY: KeyId =3D 0x0010;
>> +    const PCI_CONFIG_MIRROR_SIZE_KEY: KeyId =3D 0x0011;
>> +    const HOST_ARCH_KEY: KeyId =3D 0x0070;
>> +    const NV_DOMAIN_BUS_DEVICE_FUNC_KEY: KeyId =3D 0x1020;
>> +}
>> +
>> +// Decode:
>> +
>> +// Should decode with UnknownKeyPolicy::Ignore.
>> +nvkv_decode! {
>> +    /// Schema for the `GSP_INIT` response.
>> +    // TODO: expect() doesn't work here due to Self:: reference, fixed =
in 1.97.0
>> +    // https://github.com/rust-lang/rust/pull/154377
>> +    #[cfg_attr(not(CONFIG_KUNIT), allow(dead_code))]
>> +    struct GspInitResponseSchema =3D> GspInitResponse {
>> +        gpu_name:
>> +            Array<u8, { GspInitResponse::MAX_GPU_NAME_LEN }, { Self::GP=
U_NAME_STRING_KEY }>,
>> +        fb_regions: Accumulated<FbRegionSchema>,
>> +        bar1_pde_base: Required<u64, { Self::BAR1_PDE_BASE_KEY }>,
>> +        vmmu_segment_size: Key<u64, { Self::VMMU_SEGMENT_SIZE_KEY }>,
>
> Is this ok to have `vmmu_segment_size` not `Required`?

Let me check. OpenRM's behaviour here is to check against 0, however.

[...]
>> +
>> +#[kunit_tests(nova_core_fw_commands)]
>> +mod tests {
>
> These tests below mostly re-check the same things as the previous
> patches, only with different data. I am not sure they bring much new
> coverage, except maybe nested structs (which we could/should also cover
> in the previous patches anyway). I think we would have more value (and
> less code) if we covered the things newly tested to the tests of patches
> 4-7, and dropped the test module here altogether. Because if we follow
> the pattern, then we will repeat these tests again and again for every
> command we support, which is going to result in tons of redundant tests
> at the end of the day.
>
> Another incentive for not having more tests here: they are the only
> other user of the key constants, outside of the `nvkv_decode` and
> `nvkv_encode` macros themselves. If we can get rid of them then the
> macros become the only users of these consts, and in that case why not
> replace
>
>     pci_device_id: Key<u32, { Self::PCI_DEVICE_ID_KEY }>,
>     ...
>     const PCI_DEVICE_ID_KEY: KeyId =3D 0x0001;
>
> with just
>
>     pci_device_id: Key<u32, 0x0001>,
>
> as it is clear from that line alone that `0x0001` is the key for
> `pci_device_id`. Bonus, the unsightly brackets required because we
> reference `Self` can also go away.

Will drop these, I agree with your point that it's noisy to add these
everywhere we have commands. I also folded in the constants like you
suggest.

Thank you for your reviews~
