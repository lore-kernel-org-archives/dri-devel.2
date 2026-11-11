Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF69606A33A
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eMw+WO8W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32CDF10FA61;
	Wed, 11 Nov 2026 09:39:57 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8EAD10FA30;
 Wed, 11 Nov 2026 09:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuUVjhzjMTPvmxbkAKZRMdQSaAQmmAtcMqalyYIL4x9fFWDHOSvbT0wNixeKAGs5lt1ERQKLi1eC0Sr2hvBhakJYO3CTFkNm80cHKKf/lPlXTjpB28ihcJqWzilEj7FlFDQemgLc65XPUqb/Y1V51sbx9e1mOUcjHjbPTmKq+MdJrVFg3tUlsEXs/kPRZcMeVXvlhc+uILiRquTZMgEEwErzpn0kEXAecaC+A/rI8OaOlb6Hbsv/7zadFomhIMkH/NmdFQ6TQM0tF9AZ/MWJMprvGzU4cHoKsSGrdD6l650E46uvlQoBIcGC+scvRkW0uI9HBqCIgZnKlZIT5vhZFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2FPxoJNWaKDQy4+r4KNmMjOyvKqcAfha4gtN9JkWR4=;
 b=EDhNKOruUDriqtRuwLwf3nxdaW3mcaPtRr0cXXaEPXujZ7fbDdKYRFphZjNkh7q8022rDnELzWxK4CNY5Doc3H8kl+7k5X2MNQijQinuIAzxy08cMYAIWbc7h542OXVrLIU8wLK3eA7rWYjFFNhVqOEMzRzNXumhvMMnMqdPi+BDdNHgSKi+99Awnvnn+cml4WWH9Sp2Vu3FlVv86TSiim/qAc2f6u0ay15MgJP5XuCOaoac9dSb8GQl37+D+H6WoVLlRgNdchn6EAsry08zLxuVN7s/9sBb7oLip0ZsVG0TgFMsAYdJqJ8HMvO1q6n8E4JaD0RwhyZ3pCw0Up/taQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2FPxoJNWaKDQy4+r4KNmMjOyvKqcAfha4gtN9JkWR4=;
 b=eMw+WO8WVyeU5P8fCCHPlNU2LlWxcxYILJ0dq8nF6mhaLLFGN0oHbBC31SdnwWjGYYvJ2+nd+pNw3VIeOFv2OjxQSTVsepNszCiLFbP6LSrgLjcbq3m+jZk7SG+8G2y64cFDQHd1voxExEpd5/s0blbVwEKkTvNJRDmCawPcNsM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by CH1PPF73CDB1C12.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::615) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:39:44 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%6]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 09:39:44 +0000
Message-ID: <7e02d6ff-4278-4d57-90fc-97d7fd665b02@amd.com>
Date: Wed, 11 Nov 2026 17:39:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] drm/amd/display: Add KUnit tests for the ATIF
 backlight curve check
To: Hugo Sales <hugo@hsal.es>, harry.wentland@amd.com, siqueira@igalia.com,
 amd-gfx@lists.freedesktop.org, sunpeng.li@amd.com, alexander.deucher@amd.com
Cc: mario.limonciello@amd.com, christian.koenig@amd.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 simona@ffwll.ch, alex.hung@amd.com, airlied@gmail.com
References: <20261104-backlight-curve-validate-v1-0-10c688880e85@hsal.es>
 <20261104-backlight-curve-validate-v1-2-10c688880e85@hsal.es>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20261104-backlight-curve-validate-v1-2-10c688880e85@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0018.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::19) To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|CH1PPF73CDB1C12:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d871dd-8b90-4740-d45b-08df3fd7b7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|4143699003|10067099003|11063799006|261026140227099003|261102123227099003|261028144727099003|261022075727099003|261021121427099003|56012099006|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Yj6OSVABA+O60f9/U4m7Cz8b8Wl80F3TYy4XiPTo5g2GprEo0GvIvCzd5nki8WGrkTEGbFOesPEHPhbhxGrgqRz7RnnnGXyw8SNfEulW8ZnhTFlhbZtBJcXbHqKhDwH+63IbJFsMIofHqlfUVE9BT2MSLLjF1ejkY1OTNoHzLw4NO9+Qch6axAHumk3h0HqWoqXIuAw1+8YUR3hiyV32iQnW704phSt7cXmh1QcAFYPl3/+YJzoTywVYBs3TM5UTB8W1Hl7rMDG3pYoY/CmlbJDaGbnPupOxnbb7K45K3k8OgX8oQkNA8P1L2FTzrdwl8f6213dv2hUw6QpG8yhFGnLk/UM8TKpvKDLYToM6irD4jyAIyxo8s8BizLFP2CsqkPEcPccflKx7pWqtt6JdG1DYMwPIGfZ9IXyPr0wnUjLg7XqA/7u9TziWPylop04EJRiIeg28TjEMpr9xbjW/C+/O4qGkF/gdll5Y2SQZzkRVKXOiWww9Drx/EVpWUh83ZGe9KOPex85ZroO7wICU/iPKmenJgxEaulMnLMfHN7ZFU20ukVVCKXgxYFAByiRJYJJV5ixfS1J9HzIbT5BwVWf2RNdrJjNH/UCgUsABMBXelTG4W903t1rsHEtZqGZQI5UCjhGdhlfOvc55u31iqNHxfOMX0WnDqJEYyyFeS3E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(261026140227099003)(261102123227099003)(261028144727099003)(261022075727099003)(261021121427099003)(56012099006)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXJ5VjJkMU1lbVFLVzFvZm9NQzJOdllNSkt3dy9FRGJGYXMzbi9IdEhKblZK?=
 =?utf-8?B?bVdVQlZHOWMyZFM0VU01MlNkclpCNkM2N3NIaHcydFJNWlliREpmM1NsQXRv?=
 =?utf-8?B?NWIwV0h2aUlKRjFjREROem9qZFRDQ0ZPUjdHUWlMck5WS0pGNWtxcTg3WS8y?=
 =?utf-8?B?Y2pUR2I4L0NQMU1iYlNjRjNDdS9qdzN1WVBoZktVVEFiRFVVUG11ZktrejRV?=
 =?utf-8?B?Nnk4TnVpQXFmNm0yUnhnR2ZSNjFPUUYrYnNPNnRYdmRUekxTVDdudDFBd1VI?=
 =?utf-8?B?dEtnK0tpVFBjT0d1VGdFeFdIWnBEZEM2MVp6OWorcTNWZHp6d2lyTkw3ZFVt?=
 =?utf-8?B?NXlwNXNnWThERDd3bVhZY3E1b296NENSbkR2THFHdkkwOFVmZDhpaFVrQ0RK?=
 =?utf-8?B?cEgwckZTNzFySVdtdVQwMW11bDVCdSswS0F2bkptQ3lSZTNzOUFmMXA1OTNV?=
 =?utf-8?B?UEtpVGFqdUl5NXpoSDNWT1dMN3crbjFzcFIwTTFTQ21ZQXNNWUR2b3Jtdndo?=
 =?utf-8?B?QjNmZ0MwSDNxL2NEc2lEb1Z5YkNHV0VZN1hsV09aS3ZTUzhJVU9DdVZKSnBY?=
 =?utf-8?B?OXNxVVNmRUpaNTMyU1k0RGNkbU9FQ3JwQyt2VDh4NDFFaC9LWG45TytqQklF?=
 =?utf-8?B?bk5jUUx2RDZGeDdEdWRqRWhxMnpwcjVpdloxZVpWTSttNytOTHhtcDJuRm1E?=
 =?utf-8?B?L2hERndsMTVINkNHU25CQUhzRmsxdEtESEpYK1FiZFM5ei85U2VUejZ5SWxM?=
 =?utf-8?B?eUZIYjVWUU12Z2RQeXRpMkl6SDJma1pxRTNJQ3NlMW9xSzZ3dEdzdXdSbVJO?=
 =?utf-8?B?dE5zaE5YTnNPZGVHMHlDQ0p2d2d0SUxuNlNvVGlJS2RwQkJ5V3Q0QU1DWkZr?=
 =?utf-8?B?Q1BiU3lJRGRoNEI3WXdrYmFWeFg1SXBBTGxIRjBMK0dPdGhHR0xuQkRTTElX?=
 =?utf-8?B?dVYvZ1luT3NnL1dDV1ZSbFJma3E0ZjBDNGlzaWFONmYyU3FVWVBibWxTMTRX?=
 =?utf-8?B?eFJMdjZhVzVIMkRQeUpGVlE5cUhFQktodXlmL0psRkNsb0NveHBBSEF3ODVV?=
 =?utf-8?B?bWdjVC8rK25SanlQaU96Sm8xTDRWcU9oOWc0R3dLc2dUSjUzZTZhN1NIZmU1?=
 =?utf-8?B?NEN4eTJaeU9JaTZQYVpDT094Wm5CRG1SZFJQdjE1RzJQbVAycmlRc1F1SzNJ?=
 =?utf-8?B?MWg2cUcwbXZ2MklXTlFjTmF1amg2V3NLb21xSmt1VVZZTHRQUk5aMXQvNE5l?=
 =?utf-8?B?STdQYytFNGp3UDJlV0d5YVpPUkpvSGQwWkNMdGRGcGMzWGZhcVRrb1Y1OGZL?=
 =?utf-8?B?RUhZZEtKQzJ1eDQxL3RGUmw4NDhud1p3NXMvN2ZkZ1l2dnJlUDdBRWxzeUFY?=
 =?utf-8?B?R1FrWUhKM0ZoTlFzYlFaMkNQVmZEQXVGMWtCUlNoZld3L0h4dm5UWjBSMUtu?=
 =?utf-8?B?RUdVdkFYd2dqYTd0aTFmc2dDM3hmK09UZFZFS0RtdDVCMllCNVp5eG9aTUFY?=
 =?utf-8?B?a1p2RmtvaVF6UFVLdzQ3NmdnYXRTL1lER2VJa3RqaEg2T0xITmxPVHArQkxw?=
 =?utf-8?B?R1B0ay9rd1JUL1pIMDkwMDBmeW1iOHhFQ1RQS25NMzFYZXB4VEJsajl4N1Vr?=
 =?utf-8?B?d3dzdDhQMm52TjhnY1FLdVYzNDluTFFtRGszN3Bia0o4VDZ2VnNzN1h1Qkcx?=
 =?utf-8?B?RHdzTDkvQ2piYnE2QkFJNTNUblNqUHBkWW5JVG9mVFJlSVB3VUdBY3RtblNM?=
 =?utf-8?B?c2hxN3k1YnhFM2hvbmI5NVVQblBiTDhEZ2t0Y3ZCTjRWbnBoRlV6dUU4cTFi?=
 =?utf-8?B?VHdmQlJQQUhwUWpPTndYU0xYSjg1T0o1cXhuNitKSnZoaXJQQy9UVlZVWUFZ?=
 =?utf-8?B?NzV6eHZBSVQ5dzMzWlBJSTUzNWU4ZCtmOWc4RFV4S0Y1SDQ5d0JoNWRFTjRh?=
 =?utf-8?B?ejJWRm9yb2xpU3RFS1JQMzc0SmJzakswYVd4VXZWa0p0N2tnZUNvd2JYd2Fp?=
 =?utf-8?B?T0wzTG1QV2ZGZU5lRVl0OTFoUWE3cWpWcWJaSlI4TjlGQkxUVEttOHBUaTgv?=
 =?utf-8?B?UVNhT00vS1g4Y0RWVGpocmgwUjlqUkhaWGNBcWRlN3JWbElobEIxQTlGR3J6?=
 =?utf-8?B?ekp4SXg2czNCZldKdUE3eG5BdC9obkQ0WHpZRlBuUVM4V3R6MG45SWYyc2hy?=
 =?utf-8?B?Y1VXcXk4Rm0vOVFld09TcE9LeUxXSHJmUWl5b2w3ZmtTdG9OS3U5OWN1QTBN?=
 =?utf-8?B?b2J3S3dFejRIM2JNU1p5UVFyaDB0eEttWWQ1TDJjaldvQW5HazRBYVlrQk8x?=
 =?utf-8?B?dk1ORmJ4REJDSFNjN1JJbVhPdmhLR2d0b3hZR2t1Y1RRb0xJeThFUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d871dd-8b90-4740-d45b-08df3fd7b7c2
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:39:44.5992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+zqH/7XNiBvhKtMLHPl+IZiYbQaME04dXFHMf5I8KgqJYOMHCu/XlxCj9Fak2L7QqIGJuTT+JuswX7GiugvoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF73CDB1C12
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

Hi Hugo,

Thanks for this.

With the backlight update in the other thread, amdgpu_dm no longer maps
brightness through the ATIF curve; only the power module uses it, and it
validates the curve itself. So 1/3 and 2/3 are no longer needed. I have
replied to 3/3 with my Reviewed-by.

Thanks,
Ray

On 11/4/2026 6:31 PM, Hugo Sales wrote:
> Test the curve check in amdgpu_dm_validate_backlight_caps():
>
> - the GV301QH curve stays as it is
> - a luminance over 100% becomes 100%
> - a falling luminance rises to the point before
> - a curve whose signals fall gets dropped
> - a repeated signal stays
> - a curve with more points than luminance_data holds is cut to fit
>
> Also check the brightness the PWM and AUX paths give on the checked
> curves
>
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> KUnit: dm_test_validate_custom_curve_unsorted and the luminance checks
> in the falling test fail without patch 1
> ---
>   .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 184 +++++++++++++++++++++
>   1 file changed, 184 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> index b3e6a96320164..d76527e49acf2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> @@ -1696,6 +1696,185 @@ static void dm_test_brightness_curve_pwm_luminance_over_100(struct kunit *test)
>   	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(&caps, 225000), 255000U);
>   }
>   
> +/* Tests for the custom curve check in amdgpu_dm_validate_backlight_caps() */
> +
> +static struct amdgpu_display_manager *alloc_validate_dm(struct kunit *test)
> +{
> +	struct amdgpu_display_manager *dm = dm_kunit_alloc_dm(test);
> +
> +	dm->adev = dm_kunit_alloc_adev(test);
> +	/* drm_warn() prints the curve warnings against this device */
> +	KUNIT_ASSERT_NOT_NULL(test, adev_to_drm(dm->adev)->dev);
> +
> +	return dm;
> +}
> +
> +static struct amdgpu_dm_backlight_caps *
> +validate_custom_curve(struct amdgpu_display_manager *dm,
> +		      const struct amdgpu_dm_luminance_data *points, int n)
> +{
> +	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
> +
> +	set_custom_curve_caps(caps, points, n);
> +	caps->caps_valid = true;
> +	amdgpu_dm_validate_backlight_caps(dm, 0);
> +
> +	return caps;
> +}
> +
> +/**
> + * dm_test_validate_custom_curve_gv301qh - Test a good ATIF curve is left alone
> + * @test: The KUnit test context
> + *
> + * The GV301QH curve rises and stays within 100%, so the check must keep
> + * every point as it is
> + */
> +static void dm_test_validate_custom_curve_gv301qh(struct kunit *test)
> +{
> +	struct amdgpu_display_manager *dm = alloc_validate_dm(test);
> +	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
> +
> +	set_gv301qh_caps(caps, false);
> +	caps->caps_valid = true;
> +	amdgpu_dm_validate_backlight_caps(dm, 0);
> +
> +	KUNIT_EXPECT_TRUE(test, caps->caps_valid);
> +	KUNIT_ASSERT_EQ(test, caps->data_points, ARRAY_SIZE(gv301qh_curve));
> +	KUNIT_EXPECT_MEMEQ(test, caps->luminance_data, gv301qh_curve, sizeof(gv301qh_curve));
> +}
> +
> +/**
> + * dm_test_validate_custom_curve_luminance_over_100 - Test ATIF luminance over 100% becomes 100%
> + * @test: The KUnit test context
> + *
> + * Points (100, 50), (200, 150) and (250, 120) become (100, 50), (200, 100)
> + * and (250, 100). Level 150 is then 50 + 50 * 50 / 100 = 75% and level 200
> + * is full brightness. Over AUX, 301176 of 512000 is just below signal 150,
> + * so it lands one below 75% of 1000..512000, at 384249
> + */
> +static void dm_test_validate_custom_curve_luminance_over_100(struct kunit *test)
> +{
> +	static const struct amdgpu_dm_luminance_data points[] = {
> +		{ .input_signal = 100, .luminance = 50 },
> +		{ .input_signal = 200, .luminance = 150 },
> +		{ .input_signal = 250, .luminance = 120 },
> +	};
> +	struct amdgpu_display_manager *dm = alloc_validate_dm(test);
> +	struct amdgpu_dm_backlight_caps *caps;
> +
> +	dm_test_enable_custom_curve(test);
> +	caps = validate_custom_curve(dm, points, ARRAY_SIZE(points));
> +
> +	KUNIT_ASSERT_EQ(test, caps->data_points, 3);
> +	KUNIT_EXPECT_EQ(test, caps->luminance_data[0].luminance, 50);
> +	KUNIT_EXPECT_EQ(test, caps->luminance_data[1].luminance, 100);
> +	KUNIT_EXPECT_EQ(test, caps->luminance_data[2].luminance, 100);
> +
> +	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(caps, 150 * 0x101), 49151U);
> +	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(caps, 200 * 0x101), 65535U);
> +	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(caps, 150 * 0x101), 75000U);
> +	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(caps, 200 * 0x101), 100000U);
> +
> +	caps->aux_support = true;
> +	caps->aux_min_input_signal = 1;
> +	caps->aux_max_input_signal = 512;
> +	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(caps, 301176), 384249U);
> +}
> +
> +/**
> + * dm_test_validate_custom_curve_falling - Test a falling ATIF point is raised
> + * @test: The KUnit test context
> + *
> + * In (50, 30), (100, 60), (150, 40) and (200, 80), the point at 150 is
> + * raised to 60%, so the curve is flat from 100 to 150. Level 125 is 60% on
> + * both paths, which over AUX is 307600 in 1000..512000
> + */
> +static void dm_test_validate_custom_curve_falling(struct kunit *test)
> +{
> +	static const struct amdgpu_dm_luminance_data points[] = {
> +		{ .input_signal = 50, .luminance = 30 },
> +		{ .input_signal = 100, .luminance = 60 },
> +		{ .input_signal = 150, .luminance = 40 },
> +		{ .input_signal = 200, .luminance = 80 },
> +	};
> +	struct amdgpu_display_manager *dm = alloc_validate_dm(test);
> +	struct amdgpu_dm_backlight_caps *caps;
> +
> +	dm_test_enable_custom_curve(test);
> +	caps = validate_custom_curve(dm, points, ARRAY_SIZE(points));
> +
> +	KUNIT_ASSERT_EQ(test, caps->data_points, 4);
> +	KUNIT_EXPECT_EQ(test, caps->luminance_data[1].luminance, 60);
> +	KUNIT_EXPECT_EQ(test, caps->luminance_data[2].luminance, 60);
> +	KUNIT_EXPECT_EQ(test, caps->luminance_data[3].luminance, 80);
> +
> +	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(caps, 125 * 0x101), 39321U);
> +	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(caps, 125 * 0x101), 60000U);
> +
> +	caps->aux_support = true;
> +	caps->aux_min_input_signal = 1;
> +	caps->aux_max_input_signal = 512;
> +	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(caps, 250980), 307600U);
> +}
> +
> +/**
> + * dm_test_validate_custom_curve_unsorted - Test a curve whose signals fall is dropped
> + * @test: The KUnit test context
> + *
> + * A signal below the one before leaves no curve, so the mapping is
> + * linear. A repeated signal is a step: the curve stays, and level 100 is
> + * at the later point's 60%
> + */
> +static void dm_test_validate_custom_curve_unsorted(struct kunit *test)
> +{
> +	static const struct amdgpu_dm_luminance_data falling[] = {
> +		{ .input_signal = 100, .luminance = 40 },
> +		{ .input_signal = 80, .luminance = 60 },
> +	};
> +	static const struct amdgpu_dm_luminance_data repeated[] = {
> +		{ .input_signal = 50, .luminance = 20 },
> +		{ .input_signal = 100, .luminance = 40 },
> +		{ .input_signal = 100, .luminance = 60 },
> +	};
> +	struct amdgpu_display_manager *dm = alloc_validate_dm(test);
> +	struct amdgpu_dm_backlight_caps *caps;
> +
> +	dm_test_enable_custom_curve(test);
> +
> +	caps = validate_custom_curve(dm, falling, ARRAY_SIZE(falling));
> +	KUNIT_EXPECT_EQ(test, caps->data_points, 0);
> +	KUNIT_EXPECT_EQ(test, convert_brightness_from_user(caps, 32768), 32768U);
> +
> +	caps = validate_custom_curve(dm, repeated, ARRAY_SIZE(repeated));
> +	KUNIT_EXPECT_EQ(test, caps->data_points, 3);
> +	KUNIT_EXPECT_EQ(test, convert_brightness_to_millipercent(caps, 100 * 0x101), 60000U);
> +}
> +
> +/**
> + * dm_test_validate_custom_curve_too_many_points - Test data_points is cut to the array
> + * @test: The KUnit test context
> + *
> + * data_points is a u8 from firmware, so it can claim more points than
> + * luminance_data holds. The check keeps the points that fit
> + */
> +static void dm_test_validate_custom_curve_too_many_points(struct kunit *test)
> +{
> +	struct amdgpu_display_manager *dm = alloc_validate_dm(test);
> +	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[0];
> +	int i;
> +
> +	set_gv301qh_caps(caps, false);
> +	for (i = 0; i < ARRAY_SIZE(caps->luminance_data); i++) {
> +		caps->luminance_data[i].input_signal = 2 * i;
> +		caps->luminance_data[i].luminance = i;
> +	}
> +	caps->data_points = 255;
> +	caps->caps_valid = true;
> +	amdgpu_dm_validate_backlight_caps(dm, 0);
> +
> +	KUNIT_EXPECT_EQ(test, caps->data_points, ARRAY_SIZE(caps->luminance_data));
> +}
> +
>   /**
>    * dm_test_brightness_range_zero_signals - Test Brightness range with zero min and max signals
>    * @test: The KUnit test context
> @@ -2365,6 +2544,11 @@ static struct kunit_case dm_backlight_test_cases[] = {
>   	KUNIT_CASE(dm_test_backlight_caps_aux_support_noop),
>   	/* amdgpu_dm_validate_backlight_caps */
>   	KUNIT_CASE_PARAM(dm_test_validate_backlight_caps, dm_validate_caps_gen_params),
> +	KUNIT_CASE(dm_test_validate_custom_curve_gv301qh),
> +	KUNIT_CASE(dm_test_validate_custom_curve_luminance_over_100),
> +	KUNIT_CASE(dm_test_validate_custom_curve_falling),
> +	KUNIT_CASE(dm_test_validate_custom_curve_unsorted),
> +	KUNIT_CASE(dm_test_validate_custom_curve_too_many_points),
>   	/* get_brightness_range */
>   	KUNIT_CASE(dm_test_brightness_range_null_caps),
>   	KUNIT_CASE(dm_test_brightness_range_pwm),
>
