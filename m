Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C75CC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 04:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC4A10E2F9;
	Wed,  1 Jul 2026 04:16:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="aeLPpBdt";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C7710E2F9;
 Wed,  1 Jul 2026 04:16:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haL3NNK0MPn27EAkp8X4yOqRwoaLmZmsSGkKGPRWSYcjbImJNBH7zp56ox5dNAyG0RkvvCWfZIDyFN7repICPo5pE10Cs+g1YWOBVKIafrSRP0onp6R9PfxH1Br/xgBUlurfgRDJsQ6ok+cI6+x6amkRhIkqArcITxoLGqp8MIab6Wm/pcMm0Ym2rVwb/EC8yDYIbVmBiNEHmY9Bdn3AS0/Y7QVd+ZLZP7H2gcrvoEWtFdfSws7QAjnAjSVtG9A0EVQUQk/diEQxTyf1cG9kjRaT3drq+nicRRhHzzUxeH/LAtwhZlnVGR7OllkXbuSJWZhx/3BMp3dxf+HYehXT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZSI1PaKB4kU9MWQSpDNN/m8zASVG33fgF5pkN3Hspk=;
 b=wLEsuDUNhu6vcwIZzHHH7G8FHCncwo11A7hQO0qGwCXW3mICWkoODrcARU9lljOtrCR203MS5n9xq2cTRMy/r+ctBS4o9wRQh0zwmrQVi4NiCqJIHJ4KCrNU618BiLQoXbITMOmGCNOgjatnwFfkmDmHfFQS8h6ARzVTnGnb5ZrAiC8SriN83yW7q6nFmbBacBe0UcmCNVavH6mZhnuwZkJf29A2B4IbMSIHWtuvkVhRmP/3TXJqQzhOljL3OBiyLPDL4gDfPICturO8qruZeaRJAEd1IKa4x727T8VVNROxrnfpyF7e3js/bYFnuZKKPFzwN4dWxOXNq2veokI02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZSI1PaKB4kU9MWQSpDNN/m8zASVG33fgF5pkN3Hspk=;
 b=aeLPpBdtKXsO0Z9mP+CQxwkCcRKG+/WGh3jxdRIUinjESRvwMqPz44cGNUf0zM6c7ZittbwNyq/BkJm41gk8FUoczff5hAnHBBGSIvf2L0VvuX/nJ9dMdo9WY6uhWdh0o3rqg2aidyhGmqkauy5ZoEnrQhbeHzTo05EiyYOZhm42GiaAZAUOAxSp8Gw5okxqtf9GryJf3VR6bXCHs3l7IudYzMl2rqXcYTTWEJiEb5wyM5pxmEM1uRripCQ2ctGuCyRi8tDQ4ySL401wN8q+5B09ro5hBN1nHEdZpqRBzrORhMXCccM6zNRTDv6vZvhs97u0Fy03kTGp9xiiGuY8+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 04:16:06 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 04:16:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 13:15:54 +0900
Message-Id: <DJMXZGIY5QJR.8QZK8SCDL29B@nvidia.com>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v4 06/13] gpu: nova-core: gsp: fold TU102 unload bundle
 construction into HAL method
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
 <20260629-nova-bootcontext-v4-6-5539d8469590@nvidia.com>
In-Reply-To: <20260629-nova-bootcontext-v4-6-5539d8469590@nvidia.com>
X-ClientProxiedBy: DUZPR01CA0196.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::23) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b875990-cd60-430b-194c-08ded7277501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|10070799003|1800799024|921020|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: RV6cWDrhJGH3ZD9z3/4QPecvpDLFwtIv/4/iLQg8j+sHKmg2ICHwAyIn/mpiSsJsMv4SWdjcOSBaT5GNQ5nPZqXh/tsvqtOJQESdc3EWyhdxTHvrxcH3pfUEx90rXGjl3stPi1jqMcs+z4DCrF2pTf5bfUXhQaWU0CCS8rC4mo7qsC3/lbUrjlkNWF70/ujLZ1QZ8+fSO5fNNR+19Ufee4MEkSIZzmIp66BlgyGUPnMbaT6XpKOmFmOXlJUG4XB+05zV9LtWV0yxxrNq987Xhri/JJRV0vj+PMUReYS7ZcrqKacfmuJWMzdGK4iGna0byUlQh9jUkJjBdsUV+QruFrrrQCmtW9FCWmZ2gR6KZHnFO7DYI/TRy+GtRdIO1AeUqbiYDXy4u5YwArXLGpbH0WBHyDLpdfGvX26fY9BGwJeAjm8X+GxBBV4o1Isd/kJvSbvtq9oqQTJyh3bL1w6JmCdEM/Y38URkXGmFy+qKgkdlW+nYl8DkkLfKfiFXNTvGbcaTv1xZ1CBSceWr1NssQPGcdxkf/3/dq0p2juXBt5FNI/aEq9aQ80elgwuIBhYZtxXoOkIRbshq3ehT40UEwQy+gZZl2eU/4pE+VoxisdXdm3KSPfCvj65WrTJx3j/PrwPWkP0mhGK6lI4DfhKQFRwEfOCOrl/bzFVD+V8aox5Ma4eBERwOyc7a7lVbWM8O7B4pUAYAF/LuRhYgnFI9CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(10070799003)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnFVSjZkdjAwUjEyMUx5OUVOM2VOODFVSXVsTDZnOStwM2xzanZlajF6TVcr?=
 =?utf-8?B?Wi9XUFh4MVY0eDhtVDZvZ3Z1SWZGRTdyNTBWSmZJejVpYUdxblQxb09uWkpO?=
 =?utf-8?B?akQ1ZTJsOHZNSWdmNGc3WFBGcmRhbjJ3ck1UdkJkcVBZUVZDQnd1NGl2d05y?=
 =?utf-8?B?WDlqc1FXOXVVL1dZL3J4OTllY3J5bEoyUytmcWwzalNHQkpKSkhmRjR3dURt?=
 =?utf-8?B?KzRhZ0JFYkt6WkxRRS9XSGpRNU15UHhSY01IdUE5ZVhRTHdBdFJHTmE5SVZh?=
 =?utf-8?B?STIwNFVrc2RKelNyZ2VxVTdUSlRZSGhHL0FTS2FsSEJ6am9RNnJ1eGFpTWdj?=
 =?utf-8?B?dkdwRzZMeUk4dlBuR28zZndyeGRHNEVyN0xFV2lxVDV5VTNmVjMvTjF2TzV2?=
 =?utf-8?B?MWp4Mk9zcEpIZUR0eEpzMHpYQ0FER1FrRFBnMklpZEFWUnFGYStQVmdJRG1w?=
 =?utf-8?B?dE51RzNpUW5BWEkyMEtFQ2pNQXQ0ajlXQ0NHYTVNYUV6RUdMbjRBMFppY0ph?=
 =?utf-8?B?c3VIR0oxdXNqd3BTVFM5bkxLOVVpemI2akxHYUIvVFpobG55QlNnREp6NzZH?=
 =?utf-8?B?MEgzWEgvK0RVbVc4eWNYUUttcGpEMGtrN1B5cU0xUURXVUJxTUp2NkdBbWJR?=
 =?utf-8?B?ZmVYczlOQnVld21hcUI0Q1FyMENBZVU1bGxYbW9CR3Q0WDhlZy9Vc2lFMDdi?=
 =?utf-8?B?end1bjNUbDlndlRwMGhybG9nNE9ncisvNmRKUi9GaHdiZjBXcUN0MCs5SXF4?=
 =?utf-8?B?VFdvK0hwZTgvckxFbmVvc3A3WU1lbGJ1Y2JVTlgvK1hKUGp2ZEFMbkVzOW12?=
 =?utf-8?B?Z0x5aGZ5dnh2bG1ERng0bFE0YnEyNTIzTlAyNFhNNUpFRlovOTFVUko3VW9K?=
 =?utf-8?B?M1l5NVd2M1JsMjYrRWhRSUJOSkxKUjVXSU1EKzkxVjZlcGNtYnRXdGR3elRk?=
 =?utf-8?B?WEVnME5nQThsVVdJaXM2SUFoZlNHUVpZaXFNeStITjd4ZWdNWWtXMkpDa0Nw?=
 =?utf-8?B?dG1mbGR1L1BtSTdIaW5NZHRGQWlLYkY3S250Z3VGL29kTTVrTnVGRkF0THVq?=
 =?utf-8?B?T0s0MVFGWmMzVVY4MGVsZ1IyTjFGb1Z0cmJEV0UrVGpMZVBNZ0d5bU9WN044?=
 =?utf-8?B?QUFQUlhGTTM0dDkyQlBsREtsUDBQQmsyQkJLcmdwVlRkMGFOdlRPZkx4c2RO?=
 =?utf-8?B?Q3hudmN6UE04clNROGc2eGt0My9NMzJBQzh3U3cvTW5oVDdBSnZQb01JeGx6?=
 =?utf-8?B?bFFCYzhuV0dKakozdzJFVXB0WVB0dkNRdUtFcDhYMkJkaWQySCtHNXR3V2M5?=
 =?utf-8?B?ajBqYzI1T0N1S3dhZnJ0SGhmWVNNUzZHWHVwaVUyMWpXTVRXcDNxeDNUdTNM?=
 =?utf-8?B?WWRuZzJmRUNaeEZwcmpHRXFRWW13UWpZSS9UMW42WHcxZ1FyYVNQdGpkMDJl?=
 =?utf-8?B?aWViTlAwY01la1lQV1R1eFhHNEpXOVMydlR4aEF2U3R3cUxBa1gwSVNLZlBk?=
 =?utf-8?B?R0hZVDhlQTd4Y3hON3Rxd3VKSWxqMVphWFR5ODRCR2oyVHZ3OTJETGlSUmIw?=
 =?utf-8?B?alRqVjRseGZNNzJZQ0ZBZE5WMFJITFpoc0FyTlpQNHltdGVvL1ZZODlYc2Na?=
 =?utf-8?B?NUFJeldCUTg5OWVGNmpOdmc5NlJjYkNuY0QycDFubnZlQ1M1NFhraXdaYlky?=
 =?utf-8?B?MHdIdHV2VlkvNGRXTU9hOHI2bk9PbmlMTzBWTytvdEc5RS9uYVFkVFhCV1Ax?=
 =?utf-8?B?NmE1b3luSFduSmd1VG5RcjdtRS9IdUpCK3hmRldnYS81c3o1WWNreW9HcnJZ?=
 =?utf-8?B?NTlKdU9mSE1ldm9Nd0FGSDdRZisyNVNDTi9kTzRaWEQ2MEI5YU5wZitPRmor?=
 =?utf-8?B?WHQ4djJ6L3Z3M2h4VHdnQTZYWkVGOHJUbFN5YlFEWTA0NmxWSE1OYVNUTE9C?=
 =?utf-8?B?TVY0MHlHOUhtdGxuNHZLSmJnQjdsVTlqZWlmNXlDN0RoWE9ZRzc3cmM0NzdL?=
 =?utf-8?B?cktLMzU0UTRyRk1YMjU2WnpFR0J0RzNpTzVveVcvK0l2dmVralBPMWtqNFZl?=
 =?utf-8?B?NDlQS1d5b3MzRzZvT1pSVXNzSkN3MU8yZFdKbWZSaFV2VFlLOTBNNXJQaVZa?=
 =?utf-8?B?K3krcG0vRlByOUpTWmJXZUgzMzh3MWZaTXRGK1BRZUlhcW9oSHA2M2ZYT2VZ?=
 =?utf-8?B?NzZxaTNoSnh6c2I1SmdhN2duZXZaR0RFQ3ZGRTUzNGZsN0NDVVhPTjNVTmhK?=
 =?utf-8?B?WGJyTGw1RnJWL3F2cUs2SUozaTVaVzQ2dm0wc2tocERsN0pESHhqNWFnRndn?=
 =?utf-8?B?R3UvdDFxNEJwV3c3a1VkYzdCTjhuNnRvYzNJVG5MZ0k0STJSeVRZZlBPVmJS?=
 =?utf-8?Q?erFRCO2h+BtIA85+5NJagEXhSjlsQMGMIrUgeP2l3Vtkf?=
X-MS-Exchange-AntiSpam-MessageData-1: P1iaPXc7p5m1LA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b875990-cd60-430b-194c-08ded7277501
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 04:16:00.0973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F86cvJc14S679KFjOQ9OF5g1x8rU9QjwcIr8Us5kDF/rtI36mV9AD0updhx2h0YZAq+uEtgZ56d8RlljFqiUCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

On Mon Jun 29, 2026 at 11:09 PM JST, Alexandre Courbot wrote:
> The construction of the unload bundle is currently a bit convoluted and
> could be done in one function instead of two.
>
> Additionally, turn that function into a method of `Tu102`. A following
> patch will turn the "use FWSEC bootloader" property into a flag of the
> TU102 HAL itself, and making this a method will allow the code to access
> it instead of querying `Chipset`.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/hal/tu102.rs | 87 ++++++++++++++++------------=
------
>  1 file changed, 41 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-co=
re/gsp/hal/tu102.rs
> index ef465b99af05..0505a5beee6e 100644
> --- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
> @@ -56,22 +56,6 @@ enum FwsecUnloadFirmware {
>  }
> =20
>  impl FwsecUnloadFirmware {
> -    /// Loads the FWSEC SB firmware, as well as its bootloader if `chips=
et` requires it.
> -    fn new(
> -        dev: &device::Device<device::Bound>,
> -        chipset: Chipset,
> -        bios: &Vbios,
> -        gsp_falcon: &Falcon<'_, GspEngine>,
> -    ) -> Result<Self> {
> -        let fwsec_sb =3D FwsecFirmware::new(dev, gsp_falcon, bios, Fwsec=
Command::Sb)?;
> -
> -        Ok(if chipset.needs_fwsec_bootloader() {
> -            Self::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset=
)?)
> -        } else {
> -            Self::WithoutBl(fwsec_sb)
> -        })
> -    }
> -
>      /// Runs the FWSEC SB firmware.
>      fn run(
>          &self,
> @@ -93,33 +77,6 @@ struct Sec2UnloadBundle {
>      booter_unloader: BooterFirmware,
>  }
> =20
> -impl Sec2UnloadBundle {
> -    /// Load and prepare the resources required to properly reset the GS=
P after it has been stopped.
> -    fn build(
> -        dev: &device::Device<device::Bound>,
> -        chipset: Chipset,
> -        bios: &Vbios,
> -        gsp_falcon: &Falcon<'_, GspEngine>,
> -        sec2_falcon: &Falcon<'_, Sec2>,
> -    ) -> Result<KBox<dyn UnloadBundle>> {
> -        KBox::new(
> -            Self {
> -                fwsec_sb: FwsecUnloadFirmware::new(dev, chipset, bios, g=
sp_falcon)?,
> -                booter_unloader: BooterFirmware::new(
> -                    dev,
> -                    BooterKind::Unloader,
> -                    chipset,
> -                    FIRMWARE_VERSION,
> -                    sec2_falcon,
> -                )?,
> -            },
> -            GFP_KERNEL,
> -        )
> -        .map(|b| b as KBox<dyn UnloadBundle>)
> -        .map_err(Into::into)
> -    }
> -}
> -
>  impl UnloadBundle for Sec2UnloadBundle {
>      fn run(&self, ctx: &GspBootContext<'_>) -> Result {
>          let dev =3D ctx.dev();
> @@ -257,6 +214,44 @@ fn run_fwsec_frts(
> =20
>  struct Tu102;
> =20
> +impl Tu102 {
> +    /// Load and prepare the resources required to properly reset the GS=
P after it has been stopped.
> +    fn build_unload_bundle(
> +        &self,
> +        dev: &device::Device<device::Bound>,
> +        chipset: Chipset,
> +        bios: &Vbios,
> +        gsp_falcon: &Falcon<'_, GspEngine>,
> +        sec2_falcon: &Falcon<'_, Sec2>,
> +    ) -> Result<crate::gsp::UnloadBundle> {
> +        // Load the FWSEC SB firmware, as well as its bootloader if requ=
ired.
> +        let fwsec_sb =3D
> +            FwsecFirmware::new(dev, gsp_falcon, bios, FwsecCommand::Sb).=
and_then(|fwsec_sb| {
> +                Ok(if chipset.needs_fwsec_bootloader() {
> +                    FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new=
(fwsec_sb, dev, chipset)?)
> +                } else {
> +                    FwsecUnloadFirmware::WithoutBl(fwsec_sb)
> +                })
> +            })?;

nit: Maybe nicer to write this like:
```
// Load the FWSEC SB firmware, as well as its bootloader if required.
let fwsec_sb =3D FwsecFirmware::new(dev, gsp_falcon, bios, FwsecCommand::Sb=
)?;
let fwsec_sb =3D if self.needs_fwsec_bootloader {
    FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chi=
pset)?)
} else {
    FwsecUnloadFirmware::WithoutBl(fwsec_sb)
};
```

With that,

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

> +
> +        KBox::new(
> +            Sec2UnloadBundle {
> +                fwsec_sb,
> +                booter_unloader: BooterFirmware::new(
> +                    dev,
> +                    BooterKind::Unloader,
> +                    chipset,
> +                    FIRMWARE_VERSION,
> +                    sec2_falcon,
> +                )?,
> +            },
> +            GFP_KERNEL,
> +        )
> +        .map(|b| crate::gsp::UnloadBundle(b))
> +        .map_err(Into::into)
> +    }
> +}
> +
>  impl GspHal for Tu102 {
>      fn boot(
>          &self,
> @@ -277,10 +272,10 @@ fn boot(
>          //
>          // If the unload bundle creation fails, the GPU will need to be =
reset before the driver can
>          // be probed again.
> -        let unload_bundle =3D Sec2UnloadBundle::build(dev, chipset, &bio=
s, gsp_falcon, sec2_falcon)
> +        let unload_bundle =3D self
> +            .build_unload_bundle(dev, chipset, &bios, gsp_falcon, sec2_f=
alcon)
>              .inspect_err(|e| dev_warn!(dev, "Failed to prepare unload fi=
rmware: {:?}\n", e))
> -            .ok()
> -            .map(crate::gsp::UnloadBundle);
> +            .ok();
> =20
>          // Run the unload bundle to try and recover the GSP if an error =
occurs.
>          let unload_guard =3D ScopeGuard::new_with_data(unload_bundle, |u=
nload_bundle| {

