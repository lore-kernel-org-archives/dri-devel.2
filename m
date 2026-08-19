Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC33C5DF89
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 143B810ED0B;
	Wed, 19 Aug 2026 17:28:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="ef7d5Z9M";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021139.outbound.protection.outlook.com [52.101.95.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FAC410E81B
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 17:28:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujEK0CxV5729hfSbyb/eW1RLQ9S7lcVwJH0qpG5/1FAbLQhGON4yLDMBRRNy8baFJ6r7dFWLDIWxNPmove50p6k5MMg8n6QOwwMYZ7nsE6hWcj6gLVG/zqMhKc2IllLLmNafiRvvikUSpLJbTmng35ZdVoBpp8XjPpBt4YgnQOYnkj0JDxT1YroxVHyLAOuxLyS0DX8haPW/nwzzefn3oBAQNDLStka3/Vk+MOXdksOb8aRbk1SiT57eqmB5ETyPJQV2ULwVFWz3KLiRDJEONDLEIb4QQ+QVTfL1Qjk2ktTCCBTQ+eJZbUiiztWvb9Ac/XE9Cx75NrqTFlneS0/cAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku8GHTY0fZIvbbwAVRAotIs4LrTzK6QLMiLAc+B5Vlo=;
 b=Gxt1at6T8dV+wCjSByZwkcBX+FbovviY75jGIMxIInlvn+8vo0mkXOiNWD0A62DDoRvNPhXBXjzjN1hKRoOObElg93K5gfx76qgnfPzuuwSdHzGZA2vj3gFQz64ovpl9Ku244bytola9+CMZBxSCpk++H30P6n2SuJSYnaAe3+vSLQeoYAkqz4lCNtwIxQsbstitPCKssaCz/wEio9CPScsRv6V1D5kGOJ7tQks6YX1Rskql3HEQEqFQoCK0c0M1gcyGPtwyvHbuZLiH4UrgyK9I4eXDOhzoaNv0u54ByElYmJFh6VH4zC9FrYiafO+wm/j6Xl8WRgQCCDBLiSFvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku8GHTY0fZIvbbwAVRAotIs4LrTzK6QLMiLAc+B5Vlo=;
 b=ef7d5Z9MU6NKL7xtl907xAXk1NXzFSYk2itRCESeWirb+0R5muw6B7qOnuML5BZow0dM2uEgUwTuJS1z4KDp9wY0ZRHgpP8Nfsm6hTfT6HcS35lGKPzzilkzGjY1b4Kz3cXi3fD0jXraxj+m4m7qox5Icr0D4TZ6uGNlJMr3eKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB6700.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 17:28:53 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 17:28:53 +0000
From: Gary Guo <gary@garyguo.net>
Date: Wed, 19 Aug 2026 18:28:43 +0100
Subject: [PATCH v3 1/2] gpu: nova-core: fix barrier usage in CPU->GSP
 messaging path
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-rust-barrier-v3-1-d5b7bd7e6624@garyguo.net>
References: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
In-Reply-To: <20260819-rust-barrier-v3-0-d5b7bd7e6624@garyguo.net>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Gary Guo <gary@garyguo.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787160532; l=2895;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=jLG2mFREUnhKOYHj8APgqiVRzRsSpld7o+bTpLwn89A=;
 b=MzeZtFWWbkz57iRRNV7qZQSF4/Jo1dXhGJ4+myWyeU//YXBYBPmaA2X1TU9i85zVa0msMzRuN
 RGuwAqQcG4BBFacvAwlX/NZFQ2D8hN47khzYyrjViKSgrKwmdlzSjFX
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P123CA0414.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::23) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 660c930e-2735-4e3d-0dd3-08defe17572f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|23010399003|376014|366016|22082099003|18002099003|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 5vc9tpSZc93YG4FecG6/WelZ5ixNr5oZUOo6D21VifBL4Pvc2KplyT1B2Kqu2u55qLeEZ29NAcfF37rCzcm4kojuhTKXSd/6pvEDV7mw4H3Lv0d0oUmabcyvugPHhB1R+xF691B+sDiZJi/AawZznj9bMH9XyOipI+w2Jn2sBmgXeEdeCrBE1A+2GokWrAmqwLxX7rjwCbSC+WWjsHRI0B+loYFxoO79cX8odR50+HF3IYH/3RxPcsJFTQqBoAaznEDUCW+kSZtV81AKfQV7HcoM6hMDnxBnZgTGCoHkoqJgNyZUg5gV7rRvS7jfciM0i3iwAn6d6f7oZSQUVIRxSoBWSfPqYkhmh6yuuPlCbVV54NTY6vvQs+KDJY3EXzELphoyqxWXtpKBUe9OJmmZWFZTWw4dB9cSy4u75xionSwDdko6a5V3yrJVWPP+xqVR3a7JXrbNk50Odga66rPZ+FA/h0dBtqmQNtxGKq+1VUMHF4EjJpDYnw8UludpukDKNPA8TO7LrcCnN+QuDJLpBxuScrbr6Nc/GZPT7PSR3C5q6Z3y9sxBqV1hCg2EcYPeb2rCvrQ+Z2vPa62Nrx9BccBKL6Q8b/S3b21P5En1NyCzU7jRTRrK9s1DUPGjOyX9sSQwyqmwuc2u8xzfbudm8THGusnsAn75FFk91rCQM7c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTJWSWxtUmJhT3pLcEZwUjNqNDJhSlN0WFI2SVI5cC9COXVWUkhGVnJKUkdI?=
 =?utf-8?B?SHdlOWh0L0hyTHBkM1EySGZsblRUT3gzL01icGRaNm9OQzA1Zmdib1lGM2p4?=
 =?utf-8?B?bDVSOWpTYzB6RHZHOGcwQ3FYekJtMkFnSnJLcmVqU2l4cTZRYmdTY3JzZUZr?=
 =?utf-8?B?bGFQQUNnWFo1dXlLM21SVlFLQkV0azBvSFU1YWRjcHRBcFBTOVovbTVtcGpT?=
 =?utf-8?B?RHcyb3l4bnRIMHhxSm9FNFRLN0FCU3ZJOUZ5enNQZ0tVWXM5V1YxV3EzKzBM?=
 =?utf-8?B?SnA3TGNLRHl4MjhwRkJvT1pybUxrOEFvT3VzN1UrNzJJc29kelZLT2lsS1J4?=
 =?utf-8?B?RVhXTDM0cGx0NlhFSlBKYy9QWGdTajBiNmt6NEJoaXVJdnYwZWxhaTZLVzRl?=
 =?utf-8?B?NnpUTkZZeThFL1JnanFyYW9LRENmNU9XeHhldkdyQVNpUUtTQURXckkyRWlT?=
 =?utf-8?B?SDFTSkVjWk9BMm84MXN1eDhTTUJaUUlFTmFzalVnY3NZT2RPMXhWMW84K2s4?=
 =?utf-8?B?OWJNWDQwOXNWOHBOTDM1TDhjSzZsNWZSbWRGNWMyYklNV0ViTUNiUTZ6WkFC?=
 =?utf-8?B?N01tREZEb3FieU5NVGNFN296ZkV3MzZEdGhLdlE2QkQ0c2lFZk9vTEZua0dy?=
 =?utf-8?B?dmRENEM3U1ZyZ0RCSGJ5QjV6eThjeVJJSXVQRmZzZGhkKy8weTdhdzlJZm9q?=
 =?utf-8?B?V2NJU2M1b1dRY0RWT25RUGVPNlIrY1pxNnRzdTk4NmJMRFQ2NlhZcWxzUytV?=
 =?utf-8?B?SzdSd3d4dWRYc3JndWt6bGVhWW02OGNzbFlNYUIyem1TSStpcUhIekRzcGRp?=
 =?utf-8?B?TWgvU2ZYZ0dmeGpJMTlmYzNMWFlnOEhrZlphRmVlZjVCNFV3RDQxTG14WHEv?=
 =?utf-8?B?bmxsdFZWbGI3Rncva25kazdoNEN2MzdWL25xTXVUczVnVmllWHdybDA2NXIy?=
 =?utf-8?B?VnlmSFRDcElTYVBXK0JwNXV0UkxsbXVWcmZrNVdQTjVYUzZZTXVvR2duNEo3?=
 =?utf-8?B?QmRaUWsza1JxcFBCWi9HUWEzUFlSVnREWjJwLzZTU3BYZldzK0RGSTJpV1Zs?=
 =?utf-8?B?TFR4STZHdzQwWVpLWk5HdWNBc2E5ZFppVjRQZWVJZjg0NkNKY1F0S0dlUm0w?=
 =?utf-8?B?bnN0Q2xGdE1PY2xpQ2laMzhpalRYcWg4Wkt1c2IvOEE5SDJMZTZOSGNEYkFW?=
 =?utf-8?B?L25tc0NwSGNqYzJpRW9VaDEvOWhxM2g3ME8xQVhMUm9ia2JET1JuTGdTQ0I3?=
 =?utf-8?B?dzg2TGd1OTg4SjIrd0NRS2dzU29KRTBiWUU3ZHVzVExlZG1nU3NYcnlmSllH?=
 =?utf-8?B?dGE3YkdoZ3ZtN0dhTVllYXZENnNXM1RGNktGVTRWU0FhNmhyTVA3TElrb2tu?=
 =?utf-8?B?QnpWRDhnYis4c2JLM3JiMGZnR2pUb2RkRlNSanl2QTdiUFRIcGgrYTI4OGk3?=
 =?utf-8?B?V2dGNkZsYkIyUFhSbStPclZzaEhWNmxRRHhTV1JWV21EN01hVmkzNm5mN3Zu?=
 =?utf-8?B?Y1ZyeEp4VHptVUJ1cFBRNzRDVStMWndUSGZZZjI0RjBNMGhvNzhSK1gzMHJP?=
 =?utf-8?B?N1plNDcyRkdUU2pGYWFDdWo4czl3UUF1YjY2ZUxxd2x0SmQzYWJGWTlHamRB?=
 =?utf-8?B?VmFVRkVXUUdCcHN5bmNFVzE0YkNBaVIxSXJMSUZSMUdRenhraGh3cStheTNp?=
 =?utf-8?B?a2piQVR3L0YwMmNCY3BoM3dxbmlrVytteXY1ek9KazM4NnFjYTBHbGN1S3hu?=
 =?utf-8?B?VDkyS0lUekhUTGhNT25oMU80TVBjdEFhVjZ4N2M4cVRqdHpHanZNc2Rrc1hK?=
 =?utf-8?B?U0pzVy9Cc1FyQ0VsODB2OC9rNFlDS1ZkU2NvMXJHdnQ0cU1rbnlGK3dGOWo0?=
 =?utf-8?B?Um1PNUxFWCtIWWp5K0xtUzVhMnE3ZkpxMGliVmwrZTV1cWhhTjIwSXFEeGVU?=
 =?utf-8?B?MHZaamhSNkVkQlVzVTFBSXpYUVl1eXMxK2FNOU0rbHQ2aEc5NERIMUl1RWVi?=
 =?utf-8?B?N3VpekIxckNFMEZUOVI4MlM5clhpWUZuNW5iZHE0Y1R5MTFEelpDaDJxeHpE?=
 =?utf-8?B?azU0Y1JOQTdUdEZBNnBZczBXKzJ2elU1bU85STRxV1BEMmJlUGwwS1JGSnpM?=
 =?utf-8?B?SUl3REE0eWpSOGRhbG4yRjVId3JFQTdyMmFvTHkxdG5FejM4K0hHdHp1OHBK?=
 =?utf-8?B?dVlGWSswTWEyVnB4Uml0dEJGNWxQYTlXWHNLYkp5b2syaHhrNEF1T2E3azBG?=
 =?utf-8?B?ZkNhK0FpYmdHOUtLVG5SaUdWWW14MUNPcEUyYnNWWExSUEtqclpZMGFZUFpx?=
 =?utf-8?B?MjhtSUl4dkRUZHNCeExlNDFIVDF3cTZkSUxVSUhOTnQzc0pXRDVxdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 660c930e-2735-4e3d-0dd3-08defe17572f
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 17:28:53.4353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnKENIuYiCJccsgDlDAo6ygL5tAccy7S7DjSLcq2WmO3apwjIgHblwaRFXVCPjJ6PhwV9X2JqFHEQwGsfQAPYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6700
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

In the CPU->GSP messaging path, the code reads the read pointer from GSP,
writes the command, advances the write pointer, and then notifies the GSP.

A LOAD->STORE ordering is needed after reading the read pointer from GSP
and writing the command. Control dependency exists here which provide the
needed ordering, but it's best to avoid depending on it.

A STORE->STORE ordering is needed after the command write and before the
write pointer advance. This is currently incorrectly done after the write
pointer advance (and before GSP notification), but this can cause issue if
GSP is still processing ring buffer, as it may observe the write pointer
advance before command write. Thus move this barrier to be before the write
pointer advance. Note that barriers are not needed between write pointer
advance and GSP notification, as MMIO accessors already carries the
required barrier.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 6da728201281..70674d2d0f77 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -27,6 +27,11 @@
     ptr,
     sync::{
         aref::ARef,
+        barrier::{
+            dma_mb,
+            Full,
+            Write, //
+        },
         Mutex, //
     },
     time::Delta,
@@ -272,6 +277,10 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
             (rx - 1, 0)
         };
 
+        // ORDERING: LOAD->STORE ordering needed to order `gsp_read_ptr` read before data write.
+        // Control dependency can serve the same purpose here, but we don't want to rely on it.
+        dma_mb(Full);
+
         // SAFETY:
         // - `data` was created from a valid pointer, and `rx` and `tx` are in the
         //   `0..MSGQ_NUM_PAGES` range per the invariants of `cpu_write_ptr` and `gsp_read_ptr`,
@@ -450,9 +459,6 @@ fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
         let tx = io_project!(self.0, .cpuq.tx);
         let wptr = MsgqTxHeader::write_ptr(tx).wrapping_add(elem_count) % MSGQ_NUM_PAGES;
         MsgqTxHeader::set_write_ptr(tx, wptr);
-
-        // Ensure all command data is visible before triggering the GSP read.
-        fence(Ordering::SeqCst);
     }
 }
 
@@ -683,6 +689,9 @@ fn send_single_command<M>(&mut self, bar: Bar0<'_>, command: M) -> Result
             dst.header.length(),
         );
 
+        // ORDERING: STORE->STORE ordering needed to order `cpu_write_ptr` write after data write.
+        dma_mb(Write);
+
         // All set - update the write pointer and inform the GSP of the new command.
         let elem_count = dst.header.element_count();
         self.seq += 1;

-- 
2.54.0

