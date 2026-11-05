Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DEF606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=kGWMBqC8;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=BckqlSCe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6CE10E334;
	Thu,  5 Nov 2026 18:31:58 +0000 (UTC)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A5010E334
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 18:31:48 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A5HghVH1414101;
 Thu, 5 Nov 2026 12:29:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=VqFZ8RiK7aVH4
 u2kyCiE/zRl6X0lw5/kIT3hGto9kNA=; b=kGWMBqC8H68L5enaXAOhQ7dtrmyxV
 UJ5vIhop/zjBbDbPh667u/tnXFaTubqxG/iRbZJvSkwrC1dWLAKyR6E4SIgdoLKb
 N0WORAmd05cpwHxiTXit436Omy5HOg/c00jetCzlYGOTwACT+cgPzhQg5Pa0tz6B
 yffTbvxzlM85MoG+95d35GqpCnZLIYGc7+s1IeQT/6WNmt/mVLbQ3P4Y50+0Ewf/
 3u00FWKOtkVkpxSJQbQSoVwkqpvdWMQMr1L4144PXh4p1Y5vYRR61vp4p/uRn/8v
 NQ1MIDgplqCBOe58c0KrNq915Nb7prsKv5zPzxjKoZKOfLSpOLR5f7hcw==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
 by m0380145.ppops.net (PPS) with ESMTPS id 4hrq6tk9xw-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 05 Nov 2026 12:29:25 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACU5Rn7GVDCr/tBHUcrF3owr9ngUqcShWhbskZHZmL5RPh0QawvsDnFgg4+m5zG+0VyzeViTU/ps4+SksuMUsdcFdQzN0yfO79FS3A40X1f6hSXeQZQu2Ti7L1a8mI0vHL0po56dh2Xaadr3twTDzhdgB8mpw12EegFpMcxhS8U9UgYd22ghy2L/y/9M6bfCrT6OHoWWz2aYmVcuGz2IytNe5yTDGHyvHeKgAXCGU0d8juyBQlYApcSKWxqTi3BanSIumXfF9lvfbjOgpaXDcF5HJ6sEP4jqNY66uDydIoZynRm3YtSsD23oJMYqH2tcZOxcOeWHfN6jT2ViO5YnMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqFZ8RiK7aVH4u2kyCiE/zRl6X0lw5/kIT3hGto9kNA=;
 b=N39pVQnWdu2SZ4h+9/+zlzYvDIvC7+gzkRYL0vr7xpMlRvJfe77AD67mPHLiEZ1ZbeO/hn5LtwvnVO8xA/DgNvfLuBX2LIkBEeyBxQ2mmwwGr3jpGh++msACQhB35PJXNA/jHOZLM4KAMK57YYutmU3uyHhph/DqDoeY6eORsOshovSgPB9/OWikQmFeejgvon4jIMLPaKq103Jm5N5suo6y6jC4mZfVx6gYSH/+RQTmnoN3N0mLYlKP1cq1vu9wBJBHtV/K1u1j9pFIuyiD4FT8AIuqr0VEtqf4DImAG+nyjXj2rvDlD4VKogxTqjvpymIN7Thdp8r4P3SmP+auAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqFZ8RiK7aVH4u2kyCiE/zRl6X0lw5/kIT3hGto9kNA=;
 b=BckqlSCeuyN7vnyCCjI9eiO5hxXulH7uqfI0Kzf5aWxV6A6zRfmZDJ+2m9+aVrIXC1M5BwAgKP7wnuhw7h0t6ZhnS5KZDNdb/0lnSRcwUeaWfyl/la4yVhfm0naGvS0fe2yxvMGK6+ZKb1F8dA6dicCE1ukMjwQU6SCmkxrQVEI=
Received: from MW4PR03CA0264.namprd03.prod.outlook.com (2603:10b6:303:b4::29)
 by SA1PR10MB7830.namprd10.prod.outlook.com (2603:10b6:806:3b1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:29:08 +0000
Received: from CO1PEPF00012E64.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::3e) by MW4PR03CA0264.outlook.office365.com
 (2603:10b6:303:b4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 18:29:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF00012E64.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 18:29:05 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 12:28:24 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 5 Nov
 2026 12:28:24 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 5 Nov 2026 12:28:24 -0600
Received: from localhost (mz02jj9v.dhcp.ti.com [128.247.75.230])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A5ISNa2645537;
 Thu, 5 Nov 2026 12:28:23 -0600
From: Sen Wang <sen@ti.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jyri Sarha <jsarha@ti.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Sen
 Wang" <sen@ti.com>
Subject: [PATCH] drm/bridge: sii902x: Balance audio mclk enable and disable
Date: Thu, 5 Nov 2026 12:28:08 -0600
Message-ID: <20261105182809.290537-1-sen@ti.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E64:EE_|SA1PR10MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: ac515d67-9f37-4059-69f7-08df3b6aaca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|7416014|376014|23010399003|1800799024|6133799003|18002099003|10067099003|921020|56012099006|261022105027099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261009223027099003|261021123027099003|261009221227099003|261021121427099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: pQwvuarnHvGCpC2Ajgx7RZTHlABo2OcGFXC3ZZmpz4JLasD6eCayzCAnr2fvkIXfdIdt80hepfnb8CsRkuGkb4I7CfsU9/SHUDvWOJtpwd7z7i2K0uDZArXJT3JIkhumVIsNEKU6cVjrxp1Z0IHYRPSRzhmMaTIiBo7AvmXdB+tDnyCG5eFnr3hPVXFmyPrw+NqgtpYqQNdoqPxWSDgK7Fl9ndRhHp3yjqiXXeIxUDKUXWCyqjhBn1iuZShK/jcB7JPIVLJyr3B+La+Pn3CtBobaUFEs5fseBhY43NSPwIJuGwNrB8KaH4LwgbPAaD+C47Ng0R8n1MQDT1gnPyvaD1J1VLMcevHlIF0nvngQ6zSKlnm9QngaoFGLUWRt5uPTtjX7tE9T3w7ZHzvVjk1GBoLs/vze+EtGg+ZYGArel6Rlps0Fu5Duy/dEFZFeVhJPhFXL51RsacTAX4JM9XmeHVD/MSU8/G+i0sjnGdp9ktfTTHFRf8MvB+PoGsKNeEl9P2tWcMG1deJxDhJ9FI/tr7VJavsXwmQn9wGvKWWMNvATXKavlvpHeI3k9tUzymw4Hz1Tta+ijTKFuiNWhNL4NDLuItTagJlb9oDZbBB4vZw/muqSynwcxmmtTyvossMI7FkU3gvGsm9t/7xWoczaFxfQudq5SJp/plV3RtNT6Ma9+WssOPLgD1FraLwG4UoW0Rer+DC/d4afT9J+ECHN/Ik+83EG6B/2XIgrw8P0OI5MM+AFnbXZtVu64SoCw6G4
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(10067099003)(921020)(56012099006)(261022105027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261009223027099003)(261021123027099003)(261009221227099003)(261021121427099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lnAvWvbrqNkjQS2UCXfpneYawhu5MMAdtRObI54FNf6zaVxZVsLFUp51xNztcNkiIbwEomaXKBS0X8x6b9vSKk5vqSt+h1GzV928XN34h8YvMK7gKTkRGZnZZAGuENffBihoKr7L59vxqiHFRhHu5tJTMp/yb0Unby7DT3R+hBOiYlitx1JlAwOQpPYONnks2hQbRU9SikjC3OkF9nQLRnpg9nP+p2sS6H7f6fQpVIK+5+tl5YOplvkTLfl568UYT5iBJu9LicOVwMi3ITqotovH9rUJ/BHrL9QWC2fXoZAEmH9a9UmkbP3xQ4jN+XiGGbNt3j1T9QFWq1E/hjD7pVWCawMmFdT+szYLXbFu/RK8zFnnGY2SftmZUSyXmpyb5Bj5M17p+2vGhJGBoStge3BIz2Y/o4sHXjjW6CnagI4lhf9Yq+Bxr+hEV9OmeZnT
X-Exchange-RoutingPolicyChecked: Vjzin4rEqjSTxWODoz3jCY0wun23G0TDLNlSqQPoDdMLy6rOfTti5iaR6wY9UlWpPBFqhDtwPWxVKUY81HbW5py9HeZnzMVPLYs96WBORprRkS9CkBsDIVfNT/X9h33M0zDXNuW+39L6g5O45AJzrwQRGLtRMD0Rt364JeGDVjXoXjhLtynyerPS3WvPL9/okE9GoiMeIT5sZBnp8+DeMdGao6LwjR+puF9dV2+o6701Skc/oj1pHDA7fd5VcTcAVziWgXrea4MQcLdZHdxQ5tD3+2N1cti2JJ+xa3cJkiUZwMtC6U1fvQMjbEuRqAjRuLvX8abomwKco/woiBPUEQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:29:05.7385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac515d67-9f37-4059-69f7-08df3b6aaca1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7830
X-Proofpoint-GUID: Nz8KkqVWWGfN0-JVNbufv71ON9m_aCG1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX+qrgAqnzsWQX
 xLFvf+/8yRcYZAlxcjQYQH2H/puoFZkNHD9k9Dlj+76E69ASNW5sZcG4pu5lza9vTb+RhSnfORA
 NRyFXW9d/YebgYrL8TtImKaxQfz/gIw=
X-Proofpoint-ORIG-GUID: Nz8KkqVWWGfN0-JVNbufv71ON9m_aCG1
X-Authority-Analysis: v=2.4 cv=Q6xHcI2a c=1 sm=1 tr=0 ts=6aeccb05 cx=c_pps
 a=9+FlcKToPViwBAZXYho+KA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=5E-KntT-4LgLribNgRsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA3MyBTYWx0ZWRfX/jkqWOF9gjBC
 l/a8VJRnXxegsaDXDtRvXLvEtnzSE8LXwyZ7mmJ7+oblwNwQy5rX/ZSeSBRqswyUGDt3z275gsd
 C/SFL+y6bgaRNHQq0TxihpgaLRhnuSzf/mOrLVwwMrBF4ArKr4lTtuACPL/75y6HZEvcHF4uUG5
 yXauYc1Gluy8hkR7ztSLirtjptBvsrDyHxVbUP2KTtewveBj943UlGca1y3tbD4tgZpB7dMG4Xp
 AQ7wxug1I+wrT2bwBSA0Zf0d13dNh0G5XAZlQXxvZG+O60b4FQWF5coKiNn/wpRHhKaS+jx6cK+
 tCdJG7m7UY3nnatZPWuGxzplhi7tBRf55E+sp10a/dPf72gyk7mYnX0q4AnCZLBmZvzapNThg1t
 ULC7a1MUj2Ch0apKReFKKcgC4ptuVHVM5QfrdmEkCVMXAjFn3l8jp5AFNJncCbBqxs2cR+ht4qJ
 UuYHRz48LJLuBYTshkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050073
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

The driver currently has an unbalanced clk enable count, as
sii902x_audio_hw_params() enables the mclk, but sii902x_audio_shutdown()
disables it unconditionally. This creates a few issues:

1. hdmi-codec calls audio_shutdown() on every PCM close, even if
   hw_params() never ran. For example, PipeWire queries the hw params
   at initialization, via:

     aplay -D hw:0,0 --dump-hw-params /dev/zero

   The clock core then hits WARN() in clk_core_disable() and
   clk_core_unprepare(), printing a backtrace and tainting the kernel:

     sii9022-mclk already disabled
     sii9022-mclk already unprepared

2. A second hw_params() without a shutdown in between enables the
   clock again, thus the count never returns to zero.

Therefore track whether hw_params() enabled the clock, and only disable
it in that case, to keep the clock enable count balanced.

Fixes: ff5781634c41 ("drm/bridge: sii902x: Implement HDMI audio support")
Signed-off-by: Sen Wang <sen@ti.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 9aac44ed5b67..df72712f4296 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -186,6 +186,7 @@ struct sii902x {
 	 */
 	struct mutex mutex;
 	struct sii902x_audio {
+		bool mclk_enabled;
 		struct platform_device *pdev;
 		struct clk *mclk;
 		u32 i2s_fifo_sequence[4];
@@ -681,10 +682,13 @@ static int sii902x_audio_hw_params(struct device *dev, void *data,
 		}
 	}
 
-	ret = clk_prepare_enable(sii902x->audio.mclk);
-	if (ret) {
-		dev_err(dev, "Enabling mclk failed: %d\n", ret);
-		return ret;
+	if (!sii902x->audio.mclk_enabled) {
+		ret = clk_prepare_enable(sii902x->audio.mclk);
+		if (ret) {
+			dev_err(dev, "Enabling mclk failed: %d\n", ret);
+			return ret;
+		}
+		sii902x->audio.mclk_enabled = true;
 	}
 
 	if (sii902x->audio.mclk) {
@@ -761,6 +765,7 @@ static int sii902x_audio_hw_params(struct device *dev, void *data,
 
 	if (ret) {
 		clk_disable_unprepare(sii902x->audio.mclk);
+		sii902x->audio.mclk_enabled = false;
 		dev_err(dev, "%s: hdmi audio enable failed: %d\n", __func__,
 			ret);
 	}
@@ -779,7 +784,10 @@ static void sii902x_audio_shutdown(struct device *dev, void *data)
 
 	mutex_unlock(&sii902x->mutex);
 
-	clk_disable_unprepare(sii902x->audio.mclk);
+	if (sii902x->audio.mclk_enabled) {
+		clk_disable_unprepare(sii902x->audio.mclk);
+		sii902x->audio.mclk_enabled = false;
+	}
 }
 
 static int sii902x_audio_mute(struct device *dev, void *data,
-- 
2.43.0

