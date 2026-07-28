Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D8CC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E334E10E8E9;
	Tue, 28 Jul 2026 13:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W+s6nHBK";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K1Bd5Mm4";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2ED310E8E9
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 12:53:57 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SBFIw83853659
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=Z0SK4T207p0msSgP1VSmkVCRrkHF8uHhmBGjWu/9j
 /k=; b=W+s6nHBKX0+OBvsd16hHEL+03UJ6HLf7IKCIrO7fCmk35P/BLYnJeepAS
 GM7xJGmT5a+Zbg/WgQ+7YTplvZgx7Wnzdz0bT8jfsYiTrJv5GftF7n3yYscb384B
 i6+ez8h1aKlwdG7tW86lPwPDnTjg+GwC8O3mYpV/H8w+0bdp9przno7Hr87DQT6H
 CEyrkAOPwy5+Fm6LEP/BVL9ywRZHOsFtH/VT8DMvYhninlD2leb/koyGB5dO2uJg
 SHnfe0cUPLXAE7RIRa/2YBQxAohnJZ5j/u2xHJUJQ9ldBvf7e79aTqwgA31QRcgq
 C4+rdzr+XrAJaLrkByXTi7MQ4Cfcg==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fpseb118c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:53:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSBTULEXYAo8aHCYcs7YfDvJ096Tg8DMYkEHGC25vqH5Dci6OUNxgyqCWBXoNHOKPkQ4R1nD7FEBL8QDY+EQFYABX6LcQolE5O2+4Vap04EE6yD720rQPmcP2Ufbn13wPwSwqcwjhpxBZ1xDWpcP6FQEFIeJtT9/5YMEVz8Y9zp+LIQnBIRryB+XOG0xhpOBBXzSTSD1zqm0il/uepuJXtRfYPRXS2oFdKNJWNkk1+chz0fh5uJYDx3PiBOv/Hg0I9bTlpmx1I6RPwLKJtrMPEpB72njCQXwUJa5bHoy/FmETdZNSHVUw1HH0dKhKAsqEdIzNq7SYw3tCqgyMp3vcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0SK4T207p0msSgP1VSmkVCRrkHF8uHhmBGjWu/9j/k=;
 b=DXgWClNZg62/QQDdDbnn6yxzKyDVIZR06U8wt11T0cmp5nDXP9XQzxUGlpBv/GP9fljyHjlO0QM0FxF2mIAlGP0jmbRnfocxWLIUoFPqqCdBqnc6LgyjTKLxX94p+ZI/h1yWUhyW3Rst0BUOVOoky0ZE9JP9mBCFwc07XrmuLqtHEi29hXT4QuSc//qRaBd3uJ7FhkJQofJJTTPBnRByqWXkA5FTAULRPilrea2Fe8BY4YsoAjO80zmYG3wL2SSHLmdF0yATJn0mJ7qs5eSRfYH8v72wGxnQcpq2BqfWN7Xi/rwVrYYSdQoirDoFl0Hne9tUDNQc3v9oTD7nPiUt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0SK4T207p0msSgP1VSmkVCRrkHF8uHhmBGjWu/9j/k=;
 b=K1Bd5Mm4ujwtIBAup4dsu6+YzA063hAaqrqUyYh7LzaLc4FYM96bHAbkqSn8g6B/Z6reKYK8OPgcyst3BzFjkBnTAbyg4dCwZjvJOiBUc8BzTQNDEho1xS10BuSHpbVS6U60S8iq2QDlCOWs21HyG/nOUSGtQNQ7r5OGSz6q6cg=
Received: from CH2PR18CA0043.namprd18.prod.outlook.com (2603:10b6:610:55::23)
 by BLAPR10MB4833.namprd10.prod.outlook.com (2603:10b6:208:333::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Tue, 28 Jul
 2026 12:53:53 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::64) by CH2PR18CA0043.outlook.office365.com
 (2603:10b6:610:55::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 12:53:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 12:53:51 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 07:53:43 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 07:53:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 07:53:42 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66SCrdf92709466
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:53:42 -0500
From: Yashas D <y-d@ti.com>
To: <dri-devel@lists.freedesktop.org>
Subject: [PATCH v5 2/2] drm: bridge: cdns-mhdp8546: Add no-hpd property
Date: Tue, 28 Jul 2026 18:23:36 +0530
Message-ID: <20260728125336.776116-3-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728125336.776116-1-y-d@ti.com>
References: <20260728125336.776116-1-y-d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|BLAPR10MB4833:EE_
X-MS-Office365-Filtering-Correlation-Id: 83636d60-9806-4a14-9c39-08deeca74624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: fsfFM9Iej3hdkBX0b6DVYUH6CFI+jaPeR8RIb86UodIHOCept8RJVWyvoxd6QM57erCXRdL/6r13ogz0pW9L0ePvRW0Ck2/0dmmHy/BrTcT9zZbNQtyzxKDFABGHYubPiDILXVFaMvNuw99IcAzhU5lg36pJ2Pg7t4F2XrEBsZZQAIstja/IWruDdl6Sj1/KIeJwJsIMpsE1yKUymwCQxzg2rhpK8az1uX5ASH60Lfzp47cO6DIE8bokJto5IiBf0W1h0VsuGfij0nZ0EWe6r/egulBGU68yvpABXshjE6isyBJ9o+o5mj3BXOh2QjXYocW5yOxBiNBzpR824wFeQKJPjElFOq7ZJRd80pu5oDKvbXqmiu2ad39zQXEQ1g2Q7N2QJxlo55+aGVf1Dz61xmGBk4yjZexCPja9I5ma79vVp/xgRJPeoZ/G8g/XjHzFNvJRM2y/NdEsDMDbSjEqPrmGwIFcm+Q2C8Bt33pYjEbn4OMYmtbEG6+/WDgwDsTC68JJSgIk1gMdf49MwP06bCVTde3jQ6wJWjINLl2nLKC+//shMj9RRJIfE4wMdqOJCjhDIfY+82d9DI/0GoYIB/jZtP+FmB6q9X562XmnUwRS4QtX/TGCr3NLTWF0dU7EDUTL75V2yDYX8XYLhgjCF1elmYKs9C5Ii1UpfOlPS++PMo4q+t+3Y2cTvf5Si1a5
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1DauR+kYC9T/o2o+Zi8MXUSlDVjg66DSZZgFohp6urlgYghYOuoxoJV7l8C1AyebMAQOrEJoi93viCTXVn3sfj8siyXGelEKGakuwVVRcdnIjzoCt6eLat9tYw2XCfaXCWBA6JACGBso8u4odzgAw6xcoLuCXKaVbkUx7aHSBFwivnSHhZYtzqkoTNVgXP2D+mI5tTcn3VjDeVU/kEwGk/qC/MRMvzkT5oAB/et/mFbSV+u4dyvfqdSqM44YROwuMacpy5y2Io0g16NGttKwj68Cb3jOltSaxfAbzv5EJxG4Y6FwRTICEj09KmbatmE5Ut6vuu4/r3mcFEjXh/pr1ztLqjGfAcbxk3laXVDqS4WT2tqcPZ7g08Xzha6jnf3ojoYtUHhfDcZ7V6+jZMuOhQ2BtiTqq1tXVvtGe3d/vwzLT+2Obrz8Ku1M02/8TRXz
X-Exchange-RoutingPolicyChecked: AGjZrzW40DmRKfLHA9Sux/WWz4p6di3PufjInuuv9QmxDrG0jZo3Tk47rRAD+ONRZAhr71tWA0fAjDIFXtqUzj7ibCbT5ye/KNuOeoBwAfY9tVhBICOSLkD3tfaBdnmqhYnHn8Zue1y2HAjBuEIQjSl/CeTCFUSiJAUoDMp1/fs2kV6Sji6OO5IcAExhYsSQe6chvA+/PzWJD7WBVxmcDg6Wt4s7TaWmHqcADEkZhRiG8BgkzkHCFNhlIzAwQmfGzFz81mjeT79IjZ8wd/tAEObybRjNqI/KzS8YZ19Jwbj73cptc0ShLj+PSaW7hn6NLGdqhcO+GGCIJw4/Q/VAfg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 12:53:51.2715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83636d60-9806-4a14-9c39-08deeca74624
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4833
X-Authority-Analysis: v=2.4 cv=c46bhx9l c=1 sm=1 tr=0 ts=6a68a664 cx=c_pps
 a=9AjoWhdl+q7f6/Aw5qa/DQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=hpHgAJOo5APm0W2vkfAA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: fM7IdYMO6Ul_LjM7TmMb_BxRp2tzNbJG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExMyBTYWx0ZWRfX29kl8z86CwbG
 on692gtIkFEQriaqfMXAB6uSge/48eWq8h4Km0yKQbfbCNm4eBKm8TpXqy8CDyc1FlMcVmEbRIz
 V8ELdtfnBTpUOcvCyOIS+LLCAbu1CZA=
X-Proofpoint-GUID: fM7IdYMO6Ul_LjM7TmMb_BxRp2tzNbJG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExMyBTYWx0ZWRfXyxbtUXF93nZW
 iMD7WGX4+Fxv6kPnB5xB13RxKoYRfe9NhEfxWmltOvHoYY4dM0SjWB7/swscJvhjpzyQRK02zll
 LFfW9WMe2Un9pKUucV56O0Tj9H5AzkQvEWiX+36/8KDSuEOKjRT8VXrdA7So61c3DcnuHF2ZkzY
 AXLTzHf6vCtVkmdj89Xpcu2LYnohdJhTrkJUUmcfYpLryjs0MLluPBx0gkFQBNB4gtvSJt3+JuP
 piFHL3tykdDX/7b5GY/2GUvAFUi9gymJyAcD2u00SQpDJkELl4wHrlGWG41T/LXCgFb6U7d6LkP
 ju/7jb6eOlHMUbm5EH7w3SkZqfGS2tlNeUXRpDLbWcvx+z8TD9gMVzU+OQOmXGngl6U+LPZYMey
 0nJFgQ5J4HvTxCcdzDluO24pLmDO9O4zAArlfWTXd3LG1oItyAuZTXwyS3CkCdBql21MY4bZVVc
 S+zM6L40t0bsqXoNcRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280113
X-Mailman-Approved-At: Tue, 28 Jul 2026 13:01:39 +0000
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

On TI J721S2 EVMs, the DP0 HPD signal has a MUX conflict with audio
functionality. While the HPD pin is physically connected to GPIO0_18,
routing it to the SoC requires sacrificing audio capability due to pin
muxing constraints. This board-level hardware limitation necessitates
an alternative detection mechanism.

When this property is set, the driver uses auxiliary channel (AUX) DPCD
reads to detect monitor presence instead of hardware HPD signals. The
DRM framework polls the connection status via the .detect() callback,
providing hotplug detection without requiring the HPD pin.

Valid use cases:
- HPD pin not routed to connector on PCB
- HPD signal muxed with another function (e.g., audio) on SoC
- Hardware designs where HPD cannot reliably detect monitor presence

Limitations:
- DP "attention" IRQs from sink will not be received
- Hotplug detection latency increases to ~10 seconds (polling interval)

This follows the same pattern as 'no-hpd' in ti-sn65dsi86 and panel-edp
bindings, providing consistent semantics across the DRM subsystem.

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Harikrishna Shenoy <h-shenoy@ti.com>
Signed-off-by: Yashas D <y-d@ti.com>
---
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 58 ++++++++++++++++---
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index 504a3186ebb3..73d5c718c7db 100644
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
 
@@ -788,9 +792,14 @@ static ssize_t cdns_mhdp_transfer(struct drm_dp_aux *aux,
 		ret = cdns_mhdp_dpcd_read(mhdp, msg->address,
 					  msg->buffer, msg->size);
 		if (ret) {
-			dev_dbg(mhdp->dev,
-				"Failed to read DPCD addr %u\n",
-				msg->address);
+			if (mhdp->no_hpd)
+				dev_dbg(mhdp->dev,
+					"Failed to read DPCD addr %u\n",
+					msg->address);
+			else
+				dev_err(mhdp->dev,
+					"Failed to read DPCD addr %u\n",
+					msg->address);
 
 			return ret;
 		}
@@ -1523,6 +1532,26 @@ static int cdns_mhdp_attach(struct drm_bridge *bridge,
 
 	spin_unlock(&mhdp->start_lock);
 
+	if (mhdp->no_hpd) {
+		/*
+		 * In no-hpd mode there is no interrupt to signal firmware
+		 * readiness. The firmware loads asynchronously after probe(),
+		 * so we must wait here until the uCPU is running before
+		 * attempting the first AUX channel poll for monitor presence.
+		 */
+		ret = wait_event_timeout(mhdp->fw_load_wq,
+					 mhdp->hw_state == MHDP_HW_READY,
+					 msecs_to_jiffies(100));
+		if (ret == 0) {
+			dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n",
+				__func__);
+			return -ETIMEDOUT;
+		}
+
+		cdns_mhdp_update_link_status(mhdp);
+		return 0;
+	}
+
 	/* Enable SW event interrupts */
 	if (hw_ready)
 		cdns_mhdp_bridge_hpd_enable(bridge);
@@ -2013,6 +2042,9 @@ cdns_mhdp_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connect
 {
 	struct cdns_mhdp_device *mhdp = bridge_to_mhdp(bridge);
 
+	if (mhdp->no_hpd)
+		cdns_mhdp_update_link_status(mhdp);
+
 	return cdns_mhdp_detect(mhdp);
 }
 
@@ -2100,7 +2132,16 @@ static int cdns_mhdp_update_link_status(struct cdns_mhdp_device *mhdp)
 
 	mutex_lock(&mhdp->link_mutex);
 
-	mhdp->plugged = cdns_mhdp_detect_hpd(mhdp, &hpd_pulse);
+	if (mhdp->no_hpd) {
+		ret = drm_dp_dpcd_read_link_status(&mhdp->aux, status);
+		hpd_pulse = false;
+		if (ret < 0)
+			mhdp->plugged = false;
+		else
+			mhdp->plugged = true;
+	} else {
+		mhdp->plugged = cdns_mhdp_detect_hpd(mhdp, &hpd_pulse);
+	}
 
 	if (!mhdp->plugged) {
 		cdns_mhdp_link_down(mhdp);
@@ -2288,6 +2329,8 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 	mhdp->aux.dev = dev;
 	mhdp->aux.transfer = cdns_mhdp_transfer;
 
+	mhdp->no_hpd = of_property_read_bool(dev->of_node, "no-hpd");
+
 	mhdp->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mhdp->regs)) {
 		dev_err(dev, "Failed to get memory resource\n");
@@ -2360,8 +2403,9 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
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
index b53335b0d22c..24ffb732a207 100644
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

