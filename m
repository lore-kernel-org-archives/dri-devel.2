Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C6260A2602
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hV61kxrS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8125910F2B1;
	Tue, 27 Oct 2026 07:36:28 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B6210F29F
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEKjApKqEGprj1O0fYlYAc+rlguzMl5YEtWklL50M4YbPfCAyT9G4j5BTpwwU5EsgjmPVpaxNHj3yYBxV9ZvaDXTKTTH2BIW24PgbgyWP/DmAWs+kmio0mD90UG28q8ploXfDjKWiEVoy4wZkmZJXv9Ls72aKTePuFnNKc9Fxtab9geGHUyM1ACcyLP5djRi6SxL/TZ1YucjdVufmWch9hzPSOlyluwnRGDTlHzqflyQNsKkg7f91EMNMmDi97OGPhe6hYatKv8GlQQ9zxqDY/ue6o+tTo3ddFMiFlLyc7w09lshvdH3nSK84BCmiMFluL4pWOG0CDcp3ewlwRd7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1Eu/wme+RoAYQKijbOjp9dTQO1CcViEgfNc/ikC+tQ=;
 b=QNgG7Ku09RCODW6oUAqO/9x0aAfM0+GVvYmCoz7ClYozBDisSl29tW3+H9XPIeS/bH+J0hnjUtFMcoFWF++Wm8gPIVWkrEhp8AtIxuJJFIK3VRrH+dt3MEq55Rz3fI2nd6tG11rtxOXg3ZLq5fKpLhqWEfjYm8YCtqqge28fHTCLxmFoP67NTW3UVbPa+3pUXTY+ogU9vN+pRB0+Xzh8tXWrN+nVd6Vc/9pabOhCYh35pedSTHcfxMGgHzR4prGQBUldRbRchSDX9c5RRc8/lyaTYOcbOJzChu5hj3ZM+CcvM8u0GOFBxOam3maUX0vp9OU17frWkdLKokDVXJ4F8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1Eu/wme+RoAYQKijbOjp9dTQO1CcViEgfNc/ikC+tQ=;
 b=hV61kxrSsb2vD0y5MQg93LS29qYsxZONRZwZm5lLIf2zQ4q4oUjdBs/JE+FrZu7m+turZaDfsE2TTCV3Idkh5wlZ+FYaMEUX0yAGf0iwDfoCtI8WEbhpMahgC69NVEFr2jaqlTJ/kO8GJxw2R12sPPZkD6MFvJG5vRO5c7IaScch1XyBzeHoVvSOgsvUZ6EDy9TTEt+Gf/a1mBIYFn88ZnnJYowkH+thbsWaAAFK1OHJk90TFqAMgZcoZTJ2GmqBXBQrCisuLa+o0UgOKXMz7tymIH/Hgnstc9b/c9TB3Z8NYEsba1v4gSEuPD6htqoMzf4Rx4qh3vtL2ZSN6phQyQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:04 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:04 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:48 +0900
Subject: [PATCH v6 05/15] gpu: nova-core: gsp: cmdq: group the RPC-specific
 part of send_single_command
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-5-bed9669724ba@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0106.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: b246b863-cf15-41e3-40b9-08df33fcf4f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261021123027099003|56012099006|11063799006|261022105027099003|261009223027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: NA1tOZ3vwX7v84a8qqi7NznrM8wTAgq3+Q9I4RXGx1XT4bfDTVxhn+aMEF06ArNBKquiMtztGi3IcKweW1rE0xDBKfM3VSunGGyOOkupFqZT3IPo7+z+2CgOSBTMYxauXg5qVe5eZGessQBkA/jwO3j0iRuBpWp/Fyz1bCzv5NZEMhfgzuw9d5c0MHLg8vIEECCpe7DAH8tC4A5F9KeKv984Rxa0t8XxKZiE4X61E3ceOMU2fFcm33PkA0omVvKooze4HZSi/xUZez++A7XP6NyGl1yAiGptdx5b2K2wnSu5uoCcn7iBRzSCYTcO8E/pmvXjPdHqhk5hviwequ+kgJMstZaGwfRx8beE58b/ovH2pWG5JOzgPuGqi/eeyUQShzIy+ASjRmrxQu7JI8sY4Gl/6s3yKZj7WUTJ+s6qPY/D477JoH4R5y0/MR6FM4+qR5qEZZDhDo16BFZM9xlgcagVx1mkWGePh7QS1mvfkG9Iyww4h/7thn+Dgu9w6eded2Wq0sGFx16ufxVhui3MUdFhizoEMBdhBwkmf3/7kPAkjxQLcU58U8QMJ/GREr2WvKIgG2GONWt19XfrHuyYfuBhdYXr3TnlQDZQetGryzuXTtMGH5bXMjrK1OboMSUjtwYs3IWmytiIglSYbFpTFSCC4uMmj6fuITEJ+T5wtPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261021123027099003)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXZsYmZIcFc0cG5VN1lyc3AzZGxJVEdNMTZEaThjV0l4QkY5bTJGWUpWcGNX?=
 =?utf-8?B?Y0xZS3lrSXJRL3ZpQ1FYTXh5UzU3djZPZFpnR0g5WUI0aTRGdGd1VmNKRWph?=
 =?utf-8?B?T0pUby8wMU1rYVNQS3ZDQ3R3WDBlTy9YMVcyNko0bFpzTlBNQnE2V2FlU0RE?=
 =?utf-8?B?clFjRUpaL3A2SlF4Rms1eGFBOTk1Vmx6R0JMUTZYS1JtbHVrejE2MlluMWlq?=
 =?utf-8?B?ckJpTGMxM3hPR2h5c0tlcWxPWUZyWnlDeUw1RVhTWTdINEowdXg4eUtqZFRY?=
 =?utf-8?B?SnRxY1lrT3EyQkdQYWFESVQ1K29wb1FQNHFVZGVkakNyTWh0M3E1N2dPQ0Rx?=
 =?utf-8?B?cTltK1pKWkVVUlZSVzY3aVVmUjVXamczaUJoZ2Y2MllVbW9xdGV1Yi9BL2Y2?=
 =?utf-8?B?Q09Za3BkbUJjejM4a3BIcE44LzVJa2xiV2xITW41ZEQzdWhQSllzTHhKWTZz?=
 =?utf-8?B?MDlwc093Z0NPZHAxa2hGSDFhUldtMTVMOW5TSG1WQzlPYkM0N0FxRFlzaytK?=
 =?utf-8?B?eFpWZ2QyYTh5SHN4YWZub2FndVl1YXVGdk9CWEMzVmFtMUdIb3hvejZXdUpV?=
 =?utf-8?B?bnZmT1k2MldUbkEvL1YxcW5RNjdoL1B6Z3NOazNyNmFSUTRrT0FPb1MxYVdK?=
 =?utf-8?B?UXVBTGdFZjIveWhQa1RqYng0aGMwdGJRRzViNXp5N25wVFNONTJmUmFiVDBK?=
 =?utf-8?B?UkpuK2xzUU5mMTZRVzBzY2hHdy9ZVlVsTlpyYysvdVYwSEpMSDM4dG1IajRR?=
 =?utf-8?B?NE52WUhFdDd2Y05sRVBsN2lBL0pHR25hdzYvYTBNSHFueC9oU1RNTVl4S01S?=
 =?utf-8?B?Z1FMTUR2UENHaFV3czc3bUQxNWY0ek9VbTFqMXl3R1BQRy9mcGdtc3k3NTZl?=
 =?utf-8?B?SFYzU2tpMUxNQzZXRHpuR29pT0paendEMFdGd2Z1NkJXVkEvc2xJQTh5a09X?=
 =?utf-8?B?dW5JaHQ4MDcvK1VQUmo2U2xaazJVb0lnREowYUU1K2YyWmpNTi9sVVlkMGk3?=
 =?utf-8?B?MnlQNVJza1dTSE1FNGtlVnhRTXRtL2dXQXlNTW1DR3VaOU1KUElsYjdKMWtP?=
 =?utf-8?B?N25wSitaSmxiMW1WNmxodFBqamcvWEpBUnUzMDB4MmU4QU13Y1AvenBsZmlB?=
 =?utf-8?B?ZGpVWmtoQk9mY2FBUjJIa2RnUk5ZQlo5cGpaOTRPdmlhZ2dPRElWc0VCVlA3?=
 =?utf-8?B?b1ozWTBUdEFPVjhvcUgrQTBHamw3cVZUSlVRcjdrbTd3bzNVL3VIb0ZuWU9v?=
 =?utf-8?B?bi9BS2xSYkJWUUNHY1ZudE8xYWp0S21jcmJhcU9aeXB2WVFnUGJoVXVMU2lm?=
 =?utf-8?B?ZkJHMC9IVjNwYmI4Ulc5Z043ZEtoTWJtZ1gzWitGR3ZZK280SVY1bVlGelI2?=
 =?utf-8?B?Uk9yTS8wUStOREpha2Npc1oxWFpLYXpKRUVpMFh3R3NHaDRudm5jTU4vOVRZ?=
 =?utf-8?B?R2ZRbllCNGhnZVdhZTlEaWIrL1dBcGVaLytTcmtFNWY0Z3dkUmlsVC84M29j?=
 =?utf-8?B?bDYxYTEvbC83MTQ0dkErdnlGQTdPU3lyWnFmaTUvTmJuRHpjTzMxNTBWMWkv?=
 =?utf-8?B?THNpTHduODNIa0owcEdFWm93YXNYMHBBQyt5ZFdMbGEyS1dGQ3kzV2VWc2di?=
 =?utf-8?B?MUtmKzlGWTVpRk5PNW84UlZ0bytwNHZNRzdweS83anNzb3c3RFNRVUZZUE1Q?=
 =?utf-8?B?cDFkNFEyM1NnaWF1SXVVZDlrMEw4QUdydzYxSkFJS2hhanp3V3dxRzdJSjRa?=
 =?utf-8?B?MXdtTGQrMUdCUG56ZGEycnlqMkdSZGp4L0J5cTFKa2NLMll0UjEyK3NxbjJw?=
 =?utf-8?B?WmFtTHdneFNGYksvQy9zK09jbXVRTG04S2dXa0tvTGk3MFBQZ2cxcmZEb3p6?=
 =?utf-8?B?UXRSSFFmTGh2N3R0QWZSdkpmNG0vbjdpWE8yZ3BkQUJsWVRqWldMZGt6bDcr?=
 =?utf-8?B?M2FWQ1ZhM2RYWlcxSmEvekZ0SGdhcXRLak54WFZFV25KelZIbTFqT1FHZG1O?=
 =?utf-8?B?U09jQVZta1oraFVadXdkQldpYUJ0enVnNmJvYytiSHdDaVZncWh3NVlaL0Yx?=
 =?utf-8?B?cmxZd29YQ1h3Z0dYV1ZSTDh4TFhxalNtaEpwVkxxdkJhYXgxUkdmdWNjRVFT?=
 =?utf-8?B?dVRmYlBadmhMSW9aalVpd2dIbUVMUFVvRTdETEFjRzdLZzVYTDVHQ0dwUWNk?=
 =?utf-8?B?SDliRGlvU1Brc0dLalZ1Sk9SZm4ySE1NYzBMdGlxVmNvc2oxUXIwUFFKcDVW?=
 =?utf-8?B?dHVsWEJjWWlDc2thd0ZtdFVtcUVkb3ZzbVBjOVlpS0V3OUY4K2xUNjQzQmNK?=
 =?utf-8?B?amgvMUVLN1dJNEJwMmx2bzJjeVRmQ0xBRi9wUWdEd2hDSTFDV3pCUFlHTEZw?=
 =?utf-8?Q?OOPEFd/P7mTFoWqIuqBcibFS3mZ2VXRg65VzEJsczgZkP?=
X-MS-Exchange-AntiSpam-MessageData-1: 8okuCKvDgASkwg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b246b863-cf15-41e3-40b9-08df33fcf4f4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:04.5507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9mmlckiVufcoWI4lMarf/BaMO20GtggeU7F/QfxUXS1pxk+4gGedfk3c4UGq+Rdnpci89ugo+vNZyp1wP02Ng==
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

`send_single_command` handles both the transport and message layers of
the command, intertwining the logic of the two.

Reorder the code so the message layer logic is within the same
contiguous block of code, so it can easily be moved.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 01c83a79da14..88d81a4e37ef 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -683,18 +683,18 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             .gsp_mem
             .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?;
 
-        // Extract area for the command itself. The GSP message header and the command header
-        // together are guaranteed to fit entirely into a single page, so it's ok to only look
-        // at `dst.contents.0` here.
-        let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
-
-        // Fill the header and command in-place.
+        // Fill the header.
         let msg_element_init = GspMsgElement::init(self.seq, size_in_bytes);
-        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
         // SAFETY: `dst.header` is a valid reference, and is not touched if the initializer fails.
         unsafe {
             pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
         }
+
+        // Extract area for the command itself. The GSP message header and the command header
+        // together are guaranteed to fit entirely into a single page, so it's ok to only look
+        // at `dst.contents.0` here.
+        let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
+        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
         // SAFETY: `dst.header.rpc_header_mut()` is a valid reference, and is not touched if the
         // initializer fails.
         unsafe {
@@ -717,14 +717,6 @@ fn send_single_command<M>(&mut self, command: M) -> Result
         }
         drop(sbuffer);
 
-        // Compute checksum now that the whole message is ready.
-        dst.header
-            .set_checksum(Cmdq::calculate_checksum(SBufferIter::new_reader([
-                dst.header.as_bytes(),
-                dst.contents.0,
-                dst.contents.1,
-            ])));
-
         dev_dbg!(
             &self.dev,
             "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
@@ -733,6 +725,14 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             size_in_bytes,
         );
 
+        // Compute checksum now that the whole message is ready.
+        dst.header
+            .set_checksum(Cmdq::calculate_checksum(SBufferIter::new_reader([
+                dst.header.as_bytes(),
+                dst.contents.0,
+                dst.contents.1,
+            ])));
+
         // All set - update the write pointer and inform the GSP of the new command.
         let elem_count = dst.header.element_count();
         self.seq += 1;

-- 
2.56.0

