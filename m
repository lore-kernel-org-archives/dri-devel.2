Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EC7CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:42:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4EB688E45;
	Thu,  8 Oct 2026 13:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="IYGPvsF/";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA5CE10E011
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 13:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dl4NpEhqPoOm9SuIJdjooynN658MGvkrQTZ3FWolvPk2H+4JhJTGIMlVamUEJIMWD84DRFaLYFHMPHTaQcKkdQiJVD/ebhrDShCt684N8zKdnU0vKobEK5OORFGHivNWusNi7pR73JmYod9iG8m2KgSYFnsI2Iu3dQh/9hez0cGrrb20zw8KOKcxP4kcSz6R82j3feIAsq/Vquqn3Q8EcjDV4oW6+BPqgiMSH/a+dDKguGoz42cEnQTruDSy5Z3P2t7Yh+lPvWvRFs1O4iMcXgTxyqvBlUpGIM0N39CkSZJf6RKjLMQOpLpTB7H+kgQetq3X51Rfi9M6SsqGky4pWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2VdC2c96SNI7sPN2hQ9l4MdCQmxU8hsrMjN4tlvAEk=;
 b=F+qvzvf3MASKklW2xj412aerpogpSC6J4Hd6XecOaKD9pv5GpAc5UTVxLH2l0g6EfhziHrog9kM+XKAXXviYp4IWLhLn/sNV5RiYdE6th91e/TIqpFLF2hgW4eR45Xjjxi7TPyXQKTL7krwhgVfgFIsdub4KQ4Q0dt2EkK7NbUYB//FbZNDfQNWpMY1YbRTUyzSiLIv0IIOQapL3PXBjtlaeaEs+tMUdFRZT+nTd0VwKiBAcYlbVDyRK8D0FL+b+dgMYNp/ZYhVhPaTmG/FECu2pcBmCE15/nXeBt39AjZ9i5tHRpUs5mtB+fYu0Umto8GQTyyu/ymXe/7qYlzGZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2VdC2c96SNI7sPN2hQ9l4MdCQmxU8hsrMjN4tlvAEk=;
 b=IYGPvsF/yJzXAOJwC2FQ+OsDJ4DuXCWX64Vvb/5n7fyTNX3cdElNI1OW7y4svPCahR13gau4eulxp9fFa24Le6N7sV6cAmsm61VW3PkuOYb5oygd5fu+yHnt0e/tlF7UhA+zdY6fT4zP6PFkx5h1g8e/8lz28TrgoGjToS8t6GUJeQU3G7j4jC8lqs0biUQC3tjVuf89TPkhLPT91jLNCkzkKgaHOIUfyDSmEJcSYO22/psz50cdv9Zpu4H69kHieiDnQ9mYS6LedV4VskDEaUlYThHYv9rR2fjA6ty2KBLw3c97W4qH1nnwwQ2qS9jvS9y6Rw6/1Aq0aLFkNXyOng==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 13:41:59 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 13:41:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 08 Oct 2026 22:41:55 +0900
Message-Id: <DLZI0RL58KFW.3TV88Q5GZV5M2@nvidia.com>
Cc: <dev@nanonej.com>, "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 2/4] gpu: nova-core: falcon: Extract PRISCV register
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Antonin Malzieu Ridolfi via B4 Relay" <devnull+dev.nanonej.com@kernel.org>
References: <20260923-b4-extract-pfsp-registers-to-falcon-mod-v3-0-cd26aa94c021@nanonej.com>
 <20260923-b4-extract-pfsp-registers-to-falcon-mod-v3-2-cd26aa94c021@nanonej.com>
In-Reply-To: <20260923-b4-extract-pfsp-registers-to-falcon-mod-v3-2-cd26aa94c021@nanonej.com>
X-ClientProxiedBy: TY4P286CA0080.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae4aeb6-bc9a-450d-a31e-08df2541eca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|366016|1800799024|56012099006|4143699003|11063799006|10067099003|22082099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 3XI43k9o5hiht0jJ+JTQXqiaZTVlc+jeSDbeO4hMh+S5tTAsRDpIicKH3F/TsUMALqojUvKd7S1NuodDPps+E9O7/CpQX1m8Qx1gPHzJqGnaHAWZcp1F6BhP1w5FbGDycijvVdeyKdvoytSt5ntEWau6V6ieN1NmTXrD7HR5zlb2+YuETU1s+HNClpJdLGk6QXqUKnjKjwcZC2LxESa7w8xC2TAYvXpHyU2sWvt2/gU2a4/rEBl0q67W9ahicONHDKrzIF9U5AXMB10iaQTaBUMgyybh4lBoWRipckckStNjTPI07RbMQwd7ScvueSPBSsShjeBtdzv0ZLOyG8DmsnfNJLGqRZky5fhz52BhYZe4JJ5FvnKTtZTOkbsANGUY2QWugECwoSixGffWbFlTjZbtWMX7AtxJep8QEY61voAJqm1f4y1ViUn2HvxIU45YIRK8dJtLym9DxNmZTblpGHUX4ndR7t5uLNWWB3umiM13tUQorPfMR6DCOjFeZu4wevJk434K8utlj3+HfPGiUv0i57gblJiD7cXPxtgGrSrcHrKLSC5d43hqdm5DUJGQWBFotV1+/BrBcZqsMCxZVLz5O+92phlQ14liAlgPZ0l35RS4rJeuY2eiV4vGdLmN9LgkbjmlXZAMOv7pTYu3yNuwpalOc/JbfRzD1Idj5Vg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(6133799003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG9MMlZNOXJDN0NseTlkWldVSUZrNVJzMzU2ZG5DdkR2d05GeG5DVDhHaUpI?=
 =?utf-8?B?SGlJcXh5d1RMdEpMeWdCaDFwRUIxWXlvMk41eW9weFRpRzh6emNQclN2Y2xm?=
 =?utf-8?B?VkdESTFaU1VyMkJHaGl0VzNhR25KaVdRaityZmFQWTBDMWdTTTdMM3AweEhi?=
 =?utf-8?B?QzVXMmplZFdKTzhWUnJWaU5NMWdnN2F2SWJmbTgveEpwUUVSaGVCZ2lKYW5n?=
 =?utf-8?B?M2dLbyt5ejVvUkhKTUtTalJNdGYwUytFRVNGR3QycVYvaFJZcEtOakVIV3RD?=
 =?utf-8?B?aEp1eDRsUVBTVmw4Y0tkVDNzTUdpdEJjTmFlNDNiYWhWaGFOMlhnSkNxdDZH?=
 =?utf-8?B?YTNIVnUyZmFERWZ5N3Z2NTd3MWZJQXh5Rzg1VWordDZRSUVKaGVva1RPNnpF?=
 =?utf-8?B?SncxUHMrUE9BVVAxRTVIanJlSEZ0S25Cc1h4MnZXeU16ZWZYTmtWbURTNUFM?=
 =?utf-8?B?Z09kY0FVU2hpNXA1ckhMN3d3Mk9CZ1lESkxkYk9hdmdpTkM2QnNwRjBqQ2lx?=
 =?utf-8?B?cml3ZFhYcEdBelBWc3N5WmpUcENjdHRYb3Bld0tBQ0ZTbFZVWjFYZGplVi84?=
 =?utf-8?B?V3lvQUtENTdYSmVqWVBsUTJzSnJsb1MxMU5rR05WdUV3c211RWI5QWJTY2sv?=
 =?utf-8?B?ZW9FMWRoYXZlNHZaWk82elJLUnVvd1Zqd1hjcmxRV1IvaVVOUzRiNTBzaitC?=
 =?utf-8?B?aFRpRnBIcFZsY1dlT2dINWlBekowU0tndExHVFFpQ2dTNmhTWXpHM2pBRW40?=
 =?utf-8?B?TUY3UHBBdGF5RWxuVVhKTURhSmJwYlE5QTZwNzdsbUZNTjUvZFoxb3cvc00z?=
 =?utf-8?B?QnJTbSszRnRSTEd1RjhjVU85MTQzTW8zY1ZicWc3NnRrejNUdFk0L3gvOHAr?=
 =?utf-8?B?QlhIVi9oUy9YN3RYNmV0TjdoMDdlWGlNNDlEMkZRalFxQVlWczBCWkRjR1pm?=
 =?utf-8?B?ZTVyMFlTV042c1JQTVhScE5SUXFDTGplc2dxbXhQeGNRL3RQMWRQN3dLWTJB?=
 =?utf-8?B?djUrZ2RyNURBVnUyWWQ2T0RQYittSSsrVWt4R1dnTHUraDZoNjhxY1J2WUxK?=
 =?utf-8?B?cEVXSXpHQWtxNmxGSkFQeUJKL2IzdXJnZ0doMExKZGZ0SUFUM1N1dldNQnYx?=
 =?utf-8?B?ZFZldEpkRlVCRGQzUEpDN0dudlYyRStBeDhmUndZbCtPNy9obWI5cERWVTJD?=
 =?utf-8?B?QW5iOVI0ZVpIYWF0TU9FbXh1UkZkd2t6WEtIVHRUUHBuK1M1YXZHdmd6SEkr?=
 =?utf-8?B?RnpNNSs5TzM1bjZjMC80eUNTQk9qRjltOXpPWmpHbUhGakxYMjdyMWpEWmp3?=
 =?utf-8?B?M0YyaHFFODM0MFg0ZW80U3l2T0lYOUJKTk4vQVNVUzRHcHhiMi9nVytmWVhl?=
 =?utf-8?B?UWwvdVNpZitqYnFKYmErTFdWR0F2akpuV1NVeHJjQWw4WkxtZ0hKOE9pdHlu?=
 =?utf-8?B?WUxhenZhZzlERW8zNWRmNlpZajluaTZZczZybG5CdjQ0MGJuNjRFcUF2RUZt?=
 =?utf-8?B?RFYrVHM4dmk5ZEFkb21NdFBONDZiZzFCaW8xUHRpQ3JHYTlKOEpRUldVTUli?=
 =?utf-8?B?SGhibDdlc3hTd1V4T3Nna3FCc1dmdUdkVWdVdlNLbEhDcWdjUFNSR0JmdENR?=
 =?utf-8?B?SDAzTmgwT2RhdTNMZi9odUM5dHdjL2l4azBhaG9QWlRTNGNjNVc1MHhLL1BN?=
 =?utf-8?B?Y1VEMllkWmxVVUFlSHBmVVpHMjJ1R0IzbnAwTmo2T2hLSmtvd3NuMDVGSTJm?=
 =?utf-8?B?KytScG1tNFF6N0M4amFNVW5qYmQxRjNObVZUZWZWWVZTbzN6RnRLazlZR0I4?=
 =?utf-8?B?RGx1cjc4eHM5T2tJUWd2Z1hmMytNdGNZd2x4eGlvbmpMYjF1Wkl2S2ZIK2xF?=
 =?utf-8?B?Z2RYcmg5T2VFNHBYTzRTTG1zUzllbHpKU3RPYUJqeGhJSzc3REpFbDVmQmY3?=
 =?utf-8?B?VXpmQjBDZW8xZEgxYkh3Tkt5UzBways1ckVsamgxamhJTzhIYzBlWnJ4TjRl?=
 =?utf-8?B?NGNwalkwQUVLRmJVdWFjQ09NUGlic1ZtRUl4VDZ2emJlRWtLWlZubFhjYVNn?=
 =?utf-8?B?czgyUk5uM2YrVWIyMmtDTHRwajU0VVBqYVlkYnFVVVdSeEd6Sy9UNzdWVEZz?=
 =?utf-8?B?TzAwdVIrUTZEbkpRZzVSaDFKSmlRWGVId1U3UW5vVlpJSXhTQlFxTjBOOXV2?=
 =?utf-8?B?L0FJTzBRT3BVVXgzTnFkaGpPcm1mNlIvYlpiRU9RQkxSdTZXQ3VyTEZwUlBE?=
 =?utf-8?B?TTh3LytrT1FNaDZYUkxjSzVvQUpaY2x1QzhXUXZndjZkYVlRY3pLTGtCc0pa?=
 =?utf-8?B?ZWhjOEVXam9LRWY2TkRiL3dFQ1Ezd2RJZThXQTNONFBhU291d1JiS1lXNk9q?=
 =?utf-8?Q?t4x1lghysvQ4OWa/WGpFOjrf660vqHPN7q6uvoBr6YHxX?=
X-MS-Exchange-AntiSpam-MessageData-1: 2Ew3xnWd1zezTA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae4aeb6-bc9a-450d-a31e-08df2541eca7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:41:58.4998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjvKw/RD7vbum8JIaauKz79aUW41n4Y9GYQ23tCxd5NocXqoxE0FfqfDGEJI2YMcKD/Sk6zhje3mGVX/jyFT/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277
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

On Wed Sep 23, 2026 at 10:09 AM JST, Antonin Malzieu Ridolfi via B4 Relay w=
rote:
<...>
> -// PFALCON registers are defined in the root `regs.rs` but are part of t=
he falcon
> -// interface, accessed by the whole falcon module. They are re-exported =
here so
> -// falcon code can use a single `regs::` prefix.
> -// Once the PFALCON family moves out of the root module, these re-export=
s become
> +// PFALCON, PFALCON2 and FUSE registers are defined in the root `regs.rs=
` but
> +// are part of the falcon interface, accessed by the whole falcon module=
. They
> +// are re-exported here so falcon code can use a single `regs::` prefix.
> +// Once these families move out of the root module, these re-exports bec=
ome
>  // plain definitions.
>  pub(super) use crate::regs::{
> -    NV_PFALCON_FALCON_BOOTVEC, NV_PFALCON_FALCON_CPUCTL, NV_PFALCON_FALC=
ON_CPUCTL_ALIAS,
> -    NV_PFALCON_FALCON_DMACTL, NV_PFALCON_FALCON_DMATRFBASE, NV_PFALCON_F=
ALCON_DMATRFBASE1,
> -    NV_PFALCON_FALCON_DMATRFCMD, NV_PFALCON_FALCON_DMATRFFBOFFS, NV_PFAL=
CON_FALCON_DMATRFMOFFS,
> -    NV_PFALCON_FALCON_DMEMC, NV_PFALCON_FALCON_DMEMD, NV_PFALCON_FALCON_=
EMEMC,
> -    NV_PFALCON_FALCON_EMEMD, NV_PFALCON_FALCON_IMEMC, NV_PFALCON_FALCON_=
IMEMD,
> -    NV_PFALCON_FALCON_IMEMT, NV_PFALCON_FALCON_MAILBOX0, NV_PFALCON_FALC=
ON_MAILBOX1,
> -    NV_PFALCON_FALCON_OS, NV_PFALCON_FALCON_RM, NV_PFALCON_FBIF_CTL, NV_=
PFALCON_FBIF_TRANSCFG,
> +    NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION, NV_FUSE_OPT_FPF_NVDEC_UCODE1_VER=
SION,
> +    NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION, NV_FUSE_OPT_FPF_SIZE,
> +    NV_PFALCON2_FALCON_BROM_CURR_UCODE_ID, NV_PFALCON2_FALCON_BROM_ENGID=
MASK,
> +    NV_PFALCON2_FALCON_BROM_PARAADDR, NV_PFALCON2_FALCON_MOD_SEL, NV_PFA=
LCON_FALCON_BOOTVEC,
> +    NV_PFALCON_FALCON_CPUCTL, NV_PFALCON_FALCON_CPUCTL_ALIAS, NV_PFALCON=
_FALCON_DMACTL,
> +    NV_PFALCON_FALCON_DMATRFBASE, NV_PFALCON_FALCON_DMATRFBASE1, NV_PFAL=
CON_FALCON_DMATRFCMD,
> +    NV_PFALCON_FALCON_DMATRFFBOFFS, NV_PFALCON_FALCON_DMATRFMOFFS, NV_PF=
ALCON_FALCON_DMEMC,
> +    NV_PFALCON_FALCON_DMEMD, NV_PFALCON_FALCON_EMEMC, NV_PFALCON_FALCON_=
EMEMD,
> +    NV_PFALCON_FALCON_ENGINE, NV_PFALCON_FALCON_HWCFG2, NV_PFALCON_FALCO=
N_IMEMC,
> +    NV_PFALCON_FALCON_IMEMD, NV_PFALCON_FALCON_IMEMT, NV_PFALCON_FALCON_=
MAILBOX0,
> +    NV_PFALCON_FALCON_MAILBOX1, NV_PFALCON_FALCON_OS, NV_PFALCON_FALCON_=
RM, NV_PFALCON_FBIF_CTL,
> +    NV_PFALCON_FBIF_TRANSCFG,

Mmm, this is not great, quite a bit of churn and in the end we only need
to import 4 registers IIUC.

How about this: as a first patch, switch the registers module used by
all `falcon` submodules to the falcon-local one, which only does
`pub(super) use crate::regs::*;`

Then, move the registers as you are doing, but without updating the
imported list since it is largely exhaustive.

It is only after all the registers have been moved that you can import
the 4 we still need. Or rather, I'd suggest referencing these using
`crate::regs::` to clearly signal they do not belong here, and remove
the `use crate::regs::*` that the first patch added to `falcon/regs.rs`.

That way we limit the churn in the series, and end up with a nice, clean
state.

(my apologies as this will require a rebase - sorry also for the time it
took me to come back to this)
