Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98416F9D0F6
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 23:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7776110E025;
	Tue, 14 Apr 2026 23:17:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="St4t5XcA";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FEA010E025;
 Tue, 14 Apr 2026 23:17:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNCpiIhxyjUgjwMv+Nfwzyv3Skr/isD2NWQczLNuixDFobwdb44RTtovRfu4oxZg0KKhLZuOgQAR3zTpp5M6IoI/ulaCF6ghudNVM44Zlfq7jgAkIyaY66hXwgptb4aWTd4ZkXzxlV9TSsXdJ2luTsd24yCQXiggrjRcKgq/VYTZ9bYimRA4NJcdgx9/PFJVjALZgp5Ksw0tVYsHMuJ1LVxc9GZFz8gh2WjX1sVi7WjjH4+UQRJSQo+rxdtpdwRtGu9G+6W7Nh1y0xhiELSaAE5L/NybSTWeDEN5AkhwpPILX1VLjqYV72k7FZrPH55C42Nio1zfmK7f2QMsS5bFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHcARKKx3y8Uem8Suwarjf/E35iZ/oSG2D9rXDjB0CM=;
 b=yvf1bWudxaRytaKcPObThie9oyajDAlpxSWPb+5an1Hgm5lRcaiVKzPfrx27B6mM9j2E4IxOhaAliT/M0MTViVfqeIy2nsvv7MRhG6z/3KCynwDVtFMPfP4tomrZEumb78JkNygjC0MPnUhZRyfdYmC4d/HaAr1qiDVz22GzRFvzNb5vnrBar5q9K/I9krsdS3t1GQGitvt/gtxHCzVgRNvqz7Q0z3AGZVGuw2XZ/Ilc/ILM1x1ZbG8Z+iqpZ8qVjoEjM0mAGMi1oPSUDKJtTcTQRh4SFLHt7jpt5eSrvrvdbbqfwn//J265CiIWzh0jY8ASn8j2KP0iSXbl3QByNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=igalia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHcARKKx3y8Uem8Suwarjf/E35iZ/oSG2D9rXDjB0CM=;
 b=St4t5XcAtlO+dThI1JpNyG6cpn+kzjsWHIqVfdiFm7Y0RQzxdon6QpRsM4v4I49p3xzrtFGTQvCGAiBocK14UzU60YnvPeU9dAE4j6YlpdWKNHLl6cQ+RisFSgfIRWPPGa8vUMwoIhNDHUFeQuTfU3yT6OtLjeV2L06UId1l/x0=
Received: from SJ0PR13CA0080.namprd13.prod.outlook.com (2603:10b6:a03:2c4::25)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 23:17:11 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::e8) by SJ0PR13CA0080.outlook.office365.com
 (2603:10b6:a03:2c4::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Tue,
 14 Apr 2026 23:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 14 Apr 2026 23:17:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Apr
 2026 18:17:08 -0500
Received: from [10.254.92.140] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 14 Apr 2026 18:17:07 -0500
Message-ID: <67d07c60-a535-42c7-a6fe-79f9dd90c9b4@amd.com>
Date: Tue, 14 Apr 2026 19:17:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] drm/amd/display: more drm_edid to AMD display
 driver (partial)
To: Melissa Wen <mwen@igalia.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, <airlied@gmail.com>, <alexander.deucher@amd.com>,
 <alex.hung@amd.com>, <andrzej.hajda@intel.com>, <christian.koenig@amd.com>,
 <harry.wentland@amd.com>, <jernej.skrabec@gmail.com>, <jonas@kwiboo.se>,
 <Laurent.pinchart@ideasonboard.com>, <maarten.lankhorst@linux.intel.com>,
 <mario.limonciello@amd.com>, <mripard@kernel.org>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>, <simona@ffwll.ch>,
 <siqueira@igalia.com>, <tzimmermann@suse.de>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Michel Daenzer
 <michel.daenzer@mailbox.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <kernel-dev@igalia.com>
References: <20260225121903.236115-1-mwen@igalia.com>
 <3856874.aCxCBeP46V@timur-hyperion>
 <3d928ea8-dee9-40cc-9fcc-af063b67138a@amd.com>
 <be7debbf-727e-4017-906a-36ee81fd844e@igalia.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <be7debbf-727e-4017-906a-36ee81fd844e@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a608dc7-8001-44ba-e0ed-08de9a7bf3b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|7416014|36860700016|376014|82310400026|13003099007|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vSHO1BNVFqk/AGWIFKv/tlqVBVSlYW0FAj326dGMbW73Q31WKiJDSxAnKeVIx/GKz/hfOf+ri5p2ZJo9H5HN5/gektYoEMmAUJa22DP0FiFiR0wH8aJmTUk1MZhCwkaDqHVefBgmhiyizFBD9VWmrfOOONt74k4a4ztH7oBEOOH9HD47qR5E1XOvEoHZbdGyi9jdzbG939wPVET1j1bxee3KAO+mqj7la+2i9BY2Mp/2jWB78CiPAJJGC86lCdvbVPlWSotkTdQ4urmBtmNbCT7ELlnbtBJoSptH+Kb5RMPXV71aNl66YYSF0OK/tmPu/oVzd0BlDq1uzs+r1nZ3KRBiR/MbUy9MI5v/E772dGvczuvvawbclww7StrOqXYq0K/ge3MxdAcDbmu9cuQKHc3nYs96WVMfMUeu3W7dMmgo50AB1oPcX+iXpcgzwLFziANjUhOwSLdZtgGnUbAOwJ5HFfusWUgu2oSk7g88za7N+zyCZAPGSCqLJaduun9xUrL5nJ3j8QSObe/1taNuCGD7OEXtqbQf3oc9QYMh4U1/oMEk8uOCVWpWA9CdVNoD3Nv9EiiLONu8gyI6ReWnLI6uUuvDhJp6P0HMMk1FLJiGojjXVN0RqlXcOnFze6q6xjy51LxlZZb5O86eOij3XvR2Pm9tQIhI6QTbLVp6lNKyUMWkMXpWzbR6sePVBvnbruRIG6Y+q25HzRC/m9i2GToeD3xBMMiSKkIfuAtrr0N/1XhxMLfXRpIqlePR3RdX/QggvDukkpUZ+4ikAZtF0w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(7416014)(36860700016)(376014)(82310400026)(13003099007)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: djPV4o2wNRklSYnu9hmZytYrhTsMZ0RjthfTI1v4c0dpckQVgbAQk6Sp/SQoBwtSJFh9vTdF5XYTJWw7oR6T+pfVGGcPyau0e/o3B8JwbLRioQcapxqXXQozoa18It1eL4nZzI+n+3G+NLBVzGhE/QwT/Z1Ci2mA+xpO4oS7LVcZS66tM3BCf3eb9aTkXm5MfVJdTyeCdmg7BgorvjqQUf9IId9NRuzRNsLxSAGyivZc8pzLcVbn5j4hgtqBZIqDSQuG5HSRjraDDlr+m864EY/zIkhlcK5CJXF8+McLi4cE8sM1YQA8btd1Yp13n5n1JWy4bMocamiyNTJ3i9ScS+1ZjLTZD/LaiKNoEYiU5CFNgRy378IlSN30ZPbKh478GgHo3pFsRLFplXRw9JfXoAwF/MnLx9ysZgifJU65lbmuLdmjKSvdGDP+++UrhNUZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 23:17:09.2160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a608dc7-8001-44ba-e0ed-08de9a7bf3b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136
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



On 2026-04-13 13:51, Melissa Wen wrote:
> 
> 
> On 31/03/2026 12:45, Leo Li wrote:
>>
>> On 2026-02-27 03:52, Timur Kristóf wrote:
>>> On Wednesday, February 25, 2026 1:04:29 PM Central European Standard Time
>>> Melissa Wen wrote:
>>>> Hi,
>>>>
>>>> This is a reduced version of `drm/amd/display: more drm_edid to AMD
>>>> display driver` [1] sent a few months ago only with the less invasive
>>>> changes, i.e., those changes that don't affect DC. This partial focus on
>>>> using more drm_edid helpers instead of raw EDID helpers. Most patches
>>>> here are already reviewed by someone and I think they can be merged
>>>> without major concerns. They can also prevent new initiatives of keeping
>>>> parsing raw EDID as driver specific code, which can make harder for us
>>>> to remove `drm_edid_raw()`. They should focus on moving raw EDID
>>>> handling to the DRM common code instead.
>>>>
>>>> Regarding code changes from previous version, here I added some r-b tags
>>>> (from Mario and Timur), fixed commit message syntax (Mario) and
>>>> centralized error handling (Timur). I'll follow up the changes in DC to
>>>> accept the Linux/DRM opaque object in a separate series since those look
>>>> more sensitive.
>>>>
>>>> [1] https://lore.kernel.org/amd-gfx/20251106165536.161662-1-mwen@igalia.com/
>>>>
>>>> BR,
>>>>
>>>> Melissa
>>>>
>>> Nice work, Melissa.
>>>
>>> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
>>> For this series.
>> Thanks for your patience Melissa, series is also
>> Reviewed-by: Leo Li <sunpeng.li@amd.com>
>>
>> We'll include it in this week's testing.
> 
> Hi Leo,
> 
> In the end, was this series applied to AMD's branch or do I need to rebase it?
> 
> Melissa

Hi Melissa,

During testing, it seems we're failing drm_edid_valid() in this callpath:

    dm_helpers_read_local_edid > dm_helpers_parse_edid_caps > drm_edid_valid.

I'm 90% sure it's because recreating the drm_edid from dc_edid ignores the
HF-EEODB (HDMI Forum EDID Extension Override Data Block), which can override the
number of extensions dictated by the base EDID. However, drm_edid_valid() does
consider the HF-EEODB, causing this line(*) to return false. Commenting it out
"fixes" the issue

(*)https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/drm_edid.c#L2076

This whole drm_edid to dc_edid conversion in dm_helpers_read_local_edid(), then
immediately back to drm_edid in parse_edid_caps(), is really not nice... We lose
the HF-EEODB-aware size by creating dc_edid based on the EDID-advertised
extension count. It should work if drm_edid is simply passed straight through.

The challenge is dm_helpers* are DC's interface back to DM, and there is another
OS that depends on it. Plumbing drm_edid through DC would be quite challenging.

Alternatively, It should work if we carry over the drm_edid.size value to
dc_edid.length. Do you know the motivation behind keeping drm_edid->size
private? Would it be a good idea to implement a drm_edid_get_size()?

Thanks,
Leo

> 
>>
>> - Leo
>>>
> 

