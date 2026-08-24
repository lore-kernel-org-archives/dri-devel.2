Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6DBC5DF8C
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 02:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8F3510E037;
	Mon, 24 Aug 2026 02:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="iPhcB3ku";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A553910E037
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 02:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iauruXVT0uCX3ssnK+zRg3RPnbPzVfGYRcGWx7+hvYrHHgo2rt9/hQl8xTAjz7mmxSi7qxC1RY2nNszCbagbcOmt8JmFOybkSlY5FlbENSqmIK0s2U0RxEnOGDqYvSDgVhYvq9b0cdFUCKvm4L9v+kna47KCjJdxcB66pnCGBWj2kPxlI7OLkku6ubwYiClzSQ+mJ7tlWO0kAnpY7WEKsUTgOAU2ORSy22stFiM3Qzol4xCCHNquTGvfLpXST0YZTH5kzBl2HcHa9GaiX4ulaVLXE/G74E7h72Ib4QGUVFS1Ka7TY5ruWEG0+RwzMgksKW+tzbIVKccTk7pOGpkn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2C/j8XoG4TyeNRrVF5NKj3KKxdbkQc/CAQP+1kihAY=;
 b=KQmVUu0SvuqVSSXhd+F6mQDy9svbgSRv7YR7EJ+oUK0VjfleI6p172y3MoEodg3xuy25dvxZz9IpfoQC3v+0UHdC8CRGzknwYNIeN9QD6W+VNrsCFxJ8DZYK4w+D4iOsqOCtXQ7CCjlfmjBziyWRDEhwPKdSbJ3ow0ZEB/RavQdTMEknyqhzbn4Yzmc7kr+J9K+ME1sW4ZY5CPsyehFWqcUR37C18TEDGBf3DwiiJu05r5PfaUhqq7iTCyJly0WqwREuwpqx+9uSVD5KyUjLezOZeQ0rrbSkkQSGwARfmYBRJ0dDAd5kEStpZe3ZlY3qrjRloc4ba1wCkqzSfsVFGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2C/j8XoG4TyeNRrVF5NKj3KKxdbkQc/CAQP+1kihAY=;
 b=iPhcB3ku5CnxpJ1+vRq8RhoguU8boWhhW6aIsQpyzGeXR/k7GK3PJXuhJlaH6pH1VcecGt8Y4QoeTlJgAG2kkmHdJycc1zpyhuEoR23l/Z0UFdoxoQWm2Gl+Ray8pcU0qU8z263uBq2OUYfy0Ddzv5Svya4d4CGtIsiHz4+uHG2tERaBssJ4p5BEGp8j4GqeLbA/YZKHhqIPGOjQFM6xwSBZ8d1YXg9JOKMlCJxezp0iYALRTNSwJ8CE1ssqDLm5f324mYydkkBMmI65keQmN9pNr92d+lInuUlNWJ1EnbEwzrtCzrkGk25uSISpsusCLagaDmy6tCM1PjQZjmnLcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by MN0PR12MB5811.namprd12.prod.outlook.com (2603:10b6:208:377::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 02:44:59 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Mon, 24 Aug 2026
 02:44:59 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonin Malzieu Ridolfi <dev@nanonej.com>
Cc: linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260817-b4-extract-pmc-registers-to-gpu-mod-v2-1-9dd1d599deb4@nanonej.com>
References: <20260817-b4-extract-pmc-registers-to-gpu-mod-v2-1-9dd1d599deb4@nanonej.com>
Subject: Re: [PATCH v2] gpu: nova-core: Extract PMC registers definitions
Message-Id: <178753923260.768430.8808267111681597638.b4-ty@b4>
Date: Mon, 24 Aug 2026 11:40:32 +0900
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0228.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::23) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|MN0PR12MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: b4602815-65a2-4aa0-5502-08df0189b05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|10070799003|1800799024|376014|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: if+MG0QekdvoKA5VEX6moX6NawvNaINCbQpT4rChk46ur0IZiNdcTYfSH6+oXy87KOpyW2ph1Ti7IfCWag/vAgtqQ1deoDXEgv2cy/WeFLUmjErVQNJxTo2lc8zexY+K+wWOPuULpmMGB0A8lSgVuwExo+MykiIPxgriMGbABwQ/0SRIoqYW+jzgsY2+CM6lq8AIvxH+bFYhaU5jNGhB2I5pqaBnYCAKlzLUzlXt4qItCwlQCHH4xnlfwBXNZE2g48AVT03NutQPNonz+RmACYWxPup0FKxEBAQrqfpi8Fo08aRdn3lj31YLcn/kJDPr4m4bN2QxXAuri5vPKIaala/K/kYT3zUMxdUNDvk2eonsVV+WAJRilbAZ4IKPk+XweuQ5trNLpfjsHTeHsal4Ij7XDP5lQ77uhdbzhjaeMQVNzuO4eml4Kzt2zNc7pDssHqOdk88ScTcRM9MP/K6uAhcvTEVKD0o8yuuzdWzV8OR1eNfw51biynsJGvi5At2DKhnho99EwwOZZyjDhoBMXfSZOax8JMKpbzjC3qJqC7HX6zLv7157EjctlbxK6EsI4FqHDTh4/9WwIUVQiFnmtaCIS/C7k3cs8u5OIg0he5q76VBf/7KAf/3ckDOVmCGnz0VWhPpVJ5RWjXtxc8ehx2dWSaUq+H/Vh/y7Pz3xBqk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(10070799003)(1800799024)(376014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2hTeVF1UHdRTjlybGNLUUNIY1Jrb3dQVXFyQmRvZk0rMjJ1VlBabW9SenU4?=
 =?utf-8?B?VlMvaTZnek9oa1VjaHlKZ2RuOUt5T044Q2QralVtV3RIZk9rRWQ4WllucnpD?=
 =?utf-8?B?aURkR2puMnVJdjViZ2FtZ1g0UUpmRWZ6a3NNVUNDM2RoRE1WamNQQmtZWDhM?=
 =?utf-8?B?RXlKRHBJUzI0bjM2MXZFKzEwaEdqUHdVbFdNM0RtS0NKNll1b3JsNGsrUjNO?=
 =?utf-8?B?Y3lNQzhtZEdXeFJwcmQ5UFZGZmRvakpqSCtCOVNUYVdoWFNDb2pHakp6T2Va?=
 =?utf-8?B?OGZaRjFxMnhsS2pYMkFxRWJpU2d4WUU2MmErZ25UY2VNRDYydmRpenRtUk9O?=
 =?utf-8?B?dUdVdW43c09IbFFyalhIZ1FKOEVVcS9henN6a2hYZExhN0pLVVNBWTdSeGpp?=
 =?utf-8?B?WnJNSW10RUthUzB2NzRQcDJ1bXVUaDdyL1NnOWFTdGJlZEFTWUY1UTN5QXNn?=
 =?utf-8?B?cE9TMElzalE2Q0J0MkprLzRPcWlvaUFnS3hQRXNqYlViaFB2WVVLS0JldFdK?=
 =?utf-8?B?ajNNOElVc3RYYVBqdEZUUTNPb004ZmxuZll0YmNrWXFOazV2L2UwODZHQlQz?=
 =?utf-8?B?M1FDekVzeGVqV3FrNXJSTnBDMWhIMHQ3MGNFTUNQWmVyMTQ1SUJ1djQrU3lI?=
 =?utf-8?B?dzk2Ukc3Wm5VRWgweVZtWHZHQXBBa2ZNUUJ5YzNUTEZ5VTY0N2VXNWVUSkJj?=
 =?utf-8?B?Tnl1K29MUmx3MWF4Smd5LzRudzVOQmpjTVVrUzZiT0ZWVmZQMzhhRzJMa3ZM?=
 =?utf-8?B?TElDL0FVY0x2a2VOQ0ZNUDAzbURYcWt6bGtDNTc4T3pMWmF3anFFclYyZUdU?=
 =?utf-8?B?YXBwRXVVQVB6OVJFR1gyblIzeFptT3krTklCTzZBbktsbHFPSUZnNzM1UHFy?=
 =?utf-8?B?R1VtTG1HNkZ0QXo1dnRkVGVqdEx5SmI4dlJOUHB0NUJ5ZlJOem5JNWF1RTlw?=
 =?utf-8?B?eldzR05BNWpXSXBzMmF0MU5SL3JkWjJORjBDWnU4bDBKa1M0MUhoS1hrVTFB?=
 =?utf-8?B?OTA5Y250VlJnL0RDNGJGNFZVakkrUXhCUTFKQzhqdHh0OWlNd3c0alBpbnFB?=
 =?utf-8?B?UHpQejEyVkRYZkF6N3VnWGJhS004QkFORDlBZ2xyS1ljVS8zdmxrNXVtbndj?=
 =?utf-8?B?TEVHVUNlMEJ4eFJudS9iYlpNckhkRGpGd1ZLTGFVQ01QK0NHNkpRS2lsOVZj?=
 =?utf-8?B?enNvaWF1VXBDQTZKcnNoRXdWZ05iRHZVMjMvY0wzeWFQdndORnNMVkRwblg0?=
 =?utf-8?B?RG9jZmZaYnlBMnpoeDB5SWRreFY0S2E1bHdGU3RucUtoMXBHQXB1S1N1ZXR3?=
 =?utf-8?B?QXNzY2Y3K2FXaVRNNXdLdW4xNXF4RHNxMFROTzd2bEVjYTg4UW4xN2xqRklW?=
 =?utf-8?B?aWtIMTVUL0o1bm9yYmJlTmVUYnNIMWNsT0hLMXQvUDVHaHlaNEx4V1cxL0l5?=
 =?utf-8?B?TWtaaENWMUc1SzhaNnhFeU9CdDdBLzd2QXZmOXZlQU9keStFU3pHMnRZQXJ0?=
 =?utf-8?B?ZzQ5MVdMbmdRcWxneklsSlNKdUpaWHFpQ3Y5czNtTHVFaDZtOEw5eWZ3MTdy?=
 =?utf-8?B?WGtaa1V2aWpmNWl2cmVEa1FPcDI1bG9INVB5U0YxaTU1WjArL092Q3hxL0kx?=
 =?utf-8?B?MVVKZ1NJcnh6QWVzemlIL1cxbGpzN2VzVDZITW80cmFSRDJVdzdDc2dsUHBW?=
 =?utf-8?B?TDF1QTFIRWR3WFJEeVZJd3ltYlYwQWxsQVJudHFXVnJ2UHFzelRwSkNyby9l?=
 =?utf-8?B?QS96eFVxUk1MNWE5c2hwNkhYR3I0MFk5NnU4MEpSY0w4UytENDhKaERZOG1x?=
 =?utf-8?B?andvRTEwcDZWZTljZGo1bXhrcFk5cG4xb0RPOGJ5SlZVOEh2a1V6eHNVaklk?=
 =?utf-8?B?ejNHOEJpYkRJdTIwVHJpMEJqb0pOYTVYM0NHTjd2ZUlZcmFIOHRRV2lINTF3?=
 =?utf-8?B?enZmZXRRa09Tc1VKZFo5aWd4WHNSZEV4LzZWREprbFo3VXlWekRpVDQ3WFlQ?=
 =?utf-8?B?ekROUE9yV2FpWkcvb2JqbGpmQXRSWWlDRktGNG9CbFNpTVd1YURiVjdERVk0?=
 =?utf-8?B?U2RNY05rTnB1Q29QN0tnM0NNTWw1WGp0MGUyRVc1bDFNbExMU3o2Tmp3WVVz?=
 =?utf-8?B?d2JSemllRFJtKzVXQTl4b1l4TExjREF0TW5pa1ZtSFJDekRvWVRveVUwUUta?=
 =?utf-8?B?bnFWaEpRWlZrVVovZksrVEJjc3FHczFHR2pxUmpqT25KQ0dyWnJnZzZTd1Rs?=
 =?utf-8?B?Vm8zYmh1UHJFbTNwNzdyUDByOUNGTjBBeThVbUFUTjFKN0c4S3M5UDd3UXU3?=
 =?utf-8?B?RWszNHpNbnNLZXQva2s2bjl0ZU5DZGljUFBLZlZSR09Jai9rcC96RGdWQU5w?=
 =?utf-8?Q?hzcrdIk6r/WlK+bA9/Cmcx02tUn2fzm+eM6o1YTKiCvcu?=
X-MS-Exchange-AntiSpam-MessageData-1: eXX8XKzD4EpeJQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4602815-65a2-4aa0-5502-08df0189b05a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 02:44:59.1966 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /rUM4XHwYzdyW3rZEJTOyaR/eaVYXik93seo1rCyuibXyGLeQBJWlMJ3T7cSHyR5jT7hX2Np0gfjvhnXZAXsMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5811
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

On Mon, 17 Aug 2026 18:51:08 +0200, Antonin Malzieu Ridolfi wrote:
> Move PMC register definitions (NV_PMC_BOOT_0, NV_PMC_BOOT_42) and
> their associated implementations from the root regs.rs file into the
> gpu module that own them, in the new gpu/regs.rs file.
> 
> This follows the same pattern established by previous commits for
> GSP, PDISP, PFB, and PBUS registers: register definitions move to
> the module that owns them, visibility changes to pub(super), and
> cross-module access is provided via pub(crate) helper functions.
> 
> [...]

Applied to drm-rust-next, thanks!

[1/1] gpu: nova-core: Extract PMC registers definitions
      commit: d53bc149eea6213e9c4a4604df5521db7b7296ca
