Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA86070ABC
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t7rsoS2W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F8AE10FF3C;
	Wed,  4 Nov 2026 22:16:01 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010036.outbound.protection.outlook.com
 [52.101.193.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C093710FF33
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS25jIcanwS/1XaRuP9HmyAYXJIp0vqPY1hin2LBFt8YH+dOhqawsrGGLOniW+POQnQUWLvTbg/M+E6ZoWkpQmk2f+3v8tWxueAzk/gxP4uqBtTJUB3FuWTFIaNHi1OQdYR9g25V0+6NRdBnFSDkZRjdqO/z1LaxN+STRz/WghxvaLt8R22Ao20L2r+OO/gy8F7JtnTj/+K29tvCQdTsgN4LIEC3dGlqpof1Vrg/jEXWbnhRMW3HFsOvEbfvsyOvHPPmxJ1Pjx1P073q9yEWYuy7tuVwA9e2XYlzBHlMGxZLdrN0gCBYsiVEq7PHhsK4Uy+fnHmKT46+8s2mqvKxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpZyyPzddIKp+7+bodQBSlP/pYQk+xt8YSz1Sd2IPno=;
 b=P34NtDs102Kg6VOhSXeN1+axVcck26shPgK7t4xhRBPlUNbeqyiKJdVKF9uieDJgTv4JFO/vEpHQXYkmwNAWY5D4c+t491aIYAU1DR314HQHm97TW6X6HMvVxr9Qv/LmqGacSr6qlS7lf6AHRnMjw/ji+XTC/RGnqL+9G0wxMxi/lJe1b+sTPqpR0soQN9kyerlAP/shHLc07GogEPQ7yqRDHfEKtEoXs7hZd1rAMEDbjDQk+3WVR/AZHryxDlrNsKf8FnG8yVztKOZTFoX6XYwqPlx/UVx0alI54vJJ/SoVl4kfq6xAXUE5rlqIo0aPsGI6hpESWIszBp5rWLw+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpZyyPzddIKp+7+bodQBSlP/pYQk+xt8YSz1Sd2IPno=;
 b=t7rsoS2W93h6VhMx15xHm0Rl8qTP0FpHgANMh+/q77rHhmbmwd+SVwo2CmOdJyF7FL1VEkekqsRlHiTgkggrKA7eDpyetdHvmyZK4bQHpzYRnWNaw8IsQBbuQmpOon+wxcKYhe4K2fUH7rnUSmuFPf7ZZSQsH2mAmZxLjW3rsXg=
Received: from CH2PR11CA0009.namprd11.prod.outlook.com (2603:10b6:610:54::19)
 by IA4PR12MB360382.namprd12.prod.outlook.com (2603:10b6:207:14c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 22:15:50 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::53) by CH2PR11CA0009.outlook.office365.com
 (2603:10b6:610:54::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 22:15:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 22:15:49 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:15:48 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:15:48 -0600
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Wed, 4 Nov 2026 16:15:47 -0600
From: David Zhang <yidong.zhang@amd.com>
To: <quic_jhugo@quicinc.com>, <karol.wachowski@linux.intel.com>,
 <max.zhen@amd.com>, <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC: David Zhang <yidong.zhang@amd.com>, <sonal.santan@amd.com>,
 <mario.limonciello@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: [PATCH V1 0/4] accel/amdxdna: Add AIE4 debug buffer support
Date: Wed, 4 Nov 2026 14:15:36 -0800
Message-ID: <20261104221540.631182-1-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|IA4PR12MB360382:EE_
X-MS-Office365-Filtering-Correlation-Id: a20bb4e9-7867-4663-507a-08df3ac12e6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|7416014|376014|23010399003|1800799024|10067099003|18002099003|22082099003|11063799006|261022105027099003|261028144727099003|261026140227099003|261021123027099003|261102123227099003|261009223027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5AaXW+Y168gMmfUgn4AGaTtQi7xveD3b052Dn1GQqXQJHetKG8/IW39FWUEgN8/bUrMsLF+bU3wwhPakDa5n1WR/SNeNdCLPmyb2jYEkxg0Oc7ZpbICzWC5UbXpWVHJqdk0x5VhWEEgAWcPKA0pkNNcADygA6WY/C5Psz2qt8AWcu/FxFrp+4DPip9MJ3yXwr2x9v1gBiss6KzsKFGRDgXILVA5Wy/MpAo531lt+v4sCX+n5GQk752istWK4bG8MdHzFgFZUoqQVbL59XAVuClnkcZnCFoPXEWnUOXtIzuB9ZgDekAxrsWsvDGnllOSnpt4EOUdtfR6qQaX0Xf6TYik3QUIPavC2pPAWzz/Sg3D0ELIBLbp+HmtjMGzzdK5yVC4BaqSjWpFLurzqOMvO4u60iXQwZhz6alP8I88Id/7zSJQM4krqKQXHh1sr4zW31x6iRCkR1AHL7gXyTvo+u+TGtDD2Zvb17uSnJonRd8yvZaqICoYs+N7yoqRGLI98DFON9C5vUsHybtsypkYchaRAXkHeNLmxd37STxCvEnyrc5umDZuHqW1i0T8hKApMIj3dkGkvgbbum9Wjfm1HYbG9Txcl6g/qy6D2zNCpAI70x/oHdciUm5ckV3imWWbwL3eVW38I3Ij9TBSRy5Kqm1QH/ZLuAx/iT7lbVUsqK+GBpSpoYYP3Ml/qR6FfA2XXH8q0rR2iVM5yN+BPDoPJGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(11063799006)(261022105027099003)(261028144727099003)(261026140227099003)(261021123027099003)(261102123227099003)(261009223027099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o/P8w5aVjGnWivTIYXB84H/O2Ct9dhqQlyn80KgK+Jj6xBv3SBBzhyNxMJjYTTbbhgCI5a7NhVJt/CeOvuvXtIR60/It3nkUxahYADEzKaaFFdvSLtqwf1Oz1Rfcc4Q9HuvgWl1OCFb6uJxQqt3UvXWqL6BzjwEGHw6cMs1QlhKVwUVvPsYY+6ZYKuZyoKpva8yNzmA7W+qb4BU7JapKgVfQjQYf3VG3kNDbG5Lv//p6xz9CKYt1hP8V4gnzBPxos9zZzlwW0E/dKLXuAD3eL+y3JfInnoHGSu+YVPs09Zot4dKwGGBFl7Po6DkVbGps3JCO4Kr4ie8LuZVCAY7IfEWKrnIozamhJm64U7xG+LtaaPtABMTyDkhKXdUzOdxkDCofn3NHVrH2n7kgyCijkAYm+Jgi+AQjnespFvNlmdkkiFMaHqJW6NduEhla5pfK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:15:49.1336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a20bb4e9-7867-4663-507a-08df3ac12e6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB360382
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds AIE4 debug buffer support, which the xrt-smi validate
gemm test uses to read the per-core results, and the AIE4 CERT firmware
version query.

- Add NPU10 and NPU11 devices.
- Bump the driver version to 1.0.
- Add AIE4 debug buffer support.
- Add AIE4 CERT firmware version query.

This series applies on top of drm-misc-next.

David Zhang (4):
  accel/amdxdna: Add NPU10 and NPU11 devices
  accel/amdxdna: Bump driver version to 1.0
  accel/amdxdna: Add AIE4 debug buffer support
  accel/amdxdna: Add AIE4 CERT firmware version query

 drivers/accel/amdxdna/aie4_ctx.c        | 284 +++++++++++++++++++++++-
 drivers/accel/amdxdna/aie4_message.c    |  20 ++
 drivers/accel/amdxdna/aie4_msg_priv.h   |  35 +++
 drivers/accel/amdxdna/aie4_pci.c        |   7 +
 drivers/accel/amdxdna/aie4_pci.h        |  10 +
 drivers/accel/amdxdna/amdxdna_ctx.c     |   4 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.c |  19 +-
 drivers/accel/amdxdna/amdxdna_pci_drv.h |   6 +
 drivers/accel/amdxdna/npu3_regs.c       |  78 +++++++
 include/uapi/drm/amdxdna_accel.h        |  51 +++++
 10 files changed, 510 insertions(+), 4 deletions(-)

-- 
2.34.1

