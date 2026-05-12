Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7833FCD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 22:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E1D10EC51;
	Tue, 12 May 2026 22:32:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BZW6JCpI";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010049.outbound.protection.outlook.com [52.101.201.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDA4310E5B5;
 Tue, 12 May 2026 22:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xg8Nk5TnGwaJLbXZR9M6kaEpxPIvA09sG7d8oLpM6MV6OFr3aT3tm0epwoxkbxmRLwFi3ocJKp9xAtZcFiSjZh58C48xjmFoKnlE31mNIWzdDhxh5g9F+MIW/TpAEE6YN0MaOkYIUrRSgAV3gEWYejUdADg7Z0EKCiZCNIf2wHDyYKE88gguOUyb2MV+mUaMWqtt68sVyYX0iVSmu5GcbfQvpeTNT/NSWzoRL2XlE9mL5pfF557ZiiT1TmPyeNUTASVkyH/RVGuut/k10wAcX3kRn1fDSU9sjV3X3knTF66ewTj5WdiytHgAit/YUVAu0P1Fip0FCR658ItTIdc5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxgq25SFxzPjtGeh9YshdmgkMWnBQZl5uMgJsKmTlb0=;
 b=rKnf5gFl62DYawmDL5tkXORK6zqTj0UkmmTDa6idjzumfVsW002fp3OrQY32wlzdB5fm4ibybtDjBCU4srvjIVnJJEK795pAI3SUVnHwjsuvaIFpP63J6jdRUmOjUmAwCLNv53E6YaS8dchEgnCLxneryGiOzGzvWgofyEkGtzwtCHivw/Li6Xbq3fwuMBIULy2JJZZC5ucItVSE046V9RaIlby8z5VdrF6xiX1N7YBECDxb/CRM0wHJ9ycoVuo+qh/sHqUcp4/dplEOsli/RSyC9iWRZ8YVMzn3ZApCfe1LqUavYRWCLczPKVU6g+u1HVwn8/5sV2/XGuetEvuEQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxgq25SFxzPjtGeh9YshdmgkMWnBQZl5uMgJsKmTlb0=;
 b=BZW6JCpIao7D7Rph9kqV006nIlvTGwlE966kBoJhBBFTk+QmrNMgE0xNZVHzVCBAkFqYBqnLv7XDPQraWwybCqtHXuODyryqhLSfYXzG4+q10DptZtbI1Ou7N0oMd7ojpNfHQD2W0GfFBQyaKWPe95jL83J28irplAVesdK9Dv4=
Received: from DS7P220CA0067.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::27) by
 MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9913.11; Tue, 12 May 2026 22:32:22 +0000
Received: from DS1PEPF00017093.namprd03.prod.outlook.com
 (2603:10b6:8:224:cafe::b3) by DS7P220CA0067.outlook.office365.com
 (2603:10b6:8:224::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Tue,
 12 May 2026 22:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017093.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 22:32:21 +0000
Received: from MKMFKUEHLIN01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 17:32:21 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: <christian.koenig@amd.com>
Subject: [PATCH] drm/ttm: Support 52-bit PAs in ttm_place
Date: Tue, 12 May 2026 17:31:54 -0500
Message-ID: <20260512223154.18089-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017093:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 8658ad57-d7d1-4bfb-e5ea-08deb0765562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 5zupXIforYmBjVS6VVDmM/NrV66E3qJfWSSFaz7HN9Rp4yqXpne2R3YLXaCAc9ErKoeAf//3XW5xkETA4Kdp/iDax1xVMeShoPZSXUfwW0Rptdu5HzO+s0ksBk1auL2uxJgGcDJaIhj99DijErNnSRLm0Elbnew+khMzQf3UhWc9Tuz/WR+nsS/K9xSgmL0yshhdBPhlg6sVmpTUgYMtCvH0dlC2Sr6AXQh1ncv5bPbylyzzsyABDDZkhynVClRZM0FgmTLk+L6Z+v6ZG3233zY54IBD6giHkFue8lgZcFTM62E8RB4m8q2FXpZEFGgFxykn/rJbaJBrr7zV7ROOZ/82aLW+vJM9TXz6YjkNJybL3CO77SKR8H3w7YHw/911Ub6/mEtwoE669FB5nqiiuKZD4KFh/y0Kk5ibNDy7/ZiHc9I1Swwtc0ATBb9TpGAiul5xUHRzYNJQz3HIj+HKmcg/wBj8gNXYmc9d34eD5saHxDNrlL1BC8mAJwl2LvyL1wDd76BBo8xExLzXv1Guxqo42uWomZw+YJMNr9MPMHMlyMlxAlBZkDEV4oXASsH6u0EJkqt7BhW6RkJt9mrIt49lEkg6hG8UcSXzXMP2ZGci+pivTc5MRYWehwrVsKZ+4somMKWYBUuMBOLE2fBsu051CFou9TbEyurj2H27bWsb633k9LyVr0yEikaU7agObWmCqavsw6qmIkuhXPvTYg4fLUTxUGlQTVSd8rfCX7Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OESNfxm5ro8iHZa31h34K6e/wT77X5u8pLoVqcRIdd9MQFGMrFV2sHVPyw9Thc8UF6mLrQVHVO1YYw1zy9UtIWotNDpkdEFfgCjdSymYk4jQTAdREKtY2OycZOIsQLpQYkFKlI+z+k1bsdQONzFQkH5eff5rl6AGQNCe0Q9nHfg/ylaFFlPiNvQw+x1xaTHyU+IiJbVdn1T+wjcoIYyetwFUOsji0c5yLVhDGUhSxCMiopk2TN6DHOCLSm69YbCcSve4qj3u7GedBo/ffwN+dCrnFQpp76A8bkGjOPF3LQl1+CNRi7e4neZxDYPnHij4y3KYk8Dg1PznasAvgDQ+5VsMwDkcZaYPr/47dbziK4x4IzdfGrIGO3PnN4+Biax/NFU8xuD2sNASXXVlXQ631C0BmEadcwP8IuzWwY2gmrzZmGnMlrq8GFiwZeSIvie1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 22:32:21.7623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8658ad57-d7d1-4bfb-e5ea-08deb0765562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347
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

fpfn and lpfn in struct ttm_place are 32-bit page numbers. With 4KB page
size this can support up to 44-bit physical addressing. Grow these to
unsigned long to support larger physical addresses.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 include/drm/ttm/ttm_placement.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/drm/ttm/ttm_placement.h b/include/drm/ttm/ttm_placement.h
index b510a4812609..3e88869c0f58 100644
--- a/include/drm/ttm/ttm_placement.h
+++ b/include/drm/ttm/ttm_placement.h
@@ -81,8 +81,8 @@
  * Structure indicating a possible place to put an object.
  */
 struct ttm_place {
-	unsigned	fpfn;
-	unsigned	lpfn;
+	unsigned long	fpfn;
+	unsigned long	lpfn;
 	uint32_t	mem_type;
 	uint32_t	flags;
 };
-- 
2.43.0

