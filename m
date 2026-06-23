Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61703CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD6CE10E345;
	Tue, 23 Jun 2026 09:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="LlMHHOQu";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LlMHHOQu";
	dkim-atps=neutral
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013033.outbound.protection.outlook.com [52.101.72.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 774B510E345
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 09:25:28 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=H71ScqoHw9jOirg1fwwcBPAJa9hKEbj40v9hZkwfO15eRo/xg4RPeUks3Avx4qpJNQvdgtkbyNqy0a2vuP6K412RHEhqjLE+wWi8XPdmTZsbLueG1M/iAHRISGe9NJ43nPRYOyUg2mQT1+05NhvQCRxbClu+mRm2ud58Ud6qeFM7D4XEMqVyR9ooGLVJXg8UmqZYbp88Ql5nnMDUKHUB+wRaCqDbiefEi6jW6xlG2Fkuhrqz0tNsp8yXWcGKrzoyQ+xV5Z9Oycy1lyff0MopX3t00BK7jZ22KD0qqT/Tlpxh7Ls/ljZ7pFSWMmxWsctInj3CcB90+X+iU5f40gvprQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e4O9b829+MAGCdO5b62XJ4Q/OJRr+2vGrO6fM1/6nk=;
 b=rwoRCx8J9ewx6Tq0hb+FU94MJoDVtqVPHfazRAU+Wwho6YAQZ+AXDzeRL1F53HIvelXDaA39Agc/xgptGkb+ZlEkBjlTjhVRSG+5ZxnmIXyVRbVBGw0Qbqb1QgFMLJ0SMJzRXEXCbcXhfDOXH4mOkMzR6Tx7vAhi3bSppjUkg1eAdd3xtcx532+QKI6V7orm9kiy8mCR6cgiVr7h3WYkUqb4yK5xuZ5KgV0Rg5AAyxvO00taw0pHv9XafE4/5UxrswJCFyqvKIdHw3gru53vW4yBev9Cmt5PciEHg1IbowJy3cmWRDiyCLAEVODUn0RJaA0eUTmrLMdXh6D5wSe3mg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=collabora.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e4O9b829+MAGCdO5b62XJ4Q/OJRr+2vGrO6fM1/6nk=;
 b=LlMHHOQuAjxlSFaTtqt3lCis4JNx2taeamTmoM6RXCjGy84jfaQXnvRBxMS8Cgimn7lxUUroDX8YTsNyoIvVPnV7qN5r4vJ/zrLFMQwty0TI52OsUpIl7G/TwUB8ovjqBOpEWsmpuJYy5+vDJO4Y80P5X7Lvm5a1TpMQnFDNrD4=
Received: from AS4PR09CA0001.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::7)
 by GVXPR08MB10640.eurprd08.prod.outlook.com (2603:10a6:150:14a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 09:25:21 +0000
Received: from AM4PEPF00027A66.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::6c) by AS4PR09CA0001.outlook.office365.com
 (2603:10a6:20b:5e0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Tue,
 23 Jun 2026 09:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A66.mail.protection.outlook.com (10.167.16.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.10
 via Frontend Transport; Tue, 23 Jun 2026 09:25:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7g7eJrUvLOQZ6dQbwba8Xc6kM2LNa8AIWd6qDlSyfjDO2N42wqKqieGBdh6NCOzBm81J8dxpoT/298FB1p3ITtqZRYMAuWC+8RVDgC6kpv4eDkZdbvQXOYElxSdnlY/98S1t4FVS8W60VNYWTc5zKnMAnSBl5JyPU+BYghDYQof8iVgMb8ZbvvnWn/JxxH/yu4rwNNK2j1wOMPI5lr5zc9C6e628csCwXde5dlYRaFFIQ0yNP/2LJkBnwAXzkaRDXIE3SOuD8XYNZJ1EELQwuG8kEVt9H981Jdrdz/BG7IRGCkOczqgNzMkELgLWoDAVndZ1xFWbbMBP5s0c0X5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0e4O9b829+MAGCdO5b62XJ4Q/OJRr+2vGrO6fM1/6nk=;
 b=pC2YPTDq6N9OVCbN5NEE4qvAUWbRhGbpONE/ra2S/Ze7C+IzFI0N0PpEv9RaugBGo7bkfPpuNDEwy5lczvZIdSgkrlnqjGO/3VM0s/4NMnpzqXAV8+z5PqRmF9BqQmgTM4hEwYdIzX/pBMmdZIPhJeOyK8AUerE7fl9SAobA/3P0ewsgTnbbT9OW+A2fxm09961Q2/JsidFrsOqEXZ1tOwLChbOBufSvpYjiHxKTfsIp5z6zJUIuqkSjW7twNHnb59JcQk0Jrng7x0WOH3GiqLTxZrZQpePu05jV6x6fDv/G8yoaUS+NXbUJSDoIgYNIyt3sr3ttsapOGOAx6YJeVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0e4O9b829+MAGCdO5b62XJ4Q/OJRr+2vGrO6fM1/6nk=;
 b=LlMHHOQuAjxlSFaTtqt3lCis4JNx2taeamTmoM6RXCjGy84jfaQXnvRBxMS8Cgimn7lxUUroDX8YTsNyoIvVPnV7qN5r4vJ/zrLFMQwty0TI52OsUpIl7G/TwUB8ovjqBOpEWsmpuJYy5+vDJO4Y80P5X7Lvm5a1TpMQnFDNrD4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com (2603:10a6:150:316::8)
 by DU0PR08MB8906.eurprd08.prod.outlook.com (2603:10a6:10:47e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 09:24:17 +0000
Received: from GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133]) by GVXPR08MB11744.eurprd08.prod.outlook.com
 ([fe80::f478:4ce7:8b51:133%4]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 09:24:16 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com, liviu.dudau@arm.com, steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com,
 Akash Goel <akash.goel@arm.com>
Subject: [PATCH] drm/panthor: Fix NPD issue on partial unmap of an evicted BO
Date: Tue, 23 Jun 2026 10:24:13 +0100
Message-Id: <20260623092413.2710066-1-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0499.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::18) To GVXPR08MB11744.eurprd08.prod.outlook.com
 (2603:10a6:150:316::8)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: GVXPR08MB11744:EE_|DU0PR08MB8906:EE_|AM4PEPF00027A66:EE_|GVXPR08MB10640:EE_
X-MS-Office365-Filtering-Correlation-Id: 5730c059-c2d0-48fc-c306-08ded10958fe
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|18002099003|6133799003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info-Original: jNGSxPAKs6wc7T6Ya9lm32MZuSmHI16hkxljSe6HbkRSfViY0EPenz76kqe+fMREhzTEx8ijK4PyVHSnm0nO0m/bvBlxfYP1tlXl8daFliBcWIfI2VzEaHS6ozumE+nbfsy8LXnZxZZOw5EtpM5uJ2wmeJKMg1M+1R8swVrQ1myx45FXB5938FmI2QnK06h8b2m82PmbRiSnLuKHo019z+fw3q2a78MtG/vgBR1BwqfFCmipMzsTjbuQFbqQzfRDeqgaguVQQxSkvpz/ZHC5thgs6+hjg+os6VyLx7n28s+ZsfsMFfXGDxYUnqGEHbPY2o7uvqdiwx7WYmzbbGchVj6eo1xFDSj94Kn5FEOmGej5U+EpvxuyPNoAehjlYVhDVzntfgZx8E+OlkGMUM0Kd0ASYUlr2ag1giOYQORa4rQh8p5ePSVxY0MRZCststKLe3iV9iUvs1umAYiA+qfkBBn7MHMSCnSS085M03QBS63InoPwh2/PmTKkkw9PmZM24zpvfTPnxk1r1eVlgyqHleos09tRdBzapgyFho7TzgWM7Qffucn8Wq2TatP9b53ynla3XZqEh++sQn2XkzbSNtceVR/Tx95KhfXgp3zNAutgQqqNEB5qNBJhwlxnhbkYTM5lpymOiCGv9u9SZ6JsWsACOuWAUDxXN0KyOsRyYCA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:GVXPR08MB11744.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(6133799003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: eCrs5Dve1TWSxqhVdoy3BfOJqVnaAicnrWYNeKLarNHaXaQf22+l6Jb/utTv7veLCO37aDeBdrNtEV5XhS/TKuYpUNajOvn0yo7hyIxYddVlPgBpITBZR8DTpRuadLr5iSbwgkIzoatzZmGWFIOznoAhftfwmBqms/iOGbg3w4Zqnx3fFTl3BMwnY2IYfk3IlczdoGPawcPQTxWJ5W0auMFZNhIKPDpb9Ymoy1byBMWFqsersovy9gRXSO990EweQnqDN6xHOB5maBXmMSn95ARdw+7MFdth047NvjbFvBTzJtqOp1sBigwBYPBWK7ne/7wvxt/cR0JzN8y/WPrsrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8906
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 537134f5-9a03-4d2d-7b32-08ded1093241
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|35042699022|82310400026|23010399003|14060799003|1800799024|11063799006|5023799004|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: NLf1BsMzIvgID7v0Bv1aDWtwsOR9shY1+pS6ESVLdOvjo49ZY8MI5krAQZK4u+bOLSPm5LF3+52KfgekTDImbw8sgR1eKyUv5/Pu7tXiofRPPV4W48ZP27h5GYUVskHef0c8M2o9WuejgEDTmDtlpJXhx4CfiSBgz3Tk7b6lRwemLeIW8jN7pcZLpXhOeD3hD+DJ6WkfsYq1MWzkmW21mIwv9Erk+QnhrrFLRWKxbMLJl6QZnKTrM03su0T92BSECGkUP1nlwFlaF6ynqpKuECSEJfGeSbAVhxnZeXj7gtyB+JmNW8HSzL0XmWKwHjWXbBQiR7GIC57Q09TGngQr2MWV8NTDss9Kgdjk2VAxUkapeVUd14OEMjULdEoa9D6Hl+Ro0B9wvNNb4JV8T9lrdKkGJdz54TKhvtl3I+zQ6HP3enuigcAZekQPmG+8NMXzLHgYpHCow0kWgi1MsKH6dp/cU8WFdqpx4Kdw1RfGwZLW1+e5g5W5J14qmCYjuuruu4RzKyHSwoXoCkiunvnYYtmaSwXD70Jfjj8D2NYVKdRES5VsmMb6hHKyf8Nw4S0rrrqfOPX4iCet/LWzLyND2nh57yQ2Dkl15KJ23S9zCSAB459dii2XKdXjQY4UFdoZrgJw+TBW37yEgP+Rus8nSaSS3vRCPzKEQoifOUOzX9Zhth3RiwwzNjNuGzoyH7Wm3Yh771Nic4gd1nVSCoEn1Q==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(35042699022)(82310400026)(23010399003)(14060799003)(1800799024)(11063799006)(5023799004)(6133799003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q13rjdc9r/80p4mlrCaeG/xiUfTgzyofOIq2h9Iys0yh1ORc56MC9C4w4WnhwrB4yoveY6X/xIUsX89gBL6Otx0Hq1eVofNNOCuEKPusAL3VATvi9OR5G9jnHBfRyeMCijxVbj5jDfN2Q3hwDirJRqT+fjSGkFTjUetHK02KLVC+Dv9TCNt1bdkXjntCOlaict8caEbLgulklno0ruk3pPWYtlL6WthIKX/7uKpf7O+D9ZTHVpCodFBQ6UC/bvjX2SWZdTR+DqCqOmV6zL8o8VWuJ3zvStCTwspUvU5BzzZCXh9NBlU3y4oJoWgnPFieNR6X0v2yLDnb0v6r/7kGoXivnp54Q62YmOaJtxiQglM0rFHvzo/YGlw+GhLeFBnCELGFVxBK3miQDQfPfilNnEC5NOWAVOsv2tRzeChtAd4M7Z+b+0jcbQ1BBeUtFQh9
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 09:25:21.0349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5730c059-c2d0-48fc-c306-08ded10958fe
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A66.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10640
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

This commit fixes the NULL pointer dereference issue that would have
happened on the split of GPU mapping due to partial unmap of an evicted
BO. There is a logic to handle the partial unmap of huge pages when the
GPU mapping is split. That logic was not being completely skipped for
the VMA of an evicted BO and that resulted in a NPD possibility for the
'bo->backing.pages' pointer, which is set to NULL when pages of a
BO are released on eviction.

Following dump was seen when a partial unmap was exercised for an
evicted BO.
Unable to handle kernel paging request at virtual address 0000000000002000
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=00000008842e8000
[0000000000002000] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1]  SMP
<snip>
pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : iova_mapped_as_huge_page+0x20/0x68 [panthor]
lr : panthor_gpuva_sm_step_remap+0x39c/0x498 [panthor]
sp : ffff800086193920
x29: ffff800086193920 x28: ffff800086193a18 x27: ffff800086193b80
x26: 0000000000400000 x25: 0000000000810000 x24: 0000000000400000
x23: ffff000808af1800 x22: 0000000000a00000 x21: ffff800086193a00
x20: ffff000806fd3f00 x19: 0000000000410000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: ffff800083ce2d83
x14: 0000000000000000 x13: 3120646574636976 x12: 6520303030303138
x11: 2d30303030313420 x10: ffff8000836e6c80 x9 : ffff80007bfc889c
x8 : 3fffffffffffefff x7 : ffff8000836e6c80 x6 : 0000000000000000
x5 : ffff00097ef19088 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000010000 x1 : 0000000000000400 x0 : 0000000000000000
Call trace:
 iova_mapped_as_huge_page+0x20/0x68 [panthor] (P)
 op_remap_cb.isra.0+0x70/0xb0
 __drm_gpuvm_sm_unmap+0xf8/0x1c0
 drm_gpuvm_sm_unmap+0x40/0x60
 panthor_vm_exec_op+0xa0/0x168 [panthor]
 panthor_vm_bind_exec_sync_op+0x8c/0xb8 [panthor]
 panthor_ioctl_vm_bind+0xbc/0x170 [panthor]
 drm_ioctl_kernel+0xc0/0x140
 drm_ioctl+0x20c/0x500
 __arm64_sys_ioctl+0xb4/0x118
 invoke_syscall+0x5c/0x120
 el0_svc_common.constprop.0+0x48/0xf8
 do_el0_svc+0x28/0x40
 el0_svc+0x38/0x128
 el0t_64_sync_handler+0xa0/0xe8
 el0t_64_sync+0x198/0x1a0
Code: 8b030021 cb020021 f940b800 d34cfc21 (f8617801)
---[ end trace 0000000000000000 ]---

Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
Signed-off-by: Akash Goel <akash.goel@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 31cc57029c12..285e7b9bc100 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2358,20 +2358,20 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 	 */
 	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
 
-	/*
-	 * ARM IOMMU page table management code disallows partial unmaps of huge pages,
-	 * so when a partial unmap is requested, we must first unmap the entire huge
-	 * page and then remap the difference between the huge page minus the requested
-	 * unmap region. Calculating the right start address and range for the expanded
-	 * unmap operation is the responsibility of the following function.
-	 */
-	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
-
-	/* If the range changed, we might have to lock a wider region to guarantee
-	 * atomicity. panthor_vm_lock_region() bails out early if the new region
-	 * is already part of the locked region, so no need to do this check here.
-	 */
 	if (!unmap_vma->evicted) {
+		/*
+		* ARM IOMMU page table management code disallows partial unmaps of huge pages,
+		* so when a partial unmap is requested, we must first unmap the entire huge
+		* page and then remap the difference between the huge page minus the requested
+		* unmap region. Calculating the right start address and range for the expanded
+		* unmap operation is the responsibility of the following function.
+		*/
+		unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
+
+		/* If the range changed, we might have to lock a wider region to guarantee
+		 * atomicity. panthor_vm_lock_region() bails out early if the new region
+		 * is already part of the locked region, so no need to do this check here.
+		 */
 		panthor_vm_lock_region(vm, unmap_start, unmap_range);
 		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
 	}
-- 
2.25.1

