Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFADCD3424
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 10:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 943DD10E530;
	Fri,  1 May 2026 10:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="g2pqqloz";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011038.outbound.protection.outlook.com [52.101.62.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7F2C10E530
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 10:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYLKil9YSeX5CYIRADojZv2Ixk/fmUQE/MfOEhcWwW2eeiudOGz3Sbgl7GSpzicnY38WptArFb84gkpLYbNZIddI/i4EU78nFddb3UKCfml3vS5s4UsnE2lHRHDPFDhDIvAPfnM8uNrop3+9I8xU1tzRL7pOuQgPw5s1ClpBfQlxCIFcXesaE0jSR279bwgJ7APOiUHlvLYkYnVSuq3nl28Hozo+7IKBtA7Z3hABOp1IAph9W4WpRGCmUo1K3D0AE5YGeJwC8Hpr7UM1d0xCnounoTAGrdxcZ875hAkCJ0FXTuXAuAmWAf+SASQIqzfSUueDfG4BxroN6vS+TY1rbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ps0UmY+VlSZj+FALeW82CrnxggCxgxklaBzenmrhHHo=;
 b=NSTTSFIPKn7cgqFWkVicEZJdq1YyHwyyjFzhvyiIfqKfwnAdpmNTcoAOeMqTcbaSd0SisdMtCQ5QRQ8CM+JCHfvy2kAiEZxftFaKO0X92z8Vei1qFb1jX744VvmTBAzU7EVT9RTssyv60snG8gb6iDaNFe1ygljXtbQkNfy+VMs7VckPv7HF4ckLomSY/G3Y2F3a168BBZPdSJnS3/eF3GSoh5mKbF9XkotI+Qw4857diA07KwhZl5gBTNx+VJK7UHgSzkTYsVS0v2OV8ZOh7/Mgv6N0ZGkEOn5SmNFX/B4o2uYv06nOJWJyeBkzNF/lKikEuWBMIsX23PUlBLqLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ps0UmY+VlSZj+FALeW82CrnxggCxgxklaBzenmrhHHo=;
 b=g2pqqlozrnigOm2zh/geWMyS1ASC2ggzSLDL6lpTVhYFxUlg1To+xi8/PM45zzyXEzfQbaeIm6syYW/cDt2QmEBniExOGDClf+hAPUbiP4KfSW/Pjj4fPM82eeSqSD/0TB60I3NUWJ8li1qC9TtWX2F/pFbjysnOLgEspEXRj29mZdKoz7KR+xowUHHDgxsrt3CVnktVOciY5xY+stowxF+yPuXUEe0GVkuderexbKFeH06RAS4+sHZmfN7k6q4hOVQv6YjEVgWQMfp16jR6HfZanQ5JWIYAgPVhz4nwEuOoueOA0jZpGoDNzgxLYe/3/R4FAhXjHxDRvf9sUR45lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA3PR12MB8048.namprd12.prod.outlook.com (2603:10b6:806:31e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Fri, 1 May
 2026 10:56:04 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 10:56:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 19:55:59 +0900
Message-Id: <DI7AAJUDH42D.3J4XSUH2UZJN3@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Joel Fernandes" <joelagnelf@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/11] gpu: nova-core: vbios: use the first PCI-AT
 and FWSEC images
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
 <20260421-fix-vbios-v3-11-8f648aef7a85@nvidia.com>
 <DI5PN6T36R1G.2FIZD42MTRZ2I@nvidia.com>
 <DI5TTYAABYBC.2BCOWJTEJP79H@garyguo.net>
In-Reply-To: <DI5TTYAABYBC.2BCOWJTEJP79H@garyguo.net>
X-ClientProxiedBy: TYCPR01CA0015.jpnprd01.prod.outlook.com (2603:1096:405::27)
 To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA3PR12MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 070277bb-e620-4a56-556a-08dea7703d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j95EFn5Fn62MTAKMjCVLrGdp6tgnx//3rfp8N7e0dSgbdA5nqnOq9uDzf1XB23FX2vTX5oGzozHXOeHJWGrF5KPhJFmysFOnMOumEDddV5NN4yuznuilM589eukvIgCsMzL0Ld/LDirPNIdqV0DQyHF3SY0SxloYFFTPLLfPAkgDBH6bzBcqZE2vyzMXbxy4R/4Mm2cfZFLBa11qOf2zgRZHiXo7cEf4S870WATx74dfqqmE+BolTgZhb5qMz+/bEcujvt941JI+TDSxx57219r1L4MBJ8nErOmD+GF4krUhzb6+yVxkL4hkFhKfUbKpoDjLjldeJGy+NCT4ZZQiUOWgZAElEC6x3G6wfYifY+MxLOCwa6kTqBqmhqBnaakhGFb1jjlhG3GfBr01ODJcplAkdI92vun4757KPbPAI5CHicBp3QgWNqD6+bp32vqd8P1pDIIH25ABXRC8v7pmw1JwISz4XiLBbnTCkBKPld9SoqcPc4Cb40z28MaO8uTJAyyJMOX1n5/6dAahw7aNPbcq4Ux8TYJVSwrCBQf3behjOi26z9U3eisdUKqSRCczRX2cW/sHF3DDkSXDd6hwz5N76Lyg4LGL0QTZjCvGMQdyw9y/aj6fkFttQWcHA/bba+2l5fMvi/IVMlmEM5WtCniuzc9txM/x6fN17ZHJ/ryjgps4/DoiLi2mW9Z749usvqytI0LwL/rojZm4qFQTGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3phbStXOUhIUDVTejY1U2JzT2x2bVJrOUVhNWlrdlhteDExaU1LcnYzeXRE?=
 =?utf-8?B?bk5QQ0YwczU1SWN4dzFPZkRubUpybGFmNTUvd1lXMkx2ak1aeEFlcHpoSm1j?=
 =?utf-8?B?c21hT0JGVDBKRVVNRGgrMGI5TkxYU243TlpnUzhvUytkZEkxWjRvZEVscnRU?=
 =?utf-8?B?UjdEVEMvdmhBWWpMeXNBa0N3dlNJcVRVWnc5SWhLM3ZoV05TbU5DZ1ZEVGI3?=
 =?utf-8?B?SDJQWGRsV3dNVUZEdXdlNVlCVGlKWXdyT0U1WkpNeXgzK29Cd2Y0NHdCbGEr?=
 =?utf-8?B?VVdRMzBSY2RyTThnZ2RSV3E1K2xMNDlvTHRrUk1jSWhIR1FZREcyTERCZlFz?=
 =?utf-8?B?cXhRT2g3UDMvazMwS1MwSERkWGd5dTMzbkZ5NlVwWGs5SU5qc2J6cUxxOUJw?=
 =?utf-8?B?WXJwY2JOQ3JlYnRzSU85dVpQRkFZUW5RZXRzMTRNZUQ0ai9KemV3QzlsdU96?=
 =?utf-8?B?cTA5a1dnVEdNcmdiblNsLzhKYWJUZ3JKRU1vemRxTWMrWCtMcVdiMEYrY0Zk?=
 =?utf-8?B?OTd2NWlxV1FqY04vR2tIYkVyMm9EbE1SdkoxZ1RRNnVxbUFBVGJZL3lSWTZL?=
 =?utf-8?B?aVFCRG1ubTR6MFczdnVDWWcxZTFBQnZZWGh5RW9Pb3A3NzRTVUVlSEF0Qmx2?=
 =?utf-8?B?MUo3Mng5dlV3VWZVQlhDdG9EbVl6b2ZwVlEwUVQwSkRHRXlEWjJmMG9lTUZD?=
 =?utf-8?B?TmRDKzVCVjZkUDNJcWVHZmd0NEZLeEVoTjhydTJFRGk5anZKa0MrckMxTE9D?=
 =?utf-8?B?SlNibmRSR1l0QmdQdCtmV3JXRTkyeXY4SXFkc1BjRWdDL1cvcDN0NTg4NnNS?=
 =?utf-8?B?MDJicmtZamxvdm5tem5IMkh2czRvb0trNmVtWkMrOVRZVVo5UG1ZOXpMMWwx?=
 =?utf-8?B?NlJYVlllSzdEU2ZnNm1CQ2xBUmdHM0xqOFlVRVh1UG1YSGNndEJpbFpUcFlr?=
 =?utf-8?B?MWdrTGFYZVR2cklta3g1RmFiSm80aC9NbG11N2RScmJIMjYybHI5OHo1ZGVZ?=
 =?utf-8?B?b2F2R0E3VVg4dElSeHlvN0UyTTZYZ2N3cVFaZzZBejNzcmhIR3I5bGQ0cWpi?=
 =?utf-8?B?eHFYNWE5RmpxNndBN2FtMEJYY3FrK3FReDhBeHU5SndWMjJ0QXRVYStCRjF1?=
 =?utf-8?B?KzdBWCtabXhTSzhJRFdXRmxlRzNHakFXMVdUWDhyK2JaMTJ3NVRWZUFEa2tB?=
 =?utf-8?B?Ym1nQ3N4UVozcHlQSmJ0WHgzWWNtQjY4YU5kd1I0bjhZRUY2NVpMb3doVXc0?=
 =?utf-8?B?VEJ6OVZuSVR0WXVwUEFWanVNQ0M2RmVnWHUxM0prWTdZd2J6WjdySmZHQmRP?=
 =?utf-8?B?eTdmaElsMlByZXpiNk1PMHZ1aWw4MGliWkJsQ2hjaVVQWXpDNERFOHZFWlA1?=
 =?utf-8?B?ejlZTS8rNy9hc25rSGFHNkpGV28zVFpLejZUZjc2VWRENElvNXo5ZE41UUF4?=
 =?utf-8?B?SzNYSjRzaFVlSWJ5b2xlR0pVZzZ1NUNMbGZhMGNWNzZuK0hhRXhEWnIzOGRi?=
 =?utf-8?B?SCtBYnUwbG1wZHFkSWdTRko2eXVTWTFkMFEzSFllNVNCOGNZRXZZZFI2cUt5?=
 =?utf-8?B?UUk3MHFpM0RtTVVRSnNEM2VpMjZkZ0lPaENnMzMrT3YzaWpVeEUwZTd5eE9O?=
 =?utf-8?B?QkJOVE5jQ1o3ZGJ3b1QzdENMNUVSUXJSTTYyT2RzM3h1TUx4Z3hXWSsxejkx?=
 =?utf-8?B?U3lmZXVORWdDSEFsVmZOeFEzN0RnZlU2NVNpK1c5RzAzRUdIL1R6YlpRNUNo?=
 =?utf-8?B?OE12d0QrU3d0ZU1BUWFBN1FCZzdPQ3R3U2Q2b3R3STVJMmIyUUVsUjdoTUdF?=
 =?utf-8?B?dm1qQWV6dnNpQUhocVRETjYyYnRMUk5SaTE4NkJVNktKUDBvZHFFRW1DVUlB?=
 =?utf-8?B?bVVaQk9PWTdqVE9Dc2FMTEE5anhaWmsxSkhoODRRWEtSak5zaHVkNGtuOXps?=
 =?utf-8?B?R1VadmRKbUIyUEorVkc1a3RyM3gvK0lLQy9CR0hhSUJYWVdXa1Y2c0pVV3dy?=
 =?utf-8?B?MjhlSXUvRVJmYkYxRzdGR0dnK21CVmZ1SGQwZHl0dHRSMFJndC9XNExINVdx?=
 =?utf-8?B?QWkxTG43SlJzckh3Ym05SGMyOVdBSXBRUmkzMGlWbnZiWGQyOVArYWREdHVs?=
 =?utf-8?B?SE1SV1ZYNGI1UFJBL0RGenNCSVVicThXYU90Q1ZYOTJPQWlodDVtY2REMmk2?=
 =?utf-8?B?R05EV2tNekxkSE9mTWJWMUo3RnhHb3o4UkQ2YnBrMmJWV242KzBqamVXWVVX?=
 =?utf-8?B?azdRalYwTW8wVHowUU53QVg0SlU5djI5NDUzblUyRStZNmZGQnRlV25wU2hq?=
 =?utf-8?B?bTF3L2VtS0JFSmZJVXNMTWdIeEQ4dHE2ZGs0MXBuanJlQUEzUEpDT3F1OFh0?=
 =?utf-8?Q?DvVJbkzAhfC3/InjK6XCgEdQeBWkS/dN7r2jU+6bzAE1A?=
X-MS-Exchange-AntiSpam-MessageData-1: u47iOxcZ8D124w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 070277bb-e620-4a56-556a-08dea7703d0f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 10:56:03.7806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NebaazYpbx+hc/ujPXB/mmQfDSpKXRblA46HfjextCMBaYUboD65oJzhNlb0IXmmqsNQ62DokxuDcJzCnUUpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8048
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

On Thu Apr 30, 2026 at 2:49 AM JST, Gary Guo wrote:
> On Wed Apr 29, 2026 at 3:32 PM BST, Alexandre Courbot wrote:
>> On Tue Apr 21, 2026 at 5:20 PM JST, Eliot Courtney wrote:
>>> Currently, PCI-AT takes the final image if multiple exist. For FWSEC, i=
t
>>> takes the first one and the last one. Align both of these to nouveau
>>> behavior by taking the first ones.
>>>
>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>> ---
>>>  drivers/gpu/nova-core/vbios.rs | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbi=
os.rs
>>> index 5cc251c73800..8cfc75b1184f 100644
>>> --- a/drivers/gpu/nova-core/vbios.rs
>>> +++ b/drivers/gpu/nova-core/vbios.rs
>>> @@ -251,12 +251,16 @@ pub(crate) fn new(dev: &device::Device, bar0: &Ba=
r0) -> Result<Vbios> {
>>>              // Convert to a specific image type
>>>              match BiosImageType::try_from(image.pcir.code_type) {
>>>                  Ok(BiosImageType::PciAt) =3D> {
>>> -                    pci_at_image =3D Some(PciAtBiosImage::try_from(ima=
ge)?);
>>> +                    // Silently ignore any extra PCI-AT images.
>>> +                    if pci_at_image.is_none() {
>>> +                        pci_at_image =3D Some(PciAtBiosImage::try_from=
(image)?);
>>> +                    }
>>>                  }
>>
>> I am getting a Clippy here:
>>
>> warning: this `if` can be collapsed into the outer `match`
>>    --> ../drivers/gpu/nova-core/vbios.rs:338:21
>>     |
>> 338 | /                     if pci_at_image.is_none() {
>> 339 | |                         pci_at_image =3D Some(PciAtBiosImage::tr=
y_from(image)?);
>> 340 | |                     }
>>     | |_____________________^
>>     |
>>     =3D help: for further information visit https://rust-lang.github.io/=
rust-clippy/rust-1.95.0/index.html#collapsible_match
>>     =3D note: `-W clippy::collapsible-match` implied by `-W clippy::all`
>>     =3D help: to override `-W clippy::all` add `#[allow(clippy::collapsi=
ble_match)]`
>> help: collapse nested if block
>>     |
>> 336 ~                 Ok(BiosImageType::PciAt)
>> 337 |                     // Silently ignore any extra PCI-AT images.
>> 338 ~                     if pci_at_image.is_none() =3D> {
>> 339 |                         pci_at_image =3D Some(PciAtBiosImage::try_=
from(image)?);
>> 340 ~                     }
>>
>> I have tested this series on Turing and probe completed successfully.


Thank you for testing (and reviewing) this!
>
> Be aware of false positives and the suggested code changes the behaviour.=
 See
> https://lore.kernel.org/rust-for-linux/20260426144201.227108-1-ojeda@kern=
el.org/.
>
> Best,
> Gary

I have to say I am not a fan of this lint in this particular case, since
it moves the "ignore this" semantics to be match level rather than match
branch level. In this particular case it's fine since the _ branch also
silently ignores, but I have been bitten by this kind of match case
lifting making it easy for semantics to be accidentally changed before
IIRC.
