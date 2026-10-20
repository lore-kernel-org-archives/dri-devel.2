Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD55606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hIsAiBRU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F6F210F48F;
	Tue, 20 Oct 2026 10:09:09 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C49F210F493
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 10:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pO8EAUblt+/OhaSVKfEN8b7Z8nfq/B64a9MIKehc13v7e+wTBLNW6uWGQYmIgZtjzOJoejnZhwF6VBqH5mMl379nE+/lm+6yXTzeuVLs+cvdensETl7ZTQPekihHeGyTsVGls4K+G3NQfKKJvVrY/Hu8lq+JkQS1kaA+Wbn5V5IhwgCEYzaq99gIMwAbQP/QmA5S0v1vXLJBM39y4Bisx9bKUUeCsMII+/AhILrzpOLhfzjZZgCkekLVsnDk7oYasz4A+FU5ZV5BoYYcMAboOmjQxAE6s6DqFFLaWwcWktgna7Fk120YT6q5LLslqCakgEmR9VyxpNr/gZTGFS/jcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1Eu/wme+RoAYQKijbOjp9dTQO1CcViEgfNc/ikC+tQ=;
 b=uRicnfeZZbX7OFKTLqY8jbKtLwVIVFmErS5vL60zfddY0flcUnDfhsyIRY94ERydGIrmTK8k0z9mIAq4cMhu52jlzXvBNcw5T2zRoIZPte0kUps0BAU2hn7scI6ZD6Sy48Zhcg3m1xFlsZRm5wWkOGQ+UpNmJAg3/MVflLpJKGdKo566JQrHkryOiLD50Gn7JUKVqgKPIZz4gVdHQ9aLy39+qgYsiLqoklhbIpSAmxUgTE7Sue/7ahag5Znh749v23kxLc5a1EEMdwnJgo8yN9Zf6Csaqr3QW4nPxijuX2efLHEx7GT/uoU/edemwv1GBbSehXb5D1aj2CLE4o0uNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1Eu/wme+RoAYQKijbOjp9dTQO1CcViEgfNc/ikC+tQ=;
 b=hIsAiBRUUaN/qaXT+GUT+4o7y2j/ZgIOv2dQkZH+9xDfLojgVEbRLNGvsZ4iE/fWLtCPVHO5wyan+WXEx/my775PoLSM9CL4+LZyRg8sja60/JnhwlH/dsK+gSfHwDKFL3yIBwNWbks/TuICZM9S4HARjwIqXvYbgtkRPwnzR0rBXE92AsPuxo05+Di1MHmaHWdhtf/H0+lqpYf/b7LrDcnodZOOXmm87Vb4r2UvIiDLqisiUrzNL2f6jJG11iaq6CP/eIslv/yRD46kGCQU0hqNhyiW6xAJE5jENgs0lyA7iMVzs4y1p2Sewc9vhD8S84AKT1WZYmqLySi992BDjg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS6PR12MB754991.namprd12.prod.outlook.com (2603:10b6:8:4d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Tue, 20 Oct
 2026 10:08:44 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 10:08:44 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 20 Oct 2026 19:08:26 +0900
Subject: [PATCH v5 05/14] gpu: nova-core: gsp: cmdq: group the RPC-specific
 part of send_single_command
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261020-cmdq-rpc-v5-5-dceeb8f360ec@nvidia.com>
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
X-ClientProxiedBy: OSTPR01CA0088.jpnprd01.prod.outlook.com
 (2603:1096:604:218::17) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS6PR12MB754991:EE_
X-MS-Office365-Filtering-Correlation-Id: 44214b3a-165d-4b8e-118e-08df2e921fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: k7VLyO7/xeqwLY73ksWY9C2AbMe4DEOTLJnwsYp+FbQ7jIyWegj/Brq6sBzrvQZPgKunNrQJTW2uSzkFp7HHJ8Ou/CZax1wR1Ebs5KYG4pmvvCSMX/yUrU7ntWMSJzdwrrN8hNH0pDZwjrPGkNa0GWnhl6dd6TT43lg5SLCj7NUx8nO4TfZfv4ucm9xG9/pWesPROveOqLqmf2G43379xn+/Q31MaHHsUOEDhnbSGPyFNJiYOe6iZ4RnamWQJhc9MlukA4tPVMzA4t2O9RHtAuPj5590Ldtnr0vWtTFEAjGkwF54ZACNmSUvu1SMb7CIUoA/9rWhkHH4r1BhjiWIvRq+Z4XbzyE4iSX054AVTjKYP/G+RFkaztkLsZGrksmWO61ze3PpgQF/jC8Gme8GWta2U0dEWQL338mTQpcFKobZeloj5BTXxm9XZdZbCEgrB9MAQ2KHs2cMgxEPHm1G8+OZef3sccMTemzWF1+LiCL0iw4hgYkkw/tGm8WWg58c37xkXkARnBib+BtmmYq0jc33V77Kzqbbb627W0gKEA9YIDuSt6XxvMNaK3dEHhhYGFtiVN72+EqXIG+zWQgPU5AQrWuHh6r2eNBehCs4H7vWV1kU5zg/a/f67eHKTlw4kmXNddbz//7irAI/2geYIDLOCbWlYTDs0QsczGGANmo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUw4SmZZRGh0cnVkcVdhbzJqc2tia1ZCOHJmdHc5SUNwZ1NyNkdHUEhnVVJx?=
 =?utf-8?B?NFA5UG83U3p0cDI0Q2xtNW44bGoxcktWK1QxRmpSWk5ocjBuYitCZWhBTmNM?=
 =?utf-8?B?NGd4aHAvU3B1S2J5VkdvbFhldGwxRFVMMkNRYmJzY0dINm5zU0tFWWVqSFht?=
 =?utf-8?B?WFk4ZkxTVEhTRndndWpXZm5jZHRFNzkzYS9Fbk00UVVOQWlxdVhpeXU4SEJT?=
 =?utf-8?B?MTZsRDNacDlqdGN5YnR4Q2MxUFgzcTV5SWpEbVJRTVVSTWowTWhkNG5sOHBu?=
 =?utf-8?B?eE5vRER0TGgwRGNPQmFrWjhGWldaVk5TcyswWGx6WHVVbUltV1dsdlRnNWdP?=
 =?utf-8?B?YWc2Z000MHFUVzE5YzlJOGhCRE5wTlY3TUMvQkxsMGtHWnptd0tmSWNVaGxU?=
 =?utf-8?B?WXh0YlVTZzdjVEZqN05VL0FldGFSSmErNzYweFBGdEJNdlp2QnM5KzY3Q2NB?=
 =?utf-8?B?MUxRVGNZMEhzQnNWcmlvTDVDTm5uL0had0NNMUd3YmRlMWh0ZDlZK3RqKy9k?=
 =?utf-8?B?a3FIQm94UG9HdEFQOXdIaDU4NzZ3NlZDVDNINTdZa3BzME5teDE1R2JnU053?=
 =?utf-8?B?amZwUmJuKzZjazlTVGhtVDl4ZW5pR1Brc3pzYzJ5RlZsZDk3QXJ2RzNmQnU2?=
 =?utf-8?B?ZzI4Ymd5bWdlSThQU0Yrb1poUkhMMXUvaVFFdVgzL1J3RVV1VmNmaEZjeHBo?=
 =?utf-8?B?MXFuOFlxcTN2dlRHT040VHh2dVUvcUdScE44RXhMTk5HOGd6b1c2WEc1YUlt?=
 =?utf-8?B?WTZiSDM3cDZJWVdoTUZmRnREaUFvbkJYeW9kYThlZWh5MmhJb3hJTlJYdnFY?=
 =?utf-8?B?MWN3dk90WXJUOENCUnNJUVpOZ1F0dE5Oc0djZ3R0VDhxb1VkOWdpbmpDVGYw?=
 =?utf-8?B?MnJ0Zm00dTJhT1JGeElaQitFd1o5YkhYQUxxR0ZtV1UvTXBZY1ZTdStlYzVp?=
 =?utf-8?B?akpaay8zZE5jS1E0NU9hL1VRRnowN2h4TSs5S1lHaDZ2N09nNU9KMGRYUmpV?=
 =?utf-8?B?bkE0YTE2b2Q0WmNXdGlOKytFdXI2RTBibEtuMFRSY0hFcTlvbXl6SW56QXdv?=
 =?utf-8?B?b29aK3l2TkZ4ZFJVTnRwOVpFVGpXYnJZRTBpTW5LK2NvTFRCcEZ3b3VpM3l4?=
 =?utf-8?B?N3hzYXFsRFU0MG5jVkdLZGU2Q2IxazczODgrbTJtYXVNN2JGWHBQdlVOSThB?=
 =?utf-8?B?Y1plVmpFbitLUUpETTVreUUrOFRUejlOdXJCNVhyTFhPemZ4K2xVQTZLbFZD?=
 =?utf-8?B?a01jVTMxdzJadVdYQnB0dmJhcURReTRxbTBibzQzcXl0Ry9NQnJKeGptOThx?=
 =?utf-8?B?UXNESGIyWFdhb2pIM0tIMzc1QnNETXpwNFB4V05TZSttanY4OWRsOU1KeWtC?=
 =?utf-8?B?QzBFTno2VHBSUGJGTGZsaVNHWEpkNEs3b0RBbUZITkNnMkxQd1pkTkowM1d6?=
 =?utf-8?B?RDMxYzh4bElSRDlCMXZaQkUya3FlaHhtWHU3SjhRZEt6ZHU0WkkwZmNYUk9R?=
 =?utf-8?B?by8vT25hdjhTamt2QWRLdm5HMXFsZnF0SkIxa29Sc2Y1N3RZa3Jhd0xCYWt4?=
 =?utf-8?B?MFNjWjQ4WWtjMVh4c0VaYUYwTjNhZlNYVktXaG9hTmwvR2N4d2JHbkhlNG5X?=
 =?utf-8?B?eDIwdTJtRk1FRGNlSFV0MndLVVdDd2lMRHFPcStpM3QxaThiWlFYS0ZEbGZV?=
 =?utf-8?B?ZjhXTU15bHp3Z2JTNW1UdlR2bk4zakVBNjFCSnF3OEE5TVVUZjRaSlFZS2R2?=
 =?utf-8?B?alVQRWFxK3FraEYwbTY2TkZZUnlOS1g0MUdPWWJtRlVId1RJNEQzNWN4S1lu?=
 =?utf-8?B?cWdXWmpSVFkzbHJ3SXdtRVJsSzV2cGJWNGcvallpMmM1NktGRFVUZXcyc3Ez?=
 =?utf-8?B?MVF1NXB1b0RsWFhXUXNJcXd3dXNIMWQvazRpVnhyMUU5VnJHTDA5MFJpeGlF?=
 =?utf-8?B?cEIxOWd5d2VyNVlZbVY2UnJ6NFRyQzg5MWp2YlRyckxZdmdkWFUxLzBLWkE5?=
 =?utf-8?B?TkVMNFRhVTh4aWEyTHJRd3FRR0Q3SFhpYldia1NUcUJRRU1mbW1KeUtjOThp?=
 =?utf-8?B?ZDg2ZHBLcVFaQW0wUXZOUEMyelZyR3JmNHJQZmdMUDVqdXZhMU1xcE1pRjNi?=
 =?utf-8?B?elprc1hsMzhYRHNIdFVyVjd2YmFZZVdDRXd5Ui85SENTclg1MmNHZ2VZcWlq?=
 =?utf-8?B?ZTNGM21mang3elcvYTl2Tm5yTS9vYmRqUW9YUG02V0pIcm1CWGUwOERCOWVk?=
 =?utf-8?B?dXRmNDF3d1pBZHNoUStPd2FBMWU0TmsvOEtaNVd2aHphLzhtY1NXSithT05l?=
 =?utf-8?B?RFhGTzNFUUNERUZPSG1yYVVCQ2pzT2tnL2h5RmM3bjQ1Q1JZSS84TjZyRFBZ?=
 =?utf-8?Q?z6tDuu99Y9yPdBDWCCBQ0ZX7QQh+vRbppnD0Wgnr8/OId?=
X-MS-Exchange-AntiSpam-MessageData-1: PdWJsMQL84rmbA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44214b3a-165d-4b8e-118e-08df2e921fc0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:08:44.4704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8i6Z6TUwq9qXZ/e1NSxduiXBe1oie5KmCUV+o2Krfw2+B6obQ02gD4BvAqtNDqfRETZM+aHtoVAQeR8Cb4U9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB754991
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

