Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C962C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 624CA10E76C;
	Mon, 17 Aug 2026 11:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q4L2etyI";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013009.outbound.protection.outlook.com
 [40.93.196.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FAF10E76C;
 Mon, 17 Aug 2026 11:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/+LMVQxstGwMOyFup4S7R+Jph4W0PxCwCc9wjRRwnfUEgJH1zWyr+gRd7tV1iqb2yF6Wm9e0MFxSRjst6S1Nm7L/4mG/EWtavMFBHw3D4jM4z+OTcgyhXTURqedrzhghAs/sxb0JO4nkqsW1q0t2V/RiMt1wIistlAJmAOxlAIgGnwNnqgMx9EmBG9skpn1GR7UbxRu8KDaoBF9NV/W9EaJJCNXjDr5QKCIiiEuwzfW/AnjpwTFN8URxjHUtgZJPoaqKFfmcCx1udqVGLVzRpseOL0HKyfmtoGEhYlQRwMpvC35f/8ykzMhowQfImBXuEw9nVl9ZVg0Z+b7vIMUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rK1Q3lykl/mGfPDQp+4JYJq2Pu9CKEiSqaBGiv6zBo=;
 b=sKN9b5df9/TVPzmYmGUOGoyPPxXqnzm4ztK1i86yQ1twxj/PAQQJ3dZl52Fl1nBKGptupF85jyxP+OFiQQgoHA1hCz2o+Z9r+/g+ckVL9KdSMrf6fqSjh14tLf/o8wyzqE2c8h/WCjCSoyrRxm4g5H2UQCSFZ/HHWRzdI5usjogoV6UeQUTRodbBrK4Pkfi+5YZUokhBPHSCZ8Wi8geFbv94pXrIcfkcLhaTcDJLs2LGIOPtHGq2ghoEmNcY+W9oO0ZrX3JJOSo2soScmCctKJAnnt2F8dJJonYubeD/LAkHQmydAvWov+XqmU0p3PWR+WbIvSqRid+lMlSwUPDr6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rK1Q3lykl/mGfPDQp+4JYJq2Pu9CKEiSqaBGiv6zBo=;
 b=Q4L2etyIVTo40hzwGvxjg4BFCl77U6KTzx94mloN72RjZCc+nERZaQPwDcK4pF2h82K2NgPnizUtob2dHa9kb6FKXKnfQzWCLz343I1AtwfQOp+ekvd8zLApARjgveZlvUVLj80J0wooulGtF+9iGuFORjzDeyZU97rVf8hgcqYVeIzZ6PrQJBB9AzHmCdTDa7xQf6aJTNLZPgplp9cPUfZUDK9u6BAteSYRpTbPRChOMLB4m/r4vJBIN6DMnbhhqh5fjI/giH9ZMfitctA9xfKQ/iOks9HWDD9NBpBJDvVu3oiV936T5eLef6x0TthWKZUVAFOpHIFYYOs8y9JZtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SJ5PPFF6E64BC2C.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::9aa) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 11:49:18 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 11:49:18 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 20:49:12 +0900
Message-Id: <DKR724N9V3Z8.1HJP6NJC5A4ZK@nvidia.com>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Yury Norov"
 <ynorov@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
 <DKO414SNC0B2.248FUBGJGSPLU@kernel.org> <an4xDp29VX8Am0uR@yury>
 <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
 <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury> <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
 <DKR5W5DGAWAJ.38LHLLNPO9R4W@garyguo.net>
 <DKR6EB8OWPXG.2QYAY81UG1RF3@kernel.org>
In-Reply-To: <DKR6EB8OWPXG.2QYAY81UG1RF3@kernel.org>
X-ClientProxiedBy: DB8PR06CA0064.eurprd06.prod.outlook.com
 (2603:10a6:10:120::38) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SJ5PPFF6E64BC2C:EE_
X-MS-Office365-Filtering-Correlation-Id: aba040ac-e002-439c-415f-08defc5591b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|10070799003|366016|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 85xcJFEKKTXtB60qddeYyHkTQN3Qcgqu44yXiQZK8gBQr1wjUnoyFOwshDkXJRSBlrIi1NDK8y5bOij3D0/29xuyI/OkLVchMllUNcrWELKjeM/+eO7HGmE9cHJXV44K8BSHvckV5DF5xCxGjBSbEW1RZVxYfaak23G0cFnG77gUPaKD9CaxVvv9cRsUzTuypWigJSYcEkrf5evxGJRInrUNEuP9Wpxh6oKbkR1bjeRjMSg42ETYeDqzfXgmnR1cm1I1BcW8dk7eQCJ6yVBW9OXloUit/n4+oiNTAjUZIqLl0GVaNuQjyOIFE8mnJZftXePuOgrM7nWrH1QLvpS7NfT8lFGC/Uddq9NLIUSBODksLorPMzUngR7jq+kwO+m52Ri0NPlLHz9dgSmQuOKiGZPvf7aWlQI+sTmzHlIcdTaqI5igZ8SHVU2+zVP1pwTBPb8kkVuVS8dLW9iXaQJKgF6O/tOVCU7JuNIP7ePgy3CrUFfPEIsAmLsIGhKprUybp9+MDbPhFnYMSHvwY3ACbjVS0ViinfV2zJc0QRrjoPSDU6L03DshlvTU1dGS2dO/mSkZyPayi2/4c016hcf5Rzii2VXEZqxECJDZfuICUBlV1xDxJQwWAF622b5ufppIqtKEfCN8yeGRR9zbg6hc62OmHcGfJkvU+fpfaTuHduk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(10070799003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHY1SWZTRWNqdllFSW5Lc0txaDZnTXE3cTJlWDJaeDMvenhieVNKNk9JMXpx?=
 =?utf-8?B?MjZkNmRhQzk0S25ickxOTWRIYTdUUGVzQVJCYVdTVm1FeFU1alBRM2o2V2xM?=
 =?utf-8?B?RXRxSklWTmFHRjJNSWdpR3BPamRzZThrSWxDSG8zM042SHNLNXEyRnpiT3lZ?=
 =?utf-8?B?TlUvSTlKeTVCN1p3TEFWSWhIVVpJZFNvRGJ1OWlWTGVuaWhnTWY5UzFhNklU?=
 =?utf-8?B?QlhXbkN2bkZ1ejJlYmk3UUdPMXJSY1prL2VacENlS3Q1bGJjazJjMVBoSWNV?=
 =?utf-8?B?SG1BQUtXaWUrM21icWVUM25pLzBQVzdyaHpaV1hubVNwb3hEaSt1cTlDTVZY?=
 =?utf-8?B?ZkJZNzRvMzhrdlJSYmg4ejBseWFheXNaODdRRXJwKzAxSFVzNUVYRUhnbVlW?=
 =?utf-8?B?VlByd0xEWmlMQ2w5R3lId3c1L0dpaC9qcTdhQi9tbi90OXhoNUFVaG8yclRV?=
 =?utf-8?B?Ny9xVE9YcGoybWh4Q3MyYThTNzVCNFh4cE5XWlZxTmhxN1A5dVZ4dEg4dksw?=
 =?utf-8?B?SW9EcHp6NytKd0I0MTlGLzlWTTJwU3VyQTMydVAzZmNpbHJVQmR4bmxFNEFm?=
 =?utf-8?B?WTYvc29qbGRhYTdWUEFzQ0s3SEV6b0Q4R1NWdTQyb05pSTYzL3lrNVFQb1RM?=
 =?utf-8?B?ejJvOU9MYjNuMmxJQTE2ZmllZXpUMGVuQThFL1FtNGNlYVBoL1RWY25zUEFC?=
 =?utf-8?B?RWN6UmphKzQ3L3pYN3pmZFF1SVViS05lWjd4dG9uODVoM21UamJ6eHI5TFp0?=
 =?utf-8?B?eXd0RTlIZTRoTC83ZnppeW92em5hWExnZDhnR0ZZb2RiL3RvM1NTODZCUzBn?=
 =?utf-8?B?OHd5ZEwrZjV4LzdROTZ0WWt3YmlqMlBLNnBqK25yWnJqNmhPcWFuVTYyWFBx?=
 =?utf-8?B?TVZ3TmFESTUxRkJnMStKc09oY2dYWUx4eWEzblVmS01OWWY0ZUZhSE0vQVEy?=
 =?utf-8?B?cU1pWG5YSmRZVVlLalQrRDlIWGw0Q1EvVFpZZmF6eWdVckVESjZHd09ScENN?=
 =?utf-8?B?a3ZHdThsa00yUVQxUm1PR0ZPVU5aWGpaK2kzODBHaVRzZDFoWDBJK3ZiUmpk?=
 =?utf-8?B?SHYwV0doY1hURzExb3hZanhiZHpqbll0enN1dXhkZS9JUUsrc1VKTFlxeE8r?=
 =?utf-8?B?TDdsMzk2RW5wWGNNTW1FUG9oWXBiTGtMN2NpMHJWcWkwUEc4UzJpdWs2eGlS?=
 =?utf-8?B?WFdRMmk0ZGVtemk5QW8zK1RWUmxBcUE5d2dUK2VtaDhkTnpoR3RkakZOQXRN?=
 =?utf-8?B?OEs3MkNubFVUMWtCYklBNCtZR2NFVnMrbFhHMDRwR2diWWJKdFlHOXdRTENJ?=
 =?utf-8?B?MHR5a2hVTDE3eWVuaWNyUDUvaDF2eU5GVFlWc2pXRkVxK0kzWGIwa0hLV2xI?=
 =?utf-8?B?Wk1yMXFwNU13cTJ2WjVZTEx5WHZLcFFNYmExUlJQalVPdndRdWIwa3B2cCs5?=
 =?utf-8?B?V0ViWHd0NFdmQ0k0NzRYKzdMQVlFMy80UmJpUU5uaHJDRkNlSUtEcWZPRVBQ?=
 =?utf-8?B?NnUrYUlJZW10aDJhYnF2Y3Y1RjBjbzN6MGxHMkZRNDlKZlphd1dVVTRFU1B4?=
 =?utf-8?B?VWZnM3ZRR3Ztay9VUTMyUkhYWDE3YkM0NHFKTFVLeExRbWw5UCtKMU5teTF0?=
 =?utf-8?B?S0JNZ1NoUHlmSUo5NEtvSERTRGwrQU1tRHplZGlLVEhUYzZ6QnFQek1zMmFy?=
 =?utf-8?B?OUl3Z00vaFZuUll4R2FrVUtMa3dIdktQQ0tVWlRXSUJpN3hlZERCbnRETjcw?=
 =?utf-8?B?SFdWWld2bFpubzZmZ3FuWTZRRzhEWUsramZUZ2hCVUdra2V2UlZaSDM0bTkr?=
 =?utf-8?B?RFREaGlSK2tRR0Nha2dpaUhiU2g4d2E3aE0yQ0VEQTVpd1h3SzZPKzliQ1lB?=
 =?utf-8?B?dmsvck91YVF3Qm1oL0ZHc2FzczZ2M3NPaFZ2bEhtSWdsODJKeDYwM28wY0VR?=
 =?utf-8?B?ZjEydjhtRENzU1U1RXh1Q2JNSklmVE5yZ2FtZ1NUcHBwdXhkTHYzZUJaTHcw?=
 =?utf-8?B?YXg1UGN5bnFUK2RzRXY1VmFlWGJCaXZCSTlvb3J6KzdRYzdYSlRhSE1nMHRn?=
 =?utf-8?B?d3IxUGFxQ0ozSWY1VHlOUitpSC9TYkhYenhPTG5yWmoxZHEwSDEwS3lGbW1S?=
 =?utf-8?B?VU9LNXFNVkIzZjI2VnFkVEpnQU5MRXdWZnBHb3RTS3QwZ3ZSRnA4alRma3BR?=
 =?utf-8?B?VHVpWUhxVG1DTHlOQ2RKSE9KWU9BR2VqRGt1cDZsd283YjFLS3FKdUZzakJa?=
 =?utf-8?B?d0ZtTnFLbjVjSXp1WnEvQ2JBUEZlSkZUM0RJVmQ2dFYrSVFQS283MWt5Mms3?=
 =?utf-8?B?WGVCa1k3K1Jmak1pTHdQam5FSnlmWFVoZERLY2haS0svVm5Eb2xrUkx4SGIv?=
 =?utf-8?Q?8r48gn9rfhCc1pOKtSSSN/IeiAzcXWnHHnjFReRNk8fT4?=
X-MS-Exchange-AntiSpam-MessageData-1: mhvvQwiBw8JAWA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba040ac-e002-439c-415f-08defc5591b6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 11:49:18.2132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mTmTzW6+6vlNgVg13iD+AeuWphk3kejdQNlRx9uZAJ2nsW/X+rcXuu08CUf1OgyVH4u2PiABR/dx/LNvNY4bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF6E64BC2C
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

On Mon Aug 17, 2026 at 8:18 PM JST, Danilo Krummrich wrote:
> On Mon Aug 17, 2026 at 12:54 PM CEST, Gary Guo wrote:
>> IMO we can just support zero-sized allocation by always succeeding, simi=
lar to
>> how ZST allocation is handled in memory allocation.
>
> Probably, but in contrast to ZST allocations it wouldn't be very useful, =
so we'd
> silently succeed on something that never was a reasonable argument in the=
 first
> palce.

Yeah I agree that supporting a generalised zero sized alloc is in some
ways conceptually nicer, but I also can't see any good reason why you
would want to do it, it sounds like a bug. That's also why in the latest
version I made IdPool also not allow a zero capacity [1] (incidentally
required to not have to change the grow code to avoid trying to double a
zero capacity thing every time).

Tbh, I feel that NonZero (and Alignment) is hard to use currently
because of these ergonomics issues. But I reckon they're useful, so I
like the idea of trying to making them easier to use. Maybe you can make
an argument to not use NonZero here, but what about all the other times
we will want to use it?

[1]: https://lore.kernel.org/all/20260817-chid-v7-6-a5872e64d8f4@nvidia.com=
/
