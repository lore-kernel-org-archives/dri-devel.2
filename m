Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A8FC55174
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 22:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECD1010E46A;
	Sun,  2 Aug 2026 22:41:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bTEmwnC7";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LZNScIin";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B6E510E09F
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 15:43:25 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 672EZiaF1522345; Sun, 2 Aug 2026 10:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=4XVg4Qb4q9LFFNzW10VQGD/1g8WEMJ5ihE4Wfn9w1
 hc=; b=bTEmwnC7NgEOTEdOXvS0LOU9vciWM0AN5axkg1h12S8Q4QDIRDHQaw/ND
 CY8SvyiPqCZUsKY8mIBh2r5rhJrIc62z+k6zzd4uRcXDR3wsCBnLUCsZpewTLZit
 k8HNm7DcJSp+MqqGavFnIppoHrKCLSabMEkPc9DRSBeA2ovkBDM5k8WlaKOZyuSr
 Q6OvIqgNWn9s0pFZw0ZdYaTgUawtyYQ748kzJY8dugF/e6/UWvNjRyW1m57WFKfW
 gdeyQiAUzT+eYfTUawyKsrFs0Iwevt+AxNiqrDup9bz5gvBbK7CtBYB+xSgsQwvi
 df4aOe3hBLgbi2Ny8mttOuNkMGFhg==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010020.outbound.protection.outlook.com
 [40.93.198.20])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ft063h8j4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 02 Aug 2026 10:42:57 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oefiT/iYfhu31NCs2MtiIDaPjBENSz38okN37Ry9IrTluCvIl4U7v2eJdexlg962e7glRFQdRyYWk0o1CaaL0xkioSmTIggKvq3AWB1PymmuqH8a+29ZJi/lbHLvuniu6exYV2f+Rc092aNCtKuH611++T4325g8Qn4/3/GAp8Afzw7WldJ6DQe1J66EQq4XNxRDJBnCpxbVoavlybqJP+uNP2z+dHvcl3I2UFTyTQHkSfLebt0a1HI2ybdjG7Dwsje5G1XBqiaOOJ+f9pVwRVcIVaWHG75+DeOhec7tdAUzZWrDN/+zQ9puC05rLgMbctJLmHGMwPadbJql2lcOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XVg4Qb4q9LFFNzW10VQGD/1g8WEMJ5ihE4Wfn9w1hc=;
 b=nDXAdfI9mmEsslHrqa0SIWQqf+SIMvOr7BoyWJ+V+se6RzfWFwv4ay8jNx2rog/C2tnnlUPPMT+cIobOQDnynISo/5XW/76VGlKej2MYiKf8uz+/XmsVDWL9063t2qR3xZF/aiCNARA3PV2+FbXYk+nRO62DjoOzgVTSJE0dtXvKWPBEnNShU0w6t0FFE2PWISG5hX1rEULrg832s5NJ5ydF4wbe/1sh546zfxOZgS/uB5KLoKLPEPcMEttWmOSq5pFtCKw4BCX5i7fG74lueW0l1TKW33KFsXt4Vi2uX3by2sDtrl3RCqMkLYMryZnxoWzsWt0ga0l82Yvs0KfUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=cadence.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XVg4Qb4q9LFFNzW10VQGD/1g8WEMJ5ihE4Wfn9w1hc=;
 b=LZNScIinmMFUu5JKd40iS+fsM+qsLUCY7pVuNxoxjE310IveAfPih47JADZ/BbU97RY5jf3OKS4gLt5qdrbQivf5l265JzYpiuiGKlL0icdgZcsSdaeUgZD2kKnJYQWQ42w5wtVt+kOs3nBiWp+vzVpn2ltgJhB2KuoB/zprGpQ=
Received: from BN9PR03CA0049.namprd03.prod.outlook.com (2603:10b6:408:fb::24)
 by MW4PR10MB5774.namprd10.prod.outlook.com (2603:10b6:303:18e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sun, 2 Aug
 2026 15:42:55 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::24) by BN9PR03CA0049.outlook.office365.com
 (2603:10b6:408:fb::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.17 via Frontend Transport; Sun, 2
 Aug 2026 15:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Sun, 2 Aug 2026 15:42:52 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 2 Aug
 2026 10:42:50 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 2 Aug
 2026 10:42:50 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sun, 2 Aug 2026 10:42:50 -0500
Received: from yashas.dhcp.ti.com (yashas.dhcp.ti.com [10.24.53.80])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 672FgZ14897228;
 Sun, 2 Aug 2026 10:42:44 -0500
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
Subject: [PATCH v6 1/2] dt-bindings: display: bridge: cdns,
 mhdp8546: Add no-hpd property to the cadence bridge
Date: Sun, 2 Aug 2026 21:08:24 +0530
Message-ID: <20260802153825.1570435-2-y-d@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260802153825.1570435-1-y-d@ti.com>
References: <20260802153825.1570435-1-y-d@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|MW4PR10MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 798d94cb-f7f8-4458-2a95-08def0acb718
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|1800799024|36860700016|23010399003|56012099006|10067099003|3023799007|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: axTUonaP/sr3DckV5OEv2jV8TxWLM3w2GBh3CwjFdrTuvi2K5/S54s2PW1p6jZh+v3M+TN4723rNEsHGDJcZjVtyPktzha8pZBMOAnBipfTrUKBGgauvjoAX+siNLrQXMi9C6mw+3vbGlGoYiexO+mlKdp9Vsn2Xs+kDI2kXUYw8ehEvZDg70H/UiRIRb8lbkcbExmTN7iXi+eGgkvqBKSa6bGMSD0zTNdLczWbm9Kscw3vOsZZp5FgsTQVJjUC5WeYnao11jCwh8krD2aPohISkkbiPlbM/BwtmubWfeBxGezHIDZpzbKtDQKC7duk4F2sAWj4fJ/wd6wMNDeCQsAukDb1mYSayg+BHz6w7oi7VY22i+5lNS7dIf/8xEKPQIqDH4Cx42VbzL80IzcsvHRdVtDbl+RTTU5aRPy4yeNuDYRn51WlPlBUEZUC9shHgeLIHQwOMcFsrCcuh7kWA8gAaSJM7hRsWEjco/OBbjioRKubjLnCjgAcYWxZAaZIgWqUELSBsFzgdoLd17tMGbY8CdPXmNhppVDr6aqd+HWOj1govQeSUt3V3qEYF+4N7jI7Ox5zKE8IIujb1yeXk3dlP8PjVC6DU/gnmNsB3RcFwojpf0s8VD/VDzSWPByj/CkCJgTId7nscftHNlbHfPdTgImhd2B3CkPLcPLwJmQFSWqVnw6QqeYoAoe7WESU4p+a9LvKhq7CF6yvZiXsqJE02HIdDSUTh+nDbwinYAJZYZSxFsssy6fljpY+QvrnR
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700016)(23010399003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MQ7z8wE9vAmYZsixHNhyZ/a96CcH4EhX3scHc6dbvI+m0pOWkxyojZi4sJdXhR2x663Lq+zoejpJqQOOBxdTdq+SSLXuI/zNRXhrEZVYTOEvXwjLVGB+iBbEvpJxnef1BluDSLe2+th/40sPwBcjlAgHtb3O9281BBtbahK+X460LImHGrDq0Fc2AwCqVt5yAZORWhIFzB9sy/w5YoZR+T+0Ljho02nLDpi4k1afNlc9nbG5whY8BwMM/XH9nzRroC3taGVSkl7KiuhrckfCx9+bUZO/tYVm7ZbJuduxmTelwvwnjdstg+hpOZUk9bdeFMr9oac7D05TcpZcE9yYRgXHjTIa7fZUhjJU09I48cqEj9Lx7w2G5tsh71pTA78qJ+KUPqYdlEyGFrjGE2gN33iEnnQ+HSbxiy2/mttc1mYm4OTaw4Q4eJtZWat2QAsY
X-Exchange-RoutingPolicyChecked: KakxtKa0wftu0FMAeZFAYyJVz0yjuAerIonAeyiQXrhNYnpHgvNxMRFCOi+2ZapOEymeYtdfkPIn0gixG7xVUUdCtvkCZjnhM4nWpqV+/GjfHSNYP6sOn3AdaScHWretuddj8irnCTnP2q6kYJM5muhU9isQGS85mordGABmYWCVUX7ilFxrEnld4B/MYbGcPyDufveqmNf9s1IFk8aHRBYENzCb22NxaA25JmMh9oO2snEYVwy72tJNrTGUOitywSJmY+BeKIyW5+BymwzSMbMXOzU8O0kurqCwX2aLufFUoolknkThqNQTGy2EQb4ZRpULqNcHDzk6OQdAg2ccIg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2026 15:42:52.8873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 798d94cb-f7f8-4458-2a95-08def0acb718
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5774
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDE0MSBTYWx0ZWRfX3mg/XJOodvtY
 oOItKqYBpswxoZNGZnDKXIiUulCrpRNR/N21SDO2pfBud6u1B9QdxEoYWgo4uDEubDeABIgrCaX
 I3pWTQ4ixtG4KT0vF7Q+IbqDicr1AnM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDE0MSBTYWx0ZWRfX2J4mfgxrrlYX
 uAOIczaLYYy/y1Hn88MQYSoe4ZsB7tmvaI9QzACDehMay/0xdWnZJktP+gmucSIEPhOfqCMNfuH
 eFtXZGUA67sAwvX1CTRDzAlW2uaUTEk6Z8rE2yh7FUQ++MsS0SYffq/YwJNpsP+oh4XAeCsZtl5
 GS/Fp3QelOvtfSyYj0IVr0L1tqYlpjkq0w/X9ze0iE4lCJ6DTLh3ah3zCLYV4n9vJFfiEzRC/A8
 HWa0LXmrC1rxgSgjj/XYIL2uzsoc4zbREzHUcLx8QlbGHdz0jx/mLhSQLkE0rxyr2GFvLZI9Ehl
 Gmn24lW/2UohVUwlH/u6HIE4QQW9ZFJsRDJc6NS8I7SldbtjTrWNLJ8UNz3JBgnwcN+42KwEQCM
 5ad8uOOq/2KaYu0TlcfQWIqTqeTEYvwUF1kWaoqJIa/YHiTwbSMav9UMwQxbb3wlUXfuumTetVK
 XLWRO61cYeRpRO1euJg==
X-Proofpoint-GUID: iQlds3Y90Hp1i9XyU1Bv3aQ5ZIvlbiYP
X-Proofpoint-ORIG-GUID: iQlds3Y90Hp1i9XyU1Bv3aQ5ZIvlbiYP
X-Authority-Analysis: v=2.4 cv=VcDH+lp9 c=1 sm=1 tr=0 ts=6a6f6581 cx=c_pps
 a=6EvF431pKSa3MhyLnoL1tg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Sv0fKeRqtYgA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=EzX1xrUl6JEdRszeJO8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020141
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

From: Rahul T R <r-ravikumar@ti.com>

The mhdp bridge can work without its HPD pin hooked up to the connector,
but the current bridge driver throws an error when hpd line is not
connected to the connector. For such cases, we need an indication for
no-hpd, using which we can bypass the hpd detection and instead use the
auxiliary channels connected to the DP connector to confirm the
connection.
So add no-hpd property to the bindings, to disable hpd when not
connected or cannot be used for hotplug detection.

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Signed-off-by: Yashas D <y-d@ti.com>
---
 .../bindings/display/bridge/cdns,mhdp8546.yaml        | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
index c2b369456e4e..56ce3f65ff49 100644
--- a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp8546.yaml
@@ -57,6 +57,17 @@ properties:
   interrupts:
     maxItems: 1
 
+  no-hpd:
+    type: boolean
+    description:
+      Set if the HPD line on the bridge isn't physically connected to the
+      DisplayPort connector or cannot be used for hotplug detection.
+
+      Valid use cases include HPD pin not routed to the connector on the PCB,
+      HPD signal muxed with another function on the SoC making it unavailable
+      for hotplug detection, or hardware design where HPD cannot reliably
+      detect monitor presence.
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
-- 
2.34.1

