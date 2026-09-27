Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81887C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:25:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D811A10E65E;
	Sun, 27 Sep 2026 18:25:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pk2+RXMx";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nbUkuTH+";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D25FC10E65E
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:25:31 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68R7liCr2775474;
 Sun, 27 Sep 2026 13:25:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Zk5ZK1jJOBKWYuKAqsVl+kiH9F3VUZrd1XcyUEla5
 3M=; b=pk2+RXMxQoTeEAWCEVTeKK+W+Wi7LuJ7sLF++7qxjpMiBHzYg/w7EnoYi
 wYv6geYxBTCAhKdx1cb0Cu+9Krk6IWoIlqeUQubLmHkWVU1VlCqNpxPA2clupURl
 9sQWSwMH4QfZBzAWnmLlZ58JPLQL2QmYNdwYDj3T49QbLUHtc3AjsKPsU832dwN9
 FtQ7WK0fcCc3fGQ/qbL6b/XHZo7dCFjoCt9640mgknUarafFAui6Tiz3YH59nzmU
 GcDLlg0Mv+WQCIUVyBBaSNt/MwcMEi1tjc9mrPmP5m+MlST1zGI6VIAMjFUADEdU
 zHslCVPB8y0EdribVWvtpo56BhoMw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gxy2nhnyt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:25:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFpjwpSeULmnYP6VbmxlAaU2GuhoWaKXmvlNqlTXv29RtH8aJtk5M/1DxifcxtTbg5nNPAUZYCcLV8OUtDfZLR5fMIo3AY+XH/zZz3GG54yMTk0q1iwEzjigto7+U3yHT1K4fHBSJ71RL1YK3Sd4cXWlMNtuRfLaBLMAhIATzhqEpIK5nK/nvpNySjjUbj4vEhicQX6o7y4gGbXnMYa+ZUhj54cBeQqpv8+dPKmyBPRykAWNMCieey0S4dWPQIJi3EsRHN3C2SeKvZVauP+07nYvIVLJC3X4/8zoq9F9Vl89YT1R6H9SuAvRC/7PGHuFQzFcLHHHvmglISsNFG94iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zk5ZK1jJOBKWYuKAqsVl+kiH9F3VUZrd1XcyUEla53M=;
 b=FL1uXkPWEus2+VzAw3wdNQRxHyFtMU1WxUTnwTIfjOaSi3K+oxGZtQKyL0N/x+RGOjx9/zEStEUuLS2DpIay/DUahb52Cq4yp2lOq0MXTHx83AP+0i+9kRskJKhV6X24ST12tX/CL88wOH2A/Up1yaP03p+iI+0HG81v2uHxuQNMJtRRK+Mq7K7aHPU4zGPWFLS4uxnqDvw+e7lb+PgRma51zJ+hX24eY2AzimdQk+r96gRN7zng9VotSfW0q3VH/629yhdGjg9noTQWkuWNA6oDH21P4bDDXDyj2eQ92rewCjwCj5D7pQi7h8TWDFT408P7BlgyMQfJEruPPkgBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zk5ZK1jJOBKWYuKAqsVl+kiH9F3VUZrd1XcyUEla53M=;
 b=nbUkuTH+yVA8er86092Y7s4so9LvRfNuBT0G/A5IQ5HsaFNqDPJy0O9PyoTFfHMP9kW0K5AckhpdiyIXeF0y3OLQyS/cfbyvGBGDjLNnSki+iUmesDmBzTDNXLkdbnvnW1op1Fw6Q96//CgxQXMfYFT5v1mSrWPgGTVGCkDyRWM=
Received: from BY3PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:39a::22)
 by CO1PR10MB4401.namprd10.prod.outlook.com (2603:10b6:303:94::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.7; Sun, 27 Sep
 2026 18:25:24 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:39a:cafe::79) by BY3PR03CA0017.outlook.office365.com
 (2603:10b6:a03:39a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Sun,
 27 Sep 2026 18:25:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Sun, 27 Sep 2026 18:25:24 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:23 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:23 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:25:23 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RIPMMh2547687;
 Sun, 27 Sep 2026 13:25:22 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
 "LiangCheng Wang" <zaq14760@gmail.com>
Subject: [PATCH v2 06/14] drm/solomon: ssd16xx: Add support for Solomon
 SSD1677 controller
Date: Sun, 27 Sep 2026 23:53:21 +0530
Message-ID: <20260927182329.4193961-7-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|CO1PR10MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba4bca1-5ceb-4233-b005-08df1cc4b25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|7416014|376014|1800799024|82310400026|921020|56012099006|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 0J8NTj38wvwjgWn1lhGFAoCPnoB7sAjPvz8sVIiiqKtuW+r041SN+HL/F2gNP2Fk4rrTxZaa+5QqiK3PC6+Ob9k7a5R+PnKF93lEt1YOcyTuFamFPbe0UrxSMhnfD1h5LDMzRkhxsiynHGv9s5lJ2l/b4ZxYa2uIq/16VAyYKjOjwuCayCprXoLAxkGrTEXCXxMV57e+1bjGJhIuV+d6vXE39B4Heca+BOhhQKUitI8fNNOG4pYBiAARPTu1ULOCjcE+i1xyawz38kMZFoMaMiNMvGMFOvllS/tg0qjf5pzyCPG6erUvyTLYLgjfe5BnIEGYlDXUXH4GKzOZEEF19CEJuLhwPb1sjNhPyFCUeuNlmugRhYZL8/TmLSUaq/UjNE/1djL5cf2a/6AyZAuVwxavLmKMpcMw8MWJR8FStLCZDNwnAz8CxhS/Ut9fwwt/Ws2+YSREsD7bqwJeE8ni4+YdlR7352cxWYHMSESahmtbBQYDIkNyTWvkt4qt48B7VP/5YISC9zMzO6vPDU0fY1WoNWITEyhRvpuZv93THw30QvykGaWJs1gJxLmMDzfq+VWIYN8gv9JnbIksnBEkj89UwQjOrqUVuGxMy1iU44KdjrpNvJeA+gGws6+bR73+BwrTBKPmy21LaMK9WKR3Y1ahp48ziODUpujBvei9jqVJSZBQBAk+3H0W9t9TnTmD7mmgF5Kd/SWtfEletpN6eEse+3XE6d6XnHlWGXXce6k9gY3+NeKg+/UiyYMFahjd
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(1800799024)(82310400026)(921020)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: A5zKNSb9EAOzMtwtBxpzdIklH7kvw/Zn8M1m1rx/tSVEd5rFBzKOyxu2gPoEjhBfupPIy70a/KCl9XnU6WY/Tx/3Mq2ntsZg4o7ZyEJwyyy1NDatLCysrBow9JausD7ERgVC+1Mv+x0h6x20ch1SPbV/R5Ci/J5dLRLavNaIcCAGFKuPnZ+6fFtQaKNUPOO2ZXPyLo+M3d/pmjum+ouq9U+uOEg89mJvOg4f9C+DToqCFw0l3dKXJC7EdqYo2PVtkPftyUK+5W1abrVKcJ11L8VYcByfjkqIoO+9tkjTYuHNwgQTorvF2xcG4DSd+7p7ERWtFPe2WDhOCjDtsplht7sMGciFTcqjt3R6bVAi4zv5uUZBrklmi9amGWa6/dEAFWL7FXxMP3G5qwOYSjoc7u0XFaI+2NeHt0FJ2REUgX1jkN1sGxkvRo8uRG25gNnY
X-Exchange-RoutingPolicyChecked: RrWxaeRSgh4fZlydMbW1h1UDNwsy8tgaGBjTlACBocDafYqSIFzKKCansyEjO8Y9gcyJVDuCaIdkkL/W7TbwEaHz68CUARx3oSUgnR2znu4maoj3493ofBPrNgG+fvy9dLpUckiRQ4sUZrPoRkrH1INX8m/CTk1geSmKJDnbYPjcmjBTiEvHJxDRs2BaQZ1mwfw2tbKHdvkXNrX3Q4sPF6hsiQnEDe2/21wxqtAtLlq7E/eL0cYsZBPquPCgoiqF47Cwckzv17bxDCykNsySFuwrtIyy8UfWUhplGCIev0VskSg7lWIC2jkQcO+9fTRkNwotoEz/8B3kvhPhb7BL2w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:25:24.0095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba4bca1-5ceb-4233-b005-08df1cc4b25a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4401
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfXyoc7s6KNK0No
 q7vCHDF6EVhiu3IRx+PHChs/jYua4oDqTXAN5MsnfXlq76qgnlA3oLHtCpKCE/0XpXChBGI9Oda
 EXF1pJyBbIyHfFKlhUpCAn1+1AmZ2nU=
X-Proofpoint-ORIG-GUID: s9-Guv3d4CRSW0P9UTdpm_mCU9p4OHtN
X-Authority-Analysis: v=2.4 cv=RLgmjIi+ c=1 sm=1 tr=0 ts=6ab95f97 cx=c_pps
 a=HLJbjerEQdjma44f6ZsklA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=pGLkceISAAAA:8
 a=sozttTNsAAAA:8 a=3a6drhr0ejtckb4QK3cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: s9-Guv3d4CRSW0P9UTdpm_mCU9p4OHtN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX82WNMTXacB8y
 kdGsm3TDwIE1ONCJax0lLB6Ehf2l5+fUrSla/aSBSA3goha/4LucBLh1XNKigYdWgy49A3MlDXO
 dUjq8jIwfUKhUEkotUUwlihtQCllrn4MSGD6pfv81ZPAuIAVVcpEod9iw+Rb1nu1LDyHC1ypjLW
 53gaEw6+SKDDzMjLofVAloi46qdYcxqdTGLWSSgRDuKP6PfQhM0JbcqemnL6LYR6qRK4KYFR1oO
 pYqOG18mvPZUgow+VFHqSw5fW/wu1LJIPH2kvQ8Ywur03v/1YvWkaCiA3WmJutefRFojvDDy5HX
 ds7WoAI8I/XFZb3/8jmgLGtFSqnKnxuu7uG3eoJFvZFim+IBzoi+fYBmOvfZ1gYFLzKrCqhh9wv
 t+lzM9o9QNU2+L4wQkU5bHHK+Z8fvB+tuHwB93f7+VRHExOlCIBBPBy47nYmexCBCncUikc9jzc
 sF0DfaVIvzv7y12OZPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
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

Add infrastructure to support the Solomon SSD1677 e-paper controller
(up to 960x680 pixels, 10-bit pixel-level X/Y RAM addressing).

The SSD1677 shares the same command address space as SSD1683 but
differs in several controller-level characteristics:

  - RAM X/Y addressing: SSD1677 uses 10-bit pixel-level addresses
    whereas SSD1683 uses 6-bit byte-level X and 9-bit Y.  The
    existing ram_x_address_bits / ram_y_address_bits fields in
    ssd16xx_controller_config already handle the different format;
    ssd16xx_fb_dirty is updated to compute the correct end address
    from device->width using the addressing model:
      byte-addressed: XEnd = panel_width/8 - 1
      pixel-addressed: XEnd = panel_width - 1

  - Deep sleep: only mode 0x03 is documented in SSD1677 (no level-1
    RAM-retain mode 0x01 as in SSD1683).  Both level1/level2 point
    to SSD1683_DEEP_SLEEP_MODE_2 (0x03).

  - ctrl2 full refresh uses 0xF4 (omits DISABLE_ANALOG/DISABLE_CLK
    bits) per the reference implementation.  0xFF for partial refresh
    is listed as valid in the SSD1677 datasheet; BIT(3) semantics are
    undocumented — included pending hardware verification.

  - Border waveform byte encoding is identical to SSD1683; the same
    ssd1683_border_waveform_table[] is reused.

A new booster_soft_start_data / booster_soft_start_len field is added
to ssd16xx_device_config for panels that require BOOSTER_SOFT_START
(0x0C) initialisation.  The command exists in both SSD1683 and SSD1677
but the tuning values are board/panel-specific; panels that do not need
it set the pointer to NULL.  hw_init sends the command when non-NULL.

Controller limit validation is added in probe: panel dimensions must
not exceed the controller hardware maximum, and for byte-addressed X
controllers the panel width must be a multiple of 8.

Driver Output Control MUX, tx_buf allocation, and fb_dirty RAM window
end addresses now use the actual panel dimensions rather than the
controller maximum, correctly handling panels smaller than the
controller's rated capacity.

Co-developed-by: LiangCheng Wang <zaq14760@gmail.com>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes from v1:
  - New patch: Extracted SSD1677 controller support into dedicated patch

 drivers/gpu/drm/solomon/ssd16xx.c | 78 +++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index c478309d08e9..93fa064cf589 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -39,6 +39,7 @@
 
 /* SPI command codes (common) */
 #define SSD16XX_CMD_DRIVER_OUTPUT_CONTROL		0x01
+#define SSD16XX_CMD_BOOSTER_SOFT_START			0x0C
 #define SSD16XX_CMD_DATA_ENTRY_MODE			0x11
 #define SSD16XX_CMD_SW_RESET				0x12
 #define SSD16XX_CMD_MASTER_ACTIVATION			0x20
@@ -181,6 +182,7 @@
 
 enum ssd16xx_controller {
 	SSD1683 = 1,
+	SSD1677,
 };
 
 enum ssd16xx_model {
@@ -332,6 +334,10 @@ struct ssd16xx_device_config {
 	 */
 	enum ssd16xx_color_mode default_color_mode;
 
+	/* Optional BOOSTER_SOFT_START (0x0C) tuning bytes; NULL if unused. */
+	const u8 *booster_soft_start_data;
+	u8        booster_soft_start_len;
+
 	/* Panel-specific display mode (resolution and physical dimensions) */
 	const struct drm_display_mode *mode;
 };
@@ -420,6 +426,29 @@ static const struct ssd16xx_controller_config ssd16xx_controller_configs[] = {
 		},
 		.ctrl2_load_temp_lut     = SSD1683_CTRL2_LOAD_TEMP_LUT,
 	},
+	[SSD1677] = {
+		/*
+		 * 10-bit pixel-level X/Y addressing; only deep sleep mode
+		 * 0x03 is supported (no RAM-retain mode). Border waveform
+		 * encoding matches SSD1683.
+		 */
+		.max_width  = 960,
+		.max_height = 680,
+		.ram_x_address_bits = 10,
+		.ram_y_address_bits = 10,
+		.has_temp_sensor_ctrl    = true,
+		.deep_sleep_mode_level1  = SSD1683_DEEP_SLEEP_MODE_2,  /* 0x03 */
+		.deep_sleep_mode_level2  = SSD1683_DEEP_SLEEP_MODE_2,  /* 0x03 */
+		.border_waveform_table   = ssd1683_border_waveform_table,
+		.ctrl1_normal            = SSD1683_CTRL1_NORMAL,
+		.ctrl1_bypass_red_ram    = SSD1683_CTRL1_BYPASS_RED_RAM,
+		.ctrl2_refresh = {
+			[SSD16XX_REFRESH_PARTIAL] = 0xFF,
+			[SSD16XX_REFRESH_FULL]    = 0xF4,
+			[SSD16XX_REFRESH_FAST]    = SSD1683_CTRL2_FAST_REFRESH,
+		},
+		.ctrl2_load_temp_lut     = SSD1683_CTRL2_LOAD_TEMP_LUT,
+	},
 };
 
 /* GDEY042T81: 4.2" 400x300 panel, 84.8x63.6mm active area */
@@ -553,28 +582,44 @@ static void ssd16xx_send_data(struct ssd16xx_device *device, u8 data,
 static void ssd16xx_send_x_param(struct ssd16xx_device *device, u16 x,
 				 int *err)
 {
+	u8 bits = device->controller_cfg->ram_x_address_bits;
+	u16 max_val = (1U << bits) - 1;
+
 	if (*err)
 		return;
 
-	if (device->controller_cfg->ram_x_address_bits == 8) {
+	if (x > max_val)
+		x = max_val;
+
+	if (bits <= 8) {
 		ssd16xx_send_data(device, (u8)x, err);
 	} else {
+		u8 hi_mask = (1U << (bits - 8)) - 1;
+
 		ssd16xx_send_data(device, x & 0xFF, err);
-		ssd16xx_send_data(device, (x >> 8) & 0xFF, err);
+		ssd16xx_send_data(device, (x >> 8) & hi_mask, err);
 	}
 }
 
 static void ssd16xx_send_y_param(struct ssd16xx_device *device, u16 y,
 				 int *err)
 {
+	u8 bits = device->controller_cfg->ram_y_address_bits;
+	u16 max_val = (1U << bits) - 1;
+
 	if (*err)
 		return;
 
-	if (device->controller_cfg->ram_y_address_bits == 8) {
+	if (y > max_val)
+		y = max_val;
+
+	if (bits <= 8) {
 		ssd16xx_send_data(device, (u8)y, err);
 	} else {
+		u8 hi_mask = (1U << (bits - 8)) - 1;
+
 		ssd16xx_send_data(device, y & 0xFF, err);
-		ssd16xx_send_data(device, (y >> 8) & 0xFF, err);
+		ssd16xx_send_data(device, (y >> 8) & hi_mask, err);
 	}
 }
 
@@ -691,21 +736,34 @@ static int ssd16xx_hw_init(struct ssd16xx_device *device)
 
 	ssd16xx_hw_reset(device);
 
-	/* Software reset */
+	/* Software reset (0x12): resets command/parameter registers to defaults. */
 	ssd16xx_send_cmd(device, SSD16XX_CMD_SW_RESET, &err);
 	ssd16xx_wait_for_device(device, &err);
 
-	/* Driver output control (0x01): MUX ratio and scan direction. */
-	ssd16xx_send_cmd(device, SSD16XX_CMD_DRIVER_OUTPUT_CONTROL, &err);
-	ssd16xx_send_y_param(device, device->height - 1, &err);
-	ssd16xx_send_data(device, device->device_cfg->driver_output_ctrl_byte3, &err);
-
 	/* Internal temperature sensor (SSD1683/SSD1680 only; not present in SSD1673) */
 	if (device->controller_cfg->has_temp_sensor_ctrl) {
 		ssd16xx_send_cmd(device, SSD1683_CMD_TEMPERATURE_SENSOR_CONTROL, &err);
 		ssd16xx_send_data(device, SSD1683_TEMP_SENSOR_INTERNAL, &err);
 	}
 
+	/*
+	 * Booster soft-start (0x0C): panel-specific charge pump tuning.
+	 * Some panels (e.g. PIXPAPER 4.26m on SSD1677) require this step;
+	 * others (e.g. GDEY042T81 on SSD1683) omit it.
+	 */
+	if (device->device_cfg->booster_soft_start_data) {
+		ssd16xx_send_cmd(device, SSD16XX_CMD_BOOSTER_SOFT_START, &err);
+		ssd16xx_send_data_bulk(device,
+				       device->device_cfg->booster_soft_start_data,
+				       device->device_cfg->booster_soft_start_len,
+				       &err);
+	}
+
+	/* Driver output control (0x01): MUX ratio and scan direction. */
+	ssd16xx_send_cmd(device, SSD16XX_CMD_DRIVER_OUTPUT_CONTROL, &err);
+	ssd16xx_send_y_param(device, device->height - 1, &err);
+	ssd16xx_send_data(device, device->device_cfg->driver_output_ctrl_byte3, &err);
+
 	/*
 	 * For FAST refresh mode, pre-load the LUT once here during initialization.
 	 * FAST mode ctrl2 (0xC7) omits LOAD_LUT on every update for speed, so the
-- 
2.39.1

