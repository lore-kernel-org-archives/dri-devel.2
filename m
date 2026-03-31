Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C41FF60DC
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 07:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 643EB10E8F8;
	Tue, 31 Mar 2026 07:57:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="sQk6gJJ2";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8823C10E8F8
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 07:57:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p91WIAK5cVpTIrLlzgI6lfLLU5vFoNNpbsknUpdsE+jDcE8kaNVWxZpw5WGbPaNhsVNX+fed2JWaLUlSYF1WTBPGR+vM+bez2mu2Gg7l5HNTXblm7xx8ZbIHrhOSuNN/ssqYe/xHWKaNguBeyryuRJ5E/mMoMOA/L+v9L+P6fi1B2XxuiLVSIdu25P7WlOluso6vqd9tp6XTTYegJKgW1aYZ+SefRnThwYUmmyN/dkDKgMSWvTSm1cxhrp7Jt68UFPtJAoZwOzEdOEcxseDq8nmbj8qH38k7xyBbIbya2oIGaUWAzuvzBxcWD/fHzjCXitZ7mF1+LHlk4otTNnC6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crUPzl6fAvXIHdxKLwBRQm541CAT3dOa5Q92Pj+CJWw=;
 b=JaeFERk68a/LS0PFDXSxu26AjGzBVKWKWji6GpCIrNvlU1vhBdpzZ6GiHAtQw5z4EOLG9TNLq1HT0iQa1F2+HhhvQVYXID3rj8ueBxuSQXAnUOVJrm3iki8+SyKpQuQARuR6rgwaZHXGpq6B3cGoRlhowdlCjrzs37Sl06gtE1U3FO7vJLmmKEl7LLG3vnU7nJnNuZTZ2I9kaV6jdVcxCcCqbggXqTbcy4aiMZADhpiuH7/CRZlwwCuYZao5ZUipae/4xIAB5RNIevw5/oN+/jwyeFwMOqmmj+MGdwbXkPizC9GkEeLTO6+LxzyDDtk6vmiCm32RnAQ7iQnu7vG+aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crUPzl6fAvXIHdxKLwBRQm541CAT3dOa5Q92Pj+CJWw=;
 b=sQk6gJJ2cEL94RMWlDKGNEZ+ESxxz6KPM9U907Ei25sw88Byapub8ZjW3484155miaVPSd/9MIB+9hTGGHZ9oGDlnRutuC/Znq3JXN1c7T+f69mWGP/1LNW9XDZn1Miga85znFIDSpDohJTdCbcotXXLbsqEZk7gqraSPDuMF36BURMvQKooRLiTCsJgEWu18qr4bG7LOcJ/YnfkYLaOaTalUaYwPhMFQWFy6BT1LXTj6Eh/VtMJv8p/gdUSnKCtQPGdLLjlISfDYjTy2t4qLm8oFV/Iw0OqSua7Vjobbi1QDBh6DLVQLudgP6GC+2cZHABKrlvDWwHdUrpUnEwwbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MN0PR12MB5980.namprd12.prod.outlook.com (2603:10b6:208:37f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 31 Mar
 2026 07:57:19 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 07:57:19 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 31 Mar 2026 16:56:28 +0900
Subject: [PATCH] gpu: nova-core: bitfield: fix broken Default
 implementation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-fix-bitfield-v1-1-ebe1a72b4fae@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBCF4avIrBNGhaCuEi1Sx5qICq0Iortnt
 fx4vP+CRJEpQS0uiHRw4mXOUIUAN3RzT5J9NmjUJRqjZOBTWt4C0+RlhyaUXtmKECFf1kh5/3J
 N+zvtdiS3vQ247weCXFL+cAAAAA==
X-Change-ID: 20260331-fix-bitfield-a03f6d1b9e00
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.0
X-ClientProxiedBy: TYCP286CA0247.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MN0PR12MB5980:EE_
X-MS-Office365-Filtering-Correlation-Id: d36c7c2a-4a9c-4066-485e-08de8efb21fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: tRWUaKVNixLPZfXYc0l79eT7QciXVajnBUYFB6IVE8MZhtBdcT7LPpgJQ9WI03z1P6sKN6rootGw8xsPDseghpyXQSOpZhjdH5DDUEi0lE0cF2bH4g5K0Ir/Wpe60jSKc0YiCi67wxbTbcgRPja4jdXW00qkiWC6+Yt0yuFOzz6KeEMS8rhGRhnqItrUgQ/4WFMDZ0V0An2pRNR6emjbcENxtD71kFu5/x6VCXkNnB5U2EApGESzL4gBXmCdCMhNXZHdOyn9SDvthaD+Y1btAucF6nCZltKIrEDgzm8BfFBSxOKyIw/7NPmkNFcsSyqwcucmbQ4uqm34yCSBfuwjpFh1+X1Z8b8eC/oHEzXjMkXRsOAUguv+COLhna8X+dQOqpZU6T0v/jV6Nyc7eqQqTVhApaZfWQ11Yz/bVIhSWRrrXhyrZpHY0gq8g4xhVTAGTBd7gT9S7oHYr400pykctOaZR2IpAb3/GlR9TCia8YtmLebFlYtq6sRvKEbvARiIZaYyyaPp/ZaV0q3EGSNsRkdhB+VMZ1tDDvOF67qCTiv5sqQEjF4BS9OsIOqD+iYRmqgrVHN6i7aJfWVsMuFlJXtzM2nuqq/mm8G0fDAY/pxxV91ZfrQ/8qeuYKlUqImLE7SV/Ls23BEeju30b7rMpBPRDjie4loaHQndS8I1jk6WDJmp+9wbGaMsK0IO69dOqzWP129fdiw2ct5o15EmK9IOTMOu6yVCGks/txtUYHg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXhxR1FkK1hybUQvaXNFT0h2bVo4K3dXUHRRVnF2TUpuNGNjZlNTN1llZ0xW?=
 =?utf-8?B?ekJndWxHRzZnRWxsT1FVcFRoRGNUWFVTSFlLbm1YT0lGSm9JVCtTd3FkK1hD?=
 =?utf-8?B?NEhzWXBidG5Wc2JHbVRXOUFZZ0YyWEszTVpyTUpWa2I3a25rT1NzOXllcjVn?=
 =?utf-8?B?UmlTd1J2SG40VUdCZjVrQTY2WUdNUUFNVnFPUFlFcTV4bXcxZ3RHaHlQMkNL?=
 =?utf-8?B?bkE1SVFVd0pWK28zRGVDMkFyak9ER3ZaeVBWRTN1U0ZTWWxGMTRlRlhNTWo4?=
 =?utf-8?B?bnNzZFY5bEhrTDg0MkxBNTNWZlNvaW9HL2pmZkdxVlJJMEZNS3RVSUtobHhJ?=
 =?utf-8?B?c254V3N0TEE3WTZrOHNRdUxNS1JvQ2Q5UDRBV29NMERuRVQ4TXpQSVhlblo3?=
 =?utf-8?B?UmJSSkJuL2lVbTRWM2N4QzYzVEZLU2FUMkFyamNwKzhxc05IOGlHS1BqSDl4?=
 =?utf-8?B?VStPSGxldVZVdmgyYmxZVXRQYnpaakNicnRlNW5PTTVTUHVzS0ZYQzkyT0F0?=
 =?utf-8?B?TG93UDhQWVhZd3l5WmsrTHBFSDc3QTJmTWFHd0h3Q01BU2xWR0E3cmZBYzlY?=
 =?utf-8?B?ZjI1NmNQUE1EL3VxUkI2d2kyVjNTUnFjMkI2M1hWOWRsU0JzS2J1dzdZM2p5?=
 =?utf-8?B?ZXhVWHdkOVo2dnp4dUZaMUJ1NjNvQnlJb2VUYnlNUC9OL0FEOUl4MVN4L2w2?=
 =?utf-8?B?M0kwRERDZGtBcDBhakFkQ3pLWlNleTBHWTdSNCtIQ2NyZDBZL1MwdVJGcTM3?=
 =?utf-8?B?OG9Mdm9zTDMvTVhjNVdXeTRudDBoVGhKUXV6aHM3V2d0b1N5OHQyVGNPSzUw?=
 =?utf-8?B?YlFHanJ5dEJ1Y2JFRXpIVzF6L0s5UUJONlF6Y2YyMlJzdWd3TmJ3VExndlVs?=
 =?utf-8?B?ZGx5VW1VMUxDUGhreE1rbUFHeEprUlJyS0M4aWtLVjR6MmFsZDFxV29tbUt0?=
 =?utf-8?B?cGFvMFpxTGdJQ1B5bTdWVmdHdmw5L1NleDFTMEpoRTgxUVQ3NUU2ajI1WDJs?=
 =?utf-8?B?RXYxc2pJdEMxWDIxVXU2aFEzWkhKSEIybGxwOGVlNVhEY3ZCbDZBZ3p5Ymdn?=
 =?utf-8?B?MXRQMitVVFR6VG1MNWhnVloraiswRmt2SnJ2elRkUjRqT0FaM1hkUzhVOVRa?=
 =?utf-8?B?U05RbkRXcFRBVURXczArZXYydVZpUXQ1cmR6TjJ0djBpZThSbUdUaVo2R05X?=
 =?utf-8?B?U1V1dksrcVZVMEFpZklJZVpUYXM5UVRmT3BqSTlZR1NHTHNRSUM4Tm5Fbno4?=
 =?utf-8?B?bXRWdXpFM01sNkoyTEJ4TVFFcWtDODl0YlZwcUJvc1Fla3QxZXVMZit2Q1RF?=
 =?utf-8?B?Tis0SVNLRitnVldhSTc1Wmx6OWRHbHVIczlZNEwrUEEwS1Y5anFWMTIxNDdo?=
 =?utf-8?B?MVJwZFh2RkpJY1RNSWVLWEJKYjJWdnpuclN2MFM5dmhFR1ZNbnkxQjVWL0ow?=
 =?utf-8?B?bGRKN2lmZmZURVZyd1BjVi8ya1N5U3V5eGpQUjlhTTBaTFpPS01PMkQzSzIv?=
 =?utf-8?B?SlhHZEFXNThXanRPTFBxTlIrajU4bE5OQklhVkJhUUsxTjVhSlZBVWNQblBX?=
 =?utf-8?B?MjJya2VPcyszZlB6dURWUFJEZnZqL1c4SDFiblBRUzhXMXpMZVUxbnBpZVRo?=
 =?utf-8?B?V2ZPdGcrNlRSTlJMcFc3ckpIUFdLR2djWk9UcnFnWEJ2WHBZS1JENEZQUzJa?=
 =?utf-8?B?VExZYlA2a2EyODU1L1Q3TndiQmlnZFZ6TzBjWFowd2tsZFlIalpWTGk4Yk9v?=
 =?utf-8?B?M0pxNy9sc1k4NnMvdG1BVzlXdTlrNVNzY3A0QkJkclJGMklKNnJRWjdBa3c5?=
 =?utf-8?B?N3A3Q1dVdyt3TjNvVld4OUFOUjFEWTFiLzJyczl3MUl5QjMwc0VZYkxrZjBr?=
 =?utf-8?B?VHJxbmdEQmZuUEx0cnZ6dVg1eFlwK0lhNTJVOGIra21lMkh3S1lJQk5BeTIv?=
 =?utf-8?B?c1IwMHYrS0M3WDkxdnJ6RVloSUNDdWhGTWtZR2IwSHU4azRGQjJBeVpwMmNQ?=
 =?utf-8?B?MGNvZXhjdm1mNWtoYnZJamlQSkE4aW5FRlBldzFZbitGYmpTNlJvRE5oMXpu?=
 =?utf-8?B?bnZGR0FlOEtSV1JsOHB4OGhhL3Y5by85OUVqZU5ITm9pcUcxUC94aEs4enVs?=
 =?utf-8?B?V0J5dkxDZ0hLMCtpRnVUTFY4ZzdTNEoxekpINVpRV0VIZCs0R1ZOQ2Rudmo5?=
 =?utf-8?B?cmlFeUFWRzQ5ZFFQeFRPSENOMWtIdjFKcjdwbzJOSUtWZ3ErMWhSZjQwVlY4?=
 =?utf-8?B?N2pHOUcyMmtLSXM2TmN3dnVyelFtaSswTkltVjA5UEtiY1Ezd01zaGlPS1RJ?=
 =?utf-8?B?TGRsZTBKZEdWOXJpY001WWNQcENuQnhlZE5Ha0dIVUVYUDdKNmswakZiMm9R?=
 =?utf-8?Q?n8kDm8P++7X/XBk77SB6cjmy9N4MpIMDZA6MyXGLT5D/S?=
X-MS-Exchange-AntiSpam-MessageData-1: XWtbdHhQ6pC/SQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36c7c2a-4a9c-4066-485e-08de8efb21fd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 07:57:19.2664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GaVTJDnNrd5KjBdJeLFcqa3unzBdEpDKxyiEwCG0H2U9oOpDgvJYlbPSeI6bq2pXmDKjCa/ho7vFQ9hipgB21A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980
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

The current implementation does not actually set the default values for
the fields in the bitfield. Set it and add a test.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
It doesn't actually set the default values for each field. I know that
bitfields are being moved soon, so maybe this fix is unnecessary but I
saw it and it's a simple fix.
---
 drivers/gpu/nova-core/bitfield.rs | 50 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/bitfield.rs b/drivers/gpu/nova-core/bitfield.rs
index 16e143658c51..22d68fc21a1f 100644
--- a/drivers/gpu/nova-core/bitfield.rs
+++ b/drivers/gpu/nova-core/bitfield.rs
@@ -4,6 +4,8 @@
 //!
 //! Support for defining bitfields in Rust structures. Also used by the [`register!`] macro.
 
+use kernel::prelude::*;
+
 /// Defines a struct with accessors to access bits within an inner unsigned integer.
 ///
 /// # Syntax
@@ -314,12 +316,11 @@ fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
         /// Returns a value for the bitfield where all fields are set to their default value.
         impl ::core::default::Default for $name {
             fn default() -> Self {
-                #[allow(unused_mut)]
-                let mut value = Self(Default::default());
+                let value = Self(Default::default());
 
                 ::kernel::macros::paste!(
                 $(
-                value.[<set_ $field>](Default::default());
+                let value = value.[<set_ $field>](Default::default());
                 )*
                 );
 
@@ -328,3 +329,46 @@ fn default() -> Self {
         }
     };
 }
+
+#[kunit_tests(nova_core_bitfield)]
+mod tests {
+    use super::*;
+
+    #[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
+    enum State {
+        Inactive = 0,
+        #[default]
+        Active = 1,
+    }
+
+    impl From<bool> for State {
+        fn from(value: bool) -> Self {
+            if value {
+                State::Active
+            } else {
+                State::Inactive
+            }
+        }
+    }
+
+    impl From<State> for bool {
+        fn from(state: State) -> bool {
+            match state {
+                State::Inactive => false,
+                State::Active => true,
+            }
+        }
+    }
+
+    bitfield! {
+        struct TestBitfield(u32) {
+            0:0 state as bool => State;
+        }
+    }
+
+    #[test]
+    fn default_impl() -> Result {
+        assert_eq!(TestBitfield::default().state(), State::Active);
+        Ok(())
+    }
+}

---
base-commit: 7c50d748b4a635bc39802ea3f6b120e66b1b9067
change-id: 20260331-fix-bitfield-a03f6d1b9e00

Best regards,
--  
Eliot Courtney <ecourtney@nvidia.com>

