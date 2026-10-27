Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C5160A260F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=L0SlexPe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD3C910F2B7;
	Tue, 27 Oct 2026 07:36:43 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC3210F2B5
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsjJqKrGNkcOeFDO6hy2tQ3qliBCyPdR/qIbuLcF7Fd7Kcf/aNttM/mYpQ8KEpkXKUCk5ACGOsDYKr67kRvLjbG2PtoLeyGXnkxpedJLC7o1OqgSK+lm8vE5KckQ50eM0+je77svBlJg0O3QjB8e1kyYRA9REpPUnEZGqJ+GU1z+1DnVkeEa7wZbxthbzIW0wbRBwdOQuOIsDQfw4c4T5UTjk14vEJLUGQ+9FpDRRVUxPNeh3FV2f9Y6rbrNUmGhsRTbWvevw9v6CJkSqYoJlDa9L7qqzLKyoem5PF24C1XVUkeY+mdkuqF6ScQfBeWIOfLQyk0PfWTrmVgO8nzmyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmNy6z9cA94HVkR+XNW9QKwDM5dFlxRd4GShfaBDcF4=;
 b=LcCtudoet8WsEBoEVhuQqW9WgWMs5vFqWn66dwKEQLlyCz3CDnv7Y9wRv8l0ImWNRjeOf82erGKMLXoIItrZ3KZNj5qc4bKd6TPRCRGwowGT8Sn74EgcowZiSKaFu/hWyTXuQJbyKOCMOEvYd/P3te2P/kNvo9y1Ydy5kI/SWyXeurYZ1xwWg0vaLyt7yMayPDgf7NwJbKXpVoaElkSG2z1eStf+PMam/jbuInvzzTH2IWFdyArVmU/5yUwqQHHxidwqb8fe9QilSKvhpQWvVcNE98y1vefMsbVieyWN2DSZ8vlij7lkTsz5VMVmVl+B3Xy6v6Qt/vJP8MOpm1qdKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmNy6z9cA94HVkR+XNW9QKwDM5dFlxRd4GShfaBDcF4=;
 b=L0SlexPewNJ4AePi0FsJLDtf/KhyXNennJ+YiHSSBa7dIst8F4F3fs1ZxrMH6QljiUhXSgxAkYfIOBkusqFc0YnGkrrwAL2BAWwixqrYlud+w8eBQZaRfFUK7KNmbzcvthHalOqZmCpNc0CkI96uJWb+94EhWyI+15FSn90jgxpIiltHm7nEmBFT5amOeRl0RWbcJSLPps6y5xRA/fH/JELqL1yEN8PR3jrFYAPFnOeUXlwoghVtBC9b7yrwT7fxaZWAnpEHillObr7c41xwpcYuAzexr2reyCMDqSKGUtJhvDQxtoVtVqi2Iv+9Rqm+Pud1E4+7k12pG8Z4WzrguQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:14 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:14 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:51 +0900
Subject: [PATCH v6 08/15] gpu: nova-core: gsp: cmdq: move RPC message
 logging to RpcMessage
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-8-bed9669724ba@nvidia.com>
References: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
In-Reply-To: <20261027-cmdq-rpc-v6-0-bed9669724ba@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0373.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf0b62c-f3bb-4d53-1d8f-08df33fcfae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261026121527099003|261021123027099003|5023799004|56012099006|11063799006|261022105027099003|261009223027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: GROl/ee6SHsP4u4b0ygF35aCFFzNtyY3OKG3l3KRYHz4VOcKraPd0gjfRUKlZghS0Pu0UvsaYeLsxEOl1heTnLmcweHX3IdyFTfFFDvu4QFZ8aknJFWwN56LGDsr1fV1hGVeySt/cqVumD/8N98q0q/IBUzw2RUzNEZjGLB5bzpjFbfv1CdK3PmtxhUgBClRwbQSaGFDF95rreJkL2uNNCLcQ9JiEUgCJBBm2AnIDHgdBN7eJYurfNi1LKg7SERqQ3IFiNMDLhXvcdWrgd136+2AJ4LE4tZZe17jRJAVUEXo758E4P+J1S6eFMEkS3iFu++0IKgVKCpZD+nuFiQq00+meTwlyzBoS7mtM5RUqN/6OEg/PDsCMK3rWWIFF/ur7U0hdCCjhfyZdxqktWwhlG3t/pKfGl00qUDzmeJTM5TDyDgrBqlG47sdKIpYO+vaVc5/0iltVNDSamuinmJFMI1ndsCkRZDv8kKz+/gqtcITkYx4iKCEcl1XDhPxxm/76haNhKo12UeFum3s98ydKn9BD/HUU95Z7ciWLxT8zuGhJXFZBlEcU2lsfc+IlWubNCT7x1L3I77Pwdlzm7rfqODG21Etkt7iYar+w9mGfr/sQqeqaSKQT8GDv7Oj+RYuzdKfwpEAKYmRRvgbfWkVBOZs7Bmqpw6C0bifhcCr8dM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261026121527099003)(261021123027099003)(5023799004)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzRzRkVMd3BnM3hjWU9SaWlUVzlHQTBaQ0ZaZjdEMjI3S28vWUtOeHk0VFRr?=
 =?utf-8?B?d2NDeW5XMnN3eEQvZU1CaUVXdlorMEl6QzRteHpoRXRTM0ROUTVjeWNvWTEy?=
 =?utf-8?B?THpxYy8rdkJscE9CdWczNkRQNWtvNTJ2WEU5c3Y0N2k2aTZmQnMxZWJ6d1Bo?=
 =?utf-8?B?QWU5VkQrYUNYb215dWhLc2kyYVR2ZjNvZVVOakRzSDVHOEQ0aVV3d0FtL29D?=
 =?utf-8?B?OFRZcmtQcXBKT3AvNklneUFIaXBxb3JRUHdiUFMyODlLR1pQbkxqeDdWcTV3?=
 =?utf-8?B?S1ZJcnZUMGtrMkI2SWpKQlZiclV5NXMyTTBBcC9HZ1c5YkRWTFFFQU5xa1Rj?=
 =?utf-8?B?TlRXRVVIOE1xM2EzS0h5dHJzR3ZBWU9hYVQvRkRJTnBHYy9Id250VU56Mjl3?=
 =?utf-8?B?NlZlbE8rQjlRVkdLTWo5RnpZSTNrTTFwQit0QVQxVyt4M0ZFRUkzMk1laFZI?=
 =?utf-8?B?WFZDTFcvTVQ3MjNBRll2ZnVNSXdqRGpBdUUyOG1VcWs1L21oUXRocU9jdE9T?=
 =?utf-8?B?cmFLcU9mamdPQU02ZStrSVVMejNpT2tCV0tPWGxILzJvLzFkTnI5dUV4ZGtQ?=
 =?utf-8?B?UXV1dHcyWkplQkgzZFFKMjdJcWNjMXIwVFNwSXVDb0MzN0tiamtncVEydkhr?=
 =?utf-8?B?R1NwUFJjMDNWVU4yNEMvYUFCL0MxSjZZUkdCTk5JR093d2NmWnFFOEhsVk54?=
 =?utf-8?B?N2VyT3lzSW9zY1g3U2NTU2xveEs2b3YyMEJZdVJSRFl4NFA5Ulc5TlUwU1NZ?=
 =?utf-8?B?UzdSc0hQbk9yN3EyeU1OL0s0SWJKdUoyQldvUVYwNXpmc0NQN0tGQmVLWnlm?=
 =?utf-8?B?c1Z6Z0lxcm1LdTdGd3VnSlV1UkhVMUVMZU9iVWhndlRBSGxVbFlZSk90VVc3?=
 =?utf-8?B?Z25RQ0JRNVFFSHd6Ym5QNnk5Qk0rd3kybGpab2taUk84MU05NkxSQjk2cGVO?=
 =?utf-8?B?UFkxbDV3eFBLZEZqalN0UGhMTlFuYURXWnZxek1xbzZHZHk5WVV4V1E5aWhR?=
 =?utf-8?B?eTdia25Qb0FvcXI2L3R4bUVDVFdJclp3OHhmWWFZMVhqcVNYZXAyZGIra0xi?=
 =?utf-8?B?ekdlV1lDeXRnZitZTE1JaVh4aGM4eTJ1WFMxdnF4Zi82ZjduVzVyS2lrSElh?=
 =?utf-8?B?QzFnd0pUSGhORWVSQnVPN3lOU0x5Zm90dEcwUHhGeFQvdXdHZzg4VENnOWhC?=
 =?utf-8?B?b1hXZ2dmOFB3R0RnanlmeC9YSXVsS2VSZE1BZG1jR2x4ODFLREdlTTc2Qnkw?=
 =?utf-8?B?elYrNktuQ1pRWEJ3aGhRQmNGbDlObTd5QWYxVnNiZ0VqNnc5eEpLY1dVaEZz?=
 =?utf-8?B?WE9GcTVrZkRQNVBQallsQ1RyRnk3cmZMdllxRzVGNW1DUmxYL2JxMnJydXFS?=
 =?utf-8?B?cStKQVpYdEowTkEvZjBLK0xuTmN2a0liS09DL2F0YnByZkFMbmlmdlNkWVRj?=
 =?utf-8?B?M1YrTjR5eng4aXQwcTJyZER5N2kydHVZVUhzTFNRZ3N2S2JVZVcxei8wd0ha?=
 =?utf-8?B?QUNxd0hzQU1JSHduTm9VVVp6UDJoZmF3R09YaHdEZHJCaE9yRktKUzIybGNE?=
 =?utf-8?B?ZDNxNVJ1aEo0akwxSGVjc2UxNTlYOGFMcHFucEMyMDdFWUhxTzd4WStsTFY2?=
 =?utf-8?B?YklFRUZSMnJveTdGSlpJNjVqVjExTmdJaVRFWGNZTkdHUW5pdDc5c3ZhaTRF?=
 =?utf-8?B?eTJMOXY0YnV4aUxFQW5pYWthT3hsRmpsdk5mUWE5Q0t3KzBjZnNES0lzYy9O?=
 =?utf-8?B?YW5teU5JdThZSmNvMVBUdXp1QVVDWjVyM3BnRURQSmZwY0xHY2QxOEFoYTYy?=
 =?utf-8?B?NGlBVGkyTEJScGY0WStYSkNkbDFoTmZaUnl2TWdFVmhiVFA0SUdTRzN2NUZU?=
 =?utf-8?B?bWdNcldnR0ovYVJMMmNQcWEvT1BCclpBL3g3MTBFRjk0bEEwNnJ4alA0YlJY?=
 =?utf-8?B?RW5IeFN1bUFBb2krRnBSeUgwNndoN2JZd2NKazNYNDBscUVWa3puYngwNk1y?=
 =?utf-8?B?ZUNzSC9YSjBxbVl1S01PdkVUeWo1S1p0bVZ2N1RmWXVIMlUrbFJydGw4M0No?=
 =?utf-8?B?QmJYM09hMGt3YzJGQlFNNW8rK085UnNGOERsMlpBK0pJREsvUjQ1eXova1ow?=
 =?utf-8?B?TkpnSXpxVWZSVi9yZXREMFhoWHlOVm1qaVpuVHFzaXRDVmJ2b2R4cCs3WmNN?=
 =?utf-8?B?aDU4K3NoVmtOdmt2S1pnL3RBUU81dHRobHFlcUNkc2NvSm1Zd0NGQUxVOVM0?=
 =?utf-8?B?T3JLd0J1eVNJRkVuZXRBKy9VSnRlSmVsa1MrQ1pJWnVpTUZPejZXZWVDaGVT?=
 =?utf-8?B?amtYT3hnUTR2bGpjUi9TUzUwbjhSMGVaeERlcmpBdmxVRmZqbXR6QlRLZk1u?=
 =?utf-8?Q?rbzTNMkZDTVYn1CrJqJ0wfEm32UWiMEaESq/gNQWPgGTB?=
X-MS-Exchange-AntiSpam-MessageData-1: mydPp4r64myQVQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf0b62c-f3bb-4d53-1d8f-08df33fcfae8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:14.5413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+53Xz+b/zO2+doomNWUZiZ7FG454S++zQUAxFxJDU+GYzyB3Gp2YA08HyedkLKmLri/eu4REdGcQUkbHqu2ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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

