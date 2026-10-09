Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5908CCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 06:42:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B29110E148;
	Fri,  9 Oct 2026 06:42:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NPjY84gP";
	dkim=pass (1024-bit key; unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="iQeoW9zH";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DA7F10E148
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 06:42:41 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6993Igph1059029; Fri, 9 Oct 2026 01:42:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=q+E9fqL4MqiAz
 dmD6tc7X2E4rha3el9JyAU9xOg284w=; b=NPjY84gP5WnIjQYjKpO8nr4+2JyBC
 n9ltPPMh5l386IWb+MU/xbKiLiD36g/6tBgTPLQgkOEcYz9wVpd4awmXDm2Z7Rss
 2LGwl6UH2hetQSuAXyh/uHD+YUXN0B95mDbNkyxPBY0EaxwcAfht70mM4q2Ab/2D
 jUS0+nWQRkeptJCuzXi5v+Y9e87dje7omfaT3lCVB8afG347Rgt5G1ztWpdEnbVF
 17bcBKArGmXKfhBtl0qUxiINxXQASAJJDvjx+8eLA0DvkRmxCd33sSW6wS8gmr6m
 bfyW8/xRIZO0YezZvEPtNLLGJjbmJcaM8dWaNUymJFRXXVHP/WPQOdodg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013048.outbound.protection.outlook.com
 [40.93.196.48])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4h68h2pwk7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 01:42:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTMEvP5wjuydKh6d/xfREYzm8LqxJ7/6907tXBCNwQSFyosY3cujmN8Jjfmsg43iKGPQKsctxMAZgsViIFwZ9We2rJMZeVlEhwXtwIsyAU9IKXxrsMiC21dtrMwsxarZNSTIsbZV+teLVcGiBhpv0AHAVyPv1SZIAgy2MpKgeYv8GPOS38nZdHOmKLQ3Gq+598gxs3bwlTdJOhVsMhE8r2JNaqrzCP2yzN+T1WFR6Du2/e4hM7i8KNiSB9JdEDeur2ZCZiG8EK821HzZT7pwODr0+U/GUTEOolYDDNA/A7yoERQZLnBvVyOpIPKDQvfNQLbh8IPvwW+ccMu7ly5Juw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+E9fqL4MqiAzdmD6tc7X2E4rha3el9JyAU9xOg284w=;
 b=CMbwDZtdNrPu+d55ZyGFr491qx5Db8sAp+wWaVKkkfpGFoT8oI4ia+UUVZa8l1OJfYuwR7u+Oika66Q+RdB8mRgkCqgTJANhGgCZxQAZoMtxETeMr8bgJYmkxvqHxq/3xrBNWYHyls4hwK/tzGd3HmzWAtTNFRdOtH77otyHz4ZwJElG2LzPbGNQcYVYsjXOk9bToieikKRYlSeFBshFVHbF31QCdwMQrO+rzd/WzAC8u1nws74C9zWbYtfvRiDlWAvPA2H4nsBh/vYIdSsStyc4Vs/PinUX4VdPIBBzqpKM4ZlV0XA5b6AzbjWzRGwPil/ISEeWeqOhf2Jlp3YP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+E9fqL4MqiAzdmD6tc7X2E4rha3el9JyAU9xOg284w=;
 b=iQeoW9zHiU/dapupu1klKcr81/AVOue5tLzypGs7ZCxohqPpn75M+3RGd8rcU20+v7rDjWmH1hSkVCLwxzVcx6XbmoVGKSyZT8rWtDQ+U1JpHw6JKX5lwk2rfDJXn0Ew77Ia4/hMItsoIu+9kvQISuzan76+by3s4A0bJ7kJaYo=
Received: from CY8PR11CA0010.namprd11.prod.outlook.com (2603:10b6:930:48::22)
 by SJ0PR10MB4574.namprd10.prod.outlook.com (2603:10b6:a03:2dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 06:42:14 +0000
Received: from CY6PEPF0000004C.namprd03.prod.outlook.com
 (2603:10b6:930:48:cafe::58) by CY8PR11CA0010.outlook.office365.com
 (2603:10b6:930:48::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 06:42:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY6PEPF0000004C.mail.protection.outlook.com (10.167.247.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 06:42:13 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 9 Oct
 2026 01:41:40 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 9 Oct
 2026 01:41:40 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 9 Oct 2026 01:41:40 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6996fXfu666824;
 Fri, 9 Oct 2026 01:41:34 -0500
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
Subject: [PATCH v7 0/2] Add no-hpd property to the cadence bridge
Date: Fri, 9 Oct 2026 12:10:22 +0530
Message-ID: <20261009064024.985688-1-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004C:EE_|SJ0PR10MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7a0228-4af4-4b4a-3ed1-08df25d0737d
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|23010399003|7416014|13003099007|921020|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: yoqMJR3ICEneJx5k4UiQbguzQI9M0+DwbAfKaCZmbVdaP0aC5Y1J2SKmVS+6/tEVIkPwbu79iDr1GhVxXBU6kRgj9D1QKtzRs1stad0E83RHACJXpiPdtWem+Ane5qZj+BRLE3XKW4551hesSU1fzQGOWuldEW4W/YUutcLx4+ko4+0GxtOrtrwdC574gH2wMuMxsltbqiBdIs7s7OoxnCWIk9zhK+7abuJlbFsOqhLjdw2GglUmKSc7hPbF3e9Cs++Ao3qjzB5xrBKFBRitjWDY/MCOUQh+Yg+BLYNFJcfIZrrJcXXgyE6yHw0rT1izZNpbGVokC7viay68vygcldEeQKVWbdMvm1QRhwuHLp4t47Xy+MEcJwCXKoTvIy1n9u3Js+EwLeGItBc0XXhhUfA2Rr7cQt4g8GbdaPqNxiG/nVtcweAaFM6hgu5eYmdsfMw+jmko1fcN7oQmHKctmvqSiMjVLHp7QYrG7EnntxTd2aqwLnRYaZzzOsySHDeiWtJFAJlzYGJ0lQmx352tGDBM2FwcnhKJRM+N36T8f4gNrjVMppvvnBiYDcFK6XPDJjkenwP8RYQrzlyTixh5CQstHF7k1DXV4lCQwxgJgIIFVFry/YUM2dzSygLXStQfpjtzTr6/lAvr6Q+RV/Qg7UHpwIUgUKLLHy/GBajCSkpQ/UT2ISpeRvpCXCCPzaApkmdwmo24L7ceD7WIlGRXcbeBvtUJumioJXoMi/YaRT850XWfAq9LrE9lOPwdVTmd
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(7416014)(13003099007)(921020)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cjLKne8ZItuQrZKuAM+LC2r/Z6Z4++MwM8B8aFwsgUt2YDhEIcMClVrasp4T+0aIQ2wwOEUEB4TeeDXC34vi7y94OxSNnpAwlv2niE/8n6ZsAxkW07ctfW65o20fuESPI3QqxDUokTgsQT1HeqlqcDQOWLt6No13mL/Q4M9Vru6ioFWcgTg90rVXYVDEx8s+BiH5C71Hg/VFsE9Xpt4IelDUVNo/zsUYGh8kG5oROkR1jblvnryVYyOZ8hWkvlQV1Dse5Dj5d9EBkvLLJSJFGOLrnGziRGBUOKqm9JNyBxJIQkivhi2WUx0MR0elkNxJV6+W6gGAyK5i7JGFKwHgSWkKuc+Ckr3xmIXHXfIDYE6JH8Fak4RZyapwqsoEyUrs/vKE4Nc3ntC4kf1E4fN/0NPXpPUtSuO4Y2tDeYO/4tTMgQkU7DJWpqsqQZpMPH7G
X-Exchange-RoutingPolicyChecked: GnlimDjWsOOfds+wE4LxssE8Kz3zPwc/6Da06T6TjIOk1mNcV5wzi3jqKJDc71vI/luacMks2nOEFUtOqsija/XXYe+vkS9/aVoT8SfbHGwfMm/OwW4pQ4f5YtRDsSTrg7FXX4INKzIg7nyoyzrEe0clUfjqyRGik8k4kmIwLbAHY1TVApNLmhuep6R9xdjK1DVCubYo2s0YPDS9w7H+HbdYjhyJNZ7IpeKrKmkhZnkEvQf04gbFE6CoxM1ZrEwcFC8KV08N/GqfubxDVcK2smmzE6DRDaiAAIuO8Qpt8BrwHe5/5Al8tr/6DjO9JvdpYHyI3sJw0ZtnbvgHcsQ86Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 06:42:13.0066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7a0228-4af4-4b4a-3ed1-08df25d0737d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF0000004C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4574
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNiBTYWx0ZWRfX3V7CXPzEtCEh
 jU8u5W+i9F+a0oNcxAeYKm0UKuglerFWTHCV0RbW3+FuH0mh4zTArKtfexyhM2J0Y9ofcgpAGKk
 t9IO8KHMa8ggMFpCLzmhdSs1bRRIDqgeVyfBroWMsWGjIl2RuYb63jOZkPmpgjw6jKQ388f9Dl/
 m/GrxOpS3ZbcRM/RTsMih/A6HfPErBmdKwidERe/Pn4ZCfJ5vQai3qOdBgSP865tR+ahGUQAQx3
 iE2JiCOF7oTEIsOyoNjdWa+RPNF7zyW+2+wbjS4OtNactsrwrNUJyBipB7z5NMAZm7dnWOMnilQ
 wM4383IAkL2wFUoeBzsqquQx9rinXOejLJWC3RyLAN0TcFLAXHp5SlV5uaSQfWWprxOWd/wWezR
 pvpiP8o/Qdzt461FCBySLKAXFSEeGf93tVNDSmX6QgTtf9xo+BUFwOH7YtNpLA6PNuyIamTqQ6A
 eD7P4szMLWz6mRPNjxA==
X-Proofpoint-GUID: DmLwNIX-KK2wedf8q4IGQPMp1zpyFMFc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNiBTYWx0ZWRfX01M3Q0SU3XoG
 d++8o+3qPl2ldL0X30+OkVWbWNslSGLCYSHBoiL68vWVw4BqSrQLQYBLcw8teXAZidM2FjIUvC9
 JMzd3K8AaFvLGMLSo5MOIEqypyafGg8=
X-Authority-Analysis: v=2.4 cv=a/WlZkSF c=1 sm=1 tr=0 ts=6ac88cc9 cx=c_pps
 a=BzYQZFXHgS3DonsPiq/7CA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=QB_yHwAkhtgrPd7RwJsA:9
X-Proofpoint-ORIG-GUID: DmLwNIX-KK2wedf8q4IGQPMp1zpyFMFc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090026
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

This series adds 'no-hpd' device tree property support to the Cadence
MHDP8546 bridge driver for boards where the HPD line cannot be used for
hotplug detection.

On TI J721S2 EVMs, the DP0 HPD resistor is DNI from factory, so the HPD
signal is not physically connected to SoC pin AA24 by default. AA24 must
still be in DP0_HPD mux mode for the MHDP firmware to operate.

When 'no-hpd' is set, DRM_BRIDGE_OP_HPD is omitted and the framework
falls back to polling .detect() every ~10 seconds. Presence is detected
by reading DP_DPCD_REV (0x000) over AUX, with an early exit when the
monitor is stably connected to avoid re-programming the stream each poll.

Changes since v6:
  - Reverted back to dev_dbg instead of dev_err for the normal hpd case.
  - Picked up Acked-by from Krzysztof Kozlowski from v6 on the bindings patch.

Link to v6: https://lore.kernel.org/all/20260802153825.1570435-1-y-d@ti.com/

Rahul T R (2):
  dt-bindings: display: bridge: cdns,mhdp8546: Add no-hpd property to
    the cadence bridge
  drm: bridge: cdns-mhdp8546: Add no-hpd property

 .../display/bridge/cdns,mhdp8546.yaml         | 11 +++
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 69 +++++++++++++++++--
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
 3 files changed, 75 insertions(+), 6 deletions(-)

-- 
2.34.1

