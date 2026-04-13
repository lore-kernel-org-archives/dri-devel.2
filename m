Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C43EBFD07
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CE6110E32D;
	Mon, 13 Apr 2026 07:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rybp0201";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0786E10E32D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llNgWuXJQQOxfNQhkBU5Lj/qBP3D2HVQ78bseN3QR91V0dfuzQzGJiK5vqhtR2vnCnadT6A1IoekBm1+9CgwDrdbBaZSvl7f6xMEqoKZjcJqKjqHhR8ey4pGDjRdQEmub0B9JextJogUMIpPEIlGYshO4NX68Ud9QRvhhDE/K/aHVSBagYeF9eVdJQBaAnhzEXoFdZlGE+njU3R0udJZqvv14t6cmOGyedUcazY0KKKSS+bTjITuNaTsxaELI/dtefPz6IF8vCcBr7RRoOHE97k7W6YOyyQtyph0I42Uzysln4q2qP9Q1JqVx9dxuaqgMFqRYwOuvdqdOooFQ029KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H40B3mLccYI9r83lSrulSd6rb4l+EWBIBtf4Dm5p+Dg=;
 b=lHUFDIBxUYk3gx/8NdxjhEO+oNS89Y6l2olsq9vKweN7NVdR1kz7mlLeDSC+bImzSvFTsUMD485QQ00F5uiMxHDunIhsisQTmTRYz+dSAvPmmKND/FgQfdk5py7EXa3WnzK6Jvx/UdwRLYOtLzoCS0UzRo0PkVxPldKtpozvjxnmFHfp4FEdDeBW2c8kGyrruLOwILG6rqjL0qgSLe1nqMUNcyquYwETGdVOYzPs1tyLwjlYvF87jmtD2ni23P7jfoTbn1tXHL1NZGc7ogF7alqAOd/2QZrmhTwz3f9vOoPkrhT0oE1Z6pWRsYwLy6Or45b7pbIfy108rQ7tQ2dVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H40B3mLccYI9r83lSrulSd6rb4l+EWBIBtf4Dm5p+Dg=;
 b=Rybp02014dw7DXXo7OPi3myrrYqbmNtEPbGDTGW/h9ajptw+i1/eR/J7kBo4Fm2cEFYtO0ATiNHAnZ1eKAHCGYwZO/z0kWHv9vUcK8IobNqx0fVcXKbXhofYGgxanqfTAzMhPYszZyZPHNtOyY7W0vdJRptb4Y5fyKpUs2x0P76NUBUvdsc7FbhYfaaCV5WkfMUiAdqtjp8y5tPHLT6+2o0R4cLbSEvhYYYoUMRDdE0SQ2ZKmgNLJRdKDKAXXENv+besFfCYcpgz1Y+6oxN7V5/w6rWY0YDtsf0nehFUxKAqsQGyw5U2xREbnp/CdboIZJhPOnNCEnM6bjU0acH51w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SN7PR12MB8145.namprd12.prod.outlook.com (2603:10b6:806:350::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 07:10:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 07:10:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 16:10:25 +0900
Message-Id: <DHRU81HM4D1V.NVTBVV8BEG2W@nvidia.com>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] gpu: nova-core: vbios: use checked accesses in
 `setup_falcon_data`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
 <20260410-fix-vbios-v1-3-bc6f71d153d6@nvidia.com>
 <8bf30537-de54-4be0-a676-3e8aad6fb312@nvidia.com>
 <DHRSTLTQNYTB.1ZQO8FBOU678Q@nvidia.com>
In-Reply-To: <DHRSTLTQNYTB.1ZQO8FBOU678Q@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SN7PR12MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: 255bf87b-3403-4433-b819-08de992bbe62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: yR93+r60gTBLWvfacouxb0PXtPiEbrT4r/kfX1Mj/5XQwkubFcf1bJRkOAFby28Top2szQ9vlKuOJZ6UfDs0Sq8NP7W46AmyCk3e+vgTpqobDuRiOFNFIWQb2uEFnplY80AZmVJe7O2jaA37LhHmrGqPb2qogv35qJydEazy9Hc5iNo3zbi4/5NfuANJ0RGp1mfbspBBckLwGFx0DCeUDlhgH9KTEto/WONYE+gOuBUpW2rTQT4VuoyhOvKC5ga0jX3KFDUpelvWAdVeF6QBmtQgVN5caUnGdHg3c9fIdfsQ15lIIPGBdtfPqoqjTN59yOGRxaRDO8NiPIkJiBgphSjqPrrbNfHF/+M2VZ3PKnBo5pfUetroVu2ah/mW+cqKGxbzj8QJPeoMuFoF86MomJPMFhsujYPMtc9yZQ38mc5Sr9P5rcTB9HHW8QAX18UOm0PKabWRf5IGTYpMa4a24paSvUlV3r2TQHf0XDIderpCjHed8laVl3paEm6HHburO1jN3ATBeJ8CCxlbGSn+UERIRHBnyAWw3p+o8vF/MUfOB2JzZOTWQK+XMRav7c6LLOs/+mwH46FjdVCn45eRxuVP4idIXLuq5TA3VHdNljw0NsAFFo21nHe7Ou0OQE57qlepN96OFmIi85QKX3HissiqoJ1cNux0uT9tmg4pZoi25rY/EuPtHgtyWKqADnmvy3KgpKzlW7NWLdAG6JjwV1ybAAQt98d9oPHgRCa3wtc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVE5aGxsS2RxT094WWxLbWFXcHNUZUprUW9qTTZXaDF3MEMvN1ZRcWloRzhz?=
 =?utf-8?B?V0sxQXRBZUpvLzBNSDAxRkZHNGtIZ2NFMjMxcTdjSjR2UEQ0OVUrQ2pieWlv?=
 =?utf-8?B?ZERjdU4xelhrYzBMYnptbjAwREc3bkxmV1BDODNiOVJjMkhlTW54alVwUjJo?=
 =?utf-8?B?MUllVG5FYitIeHhGOFRjbzdCdmVkMmZmNm5mNG5WMWhZbDRRaE5QdG1CdGlp?=
 =?utf-8?B?ZGEyem92V1pRZm50cjQzMFdnNzVOSWJjY0xTcHcvMjBWRExiTTU3UFp6Yno4?=
 =?utf-8?B?eHhOdVJvbm9DYklZbG8rOXVyWkZZTXFyUmIzM01rdWhseGpuUWFsbkpCMEJw?=
 =?utf-8?B?aFFEczJIZ281WlZZK3c1Ym8vN3lmVkFjVDY1ZmV1Nm5PcER4dDRWa21vSDhN?=
 =?utf-8?B?czJlK1crUnJzRkNCNTdSS215T2F6aFN5elphZTF5QnBQK3pIbE45Wjl4K0NQ?=
 =?utf-8?B?QnJOSnU2R2ZieWxlendNQzNjeDluaTZwMmdFaS8rdHNMSXlyZFhoTG5aRW1o?=
 =?utf-8?B?WU5oNnNjM1MyZU1MdVF5R0dYWk9yOFFoZnNJNVJDcyt1dHc4c1V2aCtXOFZ2?=
 =?utf-8?B?VU16OVduTzdKVCtpdG5PWEQvNnN5N1FyUWd5eW5vdHJ1ZTF5QzN1Wi9id1NU?=
 =?utf-8?B?VkJJbTRMUUNMN01JSlJpVllBOFNKRHdHTmdyQVliTE91R0c1N1ZoblJjY2J5?=
 =?utf-8?B?eWx6U3NaY2k5UmErSlkxaVNkdmVPK1ROZ2RPd2tkREZvbWp1MG1SWDN3OTRK?=
 =?utf-8?B?NUpXeFM4RnBuYnM5VzNkNmpIUHBUSy9LU05JSmVRWW1ZTVZrQUxjalU0TGZx?=
 =?utf-8?B?QS9Rdk9mdFN0OW55bHBkTjZFZHBNTWFhS3djZ3ptSit4czJZMWd1d2dobGZp?=
 =?utf-8?B?cWl3Si9OUGlTZWMwYVYyWnFHUkl4enRXRjdPTmZMOG0xWEExcnovb2thTnYv?=
 =?utf-8?B?dCtCNThmOEl6Mm1uQmtmM1hyK1EwdWlTcG8wOXY0a1ZMWWJwOGhqeklvODEz?=
 =?utf-8?B?NnRNTHk3REVmTDNwc2lMb2EwUTFlS0NHOWsxcU9Da3d3bG9Qck9qSjRVcGJa?=
 =?utf-8?B?VEpnR3liSkhJYWdsRUZGQmxPZ0ZkeEpxTkovL2ZGWk9IOHN0YlI1TFpyVWpm?=
 =?utf-8?B?OW13OXBWZFVtTkpVMjVzd04xcHBhd3c2M2ZSS3B2UEVENG9FV09ZejZxaFdr?=
 =?utf-8?B?TGR0ckhaQnVJOUZOWUR6bWFwWVJVR2hRQnZjR1AzVW4yTlZxdjVxalNtbUkv?=
 =?utf-8?B?UTFnOEllaXoxM1lsVk1rZnh4QlZZZVhQVzFQb056c0dXSXpsUVhaWnA5YUVI?=
 =?utf-8?B?M3ZBNGFaZXJhVlNtbi9oZEpmbkxPN1lWeld2MzVwbDV5bXFVWlhFRXdCR2VC?=
 =?utf-8?B?MkxyOHpaWit4REVac25vYURnVjcxTXNDTklqZm13NUlVMlQ3alQrYnEwdUxI?=
 =?utf-8?B?dEdHU1FSam5yUkdyMUlWU0hkZEZlYWhiVjF6VjVrRW1iQVJIaVYrOWtmQm9G?=
 =?utf-8?B?R3RBblNWdmNjQXdIaVI4b2dTL0FsL3cvQVBvUVhKVXFxMlhBcW9icFYxZEhO?=
 =?utf-8?B?MnRoY0tCSUZ3akhXbXdpbktVZHVYUkY1aTVyUTEyM0haVHIwdzJtUEFhNm1L?=
 =?utf-8?B?bFBVMFZhc2tTZzJKZ1BlLzRVUndqTW9nMkhSVk1Kc2ppNTNrNVJyd0dBSUg0?=
 =?utf-8?B?aFVFSU9PTEpvTmdQZ3lMdFFwZVhkdmUwYzRoYytpODc4RzlpWWtMa1hKeHh0?=
 =?utf-8?B?cVJuYmMrMmsyTEZJVjlZc2VmT0lVNFdXSzQrdktvR2hJTFA0Vks4SFFBZWd5?=
 =?utf-8?B?aXVqeTJpME8rZlVCZXZaOCtWR253US9pT2NJbXhJNzNZcnVzLzVkOVZzaUpG?=
 =?utf-8?B?bE1odzJhZWV6ZmVUaDVZczhEK1A5VU1KWjM3TDZWQjVUL0p5eFUvRmoxVXZp?=
 =?utf-8?B?azhFRWdlTkh1Zi9CQ29ObTdVaGdINjhTWlVheVIrTHlGcWl1VEEyUklRU2hD?=
 =?utf-8?B?QldyZUZaOFhuQWJPaERyV28zMVQrUVBuVjNvMDNiU0Q3MGQrNnpaWDZXNVNt?=
 =?utf-8?B?WUVGYjVGRU1yWG1sTVROWG5JeDQzeG9DUENGeEd1ck9aei81R2ROWElMNmFi?=
 =?utf-8?B?ckxTdXFaRisxRFFOSnQySW9EVmlYRE83MDhMUXNEbU5CSDRKL1BNZDdabjRr?=
 =?utf-8?B?WFlKTEsyWTNsSUFpQ1JHbU5WZW90Vm5TUDRhbGViRlNwVDhybkxPeGhUbVFy?=
 =?utf-8?B?aUcvQzZEZGlBclNKRlRyMmR5STBkYzVlbjIvS0Fla0YxZU9EUjlRRVM3bitj?=
 =?utf-8?B?SFY4dGxvKzhpa2hPVk5pUklITkpxRThjVjQrRWUrS3lpcE1QZjFNQlFzQ3Rv?=
 =?utf-8?Q?IsCpfLOPrV5grAmZuat6+aqG4ag7vluq9jTKAxjnAr5Bf?=
X-MS-Exchange-AntiSpam-MessageData-1: 1+Void9tf/6djA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 255bf87b-3403-4433-b819-08de992bbe62
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 07:10:29.1981 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLy13fQ8gRaUvtUypRcckm/D+Z9XRyzL/8rJKhlGVnlhFRNU3b9tOc+YFfLy68VTOs2v9VINxpG8bSTSVetG/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145
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

On Mon Apr 13, 2026 at 3:04 PM JST, Eliot Courtney wrote:
> On Fri Apr 10, 2026 at 11:53 PM JST, Joel Fernandes wrote:
>> Hi Eliot,
>>
>> On 4/10/2026 4:38 AM, Eliot Courtney wrote:
>>> Use checked arithmetic and accesses where the values are firmware
>>> derived to prevent potential overflow.
>>>=20
>>> Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU=
 table in FWSEC")
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/vbios.rs | 20 ++++++++------------
>>>  1 file changed, 8 insertions(+), 12 deletions(-)
>>>=20
>>> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbi=
os.rs
>>> index de856000de23..2b0dc1a9125d 100644
>>> --- a/drivers/gpu/nova-core/vbios.rs
>>> +++ b/drivers/gpu/nova-core/vbios.rs
>>> @@ -936,17 +936,12 @@ fn setup_falcon_data(
>>> =20
>>>          self.falcon_data_offset =3D Some(offset);
>>> =20
>>> -        if pmu_in_first_fwsec {
>>> -            self.pmu_lookup_table =3D Some(PmuLookupTable::new(
>>> -                &self.base.dev,
>>> -                &first_fwsec.base.data[offset..],
>>> -            )?);
>>> +        let pmu_lookup_data =3D if pmu_in_first_fwsec {
>>> +            &first_fwsec.base.data[offset..]
>>
>> I suggest use get() here as well for consistency with your use of get()
>> further below.
>>   first_fwsec.base.data.get(offset..).ok_or(EINVAL)?
>
> This one has a local proof that it won't ever OOB, so I didn't use
> get(). Not sure what the convention is, but what makes most sense to me
> is to use get() if there is no local proof that it will always succeed
> and use [] if there is such a proof. WDYT? Do you know if there's a
> decided convention for this?

Ideally we use the type system to maintain the proof that OOB cannot
happen - typically by calling `get` early and working with the returned
slice from then on. The problem with this code is that while there is a
local proof that OOB cannot occur *today*, there is no guarantee that
this proof won't be modified (and break the invariant we rely on) by
future code.

Looking at the code it looks like it deserves a larger refactor. We are
setting `pmu_in_first_fwsec` if the offset is valid for the first fwsec,
and modify `offset` if not. Then we check `pmu_in_first_fwsec` to get
the PMU lookup table from the right source. And after that neither
`pmu_in_first_fwsec` not `offset` are ever used again. So this looks
like this could be factored out into a single test (maybe a match on the
result of `get`?), where we simplify things further and don't mutate
variables. Things tend to fall into place with properly guaranteed
invariants when we do that.
