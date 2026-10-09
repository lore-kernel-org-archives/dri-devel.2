Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88DFACA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB06C10FEA2;
	Fri,  9 Oct 2026 06:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OoI9/jV8";
	dkim=pass (1024-bit key; unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="cEe0FmW1";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F6210FEA2
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:42:46 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6993HsV11185469;
 Fri, 9 Oct 2026 01:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=oRI8Kc4F+Lej269D0tXaJ3QST4kGiEySlxSq7AW2F
 10=; b=OoI9/jV8s35lZ0aHRI6cJjTxm0SqRTLr5jLE5yHuk3sQ2tq9OQcXJTTM0
 DbrDv206+0GIgd46odGlC/pwOdK9bRGAQ8ozN8Bkdb7kIYDKhcdMJsYDNAJJjba0
 g/4ggj2prVnm0z5pxtNZD6ufpIpwtopWpGb4bxJ1TcNnkcm7HWRXA3ZphsfbKJA+
 Lq4EGow7h5cjIEo7IMB+f9R3QVVKWJTkpr6yKSmcMqR74CS+F0fpry8Ulnm3L7vL
 HbOOqETLi9SPUKIG5LIITNZkgb1V57AKvjTGGjb/4rLG/waklUcBv8WMheuEi2lU
 ry3kA900gztFBQt0+FX5Yu/vugHlA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
 by m0384305.ppops.net (PPS) with ESMTPS id 4h6nq1hwmt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 01:42:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRt0hZcdEGTXRD6KzEmkIc0Ja7WRavV2qyyMvhaxwqbtBI5O/m6T1jwjK9KJSWUnfuwRf5sn2VkL+x8ezBl+oMOYuEDT/taZuBEmI5I6nUXflxRQ3ebLd/0ZEOapVxwWuaR6Maqq/lGQuMekBkiNBo2Inhb2mHSMPMjColaxU31nleI/j1X9WRy3Bii5ZEaEXs9auJgAz4kF0MhkowMBn7xvVzgQ2HBBNu6qxw1rS9tuPOfzWG2pP38U2jV4jJ9JFBTKWH3/JsEvSFQqjJvXdFQkHrZPQu1y2/qvZqofd2SzvLi7k3w+M2aFB5FvMk6Fy5M4xkE0MwUcpYAPDpVTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRI8Kc4F+Lej269D0tXaJ3QST4kGiEySlxSq7AW2F10=;
 b=qc9r01mktfTjBXyYGBmAlvgowXV9D7PvCu2vW592ODHBC7ejcKaoVp3kDf9SasHvAEiIbI4hruxQvDHa3nEtxHxCF1vrbghrxvLt8rb3SnD54ED0JZDAjZSEutTSn7g7ZXZz80YfoHAYimYIfZuWfXYh4p7aYwvjsLiFliOPoy/es8rorZl1DToGMr04y6uqG8k7S4GQPqk9Pa6zUy154ZucPqA3+nTyBaYkJTwgAd7Lj5hi550xPzmT17pWfDUcGv4vJPHYwp5u+c2gnvuyAeQQ2DYOB2uTCtpU36xtPomd1b0U7tLx/pi5kqJzq26AYz5zwejPD95yYcAZTtV17Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRI8Kc4F+Lej269D0tXaJ3QST4kGiEySlxSq7AW2F10=;
 b=cEe0FmW1gNlkKLi4bHcTOeaTdvdOP25MyrFd8WGC/d/YGmC+59zLxoJp1V4ItiP6NmA+Bt4WiJPfeqEO/CfPz/4U+SM/5W7kuvJ4jJRti8k3+bj1Y0bxVpmEtmLUbZA2t3oRHG0omOsDIUOf1lTveLuoZRnMFexni+Emwir52Ck=
Received: from DS7PR05CA0049.namprd05.prod.outlook.com (2603:10b6:8:2f::27) by
 PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.17; Fri, 9 Oct 2026 06:42:18 +0000
Received: from DM3PEPF000265C5.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::31) by DS7PR05CA0049.outlook.office365.com
 (2603:10b6:8:2f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 9
 Oct 2026 06:42:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DM3PEPF000265C5.mail.protection.outlook.com (10.167.23.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 06:42:17 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 9 Oct
 2026 01:42:01 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 9 Oct
 2026 01:42:01 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 9 Oct 2026 01:42:01 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6996fXfw666824;
 Fri, 9 Oct 2026 01:41:55 -0500
From: Yashas D <y-d@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <h-shenoy@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <panchuang@vivo.com>,
 <kees@kernel.org>, <r-ravikumar@ti.com>, <y-d@ti.com>,
 <sjakhade@cadence.com>, <yamonkar@cadence.com>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 2/2] drm: bridge: cdns-mhdp8546: Add no-hpd property
Date: Fri, 9 Oct 2026 12:10:24 +0530
Message-ID: <20261009064024.985688-3-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261009064024.985688-1-y-d@ti.com>
References: <20261009064024.985688-1-y-d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C5:EE_|PH0PR10MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd0107e-09ec-4079-9dad-08df25d07655
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|1800799024|23010399003|82310400026|921020|5023799004|56012099006|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: I3nne1QRCuDBf3aapClvh/zLgJC3LCqYn/ZS5Lj9o1gQhAKHn/7KZZXXa25vMTPPCL9JW2htLLej3gT8WxmPvXv7RoVW9su8GmgyFrmxCb8HBCVTROODYn6Y+tjMVkXluCCYS1kpPMN9jnxb6BDQw20Aec8KVAUC0S1+GclKJwuW71gpYf1az/2rZcvvA/WGwou9Rfx5KReJ1HsRjJ+ymOSLYqkuWnWkEg+CXBo9PICTO1ZqfJsFcg4swCUw23yDSd6xXlw7ykk/3CBabY+8MkdbUa6ih9RWkTZ7yxhPx562z2v+9VG88Cur9UCQFy0AzrEVNDSH21a75aX/vqqv1hS/GCF/lYKIcwY/7lOMv3cU+OEDDAdoM0kFfFNd+Vj/FLVzeZI94PoWYxjU665Rnhtqun6w4KgMK+JzUZ20qcBHfu+TXcKeobF9gDdIJ59zj0KHnqqicGUvBl7rl++ILfndZqHD8MGdwTBK476fpRY5clDsDhR7wYIfIfvMozxoRFS4Ouwud5v7TvR3VO0pHQ8GVtymWoNWxOJkUdrcPY3qs+joW7SUFzii+dClEkNDmII4EmKkPOLSN7vD2R/5mwkUw1RJ4sqnPDdEOBDQ6eExOubY7WNQEZltAzbhbyKLtyTn9x9IjorViXiUvYBGwj5//txXRn+SdVvYR+lVjTL99/lJ4eFs6geXSJAP6LikVKp+OFWXH7Pr2vUBWGFmE4kBI1oCcra4JKqIBhFUW1QuDfsPXf6rgFWT4FquzIf4
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(23010399003)(82310400026)(921020)(5023799004)(56012099006)(22082099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aj5ECzt6F7NmDvSs7Y5yYORAOuOYWWPqIK533B6QqgrO92Uz2i94vNvaOYPlr7/5GlCFHoB6h+D0d8bS4KX2kTY3nieu3/5Jn2o6hsugAcWaqWN2a4o9c3crrw42lrEJrXgIKGc59VeW+iOVwcYvcYPKGCXIxNO6Ted/ppp41EKtvNWjXyQei4xjbbWDVWQtAKjrGX9e/FGYtwhJs1tQ5hzjppgSSXgv/1R+0pLgagbKFXk2Cp2GqWRqY8pJtXxjm3cLCXI1SiMbl4Uyxm/1gGSeP8vLjdxuA5o9rKDkQ2jfipx2ciV3t7bckIcz8LXHdimcpNkPWzVXS4Y9rlrDTWWA+fb4s29x1Surl/6LIsbf2kfUNJVy7IxPJuqZJ8wvg4sIrxsc2ZgNtJC/1rEYbF3zZaGB3NjrZXMjmZbqD67QCuNpU/N0mn+N9K5k6Z3k
X-Exchange-RoutingPolicyChecked: HgX36dNbNntsittopRqXe0+YfzNCupfxQemI9AxrGtl59gBTvjDaIl2/mVWcuNID3JbqUJMozqGYho+LcFETwHphs52x74olnvTrv9VTP64shvE80o9W18oGgD6xXB75n72j8HU1P8tN/c1acqqlRW4NYAeN0rX8wj1RF2AV75xvoXmNp6PMbphxwps4RlAxrK9BTkoh8waTY+idYywTe3Z2FTF89VVkdDZzzhqTV/7lxPqOtBu+8itZo2uT71v89HRZ9mvyb0W4qtljQ2jnxKYn3crsKnr0YZQUNwullxzGlnGGFMuYU9HD8/hFSNEuJhJy4pAWM8HRoy+cNhwU2Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 06:42:17.7623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd0107e-09ec-4079-9dad-08df25d07655
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774
X-Proofpoint-ORIG-GUID: Ghrztir9V9abZp87PR05D983dCMU2Xh2
X-Authority-Analysis: v=2.4 cv=BNAmP1QG c=1 sm=1 tr=0 ts=6ac88ccf cx=c_pps
 a=Nwoz+Mp4en+GxkTyGjE1QQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=8m6jy30CiBRjHBHqTgAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNiBTYWx0ZWRfX259hTKzBfXJd
 Uyrstqmx6ZW1RHEPgEttQ5/zR8cU+q3yeUdkHIaNDjY7R7Z7Ht915n+QQ88rMeMTdd7Lo4Sh/i4
 iyn7U2iciGJsRIgAx6H3LwLsF//iSjtFFaAcerGbDBhr14VRAseTlIrLNZBx0FVW7q7HGInd5BU
 cJ38IlcOGzbcvv3BI5woZ0vwH6zSQVBkY2KoAKhqu8Ya2gMfyi+8DocVH2X3MLmpraxSqaGijqK
 8oDF9jjfZ6BRqrnycp2M1XQKedi8HkpVJM2AfR9F/z2Z2yc0PzzzPBMyNGVMcRU+cig93L2uVIN
 RpxdzXo9ieQR27t3gWK6wNKoTH9NN///726nr4RTBKpicSC7Gj5Vvz0NFDj5nFgaMtwc3LNRJdC
 de4KTlAgDXLF1pBaTFyKvHPaDtVtuScjbSMrGXPhS7x+zCF5CBIKkN+viYM1SEMDelsMZ7X8RKr
 QaXoHDGk8XKA8BVMFtg==
X-Proofpoint-GUID: Ghrztir9V9abZp87PR05D983dCMU2Xh2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNiBTYWx0ZWRfX+2podR8Wxi41
 vIhjgQwz8dApMKeUX05KGgHt31w2Zvo7Nto2H4W+8WPJamhTsrulUGoPfBQvjpuQjVdJV/rjda7
 72CoJlefnKKzb6cFvO/RmCWc9uyoxW4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090026
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

From: Rahul T R <r-ravikumar@ti.com>

Add a 'no-hpd' boolean property to support boards where the HPD line
cannot be used for hotplug detection due to hardware limitations.

On TI J721S2 EVMs, the DP0 HPD resistor is not populated from factory
(DNI), so the HPD signal is not physically connected to SoC pin AA24
by default which makes HPD unavailable but AA24 must be in DP0_HPD
mux mode for the MHDP firmware to operate.

When this property is set, the driver uses auxiliary channel (AUX) DPCD
reads to detect monitor presence instead of hardware HPD signals. The
DRM framework polls the connection status via the .detect() callback,
providing hotplug detection without requiring the HPD pin.

Valid use cases:
- HPD pin not routed to connector on PCB
- HPD signal muxed with another function on SoC
- Hardware designs where HPD cannot reliably detect monitor presence

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
Signed-off-by: Yashas D <y-d@ti.com>
---
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 69 +++++++++++++++++--
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
 2 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index f47717bd10798..b02147a725a2d 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -53,6 +53,8 @@
 #include "cdns-mhdp8546-hdcp.h"
 #include "cdns-mhdp8546-j721e.h"
 
+static int cdns_mhdp_update_link_status(struct cdns_mhdp_device *mhdp);
+
 static void cdns_mhdp_bridge_hpd_enable(struct drm_bridge *bridge)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
@@ -698,7 +700,9 @@ static int cdns_mhdp_fw_activate(const struct firmware *fw,
 	 * MHDP_HW_STOPPED happens only due to driver removal when
 	 * bridge should already be detached.
 	 */
-	cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
+
+	if (!mhdp->no_hpd)
+		cdns_mhdp_bridge_hpd_enable(&mhdp->bridge);
 
 	spin_unlock(&mhdp->start_lock);
 
@@ -739,7 +743,13 @@ static void cdns_mhdp_fw_cb(const struct firmware *fw, void *context)
 	spin_lock(&mhdp->start_lock);
 	bridge_attached = mhdp->bridge_attached;
 	spin_unlock(&mhdp->start_lock);
-	if (bridge_attached)
+
+	if (!bridge_attached)
+		return;
+
+	if (mhdp->no_hpd)
+		cdns_mhdp_update_link_status(mhdp);
+	else
 		drm_bridge_hpd_notify(&mhdp->bridge, cdns_mhdp_detect(mhdp));
 }
 
@@ -791,7 +801,6 @@ static ssize_t cdns_mhdp_transfer(struct drm_dp_aux *aux,
 			dev_dbg(mhdp->dev,
 				"Failed to read DPCD addr %u\n",
 				msg->address);
-
 			return ret;
 		}
 	}
@@ -1523,6 +1532,19 @@ static int cdns_mhdp_attach(struct drm_bridge *bridge,
 
 	spin_unlock(&mhdp->start_lock);
 
+	if (mhdp->no_hpd) {
+		/*
+		 * In no-hpd mode there are no HPD interrupts to trigger
+		 * detection. If firmware is already ready, do the initial
+		 * AUX poll immediately. Otherwise fw_cb() will call
+		 * cdns_mhdp_update_link_status() once firmware finishes
+		 * loading and sees bridge_attached is true.
+		 */
+		if (hw_ready)
+			cdns_mhdp_update_link_status(mhdp);
+		return 0;
+	}
+
 	/* Enable SW event interrupts */
 	if (hw_ready)
 		cdns_mhdp_bridge_hpd_enable(bridge);
@@ -2012,6 +2034,16 @@ static enum drm_connector_status
 cdns_mhdp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
+	bool hw_ready;
+
+	if (mhdp->no_hpd) {
+		spin_lock(&mhdp->start_lock);
+		hw_ready = mhdp->hw_state == MHDP_HW_READY;
+		spin_unlock(&mhdp->start_lock);
+
+		if (hw_ready)
+			cdns_mhdp_update_link_status(mhdp);
+	}
 
 	return cdns_mhdp_detect(mhdp);
 }
@@ -2100,7 +2132,29 @@ static int cdns_mhdp_update_link_status(struct cdns_mhdp_device *mhdp)
 
 	mutex_lock(&mhdp->link_mutex);
 
-	mhdp->plugged = cdns_mhdp_detect_hpd(mhdp, &hpd_pulse);
+	if (mhdp->no_hpd) {
+		u8 rev;
+
+		/*
+		 * Use a side-effect-free capability register for presence
+		 * detection. A successful AUX read means a sink is present;
+		 * we do not need link training status registers here.
+		 */
+		ret = drm_dp_dpcd_read(&mhdp->aux, DP_DPCD_REV, &rev, 1);
+		mhdp->plugged = (ret == 1);
+		ret = mhdp->plugged ? 0 : -EIO;
+		hpd_pulse = false;
+
+		/*
+		 * If the monitor is still connected and the link is already
+		 * up, there is nothing to do. Avoid falling through to
+		 * cdns_mhdp_sst_enable() on every poll cycle.
+		 */
+		if (mhdp->plugged && old_plugged && mhdp->link_up)
+			goto out;
+	} else {
+		mhdp->plugged = cdns_mhdp_detect_hpd(mhdp, &hpd_pulse);
+	}
 
 	if (!mhdp->plugged) {
 		cdns_mhdp_link_down(mhdp);
@@ -2288,6 +2342,8 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 	mhdp->aux.dev = dev;
 	mhdp->aux.transfer = cdns_mhdp_transfer;
 
+	mhdp->no_hpd = of_property_read_bool(dev->of_node, "no-hpd");
+
 	mhdp->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mhdp->regs)) {
 		dev_err(dev, "Failed to get memory resource\n");
@@ -2359,8 +2415,9 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 	mhdp->display_fmt.bpc = 8;
 
 	mhdp->bridge.of_node = pdev->dev.of_node;
-	mhdp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
-			   DRM_BRIDGE_OP_HPD;
+	mhdp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+	if (!mhdp->no_hpd)
+		mhdp->bridge.ops |= DRM_BRIDGE_OP_HPD;
 	mhdp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
 
 	ret = phy_init(mhdp->phy);
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
index b53335b0d22c3..24ffb732a207f 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.h
@@ -388,6 +388,7 @@ struct cdns_mhdp_device {
 
 	bool link_up;
 	bool plugged;
+	bool no_hpd;
 
 	/*
 	 * "start_lock" protects the access to bridge_attached and
-- 
2.34.1

