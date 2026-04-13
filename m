Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585CBE9381E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 06:04:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F0910E11A;
	Mon, 13 Apr 2026 06:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SVjVcNUP";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 752DC10E09A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 06:04:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEI/z9ZKXXK/+9pn8o/p9NRyusvgyQayuneLOKMy8IO3J+M8G90gSUz2jb4Y+3FwrZuGcxaUNLjWeXHozypjtVr+aQFBYAoqtj51PpODR6KHVR+QyifvCHUivgGVMaxc+ojx0KpSk8Rv97R17L9QVE3fAriK1aRbjNdGNBvnU9lD/qF2xd1137365wEYcq3Tht7i2ptcqLunyymzvW2nJvfZzfEMYW7erFYkrdmnHyLUAioRcWTW57o4ziX29Ny4ZasfnhwPnhrxfgioLoS/hFbkiI3pc6fXpPXjhiQR+cOE40wMW21/QgXCgTn5LGQJ3keSUu+u0j0kuK+PVfs3Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGzv6CHxE4KGD/bKmbJElx4nIE0bydhQY1oPD+qVy7o=;
 b=rXDygPHhFjsOIPZ2BS9kmxBIfrihDvBpHHW84IART23pbp18dv0C/UZ4POQCTOBxSfcsDlWgMpgaNt1j0MqpCptdj02dbRSziZkEw03pAg7j+T2Wxpu7Fyg6bEWkLKn41qTL3SmUlzVzzw1MvJPcrF8cRE2NuFxmpKY6YDgEcr9NWiGxlypfyBW8FyNS6ULcIolWUicDzZJghzVNIQ9uCrKhTleiqg9BO+bP78uJp0p9j745FwrEbYRxqiJrFMg/u6hzPnbHiFMUt+KoOI12EUFA7NM00vK6YQj66/AbtFpGaYFRiLCgYdxXI7wNdCdD5N+8VrhUZ5JJ0m3iIfISyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGzv6CHxE4KGD/bKmbJElx4nIE0bydhQY1oPD+qVy7o=;
 b=SVjVcNUP7OyHTFWPor225uugTpMxjeHc+KFCXfo1Laea6UbZi0VkfL44HTHv0nUUqaxswfiAesOJ+ye31jBxlg6Lx68+LIXCzmfMXkygcH+SFyWQW8mjutizvYdnHn33/Ex4AAm32080F2SkHHBAQ6GuHq+uZo59KtPrqHcbNeKXVamWYpgvxpqlnKAptJro02Wp+b08FoXMvmUapBHawCVDsUMlpqAb98IIH2Ls5CIF6lsUOmioiyRUh+XJ4VHcnLBVW+O0gHe2tIz1im8Z3S9ACumB/6A8Xc4sJeTd5NVtAXlh37NTT1X5+PzJU9Di2SY18Do07BFC4urrAr5e3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Mon, 13 Apr
 2026 06:04:37 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 06:04:37 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 15:04:33 +0900
Message-Id: <DHRSTLTQNYTB.1ZQO8FBOU678Q@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] gpu: nova-core: vbios: use checked accesses in
 `setup_falcon_data`
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
 <20260410-fix-vbios-v1-3-bc6f71d153d6@nvidia.com>
 <8bf30537-de54-4be0-a676-3e8aad6fb312@nvidia.com>
In-Reply-To: <8bf30537-de54-4be0-a676-3e8aad6fb312@nvidia.com>
X-ClientProxiedBy: TYCP286CA0258.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 113dc2ff-8057-4d30-1bb7-08de99228ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oK4tiNhHx6RMVuLCuUH2q5QYFH3P2brnO0f/ddOsgg1DYqYNn3SYKMxdocyDWyx4ypfGH8ABXQm3JAmHLjArs1l7fkklh1utRyNhxLu7q8+FHb/APKnEfinIbnQE9dv1OU5I+Wj8bM7NF6QOJeBA/+XDMwkkcJb3y/CQ/ci+PFANT5KvzFJTuU3fl4BX1J7kJNdBd9/yQ8ru40zy7T2O0lZrM1S88iyWgoMTONIVGfg/fdE2vW+77RdXL2aY3BGWlG7MX7wKIWaz2k9mr+ZZqPqYAwEX1okeJZrLaXBXo3rUC2NihTRDLOg77ofzrWGKvvgVEuccG5dUO0p9I6/0hdXCKLJmsVcY2yhCmuSk8YYD3/IltejVfwIjfil9BssbXUSwLeKEciTsyaMGWBHG3o7v9s+cxxqAM1b7fjF5XamyofxgspjJgPNll3IaIaY6YFfpIRYHw9keD+AWvk5kIykZbHb1o8DEuinEIshwrhxtPY/KW0VUZ+4cclDx7/I7FAO9+IECXxcsgV2lMAmmB+9PojAJy6bbTQdZp43gn0pKR1jtMC0T5mveY9ryZfcJbmjBTWwp3q/2/NQs1m8Vz2ZMkboirfR3w47jZ8wuCZNSTcjXy5jL/J2itVDDK0suL1LxeQlSHIMDj8jC1zORPDRV6/GQKAV1GrnxUpLB91sW73S7S+eT8IdBMjqGl9+VeTjUwsboZVQHr4Bl8uMsFfG1T6JV10hMQoEWjCtSyas=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXdJVlB4OS9ZV3RCaWRtaXFzVVZYMVRvNm81NFBBaE03YndhZk4rM2ROYTBa?=
 =?utf-8?B?aytPVVpza214VDczeFdtVU5maUNIWUVVdkFQbWJhSytLWU1QajBUUVZGYXBL?=
 =?utf-8?B?ZjNHSjF5dElSVnhadFE4NkRzbEFpYUVRZkdzL21haWNUY3IwVE52UjVzRFhQ?=
 =?utf-8?B?dHBPR1JTelZBYnlzczlDMkFBdWxZOWx3ZjdpaG1oVE5OemRFVXF6cWdEc080?=
 =?utf-8?B?V1JHQTlJZDRpSld0VGg2OUlsdExvd3BzcUV4T1R5TytEdlk0WlhLKzhidm9H?=
 =?utf-8?B?YTNsc3Juazk1OTRROTVpalkrL0gxWDloT0dIYjBqd2lmSnlGU25mL28zZWNu?=
 =?utf-8?B?SU0rejVxZ0drSDVoZTNSQlYrZVBVZGdRRUVleDBnTTRzbHZvOEVBaUltKzRk?=
 =?utf-8?B?MDlZbGMxbWd0SVpiVWdySEhJWURpYittWjNiMHVqUXdqV2NCQnJkajFteXRF?=
 =?utf-8?B?VkxvaU95RTdhUGlkZC9kN0FFUER5MlVLSDV2Qlg4R3A4WThaTWlTUWttVXJP?=
 =?utf-8?B?MDR0UHc2cnNkN1VSeGVjMGM3ZWIyNWZjWVdSaDNQTFREbE92bS9BVDh5MU1T?=
 =?utf-8?B?TXhnZGU5bURmRXBPUFJDUXhiWk1BYXBqMmhDZExjY2dHQjYzUmt1Y2JqdEJ4?=
 =?utf-8?B?bWFIcEpsZXcrZXdlVzVXYnc1ZFh2R2drdTByV2h0SzNLZXFxZG5GckZFMmhQ?=
 =?utf-8?B?bWpwNUFicXJpdjV1RUpxdWdDWXpKSXpwSmNEL2FaOHEyWDlRQ2hhdXVwM1Nl?=
 =?utf-8?B?aW0vNzUzT1U4Q1pWT2hsQlBoaVQ5TERCOFRnR2VlWUVKYS9FTmJQZUZoayts?=
 =?utf-8?B?R0k4SDJPcnliZHlFUEtZVkZtd1hISkorbVRjUDBPcjhBZXlqU0FyYWRCUHpm?=
 =?utf-8?B?bmNTUHNkb0IwQWxQaUhzYmNTTml1MytuQk95bXhrbVBieE1EZnlBMnBJcHY1?=
 =?utf-8?B?a2xFdzNReGZiN2RDbU1LUjBMemdtQ0RXVVhTT1Z6aEk0eEZKUWpEaExybVFR?=
 =?utf-8?B?Nnp0aEpxaWp2bWRnQXpUVGxMT2diUXpobFl5cjFJelZOa3ZhOW5Ua2lQTTNX?=
 =?utf-8?B?U1pPak1aaWhzazZvLzFDaUlRVnBXdkllYmt3aG91ekpUR0R3ZGlQUko1MmlN?=
 =?utf-8?B?OG91ZWM3KzI4b2c2am51eTVPTVFyWVIyRFd6cTdtRENrbGRFbURzc2tFVENu?=
 =?utf-8?B?NTFtN0tFUy84NWZIWGpkWDd4VGtOV243SjdPZ1BpeXMraW9LR2NvdHB3cmZJ?=
 =?utf-8?B?SEJZSVdzZ2txakxTUjRITFo4N2ZXM041eG83TDV4d0NCNGVLQnFEUG0wWE9R?=
 =?utf-8?B?dXY2S0FtOW55RkFJUjhSZE1qY2U3NXZUMng3UFVULzJuN2xQZ1hMeWx2YW1G?=
 =?utf-8?B?WHhJSDhOMmhWMkZQd0xoaGNUQlBjYjFaeDhrK2ExQ1lQeGdiSjU1aGVYcWFQ?=
 =?utf-8?B?emJZbDc5T003cmZmRUZJL2dXY1VDcUk2QkttQkpNVHNHYmJSK2YrYnlrd2tI?=
 =?utf-8?B?ZnpXd0lQbWkrb2dtdHFyY2cwbk5nai9NZVdWU1JhVmxUTGVBa3MwTDJ0UWV1?=
 =?utf-8?B?RFpmYmYxdGtaOW03TytWeG5qdm5LVDZSYWZBcWovSnF0WDUwdFlrdXJIM2xv?=
 =?utf-8?B?d2N0UUdvV0MvNXY0Q0pBWjVBblZhOVh5cnR2eGNNZjNBMGVxSXBFaVl1SCsx?=
 =?utf-8?B?aDNjMm12MVJPRGIvQ3Ntb2F1Q3NGRTlwTHNZelRsN3FZVTFPOEhNd2Q2eTVn?=
 =?utf-8?B?RjcrRkVwV3ZubVltdThDdTJGTXBrd1pJLzJkNTduc25Oa1VHa1VIR0t1YXlp?=
 =?utf-8?B?Q0RtSTZDd2JJZmFrRjA5aUxVTStsbENlM0hvaHBSTlRRTmgzck9NS2E4VURn?=
 =?utf-8?B?NWY5bWtBelBiaXpzS01NUTREZmlCd3ZXS0ZZTk1JNTA1RDFpK0JMc3N4SEZL?=
 =?utf-8?B?YmZyQkMxOFhrUXl5dVNMMmlOZjhkakFsdWhYS203cnA1N0d1VHJIZzlmcFVY?=
 =?utf-8?B?Mnh6R0svQ2NBL2o5SStPVUFWV0RKeTMvRXFkYXdoMDZUd1VwNG1jc2hkZXJo?=
 =?utf-8?B?UzlZcktNeVh5ZHRVSDVpV0NXb0NldkdpZ2VxaWpMbnNWb2h0bThZVGVLay95?=
 =?utf-8?B?ZkdmaXU0dmRyN3dkbzc2Q0UybUpRb2VFcGdKSk1qR0NTNXdWd3hEMGlXZjhQ?=
 =?utf-8?B?WVFHSW9MSTFtUHJubzJOV2NJK3FsYWVMaHhQMW9OUFRCQlp1MHpmbHRIQTBD?=
 =?utf-8?B?ZStpblpVR2QzYXU1VG5JWldrbFlzbEwyejg3ZEJLVnhRQ3ZEbHRURXdXbWYr?=
 =?utf-8?B?TC9pS05LVlZ2ZjVJV2dnSTVDR1ZQVXg2MnVuK3dDcXcrcStTeFVOSmlqMm9G?=
 =?utf-8?Q?obJ7JnXH3LFazf/trmV9gj4HK9rZjZ4t6QDA/ksw9Fivn?=
X-MS-Exchange-AntiSpam-MessageData-1: OUGgFZBEkqmqsQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 113dc2ff-8057-4d30-1bb7-08de99228ac2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 06:04:37.0767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XJAvaJAO9RZLDMmBDDZMTzvfApso4cner0uuc4YgGyCG1juB78Edht7YfTUvVaz4rbTadbILzcrlvhSilJhhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702
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

On Fri Apr 10, 2026 at 11:53 PM JST, Joel Fernandes wrote:
> Hi Eliot,
>
> On 4/10/2026 4:38 AM, Eliot Courtney wrote:
>> Use checked arithmetic and accesses where the values are firmware
>> derived to prevent potential overflow.
>>=20
>> Fixes: dc70c6ae2441 ("gpu: nova-core: vbios: Add support to look up PMU =
table in FWSEC")
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/vbios.rs | 20 ++++++++------------
>>  1 file changed, 8 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbio=
s.rs
>> index de856000de23..2b0dc1a9125d 100644
>> --- a/drivers/gpu/nova-core/vbios.rs
>> +++ b/drivers/gpu/nova-core/vbios.rs
>> @@ -936,17 +936,12 @@ fn setup_falcon_data(
>> =20
>>          self.falcon_data_offset =3D Some(offset);
>> =20
>> -        if pmu_in_first_fwsec {
>> -            self.pmu_lookup_table =3D Some(PmuLookupTable::new(
>> -                &self.base.dev,
>> -                &first_fwsec.base.data[offset..],
>> -            )?);
>> +        let pmu_lookup_data =3D if pmu_in_first_fwsec {
>> +            &first_fwsec.base.data[offset..]
>
> I suggest use get() here as well for consistency with your use of get()
> further below.
>   first_fwsec.base.data.get(offset..).ok_or(EINVAL)?

This one has a local proof that it won't ever OOB, so I didn't use
get(). Not sure what the convention is, but what makes most sense to me
is to use get() if there is no local proof that it will always succeed
and use [] if there is such a proof. WDYT? Do you know if there's a
decided convention for this?

>
>>          } else {
>> -            self.pmu_lookup_table =3D Some(PmuLookupTable::new(
>> -                &self.base.dev,
>> -                &self.base.data[offset..],
>> -            )?);
>> -        }
>> +            self.base.data.get(offset..).ok_or(EINVAL)?
>> +        };
>> +        self.pmu_lookup_table =3D Some(PmuLookupTable::new(&self.base.d=
ev, pmu_lookup_data)?);
>> =20
>>          match self
>>              .pmu_lookup_table
>> @@ -955,8 +950,9 @@ fn setup_falcon_data(
>>              .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
>>          {
>>              Ok(entry) =3D> {
>> -                let mut ucode_offset =3D usize::from_safe_cast(entry.da=
ta);
>> -                ucode_offset -=3D pci_at_image.base.data.len();
>> +                let mut ucode_offset =3D usize::from_safe_cast(entry.da=
ta)
>> +                    .checked_sub(pci_at_image.base.data.len())
>> +                    .ok_or(EINVAL)?;
>>                  if ucode_offset < first_fwsec.base.data.len() {
>>                      dev_err!(self.base.dev, "Falcon Ucode offset not in=
 second Fwsec.\n");
>>                      return Err(EINVAL);
>
> How about replace this whole block with:
>
>   self.falcon_ucode_offset =3D Some(
>       usize::from_safe_cast(entry.data)
>           .checked_sub(pci_at_image.base.data.len())
>           .and_then(|o| o.checked_sub(first_fwsec.base.data.len()))
>           .ok_or(EINVAL)
>           .inspect_err(|_| {
>               dev_err!(self.base.dev,
>                        "Falcon Ucode offset not in second Fwsec.\n");
>           })?,
>   );
>
> That way, the error message also shows up when
> checked_sub(pci_at_image.base.data.len()) fails and it is a bit cleaner.

Yeah, this looks like a better way to do it. Thanks! Will apply.

>
> If you agree with both the above suggestions:
>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
>
> thanks,
>
> --
> Joel Fernandes

