Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34089606A681
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PwN+V7kH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 961F210EA5E;
	Fri, 27 Nov 2026 14:04:35 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F74610E9E4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:04:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqUtdxMV1oc19g8zNHk75/gRiziT871DzTssEsBEgrPG/ZJBxADF1Ira5LpWTV9Hr2BTB6UN70ONOZo1UMAursD3NpT0RyEvLcETTism+sJWh4kOQ7WQf20zVLN+N0yVIaGeZa9KstGOoAK/VUn4AHtz64/94SkmdzfUUafXv2F36Ny5TmOchbn5YalhC34trmrhaTvGTf7v6yxAbCgE1EU3W201xaA178wssgJXpPMbupgLwBqlBd/yBtAJqOYh8yr9V5ft4bcqw2RGKxsTXDueiCNCyFNtLD465yxg6ivCcPtB+IVE02QpuhqVkPJdaLK0oc+okSR4/atIHy6Eag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8dAkhwB9y6sqkLUY+xmrweouPoGYxb8RkPDaIE9ZP8=;
 b=w7JjiG3ggHehHCCRLm+VpzCC0bf71xzqG1GZ3JYUAFdPu7p/ld/Asi4z0oB/40bxSYJHE2eQTXxI4+kQU27ebhvTAoXm8PxY4cg43+9Yuax1ccCyFAfba6whrTFvWcNk16J1PF0dL3wGVPNfAjGV3/w9YSMUZfIKYYBj4QS+QHS+o3HPbYeyxlT/G5OpTVKMH91flRm65uXqyOiP2NHyvOqWu7IjqRtFtsLo3Lq9dQhAP78GYL0a/zeU3f38MwX/pcYs9HqdbVOtsMUP9bFssK2QQJyzWqqmiDn6stJupp4BoKPUabNVur/cpSpPMkkzhwlBENOjIMqdDfjpLrwo9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8dAkhwB9y6sqkLUY+xmrweouPoGYxb8RkPDaIE9ZP8=;
 b=PwN+V7kH89pcm2BdzWAla366NM1kpYP+o0HzJqnV5OAAQEaFVsvQYnlYqYGB6CidryrcYTxNbrJGDRLaPd54SuKyuJMR3VAFEqp319r1ApWs29gY/vIhrIb4YN2OxeQWXsSqAz/b6lhupMj1UFJ5aBg/QulDnQIVwEBMgRdv11Md2ls894p+NTp03G2nJ06pr4hRyU6i5HTpS68q9oAwbfeFgx99ROMVdSdne4GkqNpjLRwbmbs+g9pcq+B3sxO6z6w3ikvIK0s4Wqx779oGxJzV1AnPIW8fUmud4nNw+3hcMSzds+XB6XUKH5KDaVh2XAywdbuqOsO1cD/GOWb3GA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.4; Fri, 27 Nov 2026 14:04:15 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 14:04:15 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 27 Nov 2026 23:04:06 +0900
Subject: [PATCH 2/4] gpu: nova-core: gsp: rename and move the static
 configuration type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-nova-r000-staging-v1-2-4eaf6e3c0942@nvidia.com>
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
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 76651aaa-ec88-4dfd-7d53-08df4c8f5238
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|23010399003|261026121527099003|10067099003|11063799006|261026140227099003|56012099006|261021123027099003|261022105027099003|261022113327099003|261022075727099003|261102123227099003|261009223027099003|261021121427099003|261028144727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: ha9abfM8RdA1sNh7SmIyWuczKs0lg7DaTm7i8sS5bAikrW2OA8czl/V/zI7KRp8yg96sJXf3M66xc75zpmA4W1WXrDbejGMCBamm0efTm8e1ejS/GKpz+3baUcaokt8xJrJZfrygTg29Bo5pm7sA6RvheQ0YUSNNFTikvHHKtpixPcLO5Hrua3W+kUgNoGaoDPiPVtvswB9wic4dbRB+Wly8O4LO6oELccUHaJ6SacRASuZvjkXfUDSdVuWb56ZkU33kpgz7Ug40ibSwpnpxQT6RhxM3HWB1+u+f65sev9rqgLbkFRbmwW0/WAfBnr9aCEyIhArPmei1LpIvqSzRU0c0iZW2JGE/zA6nwWTqIHsIsBEPsZReBbWMgksvJuU60jlKOFNjKyk2zVHBWCfWG9ZpPhq6PHzmAxiafLp83SdyQVFl8OVZdDeWXgL2P6kYenzdcLKboGLadJ8e7LnHVT4YcRPezCHDHYpUIW0BxkldPYcA4tfWGxFBlTe7bcWgO052gIG+AQoaFyc3ccGjgLy3LY0cHHqat5PQOTA3f2d7lLkREVg3ImX5fdpSVyTCtPDyiw5YXOB91KnBHE/SbazLbZeOxn6cR/2OSIJBcGi8p6nTvolm/eB6a3z4v/kYlKdfoVQvQVSt9CJI3nEmQOwRHGOJwxw2dxH/p4G5x1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(261026121527099003)(10067099003)(11063799006)(261026140227099003)(56012099006)(261021123027099003)(261022105027099003)(261022113327099003)(261022075727099003)(261102123227099003)(261009223027099003)(261021121427099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUdzM2hHT1N1MVpNeEcrbGU4eUpUT0V4OW93UnpGbXB0dXVidTlCSXpkMFVF?=
 =?utf-8?B?dVU5aXZ5T2t1ekh5VXIwRC9iNm80QXEzZlJVNGFWNTExNTZ4NVpKMmZuVlR5?=
 =?utf-8?B?cTRvVUJZV3owZElOTjJBR3ovVkxsbk9wOHRWREZTOHBPOG50MkZsdmxXWkNx?=
 =?utf-8?B?M0pMcW1CSGJXZU16bUFxdm5JV2JBdWtNV2phWUdOR0JqQWUvSHRaU1daT1dM?=
 =?utf-8?B?ME1uUG1zR21qM1FwdGo0WDd6K3Z6ZUJ5Q1RtazN4enFpRUtxNnpndWY5WTRB?=
 =?utf-8?B?SnpMMmVFSWMxUlBuMnZoS2pzeU43K3M5VFd4K0gwUis2TDF6SkdpQ0VmNzZa?=
 =?utf-8?B?MHdPS25DWVgyREdURTk0dkZqUlFXa0ttTEZpVFY3QUdoSlgvTm9aODU0VnFj?=
 =?utf-8?B?K3l4Njg0WFlVVXdYSm54NWxpSCtNYlZUbEhiK2NaN1Q0WGcvUE82TU9iWS9k?=
 =?utf-8?B?OXpQU2gxZnRpRFYybWF4RGtWNjQzRjc1TXZaWUhScmJIWkM2ZEpKU29Dbmhi?=
 =?utf-8?B?U3NBYjI1RFMydnlYcEIrbmFSNTE0TzE2emNIYWNMaDRrM010U0h4V0RCUjJW?=
 =?utf-8?B?T3RLUTB6NFNOZ3dsZ2lPdlZWL1pOUXF3S0dRSjlydk85KzhlUG15Y3VHYzE1?=
 =?utf-8?B?TjMzUURia2l5dFBpN3RWcmQwbDNJOEpjdE5BNmVLTlk3KzFqdHlIK3ZCZ3d0?=
 =?utf-8?B?aG5nc0FiMHRpd3pZUnpUSlNVNGhzb1ZoMnFGOFIrZjMvTzI2dTdPMitjcGRF?=
 =?utf-8?B?NFB2ZzVXYXlvcy94aGFFejhsMGFDQ0RxQzFpTGV5VXhWdHlDZW9CeGhzU3Bw?=
 =?utf-8?B?Q0ZxQjRtaVRDZUdnc1U1c3VXd2F2dDhTTUVXN25PZkxXelhEa0JNb1N0RFFY?=
 =?utf-8?B?U3BqRTBsUkZyN2tmUU9EWGpxdHg0eWdSQWRVc3hZUFRCVlpvU011SzBoMTVD?=
 =?utf-8?B?bUVaZ2VlaVFvUnlEVkhtdXVYYnJjVGhCVEJVbXVmZy9ENzZOODZPeWFjbkdO?=
 =?utf-8?B?NWVsWlVKejd5a3l0c2pESzNVOEN4MUF3ei9vaEt2TVFqZnhaNkQwTVN4K1J4?=
 =?utf-8?B?WVZTTDVNOHA3MUlJSy9MaEE0YnNrODJpSTVMWXNUeDRwalZNY0VmWlBJQjM2?=
 =?utf-8?B?OFZ6bGxxNTAyQURINldtNVZTRVJNcTROWWdGSkJCQ0FEbzNDalRldkdMMzlG?=
 =?utf-8?B?SXNHWUdnTksrbDVqVHlvOU05MlVZMndvOVhlYUR5TnlBVW1GMHE0bS91ZEV1?=
 =?utf-8?B?OGoxV2xEbFNMT3pvbjFpOGp0K1ZOMHVSK21XVVNvN1p1OFZaSDNOTUZyNHNN?=
 =?utf-8?B?WWJMMkptSDgzL0JtMEFxOHdTcmZLN1ZsWlMyTXo4TXFXTDFKK1p1UEJjTGw0?=
 =?utf-8?B?cDFRVWplK3JkRUZDSlF3TytKUmpWelllK2xvWUwyUkpSaFFPUTgwQy9tVnNO?=
 =?utf-8?B?Y1JidnEwYThRdFBia0M5NWxtbmtKT3JtbTNuaFFsTHZpenlDUFVHN0ZDNUtH?=
 =?utf-8?B?TkZhZy9kNXVBVWVEUFdtRXlUUmlJSi92b3VscmgrNWhXQmR3RTZ4S3lJYTFW?=
 =?utf-8?B?ejBLWWw2dkUvYmUwWDUxK095aVZiSFJKL0RkUmlPVFRlRGpIK01lcS9nTEcz?=
 =?utf-8?B?ZTZ6RjhKUUF1Vjg3S1dqdTA0RjhnYlg4TTRyaFRtMzFLSlFCR2t1S3gwa0p5?=
 =?utf-8?B?eFV1Q2IyTlZRdVM4QkgybVpHeklPYS9ZRUlBbSs5VHBTaHlVYnUvUzRYbXFK?=
 =?utf-8?B?TGgxNXRLYnJOWkd6ekpRZ291KzBCSFowcFJuWmVnUVBuMXVybStiNGxBRXJ0?=
 =?utf-8?B?NUJhVDlxSG44RWRlbVJaQjVocDhJY2VQQ0M5VGJzZHhEWFlMbmZudWNPU0Vn?=
 =?utf-8?B?Ylo2Z211MldxbTJzRnVBSFluazlVQ21HV3AvTHR5cnZLN3JUVXFZU2VnR05Y?=
 =?utf-8?B?ZHdQV3Jrdnhac3I3b3I4Qlhnck9tN25ucmVnRms0MGFUSlJKTlVEVzZicVpY?=
 =?utf-8?B?cjZDUW5DL2s1NGMvaWNKQ3F1S3lZL1RheXdiWmdZRXYrWGxTZmJBUjBpNUI1?=
 =?utf-8?B?MDhwZ0NNRkYwRlVTdWptTHBtZDB6dVh2VTgwRWpuUGVVU2ZLOSsxTmhabWxR?=
 =?utf-8?B?RE9LQUhWZG5TS0hmS2lUZGV0a010WStSdVh4Mzg4M1I5Q1k3Q3JGd0N4WWlV?=
 =?utf-8?B?b0NtemttRENudStkeHpxYThIdys4WWQ2RUg3T252bU5VVWNvNWFkYzBFZkND?=
 =?utf-8?B?YlYxNlV3TGZSQWo2cmo0VkNmYjIrL1AreS93a0xHRERLUlB0K1d1dWI2L3kx?=
 =?utf-8?B?dXRiUzBudEhZN0o5YWZzV0FTTzJaelRhc1JpYVVvUnpkR200a0RBZ1N0anIv?=
 =?utf-8?Q?Bmc3R3+lErViALTzOLdL24AKw/oLZdWE8gkUlKjc4CEJx?=
X-MS-Exchange-AntiSpam-MessageData-1: poiPyrFe1ixgCA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76651aaa-ec88-4dfd-7d53-08df4c8f5238
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:04:15.4448 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wC4J8sKfKqICpxmGI1g90kW77r1gipO6bJPgFSB4n5rmQeJkbt84JCq5WQ/4hd8vUcNNWLlrrrbeOarT598gvw==
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

With the r000 firmware, GSP-RM reports the static GPU configuration in
its reply to GSP_INIT, a GMC command, and no RPC command fetches it.

The type that holds the configuration is named after the r570 RPC
command that fetches it, and it is defined among the RPC commands.

In order to make the type available to a GMC reply, name it after its
contents, and move it out of the RPC commands, up into the commands
module.

No functional changes.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/api.rs              |  6 +--
 drivers/gpu/nova-core/gpu.rs              |  4 +-
 drivers/gpu/nova-core/gsp.rs              |  2 +-
 drivers/gpu/nova-core/gsp/commands.rs     | 65 +++++++++++++++++++++++++++++
 drivers/gpu/nova-core/gsp/commands/rpc.rs | 68 +++----------------------------
 5 files changed, 76 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index dc877ddebe8c..f800ba6c4183 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -18,7 +18,7 @@
 use crate::{
     driver,
     gpu::Gpu,
-    gsp::commands::rpc::GetGspStaticInfoReply, //
+    gsp::commands::GspStaticInfo, //
 };
 
 /// API handle for the auxiliary bus child drivers to interact with nova-core.
@@ -39,8 +39,8 @@ pub fn of(adev: &auxiliary::Device<Bound>) -> Result<NovaCoreApiHandle<'_>> {
         NovaCoreApiHandle::of(adev)
     }
 
-    /// Returns the GPU [`GetGspStaticInfoReply`].
-    pub fn gsp_static_info(&self) -> &GetGspStaticInfoReply {
+    /// Returns the GPU [`GspStaticInfo`].
+    pub fn gsp_static_info(&self) -> &GspStaticInfo {
         &self.gpu.gsp_static_info
     }
 
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 8ab1687847ff..590d81f4e479 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -32,7 +32,7 @@
     gsp::{
         self,
         cmdq::Cmdq,
-        commands::rpc::GetGspStaticInfoReply,
+        commands::GspStaticInfo,
         Gsp,
         GspBootContext, //
     },
@@ -394,7 +394,7 @@ pub(crate) struct Gpu<'gpu> {
     #[uses('tree)]
     _gsp_subtree: GspSubtree<'gsp_resources>,
     /// Static GPU information as provided by the GSP.
-    pub(crate) gsp_static_info: GetGspStaticInfoReply,
+    pub(crate) gsp_static_info: GspStaticInfo,
     /// GPU memory manager owning memory management resources.
     ///
     /// Must be kept declared *before* `gsp_resources`, so that its components are dropped while
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 2f1cdf8b7bec..398d6525b133 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -159,7 +159,7 @@ pub(crate) fn new(
     }
 
     /// Query the GSP for the static GPU information.
-    pub(crate) fn get_static_info(&self) -> Result<commands::rpc::GetGspStaticInfoReply> {
+    pub(crate) fn get_static_info(&self) -> Result<commands::GspStaticInfo> {
         self.cmdq.send_rpc_command(commands::rpc::GetGspStaticInfo)
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index 5f1c944678be..4aae94b7ca2e 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -2,3 +2,68 @@
 // SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 pub(crate) mod rpc;
+
+use core::{
+    ffi::FromBytesUntilNulError,
+    ops::Range,
+    str::Utf8Error, //
+};
+
+use kernel::prelude::*;
+
+/// The static GPU configuration, which GSP-RM reports in reply to
+/// [`GetGspStaticInfo`](rpc::GetGspStaticInfo).
+pub struct GspStaticInfo {
+    gpu_name: [u8; 64],
+    gpu_short_name: [u8; 64],
+    /// The 16-byte SHA-1 based GPU identifier (GID) reported by GSP-RM.
+    pub gpu_gid: [u8; 16],
+    /// BAR1 Page Directory Entry base address.
+    pub(crate) bar1_pde_base: u64,
+    /// Usable FB (VRAM) regions for driver memory allocation.
+    pub(crate) usable_fb_regions: KVec<Range<u64>>,
+    /// Exclusive end of the FB physical address space.
+    pub(crate) total_fb_end: u64,
+}
+
+/// Error type for [`GspStaticInfo::gpu_name`].
+#[derive(Debug)]
+pub enum GpuNameError {
+    /// The GPU name string does not contain a null terminator.
+    NoNullTerminator(FromBytesUntilNulError),
+
+    /// The GPU name string contains invalid UTF-8.
+    InvalidUtf8(Utf8Error),
+}
+
+impl GspStaticInfo {
+    /// Returns the name of the GPU as a string.
+    ///
+    /// Returns an error if the string given by the GSP does not contain a null terminator or
+    /// contains invalid UTF-8.
+    pub fn gpu_name(&self) -> Result<&str, GpuNameError> {
+        CStr::from_bytes_until_nul(&self.gpu_name)
+            .map_err(GpuNameError::NoNullTerminator)?
+            .to_str()
+            .map_err(GpuNameError::InvalidUtf8)
+    }
+
+    /// Returns the short name of the GPU as a string.
+    ///
+    /// Returns an error if the string given by the GSP does not contain a null terminator or
+    /// contains invalid UTF-8.
+    pub fn gpu_short_name(&self) -> core::result::Result<&str, GpuNameError> {
+        CStr::from_bytes_until_nul(&self.gpu_short_name)
+            .map_err(GpuNameError::NoNullTerminator)?
+            .to_str()
+            .map_err(GpuNameError::InvalidUtf8)
+    }
+
+    /// Returns the total usable VRAM size in bytes, i.e. the summed lengths of all usable FB
+    /// regions.
+    pub fn vram_size(&self) -> u64 {
+        self.usable_fb_regions.iter().fold(0, |size, region| {
+            size.saturating_add(region.end - region.start)
+        })
+    }
+}
diff --git a/drivers/gpu/nova-core/gsp/commands/rpc.rs b/drivers/gpu/nova-core/gsp/commands/rpc.rs
index 023090ac6bd9..ab6d1114cead 100644
--- a/drivers/gpu/nova-core/gsp/commands/rpc.rs
+++ b/drivers/gpu/nova-core/gsp/commands/rpc.rs
@@ -3,10 +3,7 @@
 
 use core::{
     array,
-    convert::Infallible,
-    ffi::FromBytesUntilNulError,
-    ops::Range,
-    str::Utf8Error, //
+    convert::Infallible, //
 };
 
 use kernel::{
@@ -30,6 +27,7 @@
             Cmdq,
             NoReply, //
         },
+        commands::GspStaticInfo,
         fw::{
             self,
             MsgFunction, //
@@ -208,7 +206,7 @@ pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq<'_>) -> Result {
 impl CommandToGsp for GetGspStaticInfo {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
     type Command = fw::commands::GspStaticConfigInfo;
-    type Reply = GetGspStaticInfoReply;
+    type Reply = GspStaticInfo;
     type InitError = Infallible;
 
     fn init(&self) -> impl Init<Self::Command, Self::InitError> {
@@ -216,21 +214,7 @@ fn init(&self) -> impl Init<Self::Command, Self::InitError> {
     }
 }
 
-/// The reply from the GSP to the [`GetGspStaticInfo`] command.
-pub struct GetGspStaticInfoReply {
-    gpu_name: [u8; 64],
-    gpu_short_name: [u8; 64],
-    /// The 16-byte SHA-1 based GPU identifier (GID) reported by GSP-RM.
-    pub gpu_gid: [u8; 16],
-    /// BAR1 Page Directory Entry base address.
-    pub(crate) bar1_pde_base: u64,
-    /// Usable FB (VRAM) regions for driver memory allocation.
-    pub(crate) usable_fb_regions: KVec<Range<u64>>,
-    /// Exclusive end of the FB physical address space.
-    pub(crate) total_fb_end: u64,
-}
-
-impl MessageFromGsp for GetGspStaticInfoReply {
+impl MessageFromGsp for GspStaticInfo {
     const FUNCTION: MsgFunction = MsgFunction::GetGspStaticInfo;
     type Message = fw::commands::GspStaticConfigInfo;
     type InitError = Error;
@@ -245,7 +229,7 @@ fn read(
         }
         let total_fb_end = msg.total_fb_end().ok_or(EINVAL)?;
 
-        Ok(GetGspStaticInfoReply {
+        Ok(GspStaticInfo {
             gpu_name: msg.gpu_name_str(),
             gpu_short_name: msg.gpu_short_name_str(),
             gpu_gid: msg.gpu_gid(),
@@ -256,48 +240,6 @@ fn read(
     }
 }
 
-/// Error type for [`GetGspStaticInfoReply::gpu_name`].
-#[derive(Debug)]
-pub enum GpuNameError {
-    /// The GPU name string does not contain a null terminator.
-    NoNullTerminator(FromBytesUntilNulError),
-
-    /// The GPU name string contains invalid UTF-8.
-    InvalidUtf8(Utf8Error),
-}
-
-impl GetGspStaticInfoReply {
-    /// Returns the name of the GPU as a string.
-    ///
-    /// Returns an error if the string given by the GSP does not contain a null terminator or
-    /// contains invalid UTF-8.
-    pub fn gpu_name(&self) -> Result<&str, GpuNameError> {
-        CStr::from_bytes_until_nul(&self.gpu_name)
-            .map_err(GpuNameError::NoNullTerminator)?
-            .to_str()
-            .map_err(GpuNameError::InvalidUtf8)
-    }
-
-    /// Returns the short name of the GPU as a string.
-    ///
-    /// Returns an error if the string given by the GSP does not contain a null terminator or
-    /// contains invalid UTF-8.
-    pub fn gpu_short_name(&self) -> core::result::Result<&str, GpuNameError> {
-        CStr::from_bytes_until_nul(&self.gpu_short_name)
-            .map_err(GpuNameError::NoNullTerminator)?
-            .to_str()
-            .map_err(GpuNameError::InvalidUtf8)
-    }
-
-    /// Returns the total usable VRAM size in bytes, i.e. the summed lengths of all usable FB
-    /// regions.
-    pub fn vram_size(&self) -> u64 {
-        self.usable_fb_regions.iter().fold(0, |size, region| {
-            size.saturating_add(region.end - region.start)
-        })
-    }
-}
-
 pub(crate) use fw::commands::PowerStateLevel;
 
 /// The `UnloadingGuestDriver` command, used to shut down the GSP.

-- 
2.56.1

