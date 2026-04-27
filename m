Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9388BFF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BCB910E80E;
	Mon, 27 Apr 2026 16:01:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="E9vsgnaM";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="E9vsgnaM";
	dkim-atps=neutral
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013014.outbound.protection.outlook.com
 [40.107.162.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B284B10E803
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:53 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=EGHb4HkE/ndh97kuFc7Y/EPAIsf0G3GpxIriVhgDyRjQ5h2R4uTqLKOBBD+1lGMJINlZvNXX83z9QAj04pKvNK9m8tTdK89yL/xpdKuOjpEOe+hNP8ywL9uVgv2gzPS/7fUzOAtDTlMCAPe2ucBFTILL+zV/FzBZIwJJW6KmjsuhpHeBEP7CYN46iYgmPlgbsmljNXihcMd49oSLY/Y04HKumZPOcFsQKltSwQPiaLzVpIU6ZwJl/v8k4/EDBT+DDVyPLCnXsDxDTgXmVPkNOYjltPadV/lIhmdkjiAss3MmlD+B7kohzqOQsNiYI0G+jninu2vYYpH61CiO5JTBIA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgtMS3CdOXXldMWuw0z8yZnMApkZTWf2PTJmZUS915E=;
 b=SAPCe7o4eQ1CJPsuyJHcmLni+JoGKYj4kw5XUQRFHpOQIOkVW2cdW3QLdQk/9bRZc6v4l+N0kbrkAc86lV35dgqur9U2shcUM0dCB5bb871rSieM3SyxShgjgivMUVgssMW2iL3mD+T4tUXYeB1C6/oc5QcEOyxQkjHlOJoN9SPUdjLDWNhv0cdoDJ9jo/AldeM50QHQ9drxpGaPg5aixqfkPEiJz3ADktwykL8tFyT4XVRQmtThrmIQ6mCIPsAKOPrkUGNcZrdQ4pgydbCwO0gpFQLQHb38VtMnLnsKytfLn2OzZlwsGOz0QoydZ2t6YM7vYLSQO7GlnWuvaMmXzw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgtMS3CdOXXldMWuw0z8yZnMApkZTWf2PTJmZUS915E=;
 b=E9vsgnaMH3TPPJddL3RwZSt7nVOQCjL1YIe7ISq/G1jkOi/SfyAZq7FrBtDNGHWDc626Rl8wzdGxQm52DO/EA0Qr2zeuiX3KSZ/QSeXOZFy/Q7D5EtMQ+10V0Vn3fNd/DnUdCt4UIKWWns3GSpbVZxrRJFG5f5UxN5KKCvAwFNQ=
Received: from AM6P192CA0032.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::45)
 by AMVPR08MB11974.eurprd08.prod.outlook.com (2603:10a6:20b:775::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 16:00:48 +0000
Received: from AMS1EPF0000008D.eurprd05.prod.outlook.com
 (2603:10a6:209:83:cafe::c1) by AM6P192CA0032.outlook.office365.com
 (2603:10a6:209:83::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000008D.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Mon, 27 Apr 2026 16:00:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S96h5Q7VIgvwsyrxYTX0tHEekw4O4oQdNCI2YTlj1FxUgIQqGsXw5DbdM+H6tbE+jQXXFpRt8HR3tvgtWbdefDdkTcbjxHvfMVS0NdCwJNKg914avyGvLbn6vbpn7DeRzjebt6Z9U9U+8fM4NL8O6Vy0HPVRfW01gerh2R7rcPHN4EIiHQXJ53dU01rcFXVR4Dtq1CVmFnfxwzArdf12Y6R1Gvv9u+THdNOEO4mNHUusCHSNHnELUXF6cYXrzBo8jQScpXmyPb3fBvQNafjzStZf810VM9C45DFyx5DcpuCnt+frQx6QD5vmuTTMwtRKkvt4cbRWwr79k+Z/+paviQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QgtMS3CdOXXldMWuw0z8yZnMApkZTWf2PTJmZUS915E=;
 b=fIzoIqKX15zAXL1x+CiBcy3+q6Eqd8mtBqVfzkEN4dAq4Ckizjt5fhn42aQczEBjbIEWWDdCYksS2pyAIieCq9SEnS94D0NCqgTJ0eoRcoSRC25xd4cKw/RwPgoWbz6JGt3wydNNcjf79cMXwUDPmNM9t03mgvogpWcyhOs36gl0fTYpk0T+HlTZI+N7NnGvO5e+cyuGJ4aX16VHC1cDxnBtOKfeea8zRhCW/JClYU9zBTT4y2mlvKMOBlrZzYeocfz5Pq3okMf0tekyAI6Wm+rsywunP/STgPshkZAQrfI0VkcAheiFwl8NEskD0nxw/0CDAjmNMXFsCnHXOCm1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgtMS3CdOXXldMWuw0z8yZnMApkZTWf2PTJmZUS915E=;
 b=E9vsgnaMH3TPPJddL3RwZSt7nVOQCjL1YIe7ISq/G1jkOi/SfyAZq7FrBtDNGHWDc626Rl8wzdGxQm52DO/EA0Qr2zeuiX3KSZ/QSeXOZFy/Q7D5EtMQ+10V0Vn3fNd/DnUdCt4UIKWWns3GSpbVZxrRJFG5f5UxN5KKCvAwFNQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB7721.eurprd08.prod.outlook.com
 (2603:10a6:10:390::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 15:59:45 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 15:59:45 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] drm/panthor: Replace cross-component register accesses
 with helpers
Date: Mon, 27 Apr 2026 16:59:29 +0100
Message-ID: <20260427155934.416502-4-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155934.416502-1-karunika.choo@arm.com>
References: <20260427155934.416502-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0434.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::14) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB7721:EE_|AMS1EPF0000008D:EE_|AMVPR08MB11974:EE_
X-MS-Office365-Filtering-Correlation-Id: df4ebb7a-cb23-48f7-f445-08dea47625d0
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info-Original: vczewP0IwMyqTq/IlZvjAAGdUdhafgCNSYvgHXjJf0Nfskv0zlzX0Y8tbgV4ysmzgl4m6+Kna3OLeWzIKrRnbTSyFq/K4B4LLCmun3h7A1vKtDKHvnRFlwqhn+2KDHwztGhT4xXOe4MwKYgStArxODWHJDZhwPUkX6ZB6DcF+ulCaT5OeB6idJLXxQkG2eKVTskjY+hiFIzgG70CfEYr9EfDw8fg32spWSWYqaKGdnA4NUThA1JSaDNdan+CpQSnqZUpwYP9ZYrKcqPPrFuPSF+xwKtgfQvMDC4ZV5kqmGtwwuGhkpAuK4d12WBOfSzSeJZUxLC/0oT2aEyqVG4vS3fDFePLm319QMjGtZk87VL+MG8L6MDgcQyivildkEaNss4IdEbG3IXGniNg5TltlQuHAALWQcHnUlXKlYzU+Do1GpGeFcRZiZHDcX4/bq/fyo56KvZP/76yF4NhHYphQKWL0Un0y8/cxwWzFHxslOF7uWJPJ/2bqKxuznILSC8o1HeRa4JnYTovgAtbPdFWWUu5ipBYCUShr7YVb+M1es/XhcrHzqOG7ZCzRbuF7fzM36eRMjaIR8T+XW4y3cmzpQXFeLOGoC/nISa2Npwf/DHJInRb3zZEqi2ARBnisY94WtJV7KJygJq0E8PHOVVt0OFdHJ8Crf/DBxlR0UubSYAYeOsP5hFJVuvciOXFHOOE3dNDZZFE3WSgTbHk4Nw82zEY3kGpNf7Z6HHPwhrstHQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Y2Ofxh3FL64/AOE0byPw754jLsNnjpQ4jWbNmvw4g5JG5/l2Rh4sMAHfy6Aha0DlBEHRQo4BTP5F93Hh23DBY9XlTNx67Hk6DZJhsZAoOuAOPy4I+bjvywWCAWim+wMLHiC7hXLlUl+LF8iFF389HoChrX7qCCO/7car43hvXOEQSCDkrI7agRAnNATHUm+f99CB3LhXANcuEAWmMTPizEnCiMI7CIIRIVK4cvsR1W04O95qszqtwpv36LrJWMkMGtvuuL2lq6UyAiFEOk5meeOjFXKBz1En6OjrhRCWP9gHaTESogBDiXlrVV15kQDAgT/2I5Nrlg9NirA0r9k4XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7721
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS1EPF0000008D.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a4f1e2e2-c382-464f-8e7a-08dea476006a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|35042699022|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: J7QDvEZc0+oz/zdVVzxOd0YaWqg1ZUsV+wkky4yUx4EWFeIuCgwb9el4ZEjm5lA4Et6o3dej7iEWb/JvUPdreB+VkK4+flWac1LGK/LbaUYHY6ZTaM7oiKI6q3xkV+wbiz3XyQR4i2EDgEmFf0mRh5U7aB6d8AXcoDc4dLjUsH0eH+cW258i4FbPrFWCeRGXeYV5infRf8o8IRPNrlIInv3IFnSWqaZTQwxQd+tPN9fBaNS0kEe3HrFmeFXs87+jEgPOHfnwXoO6qZ/HLWMdqtimOloT3lO2GdTdOzRfEFJd6kqsBpNSqeOF8+vpukVjAcNRc3vQCXCfZrVQ3aRbwRNskTEqs2s3RwMJdp6YT3gZnQQBqNDW7WIEXdNf+D7U5/prQh2eCFZ3Ya0pFfjUpgX/im35ITj6AHqTWgjZibbqMbD8vs2+mbQiS0G557Jzeq8zFI0GheeCWQLqzGsRBugoC8mun0TrrZ8iLV1Y3gTaoohzt23UYhpfcbez2VEpdOvQSqdjiWFkQKPZt95dYZTVw+xa11Q35Ss3Z/4gXrOS19xZfN8MnIvI0VhAIHmGDmPAbgLNvQhvi+0UN+cXAHM0z7bCNVQT/irb9oL8nww2x4FZkaRQ/5O5yauOeyNEg07wbJ1HGlQaoJWsWSoYrymd9M3PIrb+0WPbd1OD8XlyYc87PbxGxaMhFEpsRdJVcTecQLC4pMTDXrg2FuGbOk1tGIq3iyw52fKROG3V+c4C4i9xuzFIAfVyKZ1jAwOi2Yp6wQTLKhDCVMUXAqp2ZA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(35042699022)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gfOrK4GFwsdoa5pCu1al7mDmsRwUU9iu9ppF8KVp2bcJaDiBG2Ut3PnsjzQ5hA03A1nx4yU36itBtM8+7ZV+HaDScgPiPEDEjAMolMMhWf5HYc7RRvmdYk6ciOgdGVK50k4BbrMv83tcBrcd2DhBdP+OMxZlON8R7OEMLjywzF0kEOcCWLVXTNAaYL+SXfXLhkuQXBs8pWzLtL3KdjZC2RE0XBP4AavsBqLg/XF9NKT/n0YukYJLmi2qnWSsas3GElEVIameFfOaGcvdKtietSTLi3FDTG/leIZmjD/+I0pHKgIQIPXTlIr2KQ9u0z4HFQ165eKgkcQ2xIOC4pUMbi1KQlNiU6vkgnhhjWQX4vlISIYMXjtQAtWBnnlbPHj2kLyuq1KBywK5R0xOe4bNLRDBwswhY0tUa8F8xgchaiLpC1QTgrU3gtLA6yxSndRR
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:47.9687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4ebb7a-cb23-48f7-f445-08dea47625d0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000008D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMVPR08MB11974
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

Stop reaching into other components' registers directly and route those
operations through the component that owns them.

Move the timestamp/coherency helpers into panthor_gpu, add a doorbell
helper, and update call sites accordingly. This keeps register knowledge
local to each block and avoids spreading cross-component register
accesses across the driver.

This is a preparatory cleanup for using per-component iomem bases.

v3:
- Pick up Ack from Boris and R-bs from Liviu and Steve
v2:
- Fix incorrect spelling of timestamp helpers
- Fix unintended trailing backslash

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c | 27 ----------------
 drivers/gpu/drm/panthor/panthor_drv.c    |  7 ++---
 drivers/gpu/drm/panthor/panthor_fw.c     | 13 +++++---
 drivers/gpu/drm/panthor/panthor_fw.h     |  1 +
 drivers/gpu/drm/panthor/panthor_gpu.c    | 40 ++++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_gpu.h    |  6 ++++
 drivers/gpu/drm/panthor/panthor_pwr.c    |  2 +-
 drivers/gpu/drm/panthor/panthor_sched.c  |  2 +-
 8 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index f876b13492ae..bd417d6ae8c0 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -22,38 +22,11 @@
 #include "panthor_fw_regs.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
-#include "panthor_gpu_regs.h"
 #include "panthor_hw.h"
 #include "panthor_mmu.h"
 #include "panthor_pwr.h"
 #include "panthor_sched.h"
 
-static int panthor_gpu_coherency_init(struct panthor_device *ptdev)
-{
-	BUILD_BUG_ON(GPU_COHERENCY_NONE != DRM_PANTHOR_GPU_COHERENCY_NONE);
-	BUILD_BUG_ON(GPU_COHERENCY_ACE_LITE != DRM_PANTHOR_GPU_COHERENCY_ACE_LITE);
-	BUILD_BUG_ON(GPU_COHERENCY_ACE != DRM_PANTHOR_GPU_COHERENCY_ACE);
-
-	/* Start with no coherency, and update it if the device is flagged coherent. */
-	ptdev->gpu_info.selected_coherency = GPU_COHERENCY_NONE;
-	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
-
-	if (!ptdev->coherent)
-		return 0;
-
-	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
-	 * ACE protocol has never been supported for command stream frontend GPUs.
-	 */
-	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
-		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
-		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
-		return 0;
-	}
-
-	drm_err(&ptdev->base, "Coherency not supported by the device");
-	return -ENOTSUPP;
-}
-
 static int panthor_clk_init(struct panthor_device *ptdev)
 {
 	ptdev->clks.core = devm_clk_get(ptdev->base.dev, NULL);
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index e63210b01e6e..66996c9147c2 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -34,7 +34,6 @@
 #include "panthor_fw.h"
 #include "panthor_gem.h"
 #include "panthor_gpu.h"
-#include "panthor_gpu_regs.h"
 #include "panthor_heap.h"
 #include "panthor_mmu.h"
 #include "panthor_sched.h"
@@ -839,7 +838,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 	}
 
 	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_OFFSET)
-		arg->timestamp_offset = gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
+		arg->timestamp_offset = panthor_gpu_get_timestamp_offset(ptdev);
 	else
 		arg->timestamp_offset = 0;
 
@@ -854,7 +853,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 		query_start_time = 0;
 
 	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
-		arg->current_timestamp = gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
+		arg->current_timestamp = panthor_gpu_get_timestamp(ptdev);
 	else
 		arg->current_timestamp = 0;
 
@@ -870,7 +869,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 	}
 
 	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
-		arg->cycle_count = gpu_read64_counter(ptdev->iomem, GPU_CYCLE_COUNT);
+		arg->cycle_count = panthor_gpu_get_cycle_count(ptdev);
 	else
 		arg->cycle_count = 0;
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4704275b9c8f..4a0c23e987b6 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1054,7 +1054,7 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
 			       GLB_CFG_POWEROFF_TIMER |
 			       GLB_CFG_PROGRESS_TIMER);
 
-	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
 
 	/* Kick the watchdog. */
 	mod_delayed_work(ptdev->reset.wq, &ptdev->fw->watchdog.ping_work,
@@ -1156,7 +1156,7 @@ static void panthor_fw_halt_mcu(struct panthor_device *ptdev)
 	else
 		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
 
-	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
 }
 
 static bool panthor_fw_wait_mcu_halted(struct panthor_device *ptdev)
@@ -1400,6 +1400,11 @@ int panthor_fw_csg_wait_acks(struct panthor_device *ptdev, u32 csg_slot,
 	return ret;
 }
 
+void panthor_fw_ring_doorbell(struct panthor_device *ptdev, u32 doorbell_id)
+{
+	gpu_write(ptdev->iomem, CSF_DOORBELL(doorbell_id), 1);
+}
+
 /**
  * panthor_fw_ring_csg_doorbells() - Ring command stream group doorbells.
  * @ptdev: Device.
@@ -1414,7 +1419,7 @@ void panthor_fw_ring_csg_doorbells(struct panthor_device *ptdev, u32 csg_mask)
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 
 	panthor_fw_toggle_reqs(glb_iface, doorbell_req, doorbell_ack, csg_mask);
-	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
 }
 
 static void panthor_fw_ping_work(struct work_struct *work)
@@ -1429,7 +1434,7 @@ static void panthor_fw_ping_work(struct work_struct *work)
 		return;
 
 	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PING);
-	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	panthor_fw_ring_doorbell(ptdev, CSF_GLB_DOORBELL_ID);
 
 	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PING, &acked, 100);
 	if (ret) {
diff --git a/drivers/gpu/drm/panthor/panthor_fw.h b/drivers/gpu/drm/panthor/panthor_fw.h
index fbdc21469ba3..a99a9b6f4825 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.h
+++ b/drivers/gpu/drm/panthor/panthor_fw.h
@@ -500,6 +500,7 @@ int panthor_fw_csg_wait_acks(struct panthor_device *ptdev, u32 csg_id, u32 req_m
 int panthor_fw_glb_wait_acks(struct panthor_device *ptdev, u32 req_mask, u32 *acked,
 			     u32 timeout_ms);
 
+void panthor_fw_ring_doorbell(struct panthor_device *ptdev, u32 doorbell_id);
 void panthor_fw_ring_csg_doorbells(struct panthor_device *ptdev, u32 csg_slot);
 
 struct panthor_kernel_bo *
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index fecc30747acf..747ac332be64 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -427,3 +427,43 @@ void panthor_gpu_resume(struct panthor_device *ptdev)
 	panthor_hw_l2_power_on(ptdev);
 }
 
+u64 panthor_gpu_get_timestamp(struct panthor_device *ptdev)
+{
+	return gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
+}
+
+u64 panthor_gpu_get_timestamp_offset(struct panthor_device *ptdev)
+{
+	return gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
+}
+
+u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev)
+{
+	return gpu_read64_counter(ptdev->iomem, GPU_CYCLE_COUNT);
+}
+
+int panthor_gpu_coherency_init(struct panthor_device *ptdev)
+{
+	BUILD_BUG_ON(GPU_COHERENCY_NONE != DRM_PANTHOR_GPU_COHERENCY_NONE);
+	BUILD_BUG_ON(GPU_COHERENCY_ACE_LITE != DRM_PANTHOR_GPU_COHERENCY_ACE_LITE);
+	BUILD_BUG_ON(GPU_COHERENCY_ACE != DRM_PANTHOR_GPU_COHERENCY_ACE);
+
+	/* Start with no coherency, and update it if the device is flagged coherent. */
+	ptdev->gpu_info.selected_coherency = GPU_COHERENCY_NONE;
+	ptdev->coherent = device_get_dma_attr(ptdev->base.dev) == DEV_DMA_COHERENT;
+
+	if (!ptdev->coherent)
+		return 0;
+
+	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
+	 * ACE protocol has never been supported for command stream frontend GPUs.
+	 */
+	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
+		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
+		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
+		return 0;
+	}
+
+	drm_err(&ptdev->base, "Coherency not supported by the device");
+	return -ENOTSUPP;
+}
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.h b/drivers/gpu/drm/panthor/panthor_gpu.h
index 12c263a39928..f615feb05609 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.h
+++ b/drivers/gpu/drm/panthor/panthor_gpu.h
@@ -54,4 +54,10 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev);
 void panthor_gpu_power_changed_off(struct panthor_device *ptdev);
 int panthor_gpu_power_changed_on(struct panthor_device *ptdev);
 
+u64 panthor_gpu_get_timestamp(struct panthor_device *ptdev);
+u64 panthor_gpu_get_timestamp_offset(struct panthor_device *ptdev);
+u64 panthor_gpu_get_cycle_count(struct panthor_device *ptdev);
+
+int panthor_gpu_coherency_init(struct panthor_device *ptdev);
+
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index 306592ff2227..aafb0c5c7d23 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -199,7 +199,7 @@ static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32
 
 static void panthor_pwr_debug_info_show(struct panthor_device *ptdev)
 {
-	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", gpu_read64(ptdev->iomem, GPU_FEATURES));
+	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", ptdev->gpu_info.gpu_features);
 	drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(ptdev->iomem, PWR_STATUS));
 	drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PRESENT));
 	drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PWRTRANS));
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 530e1f0254b1..5b34032deff8 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3373,7 +3373,7 @@ queue_run_job(struct drm_sched_job *sched_job)
 		if (resume_tick)
 			sched_resume_tick(ptdev);
 
-		gpu_write(ptdev->iomem, CSF_DOORBELL(queue->doorbell_id), 1);
+		panthor_fw_ring_doorbell(ptdev, queue->doorbell_id);
 		if (!sched->pm.has_ref &&
 		    !(group->blocked_queues & BIT(job->queue_idx))) {
 			pm_runtime_get(ptdev->base.dev);
-- 
2.43.0

