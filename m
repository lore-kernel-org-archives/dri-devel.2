Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07BBC44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9360610E7A1;
	Mon, 13 Jul 2026 07:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=vivo.com header.i=@vivo.com header.b="krhCOQTU";
	dkim-atps=neutral
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11013038.outbound.protection.outlook.com
 [40.107.44.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65E8410E186
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 10:59:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuOQhQr6Hb2OZJyWX3saJ4M50/36OgleC96OMEtvKa3jOhu/EUNFRLDAZluPPuJvppeWuJg+QNy7NLUmI96t2AaFX2M2CN7t990SH3/DvhiBL6pw/8Kq8B0djt9hcv28yvxKnPJHyg/q+yNg31dBFcQVUdJVEaFEJP09DHfEgJvb7ZG5u0jaj3S+LiSwcsBQQ3BaYLy70WQr19ctY6LXYgT0tSPfhQ2TAhKOKsnZnjxMj8M3oq+Zh29OEQjWS8RjUhnIkONnjtsG9Slr3Zu4oaAJEzcVZ+iIhkgi94I9PhGxCZYbutyA9bvL0nOdmgbgNvSVUkbK0bhS3xo4KV9xAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8aH6aLiVrtxBEhNTxxLxNCygc7TOj29VFxzbpE1mRaw=;
 b=YlTDAX4qUEQN8xxNlpBXqjxWXvMMToHkSALL5Nm4uuQ6EIAlEuVTMHUoPjFCXPDpmpixOE7dwItZso7pwYYluNvGFG/3kwJHi1R4KAul8jL1SxT2tHnmCrqqwOU7ze3pc7zgHbMFeTqtmvGOe0hlK4r31rUGR16IMqD+tzRc3szfRaMRxpDIvo7n2HCKajkjs8Aj4B/RM+UGAo5ozfwD4dz5LcRT/5OqsqyADvUBKVWuEZ9YFVsoCm7NeIiZalwh0/NiQC5CF3KZQnHnqNQDkC4wyXC9q/9N4VSBBxel0+4UhgHUAMMwcyQ/FoBweUYajIRpgMQO5/zT71LXOtPZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8aH6aLiVrtxBEhNTxxLxNCygc7TOj29VFxzbpE1mRaw=;
 b=krhCOQTUw1R/Efq8vzFljRWIJdiDBjMELDTkW+iOVdbBQdDS7st3RtfzEgEgzCfYJw4v7UTuFhQHzFCsrHh7FQAovrYhCstJIcCntxd+eXiBgOnrDhH7jF/u7dKdqFeJ/86Sxhs0EulZ+ThI9DB/gGSBuORznT3vTRhwtXXyGHIHGOLFTty+royhT0Ti0LquO2A4TMHOpb2S0BmXHZ4YqKDREZnt0elOuHpG6CZcPUjLQ+z5HldLwPgD2twdpAIad5BvauTXHRyVa8fKl8K4XJaUjeUip3+U+4/FFBFBp/qyieei6EF+4Wsr8WG/j2TrTV2aCxpOnGYcDjTxXnYrOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by KU4PR06MB8388.apcprd06.prod.outlook.com (2603:1096:d10:7b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 10:59:50 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 10:59:50 +0000
From: Pan Chuang <panchuang@vivo.com>
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 dri-devel@lists.freedesktop.org (open list:ARM ETHOS-U NPU DRIVER),
 linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 0/2] accel: Remove redundant error messages on IRQ request
 failure
Date: Fri, 10 Jul 2026 18:59:34 +0800
Message-Id: <20260710105937.409992-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0030.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::16) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|KU4PR06MB8388:EE_
X-MS-Office365-Filtering-Correlation-Id: b098f38f-195c-4f65-556e-08dede725c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|52116014|1800799024|366016|38350700014|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: APCYQAFvSqhKkK4a9YPCr1SPQgbmszYrE3xPioVx53lNZw9jeh1N3h0jdrgiv7ge4GiJrcHDBjTcB5GjgGXAiBECmQWYv9VxdR/mwAEqoBJ/ob2K4ptd3WJKeAPYw72tcUH70B7ti8wcmlC5z9yy7frqbB+zv2Wy1RKWk+82O0NNpEja7HkxlvFt5PXsooMPCwssnN+nO3Nb+QineW9a7xJyLgIs53e6XyJKUSYtE3EGHbBp6FgptBICU6y34k9TI7S61NL5NFI62mc+2bJTyWXXn6jnCciW8VLGoJ2qr3CDcBYN6EQLMflhXNnbpXc788mb3gkstRnwf8QzfMZvMwlrk5Gv8ZysbPEP4DoMj4rGkQ91UfkJOLgFUrzaJ/WNXMFPZiiquY/zFrRnVi17JGjmabh7ofGR2psRynIoQfw4MD2nP7Zh0cMTdFBHGRq9F0VHHLs58cD9NDqz8AJusDWfxv2BbmuGlZPHnOmAIPQd29WEZ3KrzUtP+VtjgIxQPoC0GFo+dEySj9Yz8gvcdLP0U5/zdCK0FGi/njXV3wXADOrq4W/RhYsvERswBH6bAdiogdWxRfDammI3ghNr4NtWvm1pPsxPuTeiVi5nHx7AZTrvSJ2GlG+mzkbXOCeKsxIzbR2/IE+EktMwK5AWu2uZmXEhn80ss3AIdwrxWNZbCbV55RwV5PcdFYBinbYTsIWHgIx1EWZHpTF7H2I3SB/l7IUTodFLg0rN/UVsDx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR06MB5832.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(52116014)(1800799024)(366016)(38350700014)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NEAHi5Pys3W2SnCu8a44Xk+7x13F2Rf+EzbOC5GPqwSzQ9HX9QBFO2dXIsfC?=
 =?us-ascii?Q?v20aA8fSVdyY23vbBub08hk4SGzh6+3gbwslHWgOVJesIvJyCZ9W1w7QH7RV?=
 =?us-ascii?Q?SA4s/9M4jZbaAMbGrGPiNeW4wJ9m2Pm5ILyFs0guB/uCoN86bwQWtB08nnR1?=
 =?us-ascii?Q?9etAKpgYBnEU7xQtuTwY+koBayC8VQCY9RjVmW0taLUhBwoAajjheEBu+Okq?=
 =?us-ascii?Q?3de1YcLUJ+hutHLzMLYKzSS+Dpx9kqzNs2uzbzCLR/GzMy50SuRM4ZoFDnJC?=
 =?us-ascii?Q?+lkStrO3drR9yedRnpGzZkMWQZI761n/8YdHcALyBW/PdIaf+OBiNMSj7sEu?=
 =?us-ascii?Q?w48RSEzRFIJbhwzSrHIHwHhg3wQW/AuyT5MCJjjg/YTD6NTQrdzpdZ8HNl4w?=
 =?us-ascii?Q?hUlMeSrOcYEaLGXT0daRHnxZI+gxecciVcvpFhQmVMhH1EyGa6sOm0TB8jRy?=
 =?us-ascii?Q?4cmLvnBWCkJ0klQVjhcDDknn+9cahcJBBqvAcYi0U/p2SXjvMZGBbgFlpHK/?=
 =?us-ascii?Q?4DJBKUHOkPPoRzfYu6ZE5OoqBMUS9cxnf4clbb0OL8HDOVeh01ObSYR5dxzr?=
 =?us-ascii?Q?4rGD42U09A+hCrQZf+ZANDPxu5JCzvmFykeYz5P3orx7Ixbxfb86JizHxp9q?=
 =?us-ascii?Q?/81du1DbLezbhQbv6S6fv7/Q2/sxgMWtsJHZjpQjGbWiVGNd8PgJAtwTix5H?=
 =?us-ascii?Q?k8GI1RU71aDdTlSWpuZV8GwJVXqAW1yvO3/zLcgXQqFMD0aZQjxtU4li1Z8n?=
 =?us-ascii?Q?aKoPR3icQtoiZu0XOmFOoyBdlk0wYy2uhd8WuoEd2Yy2qvaa1RGD8ojP5Yxw?=
 =?us-ascii?Q?EwJtnxlF2eK8oQ5vtHFTQTuLfcdF5JszIBO0fWO1xb6p+Fgz1SO+GnxnDhx2?=
 =?us-ascii?Q?G0bZb820twr4hAGJa8Bx3CY8nEPBIxjavNB/49SqMKmkIZelNGzSUEBoyduT?=
 =?us-ascii?Q?LzQ85m0aYuY6u3yOOQ+3wWunApsrI1nRh2xIj7ZHfvU3feldy+kKXDnhFHIK?=
 =?us-ascii?Q?Z6M94NU9Tq68epdhmZ1YNUmlnGNjV6DRTHzwtbF55ebi6fTuyMRCQLudvvuB?=
 =?us-ascii?Q?n7E3FmwLGBKB6HMCIDlMigx0XClcAGRaejaJq8B15F4OMcLBLzJkipkFif4a?=
 =?us-ascii?Q?WiMcAx0Jd6L+T0PtApJswz8hIZ26Ai16XjOXXjXdnFs5akojhncUFCK9cZ4M?=
 =?us-ascii?Q?bufW9KMZJNwEHlLqzkqzS6Vvd/RRw7rjXLKOnLdNxrkdjIypckmCO1Pa2cuj?=
 =?us-ascii?Q?W/HTOXzGrQhk9WttbyNcxI1K0OaF/Qcu4v0auUb7XfElULeS87G5ak0pYYSW?=
 =?us-ascii?Q?z5L3rxnITAaOLLhnwlRvc01+2ok5Vn6jEgwfyavYPNNyhRQ29PXhxDr84QSh?=
 =?us-ascii?Q?QSgYSTsYJPb7Uv0w4ZsUi6ST1BvDTCnnwGrDk7xg7kuxZfO9sdYs19hLu3rU?=
 =?us-ascii?Q?ttgQTdmU30TjHMkF5inBRvy0JRBNKLmMTodb84X4cKKGMAjY+s9DGtSOeUY3?=
 =?us-ascii?Q?9Z72YzWvd36EArBg58hTEYt7jFLkmkphKPbNdQw7WXt0ODKOg8HN5YgxG4Q5?=
 =?us-ascii?Q?WMucBgPcCli6g/ElGllnhZIJyaxtpUM3HQl7W6CMcKHW93UwVTw2niDKVdbT?=
 =?us-ascii?Q?+32R1zQcMuFDhnSRU+USb7kyB5h4SyzxeXTkuFJNtdYSZnbkheRL99gvcpT/?=
 =?us-ascii?Q?ZUJaqAE7nxiKBvslHnRiQk+RxKR8Ufe/ZfyTt5bQkKLcm2YlToZx3DWQemLv?=
 =?us-ascii?Q?4qEFIzb2yw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b098f38f-195c-4f65-556e-08dede725c7d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 10:59:49.5461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACMyxvu6s0GhDH+AjdkSetCuNztD6ZOcwa7vGyMTk/+BO7fdw6tNqsY9tJ0dAYy1NFh5lSpWuXBUHDIz1FiZDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR06MB8388
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

Commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()") added automatic error logging to
devm_request_threaded_irq() and devm_request_any_context_irq()
via the new devm_request_result() helper, which prints device
name, IRQ number, handler functions, and error code on failure.

Since devm_request_irq() is a static inline wrapper around
devm_request_threaded_irq(), it also benefits from this
automatic logging.

Remove the now-redundant dev_err() and dev_err_probe() calls
in accel drivers that follow these devm_request_*_irq()
functions, as the core now provides more detailed diagnostic
information on failure.

Pan Chuang (2):
  accel: ethosu: Remove redundant dev_err()
  accel: rocket: Remove redundant dev_err()

 drivers/accel/ethosu/ethosu_job.c | 4 +---
 drivers/accel/rocket/rocket_job.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.34.1

