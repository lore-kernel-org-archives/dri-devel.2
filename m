Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCCB606A327
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jCPorHTg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 265BC10E03C;
	Tue, 10 Nov 2026 22:44:39 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB94F10E03C
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 22:44:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAU+eBdkdyVjSM1Xz+d0NcrgdbebZPIK/dz3oB/00a+8Dp9QGDRa3XHHgFLRSUE+0sOfoHVwaE84MMu2FSt/iBbIWxffHwZh++J3oxs+X4dLfm6bECTYnYxadgcxYZlKIO6w7z8bp32VSw8rjtG0sFZzx4Gf1//8bhB85W8RQHS0TG2rHLtUSDARKtrFHz8QiA25Nn32AflyWcMgPQwEQjUXjbU8XTvPYhKr/qcTakEY0V6mqtt0nDkzt0Q2bTU47E7iaPURLHgwjJXcQpwvmMUJD8lOLAy35dQo19HfQyrb6xI3GlONklDnsA5aWo5GwvPE77aE8jWr9wgnOdei0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C9NbM+1wkE92zwEzA1poagYe2zKbZNc/NpPLZr8HZw=;
 b=aYBZIUWIFj4mKWB+Ax0ieNeWlQ3NuJjJoAuUKf+Hb3B/fngv/OrBr5Eepidpn1+009RNZK1S5UPLdKzf+519O8F/ECrDOTZBM6mJwwoAKAAPO2R3fGIE6wrF3c4BcxrnSTRjQpolHogXkDqX3wyt+JwvsiUxs5gaT3XCzEz1vkTYfNYDztyWspzVvFPRXPPUeLc7/VfjV0FunyhbGhSGK9f9Mxz/76120RXKMJ9aiG93Knym9UrFBjoo+oOEu7ICiA7CmSQrhfhX0V/NjQUgOV1C1xw++B1Z0W3nJeUZK3uFCixMSXBXXdD9Ahv5HJT3Vwsle8zBqin4kQ/Z9mg09g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C9NbM+1wkE92zwEzA1poagYe2zKbZNc/NpPLZr8HZw=;
 b=jCPorHTgza87kNBKNGrTUKTfJ9yiD01YmAVbpHSDNET4eXE4icl3TRaHieQYfM9Q7pHcivfCpW9UVvx0OyTpJKEiGcr7DYVHEjtqNGaeCF6p7e/n2rF76FAAebN3TETpFtFvoC6i9zw9yr6eicO+JQJ/yAOLmRR+b67woNDMLvv6Y9z4MJ0SvBzsuZL7iM4RyXibbcHkIsUuTTy4CZxjmfehNQihVtmvcbbzP/tTXT/ui7oY2N7JXNYHWG/s7QXLGqfY02W5uAAFz2eBct5OJI7iJ3Hc0fYvpHFS6wH+0A/DybeIU/NxmLldsOdR6tMt7YV/h1y+vpsxtP+41ml4bA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 22:44:23 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 22:44:22 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 07:44:19 +0900
Message-Id: <DMRW81BTJRI1.6KL933YC1FM8@nvidia.com>
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
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v11 4/5] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Yury Norov" <ynorov@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
 <20261109-chid-v11-4-082aa9bf5a91@nvidia.com> <avNXkJjOoTzUu-1r@yury>
In-Reply-To: <avNXkJjOoTzUu-1r@yury>
X-ClientProxiedBy: TYCP286CA0247.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: d89d5994-c6c8-4191-8651-08df3f7c2a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|10070799003|366016|1800799024|4143699003|56012099006|11063799006|261021121427099003|261022105027099003|10067099003|261026140227099003|261026121527099003|261021123027099003|261028144727099003|261021135927099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EfYbyJ9urD5iYDKTaQi7aqgwfHaUyjtJ1n8AVBJbWsX9X1u5oBqu3H3v4zCrLh52siULAKzBd6BdWhjUNeluPzp5GIqKPbzL8MbhEcTSpMga501wx3Z6Jvp/RDNou5X2OL/wXmFG/lMvR50+LOCuwe9eirSCwLTebhysA7rco88lFxJDLSKzpTvAKBt+8V+eH/3uV00PoIFzkQh5se7psLvqFKeLL/hur6eSkuV1ZC8VbOPwqDR8HEBCWPKOXgZzRPBv2oR3tXqI1Lth+IOnJSX7ciKte+3+4+IIf/71T4kmy7eDu24YyTOqHDnMCa6yUWCSI23kgOVMDRgovm698xfbK3g1GHmmFs+A7rH9gJ1m6WN5OlJcCsaOk2xLy2qOe9yENqI+y5xnBHIpRDbRVYm0tMdykK3hf4B4Yhe/57jMhbRbFY4sI1qcCT6GoXXAFZSwEPc00VNBIdvfS+/qOYGFJoNIn2BYSSA3aobBXjBcMM0lOziSuSSO/UKiDdoRuksZI+BXOSPzJztfLPaLvkd/tQddEYMakK+WJ8rGyjdfypfhfCONyEkQtN3lswjoPN9YmoOIUNFjmTvDxPpZC1AjOaqB2z9HQb19riJm6krIFuCFLKePqaW4w1uucUaiT6MbbpYV3vAn49I4aExnPM0kZ5ah3Knr3hoa1OcP0KM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(10070799003)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(261021121427099003)(261022105027099003)(10067099003)(261026140227099003)(261026121527099003)(261021123027099003)(261028144727099003)(261021135927099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUtqcnAralRkQ01iRXArcXJaRVVhZUoyOE00Q0JFTDRBZDcvWGFvdzJERHR0?=
 =?utf-8?B?MjIzaDkxZkRJM21GaEY0UlAvSnloOFZOaWpIL0tZYXZzd3lHN25NVjR2VE42?=
 =?utf-8?B?UFZPaVZNY2VQQTVzaUN0VDlQVFdVWkNTdXA4NFJCa29ZNy8wK3o1RWJSU3Ru?=
 =?utf-8?B?MEYzcjZ3TGlLenRkZHhSMWdGNUx4cHhwRG5DdUlvS1Q2UFNFS1FMSVN0M1VU?=
 =?utf-8?B?emRnUkxlK250RWpsZTNmNlJUSnQvM1ZteWJIMGQzMU1lVzlqRS9jT283eWJl?=
 =?utf-8?B?YWExWHRrRnB6RGxFVUVkTDIwK2JZTkFTMGhLTlJRZm04bFlNNnA0YjlqTHAv?=
 =?utf-8?B?ZDJSUDdybFBOVlVPTkdIQzMzd3ZSVDFRRERNTHZNSkpwZ0Y1VjVwR0QyTzNG?=
 =?utf-8?B?cjFWR05icndBbXBvaVNHRUhjUW1wNmVKZURwRHYwV1p3MjlxcVNkSkF3SmFF?=
 =?utf-8?B?aUQ2Qko2RnVTcHlTWEpNTjF1cmtWOERKR2hYdEpuK1JlVHFlZFExYlVLUjhj?=
 =?utf-8?B?YWV2aTlKZ09iQmFtQ0t5QlBEUzBQem95aWlFZVFQQ285dTlqTlNtYWNrMTRI?=
 =?utf-8?B?ZUJ2ZERGT1o3SnpOeHdlc044MlRVYWtEcit6MWsyR3JRRnVWYjVXZlQ2T3Y3?=
 =?utf-8?B?cCtOVFZ1NE1GU2ljc3ZlU0VGYkU5MUJCYk9xMFhHMktQb2NhWlQzNmN4TTg5?=
 =?utf-8?B?bnBIL0tXNG54M3RYcnJqRW9FY0F3anlRd2VTOEtFT0NlWXk1cExCSzhMRjVH?=
 =?utf-8?B?dFFYMUdySUwwOHM3YnJSME1PcGM0aFFkNkpUV3RnQTlzNEpjZ3FKSU12SmVM?=
 =?utf-8?B?ejMxUEl0MXAwTEcxc2JPcG53SEpGOFQwNFBLQ3F4NXNKUHhCekhCTlJJVjVT?=
 =?utf-8?B?Vk1TVWJjME9JUVJMREpTVy94ci8xWTdManVJbEJvZjJ0SXJVSmdydDdKR2hm?=
 =?utf-8?B?SEo3b3VURmovVE1HaUgzS0pyemEzME5RWjduU1dOL0h6bEJxYmx0anIrZ043?=
 =?utf-8?B?bUZ5SkQ1MnJsSE4xdFAzbURPVHI0TWxFY2hzLzlDaXl3WmdUd09OaXBzcHJ1?=
 =?utf-8?B?dGFNcWx6enFGeDUxM3hjZWJUQXZVQUt5ZjFWU1hhNXQ3UjZOL1RXdVBwVnFE?=
 =?utf-8?B?M05FV0hhNFRzdXFySnkyVXZZTDVSdGFqZ1FjQTBKVjd0MlE0c3VVcnlrS29V?=
 =?utf-8?B?Mm1tQU96N25KWlRSKzNWRGdBOTdFR1R1QjNwRnlIa0VsZGE1Qmw5amdST01W?=
 =?utf-8?B?SHo0S2NxcUl5Z3ZhSllvRUJRTWVaUCt2UDhKQ2I2eUZrNWNjcWQ4MDhldDcx?=
 =?utf-8?B?QzBFbEdkQzJKRW1TK0lPTVhWNTRqK1Q4Mm1GbDlORmtkSE8wYkYrbk0wa0M2?=
 =?utf-8?B?V0l4MXdZRzFjN1pzYktYZzVKeVZtekZvcWZMQ2pBZDhLVnAvczlFK2lPWStp?=
 =?utf-8?B?YU9GTFN2MHlLaVdQWTM4NmJ4UytIOGJXayswWVlaQmpCckxIdng3MjZkVUpS?=
 =?utf-8?B?NERhZTB6VmUvSVpTb1ZzVDZwYVFxNHM4NEpQOUh1YUVBbEp4QmZ4d3RrNS9q?=
 =?utf-8?B?VndoV0oyeE1JdG5GZi92SXk1VTRxOEgwWFg5dXkveTNDd212Y0s2WHdyUmgy?=
 =?utf-8?B?dll6SzBoYks0ajUrVm5IMGloNXIvZjFCSURBbUJDR0QyYW5BbUk1UmlqNTFD?=
 =?utf-8?B?LzdpTENGRXdlbzdOUVhyZW1qVG9uVEdLZ1A2ZWtpaFUzZDhXZy8wNlR1bS8z?=
 =?utf-8?B?ZUhmNWMyaUpZOElXVXovN0piY0xwVmMwR01YSkNtWk9CQjRrUXZLYzZqZkNU?=
 =?utf-8?B?QU1XZlhZN0R6emd4Nk1OdzgvbTZyb3AwSUo1N0NVWk9KaTFqeFc3VWlQZlVT?=
 =?utf-8?B?N2JsdUlyY0hMQlduVWRPWTRKYTVmd0lzdUZVREthamtGaXArNzl2cVB3VkhV?=
 =?utf-8?B?Mkpkd0RHNHY4UE82WVQ5ZFp1UnJOMzlySU5oMHdyNGhOYUVaNGs1cU9rcEZ6?=
 =?utf-8?B?bnk3aEcrcE5nK0lUbDI2bGVhWHMzZG5xbS8yMWY2N3RrMVZ5d1R6QkkrZFc3?=
 =?utf-8?B?ZDFvZTZnSXUyUlprTUNiQlcvTklXWTFnM2w1RFR4M213SVY0SEk5MFJ5V21B?=
 =?utf-8?B?cm8zWmxwUWtDQ0NIRUpXZVdJbFhNdlJaVTluLzAwVWJTdXZpMk1YeW5Qczhr?=
 =?utf-8?B?a2JoNU0vcDh2SllMRWZkTjZFYmhWVzZyNHh2bDloZEdIN3ZNTnlodjFha0hL?=
 =?utf-8?B?M0pKQWV1QUJLSVJWUi9RR0wrR3Q1RVBzL0lJWUorc2FDSHdmUnNrYk5OK0Fj?=
 =?utf-8?B?cmJ4ZXAyVzdyUVNXRU92QzQ4WDA4eUhudVpDQXJvWkZEQnpjZDAvS212TUs1?=
 =?utf-8?Q?ot6YK7G71pX1fCAdYLxHbcqj0aw0AS8v7egG9M0FuxPZb?=
X-MS-Exchange-AntiSpam-MessageData-1: xuvSApzMOswgMg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89d5994-c6c8-4191-8651-08df3f7c2a29
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 22:44:22.7707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RnRWynyKFQTQzjCR6ZPSQFElrg8YIZJZ1rf2RQ/hPQLooXjJNqXUW3oG6HT9IHJyakzgx/AGSjuvFrfLR7phWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 11, 2026 at 2:42 AM JST, Yury Norov wrote:
> On Mon, Nov 09, 2026 at 05:32:52PM +0900, Eliot Courtney wrote:
>> Current code in IdPool::with_capacity rounds the capacity up to
>> BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
>> smaller than this and still uses an inline representation. Remove this
>> behaviour.
>>=20
>> This allows specifying a real capacity of 0, which was not previously
>> possible.
>
> How real capacity 0 became possible? Did we eventually find a use case
> for it? If not, it should not be possible, and the implementation
> should not explicitly handle that case.
>
>> This breaks `grow_request` in this case, so change it to grow
>> to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
>> `shrink_request`.
>
> Not the grow_request only, I believe. I recall the discussion about
> panic on most operations on a 0-bit pool.

You have panics on most operations of a pool of any size if accessed out
of bounds. Zero size is not special.

> =20
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>> Reviewed-by: Burak Emir <burak.emir@gmail.com>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/id_pool.rs | 38 ++++++++++++++++++++++++++++++++------
>>  1 file changed, 32 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
>> index 92eeb7caa243..f77bd90325ff 100644
>> --- a/rust/kernel/id_pool.rs
>> +++ b/rust/kernel/id_pool.rs
>> @@ -112,13 +112,8 @@ pub fn new() -> Self {
>>      }
>> =20
>>      /// Constructs a new [`IdPool`] with space for a specific number of=
 bits.
>> -    ///
>> -    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE=
_LEN`].
>> -    ///
>> -    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>>      #[inline]
>>      pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, =
AllocError> {
>> -        let num_ids =3D usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
>>          let map =3D BitmapVec::new(num_ids, flags)?;
>>          Ok(Self { map })
>>      }
>> @@ -152,6 +147,13 @@ pub fn capacity(&self) -> usize {
>>      /// let resizer =3D alloc_request.realloc(GFP_KERNEL)?;
>>      /// pool.shrink(resizer);
>>      /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
>> +    ///
>> +    /// // A pool at the `MAX_INLINE_LEN` floor cannot shrink further.
>> +    /// assert!(pool.shrink_request().is_none());
>> +    ///
>> +    /// // Neither can a pool with a capacity below `MAX_INLINE_LEN`.
>> +    /// let small =3D IdPool::with_capacity(8, GFP_KERNEL)?;
>> +    /// assert!(small.shrink_request().is_none());
>>      /// # Ok::<(), AllocError>(())
>>      /// ```
>>      #[inline]
>> @@ -198,12 +200,36 @@ pub fn shrink(&mut self, mut resizer: PoolResizer)=
 {
>> =20
>>      /// Returns a [`ReallocRequest`] for growing this [`IdPool`], if po=
ssible.
>>      ///
>> +    /// Grows to at least [`MAX_INLINE_LEN`].
>>      /// The capacity of an [`IdPool`] cannot be grown above [`MAX_LEN`]=
.
>>      ///
>> +    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>>      /// [`MAX_LEN`]: BitmapVec::MAX_LEN
>> +    ///
>> +    /// # Examples
>> +    ///
>> +    /// ```
>> +    /// use kernel::{
>> +    ///     alloc::AllocError,
>> +    ///     bitmap::BitmapVec,
>> +    ///     id_pool::IdPool, //
>> +    /// };
>> +    ///
>> +    /// // Grow goes to at least BitmapVec::MAX_INLINE_LEN.
>> +    /// let mut pool =3D IdPool::with_capacity(1, GFP_KERNEL)?;
>> +    /// let resizer =3D pool.grow_request().ok_or(AllocError)?.realloc(=
GFP_KERNEL)?;
>> +    /// pool.grow(resizer);
>> +    /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
>> +    ///
>> +    /// // Grow doubles if at least BitmapVec::MAX_INLINE_LEN.
>> +    /// let resizer =3D pool.grow_request().ok_or(AllocError)?.realloc(=
GFP_KERNEL)?;
>> +    /// pool.grow(resizer);
>> +    /// assert_eq!(pool.capacity(), 2 * BitmapVec::MAX_INLINE_LEN);
>> +    /// # Ok::<(), AllocError>(())
>> +    /// ```
>>      #[inline]
>>      pub fn grow_request(&self) -> Option<ReallocRequest> {
>> -        let num_ids =3D self.capacity() * 2;
>> +        let num_ids =3D usize::max(BitmapVec::MAX_INLINE_LEN, self.capa=
city() * 2);
>
> You only need this max(...) thing to fix the behavior of 0-len bitmap.
> We don't have any users with the request to support them. Please don't
> add any extra code to handle unwanted and unsupported cases.

No, this code is a side-effect of the pool not being rounded up to
`MAX_INLINE_LEN` (note how the `max` moved from `with_capacity). It
would still be there even if we did not support zero-size.

Forbidding zero-sized pools would actually require *more* code in this
patch to enforce that rule, and would not allow us to remove any in
exchange afaict.
