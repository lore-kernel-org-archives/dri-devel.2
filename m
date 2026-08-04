Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59BFC55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 14:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 337A610E172;
	Tue,  4 Aug 2026 14:03:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FrSClhoV";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159ED10E172;
 Tue,  4 Aug 2026 14:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cABmjHUKc7GbnypN/F8/vkpjSI4ZPFSFp2Juy5MFjlUJrjg44vuPYg8e8+xlhDnenUtknepWgt+k1FhKnjLEc5ZGWxo09jCNvNAwgRlKSB49UYYvxOxbGOC+ry2a4qDtqLdaOgzu+TvyERlJ7HeiBVTdHbHp8wB/EISzOUkTpWE8Y1Vq7ALO5Oo8lRotkKbWLz6AfrAfwYXwANuxdvPxto3RRMDo0YhZrd8TKpYeJMEX2g/1ZLU4aof59ypeJ191qj3SzA0RZK8zUGzSM3UrOGrPrsaZt4y2dPNkygOXk2ls09+xbSBg99WowIMfwb3KP/xRUydKXnjAE3ZQUoG8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbtsEVkbH1W8z0u099HSXSBdNT+otRFdmqCFVauqqn0=;
 b=d74iFanqaXRd6NLT7/ezCjzmQ1eTZk84ld55vgHps0ALOdgIe0tiaC4t7sipepVsl5my2fJNUAO7NH5uY75zQQrXgbVHPFoAoPtKn69ETIk2AwJslI6HEIuqHY/hox584Q+9JGkpd41M+3IzipbrGkbsEep0Xt2348oxCxbnxitt2NWycsntETiZqxz4A7vUd413uqNE2x6EKr/03ZZZtIcs8jXgB1cjrRLoufFXQ5KIaSbDdC0LNgYeajuitqEa2lj/ro0T9EtypkIUUUAaAuXRoejQOE6IhmxDjeo4NWO9/UBSsLRc6nU1EvcGRzuWCueSjK8wwHQishzdrcblKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbtsEVkbH1W8z0u099HSXSBdNT+otRFdmqCFVauqqn0=;
 b=FrSClhoV5FwCkB2PwFyOJZgEn6CMuiuc8VS7nwYbqH2VtAL7uPmQnGr1t3g+UZDOpsDCE1/QJI6zBwgSdtUuvaGPlbhEnfFZo4oJzdZ7DjoboD17CUy0n1rrp1sXICO2wR37bJEJI0Bh16ZxrACyGPTws6a8zv+Er2zSmFKvgAw=
Received: from CH0PR03CA0387.namprd03.prod.outlook.com (2603:10b6:610:119::21)
 by IA0PR12MB8206.namprd12.prod.outlook.com (2603:10b6:208:403::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 14:03:29 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::85) by CH0PR03CA0387.outlook.office365.com
 (2603:10b6:610:119::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 14:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 14:03:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 09:03:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 4 Aug
 2026 09:03:28 -0500
Received: from [10.254.93.88] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 4 Aug 2026 09:03:27 -0500
Message-ID: <eaf5f037-c757-42b8-afb6-1516685487bf@amd.com>
Date: Tue, 4 Aug 2026 10:03:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/amd/display: allow self-refresh exit while entry
 is blocked
To: David Weber <weber.aulendorf@gmail.com>, <amd-gfx@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, <siqueira@igalia.com>,
 <alexander.deucher@amd.com>, <ray.wu@amd.com>,
 <dri-devel@lists.freedesktop.org>
References: <20260730033200.441730-1-weber.aulendorf@gmail.com>
 <20260730033200.441730-2-weber.aulendorf@gmail.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260730033200.441730-2-weber.aulendorf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|IA0PR12MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f41c0d-d365-4d12-add6-08def2312912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|36860700016|23010399003|376014|1800799024|82310400026|10067099003|56012099006|22082099003|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: XTfMA0OStsQ30ic/wn3A7qrLgSHJtyK8knmmVxzhmiA7LTTkhe0q1y+6zWw4Iwi5Fe7MStcWlGml9mabuVDgWhRMewr1Wf8yFHQtfYtvhrB6sufaU2sK+TNLQkKEBxAy4txM+zhv/sCMtpP0uj/phRsZjQYsgqDvjJIrf46Xmr/mC0Tqzk89jskPdUCPSpzhYvWZUY/0v3ab4bRwFbBSPeoNjZAuhvzHOSw9N1stigeW8FsDdzoliJLHpSriWxIOsXD05eN3NNnZ9rNlMJVdl9wxR4Zw6+tfQYnGKoQAirKzb7bleiv/wznvsRa1whcEsjkRDUNrF/xzhR7a+8n9U9iKaTvwfvEG4EYq2abMykzKYJvR1uikaWkCil2v2pmUD8sXszW3iHRswpyhQPggCc9Lebg/GGHfzgQ+YdxdbEnuBe9+vNft3l/R/OS4fz1Knl4lEBhh2pfREuQy3MPBOb83goNZaiwrvto/fNutsJ+a309vaRRDj9k0NbdR6ZOTsThEo916/EX3BeQXext9yc6qdF0tKkKEw3QmJH/HagYWzooKLZE8flKOrgiqjUzLRd5L4HzyB4xI5sHCM77UtGqZilDyjHLBqXz+1ADL7F5gxgZI3nTh4aWgRLpsUzhQTdni35Ch5XXZYYtxHwQBVXzOHoPtd7RvHDjzaRNAC2Gc7aUVIqOaxELu8TJrajyN17FaO/Go1DLV+wTKOHXyug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PEA1DU2EDE3EYDXAKYVJb4xz6FcxhntAtg2d37BQT+IkOf+1h+Da/DYdwjOVU5LWAQu8kZ3C1EQ4HkQE6Uh8/BOpp+sUgERSMpTORHPQAB+Ubl+5/OvjsoD0ZRLTbJXNeCfi6Ku5vp7Qz8YLPwZkh/UZiwkI34kiJUtyUvLYCRnLzCDwY/Psf6jrlMQ8oiICqf8FCLKNeg06Iic6UJZQC7WZJrVzD/YhJqd517Zlr9gly7hjb9+YmCrFPYoe1fHX+Xogz41oHniXNZSJp9u5h81vYSoxPTalVLQzTWGbFgoxj42RUD8y/QgWS2TGegt3p91ioVGTWI63TYsUt4UArUD4ok5vftnqGj3ol/xciEGP1W16KIjJ3BudB+81RzPzQoUsapM4zL8JUNDCWk8VtUmUr9WGr7Z2hoYYQCyci8I4Re4/OUmJw/6YZvw9UlhZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:03:28.9065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f41c0d-d365-4d12-add6-08def2312912
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8206
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



On 2026-07-29 23:32, David Weber wrote:
> [You don't often get email from weber.aulendorf@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> amdgpu_dm_crtc_set_static_screen_optimze() maps sso_enable to the
> Replay and PSR1 vsync events. allow_sr_entry is an entry gate, but the
> helper currently applies it to both directions.
> 
> A non-fast update clears allow_sr_entry. During a modeset, a separate
> hardware-programming event keeps self-refresh blocked while the stream
> is reprogrammed. If vblank is enabled before the entry delay expires,
> the ISM calls the helper with sso_enable false. The early return drops
> the disable request, so the vsync events are not set.
> 
> After enough fast commits, allow_sr_entry becomes true and the
> hardware-programming event can be cleared. Since the vblank reference
> remains held, there is no further zero-to-one vblank transition to
> restore the missing vsync events. Replay or PSR1 can then become active
> while vblank is still enabled.
> 
> Gate only requests that enable static-screen optimization. Always
> process disable requests so a vblank requestor keeps Replay and PSR1
> blocked.
> 
> On a Phoenix system, repeated SDDM-to-VT handoffs produced stuck flips
> followed by flip_done and commit-wait timeouts. The timeout was not
> observed with this change applied.
> 

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Thanks!

> Fixes: 3c108046e1d6 ("drm/amd/display: Add power module on Linux")
> Assisted-by: Codex:gpt-5.6-sol
> Assisted-by: Claude:opus-5
> Signed-off-by: David Weber <weber.aulendorf@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 95d3da3c4..06598273d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -119,7 +119,11 @@ void amdgpu_dm_crtc_set_static_screen_optimze(
>         struct dc_link *link = stream->link;
>         bool set_vsync_event = !sso_enable;
> 
> -       if (!allow_sr_entry)
> +       /*
> +        * allow_sr_entry gates only entry. A disable request must still set
> +        * the vsync events to force Replay and PSR1 out and keep them blocked.
> +        */
> +       if (sso_enable && !allow_sr_entry)
>                 return;
> 
>         amdgpu_dm_replay_set_event(dm, stream,
> --
> 2.54.0
> 

