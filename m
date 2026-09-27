Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEA2C9832F
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C891A10E1A9;
	Sun, 27 Sep 2026 18:24:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OQZAcFhv";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uZUAxEyj";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A949910E1A9
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:24:04 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68R7liCf2775474;
 Sun, 27 Sep 2026 13:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=pK6kieY+6+PC3
 7bBidYrT18kHK2AlYoWoCLjvNGbxjY=; b=OQZAcFhvenIX1nC7/OS3MerOklrjz
 ORi5O9YMUQ+6kWI3H4u6JJyhjyR3pOcgsTyEegEuybtmkkcMUAwbnhcRC2ml2qV3
 B57TGZkaggdNhy/IxfoHZHW8HkA95il5Qn6/Ic73NwsFf/+e338D6BNt4iFZR97u
 2nBbx6ID8q33ejZh65Xt9nMUWMrKVxbhiL4aNd0eZI69n5G8f8JbA+/x8YiLxY5s
 3gSXapknDbfJL3MkVJPnG2pHFuLbCpWHcWOAUVodrVWOypt+xlYSbQTsC+7HnEW9
 pGYsyOtFYzLEPdjzMLqZY4m42DjFCnkjuoM9ZJbR9GV69NhlpqFkVYf8w==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013048.outbound.protection.outlook.com
 [40.93.201.48])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gxy2nhnu2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:23:59 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2pAyzkMvPTKBCBcCJ9CnSr+5AIVfza7ZEZ+KsOJZcqv+HoHEmxHiAbjtotOC2PpAm6pbF2Y8J9lI951NgY1TuxCMv5KqeS94kGmW4fezk2/BF0iuF5TVFqydSAH3b+P6v3efGSKyq7V8t836KAZjVM9Xe9zx13kFwf2kNd8BQK3d+w4I6+ZBWzzBrL30YxMyu7s14N9KexvEtwvacOELpO6JX0I0iC2pNrWHqHEKlvqOdTa5CBI6Edb+qYuCckYYa7bzYVPfDCidMPnmbf1vecEiXDnWUexRoxxlrMKzaxu9v6bwhlCqiY726rdL4mGpMYFyoJI5I53AQGX13fHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pK6kieY+6+PC37bBidYrT18kHK2AlYoWoCLjvNGbxjY=;
 b=Dqd1NM8jCQXTAj5Uth2QDtChdzuISSNm7Jl8ECpKCYW0O7hpesf1x551YFjsK5dM+WutRrxIKQc1sk3re5SDbzGwQB6HkiMTBalpgBob87V9R9n0zqXt+N/EVto8I+wKhkGSPlCFnM6IrzZsFZyLdsRPMjygrLcnTsjzO5i9rBN2O6fcZdGL7xx/WKGaOMPAWOf0/EKP/pE8PQ27tqK8YoW8pb7DMYvl2DeOnBCfx4QtAXZJBR7DTuJeQtVPDkEn/fmWcg952JVV6iymMOUf6cG/3ywty3cvnDbK320Yb8PPvZhll/1C4orLiFCjDzIR7gzI/CJOgaAdMNC+8nzy+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK6kieY+6+PC37bBidYrT18kHK2AlYoWoCLjvNGbxjY=;
 b=uZUAxEyjn3G2LYQPZaAjafVk+4LoSYRLSAwkM4NIxi0APqW5QDJCMpa2SqeLFdTOg2t5ogXQSGXP07zxvld3vWIU0A+nbUddqAEyf3omkffL/NBKWzHApyW7YlPXp+FSYa+ibZxogk/ky8SA7rYqrnb8I/os9aiepox/MPGmuVU=
Received: from BN1PR13CA0017.namprd13.prod.outlook.com (2603:10b6:408:e2::22)
 by SA7PR10MB997772.namprd10.prod.outlook.com (2603:10b6:806:4d0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sun, 27 Sep
 2026 18:23:56 +0000
Received: from BN1PEPF00018070.namprd04.prod.outlook.com
 (2603:10b6:408:e2:cafe::66) by BN1PR13CA0017.outlook.office365.com
 (2603:10b6:408:e2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.13 via Frontend Transport; Sun,
 27 Sep 2026 18:23:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN1PEPF00018070.mail.protection.outlook.com (10.167.245.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 27 Sep 2026 18:23:56 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:23:55 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:23:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:23:54 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RINrLq2546134;
 Sun, 27 Sep 2026 13:23:54 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>
Subject: [PATCH v2 00/14] Add DRM driver for Solomon SSD16xx e-paper display
 controllers
Date: Sun, 27 Sep 2026 23:53:15 +0530
Message-ID: <20260927182329.4193961-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018070:EE_|SA7PR10MB997772:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c0fde0-01c4-490d-e903-08df1cc47df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|921020|13003099007|6133799003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: E5+/FWMkQDBoUKJSrbPafMujGd0ApP93jDW7Z+QyS82IrPeHFWJQSKr8wRdVRl3PhoQVl4QsW1e+Ik8h7eYB4+VL8w7H1KCUZwWYRG/w+iVsdz7c3FHpwR3IqELSqphS8KN/GmrbIVgNbQzow4AKktOQbIvI3hY8Ffz3KYbg3B3gUV798dkpVU07gfA+ntxNEjHkWtJjIF1+D85zCwGuE2hxcHQp1TPpWe4QGfEWF3ZXHLnbzu0AYF0Ttn+AubscHpqnTHQl4lCm/eocZkPQ87DzI3s+mtBTFnZ/Ff7885HYEdnbr5sLcp6TXM7CbWqqzVL2klSHQdZ9QhjEFwMUfPqBparC8sD2JmuCkDeBhF5A+uozRbWs8j2wZ24ZFyZyIl/9TG2U/h3ZZ7E3/XVWP36BDA2KFaT0iUVIHnILVFZDVdSqNgIOVfHVth3abIiSfjg9cVCRxjAgbscoY7mf+N+MRlmjpI4CKb/qjEmNnsWJzYpA5Y/z/6wyhiHXpcOJFxdR1YGH0U47gJgsADz6ry/5Dx2clnk2VdxaFXe9OQdzsHSF/yK/8ip1wO1ydnSJ96WHVH+faSgR7OGG1TE6AVwff13rk7VIrQABukwO7ZcGFZI8+NQlcthfi9xA1VZ/5gJkNuJe3uzz7+KMeI7/nPFSjMVhUR98I9/N9x9soF7ug3Hwlt3JTuzXvXaS5u5UQeHvR5GUavHNk7PlmuEyOA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(921020)(13003099007)(6133799003)(18002099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vc+agvK7FQBynBqsqBpPoe2Kv+XniFK+2z2s7jUF9W8HaK3lQrRFuenvIZfWPJYYnAXozJfp7ykyYN0bHlLuVt+XgkzNHBPTqWlZphnFakSnN9UH710JbFzQ4HrDbF1OwdmfsrlTxEoRGDaLjvp4rPA0UOtbkxY0XpCAu5nUh0z6VvfBqlc2jdv0r4pUUHV6am4I/DkNcOtOBKT+Pubci43cWJgM4gJ8izKTUmJTT3/vNYE12mQMdgYuHHRzf0FUTym+Yu5jHY0qdqU+c3oAta6S/evsCX5L1qRkNFpF0kSaXD3OUV+Dp52hPmp1enA+MXWzfSIp5WFH+bSKGUxgD3i4xYxHgxfGrzXaXOspG01+OjpQchLwJ2Pm/ZnTVJ5Ne6TtjIqE/SG3AWBsN8j05GXtiaYYjkY6eiFPgvRFghjPcg0GfvB/Ak9rT8K6YWEW
X-Exchange-RoutingPolicyChecked: CD+QDDifdPB8ipYr8TYClJV8V/muibtjMJrREFjReuspgT5DKHCi9K3YdMw63Ts8YZ8hOnqM5/yUmFX0Lx25zzrdMgOxptwUUth7sQ4J8Qg7KpK+Bv1OGRkYNFzH6vnplWVEm2Tw4roRj6j1XSLf93wzQ7YW0iG1Z9lkUHRtPHBpmKmXA/A0H0TAye7+7ih7JgcfSNVnNhJpkXXnY5OeJzxBCLJzXoQ6qyfr72gCKl7leoEd0dFZsShOg99H51opVltxnXn6DEIifLKBtr2UoYuyUcyQYTWmp1ROc85mbdWkMhR9uDqxxc70RwfTXj40wk4NFgMyEv7bq+MhDgczFw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:23:56.1263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c0fde0-01c4-490d-e903-08df1cc47df6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018070.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR10MB997772
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX+M51qwegKd9O
 dDuaO/h4kwfizBJICe6KDXX3xz2TCFymLvWSqaBaHWxDfM63D+ExXA1WAX7V072plNk0aXGO2h7
 0c/8TmyujgZqCKJPKXdHp6VurbkFFfA=
X-Proofpoint-ORIG-GUID: uLMzaoR87DGWCKJSygRrZiLN6z8D91mH
X-Authority-Analysis: v=2.4 cv=RLgmjIi+ c=1 sm=1 tr=0 ts=6ab95f3f cx=c_pps
 a=znIjPcDekDqyINJoq/POhw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8 a=Ep_Mk7Q0AAAA:20 a=_6mC_TdWDpcEeakgL88A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: uLMzaoR87DGWCKJSygRrZiLN6z8D91mH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfXy4rw9Y3nnszP
 y8cFFvgGZzNCUYdgCPgkSYUIWIUpT9roq09LruG32deKtib9GxiJqoVuc+A095/fBlxjtemJHz4
 7E1NzFdA5q3PsKrA+1wUUYh6yeBt/K0c9X9dl+gNr6ZuWiHMsumO2nqe6LQ+N+h+tS1WewSyncC
 Vzhw/Q9RWaP8FKTwYWmXR+JZb4VziS7sU4JeJyXr/EM+6XAbhyBmCsPCJlp1sAzpnJBv03Ke2DA
 fJDyIQEkLA2FlxDFB9vKs2jerPiOgg2UR9j4L3Zs5PJnieXIgQBolD7Ycr4IS/1pvJzG5vw+Zrm
 OkrpzW5dxjqbvHdrpy1ctofbSL9ZuuiQjP7kqrI04eWuRTwxUOujTYsGV5r/SbI43QfhwNNIfaM
 hmh3rzKNHmoDDXxW5611mcLcGaYievAOYgMxG088Wp2JUmzMyKVJoPJ8DlZU5jpERey8atz5hGt
 HJzJnnnOuRbY6q+XH2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 clxscore=1011 impostorscore=0 spamscore=0
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

This series adds a DRM driver for the Solomon Systech SSD16xx family of
e-paper display controllers (SSD1673, SSD1680, SSD1681, SSD1683), starting
with support for the Gooddisplay GDEY042T81, a 4.2" 400×300 black-and-white
e-paper panel driven by the SSD1683 controller.

The driver is designed and architected keeping the bi-stable nature
and low-power requirements of epaper display based systems in mind
along with having adequate flexibility to support varying use-case
requirements for the e-paper display use-cases.

The driver integrates with the DRM atomic modesetting framework and
supports:

  - SPI communication in both 4-wire mode (separate D/C GPIO) and
    3-wire mode (9-bit SPI with embedded D/C# bit)
  - Full 4-way rotation via the Data Entry Mode register, with no GPU
    or memory-copy overhead
  - Three independently selectable refresh waveforms: partial (~300–500 ms),
    full (~1.5–2 s), and fast (~1.0–1.5 s)
  - 3-colour BWR pixel classification for panels with a red RAM plane
  - Pixel format support: XRGB8888 (color path) and R1 (native 1bpp,
    zero-copy path)
  - Runtime PM with configurable autosuspend: the controller enters
    Mode 1 deep sleep (RAM retained) after an idle timeout, waking
    transparently on the next frame update
  - System suspend/resume: switches to Mode 2 deep sleep (maximum
    power savings) on system suspend and rebuilds the pipeline on resume
  - Runtime-configurable DRM plane properties for refresh mode, colour
    mode, and session control (clear-on-init/close/disable, init-refresh
    waveform); rotation is set at probe time from a device tree property,
    and border waveform uses a fixed per-panel default

Changes from v1[0]:
  - Restructured into 14 modular patches covering bindings, driver core,
    features, and platform integration (was 6 patches in v1)
  - Added comprehensive device-tree bindings support for vendor prefixes
    and SSD16xx controller configurations
  - Refactored driver architecture from drm/tiny panel driver to drm/solomon
    bridge driver
  - Switch to using GEM_SHMEM helpers
  - Refactored data entry mode implementation
  - Removed runtime-configurable rotation/border-waveform DRM properties and
    their module params; rotation is now set via device tree, and border
    waveform now uses an enhanced fixed per-panel default
  - Added support for Solomon SSD1677 controller variant
  - Improved session management with plane properties
  - Added comprehensive power management support
  - Support for panels with reversed RAM X order
  - Dropped RGB888, RGB565, R8, NV12, NV16, YUYV, and UYVY format support;
    driver now only exposes XRGB8888 and R1

This has been tested against my development branch [1] using attached
test suite [2] and logs[3], individual results[4] and result summary[5] uploaded.

[0]: [V1 patch series]
https://lore.kernel.org/all/20260430183311.2978142-1-devarsht@ti.com/

[1]: [Development Branch]
https://github.com/devarsht/linux-next/tree/epaper_drm_misc_next_staging_27_09_26

[2]: [Test Suite]
https://github.com/devarsht/linux-next/tree/epaper_drm_misc_next_staging_27_09_26/tests_27sept_new

[3]: [Test Logs]
https://github.com/devarsht/linux-next/tree/epaper_drm_misc_next_staging_27_09_26/tests_27sept_new/logs

[4]: [Test Results]
https://github.com/devarsht/linux-next/tree/epaper_drm_misc_next_staging_27_09_26/tests_27sept_new/results

[5]: [Result Summary]
https://github.com/devarsht/linux-next/blob/epaper_drm_misc_next_staging_27_09_26/tests_27sept_new/results/run_all_20250529_190854.summary

Devarsh Thakkar (13):
  dt-bindings: vendor-prefixes: Add Dalian Good Display Co., Ltd.
  dt-bindings: display: Add Solomon SSD16xx e-paper controller binding
  dt-bindings: display: solomon,ssd16xx: Add Solomon SSD1677 controller
  drm/solomon: Add DRM driver for Solomon SSD16xx e-paper display
    controllers
  drm/solomon: ssd16xx: Add clear_on_init/close/disable session
    management
  drm/solomon: ssd16xx: Add support for Solomon SSD1677 controller
  drm/solomon: ssd16xx: Add power management support
  drm/solomon: ssd16xx: Expose refresh mode as plane property
  drm/solomon: ssd16xx: Expose color mode as plane property
  drm/solomon: ssd16xx: Expose session management as plane properties
  MAINTAINERS: Add entry for Solomon SSD16xx DRM driver
  arm64: defconfig: Enable DRM_SSD16XX for AM62L3 EVM
  arm64: dts: ti: Add AM62L3 EVM overlay for GDEY042T81 e-paper display

LiangCheng Wang (1):
  drm/solomon: ssd16xx: support panels whose RAM X order is reversed

 .../bindings/display/solomon,ssd16xx.yaml     |   88 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    8 +
 arch/arm64/boot/dts/ti/Makefile               |    6 +
 .../ti/k3-am62l3-evm-epaper-gdey042t81.dtso   |   96 +
 arch/arm64/configs/defconfig                  |    1 +
 drivers/gpu/drm/solomon/Kconfig               |   13 +
 drivers/gpu/drm/solomon/Makefile              |    1 +
 drivers/gpu/drm/solomon/ssd16xx.c             | 2607 +++++++++++++++++
 9 files changed, 2822 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd16xx.yaml
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62l3-evm-epaper-gdey042t81.dtso
 create mode 100644 drivers/gpu/drm/solomon/ssd16xx.c

-- 
2.39.1

