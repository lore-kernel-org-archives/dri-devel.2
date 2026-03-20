Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2432108B912
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 12:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FA7D10E237;
	Fri, 20 Mar 2026 12:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mnjQ/Mnm";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA5010E113
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 12:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MCj2zg6Zcq4klyh31PHU0IHUnrcyFgyLc9KFJPs+zuF9M6zgQp3iX78TnMQ1kCVpfS3DJzWl/L8ch4334D4cA+gkOFmkwolOk69pVRlIy/9PY8VvWhzVbx2m2l9oqg2Ky7dwOKweVg3infwVqOPj2mVo6jKk1Q2bLmdw4JQb3jflqHlv7sMlzyLwnD/jJ46Lrt9m/gofMtNOxk1uo8bzZnj5Sf4VqsjlweDWIOlDQx4kSdEFGN3nhbLeId8Fazv7MdxaHXzbGFwTUyir2zirXmV7y0JpUFQL2KrfXhvMxL/EKuD+HIB3f01+iKsdHe2688eat69nenwpRS8iL2oc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mogrstzJsIxK37yIQhsW9+jfD3Vj8h/kFoSdwuItJU=;
 b=C/Iyj0wbhBbaE45M/i1OW9tKZTjr6VgF/xjVB4Wqouv/34ALNo/jI45emdp9yR+bG9mGr/91gQtXndRZtk8bHyf/5xBfyyMmeLnPvmMs6pDg4WBE+2SL7g9ccZZJ6LrD79k+vPfXhu35n7Pj4PBZxQImMQytHMLIaI9w1+k6UbbQugAOBZ6Fjbj1oE0Goc/vfDfpMPJUd1gQfhSx+t15Yy3CADil4o9vCVtAE5NS8keoxcDn7uRo5ZiGToTW9er97AKy8psL97gHXwFPGUL2myllzU6QmZ6ZvZEnA4xG81wMcDqGhF5l0+GTWa5TkbYuNPo+PCfscB6qD/ZZEJB8ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mogrstzJsIxK37yIQhsW9+jfD3Vj8h/kFoSdwuItJU=;
 b=mnjQ/MnmnlJW0NY868zA7Sfi2Lxihn262djIxtWKI9U0KawV0oj0ZktT4ALTxzeuSHWHa6NwlV4aUlOXesZObvsRtkGXBg08woLJyI1eS9ickHkdv8gdcVzXaAmHxhB0yCafMm/g3NPSAncYcDzIka/SszBKSdfjt3Gv60TLMfCwGdOPBhNIKPz6hQSVjM9UhZdNcu7J4ZvEdtLQn/+ubSbKDA7dAuOZ/oa/CEogFm8QTlZ/6fjzkban1mOzp7Ttj7qnQeduIN1Fwlh7++GKtykPhH67p2Lfj2gT1vgP71zJlf/mmen1P07xS5YXO3zSVe/MwzCTj0a1P6DLeBN8aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 12:20:06 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 12:20:06 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 20 Mar 2026 21:19:51 +0900
Subject: [PATCH v2 02/10] gpu: nova-core: convert PBUS registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-nova-register-v2-2-88fcf103e8d4@nvidia.com>
References: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
In-Reply-To: <20260320-b4-nova-register-v2-0-88fcf103e8d4@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYCP286CA0261.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6fae1b-4ab5-445d-5688-08de867b0522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|7416014|366016|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: IN9d7tsxzHsKPLlt/jsfArgfDVs78foNSWsYo9wlNvTG/fpIqA5wWCKpaZisLWx3WCGNMB5b4XUTlgVLoB5R90TiHjD2eNeHE7Y0+/3cjmdiQGV7jV0zn1p6Mnyy7fpAtyp0nE98EoFNINDwFRMtekXN8zphk1e2cGmLM8TWvm7mv0oBopR0qJL/quJplVTV9qNN1Hr5VHRPeB2XCj4EcyhsdRpwsYXomFPEzkLzPwvPl0skk2AMyLxRRRP9EtOHDjp4tJl1o60Nsq+tq2vVvTFvf86j94WKNdpcRlKWm4zu+2cGB9MpvOgRzuyOfPmBIh9h7jozyRQvio6zLGp0u/G7o7njsPzEoBk/e6HMK3f9NNUhKTkkmizYO697KKDlmsZTug+AbjefOJPHLU7s84rq1O/26OgOlXOFyRhVGOjHusPtT27LIvIU82fr66q1ZIiwk9tPpKBhAjQSxpIbm66A9YH8YkZ87uI3OEycB8sgyU0xNwDyUIjSMwrP8hXqd0FSpe3+bLWctqWy2bXDT2RUXaHMi94EcVn7Ag1ACjo0mPAHG8MZpY6XDjYKBk/T7haLU8x7cKmrHi9Y74p24Jx11HdgikjN+kRBnQiFOugELX1HiYfLUcsq9VriF8OMAORNSo7cufRxxdru5CLYgmkTrofXyN/CUlsas5VdsYT2M4KOinPeSajnxLmdDZ8jUXV+Ks/32m939Emc5K1klPE/1uR+KHv5FH7S9xx+I7g/1vosyKaeBe3JgmVO6AQP2oGUSuCYkicwHM5blXeVsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFNPWTMwTmd0LzdyVm9YNDRESjRpUGIvVjJGeERJTUtmU0NTZ2hzdDNJdnV5?=
 =?utf-8?B?djhOejA1Z01JS05Ed0xYK1pubUZWazVCUHZvRmlrK3hVVjh2NW9ka1oxWWlT?=
 =?utf-8?B?eGZ6cTE3aWxlbUszdGw0aEJ0YTdoNXl4R002eWNJOTRYRGxSZ1hVaFpXd25D?=
 =?utf-8?B?Y0pPeDB5RjRGQjVuS1EwRzE4WjM2RjBwU2VwQTY5NXdQWHVTOUNtV3dqbmhY?=
 =?utf-8?B?dGFYTnlkeDZqVEtnYU5mdndhL2ZpM2htd2ZSN2xOdGpnbnFvZFpnY1h6c0xv?=
 =?utf-8?B?MkU1QjB5NFhKRE10cEJwRTFXR2krbEFVWXYySjFGaGFFRnBadVZ4Vm5kN1oy?=
 =?utf-8?B?VHZwemFvNVVXaGcvbGVaUzZvcnZ3Y25pMXZWc2xtUllJbE5hUnVrUmpzWEpR?=
 =?utf-8?B?WjBJYlZBWGVhMExtRXZ5MUZPZ0I4U0x3VEpwRUxGSUoxa1N1RUIrMmkweEdm?=
 =?utf-8?B?cldTazJZcXFhTGdjdDJYN082TDZIa05BSWVFcmo4a2lmeWFJODBRQjlCV1RE?=
 =?utf-8?B?eitJYUNsMU1UUGs5bDFGVFBweWE3OGN6K0VVTWJjdC95Zk5HSDQ4Ym4xNng1?=
 =?utf-8?B?VENKaEgyNmcrelVCemZrSWx5OThpcmg5RE5Jdzg3NWp6MmJSMnY3QmJubUZV?=
 =?utf-8?B?cFZpcnczRU0xNUpsZ0N0aDR1RnhpWEU3MXBEREVyQk1SWThZejBaTGNLbFFG?=
 =?utf-8?B?S2x4TjkvNU9rcXlwZ2JDOHNBaU5RWkVxVDdYTkRsbGN0cGNYSTNmakdJbXBV?=
 =?utf-8?B?ZmcrZ0QvRUhma0RyaUlkeXRaQUU4VHJIRUVRb2o5bkdqejlyVTNQb1FHOXFM?=
 =?utf-8?B?MFpjZFZDdEdXU09idVgrZzllZmhHemdFSWsrbnRkem9TRUdrRWV2TVlaMUw0?=
 =?utf-8?B?cGtvV0c0THlhcWgxWURnR3pUWU9ISVUydzNpVW5DalBzdGpTMlR6UVQraS91?=
 =?utf-8?B?R213Z0dZUkRteTl3bmxzSXRyM0hVQTBBaVBhdmUrWWRIVFFud3R0a2xqSGd4?=
 =?utf-8?B?Y2pycDl4K3FKK1Y2ZkJXUjJ2Tk53Rld4emIwaHJBZmFvcmZyZVd3NUJKMWVh?=
 =?utf-8?B?c0FkcVp5K0h5bC9uTE92eFdISzB6bWlqVWpkM1lmYUU0WmdSS2dndjhQM0pK?=
 =?utf-8?B?Wm5TTkh1cWpBbVdQc0Vkb3NjVzNoVnA1YUNoUGF2K1NWdnp5b0FEb0ZqUHo4?=
 =?utf-8?B?NHJDT2UzY1drTjhNUlQ3ekh4eFZINnBTVFNOb1lzV0JXNEhBYVBGeTBHUFFS?=
 =?utf-8?B?bUd2MDVUeFl2N1o3VGpYNUpzZXhyaUVPU0lSaGlrM2cxdndWTjJVRUo4T09N?=
 =?utf-8?B?K0tHM2RWTjNxZWpsRkFFa2pxMXJoTkRtZzFQRVo2aXlWMGFwWDNFbVFEUUp3?=
 =?utf-8?B?dU9SVHJuNXE5aGxyVkVORXg2Uk1oT3dZTS90V2NQd2tHRWI4Z01HUjFDVFVH?=
 =?utf-8?B?QUNhM3JzNzBQR1ZWV0pmbDhvOWVZZldxMmV2enFJTWx1RHJXVmpxRjI4SGhF?=
 =?utf-8?B?ZjBJc2tNK01xcVFQOEdqRng0dE9XMkllalZEcXd1VEFVWUM0SU9aa3AxN3Uw?=
 =?utf-8?B?RW1IOXFrU1Zqb0JYM2YwTHJubGVWTDdhYkFoRlE0bEpFU0hpcms0OTdIQytu?=
 =?utf-8?B?SVNUemNzYmNnaVJNSkV0TUdBWUZhb3I4S3RmRmcrVk1XaGxYSkdQRDZvR2Q0?=
 =?utf-8?B?UlIrd2UvTklyZC93bFU5L2dXZTZiMHhxVGEzYjdCSDExRHlIdjNoblBKbmlm?=
 =?utf-8?B?RHZjVEhqb1pGclVrcnNiNUJrUUNpQ2IyV09UaTNBMzkyRGNYNzVOVWY5WHVi?=
 =?utf-8?B?WnQ5MmpON0dCNDcrVStWNXBkUlo3aG9Vc2V6UEl3VWhaRXp2U1JhZURESnNZ?=
 =?utf-8?B?c08xdUNMYzhkZnZ4eVJYYnY2Rkt2UzZvaytNSVFlSFlvMEZ3OGhwcjVNWmRa?=
 =?utf-8?B?a2pPSHJnNHlnbXp1OXQ1TG56NXRwTTZIazJRb3pyOWhaaGhJOTRrcUkrTHZ0?=
 =?utf-8?B?VXhvaEU5K1RFVGFlVU8remErcWV6WXVrRFNtUjU1bDNsVEVGYjBtZjZXRWxB?=
 =?utf-8?B?UzZYUmpoUHdnNGJQTEpSWDFKbmRYQnBpZFEwRjlXRGJZbHV0YmpmbmFLMmdG?=
 =?utf-8?B?UTRYL1JHZmE3Q0xNb0pTSVUwLzh2ZVpJNTBwUG9JVmQ2eEFvU0h0SkxsQ3N4?=
 =?utf-8?B?aThzMFdNTTZocW4rbm5ta2p0T0tmWUVmVlBBQnNEelR6dExRR291RkVtY2NO?=
 =?utf-8?B?V3JoMmU4YlJ2c05CWEMwQkVDSkRyd3phK3Z6ZFZEMVd4ZU9iUjVvUHIzUzhK?=
 =?utf-8?B?WUZTRUhrUnlMVEowcjIvb0lhbzA4MHpYT2ZvbHJUZ0NlbHUza0l2VVRIbnNK?=
 =?utf-8?Q?q92pkJqYmOE5ggguSUosAr5uf7kPRZAYYmVL6fIGvgcCU?=
X-MS-Exchange-AntiSpam-MessageData-1: QEU6/LqJwGXE/w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6fae1b-4ab5-445d-5688-08de867b0522
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 12:20:05.9789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWx5BIS/ERxM47GV5+jakjP0vU/G+sz0xtdWjn08e+ppUjg5Dzp7Tn7u/TvXk0fJ+b5lmMNsHEdCNgCprb6qUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519
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

Convert all PBUS registers to use the kernel's register macro and update
the code accordingly.

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs |  5 ++++-
 drivers/gpu/nova-core/regs.rs     | 12 +++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 5e73bd769dcc..06b8313c1219 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -5,6 +5,7 @@
     dma::CoherentAllocation,
     dma_write,
     io::poll::read_poll_timeout,
+    io::Io,
     pci,
     prelude::*,
     time::Delta, //
@@ -87,7 +88,9 @@ fn run_fwsec_frts(
         }
 
         // SCRATCH_E contains the error code for FWSEC-FRTS.
-        let frts_status = regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR::read(bar).frts_err_code();
+        let frts_status = bar
+            .read(regs::NV_PBUS_SW_SCRATCH_0E_FRTS_ERR)
+            .frts_err_code();
         if frts_status != 0 {
             dev_err!(
                 dev,
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 58fb807605dd..533d912659ba 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -109,12 +109,14 @@ fn fmt(&self, f: &mut kernel::fmt::Formatter<'_>) -> kernel::fmt::Result {
 
 // PBUS
 
-register!(NV_PBUS_SW_SCRATCH @ 0x00001400[64]  {});
+io::register! {
+    pub(crate) NV_PBUS_SW_SCRATCH(u32)[64] @ 0x00001400 {}
 
-register!(NV_PBUS_SW_SCRATCH_0E_FRTS_ERR => NV_PBUS_SW_SCRATCH[0xe],
-    "scratch register 0xe used as FRTS firmware error code" {
-    31:16   frts_err_code as u16;
-});
+    /// Scratch register 0xe used as FRTS firmware error code.
+    pub(crate) NV_PBUS_SW_SCRATCH_0E_FRTS_ERR(u32) => NV_PBUS_SW_SCRATCH[0xe] {
+        31:16   frts_err_code;
+    }
+}
 
 // PFB
 

-- 
2.53.0

