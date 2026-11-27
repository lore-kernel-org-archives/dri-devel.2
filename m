Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3017606A323
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=r7SNOvAo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE9310EAD8;
	Fri, 27 Nov 2026 14:04:27 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5875E10E9E4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfbC4AzpL23kLIYZIGUSgaRcyJOFMVx8Mene29e0kutUZHHI+VcBNxbTcjkE2ZaiJc1AMqNVtH38beIVPXj3+/H84w0VM0lkHEdkGqAqT4CPx3sg86m6BKvYo04K7rXNJoT4/onsiW8zsVM8mvu99+mtcfYfSnVAGhqj3ExbgmP33SGEWxFKBEAC1SjaJ5M8B22FauwKvI0ehH9U2ejntQS3haWodI90VT/J5NwQJV9wnNpZ+t6KM1VQZynbk5iHM+CtsAmFK1maHhQ1nWdF9e5xhxYsNBMIKwvMccdK2+BBCdVz7jb/hP4N/vEk3xLRxpnRutwRpzhNCCiSBxvmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8k6SOw56GPhhi1PrPmDN3Nu1nzexCkwFX/v0xQkhC1Y=;
 b=YjIfrl7QLc+QowR7nAQljBAmMvIqGxNjErFE44GiCQKNinMfoGcgofZPJdE5D47wW8Pgk7IXBpAKpPMisVWFOcArcuFGVhPbs/gvQkx2907mZ4/b6CSqMODvJVSsgsCVPcAmezq7NMb0vJm0uCi7ewRvxmtFLz/Yife8NKHsvNkBTAsaxIC3sy0DB+2hjT6zSSYOK5Cn59DZtdotpJqws1q2AkV98VNLooc1X7Z9H1Y9FBh898JmuPv0hczM1dKukub2LCVYTR+4NJoZ8gTUdtFAhf6oTF83Nuzs7svoJpD81TzV+P1TG5GBI/TX4Q8t3HD3QOrOK254kY58Rjd+PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k6SOw56GPhhi1PrPmDN3Nu1nzexCkwFX/v0xQkhC1Y=;
 b=r7SNOvAoMcvexEwqnCk9NvPQHR7tjF3yhXDKcYlMoSrcb5QrGvi46K7pjmyWNC9yAQHbZ8nHXTDrmo28rjnjNyoJm6fuN/XyB5XfZsc/GeohCtkykR/RdFXxtlpZcS7iktZddSIz42DazYrwKf2n8EDiWHCkbIR174ny8pzegiOrvEg0lwnPkc9VBKQVu7zZ6NjfY/C4MkHkd8Fmpqb1M704c11Pbse4OmuEeK0Wh3A4j/c2HRZ0KAfu/WmDBMXqZ1y++iWiFKQYaULzFWff3uL18wv4ekCaT3u2TQs6HctayiX6fEOMevBeyeRozKN5g2Uq4MiAIwMWIvZT8+WmBQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.4; Fri, 27 Nov 2026 14:04:12 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 14:04:12 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 27 Nov 2026 23:04:05 +0900
Subject: [PATCH 1/4] gpu: nova-core: gsp: add the r000 queue element header
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-nova-r000-staging-v1-1-4eaf6e3c0942@nvidia.com>
References: <20261127-nova-r000-staging-v1-0-4eaf6e3c0942@nvidia.com>
In-Reply-To: <20261127-nova-r000-staging-v1-0-4eaf6e3c0942@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: TY4P286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: c3356397-0d7a-41ad-7d74-08df4c8f506a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|23010399003|261026121527099003|10067099003|11063799006|261026140227099003|56012099006|261021123027099003|261022115727099003|261022105027099003|261009221727099003|261022075727099003|261102123227099003|261009223327099003|261009221227099003|261009223027099003|261021121427099003|261028144727099003|261009220027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: gx4BQYFZQ8IwESEMdsXz/i/lG+hByKx/qE9zCOMYGItwZyxFoY0K1l1hlVGydh+recQ48u0tQlnXnRRksrq25fvVuV48C0sxEln1xA0SEPjfD8rRqWIAzKHjZBRCpnftI5IwRP7Yq2h5otIZOaT3bfuvHYham78Nvhvniy0BKDq/DcOUgWN+ZheDNaR7Ufg8f1XpSjuFYbEDMu8uMDIhH42AxKf0u8+EWX5lJg3lupRzO3pfrliqKhlreiQAu8JzDQn+RClQ7XlxChjzDnFQgb1QODedQIpnwO+4qTCO8aK/jc/QEYSZg253kYWPCF89TnTXpPBIrwA9eAJLWYpXXmuSaTRThRQxmYYTCRIacEFSgAN0y9Ou3u8FnKE8xH/9NBVCivveN0kCQKuYFzlxZLXb9ZeD/bww9ssN+z6K3h2LQM/oZwtHp+IqVagNwWDk8PHfMAISAE2zmuLu6CyEqIjby4ECnFn2nddKacZq3GorC3JML5d8R8wC2aZNOglCdhQmmtKfsSFdo5RYzoJEoTkhAh8YvOQKMFWdR6Q/YJ/4n72pGVy/qS1Wzl+DYWjNJhcRN4R926tbcu2z3bUwdYwfDzEnGTHqTJmReOFohM7evSIeo8AUMoqMC0Oo1g1rOUsd3wFTlSu9BcJQFy2NlLikdiKdlMRLFu9GsESGQMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(261026121527099003)(10067099003)(11063799006)(261026140227099003)(56012099006)(261021123027099003)(261022115727099003)(261022105027099003)(261009221727099003)(261022075727099003)(261102123227099003)(261009223327099003)(261009221227099003)(261009223027099003)(261021121427099003)(261028144727099003)(261009220027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzFqcE1JblB2VlZsZ2t1c3pwNVhpcEpCYkNveVlZbXlxMUVid3A0NXFKMzV5?=
 =?utf-8?B?ZjNlSnNJaUEyNFVtbDNtSHVZd2wrZ3pFNGZiNmlKUW9YTjdlSjRYcGc1Ulk0?=
 =?utf-8?B?Z3dHdi9IVm1GQTVWbEdXRi9lTWtETDM5MWprOW9odEp6R3hJdVNQWG81V1RK?=
 =?utf-8?B?LzFHK3JrT1QyOWxybDZZS3c4d3dIUDNGanQrSFFPUkVxWmF4SkdoZys4Nmx2?=
 =?utf-8?B?TDVxbFRxUElUQXIwT1Jka2orcWFBZllRbUhZbmRBZVN6ckNoVU1iVTNrUmNI?=
 =?utf-8?B?SzE3UVpjVnZLcXZFRlBGRkg1QmZYb1JZSmJrYVQ1ZTRoaDR3RThMNmdVV3dP?=
 =?utf-8?B?VWlCQkkzZ2h1NGVGVVJnM2hoUVRrbTNXMDFrbFdSLytoUVVRVEFVckpMVmV5?=
 =?utf-8?B?Mm5wc291WWRnaFRSRmVaektQOG9oaDUwRC94Q1Z6STJoTzlaWmZkcGNESzZO?=
 =?utf-8?B?WVQyREZlb2xQcGlYL0ZzMVZiNFJjQjMwTmU0RmN2T2R4anNZNUhZemJUQzZO?=
 =?utf-8?B?WFlHQjdOcDU4Mis2aUVyUWFRSVFiTHQ4MlcyM29wZXZjUmlBeTIvN2J6aHlw?=
 =?utf-8?B?V21tWFJiR2g2OGg3blFJR0NDVlBGNDh1M29IRnVsVytsWXduZ3Nmb3VpNm9m?=
 =?utf-8?B?V1FNTlRNUTFyNGtFUC9Ga0UxOEpheU5pOXpRQk9YcWZEUk1uWjlOd3BROTBH?=
 =?utf-8?B?WFJ3R2trVmhYTUp6U2RYT1QvdUVZRTVMUVduS1ArbVNHVk1MQjNtaUwxQWpa?=
 =?utf-8?B?MVpzbWRWdmthNHJTSHdjU1VVUGNRYVpDQ1RtcmV3QVQ4S1ZoNEM3UXpMRlFz?=
 =?utf-8?B?R2YzNnk2djdGaHQ3Z2RleHMwNThsdmw1c1diVjlxclhzbDFybjBPa0dpbGZC?=
 =?utf-8?B?clF2SlFVekZ5bk9GQ3JXcGxMbVgzdll6UERhUzlEZzVCRmVibStvY2lpRFBl?=
 =?utf-8?B?RTZ6a2ovT2U1Mll3elc2d25rcXB0ajNyUVhhbk1KOXRNZHR2MmhFZFdleUQ0?=
 =?utf-8?B?NlZoOC9GWGJJTjE2bGVQdjA3TmpwVHF2ZmFyNDhVWlU5bUxvNThjTkRDQVBl?=
 =?utf-8?B?dEMraFdwenNyL0RsVFAzbGxQbnJCdDN4cHF3ZExldzI1K1lsenRtbjZjVzdC?=
 =?utf-8?B?ZTY3cnR1WnVpOTFwbmpBdm56RzhIOGVsYldnRzFEQ1pscHdlTEJBTUdlS0tw?=
 =?utf-8?B?Yzc5V3ZhaHpQd2svVHZyM3pyNHJoTjEzMVNJRGRXMTJPZUpxUGM5Nm1qYVlP?=
 =?utf-8?B?a3R2SEhSeU13eU45TlpmTVgxb0doeEluQWpxYnc0ZHBvbm8yR1Q5OGk1bkpH?=
 =?utf-8?B?T2luaEd6TlhOcGhDdnNVV2c2UjhiNFlKbzVXVUl2S01SVkVCd21DcXQyZUtS?=
 =?utf-8?B?aDEwS3JBeCtlbHVZMUl4dS9MdnZNQmo4VWhGWHFjdFM0QVRMczR5dUw0dU52?=
 =?utf-8?B?dGhhaThqM2hnT1VVcEh6K0srOVJXRnN3Wm1vWkFwcmg3YVlXeVZaRjJjd2hP?=
 =?utf-8?B?ZlY1WTJpQlV1WWFldGFtdVJRMC82NU9UenB2TUhkcUdmQjJ1WFY2SmQwNERp?=
 =?utf-8?B?ejNQR3NrcFN1VnEwbC9KcU1PRHNUR0NaL243NUE2Z2NiNEdIc2UxQmF6OSt4?=
 =?utf-8?B?UmwrUSs0TmZKRzZqT04wcDJNblNnY1NQbTZKendkK2xnUzdtWmJHUmp1ZEt0?=
 =?utf-8?B?TGhzWlBkZTFCME4xYWQ3YnNoMWxyajZrOEttUTdpcVVKek5VZ040T3FwNHRI?=
 =?utf-8?B?ZEdtTEMvMHlxNG04eXdHVkdwMlpUd05mQUJzOXhPYkdrdXI1QlVRTmZYQ29k?=
 =?utf-8?B?eEJzdTJwNzMrSktKdlZyeGdZcVc1QjdxOWt2UkJ3VndkblI2RUNuczU4MUxV?=
 =?utf-8?B?M01JYVNpLzZ6L0RFRUl5QWVGdVZYc0cwSVNNWlhrK3hDNk9XbDQ4d3FtVWJw?=
 =?utf-8?B?QnZyTDNrYTNVYUxKR3ZleGgrcHZGUjY4bFNPNlQxL0ZUSEg2cjN5L0dGalEw?=
 =?utf-8?B?Vyt4NStZaXUrUWt1VjExWnlpUVppRE5tM0pGWnE2bzhpdHBCZzFYdm5YWG9H?=
 =?utf-8?B?OS9MUmhxYW01REZtd1c4WklUZk1Vd1RIVzI0c0phZTdTOWkwZnkwUnpxSHcx?=
 =?utf-8?B?MVduMHRpdlhSQTBrTDFGdkFhV2RGRmVaZnVrekhRK3dyRzVBWHV2RUFEQWlh?=
 =?utf-8?B?c0JYY0YvL0I5ZHQ5YUFUeUNETm5Eeml3TGtmak1OVnFpeGVCK3J2NjhVMUha?=
 =?utf-8?B?bzJIaXVoWXVHWlVLa3A4Qkdjb2ljQmlISStBSTlraTN0bG1NNDVtN3NQVm1x?=
 =?utf-8?B?MVJoUHA0TkFKcUNkWE5zbHpQNkR0Qm83U2d1N0pPcm5zK2dFVExPQ05UNVJ2?=
 =?utf-8?Q?oKF4/6cMWnRESIfN37TH2bJ3mCGobevg2EP9fP/0GrIcb?=
X-MS-Exchange-AntiSpam-MessageData-1: B8px3Iyw0jX4IQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3356397-0d7a-41ad-7d74-08df4c8f506a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:04:12.5125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +F251SLHl6SEw2xuPJgid1zNa9/qNGuhS7SSrm3lbrm3oxNzVvhwtenSoE654VPLShe2XGJhLBDIGlK7Pjd6vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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

From: John Hubbard <jhubbard@nvidia.com>

The upcoming r000 firmware uses a new queue element header that includes
MCTP and NVDM headers describing the type of message (RPC or GMC) that
follows.

Add that header as the `QueueElementHeader` type, along with the two
NVDM types that the GSP queues use and the MCTP version and NVDM vendor
checks that validating it requires.

The type is written out field by field rather than wrapped around the
generated binding, as `GSP_MSG_QUEUE_ELEMENT` keeps a 16-byte encryption
tag, only used with confidential computing, in a union with its last two
fields, making the binding 16 bytes larger than what the GSP expects on
the queues. Static assertions check every field offset and the size of
the type against the binding.

The header has no user yet: it replaces `GspMsgElement` at the transport
level in a later patch that switches to the r000 firmware, and is built
as dead code until then.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Co-developed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw.rs                  | 186 ++++++++++++++++++++++-
 drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs |  97 ++++++++++++
 drivers/gpu/nova-core/mctp.rs                    |  20 ++-
 3 files changed, 300 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 5c216d777dff..2e499a74fa46 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -48,6 +48,11 @@
         cmdq::Cmdq, //
         GSP_PAGE_SIZE,
     },
+    mctp::{
+        MctpHeader,
+        NvdmHeader,
+        NvdmType, //
+    },
     num::{
         self,
         FromSafeCast, //
@@ -835,7 +840,7 @@ pub(crate) fn msg_length(&self) -> usize {
         size_of::<Self>() + self.rpc_header().rpc_length()
     }
 
-    /// Returns the number of elements (i.e. memory pages) used by this message.
+    /// Returns the number of slots (i.e. memory pages) used by this message.
     pub(crate) fn element_count(&self) -> u32 {
         self.inner.elemCount
     }
@@ -901,6 +906,185 @@ pub(crate) fn function(&self) -> Result<MsgFunction, u32> {
     }
 }
 
+/// First word of every r000 queue element: `"MCTP"` in ASCII.
+const MCTP_MAGIC: u32 = 0x4D43_5450;
+
+/// Header opening every element of the r000 GSP queues.
+///
+/// A queue element is laid out as follows:
+///
+/// ```text
+///     +------------------------------------+
+///     | Queue element header               |  QueueElementHeader: MCTP magic, element length,
+///     |                                    |  MCTP header, NVDM header, message length.
+///     +------------------------------------+
+///     | Message header                     |  RPC header or GMC API header. The NVDM type
+///     |                                    |  selects between the two.
+///     +------------------------------------+
+///     | Payload                            |  Message-specific data.
+///     +------------------------------------+
+/// ```
+///
+/// This is the `noEncryption` layout of the `GSP_MSG_QUEUE_ELEMENT` binding. That binding keeps
+/// a 16-byte encryption tag, used only with confidential computing, in a union with the two
+/// trailing fields of the queue element header, so wrapping the binding would make every element
+/// 16 bytes larger than what the GSP expects. The fields are therefore declared again here, with
+/// their offsets checked against the binding.
+#[repr(C)]
+pub(crate) struct QueueElementHeader {
+    /// Always [`MCTP_MAGIC`].
+    mctp_magic: u32,
+    /// Length in bytes of the whole element, this header included.
+    ///
+    /// Under confidential computing the GSP pads elements out to whole queue slots, so this can
+    /// be larger than `nvdm_payload_size` plus the size of this header, but never smaller.
+    mctp_payload_size: u32,
+    /// MCTP transport header of the element.
+    mctp_header: MctpHeader,
+    /// NVDM header of the message.
+    nvdm_header: NvdmHeader,
+    /// Length in bytes of the message following this header: the message header and its
+    /// payload.
+    nvdm_payload_size: u32,
+    reserved: u32,
+}
+
+/// Static validation of [`QueueElementHeader`] against its bindings type. Kept in a sub-module to
+/// stay out of the way of the rest of the code.
+mod queue_element_header_validation {
+    use super::*;
+
+    // Offsets of `QueueElementHeader`'s fields
+
+    static_assert!(
+        core::mem::offset_of!(QueueElementHeader, mctp_magic)
+            == core::mem::offset_of!(r000_00::GSP_MSG_QUEUE_ELEMENT, mctpMagic)
+    );
+    static_assert!(
+        core::mem::offset_of!(QueueElementHeader, mctp_payload_size)
+            == core::mem::offset_of!(r000_00::GSP_MSG_QUEUE_ELEMENT, mctpPayloadSize)
+    );
+    static_assert!(
+        core::mem::offset_of!(QueueElementHeader, mctp_header)
+            == core::mem::offset_of!(r000_00::GSP_MSG_QUEUE_ELEMENT, mctpHeader)
+    );
+    static_assert!(
+        core::mem::offset_of!(QueueElementHeader, nvdm_header)
+            == core::mem::offset_of!(r000_00::GSP_MSG_QUEUE_ELEMENT, nvdmHeader)
+    );
+
+    /// The `noEncryption` member of the union of `GSP_MSG_QUEUE_ELEMENT`, which holds the two
+    /// trailing fields of [`QueueElementHeader`].
+    // Using `allow` instead of `expect` as rustc 1.85 ignores uses from `static_assert!` and
+    // reports this as dead code.
+    #[allow(dead_code)]
+    type QueueElementNoEncryption = r000_00::GSP_MSG_QUEUE_ELEMENT__bindgen_ty_1__bindgen_ty_2;
+
+    // Offsets of fields under [`QueueElementNoEncryption`] within `GSP_MSG_QUEUE_ELEMENT`.
+
+    // Using `allow` instead of `expect` as rustc 1.85 ignores uses from `static_assert!` and
+    // reports this as dead code.
+    #[allow(dead_code)]
+    const QUEUE_ELEMENT_NO_ENCRYPTION_OFFSET: usize =
+        core::mem::offset_of!(r000_00::GSP_MSG_QUEUE_ELEMENT, __bindgen_anon_1)
+            + core::mem::offset_of!(r000_00::GSP_MSG_QUEUE_ELEMENT__bindgen_ty_1, noEncryption);
+
+    static_assert!(
+        core::mem::offset_of!(QueueElementHeader, nvdm_payload_size)
+            == QUEUE_ELEMENT_NO_ENCRYPTION_OFFSET
+                + core::mem::offset_of!(QueueElementNoEncryption, nvdmPayloadSize)
+    );
+    static_assert!(
+        core::mem::offset_of!(QueueElementHeader, reserved)
+            == QUEUE_ELEMENT_NO_ENCRYPTION_OFFSET
+                + core::mem::offset_of!(QueueElementNoEncryption, reserved)
+    );
+
+    // Ensure the size of `QueueElementHeader` matches the `noEncryption` layout.
+
+    static_assert!(
+        size_of::<QueueElementHeader>()
+            == QUEUE_ELEMENT_NO_ENCRYPTION_OFFSET + size_of::<QueueElementNoEncryption>()
+    );
+}
+
+#[expect(dead_code)]
+impl QueueElementHeader {
+    /// Creates the queue element header of an element carrying a message of NVDM type `nvdm_type`
+    /// and `message_len` bytes, message header included.
+    ///
+    /// # Errors
+    ///
+    /// - `EOVERFLOW` if a length does not fit its 32-bit field.
+    pub(crate) fn init(nvdm_type: NvdmType, message_len: usize) -> impl Init<Self, Error> {
+        try_init!(QueueElementHeader {
+            mctp_magic: MCTP_MAGIC,
+            mctp_payload_size: size_of::<Self>()
+                .checked_add(message_len)
+                .ok_or(EOVERFLOW)?
+                .try_into()
+                .map_err(|_| EOVERFLOW)?,
+            mctp_header: MctpHeader::single_packet(),
+            nvdm_header: NvdmHeader::new(nvdm_type),
+            nvdm_payload_size: message_len.try_into().map_err(|_| EOVERFLOW)?,
+            reserved: 0,
+        })
+    }
+
+    /// Returns the length of the whole element, this header included.
+    pub(crate) fn element_len(&self) -> usize {
+        num::u32_as_usize(self.mctp_payload_size)
+    }
+
+    /// Returns the length of the message following this header, message header included.
+    pub(crate) fn message_len(&self) -> usize {
+        num::u32_as_usize(self.nvdm_payload_size)
+    }
+
+    /// Returns the number of slots (i.e. memory pages) used by this element.
+    pub(crate) fn element_count(&self) -> u32 {
+        self.mctp_payload_size.div_ceil(cv!(GSP_PAGE_SIZE))
+    }
+
+    /// Returns the NVDM type of the message following this header, or `EINVAL` if it is not a
+    /// known one.
+    pub(crate) fn nvdm_type(&self) -> Result<NvdmType> {
+        self.nvdm_header.nvdm_type()
+    }
+
+    /// Validates the framing of the element.
+    ///
+    /// # Errors
+    ///
+    /// - `EIO` if the magic, the MCTP version or the NVDM vendor is wrong, or if the element
+    ///   length is smaller than this header and the message together, or larger than the
+    ///   maximum element size.
+    pub(crate) fn validate(&self) -> Result {
+        if self.mctp_magic != MCTP_MAGIC
+            || !self.mctp_header.has_expected_version()
+            || !self.nvdm_header.has_nvidia_vendor()
+        {
+            return Err(EIO);
+        }
+
+        let element_len = self.element_len();
+        if element_len < size_of::<Self>().saturating_add(self.message_len())
+            || element_len > GSP_MSG_QUEUE_ELEMENT_SIZE_MAX
+        {
+            return Err(EIO);
+        }
+
+        Ok(())
+    }
+}
+
+// SAFETY: All fields are integer types or transparent wrappers over one, with no padding.
+unsafe impl AsBytes for QueueElementHeader {}
+
+// SAFETY: All fields are integer types or transparent wrappers over one, for which all bit
+// patterns are valid.
+unsafe impl FromBytes for QueueElementHeader {}
+
 bounded_enum! {
     /// Commands of the GMC API.
     #[derive(Debug, Clone, Copy, PartialEq, Eq)]
diff --git a/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
index 552299c98169..959e397c26aa 100644
--- a/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r000_00/bindings.rs
@@ -30,6 +30,49 @@ fn fmt(&self, fmt: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
         fmt.write_str("__IncompleteArrayField")
     }
 }
+#[repr(C)]
+pub struct __BindgenUnionField<T>(::core::marker::PhantomData<T>);
+impl<T> __BindgenUnionField<T> {
+    #[inline]
+    pub const fn new() -> Self {
+        __BindgenUnionField(::core::marker::PhantomData)
+    }
+    #[inline]
+    pub unsafe fn as_ref(&self) -> &T {
+        ::core::mem::transmute(self)
+    }
+    #[inline]
+    pub unsafe fn as_mut(&mut self) -> &mut T {
+        ::core::mem::transmute(self)
+    }
+}
+impl<T> ::core::default::Default for __BindgenUnionField<T> {
+    #[inline]
+    fn default() -> Self {
+        Self::new()
+    }
+}
+impl<T> ::core::clone::Clone for __BindgenUnionField<T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+impl<T> ::core::marker::Copy for __BindgenUnionField<T> {}
+impl<T> ::core::fmt::Debug for __BindgenUnionField<T> {
+    fn fmt(&self, fmt: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
+        fmt.write_str("__BindgenUnionField")
+    }
+}
+impl<T> ::core::hash::Hash for __BindgenUnionField<T> {
+    fn hash<H: ::core::hash::Hasher>(&self, _state: &mut H) {}
+}
+impl<T> ::core::cmp::PartialEq for __BindgenUnionField<T> {
+    fn eq(&self, _other: &__BindgenUnionField<T>) -> bool {
+        true
+    }
+}
+impl<T> ::core::cmp::Eq for __BindgenUnionField<T> {}
 pub type __u8 = ffi::c_uchar;
 pub type __u16 = ffi::c_ushort;
 pub type __u32 = ffi::c_uint;
@@ -39,6 +82,60 @@ fn fmt(&self, fmt: &mut ::core::fmt::Formatter<'_>) -> ::core::fmt::Result {
 pub type u32_ = __u32;
 pub type u64_ = __u64;
 #[repr(C)]
+#[derive(Debug, Default, Copy, Clone, MaybeZeroable)]
+pub struct GSP_MSG_QUEUE_ENCRYPTION_TAG {
+    pub authTagBuffer: [u8_; 16usize],
+}
+#[repr(C)]
+#[derive(MaybeZeroable)]
+pub struct GSP_MSG_QUEUE_ELEMENT {
+    pub mctpMagic: u32_,
+    pub mctpPayloadSize: u32_,
+    pub mctpHeader: u32_,
+    pub nvdmHeader: u32_,
+    pub __bindgen_anon_1: GSP_MSG_QUEUE_ELEMENT__bindgen_ty_1,
+}
+#[repr(C)]
+#[derive(MaybeZeroable)]
+pub struct GSP_MSG_QUEUE_ELEMENT__bindgen_ty_1 {
+    pub withEncryption: __BindgenUnionField<GSP_MSG_QUEUE_ELEMENT__bindgen_ty_1__bindgen_ty_1>,
+    pub noEncryption: __BindgenUnionField<GSP_MSG_QUEUE_ELEMENT__bindgen_ty_1__bindgen_ty_2>,
+    pub bindgen_union_field: [u32; 6usize],
+}
+#[repr(C)]
+#[derive(Debug, Default, MaybeZeroable)]
+pub struct GSP_MSG_QUEUE_ELEMENT__bindgen_ty_1__bindgen_ty_1 {
+    pub encryptionTag: GSP_MSG_QUEUE_ENCRYPTION_TAG,
+    pub nvdmPayloadSize: u32_,
+    pub reserved: u32_,
+    pub payload: __IncompleteArrayField<u8_>,
+}
+#[repr(C)]
+#[derive(Debug, Default, MaybeZeroable)]
+pub struct GSP_MSG_QUEUE_ELEMENT__bindgen_ty_1__bindgen_ty_2 {
+    pub nvdmPayloadSize: u32_,
+    pub reserved: u32_,
+    pub payload: __IncompleteArrayField<u8_>,
+}
+impl Default for GSP_MSG_QUEUE_ELEMENT__bindgen_ty_1 {
+    fn default() -> Self {
+        let mut s = ::core::mem::MaybeUninit::<Self>::uninit();
+        unsafe {
+            ::core::ptr::write_bytes(s.as_mut_ptr(), 0, 1);
+            s.assume_init()
+        }
+    }
+}
+impl Default for GSP_MSG_QUEUE_ELEMENT {
+    fn default() -> Self {
+        let mut s = ::core::mem::MaybeUninit::<Self>::uninit();
+        unsafe {
+            ::core::ptr::write_bytes(s.as_mut_ptr(), 0, 1);
+            s.assume_init()
+        }
+    }
+}
+#[repr(C)]
 #[derive(MaybeZeroable)]
 pub struct GMCAPI_HEADER {
     pub command: u32_,
diff --git a/drivers/gpu/nova-core/mctp.rs b/drivers/gpu/nova-core/mctp.rs
index f62e79f56b05..e4d0639cde0f 100644
--- a/drivers/gpu/nova-core/mctp.rs
+++ b/drivers/gpu/nova-core/mctp.rs
@@ -28,6 +28,10 @@ pub(crate) enum NvdmType with TryFrom<Bounded<u32, 8>> {
         Cot = 0x14,
         /// FSP command response.
         FspResponse = 0x15,
+        /// RPC message to or from GSP-RM.
+        RmRpc = 0x25,
+        /// GMC (GPU Management Controller) API message to or from GSP-RM.
+        GmcApi = 0x26,
     }
 }
 
@@ -67,6 +71,11 @@ pub(crate) fn single_packet() -> Self {
     pub(crate) fn is_single_packet(self) -> bool {
         self.som().into_bool() && self.eom().into_bool()
     }
+
+    /// Returns `true` if this MCTP header carries the version that this driver uses.
+    pub(crate) fn has_expected_version(self) -> bool {
+        u32::from(self.version()) == Self::VERSION
+    }
 }
 
 /// MCTP message type for PCI vendor-defined messages.
@@ -93,10 +102,17 @@ pub(crate) fn new(nvdm_type: NvdmType) -> Self {
             .with_nvdm_type(nvdm_type)
     }
 
-    /// Validates this header against the expected NVIDIA NVDM format and type.
-    pub(crate) fn validate(self, expected_type: NvdmType) -> bool {
+    /// Returns `true` if this NVDM header belongs to a PCI vendor-defined message from NVIDIA.
+    ///
+    /// The GPU firmware only ever sends such messages, so a mismatch is a sign of corruption.
+    pub(crate) fn has_nvidia_vendor(self) -> bool {
         u8::from(self.msg_type()) == MSG_TYPE_VENDOR_PCI
             && u16::from(self.vendor_id()) == Vendor::NVIDIA.as_raw()
+    }
+
+    /// Validates this header against the expected NVIDIA NVDM format and type.
+    pub(crate) fn validate(self, expected_type: NvdmType) -> bool {
+        self.has_nvidia_vendor()
             && matches!(self.nvdm_type(), Ok(nvdm_type) if nvdm_type == expected_type)
     }
 }

-- 
2.56.1

