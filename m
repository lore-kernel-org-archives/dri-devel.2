Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39659C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7333210E94C;
	Mon, 10 Aug 2026 16:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cfbR7BMJ";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 160D910E94C;
 Mon, 10 Aug 2026 16:54:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfI+O+Q2+MoR1NFerG5kbaZXSprpTJ9F9r9qEY0ZXJ/aPGWeQWLlnVJnSCjZMXFjEAl07mDNYBSZapvVpI6O624L4CLKYeocjtBs/vxDMXnmEqXcIokEzWL2VlMTCT4R5aBXCgEk3LMc/j9MlaYmgIh5PzPm2yEGVDRfqIqgLA4ctHQX5Hnjs842GEJCj7Hh0s6fwYSu3K7PHob1qXvP7D9LFbuDU2tGd2Yz/q9NgLHdKMZ/09H+8GdLSDkTydMCy7mqgQdWsP7FeCHQUFqyGMG4Dq28ahaIBBFYkbkDjUYHr5ONSmoMJ0hBpOqB3KmO+Pqn1cQjnHvnyY79q19lxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEs//MTsU3XWZPySmch0+tUrpSCC6yAjAQ0VX52Pom4=;
 b=AvJpaDTHQ0MkkVtAU6QgtpVM5etMv0ue5k4hXZyHTbO2qMeOFRTxvuzoepBXeQd6hDtQ8nNWHpBFBwYoQ4E2P1ZNIuL7uR/ZAXmqvH6QHyRlIZ+CdQURO42j/F9u0mwutl2k7TaCckCS4wV0wYpXMKOVvRCMQQsdlml/y1cJMBCXGRoeFCd2UfrByF5Ykj4vnkU2Re4/3USNQYb/nvR12PrJhLsudC+ZSqRwNKA6qAblmqpKpg2lqfcErfkNo1GMVllx2fJNkpTP59st7PZaSipCTIe5YkxB/ZDmSHrgiVJ7aEUWcwtZa6rhi1nnsu0bXVkVr57EIADZsRC52BmvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEs//MTsU3XWZPySmch0+tUrpSCC6yAjAQ0VX52Pom4=;
 b=cfbR7BMJVYe1VferIVDn9ghdRK0bWQ2DXW+7oHpJxlzAIPardhEv+D7xOCs7q/Ys9GxUur7ODsDTxMNzstfQzZUWdcJ7WHWm13zqTrVXExEIgZ9OEaUJOzNvKVTFSMxaXwjwxdZVzjo98BVKMyKeQJZfD50+IhAuRCOWG3Suqa0=
Received: from PH0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::22)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:54:46 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:d3:cafe::3d) by PH0P220CA0004.outlook.office365.com
 (2603:10b6:510:d3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 16:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Mon, 10 Aug 2026 16:54:43 +0000
Received: from FRAPPELLOUX01-WSLPUB.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 11:54:41 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 3/3] drm/amdgpu: skip amdgpu_gmc_flush_gpu_tlb_pasid if
 device is wedged
Date: Mon, 10 Aug 2026 18:53:20 +0200
Message-ID: <20260810165322.24682-3-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810165322.24682-1-pierre-eric.pelloux-prayer@amd.com>
References: <20260810165322.24682-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: a844844f-eb01-4262-5c41-08def70013da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jTdnjjiSvcp9MR7mF1z0LavzrMZobUiLg9v6T1jtFAQES2TMMFCrGjcR6Bhyt4r4vnCWE8P6aOAy/R4ttZ69UQWAQ0A2RZNZbtrtBgd2peepKjI0ci/GxaCm6wymT74SY4wBprPEkAfv2RMJbpj5OZS6+5W5TwQnz/5DlM1Gr8eHcYAJLAvDYqOtgfEjP/kONSV/AKT5VIjlpUSmNiwu7O8VnDVpcL3oQzohfSZeO5K0nn6iHASyFToDKx3quvqH81ejvS5gAC58IKqK6/Ny+CahQxQ5zVzetsArh1vT2TEQt+PnTTni0qwq19SwbWI9tLLgo6zpD4f1LaePbl2fMqUNxe9guTqQ8QSsST/VsSiAfIJBnVUMcRFuApQSSne8McwJrEJ3gL+a+3ntxNW/L7QrDKgTKcbIY0wRoPfx5dJP3Ob+PbgSCIRzSeRqjfQUS2R8Mhay1zY/dxjahFBQvmPdExmM5iqxVNfedJeYJqU0IisZeH2MK5m4gw0JLwhDGYTQnVV8nfWlsE2BFJHKlhtbMql6KhBI4unt3eXtZJo5dCWJET2fGfsSepP6ecXXsJYqLqARp6En3hnPNwve5NtR0QV0K+7SWxv2bS9ysEP72jMox9Yl5IkvG5bRJqjIuO1ROhwK8HDT1gTwnFKC1XH5XOEoA8O2r/bqjnA2f7lgqvRspv2+on0lN2fFGjnfdQ7QpSGwR6HtYUTMcj57Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QZznJl7dZcgcI2sCmQEALeP5z/Kc+Kn5knKZMUchl6Di299pd2Qj8ZyeaijUiPi8djxYvCMXUuRuvdqkuOuDjEyMde7M+bSQbbSrSRdDhpt79zzuJIUEuVhc6Q7FnNUw/LMMrNAgi04d4HzGsLFWF0twkAJWRa8515qkZwyHIS/9nflSzLz0LXqR1miAq//42JeRfb+AT4CZJfQATatTbGqzgOBQ89EDHjdY61fkHVrMSNxtGaYW4MkOL3sAGoDjWhziE3h1AXOO2HZPy6CN22+XekgFvQmlWaEowBq9rqmqf77gnDTPSxkc4K1GmBk9OeE+wJAmNXUk3uksF2OifXTydwfLKfdhX/5FBJY4S51XrVgCAKvulbON25Gw/QqdcoTNsyQu4Cgfgq4rjkE5Py2HgMTTJROk+7XDVks9BbLcdAyGwMaYpnneXhRWbrbN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:54:43.6975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a844844f-eb01-4262-5c41-08def70013da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498
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

Otherwise it'll fail with: "failed to reg_write_reg_wait" and we're
going to fill the MES buffer which will prevent the reset to succeed.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f43d85ba4b78..c33320a6413e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -786,6 +786,9 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 	int r, cnt = 0;
 	uint32_t seq;
 
+	if (amdgpu_device_is_wedged(adev))
+		return -ENODEV;
+
 	/*
 	 * A GPU reset should flush all TLBs anyway, so no need to do
 	 * this while one is ongoing.
-- 
2.43.0

