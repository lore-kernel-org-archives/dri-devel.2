Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADFFCCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 20:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F6610F61E;
	Fri,  1 May 2026 20:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YR8wN60N";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3423010F61E
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 20:58:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHU9rNPE0W4HRsJqCFEh+tmcFaQzF79GaPVTsP6d5VmZKBevikBin6PzU/8HmcH5HD0kQm4dc/s7colyjBQ4/jP9s7Fw1sIbUGh9hbhgyxJNAD1BJu8NJ0mbUqZKwEsCge9YCHFFAE7X4swg6QGHO4WI0+sN7/kmPY40QOjvvqPGXKBa064MvD/hvCIKQZoWhh1toYsdVWqWXdXWsR7Fbz3pGjKvSsLKvaH7uOwgPgq1yudPc0Ta31+5C2SOgIn7eyKxiNHesQyad5M9j0iiK1stvD+M/rkD+NNU+hdWSwkODcZtS//6xA7/Yvp5U5L/heuiMaog+YfCbBI8CnZ4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep4JQGlKe8V4hohjyzMJPh+IkeBsXvJRP3xIV572IUY=;
 b=cJaeRFfjTv6bNLtcOSGmAWX5ys4UhTH5AsuYc8lcdrdb9CS3GOzMeuhAYNM3SNjEcCbjYLjD6tA3wQw+pYXC3ycWyaFdqUWTCOywYaCvdv9KkrJ9tGrWUDprbdPl1JUstdonBqx9KY5uNf5IZ1Yir1uSgH9sqHG/54r2fxJ8XAOqkrc5YwqA0UnGSFzagW3y6oHN/h7QZ+m5HKyN3kJVlswnoxc1K2FlB7q0XMxpIUwD1WJsYnov+tjID6icw201ZI0Rw+1jWfQHcwNKadErJKHnodLkv3LKuLzAhUQXMPoZi8XrxalLqHBXcFLXBFHlZbpmUCK2i00/U+L3MSclxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep4JQGlKe8V4hohjyzMJPh+IkeBsXvJRP3xIV572IUY=;
 b=YR8wN60NbY4ry5pT/HlUwxIkmlGcvbMp3Ssl5u9GpVNtswzKH3R2M8lV+BjHAgaoFGwE+1kj6+vapXEp26Gm4KlTu62+3h1simVeu5ics6xN0oBdiuFE7ceBYlWubAzOwmYjGgwZ4TUmvZxbIqEnv8fwrPBJJMg4tBBz3axbrw2Xz0l6WZNgCgecEWzmBrH0ym9HyMOJXZm9u5oiFrhnRLJ3B3PlPzsLc/7Ls41jol2q1w8CXK+Ry31bT8MiuczVEecVd+nSU0y7f0zOoxcCjwZysKBFrplBcpFjJq8n/bE+GUrcJQdPXmguwvvCsdEW+i/YDdriidGqtuo36/LMKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB8360.namprd12.prod.outlook.com (2603:10b6:208:3d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 20:58:40 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 20:58:40 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-doc@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v1 4/7] gpu: nova-core: add Architecture::is_pre_hopper()
 helper
Date: Fri,  1 May 2026 16:58:22 -0400
Message-Id: <20260501205825.73614-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260501205825.73614-1-joelagnelf@nvidia.com>
References: <20260501205825.73614-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0437.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::22) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: ede28046-41b0-4908-ceb6-08dea7c46bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Me5qiBN2aeZJuGkR+HwNAPn0OavLqXMjCuPV4WMtOTeZHuCkp6TjHOc6elkUgQ7/ddDi4npBmxgqmQnYkGIutsj3a/3PZF4hfMwaiz9zthSoUltWcYNWbr7sZDaAVsfkMzUeCkTi/H6QG4rFatxhQbkRAp4vOQCIMQly5bK+uE6uCo1VfSfIccdX5uF1SX+dH60IQ7lFktC/unukOkLt0BWnIab4A1tLvmt+S4JHrMMEi0G1z0n79Gm4Q0enoHQVznUH2gxwxTOfkTh2i0TMUbHpeo94Dy7Nfa7lPeQQSwDCleA3Q7HYntXdQCovaOVlR8+SbHbWhS5Y5gfnmpEeVbF21GvKzpHK02o3TJ+FdrQTLVTE71O5cInuiftahnjIowoh1N1i3XWc7dJuu4cXF1MPcqCTl0nibbUp7FBScA55LU8s6fIopxCz8Ez4r64VZ2lQLqWAY5+ItScFvnJHvQofOcSym/dAmHONUZ3N99EAa6Z6rG7k3Fhn9aY6qXdaWXKIosw12hyl9tGl4H90vDtTenlG5q94B4E2uq56chRfboAA8ZMAxTASmksLL0TiqpnFYGLu0ASoBmPklSLhTY6zq654Y+ItvaeyeLdodbYr2ysWzfrD7hN3xEYuBziTJP55gwJmbDxwkhK6tn+8LjRXcSMzJAarnQIAny2XHDIWLcdWpoGv9y/fMuvHK1OS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skiGQUZXFC9aO5X7lBEIBSVrGzeizkrz1kvylDqxh27WNobvT1q2Od5Q8S7N?=
 =?us-ascii?Q?gtP5YO7odeBTg6uIaEHDJFb/iCJ6Cb63MbLgnyBDtNIVEVwd7lDpIKF12dx3?=
 =?us-ascii?Q?3x5up2PqRoXhAXeQatAPG3bDuBQsZWz0oRrSeK9eOrMsDtV+wlThU9TCxdPx?=
 =?us-ascii?Q?VvH/d8Yd4dZK5ZcvOPsvTvUtmzKJTgTlMhPFMBPuXlZdoiIODRUs6EEN3zBa?=
 =?us-ascii?Q?jvoXZuxWjhRIqt3SYkFiacroYk5vhUgE5mVOaJSk9weSQo9D7qXumXU0Yqfz?=
 =?us-ascii?Q?wqplRIwcCod916fSGIIRgYwJIdmjdW3x8GY3i+IWPlu3s3tzt/DdkvsAmMdM?=
 =?us-ascii?Q?g0ygkMeDmnbFFw8vff/lQ+MHXAmshFQffVhBhNuH7boaB/dr/y0OcdWCxLce?=
 =?us-ascii?Q?qcukV5wj2KajnaW+xo5jEoSmuaYmIE5moEct49YR7GldcjvFZjlLufmC89eG?=
 =?us-ascii?Q?VRZC9nonigWjXCtWYFbMeci9lwdHkpM1kVts+y49RaIgfqKN0GEP4gj5xAYH?=
 =?us-ascii?Q?3SaRxnFgx7olPYCIABaXE3gNOtKX1IM1ll3rLFHf5lISj1hOL8QYzr17Tlir?=
 =?us-ascii?Q?fnI9z2pwZbLI9l8fnZryNTUlvbDp/s6gms2ZgDmjm58IRj2T54UzgAhOdl+S?=
 =?us-ascii?Q?+5ucXyEFDnCTPjb8w+VtOLK0/KTsvY7+2WjXmx2rn75C8jtfCVNbhTYrHIyY?=
 =?us-ascii?Q?EyClIauZ/f2VubM/UdR6kZF4k4LhXTz5YKk9jeJV3SPzFtBL2+h1RUDegB08?=
 =?us-ascii?Q?xe4buF52jr7as6IfEHvsEDKgOJKJl9aLe/SLJirm+4gVpyjLhJpo4xXAmrEI?=
 =?us-ascii?Q?e/KI7MVUGU0aw5EdhIuxUJE51G9hRY8O+/E8RyAO/WxALmV5L+38UyttCm34?=
 =?us-ascii?Q?Qj2r3J23G60OnBfvIRMsBuRxhMXGUMVO3i9vqhD7FDuvuU9a/6epyF5SU605?=
 =?us-ascii?Q?Hw/UvtePwGNVXUCRiztdR1sFvaVc4OyBE1OXcL699eqEBfyK2r23E0VfFaE/?=
 =?us-ascii?Q?JnBl4FThIY8dT1Z8ntGAp7GDvS+Gdh3RtXHFheB9XMvnvkEdXgum9DJymg05?=
 =?us-ascii?Q?bXwBTw2HvT4CmKaJrJfDGsUf6a16Wb63S5rDCfDEs74q3+As4naokDwrCcbm?=
 =?us-ascii?Q?I+j3fQBIzTqxbYQmYJdeWrKLuoJBu0uN2c2uFgsA1u3NksfbLQXa36u7ff2Y?=
 =?us-ascii?Q?WrBOC3g3LVdT9tmKbvB6NBZAFcSWGgEmlrIEek+QmLRyuLI8tXAfd0iUwdZ5?=
 =?us-ascii?Q?kC1sFXy0m711GL75Dl0AVNbTQLlxPAzV4sh797INy83e1vldJ3TNjZuyepVh?=
 =?us-ascii?Q?9lbJdWBhvS1VVvwngTRd0v0od1vQBVDF8ApVwFkmhIPZ+gZ1QTTrONeb073K?=
 =?us-ascii?Q?pODZPuu1e/ZaaKZBh6R4/0jWSfyfZbnjPvfmrCagU3QDPYSeTf4cyDWAiIzv?=
 =?us-ascii?Q?c4weOvOXGS6dimZWKMk0kNAbF10bZgBuS6ATdyeoGIE4sC9gwzjfL0Y57UFh?=
 =?us-ascii?Q?37ZPGteNpIJvBHtCoLRum2u8/HWfUhooWAtOGUmG5McyrbhQmW9is/2QDODa?=
 =?us-ascii?Q?sw2vh2v/9/a2nMOxEY0j34wvFN71EG8iEQHcY/N23M+uOUuB2InqZCwSBVlN?=
 =?us-ascii?Q?U4v7aLg5IfziYlMivjLuH7swL2o+p+6DxC9agzQhjf0IxZCgQXrGDYw5dIgy?=
 =?us-ascii?Q?tHgliQHCieOfEPZl7JTnQ97kXVjR2b7YK5nsco48+QZnmauFKFvsMSAz/tsO?=
 =?us-ascii?Q?Pn20Oo3z8g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede28046-41b0-4908-ceb6-08dea7c46bf3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 20:58:40.1858 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2wdrlE5U+ANd/exBkebkHCK8SbkhLnam3wssu/LbvOL7jucx4LVR9pu1x1F7CK+0vuXCUoWQl5gdl0q+RZPInA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8360
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

Add a helper method to the Architecture enum that returns true for Turing,
Ampere, and Ada -- the GPU generations that predate Hopper.

The interrupt controller uses this to determine the number of active
interrupt leaves at construction time.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 3ac9cb106bfd..3b45bce6738b 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -163,6 +163,13 @@ pub(crate) enum Architecture with TryFrom<Bounded<u32, 6>> {
     }
 }
 
+impl Architecture {
+    /// Returns `true` for GPU architectures that predate Hopper.
+    pub(crate) fn is_pre_hopper(self) -> bool {
+        matches!(self, Self::Turing | Self::Ampere | Self::Ada)
+    }
+}
+
 #[derive(Clone, Copy)]
 pub(crate) struct Revision {
     major: Bounded<u8, 4>,
-- 
2.34.1

