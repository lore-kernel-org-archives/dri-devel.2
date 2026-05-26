Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0646BCD5BD0
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 02:44:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1487510E436;
	Tue, 26 May 2026 02:44:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="r5qKzj9q";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012042.outbound.protection.outlook.com [40.107.209.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67FB610E436;
 Tue, 26 May 2026 02:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSG0/qRuAivun59z8cx/SOn/4d/zyfKSJf6bnOjSwkSjPpz+6SWTQCwW6m7V7VwCoxhCwH8eqCWWhStyGVMXbeb4r6+btividYX96SEN762zOJxR31Yps0mXHz57D6BARBjcHERsF9IJ3NDKUM4q/FY3w+AqDC/Fv2Ly+4zKjbTsw6yhUT4fEtfl8ctl+tRqOs+Yhis3QazERxwidSTzdOXrmbkn2ItKt0C2Tu+sD8CaB0u3XwAnDoYl0BAO0RP4hVZnrDMVMDkGUizusXDkq0Kmpefz0BP0k28WYmF4/pNqN7N4i1I5037gcmeIl2fyMfQalLLD5D9hGy9ap/DI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5jgkCC6IbisAc51/UuEPJrh58b5tbhgGBZHE2jzTwo=;
 b=aff5QHSQ3cIEJ4zaU37cHhVkvS9FIBkJa74/hA1oINBBrAtctKOYzJ1fFDaRC22saVKpyXngZML5gbD9rKtnxp8sNX+ggV+YMvJ2HxngV8Lo4p+XsqaDSB4N6wqI9SOdZPzCAYvjxMn7q2Eh6i+uZAk9r/DZJEhjQeoOO3CTDE5J1/phMXK4fsVI7L/047zDNDU8ZvuE5SEMQmGEkgX/2+9r+9AD31D1GLv8bJK+66EhqwdzKnDaeLSvrJR2DwOEpR4DIQvuMosLA6xDgJXk80NUQrocPFwMHj17c+9d/zvefkI1pStnIPW5H5UOkkD7cQ/y+mDPeYsnu5lH/e96mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5jgkCC6IbisAc51/UuEPJrh58b5tbhgGBZHE2jzTwo=;
 b=r5qKzj9qVTP3bVA0CkGnvI/MasOtnIjE2rDPGwlKNeWTEhT9dFkde50f4QnSEa4sRg9UIx3hQAXPgQa+PD7wZHeRrz+8rKfrTwdrAOKou4+IGL9w4lnMKY8xRimhnIBVj8zH60PTGh+PMnbeYZCUwgR6tw3wbhKftAVpu0M4rR7TGZxzbgdeE6iMbHkdotrkBJjxAIVF11+87rajLDUyiVVO+AjrCSY63VWFU9WmIwao8lNR320rJALo/7X1Fmt7HToAhNkhkoVNXw4s1xzfyut5gpsX7gIgswJZyP+ubLgu+GuY0ijmMhrvQ+DgTU7bFvG1sOMDzG1otcrdVXLqfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 02:43:49 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 02:43:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 May 2026 11:43:38 +0900
Message-Id: <DIS9H75POYGW.EBC1MLW466RG@nvidia.com>
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] gpu: drm: tyr: use IoMem directly instead of Devres
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <boris.brezillon@collabora.com>,
 <deborah.brouwer@collabora.com>, <gary@garyguo.net>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260525230152.277820-1-dakr@kernel.org>
 <20260525230152.277820-3-dakr@kernel.org>
In-Reply-To: <20260525230152.277820-3-dakr@kernel.org>
X-ClientProxiedBy: DS1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::7)
 To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 6854c30c-8106-476c-c21d-08debad098ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|22082099003|56012099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 44HyJTopJgjhrhlAW/G1GZxCGqUtesZzQwAU8rSy4A9GWVQRQqiHM0ZfxDFABGxUDXbht+rHYxLRAB06xWDkRGYjO1J6ot5D1PTomZv6qdF3EyKFf7buSvFLb2Bv0OZfY1Q2CfSK0Q+6dO6H9tlQ1f60PWbrOnroJl+8mjMdFQXY2/gSghvwmT64l22cuVvlPy8NSi+0llKFMEMdWhcZshbpWry+VTMO3zYkgBo+9NLXldi+GyGbmpLmqS8zlwi8M/TqMBLZbP2XdDmiYTuc9bM5hThQNkjODJfggsO0OsywqPcaGre6xMmkExLduYI2BNBObsLAe8MHx17Q/9xGSViZAjbE4JSDG1PgGmpyJsLnDnAtwto4BbY3SR7cm4IqxvcQleTArD4igJunUACybgt9LnX0rwyWfJL2DIaDmQ1pItLHypWlPHIVY8GlMFmxDh3rk375oQFcpgmiiun/9c0buMqYXRpyB21ZKuBMLOD6agQSYcol7+yMwO4cagrEKA2bDg8DbIkv45/XJ04jwhNFEAr8SpzE12gkXMZZswhhlcYGHrICSAMpEfttGkOKNO0kI/zshiGC3lYJaiW2zXlhZlcgng6+ROAdQBILnaNSIz2uW3ffwqZZ/7gvdfWXJCtffLZkSRe3zGfkIzF21xSG2+AlEMOKuj5sC5rtBygK8ZflIMs5CVKPze8bOpkW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(22082099003)(56012099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHFrM2hMNmxEczR1MnFmMjYxQllUbk1YUnRyRVFGcVFNcVdnV3IrNHFDa25a?=
 =?utf-8?B?Zit6cGdaMUsvMG5IaTd1c3hKSURLajlyNTZiOFVqTlNkQ0dDVytlYzZaVG02?=
 =?utf-8?B?YWd6Yjh1Q1hZUGd1c1gzREdlZU9tU1M0QWlNL3ZrdmI3amtvTnNDSzY3OFRv?=
 =?utf-8?B?MDV6cDB2aUYxZmVXWFdqcSt0OVJwck9xcW5HRE1qVjVZOExtRWRTYkQwVnFs?=
 =?utf-8?B?dkxSKzlNSGp6N29qUkdXTElUQXVyemRZejdjYW1KOEJITjJSTUo3L3FzRXgy?=
 =?utf-8?B?Mm42VHRteVg2Q3RuOUxJMTRZUnJnTFFBOTN4OW9lT2pEZFhZaXJoWmtrZHgw?=
 =?utf-8?B?Vk04czR2Qzlibm01dEhaUGI3RkMraVNkSkxFSlEzdGc5ZzVqTTRhRFJjNDNF?=
 =?utf-8?B?Uk1BRmtXQ1kzYXptdDY2NGJ2WEk4Ny94V0FZTXA5VUgwZEhtWWM5WjRWM3RY?=
 =?utf-8?B?RmlQRURONktUZDRIQzhFcVd0S0s4dkFHT09KYnNsVGlmb1NhRndmcHdLNkpE?=
 =?utf-8?B?emJOeC9acGxPQVN0RXZQeWhKcFJqamlGM3RZU2FtcHRQRXJzUSsyRVhlVGhh?=
 =?utf-8?B?T0ZYd3dCNGRiR0c4Ui9EcWN3ZzNhV1J2a1o5by9FNmxGRFpvRkp0cmkreVd3?=
 =?utf-8?B?R2JxYjFLL0d1YXlJWFc1ZjN5cU5DZkJyM3pYNGVoSy9YUlFHRGZtcnhoSWQw?=
 =?utf-8?B?Z3lVY0tRUzF6YmtPcjdtQU9oTU9zOVhueXFJQ3VRYnkzNGVpOEU5Ynh4OUVx?=
 =?utf-8?B?U2FOUmR6NVlVcmZzRisrUndPS1RwSVVuRUhyRDNmc3dyOTVHcnFUQkI1VEx2?=
 =?utf-8?B?L0wyYnVjdlV3TFg2ZjJYa1pTWFpVSHBoMVRscU14MGlwY2pWWUI4eGRscU1m?=
 =?utf-8?B?elJpZmZ1Q0pmdUJlVWg1UW01bHE1cE42SHUxTHlSN1BmNmd6U1d0N1AvWWlV?=
 =?utf-8?B?U2MrTUxhZTJaZVhyQzFhT1ZyV2k3Ny9sTVVkYjFveUcxZkNXV011UXpmQUp2?=
 =?utf-8?B?WGNXT1ZnR25hbEdpUHJVNkhuTnh3STdhZlNXeVM4eXFCdmVOYWYrZy94amZ4?=
 =?utf-8?B?U25zTE9mc0kxeWpEZEZKd000V0VqZ3doT1IwMU9ueERJUTBnSUswNVVQY2VD?=
 =?utf-8?B?VGhmekxPd3NCMjlHc0tPaU5QMlZNcTlodjFzc2pUYTBNZlVJNXNXR2xmU2Nh?=
 =?utf-8?B?NUpDS1p1YWI4ZTVDUE5wTWRidWlreXRZNmZuWk01YjdGWC91SW1Pa3lnMDJL?=
 =?utf-8?B?TTNJN1ByZ0FyaExyUGdOOVU1aDRVMWRKc1E4QXNXckE3TFlxbkNNa2REcU9V?=
 =?utf-8?B?RnpXL0dTOGlNbzd3ZWF0cEJaM2FtZFJvSVhtRXpWdTBpSGZzUWtrM1JqNG5Z?=
 =?utf-8?B?Q2R2R21RS0hUZElVQWt6RW41ZHVrOFJ1cHpMM2tXaDNRNjF4K2tNWnBmZXlO?=
 =?utf-8?B?RmhxOG1udjgwYVE1ejNma3FiOW5ESGs0cDJKTlBMM2Y3VGdYZE9NdVB3dW1U?=
 =?utf-8?B?RmJHa3dzdWd4U0ViZFhBT0ZHRjRsbjFUVWZ3QkhrTHVBSHVYT2lZZXJNWFVY?=
 =?utf-8?B?KzRVSEhmTlNVd0VCZ3JzdzFwbDYrMnRGK0srUlJ2TnVoT2NXRUgwYUxyYmpP?=
 =?utf-8?B?eXUxQzNNRVZxOGpnWlVnYVFVNDJjbVhuSFdkOE1uOHB6SHlmaTVFc1lhV0oz?=
 =?utf-8?B?YXBWWTdGRmhtc2trNllwRXNZRmljazBmS0NtMWVBY2gwZkhEeU8yc1NzSTRF?=
 =?utf-8?B?ZDR4UFFNT3N3ajAvYTZ5QkVkZGgrTm9iV2VWbnljaUx4T0UrZStYSERNS0oy?=
 =?utf-8?B?c2w2c1JzbDdsaUFoQVlUUnJ5Tkd2RHFVcDJsMWxSNjJIMUJVMi9ha2VxRCtn?=
 =?utf-8?B?TzI0ZGV2V0I4dGNJbkVGcE9SNkw5d3pCeTduL0ljN2NlTW5sa3ZKV0RIZkYy?=
 =?utf-8?B?KzRUejUyTmgrb1hkLzJISVhvaUtmdndET1RIZTh4TEYyQnArcVNPMlhVaEl3?=
 =?utf-8?B?aStSR0RCRVRuNFRmeW9ZNW9tM1JoTVJjN3dHWUtsaVoySEU3SUNCd3luZzhS?=
 =?utf-8?B?WFluV0RFcUtzbElEMDJ4eGlQNExEandQTVMxa1gzUDQ4ZmZKM3pBTHVmK2pW?=
 =?utf-8?B?RmhMaUxlREVSbWtQVWlYb1VPeGhGTjQrMGJIRGxjdVk5SHBMZ1p6NVdSUDRv?=
 =?utf-8?B?bitINTJaaHE4UkY0M0QxejlVczg0OHd2U2E2dndTMy9VTElWakN1SzlDZmM3?=
 =?utf-8?B?Y3pGUmh3dGN3emR2emtCMm9yMnB0QlUweXJ2aytPMlNmR0dhYXJYaDJsNUlj?=
 =?utf-8?B?TWs0cGk5YmJYZ1FlU29KanFqMkcwT3dHaVllaEpGaDZiNzdyV0hZWnV3cW1G?=
 =?utf-8?Q?yOOGC2+xe/eqduLGJIzbAj0rMbdgKQuB8Lcvqt2DWEgb7?=
X-MS-Exchange-AntiSpam-MessageData-1: XOOr2AxXgCOYDA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6854c30c-8106-476c-c21d-08debad098ac
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 02:43:41.5754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UsUD3gc5suhBRYfGyPo0+hpBWapveJlW/X817HmlZblLxFxvbMZ4sy/01ry9hE9hwmUCAuQ6lxRQYDIi9uxWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
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

On Tue May 26, 2026 at 8:01 AM JST, Danilo Krummrich wrote:
> Now that IoMem is lifetime-parameterized, use it directly in probe
> rather than wrapping it in Devres and Arc. The I/O memory mapping is
> only used during probe and not stored in driver data, so device-managed
> revocation is unnecessary.
>
> This removes the Devres access(dev) pattern from issue_soft_reset(),
> GpuInfo::new(), and l2_power_on(), simplifying register access.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/drm/tyr/driver.rs | 19 ++++++-------------
>  drivers/gpu/drm/tyr/gpu.rs    | 13 +++----------
>  2 files changed, 9 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.r=
s
> index 5f4c484f671f..b9a5cc5fc678 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -6,11 +6,9 @@
>          OptionalClk, //
>      },
>      device::{
> -        Bound,
>          Core,
>          Device, //
>      },
> -    devres::Devres,
>      dma::{
>          Device as DmaDevice,
>          DmaMask, //
> @@ -30,7 +28,6 @@
>      sizes::SZ_2M,
>      sync::{
>          aref::ARef,
> -        Arc,
>          Mutex, //
>      },
>      time, //
> @@ -44,7 +41,7 @@
>      regs::gpu_control::*, //
>  };
> =20
> -pub(crate) type IoMem =3D kernel::io::mem::IoMem<'static, SZ_2M>;
> +pub(crate) type IoMem<'a> =3D kernel::io::mem::IoMem<'a, SZ_2M>;
> =20
>  pub(crate) struct TyrDrmDriver;
> =20
> @@ -74,15 +71,11 @@ pub(crate) struct TyrDrmDeviceData {
>      pub(crate) gpu_info: GpuInfo,
>  }
> =20
> -fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Resul=
t {
> -    let io =3D (*iomem).access(dev)?;
> -    io.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
> +fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
> +    iomem.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
> =20
>      poll::read_poll_timeout(
> -        || {
> -            let io =3D (*iomem).access(dev)?;
> -            Ok(io.read(GPU_IRQ_RAWSTAT))
> -        },
> +        || Ok(iomem.read(GPU_IRQ_RAWSTAT)),
>          |status| status.reset_completed(),
>          time::Delta::from_millis(1),
>          time::Delta::from_millis(100),
> @@ -123,12 +116,12 @@ fn probe<'bound>(
>          let sram_regulator =3D Regulator::<regulator::Enabled>::get(pdev=
.as_ref(), c"sram")?;
> =20
>          let request =3D pdev.io_request_by_index(0).ok_or(ENODEV)?;
> -        let iomem =3D Arc::new(request.iomap_sized::<SZ_2M>()?.into_devr=
es()?, GFP_KERNEL)?;
> +        let iomem =3D request.iomap_sized::<SZ_2M>()?;
> =20
>          issue_soft_reset(pdev.as_ref(), &iomem)?;
>          gpu::l2_power_on(pdev.as_ref(), &iomem)?;
> =20
> -        let gpu_info =3D GpuInfo::new(pdev.as_ref(), &iomem)?;
> +        let gpu_info =3D GpuInfo::new(&iomem)?;
>          gpu_info.log(pdev.as_ref());
> =20
>          let pa_bits =3D MMU_FEATURES::from_raw(gpu_info.mmu_features)
> diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
> index 652556026f50..3acffefaf210 100644
> --- a/drivers/gpu/drm/tyr/gpu.rs
> +++ b/drivers/gpu/drm/tyr/gpu.rs
> @@ -9,7 +9,6 @@
>          Bound,
>          Device, //
>      },
> -    devres::Devres,
>      io::{
>          poll,
>          register::Array,
> @@ -40,9 +39,7 @@
>  pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);
> =20
>  impl GpuInfo {
> -    pub(crate) fn new(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Res=
ult<Self> {
> -        let io =3D (*iomem).access(dev)?;
> -
> +    pub(crate) fn new(io: &IoMem<'_>) -> Result<Self> {

Perhaps a future patch can remove this now unnecessary looking Result in
the return type.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>

