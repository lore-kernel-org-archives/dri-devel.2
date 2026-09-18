Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414CEC88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2243B10E403;
	Fri, 18 Sep 2026 04:55:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hF5Pl5wr";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DaIy3RXD";
	dkim-atps=neutral
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABDF810E403
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 04:55:50 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68I4sulG3299086;
 Thu, 17 Sep 2026 23:55:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=awmsF0W12/f2lXLkG4ZRBvEwez36Wt0iU48mzmrH8
 OY=; b=hF5Pl5wr/WhHvHSwuDJO+UTH6JoelHZcClFjqVsR7c3oSiQFjtXYXmBGF
 yICNMPG4+Ozu+IwHlNzudkBBgmir/IMISTNrInjEQdIq1xSh9ulihxsRbFOQKinP
 mMcwwGfBf/5Fh5wC/sD4BOihFQ6TcwGBElRsUEoHQCTljvxpCB0vN7Gyu1LYyXio
 hPXGzzGuF6ckhR2Vf/Drvlpz67t7KeqrYTUVtezQfmz2qlQWGn6TwxVu1mc58Bbw
 hXkOZ5O7yHxpzPBEcuf9BIkac8ikobriJDPHARkxCcE3ernizGHx3Y58DsgARwK7
 +fS/nKovjcM08jqPbHRCgUNu/juzQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010040.outbound.protection.outlook.com [52.101.85.40])
 by m0380145.ppops.net (PPS) with ESMTPS id 4grx6d86e8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 23:55:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vtWnxsLEW8LXfIfSgw3CFTGTxX5ECx4jTXs4Se1vfiHfeNU/PzPxapRg8RS0hbNi4MAQLCGQMOLUsBa7CBZJOtE+gFju+M64cbSPsPc2Dv8idW9Cccdblxnq8jkVCu9o4UkEJ2ucYKlRHo0B8vWOaMLdwfVIiG7+Qu1ASMxezT/h+GJWDftEJ8vgjkxpS8rKJ5geI3/wWCgspZFs7yJFdLJWrHS5kmV8QvoKNtVOEDwp0hS9xpnQprmErbUJGHycrdngphB6Ay0VHO9jYt57CNpLwfEuYDvOy0SkfTtpPjTUCU2B9IKK1pS5FwYzqaBt5cY7vTJADx+j2oPZu1V8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awmsF0W12/f2lXLkG4ZRBvEwez36Wt0iU48mzmrH8OY=;
 b=NlHIMPqbyuNcehgD+mJGr/IubAc67/DbvAo2D9tILXLSEnURApX53iAAUIbi7xwyT947NszR5xlKAYi8B4E93LMGJ63N7u/oDHulRwXHewKZYrTVoAJHpZwID2aaev5jG5ZNtHgOp/dzDu6k9bUC+kpjva21nD+uSzIuRQvHWn8FnD6AwI59L3yQ0PiqGaSFkQ/f9LqRXtNOyTdw+MmaDmCiNDBlxrV39BcJMeech+bkwAb4SdKyq5AR6dwatYiA/H/M9Me5lUpu736pXFvEXGr6BkkpMdoN1H4ql1PwqImUU2GQW+8NX9JWAY3WdjCJa5vntjiEf1/FbwvPlmmpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awmsF0W12/f2lXLkG4ZRBvEwez36Wt0iU48mzmrH8OY=;
 b=DaIy3RXDllHBibVqfAaRdM+1rawAggSAOAk/idrGWwuMc1OcgV/0fhsPx+nBPBN84PC3Em1RlsDaCSjQvuvVGXIjJ8O3NfjL17ut3eL8qA3bOtHRIaGR3tSWWC/ZPg8dVoQHvOMXenSvm5dhBoVzZ/G6N1OOi3TTxj5pG1iEJrY=
Received: from BN0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:e6::24)
 by MW5PR10MB5806.namprd10.prod.outlook.com (2603:10b6:303:193::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Fri, 18 Sep
 2026 04:55:32 +0000
Received: from BN6PEPF00000074.namprd03.prod.outlook.com
 (2603:10b6:408:e6:cafe::c) by BN0PR03CA0019.outlook.office365.com
 (2603:10b6:408:e6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 04:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN6PEPF00000074.mail.protection.outlook.com (10.167.248.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 04:55:31 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 23:55:12 -0500
Received: from DFLE202.ent.ti.com (10.64.6.60) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 23:55:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 17 Sep 2026 23:55:12 -0500
Received: from [10.249.138.184] ([10.249.138.184])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68I4t5O5130390;
 Thu, 17 Sep 2026 23:55:06 -0500
Message-ID: <1f59a88c-b0b0-43d7-ba2f-4c50aae87ef4@ti.com>
Date: Fri, 18 Sep 2026 10:25:04 +0530
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 2/2] drm/tiny: add support for PIXPAPER 4.26 monochrome
 e-ink panel
To: Javier Martinez Canillas <javierm@redhat.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, LiangCheng Wang <zaq14760@gmail.com>
CC: LiangCheng Wang <zaq14760@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sam Ravnborg <sam@ravnborg.org>, <dri-devel@lists.freedesktop.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
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
Content-Language: en-US
From: "Thakkar, Devarsh" <devarsht@ti.com>
In-Reply-To: <CAFOAJEe_7Cqo_=NWPGyYBTu3mD3CjPMC92ZZR6qHPjAhQws7pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000074:EE_|MW5PR10MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 95810403-c360-4d3c-8c63-08df15411120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|7416014|376014|10067099003|56012099006|3023799007|4143699003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: MwnPR5illyd0IxymeX/Yp0/kzXYheOMI73VlwVLNe9aLIPe0PxWjrluWgWjrBrkMJuWg1nQLLOP0gdOgFX87X6Tgd4x0uLysdRK7V2qY/b/EgCr34SZbe4C9eLInv2tezZX7CYUXLyaTS/vvKShCUkbw7pE+5m2H3VXa7p8f2U8YPbsFLPCt9I1ANh8At24HG6Nfd15Pyypn4j63YGLPmbosz/Tw/J/gYXRw8DRzyj0a5X0xqNxQrWmqlsbDS2KBf9P3Ik1lzlCaZognew9bmwk848JeE9oBJx4WEEiqXnH79lRuRkRMyrTw7KmHvOLYM2kWShS6tpVRTB1JNQw+szF0rb8JOAnpFcZ1lDdYOTePAtCjxYaGTvUfqdKAPufsk8WXK8a90QzvtB60yWhMqALjllHBMJayB/7Vu4e20ZL05onCXlan1Sz1i40tbg4+4avbMqmLrwPqTyZUZsFV+g/tzDtePK4+n2gyHZ5wUVMw6/TcsTsd+eCXMaLx+9H/GI/zQPsfkb270fOJotPZq/0gNiO8vJ4W1c14lS1hl/7tTnGOzpAzNLUeP58YdxH0aGyrV9btv7GJ+B0MBM2vMZf3uiit4o6AI104lpD+4bQzWcfag84E542e9w9su4vGK0jIyAfl3HPylbKUG55Y570rypYoGdF7V1YWcGAwTE1vQx8hdlxTRmfjoYRHOEKKJI8jThU7l3NVLwxVuhjX2w==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(7416014)(376014)(10067099003)(56012099006)(3023799007)(4143699003)(18002099003)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f3rM2bXIF3Q5BiQe5OtPlivnD6n28mDe4P2G2K+FqUYXIxm/7PHDhN7rD7+ULg+lFEQ9a/xl6UTt/iPiICRnJO+v19LJaqhrqJDVV/nRRSp7vAy85wyHWpe+4orKiA5anNpFOmZuu8nNni+pz62Ooo9Nm7uUpe5g3TMibW1FONPqI/6az7vQhvhBueYAdB9ffZN5p8EXGXh/yWivJHDHI1q1279wDjGlMZTTCc5ROx2Cyr5Nn85bUHbarlzUiurj/LaQH/Rr3Ez6mPRe3Ug41FBdjCMilv0i4SBV/RjfyhMSzjYqa93BRlZ0X9WXA48N4b7B0kCa1l5PnsA9KrRH6dbmUymz8RN32Go+S0u6w2vA1JvbYVrEM0sQM/PyLUggOHgqW3oDqzjYTJV7Z9mooG5vFZolmid38+qXbiP0z76rASGsFtTJolD1HafGmNcn
X-Exchange-RoutingPolicyChecked: 0JbfcgiMXLluYUY8wyM12FuS7nxcpoEh6t3CC4Kc0RSfZgh+Cuokxzmd4fLFTKSXInZ0eWOGx+mcQ0gT6Q67sHZmLXBnBiMGqd37ITvqfJMWarW9p/pYUz15UN6Iie87HPruAjm1H5q8Zsym2yW3aRVsgbSyPSQUop3Tyd2nbAuWmsTboLtk0bZdOGsZ+nHhNhkBRPRd6ur++esuNUl4rIrgtBctN4iyJBmCoJhh64eH6TlhpAP+GdR5+OcAERA3gkslnQ/a/hm8cOyb2NQmH+YCeXXcxayOiGB22vnFsMByN56RI+2THhZsj8tQ1LF0PqDqAB1BVljSsD8h6JXXsg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 04:55:31.3117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95810403-c360-4d3c-8c63-08df15411120
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN6PEPF00000074.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5806
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA2MSBTYWx0ZWRfX3duVcIpYmUIH
 auK+sXfoTKxAN2CimpOjFVlA+gtTdGzAoyZoaUhf922XaB3WPu3g6LlJKVpOIOyGG0WPfVLMQHf
 6q1FbR4/POf9q++WaVnw6COCb7z4xiw=
X-Authority-Analysis: v=2.4 cv=Cswq4X4D c=1 sm=1 tr=0 ts=6aacc448 cx=c_pps
 a=G4czNpscrl+lNx4D7BJ0lA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=o4p7WHDlZKQ4qsJPCBgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA2MSBTYWx0ZWRfX5dSUB6cQC8g+
 Nek/tEVotcz9VxF+Gif8Q9TOUKgv6DDzEjgocqca/ysWK1r79BhkDDCDhtL/T4RSshbr4zdhE4h
 +JrRu4yBtj977TLixaak83ZiOyuucfnIa+BtUX1raXPFBedxkJdiZARYt+Jt0yGffg8yurfgVfn
 cm7FoicqjKwIkz04mQrnxcGG9hkNDZcHdFi/Wrp4sZIkaMA7I0+RVpQ8iSwzt60ALwlfnPr2/a4
 iNixtfu5hsd/+3rRLUMuKFxJnX9Ct4s/uH2SxDrMJNCH5TcYIe4vlOu90WAH379AupSWVrHKcqf
 GrhrdGskZnB/Hx/9445TzbnaopJLIsajw/05OM6SmHCWzKk/QeEPXZLQuEua49ROfZl9hAJX1n+
 1xJyR2AtAon2l1KM9ioXjyGimBcct2VbQH20ksAmKdlayXq+qHqBByE9jvIPdrgHKB9rUTT/UrK
 kHe4H205sMgO+hUzAzw==
X-Proofpoint-ORIG-GUID: 712OxfMTYTkypV3QPbVR6LCMDprs9t-G
X-Proofpoint-GUID: 712OxfMTYTkypV3QPbVR6LCMDprs9t-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180061
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

Hi Thomas, LiangCheng, Javier,

On 9/17/2026 5:45 PM, Javier Martinez Canillas wrote:
> Hello Thomas,
> 
> On Thu, Sep 17, 2026 at 1:34 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>>
>> Hi
>>
>> Am 17.09.26 um 12:49 schrieb Javier Martinez Canillas:
> 
> [...]
> 
>>> There are a few bits that I think are similar though and could be
>>> reused, for example the pixpaper_spi_write() helper logic is basically
>>> the same than ssd130x_spi_write() AFAICT.
>>>
>>> Same for pixpaper_send_cmd() and pixpaper_send_data(), I believe that
>>> is the same logic that we now have in ssd130x_write_cmds(). Specially
>>> after the recent commit 3e391b0b516b ("drm/ssd130x: Add SSD135X_FAMILY
>>> and SSD1351 support") that introduced a cmd_params_are_data flag that
>>> allows to send the operation as command and the parameters as data.
>>>
>>> So the MCU interface seems to be the same, in particular for the
>>> 4-wire SPI interface which AFAIU is what this new SSD1677 driver
>>> supports.
>>
>> I cannot advice anything here, but at least I'd like to get ssd16xx out
>> of tiny/. It would be great to have it all under solomon/. It looks like
>> sitronix/ does a similar thing.
>>
> 
> Yes, I agree. Especially since there is even some (albeit small) code
> that could be reused.

Apologies for the delay. As to what I had looked on ssd130x family it was a
different then the ssd16xx family which caters to e-paper, so I preferred to
keep it separate and write only a generic ssd16xx driver.

Yes, I plan to post ssd16xx support under solomon as suggested and that would
handle both the pixpaper and good displays, LiangCheng had confirmed that
pixpaper was functional with my staging series [0] albeit with few fixes [1]. I
am reviewing those and will try to cherry pick them and include as part of my V2

I target to post v2 by end of next week, after running thorough tests on the
epapers I have.

Kindly let me know if we are aligned on this.

[0]: https://github.com/devarsht/linux-next/commits/ssd16xx_7_2/
[1]:
https://lore.kernel.org/all/20260731-ssd16xx-pixpaper-rpi5-v1-0-18ffc0dbf59a@gmail.com/

Regards
Devarsh

> 

