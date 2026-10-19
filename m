Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB89A606A323
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=n5ZpbMaJ;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=ojIlha7P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CD4C10E666;
	Mon, 19 Oct 2026 21:38:15 +0000 (UTC)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F6010E666
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:38:03 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLGqb2742153; Mon, 19 Oct 2026 16:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=EZnxgOpQ1PPF2ln5eJhueqDKQTKOHzbiLp2rVvltE
 wo=; b=n5ZpbMaJ8zVUwS79AtL8vtYQ28QGOxv6m+IkTDT/Gfslk498ZRNMrOVdU
 TXqdCCekzVPbnqeS/LUJaGvJoRAZ0wA7THLq6m24WWnGuBeeDbUuzb2qhKECD9hY
 xhkIH3EaG5u1eDxzP+c1xG4CHqqEWO6IaLeOI5+mRhWJ7HXcI9KsTM+leyWWYJlO
 4kuDAQ1RQWE3sgik+55b5lQf5HAAjQno0CTpErr6A3g2NTBtMp5TArjtUKB93+mf
 QN0ykh5EGyXpSb5Ji3rrEyVozTEgUCwlNoyl9fDPeihLW59tnohYyG1Af0tThd/g
 fPfvnJIFCTw0r+DUjpV3dHyOBHOZw==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hdjbkuq9r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:37:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUrgrmzzagWZ59xVOF59+im36+HXeB2gxiW/Zs3WxeQB5RLDoHpbI5BsQnoWVZjaPrepo19fYqgnH7qQYiB5rXuECB/qu4ZVbDB6qBwIl1jXbTaAURtx8amFotozZPHDWsRNqoL+CPRgy69JSWwYp9viuR+IuLIEtYSg8x2PIPgn+CRDELxMgHpMb4cgs2jgDUGd4GOf0bAslkWo6U9Yt5BbMli5dxlPI/QlHxA02l+SVKo5dT//6SnKAIcuiMeFnQw9UPNugsIMnDT//QgkfTMTN453fp94xCYmAwkuMnxXHQN6DheNE+irej6xngSQl/Arv4vhXiDGaG7Hb20ZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZnxgOpQ1PPF2ln5eJhueqDKQTKOHzbiLp2rVvltEwo=;
 b=n7umahMjU+MnWRGmo3oVylrqzM7jXpFPNwr9K/h1ZtYVyM9zwSA8yFP2ijusZm80yG9fNB1Xc6MFlzZ+suQDuT1x3uXJsaCNA0JVR9cskPAtUFPrgU4gbPg/ovg7I8dZ/X86AqIbPGitgUv7ojZ+AEXz58UhLl+U7FsvZ4BW6GqKj3rV0dPuE4w+JumtVByUSNc9tQNHUxGXkrmu78PUV40CxKPe8kzxC6FvZr517dE0TZ1EE7W+Qz9QAEZ8F2y8MK+of7uYwYRdLUK1009ElzO05CsBMD2Etye/HlD8Z4yW3ogdXjW8WkapcrUilad8dAB8/vc7U6MYExMMMmmsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZnxgOpQ1PPF2ln5eJhueqDKQTKOHzbiLp2rVvltEwo=;
 b=ojIlha7PX7x6/4cts0YDOwiGyrlZbqZtMhY12bP5gb8CoUQxFCj7PxpWrptYNoytuu+kiCv3WjqgOKCKklLug+Rof1wp0zuoX0+rKH+8SoFu3HRbATLR8x3/O49ALCnfnsNmIgV3IZxILWpc/EQWpg7Y5n36r29ACRsGwBuUcHU=
Received: from BN9P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::11)
 by CY5PR10MB6093.namprd10.prod.outlook.com (2603:10b6:930:3a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 21:37:54 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::2c) by BN9P222CA0006.outlook.office365.com
 (2603:10b6:408:10c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 19
 Oct 2026 21:37:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:37:53 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:45 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:44 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:44 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbhYe3577051;
 Mon, 19 Oct 2026 16:37:44 -0500
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
Subject: [PATCH v3 09/14] drm/solomon: ssd16xx: Expose color mode as plane
 property
Date: Tue, 20 Oct 2026 03:07:21 +0530
Message-ID: <20261019213726.4145532-10-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|CY5PR10MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: f52e4474-5420-4fc5-e079-08df2e293b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|921020|260925021311599003|261009223027099003|260925021911599003|260925022911599003|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6iO5He7nzDVUZOO4oAStrd8wcuLlhvogtaxo14XtxYFjDnlTj0JnjA0OUvJhPlmBSRJld0L+fIIRvptHsPhcNedFwc4h2cdY5kTURnyj8HNBY6B8cAGT6BYj6f0XbxttvwSpEATRO8L+ULx5wl+mVI4J4D1jOWYFUQVVlNKU2DfwMgsHNcuxXBTqSJwHWd41E3t1FLNVXcXDbbKZWwTAQsP2wQjobjmH3i2eSKV1Iv2Bxus9nf97TKjytgUo1U77CIuR+FKPwHgxdHlZvHGI7QQkbVVfQHL+sGggY2AUk1YOv6ckbPY/KNZyP7htZMfW7IZ4XFBe0nENymQJp16cam0iOWSzDYXYNloldQce8vfIedTtgW7qWFJf8FFND3jCWrxPoK+kI/F5/nmKv8mSmoVxlvBSP+aZxlXOraMngQ2J7W/LN+6J22NMrKxxWLnqcBsKZOc/Wvt9QqiuV6jUi+0cKG6YEA9xlIUp5PpXqLCLwd7udjlQOixEIdDLIkeLA77NnZAU0xCj2RlCAQxae5GMp44nIvOKb5gaYANmuEDeWI2o9bdGvolGBJcomlvaud77dwlDMky48J31lVtLNrbIiZj+ux8+P+IMVutsGXlcf+80u1VlXo7SuErdz7LAn7FZ4HYnWuvhFTfVxOD7bicB3ZuBRZQjBeP8ZRluRTMjboYMBiwYgayAYDEWTPJ+x6M7EUTjnHTC51ALJxt0tIiHmh5lfnRi1PCumgj93qwKyNu/LMV4qpfQNWT0hjiL
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(921020)(260925021311599003)(261009223027099003)(260925021911599003)(260925022911599003)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dS3uOGlUcHjLoTDtdxwGc8H/IMjunaXlHEb5XacE2vhESpsD5U65owgbNwvXocoCsu8eBJ7bOCC2NBKWlnkY8fBWNMG4LvuKGksKEpKRSSme3gkJ6ktSN7YMqqzoe8cvKGO9ea6Fg+WnjC66RIIZfFfkMeXspdVOYtX3cYkeiRAbwcppaxKMXWQpxPV+hXyg3NSzNkWDr37DItmlgbeubPVlawbk/+zjIoVBpMKVaY2QQ8klrpkTSp28Im0/5PUXWePWPAs0J4bg3sAIMljYnGRygW1WIgbnjr1yt4XZ3sfCzIpaQHaaCsiw5Ih4eEF9BkkSGTNj24zG79tJPhKPhAJWgBN7rSuEMtVOG5ItyKlDzzYtAIVrjTi1tCf8Nniy893odNcVamwcCtk9EewPFQ0UsKSq+ej9NCk7WcdM41IsPolapaQcpaLVUYQrKS5z
X-Exchange-RoutingPolicyChecked: f9bhTllFSrVEvW0g1xmSQA6EsQ3Zr+/fJ8icwIIZlNS+ZF76v285rtTFudFNGbIgShbSZIy1eEQ3hLeZnVzbJQ1eqzRRbs5+ljI5u1b4fEldt9hGd0MK9V7Ln4TlYz3HjBaDrv8XbszADWUEgxQI/H1ZbRteUpFIqWQHrwr4Azh4eA6PjZ+jIaqT2ZreAW6PgfNuogpzfq1tARkanSXYf1DmHUjfZR/QfLl3wr1InFBIQX9pYqe6V5+2GaseXqoUjuCrkdbBLRnCLA+k6BEqQvMKlCLhOrnCf0bXIMadO6efy0i0eydZ9Hh11C5JuwvR6p5j+PFRHljBco4/lxDaew==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:37:53.6285 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f52e4474-5420-4fc5-e079-08df2e293b8a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6093
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX8Y5LvNEsCZ19
 XHiZGrt8qWoML8bP8JIqAia33mw9xepJXwDJvwYyC10EWaKhUVkdHMAbtzyUZ/bE6bKtbey9R5z
 bLCPkdJ8Uu3rspK/6ecoW7aO96JVZ6w3QhejOb90tvWyD/do4/c7uuE4Ke0veLGZa7f88/hgkwJ
 oB6NFMFQxYUsCRYb73UjqK4+OrLUeCqErPvnt1TWzkqAjO5ywnfi1rk3lbhihMh8SC0+5Zn7waN
 OODQ9dC/dqgNUm/sxFEb1k7A1vLnUYjUu5qEpIaMH1QkkJHe0RmWDr446Y+wNUYevi71CNOKlHz
 uZNbgIw2Ud18B8hembYW/ow7Fxp7QflXXP4G8vBbrGeoh2mT6fEv1sxeaigQsyY0myqUSXkTRy/
 tZBftmfObSHG8tnEIBXilacl5I5isATayAg4vp7GLt0z62Slnpuz230On+P+EQTYfFdnGVrcI5B
 Wf0e786dAvXru1/54kQ==
X-Proofpoint-ORIG-GUID: 9KJqsK0mlUb_ZFfWTwy361nWM3VIdi8e
X-Proofpoint-GUID: 9KJqsK0mlUb_ZFfWTwy361nWM3VIdi8e
X-Authority-Analysis: v=2.4 cv=Vsa2kO2n c=1 sm=1 tr=0 ts=6ad68db6 cx=c_pps
 a=BcPl/o76WFXIZ3b3OvynCQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=3IO9RwVF9Dv72MOw_kIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX3wan71mzvUb7
 ENtFejdBxTHd9fYhuWLFHJoa/MpJslMh1Z0R3hpciKVLlqBa099xVNOx3Ci3KErBDwEl+0Y6Q05
 Xg9FBrlyDOkx7H4bjg1V85UVn+Ekoqw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
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

Add a DRM plane property "color_mode" for panels that support
3-color (black/white/red) display modes.

The property allows runtime selection between:
  - bw (black/white): R1 format represents black (0) and white (1)
  - 3color: R1 format represents red ink (1) on white background

The property is created on all panels with "black-white" selectable;
panels with red_supported = true also expose the "3-color" option.
The default is set from the panel configuration's default_color_mode
field (typically BW for monochrome panels).

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes in v3:
- Reject 3-color mode together with partial refresh in the plane
  atomic_check, as partial refresh does not update the red channel
- Only create the color_mode property on panels with a red plane instead
  of exposing a property with a single possible value
---
 drivers/gpu/drm/solomon/ssd16xx.c | 51 +++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index f53c67ae7d31..6037717635a4 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -399,6 +399,7 @@ struct ssd16xx_device {
 	u8  spi_buf[64] ____cacheline_aligned; /* DMA-safe buffer for SPI transfers */
 
 	struct drm_property *refresh_mode_property;
+	struct drm_property *color_mode_property;
 };
 
 /* Plane state subclass: refresh_mode lives on the plane, not the connector,
@@ -407,6 +408,7 @@ struct ssd16xx_device {
 struct ssd16xx_plane_state {
 	struct drm_shadow_plane_state base;
 	enum ssd16xx_refresh_mode refresh_mode; /* Pending refresh mode */
+	enum ssd16xx_color_mode color_mode;     /* Pending color mode */
 };
 
 #define to_ssd16xx_plane_state(s) \
@@ -1457,6 +1459,7 @@ static struct drm_plane_state *ssd16xx_plane_atomic_create_state(struct drm_plan
 
 	__drm_gem_shadow_plane_state_init(plane, &ssd_state->base);
 	ssd_state->refresh_mode = device->refresh_mode;
+	ssd_state->color_mode = device->color_mode;
 
 	return &ssd_state->base.base;
 }
@@ -1499,6 +1502,10 @@ static int ssd16xx_plane_atomic_get_property(struct drm_plane *plane,
 		*val = ssd_state->refresh_mode;
 		return 0;
 	}
+	if (property == device->color_mode_property) {
+		*val = ssd_state->color_mode;
+		return 0;
+	}
 	return -EINVAL;
 }
 
@@ -1516,6 +1523,18 @@ static int ssd16xx_plane_atomic_set_property(struct drm_plane *plane,
 		ssd_state->refresh_mode = val;
 		return 0;
 	}
+	if (property == device->color_mode_property) {
+		if (val > SSD16XX_COLOR_MODE_3COLOR)
+			return -EINVAL;
+		if (val == SSD16XX_COLOR_MODE_3COLOR &&
+		    !device->device_cfg->red_supported) {
+			drm_dbg(&device->drm,
+				"3-color not supported by this panel\n");
+			return -EINVAL;
+		}
+		ssd_state->color_mode = val;
+		return 0;
+	}
 	return -EINVAL;
 }
 
@@ -1535,11 +1554,20 @@ static int ssd16xx_plane_atomic_check(struct drm_plane *plane,
 {
 	struct drm_plane_state *new_plane_state =
 		drm_atomic_get_new_plane_state(state, plane);
+	struct ssd16xx_plane_state *ssd_state =
+		to_ssd16xx_plane_state(new_plane_state);
 	struct drm_crtc_state *crtc_state;
 
 	if (!new_plane_state->crtc)
 		return 0;
 
+	if (ssd_state->color_mode == SSD16XX_COLOR_MODE_3COLOR &&
+	    ssd_state->refresh_mode == SSD16XX_REFRESH_PARTIAL) {
+		drm_dbg_atomic(plane->dev,
+			       "3-color mode does not support partial refresh\n");
+		return -EINVAL;
+	}
+
 	crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
 
 	return drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
@@ -1608,6 +1636,7 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 	}
 
 	device->refresh_mode = new_ssd->refresh_mode;
+	device->color_mode = new_ssd->color_mode;
 
 	/*
 	 * When refresh_mode_init was set, use the specified mode for this first
@@ -1855,6 +1884,11 @@ static const struct drm_prop_enum_list ssd16xx_refresh_mode_enum[] = {
 	{ SSD16XX_REFRESH_FAST,    "fast"    },
 };
 
+static const struct drm_prop_enum_list ssd16xx_color_mode_enum[] = {
+	{ SSD16XX_COLOR_MODE_BW,     "black-white" },
+	{ SSD16XX_COLOR_MODE_3COLOR, "3-color"     },
+};
+
 static int ssd16xx_plane_create_properties(struct ssd16xx_device *device)
 {
 	struct drm_device *drm = &device->drm;
@@ -1869,6 +1903,23 @@ static int ssd16xx_plane_create_properties(struct ssd16xx_device *device)
 	drm_object_attach_property(plane_obj,
 				   device->refresh_mode_property,
 				   device->refresh_mode);
+
+	/*
+	 * Color mode: only meaningful on panels with a physical red plane.
+	 * BW-only panels get no property at all rather than a one-value knob.
+	 */
+	if (!device->device_cfg->red_supported)
+		return 0;
+
+	device->color_mode_property =
+		drm_property_create_enum(drm, 0, "color_mode",
+					 ssd16xx_color_mode_enum,
+					 ARRAY_SIZE(ssd16xx_color_mode_enum));
+	if (!device->color_mode_property)
+		return -ENOMEM;
+	drm_object_attach_property(plane_obj,
+				   device->color_mode_property,
+				   device->color_mode);
 	return 0;
 }
 
-- 
2.39.1

