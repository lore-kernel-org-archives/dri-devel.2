Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF2EC982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 859B110EE23;
	Thu, 17 Sep 2026 11:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="lBjGyDwC";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011026.outbound.protection.outlook.com
 [40.93.194.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB98610EE23;
 Thu, 17 Sep 2026 11:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxn3K2UpsQ+dDgFeDVs6OHk08zt/gNOydgkpIfLcAa+0AHhzvh+737d/A81p5YSRuIcibjmshboosBnun2Y6aC/p9hz0yXXa3LR9UNU/jurnvyUDcOKdxkrx5p1oWOlCSHpHHWIO+lKM5kXzjYKFiBdQsf0E4CAxnzGAsYzN2OpKCTW4ZU/9RKyCEAsGh9veIyuB68PhjfstpGRrmrcfDivRiXOVGtFDmVrFYhqrztfWclIVJKU70JSn29o+28Oj3Ss4bD8/0/0ix5wt2JjT4iJ93vLCB85Q1fv24Yh/bS0KyLcx3QKfsk2dkjcyV90VQ24R1KWum7ZPFbr9j+qp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuenNrnlVkNBGHeXc6GXaQVy/5kMClE2H3lql5Htim0=;
 b=Vujooz7bUZpkFYxKKIgi5JVYBZpEh3ni9/0hvnNPelDo6x6bxsNahQ9h7CenX1K9Tld4PIvTngwgWHJQNl4ry7UuX+AH6Ippp//qiq8wAU7kOlMlELT8eO+26TOJhB0Dtbtns3fMDfSKQE3FB1WEVRSrli+SCqCdp6JL67FYtjTXTWkcuiAcxAlSPRBtIO5rN9X7hy1/ykIgw7OrTpdTUHcfj3MJJ/OcO/MfAwMUj+DhHDnQb5edvaBsVbMNxX2hjkCVhZ3QLaK4uI9i2DyYQYyXzcxYhKxj6luw6Sbx6uFx++q8PExp0EyQFAnfcUsqAXGat4tDiF7+cIK9Kb+1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LuenNrnlVkNBGHeXc6GXaQVy/5kMClE2H3lql5Htim0=;
 b=lBjGyDwCsAQobc1YrpDG1fXtATlRCR3gjKy6yLcDmfoeMU/IbQh7OJbypgpEIf3r4kbSAFVouZ6FFxFgU76a9Sl3bR48h5h/TCTz84mfHWK5RyssFYd5ycH7mjsuJettShk3AzgleJ9bUmtAcscV/sQKsEP/Kx1Czvl7g/iQgBRBg2ilHIK1tGjIh/FPACPv403tQ0UV4MK0HPooZi59rbPHn0qGago7kn7rg7CHYQZyEygMj+OCNBSutZg0t/00peioqUCE+AuzhfqfrSWSVBlZaWNX94DHqjnZSFUC9zipohVOIkgdAFpkpImNkPnU8zE22A4FbT0RrUOmVUwbjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DM4PR12MB6088.namprd12.prod.outlook.com (2603:10b6:8:af::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.13; Thu, 17 Sep 2026 11:42:11 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 11:42:11 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 20:42:07 +0900
Message-Id: <DLHKBLIVFIX8.346WFGAIJBL9D@nvidia.com>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
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
Subject: Re: [PATCH v2 7/8] gpu: nova-core: add NVKV typed decoding
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Alexandre Courbot" <acourbot@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-7-0de9d5c8658c@nvidia.com>
 <DLEQBIQ50C39.23F0YZK9D7VUD@nvidia.com>
 <DLEUCB80B7ZP.BW7O43IISMQR@nvidia.com>
 <DLHFGW1ISL53.3D3X360WD8HPV@garyguo.net>
 <DLHGE0SNY9CO.1OPWR5QXKJLAZ@nvidia.com>
 <DLHGPFAO0A8J.TU9XW1AZ8XAK@garyguo.net>
In-Reply-To: <DLHGPFAO0A8J.TU9XW1AZ8XAK@garyguo.net>
X-ClientProxiedBy: TYCP301CA0020.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::13) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DM4PR12MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: d533a4f7-d98a-4b2f-fe8f-08df14b0b5df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|23010399003|1800799024|7416014|376014|10067099003|56012099006|3023799007|10063799003|22082099003|11063799006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: Y8Bbd8b8lGqFMgiCZzOxINHrHcFg+IJ7GvYObtqsQA0mJnbCzOXkQk3fBeWNQagZ/o/suzZZjFi7qg6EWPGpeVkr6/d9DAAOlJdezHW09S+mubeckFwMe6I5AfqT7tMPLTz+d54EdQK89N9gMnzeebePh4NXcYWVFMwsiE52pB6gUglJiGPT5e0urepb5pmyf4nvAZcvkSbQzx3jHKfpufLe+V3ePuIU+3sir6xQIKnUy3L1BmK2o7eINFFDWDOcxlbeP99fvXtESDLMOGYIVdS2Y+3CGGqoLlgj5kF1KJ93kqg3BDUNw9ZcI+N6u/Y040KnTtV3JtET/6gjR/g/ASjbwTbjymJgf1TN3dbHAUaJr9unXIOhM4K3KRreEQmnKxGU4obZtCg5BBi9czbS8swG7ogKDCYmtEhNtSQMI0aA8UM3+hjHkvr+qBxj2xtSQ9SF54xZoAtZq6yrrFh0HZzWCqqkZKljQNDT70NFVOVRklWlzPDXJNpFXPFHOD0cADkMU++RM0KZfmFyrhhWMLIft2Fc1Px1TLLjXOjwDyqYPfINmbs/4pTsKWlGPhA59zJhU9oIi0sU54W/gAwlxcXu1TRdzMNcNOd6472KWDLUDQisPL+H/7kbhCdCjTD7SgEP8SdRRP41FrG6J0MGJCLr9YBURpTdYi/TtbxO7zQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(23010399003)(1800799024)(7416014)(376014)(10067099003)(56012099006)(3023799007)(10063799003)(22082099003)(11063799006)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2Nsc1VFVHFNb2FEOGxXSjZmY0tEblBWZlhQa3ZiYndBSXB6SDN6VmY5aENp?=
 =?utf-8?B?Z1NacjhhQ2xjSlNYZUNNWFh3aE1aSW5FWU1OZlNUQnFhVkVYTy9uZzVWRE8z?=
 =?utf-8?B?UTR3SXZEenNBYXBhQ1Q2Szg5QWJPWkxUSHVuajMyNmVMR2h6allMSGkvckhS?=
 =?utf-8?B?WjdzMjkyQXJyRDJWYnoyTG5oaEJqeFBZMU94ODdlR0VCK1JsTkNsUUMrTjh0?=
 =?utf-8?B?VVF4VnJnTERXd3J3TnVsblRQdHlpa001QlFjWEtGb3FLQjJQMDYwRFlVVDBq?=
 =?utf-8?B?enNGYWVTYkhHaVNoOEhnMEVTd1V1ajh6bWkzV0RFbzNpbityZFdudWRFK1dJ?=
 =?utf-8?B?SmU2R0M0N0pZM3B6SktRcFhaT1NqRlY1TDZmVnJiWG84eE5oVTgvNllXOGtD?=
 =?utf-8?B?VFNPQlQySVl1YlR0QXFGVWVwaTdGakU3RHVoSEtRbm5KZVJnOWp5TFU4bisy?=
 =?utf-8?B?bC9hSnVpeldndndOVFV6Tk9GYVd2OE02and2dmg1YnR5bWJXVGMvNWoyU3NE?=
 =?utf-8?B?MUVVYlNWNWtuVDJ4cHpsZ0daSlArVTZaZXN6WUFhd1RDa3BtQ0Z2YzYwVDVw?=
 =?utf-8?B?K2dLellYbUZnMTJFKzAxN0VRczIxMGhad1hIUTZlazd5ZGdCb2ltcHg2bDJL?=
 =?utf-8?B?Y0M2eHRmRC9zZm1LNFEvUjZLb0hXeCtJK2wvVmFkWHBydkRmRzR2NlVzNnRB?=
 =?utf-8?B?OWlPdUJzRXYzY3Uxd3Z4ejZIVURCalpQYS9LMCtKeTdDd1hNQlkxbnpQMkd6?=
 =?utf-8?B?YjJPQVBMYkhTYnduODlnRmp2elJtMklrUkRBMFNPNFVJY2JsbGdQYjlsc2Z4?=
 =?utf-8?B?T0s4R1hPTjZwUHVNUWs4WU0wd1lSY1RLbk9oNURMSE9QQlM2enUwaTdJUUdF?=
 =?utf-8?B?TDBzaGVKR2lqMTFGa3A1ODJib3Q2d0UxRVlYeC9BNEp4VFVJaXR0cThvNWI2?=
 =?utf-8?B?ejdhUGkyM0dTcEo4aWJ2bjdZcjVwNWx0VjdUM1NGNG13aklkQ0F5WitPeEpN?=
 =?utf-8?B?c1pmVTI0ZkFIeTdLV3N0ZE5pODR6dDNFOTZqRDJNdkNNcjIrRjlNMldHaVVK?=
 =?utf-8?B?c0JtOWdSWmVEcUlSdHpyTTRaeUtHYVdRRXJBbGlMUktRKy9DUzRiV0Y0eEVt?=
 =?utf-8?B?MDljdFZWSUVDZVVidVVkdGIyK2Z1eHl6V0tINytJK2NaYWxRR2EzdHQraXRU?=
 =?utf-8?B?RzMzVHByY09WREdTM2Q5bTBHbkIxUlNJbENHdUcydXNlMEdFT2cyRWtJc3B4?=
 =?utf-8?B?Qys1ZHJwdGRORFJRdWFqT2hmV2lZaTZsTll2MVYweGpKR1VvSk1rQlYzeTM5?=
 =?utf-8?B?MFI5THNRb2Y2ZmM1d1AvRWlYazNkU0cwOEJmeVZDSHBOOXpzVS9LZ1dBUWJF?=
 =?utf-8?B?YUVDRVpzd21sOXFCYTRleUxnamtESU9JZ2ttMUZGVi9wLzVmVkExMWc4Vkc0?=
 =?utf-8?B?TnJOV2xCb3B4MjNuaDhaM2tqLzZHNkIrbW5kY1NTMUlVbkV3MTl1V0ZadkFB?=
 =?utf-8?B?a0dQaml0ZFpobm9YVE1SeVp5bFhPSTVyQUUvS2pVOFBiRG9NZlVrY0hEeXVX?=
 =?utf-8?B?M2syY1FQaHdBNEtPTkhUa0cxQXNaOHd3V0RtTDBnbGNPamc3cC9RZ1JXMnhu?=
 =?utf-8?B?V0dUdFdrQkZPTlliNFhMTG11SXcvZGlUY0xnOXVETnJ2Tm5ROExhcW1PRHNk?=
 =?utf-8?B?cmtEekt4UzJ6dllyZDRXZ1RjS2puRXNFblVqUmJQSjIwaEp0WkpBZ29qbU52?=
 =?utf-8?B?Uk5WaDdNcGJxbjBQR0N4bkFLR3ZYLzc4WE9jQzRpN08rR2hXYlVtRnV1Ujl5?=
 =?utf-8?B?Q1IrZHhqZDZwaHFzUGI0RmdkYUo1TWNwME9LU3JnTjBnMW82Tm41TXBvSnZB?=
 =?utf-8?B?WnV0OE5zU3o5UGc4N0NXem92TDYzdEMvTFV4UXFucktKenZZazg2WnBFazNl?=
 =?utf-8?B?VE9Qa2Z5ZnVuQkpCaEZQNTRRSGQ5N25kbzhHRUhpdEdQTzZWL0k0U1JCSTR6?=
 =?utf-8?B?ZXNOQ2FQM1hmcUVwREQ1TUtQa1lTcFhkVlFrWXQvWmRXZlFCMVMvZU1jVnBT?=
 =?utf-8?B?MnFNeEJJeUJSOVB6UktKYi9nR3R4MWxmN0dkRXdaUkNMYkt6K1RRV05uU3E3?=
 =?utf-8?B?eld5aHZnYlR2Y3dWekgydm8xNDJOejBDdUI4YXZ1UGFJc0RSUVUwcEl4MVNx?=
 =?utf-8?B?M0lqQTV0bEVHWHh2M05HWi9lNEtSRjd0NytyL0RXV2hZaTdRb1Bzd1llNDY0?=
 =?utf-8?B?ZVFBV1ZxV2tKNlVaU3lQNEVDeDdEM2FIZDBNN1VSdkpTQ3BkeHMydjhSK0x2?=
 =?utf-8?B?OUVzbUc5VGptaGVWRXBUUlVFcGF6YWg5dEVlNDhVV1JlVjRtOVQvei9iRjR2?=
 =?utf-8?Q?OfcK8n2jo9pq71gRGHHmzKNRv8xK0u6sou+91ojaLayD9?=
X-MS-Exchange-AntiSpam-MessageData-1: 6i4IlDmghvznyQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d533a4f7-d98a-4b2f-fe8f-08df14b0b5df
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 11:42:10.9917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GfuqYVndhjP2PHa2drseAeWxkdjnWsHO659VBfeGFp19V9X2UA9NoD+XdlzieFkSP1JN0CC2BC4yrqPQbBqiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6088
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

On Thu Sep 17, 2026 at 5:52 PM JST, Gary Guo wrote:
> On Thu Sep 17, 2026 at 9:37 AM BST, Alexandre Courbot wrote:
>> On Thu Sep 17, 2026 at 8:53 AM BST, Gary Guo wrote:
>>> On Mon Sep 14, 2026 at 7:55 AM BST, Eliot Courtney wrote:
>>>> On Mon Sep 14, 2026 at 12:46 PM JST, Alexandre Courbot wrote:
>>>>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>>>>>>  use crate::gsp::nvkv::{
>>>>>> +    Array,
>>>>>>      Index,
>>>>>> +    Key,
>>>>>>      KeyId,
>>>>>>      Op,
>>>>>>      Opcode, //
>>>>>>  };
>>>>>>  use crate::num;
>>>>>> =20
>>>>>> +/// Defines a schema struct together with its [`Schema`] implementa=
tion that decodes into `$target`.
>>>>>> +///
>>>>>> +/// Each member of the struct should implement `Schema`. For every =
(key, index, value) triple
>>>>>> +/// decoded from the NVKV stream, the generated parent `Schema` imp=
lementation will call each member
>>>>>> +/// in declaration order with that triple. If a member consumes tha=
t triple, it will stop there.
>>>>>> +/// Otherwise it will keep going until all members are tried.
>>>>>> +///
>>>>>> +/// The schema struct holds the state required by the schema implem=
entation to do the decode. It's
>>>>>> +/// recommended to use one of the existing Schema kinds (`Required`=
, `Accumulated`, `Key`, `Array`,
>>>>>> +/// `Indexed`) for each member.
>>>>>> +///
>>>>>> +/// # Examples
>>>>>> +///
>>>>>> +/// ```
>>>>>> +/// nvkv_decode! {
>>>>>> +///     struct RequestSchema =3D> Request {
>>>>>> +///         id: Required<u32, 0x0001>,
>>>>>> +///         name: Array<u8, 64, 0x0002>,
>>>>>> +///     }
>>>>>> +/// }
>>>>>> +/// ```
>>>>>> +macro_rules! nvkv_decode {
>>>>>> +    (
>>>>>> +        $(#[$attr:meta])*
>>>>>> +        $vis:vis struct $name:ident =3D> $target:ident {
>>>>>> +            $(
>>>>>> +                $(#[$field_attr:meta])*
>>>>>> +                $field_vis:vis $field:ident : $ty:ty
>>>>>> +            ),* $(,)?
>>>>>> +        }
>>>>>> +    ) =3D> {
>>>>>> +        $(#[$attr])*
>>>>>> +        $vis struct $name {
>>>>>> +            $(
>>>>>> +                $(#[$field_attr])*
>>>>>> +                $field_vis $field: $ty,
>>>>>> +            )*
>>>>>> +        }
>>>>>> +
>>>>>> +        impl $crate::gsp::nvkv::Schema for $name {
>>>>>> +            type Target =3D $target;
>>>>>> +
>>>>>> +            fn init() -> impl ::kernel::prelude::Init<Self> {
>>>>>> +                ::pin_init::init!(Self {
>>>>>> +                    $( $field <- <$ty as $crate::gsp::nvkv::Schema>=
::init(), )*
>>>>>> +                })
>>>>>> +            }
>>>>>> +
>>>>>> +            fn visit(
>>>>>> +                &mut self,
>>>>>> +                key: $crate::gsp::nvkv::KeyId,
>>>>>> +                index: $crate::gsp::nvkv::Index,
>>>>>> +                value: $crate::gsp::nvkv::DecoderValue<'_>,
>>>>>> +            ) -> ::kernel::error::Result<bool> {
>>>>>> +                Ok(false
>>>>>> +                    $( || $crate::gsp::nvkv::Schema::visit(&mut sel=
f.$field, key, index, value)? )*)
>>>>>
>>>>> Mmm looks like this is going to be `O(n)` with `n` being the number o=
f
>>>>> fields?
>>>>>
>>>>> This is ok for a first implementation but eventually I hope we can
>>>>> switch to a more efficient dispatch.
>>>>
>>>> I thought quite a bit about this while writing this code, since we nee=
d
>>>> the escape hatch to imperative decode (custom Schema impl basically). =
To
>>>> be able to get it down to a match on the key, we need to know ahead of
>>>> time which keys a Schema will consume. That duplicates the info from t=
he
>>>> visit() implementation.
>>>>
>>>> I thought up a few methods but it's unclear to me which one is best, s=
o
>>>> I just left it for now. Please LMK if you think this is urgent, I can
>>>> try in a follow up to improve this. Here are my ideas (when I say O(1)
>>>> lookup I mean modulo how the compiler decides to do it with the set of
>>>> key IDs it gets):
>>>>
>>>> 1. current code - just visit()
>>>> pros: key source of truth not duplicates
>>>> cons: O(field) visit as you say
>>>>
>>>> 2. Associated const KEY_ID: Option<KeyId> - None if a Schema accepts m=
ultiple keys.
>>>> You can match on each associated const in the macro.
>>>> pros: O(1) if the current key goes to a field with KEY_ID =3D Some(...=
)
>>>> cons: O(#fields accepting multiple keys) if current key is one of them
>>>>
>>>> 3. fn accepts() -> bool
>>>> You can match on `if F::accepts(key)` for each field. We could potenti=
ally make
>>>> this const with Gary's const traits polyfill.
>>>> pros: O(1) if you write an inline-able+optimizable implementation.
>>>>
>>>> 4. Associated const KEYS table; use tricks to concat tables
>>>> pros: O(1) lookup=20
>>>> cons: actually MSRV can't get this to optimize down to O(1)=20
>>>>   if you use slice::contains(), but stable can.
>>>
>>> Hmm, am I missing the obvious? Why not generate a `match` expression on=
 IDs of
>>> fields? It looks like in the example all keys would have a known ID to =
the
>>> macro.
>>
>> Some keys may come from embedded structs, which the macro has no way to
>> see.
>
> You can match all keys that you can see, and delegate to embedded structs=
 if
> keys are not known.
>
> This is essentially the same pattern that `#[serde(flatten)]` uses, just
> replacing identifier names with keys.
>
> The keys don't need be part of the type system, and it just additional me=
tadata
> for the macro to generate correct impl.
>
> Best,
> Gary

This sounds approximately equivalent to the option #2 I mentioned
(w.r.t. delegating if the keys are not known).

I considered a serde-like approach where the metadata is annotated for
the macro rather than by the type system, but I wanted to keep the macro
simple and not introduce more macro-DSL than I need to. And also keep it
kinda easy to write manual Schemas by not keeping the deserialization
info in macro metadata.
