Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3853D60A3806
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uhWGv7mU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0D710F2A6;
	Tue, 27 Oct 2026 07:36:33 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A97110F2A6
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKVd64crXCIFzMl9U6QI404a3aBSiCTfdp9K2ObicYlOpWRDZwhnqOlYkv1+pClsvJsWE8uEupIFM6hNYA/UGhAXYuh3L5j9ox4XbEto3ul0SHDU8gZDe1MhAqCrRVxVY4ksEZ01huJi+T2lfBWkUwW3lda9oMXj7hCViY9r3Zj+1WmwQ7zJYpBJdAVrJXPU99bdfTClFMRoA6H/dMhctmhzLluDXpBySrkZsE4PGMk9yBUXSm84d5dWg8QYQChIZfIaD4wnaWnA0XtnanmZNhipKMQZdZgrN2va8WmqRKNDZ41AoqE4eXBDM/o3FSDptHJDAAFHORS26VweFnlTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wadkDx3ScHHWqYjiyksoJzXWrtN2cww0+cGJr88lv8=;
 b=dxh6viq5wFa0ibDP7cHQZF61I6ztnK4Zbli4oa7RXdF4UusIMFeXYDHjYOxMakgY6Sh0e8jaBEg3NDDZres5tR/7nDsbmxlN/l0SmiJ6U8KBuop+3pwo10AI3dxbwNR4luq2t1OREMclStt+Xkjttqc9TsVQhfTu1gwdQdQ8mQZkcmwSsWpVqxLMaClS8WXgbAPAhbJswL5zTCVXGriT4UOUUcFm1Tu12XhaDwSGib7+CD12n2tcCIWUctAKKTl3bCQPprERtJgXRXUpWaL/Es0ZmTPAcmXXN+EwlkWKnUc/zUSznTAYCADFLIDpeZDf8S/vp70lWGhhjtqKHFZvtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wadkDx3ScHHWqYjiyksoJzXWrtN2cww0+cGJr88lv8=;
 b=uhWGv7mUp+Y0CRPxk2PLaadWaSBf30gY6QymO+FGhr65yiG4xhPxQp/GHn178euXjizn6QmS0UWjupNcb2wx7YzLdw278lwqH2A0UBVVcQM/xZrGdVpBm096ngxWV7h1mLfx5T1IE/YEk6UwBOpzLkaRInHkZzKKXi5/fGuJC6rJi9n+Rr4fsIwS9iqeALhv7XZDjZjq4HJ6t2UKp18S4SlKwcjfGE5Qw3YGwp9eXrmrs4HnNhJ1md9HC6bOJfEFhET98nBhnpv1HP5bkMzZqWAF70ha30aGbBdr0lw13ioucNV45kUcPKWj6xnD4nTn6eVrZKYsaUh3Zat8yCLqbA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:08 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:07 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:49 +0900
Subject: [PATCH v6 06/15] gpu: nova-core: gsp: cmdq: split the transport
 part of the send path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-6-bed9669724ba@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0072.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::7) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: db01dd1a-2e03-4a4e-2cf3-08df33fcf6e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261026121527099003|261021123027099003|56012099006|11063799006|261022105027099003|261009223027099003|261022075727099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: d8lslw8HZgHVVpcVb/l3808bhkfiFiWBQv5Qyj27V7DX1qqx4umi6GEHUn4HUBqpvcy+BnWOiAnqpOk8k3YRK4Q/bSfIFeJUB/jm/Msp/igC5XzT0CaQWDNtkXKVW64Eggmb2Z7GhZ94K2tbiG5bVKqEzxWIfm6gGrvIkJiBn0dP3Vkoxrdx6RUJWcZ8jY6jbtzP/XfqsyYbkVLsBMJdwhC7MAVIZ1QODxNqGR+6ywjkLWFuhjZgl733MfQ4Bu6MEMiy0L5bN4yj5fbHMA0zHAeRbdJ+qZGpashmFNIsWPRdYUCZgKhhExBsIaUA5JAO1+z/75Z3z1m5Z1A5CnobL22R9nHfCCXGgtaQVePfNxrJJz6tKMgFQOomrovCPX3AiCI9BffRBBRu2kAuzQ/K1/f49ZvN+c1ZNdyLqJ4lXv0T8HF+N/FFALjQV5fEWa6HubfDDeRZfh+oXeBL7McbwppreNVNbKuO16gFUuXtGeWIVktI+ljv4pUK0uJOPX/9BHU3TVHWDHGXcgDdG0dYw1M0xtewxp/AkwKaW7OpS5FFWO3fEysKJ69+g89z9sXynuEMJtF+fQuCYp7h2GHYr7k6/AOF/2vFmNB+5lPjeSWxEEuCIm6IGUMKkjvV/4BkljzwTKKZ/KEiMO/VINdGcGARbGTtYE93yS2+/E7i6mc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261026121527099003)(261021123027099003)(56012099006)(11063799006)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnJPci9uR2ZRRTdXYUlmQmRiajZrVDZFZXUraTRhZlNnYWNSaHoyNTgvOFJ0?=
 =?utf-8?B?elRjSzRRd2djNVc3VUMyc2JQTnBRQ21HUU9STzh4VjR1SFRkZm4wM1Rodmg0?=
 =?utf-8?B?M2tjVHFNSE4yV1FTVDlpcWVLTElISzdLRUd5S0R5YWVDSm9mWUFnWG05bWEz?=
 =?utf-8?B?TzBxTzYyNGRjWDZ6ZmtHemsvRW9MMCt5WnFpVHcvNGR0YytaaGtTWEJHVHNY?=
 =?utf-8?B?Yng2TldnYitudGQ0d3BaZU52ejlZZHNYS1R6ZjZ5eGNjdEpqNW91MFA2UExL?=
 =?utf-8?B?dVFIUFNFa2czbDNYUzVlRUVBeEhHYjg5aytkQmIrUUMvNzNKZ09HQjVKSlJX?=
 =?utf-8?B?c0g4KzlNTGVKMmV2a1hoTDVvWmJ6c3p0ekxQTS9LUTR0WXhROVlESEtTVklv?=
 =?utf-8?B?a3VZU2JNRFBhZkF1TzZPNURCYXRVOEhKdzkxSlc0aHZYRlpzNS9lSXBZVms1?=
 =?utf-8?B?NXVER1FPNWgwdmRrWkJxQStNS2FFRnZzcDE1V25zSFFoRkwrZ1UwVEtFSHlY?=
 =?utf-8?B?NWswbVovRUJXd0Npbk9CeG55TVMwb3ppUW1hZTlvMlpJQWZsQWtBUm4xY0li?=
 =?utf-8?B?RzVtQ0tIenlHNS9ZWEV3c1lvYXRrYVRycC83c0w3TDhKazgrditBNU9uNjlV?=
 =?utf-8?B?R05RTzFDRFBBN25VYU5vWkVWRDllL3hackc4VFVZQjhFVXYwSVh2VmZmRk02?=
 =?utf-8?B?VXJGQnFYY1FDRXpMUHFLaFlBTE82UWw4RDNaTzJZd3VlTjhXcUlmWDgxeG0w?=
 =?utf-8?B?bGYyUlQvb2JncDk3R0hpdW1VbndmZDZLcDlpbkVmM1podG1nT1BGbW5oQjlt?=
 =?utf-8?B?bENvUFJuZi9FV2hrWVRPcjFodXlwdGpxZkJOTHpLQjhraXF5c2RGMjJYd3FK?=
 =?utf-8?B?OXVRMEtkTldtbXhFYkdWUWE4T3p4VCtZVUhHbDBYR1phKzlOL09SdnRoMmVo?=
 =?utf-8?B?QVpxRzVveC9GQmNXbEhvdzZocm1vOG9QNVAzNWVTVEpURjljTXVGQVE5RkZa?=
 =?utf-8?B?c0ptVklQOHB5dDlFbHA2U0twV2g1UUY5VmE0am5SZDRTdVVNeCtWV212Rms5?=
 =?utf-8?B?NlNyZ1NJWjN2TmlWaWxrSy90NVpYY1J5SjdYRHYrd2h0OERtR0haZ0dlWjht?=
 =?utf-8?B?T3QwUjB4eWhFbi9vaWZwcnlacFlleiticms3QWpBQXljUGNYd0swb3lmamF4?=
 =?utf-8?B?YUF1bmxKQm41WkE4aGo2SGlEM0EvdGR3WnkwakhkNE12YVZIUWp6YjBSR2x4?=
 =?utf-8?B?Q3ZwOFdmTU5NSXZYNGhsU3JVM1FVSDNTLys4dTNVR1EveEZ6dzBsT1RpcFhQ?=
 =?utf-8?B?NXVpYWl3NEhUcC9NbUNuWnplN2F6RlNhWW04aWRsbGVLN0k3dU9DVnBIWmh3?=
 =?utf-8?B?N0VGU09ZcXlRR2VML0tpME5iUmY2YkI5MHlkMHJEOWNVRWV2eHdvazN0RmtG?=
 =?utf-8?B?TnQvVEkxTHdZV0l1VlpSZWpXTXgwQkxBMEthRWc2YjhjelZ2OXBtWmcrTGZ5?=
 =?utf-8?B?Zk1JVnpXdFV1RmoydVBRZlFUVlp3Uy9ZSTVBQmwrUTlEUTB4S2QyWmk1L0Vl?=
 =?utf-8?B?U1JUNjhLcy92dStGMVJMUUwvSWI4OTZzbFB5WmRYUXF0amYwanVhV2pZREdF?=
 =?utf-8?B?amZNUXA5TVhENGR1aGdvSnpwdlZwY0NteGdrSVZoQVJKdm9GS0xvNXJYc3BY?=
 =?utf-8?B?V2pIeWJGZEQ2QXlKeUxIbWU4OHBDWDRSL094YlN5cFVGV0RsRWRkeE9Bb1pt?=
 =?utf-8?B?R3FNSTMwVTVKQjVQMHZGQTRRamwxaEdvRjFLb3VEdzc2ZXhwakhZODNPUUEv?=
 =?utf-8?B?aE1GWkt5d0w1T1VsZk1tMTBtL2l2NHRhdGpYSVN1Sm9pT3R6VngvdU50TjBN?=
 =?utf-8?B?S1hkMCtoTkxqc2VkaDdmd3NTY0NJVG1COHdONU9pTVpzMFE0ejZpM3ZTU1cy?=
 =?utf-8?B?TEpUZDk3Nzk5bXJSV25aNzhlbmFobXloOEpnY3pUWHVuQXBjbFdWZyt1Sjhy?=
 =?utf-8?B?clhYTWllUGVPVnBZS1Q0M1oydUtNNlloeGlEVWFyQVF4L3Jzait5L3B6OUVP?=
 =?utf-8?B?dFllU2ZGbi81d3ByekplVkdPbGxhQzJNeU0yMWpFOTV4eDE2NVErcFJ2Y2hv?=
 =?utf-8?B?OUo4b29IQklDQlphbkFGaEhMSnFBNXZ4a0lQSkVCS2ZnakNLc0o5YTV0VUY1?=
 =?utf-8?B?bjZLMVhjZFc2ZWsvenBaZVNrTU56QXhHR2F0YVNWclhqK1ZlbFVZOFN2c0FD?=
 =?utf-8?B?YWtnV1R3YmxtbHdJb0lkL2dlMEFUSHM1SmJYZHVEdzdUbk1waGdpTE45OEx4?=
 =?utf-8?B?Z3hvOEhNU056ZDhuQ2V2WGVFOEdnZVl1Rk4zRm1IbCtZVGhBNVk4VVhvTmpu?=
 =?utf-8?Q?vYa80Khw/1tuDQbGTQUldA2gleWS0B87oZ4SFe2Lamgg5?=
X-MS-Exchange-AntiSpam-MessageData-1: qRP4iw5o/pmfZA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db01dd1a-2e03-4a4e-2cf3-08df33fcf6e6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:07.8325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcuuwgVnGlEdtmWjAmhKLE8IqbIWFDCaM79idnokMAjkUaMf5ogKv0ykxffghtSPXXBeSZdI+otjyLwwF0y0lg==
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

Introduce the `CommandElement` trait and `RpcCommandElement` wrapper
type to define how messages (independently of their type) are sent
through the transport layer. `send_single_command` becomes
`send_command_element`, which allocates the queue slots, writes the
element header, and delegates the writing of the message itself to the
implementation of `CommandElement` before computing the checksum,
advancing the write pointer and ringing the doorbell.

The RPC part of `send_single_command` (writing the RPC header and the
command payload) is now part of the `CommandElement` implementation.
This sets things up for moving the RPC code into its own sub-module,
leaving the transport agnostic of the message type.

No functional change intended.

Suggested-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 133 +++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 88d81a4e37ef..ef59f541f7e6 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -39,10 +39,7 @@
     },
 };
 
-use continuation::{
-    ContinuationRecord,
-    SplitState, //
-};
+use continuation::SplitState;
 
 use pin_init::pin_init_scope;
 
@@ -71,6 +68,19 @@
 /// reply type are sent using [`Cmdq::send_command_no_wait`].
 pub(crate) struct NoReply;
 
+/// Trait implemented by types that can be sent as a single command queue element.
+///
+/// The command queue allocates `size()` bytes after the `GspMsgElement` header and calls `write()`
+/// to fill them.
+trait CommandElement {
+    /// Size in bytes of the element, not including the `GspMsgElement` header.
+    fn size(&self) -> usize;
+
+    /// Writes the contents of the command into `dst`. `dev` is the queue's device (to be used for
+    /// logging), `seq` is the sequence number of the element.
+    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Result;
+}
+
 /// Trait implemented by types representing a command to send to the GSP.
 ///
 /// The main purpose of this trait is to provide [`Cmdq`] with the information it needs to send
@@ -133,6 +143,62 @@ fn size(&self) -> usize {
     }
 }
 
+/// Wrapper type for sending a RPC command as a command queue element.
+///
+/// [`CommandElement`] cannot be directly implemented for all [`CommandToGsp`] with a blanket
+/// implementation as it would conflict with other future command types.
+struct RpcCommandElement<M>(M);
+
+impl<M> CommandElement for RpcCommandElement<M>
+where
+    M: CommandToGsp,
+    Error: From<M::InitError>,
+{
+    fn size(&self) -> usize {
+        self.0.size()
+    }
+
+    fn write(&self, dev: &device::Device, seq: u32, dst: &mut GspCommand<'_>) -> Result {
+        let command = &self.0;
+        let size_in_bytes = command.size();
+        // Extract area for the command itself. The GSP message header and the command header
+        // together are guaranteed to fit entirely into a single page, so it's ok to only look
+        // at `dst.contents.0` here.
+        let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
+        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
+        // SAFETY: `dst.header.rpc_header_mut()` is a valid reference, and is not touched if the
+        // initializer fails.
+        unsafe {
+            pin_init::raw_try_init(
+                core::ptr::from_mut(dst.header.rpc_header_mut()),
+                rpc_header_init,
+            )?;
+        }
+        // SAFETY: `cmd` is a valid reference, and is not touched if the initializer fails.
+        unsafe {
+            pin_init::raw_try_init(core::ptr::from_mut(cmd), command.init())?;
+        }
+
+        // Fill the variable-length payload, which may be empty.
+        let mut sbuffer = SBufferIter::new_writer([&mut payload_1[..], &mut dst.contents.1[..]]);
+        command.init_variable_payload(&mut sbuffer)?;
+
+        if !sbuffer.is_empty() {
+            return Err(EIO);
+        }
+
+        dev_dbg!(
+            dev,
+            "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
+            seq,
+            M::FUNCTION,
+            size_in_bytes,
+        );
+
+        Ok(())
+    }
+}
+
 /// Trait representing messages received from the GSP.
 ///
 /// A reply that [`Cmdq::send_command`] waits for, or an event that [`Cmdq::await_msg`] waits for.
@@ -662,24 +728,18 @@ impl CmdqInner<'_> {
     /// Timeout for waiting for space on the command queue.
     const ALLOCATE_TIMEOUT: Delta = Delta::from_secs(1);
 
-    /// Sends `command` to the GSP, without splitting it.
+    /// Allocate enough space on the command queue to store `command`, initialize it with
+    /// [`CommandElement::write`], and send the command to the GSP.
     ///
     /// # Errors
     ///
     /// - `EMSGSIZE` if the command exceeds the maximum queue element size.
     /// - `ETIMEDOUT` if space does not become available within the timeout.
-    /// - `EIO` if the variable payload requested by the command has not been entirely
-    ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
-    /// Error codes returned by the command initializers are propagated as-is.
-    fn send_single_command<M>(&mut self, command: M) -> Result
-    where
-        M: CommandToGsp,
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
+    /// Error codes returned by [`CommandElement::write`] are returned as-is.
+    fn send_command_element<E: CommandElement>(&mut self, command: E) -> Result {
         let size_in_bytes = command.size();
-        let dst = self
+        let mut dst = self
             .gsp_mem
             .allocate_command(size_in_bytes, Self::ALLOCATE_TIMEOUT)?;
 
@@ -690,40 +750,8 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
         }
 
-        // Extract area for the command itself. The GSP message header and the command header
-        // together are guaranteed to fit entirely into a single page, so it's ok to only look
-        // at `dst.contents.0` here.
-        let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
-        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
-        // SAFETY: `dst.header.rpc_header_mut()` is a valid reference, and is not touched if the
-        // initializer fails.
-        unsafe {
-            pin_init::raw_try_init(
-                core::ptr::from_mut(dst.header.rpc_header_mut()),
-                rpc_header_init,
-            )?;
-        }
-        // SAFETY: `cmd` is a valid reference, and is not touched if the initializer fails.
-        unsafe {
-            pin_init::raw_try_init(core::ptr::from_mut(cmd), command.init())?;
-        }
-
-        // Fill the variable-length payload, which may be empty.
-        let mut sbuffer = SBufferIter::new_writer([&mut payload_1[..], &mut dst.contents.1[..]]);
-        command.init_variable_payload(&mut sbuffer)?;
-
-        if !sbuffer.is_empty() {
-            return Err(EIO);
-        }
-        drop(sbuffer);
-
-        dev_dbg!(
-            &self.dev,
-            "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
-            self.seq,
-            M::FUNCTION,
-            size_in_bytes,
-        );
+        // Write the message payload.
+        command.write(self.dev, self.seq, &mut dst)?;
 
         // Compute checksum now that the whole message is ready.
         dst.header
@@ -759,13 +787,12 @@ fn send_command<M>(&mut self, command: M) -> Result
         Error: From<M::InitError>,
     {
         match SplitState::new(command)? {
-            SplitState::Single(command) => self.send_single_command(command),
+            SplitState::Single(command) => self.send_command_element(RpcCommandElement(command)),
             SplitState::Split(command, mut continuations) => {
-                self.send_single_command(command)?;
+                self.send_command_element(RpcCommandElement(command))?;
 
                 while let Some(continuation) = continuations.next() {
-                    // Turbofish needed because the compiler cannot infer M here.
-                    self.send_single_command::<ContinuationRecord<'_>>(continuation)?;
+                    self.send_command_element(RpcCommandElement(continuation))?;
                 }
 
                 Ok(())

-- 
2.56.0

