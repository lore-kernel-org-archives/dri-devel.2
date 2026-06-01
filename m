Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA968CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 01:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E73112CD7;
	Mon,  1 Jun 2026 01:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HAt3s4/b";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52783112CD7
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 01:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylqKP3hHVRfJ1GNd+2Y0g9jV6YAdgpMEhaqZ5N2o+q7WXvJcK5icNNsUniJz/nUQwwB8V+SumBaY47W3EyhOcKRe8FfAzCAVMDLTWIpsFifCqTWs5y7yyMWfYtSPJSLDrv87l+BXBeZZgvVJULGgBXKCvB31SJ46WZDl4pwmOt/8hihE4eEvVWgla8LAxkFrjerYhclNAzTn1HW1AePkotKlBNWmu/WEpmapyzddGW2kINr/jd0jJP78ywqG9Bl/0I+Io9OnBksJb7exf/D2Zbjk/c4LxJo2/3gUieF/xpvpL057eVxfPYyjaU/oKodLWmcy15bVQT/ikdwSZi/2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC9sf93Q4j2nOL/LNLJPqZlePeL9zSikTqyce6bzi/0=;
 b=ubiyPAp/ltX73z9QVp3Y7GPP/JssgYq6zyqqzqkPi/M4HICFH13ojBUiQ78nQwla/HCtX8L93l2zshMiyHN7mOiodqIxw/84D1BfNTOMrh2WK0nlJk3xrUFHSmsiFOXqUTUgRRIR1jKG3qaIk/ofXM3dGTq4OO8yxpySsWQWNgdJAmarW6UlidxgWFtirM6t223bMrdtVjQd3MY3CUub6C6JNFefMQq9/P+yoJRQwIOaJOqAWFqmH3JAXozCkqcXalvFo5UhFjxxeUfJDVQ1nhediqDSdOgXzmiosdu0FimPvZCxoRpXgjWVFUikrgyVwLf4HgGFu+4SrRNOmPq+5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC9sf93Q4j2nOL/LNLJPqZlePeL9zSikTqyce6bzi/0=;
 b=HAt3s4/br4mNdI95xMzZLvIFGgzykAgLKeuBsJKMk/EbAzjB7jsl7qcR7alZuLdh1sIjquLl8+EyXFtTP2smvihsZlCX3QqoATAYVWqJb8rLKrzTNoWW6bnDbQeevDjyiYJCp6Yh0+er2owdkOChvVieI8rCWew8N9jGqX4QmGF5RxC4FQa/KLDcki1DwdSbjUK8Zws80c15Y9eKXqbsrQwEpqDBmrT/F2BIMk79z7Mh08xWozcoBAeBOBD6k+M4Nitz4ku0VgXKMhezJ6VVD8CAAWP2kptUwBnwJV1Dv5wICb/qzzENZqC/f+IyjOzuEkEvqg3SLESwx32axe9Kxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 01:44:43 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 01:44:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 10:44:39 +0900
Message-Id: <DIXBZAZ9EKVY.3GG9PWHU1Q9Z0@nvidia.com>
Subject: Re: [PATCH] gpu: nova-core: gsp: tu102: keep unloading if FWSEC-SB
 fails
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Timur Tabi" <ttabi@nvidia.com>
Cc: "dakr@kernel.org" <dakr@kernel.org>, "aliceryhl@google.com"
 <aliceryhl@google.com>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Alistair Popple" <apopple@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, "sashiko-bot@kernel.org"
 <sashiko-bot@kernel.org>, "nova-gpu@lists.linux.dev"
 <nova-gpu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "John Hubbard" <jhubbard@nvidia.com>
References: <20260531-nova-unload-fix-v1-1-c8dcdc769b53@nvidia.com>
 <312f8467da270e33f881cab7780692a49756871a.camel@nvidia.com>
In-Reply-To: <312f8467da270e33f881cab7780692a49756871a.camel@nvidia.com>
X-ClientProxiedBy: OS7PR01CA0112.jpnprd01.prod.outlook.com
 (2603:1096:604:258::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: 596a053f-9019-4221-e1d8-08debf7f5a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|4143699003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: x/wkUrku8+krBdaxgJLh1BJsfOmTOrB3SQe34BX0ZpeylU+C+M1Eqcsf9Vc0GVy/u8ZpwGW17MnJz10wH38Jikq3LU4pcurbLIut7nH8gVIq/m5n0lm2YeTBo7o5ldP2pp2Qy2VqbLdF53IzBnORaHUnTl6HJ7+j4yOmRY4e2eUPpi5JaTqRdg+H67aFDiqFWe6w4Ohcu6FEebO9MRT69akOv+wEmspkdACN7dn9NLFSH+RNY19U40dUXFhSVVDxIJNlkXkQqKK2yOLXIkh28JMIDXsQ2z1XhGCKqE91LbNquEgQeaEWB7j6oD2r9sBSEDRLRejN1vwQ2wbZabNhY/v6At0l1jdeFEX88eQZi3d74jpTAokC0pjhycayl1eJz6Da75EZuOJXC4j8t/FwTs3w2QPxmspKH4jPlkKz0PnWzzMTzJVKcEBUbVHjaqmJCyL6NjZawQmVzcpC9QhUBsYh98mcVAnW/22Q9CI8vGqMcJalGHuFO9kBXqO69A7hx3CZMZgGbUhSWS8t1OdK270MLdo4oRj8n/S4hb130lr0/iEs3QQ1P8VRHz/3B4/DIACNES85ZTAWiTXYGGNy1Cp9k390HbKkwXGffrdrQ9g/PfddTrIZ2JihtqUCs1jIAZbcz/tWCg/+JcHRWKwbH2l1N0NS56oIXHescU+TUfJUODVsE+E1vxNNGMeZgrQP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTZLVDdqQ1JneFdzaWI1RHJabmJHaTUwd1VJZHBwYWtSQlZhSmF4NzE3QlEv?=
 =?utf-8?B?TGorQ2J4b3czTlM3VGgvVW9yUTNDMlo2Q3VnQXFGa2ZVSUpsZmc3dUcrSkxL?=
 =?utf-8?B?SlMyalIydEs5SnlDMDlGYWxYR1RjT29oSTJ2VjFwTHJTUzRvS3ZvSEREaVU4?=
 =?utf-8?B?MXB0d3JqYWlPdnBDdk52WW9hcFVIN2RvVXJzaUZmT2Z0VnNYL0FKWHFsdUsz?=
 =?utf-8?B?aWQ5M3lTcDNYSENVTnJ0OUN4bmlSQm5jekNrMGRsNEsrZ2tPM1ZZcHRzYjQz?=
 =?utf-8?B?K0ZTczFFcWpUK0EraTlKUDA4MWhHRVU3QjJmNk8wTUJibGpkdG1zaXNrTHU3?=
 =?utf-8?B?WGxjeVh6WmdRWEpnbG5jZ3d4NXd3Nk5QQ2ZzN0t4UDZZUnJwQmJORlN6akVn?=
 =?utf-8?B?TmlUSXNBeXNrR0pVZE1Yc3ZEWnMvTENaczRLZ01wNFFuQkY2Q0pjYnZWNlRx?=
 =?utf-8?B?cVFJNHhRdDc0dzRvMkltaFJsWmNqTjJkOFh4U050cEl2cTl1Z1J3U1E3dm1h?=
 =?utf-8?B?enJvNmZZYm91V0lsRVZuWDRtQ3U5b3ZJTmZ2cFI2NmdBVWZMdGhmSmVCZjl1?=
 =?utf-8?B?dGs0MkpYUEUrdnlqRGFDRjJsbCs2NHZ4U3VzeFh2VHNBcHlYK3JUTXZUTW5P?=
 =?utf-8?B?a2dBRSs2WXUva3pMNmNqakUwVjRJalhjSnhVU0MrR2dDSGMrZjFuOHRXcmF2?=
 =?utf-8?B?UVZzM3oyRDBuSVgxK2hVYmhLN0w0dmJWbXY2Ni9XeTB4d0ttc2tGNEZQaHJ4?=
 =?utf-8?B?M2lIQWRGSnducExveFU3d3BURzlyMDJpSzNNY0Y4Q0xkdmtiV3NEM1QxOGlJ?=
 =?utf-8?B?d3pvMjExQ2RXRkFpWmxFRDJUczFZU2o5WWFSLzRZZjRyeUtTNlVCd3RzNUds?=
 =?utf-8?B?Q1FJcmZVeC94UWpxeENTaWpSM3JobkRJWDFRUnpwekdwTWJnLzkvUVMzenRI?=
 =?utf-8?B?UDNVVk9mT2FUdStpMXFtdDFDVkxQQk5sbjkzWStjMk9HdHJ4OXA1RmovNnNZ?=
 =?utf-8?B?KzRldFdXdjVSQlNqUVhxd1Bpb0tZVzNMcTJPd2REc2Y0djFWbmVKRkhXcXhl?=
 =?utf-8?B?dGRvZ1phWG56WmlMQUZSYjhTZ3FrWk9OZWgwU2c2RFgzcDB0NDllRnlwVndM?=
 =?utf-8?B?eUZxR1lSbzJ0V1Q4SFVFaFRtelUxS3BTZjhXVllybGZqbFM3VzhBRHl6S202?=
 =?utf-8?B?SFZzK2R4cERPZ0VpY2V5Y21HSWplRTdNeGk2N1JFbVZpWVRQU1daLzBESEtG?=
 =?utf-8?B?YW1EcUptRlkrYkxtRm9UVFNWUjA2bnhwTm53ZUx5NGMwQWwyUHoyMW83Ykdi?=
 =?utf-8?B?Vy9IR1AzMXF0ZVF5UWw2QVhVTk1aRTJDQ0FVYlpNenRMMDVQQXZPZTYvTmxn?=
 =?utf-8?B?d0RXNmFpc3YxWUFIOVJYVGRSbkp1bHhnN3RFcDhFUXl6OTRvRWRZMnJQdFZy?=
 =?utf-8?B?eVpkcUxEdGJJdEFXSnNpSFJhdFcrbGRnaFFPREFwL0hKeXFQanFab2lvc2VO?=
 =?utf-8?B?c1hZenlBaEFIR0RGT2k4MXVtM3NTNktXcjRaajhDam55WFErd2h6QkdoZFhF?=
 =?utf-8?B?TTE1dllGZjFYUWRLRE1hajV0VEpHMXJkTWNsdlJscy9iWWVWM1FZMEdlZHZH?=
 =?utf-8?B?dzQ3RGNsT1FGeVd0QURqbnpDdEJVN3RRNFYyQ1VqVEZUU2M5QWNFRWVPUVB3?=
 =?utf-8?B?THF6Q3h4OVlVcS9VUUR0dkROTTVJU2prUXRrSnFaYUZJNmM3SFlsMTdaUWFv?=
 =?utf-8?B?T3dVK083emdxZWNtWHVIUWlCbVBPZWIxN3ZDN2s4NEhSTGZNTjBSUTRpQUds?=
 =?utf-8?B?b21VOXpKbm5QLzlmWWhEQklKcmQ2L04wZUplanJXVjdGOWhDaWZRWmZGQ3Vr?=
 =?utf-8?B?dUVXemRnZUtzNXp6N3JnWVV0SnByTERveXFuV1FFcVZXT1NNUkNnNHRwc2sy?=
 =?utf-8?B?TVhNejhFdGNES28vcFk4ZnhDU2gxSGJja2VOVkx5RzRqcjhwNEhvdUhFQnU0?=
 =?utf-8?B?VlUydmdlWXp1VVNlT1l2SUdwZjBweG93SDFNcVhGaGZWNlhwZEFJMUlITmV3?=
 =?utf-8?B?Ynd1VzN2M0JxelVRSVdPTERtUkhKU3l5d0F2SHpsL2lKOFNkUUJxRnVWTzNt?=
 =?utf-8?B?MEpjTmJ2ZzFDQjNqUGF1U2xHZlVnRmtyOTRGZG0yMzJlOG1lSU94cFJMQkpk?=
 =?utf-8?B?bEx2WVFpUWltMHhyTjQ2aG11QmZOaEVTc3NhYmZKaXdCM0d4WTlac1hqcStk?=
 =?utf-8?B?RndLYWpvV0hBZDFYRjVaV0pWYTB1aU5oalB0dEduZ0MyRTdncnZtY29LcVlR?=
 =?utf-8?B?eTRaTnU3Q1RGc2VsakxROENySGRja2hpb0hTcTF1OXR3bHFCeFNSZWhkT2lh?=
 =?utf-8?Q?pKrHaZIW2EVdufho0f81gjyMlrIzcOta9bH2n1S0c+l5/?=
X-MS-Exchange-AntiSpam-MessageData-1: rnGSjZNr+DEMTQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596a053f-9019-4221-e1d8-08debf7f5a40
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 01:44:43.3764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJKtNOoFV0yvUGrjVgR2QZH2ry0yIPFSdBf0fhdpRd/p3N2TZO/iP9BcS8Esb2VfjYoZdBFiRR8TmM357g6cew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
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

On Mon Jun 1, 2026 at 3:41 AM JST, Timur Tabi wrote:
> On Sun, 2026-05-31 at 21:37 +0900, Alexandre Courbot wrote:
>> On Turing and Ampere, resetting the GSP involves running two firmware
>> images: FWSEC-SB and Booter Unloader. They are independent from one
>> another, and we should do whatever is possible to restore the GSP's
>> unloaded state even if a failure occurs along the way.
>>=20
>> Thus, keep going and run Booter Unloader even if the execution of
>> FWSEC-SB failed.
>>=20
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes:
>> https://sashiko.dev/#/patchset/20260529-nova-unload-v7-0-678f39209e00%40=
nvidia.com?part=3D3
>> Fixes: adb99ce3cc78 ("gpu: nova-core: run Booter Unloader and FWSEC-SB u=
pon unbinding")
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>> This was caught by Sashiko; I unfortunately noticed it after pushing the
>> series, but having it as a follow-up is beneficial regardless as it
>> allows more time for review.
>> ---
>> =C2=A0drivers/gpu/nova-core/gsp/hal/tu102.rs | 18 ++++++++++++++----
>> =C2=A01 file changed, 14 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-c=
ore/gsp/hal/tu102.rs
>> index a033bc892066..b10215190257 100644
>> --- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
>> +++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
>> @@ -134,11 +134,19 @@ fn run(
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sec2_falcon: &Falcon<Se=
c2>,
>> =C2=A0=C2=A0=C2=A0=C2=A0 ) -> Result {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Run FWSEC-SB to rese=
t the GSP falcon to its pre-libos state.
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.fwsec_sb.run(dev, bar, =
gsp_falcon)?;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Log errors but keep going=
 if it fails.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let fwsec_sb_res =3D self
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .fws=
ec_sb
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .run=
(dev, bar, gsp_falcon)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ins=
pect_err(|e| dev_err!(dev, "FWSEC-SB failed to run: {:?}\n", e));
>
> Shouldn't this be dev_warn?

I guess that's subjective, but since it is technically an error that is
likely to prevent the driver the reload I think `dev_err` is the right
level here.

>
> Also, how did you test this?  Have you tried breaking the FWSEC-SB code a=
nd telling
> booter_unload run anyway, and seeing if you can still reload the driver? =
 Sashiko said this:
>
>> Since FWSEC-SB (running on gsp_falcon) and the Booter Unloader (running
> on sec2_falcon) are independent cleanup steps, returning early here bypas=
ses
> the Booter Unloader execution entirely.
>
> Are we sure they really are independent?  What does RM do?

This is not really about being able to reload the driver afterwards if
FWSEC-SB fails - in all likelihood we won't be able to, although that
ultimately depends on where and how hard FWSEC-SB fails.

The reason for doing this is more to stay consistent with our teardown
policy [1], which is to keep going even if one step fails.

[1] https://lore.kernel.org/all/b5fb1462-c409-4ddc-a6c4-a83dcfaeae63@nvidia=
.com/
