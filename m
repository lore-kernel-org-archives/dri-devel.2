Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C35C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 19:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C80110E08D;
	Fri, 24 Jul 2026 19:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q4Syem5B";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012060.outbound.protection.outlook.com [52.101.48.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBDB510E08D;
 Fri, 24 Jul 2026 19:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnhUhnmMcQKnxvs0EsqYuTjxRW5LpfXMNJSA4KJPg62Wa7Hm+6OzaZlUbeXyAZCRHW3yaE8gbewRTb4PKci+LRuudab8XZlMNWbmfnfTqCpEaxxL77+POPTqYbzZriZuGlDLt+LIUleVuixmpkQDx4kJm8Qhv4RYmiFtJgsSCeRNFudAIie0p6V2HRXUO/sz4GiSq4EWaEnJeyiE/qQCWhDCid+2WwARuUTm6+5qeH8ZxiMyg9yaT3goeDigmhnzYfSYAfaBVXT6OnVWLhGk1CyRmFBFobVFhIYFXsDJWxlPK3ukc+Z6Fp87AlAQXMql2t1LujmxQgeRiiFaO8Lrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWDxulPTKZYBVQZe7M1XyUKjYX/LKHGSzaljxVoa7Q8=;
 b=EtYT5VR+9SjsdXrR6cDEFZV38G3jI4ZVwBEZmy6f074T2+bcpVAUG5IhK8gquk/zVlch91l0YVDAJW/83vKjpZCkllu0/8YE2y1b2QYj/PsXBKR39reHPgGowIMFq8L3LcAE9Yfs7HWmUQyDhZy8b9ZCk2Xjk7CqPbs1yfDQ5/XVmwR9hNRX+bl79PVJE7xQtqAXIUtA5a8/MSYJ/wC2W5Li6AuqY3zRpWLeYmMGKe91v6PO5pUh9LoncgzqdLeHiOy7vq1bVeTpAwN4zFx9+LOxbydginriVgCzWSVt5ye3yQblxC8npPsFjkeatfFFaCCXFxk3LkSV4h1zHHtYXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWDxulPTKZYBVQZe7M1XyUKjYX/LKHGSzaljxVoa7Q8=;
 b=Q4Syem5BYSQCsknKx+Z3iNgr8dt32sQFLtKbdF1xtUZtMDzz5n4mCVyHy24DUgW5ItlkgAygaZBjIINRCdQFEP1dhfYH/YhA5ZEJdTRaJ5EEajP+G3YZowLyvMiN9bgwegqg0CU/AKMKDg7qX/1NHKboGLgnS50Imd3e2eFXz2A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 19:37:39 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 19:37:39 +0000
Message-ID: <b43b52a3-9577-4e39-94db-75fd7f62c3ad@amd.com>
Date: Fri, 24 Jul 2026 13:37:37 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix use-after-free bugs in KUnit tests
To: John Harrison <John.Harrison@Igalia.com>, amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, kernel-dev@igalia.com,
 Harry Wentland <harry.wentland@amd.com>
References: <20260723233548.580891-1-John.Harrison@Igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260723233548.580891-1-John.Harrison@Igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::26) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7c1d6e-0d5a-4628-4a49-08dee9bb0550
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|6133799003|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 12NwBLHwmt5llzG3uyStFCMl0SvYJM8WHAm9fCILeKDykSENYdkv+mA0F0NjsVCjQyJ/dH+p3OtsXKmLBreGWj+d3yToVqkKf0zW/jeolSFwVRPJlloGaV86erKkgP0zNMtV8So4w+o+doFRir3rVxpx8qAAe3bx7c4Xj91GecLJbMznKXaPj+r2kayZ3NmVZr6G+3vFx+2bzj29t9XW5qryMo7sr6JZjteK3E5bsOdscy3gwUHv0oi4rpHh33JzXtz1Nnzqk3gH1IXWgr6de/T9vXrkJBC0RcltmcA8H6h0lszYa/dHc9pggSeZqnlJ9qEdKc3fh9Pg7RcOF4qpz3WRBT36cU8YO6rkVV7ggxJa77PEVNvZaSZHTDJfgAJkvicckZ9o4RhmQDxNbu1ls5nXKCmIg9vwWZUL7Sq+lfvyYRpk9cgXKR3i2aDuE4Otn3w+brjtsVUInWnb07by0oZeasHITv0ZvR7WohbzJic2Cbvkl2uvvUKxyY6oJKV+i8g5OZhfzEM6XKfq7DItdqmxuCQZ73OIGU8oVx+Z/kB04sSRbnJn88yIGf3nPJR6lfZNuqtkWp8Xe324+11LXVb2WXTYj8AGXnTp10L+6xQ4nMQr8M3Rk5nH5XsvPHmW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVFvNHNub3BCNnFVS29VZnVzVXk1OVB1Yy9xMCttYW0xNUlGUjlyZE1LOWZo?=
 =?utf-8?B?b0dBczNQR0wyL3BtczRjSUxGUUc4REQ5Q2JQLzVBNlRBbFhudmpJWDQxWFJE?=
 =?utf-8?B?cXZEa0tOczJDL1FaODZVL0NJTVlXN0lxQjhuMHhjdkVvMG5pNjZwNXV0YVNE?=
 =?utf-8?B?NXVoalhSSFFKSGQwRE1sWXQyTzVRV2V6T3ZBYnFHRXZwcFQ3RVNaYjdoazVq?=
 =?utf-8?B?QVlmVHo5RGw5TVpibEl3MTJjbUNkNDZpRC9Xd0s2SlFiWVpNWTVQbzEya21Z?=
 =?utf-8?B?TG15YTJLeDRSR2hSMHdqZFQrODdDSThBSC9vWnJhMm9sVGt0U3VGL3pOWG0w?=
 =?utf-8?B?cjFRVWU4NFI5alI5UDZ5d3M0VHNNbVhHMTJjTUFPdVNXVXRZL1I5WVo1a3NL?=
 =?utf-8?B?RkFvRyt3Z0dyU0dDVUdhQVdDSWk4d2kzVFFzQzEvanQwMjFxQXozcDBCamJp?=
 =?utf-8?B?b3dRUnp3eDdZN0xRdUZtSHhKaDAxSkJIdG5FR3BpWmE1aVNrcXpSQ3cvRVE2?=
 =?utf-8?B?Y0JUWWFHdUJYVkF2TEozbXVrb0MwbE5xT0VDeGVhV05PZ3h0TW5tWEVhK0Z5?=
 =?utf-8?B?alZZMFZ3dmNpZFZQb2JuYjlPLysvWUFySE9Xdzc4b08wb1pXRFp2YzF6M0Jh?=
 =?utf-8?B?NVNJTGpSWGV1Qi9QYlNsdUxjRDY1Y1dNSWc1TGtZQmw4aysvcGpaWVMxc2FN?=
 =?utf-8?B?RjA2ZmI4NGtWaXdXUG9OVEJRZzZFVjhUZlRlQXRINHN4bEtLcDNRN2NPNHBW?=
 =?utf-8?B?ZDlTUHRFV1BIZEVwRE5Fa1VRSmZiV3RoNXR3QW1MakR6ekJBN0R2WjJvekxm?=
 =?utf-8?B?WGp6c0xYaWw1M0QrdURZaERXNmw2THBHT2ZJNkFGNCtHMG9SbFVOVzBHbTJJ?=
 =?utf-8?B?b1ZKeVh5VGdnR29sZVhCbXZ1WmtQbml4K1NFOFkvaE4yMVhMNlRiZFdDVXEw?=
 =?utf-8?B?VGZ5UlhocU4yc0JiN29MWjVHN0FzV0FkMmR0ZHQ1TW56WHJTd2plZGw0Q3NC?=
 =?utf-8?B?cTBhMVJqbkhMYWZyNmxGV3owWFYzUk9KVy9yQ3U3TCtQMHdxb080ZitZbVJj?=
 =?utf-8?B?TlNTb1oyR1ZkSFVpWmVkMjg2eHJVQ2dJMGJuem5aNGNFbnZxM01xWVVqZm8v?=
 =?utf-8?B?NXAvVVBJalJuZEJCc3JTaGhrSERQdkVXWmQ3Z3V1M1p2cHQzRzd5UG1SaTgy?=
 =?utf-8?B?YVZsNDBBMlNhcGNwMFZjMWNsS0M3a1c1YmlsMmxQNVdYa2tZVFUzK2RkWEM5?=
 =?utf-8?B?U0ptS1VhNlVtYmMrQXJoNUxSY25XMlZiNHMwakNYeTlKNkhnYi9POXl4bFFq?=
 =?utf-8?B?ODNYNUF4S1lZUjJENGc5VG1Jc2lRNmtxbzBucGNIajduRmdnS2RzRzNMTHpl?=
 =?utf-8?B?Yy9iSmd3TnFKQWcwVE5yNWtUK0ZlR1ZDWWdPQjQ1eXV2ZU1pMXdBS0tqUTlp?=
 =?utf-8?B?K09KV2lJdVNIbHFjdnNucWI3UldURTQ3N0FXK1lCWVpiWEZUQWZWL0g0cUJK?=
 =?utf-8?B?azcvTGNyVzNKdjJJVVNVQkluYVhKYWQ3VDZPa3pmczViK2RLMlJ4ZVNGMHJa?=
 =?utf-8?B?cEhGcXN0ckhySllzNDVDZVZjSVE1b2VEZUx4VVhrNEcrcWFGTlQzZzVhR0dU?=
 =?utf-8?B?UjZsRmNXdldFeG5QNGo4SDF1VlUvMmxnb2tMeC9YcGlqMjRmTHIrMHlCaUhx?=
 =?utf-8?B?ZTVYTHJ5b2pKVytjT2VIMWNpRmJmeTNtU1hOMERxcU1XQSs2WlJpalFtTzVZ?=
 =?utf-8?B?ZGxabmYrUHdSL2ordWJ2djloR3JpNCs5UU0vcHdwb1pJQWJDY1hmYUVMTlVS?=
 =?utf-8?B?YXcycEJ2cTRDYUczQ3NtY0tBYk5HU25ZSWNMOHM1QkE0TGo1OHRTOGRWc2dN?=
 =?utf-8?B?VVh0cGl0N2IzTWZpUEdHZEppUW1XUURRU0U5RUhNeUY4VTFlWkN2T242Q1li?=
 =?utf-8?B?THpJN2JVNzkxQmxwNXFHMjdqVGUvYVhDbGQvSTVBSmgzWWhXQVBqRUg5RjRM?=
 =?utf-8?B?SUlhaU9Sdk5waE81dEFDeVlreTV5WStFUWhTTndRZFp3YTlCWmx1T3B1akNY?=
 =?utf-8?B?RVNwQXhRN2F1WGZleFpmcExDeVV0eFd3Qis1QW5aTEluRGt6VUtjb2FOQWhm?=
 =?utf-8?B?NlpTb3dNN3BTblduaWV2ek5DdlBZYmNUSEp1VEFuSzJtb3VRMXVZU0o5UWVS?=
 =?utf-8?B?UHRPdFE3MElseVhKajlqZFlVNUJ3TDZqR09iK25sNFJXaGJZUzE1TWUwL29q?=
 =?utf-8?B?R2prKy9ibEJJTlJMSm9OeGdZZXorNmcvc25xM0lCVXAvNDMyL28xb0dLOGp0?=
 =?utf-8?Q?5xxzn9OhgmrzFOud5S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7c1d6e-0d5a-4628-4a49-08dee9bb0550
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 19:37:39.1933 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wgz8vlnAMWxDA6PcbrojlAr/rYfODMmpdEFAtYn4+bRT3HEDlmvZm+FTXz5qGweUqvX3+ano29mJGhpXUKgOrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

With two comments:
1. There is a minor conflicts on include
2. The following code seems to have the same patterns (passing to drmm_* 
functions). Do they need to be changed too?


--- drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -3645,7 +3645,7 @@ static struct dm_test_stream_ctx 
*dm_test_stream_ctx_alloc(struct kunit *test)
                                                        DRIVER_MODESET);
         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);

-       ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), 
GFP_KERNEL);
+       ctx->aconnector = drmm_kzalloc(ctx->drm, 
sizeof(*ctx->aconnector), GFP_KERNEL);
         KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
         KUNIT_ASSERT_EQ(test,
                 drmm_connector_init(ctx->drm, &ctx->aconnector->base,
@@ -3903,7 +3903,7 @@ static void 
dm_test_poll_dac_load_returns_cached(struct kunit *test)
         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
         adev = drm_to_adev(drm);

-       aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+       aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
         KUNIT_ASSERT_NOT_NULL(test, aconnector);
         KUNIT_ASSERT_EQ(test,
                 drmm_connector_init(drm, &aconnector->base,
@@ -3950,7 +3950,7 @@ static struct amdgpu_dm_connector 
*dm_test_reg_connector(struct kunit *test)
                                                   DRIVER_MODESET);
         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);

-       aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+       aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
         KUNIT_ASSERT_NOT_NULL(test, aconnector);
         KUNIT_ASSERT_EQ(test,
                 drmm_connector_init(drm, &aconnector->base,
@@ -4405,7 +4405,7 @@ dm_test_modes_ctx_alloc(struct kunit *test, int 
connector_type)
         ctx->drm = dm_test_alloc_drm(test);
         ctx->aconnector = dm_test_add_connector(test, ctx->drm, 
connector_type);

-       ctx->aenc = kunit_kzalloc(test, sizeof(*ctx->aenc), GFP_KERNEL);
+       ctx->aenc = drmm_kzalloc(ctx->drm, sizeof(*ctx->aenc), GFP_KERNEL);
         KUNIT_ASSERT_NOT_NULL(test, ctx->aenc);
         KUNIT_ASSERT_EQ(test,
                         drmm_encoder_init(ctx->drm, &ctx->aenc->base, NULL,


On 7/23/26 17:35, John Harrison wrote:
> When running the KUnit tests with memory debugging enabled, a bunch of
> use-after-free errors are hit. These are due to using KUnit managed
> memory for the test objects but then giving them over to DRM managed
> objects. The KUnit stuff is deallocated first and when the DRM side
> calls its clean up helpers, it hits memory that has been freed already.
> 
> NB: There is still a use-after-free bug in the writeback tests.
> However, fixing that requires driver side changes as well as test side
> changes. Those changes are part of:
>    https://patchwork.freedesktop.org/series/152420/
> 
> Signed-off-by: John Harrison <John.Harrison@Igalia.com>
> CC: Alex Hung <alex.hung@amd.com>
> CC: Harry Wentland <harry.wentland@amd.com>
> ---
>   .../tests/amdgpu_dm_connector_test.c          | 37 ++++++++++---------
>   .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |  3 +-
>   .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |  5 ++-
>   3 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> index 0a5d439f66c3..93a854d4fdfa 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> @@ -12,6 +12,7 @@
>   #include <drm/drm_crtc.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_kunit_helpers.h>
> +#include <drm/drm_managed.h>
>   #include <drm/drm_mode_object.h>
>   #include <drm/drm_property.h>
>   #include <linux/hdmi.h>
> @@ -1449,7 +1450,7 @@ static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
>   						   DRIVER_MODESET);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>   
> -	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
> +	connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, connector);
>   
>   	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
> @@ -1488,7 +1489,7 @@ static void dm_test_funcs_reset_edp_abm_level(struct kunit *test)
>   						   DRIVER_MODESET);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>   
> -	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
> +	connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, connector);
>   
>   	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
> @@ -1526,7 +1527,7 @@ static void dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
>   						   DRIVER_MODESET);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>   
> -	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
> +	connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, connector);
>   
>   	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
> @@ -1568,7 +1569,7 @@ static void dm_test_atomic_dup_state_copies_fields(struct kunit *test)
>   						   DRIVER_MODESET);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>   
> -	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
> +	connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, connector);
>   
>   	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
> @@ -2359,8 +2360,8 @@ static void setup_panel_type_fixture(struct kunit *test,
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->drm);
>   	fixture->adev = drm_to_adev(fixture->drm);
>   
> -	fixture->aconnector = kunit_kzalloc(test, sizeof(*fixture->aconnector),
> -					    GFP_KERNEL);
> +	fixture->aconnector = drmm_kzalloc(fixture->drm, sizeof(*fixture->aconnector),
> +					   GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->aconnector);
>   	fixture->link = kunit_kzalloc(test, sizeof(*fixture->link), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, fixture->link);
> @@ -2554,9 +2555,9 @@ static void dm_test_update_subconnector_dp_with_sink(struct kunit *test)
>   						   DRIVER_MODESET);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>   
> -	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
> +	aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, aconnector);
> -	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
> +	link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, link);
>   
>   	drmm_connector_init(drm, &aconnector->base, &dm_test_connector_funcs,
> @@ -2598,9 +2599,9 @@ static void dm_test_update_subconnector_dp_no_sink(struct kunit *test)
>   						   DRIVER_MODESET);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>   
> -	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
> +	aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, aconnector);
> -	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
> +	link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, link);
>   
>   	drmm_connector_init(drm, &aconnector->base, &dm_test_connector_funcs,
> @@ -2641,9 +2642,9 @@ static void dm_test_update_subconnector_non_dp_noop(struct kunit *test)
>   						   DRIVER_MODESET);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>   
> -	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
> +	aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, aconnector);
> -	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
> +	link = drmm_kzalloc(drm, sizeof(*link), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, link);
>   
>   	drmm_connector_init(drm, &aconnector->base, &dm_test_connector_funcs,
> @@ -2657,7 +2658,7 @@ static void dm_test_update_subconnector_non_dp_noop(struct kunit *test)
>   
>   	link->dpcd_caps.dongle_type = DISPLAY_DONGLE_DP_HDMI_CONVERTER;
>   	aconnector->dc_link = link;
> -	aconnector->dc_sink = kunit_kzalloc(test, sizeof(*aconnector->dc_sink), GFP_KERNEL);
> +	aconnector->dc_sink = drmm_kzalloc(drm, sizeof(*aconnector->dc_sink), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
>   
>   	update_subconnector_property(aconnector);
> @@ -2804,7 +2805,7 @@ static struct amdgpu_dm_connector *dm_test_add_connector(struct kunit *test,
>   {
>   	struct amdgpu_dm_connector *aconnector;
>   
> -	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
> +	aconnector = drmm_kzalloc(drm, sizeof(*aconnector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, aconnector);
>   
>   	KUNIT_ASSERT_EQ(test,
> @@ -3103,7 +3104,7 @@ static struct dm_test_panel_ctx *dm_test_panel_ctx_alloc(struct kunit *test)
>   	KUNIT_ASSERT_NOT_NULL(test, prop);
>   	ctx->drm->mode_config.panel_type_property = prop;
>   
> -	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
> +	ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx->aconnector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
>   	KUNIT_ASSERT_EQ(test,
>   		drmm_connector_init(ctx->drm, &ctx->aconnector->base,
> @@ -3112,7 +3113,7 @@ static struct dm_test_panel_ctx *dm_test_panel_ctx_alloc(struct kunit *test)
>   	drm_object_attach_property(&ctx->aconnector->base.base, prop,
>   				   DRM_MODE_PANEL_TYPE_UNKNOWN);
>   
> -	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
> +	ctx->link = drmm_kzalloc(ctx->drm, sizeof(*ctx->link), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
>   	ctx->aconnector->dc_link = ctx->link;
>   
> @@ -3376,14 +3377,14 @@ static struct dm_test_fill_ctx *dm_test_fill_ctx_alloc(struct kunit *test)
>   						       DRIVER_MODESET);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->drm);
>   
> -	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
> +	ctx->aconnector = drmm_kzalloc(ctx->drm, sizeof(*ctx->aconnector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
>   	KUNIT_ASSERT_EQ(test,
>   		drmm_connector_init(ctx->drm, &ctx->aconnector->base,
>   				    &dm_test_connector_funcs,
>   				    DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
>   
> -	ctx->conn_state = kunit_kzalloc(test, sizeof(*ctx->conn_state), GFP_KERNEL);
> +	ctx->conn_state = drmm_kzalloc(ctx->drm, sizeof(*ctx->conn_state), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, ctx->conn_state);
>   	ctx->stream = kunit_kzalloc(test, sizeof(*ctx->stream), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, ctx->stream);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
> index 58615cdbe854..7d5e3823b33b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c
> @@ -8,6 +8,7 @@
>   #include <kunit/test.h>
>   #include <linux/module.h>
>   #include <drm/drm_kunit_helpers.h>
> +#include <drm/drm_managed.h>
>   
>   #include "dc.h"
>   #include "core_types.h"
> @@ -127,7 +128,7 @@ struct amdgpu_dm_connector *dm_kunit_alloc_connector(struct kunit *test,
>   {
>   	struct amdgpu_dm_connector *aconnector;
>   
> -	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
> +	aconnector = drmm_kzalloc(adev_to_drm(adev), sizeof(*aconnector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, aconnector);
>   
>   	if (adev)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
> index b43bc244487e..3454cf371414 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
> @@ -12,6 +12,7 @@
>   #include <drm/drm_fourcc.h>
>   #include <drm/drm_framebuffer.h>
>   #include <drm/drm_kunit_helpers.h>
> +#include <drm/drm_managed.h>
>   #include <drm/drm_mode.h>
>   #include <drm/drm_modes.h>
>   #include <drm/drm_writeback.h>
> @@ -266,7 +267,7 @@ static void dm_test_wb_get_modes_returns_modes(struct kunit *test)
>   						   DRIVER_MODESET | DRIVER_ATOMIC);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>   
> -	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
> +	connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, connector);
>   
>   	drmm_connector_init(drm, connector, &dm_wb_test_connector_funcs,
> @@ -301,7 +302,7 @@ static void dm_test_wb_get_modes_bounded_by_max(struct kunit *test)
>   						   DRIVER_MODESET | DRIVER_ATOMIC);
>   	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
>   
> -	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
> +	connector = drmm_kzalloc(drm, sizeof(*connector), GFP_KERNEL);
>   	KUNIT_ASSERT_NOT_NULL(test, connector);
>   
>   	drmm_connector_init(drm, connector, &dm_wb_test_connector_funcs,

