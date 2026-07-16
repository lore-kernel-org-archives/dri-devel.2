Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26194C44515
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E62AE10F357;
	Thu, 16 Jul 2026 20:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TtoDt58Z";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94AB10E309;
 Thu, 16 Jul 2026 20:58:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkBoqqBF9IrmQxfwcFyxJYG4DmuIojao4UXgx6MefvxLrpwSQf3kcLrBGr9UZmb6Ccvn9dZE/KKij4qPoSR5lbW/SPgFa3oX/S609wvG35LSwtzayvWlDhtlSTegThDWj//NCeaBi+Iep0Y3aBE8z7mlmu8gDVrXQdwzLDB5a14tnbifuFe/Q04QwmWP5Khe9o2UyfbbdJxNnc3MPQLkpX4QyXZ8VtHDITHwd9qkDPs9q+R5YqNCpEbxa+q/LamIP5icw2EDo0IBmBrT6XXvkkJijzyUUnfygMeT8cZlc4Ww56m8V4fWwYQE2UZuH9D7MIgVpU7i1GVnhB+KwjdsJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFf8UrwQcCNHwopJL8zJ7+NJQK1uUlRoVyQfBVaQftQ=;
 b=GdI2WIKgB091pFrCFS7ADk8sBYz2PDoh368829Lqx1pzLrkB6c8cmKUoLt1Sd4N1TF5RRSpRDY1GEZoJPrYoY3CDAh2CukQXsw5lpWzX7Z/mJUWRpsj/jmSCY90ubiEDnnaDFnicLjeIBHD1SCKRUFg/SXeq9+H0Td0rEk44STbZ/QN86SunOhVUqlZRQ0RRwVzepmh6P/l3EclAn29tjZbC8x5oqnuhynjXbCG1yciEdwMjoajynRn6C+taMYAk3UVXSRJ8fQRzbxliWhJtVPQrRj7zytGeXzUWE1dXum36egtZAGJr7z+jOH+DnU32tqjPLAsXu9GHf45SSzxBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFf8UrwQcCNHwopJL8zJ7+NJQK1uUlRoVyQfBVaQftQ=;
 b=TtoDt58ZXAqpb3U3BdD9ETcdmJJkyNL2wAgMQ5j4dWJWt5O01F8m8PfwCub4y+ZoA8f7GCGg52WIK+p7GznI3+VeKt8H5pk8lTbsI3jh9M+myvs6kQf6vBSo9YlNpD7B3Z0ICeV4k4O4uSUUWR4QPbC/zVlxKwOuUMqE9vg5q9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Thu, 16 Jul
 2026 20:58:44 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 20:58:44 +0000
Message-ID: <0bd7d533-d288-4c6d-be94-9a95c634414f@amd.com>
Date: Thu, 16 Jul 2026 14:58:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/7] drm: writeback: Refactor drm_writeback_connector
 structure
To: Suraj Kandpal <suraj.kandpal@intel.com>, freedreno@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, kernel-list@raspberrypi.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: uma.shankar@intel.com, arun.r.murthy@intel.com, abhinav.kumar@linux.dev,
 tzimmermann@suse.de, sean@poorly.ru, marijn.suijten@somainline.org,
 laurent.pinchart+renesas@ideasonboard.com, dave.stevenson@raspberrypi.com,
 tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com,
 kernel-dev@igalia.com, John.Harrison@Igalia.com,
 Liviu Dudau <liviu.dudau@arm.com>
References: <20260714042805.77934-1-suraj.kandpal@intel.com>
 <20260714042805.77934-2-suraj.kandpal@intel.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260714042805.77934-2-suraj.kandpal@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0014.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::19) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 094c4688-27d3-46f6-5f2c-08dee37d05c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|4143699003|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qNjEUCLKYIQw/ooehSLSGIt2Sq2qXVOu8BqOhWhzwf1qyuTLJ6kG5CmAa/kvtwPpR4ibyJzrDWa8tG9mJLAqAdQQi+FWUUoqYv2j8Pgg8InLsWD9D0eTSS6HC1/hkVAAbfR4VBGGxknVLRI1WnrBKWwt003tFWqzWh1n00FvYmBMHZDcpfiRIui8irPtNnsr9B9FuKAlav9RQAmYLgALKGjcgAtn+vmNO+lj2xf+sIjBTu1tAfmx4ROgYBJhdnohM0vGmgBcN1piWtK+HJ5VeCdjzxSVumESRgGVt6dUYYWhZbM3+C+29p8C/Y79DE/5S+lNMaqMajTJb14C86pUQz+vAyeMMCAvTl4oTbJWzBiAPXG8gfhX8kFbJG/VlS2dZfY/S9xcqljKR8XgcLbjXYoYFJJ8xfWX1SBq1mFFZ45D0vgZWJToGsCtPX6+w/X6AeftTgCNrOQCqe3AShPiv3ZnjWn0JdxUkN/YAPSNVtU4PzPRaPwjgiolneKikuXJfNn7Rw4bEhGeyI73mfThq9dyjY1J43fjeyyjbVjS0OcTd38y6XXZphGxBRIt466hpOCnFTwO+DSzp95K9PKPJ7q2WYDbba/5D4eFJmS3CSV4gSTJCjdA6slN0peLbzO1pmF+ppYtyOqihMfmAXjqexOsJmzLptQ+o4zcmNrJqos=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(4143699003)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFZFWnEzNXZBY002Wm1TMmZ1SitxM0dkSkJvV0tvTDZvWkQvZkdaVlNqZTFi?=
 =?utf-8?B?QVRBeUpvdk9MMjdKUmtYNUQzd1k2ejFGMGRzN3BNNG9HMnNCSzRwRXNjQXBR?=
 =?utf-8?B?ak0wU1Z5T05GUTA1ZVh3OFVBWFNLdmdPZHl4QWtmRk9EUXEvYzc3SUZFT1hu?=
 =?utf-8?B?MFc2Q3hXUFN4TUtMMzFKL2NwMXhvN2NCNGZzb0R0cytZZEFDUFFkdFR2b0o2?=
 =?utf-8?B?NzJsRFNEQTQ4N2dZV1o1bFFaNE51a2g1QlVndE9mamovZEI3Vk9YRkpEdEdZ?=
 =?utf-8?B?ZXc4YWJvdVZaa1E1TzZnU1lZNjd4SWFJVnpJb0tHTHY0STVUVkVzcEdmM0x1?=
 =?utf-8?B?U2pJZ09RK2ZiTDRKUFpsU0dKOFRvYm9CREw1YXpJNWVHajh5cnFNYVppMmxG?=
 =?utf-8?B?ZU9xYlRDWWV0bEx4OWVLVHN2c2FBRHh5eHVXYW1FbHdCTmo3ekxiN0doZzRP?=
 =?utf-8?B?ektTRGlLb2xBV1RLeEtBeUkvaHJJTEtkTHRnZFppczFUOVVsQjVUbERjSFFC?=
 =?utf-8?B?Rm00azdidTNEMmp2UEV5SUNGaGlkblVLcWdRcnM0ZEpyUW5jUlVXV1ZUSDlC?=
 =?utf-8?B?aGUrSFRHREJhUzZjTHpackdmemFCbmE5UldFRWptSlFnTndGWkhMY0NkaXlX?=
 =?utf-8?B?c0J0d2ZpbHg2VGRPYUFZT1N0Uk03TG03K3RUZWllU0dMU1pSZE9Kc0huYUJE?=
 =?utf-8?B?VW5kRjkxakVHeHNScUhmVmthclNLR0NHaHNkbHFoL1VreDhjZmZscmdCdFQx?=
 =?utf-8?B?eFJabmg4WjFnQ2w4Zm9JK1pwTnV0TEZjZ3M0MzE0Rm5SK3IvaWtiMEo2MW9P?=
 =?utf-8?B?eWRsRWNiZkhlV1FEeldEcFVZcFFRSXZsekZnU1NhZnA2NHd3MzdtdndYNXBW?=
 =?utf-8?B?REthdlNyZHhVa1RQclUzTTQzNnJjYTZ1Q3p3anlaaVBPSENTTU9veEdpM0x4?=
 =?utf-8?B?WFZoTUEyOW0wbTVMb2k5NUUwajQ5YzBGN2lzTlRCbnlLQ3BsWE9IcldUTG93?=
 =?utf-8?B?dzdLOXNuVGlBVmtLTDFZdjk2QXBIdUlMSTBrVlBMZTBZdm9CY2R4TFFEUEd0?=
 =?utf-8?B?TThZUTM3VzNVb0Z3S2VFc2RFMk5ha3NtMjdyY2xTZE1LZlVRa1VnTkpySEcx?=
 =?utf-8?B?b1lHMlNmQkJXQitYN1B0RXJ0akJoaWg1Q0ZHTUsvWWNCNXlFU3BwcFB1TE5H?=
 =?utf-8?B?L3hobWRTa3RuN2FTdXluT0g2U0k3S2V4VC9FWkRFZldOOTdteUlidEdVaUti?=
 =?utf-8?B?Tk0zMTQrVkVGNm1YMVptRDZBd0pOQTE3SUFpVVVxZk5vbWMxbTFjVHlUUEJ1?=
 =?utf-8?B?VjJDN3lLdzR2T3RMZzErdmJOQTliN2t0NTZYVlI1T045SGQzNXg5OElybkpy?=
 =?utf-8?B?cVVmS0swcUlGejRLSEFmc0djOCtaWFRITFROQ1BEbC9aRnBDalJCMjFEM093?=
 =?utf-8?B?eGR1R09OYkhJcER4S3ZhLzZXRHNkRHFuTlBnQ1VzTXRsWVNtaldtZ3N2eDlx?=
 =?utf-8?B?U05Qbm9rcWEzMHdtY1VrZ2E0LzNTcy9KN3B1N1YyR1RZcVNLZDI2NDZJV3FQ?=
 =?utf-8?B?aU0wNDJhK1lpUjE5TzdZM09EOVJBeE9zSWs2WU8xMGxNbnU5d0FFUmlnNzN4?=
 =?utf-8?B?RFByc2wzMTNOYVNQNi84SzV1T0hsSUROSHQ1R0tJS1FESE16L1ZsMHhqdTBL?=
 =?utf-8?B?SklwQTB4bHNmOGcyMGpkUmptMUlJaTdPS0xmNHpET3lWZkVZc0NMd3prSVBF?=
 =?utf-8?B?ZitucnZHejNBYkcvTkVEVXBRUit3TnlVUlVwNzg4Mmxub3FScjdCU1FTMnZv?=
 =?utf-8?B?ODBwc2daSHJsZHJLTlNZV0hoSFZ1MXVTQ0JnY0RuRXBvWjgrUEtQeFh3QlFK?=
 =?utf-8?B?ZXYzQngxQVJFM1ZNVmgxc1ZyWS9STXhBMUNZWGM0TnAyMGh5MTZReVFtQmtI?=
 =?utf-8?B?bmVOQ1JzR0lLQ1Z3elV5RTg0M3FZU2xrM0hMWjRGcmZVdmh2dXJmYlVpOTBL?=
 =?utf-8?B?OFBtTGYvVzJxUUFtN3NJeStKTTlNNVFhekwvTUplK3NQVjlYczdycGxnWTFO?=
 =?utf-8?B?cHlrOCszWDYvZFJOaFhQdUxraFU0RnVsQnJiWnlMbUlmaWFER2xsSFlYR2U0?=
 =?utf-8?B?VWQ1R3d1TjFWd2lUY0NxVERKdVhScnJqdzl2UWplR2Zia1hVdE1lRE9IWHIr?=
 =?utf-8?B?VE0vVTR4MWZYQTNtMTBUOGU2WGxOSnJFWWVCY2Z5dHhBSXVGdlE1ZWFtRnFv?=
 =?utf-8?B?RWFBNGpOdWRPYTBhS1hrOGtzUTRnRFp4UlhXT3ZlMkprZXJyZmN4aGlvbmZl?=
 =?utf-8?Q?fvj44f/1AoCCCxSvKz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094c4688-27d3-46f6-5f2c-08dee37d05c0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 20:58:44.2920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoBVP0CLkbAJKLRAF+bljsQqkmpUyzeK4FwMFCyqqwvx5LwwZBNLB/sILwMdFt+12hA5IaPISidF3PUt88PKNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 7/13/26 22:27, Suraj Kandpal wrote:
> Some drivers cannot work with the current design where the connector
> is embedded within the drm_writeback_connector such as Intel and
> some drivers that can get it working end up adding a lot of checks
> all around the code to check if it's a writeback conenctor or not,
> this is due to the limitation of inheritance in C.
> To solve this move the drm_writeback_connector within the
> drm_connector and remove the drm_connector base which was in
> drm_writeback_connector. Make this drm_writeback_connector
> a union with hdmi connector to save memory and since a connector can
> never be both writeback and hdmi it should serve us well.
> Do all other required modifications that come with these changes
> along with addition of new function which returns the drm_connector
> when drm_writeback_connector is present.
> Modify drivers using the drm_writeback_connector to
> allow them to use this connector without breaking them.
> The drivers modified here are amd, komeda, mali, vc4, vkms,
> rcar_du, msm
> 
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
> Reviewed-by: John Harrison <John.Harrison@Igalia.com>
> ---
> v5 -> v6:
> - Rebase on latest kernel
> 
> v4 -> v5:
> - Remove more unnecessary wrapping of drm_writeback_to_connector() (John)
> 
> v3 -> v4:
> - Use drm_writeback_to_connector() wherever possible (John)
> - Do not wrap line where not needed (John)
> 
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   |  4 +-
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  8 +--
>   .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  6 +-
>   .../gpu/drm/arm/display/komeda/komeda_kms.h   |  6 +-
>   .../arm/display/komeda/komeda_wb_connector.c  |  8 +--
>   drivers/gpu/drm/arm/malidp_crtc.c             |  2 +-
>   drivers/gpu/drm/arm/malidp_drv.h              |  2 +-
>   drivers/gpu/drm/arm/malidp_hw.c               |  6 +-
>   drivers/gpu/drm/arm/malidp_mw.c               |  8 +--
>   drivers/gpu/drm/drm_atomic_uapi.c             |  2 +-
>   drivers/gpu/drm/drm_writeback.c               | 28 ++++----
>   .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   |  3 +-
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 14 ++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h |  4 +-
>   .../gpu/drm/renesas/rcar-du/rcar_du_crtc.h    |  6 +-
>   .../drm/renesas/rcar-du/rcar_du_writeback.c   | 16 +++--
>   drivers/gpu/drm/vc4/vc4_txp.c                 | 12 ++--
>   drivers/gpu/drm/vkms/vkms_composer.c          |  2 +-
>   drivers/gpu/drm/vkms/vkms_drv.h               |  2 +-
>   drivers/gpu/drm/vkms/vkms_writeback.c         | 13 ++--
>   include/drm/drm_connector.h                   | 69 +++++++++++++++++--
>   include/drm/drm_writeback.h                   | 66 +-----------------
>   24 files changed, 150 insertions(+), 141 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1726eb6a3c63..427a8a52d256 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4885,7 +4885,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
>   			      struct drm_connector *connector,
>   			      struct drm_connector_state *new_con_state)
>   {
> -	struct drm_writeback_connector *wb_conn = drm_connector_to_writeback(connector);
> +	struct drm_writeback_connector *wb_conn = &connector->writeback;
>   	struct amdgpu_device *adev = dm->adev;
>   	struct amdgpu_crtc *acrtc;
>   	struct dc_writeback_info *wb_info;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 91affbdb2d6c..a1faf9f3670e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -894,7 +894,7 @@ static inline void amdgpu_dm_set_mst_status(uint8_t *status,
>   #define to_amdgpu_dm_connector(x) container_of(x, struct amdgpu_dm_connector, base)
>   
>   struct amdgpu_dm_wb_connector {
> -	struct drm_writeback_connector base;
> +	struct drm_connector base;
>   	struct dc_link *link;
>   };
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 88f938a8f24f..d48d764eae63 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1368,11 +1368,9 @@ create_stream_for_sink(struct drm_connector *connector,
>   		aconnector = to_amdgpu_dm_connector(connector);
>   		link = aconnector->dc_link;
>   	} else {
> -		struct drm_writeback_connector *wbcon = NULL;
>   		struct amdgpu_dm_wb_connector *dm_wbcon = NULL;
>   
> -		wbcon = drm_connector_to_writeback(connector);
> -		dm_wbcon = to_amdgpu_dm_wb_connector(wbcon);
> +		dm_wbcon = to_amdgpu_dm_wb_connector(connector);
>   		link = dm_wbcon->link;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index 3ee31634549e..18ef4ce73b46 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> @@ -205,9 +205,9 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
>   
>   	wbcon->link = link;
>   
> -	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
> +	drm_connector_helper_add(&wbcon->base, &amdgpu_dm_wb_conn_helper_funcs);
>   
> -	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
> +	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base.writeback,
>   					    &amdgpu_dm_wb_connector_funcs,
>   					    encoder,
>   					    amdgpu_dm_wb_formats,
> @@ -219,8 +219,8 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
>   	 * Some of the properties below require access to state, like bpc.
>   	 * Allocate some default initial connector state with our reset helper.
>   	 */
> -	if (wbcon->base.base.funcs->reset)
> -		wbcon->base.base.funcs->reset(&wbcon->base.base);
> +	if (wbcon->base.funcs->reset)
> +		wbcon->base.funcs->reset(&wbcon->base);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index e8cb782a6f8e..6611920c45fb 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -213,7 +213,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
>   		struct komeda_wb_connector *wb_conn = kcrtc->wb_conn;
>   
>   		if (wb_conn)
> -			drm_writeback_signal_completion(&wb_conn->base, 0);
> +			drm_writeback_signal_completion(&wb_conn->base.writeback, 0);
>   		else
>   			drm_warn(drm, "CRTC[%d]: EOW happen but no wb_connector.\n",
>   				 drm_crtc_index(&kcrtc->base));
> @@ -269,9 +269,9 @@ komeda_crtc_do_flush(struct drm_crtc *crtc,
>   	if (slave && has_bit(slave->id, kcrtc_st->affected_pipes))
>   		komeda_pipeline_update(slave, old->state);
>   
> -	conn_st = wb_conn ? wb_conn->base.base.state : NULL;
> +	conn_st = wb_conn ? wb_conn->base.state : NULL;
>   	if (conn_st && conn_st->writeback_job)
> -		drm_writeback_queue_job(&wb_conn->base, conn_st);
> +		drm_writeback_queue_job(&wb_conn->base.writeback, conn_st);
>   
>   	/* step 2: notify the HW to kickoff the update */
>   	mdev->funcs->flush(mdev, master->id, kcrtc_st->active_pipes);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> index 83e61c4080c2..9c34302782c0 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -53,8 +53,8 @@ struct komeda_plane_state {
>    * struct komeda_wb_connector
>    */
>   struct komeda_wb_connector {
> -	/** @base: &drm_writeback_connector */
> -	struct drm_writeback_connector base;
> +	/** @base: &drm_connector */
> +	struct drm_connector base;
>   
>   	/** @wb_layer: represents associated writeback pipeline of komeda */
>   	struct komeda_layer *wb_layer;
> @@ -139,7 +139,7 @@ struct komeda_kms_dev {
>   static inline bool is_writeback_only(struct drm_crtc_state *st)
>   {
>   	struct komeda_wb_connector *wb_conn = to_kcrtc(st->crtc)->wb_conn;
> -	struct drm_connector *conn = wb_conn ? &wb_conn->base.base : NULL;
> +	struct drm_connector *conn = wb_conn ? &wb_conn->base : NULL;
>   
>   	return conn && (st->connector_mask == BIT(drm_connector_index(conn)));
>   }
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> index c1bedbaa26f9..848ac37a76e4 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
> @@ -53,7 +53,7 @@ komeda_wb_encoder_atomic_check(struct drm_encoder *encoder,
>   		return -EINVAL;
>   	}
>   
> -	wb_layer = to_kconn(to_wb_conn(conn_st->connector))->wb_layer;
> +	wb_layer = to_kconn(conn_st->connector)->wb_layer;
>   
>   	/*
>   	 * No need for a full modested when the only connector changed is the
> @@ -151,7 +151,7 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>   
>   	kwb_conn->wb_layer = kcrtc->master->wb_layer;
>   
> -	wb_conn = &kwb_conn->base;
> +	wb_conn = &kwb_conn->base.writeback;
>   
>   	formats = komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
>   					       kwb_conn->wb_layer->layer_type,
> @@ -183,9 +183,9 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
>   		return err;
>   	}
>   
> -	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
> +	drm_connector_helper_add(&kwb_conn->base, &komeda_wb_conn_helper_funcs);
>   
> -	info = &kwb_conn->base.base.display_info;
> +	info = &kwb_conn->base.display_info;
>   	info->bpc = __fls(kcrtc->master->improc->supported_color_depths);
>   	info->color_formats = kcrtc->master->improc->supported_color_formats;
>   
> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
> index ebe8e1078777..4402c1de8c69 100644
> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> @@ -421,7 +421,7 @@ static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
>   		u32 new_mask = crtc_state->connector_mask;
>   
>   		if ((old_mask ^ new_mask) ==
> -		    (1 << drm_connector_index(&malidp->mw_connector.base)))
> +		    (1 << drm_connector_index(&malidp->mw_connector)))
>   			crtc_state->connectors_changed = false;
>   	}
>   
> diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
> index bc0387876dea..aa5599467d27 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.h
> +++ b/drivers/gpu/drm/arm/malidp_drv.h
> @@ -32,7 +32,7 @@ struct malidp_drm {
>   	struct drm_device base;
>   	struct malidp_hw_device *dev;
>   	struct drm_crtc crtc;
> -	struct drm_writeback_connector mw_connector;
> +	struct drm_connector mw_connector;
>   	wait_queue_head_t wq;
>   	struct drm_pending_vblank_event *event;
>   	atomic_t config_valid;
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index 9b845d3f34e1..5a7bd27d3718 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -1315,15 +1315,15 @@ static irqreturn_t malidp_se_irq(int irq, void *arg)
>   	if (status & se->vsync_irq) {
>   		switch (hwdev->mw_state) {
>   		case MW_ONESHOT:
> -			drm_writeback_signal_completion(&malidp->mw_connector, 0);
> +			drm_writeback_signal_completion(&malidp->mw_connector.writeback, 0);
>   			break;
>   		case MW_STOP:
> -			drm_writeback_signal_completion(&malidp->mw_connector, 0);
> +			drm_writeback_signal_completion(&malidp->mw_connector.writeback, 0);
>   			/* disable writeback after stop */
>   			hwdev->mw_state = MW_NOT_ENABLED;
>   			break;
>   		case MW_RESTART:
> -			drm_writeback_signal_completion(&malidp->mw_connector, 0);
> +			drm_writeback_signal_completion(&malidp->mw_connector.writeback, 0);
>   			fallthrough;	/* to a new start */
>   		case MW_START:
>   			/* writeback started, need to emulate one-shot mode */
> diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
> index a4c6a00c0941..4c77a459c241 100644
> --- a/drivers/gpu/drm/arm/malidp_mw.c
> +++ b/drivers/gpu/drm/arm/malidp_mw.c
> @@ -212,7 +212,7 @@ int malidp_mw_connector_init(struct drm_device *drm)
>   	if (!malidp->dev->hw->enable_memwrite)
>   		return 0;
>   
> -	drm_connector_helper_add(&malidp->mw_connector.base,
> +	drm_connector_helper_add(&malidp->mw_connector,
>   				 &malidp_mw_connector_helper_funcs);
>   
>   	formats = get_writeback_formats(malidp, &n_formats);
> @@ -229,7 +229,7 @@ int malidp_mw_connector_init(struct drm_device *drm)
>   
>   	encoder->possible_crtcs = drm_crtc_mask(&malidp->crtc);
>   
> -	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector,
> +	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector.writeback,
>   					    &malidp_mw_connector_funcs,
>   					    encoder,
>   					    formats, n_formats);
> @@ -244,8 +244,8 @@ void malidp_mw_atomic_commit(struct drm_device *drm,
>   			     struct drm_atomic_commit *old_state)
>   {
>   	struct malidp_drm *malidp = drm_to_malidp(drm);
> -	struct drm_writeback_connector *mw_conn = &malidp->mw_connector;
> -	struct drm_connector_state *conn_state = mw_conn->base.state;
> +	struct drm_writeback_connector *mw_conn = &malidp->mw_connector.writeback;
> +	struct drm_connector_state *conn_state = malidp->mw_connector.state;
>   	struct malidp_hw_device *hwdev = malidp->dev;
>   	struct malidp_mw_connector_state *mw_state;
>   
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 1050dddadb17..a5c11832ff64 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -1514,7 +1514,7 @@ static int prepare_signaling(struct drm_device *dev,
>   		f[*num_fences].out_fence_ptr = fence_ptr;
>   		*fence_state = f;
>   
> -		wb_conn = drm_connector_to_writeback(conn);
> +		wb_conn = &conn->writeback;
>   		fence = drm_writeback_get_out_fence(wb_conn);
>   		if (!fence)
>   			return -ENOMEM;
> diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> index 6ba3833a93ca..f93c936643bb 100644
> --- a/drivers/gpu/drm/drm_writeback.c
> +++ b/drivers/gpu/drm/drm_writeback.c
> @@ -95,8 +95,9 @@ static const char *drm_writeback_fence_get_driver_name(struct dma_fence *fence)
>   {
>   	struct drm_writeback_connector *wb_connector =
>   		fence_to_wb_connector(fence);
> +	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
>   
> -	return wb_connector->base.dev->driver->name;
> +	return connector->dev->driver->name;
>   }
>   
>   static const char *
> @@ -193,7 +194,7 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
>   					  struct drm_encoder *enc, const u32 *formats,
>   					  int n_formats)
>   {
> -	struct drm_connector *connector = &wb_connector->base;
> +	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
>   	struct drm_mode_config *config = &dev->mode_config;
>   	struct drm_property_blob *blob;
>   	int ret = create_writeback_properties(dev);
> @@ -275,7 +276,7 @@ int drm_writeback_connector_init(struct drm_device *dev,
>   				 struct drm_encoder *enc,
>   				 const u32 *formats, int n_formats)
>   {
> -	struct drm_connector *connector = &wb_connector->base;
> +	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
>   	int ret;
>   
>   	ret = drm_connector_init(dev, connector, con_funcs,
> @@ -345,7 +346,7 @@ int drmm_writeback_connector_init(struct drm_device *dev,
>   				  struct drm_encoder *enc,
>   				  const u32 *formats, int n_formats)
>   {
> -	struct drm_connector *connector = &wb_connector->base;
> +	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
>   	int ret;
>   
>   	ret = drmm_connector_init(dev, connector, con_funcs,
> @@ -378,7 +379,7 @@ int drm_writeback_set_fb(struct drm_connector_state *conn_state,
>   			return -ENOMEM;
>   
>   		conn_state->writeback_job->connector =
> -			drm_connector_to_writeback(conn_state->connector);
> +			&conn_state->connector->writeback;
>   	}
>   
>   	drm_framebuffer_assign(&conn_state->writeback_job->fb, fb);
> @@ -387,13 +388,14 @@ int drm_writeback_set_fb(struct drm_connector_state *conn_state,
>   
>   int drm_writeback_prepare_job(struct drm_writeback_job *job)
>   {
> -	struct drm_writeback_connector *connector = job->connector;
> +	struct drm_writeback_connector *wb_connector = job->connector;
> +	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
>   	const struct drm_connector_helper_funcs *funcs =
> -		connector->base.helper_private;
> +		connector->helper_private;
>   	int ret;
>   
>   	if (funcs->prepare_writeback_job) {
> -		ret = funcs->prepare_writeback_job(connector, job);
> +		ret = funcs->prepare_writeback_job(wb_connector, job);
>   		if (ret < 0)
>   			return ret;
>   	}
> @@ -439,12 +441,13 @@ EXPORT_SYMBOL(drm_writeback_queue_job);
>   
>   void drm_writeback_cleanup_job(struct drm_writeback_job *job)
>   {
> -	struct drm_writeback_connector *connector = job->connector;
> +	struct drm_writeback_connector *wb_connector = job->connector;
> +	struct drm_connector *connector	= drm_writeback_to_connector(wb_connector);
>   	const struct drm_connector_helper_funcs *funcs =
> -		connector->base.helper_private;
> +		connector->helper_private;
>   
>   	if (job->prepared && funcs->cleanup_writeback_job)
> -		funcs->cleanup_writeback_job(connector, job);
> +		funcs->cleanup_writeback_job(wb_connector, job);
>   
>   	if (job->fb)
>   		drm_framebuffer_put(job->fb);
> @@ -526,8 +529,9 @@ struct dma_fence *
>   drm_writeback_get_out_fence(struct drm_writeback_connector *wb_connector)
>   {
>   	struct dma_fence *fence;
> +	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
>   
> -	if (WARN_ON(wb_connector->base.connector_type !=
> +	if (WARN_ON(connector->connector_type !=
>   		    DRM_MODE_CONNECTOR_WRITEBACK))
>   		return NULL;
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> index 22433bfbea1e..e2a328225c9e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
> @@ -481,7 +481,8 @@ static void dpu_encoder_phys_wb_prepare_for_kickoff(
>   		return;
>   	}
>   
> -	drm_conn = &wb_enc->wb_conn->base;
> +	drm_conn =
> +		drm_writeback_to_connector(wb_enc->wb_conn);
>   	state = drm_conn->state;
>   
>   	if (wb_enc->wb_conn && wb_enc->wb_job)
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> index e7b09013ae4c..d1211788625a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
> @@ -29,8 +29,7 @@ static int dpu_wb_conn_get_modes(struct drm_connector *connector)
>   static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
>   				    struct drm_atomic_commit *state)
>   {
> -	struct drm_writeback_connector *wb_conn = drm_connector_to_writeback(connector);
> -	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(wb_conn);
> +	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(connector);
>   	struct drm_connector_state *conn_state =
>   		drm_atomic_get_new_connector_state(state, connector);
>   	struct drm_crtc *crtc;
> @@ -88,10 +87,10 @@ static const struct drm_connector_funcs dpu_wb_conn_funcs = {
>   	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>   };
>   
> -static int dpu_wb_conn_prepare_job(struct drm_writeback_connector *connector,
> +static int dpu_wb_conn_prepare_job(struct drm_writeback_connector *wb_conn,
>   		struct drm_writeback_job *job)
>   {
> -
> +	struct drm_connector *connector = drm_writeback_to_connector(wb_conn);
>   	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(connector);
>   
>   	if (!job->fb)
> @@ -102,9 +101,10 @@ static int dpu_wb_conn_prepare_job(struct drm_writeback_connector *connector,
>   	return 0;
>   }
>   
> -static void dpu_wb_conn_cleanup_job(struct drm_writeback_connector *connector,
> +static void dpu_wb_conn_cleanup_job(struct drm_writeback_connector *wb_connector,
>   		struct drm_writeback_job *job)
>   {
> +	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
>   	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(connector);
>   
>   	if (!job->fb)
> @@ -132,9 +132,9 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
>   
>   	dpu_wb_conn->maxlinewidth = maxlinewidth;
>   
> -	drm_connector_helper_add(&dpu_wb_conn->base.base, &dpu_wb_conn_helper_funcs);
> +	drm_connector_helper_add(&dpu_wb_conn->base, &dpu_wb_conn_helper_funcs);
>   
> -	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base,
> +	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base.writeback,
>   					   &dpu_wb_conn_funcs, enc,
>   					   format_list, num_formats);
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h
> index 4b11cca8014c..9ebf15392b20 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h
> @@ -16,12 +16,12 @@
>   #include "dpu_encoder_phys.h"
>   
>   struct dpu_wb_connector {
> -	struct drm_writeback_connector base;
> +	struct drm_connector base;
>   	struct drm_encoder *wb_enc;
>   	u32 maxlinewidth;
>   };
>   
> -static inline struct dpu_wb_connector *to_dpu_wb_conn(struct drm_writeback_connector *conn)
> +static inline struct dpu_wb_connector *to_dpu_wb_conn(struct drm_connector *conn)
>   {
>   	return container_of(conn, struct dpu_wb_connector, base);
>   }
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
> index 8857926e109a..11372ccfdd38 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
> @@ -43,7 +43,7 @@ struct rcar_du_vsp;
>    * @cmm: CMM associated with this CRTC
>    * @vsp: VSP feeding video to this CRTC
>    * @vsp_pipe: index of the VSP pipeline feeding video to this CRTC
> - * @writeback: the writeback connector
> + * @wb_connector: the drm connector which contains the writeback connector
>    */
>   struct rcar_du_crtc {
>   	struct drm_crtc crtc;
> @@ -73,11 +73,11 @@ struct rcar_du_crtc {
>   	const char *const *sources;
>   	unsigned int sources_count;
>   
> -	struct drm_writeback_connector writeback;
> +	struct drm_connector wb_connector;
>   };
>   
>   #define to_rcar_crtc(c)		container_of(c, struct rcar_du_crtc, crtc)
> -#define wb_to_rcar_crtc(c)	container_of(c, struct rcar_du_crtc, writeback)
> +#define wb_to_rcar_crtc(c)	container_of(c, struct rcar_du_crtc, wb_connector)
>   
>   /**
>    * struct rcar_du_crtc_state - Driver-specific CRTC state
> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> index ecfd4fc1f210..39be854c465a 100644
> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
> @@ -50,7 +50,8 @@ static int rcar_du_wb_conn_get_modes(struct drm_connector *connector)
>   static int rcar_du_wb_prepare_job(struct drm_writeback_connector *connector,
>   				  struct drm_writeback_job *job)
>   {
> -	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(connector);
> +	struct drm_connector *conn = drm_writeback_to_connector(connector);
> +	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(conn);
>   	struct rcar_du_wb_job *rjob;
>   	int ret;
>   
> @@ -75,7 +76,8 @@ static int rcar_du_wb_prepare_job(struct drm_writeback_connector *connector,
>   static void rcar_du_wb_cleanup_job(struct drm_writeback_connector *connector,
>   				   struct drm_writeback_job *job)
>   {
> -	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(connector);
> +	struct drm_connector *conn = drm_writeback_to_connector(connector);
> +	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(conn);
>   	struct rcar_du_wb_job *rjob = job->priv;
>   
>   	if (!job->fb)
> @@ -199,7 +201,7 @@ static const u32 writeback_formats[] = {
>   int rcar_du_writeback_init(struct rcar_du_device *rcdu,
>   			   struct rcar_du_crtc *rcrtc)
>   {
> -	struct drm_writeback_connector *wb_conn = &rcrtc->writeback;
> +	struct drm_writeback_connector *wb_conn = &rcrtc->wb_connector.writeback;
>   	struct drm_encoder *encoder;
>   
>   	encoder = drmm_plain_encoder_alloc(&rcdu->ddev, NULL,
> @@ -211,7 +213,7 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
>   
>   	encoder->possible_crtcs = drm_crtc_mask(&rcrtc->crtc);
>   
> -	drm_connector_helper_add(&wb_conn->base,
> +	drm_connector_helper_add(&rcrtc->wb_connector,
>   				 &rcar_du_wb_conn_helper_funcs);
>   
>   	return drmm_writeback_connector_init(&rcdu->ddev, wb_conn,
> @@ -230,7 +232,7 @@ void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,
>   	struct drm_framebuffer *fb;
>   	unsigned int i;
>   
> -	state = rcrtc->writeback.base.state;
> +	state = rcrtc->wb_connector.state;
>   	if (!state || !state->writeback_job)
>   		return;
>   
> @@ -245,10 +247,10 @@ void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,
>   		cfg->mem[i] = sg_dma_address(rjob->sg_tables[i].sgl)
>   			    + fb->offsets[i];
>   
> -	drm_writeback_queue_job(&rcrtc->writeback, state);
> +	drm_writeback_queue_job(&rcrtc->wb_connector.writeback, state);
>   }
>   
>   void rcar_du_writeback_complete(struct rcar_du_crtc *rcrtc)
>   {
> -	drm_writeback_signal_completion(&rcrtc->writeback, 0);
> +	drm_writeback_signal_completion(&rcrtc->wb_connector.writeback, 0);
>   }
> diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
> index 322cc65dc787..864125cc7d72 100644
> --- a/drivers/gpu/drm/vc4/vc4_txp.c
> +++ b/drivers/gpu/drm/vc4/vc4_txp.c
> @@ -167,7 +167,7 @@ struct vc4_txp {
>   	struct platform_device *pdev;
>   
>   	struct vc4_encoder encoder;
> -	struct drm_writeback_connector connector;
> +	struct drm_connector connector;
>   
>   	void __iomem *regs;
>   };
> @@ -176,7 +176,7 @@ struct vc4_txp {
>   	container_of_const(_encoder, struct vc4_txp, encoder.base)
>   
>   #define connector_to_vc4_txp(_connector)				\
> -	container_of_const(_connector, struct vc4_txp, connector.base)
> +	container_of_const(_connector, struct vc4_txp, connector)
>   
>   static const struct debugfs_reg32 txp_regs[] = {
>   	VC4_REG32(TXP_DST_PTR),
> @@ -356,7 +356,7 @@ static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
>   
>   	TXP_WRITE(TXP_DST_CTRL, ctrl);
>   
> -	drm_writeback_queue_job(&txp->connector, conn_state);
> +	drm_writeback_queue_job(&txp->connector.writeback, conn_state);
>   
>   	drm_dev_exit(idx);
>   }
> @@ -504,7 +504,7 @@ static irqreturn_t vc4_txp_interrupt(int irq, void *data)
>   	 */
>   	TXP_WRITE(TXP_DST_CTRL, TXP_READ(TXP_DST_CTRL) & ~TXP_EI);
>   	vc4_crtc_handle_vblank(vc4_crtc);
> -	drm_writeback_signal_completion(&txp->connector, 0);
> +	drm_writeback_signal_completion(&txp->connector.writeback, 0);
>   
>   	return IRQ_HANDLED;
>   }
> @@ -598,9 +598,9 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
>   	if (ret)
>   		return ret;
>   
> -	drm_connector_helper_add(&txp->connector.base,
> +	drm_connector_helper_add(&txp->connector,
>   				 &vc4_txp_connector_helper_funcs);
> -	ret = drmm_writeback_connector_init(drm, &txp->connector,
> +	ret = drmm_writeback_connector_init(drm, &txp->connector.writeback,
>   					    &vc4_txp_connector_funcs,
>   					    encoder,
>   					    drm_fmts, ARRAY_SIZE(drm_fmts));
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 83d217085ad0..27fb6a7b55bb 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -652,7 +652,7 @@ void vkms_composer_worker(struct work_struct *work)
>   		return;
>   
>   	if (wb_pending) {
> -		drm_writeback_signal_completion(&out->wb_connector, 0);
> +		drm_writeback_signal_completion(&out->wb_connector.writeback, 0);
>   		spin_lock_irq(&out->composer_lock);
>   		crtc_state->wb_pending = false;
>   		spin_unlock_irq(&out->composer_lock);
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 0933e4ce0ff0..145a7909388b 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -217,7 +217,7 @@ struct vkms_crtc_state {
>    */
>   struct vkms_output {
>   	struct drm_crtc crtc;
> -	struct drm_writeback_connector wb_connector;
> +	struct drm_connector wb_connector;
>   	struct drm_encoder wb_encoder;
>   	struct workqueue_struct *composer_workq;
>   	spinlock_t lock;
> diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
> index ecf29a2c0c8e..64d524d2168f 100644
> --- a/drivers/gpu/drm/vkms/vkms_writeback.c
> +++ b/drivers/gpu/drm/vkms/vkms_writeback.c
> @@ -103,10 +103,13 @@ static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_connector,
>   	return ret;
>   }
>   
> -static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
> +static void vkms_wb_cleanup_job(struct drm_writeback_connector *wb_conn,
>   				struct drm_writeback_job *job)
>   {
>   	struct vkms_writeback_job *vkmsjob = job->priv;
> +	struct drm_connector *connector = container_of(wb_conn,
> +						       struct drm_connector,
> +						       writeback);
>   	struct vkms_output *vkms_output = container_of(connector,
>   						       struct vkms_output,
>   						       wb_connector);
> @@ -128,8 +131,8 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
>   	struct drm_connector_state *connector_state = drm_atomic_get_new_connector_state(state,
>   											 conn);
>   	struct vkms_output *output = drm_crtc_to_vkms_output(connector_state->crtc);
> -	struct drm_writeback_connector *wb_conn = &output->wb_connector;
> -	struct drm_connector_state *conn_state = wb_conn->base.state;
> +	struct drm_writeback_connector *wb_conn = &output->wb_connector.writeback;
> +	struct drm_connector_state *conn_state = output->wb_connector.state;
>   	struct vkms_crtc_state *crtc_state = output->composer_state;
>   	struct drm_framebuffer *fb = connector_state->writeback_job->fb;
>   	u16 crtc_height = crtc_state->base.mode.vdisplay;
> @@ -167,7 +170,7 @@ static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
>   int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
>   				    struct vkms_output *vkms_output)
>   {
> -	struct drm_writeback_connector *wb = &vkms_output->wb_connector;
> +	struct drm_writeback_connector *wb = &vkms_output->wb_connector.writeback;
>   	int ret;
>   
>   	ret = drmm_encoder_init(&vkmsdev->drm, &vkms_output->wb_encoder,
> @@ -178,7 +181,7 @@ int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
>   	vkms_output->wb_encoder.possible_clones |=
>   		drm_encoder_mask(&vkms_output->wb_encoder);
>   
> -	drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
> +	drm_connector_helper_add(&vkms_output->wb_connector, &vkms_wb_conn_helper_funcs);
>   
>   	return drmm_writeback_connector_init(&vkmsdev->drm, wb,
>   					     &vkms_wb_connector_funcs,
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index af075c38f4db..b162ce89da37 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -2094,6 +2094,61 @@ struct drm_connector_cec {
>   	void *data;
>   };
>   
> +/**
> + * struct drm_writeback_connector - DRM writeback connector
> + */
> +struct drm_writeback_connector {
> +	/**
> +	 * @pixel_formats_blob_ptr:
> +	 *
> +	 * DRM blob property data for the pixel formats list on writeback
> +	 * connectors
> +	 * See also drm_writeback_connector_init()
> +	 */
> +	struct drm_property_blob *pixel_formats_blob_ptr;
> +
> +	/** @job_lock: Protects job_queue */
> +	spinlock_t job_lock;
> +
> +	/**
> +	 * @job_queue:
> +	 *
> +	 * Holds a list of a connector's writeback jobs; the last item is the
> +	 * most recent. The first item may be either waiting for the hardware
> +	 * to begin writing, or currently being written.
> +	 *
> +	 * See also: drm_writeback_queue_job() and
> +	 * drm_writeback_signal_completion()
> +	 */
> +	struct list_head job_queue;
> +
> +	/**
> +	 * @fence_context:
> +	 *
> +	 * timeline context used for fence operations.
> +	 */
> +	unsigned int fence_context;
> +	/**
> +	 * @fence_lock:
> +	 *
> +	 * spinlock to protect the fences in the fence_context.
> +	 */
> +	spinlock_t fence_lock;
> +	/**
> +	 * @fence_seqno:
> +	 *
> +	 * Seqno variable used as monotonic counter for the fences
> +	 * created on the connector's timeline.
> +	 */
> +	unsigned long fence_seqno;
> +	/**
> +	 * @timeline_name:
> +	 *
> +	 * The name of the connector's fence timeline.
> +	 */
> +	char timeline_name[32];
> +};
> +
>   /**
>    * struct drm_connector - central DRM connector control structure
>    *
> @@ -2509,10 +2564,16 @@ struct drm_connector {
>   	 */
>   	struct llist_node free_node;
>   
> -	/**
> -	 * @hdmi: HDMI-related variable and properties.
> -	 */
> -	struct drm_connector_hdmi hdmi;
> +	union {
> +		/**
> +		 * @hdmi: HDMI-related variable and properties.
> +		 */
> +		struct drm_connector_hdmi hdmi;
> +		/**
> +		 * @writeback: Writeback related valriables.
> +		 */
> +		struct drm_writeback_connector writeback;
> +	};
>   
>   	/**
>   	 * @hdmi_audio: HDMI codec properties and non-DRM state.
> diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
> index 958466a05e60..702141099520 100644
> --- a/include/drm/drm_writeback.h
> +++ b/include/drm/drm_writeback.h
> @@ -15,66 +15,6 @@
>   #include <drm/drm_encoder.h>
>   #include <linux/workqueue.h>
>   
> -/**
> - * struct drm_writeback_connector - DRM writeback connector
> - */
> -struct drm_writeback_connector {
> -	/**
> -	 * @base: base drm_connector object
> -	 */
> -	struct drm_connector base;
> -
> -	/**
> -	 * @pixel_formats_blob_ptr:
> -	 *
> -	 * DRM blob property data for the pixel formats list on writeback
> -	 * connectors
> -	 * See also drm_writeback_connector_init()
> -	 */
> -	struct drm_property_blob *pixel_formats_blob_ptr;
> -
> -	/** @job_lock: Protects job_queue */
> -	spinlock_t job_lock;
> -
> -	/**
> -	 * @job_queue:
> -	 *
> -	 * Holds a list of a connector's writeback jobs; the last item is the
> -	 * most recent. The first item may be either waiting for the hardware
> -	 * to begin writing, or currently being written.
> -	 *
> -	 * See also: drm_writeback_queue_job() and
> -	 * drm_writeback_signal_completion()
> -	 */
> -	struct list_head job_queue;
> -
> -	/**
> -	 * @fence_context:
> -	 *
> -	 * timeline context used for fence operations.
> -	 */
> -	unsigned int fence_context;
> -	/**
> -	 * @fence_lock:
> -	 *
> -	 * spinlock to protect the fences in the fence_context.
> -	 */
> -	spinlock_t fence_lock;
> -	/**
> -	 * @fence_seqno:
> -	 *
> -	 * Seqno variable used as monotonic counter for the fences
> -	 * created on the connector's timeline.
> -	 */
> -	unsigned long fence_seqno;
> -	/**
> -	 * @timeline_name:
> -	 *
> -	 * The name of the connector's fence timeline.
> -	 */
> -	char timeline_name[32];
> -};
> -
>   /**
>    * struct drm_writeback_job - DRM writeback job
>    */
> @@ -131,10 +71,10 @@ struct drm_writeback_job {
>   	void *priv;
>   };
>   
> -static inline struct drm_writeback_connector *
> -drm_connector_to_writeback(struct drm_connector *connector)
> +static inline struct drm_connector *
> +drm_writeback_to_connector(struct drm_writeback_connector *wb_connector)
>   {
> -	return container_of(connector, struct drm_writeback_connector, base);
> +	return container_of(wb_connector, struct drm_connector, writeback);
>   }
>   
>   int drm_writeback_connector_init(struct drm_device *dev,

