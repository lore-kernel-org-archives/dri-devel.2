Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3B9606A33F
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ooEjSKq/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE2E510E3CA;
	Mon, 16 Nov 2026 15:07:15 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D0089D60
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:07:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4N5oNBbnpCGE1ZBOZ481AM+fqhHckCm+iNIeE3Ni24s6KS61kmU0EC5HdgAPDon2Y6LTBlxBzCThGrUl5BFAQjvU6+wNsYL5TeW1yylX9T0fyU+1QIqPWSG8lXyUfWyG/pvswtEglh/TWecnIYuYBUy2MJ6VsDv7lT+Q2OoA1+MR9gzcLwTa6Lx7lpGnuQgjknLGVTPJe7p7s3JQvw+Org2IU1ebgIllRhMYg6coM3RqjorxvJzvICJcgULNrjizmBrUHKQwlza6TJlhIEw7qMFPKVA29HYbEB143FtqZNqm6fS+Km3rZEEehEjBpEPVgYaghhapt/JaVN1USKlfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bse9+2Il7UV+C/3axnKPxI6c3hLTRY7zowsrGtYzDWo=;
 b=hXf5D/nMAtAynwPK8EvujbJNcBoFGtGMa+JBPIdAiSDSqCyqSnXWL8BnPQ0w+3VhhJuIFZYF72Ix8o3YpfWPUYnGoAXGA7I2ViPqqZ1HmG/PlzxTMjciFFyNO4fqgJeqsby+LfACma3ZZFyJ9NDVWGlLGkO7BHRmfGi9YdNjA/CnDw5XJNMicFjOYX5QuE6W045g9Av0KNlZCnQefRsc8r91sqkTwJtmpPm8stMtB5rRMvtOugVCUowV+UbJrxDEKI7FImw0YQDVaCSptnROPUXDw43jhyRcZCzVdH8P3PuaxkhtBXmHo5R8IuppsRwz0WVyzNygr9zz5V/rkTd6zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bse9+2Il7UV+C/3axnKPxI6c3hLTRY7zowsrGtYzDWo=;
 b=ooEjSKq/FzJQAiMwH90VsCB6RX8VDj8N/VSYhXMKOYOR6ehe9vmhxApPG8ezg7GyUHL4s/YhcTtU43hlsh4i0l0hNWrPhPBTpkSXE5geUmZmAvqBS1NpqBJyR6tuQmtvmWifIb/FCfqRurhxubQNmMmOdbk6Kk0KRVvjMo5Nry3F1wRYmAL4GbG1LcCdvDOPT0J936gjU+jYxGmjDlNzGn64QlDxOfByGnneCaV4PTVJ0U4Qnf1VTLJS9F8L5HYnuxL8TPK4K0JAXKFuQRUjpDFkIm1GtTSPSHEM5rcGRmTtbfVOA8qWet5xGhBBTzU6DOnl442IGo5lkLD0QHssOQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:06:57 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 15:06:54 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 17 Nov 2026 00:06:45 +0900
Subject: [PATCH 1/2] gpu: nova-core: gsp: cmdq: let GMC commands set their
 completion timeout
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-cmdq-timeout-v1-1-4b50d0be335e@nvidia.com>
References: <20261117-cmdq-timeout-v1-0-4b50d0be335e@nvidia.com>
In-Reply-To: <20261117-cmdq-timeout-v1-0-4b50d0be335e@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS3PR01CA0084.jpnprd01.prod.outlook.com
 (2603:1096:604:da::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: f7203c4e-7794-4daf-a64a-08df43f3404b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|23010399003|261009223027099003|18002099003|22082099003|3023799007|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261021135927099003|261102123227099003|261022105027099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: S0vQeB6Jd3PQzZUtAts+hZWJ4WKDi1JEYvif622Yev0Bbsm9tXfUr8+hWAw8zeAGoDbnpne58rxmFnvSu7u/JVifvbG82NZCJbO0j671TTpn1sMqpdOMDmvkFMdUdX0q80eomlN2IVVLRplL0s2grXRbIN5whRCZSMhOrGgLjUj6U4mT1l/9C2ax2K6oO+qGSBJGM96JskZXcB2I81YcD81nxQ3gwttBECTZYK3CqpsbzNkR2r3mUAWxSXbYiF8Uz1tBpIE5FahGW1HL5ztYAt7OQP5tjPTsCFtZ67Zx6v9aA2tmgIJjNXkRAbyq9Mo9g6QckWJGALPL615rFm7fqlmlBb0YaYRfyh3cYWhVTGZ/v8Bh7i/brjiGqs4LhyV4MgJNw6eeK5FGU24KvTyzsfw/Sagu58aG8CeJltrWorOE73501JCtePe5mbCZoUsdHN+y3JOaw3xT+czU6wM0bKFilNfcQgfaVoGnSejolB1mfNG2EU45ow8XtoBlO5I92nrp247oYWalSoFHBCMnRoCafyHmaqo8ODfFm+anNUYnFq/fuiJU59Hpk5Cqr8spZ2H98WGEgfqxjrR3obiVIiYXH07hWOvsihf7Sqns1VOvRVEdKwNB8ze/OTZPiYHWVSk/rasQTiyAVBs2FBbC9WRYud9oAPZ4WVTqyeRR20I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(261009223027099003)(18002099003)(22082099003)(3023799007)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261021135927099003)(261102123227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1RxSFpUQ0w5UGcwMXlpNXdiNWlmbkgybEZiWk12eEt0dTJNcmwvR3B0MUY3?=
 =?utf-8?B?bm02N1dSVmUyYzAwTklKNmFQUHlrQUNQRjNrOXRNMFRzSXUvcWF1U29lRVZ5?=
 =?utf-8?B?UlVsYzN5Uk5memJ6NlB1Q2IranE5SWxhYjYrMG9WR2cvMlExdzFoS2FScnRx?=
 =?utf-8?B?UEFkMHhSU3dVYis3S1R5aDdiL2VWcFc2eEFCd25WQnAvSGVqK2d4VU9BWlBD?=
 =?utf-8?B?VkdOVTRXZzg0eHNnZEZISjRtaU9Pd2pucTYwMnRBUGYzTTBHN2lod0laN3JH?=
 =?utf-8?B?NVlUUHRoRmsrcVdGN1RlKzRneUx0eDIyM2lFZFJVUHRxd3VpVU9NNFVlOFpH?=
 =?utf-8?B?c3M4NkZ0UCtFallYclFtRDdvVFBiWUdYMTY1N0loSTkzUEdSOHRURlZiZmlT?=
 =?utf-8?B?NkZWQ05vdjV5NmxzZUY3a2pRUkpMZlA2TUFxUGU0OHVSMTFRbGl3RjFqUFhM?=
 =?utf-8?B?L2Ywa0ticWxxcU14OXhIOC9pNXdsQ2swM2FJTEVwTzA4QkRSNlk0bGxuaWFv?=
 =?utf-8?B?TFdaVGt5aEhub3dQUXUvQWtUUjZ0ZDU4aUtJN2lYTnpGSWxtRFNYZ2JYNllZ?=
 =?utf-8?B?RFM2Uml2VGNWNm9BNU1Ta3Rka3lRVG9Dd0hTdXZJYS9yMm5ITDNJYmRieGJa?=
 =?utf-8?B?UUU1amdQcEp2blplYm0wemhJTTFnM0pRZzV2VS9lMFQrTzNUUUVaQ3ZNUXo4?=
 =?utf-8?B?c2lSZU5aNlR4QlVtMTlmLzRFbEZsYlVzdnJLTmtJbXI3bitzcG9oVTdjd2Rw?=
 =?utf-8?B?ZWpnZzVFRnAzVVNMRU1WSHg2NlJ0anVOTUlNYWloZEtiNjZVN0p4TkpFdlhX?=
 =?utf-8?B?aHFJSGpTeXM5VUhhMXNRdHAybFB0VkFPell2TnZ4TWJpTThzbXBIYmg0N3hR?=
 =?utf-8?B?S0pFY3c3Uk5idGhqL1VsS0J3d2UzTHI0QkFvTnowOFRFeWpic1lpVU8xeVJu?=
 =?utf-8?B?T3BvTExscC9KZ3djcjc2K3pDcXlCS0VWZ0greG1zMUVRUGl4M3UybXVydEVj?=
 =?utf-8?B?ZzJVdWxBZWZBQ0k3YlRaZ3JqRG1vQndwcCtTZS9rdDhNbC9WQjBTbDJnQ1dO?=
 =?utf-8?B?cHh1aUZ5TkVRMmphbzNyZFVEa0xQUmlERG1ibUFWYi9CNGR1S3VKNFJGUS9R?=
 =?utf-8?B?K2JXZTViOTdDZzNGZVI0ZzZ1bGRFdXk4c2tPeW1tZGFyYkYyWnlmU255U0c5?=
 =?utf-8?B?cGRWY2dEM3BOWjlycWgvS3A5NFNlY0EzY3pzVVRHNDdKaFplT1NKYTJ6V0JM?=
 =?utf-8?B?aEQzc1d6S08rbEl6SkljbFpUQ05ZdmU3dmRQOWVQS0dqS0xqSk1UL2dYS3BO?=
 =?utf-8?B?TEJqK2NuZ2JMTmpsSE85L2JtZjZXdXFOeVNsSFVGNjAzN20rdzVBYVo1TUsx?=
 =?utf-8?B?RTdEbE9DbE1QVkRha2RXQStJOEZSQnVIa0VUaisvNW9jc3NQZGkyQnVsRGJn?=
 =?utf-8?B?MWNZVXJzbEtpTER1WkJ4YjlUdmNKcE45KzRmL3BwR0wzdzZjWGRkNFIyczl3?=
 =?utf-8?B?V2l4VGZmS2ZOR3ZLb0JibXMzd0UwLzF0SCs0dTlNdkNFMGFYS3BDSFZCOGRE?=
 =?utf-8?B?cElZdUhBQklSZkE2ZENqTkVHOFpEVk9PWmM1UVJ6NmlVVGVaUXdteFprM0d2?=
 =?utf-8?B?ZG4wRzBNTXVsTG85OGZISkZJeGovZWk2a2gwM0hwM00wVi9Fb2p4Yk41RUVZ?=
 =?utf-8?B?NEZQSDdBYisvVzluRGNyNUlDZEplZkJDYUJLSjlLVWVKdjlEaEt0WVM3QlZi?=
 =?utf-8?B?ZUgraCtIYi9ObU53OXFiQ2JVdUM2OUZ6aTA4YkxnMXRYdlcwVjRhRFZHUHpG?=
 =?utf-8?B?SHUrZVpReDhJSWJyZ09vOHdHOUVQMzNxQUtBYzYrMGJoZk0rMTlqTkZEYjFC?=
 =?utf-8?B?YWtTZUJtMzFJM01qTUxnNXdsYzl1MmhPZ09idERhVTFCK0FleHlyUmkwdlFD?=
 =?utf-8?B?TVQ1d3NGN3dpaDVVM01rY2tOSXJvaEl6ODEyalRGeEpLRGp3U3cwZDBiNkJB?=
 =?utf-8?B?ZTN4c0REMUZoanpVWEt4L1JkUWFhV2haZy9MQzlJVUpRdmJsU2JRYTVmUHRI?=
 =?utf-8?B?eTFlSEd4dlRiTjN6SUpWaDRRYWRsYTUyL0FxdWFNMVpJSlFNWmhzVU93Q0w2?=
 =?utf-8?B?eVdJbVBkU2VYUW5JRW15NmFPSGo0UHozZzR6cWJOVUcvZ3BVVkoveDhWUFBY?=
 =?utf-8?B?OWFLQ1g0QnZvVytzRm4zcGYzTVJwSnlWV3ZxVFl3cVplWlEyR0VjbDRMckJr?=
 =?utf-8?B?YlJXaVVFMW1PWjZ4QXcrdlFpSzNDeUpwTDloTllaazQzc1BaQTlCaUJSYWdu?=
 =?utf-8?B?cGk5VXdPUXZjRi9BbWNBSHRPN2ptMWVKdEkzSW5BdTlVS2k0eWdkVk9BSGdI?=
 =?utf-8?Q?yVK4AW0moPykme3M4MiukJtua4wsHhUK6zpNpGCXzXnfJ?=
X-MS-Exchange-AntiSpam-MessageData-1: 1JTleiqai1OCjg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7203c4e-7794-4daf-a64a-08df43f3404b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:06:54.5938 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFchGx2XBihzBfqFPJwt1t0PfXySVLzW4OYrroarK7QQ3vKXqqiH/GARmN0J5yYpF9B3x1NSoveC65mVjWhIFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4228
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Every wait on the message queue uses `Cmdq::RECEIVE_TIMEOUT`, but some
GMC commands (notably r000's GSP_INIT, and a few vGPU commands) might
take longer to complete.

Make the timeout a parameter of `await_msg_with`, and take it from a new
`CommandToGsp::COMPLETION_TIMEOUT` associated constant when waiting for
the reply to a GMC command. The constant defaults to
`Cmdq::RECEIVE_TIMEOUT`, so existing commands are unaffected.

No functional change intended.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs     |  5 +++--
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs | 14 +++++++++-----
 drivers/gpu/nova-core/gsp/cmdq/rpc.rs |  2 +-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 8d34acaef9ea..ad37c979d8b7 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -686,7 +686,7 @@ fn consume_element<R>(
     /// Consumes messages from the queue until a message that satisfies `f` is encountered, and
     /// returns the result of `f`.
     ///
-    /// The message is waited for up to [`Cmdq::RECEIVE_TIMEOUT`] from the call.
+    /// The message is waited for up to `timeout` from the call.
     ///
     /// `f` is expected to return `Ok(Some(_))` with the result to return to the caller, and
     /// `Ok(None)` to signal that the received message was not the one expected (such messages are
@@ -700,9 +700,10 @@ fn consume_element<R>(
     /// - Any error returned by `f`.
     fn await_msg_with<R>(
         &mut self,
+        timeout: Delta,
         f: impl Fn(GspParsedMessage<'_>) -> Result<Option<R>>,
     ) -> Result<R> {
-        let deadline = Instant::<Monotonic>::now() + Cmdq::RECEIVE_TIMEOUT;
+        let deadline = Instant::<Monotonic>::now() + timeout;
         loop {
             let remaining = deadline - Instant::<Monotonic>::now();
             if remaining.is_negative() {
diff --git a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
index 04033c64ca72..512a327a1c89 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
@@ -6,6 +6,7 @@
 use kernel::{
     device,
     prelude::*,
+    time::Delta,
     transmute::{
         AsBytes,
         FromBytes, //
@@ -61,6 +62,9 @@ pub(crate) trait CommandToGsp {
     /// value).
     const MAX_REPLY_SIZE: u32;
 
+    /// Time given to the GSP to complete this command once it is sent.
+    const COMPLETION_TIMEOUT: Delta = Cmdq::RECEIVE_TIMEOUT;
+
     /// Error type returned by [`CommandToGsp::init`].
     type InitError;
 
@@ -283,8 +287,8 @@ impl Cmdq<'_> {
     ///
     /// - `EMSGSIZE` if the command does not fit in a single command queue element.
     /// - `ETIMEDOUT` if space does not become available to send the command, or if the reply does
-    ///   not arrive within [`Self::RECEIVE_TIMEOUT`] of the send, however many events arrive
-    ///   while waiting.
+    ///   not arrive within [`CommandToGsp::COMPLETION_TIMEOUT`] of the send, however many events
+    ///   arrive while waiting.
     /// - `EIO` if the variable payload requested by the command has not been entirely
     ///   written to by its [`CommandToGsp::init_variable_payload`] method, or if a message fails
     ///   framing or checksum validation.
@@ -350,7 +354,7 @@ fn send_gmc_command<C>(&mut self, command: C) -> Result<u32>
     }
 
     /// Receives the reply of type `C::Reply` to the command sent with sequence number `seq`,
-    /// waiting up to [`Cmdq::RECEIVE_TIMEOUT`] from the call.
+    /// waiting up to [`CommandToGsp::COMPLETION_TIMEOUT`] from the call.
     ///
     /// Any GMC event that arrives first is passed to `on_event`, and any RPC message is logged.
     /// Neither extends the deadline.
@@ -376,8 +380,7 @@ fn await_gmc_reply<C: CommandToGsp>(
     {
         let dev = self.dev;
 
-        // TODO: replace `u32` with `NvStatus` once it lands.
-        self.await_msg_with(|message| -> Result<Option<Result<C::Reply, u32>>> {
+        self.await_msg_with(C::COMPLETION_TIMEOUT, |message| {
             let gmc_message = match message {
                 GspParsedMessage::Gmc(gmc_message) => gmc_message,
                 _ => {
@@ -386,6 +389,7 @@ fn await_gmc_reply<C: CommandToGsp>(
                 }
             };
 
+            // TODO: use `NvStatus` instead of `u32` for status once it lands.
             let status = match gmc_message.reply_status(C::COMMAND, seq) {
                 Some(status) => status,
                 // Reply to another command, e.g. one that timed out earlier.
diff --git a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
index 10d3f68b2f61..012f3c82e7c5 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/rpc.rs
@@ -401,6 +401,6 @@ fn await_rpc_msg<M: MessageFromGsp>(&mut self) -> Result<M>
             }
         };
 
-        self.await_msg_with(f)
+        self.await_msg_with(Cmdq::RECEIVE_TIMEOUT, f)
     }
 }

-- 
2.56.0

