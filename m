Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EC3C624D0
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CC5F10EB29;
	Mon, 31 Aug 2026 21:06:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5URKeDo+";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB22F10EB1E;
 Mon, 31 Aug 2026 21:06:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JE928h8sNauFvT6bkHEZDdJ/GO8g7IcNcPiSFzasYln3qo58cowFuwQGIRVkc0ABUyvczlf8exq6On/F96srYZEFnEfrQZ+tSzmUz4ttSbEAv1rDuS10GoxYQGvfOIN/XBOGObaSjbli1ZgqisrZs+dAdK0E4GuP0IfLBj/i3Bhpcephrmu5jy71j5VJaetQTJ1mZp7nuwXHwnud6rSgomCyaSylIbrRYxPdMFCrdrXFXoWTqnr+E3XaKd0A8Bf58cO4IY9shDpdyFhqmqwZ/+ED+vIvtSnlQN5s3dEdpoVbNjX5UP37yYDNVUhc7ByQ0TwVinuDVTo6p9cABFzQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRZeFnQoo4lxD2I6BaCQ0/YiZ49qpRC+A6495fta1fE=;
 b=p3z4Dl4BJOyWpXr9IA/yZ/Jyg1KCYy12lLXVCzGXk+dGQnS7K295923p5IVMq1tTF6cFycbp05Topmmoy4roFRf0sUahbEQKO3CoS202zcqQ7RKDVbQnVrbFm2HrfduAap/N5W3wZkwPAefVEa9u660Eg+hXUqHeJqRazehff1lCVGebvSaDvmHerSbpl9vUC7y080uuZsLRqRoNaJftvWkJqPhOrMVPHPiJ2yGNYzVj4g/kdJWSIdT/y4hMzOZbGXEfi2ZN+d8ijAjdQYbCHUsMs7qUuOc3pNocDk3t4mSLvUf9AOSkRAXH7fnzcC6WyZf7S+IvsXZghL8BXXF8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRZeFnQoo4lxD2I6BaCQ0/YiZ49qpRC+A6495fta1fE=;
 b=5URKeDo+UrcYn8vCkWXOILm2VPpA8VIIYDDL4auPQ4gED1yHLYZjLHGOo+VhdLD9yzzc4Ezss2M61Qw0qXQDcYILZzsZ12yFKklTMStz+HLvxT8ITnU9zdCzl2MeZRqpX4pd/fQ8OUylZ9hrhKvUVvcVGrLAp2wrr0H44c+aTOU=
Received: from BN9PR03CA0194.namprd03.prod.outlook.com (2603:10b6:408:f9::19)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:06:08 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::39) by BN9PR03CA0194.outlook.office365.com
 (2603:10b6:408:f9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:06:07 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:06:06 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Hans de Goede
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v7 11/12] drm/i915: Indicate support for luminance on the
 connector
Date: Mon, 31 Aug 2026 16:05:30 -0500
Message-ID: <20260831210531.2334221-12-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831210531.2334221-1-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb7f54f-16f7-4fc1-6792-08df07a3ad29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kBGuUf3sXISpuTdWll4ECLdUu9TtVS/O975+sU4tlbqLQSmYPSZ7s0Xk1/P0FgOb+4SRroMNjx1KZBWL/yKWTmhAexb7ZEnUU0pHeK6ua2JAqV43Ipy+mCVK/1oM6Q3XL8rNtV9IhUAI9UTXmqdjDl7CNGmPJEvvFNtitu96FjIrm7r8c8zFNBoFHmU5+8oQAKgZvHd3Xs9+QorrN5yPrfTH2iswzRp2pIRDHf04d+N4sbIA5xckymZNSQpXL4NzZ9Jbf6UpYtx0vbSjKz+mPGXoqRc0NPsp/MXTW1PxoXO9XA1evaJruhBGaTGeqAv19snIq68CwE8TGLRAfuhhijB8xqbXEFgxvemy7wGK2nbKgXDqlxwg0j39E3oc/mr7e46uvZHZsvVp3tgANL79uykyeKHMoHAG3on4I3TcyngEkJM5BsR0mBSIhCgS1lnWCaSPRODgt1zu2un2Trd9R1qi/P/JRiaoR7fVam0c8umf1Bv7Rv3rImunywspvgRrOJfUSoI6KhNuXXwLwdcWuLSR9d0CLzoQZfadeUBG4QjdUbdrGDXSyAOi/NTI0LHCWMFjf+641OVeKPPcnYtrDGEkGx/ColCsw3kfv74jk1tFEiYjembYU+vKbrsgzdgwb2Vn4CBF1LyFQlMmxb/RurCChbi0VKvItogBN/d9KJSVOxB7Mgih3iH10SP2UbrLI7iuPBpUUpq4mVVKC/967Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y4cnTXnusKZixs/Hb+dbZHXaMVd4SOsBjqSU40WsMa9ikJEOo+tPWnAWf31G5T1CHl9KbJ5arfv6DC3IJlT1TrABxP2yPmqSsCpzCim/LvoeGrqVh8bdBdAFTwi9MsvM1tmzumyie9w1KAiAT0KpdrMOM0BsZPUcxPLFymkVvOwQSwDYlaJY1mXMJoBZO4b/ZXUHD3t8ryrNo/X7gGKpgU8xmPlKOg0ousJFosoBwRJbglFP876dFAo9ICSAYWBrfFlo7b15E/UlcecMhvzN+QPzRX1sJf9e+QEzLQ6GVfpgiT/oBy2rYrxyv92wliK+k0EViB62pd6xyx41+K29hTG56N5I8rr9XZutfYbg7/t62AED/qf/9sTjhndPCBcbfNLE8Gk9+I3BziNvqp/YNxxPbXF0fu+4d+2sA0KVIjxt9w38z66TkpzNoqBVKU3P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:06:07.5743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb7f54f-16f7-4fc1-6792-08df07a3ad29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
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

This will allow the connector to show luminance information for
eDP panels.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/i915/i915_driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/i915_driver.c b/drivers/gpu/drm/i915/i915_driver.c
index ce6d20958320c..83cff711d28df 100644
--- a/drivers/gpu/drm/i915/i915_driver.c
+++ b/drivers/gpu/drm/i915/i915_driver.c
@@ -1768,6 +1768,7 @@ static const struct drm_driver i915_drm_driver = {
 	.driver_features =
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ |
+	    DRIVER_CONNECTOR_LUMINANCE |
 	    DRIVER_SYNCOBJ_TIMELINE,
 	.release = i915_driver_release,
 	.open = i915_driver_open,
-- 
2.43.0

