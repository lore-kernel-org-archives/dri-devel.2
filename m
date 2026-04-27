Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FECEFF886A
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE9D910E806;
	Mon, 27 Apr 2026 16:01:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="A2Cg7GPI";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="A2Cg7GPI";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013043.outbound.protection.outlook.com
 [40.107.162.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1800A10E802
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:58 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Z/vr7VCv9ZA2RaOr7dt3jCz5Pj1NzSphb8ji+aPGC3Wa8QBIktWglRL2Jh3mStvn+YNXSeEFUILI+vjFi2QSBydkzk+L7v7J0tgm+e00SpBjZIKngWsUmX5fLCHGwTJkXdV56k5cRopTm/uU0sAK7z2CogviRE+FNhaV7Y71e04bD4fXQVr25h3yeDDa1PeD8angKTwC/1tw41LUSS8N0ejft1H4JIX24WRPmzG+cTO0NMOISyNovrSKIL+UUEHZDmLXBIRKaXlNPMF9xd+4ju/zOFghFSCGg9nd8nPmcoc4ZLMx4mBUoxk0fnSNBP9ooGrTGk20tJvrKuvSQauWng==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQsmu4CnKPWr8IIdB+PrFs4hl9U2xLy2EYXQU10F8YY=;
 b=njB/Y0iFdeJmArZqT/pw6+N0CdjIH8N2OhzD2C9rrLb/fLs+M6z+s/nb4bs2xcL+UwRqPDNnJbntqZ9oIhNMGhGX3nr5IE/WrzoI1agaSbLeH6+vN9kgO0NHpXaqtgwCqbmvpe3bgU5ZRPfSLby1IGsXjg2zJVXz2bDlO1k9NyRMbi6NMFpByelY4CniadS5HnD2Xpdy1oxFo5ksmXUd+tZuAAAjpnuAdBUtDeem0qifNb5zO20EOOX7UJW/5BaL1wg+USOu8QZHqRye342obCLV85oAze9+iD6owp6oA9B6NAvrm2lrmt5AZpyPn2RfF1V9s/0xG1XuqfbRdHORZA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQsmu4CnKPWr8IIdB+PrFs4hl9U2xLy2EYXQU10F8YY=;
 b=A2Cg7GPIhXpJn4Lpt0E0b2WUg91jNvxl1MIw+GH2a4wBG0GY4tj+13pO/B9NCg+inDsSTYjZwVlV+WIwLVlGB/cjw8o/dUQXLIk1A5jRGJj0kWrpJOiRH8SCe/IEPCIzCa8IDJ5qDQ9XhfO2Iwy4NrgfKKInYt49Jovij+cA3nY=
Received: from AS4P190CA0056.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:656::27)
 by DB5PR08MB10161.eurprd08.prod.outlook.com (2603:10a6:10:4a5::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:00:51 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:656:cafe::ed) by AS4P190CA0056.outlook.office365.com
 (2603:10a6:20b:656::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 16:00:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGodOoypbfQJJkhQoyptmvlTaKGcFPZkz9eQNMNLTViMlRuoX9pHFJ19E2zb2otrhkKFkzp2veMFoorwW5OZiFTYFYTdpVf+trZZq9WhYxNBfuKkgQxWzHyrlSwhZDcl8NzKq34ovyZC6k2yLp6VNBX/KuxqqDvU4yx/ONyPf85liRPBh+gzA70JVLQ2tbW91Qmp+ZM8Spk3aKVTiY1Q/P+Bo4pdu7Qtw4cv4z699/AQ1gpKHet2lv9DfvvnLQ+l1XmbK4X7CnJQ3XZ9tDKhf+biw1BS5VL/VMpeyxFNbkksfET9BowiVokIpniDRkh7did+JReT+MryAV9EVsHQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQsmu4CnKPWr8IIdB+PrFs4hl9U2xLy2EYXQU10F8YY=;
 b=dzeND5/PL6DqSfurrMNiToI5edjzRlu+sInpBZaaxNDCC+fmCWJ3sHevrspXfQ4r+lMUpGXoZJOtEBZf/3sucDJXWMVYlmCKSZ5vJ3WYDxOblteeWLHVRfNNhLmEe0LKqCVVBUTMDYur5s5etPAO8CezkBw7eiXcdT4pjbQ3Pqsg/tBSLRwAEBF7BtzGcwy/O9fpCVJol6a+BxIEXIU8kIruqqfOFIpHHsGgdVx+meeq7A4BQktBzJ31/tC+NSjxHncBTtu0YhRKwtgq9xW3oRCl8OjiNYVEiWXTMCYpTQHyqE63yMBLi+vbmUu3pW6V9YuwWeNeRiQdbGe1Os3xug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQsmu4CnKPWr8IIdB+PrFs4hl9U2xLy2EYXQU10F8YY=;
 b=A2Cg7GPIhXpJn4Lpt0E0b2WUg91jNvxl1MIw+GH2a4wBG0GY4tj+13pO/B9NCg+inDsSTYjZwVlV+WIwLVlGB/cjw8o/dUQXLIk1A5jRGJj0kWrpJOiRH8SCe/IEPCIzCa8IDJ5qDQ9XhfO2Iwy4NrgfKKInYt49Jovij+cA3nY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB7721.eurprd08.prod.outlook.com
 (2603:10a6:10:390::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:59:48 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:59:48 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] drm/panthor: Use a local iomem base for GPU registers
Date: Mon, 27 Apr 2026 16:59:31 +0100
Message-ID: <20260427155934.416502-6-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155934.416502-1-karunika.choo@arm.com>
References: <20260427155934.416502-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0265.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::18) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB7721:EE_|AM1PEPF000252DA:EE_|DB5PR08MB10161:EE_
X-MS-Office365-Filtering-Correlation-Id: a66dd621-c1ed-4cd8-2aeb-08dea4762788
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: Lk/YQfg0Dzqa7RySZJD2DPJ/9GhohPILck4LHOBlavqlqOuf6aIvfWhmNBWkFIMwXp39RZ7DxbhBCUdyDT9yvGpZYcjbS7VV8I/tS3mbDrM31OzIaBQM1BPxd9FNWfx+ozmeFZPB5SSlrus3zLaT74Tt28vtLm4kJTiI9WfkJXxPVBR0hzD2HVjm+5l/BlE1VciyWUt8F6nDttv8IrJi6lz/S2CnVjE2LFu14VFYWug6TRSb2ggLC1ywSx1vz9Wor4OJObEOzcmSFP/x7LML42kn8uf6G9XHe7lvxQHIEZNwK0x1pPCpjWA/EnZZxitZPFO0iA0Z6wKayfksYohihfLtKvGDArl3bl5jFROu+e6kIbKmUXfwhSIFYFMGncASTB3oiceM1IAuwM4e0leHJkelMaj3jzrMb9N6ciGRT5oUnfqL9voVG5rbmH51ZdTVrn79ryE8ByhLTB48vvRS/9hhaUFVk9aiE5ohvlVCzyvgZV3TKw6/gksThbOq1tkqLZ0Nrm3uolXe3kVjBza5VDkQ1SC4exzmTGruDtAIKGC+X2UA1gBAqh9zYA316pXKm5WwBKRzIOdwG2IAv8vrAmT+z7iQi+4kG1UAVQudn1J7Jk4+FzOx4ZD09CwR67uCXhP6y93GdMz0G2Pb6toronsDZw8kWiqo5FlZaWzAehzEOkf1GrLJIT6gwCzPFKNryJlK6w4Vcj3nJ5MtxZiJGlCCWRz6NUh4Xl6J1fgh6Zk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: BWfps9wFZRvYxqCNWPJ9iU7m+Fr9CLhk4F78Ydty2G453juMkgARxvx6QWlRIKMkzpvIWM3JqeMEikA5S4iyUV9WjhIQkzTMWlqELjygNdDFrpPt7p4M/olA/HMojEqoydVY3S+hEqmsgW96lbhAgpybxjUo2DPD0fIcQcYy76nLi8XV+L8l8N4J5pMvFUijRSbUvE66wOvwMhKhWDmRqLUPcVKSkzOPLL7NZ0WYNt/ykTMecjzarvxoOtvJrvGQ2ILJjVSw0VGrYlAe+VsJqyFvry1XLL3QR/yutzjkwAYKvgqienUMcdSHZ2Mh1lY4KLvw3JzhsVdvbCZCao6D8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7721
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bf306660-0aed-418e-9e6b-08dea4760211
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|36860700016|14060799003|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: UR+4v+Mbeh/W9AgCit1Y6NJm6uNhMelsHR3JbVhcWOSygPltUzgh4UpnLUw0EqC7Fuw80quX8CTCWpe5FQe9MQ1yyOQ7kLvaNf88RHaaQ2eqcc2LQq5VUhT97hn6APPAwOvI07BVuMxH2TYa6ISch9UWmMClmKmQWXnVIvWnIQ4mcJQs31s4ps022vbY3BcKTM/XrkGsDeX1Tafz+5/2aJ2kQL6HfvSLImlYPFTLcD+BPrnQih+iNM+UdwdMZl6k9EcUISSzaj3wTTa4b4dCB5StANQnr0lFvBm2o2D8/8KAAjE1Vezsm2myELIDmx8JQPltH+4UUBQQkRmUrY30l22A0Z7AcHJ5VpWV7qkY7BvnnRFHEwRhUnIft9j8ZX2uFRUeiqo3QZmlrWSrNDwmozkq5I6BTQaPkr7sC+5DUUZhE97G4hPlHerI8kEs3FeIL30YxdTy98WFysx1NBueQjgqed0IU+rMOcOtf68Tt/0iXbGSLkZjmiLiFSxLaQerSK/cMgrb/rQgT5Q0KPJZJ4EA6HB33vxAcGYvLZ7njdN5LJ9f9oXP45X6PATIQ4kiKBA7wZEboUr/qdrHTGM22mNawc8PrphbrQda9iPwpsYmyT8Jytdwly2G/Qz1tI8nnbrXacZjZG7tQBvQjEo7mH2PkAZs66QmYTnXlLsqEKP1S+fLEocHfZxluWi+ib+rgr8O7XKBLSgXnj9kHISySy3NqNZ/sk+vFMlTRcjr7/CEE9B5AFOU6oB3kn+YHUz2
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(36860700016)(14060799003)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 687pguNYoXpKPK4Ojqt9Sx5/j5ji5NWC87LFs6tcdIpq/g+f2/ODmlR6DBQui6exh0qaBuG0It4yNyNbmnPxhzE8Zp2HnNjt/USN5lfPoh02SzgXYp0hbfJ3px/wAKc1l0Zyfx0UwCBeF5vpteveXoCaEg9/e+ACOSrHT04Hf3e0VgZ4HIrTUsvHk0CHyCGK/+FBvtsh4Qp5F4ytnPHePR3Q4AcTgtLPxxr1ngQ9PN2X5shXrcQCk1pJTWbE83GK03THsPP8UqZ4vDbc8xKkS01DZ1jv4lK3LBa+ftCIQwQUR8/FuC+uerdxdKuq8/Xp/+ekLScdgTrCK9rH8Nys26m889IumD/UMfxUJfDGb6RlepJVkhknUniXSrNpAB/ReIzAF3Pv4tUjFq6HFH+qr/2nj7LHe6bVtZNe696cylVuRxX0CMUN2wBoykEAHxSW
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:50.8591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a66dd621-c1ed-4cd8-2aeb-08dea4762788
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10161
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

Add a GPU_CONTROL-local iomem pointer to struct panthor_gpu and use it
for GPU register accesses.

This limits GPU register accesses to the GPU block instead of using the
device-wide MMIO mapping directly. Interrupt register accesses continue
to use the IRQ-local base provided by the common IRQ helpers. Update
panthor_gpu_info_init() to also use a local iomem offset for GPU
features and capability.

This is a refactoring only and does not change behaviour.

v3:
- Pick up R-bs from Liviu and Steve
v2:
- Update panthor_gpu_info_init() to use block-local iomem pointer.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_gpu.c      | 61 +++++++++++++---------
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  4 --
 drivers/gpu/drm/panthor/panthor_hw.c       | 38 +++++++-------
 3 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index f00f3d9be240..e52c5675981f 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -29,6 +29,9 @@
  * struct panthor_gpu - GPU block management data.
  */
 struct panthor_gpu {
+	/** @iomem: CPU mapping of GPU_CONTROL iomem region */
+	void __iomem *iomem;
+
 	/** @irq: GPU irq. */
 	struct panthor_irq irq;
 
@@ -56,12 +59,13 @@ struct panthor_gpu {
 
 static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
 {
-	gpu_write(ptdev->iomem, GPU_COHERENCY_PROTOCOL,
+	gpu_write(ptdev->gpu->iomem, GPU_COHERENCY_PROTOCOL,
 		  ptdev->gpu_info.selected_coherency);
 }
 
 static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 {
+	struct panthor_gpu *gpu = ptdev->gpu;
 	const struct panthor_soc_data *data = ptdev->soc_data;
 	u32 l2_config;
 	u32 i;
@@ -75,26 +79,28 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(data->asn_hash); i++)
-		gpu_write(ptdev->iomem, GPU_ASN_HASH(i), data->asn_hash[i]);
+		gpu_write(gpu->iomem, GPU_ASN_HASH(i), data->asn_hash[i]);
 
-	l2_config = gpu_read(ptdev->iomem, GPU_L2_CONFIG);
+	l2_config = gpu_read(gpu->iomem, GPU_L2_CONFIG);
 	l2_config |= GPU_L2_CONFIG_ASN_HASH_ENABLE;
-	gpu_write(ptdev->iomem, GPU_L2_CONFIG, l2_config);
+	gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
 }
 
 static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 {
-	gpu_write(ptdev->iomem, GPU_INT_CLEAR, status);
+	struct panthor_gpu *gpu = ptdev->gpu;
+
+	gpu_write(gpu->irq.iomem, INT_CLEAR, status);
 
 	if (tracepoint_enabled(gpu_power_status) && (status & GPU_POWER_INTERRUPTS_MASK))
 		trace_gpu_power_status(ptdev->base.dev,
-				       gpu_read64(ptdev->iomem, SHADER_READY),
-				       gpu_read64(ptdev->iomem, TILER_READY),
-				       gpu_read64(ptdev->iomem, L2_READY));
+				       gpu_read64(gpu->iomem, SHADER_READY),
+				       gpu_read64(gpu->iomem, TILER_READY),
+				       gpu_read64(gpu->iomem, L2_READY));
 
 	if (status & GPU_IRQ_FAULT) {
-		u32 fault_status = gpu_read(ptdev->iomem, GPU_FAULT_STATUS);
-		u64 address = gpu_read64(ptdev->iomem, GPU_FAULT_ADDR);
+		u32 fault_status = gpu_read(gpu->iomem, GPU_FAULT_STATUS);
+		u64 address = gpu_read64(gpu->iomem, GPU_FAULT_ADDR);
 
 		drm_warn(&ptdev->base, "GPU Fault 0x%08x (%s) at 0x%016llx\n",
 			 fault_status, panthor_exception_name(ptdev, fault_status & 0xFF),
@@ -147,6 +153,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	if (!gpu)
 		return -ENOMEM;
 
+	gpu->iomem = ptdev->iomem + GPU_CONTROL_BASE;
 	spin_lock_init(&gpu->reqs_lock);
 	init_waitqueue_head(&gpu->reqs_acked);
 	mutex_init(&gpu->cache_flush_lock);
@@ -203,10 +210,11 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
 				u32 pwroff_reg, u32 pwrtrans_reg,
 				u64 mask, u32 timeout_us)
 {
+	struct panthor_gpu *gpu = ptdev->gpu;
 	u32 val;
 	int ret;
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
 					      !(mask & val), 100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
@@ -215,9 +223,9 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
 		return ret;
 	}
 
-	gpu_write64(ptdev->iomem, pwroff_reg, mask);
+	gpu_write64(gpu->iomem, pwroff_reg, mask);
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
 					      !(mask & val), 100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
@@ -246,10 +254,11 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
 			       u32 pwron_reg, u32 pwrtrans_reg,
 			       u32 rdy_reg, u64 mask, u32 timeout_us)
 {
+	struct panthor_gpu *gpu = ptdev->gpu;
 	u32 val;
 	int ret;
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, pwrtrans_reg, val,
 					      !(mask & val), 100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
@@ -258,9 +267,9 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
 		return ret;
 	}
 
-	gpu_write64(ptdev->iomem, pwron_reg, mask);
+	gpu_write64(gpu->iomem, pwron_reg, mask);
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, rdy_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(gpu->iomem, rdy_reg, val,
 					      (mask & val) == val,
 					      100, timeout_us);
 	if (ret) {
@@ -319,6 +328,7 @@ int panthor_gpu_l2_power_on(struct panthor_device *ptdev)
 int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 			     u32 l2, u32 lsc, u32 other)
 {
+	struct panthor_gpu *gpu = ptdev->gpu;
 	unsigned long flags;
 	int ret = 0;
 
@@ -328,7 +338,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
-		gpu_write(ptdev->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
+		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
 	} else {
 		ret = -EIO;
 	}
@@ -342,7 +352,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 				msecs_to_jiffies(100))) {
 		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
-		    !(gpu_read(ptdev->iomem, GPU_INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
+		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
 			ret = -ETIMEDOUT;
 		else
 			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
@@ -365,6 +375,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
  */
 int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 {
+	struct panthor_gpu *gpu = ptdev->gpu;
 	bool timedout = false;
 	unsigned long flags;
 
@@ -372,8 +383,8 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 	if (!drm_WARN_ON(&ptdev->base,
 			 ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
-		gpu_write(ptdev->iomem, GPU_INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
-		gpu_write(ptdev->iomem, GPU_CMD, GPU_SOFT_RESET);
+		gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
+		gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
 	}
 	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
 
@@ -382,7 +393,7 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 				msecs_to_jiffies(100))) {
 		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
-		    !(gpu_read(ptdev->iomem, GPU_INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
+		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
 			timedout = true;
 		else
 			ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
@@ -431,17 +442,17 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
 
 u64 panthor_gpu_get_timestamp(struct panthor_device *ptdev)
 {
-	return gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
+	return gpu_read64_counter(ptdev->gpu->iomem, GPU_TIMESTAMP);
 }
 
 u64 panthor_gpu_get_timestamp_offset(struct panthor_device *ptdev)
 {
-	return gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
+	return gpu_read64(ptdev->gpu->iomem, GPU_TIMESTAMP_OFFSET);
 }
 
 u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev)
 {
-	return gpu_read64_counter(ptdev->iomem, GPU_CYCLE_COUNT);
+	return gpu_read64_counter(ptdev->gpu->iomem, GPU_CYCLE_COUNT);
 }
 
 int panthor_gpu_coherency_init(struct panthor_device *ptdev)
@@ -460,7 +471,7 @@ int panthor_gpu_coherency_init(struct panthor_device *ptdev)
 	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
 	 * ACE protocol has never been supported for command stream frontend GPUs.
 	 */
-	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
+	if ((gpu_read(ptdev->gpu->iomem, GPU_COHERENCY_FEATURES) &
 		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
 		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
 		return 0;
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 3f60c45985a7..4c5b953796e4 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -31,10 +31,6 @@
 #define GPU_CSF_ID					0x1C
 
 #define GPU_INT_BASE					0x20
-#define GPU_INT_RAWSTAT					0x20
-#define GPU_INT_CLEAR					0x24
-#define GPU_INT_MASK					0x28
-#define GPU_INT_STAT					0x2c
 #define   GPU_IRQ_FAULT					BIT(0)
 #define   GPU_IRQ_PROTM_FAULT				BIT(1)
 #define   GPU_IRQ_RESET_COMPLETED			BIT(8)
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 9431f16d950f..80aa151d5936 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -195,28 +195,30 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
-	ptdev->gpu_info.csf_id = gpu_read(ptdev->iomem, GPU_CSF_ID);
-	ptdev->gpu_info.gpu_rev = gpu_read(ptdev->iomem, GPU_REVID);
-	ptdev->gpu_info.core_features = gpu_read(ptdev->iomem, GPU_CORE_FEATURES);
-	ptdev->gpu_info.l2_features = gpu_read(ptdev->iomem, GPU_L2_FEATURES);
-	ptdev->gpu_info.tiler_features = gpu_read(ptdev->iomem, GPU_TILER_FEATURES);
-	ptdev->gpu_info.mem_features = gpu_read(ptdev->iomem, GPU_MEM_FEATURES);
-	ptdev->gpu_info.mmu_features = gpu_read(ptdev->iomem, GPU_MMU_FEATURES);
-	ptdev->gpu_info.thread_features = gpu_read(ptdev->iomem, GPU_THREAD_FEATURES);
-	ptdev->gpu_info.max_threads = gpu_read(ptdev->iomem, GPU_THREAD_MAX_THREADS);
+	void __iomem *gpu_iomem = ptdev->iomem + GPU_CONTROL_BASE;
+
+	ptdev->gpu_info.csf_id = gpu_read(gpu_iomem, GPU_CSF_ID);
+	ptdev->gpu_info.gpu_rev = gpu_read(gpu_iomem, GPU_REVID);
+	ptdev->gpu_info.core_features = gpu_read(gpu_iomem, GPU_CORE_FEATURES);
+	ptdev->gpu_info.l2_features = gpu_read(gpu_iomem, GPU_L2_FEATURES);
+	ptdev->gpu_info.tiler_features = gpu_read(gpu_iomem, GPU_TILER_FEATURES);
+	ptdev->gpu_info.mem_features = gpu_read(gpu_iomem, GPU_MEM_FEATURES);
+	ptdev->gpu_info.mmu_features = gpu_read(gpu_iomem, GPU_MMU_FEATURES);
+	ptdev->gpu_info.thread_features = gpu_read(gpu_iomem, GPU_THREAD_FEATURES);
+	ptdev->gpu_info.max_threads = gpu_read(gpu_iomem, GPU_THREAD_MAX_THREADS);
 	ptdev->gpu_info.thread_max_workgroup_size =
-		gpu_read(ptdev->iomem, GPU_THREAD_MAX_WORKGROUP_SIZE);
+		gpu_read(gpu_iomem, GPU_THREAD_MAX_WORKGROUP_SIZE);
 	ptdev->gpu_info.thread_max_barrier_size =
-		gpu_read(ptdev->iomem, GPU_THREAD_MAX_BARRIER_SIZE);
-	ptdev->gpu_info.coherency_features = gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES);
+		gpu_read(gpu_iomem, GPU_THREAD_MAX_BARRIER_SIZE);
+	ptdev->gpu_info.coherency_features = gpu_read(gpu_iomem, GPU_COHERENCY_FEATURES);
 	for (i = 0; i < 4; i++)
 		ptdev->gpu_info.texture_features[i] =
-			gpu_read(ptdev->iomem, GPU_TEXTURE_FEATURES(i));
+			gpu_read(gpu_iomem, GPU_TEXTURE_FEATURES(i));
 
-	ptdev->gpu_info.as_present = gpu_read(ptdev->iomem, GPU_AS_PRESENT);
+	ptdev->gpu_info.as_present = gpu_read(gpu_iomem, GPU_AS_PRESENT);
 
 	/* Introduced in arch 11.x */
-	ptdev->gpu_info.gpu_features = gpu_read64(ptdev->iomem, GPU_FEATURES);
+	ptdev->gpu_info.gpu_features = gpu_read64(gpu_iomem, GPU_FEATURES);
 
 	if (panthor_hw_has_pwr_ctrl(ptdev)) {
 		/* Introduced in arch 14.x */
@@ -224,9 +226,9 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 		ptdev->gpu_info.tiler_present = gpu_read64(ptdev->iomem, PWR_TILER_PRESENT);
 		ptdev->gpu_info.shader_present = gpu_read64(ptdev->iomem, PWR_SHADER_PRESENT);
 	} else {
-		ptdev->gpu_info.shader_present = gpu_read64(ptdev->iomem, GPU_SHADER_PRESENT);
-		ptdev->gpu_info.tiler_present = gpu_read64(ptdev->iomem, GPU_TILER_PRESENT);
-		ptdev->gpu_info.l2_present = gpu_read64(ptdev->iomem, GPU_L2_PRESENT);
+		ptdev->gpu_info.shader_present = gpu_read64(gpu_iomem, GPU_SHADER_PRESENT);
+		ptdev->gpu_info.tiler_present = gpu_read64(gpu_iomem, GPU_TILER_PRESENT);
+		ptdev->gpu_info.l2_present = gpu_read64(gpu_iomem, GPU_L2_PRESENT);
 	}
 
 	return overload_shader_present(ptdev);
-- 
2.43.0

