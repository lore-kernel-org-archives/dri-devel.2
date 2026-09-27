Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6C4C98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F59110E67F;
	Sun, 27 Sep 2026 18:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NV9l+Ikj";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="A8lQ9sCI";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B868F10E67F
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:26:59 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68R8phTg3706315;
 Sun, 27 Sep 2026 13:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Vj/VjvvhgHzkGLqabqeFmV7NiJ9aFDafCq1m6DmEg
 AY=; b=NV9l+IkjyKc5Gtkbmnx8t13KKuBr7F1Riv9R9sD6cz2rTQSFLwLueAoYK
 Ol6m1ZxodgvZxhCto2i/dkrXoY924M47pQceosGGW+RHy2yDDB70u4zg72ARXybr
 D4JVow9UYPgVTXVFf0A+Dde/QiiYPl+LSIzQ7wXf2KKvXtLC7iiC/CmYFdgdgnqV
 ABouD2LSkbhB8TYFL7gpXHr9F4E3vgG2yo++tOCjHX/5SvfdQ9pbLnhNmKdVwF33
 85Tnyi8Hz5IEVMbZcieoMH2jseLNsWORpnHc2MrfZLS/7zm3XcrIbPbJ55SmNo2D
 Qjei0NjSDAVv1wQjKNR/VnAvDXGlQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gy00n9huw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:26:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNM4xYmLieJhVx6jm+t1zerF/w0X9v2LoUxuR/TjJ10r/lq55sMwaRdCwh6GeNIjuQwJ340hy3PLXiszlU1UKSLjaLy9ZZ1R3yIXF6QEISmGQYtBVgk0qevkcFDtymHrkuN6S0gbjgIg7FkHZeou8DwsGgW4tP8i5m0SWifHLeH0bu0XxZgQNvZ+S0E6hLdwCvIxXoQOFUnUYKPFzkxWAZV+U/P5XtsBOA3GfydcesFLIWhNh3V6FVOAMBI8mWtzuZM7D983BQ5cUtQoGk8mUF25qzYSglQLVP9ClFxy0qvgkRpSZtIMXvW03V2hhVVw5rMBQzDSUqifh4qdyKzsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vj/VjvvhgHzkGLqabqeFmV7NiJ9aFDafCq1m6DmEgAY=;
 b=jYz/rwCcxa9ixyjvZORjWXc7GD55p5Buv1BdUJlXDA1pLj0y0vlGyaDnEbXUIVqzEjJYFPIywitGe2dyG8JMdKF0V7tfz08dFTpg9G7I6GJftxtLHTqXE8H6hIga05RX+r6j9YSWakKVOtDNqkiDU9cMw6+RKnlq5LJDVrF6CgO/3ObcHgL29zO1AcM29FfvUlokKOxBm8E4s4ft2fbD54Qiz3hOVuW0PfQeZYJF1p5Gir04pVb4OXkjuZFs47LdTmwQYh+RE5qb9OR+DYEbXmxcbgIvyn5OPqF1SNtkijn/HvsXzUbDraSqdb0uuorH4MSv86Y8XeMxZLRKAFCgAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vj/VjvvhgHzkGLqabqeFmV7NiJ9aFDafCq1m6DmEgAY=;
 b=A8lQ9sCIMU0lnPDvqDptqAMFASzLrsYhcnUinioNFaFAgmlfAzuKBxU7R8yzveyptrXzxFAvVu/a9TwBhjrmi6WycUeDcL0oPSot0BK2pQWlnoJYkXOH8mC/3OcQGVSygJCtIwZheB2cKjcm5fhzjB9/ywfDu3hiRNKdCNsr5XU=
Received: from DS1PR05CA0005.namprd05.prod.outlook.com (2603:10b6:8:457::8) by
 CH5PR10MB997692.namprd10.prod.outlook.com (2603:10b6:610:2f2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Sun, 27 Sep
 2026 18:25:10 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:8:457:cafe::73) by DS1PR05CA0005.outlook.office365.com
 (2603:10b6:8:457::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Sun,
 27 Sep 2026 18:25:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 27 Sep 2026 18:25:09 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:24:40 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:24:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:24:40 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RIOdYc2546867;
 Sun, 27 Sep 2026 13:24:40 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH v2 02/14] dt-bindings: display: Add Solomon SSD16xx e-paper
 controller binding
Date: Sun, 27 Sep 2026 23:53:17 +0530
Message-ID: <20260927182329.4193961-3-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|CH5PR10MB997692:EE_
X-MS-Office365-Filtering-Correlation-Id: 69d6a558-8f36-4a68-34a9-08df1cc4a9b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|23010399003|1800799024|82310400026|10067099003|56012099006|6133799003|3023799007|18002099003|22082099003|921020|13003099007;
X-Microsoft-Antispam-Message-Info: 3mfZH3h4Mnf081vjX2dNj7QVn0l5FEl1rFO2Sba+EBU/AI0EiWIfXWJwNbOyqEOK25sPAz5N5ZWN86dlI3vNBR3+vRHYuVodnF26Y5KMgRbiLRi11IygET70+2st5196/SmU7lkKBzaTI6lrbTRw5RYkjB6eFW1bQXerQCV/aDMmFEOh4EDPqAYV/2NJT27CDeHpLSCNs7bKTEBJwCuZhDObb75FtnDgRnkVe2CL0otux8HGGFT5roO8gGCTFblvQMhtckufdQ/P4eFDC0am/8vH6BPABcmkwRIzHctF4GvLqCaFTBYamJ/+pThqReMtd21oZuostwAFIj937+AfMwjrp97LtlnDJxb2FF7W667OAkCNKv6RBP9RWvYVl12obL35H6ZpyxRmB3J2tUu9Nrt/Vwtydn529fyeh5aF8Vcn9TmirNxZuDuRNWy699PLdb07SFgEFl/u1Kc8YpakmNLAiBOvH/9bnG6mD6Y0zAPNna2qDHr+irNW+f0ntf/2Y0n9cOM8IyjOSGU9k3NES4dbNZSvsuJpvO+7VfIcsLMg//vD/vsH0fbO1AyVMVIef0HmGaYi6Lprbfc/igaAS4+2IU14thqWSclAaa7LILXAUxHwfoHi6XMubrDBpnxXVoHaPqv+DmHACMnt0EMoragNtqV9KJZpieIWlVQXIPJz2F7P4Dwb00dma1gSPr9W
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(10067099003)(56012099006)(6133799003)(3023799007)(18002099003)(22082099003)(921020)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Nn5et8h+bN2BQuELI7PCo4YkCLDK4sPi+Q/FsLFcTKCZEeuJErCUcY3tG+vGTfINciN9tYLNpDTlRq431smr5wtPd4083gmCy0bnCKu2BnMruNnwlzKmvs1ZImgS5iOQLCjibuWJvdUzuoDYk6Zid2CiNP2Tl7MjjfaMiDlObhvEcApLK4zLBD9hVTkaJSl8zJOvYVLlM6cmVv+A/FKzYOsz/X6qaJWhxjobwlw7MCRSRVmVzx8SUTAKY+vzYez7hnkVVcp24UL5c/DjwHYJBM9x/12IpDrdGXBc0Mrhhz2VlbAQaQrwmI91Xw7KFL4ppVFcFjLLGKkvsS85qRhkrUks5OwEHYb60YXJfpSxSTI5M8WSZgFsYK1m3+UpBM61/D+HOHkAmHRcJWdB2Ivb8LleIEFSuOqIpnorcs61WxQwWHF5VciIWi6FqiwQFneZ
X-Exchange-RoutingPolicyChecked: spEP28GAcVyVm/pKElEw+9G08TI9kgXUWd1jMRwL9a/e8cmv5RdcPvX9KgGNTkwjO0nLluAKpzPliTEK6eGkAYLtWb1bKZ+DWtXT4kHt9KmtmUzGW4oasYXJWlLUm6AZGeea5sDfa0AoiwCMoLSi+ienMQuk0UB7h2r0q1H2B1+NnqKfkmexKh/J2dMJg5T3Y7iQ6lDekuqSW/AZkC3onUYv1tCyH3T4L807istkLQMxI8OG33FGzHNMGZ99Ir3ATy/hH/FJUb0Q3h8quPMsYx2f/ugoLeSJT579ZQEwwHlorE0beiJeyWvvjksYd5p7YClfXNX0mmspcKqtzSUa1w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:25:09.5250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69d6a558-8f36-4a68-34a9-08df1cc4a9b5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR10MB997692
X-Proofpoint-GUID: sNFqYFeupT5wrKuzu0fOFH_fyC0aFktR
X-Authority-Analysis: v=2.4 cv=fKysTpae c=1 sm=1 tr=0 ts=6ab95fef cx=c_pps
 a=g4Zu/129bcKSj1q/f/8ScQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=YmX860EEAAAA:8 a=LBxWy3usAAAA:8 a=gEfo2CItAAAA:8 a=sozttTNsAAAA:8
 a=3-E89_k90uRfBEW5-WMA:9 a=BeCehlkWaqzeQ17686bl:22 a=4jSGKt0uXjqk0CpsFuVH:22
 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: sNFqYFeupT5wrKuzu0fOFH_fyC0aFktR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfXxVvaAyiLOoeZ
 /PLHkwu3NC+wVD1xinsPs3X/UmXD7XMwwXPgoWuesU594WYkIrKA93gmW9+U8iTnmPU88paCDi0
 qxQ+N2BXVuHpZNv+QO3pG2YV3RIgqkE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfXxSRn2mTK1Q5s
 OmTTiQkNTeeAVNZP3inl4TTofQL3BYr/hkBPu/O+7Ag4p+kcaqKZZzfh5FcqMAtSfSEiCJ6/a9g
 t+FFyJTtDccCKbZsBEiJfubhy6KHQtyWUkqWogPzWnrIWz8COQshsFMvtYOh03WgX8F/5d85A5w
 DY3QtFqnzavsV4R+V7U1TQ3O4xOV7h7UcLVJAqZllWULTNkbTnu5g86O+JGcj3aw4n4SGePHABZ
 yC+wPt7yJJKhMKFgZIhReNmqU2gE1cgOXKijsbSxu9c8qjMZCslvjxCCKgTHJHcelxS8juLzUzS
 PfrW57hr7R8Cb02SsLWTcu5nUFVcvdJzx819fhnjlz2oBUrdzP4pWxtf42MbPeuspZfSIigZEVT
 hfnVV+bE4/BSIYuQfRQZ92hBfNld6B7nudXAoJg1Q8f14rf/Q1P+zkfIuKDDB51KwKm+OOJgXpr
 85GqjWp+R+dMEc4L0+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270073
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

Add device tree binding for the Solomon Systech SSD16xx family of e-Paper
display controllers (SSD1683 [1], SSD1673 [3], SSD1680 [4], SSD1681 [5]).

The binding covers the 4-wire SPI interface with required GPIO pins for
reset (active-low), busy status (active-high), and data/command selection.
The spi-max-frequency is capped at 20 MHz per the SSD1683 datasheet [1]
which is also the maximum supported frequency amongst the family.

An optional rotation property allows static display orientation to be
configured from device tree.

The data/command selection GPIO pin is also kept as optional since various
SSD16XX controllers such as SSD1683 [1] support 3-wire mode too with
data/command selection bit transmitted as first bit before sending the data
sequence.

The first supported compatible is for Gooddisplay GDEY042T81 which is 4.2",
400x300 resolution black/white e-paper display using SSD1683 controller.

Links:
[1] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1683
[2] : https://files.seeedstudio.com/wiki/Other_Display/42-epaper/GDEY042T81.pdf
[3] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1673
[4] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1680
[5] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1681

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes from v1:
  - Added fallback compatible for the controller
  - Wrap lines to 80

 .../bindings/display/solomon,ssd16xx.yaml     | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
new file mode 100644
index 000000000000..b31fb862de04
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/solomon,ssd16xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon Systech SSD16xx controller based e-paper display panels
+
+maintainers:
+  - Devarsh Thakkar <devarsht@ti.com>
+
+description:
+  The SSD16xx family includes e-paper display controllers (SSD1673,
+  SSD1680, SSD1681, SSD1683, SSD1677) with integrated gate driver,
+  source driver and timing controller. Different panels use these
+  controllers in monochrome or 3-color (black/white/red) configurations.
+  The controller uses a 4-wire SPI interface and requires GPIO pins for
+  reset, busy status, and data/command control. A 3-wire mode is also
+  available where the D/C bit is transmitted along the SPI data line
+  before each byte.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # Good Display 4.2" 400x300 monochrome e-ink panel
+          - gooddisplay,gdey042t81
+      - enum:
+          - solomon,ssd1683
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the RSTB (reset) pin. Active low.
+
+  busy-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the BUSY pin. Active high when the controller
+      is busy updating the display.
+
+  dc-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the D/C (Data/Command) pin. Low for command,
+      high for data.
+
+  rotation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 90, 180, 270]
+    description:
+      Display rotation in degrees clockwise.
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - busy-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "gooddisplay,gdey042t81", "solomon,ssd1683";
+            reg = <0>;
+            spi-max-frequency = <2000000>;
+            reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+            busy-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
+            dc-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.39.1

