Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03F3C5516E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:27:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CCCE10F070;
	Thu, 30 Jul 2026 20:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Upad/GYs";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CC8610F070;
 Thu, 30 Jul 2026 20:27:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yQJuHLoTEgw8ucefFLYI3LCKlullHoq/OfZNzwfNYgluR2jVpK1JO/nu7W8onJMJPWDoJobqwkTkNdLvtD+9X7U/39ckjPivVVEUynOzgxRoVnXUoGTN/T+vcDs8imeUeay+U7s9oLHhRN9zskTFHjJgUweKGAxc42+JutvhIVXlwxCypvEeRKKdsUaIDhH9PupRXQSzoqbPuDab6v/6XqhCH1N2cdZ7vET4l3de4udlaELtZ4/QvKngV4fjVjoBMoeoYu1hNfycvGSW0yU4pl3jTLy68RlNbGaQWneMsgO6jvAk2wj/eJGT1smKyFbZzkv0gzPs/QMvdwM7W2e9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1VaTQs/PGhXFYtG0JcWJQfc+KlOQLccDCKYtPdgkaY=;
 b=XU6UQWn9XuC4jdXqKXt1VeJccqMqf+lzB0C5qA3kC3aCW0oyEOURiaJrxea4NCjtQzJOz0zFgmG9d5P8yufsY+sg83T/fQrfGo/ZMjPpVOEx+1QitVkGdYSSoqBZTNY4js33SnnghXtgtiqluGUvsfUChCU9fuR/NXAtSlbVpcwCl6l9353SPcmbYLuTPoptKVcVSe0ehoQCm9xmDgYn4L0Hlr5XI5WuO7/IQycBwZJk3nhHVKCoQ2EISo6iNO7ZzlPTzRjIf3qi+p3UTBOe9v1apZwl6JK5XtCmKnz4CQQSPt9pGaPrxUnD8kV54uRYcU0mPr1A72IWcGZweHGjXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1VaTQs/PGhXFYtG0JcWJQfc+KlOQLccDCKYtPdgkaY=;
 b=Upad/GYs0l6cONiC7PPTlSbY9tJIFeqGX+ZetICCiaBEikgYe8m00c6poLu9KeIwazsKovMH2hQTuTOQFVSs97ESBS6uzfl7d5/2JoNUFP7EBMqit9noh/b+Lf3qPhBYQQOQMsI75anF+Y/mE9wJqfxlTqvolkJHmZnGHQeBvmM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 20:27:31 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 20:27:31 +0000
Message-ID: <fea5b938-24ec-4e62-9c7b-e0afbca83c0e@amd.com>
Date: Thu, 30 Jul 2026 16:27:27 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Melissa Wen <mwen@igalia.com>, Robert Mader <robert.mader@collabora.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-2-harry.wentland@amd.com>
 <20260730135911.4e52408e@fluorite>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260730135911.4e52408e@fluorite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0237.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::32) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: daf48056-849e-405a-1e29-08deee78fb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|5023799004|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OaKBWuycdvB7K0LCOtykvziR7UsY0eV2h8CKV7ubflOyvM54jNpaloETL4mnojDA76M/ssOX0suN9QFkyPP5KzOvuCYDB/Cyrsej1KEDW0gQtqlKNC/rZ9RTNVt4/P6BbpGtsJiRoRWbAbBne0PbkyjRaDOSmdNde/awy+Yt2Hypv/QjCgw8zlBY5i3zPOOHd710qfO3eaV6iKV+b9LdA6hnRYeC8A16x2Lj8wCmODWB09+I08Qw5V/TlI9gEvoWPiY1v60wNsH+WIndMVl0JL0b1PZwTdTSiv4uQWoxfiY3pHLj8nCtP4VXTCtqQjeWWIm3mwFRzLirAFXnYJ5WMos1iPb+UtnK2IqzsM8uUbhohJNN/oQLLM5/wmWPfX+Q/0LpcLmREuPRhdg5Y1qAGmon71h5O+TfoWkpwYoHAlWHa6kGMb3EXLndZBqR7UCgO5cvrdCM414TDWCX4HbpQq0QEUJa9SLDFG1HioHbSc5IVIcDNIgAFm5KwgCmevabB8ISG0BGBj1INRebUqyFNIXafigcauyh+eIHzCLkWDR7t1IwTq6eWlh4crfxktKru7u9aPZGNvAroIkoObDqpa6qyV5wJ9xnHG8drKHDkuolF84rLKGsss2xetVO5kQn6O1PhuopnFBNq/CDrda1fKFUOpau+Fmu+fcA+LoJdHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(5023799004)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmJaNG5Yb2l2bzNNQVRYdzRFMG9VZGNBWmo3ZlBIWG8yYXRYb1dESzNDRmJT?=
 =?utf-8?B?VFBHZTV6R3BQQXMzb3BhbGFEY2lLdThtQ2JUR216OHY2NmNKSkxXWVJjTlVn?=
 =?utf-8?B?T2JMZ3NmUE1vNnRodkxteVR3enpaaUc3ZVRiVTk3WkEvUU02YkxPVVFxUEEy?=
 =?utf-8?B?dCt6R2NPR1pjS0diOTJHbkFjZHl0Vzlpc3lqMEpjbUlSam9sVkpTdjBYUllk?=
 =?utf-8?B?VDZRdE9FZDhMcXJFZkdscTE2bXpoZ2pDbUUvc2JIUEVUek55citqZzBUK3lX?=
 =?utf-8?B?Qzc0bVhpMy9XZjc0U29jOFNLd3F0OFlsTEt1Q1dqR1gwRU5ScFo5dEkrYnNU?=
 =?utf-8?B?RTNiUFVoVE1tb1JNRG1sV2RQWEpXWkdkc1RMb1kyTC95Z05YbW1jTW9KTUJP?=
 =?utf-8?B?WGRvMExtZmxLV25Ha05UTkUvK214QVZhNlRNOFBtZFltTmxlM2h1czlramdq?=
 =?utf-8?B?TllCTTNOU2d0MU1DVkhaZGRxR290VUoxa01HREFzU01vbklFakx0WXNZd3Y0?=
 =?utf-8?B?TC9idHhTNVYzYnNWZE1xSitZUFY0ZFpoNHhPV3pHYXFlZm1xaVRnN3ZEZmRu?=
 =?utf-8?B?SVM1ejVKNDFjQVFxR25XUnBQZWZqNGd6VDJyeWlINmU0MldudjBUb1BWdG0z?=
 =?utf-8?B?blU1UDNQZm1aME5kbzhHUFprT2Q3akpqbFpmUGtnVDlpdS9mYXZqSktGZWZF?=
 =?utf-8?B?RXVrRUtDMkZnSFU4dEZUVkcrbC9iS3NUUEk1SUgwTlBBTkdEdzd4SWluY0g5?=
 =?utf-8?B?V241RXZydGx4YmtQbEsxYVJWdzdHaDZCc1hZOGI2TDFnNTAzL09GMW9OZlhU?=
 =?utf-8?B?RnE1ZWRFdEtZZXFyV21vOG1IRStUWGpUckxoVmVpS0xBUDh4REZuTGVkNUFS?=
 =?utf-8?B?OXVVZUxqcGp5cDFINWZIUEtGRWJxZ1Y5SDVWL284QmhoODl5MFNSaWxzVlpy?=
 =?utf-8?B?Ulg3UVZTZ0hUTHdEa3dMSEtraUVINWYvMG1CcEpwdmF2aUVXQWIzaU9PcStM?=
 =?utf-8?B?Q3M4a1grZlpEZThyUFJLNSs1WGJmZm1YSU1ZV1RmNC9xQis1Q3VxRGxDYld5?=
 =?utf-8?B?RHp0Z2gwc2pNUlNlVkk5RXZUUWJ6ODk2K2JWc2FyZCtCMExSaW5GQ3o1RFBu?=
 =?utf-8?B?L3NRdURLUmp2eHoyLzExUzc3MzVpbURZNjh5QWVFaS80V09lM0ZTYWI0V2Z6?=
 =?utf-8?B?czhPR1JHclNwUVJKdVYxdlJiOTZkelNsMGovTVdSOG9xSjlYNWNxb0YvN1pI?=
 =?utf-8?B?QllGZUlZdzZTUUh5ZXk5Y2FOVjRkRURsY2taYml1L2t2M09JMW82eUNOMjAy?=
 =?utf-8?B?dGFWVVNyaklkNUpnN0Y2bzZOZXlzOHh4R2FKQW41Ti9tYzZPMXQ1YmxoU3d3?=
 =?utf-8?B?UHRpM1RyRlVZUDllWHdVRTZZV0NGRjczRHZRU3pUa2FkNm1nY2cvZ3lMdFll?=
 =?utf-8?B?MUZrcWdHVTU4bHNQSWZXMXMzb3lCVnozQ0w0cGJLYThLNllyYUxndHhDbjFT?=
 =?utf-8?B?VHk2YmhSSU5Jc3FBTkY3NWFuOSs3TkdpOHZIek9mZDIvQzVkUHJIRlZleE1a?=
 =?utf-8?B?QW5MbWpYN2NmUXJ0NTR2b0lvb2VJY0lVVTdRdVFUYW4vWjlQeEs3eThFaytM?=
 =?utf-8?B?UkVWVTAvWGhnZkpIeUZVWjlXenVwQ04xMVJkdXBWTFV5NW1lZkFEMVVKS0Ez?=
 =?utf-8?B?QmdmZEoxWVAraUIxSWdjaWExL1hCS2trZ1g5cHBTR3BXd0p6NUJHM1NoUDBR?=
 =?utf-8?B?YTBORCt0UHVnZ0ZUVDhiMVIxaTBrSGdOcG5LM0dhSUF1Zkt3SHdzbUUzM3J3?=
 =?utf-8?B?MVZvR292YXozb0YrZWRzczJTVjVuR1Q4ZTkxSTdjR0NuOGEzci8vUFlZazlE?=
 =?utf-8?B?ZDB5blZGRlJRTGlQMU1ieFV0cUVzQTF4MEhBbU9NK29HdmhMN1RWT2lkanp0?=
 =?utf-8?B?UG9CMnMvUU9DM1pkSUhHSDlNTWFjZFVtbTN1blBzbTFqcHVjNVhIcFkrNE00?=
 =?utf-8?B?OVhvVDdkY29xSlFITlAwZzhSZk1FS0VSV0FTaXY4Q0NXOVhRVVBPUGhWalg5?=
 =?utf-8?B?azV2Q3pBeWlUOFQ2Q21id0Q4cWZoV211cWhYVVgreng1SGtKVlNmYUU3U3hs?=
 =?utf-8?B?SkJoVHMrN1lCMnFkZWxsVnF5VHFFNWovN2w5eUtPV0ZKeWhJSEptdkk3ck0x?=
 =?utf-8?B?b2xWZFZOTWdvQVNmOFc0THljYU1yeVJIRU90bWJPSG9RTk9tRGVqenVHOHlw?=
 =?utf-8?B?dFA1dW91Nnh6K201RGNyL0ZZQmZ1cXJad1NTSVdxYXBLa2Q4RlI0RDQzY0lC?=
 =?utf-8?B?NlJHdE53ZkpkUXlzdExTcVk5cFpQb2ZIVlBXRkMrbkgzUXk3MVd2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf48056-849e-405a-1e29-08deee78fb49
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 20:27:31.3858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJTRfgWHuYnNOgMNtbmQNFQwMQrQFGrrJzy5CC2uB3nFLLDQyt4lZ68ReG6qn3ThSlxDGKlk8VTr+cC7Mhryqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721
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



On 2026-07-30 06:59, Pekka Paalanen wrote:
> On Wed, 22 Jul 2026 09:45:57 -0400
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
>> v4:
>>  - Add limited-range YCbCr-RGB conversion matrix enums (Robert)
>>  - Document matrix values (Pekka)
>>  - Clarify RGB709 to RGB2020 is a full-range matrix (Pekka)
>>  - Fix confusing "CSC preset" doc (Pekka)
>>
>> v2:
>>  - Naming changes (Pekka)
>>
>> v3:
>>  - Fix NC matrix enum name and string (Melissa)
>>  - Rebase
>>
>> Co-developed-by: Harry Wentland <harry.wentland@amd.com>
>> Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>> Reviewed-by: Melissa Wen <mwen@igalia.com>
>> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>> Reviewed-by: Robert Mader <robert.mader@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_atomic.c      |   4 +
>>  drivers/gpu/drm/drm_atomic_uapi.c |   7 ++
>>  drivers/gpu/drm/drm_colorop.c     | 109 ++++++++++++++++++++
>>  include/drm/drm_colorop.h         | 159 ++++++++++++++++++++++++++++++
>>  include/uapi/drm/drm_mode.h       |  12 +++
>>  5 files changed, 291 insertions(+)
> 
>> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
>> index 682fcc651525..e7ccf7d053b8 100644
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
>> @@ -90,6 +91,17 @@ static const struct drm_prop_enum_list drm_colorop_lut3d_interpolation_list[] =
>>  	{ DRM_COLOROP_LUT3D_INTERPOLATION_TETRAHEDRAL, "Tetrahedral" },
>>  };
>>  
>> +static const char * const colorop_fixed_matrix_type_names[] = {
>> +	[DRM_COLOROP_FM_YCBCR601_FULL_RGB] = "YCbCr 601 Full to RGB",
>> +	[DRM_COLOROP_FM_YCBCR601_LIMITED_RGB] = "YCbCr 601 Limited to RGB",
>> +	[DRM_COLOROP_FM_YCBCR709_FULL_RGB] = "YCbCr 709 Full to RGB",
>> +	[DRM_COLOROP_FM_YCBCR709_LIMITED_RGB] = "YCbCr 709 Limited to RGB",
>> +	[DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB] = "YCbCr 2020 NC Full to RGB",
>> +	[DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB] = "YCbCr 2020 NC Limited to RGB",
>> +	[DRM_COLOROP_FM_YCBCR_LIMITED_FULL] = "YCbCr limited to full",
>> +	[DRM_COLOROP_FM_RGB709_RGB2020] = "RGB709 to RGB2020",
>> +};
> 
> 
>> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
>> index 224fae40ed2b..92eb6463c39f 100644
>> --- a/include/drm/drm_colorop.h
>> +++ b/include/drm/drm_colorop.h
>> @@ -134,6 +134,146 @@ enum drm_colorop_curve_1d_type {
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
>> +	 * Converts full-range YCbCr into full-range RGB using the BT.601
>> +	 * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
>> +	 * at 0 (the nominal 0.5 offset removed) before the matrix::
>> +	 *
>> +	 *   | R |   | 1.0   0.000000   1.402000 |   | Y  |
>> +	 *   | G | = | 1.0  -0.344136  -0.714136 | x | Cb |
>> +	 *   | B |   | 1.0   1.772000   0.000000 |   | Cr |
>> +	 */
>> +	DRM_COLOROP_FM_YCBCR601_FULL_RGB,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
>> +	 *
>> +	 * enum string "YCbCr 601 Limited to RGB"
>> +	 *
>> +	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
>> +	 * the BT.601 coefficients. Before the matrix Y is offset by 16/255
>> +	 * and Cb, Cr are centered at 0, following the studio-range
>> +	 * convention of ITU-R BT.601::
>> +	 *
>> +	 *   | R |   | 1.164384   0.000000   1.596027 |   | Y - 16/255 |
>> +	 *   | G | = | 1.164384  -0.391762  -0.812968 | x | Cb         |
>> +	 *   | B |   | 1.164384   2.017232   0.000000 |   | Cr         |
>> +	 */
>> +	DRM_COLOROP_FM_YCBCR601_LIMITED_RGB,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FM_YCBCR709_FULL_RGB:
>> +	 *
>> +	 * enum string "YCbCr 709 Full to RGB"
>> +	 *
>> +	 * Converts full-range YCbCr into full-range RGB using the BT.709
>> +	 * coefficients. Y is normalized to [0, 1] and Cb, Cr are centered
>> +	 * at 0 (the nominal 0.5 offset removed) before the matrix::
>> +	 *
>> +	 *   | R |   | 1.0   0.000000   1.574800 |   | Y  |
>> +	 *   | G | = | 1.0  -0.187324  -0.468124 | x | Cb |
>> +	 *   | B |   | 1.0   1.855600   0.000000 |   | Cr |
>> +	 */
>> +	DRM_COLOROP_FM_YCBCR709_FULL_RGB,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
>> +	 *
>> +	 * enum string "YCbCr 709 Limited to RGB"
>> +	 *
>> +	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
>> +	 * the BT.709 coefficients. Before the matrix Y is offset by 16/255
>> +	 * and Cb, Cr are centered at 0, following the studio-range
>> +	 * convention of ITU-R BT.709::
>> +	 *
>> +	 *   | R |   | 1.164384   0.000000   1.792741 |   | Y - 16/255 |
>> +	 *   | G | = | 1.164384  -0.213249  -0.532909 | x | Cb         |
>> +	 *   | B |   | 1.164384   2.112402   0.000000 |   | Cr         |
>> +	 */
>> +	DRM_COLOROP_FM_YCBCR709_LIMITED_RGB,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
>> +	 *
>> +	 * enum string "YCbCr 2020 NC Full to RGB"
>> +	 *
>> +	 * Converts full-range YCbCr into full-range RGB using the BT.2020
>> +	 * non-constant luminance coefficients. Y is normalized to [0, 1]
>> +	 * and Cb, Cr are centered at 0 (the nominal 0.5 offset removed)
>> +	 * before the matrix::
>> +	 *
>> +	 *   | R |   | 1.0   0.000000   1.474600 |   | Y  |
>> +	 *   | G | = | 1.0  -0.164553  -0.571353 | x | Cb |
>> +	 *   | B |   | 1.0   1.881400   0.000000 |   | Cr |
>> +	 */
>> +	DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
>> +	 *
>> +	 * enum string "YCbCr 2020 NC Limited to RGB"
>> +	 *
>> +	 * Converts limited- (narrow-) range YCbCr into full-range RGB using
>> +	 * the BT.2020 non-constant luminance coefficients. Before the matrix
>> +	 * Y is offset by 16/255 and Cb, Cr are centered at 0, following the
>> +	 * studio-range convention of ITU-R BT.2020::
>> +	 *
>> +	 *   | R |   | 1.164384   0.000000   1.678674 |   | Y - 16/255 |
>> +	 *   | G | = | 1.164384  -0.187326  -0.650424 | x | Cb         |
>> +	 *   | B |   | 1.164384   2.141772   0.000000 |   | Cr         |
>> +	 */
>> +	DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FM_YCBCR_LIMITED_FULL:
>> +	 *
>> +	 * enum string "YCbCr limited to full"
>> +	 *
>> +	 * Converts limited- (narrow-) range YCbCr into full-range YCbCr.
>> +	 * Though not strictly a matrix operation it can be represented as
>> +	 * one. Luma is expanded by 255/219 and chroma by 255/224, keeping
>> +	 * the black level (16/255) and chroma neutral point (0.5) fixed::
>> +	 *
>> +	 *   | Y'      |   | 1.164384  0.000000  0.000000 |   | Y - 16/255 |
>> +	 *   | Cb'-0.5 | = | 0.000000  1.138393  0.000000 | x | Cb - 0.5   |
>> +	 *   | Cr'-0.5 |   | 0.000000  0.000000  1.138393 |   | Cr - 0.5   |
>> +	 */
> 
> Hi Harry,
> 
> the prime notation (Y') is often used to signify an electrical domain
> while in the same context stimulus variables without prime signify an
> optical domain. Using both forms here might cause some confusion.
> Instead of an equals sign, maybe you could use an arrow to avoid having
> to rename all YCbCr variables? (e.g. x ← x + 1)
> 
> About the chroma offset for both ranges on all coefficients; it depends
> on the number of bits per channel B such that
> 
> 	N = 1 << B
> 	offset = (N / 2) / (N - 1)
> 
> I assume the drivers and hardware get this right, but I feel a little
> uncomfortable letting this approximation into the documentation since,
> strictly speaking, it's incorrect.
> 

I'm dropping DRM_COLOROP_FM_YCBCR_LIMITED_FULL and DRM_COLOROP_FM_RGB709_RGB2020
from v5 because we don't have any good non-IGT usermode testing these currently,
to my knowledge.

Chaitanya, I expect you'll re-add them for your Intel series. Make sure to take
Pekka's comments into account then. Would like to see how these fit into any
compositor implementation.

Harry

> 
>> +	DRM_COLOROP_FM_YCBCR_LIMITED_FULL,
>> +
>> +	/**
>> +	 * @DRM_COLOROP_FM_RGB709_RGB2020:
>> +	 *
>> +	 * enum string "RGB709 to RGB2020"
>> +	 *
>> +	 * Selects the matrix that converts full-range RGB with BT.709
>> +	 * primaries to full-range RGB with BT.2020 primaries. The
>> +	 * coefficients match the RGB-to-RGB conversion defined in
>> +	 * ITU-R BT.2087::
>> +	 *
>> +	 *   | R2020 |   | 0.6274  0.3293  0.0433 |   | R709 |
>> +	 *   | G2020 | = | 0.0691  0.9195  0.0114 | x | G709 |
>> +	 *   | B2020 |   | 0.0164  0.0880  0.8956 |   | B709 |
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
> 
> I have verified all the matrices listed above.
> 
> I would prefer to see the notational issues addressed, but with or
> without:
> 
> Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> 
> 
> Thanks,
> pq

