Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF1EC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 21:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A971110E9AA;
	Mon, 10 Aug 2026 21:05:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mdVdCuk5";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB2F110E238;
 Mon, 10 Aug 2026 21:05:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWX8NA/BOe2ePljy1UN/2p4npYKs7ONWcu6ZMWO6zgilTD1JsL/mAQlCUMhDkTzO3z1xU0KTS9GI6ku3RLK0MOWfk+SqcUjrYMAFEiCbgHb8pazvysLa3M89NwRFEttYKLNxyhQ28um5mP/M3vVobq9knytTKGbIe2mPVfl/zMMihetcrNH8H17ECeWv7fyIXP4TYkpJLYPzy82m22/CnoDxrFXn8UREgLuXAH5Um8c3nXlee1jUYHdFTTKlzVJOT6b4iEyGxCgT0YJowSnDSMxOPI1uTZBKoYEMWoPViT/5brzgB6iY7QcuaZTd8Lvfa2rf1duMiit4b/0YNAn3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3AUuAo3E7Pm+46OcMj23bHU3KNnvk9rHfrRD00gAbQ=;
 b=mrHDCKpqhbEALpW37Kp5ny2gQcheHDUZhUtjEwyTb0S+riGp8nnHJq47uAqeesfbPAUkN1DPglM3XCgxTwUruL+h59M8yqt+2l61UNdEcZ4yiYCP2uH3XYbenWVzS5WnMRsdDH9Zk6OAD8C2ukdT1laI/wwgvJS4fFlQuy9JEMcbW3MBQydaNoAnf6OqhwwoHUG2Z28/fNsFemcrcbJRAXIWrnnLzBhxE8T5MPkI9tYedgYheGkn3+NPrqrDxoJD60/XrKtdnWCHesBY4uI4o3nFNVNBMeynJw7VCAylmWc0tlCJIfYDfcUZfAACKBHT+Bg11mTKpasyoip9+I9Wfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3AUuAo3E7Pm+46OcMj23bHU3KNnvk9rHfrRD00gAbQ=;
 b=mdVdCuk5I6PXryunIng8Av0U7NRsxTtbjtYiWU83UJMQ/wCDJtt0i296qoZEgJOt4PqZ7MOFV8RPnit1YdOgFAFaaDgAvbL81iriyHKqBONEeXsSOOKLuP5Dyhwc3T/CRSANNOK+k+/U5FmsBLAHLP4RORM8AKXXHU/p6hrhYxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 21:04:56 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 21:04:56 +0000
Message-ID: <36651a7c-0301-46db-a07d-d48da10b8512@amd.com>
Date: Mon, 10 Aug 2026 17:04:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] drm/amd/display: Add HDMI ALLM support
To: Fangzhi Zuo <jerry.zuo@amd.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20260730171754.704049-1-jerry.zuo@amd.com>
 <20260806205449.16806-1-jerry.zuo@amd.com>
 <20260806205449.16806-5-jerry.zuo@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260806205449.16806-5-jerry.zuo@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0207.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ad::11) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4f15f7-0290-47fa-f66a-08def72307b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|18092099006|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: cPNTsTd8Cb6Ew2vRHZ6N9w8SJ0GUmUg0SY7AnahyafLaAo95CUGsbTh24ooXVHnd1PTGOpLGOx9cS4Z3V4RAdGaiAV+WszjHd0WYtXCORpqN+cfNYL5VmtV8mbRfNt5qAWzJmIyVjMz3dFMcvJZYBWMwGvrr7DqeIV3y2wG6zf7p7p8M86ZgMoslHQVEyUkXoReZoabvYxkNiekVOZ/r/CEmRCz79eZrxZA3xj61ohLrrc+WxB60W0KI2MnPvz2rxNzLpotB4j4IUrBzyYlrNySurVf9Ak/dN6C1OuwEsJ8YoMMw9FbnfW+0cYMoRrsbBPvk0aRxyvdb1jQix8hgn606/wJl4gko4vMnPitO2GqSVraeK/UmZ5TVGcBQu5SsU9I9UOaG0PGLw/scNscxHnSosbIVFTw+k9fIFy78k1h9CEc1xHQ0f4t44bRC1T1UNJa0cd1DfbwuncZXhLIqdP8ORdy8+LXLo0lYhQxMl+exZtcOSeD+BMomvV94W+bVHBvaJoOK8nTxXl7sSE6SdOKs3dcqUVTqXxYFc/cBdOYAqy3HSlImLoM2Hve2l9lt7DnWxhqvl+qurk37fl9fgCVX3+w45IFwMB1zXlsFBnEkEn/GkRv2uf3yRTJZ3GXpr24QRZXwAUZ34PLAUjo0lunNofNCZ6mJkWvCTVvsN6U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(18092099006)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzJHK2xBUThHemkvdmZ0RXQvdmVURFFJbysrcllPRi9vZHhWbitINGorZTMw?=
 =?utf-8?B?enQvUk92bWZTazd5Ry95VlJuaXhpTnNEdkswSzFJWTBVNThNb2ZEZ2Y3RFpQ?=
 =?utf-8?B?bEY5WWdMRFNaYTY3SUxubmZhYWh3RkgwQUl5dVFXN2xUZEI2eXJJbzRnNVlx?=
 =?utf-8?B?TkVzZ2FSNmZOYVZhay9WNjVMeVc5V3NCazVKaXBuVU1LbWt4QUp1WjRkdFkv?=
 =?utf-8?B?cmxlWkdWQXN2N1MvdTRMYWo0RTZ6Q1g1czduRG9mejg1aXlWTDBDUzJFTGg1?=
 =?utf-8?B?MnRYT0JWZFo3eDc0TlJNVzIyQ2FCcmhWaDB4WVhnTXFuOHVHbnJRSTI1a0ht?=
 =?utf-8?B?YUJEQ2ZkTXkxRzhIaVZRN3puSEhZeVJWZXcwaXUxM0VhTERpU01mU21lWHYw?=
 =?utf-8?B?bGR2Tm10UDRSMUJuUXZ1aDFuWDhKY2F6eWRxUG4wT2lmL3A0TG9JNGJTTDlp?=
 =?utf-8?B?MzJObDRXNDZyOEpwNFc4a1AvS01pZnhMVzNlNGM4QUVwMTlqcXgxaDhkN3A1?=
 =?utf-8?B?TUVsOGlOSklsUXBKZGQwS2loTGtiYXdiZDhmM2Y4V1UxTE9vU0VjaHZ0UFJZ?=
 =?utf-8?B?NXlzVEl1cDBkSVJzOUdSYWRFMDU2VmZQVHZOcWZiWGNiMGQ4bEFCbHc0dE5X?=
 =?utf-8?B?WjZST1RjV24yaC9BZDNqdjBvRm5JbnQ1bjZaS3VPM0VnY0p2cmhaNVFMSzZZ?=
 =?utf-8?B?ZWNnamxDYkRYUjE1OHpUQ0wydjg0RWtmQkJLam5HT0VRVUYrZGZxVjNkZkh2?=
 =?utf-8?B?dFJhb2FxNDIyYTdKOUo5SXByZTF1S3V1ZFNEL1VwNUFwL3VSRm5jdVlFeFZw?=
 =?utf-8?B?MWtXYVZuZUpJeXE1VlFuR3hLd0M4NzBWR2NMcXArMVNPWllTRzQwOUVmNVV4?=
 =?utf-8?B?dDhkdVFiN1lSYlNzSFozZ1VCdWg2V0EyOHNyNldiKys4M1ZIVnczdjdtWjZP?=
 =?utf-8?B?bkdrcWszbFdOOS9yTlV4VTJlamRYdVpIU1hZYTdmUS9DVjdFMnp1UWJQYS9u?=
 =?utf-8?B?amNab09Dc3ZUbGQrcGUyTXdCWFpBVWkvVXZxQmg0QjRiS01zK3puKzFyQ3Ir?=
 =?utf-8?B?REV5U2ZaUnBLMldCNUZybUhwRFcvVVFoNXBJcXprMWxtTkdPZDN3ZEdBa292?=
 =?utf-8?B?bTdTZStWQUVXR2xMUmNDTTRYOWdhTjVldC83WHovNG1maklwT0h4eEdwWTI1?=
 =?utf-8?B?YlhrcVFRTGZtZld5M0pnamRSamdTYWRvUERKb3JlMzBPODlxdVVVR0h4RU1Y?=
 =?utf-8?B?Q3hNVFhnelRPTGRQSmxlV0ttUEtGUjRhdEdhVFdabkF5cUUvWGdBSkVDMCsy?=
 =?utf-8?B?L1RVVXBMV0RjNzdYczhublNPT3E2UW5RclEzeUlSQXBpSFMyQWNST0g5SkV3?=
 =?utf-8?B?ZHlmZ3FnY25sb1BvVjU4REZjRU1yUzM2dmhxbzFzUmIxK3dTcFQyVFZyWEQ1?=
 =?utf-8?B?am9TRG5veTk4dUtoQnRVU3lPdkRpeEV4aHgxUGI4akZKbFBaVG5ML0ZCMTNl?=
 =?utf-8?B?T0N4QVc1UmJEYm5PalpBZHlLMDBHbEdNdjNjWWNsOTJZc0lIdW02SkxXOGM2?=
 =?utf-8?B?M3pvbTQ4LzhoVy9pcUViRS83K3E2UmIwZlh0YSs4MlcvcE9Ub3pxcy9OdlB5?=
 =?utf-8?B?ZXczKzRLVFBaR0Q3R3RUaDZMYVpmSk50NmpjdFRkQTdlL1JyZ3EyRVQ4TWla?=
 =?utf-8?B?eDkra3RLUUNqZkJuRzBaOWEwWGV5NzFQUVNQZFhseFJVaWZVcVdDbTdBTW91?=
 =?utf-8?B?aEtUTlBhZ2JHQ3hFazBsY21nMTJub01wRXU5NkZKN0wxQWM4L0Zka1NtWGQ3?=
 =?utf-8?B?VGpDY0FXVXcrQlV6N2RURHNoNUtnNDhsN1VpTzF1SkNrQlpjN24xRzM2T1M0?=
 =?utf-8?B?UE8rM0xGeTRmSmpYTWdkTnBBZmFVbFAyUmVjVVA2OEFjblZGTzlGejk2TDQv?=
 =?utf-8?B?UXBpN3F2NFFoL1V5czJOOTJVNElBb1VLOGdrckJFdTRlR1VieFRDejg1UHM1?=
 =?utf-8?B?R3lnbWJqcUh1REh2eklrNHl3dFFYN3dHR2FqYnl4SDVFQXUrbm5SVTc4VlpG?=
 =?utf-8?B?QVZ1TVd4d1JwM1VxQXFYajE0VjNSb1NaZ0E2dk8yRGJ5Smk4UnFTd2lVTXhV?=
 =?utf-8?B?ZllIZUprc0RDR0MzVWVYUENlbE8vSndBdUJCb0UxdmgrZFNMZ3ZSWThaTy9K?=
 =?utf-8?B?Z0gvRExxa1U2RWI5c1JyOFA0bzMvQnpadFkyOVJaR1lWYXA5Z1NETi9NdHFx?=
 =?utf-8?B?QzRsR3RkUTlGdzFyRTFEUm1WeHlEbTJoWjhEcDVkUkc4V0NMWDNQMzkvYS8y?=
 =?utf-8?B?VnNjUnJFTC9Ha1BTcWcxSk9Jd2dwNjdHTXVaWDJhdEVpNWV6anFGdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4f15f7-0290-47fa-f66a-08def72307b8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 21:04:56.1725 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9dep8mxAFhkdsg7S99BXEnZyb0tS/WVoJBki2dixyYy9A2JNhRLshQR4l/XNNUELdn0UOjZxWp6mop+DPkd7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
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

On 2026-08-06 16:54, Fangzhi Zuo wrote:
> why:
> HDMI 2.1 Auto Low-Latency Mode (ALLM) lets a Source request the Sink's
> low-latency mode through the HF-VSIF. amdgpu never set ALLM_Mode in the
> HF-VSIF, so ALLM was never signalled to the sink.
> 
> how:
> - In create_stream_for_sink(), build the HF-VSIF with ALLM_Mode set when
>   the sink advertises ALLM (connector->display_info.hdmi.allm, parsed by
>   DRM core from the HF-VSDB) and the content type is Game (content-type =
>   Game is how userspace requests low-latency mode, HDMI GCTS HF1-56).
> - In update_freesync_state_on_stream(), also set ALLM_Mode when
>   Gaming-VRR is active (VRR_EN=1, HDMI GCTS HF1-58 step 8.3.1), and push
>   the updated HF-VSIF (vsp_infopacket) as a stream update.
> 
> Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 ++-
>  .../display/amdgpu_dm/amdgpu_dm_connector.c   | 18 +++++++++--
>  .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 31 +++++++++++++++++++
>  3 files changed, 51 insertions(+), 3 deletions(-)
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
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index df39bc70ec6c..6cfd7526ab56 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1572,8 +1572,22 @@ create_stream_for_sink(struct drm_connector *connector,
>  	update_stream_signal(stream, sink);
>  
>  	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
> -	    stream->signal == SIGNAL_TYPE_HDMI_FRL)
> -		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, false, false);
> +	    stream->signal == SIGNAL_TYPE_HDMI_FRL) {
> +		/*
> +		 * Enable HDMI ALLM (Auto Low-Latency Mode) when the sink
> +		 * advertises ALLM in the SCDS and the content type is Game.
> +		 * Setting content-type = Game is how userspace requests the
> +		 * Sink's low-latency mode (HDMI GCTS HF1-56).
> +		 */
> +		bool allm = connector->display_info.hdmi.allm &&
> +			stream->content_type == DISPLAY_CONTENT_TYPE_GAME;
> +
> +		drm_dbg_driver(dev,
> +			       "ALLM: set mode: sink_allm=%d content_type=%d -> ALLM_Mode=%d\n",
> +			    connector->display_info.hdmi.allm, stream->content_type, allm);
> +
> +		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, allm, allm);
> +	}
>  
>  	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
>  	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> index cb49184813de..c4bc6e717df9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
> @@ -252,6 +252,37 @@ void amdgpu_dm_update_freesync_state_on_stream(
>  	new_stream->vrr_infopacket = vrr_infopacket;
>  	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
>  
> +	/*
> +	 * HDMI ALLM: transmit the HF-VSIF with ALLM_Mode=1 when the sink
> +	 * advertises ALLM in the SCDS and either the content type is Game
> +	 * (HF1-56) or Gaming-VRR is active (VRR_EN=1, HF1-58 step 8.3.1).
> +	 * HDMI 2.1 7.6.6.
> +	 */
> +	if (new_stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
> +	    new_stream->signal == SIGNAL_TYPE_HDMI_FRL) {
> +		struct dc_info_packet vsp_infopacket = {0};
> +		bool sink_allm = aconn && aconn->base.display_info.hdmi.allm;
> +		bool allm = sink_allm &&
> +			(new_stream->content_type == DISPLAY_CONTENT_TYPE_GAME ||
> +			 vrr_params.state == VRR_STATE_ACTIVE_VARIABLE ||
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
> +				       "ALLM: flip on crtc=%u: sink_allm=%d content_type=%d vrr_state=%d -> ALLM_Mode=%d\n",
> +				    new_crtc_state->base.crtc->base.id,
> +				    sink_allm,
> +				    new_stream->content_type, vrr_params.state, allm);
> +	}
> +
>  	if (new_crtc_state->freesync_vrr_info_changed)
>  		drm_dbg_kms(adev_to_drm(adev), "VRR packet update: crtc=%u enabled=%d state=%d",
>  			      new_crtc_state->base.crtc->base.id,

