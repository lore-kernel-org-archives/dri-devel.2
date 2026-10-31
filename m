Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7C0606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 02:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TKgmZH7Q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCDB7112A82;
	Sat, 31 Oct 2026 02:17:29 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16981112A83;
 Sat, 31 Oct 2026 02:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWCzjnlkpoPho8ZMM3ie8KkyRlzQ9j+JD2iJ+u0zaAWRXYPwO4oNly3KWyOoR/cr/LuvzJ0fw4ogDhRXU+uIr4Cm2CYaoXSIRwWlkWH/MSiRAGrLZI55U12BTYqyBpLomf8HFlRKtr5YA7Ar7+4w5iznxtmso4TldMiEiWc5E2nhgCdOxWMhIvd72ySt1x+sUa9uz7IjCRjvpbmG319JCqL3XwQx7Ts3q7I87PFJEv6LH3e6xZa6Z60u9PTr3oYp7TXoAk7BhzKOkRc3YvApJqqsyPtBTGa/3FNa5CNG6Wk1OfufOduAURbBBTWYJjus9BEfs99Jwi1ycqfoxWqZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlT6WK9EfQeokNIBVCcvYnEnzyHSTuM3E/ZZQBVosGg=;
 b=ARkxAQ00EaAwqh2+tfvx+GSLeJrarF94PZktns7t4iW7WnE9IA2yJVezDzhpd9NdxwDtU8d1A29pOYpJdcQaOqC9QxsdC6RUEIyEcDQGO+BvwP3gAcLLLRgTGHFYos3/nV8cxpxyX6IeFfPWYn5uNqumOvf0+Mq4Qi2hqsPE+4wR8J9GspxXHnBUE0Yob+p9eejiyAsiCJPmYEVPcAyBEz1+Hwavs54Ci6kQjmxbsme8t1gbNHlLQ7fMrIzl2iXC88aysnhXEWUyFZZiMBNiSYFtSrVqZIK1HscUoFYe82Zd9xKSfx2vHveY9W3IevwFIJqnlsfP3qVzGg7yQv06ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlT6WK9EfQeokNIBVCcvYnEnzyHSTuM3E/ZZQBVosGg=;
 b=TKgmZH7QgiZuaLd/oI2vlMZIviITJyspImBK0E18RW4AqKO7z9ULJ324cmvnMN8Z1c9Fgh/FJkUG4zIMyQsV6+QSxCcBjr9uKQ885EsJFStQuecaRBD7euuPRE+vcDhkUaZEo/jIu8vNpgqUp3ANAyHkgz0iTrjyY64fL1xm5kA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18) by CH3PR12MB647349.namprd12.prod.outlook.com
 (2603:10b6:610:365::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 02:17:13 +0000
Received: from CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26]) by CY0PR12MB226969.namprd12.prod.outlook.com
 ([fe80::f47a:5d4e:f3d5:5b26%4]) with mapi id 15.21.0569.009; Sat, 31 Oct 2026
 02:17:13 +0000
Message-ID: <c50b5e4c-9b6c-4cbf-ada4-cb2ddc444b80@amd.com>
Date: Fri, 30 Oct 2026 20:17:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amd/display: Add KUnit tests for the eDP/LVDS
 native mode fallback
To: Hugo Sales <hugo@hsal.es>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, "Chung, ChiaHsuan (Tom)" <chiahsuan.chung@amd.com>
References: <74c73b6f-a6b3-4652-8da1-b5c46ae58809@amd.com>
 <20261024163347.2413649-1-hugo@hsal.es>
 <20261024163347.2413649-3-hugo@hsal.es>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261024163347.2413649-3-hugo@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::18) To CY0PR12MB226969.namprd12.prod.outlook.com
 (2603:10b6:930:130::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY0PR12MB226969:EE_|CH3PR12MB647349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f20fcd3-b7d8-4c83-a290-08df36f51385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261022113327099003|261026140227099003|261026121527099003|261028144727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: d7HKnWlAo+X/bsBpKwi/1yqyF72FJ8oaYtwNKs076xyYkqrURMiLDDrf5/3I/gXpgr1OnyBQnvVVL3K9gkwNBJKneJjYCkWSfcwCHmZ9E6xc9q2uvPfXv2JnfqIzKWfJ0j8vjJ2Owfj41fmfGTC0aPZsG1Oz8AXNOc1oMn+B1CxkKyKPlEdVQGgHNDHdmP93hx9+55wrenyMBof0cjdN9zPWxuKZ/GSLgxO16hR4N5CRtszEIv8j3vOssT41ScVVSAHYIidmbKFcjNFEhGzBSz02Xzu6cgagCS2a52FR8M3AWEbjO5PB76O6Mrj6+ySLKYoZht2AI4saMdzZRRPPmDGmRq1zaJHMt+o2Sp3M5lcnbJbCjiXLq5MfXST00pYssOaLzw+6oNAyrPvU3+bB6G3M4X/5L4FjXF5WjopOPF4/Q5Q0QYOYOCqu9hltj4cr76p93R3Nh6L63caXUVFDqlEsW3utdrko+/1V5wGnTJzT9bUW1leT1jcf+UObpIv6Z847d0ZaB/rK9Wxf/UiuBTCtdZ9gztds3bImnk2hpEEwwWIx2Kyx5xdYo8yulMekP0dffm1gRkwGB85ks41Nnq/+QWVDMRTd1BNnFkwFFosl+in9qTzwmHXsdbo6U2iH8E/D7Fd4JEIdPTpQVm1Ke+MRkE3ceV8/52WBGanVNvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY0PR12MB226969.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261022113327099003)(261026140227099003)(261026121527099003)(261028144727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHY5ZW1ETkhPWmo2UWxoNkNZcXdqVnNuVUtzc2FjVmovTGkyV2dUT2R5OExi?=
 =?utf-8?B?NHZOMzNpVS9Rak9lZ29YK0pLWnBUN1JPK0hyMkExaExjalV0TDhhWFR4alo1?=
 =?utf-8?B?cEl0aElmNzRyb0YwaTNvczhoNVFYNGxZTEVGUkFRSTBsYmRORis4TlZUa0po?=
 =?utf-8?B?enJxTTZ5ZGM1bENxKzkzQUcxSEVrb3ZTSTZVbkFNWGE2amJEdEE1TVNMeW5i?=
 =?utf-8?B?d3ZHeWVFTnlSUXdUMEtjUzh5T2lUeHgxSm9pOU1neFBwWmUzTSs2THpCZzBa?=
 =?utf-8?B?T0oxVTFkcFhxUUl1alJJMFZRVlNiOC9rR2xLaWtSUkRRb0FYVjBNdXF4ZUxN?=
 =?utf-8?B?NWRRemtWOGJZekIwUFVLR1JVK3pzWnQxWmVHN1o0SGNlQytxNWNMM2lpajhN?=
 =?utf-8?B?dnMzaWxYVjNDY0lsYWVXbWxBc0YvektvaE42SWl1aWZPeERPWFZSRUxTb3ZS?=
 =?utf-8?B?R0FjTjBMbVl2VG4raFhPT2dRVTVPV2p4K01xRFEzVUtiSlBGRFlyV0J5OHRt?=
 =?utf-8?B?dDZzem5CNFdkSEtsYi9oQWVPeWNhSzJTbzJ0TUhKY01FOG9zWWZFazhvbmgv?=
 =?utf-8?B?b3I0L3AxL2t4bWg5a3JUcjhVSlQ4UEYxS0dSV2hEbzJXNnlSYkxMRXBRcjNp?=
 =?utf-8?B?ZEpBR0NwSm1yVmY5c0s5OTF6bldyVVFVQXcyQ0JLMlZtVGRZSG5uUGdBR0VD?=
 =?utf-8?B?dm1Jcy8yTXpCZlRJT3FmdU5jY0xFS0htQmpqd0ZoelYvdytDdnNNOUx2b0tC?=
 =?utf-8?B?eVdqKzNvK3VzaEk4SzB6K2I0TlZzc2ZJM1RZZEdheTkzNlVzZnY3bWpDY29K?=
 =?utf-8?B?Wk1WWUR4QU9kWFdRWFZra2RnMjk3TUhLSytUQ3BvZDFUQ3pGM3E2VXpSUGk3?=
 =?utf-8?B?aFhGbUhoL2lZaEVyaHVBZjhvNlVxUHNXNmdHM3QrSE5Ld2NoTVM5QUhXUXZu?=
 =?utf-8?B?Mi9iNmVjVjhmL2VYSm5IS2NwVFRNQk8zY05VQVRSanNZcXE4L2FtbFBROVZG?=
 =?utf-8?B?UmpIQ0NiOHFHR3MwNHV4MFp1M3ZqSnVHVGgvNVI3NGxSQ20yOHhLOHViU3lj?=
 =?utf-8?B?alRuYlY4a3BtUnc4QVRyYkk0M0JndW5nb0J1ZElyVzhNRTUxenErMkFlbzNn?=
 =?utf-8?B?Vk1rRlBJY3Z4SkxiZVVwVjFmU2l6NG9WVll1U0MrYjZpZThOOW1KWkJ5cDVk?=
 =?utf-8?B?cjZqNEVRQUl3N1pSa0h3QXNpeEJZNHRkQUxQdGtvOXROcmg1WVFuY1U3WXRl?=
 =?utf-8?B?VThzZEdUNTdIMFZES0ZpMjBuVTVlTnJGYmNnNkJZYW91c28wVUZ3MzQ4V1Fo?=
 =?utf-8?B?RjFza3FWNDZGN3BJOEFiNHZKYmhDck9LRTBGWGxrTzYwRGM5T08ySFJaZDky?=
 =?utf-8?B?Zm1jQUVlTGo1eEhvUUh2SGh6WFBXRkJzWk9lQW1wcSt3TnJHeCtDdVlqVjFC?=
 =?utf-8?B?by8ra3o3KzVGdEVpMDAwNUdXOU9mOUN5cU52eTNSMWNkRnp6aGtFdUJUVFA0?=
 =?utf-8?B?aWZUSE0wUUVKdHNLeU1LRXhmazVxSzR1MlFQdWNTWHYvcjd5OHVMQ2l3V015?=
 =?utf-8?B?WVA5NEF1bE1yRktkaExGM2ZDdXpRNFRMNDI0Y0ttc3FFc3BxRmR2WGoxa3pM?=
 =?utf-8?B?NW1QL1B3RjlFYStsbTJmTjQ3ZG1LMEVBTTNLRCtvY0FsRkNzWW55YUdiekVn?=
 =?utf-8?B?K0RsU2Ntb0NlYjFsWFR1Y3ZWQjljU3paZXAvNGRiREtBUE5LNHdBM2lsVWtk?=
 =?utf-8?B?Z0llaTFITmpVdDRvNy92U0ZYSmZKenpYdzMwbUs4MmVlTm9tSXBFRGpsZkpa?=
 =?utf-8?B?d3pIaUY1RTdSS3J5WWozeWR6a3NaNjN0MnFGdmM3a2xIVjhGWnBLNXFWODY2?=
 =?utf-8?B?bmwxVzRxVnNnRXF1UXZMK3dINGxTZnBhNExDUEpTSzBLbUp5cDh0QzQxNkJs?=
 =?utf-8?B?dFhtcWZHUmpvWmhmVjc5L05nQm1wMnBFNVF1UGdvMkt6SlFXKzZVa3hyRy9R?=
 =?utf-8?B?Zmo3b2lIdm8vNGxDaVJXOXVZVkJpd0t0cUtSWEZkZnlobWVkTkp4NUIyRFk2?=
 =?utf-8?B?blVtOFE0UjJhMWFTblpOcW9Pb3lISzF5YnVVNEpEMGhOcy9uck1sVHA2L284?=
 =?utf-8?B?S0N5alp0S1FEK1BieGpLWUREbUxwczhFbDhSbVFpemZjSDZQcW4ycktlWW0w?=
 =?utf-8?B?aXlxUVlHaE5rb1c1ZjRaTWZ6NG10V0V5RjdaVUowVHMzREZENVA1UTV0ejBD?=
 =?utf-8?B?dWF3WkZ3K3kzazVZTWh0YU1jdnl1eVd0Tm1FNUVFZ0FxajhDd0dPUEt6SmU1?=
 =?utf-8?Q?S5nzB91nspCz7OuX/L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f20fcd3-b7d8-4c83-a290-08df36f51385
X-MS-Exchange-CrossTenant-AuthSource: CY0PR12MB226969.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 02:17:13.3265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2buEYz0JUXAemOQoUnWgSQd3C5feuPRSskwj6VPFkwW+DEd9I9sAnhI+FrTRy8v/YYLfDASDIWbZtKG3t1GeYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB647349
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 10/24/26 10:33, Hugo Sales wrote:
> [Some people who received this message don't often get email from hugo@hsal.es. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Leave only a scaled mode in connector->modes and put the larger native
> mode in the encoder, as a size-limited probe does. On eDP and LVDS,
> create_stream_for_sink() must build a stream with the native timing and
> the scaled mode as its source size. On HDMI it must keep the first mode
> in the list as the timing
> 
> When the list also has a mode of the native size with a different
> timing, eDP must use that mode and not the encoder's copy
> 
> The fallback must stay off when the list has a preferred mode, without
> an EDID, and when the encoder's copy has no clock
> 
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
>   .../tests/amdgpu_dm_connector_test.c          | 226 +++++++++++++++++-
>   1 file changed, 224 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> index d291ae40ca1d0..af71ca660bfea 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> @@ -4181,7 +4181,8 @@ struct dm_test_stream_ctx {
>          struct drm_display_mode *mode;
>   };
> 
> -static struct dm_test_stream_ctx *dm_test_stream_ctx_alloc(struct kunit *test)
> +static struct dm_test_stream_ctx *
> +dm_test_stream_ctx_alloc_type(struct kunit *test, int connector_type)
>   {
>          struct dm_test_stream_ctx *ctx;
>          struct device *dev;
> @@ -4202,7 +4203,7 @@ static struct dm_test_stream_ctx *dm_test_stream_ctx_alloc(struct kunit *test)
>          KUNIT_ASSERT_EQ(test,
>                  drmm_connector_init(ctx->drm, &ctx->aconnector->base,
>                                      &dm_test_connector_funcs,
> -                                   DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
> +                                   connector_type, NULL), 0);
> 
>          ctx->dc_ctx = kunit_kzalloc(test, sizeof(*ctx->dc_ctx), GFP_KERNEL);
>          KUNIT_ASSERT_NOT_NULL(test, ctx->dc_ctx);
> @@ -4229,6 +4230,11 @@ static struct dm_test_stream_ctx *dm_test_stream_ctx_alloc(struct kunit *test)
>          return ctx;
>   }
> 
> +static struct dm_test_stream_ctx *dm_test_stream_ctx_alloc(struct kunit *test)
> +{
> +       return dm_test_stream_ctx_alloc_type(test, DRM_MODE_CONNECTOR_DisplayPort);
> +}
> +
>   /**
>    * dm_test_create_stream_fake_sink_success - Test a stream is built from a fake sink
>    * @test: The KUnit test context
> @@ -4547,6 +4553,215 @@ static void dm_test_create_stream_hdmi_vsif(struct kunit *test)
>          dc_sink_release(sink);
>   }
> 
> +enum dm_test_native {
> +       /*
> +        * The list also keeps a 3840x2400 mode at half the native clock, as if
> +        * mode_valid had rejected the native timing and no limit applied
> +        */
> +       DM_TEST_NATIVE_LISTED = BIT(0),
> +       /* The scaled mode is the preferred one */
> +       DM_TEST_NATIVE_PREFERRED = BIT(1),
> +       DM_TEST_NATIVE_NO_CLOCK = BIT(2),
> +       DM_TEST_NATIVE_NO_EDID = BIT(3),
> +};
> +
> +/*
> + * Build a stream after a probe with size limits below the native mode, such as
> + * fbdev emulation's. That probe leaves only a 1920x1200 scaled mode in the
> + * connector's mode list, while the encoder keeps the 3840x2400 native mode.
> + * @flags is a mask of enum dm_test_native
> + */
> +static struct dc_stream_state *
> +dm_test_native_mode_stream(struct kunit *test, int connector_type, unsigned int flags)
> +{
> +       static const u8 edid[EDID_LENGTH];
> +       struct dm_test_stream_ctx *ctx = dm_test_stream_ctx_alloc_type(test, connector_type);
> +       struct amdgpu_encoder *aenc;
> +       struct dc_stream_state *stream;
> +       struct drm_display_mode *native;
> +
> +       aenc = drmm_kzalloc(ctx->drm, sizeof(*aenc), GFP_KERNEL);
> +       KUNIT_ASSERT_NOT_NULL(test, aenc);
> +       KUNIT_ASSERT_EQ(test, drmm_encoder_init(ctx->drm, &aenc->base, NULL,
> +                                               DRM_MODE_ENCODER_TMDS, NULL), 0);
> +       KUNIT_ASSERT_EQ(test, drm_connector_attach_encoder(&ctx->aconnector->base, &aenc->base), 0);
> +
> +       native = &aenc->native_mode;
> +       native->clock = 592500;
> +       native->hdisplay = 3840;
> +       native->hsync_start = 3888;
> +       native->hsync_end = 3920;
> +       native->htotal = 4000;
> +       native->vdisplay = 2400;
> +       native->vsync_start = 2403;
> +       native->vsync_end = 2409;
> +       native->vtotal = 2469;
> +       /* Cached by the first, unlimited probe */
> +       drm_mode_copy(&ctx->aconnector->freesync_vid_base, native);
> +
> +       drm_mode_copy(ctx->mode, native);
> +       ctx->mode->hdisplay = 1920;
> +       ctx->mode->vdisplay = 1200;
> +       drm_mode_set_crtcinfo(ctx->mode, CRTC_INTERLACE_HALVE_V);
> +       dm_test_stream_add_mode(test, ctx, flags & DM_TEST_NATIVE_PREFERRED ?
> +                               DRM_MODE_TYPE_PREFERRED : 0);
> +
> +       /* After the scaled mode, so that taking the first mode can't pass */
> +       if (flags & DM_TEST_NATIVE_LISTED) {
> +               struct drm_display_mode *listed = drm_mode_duplicate(ctx->drm, ctx->mode);
> +
> +               KUNIT_ASSERT_NOT_NULL(test, listed);
> +               listed->hdisplay = native->hdisplay;
> +               listed->vdisplay = native->vdisplay;
> +               listed->clock /= 2;
> +               drm_mode_set_crtcinfo(listed, CRTC_INTERLACE_HALVE_V);
> +               list_add_tail(&listed->head, &ctx->aconnector->base.modes);
> +       }
> +       ctx->dm_state->scaling = RMX_FULL;
> +
> +       if (flags & DM_TEST_NATIVE_NO_CLOCK)
> +               native->clock = 0;
> +       if (!(flags & DM_TEST_NATIVE_NO_EDID)) {
> +               ctx->aconnector->drm_edid = drm_edid_alloc(edid, sizeof(edid));
> +               KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->drm_edid);
> +       }
> +
> +       stream = create_stream_for_sink(&ctx->aconnector->base, ctx->mode,
> +                                       ctx->dm_state, NULL, 8,
> +                                       PIXEL_ENCODING_RGB, false);
> +
> +       drm_edid_free(ctx->aconnector->drm_edid);
> +       ctx->aconnector->drm_edid = NULL;
> +       KUNIT_ASSERT_NOT_NULL(test, stream);
> +
> +       return stream;
> +}
> +
> +/* Expect the stream to be driven with the 1920x1200 mode left in the list */
> +static void dm_test_expect_first_mode(struct kunit *test, struct dc_stream_state *stream)
> +{
> +       KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 1920);
> +       KUNIT_EXPECT_EQ(test, (int)stream->timing.v_addressable, 1200);
> +       KUNIT_EXPECT_EQ(test, (int)stream->src.width, 1920);
> +       KUNIT_EXPECT_EQ(test, (int)stream->src.height, 1200);
> +       dc_stream_release(stream);
> +}
> +
> +/**
> + * dm_test_create_stream_native_mode_pruned_edp - Test eDP gets native timing
> + * @test: The KUnit test context
> + *
> + * The scaled mode must still be driven with the panel's native timing, kept in
> + * the encoder
> + */
> +static void dm_test_create_stream_native_mode_pruned_edp(struct kunit *test)
> +{
> +       struct dc_stream_state *stream =
> +               dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_eDP, 0);
> +
> +       KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 3840);
> +       KUNIT_EXPECT_EQ(test, (int)stream->timing.v_addressable, 2400);
> +       KUNIT_EXPECT_EQ(test, (int)stream->timing.pix_clk_100hz, 5925000);
> +       KUNIT_EXPECT_EQ(test, (int)stream->src.width, 1920);
> +       KUNIT_EXPECT_EQ(test, (int)stream->src.height, 1200);
> +       dc_stream_release(stream);
> +}
> +
> +/**
> + * dm_test_create_stream_native_mode_pruned_lvds - Test LVDS gets native timing
> + * @test: The KUnit test context
> + */
> +static void dm_test_create_stream_native_mode_pruned_lvds(struct kunit *test)
> +{
> +       struct dc_stream_state *stream =
> +               dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_LVDS, 0);
> +
> +       KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 3840);
> +       KUNIT_EXPECT_EQ(test, (int)stream->timing.v_addressable, 2400);
> +       KUNIT_EXPECT_EQ(test, (int)stream->timing.pix_clk_100hz, 5925000);
> +       KUNIT_EXPECT_EQ(test, (int)stream->src.width, 1920);
> +       KUNIT_EXPECT_EQ(test, (int)stream->src.height, 1200);
> +       dc_stream_release(stream);
> +}
> +
> +/**
> + * dm_test_create_stream_native_mode_pruned_hdmi - Test HDMI uses the first mode
> + * @test: The KUnit test context
> + *
> + * On a connector that is not a panel, mode_valid may have dropped the native
> + * mode, so the first mode left in the list must drive the timing
> + */
> +static void dm_test_create_stream_native_mode_pruned_hdmi(struct kunit *test)
> +{
> +       dm_test_expect_first_mode(test,
> +                                 dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_HDMIA, 0));
> +}
> +
> +/**
> + * dm_test_create_stream_native_size_listed_edp - Test eDP prefers a listed mode
> + * @test: The KUnit test context
> + *
> + * When the mode list still has a mode of the native size, that mode's timing
> + * must drive the panel instead of the encoder's copy, which mode_valid may
> + * have rejected
> + */
> +static void dm_test_create_stream_native_size_listed_edp(struct kunit *test)
> +{
> +       struct dc_stream_state *stream =
> +               dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_eDP,
> +                                          DM_TEST_NATIVE_LISTED);
> +
> +       KUNIT_EXPECT_EQ(test, (int)stream->timing.h_addressable, 3840);
> +       KUNIT_EXPECT_EQ(test, (int)stream->timing.v_addressable, 2400);
> +       KUNIT_EXPECT_EQ(test, (int)stream->timing.pix_clk_100hz, 2962500);
> +       KUNIT_EXPECT_EQ(test, (int)stream->src.width, 1920);
> +       KUNIT_EXPECT_EQ(test, (int)stream->src.height, 1200);
> +       dc_stream_release(stream);
> +}
> +
> +/**
> + * dm_test_create_stream_native_preferred_edp - Test a listed preferred mode
> + * wins on eDP
> + * @test: The KUnit test context
> + */
> +static void dm_test_create_stream_native_preferred_edp(struct kunit *test)
> +{
> +       dm_test_expect_first_mode(test,
> +                                 dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_eDP,
> +                                                            DM_TEST_NATIVE_LISTED |
> +                                                            DM_TEST_NATIVE_PREFERRED));
> +}
> +
> +/**
> + * dm_test_create_stream_native_mode_no_clock_edp - Test an empty native mode
> + * isn't used
> + * @test: The KUnit test context
> + *
> + * amdgpu_dm_get_native_mode() zeroes the clock and then copies only a
> + * preferred mode at the head of probed_modes. When there is none, the size
> + * left in the encoder is stale and must not pick a listed mode
> + */
> +static void dm_test_create_stream_native_mode_no_clock_edp(struct kunit *test)
> +{
> +       dm_test_expect_first_mode(test,
> +                                 dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_eDP,
> +                                                            DM_TEST_NATIVE_LISTED |
> +                                                            DM_TEST_NATIVE_NO_CLOCK));
> +}
> +
> +/**
> + * dm_test_create_stream_native_mode_no_edid_edp - Test the fallback needs an
> + * EDID
> + * @test: The KUnit test context
> + */
> +static void dm_test_create_stream_native_mode_no_edid_edp(struct kunit *test)
> +{
> +       dm_test_expect_first_mode(test,
> +                                 dm_test_native_mode_stream(test, DRM_MODE_CONNECTOR_eDP,
> +                                                            DM_TEST_NATIVE_LISTED |
> +                                                            DM_TEST_NATIVE_NO_EDID));
> +}
> +
>   /* Tests for amdgpu_dm_connector_detect() */
> 
>   /*
> @@ -10248,6 +10463,13 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
>          KUNIT_CASE(dm_test_create_stream_dp_vsc_colorimetry),
>          KUNIT_CASE(dm_test_create_stream_dp_colorimetry_quirk),
>          KUNIT_CASE(dm_test_create_stream_hdmi_vsif),
> +       KUNIT_CASE(dm_test_create_stream_native_mode_pruned_edp),
> +       KUNIT_CASE(dm_test_create_stream_native_mode_pruned_lvds),
> +       KUNIT_CASE(dm_test_create_stream_native_mode_pruned_hdmi),
> +       KUNIT_CASE(dm_test_create_stream_native_size_listed_edp),
> +       KUNIT_CASE(dm_test_create_stream_native_preferred_edp),
> +       KUNIT_CASE(dm_test_create_stream_native_mode_no_clock_edp),
> +       KUNIT_CASE(dm_test_create_stream_native_mode_no_edid_edp),
>          /* amdgpu_dm_connector_detect */
>          KUNIT_CASE(dm_test_detect_force_on),
>          KUNIT_CASE(dm_test_detect_force_on_digital),
> --
> 2.55.0

