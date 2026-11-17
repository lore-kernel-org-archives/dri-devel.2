Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF9606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 03:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1XQ/QeyY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE43910E36C;
	Tue, 17 Nov 2026 03:15:10 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011040.outbound.protection.outlook.com [52.101.62.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED2510E02B;
 Tue, 17 Nov 2026 03:15:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdjrykvXIQc3yg+Egwwfiy7OtHAxLiyRr3N3tQ10GAUKB1ZBd/Hea4XIwdz164kXgZMEiYulRcewD9/mNcSRHaJW47Zo/ksnG/ZCZBYyFsnO32uCI5OO/lC21yVKz+RV7938/HFQs3kb4PafxGSvzrUbj6fLgqEkuI+YZH7hBGPTjZcmIVU7aW0PGQMg0Bc9oiZJnP3y33AuWVssAr9gwz7ydLOr4tsB86r7OM+6YlpT24OV7NNF2aIbBuOAKEwEPx6VLwZGYANH3mg3T3bwTVWUMq/13VW+YCIR6tuCfj+jbGDSvxNwKzK10CJide/LBntjpHBQFD40R1mbZcTrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQA94qmr9YfiKUVtLTdgAl8+ndMSocPRcP37ekZsATQ=;
 b=HM8mdD4oh/7mQ9HdjGOxa3CND/3NrCI+55Yx+/AfE/NqTxeEZm0fWeB9omKQvaH+gt9V3B33hv+pLdX8q21wy01pDPrPWyOUDMYJcNFLgTUm9MCLGMJpXZrT6RwjJQmmxATmyNyBsau94/h4T7eASQ5R3lEJyStAI7WRr8womdmPyPFYAqI+OIiNbbyvl3EkP5lyXwJcB3dS+uAfMEJw3gNQboBd1+i4QwNTq+Y1jXOJQbmUgEmQdXs02vj9EvwuOJIISrXEBaRW6MmrNTO75Yc+cmTz4/Zl+iHtwXhIOA3/FftmWzRQt21aHpwNUBR1MynXLv761iieR4lnVXF8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQA94qmr9YfiKUVtLTdgAl8+ndMSocPRcP37ekZsATQ=;
 b=1XQ/QeyYM5lhfp8u2zRnBC3soTRmq1cO3naPknf+lUtrP6bGZp4xkB9vjp+6NEvfBAdG3wKny2dl/6CDOBvWaMhLitGc7LuUp2DgEohxqoPnAaDZlFN+fznHwTocbrHMkIryr9O2zrBBk8rTVIPFRwN/bG+jvWMjCiQUjmuoWfE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 03:14:25 +0000
Received: from CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd]) by CY5PR12MB6132.namprd12.prod.outlook.com
 ([fe80::d9ab:4258:a9ef:b8cd%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 03:14:24 +0000
Message-ID: <3902fc15-22b9-4848-9541-f6d3a85c80e8@amd.com>
Date: Tue, 17 Nov 2026 11:14:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] drm/amd/display: Commit panel_power_savings writes
 from the kernel
To: hugo@hsal.es, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Alex Hung <alex.hung@amd.com>, Bhawanpreet Lakha
 <bhawanpreet.lakha@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 David Weber <weber.aulendorf@gmail.com>,
 Shivam Kalra <shivamkalra98@zohomail.in>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::14) To CY5PR12MB6132.namprd12.prod.outlook.com
 (2603:10b6:930:24::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6132:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c1a267-748f-40b4-f4e3-08df4458e1cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|921020|10067099003|11063799006|5023799004|260925022911599003|56012099006|260925021311599003|260925021911599003|261021123027099003|261022075727099003|261009223027099003|261022105027099003|261026140227099003|261021121427099003|261102123227099003|261028144727099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: RrO8ry+ecRIDcDUsBQBnDCKVZLmIpjHwUbwmwS5bCpEsQc4VUQ1sYi0Mf4ywG0fIHR1rMlOwTEvTtP3PBTviWAQh6PLWvjCY2H7KmIGgbthKiSxvNF2QK63134+TdF57lYh7dfnbH0YpKp52Fwvk53ZdUJ50uSf3dDUqIZivH98El0zvpPEbFXocD64w6fNt97mHZotwJfR80PvRXSyi62ozGwtrGgD+FDCjlXzY6HYFsg8EDvP64yiZ9XQ95+hgLVbiy4ISt+dg5fflzr4V8xQxiUw4dCTIY7JKY2bIlqYtkioGLxhI3Cy66IdFkXyoU/L9HNL2v/nL/fyjOQYnFP3RIczV7Ohv9B4nWzxjsHkgfaTBTqVEo8+Fyl/MsJYLnATKwU8eKmlB5d5NuzGx2rvdZb7Es5/llTR5WdUZHG4u4W3u6zaP4wLiEuwD8AKdoovXO137jbxcET7qqA2y4z3QqmCQkRAr6L3J39v8oo9hg0dLjgPDvWidmJTWrNlJ26f+BoZknPXPk0x2qu9J4UsyQI7Wamn+BEqd1HDuhSbvEIVo2ER2ZnN6Gb8jvSPpA5QDcKMQqV6SxwVPaz8Mz05QVOx51Q0HHI+0z1Svh39aRhwPidNRc6UkJKrG+qTIUV8rSjVLWmLrbAC6LIMzhFkHYxUh61oqvSkIoVFOaKI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6132.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(921020)(10067099003)(11063799006)(5023799004)(260925022911599003)(56012099006)(260925021311599003)(260925021911599003)(261021123027099003)(261022075727099003)(261009223027099003)(261022105027099003)(261026140227099003)(261021121427099003)(261102123227099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWp4aEVvbUZPcmNNc0lXL1VCb29FaThTcEsxd0dBOHVKKzF3QWtXdk9NMUwx?=
 =?utf-8?B?ZzdaMCs2cXQrT2pKUThTZHZzNm4wQWF2UDVvNklRamFtRUUrWVkzTlpCa3Q2?=
 =?utf-8?B?VGlUeWxjVE9NN01obk1aZkNQTjNGRXd3YWlPNndBYjRhWUZlRXd1ZUw0bm1T?=
 =?utf-8?B?dUlYZ0NWcDgxbWI0LzdSRlJXQnVBR01xdTc3K0gwakZjWnkzUXhMVVY0SkpI?=
 =?utf-8?B?bHdLRkNhUEdsd1NHMU5ST3NFZTdBVitZL3p6K3duK2Uxc3IycVFud1JBcmY3?=
 =?utf-8?B?bUJMdTZNV2tZejBLZUNOb2x0RzRLM2lVbUhUR1BkMndHU1IrSG5Ed3o3dHZv?=
 =?utf-8?B?dEpORndDRXpXcnhZbmdKcjJjRy9MS0FabmE4RDBLZmdaQTNZby9SMVBEdERz?=
 =?utf-8?B?c0xJWDlKTUhDWjAzUzZqbGJKc1lRYlRtaWNGL0w2b0oycCtPZFZvLzY2S0Rv?=
 =?utf-8?B?d044U0hNYWxFekFkWVVPVW9Vb1pja1o4UmRmK3pzNHMvVm1HVlBha081aHQy?=
 =?utf-8?B?WjVUMFZkb1pRUGgyTEI2RUVPbUhLU1VjQmt4WlloL1AvZ2ZIbVhGNkpzV3dK?=
 =?utf-8?B?OHJOVkZwYlpyRUxVYWRMeGs1VTlGQlljK09XWEQ5d2dZOTlPV2lzT2FYUVVN?=
 =?utf-8?B?SlJ6ZUVXRkdiMzhBVC9IbHhab1lBa3YwZzFYRkI4QkhHYVJ2SE92SzFRb2px?=
 =?utf-8?B?UC9reGlKRXFGQ05yeVE0YXArblhWakkzS3UzUTloMTA5Y2pQc2lPaE55VTJj?=
 =?utf-8?B?dGVrWDNYbVJjTE1xNWFpUkJHT2QyMmFnQTIra1ppYVFkdUYyWjBaWVRVRldu?=
 =?utf-8?B?NlNHcmlvR1poM1N3NkJSMWNRWkxUYUJIRFhLaGNMb3lCWmlnYUQrNFJmaHJG?=
 =?utf-8?B?M01IclNqZXpOZlBrNVdtTDA1Y2pEVnZBUmpLTnVEYzFOVGN4OWdxK202Y1Jy?=
 =?utf-8?B?YUNacUMyTDdKY1Q2VHV2ZlBQd3ZDWGdmL2lIT2l1ZUw0bmIzVEJCUUpIR25v?=
 =?utf-8?B?YmZ6RWNlWVBhbEY0R09kQkRwYzZTRDk3ZnFaYUs2UTN6NWlFQmNWL1A4Ynov?=
 =?utf-8?B?bi9NeFExN3pCbXp6OVY2cVNIdWRJSmFpUTh0M09hYkFhd3Z4VjkrRUoxMVAw?=
 =?utf-8?B?WGdqRkJKdlFyM3pzUUk5dFpBNW80alhhZHpuRzI0Nys0ZkdTWUxNWGxHQ0lz?=
 =?utf-8?B?cVBwZWJsc1prbHQvSkJFMXVxNVphL1JCa3BuVGovb0tYZDNkUVJvNTVEN3Bz?=
 =?utf-8?B?NWZIYi9Ea3ZROFYxTkY3VnpiQmNlbjdJYnNCZ1cvVkJ0TzhlM3VkTVVYeG1W?=
 =?utf-8?B?OGhNMXdOMzlpSElaNWVzNlg3TGJyUEViSERIMEFILytQN3RVOERpQ3hUZVVM?=
 =?utf-8?B?ZlU3dVozbFVHM204V0Y3Wm95VHVWbSthSnFSWXZaMlc5VEp4LzlTRWVPTXI4?=
 =?utf-8?B?aERPalNrdDJCYUxFc3VQSHErRFk2SnJld3Uxay9OaTFDVlljMjl0SDlnMW05?=
 =?utf-8?B?bUxCR1p4TDhESzZUM1pRdHpKaVZnY1g2ckwvQi9nRitYUG1WMDRGeXhMWW9N?=
 =?utf-8?B?WWtXd1M5U29FZmVBUE5VOFBjaVNKelZGVE1zRGZBTVdRNGVlNlBOa3A3d3Zk?=
 =?utf-8?B?cmR3TlZDWkkxOWtta1NWZklucWJ3K0dvSVgzVnNEOTFheTUya3gxSGZWYVNF?=
 =?utf-8?B?cE5mbnpXcUZIdDl2Yk5ZTXpIeks0YWFtNDBKeTFwTHAzb2ZDMHQxQ2cxczhW?=
 =?utf-8?B?aG9naW8zazk3bUFrTTUwT0wrSEUydTZFZk9jeWpxcGZ5VVBwRXVuQko5K29r?=
 =?utf-8?B?dGludlQrTWF0aitVS3BWT21kQXE1WmF3VzJPaXBiVVZtc3J3VTd6REhPcGpi?=
 =?utf-8?B?bzhqUk1EL0tCOVdRcDdGb2ZXdXI2Y3g1Z01yRlVEYmlrYTZNVFltaW5TczFL?=
 =?utf-8?B?WCt1eTVDWTA4bHR0NCtsazhkczIzQ3ZZQWQ1SXVJQWVZZTZyKytSK1hUZkQy?=
 =?utf-8?B?aHRPSXJLY1RjSGg3WHY3dUhaSWVhNldEcE1jQ3ZUaEFOckpoUktZWklZVXVx?=
 =?utf-8?B?U3dVMHZZYStwanE0ZkcvbnNQR3lFdktIWXEwcjJhYUxpdnVNbDJkT09xM1p3?=
 =?utf-8?B?MTNITWcxWjFwRndRWWVkZ0tCRUtkMTZQSVFOekRMdndWREdNZGpTRHBZOEVZ?=
 =?utf-8?B?ZUdoNU9XTzFIalBhY0FzZFlxa3ZsTmtsTU13a0RXcFpEd1lZa3h2UVlac09X?=
 =?utf-8?B?ekhwK3A2OUpYVHFPTW8wUTF4RXh4Y0dtdGZIRGhXb0puRVZkaVpYUWlwdHVD?=
 =?utf-8?Q?tbnTtcLYDXdiNONBbK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c1a267-748f-40b4-f4e3-08df4458e1cd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6132.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 03:14:24.8078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2XAFPP4XJAsx4lJA45pnwuILrH7GGjWeaY4QDwJv9qVyVuvR0e1STtiX1bR+O8JkBNJDi3QGFK/o7GSlWnREg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181
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

For the series:

Reviewed-by: Chenyu Chen <chen-yu.chen@amd.com>

On 11/16/2026 10:01 PM, Hugo Sales via B4 Relay wrote:
> A write to panel_power_savings stores the ABM level and sends a hotplug
> uevent, but the level reaches the hardware only on the next atomic commit
> that includes the eDP connector. Hyprland adds the connector to a commit
> only on a modeset or when a connector property it sets changes, so on my
> laptop the file read back the new level and the backlight never changed.
> power-profiles-daemon writes this file on every profile, AC and battery
> change, so none of its ABM changes applied
> 
> This shouldn't need a fix in every compositor. The file is for writers
> that aren't the DRM master, like power-profiles-daemon, and they can't
> commit anything themselves. Today they depend on the master taking a
> generic hotplug uevent as a cue to commit the connector again. Nothing
> documents that, and a compositor has no reason to read a hotplug event as
> "a property you never touched has changed". A compositor that wants to own
> ABM sets the 'adaptive backlight modulation' property, and from then on
> the file returns -EBUSY. The file has to work without the master's help.
> The backlight device already does: a brightness write goes straight to DC,
> with no commit at all
> 
> This series makes the write commit the level itself:
> 
>   1. Render the existing kernel-doc, which no rst file included
>   2. Add the CRTC's planes to a commit that changes the ABM level, which
>      the forced modeset used to do. With VRR active, such a commit would
>      otherwise carry only the primary plane
>   3. Stop forcing a modeset when the connector's ABM level changes. DM
>      already sends a new level as a stream update, and the commit that
>      added the modeset flag also added the CRTC, which is all that update
>      needs
>   4. Move the store tests onto a full pipe the store can commit to
>   5. Commit the level from the store through a duplicated connector
>      state. The write returns the commit's error and no longer sends a
>      uevent
>   6. KUnit cases for a connector with the CRTC on, off and failing
>      atomic check
> 
> Patch 3 also asks, below its cut, whether scaling can leave the same
> check
> 
> From my reading, other commits that add the CRTC but no planes, like a
> change of the HDR metadata, can drop an overlay the same way while VRR is
> active. That needs a fix in the CRTC check that pulls in only the primary
> plane, which I'll send as a separate series
> 
> Hamza's v1 of the 2024 patch that added this file had no flush [1], and
> Mario found that the level only took effect on the next modeset [2].
> That patch's v2 changelog says "force an atomic commit" [3], but what
> was merged, commit 63d0b87213a0 ("drm/amd/display: add
> panel_power_savings sysfs entry to eDP connectors"), sends a hotplug
> event instead
> 
> Commit 8d20a066fa9b ("drm/amd/display: change the panel power savings
> level without a modeset") later applied the level outside atomic. It
> broke igt abm_gradual, and commit 95aaa207e9ef ("Revert "drm/amd/display:
> change the panel power savings level without a modeset"") reverted it.
> The objections back then were to sysfs overriding the DRM master at all
> [4], which the property above now covers. I didn't find any discussion
> that rejects an internal atomic commit
> 
> A write now returns the commit's error instead of storing a level the
> hardware may never get. power-profiles-daemon logs the error and tries
> again on its next profile, AC or battery change. Nothing I found reads
> the uevent for more than a cue to commit the connector, which the kernel
> now does itself
> 
> The commit is blocking, so a write can hold the CRTC locks for up to a
> frame while a compositor commit waits
> 
> Tested on my laptop (ASUS ROG Flow X13 GV301QH, DCN 2.1) with v3 on
> 7.3.4, under Hyprland with no modeset during the run:
> 
>   - 25 writes cycling levels 0 to 4 all succeeded and read back, with
>     nothing in the kernel log. A write sends no uevent
>   - I wrote 4, 0, 4, 0, 2 and 0 six seconds apart and read
>     amdgpu_current_backlight_pwm and amdgpu_target_backlight_pwm every
>     half second. After each 0, the backlight was back at full PWM by the
>     next sample. After each 4 or 2, the target dropped, to 25% of full at
>     4 and 52% at 2, and the backlight ramped down to it
>   - This series on top of "drm/amd/display: Leave self-refresh before an
>     ABM level update", with the panel in self-refresh before each write:
>     all five writes that changed the level took the panel out of
>     self-refresh for the update
>   - Writes of the current level return without a commit, so they leave
>     the panel in self-refresh
> 
> On a text console, igt amd_abm passed all five subtests. I also ran an
> IGT test that puts an overlay plane over the primary plane and turns VRR
> on, so the CRTC idles at the panel's 40 Hz minimum. On v2, a write took
> the overlay off the screen until the next flip. With v3, the overlay
> stayed. With VRR off, it stayed on both
> 
> [1] https://lore.kernel.org/amd-gfx/20240126222300.119292-1-hamza.mahfooz@amd.com/
> [2] https://lore.kernel.org/amd-gfx/1162e59e-3f53-4c84-b186-bb2f4642216b@amd.com/
> [3] https://lore.kernel.org/amd-gfx/20240202152837.7388-1-hamza.mahfooz@amd.com/
> [4] https://lore.kernel.org/amd-gfx/b117ccc0-6569-4753-9cb9-c304f9e50d30@amd.com/
> 
> Changes in v3:
> - New patch 2: add the CRTC's planes to a commit that changes the
>   level. Without the modeset, such a commit with VRR active carried only
>   the primary plane, and DC dropped an active overlay until the next
>   flip. Sashiko's finding, reproduced on v2
> - Patch 3: credit David Weber, who sent the same condition change in
>   August (Chenyu)
> - Patch 5: say that a compositor commit waits for the write instead of
>   failing with -EBUSY, in the kernel-doc and below the cut (Chenyu)
> - Link to v2: https://lore.kernel.org/r/20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es
> 
> Changes in v2:
> - Patch 3 (v2's 2): name commit b05e2c5e81f9 ("drm/amd/display: Update
>   ABM crtc state on non-modeset") as the one that lets the non-modeset
>   path carry the level, say the KMS property loses its modeset too, and
>   say "drm/amd/display: Leave self-refresh before an ABM level update"
>   has to go first
> - Patch 4 (v2's 3): set level 2 before the test that writes 0, so the
>   write changes the level
> - Patch 5 (v2's 4): return without a commit when the level doesn't
>   change (Harry). A write that changes nothing, or that the DRM master
>   forbids, no longer wakes the GPU. A write that a signal interrupts
>   restarts instead of failing with -EINTR
> - Patch 6 (v2's 5): test a write of the current level, check that it and
>   a forbidden write leave a runtime-suspended GPU suspended, and fold
>   the CRTC on and off cases into one parameterised test
> - Link to v1: https://lore.kernel.org/r/20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es
> 
> ---
> Hugo Sales (6):
>       drm/amd/display: Render the panel power savings kernel-doc
>       drm/amd/display: Add the CRTC's planes when the ABM level changes
>       drm/amd/display: Don't force a modeset when the ABM level changes
>       drm/amd/display: Give the panel_power_savings store tests a full pipe
>       drm/amd/display: Commit panel_power_savings writes from the kernel
>       drm/amd/display: Test panel_power_savings commits
> 
>  .../gpu/amdgpu/display/display-manager.rst         |   3 +
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  17 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 118 ++++++++-
>  .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 271 ++++++++++++++++++++-
>  4 files changed, 390 insertions(+), 19 deletions(-)
> ---
> base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
> change-id: 20261101-abm-sysfs-commit-96a38de1ac66
> prerequisite-change-id: 20261113-amdgpu-psr-abm-update-next-de20bc23b12c:v2
> prerequisite-patch-id: c6cbeb4671914753ab7526369c2612039ae16504
> prerequisite-patch-id: efc64b5a0a1bc2d46494d4797b0d25447b174076
> prerequisite-patch-id: 496307c9687a947cfbfdcf1b6d0ad6ba1b6d4089
> 
> Best regards,
> --  
> Hugo Sales <hugo@hsal.es>
> 
> 

