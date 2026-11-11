Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E12606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 22:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s5vzHOy9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D8510EA82;
	Wed, 11 Nov 2026 22:35:34 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C45D10EA82
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 22:35:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzEZ/CFVPFySlPW1CfmOMd5I+aTtrwvCv3Iibt01I4AlBO1s5k0FC7S4w+J9Rc0dqNA0x4vCU8p3cM0gtX2v98tk+i0X+LM+WT6Ooyinh3XNnhL73Dt6BbNZobj/oVmkmgkG2BGUhvd/wIW0L6WcKScl2hwaORcfuqt2MulbDjQXxnBRrdlSj7+eiX8xl8lGbXFt2pp15HtCMuOaHF+1a5jsS7aNtocXtjw/oCfDm8BwmFg7SftBzhCpL5osQyBXHorOdqDF2ohhTpAsPhuX7+/eoTSOpdg0HWFyCmJVso3VOdUwLDYtLoWA3piPSep9XLhWPsQYFxCC0TXKHLdhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGENeai6u11/gboZg19LzfF3SJ4oGbA9x8+44XNXzeg=;
 b=AYkhRayIed+wJE2KZp9XRMIwPQTWbzbtOh8JqV2HxLZExLNISe9Pn10me7S4yQDgIhKfIwq8sWDfQZeRrQyrKMVfNtrwzV9AP0VmfyYW9rclgseJBp/9oefRH0e/K2EhyYwwUfco53s8unXYgVoE0xsDajHwgX2Z1QrQW6s7zPXpuRr1Cn/jfSDQvZ25OKGplOZB0auP9kzMnqvE3WdkjC9BavM7PLPcAXaJRGzCQBz+4FrQqU0p8h9JYzDKQdf3xDr7uGabeyGw6lx3+vM8cY7O1EIKiMeIUMUNadKAwA6+HTLmt8VQDZYdBOqwU10azrKFusVbxk6xdjDjWUwNvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGENeai6u11/gboZg19LzfF3SJ4oGbA9x8+44XNXzeg=;
 b=s5vzHOy9oaiaedJb4t2BvnRvTlw7IyBES9S23jtGFADhXW9WCvcFcgx7vJwBGSbEwAZFNUVyqxxBLFeFENfxidwwgm5CX2T8+VinlrFnsylzQeSnwfabZBmUwnykWf5pErbAetY0KwmaRhSF6MKGDiZ5mzWP1wnsPMvQKegHJSe3F8ESW4bEiPw8btz5fmc4qvYMA10RE5SS3YTgJ0Ew9SPk+SD4HLV4QMCoPC35gFarvw3n0FtXR/UR+WyE5MXKUbxKyhnbQdKr2eUQ2cJEwiLbg4L5wg16KyO3yctYQfQLCGNAkvs5JoBtOEYHeuhSkLdSrBbvosasy8hvQgz90Q==
Received: from SJ0PR13CA0109.namprd13.prod.outlook.com (2603:10b6:a03:2c5::24)
 by EAYPR12MB756173.namprd12.prod.outlook.com (2603:10b6:303:2f9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 22:34:28 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::55) by SJ0PR13CA0109.outlook.office365.com
 (2603:10b6:a03:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 22:34:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 22:34:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 14:34:10 -0800
Received: from xinmengs-dev-vm-linux.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 14:34:07 -0800
From: Simon Song <xinmengs@nvidia.com>
To: <dakr@kernel.org>, <acourbot@nvidia.com>, <kvm@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <linux-pci@vger.kernel.org>
CC: <alex@shazbot.org>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
 <skolothumtho@nvidia.com>, <kevin.tian@intel.com>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <markus.probst@posteo.de>, <jhubbard@nvidia.com>,
 <apopple@nvidia.com>, <joelagnelf@nvidia.com>, <ecourtney@nvidia.com>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <zhiwang@kernel.org>, <zhiw@nvidia.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <jgg@ziepe.ca>, <bhelgaas@google.com>,
 <kwilczynski@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <peter@colberg.org>, <xinmengs@nvidia.com>
Subject: [PATCH v6 05/11] rust: device: clarify the drvdata_borrow() safety
 requirement
Date: Wed, 11 Nov 2026 14:33:30 -0800
Message-ID: <20261111223337.508989-6-xinmengs@nvidia.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261111223337.508989-1-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|EAYPR12MB756173:EE_
X-MS-Office365-Filtering-Correlation-Id: df8e2a2f-1456-4036-4fcd-08df4043f242
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261022105027099003|261026140227099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: ulSulnICqhNNUFhcNq9wCcSiqonBeGAfXlAU1AYnbBDCgxuikAx6BVOt4eSm3Tf351PZDAp3R3/O+B+6lr4NivqFgam6l/bmy9cAEXL8P/pJ9pbPYOROx6YqGEplgt7iGajRy0jmzjD7CoayvU3ZropHGOPb+qUHk0tLPYjZPeypsn2eSkDPLzbqXUUKuCfy3jlnDBjEE/KD5ZQ3e0brxHzBOPYXKpk0qYyxE4ZrYXVa+HmTvCKdjY2gNjNWDrrjboe8TKlQ1Gfr6qLlFTPQJifh5rmCdNmQHTjR6/NuSDAdTjdfmJVi1Cb62AB0G6r/hOYSUqrjkExtruPICKZbIcvUDiuDP9xVxaujDs2vWeUdR1rf+XuaENPqLl0cWJYoeFVnc2HnWQnTmR315cflhJrmR8t8/dvCtaHssZQ3ry2Ec5ohRYaCgIe6W/KLHrUYzVqluuRsAJyrFqZTxAQJMlxw7zY2lFwgRKeubUdZsruqnJm2T/Ae4MR/U6Rn1pwYBaShVdGARuej3HOYfnsBJCXrBtz83YakhPxQytWpRTGeLZftIbUyS5ON3hf7y21lZUcPdI9B6ECIOg51efB8edcevvuKGVWJ6YxpEWk/GBViKM9cgrrxeZ80TKMTK6TtmZkvPZ9mx1DmeajOOPLc4YrQ7pZdSh+TbHKhRd9g9vDTS7gFBsPyTJOksd4fotlsYU4prjx2iKQOptVLBE1NvQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Cbnc3qkwt9z0/0Z1NM2m0pju6QJ55dKiO9Adh9tkmnsumAN00QrdWf6o7Y5aD401Ra9UnaWWOJwtCNgN3/T/X+x0TqF93tRZ4mqKaFlATysbsyAH99IHQPvvrjEdrwP48Ub5ALM2vBpS4p1VQIjqb3X6I9oO2Pyau8Jm0glOuqi1l2PGToR2esTk2Pt2dnmnb1W+D3Qnc0NRPUEJf3X2MU3th5NOeyPqahh8k4+9MwuPwP4eNEiNyCiYcC8yYPmKTzOw9KqOMx7wGqDNWj1SPogOTKY57rJpl0tTdSXeKev8HDaGAgDocxzE6bXox1/6TO/DcD4jD0DqZIjp4RXGep4zTGdfZNUn7e17AAvg0IlX6YWQ4n/9YtWZhfU5uJZzGWJiah2fuHSp1gjx9C4yMPMNjslA+EM5G/jP3OLPbtbqpJEsyGFwUtEERTDCAcgm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:34:28.1026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df8e2a2f-1456-4036-4fcd-08df4043f242
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB756173
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Zhi Wang <zhiw@nvidia.com>

The safety requirement of drvdata_borrow() says it must only be called
after Device::set_drvdata() and before the device is fully unbound.
This describes when the stored data is expected to be present, rather
than the requirement itself.

State the requirement directly: the data stored by
Device::set_drvdata() must still be installed and remain valid for the
returned borrow.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
Signed-off-by: Simon Song <xinmengs@nvidia.com>
---
 rust/kernel/device.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 2291d85b6849..1f6bb58396e2 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -243,8 +243,8 @@ impl<Ctx: InternalBoundContext> Device<Ctx> {
     ///
     /// # Safety
     ///
-    /// - Must only be called after a preceding call to [`Device::set_drvdata`] and before the
-    ///   device is fully unbound.
+    /// - The data stored by [`Device::set_drvdata`] must still be installed and remain valid
+    ///   for the returned borrow.
     /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
     ///   [`Device::set_drvdata`].
     pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
-- 
2.43.7

