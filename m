Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C4A606A322
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=iTh3xy9y;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=OJY1qMQV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA0F310E4EA;
	Mon, 19 Oct 2026 21:37:51 +0000 (UTC)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53E510E4EA
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:37:40 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69JLH8Nd4181198;
 Mon, 19 Oct 2026 16:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=z7hVKMLri08CDjDo/Wk4z3TxFJJXtKHeSrrI5EAB8
 Lw=; b=iTh3xy9yJobO+v8wq4xSCn0jVL9ajNOWsC3GXugKLANChy/6vXV+F3YPv
 /fsivStHeM8/38fMuT0pwV5jvSCeuVEll/UiDz+BAhvy3YTFVFvEY1XW6mVd4VoI
 Hvx8uZF7UjIrtBEsaG4RQJJnQB3KsSxgXsfU6jcu/XPnufrcWki5VRGYzk6V0+Wf
 4rixXqMYdsyAog6niXSFmYNhDTKbzZWh6j4tR7R1vHZsPqcfz5MvSHxdWCCaZ0Eu
 ezRYGY7NEccY/27YDK0ms+1mKbDUkOKWoafwNi/axZVXmGWBTZooVMuyz9/oVgDb
 xhAy1LLQECHSmt7+97xb0bfrFHY0g==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010049.outbound.protection.outlook.com [52.101.46.49])
 by m0384305.ppops.net (PPS) with ESMTPS id 4hdjdabmsx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:37:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1UcbEGq6DZZb4wOTHOZGi9HuteGpCznpC0+pZuZMwtuK5XiMbfqcU6rnJbPw8iD6igJzi88hD/wXDPeV6wsRRx2ZXrV4cNnBY2sgfRh3IZ3G+1L3gOWQlxUjIPCB7iJfPliFmPFM2dstoyCc4JWFdxIdQ3fdtsbzAtPW3ecE6GTB6MQZoudvWhohlhuVRMOVoxiHCQ4nGyrWfSxS9qmQZHDvct0othJvQFPfgOir4AHDQnOIwVCKTm6xsCGxnPjysOZ2e0GgsSh1JpN8xjpj1jVSofqz63G9+WU48ZIXSQSJcskpYXpS/1tsS070X5A1Nnbotpjy84FxNJ33OrI8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7hVKMLri08CDjDo/Wk4z3TxFJJXtKHeSrrI5EAB8Lw=;
 b=s4EaA/mf4JKaDAI0r1K9N2Szn3HPmS0B8hI0hJim7lIW8mzqZrd7sAyqJvfVU09/TBtMUGsylKG1bao2NhzyXSZ4yInn+TATWxsapcXdNPCJN6ozmszEufa1O1LLWHqJ+dwVXpiNBD9+cNReeSk7INYALVnkgF66KwTuVwvLlvPcsRJ9WDR/SIIB70oWCr1Qsgnp3ks6OTqiwPIkoUqbNeZuC3saDr6Gwezf+7E4lMBAgM393HsN7lJB5/pd+WqS3j1I6yvhLieosWSrE9GZgr15THbMxmI0cXBnlLf0dAR7nBK5wA/g9eBRbogwdKeHljkzFTRKZS+OzqVkRCZKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7hVKMLri08CDjDo/Wk4z3TxFJJXtKHeSrrI5EAB8Lw=;
 b=OJY1qMQVif607/ZDO6d51SlzSXdWO1Cl8XsMevW71IblgISWRtxAdFA9OsE73fOkTOts/Ic4KfGjT0j9JZr4ew6i7FdQlL/u01ikZCFnCTiZxAgk1lLHHtSwmGvuKLKtmi7CS1vKV70jzfZInniMfjo1FI7GgWckkFl/dnGGQUo=
Received: from BN9PR03CA0057.namprd03.prod.outlook.com (2603:10b6:408:fb::32)
 by CO1PR10MB4609.namprd10.prod.outlook.com (2603:10b6:303:91::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Mon, 19 Oct
 2026 21:37:32 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::1c) by BN9PR03CA0057.outlook.office365.com
 (2603:10b6:408:fb::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 21:37:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:37:32 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:31 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:31 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:31 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbUTR3576902;
 Mon, 19 Oct 2026 16:37:30 -0500
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
Subject: [PATCH v3 02/14] dt-bindings: display: Add Solomon SSD16xx e-paper
 controller
Date: Tue, 20 Oct 2026 03:07:14 +0530
Message-ID: <20261019213726.4145532-3-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|CO1PR10MB4609:EE_
X-MS-Office365-Filtering-Correlation-Id: 7745c0b2-a7df-46ce-573f-08df2e292ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|23010399003|376014|82310400026|1800799024|6133799003|10067099003|22082099003|18002099003|13003099007|3023799007|921020|261009223027099003|261009221227099003|56012099006;
X-Microsoft-Antispam-Message-Info: SqAa2z2lI9SDP7cCEuBHzPK20bGRHbzm4GjbZ7q2zj3v0O/LORPngvZX86jZ2ATpJk0pR62C2Lzm9xQYJjyBeZtUvs9QmCvj8PeDNY7IogkvHZaxz7g0gCPL3uFoG0B139mE+SoNeYaQAtCYc0hJV4lF64lQY8xPqzIDLv9TBZe9/d3i7YfrsjwpraaqR/6T5tHbrq7Y/MG8y22oBRc9djh1RX2YJkkNSJXn0LJIC2ZCerJeSjN4cWNyffMpgR6M15DiqiNEvPTmkWtI0fx7C3xO0g9OuuFseIexsgNvmXg+4eUbQuWW4cZw7K6ZucGgEqdlAlhIlvLli15wAU7b4CW3CJHNbaIhfeWzPLRZe6Oo2iXAizM9s1wTTaPphgQdJFQ+kissa0lIcf6nPfnpQ1M1cdSmIAag0IItCmU0wASPzoe2pHftYZykCl6wOzuYjKcV6IF+DNh7PeVCPujKgPWbVF3cg7c3pQHABb66yV9cmt5ERMwDUzkyj1+cE3+3fKWirFUHwSO0tO0x817eniyQ1tfUkfVAZQuIlhqLkUObrFB8gF87lfFvzV8x+AQmh5cagThK2dOQ3KsrX6AeJDUDawA4173aZnpS0PvIlOIKZYQw19ht+0rTJd5VjHZ0MTXhA5Wc1pmbQBEaT1YVugp2yUbZd8morE2KBUvAp72sAZHTKeBQ+Ftwc4benW17
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(13003099007)(3023799007)(921020)(261009223027099003)(261009221227099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JQ8oWVFTw7FBu8HIuMUr8jPTqdMzShQt/Cc9R9uyOHHFPBj59aOb55H1njK4EQjGs6cwpneOxeUZyVGX69KIdWBKTixX+7a81nn+iuSLsvLmA3fail9lxOISOArIbPhjTmqiWn02Fx+/08VXBWODtvIdinL9DdPnXlSrgMeMMTFWLHQnc18mK+0XmmR+RXpuEg6gJgIm1NqRNnW6C0088ke22zxNI2dsl8jzj0BL4M2ebFjwnHxGpV3SVrkDGqjCRwZZA6r/2q3RQy388VcWpOoEEWTDFyxQv5suSrkIlg44H1yjN1Yeb2FpMVKvLYEI5DKYiISmVhUWcnUxUAXv1uFp8m2cTdtuPi3UEYLucAvfbbxpzmY+9NTvCG9CDM8YqjKuoMGmf1jfsai6/F5SHOZJZY+Ifz4jUVGS/5EPZlJPBc5VpfMm4St3Gx+VPOhw
X-Exchange-RoutingPolicyChecked: EjgSv70PSfXKdDumhA696LIgVwnWiH4098fpbLXwmVykf+ZU1RHT6ZtLqIlLjCF7ONKqsL6HxX95h6gwWL9Cwzku2ycMpzyyRncrgQgjRjbFcB+J3vM+W0TwrAgDHNY+Zy6t51QVEr9xsDCfwyPS32iZFhyvNTvTaU2HX/N23b3kkXVdgAaeJq4ra1iq/4ZhfKYXrKJ9OMN6GMDZa5bx+5wim+aCLQgd8HDpCwMNMawT7F3t1x5njg4n1Wy0PuxX7H+GXkwyLyk8hb2MN16x/PV75xvKxVehXbSBVVlY1XvODVoTLECDuJMeysbhtWNi/hvqrmyTmGZJiI6hHiOiDw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:37:32.1000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7745c0b2-a7df-46ce-573f-08df2e292ebf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4609
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX1gxg7Pw4Z6fQ
 LANlHfZzeHA1tR/NAz4Pqmt1zjHRQDh6iD5PyzYfMrc3JIcMpUcG8E9xjNhlyc8hqATj7lT9Xfs
 eUOPs5L6wNjeBsy8ggR+Pzi6Bba8HYJRaMHoflCDfxf493/2hCMBRaQeAJ3egbrofY2c0FTIu+4
 uYb/W/yAS605vTDvRiLLHbbCgS5DQu39qIMc9bRR4zs93SOvCeo/IHXUAHPsiSrl0TT5MdkdjyE
 lOUyYf3otd3bmouMAfOM+d2dhxBu3ZnzXp5NBGRvfI3aaP2ma7L3LOyCWmtJ5Kt5LQA8gWH845l
 aVpTVsSX8rVdKNNL1m9QuEXzb6tx6RTPXsHHecYSJZ6JUICKZow2+korTl6HQygROkHam94sONK
 0rnyRCBVTbAkcq3bPhAEQHl7UHvSikEL+fwLviB/5bsBrLVEF3Kb4gZ2xxRpAcP7NQv8O4O/cxl
 VeCTbgrvcIqTZvXnokg==
X-Proofpoint-GUID: Sdgh6cygszfGml_d7ZJsfZ8IGo9y_2oC
X-Authority-Analysis: v=2.4 cv=HPNWhYtv c=1 sm=1 tr=0 ts=6ad68d9f cx=c_pps
 a=+5nsKerQHvRPAoQt0ERV+A==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=YmX860EEAAAA:8 a=LBxWy3usAAAA:8 a=gEfo2CItAAAA:8
 a=sozttTNsAAAA:8 a=04s_Tx_WtkqpIzaroloA:9 a=BeCehlkWaqzeQ17686bl:22
 a=4jSGKt0uXjqk0CpsFuVH:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXy0a098XO0+Qe
 0k+Wk7gVfyFc5POLTG/s5/oRZXr1gGC2Y+DO4y+zivFFSRjtaSmCR1GkQ+H2vOfwqtDRvPZqVJ7
 E9u4EUEkHQfo5+6stqc+ZtXLFLgigp8=
X-Proofpoint-ORIG-GUID: Sdgh6cygszfGml_d7ZJsfZ8IGo9y_2oC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 clxscore=1011 malwarescore=0 bulkscore=0 impostorscore=0
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

Add device tree binding for the Solomon Systech SSD16xx family of e-Paper
display controllers (SSD1683 [1], SSD1673 [3], SSD1680 [4], SSD1681 [5]).

The binding covers the 4-wire SPI interface with required GPIO pins for
reset (active-low), busy status (active-high), and data/command selection.
The spi-max-frequency is capped at 20 MHz per the SSD1683 datasheet [1]
which is also the maximum supported frequency amongst the family.

An optional rotation property (as defined by panel-common, in degrees
counter clockwise) allows static display orientation to be configured from
device tree.

The data/command selection GPIO pin is also kept as optional since various
SSD16XX controllers such as SSD1683 [1] support 3-wire mode too with
data/command selection bit transmitted as first bit before sending the data
sequence.

The first supported compatible is for Gooddisplay GDEY042T81 [2] which is
4.2", 400x300 resolution black/white e-paper display using SSD1683
controller.

Links:
[1] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1683
[2] : https://files.seeedstudio.com/wiki/Other_Display/42-epaper/GDEY042T81.pdf
[3] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1673
[4] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1680
[5] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1681

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes in v3:
- Rename the file to solomon,ssd1683.yaml so that it matches an actual
  compatible string
- Drop the redundant "binding" from the subject
- Describe the compatible as oneOf/items from the start so that the next
  patch only adds a branch instead of rewriting these lines
- Reference panel/panel-common.yaml in allOf
- Add spi-3wire and document that omitting dc-gpios selects 3-wire mode
- Use the common 'rotation' property from panel-common instead of a local
  definition that said "clockwise"
- Remove rotation as it is already inherited by panel-common
- Set spi-3wire as true since supported by panel
---
 .../bindings/display/solomon,ssd1683.yaml     | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1683.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1683.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1683.yaml
new file mode 100644
index 000000000000..2e2aa195fb1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1683.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/solomon,ssd1683.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon Systech SSD16xx-based e-paper display panels
+
+maintainers:
+  - Devarsh Thakkar <devarsht@ti.com>
+
+description:
+  The SSD16xx family includes e-paper display controllers (SSD1673,
+  SSD1680, SSD1681, SSD1683, SSD1677) with integrated gate driver,
+  source driver and timing controller. Different panels use these
+  controllers in monochrome or 3-color (black/white/red) configurations.
+  The controller uses a 4-wire SPI interface and requires GPIO pins for
+  reset, busy status, and data/command control. A 3-wire mode is also
+  available where the D/C bit is transmitted along the SPI data line
+  before each byte.
+
+allOf:
+  - $ref: panel/panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              # Good Display 4.2" 400x300 monochrome e-paper panel
+              - gooddisplay,gdey042t81
+          - const: solomon,ssd1683
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  spi-3wire: true
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the RSTB (reset) pin. Active low.
+
+  busy-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the BUSY pin. Active high when the controller
+      is busy updating the display.
+
+  dc-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the D/C (Data/Command) pin. Low for command,
+      high for data. If omitted, the controller is driven in 3-wire
+      (9-bit) SPI mode, where the D/C bit is sent along the data line.
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - busy-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "gooddisplay,gdey042t81", "solomon,ssd1683";
+            reg = <0>;
+            spi-max-frequency = <2000000>;
+            reset-gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+            busy-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
+            dc-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+        };
+    };
-- 
2.39.1

