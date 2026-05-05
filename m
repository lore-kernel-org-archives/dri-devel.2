Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA11FF8855
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 16:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5990310EB87;
	Tue,  5 May 2026 16:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RZ8n/hZx";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE6A10EB85;
 Tue,  5 May 2026 16:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jw8A+fet/p1xf7La27xgHTFNj81m3sBSJrAiZVOw6qRV40+T0FfIs3bprjDrtXk44rzT506uW1WL3z+qWM33QiT/fnvevA2ulP+xgYZY6qzQhelQmX5QSrKdF2ncLpR/DgkdT9mZ9Mb3sitkRrmt9nYHaPEIqXpdkfNzLmnNPmfURqqpe0XpYXqxKVBo4UH4QbUgUMwRI5bKg2T2RSB8eBIz3D1EMPh1NDBqXn6tYRUWwuJb55+RqbAFchWcOFW6lCmCW0uE0RocKMAF49cMG1QOlaBq1fZ+Hjzv/flghWTTs5zFLneOQycX5sZASRhduzyVTgNBdkDhyVU2HP0t8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxHaaMBsRm28R6mfVDtNdJqb6Jn9/qxIQhpInvtncdQ=;
 b=MM5TawbQq2jnElh1PqwGHbT1V/Z/6d82rbCRV+mM2o8Pn5eQAjHV2SZtg/hZiqE2bDhJG/om7w37a4H9zm25+vZVYCAku63LlLP4+GUnKR1uUw9tvLCVy6dFBjlDD1Y3WULHWXRWmvfl1bVFyUMp4OXKFtcWcaU8IWk702zWo5mpnpAKOBPXOgzA/HQbPkq01lHPat78XXQn1RmVQ68Omovmz5v3ktVINmvy4bcIuxhlUyMl8wqQT4BgT5RqBzN9okGA1Rvs7ofo0gJdOXB6nvRC6ZuaUqKrHcoJ+4CE+tka/DX2ol+FhOJBSIr31SoFG5HNSpLgINHG7AA2INDEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=effective-light.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxHaaMBsRm28R6mfVDtNdJqb6Jn9/qxIQhpInvtncdQ=;
 b=RZ8n/hZxw4bXIY0hpDUMXprP1WllIAbEYkpOL82g7bWHiNnrHGig+u6n8lUFBUIFZe1FS2lJPzrEBCLfR5xYRqPjklEAejONxpRzm7WNEJdDFwAogfkrI9aaLKKaLc7rDnVtNmx2n5Py3RZwmM2V8ZN80s2g+FByLuadaBpK+m8=
Received: from PH8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:510:2cd::19)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:41:37 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::ea) by PH8PR07CA0011.outlook.office365.com
 (2603:10b6:510:2cd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 16:41:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 16:41:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 5 May
 2026 11:41:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 May
 2026 11:41:35 -0500
Received: from [10.254.92.56] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 11:41:33 -0500
Message-ID: <99c2f84f-6453-419a-b7bd-c4fb6cda85e0@amd.com>
Date: Tue, 5 May 2026 12:41:33 -0400
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
 <62c4c0e9-6368-4737-afc9-d4b1fa7a94e7@amd.com>
Content-Language: en-US
In-Reply-To: <62c4c0e9-6368-4737-afc9-d4b1fa7a94e7@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: sunpeng.li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: 299a5f73-91ff-4649-cedf-08deaac52d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|42112799006|82310400026|36860700016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: W0HS2HEY+aO1DnDbxOCSzVy5uqU4+ywhzGtlpNpXMxT9KzYjBpBGlUdRK7xaNBrL7bzkKj2vW/hJjTQkM0D90enpqnRARamtUggEw8RTbcAYilI8ERzd6yG3FOKyVVqlqFd5YApkNpLBaK14QmwqUospg+g+YCutZFBesck7ZrFIkcFV4dvcnevCKkt9wLb3bXbeqN0p4fgkefxCsELwAbqQWiORYOlsbeYA7jnJlgodk+Yr83uDfXfSv0Qg2yY25v3hM5veJbJk6qF3AVsvVTSKgJvPjUTHksJ+kR3/TIU1Kr96TRcRGRPzIz+ClRbXoXYvGEz2CyVysmwoUjOO09Vs7VWM//yNBX10bZMROZgfU4e2IVTsxz0IKSDjFJdTDoNKhA+nF08nMYdi4xkVosrDWc+uTtq+oTlLZoxms1acI1tvDgyKxGNrCKXcXy4364Pk9Szg/y/Ynl0D9HHUKd8cFCCf3K6JHF5TcEy+WeVKAtcCWH8Tu5d2c9tujpxM9AOve6RvrOdbAd4fRY1vMBSyWcJi6Xjk7bqzm9WhmV39xCmZZoAeHRwDB1eVSbSBV8Gl/7IfFFb3od3ByBIBIPVrPyD4UGJyHKjt4Ng37jttzP1QsoVrQx+Ntbsi97PfXcu56+fgqSKpS/pIM38hDsdAqxQWDFeVRYRUlwiEtpE0N90Pj6pTOwcPVeXgtDIw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(42112799006)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KPaQR1T5KQYeT13ZUTYTvbH8IKyIWF5/j0WwArq9og6CgmuYkUlqqjgGSKZHW2HoqbzRwC2aUp3BIO3E3C96ha9vAV6zQRiz61njr3f6Ltxq0InX0EcuVH/7tiJdz4zvOUtAyCxY7TbP3t54/isfuHaoEqMioVnLWnVLsmaB/E9tmTjw46acjv5f86VA+AOTWNLuxJ4bb8zAXGuF3OPlMnSHhs1GPSBHv9yxHo7FZ6Tbvexrr7qHcxT2lBwqNWE1UJS+DyJ+fOopQvTEwTnYYsLRufPccYgwPjEtDYxDKoBB84HAw46/ul9qsUY1A9mYmxj78j+v9ahM45ARnGk1zGI2usFrzk/mNMrZp6xvB7HSeDdwX4kuucfumrlMnyeSqqOWECBIa71e1XPsf+mnqnNoXaVpz/0B4Gjntu17cQXQHo1xq5nJRdqNtNsvgsQx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:41:37.3044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 299a5f73-91ff-4649-cedf-08deaac52d03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
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



On 2026-05-05 12:36, Leo Li wrote:
> 
> 
> On 2026-05-05 12:02, Leo Li wrote:
>>> +	/*
>>> +	 * Compositors will refuse to make forward progress unless we send
>>> +	 * the previous flip's completion event.
>>> +	 */
>>> +	if (WARN_ON(acrtc->event)) {
>>> +		drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
>>> +		drm_crtc_vblank_put(&acrtc->base);
>>> +	}
>> I would expect this WARN_ON to occur only after the 10s flip_done timeout expires, allowing 'this' commit to progress with the previously armed acrtc->event and ->pflip_status from the previous commit ('this' commit would be gated by drm_atomic_helper_wait_for_dependencies).
>>
>> In which case, we probably want to apply the same above hunk for the cursor path here and also raise a warning: https://elixir.bootlin.com/linux/v6.19.3/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L10170
> 
> Hmm, scratch that, looks like I didn't finish my own thought:
> 
> I think this would also mean the compositor sent 'this' commit without waiting for the previous vblank event. IOW it's not that compositors refuse to make forward progress, but wait_for_dependencies() in kernel will wait for a flip_done completion that will never come. And that can be a long time, since the drm_crtc_commit_wait()s stack.
> 
> Indeed, it seems to be the case in the dmesg log attached to this issue: https://gitlab.freedesktop.org/drm/amd/-/work_items/4809
> 
> The back-to-back WARN_ONs are likely from the hunk above, and one level up at https://elixir.bootlin.com/linux/v7.0.1/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L10186. The compositor attempts another commit soon after, and hits the series of timeouts within wait_for_dependencies(), before we hit the next series of WARN_ONs from the same locations.
> 
> So ultimately, I don't think sending the event here will do anything. Since by the time we hit that WARN_ON, we've already waited through wait_for_dependencies(). At which point, there aren't anymore waiters on it.
> 
> I'm thinking an alternative would be to issue a 1-2s delayed worker whenever prepare_flip_isr() is called. The worker is canceled whenever the event is sent from the irq handlers. If it runs, then the expected pflip interrupt never fired, so we deliver the event in the worker. It's effectively a SW fallback for event delivery.
> 
> Of course, it is only a fallback, ideally we figure out why interrupts were missed in the first place.
> 
> - Leo 

(Apologies for the spam)
But regarding this patch, I'm OK with dropping the above hunk but leaving the dm_helpers_dmu_timeout() implementation.
With that change, this is

Reviewed-by: Leo Li <sunpeng.li@amd.com>
