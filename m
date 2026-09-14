Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1D3C88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 04:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0109410E0B1;
	Mon, 14 Sep 2026 04:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z3IY5xNW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 136B010E0B1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 04:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/rn4HmqV2gz0T/N3cwSKlkWVI1IpCv/jNGZt25qUeU5Vc76un0BsLKWXA3Zr312k1nYz/e93c96Xa7jOrjgeIznMP9axJk7U/LjM4Xo/GLse/gs4kZ9oC9ztNM2mW0Rg1yWZco2TrSonbq5Ga7fA2RBTn7wzaCatS78XD8yQBtKe4Z0BGEYCna8LImFq7dy+8zEiIWrDrS8sIq+JiiMbpu8KfsyKL73JEBii63ktDMtttRlW7eigaL38vJTfN68QfeAnWVDSvzbginqpA2a2cy7YjxQRL3Scem2DAL3jS/YCBgqxkjB7H9j+UGmLFSfmPctO/ssel/vlD3jwU1uNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5f//rYsWGIptdSc4f7amIPRCAbbqnW3lN7Y2x4tu7o=;
 b=vP8dOnc6ZQfTfz3aPrq/dVweaZw4bHbhqmlu8PN4TRFXLLZrHVCd/5XcGaH5uS83uFkrERuBrraveUNt9Y3Cct7XzRnKSPj+c//fU3sEVIKfL2/jK2LSoI1wP2tH6Z2X613AlTJ0o/CIUpKyrHq2E3/Lc1eR2SzGV64GvMmBcfuw5sMEYN8dhe5+s3xPycHUe0A67wNbkW+h9AINgJXthlBqmpv0JY9ZkFNa1qhTxZbBFzQZ96gsrBZCGTmhJW34SHVemHpLJg4GkU1rFWrE/h3J4hTNPwJ5DvOlDNmg1ej3RZlHdfRHqnzg/B7KfVBIZGvWM0UDsFoNXKlW/+NH3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5f//rYsWGIptdSc4f7amIPRCAbbqnW3lN7Y2x4tu7o=;
 b=Z3IY5xNWRWuaqViLKdW7zKUvL6PhByYaLdizv8mN5orTgIE9rXcuLW1oVY9SRpFOSVM31IY44vQDA3EQ3fcovpTJds0W8Sd+vQwdKiOytTXySnXoScu/i/DTouYTy2HX0I/zhXo6XJ64Xg0HroZ8S7jxKgbAkhI/gMD8kvkYEL0iVhnPJm98MEtdJDJsxMm4oBEjvCm8HRR8yCEjcJa7C74CajxWirDyB0U09Sq7PLSKeH5qau3YwCx7jVzxGMaaYQl5m780HpRQ6xvYp9mQSk0mh48IUVLI7Jqbeg9LZbDMGgEe3/rmW4lB62nbP3SdE2B33Prh+xPQSwQmTxO9JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by IA0PPF52B16157D.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 04:11:42 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 04:11:42 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 13:11:39 +0900
Message-Id: <DLEQV27IDBCH.16D7K7DXI5ZK8@nvidia.com>
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
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 8/8] gpu: nova-core: add NVKV GSP_INIT schemas
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-8-0de9d5c8658c@nvidia.com>
In-Reply-To: <20260827-b4-nvkv-v2-8-0de9d5c8658c@nvidia.com>
X-ClientProxiedBy: TYCP286CA0179.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|IA0PPF52B16157D:EE_
X-MS-Office365-Filtering-Correlation-Id: f68d00d9-a11a-41de-2e98-08df1216485d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|366016|376014|1800799024|10070799003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 58/bDem+xDGsPaFv5aWQYXzwstvwKjQVon5JHQVmKo+nJxxkIZc46+Vj0iEOr8C/Ly9reuZGw/bU0eF4wgIML2bodiLA3wL9/+vMUC8zg5Cd6Jl0bVfMrCSyFWxyQrPcyqF6Qh5HTE86nhmKNlM2zsqj/KjUGZcOmVGubN+23Zi31Vq11DKEW40G7KV0VhLsxub8/zV41iSw2o/A8T0tGJqW26Mh7gx6m2dBKf2JVU3Fzhqdi+YKWgGEtaOFrA4owbhK6t106YsodEKOhszXrXZrUO4qhR2o5ts4LpkKHsTJ3DY9LzpICJhi/1e+nBL5rr8aohh+3DDaKXyDMILlgrd0PBb8Vfn2Wtpon2O8GFPfaalAz6p0CrFr2LBLGKJaqiKpaoSRh2czsv5G2uy91wtNeZi3EzaUY/BB4UrdJ/ifiNM5I/OYwDsZgKG1e3YCr7c9eXMqEnvtOwp1QlnIjY91Azi01zJmxz8OGnEucIyhi7je23Z1HLVax1YAnyCkjDg0LBDVWWE4NhZB/e5A3hsc9i0l0oGfFWqpwMfFSYSZJF6MWErq8j3jxsm14Uhu0ZSErVlhIU3YoB0CwjISj2Q8Azdvnsv3+dtMEr4Pe86EYOg0Q5d1kMUnigLDfUwOztI1upx+zFuVLf2MnKVej/GX4gXUZcYoO9g/OesNi98=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(10070799003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0lUem9NWFEyb0s5MHRXZXluQ1RCdTg0VElEQkY2UFpzL0dFTXpXODNTeHpn?=
 =?utf-8?B?cHkrMXNLSzVuNyt3WVFPNllOVGRQQjhIMnNOZis1MHFSZDFkNkhoaEpHQUFj?=
 =?utf-8?B?ZEExL1hFZm1uaXJxdXVubnRWYUozQXJPbmxJNUc1RThGZzBPQStpQTh3T0s4?=
 =?utf-8?B?eTBLVkVZanJDRHdZT2JLcWsvaGdrZGJWMjVJK09WNkZ1VmxUWmhDNVgvZm9X?=
 =?utf-8?B?MGRpbzZxLzY1UWtWN1BKd05qMUdiWUFsZndtN055VFZGTUw3OW44TzBPNlQ2?=
 =?utf-8?B?M2lJR2ZNRTBFd3V2L0UxdWp6SGluTzhaY2VJT3cvdU9ZeS9RRHFQRC9CZzJr?=
 =?utf-8?B?dGdEdElEeGdOT3Rjc3NLV2VTZlEwZmZsZm5DY3dCd09Vb3pMTVp2WW1HMzJO?=
 =?utf-8?B?NWhBMElVem4razBack9BcDREVUNudVBqdG82QlEreGRMWllReDVFdzJOTDFZ?=
 =?utf-8?B?OS8zVHRvUEVhbVlpYU1wTldEZHZNUy90aCtTM3plQzRMVkxFSjYrVWlnd3FK?=
 =?utf-8?B?Zi8rbVV4aHJiYTduVEh6QWx5L096b2QwMkNpU2JhYTJOVWlUdFMzbXB1bURs?=
 =?utf-8?B?MjJkNHhNcnR6RUxqempXY25LWUMwZTdZY2M2VCt0a3BWcXN4MXFNbmRGOThC?=
 =?utf-8?B?OVhOdEVRcFpTeDZINUxCaEhrSVcyNFNoTzRDRVM4RXN1SDJWaHdFblFlTnoy?=
 =?utf-8?B?dGpxQjh3bUJPVC9EczFrRGpCVmFhZTdPLzhDQ2FJSkJSS0t5dlBZT21xSEV3?=
 =?utf-8?B?aW96Q0V0aVdPR2l1T2swZVVQeUhnWlRzYS9yQ05MK3VLV3RUMHNwWEo3R1I2?=
 =?utf-8?B?NjdGNXhCUVd3RDA4a3JBTldPb3U0UG9rU0dPczcwUjBBclJVOEFZWTd3SVdM?=
 =?utf-8?B?NXVUTG1BYUpvUGdxdTNVclh4VzhIWjNiQjBWcWMydlplS0gxdVhIZzVUbTRJ?=
 =?utf-8?B?VEJSV0NCczViWVR2UVV2N2lTNlVzeXFtMVZlWEFLb0k4R1l2Tzh6clRtU3RC?=
 =?utf-8?B?Tk1ueWE0Nk1OZkdDQk9GNnhtWERqb01zaG43TmVoTUdhTXphVlpLdTErSGcz?=
 =?utf-8?B?aE5YNzFGMzd0Y0FIM0xhaThNTzRISEFETHlGUi9vWVpxTklkMkJnbXpMNTB0?=
 =?utf-8?B?UWw5T3p6TG5HNVJPcFNKWU5NbllnbktYWHhwUkY4dDlTMEptbFc3UnNlc1M4?=
 =?utf-8?B?QmliU3AzYi8rU1AwNE83aUpmWCtwSWc1Y0hySDVWd2lmMUVkVTUrdHNLRDlu?=
 =?utf-8?B?b3dWVGw2c1YwWWlrV2lCdW4vUkxBbEpSMmxVdzJ4K0N3SW9xbUQ3d0xxTnFC?=
 =?utf-8?B?b0ZWK2N2UU03Qk5yaDFSUHVMOWY4REs3eHU5M1MvSVNlTmw2UElnVU42RWtS?=
 =?utf-8?B?NWtham85OEFXakh1NnQ5elprRHYxVVhoVC9Vd09KYjJubmJ1RWd5N2pRVU5G?=
 =?utf-8?B?UTZ6QTN0YVdwcHVveituY25kTTZVblBUajhHWm9haGJOSmFURUtTbDI3aWM3?=
 =?utf-8?B?b0ZKN3MrWlQ0SlkxVjdyYWdrbGZCTElZOFh3b3c2RmxhcXE3cU83YjJwZlAw?=
 =?utf-8?B?dEJId1NFVnVRZENCeGJRWjJBblhKcjZLbzNadDJzWVZYRkgvaWEyUVdUQ2JR?=
 =?utf-8?B?Zzl6QXJZNXhzVzZwZUdxQ2tZYm1IZHFEN2NHdVBRT1ZBWVN0WVpySkt4OEJV?=
 =?utf-8?B?UlFYajlONkdOTTFYRVBSSVVyUzcxZHB5dldva2pNWFhiUTlZU0xqOEhBU25z?=
 =?utf-8?B?TU1XNGtyT2lxNkY4aHlWNWltUytNMklScnNpNlpPZkExdE51TGJ1Q3g5cDBS?=
 =?utf-8?B?VER1UW9iVWtxc1BYdWJVR2JITHNDZ2dlTjNKcm5ZeGNmbDZsbHovUlRXSkdW?=
 =?utf-8?B?QjUrRVJrZ3FJRCtXZDVLVlVObllycThtVUdUSGpmZW9Ed1YyaFl5czJkdXFj?=
 =?utf-8?B?cnZPOC9iYlRENHovdElYbUo3a2N5ODRRYWh5QzA2TGxWc04yT2FtTk1VaVFm?=
 =?utf-8?B?cmo3NTlOcEJ1UWs2VHZ6TnJtbFNBMGhCNklwR085NjJROVJaSzh3eTAxNzcz?=
 =?utf-8?B?QlZVOFRQMFhkam1lMDBxZEVRMUUxVGtBYndwVTBEQXFxUzhCK1B4Yk9pZnVy?=
 =?utf-8?B?WC9xYnpJc3U3MGptejJOOWNYUmhidDBGZ3p3VkE5enAvYzdmRk9iRmJSMDZL?=
 =?utf-8?B?SkN0NWVmSUJDT2ZCUmJ3dG44YWcvRit6VVFKSjlHWnh1OWJSME1ydzd2dEc2?=
 =?utf-8?B?OVZKL3BOUFVaQTFEWkhuT3ZNTm1odDNtT1FocHlTUU9xek5oTUluOWZaUE5h?=
 =?utf-8?B?eHVSL005WWhpN0RzaUZrbDN0Wm5WYVQwajRWcjV0Z0NXVjR4RHhad0VSSGhV?=
 =?utf-8?Q?q8Og8oboT2+GSuWA8wx145BEiAVhIE9bGPueAAbhFwJqU?=
X-MS-Exchange-AntiSpam-MessageData-1: zxkBOF2aoWWwVQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f68d00d9-a11a-41de-2e98-08df1216485d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 04:11:42.4112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04SHBkLQJVvTzEEdySmzYi08D4sFI5JgCJAVgchtEjGmAyx0uUQio3CZ7m0mHkryxZRrHQ1omT1X5P2tuPY3Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF52B16157D
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

On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
<...>
> +impl RegKey {
> +    // Define the Key IDs read/written by GSP.
> +    const REGKEY_NAME_KEY: KeyId =3D 0x3070;
> +    const REGKEY_VALUE_U32_KEY: KeyId =3D 0x3071;
> +}
> +
> +impl Encodable for KVVec<RegKey> {
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        for regkey in self {
> +            regkey.encode(encoder)?;
> +        }
> +        Ok(())

Maybe this is just me misunderstanding, but how are the keys
sequentially sent here? Because I don't see any mention of an index, and
`Key::encode` hardcodes `Index::new::<0>()`, so how are these supposed
to be decoded into an array? The `gsp_init_request` test below only adds
one key to its `regkeys`, can we add at least another one to see what
happens and verify that the received content decodes as expected on top
of checking its length?

Also drive-by design question: do we expect to have bidirectional types,
i.e. types that need to go through `nvkv_encode` and `nvkv_decode`?
Because I guess there would be some mechanical overlap in the
definitions for that case. Although maybe we can mitigate that with
another macro. :)
