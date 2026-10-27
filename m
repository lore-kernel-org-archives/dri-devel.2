Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F070D60A6F7E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PLOxvOee
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BAE710F2BC;
	Tue, 27 Oct 2026 07:36:49 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B8E10F2B8
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YmmL+49YBWj2QdME2ly2ZyGhEd+3Yaog0bycHzY5KZlNHEm8q8RmlqwC4oTal1hh7WUpBXa+DNNByR3L46PQh6ETESDWgoNu7eIrKVBiNAFEq2kzHYZmL9zRj4D9eqC4LXVPsQvLbvbXOhTLPZVxlBpRFpUI2zhziyGxbBQgbFQeu5uebbBTOplMCFxVsayCu4yJ8r5yTdCQ70K9NW9RQn3GrP9jqBwted79LrUdP2mFVsxSuqmcK0T0iFyCsEW8MtrhFnw7OSldgCF2qeDmM1mjoZ4g2RJXfR/8RMOTWtSyJKHZNhrWD42+lyWPjBexeV0OViQ45X4g44xYRtO2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJgiY2XhD7WkCfY/76dSK5i67HEfv28Y57lViEqkopg=;
 b=aiQh8zSkGQK3B7ok2H0c/v7LdjQIvrYhBg+4uOqDlErJJVV9V2V/JLtrz4uPSBYwzyYbbfYdP6ErQu8DbTHR0f6jcVKXJ/5HuvP0kw0TQcAryqjCDaG4kC425vHyhhNSSTcOZY2EnQ+SQHsc5IxmdLli3m4aW83LdmMrmJiJ3E6omCAdWTWrlNON2viMmaFE8G23gW4+XFMO08XVp6BVsV6ku6qT86xJvlgA1fNl2+1Qj09zF4kwtpIHuI07y+AiJdRJcDRKrPwjggsJqersxic8wjScmYdqZb9m54W+4jIeh3/tRI5I3KQjptjewN5vRoQKksFxozg7d9vk/gUgGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJgiY2XhD7WkCfY/76dSK5i67HEfv28Y57lViEqkopg=;
 b=PLOxvOeelxccfD6ZzbqGKhb/dX0dbCClsGyE4dJ74YNM8ll5JKoY/wIrWI951TUWWaPcqW+2ZJWgd6jFC+jIbD3E1ZxYVSjlrlnVt+3MJy2LyJ0q5ekzYIwX6Z9pXGr3BlJZdhtx3/oQKUyOlSbrujh1po32KbZGWmv19RV693EIFtl/FbRlUF2qEzCB/8ph0LcHIOsycXxsNt6V1U6c3f1eU4t4t484VzzHUmaiSxt3RGBJ7SUnJMBoEqu7Mdw0k4O0ZkH0vMWcExGlDMyJfvGppcJPFh38G3kM0pwe11I77I0RpvWJ7ggwkPeQpERDoWuIMnomTrNDIUL5B2mcAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:19 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:19 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:52 +0900
Subject: [PATCH v6 09/15] gpu: nova-core: gsp: cmdq: split the transport
 part of the receive path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-9-bed9669724ba@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0038.jpnprd01.prod.outlook.com
 (2603:1096:405:2bd::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: daeadf5a-4fff-4c20-9e1f-08df33fcfd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261026121527099003|260925021311599003|260925022911599003|261021123027099003|56012099006|11063799006|261021135927099003|261022105027099003|261009223027099003|261022075727099003|261021121427099003|10067099003|260925021911599003|22082099003|18002099003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info: e3Mh+6wHLjoSEq0r8nGMkjrLn9jKBrdMc/gCXybZgwGeayct/lu7sNWlzso8x8CzFGh52C53f4+2br3ZvtcjauD1FxU42yTRXOXbiVxgexu/qQO40dkmfcTScYDsZNAP6upCG2N+ASePxVQC3kg/RXXhNB5NCp7nJrE09o67Bw4vWeQ92C+ZePLJTafJRHBLUceKzqDtB1mlhlDQDpT8fZoRx/cJY7130v3Vyhy1k/ESrWMF18NJF2SVdCA/3jhisVTUVTtBbm+oCx7iMpPO1COWiHzyDQQ0D6okPtDMpLfvIei9SJuYgIPH/ArP5JXapI2tmHBAHe508tL0Dfc4fv+f+9L7cmEVY0/dfen3DF6ONX/YLaTCDoYYXWpjG3f+fguX8OH7YPUh94bJUxBAcPej56WkUBpAeT1C8BhVHVQ3dFsN69U/vkpNW+6mI2g2DZ60++X2mL12igcFR92NsRLxBJU3Y1iZsREb0oRYYXATzDFc/5yzjREY/QAbw9O5RKVC3nxPpVjKJdg27tZ18kAYbz3hIWaUF0MK3mc55laFmWhte7hTA2rje6p41Bq9NQHhUPhd1h5zy9SUfY5glBA267z4/oGA2nu8Cp05jIdZqFeDhau6Es/vfWPwATIxGn9zlbNpm8SNIBZgQjauFkWQ8BvihV2F1/c+0Y+lEzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261026121527099003)(260925021311599003)(260925022911599003)(261021123027099003)(56012099006)(11063799006)(261021135927099003)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(260925021911599003)(22082099003)(18002099003)(261026140227099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NG5aYytzRXBNMldHZnBTM3NTdEg3cGtMeGVabmo5aU5sNTRzOGl0TkEyMUxr?=
 =?utf-8?B?UGE4TGV2dFhtL2Z6SjRoSmRGR2JXbSs0K05MZWdjR3VUSTI2ZDRrTytIME9h?=
 =?utf-8?B?cFVXazlVOFQwVFNhekp3cTVqMnlOa0RvSUF1aGFaa1lUWTZMT3pMaWlRNGk1?=
 =?utf-8?B?Ukk4S210S2pFMnp5ZjlCam9odE5lUkJ1b0FBejE2RGJENmV5M1kwa2JuUW1C?=
 =?utf-8?B?eTNmd3dKN1M5UndFeVVRVEFvMGprS2ViTkZPaEdUb2YzM0ZrdXIxUk8wRVUy?=
 =?utf-8?B?a3lUbGhITkxLMmZUV2Mwd1hUZ3JUKzB4Vk5KdHA4dzZQaysrcENXZlhlL3k2?=
 =?utf-8?B?dVQ1OEh1UlNIQlpFQ3RhZmpiOEtGUXR1d0JIUVNJVVVIUzg1WU5aZHNDUjdC?=
 =?utf-8?B?NlMwS2VmMXhGdzd3SHJvUlNLZDdlbE5KK2gxQlJLS3BrN0FaanZyVjRRS1Vl?=
 =?utf-8?B?VVBLMmdEbWRtTFdLMmNCVGRNckU0cFZyRml1RDROekZscUtJZFhMaEQrbGhu?=
 =?utf-8?B?QmRTZFlwMG1RYVZKbW1GbU9IY1QrSWJGU1JQN1BvdFdsQWFqZlZRS3ZyMXN6?=
 =?utf-8?B?M0ZoWUlXcGhBdk5IQjNuVmFuMitxK1lBY1QvOG1UT0JBNWtlRlVxVHUvQjhy?=
 =?utf-8?B?MWhjUGE3V2ZLQ0VuWnl4aDBtRkwwRzljZzRHaWZHWkFsV2x4bTAwdDFKdDgv?=
 =?utf-8?B?UnBmZlFwWHhnNDNxMUEzbDhHTGR1UzNhNm5Wa3pFaE5Fdm5ZVFJVZkMzZTA4?=
 =?utf-8?B?Y0xSOHhOWHhWdVVxMjcyalFOMnNhWFM2UlpDUDNqV0k1bk5IRFFFcDRUbitk?=
 =?utf-8?B?dmtObGNCNjZmZUczVUlGTW4vcnBsZTlZdTJJT1lLcVBNeXhrS0MyaThNZnFi?=
 =?utf-8?B?VWg1WDBqZE9CaHBXUk5KNHkyb05LbWdocnVBQTlNUjFiTUJJZ3YxN3lPSHZ0?=
 =?utf-8?B?b1FLNGFHWWpSdkIrY0JFZGhrK1VTTXZQWHlvU3VQL1pvZGNWL2t2QWUrNWJL?=
 =?utf-8?B?SHRXQnZRbDlGTW5ONGlZaFRrWTNlbXY2c3hXNDAwRWVUNXhvSXN0WnV3c1BD?=
 =?utf-8?B?SkhLY0I0MkdITk1NRVVQQkh4MlFBcDBaMUJiTStsRDNYdk9PUG90cU9jQ0Ew?=
 =?utf-8?B?Y3Y4OWk5MkZ1UWs4R1hXei8wOWxuQTE4OG9LUUFjaVVMZWtMWnB0Q3NmSGph?=
 =?utf-8?B?bkdWMXc4UEtEYXgzaU5hV1RkaVlFU0VLQWtJOVRWSEh5dU4zbHdVNy9hdm5o?=
 =?utf-8?B?SDkwcGxQZjBySGhqRUNxdnhLWWt5alFiWXRZSTViRWpBOGR6ZVBwZWpteVBq?=
 =?utf-8?B?ejVBdVFZYm9LR2pYQUJJZklCdU9FTklZeEdac2c4TmNhdFlUajJ4SlljM3NN?=
 =?utf-8?B?TG9mQ1VOSVVFNFFDeGpGNWVXc29PM3ZsZEVZRkVlRU5zTmpjeVIwWjI2WUlm?=
 =?utf-8?B?TWY5Nk8vUHlXdWhkNDJPeVhLazF0R1M1K1k0RUZwTnFQNGNNWlg4TTVERzRn?=
 =?utf-8?B?S2p1RHlhVGM5Mm1JeFZkSG1aNzB0RDM4Um9aSDYzaXpkOFdvcExWZ1AyZmIr?=
 =?utf-8?B?TkllYVA1TGZNd3YwQkd4dGVZVi9DRGNUalV6aW94QlF1eTlIeGNETXJWRXdx?=
 =?utf-8?B?b1BqSForcHN3RkhLb0h2Q1MxUXBQYUVITjIrMzZNcDBBeFhlT0tZVFpvWllB?=
 =?utf-8?B?Y2NEcFQ3STVBZkh6bGtMSjJrbVlJTHE1N1dTa1JqYUtybzQvUWkrSUFyclV4?=
 =?utf-8?B?UjhwUk41T1U2OVlrYXNCZXdJeUtkVXJwS1dPenE3L0R4cGdPSGFZcmtvMEN5?=
 =?utf-8?B?RWdyc09kaUs4M3dHYm1tMm90ZU1MN3QvaGR0WTRjbzVQdTJEcHNXbkVZdUpH?=
 =?utf-8?B?SUpETm9jYXRQbmoxS1VwZ1pqd3NwSzZ6NWdhNkViN3B5K0d4Z09MY2ZzTEVD?=
 =?utf-8?B?L0JyaVF2R2lwZUVQK3RLamtZVGUyOExTaVpKTHI1L085STZhMEdHVytmWkVx?=
 =?utf-8?B?Q2FhYk9OQ1VZTDMxREhwU25scHFEalBmWEcxMVNSSXI2QzNyc0xWbFF3d3Jo?=
 =?utf-8?B?MjhmQkZrN3libTNrNFdIS2V4ekVzK1dkVTJwV2JvbERzRno5L3VPZXg0cWhx?=
 =?utf-8?B?S1NtRXRsTmNibzh6eXk0M1NIeGFEUUUweEZVQU0zaXRxaEpMSVhMN3FjS3V2?=
 =?utf-8?B?TTVsRHVxVFRmOWFVSDRGb2NNeFYyUVJWQ1BBOSt4NGxQNWNHekx5em5ubHor?=
 =?utf-8?B?OUFLaldCZzZ0M2VqWVkxZnlENHczZmVicldvOUtpSU9hL0xnVjVicUIwazM4?=
 =?utf-8?B?OGlwamdWcWltZVIxc053SXFzYUdLdnJGTzlUNUxncjVQUkZxU0QyQnRMSCts?=
 =?utf-8?Q?xa4tTSeGTCcanJheUFg8JFsl/IthiUZ4It+v6S3v87Uiu?=
X-MS-Exchange-AntiSpam-MessageData-1: L+hayEJOWrpEJA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daeadf5a-4fff-4c20-9e1f-08df33fcfd0e
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:18.1567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieH56cHlJnbUj5pz87tCL/KJ6Ggc8ehImMEJxvf1biVxAW0+Jjux3ggqwjt9PCst49n/1yVpEOdYbjr3Mlr7LQ==
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
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 Documentation/gpu/nova/core/interrupts.rst |  7 +--
 drivers/gpu/nova-core/gsp/cmdq.rs          | 96 +++++++++++++++++-------------
 2 files changed, 59 insertions(+), 44 deletions(-)

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
index 4efc96eba4dd..6075868638ec 100644
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
@@ -930,57 +936,42 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
         })
     }
 
-    /// Receive a message from the GSP.
+    /// Wait for the next element on the message queue, pass it to `f`, advance the read pointer
+    /// past the message, and return the result of `f`.
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
+    ///
+    /// Note that `R` may itself be a [`Result`]. In this case, the above only applies to the outer
+    /// [`Result`] returned by this method.
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
@@ -1000,14 +991,39 @@ fn await_msg<M: MessageFromGsp>(&mut self) -> Result<M>
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

