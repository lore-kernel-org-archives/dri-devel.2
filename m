Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2171AC5DF9C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C76F510E7F2;
	Mon, 24 Aug 2026 19:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bf8g5DJj";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EADB10E654;
 Mon, 24 Aug 2026 19:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSPfcbSSwF9Hmu6QGPXJDgUzSQ5BEXNY4EamXSssYMMYu3OsnLws/oEQ6YQYz98sOsH+q+INT8gzh2U/v/uhpcf97qmq0Vz7zj/ilykBHbOgl5buNMbtgwFlqlyIHd+24TByenVMK4Ite3Gl5B8jROcDk2gWgHNMgLyNjFZnOuZxDGHQuJXwpE2wX1V5Q/lM45tvQ69c2dwElIYK7NIxUmMf/mA17UtPwGQ0dPMJIUlkDg9Pt/guuBZOzPCzNrFlR6V498q4FlE0rNrhTWTcTKbYpHWk66cowDFsht7QgKuKCHXn2dDhlHGu1yGxIqc+d32GvYKIxhEqIvzOXmPAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKpSvLv6J9+xua0E7MjQhQlyeKPTWhZmDw5o4c5fht4=;
 b=N+uGGoy5D3TODGSqt8GCSTZOkJMATehuEHKq6YILN1y6t/1fXF5Bss4Q05yA/6lZBNTf1TnWds7FMEqPax+6crzcBjOjwkYQbwsF9IuOzE5ZYGBhvIRvEt0J/EZcXOKoqgXvdIBqUvnxNgwFT2ulUtNzhyKbP8j7ObbyLHK/KuAKJbhuqnsMLBqouYixhxJO0O77tvugyTZYBc97RZW4uD+x8HXmfHxq5eufN9j9xZrJyo+6BTRvObjuKBHeuWwfaR2dTfIjkLNYwTNwWDlwLbDtyBoksci02gP4juVtSQFOlbkY4e/GGtLZG7uR+O3Zrqqi5D60VYRhF1fDn70C/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKpSvLv6J9+xua0E7MjQhQlyeKPTWhZmDw5o4c5fht4=;
 b=Bf8g5DJjX6FrTKMhNQyQXdQ4I6EZzi+mIUt/91UVqwndWPWdL8C0AzhLeXmiaVmf7bJ7rJNdD9pS0rO12KDoS0CgAa1leS+z5VfqARTglW+sghW1f1/d1l2bdk1HId1c7bjLkQzcxQ6M721jtPPEvKe/qExKmxOACBHWDjXr+DY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by IA1PR12MB6353.namprd12.prod.outlook.com (2603:10b6:208:3e3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 19:59:37 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 19:59:36 +0000
Message-ID: <239158bc-3060-4a9e-916d-86baf2031d36@amd.com>
Date: Mon, 24 Aug 2026 15:59:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] drm/amd/display: Enable HDMI ALLM for Gaming-VRR
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 daniel@fooishbar.org
References: <20260811003921.1398292-1-jerry.zuo@amd.com>
 <20260814164344.3098143-1-jerry.zuo@amd.com>
 <20260814164344.3098143-5-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260814164344.3098143-5-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0016.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::15) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|IA1PR12MB6353:EE_
X-MS-Office365-Filtering-Correlation-Id: 714f1b18-6c59-47ed-b2f2-08df021a395d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|22082099003|11063799006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: hIsXYpROR9KqVt29se5C5ohVQzQe7+uX7+tN666MDU1wXXsogRFq8KGIi/W1EdkQ8Z4P5IAyvsDj94GjaMXAPZSNIg7o1LRCyHsnqYyIaLNLSn/ZXvQ3raFKt5fF94bAIw589phaSy3c7tYBClgN9sBWOIzwQwiTrwf9DsZM4Vfhfd7VJkoeGUZ7+/y3q2fvC5YB80MVuxCl6jwIdVk93pYXj/DpO4Vzis1R8/mVJ77BPacU99fjpwShEhs5SyZejCLLsVQp6/vGRqMNRq/ZPp9o822PbiZbCT7jL6RPVuOK6U8ZlUmR6FWAzWMNTVGIz5mjcFQOpaHtv2oYJx3NNqH9Cg/vrbn/T9Ug/xBWnwlezDHbjADV/CzWiOHqJKpUIdhhwp21DiEDXy6S95OT8GvRxKrFqNmMwW1QlJ3tAfnyZucU0qbZb8dtDEF79wvXdWblK/ynMdCLwv+OoTL4rvbuZ4O+OIhy18nlJFDzwDxqGT8CDVW0kQm2C1o7oKgkkpecI1kGLcXs7PkwV9zSFEz+uyXPvJhtZ82QGKIFPsWaXMBXNDOGqlx1B7RkkUsRyfbB8c0Bfr+uboYza0lxHP+INBU3otvwQzaHGf5dL5PswGy4ovDt8AN3JcWwLtTKNGHvv3R1fg93yldj8rUjsc9FQo4reP3Y6aMmbN1Kb18=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(11063799006)(4143699003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTFJVlJDa1I3Rjl2bkV3VWY3bFI1MzhRSkJPREhLYmpVT0pHS05vWWhlZzVL?=
 =?utf-8?B?NmswUmxmS0NDSGxjQnlNM0ZnWHlUbEk4UC94YkVMZVovVm1rYzRXK0prUVp0?=
 =?utf-8?B?akI0bURxQkpsTHlvcGZSdWw0VEtwdFErZ0dUODdQSHlXbVdCblQ1UE5rTi92?=
 =?utf-8?B?ZkxQY2hqV3ZoWlRtWkZmY3Fyb0huTWZ0RlM1d3I2dStxVWNFbXk4NDNaMHc0?=
 =?utf-8?B?aE1pcTRDR2phWlJDT3VaS1dsS0hHMVFZbG90a3I0VTB1T3pEQnVzSmVteU9i?=
 =?utf-8?B?a3NKb21NWGRUc2JBNHlLcXlXUmdvVlYxRGRDeEZDWGc1Ujd0UlA2VWtCdmdC?=
 =?utf-8?B?aE9WWWRLenZBcWY3R1BmWEx2Q0xTemhYZGN1MXJ6YWMwUzg1STdFTUtncWl3?=
 =?utf-8?B?UC9mRWhxQ1RaU0JMTUF2N1FnN3E4VFFZWkVpRy8yT3BPSm0rZ3lHamVLMzlv?=
 =?utf-8?B?K0laaGpveE5HcVFhSlVQYzV4RENUb0FLVURuVlBzZ1MxUW9JTDkyVCtnQzNy?=
 =?utf-8?B?MUlHNGg2WjZBc2hUYXdMRWEzRjZIbVV3OSs4b2FKWVVvUUM2NDdtV0hZaERE?=
 =?utf-8?B?Uzd3aVF6SEI1d0FRcGl3NW5uQW9NMW5iY0FIcE5FaWEyR1owNjQ5ZUJ4ckxJ?=
 =?utf-8?B?QU94dytBSTM5emo5L1JDMWU3ZlBWdlFWUElKVkxYYXFuK3BRQTl0M21BaHZM?=
 =?utf-8?B?OUx3NXVYOW9IN2pRdDNGa1pVdk8rOFFydE1jTTFBY25XYlVRTVhXZHZoRHhP?=
 =?utf-8?B?SjhQQ2VkTjJraHZLWUdyV2w3L1FaU3NYUFlxUVhOSUpTQkhEakVnMXpoQTRT?=
 =?utf-8?B?ZVFFbnptMmpiUkJ6U05JRmc3ZzdTS3Q0eVZ6amdqcWNjYTVwdHpiajJreXA1?=
 =?utf-8?B?dHQxeFZ0SWF4Q0pwdmVJbUZ3M0Vuc3ZZeGRFRFh0Q2tkeW11OE1xSDdUQjlB?=
 =?utf-8?B?MG5BUEVMVzZKOWMxMzZkY2IyUGJXTjd3Q2JlbHQwemVtMEJ1SzE5ck85QVRj?=
 =?utf-8?B?aFFWVXFGbXRsY0ZiU2FLRVh0dmN2S1V4MUVtREZ5RzBiZ0dyaFMzWkR5MHVX?=
 =?utf-8?B?RThocFdQMkdEa0N6ZXdXSFlud0VDaXJHeXJZdDhZTDZ3amh1TCtPUStaaDZ4?=
 =?utf-8?B?YkxGMG90NWtiNnZXTGVBdDhPVHRPY01QNUtjNm1hMUl3bUU1czUrOVdPOURD?=
 =?utf-8?B?bXdtWTcrMzhHUzkya3ZGL3hWdWZIazROb0ZRcDZyNlF5MExFdVZxcjFjcmYx?=
 =?utf-8?B?RE1aY0pKckd1a1dXWXZWTDhoYnBXYWZYZ1lGazN4WmdFc2VhYmpFWEx5NThL?=
 =?utf-8?B?cEhjNWIyK002dG9YbEFrV2hEUHQvUjczNmxPUmhhV2Vkc2RZTjVLcUhDWkYx?=
 =?utf-8?B?SjhOMXczSDI3Y0F0L2FJbW1IK2VqNGlJYjREdllhRmFCYncxL003YlZaRk40?=
 =?utf-8?B?REltaFJsZ21hOXhxdWE0YXpEYmxaU3Bpd3lhbGd3OWdvTC95dmRFeUxyNG51?=
 =?utf-8?B?U3RCaDNONU94bXM5RFRVTnhNa2hYcngwYUE2MEw4Q3o5VHN1Ky93SnJaSTY2?=
 =?utf-8?B?NURJNmtNay9YckpvNEd4Vjl6Y1o5dzNJVVRUZTJVZ0xlZ1g3SUQ5MERyVzV3?=
 =?utf-8?B?d0JVazdDdmtCcGVrR1UyUkNZRGZqT2RkZ21lVnZSSHJuT3JMUkkxM1E0azh6?=
 =?utf-8?B?ak1YNTVhalJMWHZwWVdxeHRsanpFR0NMcCthQ2RLVnVlRCtvd0lPVFdlYXhY?=
 =?utf-8?B?OWdvZ1hXaFp0K0hvbTRuSEJXVHMxTmp0N0xIUlZDT1luODJhVFJYTVZQdkdh?=
 =?utf-8?B?VGNNVEJ5WFMwSFdreHdYYXBaN2RoL0NndlZSYmhudkhaM1B1c2x3YnZwcFBl?=
 =?utf-8?B?czZpRWIrdXJ0dk53ZHN2eVJxUDRLdkx3bW9Gb2hUOThtbjNSelBNT0M0OE5U?=
 =?utf-8?B?SVVOdTRUbk9xcForOVovZGNQcWg3b1Y5Q3hjeVYySU93eVFrL2xXN3JjeHJG?=
 =?utf-8?B?b0gvTmlGekNXYndpSUFXSzVDMkxrMTROOHhValNaanlZaEhXTzk1Z3ZUdlpp?=
 =?utf-8?B?cVVnaG9hUVFMczhSYnczcDQvNzh4dGRseVpMelNzTXEwSHVMNWUrR3MxVGEw?=
 =?utf-8?B?aldITmtIVVlyL1A5VmVGZThVR0Via0w1M0VCdllCSUo0WHl0UWVZeVRCV1lD?=
 =?utf-8?B?am0xTVpYcmFzYkZpek43eFdacTBJTUo0VS92eFczLys0OWJqWlh2VGdRUHNO?=
 =?utf-8?B?SGhvaXUyMVhNZmZHSmJ0U1Iza3BOeVZLY09RUGk2b0p6VndVdzRDZis1TzFK?=
 =?utf-8?B?TFBUeVR1dEJqQk1TYXF5SDlEVE56bE40RkU1aWVVS1NpVkp4WnRyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714f1b18-6c59-47ed-b2f2-08df021a395d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 19:59:36.7050 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yq16bTnCbwFIS9sxGA++NAaG3k7/3IbCtB6AYZsr7ObFFNrjMwfgljfhiKI/HQ3riTaN/V5WiFL20C8mFGz8aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6353
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



On 2026-08-14 12:43, Fangzhi Zuo wrote:
> why:
> HDMI 2.1 Auto Low-Latency Mode (ALLM) lets a Source request the Sink's
> low-latency mode through the HF-VSIF. HDMI 2.1 Section 7.6.6 requires
> that when Gaming-VRR is enabled (VRR_EN=1) and the Sink advertises ALLM
> in the SCDS, the Source shall transmit the HF-VSIF and set ALLM_Mode=1.
> amdgpu never set ALLM_Mode, so this requirement was not met.
> 
> how:
> - In update_freesync_state_on_stream(), set ALLM_Mode=1 in the HF-VSIF
>   when Gaming-VRR is active (vrr state ACTIVE_VARIABLE/ACTIVE_FIXED,
>   i.e. VRR_EN=1) and the sink advertises ALLM, per HDMI 2.1 Section
>   7.6.6, and push the updated HF-VSIF (vsp_infopacket) as a stream
>   update.
> 
> ALLM is driven only by the mandatory Gaming-VRR case.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +++-
>  .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 29 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 567bf04979ee..ff0db0cb9880 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4029,9 +4029,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
>  		}
>  
>  		if (acrtc_state->stream) {
> -			if (acrtc_state->freesync_vrr_info_changed)
> +			if (acrtc_state->freesync_vrr_info_changed) {
>  				bundle->stream_update.vrr_infopacket =
>  					&acrtc_state->stream->vrr_infopacket;
> +				bundle->stream_update.vsp_infopacket =
> +					&acrtc_state->stream->vsp_infopacket;
> +			}
>  		}
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> index 382c339b67b1..63d10cb7f5ed 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> @@ -252,6 +252,35 @@ void amdgpu_dm_update_freesync_state_on_stream(
>  	new_stream->vrr_infopacket = vrr_infopacket;
>  	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
>  
> +	/*
> +	 * HDMI ALLM: when Gaming-VRR is active (VRR_EN=1) and the sink
> +	 * advertises ALLM in the SCDS, the Source shall transmit the HF-VSIF
> +	 * with ALLM_Mode=1 (HDMI 2.1 Section 7.6.6).
> +	 */
> +	if (new_stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
> +	    new_stream->signal == SIGNAL_TYPE_HDMI_FRL) {
> +		struct dc_info_packet vsp_infopacket = {0};
> +		bool sink_allm = aconn && aconn->base.display_info.hdmi.allm;
> +		bool allm = sink_allm &&
> +			(vrr_params.state == VRR_STATE_ACTIVE_VARIABLE ||
> +			 vrr_params.state == VRR_STATE_ACTIVE_FIXED);
> +		bool allm_changed;
> +
> +		mod_build_hf_vsif_infopacket(new_stream, &vsp_infopacket, allm, allm);
> +
> +		allm_changed = memcmp(&new_stream->vsp_infopacket, &vsp_infopacket,
> +				      sizeof(vsp_infopacket)) != 0;
> +		new_crtc_state->freesync_vrr_info_changed |= allm_changed;
> +		new_stream->vsp_infopacket = vsp_infopacket;
> +
> +		if (allm_changed)
> +			drm_dbg_driver(adev_to_drm(adev),
> +				       "ALLM: flip on crtc=%u: sink_allm=%d vrr_state=%d -> ALLM_Mode=%d\n",
> +				    new_crtc_state->base.crtc->base.id,
> +				    sink_allm,
> +				    vrr_params.state, allm);
> +	}
> +
>  	if (new_crtc_state->freesync_vrr_info_changed)
>  		drm_dbg_kms(adev_to_drm(adev), "VRR packet update: crtc=%u enabled=%d state=%d",
>  			      new_crtc_state->base.crtc->base.id,

