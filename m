Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D16C98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDDB10E675;
	Sun, 27 Sep 2026 18:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UJxhJ/FO";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SMR/mVkk";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 705A310E675
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:27:10 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R5ddVW2282836; Sun, 27 Sep 2026 13:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=dawKxhttlNPMoKpD65YH6LNBtC4+ddC+SVQzFShCc
 l8=; b=UJxhJ/FOAFDLuetrwuafyxDJ7725iOiPyIz5yRPMyMMEJclOSjmg+Xr9S
 7I+MELuh3DvbO4D1dEFJXkJ4p13FodIp0e63/YRloQKB51vY0OYjcIaDFDHML4uQ
 gCKvwEg33dnKn66Uq3sU29WJlNHrKs0Ke4pm3OHWXxZXRFR2xqC/IoebJfxHpOmM
 5vsKki7n8ZnD+b52TZcYkZ9sgfYX/s0LH9+WIBGzYwHqH9WSJ/jh5u6FrTRN7bpN
 HkrSVQ6kunOJQ5kwOWt1xNJtjjz+QOdfSnvr7F90dnnSwBG6AIzvXN41X+RBj2KK
 2YhR399TLeE0QMQBb0e1Ix10HL/FQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gxw6nsy91-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:27:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfCfBKtx5GUAYwwI8S09LKD2lmlk+mT89J4g+xQiydq0kcRKGM07/bfS+HOPb9U+n2ROveEU9ZAJ82Q4AaAiIBeq0bZzbAu1RpaH8vGgJa10fqSBi78HAjzf4WIDK0/ILQrWUOjTABp6Crdo6PqAbgsatuenokWcRF1lKjMGtrIzjkK8cpcTMGCXzRCv3rbRdoDvWZD4wtGaqbvx/aF5YyEeVe79Si2BXYwww1KDjdLWjK+RVj68mVkBy0z6+O0tYtG8KwbC7HnD6EPxqsrJBbby7lRS+1ef8Xh5vY7B8U2HhRuvmpGKbmHmRweVZ+eML0pyNLLtQnBCxSZRLsB2Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dawKxhttlNPMoKpD65YH6LNBtC4+ddC+SVQzFShCcl8=;
 b=ViZz2ozwhJq2XIUezAVtmrPgm1t6y2nIKJROPcEf/DqWBm7iTxnyQPh7YH71RLPmz7nUU0cE1apdCwUNBCUqIUSehtyR1cv119XO5PLwcMxK6Rb6q1enJY33t8Z0+JwEzCfeOPAoMkbaGAU5o0IyNy3+6XHlcwDzGxA4MMiO69eKkVM8Po6M5dt7i7qu19eSD0qtKri0tSOKqfNHsc6nbhbGzCNh4CzZlnuB9iN42dshi8u8uWf9nxMq3vzh/sizab9Hh2MnmUl8haUxwnfNMOzClnG15HVL1/2XVc0tPDU7rP5z5t4vzfEXzyibR4Bc63MxZdbv5fFWNOzRma1vRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dawKxhttlNPMoKpD65YH6LNBtC4+ddC+SVQzFShCcl8=;
 b=SMR/mVkkXsaErhjLTQ8jG3d1Sn+OoqYbA3SQyrTkWG1dChp1Z+1ktgYG8TyFCzbOdTw+ny5CzOzCI9GRRoL9HC2wIVUH12XWuosaRl8/3xAsWKyGpmocOznCs2qGYH7FlnaNOcG7EJB+uqGocj5AwEq5y4G0M6C1H1zyg9DNsKw=
Received: from IA1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::15)
 by IA3PR10MB8162.namprd10.prod.outlook.com (2603:10b6:208:513::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sun, 27 Sep
 2026 18:26:19 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:461:cafe::6e) by IA1P220CA0001.outlook.office365.com
 (2603:10b6:208:461::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Sun,
 27 Sep 2026 18:26:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 27 Sep 2026 18:26:18 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:46 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:25:46 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:25:46 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RIPj5p2547966;
 Sun, 27 Sep 2026 13:25:46 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, LiangCheng Wang <zaq14760@gmail.com>,
 "Devarsh Thakkar" <devarsht@ti.com>
Subject: [PATCH v2 11/14] drm/solomon: ssd16xx: support panels whose RAM X
 order is reversed
Date: Sun, 27 Sep 2026 23:53:26 +0530
Message-ID: <20260927182329.4193961-12-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|IA3PR10MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: 5826c56e-b7cb-4dd0-903b-08df1cc4d29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|36860700016|82310400026|1800799024|921020|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: I/DDSpggYCfuwzuDse3z/Vwj+T+untXIAfWPvcIM2NFL8awk8Yizp7ZPyMMrcK8k66r+4N6Fn+JhUPLuYMDe2TsfwRqq0cGu8lvNJTzLpgWXfrfTti53X5PgMrWt5TP4Pdi6m1L/Lb2fa0R3Q2UhkEMJdsXdPepIkFEZdcLFh4sU+XeUHFbw0Z4hIPpfcrp+KpcHONvf17A0RcPadV/rX1IaVj5oclBd+0ouFnHFuOIgVXHZ3145/gUWEe5uv5LpdOMLInrdpMslmP1jy2QDtF3PsQTQfchryNAq6GLpuVTNITVRSvpNovWjViC3lBCeZ4FC+onNQ3Ivg5efg0eo6z1Qyg2ysW+uIRbhHn7Ke4BR3RCLQd3GKWsFaXaZmzvBt1pxhAMEP64wXvDG7Z42UjBoPXgvt6I/rgvl1XeX8TAmX+vekLMvaDqjk0b492rTCHYzXTESg0fHIuyP4iAIV95HKOYDdOF5TUu5SX+1HzFwVdvpU02rlxnJScLYGzhyAsk88oPxheXcx6RuYcqncKA+76yMWVbGonkp6ZqrlYGsfXZZhoo7RJ6Yeo9lj15W64VmdNZsuA7ZGL4a3+NE0SBah2E+eqSXuUEKUsXwI4vuBon64gKgVS4WLbKhJX0ukVhEnWTvZ7+zsAT4N8yo0gQfzC3f5oUfGAQbZKunzFZNt2YgfbuitnCL3wWJdgvTOgu+biHaLccOB5gyKTn8KAFDqTcPWXZReKs0iUmj8aIfZnuecgZkTxj/O7ZmDaPa
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(921020)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WYE7qLZNyXvh5HuTV4CiOmPjHfyHFBMyHmvlnYyLR1NHH489rdTzGgwy/bjAQcQWckgLyOfPSLzOQEx64i+I9pt4Oj+rQ1MwGcvwkpmmdJRh+2MnSRnr8ejdHbCpamAzgjgTfsfHDObejGvTM0FZQp2MCxbIdJG/BLEQ8xb2CUVMXXphug+4Cbfa5z9pZouFqxfrcvne/zdsDMTyjy/YFB6IOugBfg5BFforCstU4EzLFcLtj74bWWPmjPCpAgYEFMELYFQt45aqxv41Qijn1q6o9kxlW0wH1b1xmLFXXhoftemndrCQkHrcB8G3C+Ypi8zaKABLVPpaCUQamb4gDvOLbJjYdrxxXmdxn9nAeAzmjOtUtvmL1CdL67rDNmzvD+3+eJgTcQTrasAUUq62iia0isZLaeMMKLTR04W0aSySLeM1x2kMEas+D9g5VyiZ
X-Exchange-RoutingPolicyChecked: KLSdKBWPhGVqTIMij00/uQl95DCe0dPtxJerwuPQSBNVUpSO2qDydEQnAn34ll0ijOscHWl1s5tAwoxxhcW92kRke2gsx4wDjyQOmZjE57ioOxrVC4aU3fWpfPNmMlbAGAzecr+Wk5jcyggFjzduz2MML/ioqU6Ip8qBDhcgIv7OI1ChHWQeIpeif7LvIFkQowlOoCVX5Ee5LDR31peFCEcC5Me9trgYnMaQYLTHZ0hngkGwbPNkzT0WMgHv1HLobI34UIYI9povaghiQCyZ+Sr7HqW4aBsJMoivsTkY3de3e+Dpk/eUz0+b3i/KCqSrJujah+h5MnUNsEWF26UHvA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:26:18.1124 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5826c56e-b7cb-4dd0-903b-08df1cc4d29a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8162
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX0JK3m6pwClqZ
 AjVK16Vnw5zfW/7s6PX/cX9CsdFfn2vaJS+XZaI7CX/E/m3hk5nuxlEMbFo9Vqy3mHQkChFo2nq
 u3uJ2VI2PbTr7TCu03CQtWXhLpwLXgw=
X-Authority-Analysis: v=2.4 cv=dbkVTnXe c=1 sm=1 tr=0 ts=6ab95ff9 cx=c_pps
 a=5QB7A90Jg1Mn+JdiV6um6w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8 a=UpfALD_kB0Hx50bdgzMA:9
X-Proofpoint-ORIG-GUID: 42O6raC0nFR3JDJof5tPYaZySiqKHcdp
X-Proofpoint-GUID: 42O6raC0nFR3JDJof5tPYaZySiqKHcdp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfXwGtmvoAQCoy8
 c2uFBZ3IQiDGR0qRqJUVSTy7y2B2o6oT4brIFD8QD3q4woTe5gfxpgvF+W74LW5bBx7/ElnFPXr
 IBKckJzQiaDPHANj4LCrtdDZ0gWirA1n1ERb/2UYIPvNvQQfJgqJDPnwE2pK9BNZo0Y+o+nCZGN
 EFU0uPnCsKQCnXLC7Rm6iGQzjBHYiuUByWA0RYkUxUIBbONSmYP3Wecqvf2sHwEbc4JmwWomUSL
 GYQL7wS95Fp1QXOgZsFcbJZp+gLGMPv1tIm42j195tgdfe7WqlRthUxyKXBaIkQxBP5L1UQNvrW
 IzJw12r7dGAd3UNoWfz/ki09f3MHca/qXgHuF4nCuqYvybiLoE0zfXuOBA6/RYLg/hsGpRc01Er
 aoYryk2VMj03jafhyCyGgXBjvf2iGuVgCc5gNiWqkROhQvDk65dHHY+K1rbrU/B41oOP1sS9e3d
 QlXlY4g9sqBsmjyFA9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
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
Changes from v1:
  - New patch introduced to prepare base for pixpaper

 drivers/gpu/drm/solomon/ssd16xx.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index 6331f367d864..8fe09dca589e 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -358,6 +358,9 @@ struct ssd16xx_device_config {
 	const u8 *booster_soft_start_data;
 	u8        booster_soft_start_len;
 
+	/* Controller scans this panel's RAM X in the reverse direction. */
+	bool x_mirror;
+
 	/* Panel-specific display mode (resolution and physical dimensions) */
 	const struct drm_display_mode *mode;
 };
@@ -513,6 +516,7 @@ static const struct ssd16xx_device_config ssd16xx_device_configs[] = {
 		.default_clear_on_disable = -1,
 		.default_refresh_mode_init = SSD16XX_REFRESH_FULL,
 		.red_supported = false,  /* 2-colour black/white panel */
+		.x_mirror = false,
 		.default_color_mode = SSD16XX_COLOR_MODE_BW,
 		.mode = &gdey042t81_mode,
 	},
@@ -1121,10 +1125,11 @@ static void ssd16xx_convert_fb_to_3color(u8 *bw_dst, u8 *red_dst,
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
@@ -1146,7 +1151,8 @@ static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
 	 * if not, the generic pixel-by-pixel loop below handles non-aligned
 	 * rects safely.
 	 */
-	if (format == DRM_FORMAT_R1 && orientation == 0 && rect->x1 % 8 == 0) {
+	if (format == DRM_FORMAT_R1 && orientation == 0 && rect->x1 % 8 == 0 &&
+	    !x_mirror) {
 		unsigned int src_pitch = fb->pitches[0];
 		unsigned int width_bytes = drm_rect_width(rect) / 8;
 
@@ -1168,7 +1174,8 @@ static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
 		 * The data entry mode and cursor position control scan direction.
 		 */
 		for (x = rect->x2 - 1; x >= (int)rect->x1; x--) {
-			for (y = rect->y1; y < rect->y2; y++) {
+			for (i = 0; i < drm_rect_height(rect); i++) {
+				y = x_mirror ? rect->y2 - 1 - i : rect->y1 + i;
 				if (ssd16xx_pixel_is_white(src, fb, x, y))
 					byte |= (1 << (7 - bit_pos));
 				if (++bit_pos == 8) {
@@ -1194,7 +1201,8 @@ static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
 		 * The data entry mode and cursor position control scan direction.
 		 */
 		for (y = rect->y1; y < rect->y2; y++) {
-			for (x = rect->x1; x < rect->x2; x++) {
+			for (i = 0; i < drm_rect_width(rect); i++) {
+				x = x_mirror ? rect->x2 - 1 - i : rect->x1 + i;
 				if (ssd16xx_pixel_is_white(src, fb, x, y))
 					byte |= (1 << (7 - bit_pos));
 				if (++bit_pos == 8) {
@@ -1267,7 +1275,9 @@ static int ssd16xx_fb_dirty(struct drm_framebuffer *fb, struct drm_rect *rect,
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

