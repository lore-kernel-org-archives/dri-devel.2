Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39EEC61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 00:08:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E6510F1FF;
	Fri, 28 Aug 2026 00:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="dMRqpr/Q";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010042.outbound.protection.outlook.com [52.101.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B5E10F1F9;
 Fri, 28 Aug 2026 00:08:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heF+PqkbLDqzSYUImtw87wwDkGHwRLpMic2t73o3YZMMTsm1VRVoiw582YO8++UsI2pRIbtNq9+pzPAsz9f0LSJCFB4Ow1WG4P39Q9tPGaPeKF75I4a+OkJfDL5Ez+E43RLD5AjPSbSjdpTenkuGVxXbtlL+r43qmcfdUGde6YdHExjuvltc37NCTUo8fEjESiJmf/sl/lkxn7X5cpoLuWd+Gzh879YhmU8xzKHs979a9qY6Ckc5kazn2NAVBEiIvZiWM+HuNsuNjVjdyoWOXvPpYFvvyT3MkobFc5OWgpS3s88w0AzD+kqYUpP6lMzskG+nHpbc4bZyiHNfzGCnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab3E7GZ3xKj5gOrH749OnqfnaeJm2ovJVqnsKO6n/VQ=;
 b=pO+XwfIgYnHGoX5RofeBxKMsFOvEtk8ORmv2N207GHjMpor+eKCEaBp8lTX9xk3h4RjHfQmGIMm1YOap4V7kPJDDz8nPMu14+q8DfIzSxkWskvNXGBYVVoX8Jui/kk/9+FiNCECWuXkJe8ZGwx9JQM6tEPT8SuwJWhp73z8fT4/AzRZloIa3WCCaxvPf3apc0ZIbkvaUjBOfY0cz//6PJiQd7tc18DRhF4VjG6XZabTpqf6MuisuKioUEZOC6NLapy7WnFKalP9ckk5P9J8buz9yAyIj6jCROp83/9IujtGpxwKDHbKF57PLz5t6/5150o5QmdnscF9QaRjYMuM47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ab3E7GZ3xKj5gOrH749OnqfnaeJm2ovJVqnsKO6n/VQ=;
 b=dMRqpr/QxjeP5rgGFRcszDVfaaKu+QsLPux9qbxbERejYxaDSD+s1ANuCcrPr2ZYbBJUKw25oAjedyPIzfEhEpJM1LOI5/m9vQk2x+2q5NZEBvmuswXY6PSI63x1Yhq16ESy9mlNjRJtFdyrBhEVR7M6gb9YtO8XRuK5QfdzRyNsTe8LA4sPgO8dcb+fhIWMlopqDB3HHPPbnZw4ohiN1b2mIWg2WjeZ/6Pccv1xRRMVznz89feznKgP5+wAjfhEgiMJwz4HfHZZAwpYpcQvRD3J+ysQE7i+CPHkX1fxaoA6h3JUkQzKJoApR9eljFy85OqZyIKHgrPDP/CmvSsnag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS7PR12MB6022.namprd12.prod.outlook.com (2603:10b6:8:86::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.10; Fri, 28 Aug 2026 00:08:17 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 00:08:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 09:08:14 +0900
Message-Id: <DL051FB1HOBY.2UC911T3M9AIS@nvidia.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
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
Subject: Re: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alice Ryhl" <aliceryhl@google.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-3-bc74c77d0214@nvidia.com> <apAEK9CUZICDTL1i@google.com>
 <DKZNWJZTS063.3Q91LQ4LNE4Q6@nvidia.com>
 <DKZOJLLRFT75.1967F9U9JUTVV@nvidia.com>
 <DKZRUNURZ645.1R1EVJ9ZEXFDE@nvidia.com>
 <DKZSPZS1CQ29.11DHEBVKWF21O@nvidia.com>
 <DKZSWB7OFDRY.1QKAIFC1QP9RA@garyguo.net>
 <CAH5fLgiGcOn+HQLj4w9yDc31V54PbqNUQv8cUFRoEuFzQrAAZA@mail.gmail.com>
In-Reply-To: <CAH5fLgiGcOn+HQLj4w9yDc31V54PbqNUQv8cUFRoEuFzQrAAZA@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0078.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::15) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS7PR12MB6022:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb7879c-b7c5-4928-421b-08df04987629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|10070799003|366016|7416014|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003|5023799004;
X-Microsoft-Antispam-Message-Info: etndff+zlTYcrMMnDaLYrozQqV0ZC2lmflVpTf54r+UfFpIoXdlWMz80zZUTzChz2IIKBYU8HWmeZzZe0VVx3vbtf0bNYuncmnZ+Ig3cnBb28fhKKNrOiPRzc/tC+Ssmjfcv7DQrrkcGOge9nNKQ9IA4Lci5n0J9a01BGQ6W8NDtOqnx9fsOvXEKKEtmrxVyPkazM7d1OKH3//YNxFvi/s11QGYa6D8m4myLjNTXJ94JfW6JgMg3jgUOi6b1Mm8UQN1t+LZ47zdrqgqPjT5m1pcqSyxw+pyISvSFh5ZV2VARUGRkJaUqgkFai9QL62eJI+VMLow9QujgeRuTkKTlDtn3tJ9qDTxnTVT4rprEk8xO+XXFtWIGR00f1DjE6/02H8huMcT9rfRHvjPXXnqlaeKxaQhqq9feIThSYvjRznlW9GLggRvS8vdAoENroRFu7IUc3u8KC+7zSWrObGggMH/NradsGqMQrnDOI8hLrEOC+SNHlOvlTYfrCaIXXutRSdLri13swAj23l4nZJZu+LbXam01RsRW7v9SvHbUt3notMkIPXjtL6AC0d29DoSGADWEzsZ3tihqI5/buJpxR57eGRKIvmQR74DBpA3mQsFkh8FVjeh5P/RIAacy5WYn9R3BLP+RVPcPLeIncz6js0omSXpUPu16ft1/JXWo9nQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(10070799003)(366016)(7416014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFpTbzZCRGRwNlF6WitFT01LZkt4L2RjWGh2ZDRtNjVMdVA3bUZ6ODNoYlEx?=
 =?utf-8?B?TGVyN0ZsUkh3UzRsMUZKaEZQckNYdll3U1RDWWVhM2xmSnhZa1h1c2hGa3Rt?=
 =?utf-8?B?UWZzb1hUOFlMRzJlT2QvZUt3THJQOFRKK2pJbDJoWk8xOTJKS3kreVhEMHF6?=
 =?utf-8?B?NGZhNzgyb0xYTHN5ZkVzYU5neXRqb0l4VU9CbUlsL0RscmVFNXFaMnR0NTdH?=
 =?utf-8?B?U3FrTTVRaVN6NkxKQVcwY25laERDeGxOOTlZTnVBUkxvbmRmN0d4dkhONlNN?=
 =?utf-8?B?ZFZycWlET1F0L1h5WUsrMFVJcEx0T2gvTlBLT2FCVG9qeWtGL0hEbnZQb3kz?=
 =?utf-8?B?L0llVXVUWTFETFhtWlM2eFJucnJFcnZsVm9QYm5FMFhFdDJDN2RRa3ZQWGgz?=
 =?utf-8?B?dndLWTZhRkNCZzYzV3hibENBb0Q4Y3pldkFva1JMaHhRWmJJRVBLdlQ5NXZI?=
 =?utf-8?B?ODh0NzJ3TmpvUzBGY1pXNjZKRkpLY2ZUNHhTbU1GeGI5cHdKQURmbVlkbWRI?=
 =?utf-8?B?RlkvV2xwNW16dTlGUGI5V216QkphNnJ1RFhFODB1bDdrYnBCVy93VUlKc1FT?=
 =?utf-8?B?cjFKeFZVVktkM2RtbFQ5YkxxSXI1bmxnNDZ4ZXVKdVZ2QUsxM3kwUjlacFVR?=
 =?utf-8?B?MkJLU3dsS0k2bTdYYUo5WVozN0Fkak9UOTlTVE5RYi9vbGVGS01oYzdtNXU3?=
 =?utf-8?B?VDBDMk54bDZ5LzkrVmZya25TMGd3Q09DeFhMNW0wMk1lRldBYTBONUw3MWVD?=
 =?utf-8?B?NDc4bFlJb00velJ2d3hXMHNZL3BHQ3ZnTVdqZ3N5VG4vVmJkUGhvaTdmSDg5?=
 =?utf-8?B?Vk1Vam5WRUNXbDV6aDZMZmdlUVFVamtacFRIVHByZ3gzc0pOTWNacXNyNUtM?=
 =?utf-8?B?bUVoQ0JCTnAvV2g3bEhwZEpieWxVeTBlTWRpQVg5WlArNFhYKysvR0NUR0U4?=
 =?utf-8?B?ZnZRMmlqaWhwc0RYY2xNd0ZUZnNNNG5jM2N2Wllpbnc3Vkg5UXRMU0JkZlk3?=
 =?utf-8?B?Rk5hMEpDZEpQd25haXVhYzR4Vlp2YWdRcUZaVkpQWVJiU1ovd3BvbUpnZjJr?=
 =?utf-8?B?MmhUdVh6QlYwRTFTa3hxb25Wd2RhWjcycWp4eHpabGRVeUE1T3lwdUpvRUxF?=
 =?utf-8?B?T0hoVGlqa2hMajNFTFNJbERsQTc2ZnBpK0dIZGtiUURrSXZOb043aWpQQi91?=
 =?utf-8?B?T2Zia1FqbmtST3g4bFR4c3ZlQWFXRGJpdllpWHhrTjhTZTBPd3ZJeEQ2Q1lH?=
 =?utf-8?B?YjF0cExrTTVRaWRidjAvTlZIaFIwNTJ6czkzSGMvVVRjdGUrVFdqamRaWnV4?=
 =?utf-8?B?bFNWK01XZll3TWdrU3h1cWVvM2w2SWhqMm8yZlJ2LzEzamIvUjNKZEN1dGZT?=
 =?utf-8?B?THJrQzhnZTUxRkNtdUFidDYxS3BDN2xRVkd3TnFxTTFDNHpGL2dZcVRQc1Nn?=
 =?utf-8?B?QTJXTlVmeDRoNVhySFlsNEw1ZXVCU3IyaWd2S3JZaDF0T2Z1aWsrNXdSQXZj?=
 =?utf-8?B?aG5WaFpxWW9Ucm0zVGNROWdQcmNNa1ZlUTJrYzJtN2U1bHg3VWo4UTVxRXBR?=
 =?utf-8?B?b0RjaldmaFBKdHp4a3lOMkF5VGZZWFNBRElZT0Z6VTkyblZvMlR6TndvcVNB?=
 =?utf-8?B?eWRtTXJINmN5VTlQNkRnMW1xNVdWbDVFS0QyZ0pJbXZUSHgwcUlCZTF2ZDNF?=
 =?utf-8?B?Y0d1aGhIbm5wdTc5WGV1dnQ5SWFwdklVMDZtRzhHazd6M01GeDhTbnpwRlho?=
 =?utf-8?B?dmpDR255eDR2Uk9SNEJvaThQREV2QzdxZ1B2cnc2TlRLWTRycFVnN2hGWFgy?=
 =?utf-8?B?Q0h6RTFYYVZ4Q1NuSTQ3NWQrVm1QbnBEMmVaSHpMRGdDRFBoS3JLZ2JHc3Ar?=
 =?utf-8?B?QTliaEZObWx0VmJZVXE4ZElialZQSTFGMFhGdkc3T2dVTzVoSGIySW1zWGFP?=
 =?utf-8?B?dW56L2VFNEY4TG9lN1lLTGhlTEZ3Z0lCdGF1RytkL3RlOE9zRTEzeWNIT0la?=
 =?utf-8?B?RlFSTlNLVjNtd3RseExPcU1reEF3S0tsRE9nT2pPdmZnaXZBSzJxbmVRajda?=
 =?utf-8?B?bDc1VEl6UTNMWlgzdHV2ek5obksrZENlWFNBdUliK1JJRVEyZVBVeHo5dVZ2?=
 =?utf-8?B?Q2RUU3VFVjN1anFacjdyQ25IZkk3OTZxamVZRk55TVE2ZWpVQjI1d3hQS2tZ?=
 =?utf-8?B?cUtoY2NJOEl3NjNNYnp1UnZHa3lnSGxCZ3RqNnhJQUdQSWFpc0tsSTVHdlQv?=
 =?utf-8?B?aDlvajNVZzZTeVVDdHJvYVJydW05UzhSb0dtU1duZUgrTytLK0hxNW1iem1J?=
 =?utf-8?B?TzU5TnRIVEVWNnF4cnFyMU1uQUZiQTYyZEtUbEdibmk2cUdJQld6VmVtVjk4?=
 =?utf-8?Q?XVyC0xP1WOQ+arcx361lkv3QGcMP7r4mtTkGiOzXQAot7?=
X-MS-Exchange-AntiSpam-MessageData-1: fnWud3lhAr1lJA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb7879c-b7c5-4928-421b-08df04987629
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 00:08:17.5597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dOj9rS0py2QKxgFmZJmQwA3y13UWdcoi2iDkWTCHENH6pVL/zb8ca1Jz6/xayE5WM8tabQ5MQWRaKMfWyM0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6022
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

On Thu Aug 27, 2026 at 11:55 PM JST, Alice Ryhl wrote:
> On Thu, Aug 27, 2026 at 4:37=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
>>
>> On Thu Aug 27, 2026 at 3:29 PM BST, Alexandre Courbot wrote:
>> > On Thu Aug 27, 2026 at 10:48 PM JST, Eliot Courtney wrote:
>> >> On Thu Aug 27, 2026 at 8:12 PM JST, Alexandre Courbot wrote:
>> >>> On Thu Aug 27, 2026 at 7:42 PM JST, Alexandre Courbot wrote:
>> >>>> On Thu Aug 27, 2026 at 6:32 PM JST, Alice Ryhl wrote:
>> >>>>> On Thu, Aug 27, 2026 at 04:28:31PM +0900, Eliot Courtney wrote:
>> >>>>>> Currently, using NonZero/Bounded constants is quite verbose. It's
>> >>>>>> unfortunate because it disincentivizes using it in interface boun=
daries.
>> >>>>>> Introduce a macro to make it nicer to use. The macro `cv!` (for c=
onstant
>> >>>>>> value) takes a const integer expression and widens it to i128 (at=
 build
>> >>>>>> time only) before passing it as a const generic value to a new tr=
ait
>> >>>>>> function `FromConst::from_const`. The trait is implemented by Non=
Zero,
>> >>>>>> Bounded, and Alignment and lets values of each be constructed fro=
m
>> >>>>>> constants without a verbose turbofish syntax. For example,
>> >>>>>> `const { NonZero::new(1).unwrap() }` can be written as `cv!(1)`.
>> >>>>>>
>> >>>>>> Suggested-by: Gary Guo <gary@garyguo.net>
>> >>>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> >>>>>
>> >>>>> This doesn't work in const context, so I don't think this is a gre=
at
>> >>>>> strategy.
>> >>>>>
>> >>>>> I would want to use it for cases like this:
>> >>>>>
>> >>>>> drivers/android/binder/netlink.rs
>> >>>>>         const BINDER_CMD_REPORT: u8 =3D kernel::uapi::BINDER_CMD_R=
EPORT as u8;
>> >>>>>         const BINDER_A_REPORT_ERROR: c_int =3D kernel::uapi::BINDE=
R_A_REPORT_ERROR as c_int;
>> >>>>>         const BINDER_A_REPORT_CONTEXT: c_int =3D kernel::uapi::BIN=
DER_A_REPORT_CONTEXT as c_int;
>> >>>>>         const BINDER_A_REPORT_FROM_PID: c_int =3D kernel::uapi::BI=
NDER_A_REPORT_FROM_PID as c_int;
>> >>>>>         const BINDER_A_REPORT_FROM_TID: c_int =3D kernel::uapi::BI=
NDER_A_REPORT_FROM_TID as c_int;
>> >>>>>         const BINDER_A_REPORT_TO_PID: c_int =3D kernel::uapi::BIND=
ER_A_REPORT_TO_PID as c_int;
>> >>>>>         const BINDER_A_REPORT_TO_TID: c_int =3D kernel::uapi::BIND=
ER_A_REPORT_TO_TID as c_int;
>> >>>>>         const BINDER_A_REPORT_IS_REPLY: c_int =3D kernel::uapi::BI=
NDER_A_REPORT_IS_REPLY as c_int;
>> >>>>>         const BINDER_A_REPORT_FLAGS: c_int =3D kernel::uapi::BINDE=
R_A_REPORT_FLAGS as c_int;
>> >>>>>         const BINDER_A_REPORT_CODE: c_int =3D kernel::uapi::BINDER=
_A_REPORT_CODE as c_int;
>> >>>>>         const BINDER_A_REPORT_DATA_SIZE: c_int =3D kernel::uapi::B=
INDER_A_REPORT_DATA_SIZE as c_int;
>> >>>>
>> >>>> `const_as!` [1] should do the trick for this, provided you don't ne=
ed to
>> >>>> create a const `NonZero`.
>> >>>>
>> >>>> [1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe2=
@nvidia.com/
>> >>>
>> >>> ... but I agree it would be nice to be able to use this in const
>> >>> context. And there is an overlap with `const_as!` that becomes more
>> >>> obvious the more I look at it.
>> >>>
>> >>> In for a penny, in for a pound of macro code as they say. Since we
>> >>> agreed on using macros, how about unifying both under the same `cv!`
>> >>> macro, with as many branches as we have types we want to initialize =
from
>> >>> a constant value? For instance:
>> >>>
>> >>>     // Does what `const_as!` currently does under the hood.
>> >>>     const BINDER_CMD_REPORT: u8 =3D cv!(u8::from(kernel::uapi::BINDE=
R_CMD_REPORT));
>> >>>     // Calls `NonZero::new().unwrap()` under the hood.
>> >>>     const SOME_NONZERO: NonZero<u8> =3D cv!(NonZero::new(kernel::uap=
i::NONZERO_VALUE));
>> >>>     // Calls `Bounded::new::<{ ...}>()` under the hood.
>> >>>     const SOME_BOUNDED: Bounded<u32, 2> =3D cv!(Bounded::new(kernel:=
:uapi::SMALL_VALUE));
>> >>>
>> >>> I.e. we would have one extra matching arm in `cv!` per type it handl=
es
>> >>> instead of implementing a trait. The syntax of the macro would look =
more
>> >>> natural (bye bye `const_as`'s awkward `=3D>`), albeit it would have =
the
>> >>> limitations of such a semantic dispatch.
>> >>>
>> >>> Even the name `const_as!` wasn't really accurate to begin with: what=
 it
>> >>> really emulates is a const `try_from`, and we even discussed
>> >>> implementing it in these terms in the future.
>> >>>
>> >>> I'm sure the idea needs more polishing but I think there's something=
 to
>> >>> explore here.
>> >>
>> >> Yeah I agree that const_as! is similar and if we had const traits we
>> >> could fully merge them and have it always work in a const context for
>> >> both duties (which are really a const tryfrom as you said).
>> >>
>> >> I am not sure about the suggested syntax (e.g.
>> >> cv!(Bounded::new(kernel::uapi::SMALL_VALUE))), since it seems very
>> >> verbose.
>> >
>> > A bit, but what I like is that it looks very close to what you would
>> > naturally write if you had const traits (minus the unwraps), so you
>> > don't have to learn a new syntax. As long as it's not *more* verbose
>> > than natural Rust, I think it's fine.
>> >
>> > It also has the benefit of relying less on type inference, i.e. `cv!(5=
)`
>> > requires the caller to specify the type even with a `let` statement,
>> > whereas you could do `let v =3D cv!(NonZero::new(5));` and it would wo=
rk
>> > as expected.
>>
>> Even with const try_from we'd still want `cv!()` to avoid having to writ=
e
>>
>>     const { Type::try_from(...).unwrap() }
>>
>> I think having `=3D>` syntax is great because it is a good place to *opt=
ionally*
>> require type annotation.
>>
>> For enum repr for example, I think it'd be great that
>>
>>     const BINDER_CMD_REPORT: u8 =3D cv!(kernel::uapi::BINDER_CMD_REPORT)=
;
>>
>> would work directly. It might need some tricks, which I have hard time c=
oming up
>> as I'm not feeling very well today, but I'll give it a shot over the wee=
kend...
>
> One could potentially define a trait with a MIN and MAX value
> constant, and then implement cv! like this:
>
> 1. Verify that the value lies between MIN and MAX.
> 2. Cast the value to uNN of the same size as the target type.
> 3. Transmute the uNN to the target type.
>
> Since the trait has no methods, this works in const eval.
>
> Alice

Using an associated const by itself appears to work - I tried this which
is very similar to Alice's suggested approach above:

```
macro_rules! const_assert {
    ($condition:expr $(,$arg:literal)?) =3D> {
        const { ::core::assert!($condition $(,$arg)?) };
    };
}

trait FromConst<const V: i128>: Sized {
    const VALUE: Self;
}

macro_rules! cv {
    (@widen $v:expr) =3D> {{
        #[allow(unused_comparisons, unused_assignments)]
        {
            let v =3D $v;
            let r =3D v as i128;
            let mut back =3D v;
            back =3D r as _;

            ::core::assert!(
                back =3D=3D v && (v < 0) =3D=3D (r < 0),
                "value cannot be losslessly widened to `i128`"
            );

            r
        }
    }};
    ($v:expr =3D> $t:ty) =3D> {
        <$t as FromConst<{ cv!(@widen $v) }>>::VALUE
    };
    ($v:expr) =3D> {
        <_ as FromConst<{ cv!(@widen $v) }>>::VALUE
    };
}

macro_rules! impl_from_const_int {
    ($($t:ty)*) =3D> {$(
        impl<const V: i128> FromConst<V> for $t {
            const VALUE: Self =3D {
                const_assert!(
                    V >=3D <$t>::MIN as i128 && V <=3D <$t>::MAX as i128,
                    "Constant cannot be represented by the target type."
                );
                V as $t
            };
        }

        impl<const V: i128> FromConst<V> for NonZero<$t> {
            const VALUE: Self =3D {
                const_assert!(
                    V >=3D <$t>::MIN as i128 && V <=3D <$t>::MAX as i128,
                    "Constant cannot be represented by the underlying type.=
"
                );
                NonZero::new(V as $t).unwrap()
            };
        }
    )*};
}
impl_from_const_int!(u8 u16 u32 u64 usize i8 i16 i32 i64 isize);

impl<const V: i128> FromConst<V> for Alignment {
    const VALUE: Self =3D {
        const_assert!(V > 0 && V <=3D usize::MAX as i128);
        // The unwrap fails the build if `V` is not a power of two.
        Alignment::new_checked(V as usize).unwrap()
    };
}

const A: u8 =3D cv!(200u32);
const B: NonZero<u8> =3D cv!(5);
const C: Alignment =3D cv!(4096);
const D: u8 =3D cv!(200u32 =3D> u8);
```

