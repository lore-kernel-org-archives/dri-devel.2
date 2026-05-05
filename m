Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854A6FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 16:36:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2192E10EB81;
	Tue,  5 May 2026 16:36:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BEKJch5K";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010043.outbound.protection.outlook.com
 [52.101.193.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18EDA10EB7D;
 Tue,  5 May 2026 16:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xEPozAGEB5Y6l7U3DNC73MhaTUZHtem+IImDF55ef/nn11P3YRBI5T+2If/yuqomfJvzgZtK+5hTjkKKBL9vnXq8f8Y+GzZQY2iIN1Ck7ouRSJ+speVXwuifqVPzNN3qAlE04z2C0zqkgSLeAz/+zBURc/89Lnt9f1YTDHJ3JveJEmkLHbEBtpafH35iszesCjbts1zqLrCHBH0bMMk/K/N5Bdi+DaxGz88tbOMX54IIKCEsKhUwwu4q8lR4IFrtXm0OqOSx1oahEEUPK5O5vzwe3+bcdBKzF9O4AbMg5NGnO6cEYUV+U8FEGCHc/CM5MEj7UQTP4xETOSP/OKpPmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCEJDAXLM3rl7s/YnU52W7UiJpu9dhn3u+G+9GhcbOo=;
 b=D1w0Bi61vPyBaI4O8MsXLuog8tVB25e/P27D1KfwTmcabipvW6uZrshYqHLPme3GERkZWR0EwWxJw4EZ3lOMC74inJCtx7Q4kwMm11Rx7ahSfrAqk3r655bLoJ9+OSvcPtxAepowsUCtlASMpX4XwF6D3J13u0Nqo9FKcDKom8skjA1F+caEjyYflG8egRUvtrF3S0dJe6xjvdDl8eNVyNCJ+HoNwGrBI7PwAl7HsFe4R7jpu/J9Z7PzYNh6/YBgZZyYSXNRnRRZTy3fcrQh9iqeaHxT4oR2Pvie1dXtrtiIXGd50iAnq9QTSk5zfE02lY5KmBmqC1mox3ywpiNI2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=effective-light.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCEJDAXLM3rl7s/YnU52W7UiJpu9dhn3u+G+9GhcbOo=;
 b=BEKJch5KYsNpCTyU5LXCiWAQ7iMtCGRwDyXaQsLg8G4joOBYaU3y+6LYgWCNpHxsJhVKQQOI+ELwLwB9oGr6ErgzVY56BRDJZMGKeOid//3dI6p9mziQSHklwvAsb02nx0AtjkNBlfqFkcJHB3BQ9/4uIzRdweUQ5CBE24Xjn2w=
Received: from SJ0PR13CA0043.namprd13.prod.outlook.com (2603:10b6:a03:2c2::18)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:36:09 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::81) by SJ0PR13CA0043.outlook.office365.com
 (2603:10b6:a03:2c2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Tue,
 5 May 2026 16:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 16:36:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 11:36:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 11:36:05 -0500
Received: from [10.254.92.56] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 11:36:03 -0500
Message-ID: <62c4c0e9-6368-4737-afc9-d4b1fa7a94e7@amd.com>
Date: Tue, 5 May 2026 12:36:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/amd/display: add DMU timeout recovery support
From: Leo Li <sunpeng.li@amd.com>
To: Hamza Mahfooz <someguy@effective-light.com>,
 <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu
 <ray.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, Yussuf Khalil
 <dev@pp3345.net>, Tom Chung <chiahsuan.chung@amd.com>, Colin Ian King
 <colin.i.king@gmail.com>, Charlene Liu <charlene.liu@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260501203552.749080-1-someguy@effective-light.com>
 <20260501203552.749080-2-someguy@effective-light.com>
 <d2ee9fb2-4b62-4ee3-9395-4a9f7c4e53bd@amd.com>
Content-Language: en-US
In-Reply-To: <d2ee9fb2-4b62-4ee3-9395-4a9f7c4e53bd@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: b54baef2-c147-4792-be37-08deaac46978
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|42112799006|7416014|22082099003|56012099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 1Mw85D7StzedulwWYWE8Pq4kg74X13dcIpYBY6iEXDwjBF5yXz77tlm1BlGZwc28FPaYHfWT7bOjt/nyRXavNLvUkAkBEX/oxpfqVyYg/Llb3PkSdh8dp3+6QHztaP1FgPlOH5OdpTQGUGTEnhYAP1pKu2BmRiQWKNkO2yNhFOZvYd4BNHYfxGtZPw5l92gUlZG0CTxB15CxewVETvxLoeEdyp49hYcoL38+btzKKsR8PycgFi1hqrIUNC7H0lIEh7nomEr767EA3idcCBS7wa/sTqPNTTj62uU7g8g3GKzes+vsfUjrziGgBzLZY8+e5mnssH8dc6BFaGVwVRNQ+jy+SwP3XHNL8mRNZ6SOaDqlsYQ6zoVLmdKpWI2hGg4cdFOzDze7hmRv9dQCNi/G/6nvXUF/6YGJH0Asri2qmuJ/ds8aHYQmPHNPPGzwrcqKIs4O17WPJJwCd6qZL+psiR/sNrzNjp9nB7M2uzVdIf2WSzfCkG4xweNDR4d7ZkogLS0ZH6CVYVVygQjSoLp6vgnNquP7xV+kv7tQtbmVVqIuVgL0ydctkBD7Kr+8J+g64eSpuavaCxLwfXeqvgsNmElgDMo8sMUsVzwy/hW91M+YKhrxhF8u06NZ60UUvvDgH3yfo43bxolSTKDyKY4jNpGI4ltf5QRo21LWNGd9BX9R6qpCXcLsnomUsT1nGbm+
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(42112799006)(7416014)(22082099003)(56012099003)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7m+FyVgsuhHytD3qYsVMhH+aqQwAT2Jo4z1n8mbTZA79gnd5fqII/ZQmOcos7VP3i1hkVdzPIXX4us08mDE+gCoHDg8p0qNxT0WCXUs5BPxwFJ5bOkq0ejzPAWgRR0Oq+b+qLYwURUA56mVEbpcz3krNKw6j7t2F1pEn+l+ipbQ0NLUqAIsbYOMsTsN8/YJ7/9IKgIraGcJj5qL01q0rlWvHb841K6JGd2qr5e6BsCKLoWa2vgCV9z1T8HFSxznwqWoEGsK4UwrxltK3jL68BwWizY06XMp8t7rNEMHgR/vCsEjCgDEsLCUEc9/ScJlwRS1SK8GL04q4Wo7umFE4VZs9oFpa1JMxJ4BqAMxsd0QE08q8e2fjoV51cpbY4yH9TeyRO5ukfK7vi1hOPP0OOProM1L1wYjzYuD5aVlXaiZU5IhFice0Zu36EDV2bars
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:36:09.1923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b54baef2-c147-4792-be37-08deaac46978
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197
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



On 2026-05-05 12:02, Leo Li wrote:
>> +	/*
>> +	 * Compositors will refuse to make forward progress unless we send
>> +	 * the previous flip's completion event.
>> +	 */
>> +	if (WARN_ON(acrtc->event)) {
>> +		drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
>> +		drm_crtc_vblank_put(&acrtc->base);
>> +	}
> I would expect this WARN_ON to occur only after the 10s flip_done timeout expires, allowing 'this' commit to progress with the previously armed acrtc->event and ->pflip_status from the previous commit ('this' commit would be gated by drm_atomic_helper_wait_for_dependencies).
> 
> In which case, we probably want to apply the same above hunk for the cursor path here and also raise a warning: https://elixir.bootlin.com/linux/v6.19.3/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L10170

Hmm, scratch that, looks like I didn't finish my own thought:

I think this would also mean the compositor sent 'this' commit without waiting for the previous vblank event. IOW it's not that compositors refuse to make forward progress, but wait_for_dependencies() in kernel will wait for a flip_done completion that will never come. And that can be a long time, since the drm_crtc_commit_wait()s stack.

Indeed, it seems to be the case in the dmesg log attached to this issue: https://gitlab.freedesktop.org/drm/amd/-/work_items/4809

The back-to-back WARN_ONs are likely from the hunk above, and one level up at https://elixir.bootlin.com/linux/v7.0.1/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L10186. The compositor attempts another commit soon after, and hits the series of timeouts within wait_for_dependencies(), before we hit the next series of WARN_ONs from the same locations.

So ultimately, I don't think sending the event here will do anything. Since by the time we hit that WARN_ON, we've already waited through wait_for_dependencies(). At which point, there aren't anymore waiters on it.

I'm thinking an alternative would be to issue a 1-2s delayed worker whenever prepare_flip_isr() is called. The worker is canceled whenever the event is sent from the irq handlers. If it runs, then the expected pflip interrupt never fired, so we deliver the event in the worker. It's effectively a SW fallback for event delivery.

Of course, it is only a fallback, ideally we figure out why interrupts were missed in the first place.

- Leo 
