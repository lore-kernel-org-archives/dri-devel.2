Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAA2C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B576D10EB78;
	Tue,  7 Jul 2026 07:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="jF9n7HcY";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010047.outbound.protection.outlook.com
 [40.93.198.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E10210E46E
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:22:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgCCT0sV+Pqy952l3mTxTi9nzZTu9/6YwB+ANK9uRDw3e+kn33CiyPaNdPIGY7zyud7nQFza9Du5ZgUGg6B5X6/LFr2qMxKmVqNC+gqg3e6CdplUJ0Q7ovUDq0RfKlz962gXfZnqXUJ3GKk89UE/gZM5Kx1k0CF3t2YxEW1Ui+qdc2YL2AIhDk1+N37w2Ytse4K4a3YE9fJDkK1dU71XDJ4wWEExCkiDOxhwsk/ljWBv6YGj1Txp0Xj/c+N7XUHUVVEg8QKmUOUL51vT7z9/rcImIF/xKBZFKE+idmAd7PNk40amr53W+AXIrgbJJiHCb5lDQntwpUZK0ceTPpwZOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duuEjgjBsOS6eRGHys2mAenzIkbL/1QLZFWDZ+ysZsQ=;
 b=LNhelKPHHn3gKJspvksh1x4wPvxslsrIs36OEvIN/LaIYJ1naoIWqBgdFptRfL6JIHHHT3Bh33qRA71px1FSUYa1GEU5SuIX4WW+PyCce+XfHR0MDCFWLSo04Fj4fPbNYyejn96BxU05GPZYBNZF3vuULsuMyjJ41lbgAZY+9spNzd8rUvjzMpKs5LWScQ6pGhwzdw7CBrfgozUEmj7rueiab9G324GDDaM3dpeiSNDgcfQaX4Mu449JJthwrRigpm4MtFmBHLJhZ2Bvcl+sQBWe9sFrMZJx5BG2h447tW/dZQRa7qKaJgp+kVzHkO51m1mU0jDYmW6g9oYbjgN1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duuEjgjBsOS6eRGHys2mAenzIkbL/1QLZFWDZ+ysZsQ=;
 b=jF9n7HcY8Gfu6SbTZ81p/6OEhez//9kLtwb83ujaEVPwo8Cou1ZirV9rOtIECNPhd312V/t5Y7iNV2Uvq5nNld9+xcQNQXw7mrxClJREzUJsdzABPKWbHn88BdDI2r7swleVdBi9O/ofw9Ki7Nf3gQkmzqY30Z6pFLCZ8TTd76ut9wUFb67by/m8efMio82ahaQy/4GzEV8MhvwS4lm/CoEdmJfqJnDeb2+ojfwXSKUAfcRuqeLsk31yaG/GlHto82ZBkG8D3QF048ssFw5nHNXlHP3VDiu02C44qfz+cu8lEE79K1bbbs8sfD31xCTYS3GRxzp25RJ+HZBLudYxww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:22:07 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:22:07 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Tue, 07 Jul 2026 16:21:36 +0900
Subject: [PATCH v5 03/13] gpu: nova-core: gsp: replace BootUnloadGuard with
 local handlers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-nova-bootcontext-v5-3-ecad9346387f@nvidia.com>
References: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
In-Reply-To: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0254.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 657c178c-b01a-4f20-4d61-08dedbf87369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: uzld/2XhXN3NRCaZ5b66eptcpxpCQSNJ4o/Lc7SUNWoAaldmzm+UNb8vjU9DRQ7gmgdqTmiCeyT+3OoILROq+Bfz+E9/1tslj7m4Yt0zsaz3WkqLd+lCJSrrKUJdaHIBBZnOrl7hemQXASgn0Q/M4PaQV4U5624tY9aVzTGCGE6AG7BW6fmCQxOUE8a/K4EaUG6savBM907rEnm5seSElFAKeW9/hM6l2mGbuLqTHzL/lOPpIf7e8POdD9JZC7s4VMIGQBQHUm5g+e4oEgYrxUBVlFZOKL4urvvmZanVnHk9y6zLUCREQnmGvjthDY21CLRJkldUH6ZI+f60nFn8H2ZAhHxD4x3SJmRPSBfgd6+qljge/DRuUPbeboaR/xeYVG01gBn/4GuZuKzokMnDWCJ6cf4CwVRcK8sl6GyurOa/mc0+69V1h/BZOkt9NvWOg8GY0zV55SrXZsMSoZgefnntvqgHFBywNvXn+WimvHuDcIVG/bgpP2texRMJ6bEhav1GzM7no9UGLJNEId+nu9olvKhznqkfPYdao9t133CFKN4rUXKmD64y4xd09fpNT+qpmxlcSJ5yIYUiUyEo2Z7FWPVabpKOq0wIuYn6lOvHDzfUVyE8gvh9ssr/ea3qvNCthaa3MyRiupBzKbbQpATbizyPGEn+tAWVyq655kvHO6l1ACIppG073qTduiefn5/qVgYRH3uDe1dUdhtGwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmJaS0dRZlJmdExMYk10TFpUdEkrRlA4QVBzaDlnZmRLYUJ3ZmdyR1lqbTJX?=
 =?utf-8?B?UnkzOVF5ekg4UDJtRmFhcmdwMm05QWorUXMrOHRYZndiak9NLzZQQSttQk1t?=
 =?utf-8?B?cVBjMjlaVzdRMklCby9HaHpVaGpXY1pwYjZnUi9GeWYzV1VRSGxGdVlMOXdR?=
 =?utf-8?B?cGgrc0R2all5R1A3dTNxZzFKZXBQQVYraEszeW9haGM0VisxNzR0eFdqRGFt?=
 =?utf-8?B?SmhwU0ZLTm9pZU44Rk0zVTBjU1o5dUJjejFHcXNNQmdSeUlOVTA2MlBIUGR1?=
 =?utf-8?B?bXMrbWMwRWdNVDRYZnN2RnJQb1R2SXhCZHZpbkhVdXRIdm9KZDc5WFBFcDlQ?=
 =?utf-8?B?WUM1cE1NNXBxRW15TE1qQlVmN3JjdFpyNFpCc1JKcUVudWR4ekl1bEFjbFhx?=
 =?utf-8?B?a29ZQy9SckRoZWhyWFlzZ0VPSGFFL2RDWWNQTW5ZUEZnWHk1LytQNW4wemdB?=
 =?utf-8?B?NDFXZHJjV1B0bE01K1NSeHFQTisyQ21sUHpMbTRMYVlTZ3BSOWVLT2UyV3g0?=
 =?utf-8?B?YzQyWjBPWXpOZjJCTy81ZmZ2SkVCMVY3MG0ySnhSUC9aOWsycWNvTktHVXU0?=
 =?utf-8?B?eGRHNGNHY0RKbnVwWDZKMUFUU2FEQlBkajRIL2lMTGxOcCtIQmR3aEl2Z3Jl?=
 =?utf-8?B?MzlpVmlWSGVuYVVIVHB1T0poY0M5TVErdmNWdFFTdUlmcklwckxMZDgvVkFF?=
 =?utf-8?B?V3RvaXdVRjljTUJ5WmZKKzlXQllJUUtmRXg4c0poTVUvWHltQTRrb1hodm1E?=
 =?utf-8?B?STByRkVQT0RXenY5R0lZWTUyYlVNMVlvRUZnb2FGZ0lHbHhYYmRxRHN3bmRt?=
 =?utf-8?B?Q1prVmUxbnNhdjZqMEhkRExyUG1BUWEzZVkzOGRtMTlJUXZ5MXg4TVRxdGZC?=
 =?utf-8?B?d3FybmNteVFyekVoNWNDTXR6b055a0J1SzAzRlNjVTJiMVMzWVZTcVg3QmNm?=
 =?utf-8?B?czVIRFlYRGNVZVhha0hLcHZ4QXp3Uk16U1VtbGRSTVlIMUI0a3VqU0x4Qk40?=
 =?utf-8?B?Tm14dnNJNW1ieDk0Y2xkYlpGWi9ub0p3RFErNFl3NDhucHNQS3ZyTDU3TEI5?=
 =?utf-8?B?ZHhtbmRqVkZBMVBaamVySW0yTGhZcWpqU0VZM3RsRmdGVFhuZ0xMcFhTZS9a?=
 =?utf-8?B?SWZ1S2ZseTA4aVBRNkExSG5SazRtYVhia0FQR21SRzNlbUJwTnQ5cUkvMHZk?=
 =?utf-8?B?dE45RGhwek5oMnlJeDJsNk9OUlZNL01VcXdoSXlhajhHWkF4K0lDeWhjSmpn?=
 =?utf-8?B?VVhrOEcyTDlKbWZ6R1RRR3hQZ0o2N2J3Vlh1SFJOM3kvK1dBVUNEMlBkT3g4?=
 =?utf-8?B?SVRXNisveitoZHI1NEs3ODkrZVlUaTFERXVUMHkwYXVaWlBsN2RCV1FzeXo2?=
 =?utf-8?B?SzhJOHhJQTlKeUhtSTNkQVlDSnRsYjc5TzVmcVAvMVFoakdNY2M1bDJEdEFC?=
 =?utf-8?B?eVE4eDNYRlpkLzY5aFY3T1l4NzViaXFMV2JoMUs4UDMxQWxJVEJDMWQxYlZ2?=
 =?utf-8?B?aXliRkJUWTgxNzM5RUJKam1yVUMveXYwaWRnRG1wZ05kRm55YWZmOHJ4Yy9P?=
 =?utf-8?B?OHBZVDk2M1o3TWJqcisxNGIvbEc4aHZHdEZzZzBVU2g3cGhNbUJTT0RuVVBm?=
 =?utf-8?B?Q2Y1Uk14ekNldXpOZ2FyaHI5SnlEa05oVTBoVUM3d1NHamN6QUN1UTJoTVJh?=
 =?utf-8?B?UXlBNVJyZzZaVjJYS2ZuNHQzdjhnR3RpRWY2N3VQeDdaR0hYbG4yTkdRdWs0?=
 =?utf-8?B?TUFiQ1I3MlQ1M1ZBNjZvdmVGUytneHZlaVBoMDlSRkQvMXd2Sm80QWxyc1JG?=
 =?utf-8?B?Ump3MFd4OGExOGRwb29ZT1hlUW5vWVg5ZXhkbkxSSkNidUZPNFk4Mm5FdjBN?=
 =?utf-8?B?TFIyQ0NGaXRLQ253RVpKQVoyM1QvUStQSlFoT3JUTVZkcjVCTEd2MzhIb0J5?=
 =?utf-8?B?VjNvU3BzMEtWbjhZTTdUb1l5VXZnK1gyRnZLRTB1QXZvYlZXaEY2RlZTdVhj?=
 =?utf-8?B?Tkd0RU1WUWhsMldFd2JSSXNHdGw1dHpVeFJNRVBtenNxeTJYeWsxeXNROEN0?=
 =?utf-8?B?ZGZub1dJTXhaaXQ2OGFqa0FhOG5wVjdVRmlaSkVleWc3Qm1aMjFCYnBQd2pJ?=
 =?utf-8?B?UnljVXFvZjNpWUIwaDhpN2hMRjdrc1k1VHA1NG8vMUdjU3AzZjg0Vjg2T2hw?=
 =?utf-8?B?eFJLbUYyT25kR0NXbmlDb3BGUWJvaXVRV0NBU0krd2lkdHcyVmhkZFFVWlln?=
 =?utf-8?B?TlFVWTBxSnVReUpaYTY4R0dFME1tVkVqN01wNlpzTlp0dkVYaFpsSDcra3lY?=
 =?utf-8?B?cFZHY2had2trRGpLZDFUNXN4VTVsSUZzT0JFYTdwczJsRzE0OFVIRElhZm40?=
 =?utf-8?Q?Q7DNpSIFG+01a5jqhSonHpqiw85cz0oucgKBT2I6P1OJJ?=
X-MS-Exchange-AntiSpam-MessageData-1: yRmtam8LeaM9ow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657c178c-b01a-4f20-4d61-08dedbf87369
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:22:06.9118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YwoNBjYAig3NJy9ee7J8iajEkMuDJz1CNNUgqFvPauVAlrTAyC8zRrHgnENLeJjARsurqVsQ+PVBdVJxZyNzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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

When adding the GSP unload capability, we introduced `BootUnloadGuard`
to automatically call `Gsp::unload` whenever an error occurred during
the boot process, in order to try to reset the GSP to a valid state.

This approach is not well-suited to the errors that may occur in HALs:
by definition, an error occurring in the HAL means that the GSP is not
booted; yet the first thing that `Gsp::unload` does is queue a shutdown
message to the GSP, which will inevitably result in a timeout when done
from a HAL.

Furthermore, `BootUnloadGuard` is problematic because it holds
additional references to the boot context, notably the `Falcon`s. These
extra references stand in the way of making some of the `Falcon`'s
methods mutable, since those methods would require exclusive access. As
this behavior is only needed in one place, introducing dedicated types
for it is distracting and unnecessary.

Thus, remove `BootUnloadGuard` and adopt a two-level error handling
strategy:

- HALs are free to handle their errors as they see fit (most likely, by
  running their unload bundle if it is ready by the time of the error),
- `Gsp::boot` uses a `ScopeGuard` that runs `Gsp::unload`, since the
  GSP should be up and running by the time `GspHal::boot` has returned.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gsp/boot.rs      | 67 +++-------------------------------
 drivers/gpu/nova-core/gsp/hal.rs       | 13 +++----
 drivers/gpu/nova-core/gsp/hal/gh100.rs | 31 ++++++++++------
 drivers/gpu/nova-core/gsp/hal/tu102.rs | 23 +++++++-----
 4 files changed, 44 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index ab0491b57944..536f2e341c01 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -30,66 +30,6 @@
     },
 };
 
-/// Arguments required to call [`Gsp::unload`](super::Gsp::unload).
-///
-/// Stored as their own type to avoid repeating a long and tedious list in [`BootUnloadGuard`].
-pub(super) struct BootUnloadArgs<'a> {
-    gsp: &'a super::Gsp,
-    dev: &'a device::Device<device::Bound>,
-    bar: Bar0<'a>,
-    gsp_falcon: &'a Falcon<'a, Gsp>,
-    sec2_falcon: &'a Falcon<'a, Sec2>,
-    unload_bundle: Option<super::UnloadBundle>,
-}
-
-/// Guard that calls [`Gsp::unload`](super::Gsp::unload) with a
-/// [`UnloadBundle`](super::UnloadBundle) when dropped.
-///
-/// Used to ensure the `UnloadBundle` is run during failure paths.
-pub(super) struct BootUnloadGuard<'a> {
-    guard: ScopeGuard<BootUnloadArgs<'a>, fn(BootUnloadArgs<'a>)>,
-}
-
-impl<'a> BootUnloadGuard<'a> {
-    /// Wraps `unload_bundle` into a guard that executes it when dropped.
-    pub(super) fn new(
-        gsp: &'a super::Gsp,
-        dev: &'a device::Device<device::Bound>,
-        bar: Bar0<'a>,
-        gsp_falcon: &'a Falcon<'a, Gsp>,
-        sec2_falcon: &'a Falcon<'a, Sec2>,
-        unload_bundle: Option<super::UnloadBundle>,
-    ) -> Self {
-        Self {
-            guard: ScopeGuard::new_with_data(
-                BootUnloadArgs {
-                    gsp,
-                    dev,
-                    bar,
-                    gsp_falcon,
-                    sec2_falcon,
-                    unload_bundle,
-                },
-                |args| {
-                    let _ = super::Gsp::unload(
-                        args.gsp,
-                        args.dev,
-                        args.bar,
-                        args.gsp_falcon,
-                        args.sec2_falcon,
-                        args.unload_bundle,
-                    );
-                },
-            ),
-        }
-    }
-
-    /// Disarms the guard and returns the [`UnloadBundle`](super::UnloadBundle) it contains.
-    pub(super) fn dismiss(self) -> Option<super::UnloadBundle> {
-        self.guard.dismiss().unload_bundle
-    }
-}
-
 impl super::Gsp {
     /// Attempt to boot the GSP.
     ///
@@ -107,6 +47,7 @@ pub(crate) fn boot(
         let bar = ctx.bar;
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
+        let sec2_falcon = ctx.sec2_falcon;
         let dev = pdev.as_ref();
         let hal = super::hal::gsp_hal(chipset);
 
@@ -118,7 +59,11 @@ pub(crate) fn boot(
         let wpr_meta = Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::new(&gsp_fw, &fb_layout))?;
 
         // Perform the chipset-specific boot sequence, and retrieve the unload bundle.
-        let unload_guard = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
+        let unload_bundle = hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?;
+
+        let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
+            let _ = self.unload(dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
+        });
 
         gsp_falcon.write_os_version(gsp_fw.bootloader.app_version);
 
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index d3e47ef206de..851d1f24c137 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -24,7 +24,6 @@
         Chipset, //
     },
     gsp::{
-        boot::BootUnloadGuard,
         Gsp,
         GspBootContext,
         GspFwWprMeta, //
@@ -51,15 +50,15 @@ fn run(
 pub(super) trait GspHal: Send {
     /// Performs the GSP boot process, loading and running the required firmwares as needed.
     ///
-    /// Upon success, returns a guard that runs the GSP unload sequence if GSP boot does not
-    /// complete.
-    fn boot<'a>(
+    /// Upon success, returns the [`crate::gsp::UnloadBundle`] to use with [`Gsp::unload`], if one
+    /// could be created.
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>>;
+    ) -> Result<Option<crate::gsp::UnloadBundle>>;
 
     /// Performs HAL-specific post-GSP boot tasks.
     ///
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 1d06405a32f6..18c889f9f413 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -23,7 +23,6 @@
         Fsp, //
     },
     gsp::{
-        boot::BootUnloadGuard,
         hal::{
             GspHal,
             UnloadBundle, //
@@ -143,13 +142,13 @@ impl GspHal for Gh100 {
     ///
     /// This path uses FSP to establish a chain of trust and boot GSP-FMC. FSP handles
     /// the GSP boot internally - no manual GSP reset/boot is needed.
-    fn boot<'a>(
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>> {
+    ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
@@ -160,10 +159,6 @@ fn boot<'a>(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
         );
 
-        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-        let unload_guard =
-            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, Some(unload_bundle));
-
         let mut fsp = Fsp::wait_secure_boot(dev, bar, chipset)?;
 
         let args = FmcBootArgs::new(
@@ -174,11 +169,23 @@ fn boot<'a>(
             false,
         )?;
 
-        fsp.boot_fmc(dev, fb_layout, &args)?;
+        // Keep the result as we want to wait for lockdown release even in case of error, to make
+        // sure `args` is not accessed by the GSP anymore.
+        let fsp_res = fsp.boot_fmc(dev, fb_layout, &args);
 
-        wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_dma_handle())?;
+        // Wait for GSP-FMC to release the GSP lockdown, indicating that `args` is not accessed
+        // anymore.
+        let lockdown_res =
+            wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_dma_handle());
 
-        Ok(unload_guard)
+        match fsp_res.and(lockdown_res) {
+            Ok(()) => Ok(Some(unload_bundle)),
+            Err(e) => {
+                // Wait for the GSP RISC-V core to halt in case of error.
+                let _ = unload_bundle.0.run(dev, bar, gsp_falcon, sec2_falcon);
+                Err(e)
+            }
+        }
     }
 }
 
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index 87ceb8878f01..f78e2489f5a6 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -6,7 +6,8 @@
 use kernel::{
     device,
     dma::Coherent,
-    io::Io, //
+    io::Io,
+    types::ScopeGuard, //
 };
 
 use crate::{
@@ -32,7 +33,6 @@
     },
     gpu::Chipset,
     gsp::{
-        boot::BootUnloadGuard,
         hal::{
             GspHal,
             UnloadBundle, //
@@ -259,13 +259,13 @@ fn run_fwsec_frts(
 struct Tu102;
 
 impl GspHal for Tu102 {
-    fn boot<'a>(
+    fn boot(
         &self,
-        gsp: &'a Gsp,
-        ctx: &GspBootContext<'a>,
+        gsp: &Gsp,
+        ctx: &GspBootContext<'_>,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
-    ) -> Result<BootUnloadGuard<'a>> {
+    ) -> Result<Option<crate::gsp::UnloadBundle>> {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
@@ -290,9 +290,12 @@ fn boot<'a>(
             .ok()
             .map(crate::gsp::UnloadBundle);
 
-        // Wrap the unload bundle into a drop guard so it is automatically run upon failure.
-        let unload_guard =
-            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon, unload_bundle);
+        // Run the unload bundle to try and recover the GSP if an error occurs.
+        let unload_guard = ScopeGuard::new_with_data(unload_bundle, |unload_bundle| {
+            if let Some(unload_bundle) = unload_bundle {
+                let _ = unload_bundle.0.run(dev, bar, gsp_falcon, sec2_falcon);
+            }
+        });
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
         if !fb_layout.frts.is_empty() {
@@ -319,7 +322,7 @@ fn boot<'a>(
         )?
         .run(dev, sec2_falcon, wpr_meta)?;
 
-        Ok(unload_guard)
+        Ok(unload_guard.dismiss())
     }
 
     fn post_boot(&self, gsp: &Gsp, ctx: &GspBootContext<'_>, gsp_fw: &GspFirmware) -> Result {

-- 
2.55.0

