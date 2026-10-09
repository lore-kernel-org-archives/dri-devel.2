Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAE5FCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:46:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CC710FEC6;
	Fri,  9 Oct 2026 06:46:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PCf/3yop";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010053.outbound.protection.outlook.com
 [52.101.193.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52AA010FEC6;
 Fri,  9 Oct 2026 06:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIc54TfrY41ON3i/g5XKdFvS1AVBYclnfdQ0mxAtdAZLdYg+j9qnzM8dosSUpRO+L4rR1b3GDCqxPvDzNuSyat2M4R/AZ35U6fRWd3AARFi7DySJTgkrLoRVG38iWqFBc3LbrsFz6J3ACvDVdm8yGZJttmUVIfs6YFDxBmj+VO2N45Kr1qaVOULOKeoyjvvay7/8DS5f/oLY+zgUIVsh13r4/ON8HvU9VPMvtprLrGJpUp9FSb8qsmg7HRAsddArtK7D93B338WlcWuzwBcnjw1Jl2AUmfx0lvrLT64Hu+QLvRbiXftrjRBQEox+qnKOPG7zxhJ6I+XFXjocqJN/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/RcB4L+iCLocDO6I+wTC/z8jKjKB0p/8Zq753KvvU4=;
 b=tK9v5/Hku1M9LafyXBgiqNImChNjai9Y2AMT/lcXsWQjBie9Ustz7kFvnDGz65EkfJQKlXYvfYTly9shrBDuQv2VoWUMPf0w+ka9IAFw+46/8rQs0S98FG8WtAsUsjsQ+v2HEsfl/4HAfCLpm4wtYleS1zS0yq8nHXrZn8F+QGzkFlihvyXUGAPm/ujjfQtsLGSpRLEreOMswbT+NEbH2eF9tBqnIkBovu1Bezn4dnDUqgpRxkJwNuy6dkILFpI5pECBop/wQRdtxd8E6DmxvvlvcLTA0PfvKJGr7E8HxTotnUIsEvCSIWBMF2xBPynRHiliARm/tdkYvvj0YS0RwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/RcB4L+iCLocDO6I+wTC/z8jKjKB0p/8Zq753KvvU4=;
 b=PCf/3yopIDr8Nvgrg+pqQp77HHHW0hWPDp36PEUTrFSrrrTQ/mV6oVEmPcB3fXbeVdo/1i0qipXveKvmKC3m6MffccmUZNjfLaEqXrBUpR3UmllDICCVOaQL0HrLj6zLQdNAh0FqSSmIGjN8ZeAR9v2WBBU0jpiH4UGJ2axEQV7WY7njx2XBZ77dVEX5pv1ildawYyJzOeA+PtGDAogjymke5mLfMecfcoSloViYsMzB5Hnws1DSynzffc3gIE/otyG8Kcw9HdTi4XlQWvOiPNZpE7FJY0fdFNl7ahwVutEnaQMh9/rpO4vYjiP7uQ22i7y+Fy5Op96HWhWLAMo6Qw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 06:46:22 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 06:46:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 15:46:18 +0900
Message-Id: <DM03T324DC0F.2VZT6WIAHM0VI@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 7/9] gpu: nova-core: gsp: cmdq: move the RPC code
 into a sub-module
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
 <20260930-cmdq-rpc-v3-7-91613f06520b@nvidia.com>
 <DLT8T5HQDV6N.30T90TO3IDNKM@nvidia.com>
 <DLZY4W2CTZGL.3K38U20U8KLLF@nvidia.com>
In-Reply-To: <DLZY4W2CTZGL.3K38U20U8KLLF@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: f9461ef0-bf0d-4a3d-00a0-08df25d10737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|376014|7416014|366016|1800799024|4143699003|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: aMXHGYBTlOV1EVSyK+7uhnHNF5JeCmHSpM+VW8IY8eIfdUK1h5wv5mXE8NYCetbhxU6G+ZR/padeVcjHCoXxcJ5nD2IsrcaNPDxAcTj83QOAO8IpCunWxgOlJxgq4MpU0aQRmy1C5MOKp6lZ78D+XlTchli/1bYg/CePV9MeaAf/rxqXrqJqhELoD6dEv7qFe2OQawMZWzlvZ/hlkgZTMAmjdesiA/1s80ncWcW6XWejZqy1PtzlpTg8lFxbjMFe6FIDVKHm7FXqoQlIdO7jXMapJqQuyHXXP78FHxeyzZPSBieGxtnbXib5OKufqY8Qf6qb8z5aGnNd/LQF2UhjvqYQdQ+6zThZZQn2uSm9UpUB6lsaCnRHZfUccEWD8ozdS7hcfsWQx54tjiqb/6I7jCan58F9S2nFn29T9sz/CFFsvoMIpfOffUVxfBeyZq+x968I0s2qYbh7nkCARZ6hrWPC4VORmIq6tmnHw88IzHtqXdWRgvFQ+demSSYHNd9GKymrZdUlUjhPaZyD/s6NHksnKtcN3kf5zhiAYDsogsofDroJVt+VDRQaJV0qwzph2tTNV6f37dJ7aKovj8lbPHx0kdvV6FLMMVZppBweyk4edmA52ydGtQnj4plBU8ObrELTDe4D01SyNylvfZXLDjF6hU57DDAgmjlFNmCswwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(376014)(7416014)(366016)(1800799024)(4143699003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QStZUXloTWFqbHhSanArUjFCTXRoNWtkTDNMVDVQZ3hDUkxjTFFKdEJqYTBy?=
 =?utf-8?B?ZXQvRG54cU1qUERUM2NiN3RmYlJ4Y09XREZSTnNXcUR5VkhPdFVZekYwaTNQ?=
 =?utf-8?B?djNBc1Z3SzlaYUZZRGpHRlpnK2FjTUwzVVBWU2JMdTR6MGRwTGhEdldxd253?=
 =?utf-8?B?dEFRYVNxZmsvSkNxa205V2toV2Z0R1VuUjVLODN6SEMwOFJOVEM1aFArbiti?=
 =?utf-8?B?VWRRQklZNEo0U0NqVGYwdkljUE1peE14QTVSWmJOZHF0Y2xxQWdZU3h0TnAy?=
 =?utf-8?B?TjRITG4wTVJwNVJNKzUzaXBYcE1XQTQwOFFIcjJnS3FoSjZvOVF2V3c3WGs2?=
 =?utf-8?B?Q3lQcWIwb1grMFdDSlBmZU0zdGtXYUpiUnF1WkZSa2VyRy8ydVhtNE0xYUR5?=
 =?utf-8?B?U3k2SHZpN1hvMlV4L3NNdWJ5MVB0ZzlVV2xxQVgzTm9FaHRRTUxWZkNvQ0x6?=
 =?utf-8?B?SnoxNUZ3MVQ2ekhWRjVvSkt2a3hyQjZKNnQ3M3cyRVJiYTNENU96WXM0YUdW?=
 =?utf-8?B?dXZtdXR3NDBCNHF1NnVjQUU3TDAvNGNYMFRoNk81UnM2aGEydlRncmpLelc1?=
 =?utf-8?B?b0JMWHA4Q3hqbDlzVFE5TDhmWGx5Q3NibWZTN2VKakVudnlXbmlOTnBKN2po?=
 =?utf-8?B?Vm5RTUlqdFp2dkdoSk56M2tNdmpGa2lUUHF1Vkg1SjhaZ09od0lubVhPMDk0?=
 =?utf-8?B?bkd6cHZIOVlzSFVEQll2d0xlL25kdGZuVG1yL0VSODB4WjhDODhmZ05DemFF?=
 =?utf-8?B?dmI2bHkrUVVhN0s4U3ZsQUJDcjVwT0VqekhVaUo5czNhVWp2ckExcTRJRG5k?=
 =?utf-8?B?RUU4ME5SbW16V2hvVVozbG5YSmttT25saUQ1S1VSampiRWx5SU85WkQxUGFC?=
 =?utf-8?B?NHg4NURFVGVWcHBDeWllVk1FMWU3a2VVWWF3SmUycnhOTjkvOTlkeWZDMjBu?=
 =?utf-8?B?cmVTdUV2K0tKUjhiTGRsdTVyZ1BXaXU2L3RHLzlDNG9FTjY0NmJ1Mm93bDla?=
 =?utf-8?B?RFUrb1lseFRlWjgveE9rcW1rVVpjUUt5SUNSYUd5bldxVmxPY3A3N1JleDRx?=
 =?utf-8?B?cWwvUjJOQ0JCeWcyVk5MOVZPVjlyYVZpR1hDWnBtTGV6S0lLaU5MOVRiVWpn?=
 =?utf-8?B?Zjkwem5VUzhkay9VZ2NtNjdRcWxpd3hQSWlYR0VjVDJLUGpaaHNTak9FRUxZ?=
 =?utf-8?B?V1gvdjMzZGdnWmtxQkJJejROQ25Ja3Y4WW1XdmN1MjdzNnQyamtaRmVZYmp6?=
 =?utf-8?B?cTAwaEg3N0VJaHk5eVF0N3ZnVmxRTS91RHFYeExjTnZMMmRrVVZ3NzZkcVgx?=
 =?utf-8?B?YWExRnBKQjh1Wms3RkJ4QmR0bXVkMllBUGFNQkxKWWplVGd5aXZzd1FBZ1k3?=
 =?utf-8?B?ODFHUU9vbnFqNFJTZTRYTFhLaDk4aHVzcmV1L2Y0d3JtcWlpbmNIRTFUMVhX?=
 =?utf-8?B?bGoxV0FKSElnazgwOTNMeXBoV0lmVkRya3NOUnB5cGZxUWNrUXFwd3JqN2pr?=
 =?utf-8?B?dFBBTWZUYzZpZTNYUk95Z09Wd2RlNjlRN2puVjQrZk4wakg5WjlDZXNadkg0?=
 =?utf-8?B?d0llZkVYSERtQlh2VjlsTzY0QU5WRDNxVDJJSzNKZEZKSmRVeFk5a3M0dEdq?=
 =?utf-8?B?eUFPb1ZtclpxUzNjdzJUeFZFZGg0WG1URHltaTZEdThtL3lBYjBmUjRJcS9r?=
 =?utf-8?B?eG9YeGsxME1rdTFiQllORWVUdEVRNWhVVUNXYjBtU3hSUGw4TllPZVV6VU1H?=
 =?utf-8?B?VGFnalhJVTRISk5Dbkk1bWV1TjBMYW5sNXUvaVh4NjFZWkh1VXZkRDNCa2l1?=
 =?utf-8?B?bk5YandweUFFMnhmTFNmcDhoc1BTVGplWjYzSUtsSlNJZGo3TlNwblQ3OVNK?=
 =?utf-8?B?anVPUVEvbEk2dVVEc09Ddkdya3dsd0FrM09qWXlVL2xGci9kc04xS0J6SVFw?=
 =?utf-8?B?R2tXQkpqNmErMkhIRlNLbVBJbVYxTTFENEQrSkxkUFRNSG9JdUhsT2lhWlh3?=
 =?utf-8?B?VnJWRDlhMGVtdUwxRFpoSm9GMk9Oc0FzM2I2L1pmSzdpN2FoSG9pTkxsT3pi?=
 =?utf-8?B?TktOQjNYTEZncDFhTm82SkJHR2s4NjRxSXMyUGhSWkh4UE9RT0lIM1daSnBi?=
 =?utf-8?B?MExlWVZDOHNGdU1SMU9rL01VUFhnK2crK3lEaEgrKzN3eXlBQmViR3UwWndX?=
 =?utf-8?B?ZitoazNmSmN3YUpuOFk0V1pTenFXb2JkOXlIK3AveEI3c21Cek02b1BnVWp0?=
 =?utf-8?B?RDVDN2NhcUhnQk96UVRneHVOQy8wazJKdFA3NHdLOUpqZWtVL1pzZjVuUzZ6?=
 =?utf-8?B?NmkvbHlIc0d6ZWJicjVJWFBaTlR4aGN3TjRBRmh3Nk5uWkg0anNjOFdUdTk4?=
 =?utf-8?Q?FtVIttvnqzqEJoE3md4heYkuwt8u7M6d8ajkKW8XaApxu?=
X-MS-Exchange-AntiSpam-MessageData-1: iWV1a95GT+sYSA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9461ef0-bf0d-4a3d-00a0-08df25d10737
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 06:46:21.0671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wY3BER2H9BfbpgHe+AYGBzgak2/jnj5gKUmCdfD3N937SW+yLCsYeHj4ih6shZff8ft3GaAb0Nw21yTUjLncqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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

On Fri Oct 9, 2026 at 11:19 AM JST, Alexandre Courbot wrote:
> On Thu Oct 1, 2026 at 2:12 PM JST, Eliot Courtney wrote:
>> On Wed Sep 30, 2026 at 11:55 PM JST, Alexandre Courbot wrote:
>>> Move the types and code related to sending and receiving RPC commands
>>> and messages into the `rpc` sub-module. The methods are still declared
>>> as members of `CmdqInner` and `Cmdq`; only they are now in their own
>>> sub-module.
>>>
>>> This is a pure move commit, with no functional change intended.
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/gsp/cmdq.rs                  | 343 +------------=
------
>>>  drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 380 +++++++++++++=
++++++++
>>>  .../nova-core/gsp/cmdq/{ =3D> rpc}/continuation.rs   |   0
>>>  drivers/gpu/nova-core/gsp/commands.rs              |   6 +-
>>>  drivers/gpu/nova-core/gsp/sequencer.rs             |   4 +-
>>>  5 files changed, 388 insertions(+), 345 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/=
gsp/cmdq.rs
>>> index 07036972dbec..06386d1ab192 100644
>>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>>> @@ -1,6 +1,7 @@
>>>  // SPDX-License-Identifier: GPL-2.0
>>> +// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION =
& AFFILIATES. All rights reserved.
>>> =20
>>> -mod continuation;
>>> +pub(crate) mod rpc;
>>
>> Should this be pub(super)?
>
> This cannot be unfortunately, as commands (which are in a sibling module
> of `cmdq`) are protocol-dependent and need to view `CommandToGsp` and
> `MessageFromGsp`.

Err sorry, my reply was completely wrong - `pub(super)` here means
visibility in all sub-modules of `gsp`, which is exactly what we need.
Sorry for the noise, and I'll fix.
