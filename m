Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA43F459EF
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 16:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 626C510E9A5;
	Fri, 10 Apr 2026 16:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="UTJKbHBH";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UTJKbHBH";
	dkim-atps=neutral
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2825210E9A5
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 16:47:51 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=FpRfMGntPfehi0L4wbWidbPWeSR53juKP6b5jhtVVa2SFp0SOcpJRcEdPlHlf1PDvHYXWQZ1/k5j9kdIXSMvSYErRPe1Tikilc8sr9c3iERjms5tmR77frqC0JzgoqPb5ZQTuG2LXlTb1h+EsNZczKpuNZumfRHW02du9eNNQ5gtImCMJpYiPSAM4fJwPvZtZKeQ7q9V1E6tM6RUh2LBVvnoaY+2veTyRMuuRk5t/bHoJ3SQ5h74JaM4KHw//ARJmB9Cp2rFGZh7/Lv3C6Vrsqo3rbgBGuiROkzAaXl4MJCsKl8ktQBcrKsqFVz9ojsrfoy9seHAwG03vPHonY03nQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gwTABRoWIin4lYbqQbj3u1ZQ6L2TUJs9/tRvYfFPJ0=;
 b=NsTnJxbgZCE/ox3GRh5ScvgG156dqXSueDbds0KPbP2Vvm1k7Ny86qLtfVrprWFIO5jiTECrQdyklcVgmM61hpH+wdPLx0CtVse10E0xAVsC7ItHuWFUfW/3amMeeymCL7BINQiinGX/sxSuGGS8RZ6JMG8qlBQjvXpGWIFURT+rxiKJvV81eDD08vulTaUEtXwGqTiO61tbq+JyVeUue6k1LoVW0aK322py29A6GTP4+0mpwWRpfBHhgL41KhUQfHD3vh9CvqQy+a4f9ROVCV29WvtBn7Xd2Nwa7Vg8Q4cdDjy+sCh/CA9jE7ZUS1YLt0ca74CpMUXKstTUQT6YaQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gwTABRoWIin4lYbqQbj3u1ZQ6L2TUJs9/tRvYfFPJ0=;
 b=UTJKbHBHeDusr55RjnpXIzCa5E7Ik3nj8i0JFrl5QgidaH4ijelwY/PN2/ZKb956jlvJdLJvXWnYIr1nD63RpQayfNaZyWmCE9NsCtHeIm6MJiWooVPxp7CfcOdjaYhU5B8E1m9ePn4a3mEAju7J12BHd1/TgOIW8FRMmQ49e1I=
Received: from DUZPR01CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::13) by PAXPR08MB6559.eurprd08.prod.outlook.com
 (2603:10a6:102:df::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Fri, 10 Apr
 2026 16:47:45 +0000
Received: from DB5PEPF00014B99.eurprd02.prod.outlook.com
 (2603:10a6:10:3c2:cafe::1f) by DUZPR01CA0063.outlook.office365.com
 (2603:10a6:10:3c2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.42 via Frontend Transport; Fri,
 10 Apr 2026 16:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B99.mail.protection.outlook.com (10.167.8.166) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Fri, 10 Apr 2026 16:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gilXGJ5na/HwQK3FNe/XlVfLqNoTfz1aGdfXCXn1HtgMswhl0hGCfyLLZOOdSGlwn1oF3EqbsFKf9e8KKbZmrVeAKGaB1vL0UrM8MmY9oFBqSb+F2/L9UnLtUhsVq4R/C5MXCxz+Lsj0jsqA1eEvR8ZkCM7/EoIrkFtuoGs1QSkQ7ufVJLVs9lKo/y0Br2IL/wvrW7O0x6BcQzgYY4jeeyWybeVmGXAt0K0OV4ZYHufY27EOUXHp/Dt7aDEHfG0oXzg3kv+Hy1nawxxRKPkBr3PqA3ivLtt1QDEioS1GDRNr+U6t/pO3FV4a/v4PHGFDZ/qKvSHTIzhE1/i2PUYL6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+gwTABRoWIin4lYbqQbj3u1ZQ6L2TUJs9/tRvYfFPJ0=;
 b=w/+L+6UbI8M8DiAie1jYk0do6bUmDFjOzXiBvHR/qroQfcMBV/E+j6Ku6fLC4aNXqQssnezui8ooKhNOwF9ld6i0/DdQFidtjOya4H7LwQFM/dy+yyRZJgrcXaQHgZBpJcCy5oY9lTxdZqsu/QGO/woY7ijgu8nz1gFlNQ8RHhHVpau4R0V0lGADoU0FnJ2uqlpLjaWzOikPgsjjyaQy3Y0KAZhVKR2qEC1kl4C1hH+50S8b5kB1lJ16Q/5HYZk8QE1c+UxPbSMdtmplzBluBMK6lW6nKqylpLVWklpqlp36+e7Y8iPJiZG+jjZQkqr4RX71eJuyugnPXqih5GU6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gwTABRoWIin4lYbqQbj3u1ZQ6L2TUJs9/tRvYfFPJ0=;
 b=UTJKbHBHeDusr55RjnpXIzCa5E7Ik3nj8i0JFrl5QgidaH4ijelwY/PN2/ZKb956jlvJdLJvXWnYIr1nD63RpQayfNaZyWmCE9NsCtHeIm6MJiWooVPxp7CfcOdjaYhU5B8E1m9ePn4a3mEAju7J12BHd1/TgOIW8FRMmQ49e1I=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by AS8PR08MB9624.eurprd08.prod.outlook.com
 (2603:10a6:20b:617::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 16:46:42 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 16:46:42 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] drm/panthor: Pass an iomem pointer to GPU register access
 helpers
Date: Fri, 10 Apr 2026 17:46:30 +0100
Message-ID: <20260410164637.549145-2-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410164637.549145-1-karunika.choo@arm.com>
References: <20260410164637.549145-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0582.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::17) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|AS8PR08MB9624:EE_|DB5PEPF00014B99:EE_|PAXPR08MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: de6822b6-0f6c-4688-7add-08de9720e3cc
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: sVoWBzUTqkK7m7udAg+khEvSVD3mHRx8GYxpLSB/qxCZrEmmrTwL+ityiNEZPXRVG4H16FlgtKGYPopE0R8QYHcyx7WeD2SUVhUQp7RptnydiB50jSaZf6/EEjOEpEP0wnBUw/oCBW9N6gTfcmBIFBUlKBydMAiVsDxhsr5MCVreXGYzScRwHn1xJ8IcwtPeOmoR+yzDSGJ3AHioBi6dQr/R+aMZcwMqGarkihJsQMdjRgMYGYltzvbzqb8GOBMq44Cx6OAw+jYCf8IporZHaIp1q79VmV1MN4IHzxX+AE6Kqa9y9U1me7CxvKUAcZHDPPkIoic6WfcwI7vFpPHDFLxIHR6AgxOPlCatMPg6oZJU7SrjE9KnusLEq7Zg0TmO9Zvewg8ReNToZQzzWatuiN0TJeivD2wyfQCpVEBMH6CwG9DKrA2jxmdP3qaMPkUIRywY58UVNCWLj7sr/8AMWYBPrWfes8QZ/486BmsGRRUU7CEAG77OtOE8YrhU0jnOV7d/mTv35JcuQVgAeOZdrQHilGovU8RcZiHA9OQZzbuSxOmetLKlivW55dqtXMotKaVT6Febu7S5SxKL6E9k0ZBZQYUg0xn+4+sgJcD1l8sH256pIwwT6sKHC6g5bzUhk8cZ8PCaVPV15snrZ+lzh0MI22hM0eHaJChvB3rSjosPWgQwbkFSfMLgN5LmMPM2YJDr1Ka31Vgru8WspfUkjU0hoc9f6IrcJ+W9Do1aAqI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: fGgitONBHojMxY0fFlR2rb34HAvXDZO0/vwIvntXP8tLhlSPKj1HmivZEI2tCedsPE/OFnSc5ajWHIXe/zfwgA5FJxzcK1aznZXOeFrqeq7n2JBz7hzQYedU9s94IU55v0kiTvKa0T6Np2l9QBluortJ8E2dq18krJBOzlRRwyl0ezxcfdi1VajIpvbarSU3UsgPL/A9oxWns4UFlyH9FybbL/tplO2bn/mEsMRPv5luIZ69B3syVYiZe+CFFcOy7j705g2m88/72XGw+sy8HyPGJuGhRfw8f4EBeLwdSHoFWLu7ubPADOY3qbpVnaUhUqTC1Lb8nZv0XE27usPLjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9624
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5b78e3f2-4cb8-454a-2e99-08de9720be6f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|35042699022|82310400026|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: PsqisbZBOQGq71dKjE+b3IDHlDEUUhZ4AayLLvXa4zLXPhUaTI6nWX1bpNLn0KINJfRPt5Hc3eJxS0ktxmOnRXl3fuqJWFLnBBpx2QJdNmogYyNAq/UXMAknGMSC9kQfNSawol9FCySipbVZoH+hUQClRyRdKZNzhTsClqg6fDfKjqO1a6NB8PqRTv6UdMkf4h+BHBLfvxRWKal4XNgRdrI0KgTQNpqu2tM+E/w5fER3ZNTju4tkm7za74JdYA/vQbJtqRDv/rx471Oyij7rOLe6nHZdjB5WSwemoR1uBevddVHxyA0Yd0UWgfno4ZNl5WWGYFjFNOsHhzqZ3Yu4AebDCOaxnDe98H6mBTTioOgTRNagYeDE6pZi3XXo+jp1kfU0kf19RxNFDsrRIN3LFSWj2upDBDsXlvVrnNLkCoTc3tSR6A/vdCPH8uFRHz/ZcPFMNEnvLBW9+XGibq1GMZG7xN7UeJD93amDp0n3UMrTpWn5bTZhiw2GGS7wbMEaIQ0hjxe1/BRUpl+/8IpEaAu3HwkkiiyoCeKbOhCIPFvALUkwCwVDadhwhoJpl2RAb3rfIYzBpCNUKXtA8gafMN+s/4MEhXHDdeHKTop0VMVAYKH3XeWLzQYapOHs7mBi0aZ8/gJLP/M8vAuuFcDeqkpcjB6szvx7vDm5B3xPL5iQTX2VVkWB5GPpSN8XXjLH6bU4qzOhqhjodvjN8hfyb/Vjn6iPI3ZqZcXeWEzn6DFXbveHDYIgfq+bxl5fWgnf9EtufUZcLdAf/ehWCOaXeg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(35042699022)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BS1LJDGjyJPuBQ0JyFHitERjdCXrlgVyyZeAJWXX2gaxezsTr/O/m1IH4ozm8sJMd1UkK7Cqwqq+e2+EIydUSwBAZ7m0VqyIOxIj9cuAKxTd9jIqQ1oUjEpoUqL7SLuF5ZOLjuIeXOw4ZZFor9djwEvUOwbVZCGIZJCt2q9Q1zl4tOxhMYi3QSGiqXIdiv5FpgObI3YXkJH573FIyLvmeTz1hqJDjjqJXgyv7Eyo59+TeJoQnmcPELFmC0b4oNLrGw3LA3MbGzLnRgq6OBeVowlnBdvTb6QZ9odKU3zfp+wvwcK6tGhiQ6OClxB2WkXoclxrUG044NhmSSEcQAWblqw3fpCBE85wsfs6znYj5EtX32hpJugSucxKc04ftF+UxSA1f2bWJVejaeFTn4a2K1jGErfWDWYW+SrCI0XKPziCkk2j5BG5mZmGJlW2Px+Y
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 16:47:44.8684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de6822b6-0f6c-4688-7add-08de9720e3cc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B99.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6559
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

Convert the Panthor register access helpers to take an iomem pointer
instead of a panthor_device pointer.

This makes the helpers usable with block-local registers instead of
routing all accesses to go through ptdev->iomem. It is a preparatory
change for splitting the register space by components and for moving
callers away from cross-component register accesses.

No functional change intended.

Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_device.c |  2 +-
 drivers/gpu/drm/panthor/panthor_device.h | 78 ++++++++++++------------
 drivers/gpu/drm/panthor/panthor_drv.c    |  6 +-
 drivers/gpu/drm/panthor/panthor_fw.c     | 22 +++----
 drivers/gpu/drm/panthor/panthor_gpu.c    | 42 ++++++-------
 drivers/gpu/drm/panthor/panthor_hw.c     | 47 +++++++-------
 drivers/gpu/drm/panthor/panthor_mmu.c    | 29 +++++----
 drivers/gpu/drm/panthor/panthor_pwr.c    | 61 +++++++++---------
 drivers/gpu/drm/panthor/panthor_sched.c  |  2 +-
 9 files changed, 146 insertions(+), 143 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_device.c b/drivers/gpu/drm/panthor/panthor_device.c
index bc62a498a8a8..d62017b73409 100644
--- a/drivers/gpu/drm/panthor/panthor_device.c
+++ b/drivers/gpu/drm/panthor/panthor_device.c
@@ -43,7 +43,7 @@ static int panthor_gpu_coherency_init(struct panthor_device *ptdev)
 	/* Check if the ACE-Lite coherency protocol is actually supported by the GPU.
 	 * ACE protocol has never been supported for command stream frontend GPUs.
 	 */
-	if ((gpu_read(ptdev, GPU_COHERENCY_FEATURES) &
+	if ((gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES) &
 		      GPU_COHERENCY_PROT_BIT(ACE_LITE))) {
 		ptdev->gpu_info.selected_coherency = GPU_COHERENCY_ACE_LITE;
 		return 0;
diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
index 5cba272f9b4d..285bf7e4439e 100644
--- a/drivers/gpu/drm/panthor/panthor_device.h
+++ b/drivers/gpu/drm/panthor/panthor_device.h
@@ -505,7 +505,7 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
 	struct panthor_device *ptdev = pirq->ptdev;						\
 	enum panthor_irq_state old_state;							\
 												\
-	if (!gpu_read(ptdev, __reg_prefix ## _INT_STAT))					\
+	if (!gpu_read(ptdev->iomem, __reg_prefix ## _INT_STAT))					\
 		return IRQ_NONE;								\
 												\
 	guard(spinlock_irqsave)(&pirq->mask_lock);						\
@@ -515,7 +515,7 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
 	if (old_state != PANTHOR_IRQ_STATE_ACTIVE)						\
 		return IRQ_NONE;								\
 												\
-	gpu_write(ptdev, __reg_prefix ## _INT_MASK, 0);						\
+	gpu_write(ptdev->iomem, __reg_prefix ## _INT_MASK, 0);					\
 	return IRQ_WAKE_THREAD;									\
 }												\
 												\
@@ -534,7 +534,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 		 * right before the HW event kicks in. TLDR; it's all expected races we're	\
 		 * covered for.									\
 		 */										\
-		u32 status = gpu_read(ptdev, __reg_prefix ## _INT_RAWSTAT) & pirq->mask;	\
+		u32 status = gpu_read(ptdev->iomem, __reg_prefix ## _INT_RAWSTAT) & pirq->mask;	\
 												\
 		if (!status)									\
 			break;									\
@@ -550,7 +550,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
 					   PANTHOR_IRQ_STATE_PROCESSING,			\
 					   PANTHOR_IRQ_STATE_ACTIVE);				\
 		if (old_state == PANTHOR_IRQ_STATE_PROCESSING)					\
-			gpu_write(ptdev, __reg_prefix ## _INT_MASK, pirq->mask);		\
+			gpu_write(ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
 	}											\
 												\
 	return ret;										\
@@ -560,7 +560,7 @@ static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)
 {												\
 	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
 		atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDING);				\
-		gpu_write(pirq->ptdev, __reg_prefix ## _INT_MASK, 0);				\
+		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, 0);			\
 	}											\
 	synchronize_irq(pirq->irq);								\
 	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);					\
@@ -571,8 +571,8 @@ static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)
 	guard(spinlock_irqsave)(&pirq->mask_lock);						\
 												\
 	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_ACTIVE);					\
-	gpu_write(pirq->ptdev, __reg_prefix ## _INT_CLEAR, pirq->mask);				\
-	gpu_write(pirq->ptdev, __reg_prefix ## _INT_MASK, pirq->mask);				\
+	gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_CLEAR, pirq->mask);			\
+	gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);			\
 }												\
 												\
 static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
@@ -603,7 +603,7 @@ static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *
 	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
 	 */											\
 	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
-		gpu_write(pirq->ptdev, __reg_prefix ## _INT_MASK, pirq->mask);			\
+		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
 }												\
 												\
 static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq *pirq, u32 mask)\
@@ -617,80 +617,80 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
 	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
 	 */											\
 	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
-		gpu_write(pirq->ptdev, __reg_prefix ## _INT_MASK, pirq->mask);			\
+		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
 }
 
 extern struct workqueue_struct *panthor_cleanup_wq;
 
-static inline void gpu_write(struct panthor_device *ptdev, u32 reg, u32 data)
+static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
 {
-	writel(data, ptdev->iomem + reg);
+	writel(data, iomem + reg);
 }
 
-static inline u32 gpu_read(struct panthor_device *ptdev, u32 reg)
+static inline u32 gpu_read(void __iomem *iomem, u32 reg)
 {
-	return readl(ptdev->iomem + reg);
+	return readl(iomem + reg);
 }
 
-static inline u32 gpu_read_relaxed(struct panthor_device *ptdev, u32 reg)
+static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
 {
-	return readl_relaxed(ptdev->iomem + reg);
+	return readl_relaxed(iomem + reg);
 }
 
-static inline void gpu_write64(struct panthor_device *ptdev, u32 reg, u64 data)
+static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
 {
-	gpu_write(ptdev, reg, lower_32_bits(data));
-	gpu_write(ptdev, reg + 4, upper_32_bits(data));
+	gpu_write(iomem, reg, lower_32_bits(data));
+	gpu_write(iomem, reg + 4, upper_32_bits(data));
 }
 
-static inline u64 gpu_read64(struct panthor_device *ptdev, u32 reg)
+static inline u64 gpu_read64(void __iomem *iomem, u32 reg)
 {
-	return (gpu_read(ptdev, reg) | ((u64)gpu_read(ptdev, reg + 4) << 32));
+	return (gpu_read(iomem, reg) | ((u64)gpu_read(iomem, reg + 4) << 32));
 }
 
-static inline u64 gpu_read64_relaxed(struct panthor_device *ptdev, u32 reg)
+static inline u64 gpu_read64_relaxed(void __iomem *iomem, u32 reg)
 {
-	return (gpu_read_relaxed(ptdev, reg) |
-		((u64)gpu_read_relaxed(ptdev, reg + 4) << 32));
+	return (gpu_read_relaxed(iomem, reg) |
+		((u64)gpu_read_relaxed(iomem, reg + 4) << 32));
 }
 
-static inline u64 gpu_read64_counter(struct panthor_device *ptdev, u32 reg)
+static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
 {
 	u32 lo, hi1, hi2;
 	do {
-		hi1 = gpu_read(ptdev, reg + 4);
-		lo = gpu_read(ptdev, reg);
-		hi2 = gpu_read(ptdev, reg + 4);
+		hi1 = gpu_read(iomem, reg + 4);
+		lo = gpu_read(iomem, reg);
+		hi2 = gpu_read(iomem, reg + 4);
 	} while (hi1 != hi2);
 	return lo | ((u64)hi2 << 32);
 }
 
-#define gpu_read_poll_timeout(dev, reg, val, cond, delay_us, timeout_us)	\
+#define gpu_read_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
 	read_poll_timeout(gpu_read, val, cond, delay_us, timeout_us, false,	\
-			  dev, reg)
+			  iomem, reg)
 
-#define gpu_read_poll_timeout_atomic(dev, reg, val, cond, delay_us,		\
+#define gpu_read_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
 				     timeout_us)				\
 	read_poll_timeout_atomic(gpu_read, val, cond, delay_us, timeout_us,	\
-				 false, dev, reg)
+				 false, iomem, reg)
 
-#define gpu_read64_poll_timeout(dev, reg, val, cond, delay_us, timeout_us)	\
+#define gpu_read64_poll_timeout(iomem, reg, val, cond, delay_us, timeout_us)	\
 	read_poll_timeout(gpu_read64, val, cond, delay_us, timeout_us, false,	\
-			  dev, reg)
+			  iomem, reg)
 
-#define gpu_read64_poll_timeout_atomic(dev, reg, val, cond, delay_us,		\
+#define gpu_read64_poll_timeout_atomic(iomem, reg, val, cond, delay_us,		\
 				       timeout_us)				\
 	read_poll_timeout_atomic(gpu_read64, val, cond, delay_us, timeout_us,	\
-				 false, dev, reg)
+				 false, iomem, reg)
 
-#define gpu_read_relaxed_poll_timeout_atomic(dev, reg, val, cond, delay_us,	\
+#define gpu_read_relaxed_poll_timeout_atomic(iomem, reg, val, cond, delay_us,	\
 					     timeout_us)			\
 	read_poll_timeout_atomic(gpu_read_relaxed, val, cond, delay_us,		\
-				 timeout_us, false, dev, reg)
+				 timeout_us, false, iomem, reg)
 
-#define gpu_read64_relaxed_poll_timeout(dev, reg, val, cond, delay_us,		\
+#define gpu_read64_relaxed_poll_timeout(iomem, reg, val, cond, delay_us,	\
 					timeout_us)				\
 	read_poll_timeout(gpu_read64_relaxed, val, cond, delay_us, timeout_us,	\
-			  false, dev, reg)
+			  false, iomem, reg)
 
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 73fc983dc9b4..4f926c861fba 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -839,7 +839,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 	}
 
 	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_OFFSET)
-		arg->timestamp_offset = gpu_read64(ptdev, GPU_TIMESTAMP_OFFSET);
+		arg->timestamp_offset = gpu_read64(ptdev->iomem, GPU_TIMESTAMP_OFFSET);
 	else
 		arg->timestamp_offset = 0;
 
@@ -854,7 +854,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 		query_start_time = 0;
 
 	if (flags & DRM_PANTHOR_TIMESTAMP_GPU)
-		arg->current_timestamp = gpu_read64_counter(ptdev, GPU_TIMESTAMP);
+		arg->current_timestamp = gpu_read64_counter(ptdev->iomem, GPU_TIMESTAMP);
 	else
 		arg->current_timestamp = 0;
 
@@ -870,7 +870,7 @@ static int panthor_query_timestamp_info(struct panthor_device *ptdev,
 	}
 
 	if (flags & DRM_PANTHOR_TIMESTAMP_GPU_CYCLE_COUNT)
-		arg->cycle_count = gpu_read64_counter(ptdev, GPU_CYCLE_COUNT);
+		arg->cycle_count = gpu_read64_counter(ptdev->iomem, GPU_CYCLE_COUNT);
 	else
 		arg->cycle_count = 0;
 
diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index be0da5b1f3ab..69a19751a314 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -1054,7 +1054,7 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
 			       GLB_CFG_POWEROFF_TIMER |
 			       GLB_CFG_PROGRESS_TIMER);
 
-	gpu_write(ptdev, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
 
 	/* Kick the watchdog. */
 	mod_delayed_work(ptdev->reset.wq, &ptdev->fw->watchdog.ping_work,
@@ -1069,7 +1069,7 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
 	if (tracepoint_enabled(gpu_job_irq))
 		start = ktime_get_ns();
 
-	gpu_write(ptdev, JOB_INT_CLEAR, status);
+	gpu_write(ptdev->iomem, JOB_INT_CLEAR, status);
 
 	if (!ptdev->fw->booted && (status & JOB_INT_GLOBAL_IF))
 		ptdev->fw->booted = true;
@@ -1097,13 +1097,13 @@ static int panthor_fw_start(struct panthor_device *ptdev)
 	ptdev->fw->booted = false;
 	panthor_job_irq_enable_events(&ptdev->fw->irq, ~0);
 	panthor_job_irq_resume(&ptdev->fw->irq);
-	gpu_write(ptdev, MCU_CONTROL, MCU_CONTROL_AUTO);
+	gpu_write(ptdev->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
 
 	if (!wait_event_timeout(ptdev->fw->req_waitqueue,
 				ptdev->fw->booted,
 				msecs_to_jiffies(1000))) {
 		if (!ptdev->fw->booted &&
-		    !(gpu_read(ptdev, JOB_INT_STAT) & JOB_INT_GLOBAL_IF))
+		    !(gpu_read(ptdev->iomem, JOB_INT_STAT) & JOB_INT_GLOBAL_IF))
 			timedout = true;
 	}
 
@@ -1114,7 +1114,7 @@ static int panthor_fw_start(struct panthor_device *ptdev)
 			[MCU_STATUS_HALT] = "halt",
 			[MCU_STATUS_FATAL] = "fatal",
 		};
-		u32 status = gpu_read(ptdev, MCU_STATUS);
+		u32 status = gpu_read(ptdev->iomem, MCU_STATUS);
 
 		drm_err(&ptdev->base, "Failed to boot MCU (status=%s)",
 			status < ARRAY_SIZE(status_str) ? status_str[status] : "unknown");
@@ -1128,8 +1128,8 @@ static void panthor_fw_stop(struct panthor_device *ptdev)
 {
 	u32 status;
 
-	gpu_write(ptdev, MCU_CONTROL, MCU_CONTROL_DISABLE);
-	if (gpu_read_poll_timeout(ptdev, MCU_STATUS, status,
+	gpu_write(ptdev->iomem, MCU_CONTROL, MCU_CONTROL_DISABLE);
+	if (gpu_read_poll_timeout(ptdev->iomem, MCU_STATUS, status,
 				  status == MCU_STATUS_DISABLED, 10, 100000))
 		drm_err(&ptdev->base, "Failed to stop MCU");
 }
@@ -1139,7 +1139,7 @@ static bool panthor_fw_mcu_halted(struct panthor_device *ptdev)
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 	bool halted;
 
-	halted = gpu_read(ptdev, MCU_STATUS) == MCU_STATUS_HALT;
+	halted = gpu_read(ptdev->iomem, MCU_STATUS) == MCU_STATUS_HALT;
 
 	if (panthor_fw_has_glb_state(ptdev))
 		halted &= (GLB_STATE_GET(glb_iface->output->ack) == GLB_STATE_HALT);
@@ -1156,7 +1156,7 @@ static void panthor_fw_halt_mcu(struct panthor_device *ptdev)
 	else
 		panthor_fw_update_reqs(glb_iface, req, GLB_HALT, GLB_HALT);
 
-	gpu_write(ptdev, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
 }
 
 static bool panthor_fw_wait_mcu_halted(struct panthor_device *ptdev)
@@ -1414,7 +1414,7 @@ void panthor_fw_ring_csg_doorbells(struct panthor_device *ptdev, u32 csg_mask)
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 
 	panthor_fw_toggle_reqs(glb_iface, doorbell_req, doorbell_ack, csg_mask);
-	gpu_write(ptdev, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
 }
 
 static void panthor_fw_ping_work(struct work_struct *work)
@@ -1429,7 +1429,7 @@ static void panthor_fw_ping_work(struct work_struct *work)
 		return;
 
 	panthor_fw_toggle_reqs(glb_iface, req, ack, GLB_PING);
-	gpu_write(ptdev, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
+	gpu_write(ptdev->iomem, CSF_DOORBELL(CSF_GLB_DOORBELL_ID), 1);
 
 	ret = panthor_fw_glb_wait_acks(ptdev, GLB_PING, &acked, 100);
 	if (ret) {
diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
index 2ab444ee8c71..bdb72cebccb3 100644
--- a/drivers/gpu/drm/panthor/panthor_gpu.c
+++ b/drivers/gpu/drm/panthor/panthor_gpu.c
@@ -56,7 +56,7 @@ struct panthor_gpu {
 
 static void panthor_gpu_coherency_set(struct panthor_device *ptdev)
 {
-	gpu_write(ptdev, GPU_COHERENCY_PROTOCOL,
+	gpu_write(ptdev->iomem, GPU_COHERENCY_PROTOCOL,
 		  ptdev->gpu_info.selected_coherency);
 }
 
@@ -75,26 +75,26 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(data->asn_hash); i++)
-		gpu_write(ptdev, GPU_ASN_HASH(i), data->asn_hash[i]);
+		gpu_write(ptdev->iomem, GPU_ASN_HASH(i), data->asn_hash[i]);
 
-	l2_config = gpu_read(ptdev, GPU_L2_CONFIG);
+	l2_config = gpu_read(ptdev->iomem, GPU_L2_CONFIG);
 	l2_config |= GPU_L2_CONFIG_ASN_HASH_ENABLE;
-	gpu_write(ptdev, GPU_L2_CONFIG, l2_config);
+	gpu_write(ptdev->iomem, GPU_L2_CONFIG, l2_config);
 }
 
 static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
 {
-	gpu_write(ptdev, GPU_INT_CLEAR, status);
+	gpu_write(ptdev->iomem, GPU_INT_CLEAR, status);
 
 	if (tracepoint_enabled(gpu_power_status) && (status & GPU_POWER_INTERRUPTS_MASK))
 		trace_gpu_power_status(ptdev->base.dev,
-				       gpu_read64(ptdev, SHADER_READY),
-				       gpu_read64(ptdev, TILER_READY),
-				       gpu_read64(ptdev, L2_READY));
+				       gpu_read64(ptdev->iomem, SHADER_READY),
+				       gpu_read64(ptdev->iomem, TILER_READY),
+				       gpu_read64(ptdev->iomem, L2_READY));
 
 	if (status & GPU_IRQ_FAULT) {
-		u32 fault_status = gpu_read(ptdev, GPU_FAULT_STATUS);
-		u64 address = gpu_read64(ptdev, GPU_FAULT_ADDR);
+		u32 fault_status = gpu_read(ptdev->iomem, GPU_FAULT_STATUS);
+		u64 address = gpu_read64(ptdev->iomem, GPU_FAULT_ADDR);
 
 		drm_warn(&ptdev->base, "GPU Fault 0x%08x (%s) at 0x%016llx\n",
 			 fault_status, panthor_exception_name(ptdev, fault_status & 0xFF),
@@ -204,7 +204,7 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
 	u32 val;
 	int ret;
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev, pwrtrans_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
 					      !(mask & val), 100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
@@ -213,9 +213,9 @@ int panthor_gpu_block_power_off(struct panthor_device *ptdev,
 		return ret;
 	}
 
-	gpu_write64(ptdev, pwroff_reg, mask);
+	gpu_write64(ptdev->iomem, pwroff_reg, mask);
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev, pwrtrans_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
 					      !(mask & val), 100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
@@ -247,7 +247,7 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
 	u32 val;
 	int ret;
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev, pwrtrans_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, pwrtrans_reg, val,
 					      !(mask & val), 100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
@@ -256,9 +256,9 @@ int panthor_gpu_block_power_on(struct panthor_device *ptdev,
 		return ret;
 	}
 
-	gpu_write64(ptdev, pwron_reg, mask);
+	gpu_write64(ptdev->iomem, pwron_reg, mask);
 
-	ret = gpu_read64_relaxed_poll_timeout(ptdev, rdy_reg, val,
+	ret = gpu_read64_relaxed_poll_timeout(ptdev->iomem, rdy_reg, val,
 					      (mask & val) == val,
 					      100, timeout_us);
 	if (ret) {
@@ -326,7 +326,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
-		gpu_write(ptdev, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
+		gpu_write(ptdev->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
 	} else {
 		ret = -EIO;
 	}
@@ -340,7 +340,7 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
 				msecs_to_jiffies(100))) {
 		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
-		    !(gpu_read(ptdev, GPU_INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
+		    !(gpu_read(ptdev->iomem, GPU_INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
 			ret = -ETIMEDOUT;
 		else
 			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
@@ -370,8 +370,8 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 	if (!drm_WARN_ON(&ptdev->base,
 			 ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
 		ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
-		gpu_write(ptdev, GPU_INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
-		gpu_write(ptdev, GPU_CMD, GPU_SOFT_RESET);
+		gpu_write(ptdev->iomem, GPU_INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
+		gpu_write(ptdev->iomem, GPU_CMD, GPU_SOFT_RESET);
 	}
 	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
 
@@ -380,7 +380,7 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
 				msecs_to_jiffies(100))) {
 		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
 		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
-		    !(gpu_read(ptdev, GPU_INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
+		    !(gpu_read(ptdev->iomem, GPU_INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
 			timedout = true;
 		else
 			ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index d135aa6724fa..9309d0938212 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -194,35 +194,38 @@ static int panthor_gpu_info_init(struct panthor_device *ptdev)
 {
 	unsigned int i;
 
-	ptdev->gpu_info.csf_id = gpu_read(ptdev, GPU_CSF_ID);
-	ptdev->gpu_info.gpu_rev = gpu_read(ptdev, GPU_REVID);
-	ptdev->gpu_info.core_features = gpu_read(ptdev, GPU_CORE_FEATURES);
-	ptdev->gpu_info.l2_features = gpu_read(ptdev, GPU_L2_FEATURES);
-	ptdev->gpu_info.tiler_features = gpu_read(ptdev, GPU_TILER_FEATURES);
-	ptdev->gpu_info.mem_features = gpu_read(ptdev, GPU_MEM_FEATURES);
-	ptdev->gpu_info.mmu_features = gpu_read(ptdev, GPU_MMU_FEATURES);
-	ptdev->gpu_info.thread_features = gpu_read(ptdev, GPU_THREAD_FEATURES);
-	ptdev->gpu_info.max_threads = gpu_read(ptdev, GPU_THREAD_MAX_THREADS);
-	ptdev->gpu_info.thread_max_workgroup_size = gpu_read(ptdev, GPU_THREAD_MAX_WORKGROUP_SIZE);
-	ptdev->gpu_info.thread_max_barrier_size = gpu_read(ptdev, GPU_THREAD_MAX_BARRIER_SIZE);
-	ptdev->gpu_info.coherency_features = gpu_read(ptdev, GPU_COHERENCY_FEATURES);
+	ptdev->gpu_info.csf_id = gpu_read(ptdev->iomem, GPU_CSF_ID);
+	ptdev->gpu_info.gpu_rev = gpu_read(ptdev->iomem, GPU_REVID);
+	ptdev->gpu_info.core_features = gpu_read(ptdev->iomem, GPU_CORE_FEATURES);
+	ptdev->gpu_info.l2_features = gpu_read(ptdev->iomem, GPU_L2_FEATURES);
+	ptdev->gpu_info.tiler_features = gpu_read(ptdev->iomem, GPU_TILER_FEATURES);
+	ptdev->gpu_info.mem_features = gpu_read(ptdev->iomem, GPU_MEM_FEATURES);
+	ptdev->gpu_info.mmu_features = gpu_read(ptdev->iomem, GPU_MMU_FEATURES);
+	ptdev->gpu_info.thread_features = gpu_read(ptdev->iomem, GPU_THREAD_FEATURES);
+	ptdev->gpu_info.max_threads = gpu_read(ptdev->iomem, GPU_THREAD_MAX_THREADS);
+	ptdev->gpu_info.thread_max_workgroup_size =
+		gpu_read(ptdev->iomem, GPU_THREAD_MAX_WORKGROUP_SIZE);
+	ptdev->gpu_info.thread_max_barrier_size =
+		gpu_read(ptdev->iomem, GPU_THREAD_MAX_BARRIER_SIZE);
+	ptdev->gpu_info.coherency_features = gpu_read(ptdev->iomem, GPU_COHERENCY_FEATURES);
 	for (i = 0; i < 4; i++)
-		ptdev->gpu_info.texture_features[i] = gpu_read(ptdev, GPU_TEXTURE_FEATURES(i));
+		ptdev->gpu_info.texture_features[i] =
+			gpu_read(ptdev->iomem, GPU_TEXTURE_FEATURES(i));
 
-	ptdev->gpu_info.as_present = gpu_read(ptdev, GPU_AS_PRESENT);
+	ptdev->gpu_info.as_present = gpu_read(ptdev->iomem, GPU_AS_PRESENT);
 
 	/* Introduced in arch 11.x */
-	ptdev->gpu_info.gpu_features = gpu_read64(ptdev, GPU_FEATURES);
+	ptdev->gpu_info.gpu_features = gpu_read64(ptdev->iomem, GPU_FEATURES);
 
 	if (panthor_hw_has_pwr_ctrl(ptdev)) {
 		/* Introduced in arch 14.x */
-		ptdev->gpu_info.l2_present = gpu_read64(ptdev, PWR_L2_PRESENT);
-		ptdev->gpu_info.tiler_present = gpu_read64(ptdev, PWR_TILER_PRESENT);
-		ptdev->gpu_info.shader_present = gpu_read64(ptdev, PWR_SHADER_PRESENT);
+		ptdev->gpu_info.l2_present = gpu_read64(ptdev->iomem, PWR_L2_PRESENT);
+		ptdev->gpu_info.tiler_present = gpu_read64(ptdev->iomem, PWR_TILER_PRESENT);
+		ptdev->gpu_info.shader_present = gpu_read64(ptdev->iomem, PWR_SHADER_PRESENT);
 	} else {
-		ptdev->gpu_info.shader_present = gpu_read64(ptdev, GPU_SHADER_PRESENT);
-		ptdev->gpu_info.tiler_present = gpu_read64(ptdev, GPU_TILER_PRESENT);
-		ptdev->gpu_info.l2_present = gpu_read64(ptdev, GPU_L2_PRESENT);
+		ptdev->gpu_info.shader_present = gpu_read64(ptdev->iomem, GPU_SHADER_PRESENT);
+		ptdev->gpu_info.tiler_present = gpu_read64(ptdev->iomem, GPU_TILER_PRESENT);
+		ptdev->gpu_info.l2_present = gpu_read64(ptdev->iomem, GPU_L2_PRESENT);
 	}
 
 	return overload_shader_present(ptdev);
@@ -287,7 +290,7 @@ static int panthor_hw_bind_device(struct panthor_device *ptdev)
 
 static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
 {
-	ptdev->gpu_info.gpu_id = gpu_read(ptdev, GPU_ID);
+	ptdev->gpu_info.gpu_id = gpu_read(ptdev->iomem, GPU_ID);
 	if (!ptdev->gpu_info.gpu_id)
 		return -ENXIO;
 
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index fa8b31df85c9..0bd07a3dd774 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -522,9 +522,8 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
 	/* Wait for the MMU status to indicate there is no active command, in
 	 * case one is pending.
 	 */
-	ret = gpu_read_relaxed_poll_timeout_atomic(ptdev, AS_STATUS(as_nr), val,
-						   !(val & AS_STATUS_AS_ACTIVE),
-						   10, 100000);
+	ret = gpu_read_relaxed_poll_timeout_atomic(ptdev->iomem, AS_STATUS(as_nr), val,
+						   !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
 
 	if (ret) {
 		panthor_device_schedule_reset(ptdev);
@@ -541,7 +540,7 @@ static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd
 	/* write AS_COMMAND when MMU is ready to accept another command */
 	status = wait_ready(ptdev, as_nr);
 	if (!status) {
-		gpu_write(ptdev, AS_COMMAND(as_nr), cmd);
+		gpu_write(ptdev->iomem, AS_COMMAND(as_nr), cmd);
 		status = wait_ready(ptdev, as_nr);
 	}
 
@@ -592,9 +591,9 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 	panthor_mmu_irq_enable_events(&ptdev->mmu->irq,
 				      panthor_mmu_as_fault_mask(ptdev, as_nr));
 
-	gpu_write64(ptdev, AS_TRANSTAB(as_nr), transtab);
-	gpu_write64(ptdev, AS_MEMATTR(as_nr), memattr);
-	gpu_write64(ptdev, AS_TRANSCFG(as_nr), transcfg);
+	gpu_write64(ptdev->iomem, AS_TRANSTAB(as_nr), transtab);
+	gpu_write64(ptdev->iomem, AS_MEMATTR(as_nr), memattr);
+	gpu_write64(ptdev->iomem, AS_TRANSCFG(as_nr), transcfg);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -629,9 +628,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 	if (recycle_slot)
 		return 0;
 
-	gpu_write64(ptdev, AS_TRANSTAB(as_nr), 0);
-	gpu_write64(ptdev, AS_MEMATTR(as_nr), 0);
-	gpu_write64(ptdev, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
+	gpu_write64(ptdev->iomem, AS_TRANSTAB(as_nr), 0);
+	gpu_write64(ptdev->iomem, AS_MEMATTR(as_nr), 0);
+	gpu_write64(ptdev->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
 
 	return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
 }
@@ -784,7 +783,7 @@ int panthor_vm_active(struct panthor_vm *vm)
 	 */
 	fault_mask = panthor_mmu_as_fault_mask(ptdev, as);
 	if (ptdev->mmu->as.faulty_mask & fault_mask) {
-		gpu_write(ptdev, MMU_INT_CLEAR, fault_mask);
+		gpu_write(ptdev->iomem, MMU_INT_CLEAR, fault_mask);
 		ptdev->mmu->as.faulty_mask &= ~fault_mask;
 	}
 
@@ -1712,7 +1711,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 	if (vm->as.id >= 0 && size) {
 		/* Lock the region that needs to be updated */
-		gpu_write64(ptdev, AS_LOCKADDR(vm->as.id),
+		gpu_write64(ptdev->iomem, AS_LOCKADDR(vm->as.id),
 			    pack_region_range(ptdev, &start, &size));
 
 		/* If the lock succeeded, update the locked_region info. */
@@ -1773,8 +1772,8 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 		u32 access_type;
 		u32 source_id;
 
-		fault_status = gpu_read(ptdev, AS_FAULTSTATUS(as));
-		addr = gpu_read64(ptdev, AS_FAULTADDRESS(as));
+		fault_status = gpu_read(ptdev->iomem, AS_FAULTSTATUS(as));
+		addr = gpu_read64(ptdev->iomem, AS_FAULTADDRESS(as));
 
 		/* decode the fault status */
 		exception_type = fault_status & 0xFF;
@@ -1805,7 +1804,7 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
 		 * Note that COMPLETED irqs are never cleared, but this is fine
 		 * because they are always masked.
 		 */
-		gpu_write(ptdev, MMU_INT_CLEAR, mask);
+		gpu_write(ptdev->iomem, MMU_INT_CLEAR, mask);
 
 		if (ptdev->mmu->as.slots[as].vm)
 			ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
index ed3b2b4479ca..b77c85ad733a 100644
--- a/drivers/gpu/drm/panthor/panthor_pwr.c
+++ b/drivers/gpu/drm/panthor/panthor_pwr.c
@@ -55,7 +55,7 @@ struct panthor_pwr {
 static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
 {
 	spin_lock(&ptdev->pwr->reqs_lock);
-	gpu_write(ptdev, PWR_INT_CLEAR, status);
+	gpu_write(ptdev->iomem, PWR_INT_CLEAR, status);
 
 	if (unlikely(status & PWR_IRQ_COMMAND_NOT_ALLOWED))
 		drm_err(&ptdev->base, "PWR_IRQ: COMMAND_NOT_ALLOWED");
@@ -74,14 +74,14 @@ PANTHOR_IRQ_HANDLER(pwr, PWR, panthor_pwr_irq_handler);
 static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
 {
 	if (args)
-		gpu_write64(ptdev, PWR_CMDARG, args);
+		gpu_write64(ptdev->iomem, PWR_CMDARG, args);
 
-	gpu_write(ptdev, PWR_COMMAND, command);
+	gpu_write(ptdev->iomem, PWR_COMMAND, command);
 }
 
 static bool reset_irq_raised(struct panthor_device *ptdev)
 {
-	return gpu_read(ptdev, PWR_INT_RAWSTAT) & PWR_IRQ_RESET_COMPLETED;
+	return gpu_read(ptdev->iomem, PWR_INT_RAWSTAT) & PWR_IRQ_RESET_COMPLETED;
 }
 
 static bool reset_pending(struct panthor_device *ptdev)
@@ -96,7 +96,7 @@ static int panthor_pwr_reset(struct panthor_device *ptdev, u32 reset_cmd)
 			drm_WARN(&ptdev->base, 1, "Reset already pending");
 		} else {
 			ptdev->pwr->pending_reqs |= PWR_IRQ_RESET_COMPLETED;
-			gpu_write(ptdev, PWR_INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
+			gpu_write(ptdev->iomem, PWR_INT_CLEAR, PWR_IRQ_RESET_COMPLETED);
 			panthor_pwr_write_command(ptdev, reset_cmd, 0);
 		}
 	}
@@ -185,7 +185,7 @@ static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32
 	u64 val;
 	int ret = 0;
 
-	ret = gpu_read64_poll_timeout(ptdev, pwrtrans_reg, val, !(PWR_ALL_CORES_MASK & val), 100,
+	ret = gpu_read64_poll_timeout(ptdev->iomem, pwrtrans_reg, val, !(PWR_ALL_CORES_MASK & val), 100,
 				      timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base, "%s domain power in transition, pwrtrans(0x%llx)",
@@ -198,17 +198,17 @@ static int panthor_pwr_domain_wait_transition(struct panthor_device *ptdev, u32
 
 static void panthor_pwr_debug_info_show(struct panthor_device *ptdev)
 {
-	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", gpu_read64(ptdev, GPU_FEATURES));
-	drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(ptdev, PWR_STATUS));
-	drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(ptdev, PWR_L2_PRESENT));
-	drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(ptdev, PWR_L2_PWRTRANS));
-	drm_info(&ptdev->base, "L2_READY:        0x%016llx", gpu_read64(ptdev, PWR_L2_READY));
-	drm_info(&ptdev->base, "TILER_PRESENT:   0x%016llx", gpu_read64(ptdev, PWR_TILER_PRESENT));
-	drm_info(&ptdev->base, "TILER_PWRTRANS:  0x%016llx", gpu_read64(ptdev, PWR_TILER_PWRTRANS));
-	drm_info(&ptdev->base, "TILER_READY:     0x%016llx", gpu_read64(ptdev, PWR_TILER_READY));
-	drm_info(&ptdev->base, "SHADER_PRESENT:  0x%016llx", gpu_read64(ptdev, PWR_SHADER_PRESENT));
-	drm_info(&ptdev->base, "SHADER_PWRTRANS: 0x%016llx", gpu_read64(ptdev, PWR_SHADER_PWRTRANS));
-	drm_info(&ptdev->base, "SHADER_READY:    0x%016llx", gpu_read64(ptdev, PWR_SHADER_READY));
+	drm_info(&ptdev->base, "GPU_FEATURES:    0x%016llx", gpu_read64(ptdev->iomem, GPU_FEATURES));
+	drm_info(&ptdev->base, "PWR_STATUS:      0x%016llx", gpu_read64(ptdev->iomem, PWR_STATUS));
+	drm_info(&ptdev->base, "L2_PRESENT:      0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PRESENT));
+	drm_info(&ptdev->base, "L2_PWRTRANS:     0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_PWRTRANS));
+	drm_info(&ptdev->base, "L2_READY:        0x%016llx", gpu_read64(ptdev->iomem, PWR_L2_READY));
+	drm_info(&ptdev->base, "TILER_PRESENT:   0x%016llx", gpu_read64(ptdev->iomem, PWR_TILER_PRESENT));
+	drm_info(&ptdev->base, "TILER_PWRTRANS:  0x%016llx", gpu_read64(ptdev->iomem, PWR_TILER_PWRTRANS));
+	drm_info(&ptdev->base, "TILER_READY:     0x%016llx", gpu_read64(ptdev->iomem, PWR_TILER_READY));
+	drm_info(&ptdev->base, "SHADER_PRESENT:  0x%016llx", gpu_read64(ptdev->iomem, PWR_SHADER_PRESENT));
+	drm_info(&ptdev->base, "SHADER_PWRTRANS: 0x%016llx", gpu_read64(ptdev->iomem, PWR_SHADER_PWRTRANS));
+	drm_info(&ptdev->base, "SHADER_READY:    0x%016llx", gpu_read64(ptdev->iomem, PWR_SHADER_READY));
 }
 
 static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd, u32 domain,
@@ -240,13 +240,13 @@ static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd,
 		return ret;
 
 	/* domain already in target state, return early */
-	if ((gpu_read64(ptdev, ready_reg) & mask) == expected_val)
+	if ((gpu_read64(ptdev->iomem, ready_reg) & mask) == expected_val)
 		return 0;
 
 	panthor_pwr_write_command(ptdev, pwr_cmd, mask);
 
-	ret = gpu_read64_poll_timeout(ptdev, ready_reg, val, (mask & val) == expected_val, 100,
-				      timeout_us);
+	ret = gpu_read64_poll_timeout(ptdev->iomem, ready_reg, val, (mask & val) == expected_val,
+				      100, timeout_us);
 	if (ret) {
 		drm_err(&ptdev->base,
 			"timeout waiting on %s power domain transition, cmd(0x%x), arg(0x%llx)",
@@ -279,7 +279,7 @@ static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd,
 static int retract_domain(struct panthor_device *ptdev, u32 domain)
 {
 	const u32 pwr_cmd = PWR_COMMAND_DEF(PWR_COMMAND_RETRACT, domain, 0);
-	const u64 pwr_status = gpu_read64(ptdev, PWR_STATUS);
+	const u64 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
 	const u64 delegated_mask = PWR_STATUS_DOMAIN_DELEGATED(domain);
 	const u64 allow_mask = PWR_STATUS_DOMAIN_ALLOWED(domain);
 	u64 val;
@@ -288,8 +288,9 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
 	if (drm_WARN_ON(&ptdev->base, domain == PWR_COMMAND_DOMAIN_L2))
 		return -EPERM;
 
-	ret = gpu_read64_poll_timeout(ptdev, PWR_STATUS, val, !(PWR_STATUS_RETRACT_PENDING & val),
-				      0, PWR_RETRACT_TIMEOUT_US);
+	ret = gpu_read64_poll_timeout(ptdev->iomem, PWR_STATUS, val,
+				      !(PWR_STATUS_RETRACT_PENDING & val), 0,
+				      PWR_RETRACT_TIMEOUT_US);
 	if (ret) {
 		drm_err(&ptdev->base, "%s domain retract pending", get_domain_name(domain));
 		return ret;
@@ -306,7 +307,7 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
 	 * On successful retraction
 	 * allow-flag will be set with delegated-flag being cleared.
 	 */
-	ret = gpu_read64_poll_timeout(ptdev, PWR_STATUS, val,
+	ret = gpu_read64_poll_timeout(ptdev->iomem, PWR_STATUS, val,
 				      ((delegated_mask | allow_mask) & val) == allow_mask, 10,
 				      PWR_TRANSITION_TIMEOUT_US);
 	if (ret) {
@@ -333,7 +334,7 @@ static int retract_domain(struct panthor_device *ptdev, u32 domain)
 static int delegate_domain(struct panthor_device *ptdev, u32 domain)
 {
 	const u32 pwr_cmd = PWR_COMMAND_DEF(PWR_COMMAND_DELEGATE, domain, 0);
-	const u64 pwr_status = gpu_read64(ptdev, PWR_STATUS);
+	const u64 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
 	const u64 allow_mask = PWR_STATUS_DOMAIN_ALLOWED(domain);
 	const u64 delegated_mask = PWR_STATUS_DOMAIN_DELEGATED(domain);
 	u64 val;
@@ -362,7 +363,7 @@ static int delegate_domain(struct panthor_device *ptdev, u32 domain)
 	 * On successful delegation
 	 * allow-flag will be cleared with delegated-flag being set.
 	 */
-	ret = gpu_read64_poll_timeout(ptdev, PWR_STATUS, val,
+	ret = gpu_read64_poll_timeout(ptdev->iomem, PWR_STATUS, val,
 				      ((delegated_mask | allow_mask) & val) == delegated_mask,
 				      10, PWR_TRANSITION_TIMEOUT_US);
 	if (ret) {
@@ -410,7 +411,7 @@ static int panthor_pwr_delegate_domains(struct panthor_device *ptdev)
  */
 static int panthor_pwr_domain_force_off(struct panthor_device *ptdev, u32 domain)
 {
-	const u64 domain_ready = gpu_read64(ptdev, get_domain_ready_reg(domain));
+	const u64 domain_ready = gpu_read64(ptdev->iomem, get_domain_ready_reg(domain));
 	int ret;
 
 	/* Domain already powered down, early exit. */
@@ -471,7 +472,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
 
 int panthor_pwr_reset_soft(struct panthor_device *ptdev)
 {
-	if (!(gpu_read64(ptdev, PWR_STATUS) & PWR_STATUS_ALLOW_SOFT_RESET)) {
+	if (!(gpu_read64(ptdev->iomem, PWR_STATUS) & PWR_STATUS_ALLOW_SOFT_RESET)) {
 		drm_err(&ptdev->base, "RESET_SOFT not allowed");
 		return -EOPNOTSUPP;
 	}
@@ -482,7 +483,7 @@ int panthor_pwr_reset_soft(struct panthor_device *ptdev)
 void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 {
 	const u64 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
-	const u64 pwr_status = gpu_read64(ptdev, PWR_STATUS);
+	const u64 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
 
 	/* Abort if L2 power off constraints are not satisfied */
 	if (!(pwr_status & l2_allow_mask)) {
@@ -508,7 +509,7 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
 
 int panthor_pwr_l2_power_on(struct panthor_device *ptdev)
 {
-	const u32 pwr_status = gpu_read64(ptdev, PWR_STATUS);
+	const u32 pwr_status = gpu_read64(ptdev->iomem, PWR_STATUS);
 	const u32 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
 	int ret;
 
diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index a06d91875beb..7c8d350da02f 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3372,7 +3372,7 @@ queue_run_job(struct drm_sched_job *sched_job)
 		if (resume_tick)
 			sched_resume_tick(ptdev);
 
-		gpu_write(ptdev, CSF_DOORBELL(queue->doorbell_id), 1);
+		gpu_write(ptdev->iomem, CSF_DOORBELL(queue->doorbell_id), 1);
 		if (!sched->pm.has_ref &&
 		    !(group->blocked_queues & BIT(job->queue_idx))) {
 			pm_runtime_get(ptdev->base.dev);
-- 
2.43.0

