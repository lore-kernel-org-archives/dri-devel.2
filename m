Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAC4C54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:01:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E947410E8EE;
	Tue, 28 Jul 2026 13:01:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W/0VF86j";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aq3zcJ9k";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7F710E571
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 12:53:48 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66SBEj4Y1103459
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=7HpzrVsb9fvgQ
 h18aGnHqutVeuSYkOhIPLB9u7hZWT8=; b=W/0VF86j8+uxtjvj7MQLYnLhSDdGV
 07LQv/22Y5hCrSnd+h/qoHE5d6/hfBqLwrHgCfiL/be0dSayGYql0SWAEL16UKX3
 H1lckZg8SSgrursjX5HccZApx5CBGl8XzD0JOkn+fW3wlH3nBmnOUJkbp6eAmjsj
 6bhZDq06rqjHqTZp7ftiyVcxu3RWvkL46a0iWj1d98lUkmnin3c60swaCaVbqI0W
 4Av1kQ5Ibtsc/Ayyw6WA1QABSzQPeDegCMBJvSfI1KM6iRu2FJ7VkTPpULzW6QyR
 itkr2mu2oEm1WLDSHUJI9o4hKdG4B4Toq02FMCMa/sjuspN1QeUdRxwow==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fpsdk12qg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:53:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlUGyxFIGAvoppuQhwLGujadVQ+hb10sgm9VQAWlE/x1Hq4P+UJFU5c3VesUwy2NKmfgEOX/0fzbLRRnQP7V+jtSktUk/k3KxoQJ9NdPzgkV1Y/o0qX4ERtsW/7TfQs+XJOXSLum/vVn/P1/WkyxjwDamN1nWoxpUapNz+xX4di6gI951z+i+KRwCs9zZ/m0PUr7bXInq8Ss/pE11B83RoF3wPRXpIb/MkRT8ZmB+EqUWhk8qMQtgt3yq7yqZFAzWemXq5+iVPf82GbrVVVsr4Non9Ve8SDgkRJRfEvYO3TJX3mv0Dex0Lswbrxq6S4iejCaLw1XRwtJzUxGETuzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HpzrVsb9fvgQh18aGnHqutVeuSYkOhIPLB9u7hZWT8=;
 b=lIYxDvMfCcPDgkhYUBz/6y0XvSjAPwI+BgDes5d621OOCnDie+dS8i2V85WQmwm7SLI4v6UAd+lSuYXJUPllWYN8lZ3XZ6zcT7hXSkDx77wL3gSMqmZCvTrJioaYHsI2QuVnOwb9o1ujIL6ydBVO+iTwdu0klvhH9XwT1cmaSKp3BNDquEOe0y1aXkcYcjqClVus8OMZEWiD4G/zyMcFA18bQIs8w5PQNGsaFdN6twEUEWT+Mw+H9Bp4K9eBf0SAMVgyLeO6jTwRMEQganwXrhtSLGkUfz89bqVuMMb58zuAsFuZ8VohgCM+YQ89yEzlN690zUYLgj7iOmDoaVFUuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HpzrVsb9fvgQh18aGnHqutVeuSYkOhIPLB9u7hZWT8=;
 b=aq3zcJ9k4rl875zoAFDm6fjp6g4r6jFZJWB2Bzo72AklQpKPwV9TiXALdctR4xz3A+m94s6QHKZNipHBBCvbdpsdudN63oHCD056eWtYhIxIpeyfcBVM3FIXhXOWJYMnenzioqD8BiUUFmti+3vjJ97SwuvXmcXeAog7RbDBNZI=
Received: from MW4PR04CA0331.namprd04.prod.outlook.com (2603:10b6:303:8a::6)
 by PH0PR10MB4742.namprd10.prod.outlook.com (2603:10b6:510:3f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 12:53:43 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::70) by MW4PR04CA0331.outlook.office365.com
 (2603:10b6:303:8a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 12:53:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 12:53:42 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 07:53:40 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 28 Jul
 2026 07:53:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 28 Jul 2026 07:53:40 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66SCrdf72709466
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 07:53:39 -0500
From: Yashas D <y-d@ti.com>
To: <dri-devel@lists.freedesktop.org>
Subject: [PATCH v5 0/2] Add no-hpd property to the cadence bridge
Date: Tue, 28 Jul 2026 18:23:34 +0530
Message-ID: <20260728125336.776116-1-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|PH0PR10MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f1c21e-80a4-444d-b4de-08deeca740e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|10067099003|6133799003|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: Wh0sqCL9lzxoMGHgh9JxdUtnz5ieYwLOGXIITG78aShRq7/6gN5bW8KPxI/9R3eeLAzRD1lW10tIni45XYb4ERVOf71XKIeU7TY8pIFMns6W3ARz53QM08neqLYmMTByZy15Kb+QGTk/Zo4aUhJPK2eT6EvsVvz/DPSbFq+uQPe9oPQKuKVASlo42S/W/sAfuc2e5zcy5wbHpStlBjPSwenWM0z22V/lK+Sd+Rkn3wxVH9laHIH8m4CNLlAvNktWBK6Yy2iFkkBptPYTrSM3yxNo/saCbEi+/AX/h/8HA0tpbdGn4GKEbQPxF4zXEVETlBxT/89tHKF42ORjsGzyKbpWU1L9OvdjIG639EXFtnqpKby59rR0M2qNRsQqOaWdRo6DKBzlDv2SQMjpSBhasbOX0NushcVhv2h/nbiTBM0i9kwo94F4yD2Es9nsZG7LElcAPRBuXM7/QksiEbjCS2AZW+d0rg7VWz6+8Pci2lWQrJ2Q1wEG/1mzqv5buYqs+cYNZ+HahOwkZQpAPQ8F+zx9WSOmPqQnMpkq/rji4EksaZMTAiCkykFHb2QyYHElBaGpHa9DlWR3/bjgqeEX9/AQy6MluGum9DbVhAHMcPPKpHC9t1/RqTh3JeWaI2t45DmWv5IdbFS0jSYbtvzNDr5tRuDxVrMyEABcgFKCzaTKMkuQ+Ad7juG04NFQEuNfaKnILwpFbeUtIR6uuENpgw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(10067099003)(6133799003)(56012099006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2Bbkr+q9uHwokW1Tb0rA4sNIJTETc3hY1krYzYpn+Lv+nSNuGm4ddBs9USJhu6B+qm8zRTCATVJnWB6MdzBWGAElLAaIYLhX65q0TWonKCreUpSmgmaQd8vN9aP6vlN8ybe1xGTvm2WRbA/hlAxD4ckPr4g86CxO2LBCSscr1IE4v8xf7QPTAR5b9qZ71Vp7VOivFQ9ufnNwGjY0Awdq8vqLU1toSthdxqFUEY6k6rVD9F7OjTqRV4frfzI1ChedkKO1Z2SdXvoS98UXaJnIjf0ZMMtVhszx3iVwIx58uc7e09gg3PTznJO9I0j38aqXwpRInal+UUHTSrOtAUcnokTDublM2ln8oX6cGZLnvkWHojYAFdp3JraXuu+CYKezml9dxZMgP5XzRg18mNqzhrgT4S86kBRYcmjE2FcpTUQQOJTOemBC4I3r6ysSiety
X-Exchange-RoutingPolicyChecked: EZW9Eu7Py6UBDT7em2dqk2L64bXtu0bFTAaR9Jbxbyrw/JLNbmeWLrL4bAZtZImjs13qEV6l3KJqgSXJRV/f/khDN2N1w2rpeXgQXnHBFZjMPKUmc3NUSs3eAAK0QolTfZ8HKwhqNckQRYpBw7vNFq7OkMT3vigihX1yl3cXLoxM9e3/CG9Y20lBzMleilFVXoSWXX39iqVo8RFcnHafWbCO9Qik20dk6W2y29JU0TwBGtwAbovXaRMKRdu6AUIf1oqRVmICgl//Gtsto5natlse98JmwEsoBKdJHOQH3WoeloG6LMEn6nl9bbM6ki3IZcJ5HLxEBdb+QdWJfztgjA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 12:53:42.4186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f1c21e-80a4-444d-b4de-08deeca740e2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4742
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExMyBTYWx0ZWRfX7RkrXXAmVJti
 EHIrCLyCoz4DrNXK0ZvtfjjCa66bjBOCsXNvYr9JGD+rB5bVo38EEBssuGX+ZFAKSWDjowf6nrZ
 FP5+68+zVLxXvY5kIjCct3x0Bq67h7w=
X-Authority-Analysis: v=2.4 cv=e9M2j6p/ c=1 sm=1 tr=0 ts=6a68a65b cx=c_pps
 a=f30+ahQCdjj2/zPB7vFTLg==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=0JgP1c8QgrBT70boxssA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExMyBTYWx0ZWRfXx0bieh/GVkNy
 veE136pnocWMyNWVKvwpl1OjzAZu+4YxikM9tiM7snR/BBOnFYKYH5bCfJoKHthBFcX0wbLYBXV
 bGcACfH6ul+nM/8fzHPejNyKyTGr7bQ+f/TDO5Hutn+xlSfOiLMs07Zqlv+drifHAKsUG2AJy9d
 xCNxsI+/8VZnMUaXRjCCnl+htYs10h8w163Um2+Pexd/U/VIrSUAHIjVGaR/+3xvyi7NU4z73bZ
 pItWkqGGKrIUab6Lg4Wg9dsGOYiN22wD2OFxX/I+OFNOp4Kz49AUL+OD50oh6PWzzAlknA7bVkg
 J4RCvLfDbOpVuMdvHEwe4tdeeV0XXsYbhZyoCpfYycmxoCcaw2MG21r/nA6/BeT2OrQDc+gvshS
 zlgc1vB2Dwsgzge0bZkomuCtAx3EMDlLolGzsKiexeeHvW1IMmHDqoQMFt7L7tTE3i5jmzKUSNN
 UAsXhpXsOzxCeFbmRYQ==
X-Proofpoint-GUID: O5e-HX68dDO8S5u6ClMxaqB-EXVhDm8o
X-Proofpoint-ORIG-GUID: O5e-HX68dDO8S5u6ClMxaqB-EXVhDm8o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280113
X-Mailman-Approved-At: Tue, 28 Jul 2026 13:01:38 +0000
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

On TI J721S2 EVMs, the HPD signal is routed to SoC pin AA24
(MCASP1_ACLKX/DP0_HPD). This pin is muxed with the McASP1 audio bit
clock; selecting DP0_HPD breaks audio. There is no alternative pin
carrying the HPD signal which makes it impossible to use HPD
without loosing the audio capabilities.

When 'no-hpd' is set, DRM_BRIDGE_OP_HPD is omitted so the framework
falls back to polling .detect() every ~10 seconds. Monitor presence is
determined via AUX DPCD reads instead of firmware HPD status registers.
The .detect() callback drives cdns_mhdp_update_link_status() on each
poll to keep mhdp->plugged current. At attach time, the driver waits
for firmware to be ready before performing the initial AUX poll since
no interrupt will trigger it.

Changes since v4:
- Corrected the dt-binding Subject

Link to v4: https://lore.kernel.org/all/20260630102610.1849902-1-y-d@ti.com/

Rahul T R (2):
  dt-bindings: display: bridge: cdns,mhdp8546: Add no-hpd property to
    the cadence bridge
  drm: bridge: cdns-mhdp8546: Add no-hpd property

 .../display/bridge/cdns,mhdp8546.yaml         | 17 ++++++
 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 58 ++++++++++++++++---
 .../drm/bridge/cadence/cdns-mhdp8546-core.h   |  1 +
 3 files changed, 69 insertions(+), 7 deletions(-)

-- 
2.34.1

