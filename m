Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFC8C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCC610FBB9;
	Fri, 25 Sep 2026 17:54:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="S/QMNYqM";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ve2J3o+p";
	dkim-atps=neutral
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 582BC10FBB9
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 17:54:34 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG1bGG2478489; Fri, 25 Sep 2026 12:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=3naU3PpXFfPjyHmwnMU2HOc7VX7Vp1eDGQD9U5QrY
 Zw=; b=S/QMNYqMNqDcmT75L0VXSKVrsLfr/q6gyMCXiaT8HYayZD3KtLVqL4CgC
 EfE4QEmZCZ2Cr7QiAaeWTEmY0g+Ys78+trD2sEqhoQqQpFeEW3Wjd8sY96wOsVt3
 ALUlO2MiOaS/h3qFBARbzcKa//0w83b4Hz+KIkVMHbYUojaEwqyA+P7c77rtC8Dz
 XlT2GdGcXH5MK3/w1SCbAxOMz64DiBArCiUspFMw90XJSbK8DIwhLslRgVwxS7sS
 R2LfnNYYnaJGr1Yn7IO+24pQXZmG49LefUV3RDCAPJ3hhqgSX6y9Qfcc1hozlhyS
 iNq1E69L20veEWcTaRhO4BpOibxWQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gwtcnsexb-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 12:53:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysNZHxc81yKuT9XJbN7yzGQsRRrx41vcL0xir7S0xnDXTiWTPDVNc9a+g2L5+vHnhhnr5eVmJLNH7kez+w8ODhNx1syyS+WHtJtzocDri0fSsOCJYkvS6Yvqos+3os7ZgJfLcrux4dRuQr8YC1OtbaFdh7e2wOhohg9G7VnPpmmDeHlSxybqmoePCjZdU/hjMTV6VjXwSN/qWrBWGHozcwtrj53qhTF96NqZLzY0VAMSg3IUBaWqwAYRIFMHtG7xZMYNDKdKE8qzqUc4X5TCCHwE7z67S/i1ma8fMoZCkVdxASbrOlQY3hEGjcPAzR/iEw796sLoPmzyJNk0mokmxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3naU3PpXFfPjyHmwnMU2HOc7VX7Vp1eDGQD9U5QrYZw=;
 b=FaKeqIUkJTjkkg5CfZuIId4eP3y7CwzcMwAsAPbPwCYp1GpGvFX1N8sVPVV7pjN3gu8+jzpl/eB1vbcBAqixtezip+Ai/M1bnLQodSucOSSWOzDMdGs8Vd8/jN8kVnHzZWCbrQI0MmfEqjseE/Da+AV0qd1nzbUEPQRDCkNjeUpN6VqRrsRzWWUuQUViTSdJe/zbIHgrB4V7QXFpgS7mKy1I8/dR4S5Rt6kgJLIb7oG7OGgMakBvEF4XbsHlniLuxmGZoTRRxztYMv1/k49TAvsAuEvEm/4qitgor2lYa7uyc4ITFa/bpa8qa7xJE4NzjZLIcntdwxA9y9AGjDr4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3naU3PpXFfPjyHmwnMU2HOc7VX7Vp1eDGQD9U5QrYZw=;
 b=Ve2J3o+phTb16gLMiYVl6YwqZhdAQJCyh9WuKJuCmFnQ6IUuLNurOkSQaopgaggHjtsaVbeHwG0qjkyGRTcsDpxQ5//SwB/+hQ0uY1DqR+VAraD5+4B/qMG3YjVcwXrdf2PGOPAmCJdWwTGEElREHtbTEpHMAkPLJc1U+Vp7Lzk=
Received: from PH5P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::16)
 by BN0PR10MB5160.namprd10.prod.outlook.com (2603:10b6:408:115::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.9; Fri, 25 Sep
 2026 17:53:41 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:510:34b:cafe::f) by PH5P222CA0005.outlook.office365.com
 (2603:10b6:510:34b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Fri,
 25 Sep 2026 17:53:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 17:53:40 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 12:53:32 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 25 Sep
 2026 12:53:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 25 Sep 2026 12:53:32 -0500
Received: from [10.250.148.15] ([10.250.148.15])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68PHrPgK2296425;
 Fri, 25 Sep 2026 12:53:26 -0500
Message-ID: <48c598f8-f206-4d04-a031-8ace135b1b88@ti.com>
Date: Fri, 25 Sep 2026 23:23:24 +0530
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
From: "Thakkar, Devarsh" <devarsht@ti.com>
To: LiangCheng Wang <zaq14760@gmail.com>, Javier Martinez Canillas
 <javierm@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Wig Cheng
 <onlywig@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Ravnborg <sam@ravnborg.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
 <20260529-bar-v3-2-5c2ac1c751ee@gmail.com>
 <2bfb73e6-dca3-4d93-af04-3c644929dd19@ti.com>
 <20260616083921.4066690-1-zaq14760@gmail.com>
 <423c3dca-9589-488d-8462-c3d51f05ee4a@ti.com>
 <20260617020926.114947-1-zaq14760@gmail.com>
 <8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com>
 <20260731035705.3198816-1-zaq14760@gmail.com>
 <20260916082924.956116-1-zaq14760@gmail.com>
 <0a13ccb8-8817-4223-a4a2-0de594ac8c71@suse.de>
 <20260916094453.1062125-1-zaq14760@gmail.com>
 <f4c6feab-b1ec-48df-81a5-888444b243a3@suse.de>
 <20260917025644.1262504-1-zaq14760@gmail.com>
 <CAFOAJEfnDrGTg40h=R0mfZasroPkrSsmbVmmMA91O9uOzu_gYQ@mail.gmail.com>
 <0259fb51-acb8-4b07-a6d5-2fe25fb0de9c@suse.de>
 <CAFOAJEe_7Cqo_=NWPGyYBTu3mD3CjPMC92ZZR6qHPjAhQws7pw@mail.gmail.com>
 <1f59a88c-b0b0-43d7-ba2f-4c50aae87ef4@ti.com>
 <20260918062518.1824876-1-zaq14760@gmail.com>
 <44927324-295e-4528-8a66-2cdd4a52b1be@ti.com>
Content-Language: en-US
In-Reply-To: <44927324-295e-4528-8a66-2cdd4a52b1be@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|BN0PR10MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9404b5-467e-4024-b820-08df1b2def06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|7416014|376014|10067099003|56012099006|5023799004|6133799003|18002099003|22082099003|4143699003|13003099007|921020;
X-Microsoft-Antispam-Message-Info: yQ5wNH6q4u1F9Abuq85RZvTVgGdRbC9+GEuDcw8/w6uMaY/p5WE6sqqOm64NB7iFQMmXE/ok4Dsq/iMFyISI743fKtxyik9Kr5kBMfeGJpwwSGSOYq8M7OL6CsLlhoPdWTJ7YOy9MbDdLNIsGQ9g2G7GkAHIfAz9CgGDEVWCjI9DYLDgrOmSRC6qPTyTlBiiRUSjh2DMgKq+0vc42s8MNpZ83kMuwi2lLJvW+iVVOw4B8JqwgjeMR01gBDKuwVP5IhetbKXFHarU7Iqc/v2a/QPYeFdvZMH8JwC/epeS0lI/so5ZDqgbHrrhdjHiwsU3KQGh48izyzmTU6GaZi2YOKIlh4EsN6e38523jAJeE2Furbzpy0u0PCjZeDs7dTecVL5Bx1gOVAjWxVpPoQ0XJGbGAq3yPIQZcyaGZ7WJ/wMETe1AZWGxSz1lqaxfLSxgiOrlWiWa5v5/7pXVd7gSmXvAzYYNyeTwDBceoNK5Q1tKwVgl9GfFD4N6n5lNk2eDTP1HMqAL+KQ9l21zeslHXMZanOBqgLqLgijf0NoIBMchsnTnvGHVQvVZeuPQz/GY4jrf6PGjb6tFmehO1vxrofaimDMBApMfStuZAS0iU3d8/IvD6gHlBMSg5c40nElHbupxAGFQ5AlSrMnhC5CDfp5XPwhSw95pq6sBnLo0R0qdzXJ415x6mOYuPZHSBF4Z7CGNSAJqwIv9OCBqznTYag==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(7416014)(376014)(10067099003)(56012099006)(5023799004)(6133799003)(18002099003)(22082099003)(4143699003)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fVW2kLzNleAvhBIVaX37PVOmNkplaoUu8FLwNuu2GzK+kdVNkFlbOTVz/vW0dHbAXq2ANtlwwypZ3lXIvSERUlLJKor4fJ5W9gw5HlQ+/Ax+corgFbqKEQV1nU3Kpx6y+ZH5yOK0u1+21xIReC3QJLXGSyI1vTIMeC55/BPTosSsurmf5cvMcY8JSdyD4ZvBkgp8athwOa42lmDjZ//AH1yFViwfK8/hflBCRb7Y7Oe6WsP1qG2e24kt2J6OXT1lZBciuhcLVn+z8/SZVSMTGRYAxQoF08MX2bQovJPGRdrQ5MmDjpNUkWC5jTsV/Hj9l7V9iGQpZs1vQT9r/oVq3EgSlq2JNuInawGfZka/SqfTdy00Ay2tWqAOP+RKGBj4b0vld17mJS8kEkVgQXFg83xOVwjQ+f9RPzeHSJsb34sZElDl46xlQ5KB79eLWBF7
X-Exchange-RoutingPolicyChecked: mOcI/vvFCVc41tieKhhyHFM7j7KZBgL88/3DAL4aGTCeHW4oL04TwT/twelOxI/Qt6ZSki/WmjC2zYZvGoOYbxMxzxNsiQrptgMEZudMkJGJFbMfPtlVu4eQRVjR1ebpcgDvu2Fte2wIjTE1VHLBVwgeXPjPU/ceWSCdAbw/rhbtipPomrBc7R7DMfQm5uaX6NfZIpVgxVd3q6g/aaF9Apw4QH8WDg+/VmqL0OuKZPaLuAkz+3zLB+xh3hiPAApu0r4QLfgiYog8TRPj0pcu3+PbS8r+3T4k6/xyOfXWZ3TV8GTVBDWHB/AsbpP6n1Ec7XMbSNiRUSM/hY654RcSYA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 17:53:40.6160 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9404b5-467e-4024-b820-08df1b2def06
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5160
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX69M06OIagWIj
 hagJ0veiIZal11An6B8GElxLD1Ggb2Cl1WzstI5CMuluyZ9jCeSYNF92lS+yQ/ass3kxXq/dqxc
 AdElt8J1qNS8eRuGaG+fuSpNPWh96uY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MSBTYWx0ZWRfX2oh3T1JrSYft
 2s9dzJ26nWwNK68kqSoqiwp+rGSYVvfl/VLZaHs50uQE7SaEoDejYVfDFjQAbl5gnz8Upc9OwSr
 tYWyMzeyfAWB48cUKihF6bkOr3VYMsUmJdKr1iHx3FgVDwFL25qxk+Ncmf11YWCWNlG+oYIfjP3
 vy7FUts43V1Ton4CjCnrP0lI2mHcoRHXIGDmecxEhB+UW0HD+Eu8zEPURHO81zghmomS2AY+3U0
 HigwXBy8Q5j0Q8D/gPr14qjyyfNneCibGPoIY/gxLmx5b+BBDyE33tR20IxlFMCARWDk8JLWK4T
 lklLzrlegpL2BS6jk8EF4Dd0gf2yDDwUewpWCGHysO9mKOy69u/v7Q+DvY99YcjCeSqKTZBdynj
 1jLVqvVDhZIEiOviLciHgimoHdb/jCxRBKXZKAbp8IiZAxXYzPUYa6WKLV5AOapkrLF/SPN9ocF
 jEpvi6FG3u4cy5WfcoQ==
X-Proofpoint-ORIG-GUID: 31puk68u0praOcIE2Z-4zNeUxYtDmAQJ
X-Authority-Analysis: v=2.4 cv=P6evFSAu c=1 sm=1 tr=0 ts=6ab6b528 cx=c_pps
 a=7wCTOXyfr6KSlQaUtw4X3A==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=pGLkceISAAAA:8 a=NEAV23lmAAAA:8 a=PTNuhyjmd4sFyQkfufEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 31puk68u0praOcIE2Z-4zNeUxYtDmAQJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250071
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

Hi LiangCheng, Thomas,

On 9/18/2026 10:35 PM, Devarsh Thakkar wrote:
> Hi LiangCheng,
> 
> On 18/09/26 11:55, LiangCheng Wang wrote:
>> Hi Devarsh,
>>
>> Good to hear from you, and thank you for picking the fixes up.
>>
>>> Kindly let me know if we are aligned on this.
>>
>> That all sounds good to me, and I am glad it is moving again.  I will test
>> v2 on the PIXPAPER 4.26m as soon as it is out and send a Tested-by.
>>
> 
> Thanks for all the help.
> 
>> There is one thing worth settling before you post.  Back in July [1] you
>> wrote:
>>
>>    Certainly. I'll exclude the pixpaper-426m support patches from my V2
>>    submission so you can handle the review and validation on your end.
>>
>> That is still what I would prefer: the 4.26m is the only SSD16xx hardware
>> I have, and its binding is already acked, so I am in a good position to
>> validate the panel and to look after it afterwards.  Unless you would
>> rather it went differently, I will send the panel entry and its binding on
>> top of your v2 once it is out.
> 
> Yes I don't plan to send the pixpaper-426m patches from my branch as suggested
> earlier, you can send it on top of my v2 series as discussed in the earlier
> thread [0]. Also I am glad that those patches helped, thanks for validating.
> 
>>
>> Please reshape the three fixes however v2 needs - they were written
>> against your staging branch and the driver has moved on since.  Two small
>> requests from my reply at the time [2]:
>>
> 
> I need to have a deeper look at those patches, I had also been modifying driver
> as per pending review comments and fixed few issues around rotation too in my
> internal dev branch, so would want to see if any of those changes fix similar
> issues or not. I may need your help and reach out to you again for help with
> validation on pix-paper once I ready the v2 code. Also we can discuss direclty
> on #dri-devel (my user is devarsht) for faster alignment.
> 
>>    Please keep them as separate commits if you can - git am preserves
>>    authorship; if you fold the first one in, a Co-developed-by with my
>>    Signed-off-by would be appreciated.
>>
> 
> Thanks for sharing those fixes, I need to have a deeper look on those patches as
> we discussed, but in general :
> 
> If the patches are bug fixes then as per kernel patch guidelines I would have to
> squash it to the patch introducing the bug to maintain bi-sectability and avoid
> issues in an intermediate patch, in that case I would try to attribute your
> contribution either in commit message or via co-developed tag as applicable.
> 
> If the patch is adding a separate feature on top of existing then I would keep
> it as a separate patch as you suggested.
> 
> In any case please be assured that I intend to credit you for your contributions.
> 
> Also since the driver is not merged yet, for any comments or suggestions on the
> core logic, please feel free to post it as review comments on my v2 and that way
> it becomes easier.
> 
> Regards
> Devarsh
> 
>>    I maintain the existing PIXPAPER MAINTAINERS entry - would you mind
>>    adding me as R: on the SSD16xx one, so I stay on CC and can retest?
>>
> 
> 
>> [1] https://lore.kernel.org/all/8fcfab0f-6b98-478b-be4a-c5b810fb3524@ti.com/
>> [2] https://lore.kernel.org/all/20260731035705.3198816-1-zaq14760@gmail.com/
>>

Just a small update from my side,
I have staged my patches at this branch [0] and validating, will be sending out
the patches over the weekend.

Liangcheng,
I have included relevant patches from the series you shared [1] barring the last
one. The last one, I did not include because it probably needs more digging as
it does not work properly with the panel and my application. Further more it was
on top of my runtime rotation patch and I think there were some pending comments
from Thomas on runtime rotation in V1 which require a deeper look so I dropped
runtime rotation patch altogether for V2 and will try get back to it later on.

Feel free to validate and let me know if any issues.

[0] https://github.com/devarsht/linux-next/tree/epaper_drm_misc_next_staging
[1]
https://lore.kernel.org/all/20260731-ssd16xx-pixpaper-rpi5-v1-0-18ffc0dbf59a@gmail.com/

Regards
Devarsh

>> Regards,
>> LiangCheng
> 

