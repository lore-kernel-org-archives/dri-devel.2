Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552F60A2631
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LOnHlac8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E271510F2A3;
	Tue, 27 Oct 2026 07:36:23 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010041.outbound.protection.outlook.com [52.101.85.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D6E10F2B8
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgQGTYMMkZrPggMvc+ARARw7ExKm6Mx8d1XXrV/enMsiY2OuHWGzZHsw/SbBsrc9JmNZ+45EATyJgFZlVSWvYJNSj0BM5WeOBJcZRXyipimUyxMlZVJHOBvJpc1wG8yTJ3kETWsgHK4PeOT/35bVglrJ1B9CERbQf71/4XEM4NDhcnWh5VQ9ZhSatPifRqB6i34Pdz2B6+mmicG3QHCSgC7mv1cSuq06dIExn/52H55mTymLZKsZnKBNg0IWIAfKIXyyO9csqTkFxGNca7mljas+/Fll0sLE2zHkB5N1NaxBs/ezQxSUznUqSVIYM9nnK0Izzfze/wwp19dcSARi3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZajFw8j/U4KO+eSfOw+D3rk9xMfsVG1lsWEOXSfNAUs=;
 b=WXRum8+piQn9fFwfex4Wdo973xEivKt+kLYIj6vNTowsWnFRbVZlcecwrPNquRBnaE+Pj8Lc25U//k28MrDHp/zfiM6I22LDD91OFaLVWWgfzj39/j/cF59lPJVt4MwEDRbxo1zQKziSvdOuoa712KisxvNQ7a5LKnLJmGm5cFlbakv0cK2nnVvw+2BloUx+J9YAZssXLNwgXXOPNhuHQY5DkNWvFffz3KGpNYsZuQ/t73o3F0idPJQQaRJ2PdEewTIFE6jEHVrvWR0fRO4SNt5JoATaGPk48eYm5lzlenZccTDsNZE3zG3mT5f3rDofBDJFTQnHXaLlaARwTJ6lQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZajFw8j/U4KO+eSfOw+D3rk9xMfsVG1lsWEOXSfNAUs=;
 b=LOnHlac8ZGIov+zeKjtJn0IIV7spWZQLfqhLVjurB0mqFzL/iskTC58ow3OyuvGS8MFJzXC1wz+yD6VdM4nyh2VXj8mEStwDOoOmLW5L/WKu6Xm6SRGPM94Lxb4uI72z2S/8vxiSryJunsdi8bpKQghMD6RALqJn2D9Voyc0ht50UHCVHFJSeRZ2oLk5i4bDl4N3isj3Dsc3uoZNutbvxHpxmxvwkj7eGHOR8cVpUigWb4HwM+kqmFHsUHrqtMoHTLIj/NzJLshsU3QXbcr7N/NjgcM4n/TkXcR+TDPIeFBVUvcJZ9wyzIEyBYtss4yBn0I2b/otHrsOVWBIrw6Zrg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:36:01 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:36:01 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 27 Oct 2026 16:35:47 +0900
Subject: [PATCH v6 04/15] gpu: nova-core: gsp: introduce and use proper
 RpcMessageHeader type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-cmdq-rpc-v6-4-bed9669724ba@nvidia.com>
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
X-ClientProxiedBy: TY4P301CA0109.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::16) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 483216c5-d365-472a-94ec-08df33fcf342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|261021123027099003|56012099006|11063799006|261021135927099003|261022105027099003|261009223027099003|261022075727099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: imOTVQ9woWnXkKN/4DYItwhIo30uSOKVJsQR9rSMjc+POfMX7wWkKx6Tc9xuVOODgAHNMBq32P+8LbPHwbe9uaXfjAjH4LJ26eLDGTNh7O4/MzZ5wRIpZZPtPDc2Z7ikItrNbRU8N9KdfeprSYn6TgdSThB5AMNVJ+dBG5A1GVApvyiG3iZL3RoG3N+RsYbNrilfBf/8OJDxMbgVRnYJRcK1C49M1n7u+DaEO1Fpq04a+0wGLMQi91SxO2p3TUonYeTViwJvFMh6pb/LsguR5annChFchVUlyofFGCIwNY2fPAmwstAORhPtsVn34XmvA8QYphfKGZ32kdN0drWHCB9+KSnR3ZPUkuTfvSCUU6mcQZAbQ8km0BGBxYrpX8dUhjr9cOaHQMcEQpZq2ZHR7Aa4HuPkGeT3mCfJsEGBUKdBMb7lQlb8OLFvbzUp7r4jg78RzHAIyxADkD6vLOe7lNWdzRAPHEu0ioCJI/YT8gbnZaIrFVxVGiXv8o0nGdCr4wTIswSdsJ/Xj+jcueY4jo+Yx8WmW9zCf3bPb/XxXQ66YLjE7X56b+XkwudpJzglvydIf6GUja860JFJPmKmVjPOEOU0BODYPlxZ5zjO1I46NygUCTWFgB4YcsAY4zdCX5F/sK/wfIlkyxHG5OmJTAybslle+i857jJf25WT0c4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(261021123027099003)(56012099006)(11063799006)(261021135927099003)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUNUK0dJV1JnVGFwL1N2RnlZVGs1UXQyVWs1MTF6em9xMVFWRnFFL2c4SlJL?=
 =?utf-8?B?YkwxY3I3bUxIVmF3RjNGZWtkdWFKV0I3UGxnSm5STXZKNjBpM2hvT3B1TE5a?=
 =?utf-8?B?M2tCTlFiakJPQzdtZ1RRbGVLaDNyTVBWaFdHdVJLeFh2aFo3QmZnQy9KWThY?=
 =?utf-8?B?RytBWE10Uk8xeWJtS1Njc1VDcmxPeGY1R2hmNENjYjBwUnBiTStGNjVCL245?=
 =?utf-8?B?RHhkQmowaHdDY0NTbzdVdEJJRW1McE52eDN6d0hQelFSTlJmUCt0L0k3RW14?=
 =?utf-8?B?Y0JDamgrOWhaUUp0a3FHdUJhZjh4blVERStnK0Fna1A0b1RWanR5VUNBbEo2?=
 =?utf-8?B?RDc3YTZhMVVHTUl3SnNuOXNhRVJTS21QMVR0ZjQ0QWN0OFZ1eERGNGd0UVNh?=
 =?utf-8?B?UXhzMlUxQTFLRFJhMzVqcDZseVBaTG9qa25mUXpQUmRpRUJrODJRdlQ2dVRH?=
 =?utf-8?B?MVNady9zREdIazZWYWdrM1VDb1IzKzI5MDY3UFVBS3lvTnUrTVpYbDg4UVpu?=
 =?utf-8?B?NEx6bE80cXZQQlR5dEFNWDY0dDByckxsTVJKUWxONTVGSDg5TzgrMmxyb24w?=
 =?utf-8?B?YVZoa2FFaDZvRDVpRzJFbmc1bHhXVkRzL0gyVGR2Rmx6Z2F0Y1NJUFRlcmp3?=
 =?utf-8?B?b2dkNEhscDNQQUcybUNCQWFIQmZxa3dIMXM4ell1SCtjVGZKSDhzdUJMWmVL?=
 =?utf-8?B?dlhLb3VjZHpGTzJSdEdFbFFyVWpxRktrZDIxVUR4UEZhZzQ4aisxUGxncTJV?=
 =?utf-8?B?T2F6VG1ZVm96QTNlZTRFOFpEZURteERGbVg1anZqQ0RTM3VmMW55YzlqUU1w?=
 =?utf-8?B?Rm1hczdEaU51RnB3VXVKRTBkVVpSSEt4aVFVcVhTK0luNzlNWDBCcWVhRTVH?=
 =?utf-8?B?RUpJVlJ4VW5jRnVlLzV4K2JzKy9KOXpwMHhsWFFVZmlWcEY1c3d1VDhvQ25P?=
 =?utf-8?B?QXR5UkdydEllaklHTjVkNW5WcXhQWmpDRzBlaVBpVjdpRDM2SXpVaEtxS0Qv?=
 =?utf-8?B?RUdoZ1BvRG5TSzRpa3dIbDhpQ0hESE5ZOVB2WkRiallTbWlqbTB6eGtyNWFq?=
 =?utf-8?B?UzdQOTQrUE43bXNlWXFkVEpEUTJabUZJZXdEamxMWjdieW9IZkFzcE1zKzh6?=
 =?utf-8?B?MmhrTC9XM0hvck5wdUhOWkZFbG81SmVPcWpSQzFaU0hDTEFzWGYySyt4VVEz?=
 =?utf-8?B?aTJwRjdtekc3WklvY1dqdUd3dVVjdDFrbVlDa0E5WjJaZUc3dGNwN1JRZzNM?=
 =?utf-8?B?NG1VN1AremNGc0VjSEFJdzNFN3pRbWs2SGxnczExVGlkeVJNMmNiWjVLcDRl?=
 =?utf-8?B?ZDdyY2tTZVhRc21aRjJRS3F0RlFKTXhKOUZiUCtKNmplcERwWE5KaWk4SHUr?=
 =?utf-8?B?cEJHNm1kM2dDNStDbHRZQW9KbFlOWmF2Y3NwdFhhNFNoUzZ3V1c4MHJqRkNu?=
 =?utf-8?B?aGFzU3k4TytrLzd2UFUxS2t2cTVESTlNNlN4OUZmWmYyaFN0Y1JZVkFCWHFC?=
 =?utf-8?B?dDE4bjhBL2F1cHhGWlpGNkNOQVJadUNYQnFxUFRLM2RaYW1SYVlqNHY2OWda?=
 =?utf-8?B?VzVXRFo5R1dINlZDS1UwNHdBVzQyQ2ZGeldjWWI5ZWdqMTM4MCs3TGVJdEJ1?=
 =?utf-8?B?c01sWWY1eUdxbWNEcEpnNENqK1UxVi9URG9kZmtVM1YwV0d5WVVEMDJVT0hP?=
 =?utf-8?B?OGZ1WHhHVWRDYnNIdDdGSkVsTm9XOFJUa2trK0tPbm5XL3Y3Q2t4dzhCY2o4?=
 =?utf-8?B?NW1iOU1ieE0vM3JVMTdjMXJIU3orYTBlU2R3c0tvYXdFMnMvNm40L1JCL283?=
 =?utf-8?B?aFl6K04yZ3RyK0RTSlBrMHVDVnVmVDlSOFVXZjhjd3lYOHI0bW02clZ0Z1Jh?=
 =?utf-8?B?Q3hVUkFFaXlqTWZnNEovSUZwYTBwS1BGMjM2eU5oRHpNeDZ4N25SU0JaVmNT?=
 =?utf-8?B?bkFCVGt5WVoweWQyNmNQSnNYS0Z2dTFOTWJsbXlnUkJwdzdWd3hxcHBzY3p4?=
 =?utf-8?B?Q3p6RFhQWWV4YWlwN3Vta1JpZkZ5OVo1TTNHYWhVK0VqZlF1alRQTUQrWnUx?=
 =?utf-8?B?T2V2eloxSHJoVVBBV2dFUExPUU9SYTJMQ1QybThzZXFGTC9LSGtrRHhJZXg2?=
 =?utf-8?B?VXhiaDh3VDhEZEdyVTlvWDhxRk9sN3lFZ2N5Z3U0VURWTEZlckhmSytwRlF0?=
 =?utf-8?B?amF0WTdNMk5WeFVxWEN1MGgwTisyYVYyOXBHNjdjcjRaT1pNL0xsSkNFcUVV?=
 =?utf-8?B?RExldTVLcms0bkloaU1DWFBVRmd2N1BtWFUrMGk0d0t5V0lNVFM5MlpMZW45?=
 =?utf-8?B?MXBpV3FVVnVhb0xhMWREYnAvWENsUUVQRDNiYkR5bXE4ZzdJcHhIRmx6Mk4v?=
 =?utf-8?Q?CZJdF/ZL+vmvyq/aoVJMq5UuV+M+878Ecq8ZXJ69fV466?=
X-MS-Exchange-AntiSpam-MessageData-1: MCIaQtNobvm9xQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483216c5-d365-472a-94ec-08df33fcf342
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:36:01.7015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lB3HvD+BXvDw2PbXpWfafqjxaFpzQpkIPAN02vYh3ek6CoY1RVoeGZ3Ml+TXRnOfOQvZKzYjUiBcUqzxR1Qmfw==
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

So far, the GSP command queue transport and message layer code were
intertwined, a design issue that goes as deep as the types themselves:
the generated bindings for `GspMsgElement` even include the RPC header
at its end.

This makes it difficult to introduce the new GMC message type; thus this
patch works around these limitations to make the RPC message header more
explicit and allow it to be eventually handled by a different layer.

The `RpcMessageHeader` wrapping type is introduced following the same
model as `GspMsgElement`, and can be obtained from the latter. The
methods of `GspMsgElement` that actually query the RPC header are moved
to `RpcMessageHeader`.

Regarding initialization, `GspMsgElement` leaves the RPC header zeroed,
and the command queue code is now responsible for initializing it in a
separate call.

The only functional change is that the RPC debug messages now display
the size of the RPC payload instead of the whole message including its
headers, as they are technically part of the message layer. This metric
is arguably more useful as the headers have successfully been parsed by
the time we can print these messages.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/cmdq.rs |  50 ++++++++++------
 drivers/gpu/nova-core/gsp/fw.rs   | 123 ++++++++++++++++++++++----------------
 2 files changed, 106 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 0c18a586576c..01c83a79da14 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -54,6 +54,7 @@
             MsgFunction,
             MsgqRxHeader,
             MsgqTxHeader,
+            RpcMessageHeader,
             GSP_MSG_QUEUE_ELEMENT_SIZE_MAX, //
         },
         PteArray,
@@ -688,11 +689,22 @@ fn send_single_command<M>(&mut self, command: M) -> Result
         let (cmd, payload_1) = M::Command::from_bytes_mut_prefix(dst.contents.0).ok_or(EIO)?;
 
         // Fill the header and command in-place.
-        let msg_element = GspMsgElement::init(self.seq, size_in_bytes, M::FUNCTION);
-        // SAFETY: `msg_header` and `cmd` are valid references, and not touched if the initializer
-        // fails.
+        let msg_element_init = GspMsgElement::init(self.seq, size_in_bytes);
+        let rpc_header_init = RpcMessageHeader::init(size_in_bytes, M::FUNCTION);
+        // SAFETY: `dst.header` is a valid reference, and is not touched if the initializer fails.
+        unsafe {
+            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element_init)?;
+        }
+        // SAFETY: `dst.header.rpc_header_mut()` is a valid reference, and is not touched if the
+        // initializer fails.
+        unsafe {
+            pin_init::raw_try_init(
+                core::ptr::from_mut(dst.header.rpc_header_mut()),
+                rpc_header_init,
+            )?;
+        }
+        // SAFETY: `cmd` is a valid reference, and is not touched if the initializer fails.
         unsafe {
-            pin_init::raw_try_init(core::ptr::from_mut(dst.header), msg_element)?;
             pin_init::raw_try_init(core::ptr::from_mut(cmd), command.init())?;
         }
 
@@ -718,7 +730,7 @@ fn send_single_command<M>(&mut self, command: M) -> Result
             "GSP RPC: send: seq# {}, function={:?}, length=0x{:x}\n",
             self.seq,
             M::FUNCTION,
-            dst.header.length(),
+            size_in_bytes,
         );
 
         // All set - update the write pointer and inform the GSP of the new command.
@@ -791,23 +803,25 @@ fn wait_for_msg(&self, timeout: Delta) -> Result<GspMessage<'_>> {
 
         // Validate checksum after truncating the message to its exact length.
         if Cmdq::calculate_checksum(
-            SBufferIter::new_reader([header.as_bytes(), slice_1, slice_2]).take(header.length()),
+            SBufferIter::new_reader([header.as_bytes(), slice_1, slice_2])
+                .take(header.msg_length()),
         ) != 0
         {
             dev_err!(&self.dev, "GSP receive: bad checksum\n");
             return Err(EIO);
         }
 
+        let rpc_header = header.rpc_header();
+        let payload_length = rpc_header.rpc_length();
+
         dev_dbg!(
             &self.dev,
             "GSP RPC: receive: seq# {}, function={:?}, length=0x{:x}\n",
-            header.sequence(),
-            header.function(),
-            header.length(),
+            rpc_header.sequence(),
+            rpc_header.function(),
+            payload_length,
         );
 
-        let payload_length = header.payload_length();
-
         // Check that the driver read area is large enough for the message.
         if slice_1.len() + slice_2.len() < payload_length {
             return Err(EIO);
@@ -852,8 +866,9 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
         Error: From<M::InitError>,
     {
         let message = self.wait_for_msg(timeout)?;
-        let function = message.header.function();
-        let seq = message.header.sequence();
+        let rpc_header = message.header.rpc_header();
+        let function = rpc_header.function();
+        let seq = rpc_header.sequence();
 
         // An early return here would leave the read pointer on this message.
         let result = if matches!(function, Ok(f) if f == M::FUNCTION) {
@@ -879,7 +894,7 @@ fn receive_msg<M: MessageFromGsp>(&mut self, timeout: Delta) -> Result<M>
 
         // Advance the read pointer past this message.
         self.gsp_mem.advance_cpu_read_ptr(u32::try_from(
-            message.header.length().div_ceil(GSP_PAGE_SIZE),
+            message.header.msg_length().div_ceil(GSP_PAGE_SIZE),
         )?);
 
         result
@@ -958,12 +973,13 @@ fn drain(&mut self) -> Result {
             let msg = self.wait_for_msg(Delta::ZERO)?;
 
             let pages =
-                u32::try_from(msg.header.length().div_ceil(GSP_PAGE_SIZE)).map_err(|_| {
+                u32::try_from(msg.header.msg_length().div_ceil(GSP_PAGE_SIZE)).map_err(|_| {
                     dev_err!(&self.dev, "GSP drain: message length overflow\n");
                     EIO
                 })?;
-            let function = msg.header.function();
-            let seq = msg.header.sequence();
+            let rpc_header = msg.header.rpc_header();
+            let function = rpc_header.function();
+            let seq = rpc_header.sequence();
 
             self.gsp_mem.advance_cpu_read_ptr(pages);
             self.log_event(function, seq);
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 918a7ae809eb..54274913a68f 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -781,25 +781,6 @@ fn new() -> Self {
     }
 }
 
-impl bindings::rpc_message_header_v {
-    fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, Error> {
-        type RpcMessageHeader = bindings::rpc_message_header_v;
-
-        try_init!(RpcMessageHeader {
-            header_version: MsgHeaderVersion::new().into(),
-            signature: bindings::NV_VGPU_MSG_SIGNATURE_VALID,
-            function: function.into(),
-            length: size_of::<Self>()
-                .checked_add(cmd_size)
-                .ok_or(EOVERFLOW)
-                .and_then(|v| v.try_into().map_err(|_| EINVAL))?,
-            rpc_result: 0xffffffff,
-            rpc_result_private: 0xffffffff,
-            ..Zeroable::init_zeroed()
-        })
-    }
-}
-
 /// GSP Message Element.
 ///
 /// This is essentially a message header expected to be followed by the message data.
@@ -811,17 +792,14 @@ pub(crate) struct GspMsgElement {
 impl GspMsgElement {
     /// Creates a new message element.
     ///
+    /// The RPC header is left initialized to zero and must be initialized separately using e.g.
+    /// [`Self::rpc_header_mut`].
+    ///
     /// # Arguments
     ///
     /// * `sequence` - Sequence number of the message.
     /// * `cmd_size` - Size of the command (not including the message element), in bytes.
-    /// * `function` - Function of the message.
-    pub(crate) fn init(
-        sequence: u32,
-        cmd_size: usize,
-        function: MsgFunction,
-    ) -> impl Init<Self, Error> {
-        type RpcMessageHeader = bindings::rpc_message_header_v;
+    pub(crate) fn init(sequence: u32, cmd_size: usize) -> impl Init<Self, Error> {
         type InnerGspMsgElement = bindings::GSP_MSG_QUEUE_ELEMENT;
         let init_inner = try_init!(InnerGspMsgElement {
             seqNum: sequence,
@@ -831,7 +809,6 @@ pub(crate) fn init(
                 .div_ceil(GSP_PAGE_SIZE)
                 .try_into()
                 .map_err(|_| EOVERFLOW)?,
-            rpc <- RpcMessageHeader::init(cmd_size, function),
             ..Zeroable::init_zeroed()
         });
 
@@ -848,34 +825,27 @@ pub(crate) fn set_checksum(&mut self, checksum: u32) {
         self.inner.checkSum = checksum;
     }
 
-    /// Returns the length of the message's payload.
-    pub(crate) fn payload_length(&self) -> usize {
-        // `rpc.length` includes the length of the RPC message header.
-        num::u32_as_usize(self.inner.rpc.length)
-            .saturating_sub(size_of::<bindings::rpc_message_header_v>())
+    /// Returns a reference to the RPC header within the message element.
+    pub(crate) fn rpc_header(&self) -> &RpcMessageHeader {
+        // SAFETY: `RpcMessageHeader` is a transparent wrapper for the type of `inner.rpc`.
+        unsafe { core::mem::transmute(&self.inner.rpc) }
+    }
+
+    /// Returns a mutable reference to the RPC header within the message element.
+    pub(crate) fn rpc_header_mut(&mut self) -> &mut RpcMessageHeader {
+        // SAFETY: `RpcMessageHeader` is a transparent wrapper for the type of `inner.rpc`.
+        unsafe { core::mem::transmute(&mut self.inner.rpc) }
     }
 
     /// Returns the total length of the message, message and RPC headers included.
-    pub(crate) fn length(&self) -> usize {
-        size_of::<Self>() + self.payload_length()
+    pub(crate) fn msg_length(&self) -> usize {
+        // Note: this is transport-layer code accessing message-layer data, which is only ok here
+        // because RPC is the only kind of message we handle, and its header can (with a stretch) be
+        // considered part of the transport header.
+        size_of::<Self>() + self.rpc_header().rpc_length()
     }
 
-    // Returns the sequence number of the message.
-    pub(crate) fn sequence(&self) -> u32 {
-        self.inner.rpc.sequence
-    }
-
-    // Returns the function of the message, if it is valid, or the invalid function number as an
-    // error.
-    pub(crate) fn function(&self) -> Result<MsgFunction, u32> {
-        self.inner
-            .rpc
-            .function
-            .try_into()
-            .map_err(|_| self.inner.rpc.function)
-    }
-
-    // Returns the number of elements (i.e. memory pages) used by this message.
+    /// Returns the number of elements (i.e. memory pages) used by this message.
     pub(crate) fn element_count(&self) -> u32 {
         self.inner.elemCount
     }
@@ -888,6 +858,59 @@ unsafe impl AsBytes for GspMsgElement {}
 // are valid.
 unsafe impl FromBytes for GspMsgElement {}
 
+/// RPC Message Header.
+///
+/// The header of a RPC message, wrapped inside a [`GspMsgElement`].
+#[repr(transparent)]
+pub(crate) struct RpcMessageHeader {
+    inner: bindings::rpc_message_header_v,
+}
+
+impl RpcMessageHeader {
+    /// Creates a new RPC header.
+    ///
+    /// `cmd_size` is the size in bytes of the payload. `function` is the RPC function of the
+    /// message.
+    pub(crate) fn init(cmd_size: usize, function: MsgFunction) -> impl Init<Self, Error> {
+        let init_inner = try_init!(bindings::rpc_message_header_v {
+            header_version: MsgHeaderVersion::new().into(),
+            signature: bindings::NV_VGPU_MSG_SIGNATURE_VALID,
+            function: function.into(),
+            length: size_of::<Self>()
+                .checked_add(cmd_size)
+                .ok_or(EOVERFLOW)
+                .and_then(|v| v.try_into().map_err(|_| EINVAL))?,
+            rpc_result: 0xffffffff,
+            rpc_result_private: 0xffffffff,
+            ..Zeroable::init_zeroed()
+        });
+
+        try_init!(RpcMessageHeader {
+            inner <- init_inner,
+        })
+    }
+
+    /// Returns the length of the RPC's payload, not including the message and RPC headers.
+    pub(crate) fn rpc_length(&self) -> usize {
+        // `length` includes the length of the RPC message header.
+        num::u32_as_usize(self.inner.length).saturating_sub(size_of::<Self>())
+    }
+
+    /// Returns the sequence number of the message.
+    pub(crate) fn sequence(&self) -> u32 {
+        self.inner.sequence
+    }
+
+    /// Returns the function of the message, if it is valid, or the invalid function number as an
+    /// error.
+    pub(crate) fn function(&self) -> Result<MsgFunction, u32> {
+        self.inner
+            .function
+            .try_into()
+            .map_err(|_| self.inner.function)
+    }
+}
+
 /// Arguments for GSP startup.
 #[repr(transparent)]
 #[derive(Zeroable)]

-- 
2.56.0

