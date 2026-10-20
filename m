Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B9960A2600
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=AlK4bMnX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD84410F499;
	Tue, 20 Oct 2026 10:09:13 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010005.outbound.protection.outlook.com [52.101.61.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEBCC10F48F
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:09:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZlBIu3fs6GRzDOg/kof2vd0MFGRTQvYebcjYX5qN96ZH18Cpn1R4d8wNqZV8gslVrWYipwmVrZbHLqpJGNwNxsOJgaxXPjIsqKs7I6AO/o/Mhcuk2GBJYQwM7ix1y+8y5gaootD1OW+zy/g41IAS9glV3FBNgXmNnA/s6+PWDL18F9V4eD7njdR+Rc+zpggwRyc0SaR35LL/mqg621jWu3Ho64s2tYaSMM9DRTcWjMqLlKS75xaezEux3mQa/lad/w5M3qQNCtFw5gL9xQ8L4sG/LYpGVV74jEzWSX0gPN7IhN3ReKO8NWjDIZ4X8o4xPMk44HwtcR/FDlDz+46EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv0Ch1LppCYiv3p0gJ36zBRbMRSGsiA4S/0fELGP9rk=;
 b=a41Wt2ybxMh3fZm/vK7WXyLx+KfLVh8/oMToVfqnlP0jfxcSJ4Q1CMVQGzrC05uW+HaqO5i3eJEGAS3LBnyTZVB2fZmzij78KXdIs8MtkectVCqEvsc0cr812ps//mw5S2UhV1Mv/QH6iD16fEDFsOaM8qidoMPfazbk/tlvKve38ucEXP2vde2LjddLirlDCFw6QX0pKqpZhDhJpMbVowGNghT5BqhTlpFKWhoH/IcVODnk0y7YPqZo6p5P8HPafCOxLXwDt5RHXSrUycYiIPbYtHM643H0gP92tWuDyVF7nyQc3sPFt09VTcpZQxD/H4BdkqaVZTW5UzMZcofxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv0Ch1LppCYiv3p0gJ36zBRbMRSGsiA4S/0fELGP9rk=;
 b=AlK4bMnXs2H78CKdbnfzDIPVuR/V74bPvk9DIlrKvlPO7k9IX3/XG9tiqiCQn/kDDEXWXkEUNFK1srLcnBdLaXOP6Y53IW1+6Y7SIZFQacCZFHv6Yg2SM/2TbMIfSjwWmq5DWidlozh5AIRyopUxkAQViMOmSTD4eRHV6A3LOcU3ypxXwvjkG86DpcXJ/kmIxcYNImlZDm282ZWlcfWuPeizNzt/xXuxocmY4ginVj71IPlucwg3X2UzR1YXODvvWr+1KsI6HwDcM9IfBzfALBb0y36vx5LoVAzDyIclVpTJ3UlUYp2bghxc1pDzu2uyKZMcL5+X/uGfhklz2NHReQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:08:50 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:08:50 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:28 +0900
Subject: [PATCH v5 07/14] gpu: nova-core: gsp: cmdq: split RPC parsing part
 of the receive path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-7-dceeb8f360ec@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0059.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: d25946ba-1a1d-4178-f3c6-08df2e922371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|18002099003|22082099003|10067099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4//o5YH35l23Jrzi5xrcPoK/XHVu9RBlNEGlH4+Jlawike+5pjkgVbF8qwyS59yYK8aol2rj0qXflX1VmHLRlDiiPcnizMJNI1DLZ4UFO04ItV6SKkYHhGneVLzmjBYH+Jr3YbPRVSm8tKVVjNaNJQ5yPqKmNuubSD+4FIkv03MaBe9YIDMHD0Fk4oMdK+/puPokY8xHJ3CWdiZBCqwdYmQRyx2VGdocCcgbVV1C56uoWjOJCLFlWurwFryAtmwWc8KG29TD+nZNbR5CB3pt2kE1Q2yLShtEbkhoj7OwRV3uHNPBmqq1XpemNLpVs5A7PP3qJmzVZUAVjS9SgHe28JgyUQsUWswy2XK2G5B1PkIg3TKS8lHLXx1v+C38C2++B/mlE9Q/N95AJiBO30fcX7qWQBzz4qfCtOssxLWgLZE2k1Dl74C7PSVU1aM001RBYF1Vj5u+ZXrxlhsrRzzOBk+xivrCu7flH19+SV/BsdKJT6GMdB0giJxiWwGDWMvPPyDlIuyMMdMbTNabJg/B/PSQFwX7imgalz4DuCb0NmwyoepBJVkw/8vv2T3ZevyYwcq58PN0jmOWxAFpHhXhM6XVxUDjqlhPfBsT4xlMuXM2GygBXWk6fBqnUyAgFdT0ud09WDUQX3DfH2Q3HS44d4c3/YKozHuaALpZqOUbx70=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWY4RVlqTVJ6U3ordVNLSDFTYlJUemNMUmVaUEwrb2kwZGtTL2Ewa1FyVVBF?=
 =?utf-8?B?T2dZU0hDd3BDMXlITlpIQVM1MHU2VlhxdDdXUmlLUk92OE5QZEZPV2dWWnFY?=
 =?utf-8?B?N3hWUElFekFHbVE3eTdKU3FwM29KdjFuTEUwaDhEbjJaZy8zTFlqUEJDcnFl?=
 =?utf-8?B?ZXdVRW5jcXNmcVhhUGw4eDBhTGFyU3diTjRBZkQ3RUg1U2VnNWFXcml1UCs2?=
 =?utf-8?B?MTN1TDl2NEdyLzg4MFVOWHd2RFB5L2dSaXhDUkhYdjdtNU4xQWd3YlpEbE1k?=
 =?utf-8?B?WmFHalZwU2krSW1tRUtQc1pnNjdmZXZkOHpORmt2MTM1SjE2TStrT01majNH?=
 =?utf-8?B?Z3VqZHV6T2VPQkVLVUVRemUvamxzejRPaUZMUGErRy81dlRVaEpINk9Qbmtn?=
 =?utf-8?B?WWcyeHVlZ2pDNjZDaWJTU1g1RHpFYXk4TjNYNVU5Sk5EOFBBV1k3RDRJWHNn?=
 =?utf-8?B?RW9udWlsQzJEdlNtRFVucXlCUFFRK0cwcW8zUHZZb2ZnVm5QV1BxSjF5dW5D?=
 =?utf-8?B?M0VFcC9yTlB2V1pzZXByRzBGcUxtbFZZVnNMMTRHUXNGMWwzVlMxQnhFVUxC?=
 =?utf-8?B?cThzZUZ2OU9qTXVEbjlUekZ5MS9POUxra2V3TkVXRVZHUDZNVDZrRklNYklw?=
 =?utf-8?B?MmdjSytFL0x6SFNaWkM4aElkVVRDa29pWU9JQmE0cTdlc3VYRkJSc1pkd1lj?=
 =?utf-8?B?MW5hUjZRRElEWi9kWGZLRHpZSDd1OWZIMStZamRiQmVhWERIbm1MVW01ZGJO?=
 =?utf-8?B?UE1ZTmpQVXE4bGR6aS9QY3RPU0UyckRCOXNLVlZqbVA2L3cxbko2RllXNnRC?=
 =?utf-8?B?NjFNNHE1QzA1aEUzOXZLS3RkUVdoY0pLTEl4eFhVZ29yd040ZGdkYzVvZ2gv?=
 =?utf-8?B?U2hnVE94SEVtQmRRejlGZlVOLzdxSGxpb0s4RDJRQWNuVUZuM0pKSWRZSXNU?=
 =?utf-8?B?NUVSQ1gzRVpLUkl5UENLMGFoUW1Dbm5rb0c1dERjWVJoMFErREltNEFYdkFF?=
 =?utf-8?B?RnVmaG1iU0oxaUpPY1orc1U0WktqcDJZNEZpU1h0bGlNdlZKazBSYmorZXgw?=
 =?utf-8?B?WkE2WklBekNFR0pRdnliR1VmSlFoMDg3RE8zd3hoa2VzUld3TzFyZWtXVWl3?=
 =?utf-8?B?a3IrUjI0QUJ2a1VmYmE1YWZyZ0kwczlDZWVseHJKNkwvelMvclF3RTY3aTVq?=
 =?utf-8?B?UnIvVm5QczRFVndUYVIxYUJLMU1EbE52aWJmQVA4OElLQlNkUXp2enVaMjlv?=
 =?utf-8?B?QjRoRXl6RnJacWd5Sm03TTh4bCtCaXp2MUhJSEUxRm8xZDVQMThxd3UzTlgw?=
 =?utf-8?B?K2JCakFrcDdSdnZwcnUvRFFhVWRQcWdkcEkwcExSR0JncUVmOUhiZkEvVnJn?=
 =?utf-8?B?WEZ3a1NDekJYYjQ2ZllYbHVUdFY5aXJjZjhIQVZsbzNNV04xb3J1TmNiMGRM?=
 =?utf-8?B?NlVVN3RVeVJhR1FzbjEwUWVYYVYwWGhxTGZDOXJ4ajcrSm1FZUwyNGJLTnFr?=
 =?utf-8?B?R2xaMVlnZlY1V2lrRU9WazNLWmtxaVZ2WUhETmFFTjN0bTlNWHlPendZS0Zz?=
 =?utf-8?B?cFhNai9jWFNITXJwQ0FUSUM3S0h6aWtvMkdqZlRxNkRCQU5sNVBpQ3pmNDBH?=
 =?utf-8?B?YnNTdW4vQUpyVTNyOUU3ak95dnI5bThEMlpDdHhKUWh0QlZwdGhPV085eW16?=
 =?utf-8?B?bENOSkFlSkx2SktSdHRKcFZ5ZUJRTitrZnBZdnBNUkJXbkM2ZEUvSFdUc29j?=
 =?utf-8?B?WXlMV3BiNERzNmRma0VzTWJKREFzWXdtL2dEY2hnRm5DWXRrZC8vSHcrdWFw?=
 =?utf-8?B?dFpxWVNhTk1nVE9IS1NqWVpuTXE3ZG5vWHpPTWN5QnNOSG1FV0p2MkxZcHFP?=
 =?utf-8?B?dk9GM0lKMHU4SHBrSXZ4cE00VG1hRG1WWityVDBhQU0zSU03VWJybEJjbEgz?=
 =?utf-8?B?VVBnakYwcHJUUy9uWU84ZEdUVXJrWlUwRXh1YVR4UjRITldiajI4RUt5SXBt?=
 =?utf-8?B?Z0hSNFo4VzJSTGUzU3JOa2VqTXZ6SlNiaGlhQ0N1a1VLYWlIbXVkWVp4dmxE?=
 =?utf-8?B?SXZseXRsb3IyUnZOTUxCN1UweU8zNFY4K3MzQjVrcG5Ja0dnbmFZdTB5V25j?=
 =?utf-8?B?UitWc0JjbUhXSlRFaTlFeWRwTS9lM0pwbDlYTm5yZXh1V1BmMkswZ2RYTGxT?=
 =?utf-8?B?YVNjdy8zN2NiVzZOaWREbDdaNXJlVUpnbDB6VkorTkxrN2hMbCtON3NiYVlE?=
 =?utf-8?B?TzBkQWdCZEg1bi8xTThlUXFqSHBGTjNoSDRjeGdmNXl1QlV0bzYvdThmVUhl?=
 =?utf-8?B?QmpyTVkrZytyZTFCR2taSmZJTWFBT2lFb1UyMHhveWlWWlN2elJmK1J1TEcx?=
 =?utf-8?Q?Q2JG/627NrU8/4OUka+cT5JcNTQFHeeY00ctpqVhCrno3?=
X-MS-Exchange-AntiSpam-MessageData-1: EBNyjnaTm/wNKg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25946ba-1a1d-4178-f3c6-08df2e922371
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:08:50.6175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jwbcnt1imJrR1wqBE+qyD0fu94oFlAcUYgK36sp4B1Q80SOPVLAjT28pVmQD6EAQRD1l/h9BxAg2enE/1TtVFg==
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

The RPC parsing should not be done in the same method as the transport
header parsing. Split it out and introduce a `RpcMessage` type to
indicate messages that have been successfully parsed as RPC. This makes
the code easier to move around into its new destination.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 112 ++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index ef59f541f7e6..18861400c3be 100644
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
@@ -838,35 +896,6 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
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
@@ -893,14 +922,15 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
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
@@ -914,15 +944,13 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
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
@@ -1004,9 +1032,9 @@ fn drain(&mut self) -> Result {
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

