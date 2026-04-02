Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95EED6AAFE
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 19:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DB7B89289;
	Thu,  2 Apr 2026 19:44:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2IXzqTIb";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B2189289;
 Thu,  2 Apr 2026 19:44:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dmy+HiBd8dnL7rwKwf8mA92ysTbryQk10J/mTOdYyGUJXJ7isqs8+pb8h7WaAXKNLOJfUuMPiODAWirrakmEQRKxt5GOVgPhIzxb0zvMFuPtm+PBv1cbaARlxJGZ5E6MQJc/6NysvR85TkTXJJ45giUgj+Az9OraAVW9Tu8dnDNRer0nKzNzbjwkO9YzGKca6iZ9tro6lf7l6U99f46xJwdEIrV2t8YdFG2ZCmZ742UyNOjeAGD7YvESUhgBQhGH73VFnRueHjwLFjvWSnAtqyUD/4zhtUUxCWmnpcU5HnnkJQSFAp7aPGN5ztKWFpz/xeD8VmGzClG2h0m62Ib+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C77S1bJJY0iW9wnA9Pn8GPS9eCE2EzROM21refEQOQI=;
 b=urzhzv/T0Hh/MR18TjcouQPEhMetIKr5dwPzi10WSA3pcTkHZcmZ2DJyeuYCcOupv76TExcHCOgBtTrOWdxM4IHAxHTuAF6mFtazgO6sLyCcXpXBzlFAL/a3Bc4tz603tgwqfIJAdEubAV0t1O3F09mrzPbD43VCLEGyuwX8g/oX1pVD6BVDwNudDIsAb4osWsVp6OwqEHb6UrYmhQ+4En3ktDa+m5s6VeP7uYxsn8RpbTkPBYXiS7XmlERkh3AJbN/VsfSuVhcg6qg6xEXvp7qbLJR1spNF1LNqkn4ZieMXLDKyDyEEGWwVB0k0V8HoxPKV/fZTin1KZO+HJ3ajjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C77S1bJJY0iW9wnA9Pn8GPS9eCE2EzROM21refEQOQI=;
 b=2IXzqTIbtfM4IFm/+7DQ4bvy+xDsyJMcmOTBlG+VxdCUpFZVYlGvOdcIcXaykaQMsroe0TSu5TSWU8jgUz3AzqrLA/QIccCCXc02/GIaWzMEnF3/6X5LQALDN21jwRbhzOgz6sRPPsNOgPo81ihg2jm/x2hJlqhwq/8Snpr74WQ=
Received: from BYAPR11CA0041.namprd11.prod.outlook.com (2603:10b6:a03:80::18)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Thu, 2 Apr
 2026 19:44:25 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:80:cafe::6) by BYAPR11CA0041.outlook.office365.com
 (2603:10b6:a03:80::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Thu,
 2 Apr 2026 19:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 19:44:25 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 14:44:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 14:44:23 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 14:44:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <airlied@gmail.com>, <simona.vetter@ffwll.ch>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [pull] amdgpu drm-fixes-7.0
Date: Thu, 2 Apr 2026 15:44:09 -0400
Message-ID: <20260402194409.914769-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8dc91d-ccaa-4f1c-678f-08de90f03ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 62XRyBplzKQQk6civ2HXBnXMHO1n/3X5Z+VchTcXztgPd9wsFgf2Laz5y7saFht578Worirz6F+0A5q1xDUkVB9ozVHyGQb5F2VwCdYDUPXmCzfb9xdZ/Z4YlckD1tlM0EXKIFQnE8xaC0rkMsuMgj5hTSt5pSIMari7H6YmAC4aHrhze59mjIH6JJUXwG2T/M5mC6C7LyN7ynqWhPR9WhpvYyX8c1Vde3OdXnKe1F6Du0kTe8HwO2ZbwMZIEc2fRQQLvA8nh4T8XRPiQ0TsP5j3nm4sR5WHJDbRC5pLSPrkOqRlI6Kb1SbntWbwOhvvG6s2bQmwAIX7EOuUgisSkITqTN9ONJ/I/bZ7JOAJenydSjhN8VE17DLYX7IZo7zrr5eC+x6TO7tDY1R+je4egp9hk42RNH5snIEHsRuwRHWFd8Wgl8zKEkKVslN89njU/pNfeyYaAQXynAjKvoLDcTNffqBvAFl4MQUB0o1NQ6gP9NNkq1oFoKjFF8mPpO0mAedcZEocMo4JpjPyR/FahjxwD+Py0OjbnHqHrPeK5+KdO7WhtMjCdCMJo9/ONKWy1gmb9iIZiIUp7+1fc9Ld3CKNlbmTC0DXse1/+1bIpTNZCgiysFlDG1N4XOlWhg6e+f7NJhA3ws2GDrPREW87Zo736IRl2zwRCWsEHqAP74Bi9MjgTqZa/8UMF5q5hvSsdhXfpOy/s3wFXvkZxYg3JpLZJMVXdaya1TEUty/gRi0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(13003099007)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kyqKOhDuV/874Q9q9M6If966eVk+/lFXhkyBCTe68EPBA+xtUIfi0J19XuHcif79LJ5AApWqZ9GodPJcm0FVDDqITtUh1OOK4d7WAVozD5l2mcnioaOAA13RidPtHma7zX4B6cNe58bXUOX5bqG7OlvpqPfvIXvLvfdYS5CaPE+wGusOV31F19/iNm/1vYWfpHgckh8Yooh2BhI56LV9YFjcm8GR38yMKgTKgdSQTm+trwtCSIJwQSF4/ZfP3HL7DBLLYeA2sk0bU2LIKyPXOyuCmXfBUQK5+7/jYishqBEtGKvBIu6p5ahIDT5nGwJKwKY8a7YTs7kkcxt8mSogvAPIbFf+JZpxnNWQ4WDxND6L/WkpmaQUVh4HYeaxojvcklgMkWXvOVF18dWvmI+Thf2SaxVHI3QPZaUJPbjwMqeB+auXS37ES3V3lOGCm8+1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 19:44:25.2303 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8dc91d-ccaa-4f1c-678f-08de90f03ed1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715
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

Hi Dave, Simona,

Regression fix for 7.0.

The following changes since commit 78746a474e92fc7aaed12219bec7c78ae1bd6156:

  drm/amdkfd: Fix queue preemption/eviction failures by aligning control stack size to GPU page size (2026-03-30 16:22:44 -0400)

are available in the Git repository at:

  https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-7.0-2026-04-02

for you to fetch changes up to a4983968fa5b3179ab090407d325a71cdc96874e:

  drm/amd/display: Wire up dcn10_dio_construct() for all pre-DCN401 generations (2026-04-02 15:24:13 -0400)

----------------------------------------------------------------
amd-drm-fixes-7.0-2026-04-02:

amdgpu:
- Fix audio regression on renoir

----------------------------------------------------------------
Ionut Nechita (1):
      drm/amd/display: Wire up dcn10_dio_construct() for all pre-DCN401 generations

 .../amd/display/dc/resource/dcn10/dcn10_resource.c | 41 +++++++++++++++++++++
 .../amd/display/dc/resource/dcn20/dcn20_resource.c | 42 +++++++++++++++++++++
 .../display/dc/resource/dcn201/dcn201_resource.c   | 41 +++++++++++++++++++++
 .../amd/display/dc/resource/dcn21/dcn21_resource.c | 34 +++++++++++++++++
 .../amd/display/dc/resource/dcn30/dcn30_resource.c | 42 +++++++++++++++++++++
 .../display/dc/resource/dcn301/dcn301_resource.c   | 42 +++++++++++++++++++++
 .../display/dc/resource/dcn302/dcn302_resource.c   | 41 +++++++++++++++++++++
 .../display/dc/resource/dcn303/dcn303_resource.c   | 41 +++++++++++++++++++++
 .../amd/display/dc/resource/dcn31/dcn31_resource.c | 40 ++++++++++++++++++++
 .../display/dc/resource/dcn314/dcn314_resource.c   | 40 ++++++++++++++++++++
 .../display/dc/resource/dcn315/dcn315_resource.c   | 40 ++++++++++++++++++++
 .../display/dc/resource/dcn316/dcn316_resource.c   | 40 ++++++++++++++++++++
 .../amd/display/dc/resource/dcn32/dcn32_resource.c | 43 ++++++++++++++++++++++
 .../display/dc/resource/dcn321/dcn321_resource.c   | 43 ++++++++++++++++++++++
 .../amd/display/dc/resource/dcn35/dcn35_resource.c | 43 ++++++++++++++++++++++
 .../display/dc/resource/dcn351/dcn351_resource.c   | 43 ++++++++++++++++++++++
 .../amd/display/dc/resource/dcn36/dcn36_resource.c | 43 ++++++++++++++++++++++
 17 files changed, 699 insertions(+)
