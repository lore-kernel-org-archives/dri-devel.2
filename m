Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE822C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6173110ED2B;
	Tue, 11 Aug 2026 17:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c41UvTwm";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011005.outbound.protection.outlook.com
 [40.93.194.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D71B10ED30;
 Tue, 11 Aug 2026 17:35:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysGzfS/fGcXmxuVV3Vw3KtYH0QPYaydZyqzm1LWfF7whIW0lnvqCCPjWAI2Jxg27pKQh70ohfRDu6AHqKimEJEtbyVf/6O5DcKHN9c4TKEov6PxoQwWI2Mc/WB/EmzYeN3/63AwhlV3sfUG00FN7BpCsTWcybhOXgZIT5aUq/ASRVJJKZ1Wu1Os5x0XBhkdpURGQJSJKpz1ddj3JsPQ7bHQLHYBbEDGoDrqMWDFE57FBbDFipjV3Me20Xw3ZQXrvZUvvAhpvNAW9s5qBmdmhb76bAr+Q7ofj/aXb2/HylnYtAD5lzrxaCWjJQ7JefQSst1aOy8MMW2TLiwR6TSJ4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVyLyjyonB92+lc+SjF9c0JIdq13kEKvFvhANgAg5GA=;
 b=jwm/hg8i3QMaj/O+B+iIsqrlfia6E4lVSlO0pLYgcvSSG/k8ZEvaxyp4nTLC0f0INIDBaBZ/kXiYJdYjA/ahh8YmxjPymv/WI+I4D078at5vejTKe0pLsjcm5O0QE+vNbU5+pOBWVVcTjX1Dh6iP5GHJpzRFID3btThtUNQiO2TWulFUp32zIJQkIRQLnfW9ZWR7nGYfIWkFfal0ioTA3aA6AAd2/95/3h+7zrA9MdsEcJy2sT4F6exIvhHur0yF7RVMCpr6CtRCdR0YVEZ2dB1iQscAOhZaQUV0nA1ck3kIOvz2AmAt8LQSaYBkjI+9rxFD35tof9tVdCKm+4fMGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVyLyjyonB92+lc+SjF9c0JIdq13kEKvFvhANgAg5GA=;
 b=c41UvTwmY134lCblp75Bl0nE2dZ1Lk5xgDC5ykZFUvvSjMj6ooGHK1pGjY3FoOrpNb76lK13etlTLkWSsE27kqb6C3xqLCi4U98TGIdNh3EZWOFqrl9rMN0W+WH5sG1wOmfedQN/wqr6CsFP7PRtqkwFhIelpQdUbKCkNwoCdPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by PH8PR12MB7421.namprd12.prod.outlook.com (2603:10b6:510:22b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 17:35:44 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 17:35:44 +0000
Message-ID: <19405ef8-255f-4f0c-8510-8e7530e7b875@amd.com>
Date: Tue, 11 Aug 2026 13:35:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] drm/edid: parse HDMI 2.1 gaming (ALLM/VRR)
 capabilities from HF-VSDB
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 Bernhard Berger <bernhard.berger@gmail.com>
References: <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260811003921.1398292-3-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260811003921.1398292-3-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::15) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|PH8PR12MB7421:EE_
X-MS-Office365-Filtering-Correlation-Id: 793e1e1a-9ce4-46fc-7a7d-08def7cef896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|56012099006|10067099003|5023799004|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: lJKZ3sRCnOAyexDWj4wxO9zNYmXqPFd+3lZtURZ9OLuz3bcDA+6zKABd5wr2sd6XSn0zUGFIEhrsaLDK/7a9d0WJujIczV5vbQae8XJ5K2FVmCM0YenU53fFOe6wBgzLuPHIQ87E/GmDXTYHzZCTjpo/7aYefHCFHP0wigv6VyU24Jf3/ANBAh6d7NJY+zeSZCtDWfUiwwB0AMxxEj+PYJe/W7P6q8xGcM/hNrc5t8VqgaDNwzPvxj50ZL2SB/jzTPQ6S/HTisIr3paDl9NWiJb+tulhgjg6H4x5c+Fad/5ri6OR3xxXNfC0Gt9qOPQOyt9hk7D1LFGrHC9qnD3dNEYat2DPUrZN44T3DbqFp5Z/2dRxOEzPVGxDsHgUx7TkvoqkOzy2wq/0I2WytrVzraGONGI+RI5Dtgq1cOK/XAUWyB9XOhZGYI4fZ8/jqzPz4TR1un2t5oL2E2yssy0iAyUxlI7YERTeGW9hhandorLvcNpshp1+AerD3BvpR3hZ/5LfGScbDjStaD0besxARUarXjsp+8ZDuevRKSbEor4kGMpifHqvZtCacggLLqTWtgrqpsN+ujueeQbcWwMmXPXkp/ZfU0B0DVsLZ8MKyHovPXTSfiCLnftlhNiBl0UPuhI5UCZPte0e4fAsNLkkNz0sig+//BXchIOuGqF6p88=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(56012099006)(10067099003)(5023799004)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejd3eVBtV0RNNkxPNWZLYnVjdEdEL0xUcGlBYmE4dHNrN0tRLzR5RVI3amhw?=
 =?utf-8?B?eHJqeVI5MFoyN0RnbW5GS2M4d3l1cG4rS2dWTUxlT1JJbkNZRXhIdEliV0NF?=
 =?utf-8?B?dmdWR29OSDNEUDBuMWZSaHpiYTV1TTMvZkJRQ2RnUUZvM3IrQVZjUFpCZWYy?=
 =?utf-8?B?U0NyRkd5em1KbktGcVJzWDYvbWswTEZKOEFwMmVVWnNCV1ZFcHZQTCtOVnY4?=
 =?utf-8?B?Wk5ac0ZZNWdaWVNrclN2TWdkU2hrNE9qWitya0pWYnE4cmxVRUV1QmVyM3RD?=
 =?utf-8?B?R1h6NTJFWURGRFFBWWlxYTZoUDFnREVadlhiU2w0WWJFZG5MZGtlc1NtbUFS?=
 =?utf-8?B?YkpWYzVqZVpNdDY5enoyTllNaWFyVWlJOVhaWDl5eWdHWEhNS1VqN2xaRDlP?=
 =?utf-8?B?dWhNLzh5cUJwRnBRa3AvZVdvdDFVVjNlMEtFT0ozN1B0WmJSUmhvdmVYa1I4?=
 =?utf-8?B?WUhXQUJvdmthbnlMcGRlUGdFdnJ2SWw2QS95SHYrT0ZFWnJpajRZdE1kTzRN?=
 =?utf-8?B?RW1vdVJqbGxxbTVBSUhNbU5JSXlDK1JHeDVUYllkT2RKM3pmVGsrWmhyNVNz?=
 =?utf-8?B?eXhMbjlnMDdDdE5ibGZmSG5GdGE2ajJmU1BvZ1EvczZYOFd6dHl1eGsycnVa?=
 =?utf-8?B?UGNFS0JZVGxaSW1rYVhxYlM4dnBScEpFMjkzUWErUHJTQ2kxOGVoZVVvZEs1?=
 =?utf-8?B?RG5wZTlyMjZKb2Z0bXZ4b0k2T0VzVm1ZWWo1NEx6SGR5K3VYTitES1hxdkU5?=
 =?utf-8?B?eCs0blNGRGgzWXpQVit1VjVuc3VxMC9JVzhPaHBuem1BanU4TGZOaFN3cHAx?=
 =?utf-8?B?anNaVDJKRGJORWp6VzY4Ujhlbm1XQ3R1UFBQcUhzYmVQVmVsSkJCWWR2N2R0?=
 =?utf-8?B?QVNQK01HZ0VUNTRFd1FQN3U1NmFnN2ZFdFd2M25CWVY3dXNLaFR6cURKYzZw?=
 =?utf-8?B?cXZualNHRE1JWlU0WW5mZ0F4dHJuMS93aEUyaUU5M0N0OE11ZGtDSVM0YTdD?=
 =?utf-8?B?SkRHanFOM1U1YXM4Y3NDbC9aM3BpTktIeENVTU1WUnhoWFN3Ylpsb01oRDNF?=
 =?utf-8?B?Q0pjeVFtbzNyNDhxK1FpMmRYNnh5M1hVVERVVm1DTit1K1E5Wi81NmJKY05j?=
 =?utf-8?B?aXp6RU9mZ2l0SVlFV2xFVktqWXJwbE1HSXhTVmsrZ1JmdjliUHhLaDBqS3Fz?=
 =?utf-8?B?THQ3SkFLZ1AxbXhZZm5zNHo2OStOSjY1ODhNeHZuc0p4VUZQTnZRam42NVFB?=
 =?utf-8?B?ZFhDeldxUGFyUDNmZXJyNGVUVFJWd05aZVJoMlhkYlhvSjFUVHc0bUlRclpY?=
 =?utf-8?B?L2s1MXBNWXl6dDBHbGloOHlaekUramNUVU4yN1NpdlhNNDVaYWdGbXYzUlA1?=
 =?utf-8?B?TUJzQTNTM2E0M3ZYdk9sbXdzNjMzT2hKdmVDdWtkY0pvWXlwQkNCZmZZQ2Np?=
 =?utf-8?B?L21MM3YrM3hTZkZzcjlDTUdEREtac3pkeStRZEtKVHpiZ1RnNXJmSmNOK3Ar?=
 =?utf-8?B?aVZLcXlnVGQ2elhZYW85MklrbnFLV3E4L091VDlmc01YeFVFTENSRHVkei9L?=
 =?utf-8?B?QWk3NzJxVEhnNWhFcHhlWS9sN3dZOE42YVY5dVl6NjY0MkIvcmtrak1mSlVv?=
 =?utf-8?B?d3RvQ2VRM1J1K0lHakgxL0FncDU3Mkcrdjh6Y3JHT3M3U3VBS1c2TWhWRFM1?=
 =?utf-8?B?MDQrMWZEcGlRN09xS0dLaDdMWnJFUmtCMlVyNmRWV3ZKNXJHMTZrNVNqb0x4?=
 =?utf-8?B?QXpEbHFVTVp1Vm9TQ2tDaHpKaDh3eFBwcXUxcUsxeTNabGUvM0dlVE5OM3g4?=
 =?utf-8?B?ellWbm1CZ1NXTXd4WjRBV3lsU08zMmx6L2FDZmwwT3pBQ2s4TWVIVkd1RUJk?=
 =?utf-8?B?djY5aW0vTjZkYUVsOHp4VlY5aFlsT1h1aG9NMEcvdG5tdC9TbUNqMTZ1MWVv?=
 =?utf-8?B?ZzRnUGl6OHEzZVZiQk1HZm93S2xPajhYVElTNWtVWHNNQS9NWFBvc21tOEZF?=
 =?utf-8?B?SW1zWDd4eUIzSjR3dCtTc01MZUs3ZmtOdm9XRGFETDlQS1M1V1Nhb2RkUUZj?=
 =?utf-8?B?Mjg5UmRaMFNJMlA4Mk5LOU1JbXRGTmpOSE93OTRWZEhjUVRnNjdMbnFEWWhW?=
 =?utf-8?B?R2xqa0VteTNqZDMrQ2NtYy80SHJTY1duWXUxQkY3Q2R3dmY1RitGVUQzSm5i?=
 =?utf-8?B?L2hTSWI3Z0thOUg4cVpndVM0NDV4LzhYSU9ETXIxbjJNU1Q2cWViMlIzaHhM?=
 =?utf-8?B?eDVIVHB6SWpLNXJoT2o1ZSs2VTNPTHdycHpHUHJsWmJuY3BSS1dzQlBtaTk4?=
 =?utf-8?B?ei9WUVp1UGcyNzdHZUZ3U09ydHBpanRXdGYvTWhUM1ZZZFAzdldPZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793e1e1a-9ce4-46fc-7a7d-08def7cef896
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 17:35:44.1062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 840FZ3AGTgXeTGRA0O4Du8b5AoK/0tyjg+iIOq5EvYMOtP6vPXqcLnPlnN0mkQseAQJjj59ob8BlBuz/f3mdkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7421
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

On 2026-08-10 20:39, Fangzhi Zuo wrote:
> From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
> 
> Parse the HDMI 2.1 gaming-related capabilities advertised in the HDMI
> Forum VSDB (HF-VSDB) and expose them through struct drm_hdmi_info so
> drivers can consume them.
> 
> Add struct drm_hdmi_vrr_cap describing the sink's VRR capabilities: Fast
> VActive (Quick Frame Transport), Negative M VRR, Cinema VRR, MDelta, and
> the VRRmin/VRRmax range, together with a "supported" flag derived from
> that range. Add the fapa_start_location and allm (Auto Low Latency Mode)
> flags to struct drm_hdmi_info.
> 
> drm_parse_hdmi_gaming_info() reads byte 8 of the HF-VSDB for the
> FAPA/ALLM/FVA/CNMVRR/CinemaVRR/MDelta flags and bytes 9-10 for
> VRRmin/VRRmax. Per HDMI 2.1, VRR is considered supported when VRRmin is
> within 1-48 and VRRmax is either 0 (maximum based on the video mode) or
>> = 100. It is invoked from drm_parse_hdmi_forum_scds(), and the parsed
> values are logged for debugging.
> 
> Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> Tested-by: Bernhard Berger <bernhard.berger@gmail.com>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Maarten, Maxime, Thomas, I'd like to merge this into amd-staging-drm-next
since other changes depend on it. Would you like me to push it to
drm-misc-next as well or wait for amd-staging-drm-next pull to get it?

Alex, any objections to taking this directly via asdn?

Harry

> ---
>  drivers/gpu/drm/drm_edid.c  | 42 +++++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h | 47 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index ae26618a9a57..d508ec633c9b 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6182,6 +6182,33 @@ static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
>  	hdmi->y420_dc_modes = dc_mask;
>  }
>  
> +static void drm_parse_hdmi_gaming_info(struct drm_hdmi_info *hdmi, const u8 *db)
> +{
> +	struct drm_hdmi_vrr_cap *vrr = &hdmi->vrr_cap;
> +
> +	if (cea_db_payload_len(db) < 8)
> +		return;
> +
> +	hdmi->fapa_start_location = db[8] & DRM_EDID_FAPA_START_LOCATION;
> +	hdmi->allm = db[8] & DRM_EDID_ALLM;
> +	vrr->fva = db[8] & DRM_EDID_FVA;
> +	vrr->cnmvrr = db[8] & DRM_EDID_CNMVRR;
> +	vrr->cinema_vrr = db[8] & DRM_EDID_CINEMA_VRR;
> +	vrr->mdelta = db[8] & DRM_EDID_MDELTA;
> +
> +	if (cea_db_payload_len(db) < 9)
> +		return;
> +
> +	vrr->vrr_min = db[9] & DRM_EDID_VRR_MIN_MASK;
> +	vrr->supported = (vrr->vrr_min > 0 && vrr->vrr_min <= 48);
> +
> +	if (cea_db_payload_len(db) < 10)
> +		return;
> +
> +	vrr->vrr_max = (db[9] & DRM_EDID_VRR_MAX_UPPER_MASK) << 2 | db[10];
> +	vrr->supported &= (vrr->vrr_max == 0 || vrr->vrr_max >= 100);
> +}
> +
>  static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
>  			       const u8 *hf_scds)
>  {
> @@ -6308,6 +6335,8 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
>  
>  	drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
>  
> +	drm_parse_hdmi_gaming_info(&connector->display_info.hdmi, hf_scds);
> +
>  	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
>  		drm_parse_dsc_info(hdmi_dsc, hf_scds);
>  		dsc_support = true;
> @@ -6317,6 +6346,19 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
>  		    "[CONNECTOR:%d:%s] HF-VSDB: max TMDS clock: %d KHz, HDMI 2.1 support: %s, DSC 1.2 support: %s\n",
>  		    connector->base.id, connector->name,
>  		    max_tmds_clock, str_yes_no(max_frl_rate), str_yes_no(dsc_support));
> +	drm_dbg_kms(connector->dev,
> +		    "[CONNECTOR:%d:%s] FAPA in blanking: %s, ALLM support: %s, Fast Vactive support: %s\n",
> +		    connector->base.id, connector->name, str_yes_no(hdmi->fapa_start_location),
> +		    str_yes_no(hdmi->allm), str_yes_no(hdmi->vrr_cap.fva));
> +	drm_dbg_kms(connector->dev,
> +		    "[CONNECTOR:%d:%s] Negative M VRR support: %s, CinemaVRR support: %s, Mdelta: %d\n",
> +		    connector->base.id, connector->name, str_yes_no(hdmi->vrr_cap.cnmvrr),
> +		    str_yes_no(hdmi->vrr_cap.cinema_vrr), hdmi->vrr_cap.mdelta);
> +	drm_dbg_kms(connector->dev,
> +		    "[CONNECTOR:%d:%s] VRRmin: %u, VRRmax: %u, VRR supported: %s\n",
> +		    connector->base.id, connector->name, hdmi->vrr_cap.vrr_min,
> +		    hdmi->vrr_cap.vrr_max, str_yes_no(hdmi->vrr_cap.supported));
> +
>  }
>  
>  static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index cd06a3b914a0..9f8f109c2dd1 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -254,6 +254,44 @@ struct drm_scdc {
>  	struct drm_scrambling scrambling;
>  };
>  
> +/**
> + * struct drm_hdmi_vrr_cap - Information about VRR capabilities of a HDMI sink
> + *
> + * Describes the VRR support provided by HDMI 2.1 sink. The information is
> + * fetched fom additional HFVSDB blocks defined for HDMI 2.1.
> + */
> +struct drm_hdmi_vrr_cap {
> +	/** @fva: flag for Fast VActive (Quick Frame Transport) support */
> +	bool fva;
> +
> +	/** @mcnmvrr: flag for Negative M VRR support */
> +	bool cnmvrr;
> +
> +	/** @mcinema_vrr: flag for Cinema VRR support */
> +	bool cinema_vrr;
> +
> +	/** @mdelta: flag for limited frame-to-frame compensation support */
> +	bool mdelta;
> +
> +	/**
> +	 * @vrr_min : minimum supported variable refresh rate in Hz.
> +	 * Valid values only inide 1 - 48 range
> +	 */
> +	u16 vrr_min;
> +
> +	/**
> +	 * @vrr_max : maximum supported variable refresh rate in Hz (optional).
> +	 * Valid values are either 0 (max based on video mode) or >= 100
> +	 */
> +	u16 vrr_max;
> +
> +	/**
> +	 * @supported: flag for vrr support based on checking for VRRmin and
> +	 * VRRmax values having correct values.
> +	 */
> +	bool supported;
> +};
> +
>  /**
>   * struct drm_hdmi_dsc_cap - DSC capabilities of HDMI sink
>   *
> @@ -330,6 +368,15 @@ struct drm_hdmi_info {
>  	/** @max_lanes: supported by sink */
>  	u8 max_lanes;
>  
> +	/** @fapa_start_location: flag for the FAPA in blanking support */
> +	bool fapa_start_location;
> +
> +	/** @allm: flag for Auto Low Latency Mode support by sink */
> +	bool allm;
> +
> +	/** @vrr_cap: VRR capabilities of the sink */
> +	struct drm_hdmi_vrr_cap vrr_cap;
> +
>  	/** @dsc_cap: DSC capabilities of the sink */
>  	struct drm_hdmi_dsc_cap dsc_cap;
>  };

