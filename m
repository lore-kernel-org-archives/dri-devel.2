Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E441BC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 04:46:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC7110EB49;
	Mon, 14 Sep 2026 04:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="G2+y4zUW";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F334410EB49;
 Mon, 14 Sep 2026 04:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJKEf4F39jOyAoPqS6dBH8TCicngwQ4CYLsvPlPvW4BxgcplwZG3xl2HeONtAn87JbB6DMJtfMRK0yM3AJjuP1qBxkWskWgDPRZcyFAO/gugHI4LhMy0ukw/UdYWpnPNBPkk3r1/lBEIBsgPhBNVINp57bmB9shb1jOCfN+NzastZdc6cSr3XQvMa8F1TX3Lt6nB6xxpSH79i8lda/CSdXcjOzzeOH/Z4uDE+fP/kb+pIDvoes4bzC3i0eSXGbDC58o7dE7d9M2bq6StR9hoRvbVG9C2kS0PuFQaANXt9+Xn1bYePj7S5KLzPIVUuJYeO+DY9pSRGFY1H2vYjfNv4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2eugNITPidWpAfsGfYfXuThkbUk9pbfgbV57TTR0INs=;
 b=bLrZiuQ6c26e31ccn/B0Lnn4hu/pWJrlsaZQOUYVk98KZGb1cUHLWB1u6xA4TZa6ZKX2RGXzt6eiQlNklXLCQm6oO1NKbgwMJNrECx2/WgIyp7FNphLbtY09gUyDXcS0ey0BToRUtu1rSjo6JKn3I9axnVEJgRKYjzsRCm/wRoTpPgWSWkwMSztLTntMQWjvd0/dPqmvaik12Hjo4RvRZbreDK0Ek0cmbiBHNayQNpe/qNOn5N8E1RPmGElqzNjJgOWsVriiKy1bM722HHr1lEhHupzT9oDQEmFkulzpOfR6+PcT4dh77B9FoIBr7TDpSILvwoIsDRxWSZaNY6pHXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2eugNITPidWpAfsGfYfXuThkbUk9pbfgbV57TTR0INs=;
 b=G2+y4zUWNLiIIKUsqW2I1cFBwW7TNg6yZN6bFxBc43lvxpGnNpUSEu/iKverxm4BZ0X9eQogqa67IETGRW6bd9FW+nZ5o3959M2xC/sBrhjysMbW+Z3//h4LioRQ0i/L4/7TAjDwSf+UfV6P8ZrE93GNRkINuVveWQY7aub3VnmSaH7jMiq5NsROBZ9/d5grtz3Wrmnb93e7S/H0kwMZomGjSal1qz1MWP9YS4c22O3zGhJFr8SlR5aIDxuR15EJEx7FObpv+XllTbwrmXI31dSVdJaLUMPANzYh+mJk5ynFJZ6qsLN4zXQnrMCloZAcqz68NaOs7bhscKbYYQx6rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Mon, 14 Sep 2026 04:46:06 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 04:46:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 13:46:02 +0900
Message-Id: <DLERLE2DDKS3.2IOUSLSOOY9OP@nvidia.com>
Subject: Re: [PATCH v2 6/8] gpu: nova-core: add NVKV typed encoding
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
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
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-6-0de9d5c8658c@nvidia.com>
 <DLBHFHGH4MEE.1ZELDBMX36IQC@nvidia.com>
 <DLC8DZY8QM5N.5Q8MS71R0VKQ@nvidia.com>
 <DLC8MGO86DKV.3IIHPUADV9IRY@nvidia.com>
 <DLCG22C6X96C.3A8EKCQAZ37FD@nvidia.com>
In-Reply-To: <DLCG22C6X96C.3A8EKCQAZ37FD@nvidia.com>
X-ClientProxiedBy: TYWPR01CA0029.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::16) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: e168603a-8075-43f4-9944-08df121b1658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|10070799003|23010399003|22082099003|18002099003|3023799007|11063799006|4143699003|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: uO8qA4nCrr/M1GbzLbuZd8HvG7+nA5sQHivAjVBXrlRcFvM0Y4gQ2sSfb57on6fMRSdPwpxMe8Ls45WC1APM8AiTbLjsr0p5Dssd5ch5fw3N3q8jaTawThwE559CzuOP4GKZQPNiFQvOxwjsd5/ulhdyCNx87MtT+LdlugVSTc7oC5DKzSh/BF1BwJL7BEmeG9m0Pu0PGBYtVj2GicTSar6qoIJkGlOvheni/l/DT/M0yeJvVJlFXln9Q6SWhK+ExNkBdURpB01Z9ixS2fdZ8NfvwcjAqzP0baJ1OHWuQ7HDpncABgNGAZYoNuqH5JdyS4bHeT80Ke7wpJZGv3/6qrhXva/ACVU0gM7X0BtNQT7FbKfilVGTok2PZ5ubahhwVLNwA4MLXJ36V4aDAYGLZOqSyPJiCnE2iz4RkStmi6jYMg+EYyWc3cDoM6yd2jJn9Mxt5HHlwJ8pCnOCIpwGA3m1HyddzFfVW7MPmrJVbcgrIQRJ6IC+X2qMv4y2cWZgSCRRcJHZbllQhJuLLucFAtWdjb/0rs18gBMOmiz11qoPBpdz3XMvAgNBiXkzuBfSC5Qquhrq38PZSehdUPjmaMK2sqCn8gh2uqPy4dKzD8cR7MdPIkukJObtEFnbKaEeLtfwgb/WhHeLUhPbnB4ZnuCe+v9pis04a/19Vm3++IM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(23010399003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(5023799004)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2lUOGp3THRlUVJaTjgzS3JqY0ZubnZSa1RWWWFuUW1UNUNVejZpdTJ4R2tR?=
 =?utf-8?B?bDRKK3ZFalMzaUpPMm9lb0xVWkVxVjJhYXY3TitoekRJakpZMWE5VHlDaW9S?=
 =?utf-8?B?bmNzNkNPQWNQZ3hVTE5qNkRvUXB1ZlgxYVRtZDJ3cGVXRGZoQUhzekVnMzZs?=
 =?utf-8?B?UXJUSGdVZjVKakxHQno5ZFRPZjE0Y2tYRzU5USsvSEo5dEhYZVNLSmpQS2ll?=
 =?utf-8?B?OWNvQnUxb0pJeEF1NTl1dkdRVStjNzVIMTcvc1pJQzdxSVdUU2VsS1JPUjBz?=
 =?utf-8?B?SFhwSkJJNUxUUnVRRjRBVFltenpsblFZR01YY3ZDKzNVQ0VzdTVzNzRZUys3?=
 =?utf-8?B?cmdXN1gvYVgrSzJIU2l0bm5NL3RmNGxsQzd0T0pybGxDRjRDN3lSekZkbHpi?=
 =?utf-8?B?dXAzREVyb1MrdUpaUUFJS2tWMzRpb1NLcWlELy81L05jYTBSZFlmR1krRWdN?=
 =?utf-8?B?UHd6VWdYa1Z5UnpOekgrbW9Dc1NUWEx5WlhOaHFzdDNBTnVvTU1Jc1ZlWGxV?=
 =?utf-8?B?SGdIMGpzaGl0cmpCNDA1bkpUZU5CbVhEa2VnL29RYmlQNElGcEhlQ29kSHho?=
 =?utf-8?B?T1pQT3JKMHcxUWlqa3VMN0RTTlJxOHJWWlRQY3NPN1hmbXRkNTdORllNc1lN?=
 =?utf-8?B?ei9VOWFxd0VyeFJsN21hbkpYUEo1NDltVThVaFUxcnNWTnZDa0N5elpqWGls?=
 =?utf-8?B?dEV2M0tvT1RmYUw2TlZOb0hMMUJRa0xOUkx5Qk5pTVljUlJMNytXZkVSRGph?=
 =?utf-8?B?djdWU2daMCtMa3VScnNVeTN4T1ZHS1BuV1V4YVc4SWJjUEtvUmlaRUxVMm1y?=
 =?utf-8?B?VEs0QzhDZEM0OXBoQngxYTdCbFhScVg5SWJIT1RYb0NWTjI1Q1o5ZnJqUjhq?=
 =?utf-8?B?U0hiSFc2VTcyVTBwZEh2Y1pLRXFDOU51aDhhN3RRRDFabEN1V2J2RStVNFJI?=
 =?utf-8?B?VGs2RDdEdVRmbkEwTlUxWW93SDFwNGUxNEYvK2JDOFlTSFhYM3M0MDJRRXFJ?=
 =?utf-8?B?ZE9JV3VGSFhsZnk4QWpEZTVPK0xMSHZFZm9rZk81cmxQa0RvSk51VldZN2tW?=
 =?utf-8?B?STJWUDVDTXJwd2d3ell1bTN6Wmt1dHRQVzc0UjBwVzVESitra0d1VE1DeEZQ?=
 =?utf-8?B?d1BNSk9lbUpDT1VyYWpSRUdVNUNicjJmbS9Ka3hWTUVQMzRmbzQyb0dxS1Z1?=
 =?utf-8?B?cndBc0p5SWVEek15Uk1NdldqV2R4amVsNERhM2pGV3poOW1HajBtbGRjYjU0?=
 =?utf-8?B?T3RzQURoOGlMZ29LK1RpTGFwTG9TdTZuZFNsYmpYYUR6OUlJTDhyOFhVaFZX?=
 =?utf-8?B?NUR5V1huMHEwQmZaZkxpcmFPRjZxUFc1aHNkd0dicTh6VzYyYUw0QklsNzFS?=
 =?utf-8?B?cHdBNUlkVFFZckFwYUZtM3NmdGVON0NqYXdwLzJzZUdWUkQvZDJ6YXFCd3lZ?=
 =?utf-8?B?bUpaQzRTajFGbUJ4SEVFaVJvQzd3KzJ0d0c1Sk1jMDJFSHNadzJ2dVJwRHhC?=
 =?utf-8?B?K0RySGFlb0R6WEYrWVlvK2dCUUY3MVZ6SDJTWUlSY0JEYWt4OXU4SURDMENI?=
 =?utf-8?B?UHl4dnZjbFJzaXpiUWVHRmVQRmRlSVFjRWJZS1p6bk5OTUUyUHNpeWVGWmdF?=
 =?utf-8?B?NlkxOGN1VFJQaHZtMjh0Vnc0bFU2RkFSdGVKTTR3V2UvZ2ZNZ09IVVdOaDJm?=
 =?utf-8?B?OStmRWN0b2M0bEZSSks0VW1WVlJ2Q0FVanlOTUNQbkowa3pIK2l3aldmQjkx?=
 =?utf-8?B?cHVaQ0d3WENGZEVuZE9KYzMwTy9GVFpucVJQc2VVb1FnTGNIVkNNVXE0aFQ5?=
 =?utf-8?B?K1JSb0NJUTFDSXhwSmVDUWQ3OVlReSsvRDZ5YjVXYnNMekRUNzc4dW5GY3Zm?=
 =?utf-8?B?dDFwVDZhSytoR25FOFRhK0FDQnAzWlVSSm95TWk1Tmc1cHNiNHQzd1VINFNy?=
 =?utf-8?B?bUZVOFFpelAvUHlERzZDb1NNbjdObHFZZlJhVHRJelFxRGZuS25ERy9yek5L?=
 =?utf-8?B?UmN6L21UTnJORGpiSit1c1kwdkZrakRUSXFJZ05zV01JcTlMcTkxUjNxZUFu?=
 =?utf-8?B?Z2hRaUxpV0FlNk4xTk9sMmVxNXk4UmlEYy9CLzErOEFwR0hCL2g5WXRnSGpR?=
 =?utf-8?B?VFRLS0U4ZlFPR0FTa3VDT1R6MTJoczd1aExPWW1vQ1BQZjBRTGtyQStEWXo2?=
 =?utf-8?B?ZEFqUDdPTmZyQ2t0UzZoZk9Ndi8xYU1jRWZqRG9xclZrREYrVDNjS1U0L1Ri?=
 =?utf-8?B?dFJVWlhBOWhickJFdjRMUENQYVRlZ25HbGhNdFZLVmpQTnJXMVg5aDRtNEZz?=
 =?utf-8?B?UXFsY3YyYk45RjJNbytQNFpjYlBhazlFdGFpbVE1UFk1ZHQzZjJSbm45TlpF?=
 =?utf-8?Q?abCGkGq8v8K/iGeSLcyWDpD+d4v8PzFG18q8rdUk11DfJ?=
X-MS-Exchange-AntiSpam-MessageData-1: 9yBg4nUs9c3d2w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e168603a-8075-43f4-9944-08df121b1658
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 04:46:05.9219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oc7cONbl0l+/7hVJR0Sv+DUQ0bmasCFhanxQxXstksvxUGDJ4HvRPpJA1Lye/M40dza/c9ykYXz5R43V+AlZRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
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

On Fri Sep 11, 2026 at 8:18 PM JST, Alexandre Courbot wrote:
> On Fri Sep 11, 2026 at 2:28 PM JST, Eliot Courtney wrote:
>> On Fri Sep 11, 2026 at 2:17 PM JST, Alexandre Courbot wrote:
>>> On Thu Sep 10, 2026 at 5:10 PM JST, Alexandre Courbot wrote:
>>>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>>>>> For struct-like GMCAPI messages encoding field by field manually is
>>>>> noisy. Add some type machinery and a macro to automate encoding of
>>>>> struct-like messages. The `Encodeable` trait can be implemented by an=
y
>>>>> type to say that it can be encoded into an NVKV `Encoder`. Add a simp=
le
>>>>> `nvkv_encode!` macro that works on structs and encodes each field in
>>>>> order. Provide some base types, such as `Key` which statically
>>>>> associates a NVKV key with some value, to avoid having to make a lot =
of
>>>>> newtypes and implement `Encodeable` on them.
>>>>>
>>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>>> ---
>>>>>  drivers/gpu/nova-core/gsp/nvkv.rs        |  49 ++++++++-
>>>>>  drivers/gpu/nova-core/gsp/nvkv/encode.rs | 178 +++++++++++++++++++++=
++++++++++
>>>>>  2 files changed, 226 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-cor=
e/gsp/nvkv.rs
>>>>> index cbeee7f376b6..10dcbb9e602c 100644
>>>>> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
>>>>> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
>>>>> @@ -10,8 +10,13 @@
>>>>>  //! naturally maps to storing a &str with the GPU name.
>>>>> =20
>>>>>  #![expect(unused_imports)]
>>>>> +#![cfg_attr(not(CONFIG_KUNIT), expect(unused_macros))]
>>>>> =20
>>>>> -use core::ops::Deref;
>>>>> +use core::marker::PhantomData;
>>>>> +use core::ops::{
>>>>> +    Deref,
>>>>> +    DerefMut, //
>>>>> +};
>>>>> =20
>>>>>  use kernel::{
>>>>>      alloc::{
>>>>> @@ -92,6 +97,48 @@ fn deref(&self) -> &Self::Target {
>>>>>  /// The index of an NVKV value.
>>>>>  pub(crate) type Index =3D Bounded<u64, 12>;
>>>>> =20
>>>>> +/// A static association between an NVKV key `KEY_ID` and the storag=
e of its value.
>>>>> +///
>>>>> +/// Use with the encoder or decoder macros `nvkv_encode!` and `nvkv_=
decode!` to let them know how to
>>>>> +/// map the value `Key<T, KEY_ID, As>` to/from encoded data. For bre=
vity, `As` inserts an additional
>>>>> +/// conversion (`From`) to avoid having to implement [`Encodable`] f=
or many types. For example,
>>>>> +/// enums that are easily convertible to a u32 can have `As =3D u32`=
 and rely on the existing encoding
>>>>> +/// for u32.
>>>>> +#[repr(transparent)]
>>>>> +pub(crate) struct Key<T, const KEY_ID: KeyId, As =3D T>(pub(crate) T=
, PhantomData<As>);
>>>>
>>>> Does the `T` need to be `pub(crate)`? The series builds fine with it
>>>> being private.
>>>>
>>>> Also the relationship between `Key` and `IndexedKey` is a bit unclear
>>>> with the current type layout. IIUC `Key` is basically a specialization
>>>> of `IndexedKey` with an index of 0. And yet `Key` is declared in the
>>>> root `nvkv` module while `IndexedKey` is in the `encode` submodule...
>>>> I'm also wondering whether it would make sense to make the relationshi=
p
>>>> completely explicit by making `Key` a newtype embedding a `IndexedKey`
>>>> with the invariant that the index is `0`, but not sure about that one =
so
>>>> your call.
>>>
>>> Ah, I guess that's because `IndexedKey` is local to `encoder`. In this
>>> case keeping it there does indeed make sense. After complaining about
>>> the visibility of other declarations, I should have noticed that one
>>> too. :P
>>>
>>> What worries me more is the fact that no index larger than `0` is ever
>>> created. This looks more and more like a bug to me.
>>
>> We currently don't send anything that wants an index other than zero.
>> But, in the future we will. The way I did this so far is by having
>> 'IndexedKey' which represents the most general thing that can properly
>> encode anything accepted by the NVKV format. Since it's cumbersome to
>> and rare to use, I added Key as a wrapper on top. It would be possible
>> to hard code 0 in the index and only have `Key` but then we'd just have
>> to change it later. Since nothing wants to set a non-zero index
>> currently, it's private to `encoder`.
>
> But surely we should be able to test the non-zero path, even if we don't
> have any real-life user at the moment, right? As this is part of the
> NVKV spec, we should ensure this is correct.
>
> If `IndexedKey` is supposed to move down one module when it gains a
> user, I think we should place it in its expected destination from the
> get-go.

You're right, let me add a test and think about moving it.
