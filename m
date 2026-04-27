Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB99FF8865
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A88B10E59A;
	Mon, 27 Apr 2026 06:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="a2ngXooX";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011020.outbound.protection.outlook.com
 [40.93.194.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C96210E596
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urBompS6xZdna40yZnSdw1kgLvWNAKX177xhTWVqDKmShxQkE73EBNq9r697kXyuYf57WIYcr8s6w/i07PllK/5Kz3+P+434FDokfkGyyyS1NIfKguhrZgegsZKSFzTUoovoz03jLmd/vzBGZcy4poGwm/CyImMIpRT9+23KgojDPfnoB18Hmkj/GbXnbL0igMoXSqr8g3mq4zc80/qSdXE+4Ia+OxqyiZ86LA/LwbUGPFcMog7WFS7hRZ0kkM/SuH8Wwl3LUXABZhCkXaz2Sv6ljJb4bZZdeL5Tl/2mlM54kFMuS4lILRYZbN2BjJ3il4V+QFqY+aCYx4rNUgNhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dBtH2QWMoAQkV3R96OjYMjhJdhJUHYCobnZUzC4au4=;
 b=fdN37FKxZCTHbFOlZKj62aopFd5aDEfMQhiQJ7wThBeT66ZQqERzN8YZeDpDoIKgssOaHl0WyRYEb5fz7fnPH7yIMRkyEMDxhIaJa0U4dQatoVH+ea18HZJlCz6hSjIB9zTTr/Ou0LY/Qg4/HFE9CMSKsrnaO5UrJPUdNZslm4+R9Z2HE5haHyepiCE6pmkoBNMhaioHJC6h7my74UlEIG3ETRcAuDU5qrkgoNDnCWF8T4H0dnBAlUItvkSOTL9IUpWasXd3COKVNFWU1W2IFPnXuPBOHwjBiiBhkq3LsiQ3XwObIxcK9LSc05fA2VrMoMSRtsIIyPUq7KI1Zap6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dBtH2QWMoAQkV3R96OjYMjhJdhJUHYCobnZUzC4au4=;
 b=a2ngXooXhB2kCG0w9iqfEU6CRzEDwkoeJTyPGp/TpW3ng9rmvqAAQ1rvXVZgBdfJLzgQEbmwMzbFnhsknlLsBWXynjVuinT+8cWzdOyUGFbgWcAKslqY/8REvdMhVqQj8//EoQ391WtnVwBbf4vp3A1uUIUVsefOFtUV2QnONxlyxMOa+zpOfqUOFXwkUp4jmqTN28tscELOH+J3UcddAZ1Jj+bLLHgkqDKl7jYI9ygEal8cKR0IIs2G417c3jQNNpesHf1O/YoCO9SUBf5wuweCRmFaLcNUhxK1yOvdxINvhnezJfvGLtvfwBdt5evcZNbvrybku27XdFf1afxgKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 06:57:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 06:57:17 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 27 Apr 2026 15:57:00 +0900
Subject: [PATCH v4 3/8] gpu: nova-core: split BAR acquisition in unbind()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-nova-unload-v4-3-e145ccddae66@nvidia.com>
References: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
In-Reply-To: <20260427-nova-unload-v4-0-e145ccddae66@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0114.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: b35e8894-8ef2-4947-6413-08dea42a3839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 2DgPbfA8XNF5jrEmGMu+TEzkwe1cQ4i0B/5N32c7xQXBx2Rwtn662NQ6j54EAhh2kWR87PjDgq48Jw66CaW+flH5bUpY+I6FkrN4c2bMPV4WTM4+WG+G3jmPBxVowoqZP3cF88h74m1jaHjEiQ0A/57GDBUhnbrPQIugkUfR2onvpIv5zmzd4ZsMDVuzXnALwuGzQK6N7/ceSO64vs3cTNj1PJDwa0XX3bI3fK25OroB5xQtfeaEcH8dQU+MjtTpzYX1FHU4j40uF/uy1JkVUFWh4sGndcjONsOg69GHEfJLMQ2GDjwZaYOD99i40bd0GtYm0QwElRDaMYgfXn+HmIsfxzEpfjDP9VryNAGcLQHs8xvw4bcMN9BlHe6W9n9l1W9AgYoEVq/ljlPGoQedy/kcsSOCsUJ8ySciYJ5e9pcpi1AFPFAO56M9XmSmI+qFRrpWERD40O1GX/C73+uvXRz/Hf180LtGebnsMwbgbP9iZ3SqzK2aQmUTZQlRvy3+UfqZ6WCHKLZ2/nANeydWqli0fYzASGYp/tox8W+e+YIvPYM9Q/9IDijCiwys89Dd8zeKWHd+bGVP4nHkGNQ2fH2XDHks18Ap4oLdez1aqBQAgcUnz+53QIipGrZ3GZXmTm7QIRArJbqVVAdfJtMuI+n4HcQLegDMdsfS/j/tdZxQQYmLR2b4g0juBGZTc4sS1n5GyMPXNteIpIENfl0V68iNE/gWUYd30aXF7T1Qd9o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGpsRnhNZ3EwZzd5TW9VZFAzMzlBMVdZcjdIaW51ek42L3FZaCt3K2hRSWhw?=
 =?utf-8?B?LzNpVHVQQjBtYTF1eGpGeHZxNXkxa0MrYktFMnQwMWZNcjh2c3Z6K2xvOGhv?=
 =?utf-8?B?SDgxcmUzVmVOb3dPUm43ck9QekNpUHBWSU1vOWdQdlBNMWVxZXltVW9uVWhB?=
 =?utf-8?B?c2FzRCtsK0ppeERIdnQ3UksxZVA1ZndpTkkzZW01Si9aZTRtSWVzRnJmMHc2?=
 =?utf-8?B?dndlMzl5dmRXZTlrWTBkTlNIbTU0bVlVa0IyM3JoZVV3MlJQRXRZWmE2Q0VT?=
 =?utf-8?B?NTUwanlqTnQ5N1FjTFR2Nzc3QmxwQnh5WkdDQ0EwcVU2cGZud3RHTjdnYS95?=
 =?utf-8?B?d3QranlvbGdEQWpzcjVvdHF0R3hrcHROZ3l1bXFQYVhOa0h3K1hsVGlLeEpl?=
 =?utf-8?B?WFQ5MzBQWStNL2x5aGpUaXVpNnNienBlTXV6dXNSaXdnemQzc1NweDc5NDNV?=
 =?utf-8?B?eWZ6Uzc5eTNiMUgwVXNlVlQvS0VtNGY3UmlETnJpUlYyTlJRSTVKN1Qxckg2?=
 =?utf-8?B?YjFpSUI4WjJYNVRWVS9yb3NXZk44ZXhGVGY0d044SVJjTS9PY2p6OW1jNWts?=
 =?utf-8?B?U1Z2UXptQVNQdy96RElMT2UxM29Yb090R2IzOHFlKzM2aGoxTS8raXF2ak1i?=
 =?utf-8?B?RXBoaWFNZzlOaFVmRTlIMGRkWUtZMTZGTldMdDdCYnAzTWZDUWlkWlpTQ0px?=
 =?utf-8?B?Z2VuK1IyaVdDWDk4VlZRT3RFbUtaS2RyV1RhYmFPUVZIMzUyMVIrS09PUTA0?=
 =?utf-8?B?WnJvOGxrYktkbk9FOTk2QWFMVHZObVpOdHBvdStWVHF1dXlWNlhXOXl2S0Ja?=
 =?utf-8?B?RWorTndaZm1KdXFrQ3dMTDBOS29zc0tVY041NUJaUzdLOElMSlBGV2xxaU05?=
 =?utf-8?B?Tytyb0lFZm1IdlJKVlMwS3Vqc1dRRDUvQkJoV1AwQ05sZmQ5VVVLU3QvR1pa?=
 =?utf-8?B?VWxEcWNvZEFWbnNwc2NwTEpyNUJ2TW9WakoxTy9QT01hV3FyRXhTamUzdXBY?=
 =?utf-8?B?NGhpMUJWSjNuZTJyM2FDVkZvZkExNVkwZmM3Sk9TREsybWpEUWNtTmM4dFR1?=
 =?utf-8?B?dVU2Tno0dHBZbnhHaVF2SUpFd0pySmFTOTV3ZnJrcE8xRGFFL2c5Zmhpcmt5?=
 =?utf-8?B?a0NtQTFoaVRZQUZERjIybEVvWXovM2ZPdXFkTlg2NU5KNkdOcVplOGc3M25X?=
 =?utf-8?B?dGZHVDY0dFp4U3dxWVZ6cGtyeTRaVHJvNWZuOXJ6K3hvYVNHSTlEMXlZbytI?=
 =?utf-8?B?eDhkSDBKVVRBdWJha2tuNE5hYkNtMFlWMnR4eVk5ZUZXcFVweHBqRWNWZUVu?=
 =?utf-8?B?UmRTUWlJYkh6TzJJaEVuSFVJZGtWM0NJMU1RUEo1SG1QRkwyWGg4ekZlWHpa?=
 =?utf-8?B?bk94YmZjbEo0UG1YYXBESTR5S1lBclN6dGpxVlViM2xzeURDZnFkV0lkMmho?=
 =?utf-8?B?aXdKR3RNbHFsOHh6MEJNcXN5T1d5TDljb1NQT3VULzRtcmN4aG1NRW93YXFi?=
 =?utf-8?B?WWlZQ2d4TmtUZEJRRlYzZW1MUTJYS0UraWF6RHZ4SmpMZU4xWHpLd3UxTyt5?=
 =?utf-8?B?R0ZyMW1kMGZlU0pDU04yNnRmb3pBM1YvYzRDMGJtaWtNazlwazMwQWRWYWJ2?=
 =?utf-8?B?RjdneTM1eklDcTR0SUFMV0p2MVQ0T1hwa1BhYlZXTVNOWEJ5ajM0d3FSUnhy?=
 =?utf-8?B?TnJsb2tvQy9ZTTBMWlQ5Z1pLV3ZqeDFQYWplZzN6RGxYOXlkaFhpaHhNWnp4?=
 =?utf-8?B?eFI5SG9MZFhnUWFYL2pHcXcvRnloc2ZpWEZXdkx4WHdLd24wdWJGM0FXdFM3?=
 =?utf-8?B?d3p2c0x3NmltYlVMdmI4ejd2ektpTVorQm1PdnptTm9RUEZsaldzdmRkM1Z2?=
 =?utf-8?B?V3lkNDJQL21xbDBld3JTekYxbiszbzc2WmhMQTR2NDA4V1hYVktPNzhQeWZS?=
 =?utf-8?B?aGJEZURQUzkrcklJSUt0M3cyN3hpMjFpM0VtL0dITG1sMXJ0UzJKUk54bTdJ?=
 =?utf-8?B?L3h5NUNrS3NkbXNlclgrS0oxRVRzSGJ4dEdHdXM0NWZwNWxvZHRHQkJqV003?=
 =?utf-8?B?Y09MNFpybHJRMHROSUEwajhlYTlVQXpJbWd2N0xXMDQ5Wktud2xyaHpHQ3pO?=
 =?utf-8?B?UnpFWG51c3p0eVduNVA0MVdPSXhGWGhvSGQwZVBLWDhBNzBtVzcxTDYwSDJN?=
 =?utf-8?B?L3ZkbUJnN3NYdllZZlVoTXJnTmNDZHNHWDlIUzcvQUorYWRHcVYxeGJNK0lX?=
 =?utf-8?B?QnFuaC9lMm9mbkhabURneXlXaFNJQmxMeU8vc2l6SjBJMWNNTHJ0SllZMFpa?=
 =?utf-8?B?eXd1V2NDOVI1OUpuWG9oZGg4K0kvaVJKeitiU0lkRmE0M1FIandjNlZCTXJS?=
 =?utf-8?Q?CkLFDVjjyMVdknOsFsFh9yqwdqQsCpJmGIEg9KNhWACRb?=
X-MS-Exchange-AntiSpam-MessageData-1: ynLqAQibyNYhVQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35e8894-8ef2-4947-6413-08dea42a3839
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 06:57:17.3315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpEXFna37g1vtNLTpKsAcopBNKj/H0y5GUsmtQiUEvf56J5lm5ASHwtF4rlQJ/eT7dJzkRges+STMQE9ezewoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655
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

We are going to use the BAR to perform other teardown tasks, so move its
acquisition into a dedicated code block with a more meaningful error
message.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/gpu.rs | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 233a4bcec9fc..920783362251 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -319,10 +319,11 @@ pub(crate) fn new<'a>(
     ///
     /// Note: This method must only be called from `Driver::unbind`.
     pub(crate) fn unbind(&self, dev: &device::Device<device::Core>) {
-        kernel::warn_on!(self
-            .bar
-            .access(dev)
-            .inspect(|bar| self.sysmem_flush.unregister(bar))
-            .is_err());
+        let Ok(bar) = self.bar.access(dev) else {
+            dev_err!(dev, "failed to acquire bar for driver unbinding\n");
+            return;
+        };
+
+        self.sysmem_flush.unregister(bar);
     }
 }

-- 
2.54.0

