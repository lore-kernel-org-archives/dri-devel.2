Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49375606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5iQH5EM7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3B0510ED6E;
	Mon, 16 Nov 2026 09:08:17 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A9E10ED6C;
 Mon, 16 Nov 2026 09:08:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+f2aoS7i9JV8RB/L1Fm21kaEjiHb5NvvGd8+5v9oVlD9wy1BBfdRYSnz/5qBB+IrYZoVtRbF54vMRcGhTBRJ4ai8XGWKS0nOuA45nWS/brv4t8JnZ0FifAUOXDf/2QUdlJZAM+xAFj8djavOBDrPwvGjCCjCYx+3J5IE3IE4702X4vDLxXncR8rlXcIbE/0uXbgKxVGCpu2J+09LSfXZex+zIAQPR8rU2bKmzPQeUizbkLq5Dtp/IiL2WtuZdM1tkTy8S6lw0E5nJGGInJolR+ZpspNYS/Zm3OFzr6QtBbZVaGVJVGJj0KaqjEO+kezGxDGRx5g9O4lJq66IFmjTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6GsJiveNwXacXnesIKWN1R2r5LzLES2J9wybZ6aibU=;
 b=ONksKBofoISmKa7bYlzv0km2oCKOZHXss9OOQ5wX9rUqx3UEXQo0fEguw+PC5ghWy17PpI15A7xD6mwXrsEUUmysOeTrja8fm4RCihs96HdVxKXChjHS9JVPvif8H/+byFo2sFgI7czBcwywlt61sQRGdMtq0hnsORhtiSIPXzT6Ongxy4HQLsJqSzllU9O68EEXF45/OXXlSX77LWIKIYH1eJ3dNWZA+An3vXL1DzsmL3QLRbMTCHbyFEod98IG+2qZqSgl89cZvI6N0qnxLFpqQ3Blt7ZOxUJCQvj3aHnh8ZPrcu+/JRzDubTmFqt8RLFaQlizoDOElZnFrUkOvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6GsJiveNwXacXnesIKWN1R2r5LzLES2J9wybZ6aibU=;
 b=5iQH5EM7hoNRGBnC3Co6+5a04FQa886mqX7t1j/16eoYmGQPmbzAmvnX1mBNcb44smgm7bgFVAG76f4Xvi7RTnsxIIg7TKVT+mne6erLtVmrSgU2DcteFPvM1FKK2wmOqv+DBftVPwtqtBMStEaNNlGU35BL99gEmZ5Nla+eWOg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8)
 by SAWPR12MB999117.namprd12.prod.outlook.com (2603:10b6:806:4e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:07:50 +0000
Received: from CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd]) by CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd%6]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 09:07:50 +0000
Message-ID: <737aad6d-24d1-4496-83af-9db8fd93c736@amd.com>
Date: Mon, 16 Nov 2026 17:07:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] drm/amd/display: Commit panel_power_savings writes
 from the kernel
To: hugo@hsal.es, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Alex Hung <alex.hung@amd.com>, Bhawanpreet Lakha
 <bhawanpreet.lakha@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es>
 <20261113-abm-sysfs-commit-v2-4-5808d17a7e89@hsal.es>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <20261113-abm-sysfs-commit-v2-4-5808d17a7e89@hsal.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::14) To CY5PR12MB6132.namprd12.prod.outlook.com
 (2603:10b6:930:24::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6132:EE_|SAWPR12MB999117:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bba067b-9a80-46c1-797b-08df43c116ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|261009221227099003|261009223027099003|3023799007|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|5023799004|56012099006|11063799006|10067099003|261102123227099003|4143699003|261102130727099003;
X-Microsoft-Antispam-Message-Info: KzwrsphkSq/RwZYorTKSzYAaQ2w2riYILWkCe7t3iFJI9/yt9t3T5fl/mf7m7XSMPShkXWL3n5wbKV+CUkaU6I62ykJOh31O73MVUifDbJIi7zlQQFUDGchpDQQhKqmnb45aBX/ExD/GI7c5jEiHC+enlBLkagy5SRWZ0INt0FkSLBMtETrNs/f9Bt3dKnKl+c8tWy2JLCwD/+I2+KSsIGh+dlvdLHBbQ9Zj80xdXEhfHHoLm01sILHQrsjPAgGdookRALzgP5B4FKjOB937RMh7D9W1O4NBPdIYrwMfouwDfIL9ycJj4mzmiRl4odo961IXl4nZkHINWUBU1VtLCbMXASvwRlDx/zE+4DIAqIDKxOG8WMwq62eETEMm81u5Va3UIMBFzQMb8LzBkCltqqH8ynzbaC6rq8ce3Eloh//6e0MfUh7lSigVmSjiq+NMxS3s6YkMzOnPVncgFxfC41lbRhZwJblNuv2Ii3mlY5BrQ/p67blc6EgoqYewcrcnH6d8FJ9XFDKuhNxBEWU/bdcQyobzjhe6SrU2KtWeiv2J1LA+w9/627PQ0wKES6Tja7cSHg0RgvfRYc5EzOmY142dWy019B4vIUzhRvRZNREY8FVNFtctFjyiwjOq8/gmEPgodGiEAhfHYVXYqCxeadug8VnzmV6WrreRhUtAHiU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(261009221227099003)(261009223027099003)(3023799007)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(5023799004)(56012099006)(11063799006)(10067099003)(261102123227099003)(4143699003)(261102130727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dhZGpnSm9ZQUhBQ0wrY0N6cTZGN2NObVFROXVQV09LUkNkblB1L2VrZUpH?=
 =?utf-8?B?Z0c5TnZBdEdsVldIRldYSGRiRkltTGlWcnNLL1FWVjJJb3Z3a3lYVW9aV0F2?=
 =?utf-8?B?emxMbFl6Z1VMR1ZUMUozRitkM01icFh1YUFSNjdrcGZHQUJzMDhheERHNmdH?=
 =?utf-8?B?RXFOS1NQTURDTGdMQUt2eGlKU2ZaTHVJcnBuQlB0RU5xNkY5VmR6RzM1bDNp?=
 =?utf-8?B?VFBMV3ZXSXN0c080WWVMcGdINThrQW1aQ1k2cTNNVzA2dnhXVDIyZFRqUjhL?=
 =?utf-8?B?NkpuUXNYMGhmYXk2MysyTURCT3JQOStiVTN5VnAvcjJBMHpHaGJncTcxYVI2?=
 =?utf-8?B?ZVY0NzFUTmRGd1g2eWIydjZ3M05DU0M2d3BKeDBNSjllNEhGdDVKV2xjZ095?=
 =?utf-8?B?bW5lUGF0ZTBNdlp1Y0Z3TzVabmZ5MDFyb0drL2kvYnJwZmxlQ2FMTjVwa0Ro?=
 =?utf-8?B?Ui91V0hDOTBnaXphdzNjNlN1RG1DeHFTSHBNb1ZZRFlqNENSR1NKWHRFRjlD?=
 =?utf-8?B?VTdlTEV1V2N5TUhLSnh4bHBhRlY5anpXYkVXMys2V2dUaHlsdzdvaHRZNzFt?=
 =?utf-8?B?NDlSY0ZxdWplQUY5Y25WbXRoY1YvTDQvZDRIZFpwY1I4Mmxudzc1RXc0YVNr?=
 =?utf-8?B?N1VZMkN5ZFV2dW9qOUgxQXNvbThpK0xFY3lZZm5nQjRxSlI2MEdjeWZFTUVX?=
 =?utf-8?B?QjIyektMa0RYblpieVluZTJoalZReXNzRkFzQlltN3FBRHk2d294dVhQaE9F?=
 =?utf-8?B?U2NuZHNtbkQveEJQVU1uR2NjRGZCbS9HVXFFWlU3dVFCaGh2MWxTMjFXNVZz?=
 =?utf-8?B?WEl2V3JIazAvVXRFTWRYNlBYRXptT096a0V3NWlyOGI2a2t5aEU3QzhacGNs?=
 =?utf-8?B?OUl4Z243Q2VWREhmNnMwdWhVK2JoNmxxRWFGMURnTDl5dTRMd0NOT3Urd2Jh?=
 =?utf-8?B?dXlwMXhLK2NWcUpiK2RMOTdhM3ZzVC9ONkt0eU9pV3IwMytXdzEyUjhzT2Ey?=
 =?utf-8?B?dG1QUkhmS0l4YkZoeS8vU1FFWmVhZHhUNTFvSGprZ0hvWVVNYTBQcFRsNWcr?=
 =?utf-8?B?aTc5U2tVZTdTSHd4N0EwUzJlREF6TGhibHcwQWc5cUZsTEpsYXh6b2ZDR0g4?=
 =?utf-8?B?V2U3K0NKZE5aeUJsMUh5QUk3WVladW9qOFQrcEcyMDZnSlNYR29JRExqL3VT?=
 =?utf-8?B?YmpacVJrY2kxMnp3enhwazdxUks0N2x1Ri9GcWlBUEJTTnc2andhSnp3ZCs5?=
 =?utf-8?B?bFZIOUdUSlQ4aFNPM3RMUlBYcXBFbnZaRHdMQ2kxZGw5UmhIdUZnSWVGYlo2?=
 =?utf-8?B?cktUMnNrU3dhSjdWeDZ1bEsrRUV4eXl0eEdPeGxuUVR6WDViYUQ3Nldldnhm?=
 =?utf-8?B?ZnRBcHQ1UHIwMDZCaXA2dU5xZTlaUFZTUmpaNTFsVzhybFYxMVQ1YXJkbmxI?=
 =?utf-8?B?Szg4dUZiZmtWcmV5bElzeWYxeHhoQlNEeE9JR0dneERzdjJMMUFqbFR5VTZT?=
 =?utf-8?B?ZWRHNXBoZlNzVGpXYTEvK3BqcytjTVhwL3p3WG85TkJZUVRGeVRiRmVEWG4v?=
 =?utf-8?B?ekdXS3F6TS9McmQ1RDFRQjVRbFZTeS81WFpaSkpCckU1ZjNzWHhzTHZwNzZN?=
 =?utf-8?B?bTl2ei9WeGUwbUtMQUJweFVldTFXdVRLMlhJY3FZQWxTVE9QcEQzZ3YxZnBs?=
 =?utf-8?B?N051WExMRWRYVU9lUG1oZUZFNjd1eVFVV2ptOXU2R2JqRGY5YUVtMlNVbTZh?=
 =?utf-8?B?YnRNZlBwMHA2N1huSFdaK28zSU11Vm55MGVFWm51SEIvSnZoZFBMak5rd3B2?=
 =?utf-8?B?cW1Ga0JkcEc1SllaYU1aVi9MZlJzSktWOWF4YWZZYy9Ld0NWS3hTclhFZEQ5?=
 =?utf-8?B?TWgvaHpIQXpRM2tVMWlDWFVGZ0psbnppN1pqMDdER3Z0M1oxcFRJWFNQLzlo?=
 =?utf-8?B?ejNRY0lYVXNtSDVlMTNRWXBQT2NSNTBhRHVMaUhCWTdTWVo3S0o1MkdSblJs?=
 =?utf-8?B?RXJpa1lHMHpBQkc2NEN5aDk2Nmg3dzF2OUovUFhvemx0TEhFQUw1Zk5OdTlh?=
 =?utf-8?B?NkdzL0FOWEQ0NnVaaUtGSkY1K0tSbVl5WGFDY2w1VUtyZmRFeE5LdGswWXFR?=
 =?utf-8?B?ZEVKa1F3VEtjaE9MZEZUMU16b3NTL0p4eGx2dFR6ZTJZYVVMZGZSN2hxbDFt?=
 =?utf-8?B?L1ppRGRzN29wN3YvcmJSa1MvaDVKNmlobmhrUjJUY1dYUDBUL2EzYlNCbkpi?=
 =?utf-8?B?OTRZdkdhSVNnMHBBUzlhWFpIMHJ5VDFBaGZUV25Ma2Z4YkVrY1diaVIwRkpV?=
 =?utf-8?B?SXNUYWtkSUhKU0hXK01ydExSUk9iRnlHMWE2VzYwOWRQRitUVnJPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bba067b-9a80-46c1-797b-08df43c116ea
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:07:50.4713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R4b11jPBEFUv6Fk74MiLJ0BvZaM74zsQISpsFS5aOD1V+P39ySlJKjqYIe1loTuDEH1eSJOmgEYNqbNLUky4gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999117
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/14/2026 4:24 AM, Hugo Sales via B4 Relay wrote:
> [Some people who received this message don't often get email from devnull+hugo.hsal.es@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Hugo Sales <hugo@hsal.es>
> 
> panel_power_savings_store() currently writes the level into
> connector->state and sends a hotplug uevent, and the hardware only gets it
> on a later atomic commit that includes the connector. Hyprland adds the
> connector to a commit only on a modeset or when a connector property it
> sets changes, so it never applies the level
> 
> Programs that write the sysfs file, such as power-profiles-daemon, aren't
> the DRM master and can't commit themselves, so they depend on the master
> taking the uevent as a cue to commit the connector, but nothing documents
> they should. A master that wants to control ABM sets the 'adaptive
> backlight modulation' property, and from then on writes return -EBUSY. The
> file has to work without the master's help, like the backlight device,
> whose writes reach DC without a commit
> 
> Commit the level from the store instead, with a duplicated connector state
> and no modeset. The write returns once the commit is done, or with the
> commit's error, so no uevent is needed. A connector that is off gets the
> level when it is next enabled. A write of the level the connector already
> has, or one the DRM master forbids, returns without a commit and without
> waking a runtime-suspended GPU
> 
> Document the new behaviour in the kernel-doc
> 
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> This needs "drm/amd/display: Don't force a modeset when the ABM level
> changes". Without it, atomic check sees the changed level, asks for a
> modeset and the commit fails with -EINVAL
> 
> A failed write used to leave the level stored and send the uevent anyway.
> Now the level only changes through the commit, so the store reports the
> error. power-profiles-daemon logs a failed write and tries again on the
> next profile, AC or battery change, because it compares against the value
> it reads back. It ignores the hotplug uevent. Compositors used it only as
> a cue to commit the connector, which the store now does itself
> 
> The commit is blocking, so a write can hold the CRTC locks for up to a
> frame while a compositor commit waits. The other way round, while the
> store's commit is pending, a nonblocking commit from the compositor on the
> same CRTC fails with -EBUSY, as it would behind any pending commit
> 
> The store takes a runtime PM reference around the commit, like the
> atomic ioctl path. Its locks are interruptible, and a write a signal
> interrupts returns -ERESTARTSYS so that it restarts
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 118 +++++++++++++++++++--
>  1 file changed, 107 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 27546febf90d3..8487ac0661396 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -40,7 +40,10 @@
> 
>  #include <linux/backlight.h>
>  #include <linux/minmax.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/power_supply.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_drv.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_utils.h>
> 
> @@ -691,6 +694,18 @@ EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
>   *
>   * Modifying this value can have implications on color accuracy, so tread
>   * carefully.
> + *
> + * A write commits the new level before it returns, without a modeset. The
> + * commit waits for any commit already pending on the connector's CRTC, and
> + * while it is pending, a nonblocking commit from the DRM master on that CRTC
> + * fails with -EBUSY. If the connector or its CRTC is off, the driver stores

I don't think the -EBUSY part can happen. The store's commit is blocking
and keeps the CRTC lock until commit_tail has finished, so a master commit
on that CRTC waits on the lock, and by the time it runs stall_checks()
there is nothing pending. On a Strix laptop under GNOME with es2gears
running (about 120 commits/s), 26-28 back-to-back writes with v1 gave no
-EBUSY; the compositor commit just waited. Could you say that the master's
commit on that CRTC waits for the write instead?

Regards,
Chenyu

> + * the level and applies it when the connector is next enabled
> + *
> + * If the commit fails, the write returns its error and the level stays as it
> + * was. While the CRTC needs a modeset, as after a DSC override in debugfs,
> + * writes fail with -EINVAL until a commit that allows a modeset clears that
> + * state. Writes fail with -EBUSY once the DRM master has set the connector's
> + * 'adaptive backlight modulation' property to a value other than 'sysfs'
>   */
> 
>  STATIC_IFN_KUNIT
> @@ -712,13 +727,100 @@ ssize_t panel_power_savings_show(struct device *device,
>  }
>  EXPORT_IF_KUNIT(panel_power_savings_show);
> 
> +static int panel_power_savings_apply(struct drm_connector *connector,
> +                                    unsigned int level)
> +{
> +       struct drm_connector_state *conn_state;
> +       struct dm_connector_state *dm_state;
> +       struct drm_device *dev = connector->dev;
> +       struct drm_modeset_acquire_ctx ctx;
> +       struct drm_atomic_commit *state;
> +       bool forbidden, unchanged;
> +       int ret, idx;
> +
> +       level = level ?: ABM_LEVEL_IMMEDIATE_DISABLE;
> +
> +       if (!drm_dev_enter(dev, &idx))
> +               return -ENODEV;
> +
> +       /*
> +        * Don't wake the GPU for a write that changes nothing. The duplicated
> +        * state below is checked again. This check only spares the runtime resume
> +        */
> +       ret = drm_modeset_lock_single_interruptible(&dev->mode_config.connection_mutex);
> +       if (ret)
> +               goto dev_exit;
> +       dm_state = to_dm_connector_state(connector->state);
> +       forbidden = dm_state->abm_sysfs_forbidden;
> +       unchanged = dm_state->abm_level == level;
> +       drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +
> +       if (forbidden || unchanged) {
> +               ret = forbidden ? -EBUSY : 0;
> +               goto dev_exit;
> +       }
> +
> +       ret = pm_runtime_resume_and_get(dev->dev);
> +       if (ret < 0)
> +               goto dev_exit;
> +
> +       state = drm_atomic_commit_alloc(dev);
> +       if (!state) {
> +               ret = -ENOMEM;
> +               goto pm_put;
> +       }
> +
> +       /* Kernel commits allow a modeset by default, which a level change doesn't need */
> +       state->allow_modeset = false;
> +
> +       drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
> +       state->acquire_ctx = &ctx;
> +retry:
> +       conn_state = drm_atomic_get_connector_state(state, connector);
> +       if (IS_ERR(conn_state)) {
> +               ret = PTR_ERR(conn_state);
> +               goto out;
> +       }
> +
> +       dm_state = to_dm_connector_state(conn_state);
> +       if (dm_state->abm_sysfs_forbidden) {
> +               ret = -EBUSY;
> +               goto out;
> +       }
> +
> +       if (dm_state->abm_level == level) {
> +               ret = 0;
> +               goto out;
> +       }
> +
> +       dm_state->abm_level = level;
> +
> +       ret = drm_atomic_commit(state);
> +out:
> +       if (ret == -EDEADLK) {
> +               drm_atomic_commit_clear(state);
> +               ret = drm_modeset_backoff(&ctx);
> +               if (!ret)
> +                       goto retry;
> +       }
> +
> +       drm_atomic_commit_put(state);
> +       drm_modeset_drop_locks(&ctx);
> +       drm_modeset_acquire_fini(&ctx);
> +pm_put:
> +       pm_runtime_put_autosuspend(dev->dev);
> +dev_exit:
> +       drm_dev_exit(idx);
> +
> +       return ret;
> +}
> +
>  STATIC_IFN_KUNIT
>  ssize_t panel_power_savings_store(struct device *device,
>                                  struct device_attribute *attr,
>                                  const char *buf, size_t count)
>  {
>         struct drm_connector *connector = dev_get_drvdata(device);
> -       struct drm_device *dev = connector->dev;
>         long val;
>         int ret;
> 
> @@ -730,19 +832,13 @@ ssize_t panel_power_savings_store(struct device *device,
>         if (val < 0 || val > 4)
>                 return -EINVAL;
> 
> -       drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> -       if (to_dm_connector_state(connector->state)->abm_sysfs_forbidden)
> -               ret = -EBUSY;
> -       else
> -               to_dm_connector_state(connector->state)->abm_level = val ?:
> -                       ABM_LEVEL_IMMEDIATE_DISABLE;
> -       drm_modeset_unlock(&dev->mode_config.connection_mutex);
> -
> +       ret = panel_power_savings_apply(connector, val);
> +       /* The modeset locks return -EINTR, which write(2) would not restart */
> +       if (ret == -EINTR)
> +               return -ERESTARTSYS;
>         if (ret)
>                 return ret;
> 
> -       drm_kms_helper_hotplug_event(dev);
> -
>         return count;
>  }
>  EXPORT_IF_KUNIT(panel_power_savings_store);
> 
> --
> 2.56.0
> 
> 

