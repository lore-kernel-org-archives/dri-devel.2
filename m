Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34E7C98338
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 18:24:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E1B310E1C4;
	Sun, 27 Sep 2026 18:24:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="o49491ds";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IVrc/5F+";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC2210E1C4
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 18:24:45 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R5u0g92806212; Sun, 27 Sep 2026 13:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=wKfazW6IaHKtupTAV1SAwN82hLZUyra+bfuHk08eH
 mw=; b=o49491dsHc3q4eopbx+KSXbw5uHjRNDHZH6LTSp9VftUYgs/gMErZn7T4
 lSptKUSuBtdOJLLk0dEb4s4EXD9LGliCQ5UfaxXBp+MBc3d7NCBoZ6Rmz05pEdcA
 P88gAMmXuUClgyVfkcUAsnXK+99oXSkqmZDNt2QP1w6xM3Gzk0Epz4RBX7mYRJq7
 nLR+dGfhSkzjyMqAiNOZABg58iC4PpEgCOWqMv51VKs5SNWWgPRFFhEfmqVPH8r5
 ReLkXhPhsA2qAnidLv92xS04/l7+tmz6stg3LMF6+vsNMSlRipEHuwU/pUZukulf
 wezH/iJkYYCxe8MvXbU7ODXcUA+Mw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gxwe5hxdj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sun, 27 Sep 2026 13:24:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCsCveRLWQJFWGjrs9aoH2Ft0MCLnzMvyb6ju1dMEeI0NKDUyu//+Qzs1aRRzDBanYGn2vSleUS318V/KaxmM+Mn+oy9Kli8m5SMlPEMyMR1Lipiq9KouGu2FUX5A8RjIqBry1VKniJ5HWOTqoAe9NB6erkju1mPCa18kfnQCZxUBu+TSRFTMqhRwJRMF2wlWAL5zZTs8zQnBLd+RTF3JpyW4Wo0Johl7wKN7PZ1o3yxG2Ki9mdAIv972ktOULsIi9MBZh+zsrruieP9EDfBR8zBosvouS/7x/hj0DDCEd1997hfyuV5XH+DeqEdZERvYKdyd6NDre3lk2Vx3us33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKfazW6IaHKtupTAV1SAwN82hLZUyra+bfuHk08eHmw=;
 b=Ne9jgqmuB/UwqXHHMc8ZHF6obTxYNdfpydMFgZ50IkYGg1SozlRgymh0gQGrHMCYOUM6bypzkhIXVsIrb6UXYv4k4IR/xyNoUgAYzvvOCqAVc3NvLTYHXXX2oi30PlAfVRwKnr/agVqdRdZT2MZyeq0UVJFdKvabeMP5XnqXeBbox4HMWR5G2U7AgtYrY5U8QCAtH3IyaK2lu7qun7sCNkRgyAFWvqTB1UDpCyGDZ8LJiH6JuG08DdSH2cIm+UyxSbBXsldYiM1TznnNvozxvmGy0myx1epRPKOKhdM98epfvlSqX/QUUkzHgzgQhx4RansOLSu10HKh0iqI9hhr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=oss.qualcomm.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKfazW6IaHKtupTAV1SAwN82hLZUyra+bfuHk08eHmw=;
 b=IVrc/5F+qDC068jg0K7wnCPiVFbq4gfOnbCn4CBVvHViE88eQuB07zPWLTXy1WzuXEJ70JkY71cOYv2IF8VSW1z2zjjWh7qL2DiJncBW5+vsTDEUeuj9yR2sd+JgMOpdfbUNqSnlM2mcs0bMLN5Cr78/91/XJBLyrLm8TlRVSn0=
Received: from SJ0PR03CA0133.namprd03.prod.outlook.com (2603:10b6:a03:33c::18)
 by SJ0PR10MB6423.namprd10.prod.outlook.com (2603:10b6:a03:44d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Sun, 27 Sep
 2026 18:24:35 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:33c:cafe::36) by SJ0PR03CA0133.outlook.office365.com
 (2603:10b6:a03:33c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Sun,
 27 Sep 2026 18:24:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Sun, 27 Sep 2026 18:24:35 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:24:34 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 27 Sep
 2026 13:24:34 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Sun, 27 Sep 2026 13:24:34 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68RIOWT81628720;
 Sun, 27 Sep 2026 13:24:33 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Devarsh Thakkar <devarsht@ti.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 01/14] dt-bindings: vendor-prefixes: Add Dalian Good
 Display Co., Ltd.
Date: Sun, 27 Sep 2026 23:53:16 +0530
Message-ID: <20260927182329.4193961-2-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260927182329.4193961-1-devarsht@ti.com>
References: <20260927182329.4193961-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|SJ0PR10MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 66884ae5-ffaa-4058-ba7e-08df1cc49575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|82310400026|23010399003|1800799024|921020|10067099003|260925021311599003|260925022911599003|260925021911599003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: s3o9aH2dlPVWPzjNLm+uhsfjnTGwyncimqjUU2iUM1Qs8+Sxe9CaORGjszqU0PJABolfLGExg5FMlEPFULqRbfNdDqEkB645xKTOceDtMAn7mHyVwg/tcXKJd1Kx4XOOtA/D6tEorLfSqWIFWYbrBQeaVMNaIAb7f+MFMZPp9nELfmf4Iq1o2F5M4pJdW1SYP1oSTRvB/3wUs2vLHC0RFAnggPdOmqsPiRDwMta4TS+dYFhA/df7WFY5WBU58up7WPFXLNjtlgY8pmhYbYTvwdqWSHHbKHKNY1PPgIsRQPXkDgYymF56kyTurwTxsePsCH3ECGOovILFn95NgrNNoal2NfzOKJlj3WC4wa4zspSTjFzFJ5cxaKnfiHiXxHQiLXlwyn60efCpuTTsOrw15LmYquC47LhOwzQ9IcVmWSyPv+cAh9aAkO/XNweXtZbft9sW8ARMXZ+EKjO0SFw77jVEMg1hWcKwKK9Dz3Dh3aabiA16p0VSVvYw7lkBS1OoNjpkMboh+FtZsKbJbQjKUt1/J+Qw7WkDGv9rGrV8IcxdlkJdRPLXJNRi7/JQDyHkey99c+Kw3V9uUOv8LT0yvWRlfgRDu7D5utWmpSwhl6s66lTyzd/xO3OtVxpDEV71KWeQDHtYdZrQBLFOXIIQDwzPe6M5+WV4RwnYzE3nBScRUopKgdv4+LkPxlR4Ps2PvKb/UPI201fMRuVqGHly09zcrPUZoDBNB1eGMi1pEZLLVBScRlxgKGLvs3dQVinZ
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(23010399003)(1800799024)(921020)(10067099003)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3P3uq4ReamO2oJtp20mrpn47Aj825+QDxLVsY6QaHFoCpk4TWwK0hHHa8TIkEAJ8vl52gyZrtpUmrGcxRhp3oCNkVNm3zd7kMeDMNLUBml2gM68GgkPDtHm4ccRo4oA7V6ynPZ+WkRtK2IXniz7RfNqwMGDuU30iKQiC3/h2s+gqRPTkmA0ITxjvDYRsAr6LF02A99sAiK1r+IKiEG0+x5AMgUP6/Zp9ZazWFUr9XRDB7j8r1Qt+RrbXG1sIfnPWsp97T1v0rVZxlN0jbqDzdJPYpVCWDMm4ktIswRo1sSFs8WEH/qFNo8NUvLUtHoXIJSS/fEGgO4giGJQANZwMQDA2YaAAsioF6B+tAZNn7VC3zs8TrmsJ04lQZNDzo5P1Jl2DDeBK2PloIGyK+Vg1g4Rtt3pgVU/byrkaa6mblFoLDR+4S50xsCfhNJi9AKlr
X-Exchange-RoutingPolicyChecked: ENbWVL66ft9d9kyXjaYWQU+9FGGrXIfzTJRXcbJzLJGlIIhnR+9vmof9tiRQYSndLXEK5yMuIuYCY6UFkxpRUsIuOtJ7ciIBkfglVK0QhlgIuAXv6L3oHlG0MYTmwvL/yKNjTG9wgHWyZxTnQVsUbpGidQfxa6meG6X+oa3FyuVNFi13U07jigNKNN0dYeedPBN6oxEQtVyv1TgLSVqHM1UE3qzlw+XIm9gixHxSZpOYrG4XlmDlwH5OUZzqBNvGFUG2v6lhIUXeeURc/mCImJnbqh+jVn6fc2KW6DBdo2F72pX15ZCbinpoTetYksfgcalaGK2yqEHwv0ArkIg++w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 18:24:35.5306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66884ae5-ffaa-4058-ba7e-08df1cc49575
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6423
X-Authority-Analysis: v=2.4 cv=aeP0Dhot c=1 sm=1 tr=0 ts=6ab95f68 cx=c_pps
 a=W8nThqPTbj8xD7CpgneC0w==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8
 a=6SX0sZSdmN_HxNRVgkQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfX0sS8srrSZkeb
 jn627kxuetJuShPAQ8sM3R2p4rKuif+9NINgtcavRIq9+9fwXNDvtEuOoqrFwF6Vys8IShUQwKp
 1lIhq1tOqr1uxAN0N1hYvmqiAad0dykYjNxeRj990zn3qsjA48C0LsA5MRbQ4r5u9VsjBR/1lG/
 MESDmGUuNiyJSwlbrxmZbcjlQhsrEheERkJ4QUtUbDWRZ6GvVxzJO+ZA7nzhGnhyO/y1ukESckc
 ZefZhqGdRp91Z1RrxZ+MIkSltZN19oZTWdfQSUvbIEFzb6ehLxTeNZwcpotkgjHVW/hYGbrojEO
 xN5rvW+Xj9TG+eTrgtwDn++Jj3KUAGLKoUG/AVAhNZvLeBpwWsUVDmnqPDUYozKoOaRotEyloQV
 0uOaIoASHUmiZtSAd9BX/B/aHyjZ4UoOWxu4mxm83jtKppfnHnjv2nyAw/velzE40df5ARkNT5B
 6a7AI/Ifd0rxX8JUS3g==
X-Proofpoint-ORIG-GUID: DNik_wXVnH0v9DeY6wFHMEaGZnSPtNsx
X-Proofpoint-GUID: DNik_wXVnH0v9DeY6wFHMEaGZnSPtNsx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA3MyBTYWx0ZWRfXydlDJDXdtKrj
 EuB5WZs/UdaX9Qepr+4jesyc2OAEVsOjpgxWDVVk5CvZ9krJHTW7ktss2WLC3n58Pcoj4F8h8hh
 UtWU2+eovNVumSHiFQrpRG5NCHu7jyE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 clxscore=1011
 adultscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
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

Add vendor prefix 'gooddisplay' for Dalian Good Display Co., Ltd., a
manufacturer of e-paper display panels and modules.

This prefix will be used for the GDEY042T81 e-paper display panel in
the solomon,ssd16xx binding.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes from v1:
  - No change

 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..3e8062aa92f7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -686,6 +686,8 @@ patternProperties:
     description: GOcontroll Modular Embedded Electronics B.V.
   "^goldelico,.*":
     description: Golden Delicious Computers GmbH & Co. KG
+  "^gooddisplay,.*":
+    description: Dalian Good Display Co., Ltd.
   "^goodix,.*":
     description: Shenzhen Huiding Technology Co., Ltd.
   "^google,.*":
-- 
2.39.1

