Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ABC606A333
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GINUyWL5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FE9A10E9E4;
	Fri, 27 Nov 2026 14:04:41 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010011.outbound.protection.outlook.com [52.101.201.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB86410E9E4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 14:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnEPM8I9GGRSDfbLll/8e1s0KVN3/gUJYPmTaqHvlf+5cTk5SzbQNv0YC7qQ73SYXst7Hd2F/D63nKb6PN8vgdpd+sgGgzXM+gnZi8q+UP1e50EKDRYeMvAlXa2zHlf2c3C+xzsCpnEhUihKIzHdaoqZaAKo+34dNEuGKjUspKWtSqCDlMiGOk4Js12nQQNY8b9ORHtgLjaKQzxm68LAiq53puODM/elADnCq3CQhke8SRDF4NRP9DrwCvo0U6VZqgoo/S3PMDWWKUVQyDO3bGs305dy2kcyhIDP9wMaHACG2C5B/wMVdbFXDWw8PtYftDbQdjdip4DKjzliW0/trw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yZ8Uk/imzmj8YoCqq3nnQqHOKRXU6SGUT2osWC2ICM=;
 b=TryBQV4szHUIOKNcvtaWDL6Mz5bVMJ9s+n/Bptn+hfoqFig2uG0CZWeR1iwiso1vOBg3xo2XZi01+j4ggMrifZ+tM/VJSHJbPTbhTXCaUfrUkDyK9t0NuN1/jQ+3m/GvGjVbSbY6wGkpuySkOvqzqGamxDKezwLNhyKd2OKCp3/BdSxkLV10j4I8It5/4YOb8tp5wyPzRKodIuqGjTFaB/E6E4qiMN9W9hf6My8vOzdzNTn2q4gDa5FSGJGY1JsZYYcA3jpolmRZXYY3oQEb9wQNPQHUlMFHxByyWZJLXP2xoe4s0Y4GMqldZ6ZCB3H8cbnFGULGjYho8jueL5IYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yZ8Uk/imzmj8YoCqq3nnQqHOKRXU6SGUT2osWC2ICM=;
 b=GINUyWL55Xke2bclY92aVQg4rIRXdKUfHe1pqSYbeFt+Wd7rX5R+Z0xEiTCStiTlSW2dwyXD2JEDznfbgtU8WOiJ3w30K6fX9Tl3Za6GkRkOlblZ8ynSUzc0mSQy/j4D8Kzodh7BJ7/0dVLAFc4jVFlFBphMYv+5hulmfnzm/Ar2fbhdrVfc0nKcJE4BbIBvOOivBDxU9xriJvpvk0ApbE1384ZSBmb9oSEYZpm7nbzxOzJrEw2xiQBBYDgox5WicJv8e7FzSV5iOAd8077dsbq72yXQvAtUm2xs7U++EMNWigmhun4Jg6ioYtrly8fUd0QrhI+ufg5BIt0f0LvSSA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.4; Fri, 27 Nov 2026 14:04:20 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0662.001; Fri, 27 Nov 2026
 14:04:19 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 27 Nov 2026 23:04:07 +0900
Subject: [PATCH 3/4] gpu: nova-core: gsp: return the static GPU
 configuration from boot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-nova-r000-staging-v1-3-4eaf6e3c0942@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS7PR12MB6168:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b30ca07-0b42-4922-aab2-08df4c8f5449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|23010399003|261026121527099003|10067099003|11063799006|261026140227099003|56012099006|261021123027099003|261022105027099003|261022075727099003|261102123227099003|261009223027099003|261021121427099003|261028144727099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 6KaE7AEzDeD0jXEsTM+UGMnj62BFQ+7C9i+VKkxOcv2u6Vg9pg2ZcG0X04hzJ/ERf0OaLC+VMdl6m4WdxktdbBa6lffouw0N4+JUrKbJVblK3WuiDkpJQE3iByHznrJnPYYnnxnIo+M87Kcb1xXL6vYJ1VYMK0Sx6HAMzSUF8v4KDmvqXolEsmrBTrsn6AOBZ13GJtxCrIzQ++2Ua2dLGfBw/2/EroCUD0RhM17TQO0jzcZ+yKCSLtEyODVAClx+cEBnrY80kAxOSmjLC6B8TK9Azm5RL8iZ3EQ73wB4JMsrqU37ac0GwJQo54GHnpEUo5Wh7c9sdyX32WsewVpncYaR70B0PgPvHu2PQEp/NLD31UQrOAHC3OM4ceTw5bUw1B2HyC8WhqvEVVcXWop14/X9o7oYhlQsyWA8caX+/X0HAY1w2+5VPOob9IrMo6aK5YU12ot+ikVVA0fi1eTzSkyTfFf4Yl6EssNPbTZnh5Vysw99SOCka3/2PHdaA7DzDbJ550XKierr8iLVo7CmMovLSmhunxGJqYSDQyUz26qeJg8jJRmoME7jpbWG8CgSk6H3kBNTNxq07qqcEZ+kCiuRyQLiJhWmQyY0WQA9Mk4FKalzKPD03NFC6fgRjlO83FGOqzIXthTkl3Y/FJtKxbQZeAdh+oag5qDpUdi9VZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(261026121527099003)(10067099003)(11063799006)(261026140227099003)(56012099006)(261021123027099003)(261022105027099003)(261022075727099003)(261102123227099003)(261009223027099003)(261021121427099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZDdXBhNmhITTZsWmt1VVlobys2cVZyS01VVUlzUW01eVRaaVJjRlZSUnRH?=
 =?utf-8?B?akZNak1YN1J0MXNzN21BQ3Z3Z0lPbGRHeUlwUm5HZ0tScldVUmNjenlBVHhz?=
 =?utf-8?B?aEEzWWlOSi9EYUMvK3VRNGNPRW4waUdaVGlLYzhWT1JiR1Vtczg1L2FOVG1G?=
 =?utf-8?B?eFFVdmpyY2pJM3RwMStwM2RVby9qQUxnamV2T2EwdG9Zbmlwd1FiTnJPeVll?=
 =?utf-8?B?R013b0dkYnJGWkhwVDZ6STkvR0swWGdNNU1aV2FjSEh3WlNRQUhtcytxdjRF?=
 =?utf-8?B?VU1YVHdIdzBySU04NThsVHJjM1FTeUZGWm54ZXlXTGpVUUJabHFDWnl2cjVD?=
 =?utf-8?B?MFJubURZS3RhbUVmcGp5UEg3RjRmWFFWVVNrejlaVXFtNGJrUG5uTWpYSEE1?=
 =?utf-8?B?UDVoRXhwNmk3OUltSjZvTFNQV2Q4T0xCdEVxRUpKdVM5VUt5VWVBaVFOa2dV?=
 =?utf-8?B?U2tqcndyMTU0Z2xSWUNjcG5GUWl3S3M5d0x2UmsyWTNYQkZCUFJZZlM0UHY4?=
 =?utf-8?B?aHFxTjRYMkgvMGplZXBZVnJtYXhKSXFJcExFVWxlRzhLL0lOTndXV0d3RGpU?=
 =?utf-8?B?Vkw3VjBCZ2NuODZ0d2VmUTh4Nm1ERlZ5aGhWKzRDMExXSWpkUjBNc3ZUWm94?=
 =?utf-8?B?VElnMFc0UmszWkJCWFQwM2JUNVlXYWt6NzhVQzB3ODJGRzBhMWl2QVJMTkRa?=
 =?utf-8?B?TjRRNUNPTXJyYmo3RnlYZ0RMdnRHSjUxOW11d1FLa3FUK3hsaFVZUkdLZ2JY?=
 =?utf-8?B?RU1uN0RlcWZUdXhHaWptaTNZWW1TeTlqVVdobjVCSjg2VzNuei9UQXVJenBa?=
 =?utf-8?B?Ymg4NE5ySkZObk1FNHFLSVJMZWxHaFNHbDdLTmxUQTFVVXl0MStMVC9FWmYv?=
 =?utf-8?B?KzVXcjNoUGJsbHNHb3VySDhCa3JJVGpvbzAvS2VZZERxbk9SaU4xbXA4SGN5?=
 =?utf-8?B?WUwvUmhMY3lGUVlDeStuR1RSSEM1QktMVnVoYllhQTNiaEkyVjdyb0dUTVZx?=
 =?utf-8?B?Qy9tcVdieGxXcFd6YURHVVJ3WmYwK2t0U3JaMmZ0bTRwVEc5MXFMa2RhNXY4?=
 =?utf-8?B?Y3ZrYU40Q1Rlam5ROTNTaE5kemtDamZhNzh3NGxOTmZCSytqRU1PK0JsMzZp?=
 =?utf-8?B?dHdHdVAveTV5QklLT2FsYnVva2NqN2xSTVJ2SGg1TmZuT0UveWZrWDhwd2RK?=
 =?utf-8?B?U3gwZE1JTCtLZkVVSTBjaUVsZnhpZHRLekV4b2ZDN1RCUFlBK21TQll0cmY5?=
 =?utf-8?B?VllVYStML2tXOUJKYWFrTWZENTgyUDcrQW5hUDdJcUUwSkV5a1MrTFpXczFZ?=
 =?utf-8?B?cHh6RDFXV3FJOHZ5b0lKckhSUnpYaG8vMGlyM1IwNFh5WDZhRXR5R2VFMTI5?=
 =?utf-8?B?Mnh5Y1lYOGpnd1YrZXNNZlBmZ3dFRnJMNm1xNkJ6cHloZE9Yb1VSTE4yakV0?=
 =?utf-8?B?cnVxNEpodlJyc3gwSDluYkRaL1cxV1krQWdQMFI5cW5OdlFHMEV2d1FBa2hu?=
 =?utf-8?B?dlhVcVZ5bVBlZzhsWC9LQW94Qm1TRUJKT0IxNThwNjFwMk9lSnB6bmpDazR3?=
 =?utf-8?B?SEtoMHV5WHlLbnpOQ0NlWCtFdXFWSDRZZFVSb0VLUVlneVlyUVI4RmtiRGlM?=
 =?utf-8?B?RDdqR0pzTld1NWRWWnNGYkowYVBlTVJDYk5TRGhkYzA5UzZsUm9OWCsyMWtw?=
 =?utf-8?B?bkZaRVNQRHBXR2srNmtOWkdjcWhNVWs2aHMrdTNwMlVpREVUeElSREI5cGZT?=
 =?utf-8?B?RTRUNldYaW80SWwydXJpTEtYSnZ2T2tPbDl3MXFNQXlPeEg1ZlAwaXNUL0Yz?=
 =?utf-8?B?R2lHQVJZdmwvZHZXOVdSSE0vL2RBRVpBL0lWUFM2Ymk1V09XbmFRbTF1WEdn?=
 =?utf-8?B?THAzWXh1TG14SjRwbCtQVnQ1Q3J3WGphTkZ6b1cwaHYvNDMweGtMaE84aWRp?=
 =?utf-8?B?eVNVczRVZnBJeDJMRjBaWFcwQVJuTjF4bVI3Z3R6WVFFOVh3M1VWcUxHVGpj?=
 =?utf-8?B?TEEyVnBmeTByZU9aU204bUVLSCtkcDFvMWgzL2ljSk9sMnNieXB0OGtNNUxl?=
 =?utf-8?B?cHdlSzFFSTR5VFhrT2lpbituZUFuR04yK3NGUy9TenJYb0pSSHo1end4a2FZ?=
 =?utf-8?B?bm83QURJR3FiMjhsbGlCQkUvSnE1U3dsa3M4eTNYbnJPWUZTSzhVQ1RPSm5T?=
 =?utf-8?B?NWRCVEtqclVJc2tpQWZiUm5GZWtDdWk0bjhjcGM0MlFCUklma0pEd2drVnFM?=
 =?utf-8?B?b1Qwdnd6elgzcHg2a1FWbXZFenBVdGFXWVlyL3R1VWZQUW9wZWM1T2cvUGh2?=
 =?utf-8?B?TWVOY1IrOHpkU2Yvei9Zcng2YURIWk4yb3RTbXNsOGRmK1FFQW16R25JNnBk?=
 =?utf-8?Q?M0vb2F7UHhfbSZ+asFcH2d6/4bitTtdcuYSllL764jfY1?=
X-MS-Exchange-AntiSpam-MessageData-1: MOKDzjf3An7+0A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b30ca07-0b42-4922-aab2-08df4c8f5449
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 14:04:18.9185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+e1mLeyVbIcd/+4i+ymw8G7wH4XQmIdh/ps3D7zdzYywPmfqEWyZXy7JTzJm2xP86BBYwunbwY+T4m4k3JqcQ==
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
its reply to the GSP_INIT command that ends the boot, so the boot
sequence holds the configuration when it returns.

Nova-core fetches the configuration with an RPC command after the boot,
once the interrupt handler is registered. On r000, the boot sequence
would have to keep the GSP_INIT reply for that later step to read.

Return the configuration from the boot sequence, together with the
unload bundle, and send the RPC command at the end of the boot sequence
instead.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/api.rs      |  2 +-
 drivers/gpu/nova-core/gpu.rs      | 36 +++++++++++++++++++-----------------
 drivers/gpu/nova-core/gsp.rs      | 13 ++++++++-----
 drivers/gpu/nova-core/gsp/boot.rs | 15 +++++++++++----
 4 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
index f800ba6c4183..a665eabc44c2 100644
--- a/drivers/gpu/nova-core/api.rs
+++ b/drivers/gpu/nova-core/api.rs
@@ -41,7 +41,7 @@ pub fn of(adev: &auxiliary::Device<Bound>) -> Result<NovaCoreApiHandle<'_>> {
 
     /// Returns the GPU [`GspStaticInfo`].
     pub fn gsp_static_info(&self) -> &GspStaticInfo {
-        &self.gpu.gsp_static_info
+        self.gpu.gsp_static_info()
     }
 
     /// Returns the GPU [`Spec`].
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 590d81f4e479..e4db5ce47316 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -32,7 +32,6 @@
     gsp::{
         self,
         cmdq::Cmdq,
-        commands::GspStaticInfo,
         Gsp,
         GspBootContext, //
     },
@@ -341,8 +340,8 @@ struct GspResources<'gpu> {
     /// GSP runtime data.
     #[pin]
     gsp: Gsp<'gpu>,
-    /// GSP unload firmware bundle, if any.
-    unload_bundle: Option<gsp::UnloadBundle<'gpu>>,
+    /// The static GPU configuration and the unload bundle that the boot sequence returned.
+    boot_result: gsp::BootResult<'gpu>,
 }
 
 /// The GSP event handler's registration and the enable of its subtree at `TOP`.
@@ -393,8 +392,6 @@ pub(crate) struct Gpu<'gpu> {
     #[pin]
     #[uses('tree)]
     _gsp_subtree: GspSubtree<'gsp_resources>,
-    /// Static GPU information as provided by the GSP.
-    pub(crate) gsp_static_info: GspStaticInfo,
     /// GPU memory manager owning memory management resources.
     ///
     /// Must be kept declared *before* `gsp_resources`, so that its components are dropped while
@@ -425,7 +422,7 @@ fn drop(self: Pin<&mut Self>) {
         let this = self.project();
         let device = *this.device;
         let bar = *this.bar;
-        let bundle = this.unload_bundle.take();
+        let bundle = this.boot_result.unload_bundle.take();
 
         let _ = this
             .gsp
@@ -505,7 +502,7 @@ pub(crate) fn new<'a>(
                 // This member must be initialized last, so the `UnloadBundle` can never be dropped
                 // from outside of the constructed `GspResources`, ensuring that the unload sequence
                 // is properly run in case of failure.
-                unload_bundle: gsp.boot(GspBootContext {
+                boot_result: gsp.boot(GspBootContext {
                     pdev,
                     bar,
                     chipset: spec.chipset,
@@ -537,9 +534,9 @@ pub(crate) fn new<'a>(
                 gsp_resources.gsp.cmdq.drain()?;
             },
 
-            gsp_static_info: {
+            _: {
                 // Obtain and display basic GPU information.
-                let info = gsp_resources.gsp.get_static_info()?;
+                let info = &gsp_resources.boot_result.static_info;
                 match info.gpu_name() {
                     Ok(name) => dev_info!(dev, "GPU name: {}\n", name),
                     Err(e) => dev_warn!(dev, "GPU name unavailable: {:?}\n", e),
@@ -557,13 +554,12 @@ pub(crate) fn new<'a>(
                         info.vram_size() / u64::SZ_1M
                     );
                 }
-
-                info
             },
 
             // Create GPU memory manager owning memory management resources.
             mm: {
-                let usable_vram = gsp_static_info.usable_fb_regions.first().ok_or(ENODEV)?;
+                let info = &gsp_resources.boot_result.static_info;
+                let usable_vram = info.usable_fb_regions.first().ok_or(ENODEV)?;
                 let buddy_params = GpuBuddyParams {
                     base_offset: usable_vram.start,
                     size: usable_vram.end - usable_vram.start,
@@ -574,13 +570,14 @@ pub(crate) fn new<'a>(
                     bar,
                     gsp_resources.spec.chipset,
                     buddy_params,
-                    VramAddress::from_raw(gsp_static_info.total_fb_end),
+                    VramAddress::from_raw(info.total_fb_end),
                 )?
             },
 
             // Create BAR1 user interface for CPU access to GPU virtual memory.
             bar_user <- {
-                let pdb_addr = VramAddress::from_raw(gsp_static_info.bar1_pde_base);
+                let info = &gsp_resources.boot_result.static_info;
+                let pdb_addr = VramAddress::from_raw(info.bar1_pde_base);
                 let bar1_idx = crate::driver::bar1_resource_index(pdev)?;
                 let bar1_size = pdev.resource_len(bar1_idx)?;
 
@@ -594,6 +591,11 @@ pub(crate) fn new<'a>(
         })
     }
 
+    /// Returns the static GPU configuration that GSP-RM reported at boot.
+    pub(crate) fn gsp_static_info(&self) -> &gsp::commands::GspStaticInfo {
+        &self.gsp_resources.boot_result.static_info
+    }
+
     /// Waits for GFW, the GPU's boot firmware, to report completion.
     ///
     /// The driver must not program the GPU before then.
@@ -616,14 +618,14 @@ pub(crate) fn wait_gfw_boot_completion(
     pub(crate) fn run_selftests(self: Pin<&mut Self>, pdev: &pci::Device<device::Bound>) {
         let this = self.project();
         let dev = pdev.as_ref();
-        let regions = &this.gsp_static_info.usable_fb_regions;
+        let info = &this.gsp_resources.boot_result.static_info;
 
         if let Err(err) = crate::mm::selftest::run(
             dev,
             this.mm,
-            regions,
+            &info.usable_fb_regions,
             &this.bar_user,
-            this.gsp_static_info.bar1_pde_base,
+            info.bar1_pde_base,
             this.spec.chipset,
         ) {
             dev_err!(dev, "self-tests failed: {:?}\n", err);
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 398d6525b133..bf0028e52e3c 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -157,12 +157,15 @@ pub(crate) fn new(
             }))
         })
     }
-
-    /// Query the GSP for the static GPU information.
-    pub(crate) fn get_static_info(&self) -> Result<commands::GspStaticInfo> {
-        self.cmdq.send_rpc_command(commands::rpc::GetGspStaticInfo)
-    }
 }
 
 /// Opaque bundle required to unload the GSP. Created by [`Gsp::boot`], consumed by [`Gsp::unload`].
 pub(crate) struct UnloadBundle<'a>(KBox<dyn hal::UnloadBundle + 'a>);
+
+/// The output of [`Gsp::boot`]: the static GPU configuration and the unload bundle.
+pub(crate) struct BootResult<'a> {
+    /// The unload bundle for [`Gsp::unload`], if one could be built.
+    pub(crate) unload_bundle: Option<UnloadBundle<'a>>,
+    /// The static GPU configuration as reported by GSP-RM.
+    pub(crate) static_info: commands::GspStaticInfo,
+}
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 9d5da5b165ac..a45f2b21a2ab 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -27,12 +27,12 @@ impl<'gsp> super::Gsp<'gsp> {
     /// user-space, patching them with signatures, and building firmware-specific intricate data
     /// structures that the GSP will use at runtime.
     ///
-    /// Upon return, the GSP is up and running, and its unload bundle (to be given as argument to
-    /// [`Self::unload`]) returned.
+    /// Returns, with the GSP running, the static configuration that GSP-RM reported and the
+    /// unload bundle for [`Self::unload`].
     pub(crate) fn boot(
         self: Pin<&mut Self>,
         mut ctx: super::GspBootContext<'_, 'gsp>,
-    ) -> Result<Option<super::UnloadBundle<'gsp>>> {
+    ) -> Result<super::BootResult<'gsp>> {
         let pdev = ctx.pdev;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
@@ -84,7 +84,14 @@ pub(crate) fn boot(
         // Wait until GSP is fully initialized.
         commands::rpc::wait_gsp_init_done(&self.cmdq)?;
 
-        Ok(unload_guard.dismiss().1)
+        let static_info = self
+            .cmdq
+            .send_rpc_command(commands::rpc::GetGspStaticInfo)?;
+
+        Ok(super::BootResult {
+            unload_bundle: unload_guard.dismiss().1,
+            static_info,
+        })
     }
 
     /// Shut down the GSP and wait until it is offline.

-- 
2.56.1

