Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA69CA601E
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D33281120CC;
	Fri,  9 Oct 2026 11:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="AG9o72JG";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011012.outbound.protection.outlook.com [52.101.62.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDC481120A2
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:54:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkORRAOp8fUOvtGBT0seaBECaKOZlhG2g3QAammZL5oyrGue7ayIO68IhvpnizpKWGFqYGX0URHgQhMXd1jnY1p+Bq3XNHYI546ajUHoEsBTOIvBt/NXYzAxf+pORf+R9Z9sqjyNp9DeYQnr2YpaoAzxTJSs7PG3zOxtgQ8DdbVRsf5AJawrFiAjzAHq1aMk/9zD+SvpywA5ay4vF4qId0vWfpIAO/IqMXatwV5xkw96Q46Gle9kPro0UxsTDASSjVNNZNr58q+acqKV6QvGLIaKa93sS7+G9hdTklcfTqZ7deJ/MDQAnS8dZFUqJOyi6Jl4tULA9zP/q+Ppr8rSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dnb2tovUDdH9zSLoq6/1MZq8UYqg/L1lhEsrNab0J5Y=;
 b=byHpbArQj5QkqsAzNhCgnnIHxsGUAuOHzInZ8kOWmfRB3/gY5DIo4DdM8WUpixW6ieEoAvs8CUgHOBxiGNCBGHFDkRN48a9AO5xVRGZ7iBGTjQ0YrqgOl2kGRhEHGEuSnq/hvkKvu2Dd1TS1TLsONF1/CVG1SxFMcmkDYbLzShqA+W6ku/FDBDWwXtFkoRQ84FPwJXvtirhKCBBJZ1vpFqfp0q5XbedZNYGhTch/yHWCxtSMCU2FkcrSOaxE+5oq6Rx+a1wim8cT6uLWssZC/EXlI8GXcbQm9AWBwsLaY0yR3LTHN+Vy4e8hoTKTzFtM6zmJmgjK9iUjivxFBV+UNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dnb2tovUDdH9zSLoq6/1MZq8UYqg/L1lhEsrNab0J5Y=;
 b=AG9o72JGAUMk9PmHtk5fmtJ2SBW0LI/1CI9awr9agUguKG8O59ThoC106tp2G84zNxwCRO0Je6YcU/YXPh9kdhydvJb7736NunxqkPqPrKxAqd6S+FDi59JkQkSac3kV4SCVX5IyaD10pUQLK9Z2y4djzUWgTkSGFSwUIYc3a+eP8C88aXevVdtyPBoWB2nQBbsqheDiNmEcWoNxrilJuMEhXq5UcTfKiP9pk2DSiwbhLqzbeMEPSR8U8IJXWOAjpDT3IN0SsZ+aZbc86EnzSYG4tSjKqVHBz7hWyNBekeg/XCMlFN9aL8wUYy45scSSiP8i6Xw0UTRs/5Q3XG3Uzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS2PR12MB473522.namprd12.prod.outlook.com (2603:10b6:8:400::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 11:54:34 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 11:54:33 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 09 Oct 2026 20:54:01 +0900
Subject: [PATCH v4 05/10] gpu: nova-core: gsp: cmdq: split RPC parsing part
 of the receive path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-cmdq-rpc-v4-5-c9ab8de1d3f2@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0077.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS2PR12MB473522:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cbad48-5e67-4b76-ab8a-08df25fc15ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: VJu6DLB6cMUhG/T1i3FwCUWJ0xNGhC0uv9Jo899Q2v4js3M+/8e6LJXO8LahG9AaFi60g/grrFmfCEHhkXD3NH0BI6NWflKmEQ2350grO7oqy2vvKdxR7CcusPkaAYKCjGZ5+O2lv2c4qnTGwS8WTUuaJ3VH+0v+VfmJixFhgvxynSVW2j+TnpwcN1n+CO5/btc0nje+NxDDlYP+x1VytQ8EddPgLef+35UEo5C9AaopNLQ/koT22r4U8IN4wAoDz84zZmgodfiOSpIIExc68+rCWZsqxbH13evvaHy288K4kN27wplzdoZ4NSUWNc1FaULwHHmRT3NSN13WJrFnaPr5oNICrKD9LQzOVAX5CBOArj11UhZ0Kxn7aCPFM4AOAnaN/qDZ0prTwZV1o0w0I5nnw3qGsxkBP1Lr1vLblvf66G2jQlV4AVrbvxtcX1fduzGR7rrhhvlok2WjrLQia+Hi4QPlb4AKNOykQnealkKIl48ABB1GeSmilqKPstUgLT3yrfJbaUNCOGAMV4tRJ404WcGydajsKq1cLExgeKbAGhNNmpoNlNh7ETPxuQ3xetWaxjnrIX0EIf0Gx7evxnUdxEk4BUEPsRPHCtKW1Rf0FLwlHpdGe1qFIt0VLU5OY+KDd0id5m9eqcP8/Kc1ppH+EXjoyBD6GmvoC52i5Zs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWhGTjQ3dUpGZmwwZXA2R01DRGpsNFF5b3E3UWdLYUVlOTJnZnpRZ3VmV20z?=
 =?utf-8?B?OTlBamRneGphZ0NnaVhJY0w4MlB1THQrT1dQSjhiMitJcXgydHkzcjdCeU9D?=
 =?utf-8?B?cW56QmppVlBQK0ZSRGdLd2ZjcFhtbkJnazFpNzBLeE9iVi9Dd3V0bWQzS2Zw?=
 =?utf-8?B?OWcxSDhCRk5zOE9vOWV0UlllNFh6YUxUMjBnRmE5bGkxdk5xNG9OVmJQc2s1?=
 =?utf-8?B?MGFpcFQ2aWhuT3VabVpyYUJqQ1lmeTZYUXdETUF1eFpKaUJOVUJ2Vm5wSDl2?=
 =?utf-8?B?eERhR3RGaHE5ZTZaK1ROdExzRGJPTksxTVdEeHdqU0h2U1N6N3JvL3AwcW5y?=
 =?utf-8?B?cnhIRHNzTGRYR2k2OU9uRlhHSWVrdTV0WGludVMzOVFwclFyZi9iZU5UY1ZL?=
 =?utf-8?B?UkJQeVhqTzZtWEtvbUJHZFFVbTI0NWptd1cxKzRzS3hnL2psZHdpVy9KTmha?=
 =?utf-8?B?cDM5RkZUbmxUVXVOeEQyUlpNWnBwMVpkWk9jdDlrRno0NWZ0MmFqa3FURGE2?=
 =?utf-8?B?VnNXN1N2ZnZXZ0VKNGxsRnd4NUVtbGxrcVdueTdNTVpKMnE2akdPR1FZNTFx?=
 =?utf-8?B?clIwMVZwVEJieGltTGNuc0hHc0JSMGZLZFdUSWN3dnhKM1lJN1EyWTB5YS9P?=
 =?utf-8?B?TExnTElLcVlFQUdFSUE2Wm5melNjemRtNk1OdjNqL2EvU25Rb1RuS0Rpc3c2?=
 =?utf-8?B?d1pXbTFlbmpvMHdrWmRBZytGMXkwY1htN0RPd0ovMlVnL1JIcDFUUHMyc3JN?=
 =?utf-8?B?bWVZbjhxaGVrQysyQUhtNmZMTnJTYUp6anB6VktxaWd6d3FuN1Z3M3pEMTYy?=
 =?utf-8?B?Mi8wNm50Q01jNkV1NFNvWURpZFNkWHYxdC9PcEthWXlCZVB6S2JEeE5Ca2lP?=
 =?utf-8?B?K3BwSnlJQVU0b2I3RXFDc1p3eWY4Q2xiUUxDZ3UyQUtsTjJwd283b0FmNWFz?=
 =?utf-8?B?TkY5ZmdvenE3ekZycjAvMUM3NFpWeGsyL1pYYVhWVGxKcDBXbjNBOVl6TDlK?=
 =?utf-8?B?a2xhSDErZlByRDVzSkhBU2VseG1mbXdHN3lUajVWVWZOSGtkQVplMm8xMGJ3?=
 =?utf-8?B?ZWdpeXl4bHh4d3ZuVE1KRE9GZTF5RExpWmZWdFNDSE1odkhEVTlIWk1TOWI4?=
 =?utf-8?B?N1dUQUpsci9NdWNQRzI4aDgrWVZhOU1Cbko3OFpFWE1jMkU1NllzTnBQd3lt?=
 =?utf-8?B?MCtQWjFsczJDQ3dlZW1MV1BtMW5PL25XY2RTTlBmcjl3N1RoZXhEdVdXR2t5?=
 =?utf-8?B?RVhEWThsblZCOFFkTTlTNlZ0bDJ1cUMxbkJNQm5GT1lNYVI5THI0RFlCR0E3?=
 =?utf-8?B?SkVYRExGSmZUcWl1SEpnd0UzcUJpSDJ6M3FCTTJmMFE0THFTU0E0S0M4ZnIy?=
 =?utf-8?B?VGhKVkJ5SWZKWEw2SUVKY0RmdHc4TXpzb3VIOVRwYklXYXNKTkFJWGFDNTFu?=
 =?utf-8?B?em5KSmJCWHVHVms1d0x1eUZHRWZnR1dRWXl6TFcxaHJoc2RDdFk2SjlBM0xt?=
 =?utf-8?B?L2pmQm04MEZLMzJRSWVBUEJvbEhud29vRDcycEl1clJ6R28yK3Q1eFNaT0lR?=
 =?utf-8?B?cjc4RThtbGdHTlRSWENuSW44c0R6SThtd2VrUmhDU1FoVTVvLzdZcjZvODdp?=
 =?utf-8?B?SkRYRFZHMHVzZ2JKbmhuOW5zUlZkaE9FWUVkRTFVQmk3KzlwWlQvdk1OSm1U?=
 =?utf-8?B?NlRTNkdXTC9GV0UvUjdONFowQXBqT0t1NUs3cUdSU2JJNGdYdmJidU9OUXYr?=
 =?utf-8?B?aWtBMUY0RVp4a05FN2IvZDRiYWdlaFVXZGYwcU91SnhaRFM3b3VrZDVuSk1O?=
 =?utf-8?B?UVc5MHc3QmgwRUV2QWlhb3VJZ0ZmUmk5NXZ3dzVqb2VwQlBWdHdyYm5RQWZs?=
 =?utf-8?B?cE04N1RCTEtyR2VzQk9OdlRLU1hhY1p0ZitoTURPa2ZPUjRFUno4elhRWjl5?=
 =?utf-8?B?N1E1cUpteWkxbE9xbzVhcDJScWlCbnJxZ25JQ3g0TFRtdWxRc2NvR0dCS0lt?=
 =?utf-8?B?Z281TVdHQ2lRUnNiN2dmT1gwWTlzUEhSM0VueE1GWGhGaENRNDBrNS91Nlhx?=
 =?utf-8?B?UmU1bW9PbXlTUjBac04wY1hWSTlkTDhCMk9LcUJtUVVweDFwUDFSMmV5R1ly?=
 =?utf-8?B?REFrWjZRM0RhNjNhMzdsdVRieDVXQ1k2TlVaelpRMC9OaGp2N2NmNUJMRERv?=
 =?utf-8?B?U0hNNzBBaUlpSnpRdXJmU2Nna3d0MHNlRVR3SUNmRjlFdHFsaFlQZThTaCsx?=
 =?utf-8?B?ajQ1c29CL0VHcTZMaHh0eXp5VjVieXZjOHU5RU9wRENjMmJHcWd6Q2swU21t?=
 =?utf-8?B?VUlkSVEyRUtySk4zbFVDeVEvd1RoYmtwTDdCVnloVnRZdlBFZlcyMjdjUzZB?=
 =?utf-8?Q?5F8hcE6miNLjO5jEZMIB+q8XUpTFgLRmx2TszuvLL3hga?=
X-MS-Exchange-AntiSpam-MessageData-1: nNwPkx92vJgfKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cbad48-5e67-4b76-ab8a-08df25fc15ce
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:54:33.9197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABWpKbe1oNgnCqdXlNTbnukK4AxJBimrFH9iS2ESwmNRfBh+eaC5PXXVJ20lVGMXt+SBVSSXNF65d0g2u7QvDA==
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

The RPC parsing should not be done in the same method as the transport
header parsing. Split it out and introduce a `RpcMessage` type to
indicate messages that have been successfully parsed as RPC. This makes
the code easier to move around into its new destination.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 112 ++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index dee2520d3124..2ffb8f4b2ef4 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -554,11 +554,69 @@ struct GspCommand<'a> {
 struct GspMessage<'a> {
     // Reference to the header of the message.
     header: &'a GspMsgElement,
-    // Slices to the contents of the message. The second slice is zero unless the message loops
+    // Slices to the contents of the message. The second slice is empty unless the message loops
     // over the message queue.
     contents: (&'a [u8], &'a [u8]),
 }
 
+/// A RPC message ready to be processed from the message queue.
+struct RpcMessage<'a> {
+    // Reference to the RPC header of the message.
+    header: &'a RpcMessageHeader,
+    // Slices to the contents of the message. The second slice is empty unless the message loops
+    // over the message queue.
+    contents: (&'a [u8], &'a [u8]),
+}
+
+impl<'a> RpcMessage<'a> {
+    /// Validate the RPC layer of `element` and returns its RPC header and its contents trimmed down
+    /// to the RPC payload.
+    ///
+    /// # Errors
+    ///
+    /// - `EIO` if the element is shorter than the payload length advertised by the RPC header.
+    fn parse(dev: &device::Device, element: GspMessage<'a>) -> Result<RpcMessage<'a>> {
+        let GspMessage {
+            header,
+            contents: (slice_1, slice_2),
+        } = element;
+
+        let rpc_header = header.rpc_header();
+        let payload_length = rpc_header.rpc_length();
+
+        dev_dbg!(
+            dev,
+            "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
+            rpc_header.sequence(),
+            rpc_header.function(),
+            payload_length,
+        );
+
+        // Check that the driver read area is large enough for the message.
+        if slice_1.len() + slice_2.len() < payload_length {
+            return Err(EIO);
+        }
+
+        // Cut the message slices down to the actual length of the message.
+        let (slice_1, slice_2) = if slice_1.len() > payload_length {
+            // PANIC: we checked above that `slice_1` is at least as long as `payload_length`.
+            (slice_1.split_at(payload_length).0, &slice_2[0..0])
+        } else {
+            (
+                slice_1,
+                // PANIC: we checked above that `slice_1.len() + slice_2.len()` is at least as
+                // large as `payload_length`.
+                slice_2.split_at(payload_length - slice_1.len()).0,
+            )
+        };
+
+        Ok(RpcMessage {
+            header: rpc_header,
+            contents: (slice_1, slice_2),
+        })
+    }
+}
+
 /// GSP command queue.
 ///
 /// Provides the ability to send commands and receive messages from the GSP using a shared memory
@@ -841,35 +899,6 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
             return Err(EIO);
         }
 
-        let rpc_header = header.rpc_header();
-        let payload_length = rpc_header.rpc_length();
-
-        dev_dbg!(
-            &self.dev,
-            "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
-            rpc_header.sequence(),
-            rpc_header.function(),
-            payload_length,
-        );
-
-        // Check that the driver read area is large enough for the message.
-        if slice_1.len() + slice_2.len() < payload_length {
-            return Err(EIO);
-        }
-
-        // Cut the message slices down to the actual length of the message.
-        let (slice_1, slice_2) = if slice_1.len() > payload_length {
-            // PANIC: we checked above that `slice_1` is at least as long as `payload_length`.
-            (slice_1.split_at(payload_length).0, &slice_2[0..0])
-        } else {
-            (
-                slice_1,
-                // PANIC: we checked above that `slice_1.len() + slice_2.len()` is at least as
-                // large as `payload_length`.
-                slice_2.split_at(payload_length - slice_1.len()).0,
-            )
-        };
-
         Ok(GspMessage {
             header,
             contents: (slice_1, slice_2),
@@ -897,14 +926,15 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
         Error: From<M::InitError>,
     {
         let message = self.wait_for_msg(timeout)?;
-        let rpc_header = message.header.rpc_header();
-        let function = rpc_header.function();
-        let seq = rpc_header.sequence();
+        let elem_count = u32::try_from(message.header.msg_length().div_ceil(GSP_PAGE_SIZE))?;
+        let rpc_message = RpcMessage::parse(self.dev, message)?;
+        let function = rpc_message.header.function();
 
         // An early return here would leave the read pointer on this message.
         let result = if matches!(function, Ok(f) if f == M::FUNCTION) {
-            let (cmd, contents_1) = M::Message::from_bytes_prefix(message.contents.0).ok_or(EIO)?;
-            let mut sbuffer = SBufferIter::new_reader([contents_1, message.contents.1]);
+            let (cmd, contents_1) =
+                M::Message::from_bytes_prefix(rpc_message.contents.0).ok_or(EIO)?;
+            let mut sbuffer = SBufferIter::new_reader([contents_1, rpc_message.contents.1]);
 
             M::read(cmd, &mut sbuffer)
                 .map_err(|e| e.into())
@@ -918,15 +948,13 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
                     }
                 })
         } else {
-            self.log_event(function, seq);
+            self.log_event(function, rpc_message.header.sequence());
 
             Err(ENOMSG)
         };
 
         // Advance the read pointer past this message.
-        self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
-            message.header.msg_length().div_ceil(GSP_PAGE_SIZE),
-        )?);
+        self.gsp_mem.advance_cpu_read_ptr(elem_count);
 
         result
     }
@@ -1008,9 +1036,9 @@ fn drain(&mut self) -> Result {
                     dev_err!(&self.dev, "GSP drain: message length overflow\n");
                     EIO
                 })?;
-            let rpc_header = msg.header.rpc_header();
-            let function = rpc_header.function();
-            let seq = rpc_header.sequence();
+            let rpc_msg = RpcMessage::parse(self.dev, msg)?;
+            let function = rpc_msg.header.function();
+            let seq = rpc_msg.header.sequence();
 
             self.gsp_mem.advance_cpu_read_ptr(pages);
             self.log_event(function, seq);

-- 
2.56.0

