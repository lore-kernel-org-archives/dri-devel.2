Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8798DCA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 23:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B435810E0CD;
	Wed, 30 Sep 2026 23:03:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BabIKdMD";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011042.outbound.protection.outlook.com
 [40.93.194.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40FDE10F502
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 23:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upRIyJEDgsAbOhbyvuSEA+st97d/jHJpin10/x+TB/ZRkv+qKIyryU68NXU5d0CoF81s5YlwPGYxOYluso8qOdeZWChzqnPnenvVah2nzkYtVEa/ly9a2+aGD1hSHEAnGVMWSu+iMJniJc9EaPk4+Qylh5n9AdWeP29sS67nM7ZHEmQ+rKtKat18Z0DZyen9u2TKULmFftFxQoInm5HKnT5TVozNiSsZRD55yVeKGZQyk0q5wHyrR/nKKsVUKpSnxRvBLtPDe7V5wKlk3MlvEBlSsE1fJ/NGRg3G/Zv+2IICoJuj6QC5buPNlBZZD/eZTh7F0+c+kmDoQ+u8q6HUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjULDSTtHnMKbQByRDYu396b1T8oIcWGNwMNLDpnPU0=;
 b=VN6H/kM7P9W0kGlXLIlwTWQjANegsBJoNeu1cbfji4MJDdYyCkg1TUSZD2pLBmNZrMnC/ElZqdcQJV9aHVzJ3A266bTP38wRUummT6VJro8chR9o0R4vuehddJC9ai6WHT/qGbopaTP7YuBHR7TEc7/NIcHjXrr//6PN6KJH19tyoA4y5MdQ+PmKNI6Zez5xTevJfhAwqCBwxVka9sp0pyoRMgOs69RvwCJtd7JH5azfhXOXStY/jzLddaFSJlb1zpCW7cxR1iXC0MskBhnpRlLj7PYpWnWl8GEvOsYLGD/nYN+Wu0eu1bVCPK3u1fT7pPoasRYHjg+UrA+pJUV48w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjULDSTtHnMKbQByRDYu396b1T8oIcWGNwMNLDpnPU0=;
 b=BabIKdMDuTHpRjr1DGjjfO1R89oYkhSacIHH6w82nxp1hlXmkYt82euiz6EYTbvkoBN36hRaKIITtWWUPns5cpDLyBExHkqt9r2XtZ95LT+NwviC7Lrf/rmAF2uDH0S5S7EVEp3hEGO+/J3mZ8cjUWKZGaEYeU+Lh3hFpzgr234cBSbyIAazsuCCp24k70tEBfrHC+782VidL6RUJRQwjiJzOO0G5OXk0cxDG80idloaovIzQwCTHL/a/msI56qHMogJMXZdqzSndME7U3HONvtLv/khu0CKPhH3ngW2bIWizxofTa0cpGbcMxbSIetmFE/RZsSJjS8ZHpiraZv2bg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by PH7PR12MB6934.namprd12.prod.outlook.com (2603:10b6:510:1b8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 23:03:28 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 23:03:28 +0000
Date: Thu, 1 Oct 2026 09:03:22 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: airlied@gmail.com, gary@garyguo.net, acourbot@nvidia.com, 
 jhubbard@nvidia.com, ecourtney@nvidia.com, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: nova: Move VRAM BAR size query to GPU info
Message-ID: <ar2U6xn1H0cEMzPS@nvdebian.thelocal>
References: <20260927142258.1260711-1-dakr@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927142258.1260711-1-dakr@kernel.org>
X-ClientProxiedBy: SY5PR01CA0070.ausprd01.prod.outlook.com
 (2603:10c6:10:1f4::13) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|PH7PR12MB6934:EE_
X-MS-Office365-Filtering-Correlation-Id: dc37bc63-8521-4add-51ec-08df1f4709d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|6133799003|10067099003|260925021911599003|260925022911599003|260925021311599003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: wMO0JaszMl5fBqRvwICHHjcSx9U9HTFKmvzDCs96JqaNxSql/RXcm6dnX++PZ41w3/e2cRyMdw1KmQtw/54SHjVWTIS1kwNlA/b+xRoKMvwkgn5e7P9726IdoGE22REWj4A0+ky9jBoIORFJbV2qJa1+wBXec3s8tIZzHOCb9T51izivq7SU8qsQr8z8XYpjbqU8Z0KlB3VmystvObAScjr+pjrpXoA7uAgDDIj8Ok+VyC9sgaDq5eOd0lLlksIfMy3JgNhyjdbQ8TV5cXGAp705gRlKFnZM97Bzmj2eHlnGcqOKfAUB3AznoejnbF25CijjvGAAnJP0M5JCe/6cOaonDPT/KAkm0KwGMzK76PUg77ps3uth9zyaMkiTr32Z+e/L0uLpRaFp9eW32PcC+oVhtesDuYSFLxS6RTi7K6bcTY+fAHjEUGfG/vef21b51flxaCaTQGdqIJK9OjDUnO4gRy42HqSsj7jdVreiJa7FwIa2hdvM0gFOVl5iBs/t6WKLbrU35V/YJ4OxLfYiEKWePyC5oHB1viftH7hOa+NDFzdtS2oR/pwfjMC2BqO8nFoiOg3t/VC4ioTsdnX/uKlIy+fK+7RDmGvEcTG3cA/mIUuxKVRFyOc7otoeJ0c/iXjBrxWLPAuUgZ9DKR/8d+SkI6t5i1j+PjPJ0QlRWG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(6133799003)(10067099003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yowlWTJtDTkn4dexocaQy5qs4PmmLQX1OSZWNNABO9vK9FnrgM7eGoc7Yv+j?=
 =?us-ascii?Q?MCSYZTuBYi9JxKhxn7n4JfU9mEs2RMXswxgv1+oQUVZR0Uu6oTK+zIPvB74R?=
 =?us-ascii?Q?pATxUrJRJnIcsiLXmah4ytwhfJYu5QkOZQnuCilaQyUV/0rYAB5FwF4fmntV?=
 =?us-ascii?Q?7RuWtj+x3lpmFB9Xfasg3scKKmAdLK7Z5mQc3+94BE/srV0UKRPPabLwpxFc?=
 =?us-ascii?Q?2x0RvOHSoq/ReeFwdNrW4jVWdtLtjTLf9b8Z5QIwKC5AEuowPbbxSQ9uR1iq?=
 =?us-ascii?Q?Z6a41V4ViKgfGv9iFQ7SlmFZlTZ4OLhAVql0Uyug5bzalPP9noEzDUhzdczx?=
 =?us-ascii?Q?OP4R67oxwRqiz8wxb4wZfUvKVWdGwc6GaMwyEZF9mzZGwwBBwj/GXpSfmpdp?=
 =?us-ascii?Q?7kvjX1Z9K7klmlpsrgcl9tmdwjD5XZP65gRuEhSBNKs1aURRTdYZL5It34qf?=
 =?us-ascii?Q?n3vUiudaNYpoM5Ax8dWx5hQabe8N93/YgdMPYCwe8+i16haZ2tUXk7vJ9zgG?=
 =?us-ascii?Q?rJGeAt6xaqj8SdnZaadIG8QsT97OpTOfdsK6IKZQfi35H4rBHXqZAWmmhkcD?=
 =?us-ascii?Q?tUr0oiSTtseUtKWV54/ZvfvCNhPh/Z1gGijFfDcJkAJS3Jea7BqbZXsLvcrp?=
 =?us-ascii?Q?YEzrmonAGx7IVZyWoIjxqIjbFgY+I8xhh7QV1cbq0RJ3ilTZvAXLbME3GGlW?=
 =?us-ascii?Q?ygjEqMY2Vkq0/NitBg0MMIDDDzpqcSRoMK8I7gVzc7nWwYHIHKBukF/SYfmX?=
 =?us-ascii?Q?FT/VRis+7nmzSuU+ZY6hepxWZfztz12tjCCUxXebVuTe381FHbneGbGQ9DiJ?=
 =?us-ascii?Q?kCWff6C+mAL0B3VQyLBBgw9kRjGFNo8HyJwju3MoUQC93GZLEEOH2D309S8O?=
 =?us-ascii?Q?PaYDGms0NzQ5vrYSLmSw1iVlfKbINniD6WFtPU/IFXo9YxTqLLJK/0Kk+gB/?=
 =?us-ascii?Q?i4PUvEKKTo4KjooMkDRTsta5cU0uhIefAV5lJ9t1Y9cp5/mPTWU3tVzcnXQA?=
 =?us-ascii?Q?Xl7e1m+q+zpxsEXiDxCdx1tTLKO2cw2GknFyZzme8mALpA0d9I/2k3/WvgVY?=
 =?us-ascii?Q?kEzzeo13362f2ZxnF+HsHE/gS5DO8osTxF/UcTkPaOAbtqsDL17o51gGU26W?=
 =?us-ascii?Q?4xmlWsbrOon1ZgQ4iAxbMvjXrMdg7T+rHxY8oQ3fwda4EOWqqtPUEIG/6u3g?=
 =?us-ascii?Q?6Zgb3aDvf6U8FbjqPrO+Tg0iX1VaPQgnvB23fyssmUR5vyAX5IyL0ZUDJsBb?=
 =?us-ascii?Q?hjkhRDsCfHf40gkTCkuivat6EYf7L7KTXYBSc/21oHtyX6TgsqBS09bqLH4f?=
 =?us-ascii?Q?rZtfikugJRGc+VJrBR//oKbsIFdmMI70T0W2Rs/+ZnMA989CdZUgiWKGQMhJ?=
 =?us-ascii?Q?Tu1LN4RE0O6pWKHPF6KiNiertsOFp2O6POHbTP9f6dNgisl8nl0ZG+DRSMKt?=
 =?us-ascii?Q?L/vfax7Phip0gkeeWGaXL+p/82EiD5kiW2Pkp9xWfWNyPaxD1+sKaes2t9hw?=
 =?us-ascii?Q?vsyo+GQDf3cUfMJ3oKuI0Y8oWKT1pm6MQsgLCbHpXl7ABg363CC/eEPGE6yD?=
 =?us-ascii?Q?h1NXRqnlkHy6aE4scbVPb1wXjkXJDbaaATrg2VK2Yh9yHw/AyhOVzhfnYFaC?=
 =?us-ascii?Q?rx+mg/s2d0Ze1IKPlypLzGwoz+ngfU1qmGBX+y/MwbojsSTTCMKHDTqkJ3MN?=
 =?us-ascii?Q?SquElHewb/LkEji3aLpGMCZaQDMw+ucv4Z19LuOlqbHwO5g2x0cCMg00oGNX?=
 =?us-ascii?Q?g5RJw0olmg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc37bc63-8521-4add-51ec-08df1f4709d4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:03:27.9779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoCyyN4jR492eGRj/LL68/NxYr+XAJ/I7KxIwWRfBzut46QEGgasJ6wNP1R1ILpXSaOL+b3WNGdCh5/Bc63sRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6934
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

On 2026-09-28 at 00:22 +1000, Danilo Krummrich <dakr@kernel.org> wrote...
> Nova exposes static information via its DRM_IOCTL_NOVA_INFO ioctl, thus
> add vram_bar_size to struct drm_nova_info_gpu and remove
> DRM_IOCTL_NOVA_GETPARAM and its uAPI definitions.

I see everyone else has already jumped on this but feel free to add my RB as
well:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> This breaks the uAPI, which is still fine at this point. It requires the
> corresponding drm-test change in [1].
> 
> Link: https://gitlab.freedesktop.org/dakr/drm-test/-/merge_requests/2 [1]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/drm/nova/driver.rs |  3 +--
>  drivers/gpu/drm/nova/file.rs   | 18 +----------------
>  include/uapi/drm/nova_drm.h    | 36 ++++++++--------------------------
>  3 files changed, 10 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
> index 46e13fe795eb..851d50b4dd15 100644
> --- a/drivers/gpu/drm/nova/driver.rs
> +++ b/drivers/gpu/drm/nova/driver.rs
> @@ -95,9 +95,8 @@ impl drm::Driver for NovaDriver {
>      const FEAT_RENDER: bool = true;
>  
>      kernel::declare_drm_ioctls! {
> -        (NOVA_GETPARAM, drm_nova_getparam, ioctl::RENDER_ALLOW, File::get_param),
> +        (NOVA_INFO, drm_nova_info, ioctl::RENDER_ALLOW, File::info),
>          (NOVA_GEM_CREATE, drm_nova_gem_create, ioctl::AUTH | ioctl::RENDER_ALLOW, File::gem_create),
>          (NOVA_GEM_INFO, drm_nova_gem_info, ioctl::AUTH | ioctl::RENDER_ALLOW, File::gem_info),
> -        (NOVA_INFO, drm_nova_info, ioctl::RENDER_ALLOW, File::info),
>      }
>  }
> diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
> index 766a6ddb7e10..a05264917a0b 100644
> --- a/drivers/gpu/drm/nova/file.rs
> +++ b/drivers/gpu/drm/nova/file.rs
> @@ -60,6 +60,7 @@ fn new(reg_data: &DrmRegData<'_>) -> Result<Self> {
>              architecture: spec.chipset.arch().into(),
>              chipid: spec.chipset.into(),
>              vram_size: gsp_static_info.vram_size(),
> +            vram_bar_size: reg_data.api.with(|api| api.bar1_size())?,
>              gpu_gid: gsp_static_info.gpu_gid,
>              ..pin_init::zeroed()
>          };
> @@ -108,23 +109,6 @@ fn open(_dev: &NovaDevice) -> Result<Pin<KBox<Self>>> {
>  }
>  
>  impl File {
> -    /// IOCTL: get_param: Query GPU / driver metadata.
> -    pub(crate) fn get_param(
> -        _dev: &NovaDevice<Registered>,
> -        reg_data: &DrmRegData<'_>,
> -        getparam: &mut uapi::drm_nova_getparam,
> -        _file: &drm::File<File>,
> -    ) -> Result<u32> {
> -        let value = match getparam.param.try_into()? {
> -            uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => reg_data.api.with(|api| api.bar1_size())?,
> -            _ => return Err(EINVAL),
> -        };
> -
> -        getparam.value = Into::<u64>::into(value);
> -
> -        Ok(0)
> -    }
> -
>      /// IOCTL: gem_create: Create a new DRM GEM object.
>      pub(crate) fn gem_create(
>          dev: &NovaDevice<Registered>,
> diff --git a/include/uapi/drm/nova_drm.h b/include/uapi/drm/nova_drm.h
> index a74daba6ea94..d7017ed17143 100644
> --- a/include/uapi/drm/nova_drm.h
> +++ b/include/uapi/drm/nova_drm.h
> @@ -18,13 +18,6 @@
>  extern "C" {
>  #endif
>  
> -/*
> - * NOVA_GETPARAM_VRAM_BAR_SIZE
> - *
> - * Query the VRAM BAR size in bytes.
> - */
> -#define NOVA_GETPARAM_VRAM_BAR_SIZE	0x1
> -
>  /**
>   * enum drm_nova_architecture - GPU architecture identifier
>   */
> @@ -77,21 +70,6 @@ enum drm_nova_chipid {
>  	NOVA_DRM_CHIPID_GB207			= 0x1b7,
>  };
>  
> -/**
> - * struct drm_nova_getparam - query GPU and driver metadata
> - */
> -struct drm_nova_getparam {
> -	/**
> -	 * @param: The identifier of the parameter to query.
> -	 */
> -	__u64 param;
> -
> -	/**
> -	 * @value: The value for the specified parameter.
> -	 */
> -	__u64 value;
> -};
> -
>  /**
>   * struct drm_nova_gem_create - create a new DRM GEM object
>   */
> @@ -189,6 +167,11 @@ struct drm_nova_info_gpu {
>  	 */
>  	__u64 vram_size;
>  
> +	/**
> +	 * @vram_bar_size: Size of the PCI BAR aperture used to access VRAM, in bytes.
> +	 */
> +	__u64 vram_bar_size;
> +
>  	/**
>  	 * @gpu_name: NUL-terminated full GPU name.
>  	 */
> @@ -205,21 +188,18 @@ struct drm_nova_info_gpu {
>  	__u8 gpu_gid[16];
>  };
>  
> -#define DRM_NOVA_GETPARAM		0x00
> +#define DRM_NOVA_INFO			0x00
>  #define DRM_NOVA_GEM_CREATE		0x01
>  #define DRM_NOVA_GEM_INFO		0x02
> -#define DRM_NOVA_INFO			0x03
>  
>  /* Note: this is an enum so that it can be resolved by Rust bindgen. */
>  enum {
> -	DRM_IOCTL_NOVA_GETPARAM		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GETPARAM,
> -						   struct drm_nova_getparam),
> +	DRM_IOCTL_NOVA_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_INFO,
> +						   struct drm_nova_info),
>  	DRM_IOCTL_NOVA_GEM_CREATE	= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_CREATE,
>  						   struct drm_nova_gem_create),
>  	DRM_IOCTL_NOVA_GEM_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_INFO,
>  						   struct drm_nova_gem_info),
> -	DRM_IOCTL_NOVA_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_INFO,
> -						   struct drm_nova_info),
>  };
>  
>  #if defined(__cplusplus)
> 
> base-commit: 10a6623a24a85708650efad7be15182289403cd7
> -- 
> 2.55.0
> 
