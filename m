Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F931109878D
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF9010EAD9;
	Fri, 20 Mar 2026 14:48:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PKX68Qvg";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E819110EAD9;
 Fri, 20 Mar 2026 14:48:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NstTZn5w+nPr1MKdgvK53aGaabWgouKZFzaxhPXppXm//i4GvzjkMG0Zrx6dCgmE2kiUMB6nOLcIi8d7lqXKsoGrfmcUxU6JRbp/M8RiZnjzCe47TCi8CHsXZtB1y7s3uAinEsyBiJORbJ3wc5B4nNG6SoC/AdKxy93CGyzyovAYFqsjN98Q6kew8V/+BLwcJn36xEhl+nV0i9DscrwRg5Zg44g1/SsqUzWbo9BY2MLTw9UsUqKogsi75F/GOrqx6p3T6wUoWJGiAKaHGKBdmV74CztzteIVTAjrZFDxcRUBW4qel/E9Jf8D1KYcejnpqf+02nWrWnkPnxKEurKpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hhS2KHmFn9Csys/I1DmAXxcKAO0dZCojB+FmFVXjyk4=;
 b=WriHT6IuAnpxJt97ajJI0XNk0cr+vSfCfcfG7OUULA5Bu3GLbW6JhCzVrX2oGYRaozEw/tIPnAes7wvIgnYY5TLelrFBVjVIG/TfxsY7sK+6dK8J4wiKmnr33R7Btd/UQf9vp2cgzJmKRyz52XzA1rvY7YsWlTMAqfr+8wN1w1TFj8fkmYXwArYVsgFPfv5cTEAmmXUvUnCdgJFxKNKNkAqQqMrO3QenidxZ9HiLyxjbXpnC2Et91FCU9p+DLZfgL7uga6A1sdc1JV5M53re19V9f5psmEuCfMdwu+42eb5/aYQT8BPL5emB7x/DGhGYLDWxLwmhy8Enfj2PVS+R7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hhS2KHmFn9Csys/I1DmAXxcKAO0dZCojB+FmFVXjyk4=;
 b=PKX68Qvgt3XWrMr8+UWMNciW1rOCNe59V1TkJ01IoGty3Cek4jEqL7vGrZUwP7nAMhMy4nKjZDQ6F/tXygte2kt6JHnHE1tyyrHn6Tuy347JAsZICZhgAgPaKw6vaHr81ga6IxSm1HtCiUBthsRn7AdmTBfiE59bTPKArF8+LHs=
Received: from SJ0PR03CA0095.namprd03.prod.outlook.com (2603:10b6:a03:333::10)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 14:48:48 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::21) by SJ0PR03CA0095.outlook.office365.com
 (2603:10b6:a03:333::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 14:48:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 14:48:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 09:48:47 -0500
Received: from [10.4.12.71] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 20 Mar 2026 09:48:47 -0500
Message-ID: <edadf773-e7ad-4a35-baea-e978e2c08221@amd.com>
Date: Fri, 20 Mar 2026 10:48:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/27] drm/amd/display: Use bigger VRR range if found
 in AMD vsdb
To: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>, "Jani
 Nikula" <jani.nikula@linux.intel.com>, <alexander.deucher@amd.com>,
 <harry.wentland@amd.com>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <siqueira@igalia.com>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <bernhard.berger@gmail.com>, <michel.daenzer@mailbox.org>,
 <daniel@fooishbar.org>
References: <20260216164516.36803-1-tomasz.pakula.oficjalny@gmail.com>
 <20260216164516.36803-8-tomasz.pakula.oficjalny@gmail.com>
 <7da80c4be3e20c126017646f783b80136bb0700e@intel.com>
 <5649c232fa0243c2c3ca7be91529409921604d69.camel@gmail.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <5649c232fa0243c2c3ca7be91529409921604d69.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bef503-e8ce-409e-2fd2-08de868fcb42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|82310400026|1800799024|376014|7416014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Pz4CFs7BUXpbDcIHAbyvqni/NlEuvFKHIG6zDxPwtZaXUUgU/Y/DmgIGPVdn5tLsrSsLow0R+/d1aPmeSLtSuKXpjUBc5phj9AiqeNwHstvf1hq9oY60W6dmMgIo96lpJASLh92p4zGKxFANi+MpMvcsSgvnI/Rk/pjllb5ufXaTkjiRslttpB/TUF9UjVnhPaWlEVGId6eHogJqnJDVn+r/Pr55MBolnJJNA5FIiGE/MUrsY38wqV01uCLgXAzGNZe7fr+/utjlpWR22pHSIZw8JXUdmCzsRyLefUvYGyHQK60Z8FxpzEDMXcNFX5O2PlO5zrd1tJKoKQHIIaoJbrdO3sFPWHmBtFqKlvQH7FOgXcaVBCp+5XgNI5EGrNxiSIEkwbZzWIhiFoxHPtkGEGZl7bKfhL6k2SoVgriMwhBXG8ylBN/GuiDctO0KBiYm/sPzZMQ1yNh+FDH8ceZglFA40T5U80mkbYsajbt/7smz98J0xM0TGBUysFRFaI1t9YMw22dhFvC3s5SJjY+mauRamXNBXvYKMr75FwVFXxRaDSUbySQDaZj9OVuwrJJCDvfK4llr1Nxx9ZxADNm7ZVWRUhU9XD7HwZhy0OIY2JbfNIhjyUnVZi3pJb0SOMUt6jkqgWC3mJ9Ef1KEpoLafUFDjr/yRHtltgHR2t9BBQ1y+bghwW2/Q+Rm1eRq2mulXOh8R6DT4hsfqg+3qVv7+ZD8/ZNpFMqvpW8pyKVcWpP3bxMMCfEWvTilCabfkvUY7MEGVBFxlSLsuS3RcmWEbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(82310400026)(1800799024)(376014)(7416014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AJ9IxsEZokeLR9vNUM6n/RM5HF/TzZVG0ULgV1b2IrTV2huRFTqHs5l7MUMzj3HkzzhcXsu1NuTXERmLav30vCM/lqVEa/dLgaza07hefU51xO1dp1B5CVi37q2j9pgjNkiYz3X3lpTWivRg5wNcJ5P0tOIPAO30/kxbymxZRp2MdMyRsa0vEGNEatNgWcdI8wXN0fY/AlOi1MwpxU1/5Ylc76UT01SYDxkIJhcuumC/6N3T2Qth3NirgMb4QZanPmzHor9gSX5BcrJmwHU01j6q4+R8mbQEjf+I0cjUkH6xMVWPl+GR7JQ6BPE4HPW26ooOxhIMYkLlGbOZuTv2TgxUwq1bYWB9k2kx9RfqS9c5kYBHnvueBMB/OjfvVSyCshTq1tOqyBzB7Xi1vfr6DW3ZjMH4taUJ7PujrVZatSnIG/65xEqfy3eYhSCmN9QJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:48:48.0603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bef503-e8ce-409e-2fd2-08de868fcb42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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



On 2026-03-17 06:03, Tomasz Pakuła wrote:
> Hi!
> 
> So I prepared a version which completely removes the drm_display_info
> modifications from this part of the driver, but I think I know why it
> was there in there in the first place. Without changing these fields,
> the dri debug information, reports wrong vrr range vs what the driver
> decided to do.
> 
> Basically, with monitor that have different vrr range in 'monitor
> ranges' and AMD vsdb, it only reports the range from monitor ranges,
> worse, for monitors that report GTF range (all HDMI TV, even some DP
> monitors) the vrr_range for the connector in dri debug is reported to be
> 0 - 0 even though the correct range was picked up from other places like
> DisplayID, AMD vsdb, HDMI Forum vsdb or nvidia specific vsdb.
> 
> Moving all this into generic edid handling could be quite a problem as
> well since different manufacturers might want to handle VRR differenty.
> For example, Intel could decide to support FreeSync sinnalling or just
> getting the range from there, or not. HDMI VRR is another issue where
> one brand could decide to prioritize their own solution over the generic
> one (FreeSync over HDMI vs HDMI VRR).
> 
> The vrr_range in debug ony exposes display_info.monitor_range but it's
> name suggests that it does something different. Maybe it needs a
> dedicated place for drivers to show what they ended up deciding upon?
> monitr_range alrady is only used to expose the range if it has 'range
> limits only' flag so only for VRR. My concern is that we would have bad
> debug info in there now.
> 
> I'm working on adding a drp connector property that would expose the vrr
> range so compositors could easily parse it instead of relying on edid
> parsing, that will be impossible to match.
> 
> And again, I'm just a guy providing fixes, I think bigger changes should
> be taken with AMD. The functionality is already in the driver and my
> patches do not change what it does with it. I'm not even changing how it
> parses anything when it comes to edid, just using what's already there
> to decide how to handle VRR.
> 
> Tomasz

Hi Tomasz,

First of all, thanks for creating and testing these patches. I can't
_currently_ comment on the HDMI related things. But regarding VSDB parsing,
there's work in progress (not on the mailing lists yet) to move it to
drm_edid.c, looking to store everything in a "struct amd_vsdb_info"
within drm_display_info.

There will be duplicated vrr_min/max values stored in different places in
display_info, but I think that's OK, since they're also duplicated across
EDID/DID/VSDB? Drivers can then make their own selection for the final vrr
min/max, and reported in a new read-only property like you suggested.

I'm not sure if compositors would prefer to decode the edid themselves, or
rather have driver tell them via new properties. Maybe it's something to
bring up at the display hackfest.

Thanks,
Leo

