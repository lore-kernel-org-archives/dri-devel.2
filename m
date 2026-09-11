Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B6BC88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:49:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDE310F6BD;
	Fri, 11 Sep 2026 18:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ob8US9L6";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013050.outbound.protection.outlook.com
 [40.93.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE70610E3FE;
 Fri, 11 Sep 2026 18:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MRJyXr4BfJnZ7qeX8a4o4nXeLK+AYcX4WghyZxmf/SjzlcADjO0txbcVHFRqHe1zMoW/dOBmthUDDTz9vXeLoptFlgPvUHCXl1IRBX1aXPYn6ePidNrymyEpFWHztar9WVs8/ObBXvdEWjUcXPddCRlnRx0lHs2Mg2g/Juj7A+GW6PS5un2SPBsTMs9qNl2uNS8FeBOtC6izwI7QBY2R8bWO1/hvfywfpzijGpQ0t056+l2pj8U/FdjevzzfMgd5ekLPjU26E09eFAj3h4qapkHTi1r7lZ/KqGijsDJ4uiX5+tV7GHlTbGHRPeMoTDitq0qydpJXEvj4mYylnlnLsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2urd8YlFWk2AmcLUkLmCK2OxZz9NbU3l1yn41htywU8=;
 b=u/vGpK6mP9b87w1O0lL2l9SsKCUVZKWQDHdPSLaP/D46qZHT9halJ0jo6xwVabGZjCyOOKj/+5o8Mxt55IQGfu0piOO6Wr2nL+tNx9y+CXDppCdWfn8UVOoK+xpEwdAUN0a2hNcljvBgyKefFc/25/k66z5Gka64oecGdRN12/YIMCgt/UHrux0CVuufXrD+EiSUMl5Qk9XmPbFX/O+ajgzE0uKWq/uGnLArFyyW/pLVsxmtQPfqC3RQrS3DWG4hoBKDe2ySgMXshensY/9qR7cAjpAX6eO176tQvpWIEyBs64UU4HQKTKTRbKSB4V8e/yFXNI9NmK1tKOZ3DC8Ecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2urd8YlFWk2AmcLUkLmCK2OxZz9NbU3l1yn41htywU8=;
 b=ob8US9L6qnglWKkXT8tt1oTWbNnKbXjrUiDx2RHf+3PCWOH6DQj7nHRqyRNclmsCKsHYVJ/LS4v22zDTwk8l9W8Su6/m4kvOVGCe3xqdt4zQl/R05fJqff1rqYdPzmd6inRrnQiOwmLUyWRvZe78AvAjlrIYkZo6jnXsPtRdIi8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::645) by CH3PR12MB9731.namprd12.prod.outlook.com
 (2603:10b6:610:253::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 18:49:44 +0000
Received: from DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::2359:d8c:c779:471a]) by DS5PPF18A985A10.namprd12.prod.outlook.com
 ([fe80::2359:d8c:c779:471a%4]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 18:49:44 +0000
Message-ID: <5ce8f51c-1f91-420a-ab3f-7b10b4c73ae3@amd.com>
Date: Fri, 11 Sep 2026 14:49:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Try RGB before YCbCr 4:4:4 in stream
 validation
To: Adrian Betschart <adrian.betschart@cinemaone.ch>,
 amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Adolfo Rodrigues <adolfotregosa@gmail.com>
References: <20260911151314.66957-1-adrian.betschart@cinemaone.ch>
Content-Language: en-US
From: Ivan Lipski <ivan.lipski@amd.com>
Organization: AMD Inc.
In-Reply-To: <20260911151314.66957-1-adrian.betschart@cinemaone.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::16) To DS5PPF18A985A10.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::645)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF18A985A10:EE_|CH3PR12MB9731:EE_
X-MS-Office365-Filtering-Correlation-Id: 58291fea-f717-4fe2-b0fe-08df103571e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|3023799007|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j/h5TfPfffDHjRxMr2AxqC9aIZ0uBSw0tIB4/4WasDTe5KjrjcceHZ/ZiXmx797NXy933RU7em43MnWGdYThYAZz3nerx0AznogxB5GK/BUJhMO9K/HBmNVlEKU6RfroTH8ywQ4QNjcyAJrAIj41r4YU0DJcQ2MKojy9VTrbyAHco2Q6nsCMcarAHNTbDTfdjmCd9D4lH8JOb19rHBm755JZbnQWIWbgyMgQTvTA9Nsh9nLxdEPqIIn/u4oo+FfxX2hvYpOCWLmLQosYbW8gvvqbw7IbWy4rQ1C5+A5MDyvFdD+XdNGc49rzYku6oU2cGUOamEfUnXz9RLBe+25Jg/70DgwvZ/hUL9JmniRi6LRCiQJIe9MK5dcNwF8TwhTbq1rZpG2amtxw1MzLj0QmmaUv67GX0/4rwjUhpZxCzVFV1bsIbRX1qlnyuvHN214QSE/jcIm3r+H7IJDDI1ErBlxSMf3gbJpy/PR6/k0gHqdC4Z3m9sZ7WGwm9tqKWVX1Z40sj6qZCEda7mihM2Cyi9ndRqL3iDSZLP/3jHQGd9J8QFpdNFGR4ZKtDOPoHpT4XcXs0uBDtqiSiYzEBtaYbfV4GSW+VHroOIEMAcvTc+m7q+cZa+u0wuqSL2FM6XcEaTbDU5lTMbzN87m6hOuDxNxWDRkoc35jKVEwwf+W174=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF18A985A10.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXlVNzlzZ2xCamd5MSsvZmNZdGxwM1lIcTM4TjBHY2VwSlpoSUdFNmpWKzRk?=
 =?utf-8?B?cUcxN2NsT29VS3JnTlRyY2E3TWVSTkxleEM0WGRETmhZZWNQV0JvaWlXbEth?=
 =?utf-8?B?VzJ2YzRBWUtod0RsYytWWjkyazI4S0djL3Z0Rkc1Z0t0WkpoWFd2WTdxM0dB?=
 =?utf-8?B?Z0FOZTJIdE5IOVBPb2JMTDdPNUQrYVp0RHhZRHhiK1Z6UkdoUDBzYkhqbzlB?=
 =?utf-8?B?c1FJb3ZyYURzQ3MwaDBrYkVvNGljdEhZSzYyOC9rR2tScURHOFd6Sktwc2xZ?=
 =?utf-8?B?V0RKMFJTRVdMVDBLVzdFVFdpM1BGaFlSckJPU3FoZExZZHRqRCt2M3hPdnl3?=
 =?utf-8?B?VlI2eUZqMitRRUl0MDlrdUhaZit2UmtuNzdWWUVwZlN2RG9DNko0ZkZFNUx2?=
 =?utf-8?B?MVdDN2I3REw4a0pRS1pwWUdkazdQdENveW5uaTh6K2F5eDZtQzdBQkNURVVJ?=
 =?utf-8?B?ajU1aWFXLzZrTDRhVnAzTXRmOHE0NzVSZWVhaXJYNXA5UmcrSEpmWnB1a0Js?=
 =?utf-8?B?Nk5JcTVlaWlUNFZlUEJndEtncGw0WTNKVmx0SEE3cElrMndoV3hBMmVqZzRs?=
 =?utf-8?B?REZwZHRsalFqUlpwdGRMUnFkSDJ1bXMxb2JNV0drYTdjMFlkUFNUNmQ3RzVC?=
 =?utf-8?B?aEx3UGRVbXZHbldxaTNKNmZXTlphU0MvQWhxSmFURGZVWWZybDR6aFpvMTRW?=
 =?utf-8?B?a01aeVdIV0dZcVFwejRQUTF2WHlaL05KRCs1Q1VGYUZtNHI3dUUza1dINHlS?=
 =?utf-8?B?MjNMcnZhMDgvN25BZmFYdk1iUEtQdEthaC9qa3pFY0hhL0dWRVlQTU5WbWJv?=
 =?utf-8?B?N1NDM05vRFIzOHoxUzNWMFdUUGk0dUpkZlJCcGp3NjhpRnkwNnBiZDM5cFBa?=
 =?utf-8?B?dE1oLy9jMUhGVHZ5WlBVdmxIa2pGWTlTZnNodkMreklwcnpYd0R3SkcvNitL?=
 =?utf-8?B?bDF5VzZ6dk9WMUduRFhqZngvVjlGSkdVMCs3R21DNHNuNjk3bE1KcHovazZu?=
 =?utf-8?B?ZnNnUEpORmM2TFFORVpsbjJ2Z2xEVGNscjBiRkhVV1J5Vjg2WXNaTzBvTnNs?=
 =?utf-8?B?L2dZc1ZMNEV6ZU92aVZ0ZW1BT2h5YjlTRUYwdVhoci8yT2s3YWY2eHJ3c1Q5?=
 =?utf-8?B?TWtWenhrZHJ0VlFtSkNVaFlJdThXV01IRm03U0JUQXl1RnpKRzVzMWlTSTRB?=
 =?utf-8?B?SmdZaTdhcHBnbFJhL0NQMXc4OStiUjBQMWVZUlBBTWtDRkRxbTdDVVNKdFlC?=
 =?utf-8?B?TkJ2ZUZqTWJBbVJBb240QU9GN2dKUEM2TlI5NU42ZzVMR1dZVmpLdnAvMFBx?=
 =?utf-8?B?QVZWUzNsVFZkVnMyRmVzRVBOT1Q0YlZBSlZiaTlZQ3pCV1FGMXRLN0x5VEV4?=
 =?utf-8?B?aGx6aEZqMUNicEVQbzBpNDlaeEQ1NG5rRzYyZ1dHYUttQW12N3RrQjgxZnJa?=
 =?utf-8?B?WEYzakRxdVRkWjFWWE5nOFhJaTl3amNqRzNKcTduR2kyeG9YMnVkVm9Lc3dU?=
 =?utf-8?B?Y21MWDBoQmZkVFc2SXBHZG5VckZCWGpDSUxaREZDZlU0Ti9MOTRDUkZBUGxF?=
 =?utf-8?B?TjQ2WVpBRWJTZHpycW00UWQ4VFYrT2twLzVlWFVsTW0xNzFoQ3FGNk5wZjdu?=
 =?utf-8?B?cWdLNG1UNVBGeld3RVg3Qm5SMjlmUmh3d2xEUGxtcWQ0d01nOHZ1NXpHV044?=
 =?utf-8?B?QlAySGlZbFZwVGlFQi9TWFRGekFjQUMwZ082T1dYUDgxS3NXYnFSWVV5SFZw?=
 =?utf-8?B?dlVibXVnZGNtU1BVNXFzR1JROXZXUWZnUm85UnhET09rNWt5OWN4ODlzY2sz?=
 =?utf-8?B?d1BJYWxMQmsyMVhHcmlOY0hBQlZPdHp0VTBzck1reUNjSmpmWUIrNWhjL0Zs?=
 =?utf-8?B?eDRjNXUxMVFpV29IeWl0cVp3MEFaVVBnWlFUTDIzVlc0OVI0Rkdrd2pObVV0?=
 =?utf-8?B?Z05NamwvVWM4eDdnZzdIL1l3cXBLTjVLejdYcEp3SU1Ecjh5KzZqaUE3eE52?=
 =?utf-8?B?S0EvMGRQeG4xRHpZbVYrdlFSM2hZSzlSU3dPRFpCNThvR3piK2dpMko2NEM4?=
 =?utf-8?B?RDBlQjh3ck4wT3FXdHAzcUpyOTd0ci96VHZ5citiM0JUVXRLSWhpZ2dxRU41?=
 =?utf-8?B?KzY5TFo2a2hEb21haFJmZGZPL1lyUUtPOXBWVjVKeEw4dGxBZjBWLzcvSExG?=
 =?utf-8?B?N2w1L3NMNXVuQTh2WlVRbnNsS3dDbWRUck04djh6U2RQbTdsNm9TdDF4OVZr?=
 =?utf-8?B?QXkyNVVCNFNnZzlYcWlrODFrRUdXaFU4TjkzTFFaNkgvNDRkZHd5dzRQNWoy?=
 =?utf-8?B?K3FqdHB6RTJ5SitURForUmIzMWJzcCtCSThPa2k0ckRGTXdHQkFFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58291fea-f717-4fe2-b0fe-08df103571e4
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF18A985A10.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 18:49:44.2452 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBDiV3FJWYyb0vktp3wwzTR8bNyUfH1XqQ573I7w02GYuzDdBkaVOlXsEvJIhjpU9MqKOo2OboI3Dc8kf3FWiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9731
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

Reviewed-by: Ivan Lipski <ivan.lipski@amd.com>

On 9/11/26 11:13, Adrian Betschart wrote:
> amdgpu_dm_create_validate_stream_for_sink() walks encoding_order[] and
> uses the first encoding that validates. YCbCr 4:4:4 is listed before
> RGB, so an HDMI sink that advertises 4:4:4 gets YCbCr 4:4:4 whenever the
> "color format" property is left at AUTO, even though RGB fits the same
> link.
> 
> That contradicts the documented AUTO behaviour for HDMI in enum
> drm_connector_color_format (RGB, falling back to YCbCr 4:2:0 only when
> the bandwidth is not available or the mode is 4:2:0-only), which the
> amdgpu implementation of the property also describes. It also leaves
> the "Broadcast RGB" property without effect on such sinks, since the
> quantization range it selects only applies to RGB output.
> 
> Try RGB first. The mask still holds every encoding the sink supports,
> so a mode that cannot carry RGB falls back exactly as before.
> 
> For reference, v7.2 picked RGB here unless YCbCr 4:4:4 was forced
> through debugfs, while earlier kernels picked YCbCr 4:4:4 for any HDMI
> sink that advertised it.
> 
> Fixes: 0b0ff65d3ca1 ("drm/amd/display: Refactor stream validation")
> Suggested-by: Adolfo Rodrigues <adolfotregosa@gmail.com>
> Tested-by: Adolfo Rodrigues <adolfotregosa@gmail.com>
> Signed-off-by: Adrian Betschart <adrian.betschart@cinemaone.ch>
> Assisted-by: Claude Code:claude-fable-5-1
> ---
>   .../display/amdgpu_dm/amdgpu_dm_connector.c   |  2 +-
>   .../tests/amdgpu_dm_connector_test.c          | 34 +++++++++++++++++++
>   2 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 0b446133edd8..98d0b35ed4e4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -2226,8 +2226,8 @@ amdgpu_dm_create_validate_stream_for_sink(struct drm_connector *connector,
>   	 * below gate which of these entries are actually attempted.
>   	 */
>   	static const enum dc_pixel_encoding encoding_order[] = {
> -		PIXEL_ENCODING_YCBCR444,
>   		PIXEL_ENCODING_RGB,
> +		PIXEL_ENCODING_YCBCR444,
>   		PIXEL_ENCODING_YCBCR422,
>   		PIXEL_ENCODING_YCBCR420,
>   	};
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> index 6e70d72135dc..c064def8253b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> @@ -7175,6 +7175,39 @@ static void dm_test_create_validate_stream_prune_context(struct kunit *test)
>   								    NULL));
>   }
>   
> +static enum dc_pixel_encoding dm_test_cvs_first_encoding;
> +
> +static bool dm_test_cvs_record_first_encoding(struct timing_generator *tg,
> +					      const struct dc_crtc_timing *timing)
> +{
> +	if (dm_test_cvs_first_encoding == PIXEL_ENCODING_UNDEFINED)
> +		dm_test_cvs_first_encoding = timing->pixel_encoding;
> +
> +	return false;
> +}
> +
> +/**
> + * dm_test_create_validate_stream_hdmi_rgb_first - HDMI tries RGB before YCbCr 4:4:4
> + * @test: The KUnit test context
> + */
> +static void dm_test_create_validate_stream_hdmi_rgb_first(struct kunit *test)
> +{
> +	struct dm_test_cvs_dc *c = dm_test_cvs_dc_alloc(test);
> +
> +	c->link->connector_signal = SIGNAL_TYPE_HDMI_TYPE_A;
> +	c->aconnector->base.display_info.color_formats =
> +		BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444);
> +	c->tgfuncs->validate_timing = dm_test_cvs_record_first_encoding;
> +	dm_test_cvs_first_encoding = PIXEL_ENCODING_UNDEFINED;
> +
> +	KUNIT_EXPECT_NULL(test,
> +			  amdgpu_dm_create_validate_stream_for_sink(&c->aconnector->base,
> +								    c->mode,
> +								    c->dm_state,
> +								    NULL));
> +	KUNIT_EXPECT_EQ(test, (int)dm_test_cvs_first_encoding, (int)PIXEL_ENCODING_RGB);
> +}
> +
>   /* Further tests for amdgpu_dm_connector_mode_valid() */
>   
>   /**
> @@ -9268,6 +9301,7 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
>   	KUNIT_CASE(dm_test_create_validate_stream_force_ycbcr444),
>   	KUNIT_CASE(dm_test_create_validate_stream_prune_timing),
>   	KUNIT_CASE(dm_test_create_validate_stream_prune_context),
> +	KUNIT_CASE(dm_test_create_validate_stream_hdmi_rgb_first),
>   	/* amdgpu_dm_update_connector_after_detect */
>   	KUNIT_CASE(dm_test_update_after_detect_mst_noop),
>   	KUNIT_CASE(dm_test_update_after_detect_sink_unchanged),

-- 
Thanks,
Ivan Lipski

