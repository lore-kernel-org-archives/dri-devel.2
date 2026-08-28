Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76464C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A011A10E4BA;
	Fri, 28 Aug 2026 20:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R2v7mwG9";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B5E10E4BA;
 Fri, 28 Aug 2026 20:42:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlQJd1Uvqt0N4mzp/BWsSlcod5sC2GRFHoNXLYsZmuUyKN8322/tdFlbE3W+tjcRBDhJRC+UTSRgMKmqDHY32oL5GgK5rbiF79lidDb+JkKea85APAotZub5qATBAlK9TDy/2wmrJ+0Zsw/MrLGuqc0UwrAVL3vOUVPGfxMD74ktQOZZ3dF8Dr6MdidNJV+sUkXfN+0DzmIAf8ev0GyAjNx98LkdxLdOz+wIrXWPdir7KkswTE5SIAoG63bLt1TBsIriUn/Ddl8w1PxH9wUFfqXmJka9qIHQU3qwiJhlfi6D2840mvLDTdVh4icAaxs+cfMXB4kmPTCPTQ3lPX3Idw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Erlw/Jz8aIh4gcon3rn+PZuwmalV1u0/5yP3PGJRo3s=;
 b=Rav6OI0TN3MTilAl6D3M3tTjupRazkMnliPDnq5eqDtLNmZwnmJyh3bT+CFgzxRPz/avECaURrgnaiQ9eRVK34I1dBANTWSz11MYyCQDCLVecpJEI+hifrsG89oKXHrRqmLz0w6JTgOoBJOPsKAD41C35MqGy4QXY7DBiO1KdOMel6ps1BGzzWMhIjF55eXyanuP0F1uJ0xjkwOs+IetDKCBoRY2B7gVs+XRQT1m2BOmWAteO+PBvgnU5T7ZjtKqDtIA4IS6oEedD0B+XdxDBIELYZTfIWV/kBPxFEAdolRnkMTit856vg+9fKKoSktn3ymHLc+sgPRe3o0dGvvH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Erlw/Jz8aIh4gcon3rn+PZuwmalV1u0/5yP3PGJRo3s=;
 b=R2v7mwG9BnsCYSPjhkRMpvDd4gqt2SQcvsmFgXVXXFdQNLZuk8wyazyptFq0C9ULNONbA32pN0JZXYcHfy7Aaaz1yGKMpo9gaN1AiII08142mO3ZD9kUSx+2ckTKIVe2HJ5jJwfjFO/c+1R//euih3JCa8A/qMo0xKd6nkEyZKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Fri, 28 Aug
 2026 20:41:58 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 20:41:58 +0000
Message-ID: <2eb3d525-d7fb-44a5-9904-fbb729353c41@amd.com>
Date: Fri, 28 Aug 2026 14:41:55 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: fix division by zero in
 get_estimated_bw()
To: Hari Mishal <harimishal1@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dillon Varone <dillon.varone@amd.com>,
 Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 Cruise Hung <Cruise.Hung@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Peichen Huang <PeiChen.Huang@amd.com>, Qingqing Zhuo
 <qingqing.zhuo@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Mustapha Ghaddar <mghaddar@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
References: <20260822145751.42328-1-harimishal1@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260822145751.42328-1-harimishal1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0246.namprd04.prod.outlook.com
 (2603:10b6:303:88::11) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b3bff2-41fc-4b93-7665-08df0544cde0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|10067099003|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: yVW/BdrdU7YJILoaJKBtIZFxjXwpF0sRtuTxZau5wrqHGaUzU31LYNhmzBn0mtVJ68O5XJWSQRvyalr4Mv3KLLn+Z4egkScnihmhqwrYh3lFJqBnQup/wBwBmIykJ9tAJebIQDJfzH5uOTwYOZ80Fm5lzujq884cQRiBzp64O3rUehNKFfHaSD9HGw32X84Vdfzv50IfaEKQRA39CjvieAXmQ32Da7TNmUQwyrkaHUKPKnwrX57WVQ+1IuPB+y1/g9Lc2sj3eVj3PgbFhS6K25cDvM+ioHj8OWMXPIlsgQSqT0/Bl0GEXaL9XAPW43muBPvSWZ3YTlZZBxXLLZhP8pBXFvI+1xvdBLxPkeNTpzA3dsAOwJRj/YYfZF33lPjlPYTkE/pfbDN13uhs31sKPXoFpcmPlmtbXO+r8ePMKzhkm+IJpfydX1OsOD1ALbnKrGnTLRYpywZjt1M7hlsewQ1CIcrW4pebSydFcXqE2gzdIA74ahS7N8EL4SaI+Apiwl3VzJD+TW8lwcfJ0E6RWLq2/nAWm8ffmVIUUYfS1H+I2qwTqZAiyLPmuOavrFSknReA+VDIoyWj0VeP+iyPQPErHmYqQ2Lf+rsDm3WkemXxPyaWxy0F3hHy8o8b05jxwzKU1H+2XwIdNfMrSRZ9MpDvi4ooRuVFzIMurLRshks=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGF6NnFCVXlJWTFkSFpIM1hkaEVuNlBMLy96U0FoQnF3T3A4Y0t2MlN3Zzh1?=
 =?utf-8?B?bDR2QU1RVzBFdnM3MHg1czIzUDdpOXg2Qkc4QTUwR0p6ZFFkYXpMQm9zNVFi?=
 =?utf-8?B?b0lwdzRObzRGYlRBR1dYWmZTcnFGTW9yOCt2ckM0S0pEVXFsRjlBR3AxelJR?=
 =?utf-8?B?WXA3c2QzdHo4NGwza1dkcVdsZXFkZkUzdTNLdzJaWG52ajV0R0N3ZXd6YWtJ?=
 =?utf-8?B?WmVLL2daVi9vdzNzbEZ0NVJEc2RMRitrdks2ZFlidWRFdmNva2FWMkZIUFht?=
 =?utf-8?B?UkJLeGFoU2NmbDZXODdOL0hac3FSUXZ6TmZpdDZlcGMvWDFZNHBzZjdsMHRF?=
 =?utf-8?B?aG1UZUsyYkw0bHo3aHJxYzZENFcxL01kNi9IWDBDZlBML3BXTFUvTlpwNW0z?=
 =?utf-8?B?aUMxRFY4Y0xqb0RsQ0hiZTdoSXVnWFZjSldVR1ZkemF6Y1RqNnhQNlV5aDFw?=
 =?utf-8?B?cGhac29yV1g2OUcrUTY0a05kemdOVXpOMVhqMjhMam1aV0ljaUQ1MXdhblI4?=
 =?utf-8?B?Z01TWTJjR3VDb3lpL3F0M252KzA4SGh6NmNjcDJFalEwUVZvYWJyNUpaNThp?=
 =?utf-8?B?Wmc3ZzA4MEVPSkdYOEhMOE5BWGVBSGR5bUt4V2N6QXRhTFo2a2RUK0V2N0Fz?=
 =?utf-8?B?TnQ3QlRUR093UDhQOFpVTHRRcjJjUUpTOTdtdFhnVWVqWVdOQWRMekhQa1dC?=
 =?utf-8?B?cktnVmVjMWlUczl5R1dOYTV2ZnZ6UmhRb3pGd3ArdXRndUFSWVFuS2Y3Vmk0?=
 =?utf-8?B?VHhtN0I4UFJBTnBudHZyYkFlbG1Wb0pVRkhUcWZJZ2ltTWdndnp4bTFRVkZx?=
 =?utf-8?B?UndlY3h0WnZSVHBWSlFZRlI5YkhrYkk4ZGZrczE2emJ6ajFraURHaXJucUFv?=
 =?utf-8?B?VFk5TFh2WU4ycE42MXlBWURJc3FjeGREbXNSMVFxZUYwSlA0aS9FUFhQNmxH?=
 =?utf-8?B?Zm43dnF0NFJIRm1kNW9pV3pLcmp3dmlpNEI3aGNPTXN1aDhMU2pEaStYM3pF?=
 =?utf-8?B?Q0UzLzdmeVRqczVLcGp4aHR0Wm04VXV3SERrc0lkK0RpemlkODhSSDhCZXRn?=
 =?utf-8?B?VWZRV2NwSTdDUHlvVDJXdThWKzVnanMxNU02MGhaQnI4TFlSWVJ3Q0E5OWtJ?=
 =?utf-8?B?KzJ5OVk1SG80QzBoNllZaTZ4K0xncjlJcDEwSDM0cmFVQUxoMDJrb1lFV05P?=
 =?utf-8?B?VGNFMTMrVUNXYUc1YkNwcE9Nd1Q5K1FpKy9ibnRNVGhpc1BEZ3dKOVNDNnpj?=
 =?utf-8?B?OHpvem5UaDNkQVU1czc2R3Bud1R6OWlMNzJoaXFzUWhaRlRMQWQzWi9DZjlT?=
 =?utf-8?B?SnM2c055U01iM2xNR3ZvMUtlcjBPVVV4V1VJVXE4RTFIZExHdXpWeHdjOEtI?=
 =?utf-8?B?UVpMT3Bwd1dTNDBWWHRzdVVYRmxGVUpYTk5RVlRZWVNSaytBWjd1Z2ttZGlI?=
 =?utf-8?B?am1vWVpPWHJnSW56Y1l0emJEVExVRFNuckhuRWlMMGltRUxNUHpkZGRFaDd0?=
 =?utf-8?B?OFRsMDlRYlZMeGx3UE9KOHM2b3BxUlNETmo5RlRRWkQ1Z1NqTmlWcE1nNktT?=
 =?utf-8?B?aTl6akdFeXNtQjV3VnBjTGEwSjRYeE5yR2NiWmVuQlBQTmdzaDBRZ0NKTjF3?=
 =?utf-8?B?bWRHYTB5Rzc1VkZHUVRKVUh4WkgrdExkbXlCQTM0SnU0bHJ4Y1FrMTZtbCtv?=
 =?utf-8?B?TE5RdnpPdkJJMTYvbmZHWmtYVExrTVRYRC8rdXkxNzhCNFVsZkJSQ2FBaHNu?=
 =?utf-8?B?d00xVUdNMjVkNzQ1b0RZdGxFSTcyaUhoSTVoQzRNZnllNVBRbFdZV0NBUElZ?=
 =?utf-8?B?Uk9TY0lSajRTNXNwSjlVd2lieG5OY3Z3dWtGR1Q1Tm04dlUzaG5Sdmx0cTlN?=
 =?utf-8?B?cFBxeDNTd1ZrU0JBeGhxdjVNYzlaT0pmazQyRmN3VXpJWHFEU0hlL0pmRGhL?=
 =?utf-8?B?dHgyRldlaDFVcFZheEQzbnJidUFmTGk2ZmwzaDdubDhCQm5GaE1WT2FxSDhU?=
 =?utf-8?B?V0x0S2ZZZ0lMdDh1YW9zUW82QzFNOGE3TmozVHdMdkI1YXZTMEhWRVlSOWFh?=
 =?utf-8?B?UlI4R0dIZGhtTytVeEdiV1lUQ2hwMEVVYXBMY3FueTJSYllETmxsRWtsY3Aw?=
 =?utf-8?B?Z05kWDVlZEY3b3hOSi8wTW85ek41VnJpbkd0MEZuT1JyQ1ZkSXNmQ00rSnNW?=
 =?utf-8?B?VlAzdHhxVXRzOVJVWCtrejU2dFExaFJuTmhHVjlxVVVveE5DTmIvS2hOdHV0?=
 =?utf-8?B?MG8vcnNIc3NscFJJWkZZUVNYdWlCdnlQNzdDQ1pWMURQM2tXL05sL3hjaGZZ?=
 =?utf-8?Q?wyc38IR3mw3k9tZvOZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b3bff2-41fc-4b93-7665-08df0544cde0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 20:41:58.1813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5hBh/mJ5HXty336ofbKI4ekWk47ZIEHopvfh9BOoSLMP4s6/yCL3Q31SQvDee+sO4bJyRD9o+mOu1anQeF7bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
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

Weekly promotion tests found no regression.

This patch is
Reviewed-by: Alex Hung <alex.hung@amd.com>

On 8/22/26 08:57, Hari Mishal wrote:
> [Some people who received this message don't often get email from harimishal1@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> get_estimated_bw() divides by link->dpia_bw_alloc_config.bw_granularity,
> which is zeroed by reset_bw_alloc_struct() and only populated once
> DP_TUNNELING_BW_ALLOC_CAP_CHANGED has been handled.
> 
> link_dp_dpia_handle_bw_alloc_status(), the DPCD interrupt handler,
> calls get_estimated_bw() whenever DP_TUNNELING_ESTIMATED_BW_CHANGED
> is set, independently of whether DP_TUNNELING_BW_ALLOC_CAP_CHANGED
> has ever fired for that link. A connected USB4/DPIA tunneling device
> that reports an estimated-bandwidth change before ever reporting a
> capability change drives a division by zero in this IRQ path.
> 
> link_dpia_send_bw_alloc_request() already guards the same
> bw_granularity division; add the identical guard here rather than
> introducing a new pattern.
> 
> Fixes: 8e5cfe547bf3 ("drm/amd/display: upstream link_dp_dpia_bw.c")
> Assisted-by: gkh_clanker_t1000
> Signed-off-by: Hari Mishal <harimishal1@gmail.com>
> ---
>   .../gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c  | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
> index dd854d992692..f43fc4b78a8d 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
> @@ -103,6 +103,11 @@ static int get_estimated_bw(struct dc_link *link)
>   {
>          uint8_t bw_estimated_bw = 0;
> 
> +       if (link->dpia_bw_alloc_config.bw_granularity == 0) {
> +               DC_LOG_ERROR("%s: BW granularity is zero!\n", __func__);
> +               return 0;
> +       }
> +
>          core_link_read_dpcd(
>                          link,
>                          ESTIMATED_BW,
> --
> 2.43.0

