Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DB8C55189
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 22:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF05C10E476;
	Sun,  2 Aug 2026 22:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qQKeWE1B";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="k4aYPNnZ";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7888510E09F
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 15:43:11 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 672EYawn2519561;
 Sun, 2 Aug 2026 10:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=2/KopWe4OoeLd
 rcW88lJZ0SeKWwG8JhPUZyziDN8XrA=; b=qQKeWE1BVrwaS4TL2PNaRA9WJYUai
 gLr0VZrNpSSKZSQGzQx5TgJcpWqM9yjXF6kll9vs0LjyRhscvsNcpWlYmeEcBtTg
 M2AllVkyB/3UTR1Ic85Dq2Lh8YiUykQybRIIhNZAuV2PxaT0fT0wk6i0SSlFHRKN
 9u1hf+/GR80d7a8cko0cUyoKhgihrkvOZgqxdr//2w3DZ14OvNdOoBGWX6FgTGkk
 iWLUU3fPivyzYcN1mfK9s3GM38bkHx5aowo3tcii4YaZ6pAnTgyjVMAjp7h9w4oN
 6jcONXVg1ECCkk8fecnPYc/5dTSB+dKTv9k81oYLIVGE5Elq3qwCpPklg==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
 by m0384305.ppops.net (PPS) with ESMTPS id 4ft2rn0ytb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 02 Aug 2026 10:42:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4B8cMHJFG75Z0vPMkXG9Jg2AooSze5JdlX0J3QPfsF5eJYdduBYoYden3v6hPX64jP+tVcCbs9sDyJ80AMhCe4FDOWQW8PapRrNlZoJ3fJ8bILpcz7cg/EDPfZSLr4P2EuiiUImdb9bl9bcs9sxzVu2yNjzFd+0JbTs0++0kLN1CX9HS0NQ/KUJ5lnVZ23At807nAMwYcrO4hjLWf3De5n4c+5izzoWzSjLseeurQAXCOfyfzjwTwyT+4UdP1e23KWjuPGNcXAghBSIdxPBLmRecUyJLKuyLEprhi2NS85DNXiwk4pGXWlzGFtkyhLGeasj1Zr6YdwY4qjOsGrxAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/KopWe4OoeLdrcW88lJZ0SeKWwG8JhPUZyziDN8XrA=;
 b=N6O1amqA90mJo0AP2NdSaYrTQ9aHzvt5JWxtRbNjp3IRXa/kYzkKgNqtxCLHsX62mf6B71PEtREyQS1aDubTZOp8k3RFJ/qK6ohquhAQBcGGKBD/s+nUAm7EUFVyDAfXGQ7nEtAFDEOv2Xco2kfIoG9TmJau1eI8ZNVCd7aPu9xE/LM83HE5mQNApj2Zk1CQtlbmjuMRByXLJS/goT86Cn7rnLkQtgdnKIkNCLUPXmlbkZuqeWwDcA+HEpxIrIKAjKWWT115eNjwbcFjLN+9XD7ruP3XBi2ry2I81w7fkmjZRq00gC6mrWWhbcwZHNCiaSIPXk8jiB8IQXe6rb2UNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=cadence.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/KopWe4OoeLdrcW88lJZ0SeKWwG8JhPUZyziDN8XrA=;
 b=k4aYPNnZ9YhOSMgLy2mtKfeTKzNVyoVfxhW7dz92r1UopUXyttG6ZHo5bGLThEifVWGiABedB4YIGZdnDxrNVIOdYUIcQFKCORKWVRptvueYT3RQiT2pQ68x0HteCyckko6GNsQTuhAc5MST0EuljXSLVZ7roiBdMPZG8FYD4m8=
Received: from SJ0PR05CA0093.namprd05.prod.outlook.com (2603:10b6:a03:334::8)
 by CY5PR10MB6069.namprd10.prod.outlook.com (2603:10b6:930:3b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 15:42:44 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::af) by SJ0PR05CA0093.outlook.office365.com
 (2603:10b6:a03:334::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.12 via Frontend Transport; Sun, 2
 Aug 2026 15:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Sun, 2 Aug 2026 15:42:44 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 2 Aug
 2026 10:42:43 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 2 Aug
 2026 10:42:43 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sun, 2 Aug 2026 10:42:43 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 672FgZ13897228;
 Sun, 2 Aug 2026 10:42:36 -0500
From: Yashas D <y-d@ti.com>
To: <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
 <jernej.skrabec@gmail.com>, <luca.ceresoli@bootlin.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <tomi.valkeinen@ideasonboard.com>,
 <r-ravikumar@ti.com>, <sjakhade@cadence.com>, <yamonkar@cadence.com>,
 <u-kumar1@ti.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
 <d-mittal@ti.com>, <b-padhi@ti.com>
Subject: [PATCH v6 0/2] Add no-hpd property to the cadence bridge
Date: Sun, 2 Aug 2026 21:08:23 +0530
Message-ID: <20260802153825.1570435-1-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|CY5PR10MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: 33dfc81f-a674-4b62-cf54-08def0acb202
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|56012099006|10067099003|921020|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: DYYlukPN8SP1UrvuDBsuGl+AeBq2B237Fmbb7aojPEzqMc8erDmx9Td2CHZ51jR6IckpjO16TSGyiF3AHVZAaYam6jEfgVQsgtYS+fAYrBGRGv9AVkrh7sVEFsE/1apDJuJTNcjeeTbECDKBhixo9CjNsBBEiXld70zVWpCBdMGnzcimrkQ+w10CGR5sPF56LHpqR+jpN3jYeyNlCYkcVyLoPqv78B/0FEfBvB7S1hTiYrwn5i7eJSbCGxzE0mXvR35r9phtEI/ImHdJu73tbLR0GAwyDzifC3wloF3flD1mzZBuwrK2F6hg59iRrlPFs2kQUnhaL1/gO+4RGf5jS4QSZPFxpH175NU/GxhKvLBpKc2/JrNJ/evDfsL6bOdZSzaLcn6msATCn+OlwT5mcTy27ywEvFIjXjyYEBbqprQEJEuGQRoKv70yC90Rq80OCXHV3AfRnyCS5XMr8dmUNkmO/V0MhDlpsV/jLOW2Z8RN0x2PjRb2CLVNafvZ25blnmkJEbch+IcKKGcoIOypIQSb2oeUFWlHieZrCNC1yCFUUdY4ohQKVvoHwChgYCS9TYLt8zbfjM6a1Z9hGqHOIpWdW3g1p8tv0EbF/7StfhVdAaOuwnSsxVka9/B5/UmO4Mljk7Gm1Jl/qh41Qz6mjM9gyfjrw2TUNsO6+ICmLQlKFocDEzMnfo6dpK6PNuJgTU0RN/8A5T9OzB882A6mG67nX9yooCYYXxDZhK6yvckvPTloNDQUkdqQ6H3CaGTi
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(56012099006)(10067099003)(921020)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: laeXin6DyPNrQ0CqvDB/hx725aGaSJyHSvE/mACS6W77npBKELFGhdg92YXxzmauzN5xQJSdpGtzaWQ7J1Fm3FqccMRRpQWxLWExMVvXCZZBIdNlAF9iUd2iBQzl51MzB1XchI3z/4Aq0MXkt/gtpt0xWupoLwnU2UykAwsGDUYE7LaTcZe5xlw1KcDBIoLVrsBaEcAKKYSMvKIWr6irDaeR4F8IUWcGcpQAGS5UrhVQuI9ykrLHDDMxsSX2GAi1YWXoeQzf3QPVxt5b5SDsSwRHnAj09Kxkd1x3mjmoVTm2f4tRSymzkXUMIztOgHVI/nxrcSMgBAe4+n4CmdbRLCyDIgOgfLTx95VTRh2akflmVkBN8ZI0ARH+bFO8RyXj+iG8ak/dhvEw9OS/UThkrRhHEm+iIEzU2tCY4OVmPZPn2x0C1nwHuVGbWkknk41O
X-Exchange-RoutingPolicyChecked: dAjcWXdd4olpE22IlThyFIND7BGaCNpeAxF3fGgl3Rfb73R1q0TSIfAj0xXMDSe7JQEXDT3NP8bObNzVvbIBo+aVD3RcXUtq1nc7nLB+qJMZgy40ij2G6IO6IwWSgBZIJhStQ+T42AnCoBWdJ0+3VY4fQOj1uOC1ZwRYzC8B1rqkSfu8v3/dNMOqmYkfv1rzh7WK5GYQCFy5cL4uqk6a9lMArjdFEyUv/moL1S514Je4K3XmzCPnI0s/yHFglNhT5AOjI4qBKfvIHnMCtfNo/+9kFeSzpAJpMfTXEXDWgWJXqlxlJFExr9l/2fwUShswaLgPmuHpCvC4E1lGkAHjRw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 15:42:44.3481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dfc81f-a674-4b62-cf54-08def0acb202
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6069
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE0MSBTYWx0ZWRfXxh8B5tuvKrOR
 tnwcqNZiwItd9U/PKPN3+JtuDD3Gb+GxBQlJcUIoGo8JRacgJHHXgcmPOrHzVhVI4R/LAwrRGkK
 JG9Qrp1yee9QBo/dRRuWeycy9kl8F/8=
X-Proofpoint-GUID: BiTG3MJoAsbpMt7xQDHpwNU73rid05RA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE0MSBTYWx0ZWRfXwOXUvKvj3qyw
 bva0vlkuW3eJSPkxMGV2AyQGb87Bc74NusRDXeYzWlGbUITy2amxAPgRNTLx2zteG/kAuc4xZ/+
 9zoYTeNqiAs6g8e8aXkAbNfxBgl0m45fq2XNkyQEj4pJJTsMEaf3P1i6QFofVQUIfaKVZY1Da9C
 jsKPnm5CcWI1HSbB+EebJHrlsVkZDL4BZZo9RDnzRONwkaLqyPOpSGqYvkYR45q1KC1p575IVBb
 PN/R40wSJbeWEoXASP+dhSZNuZUUi0AOlscB2noLNQ/y4YDtiZeGCmpwUQSDwCCjwyXYLtQ9efj
 kmJWt6E/5Jd9cwICcQLmE2hPE4rOAHRjThPzv0QIabyvjEQBS9B8XIxUdl3Ncsk+pDMrBmWVQPZ
 8AS8Tw8N2qixr0T4x+dAdwO4/pS6/mn40DcwSI8r3ybubbUOW4i/8bc3HN7mtG5EqZ5091MMcHt
 IXWsZmuyDBaOAhKrggw==
X-Proofpoint-ORIG-GUID: BiTG3MJoAsbpMt7xQDHpwNU73rid05RA
X-Authority-Analysis: v=2.4 cv=W5sIkxWk c=1 sm=1 tr=0 ts=6a6f6577 cx=c_pps
 a=AdSExLHk7727Th38kKp3hg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=9-QY_qRTy5mdCz-8vT0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608020141
X-Mailman-Approved-At: Sun, 02 Aug 2026 22:41:01 +0000
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

Changes since v5:
  - Corrected hardware description: conflict is with RGMII1_RD0 on GESI
    ethernet board, not MCASP1 audio
  - Fixed YAML parse error caused by bullet list in binding description
  - Removed 100ms firmware timeout
  - Fixed sst_enable() called on every poll: added early exit when link
    is already up
  - Switched presence probe to DP_DPCD_REV (0x000) to avoid reading link
    training status registers unnecessarily
  - Fixed lockless hw_state read in bridge_detect(): now reads under
    start_lock
  - Fixed data race in attach(): use hw_ready snapshot, not bare
    mhdp->hw_state after lock release

Link to v5: https://lore.kernel.org/all/20260728125336.776116-1-y-d@ti.com/

Rahul T R (2):
  dt-bindings: display: bridge: cdns,mhdp8546: Add no-hpd property to
    the cadence bridge
  drm: bridge: cdns-mhdp8546: Add no-hpd property

 .../display/bridge/cdns,mhdp8546.yaml         | 11 +++
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 79 +++++++++++++++++--
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
 3 files changed, 83 insertions(+), 8 deletions(-)

-- 
2.34.1

