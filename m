Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C062C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 04:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E202410EB46;
	Mon, 14 Sep 2026 04:45:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OKTUFLuF";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013058.outbound.protection.outlook.com
 [40.107.201.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1977E10EB46;
 Mon, 14 Sep 2026 04:45:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvHjocxW7/NkpuRdZAJZ37i1i4+/g0rVDFk5Ffvv/Vl6bYe7+vkUngq7HdEH3o4Cl2MRng0w381eSiK6OcVfEnIjFZIUrn6wpFkiCimcqrW5OuQIE/K9ADBJYeYDh+YmaNXL9/4ZHjnWD4UlyRF1Sis3G8pyVt6t2uCa0R1TGpEV6e4nJQMOTPa7Fj7UprEe0Ac57SBMz+PJWQW6BvKQgN8UhHU7y9MJXPklVvqfThWdo9v6XzHlQC9tCE/3eGt5WO+piEIeM6IhfajzO31fltTmh3pcfzdOYQRzlrJdOnFi4ApQZ18IlzDU+osBS/reqLYX+fBYkCqeJhFK1StFfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uCcyt9dfSKkISXimrRN0Ok2gUT+q4Dpvjq7IklfSwnk=;
 b=KmC9evuZUYpE/dWIbdtrcmNOZ+gnxIYeraS7UqACZ7ibbm/qdCSLUhnm0u95G0EdQBlkCABotA8uN1UrRE9lJswe9M8+BHr05ag7NvaQWKchMH5kCR0ZADGFPC9iWjjhDQf4dizuayboVluUwRjEx0M16VIBgcYYYwdOtd5bAXiCuwS11Yiy1HTd0XTJuHl0fbleboNoAQNyWFj55zGm7ZCOQNdo6Hi1SjEIivciE4eG1mLwYC6tNhvpQEzSpKQHjYGyvCYciIsvhTJhWUFth8vNQPs+6o7qvOl0th6NgvkC594PKQqZbzAxBlXApzORkmMMtT/3gKDKoIfr6tHlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uCcyt9dfSKkISXimrRN0Ok2gUT+q4Dpvjq7IklfSwnk=;
 b=OKTUFLuFU+LoSk/MrPKLdqUWr94+ItgaJ6W1R7prFm8nhj+qOEeAmlaDLQrzlr8i0Yo5Nuhx3kAe3AxtZaw0F/gDYFOoePfRslWddc83H2pXMZsMVx0pDhO0fe2iJ2vrRjV+sZUe3tlMDiXGvxL1tym9GipfQCmNXPNGT0AbX4n+XfHQ3576YOY/kGI1NcpVw6BshWIz18OxRWjAT4PNRczL2xww+o77uJLeizpxRjO4YB8i5A7gNHf1m4SJKJ184LXtAQnldwHxL+PINQa9gjYfENnuRXKHpX3pRqGQ+b1yg1ZgZirXM89xmozvytozn90l5eIzUUUZUqPIb2CO0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Mon, 14 Sep 2026 04:45:16 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 04:45:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 13:45:12 +0900
Message-Id: <DLERKQXXR6W4.1K44N4T2IS6UY@nvidia.com>
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
Subject: Re: [PATCH v2 5/8] gpu: nova-core: add NVKV decoder
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-5-0de9d5c8658c@nvidia.com>
 <DLADH5QVXWSD.2FO9OVBIGYNQG@nvidia.com>
 <DLADY8BA86SI.125037GQGOEN7@nvidia.com>
 <DLAIIHELWF8H.3KAZJV8DOIJ6O@nvidia.com>
In-Reply-To: <DLAIIHELWF8H.3KAZJV8DOIJ6O@nvidia.com>
X-ClientProxiedBy: TY6PR01CA0009.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c867b0d-35b2-48b6-a63e-08df121af8c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|10070799003|23010399003|6133799003|22082099003|18002099003|3023799007|11063799006|4143699003|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: puWBbkXPTQPHh9XErbLqiMXSQflsK7m4okiy69rxrLj/K23RXXbh9X/EH4PvEKSjrR88fnirn0BYnoywEk+GolXkvdNS/MJHbdmod88rsmy2WxUCi9uKtUhJGWnWZQ1hF9IjTROFAbWVT+5HP5lFu1ic8oWisZG9B5v158sxTT5AXVpNT7R5r9NllKgx8/OwdlRlJ4jNN9/keiPBLnEEETS01lObPASIXD3WECMvjFxDAHL2vyWTHPjlOd3bVLffJWF50Ps0jw8x/Bc42GKuoeqc2PdHIzl8u7JzLqQobkdYTtU//i3Pm//7ah2soXVe3d/zX+wYn25XtW+Lwx1q7wVJmy3nTGniO7T5nt4dh2utqg3mnqpPM1ACLHzrQHAZoerHXYzaHPkOPORUWZrTCCD4rtX6VTxpuc2ZckPK76SFLmhPqu+2uBe2GdgJDQ4yS5DCErDgB9BhC0P5F6P6GauNP3Rer7Sf8zq9mCJ+i9QxcIRlRbfmcHFEtR9rfQST90Vs9uJ/85Wi0N/9NXYUonmEyooO2vbNIoHEc0lcKOT5miE2KAAlEy41rRRzQQPv7EROKcB5iV5CfdBpaind2ZxaAFBhoFq/txrGvZ3gV7J9JgnON5662oPsm6gYwOFjN3/8p5wUNJv+UDKRODaJnVnkNGHa/4sIhbBb3bPV88Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(10070799003)(23010399003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(5023799004)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUdkWFJQcCtYdDZWK0dNY2hKdmVnOVA4OFVYY0l1bkkwQXJwaGNWdTBod0FS?=
 =?utf-8?B?K3VUdXd0WjUySVQrd1ZJTGpEM1BSa2RnSThJWHRleXRuUENFWWErc1FDODVi?=
 =?utf-8?B?SzU1eStDQTVFODVpV2RRbDJ4RkY5SXYwb054Uy9FZ0dzNzVNdFBFdFlEZ09w?=
 =?utf-8?B?ck5mZGdDMmZQUndkbXdaZlFEd0w0ck1NT0ZGVE9NTmJpRms3c3NhNVpNVmla?=
 =?utf-8?B?eW83VW9teWxBVHF1V1FxNXoxc1lJQVg4cXN6THhITVhySExyOWd0SnV6Q3Q2?=
 =?utf-8?B?bWNMS0FjckZ3T3JUcnlTTVBmODZ3bVVVbzkxRGlQQVlLOXBHTlI1QzNRRngr?=
 =?utf-8?B?Mjg4UFV6MHdoc2pQU0FOUlIybHVVVHMydmVBS2dhTkk4K2lrcThPNjV6VVhT?=
 =?utf-8?B?OTZtTm16VURIdXl1VjVleWRhVUlXWnBCTExhQlQ0RXEwdTR5cC84L2VrR1lK?=
 =?utf-8?B?bDBxenp6UmgyV1gra1lMcGhZUDAvdFIrMGdZRXE2QU1oK0w1T0JxYktNenNs?=
 =?utf-8?B?ZW9tZDkyK0ZiNnVYRnNQekJ0eGs0ZFRTbkpERVd6ZmhoMkJLS1dwd1pRVWpV?=
 =?utf-8?B?N3FPSEVsQlBCRlVmSXJmaW9aaTJmYi9jYXpEK1lLTXVSYXBZNzBQSDRtdUtt?=
 =?utf-8?B?MWRGdUFibEw2ZGgxZC90bGtEMkoxZm1qN3MrMmJJcVBGTjIybm8ybXpWTXZ5?=
 =?utf-8?B?cURGbEo2ZEpZVUJqSjMzcW9iMTBpTVBNczVEYTF5VXhKdms3YkFieDFpWUEv?=
 =?utf-8?B?OWZkNXR6YzBIdXBUZ1lxL3d0RFN5WXN4TlpvMHRZREpHZWZjYktGOXFNdHA5?=
 =?utf-8?B?SVlZRVMvSXZ2QXdmZElXb3U4RFptRG50dmIzTmxzZk1kdEV5Q0NwbWp2Y0kw?=
 =?utf-8?B?VFAyeHU0Q3BNbHd4amh5TTdZdTRaMWJJOHBvbjRobWJ6dDBhOVlIOFRpWWU4?=
 =?utf-8?B?cG54a1dKMlA4MnRYT3l5dEJIK0J5U1pzV3pHNk0rR3lScVVQR3lWcVNNb1Nr?=
 =?utf-8?B?Q1JKUXcrcW1ZNEVvTXdHZllVbGUyMWxQREtBTmVCc1NSSlYwOVZ2WFplNEZ1?=
 =?utf-8?B?VVlMai9CZjY0N1BSUzV2aHlQNkFjVWZjRHg3N3JFTTYrYjA5WXcvanQrb1hV?=
 =?utf-8?B?RUEwS1N0N1A1cEJPMHpYQzlPL3JYaFJwM2tkdE5WK0dGamljM20xdXlRY2Uz?=
 =?utf-8?B?NHNOem9CRkp0TjNFYVV5Y1VnN3U3ZjFWalBBUFhPemFibWRyc0FkSjNKUWg0?=
 =?utf-8?B?VytnZUxJV3hRRUZZVzBrblRlMFFTd0Vldk5MdkVhNU9TdE9GWDlldTFIVm9z?=
 =?utf-8?B?K21NK2RpUlozQ3ZjaDRoL1hPV0FNQmtEekhSaU1FUjA3ekE0VUUrOTRlUGlM?=
 =?utf-8?B?cis4Ri9MYnhrK0p4a3AxYUdHRDNmcnA4VWp0RUI0QXU2WU02aTdjd1ZKZHJC?=
 =?utf-8?B?cGw0cTZmcm5lZHc2WnFSY0tTczVGbWNpLytoTzNIRS9qTkhsbG9JbG5SL3U3?=
 =?utf-8?B?UXRmWlhmYlcyaERBTjEreFhrRFdIY2loMy9uRlZmcWZjTHJnL3hzVkpSZGVW?=
 =?utf-8?B?Wko4UlRyZFdBYk5yckF2S1ZXU1IxMHVYWjIxVzZZQ2V2clNiZXhhcTVGNlJX?=
 =?utf-8?B?aFdLL2JVenhIblZuY2tKZ0xPY0VrNldwRW9IR1ZoV1lCR3pyanU5b1doQ2xS?=
 =?utf-8?B?bXc5eGRmNWNYZTVYa3k0eldhQlg3dXF3aDlrM3BiRlFncDcwcEd1OUlSN2xK?=
 =?utf-8?B?ZmZzakFrcFBsRFRCV0RnNE1pUXZHd0JYU200amtlZjI3TDJGMW1lVDhMVmt6?=
 =?utf-8?B?WWU5UXNnejB1Z0ZHZWw4YlkzNU13eDN6UThEaGVEMlMwZUVvRHVxbHVPcDNE?=
 =?utf-8?B?VUF1R1BxdkxCWmJFYU9pak40UkRaUG95bE5SdmF2MklpcERreERrNndIaDkx?=
 =?utf-8?B?S1gxVGIra1BlcUY1azQ1UFNaMVBDTEZaSlFNUUZlTEdRVHJvOGl3bW1UMkRO?=
 =?utf-8?B?SzlvQy9LdFdKem95bmV6b05Jc1JlSlVDcVY3WFprNDVmL3B2UEZGdmFOaXJI?=
 =?utf-8?B?UE5HcWI4ckQ5R0RIUEN2eWNCSmlkNUtsZnllcVM4K3dYcGtpMGxEdjMvOFpz?=
 =?utf-8?B?MDVxc01GR2RPM3Uzc1ZiaWE1cGdrYmJtTFcwYUxWam9VdmVXV2JxbUFVSnRD?=
 =?utf-8?B?RHpqTVpBaVZLdlFKWDdtNWFxQ0hZQXhZNWw1SWJqS2p3bnFOaFNhVU5HcnhK?=
 =?utf-8?B?TFhFaWVxUTdIQ05IdkFoZ1ZISkhrcFY0T1QycUU4T1E4bDhtVjhoMlhZTXVx?=
 =?utf-8?B?ZGwxd3E0WHFDN3h4elBIbFdPQTNNOEVDclZpUjRDTUVCNFczc1VnWDVzNUhv?=
 =?utf-8?Q?d6RDmMole6tcHu86djJirUAJ+rGsVkzggUvf1k3FLRZgV?=
X-MS-Exchange-AntiSpam-MessageData-1: 1IU/4Vv/16negw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c867b0d-35b2-48b6-a63e-08df121af8c5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 04:45:16.3141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cg2YZdq7xKxvfJ3MUW5KO/dLfc+K8IjTn7OZWK3wk/IdZnHum35zQdgEg72TWn8pSIjfYmRBwkIPcjjcfm/dGw==
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

On Wed Sep 9, 2026 at 1:48 PM JST, Alexandre Courbot wrote:
> On Wed Sep 9, 2026 at 10:13 AM JST, Eliot Courtney wrote:
>> On Wed Sep 9, 2026 at 9:51 AM JST, Alexandre Courbot wrote:
>>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>>>> Add a decoder for NVKV. This is for receiving messages from GSP for
>>>> GMCAPI calls. The NVKV format essentially encodes a sequence of functi=
on
>>>> calls f(key, index, value). This decoder reads an encoded stream and
>>>> invokes a type implementing the new `Schema` visitor trait. The
>>>> `Schema` trait can either consume the value or not, which is useful fo=
r
>>>> composing Schemas. If a (key, index, value) is not consumed, error out
>>>> depending on `UnknownKeyPolicy`. Whether ignoring unknown keys is ok o=
r
>>>> not is per each GMCAPI call.
>>>>
>>>> Add kunit tests for the decoder.
>>>>
>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>> ---
>>>>  drivers/gpu/nova-core/gsp/nvkv.rs        |   3 +
>>>>  drivers/gpu/nova-core/gsp/nvkv/decode.rs | 265 ++++++++++++++++++++++=
+++++++++
>>>>  2 files changed, 268 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/nova-core/gsp/nvkv.rs b/drivers/gpu/nova-core=
/gsp/nvkv.rs
>>>> index a8e16687a134..cbeee7f376b6 100644
>>>> --- a/drivers/gpu/nova-core/gsp/nvkv.rs
>>>> +++ b/drivers/gpu/nova-core/gsp/nvkv.rs
>>>> @@ -27,6 +27,9 @@
>>>>  mod encode;
>>>>  pub(crate) use encode::*;
>>>> =20
>>>> +mod decode;
>>>> +pub(crate) use decode::*;
>>>> +
>>>>  /// The allocator backing [`EncodedStream`].
>>>>  type StreamAllocator =3D KVmalloc;
>>>> =20
>>>> diff --git a/drivers/gpu/nova-core/gsp/nvkv/decode.rs b/drivers/gpu/no=
va-core/gsp/nvkv/decode.rs
>>>> new file mode 100644
>>>> index 000000000000..ceb97e73e100
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/nova-core/gsp/nvkv/decode.rs
>>>> @@ -0,0 +1,265 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +// SPDX-FileCopyrightText: Copyright (c) 2026 NVIDIA CORPORATION & AF=
FILIATES. All rights reserved.
>>>> +
>>>> +#![cfg_attr(not(CONFIG_KUNIT), expect(dead_code))]
>>>> +
>>>> +use kernel::prelude::*;
>>>> +
>>>> +use crate::gsp::nvkv::{
>>>> +    Index,
>>>> +    KeyId,
>>>> +    Op,
>>>> +    Opcode, //
>>>> +};
>>>> +use crate::num;
>>>> +
>>>> +/// A decoded NVKV value.
>>>> +#[derive(Copy, Clone)]
>>>> +pub(crate) enum DecoderValue<'a> {
>>>> +    Scalar32(u32),
>>>> +    Scalar64(u64),
>>>> +    Array8(&'a [u8]),
>>>> +    Array32(&'a [u32]),
>>>> +    Array64(&'a [u64]),
>>>> +}
>>>> +
>>>> +/// Implements `TryFrom` from the given `DecoderValue` variant to the=
 given type.
>>>> +///
>>>> +/// `TryFrom` is used by the `Schema` implementations in this file to=
 convert from the
>>>> +/// `DecoderValue`s into the types to store. Provide the implementati=
ons for basic types here.
>>>> +macro_rules! impl_try_from_decoder_value {
>>>> +    ($ty:ty, $variant:ident) =3D> {
>>>> +        impl<'a> TryFrom<DecoderValue<'a>> for $ty {
>>>> +            type Error =3D Error;
>>>> +
>>>> +            fn try_from(value: DecoderValue<'a>) -> Result<Self> {
>>>> +                if let DecoderValue::$variant(v) =3D value {
>>>> +                    Ok(v)
>>>> +                } else {
>>>> +                    Err(EINVAL)
>>>> +                }
>>>> +            }
>>>> +        }
>>>> +    };
>>>> +}
>>>> +
>>>> +impl_try_from_decoder_value!(u32, Scalar32);
>>>> +impl_try_from_decoder_value!(u64, Scalar64);
>>>> +impl_try_from_decoder_value!(&'a [u8], Array8);
>>>> +impl_try_from_decoder_value!(&'a [u32], Array32);
>>>> +impl_try_from_decoder_value!(&'a [u64], Array64);
>>>> +
>>>> +/// A visitor that consumes decoded NVKV and produces a `Target`.
>>>> +pub(crate) trait Schema {
>>>> +    type Target;
>>>> +
>>>> +    /// Visits one decoded pair. Returns `Ok(true)` if the schema con=
sumed it.
>>>> +    fn visit<'a>(&mut self, key: KeyId, index: Index, value: DecoderV=
alue<'a>) -> Result<bool>;
>>>> +
>>>> +    /// Returns an initializer that makes the decoded `Target`.
>>>> +    ///
>>>> +    /// After the returned initializer runs, the schema should be emp=
ty again.
>>>> +    fn finish(&mut self) -> impl Init<Self::Target, Error> + '_;
>>>
>>> Would it make sense to make `finish` consume `self`? Because "the schem=
a
>>> should be empty again" sounds like an implicit contract not everybody
>>> will think about enforcing, which could be a source of subtle bugs.
>>
>> Yeah, it would make sense, and that's what v1 of this series did. But, I
>> noticed that it forced materialisation of the Schema on the stack (and
>> the Schema can be large), even if you allocate the Schema using a Box.
>>
>> There's two places where it materialises - in Decoder::decode and also
>> in Accumulated.
>>
>> anyway, that's why I changed it to the valid-but-empty like convention.
>> Please LMK if you think there's a better trade off solution to avoiding
>> materialising this on the stack.
>
> Indeed, I don't see a way around it. In this case can we make the
> requirement stronger than "should be empty" in the doc? Because AFAIU
> caller code depends on this behavior, although most of this is handled
> by `nvkv_decode`, so we are working in a controlled environment here.

Yes, I'll strengthen the wording, sgtm.

