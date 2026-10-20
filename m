Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3923560A2609
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Mmb0q4YU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A085210F493;
	Tue, 20 Oct 2026 10:09:22 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012036.outbound.protection.outlook.com [40.107.209.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C626110F493
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:09:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W12+WVaYFGNDxagmhnXlyB6ZGsVn88jc2c+az8Wkbqe923erbh5g/je/ej7bTPhhO+x8EakZ6oEKyyKvBf7RBppjh/n5sdyOJJeFaVrUXunv1Ac3mg1eaZz+/J5B+gtVPh8ea7Gn9hlOE8ZUJqhW8iP4GXccigvVt4T+35O/ur2mjs/+LRGFWX+0o6SZxwI6NcfF8Ok0S+gudB5ps0xLQb6t6l17+DyuziO8FVQzafze61ImW9nCV7JhVfZ/uUWJge2kgHN2wI0FRiXKFixl7resLEPKHzsa05GT7y8Z+2IKi0cHJr509Iidu8jSVz4lhRh/G1FwQcsYIlpAVB0i1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1Z60orSKm/Gifj5slqu1rqKWJ8ushM810pXZQnT3Oo=;
 b=YFRBuqUabHT+jQExJwefPm3e1cKefLf+gvOShyjHgbwlWNkCbgh0JlHS9xWlkGDKRQT+O3WAQNYDHie+RRfGQLXOKMoxva5mFNNfIqcFyeK1i36YYgeDeZSMep7sI4z7/ONINTnHbYpQd+5/o8nOTj5WV9ARfrDMSaH2KcTB7QqrEDFqzpRxhFTZ/XqifijhOwNOGbCCHC+O8xnt2Jso40alviWehuBjTrRDzO07dO+jS2ntxEuW0jV/F3qdLqfZOrtt/XhKw2no/DdciLiTbhnQqfggCg5BLwqkTqnshu6eDPxDvwvWxbTIfIc4myhNv/ir9Vr4JkaeCxsIz05ZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1Z60orSKm/Gifj5slqu1rqKWJ8ushM810pXZQnT3Oo=;
 b=Mmb0q4YUkROCFg9sGr15wwg0L/tq/oo8h78kdrTfgB4DDO4CrWOD08Lzecfu2cr3GY7UR4vaSqZtKGYHye0WDfdORnvYDcGgIbfRcTlxwFV+43j68TLIYwXU8Gb+ZlzfhZu/AlOEjjxR5hXHHHfmgF9jmEzA19/PkGEwTUeLMAPlNhMeRm/i77VvWqGw+wFhpYD5LI3cFjn/4yWR9QPS9XzatGKBkcan4a/lT25ZS65+5J6m4agcYvBpQu37aMoTAYXWYA+1vjV3/fTRD0GcPf0miOB7TosyIqu249VCNiDcGULrv+cEV3isNwCCtKka3/JYYfTbQ2zxNTweCj1fxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:08:56 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:08:56 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:30 +0900
Subject: [PATCH v5 09/14] gpu: nova-core: gsp: cmdq: split the transport
 part of the receive path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-9-dceeb8f360ec@nvidia.com>
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
X-ClientProxiedBy: TYWPR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::23) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 74463adc-50f3-40a1-5ae9-08df2e922733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|10070799003|1800799024|18002099003|22082099003|10067099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: W1XA7KwjSyTbzBt8eLyJN4KXR+wtWDvhYoUOR5aux9kjUFZOm/aDI+5uodSE8gsDGztHp5qjwPor+69obhxtQUtooxRPIXcaVEd3G+IQt+ZZsOueqnTwharqHEx002dmQue1YounYUvZI2nsBv3NCChiDMihp+lC4pEwvXu02HW3eFbLN6cBORotUpBf8+hS6PJNruNEL1Zxz/VlmiFmiffQIVABW3H4+IyV8S61SIzKcgT//wKIZRi6W7xXJHD6jn4yoEpuZXyPUjhCYvsx4UMPtgkrAPH+3IlRxg98npcGMCgyrMX8mzbnDW8xpTZ4G7Qxsp6vV11bWGwzMkAEH7OeXtBssByuUGBGLfhuHOMSL77B0r/uPrRN1f2WKbtpaQ+L129gu5nAfLrcRKnmt8wlg9e1wEPSqkjsooZ7InIFa8QSW6GF8OWx1+X8xhDgQ2JsBxSRPPaF49cNaAh3W+DU7PlkO9Iic2NMMg8qHQFghAmblAxFs1ddQbdPMeSMJoKmCVRWUpHDIUh4M27rR38L7cznDDlu8iPjonXt1PbGHTEuUZLPr5LTBXRe+u0j9Fcarbc6sgcKKW1W5OIpSqZEF9MwiecGdMRy2+GI3egdm/Hz/KcrHkRhliTa0jGuhQf6+IcvmJVdQTQFCMnvQ1qEGwXdmTRRpkBbE9fJ5Ow=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(10070799003)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnlSS3ROMms0U2phbVVzZkw3TzRBRXNGTmNKQW82UnRtOC95YlVURG9XazRL?=
 =?utf-8?B?UlR4LzlLTGllazVoTU1idXEwbFVGY0FkTkpxcFZEeG9tZ290ZjhaZis0d0xQ?=
 =?utf-8?B?NVAzbWRnQ3VFcFZHWi80M2UxMUtTZkMwZTB4QXlManVjeExiQnhxREwxRHZv?=
 =?utf-8?B?SmpHa3M1MmhKaHg5L2YxVTVYQ0hRMzNjSGdpSkJoN1pwWkg0NGQxa20rWDU3?=
 =?utf-8?B?SjRETTlHRGNRbkJWTCtWc0tvWjIwaFBHaW9kcHJPbk83bTVnQWRuK0YrOURm?=
 =?utf-8?B?V014SEw2c1NsaEh4VlpkMXQ0ZUZ1K0xTTFRJQUhGOWtsY0JFMCtmUk1wWENV?=
 =?utf-8?B?VUV6YnZocVZkZkhZVThhbGZyMkdyNXBkUEJGdERkSGpGeWw3M1orVjlvTkZx?=
 =?utf-8?B?dkFUcUJwVHh3TGR5YzVNanRoYUdEZVJQWW8yTy9KTTdvYkp4bUxKd1Fkblpw?=
 =?utf-8?B?NkFxcU1xaXM3a01qRVNUWEc4b09mZG5GdjdGQUZobTVDdk5PVEloeENkZ2hh?=
 =?utf-8?B?OVBtNmhtS09RU0xwZ2E1TTBJWlozcmlCMXpWbEZmS1JUK3IrYytmL3duZjZH?=
 =?utf-8?B?WmVTN0h2a2I2RU16SFJUd1V5SENIYkhjZlRtdnRUdGd3Q2NOcnpGZCt1NTZX?=
 =?utf-8?B?bWhJWmJ0UGQrY1Q0WTI2NFRkQnFUMkdXL3drK1BKZnFYMFpsL0JoeUFXUTNR?=
 =?utf-8?B?eTZNZkI5Vm1GODAycWpaWTd5bXNGa2Z5dUVWM2IzdkZZejN4SXJhQVNiZ1BH?=
 =?utf-8?B?WWM3ZjVvNk9nSFM4N0lYaVgxZEwrb3ZHVHNFdk1STzgxQlJmVnZrbFBQaXFi?=
 =?utf-8?B?UFBaVmgvbkJxMU1nMmZQWWtVRWFrZmovNklCRm5kWnVTbWp6d0hyUTFNZ2dr?=
 =?utf-8?B?aWxzK3ZDWGRJTUVaU2pzYVpzSzNhQWdLRzVMODREU1owRGFLNkxQK2NhTTc5?=
 =?utf-8?B?YlhyWE9GeENsUUhHWUF2ajZmb051eEpUOHNwdlVONzloTHI3aitzeTZDK3BI?=
 =?utf-8?B?YTl1QlB5SkdCa1BrV0Zzd0FRdFZtajhjU01aQVhaMDJNSEQ1ai94MGdXVVdB?=
 =?utf-8?B?YkwyT2laV0ZNWENUNTVVWC94UldLd09wUkhhazZIV2V5czMxQ2xxZ3pzTTds?=
 =?utf-8?B?K1hKOGpKZm1iMHZPKzRqQU5VbGg4NmZ2RTZmYWZ6UTFGWVB6QzhMTGtSNTFY?=
 =?utf-8?B?MGdpMWF4Y0tlUnpVTTQrZ0IzdmhXajJFUzUzOWNIZTEwTzNXV3p5U2FVU1J3?=
 =?utf-8?B?YnJLdVMvN1lqQ25BQ1NnczE4OXB6Y0N1QWgvaHNRbHhLV2hrdFc4Vld3S2ZF?=
 =?utf-8?B?Y09OYjVUTUdLVHpxTitpUHFRWEE1WHYzMkhiZERyMndiYTU0cFh0OVFUbWRM?=
 =?utf-8?B?ZExMVkg1Ykt6WmovWGxoWFJOckJxWTZmbUhPMzJVUGlpVXpNZ1MyTGZudmtF?=
 =?utf-8?B?N2I2S2xZOTN3VDNPUWFRSXUwSDJwdXlvbURFbWVyM3B5UTg1a0VOR0tXV2NJ?=
 =?utf-8?B?Y0dNZURRcm8zbEgxQTU1enJ4Tk5SSDVxTUNVYWkxcytpckxCcFlRSXZRenNH?=
 =?utf-8?B?aEFlTGk1YXdJeXBpM04rNStlbTZNai8vdHJqTW1maDBPRlVTaENNdmVlVWRz?=
 =?utf-8?B?am5JOXE5aTBSVmp1dUdZV3dtS3c2bEI0SGNkYzU2Y2pnQTB3VnAwRllBcy92?=
 =?utf-8?B?UytxNk8zUFh6ZmpGYWpFdEVMdXVyaTNlaTZwK2prRWlwQ0hlZjBwZUpUSWVz?=
 =?utf-8?B?UUV5c1h1K1F4Qm01RDh6S2FBRUJYUHRyeGlsM0pyUHZiV3dQYytLbVpxRnJ6?=
 =?utf-8?B?bXQvQTFwcVdOcnh2Zk8vVjg5OHc3LzFnNHBRSFBZbGd5SXovbHRmLzVEU2tl?=
 =?utf-8?B?dldnSkhzNks4ZGpwU0hkbFFPNTFkVmdvZmozL3FqRG9oMU9yNGZndnJ0Nis2?=
 =?utf-8?B?eW81MDZqZkdFSDB1cVA0eWVidG9Nem5vTFNGT0NCWm1TNXJpSytuS01ZdTVH?=
 =?utf-8?B?eVRMd0kzRGVVdDMvQllycUx0eEpvSlZPc3pQTGVOTVZVZm82dFR1SVZNUVlC?=
 =?utf-8?B?VlRocUxmMC9ZeG9JQXR1ejZGQ0pqYjc0Q1MzODBtZFN2dFV1UVYyZklBeTFt?=
 =?utf-8?B?TXRiWGZIQ1pReWczMDRNcm5JTG5Ralk2YnhsQWVrOUJoaitqMlQ2UGNSQ0RZ?=
 =?utf-8?B?NXZTZmpqVmd3b1J3SXdnK1pxRXYxdFJQSnVENmpHOGZCVEJaendGOUNXVGcv?=
 =?utf-8?B?dTl1UXQ3Vll5RlJqVlR5UEFKNWNVQ0l0cG05a0Z2TVpiTDJ6UWFYVjZER2lW?=
 =?utf-8?B?WHlLZWVNbFZyd21FNy9STWo5L242TW56SXVBNGFBUmtOd3pRTFZrYUdxbVlT?=
 =?utf-8?Q?M23BpFIygZ6i/bpbXWXiiQDOGVXibszFQJXEyRZOc5AcP?=
X-MS-Exchange-AntiSpam-MessageData-1: wg5Ci+YY3/EcrQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74463adc-50f3-40a1-5ae9-08df2e922733
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:08:56.8560 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LUYSRkAMLErfdtcWjoCn2OCYz5aceJZyEmO1LO1pIapUunajdMmtEWjYTIHvs8DNow5gextru9jyW2J3C6Rofw==
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

`receive_msg` currently handles both the transport and RPC layers.
Retire it and split its logic between the new `consume_element`, a
transport-level method which passes the parsed message contents to a
closure before advancing the CPU read pointer past it, and the
already-existing `await_msg`, which calls `consume_element` with a
closure matching the RPC message.

This introduces a small behavioral change: a matched RPC message that is
too short to contain the message component itself no longer stalls the
queue. This behavior is justified because it fixes an inconsistency:
unmatched RPC messages were always skipped, whereas matched RPC messages
could block the queue if they were too short. While a misconstructed RPC
message is a problem, it is not a fatal queue error as long as the
transport framing and checksum are valid.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 Documentation/gpu/nova/core/interrupts.rst |  7 +--
 drivers/gpu/nova-core/gsp/cmdq.rs          | 93 +++++++++++++++++-------------
 2 files changed, 56 insertions(+), 44 deletions(-)

diff --git a/Documentation/gpu/nova/core/interrupts.rst b/Documentation/gpu/nova/core/interrupts.rst
index e42286915711..13a087b960c0 100644
--- a/Documentation/gpu/nova/core/interrupts.rst
+++ b/Documentation/gpu/nova/core/interrupts.rst
@@ -583,13 +583,12 @@ the command's sequence number on every reply. On r570 the reply to
 ``UnloadingGuestDriver`` carries sequence 0.
 
 The read pointer advances past every message that passes framing and checksum
-validation, whether it matched or was an event. A matched message that is too
-short to decode is the exception, and it stays at the queue head.
+validation, whether it matched or was an event.
 
 A message's length is inside the region that the checksum covers, so once the
 framing or the checksum fails there is no trustworthy length with which to skip
-the message. Such a message also stays at the queue head, and every later
-receive fails on it with ``EIO`` until the device is reset.
+the message. Such a message stays at the queue head, and every later receive
+fails on it with ``EIO`` until the device is reset.
 
 The polling path and the IRQ thread both read the queue under the command-queue
 mutex. Replies and events share one queue and one read pointer, so one lock is
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 4efc96eba4dd..58761a5f609f 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -645,6 +645,12 @@ fn log(&self, dev: &device::Device) {
     }
 }
 
+/// A message whose protocol layer has been parsed and validated.
+enum GspParsedMessage<'a> {
+    /// A [RPC message](RpcMessage).
+    Rpc(RpcMessage<'a>),
+}
+
 /// GSP command queue.
 ///
 /// Provides the ability to send commands and receive messages from the GSP using a shared memory
@@ -930,57 +936,39 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         })
     }
 
-    /// Receive a message from the GSP.
+    /// Wait for the next element on the message queue, pass it to `f`, advance the read pointer
+    /// past the message, and returns the result of `f`.
     ///
-    /// A message whose function code is `M::FUNCTION` is decoded and returned. Any other message
-    /// is logged as an event.
-    ///
-    /// The read pointer is always advanced past the message, regardless of whether it matched.
+    /// The read pointer advances regardless of whether `f` succeeds or not.
     ///
     /// # Errors
     ///
     /// - `ETIMEDOUT` if `timeout` has elapsed before any message becomes available.
-    /// - `EIO` if a message fails framing or checksum validation.
-    /// - `ENOMSG` if the message was not the awaited reply.
+    /// - `EIO` if a message fails framing or checksum validation. In this case, the read pointer
+    ///   does not advance and the queue is stalled. This is a fatal error.
     ///
-    /// Error codes returned by [`MessageFromGsp::read`] are propagated as-is.
-    fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
-    where
-        // This allows all error types, including `Infallible`, to be used for `M::InitError`.
-        Error: From<M::InitError>,
-    {
+    /// If an error is returned, then `f` has not been called.
+    fn consume_element<R>(
+        &mut self,
+        timeout: Delta,
+        f: impl FnOnce(GspParsedMessage<'_>) -> R,
+    ) -> Result<R> {
         let message = self.wait_for_msg(timeout)?;
-        let elem_count = u32::try_from(message.header.msg_length().div_ceil(GSP_PAGE_SIZE))?;
-        let rpc_message = RpcMessage::parse(self.dev, message)?;
-        let function = rpc_message.header.function();
+        let elem_count = u32::try_from(message.header.msg_length().div_ceil(GSP_PAGE_SIZE))
+            .map_err(|_| {
+                dev_err!(&self.dev, "GSP receive: message length overflow\n");
+                EIO
+            })?;
 
-        // An early return here would leave the read pointer on this message.
-        let result = if matches!(function, Ok(f) if f == M::FUNCTION) {
-            let (cmd, contents_1) =
-                M::Message::from_bytes_prefix(rpc_message.contents.0).ok_or(EIO)?;
-            let mut sbuffer = SBufferIter::new_reader([contents_1, rpc_message.contents.1]);
+        // RPC is the only type of message supported for now.
+        let message = GspParsedMessage::Rpc(RpcMessage::parse(self.dev, message)?);
 
-            M::read(cmd, &mut sbuffer)
-                .map_err(|e| e.into())
-                .inspect(|_| {
-                    if !sbuffer.is_empty() {
-                        dev_warn!(
-                            &self.dev,
-                            "GSP message {:?} has unprocessed data\n",
-                            M::FUNCTION
-                        );
-                    }
-                })
-        } else {
-            rpc_message.log(self.dev);
-
-            Err(ENOMSG)
-        };
+        let res = f(message);
 
         // Advance the read pointer past this message.
         self.gsp_mem.advance_cpu_read_ptr(elem_count);
 
-        result
+        Ok(res)
     }
 
     /// Receives a message of type `M`, waiting up to [`Cmdq::RECEIVE_TIMEOUT`] from the call.
@@ -1000,14 +988,39 @@ fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
         Error: From<M::InitError>,
     {
+        let f = |message: GspParsedMessage<'_>| {
+            let GspParsedMessage::Rpc(rpc_message) = message;
+            let function = rpc_message.header.function();
+            if matches!(function, Ok(f) if f == M::FUNCTION) {
+                let (cmd, contents_1) =
+                    M::Message::from_bytes_prefix(rpc_message.contents.0).ok_or(EIO)?;
+                let mut sbuffer = SBufferIter::new_reader([contents_1, rpc_message.contents.1]);
+
+                M::read(cmd, &mut sbuffer)
+                    .map_err(|e| e.into())
+                    .inspect(|_| {
+                        if !sbuffer.is_empty() {
+                            dev_warn!(
+                                self.dev,
+                                "GSP message {:?} has unprocessed data\n",
+                                M::FUNCTION
+                            );
+                        }
+                    })
+            } else {
+                rpc_message.log(self.dev);
+
+                Err(ENOMSG)
+            }
+        };
         let deadline = Instant::<Monotonic>::now() + Cmdq::RECEIVE_TIMEOUT;
         loop {
             let remaining = deadline - Instant::<Monotonic>::now();
             if remaining.is_negative() {
                 break Err(ETIMEDOUT);
             }
-            match self.receive_msg::<M>(remaining) {
-                Ok(msg) => break Ok(msg),
+            match self.consume_element(remaining, f)? {
+                Ok(m) => break Ok(m),
                 Err(ENOMSG) => continue,
                 Err(e) => break Err(e),
             }

-- 
2.56.0

