Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14316C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7282010F771;
	Fri,  3 Jul 2026 10:22:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="f2T9uZkt";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012022.outbound.protection.outlook.com
 [40.93.195.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437E010F771
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go10pQO1Gvnv2csNmnsqVqnaDUT8lvFp0fuvDDlsqbO1BIKJ+QHZ5neB7Yy2740K09liZXqWXjJMj2+hwqnbPrrAZXbmQSZHrae3p42c8ew4y43AWMMfZfOBRQxqn+IXZWIFd7xAw/KQkcUvLJow9zWwNiP1gFKYBz3WuIuiWYc9ihuI7zbGZxJFYFgMay5ruv5/LFjN6EEj0IIxEVsBycxJZCj6YMibXg05Ek3Ig5l8yqQc14bbQVCw/wTQq91IOQicVtCwjfZqXdVmB9bkqYlxuKO5mNZG4QryH//T5yXl6IyHk+nPDq43W41ZnZSMJlCUPlFq16RsC02cTE7x4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0OLA/Zw774dQEBxt6RuuHFy7CTzcNlqRRRHU0V9938w=;
 b=X0XaavMoUdYl9fk2Cl3ISs72PMrx5rDzHlaX9oAJ3Pc1ILiyB51pTC4sdVYa0+P/lbXshRubVPeXzoDwE5ZCzx6VoOWMk2ZVAYmN0a9O1bnqe5+33R3I3hb0cJVquSz+ZqidwSQ+xmFjf5vEs9fT15eWSO0mnlLsuAlQnnMFRMVqnN3zr4aAqDQAELqecojypH5itjV4uPOxQbWKIJvcbUqG9EBbaxkBs+urQm26qbsbYXbK3GHOpTRHNuUcIikxy9R4U8WVfNWWCFSA0azhwcW0IvSyKHsnBlh046DsUm3S3NaHTyUDhLbS8MFBpa7+7da0xqDLz8VQCidi0e6qxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0OLA/Zw774dQEBxt6RuuHFy7CTzcNlqRRRHU0V9938w=;
 b=f2T9uZktBW2xDTMKmyM59pkrxQIDQm7ZyF+Jkm0PRnF3Czyj7UYu1RIt/M9K8PapB7u0N+6JdPaNN1ErFMEbY23JHmBQ3kXNn7AcJ58L4SFdkoCBEE8VJ7jMBns+ZUH5DZX/A6jHxywewTRcbduJ65nnf8Q9eSOKJAcAAVSHZfYzG6L4ciUM+g1BzFwwfeKKZsv05+DFhU+QA19j18TM9bahLYMSdi4vkKtyBPfIK2zcILCX3ZgI1X2gf8WmmQiu7pYQ7V38um7UI81VV+C94z79RiL/XFk0zGoYCj3JkdlNdky9tVws32tCukTRzCigy5Sc0BB4vR2Yq0NSRbH0WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM4PR12MB6326.namprd12.prod.outlook.com (2603:10b6:8:a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 10:22:26 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:22:26 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:22:06 +0900
Subject: [PATCH v2 02/10] gpu: nova-core: fsp: catch bogus queue pointer issues
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-blackwell-fixes-v2-2-8e3d8bc32bb9@nvidia.com>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0137.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM4PR12MB6326:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9d9e9d-8c24-4cf1-5b7c-08ded8ecfa86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: iaZQKTIrtuL5SifosMHDTwpiA/6BkuN2ARMKFc6mXziXPkKvhS+OCiwWt3z0vCeP8xg12XKXLQ4Tv6MnxG8daPU2zWFO+pqOfVRuvvF9vWNWXHaoawCjk127v07ffHiLmfkiMwsSvYoMXmqNSMm9k/U/xphRtRwLM+JFBmXl41gKfrBGVCiBTfxRsJUoO+Fc6Q4d/t40MIgTMoDA749rszAcVuDpktXGFpCMf0BGNTDxbgnYf2mmELNJVkIspgRKby9YwST1JmZUkI1TcrQDyn1CRWry2DkDDbqUVtMf7Q6Wv2+xKWTfAJylIdVPAv4mHMw7SGbCWPDazasL0ZOTgy5jVZcCHRUjlIfPB9X7l86TttmQzzUfc8nshir899C72wnft+Ezf2QJ8Kzby6ffxR6HkIxD2czjv6QEeIKUPoGXSL6DCmxm6UQd2OIVEkxOdfgib9l9rwgJbaZgKcNFKPgJiWTGBmP8DQx8JdhJqwCUGzz7G78w/uqzeRba4o8DVTLI70XEDeNb3KS7o7upOV/ed7cCmMHbp5dXl1utywlrSCVYVufwXAnJMMwqGq/ayzFffRVQN1JyVokXEVWbf8IJqmHiAjMf6ZlFMe50sV6wTk5Wq48QPnVf5oYvK7etHKJsxh4TfJ6IhlUyTIrTghRk/jhmEhc73QPdIq6/PrM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDRXMWFmMG0reVdRNWVSaVQrNjU0aTZiczdxOWIrUUlKWFlpVkl3WEtFbjhK?=
 =?utf-8?B?Z09kSVZSbWtscjd4THEwNzJ1S1JhN1I3VFNFSWloOTBiUjRjQ1FUb2xHOTdS?=
 =?utf-8?B?UStvVTdiVExCOVY0Wm5mcnVJZ25QQk8vY3RwRndZN1VqMkk3YjJZQU8yN1ZM?=
 =?utf-8?B?ZjNYaUFqamlwWVZPWXl1QW5QRlZiL3krK094aFdDVDFLL3I2NFZLK0xwSE03?=
 =?utf-8?B?SXBHQTM3Z1h4NTVmRkFhc3JsMHc4dlc3NFlLWlFRZ21PNURvaEEwdjAwUE9u?=
 =?utf-8?B?WGFEeG4vSElRODFnVHBDb0tBdkY0eTIvam91RTA3M1hXQllVN2xBaFMzdldU?=
 =?utf-8?B?VnNNM1A3S24rNWJnTnJoT0ZrNDJFMG1QNHlBdkd2YVRmQzYxeWFuT2NpZUVt?=
 =?utf-8?B?Q2xudjZ3Y20xdjVjeURvV0FQbEpHMDZJbTF3bGFCRWx3dDVhMGhLdm9DbVht?=
 =?utf-8?B?bWRZK1BHcXcycUF6T1JQMkc2c0JUbWIxbkJJNDNzZGt6Zy8vbHoya0t0NmVv?=
 =?utf-8?B?cDFhdW13cFl1V2V2TG1XbDlySTBnLzVXWFdNc2lHbXZsRDlSck1pRDlPaXVK?=
 =?utf-8?B?TmZ3Mk9XV1h0T2ZEN0tMWGcvZUpKcHBoWTZMbUExRnRQUDlld2wyVjYzMmpq?=
 =?utf-8?B?NEg1QUkyQ0FiTUIveHp4K3grMGhCQi9vbTAzT2dyL0J0OHp0MlNoaTlBSHI5?=
 =?utf-8?B?c3M0RGtTSTFVY0tGREhTZ0daZ1V4TzJSbFRHbjk5MzlpZjBtNzJRRGJaN2hJ?=
 =?utf-8?B?bTY3TGRFNVBYUTM1Zms2MEo2bVJaajVCWFBKYjhFeXI3ZXNzSnMyanN4T3U3?=
 =?utf-8?B?M1l1NklKZlV2ZXpra0NFTGFKaU5EcXljaSs1ZEV5Y3l4ejFrSnk4WXlIeUwz?=
 =?utf-8?B?R3JKY1RCWE1MZDdXWnZtSHkxWWxrUS9SUUdwUWhPUnQ1QkZNOVp0WS9iYmZX?=
 =?utf-8?B?N1ZOaFpNakJITUFSOThKUXFmWVZhaC9NdmxlMjBPbVUya3NEUHMxekZxQ0lt?=
 =?utf-8?B?Rzl2K1pXQ01iMlhWdFhSN3lOME8wNElHU3RhSTRRRHRGRTM0azhEYzh4MHFY?=
 =?utf-8?B?SGpLRkxnY0lXT3l6WjhYWElOMHNMOUw2RXZEN1ppdWZvbDIwUC95S2tWdS9x?=
 =?utf-8?B?bWVZV211dGdjR3pyLytyRE1hMGp3WXBwcHRyTkx4TDVFSlFmV0ZJYkZRN3Uy?=
 =?utf-8?B?Y3Y5dkZOQXkrbTFRZE5wLy9nTmFTVmxHUWQ4MmNvSDU4NGxZNDROSmRWTkVS?=
 =?utf-8?B?MlZDTXNWdXhPOS9rZzBFSlo3NVZqZ2JtUDdjWVRpeWtENVFQS2RMa0xZd2tV?=
 =?utf-8?B?cThROTFuSEU2WEZ6cUNVK3pTNzlxczVybFFmVXpuNGJkcGM2QlhVbGVmTTJW?=
 =?utf-8?B?OFdGSkhBYTZaMDhJMjliZUdKc2ZqYThyTmhDcVg4b1YzY1lYMkhCU2dEcUhR?=
 =?utf-8?B?NlY4Tjl3NHNtMTVZNThxLzZ1TzhvU0xodFEwRDdyM1MzTFk4aUlDUkc2Q1pI?=
 =?utf-8?B?Q0lONlRHTEtYakRya0xkYnhHV3pBQ2xhRUNCaTZUMWZtZkdDWTVlRUlMaTAv?=
 =?utf-8?B?bzZIR1BaWEFQUSs1WUFRTVlsWHhlMU1TVFdHRGt5TFU3aHFNYWNwY3dXVUY3?=
 =?utf-8?B?VHRHajBYZ2I2RlQ4dGZ2c0xjUUFXNHhnbzMzMG5mNng0K0hMTkJNWjM1OHMy?=
 =?utf-8?B?N0JidEYydkphUVQvR2o5R0pyYmZWNEFYa1hpeUdUbzd0RkVhaVVXa3RMZnQv?=
 =?utf-8?B?bS9Ca2RVU05RNmlST2FQU3FBMVhxS0lJM1k2eUVzT0JSMkhYc3A1YjlZOUM2?=
 =?utf-8?B?QXlXUU8yUmNjaGF6azZ5Y0NtdHViUUdkUElJRVMzaGVsR2IxdDA3L1ZESmFO?=
 =?utf-8?B?WHl3YU5iT1NXZjN2cEIxd0NBeWFWbnRuMldxL1dxOEdxUVo4K0cydzVaQ3Jw?=
 =?utf-8?B?dWZXcEJBdURyS25MME9NdXB5MUtoWDdxd29salEzQldOdFVvYkp3V2RoNXJT?=
 =?utf-8?B?L2g5T1V4M0ErVnhxSVdKQjBVQUxLNDJLWkQvWUQ0Qm05cUx0ejI2aStjZkx3?=
 =?utf-8?B?VXBkVGZxWVdVZDRvT2I2MUdRUjFaUFQzSjBGbXYvT1JNRk95Qjg4QWlDTzVk?=
 =?utf-8?B?dDlUa2h1bE15Ym9sR0F6bEYyU3B5dWlmR0xEN0pZeEtuL0JxNmdTK0llSmc3?=
 =?utf-8?B?Q1ExWXhVanpWUXdKZ1QveGxNZk5QUlpXeTNVcnNlV2xuemwzckYvS0s0Z2Ju?=
 =?utf-8?B?TVRUd1YyQTFmTGhsVTVTZk42eDVSUEp6UVBpN25Yb1AxZ2pIN2poTlFiLzN0?=
 =?utf-8?B?Y1BCSjl4MlFTQSt1eXFrLzNYNFc1YVpHV200TE1yWEpQYXFxcWlFUDc4OGxV?=
 =?utf-8?Q?FJR24Ai279hjgzd32AmIjecSEJ9MrSFSWJt8sKEFk7a92?=
X-MS-Exchange-AntiSpam-MessageData-1: Gho9FfScXCNGjg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9d9e9d-8c24-4cf1-5b7c-08ded8ecfa86
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:22:26.1117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JA4BrMjEUEUtc+NViqVBMWAPzwfbOpymvxY6NQITo3XEaytEn97KakXR8MsSyvK/opdzyLFgBYfDv1leuh5Ofg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6326
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

Currently, `poll_msgq` will report a message of size 4 if the queue
pointers are broken. It's easy to catch this if it occurs, so have
`poll_msgq` return an error in this case.

Reviewed-by: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon/fsp.rs | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
index 7cd9604d1f4d..3752448df431 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -109,19 +109,22 @@ fn read_emem(&mut self, data: &mut [u8]) -> Result {
     /// Poll FSP for incoming data.
     ///
     /// Returns the size of available data in bytes, or 0 if no data is available.
+    /// Returns an error if the queue pointers are bogus (`tail < head`).
     ///
     /// The FSP message queue is not circular. Pointers are reset to 0 after each
     /// message exchange, so `tail >= head` is always true when data is present.
-    fn poll_msgq(&self) -> u32 {
+    fn poll_msgq(&self) -> Result<u32> {
         let head = self.bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).val();
         let tail = self.bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).val();
 
         if head == tail {
-            return 0;
+            Ok(0)
+        } else {
+            // TAIL points at the last DWORD written, so the size is `tail - head + 4`.
+            tail.checked_sub(head)
+                .and_then(|delta| delta.checked_add(4))
+                .ok_or(EIO)
         }
-
-        // TAIL points at last DWORD written, so add 4 to get total size.
-        tail.saturating_sub(head).saturating_add(4)
     }
 
     /// Writes `packet` to FSP EMEM and updates the queue pointers to notify FSP.
@@ -155,7 +158,7 @@ pub(crate) fn send_msg(&mut self, packet: &[u8]) -> Result {
     /// memory allocation error occurred.
     pub(crate) fn recv_msg(&mut self) -> Result<KVec<u8>> {
         let msg_size = read_poll_timeout(
-            || Ok(self.poll_msgq()),
+            || self.poll_msgq(),
             |&size| size > 0,
             Delta::from_millis(10),
             Delta::from_millis(FSP_MSG_TIMEOUT_MS),

-- 
2.54.0

