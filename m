Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09F6C44501
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4553010F783;
	Fri,  3 Jul 2026 10:23:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0uB7GdE";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C57A10F783
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sq0PgOxneqzzr5rjaJfBWoq+dnXjvAjqW6NDNU1s16r3/d4JoZAuYSz7OOQ9WF/jnGJuq7Ze5PvpDRsOVwwNUkS/cd0cKPd86y3rdXNa8UFeePQVfP5gq3r2TfNbyYSMoI0MyXiqdhiNVllGohaULcupK8XQNopdfni3C/O1GDUloVRuMDzMZEUPdc9Nd1yM2gdc4TmVqLqVR234bzo9Tjp2OyViRSSLNY/ZayePjLFS1JqyMCEJynsdAQG29cBT0ne1iH6HpFREdHwMN08hZRCaorGIzSvqK1jWeOyCmzrVlJzFWzijV2Qm1f/gmcC3AL2hGhaomwda5Sbl2oMc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MslzB7PhFou2Ge5rCvZekyUX1vGzbkGAAW8EEFi3lrs=;
 b=TrtyBBYp0Xp0VGkFqc4L4A5yMRnmpPoeaqTkF25CP1Obo8i3lQwj97Q3nxJAe+VaveWfzTJJxoMoPyZn7oF3k2GM9rKf5hV+lExHXZ5rOUPC5w5zXpogDf0actNYpeFe8Dq0N0Wo7TaJgGkNKl/KdvvZier2z852zSzG0YcXhMU6CQoH6cPOJeJs3n7PbuP+56TevifhVuAmwaz82V3ionqipOYXqB7bqMY1QAxNPnNp+wfUwRd8YmPNVv2xB8F1CVpzyfUiY0Y9oIt9g0UkhL71TDk1JBcozPzuFtuCSfzeYFL8tLTB28hwuozXrAr2kMoKPFYyfuWRVT5A8oclmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MslzB7PhFou2Ge5rCvZekyUX1vGzbkGAAW8EEFi3lrs=;
 b=C0uB7GdEPkZUAMlOvqjpyVW0IZ536DePQS6VWiQPKN93X/uOshKN49tV67vQzyZDItm+aCpDWgpgjZ/tLMvgT7HrtfI8R1BixlK1pNglaHa1ndBEdFyzLpOGyvMUqwtASPMRa4NMH4ZDko5VF6As8dXMeM43BUHkRBA2jOxcfZygy3cE7rI7S3FBUHqksNAJlmjWIUyIwAEkW2xMfRHxw+/IbUkgcLWjrhnP5bi5AM970OpWdSCia4UYnuI05hvovbsBkCeDTFJevMMH+ZfVRXU2unAlCiWBY0+XyuheflXjFUSVu4bQJguMpmRqDP/uDHGo0M4KuwiOO4aLSav6rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH8PR12MB9743.namprd12.prod.outlook.com (2603:10b6:610:27a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 10:23:03 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:23:03 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:22:14 +0900
Subject: [PATCH v2 10/10] gpu: nova-core: wait for RISC-V HALTED on FSP unload
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-blackwell-fixes-v2-10-8e3d8bc32bb9@nvidia.com>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0172.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::9) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH8PR12MB9743:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a5c515c-3148-41e2-d308-08ded8ed10bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|56012099006|11063799006|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: fxKcLvcPKFUn4mCjCFM53tbjihfXBrSzctInBpJfW+C1npDiRdWWwLA9tZjSza3unTRpyX4tyzfeRi9/z8K+Vw73T4HHvr0gBIGiBS4pn4dIEKXxsS8/dRDfV82PzmQ6wtISeX2ZxK5i751WCQw9xDkXFshcl03fKMOw4NvfdwJ+Psa+oOBC65IqqO+q0NlLqZKR7ekxeA5Bkzt8w6lEUTu75W2kLrepVcaCb2nX/n57q55zTyZdXVcUurtoZrSxwLiNYl47AoQpqDePYDH43sjDAGt5VMbtwWKLlcFIkFESPlj/sx3h15N0tXH32bAv7f2ZIRbEMzyQjdCO0HOrX11nFuz+W6OcNuuT7/0arWuCNtkT55JT6wRWrXmxVayQUULiWEe5mMB4GOtH7fEJYKSruaK2cJE6ske/9ODeenLWYIHaQUvzFh3JbLwTxYGCC56Fu370lh9gjzMZIpnHt3chJXpocbMmpAH00wse1vfNRtOB8N9pkNqK8j7sJd0bMmdAT6fy3obx5Q6mdwiPzL9ph8oo7TS/EwmpsWiG56Kyakgxjp3V7IqntDOHgG8u2UM2L9FopaTUplwH4YeL7wc0acAwaoPXYlmpUo7W2hUWHiuwCQGfqM9AUA2REORCyav9xSdP0jizITMBh3iH1BCTfbCB7cnaZXGloIUm8xE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(22082099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGcxZFRqYXEyakMrYWF2MlVTTXBLS09xcjN4eFNzSW1BRkhzdE91czk2SWhy?=
 =?utf-8?B?QmtkaFBiNkVPQ2VwZk9WUDRTR25PamUvMTlpLzNadXFxb25LYzFhcUVlb1ps?=
 =?utf-8?B?d3pjRk0xanV3N3FFelBhZWxxb1VLTE5NcDJMSzk0Q1cxelJQd044ZktacWxQ?=
 =?utf-8?B?VXhGTnVMclVkdGlaMkRhNnVjOTg4TERLMlpHd2NhVk5EdE9Pem5HWXN3aU5V?=
 =?utf-8?B?MExYSnZhTVNQeEtJT3BTVkdZaGlkZFc1enZESS9jWk9BM284OXpSNTRQMTh0?=
 =?utf-8?B?NWllTUthT1NGK3BwUXdoVUpnd3FVUld2RXkvdGpVaFFBeTNXZUF6ZmZWRkNF?=
 =?utf-8?B?VkZrTE1oeWZlQjNwcDU1azdlaU10YUZWeDNmZFl3YS84bTdrV2oxRTBDZmg4?=
 =?utf-8?B?aVNFUCtmQW1TdlI3T2VpYXo1cE80dWpMR0ZqWUpNN0RJdXVCekpEZ1o1dnM5?=
 =?utf-8?B?cG44cnFLRHg2WkE5ZXJUbHFmck1WdlpaZ1pVdTRlc1FvRVRhMVVweUU1MlNn?=
 =?utf-8?B?Sy8zaE5rdE1sSDdJNkludjJVMnJyTjBmSmZ5VUFJb0NJY0g3dmUrUEF6TnJn?=
 =?utf-8?B?R2Fvc0U4WGZLdU52T014V2dXbERhd0hOVDhjZGNNRkZhaWhhZERCMnhCdVF5?=
 =?utf-8?B?KzlnREdxWStaNmFjaFFyRC9mMUV3dDUvMWIrdmJPY05uVGlQNk1lQ2V2UlVV?=
 =?utf-8?B?bXBUQXRMUjAwUEtGL1RQdTZsK2JBZUlKSzJreFhRbi8rc0VweWZsSzdDMm9j?=
 =?utf-8?B?QnRxaXVvZHFqcGV0ZGM3ZmJTUERSZng5RWQ5OC8vd1pyRFNoMFp6aVUydUxt?=
 =?utf-8?B?UDZMc0wwVjNvQkZ2S3NwMVZOUFFxU3Bad1g1MERJYklTOUorUXZwYmhyWFhE?=
 =?utf-8?B?Y1N0TmxGWFlJR1AvUWNCTmZGSnRlRWRNZUI5QTQwbVFSeUdFSS92QjJpNFJW?=
 =?utf-8?B?QmxEZ0wvbUhlcHFtZmNBekdqV0xmNGQrU1JhQXJ3anlCL2tnL0VhT2N2V3VB?=
 =?utf-8?B?MjFjSWVTOWhlbkdWekVXNnRkb0ltajBOYS9lci9GSkFCUDJLMUUrMU4vR1VU?=
 =?utf-8?B?ajVlTjhPY2ljT2JDMGR1YXczenNPcGJySjZZRFE1aTJqN1daUTFyNWlQdEN6?=
 =?utf-8?B?UzRaZ1VvbmFmVWxSUVlSb3pMcUttcE5ldVM3Uzc5SVZibTlYd2NMRXU1UnQz?=
 =?utf-8?B?UHh6bi9FdGlVOHEraWJHSXZmVG5QWk1zWHVTR2d3b0V3MGZuUnNsdGZxMWs3?=
 =?utf-8?B?MEZrYUE3eGN6QitoZnF2b25ZdC9UVE0yd2F1akc3RkNLdGo4VVdCUm01ZW5C?=
 =?utf-8?B?WEthL2txNU5EVGViWnNRQllrUFAwd2RGcExYUVpVQXZpalIyR0hOSVJMb0hq?=
 =?utf-8?B?b2cyemY2UTY3NHg4NUlvUU1mM1UrYm93MGxTb242NHB6eFRHTC9kbHhoUjUy?=
 =?utf-8?B?Wk1XWExaZjFRWWFacHlmTVBYVEMvbjROR1d5YTVyUGpPQVRmejkwWXVJRGd5?=
 =?utf-8?B?cjZ0ZWcxNCtLWFYvY1RBK2E2K3gzUEFDL0o3TVErYW9qdFVNNnhwWmUxQ0tG?=
 =?utf-8?B?K2pmbTZRNzlPUnY3VERlbnQzN3hwcnNGcWtsVFByR3cySG5vRXJZOUExbDJW?=
 =?utf-8?B?RXZSYTFqUnV0bDlaVHBDaVl3SGF3dDlNTFdIVDI3SzNzam9wb2Ixa2U1Sndu?=
 =?utf-8?B?V2JkQWhGRUozU0RrbUkyZzR3Mi9iM0V4SVM5QmoydnpoMVFqQXVjaTRCenF3?=
 =?utf-8?B?K1lBdkdDRkM5VFh5STdjTUpubllVMzdjS1laa3F1cStPWmZyOFpxc2xYbk0y?=
 =?utf-8?B?VUlqUjRlYW5sRVJCRERSY0JIYzVGWDJmbTQwM1hhSGFMVWh5Q1ZCRTg3czRE?=
 =?utf-8?B?ZGcvOFp1b1U2M0ZmOFNTNnZYZldMemJVSTR5aDJQanN2UjNPNFVqVDRvMTJt?=
 =?utf-8?B?OVlpbHRidnlyMkxOdDVEekJnUEVjdEdwUWFYbld2UlUrU1NqS2VWODRydHk4?=
 =?utf-8?B?bUh1bDVWaTYwVVNnclo4QVRVQW5EQmE5ZWhZNFFOMnhQOW1CTjA4Ny9YV2sy?=
 =?utf-8?B?YTk5U2RQS2RWeGw1NnYyNWNtckZXZlIzT1hNRXNOdFM5aVUvcGhuK3lsWW8w?=
 =?utf-8?B?b1FKVkFwNDgwSVBQdmVORzJ5c2RvUDF6RTg1MXpGeFlYK3NybXJFWkhWNVVF?=
 =?utf-8?B?WC9PUTVhT3dUVkpSaXFhTnJiVGk3b2NZR2pPTG1DbmFCQVhnaFV6SnZVUndv?=
 =?utf-8?B?NjAxOFlHTlRXVUxvcHNFdllOMVRkWHJvcElKTzQ2Q0tlc1FFb1VmbXJTQmNU?=
 =?utf-8?B?VWFjUTV6N0lZaDJTVDI4N0RqbGRkTHJrbkt6WTZRNDNQUjRSVzFqaW1sNHFW?=
 =?utf-8?Q?tbmfVLDS0yqHPHDjrxrcm8kRhM0TTFWvC94Wc/DqlOsB0?=
X-MS-Exchange-AntiSpam-MessageData-1: ESHl1SMBMtdw5g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a5c515c-3148-41e2-d308-08ded8ed10bd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:23:03.3656 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4rnA5RyR5XZch702w4Wzuk3X0WKi5kQclC+7T+ABZBJNJl104owlkcqbqWn+/QSAJSmQXVf/CIit8EZtwNHtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9743
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

Currently the code waits for "not active" but this is not the same as
halted as there are more than two states. Match openrm here and wait for
halted instead.

Fixes: c7fea1f70944 ("gpu: nova-core: add non-sec2 unload path")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/falcon.rs           | 11 +++++++++++
 drivers/gpu/nova-core/falcon/hal.rs       |  5 +++++
 drivers/gpu/nova-core/falcon/hal/ga102.rs |  7 +++++++
 drivers/gpu/nova-core/falcon/hal/tu102.rs |  4 ++++
 drivers/gpu/nova-core/gsp/hal/gh100.rs    | 11 +++++++++--
 5 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 78948cc8bff3..ec286017535f 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -749,11 +749,22 @@ pub(crate) fn signature_reg_fuse_version(
 
     /// Check if the RISC-V core is active.
     ///
+    /// Note that this does not imply that the RISC-V core is halted if it returns `false`.
+    ///
     /// Returns `true` if the RISC-V core is active, `false` otherwise.
     pub(crate) fn is_riscv_active(&self) -> bool {
         self.hal.is_riscv_active(self)
     }
 
+    /// Checks whether the RISC-V core is halted.
+    ///
+    /// Note that this does not imply that the RISC-V core is active if it returns `false`.
+    ///
+    /// Returns [`ENOTSUPP`] if the status is not available.
+    pub(crate) fn is_riscv_halted(&self) -> Result<bool> {
+        self.hal.is_riscv_halted(self)
+    }
+
     /// Load a firmware image into Falcon memory, using the preferred method for the current
     /// chipset.
     pub(crate) fn load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) -> Result {
diff --git a/drivers/gpu/nova-core/falcon/hal.rs b/drivers/gpu/nova-core/falcon/hal.rs
index ee4a017f3a4c..7e532889a1f4 100644
--- a/drivers/gpu/nova-core/falcon/hal.rs
+++ b/drivers/gpu/nova-core/falcon/hal.rs
@@ -53,6 +53,11 @@ fn signature_reg_fuse_version(
     /// Returns `true` if the RISC-V core is active, `false` otherwise.
     fn is_riscv_active(&self, falcon: &Falcon<'_, E>) -> bool;
 
+    /// Checks whether the RISC-V core is halted.
+    ///
+    /// Returns [`ENOTSUPP`] if the chipset does not expose RISC-V halt status.
+    fn is_riscv_halted(&self, falcon: &Falcon<'_, E>) -> Result<bool>;
+
     /// Wait for memory scrubbing to complete.
     fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result;
 
diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index fe821ded5fa1..7600ee07ca2e 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -139,6 +139,13 @@ fn is_riscv_active(&self, falcon: &Falcon<'_, E>) -> bool {
             .active_stat()
     }
 
+    fn is_riscv_halted(&self, falcon: &Falcon<'_, E>) -> Result<bool> {
+        Ok(falcon
+            .bar
+            .read(regs::NV_PRISCV_RISCV_CPUCTL::of::<E>())
+            .halted())
+    }
+
     fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 20ms.
         read_poll_timeout(
diff --git a/drivers/gpu/nova-core/falcon/hal/tu102.rs b/drivers/gpu/nova-core/falcon/hal/tu102.rs
index 34bf9f3f44c7..5291598fedf7 100644
--- a/drivers/gpu/nova-core/falcon/hal/tu102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/tu102.rs
@@ -55,6 +55,10 @@ fn is_riscv_active(&self, falcon: &Falcon<'_, E>) -> bool {
             .active_stat()
     }
 
+    fn is_riscv_halted(&self, _falcon: &Falcon<'_, E>) -> Result<bool> {
+        Err(ENOTSUPP)
+    }
+
     fn reset_wait_mem_scrubbing(&self, falcon: &Falcon<'_, E>) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 10ms.
         read_poll_timeout(
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 6fc6d487e4c8..2a7aecd55b60 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -115,8 +115,15 @@ impl UnloadBundle for FspUnloadBundle {
     fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for it to finish.
         read_poll_timeout(
-            || Ok(ctx.gsp_falcon.is_riscv_active()),
-            |&active| !active,
+            || {
+                // GSP register reads are not meaningful until the PRIV target mask is released.
+                if !ctx.gsp_falcon.priv_target_mask_released() {
+                    return Ok(false);
+                }
+
+                ctx.gsp_falcon.is_riscv_halted()
+            },
+            |&halted| halted,
             Delta::from_millis(10),
             Delta::from_secs(5),
         )

-- 
2.54.0

