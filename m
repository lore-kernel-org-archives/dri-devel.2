Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62653CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 17:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39E6710E1D7;
	Sun, 11 Oct 2026 17:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="SWuT+AZ5";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SWuT+AZ5";
	dkim-atps=neutral
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010068.outbound.protection.outlook.com [52.101.69.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E588A10E05C
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 17:40:21 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=s5F93KSIu4ijrewBHACg5WsUzEmZZkJWaKCKaE5QeWrxZC+e2mU3qOGPu6SG6BmLPekgWk33xgeObyDR2lALqRkdUQEW26KdDz3/JHEjH2nXWt1zxVEumQofKUiJ6cRG1OOVYNQFE6ftpYY4bdFCQMKwKVYfSmyKnfs6EwgOxKqQRxpsxajNDBEZPuXMN4K8T/1GJztJja5jCi2yJmAkZ7cu4UUjIHtM6QE96VO0gFEp9fJLkVRfTntAY6RWeZXU9celX3FuOrjaz3UX5ELbSTiymw7rl+PUa1y4RBhFM04kMHCDYXktZib+BT748F0Z0PVnVmJ3c3TRCmpyKMuaBw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx6IsF/HFQXkI9HEPm7JHbI0utq+JyiXY/rE+89su9w=;
 b=PZwzn4OcZBMER4yuS14o9LyvI1MQRAXgCTGKvUhFeZrCfttzu2dBj+XmulNNObx9iXORbHhu6zPCoPlfQCseOGFEy7bBASWHXBl7e1jpGD6oFSfoOuq35aLI9vIc2U7+LM3G9utpCJUDVyIBEPxExuMO+SQHUNcRdMe3OuxTWun38zrvE3AsyhUBkG4ujjiI9+6qjM6jshD4Ud3AyEz+pOYSNvBEsVic+m1KM6SCrhQwhXPrnIruPsj3lHp8NXrh6Zbs7760n6p/7/xXQe2Id8aqkf604TyivY4Rmc+vqm5Mz6h+xxq7AflPnfNc73v/UDdAANSws21Glj6uNtEAvg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx6IsF/HFQXkI9HEPm7JHbI0utq+JyiXY/rE+89su9w=;
 b=SWuT+AZ5m70SmH1oxmboQJO5DD+q7GP/OFKcpL+hCBEnScIC3g6WQfYVc9dO+ynWQd4nshrbLjToJuJis1OnLIpzMl9Fj0XW4JhSF4xWCW8xgBQPLLOp+pOIkrD99CIhtf9aFp6wAMQymOSY4P2K3xKqv3sFKF+ieYLhrpPBcxE=
Received: from DUZPR01CA0117.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::23) by AS8PR08MB8350.eurprd08.prod.outlook.com
 (2603:10a6:20b:56c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Sun, 11 Oct
 2026 17:40:14 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:4bc:cafe::f) by DUZPR01CA0117.outlook.office365.com
 (2603:10a6:10:4bc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun,
 11 Oct 2026 17:40:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Sun, 11 Oct 2026 17:40:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlGavKqv1CN3gAItaYrZ+QZHCSM21tCMwg3lmaX5V8f11+lMi71bCmFLZ7+7o8toe0FmNRXIbbAouW7ozt+/byYyufAopAMBm3utKfUZvPpwPwWHIjEWK0WftYgMABfJ5HwyfP/T55Ajs4uHEVq5DsL87xPDLfyYKiyMlyZfoNxo74iEVptNyqq0irHlqfm5vuNIoErdxgiMX9XMmdZjCncmpfhOvDeCvkGMMUY2eoDaX1WCS7IPk2YDmCpz4CVBQwlZQhtpfoIVXZ9RFbYl56dtpU7cDCFF/CkP2HaCp/fcdijI3q63mSgdeMKLYOQHN9305Ni4mLPhwgrMnpyJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jx6IsF/HFQXkI9HEPm7JHbI0utq+JyiXY/rE+89su9w=;
 b=JReaQTipIDyBVhAgbgNT1E2H7nMWKSOg8P0K6Oi6IN22TgQJZhsmLbhJq5bMw5vLjQBeMakwJuJKFGQmi/CNxuiKoWcxuIV7//19JoKQLQSxS9/Iaji1sTKRWOmjElfGiVZmhtoReiljWCn20JxwivAgChOKA9AGqy3l222/4odfr/K5QypYflnwa2HL4wj2SngaRr4mtDdheTiiOyba9fflLWg2MEKvouHWgdjwYchb3n1k81bRgp1pir9Qo9Be1z3VCXPAE2wH8F9kHakaz0Aw4ghmgnJDmQiqiezsmMinqW5xy1zgB338YOVjFZ2aDkVpPDg4+A05dBRhJNHDVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jx6IsF/HFQXkI9HEPm7JHbI0utq+JyiXY/rE+89su9w=;
 b=SWuT+AZ5m70SmH1oxmboQJO5DD+q7GP/OFKcpL+hCBEnScIC3g6WQfYVc9dO+ynWQd4nshrbLjToJuJis1OnLIpzMl9Fj0XW4JhSF4xWCW8xgBQPLLOp+pOIkrD99CIhtf9aFp6wAMQymOSY4P2K3xKqv3sFKF+ieYLhrpPBcxE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com (2603:10a6:20b:2d5::15)
 by AS2PR08MB9521.eurprd08.prod.outlook.com (2603:10a6:20b:60f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Sun, 11 Oct
 2026 17:39:41 +0000
Received: from AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd]) by AM9PR08MB6052.eurprd08.prod.outlook.com
 ([fe80::5ba6:c70c:1cd:48cd%7]) with mapi id 15.21.0522.009; Sun, 11 Oct 2026
 17:39:41 +0000
From: Lukas Zapolskas <lukas.zapolskas@arm.com>
Date: Sun, 11 Oct 2026 18:36:48 +0100
Subject: [PATCH v7 1/8] drm/panthor: Add performance counter uAPI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-panthor-performance-counters-v7-1-12c32495062f@arm.com>
References: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
In-Reply-To: <20261011-panthor-performance-counters-v7-0-12c32495062f@arm.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nd@arm.com, Mihail Atanassov <mihail.atanassov@arm.com>, 
 Lukas Zapolskas <lukas.zapolskas@arm.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: LO4P265CA0153.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::16) To AM9PR08MB6052.eurprd08.prod.outlook.com
 (2603:10a6:20b:2d5::15)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM9PR08MB6052:EE_|AS2PR08MB9521:EE_|DU2PEPF00028D03:EE_|AS8PR08MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: c46ea45b-6d0f-4f25-5f8b-08df27beb4dd
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|23010399003|6133799003|10067099003|22082099003|18002099003|921020|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: KRe5tQYWoMpE4wbYfFCOXUffgq1M1ADAUZAzefhwIXV0MMiD2Gs+qo3zTXitNfU0xUqgjPjvH6rkb5oBh8rQOuAz8eS6r96ht8ecfN3XLv/x6DghG+sg4Tkk9n3le44+JYgicMcpbkNVNUxRDRwqbys297zA1REFhIK+U0NU/kTtj0HAL0acFIvJ1h85kBZ0BbbiwB7wB7oVYRdmCAST/vPlcZFEUm/aI7GfY/5XpiNE1Y3/+02gqXv3mMVR2wOIWQaSnHbM/UkYLhe8E0qdIgiNbNdWXR8CLOwSGuEqJ8cpelKZqLfnuWixVHE8yfsuIQ3CAfv3DdZrVUJrLrvl7ze0wRCmjfkF8tu58bnKALA/Lz1/HLV5FJ1Sngn6e7QFu1xrEcTI+aZCVeoU6Bbf1LRUH5xEBVgUEM5uZ0Tzn0w15qO8++lP83dVex4pz4uO++vSgXgapIF9c45oWND8bY+2NV0ZNe0i5N6UMXQYQTIfDMbHaTmw79aAIf3JXfQdvybakO9hvRFcLMCHNU1fq8GGrSdxRXZ0V5KSqmErTBxmXRBSQwgK265M3cMQTELf5jnpL7S//+fx8SWn6OKdGtswNhVsO2E1fVLXSdRjKhwl9+HIzEoXAiQqysMI5AQcyuo59rtU0ADR2x9JRuiHdrw8NAweD2Cdph95nI9vOkNKYnDzprZ1en5uFRMmE6S3fk1ItKsrP9K1jBQENm0jDA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM9PR08MB6052.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(921020)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 3ur4VbUUasBK5cYKmJ+9E3zW7SzJwwJucHTowOVnDgEdKlAMUrWkCOHk1dG6AEiJdfdZHvx+pnYm6RzLEZL5IXztARhlDCwcNZz5D3q/hPOcRSWHgu/CTi8S8K+6dgzU9T3OaTEsIPdw89lGAtCJ74ZsJs4Dw2Az9MOSeMTjjrOtEMAWCwbbjJNWgCubQMec5tVG1z4Xhx8gtSDiaEjhpiO6wsGskj6wyTM1H/tZBVoxpYP9GvmnsTUKD8JkL7OcdS+RzJXe5ruCR3C5gjekNWXjMCFh9RySXraY+faMwxgf3+kTL4ckKv4C/NT7/Cro1STSWK1E3bbNFJyYYVen9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9521
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 25bd7a7c-b1db-4b65-ffb0-08df27bea143
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700016|14060799003|35042699022|23010399003|82310400026|56012099006|11063799006|261009223027099003|921020|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 7fYPNtzwIZjmHlg2QfgfkjwUPAuiD5BFtup+MYpQZepQESZvAWYdgxzbnNpte7wHv2U3QSQNIEuIjDiCnsbzi2PdQp5cEjUBT9qVpT/ygO0Iej8xp2vaM2iYePp2v7qqqAqfVqGmRpbux1mS1vHFoMUBN/u9NX8Np07lm4ozLR75TYAlGeRYfBWouQdUQ3u7/ifKm/RCjN5EUNlzvHbijIs36wnhTQHdFbuSQ0KX0xssU4pU23c1CsVg1cYGfsiZNa7Mw802kCyIUEEme5vvNma5WVTAiHI2ivjo/OBPOatWm6k2xDR3VEgw3HHNtq4eHXSxUNnuoba+Jf9Qw4A1UWoQreazMVYd5cHk+x3lmFoPIFvg5k+oxxvyzg4OdxitoDKqnNB2G2lYHrJWd19+AVdFeopc4MxmOyFLRdGCKFK4WQ/pKHrIO6dxGukcOCAnTR9pX4R4uOAvfwXxD88N6jAqH2XjM2ngslMexQKW+J08Qf8lFRyFM2BI34iu5EvlSyMGJlrInxPwrMcM10ffuCb7Awry/IFmwqgLC+6tlx207xNdxliRxiWTP8w17s6Tlw3fzfuSEh2m0ihHaebos3tYrfo0QexEucXu22BToE3ZMy7KcT8noFEVM/1M050PxK6vvVwOsginYTsmq/k7/W9firqYb1hSwncI28jUK6CMBQZViWWgi2sC6jlA/36Gp+gy5xhqdsOFxbs8RRzD6VU4IsyOAW0/IPGCdvxFFb12bSQiAxWF2ZY8VM1rSz/O
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(14060799003)(35042699022)(23010399003)(82310400026)(56012099006)(11063799006)(261009223027099003)(921020)(22082099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D/vT3Uk11kU815SV/FUrS/htyBuMB0UGFEQdNtU6gxsqdDt8rkuaEjK5CoT6nOIv1lg0PARrO/SoAuTWuMDMlxUv491DZfmZNZplxv+jLH8GDIjdvWDCmA9BuVsoz+nTQx7lJW/RVDsnAdlUR4QichivHwT4kEyufjATyIXq5Ljra6pi83AV3Vg/XhUzyeu5vtP5t7q1T9a2OvfW9ySjEFqHpIT/abk7FsQ3BHbAaXWqB1cIpvl9NKd6No63bc6FVYStijmjgSwWZYeUE9PU+6Ew4S4K1fa6uiXLnNu5pNk9CyF7XeJzXfBKci7FlqkJ0L7zB1AgICZlIgzr/MxXnn1uSEwjzFp1KoEjsfsgeAQRQtYc1AdrgH9+ts5Ldax+0KqmNElWU56iA/tTnxVy4J8yPcLU/X0zXgc+luAHnHrO74x6Ec6jdcFy2K2njnf6
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2026 17:40:14.0490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c46ea45b-6d0f-4f25-5f8b-08df27beb4dd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8350
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

This patch extends the DEV_QUERY ioctl to return information about the
performance counter setup for userspace, and introduces the new
DRM_PANTHOR_PERF_SESSION ioctls in order to allow for the sampling of
performance counters.

The new design is inspired by the perf aux ringbuffer [0], with the
insert and extract indices being mapped to userspace, allowing
multiple samples to be exposed at any given time. The buffer is
annotated to include sample metadata and block metadata inline with
the elements they describe.

Userspace is responsible for passing in resources for samples to be
exposed, including the event file descriptor for notification of new
sample availability, the ringbuffer BO to store samples, and the
control BO.

[0]: https://docs.kernel.org/userspace-api/perf_ring_buffer.html

Co-developed-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
Signed-off-by: Lukas Zapolskas <lukas.zapolskas@arm.com>
---
 include/uapi/drm/panthor_drm.h | 370 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 370 insertions(+)

diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index a2ff0f4ec691..e45f75b76245 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -154,6 +154,23 @@ enum drm_panthor_ioctl_id {
 	 * This is useful for imported BOs.
 	 */
 	DRM_PANTHOR_BO_QUERY_INFO,
+
+	/** @DRM_PANTHOR_PERF_SESSION_CREATE: Create a performance counter session. */
+	DRM_PANTHOR_PERF_SESSION_CREATE,
+
+	/** @DRM_PANTHOR_PERF_SESSION_START: Start a performance counter session. */
+	DRM_PANTHOR_PERF_SESSION_START,
+
+	/** @DRM_PANTHOR_PERF_SESSION_SAMPLE: Request a manual sample on a performance counter
+	 * session.
+	 */
+	DRM_PANTHOR_PERF_SESSION_SAMPLE,
+
+	/** @DRM_PANTHOR_PERF_SESSION_STOP: Stop a performance counter session. */
+	DRM_PANTHOR_PERF_SESSION_STOP,
+
+	/** @DRM_PANTHOR_PERF_SESSION_DESTROY: Destroy a performance counter session. */
+	DRM_PANTHOR_PERF_SESSION_DESTROY,
 };
 
 /**
@@ -256,6 +273,9 @@ enum drm_panthor_dev_query_type {
 
 	/** @DRM_PANTHOR_DEV_QUERY_MMU_INFO: Query MMU information. */
 	DRM_PANTHOR_DEV_QUERY_MMU_INFO,
+
+	/** @DRM_PANTHOR_DEV_QUERY_PERF_INFO: Query performance counter interface information. */
+	DRM_PANTHOR_DEV_QUERY_PERF_INFO,
 };
 
 /**
@@ -517,6 +537,93 @@ struct drm_panthor_group_priorities_info {
 	__u8 pad[3];
 };
 
+/**
+ * enum drm_panthor_perf_block_type - Performance counter supported block types.
+ */
+enum drm_panthor_perf_block_type {
+	/** @DRM_PANTHOR_PERF_BLOCK_METADATA: Internal use only. */
+	DRM_PANTHOR_PERF_BLOCK_METADATA = 0,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_FW: The FW counter block. */
+	DRM_PANTHOR_PERF_BLOCK_FW,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_CSHW: The CSHW counter block. */
+	DRM_PANTHOR_PERF_BLOCK_CSHW,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_TILER: The tiler counter block. */
+	DRM_PANTHOR_PERF_BLOCK_TILER,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_MEMSYS: A memsys counter block. */
+	DRM_PANTHOR_PERF_BLOCK_MEMSYS,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_SHADER: A shader core counter block. */
+	DRM_PANTHOR_PERF_BLOCK_SHADER,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_FIRST: Internal use only. */
+	DRM_PANTHOR_PERF_BLOCK_FIRST = DRM_PANTHOR_PERF_BLOCK_FW,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_LAST: Internal use only. */
+	DRM_PANTHOR_PERF_BLOCK_LAST = DRM_PANTHOR_PERF_BLOCK_SHADER,
+
+	/** @DRM_PANTHOR_PERF_BLOCK_MAX: Internal use only. */
+	DRM_PANTHOR_PERF_BLOCK_MAX = DRM_PANTHOR_PERF_BLOCK_LAST + 1,
+};
+
+/**
+ * struct drm_panthor_perf_info - Performance counter interface information
+ *
+ * Structure grouping all queryable information relating to the performance counter
+ * interfaces.
+ */
+struct drm_panthor_perf_info {
+	/**
+	 * @counters_per_block: The number of 8-byte counters available in a block.
+	 */
+	__u32 counters_per_block;
+
+	/**
+	 * @sample_header_size: The size of the header struct available at the beginning
+	 * of every sample.
+	 */
+	__u32 sample_header_size;
+
+	/**
+	 * @block_header_size: The size of the header struct inline with the counters for a
+	 * single block.
+	 */
+	__u32 block_header_size;
+
+	/**
+	 * @sample_size: The size of a fully annotated sample, starting with a sample header
+	 *               of size @sample_header_size bytes, and all available blocks for the current
+	 *               configuration, each comprised of @counters_per_block 64-bit counters and
+	 *               a block header of @block_header_size bytes.
+	 *
+	 *               The user must use this field to allocate size for the ring buffer. In
+	 *               the case of new blocks being added, an old userspace can always use
+	 *               this field and ignore any blocks it does not know about.
+	 */
+	__u32 sample_size;
+
+	/** @fw_blocks: Number of FW blocks available. */
+	__u32 fw_blocks;
+
+	/** @cshw_blocks: Number of CSHW blocks available. */
+	__u32 cshw_blocks;
+
+	/** @tiler_blocks: Number of tiler blocks available. */
+	__u32 tiler_blocks;
+
+	/** @memsys_blocks: Number of memsys blocks available. */
+	__u32 memsys_blocks;
+
+	/** @shader_blocks: Number of shader core blocks available. */
+	__u32 shader_blocks;
+
+	/** @pad1: MBZ. */
+	__u32 pad1;
+};
+
 /**
  * struct drm_panthor_dev_query - Arguments passed to DRM_PANTHOR_IOCTL_DEV_QUERY
  */
@@ -1270,6 +1377,259 @@ struct drm_panthor_bo_query_info {
 	__u32 pad;
 };
 
+/**
+ * DOC: Performance counter decoding in userspace.
+ *
+ * Each sample will be exposed to userspace in the following manner:
+ *
+ * +--------+--------+------------------------+--------+-------------------------+-----+
+ * | Sample | Block  |        Block           | Block  |         Block           | ... |
+ * | header | header |        counters        | header |         counters        |     |
+ * +--------+--------+------------------------+--------+-------------------------+-----+
+ *
+ * Each sample starts with a &struct drm_panthor_perf_sample_header containing
+ * timestamps, sample flags and the command's user data.
+ *
+ * Each block starts with a &struct drm_panthor_perf_block_header identifying its
+ * type and index, followed by counters_per_block 64-bit counters, as reported by
+ * &struct drm_panthor_perf_info.
+ */
+
+/**
+ * struct drm_panthor_perf_block_header - Header present before every block in the
+ * sample ringbuffer.
+ */
+struct drm_panthor_perf_block_header {
+	/** @block_type: Type of the block. */
+	__u8 block_type;
+
+	/** @block_idx: Block index. */
+	__u8 block_idx;
+
+	/** @pad0: MBZ. */
+	__u8 pad0[6];
+};
+
+/**
+ * enum drm_panthor_perf_sample_flags - Sample-wide events that occurred over the sampling
+ * period.
+ */
+enum drm_panthor_perf_sample_flags {
+	/**
+	 * @DRM_PANTHOR_PERF_SAMPLE_OVERFLOW: This sample contains overflows due to the duration
+	 * of the sampling period.
+	 */
+	DRM_PANTHOR_PERF_SAMPLE_OVERFLOW = 1 << 0,
+};
+
+/**
+ * struct drm_panthor_perf_sample_header - Header present before every sample.
+ */
+struct drm_panthor_perf_sample_header {
+	/**
+	 * @timestamp_start_ns: Earliest timestamp that values in this sample represent, in
+	 * nanoseconds. Derived from CLOCK_MONOTONIC_RAW.
+	 */
+	__u64 timestamp_start_ns;
+
+	/**
+	 * @timestamp_end_ns: Latest timestamp that values in this sample represent, in
+	 * nanoseconds. Derived from CLOCK_MONOTONIC_RAW.
+	 */
+	__u64 timestamp_end_ns;
+
+	/** @flags: Current sample flags, combination of drm_panthor_perf_sample_flags. */
+	__u32 flags;
+
+	/** @pad: MBZ. */
+	__u32 pad;
+
+	/**
+	 * @user_data: User data provided as part of the command that triggered this sample.
+	 */
+	__u64 user_data;
+};
+
+/**
+ * enum drm_panthor_perf_counter_set - The counter set to be requested from the hardware.
+ *
+ * The hardware supports a single performance counter set at a time, so requesting any set other
+ * than the primary may fail if another process is sampling at the same time.
+ *
+ * If in doubt, the primary counter set has the most commonly used counters and requires no
+ * additional permissions to open.
+ */
+enum drm_panthor_perf_counter_set {
+	/**
+	 * @DRM_PANTHOR_PERF_SET_PRIMARY: The default set configured on the hardware.
+	 *
+	 * This is the only set for which all counters in all blocks are defined.
+	 */
+	DRM_PANTHOR_PERF_SET_PRIMARY,
+
+	/** @DRM_PANTHOR_PERF_SET_SECONDARY: The secondary performance counter set. */
+	DRM_PANTHOR_PERF_SET_SECONDARY,
+
+	/** @DRM_PANTHOR_PERF_SET_TERTIARY: The tertiary performance counter set.*/
+	DRM_PANTHOR_PERF_SET_TERTIARY,
+};
+
+/**
+ * struct drm_panthor_perf_ringbuf_control - Struct used to map in the ring buffer control indices
+ *                                           into memory shared between user and kernel.
+ *
+ */
+struct drm_panthor_perf_ringbuf_control {
+	/**
+	 * @extract_idx: Number of samples consumed or discarded by userspace. Only
+	 *               modifiable by userspace.
+	 */
+	__u64 extract_idx;
+
+	/**
+	 * @insert_idx: Number of samples emitted by the kernel. Only modifiable by
+	 *              the kernel.
+	 */
+	__u64 insert_idx;
+};
+
+/**
+ * struct drm_panthor_perf_session_create - Arguments passed to DRM_PANTHOR_PERF_SESSION_CREATE.
+ */
+struct drm_panthor_perf_session_create {
+	/**
+	 * @block_set: Set of performance counter blocks, member of
+	 *             enum drm_panthor_perf_counter_set.
+	 *
+	 * This is a global configuration and only one set can be active at a time. If
+	 * another client has already requested a counter set, any further requests
+	 * for a different counter set will fail and return an -EBUSY.
+	 *
+	 * If the requested set does not exist, the request will fail and return an -EINVAL.
+	 *
+	 * Some sets have additional requirements to be enabled, and the setup request will
+	 * fail with an -EACCES if these requirements are not satisfied.
+	 */
+	__u8 block_set;
+
+	/** @pad: MBZ. */
+	__u8 pad[7];
+
+	/** @fd: eventfd for signalling the availability of a new sample. */
+	__u32 fd;
+
+	/** @ringbuf_handle: Handle to the BO to write perf counter sample to. */
+	__u32 ringbuf_handle;
+
+	/**
+	 * @control_handle: Handle to the BO containing a contiguous 16 byte range, used for the
+	 * insert and extract indices for the ringbuffer.
+	 */
+	__u32 control_handle;
+
+	/**
+	 * @sample_slots: The number of slots available in the userspace-provided BO. Must be
+	 * a power of 2.
+	 *
+	 * If sample_slots * sample_size does not match the BO size, the setup request will fail.
+	 */
+	__u32 sample_slots;
+
+	/**
+	 * @fw_enable_mask: Bitmask of counters to request from the FW counter block. Any bits
+	 * past the first drm_panthor_perf_info.counters_per_block bits will be ignored. Bit 0
+	 * corresponds to counter 0.
+	 */
+	__u64 fw_enable_mask[2];
+
+	/**
+	 * @cshw_enable_mask: Bitmask of counters to request from the CSHW counter block. Any bits
+	 * past the first drm_panthor_perf_info.counters_per_block bits will be ignored. Bit 0
+	 * corresponds to counter 0.
+	 */
+	__u64 cshw_enable_mask[2];
+
+	/**
+	 * @tiler_enable_mask: Bitmask of counters to request from the tiler counter block. Any
+	 * bits past the first drm_panthor_perf_info.counters_per_block bits will be ignored. Bit
+	 * 0 corresponds to counter 0.
+	 */
+	__u64 tiler_enable_mask[2];
+
+	/**
+	 * @memsys_enable_mask: Bitmask of counters to request from the memsys counter blocks. Any
+	 * bits past the first drm_panthor_perf_info.counters_per_block bits will be ignored. Bit 0
+	 * corresponds to counter 0.
+	 */
+	__u64 memsys_enable_mask[2];
+
+	/**
+	 * @shader_enable_mask: Bitmask of counters to request from the shader core counter blocks.
+	 * Any bits past the first drm_panthor_perf_info.counters_per_block bits will be ignored.
+	 * Bit 0 corresponds to counter 0.
+	 */
+	__u64 shader_enable_mask[2];
+};
+
+/**
+ * struct drm_panthor_perf_session_start - Arguments passed to DRM_PANTHOR_PERF_SESSION_START.
+ */
+struct drm_panthor_perf_session_start {
+	/** @handle: Performance counter session handle. */
+	__u32 handle;
+
+	/** @pad0: MBZ. */
+	__u32 pad0;
+
+	/**
+	 * @user_data: User provided data that will be attached to automatic samples collected
+	 * until the next DRM_PANTHOR_PERF_SESSION_SAMPLE.
+	 */
+	__u64 user_data;
+};
+
+/**
+ * struct drm_panthor_perf_session_sample - Arguments passed to DRM_PANTHOR_PERF_SESSION_SAMPLE.
+ */
+struct drm_panthor_perf_session_sample {
+	/** @handle: Performance counter session handle. */
+	__u32 handle;
+
+	/** @pad0: MBZ. */
+	__u32 pad0;
+
+	/** @user_data: User provided data that will be attached to the sample.*/
+	__u64 user_data;
+};
+
+/**
+ * struct drm_panthor_perf_session_stop - Arguments passed to DRM_PANTHOR_PERF_SESSION_STOP.
+ */
+struct drm_panthor_perf_session_stop {
+	/** @handle: Performance counter session handle. */
+	__u32 handle;
+
+	/** @pad0: MBZ. */
+	__u32 pad0;
+
+	/**
+	 * @user_data: User provided data that will be attached to the automatic sample collected
+	 * at the end of this sampling session.
+	 */
+	__u64 user_data;
+};
+
+/**
+ * struct drm_panthor_perf_session_destroy - Arguments passed to DRM_PANTHOR_PERF_SESSION_DESTROY.
+ */
+struct drm_panthor_perf_session_destroy {
+	/** @handle: Performance counter session handle. */
+	__u32 handle;
+
+	/** @pad0: MBZ. */
+	__u32 pad0;
+};
+
 /**
  * DRM_IOCTL_PANTHOR() - Build a Panthor IOCTL number
  * @__access: Access type. Must be R, W or RW.
@@ -1320,6 +1680,16 @@ enum {
 		DRM_IOCTL_PANTHOR(WR, BO_SYNC, bo_sync),
 	DRM_IOCTL_PANTHOR_BO_QUERY_INFO =
 		DRM_IOCTL_PANTHOR(WR, BO_QUERY_INFO, bo_query_info),
+	DRM_IOCTL_PANTHOR_PERF_SESSION_CREATE =
+		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_CREATE, perf_session_create),
+	DRM_IOCTL_PANTHOR_PERF_SESSION_START =
+		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_START, perf_session_start),
+	DRM_IOCTL_PANTHOR_PERF_SESSION_SAMPLE =
+		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_SAMPLE, perf_session_sample),
+	DRM_IOCTL_PANTHOR_PERF_SESSION_STOP =
+		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_STOP, perf_session_stop),
+	DRM_IOCTL_PANTHOR_PERF_SESSION_DESTROY =
+		DRM_IOCTL_PANTHOR(WR, PERF_SESSION_DESTROY, perf_session_destroy),
 };
 
 #if defined(__cplusplus)

-- 
2.43.0

