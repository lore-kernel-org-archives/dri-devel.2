Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9967606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 22:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iM1/7N3P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 157A710FF7B;
	Wed,  4 Nov 2026 22:43:24 +0000 (UTC)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011050.outbound.protection.outlook.com
 [40.93.194.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C121E10FF8B
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 22:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYJVi9tQ29ZanVZyGqM9nPUUP7hcoWKWeZnCg2PS7Fd2pchanep3zX9ztFiNdBMs2nDFA1N/u2OnMM5zELrECMe26Wf7dM3av7HP18+wY4a2P6iHGtQVdfHtdvV0Qt+ZIlb9BTZLfatBDgLg5OPvvGiMpO3afVvmETZ5SbM2mJMiqAML8n50lVR0CqBlodgNIb7NXQ0E+7dIiAYzZaj4g30YkFCzAsQO0gE9U5yiVwg6ZwuGvrZ2q8p4rwWcpEFHm0KS3sLoJ0ZeCwi/SmTvlMCSxd4ka36Xhh9KaIP4fbLkPo5+76QeHqOsYtKsvYz2u2HjPEa3Qr1An8MYCnRftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbqQ+oymtmZz7tqb+FIkFoURWWMnnMkUk5WC/RMHiz4=;
 b=e5NfGkQkrkYNOLIvYmPNWIcdzDXy6mNaKlTNNcxPj5etWIRup0t/hcvvXpexgcqcKdSr7646un5AWRQK56Yo/bazZI3bbNOGbmQbsRTHLlAnOi/pzK61io+WXbFYw8pThhL7FfXfM8MOU32ArEgY9xuP8+/dR+aZ/KL1SqBywEUKRPH308wznlTKXRpDTHxy2svlThnzttAY0T9YvncOOukMCEh+5H3Jv6/Flf2x2yaoxJJWTLKBKnQuFfCUZeoGzE7SD58rUEENUMdHi+qr7WL2fuuf5Dk2GBrnxynmeb/heCD/DEuEJdz1pUHa0dsy643k1jIgkx1/ArHSW0bTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=quicinc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbqQ+oymtmZz7tqb+FIkFoURWWMnnMkUk5WC/RMHiz4=;
 b=iM1/7N3PNIlWy/XAFJOcU4amP+mNsnd+BSb7f80pA9aQtR0wwKYLFT6xqjoMoLPL750NPfKS+oQ1iOcHoPDRMpU5CmYYbrci9ivHWOLCWbTXoMl29iQojA36MwI1n1Z6Ob3LnnfP1W0zvTLF2MPYD6xYDfYO7CbufxYsWWKvNsA=
Received: from BY3PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:39b::18)
 by MN0PR12MB6055.namprd12.prod.outlook.com (2603:10b6:208:3cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 22:43:10 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::23) by BY3PR05CA0043.outlook.office365.com
 (2603:10b6:a03:39b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Wed, 4
 Nov 2026 22:43:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 22:43:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:43:08 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 16:43:08 -0600
Received: from xsjdavidzha51.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Wed, 4 Nov 2026 16:43:07 -0600
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
Subject: [PATCH RESEND V1 0/4] accel/amdxdna: Add AIE4 debug buffer support
Date: Wed, 4 Nov 2026 14:42:58 -0800
Message-ID: <20261104224302.643329-1-yidong.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|MN0PR12MB6055:EE_
X-MS-Office365-Filtering-Correlation-Id: c199eb79-9a18-45b9-e6b0-08df3ac50025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|7416014|23010399003|1800799024|10067099003|18002099003|56012099006|11063799006|261028144727099003|261026140227099003|261102123227099003|261009223027099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: SPTWUxafXbf1TXW/Pvn/17HJWIFaJoW3yIyWWPLunH01blXQpbkTtdCNqkAk3UZAtFTlv30OCFI2EO1+EFwuJEv6mK4TgyQRbyHMxhZsFq6VDqLD6PxXigdn6UiCqlzr/KV1MTAZ+mF/gxYgAl2+wjdMW4UO+LMw58uXdOvuop/TlzxIzrPQbQivgbcQL87RmeAWBp9QqaFLiSn6kHaSTiqwDQFhMzeLE2pKleE8JCED/gBbpbkYUUmfyOBDbTitOGFhsYz0nEefj+gIk2Vdv3aBMQAQoe7zVe+Zs3IIJEURMNh+yqZ6cXEC65F1VMm/D2omalGvxXj0/2S+5t7fBQvAKQzhPvVoZW61SAVamJfpacyR1fS1Smq462o9ASvajoqGVYiuzHgitRuXe3S1Ih/bL46TcP3x5vhZEVrNKSpRbC0zNh7xwBb6UYBx8DM2lZs43PpsfW6ldhvSsLhpjbFTQxYzn8OyWLAf7ctKK+MUr/jbbenmsvwZnGKC2iMXnB3D7ByfTzYQ//4/ZtBr5H9avwgIpPacM4LzN6rDcTP8Ol4pO0Fgch4+IKcOpNGmTLoHLy10ZoDVu6gBEeX/jV5p3P5Tv34jmBekzmHzkhBdCDzQ7hrIhHWzodTe+9lKo8KMZuyue4Iy2ME0wDjqQ5DQk4kNTAjn5zaQ6bsYlVYwneywF89qFd/THN7w9atYntwaLVLFAWFVysuPgQc/MA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(23010399003)(1800799024)(10067099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261102123227099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0vYcISkVzptt1k4idUrT93QQka4xNyJtbjUCegtW5WwBbiTnx6vfUbeU59+kd2ps3KiyLREAxeLJgYhVqAtJAfxVWBRVAKPj/SZ1+maM8V3+SvQqthN79ETYbyljD98N6RfvwhWY/RHIjcGu/qXbsxRcWobsiF4nl4FMjf5SEHFX/+pvmmz83EBcYWxJR6/TzV0RKseuqbtWVdrEUlhlR5sd6Jti1BCq/uRR3NmksqTm+ku/HWn4U6qbj3A83jeUu5aDcmOlm2ELHnO374Z0llMW2sxyfCHof/BM+YnllNcXVZ8a20TNxQ3aKyevbwH0b9PEaQ6Y00eT+4bF+7+yeiERWsNiI7LmsgmgwzAWxqZt/igN3DUNqRHcGxjr1rCpVqObLSTdSeHsUsCkjKNqA8QjYEnnlHRIAHx/zxPCmoz0brfsxJflIpK7xtMNqVQ2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 22:43:09.4702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c199eb79-9a18-45b9-e6b0-08df3ac50025
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6055
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


base-commit: e32e83a6c5ec031a7f59d4794113d8484b220254
-- 
2.34.1

