Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3067BC88E6F
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C8C710F02B;
	Mon, 14 Sep 2026 16:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o33MJYrH";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013007.outbound.protection.outlook.com
 [40.107.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE67510F029;
 Mon, 14 Sep 2026 16:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhvvIfGWeJDeXyQd3/aigZ7C3Debf4VH10mkcfe5a9rMyltAF6sjw+5z5SitRWxIFb+Wuyx0Ay7g3ubbEwXPPt8vTxSN8yPRLGtAI22bmbs0hWwf37YSw9POVbvdg8b6ki4Y7LXJw3JReW5bJX0HVeN9Aych43G7klXP4NdSK2z6P2u9fgYV45P/h7GYWTv2VLLQanDUuDzUqpqiKkOVbNfbtpir+B0BonzuHWnpGClh/E1hoPJVj7Z2YFWX+X1Gcn7G0JH9368IAHjEwiO5tuPpU/d0CaF3lVEV6K4FCsvvBHycvsXmoW+AcLb7t2YS50p9LN7vQ8QVEllO93hw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+D140ULnSZjdwVYKcrkx412W2FZKIx+JQfoynB1S1o=;
 b=b7ZG22EO8J2MS95ONESZaXy2tCWynlMJZguMXlQU//hKhtpYi9LzXeh4/4yaBmOOLGHAlXF9KE82kRVbv4dkL3vJKxHoyU6zCQnCk5yHT74Iu00wrcnVEGXj288ThkY+LhUzC07CdJBnAWN20VT9iNSM9YmDMblbCNcNKGt3Arp/lfT+08eGfr5QAaKgKoXKl6WyNXv/pl/RiDFHZPOG/vxmp93sdNsAT2XTt/VaYcRD9b4HUbPeSR8uG7L6r8r8MWxthJM0ZyTydx+wjoXbZRTgcLE5H0zDBqJ9TGVENrDbHHC5jkQxMrCxcue2YyoOUPdgJHHDPVyePBUGQCwpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+D140ULnSZjdwVYKcrkx412W2FZKIx+JQfoynB1S1o=;
 b=o33MJYrHD16/auKeuqrNvVwOUeF46RWlTpoRWDYNXQ9tnImP71cwZ06DBVkFe6NdXWRf64o5I5JW17DGK5Qhzru28ePgPbCAi7WLQloYYSfZGB9/vXxSpTdlMNvJdEHvkRlRs7PtHSoPSDeSWRmSsfIfhJv/5TptQJgXQCpAfzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Mon, 14 Sep
 2026 16:43:42 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%3]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 16:43:42 +0000
Message-ID: <25569f7c-6c04-4446-83e0-2d51c3de98db@amd.com>
Date: Mon, 14 Sep 2026 10:43:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: pass scanout position values directly
To: Mohammed Anees <pvmohammedanees2003@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org
References: <20260908082045.99555-1-pvmohammedanees2003@gmail.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260908082045.99555-1-pvmohammedanees2003@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ2PR12MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a0c522-ce02-4c21-ab98-08df127f55ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Xwc7Uwzj5b0owT6XUWjpRd2+XGgtGrodPJmgeBM07yQb23s0AidCqKO0HxJXtlaEd7fx9dub4un+X+OuETAuKlVflW5jBtb3SPS+Q0RMmzU6om4bMUVVKfIzMPKeQwl8jLPSUKdYHhpCHQTX3pDXCTZwdf/J+lGJBMCPe21CRsi7Qf7ku/rSvEvEY0JKLuMlIAHluICLxt+YySRSb+GGLqejk9DCaIsrLgSdJ9x86bNjhESU0iUjbH0gTMkengyVu3wzDLmxLAjHIUcmeB2F0dpOr4Jw5RyLfXt7YX7Jfc+3h+470rPfFjVcc39UuRd65unO500ckxbbIWAffCeYbpD6CZEYXGohEB9cyfcPi8/yL3v+OEi7s9jy5p8YZKXcaIWhZpOAIbhakyYvJa6JK0NJ+jrt942O+SlV1/XzyGELSy/Fy5dnEWAwbqyZGt7yP4mCzxVMsN8iWGbUEDbeCU5gkx1Gsl8UOFi3AiNiwwWflpdHc/yPfcGt+m6lvYNtHArpFeY/kXiz1V0vKgcfbjR4QWbsKY7xXR1WdcqbNBgkuue39FmgkjrX7NGGh90DKP7I1IBvog7EqpZP7spydBVLheZ7Sesab88YlzltS6zk1DDRAUC5uQ2U/BGKIMqLXtTuM8/o3qpaOL4y+vHWpj3xtDwkQDyvng70P45Sy9U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHV2ZmZLN3BOOG5obTk3cUhvdWNxZERUaS9Ba3RRTDZPNURVaUxtQWcvVThl?=
 =?utf-8?B?NDVESzNKMmpPMWFLdDdkdlVoSU02WDllaWlnTDhyOG0wNTc3K1dwakRZdW5r?=
 =?utf-8?B?eVc0OC91cFVsRmdzb09aU0UrcWlUZG9VWDVudW53N1Jma3VuL0p1aE9YMzNF?=
 =?utf-8?B?bUJqbk9xM0ZaTTh2elQxcG1ETFd1dXNXWlhQWDkyVWZidUx4SjVScW52WlRG?=
 =?utf-8?B?N0pvZ21LdkxkaVhHdE5LM2NaSHV4a2ZDaXpnRlJyOHgvMC9RWUpzS1M1Uy96?=
 =?utf-8?B?aUV0NDVhaUE1M0J6amhlamhydnZWSkdTK2lPcEptQjJBdEQ2L0RlR1paZndk?=
 =?utf-8?B?YlJybW9sTDJGbUdvRS9iYVdaMmxFNGJqdHBJY2ZWeEdtUllrK2dGckFpM0x0?=
 =?utf-8?B?U2ZZMDhrNU8wejhPbmdDbUxWWWY3S0tnOW9SMTZjZ1BxYk5kejV4djFrVGNF?=
 =?utf-8?B?T0F0UXNwTzh5K0RSMlFiSWNrTVZWcUxnRDJKM2xzeHJGTGE2YnZnVzFNRlFn?=
 =?utf-8?B?T3N3b1VFclFhaTcrYU1mRmhXS29xei9BVjR0SnZOWWlvbzRFbERuamJ6RWpz?=
 =?utf-8?B?anRHSGgrZHg1VytXc3hVb1FpSWhnQVZBZko5akhMWm55UytvNDlvaFZzSlNW?=
 =?utf-8?B?aFJJSDc5Q2tWa213blVlOFBMZm03eWtta0Jxd0kxV1hpQklLUFBkSytNSUtM?=
 =?utf-8?B?U0gvdGkzbXBOZlRmOWxyK0YrckVTUjNBM1NYZjFia1V6SHAzQzladnNGcnhS?=
 =?utf-8?B?ZjgydHhUYVNNWm0xWkVCc2ZlNENYVDJ5WXpyak5EL2h3LzU2cUxUZmwvOHZz?=
 =?utf-8?B?TGpVVG4yNzAwOWhEckN6WW42YVFhbGo5SEQ5eXM5TEx6TTZOT0pJYkl2OEhU?=
 =?utf-8?B?aGJCaWYrNFgwR0NWbXQ4M0ZVZnlqeGtXNHJMZkN4UlpqQlk3YnprbmlNSTgz?=
 =?utf-8?B?VERLR2lRVFZBYndPcVNMM1M4U0hNU3hFOHpDblRtdVROcVBzc0hrWmFIZkhH?=
 =?utf-8?B?QnNWOXV1R3RZZWVvNnk4NU5aWXpralNtTFFiK1FGZ0FaaDVhbzl5TDE0clF3?=
 =?utf-8?B?UCs5SVZHb08zUEFpWkRxamR4L2pwZFBSRGFFdTNZbzlKMWJHT3hHcTRLeC9t?=
 =?utf-8?B?Sk9DTjEySlcvN0laSGFnOElHQUFLN2FhWGFPVmlPKzQ5Y0U3cTFLQ2tWWFlX?=
 =?utf-8?B?b0FZS2J2VUJIZjZvbHpvVjNWQUZHSk1wZmZoN1libGVuV1VZZ0dWanI4Yy9L?=
 =?utf-8?B?OTk1UE1pY2Nsc1VVMDZva0R6ajNWcWxoZVFadzBlaHhnazMrWUhkUDgwYmFt?=
 =?utf-8?B?R09IWXdoKzdEbGh3SW1nT05oYlpHTTFxejR0ZnRZVGRRZzJmTExDK1cwUzBJ?=
 =?utf-8?B?ODdOeWtOUWZHdDVxdXpNaGhHUnlDU2RBNHZVRXptMWRySVo4S1lPNVhyM2g1?=
 =?utf-8?B?K1FrL0xza0ZucGxTeE9pSWRWWVBKKzlsQ2FhTVZPemI1c0w3L2FsNzhWd1Zs?=
 =?utf-8?B?RDN2cURWVklRN0w4cDhKZkFXSWFTS2l5N3IzY3NIeWdISzFTaW1kSFY1eGFy?=
 =?utf-8?B?bHN2T3lDa08wOWdJVkRPNno0ejJHMEhXdTR0bW45eXRrb1lCeG8vR1dlNjVH?=
 =?utf-8?B?Q0lpczVpZ0Y0RXViaTBPMjcxQ0Q3eElDS20vbnRlVUw5Z3kyNHRvY0pEeEVI?=
 =?utf-8?B?YktqaWFmcE1tbGFwUXFrdlkzUXZOV0lwY1BlNENCNm41SnY4Ui9EUjdEYmVM?=
 =?utf-8?B?bFc2U3VHaWxDS1p3Tmk1TUVQeEdXdFpFRmFNYkdVWncyYWk1cU9XUmU4M2Ix?=
 =?utf-8?B?NTNaUE4zZ3gvc0E1ZlFJejdFNGZCbXdLQkQ3YTRpTEZ1djdqS3BWU1NQR3Jy?=
 =?utf-8?B?b1FNUG1PdkRrTWFFR3p3aWFRNnJ2Q0RGd2t5UmYxUFFxUDhSaUllUmZwV2Yy?=
 =?utf-8?B?dmlsVC81RGhIMXFXVHE2ZGFJd0V1Wnk1dFZPZm5vT0t0UzdYakJTa3hZTDlz?=
 =?utf-8?B?L0dVU1BWaTM3NHZQU2hXY0hOTWpnaHBXMCtsS1FTcW5OWXR1M0hmOVpyaWU0?=
 =?utf-8?B?Qk9HYkZhc3F2dnB5eFF4M1A4MDI1aGFucWtXTEhwWEZUNTFiTW9KMG8vTWlh?=
 =?utf-8?B?c3gvT0t3M3lBOVdYVDBSdnhXNENzejFadlBzVCtnZ1Q2RlJzbXNQdlNHVjN4?=
 =?utf-8?B?WXlURmVpdjkxOURFQTllbVZIV0RYc1BhVXNWL2ZkRlRmc3l1aFBhRFVaNVBP?=
 =?utf-8?B?c255bTVYKzBhUC9LWDRxZWxEck9hRVdsSG9qblVXdTNkREhIeU5KSDBJdnhu?=
 =?utf-8?Q?f/yxqtLKPQftjvJ1ST?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a0c522-ce02-4c21-ab98-08df127f55ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:43:42.3477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78b8Y1dY60cBrBqsaI/MpwS0uH/U3F0vui5gXGHf5+HiwXdrvYz/mWUKYpQEdjc0XUgQI820LnLwnTlnPdRqWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8109
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



On 9/8/26 02:20, Mohammed Anees wrote:
> [Some people who received this message don't often get email from pvmohammedanees2003@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The DC scanout position helper already returns vblank start, vblank end,
> horizontal position and vertical position as separate values.
> 
> dm_crtc_get_scanoutpos() currently packs these values into the legacy
> register-style vbl and position values, only for the amdgpu base driver
> to unpack them again.
> 
> Change page_flip_get_scanoutpos() to return the individual values
> directly.
> 
> For the legacy DCE implementations, keep decoding the packed hardware
> register values in the backend before returning them through the common
> interface. This keeps the register specific representation local to the
> DCE code.
> 
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 22 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  8 ++-
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 20 +++++--
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 20 +++++--
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 20 +++++--
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++-----
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +-
>   .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 56 ++++++++++++-------
>   9 files changed, 124 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index 59ea338b554c..86c806f9fa97 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -1762,7 +1762,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
>                          int *hpos, ktime_t *stime, ktime_t *etime,
>                          const struct drm_display_mode *mode)
>   {
> -       u32 vbl = 0, position = 0;
> +       u32 scan_vbl_start = 0, scan_vbl_end = 0;
> +       u32 scan_vpos = 0, scan_hpos = 0;
>          int vbl_start, vbl_end, vtotal, ret = 0;
>          bool in_vbl = true;
> 
> @@ -1774,8 +1775,14 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
>          if (stime)
>                  *stime = ktime_get();
> 
> -       if (amdgpu_display_page_flip_get_scanoutpos(adev, pipe, &vbl, &position) == 0)
> +       if (amdgpu_display_page_flip_get_scanoutpos(adev, pipe,
> +                                                   &scan_vbl_start, &scan_vbl_end,
> +                                                   &scan_vpos, &scan_hpos) == 0) {
>                  ret |= DRM_SCANOUTPOS_VALID;
> +       }
> +
> +       *vpos = scan_vpos;
> +       *hpos = scan_hpos;
> 
>          /* Get optional system timestamp after query. */
>          if (etime)
> @@ -1783,16 +1790,11 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
> 
>          /* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
> 
> -       /* Decode into vertical and horizontal scanout position. */
> -       *vpos = position & 0x1fff;
> -       *hpos = (position >> 16) & 0x1fff;
> -

Move the "*vpos = scan_vpos" and "*hpos = scan_hpos" assignments back here?

This change increases *vpos and *hpos from 12 bits to 32 bits. Please 
comment it in commit message.

>          /* Valid vblank area boundaries from gpu retrieved? */
> -       if (vbl > 0) {
> -               /* Yes: Decode. */
> +       if (scan_vbl_start || scan_vbl_end) {
>                  ret |= DRM_SCANOUTPOS_ACCURATE;
> -               vbl_start = vbl & 0x1fff;
> -               vbl_end = (vbl >> 16) & 0x1fff;
> +               vbl_start = scan_vbl_start;
> +               vbl_end = scan_vbl_end;

This change increases vbl_start and vbl_end from 12 bits to 32 bits. 
Please comment it in commit message.

>          } else {
>                  /* No: Fake something reasonable which gives at least ok results. */
>                  vbl_start = mode->crtc_vdisplay;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> index 49a29bf47a37..9390154c12a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
> @@ -33,7 +33,9 @@
>   #define amdgpu_display_hpd_get_gpio_reg(adev) (adev)->mode_info.funcs->hpd_get_gpio_reg((adev))
>   #define amdgpu_display_bandwidth_update(adev) (adev)->mode_info.funcs->bandwidth_update((adev))
>   #define amdgpu_display_page_flip(adev, crtc, base, async) (adev)->mode_info.funcs->page_flip((adev), (crtc), (base), (async))
> -#define amdgpu_display_page_flip_get_scanoutpos(adev, crtc, vbl, pos) (adev)->mode_info.funcs->page_flip_get_scanoutpos((adev), (crtc), (vbl), (pos))
> +#define amdgpu_display_page_flip_get_scanoutpos(adev, crtc, vbl_start, vbl_end, vpos, hpos) \
> +       ((adev)->mode_info.funcs->page_flip_get_scanoutpos((adev), (crtc), \
> +                       (vbl_start), (vbl_end), (vpos), (hpos)))
>   #define amdgpu_display_add_encoder(adev, e, s, c) (adev)->mode_info.funcs->add_encoder((adev), (e), (s), (c))
>   #define amdgpu_display_add_connector(adev, ci, sd, ct, ib, coi, h, r) (adev)->mode_info.funcs->add_connector((adev), (ci), (sd), (ct), (ib), (coi), (h), (r))
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index 7c784277396a..7033531001cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -277,8 +277,12 @@ struct amdgpu_display_funcs {
>          /* pageflipping */
>          void (*page_flip)(struct amdgpu_device *adev,
>                            int crtc_id, u64 crtc_base, bool async);
> -       int (*page_flip_get_scanoutpos)(struct amdgpu_device *adev, int crtc,
> -                                       u32 *vbl, u32 *position);
> +       int (*page_flip_get_scanoutpos)(struct amdgpu_device *adev,
> +                                       int crtc,
> +                                       u32 *vbl_start,
> +                                       u32 *vbl_end,
> +                                       u32 *vpos,
> +                                       u32 *hpos);
>          /* display topology setup */
>          void (*add_encoder)(struct amdgpu_device *adev,
>                              uint32_t encoder_enum,
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> index 7de7adc8f225..8bbef608c5dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -256,14 +256,26 @@ static void dce_v10_0_page_flip(struct amdgpu_device *adev,
>          RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset);
>   }
> 
> -static int dce_v10_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
> -                                       u32 *vbl, u32 *position)
> +static int dce_v10_0_crtc_get_scanoutpos(struct amdgpu_device *adev,
> +                                        int crtc,
> +                                        u32 *vbl_start,
> +                                        u32 *vbl_end,
> +                                        u32 *vpos,
> +                                        u32 *hpos)
>   {
> +       u32 vbl, position;
> +
>          if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
>                  return -EINVAL;
> 
> -       *vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
> -       *position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
> +       vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
> +       position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
> +
> +       *vbl_start = vbl & 0x1fff;
> +       *vbl_end = (vbl >> 16) & 0x1fff;
> +
> +       *vpos = position & 0x1fff;
> +       *hpos = (position >> 16) & 0x1fff;
> 
>          return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> index 3c1d6901127d..2181fe57dfdd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -220,14 +220,26 @@ static void dce_v6_0_page_flip(struct amdgpu_device *adev,
>          RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset);
>   }
> 
> -static int dce_v6_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
> -                                       u32 *vbl, u32 *position)
> +static int dce_v6_0_crtc_get_scanoutpos(struct amdgpu_device *adev,
> +                                       int crtc,
> +                                       u32 *vbl_start,
> +                                       u32 *vbl_end,
> +                                       u32 *vpos,
> +                                       u32 *hpos)
>   {
> +       u32 vbl, position;
> +
>          if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
>                  return -EINVAL;
> 
> -       *vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
> -       *position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
> +       vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
> +       position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
> +
> +       *vbl_start = vbl & 0x1fff;
> +       *vbl_end = (vbl >> 16) & 0x1fff;
> +
> +       *vpos = position & 0x1fff;
> +       *hpos = (position >> 16) & 0x1fff;
> 
>          return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> index a17944d5e843..1388f2161ae8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -204,14 +204,26 @@ static void dce_v8_0_page_flip(struct amdgpu_device *adev,
>          RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset);
>   }
> 
> -static int dce_v8_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
> -                                       u32 *vbl, u32 *position)
> +static int dce_v8_0_crtc_get_scanoutpos(struct amdgpu_device *adev,
> +                                       int crtc,
> +                                       u32 *vbl_start,
> +                                       u32 *vbl_end,
> +                                       u32 *vpos,
> +                                       u32 *hpos)
>   {
> +       u32 vbl, position;
> +
>          if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
>                  return -EINVAL;
> 
> -       *vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
> -       *position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
> +       vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
> +       position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
> +
> +       *vbl_start = vbl & 0x1fff;
> +       *vbl_end = (vbl >> 16) & 0x1fff;
> +
> +       *vpos = position & 0x1fff;
> +       *hpos = (position >> 16) & 0x1fff;
> 
>          return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f49cc198fb0d..f77054060d87 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -186,10 +186,13 @@ STATIC_IFN_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
>   }
>   EXPORT_IF_KUNIT(dm_vblank_get_counter);
> 
> -STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
> -                                           u32 *vbl, u32 *position)
> +STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev,
> +                                           int crtc,
> +                                           u32 *vbl_start,
> +                                           u32 *vbl_end,
> +                                           u32 *vpos,
> +                                           u32 *hpos)
>   {

The variable names vbl_start, vbl_end, vpos and hpos are less 
descriptive than the original ones below. Let's use original variable names.

> -       u32 v_blank_start = 0, v_blank_end = 0, h_position = 0, v_position = 0;
>          struct amdgpu_crtc *acrtc = NULL;
>          struct dc *dc = adev->dm.dc;
> 
> @@ -207,18 +210,16 @@ STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc
>          if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
>                  dc_allow_idle_optimizations(dc, false);
> 
> -       /*
> -        * TODO rework base driver to use values directly.
> -        * for now parse it back into reg-format
> -        */
> -       dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
> -                                &v_blank_start,
> -                                &v_blank_end,
> -                                &h_position,
> -                                &v_position);
> -
> -       *position = v_position | (h_position << 16);
> -       *vbl = v_blank_start | (v_blank_end << 16);
> +       if (!dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
> +                                     vbl_start,
> +                                     vbl_end,
> +                                     hpos,
> +                                     vpos)) {
> +               *vbl_start = 0;
> +               *vbl_end = 0;
> +               *vpos = 0;
> +               *hpos = 0;
> +       }
> 
>          return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 089741ba0619..2819b58e8a9e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -1167,7 +1167,8 @@ int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
>   void dm_bandwidth_update(struct amdgpu_device *adev);
>   u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc);
>   int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
> -                          u32 *vbl, u32 *position);
> +                          u32 *vbl_start, u32 *vbl_end,
> +                          u32 *vpos, u32 *hpos);
>   struct dm_atomic_state *dm_atomic_get_new_state(struct drm_atomic_commit *state);
>   struct drm_private_state *dm_atomic_duplicate_state(struct drm_private_obj *obj);
>   void dm_atomic_destroy_state(struct drm_private_obj *obj,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> index a67774e6db36..4180f519b57b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> @@ -158,15 +158,19 @@ static void dm_test_vblank_get_counter_no_stream(struct kunit *test)
>   static void dm_test_crtc_get_scanoutpos_invalid_crtc(struct kunit *test)
>   {
>          struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
> -       u32 vbl = 0;
> -       u32 position = 0;
> +       u32 vbl_start = 0;
> +       u32 vbl_end = 0;
> +       u32 vpos = 0;
> +       u32 hpos = 0;
> 
>          adev->mode_info.num_crtc = 1;
> 
> -       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, -1, &vbl, &position),
> -                       -EINVAL);
> -       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 1, &vbl, &position),
> -                       -EINVAL);
> +       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, -1,
> +                                                    &vbl_start, &vbl_end,
> +                                                    &vpos, &hpos), -EINVAL);
> +       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 1,
> +                                                    &vbl_start, &vbl_end,
> +                                                    &vpos, &hpos), -EINVAL);
>   }
> 
>   /**
> @@ -177,8 +181,10 @@ static void dm_test_crtc_get_scanoutpos_no_stream(struct kunit *test)
>   {
>          struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
>          struct amdgpu_crtc *acrtc;
> -       u32 vbl = 0;
> -       u32 position = 0;
> +       u32 vbl_start = 0;
> +       u32 vbl_end = 0;
> +       u32 vpos = 0;
> +       u32 hpos = 0;
> 
>          acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
>          KUNIT_ASSERT_NOT_NULL(test, acrtc);
> @@ -186,9 +192,13 @@ static void dm_test_crtc_get_scanoutpos_no_stream(struct kunit *test)
>          adev->mode_info.num_crtc = 1;
>          adev->mode_info.crtcs[0] = acrtc;
> 
> -       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl, &position), 0);
> -       KUNIT_EXPECT_EQ(test, vbl, 0U);
> -       KUNIT_EXPECT_EQ(test, position, 0U);
> +       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0,
> +                                                    &vbl_start, &vbl_end,
> +                                                    &vpos, &hpos), 0);
> +       KUNIT_EXPECT_EQ(test, vbl_start, 0U);
> +       KUNIT_EXPECT_EQ(test, vbl_end, 0U);
> +       KUNIT_EXPECT_EQ(test, vpos, 0U);
> +       KUNIT_EXPECT_EQ(test, hpos, 0U);
>   }
> 
>   /**
> @@ -1211,14 +1221,20 @@ static void dm_test_crtc_get_scanoutpos_unmapped_stream(struct kunit *test)
>   {
>          struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
>          struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
> -       u32 vbl = 0xdeadbeef;
> -       u32 position = 0xdeadbeef;
> +       u32 vbl_start = 0xdeadbeef;
> +       u32 vbl_end = 0xdeadbeef;
> +       u32 vpos = 0xdeadbeef;
> +       u32 hpos = 0xdeadbeef;
> 
>          dm_test_crtc_with_stream(test, adev, dc);
> 
> -       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl, &position), 0);
> -       KUNIT_EXPECT_EQ(test, vbl, 0U);
> -       KUNIT_EXPECT_EQ(test, position, 0U);
> +       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0,
> +                                                    &vbl_start, &vbl_end,
> +                                                    &vpos, &hpos), 0);
> +       KUNIT_EXPECT_EQ(test, vbl_start, 0U);
> +       KUNIT_EXPECT_EQ(test, vbl_end, 0U);
> +       KUNIT_EXPECT_EQ(test, vpos, 0U);
> +       KUNIT_EXPECT_EQ(test, hpos, 0U);
>   }
> 
>   /**
> @@ -1229,14 +1245,16 @@ static void dm_test_crtc_get_scanoutpos_exits_idle(struct kunit *test)
>   {
>          struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
>          struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
> -       u32 vbl = 0;
> -       u32 position = 0;
> +       u32 vbl_start = 0, vbl_end = 0;
> +       u32 vpos = 0, hpos = 0;
> 
>          dm_test_crtc_with_stream(test, adev, dc);
>          dc->caps.ips_support = true;
>          dc->idle_optimizations_allowed = true;
> 
> -       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl, &position), 0);
> +       KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0,
> +                                                    &vbl_start, &vbl_end,
> +                                                    &vpos, &hpos), 0);
>   }
> 
>   static struct drm_atomic_commit *dm_test_alloc_commit(struct kunit *test,
> --
> 2.55.0

