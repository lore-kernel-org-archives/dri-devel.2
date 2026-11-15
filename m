Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179AD606A31F
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MdUPQ0w0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4158110E36E;
	Sun, 15 Nov 2026 23:47:47 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224F510E0AC;
 Sun, 15 Nov 2026 23:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUc+1aPlE8+N0pZxmlUs73RzeJh2bhJ8ThtTqz9aMjeOkJxBcNUIOH7hSOiR6F0qagirlfonpUBNB6Bz686mwlPRpCy9qCDP9+kpihC2a3mPcZbDuCInGrz3RnxZio/ep8XiWi5U7EwBbaqujSC39jbZwgPjiyHiZ1rIRLg4BPsVIpl8w8PEFPg9t97IT7LQbRkmI+6MZ7KbTyKFWZpfjfzjzTpNqQIzey6HUjNmml7aHlGgqFHwj9ATN8UoDFcN8BJvRFurKOkeEdIiO3i0zCik7ga4VZe9vQ53SUnA4ftIlfQJGq8rJwDvj8zBEUKmUBqVjT0eL9OoCbkrGglmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1xPnIsX/qon71ekIa3b2Fhf/asc8240gRK7bVj6l/c=;
 b=VjRKvjB36l9i2NOEEVrjyCWtpVof1BzafVDq6qmy/h3YaE9zjWIPRfvUXy6+A2PtLRM1zcSv0tPUZSlPpbaxDr7ZDAuPI/rzIPKlgSw/WQorbDwqLjc7e/rL8PryjbL+xHltfV2Gk+QVdiks6+87vqgTvBu7jGLrBOSkr3WPrYQw8NV40XufpZCyhVwlEDRB67Kn3AhesIgk04hUoBPL3QU4JkrwRP7yS2E7QajWrbbCBdCayylMsDaXo4JHrG9rYt0V9TCFaj3N2Xr+IfMb+fTy6uh28IAWIWBXuNZ+Jo7ST69rsvDC6Sxj6j4G8yDO+TgEpsXv/03vKbunNyzZ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1xPnIsX/qon71ekIa3b2Fhf/asc8240gRK7bVj6l/c=;
 b=MdUPQ0w0X92GK5z8lOTyKBvvWDLDyBJDxlriwRAMNX9KhJ0NJHBHb0iEUgH6ycefvEhjBIE1QHIHbXesGXim7Ht2UZQjSzo2RL4/u8HxUAuhnez4vbsT8vpLBvVeyZgf3YjLtgSY/eDgn0afA98pcb8c3VGxNYhMrhuidGVqoN4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by CY5PR12MB6036.namprd12.prod.outlook.com
 (2603:10b6:930:2c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 23:47:37 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%6]) with mapi id 15.21.0615.013; Sun, 15 Nov 2026
 23:47:37 +0000
Message-ID: <fd0f7746-ff00-4dc9-a5a5-c10611b94aad@amd.com>
Date: Mon, 16 Nov 2026 07:47:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Restore PSR-SU guard in power module
To: Egor Perevoshchikov <rickbatra0z@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20261031040051.46100-1-rickbatra0z@gmail.com>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20261031040051.46100-1-rickbatra0z@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0058.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::17) To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e180ac-5d54-42a8-44e8-08df4372d408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|5023799004|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: MKqatpU7mQ9zxT7Pg7Norh3tYu9dQorTjbQkQDiU+3npj/vvXVN+r+GivtrYjBNrWcLRuyQ/H0U6WnyXF4ErnpL2P6ZiDxolkS3lxtc7VtJv+22wO4Jig52k1JqtlGNnoMYmVD4pXFOVMU8A2qlpRuhN7Y7joNmdhb2aDX+iLgyarUu8oalSoD5l716vFqlFqJL3OqBzxhg/+W5KvZUfj2+zbbK/fmIkKXuRAj9SilkhqXcVHwnX0xpk4rqPmf3f3lTQCN2Q8fnjwFFAiu/XYxIhPkiB+VvOFnzAFnoLTkYPrhOJQipgYTVhOCX1m3pTy+Vwgb9kuGDy3vkHa9IUt4ZUPa/1LhcVBxSZBgO+Jzv6nC4YHIEWH0jqidBw2yn7Z9O/MfbB1Xb4D8Bi4nIMKdjYe0l55DqLLPnOSYOnWw6Ac5Ov8vdII0VzmdoS5yCrnujyBNvwvme6KRD5O1SvofnSVLlgxoNyWXSsy7mUSS0cc2Rons8FOC+LMmz+kjJ85jS6fh7NsvWWZJmT3pR5FuD1UtdSjyLEWO1CMqJVojgNGw7pi+7+nmTG1AdmRkV/8ZwaQUSW5CCnfCG/YWqDCV6a6sXpVUfbCO0IF5ByxJg0pLsGWQ7nrxUha10jBssu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(5023799004)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L01GcGdWRksrZkNBRmJtTTdSQlBtQU5iU2VOMzVRc3plbVJLRmp2RXgyTllm?=
 =?utf-8?B?anNvRFVlZXRlc2oyZHBmN1dmdFFzaEdmbU1ZRFlLNmZ6RW52NlV2RmptZC8x?=
 =?utf-8?B?OFVSeUNRTEtkd3UrRFpVb3BzREhBeHIycVYrdFNDVnpBdTVvVzVhY1Z0T0pB?=
 =?utf-8?B?U29NU2lrR1lrSmQ2ZU92M3R6UXVKN05zNHFVWEpMNHVmM3Ivcy92WjEyMUY0?=
 =?utf-8?B?SFB1VmVXR0tnY2owRnFmRFhCdzBGNldNaHhmSzlxaFp3aVhtK3d2enhyQmNn?=
 =?utf-8?B?eW5PK2w4VmYxdWpkZWU3cWI0NExLY2hMRVhhbm5sV2ErTzgrV010ZW5QZk5Q?=
 =?utf-8?B?b0JLZ3ZLR09TV3lDRUJQM2tLTkV1QU12MGNCU0VmUmxaVTRjQzV4YVNHMWRY?=
 =?utf-8?B?ZXFzS01GS0F4aHAxNGJqd1NZMjNCZzd3QXY1Vi9HWnBhWExrODMyR1huU1BJ?=
 =?utf-8?B?L0N0ZFJ4QnZtZUJBNWRFZXRqU2l4R3FoOEVHRmxQNmpscFJpakpVdGpFa2Nm?=
 =?utf-8?B?d1pGSkplK1oyRFlZWXhOZlUvV1RJV3NqckhqM2Q0TEJvM1MxR0RzY1Zaek5q?=
 =?utf-8?B?N05RN1pXN1RVNjhmbjdpOG82REN5K1JhNkU5Z2ZLWTE3STZ1cnBjRmxWOTV1?=
 =?utf-8?B?d29sUWFpc01LeDUxSmNRZFUxam1Ka2VrRldrMjZtYzQ5L29RQ1FmZVZUanlB?=
 =?utf-8?B?WjI5L09WVFFOWHV1WDFWaDk4ck1paDR2REVqd0lyUzRyNlZaRnRaTWR1TytF?=
 =?utf-8?B?VGRuaEhMVGpaRXgzVWhwWEFhTEFKcFJSKyt5US9oZG1vcmZYdjFlRFMwOS9y?=
 =?utf-8?B?SjV2QWhPdzlXekJBaWNuVHdrWGtJcHA4TUcwTFlXSFM3MFVBQU0rYW82RTRi?=
 =?utf-8?B?UklwV2REM1pJU21SUXRNbzQ2U0dOWDBBNVlNeFFmRmJHNTVKKzJ1cEMwVGtz?=
 =?utf-8?B?WTRQZHdCdi9yYmoyWG1lQUJQWlhyTGszc2ZtVTNVa2t4L1dIM0crbzJYblV3?=
 =?utf-8?B?SDdCNFhxZlR4OVNibnNmanAwRk90cStycENzWW1KeGI3UGZhOElkdWx0dVdZ?=
 =?utf-8?B?SGtwdXZ0K3B2NjJoU0crV2pVYnNiVFYwTGxEMGkyK3JGOXhISmwzTUVUUnVy?=
 =?utf-8?B?UUo2S2d5ZEdIcmZObjhpMlQxTVBRQzdidE5CZm9QU2FwczB6eTl6VUhtWS9I?=
 =?utf-8?B?dnJDcW1QUkFHS3p3Qlg0Y05nSzU0VWNVLzZ0b2pIdWowY2ttTWNjanFud0JB?=
 =?utf-8?B?aStCbHg1Ymh4dlBDUVBuRnhZNUd2c3VmTHdOeGt0M20xMmhia3pqcmFHLzlW?=
 =?utf-8?B?LzlqNjd6QTFzRUl1NnNuRloxVjVRWGM2Y041RHFYeDVQZ0dJbTNOaHdabHZV?=
 =?utf-8?B?TUQxV0dENFR6eE56WFk5enZNcnJzSzNRQXZRWW1wSHFFVWNhbGlqYnR5V1pa?=
 =?utf-8?B?djRzU2dMVHcxTGpVWVRDOWM4dDBtMEtxbDBmK284a0tORzA5M0Z0SFZKckQ0?=
 =?utf-8?B?czExQkN0RlVsc1ZpVkQvQ3JCbnpqTXFYOGFQTUI1UVhQZTB3cnVWUFk2cS9O?=
 =?utf-8?B?OTVaaVlrT2xJS2hpSjM2OU5wTkhPclpFK3pYZHhZVWdlUXNvK01PV3JqZGRQ?=
 =?utf-8?B?VUFXRjNEQVBoeHpvNnlFMGtIVXVSdERNd2pzVFpmR3JOQjJYaXlXYU9tT2lX?=
 =?utf-8?B?SkVDV0lnRVdhZVh1MkgzczlWaHVldjA1NzZFQmkrTDkwd3ZhUXlZeXV5ajN4?=
 =?utf-8?B?TVBjeDd4TWNNZXNJRHZabDErMXJ2ZGpETDNLMkdKTUN1MDMwSXNFSmhmK1pj?=
 =?utf-8?B?SFl3RytXd0NITDdRK1ZOM1FldG9aZlpjaGtBWHpTTE9FRE81NnA0WTBURHNT?=
 =?utf-8?B?STVsSjVlclVvaUROR09SQS9HNEkrajVFRjhQbi93NkpSdmJCWFo0RHcrK1hW?=
 =?utf-8?B?SUMwd3psU2VxYVd1OVB2c2ZHUHVQdVhXbXNQVFpVQWphdjU0a3FnRE9wOWVu?=
 =?utf-8?B?VWlENnBVRFJ2VGZ3anZaeUxrY3JHd3FTNEhkdTkrSXB2aXJKRm83c1hLUE9i?=
 =?utf-8?B?WnpkSTJWb3k3RE95Qk5MOXRhY09YN1NtRlMwWTNwbDA0T0dwTW4rYzBscmhP?=
 =?utf-8?B?U0VHR2J1UjJ4emxTcWt0Z3BUVzBUbTFzdi9CY2F1SkNpSy9BcFdkVmhLR0d6?=
 =?utf-8?B?UTF0dktydENiRzNvMjlRUXU4dXlrWWRrM043QUhkS0huNlhzdk9sL0x4UkJu?=
 =?utf-8?B?MDI2QXZKRHVPR0J5NlZVNmVmOWtzMGV2b216SzVVeDMwUytvWmtGWFNqaUNz?=
 =?utf-8?B?SHV0bDlHSVZmRG1iazJNQkZzWWZraXZNTmduUmEyR3ZSN0RTNDNSQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e180ac-5d54-42a8-44e8-08df4372d408
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 23:47:37.3952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nksVriRW0Dd6r47xSFFFz5dPYTNwfJI1iLNqzBYC8OaDVWERl49u3DHuXXZ+Q/E2cDnJlGUc0becUuEUrzrsuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036
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

Reviewed-by: Ray Wu <ray.wu@amd.com>

On 10/31/2026 12:00 PM, Egor Perevoshchikov wrote:
> [You don't often get email from rickbatra0z@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Commit a5ce8695d6d1 ("drm/amd/display: Avoid configuring PSR granularity
> if PSR-SU not supported") restricted DSC slice-height configuration to
> PSR-SU. The power-module integration removed that guarded caller. Its
> replacement in mod_power_psr_notify_mode_change() calls
> psr_su_set_dsc_slice_height() unconditionally and ignores its return value.
>
> On PSR1 links with a DSC slice configuration, this applies a PSR-SU-only
> alignment check even though selective update is not enabled. If the
> calculated DSC slice height is not a multiple of the nonzero advertised
> SU Y granularity, the helper triggers an assertion. It also sets
> dsc_slice_height before failing the check, so the caller passes this
> SU-specific value into PSR1 setup despite the failure.
>
> Restore the PSR version guard and failure handling in the new caller.
> PSR1 proceeds with the zero-initialized DSC slice height, while PSR-SU
> retains its alignment validation and stops setup if that validation fails.
>
> Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3027
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Egor Perevoshchikov <rickbatra0z@gmail.com>
> ---
> Tested on a Xiaomi Redmi Book Pro 15 2023 (TM2209), Ryzen 7 7840HS /
> Radeon 780M, BIOS RMAPH5B0P0909, with Linux 7.3.0 on NixOS.
>
> The tested panel uses PSR1. Its 2000-line mode has 16 vertical DSC slices,
> giving a slice height of 125, which is not a multiple of its advertised
> SU Y granularity of 4.
>
> Before the patch, boot produced:
>
>    WARNING: .../display/modules/power/power_psr.c:666
>      psr_su_set_dsc_slice_height+0x7e/0xa0 [amdgpu]
>      mod_power_psr_notify_mode_change+0x1b7/0x270 [amdgpu]
>      mod_power_notify_mode_change+0x160/0x1d0 [amdgpu]
>
> After rebuilding and booting with the patch, that warning is absent.
> With VRR disabled, repeated debugfs reads report psr_state=6 (PSR_STATE3)
> both with and without the patch. PSR remains functional in both cases.
>
> The older dsc2_disable warning in #3027 is no longer reproduced on this
> kernel. This patch addresses the remaining psr_su_set_dsc_slice_height
> warning; it does not modify the dsc2_disable path.
>
> The patch is based on the mainline v7.3 release:
>    c03c1a14507dfaf8b856c2608f9ac216021fc222
> This matches the kernel release used for hardware testing. The original
> power_psr.c is identical to the Linux 7.3 source used for the
> hardware-tested patch.
> The patch also applies to drm-next-2026-10-31:
>    f94ed3d7cba3c83eef50b1a96d630d63cf54f69c
>
> Additional validation covered eight cases in an isolated C harness using
> the actual setup and slice-height functions with hardware calls stubbed.
> The original PSR1 warning was reproduced; the patch avoids it, retains
> valid PSR-SU setup, and prevents setup after failed SU alignment
> validation.
> The patched translation unit was also compiled against Linux 7.3 headers.
> PSR-SU behavior has not been tested on PSR-SU-capable hardware.
>
> LLM assistance: source history tracing; stubbed software tests; submission
> checks.
>
>   drivers/gpu/drm/amd/display/modules/power/power_psr.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_psr.c b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
> index 96bb77fff05..7139395b5c0 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_psr.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_psr.c
> @@ -94,9 +94,12 @@ bool mod_power_psr_notify_mode_change(struct mod_power *mod_power,
>           * The value of DSC slice height is determined in DSC Driver but it does not
>           * propagated out here, so we need to calculate it as below 'slice_height'.
>           */
> -       psr_su_set_dsc_slice_height(dc, link,
> -                               (struct dc_stream_state *) stream,
> -                               &psr_config);
> +       if (link->psr_settings.psr_version == DC_PSR_VERSION_SU_1) {
> +               if (!psr_su_set_dsc_slice_height(dc, link,
> +                                                (struct dc_stream_state *)stream,
> +                                                &psr_config))
> +                       return false;
> +       }
>
>          dc_link_setup_psr(link, stream, &psr_config, &psr_context);
>
>
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> --
> 2.56.0
