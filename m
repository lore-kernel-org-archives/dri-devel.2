Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA57EF531D0
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 03:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C851510E059;
	Tue, 14 Apr 2026 03:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jPjv05+x";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9D710E059
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 03:13:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ds5hcrgGovDJeBSbGssY9S5wHNh2yRG6XDDYFWcwKR2P8bO3VnAogBpF38DFlQRb9G4Zw0wnrzJqgbbQs7zCR2oA2Z27A+HZ0EAKJftQiOobtwMYcxjQ+LeTfYvGdXmH1NbWgzumxTbtr3A7emR1/zme+sUyiCQ4/emCZb31ADFINMqd4dS1T66tBVgzlukMBaPwIIryTbeNGAl1JZq9xlCOd9kCuGZE5/x7SnMQjH2sFbfsum8k8MkegwQTHVK3ZIIAKwRGi9/USRj9qisIVo627CdGg4CElENzVYk2UHOGqs1wvOcAzCyxVgDJcni5KfLE8IuWAfizsTggXjGZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCRzftIqZs8v4gh6kBiT7meiYNcRJLr5kirRlSf8PWI=;
 b=rWaAlmLTclpUc99Uexk10YFQFUNlu60Ul2tWCRlzzz4lTTx/pTUsa6lScR56qQqdO6SrGPgerMjG0JRY0qhVB5Jb91jGdalMeUIwD8Z99Xt87LODJwkDAu8TLaA/RXmDQOzFg5lt2JagG+mEgvHxiv5rF7TruMYYmYsT+xfda0UUYREU9p6huj21Y0bSWkTKRqNL/OXojGuHKpPZ02ImhFGw9jIJfJXgcUZC8w4dzMjC4oMPDh4NqlEjEAdMTzKxfrWBbBt9MnBRpyBY3hQy6a500Jsl6uuqeYyleAgWZdeE7w8GhV5mQLbZewKYgPj7UmvZqUkIcesFT73KF0ovRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCRzftIqZs8v4gh6kBiT7meiYNcRJLr5kirRlSf8PWI=;
 b=jPjv05+x+1eakmY4VfxULwTPQUMN0Qd+pPohVZoeugRKbwaDnwWkP9rXDID2J7BUB2pH6Uh7DiFpvXfTrrB7/V483BqBZalMTeniFV6ZW0CxP6DOFybSBhEdLbMfDrGovltOQtUAx/e/QlS6VvWlb3h5k7+Yk8XHzi+w/oz9TPvn2OQYdYKMjJ6/hQ99AVzTLwo531sMuHw0sWPx3DPnku3LoOTDGZm2uZX2Dxg4XWdxGT1BiqztVyG6kxhoS/IL3YtRcjB5D1W458Ft3c+K3OIRbX7CvF5Ld+vyLYgJGg5m+hEsLW/BW7H/jnRCO8nTp3WUqY+T0Q7jIk1J9TaAHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 03:13:52 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 03:13:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 12:13:49 +0900
Message-Id: <DHSJTFBXA2EM.1I22OK3J5NPRL@nvidia.com>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] gpu: nova-core: vbios: use checked accesses in
 `setup_falcon_data`
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
 <20260410-fix-vbios-v1-3-bc6f71d153d6@nvidia.com>
 <8bf30537-de54-4be0-a676-3e8aad6fb312@nvidia.com>
 <DHRSTLTQNYTB.1ZQO8FBOU678Q@nvidia.com>
 <DHRU81HM4D1V.NVTBVV8BEG2W@nvidia.com>
In-Reply-To: <DHRU81HM4D1V.NVTBVV8BEG2W@nvidia.com>
X-ClientProxiedBy: DM5PR08CA0041.namprd08.prod.outlook.com
 (2603:10b6:4:60::30) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c0f8ca-2c75-4e60-77c9-08de99d3da9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: a6kaPhDeTZvHLWWlOobhW6VUpEZPPVCSONc/141XosRMjrofdBuOFt0XYpL58T8LO8/0wMbC5Tz+OVoLkNY9fRHSC7MH14wQi5yJKE32QVit9ygvYIIaDId/aqSKfhSRRqHqIE4mAW1Zoleu9CX8LSpMsUL+TAk1DRDUUZtxmVYihlBBRsR8x8DuWScZbqVvYd0kGTvYttB/URIDHb94/TE086CpcS4f6wwwdrvunn2cfoRDDBr5O3wQ6gC9IzaI1jt+Vj0Jf/MUKZvwRaxVdUFTpxytt8MfEtsh5y6u6YmLpqr05nalvkqBdFklhcATUG8RIOwtx83zKx8tpIJV4FmIQtT0WpOWtN9DparAsA+6Y/9TtP7X2CPMkA9ntQAj1zzfhxdU6Ryg2qpiS/hYMYEOPTH4Z4hPa9HI6frAtDEW0eYRlfIyT3teTBTgi26G+NwHek1FVNB2jYg4tgdjmH3kDceQdBgG0OuKrRZa7NgDy2Ncxa9n2+I4ksKBg1GhBMiPGa2ncTSUKZptIwYYqjzf+Ru6o6lIjNiZjbp6IjjAtiqsieB+baSQUd3tpGbkgR5Vdd13c0kgervibCy4c3zLWeaALVCj33Zl41OPbcHzRLgGEkZpQZ0tD286Xtt6KKcsQuX0GY04HdM0EKn9Tbg+BBnz/RMyh0a6CWKZ3hJ05EiGqoYfbYVjxLe59K45PZb6C14Myze44C6NclQ0bpqJ114fcw9nf4rSpV5pbKY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHB1V3RDaW82R0x4endzVnlHUWFhVmhNNmJNbVJZZ2t4ZHhtWlJ5VVpQN3R3?=
 =?utf-8?B?Mm1iUWdWckt0bHdHMTZ3a0Yzd1FuZi9KYWFlUEVkdXhlMVBVcm9yaVFlQ3hZ?=
 =?utf-8?B?enkxUTI1eU9YMVFhbzZmekN1a3ZkeTgzNHZLNkh2RW4wRTdIOWV3YS93UTVv?=
 =?utf-8?B?TkNTN1dOYUIxREpnU3Z0VmRJSkRkRFlLSHcwaUNTNEl4cGx3KzRXdWhsN1gw?=
 =?utf-8?B?cmN2K01FN1BQSGlIa2owR29iR2FWVnU0aEx6MGJWaElqcGgzdGszTENFSzJT?=
 =?utf-8?B?RmxKQ1ppVXkzM0E0NDUrRUp4OUFaSnM5a2RPOHJ3S1l2ZjB3dzVjWCtpR2RU?=
 =?utf-8?B?dmlYOEMwMjYvdkE0UjNXeWs4Z09CdzBBSk80Nnh6Wjlrdkpvam90NW9YdXNI?=
 =?utf-8?B?WXJhdmJWNlNLRE96K2habWQ0RkVtb1pjQlluank0UnBRL2hHc1hZWlFhYm93?=
 =?utf-8?B?Z01jRDBJY0VLL3BiN2MzY0N1RFVnSXlQZ1ZmUnRLYnBOak9nSjE0QWhNZkdQ?=
 =?utf-8?B?RU5IY3JuOXkrSHA4dVg5eXdlajlncUlEcDVsTFN0RGdpS2U4WkxhWkhpRXkw?=
 =?utf-8?B?b0FZZFM5MGI2QUIwY3k5alU3ZGFhMmhkVlVqU1ExZU1BZ09RUjY0ZDdLWVVJ?=
 =?utf-8?B?eWdKVmhSRXVDSUFINDV5eUhYSDB6d0tvLzM2NnBYazdOdUg0bjhJdTZmcXEr?=
 =?utf-8?B?R3ZoOFR6OU5VNTJvMFBxOTRPQTMwZUg0MGd3UE1pTnFiVWtZR3ZlL1didUc5?=
 =?utf-8?B?eVBDaFRreWhDVGZwRk94ZGVDWVhJdjdhSGhBWEhmUkU1Wjkrbks5TW5xcit2?=
 =?utf-8?B?YjZWYmNKRitpTHZDeExPWVZXRlArU042L0liMkQwZTY1T2VnVkJ3M0cyemtz?=
 =?utf-8?B?UzRFeFZqeHZVRy8rdWMzckdJbnZEeTJkYkVLVHhZTEFnQ1pDYWFCWVBMcWQ5?=
 =?utf-8?B?aG00TjcwamxYd2NoeXB6Z3YwS0tmR1QrVEVBNTBva0MwL0gvWnZEbmFYWG1L?=
 =?utf-8?B?eFhMRHpLcjQyQ255dEQyclI4Qit2UTZ2NFFGR0NhVHI5Nm85UVRMekhQcit4?=
 =?utf-8?B?OXROSVVmTFpXOHU2Wjlrb0h4ZlJETEdhUW1IQUlhM2lPS2NqYU9aRnRWYUk5?=
 =?utf-8?B?N0FtN2xtL3pEY3pzRmg3Z0x2RnJKUXZTc1pvWVlzS3hta1lkaVZCQXpTVWMy?=
 =?utf-8?B?c1hwbDh4NEY4TVVQUlk2aFFTcE16eVpTRng2ZGp4WnMrbHVUYmxmNE5OMEwv?=
 =?utf-8?B?UVVnYnZQMmEzeU5ESU5WaDNpVWVlbE16VEFnVXJORm91SFRsZ2cycGlDQWQr?=
 =?utf-8?B?NXNmMjhMUTkwOUlwS0pjd2JmUU1YVWUvTFRXc25WK2N0d3NlZjllaVJ4aFUw?=
 =?utf-8?B?d0dEUkZTSG81NFZZNUFTN25aRmJtOHNkeG10S1ZsTHl0L3Mvamt4ZllUcTNQ?=
 =?utf-8?B?MDA4VjJpVzFvNHcydEZoNS9FSUVCT0d5VDE1ZmU3dVZadWJQTFVJY3psUith?=
 =?utf-8?B?N01DZHhneTA2cFZuNGVzNGRiZCtCd3h2OG03bUFFMTY0eXRUYXNiODZvVlBY?=
 =?utf-8?B?dncvakRSOHNRUTJ1b2tPTXpVcWdnbDIwV01Id250SUJVZjc5Z09DYXpsWTlP?=
 =?utf-8?B?a05zVU9hS1RBSVFoL3lqY294Vkc1ZEVaWWdFWFJwS2psSFowY21IRUF0NXk4?=
 =?utf-8?B?c1A4REpia3FGbFZhYnRjaE81RmpnK2dWZ2tzN2xIQm5XbzZHVnFZaDRzOVll?=
 =?utf-8?B?djN4WmFPS1RkUityS3BVZThXbUhoYUIvQkM2TjVPUXNVL0dWSVA0SjlMTmI0?=
 =?utf-8?B?M1Z0MTBJOEROZnRVZjcrZ0l3aEM5dWJsMmdIQVE3Um0zTm53Q0ZYek1wUHNt?=
 =?utf-8?B?d2QwRGVrZmErZzVsS3FkTHZtYmc1V0w1aVdhWERtazQrb01VOWZjbHRqK3Fp?=
 =?utf-8?B?eTVmTUx0MXFjT3I3SXVqWUNqZjFmcTZ4Ykdua0RFTjJHbnRCUHVaUlVDWkx4?=
 =?utf-8?B?aXNmTVBxMW94RTJUVlhMTkl6ZnBVZnFNQUh1N2p2OTg4N1M0MTlpSjlCYWtR?=
 =?utf-8?B?NW14L1F2eVRuclQ2OGF3NFNmRENiYVlhSkhmWVJxTC9EUFNLcjVYd3VtMGFz?=
 =?utf-8?B?WERSUFpiMFQ2OGRjMFczaDdtMGdScXZvUGR2enE4VHlMQ2hqSTVzVVBPakxo?=
 =?utf-8?B?bnVucWo4N1o4NmJZVWpxelo2bWpQODVOcVdYbk9aUzNvVy84VGUvTnJqQkxN?=
 =?utf-8?B?MWxVeWh0Q2xHWVdER1NTaVJacGJoSVlycTZ2cGk2MU1GS3Z3QjNhMUVhK1RS?=
 =?utf-8?B?aDFRZDVoWjIrYkZqSHpaWkhqN0UrUVBaRGFDUHppd2ZUS3duY0pLRnE4dXIw?=
 =?utf-8?Q?fMm9kKOUhL1LG8CVfp840lWHfNn7r1lrfYl8ZPBWY8nmv?=
X-MS-Exchange-AntiSpam-MessageData-1: ERIMUaj+VLLF1A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c0f8ca-2c75-4e60-77c9-08de99d3da9e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 03:13:51.9806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQfbUeFtgy0spXZtV8lHP7sHXlPBKsqcjUrEchSi4zg8NAa5G5SFCmPI/y4xK6Q5HSz6DHJ/U1HsK8gkPqXbWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
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

On Mon Apr 13, 2026 at 4:10 PM JST, Alexandre Courbot wrote:
> On Mon Apr 13, 2026 at 3:04 PM JST, Eliot Courtney wrote:
>> On Fri Apr 10, 2026 at 11:53 PM JST, Joel Fernandes wrote:
>>> Hi Eliot,
>>>
>>> On 4/10/2026 4:38 AM, Eliot Courtney wrote:
>>>> Use checked arithmetic and accesses where the values are firmware
>>>> derived to prevent potential overflow.
>>>>=20
>>>> Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PM=
U table in FWSEC")
>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>> ---
>>>>  drivers/gpu/nova-core/vbios.rs | 20 ++++++++------------
>>>>  1 file changed, 8 insertions(+), 12 deletions(-)
>>>>=20
>>>> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vb=
ios.rs
>>>> index de856000de23..2b0dc1a9125d 100644
>>>> --- a/drivers/gpu/nova-core/vbios.rs
>>>> +++ b/drivers/gpu/nova-core/vbios.rs
>>>> @@ -936,17 +936,12 @@ fn setup_falcon_data(
>>>> =20
>>>>          self.falcon_data_offset =3D Some(offset);
>>>> =20
>>>> -        if pmu_in_first_fwsec {
>>>> -            self.pmu_lookup_table =3D Some(PmuLookupTable::new(
>>>> -                &self.base.dev,
>>>> -                &first_fwsec.base.data[offset..],
>>>> -            )?);
>>>> +        let pmu_lookup_data =3D if pmu_in_first_fwsec {
>>>> +            &first_fwsec.base.data[offset..]
>>>
>>> I suggest use get() here as well for consistency with your use of get()
>>> further below.
>>>   first_fwsec.base.data.get(offset..).ok_or(EINVAL)?
>>
>> This one has a local proof that it won't ever OOB, so I didn't use
>> get(). Not sure what the convention is, but what makes most sense to me
>> is to use get() if there is no local proof that it will always succeed
>> and use [] if there is such a proof. WDYT? Do you know if there's a
>> decided convention for this?
>
> Ideally we use the type system to maintain the proof that OOB cannot
> happen - typically by calling `get` early and working with the returned
> slice from then on. The problem with this code is that while there is a
> local proof that OOB cannot occur *today*, there is no guarantee that
> this proof won't be modified (and break the invariant we rely on) by
> future code.
>
> Looking at the code it looks like it deserves a larger refactor. We are
> setting `pmu_in_first_fwsec` if the offset is valid for the first fwsec,
> and modify `offset` if not. Then we check `pmu_in_first_fwsec` to get
> the PMU lookup table from the right source. And after that neither
> `pmu_in_first_fwsec` not `offset` are ever used again. So this looks
> like this could be factored out into a single test (maybe a match on the
> result of `get`?), where we simplify things further and don't mutate
> variables. Things tend to fall into place with properly guaranteed
> invariants when we do that.

Yeah fair enough. Let me send a more complete refactor in the next
version. Thanks!
