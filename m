Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FD9FF8869
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038F210E809;
	Mon, 27 Apr 2026 16:01:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="j1YVohhP";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="j1YVohhP";
	dkim-atps=neutral
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 630C110E802
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:56 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TUmpkXYqWstWFJ4kPM9RBfl4jJKpRwwcUrSae9es3HPCSJzSZg5pC76duKKHxk5J4r2E/HraNO5KU65Gp/AU7hkwEx10hD0ITnH3/Z4hO6FMpaboUJcDj6m9x0MZ2oEe9+0hOUpEopDk2nyCOgwAQjCL/9P/hUI7ww09QDbG7YwTKazEl9KE0fFUHDnSFr4LlcnuivZylNbDYV3+hEmY7HBGfqSQJabnGk4Lj3uODHPZsSPaKxBcHhKq38X3knD6Et3cGzcNNcXIMvYxuf3DZ8yOxWapuNIMRLonHjhBzbFps+GhMYIjiZm5/zOZfF7EfACoJixOzTmYw3Mz8lp0LA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yi+gw7wQwUTm9Ayl6tXoWn5xq1RtM7CLoA2p6p8rjsk=;
 b=szdJGHig3ZZsDPzr7hq66Uisf5sCOCUVaafqdWJOaxjKUVMATQoNWY/4IVWZ9o68F2Bo/mX6dErUSpjh4PygJX+CFzvDnAyNg8CMcMdGXmu8cuQBIJNY16j60jRIenRculSasWV4iM86PN90V+3m5zmqZkrSUFdJN6SwpFrms/oy0p9Xfr6hNKhy9h1n6WZTGkapIFvqc25POW+CGNzPV4GsbgM+z4HRzohA7wEG8AWgY2ZHBEKvmqg9leWQCEeDuU0F4TACAxXMzsqtB1JCM6+sgSnVgKzG1q20rIw+lsjQ51Zc7nZ3rP2BhTytTDKoVoumSTG2gNaYBO9NJ3wm7g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi+gw7wQwUTm9Ayl6tXoWn5xq1RtM7CLoA2p6p8rjsk=;
 b=j1YVohhPUrrOrvDfEGu+URZbfM1ZYDHjCgVGwGUFSdXV4WOd7QOcS5yu4C+788ijKEL3dNgDHZjD6ghphJ8x2alxgJBK7IcvVL+yKqrlCtg+XWXCACCsrdpS6Xlyq8pG2arbUDQ/x6FGqIZSsXzFVazLJX3KkxSZRkLhk/ZfJUg=
Received: from CWXP123CA0018.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:73::30)
 by PAWPR08MB8984.eurprd08.prod.outlook.com (2603:10a6:102:341::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:00:50 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:401:73:cafe::d6) by CWXP123CA0018.outlook.office365.com
 (2603:10a6:401:73::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 16:00:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d51n5RRaNomhFJ3mFa4FqfJjysQ+n3LiHOrCS4u42gi1DhasE/bM7rfZSZUwwYWsQc0hEJBglg//YHOhtdASDxVUSVWEtpHJTdnCw3HC7PY+IsCGupbnSddKpPeAz2/DdqxBgp53rbb+yLQ3anspZa61U26LIuQwTLNliI2Pim4fP4ViEM4KUjKwqB7L4x/4yhMvji7K8Y2uSQjOI6wP7RFtpHYq8qVn8PcD/9vnkFBUXWsFb+336q1ylf0uc8OxSPuWJDNIpCv7xAwP9WyHp0kOa8dbqt8TUMZYES7Y/WzoYxA6JTQBIJQ17xzfqd/J/JtQ5XmGRdra3MdtyGObwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yi+gw7wQwUTm9Ayl6tXoWn5xq1RtM7CLoA2p6p8rjsk=;
 b=cLlEe1UIl9eO7SMds/8hcI8l5pthcOBavv7rDEfMuM0CfIaMVLgiGorgAMiHuJOCcmLpGa0fEo6MahQNBiwJlqcGqZlXbtKTPjtgSeP3WIeRO8wmypYPbAyMcCKPmIVeTfqJKSsgQ1TumrNriBLbQk/ldOuMVTsnJ/oDfzQrnwhzq8lxDNOuYPks0eSp2gNPcEu8cvwx/QnE5qrsyrYtnKDGllaLnC820+uSqvzDYOPctct3BpVS+0VVkq9QpMATKNudXe1J4CjpMpChZPl3Jj7i8CC+gir/Hjf4jZY3p22qXKiSMStcHW6O0A1PTKIHVFRPTxyjn4rL5zzcRZwH2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi+gw7wQwUTm9Ayl6tXoWn5xq1RtM7CLoA2p6p8rjsk=;
 b=j1YVohhPUrrOrvDfEGu+URZbfM1ZYDHjCgVGwGUFSdXV4WOd7QOcS5yu4C+788ijKEL3dNgDHZjD6ghphJ8x2alxgJBK7IcvVL+yKqrlCtg+XWXCACCsrdpS6Xlyq8pG2arbUDQ/x6FGqIZSsXzFVazLJX3KkxSZRkLhk/ZfJUg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB7721.eurprd08.prod.outlook.com
 (2603:10a6:10:390::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:59:47 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:59:46 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] drm/panthor: Store IRQ register base iomem pointer in
 panthor_irq
Date: Mon, 27 Apr 2026 16:59:30 +0100
Message-ID: <20260427155934.416502-5-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155934.416502-1-karunika.choo@arm.com>
References: <20260427155934.416502-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0118.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::9) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB7721:EE_|DB5PEPF00014B98:EE_|PAWPR08MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: ab4cecb7-096f-4a8f-ad70-08dea47626ad
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: NvIAeBE7WKZ65cDOFyoYSpr4HOs9exGHYXn87HyTufMiKn88P88FcwIHMSC87BtAyr+Ui9CGGpW7t2sApK67CMqXXpgMbhPo8LnkF2zjSbO/9ZWFPQfcvRjkkSEn44KQR/DNIH9gGv9wIurL/dQk6PQU0KfwuvTZQrx6ol2c/dN1UBO+ls1tqgOyQEZyaJkk7s3IPQMGp2EfzAGoF1NSMUdmVx/qzbWpjuXdepmnWOqj/sGBvzoc7pcafNpnIaCFywlI4XR5fegNLzXZnPReoI+HzlGfFgeKOYQvgICzs8yoNH1dl6gICl1aC4Vx42EXqjDQApgXvrAW59M6dD5tNEmtMNUSAZHCeZRa6467OLI4L0blPXAw7rOwqDxxQzgv3r5IPa3QbCNeVy4KntQgdtcPnWjRAPRbrjGjoHD7SUPKYo/jLBbMwRnzqtB9qJjprk2m9AwBk7ZuwhPTyqeuzG9JV3s1WPcQWkjuGQQtJgEnEGDpvH+UoU4qqUKRvUf+xRNSYMcG/gDv0Jf6YarJwDn/F9pEv3oFJrXtBiMu6i0ZQeiFxzmCNoMHgGJvNSM3FNLPbPXPg/03RxP+9wFrEDXaysfG49M//XEIas1ccX/JKsK17yoLbfD1pcXlJN3dx+VFClCQmRgCJ1TZ8cC9rnP6Q2m4fkrt60KcMWKbJqu+u/+OYPdn8+yJCYLq+efZKvpxOd4qUfDkt2NaTVNS/42HQcSZgTEIptaFdYlkL8E=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: W91n8+0gHnVzbd703k19PmmaSKUi3Uw6nIDXRJgYgugS7vvfz5ShHjPTtQzyJ6D3wV6SA6jUr2DnMtA1TBYWor6OJFuRzGynyzHErwyIJuSfuibMhTh3AZUf9mF8FxZQV9322J0aRWPogPtvU87phWKx3F0/E9UoFQn1AQGkmlGRGvwm5lD2YApB7FfymWoZ/WYmIIJJAKyU7HzSthaRUVBpZh6IpwMijeJFhFBMW0Ay7UNbb+YjdG0c3us3t0FaY1wOCqcJeOiwAqdJHBFTtAzTrXmC2oZ+VDFQmZeCXjR4PM8rSEmkVQrHXU9OZFOeUq8GS5/1ul7Kx2NMaF2EZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7721
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0f84b4f6-c117-4e35-8249-08dea4760137
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|35042699022|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +qSJPYmQMaTLoVr0orAJn1i6izuSVMcy4yR8bWAct6PwtfWS30tSt8OvDJgvCG4ASv0xR3N38QMvxFHksYS/efwQrAnxJEinZBKFcTDm0b3YG19OEI8cYrPdjXK0e0uTZfbzCWolz93vU6gM0AU07C3C5qmdkQATzSPW44uQBUTOFZ9YDGT0v1B5A3iw1qt6jns6Vis+3HYBc//Ye2BjSoJQN/uqRsf7yyYoPObVyJufR5nHTVjoRyRCTXmtLqgVarqusqsmEbNd0bCDvliK9FFimvuxSLPA+/AedrXLuuQz9lKXdptA9ukrLmPXwIeme/0xXcgyhp11oOZSmNbh0jt7kDkQX3z1znV1kEkxtQ8ws0tGjl9r4sZsYZbsoBooMoEqwygUtONvinx0RPyxMfuY81w9MJv8OmrqFjdmQwW0qY+TV6142xK7W/M8s+asA1nVUC4zi4URAhYw/mLamQBkWExZNRCSGGLPS1DuObZp/2sx0/I3TyFSBbyIeoE2TL+N7Pu5qoY9dtZAEbXjfjChT5d4W5KJOvyLi8ShQH+J5AssBdaQIW+uMULLxfPmTLpQMergNTSea7dWQVid6EIAOq1XFSfYdVnjgA8GSIlkmohgxZI/qJyczfem2op9N93QiuuAhAM2JmJp1idbsv7lqXxxUJXXqnN7Y3EHpSvUlZb24PLbDqdYuRUq2cR05tf2UPItSQ4gjwo7blbBhzocLSGwDJAN6j3WAGMDTSeXruNaHP9/ifiwwbxm87crGukgBd8oEtQaCxXUJGf8UQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(35042699022)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GtOq1bSRa106EjjfYS4E36rAoOszBxz2zV9zvygn0DQ9EBzmbtbRE3ajsqjrYCH9FW9AsjetK9f8ZrUmd3XIOS1Rr8HyTzTyRfJJsoIRMFeFVbC1RkFS6YqO67AJ4u3WKJWMzrptJbqcTVj9lC/uafCRnCB69++E56M0wCYHhxifof1EfgPpwueLwRTPJXCBfNl2Nm5jy1kZ64ZrdRXnaGDuyQMZRjxxY9U9SULMtPL4S5E6YjJmxsb2ZyLx4pA4rx6lCaRLmWbaSyNPsAefylW//WCxEWWL4duDDkgj8a9un76pmrdRvK0QjrZnDYMyrR8BN7QBy9tJYJ/0O4MsjzK+MDz2uWjAa5tnduyM/wuO1qJkGs7O8E7AOtygSXs7zmQejG3jUCogiFu9j+TwHzWQSqfhY0Pvm5S0jfiWoDxoE802R4jopfReCgREtFaQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:49.4078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4cecb7-096f-4a8f-ad70-08dea47626ad
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8984
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

Update common IRQ handling code to work from an IRQ-local iomem base
instead of referencing block-specific interrupt register offsets.

Store the interrupt base address iomem pointer in struct panthor_irq and
switch the shared IRQ helpers to use generic INT_* offsets from that
local base. This removes the need for each caller to expose absolute IRQ
register addresses while keeping the common IRQ flow unchanged.

No functional change intended.

v3:
- Clean up definition of pwr->irq.iomem.
v2:
- Change IRQ request function to accept an iomem pointer instead of
  computing it from an offset argument.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.h   | 32 ++++++++++++++--------
 drivers/gpu/drm/panthor/panthor_fw.c       |  5 ++--
 drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 ++
 drivers/gpu/drm/panthor/panthor_gpu.c      |  6 ++--
 drivers/gpu/drm/panthor/panthor_gpu_regs.h |  3 ++
 drivers/gpu/drm/panthor/panthor_mmu.c      |  5 ++--
 drivers/gpu/drm/panthor/panthor_mmu_regs.h |  3 ++
 drivers/gpu/drm/panthor/panthor_pwr.c      |  6 ++--
 8 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 285bf7e4439e..4e4607bca7cc 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -82,6 +82,9 @@ struct panthor_irq {
 	/** @ptdev: Panthor device */
 	struct panthor_device *ptdev;
 
+	/** @iomem: CPU mapping of IRQ base address */
+	void __iomem *iomem;
+
 	/** @irq: IRQ number. */
 	int irq;
 
@@ -488,6 +491,11 @@ panthor_exception_is_fault(u32 exception_code)
 const char *panthor_exception_name(struct panthor_device *ptdev,
 				   u32 exception_code);
 
+#define INT_RAWSTAT 0x0
+#define INT_CLEAR   0x4
+#define INT_MASK    0x8
+#define INT_STAT    0xc
+
 /**
  * PANTHOR_IRQ_HANDLER() - Define interrupt handlers and the interrupt
  * registration function.
@@ -498,14 +506,13 @@ const char *panthor_exception_name(struct panthor_device *ptdev,
  *
  * void (*handler)(struct panthor_device *, u32 status);
  */
-#define PANTHOR_IRQ_HANDLER(__name, __reg_prefix, __handler)					\
+#define PANTHOR_IRQ_HANDLER(__name, __handler)							\
 static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)			\
 {												\
 	struct panthor_irq *pirq = data;							\
-	struct panthor_device *ptdev = pirq->ptdev;						\
 	enum panthor_irq_state old_state;							\
 												\
-	if (!gpu_read(ptdev->iomem, __reg_prefix ## _INT_STAT))					\
+	if (!gpu_read(pirq->iomem, INT_STAT))							\
 		return IRQ_NONE;								\
 												\
 	guard(spinlock_irqsave)(&pirq->mask_lock);						\
@@ -515,7 +522,7 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
 	if (old_state != PANTHOR_IRQ_STATE_ACTIVE)						\
 		return IRQ_NONE;								\
 												\
-	gpu_write(ptdev->iomem, __reg_prefix ## _INT_MASK, 0);					\
+	gpu_write(pirq->iomem, INT_MASK, 0);							\
 	return IRQ_WAKE_THREAD;									\
 }												\
 												\
@@ -534,7 +541,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 		 * right before the HW event kicks in. TLDR; it's all expected races we're	\
 		 * covered for.									\
 		 */										\
-		u32 status = gpu_read(ptdev->iomem, __reg_prefix ## _INT_RAWSTAT) & pirq->mask;	\
+		u32 status = gpu_read(pirq->iomem, INT_RAWSTAT) & pirq->mask;			\
 												\
 		if (!status)									\
 			break;									\
@@ -550,7 +557,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 					   PANTHOR_IRQ_STATE_PROCESSING,			\
 					   PANTHOR_IRQ_STATE_ACTIVE);				\
 		if (old_state == PANTHOR_IRQ_STATE_PROCESSING)					\
-			gpu_write(ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
+			gpu_write(pirq->iomem, INT_MASK, pirq->mask);				\
 	}											\
 												\
 	return ret;										\
@@ -560,7 +567,7 @@ static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)
 {												\
 	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
 		atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDING);				\
-		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, 0);			\
+		gpu_write(pirq->iomem, INT_MASK, 0);						\
 	}											\
 	synchronize_irq(pirq->irq);								\
 	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);					\
@@ -571,17 +578,18 @@ static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)
 	guard(spinlock_irqsave)(&pirq->mask_lock);						\
 												\
 	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_ACTIVE);					\
-	gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_CLEAR, pirq->mask);			\
-	gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);			\
+	gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);						\
+	gpu_write(pirq->iomem, INT_MASK, pirq->mask);						\
 }												\
 												\
 static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
 					      struct panthor_irq *pirq,				\
-					      int irq, u32 mask)				\
+					      int irq, u32 mask, void __iomem *iomem)		\
 {												\
 	pirq->ptdev = ptdev;									\
 	pirq->irq = irq;									\
 	pirq->mask = mask;									\
+	pirq->iomem = iomem;									\
 	spin_lock_init(&pirq->mask_lock);							\
 	panthor_ ## __name ## _irq_resume(pirq);						\
 												\
@@ -603,7 +611,7 @@ static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *
 	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
 	 */											\
 	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
-		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
+		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
 }												\
 												\
 static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq *pirq, u32 mask)\
@@ -617,7 +625,7 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
 	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
 	 */											\
 	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
-		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
+		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
 }
 
 extern struct workqueue_struct *panthor_cleanup_wq;
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4a0c23e987b6..73ef07a37e22 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1088,7 +1088,7 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
 		trace_gpu_job_irq(ptdev->base.dev, status, duration);
 	}
 }
-PANTHOR_IRQ_HANDLER(job, JOB, panthor_job_irq_handler);
+PANTHOR_IRQ_HANDLER(job, panthor_job_irq_handler);
 
 static int panthor_fw_start(struct panthor_device *ptdev)
 {
@@ -1470,7 +1470,8 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	if (irq <= 0)
 		return -ENODEV;
 
-	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0);
+	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0,
+				      ptdev->iomem + JOB_INT_BASE);
 	if (ret) {
 		drm_err(&ptdev->base, "failed to request job irq");
 		return ret;
diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
index d523d41e18dd..eeb41aff249b 100644
--- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
@@ -15,6 +15,8 @@
 #define   MCU_STATUS_HALT				2
 #define   MCU_STATUS_FATAL				3
 
+#define JOB_INT_BASE					0x1000
+
 #define JOB_INT_RAWSTAT					0x1000
 #define JOB_INT_CLEAR					0x1004
 #define JOB_INT_MASK					0x1008
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 747ac332be64..f00f3d9be240 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -110,7 +110,7 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 	}
 	spin_unlock(&ptdev->gpu->reqs_lock);
 }
-PANTHOR_IRQ_HANDLER(gpu, GPU, panthor_gpu_irq_handler);
+PANTHOR_IRQ_HANDLER(gpu, panthor_gpu_irq_handler);
 
 /**
  * panthor_gpu_unplug() - Called when the GPU is unplugged.
@@ -162,7 +162,9 @@ int panthor_gpu_init(struct panthor_device *ptdev)
 	if (irq < 0)
 		return irq;
 
-	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq, GPU_INTERRUPTS_MASK);
+	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
+				      GPU_INTERRUPTS_MASK,
+				      ptdev->iomem + GPU_INT_BASE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
index 75474b7d7341..3f60c45985a7 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
@@ -4,6 +4,8 @@
 #ifndef __PANTHOR_GPU_REGS_H__
 #define __PANTHOR_GPU_REGS_H__
 
+#define GPU_CONTROL_BASE				0x0
+
 #define GPU_ID						0x0
 #define   GPU_ARCH_MAJOR(x)				((x) >> 28)
 #define   GPU_ARCH_MINOR(x)				(((x) & GENMASK(27, 24)) >> 24)
@@ -28,6 +30,7 @@
 #define GPU_AS_PRESENT					0x18
 #define GPU_CSF_ID					0x1C
 
+#define GPU_INT_BASE					0x20
 #define GPU_INT_RAWSTAT					0x20
 #define GPU_INT_CLEAR					0x24
 #define GPU_INT_MASK					0x28
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 853f5ebfe5c6..64d53e7cb763 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -584,7 +584,7 @@ static u32 panthor_mmu_as_fault_mask(struct panthor_device *ptdev, u32 as)
 
 /* Forward declaration to call helpers within as_enable/disable */
 static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status);
-PANTHOR_IRQ_HANDLER(mmu, MMU, panthor_mmu_irq_handler);
+PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
 
 static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 				 u64 transtab, u64 transcfg, u64 memattr)
@@ -3247,7 +3247,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 		return -ENODEV;
 
 	ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
-				      panthor_mmu_fault_mask(ptdev, ~0));
+				      panthor_mmu_fault_mask(ptdev, ~0),
+				      ptdev->iomem + MMU_INT_BASE);
 	if (ret)
 		return ret;
 
diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
index cc9cf603cec6..de460042651d 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
@@ -5,6 +5,9 @@
 #define __PANTHOR_MMU_REGS_H__
 
 /* MMU regs */
+
+#define MMU_INT_BASE					0x2000
+
 #define MMU_INT_RAWSTAT					0x2000
 #define MMU_INT_CLEAR					0x2004
 #define MMU_INT_MASK					0x2008
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index aafb0c5c7d23..705d998447b5 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -70,7 +70,7 @@ static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
 	}
 	spin_unlock(&ptdev->pwr->reqs_lock);
 }
-PANTHOR_IRQ_HANDLER(pwr, PWR, panthor_pwr_irq_handler);
+PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
 
 static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
 {
@@ -464,7 +464,9 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 	if (irq < 0)
 		return irq;
 
-	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK);
+	err = panthor_request_pwr_irq(
+		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
+		ptdev->iomem + PWR_CONTROL_BASE);
 	if (err)
 		return err;
 
-- 
2.43.0

