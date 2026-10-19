Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BCA606A336
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=qSkv454d;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Vn9khZoD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E4E810E674;
	Mon, 19 Oct 2026 21:39:01 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C2A10E683
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:38:43 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLboVD1358350; Mon, 19 Oct 2026 16:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=4e6b4KT7qmfphTblCoHqELaQBOugwlAyqcg0MkCEA
 ck=; b=qSkv454dmE5GHM9RPxKpkb332XQ70IMWr/Z7dSYNl1kcNzmwWzt6cjiOR
 pTAyePBZIjOSfV/klHjq9ZZDWqLQ2SFIwOrU21obYa+LRQYO0n5lJ9/Qisc2BNtL
 rqubzaEBwrFWnBYK5ir7cUrmtbwwGkibDzIaIGrOBuBC5N5lQxrWa82dGmXLr3IF
 KFSLUIuEC6PqaH7rTRYmMvxrDuQkrVMZQPtne1EFH60ifzBkivuN7jXzqfqcsllS
 J3+yTF+7bYgkjlJV2HPjTLLiIoYoWpaClhN5w+mRfqDs4Yz3wDgsvL9PqwdNTy1n
 +EguWCDfNgXS4YCSbmOyVsYM9xObw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010035.outbound.protection.outlook.com [52.101.201.35])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hcrd6159g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:38:38 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quOSuUkoExe95fFikl/RImIcxdvi+fX66S+oC04hYZjY9aQqU3kp7r9gZfwDQy1l2okfKPRRBwOtAttiKwabKQDkBw8BlvPexoeplUtUDe/4v3lXO2kG1T4O1b4d53MHBd6m78arqaq8AMYkvnkZZkd66I9AhrTXlI+5+4QOiNlrYl6LBmu1kRdhY8sC4oWAU8QDFB2dsgcAaQDN814UcglEX8MvsSyOi3Jx6hKMxumxeyhhSQhZCsCZ58oPqsc9gXGJjftXFM6QRRreinUF/2hgiw9Fzk8+yCb2pegKvZ07HCR9ldd+q6ANXTakVfV7rLZNAnDXJZTh4AzewGIZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4e6b4KT7qmfphTblCoHqELaQBOugwlAyqcg0MkCEAck=;
 b=Q85PNsgEzbuSEvUsHExPsp3tJ0zT2X8HrVrDmoGHSzSIOjyzVJKo0HQ4I+srozyrfERmvT/ZkYpCPwIW9fvqV+9hoXG59ko33FBdo7Vsog6QtCbyhbhxV6KfT0gBd9ezvB9SG6FdZZeyFa7S8r88WVLZed9tRUZsZ7fKNjGc0e/Bsg3wc/RzwHfmAsMhVXCGrYJSqk3op3xNlVmqMveA2WF8PJ88v5JKP2eQkzL9ijvE1koY1XvTwFbiyiFk5tp3mI+vEsmL/XsNUwe/srfp0lC+vtjRsuk32RJPEMaNUHDGPFo0DDNFfk+KGHFBxj9MaumHEhqNB0Qg8Nk0ZHW5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e6b4KT7qmfphTblCoHqELaQBOugwlAyqcg0MkCEAck=;
 b=Vn9khZoDtxfvzed2Xz94NIiDcy/zlfpFk1Ypg4vVhqrzdzZqnBB5WO5YABmmI9u+2krhXnJt4bDEGu9+D2UaiOwO4NUvbPHWa4BIZVzO+ZG5y5Eh6qKszBf3Z2Ey5bsAoCy7Bt4+2pgm857lB4dpKwgCWedbYmqtgBMWS+ypSso=
Received: from DS7PR03CA0286.namprd03.prod.outlook.com (2603:10b6:5:3ad::21)
 by SA1PR10MB997628.namprd10.prod.outlook.com (2603:10b6:806:4b6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 21:38:34 +0000
Received: from CY5PEPF00000E76.namprd02.prod.outlook.com
 (2603:10b6:5:3ad:cafe::1) by DS7PR03CA0286.outlook.office365.com
 (2603:10b6:5:3ad::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 21:38:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY5PEPF00000E76.mail.protection.outlook.com (10.167.247.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:38:32 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:48 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:48 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLblQw3577094;
 Mon, 19 Oct 2026 16:37:48 -0500
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
Subject: [PATCH v3 11/14] drm/solomon: ssd16xx: support panels whose RAM X
 order is reversed
Date: Tue, 20 Oct 2026 03:07:23 +0530
Message-ID: <20261019213726.4145532-12-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E76:EE_|SA1PR10MB997628:EE_
X-MS-Office365-Filtering-Correlation-Id: c90bd10e-7a66-4e0a-1442-08df2e2952cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|36860700016|23010399003|82310400026|921020|56012099006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 1gVRIJmjq8KA2KCwW8tQr0PK6tbrOuzEDCZw0R9y1L87+oh5Zvm9Y9Nt4M3yD1hHRGSqlnekdkDeoA9C2GxYaIi6rLqVXyjfcRyQ3xjknpvWnn28gMGb/JSPAtBuzl0zR935BxSmNtJF0hA6kcLdv4kkXRyZgf5i4xvtW+sM6k+ivm7rpPzSQLiQq4sJ3JRqw3QMbu4IzC4VPxEoDesjhKDVcAaR81ucwio0oBBO+pW+KbGlBkrt8kUbM56Gl8l9ZzQhfsnN5fFBrltixkJe5DFPPpmNC4xRSx0AHVVEe/szp5wWWQ+hKV6TUjmuPKnvDvwE8NZ/etEDiidWqaBetlbGN4RFv/qJmueHn8rlzyaGEQsZmwwZNmy91YQ8nUYmouDVC3F9PauSvsfptyP2AmnLD4WUddKr9jKs96pB0dlT/ei9ngwtDR8sLM8npUYL4ChUgNk+tzeUzksp59IZAloRLIHdLa9vsee+UAVF1fOf+XzaK6ufpNVkdrIOYjTo8ZcsDImAs/sPf+ghksePw870Ehq7ZwJRUjzXuCmE/spfundcFjTR1n+SfLat/KNaD3/RKV3SW6pNQQwV2FsGHM30ToirYsJa0KYO+dlWJIm8ZVmPqO6N/oJOCXEW4FeKr3XwJDZPwPa7J/10nH2oNPsD1PQwnAadoUCxNGCGGwFpgJBJfi29tjK/7Us037rbei9v/GvVtslFIZl3xChHbz2gUAdHOCsbt6uaLEQ6owOp39hBgOnXYEtxDsit+f3/
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(23010399003)(82310400026)(921020)(56012099006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lApBme4YRoNxuh2NQNpYe6LBH9jNnb/aob/FsZ0pbQDw90ZIBtNHNQiTJ+5lBMQ+KlPtuUHo8dUBtMZe/pOHLHLf7IhdpRFGf/yqxhr2PBJHrMB8+dogQ2xXk+uHaDolqiqw1puixK7A+LiM4SjWsTiRlJXeq2gfb9yVYJrRXIaFHrUPJgyAA71qhHGt0BpvPGrOkBCn/mbuktFgJuSs8S2vYMuB/BMla/8FFF3Zd1F4QAYZDIGEjFXg6FB00ge3/o4+8j3K4spQKqNVeus5J0CmgUE5F5hFb5bOCOnrpFu3Qs6C0rShPiR1+VuIBbkobdSTG6TFegGA1J2zXJcJUiOIYqfAT7/LrkCsMQela+V299AvxyUlfeRG5jQjjPHHNhgszk/cWOllsbFFwQdLwcPCOAnOegUTvlhVHyA4rUqcN+57lXf4mufuxRXf8ytD
X-Exchange-RoutingPolicyChecked: 1CIJ7mTYs+qXoWOeNKhqwbvO5//FEMhNm1TXmOMxtgavvXYLeIE5Z6SXXZnX7r40KLtSeBObEzIqhVK1H8Th4UjxHWqxg845noM3AsDvJBw+tD/GrS6LcNq+8XC/lAS8uBSsUye0sPoO30g967CiZc1c/GBMDI1eBCOPCFsPl4Jw48YOlEFCxqmjWnFN47tHz1foLRaqmMQOfDu5QsSbTNAmOTxAf9tHDzVFZuel4gTNb6rkYoF78iUQ/2AUbcl/sXqOGk1EpwYTArwTC4lmdEg4pWM75i8mVQDRSiWcUudSKwulst16nHLjMAenf7pVOMFXRjErWW2CWtmdj6klYQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:38:32.6746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c90bd10e-7a66-4e0a-1442-08df2e2952cc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997628
X-Proofpoint-ORIG-GUID: x5B9ZkdpTUGZygDS-at8cZsw7lYppD2H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX71cmqpS68fb8
 spdu/P/Epq/dc3N28G8bWnQHUtx0oV9zUAxXlrtiPJc9zgrdkpSr1+pRr9JaCulRSFltRisie63
 KI159RGsZ22zgfrHCE3Fa2Mh+/4SI8RBrdAp2NvS7+YzUWmL+1KwgeZ0KJVurjII64DfpK35P8V
 fLx14aYivZ+cbDMUubdTG4mzdoKaHOrfb1XCq9DPpHfDgIcCsPMCHEIcDv8+JslbO1TFI5FJu0P
 BbpsgvS/wC2TrkiW8mvyqAhgc762C79MJ+2cwohyHRHaCA2cl3N67BRXQ8Wn7ozHZweSlXWiQvM
 pcXYWLqg8ZpmpTpCAhUTptXaKzxHCMlbgkpxVejOtQT4FvB/bx331UEJW9dWB3mjFkazPwrZfQe
 cgm5QPawP79Swg2UdV3GuDSjiwgEvVbeQDsB+1AUyn49OTKd2jZttl1QZkYZgVSA8uDlIx5sUaz
 u+br//T1XiNkgQM6plA==
X-Authority-Analysis: v=2.4 cv=ReYFmFtv c=1 sm=1 tr=0 ts=6ad68dde cx=c_pps
 a=gTn3qzDU66SAkKtIq75K5w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8 a=UpfALD_kB0Hx50bdgzMA:9
X-Proofpoint-GUID: x5B9ZkdpTUGZygDS-at8cZsw7lYppD2H
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX/tWHIXYdfoEY
 ohn1Xw88B9r+P9Ugxf/dVhTa1L9xNwYHyt/VzbmjKUOLKlgqH29hTTntT1kBCnj2SSwH04TYZnl
 5xSQYWa1KgwVaWDL/e12Ax6HVBi1clo=
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

From: LiangCheng Wang <zaq14760@gmail.com>

Some panels have their first column wired to the controller's last source
output, so the controller scans RAM X in the opposite direction and the
image comes out horizontally mirrored.  SSD1677 offers no source-direction
control that I could find - command 0x01 only affects the gate side - so it
has to be handled while packing the framebuffer.

Add an x_mirror flag to struct ssd16xx_device_config and honour it in both
branches of ssd16xx_convert_fb_to_1bpp(): the scanline order in the
landscape path, and the inner loop in the portrait one, which is what maps
to RAM X there.  The DRM_FORMAT_R1 memcpy fast path cannot mirror while
copying, so it is skipped when the flag is set.  Enable it for the
pixpaper-426m entry.

Tested on a Mayqueen PIXPAPER 4.26m (SSD1677, 800x480): a pattern with four
differently sized corner blocks renders correctly at rotation 0, and a DT
rotation of 90 gives a clean clockwise portrait.  Doing only the landscape
path leaves the portrait output transposed.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes in v3:
- No changes since v2.
---
 drivers/gpu/drm/solomon/ssd16xx.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index 13bd825bf3f1..29dca237378f 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -355,6 +355,9 @@ struct ssd16xx_device_config {
 	const u8 *booster_soft_start_data;
 	u8        booster_soft_start_len;
 
+	/* Controller scans this panel's RAM X in the reverse direction. */
+	bool x_mirror;
+
 	/* Panel-specific display mode (resolution and physical dimensions) */
 	const struct drm_display_mode *mode;
 };
@@ -517,6 +520,7 @@ static const struct ssd16xx_device_config ssd16xx_device_configs[] = {
 		.default_clear_on_disable = -1,
 		.default_refresh_mode_init = SSD16XX_REFRESH_FULL,
 		.red_supported = false,  /* 2-colour black/white panel */
+		.x_mirror = false,
 		.default_color_mode = SSD16XX_COLOR_MODE_BW,
 		.mode = &gdey042t81_mode,
 	},
@@ -1161,10 +1165,11 @@ static void ssd16xx_convert_fb_to_3color(u8 *bw_dst, u8 *red_dst,
 static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
 				       struct drm_framebuffer *fb,
 				       struct drm_rect *rect,
-				       unsigned int orientation)
+				       unsigned int orientation,
+				       bool x_mirror)
 {
 	u32 format = fb->format->format;
-	int x, y;
+	int x, y, i;
 	u8 byte = 0;
 	unsigned int bit_pos = 0;
 	unsigned int dst_idx = 0;
@@ -1186,7 +1191,8 @@ static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
 	 * if not, the generic pixel-by-pixel loop below handles non-aligned
 	 * rects safely.
 	 */
-	if (format == DRM_FORMAT_R1 && orientation == 0 && rect->x1 % 8 == 0) {
+	if (format == DRM_FORMAT_R1 && orientation == 0 && rect->x1 % 8 == 0 &&
+	    !x_mirror) {
 		unsigned int src_pitch = fb->pitches[0];
 		unsigned int width_bytes = drm_rect_width(rect) / 8;
 
@@ -1208,7 +1214,8 @@ static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
 		 * The data entry mode and cursor position control scan direction.
 		 */
 		for (x = rect->x2 - 1; x >= (int)rect->x1; x--) {
-			for (y = rect->y1; y < rect->y2; y++) {
+			for (i = 0; i < drm_rect_height(rect); i++) {
+				y = x_mirror ? rect->y2 - 1 - i : rect->y1 + i;
 				if (ssd16xx_pixel_is_white(src, fb, x, y))
 					byte |= (1 << (7 - bit_pos));
 				if (++bit_pos == 8) {
@@ -1234,7 +1241,8 @@ static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
 		 * The data entry mode and cursor position control scan direction.
 		 */
 		for (y = rect->y1; y < rect->y2; y++) {
-			for (x = rect->x1; x < rect->x2; x++) {
+			for (i = 0; i < drm_rect_width(rect); i++) {
+				x = x_mirror ? rect->x2 - 1 - i : rect->x1 + i;
 				if (ssd16xx_pixel_is_white(src, fb, x, y))
 					byte |= (1 << (7 - bit_pos));
 				if (++bit_pos == 8) {
@@ -1307,7 +1315,9 @@ static int ssd16xx_fb_dirty(struct drm_framebuffer *fb, struct drm_rect *rect,
 	if (red_buffer)
 		ssd16xx_convert_fb_to_3color(mono_buffer, red_buffer, &map, fb, rect);
 	else
-		ssd16xx_convert_fb_to_1bpp(mono_buffer, &map, fb, rect, device->orientation);
+		ssd16xx_convert_fb_to_1bpp(mono_buffer, &map, fb, rect,
+					   device->orientation,
+					   device->device_cfg->x_mirror);
 
 	drm_dbg(&device->drm,
 		"fb_dirty: mono[0..3]=0x%02x 0x%02x 0x%02x 0x%02x (data_size=%u)\n",
-- 
2.39.1

