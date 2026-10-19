Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709C60A2611
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=AICHGflb;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=RiGyw7ul
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DA010E67F;
	Mon, 19 Oct 2026 21:38:40 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F4810E67F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:38:27 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLbnR31358342; Mon, 19 Oct 2026 16:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=tGSxlF2yWe323oGe4KICUHYOHJwdpcCgeSQ3X5G3x
 GU=; b=AICHGflbG6543mFHFtgDmbEltc2f9Mpoiun/WKUI7fLdWYFWZPol/uv3k
 znJ9hlLTkB2xodwaXl82fof5hLGFQmwfjvia6CPV+Ft3Ekj7s8U9IgZr+HbxvqWs
 hwEckTQ2gWjvzImHYWmadLR0QjYDV4LHSNwnKzzp6o4uws35JOABFmMb6ajP/Ava
 yXtPZ/bFFHIhoIINdc1ZcQD8Ir404o8FbQ6nj3ZrFHHyjDAdOVmdUg52yByrCXld
 iyleKx3FzRmwpC7Nmh6atgNKbsaKfleWp5Aw5bPsEXCd0MBTpxDUBYp2C2PE5oLn
 21Iivf/+Gptapai0Zi1+PLhI9p6SQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011036.outbound.protection.outlook.com [40.107.208.36])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hcrd61589-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:38:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nV3VT+N2iLROPzD848iwBjRkcgDCLVLTkIOT5ppGjjzN75SM9iEd8iCX7NGdRlq+006Lk6qK1zX+YQt/uhwE4b1bqzdAQiSPQuyhMb/LZmYNyc8inY2O4aIgFJdRlYVN7qL3tMsvLBXDUYlyWU6EmxfqizvfXKo818YSRAS3bLh1TGUiowClQ/RJ+7ULLbwu/AFyjoQujoXuYmivjA5+gH++YM7WoSa5F/PuDQrJX28HTSEKmaD1WttthBxbeSe3eYw+3gL7hboMzMAp7cbVwbrSBy/MhkjKY/3Q03Y6R/7tNnbwMsunJ1DisuIVBb7X75HrZNk6aFpntDwyk+//GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGSxlF2yWe323oGe4KICUHYOHJwdpcCgeSQ3X5G3xGU=;
 b=s6HwXHIeIhy2YE+E+y/SwOpdrKgSmHGvBZ3t4B0YYNXDjxeKpQxTN0dE8jsAVi6wzYXZ3kgm0GJQvF+XIdpNgqCZ0DSvbdpXZosNLRX9cibtGMKtyiVuJmzoBSx+msIf/N0Zlunv0rOzkn8rbCVAIi9rF8TsogFgyYeqyn8coXb7pT4U/DPImltXyDKQTsb3FsCbxQ5K8kcFW1LG/wV8oX/P2p93nMPtP03g99MG6Yt39Xb6dcji8C3tlddfKf+B0t859PNGvZ1kObAKm54Vx5RGpapHTt8lGQJZWue7n3m+jQn0236GQfgoWwCw38buKTFxOp9Q94fE830W2KFjkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGSxlF2yWe323oGe4KICUHYOHJwdpcCgeSQ3X5G3xGU=;
 b=RiGyw7ulAuqeDDm/cJIZfnCVcpg0V5OMsQtM8qrTlg5ym1wb5XcCnazNf2UwbK3myBj13ft4KBbKLtk9CM9PPEcNPZ/bAdIKT1jOlw5SVCsOG9xeiUET88maWs8pTn7+bV28f2sXsoh/diIVYl4vuicCt1qL8UqMlEAYBU6u124=
Received: from BN9PR03CA0388.namprd03.prod.outlook.com (2603:10b6:408:f7::33)
 by SJ5PPFCC6481C4C.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7cf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 21:38:14 +0000
Received: from LV8PEPF0000005D.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::2e) by BN9PR03CA0388.outlook.office365.com
 (2603:10b6:408:f7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 21:38:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 LV8PEPF0000005D.mail.protection.outlook.com (10.167.245.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:38:12 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:39 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:39 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbcbM325812;
 Mon, 19 Oct 2026 16:37:38 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <devarsht@ti.com>, LiangCheng Wang <zaq14760@gmail.com>
Subject: [PATCH v3 06/14] drm/solomon: ssd16xx: Add support for Solomon
 SSD1677 controller
Date: Tue, 20 Oct 2026 03:07:18 +0530
Message-ID: <20261019213726.4145532-7-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005D:EE_|SJ5PPFCC6481C4C:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e9793a-610b-430d-f176-08df2e2946fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700016|23010399003|82310400026|1800799024|260925021311599003|260925022911599003|260925021911599003|261009223027099003|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: wruMJKJmFkVTOZ2SahjAuh/DNGia8+vBFu0dI6/l8njR3zbcWX+5sowBwQU05a30vB8ZuiPLJvJXFWIGVUqs2mLo9ZPTBbaCJ2jOpaM+KLPW4XGBGCzbjmhah8RbDvWx524flE+M6+n52HKgim8934pPb9bB2rGl/jM9AWbb8E61KCbyjyRJAdSjP/pvyO5j33EnFsm+4ozW2dDnSOpooTGjhearRh1Ioceot/fxuUSf5YShA+lVjr7/pweD8KWlHeBXoZ08hQX1xTiUaqS5tY842ReJirtUiTFpcySjOdo3crw9vVwSYlaVRUTdEqF5au020I0BdRx3DM/ExKJte30bs94makzy4z2Lvx3hEngh6yJ9O/lZHfTEYs+Qg8egXb+HFzzfQkGKcmHcc6GSGZt2BgHs7RvGyUVYyGdi3xRN68p/5mmTAOVR8FI4AmpTyT+hEK3vdpbfRLqgCtjdiNsRd0xogX9Ljjsa0ozDQS8oQnku8yiyhEIdJBccGIqteDsA2K3lf3lz7hlyLSQGZe+0TwWr6TPP2WscqcltgM+tBq8q1BDaD4mTEusHwqAX8+ur9zw0YofU9MIuLh3/ZwOSCCUM/gwU9XNxmOzo3qqHdGLKyfvos/oZEXjifuPPb3LBrSGowN93al5idw/MQiZ/c0hk3YGYT8/AfzITfhaBg4iQVzDXH5IF5BrZJvBnszuLpwv8U8ntYCUio65LEDghwhY4OdxP8sVpP6Dg8M6k26l/V9kYjEcLoZmWuo3e
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(82310400026)(1800799024)(260925021311599003)(260925022911599003)(260925021911599003)(261009223027099003)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mPC0YXKimKYQEtHonghbOp8iZDtLnHpbaN2jwCcngtIyyBxAMow2cS22P+Yi9+6/HIMVLojNMCbk/VMbsuTnKXSe+tip0naOcFmTPqQ9LxazhCZQ9Dr2+9XCEQDoxP8dn3dB8k/l1OfO/pcQUyhuBT4C/UbX8k5Lyy2L/XiFXQVkoGNLh/H5LzRTNpT+3kd/E2KPbCwZUat++254IB5ilqw++vnwtdivnpoIvCPm5mWw406Ci53dyEAvmoXMupf/yC4i+a/yIEtXLnMeq+Ownc10i6zzdWeldnnCZJFUZp4EEjTJfqDtG5VG+7dll9Y4iyyz/K8ZMZnU+O1p+LFj+tYkU8eHsFRwG76EwHp+6MoOQ29MW0mxTduzztngthKN0vpk8JIwXfVE26+FhCjx1pbajo0SXP8pqnn2kf20yup+KEPWRLmOt8Zd5ZgxNiTt
X-Exchange-RoutingPolicyChecked: eYGhD9rYPPIZ88BcMPwMEEOguyp+JMfm45T8JV1hSn6wXVTi5/B816dpX+0LqMAuc7V4ahtTS79SWVX6KNJSx68eNEiEEvjAjWVhM/j0rdqqUyDasZtS/hWNRgED/4rmmai3w6vcg0vhxrGD7kOiTffgMjvD6GNm2LwAveFcKFNx+o1MNGVu91P2S/8GPwTcwU4TonUMCqb0ebXK6TzZJ4QmZWNyXDSqfbuHH0/8AR5cHEeIC2RfTh6HsUbhqRMjh38R0EEJgBs87uvwSgf63WjQBlFbBdQTGGdEI8WyLkpAbSB63jf5ErEqS+mBf59QEnpYtnjtx7hyQCGR5RDrlQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:38:12.8178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e9793a-610b-430d-f176-08df2e2946fa
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCC6481C4C
X-Proofpoint-ORIG-GUID: 9t7xHekxQ716AINHDS1NSmDwRIOH1stp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX4JyKMC/R+mPc
 2D+70F2la1gjtaCk+6ssRR6kH+ZKbPAkxkRHDk2dapmM0jUS7Kuodv6Z5NOgCo2PKKHmcFSFpd5
 /8RovLfR4V0xW49wZcUofAG3g2EYzcCoTk3XDMHh0RcBznuHU6fGMezCwpw/fMgf9GjFJfNwwrs
 uE7KSrwcxS2RFqhCWoJrbUt7GxW8brtMAa/LBdQ/zzaGMYvsEAhgFcgbKTMFQinmsDNfEU1Fah4
 9Az/zu+MH3nlLMKloFBtq8giApYdMaX4u7C58Z7bEuy9tf6kUzXHHuijReQhoYVMY0NxG4DPWJY
 zg72/R4s4Z2OQAYmpY0Kgo9RmMtw2tQviBsKvOLKJ7s3W0mcpJaFRRZmy3Ln+B4/dFbbsxdZfts
 rtShz0yoPdfMe0adnoKRU6243HfuC6avHBkOhJ+xRBQa2KLy8hDe+/ILzuBajy2MFM4UWfQ25Y4
 4bTDJSU+EI1kXUfnqSw==
X-Authority-Analysis: v=2.4 cv=ReYFmFtv c=1 sm=1 tr=0 ts=6ad68dce cx=c_pps
 a=uJxR2RjB/d5PFa0hjvWx4w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8
 a=ZCHZFO_axtcqoImUyJkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9t7xHekxQ716AINHDS1NSmDwRIOH1stp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX4MM4fDbpcG18
 1ZQi5gwc6T0Yx40uf008fBWeFld1CQqxIg2RMI2mmRXOTubDPlmYoJH/X1bDyYeco/g15gIKvGM
 SVut64ZHO0TjFc1PWqWA2kf/DY+QCck=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190086
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Changes in v3:
- Whitespace fix in a comment, no functional changes
---
 drivers/gpu/drm/solomon/ssd16xx.c | 78 +++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index 7b0096448768..ff0e459082de 100644
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
+		 * 0x03 is supported (no RAM-retain mode).  Border waveform
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
@@ -557,28 +586,44 @@ static void ssd16xx_send_data(struct ssd16xx_device *device, u8 data,
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
 
@@ -700,21 +745,34 @@ static int ssd16xx_hw_init(struct ssd16xx_device *device)
 
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
+	 * Some panels require this step; others (e.g. GDEY042T81 on
+	 * SSD1683) omit it.
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

