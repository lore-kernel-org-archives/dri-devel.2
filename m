Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364F3E937E4
	for <dri-devel@archiver.kernel.org>; Sun, 12 Apr 2026 14:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F9B210E2C7;
	Sun, 12 Apr 2026 14:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="TvC4oXHK";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="TvC4oXHK";
	dkim-atps=neutral
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013041.outbound.protection.outlook.com
 [52.101.83.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC6AF10E2CB
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Apr 2026 14:31:17 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OU7SoNoCqH4OcoNmqDWNXtn8X4zK/QXJPlEA1/wqaxi5qvpS8FY7/4BAWdMGcRsR+Jc2xBLR4hurM7BCu0UfApfniS30UtsggR+22xJHE7QsXXAhEMnYQSKphf3UBxcV/L5fR76HQmAhs6WxFzY60gzrbXZHoUnZb1DM5KP+alGju2IRRnvGaCzYKaPfo8OCVTPcbBzbdOhH9EI3ESYeDCeLQP+KUzT7jKT/AHMiOrXBClTj4izuyuAsR2keuRIPVvweUSVMWLGKqnpcaO2dv7Qj5zh3q8aBDypi2vnSGb/9KIRFW0d4raABAEwJlZXuxxb1CWJ1+HQFHdC3ahA2JA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRdPYZfmfBpuqPntAVmclAIJ1f+aBUAEL3lu+qT+TcE=;
 b=Oaf8XN7qkP+I0oAg+BggUhnanpCa91wrv0EzOSo/2hMdpGW2rQroXNyoeZP0KeNg/6gbqkPRCulqDhunwFWooFTboJYXM+Tq+tz0OMq17WUBx2pCRyF8lo4iHREILfx3u4QLZsRfXEIqzqwNx4lmNFf1h7OpcVqvH8ldj4ODqFK83pQJl0K8iBVrFYYjLnD1xl9K0J5xouvh7nBvaP/qW/FfQ5L/gjHaU+6Ty+CA98/mtJN1G+KKfSydkS5NA8v56us1xIn58xnkrEOI2GeOxF8NH9LjPe+6jKw5VBYrCHkkEZMRkufvYaXKpwOIzjSYOyJiY04EY+vTdNB2pQE2kg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRdPYZfmfBpuqPntAVmclAIJ1f+aBUAEL3lu+qT+TcE=;
 b=TvC4oXHKbmQYJW1hSwlfo+4f/gUxSh8/IQQydt4oafKrYcbTMygWHXKMOPNskSixa/3/uaMxuHulqJ/7cMG/8mdAegLgdI2IdygXt4moIBRinupdlVcBZxKR1Yhc3htskwczGsYpZ9KJIJA+nkfX23Dpb3qIFDAY3EkCxEWs4cg=
Received: from CWLP123CA0048.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:58::36)
 by GVXPR08MB10811.eurprd08.prod.outlook.com (2603:10a6:150:15b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Sun, 12 Apr
 2026 14:31:11 +0000
Received: from AM3PEPF0000A794.eurprd04.prod.outlook.com
 (2603:10a6:401:58:cafe::78) by CWLP123CA0048.outlook.office365.com
 (2603:10a6:401:58::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Sun,
 12 Apr 2026 14:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM3PEPF0000A794.mail.protection.outlook.com (10.167.16.123) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17
 via Frontend Transport; Sun, 12 Apr 2026 14:31:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pp5/9uy7hlze+1gTbGghrgauHkTdKbfImhl7ztvgYoNkWa9CIvaFEXBAiwy8i5RFj9TwW08z3I78LBzyo77ShuPSkU3Ha9eQaTIn0Q0Q9ocMeSNYS5aGwPRbNj7F98YDAHxrgO4cgoOrPPG1sg2ph6O30wwTDcRIaIws4XfvReGMLWOazXHljw/s857bqHIxaIDrRmHSycWSyaqrsQxAubfmxmjZR1S8H0nK2tQK2Bc6PAJDXiGM7B2Q6v8WOm6ceDF6S3sOYZakr+G1rEF1Nw8rgOn2qsMvmkJBFnPg1/wMNHC++BRxBbK51RHDmui5CdaWWcLoTuY24JKtpxhrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRdPYZfmfBpuqPntAVmclAIJ1f+aBUAEL3lu+qT+TcE=;
 b=OzErs7UGIbO5ceB6QrkvvayPb7ccVsRDfejO7wBQ8yQwEERWWPJjOWVMUYzrhGCUF7jyEBtKfR9RxHXLTD7j8gBcYQK4yxCid3gMQDoju/u5ROZvzF7Uq1XtTI+ry/viehrZyTcCJ9HoAdOg+r8RJHMtnGFuaSExekckxCw/v1d6tKbo7qNdbZwtcmfW4jfsSorUD3j68U7QroDweVmH7vX/haMeowaxOcErJyD6JB25PVCJ23Ycj0fXqgs3CqEFuda9ckQmso7ya06puGvMPuHttjSKNVW+C5tCInNd3LkPDHyMQ/O3dtmEFkeAYocwJFKVehGqB6sLJtqhZbZigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRdPYZfmfBpuqPntAVmclAIJ1f+aBUAEL3lu+qT+TcE=;
 b=TvC4oXHKbmQYJW1hSwlfo+4f/gUxSh8/IQQydt4oafKrYcbTMygWHXKMOPNskSixa/3/uaMxuHulqJ/7cMG/8mdAegLgdI2IdygXt4moIBRinupdlVcBZxKR1Yhc3htskwczGsYpZ9KJIJA+nkfX23Dpb3qIFDAY3EkCxEWs4cg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18) by DB9PR08MB6556.eurprd08.prod.outlook.com
 (2603:10a6:10:261::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 14:30:07 +0000
Received: from VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d]) by VI0PR08MB11200.eurprd08.prod.outlook.com
 ([fe80::27c:ea0c:e75a:d41d%6]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 14:30:07 +0000
From: Karunika Choo <karunika.choo@arm.com>
To: dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] drm/panthor: Use a local iomem base for firmware
 control registers
Date: Sun, 12 Apr 2026 15:29:50 +0100
Message-ID: <20260412142951.2309135-8-karunika.choo@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260412142951.2309135-1-karunika.choo@arm.com>
References: <20260412142951.2309135-1-karunika.choo@arm.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0026.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::6) To VI0PR08MB11200.eurprd08.prod.outlook.com
 (2603:10a6:800:257::18)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: VI0PR08MB11200:EE_|DB9PR08MB6556:EE_|AM3PEPF0000A794:EE_|GVXPR08MB10811:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a5772b-46d6-4abf-93ad-08de98a02432
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info-Original: rJUw3i3Yx4DjkDphJSans24FmjFeNG6iyqPcYoLjqv7zJKUd8cwmmG+UAUGwsr5SeYg0UI44jqxT2wPjBUPJJhJjvgEEW9M3THQqXj7IrVUaaVzIDywi+/HzcMqeiDyeXXPOEOH+xdiJqkx78439hlwzZO5Ovw/y9LL1HKHU4Q5uQ+n6Z0snktly2RGZdyJ6HIk6r2Eutgdx9GTRlZY0vkWsE/THgBWvreddry3UlYyIiE4tAnM7K024XgAysnj+Dn1LPlqgJUtWQSz1jsDNw1zTK8PsZRiMdxcar2Czahxmr9AKXFVBS4unVeR3pEKPgToyBZ0WRmg+LjTQipr0Lg+KbDLFmNSt/LnjcnY3ojfScX83Go09vxirdXKS9OfcysNILi/F18+KnKNUXd1R4VybdOYBvYqLq+IFEpjvYgLxaHLA+xlH/f7Z6IbAJNW6FWCpaj54LG/pGQdULNjTLF+5as77QNvYVcxbNCORDBZS08kLilINyyTrGdUFqnc1N0NqshQhmj2nXIyLfpn7i+c2dKvhUzRahqFSfMfdbRE2eVd3rrkIGSjGQGu08VONGTEo94ug5zhF2d/I0+W4DiPEg+8sYYXe3YZHeqdrFx1denPR1sq8uD7o8D/PzdgWl1wqABg0i61t/c/YdZIYMTMoeBXdcM846RCMU+5F4SsA4KCRD+bpjulq43Rac+rDV4olQpW2STXm230VhJsXFMSVL0uYA91klUcAb/SjD7s=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:VI0PR08MB11200.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: wo0G3VO1AQggwAOGbd/u3PyAs5aAVfovDaCaDg1u8+Z09/vJODugMYnXTgb3Q1JKLdg4LXQ4IytvEpuoZJFju/PfNv3WSHcqTzJX8DkciGAa/oVDz4PkCrPtIjO5LgbZICtr+czYqUJkIqQpPs2+9+aZurNLOr+ra/cwAik0zY9pOzP5HFLOE3hN2x1ml/FMcWkZu1jP7jHwzncQVMl9G38VIR+Y30V6MYqJoHF7FGugLYelsMbz6h4OZ3hoo1nyvD2Q2ucQBrV7PsH/Tn/Lz7U/G3aou4CfoDuFASHnInSk8YyA0zcL25c0zHnDUOnZPANFi/wFABPebRcTMYXUfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6556
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a573396a-925c-4166-6064-08de989ffed9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|14060799003|82310400026|35042699022|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: qBRaK52HrJDMXZmBP5PcmBeLoeBgCJGdCGA9NvqDYhElGF/jjfzUnOICsmCf1VgpMaMZAG+/twjLLbcbV2NByZywr3yK3bQjUGW3upzwdxBMVq67dGl2D4RZ/Jca+ndVUORtaRdiHEzx2XV1HitQohcI0yxiVNwQlocVoPAKGaRtuiTdGV+KgYtBNJkmkZJQX74lQC8vuS9wwg982tvYqj28lTxW8gxBIguO0HLmNcO3oHhxtkKUNjKymMMCQosyPccn2Ui8JRT1C6HMa4/0oPeXeYD7unTinElSggCpO5ToTGo76ewFqcEDcUasHeQ1f5zE3VfEvnQRcKb7LmhtSoObACoDYhkmQnCJ7yaBqu4Cbwb+CVbLo5CrV1mlaR5fVf3TwjOfCH6VH3dG7B9Ei6iY4EspSbMovGycXBifOatrgzUnDMmaQI0+1Nu3qhvgzGMYzbQABh/HMd0nNES38nRdneix2VipCMKDvdaskteoUED9Jn8YpTNYSyrNgyyXG6RV5tSN6YLg0ayFYOzVOdduWkZME+hIxO/OJX7pMvrp4ExAh5SKhJHC/BT3DYV3MtXg5/3nFrMITYE48Iq2j0mfKrkXsKTVzBotgWKWUsrjyWCDRsva46KXDNKkuPIndbA3MbPPZp5k8KRE2MxMLDEsXHYsexwowc1x+2vjdaeu4nme6Qtbuk8Hx/4XatEl6e8vVJY+QO/V4JQOpBEPHbuU8uz8lQo+T/BWuunO+btK48m8DnGosuASBVKWivOLYM0w/1E4E94wemB2SoTCkw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(14060799003)(82310400026)(35042699022)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hH6MuJNc86TgQ0w/2R9DeifQkach0bjVVzhh47MlkYxi7HjxlPkvFgnqCBjnPrQ7Km7X9NMZwnQFHNRIQ4KaywgtLREzXNB1p69X2dyoCexzdSuipvjNHGgmFKovElK/bIDZ04ORvcQwYFRwTfKv/YhdJshvRvuoVYvq9rlNud268H4iZeZBK9zyfstHjdsAs/gi0LegUPqyw/Vy1c4Q5kg8MSQTsU/Ijp8khLS5dXAKq3Jy42ej1dqRqEAj5x9frjxubL39W0t+RmM5iafn1YrcuZUiv4WgSrtxCEatbDJkdjuQNkG2XqyrJLFN6iVQbJKVyfbKw6VLdNzVX528yn6xeB8AawMK9lBOpEPUWzifN0uwbqzzwSA7j7hJTLj5RAiHVH2tbfq+oBm/Qjp3jIIgjinWF3YC/v2Tjj2hreTf/wF6v3VqFHeQ4KR+LCiS
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 14:31:10.1774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a5772b-46d6-4abf-93ad-08de98a02432
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A794.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10811
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

Add an MCU_CONTROL-local iomem pointer to struct panthor_fw and use it
for firmware control and status register accesses.

Job interrupt accesses continue to go through the IRQ-local base, while
doorbell writes stay on the device-wide mapping because they live
outside the MCU control window. This keeps firmware register accesses
scoped to the component that owns them.

No functional change intended.

v2:
- Pick up Ack from Boris.

Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Karunika Choo <karunika.choo@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c      | 20 +++++++++++++-------
 drivers/gpu/drm/panthor/panthor_fw_regs.h | 11 ++++-------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 73ef07a37e22..986151681b24 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -234,6 +234,9 @@ struct panthor_fw_iface {
  * struct panthor_fw - Firmware management
  */
 struct panthor_fw {
+	/** @iomem: CPU mapping of MCU_CONTROL iomem region */
+	void __iomem *iomem;
+
 	/** @vm: MCU VM. */
 	struct panthor_vm *vm;
 
@@ -1069,7 +1072,7 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
 	if (tracepoint_enabled(gpu_job_irq))
 		start = ktime_get_ns();
 
-	gpu_write(ptdev->iomem, JOB_INT_CLEAR, status);
+	gpu_write(ptdev->fw->irq.iomem, INT_CLEAR, status);
 
 	if (!ptdev->fw->booted && (status & JOB_INT_GLOBAL_IF))
 		ptdev->fw->booted = true;
@@ -1092,18 +1095,19 @@ PANTHOR_IRQ_HANDLER(job, panthor_job_irq_handler);
 
 static int panthor_fw_start(struct panthor_device *ptdev)
 {
+	struct panthor_fw *fw = ptdev->fw;
 	bool timedout = false;
 
 	ptdev->fw->booted = false;
 	panthor_job_irq_enable_events(&ptdev->fw->irq, ~0);
 	panthor_job_irq_resume(&ptdev->fw->irq);
-	gpu_write(ptdev->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
+	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
 
 	if (!wait_event_timeout(ptdev->fw->req_waitqueue,
 				ptdev->fw->booted,
 				msecs_to_jiffies(1000))) {
 		if (!ptdev->fw->booted &&
-		    !(gpu_read(ptdev->iomem, JOB_INT_STAT) & JOB_INT_GLOBAL_IF))
+		    !(gpu_read(fw->irq.iomem, INT_STAT) & JOB_INT_GLOBAL_IF))
 			timedout = true;
 	}
 
@@ -1114,7 +1118,7 @@ static int panthor_fw_start(struct panthor_device *ptdev)
 			[MCU_STATUS_HALT] = "halt",
 			[MCU_STATUS_FATAL] = "fatal",
 		};
-		u32 status = gpu_read(ptdev->iomem, MCU_STATUS);
+		u32 status = gpu_read(fw->iomem, MCU_STATUS);
 
 		drm_err(&ptdev->base, "Failed to boot MCU (status=%s)",
 			status < ARRAY_SIZE(status_str) ? status_str[status] : "unknown");
@@ -1126,10 +1130,11 @@ static int panthor_fw_start(struct panthor_device *ptdev)
 
 static void panthor_fw_stop(struct panthor_device *ptdev)
 {
+	struct panthor_fw *fw = ptdev->fw;
 	u32 status;
 
-	gpu_write(ptdev->iomem, MCU_CONTROL, MCU_CONTROL_DISABLE);
-	if (gpu_read_poll_timeout(ptdev->iomem, MCU_STATUS, status,
+	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_DISABLE);
+	if (gpu_read_poll_timeout(fw->iomem, MCU_STATUS, status,
 				  status == MCU_STATUS_DISABLED, 10, 100000))
 		drm_err(&ptdev->base, "Failed to stop MCU");
 }
@@ -1139,7 +1144,7 @@ static bool panthor_fw_mcu_halted(struct panthor_device *ptdev)
 	struct panthor_fw_global_iface *glb_iface = panthor_fw_get_glb_iface(ptdev);
 	bool halted;
 
-	halted = gpu_read(ptdev->iomem, MCU_STATUS) == MCU_STATUS_HALT;
+	halted = gpu_read(ptdev->fw->iomem, MCU_STATUS) == MCU_STATUS_HALT;
 
 	if (panthor_fw_has_glb_state(ptdev))
 		halted &= (GLB_STATE_GET(glb_iface->output->ack) == GLB_STATE_HALT);
@@ -1461,6 +1466,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
 	if (!fw)
 		return -ENOMEM;
 
+	fw->iomem = ptdev->iomem + MCU_CONTROL_BASE;
 	ptdev->fw = fw;
 	init_waitqueue_head(&fw->req_waitqueue);
 	INIT_LIST_HEAD(&fw->sections);
diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
index eeb41aff249b..b2e59cfc22b0 100644
--- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
@@ -4,23 +4,20 @@
 #ifndef __PANTHOR_FW_REGS_H__
 #define __PANTHOR_FW_REGS_H__
 
-#define MCU_CONTROL					0x700
+#define MCU_CONTROL_BASE				0x700
+
+#define MCU_CONTROL					0x0
 #define   MCU_CONTROL_ENABLE				1
 #define   MCU_CONTROL_AUTO				2
 #define   MCU_CONTROL_DISABLE				0
 
-#define MCU_STATUS					0x704
+#define MCU_STATUS					0x4
 #define   MCU_STATUS_DISABLED				0
 #define   MCU_STATUS_ENABLED				1
 #define   MCU_STATUS_HALT				2
 #define   MCU_STATUS_FATAL				3
 
 #define JOB_INT_BASE					0x1000
-
-#define JOB_INT_RAWSTAT					0x1000
-#define JOB_INT_CLEAR					0x1004
-#define JOB_INT_MASK					0x1008
-#define JOB_INT_STAT					0x100c
 #define   JOB_INT_GLOBAL_IF				BIT(31)
 #define   JOB_INT_CSG_IF(x)				BIT(x)
 
-- 
2.43.0

