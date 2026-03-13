Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D616107BCCD
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:54:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A932810ECE0;
	Fri, 13 Mar 2026 16:54:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rcVpZ2/C";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2476810ECE9;
 Fri, 13 Mar 2026 16:54:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4TrvWROdXtwkbyYrOS1vJsRJ/CQoKNdY2UKp2MCQRGSuXeG5rO1bNp571K9y+jzv1h1QzaU/NKoM7iKwuEmSDV8YfCzYYqUHY/5eGNrjCqUzUVSUTDdo0g9gj9XAw+v5xaq/BH7hYUiKurflXvhJTWGR9fDYmstvEbc6XUOxn1QYn5XeOEn7zlJIa083ze27TU+u2d+EeQzCSzH+8lqtkFKMVUchrwB6DcyO27y55/M0FhYzzWrRGSLpp+Dl3clcZAYVnNIH7lBxukIV/h/ABxt8f1hRDhFwowWal5SJ/t2wGUArb3mAQwUZnQQFeqx/xc6i7XJwB+zwWo3g/gU5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEtl3NKfX9SDPOIFZ/eEbTlZdeii3QoGmV012Q1QnQs=;
 b=V3mh6u7H1THCdKDprNH9PelBaAE+8652D/qtQfhqPZcotGgkwkgj29qaKYMjC4HYi0szpprLhq6lCHYbyCTQGJYctAzj9Pc5/90zxk8/A1qwsY/79xxWW4QooCQjvJ8XuASdPXxGGIvM3FG6R08LUQmcEUc8ONvRssrhaVGtgM2SWbC2x5gxAnNH0Ei63Nde9Qapp/dI480sokgvmN53y0xkjTq0aJ1eISlOwsAA+DxdUj0l7M9Hz+PaNCRMFQM0HczxM9qq/DYk6fq/6AAIB8EITdFZfSoDByFYXkVd8vBiT24P+55Si2ekcHb1UIQwCr8ik4iuezNUplBVmv9F9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEtl3NKfX9SDPOIFZ/eEbTlZdeii3QoGmV012Q1QnQs=;
 b=rcVpZ2/CINsiS3R2IvsB17guMUCLGZ98M2GLEJ6JjDeEeE6jTBw7zBzJlad/QZPFDvsqzsVrCemx3ke8IWqO+KL+dYkctyQYcNJqWzVcsWJrKl6KyFp4QA4eXU/4kQgCK8OUFe/eAW0NBrgnbqqEkNMf9kYv+A1CXLIjpN9zleYLoLStRNkjsNkz9m11qSOqoLChK6nVLN0W06DYNAPkflWGoX8gd51qiewJjCQXMBgmR93bgTulgifQKjMqaHmAKbx9YlE9jjpAWyfLn1BDBPexUAZ+lIVJOJxadnvKXJQoVb8SqJ7BxlDxUk9JbBgO0lE7JDB76gIx///A8G9AfQ==
Received: from DS7PR03CA0148.namprd03.prod.outlook.com (2603:10b6:5:3b4::33)
 by MW6PR12MB8835.namprd12.prod.outlook.com (2603:10b6:303:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 16:54:36 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:5:3b4:cafe::6e) by DS7PR03CA0148.outlook.office365.com
 (2603:10b6:5:3b4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Fri,
 13 Mar 2026 16:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Fri, 13 Mar 2026 16:54:36 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:54:17 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 09:54:16 -0700
Received: from inno-dell.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 09:54:07 -0700
From: Zhi Wang <zhiw@nvidia.com>
To: <dakr@kernel.org>, <aliceryhl@google.com>, <acourbot@nvidia.com>,
 <airlied@gmail.com>, <simona@ffwll.ch>, <lossin@kernel.org>,
 <gary@garyguo.net>
CC: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <cjia@nvidia.com>, <smitra@nvidia.com>, <kjaju@nvidia.com>,
 <alkumar@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
 <kwankhede@nvidia.com>, <targupta@nvidia.com>, <jhubbard@nvidia.com>,
 <gjuvekar@nvidia.com>, <joelagnelf@nvidia.com>, <zhiwang@kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
Subject: [RFC v2 03/10] gpu: nova-core: return FSP response buffer to caller
Date: Fri, 13 Mar 2026 18:53:27 +0200
Message-ID: <20260313165336.935771-4-zhiw@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313165336.935771-1-zhiw@nvidia.com>
References: <20260313165336.935771-1-zhiw@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|MW6PR12MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2e05d8-c844-4744-5e2d-08de81213578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|36860700016|1800799024|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: V3kBtShJ4FfLYjWcoWy6gMV5THfF1LxDzk+A7iLP+5jN23hCTmLvrwOjJQoaeipuugUZKGkFCK5qlfkjSgftdQDM+oXnAvEjvDX8QHE1Q0nKlbWjz7Ej/njkWJXmAIcACTWe79IzGG9plgP2m4y9i87SK4DXMMHqMZxcLFxmrc0Xmdfq/m7rG6HxBTDCMD4UeCFMjEM1WqwfjR+J3GeYjW1XYdi09c/0evou8gIbkzzQpnYj0ebWmfCu5dYvGMMoLMCejDaAdmJNbj3O/vw4ICWcd/YFqeJ/k+q7o0ZsMNKR9SHd+0CVRv8vBTWFs5j9T8RT08w31PNz86ud8Hta8x+0KTvayQ921JAxql1CVcrhaNDq/+YAmn/Hu3A+1n8Tdih7VqqzJkeHVBQ3ng5Mzl9ZlJDIk0NoTisLd26gqSGKB4UAidF28XsduMgIk/UfziF1TGB36nx+Li53WI7rGSkXObSyW5qMnvsIukqHDv/RnTXKHepc9khotKaM+4HANbXCcPnFmPZAx7nLnTUOVfVoS72hT2XYhz3Otc65gN1qN4AC/yZrXLsKD1IhGhy/RUwZvItAUKOV9Ze4tXQ2/c7R7TQDzQ6fqYt/3I99gXcyC1ZdjY+xDYcTFF9fp7OJ37F4ynsH9XD/XCbzeOOUjDN5cP5P2o27hNl5CWDnyX3VaSLSojk9TEaazBRL2xTrgUnk4zcm2lSQPJPooi/gWNo6SuEe2J3nkuRWG98rdemtMsYqUWlj8HvkkCXa8X54uWKRrvd7V5KhrNpctjcoQg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6ZHnFAi1AECb9quPlKEMl4ah4gt3pvd6lr01Ca2g4sxpdD5ad8EvyNBYmGRNe1xn29ujuI3x575xVvtKnDeqDsa5J9yeGs7A8oolcSLhIafCRko+Gfr99mD9hIb1IMsIMY1TngkTsK+acdnj3rliubaNzUX+CA8CeuzDCXel4oLFQs2EGIsJE8KmmFXeIqtlTMqhfYJduthGp7kE+tfmRw7QGbsjyEOdCwwRGx0Kl6zMfBB4H5SuVlgLZxP3o+XmVLxy/3+fi13dnyoxAdhtU5XYUmWuOvNuPCWLP7LCuyNa6Jj5aBknQD1ZntDAIqaLYMMI55sHzy2/q327qXTsfuUX/sRE8ePJxzFbt68IVAmCdDTvKq/Jx9Ljlq46S5SI+EEtsPIiPPivVBExv8v7rh1vtay7e9tEfAECMNSutAi/VOUZOx+2U83wVnbh/pV8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 16:54:36.2548 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2e05d8-c844-4744-5e2d-08de81213578
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8835
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

Change send_sync_fsp() to return the raw response buffer after
validating the common MCTP/NVDM headers and error code. This allows
callers to perform protocol-specific parsing on the response payload,
which is needed for the upcoming PRC protocol support.

For the existing COT caller, the response buffer is unused.

Signed-off-by: Zhi Wang <zhiw@nvidia.com>
---
 drivers/gpu/nova-core/fsp.rs | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 477ed719b757..69e48b655879 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -454,12 +454,13 @@ pub(crate) fn boot_fmc(
     }
 
     /// Send message to FSP and wait for response.
+    /// Returns the raw response buffer for protocol-specific parsing.
     fn send_sync_fsp<M>(
         dev: &device::Device<device::Bound>,
         bar: &crate::driver::Bar0,
         fsp_falcon: &crate::falcon::Falcon<crate::falcon::fsp::Fsp>,
         msg: &M,
-    ) -> Result
+    ) -> Result<KVec<u8>>
     where
         M: MessageToFsp,
     {
@@ -482,12 +483,13 @@ fn send_sync_fsp<M>(
         response_buf.resize(packet_size, 0, GFP_KERNEL)?;
         fsp_falcon.recv_msg(bar, &mut response_buf, packet_size)?;
 
-        if response_buf.len() < core::mem::size_of::<FspResponse>() {
+        let min_size = core::mem::size_of::<FspResponse>();
+        if response_buf.len() < min_size {
             dev_err!(dev, "FSP response too small: {}\n", response_buf.len());
             return Err(EIO);
         }
 
-        let response = FspResponse::from_bytes(&response_buf[..]).ok_or(EIO)?;
+        let response = FspResponse::from_bytes(&response_buf[..min_size]).ok_or(EIO)?;
 
         let mctp_header: MctpHeader = response.header.mctp_header.into();
         let nvdm_header: NvdmHeader = response.header.nvdm_header.into();
@@ -532,6 +534,6 @@ fn send_sync_fsp<M>(
             return Err(EIO);
         }
 
-        Ok(())
+        Ok(response_buf)
     }
 }
-- 
2.51.0

