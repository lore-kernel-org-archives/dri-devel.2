Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F63109B493
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7553B10EBA5;
	Tue, 31 Mar 2026 15:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="foj5kiFu";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010024.outbound.protection.outlook.com [52.101.61.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C40910E2B1;
 Tue, 31 Mar 2026 15:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOPBtkgbPe5NW4ZMU5F2B9atYAWSSXtnyaqWzbxUUCezMjKhxsib9OVbvyEbmHy0/4H/+3Qztn/Ffw82nUE7bZsAejMtaB66QsthS6itDwFhiLnvP6VgECB+4ESsNilTcqOZoq848CHFAdUn+G8r5kdgWlXgsJ921qfTkaoj5IcSj5EB+ARsrBOGr+J80IIGlFedr9cT9A+Mc9OvPVb+Y8LuTZUjjN1ydzvZSfFA1fSlVaRTsgXS3kf7EShM4/dgC1cyU/HKHP66a1kcIuHLkd7+nS0yKCk1HveUhXJi2Uej8320dnF6JQmxjj34/GVLHKQQp6dxMGW+hw1mjPqO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DaoARQpeI5cJKYRJGALOOBxT8lCEO910+g9swoxUZw=;
 b=xN0CAgIVlhCFBn324oDmWIbHrWKQw2V6cq+ZudY6oNNYFJRwBARqxplHIG0q/HVQ2ct34FAl+PywoaaLpJpd6dS3iMdLfyVQEeesMhFiQ0Yv6GMvP/mbPjiAamI6S+XoQAlrtQyigCGF/Cyszr7rtVjDfnUmv9dd4d+fw8x1eGjvPP64YLuo9NWm/LCF5WWfGr7ga4NOX+lwfihcdUz6H1szbZyo9UgVii0vZPMkQpE78ocYZvC2cC5MIf5pyQ8Acx9+m9Prc6tINIOgw3nDvw3mXahGEmsPEzZIK0FZSYqMNFAHJmkgcqbRKyJG7gdhTxSjMr4xbB13nYly197xzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DaoARQpeI5cJKYRJGALOOBxT8lCEO910+g9swoxUZw=;
 b=foj5kiFuixY5s3DeuK+K3pL85VJBhf4reDAq+4dwUZVGKuZ7XCSzxDvA8oIaSlVN6Bo2yfVj7AuQ/kfWStACQSIXFphuyYGXm0jTliH0wV6Qd8Lgb/UzC1C2Y+EC3gP6wgVNjFJB/eMsLygiTq15RCmuxi6FPe8aw7hV276WZ6U=
Received: from MN2PR14CA0007.namprd14.prod.outlook.com (2603:10b6:208:23e::12)
 by CH3PR12MB8185.namprd12.prod.outlook.com (2603:10b6:610:123::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 15:45:55 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:23e:cafe::a) by MN2PR14CA0007.outlook.office365.com
 (2603:10b6:208:23e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Tue,
 31 Mar 2026 15:45:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 15:45:55 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 10:45:53 -0500
Received: from [10.254.93.25] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 31 Mar 2026 10:45:52 -0500
Message-ID: <3d928ea8-dee9-40cc-9fcc-af063b67138a@amd.com>
Date: Tue, 31 Mar 2026 11:45:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/8] drm/amd/display: more drm_edid to AMD display
 driver (partial)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 <airlied@gmail.com>, <alexander.deucher@amd.com>, <alex.hung@amd.com>,
 <andrzej.hajda@intel.com>, <christian.koenig@amd.com>,
 <harry.wentland@amd.com>, <jernej.skrabec@gmail.com>, <jonas@kwiboo.se>,
 <Laurent.pinchart@ideasonboard.com>, <maarten.lankhorst@linux.intel.com>,
 <mario.limonciello@amd.com>, <mripard@kernel.org>, <mwen@igalia.com>,
 <neil.armstrong@linaro.org>, <rfoss@kernel.org>, <simona@ffwll.ch>,
 <siqueira@igalia.com>, <tzimmermann@suse.de>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Michel Daenzer
 <michel.daenzer@mailbox.org>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <kernel-dev@igalia.com>
References: <20260225121903.236115-1-mwen@igalia.com>
 <3856874.aCxCBeP46V@timur-hyperion>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <3856874.aCxCBeP46V@timur-hyperion>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|CH3PR12MB8185:EE_
X-MS-Office365-Filtering-Correlation-Id: 4acd0c7c-191f-4077-68bf-08de8f3c9898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700016|1800799024|42112799006|82310400026|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: icqQpR5nAJuOYnU96KnNb4WrtlGL+BRauPwpgL+YnjMokddxzJOaQa+HW24gBD2USdSrV+VxOwS5pYxSyC4mOMxeh3ZarV9z6ZfmvRqUxFcpISv7dOO9yszLZEJHZyReD3IO3g5MfYzjHwyJV7F7+fwbi3vth6PXia7Mes3trZwC3Mfwhs9lVQmhgolPa4Kw2f/WZXtE4pfNekIX4ls2Rok49B/S6+NPvabhdCZn5bkigmDIJhu4skF/yqooXYW2UumwJWh8MBX1NMVS3OF86+E/pze5pEkrLxOgE98ib/OIBP+PMVyZkk63sc0z1Tismallnxwq+aOj8i7sWWq1vGRSXncseJDr5LrCE9SttDCUnEt0TR0HwiGIlQc4XxFllCDVgMqvE3yBIq1/aDkjJWwRQpUu4ApvBZZWxWNCbl70FP7AWrywB80Kn8bRzaVaqmvuT5SwK9YikCym52vrZZiDojUeQYZYIbAYXVOeIwKJitPwfuY1WKqPuvOftGpAxWdEgVPWe2blFN4poeAhG6qaAjnZ3OloCjxdaPKItdeGyhWZ4NGoOnVI4uVQiIVOcZm80uZlSanI8cwAVFfYkuNpY6bK5BibpSUnnInmyNfdsw3z+Hg1LmlbSpWfumOK2ATNwaoLPctaY4won6aGKjjN7vouixhqaLcm1L6oIEwt267FT0oXrN6pWZK3ZTWkjDLG41aVFv48bJD1PHsA2oiGX+8sps0XrBXp7jjhUMA3kH6t/VOcQXz8EIMbOTI2Lj8VfX1olds3HNdREi/R/+xcAZLn7Ob1CUz97owS/Ea45AG9TiD7o5Iqsto3DhNs
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(42112799006)(82310400026)(921020)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i+bOPnapl1pAfjW7oqfAfeC0X78y2gJ5xdKKjuWNVJ3ua6M6pPuw7QtWP7e/QOUDMUn3ukxCQMdJBakeDHxFLDsLniVUL7xy5ypKrdv3t8Ehy9WOo31VRn+vluek1xTP71P+1Mjy1Lj5LI7KMT8alKFWaIYjv+0QM+bms2hUneCsBjbDu8WZNxxST38+NV3AL/FKj4wv40EaMizIoL1pyUnijFNsBQXACD8J4o3y/Q1ksAFzgNBCSlxLhHGpSRr6CJYvAO3cCMQnUG+VpkFU2U9dRRm9h1Iqnz2BxdGwubbiCzEQ1HGX23XlZMfeQb7ETRlcnm4H0bPAHRm8mkN+hah8/hfAiX395ulSkZqL47Kj1u90tq0S+jhlK6uiETOKtubPxgF/lysrMH0p5ZfEiHOcQIjwocVZzYCjAFL30PmzSghUGDGjcLm/0KPkH50N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 15:45:55.3690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acd0c7c-191f-4077-68bf-08de8f3c9898
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8185
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



On 2026-02-27 03:52, Timur Kristóf wrote:
> On Wednesday, February 25, 2026 1:04:29 PM Central European Standard Time 
> Melissa Wen wrote:
>> Hi,
>>
>> This is a reduced version of `drm/amd/display: more drm_edid to AMD
>> display driver` [1] sent a few months ago only with the less invasive
>> changes, i.e., those changes that don't affect DC. This partial focus on
>> using more drm_edid helpers instead of raw EDID helpers. Most patches
>> here are already reviewed by someone and I think they can be merged
>> without major concerns. They can also prevent new initiatives of keeping
>> parsing raw EDID as driver specific code, which can make harder for us
>> to remove `drm_edid_raw()`. They should focus on moving raw EDID
>> handling to the DRM common code instead.
>>
>> Regarding code changes from previous version, here I added some r-b tags
>> (from Mario and Timur), fixed commit message syntax (Mario) and
>> centralized error handling (Timur). I'll follow up the changes in DC to
>> accept the Linux/DRM opaque object in a separate series since those look
>> more sensitive.
>>
>> [1] https://lore.kernel.org/amd-gfx/20251106165536.161662-1-mwen@igalia.com/
>>
>> BR,
>>
>> Melissa
>>
> 
> Nice work, Melissa.
> 
> Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
> For this series.

Thanks for your patience Melissa, series is also
Reviewed-by: Leo Li <sunpeng.li@amd.com>

We'll include it in this week's testing.

- Leo
> 
> 

