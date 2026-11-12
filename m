Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1716606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xRFgB/0J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7BB210E692;
	Thu, 12 Nov 2026 20:32:01 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5F110E650;
 Thu, 12 Nov 2026 20:31:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ov7X7QigIX2OBlYtVM3fUkIB0n+kIWLxxkGHBtFS0E5X07eA6MKjCYgDTBLh+C7Po5wDaWKPZwvdOYZDDfLG8aNb6rLUvcgUdjVmOROhZIWgT0BTAY37ZtFRjHO2IzOkrNRl+Lrg4eL0noiy6CH7o2oyx8i+7vPYw8fFM+9NekfIniPiSukyAO0jMxOMOumYLKKDpQ9MOwW5Kvi/Pby/OrLGD7wW9314rOMRnrhKPpZJ5pq5m+56RCUh1GJLCEQPud5vbUEN+s/bOAJbmNQ89zKIB5qgvX5X6OaDq2dozat+o0ghASgw6kv0h2Dlzz7H3FPnKz4deNNzN0Ha4LLbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hugmw+zz17xAATfmlEg3iGqApO5X5JOS2k7qdjrMcE=;
 b=HorNjh66qFTCzVlU3Pk4lK6m2nq9x+9icJ+jt0haBIleLiFMuldoUeWGEQb7hemK7PwcOkMRrjO8126hmzmyJpXfVr32qn2EZ0x0gOWmryDRYtfaZlk8EH4LyNvVl8PgXi8yfNSTNmXpdGyPL03xSFNg35OR+MLRDSIVhsvDnr2xfbjS8m6Zpvmc0Un8bJS2HR7P1Ofu3Uy3o+Ptlt6VeHQkOPyf/XA3TLdAVYg2pSp5GyWRoHzK6Vlis5QMFYYgFGjXDfPIsxTfmX4kc9HoOSTZquSHUzp5BhJtxfB2f7wTi9Cu41RwSiEUj7kJr6CDfGC+Aiu8+c/Yh64KfEweXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hugmw+zz17xAATfmlEg3iGqApO5X5JOS2k7qdjrMcE=;
 b=xRFgB/0J/MSY4j1aWhVd7DabEe8QX4Zz5Cml0r9v6YlemfxgYWLWm1RCmeEkCfUOM0GsnjdAFDltzYDTsyqLhw9T8JDyW0JzzOAVHAWGFH3mW+LNpBSNtPhHuTNDgU/fhMogu9rkXj8RyuDJHHT+SvhHJ4EpkQ4RtWQ1dre3Eww=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18) by FT1PR12MB777854.namprd12.prod.outlook.com
 (2603:10b6:170:24::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 20:31:52 +0000
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a]) by IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 20:31:52 +0000
Message-ID: <9ba0ef86-2e60-406a-a390-f989e4ed2237@amd.com>
Date: Thu, 12 Nov 2026 15:31:50 -0500
User-Agent: Mozilla Thunderbird
From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 18/19] drm/amd/display: Replace dc_get_config with
 per-option config reads
To: airlied@redhat.com
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Austin Zheng <austin.zheng@amd.com>,
 Jun Lei <jun.lei@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20261112-amdgpu-dc-cleanup-v1-0-0fae41718ad2@redhat.com>
 <20261112-amdgpu-dc-cleanup-v1-18-0fae41718ad2@redhat.com>
Content-Language: en-US
In-Reply-To: <20261112-amdgpu-dc-cleanup-v1-18-0fae41718ad2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0323.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::29) To IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA6PR12MB893085:EE_|FT1PR12MB777854:EE_
X-MS-Office365-Filtering-Correlation-Id: c6bf6edd-deff-47ac-5919-08df40fbfc37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|6133799003|261009223027099003|11063799006|56012099006|10067099003|4143699003|261102123227099003|261102130727099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: xj5lAYAuwlcO31hR+4V6UCb8F/jbXVL4TznhJ4W5qjfPYQ5cPEqg5OeHmZ6AGi+cSlEyqzDQtD49hPomT6jGQCQGs+jrVnozzhUbrF5x4At6CBZvyiM8B7/J4RddY6sh63zSKsXFG//Ode80PTzdjgLIC9EtLyFoeyKS+ZYKWxMrrkqaVsENbY6CDE5TEVfdLrp1ndz183IGV2hWofZifJSxSVFC79xvigTrcv20jGRmPNJJk4Uv1XL3b/YCgLpRq9T0SFSqCVDIyyN4a0V5jGlJx98uuwajkT5jugEmqC5cp+nT+NpDU6A3SxNxC/RlTlnrHVD5BbdMZRTKA/TWPW39XoJyWC0hYLMPRZF7RW42NO5VUub8nkzK5+/QSXtQiXG8eHAi2qMphwQGll3vbV7GLUSCEt6lLmQavzTe81x0bUYm5IK5Rm4Uc9PMnhqtjv6CF6caRAZNCoIAOrQAJI3VmwjFTNT060AXxIyKpzTKWyVUPX+gXP/kCG8BrGiKxxTd12hi+FrbIlKGewDn0bEhu9JP5GdlSDkNWgB5eETiAMVF3OYfauS/vGhft4pjF+/6ZfLX7WqOk6JFQYjf8sn/cShk5iy2yoWIjHGmGS5popDvoNqosMSJy1T9vTdK1Vjp0LqbXuyYAsMKRpYKjc8C7xKPU/v4JEuMbDSshRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA6PR12MB893085.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003)(261102130727099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTVtNExWaTdyeTVwR3VEVlhHcmZuTGFhb1FjdWl5TlNadEVZazhPclluREh3?=
 =?utf-8?B?dGs4VlhaTW5STkdvd0Z6R1doUGdoWnozMEFmeXp3aEkrVDNhVDJkRWR6ZC90?=
 =?utf-8?B?SDJFamJzNjMvQTdMWTlBRmF1RlhndXlJR2szWHY2NEY0TWp5MGpVTUhDOHpw?=
 =?utf-8?B?YTk4RlNMRGhUK0VNMForZ282cmNxMmlkSjhiRDhkUWpKOUkzQWlvTGxhZkRs?=
 =?utf-8?B?MWtoQjU0MHBCNTJwaldyR2NDcWZJUzZrKzNIRjBqVVBvdGk2UDA0UW9iV0Ns?=
 =?utf-8?B?Mm52cG1qY25SM001L0puQUEwSFozTTBIUGtEVlRDZUJCenQyNUNubm5wZ3FZ?=
 =?utf-8?B?NEI0enk0TjNaTjZQU2Z6b3h1V0lvWTlEdUNFRGNsTTlvRjNOK2czOUhtM3B0?=
 =?utf-8?B?emk5aHdnVmVuc05udEhrcjBnSVlJeWtNUnhSQ1dPRXRoVTdSbUV3OGJ2c0tU?=
 =?utf-8?B?Zk0vOXo1bWdzak5yOHp1WE93NDJOT0RTMWE0VEVEQlhVbTB1RDdPQzY0VXN2?=
 =?utf-8?B?QjBlTHlockY3T2tEd1NNbTBNSENoVmlKYWxDODgreWtZSXRnaVhFN1d6K01x?=
 =?utf-8?B?SzVXZXpYMFI1K2dZZk9nM1lqRnpzVHk3WnNFSU9kZ1dVbi8xYkZBSlFQNDFk?=
 =?utf-8?B?U2cyVnZHL0RaUkxscjF4T1JuQ0tDYndWMlA3ODR5bHQzT0p3QnlOMS8zNXNr?=
 =?utf-8?B?MERrQkZqZGpMTXRIY2ZkQVc2ajNyRCtRM2c1bmgyTXJ3VFdjWkNEa1dnTGVz?=
 =?utf-8?B?NWczNGpDeFQwbzVRZythTFJVNHJzQ3h6a2pKelF3V29qaDM0dHZhc1hUVzNl?=
 =?utf-8?B?VUJqSFFWRlpWRWlyM2gwZzlDWVVKQ1lVR05FU3l5b1B2aVFmbENydGNCZDND?=
 =?utf-8?B?TnhMUVJCVmJDMjZZelM1NVVsTllzbFJXNjJHWTRHeVJSZnJVRmVLaVVtOW5P?=
 =?utf-8?B?RkpIRDhtSGY5a1ZjekZkUjBRWnUvc3ltdVpLQ3l3Nk9jZTNaTmdOempVR21H?=
 =?utf-8?B?MTV3VTZYZ1lDc3RDMHdpYXRHbFhoZGRickxmN2twakI1L2paZEVHUHRlNVFs?=
 =?utf-8?B?V2VTbEsyVWRvMk8zM2xqR2RvT1FYMHd6ZDBmdWkyRkxkUHBZQ0FkRldCOXEv?=
 =?utf-8?B?Ym9LV0JYM3JUd0htN09EeUV2a0RRMlF5WXdPektCK3ljbGxpTlZhNzlDQzRB?=
 =?utf-8?B?Mm02dVM2UExySTJJU3ZkQ2dLcEgwampMRWNodkhKZjF1SDVvUmVWd1V1MUtw?=
 =?utf-8?B?UHFKRnA5bUExajExOUpYZjNKR2dnSmhpdTRTT1YrSlNNaWw5ekpaR1NVY2pa?=
 =?utf-8?B?Q2ZGRjNYakJJMjBUcDBGK0p0WGRXeFNUdEU1d05iWEYrYkswNXZVbW0zTFRJ?=
 =?utf-8?B?TVZZVStPZ1pTYnBFQXBGY1N6ZTVwa2lJVEdjQnBoTmxGN2NMWnlDaUgwbHd6?=
 =?utf-8?B?NUp3aXdEc3gyMnNKNlhvbE1vZERXeVBPd205a3RlZTUvK0tDajZHbFZJMTVa?=
 =?utf-8?B?emN0ZmtoMEw2ZHdlc2hVeUord05hdE9UalJzUGtaRUx0SC9XSHlvVWNaU29O?=
 =?utf-8?B?UU13aThMeWtMOWlmNUE0K2szbzF5VjZlZ28rWG41Rk1NQ1JuVnVGdU1zaU9K?=
 =?utf-8?B?Z1hLQzZaOGR5cTh4ZVBBRnlqelpSS05KRU1pdm42OHhJYng2UmFsK2tkeE9R?=
 =?utf-8?B?S2szeXBjQndpM3NCUGZ0czZFMjNkV252M2ExTmJQYUMvYzhaQVJqNFE5ZlBS?=
 =?utf-8?B?WlpXc2hGVHFTOEJIRHNaTGxpcXpVenJkVEpEYXRJWTgxK0g1akIzZDJJM3Qx?=
 =?utf-8?B?NjVpVVVFQzhDZkRJMFpuUFJoUUdaTVJ2V1ppZS8vSmJCVm0rZkRpenFLT3Rm?=
 =?utf-8?B?cjF2bmNRdGJOMUhscS9aNXB5SkFRcVlYcUg2Zm9rOWpDNHZ1RWlJVzFUbnFQ?=
 =?utf-8?B?TXZwR1hSSURDVGQvYTRlREFSY1dWY0Y0YldkVmE0MUdWSE9HRkc5blE4QVB3?=
 =?utf-8?B?T2NxTERseC95RHN0U1VSSlVSOFB3bk1Hdi9vY0VLWVp5eFJXTERrcWZhTDJx?=
 =?utf-8?B?R2MzdnV2ajdpNWg5TnN2NEFNZFQ3L2JXTURaSEdFMnJHajlXUlV4MmRnVnN2?=
 =?utf-8?B?UlpWdXBnbk1aZ0ZHblJwT0VNanA1Q3hyUDJadlRBKy9DQnVaVFVUclhuMW1U?=
 =?utf-8?B?TTVUV0dDWmR1VnVRTUV4a1l1TDdpRG9qd1lZRmhJb20yMFJhaWRrM09LRWVU?=
 =?utf-8?B?dnZ4U1hUbW1ObzQ4TkFtS24ybHhrU3JFU0JWc09BWjROOE1QdmZWQ1NISG01?=
 =?utf-8?B?OXY1SXExcC9Na2dra0ErRy93ejNJcWx0Y3RtejZ1ZEZyUlVjaDlFQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bf6edd-deff-47ac-5919-08df40fbfc37
X-MS-Exchange-CrossTenant-AuthSource: IA6PR12MB893085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 20:31:52.4096 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0d68wLg/ax19OEvcOYrrWX6+uXB6QxfGHAh9eaX82qoaR4kWxi8I/RRfLxrY2GMSCr2bLnLIt5adFxZreZKyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB777854
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/11/26 20:43, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> The only external reads of struct dc_config were five runtime-mutable
> options. Give each a purpose-built getter (dc_get_disable_ips,
> dc_get_enable_frl, dc_get_consolidated_dpia_dp_lt,
> dc_get_usb4_bw_alloc_support, dc_get_allow_edp_hotplug_detection,
> complementing the existing setter) and drop the dc_get_config view.
> KUnit tests install the options through dc_test_set_* setters.
>
> No code outside the dc directory references struct dc_config in
> production anymore.
>
> Part of making the struct dc sub-structures opaque outside DC.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>
> ---

<snip>

> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_test.c b/drivers/gpu/drm/amd/display/dc/core/dc_test.c
> index 04c799ae33d3..6431afb2b5b1 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_test.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_test.c
> @@ -105,17 +105,36 @@ void dc_test_set_idle_optimizations_allowed(struct dc *dc, bool allowed)
>  }
>  EXPORT_SYMBOL(dc_test_set_idle_optimizations_allowed);
>  
> +void dc_test_set_disable_ips(struct dc *dc, unsigned int disable_ips)
> +{
> +	dc->config.disable_ips = disable_ips;
> +}
> +EXPORT_SYMBOL(dc_test_set_disable_ips);
> +
> +void dc_test_set_enable_frl(struct dc *dc, bool enable)
> +{
> +	dc->config.enable_frl = enable;
> +}
> +EXPORT_SYMBOL(dc_test_set_enable_frl);
> +
> +void dc_test_set_consolidated_dpia_dp_lt(struct dc *dc, bool enable)
> +{
> +	dc->config.consolidated_dpia_dp_lt = enable;
> +}
> +EXPORT_SYMBOL(dc_test_set_consolidated_dpia_dp_lt);
> +
> +void dc_test_set_usb4_bw_alloc_support(struct dc *dc, bool enable)
> +{
> +	dc->config.usb4_bw_alloc_support = enable;
> +}
> +EXPORT_SYMBOL(dc_test_set_usb4_bw_alloc_support);
> +

Similar to the comment on Patch 19/19, this creates a bit of API
bloat. Something like `dc_test_set_config(dc, config)` might be
better.

Harry
