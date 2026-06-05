Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CB3CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 08:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F13C110E4BA;
	Fri,  5 Jun 2026 08:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="MBvdhC8U";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010069.outbound.protection.outlook.com
 [40.93.198.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E45BC10E4BA
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 08:32:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k49ITvnuw6hhuGVMObHy/06bcJI+wAGMr8RMqE+u1Kiho9l6AWLT4JTDgBdTp5v9iDG+9Kyy7jhWwqhg2mASxjLP+9GA28mIla0nuBmpVUY0DrT8YgJ9RPWI/zoWZ0mnDHtdwzc3wq3kqVFuj6n/JU07x+5PwN5lM20utSny06ZhdRL0J5NTbqCp2Eqdn/3x5IWTjCEbgHFayCYAwgMiUY0w2iuYr3TEuPJtVm+4wCXQRyvohY0aeXEwoOVCxChfZPN+PmrJDjQlalZM5LHJFCs+Qppghvr5ZpPzSX3TIHjKHzo+ixDoP15NZ3T82TZh6+VEdI5GHn0PdJ+EuNOshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTgL3s2k4HcV02O0BOGTYGIhF6isKW1AGP+UQ9A3JEY=;
 b=FekLHA606vgHYiSHdus6k/mtt3S4K8SAGgHO93vF7uMS9ADbszTmsOsTZk5bVa4yowzrbLwRZLeJ+PgFUAC5ZQOXNY199xbQsvcUmv7pxyKrF24f/KcT3akIMqb+M0Eu/iwNvq9dMY7EQ5dW88YeT8Do+lK0SgWtr7pD7NYP5kpjNGS3WrmwKEDakvpULmwAIdw5mRqChU3Ukro3ZjYPFQBf8ItWXC30joTC9GVQ61QKUfGFIL+YTt57+pbX2nNtittSn+LV6z8FoJexafsHlE2IrLPJZOZm7lJOIqRMmz3wWqa6yviXLTAcPcGqyTzTxHPS9hQ0vsCy7vpzyPj6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTgL3s2k4HcV02O0BOGTYGIhF6isKW1AGP+UQ9A3JEY=;
 b=MBvdhC8UZ8lowRDtqBB3kijTq2vV3TENY63TWG+FVQ0t3x++wNIUjjzlrrQ6cPWR2/C3WNIfSE7lfh/7YZRWBkdg7z2eNySDs3GboKoPR3uq/7SVvq3pRMQfNtCWuQf9I+cm5L1svPBLvlfdkvlFoXbgR+L/QLpeOLYh6wzukGgYTAkMSYCBkQLVJNqy0usnLx9MJyfCumvOueVlGfkzGxqAsq17dtCTT+YHW0JO9WM5JVDfQl3YhVwFHsbijjm4lQYJ95WwcTOyR5XyLdqDwgs3CI4g8xEsEJmqO1IppsThX2DHPW19uTcXvM8J+pBn1LT9ekS3jeXO7H2WeXY05A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8911.namprd12.prod.outlook.com (2603:10b6:610:169::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 08:32:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 08:32:15 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Fri, 05 Jun 2026 17:31:52 +0900
Subject: [PATCH v4 2/6] gpu: build nova-core and nova-drm from
 drivers/gpu/Makefile
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-nova-exports-v4-2-e948c287407c@nvidia.com>
References: <20260605-nova-exports-v4-0-e948c287407c@nvidia.com>
In-Reply-To: <20260605-nova-exports-v4-0-e948c287407c@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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
X-ClientProxiedBy: TYWPR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8911:EE_
X-MS-Office365-Filtering-Correlation-Id: 53f17529-dfaa-4eb6-75b7-08dec2dcf2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|366016|1800799024|376014|921020|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: k12Xcza2EwRjyRZ6L2Cp5lQ3wd7zVyUt9y7A+kYbV8udv8GnvNXhuwizwhVNc6IJzR9JaNrwfegzqyeS2c+y6dyrNOCcn9NRWEmG9jGEqr0wf6kjUiyODyTl4Z6Hl/FS4GgDusH7yAhTyG7oP69tj9ohwEKPa/VJ+H4AT+HJaInIlAyHaVnBo5eVt05utfE8hVuRc3sGleYqUxOxn+mNoemEghw6nuhCXrNBwdm4XaorORmEDDbEOdBwz+TxdMfPQwn11OuoueIPzd+x6bZ5IiVofWAcN37rVqfVjmSCMZkuK1L1W1Uwi1ZQeAIe6SoSQrizerjzr9ydtcvv/Vg59ViFqOMrIGKW+1n5cCe3e/adRxpZ9oZ+kL6CJqq7ABDn+ZYB81qgftv/IWRaxLcr0U2OnVKl5AnQXJwzKUFU9MRU/0tg4KE1i0SUGpZn2BTxYYjN7cvTu+FpAU8iKyi3e3DM4J/cwKrEXbKl+uTZrbyExi3+2opvvObIR2NGCrtw6q7C7/8fjK3RPcRRLOPKyuNq1SGjSSKM7Sp1OzoQK9hHceUXoa7QgxgAp6QiJ0yA2M8p3TSgYuN1+bzuuOiKMLymrXmG3jfx3X0G76CLjte9DmZmvofhg9DU69Rtc2DVVwXyepdlanmdck1EjLbmCIURv4hkzm/F45HsHhe4Q+IhKetwBtmM58/1wDyzinRvz/PlTvtN+K0nqGNG4ynlm/Y2URB1XW3Hl6IcvPf9E0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(366016)(1800799024)(376014)(921020)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDZMdjR5YlJqaU85UUZqY3RJRzc2NUl1UmxoL01lQktFK28rSCtlTDdnTVBK?=
 =?utf-8?B?MGIrNXZ1cUJBWStxMW44UWMvdmlhYnVQT3NPdjlUS256UC9qS21Bc2FVQUdZ?=
 =?utf-8?B?bCtFVFdjcjhLZWpUT1l3cEo0UHpXcDUzaTBvRHM1M3lJR0tCRDgvRlFmbEJZ?=
 =?utf-8?B?TkFhZTdWaWFjMVBMOEViZ1JISGEwWHYxazhpVDZKdDdjSktjTDBQNVRDZ1I5?=
 =?utf-8?B?S3lhZE1xcnRPTXp3Ly9YUmdVbzJ2b25HdFIvUFphc1JrNlAwcUMwOVBPS3pX?=
 =?utf-8?B?R0VFaS96Q3B5aTMyM0o3Umd2WThDWFo5ajcxZHN4ck5VZm56TDdSUjQwN1NG?=
 =?utf-8?B?ZU9ldXZGMW5vZ3psVUdTQ2Y3ekpEK0Y5TXUrZVpOR3ZxVTVBMkE4SFRqenYv?=
 =?utf-8?B?dThyVHRDdURzSEM1SnZ2aVZoQkJDTTVEWlNCbURFQ0ZzNEFxME9iancxNFNR?=
 =?utf-8?B?WnRXL0M5OE4xcUVvMlkyazFWV0tYbllyZHFocUxuMFF4ZWh5Mjk4L21XVFBB?=
 =?utf-8?B?M1A0dUNGVnBETVh4RENud2pQcG94L1kxT1haUlBpMlcwT0lXYnB2SEpITU1q?=
 =?utf-8?B?cUlzRXI3ZlFweDJKY0NENHVzSUJVcVhaZm8xanpPRlB0OTVEblVZTHRvdThL?=
 =?utf-8?B?a21pYVdrK2FjVWdRb3EyWGc0TEhmOTB0ZEtDTWIwaTYzZHpWL2JWUlBEd2ZO?=
 =?utf-8?B?K3lzYlJpeitDWnAzakh4amE1UzZFTDR3UnhkUE1hNktuVDNGdGlWczFNbWMy?=
 =?utf-8?B?R1dUS1p4ZzBWQ3VnelorWFF1LzJvejRoRkl2anYyWUtQVEp4TEV0OGhRWEhw?=
 =?utf-8?B?bE45aFRYTVhtbk5qMVY5dlBIYUxkdDRRZFRKMis2V0NsQko2anlSdEdpbEJD?=
 =?utf-8?B?dlBFd2dveXJnZlI2VlEzVGNCSk95LzhJUkdncHc1eHZpWlpxbmhRRkc0cy80?=
 =?utf-8?B?dGhFQUNTRGM5aGx5NVplVGdFVFZQWEpuUW9vYTBuM2NTdkQyVzF1VU9xc1hr?=
 =?utf-8?B?bnZGMEcvSzFwaG1WRTRFcGlPdXdyU3dJMEhCaWoreEk2Ulp1T3ZlK2tGNVBG?=
 =?utf-8?B?L1JTejRUMTJhcG9XbEd4Z1YzMHh1emhMbjVXN1U4WlAvNFd1TkJmUGdjc3Ro?=
 =?utf-8?B?dWlLbHhPM1RVdzVPbzlqSzBvaWZTejgyUzV6ZlcwZ09kSTZBbHlaN3dLdUN5?=
 =?utf-8?B?SGs2cnByV3BPQTA4STE3cmF5ZWhHWWJXeDYvTm44WFBqTzcxMFBmQWRINlJk?=
 =?utf-8?B?cXBMYlJwWGZqdDFFSnZjUEFrYm5RbnpjaEwrVHBEdzFPSVpiVm5kK2hLV1kx?=
 =?utf-8?B?SnBrRCtGdVh0NkFaSW9BTEZFNVVHeHlyMG1VUk1uWWoyZi9Yc0djVUhJT3JO?=
 =?utf-8?B?TzBRWFAzbldXLzVJOWJ3QWp2cm1WU3IvZjJodWIxaXZPVUl1QlVGc3hieDht?=
 =?utf-8?B?azQrWURFSGdHcS8zbzIrZ2tFWXg4eDNnZDU0c3ZHcTBlSi92UHliMCtoamlE?=
 =?utf-8?B?Z1JyeXhuako0M1p2SjRtNWtwLzR2N1FmWlpQUmtsTkE5eVRER01hbUZFQm1D?=
 =?utf-8?B?SDI1WnNmUjIzN0w5RDd6SUN3WVdnd21UVW5WYkN2dzhEaktRenVzN3hGMVZK?=
 =?utf-8?B?cVE3MThFaVRlRWx3eldURHlFSmpQa0RaOFdLSlUwZFJQTmNIRTZSWGhFemZz?=
 =?utf-8?B?REFqcEpTMkllY2lDcVdLa2dDUDYyem9CU01NNHRCSDhzQmErYUxEQm92Zlp4?=
 =?utf-8?B?LzlLZWRiNVpKYmxJQ3BEWXhoY0MyemZGS083Y2NYaGNDNWN6U2dicTV5eUsw?=
 =?utf-8?B?TzVvamhvRmcwZlFuTm04VXV5OVBoazQ5dnhsTnd1dVRPNUZHbTljRjlneWts?=
 =?utf-8?B?QzYwdEp0eE5lMmlDTk5RWGpDankxWnB1WUFDYjkxSnAySTkrQklGWGhzM3NM?=
 =?utf-8?B?ZmFNZ3lzSlduMG5LcTVtUGJNejJQTmNFSzFHUno3TWJ5aWxhTVpIaEpSSnE5?=
 =?utf-8?B?MTJjWmN0a2ZIOGtld2dCSWF4NWhsNUR1a3pJSzU2WEI2cmZXbmRrVDA3Vytz?=
 =?utf-8?B?aDB4T3RVSGZNK2Q4dUFhVUU3dlZWMWwyakFPMEtHd05FOEtJL3ljYXN0MFFK?=
 =?utf-8?B?S0FjWGxreUl2L0xCQ2o0WkRUWnVaQU4xN0RTY2tWZjRkSzkyUlJDQ1pEbVo1?=
 =?utf-8?B?dWFFUXMxaTRId08rZnBidGpRWUpERFNPVjZicXFJaTJZWmFwNk81TWRrRzZL?=
 =?utf-8?B?T0xNb1RyRXM4aVpzN2tFcEc4SW54VUNZdkcrcGRNM1hlUWhjWDJVbmtQcFE2?=
 =?utf-8?B?elBDL3NxUDZseGd4VGo4aVdMK2JteXFqcGx2RWMzNEJ2SnBHUHRwaTd1TGVw?=
 =?utf-8?Q?n9VliY1ipUMHUxtLgvpBn8J8qXbq4bxKodeaDv++CcFjr?=
X-MS-Exchange-AntiSpam-MessageData-1: qwEnoJNIF4C6XQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53f17529-dfaa-4eb6-75b7-08dec2dcf2c3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 08:32:15.5947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWbeKkz0jp8MAgAW6LI79LN/ocW6xQPvSrT0pSeQUj+TsPJZLs6/V9EGRv/F6QHe6OlurYfHWUWYxvjD9rbm3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8911
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

