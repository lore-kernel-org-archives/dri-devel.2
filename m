Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD03CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5AB1120A2;
	Fri,  9 Oct 2026 11:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="smcbGl3C";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1839E1120A9
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avOFDm9BIsN2HN5d5+luJmrz/usF4rGaRi5YeL+U9lZHWWrhyt3HjlAGSymo4tT6us/g45zwZj8zGC11NiXGtxTklD0NAsVxa+/ljNeaMTZ9ahUxxCvbhpvn+GsELwpMf613ylQ+g8cDFeCVmczgrGCLK+GqgLzH89AZZ4y3WOvpvux1iNK0Rei0ubqOctfOeHwYSwgs0kMKmt9pGmmTZyIBEmRG+g//qltQR8Z3UlLLFx3mc/3uBmpcSrF55RHhNW6yfzf5cEuJODenPgGa8ODzdM5pHH+YmtF83Q6ymAMZFUVtNdYFwWDudNICa+8VdpK/e6gMkmQCGzF/I7AmCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c29dztPHTBdywze5C+qaNSDOV9BdAxqDSIybslhtK8o=;
 b=nEGIyh3bkgJ88rwSrST94XE/FLAdcOYBCKczxfUgoOs6A5vizS37HGLgKPcZkquBkTv6V79DquTjL+TBS9YfA6t/hQUr/dPEP2hs9wYF5cZ9YIRnJ3EeVRDBTG/H+OGO0ejSkQG8JHY2xUBP3JYS1u9n2a7WqsA+/hpK9JOkpMoYzhMVByslcFkATP2XSXwGuS7nTZVz8GdLNdfqEVzAYmo86nLPZDY0x6R1d5JKUheEjlj7UQ8EyTYD/nCVCEit0BxrX6xCOAmMKEBQnG1HwigNwp7nTb6lsGXLNgpWcQzbvhwiRBBAAGRn5X6KkBLLo18MpbPI3n5rBvh7uJC5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c29dztPHTBdywze5C+qaNSDOV9BdAxqDSIybslhtK8o=;
 b=smcbGl3C+CYzSPr623rF6uGQHuhg/eXhwsOOFud/XB9ve9ahMBDN+Fhbo/o1acIQX+93yo53qaniE7Ny6rSa16/sgNQ32L/W/dDVxpZBJpnqTVYuSMrkVwapWsnXPra8Bn3/zjcSe/WXMcvTgxLnU63/nCXvQpdiFy5t366kjlurkzRcRh7sRsCf8JySxbZcWo61Qf9KJnJZPyezGfca4jCRa7wsG14cADF2Kw4/z6dLkp3fayp2qb9X7DnmM4e2qj5hwuFz2Olh3cuSGAq7pdroLygH1DFmCQJlNJQSbCe5yrxnWh6WPemH3akHiKOtpCRmrehuukVwb8JIrZnrlg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB473522.namprd12.prod.outlook.com (2603:10b6:8:400::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 11:54:37 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 11:54:37 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 09 Oct 2026 20:54:02 +0900
Subject: [PATCH v4 06/10] gpu: nova-core: gsp: cmdq: move RPC message
 logging to RpcMessage
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-cmdq-rpc-v4-6-c9ab8de1d3f2@nvidia.com>
References: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
In-Reply-To: <20261009-cmdq-rpc-v4-0-c9ab8de1d3f2@nvidia.com>
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
X-ClientProxiedBy: OS7PR01CA0083.jpnprd01.prod.outlook.com
 (2603:1096:604:25b::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB473522:EE_
X-MS-Office365-Filtering-Correlation-Id: 228e5a75-65e2-4003-1dd2-08df25fc181f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|5023799004|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: dKDSUiV4i6anumPFuhXqXkGVVMxv416uqmeWVagF4btTst4HzizYJXN0PVV24o6SPO33dri9PfcckrwYBEycE1t1QrJzLPYvVdncD7NW4+eJFW5oqsXQzN/I90yqI54XsbeXpw+smx9fKgr3L7WibfH2H8kOEPZjnz0wAl8guv7umx9+vokakfUFVuvkOpPKAI8MoKA2Hnkl6LNvdG6S3VXANyhA73igWVz6oSStAbJ2FxyyXEgXQpydoKPB38STsqz+8gkJhS6EIiedtyJy4Off+XxX/rUAIQQQcr5YTMTDXE4GVEobwD4gdhlhTVfnXD5ZT9dveCrCBeeMmzvN4kXm1Nl4B7jUwDTKbIgSz3Qyv2/QEmv+QjVct79Sfr+SUaHFky3M+jBKAqt1ca/3EzRLOtSMdXvBuQ2j8oLZZTaqrcSeo2JFYx3xTQ3R1prDiIywtHozSMB7ezDYvH3Y8NffEAU7UNd/qeN58mcYSNIgcRJjeSzQrluktgq9s/6BQ2yJt54C2d5+Yk++a4aTjx3uMzf8nSGb1hXkEM0upiJI7vv7bx6SgO3DamkRj+dQDs6qz/g3CicR2b+WTXvYtm9yWBVxRCmuf/SjJ0IRZCyp4t5RyoFat3nXlyAw5W9XAZ9+6BQ50BjWCBz5PW0nZqt8s30tY4PkjmqN59Z/uso=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(5023799004)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUhUck50c285Q014VnlFT3ZDVmVrYUl3NVNPc0hDUkdqZERPb2dkVmdpT0lP?=
 =?utf-8?B?clNwUFdSTmJzL24yTmNhemxiRVNKQy9YL2tCbUNFRm1acHpDajc4RDI5TUVt?=
 =?utf-8?B?NytDSlhseGNqU29Pc2h1ZHBMb1phUE45VnRWWnBjay9Oc3MzOVNRbUsyWHhk?=
 =?utf-8?B?MHd2V3czU1phMDhnMEx5WDVhTnVzU3lqTGdvU2t4V3c4ajRhN2h3TmtnVEhJ?=
 =?utf-8?B?c0ZVWVN2TTVGNzI5anJMT0tpaHNGOE5OallPTy8rSERESkNpL1liY1k2bFFz?=
 =?utf-8?B?c1kzSmpYTGVwcXFoWTdVRzYwWFZIV1dQRFVZdk1ZbzZ0TmNIekpzTEEwUWdI?=
 =?utf-8?B?aE1qZXRFR2RVUnBzdGJ0cHdUY1BOV1ZpYXQweWgwWGIvK0FDeGhvY0pkSng5?=
 =?utf-8?B?VnBPYlowcDBBS3BDZGNEV2Y2SjlCMjM0ejdEMnRqU2xLMjdhQnNIYUppb0ll?=
 =?utf-8?B?cXVHYjlEeTROL2hCN0V1UnVYb1BDdnBrYm9UTmtJV0FRdE9qeHkreXNWUDN5?=
 =?utf-8?B?S3lnSUJSbkllZ1NZdnhQZFVIRmlLQWg0UlJZQXpWdGJ5WDVRM1VxS3FmVEhq?=
 =?utf-8?B?SWpjOFZ3YVVja3h0WXJRc2h6VGZjTGtUemlhTkNPNGg2RU1QZStFWnQ0T09l?=
 =?utf-8?B?UnA5TitlZUVndmh2L1dtTVduUEJFMUF5S0VuNGpGbXpXenpHcnFiTWxuVTZT?=
 =?utf-8?B?T1ZXQWRIS2dENEhRU21vdnIyeUNMdjNWYWgwSGJkK0xMSDFiRW1mRTUyYWxG?=
 =?utf-8?B?NXpza0hLSTF4NTBad3YwVURoYU9lOFdsNzVxM21seFRZcitWSVF4WDFZLzlR?=
 =?utf-8?B?VVoxTnk5d1VwbmsrdjgyaFJSeHVpZU1lMVFMSmFCN0g3SG1lclpRbk9PMnlL?=
 =?utf-8?B?R254RE1UdFFOeGR2NzE4S3NyRGNXdkRWWGxhT3pxSHpNbWRPMWkyV1F2WWJq?=
 =?utf-8?B?YnpyY2ttS2JEcVJsUkJrNzZvd2pNK3NnOG5pY1hwdjhwN1lCMTdMaE1rQmp5?=
 =?utf-8?B?cjk5aE1mN2VPQTZ1ZGoyZCtKSVcyOFN1TC9sSzljNFM0SXFaNXZYOFRJcXg0?=
 =?utf-8?B?ZkZRN3JaSEFZOUh5cksvZHJ5WmhXOVdYTzhoZXA0L2NnUkJsMmE2Y2FsMUYy?=
 =?utf-8?B?bnVSNDU3OU5uVHJrL3VnbTV1ZjVBT3hEK3B5NDJhcVB6aGp6MWRVck1Ccnpa?=
 =?utf-8?B?NGhKZ3NCSC9zdXpmeGpwMG5rTCs2UFM4eGF6YktHRnpvZ1ZZV0dIL1V6a3Y0?=
 =?utf-8?B?S0RyRzd3QlpUalJZK0t0Y0UydGNWYlJ5VUk4NjBLUTA4eStjcERVWE9oclky?=
 =?utf-8?B?NlZXdXplcXp2M05BSFFNTllraXpxRFhEMTdxbDE2TTZiRlBjNkYvSjRoM0xy?=
 =?utf-8?B?V3hKZHlmNUVZeWR5c0RLQk05WFc2ak1DZGxrUmtRaFJPMTRyOGUwQnpLUmIx?=
 =?utf-8?B?TEE1N3VaZ2hkQ014bDF0L1VEQmI1UlVXekRVbWRnQWI2S0RIbHJJcTRhVjFt?=
 =?utf-8?B?OUNmdHFYbEVLN3B5NCtCWXNVN0lNcStUTW9NZlVYZ0hBUFJOaVN0MFNqQXZm?=
 =?utf-8?B?UXNnMUo1SWo5ZExTYkVqQUs0Q2NERzJKdzBMN0lJaTdNZ2c0bmJPeVBpT0pk?=
 =?utf-8?B?MHpTLzlOWHp4cFFwQTg4emx6SFJqUGlwUXRZQkhBSVc4K0FzbURXdWVUSytO?=
 =?utf-8?B?ZlFqUHREaW8zLzIrMHl3ZHI5eW5VbGNBczBZNGJEMzBxSEswT3RPUi9TbEtl?=
 =?utf-8?B?dldWQU9NVzJtOEhWWi9OYkRkenZMejliM01NeDducjVGeHZUdWUvd1B0Skcv?=
 =?utf-8?B?K3pzdS9TT081YTVLUUU4aWYzZGFNQVU3TFRiOFVtK2tsRnV1R0JiUjI3R0cz?=
 =?utf-8?B?RXRxUkZnYkxtdmcyd0lXd1U0ZS9WZDlwYkhpMDdGdEt2UWt3UnNYOElkR29t?=
 =?utf-8?B?cW9DbVE1RFN5TSsyQ2x0WlNlbG5MeURJOC9OK2J0YzJKUkF4WjIwTjNZKytx?=
 =?utf-8?B?M3RpZ0Y5NU81QlJRWlVLcUt3aXpXVE9JUGwzSG1PTTlNbWZpVWM1TE0zRnVu?=
 =?utf-8?B?bWxSRWxsMUVhSEJCTmZDMzNudWpVZEhsY3lMRzZsZVhoVGN1WTYzdEVhVmxX?=
 =?utf-8?B?M3JNWEVSYlZvRGVpbms0QUw1UitZd3ErazJ1NVVmbGdKdk1BZWY1SDZ3Ykdw?=
 =?utf-8?B?TG1BNEpnc05JQWhxcDAyMWlFMlQ4bzdRb1c4VzFkK0RzSWZRVjlPUW9sR2tK?=
 =?utf-8?B?R21aaENPV3pybkhsQkhWYjNHQklMZU5ZUWhuODcvVXZLZUsxQjY1MHF6cFRB?=
 =?utf-8?B?Y25aQ2E2Nk42YnVOejZFeHExUUxEZkpDUnFibW9jaSs4M2laY2hQZjlkTk1i?=
 =?utf-8?Q?YqRS97XL0qAx8zQKN7Yo548mlVSYTHIOpwvyXhB/S6M/F?=
X-MS-Exchange-AntiSpam-MessageData-1: F/hlRRH0FAWjlA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228e5a75-65e2-4003-1dd2-08df25fc181f
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:54:37.7745 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKT2OkKLU2YW+z/+sLoORc5djkRof5c+3UlLAy20O9MqxGjQVpvTZbyABoykAuRfhEHkyjCKE7SqhVoE0tLReg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB473522
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

The `RpcMessage` type is the right container for the `log_event` method,
since it contains all the data we passed to it. Move it there so callers
don't need to extract the required data themselves.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 66 ++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 2ffb8f4b2ef4..a059ce74ba2d 100644
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
@@ -948,7 +976,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
                     }
                 })
         } else {
-            self.log_event(function, rpc_message.header.sequence());
+            rpc_message.log(self.dev);
 
             Err(ENOMSG)
         };
@@ -990,36 +1018,6 @@ fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
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
@@ -1036,12 +1034,10 @@ fn drain(&mut self) -> Result {
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

