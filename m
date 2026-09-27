Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11435C98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 11:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5507210E54A;
	Sun, 27 Sep 2026 11:15:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="HKnf6zNw";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD4810E567
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 11:14:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqoHNkr1WJcAgFfl0tYExuBfUV9Qr4Iz2w+WCwyh0AGCxtxjsMkzj3nia8VJLIOED0v2Y2zKgcpiPiA8/BSK4PwK8oqR2ygWZza6MB9vzm8RroLbU7TnzBr6AfagTajAfW1XmM0Lx4vW0ncgTh6YVjbtv3Ri3NwpQ+ymRFa8cEkZIwxybpgD3G/uEVmbXlUvA7YutFWaHbs+C6XoknnBkF7Hyp2/ejXrr03cH3wEW1Hbx1JfYYft0i+xdEPKm/iuWna3wn2M9jvfc2P7KMqyQ9kutYRU8+iOKssLNAkSNcIb3MLnp+2EPyJV6wS44iyub0CzI+8WEbpCuZBCrXZb8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KcNKVJgSLyO+hZNGH886pJJ7L4xPKlHTER/xAT0h0X8=;
 b=UMlBz5GT/vrYhgd8ytcqEIc9ycbSY8sRB6eeI8IG8MZdi32M2Ef9UxVVclTX+kWAQ5ASOmAd9Ig79VYscEjJhd5XvP4kWLvkfSUrDnWLdj3/IFSxOyR4do7jz0XM2ezXUQcB12f8xPddJmym61D2eqRdClyqyEBSmv3/4XAtZIJeriCuo6dAO0iB6V1tMDSze7Mz8RLYHe5GzN+Z4oCZdWe6fb1FJLLyjFHpYub1q8cufziYsYAsimsFKjEH3rRU6QDlvqDkDK+2uctwT9yoVdhwgjbpo+OUKSMKMqiLxvy555GSZMWyi501n3ZISxXDt4gikwB3vHZREqzP0TJxmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KcNKVJgSLyO+hZNGH886pJJ7L4xPKlHTER/xAT0h0X8=;
 b=HKnf6zNw5GYTuXGxiWW30jOPjFuURronJDWglxA97jFY9p/8vTgGLzbxL0egvHfbhhlDVihSR0cInABg13sBI+w1/x4RQNQFiUKW4Xm/eIYF6ZqvXMHl541jTPGKD1I/gKdLINzYmtzWPM9H5XvRwfdjNx2VXb6rArvQI/ksqMrvc0cIcqLvhL/HLbkKEpWz2fTEYCxth1WdQ1oec+TfTYsZqjwWTEMzFYkSmJI1gKXTRBcCMPke95Hd9Wy2v5DNhndFHV2RLGXTLcL+Fq+3jlKqL9yVo/D6FaHOjIeCmOap1v/SUbNPyU/IbH7t4+vYwLSeOquIsCieTyxZuXdDYg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 27 Sep
 2026 11:14:49 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0451.022; Sun, 27 Sep 2026
 11:14:49 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 27 Sep 2026 20:14:29 +0900
Subject: [PATCH 07/10] gpu: nova-core: gsp: cmdq: split the transport part
 of the receive path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-cmdq-rpc-v1-7-822db5af910e@nvidia.com>
References: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
In-Reply-To: <20260927-cmdq-rpc-v1-0-822db5af910e@nvidia.com>
To: John Hubbard <jhubbard@nvidia.com>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>
Cc: Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: aace7e0f-cbe2-4d22-d43f-08df1c888b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: AX+iDtqBK3E+JwXSnx+93NOKtUacy3kiB1QlrdhA+YwgrDDRfujxGzNRESSbIA3jF/4IUhOAgHqMoioqclwIRcvfjgTexEcVgLv2NR8x5iknLu9/SQSxoXrQg/+wFGB2Y7XIdDTPHo6ir2h/plE3xU5k0jEuArn8vNg5trl2t9wfUBweETb8OrNtUhnSlWGdXGCgdgG8QLn0UztInHHi14LryKkHAd2cn6LDigX9tN/RUxy3ecotSwBjGAypYzZ0v5ks0f2Aiqb+8NIAaYk+eOXN/aAWpWA3fVeNC5cUwQbp5mvjO6BxS3FrLxbrdLprsu1rF+iiTRY9pO6sc3N+s1KsCeCuHYh/dvcktJA/9Z/aS2vduNd8GNKgbJ3f5u1GCexk1rw2lPRpyuIzrHjGPdvf7exnJmqJKeJJ/4rilzFJvZilCP1QIa31o36ACjnzNmLh9k1EqxB7bP1GPhjCps4qoHdEWps+bKaFcCqn3SqfbOI/aCwSSHSIG2n7FH2QeQIbnyeAZxo4LbQCYyBqGwoUe40msVclY2i+FC0EyHJJ9o0iR153aYDO396ZWioFbmEylgZiVFd/RmBuow1sh3BcKXCXyqusTNmbTsNmjl6e61eTzhLtvr1fbapm/SLBkUuwShw8NRvQTZFMapmjYgOg3yNH0K8sxUxiqlYL5Xw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlN3SmQ2dzVOSmdxam5VaGdnTUptZ1BvQTQ0UGIxYVpBZU1ibm5OZzVrVlZn?=
 =?utf-8?B?RXR2eHhpbXJuM0owQkVYclQwVzRpUXVoVENYc0djRWJWVFo3eTRsUjc3YTdW?=
 =?utf-8?B?bjRLay91YnQ4ZDh4bnFha3FFc0RLRzUwY05zTWRRbHovbmJkaDBqRWFlVTE5?=
 =?utf-8?B?RXFsN0hrOE81bTc1WUxGQVN2Q2dDa2tzY256QXp5U0tQbzNzK1F2ZzZnVTJ2?=
 =?utf-8?B?RzNJU1VVN3BtSzBwUlA2RFA3MXhWa3BQZlZJZit1S0lPUHlabjNrRXVQK0Zn?=
 =?utf-8?B?OHB5cHdPWjJ2SGJpM2JXUzlUc1ZLeUc1dkVyNU9CTjRsdDJwSUhnNElhTklL?=
 =?utf-8?B?RGgraHQ4b1AzeFZSQlBZbWo1STVpWlgwNGNmTnRzbEpwaG4ySzUyY3FjQkha?=
 =?utf-8?B?ZFZjSUVyUHZYWG4xdTJIN1JZYUJ0OVdIcEE1bm5kQm9iTUFveGxBTVY0RUx5?=
 =?utf-8?B?eVZXcG12MVZrS3ZtUmdSWFgrNDZaOHFidG5oUnRSazVWVC90Z2NrRDU3cWw0?=
 =?utf-8?B?YVIzWHd0MDVnNDhaclRid0xZdFFFdlNLN0ZWNkxQbG41Znp1T2tZVC9jQnlV?=
 =?utf-8?B?MGMwT3NHTmdqRWNRd21taWM1THlUa2FaTGZFeURaRGNKRXB3ZEp4Qk5hN3BW?=
 =?utf-8?B?dG00Q1NFMmRyWnVhMFNzWDdyK2UyM2t5ZWRrVFE2VExTaXFPNG5RTHEvd0JU?=
 =?utf-8?B?Q3Frc2xxNUxWbXBSWm91dUxjcngrNTN5V0txS1dIdG5td2xxbnBiQWErL1l3?=
 =?utf-8?B?TzdJZk8rTjg3VXRPZCtpRTVkbzlpVXJqMU1XejV3aVpPZ3JQNkxnVGNVNG1Q?=
 =?utf-8?B?bFFHekNlb0NxQStzcjdnQXpPclNqRXRUcUlkVmFhbU1CbVZ4U3RFVTVvM3hz?=
 =?utf-8?B?dkRsZHpyTkl1T0VmQllpOWJ0alJYTGJ6UkdRamd0dDFneEVtWDl2L045aFFj?=
 =?utf-8?B?R2daNFlqbWtHU1cyT3JZWkVXbFoybVUvUU5LR3NibTBqTmVkbzdQdjBqZGIv?=
 =?utf-8?B?NzZ2ZlNUZjlFajQvTjBqalJnMkJ5VldKNXRsZnlmYTBONUs3SzBEbkxoVjlp?=
 =?utf-8?B?Wm1UeGpLYi93WlNMMVI5aHlMaDVtMVJ2eGp0eWFlMWFQMzB2Z3JDZXRNaUVv?=
 =?utf-8?B?Rmp3LzMrUW8xZ1U3Vk1wR29OeEVqd1JselhlYk1jeFlSYmhVelRScmhNUFI4?=
 =?utf-8?B?R21iRlB6WHQydDVCbkJTSXE3UTFoSmpwWUVNaXhtSUtlY0grQTBnMFAxOEFk?=
 =?utf-8?B?c3NLMWo0NFJrVjFPbWlCNGgxcDdyVG4yMllFeHA2UnViREZsZUpsdU92LzNJ?=
 =?utf-8?B?SXgwN2d6c3ZjZkdtUm5uZkhBK3hib2pwSUE5YzJWOVVuVjlYZnBkbGVTSGJ2?=
 =?utf-8?B?VldjdEpXUURoS1hXd0ZUNDZ3Vy9OYm94UjUzcVZFZW15b0hFcmpkL3JaMkYx?=
 =?utf-8?B?bEpVWEcrVE9MTDZSemlnYjFpaGdHLyt6Zk5NRWRkbTBBZ1FwM0FaQnN0azJU?=
 =?utf-8?B?TEpncEJHK2NGcDlXWkR2TE9NUk5seEllUHI5eVduY0NQb0tpU0NsYU9yNi9s?=
 =?utf-8?B?RXYxR2RjNmNJZEYrRzIvVFk4bGpqWG1NTXNWMWY3aFIvV0FHb214aDRJNmJB?=
 =?utf-8?B?RkRIM3I0L2Vtc2ZGRzNCcFVDdGVTTlc0aVN2aUxMVElXQSt5cVZCaTY1cFkv?=
 =?utf-8?B?WjV4ZTZiYUk4SHhYMDF0RWVQanNCdHhKeitjeUFyWkpLTHJLV3JrWVNBSkpv?=
 =?utf-8?B?VUJ4UDU3ZkF1c2k5Z2dLOEdtdXMraDMxeEhOZzNEYUl0UmNrY09sbTkrU0JF?=
 =?utf-8?B?NStsZzhydGhGR1pvTFJQdktLQW5qT2I5cmRBRlBmY1dVZWIvbVNSQzB3c2U2?=
 =?utf-8?B?TWFyTkd1RHY1bjJiTjZBc1pJZzlRNENKOTBwOFBTczlsV2dEeXVNa0JMN21h?=
 =?utf-8?B?YkUwSzVYNURsMEtDU2lEdDlaUzNLdHRKMEE4ZXRTczVVZjRkWnF1c1VGYzRw?=
 =?utf-8?B?c05NcDArcklKZDFRMEF5Z0RoSHZQNGJNeEFsaFl2SEVYQTJFaXFuNy9IbVl5?=
 =?utf-8?B?My8rcElBQXZqTDNSdGFEWjV2ei9xOElmbVJubjhGT0RIYWYwTEgvTHRIbGIv?=
 =?utf-8?B?NWhuSExIeitFczI2VkJyWHFaRFhWQmV4WTd3akZCU1RuaU1GL3lnSlY0RUdW?=
 =?utf-8?B?TUhEZURNa2dLNzlFZkJqbCtqRTRQdzdKT3NFNTMvOVhQZ2xwSlJtTkxIWmFI?=
 =?utf-8?B?N1ZVWFFSbERwL3J4bFdzUTA4TnQrYVBqK3RncWpJMnRvV09wUGgzKzcyTUl6?=
 =?utf-8?B?Rkk3d2ZPaGJuQS9nQ2JEc3FKZ01FUmpiWWRXR0JJN2lXUEtEejdjK1BIdVdI?=
 =?utf-8?Q?S44x3JSBZDbXDJZ3NNFLVPnCYTTkLwto0v8oy+E0Elxiv?=
X-MS-Exchange-AntiSpam-MessageData-1: dFe3N5Z4LXmpnA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aace7e0f-cbe2-4d22-d43f-08df1c888b64
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2026 11:14:49.1363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7vZDs5s/tSrGqHlDZDEmOPGVY5R5F2Z+l35Nx25MCqBPxanHbcagrA2Q0cd4ktUW0zyt+Ayn9ufF/iVPNRRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154
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

`wait_for_msg` mixes two layers: the transport layer which polls the
queue, extracts the element header and validates the checksum, and the
RPC layer which reads the RPC header and trims the payload slices to the
length advertised by the RPC header.

Move the transport layer into `wait_for_element`, and make
`wait_for_msg` call it before validating the RPC layer. This sets things
up for moving the RPC code into its own module, leaving the transport
agnostic of the message type.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 2d22ae45e990..d50a2a594f82 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -584,7 +584,7 @@ fn send_command_element(
     ///   message queue.
     ///
     /// Error codes returned by the message constructor are propagated as-is.
-    fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
+    fn wait_for_element(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         // Wait for a message to arrive from the GSP.
         let (slice_1, slice_2) = read_poll_timeout(
             || Ok(self.gsp_mem.driver_read_area()),
@@ -608,6 +608,18 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             return Err(EIO);
         }
 
+        Ok(GspMessage {
+            header,
+            contents: (slice_1, slice_2),
+        })
+    }
+
+    fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
+        let GspMessage {
+            header,
+            contents: (slice_1, slice_2),
+        } = self.wait_for_element(timeout)?;
+
         let rpc_header = header.rpc_header();
         let payload_length = rpc_header.length();
 
@@ -619,6 +631,8 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             payload_length,
         );
 
+        // Validate the RPC layer before returning the message.
+
         // Check that the driver read area is large enough for the message.
         if slice_1.len() + slice_2.len() < payload_length {
             return Err(EIO);

-- 
2.55.0

