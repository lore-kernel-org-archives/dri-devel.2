Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D61CDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:49:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A8A10E057;
	Wed, 24 Jun 2026 15:49:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AQdPA761";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 849C810E057;
 Wed, 24 Jun 2026 15:49:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XT2eInkHI6mhNc9mp9MOeQxaP7xV9gAEcegW1NX8mFrj6uRA8qQRJF86SzfKD9/UmeQlOlqmmBCprRhzZBj2OpcnGFOf9WmvLEaRf8uvblEfbXDHevpl0K1OG3humoCsHJl1eY1fpLCGKVd8SAECQOX2dp5zx6D1mx7RzGJI156553wLBYcYFxhnIo6mXPy3C8M/SG9jV3meN9WpaTa1Ut8YUfCbAFpDbpN/zu39vQlrQKUV5TUUjWNyc8HlEAIelPtAccDUUV+b7csOkvNH/nP0EUUrdcnqMg/ybskjkyLka8FiuQvZ6Y9RxHfdiWv9USfUkyGng20WUSNLy69atw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/THE7RgYB3SboMmxIubAWeJZM05BctJxfnam3l1zk6k=;
 b=DOVxk2mEOsJ/o1NWow+d9pMC4/nwRLnXanxWymJOF22tp2quq6ZVRvCgTg3ZBi5LkE2N8UBL507neibqsuyAhlTmNkucTVd+0TnLju001+LFvxkVx69a3slG9Sng0D4ZsS05zv+OuGl3t4J9raDCUTJxhHkTe8bjgkLUTmDD2qpM5CGOFmWJU+vQ4Tit1IM8uUr3AUXUkWseiBKPTtTkpwCxzdwLjUbN2VyChRcJyh68Ll4I4HWolwi+OsAdpx8cLN0qA2Bvj8/pt90U/1gNcSWDoowOBffsBrxJMvF5UUtXmWgoa5tF60kshtSn3fXdfx6vFUIU/nMbFpD4djxffQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/THE7RgYB3SboMmxIubAWeJZM05BctJxfnam3l1zk6k=;
 b=AQdPA761tiy/uMg7Ob/17B3enlM1nZ+6m5kcEysRorGlz1yGPJ6XWibYpext6032pcxLFKQQfwx78BFPeYN1sHtArSD6GJ/d1DAMDJLcy7jcEl2o9IXWq/mSGM+cexnNSJUe2UXwoLncysi2W1x76Eg7BnCN4hNe9PZeGxxm/uU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Wed, 24 Jun
 2026 15:49:49 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 15:49:49 +0000
Message-ID: <8234f6dc-d66d-4863-b66c-f32f9b0d8abb@amd.com>
Date: Wed, 24 Jun 2026 11:49:43 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/connector: Introduce "min bpc" connector property
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Xaver Hugl <xaver.hugl@kde.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, Mario Kleiner <mario.kleiner.de@gmail.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Daniel Stone <daniel@fooishbar.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, wayland-devel@lists.freedesktop.org
References: <20260612-min-bpc-v1-0-bba88c2c4836@collabora.com>
 <20260612-min-bpc-v1-1-bba88c2c4836@collabora.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260612-min-bpc-v1-1-bba88c2c4836@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::15) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 690a4c9a-c83f-45f3-f379-08ded20838eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|23010399003|1800799024|22082099003|18002099003|921020|6133799003|4143699003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: Ydtflvn+cP73fuj4gvBk/NkqiiVN2X8q88ZHr/xGoc171/BWmemcqnz/2BjIjS0JKzGyD6wLRt2bSRYgs+HLtJKiDKcDrErVyUsqcskNCNh/Pp5WKGDEmM05w5iA6jz3XrlEgzN3e7NQh7UCreE1BCrWIPqv0Dp7b7gnF4cU55AXPv0j5bm52WLPkuOHHaLBfq+mt/gu+aXIkRCB/eNK5xg8MCQaX/C1Plbpk+/Cg8uSNeiVI0lNbaFCiVFT0zdzeRrSocVxYxzSM2ZgUm6Ww/LpYHDwp+qy38MUG4jZeMIvJR+8Bz0wtxEzmddDE0tc2Qv2ZRQ7M+VAu65OL5Fdn+Q5sW6Wr14Gjzaf0isubX0INktwPa+tfxfdvAvlYQKI/XqXSLqSddEP6arX0VK4DOPkduxs4k1MvWUCtC7s/x35VvzdTu8a/HMUi7Z06/AVOXb6xMNixipUVZgnrkyVgnQad7c4K6lb+qYpYD/mg6NvsCJr6ERCc5kwzU6KCmx0jWXGpkh2fUu/6ZjDNyK75RZLLjnWxxhXyf3i+Urj61OGj83dMRuiv64ZFa+rmSXsw5wNJhYshKgca0vRHm6UFNhGaItYNzL6WqMpoHclvFH65LLX6z1A4d41uycgNbX6K/t25H5Thx0eZ0M1xG7KLaZjQTDigXhQ0IJc5nOvwKQOlzJP698FAvy+GbmYrfX67CHqSjyyve9Yl4XOdvDsCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(921020)(6133799003)(4143699003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzhjOU9yQ0lZY2d3RlUrZTBaK0czc1RUdnN2N1JtZkJSVTNGM1h6M2ZHZ1Z5?=
 =?utf-8?B?SUMzd1k3dzV4MEJ4Nlp3d0puUFNtOEJESVRiMkZoanROdnBGUy9mR3V5Skwr?=
 =?utf-8?B?aXhLKzMxTUxwNjNHbVhjR2VHQVR2M0VFejJxWTQ3a2w4UWd2S0liVkdTV25F?=
 =?utf-8?B?dTR3WS8xYXpjb1Qyci9TVUNMZW1PVDZUZ01qZ3JSbVJGbWN1ZkZpejJjTzhH?=
 =?utf-8?B?Tnp6Rm0zaUo2dkpGa3ljMndwaStDaU80Q3FMcG9oVEpPdEhxcFRiQXZhRmVj?=
 =?utf-8?B?M21ESzVvc2ZrTHJUTUhOcUJtaldVYitLOGRMSjl2d1FOKzNzQmRkOGN0VSt3?=
 =?utf-8?B?S1I4MFJSakdEdm1TblZOLytXSzh1YWs5UnJwWStNT3ljZ2w0WHRIQmRFL1kx?=
 =?utf-8?B?NDNqQmh4UkROTlE4a1oza2txeWc0elJ2ODZtMitpTzVBSW45a2VGT3BjY21R?=
 =?utf-8?B?Sm9BYlRYY1Via3Q2Y1lnR3BWQWo1ZXJRYklLeldMNko0YnF0VnpqYmYzRjVM?=
 =?utf-8?B?UDZSVXFZS0cvOUpwU3p1b1UyWVVDQWhHeEJlbENaNGFQSUpOVFdkU2E0OHh5?=
 =?utf-8?B?K3ljNDBERmJCWGlJVUJFT2hoUjBxZUNuTUVLdUlrSmdkR2J6NUpjZG5UOU5Q?=
 =?utf-8?B?SFR2akwxOVNieUZ3Und2RGk2TkRUcTlqZzF6ZmMxNXRWbUVYekk4RVBUbEtp?=
 =?utf-8?B?M0lhT3RUbThWQVpTQkZGcnZDRDQ3eTFhRE9Yb0ZiendCa0UwK2hNRHZubU5x?=
 =?utf-8?B?b29HcjloWlc1OGowTE9iY3pxUW5yNlJnRC9aMkt5Y0YzY1Q2cUwyTHAyZGE3?=
 =?utf-8?B?WUpHWGV5T0FDR05laUdjY2lRN2U0c3cyaVBCNnVHWVlFWWVpQldOaytYYkF6?=
 =?utf-8?B?S0pOaVBHSkZUY2hyN2hhUzNZUFRWK2N6c2dGZzZuMi81L2dUblZEeXdzZWEx?=
 =?utf-8?B?WWMrbllvZzIxSGtnYVVkK2R4QXNzQVRGMzM5QmNUaWNWaWdBMjFIdWxFajVm?=
 =?utf-8?B?YWtjY3MyQ3dISDVSVWpSVFY1WVlKOXppRitWZm9nUEhpYlQzSk9MSE9aVWtF?=
 =?utf-8?B?eFpMcTFPN3BDYjJQdm9zR1FrOGJrODNIb3A5bWRPNVcxWTZQY3FWVVQ2RzN1?=
 =?utf-8?B?L1BDaE5lN3BOaVVzdGVXeThjTC8vOENTMys2L0F6emFHdCs2aDZrWUZtZCty?=
 =?utf-8?B?NzRKcDZMMnBzTHNXNVIrOWRKMXByTEJITVpPWHBTdEFRdGhpZktvVGxFV21v?=
 =?utf-8?B?dHVKU1pVUHRoTVdjUXFjeE8wYWxOY3cvT2YvaStwRTFhOS9XV0JsTzB0N0hs?=
 =?utf-8?B?L0FZaG12Y0pidU01VHV1ZGo5bEdkeGhEb1lma2k2dVFzZVJZYW4wUjdWT1pu?=
 =?utf-8?B?eXY4QmhFUVFrZ1FDcVRhZFhDTVl2MzN3YVVhR2l1cGVwVDF4SGxOUnQ2dmNG?=
 =?utf-8?B?Y25JS1FhcFpLUmdjdnRaTUEwSElTYkRHODFmUzdpMXpOdHI4c3R2MElFc2hy?=
 =?utf-8?B?aVBzeU1iVW5sNnpIeE1CMVBnRDZVRjJKck14RTVZdFo5VWlMZFFYQmgvaU1n?=
 =?utf-8?B?RjFTb0FjTEJpcTZvMVJsWnBxWHBxRW5waEozNzhrTjBqMHB2eDRya0M4b0pW?=
 =?utf-8?B?OEt6OHpaTjJGbGZEMFIwazRPZWg2U0x4THNFSmxydldPdkFSbWR6VUQ3T25I?=
 =?utf-8?B?dCtuZ0o5a0pjSHJ4Q2xvakJYL3VvWXM5S2VOMDBiQnlWejRoclRPVjQxN01L?=
 =?utf-8?B?Z053MHM1UW1IenBlRUNrZkw1TU9BS0JwQ0pkZ1NPdUxIbGtkanN4aDlPY09s?=
 =?utf-8?B?U3JHK28rQUg0YTlLQldLMFROUG1pczV6SjRVeit1VWR3NzFvdjFDUEs5WGxH?=
 =?utf-8?B?czd3UzJiUVF1bC9CVTkxbVZZdStlSmdJZjlsVFptQlB3aEZFb25BMW1EY0xG?=
 =?utf-8?B?N0tTU1NvV3F6WmUreFIvNVhmMVBvWEV3TjlJcFFQTXJ3NEZ4UWtPZ3VQOGtK?=
 =?utf-8?B?OUZpcnRWaXoyMmx4TGdWMDRGTGh5YWg5R3BJaFNINjlMUWI4ZzA0amZnZWhj?=
 =?utf-8?B?QmN4U2I2TW1IeHcwampIay9ITHdPdWhVUGd1SGUwZ0tHNnhLb1RmalduNDg4?=
 =?utf-8?B?VWJZaUtrU2lPeHlka0VxUzBCbDk3Yk1IaXp5QmZZQ3BOWlhpVlFjQ291ZHB4?=
 =?utf-8?B?UDFpS2RnTDlDaUFVZ2FldEVleFFhSXBCTVMrRmN6amNBeDhQTXhzSnczemxh?=
 =?utf-8?B?SnFyL0VTb1dFbThDeGNodjE0NTFOd1FVUEJEVXRYQXpES3pnM09ZMVhUcUlB?=
 =?utf-8?B?RzhIaHFTR3Z2SGlsUnU4OXNianQzdW1XR3pTdzA2cmdlSjdMaUh5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690a4c9a-c83f-45f3-f379-08ded20838eb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 15:49:49.3088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaI31+C+0ttJukwRvEDubpV23jDM20e3eG/1xSMgBfP0tDlwJKwyZRMF8n9HfAvF280j+C9/yYpXfbqoAJO8Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
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

On 2026-06-12 11:34, Nicolas Frattaroli wrote:
> Add a new KMS connector property called "min bpc". Its purpose is to
> allow userspace to mandate that the output bit depth ends up greater
> than or equal to a specified depth, or else have the commit fail. This
> is useful for checking for output depth degradation in combination with
> atomic test commits.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Despite your statement in the cover letter, this does still need a
userspace implementation before merging, as well as an IGT test.

But I like this definition and your documentation and think we have
something quite workable, even long-term.

Harry

> ---
>  drivers/gpu/drm/drm_atomic_helper.c |  4 ++
>  drivers/gpu/drm/drm_atomic_uapi.c   |  4 ++
>  drivers/gpu/drm/drm_connector.c     | 77 +++++++++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h         | 13 +++++++
>  4 files changed, 98 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 285aac3554df..613a674ace87 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -739,6 +739,10 @@ drm_atomic_helper_check_modeset(struct drm_device *dev,
>  			    new_connector_state->max_requested_bpc)
>  				new_crtc_state->connectors_changed = true;
>  
> +			if (old_connector_state->min_requested_bpc !=
> +			    new_connector_state->min_requested_bpc)
> +				new_crtc_state->connectors_changed = true;
> +
>  			if (old_connector_state->color_format !=
>  			    new_connector_state->color_format)
>  				new_crtc_state->connectors_changed = true;
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> index 1050dddadb17..0440cb63f786 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -956,6 +956,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
>  						   fence_ptr);
>  	} else if (property == connector->max_bpc_property) {
>  		state->max_requested_bpc = val;
> +	} else if (property == connector->min_bpc_property) {
> +		state->min_requested_bpc = val;
>  	} else if (property == connector->privacy_screen_sw_state_property) {
>  		state->privacy_screen_sw_state = val;
>  	} else if (property == connector->broadcast_rgb_property) {
> @@ -1043,6 +1045,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
>  		*val = 0;
>  	} else if (property == connector->max_bpc_property) {
>  		*val = state->max_requested_bpc;
> +	} else if (property == connector->min_bpc_property) {
> +		*val = state->min_requested_bpc;
>  	} else if (property == connector->privacy_screen_sw_state_property) {
>  		*val = state->privacy_screen_sw_state;
>  	} else if (property == connector->broadcast_rgb_property) {
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index cbb067d02cb9..dcf53cc113b0 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1738,6 +1738,46 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
>   *	drm_connector_attach_max_bpc_property() to create and attach the
>   *	property to the connector during initialization.
>   *
> + * min bpc:
> + *	This range property is used by userspace to set a minimum bit depth that
> + *	the driver must reach on the connector for a given atomic state. If it
> + *	cannot do so, the atomic commit fails.
> + *
> + *	The precise definition of minimum bit depth used for the "min bpc"
> + *	property must align with the definition a given driver uses for the
> + *	"max bpc" property, such that when "min bpc" and "max bpc" are set to
> + *	the same value, the allowable range of bit depths is a single set point.
> + *
> + *	Drivers should ideally use a definition of bit depth that refers to a
> + *	perceptual optical bit depth, meaning it is equivalent to an
> + *	uncompressed optical bit depth for a variety of content to the median
> + *	human eyeball in a variety of viewing environments. The display link's
> + *	actual optical bit depth to represent the data on the wire may be lower
> + *	due to compression techniques, or even higher due to padding. In
> + *	concrete terms, userspace should not need to know how to implement DSC
> + *	compression in order to set a minimum bit depth to the appropriate
> + *	value, and should not need to perform display-protocol-specific
> + *	calculations to set the right on-the-wire format.
> + *
> + *	Userspace may use the "min bpc" property in combination with performing
> + *	atomic test commits in order to enumerate the possible output bit depths
> + *	for a given configuration. This way, userspace compositors can make
> + *	use-case and content-specific tradeoffs to reach a desired output bit
> + *	depth, such as by using chroma subsampling, or by choosing a lower
> + *	refresh rate mode.
> + *
> + *	Userspace may use the "min bpc" property in combination with the
> + *	"max bpc" property to know what output bit depth a successful atomic
> + *	commit is using. By setting "min bpc" and "max bpc" to the same value,
> + *	a successful commit will be using an output bit depth of said value.
> + *
> + *	When "min bpc" is set to a non-zero value, any bit depth degradation
> + *	logic below "min bpc" must be implemented by userspace (through lowering
> + *	"min bpc"), rather than by kernel drivers. For a driver to degrade to an
> + *	uncompressed optical output bit depth below "min bpc" is always a bug no
> + *	matter how good the intentions are, since it renders the property
> + *	useless as an oracle.
> + *
>   * Connectors also have one standardized atomic property:
>   *
>   * CRTC_ID:
> @@ -2892,6 +2932,43 @@ int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
>  
> +/**
> + * drm_connector_attach_min_bpc_property - attach "min bpc" property
> + * @connector: connector to attach min bpc property on.
> + * @max: The maximum bit depth supported by the connector.
> + *
> + * Create and attach the "min bpc" connector property, which is used by
> + * userspace to require that a certain minimum bit depth is reached by the
> + * connector on atomic commit.
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */
> +int drm_connector_attach_min_bpc_property(struct drm_connector *connector,
> +					  unsigned int max)
> +{
> +	struct drm_device *dev = connector->dev;
> +	struct drm_property *prop;
> +
> +	if (max > U8_MAX)
> +		return -ERANGE;
> +
> +	prop = connector->min_bpc_property;
> +	if (!prop) {
> +		prop = drm_property_create_range(dev, 0, "min bpc", 0, max);
> +		if (!prop)
> +			return -ENOMEM;
> +
> +		connector->min_bpc_property = prop;
> +	}
> +
> +	drm_object_attach_property(&connector->base, prop, 0);
> +	connector->state->min_requested_bpc = 0;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_connector_attach_min_bpc_property);
> +
>  /**
>   * drm_connector_attach_hdr_output_metadata_property - attach "HDR_OUTPUT_METADATA" property
>   * @connector: connector to attach the property on.
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index 4317166562cf..63d6ac85b3ec 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -1261,6 +1261,11 @@ struct drm_connector_state {
>  	 */
>  	u8 max_requested_bpc;
>  
> +	/**
> +	 * @min_requested_bpc: Minimum output bit depth requested by userspace
> +	 */
> +	u8 min_requested_bpc;
> +
>  	/**
>  	 * @max_bpc: Connector max_bpc based on the requested max_bpc property
>  	 * and the connector bpc limitations obtained from edid.
> @@ -2291,6 +2296,12 @@ struct drm_connector {
>  	 */
>  	struct drm_property *max_bpc_property;
>  
> +	/**
> +	 * @min_bpc_property: Default connector property for the minimum bit
> +	 * depth for the output to reach, or the commit to fail otherwise.
> +	 */
> +	struct drm_property *min_bpc_property;
> +
>  	/** @privacy_screen: drm_privacy_screen for this connector, or NULL. */
>  	struct drm_privacy_screen *privacy_screen;
>  
> @@ -2697,6 +2708,8 @@ int drm_connector_set_orientation_from_panel(
>  	struct drm_panel *panel);
>  int drm_connector_attach_max_bpc_property(struct drm_connector *connector,
>  					  int min, int max);
> +int drm_connector_attach_min_bpc_property(struct drm_connector *connector,
> +					  unsigned int max);
>  void drm_connector_create_privacy_screen_properties(struct drm_connector *conn);
>  void drm_connector_attach_privacy_screen_properties(struct drm_connector *conn);
>  void drm_connector_attach_privacy_screen_provider(
> 

