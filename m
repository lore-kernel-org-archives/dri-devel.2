Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3601BC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6CB10E5AE;
	Tue, 21 Jul 2026 19:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pSZPmp2W";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F6E610E3F0;
 Tue, 21 Jul 2026 19:28:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ju8Bxfx5fQEfYJNWrOS510VzFZXV4CkvkW8/FTNJsEa28Mkmw2+k6cCv72DVNeUpj0089sd0I0Li+PAaKJs/m3lMarIYtrSO6zuF9QgLATbHABD9d8+A5dhEiKp4SBw60qU0nDluAMiAuqI8Ub2NMYAurRNCHwLKd7VCs2aPMknvQr87MeDi1CbnT3lJQ091+4HA9WAfj4AWCiDY62HiNbCddajQTxCwM7LypTiSS+dNQeMINnMgQ5t8RwEySY/hvB/ciii2Pz7KM10NiVEixLaZuKA6R7qDQeckEAgX3PYIDPXAmRJAHQMTQFT+Ucob5cImwivSTmBoagQZJcMrww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niHZtr3RbaZU4k6E2fHaW8X1+C5wRp0GU+XMtBei+gg=;
 b=dVs8eu3YuhjIXCGyfz4jvOnUYTX7Zz3tB+aDOaSmQ9FxJSxxLrZH4cJitOnBtEQXIOVzpuppDlEodPgH5wCBuED8ilo4XAQVJ5s7LnwBPr77/BIxmCwUhhxOxPn5jOO2I6/CVxvFz8qSSsRKsxy0J5PXjp+jiBjyiGtIxr11siRHbL2irUVBcGn5mr2ewBGtxK7JkfNKQMq5TdzVfckz518MzPpQMbk8au/UNw+B7FkOYMi3aGl/YGipLqq7k9/b7+ypZJHm9TP33A1thROKVjiVgijA+t5kCIvvXEanhREB85DznOQHeUjfZ9fYGgrxD7vVUDc0C8/IZ8XspnQSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=niHZtr3RbaZU4k6E2fHaW8X1+C5wRp0GU+XMtBei+gg=;
 b=pSZPmp2WM9cv2PS+d3geCmovIeICj+XsvYOLGRVPlkvvIk6NN3HNECIantEYNAwM5ir/970gxCjYId2IYOp7jFPf5tvkZHcNyPaT0tI5QO44ZwEpZHhuw2NRlpzneFPEU9+Fu6RcVsO28w3QhBcYzUoE72GLF15utP+5Sa9lgVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 by SAWPR12MB999316.namprd12.prod.outlook.com (2603:10b6:806:55f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 19:27:59 +0000
Received: from SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b]) by SA0PR12MB7003.namprd12.prod.outlook.com
 ([fe80::4099:396e:1f40:169b%3]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 19:27:59 +0000
Message-ID: <c4aaa599-d1d8-4418-ada7-2e141f7a9e3f@amd.com>
Date: Tue, 21 Jul 2026 15:27:55 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Melissa Wen <mwen@igalia.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
 <20260623164812.81110-2-harry.wentland@amd.com>
 <20260703135227.742fad19@fluorite>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260703135227.742fad19@fluorite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::8) To SA0PR12MB7003.namprd12.prod.outlook.com
 (2603:10b6:806:2c0::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7003:EE_|SAWPR12MB999316:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1fc83e-d580-4b27-a0e0-08dee75e2c34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: i/F+kLfyBUjgHcnnXdtCOT9+KM86X/9CjtwAvRdyAoSjn3/B6QCqqXpXrBbc099cE9RkCKRLCW4ahb6FeMw3mkXaQL+bjqS9FLbqviKfDPgTjymx2oAjpw6Hd7CJsRA4Puw8Yd+0MKZ4scxs9e8ZeRooR9wVbqjgK5L8zESYoTPVKMQ189J0hMsE0tBJB+NAWaq/dSD70rnZRiay5xy3SnN5Htg/lbotvo5qrFODEzoGRtMqeFExV15hTZ0Mfj4nBOtKDf3pIZLfwETJTj0XKfmHHRrA/q2tTJcbuncKAUQ77MLNy1JMkzSAU/gUCMsfmaBqkjuiwyFrIJ3I+cfTOxNw0Ou1tCjppEHT6vf4ZN+MCMb1f/kOqyh2B077eJof7fY2k9bOIFBjINa+kKk1MQDrmunbkAprj1/QlGjWVA1PVwDZXe/fM7Te+V3gwUDFpZpuy4YFPPklN+XcAQpAmxhQ9PPp+7Kg1BsoFpRAkRh+CEnD5ZReZKoZuWt5RjOnoCTW0XmCx8pNm4NX9nQF1wFsABlKpkd/ersH6Uub/uCjZfaCL9VOCPXyvvkTvX90NQKzMHsCrp9PsiBrsg27v7AsWAA27uQPTKQFDUB0UTUWpTrg4sEnVrPTPl6f9T1CZKnPiIE9v+652NaLGC5/pLrapGZ5vZ4dA45QmFhRBPo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7003.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE5BaFJTOHFTY00rTXVIWUsvK3lpSVh4NWtJaTBkejNzaC85Ym5zTENiTkNW?=
 =?utf-8?B?cllvNTY5ODFzYzhEYWE4WkFaTlRrS0ZPdUVQQnkyd1pKOGNDdnNDenYzZVc3?=
 =?utf-8?B?N2lvSFUydE83V0tjRldrbGVIYTRURHNoUXUyN2ZBUzdBMk02UUNRZGhjVG1M?=
 =?utf-8?B?b3NHWFVEdHpZbDBBckZYRHFGZThDUjBUaG83Ymw1YTBrWiszUG53Q1lsUXdJ?=
 =?utf-8?B?VDNGTEZXYW02T3dnTmxESy9MRTRsVDBsWXQzQ0ozU3ZrU21Zcmh1MDQzS1N4?=
 =?utf-8?B?WWNRUTc0QU95WDdpUWtVNEVtMlIzTkowVFpUQm1rYW9uY2J0d3lwNFcwalpn?=
 =?utf-8?B?bFNIWUlWbytMZEZNbU5HZnlKTVV1cWJUc1FIU3BsaWVOMkIzdWZYMlN6bEJo?=
 =?utf-8?B?SWNYTkx0NTI0Kys0L2kxSTFUbFVJYXpvOEExTDZSemIyN1VETVp1VmdPTnVu?=
 =?utf-8?B?YU1xM0hadlBRblJlL25tUVpTRDBFakVBVFF6VzVkZ3R0MDBudi96dGs0V3JU?=
 =?utf-8?B?U0VEZ1hiYmlUK0xTaFhFTWtQbGZ2TE53SlV0dXZ6VXdSamRJSVFxZkR6MGhH?=
 =?utf-8?B?UGdjTmswMmNraXFwMFdwQkw5am02anl5RVlBMWg5VWhPdHdpMUZLbDlDblFB?=
 =?utf-8?B?TWZpZk9YdXdSMjdTSmZjNVBhRjFCZ3piSFV3eWxoMEhtV2wzdGs1UXVzR1oy?=
 =?utf-8?B?bjhTdldQajVYTk55MkVBRzV6QW9OQXVlbGtBQWI3SXMzaUZHQldpQXJqOE4y?=
 =?utf-8?B?cjlna3Y1K3R3UHpzM1RNczRnVkpvQkMzaGQ0YUtad1ptL2ZYOEhuejVsd0ZJ?=
 =?utf-8?B?anp6Zkd1RW9Ya2ZuM3F5U0tlaWtSaUdZTE81QkNiSEN0UXhBM2ZyQU9COVd5?=
 =?utf-8?B?amVYTGlKdTdCWFdpYy9zbEtYQUNWNFRSNndZcGRLbWRzRTV0WFF0R0J2WWNL?=
 =?utf-8?B?VVJmNjdSNHBhRjlnTnRYQm5FejcvMDZIVnNKeHBOTjdseG9hbTdBSzdROHFq?=
 =?utf-8?B?ZEs0Z0ZyYmhQejNLN2JtL2NLOGpqWitVY1JoelkvNDhOU20wK0RoL2VuYXhV?=
 =?utf-8?B?UVUwNWgwR0tocU5wL1VsRnNyVVd6NUhQR2J2UW9RWHpZZlR6WWNnV1NYOERY?=
 =?utf-8?B?c3dxN25Pa0kyTWYzUW9CMHdGY2VRRWpoQmRtZ2hGRkNzbkd2dGZsU0Y3eDJX?=
 =?utf-8?B?YTlyVU5NYWhyTnNNNnN5OHZJcFF0TmV4WmJDU0d2SE45Rk9QNzZwNTYvSVl6?=
 =?utf-8?B?aG5tc2dxYlQ0T2QzcXFsYWhqdkh3eis4STFsSWh6S1lVUmpDSlkwSVlyb0xU?=
 =?utf-8?B?dExJM0ZGckE4OElDWDNaUG9MbmVuVHUrYzYvYjcveDcrZk1tekpQRVJVajMv?=
 =?utf-8?B?d2JDNzd4aityYThJRGhxSTQzSVQ5MGF6TFd1MU9VTW44cTUrLzk1RGFKZE9o?=
 =?utf-8?B?KzRVZ2ZUems2aDAzK0pUaEd0Q2tzNUhkVmdNQU5VVnd5UmdxYzg1bjBmb3hY?=
 =?utf-8?B?dm4vWVZZSlVpUXNjSHBwRHU5d2VWMzF2Y0RRZmhjSXRxU2dYNGIwdnNYY2dS?=
 =?utf-8?B?SitnY1NGcUU1WHplWFZJb0ZrZ01jbFBZdXNLN2s3Zk5sUWN6RW5VbktUVmg3?=
 =?utf-8?B?QVlDY1ZSTkR4Mnl1QndaWmRUY2IwL253N1Q4Z0ZwUS93Q0pUMWVSSitxY3Fm?=
 =?utf-8?B?UXNOVDFnZjNZS0FOY09zNldYMWNVWDI2eFNGak5WaDlNbEpJQ1RQNHFXVzMz?=
 =?utf-8?B?K3JjQUM2S1haa1RhcWZiaDJ0d0pFbTdSRllRZmxxSSt4WHhkNEMvSU1lazN0?=
 =?utf-8?B?aUNNMXZtSkNJZmlwZkV2NDYxRWJ4NEJrd0JoRHJOYlpPOE5BTjhINGR0NWVv?=
 =?utf-8?B?NnRlcElWU21zWGhJc2xTNVFqYk8yWlNCdG5jWkhydEFyaVl6U3RPblJCK2t6?=
 =?utf-8?B?TGw5NDNvQWVPblJXSDArSVZReFZ6cTZmQWZydjUvZkRkRTFTdjZQT3dXTlYr?=
 =?utf-8?B?ZHNVbFBLcFY4NVVzbUZ2cjAwbUNjRjJDQ1VTdUE0Wm1kSldkOW9ZeXZXeERP?=
 =?utf-8?B?MlcrYmtYalBtc2lCUzloTGYzYkorYXJHSDkvSWZxZHk4cWlTVk1LZWVsRzNI?=
 =?utf-8?B?dVF2dndKbldFQkdJajBWS3lhOUxGb2FqdlF0dlNVLzBYalJiRTlPWGFXYjJY?=
 =?utf-8?B?SkpCbHgydjZOUFk4RnJMa2VqMldERGw1ZklrbGdmdGxPSkVDQTZJMy93ZVlJ?=
 =?utf-8?B?dzRpQnkzbDNjZ0xTN3U3WUVJTW5UcVlSczF0L2d5WEVhY0MxWjhOZEd1cUhh?=
 =?utf-8?B?b1NXZnJ3YXY0ZEZIenBWK1pXcndnNk1EZmNDN2tjRFo4SDJhK2RJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1fc83e-d580-4b27-a0e0-08dee75e2c34
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7003.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 19:27:58.9139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zs51QKUahP2CAOjr4t94w2/rndiSQSWUbROVICOqW7RV/RLycD3oBki6ES5/qm+Fy89zndesAscE8LfWRN1Dww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999316
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



On 2026-07-03 06:52, Pekka Paalanen wrote:
> On Tue, 23 Jun 2026 12:48:02 -0400
> Harry Wentland <harry.wentland@amd.com> wrote:
> 
>> From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>
>> Introduce DRM_COLOROP_FIXED_MATRIX, a new colorop type representing a
>> hardware that performs a fixed matrix operation.
>>
>> Unlike CTM-based colorops, this block does not expose programmable
>> coefficients. Instead, userspace selects one of the predefined
>> hardware modes via a new FIXED_MATRIX_TYPE enum property. Supported modes
>> include common YCbCr->RGB and RGB709->RGB2020 conversions.
>>
>> v2:
>>  - Naming changes (Pekka)
>>
>> v3:
>>  - Fix NC matrix enum name and string (Melissa)
>>  - Rebase
>>
>> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>> Reviewed-by: Melissa Wen <mwen@igalia.com>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>> ---
>>  drivers/gpu/drm/drm_atomic.c      |   4 ++
>>  drivers/gpu/drm/drm_atomic_uapi.c |   4 ++
>>  drivers/gpu/drm/drm_colorop.c     | 106 ++++++++++++++++++++++++++++++
>>  include/drm/drm_colorop.h         |  84 +++++++++++++++++++++++
>>  include/uapi/drm/drm_mode.h       |  12 ++++
>>  5 files changed, 210 insertions(+)
>>
> 
> Hi,
> 
> the UAPI looks good.
> 
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> 
> It's a little bit unfortunate that the colorop UAPI documentation is
> embedded into kernel-private enum types' documentation.
> 

Agreed. This goes beyond this patchset. I'll have a look at a separate
series to see if we can fix that.

> Is RGB always full-range? The documentation could be more explicit
> about that. Maybe the documentation should spell out the matrix
> contents just to be clear? There are more than one form of limited
> range IIRC (HDMI, JPEG, SDI). Or maybe JPEG was a different type of
> full-range?
> 

It's always full-range. Agreed about spelling out the matrix contents.

>> +	 * enum string "RGB709 to RGB2020"
>> +	 *
>> +	 * Selects the fixed-function CSC preset that converts RGB
>> +	 * (BT.709) colorimetry to RGB (BT.2020).
> 
> Why is this called a "CSC preset" rather than a matrix? This confuses
> me.
> 

Will fix that up.

I was taking Chaitanya's patch as-is and adding my changes in Patch 2
but with all these changes I'll end up squashing the two commits
together.

> Was there a conclusion from discussions around compatible pixel formats
> for a specific choice of a fixed matrix? How will userspace discover
> that, or will it be based on documentation and enforced as a common
> requirement over all drivers?
> 
> ISTR some hardware requiring an YUV pixel format to be able to use the
> YCbCr conversion matrices, or vice versa. Otherwise there is no reason
> to have that limitation.
> 

We talked about this at the Hackfest (offline most likely) and the
consensus is that there's no reason to limit this to certain pixel formats.
We should treat it as a simple matrix that operates on the 3 input channels.
If userspace decides to select a CSC matrix for an RGB buffer it's assumed
that that's intentional and userspace knows what it's doing.

Harry

> 
> Thanks,
> pq
> 
> 
>> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>> index 3af1b9cc9a06..ced591c4a0bd 100644
>> --- a/drivers/gpu/drm/drm_atomic.c
>> +++ b/drivers/gpu/drm/drm_atomic.c
>> @@ -925,6 +925,10 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
>>  				  drm_get_colorop_lut3d_interpolation_name(colorop->lut3d_interpolation));
>>  		drm_printf_indent(p, 1, "data blob id=%d\n", state->data ? state->data->base.id : 0);
>>  		break;
>> +	case DRM_COLOROP_FIXED_MATRIX:
>> +		drm_printf_indent(p, 1, "fixed_matrix_type=%s\n",
>> +				  drm_get_colorop_fixed_matrix_type_name(state->fixed_matrix_type));
>> +		break;
>>  	default:
>>  		break;
>>  	}
>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
>> index c7f80d90794c..cee4550ffdbd 100644
>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>> @@ -761,6 +761,8 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
>>  	} else if (property == colorop->data_property) {
>>  		return drm_atomic_color_set_data_property(colorop, state,
>>  							  property, val);
>> +	} else if (property == colorop->fixed_matrix_type_property) {
>> +		state->fixed_matrix_type = val;
>>  	} else {
>>  		drm_dbg_atomic(colorop->dev,
>>  			       "[COLOROP:%d:%d] unknown property [PROP:%d:%s]\n",
>> @@ -793,6 +795,8 @@ drm_atomic_colorop_get_property(struct drm_colorop *colorop,
>>  		*val = colorop->lut3d_interpolation;
>>  	else if (property == colorop->data_property)
>>  		*val = (state->data) ? state->data->base.id : 0;
>> +	else if (property == colorop->fixed_matrix_type_property)
>> +		*val = state->fixed_matrix_type;
>>  	else
>>  		return -EINVAL;
>>  
>> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
>> index c0eecde8c176..c11c3012fcc5 100644
>> --- a/drivers/gpu/drm/drm_colorop.c
>> +++ b/drivers/gpu/drm/drm_colorop.c
>> @@ -68,6 +68,7 @@ static const struct drm_prop_enum_list drm_colorop_type_enum_list[] = {
>>  	{ DRM_COLOROP_CTM_3X4, "3x4 Matrix"},
>>  	{ DRM_COLOROP_MULTIPLIER, "Multiplier"},
>>  	{ DRM_COLOROP_3D_LUT, "3D LUT"},
>> +	{ DRM_COLOROP_FIXED_MATRIX, "Fixed Matrix"},
>>  };
>>  
>>  static const char * const colorop_curve_1d_type_names[] = {
>> @@ -90,6 +91,14 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
>>  	{ DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
>>  };
>>  
>> +static const char * const colorop_fixed_matrix_type_names[] = {
>> +	[DRM_COLOROP_FM_YCBCR601_FULL_RGB] = "YCbCr 601 Full to RGB",
>> +	[DRM_COLOROP_FM_YCBCR709_FULL_RGB] = "YCbCr 709 Full to RGB",
>> +	[DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] = "YCbCr 2020 NC Full to RGB",
>> +	[DRM_COLOROP_FM_YCBCR_LIMITED_FULL] = "YCbCr limited to full",
>> +	[DRM_COLOROP_FM_RGB709_RGB2020] = "RGB709 to RGB2020",
>> +};
>> +
>>  /* Init Helpers */
>>  
>>  static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *colorop,
>> @@ -455,6 +464,80 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
>>  }
>>  EXPORT_SYMBOL(drm_plane_colorop_3dlut_init);
>>  
>> +/**
>> + * drm_plane_colorop_fixed_matrix_init - Initialize a DRM_COLOROP_FIXED_MATRIX
>> + *
>> + * @dev: DRM device
>> + * @colorop: The drm_colorop object to initialize
>> + * @plane: The associated drm_plane
>> + * @funcs: control functions for the new colorop
>> + * @supported_fm: A bitfield of supported drm_colorop_fixed_matrix_type enum values,
>> + *               created using BIT(fixed_matrix_type) and combined with the OR '|'
>> + *               operator.
>> + * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
>> + * @return zero on success, -E value on failure
>> + */
>> +int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct drm_colorop *colorop,
>> +					struct drm_plane *plane,
>> +					const struct drm_colorop_funcs *funcs,
>> +					u64 supported_fm, uint32_t flags)
>> +{
>> +	struct drm_prop_enum_list enum_list[DRM_COLOROP_FM_COUNT];
>> +	int i, len;
>> +	struct drm_property *prop;
>> +	int ret;
>> +
>> +	if (!supported_fm) {
>> +		drm_err(dev,
>> +			"No supported FM type op for new Fixed Matrix colorop on [PLANE:%d:%s]\n",
>> +			plane->base.id, plane->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if ((supported_fm & -BIT(DRM_COLOROP_FM_COUNT)) != 0) {
>> +		drm_err(dev, "Unknown Fixed Matrix provided on [PLANE:%d:%s]\n",
>> +			plane->base.id, plane->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = drm_plane_colorop_init(dev, colorop, plane, funcs, DRM_COLOROP_FIXED_MATRIX, flags);
>> +	if (ret)
>> +		return ret;
>> +
>> +	len = 0;
>> +	for (i = 0; i < DRM_COLOROP_FM_COUNT; i++) {
>> +		if ((supported_fm & BIT(i)) == 0)
>> +			continue;
>> +
>> +		enum_list[len].type = i;
>> +		enum_list[len].name = colorop_fixed_matrix_type_names[i];
>> +		len++;
>> +	}
>> +
>> +	if (WARN_ON(len <= 0))
>> +		return -EINVAL;
>> +
>> +	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC, "FIXED_MATRIX_TYPE",
>> +					enum_list, len);
>> +
>> +	if (!prop)
>> +		return -ENOMEM;
>> +
>> +	colorop->fixed_matrix_type_property = prop;
>> +	/*
>> +	 * Default to the first supported CSC mode as provided by the driver.
>> +	 * Intuitively this should be something that keeps the colorop in pixel bypass
>> +	 * mode but that is already handled via the standard colorop bypass
>> +	 * property.
>> +	 */
>> +	drm_object_attach_property(&colorop->base, colorop->fixed_matrix_type_property,
>> +				   enum_list[0].type);
>> +	drm_colorop_reset(colorop);
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(drm_plane_colorop_fixed_matrix_init);
>> +
>>  static void __drm_atomic_helper_colorop_duplicate_state(struct drm_colorop *colorop,
>>  							struct drm_colorop_state *state)
>>  {
>> @@ -521,6 +604,13 @@ static void __drm_colorop_state_init(struct drm_colorop_state *colorop_state,
>>  							   &val))
>>  			colorop_state->curve_1d_type = val;
>>  	}
>> +
>> +	if (colorop->fixed_matrix_type_property) {
>> +		if (!drm_object_property_get_default_value(&colorop->base,
>> +							   colorop->fixed_matrix_type_property,
>> +							   &val))
>> +			colorop_state->fixed_matrix_type = val;
>> +	}
>>  }
>>  
>>  /**
>> @@ -584,6 +674,7 @@ static const char * const colorop_type_name[] = {
>>  	[DRM_COLOROP_CTM_3X4] = "3x4 Matrix",
>>  	[DRM_COLOROP_MULTIPLIER] = "Multiplier",
>>  	[DRM_COLOROP_3D_LUT] = "3D LUT",
>> +	[DRM_COLOROP_FIXED_MATRIX] = "Fixed Matrix",
>>  };
>>  
>>  static const char * const colorop_lu3d_interpolation_name[] = {
>> @@ -640,6 +731,21 @@ const char *drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_inte
>>  	return colorop_lu3d_interpolation_name[type];
>>  }
>>  
>> +/**
>> + * drm_get_colorop_fixed_matrix_type_name: return a string for fixed matrix type
>> + * @type: fixed matrix type to compute name of
>> + *
>> + * In contrast to the other drm_get_*_name functions this one here returns a
>> + * const pointer and hence is threadsafe.
>> + */
>> +const char *drm_get_colorop_fixed_matrix_type_name(enum drm_colorop_fixed_matrix_type type)
>> +{
>> +	if (WARN_ON(type >= ARRAY_SIZE(colorop_fixed_matrix_type_names)))
>> +		return "unknown";
>> +
>> +	return colorop_fixed_matrix_type_names[type];
>> +}
>> +
>>  /**
>>   * drm_colorop_set_next_property - sets the next pointer
>>   * @colorop: drm colorop
>> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
>> index b4b9e4f558ab..88933d5b4d8b 100644
>> --- a/include/drm/drm_colorop.h
>> +++ b/include/drm/drm_colorop.h
>> @@ -134,6 +134,71 @@ enum drm_colorop_curve_1d_type {
>>  	DRM_COLOROP_1D_CURVE_COUNT
>>  };
>>  
>> +/**
>> + * enum drm_colorop_fixed_matrix_type - type of Fixed Matrix
>> + *
>> + * Describes a Fixed Matrix operation to be applied by the DRM_COLOROP_FIXED_MATRIX
>> + */
>> +enum drm_colorop_fixed_matrix_type {
>> +	/**
>> +	 * @DRM_COLOROP_FM_YCBCR601_FULL_RGB:
>> +	 *
>> +	 * enum string "YCbCr 601 Full to RGB"
>> +	 *
>> +	 * This selects the matrix that converts full range YCbCr into RGB
>> +	 * according to the BT.601 coefficients.
>> +	 */
>> +	DRM_COLOROP_FM_YCBCR601_FULL_RGB,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FM_YCBCR709_FULL_RGB:
>> +	 *
>> +	 * enum string "YCbCr 709 Full to RGB"
>> +	 *
>> +	 * This selects the matrix that converts full range YCbCr into RGB
>> +	 * according to the BT.709 coefficients.
>> +	 */
>> +	DRM_COLOROP_FM_YCBCR709_FULL_RGB,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
>> +	 *
>> +	 * enum string "YCbCr 2020 NC Full to RGB"
>> +	 *
>> +	 * This selects the matrix that converts full range YCbCr into RGB
>> +	 * according to the BT.2020 non-constant luminance coefficients.
>> +	 */
>> +	DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FM_YCBCR_LIMITED_FULL:
>> +	 *
>> +	 * enum string "YCbCr limited to full"
>> +	 *
>> +	 * This selects the matrix that converts limited range YCbCr into
>> +	 * full range YCbCr. Though not strictly a matrix operation but
>> +	 * can be represented as one.
>> +	 */
>> +	DRM_COLOROP_FM_YCBCR_LIMITED_FULL,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FM_RGB709_RGB2020:
>> +	 *
>> +	 * enum string "RGB709 to RGB2020"
>> +	 *
>> +	 * Selects the fixed-function CSC preset that converts RGB
>> +	 * (BT.709) colorimetry to RGB (BT.2020).
>> +	 */
>> +	DRM_COLOROP_FM_RGB709_RGB2020,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FM_COUNT:
>> +	 *
>> +	 * enum value denoting the size of the enum
>> +	 */
>> +	DRM_COLOROP_FM_COUNT
>> +};
>> +
>>  /**
>>   * struct drm_colorop_state - mutable colorop state
>>   */
>> @@ -183,6 +248,13 @@ struct drm_colorop_state {
>>  	 */
>>  	struct drm_property_blob *data;
>>  
>> +	/**
>> +	 * @fixed_matrix_type:
>> +	 *
>> +	 * Type of Fixed Matrix operation.
>> +	 */
>> +	enum drm_colorop_fixed_matrix_type fixed_matrix_type;
>> +
>>  	/** @state: backpointer to global drm_atomic_commit */
>>  	struct drm_atomic_commit *state;
>>  };
>> @@ -368,6 +440,13 @@ struct drm_colorop {
>>  	 */
>>  	struct drm_property *data_property;
>>  
>> +	/**
>> +	 * @fixed_matrix_type_property:
>> +	 *
>> +	 * Sub-type for DRM_COLOROP_FIXED_MATRIX type.
>> +	 */
>> +	struct drm_property *fixed_matrix_type_property;
>> +
>>  	/**
>>  	 * @next_property:
>>  	 *
>> @@ -424,6 +503,10 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
>>  				 uint32_t lut_size,
>>  				 enum drm_colorop_lut3d_interpolation_type interpolation,
>>  				 uint32_t flags);
>> +int drm_plane_colorop_fixed_matrix_init(struct drm_device *dev, struct drm_colorop *colorop,
>> +					struct drm_plane *plane,
>> +					const struct drm_colorop_funcs *funcs,
>> +					u64 supported_fm, uint32_t flags);
>>  
>>  struct drm_colorop_state *
>>  drm_atomic_helper_colorop_create_state(struct drm_colorop *colorop);
>> @@ -482,6 +565,7 @@ drm_get_colorop_lut1d_interpolation_name(enum drm_colorop_lut1d_interpolation_ty
>>  
>>  const char *
>>  drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_interpolation_type type);
>> +const char *drm_get_colorop_fixed_matrix_type_name(enum drm_colorop_fixed_matrix_type type);
>>  
>>  void drm_colorop_set_next_property(struct drm_colorop *colorop, struct drm_colorop *next);
>>  
>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
>> index 381a3e857d4e..bff6dba08d50 100644
>> --- a/include/uapi/drm/drm_mode.h
>> +++ b/include/uapi/drm/drm_mode.h
>> @@ -954,6 +954,18 @@ enum drm_colorop_type {
>>  	 *         color = lut3d[index]
>>  	 */
>>  	DRM_COLOROP_3D_LUT,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FIXED_MATRIX:
>> +	 *
>> +	 * enum string "Fixed Matrix"
>> +	 *
>> +	 * A Colorop block that performs a pre-defined matrix operation selected
>> +	 * via the FIXED_MATRIX_TYPE enum property. The driver advertises the supported
>> +	 * operations through this property.
>> +	 */
>> +	DRM_COLOROP_FIXED_MATRIX,
>> +
>>  };
>>  
>>  /**
> 

