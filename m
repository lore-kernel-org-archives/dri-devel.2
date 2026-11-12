Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08BF606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 05:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZV1Ev34s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0610810E045;
	Thu, 12 Nov 2026 05:19:25 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012048.outbound.protection.outlook.com [40.107.209.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6143610E045;
 Thu, 12 Nov 2026 05:19:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHrUfTFtWgm7S6xL3akAVidFCpflfFNeiMT1WDGOkuU92Evj6lNgOVQWi2Slxq0gAVss6xPkXrB2F7wN6WibW9+UPlN7igPfkprcn3jewighySWgQh2BDDLXW/ka1IC1CCNeBghHIGJhUayILJdIxXUNVxGGABhidBK21s1xnq9GRlLqS2KK0VvykCigb+zH9FOYkhdY0/xL3MgNgAJBHNCbpWGL6AQK3YEU8SfdGbHZHoB3WjzMfPb734mObYSBFrzTJAfvhIEY/RIUVnnQ3/vmAhJnnkvHJBU2u4vyy8V54RywgF10TYCfONRJd5j8qvWeoUcdxNLj+oQVKKmcuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgDFk+wFpCUYMJKscTNCyvy1oWEzgE8QndWz1VSD780=;
 b=JQ76l+5rxxzgrVGKsS5PKKTSga9UR1HQXnph0u+aM5GEV4L5iNa0hGuRiMyKydMbJ4LUESK1+yWtQ35GfHPY9mC2hi2Ka9Rx1JSfnbkieCWh+tHWg933GsvPVzcsUqswkMZq6HhiRqClSR/Fq8UtBnMJJBcBBRDrEkfIL+9WEau7ovG1LqtwMyPDlSjkjlhfyeH5T0wMk3+OruZVkQMForzrgmrHovcfAmMx5/yb8hsb83C+jsMCDFLDcf2ruEi40sSV4kduQXZDoZx/cTXiOX1mzgRyreg5/kSg0fDFIaWe6uneNZWibIp1W/wNsqc5uUmgKjK9dX0fpL+DS2jxsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgDFk+wFpCUYMJKscTNCyvy1oWEzgE8QndWz1VSD780=;
 b=ZV1Ev34sCs0P8oE/bZSsFDyo4qdJD/B15k15FbeTkp1kbtFhK1cKUT4bSN/4sc8i0ndS4oAAD2+//PYQk+mKFzRHrfcqlqMEQFKTgkpddZBtrTgnXR8zqoSMHbT7iLf8w63mQHoxM08brdNuBpEW1B7c4KP1jmG2RLcEZRR7p193s5hyrpktbZOg10AkyX5GWevlP2IZGS/68QfVJQCLH6HFs5jxR+dVoDapKvt3Hru7rfoBf/9CqgcDS23rfUiW6WUMoXwn6dyAN6uwKLfSTV7ypNkhOAGoXB/NN4guAOAJHPCMIHAJtK1BuxevBVP5GRDZJDBND4Rx51KZckXl4w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 05:19:14 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 05:19:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 14:19:10 +0900
Message-Id: <DMSZ8WDZHACY.1PFMVNJHFRDC8@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: gsp: cmdq: increase MSGQ_NUM_PAGES
 to 64
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20261111-msgq-64-pages-v1-0-d8c56b6fdd6c@nvidia.com>
 <20261111-msgq-64-pages-v1-2-d8c56b6fdd6c@nvidia.com>
 <DMSGRDMGTD4J.30PUSSFQMZ4YO@nvidia.com>
 <DMSUNELHV29J.3P27BLAEVKTAV@nvidia.com>
In-Reply-To: <DMSUNELHV29J.3P27BLAEVKTAV@nvidia.com>
X-ClientProxiedBy: OS3P286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:201::20) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: 90456795-892a-4395-3cd8-08df407c7d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|23010399003|376014|18002099003|22082099003|261009223027099003|3023799007|4143699003|261021123027099003|11063799006|10067099003|261102123227099003|261021135927099003|261028144727099003|261026121527099003|261022105027099003|261026140227099003|56012099006|261021121427099003;
X-Microsoft-Antispam-Message-Info: 82YkbTJI3G9tSEDTFCcxdvrZ7WeR/uG4aR8q5mP36ymk3s2/m/tHnYurof6Ud1OdOISRaIV5JP3Fq3iXFYAgWFtgvNnB604FLyEG5kOdwzXEdpjcmNEldgK1V+NMpoZSNg9/cXxD6usrK8bYMhWIc2/DuPmGOEx7/4YVxsUSGdPpAIabpAL+P184r+LqiWrDErIYbYkY/m9IK5Bmtc94b3RIDliQRn9dUkB46tu/uOZVKbVioHcPf8fRV4h23mtHUYw+soJZ6Urq96IPKl6QLwL2fsrLn2pDNHDjBO5utY2wneHCwvkoQYatbTfOViRVjOidmaLR/Fd0ZA1VSrxtjBlJvxaQzB94r1SWguw73Q1mdu5d4G6fN2+21pCZo1IOBJRn2wbl4FUbjjQg6p+aINz9r+GfZAigXTmu1ePbUIPJehET5DLD7xx8ImTS5tINhYTJbjcOwEQEjWtM49nYBKuRRrQOyfkYiNEjykUu9RpFrO/iEkC9TONXqhHBkwmDYh+V//1kRszKorLlJ3fYpF00AT6FHesLbK+iIH6byUXsS/92xsMMe46x8lRZbhHR+mEJN+YgopL/YEpw00EUN/SNns8RuNWeYWo9yhCkdakr7KUElEmoEQvVimwcu8O5kqXnG8eHnF/8Si7Xuw7Cv0AX/i5iNd7tUeVC7l9Vz54=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(23010399003)(376014)(18002099003)(22082099003)(261009223027099003)(3023799007)(4143699003)(261021123027099003)(11063799006)(10067099003)(261102123227099003)(261021135927099003)(261028144727099003)(261026121527099003)(261022105027099003)(261026140227099003)(56012099006)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGRCVk5QMWR1TWFwTmZMK09lSnRxbStGUHllQjdDTGh5WWRwNDczSlBwZEMx?=
 =?utf-8?B?Mm9kd0tmYWVnSHhhN0I1QVEwSVc1VU1EVTJBVnkrZjdzTkJ1QUYzbGEwZGVG?=
 =?utf-8?B?b0I4ZnhVdjZ1a245Y01adGQ4L2wxK2I1dGRVbVNRSUNoWGtDV1EwQ3ZjdEN3?=
 =?utf-8?B?ZVZUQWl0TlBaOFY1eUczOElLbWVCTEJCNUppc1lwNURTMW50WEU2eXRXOUlz?=
 =?utf-8?B?ZGlZdEZJM09aNGRyVHNOazdoWXZKaS8vajg4UFBjR3hXK0RQSVViTEdrTWdT?=
 =?utf-8?B?a2l3VWo4c1hzaHBHczZNSkxrU3RqV1hmRXRXdWI3eEQ3WGRzTWY5R0NMTDlJ?=
 =?utf-8?B?bjlaSi84SkpJZkNKT2JvTlJZNkFNVUFqN0pvT3Fud1BhWUQ0WVc5cENvRkt5?=
 =?utf-8?B?NEpBVmtkMVNyeWJmYjBmOURzcE1GVFE5OUNVTkxWaHJzdEZlcjVXWk84R1Bx?=
 =?utf-8?B?RzVSNUc2TEdQN1RlVTN3VW9vRDlNOEdFbkVYRElpRDhjOElBNEYxUkJYQ3VF?=
 =?utf-8?B?bUR1SUJxVER2bjZQQWgyTXhKNWlrejZmQXBlWExKYXNJUkJJMkJNQ01kR3pr?=
 =?utf-8?B?bTN2Z2lMZ3grTDBiUVQyaWFVcW9mK1ZacURHQkcreHFQNmdVQVZSdENIMVBX?=
 =?utf-8?B?dHhPLytCTWxOaUIxck11Uit6YXRGejVrRVp6cGk4Qm9hWDE5R09OOU1scDRD?=
 =?utf-8?B?aTUxbnk3cUtjcHIxZi9udy83ekJ5WldSRWVNdzZla3BJbENTUHhMSEE2YUFZ?=
 =?utf-8?B?TDlJclhOcGs5Zm94MFFZY01nQTVRWkx4aG1kZSt5dlp3YVpScWJoM01WVDdq?=
 =?utf-8?B?ZUpIbzFRVlBIOERqV09ZSUtyTlQ5a25SZDhLdStOMCtsOEF6eGNLcHlKUFRL?=
 =?utf-8?B?cHRDbi92bHdxVDdTU3JrVVlpbkh1Mjd1OE16a1BUaFQxOEdxeGNVdldwa2ZN?=
 =?utf-8?B?cXczU1hGUm5SUUsxTHZ1S3lMcFZud0IzYWJpUHlaelBQcFg1ejFnWHZ0Y201?=
 =?utf-8?B?Rk5iTzVTRVVnN3NPNGhyUFZGQm5udEtpWExKUXBETHZ3NHZ3VndQSmVzWGRv?=
 =?utf-8?B?enNISnFxZTlpcXNKOTFHQmlVZEpQTHhQSzlDQ1JnamNWVE5uMU94SHBKY3Y3?=
 =?utf-8?B?a1FuNVpCZmxFNmwwL24rNkFqeTBZZm1HVGYrUmdBVFpLaHkxb2lheGNZT3ZZ?=
 =?utf-8?B?NC9RMFcrcWJpR3lRbC9Td0FjOFBkOGdlb2x1b1NOc2VvdVp1blVXMWZ6ckdp?=
 =?utf-8?B?b2x6aGcxRE1DUzAySEFqYnJ2NkVQdzFpMVA2NitrWDgremZteEZTMlU3REFB?=
 =?utf-8?B?T0IvdmFWSlQ4UHJaNFZtdCtFbU9JL2QyTVU2M052My90WU1kMVFVNTZndFlL?=
 =?utf-8?B?RC83K2dXbldyb2hud3FucXF6MWpCWWF1ckFGZDBuakNySWpNS2JKNEFaS2po?=
 =?utf-8?B?TXYyUmcrb2tuY2ZTbmhDNTB2S0pLajlFWlBTaGFNQjFxMTFIcVBFNnExQkJU?=
 =?utf-8?B?Ymlzc3lGbUd3RHVtL2o1eittWWNsdllrZWQvdDBjZDAwY1Qrb0k1UnJiUWl5?=
 =?utf-8?B?VTY1Nkk3YlM0VmhuOUlsd0RVMFdpc2owUDFwT3RWd1JUSEhUMHVFSkR2cDhF?=
 =?utf-8?B?V0lnTStiOFUwaEpLaDlaZmIrY1MyRDFTRUpkWHNqUU9QWGtJN0FVSE5DS3Jn?=
 =?utf-8?B?WmFDaUNMWFFiSWYrQWF5b0Q2K1FKaVZFN2I2d01IZXY4NG9CYWViYVRGblFs?=
 =?utf-8?B?aHo3WTZIYVpBMG5tOUNMclhuK1pmWGh6Smw2cEx5SEZYQWxPWHIyaERReERQ?=
 =?utf-8?B?YkV4ckpVNlVOOGs0cllMUlBxZ28wWUpIUklKL0dUQWtJcnJ6Wi9oRFRtK2hi?=
 =?utf-8?B?Zm1HQlNWNkhRT0dFTWZCQmdxOHZFRmhvM3g0enRJRUhWMVdzbGIxSENEODFy?=
 =?utf-8?B?U0Q1NFRzL3h3UlBlNlNmUzVmOHludlA1NGtTemNWeXNZMFlKK0syTHRUTTNS?=
 =?utf-8?B?NlkvdlFCTnJod2NYbS95cEE0WHgrTVE3cndvcnY0Y0swZ1ZWclVYbXdMOVYy?=
 =?utf-8?B?Tlo0cEF2WGlzc3VEUk00SEhLMTdYTlZZZ2JWdXhRYkExckV4OHAwQVhCMkJL?=
 =?utf-8?B?bFpSUG1KUGZlOG0zTlhkVXN4Tjh6NktnK1BLNVpkWTBibWpBUFl6SlJ5TWl3?=
 =?utf-8?B?MkVwQzFPdUh4cEVicU5FSzVpeUoyYWRuMDJLTFdFMTBNNW84aWZhcXV5RFli?=
 =?utf-8?B?akIyUGRhQ2lPb1IxK0NhRSt1cVhEMnVmdXI3WWNkUVBiR1Rpc21NVlVGK09X?=
 =?utf-8?B?eFhuQ285S0VXcnpaMVBJMjlWSWRpSi8yOTN0eEU2WmU4ZEU0VVI2VkdaNnk2?=
 =?utf-8?Q?cu3hiV0OfkkvP6YsoDHPS4Il+zFwCrDK4mqfhcTWh6fG+?=
X-MS-Exchange-AntiSpam-MessageData-1: 7PCvmmfE0TUrYA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90456795-892a-4395-3cd8-08df407c7d72
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 05:19:13.6953 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkXH9j9Yoh6ORdd/dw2f6QqwZKDgsUdM7R4rfp7rH3LQIr1J/sasKzS7iZePRUsEkHbNWBW9ACKE0VTb9BdGqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6280
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 10:43 AM JST, Eliot Courtney wrote:
> On Wed Nov 11, 2026 at 11:49 PM JST, Alexandre Courbot wrote:
>> On Wed Nov 11, 2026 at 10:37 AM JST, Eliot Courtney wrote:
>>> In the msgq v2 protocol, which the r000 firmware uses, the queue
>>> pointers are kept in u32 registers and increase monotonically until the=
y
>>> wrap at 2^32.
>>>
>>> `MSGQ_NUM_PAGES` is currently 63 and does not divide 2^32. This means
>>> that on msgq v2, the slot can jump backwards when the counters wrap.
>>> For example:
>>>
>>>     (2^32 - 2) % 63 =3D=3D 2
>>>     (2^32 - 1) % 63 =3D=3D 3
>>>              0 % 63 =3D=3D 0    (slot 0 instead of slot 4)
>>>
>>> The writer can then overwrite slots before the reader has read them.
>>>
>>> Increase `MSGQ_NUM_PAGES` to 64 and check at compile time that
>>> `MSGQ_NUM_PAGES` divides 2^32.
>>
>> Have we tested that this was also working on msgq v0?
>
> Yerp I tested boot on turing, ampere, ada, blackwell.
>
>>
>>>
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/gsp/cmdq.rs | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/=
gsp/cmdq.rs
>>> index 33074bb53e8c..240ab42db557 100644
>>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>>> @@ -84,7 +84,15 @@ trait CommandElement {
>>>  }
>>> =20
>>>  /// Number of GSP pages making the [`Msgq`].
>>> -pub(crate) const MSGQ_NUM_PAGES: u32 =3D 0x3f;
>>> +pub(crate) const MSGQ_NUM_PAGES: u32 =3D 64;
>>> +
>>> +// From version 2 of the msgq protocol, the queue pointers increase
>>> +// monotonically in `u32` counters until they wrap. If `MSGQ_NUM_PAGES=
` does not
>>> +// divide `1 << 32`, then the slot, `counter % MSGQ_NUM_PAGES`, can ju=
mp
>>> +// backwards when wrapping, which could overwrite slots that still nee=
d to be
>>> +// read. So, require that the last counter value, `u32::MAX`, maps to =
the last
>>> +// slot.
>>
>> That's a pretty convoluted way to say the number of slots must be a
>> power of 2 representable as a u32. :)
>>
>>> +static_assert!(u32::MAX % MSGQ_NUM_PAGES =3D=3D MSGQ_NUM_PAGES - 1);
>>
>> Same here, can't we use `MSGQ_NUM_PAGES.is_power_of_two()`?
>
> I actually had this originally but I think that this form expresses the
> condition more directly. The condition/issue is what happens when you
> wrap the counter - it should go to the next slot (which necessarily
> needs to be zero since a wrapped counter is 0). So you want
> MSGQ_NUM_PAGES to divide 2^32. So if you write
> MSGQ_NUM_PAGES.is_power_of_two() you are implicitly relying on all
> divisors being a power of two, which is an extra logical step.
>
> But in the end I don't really mind, so lmk wdyt.

The current condition also involves an extra logical step. What you
ideally would have tested is

  (1 << 32).is_multiple_of(MSGQ_NUM_PAGES)

... but as `u32::MAX + 1` is not representable using a u32, the one you
chose is the closest one. It does takes some extra labor to understand
what it intends to convey though.

Trying to put myself into the shoes of someone looking at this code for
the first time, this comment and the condition look a bit hard to chew.
How about using a u64 to test the condition we actually want:

  // The queue pointers are wrapping `u32` counters, and the slot is
  // `counter % MSGQ_NUM_PAGES`. For slots to remain contiguous when a coun=
ter
  // wraps, `MSGQ_NUM_PAGES` must divide `1 << 32`.
  static_assert!((1u64 << u32::BITS).is_multiple_of(cv!(MSGQ_NUM_PAGES)));

(I have removed the mention the the msgq v2 detail - it is useful in the
commit log, but becomes unneeded information in the code as it
eventually will only support v2 anyway)

WDYT?
