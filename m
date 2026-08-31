Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF33C61DF0
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 04:58:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77EF010E5D3;
	Mon, 31 Aug 2026 04:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="X7ipUNr+";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011026.outbound.protection.outlook.com [40.107.208.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEE4E10E5E0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 04:58:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJ3qGoPvN/pCPd49f6de7VfbSHQmoWIxZtWxjf5LcFVR0sa8iHzqt3Nes6gWISFkZ5Ll9uvb2KNc+xKaxUWOhZ7Ls8kcYJyp9t3zHZDc+QGuGICF+BV2fT8LrJPTAxwOTYF8jmRFG9+tCvFk0/ykMNU8XuT5tk9Xv7QAUnbKaW0OBzruUs46kqNNLjhDiUXBPtFN33b7ValtRW1TGqeonpqU0B2B2Uw0heNDRgF0rkeWVm5RJqrk3zXQpNQyF6k4sfl31Xh9o420mKMJ1X/ZSaNP58LXjueL+9oBlmeeNnHt2J25i9kXwrFUwT0NK++LIGBdbJZ1zn36TZ1UmsiJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBQSDs2nN1CrMzj3ktfJDrfbWEP4JfgWucqRCl0fZqk=;
 b=NI7EfvfD8BBD94kHfJHGTdDqYZnT2vJcwPP1EN7Ehzac4BJK7Z9b6ocRBkDPzTEmbavJb87HQpi33u/62PfJaL+N8pb8KCP3KwnzntnGmQAvc/gF5ZhXK+RrcKvSCmGSks/eYS3lQt42EHJM5RMzaZF3/q5BoUxxfNwTk/yddZlXhYNXAe6q04A9RGJ2aAqbYd05M+slsqTipKzl+tZ9OvosMaUsWsUB8i1tapBG1O0J9Wc+GvhbjRZRYVehtCnrnyXYqb5gnZT6P1i83CzUrRxf4GtYY5E/XBf18A1LAikB6nCPKpo+ezVE/cyqMow2p9CjrKD8M1lCTgt38e1e3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBQSDs2nN1CrMzj3ktfJDrfbWEP4JfgWucqRCl0fZqk=;
 b=X7ipUNr+rKudgDYvZFnwpqJlW3NYm1SKjFipodQJEe+SbCnUbWu/3FzLD/MW2UzIxxwtbKbiAEcFkfq0qartoTOqJXVDnG5D11WEJ8ENsJqXMxn3HM4F59vdbtyWCSK16WBG0bSPU19uDRzEiCdVX2Gq1zixzfN/3T1x4sS+wd15+t07Y3ME/J6oMC48aVw27mR8YDkfQ4WmFBJq7cb0Ummt0Q/XirMqN3khzLfsmf7wBZnEIxhJUQxhX8S+umtB8pSWk2IdY7JZ+c6A/QdC2XOU2IcAynuSgVwvT4aQP8U509UXxUzBNVnO3jpi4iRRAYnwCO3J12MWR0+dQqHAEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by CY5PR12MB6599.namprd12.prod.outlook.com (2603:10b6:930:41::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Mon, 31 Aug
 2026 04:58:06 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 04:58:06 +0000
Date: Mon, 31 Aug 2026 14:58:00 +1000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: M Henning <mhenning@darkrefraction.com>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 05/11] drm: nova: Add an info ioctl
Message-ID: <apUIbKQaXrLwskPP@nvdebian.thelocal>
References: <20260828033531.1117754-1-apopple@nvidia.com>
 <20260828033531.1117754-6-apopple@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828033531.1117754-6-apopple@nvidia.com>
X-ClientProxiedBy: SY5P282CA0027.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::13) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|CY5PR12MB6599:EE_
X-MS-Office365-Filtering-Correlation-Id: d90e8dee-25c4-4f8e-e503-08df071c71d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10067099003|11063799006|4143699003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: L1mVr7Ig7c7ILp8f8hZFMrMzjpZwRrTbELeuQ7Xz2LpA9ohDB8dX2BPO5jEtyeZxvmzkbe64duYmyUmPsXj8gIhbOToOAc3szuSUuLnOYw3oDzgr1/ov+Tg8yvL54YYjEMZou3Wa5wbddNxvdIJxT4mhNQL1y+7sdNM2MSzzEa5fQElWMTTcvysXnMhm4ShVYn9fJKfAwGFAow89D1D+AJAIRXLfi3NqfZAsnLFDmtCHmQxsV8HMD/l41RCqzX3M+rOtbwvdVc0uQZCcqyp2WGyNElZWyYiRUQrIcnoXLcomiOi6+MN084nagn+w8bopfp2IDK8/1H6H/Jc7sr7MSr5RF5jp0XaFdtu/ETewKYbB+/AaigX5NU9HbmeJifXcL3dzDCvDKbGKM+638M6d+Pzw0+1b12OHJMvHrn/Op41xm4FeT98StBuwK3xGtITXUwPKoUFiPlYbawfKoaQ1Panxguw+m8ltgUEAcPTdJlekH605iMaVYPUL1gQXN6CjborehJkTp5DoPdOIlcEyAn15ogV/u5SyoyzlB/tPIsEInOcXWjU/51IVQ/IV5Fi1B6FlhQ/6AqaXR5JqwVarLTiY9p86hxgX6pWbiJhl5fkm8cne5300gEnHHOY21OD5oJ7OpTmgSUPPKGZp6uMzJIl9p5sfN9/2yQnZCrS+sfM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xUgiCLCKvuDRMhOyA6WiVUNLMonfFEnT8LOAXEYpX6Xhg5yrU70EkBBQHYLX?=
 =?us-ascii?Q?wXl3mGgqShvNPjRLwTRmayR3BNn48vP8o2CDJ9IaxjYLlQshvYmkQ72tkZ+x?=
 =?us-ascii?Q?q+nDV4aJpZ5rodhtyQUBKn0N8mGPkTkMVHTvOc2Wfik5RYcWOd4cuvyIZCib?=
 =?us-ascii?Q?zlhoXfN+8hiD/SGS/5ar95LknPdVOB4QJTTXC9dZYgoXKWZhTfJocfsZqjke?=
 =?us-ascii?Q?OXLhwT25Ec0WtX9u3C5AypK59XH2Fj+WgwFwBA+3rQ5S0jhyRKPh+TQaLwny?=
 =?us-ascii?Q?hEWZOtbDRgbxKN1pAm3HRaZoIwtnEuQFa/Wb3wtVBwjpQ/+KGlSBVloAwgNt?=
 =?us-ascii?Q?Ncnl91ee++XjjsFlODujlNOJIwPS7I2Y73dnPwEZ7IHhF9lCS41Jp7aMpG+N?=
 =?us-ascii?Q?tuWcfL9oM6nLLxnQi10KemE7ilnEXEDqkL9vrhE0bxwEvtEWvPgLtKxtHT8y?=
 =?us-ascii?Q?sljakn3Oy3jppaRC9wTj/FgHa2T3UjY4R2xRxaY0mB0DLlMJai65VUnyGA+L?=
 =?us-ascii?Q?+X2a7hl6Ln9Jv+bSWMJx6wlcovMX1ENtBSCKG58irQyWBxN+6ySvOQSYsNhj?=
 =?us-ascii?Q?uln2Cy4B6JtHmHkFdQKg3X/Tp8OfhqrDWuwX+GT5CtAXylD2zGch/tU7mreg?=
 =?us-ascii?Q?jcWnV87RyE5QDx0NDu2hY702ZaYgbGDC8n0r/RTGqW5DV9C/PR26eudDE0MC?=
 =?us-ascii?Q?6kkYO/2HsKOtet65jz020vAvhw1xn9x6c7t2YSv/jbYpORwdRv7qf+YxnUUf?=
 =?us-ascii?Q?QERzyHD0XGSGoW5RSF4/u7ObXUuzsJTAabai16Qd7WvsNIdPcWBSaOgvAatB?=
 =?us-ascii?Q?2XpUsnkQeJxRZZum6ECVfzpowdXX+a8my/fvGriuE/t3gEQyW2jUXXEjTeoz?=
 =?us-ascii?Q?fzf4EUz+6XbchEA3jjcl42WTsrRCaQQe/C6PyjbbSWJ3DzH8lyaNBUmCg9ZC?=
 =?us-ascii?Q?Huv9V+qpywI5KLo2b79ON63gWr1hSWihe36a0DmAYqz0gYY/nJVYcrWogYjm?=
 =?us-ascii?Q?2LjtbqfVREzNaJpbZdRjRHg/STqhomNIaaQjOTkQBBzLPvI2bh8WRzh3s5L4?=
 =?us-ascii?Q?/yl05TNupLIqB8uoY6At1h0rZELaQhmKtmcLeb294iAXK8Zb+q5YL2Ikm/cQ?=
 =?us-ascii?Q?s1LRhRTUM2mp8IXQCBawshKfRIZF+Wrau0pw4YO4CFEMLb1Ctb+jDFRWK7iB?=
 =?us-ascii?Q?iEwRxM1BFqAYKK5DJ9Hfjve241Rc//+wbVybLZiYsH6RkDoXrqxStmlU3eFK?=
 =?us-ascii?Q?sAJcSzKbQeadMSjPQ0iWO4UnS9J6m4vBGl7Hh6gKspDOQeU2gnzb/2Zg3Jwj?=
 =?us-ascii?Q?9E0Ly9LFt4yUOlp3by4HJUztbaiP4K19q2J4bxQZh/MkG7dsqZ0XmhoQIAh6?=
 =?us-ascii?Q?SPWUNkZn0dGPzqc4jg9yfVBMp8BpEi8RXi1wfbzKFcFZ0ox3sEIsYM6x1dsh?=
 =?us-ascii?Q?bn1DEELr6xq+kqM2aRAPnSuo3gj4s9nt7EkfcZcA5J3LTV9xSQNQZR4EGAQV?=
 =?us-ascii?Q?l8/I9N/mFQmKpxsOEXCBc8e4g6EpPawqaRlpqCtaZQt9nnRHr8hfPQ78Rlv4?=
 =?us-ascii?Q?Yl0KuBc0wPQV2u71X9715kmtuLC/qsi75AnUeh0kbLmJOT1ktPEWZ7oBgFiG?=
 =?us-ascii?Q?PDn8VeOXE1JyN+s9Z6+0QnetHKKbLZblmlVIvagXxbxI4bBJ5XKY8ZOPhIsq?=
 =?us-ascii?Q?wmYc8Yk7AxTbjR5YrsDoudKOmGcBNgKKxabCylSt0yeXHiolXDVAuxh3bnt2?=
 =?us-ascii?Q?uW6WTCN9Xw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90e8dee-25c4-4f8e-e503-08df071c71d1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 04:58:06.1834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nl1TPmYd/HXei3VRVHF4cMrFc33qlIDSveSZ1mcx0fzLUgsX2/JBzEaOWV6ZE10vn764tS1a/LeTyu8EiU75Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6599
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

On 2026-08-28 at 13:35 +1000, Alistair Popple <apopple@nvidia.com> wrote...

[...]

> +/**
> + * DRM_NOVA_INFO_GPU

Now that we have the possiblity for multiple types of info calls I'm going to
rename this and subsequent similar usage to DRM_NOVA_INFO_GPU. That makes future
definitions more consistent and keeps them distinct from other UAPI structs, i.e
DRM_NOVA_INFO_<type>.

 - Alistair

> + *
> + * Query GPU information. The result is returned in a
> + * &struct drm_nova_gpu_info.
> + */
> +#define DRM_NOVA_INFO_GPU		0x00
> +
> +/**
> + * struct drm_nova_gpu_info - GPU information
> + */
> +struct drm_nova_gpu_info {
> +	/**
> +	 * @architecture: GPU architecture identifier. See
> +	 * &enum drm_nova_architecture for currently known architectures.
> +	 */
> +	__u32 architecture;
> +
> +	/**
> +	 * @implementation: GPU implementation identifier.
> +	 */
> +	__u32 implementation;
> +};
> +
>  #define DRM_NOVA_GETPARAM		0x00
>  #define DRM_NOVA_GEM_CREATE		0x01
>  #define DRM_NOVA_GEM_INFO		0x02
> +#define DRM_NOVA_INFO			0x03
>  
>  /* Note: this is an enum so that it can be resolved by Rust bindgen. */
>  enum {
> @@ -104,6 +151,8 @@ enum {
>  						   struct drm_nova_gem_create),
>  	DRM_IOCTL_NOVA_GEM_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_GEM_INFO,
>  						   struct drm_nova_gem_info),
> +	DRM_IOCTL_NOVA_INFO		= DRM_IOWR(DRM_COMMAND_BASE + DRM_NOVA_INFO,
> +						   struct drm_nova_info),
>  };
>  
>  #if defined(__cplusplus)
> -- 
> 2.54.0
> 
