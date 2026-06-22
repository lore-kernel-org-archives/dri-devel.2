Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F403CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9FE10E6E5;
	Mon, 22 Jun 2026 13:30:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NQKKjR4j";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB1610E6E5
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:30:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMuzLeHzxPzfF62DhsY3rASJsByMTskbw1Gm2V4wPunJvqMGj2pvKIY1LrxxdxhqR/4NO7gdaY/b5hrsjCw+1n9rjiy78RqPkkI4bP9cNomiAm7lzSaNqfPuP93xExiMma1t1TboHevxehc+JZGfhYPsEdBbqlVywk7N7hm83DB0OuKk/n5TCXnCy/2P/hCJ/MuQ/Z4eOAMmpaH+rh8evz3nrpxEqmPAvjKRKpsoO4Bn1jcucysDNRr5LezAv+5VaLt3qpHiICPiy+/PAESm5A/CrXB8TRsN6bzSF+pIgCLTdcfiPhLRYW83iQ5pXDieCgnQ2tv78BLLeS5NerfQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTgL3s2k4HcV02O0BOGTYGIhF6isKW1AGP+UQ9A3JEY=;
 b=ygsRPPLme8EG+6k3aG+hYF69mah88lPDTcvbkVh74v0tw9T6t00YYnbxRaK3BQvCbz7OScjPq6cVAOeUH5ZPxDqY8TY5CQhvtn4BfjtjLGEAjA/bFmRjY3cQK9AHFQ9UUKTFuIjiu8NIo4lTjz9AA6XdxFRSKA+Snm34vap2SVXEZbLRlq7kNcwPu74eWa59QBgiuYGRLLwGCfUs1ZI3DeZoi78NYNlRCdfBPR4bYJ8tXY7r3ETkkluM4g3NuYAPo1SzMKWhg1bdgjjsuAsgmaoo4zUN40lzkh1PA51Y8RKWGw7PpEQQDhdNa9+Xczy/VmVftXW7pQfxrL9WHtFg7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTgL3s2k4HcV02O0BOGTYGIhF6isKW1AGP+UQ9A3JEY=;
 b=NQKKjR4j//hmbfzHH+cRj7qKQIIqZenfgV9wD//YOe/Rome/PFWAKaqgzx15V9TUC7kQ8o24gV/XhPNQp83hafg8tF507dA31nw7AktHrQTNN9D6xE2d4LwVwqv/ESrw17b4PX5Lgu1fYjE0ZT/3+hfmxnQ7ujuXQK5PS0QvfvccRtGPoKjyDtgRz7xRpk1QwdlStKaLzWFgkQolnWxB80yddbm5l9BZM33jZZiRm9Zi+oe2u/GTp4GTsvmxre31oy6DFmeD5yTA6aLYx+c+KahAPyYYyfMPZ2JHeYEGyw97SR0Y7pbeZezOCflpt+OuUCfMEXfx+uokImiXCnd71w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 13:30:38 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 13:30:38 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 22:30:07 +0900
Subject: [PATCH v5 1/5] gpu: build nova-core and nova-drm from
 drivers/gpu/Makefile
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-exports-v5-1-6191773fc977@nvidia.com>
References: <20260622-nova-exports-v5-0-6191773fc977@nvidia.com>
In-Reply-To: <20260622-nova-exports-v5-0-6191773fc977@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: 3478816c-b484-458b-006c-08ded062729f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|10070799003|376014|366016|1800799024|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zPU3vF2PdCPjbe5GlrfDKLPGOui1Pdg7DHo577QiocaO+D0l21/NeyPCd61pmIKPcrFySykdfrzMpT5ijuiGpLDDRbq6FUE4IypDGndQ6p0+exIF7/5XZxwkWEy0VYAA1ZmJbmKbVrFcqt7zj+LUcsGfm1wz/585H/K2xH31nNOU2Cbaq2w/H6c/1FbquhLWbETbkAMWUg0Gh/AX4go+23mKfeKbEaNH+4DN0XHnPgPv4jB8AN5DpR3Y+5xDnC0t3V4qI0xsM4tUhorGdw96GI8lcNgAG55OH+6j6C+MssEJ5e3z0Mizz2gz3cVutC62HDP5RDLiYNbifgZb8w7ceq5OKRNnwMw/OOzPhRds1jM3DqLASiQf22p1W8v3C7deHnZMQjTXFS1mXCjVA2ZxvcTl6FmhiJD63s/7QKN785EPHkskRK8vTu/wEiG0H1WEXsAjp0n0sKiQpSi7UIvVVkJQJna4GYI858P4QBuMq+c+LkO3rHu1yw9vPbgbGl/Z9EujBwYPyXN0dChQoHggl/1iIC9PKdv1ZoLLA4rU1aphl9uDdfJF/uoVfDChZ4Y51iX91M3R4Lh34AfTan+WzItBYSEtwaZF9awjz23eA1sca9VT+Of3pnn2AfGKiynIPVnmY8/22k9JvsvUAuCgfCNk+D1axQr2pvMnXp2+PrZuyznv684joGU4b3RWtOT+LmkfiwyrDgGxxFa0tHJo/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(10070799003)(376014)(366016)(1800799024)(921020)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXpEVVBEc25ReW91V1BDMEhlR2t4NWpmcHdtbThkb0hDeXVzNUZrZWxkTThL?=
 =?utf-8?B?V1l5ZG5EYW5PS3Vrb3RnRzF6RDkzN0JaZHA5RGFqaG1lSkNuNmhxQmxzRi9o?=
 =?utf-8?B?WVRjQWVMajQyNkk5ZE9WT2M1aThCOGt1dTdCTC9NY2hKc0VhRElCV25DWmVK?=
 =?utf-8?B?ZWlFOHhybTBUd0JOTFExN2o0R21zbmtSK05MYXFhOWprWHJyak5kNkVMUjNa?=
 =?utf-8?B?UnlSWkhWaWE4NGJ0THFDSTcxSXBKa0x0WlU2QVl1dmpnMlFxMXh2VVl5UHRn?=
 =?utf-8?B?alg0RmJ5Sms0QmlRanh4cFJ3UndqN1pvdHlHeVRxWTgra1FPMSszSS96RUVJ?=
 =?utf-8?B?VmROTTlLNEc3TXZSL3VzK2d4RzBDQ2dTWEVLRnN3eGtuak9SR2RUbm1ua2lG?=
 =?utf-8?B?Z2JXcGNCQTVTWU55dHBOSFdadUZJR3pCdUdTcVlMT3o1WklweUppQU9ucVhD?=
 =?utf-8?B?U09oV2RZZmlIQWFPRlVQRGNlYUVNcjkrSlhsOFdPSEZKT2JRZVArVVgrc2l0?=
 =?utf-8?B?Z3ZlZ0dXcVNJVVZCcGFWMFptdFYwVkVCYm1TRVhJT2lTb1l2RHduRFVZNlBq?=
 =?utf-8?B?REhicmU1YjluQzMxc0t0VUZxVVJhMHdCTlJCb2NPb1psRGxwSXBHa1dNTmdC?=
 =?utf-8?B?VUlSZUhRZWlnNG0zOGZpczhwVk9XNHNHSmFleVRoSjljcFB5aHNBS2pPaFJR?=
 =?utf-8?B?Z1VQN2NLdWxiRlZTZW1vTUdBOEZrY2xjMWN3SG4xbTZ5R2RTaEhUWjJmeVNQ?=
 =?utf-8?B?enNpMW5DOUZBN1l4TVpzbmptTWl1bE44bEVLMTFUT3ZJazc5V2ZCSUxZZmV4?=
 =?utf-8?B?ejBzM1FydGYxeEZGanc1bGpmemFhNm13aFhTUFE2STdrWnVmUU8vUHVrMk1D?=
 =?utf-8?B?Mks2RXhyZ0VXUHJLUTVDSzB5MTJyTEgxSm1la2kvVitLaE9oeVRNSkN1WHZw?=
 =?utf-8?B?QmJyNHQwNFpYbnYrdi9oL3ZPU3lRYTRjVEF1UWw0enduRE9EcDN1REpPZm0y?=
 =?utf-8?B?NnovTEsyRzNOU0x2UUg5YkJPR1orM0NKRGJDWDQyOUlWdU5EY01RZWg0eE03?=
 =?utf-8?B?a1pzRldpYVIvZnordGZubHVUMDY1UnI2RjdoWW9ndjl1YUU5WWp0WXpsc3hW?=
 =?utf-8?B?VEd3RzdhMDdSUG1YZVc5YjZBc0d0NUxheWltdWI5NHUrM1BzaWl6bEpiT3Jo?=
 =?utf-8?B?MkQ1RWRqR1U3d0dFRmlJdjVDM1EyVUdBQUlxa1dtbGIvVlZKb2lwWk11T3lK?=
 =?utf-8?B?QmkyZzV3QUF6UkhaQnFBNDYyMHRya05MemoyaitCK3Fld21ZYmJPaldZTkI0?=
 =?utf-8?B?SXBmdHZlaWw0LzBnM0xpTWJUOXN5NzdlV1NrRkJUVXpsTHJIeEdxeTEydHM2?=
 =?utf-8?B?bjZIR01sMWtFWTBTRkZVcmlKUUw3aHl5U2ZBekFLRHYyQVV5cUdnTGRDeGRw?=
 =?utf-8?B?VXN6MGFtdmZielVqN3dqaGNNeDlham5lVFJBV3o3dGFiNGJTY2I2d1g0dExB?=
 =?utf-8?B?TFVrWVB5TmZRbDMvT1EvQU5QV2ltSjFKeTFEQ0QzRHMwOFhrY000c1AvL2J6?=
 =?utf-8?B?Z1AyRlFYTStlNm5hajZZVmZQYk1QanJHeElyQ2ZJVzNQbWF3bFExV2JxQkVQ?=
 =?utf-8?B?S0tiQjBYbGV1bDhZTUU1cmpUQVRlQkxaMktYUWpaTWNmQVhKNkNTOFlMc3Jx?=
 =?utf-8?B?WXpkQzE4RDlGL3hoMjNOcUVwNWk0TFlPem5Yc0RtTkp5VnVQTmVkSUE4Zzk5?=
 =?utf-8?B?QnVTM0YyRUtFeVU1bWlBZE9vYTdXTjV5MnFsZ1NBbkd4bCtibHJReWFrVm1i?=
 =?utf-8?B?TWZmVXdzcnlDNXg2Qk8wbGdUVFZPZS9aaDdMQU42bjRlVTFzVkdMZmlGM2U1?=
 =?utf-8?B?UWg2aXJzVldmN2lhbHRtUmVBVFc4M1FJZHQyK0dGSSsxQ1NKb01yWENmNDFl?=
 =?utf-8?B?azZlU2NFcWMrR1N6YUFicXE4S3F6NGt6ZllZWU0zMDQ0U1p3ekFlSUgzK01H?=
 =?utf-8?B?eEZLdmQ1enFmcGM5elZwR2Q4MFdHWGdGUWZJVUJ2MTZEbzYvZVQyVU82T0pQ?=
 =?utf-8?B?RURDNEpVRStDMHFRMlc0QTJxZGRTZWVUOEtoTWJSM1h1dDhiTFl3SFBueGR3?=
 =?utf-8?B?cVdMa3dZZ1Y0cUdqRTNIdkt6cno3eSs0NkZ2dGo3a2I2dkt2N2tLUTNZRmtW?=
 =?utf-8?B?MWJoQU45Y3JZMENIL0I3Q3N5enh1UFVFVW5KQms0bTUreXJUR0wzUlIrL0VP?=
 =?utf-8?B?blRUV1JCNEYzaWxyMjJVRTFFNjNwSCtJeG51WnFDT0JmQTZDMlA4V0U4TE92?=
 =?utf-8?B?eFB6dk1rMDNVVU1jWVVMYnMyTURnWWMxVUVmS1dYYkdkbThuekVLdWdZU09m?=
 =?utf-8?Q?b7Smv1ajJHmw0FG6YQu7N29Nzj+/uKxoQXsSaAUmfmJJy?=
X-MS-Exchange-AntiSpam-MessageData-1: 4Szopf0FFcl1FQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3478816c-b484-458b-006c-08ded062729f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 13:30:38.3061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ec7D54FwJWHhKHTncMH2y+7BB0QMLQ6rfiZeOJkdmthExCi23aVFbi1zVxQyewNEqysISTfBbodDmZKa1WJ9zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774
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

A dependency between nova-core and nova-drm is about to be introduced,
which requires nova-core to be built first. As this is not easily doable
from separate directories, move both build targets to the first common
parent, `drivers/gpu/Makefile`.

Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/Makefile           | 12 +++++++++++-
 drivers/gpu/drm/Makefile       |  2 +-
 drivers/gpu/drm/nova/Makefile  |  4 +---
 drivers/gpu/nova-core/Makefile |  4 +---
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index b4e5e338efa2..45e0941324fb 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -7,4 +7,14 @@ obj-$(CONFIG_GPU_BUDDY)	+= buddy.o
 obj-y			+= host1x/ drm/ vga/ tests/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
 obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
-obj-$(CONFIG_NOVA_CORE)		+= nova-core/
+
+# nova-core and nova-drm are built from this Makefile so nova-drm's dependency
+# on nova-core can be expressed as a plain Make prerequisite rather than a
+# recursive sub-make. This is a temporary workaround until the Rust build
+# system supports cross-crate dependencies natively.
+
+obj-$(CONFIG_NOVA_CORE) += nova-core.o
+nova-core-y := nova-core/nova_core.o
+
+obj-$(CONFIG_DRM_NOVA) += nova-drm.o
+nova-drm-y := drm/nova/nova.o
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd783..e635fcffd379 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -186,7 +186,7 @@ obj-$(CONFIG_DRM_VMWGFX)+= vmwgfx/
 obj-$(CONFIG_DRM_VGEM)	+= vgem/
 obj-$(CONFIG_DRM_VKMS)	+= vkms/
 obj-$(CONFIG_DRM_NOUVEAU) +=nouveau/
-obj-$(CONFIG_DRM_NOVA) += nova/
+# nova-drm is built from drivers/gpu/Makefile together with nova-core.
 obj-$(CONFIG_DRM_EXYNOS) +=exynos/
 obj-$(CONFIG_DRM_ROCKCHIP) +=rockchip/
 obj-$(CONFIG_DRM_GMA500) += gma500/
diff --git a/drivers/gpu/drm/nova/Makefile b/drivers/gpu/drm/nova/Makefile
index f8527b2b7b4a..b9fad3956358 100644
--- a/drivers/gpu/drm/nova/Makefile
+++ b/drivers/gpu/drm/nova/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-
-obj-$(CONFIG_DRM_NOVA) += nova-drm.o
-nova-drm-y := nova.o
+# nova-drm is built from drivers/gpu/Makefile.
diff --git a/drivers/gpu/nova-core/Makefile b/drivers/gpu/nova-core/Makefile
index 4ae544f808f4..4c15729704a1 100644
--- a/drivers/gpu/nova-core/Makefile
+++ b/drivers/gpu/nova-core/Makefile
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-
-obj-$(CONFIG_NOVA_CORE) += nova-core.o
-nova-core-y := nova_core.o
+# nova-core is built from drivers/gpu/Makefile.

-- 
2.54.0

