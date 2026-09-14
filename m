Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC54C88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 12:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FFFF10EE0C;
	Mon, 14 Sep 2026 12:12:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="OM5/UjO5";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011036.outbound.protection.outlook.com [52.101.62.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57CEE10EE0C;
 Mon, 14 Sep 2026 12:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPfP6WXvdfsMSBw5lhZrqk34bjKrxR6cCrW77EzmVguvV4EieY/EwdAJwSq6ykeUeHuNmePl18/VQk6jEIJ6keeMBJ2zyJJoxba0XUPMzofYXBrL2hbRmd2WwwI3opxoDt0j+MYvhEaI44+40jsSfIsary6hYwdYFGi25pLRIuSfkGx3L80xjqW32Gt78PIt9clIYlC3Y/ZfN6Q/6E2Is7Kuw41rhaRpPKt8s8lXdTflCv+afY4sDZph+sJI7BfqmNkr9LaEcW4vVTKeY+jpn1bLmXyg39P4JfZXAc4TeLXIa3IYSW2P8kf+0AW4gfsOtW3bO+I8CmCZPo9BrQSJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZdbtIwtstO2Nn3Z+fCqvDqjEUXd04Xolwa9jwGPKp4=;
 b=poYnPi2wIzIDmxmTiqo3KzIagRY7kOyg/Dqww1yG4ab6eNTWtn3VUnp5ABNqoPVobVLx56NXkOugF2Co1Fq9/+tkjtrIPiPlPcsv9uC+vWaAIYGHwpx+bwr6svnSy0L3XBZIgN0NiDXSv3htWjLoJ8ysSwCoXwbZlg6mVU+MgG3z2TJxmxsAuFry5w/YoFGy7kh1fiQhUC/aIxzu1zrpbmZr3vaGLCcNcTFQNg+sLfHFn6gPvkY8jjJuOEnLLa9xNkUMGoYsCkX+PDiWxRjsu+rEH8Y5AmXfXTykGXR3f1ScSlvUgZutvgfKw7GuY249JroKeVWDTZT6M2n6aMe6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZdbtIwtstO2Nn3Z+fCqvDqjEUXd04Xolwa9jwGPKp4=;
 b=OM5/UjO51UkezJ5JoNyFPKOUZXkknyTgSkprzFr6H/VqM//E54bL62FhXa50nKe5NxH+DvkQqzOVMhjDwY1Te/B5Vy57cMQoTtS/vnJ/1nxUE1QwH1oUFGuWb7AtRqGFHVAsUV8mG+xB6YWEEHtRl7xgpbWMwBXSY5dG4Hyhv22qjA0sR/D75Wz2wXX/RjSihS9B/cPYVmBaDFUQAVPEqi54NjbcdY5XPImiOEmvJiHPr4fw5BTnCfsno2+jZiicMhj6pfVgZWmu/dMosMNnR0b5YYTwrI7daBBgxEvjQSigVJ2Cu/rP7BQLbs/lGUtscAUC5ZVoEvnVDv/01Iz79g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH8PR12MB594730.namprd12.prod.outlook.com (2603:10b6:610:32e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Mon, 14 Sep
 2026 12:12:07 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 12:12:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 21:12:03 +0900
Message-Id: <DLF12VXN7OUS.1KHT1G0SSR6FW@nvidia.com>
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
Subject: Re: [PATCH v2 8/8] gpu: nova-core: add NVKV GSP_INIT schemas
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-8-0de9d5c8658c@nvidia.com>
 <DLEQV27IDBCH.16D7K7DXI5ZK8@nvidia.com>
 <DLESSF3W6AV9.3GZGHANXDQJVM@nvidia.com>
In-Reply-To: <DLESSF3W6AV9.3GZGHANXDQJVM@nvidia.com>
X-ClientProxiedBy: TP0P295CA0011.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH8PR12MB594730:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ebec1d-eec1-408f-a3e7-08df1259655a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|376014|23010399003|18002099003|22082099003|3023799007|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: eCoEbxqdmqivFh0PJR97NRt6pz0Cbu4VHydRr2/k1Z1CLFBUimdFdIQp8D/9KPWDftaZAevc/+C1i4wnn3iX1n/c79Dva05fjPa/jEMuR7ck/xUwELFRrOuWUgu/l817ihX6dHUB+u7UYNzKT5X4pVzyCerGP+oJty/JKgnjXScAmwebvYIA/wyYJoj31b7naJZU5/+bW5ONtvIFCcMEVPCGdXQ78TzDLeA/azAiME+ibu03/0zUi5Pq5r6uhu3oUnuXIhm2fwMCVmz9//omsEdzwmCFd0piSGCPaDiaqgLEExFCF2+d8450Qm824z5rx7Gjwxa62z6qhYtC+qv+q/z1JV1h5lEBOneW0AJd+r9oFyrrrMwWYSw96prlo8+wvH0Z1KJ5EeCWS7q4J9h6Ja3zViuS2qTsrUEJqVib0JA6Plnub89kD/nqebBFId7WTvysnLwlJe/4AXJI6okV02IP5RkLhKnqlXzmsCAXtyXaIQY1f+jEmS68jyvMOE4DZ6N5fcLplOgSPXQyhAe/Vgd2seYT0OWAcTsnU0R1sZR0NuDYyZ0SgUe6lKVC40+wuxSCjFkOHp684ciCABP8mS+7gaCRdnsZuknd8iLPdyrrU7/aYbhK/VGAipqYHaT4ky9AId1C55kkVsZ/d410qfK5FCv8I87eBD0V3s+aPa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(18002099003)(22082099003)(3023799007)(4143699003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHFoUnVYV2N3L0VGTDdheWhsR1R3SHoyVkxWTTFTNi93Q1Q4TzFkVXlUanFB?=
 =?utf-8?B?b1pmciticDJzRFQ5TkpxK2Y0d3lrQ1ZudTNveFhhYVhNajg3OTRRWkVIRlNB?=
 =?utf-8?B?UzdCdFpiY2taMjV5dmhTY0d4UWNsQ0ZLdHc0R28vdkNFeGZuK0JYNVFHcjdN?=
 =?utf-8?B?UHV6cUFXYmV2UWxsS0VZVmd6ZjNhNmpETVdHOUJBaUJ1T2h3eWIxK1dweG1Z?=
 =?utf-8?B?RCszV05xbU81ZHF0Zm9vZGJQNWR5dGVJa0x1K0tPSldFNVZWQTF5RVZ3TFN5?=
 =?utf-8?B?Qkh1OHNBYklaOWRhdk43b29YMWo3K0kvcE5WMEhtMkdIN0U5K3dzWVNoTnA1?=
 =?utf-8?B?bHkwVXp4RXBzbHFpcm40dFZnRTJkS2Y1TXd1a2I3dmZrTlVleXV1TC9nQ25m?=
 =?utf-8?B?Q1d1L1hJaGNHSGVTYldyM1NwTndPbUFLdmR2VjNyRXFJcU9KUDd0ZDQ4NU9R?=
 =?utf-8?B?TVUzZDVUREZXUjg4OWZja1dBMHpWVmtFcjV1Z1k2SmZqUzZlTXJJYlBnTEVo?=
 =?utf-8?B?UWp0TXdqbDBtaW9pZDZlbmtENUN4RlAxUXVyVGVjUlVXdERKSUxHS2E0QU1D?=
 =?utf-8?B?ek5Ta0xOVW1QakQwbDNzcjN2MkZNZ3lDVnEzL1ZmRDljbjhXdHdVOTZEdjVE?=
 =?utf-8?B?MjNhckZBTGQrMURJMzFCRkl6NnpJTnU4MjIwazQ2dmdXc3pKbVpwWlBYSEFQ?=
 =?utf-8?B?eWFxaW9hMWkzTDZ0RVRpRTM2N3poY05RdndoSTN4N0tOS2dmT014RkxQNi9o?=
 =?utf-8?B?Umlzc0d4VDZEU2lsdHAvcHdhMkdieEpKS1Q2aWxCbXF2SDZEUkdhNFJIdmxw?=
 =?utf-8?B?VythRG0xWnd4eXhWMTBVSTM4U3d5WjlQaWtBUnJ4bXRZK0UzanJveHNlaWxq?=
 =?utf-8?B?T2NEWmxTQ0hMZW90VUV1U1NsUElCK0V2NFQyNCs2Z0ZOT3NDUVkvdzRBcVdV?=
 =?utf-8?B?S1BYcVJXSkk0MkZPZG1BRS9NN01LbTQ5U2cxV29SODJpcUxvbTNKbDUvU3dJ?=
 =?utf-8?B?eHRJcHRYbVgyazRGQmV5T0JJaFozMWVkVzFrUTU0akVqR0x5YWkwWWxIY1JW?=
 =?utf-8?B?djArWDgxdXE5NThLOCtINGIwOG8xZ1FMcUxzdnYycFRrZi9TaDNKQ21TVHVi?=
 =?utf-8?B?R1B6ZjIraVNscHJIU0c0bmtMaEk4cTVTZGFFbjlWVmttRjRFSjRNRXNaUGFO?=
 =?utf-8?B?ZFB1WW5SZE9oZ0MzeWFXWHhISHgya2lESWpDUlZuRFNBZ2c4TzlBbkx0Q3RN?=
 =?utf-8?B?emM5L29NOWNaNnQ2VHNFTHc2VFE2eWNqU0xIR2R3bnJJWW9tSG0vUjk4RWp2?=
 =?utf-8?B?dWhJZnVZcDlkYythZ0JBM2xVakI0NFAyeEYybk9ERUI1VllkQ0lqd21pYlQy?=
 =?utf-8?B?blc2NGtOVHU2ZVFEMy9MU3RINzNJSll6cVBlbVpOS1NUNmJldW9waHBqemE3?=
 =?utf-8?B?bU0reXVrdHZlRmxRdEg4ci82bTRmOFR1bk00OTI1Q1BycWs4S0V5TmsvanpN?=
 =?utf-8?B?RTdGZ1dGK1Z4QUh5eDJuVVFWZCtZYjNScjBhOVRiWXhxUXBUMTlTZWxBWG43?=
 =?utf-8?B?dnErbWNkYThKZ255aSsra0hNSWJoOC9VUDRTYndGcURwdW5yUzhZTzlsK1d0?=
 =?utf-8?B?S1UzTkdQMGtUYjE3WVExZFVoeWZ4NWEzVEcxWHp1aVBZUGt2ZGJLNnYxZmNB?=
 =?utf-8?B?dmZvaGZWcEl0L2tvL3U1NDRsbll4b2FTdVY0a2N1eEkyWEpsZTlqLy8xNjRS?=
 =?utf-8?B?V0p0VGlTQTQrbjRPSU1FS2NxUVRtVXZlZGdnMm0zWVh3NHduM0I2NHlTOFBV?=
 =?utf-8?B?aEd0Z2pDbTZPeUlYOHd2RnRYRjR1NzJqdTU0bWFlM0FndzNIcVJ5RmNtNjdp?=
 =?utf-8?B?TTFTTUlGSnpRL0tDWjVQOXhkcGVwNjhVaEVFRWJpdzU4ZTJCc2RnY3FSek00?=
 =?utf-8?B?a2oyRGlNQlFQc0MwQklEQW9ocnZOdU1BOHZYVGR1Y09DSHAwbFNBSnVqeDdT?=
 =?utf-8?B?THdNUmR4YWZuOXZsdUsxSXFOejloSGJBYzEwSytVTzU2STVZRVR2RzJkc0VT?=
 =?utf-8?B?SjlpU3B6eTdEYnlrS280ZzRhcG1CNklRdURXeEpac3F3T2pqdEQ1WGpMMmky?=
 =?utf-8?B?ZDJpTENaeFhNckxESmswYUIzc3A5clVvVDhDdUJBUkxYZG1VdW5kMXRYMVFG?=
 =?utf-8?B?WTB1dVZ6bDNwNUdZcUJPWDlLWkJ5S3lwa2lTZ1oya0lBZkt2MHhIMDhpZ3F0?=
 =?utf-8?B?aWwxOXpKVEdkdzdMRnlCWm5IMEpHckFEeGlDYkZrWWhRSVFBVXA4TEZ4OHVT?=
 =?utf-8?B?a1J4T0gzQUl3a2FUd1h5UllGOXgya21QUllRVmczWFIxN252VUZOZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ebec1d-eec1-408f-a3e7-08df1259655a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 12:12:07.4737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcQzICoX9DRf9XRyU+WAGD5s7oIjltyw9klgYIVBKf95ZafnpXXJOijGqUxf2sFld0YYRBKYK2hrT2Zn7IKs9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB594730
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

On Mon Sep 14, 2026 at 2:42 PM JST, Eliot Courtney wrote:
> On Mon Sep 14, 2026 at 1:11 PM JST, Alexandre Courbot wrote:
>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>> <...>
>>> +impl RegKey {
>>> +    // Define the Key IDs read/written by GSP.
>>> +    const REGKEY_NAME_KEY: KeyId =3D 0x3070;
>>> +    const REGKEY_VALUE_U32_KEY: KeyId =3D 0x3071;
>>> +}
>>> +
>>> +impl Encodable for KVVec<RegKey> {
>>> +    fn encode(&self, encoder: &mut Encoder) -> Result {
>>> +        for regkey in self {
>>> +            regkey.encode(encoder)?;
>>> +        }
>>> +        Ok(())
>>
>> Maybe this is just me misunderstanding, but how are the keys
>> sequentially sent here? Because I don't see any mention of an index, and
>> `Key::encode` hardcodes `Index::new::<0>()`, so how are these supposed
>> to be decoded into an array? The `gsp_init_request` test below only adds
>> one key to its `regkeys`, can we add at least another one to see what
>> happens and verify that the received content decodes as expected on top
>> of checking its length?
>
> You are not misunderstanding, it's just a bit odd. This is because
> sequential regkeys are all sent using an index of 0, according to the
> protocol. I can add a second regkey into the test to demonstrate this.
> We currently don't and won't soon have a need to decode this kind of
> repeated index 0 encoding scheme. We have `Accumualted` now, but that
> relies on the index changing to know when the previous value has been
> completely sent.
>
> To test that the content decodes we'd need to add either a test only
> Schema for it, or add a schema that isn't (and won't be soon be) used.
> Alternatively, we can test against the encoded byte content directly.
> Which do you prefer?

Whichever you think is adequate. :) As long as we test things our
current code allows us to express.

Although since the NVKV protocol is specified, I think we'll want to
confirm the fitness of our implementation for the entirety of it, even
the parts we are not yet using in practice. In that case I suppose it is
acceptable to have a Schema that is only used in the tests for the sake
of completeness (even if that means having a temporary
`#[expect(dead_code]`, as long as the reason is documented).
