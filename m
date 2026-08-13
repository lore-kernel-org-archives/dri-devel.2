Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B00C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 21:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6148310F531;
	Thu, 13 Aug 2026 21:38:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fBol+8tS";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010018.outbound.protection.outlook.com [52.101.56.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0CA310F531;
 Thu, 13 Aug 2026 21:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOGRpi5zCVveVLDO0QQHA7xc/18L7ghF8VGiYaj8hesWgd9AC+e/wMUJkwFsNkGaeb5Vd6XSZ5hDPXErWP6FBppyNQtlaG5wVbNx9/dIIVxSlwsZBbIsgJ3oaK8JWqNdPlwP+iWjmaJxuY/+Zd7W9e1NfJhGhn6ok727XzpPcX+OOgpUnBSpPmtxseNeAItSoQjlsJeeszWQPwCSGx/hSENx4F53WgAutpoEs8+Xq3v0L3G7FNSGC+z2OjkPQpVDKB4whQ8sGdI3oOs8UIIJdkfqNuVtnCSwya4wMQWvmfQBRsp4Ai0vEAxd7FN1v6VF98Hr8PE0fazQdMGxFKTQxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyHRvn7O8wXwMJkRgfuwLmjPZMAILiGVAycHBd5BMhM=;
 b=sz2OeWcNEqD1d2BFp1hZtD46nEoIK8Qiuq9phsVPnNs2bxbp6vuGByOaKdq+xgwBpnDhWCkA+9nF20sFVzaOm0HyRRZMZ1btO5OkFdfFbBHE6YlHKoMKB4sNdqe0y8bCVBz02oXcjo3UG2LTvYhv2ZNEjNLwRAlm0x7+21Fykm1+6yJKS+2wfgAt3IgUTIOV6mfF5z3OoF7qdaPw7Lflhr1iOqeHq9qSkJAOzIIC0w1HuNf5I+/weO+Mi//oV3x18N/S+QQStONAKzklbLnkICoGUQATAPgmgu9/GsvdAAko84GdUNFgynGrWl0CBETYmGbpJ3nbhcMWdfJrk5TpXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyHRvn7O8wXwMJkRgfuwLmjPZMAILiGVAycHBd5BMhM=;
 b=fBol+8tSUfgDoZ4PeP81c3yV2zPH6SPtxFfFItqa4B0/JURw9/TFyvaL4Huimf9GngvFmrzXfRuDbaprhdQ4q+5sjAZT3uc4Z9CMOFhRAUwzL5WYBUwb4hFH5ZRjthgZdtevAGzy/8xK0tw8ZgwMxE4tX24dOeowo9arECRRJQDcs1QRoHeis3CuCLTvdD0MFpNS2o5DH/QAykzJjpNfOSbVymbpVAgdp0y0OaTgGOlKcPaaH+Zqqe6HHu3ZkyKACl6JifcBMiLNSUOHbg/tB+Brp91IdvVj/Wb1JhinprSliTsX8p/jYpAIfn+1XOGpI1kHOgIVmKfTHjxmDOEIgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 BY5PR12MB4084.namprd12.prod.outlook.com (2603:10b6:a03:205::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 21:38:37 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 21:38:37 +0000
Message-ID: <c2cf35f6-7dfa-4186-acef-deab9a6f1b3c@nvidia.com>
Date: Thu, 13 Aug 2026 14:38:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
To: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>,
 Yury Norov <ynorov@nvidia.com>
Cc: Eliot Courtney <ecourtney@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org,
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
 <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
 <DKO48OG9DU2S.16YBDI113DR4@garyguo.net>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DKO48OG9DU2S.16YBDI113DR4@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::29) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|BY5PR12MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f55e8e-bbf4-4550-5a00-08def9833bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|56012099006|10067099003|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 4nY5wbfR8A6EEdbbIsLuGrEXuRgCA7LL7zx/63/L/eyHyi6P9+UaUXy4OYI+gIF08feCYyRRMeDvST/kWyxg4HumBsGTTYDwVNWCkWXVnj6eDn80Ja32eEeF5CI8TzWL6IHfdqg6B6l+OOgGjD8rGZ5Rk6cDwNIZY9LuSbrR8JBkzCX3D7Pt0D84OmQKXKd+OixCNirs9BFcO9a2GKjJSR6pZVf3+EqR+lB1jReQW8ysnCOk/RN75L18ap4JfWcDeHM/7QYwligYjLcM0WwKJTP0xmHQ2lcwwZ9H31ZIpDZ+g+/uZdEWJwwMiI/wVRacaSj0wEsXVKKDA+ulPoDBvcsQVb2oQARdorVlL1LGeGqiZrQhOLk1d02sqM48TosV1XMvTsXh5430Aa6mGc4Sqwjk1wAr6gV3nbZaDhoUV5Gul6R+7onRKWQcCoVrSPKR58f2FqYziF7eEnu0ocK5eIej3o4sl3kf1EoJdvJv+fgyWtVQeiwewg/G2RriSvah6v4LGQMDL8dvYC7Uyf1yN4BQaNmLtijwAbU1thfnkSptWgAQ0dmWCvs+8K35RikyXu7NPImfBYbl/0ezT63KzH+GYJFmdqkZBNyvrJZRs7GWdGapHPl/z5NNsa4J7eSn5cO43pLjD7MW5x1db51zOSgyEceoqjlSG82vMwQdfNg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(56012099006)(10067099003)(4143699003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHBsbFdHa3dUbno1UXQ5Qm85SDlMNU10VWRaUXRaR0toQmFNZ1IwMFB0OTEr?=
 =?utf-8?B?d3R5VW5mZWVTU0NiT0M5Um0yTGxzeUZoTTFlR3pmL1FRNmRwOWlsa2JKY09C?=
 =?utf-8?B?aGYvT2hWbnNCQytFazZ3bmtRa0tpUmxBa3p5S2RuaEdrK2JLM3F5RUtVVHNE?=
 =?utf-8?B?ZkNvODNYZjgxSTlGdW9aV2JSN3h3eUs3dXFOT2YxbkhnWVV0S2JqNnVxY3lI?=
 =?utf-8?B?aWt4M2E5OWQ0b1pPTzc1YU9KZ2lWTGQ3RnNaZmwxTHM4ZkM3WEN2Rml4aWdU?=
 =?utf-8?B?dEZvWHpqTlJjbmcwdjdCS0NGaHpjZnpianQ4VGdXeWhtdDJtTm52K3N1UGFN?=
 =?utf-8?B?MWlSclF2cUZjbUpmSVUzYWM1WlFhU1BIL0QyMFNmQWlqd21XL2VNbXYwSFpU?=
 =?utf-8?B?ajhlcFAvbkhMZEFEZmprVmZQN0xiYklqNlVFV2wrYnZxbE1IK0pZMWQxRldG?=
 =?utf-8?B?Tms2OHBnbW5IWFJIM2VWeERGdGE2bjNhdWFuRzFhcEF2RUo0NjhjcWczWk1X?=
 =?utf-8?B?NkZZZUZQQlRWYVdNZFBJSVJCUVdzak13OVlUNGlwQXpZYm9yNVh1Y0JzUzV4?=
 =?utf-8?B?NS9CLzc4MzBPRDBHazFPMlp1TGtVMW9kM2xvNHRyRStOczUzME56UkZYb2pJ?=
 =?utf-8?B?c1EreXJBM2dRQTlyOWd1d3JBWjA1Tno3ckMvOEFFUFNYL0FzdXdRb1FNRGFY?=
 =?utf-8?B?SVNpSTN3cURnUDVZcjA0NXhhbElNSVdrM0IwR3lpUmJkeHNjcmF0YXA3UzB3?=
 =?utf-8?B?U0hLTjN3TWdQQ0x1Vmhtdm5FTzllb3FKa3FqZWYvMXZVZ2Iwb0hURWFnNlZp?=
 =?utf-8?B?WjkxREYwUTVoNStGOS9TakNKd05XekwzWVRNM0pMbFJkbyt2cGM2NGp1bkdh?=
 =?utf-8?B?aGg5ZzNjVTJlUFNNcFQzM2lXSDhOM2RiWjN5ZHllQVNqT2tLVy8ya0QvQlcx?=
 =?utf-8?B?d2I1WTlkNy9SdTZkWDJ1UDE2cTRnZ1hWdlFlWUlLZkgwL2NxMmZtVTMwaGNK?=
 =?utf-8?B?V2hucTJRdVhkVStCU29hWnNTUXB0YTNqc0NjTU8wOFFZenY4VGlwSytmeW94?=
 =?utf-8?B?OS9YazhtYmtKNGFRTFV4YmE4Zi8xWjZrLzZ1VHJaM2FsYmJjaDVRQ2pSRVgz?=
 =?utf-8?B?SWcrYnNSVm5FbWIwRTUxQUw3alB4SHVMUnk5U3V6SDkxTXozUm5CL0QyOWR6?=
 =?utf-8?B?Y05yVjgvN1pwQWJoeVhXWW1OZ2hnK3BRUXBJT0RtTkZnQWd0OEdVWDd4ZUw4?=
 =?utf-8?B?VzZCZmw3RGxuVnB2a1JhaVprbGpGRkFkQVdPS2xGUmhmQjUzQ2lXZm5PeEpF?=
 =?utf-8?B?VUZmcTlrRjV5RjVnb2FxaGxvY3VvRDZJVGFUeG1PWU0ydkxvWHh1cG41Wlo3?=
 =?utf-8?B?SDdGOWRuQUZCWktabjZ4MXJsQ2JweGIwclhEa0ZQSGFKVlJZVmtIZDBFZUl5?=
 =?utf-8?B?eDBGektiSU8vRTBsR0FPalNWbDltcklCWVlGYUxYcHVwZEdRUXl5aitCWGN0?=
 =?utf-8?B?T05DZHM3MW5TV2p0V3Q4elFaWmlXK0Y0SWZjaSt4d2hpVkthVFZZQkZkcTBT?=
 =?utf-8?B?Q1FrWE9RWFJEVTJlYzdRNHZGT1JiN0lwRDVGUGZ4QjZ0UmVzR0dEU2t6UVp0?=
 =?utf-8?B?Z0xXRnFWUTVLUEhGWk5FTXhzd04wMVowcEpSMk1nSE9VSWFQRm5qUml0VVV0?=
 =?utf-8?B?RzVJZVgwa1cxQU85K251bFgvajQrREoyMXRKV1JXdU51YTFVMkwxLzBkbEtC?=
 =?utf-8?B?b0QrQnlaZDI1MWR1NkY1WTlZbDFRZ1VlWGoxVFBZdlpHZ04yVUJEZmYyWmFu?=
 =?utf-8?B?MVVKUW1XalFldWNZSytjc2tUS0VHeGQ3T282bDVaQXBWZjA4aTRlQ2FsWVJV?=
 =?utf-8?B?UTEybUU4TG5vZENqQUd2QVpPaTdFTHVnOGZQM2FsMVJCd1cwYURhd2IxQkJi?=
 =?utf-8?B?WWczcFQ0MjMyZy9ONlZ2OUpYQ3Q3ZHNjVG9mQ3BudjZYZGRxakVFTUFOMWIw?=
 =?utf-8?B?VE50emQ4eGMrWVNJanNoV1ZMRlhTWHNZRnN4TjFuaW5BOXhxbWQ0SGQ4QkJn?=
 =?utf-8?B?TjV0UWgvQUkvZGdnL05XV010c25zSUNWdm52eXpPZExLU2x4bXRzTi9EUVZt?=
 =?utf-8?B?cGJ0RVhONVZzeVNXS00xR0s3eUoxcDNVbUlpRFIrNzhucmNNQVFWUGZFdWFx?=
 =?utf-8?B?SEhHTmpCVEFRYVlpdmVreENDckUrSkZrbStSRjgydTdoYjdtTnRVNTBNWjZM?=
 =?utf-8?B?Nm9KbXFmQnRxZU9sKzZ2bXRIdk53S0NxRmd4V2hXSUdNbmkyVFQ1c3FETVVD?=
 =?utf-8?B?dDg4MmVuRzNSUmFKSjVjbUR6Kzh1Ly8zZTZDRjArUUFyYUttNW15QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f55e8e-bbf4-4550-5a00-08def9833bbe
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 21:38:37.3401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1VsxcOyXtuB5+YSLtdiIQZ/W6BQBh0XbswFYcDbHF/WBdkcjP5ead6Yy5UfIcxA6dD+6GHimwpcIPwL2tVfulw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4084
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

On 8/13/26 1:58 PM, Gary Guo wrote:
> On Thu Aug 13, 2026 at 9:48 PM BST, Danilo Krummrich wrote:
>> On Thu Aug 13, 2026 at 8:32 PM CEST, Yury Norov wrote:
...
>> The code from Eliot does actually already takes advantage of this. In
>>
>> 	pool.alloc_area(nz::<8>(), Alignment::new::<8>())?;
> 
> I have to say this looks quite ugly, compared to just `.alloc_area(8, 8)`. In
> this case I'd go with something aesthetically better...

In addition to aesthetics, a practical concern is that there is a
higher cognitive load to both reading and writing the longer form,
above. Perhaps that is just the price one must pay.

However, for primitive types, I am hearing (even from Miguel) that
there might be a way to get the static checking *and* an easier
interface.

Here's hoping you all can find a way to do that. :)
> 
> While keeping invariants with types is generally good, for primitives I'm never
> a big fan of `NonZero` and `Bounded`... The turbofishes are just ugly and they
> are must harder to use compared to raw primitives without typing a lot of
> symbols.

 
thanks,
-- 
John Hubbard

