Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21588C624CE
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 379B510E523;
	Tue,  1 Sep 2026 05:07:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cz0N78k1";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012002.outbound.protection.outlook.com
 [40.107.200.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF0210E523
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 05:07:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofFjiFz0iGr+it6MxoTPwc8rCmmkPsZIou2BzP41xvrz9/LgU9peU1rHhwZa16xhWnn2PcsLCI6VQIZogoihuIGlsigcUDB6RooOh2L245JfRHfe7KH5IfFAXAkg2/gIfmuQX2HFH1/1607V+MBJbvSEQ3quYvIezAPknJbepT90lPKtX/K+2I80bhfFpvtIPgBMRp7Hy7AGQJ33Q9qI8V3GVoPyQd8Ffyb9yg1QFtSPxE7Unj5z+hTzz1l5AxJLscRbH39vhqHYDI21t6/aqH/qpuCZIHrAqRYKPULY1QBuPAaw2XzGDVabExs0+ZXhn00OpaeWY8tlwKbw22Ktmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQpZ3a2f+LqsfUy7ar+HiczTCtS9VKXENlMnptM23LA=;
 b=rkpI1XzbZr54WfE/V1O7oMoqrml34ZVA9QrsSQm0we8B7KxLnjmzj7qkuiQKF2XjHUjXrZkEC3jxuon1ir58KOvJb+bJfkyiXpyEBM9WsfGgBTUP78loQlnqqi9ymDWp1S7zKjnHtPizOsDLb3KkxOqBMJ+DfIUCAIbLRvNaVrq+2HFM2mUPxJJ0BJfTZQk/wogkzGN/6cU3n5JrnQvl9VepZrz02zfPh9bmA3E+gTKNWGx6ajdR9v4jv85YWm903MCnQgrDXl2d9M6ufZW5SJ3DLBKTFqhlnsBBqxKN/tCJbh4ON+JZwsUxfmZv1jM8J0PRxSMcyb4Gr7IOYvjkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQpZ3a2f+LqsfUy7ar+HiczTCtS9VKXENlMnptM23LA=;
 b=Cz0N78k1CoYLABEW/4opVxSHqPmtfBlHOMhovuu+JOChBTfk1sYPTKk66BIqgvG1a2NFd/H5wA8HYumYR+AZcm5lso0s/sQr7gUIP56bkQfHVZHcGVTi8La21HbzB64Bhs38mhPXNmy3YtTkvdjfTYylS2ydrixU6vb95K8kIpDYbg6vjum3ALwG0cImh1am9HQ0pHPsTRJADnFDRalcvnYEwbk2tJjl8q6AXqtY3EIpQtsqCB8IbetVEBLb2TrK0hTFFPdQQtOSzCu6mlC2tZR092Z73T3xDXeQs16/hBRl3m5ns7fPUMQiRAbx7mzQqLyv3q1cTItLE6wP1+TgBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Tue, 1 Sep 2026 05:07:08 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 05:07:08 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 01 Sep 2026 14:06:41 +0900
Subject: [PATCH v2 2/3] rust: prelude: add `num::cv`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-cv-v2-2-446bc69d2ade@nvidia.com>
References: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
In-Reply-To: <20260901-cv-v2-0-446bc69d2ade@nvidia.com>
To: Alexandre Courbot <acourbot@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0161.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DM6PR12MB4355:EE_
X-MS-Office365-Filtering-Correlation-Id: 420e984f-18b8-4a75-e8f8-08df07e6df5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003|921020;
X-Microsoft-Antispam-Message-Info: VOoHi79sIzVh7mlEXSKCQCe4a/47kn2rXQvRuNFbl5Zk+yXlp/lp3zr3mnL5T/eqfSC592Gv9jaT44ktEi+zJkkXmJH4PJaPe+ubKs8Pm5CIISo/fcIuyMUSUaxiyj9fnRDYLZwYGPUY2/98h/PerbINlFlFREaFKTrjMuKeh13AQiRWXPjwZfOoYY/wT0M3ZkUg25i0BbO4zSFOiUrSK3ClZOX25GBaTv1wCRVIiHjbDZTBB1evS3Ie7QzhoBy3LyMBanApB591VRBbSs6Z0iKr1lvjmCKCGy4CD2ikzNxsNrw6ph7yA/TMWoMaVMkkGDOINQGvw/1/vfz+XRHBSa/jk1LTEFkUWpk0AQ3D7jwJT+3nImoRe0FD4nxh5h7arYWooNvR3K4hfoqPZDdUN6Mordt1G68E+yTAj9fuS5KfrHmXcC+pHe0Et8nW1PBEH2Vc7IO6s//52gcqdlELJDUXh/Fqud++kS24qU6LRQbtWbhoCQZyLZrxnUYjVD4NMUG4Cz9UeAoK17u+Bnrz783h/WiJc+YKL7RXi1hB9JHWCPsud38eb5FkpfaEnGQ9F/4xwB0I3Tf9/XWiRcr42Wr/1oTsQ8Q5FP+8M4eTbzD5nq/2EA/uElIXp/nZqV68qkFr4C4Xv5RIR78aBTTEk0vyA+F16BRmyKS9LQsUujWl5BeGWZdwJxW/c7N/KGSDHzUrI0i58VXqhgXVkR6bvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ankydmJOUjJ2Z2xQbjhZNktvcDJQWGNiQ2FwOWoxVTFmTVMzUGVSS2RCMGtB?=
 =?utf-8?B?NnNuQUd1RytLNFFiOVpERlh3SkZvcHJUaGVrUC9VRm95VzBPcjQ3b3RWME80?=
 =?utf-8?B?bERZeHVYU1prcVNIVnpzQ09MaFd3ZXdSSVRVU0NKb2tKQzhtZmNCT09JZDlO?=
 =?utf-8?B?cjlRMDlWTkFodTB0eGNRWTBoUG1TUlF2Sm5pTU1wbHpjK2dZNExJWmhXMmJo?=
 =?utf-8?B?dHFtcHdLT2YyOG5EeHJFcGVqK2Nid0lFL0NWbVFIdzl5bVlsS0NaSitlNyt3?=
 =?utf-8?B?T09FN1lWRUdnWFRXTjFqTUtHbGt2RkYybSthUUhHSXp3ZHAySGt1S2EyY0pl?=
 =?utf-8?B?M1pXdUVObmx2UW5DNUZwd3VQQkZjb2N6Nm5sWnpQN3F1dHYrUFpISHJJZDNE?=
 =?utf-8?B?S2lxUXZkSmVLdXMwdGNlallVdGhUK0JDdzhZdmxwak1QbS9JS3RCZElQY2Rm?=
 =?utf-8?B?WXA5YndJcldHd2lad0NnaTRDeFdEaDk0SXZUZ0ZraEx4QTJibHJ5cDVueTQr?=
 =?utf-8?B?TlVpb1BlLytXSG1TY0tzNXNyQVhpSVBRaXU1S1Zac0hYdllSZm5md2g3OSsy?=
 =?utf-8?B?eTNFKzBiNkFtMm9OZU9lVTdMUVY3S0ZDSnpoc0J1bmhpZnhZSDhZSGNBeHhR?=
 =?utf-8?B?Z2wwS0o2Vm9NdE5jVXpSNUtUNnFSNFRSMVZnckNoZ3VGRGRRRlRvV3piUVpm?=
 =?utf-8?B?Szd5UU5RWHo4VTdWNjR3SWV2ak92aVgyY2NYWW1Kdk8rL0M4VnFidUpGeG5L?=
 =?utf-8?B?SjFuMVNuTDJEL3BLRTgvS0Y0MEptcklYKzVLSkhKYnl0QWx2bkxheGlSQjk5?=
 =?utf-8?B?bnJLK3JhWHR3SmlscDQyejh1V2ZCT2phbTJacFUwV08rekFiUEpwRVBPWERn?=
 =?utf-8?B?UjJHMWoxd1F6SmJUZHpEN2NJTzc0S05TRG9CdFNsRE40YjMvMGFVK0d5cEhY?=
 =?utf-8?B?M2xMb3doMTVodlZEUDhwWXdvM0M1WnhsR0FPdytLTjVnTWZURlkzUWdVakUr?=
 =?utf-8?B?ZTFrcktyZGxudGJnMTQ1NGVGbFVwZDMraWo0ZFlJMlpJa1VOSWp5MDhnSjBu?=
 =?utf-8?B?b29uOHgvak8vd1ZPNTlYZHZHYkZQRGFYUWFwSTV6aFVJK3R4TWRNcTNPR25p?=
 =?utf-8?B?K0J2cnlObDlQUmo5NEQ2Y0l3clBHZTNRdXBVd0p4Kzhwbmc4RkFMQnhHMGw2?=
 =?utf-8?B?bHdxc1VZakpodDM0VFBmRUJkdG9BMHNFd2NjNWtHNXpZZzhFeXNLeFM1VTM5?=
 =?utf-8?B?SDROSVA5SkZHMzdXM2g3WjVJTE9ndjU1SEVvbzNnUEpuVWh1ckRienRIU3Vl?=
 =?utf-8?B?OFdPajFPa01GNkpSNzVNaG1XemtkUHBDbHVwRlMrYlBNSHRmRTRKSE9Oc25V?=
 =?utf-8?B?SG1Nb0JDMFptYWpKQzdGbWg2UDkzNzgwVjhTaHJ1eTBsck9HOWdjN2QxYk51?=
 =?utf-8?B?V0dEajdjQ01LM1kwNmN0bW00OWhqWFVyNktxVkxPeVoxQWZvR0R0R0s4K2E0?=
 =?utf-8?B?SjFrMXB1dmcyNTkzUnZuN0wxRFJxK25kQzRxTVh1NzN1cGlYTC9WVVp5S1lL?=
 =?utf-8?B?eHZoWlNKREVqd2g0cHJMSHZhTWFjMCtuU3JMVXdOU3dGR24yQ1NFdTFlTGdG?=
 =?utf-8?B?b2pacDRNekRKQWxtWjVVZnVNRi9yL1FvVHgyeVMrZGF2OVF4RTJLUVZNN3ZV?=
 =?utf-8?B?RXd6N0gvc3NMSDVhVm1BL3BZUWJTVzBEYXFGVkVYdDV6UnJpVGg5RTRpb2d4?=
 =?utf-8?B?WG42dENSK09nZE5kVnZ5SmliSHlhSnIvVEpQUDVXTmVKYWVndFNudmVyUisv?=
 =?utf-8?B?cnR4Z0lSUHRuSUxkd2ZPZk9KU3k2aWU1dzlwZUFieFV1eHlBM1VheEwxRWN2?=
 =?utf-8?B?SE4ySzltSCtVVlk4emlRNHJDS2xieExZajZSTXYzZmZZNjRnVzRiMVFDSWRB?=
 =?utf-8?B?TEl6UERDU1NwZGdLU1I5OVlFTUtWWmRXWS8xM1Yrbk5SZzI5SWtidHU2RVpB?=
 =?utf-8?B?Z1pxL1NqNlNOZDlFcGtmZWZBQ01lVjNSeVgvNkw0Mmd3RktBbjlsR1k4aVJj?=
 =?utf-8?B?RGNHdzV3L0tzQVI2UjNXQWZGajhNc0RjMjZyNE01c1lVSEhES0l0R1ptUzhM?=
 =?utf-8?B?SnZvaU1Ea2xjNWZhc3MyUE41R2hWR1J1Y0N0SDhUQmJqSklXUHQ0VE9UWERj?=
 =?utf-8?B?bWhMOGorbWY3WmQ1UkpoaXRFcUY2RFp3dEo0ZFFRellBM25aUmY1UUFsVjRp?=
 =?utf-8?B?d1VvMUtFZ0VkU21WRDBCc0NHSWVQd2ZhVW1xZXJuTE0zU1ltSDhoWkh6OGhV?=
 =?utf-8?B?eGdINWxkeVU3Z1JnWU1SWkVGeVdrZ2FWSllEMkhiTS8xcVFjZlRSd202RGpj?=
 =?utf-8?Q?NOycfK/owBgxHSgvckVjbeTteygCeo6VkjrtFEUXyQ2Tf?=
X-MS-Exchange-AntiSpam-MessageData-1: dC7CDRnEFbjmvQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420e984f-18b8-4a75-e8f8-08df07e6df5a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 05:07:08.2074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukWe1W5uRJhRpHazygIRTKA8eTwvXkjHGZ/GzDVV26x4QnNfcFejGM5pGG6zcWuNdJb3Qc4q1vo7HEpFb5qJ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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

Add the `cv!` macro to the prelude so it doesn't need to be imported
explicitly to use it.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/num.rs     | 1 -
 rust/kernel/prelude.rs | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
index 01ae2538b3e4..2207088dfb65 100644
--- a/rust/kernel/num.rs
+++ b/rust/kernel/num.rs
@@ -20,7 +20,6 @@
 /// ```
 /// use core::num::NonZero;
 /// use kernel::num::Bounded;
-/// use kernel::num::cv;
 /// use kernel::ptr::Alignment;
 ///
 /// let v: NonZero<usize> = cv!(8);
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index ca396f1f78a6..5facf8f7af90 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -106,6 +106,7 @@
         Result, //
     },
     init::InPlaceInit,
+    num::cv,
     pr_alert,
     pr_crit,
     pr_debug,

-- 
2.55.0

