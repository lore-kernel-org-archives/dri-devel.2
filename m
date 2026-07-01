Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043ACC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 00:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FAF10E1E2;
	Wed,  1 Jul 2026 00:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="E4eGHBWj";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010058.outbound.protection.outlook.com [52.101.46.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C61610E1E2
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 00:15:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMibIJqpLyfgp8ShM2z7wU6BGhwDv+mzZHsqp39K5Oq8ie5GB4WU30OJyo3j/TD2LQxHjVPVSshW8tBJQAFppw/eME92GpkYYt4dVOVtfZ7CFNspmU62oDfrz/6G1kP1C/JA3iT8B/kJjdrnNHljm+GTw71ZKvHSPHN/n6aTvVBC9x1M61jJI5fz+5O1VGvI5bLsMEPMh1CH4cmKb81RQ9Do7Jkv+rM7ZHjrj6AshtiCd237mJDZomZ0pK6AaTGYFkOuUr8wBp5fBvlA9ZmJNIOzN2i2Nmzy2L6T8j4fG8fJFQLb8w6cY+pIVjcwbhpCwWoJD9BwvDVZgYWie44ILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLNhrSijMUUkP83oQU0jZ7wWWUUBTQUTFYfMT93jkdc=;
 b=FTsQA3Y0AngXNqoLb/w5n2fhXh4QOYFt3o1AtP+9vODZgQVXE5fLy2K/MQNUYSbOrnOzfEYVhEBClCgJsck5MY9jXWJTQlcTsCzXrjyG5e1pvpwFWBm18d1bIGeVuLB/RIp/LyJfvqGFJOqth4IQKsLPhV8VHFpsghvYyizQNYZJHvxZ/n+2kPmnL9GxFSm5qboC73lorO0o1np0rkyjUjgu+wlcbZaqZ0G9F+lAyFNoRObMatCuII9oIbpU0TgUYlenY3/hgk75UD+zyFoV34VPVd/6SGTeQUUj0ussQSsmoS7Xv7wc9ZGkQqmJIt9bhm3YbuC03fdDyT0J1ZMZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLNhrSijMUUkP83oQU0jZ7wWWUUBTQUTFYfMT93jkdc=;
 b=E4eGHBWjx7+YSFvw4DVi3iO21CdHPH/9F7sLl5o2JkOfqR0CvQi/XnV9HJ43nL4dc/5WvLUt/yy9jDzFaRVyYQtZgRgQIVZZOXZJw7lyGWE9BDrSny8O/t1PozKD9QggqsIOfZqnvPsgOk1DObCSe0pnMlcyrMjIorJ4uD8LT3Vu9iSfGuGX9h1/Qchrdh1oAobx4nJCpz/gjTCCXV8wq+tbnAj0Q3hbKam9S1ldkP6fv+qE0hUI2BslEryshT/FGAapkAPCsgFOC2WgtaXmLA+tdqbKe+FQYSBhyEX70p9NGIPyvj4vH27xIkuW7V8KrA5u/foDFYNT1PBfzVz+zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 00:15:43 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 00:15:42 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Wed, 01 Jul 2026 09:15:30 +0900
Subject: [PATCH v2 1/2] gpu: nova-core: convert to kernel bitfield macro
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-nova-bitfield-v2-1-2e949bf1836c@nvidia.com>
References: <20260701-nova-bitfield-v2-0-2e949bf1836c@nvidia.com>
In-Reply-To: <20260701-nova-bitfield-v2-0-2e949bf1836c@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWPR01CA0017.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::22) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 75aa2721-47a7-4aa0-9b2c-08ded705e371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|10070799003|1800799024|366016|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /SXHkRRhvlAgW7eXSB/9wiz5LoPWtftXirHBTrK8Wy3UeP6mnzbayVl+CXWbvxPOLCyIdGrYULtTZRXd1U2mVfqjAI0MptwYGeGR88LwEqNwxU/neHqd2feP6peUu8JPLAz+SCZ2vIJ/VgEf7WptjJNuxTcuFLts3uGWjWohyi2UWBBWUqLoI6mri0OEGCTnBjHstTXVbqc91mWUecRyu/jP3rjQHDo5T26C20KRf8UYU5EXSdxb52krIEKmcDrFoRiKAxO7EcoafA/vVZqZzg+GZe/W4p6dxN+uc0ugJDb4j3WH4C3b24kdG5EJCal8arpL/n8TGi/YAeOFxzjZ4BLq9qMHEUWRw1wNjBB2OFY45nQ7VFICd+apRjuvsNZSUSNCCEKniT7siNDdPrvFEORTwENp/MtGHbQ8SBoJQIDMjvZ1BVtNxE1oKOc4Dl8NKs9XxsTel+phGeVtWIMktVZtkkYvYR18TU1n2/x+SQkCU26Pe/bCyZ1QsbR68jzXh0cW0E0ixLyPg9u/E+bLpqH4wg0mW7Vv79GhiXreZQSk0Vh57huL5mZHQ6FMENhnLIs7GnLGXf0jrIj5knjZZzqocosLNdms+YggNaeUHz6ILFW84cFjG2XWIJYcEvuqnlnxe6IAgpFXgDGX+8xaTu+uB2xDuMn3G7Pb2lbk4rVpwgrxznCuglMT2LR8Mn3epPJBphi4VJ+xzUcU4+1N+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(1800799024)(366016)(921020)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUFPMW5HWVkrcDhxL1lNSm03cEg5K1ErcmxpWVlEMkhUeVRZV2pMblhIeWxE?=
 =?utf-8?B?MzhPZHE1TW1CcktwSTB5TTRNVVQvb3ZPWVowQmtqV1A2L1drbW53ODhHNlBi?=
 =?utf-8?B?elRSekFibWdSMlFWbExmV3RTUnV0N3NUUmJmZVlLL1dtSnBZWVNTQWcweG92?=
 =?utf-8?B?RkdBc1lEcXRkeE4zVThWb01qWUZkSUU0ZVViVjMrWWdtakk0SGJvL2xiWGM5?=
 =?utf-8?B?ZzdpNGo4VVh1SDdKdE4yZjdyczFtUURSYUpTZVhRdnBsS25mbXFBT0FocXV2?=
 =?utf-8?B?V0xpRGZQd3pRK1ovRW1DYVJkRFFncVFkbzFMYm9vMEtYUHI2M0VSYTY1LzhC?=
 =?utf-8?B?cklqSjBUcVdUbWlMZ2RsSk5maGc3eXVZbEJpU1d3Mzd5RzQyRmpzdkNkOXdy?=
 =?utf-8?B?d1ZrdFpxQlVaR0FDd0I1YmdlNXE3c2FRSW1Xd2dQWlRQVURJWkJPRDhRbDI0?=
 =?utf-8?B?Q1IrQ2xQdVE2bTVCQ2RCSGxlSnJsSHhhTktRbVdXY1pGK2RyM29OalJ2WlVR?=
 =?utf-8?B?d1BmR24wRXRiSmFFekpVZ21lODJzZUtoeEsyeEVSU1NXdWNBMkpjWkQzcGZE?=
 =?utf-8?B?WW5wak9MbGpIWGFocnoxVlRkWG55UFFyYW4wSGJSN3d0OWp3L1lnVllPbngr?=
 =?utf-8?B?Y3FnbXN4NmloVEFidG9TS3FtNmVzaWZtVmMwVVdPRmNSRDlUUmVESmROOStk?=
 =?utf-8?B?a1dqNTY0eXVzY2NyVXRmeENOMkFxRXE1RzRNTjhod0NHSTFORmtuYTJjNWFY?=
 =?utf-8?B?ZmVzZ0huQ0lTMVduR292TGk1Z2xVSGRScWNGeDN6ZFExd3dXT3psVS9wYlJK?=
 =?utf-8?B?cHBQbzg1R3FNSm5LYmpGT2Rnc2t1VW9DQXZCTFM2dUlraGVFZjFrcHlxNjht?=
 =?utf-8?B?c3FDSU84YzFxeEpSamx6cXpGbUFCQVVzektxU0RISUZhRkNtWkRxTEhZZzRp?=
 =?utf-8?B?bzJvblcyV0VMVlJoRlNmajVPbnkzOU0wMS9ud01IbjFxUGkwY1dGLzE1THhZ?=
 =?utf-8?B?Q3RzUldKVHh0Zm1MeDBrRldQRkJkRXNyL3lGazlpZy9aa01UYU5aQjB2T3FU?=
 =?utf-8?B?V1lMaFZzMXpYd0JoSVdrb1UwRXpMSGd3Q2tCOVJKeXIvdW1oODQ5RFFRRGgz?=
 =?utf-8?B?OFk5b0hEUE84VXpYYVlzamtaUXZOMTczR3FEZTdqcHM1dVBEWnhQbWZOZEFh?=
 =?utf-8?B?d1l0dGpabkVSeW1JSmRJOGdWYUFmTENCS2NVTXU4V0RSVURKNDc4YXd5aldj?=
 =?utf-8?B?M0NKOTd3cDFUYnRTSklEeDIyajBNRjJHL3lvWmg3ZXk1UWozSFNmbTlJb1k0?=
 =?utf-8?B?YjRWQm44cE9UVU10VksrbG85YzNVVDRsanFPMVczYmpCSVV6U20yZnhrN3Uv?=
 =?utf-8?B?THNxQ2RmTlhyZ1c2NFNOSk9BVzduYTlFV2kyVlBTRFpweGRkVHFiRjdxdTYr?=
 =?utf-8?B?WTNzVXA1Q1krQW9zRURYajJlK0plQ21vUmxWU2VqeGFqRmhFWENBNy9YbXVN?=
 =?utf-8?B?UUxEZEVCU3JzdkJjMms3QVdoWU1BakZ0NlRZWFBTeWhpNVVJTUhTWEhzM1Er?=
 =?utf-8?B?QTdqVWQ0Smk4dHV2ZlZmSzFpMENMaDRuWVE2a1dFY0hvbUp1ZnptY0VlSzVT?=
 =?utf-8?B?UDNIOGh2ZmlqVllJcVkxWEZFbEw4WDNYT2pWNjJVMXZEM3BGMUh0OHFObzdp?=
 =?utf-8?B?UGZVTTdEcVVMaUc4UmovRFNQQStCN3piSjdhbExnb1FmazNzZGFDbjkwaEsz?=
 =?utf-8?B?Z0JaTmVUVkdacnhTNHlUK3RKUUd0cW0ydFVHbGsrMWdFS3lUaFQ5Mmx5K0k5?=
 =?utf-8?B?dmlzdjluZkc3RkxHdStJUU42OWJ5SzMxSzhQT1diMmpMdWpaZHZYSmpaNFZV?=
 =?utf-8?B?UkE3OHJXb3VITmpVaC9Nd3hkbWxFOFEwcWxXdXcxNUlEMlZYWFpHcEoyZTNk?=
 =?utf-8?B?a21lbTJ0RW5kQi9qbW1NT3dvSnBBWk81UlRreFgyYnR1Y0ZvYWxZUDJmRXky?=
 =?utf-8?B?Q0NLbFhqZ1hyTmZrcjdZQWYvQ1RTay9EMGtGOGJpbHFKZXVoajZXOWxyNXkv?=
 =?utf-8?B?VTJFNWc1SFBQbXQ4b0w0ZVpqOUVYNVlDeENlUU5oSGFuaFBFWmt4OVFhMGxj?=
 =?utf-8?B?M0d0MEZkb2JuREpkdk84bmpaUy9CTlhLeFRzZXdVKy9yeDJIcDFSbEY4OU9v?=
 =?utf-8?B?aGdxMExyL0JOakozNkN4cUJhcmxIck9HamZTWVRBek1kQVlCYmltWCtkQ2tN?=
 =?utf-8?B?cVBEc0gwLzgweVl5SUJXd2Fka0U0cnBmcTJxdkk3eEs0MWtlL3RKSmt6UU9K?=
 =?utf-8?B?bUNnSVB5VElIREVvczZwSG02OTE0cVlKNU9NdDRQdU5vQTQ2RWhYdGRqOTBj?=
 =?utf-8?Q?yqRtaHyau8CEjCfUFEW64nvQmbv8mYW1864+zEyd95vq1?=
X-MS-Exchange-AntiSpam-MessageData-1: KCi+OevBaFcvoA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75aa2721-47a7-4aa0-9b2c-08ded705e371
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 00:15:42.7613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54gz6YPzFRczqymVPtLC6VmPkyu0dNI1ZY3pXZK/OuVRtLXM3t9c/rX+JynivM+h/HULEw6xFL53lviERmfCCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771
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

Replace uses of the Nova-local `bitfield!` macro with the kernel one.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Acked-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/fsp.rs       |  3 +-
 drivers/gpu/nova-core/gsp/fw.rs    | 11 ++---
 drivers/gpu/nova-core/mctp.rs      | 86 +++++++++++++++++++-------------------
 drivers/gpu/nova-core/nova_core.rs |  3 --
 4 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 574e1627e63c..f0c595175c9c 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -11,6 +11,7 @@
     device,
     dma::Coherent,
     io::poll::read_poll_timeout,
+    num::TryIntoBounded,
     prelude::*,
     ptr::{
         Alignable,
@@ -300,7 +301,7 @@ fn send_sync_fsp<M>(&mut self, dev: &device::Device, msg: &M) -> Result<KVec<u8>
             return Err(EIO);
         }
 
-        if command_nvdm_type != u8::from(M::NVDM_TYPE).into() {
+        if command_nvdm_type.try_into_bounded() != Some(M::NVDM_TYPE.into()) {
             dev_err!(
                 dev,
                 "Expected NVDM type {:?} in reply, got {:#x}\n",
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 4db0cfa4dc4d..5a8392b33b4a 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -10,6 +10,7 @@
 use core::ops::Range;
 
 use kernel::{
+    bitfield,
     dma::Coherent,
     prelude::*,
     ptr::{
@@ -742,8 +743,8 @@ unsafe impl AsBytes for MsgqRxHeader {}
 
 bitfield! {
     struct MsgHeaderVersion(u32) {
-        31:24 major as u8;
-        23:16 minor as u8;
+        31:24 major;
+        23:16 minor;
     }
 }
 
@@ -752,9 +753,9 @@ impl MsgHeaderVersion {
     const MINOR_TOT: u8 = 0;
 
     fn new() -> Self {
-        Self::default()
-            .set_major(Self::MAJOR_TOT)
-            .set_minor(Self::MINOR_TOT)
+        Self::zeroed()
+            .with_major(Self::MAJOR_TOT)
+            .with_minor(Self::MINOR_TOT)
     }
 }
 
diff --git a/drivers/gpu/nova-core/mctp.rs b/drivers/gpu/nova-core/mctp.rs
index 482786e07bc7..acc2abbd4b0c 100644
--- a/drivers/gpu/nova-core/mctp.rs
+++ b/drivers/gpu/nova-core/mctp.rs
@@ -7,55 +7,51 @@
 //! Data Model) messages between the kernel driver and GPU firmware processors
 //! such as FSP and GSP.
 
-use kernel::pci::Vendor;
+use kernel::{
+    bitfield,
+    pci::Vendor,
+    prelude::*, //
+};
 
-/// NVDM message type identifiers carried over MCTP.
-#[derive(Debug, Clone, Copy, Default, PartialEq, Eq)]
-#[repr(u8)]
-pub(crate) enum NvdmType {
-    #[default]
-    /// Chain of Trust boot message.
-    Cot = 0x14,
-    /// FSP command response.
-    FspResponse = 0x15,
-}
+use crate::{
+    bounded_enum,
+    num, //
+};
 
-impl TryFrom<u8> for NvdmType {
-    type Error = u8;
-
-    fn try_from(value: u8) -> Result<Self, Self::Error> {
-        match value {
-            x if x == u8::from(Self::Cot) => Ok(Self::Cot),
-            x if x == u8::from(Self::FspResponse) => Ok(Self::FspResponse),
-            _ => Err(value),
-        }
-    }
-}
-
-impl From<NvdmType> for u8 {
-    fn from(value: NvdmType) -> Self {
-        value as u8
+bounded_enum! {
+    /// NVDM message type identifiers carried over MCTP.
+    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
+    pub(crate) enum NvdmType with TryFrom<Bounded<u32, 8>> {
+        /// Chain of Trust boot message.
+        Cot = 0x14,
+        /// FSP command response.
+        FspResponse = 0x15,
     }
 }
 
 bitfield! {
-    pub(crate) struct MctpHeader(u32), "MCTP transport header for NVIDIA firmware messages." {
-        31:31 som as bool, "Start-of-message bit.";
-        30:30 eom as bool, "End-of-message bit.";
-        29:28 seq as u8, "Packet sequence number.";
-        23:16 seid as u8, "Source endpoint ID.";
+    /// MCTP transport header for NVIDIA firmware messages.
+    pub(crate) struct MctpHeader(u32) {
+        /// Start-of-message bit.
+        31:31 som;
+        /// End-of-message bit.
+        30:30 eom;
+        /// Packet sequence number.
+        29:28 seq;
+        /// Source endpoint ID.
+        23:16 seid;
     }
 }
 
 impl MctpHeader {
     /// Builds a single-packet MCTP header (`SOM=1`, `EOM=1`, `SEQ=0`, `SEID=0`).
     pub(crate) fn single_packet() -> Self {
-        Self::default().set_som(true).set_eom(true)
+        Self::zeroed().with_som(true).with_eom(true)
     }
 
     /// Returns whether this is a complete single-packet message (`SOM=1` and `EOM=1`).
     pub(crate) fn is_single_packet(self) -> bool {
-        self.som() && self.eom()
+        self.som().into_bool() && self.eom().into_bool()
     }
 }
 
@@ -63,26 +59,30 @@ pub(crate) fn is_single_packet(self) -> bool {
 const MSG_TYPE_VENDOR_PCI: u8 = 0x7e;
 
 bitfield! {
-    pub(crate) struct NvdmHeader(u32), "NVIDIA Vendor-Defined Message header over MCTP." {
-        31:24 nvdm_type as u8 ?=> NvdmType, "NVDM message type.";
-        23:8 vendor_id as u16, "PCI vendor ID.";
-        6:0 msg_type as u8, "MCTP vendor-defined message type.";
+    /// NVIDIA Vendor-Defined Message header over MCTP.
+    pub(crate) struct NvdmHeader(u32) {
+        /// NVDM message type.
+        31:24 nvdm_type ?=> NvdmType;
+        /// PCI vendor ID.
+        23:8 vendor_id;
+        /// MCTP vendor-defined message type.
+        6:0 msg_type;
     }
 }
 
 impl NvdmHeader {
     /// Builds an NVDM header for the given message type.
     pub(crate) fn new(nvdm_type: NvdmType) -> Self {
-        Self::default()
-            .set_msg_type(MSG_TYPE_VENDOR_PCI)
-            .set_vendor_id(Vendor::NVIDIA.as_raw())
-            .set_nvdm_type(nvdm_type)
+        Self::zeroed()
+            .with_const_msg_type::<{ num::u8_as_u32(MSG_TYPE_VENDOR_PCI) }>()
+            .with_vendor_id(Vendor::NVIDIA.as_raw())
+            .with_nvdm_type(nvdm_type)
     }
 
     /// Validates this header against the expected NVIDIA NVDM format and type.
     pub(crate) fn validate(self, expected_type: NvdmType) -> bool {
-        self.msg_type() == MSG_TYPE_VENDOR_PCI
-            && self.vendor_id() == Vendor::NVIDIA.as_raw()
+        u8::from(self.msg_type()) == MSG_TYPE_VENDOR_PCI
+            && u16::from(self.vendor_id()) == Vendor::NVIDIA.as_raw()
             && matches!(self.nvdm_type(), Ok(nvdm_type) if nvdm_type == expected_type)
     }
 }
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 735b8e17c6b6..a61406ba5c0b 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -10,9 +10,6 @@
     InPlaceModule, //
 };
 
-#[macro_use]
-mod bitfield;
-
 mod driver;
 mod falcon;
 mod fb;

-- 
2.54.0

