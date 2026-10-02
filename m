Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BA6CA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C49BE10E47C;
	Fri,  2 Oct 2026 11:38:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZvIW5Lx/";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072B910E45B;
 Fri,  2 Oct 2026 11:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHcutkD98wdDzGvumG5Brzf9ecjAFMEI6dBsfWxaDualZmYVurAkvkJru04GNCJVdJFAjGkijoDgzttQDX+6x5RDGTBQ9VaWPrpPRluXqj31CFg2ExAC9sUjP+3BFb8+qZZ52hh8NmglpffGHkBsIM26jY+mj9DQYowchDikcIVju2cqu9Z+cP5+GPa+FjK0WbfUW+hhHeYQIr2sMISgxfSddZ/C8tCFB9bHsngLX2xo7Cf+2It29W9OW26VvvapTA7bSuJBcEvQ07MOP4aq0TDl+e5TzrSw0I1QxzpYJyB7Vx6LB6EfhjzLh5t02Kn6X/Jt0Qufk0UPtlB9M0d46A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmR1xWxrP3uVX5BSQEM3E+3INTnl02c004Hfy/4njSk=;
 b=cD10fvBarUEdfzdeXD0DFd1OeEETJzU08JtRqQP2dYRmxed4e861vMm+VeqJOjJo2lY+pBc6UFlB8pjdLD7teS2ckk+tsYxCBXuFC1H0JW82iXre5Ap3lgdS9gPSPpnfJLROViZlktA9vNj+w0fYj9Euu6J9BzrUDMiAP5M690MUwzas1aTpcGRTDEbYQHhPr60AYoueTNmNhzz84DaiaX+4IzEtZSN4pEHTiwyyjqLlxmK3zuN6B3qNgWjCYtIbUq6v95GyCtnvvgMHfRpwUOX8piEY57VpnL2kuIOZj3H57+EgxmgCuhhgdjKKaaeiZr0d1GFhJR2k5jUAElOT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmR1xWxrP3uVX5BSQEM3E+3INTnl02c004Hfy/4njSk=;
 b=ZvIW5Lx/+gA4n7q8pPJg8H4hyTOAigwjNl3wE+Ds4TwLQS+5irMxRZHfD1qOxT19FfGOzf+gkmDskLarCDLCifdMCuRxHHeUhfqolrwonr1bRRIZzbqdo9qKsB+9TqeOKlPoay7WTIHfXmgwSyTKe6LKPm9xy5pL7HHcNUumtAU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV1PR12MB999306.namprd12.prod.outlook.com (2603:10b6:408:3f8::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 11:38:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:38:34 +0000
Message-ID: <981f01e1-0c3b-4854-9d72-8bf22af9fc64@amd.com>
Date: Fri, 2 Oct 2026 13:38:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix kernel-doc warnings for cgs register
 typedefs
To: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
 skhan@linuxfoundation.org
References: <20261002021750.13596-1-emmaonana18@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261002021750.13596-1-emmaonana18@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV1PR12MB999306:EE_
X-MS-Office365-Filtering-Correlation-Id: c00349f7-bcce-4f2e-9fc4-08df2079b131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 9s89wNNmgDTqYjAjs4ntaUT/PXNQnzYp59biC8vedj24VvXZa4JVactWlLWpqRnoao8LmTrYoGyO7LzvM3wqrPHMhrh9TbHZe6oik5RRBr8nQvs5FM9PFEbzKLMipHfhIzdcv011IuDJBg+2I2KXXOb7esvVDDBTmDmmD96b2ROD6/9mTZpHO7kkypkZm+aicQRKhLVyqDBmGRAmef8z0Wk3Xld5ubiz9CryT4pwz0yzNSyE1lOmELkGxKCNwYmRiJZBpNebYJM7FgFptDQ5ArTO+s0mfQZZQIBF3GYtmTMC0BGF+9oYKnJPvk9p/Nr9WgHRcEPqwdVEgMfgGzr1MFXkwA2ikjVvuwHd7raqHAGa1iu/oMsbn30kX9AZNKtxDZSnzUErVH0tWqMPYbwz7ikfl2gb7vTH2a/sQxAVSzR+AOJtwjqvl/7gPXrPGhU6h/Zt+Q/G5xClOKNY9lf3CpMQgzxoilVHQFyIg54CraC1gtyWJaZGCezuBU/VmHvZQ8FXqq8BZMT08SHbl3O7oA4NIwnE5eZOHriP6tAp2LxEScDBFSiG5NzhAYa/FBYc+w1FQM188e79MS6yuCLdv2WVZIM6bMdfb+r01YYno2uGqCcUdP6sG5+lGA29OFiZjspNGvn7wXUCI8rqYTT2JAv8dk+XACpwpTBeNmKYPzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhlN1pQS29lSExGYUttT2NBWUNwRkc4enQyODdBbWZ2OVo3SmhqeHNwV2I1?=
 =?utf-8?B?VzAzbmJBdjd6bmpqMWtaNjNQZ0s1SU5SL080bE50akJvdWVrK0QrZFBzck5x?=
 =?utf-8?B?V1NYdkYwRWlSMnljNVFwZUpnaDQ1RWVRYkt4SkZ1eER2RXZncStDWDJ1aW43?=
 =?utf-8?B?VXJ0TWNqclh0SSsxMkdReWdxYTV2SkxwK3cwaDBKUDJiYTVnL0VMODdydndK?=
 =?utf-8?B?eEVuckIvdm5oaktLSjZtMVpaSEhiUlpHWU1aNE5RZ2lzY3lwcmZpYkV5aGJp?=
 =?utf-8?B?My9RRzM3UnFDaHV5QVlzNGxRZXh6NVFSVzArc0hFUGVXNkt0cUVYUFVGYXll?=
 =?utf-8?B?cG1BMnpRcXgyVitrSThBOUgwUFNZTFlOY1V3K2hzL2lIWlMrMWIzYlp5cWQy?=
 =?utf-8?B?VVhabXBoTFZFMVpJdUFvVnNPWHFCdWw4MDZnWkpzVU0yWjlwTHJJNS9oUlhC?=
 =?utf-8?B?ZDVjWmJlTGJPdERyTU13a0p6MGUramM0ME1HWnU4a2ZRZExTbEp0YTBNOEN2?=
 =?utf-8?B?aDFpKzZFVGQrTVduRzRSU3J6TlpQL1ZmaHNJSnRWM3VIaGtuTlRPQmw4MExl?=
 =?utf-8?B?RDFCODdTN242QjdrT1VSbjE5RVRLeE1Cc0EyUWZMNEZqNEJRQ1A1NDN6NXps?=
 =?utf-8?B?WmxiQnB2T3NKZEpNcXRFZ2N6elZKWU5KRjNiOXAvTlh1R09WdkVlTy9NZDlH?=
 =?utf-8?B?TjFscEt4ZVE5QVJKdVNUcytBWDR4d1BpaGhFS3BXS0NVdmsxR3ZyMkRzaDVk?=
 =?utf-8?B?NWhXTHI1bmZPLzdNdEpwSTl2ckdqdkJqejRVc3pORXBjbjQxeUs1d293eWdm?=
 =?utf-8?B?OVp3SFY0NUl6TlA0TGc5SWV4cytueGpGSWVLSnppc2tsOFJWTy9URFhYeHd2?=
 =?utf-8?B?RUczUEFlSVFMVm9lMTlhV2tnRFYzTnE5M0tLM0ErV1ppTFhRQzRETkJnMGxZ?=
 =?utf-8?B?VVFGV3dSZDlwTkhaUVFhZm05YldGZk1EQW9tcDJEeUNUdEZXUWFsdXhETnQ2?=
 =?utf-8?B?MGNHTFUxQWY0MitUZjZWeHR1emJpU21GZWFiVjQ3R1VqWkRtMEdFd2QyOE9E?=
 =?utf-8?B?MzFtam5kUkhoS2xXNi8xWmxzSG1jTFRJZy9xNFFuK3VsMVdUOVFTZUM5TXM4?=
 =?utf-8?B?b2c1dmtMWTFGK3Z4b0c2ckp0WEZrdlcvZ09VamJkTlFtTVVDNFpIMWFxSFIr?=
 =?utf-8?B?c1VUd01CYUdBZVYwWGZmdWZBeWg4T2NxVnZrMXdDL0ZCYUN1d1pEb2RqaXdi?=
 =?utf-8?B?OGFtZ21ST0JPMjU2MWdnbGlHbzhZLzREbGsvZktDV0FSbG9CUDRrdS8xR3NF?=
 =?utf-8?B?aTIvYWMvdXpYcWx6U1BPY1dMQjNVVWFzSExDSFhCS1pEUGRoR3JXQndhMG9T?=
 =?utf-8?B?Y3pTbEhxMHc2SmFrVVNyMXJDaFhRbDVOWWgzYlhBQUJjRHNVU1FvTlYydmg5?=
 =?utf-8?B?RkpCdkUxeU9VVE5nR21BV2tVSmh4eXg4Y2J6cWRMUVAyUitEQUk1ZUsxOTlY?=
 =?utf-8?B?MG5BUWlyaC9XcjloZ0pMbDFrSHdlcFZJNEtFdWJQclh0QjB0S205YmtITFQ4?=
 =?utf-8?B?K3VlVXFMenBXMHJnejlwWnl5Z2Y2MnpIbElQdzJQWkZRVHhYTEs0OGR2YTRN?=
 =?utf-8?B?eGdKN3RtMlVSKzdMMTZNT2FBS1ZFM1dickhYQkxHUTB4OGxKSmJ0OGxVM29i?=
 =?utf-8?B?MjV4Y3ErUFFybkNyQzFSRk5KZkU5aFhHeU5jMkptQ1J0TVp6WXpJSzc3aWxr?=
 =?utf-8?B?Zm03T3pUTDRTWlkyZFFKcGFWNFhpemNJVnRhRGk4eThYZ0pyVTZxNk1TUit6?=
 =?utf-8?B?L2c2TnRleUxyUzBkbzl3Mis4UUxsdksxNVYzTlAzRFhSbTVCbjZrd2ZSaGZh?=
 =?utf-8?B?MGZkL3hHNVd6NTdFVXhQdnl1Tm1jT0ZYVUlTNzJoUGZaMFpZckVmbjY0ODNx?=
 =?utf-8?B?T2JDYld1RU1icUFLTm9pSlVuUnB4bDZhMUhIc3RSOExWd1RaY1ZORFg2T1h2?=
 =?utf-8?B?Uk4vN2ZjTFBzbllLeGNpRXBQdjBJRUREalVZSGFJRmRoaE54aG5NMktvTUgx?=
 =?utf-8?B?U1Z2VjlqVytRRDREVkhjQVdySHlsV0N5c2R4OU4rZmpjUnJEY2pGMVlRNUxW?=
 =?utf-8?B?ZWlycXlKMlJtYzBtNG42T2tkanM2OSsra0RJSm8yQkUxZi9WbytaSFcwUVJI?=
 =?utf-8?B?em43QmJsc3VZbzl0N3lyenR6VStOVlhMU0lnTEtWRStadW0rNjdnbGp4SlFM?=
 =?utf-8?B?blJ1aDZDb2xUOVE5Y0lvMHh3d3BqYjlQQjk1QVhZRnFiUHhORjBTbjEydkZm?=
 =?utf-8?Q?bHSOzNVsiUqgdCXYsW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c00349f7-bcce-4f2e-9fc4-08df2079b131
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:38:34.7223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byvUFG6COqcm1QCdKkP4+jmwKOWl2uBI8OYB+n6Ao+frEyuZsVZRtg2a4J05JV7U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB999306
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

On 10/2/26 04:17, Omokefe Emmanuel Onanaroghene wrote:
> kernel-doc reports prototype mismatches for the cgs register accessor
> typedefs, whose comments do not use the documented typedef format, e.g.:
> 
>   drivers/gpu/drm/amd/include/cgs_common.h:89 ... expecting prototype
>   for cgs_read_register(). Prototype was for uint32_t() instead
> 
> Use the typedef comment format for all four accessors (also restoring
> the dropped _t suffix) and replace the wrong @offset with the real
> @space/@index params in the two indirect-register comments.
> 
> Signed-off-by: Omokefe Emmanuel Onanaroghene <emmaonana18@gmail.com>

We should potentially just completely nuke those typedefs since they are actually an unnecessarily layer of indirection.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/include/cgs_common.h | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/cgs_common.h b/drivers/gpu/drm/amd/include/cgs_common.h
> index f40b6a03fe63..3a25c3c75a3a 100644
> --- a/drivers/gpu/drm/amd/include/cgs_common.h
> +++ b/drivers/gpu/drm/amd/include/cgs_common.h
> @@ -81,7 +81,7 @@ struct cgs_firmware_info {
>  typedef unsigned long cgs_handle_t;
> 
>  /**
> - * cgs_read_register() - Read an MMIO register
> + * typedef cgs_read_register_t - Read an MMIO register
>   * @cgs_device:        opaque device handle
>   * @offset:    register offset
>   *
> @@ -90,7 +90,7 @@ typedef unsigned long cgs_handle_t;
>  typedef uint32_t (*cgs_read_register_t)(struct cgs_device *cgs_device, unsigned offset);
> 
>  /**
> - * cgs_write_register() - Write an MMIO register
> + * typedef cgs_write_register_t - Write an MMIO register
>   * @cgs_device:        opaque device handle
>   * @offset:    register offset
>   * @value:     register value
> @@ -99,9 +99,10 @@ typedef void (*cgs_write_register_t)(struct cgs_device *cgs_device, unsigned off
>                                      uint32_t value);
> 
>  /**
> - * cgs_read_ind_register() - Read an indirect register
> + * typedef cgs_read_ind_register_t - Read an indirect register
>   * @cgs_device:        opaque device handle
> - * @offset:    register offset
> + * @space:     indirect register space
> + * @index:     register index
>   *
>   * Return:  register value
>   */
> @@ -109,9 +110,10 @@ typedef uint32_t (*cgs_read_ind_register_t)(struct cgs_device *cgs_device, enum
>                                             unsigned index);
> 
>  /**
> - * cgs_write_ind_register() - Write an indirect register
> + * typedef cgs_write_ind_register_t - Write an indirect register
>   * @cgs_device:        opaque device handle
> - * @offset:    register offset
> + * @space:     indirect register space
> + * @index:     register index
>   * @value:     register value
>   */
>  typedef void (*cgs_write_ind_register_t)(struct cgs_device *cgs_device, enum cgs_ind_reg space,
> --
> 2.43.0
> 

