Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC1606A888
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E3DLAUAN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C09A210F279;
	Mon, 16 Nov 2026 15:07:22 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011022.outbound.protection.outlook.com [52.101.62.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D75310E99A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:07:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1Bl+U3lHIK4ID4+8SJCTtECb0j4eWgJ9/mnFcwvxVA8ny9SSIbUIKwr4iJoZH4bPgXdG/L7IvAkxiLuBmT4s0FgjwjfAVlaKOOoH+iy/4Cspv6rnZbP7ljBrTcy+ZFXfXYHFcC/0rR5KlqwYNT2AQve8ae2KtKuQe4LZAtF3FhlYON+0vdOJvexb3CgEL6YRnUUsZxj+dExT1+Ks7iC3h3jHvQJEHq5aITBA1of/7jmSTVy2L8RH5mMey2ei4Ri+EAMukWHI4Ar3B1wwfudHPeuwGDrkeP6CPCMzGdviOmBzNYpMMHlo9aalRLgtS39rlN5eqStGO5QSXNk+a+v2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlM25KubP1JjXudx7tFtMp39CDViPzHNhvG3Ir9VfAM=;
 b=y1BVEwoQ7yO0mpEp6QDUwa5tuqOUnC772uRdOU37jlulwf3rnFvXJSin6O8hbNYriKAzObv8VBb4yO8aoJanJboOCd1z88cOiKRQzzdbSnvV15o5Eii4y22VTqnQphtAhKRBxEvbVfYDT0/w1EYJKxcIsO0Aa4HbPsbTEzy8aCdbTYCT8fJyFCr9sWubGHDKonHTP1Y6QWQfzwQlx4r9D5cgtihVmcWro/Hj0+ebSF1ztHEUklqUjQaofa+Cx9IY8nB8grGJ1O+T+bauzM+ckIXXattEQqozraUcJi609mPWIFift4lY3RA9gqyzHBvvKu7S/epBDxpD0jV/IcVAnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlM25KubP1JjXudx7tFtMp39CDViPzHNhvG3Ir9VfAM=;
 b=E3DLAUANd+KnlqwarlqWwsFRBkH/j62Yi/sLWYUhwJ5191CNiVUUQD3uJUPQKuW6L6zXI5tr50hSw9r4RmqlLQm12uNkUVIujVloKkrE8ZHO1UuHF4RzZOWAurPJAysUxBQVAqNWsjbLTMsI3tuyo6+M96vNfeRqagAALianymRkzGawT/BGHXw6jlIzmkfjJWV4839b5TIptLM54QQDDHR+rRAIrMGSEne4WyKlhdVfTIP0/rgfpbWTDb4ZfVgQPNY1yGI3P/BVeR08CF5T+3Fs7w4Q2I+6XB0LMhiW4ksQ3D5WYsQliWASEgDKI66ijpnz9OpDDwK95AQkaZQX8w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by BY5PR12MB4228.namprd12.prod.outlook.com (2603:10b6:a03:20b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 15:06:58 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 15:06:58 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 17 Nov 2026 00:06:46 +0900
Subject: [PATCH 2/2] gpu: nova-core: gsp: cmdq: support GMC replies without
 payload
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-cmdq-timeout-v1-2-4b50d0be335e@nvidia.com>
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
X-ClientProxiedBy: OS0P286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9c::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|BY5PR12MB4228:EE_
X-MS-Office365-Filtering-Correlation-Id: 4335d0ff-a055-4cf5-c806-08df43f3427d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|10070799003|23010399003|261009223027099003|32116099003|18002099003|22082099003|3023799007|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261102123227099003|261022105027099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: YZ5a6ZarW2j1VP8sgW+R5Mj0fRAstgaqF2XwNI168TK3+4hqASHHnPhTm7q2XU3IaxTe1XOnLnG5ujtn5/PtkEVrsXQQaXLUgXF24aJ7RXz3c5bL9Y5U3yvIsoJBHJdeheoPOZj6Jf5tPH0SR7WpbOFOvG0A/nmpSGG5231iSAuaO0iWHlLJpf5Fceb/Ybs2rNSY66hWwEOu1nPhuprsOZ710GvWV6DCx8/0aXZjlLccPE76dhTxH0VokN1YRrz3waRCfYw3SYNaY8iYngY7spSBh/R7dSWl7esziJguO3LxEOD6+n5zapCLjxeHwb5HljQpd7oq87uTddV9F4ueQU+awFnNnvprALi9jQxeaXocPIdnWnvwxbPG6o68iVYnVyWoUsRF8k7725fUa9sdFfofaFf5twsYAgCCa+dV08QviH+RVd1dp1qIrQY/Nw5LZ5HAlgYfE1gPxwJxCnBA7NhlLu8Dm87Rb25hHhoZWECXE042iqj4YBmgEM2W79r5LTFqxKLKGs8eZtNymhmZnruJdjnxOQhewh0Gk4ICxG4l4awmg+XVv/utR2fX8jsw8FuTw9ET2v/9mM8ds8HlENEfehT0sWeVPq4fQnhjqgGYD28HaDW35ZDwQqKzNzkfVthV/rQD0beNP6kcfJNdlKHwHxGrJi079pJTZjZUFU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(23010399003)(261009223027099003)(32116099003)(18002099003)(22082099003)(3023799007)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261102123227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dW5GMVhjNGRTNm95b2pLTmlzUHFFVjAxckN5bVZ4cStlWTM3TkhNQkhDZkdU?=
 =?utf-8?B?aURCclBUdi9OYVg3cEdzcEtOTUF6S1A4T1ZpZ3dXNEVRSEczQW9uYlZpNFNv?=
 =?utf-8?B?S0ZTN2RQRGJzc0dLVHkwTHVlRGFsZHZOVlBxQ2lDbVFjZ1FiaVR3TUFCRkpG?=
 =?utf-8?B?N1ArYjhHVVRKWk9OMTRVZmYzeVFvakRiZ1dwWG50WGQ3c01tMUVjcyt3V2w3?=
 =?utf-8?B?L0pEK2xpR1NDZnZVUS9KQWIweldLTzhTU1VtcExvcThVR3RpZ3ZFVXRKaG1G?=
 =?utf-8?B?bHkrd05XclBEc21pakZwbEJwNEo2UFhHTTkvc0x3amRtYlZ6T2hJdlFxVExJ?=
 =?utf-8?B?akNTSE9JbjBDVzZLQStHQlh1bDBYM014TnBjNVZtU3N4dWZlWW90ajYzRGc2?=
 =?utf-8?B?a3Fwb3B6OTArR3lRVmRtSEUxSjhIMWJ4V2dycnlLV3l4cytkc0NFMUYxaERF?=
 =?utf-8?B?TjBaOFJXVzZtdXIvUE53MktZSUtXSlpQSHdveSthR0Yrb0o3QXJXZXlZQjZs?=
 =?utf-8?B?N1Z0ZkVXQ0VUNVB3L2t0cGZneDAzYWpTT0VaZGVqclR5MFZxdFNxMTRqd0Vh?=
 =?utf-8?B?ZXd5Uk90MDR1VFBWY29McWZqNjQyYy9VVFlvTHhUc3lKMjA0TGhLZ1B6aHl5?=
 =?utf-8?B?eWxIYkU0UVFzR1R0dWNGYmRCWUlkV1o4UndnNTZvbnpSNnRBK2Q5OTRmUUtt?=
 =?utf-8?B?YnU0WUd1WFZvSzNtNnhmT2JYNng1bU5hUnVDN2sranllNW9ublFJU28zMTR3?=
 =?utf-8?B?TG9pTXdhWVlVZGdHVVZpYXBWL0wwZWlnN0VsMnJ4Rlc4cUMvTHB4YlppckIx?=
 =?utf-8?B?UURuQWFlUVd3SGhidHFlY0g2Mkc5WjlZNERreStJVnJxbllLWlhKMkExMlo0?=
 =?utf-8?B?Vk1HZjFxUkwwdUFEWG80UFZuRFEvV2ZDSDN0WjFQZk5DK1I3U3V2VlpFL1Z4?=
 =?utf-8?B?djlaVC8wcTh6QTR1RC9iWGN6aE1md1FRbDE3cit5ZStXU3UxbkFsTENwM2Iw?=
 =?utf-8?B?TXdaMlYwcFZ6U1FiN2VVN2U2aUJkclNlY3FBcmZ4d1JYWGZ4WWlrN2V5RGJ3?=
 =?utf-8?B?aHU0eE5XN0p3QzA4VWMzRk5uLzZrQnVTT0Zva1FWN1VTT0MxYTdBQUd6S2dD?=
 =?utf-8?B?QVR0QjYxN3A3NzljRnZCaE1teXFtSVIrQXVLMC85TVhOTnlWRFlrUHNOaktK?=
 =?utf-8?B?WnJ4aTRPakNmL2pEaDhGSEFuK0dwcTF3dWtDU1kwTS9pSGRYRHdYeE1oQmFr?=
 =?utf-8?B?NGRubEV5QnVvc0dlU1kzMVRTYjZtYU1nVXQvZHR5YU1Sdzdxakx3SkxqZEkz?=
 =?utf-8?B?bjBZMkk4SDV0QXZXTjU4TTNXNTZTYzV2M3FXUWpPdW9CbjR3Vk5mR2lab2E1?=
 =?utf-8?B?SzNqYjRnVHhqZjM2ZmQyRkF2M3kxdkdwWWhCYlNCeHQrWlpacnhUcURHdUNu?=
 =?utf-8?B?WXdQU2tTTng3aTZKbUZqdi94b0c5eXJ5WEo2QndwSGhuWlpKclhxS2RDQ2hS?=
 =?utf-8?B?Y3c5Yk9IVnFENjZacFVVOGowSlVEVzVrOHkvdnNiaXR1SHhnRFBweXovTE1i?=
 =?utf-8?B?b0VoOXloZXdyNUhpWHlzcWRYTjNRcFozL3IvdTFpQnhXbWtsc1RxYjI4ai8x?=
 =?utf-8?B?am1kUm5semYwbWhJVW1FL0Q1NHB4WkluMmIxKytsNlgrTDRFdXZxRlp5MmNj?=
 =?utf-8?B?RTAyVlZkQk1NM3h6SFp1Y3BJSlV2R0NtOFgxVTcrN0R4bHd1UWFmQndwY200?=
 =?utf-8?B?WnFXcEJNU2VpM0N3d2tualFDeFR1Vll1eEEyUFRIazhyakxrTXNvUTVnSE1Q?=
 =?utf-8?B?V29vcnZwNTRndi9VamhJWjd2S3J2MVVnZjd0YXgzRTEzMTYrdjZIa3I1S0Zk?=
 =?utf-8?B?SXpIZUZySlNXVUwxUkRWWmVQMmZ5RzRlZE80YVhUZHpGc29DVWlUNUJvU0hL?=
 =?utf-8?B?S2NzQUZ2QU1xV3dpV0UrdnZNbnpSQkxwTVcvOFVTYzBpNlJRSzJVRkdwUUNG?=
 =?utf-8?B?WUU4bmJkU2tyTTd0b1p4L1pMVWlLQmd5MnV2bmVOa2J4VS9YTzR3TE42STNz?=
 =?utf-8?B?UUFLclhJMFJjUGdocytFL3QwZ1ByNUV0VUpkU2c3U09ZSFF0OHpVa2dicWlS?=
 =?utf-8?B?NmFwMzF5dGR5aVgwS25aMWNHbEJocXdTYS96V2JmcnpSQWRnMXJFb2JNa0Y2?=
 =?utf-8?B?clhnVTRBTHVoN3QwNUpoc1ZqTU9MTExNUTFMTC82VGN6NUoyV3VUTm84cFNx?=
 =?utf-8?B?VFJKa3ZoaW1hejdVTlRyTFdQV3Z1Y3p1NnlORE12eUsya1lBNS8vZUMvN3NS?=
 =?utf-8?B?QVNTRTRLa0pUVElOY1NOOG9VS0ZnaStaVnNNZHNqb21UUmFFd05uaDB3VVBZ?=
 =?utf-8?Q?YoloS1r21VTtoAhJyL5rnerMfwz+6Wg3hZeEq9puB364U?=
X-MS-Exchange-AntiSpam-MessageData-1: rYT7tNcXzx6QjQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4335d0ff-a055-4cf5-c806-08df43f3427d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 15:06:58.3232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psNXKXGuF7RoalX4UnMa8rGXteQ0ZJsAsEP02GUeNpa9xpXSI8F8jVmm0hzddnqoKDPMxhgFJCZN9hxsJIhMeA==
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

Some GMC commands are answered with a status and no payload. Their
reply type cannot be `NoReply`, which marks commands that the GSP does
not answer at all.

Implement `MessageFromGsp` for `()` so these commands can use it as
their reply type.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq/gmc.rs | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
index 512a327a1c89..f4311593e360 100644
--- a/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq/gmc.rs
@@ -3,6 +3,8 @@
 
 //! Support for the GMC (GPU Management Controller) API message type on the GSP command queue.
 
+use core::convert::Infallible;
+
 use kernel::{
     device,
     prelude::*,
@@ -53,8 +55,8 @@ pub(crate) trait CommandToGsp {
     /// after the GMC API header.
     type Command: FromBytes + AsBytes;
 
-    /// Type of the reply expected from the GSP, or [`NoReply`] for commands that don't have a
-    /// reply.
+    /// Type of the reply expected from the GSP. Can be [`NoReply`] for commands that don't have a
+    /// reply, or `()` for commands that only expect a status code without a reply payload.
     type Reply;
 
     /// Largest reply this command accepts, in bytes. Zero for commands that the GSP does not
@@ -178,6 +180,17 @@ fn read(
     ) -> Result<Self, Self::InitError>;
 }
 
+/// Reply type for commands that the GSP answers with a status and no payload.
+impl MessageFromGsp for () {
+    type InitError = Infallible;
+
+    fn read(
+        _payload: &mut SBufferIter<core::array::IntoIter<&[u8], 2>>,
+    ) -> Result<Self, Self::InitError> {
+        Ok(())
+    }
+}
+
 /// A GMC message ready to be processed from the message queue.
 pub(crate) struct GmcMessage<'a> {
     // Reference to the GMC API header of the message.

-- 
2.56.0

