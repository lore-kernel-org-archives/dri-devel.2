Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECEDC982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6045610F396;
	Fri, 18 Sep 2026 13:56:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IRWO/95J";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011044.outbound.protection.outlook.com
 [40.93.194.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9015110F3A1;
 Fri, 18 Sep 2026 13:56:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGwf0XOuvxUuKqkl+gZNm0R1aPaf2mqSuucjV8MFqss1J7y1hM3BfTTVBb4NgjMgguQZIa5il3h7vMhqjtEWy+rBQyBCLbRY6BuIjgZtFlMTFZo9/FTMOE+SIvXehrz5FPfgwkXMhDaavJLZKu/SdiuOq9cGj3HRfhSbr4pZXi/6O8T5rI3botoJz7MGFa06JZf+AL3FwFMvSO9tBnlAElVb64cUB7z4i/X+LqaXWaGEdHLeSJzR5TPGgkqkZnLAIkMvb6wnDhca/+j/oX9Z9KRRnF/FbcvbWsgedtwIBegfVkffa2nVZL/YrjPpWmzMiGHapsr7XJhMobSHvZoeXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdjnL+U2Lo42Wjt+hqHqkjkhU6b5rIrdXN4dxdB0+LQ=;
 b=XjPhcZks97gJlsclwleIKGbET+4oRtMHaXJA1Indj4V2Tw0KXrpjDKaZIWF2OGFOQlzJ792ulOq1QfuCwHSZPzXQjIj+aEpOO9w+7Ckt0Ia3bSLQTquXcb+xdAeKjFimzoYDPyrdFDEe+/2bTU9ivhgVXUA0OC9ahEatY40+gRYFPo75HG/ExF7zeRYpEe3CLQlqP8F4N1T0btEs4Y2n5OfIHCARpNRIOmO2E5HRFFR4rx/6lqGQjH84u+/S9rsTfnCR0zlOxstGch6xBqWpAP+20s8xehQox5LgXNYi6RP7kNskS4D4TFq5ysYyFraubOH3EHA+GHtqFJDz2F1g0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdjnL+U2Lo42Wjt+hqHqkjkhU6b5rIrdXN4dxdB0+LQ=;
 b=IRWO/95JObFP3Zw4MPEasxA44SrCOQ7xtFJDuLuMfjbPQc/deIeHMLT15X5Gzdhx8esJ2wUXbfvdre+bUSPtuMXc4agFe5VbJS/QEWFfSdpf8F+OsLcpLszaoE/LoySJSJVgPhZ1KY3yplPj5LkM481laWTuuWwd4f0QVKp/tdtE3uye+JLWB95tBYxR39JXngs8XjRTwBMQpzlAJXQVolaSbfqmyyMqGt8iZPA0K12EbetGtyw2jJkWwAmH1V6lyIYV8UMqxRTwVsriBzvTV+3+9zR9JX3Zm+m+fi85Rr2HZNl1hrbxyJ7NkmiAqP1Io07Kzws7Yu23Jj3B+4SSgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS4PR12MB033229.namprd12.prod.outlook.com (2603:10b6:8:50c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 13:55:57 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 13:55:57 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 22:55:54 +0900
Message-Id: <DLIHSKKUVP7V.153Z4TTEYFL3Y@nvidia.com>
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
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260827-b4-nvkv-v2-0-0de9d5c8658c@nvidia.com>
 <20260827-b4-nvkv-v2-8-0de9d5c8658c@nvidia.com>
 <DLEQV27IDBCH.16D7K7DXI5ZK8@nvidia.com>
 <DLESSF3W6AV9.3GZGHANXDQJVM@nvidia.com>
 <DLF12VXN7OUS.1KHT1G0SSR6FW@nvidia.com>
In-Reply-To: <DLF12VXN7OUS.1KHT1G0SSR6FW@nvidia.com>
X-ClientProxiedBy: TY6P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::8) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS4PR12MB033229:EE_
X-MS-Office365-Filtering-Correlation-Id: d96fc489-7eb8-4af6-95e3-08df158c9071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|22082099003|18002099003|4143699003|3023799007|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: IIHASQNc0V1ZyD8YgWY8dIg3Sb9TkySOdKJVfL6vmXwPgg0eOuv2oAhX18o/lfI290Fum2t4Sz1KVnJsVhRb1QoihecGGS3jAy1oTYdedgFzVla2hBoktYNmTQamuZdIvKb/ghoa++8ty1nrmDPHDXJoElmNCTi226Wxjr4hCPsI06q/AFMRVnrM7Z3MjwOo4SH2KYsk/ucXW3NruQ+T4zbSsuUU0SJ09IzTYDs/Z+A1queU6He1fpL5SrqbV8klTGdP3zDae4FgECL8Ka8ntz7RAzSkyGUb5IxjzSPKx96Ttoubs2OFzV0qarRxdC2rxGIVwNYFhA8JJEgoj4/su2zCrBNRAcD6CroykSwO3rmv4neY9eJfKRutS3a4Z3lI/x6tDq2cSe+QZK+oHa7lqG5RsBjkGVeksJXY8i/Wqi991n/LUJ91CCINCVnPUvwgNo1PahS7F2HpWaFMSc7CNvRdiudPBTlWfck5U/vKByOeIU3d7PV4fuqevAvU3PPPl9dMN+pc2oRVdGHjSvZxyJguJTCTWBu4fV+/SAvghsj1D2E1gOIHu7G7H3Ea++o1yzWRBx40B0xuQgUZjnJFaLhaTiGeR2nT95ATG08ZN1NLxo4FZ1tKrMkhn+LL6F6K0Dc1WS880VIMhqwq69/yWiwAsM0vpYPikPyZuArQr+g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(22082099003)(18002099003)(4143699003)(3023799007)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODgxZG0vY3lCYmlYR3p4Ri9KNEhtbUh6QUdYMkEyeERHUDlpdHptcWU3YVRF?=
 =?utf-8?B?ZHZkMEtUSGRzQXByVGJZWWxkbGh4U0l5UENwWVdLUjY2NU1SRXJ6K2p6REdV?=
 =?utf-8?B?MjJZaUE5NWlKSStTTVVzTU5oVHpKWTJ5OGFWZWZPdlF2RHFqYU1pSUVXM2FJ?=
 =?utf-8?B?bHFENXBGSFJOZHlPR3Q0UEk4V3JubG9QN1lTQm5IdlloT2IyUHpYRXAwMGtI?=
 =?utf-8?B?cXBJa3pTVFNQTE5RR3V3aUFWWGh0WTk5NGFuVWVwanlyL0phdXlHU1plcElD?=
 =?utf-8?B?TjZQTVp1VHVDOGYxRWtOQUo2dTRQa3B2VGdSZ0VHUGVRODd2UXRRL3lIS2Rp?=
 =?utf-8?B?WE4rQ0JYVkdWd2pFVG5jQ0g4enFDTDFlK2xJY0taMUNNQ3JxakViR2ovVDd6?=
 =?utf-8?B?YllFdVBUcnc4bDgySEliL3pxOWU0SEUvSlgzdzN6Yk84NGRWTThGL3M3dTB2?=
 =?utf-8?B?SXBZQzl1VG5SVXF3cVo3WlVrTG9Ub25XUExPWU4zUkgyUGN0eCtqS2lteFEv?=
 =?utf-8?B?TnhrbW9ZRVpFUXNZSXBhRVZ2TWVWSExBTjYrNytTTEx0L0NmVVhpYzA3QVJ4?=
 =?utf-8?B?Z3lueGJOOVJPVUlOYVlGc2R4RXJzL3hkbUVYTlBGb3NPODdKZjZKbERUMGU5?=
 =?utf-8?B?c0U4MDlTdlhkMGZ5T3JhTGtWcUUrQ2w0ZGVaUmIydCtkRUJnaWhiSmRiUmI4?=
 =?utf-8?B?dEZ1cnZuK0JubTJ1a1RndFdyQWFtSGxpeHNmZEc3eFo3YmVDRmpkbU9oaDBq?=
 =?utf-8?B?TmhoNjJQY1JxS1pxbm1yays4eDR5Qkg0OEJjTnlMTmtZUTBqdUpaU1krQWMx?=
 =?utf-8?B?eFo1ZUlpaXZmMUJHdzRSZEVSYTRzWTk3OENIajZVQml4K1J1RWdaNk1mMTNq?=
 =?utf-8?B?U1Z5WEdhLzJTZTVhdWZnOXVNcGRzekZWOUNNTUlaT21KMis0SlpIQUFsQm11?=
 =?utf-8?B?cnIyV21PbS94N3hCK2JtTXVPNEoybnJsbG5QZXpVTFBlNEZlUHJlb0duNUxH?=
 =?utf-8?B?VU5BTGNEbDVneVpaeXk3UlBKQXJXVXZva29SY2tVMUpibU9tdk9wMDgxRFNu?=
 =?utf-8?B?TWNSeS90OHdBOExsM1BneW10WWJZNWVDcWY1UnU4R0ljM2Ricy9HOUFRUzB5?=
 =?utf-8?B?cytWMDRGUk9handpWmlqbDl2ZGlZanJpOFNna1hRYjFIK1cxelZZb2NpdW81?=
 =?utf-8?B?aFVRelRVSWpNd1NUc0h1SnV5bDFwdVFTdFhPUlc1SHFTd0JGR3NYeDdqTm9v?=
 =?utf-8?B?dGsyVmxKVTB6SkdaeTFibHdPNkJQMUc0RTBTV0x4MWFlS0E3cVZpeGtiVnVK?=
 =?utf-8?B?OHY2eWhhZ0FYNGRoQnpiTWF1U0F0S1d2VVpCcjRiNlBRdUFMNUJBcmMwQ3VD?=
 =?utf-8?B?MG9vY0JUNi9COHBRdURMaHpUa3Jkd21UbHN0YXhOZG54TjN6TTRKVVZxTkpG?=
 =?utf-8?B?cGN6R3dkOVJiMEhremxqaTVKdHF1ZXJaV1k4RjdXZ2xJRDVrTjZqMWh3Y2Yv?=
 =?utf-8?B?akRrOU1tK3NESjU3VENVU2gwODJmSGVFTmo5NHBlaWdKbVhwTEZ4cENGdWRk?=
 =?utf-8?B?ekRJcmFrWHd3WFRoVm9FOHZzQ1ppbkFXWkdFazNPQkcwSjB4STdaTURwM2hG?=
 =?utf-8?B?dEtoditNdmZ6bklRelUyUXZiMmVDcXUrYjJuSWJTUzR2QjJPWlBDMitYc293?=
 =?utf-8?B?c29uM0VremNSTFBYQ1FocEFmQmlGOEREYnMrR3NOaHVTSVdVYUU5MWd1anZF?=
 =?utf-8?B?OExDTGVpeVZjV3ZMbUUxMkR2RkdwM2o1bE9ITjN3WjlSQ3R6V09yQnNmWE1n?=
 =?utf-8?B?Mk94Yys3TlJWc0RMOTNZak9TV3dOQzFmSUY4c01JRzZEbXl1OThRYzd3T0xG?=
 =?utf-8?B?R1luNDhkVE0ydGp4QzBWNFdaL3NKdXg4WGxiSnVSU1Y4NUhIOFJMUVZkTTB5?=
 =?utf-8?B?SlVwdWVUNEJVSXI2TmdydzRxZ3NRSHQ5ZnVNM25oZWRBWXB4RmU3ay9sSlEy?=
 =?utf-8?B?N3VKSnFIelBxazZqSUJGWE1GSVlEbmxIZ0swUTBYV0Q4ZWx6UnhSNHh1QU1j?=
 =?utf-8?B?ZnlxcFlvdW1nQjVyd3VVNnNUQzNEeldvUjYzRWhWbTdybTc4UGEzZEtiZkZQ?=
 =?utf-8?B?aEJMcUlLUzJXbEczVnBMTG8rbExLa0NrWi9ub2hIT2NSOHFNcHhrYnZISVBW?=
 =?utf-8?B?VGRxd1owK0crSHlYenZqMHpGQnQ0TnVTRTVLZXp3ckNMNnM0amdabXlsYXph?=
 =?utf-8?B?MWZFVjg2Y3FSZVR2L1E4UEkyN3VmbWV0QWlJZGxsVG94QWV6ZmVXOWJoZ24y?=
 =?utf-8?B?WUNUYWRmemsxc240NStIZUdOU1dRVE1pbkg0VU1aMTJNRjE4VllCZkJpYU5D?=
 =?utf-8?Q?RtQXFK7RnFYz/9cYGXH8smmfhy+SmEpifm8TBxHX0eS85?=
X-MS-Exchange-AntiSpam-MessageData-1: dXIMLyGwD1U7mA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d96fc489-7eb8-4af6-95e3-08df158c9071
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:55:57.4703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZoDnTjb9ubeGG3EjRKrhPBOpChuq0wA5zMUj+ViuTh1diFSZ5BBCcvVqLh5d7LC5A+v1AWf2s3aikoCp3cXOIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB033229
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

On Mon Sep 14, 2026 at 9:12 PM JST, Alexandre Courbot wrote:
> On Mon Sep 14, 2026 at 2:42 PM JST, Eliot Courtney wrote:
>> On Mon Sep 14, 2026 at 1:11 PM JST, Alexandre Courbot wrote:
>>> On Thu Aug 27, 2026 at 11:12 PM JST, Eliot Courtney wrote:
>>> <...>
>>>> +impl RegKey {
>>>> +    // Define the Key IDs read/written by GSP.
>>>> +    const REGKEY_NAME_KEY: KeyId =3D 0x3070;
>>>> +    const REGKEY_VALUE_U32_KEY: KeyId =3D 0x3071;
>>>> +}
>>>> +
>>>> +impl Encodable for KVVec<RegKey> {
>>>> +    fn encode(&self, encoder: &mut Encoder) -> Result {
>>>> +        for regkey in self {
>>>> +            regkey.encode(encoder)?;
>>>> +        }
>>>> +        Ok(())
>>>
>>> Maybe this is just me misunderstanding, but how are the keys
>>> sequentially sent here? Because I don't see any mention of an index, an=
d
>>> `Key::encode` hardcodes `Index::new::<0>()`, so how are these supposed
>>> to be decoded into an array? The `gsp_init_request` test below only add=
s
>>> one key to its `regkeys`, can we add at least another one to see what
>>> happens and verify that the received content decodes as expected on top
>>> of checking its length?
>>
>> You are not misunderstanding, it's just a bit odd. This is because
>> sequential regkeys are all sent using an index of 0, according to the
>> protocol. I can add a second regkey into the test to demonstrate this.
>> We currently don't and won't soon have a need to decode this kind of
>> repeated index 0 encoding scheme. We have `Accumualted` now, but that
>> relies on the index changing to know when the previous value has been
>> completely sent.
>>
>> To test that the content decodes we'd need to add either a test only
>> Schema for it, or add a schema that isn't (and won't be soon be) used.
>> Alternatively, we can test against the encoded byte content directly.
>> Which do you prefer?
>
> Whichever you think is adequate. :) As long as we test things our
> current code allows us to express.
>
> Although since the NVKV protocol is specified, I think we'll want to
> confirm the fitness of our implementation for the entirety of it, even
> the parts we are not yet using in practice. In that case I suppose it is
> acceptable to have a Schema that is only used in the tests for the sake
> of completeness (even if that means having a temporary
> `#[expect(dead_code]`, as long as the reason is documented).

Alright, I will add a test for this which adds a test only Schema for
regkey. In doing so though, I noticed that with the current design to
write a Schema for regkeys, it's fairly easy to end up with `Target =3D
(KVVec<KVVec<u8>>, KVVec<u32>)` which is not very nice.

I thought it might be nice to allow the possibility to borrow from the
encoded stream. Then we can at least have `Target =3D (KVVec<&'d [u8]>,
KVVec<u32>);` (Or use an ArrayVec and avoid forced heap allocation
entirely, but regkey is one of the locations where no clear max # of
them exists AFAICT).

The next version of this series will include this, basically means
adding an (optional) lifetime to the schema that represents the lifetime
of the data. To avoid infecting every struct with this lifetime if it's
just doing copying, I've split Schema into a Schema trait and a
Visit<'data> trait (otherwise you can't refer to Schema::Target without
being able to name a specific lifetime). The Visit<'data> trait is
generic over the 'data lifetime, whereas the Schema trait is not. If you
want 'data lifetime semantics you can add a 'data lifetime to your
struct that implements Schema and plumb that lifetime to the
Visit<'data> implementation. If not, you just let Visit<'data> work for
all lifetimes. The macro handles this transparently. It's not a big
change in LOC but it lets us avoid a copy.

What I'm envisioning is that we do one copy out of the command queue to
provide the encoded stream as a single slice. Then, Schemas can take
borrows of that if they want to. Then, when we convert to the `Target`
output type it can be copied into the final type we want. So that leaves
us with two copies, which is in line with variable length handling for
the r570 Cmdq code (GspSequence, ContinuationRecords).

I considered an additional approach where we deserialize directly from
the command queue ring buffer memory, but that means we need to handle
two slices all the way up into the Schema implementations, so it's a
larger change. Anyway, it's not incompatible with the approach in this
patch series or the approach I mention above, and would let us get down
to one copy for variable length data. We could consider doing that later
if we really want.

I was also looking at if maybe we can do the bidirectional type thing
without overcomplicating the macro, because it ended up being quite
gross to add round-trip-like tests like you suggested, since you need to
basically duplicate the struct. If you have the macro generate the
Schema struct and the storage struct, plus the encode impl, you can
avoid this. I tried a serde-like syntax which actually ends up being
doable with just macro_rules! altho is more complicated. That ends up
looking like this:

```
nvkv! {
    struct GspInitRequest<'a> {
        #[nvkv(key =3D GspInitRequest::PCI_DEVICE_ID_KEY)]
        pci_device_id: u32,

        #[nvkv(key =3D GspInitRequest::PCI_SUBDEVICE_ID_KEY)]
        pci_sub_device_id: u32,

...

        #[nvkv(kind =3D Repeated<RegKeySchema<'a>, { RegKey::REGKEY_NAME_KE=
Y }>)]
        regkeys: KVVec<RegKey<'a>>,

        #[nvkv(kind =3D Optional<VfInfoSchema>)]
        vf_info: Option<VfInfo>,
    }
}
```

Another version avoids the macro complication, although it's less
obvious what the field types are on inspection (they are declared by the
macro using Schema::Target):

```
nvkv! {
    struct GspInitRequest<'a> {
        pci_device_id: Required<u32, { GspInitRequest::PCI_DEVICE_ID_KEY }>=
,
        pci_sub_device_id: Required<u32, { GspInitRequest::PCI_SUBDEVICE_ID=
_KEY }>,
...
        regkeys: Repeated<RegKeySchema<'a>, { RegKey::REGKEY_NAME_KEY }>,
        vf_info: Optional<VfInfoSchema>,
    }
}
```

Anyway sorry for the wall of text, any preferences on the above? Or we
leave it as is with the separate nvkv_encode/nvkv_decode macros with
some fairly verbose/gross round-trip tests.

