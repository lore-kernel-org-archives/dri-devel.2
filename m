Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06C8FCD0CD
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:06:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3B710E6FF;
	Wed, 18 Mar 2026 08:06:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XkZVwuwL";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE4810E6ED
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvYcFDph34v65rpCSPRlgCxlmwgWkTM2ziu2hp2/Cj+HhT7y3+vbFZgE8TZ//FLZ8NmDxc9NFLix4KaxjhPtZDDDDCBn84iu1l1XalEMo1iMIXU4nnU+GTqFtXRSlXegAjIiirBbp7PA6SEzss+ZhXb0uMlqvcsOMkweZ9gUUNqO2S4WpInwj/ruTmVQT4BN/6URuib7/jqssorjZ4tcWxAB5XAxn/ojZ4kDs3NvJOy79Hx/zR/Pypr9QjAk5K3CP5g40459kEW2J2BuAa6Q2JJY9i6958KrBQmHWUxCEYd9SvsfWmiUGbsaJ6Bwbrd4f0sRn8YAeKFtNe1hTa6Ncg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yTvPr6hrFzORVSJU4SHR2RZHJoAd4fqNQitYFNzjEH0=;
 b=w5JVP8EoPHUlFUWEWyFGnLGp7XfL07AtZdrKSJAubROyKPv30Fy2XoV0CTw+T+xvTQ5c12QtPDFMObbmYx9N3dlEA0r5vpVYAajeZS75R2Z6f7SqxPbwko6PCROGnsgiBnamz1QmyiY2SItbzdTQMvzp1ADW3ZhvxlpXepDgna7cFqmUjpP2p1uyQjk6OrQanSP2EDxQdfYGbDNyhaTc2vtlm4AMFFWvhiIAVgGBwllakGaismwwx6kdOju/BwVdm6sA0Ir09Ty2ofRJ4rspzcVLUyEP1mBh3g7klQY4EqR7OWAl08CgSGUbdbk+OD260b8FCGTjQ/mHTYm+p3F6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yTvPr6hrFzORVSJU4SHR2RZHJoAd4fqNQitYFNzjEH0=;
 b=XkZVwuwLwZklIu3HBKYW0KvnU3QTQRd8k3+EFIRlLbHReZime3ACOKL/Zm6SV6ZwksptQafcKHWZeNoSxGY0Kk/CZ9SCtuIOEhGIPMIUR5hnPLQnfIFDGBa3lLhTAcdlvQcrNRNdtayj/RoHrn3ZSBgKYcjpUCVinSORmq/UdYyrRyIQRyaXJAJAEeXFrWUgBG2GhUw3J+uf9H2URqpyAw8skiRoC0QarhR3PFt3YXFgkoyQH7FHxWFDH8kPb7EuvZP1OX4tBmCF+wDiSVv70ksdqYo0coln/cwadQN0UKNyb0Ssn48jBf+bLsUkV4enCDlIBOK/cOtM8VyWZrRaHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 08:06:29 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 08:06:28 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 18 Mar 2026 17:06:03 +0900
Subject: [PATCH 5/8] gpu: nova-core: convert FUSE registers to kernel
 register macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260318-b4-nova-register-v1-5-22a358aa4c63@nvidia.com>
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
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
X-ClientProxiedBy: TYWP286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::6) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eba0057-d01d-4487-0355-08de84c54216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|366016|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OqRCdJI4qjxxbwmQM2bCSdg2OE8RbKuuX4bZ9m3OYyjb4dyBaictzi7Y+FiZCXyaSVheD9iKhbCaNBDG6oTWqVruTUO3SKNq2SIlgjnlH+HjA7drFcx5m/r7/yvFYjIT1YAz9keSX8DT0Qjr1EPwGAMV4YcpwNHWF2V1BFfm0eCFu9hJdAn3WbssLUUofOFkJoNRKKlHv4LBxQ4HFuUmAOYVo60Dq95k6TatSuZpurSnkI1QLmQiOkE0zJsBa9hOjWm+TQebbXiaeciYplu7Cxo0WKg+ui/7pyjlTNwY0wuFVKfCB/3IJviS6w/pyu+w/pMEjBzDO9BkwatmsWdFbcc2WHmProLIXLBnUCS3GckoJ1wqJUZ8Dj6x0Q2IK+fd7DRDZEhaU8OxIPmlMZLqPgBuQIad+y/XixygsR8Xd89bcYOKmtOfWEN2vvJMug6/LxI/wybhwwzvP5iFWolXgWYyDCqCupVJiKkQLyD71lKLUlRTmRiD/PxwrX9G0yz6EutJI9hn/AbBft7w7b0yWn8Yjzlxwak3Ax+XmG+QCdxjYfpD+77dH268HCpazXJlu7snCI2AAnuZTLFEhmSaGEoU5hRl4RKDSGM4DPXCBBtCpPEGoKvz2URZuvktE2lm4TSbIGOno8IOQyYC9pb/MOodOWpn/UCAubGNQLOBGcGjSNWswYxmDFoxaFH6uJHORFEGyeWhi65C/c2L1Dw52PU+paN5f9Pd8E6Xomi7wr47qAnDcTHpz/5w6cwyYFed6TtDRJvLjKrKmuExz8gw8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(366016)(921020)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzdGMGZ4MWNWcFl1V0QvOGxWS0VldFJEd2VvSHBZblU5dUdRQ3RYV3lERFUz?=
 =?utf-8?B?WTd0OG5vdWxOc0FqZUZSUDkxdVZNZ0hZOVlqT0FWMTJoVDdmYjIvOG8xME9B?=
 =?utf-8?B?UzJDL0U5UmZ5d1dLakt2RGJpYVBkS0xlcDB0UGxQYlViTjdvTHJMM3RUeERp?=
 =?utf-8?B?ZlV3VDFpSmdnWGlvc21yNDI3VDNwdkd3Njk3eURIUFcrSmhWT2FDQWtsV29v?=
 =?utf-8?B?azVNOXFidTY1Kzdrb2NTZnVvU3VXd002MU1DNldzWi84WnlyQXh3TGtjTHRN?=
 =?utf-8?B?UDJlV2dKYys1TXo1VXluR1dkbVVGNmc4Yy9Kd3lZUjE2dWxUbnJodEpSSDE4?=
 =?utf-8?B?SWtIVG9PbSs1R2hGb1k4OUk5T1Y0KzRGbFJwKzMxMnhWaEczZlMxaGYyemlJ?=
 =?utf-8?B?Y2ZWRjI5eDd1cm5HOEt5dU5KZEVGaEttYUp0OWVocFNnZXhKbWovK0twL0tB?=
 =?utf-8?B?SFJUUlNIOWJleWovVjBZaEttMi8rQ1ljbUYwMjA5LytMMHFESVRHMWpCTnZr?=
 =?utf-8?B?RDY2Y3Q0L2FrNHlDNzVROHk0dFJIOU9JamY2eENadlkyWjJvYzhxS0JnRmgy?=
 =?utf-8?B?SGZkQyswR2pOOHk0eCtpVjk5eXFwTFltWi9wTVB1ZWJYRHRHWElmbURjZktS?=
 =?utf-8?B?WEs4SWVUemdzVjdldVBaMnc1TEUyVFRKQk9YWkJjUk1wQyswQVFQK0tJNzgz?=
 =?utf-8?B?akJNb2RYR3lFNDFXdGI2b1RNMXMvd0oxVVNucVNjU0hrU1JEYzQzdVR5OTNV?=
 =?utf-8?B?amZuTzJpaFdZUDE1YXVrS0RGYWlnUlNKTk1FR3BsNVNselVabVpUOUZiY2FP?=
 =?utf-8?B?T2I5ZUY0dkpsL3R1U0l0K2U2R21NM3U4VUM1RlZYR1lzL3ByOU9pemJCckh2?=
 =?utf-8?B?bFhtY0pqc3FwbUFmUUN4V0dKdE12bTg0dmE5ajV4Qzg0SUxTMHdzc05TTUc2?=
 =?utf-8?B?SjU3YXplVml5TkpIbm40VFBqakp5RE1IZzBpZDM2TlYzbkc2RzY1NGtyU3lt?=
 =?utf-8?B?cmZsVU9pVWVEYUszeGdnS2lFNVZLamppWTNHYktCeTQ3RGIvdmJRZ3JJRU82?=
 =?utf-8?B?RjZNclZxcjlaZU15UitmRXJxRnNpYlNJTEhHOWhhZTZEeVRsYUxLb3g5RW9L?=
 =?utf-8?B?M1YyZ0dyTEh6ZW85RVY1aVFtRzQwZmcvZ28xVXpJZnp3TURZSUh3MjFrenlQ?=
 =?utf-8?B?T3F0Wk13S01UMlJpSWNzT2FhYyttblNsMXRFM0tHM3NSMFFHdG5XSWd6Qk9r?=
 =?utf-8?B?QURGVEhEbXZXR3pGU1JLNkE1WFRIZzdEUXJHK1lqeG44TlBLaEc2Z2hPWk0y?=
 =?utf-8?B?NzVmdVE5ZGp0K2I5L1JsZVEyN3JjQXAra1kvb1VJNVRTV3RyWEV6a0hjbW1o?=
 =?utf-8?B?RkVXc1dCcHl0cER6UjdBNzBLeEQvWTNMbis4TzJXbTRtNmNLVDNBb1pWb29K?=
 =?utf-8?B?TlZta0UxeCtLeVR5dStwMmE3VTlyWXpHVWpReXlVL1BQRVBaWDl0d0FaN3ZS?=
 =?utf-8?B?LzB3dHVvY3k2SXB0ZEprazhFZHpwMFdOcDRja29YTnZzakJlY0Npa2FqQU1R?=
 =?utf-8?B?cGVOcDNKdTExU1RrUTlJZDVBWWJQUzFCZnUza0RyVG8vUmpDRUVmbnZqMVIy?=
 =?utf-8?B?TXVCVzRCdkJ2YWtCZUIyaGdCN0prMjV2ZjRWT3hmWWRFV2lETCtvTmExZEtw?=
 =?utf-8?B?cUVPWWJOWTc2QlFNenNEbnd5dUx4RDNNYmt2VTJSUXJBbEFjWktmalhDSU9N?=
 =?utf-8?B?c3NjZGJRZkVZMUFXM1A4UkZ0RCtEdTNGSzQrdzIyY2l4K2dLNGxQelNHd1BM?=
 =?utf-8?B?WXpaT1dROXR6clZIa0M1blA1am1PMWpLVmdmUitDQWRLbjNyaE0wRjd5MDc2?=
 =?utf-8?B?UnJHczUwZ05EVTMvV0Z1Sy9BVS9tQzZ3TFp1K3JBY2F5Y3BYNmprWHB4OXpl?=
 =?utf-8?B?UXl2eFk1c1pXaGQ2VHdIRG42djBQZzg5Rk4xc0xTaE41N1NRUU1wd2Jhejl5?=
 =?utf-8?B?THpBZzlQWGRmNjBrZ2R4RUd1L29OYXhmeUxpN0MxKysraGhPQ1Z2ZU00T3Qw?=
 =?utf-8?B?SS9WZDdXQ2lTRWk1aDlwNzhybHAyd1NRcFZRQmNmMzE1R3BBVDNPU0s2Vncx?=
 =?utf-8?B?bC9KUlEwY2dJWmlzTVB3UkFhQ3IzWW5CYUlvOUNBSUJWVWJ2WnpORjJsYWJh?=
 =?utf-8?B?ZkhYb3JjcVdud2dlb05aTndTTnF0S1NhMzI1RTZZWmlaNDBteFp5bzNHTGc3?=
 =?utf-8?B?NzRtQlNNMHMyeE9ib2RDbUVINldoODJ6b2Fpck1OV0Rmb3M0TjZnNmNrbjYx?=
 =?utf-8?B?dkozWXUzNCs2UlpCQmRRNk4vbFpRRFVCY3BRT2FUSnA4STVZMU5vcVNSb085?=
 =?utf-8?Q?4nTL45OuopVRbIsARFrpYQqxK1TZPZPBNxKb5ZS9+BS2f?=
X-MS-Exchange-AntiSpam-MessageData-1: GhyP2/yJsZOCzg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eba0057-d01d-4487-0355-08de84c54216
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 08:06:28.8742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmO5Xj/YJlYwMoJY8dxWWRC+Gvulksaou9n/UPtAbAt1Q0qoFSyTRpd48WNLgzjgMPEi+RU1ubFEMYXYiEqBmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197
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

Convert all FUSE registers to use the kernel's register macro and update
the code accordingly.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/falcon/hal/ga102.rs | 20 +++++++++++------
 drivers/gpu/nova-core/fb/hal/ga100.rs     |  3 ++-
 drivers/gpu/nova-core/fb/hal/tu102.rs     |  3 ++-
 drivers/gpu/nova-core/regs.rs             | 36 ++++++++++++++++++-------------
 4 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index 8f62df10da0a..e3eb6189819f 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -4,7 +4,11 @@
 
 use kernel::{
     device,
-    io::poll::read_poll_timeout,
+    io::{
+        poll::read_poll_timeout,
+        register::Array,
+        Io, //
+    },
     prelude::*,
     time::Delta, //
 };
@@ -60,16 +64,20 @@ fn signature_reg_fuse_version_ga102(
 
     // `ucode_idx` is guaranteed to be in the range [0..15], making the `read` calls provable valid
     // at build-time.
-    let reg_fuse_version = if engine_id_mask & 0x0001 != 0 {
-        regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::read(bar, ucode_idx).data()
+    let reg_fuse_version: u16 = if engine_id_mask & 0x0001 != 0 {
+        bar.read(regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::at(ucode_idx))
+            .data()
     } else if engine_id_mask & 0x0004 != 0 {
-        regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::read(bar, ucode_idx).data()
+        bar.read(regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::at(ucode_idx))
+            .data()
     } else if engine_id_mask & 0x0400 != 0 {
-        regs::NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION::read(bar, ucode_idx).data()
+        bar.read(regs::NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION::at(ucode_idx))
+            .data()
     } else {
         dev_err!(dev, "unexpected engine_id_mask {:#x}\n", engine_id_mask);
         return Err(EINVAL);
-    };
+    }
+    .into();
 
     // TODO[NUMM]: replace with `last_set_bit` once it lands.
     Ok(u16::BITS - reg_fuse_version.leading_zeros())
diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index 629588c75778..1c03783cddef 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -40,7 +40,8 @@ pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0, addr: u64) {
 }
 
 pub(super) fn display_enabled_ga100(bar: &Bar0) -> bool {
-    !regs::ga100::NV_FUSE_STATUS_OPT_DISPLAY::read(bar).display_disabled()
+    !bar.read(regs::ga100::NV_FUSE_STATUS_OPT_DISPLAY)
+        .display_disabled()
 }
 
 /// Shift applied to the sysmem address before it is written into
diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-core/fb/hal/tu102.rs
index 515d50872224..281bb796e198 100644
--- a/drivers/gpu/nova-core/fb/hal/tu102.rs
+++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
@@ -29,7 +29,8 @@ pub(super) fn write_sysmem_flush_page_gm107(bar: &Bar0, addr: u64) -> Result {
 }
 
 pub(super) fn display_enabled_gm107(bar: &Bar0) -> bool {
-    !regs::gm107::NV_FUSE_STATUS_OPT_DISPLAY::read(bar).display_disabled()
+    !bar.read(regs::gm107::NV_FUSE_STATUS_OPT_DISPLAY)
+        .display_disabled()
 }
 
 pub(super) fn vidmem_size_gp102(bar: &Bar0) -> u64 {
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 4439464aae4d..9682a94b8b77 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -294,17 +294,19 @@ pub(crate) fn vga_workspace_addr(self) -> Option<u64> {
 
 pub(crate) const NV_FUSE_OPT_FPF_SIZE: usize = 16;
 
-register!(NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION @ 0x00824100[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
-});
+nv_reg! {
+    NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION[NV_FUSE_OPT_FPF_SIZE] @ 0x00824100 {
+        15:0    data;
+    }
 
-register!(NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION @ 0x00824140[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
-});
+    NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION[NV_FUSE_OPT_FPF_SIZE] @ 0x00824140 {
+        15:0    data;
+    }
 
-register!(NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION @ 0x008241c0[NV_FUSE_OPT_FPF_SIZE] {
-    15:0    data as u16;
-});
+    NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION[NV_FUSE_OPT_FPF_SIZE] @ 0x008241c0 {
+        15:0    data;
+    }
+}
 
 // PFALCON
 
@@ -517,15 +519,19 @@ pub(crate) fn reset_engine<E: FalconEngine>(bar: &Bar0) {
 pub(crate) mod gm107 {
     // FUSE
 
-    register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00021c04 {
-        0:0     display_disabled as bool;
-    });
+    nv_reg! {
+        NV_FUSE_STATUS_OPT_DISPLAY @ 0x00021c04 {
+            0:0     display_disabled => bool;
+        }
+    }
 }
 
 pub(crate) mod ga100 {
     // FUSE
 
-    register!(NV_FUSE_STATUS_OPT_DISPLAY @ 0x00820c04 {
-        0:0     display_disabled as bool;
-    });
+    nv_reg! {
+        NV_FUSE_STATUS_OPT_DISPLAY @ 0x00820c04 {
+            0:0     display_disabled => bool;
+        }
+    }
 }

-- 
2.53.0

