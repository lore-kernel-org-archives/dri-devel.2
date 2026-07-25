Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F22C531F9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 06:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223E910E115;
	Sat, 25 Jul 2026 06:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a2E30HsT";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E0D910E115;
 Sat, 25 Jul 2026 06:02:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOaFno2Vq7fkZuEu+ZwmybvkhLF7acxU5QLLRljXEo1mAQJ2YE6WtzxrxOwYQBeTjDVWOMp/WoIYb2+z5Ma+RARqsuOHftWpC2UnJYf8Hosp78c+sB5cNz0HYbsRqn0kUnn7E0K2MPCIBjIBKyGPFsnhxAH4wd2BM1EmN2na3R1XOo+wINzXFJis18O3iSjmGCR7YUitXtxDA/qQlNi5IZWsoRfoUdlgxgFk+EoiCiqII/QOfJ6dsBaE9A5PJfOurc/aWsyMuHb47TYWZDW5gkfczdL72KBU7xeLFjyP9t8AoBd9mR79LvKP+VxkyiH/ztnf+qtQQjng7TOJBg0LIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjgTZVXWSPGLN0v95/37GDHXIh0UjdMb6obmsg+STvw=;
 b=kqfE+H2zbqkRfaxgF+g8t7HXCR+Z/AGalDheCt7si3BaZR+2jtcOSOaqTqXAKJhG4CmDA9eg9L8n+Pr53L2yGxwCat971BVP4LntjAjPSXj/JNUeu0chCjxUre3ovY84tt42h/foHUtvRyZE32W+szSFRAPkPk3MYLgoeHEojGwiqHM8ezfQeUkoWEbae2Xyd61vFURnZtToulUcBhnWjPPn/rHRnZUj0i6l3F/IPoBxkyJtedQO+NdprpGZSLc0X6fz2ycsdRuu+BP5GafCaX9xN2PauvNeYrOoJDgGwCymF04PU6SeVRleoccqUprLnxr4/eX8ldFCcLVRnqKvzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjgTZVXWSPGLN0v95/37GDHXIh0UjdMb6obmsg+STvw=;
 b=a2E30HsTaYymcLAjOdnAn37oO2QtU5rE3xJmSuNbFvq1Tp+lIkxnBCNxgNXk1Co2JGO/NYqEh8A5JBUPgiH+TGfhbwhgRRx7MmgUGJ2M3bBgjhl04WP1HDLvWfC4tL4rV94qcMDVzyrDvnej2n8WxnEtRLtwVjqZs1El4+z3cpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 06:02:53 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 06:02:53 +0000
Message-ID: <ed5d2a12-1ed8-4203-8b09-e71406e3c855@amd.com>
Date: Sat, 25 Jul 2026 00:02:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Melissa Wen <mwen@igalia.com>, Robert Mader <robert.mader@collabora.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-2-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260722134607.136293-2-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0166.namprd05.prod.outlook.com
 (2603:10b6:a03:339::21) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7482e7-5a28-443c-fc6f-08deea125db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YY0JpXn25+WtwV1YPeVLHPgzQ5V/0H7Nisv/99Vo1Nr1eJgn/dorK3q9etCMCXRXkiykwk/QvCfLCy5MSJfvnHgzfD+Lp1VR+9g52NIoqKbWyyVYwXMc4O9LSoRjgFdx+lw5wUM1Dm5YYAHRI/jtItJHc9Mt9ZkYJdC5z1qWlW37MPcemKuSAEOc+PIcOQN591GgMK3WdsBio4eRjiX87TVUgbo9yKwijllk/Dw2kBtWOzVPcWTIREYzdlrtBEZxg8XEzbrNwKH1BYkuFyu8Ut4ZvGLxGO1QFCATfCGClCE2HSxm+Suz14drF9n/hfFad54oVrjK2/iMjNvGV2H/xurVGWHHiBIFEVWr5p1XK11S+73tOUkX3TzO1sBl61medh7veTcoAd5gl2F3k/iaZlmfS2X3CyZYmD9tq6lcuxHjlqBLvxdaMRIsrfEi4A48RnO5AdmiXFSkxFypslHIoz2Uq7YmU2Ov7ETQ6NTfZj7jlXjrX07PLDOa288yWwosPy5eyrlpvlqzf/QtGRavrQ7/bfnLJNYKAXgpNYLV+Vr+gZZeDU04Mn2Q4V6Y8J+Kbdrm2xH5PJrcNO/t1wCAEnITVO91zLiE+viMKX9l4iMSQ62QpaFwEPaOjHRXcX0PGt4NkU/7Q077xGGotiDwOOx2R7APesyMGT+IFoFIoWU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlN0N3UrNERlSmxhcjFGSWFXbUhFWlVtakxVL2tSdUc5bFlWcmRrOUh3Qzdm?=
 =?utf-8?B?NjVwNld0dmxJNXhUclBPbEpDVmY2WE9nTEhKTTFIU1U4NC8rTHdXOXJlVGUr?=
 =?utf-8?B?WkdQQkdBU0h5dDRvcUhkeWNhaG4rdG44SU0wM3ZkMElVTWF3WVlKVjlWQUl3?=
 =?utf-8?B?ZDhrNmhTbTA1b0NDaEd0TmlQbEJXc09UbDdpbStNUW02ME94UlJMb1V6UlEz?=
 =?utf-8?B?dGd3Q2hldHBMaTBxSXV6R3hKRExzL1ZGUHlCQ3JwTlRSNDlvSzJXNHRDaW1O?=
 =?utf-8?B?SXh0a2p2RDl4ZTlla0JPZ2N2NHB1OEZ2RG8rWFV4dTJNdURCZWZnbk05WjNZ?=
 =?utf-8?B?Tk5aWE8vSWhod0gvK1JJaGlnRXpOYnZ3UktPNzJIeWpORTlDNjdHQUMrcnNv?=
 =?utf-8?B?R1FjWWZWZDVMeXg4eXJ0cWs2Mml0V0tSWitlMDBxdjJEOXJiRmlPTGxjRGx6?=
 =?utf-8?B?d0l5U0hHYzVSdXhTUHVmTmhqUmJReklTc0JkZUFwcFBKajBxVjV2V04xZjFh?=
 =?utf-8?B?WmdJYitZRmdpSUd4dmt1eEp0eUtHcERYRGJ0UHcwSml4N3dva3BaVGZhekhB?=
 =?utf-8?B?OXNZTTlzSVRscnh1REhyL2hpUHg1SE5XQ2VIY3g0NHNrRGlJUnN2bGtUbnpv?=
 =?utf-8?B?MjhxMTFtemlTSGNNUmRyN3lMYzBwaWV4Zm94ejBEL096RXBWbi9Xb2ovTHlj?=
 =?utf-8?B?bkhhR01iTTJkSXR2R3lvN1BuSWpvL081ZnFtUjFrMXVJemxuSmE2VE5HblRQ?=
 =?utf-8?B?RGJLZkpEeFhmZzhqYzg1ckdYZ0ZxT3BUd285bkQyR1JYNEpWRW9weFpSOHJj?=
 =?utf-8?B?Y1JNb090QnBBWjBObkhmZkkwNTdJdzZ4OGlrMDdWYW9qbXhuRlpPYnNidVAy?=
 =?utf-8?B?TlBCUVR2eGJScGV3MjJsV2orN3JYVTMzMHRDc3QzVnBXcDlIYWxpYkNRT2cx?=
 =?utf-8?B?UU40MkZQdTFLTS8za1F6S2k5c3dQMSsrZldyN3RqSHhkNjl1YXJKV0gzOG1t?=
 =?utf-8?B?TjFJRXNvRnFNUllQdHVWVmc4cTRPbndRNGlkQmhwMm45K2xMMVRXWlA1NG1m?=
 =?utf-8?B?MFlWYzRPang5bEw0L2NHVVNWUTVNN0w0UEJTVzhBa3ZzTGprL01ITE95cjd0?=
 =?utf-8?B?ZnpPaW9LUUtDOEl2UVRUOHVqRTl0K2k2TUZxRncwRHpNOTF2YUF5TGZYZU5t?=
 =?utf-8?B?aEo5anMrVU5YSHdOdUFUSnBTNVlZMFUxSU15TTI4Zit3MXNpR3FwZUhmbUhs?=
 =?utf-8?B?TmFHK1BEZ3NQRnJPMEIzQzFTaVRvVEJYOHU3R2FRaVFUdjFwb2NLeFY1NEVp?=
 =?utf-8?B?WXAyQXJ0TkxvZXRBczVhWFZvV3hwekpPaHFZR1hmUUtUT3RCcGdKbzF4UkpX?=
 =?utf-8?B?cGFZbUhZQlZjUnlkSjdMN2RpOHovQmgzc1gxTVF4c1ZQRXlkWFJzSkpyWFZD?=
 =?utf-8?B?d1F1MnhPVnlhRERqcVpNMjFaTTNrVmg1dVcxR2dCRzNKL1VwdlJRV2QvVU5S?=
 =?utf-8?B?ZGEzbnViTkRCVFRZeGd0OFZ0ZDVaNXJ6NkRnZkdXeDk5RzE5VXlYakNxeDh0?=
 =?utf-8?B?WmpSdmJQbVR4U3RNdElQVUtIbWlMTEx6Wm5tbXgvM0NkeGRrNW1tQ2Q5cEdR?=
 =?utf-8?B?akxDNFd6RjhocUZOdWdYY1VsQlM3YmFHVjZvSGsvMmZ0UmNGbmJIM1pzdDZt?=
 =?utf-8?B?UWpPV3ZjRjIxSzlxaW56SVpKQzVaeUs0b2s5TWxnTWdBMXVGYkUxQnJ1OTF6?=
 =?utf-8?B?RXc4V3hkT3gwS2RVY1crVFhoQ3U0STNaRnlyUGZpL2twR2tMVVFIWHAxRjF3?=
 =?utf-8?B?dkxEUEgxTG5KVkhMZnU0ZUlSMjVsSk4vVUhWNDFNREJNQ0RlOEQzQnBreVBs?=
 =?utf-8?B?dlV4Q3VycnVsYmE5TTJBRGdTbnYybkdtNEQ0b3ExUUlKQVBSdUc5UjZMb3lP?=
 =?utf-8?B?MzVJU1ZoNS9Vb1RHMkVJUEszV2M4OUp0am1OMnYrZjMyaW56VzhKOEQxWlo0?=
 =?utf-8?B?TUJzc3dLdGdrK3FqRlplUnpERXUvcWtqZFFmM3FmRmQ2Q0lXZDUyOTJFb1lC?=
 =?utf-8?B?c1lRZENSY2lZdmtOdy9GWGN1Q1Y4RDIwSUttallyU0twcUUvK3VEVnRRa1By?=
 =?utf-8?B?UDlJSVlHNjRoQ3NYY1J4VHFsc2FKajkweEpIaDYvNXM5djMxZkFMdW9ITllO?=
 =?utf-8?B?T3FWNTZ0OEhmOThibk5wSXJmb3kyN2R2eFMrZzB0TzNYd2FNL1NSY0xsb1Bs?=
 =?utf-8?B?QlFrWUsySXZZbG5tSCtNZitvc2ZJOHl0V3p6bTVtcUFRaGo5NWxYRFVKUHhk?=
 =?utf-8?Q?g2ROSaIe8bhduM5kA/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7482e7-5a28-443c-fc6f-08deea125db8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 06:02:53.7151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zG0jJaiVDMLYPmD3chFR/tFzayaB64Tj4/pS2g8ghf2Hq6IIvB7QHH9jCDN6qx9fD0/cBLrX6GVQ0fo2cdBh2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7
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

On 7/22/26 07:45, Harry Wentland wrote:
> From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> 
> Introduce DRM_COLOROP_FIXED_MATRIX, a new colorop type representing a
> hardware that performs a fixed matrix operation.
> 
> Unlike CTM-based colorops, this block does not expose programmable
> coefficients. Instead, userspace selects one of the predefined
> hardware modes via a new FIXED_MATRIX_TYPE enum property. Supported modes
> include common YCbCr->RGB and RGB709->RGB2020 conversions.
> 
> v4:
>   - Add limited-range YCbCr-RGB conversion matrix enums (Robert)
>   - Document matrix values (Pekka)
>   - Clarify RGB709 to RGB2020 is a full-range matrix (Pekka)
>   - Fix confusing "CSC preset" doc (Pekka)
> 
> v2:
>   - Naming changes (Pekka)
> 
> v3:
>   - Fix NC matrix enum name and string (Melissa)
>   - Rebase
> 
> Co-developed-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Robert Mader <robert.mader@collabora.com>
> ---
>   drivers/gpu/drm/drm_atomic.c      |   4 +
>   drivers/gpu/drm/drm_atomic_uapi.c |   7 ++
>   drivers/gpu/drm/drm_colorop.c     | 109 ++++++++++++++++++++
>   include/drm/drm_colorop.h         | 159 ++++++++++++++++++++++++++++++
>   include/uapi/drm/drm_mode.h       |  12 +++
>   5 files changed, 291 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index e5c8ef06caed..45df6376f408 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -925,6 +925,10 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
>   				  drm_get_colorop_lut3d_interpolation_name(state->lut3d_interpolation));
>   		drm_printf_indent(p, 1, "data blob id=%d\n", state->data ? state->data->base.id : 0);
>   		break;
> +	case DRM_COLOROP_FIXED_MATRIX:
> +		drm_printf_indent(p, 1, "fixed_matrix_type=%s\n",
> +				  drm_get_colorop_fixed_matrix_type_name(state->fixed_matrix_type));
> +		break;
>   	default:
>   		break;
>   	}
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 1050dddadb17..d52504d823bc 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -786,6 +786,11 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
>   		return drm_atomic_color_set_data_property(colorop, state,
>   							  property, val,
>   							  replaced);
> +	} else if (property == colorop->fixed_matrix_type_property) {
> +		if (state->fixed_matrix_type != val) {
> +			state->fixed_matrix_type = val;
> +			*replaced = true;
> +		}
>   	} else {
>   		drm_dbg_atomic(colorop->dev,
>   			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
> @@ -818,6 +823,8 @@ drm_atomic_colorop_get_property(struct drm_colorop *colorop,
>   		*val = state->lut3d_interpolation;
>   	else if (property == colorop->data_property)
>   		*val = (state->data) ? state->data->base.id : 0;
> +	else if (property == colorop->fixed_matrix_type_property)
> +		*val = state->fixed_matrix_type;
>   	else
>   		return -EINVAL;
>   
> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index 682fcc651525..e7ccf7d053b8 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c
> @@ -68,6 +68,7 @@ static const struct drm_prop_enum_list drm_colorop_type_enum_list[] = {
>   	{ DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
>   	{ DRM_COLOROP_MULTIPLIER, "Multiplier"},
>   	{ DRM_COLOROP_3D_LUT, "3D LUT"},
> +	{ DRM_COLOROP_FIXED_MATRIX, "Fixed Matrix"},
>   };
>   
>   static const char * const colorop_curve_1d_type_names[] = {
> @@ -90,6 +91,17 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
>   	{ DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
>   };
>   
> +static const char * const colorop_fixed_matrix_type_names[] = {
> +	[DRM_COLOROP_FM_YCBCR601_FULL_RGB] = "YCbCr 601 Full to RGB",
> +	[DRM_COLOROP_FM_YCBCR601_LIMITED_RGB] = "YCbCr 601 Limited to RGB",
> +	[DRM_COLOROP_FM_YCBCR709_FULL_RGB] = "YCbCr 709 Full to RGB",
> +	[DRM_COLOROP_FM_YCBCR709_LIMITED_RGB] = "YCbCr 709 Limited to RGB",
> +	[DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] = "YCbCr 2020 NC Full to RGB",
> +	[DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB] = "YCbCr 2020 NC Limited to RGB",
> +	[DRM_COLOROP_FM_YCBCR_LIMITED_FULL] = "YCbCr limited to full",
> +	[DRM_COLOROP_FM_RGB709_RGB2020] = "RGB709 to RGB2020",
> +};
> +
>   /* Init Helpers */
>   
>   static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *colorop,
> @@ -453,6 +465,80 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
>   }
>   EXPORT_SYMBOL(drm_plane_colorop_3dlut_init);
>   
> +/**
> + * drm_plane_colorop_fixed_matrix_init - Initialize a DRM_COLOROP_FIXED_MATRIX
> + *
> + * @dev: DRM device
> + * @colorop: The drm_colorop object to initialize
> + * @plane: The associated drm_plane
> + * @funcs: control functions for the new colorop
> + * @supported_fm: A bitfield of supported drm_colorop_fixed_matrix_type enum values,
> + *               created using BIT(fixed_matrix_type) and combined with the OR '|'
> + *               operator.
> + * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
> + * @return zero on success, -E value on failure
> + */
> +int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct drm_colorop *colorop,
> +					struct drm_plane *plane,
> +					const struct drm_colorop_funcs *funcs,
> +					u64 supported_fm, uint32_t flags)
> +{
> +	struct drm_prop_enum_list enum_list[DRM_COLOROP_FM_COUNT];
> +	int i, len;
> +	struct drm_property *prop;
> +	int ret;
> +
> +	if (!supported_fm) {
> +		drm_err(dev,
> +			"No supported FM type op for new Fixed Matrix colorop on [PLANE:%d:%s]\n",
> +			plane->base.id, plane->name);
> +		return -EINVAL;
> +	}
> +
> +	if ((supported_fm & -BIT(DRM_COLOROP_FM_COUNT)) != 0) {
> +		drm_err(dev, "Unknown Fixed Matrix provided on [PLANE:%d:%s]\n",
> +			plane->base.id, plane->name);
> +		return -EINVAL;
> +	}
> +
> +	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_FIXED_MATRIX, flags);
> +	if (ret)
> +		return ret;
> +
> +	len = 0;
> +	for (i = 0; i < DRM_COLOROP_FM_COUNT; i++) {
> +		if ((supported_fm & BIT(i)) == 0)
> +			continue;
> +
> +		enum_list[len].type = i;
> +		enum_list[len].name = colorop_fixed_matrix_type_names[i];
> +		len++;
> +	}
> +
> +	if (WARN_ON(len <= 0))
> +		return -EINVAL;
> +
> +	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC, "FIXED_MATRIX_TYPE",
> +					enum_list, len);
> +
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	colorop->fixed_matrix_type_property = prop;
> +	/*
> +	 * Default to the first supported CSC mode as provided by the driver.
> +	 * Intuitively this should be something that keeps the colorop in pixel bypass
> +	 * mode but that is already handled via the standard colorop bypass
> +	 * property.
> +	 */
> +	drm_object_attach_property(&colorop->base, colorop->fixed_matrix_type_property,
> +				   enum_list[0].type);
> +	drm_colorop_reset(colorop);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_plane_colorop_fixed_matrix_init);
> +
>   static void __drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop,
>   							struct drm_colorop_state *state)
>   {
> @@ -533,6 +619,13 @@ static void __drm_colorop_state_init(struct drm_colorop_state *colorop_state,
>   							   &val))
>   			colorop_state->lut3d_interpolation = val;
>   	}
> +
> +	if (colorop->fixed_matrix_type_property) {
> +		if (!drm_object_property_get_default_value(&colorop->base,
> +							   colorop->fixed_matrix_type_property,
> +							   &val))
> +			colorop_state->fixed_matrix_type = val;
> +	}
>   }
>   
>   /**
> @@ -596,6 +689,7 @@ static const char * const colorop_type_name[] = {
>   	[DRM_COLOROP_CTM_3X4] = "3x4 Matrix",
>   	[DRM_COLOROP_MULTIPLIER] = "Multiplier",
>   	[DRM_COLOROP_3D_LUT] = "3D LUT",
> +	[DRM_COLOROP_FIXED_MATRIX] = "Fixed Matrix",
>   };
>   
>   static const char * const colorop_lu3d_interpolation_name[] = {
> @@ -652,6 +746,21 @@ const char *drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_inte
>   	return colorop_lu3d_interpolation_name[type];
>   }
>   
> +/**
> + * drm_get_colorop_fixed_matrix_type_name: return a string for fixed matrix type
> + * @type: fixed matrix type to compute name of
> + *
> + * In contrast to the other drm_get_*_name functions this one here returns a
> + * const pointer and hence is threadsafe.
> + */
> +const char *drm_get_colorop_fixed_matrix_type_name(enum drm_colorop_fixed_matrix_type type)
> +{
> +	if (WARN_ON(type >= ARRAY_SIZE(colorop_fixed_matrix_type_names)))
> +		return "unknown";
> +
> +	return colorop_fixed_matrix_type_names[type];
> +}
> +
>   /**
>    * drm_colorop_set_next_property - sets the next pointer
>    * @colorop: drm colorop
> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
> index 224fae40ed2b..92eb6463c39f 100644
> --- a/include/drm/drm_colorop.h
> +++ b/include/drm/drm_colorop.h
> @@ -134,6 +134,146 @@ enum drm_colorop_curve_1d_type {
>   	DRM_COLOROP_1D_CURVE_COUNT
>   };
>   
> +/**
> + * enum drm_colorop_fixed_matrix_type - type of Fixed Matrix
> + *
> + * Describes a Fixed Matrix operation to be applied by the DRM_COLOROP_FIXED_MATRIX
> + */
> +enum drm_colorop_fixed_matrix_type {
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR601_FULL_RGB:
> +	 *
> +	 * enum string "YCbCr 601 Full to RGB"
> +	 *
> +	 * Converts full-range YCbCr into full-range RGB using the BT.601
> +	 * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
> +	 * at 0 (the nominal 0.5 offset removed) before the matrix::
> +	 *
> +	 *   | R |   | 1.0   0.000000   1.402000 |   | Y  |
> +	 *   | G | = | 1.0  -0.344136  -0.714136 | x | Cb |
> +	 *   | B |   | 1.0   1.772000   0.000000 |   | Cr |
> +	 */
> +	DRM_COLOROP_FM_YCBCR601_FULL_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
> +	 *
> +	 * enum string "YCbCr 601 Limited to RGB"
> +	 *
> +	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
> +	 * the BT.601 coefficients. Before the matrix Y is offset by 16/255
> +	 * and Cb, Cr are centered at 0, following the studio-range
> +	 * convention of ITU-R BT.601::
> +	 *
> +	 *   | R |   | 1.164384   0.000000   1.596027 |   | Y - 16/255 |
> +	 *   | G | = | 1.164384  -0.391762  -0.812968 | x | Cb         |
> +	 *   | B |   | 1.164384   2.017232   0.000000 |   | Cr         |
> +	 */
> +	DRM_COLOROP_FM_YCBCR601_LIMITED_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR709_FULL_RGB:
> +	 *
> +	 * enum string "YCbCr 709 Full to RGB"
> +	 *
> +	 * Converts full-range YCbCr into full-range RGB using the BT.709
> +	 * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
> +	 * at 0 (the nominal 0.5 offset removed) before the matrix::
> +	 *
> +	 *   | R |   | 1.0   0.000000   1.574800 |   | Y  |
> +	 *   | G | = | 1.0  -0.187324  -0.468124 | x | Cb |
> +	 *   | B |   | 1.0   1.855600   0.000000 |   | Cr |
> +	 */
> +	DRM_COLOROP_FM_YCBCR709_FULL_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
> +	 *
> +	 * enum string "YCbCr 709 Limited to RGB"
> +	 *
> +	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
> +	 * the BT.709 coefficients. Before the matrix Y is offset by 16/255
> +	 * and Cb, Cr are centered at 0, following the studio-range
> +	 * convention of ITU-R BT.709::
> +	 *
> +	 *   | R |   | 1.164384   0.000000   1.792741 |   | Y - 16/255 |
> +	 *   | G | = | 1.164384  -0.213249  -0.532909 | x | Cb         |
> +	 *   | B |   | 1.164384   2.112402   0.000000 |   | Cr         |
> +	 */
> +	DRM_COLOROP_FM_YCBCR709_LIMITED_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
> +	 *
> +	 * enum string "YCbCr 2020 NC Full to RGB"
> +	 *
> +	 * Converts full-range YCbCr into full-range RGB using the BT.2020
> +	 * non-constant luminance coefficients. Y is normalized to [0, 1]
> +	 * and Cb, Cr are centered at 0 (the nominal 0.5 offset removed)
> +	 * before the matrix::
> +	 *
> +	 *   | R |   | 1.0   0.000000   1.474600 |   | Y  |
> +	 *   | G | = | 1.0  -0.164553  -0.571353 | x | Cb |
> +	 *   | B |   | 1.0   1.881400   0.000000 |   | Cr |
> +	 */
> +	DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
> +	 *
> +	 * enum string "YCbCr 2020 NC Limited to RGB"
> +	 *
> +	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
> +	 * the BT.2020 non-constant luminance coefficients. Before the matrix
> +	 * Y is offset by 16/255 and Cb, Cr are centered at 0, following the
> +	 * studio-range convention of ITU-R BT.2020::
> +	 *
> +	 *   | R |   | 1.164384   0.000000   1.678674 |   | Y - 16/255 |
> +	 *   | G | = | 1.164384  -0.187326  -0.650424 | x | Cb         |
> +	 *   | B |   | 1.164384   2.141772   0.000000 |   | Cr         |
> +	 */
> +	DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_YCBCR_LIMITED_FULL:
> +	 *
> +	 * enum string "YCbCr limited to full"
> +	 *
> +	 * Converts limited- (narrow-) range YCbCr into full-range YCbCr.
> +	 * Though not strictly a matrix operation it can be represented as
> +	 * one. Luma is expanded by 255/219 and chroma by 255/224, keeping
> +	 * the black level (16/255) and chroma neutral point (0.5) fixed::
> +	 *
> +	 *   | Y'      |   | 1.164384  0.000000  0.000000 |   | Y - 16/255 |
> +	 *   | Cb'-0.5 | = | 0.000000  1.138393  0.000000 | x | Cb - 0.5   |
> +	 *   | Cr'-0.5 |   | 0.000000  0.000000  1.138393 |   | Cr - 0.5   |
> +	 */
> +	DRM_COLOROP_FM_YCBCR_LIMITED_FULL,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_RGB709_RGB2020:
> +	 *
> +	 * enum string "RGB709 to RGB2020"
> +	 *
> +	 * Selects the matrix that converts full-range RGB with BT.709
> +	 * primaries to full-range RGB with BT.2020 primaries. The
> +	 * coefficients match the RGB-to-RGB conversion defined in
> +	 * ITU-R BT.2087::
> +	 *
> +	 *   | R2020 |   | 0.6274  0.3293  0.0433 |   | R709 |
> +	 *   | G2020 | = | 0.0691  0.9195  0.0114 | x | G709 |
> +	 *   | B2020 |   | 0.0164  0.0880  0.8956 |   | B709 |
> +	 */
> +	DRM_COLOROP_FM_RGB709_RGB2020,
> +
> +	/**
> +	 * @DRM_COLOROP_FM_COUNT:
> +	 *
> +	 * enum value denoting the size of the enum
> +	 */
> +	DRM_COLOROP_FM_COUNT
> +};
> +
>   /**
>    * struct drm_colorop_state - mutable colorop state
>    */
> @@ -197,6 +337,13 @@ struct drm_colorop_state {
>   	 */
>   	enum drm_colorop_lut3d_interpolation_type lut3d_interpolation;
>   
> +	/**
> +	 * @fixed_matrix_type:
> +	 *
> +	 * Type of Fixed Matrix operation.
> +	 */
> +	enum drm_colorop_fixed_matrix_type fixed_matrix_type;
> +
>   	/** @state: backpointer to global drm_atomic_commit */
>   	struct drm_atomic_commit *state;
>   };
> @@ -366,6 +513,13 @@ struct drm_colorop {
>   	 */
>   	struct drm_property *data_property;
>   
> +	/**
> +	 * @fixed_matrix_type_property:
> +	 *
> +	 * Sub-type for DRM_COLOROP_FIXED_MATRIX type.
> +	 */
> +	struct drm_property *fixed_matrix_type_property;
> +
>   	/**
>   	 * @next_property:
>   	 *
> @@ -422,6 +576,10 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
>   				 uint32_t lut_size,
>   				 enum drm_colorop_lut3d_interpolation_type interpolation,
>   				 uint32_t flags);
> +int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct drm_colorop *colorop,
> +					struct drm_plane *plane,
> +					const struct drm_colorop_funcs *funcs,
> +					u64 supported_fm, uint32_t flags);
>   
>   struct drm_colorop_state *
>   drm_atomic_helper_colorop_create_state(struct drm_colorop *colorop);
> @@ -480,6 +638,7 @@ drm_get_colorop_lut1d_interpolation_name(enum drm_colorop_lut1d_interpolation_ty
>   
>   const char *
>   drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_interpolation_type type);
> +const char *drm_get_colorop_fixed_matrix_type_name(enum drm_colorop_fixed_matrix_type type);
>   
>   void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_colorop *next);
>   
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index bd435effdcee..ed1a660a3dfd 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -955,6 +955,18 @@ enum drm_colorop_type {
>   	 *         color = lut3d[index]
>   	 */
>   	DRM_COLOROP_3D_LUT,
> +
> +	/**
> +	 * @DRM_COLOROP_FIXED_MATRIX:
> +	 *
> +	 * enum string "Fixed Matrix"
> +	 *
> +	 * A Colorop block that performs a pre-defined matrix operation selected
> +	 * via the FIXED_MATRIX_TYPE enum property. The driver advertises the supported
> +	 * operations through this property.
> +	 */
> +	DRM_COLOROP_FIXED_MATRIX,
> +
>   };
>   
>   /**

