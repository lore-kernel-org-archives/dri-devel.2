Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408060A2629
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TGlC0HlL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5E5810F49C;
	Tue, 20 Oct 2026 10:09:18 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E880010F493
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:09:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzWVHytT5W3uvT+y8h9qyjFwXYu7WJk5mST9gkwux1R5T7wDtC4W64DTxBG2urXw7x5f6tYk6zCJoy/dsP6IuPrS9W38eCOiLUIpRj4JC/QYIzbkYO1TM1fnpLD8O/0ifhNjcsYmu1heH8tZeCprf4I1jZVdfl2Y9PcgVBpv5PIBEchLqQg5dc8eq9+Hewi78jVeS4GnX3ttD88jrQ/kxPvZJor03KAIywni3hw6lJnJ9tXf34afPDoZq8cjYEfytazeMgWqbX8DILyTVLvd0k1pAhbVUrw2/J1TghlAVb2F4Hqj0LKkW7ljv0Q5ckgUd6gGnSJVsKs7esOWQ1zn0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmNy6z9cA94HVkR+XNW9QKwDM5dFlxRd4GShfaBDcF4=;
 b=HMUOkY5pEyxGT/gZbVOOwL1BImpslaybiZaTA2EP/zYKdnOf3T72Fu+8O+b5WQ7mDZzUhKzbNHVHpvUDLWYMUxnXbWIVDE2PC3EjDhnGqEQlzsZM3U3pHHjUma26V5IxBsmT+ZDun9NKZ78qmVXnA0By93ANKhjnVYNdVyzDI59Og6HyiKe2a8RGCQZqnXUyyt7TqsSZGRPMwtn5n7llmbzRx6dZcUdLxZ6WAcM4nq5ffomDG32zoJJYcIXXfOFyjaVa3148A/OQVH+ptjJiAS/B9ZtfjdmH/vVzWh1ymSHJ+jZaSqrSQJ4OuPQoWDvGAPt4LPT+KmAX8urGhD9faw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmNy6z9cA94HVkR+XNW9QKwDM5dFlxRd4GShfaBDcF4=;
 b=TGlC0HlLyYBPT70M80WZP8+pNAiZf54DyX7Kvdp928gmx+RikT/0Eo6FM+AxHfCUeNqYl4YwGGPdOgeQIL94GAGrwX07cGctiWuWhVHSSEeWg3ZLBKEUkIpPJyIiMnaVZUWkWgTv4jJPgz7AIsNEouboeceL7MwVo5OZ3F1PqVX38Sng5Am1S47nvkmxJTrNU8ibUozf1AgRiwzBhaZ2/LmRJsTjB+Yf02ziNfV5nEBCyBXLIVs4T4uhiwaEBYkutfO7j1BSDzFdRcRmIhSA2qLlkBt7u4x+WXvD/gcOfxBdeZ8R8eNKd3RH0zFrLw36yuAZORNiGnwm20xPT/bIgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:08:53 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:08:53 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:29 +0900
Subject: [PATCH v5 08/14] gpu: nova-core: gsp: cmdq: move RPC message
 logging to RpcMessage
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-8-dceeb8f360ec@nvidia.com>
References: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
In-Reply-To: <20261020-cmdq-rpc-v5-0-dceeb8f360ec@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0014.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: b2135699-ba72-4971-2b4f-08df2e92254a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|6133799003|18002099003|22082099003|10067099003|11063799006|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: CSpPHLIVH63lpD5UjZ0QzpBYnkUJoq0ChvU6qcOm0UF23laYkhqjYj309p9/zD+L97eqS/sV09WuQD3BfOkOdwlONNAZ++ebRuLFFqtyXKf2lcHR+lZnoiRHhl2KYx2VJTYwJCf9ddSMgYeWHw6bcovDdnn422A5k+hvZ3R9Z6uZ3FBwjfKbQtlS8h150Bqls2wulnuhptO5Z9EhM6okT400e1a3sb1XSoidHXXqlSHao9Dwjx/C/bLEe4UzbOuNStbVP/OCPaZ89XYWUgaqy6L1eqUoeJ53XRJRosuUBOG2RxWJhuRxge04Te6RarTtLu0FXOAR3lySxv5WdFmVrOfRPaKD0r8TuKRyTzS0Qw3IRLhaIKiKcG+DbLYfNgVvC1JZuA1HiFCWt6IA0b9oTJHEfAissFO0V7JCHSKRZe6o79YfqqLmFi2fNx3v66BDmKF9m81xVMgbxKDiXBlgK2eWfK7qlv5s5xu0y3os9xpCBIZPwqWw8fBB6oOV/LJlb0bOo4OKSy230OBwTE+Be0HCrJ0J6NUanuMI72AhKCMAc93sA20d+fDRNMUS6aWCsIJgr4NL0AOXDpG9XSB+5aWHhfrvzYDHaq/wDd3i2L8sPTZA2kaIzrO2dNOnsRcRnZzW2+RGT/ODR1Au0OPplSbFBTs5EoVK9fcWvTRzMJM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDJPNzR0UmtlUytYMkw2UFhBdmh4TzgwVkdGeEVmMFpmdGkrUXd6THdQSUZB?=
 =?utf-8?B?dlpMSThlZEI2eDM4SEZqbHphM2J2cmkzcURlV1VGRU84WXdCb0llZkJUQ2N0?=
 =?utf-8?B?a1N1a1lGTEVPQ1UxYjhKZ2VuV3daSG9aMGVZV1YyRCtaRGZncDVNcisxcGhE?=
 =?utf-8?B?b09Hc2t2cXpDS0RkQnlHYy8zWXQwSjV1TUVZN2QvUHVQdVhIUlVqSlVvUXFr?=
 =?utf-8?B?Rkwxb3RDM1ZxVDR6dmx1UHkvbk0zT2d1Y0JKNG1LSUpYNnNFQXN1UlZGaUxu?=
 =?utf-8?B?ekJSb2FXbk5kYXNUdVJjRk9mZlZhdGhNWUE5L1B6VjdRbGVpNHRsekRkOEJu?=
 =?utf-8?B?U0ZnRTZ0ZHVQUHl4TWUwNXhLTXpkNkkvRzNRNmlyMG83WlM4ZzN1TkVxWFlK?=
 =?utf-8?B?NUVsMFM5dDVUZ3BBVW8vaWFPdG8rK1hlZ2F3VDlGM0RBbjR4V0xEaCtYaUts?=
 =?utf-8?B?ekVSTUpQUG1jc3hhWEJxNkR4ZTd0VzJUc3JUcElZOXo1N3J2b0t1dzRJREVM?=
 =?utf-8?B?UVZ5Tm56TGpZdEZRS2ZxVUZZRmlRa25qZUN5bS8wbndhMkhLL1ZRNllyQnp0?=
 =?utf-8?B?a3NUS0JicTk1Qk41ZXU3K3Zwc0VwcVdVbTR4MUp0dVlVRVZhOWhVbjJCWThz?=
 =?utf-8?B?bFN4bUE3N3hwcHF0c0plL1ZiQjdpNGlhT2ptS1ZMYVIvWFBhYVJhVHVESUtR?=
 =?utf-8?B?b3RiM0pVNEpRWFZtclRsbnV3eDNSQkNiZTFFWDJremw3WkpVeTcvTE1OZU5Q?=
 =?utf-8?B?WTM5c2Z1Skszajl4clViMUVmTnV6cVN6Q0xqeWh4T3NrNWIrV0M5bGtsNDVW?=
 =?utf-8?B?ZkRiVGdzdEVyd1l0YzhiSUhCL0h5SDBVcjRGNmlCL3QvUHNRUUhQSDZ3Vi9Z?=
 =?utf-8?B?TFhrYlBOeWlyZzBTc0FYUjY5bzdrWDJleThhUTBCbnE5VCtIVmY3bkJ3TXZl?=
 =?utf-8?B?V2wyRGhuNDRUT0dqSEhURlQzNDk5bEltdU9LKzNWRnJOWGpjNzNGZk1icEEw?=
 =?utf-8?B?eDNJSVJibit0Z3IyL3Fpbm9aWUdHZ0tTQVlTaFZoVk5ZUHo3cmxpejlzMVA4?=
 =?utf-8?B?VStlS0wzMmI1QWtERFJLdkRwaGFwWDlBZkxmeHpHd0MrM0IyV29EMjBtUUgw?=
 =?utf-8?B?T3Zaa1M4b2RESjhMT0NhbzEvcE0yUnBZbzY4bjVJbkxVT2hVRnh6aVJPRzd4?=
 =?utf-8?B?REEwSXk0WWQ3YVRWSFk3NkFkRTJ3ajY1U25MdW1WejE3bzlTZkZlOUdPYWVK?=
 =?utf-8?B?WHh2bVRiaW1ybDF4Z1hkYzFEN20wVkFGR1A2Mmd3dVo2Z0JYQ1k0dHdoZ3Js?=
 =?utf-8?B?Vy9UU0RRWFVVc3BHcm5EVmJHVTA5N3R2UmQrdFYrQVV5ZTBrWUxWQTNwajR6?=
 =?utf-8?B?WGFKQVF3VDIzL1ZmL1RiUmczRkd2dldzM3VtQkFLTnNYc3ZOVnJiNC9EZFd4?=
 =?utf-8?B?ZHVQYm0rTVdtNDNaakJTNlJ1RzBLTENGZ1ozU2RsMVJDamJXcGFpNldJUjQ5?=
 =?utf-8?B?NHVXNjdNcHVScUhzc0p1MldGbTN0ekMvWjV6cWZuZTRZNDhGN2ppZGNCWG5V?=
 =?utf-8?B?ZHNDZXp5QVptYjFqTyszdk5rRjY5dVo1bVc3RExCL0VQSkVOY3lkN2RkblNC?=
 =?utf-8?B?cUxLVlVwSE5GNWFKRVF2WC9laWFaallIU0J6b25lN3oyaGZRb3NmYUM1U01p?=
 =?utf-8?B?b1ZTM1pTaVBoS2hkQjU4YlRnQUJoakVsdTBzQ2xaYThQYnY2VE52amR3dk16?=
 =?utf-8?B?Y1lTVTlTQmk1VE5hRHBFUkZIUGRFa1dGa0YvbUpBWDJyZWp6cnZqKzdmQ0hz?=
 =?utf-8?B?NFhLUmZkNGtpQXRUclNyWWxxb0hzNGM2RE00cU11cWpGeXBiTCtVbm1NMml3?=
 =?utf-8?B?Q3JTbEM5blpwaFJsOU1ZajdYR21TdVhYQmdGM01LOWFXWEpYMXZvMm1qeXFv?=
 =?utf-8?B?TXRhZ3B4bS9pdGdUR1VQYjJ1ZUVkblFOU0V1NzVrVEp2QWZYcGJPT1RhQnFW?=
 =?utf-8?B?d0x4bzZuM1pMMWQ3cjc4UzlHM29ac0VHWkkwWjdJTkN3L0VHQ1JEWGZPbW0x?=
 =?utf-8?B?b0FZcTc4d1JvZnliYnZBa0lmNTNuQ1RWUkl0Y21pN0ZjTHdaYWtEaTVBSTVk?=
 =?utf-8?B?K213cHZINGFkR1hLYXZaZEpiRG9TQzlsYytJZ3oxSm1mS3IvazBxRWJNSWRC?=
 =?utf-8?B?QitKeCtwMVNPWEpOWmZnSUpScC9vVHhHY0xwZFIvL2c1NWRpS2p6NmRGWWxr?=
 =?utf-8?B?ZGdnOUVJN2hha0hYdjdsaXlLMTF1aEN5c01KbzFDK0hNR09ETkFjQndhMXZB?=
 =?utf-8?B?RzV4OU5DeGdkcEU1Sjg1NmpqRU9LbnE2eXRyeWRDQXdYUVVyQSsrekI0WFB4?=
 =?utf-8?Q?d2o5jOBeQboLYVd9/kkxxiANgJfwq8l9YzI3/dpjIctY2?=
X-MS-Exchange-AntiSpam-MessageData-1: 2GsOlA+UqxaS4A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2135699-ba72-4971-2b4f-08df2e92254a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:08:53.6511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AA/E3a5OacUxit8Bkb2AD2WgKmr7zT+yiRVMJG1pq0FKPXNCH2Xh/EvxXL5YabfvpKaR9hvJ88TZTheMdXKog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The `RpcMessage` type is the right container for the `log_event` method,
since it contains all the data we passed to it. Move it there so callers
don't need to extract the required data themselves.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 66 ++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 18861400c3be..4efc96eba4dd 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -615,6 +615,34 @@ fn parse(dev: &device::Device, element: GspMessage<'a>) -> Result<RpcMessage<'a>
             contents: (slice_1, slice_2),
         })
     }
+
+    /// Logs an event, meaning a message that no caller was waiting for.
+    ///
+    /// An OS error or robust-channel record is logged at error level and an unknown function code
+    /// at warning level. Other events are not logged.
+    fn log(&self, dev: &device::Device) {
+        let function = self.header.function();
+        let seq = self.header.sequence();
+
+        match function {
+            Ok(MsgFunction::OsErrorLog) => {
+                dev_err!(dev, "GSP reported an OS error (seq {})\n", seq);
+            }
+            Ok(MsgFunction::RcTriggered) => {
+                dev_err!(dev, "GSP triggered robust-channel recovery (seq {})\n", seq);
+            }
+            // Nothing to do for the remaining known function codes.
+            Ok(_) => {}
+            Err(raw) => {
+                dev_warn!(
+                    dev,
+                    "unknown GSP message function {:#x} (seq {})\n",
+                    raw,
+                    seq
+                );
+            }
+        }
+    }
 }
 
 /// GSP command queue.
@@ -944,7 +972,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
                     }
                 })
         } else {
-            self.log_event(function, rpc_message.header.sequence());
+            rpc_message.log(self.dev);
 
             Err(ENOMSG)
         };
@@ -986,36 +1014,6 @@ fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
         }
     }
 
-    /// Logs an event, meaning a message that no caller was waiting for.
-    ///
-    /// An OS error or robust-channel record is logged at error level and an unknown function code
-    /// at warning level. Every other event is recorded only by the receive trace in
-    /// [`Self::wait_for_msg`].
-    fn log_event(&self, function: Result<MsgFunction, u32>, seq: u32) {
-        match function {
-            Ok(MsgFunction::OsErrorLog) => {
-                dev_err!(&self.dev, "GSP reported an OS error (seq {})\n", seq);
-            }
-            Ok(MsgFunction::RcTriggered) => {
-                dev_err!(
-                    &self.dev,
-                    "GSP triggered robust-channel recovery (seq {})\n",
-                    seq
-                );
-            }
-            // Nothing to do for the remaining known function codes.
-            Ok(_) => {}
-            Err(raw) => {
-                dev_warn!(
-                    &self.dev,
-                    "unknown GSP message function {:#x} (seq {})\n",
-                    raw,
-                    seq
-                );
-            }
-        }
-    }
-
     /// Logs and consumes every message the queue holds.
     ///
     /// # Errors
@@ -1032,12 +1030,10 @@ fn drain(&mut self) -> Result {
                     dev_err!(&self.dev, "GSP drain: message length overflow\n");
                     EIO
                 })?;
-            let rpc_msg = RpcMessage::parse(self.dev, msg)?;
-            let function = rpc_msg.header.function();
-            let seq = rpc_msg.header.sequence();
+
+            RpcMessage::parse(self.dev, msg)?.log(self.dev);
 
             self.gsp_mem.advance_cpu_read_ptr(pages);
-            self.log_event(function, seq);
         }
 
         Ok(())

-- 
2.56.0

