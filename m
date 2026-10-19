Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1462606A332
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=NlYH2yui;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=fvjkFbv3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BF9010E1EB;
	Mon, 19 Oct 2026 21:38:07 +0000 (UTC)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418D610E1EB
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 21:37:56 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69JLbem61144180;
 Mon, 19 Oct 2026 16:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=so8cPndTz8bqkWm4lYrRnVQIPhz/t1WQAX+ex5Z70
 E0=; b=NlYH2yui9u/So3nw9aS22EbYRLFBC+z8JE5InYLANWvNAAPM3kV6RD9O2
 6eLLf8YjusuOlJPIXOswgaIGb5auUnqwfNXhI0epsK0d3VIB0vSl8a2BJ3BNGM2D
 wvruPryYgkJGWASwJ9GVOglUWB6AKIjTnq/vkpPl3Gvu3pdMajy5xOM45MQG95AJ
 fXQfGj11975bMQoDehFEiwHlX9mew8ZJ06V0QaNdSPejBUE/5rKiKxltOQO2IhJX
 zu7LHqgU08dtPLE7wBJecPP1H1Q7AR1x7pjmAx0ZCJOpZyVXVIZFx2P9Bn4cpE7g
 vdgq3GCZkiIzNHWcmjACm4ubvgGHg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011062.outbound.protection.outlook.com [40.107.208.62])
 by m0380145.ppops.net (PPS) with ESMTPS id 4hdsy68cax-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:37:52 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrZIXgYDvn7morvgb/0w/4YIRKOpafPx50Kqx1qzTg6ad1tKhBgZCIyKJsshpdCf1W5TnQ3xmGoFiZxSeqJ9jWWjWA8uJ6mH63CD0424lu3vpm+3NWhNpmUBr4VFfkN9yuPYwdLly7ZjOIPpHiUIk2avlqRdSFXZhcuPXeOxsma5vPGMulIq/74c+taiQ5PYUmiSycv7Xk5yTVnuaAzss4sChvITt+WnPRCI+8K3b9wUx9/3MimxOAspX/1JZQ0zOI0NVo/FeEDxILH2CRNnHmDwMYDJPDIPRa7krJO337hQpwno5ws8BTIlV74t7+Lpv9h+YnM7ducO0mF3I930QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so8cPndTz8bqkWm4lYrRnVQIPhz/t1WQAX+ex5Z70E0=;
 b=D/eYizzEKNakoLgNfGhyr5sNzRMVU8rd9fxxzpOn6R3EQ1qLXgfpKjiLsvk2oRcjYUjZkOBuKMiybjQ0bh2+Md4jr6ASxbQRvmneYObH5HfVRZbRD5NyFuT/Ai6lYEhDMVYkBkTRwNzjB2/1DhnHRV2uvE21M0Vd5jQ9MUxXbcv12xlQ4nKm7JEcI/q+tSfqXQXVDkXDTC4yUL7eVPT/mtkIgdehlRgutfKBwIM0HHn0fIpThNYbrbQzaMMl3exgGUvC7WAFww+hZLpS3rTt41UdbnwBWJpXSfwig+kHG7K3bBslUsPQEsCrzQ9XVkDUaH08eERQxKdOnCZMnlKbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so8cPndTz8bqkWm4lYrRnVQIPhz/t1WQAX+ex5Z70E0=;
 b=fvjkFbv3+VpYt0RmMrJrtEW06uEm9grwiH1DvZhARfeH1hA3L0jp9fnjXRt/FdQli7KPDBI9zEr+cT1EtYBjiAxMTAosySpCSBeR2FhAjwo70gz5f4eG7XcTQ/pK5mzcmjZkUu6l6rHw4pdVTHbfjiA8q/mfffddWgdZ9flegKA=
Received: from BN9P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::6)
 by PH8PR10MB6314.namprd10.prod.outlook.com (2603:10b6:510:1cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 21:37:46 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::4f) by BN9P222CA0001.outlook.office365.com
 (2603:10b6:408:10c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 21:37:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 21:37:44 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:41 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 16:37:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 16:37:41 -0500
Received: from localhost (ti.dhcp.ti.com [10.24.51.125] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69JLbdp83577003;
 Mon, 19 Oct 2026 16:37:40 -0500
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
Subject: [PATCH v3 07/14] drm/solomon: ssd16xx: Add power management support
Date: Tue, 20 Oct 2026 03:07:19 +0530
Message-ID: <20261019213726.4145532-8-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261019213726.4145532-1-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|PH8PR10MB6314:EE_
X-MS-Office365-Filtering-Correlation-Id: 7639083c-d29d-4335-c3dd-08df2e2935db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|7416014|23010399003|1800799024|82310400026|261009223327099003|261009221227099003|261009221727099003|261009220027099003|261009223027099003|10067099003|56012099006|3023799007|22082099003|18002099003|5023799004|921020;
X-Microsoft-Antispam-Message-Info: euJzQXBN3g0Xn92C6hj9GfYO2hF/5znfK9wmc/Ht9tu/WTI162sC6zkZ6+UIJBD4oHJ/hTnEofqiRQa6rWvgZCf1na2ahPqoyT6GqD56OAlqn6afPWn6CunujywGpcj8FoCe0e5E4TdlC5V1ObaUTPBZd4IkpxurIbkGZOLLyKcAKVZn78C9vR543Zl0m+MMX74bWqP+bvSstTgZ9903hsZTG6mbgQS18quaGBIcdmAj9US8RraaAG55V11sSs73ouJK2Pb8OH4e5Wxm1TGNkuZslB8pBpVKl1G/mMPDAgfEo5Brkn6EZJlscNv+/ojvyN8+0jNF9pOGyqY4I8a1Mf4O7YctOx7BsEOQniUTxF7ZJJtgBrsyGb5HyydHmrjOSRWssKjWbgNeEqk6wksqO8v+qLoNsXzzPdb8femXbm2e8mjhgf5lsYG8aw1l6l5QrqcuBgarWFK5X+G86kP7QKZiA3FGa+rKw7Lijvc+jLRCNe/LWACgOsCo8TY4urpPn+FnNlxph8L1JiZQ6GzSw1W3jU+m27Nv2btDw9IznK6W7pE3MUEBveQlgF0fiO00b21St0FgSf1oDzi3lbWG+cTSvOgL3MJCu1xWDGTmIA7fUwCphzBM/dEKp9WHeKgLn6tL0hOSX6OEvnoIWDmqUnmlYa2XPZMU13YmWy84uet0+3IH0bgE4e1g33ilexYBqn1RGjWz8ZfScFHYP7akKK74YAB1ftkgWZ9zWwXRzIWGxz7zoZ/hf1dAQfp+N2SI
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(7416014)(23010399003)(1800799024)(82310400026)(261009223327099003)(261009221227099003)(261009221727099003)(261009220027099003)(261009223027099003)(10067099003)(56012099006)(3023799007)(22082099003)(18002099003)(5023799004)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6dBvxnnVnJnWfq6wIn8u23NYYK7iJQfWrzvyW9OV9fcuoNxJ5A5CjAJRBlG9gSE2Ryko7gOq/nSxu71vods19ZKFu4321JcE5JMvswLQOipZ37PPcuXK1BNZNOS/qCq6sFdE2PwHqnzy2l03CtuAfUMoDAe9jaABmtOBCYbUifA18Y1Mrmb4zEHDccW+UGlnV8UtoFmPTZj63R2M+CvSJ29tB9ftW/ki2EV99Q6yfy0N/FgKw8BN4BRJ52Rr9bs8VhTuaWrvfdSzReuJoRGC4tbNI5xxnxU/USWkyPqds6PD64l7jhfTPI302lOlqwOt5yYGVWjc8vwVSNcxBWAFmIcp9ZbohMnj9A2nuYDBikzY7a6nQssd/GGHZzzCPcdgClzSUFoYHi52pn2RUmhPuqd4+C8TjboDtmh22oHHJGfqRoPptdPjFM5hafcVJCeV
X-Exchange-RoutingPolicyChecked: 2hAjobfoCpDa0/GPFsMZMiVulpzrys+pzjfPwco0O9gdayyx2Qlz+NzTsYT2too3R8gII1gvARmG1C9s2R+FVj1ah14v1uk+xiaIPJC9DdUX1oJVjJEMJ0ezjFts5YppPwS/Nu6kEsKu/Ca+rqsf9loj/Mzx2Oud9qwPbAS0+H2h7YoSVaRzSraJV/Vowxc35ZKSMl/0whd3C9fKiUoYf1vGdiX2JKm8s3SxFh/tbY8d3iorRyNQOqfHA68u324/q+7EbmkhtT7p65rrPaqu84Nlcjxxo/GafalpKM8xS/pXWsuxfnvl92P87kdacIFTRxFpx9BxQPCJZ2OhvDikhA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 21:37:44.0792 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7639083c-d29d-4335-c3dd-08df2e2935db
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6314
X-Proofpoint-ORIG-GUID: MQg30NUxyUgUPSAikQXYlstOlCQrYw8B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX+81v5sNcU+BG
 kOKmorqhX+UqIWCFrILkcxaD6xOFyzzUax6jSQvmuR2/6eKzR6w4SOo5v9zB780joMzPr99zHaN
 spbR9No5iEiH+ZdifvPYJozmYz0dGb/q6I6VirbvhLGqjz74AhDepJ/ZHM9ec0LbWvDWkeH521v
 PTudQKRkklbY1t2v7SHbi6S8rYtjqYR6FxRU+zS9/FgNnAdldBG4xcBJ2S3cIeelx2WbSQkcC5u
 WVdxfs4kkU0an2zmgCyCf8ObLr83WImYH2Tg7xfF+fL/liye+fpLbnplEuv2Wh/oxS4TITje+i4
 FOwd9QQtf2+Aj6kLAKUKX+3QsEtvpN+0u59842VFfeqQ/nRm6xQfykJzrcmFjj9JRXxZ14f8a/c
 HfMO6q1ommtdB7mPMMMUM4dljTzjZZYKQdFpmWAHH/7Lq9j9IC6bcTbLHydyAm4SMf6V1T4Zydq
 nf+JnAiE8QwutVATNNQ==
X-Proofpoint-GUID: MQg30NUxyUgUPSAikQXYlstOlCQrYw8B
X-Authority-Analysis: v=2.4 cv=KPTPn1Fo c=1 sm=1 tr=0 ts=6ad68db0 cx=c_pps
 a=ZweBVesMg4eTnUcQsPPJdg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=r3l85C4EJKy2ZlKO6JoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX4K8JnALfUalP
 ntu/By95NA8nAZA3ANJtu5YDiH4+7DNtfQ1H6RrTXyu6L5KnufJkCr5P0s/7u0R/d16bXX4SuGL
 Ce0/Woa8EnIUO/pS56NJmB7eC+E/TI0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190086
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

Add runtime and system suspend/resume power management to the SSD16xx
e-paper display driver.

Runtime PM uses a two-level deep-sleep strategy:
  - Level 1 (runtime_suspend after 35s idle): light sleep with RAM
    retained (SSD1683 mode 0x01), allowing fast resume via SPI wakeup
  - Level 2 (system_suspend): maximum power savings (mode 0x03),
    requires full GPIO hardware reset to resume

An autosuspend delay of 35 seconds keeps the panel active across typical
userspace update bursts, avoiding unnecessary deep-sleep/wake cycles.

On resume from level-2 (system suspend), the driver must fully reset
the panel via HWRESET (the only exit from deep sleep since SPI is
inactive in mode 0x03), re-run hw_init, and redraw the last frame.

For SSD1677 where level1 == level2 (both 0x03), the system suspend
path skips the redundant "upgrade" since the panel is already in the
deepest sleep state from runtime suspend.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
Changes in v3:
- Check for damage before taking the runtime PM reference, so the panel is
  not woken up when there is nothing to draw
- Put the panel to sleep in remove() with pm_runtime_force_suspend(),
  independent of clear_on_disable. Previously it could stay powered after
  unbind
- Return the error from pm_runtime_force_suspend() in system suspend
- Do not clear ->initialized again in system resume; force_resume() already
  re-initializes the hardware
- Do not fail runtime suspend if the deep sleep command fails, as that
  would block all later resumes; the next resume resets the panel anyway
---
 drivers/gpu/drm/solomon/ssd16xx.c | 209 +++++++++++++++++++++++++++++-
 1 file changed, 206 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/ssd16xx.c
index ff0e459082de..99f11b7ec03e 100644
--- a/drivers/gpu/drm/solomon/ssd16xx.c
+++ b/drivers/gpu/drm/solomon/ssd16xx.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
 
@@ -40,6 +41,7 @@
 /* SPI command codes (common) */
 #define SSD16XX_CMD_DRIVER_OUTPUT_CONTROL		0x01
 #define SSD16XX_CMD_BOOSTER_SOFT_START			0x0C
+#define SSD16XX_CMD_DEEP_SLEEP_MODE			0x10
 #define SSD16XX_CMD_DATA_ENTRY_MODE			0x11
 #define SSD16XX_CMD_SW_RESET				0x12
 #define SSD16XX_CMD_MASTER_ACTIVATION			0x20
@@ -52,6 +54,9 @@
 #define SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER		0x4E
 #define SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER		0x4F
 
+/* Autosuspend delay in ms */
+#define SSD16XX_PM_AUTOSUSPEND_DELAY_MS			35000
+
 /*
  * Data Entry Mode (command 0x11) AM/IDY/IDX bit encoding (common).
  *
@@ -368,8 +373,10 @@ struct ssd16xx_device {
 	bool first_clear_done;  /* clear_on_init has already fired once */
 	bool cleared_on_disable; /* Avoid redundant clear in atomic_disable */
 	bool cleared_on_close;   /* Avoid redundant clear in master_drop */
+	bool pm_force_suspended;  /* pm_runtime_force_suspend was called in pm_suspend */
 
-	int orientation; /* Display orientation in degrees: 0/90/180/270 */
+	int orientation;      /* Display orientation in degrees: 0/90/180/270 */
+	u8 deep_sleep_mode;   /* Deep sleep mode to use on next disable */
 	enum ssd16xx_refresh_mode refresh_mode; /* Active refresh mode */
 	enum ssd16xx_color_mode color_mode;     /* Active color mode (BW or 3-color) */
 	bool fast_lut_pending; /* LUT pre-load needed before next fast refresh */
@@ -1466,12 +1473,26 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 
 	drm_dbg(&device->drm, "plane_atomic_update: fb=%p\n", fb);
 
-	if (!fb || !device->initialized)
+	if (!fb)
 		goto out_exit;
 
+	/* Nothing to draw: don't wake the panel up. */
 	if (!drm_atomic_helper_damage_merged(old_state, new_state, &rect))
 		goto out_exit;
 
+	/* Resume lets the runtime_resume callback re-run hw_init if needed. */
+	ret = pm_runtime_resume_and_get(device->drm.dev);
+	if (ret < 0) {
+		drm_err(&device->drm, "plane_atomic_update: failed to resume: %d\n", ret);
+		goto out_exit;
+	}
+
+	if (!device->initialized) {
+		drm_err(&device->drm, "plane_atomic_update: hw not initialized after resume\n");
+		pm_runtime_put_autosuspend(device->drm.dev);
+		goto out_exit;
+	}
+
 	drm_dbg(&device->drm, "plane_atomic_update: calling fb_dirty rect=(%d,%d)-(%d,%d)\n",
 		rect.x1, rect.y1, rect.x2, rect.y2);
 	/*
@@ -1529,6 +1550,9 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 		device->border_waveform_pending = true;
 	}
 
+	pm_runtime_mark_last_busy(device->drm.dev);
+	pm_runtime_put_autosuspend(device->drm.dev);
+
 out_exit:
 	drm_dev_exit(idx);
 }
@@ -1590,6 +1614,10 @@ static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (device->clear_on_disable < 0 || device->cleared_on_disable)
 		goto out;
 
+	ret = pm_runtime_resume_and_get(device->drm.dev);
+	if (ret < 0)
+		goto out;
+
 	drm_dbg(&device->drm, "clear_on_disable: running, mode=%d\n",
 		device->clear_on_disable);
 	ret = ssd16xx_clear_display(device,
@@ -1597,10 +1625,12 @@ static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
 								  device->clear_on_disable));
 	if (ret) {
 		drm_err(&device->drm, "atomic_disable: clear failed: %d\n", ret);
+		pm_runtime_put_autosuspend(device->drm.dev);
 		goto out;
 	}
 
 	device->cleared_on_disable = true;
+	pm_runtime_put_sync_suspend(device->drm.dev);
 out:
 	drm_dev_exit(idx);
 }
@@ -1614,6 +1644,13 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 	if (!drm_dev_enter(&device->drm, &idx))
 		return;
 
+	ret = pm_runtime_resume_and_get(device->drm.dev);
+	if (ret < 0) {
+		drm_err(&device->drm, "crtc_atomic_enable: failed to resume: %d\n", ret);
+		drm_dev_exit(idx);
+		return;
+	}
+
 	drm_dbg(&device->drm, "atomic_enable: %dx%d orientation=%u°\n",
 		device->width, device->height, device->orientation);
 
@@ -1621,6 +1658,7 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 		ret = ssd16xx_hw_init(device);
 		if (ret) {
 			drm_err(&device->drm, "atomic_enable: hw_init failed: %d\n", ret);
+			pm_runtime_put_autosuspend(device->drm.dev);
 			drm_dev_exit(idx);
 			return;
 		}
@@ -1645,6 +1683,8 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 		device->init_refresh_pending = true;
 	}
 
+	pm_runtime_mark_last_busy(device->drm.dev);
+	pm_runtime_put_autosuspend(device->drm.dev);
 	drm_dev_exit(idx);
 }
 
@@ -1744,11 +1784,19 @@ static void ssd16xx_drm_master_drop(struct drm_device *drm,
 	if (!drm_dev_enter(drm, &idx))
 		return;
 
+	ret = pm_runtime_resume_and_get(drm->dev);
+	if (ret < 0) {
+		drm_dev_exit(idx);
+		return;
+	}
+
 	ret = ssd16xx_clear_display_on_exit(device);
 	if (ret)
 		drm_err(drm, "master_drop: clear on close failed: %d\n", ret);
 
 	device->cleared_on_close = true;
+	/* sync suspend — bypass autosuspend, sleep immediately after clear */
+	pm_runtime_put_sync_suspend(drm->dev);
 	drm_dev_exit(idx);
 }
 
@@ -2011,9 +2059,26 @@ static int ssd16xx_probe(struct spi_device *spi)
 
 	drm_mode_config_reset(drm);
 
+	/*
+	 * Mark the device active before enabling runtime PM.  The SPI device
+	 * persists across module reload cycles; pm_runtime_enable() alone
+	 * does not clear a stale dev->power.runtime_error from a previous
+	 * module load, which would cause pm_runtime_resume_and_get() to
+	 * return -EINVAL on every subsequent call.
+	 */
+	/* Use level1 (RAM retained) for runtime PM idle. */
+	device->deep_sleep_mode = device->controller_cfg->deep_sleep_mode_level1;
+
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, SSD16XX_PM_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
 	ret = drm_dev_register(drm, 0);
-	if (ret)
+	if (ret) {
+		pm_runtime_disable(dev);
 		return ret;
+	}
 
 	drm_dbg(drm, "SSD16xx e-paper display initialized (%dx%d, %d° rotation)\n",
 		device->width, device->height, device->orientation);
@@ -2029,6 +2094,12 @@ static void ssd16xx_remove(struct spi_device *spi)
 
 	drm_dev_unplug(&device->drm);
 	drm_atomic_helper_shutdown(&device->drm);
+	pm_runtime_dont_use_autosuspend(&spi->dev);
+	/*
+	 * Put the panel to sleep regardless of clear_on_disable, which can make
+	 * atomic_disable skip touching the hardware.
+	 */
+	pm_runtime_force_suspend(&spi->dev);
 }
 
 static void ssd16xx_shutdown(struct spi_device *spi)
@@ -2036,8 +2107,139 @@ static void ssd16xx_shutdown(struct spi_device *spi)
 	struct ssd16xx_device *device = spi_get_drvdata(spi);
 
 	drm_atomic_helper_shutdown(&device->drm);
+	pm_runtime_dont_use_autosuspend(&spi->dev);
+	pm_runtime_force_suspend(&spi->dev);
 }
 
+static int ssd16xx_pm_suspend(struct device *dev)
+{
+	struct ssd16xx_device *device = dev_get_drvdata(dev);
+	struct drm_device *drm = &device->drm;
+	int ret;
+
+	/* Use level2 deep sleep for system suspend; SSD1683 loses RAM but saves more power. */
+	device->deep_sleep_mode = device->controller_cfg->deep_sleep_mode_level2;
+	dev_dbg(dev, "system suspend: entering deep sleep mode 0x%02x\n",
+		device->deep_sleep_mode);
+
+	ret = drm_mode_config_helper_suspend(drm);
+	if (ret)
+		return ret;
+
+	/*
+	 * If the autosuspend timer already fired the device is RPM_SUSPENDED
+	 * at level1.  pm_runtime_force_suspend() would skip its callback, so
+	 * level2 would never reach the hardware.
+	 *
+	 * SPI is unresponsive in deep sleep; HWRESET is the only exit.
+	 * After the reset, level2 can be sent directly without a full hw_init.
+	 *
+	 * Skip this for controllers where level1 == level2 (e.g. SSD1677 which
+	 * has only one deep sleep mode): the device is already in the deepest
+	 * available state and no upgrade is needed.
+	 */
+	if (pm_runtime_status_suspended(dev)) {
+		int err = 0;
+
+		if (device->controller_cfg->deep_sleep_mode_level1 !=
+		    device->controller_cfg->deep_sleep_mode_level2) {
+			dev_dbg(dev, "system suspend: upgrading level1->level2 via HWRESET\n");
+			ssd16xx_hw_reset(device);
+			ssd16xx_wait_for_device(device, &err);
+			ssd16xx_send_cmd(device, SSD16XX_CMD_DEEP_SLEEP_MODE, &err);
+			ssd16xx_send_data(device,
+					  device->controller_cfg->deep_sleep_mode_level2,
+					  &err);
+		} else {
+			dev_dbg(dev, "system suspend: already at deepest sleep mode\n");
+		}
+		device->initialized = false;
+		device->pm_force_suspended = false;  /* Skip force_resume on resume */
+		return err;
+	}
+
+	/* Force runtime-suspended state for clean resume. */
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		drm_mode_config_helper_resume(drm);
+		return ret;
+	}
+	device->pm_force_suspended = true;  /* Resume must call force_resume */
+
+	return 0;
+}
+
+static int ssd16xx_pm_resume(struct device *dev)
+{
+	struct ssd16xx_device *device = dev_get_drvdata(dev);
+	struct drm_device *drm = &device->drm;
+
+	dev_dbg(dev, "system resume: restoring state\n");
+
+	/* Only force_resume if we force_suspended; the level1→level2 upgrade path did not. */
+	if (device->pm_force_suspended) {
+		pm_runtime_force_resume(dev);
+		device->pm_force_suspended = false;
+	}
+
+	/* Restore level1 for subsequent runtime PM cycles. */
+	device->deep_sleep_mode = device->controller_cfg->deep_sleep_mode_level1;
+
+	return drm_mode_config_helper_resume(drm);
+}
+
+static int ssd16xx_pm_runtime_suspend(struct device *dev)
+{
+	struct ssd16xx_device *device = dev_get_drvdata(dev);
+	int err = 0;
+
+	dev_dbg(dev, "runtime suspend: entering deep sleep mode 0x%02x\n",
+		device->deep_sleep_mode);
+
+	ssd16xx_send_cmd(device, SSD16XX_CMD_DEEP_SLEEP_MODE, &err);
+	ssd16xx_send_data(device, device->deep_sleep_mode, &err);
+	device->initialized = false;
+
+	/*
+	 * Don't propagate SPI errors: a failure here would latch runtime_error
+	 * and block all future resumes; the next resume resets the panel anyway.
+	 */
+	if (err)
+		dev_warn(dev, "failed to enter deep sleep: %d\n", err);
+
+	return 0;
+}
+
+static int ssd16xx_pm_runtime_resume(struct device *dev)
+{
+	struct ssd16xx_device *device = dev_get_drvdata(dev);
+	int ret;
+
+	dev_dbg(dev, "runtime resume: initialized=%d%s\n",
+		device->initialized,
+		!device->initialized ? " (running hw_init)" : "");
+
+	/*
+	 * pm_runtime_suspend clears initialized after sending the deep sleep
+	 * command.  If a new app opens before the suspend fires (the put was
+	 * cancelled), initialized is still true and hw_init is unnecessary.
+	 */
+	if (!device->initialized) {
+		ret = ssd16xx_hw_init(device);
+		if (ret)
+			return ret;
+
+		device->initialized = true;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops ssd16xx_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(ssd16xx_pm_suspend, ssd16xx_pm_resume)
+	RUNTIME_PM_OPS(ssd16xx_pm_runtime_suspend, ssd16xx_pm_runtime_resume, NULL)
+};
+
 static const struct of_device_id ssd16xx_of_match[] = {
 	{ .compatible = "gooddisplay,gdey042t81", .data = (void *)GDEY042T81 },
 	{ }
@@ -2054,6 +2256,7 @@ static struct spi_driver ssd16xx_spi_driver = {
 	.driver = {
 		.name = "ssd16xx",
 		.of_match_table = ssd16xx_of_match,
+		.pm = pm_ptr(&ssd16xx_pm_ops),
 	},
 	.probe = ssd16xx_probe,
 	.remove = ssd16xx_remove,
-- 
2.39.1

