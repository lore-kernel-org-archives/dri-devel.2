Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62139606A337
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=C/cUC2Ru
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC63610E218;
	Thu, 26 Nov 2026 12:33:09 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5018F10E218
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:33:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU6d4Y87nsphb6fp6kkI0uwIbXXNUSaFXsGRm8EhEOI2nV8DmJrirfsw277MxWI2K+fvoNCM7cmE+9qI2DcV2dTiHdsb1tg8q7QThfLcQ9lauq5+br5c7nPMTsxh3sCfKtTBfjvQMIiV61Grku/17D3uFgWyFGXOMQx1i7WpQ/YWoG+LzUZv0AEYbxSMKwYd0sCzQvWZvSN9knTuu5N6ntrFaPcLqyspVzImL8KfjS03WzQ+kSsRxr+oU+wph5ecn4u3UkgTJOv3p2X3dbqIom/rWCQWlA1vOwQ8rQWWuh7M62dv3TqYB+rI8KXy43S9V8oLY7Mrx2UJnH5xFU6j0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yhx1sqU6Rv7xuhEi7mMmbcEQjAQY/jDEfdz4mnR2duw=;
 b=rIc9KmjaIzt0ck84hM35inD15AHGer2JP4DUbxPD6D1D79S77KZz69UhfBJZiX3GYfJyYgn67zphnaMayTLL7VNIPycu1QqmozgGg2XPbqSQB6kxz2/BzipkNE6XfEJXojGfbdZF+Wpdb8nC02w0L3S7syehrcoICJ0PIreYd/EP/7GoBT2P4YI/1XkJuDb2jmIkcT3e3TxWSdRl3+aFQ7UYOwSON/hc+n2gnJX+3US2bmdqMu2rPVEgygKdexEyqGf1Pku8V9VwLVfoZe0PVh+aojZlAadmcX7ZQR2Sa5KFur+4u+nb086AhMu3hRWGGVWUf9N9zD1We39ON/E60A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yhx1sqU6Rv7xuhEi7mMmbcEQjAQY/jDEfdz4mnR2duw=;
 b=C/cUC2Ru8XAjgVSZDY1yMG/L9f8oJA4pxD4H6Ev3EVefUP5LQmtJAX8eau2tT60lRkhwjm9eyLKpBaTAtSwdO7SyCYQfDQtoCTU7SpusIq6RYPQ3yD0twbtbLZZ+sktKvA8EDndLBb0Zd2znjfroRA4KRviM+FO4ZIY0ezAukTo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB7965.namprd12.prod.outlook.com (2603:10b6:510:270::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 12:33:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 12:32:59 +0000
Message-ID: <fdd06e49-e74e-4991-9c87-216ece29ee7c@amd.com>
Date: Thu, 26 Nov 2026 13:32:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/drm_exec: fix kernel-doc string in drm_exec_retry
To: jakov novak <jakovnovak30@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20261015135029.22698-1-jakovnovak30@gmail.com>
 <CAPUiDP1_t1YNG5=HfQZ6wp_TRH2qoSseojJjWgpzQ535NE1RqQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAPUiDP1_t1YNG5=HfQZ6wp_TRH2qoSseojJjWgpzQ535NE1RqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB7965:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ad4b0d-4d1d-4e12-63ac-08df4bb967e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261102123227099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: Ylju3JBV7G8rjnHtWoQGWolRhbisWMIvprBU/ky8p+P8TNHzTnit+ZFNKvdaqvsq7pB6UgRT4bxMXHcz7QGeostuLQny9rCwzbTLoIgiY6tomYt53I85rCJCuNlgUsYGyVV9gCtnPUojyU0M7oXGMLWeqQNRTOxaEnWSVWZgM0bLo860+c1CwUNmwrNDV4kY3Ate++RpyvgrvnzR82weVevCCfn5/62qT0B8DLLGCB/mGz271pHnWcKkYtiVq1BhC96LtK2c7+ih2r2IkENbJaBrf1aTGN+IjlZuxWi1hJMHzj8PiBkKCHWUSa0e+5F4ycVaaUIub3X2XmPljIXXo/73IJvyXP5Knauz/gpzdqT9mCS5CdMfT8z68RwBbEp+fCd3tZJ7ODIoBkveas6t0XIwJBnrb7fL3X4xi3Kj77/dMrf4pU6RoIreNOXGBkvTyAYKpH0tm71VEyPGfs525km4d+Go3189LKYwPD1OIYF5A87sKKYwRlVUvfTSGcZNxeXTVXzNAUc93U69kNyhu6OsP/JJL42pIAswjoutr5KyAzjgdh+8///WuMeDWu29aGtZYChkTW85IJrvt4sFPRrkDsK4rALZltmU+InuzNPvU6kY/DzyYAIXZBkjCRz0HBCha+mIAlhEOPtWSbCKLjc/KWP1JgwDWI88j+YFtxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261102123227099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEliU2NqTW5nQ3cyak92T2xNaDZWTDFWNmpDaXNBODlMbThWZFN6NU1JN3M5?=
 =?utf-8?B?dW82L05zVEdOYzVlb3NQdWRHbUdiakt5RXZ6NGFscTNGblN0dHJMUzZtbDBY?=
 =?utf-8?B?d1RralBROVMvaGF5d0FuV09ralZCbGUyOWZRZTZhUUhScHZ4a3UybVFkNnM3?=
 =?utf-8?B?SUFCUTYxNElmcTluYVdxb1FVYVZRVUFPVzFMT01qMVo1SVpoSHg3WVlVUDF1?=
 =?utf-8?B?dUpFeTB0MjBIWGJ3eC8zUTU4VXJaTXhFd3lXODVIZkhqTjJsNm4vR0xYemxK?=
 =?utf-8?B?ZXJCL2l1YkNUMGRQdHpHZjN2eXhqWTNoMzhQN01ySE1VT0Q0WTVvU0NRMU1H?=
 =?utf-8?B?YnIvT2hOd2l5VGNsU1Z6SStMOHEzQnRoQ2hDZWoyNE9CRGF5M1RubmdJM3l6?=
 =?utf-8?B?RVJnQjhPeHJoek1Ja2krTUhUWW1qQUVNSjV4eW9RdCtaK1lMeFk3WWJxQS9M?=
 =?utf-8?B?QzY2WWJHSHUzUTVQdGszYjdFdExSa0p6YUxkemo4cTJkSVZsUFArRFNybzBQ?=
 =?utf-8?B?Z05LV3pCU2NlcU5qVitPLzlTUDZ6a1pYRWxZQnEvdXNDZzR1VlFwbWV6Sm9j?=
 =?utf-8?B?Y1pyaW9TSjFLYjg2TDJVYlZiSTBCYTJPTTVTN1pXamQ3aHB6aHFZbldlNTJE?=
 =?utf-8?B?S1JUNDlPeHVoZW9VWFhERFcwZFhSei9RL05KUXE0cG8xeTdDdEJlZWo5VGZw?=
 =?utf-8?B?L25hOUlISDJKOGRKbm1aVkIrcm5RQWZscEh6Vk5PbEZIWHdEbFYzTnoxUzla?=
 =?utf-8?B?Smk4VFFZVHNVZTV6TWRKcU9kK3ZyWFMvc1Vob295MUNFQi83Q0dpTE9QdlVC?=
 =?utf-8?B?OS9ZZUE4NFlCalZPRjcwZGoxWmxweE1QRTN2MzhRZlhGSi9zZWV4QUtMamJJ?=
 =?utf-8?B?MHkvSFYxaEsycXdhS2VPMGZNUFU3TVVxVnJWYzNzejY4elRmN3hHbFczY0pH?=
 =?utf-8?B?R3J1STgwNWhlWWFPRW9aOVdIeS82aDRqMHdQOVBkTGdJRFk0RlE0SEkwRW5z?=
 =?utf-8?B?R09SRWNWclVpQ3BIZWd5Qi9sK3U5OCsxVnR3dnFGN1o5bm1DR3RCQld6SjFq?=
 =?utf-8?B?cEkwR29ZaVdDVnIwVk5BNkFuRTBPdHpBSHBjSExXZHYvS2NDc1J0YXRyb2JK?=
 =?utf-8?B?bjhSbUlRcWpiZ2ZKcFM3dUVNSFdUUHhzelpuNGlUNlpiUkFQUDMwLzlZaUQr?=
 =?utf-8?B?TXRadkk5Wks3c1FvOHJlQ0tXY3NUQmlyNE4yRHNWeHRUbTYyVEtSWG56WUV6?=
 =?utf-8?B?eE1FcUpyQTRMTUZTTkF4TVFBOUxlekppbFhTZS83Vm1mamJCYUhOYmphdGFa?=
 =?utf-8?B?VFpiYTJ3YjFZd2tVanZad1dQam5CcnlwdG56VG9GOUtvbm93ZG5BR0l4WFF4?=
 =?utf-8?B?cWJjd3pxLzZ2RlEyM2t5bjIzZkt0TUs4QTNKVHRZZW9EUmlWdldUMC9JRUlN?=
 =?utf-8?B?MENRTExpU3o4eVU0TXNmclljZTJWUmgrYUxXamhkaGNiVVpUVjRJM3dwcUkv?=
 =?utf-8?B?MkZWdjRmbHhhUTMrK3pqTmtDNGlTZmFMYnVCUFRsRkg5cU1wUTZkYUp2TGFF?=
 =?utf-8?B?QlpJL0xWeWs5YVM5eDAyWkFxUUUrL2EvZWNpNjZHcUNtcEl2MG10bVJWczFl?=
 =?utf-8?B?b1Y3ZXhDZFJ1dWVzYjdGTDd0RGxIYVN5aG16dEpLM3RRYzN5b2cxdnZGb3ov?=
 =?utf-8?B?Nk9ldlZvSWlWOGlvYjFIVyt4VWh5WjdCbXlGQnpSNUZ0dE5jN3VpaGVrZHZ1?=
 =?utf-8?B?MjJyU0lqaW5Fb0l2SGcyZnJTMFdLZU1nWWZSSHpkWHVEQ0ZUR2hwU3RqTUQx?=
 =?utf-8?B?eis2K1ZsK3NBVi9MR1VnNGhCUEFDTXc5YmhPVjhWSlJRVWN5enpyTkdEc3Qz?=
 =?utf-8?B?ekZoTTdBZWk3WU1SOVVyeXNpcnF0c2lSUXhScmlENkxIQzhvR1F2SzlEaEhv?=
 =?utf-8?B?VE1FNkFVOUhzMFZ4T3VXb2ZVTnBtNmF1R295ektkWjZCaUpwMHl3ckhya0VM?=
 =?utf-8?B?YVQ5SnJDQ21KcTBsUDB0OVFZYjVreW9na3pkTUZXVlRlRTdjRmplMnZrcWpE?=
 =?utf-8?B?eWRmL1l1QVN3UWpZR0lQZnVCYUpxcHB1OHBtVTBMYUdiL0JuREpXWldpVjA1?=
 =?utf-8?B?azk5eENNdzY0NHFyU21CZklXV1djbzFLY3VpaUMxczFoekxmSEN5TzBMRWlz?=
 =?utf-8?B?bGFZemtTajVZSFo1TFhoVVhoVWhmN2o0M0RJL3lVd1kycWxYSXJUWGxGZUM4?=
 =?utf-8?B?bE9iNjk3N2Q3eW9vNTV6aE5PMFpwSVhOU2F2TDZvOUFwVEJ6SHFraCt6V1B5?=
 =?utf-8?Q?a7ZvfVU1/zPGgkU1Rt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ad4b0d-4d1d-4e12-63ac-08df4bb967e7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 12:32:59.6547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFWagXcTG9kIq3dygSDVFjETJFcZLUoo1c1iR64yxx6Y3f03SUekT/Btnb17jnZw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7965
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

On 11/26/26 13:16, jakov novak wrote:
> On Thu, Oct 15, 2026 at 3:51 PM Jakov Novak <jakovnovak30@gmail.com <mailto:jakovnovak30@gmail.com>> wrote:
> 
>     Building the documentation currently with make htmldocs gives the
>     following errors:
> 
>       WARNING: ./include/drm/drm_exec.h:159 function parameter '_exec' not described in 'drm_exec_retry'
>       WARNING: ./include/drm/drm_exec.h:159 Excess function parameter 'exec' description in 'drm_exec_retry' (did you mean one of: '_exec')
>       WARNING: ./include/drm/drm_exec.h:159 function parameter '_exec' not described in 'drm_exec_retry'
>       WARNING: ./include/drm/drm_exec.h:159 Excess function parameter 'exec' description in 'drm_exec_retry' (did you mean one of: '_exec')
> 
>     This is because the parameter is defined without the underscore in the
>     kernel-doc string. Change the parameter name to add the missing
>     underscore.
> 
>     Fixes: bba175a2d4be ("drm/exec, drm/xe: Avoid abusing the drm_exec retry pointer")
>     Signed-off-by: Jakov Novak <jakovnovak30@gmail.com <mailto:jakovnovak30@gmail.com>>
>     ---
>      include/drm/drm_exec.h | 2 +-
>      1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
>     index cc2937185a9f..ae1d074ade5a 100644
>     --- a/include/drm/drm_exec.h
>     +++ b/include/drm/drm_exec.h
>     @@ -150,7 +150,7 @@ static inline bool drm_exec_is_contended(struct drm_exec *exec)
> 
>      /**
>       * drm_exec_retry() - Unconditionally restart the loop to grab all locks.
>     - * @exec: drm_exec object
>     + * @_exec: drm_exec object
>       *
>       * Unconditionally retry the loop to lock all objects. For consistency,
>       * the exec object needs to be newly initialized.
>     -- 
>     2.56.0
> 
> gentle ping... 

Just pushed to drm-misc-next, sorry for the delay.

Thanks,
Christian.
