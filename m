Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3BA1C55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 05:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06AC010ECD7;
	Wed,  5 Aug 2026 05:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NU9XoxS2";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60FD910ECCE
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 05:45:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcZtnxl9GDlOIjh6FWZCuLZSD19OIJHR2sNIzyjyremr6v7HS7v3lSYMsotewqJOoyi1Gyv5PwLhmJlZttyKSyqE3rP2bXlJ1CtFM3cCROO4nUakboQjOaDaa7vkqQnzD6qWgGiwb7oh5ZYv2mG5ClQdgr3qCnjOUVt94owi512QSfD7s0gHrkox47I9xtvEOWkA0jOu+JAuHKBZN96D0hHcZ0P08Cncj9yv/sa+026CeuUCITwt5gzjXPLT9bC5nqbuGG5Bhclq/f9J9Y7smcaW9LkJqVbST5mrid8kklbfuaWXtWqKBQCf7a9EaUowvjvCva2Gj9VU5xqoHR0+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwIT6jboVZOnZAfTzZt2VSrOoqfi8wp7SdzzIaMrz6E=;
 b=xc1Tegkh1YmcU2tZhe26njBdg8gRmzGEvDxN1Nrrh5RE5cu9dlxfhjFsW6JMv8TdBwzVgoDFvNPEbgVRTlnzbrIehyB2hHj/Jkmu8A7eMeobzy7fOGdVRidTW8+roC+k9vSeK33PgW5bgeaVbxuJgj5QwV6SANSi+3hQ1vcEcQqh8oDryKNj6d6BXHiLO3kCtyAreYB+szAMiuGh1wFX2ffINIcoLspqkqVxYpGk0CsvIJVFM9lZpEHJfsEwunOIeCp334QFGmKB7HVq5yn50CzFtegYNlb8pYsePujLQYXBQCDusv4h9y8DEl2nQmxLeB/wZ3ayILqXPPLGsIrI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwIT6jboVZOnZAfTzZt2VSrOoqfi8wp7SdzzIaMrz6E=;
 b=NU9XoxS2k6zAwc4thpWgyTDkN6X70FJ1tO34j7Duvy2xsJr/y9Yp2JYQocYj6o/kDp9LRYpeu0jkxJZXqztikAHwylvJfSR8aYlJg/n+CMx7QRg6HII8+JasC/uoG0bgEqc4/cVA2/C8ypOiNS9XRQYx6/o8Y1zGeFeyK/J1G7/JFQBVmLifLdNQfgApSTQS2Qpp0QB0m6TI7miNYf/CFFRtQ0phjO4HTYua7nn2Rjg4dHfj5KZteZtA2ouFRwnZywFKBmEpw+s4D2VzHIJmUEOMPpIulN+cxEiF7GnBN+uzsCENG1RDz8F9McBGUohwA6v0GAbh+ewjK0+np7oufQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYYPR12MB8989.namprd12.prod.outlook.com (2603:10b6:930:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 05:45:47 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 05:45:47 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Wed, 05 Aug 2026 14:44:56 +0900
Subject: [PATCH 09/12] docs: gpu: nova-core: Document the PRAMIN aperture
 mechanism
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pramin-split-v1-9-ff3e84a75dac@nvidia.com>
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Yury Norov <yury.norov@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::12) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYYPR12MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dee8f70-c84c-4d90-8033-08def2b4cc68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|6133799003|10067099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uZypJq9IZEyopNP/9vKNriMWNL+6+DQPaCaaMBdUrMrWh5+6n9hQg5IlInqX+uE0B8cRom0y44DfWxOnOmOFGIMxbAyxVHTNgOyL+Mfhe/6a6mmI+SGkJoLsatyECmsZjv3tg8QHVgnAkMzEQiEH2YVaY6DImAIkGePBnUSISh5OX9gV/0a+/SKGcngR2wwCKrUJFA3uWy7Kc24O/JBtTYKoLFHdFYo+Hcd5hRLzTOJ5XWsGpt4TivkyjBMoG8YE8EAvzrMV48alSWACSu9KYiN5ih5NVqKBp2ZIc1I7YxEt7ewi2BA3IOx00BA7E0GtRhalqncrd8p0+oGJv+6OVnzY/nzqLBczApWXZ7gEukmLGAWTURSoUVOTqs4ijgOzk3qhZPAe71/jkhYWFT5lMZVCNt9UD+KGrl7qzReOx7s1rQtknbimuOkta4/R3lFmru9cQRyvAffAFNHAEKyyXrTzEnOMeITNinSf4fW6tQG6Gt8mM+HlNEdv4Q/ErgKJ71OJ0gSoQrHG3ohgj1/sD/o7CmyEkDZFtrVhRg/IhUtS651NwcVE8Nu+rKCNuc0BxIxhuUPDcUckO5+nTRIg6SXQbK9rmCRGDr9uKBB4RZdMERiKV0BUxaEequQyPV3qKLmFHl6ksl7Tafz7NAvwP7stbYMybV11iFPYyVM0g0DidoO45LhNxPJY3U2KinxRB0CQHyWs2OD27Qvnv/UYiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(6133799003)(10067099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sy9TcHBqNDNkWVZUYnUwVExQVHFwQWoxdjFVMUN2Zk9HMmJNano5S0REb3Va?=
 =?utf-8?B?TlZ2cTJzc2JZUkdCYkJabFlxejVZelBTUkYySSs1UHY0bGVXUWlCZE5wOXIz?=
 =?utf-8?B?RjlBVS9yMTFrYkc2QkwzQnBPY0ZWZjI2emkxZzRuczR1SnUrbzZqQWgrQnc2?=
 =?utf-8?B?Rjc1VlJVMjRiTnc0MUl6RDJUYWdyMGJmak4xUm5tZWFwa3ZFYkJ6VDcybzhk?=
 =?utf-8?B?UDVTeTlWNG54N2Rpd0I2NGRSV1lJUEM2SWpwNmRUem04WUJiZXlibGtrRW9X?=
 =?utf-8?B?MTYxaHZPa255SmYvYWxUQnB4WWNsSGt1WW9xWmR4SFNDY1FOOG9CNWNLSklG?=
 =?utf-8?B?alpnWmxpWFVvSHVPYWFCeHVLZVNnQVdnSEhwSmV3R0Q1bldJY1JsWWdZWE9l?=
 =?utf-8?B?MzF3VkJyY0Nyek5CVTMyUWZZTnVYTzNrK0k1ZXVuZDJjU05EYTFVMVEwOER4?=
 =?utf-8?B?REFuRGtybmZHYTNmRFV0eXNHRU1RTTZwSm52YlVXdzdvVFFhV2J3NkZmOWx2?=
 =?utf-8?B?VkhvdklYTkZlcDh0VzhiRlFhWEx5NytMT2tDVTZPM2VOMlRRYm9YejdMVU12?=
 =?utf-8?B?eDN1d3E2RWlZVUhmMTZsQWdDeWREZEVTcEVudzVnbVZkM2VkeVREV21zWnFz?=
 =?utf-8?B?eml2TVpOU0ZKZ0NkZVg5d3dlaGdtaDh3QVB0ZTlqUkc2TXk4RmxoeEYxRkFJ?=
 =?utf-8?B?YjltWEtvVEhCKzBhaU9obEU2N29jeWJzdlloWUhmblNZMWw0Wm1BenN1ZmNX?=
 =?utf-8?B?eCtPSkhOUmovU1Q2WkFnOCs2N2QrcXhGVVVPZUJTWktiSVY4QjQ0ZzBzRFA0?=
 =?utf-8?B?b1Z3ekRobmEvY2VCUXYyZ2hDbGtvS1M1bU5lYkM1R3BtUlV2ek81cENMQ2lt?=
 =?utf-8?B?WFpTV2N5S3Z5WDNwQjlJOWlRQ0xDdU55N04zUXBqTWtSV3NRbUFER09nYlVx?=
 =?utf-8?B?dUpuMUs1ZE1Ccmg5ZzdMTXgzV3VTaG5JVkNUMGdJS3FGVHNhMU1WLzRUQW1P?=
 =?utf-8?B?ei83eDRBcTNsZVV3RXpLRzZEUGhNRklzT1I1ejVxYzc4QTV3VTd1WXUwbEZ5?=
 =?utf-8?B?REs1bDNkUHZzelQ3TnJ2TmxDcWwrTEtVT29Na1ZHeWFMV1U2TTIxK1ZaQWhH?=
 =?utf-8?B?T0FCOEt3YndXY2lIZ1hyMmErb1lQSDFlSm9qWUZ1N2Nod2ZKUkhqY3hxVi9R?=
 =?utf-8?B?TWFKYzF3OVRSYmo4WjhoZGFEOGtPakNIZGdiT2doUktlc2VPSVRSSWhPRGtj?=
 =?utf-8?B?TWVJeFhqRkNHZTd2SE4xUitGQjByaUtOZVhqNUhkYjEwN0V2a1IxS2pyTmxp?=
 =?utf-8?B?ZmZmdmNrcXZnd2I1UjdxVE5zQVhwd3BlTWpDZGx4dHI0dzlhOVlHOHREWldG?=
 =?utf-8?B?NTluSklGYm8rMTBBd0duSmxQemZLckdFejFJQ2ZjaGFBQi9KRktENElkaWN0?=
 =?utf-8?B?NjUwc2J1S3p3VnFLSG8vd3ZzcW4xbnlYRVJVcjdlRVBvSHNkRFhFZGxsR3g2?=
 =?utf-8?B?ZGhnSmZ2bDRLYUkrNG4vQ0VPRFFqUStOMU9leXg5V0t0eGpXei9aaWJqQWdH?=
 =?utf-8?B?ZG5zSmVFeWVpUU5WeUg1eEJPd0J5QTM4aDhmekhRMGlXRzZzbHdDZmV5VFpn?=
 =?utf-8?B?R09xY2t6ekwyWWpYUDB2c29jQzZtMWcxclpMak1Ta085RjVTS2cxWndjai9O?=
 =?utf-8?B?S1FwZ3ZTK3VOUzY4NHovWUJBTmdHbk9xUUFZWWk2Zkl3N2lhWFVNMWhLbmJx?=
 =?utf-8?B?VXJEcWtsU0VLOEw2cGU1TkR0S2NLYVVxSGtVTU5WbnlJY0wvVTZRdHZmTkZr?=
 =?utf-8?B?MGlseTczcHZhSFdqQUFhQmdhOVkxNmt3NmR5TFFGdXVoeXIrcWNwWmJTMW5x?=
 =?utf-8?B?RGpwVWdtTjZkT3hnM3NnL21ZODltWDlvUnUxRERCdHluenNGR25qanFWOHla?=
 =?utf-8?B?RSt6VHh1ZDVTZUhLN0daZjVFSTQ4VmVWckN3SklmTUt0M3g0dEdLNGNBUE5I?=
 =?utf-8?B?TTh4YmMvQkZkd1Q4Zk43LytFZjVWREViSlNGZnhSeElXdWtiSnMxZU1jaGN0?=
 =?utf-8?B?ZmFzT253M2NublNtQUJwK0ZybDRVU1VUZ0NUOXNhMU9ocTYvM2J2RzhvQThi?=
 =?utf-8?B?bElFMmZyRUE2djhnZGFIL0VLNTV5UmJ1TU5wN3NmK2hiZGtOblZVQU43Ujc1?=
 =?utf-8?B?MktDNmxDL2Y2ZTVrMHllQTRybnZMcEFGNUxqVFpxb1Y2cWZ2WmlTbzlTMDJC?=
 =?utf-8?B?SVRSUjZPeXJnajYxZlB3dkFMUG5LclZyeExoazh0OUxrVm1rK2NhTEdiOHJY?=
 =?utf-8?B?dC9IbXBiS1JvQ0tRLzhtM0xCVllneTE1NXBpRTIrWXhSZ3dEbHJ4OUdJVUVR?=
 =?utf-8?Q?GNJCetr2CHoSCCzSWZeLwALwVjII64cgTLBxurLMSXN1r?=
X-MS-Exchange-AntiSpam-MessageData-1: BqPKz+zXRsbYMg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dee8f70-c84c-4d90-8033-08def2b4cc68
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 05:45:47.1890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDbJEviIx8gK/Yvj8v2tHbANv2i7RRXFJLhjldndUG+ixFPyE2TLJAiA/o12Di9HZN5sII0xO4CSqmkJ+sCHEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8989
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

From: Joel Fernandes <joelagnelf@nvidia.com>

Add documentation for the PRAMIN aperture mechanism used by nova-core
for direct VRAM access.

Nova only uses TARGET=VRAM for VRAM access. The SYS_MEM target values
are documented for completeness but not used by the driver.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
[ecourtney: fix the TARGET encodings, KiB/MiB units, wording nits]
[ecourtney: wrap at 80 columns]
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 Documentation/gpu/nova/core/pramin.rst | 128 +++++++++++++++++++++++++++++++++
 Documentation/gpu/nova/index.rst       |   1 +
 2 files changed, 129 insertions(+)

diff --git a/Documentation/gpu/nova/core/pramin.rst b/Documentation/gpu/nova/core/pramin.rst
new file mode 100644
index 000000000000..f50b052d73ba
--- /dev/null
+++ b/Documentation/gpu/nova/core/pramin.rst
@@ -0,0 +1,128 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+PRAMIN aperture mechanism
+=========================
+
+.. note::
+   The following description is approximate and current as of the Ampere
+   family. It may change for future generations and is intended to assist in
+   understanding the driver code.
+
+Introduction
+============
+
+PRAMIN is a hardware aperture mechanism that provides CPU access to GPU Video
+RAM (VRAM) before the GPU's Memory Management Unit (MMU) and page tables are
+initialized. This 1 MiB sliding window, located at a fixed offset within BAR0,
+is essential for setting up page tables and other critical GPU data structures
+without relying on the GPU's MMU.
+
+Architecture Overview
+=====================
+
+The PRAMIN aperture mechanism is logically implemented by the GPU's PBUS (PCIe
+Bus Controller Unit) and provides a CPU-accessible window into VRAM through the
+PCIe interface::
+
+    +-----------------+    PCIe     +------------------------------+
+    |      CPU        |<----------->|           GPU                |
+    +-----------------+             |                              |
+                                    |  +----------------------+    |
+                                    |  |       PBUS           |    |
+                                    |  |  (Bus Controller)    |    |
+                                    |  |                      |    |
+                                    |  |  +--------------+ <------------ [1]
+                                    |  |  |   PRAMIN     |    |    |
+                                    |  |  |   Window     |    |    |
+                                    |  |  |   (1 MiB)    |    |    |
+                                    |  |  +--------------+    |    |
+                                    |  |         |            |    |
+                                    |  +---------|------------+    |
+                                    |            |                 |
+                                    |            v                 |
+                                    |  +----------------------+ <------- [2]
+                                    |  |       VRAM           |    |
+                                    |  |    (Several GiB)     |    |
+                                    |  |                      |    |
+                                    |  |   FB[0x0000000000]   |    |
+                                    |  |          ...         |    |
+                                    |  |   FB[0xFFFFFFFFFF]   |    |
+                                    |  +----------------------+    |
+                                    +------------------------------+
+
+    [1] Window starts at BAR0 + 0x700000.
+    [2] Program PRAMIN to any 64 KiB-aligned VRAM boundary.
+
+PBUS is responsible for, among other things, handling MMIO
+accesses to the BAR registers.
+
+PRAMIN Window Operation
+=======================
+
+The PRAMIN window provides a 1 MiB sliding aperture that can be repositioned
+over the entire VRAM address space using the ``NV_PBUS_BAR0_WINDOW`` register.
+
+Window Control Mechanism
+-------------------------
+
+::
+
+    NV_PBUS_BAR0_WINDOW Register (0x1700):
+    +-------+--------+--------------------------------------+
+    | 31:26 | 25:24  |               23:0                   |
+    | RSVD  | TARGET |            BASE_ADDR                 |
+    |       |        |        (bits 39:16 of VRAM address)  |
+    +-------+--------+--------------------------------------+
+
+    The 24-bit BASE_ADDR field encodes bits [39:16] of the target VRAM address,
+    providing 40-bit (1 TiB) address space coverage with 64 KiB alignment.
+
+    TARGET field (bits 25:24):
+    - 0x0: VRAM (Video Memory)
+    - 0x1: Reserved (unused)
+    - 0x2: SYS_MEM_COH (Coherent System Memory)
+    - 0x3: SYS_MEM_NONCOH (Non-coherent System Memory)
+
+.. note::
+   Nova only uses TARGET=VRAM (0x0) for video memory access. The SYS_MEM
+   target values are documented here for hardware completeness but are
+   not used by the driver.
+
+64 KiB Alignment Requirement
+----------------------------
+
+The PRAMIN window must be aligned to 64 KiB boundaries in VRAM. This is enforced
+by the ``BASE_ADDR`` field representing bits [39:16] of the target address::
+
+    VRAM Address Calculation:
+    actual_vram_addr = (BASE_ADDR << 16) + pramin_offset
+    Where:
+    - BASE_ADDR: 24-bit value from NV_PBUS_BAR0_WINDOW[23:0]
+    - pramin_offset: 20-bit offset within the PRAMIN window [0x00000-0xFFFFF]
+
+    Example Window Positioning:
+    +---------------------------------------------------------+
+    |                    VRAM Space                           |
+    |                                                         |
+    |  0x0000000000 +-----------------+ <-- 64 KiB aligned    |
+    |               | PRAMIN Window   |                       |
+    |               |    (1 MiB)      |                       |
+    |  0x00000FFFFF +-----------------+                       |
+    |                                                         |
+    |       |              ^                                  |
+    |       |              | Window can slide                 |
+    |       v              | to any 64 KiB-aligned boundary   |
+    |                                                         |
+    |  0x0123400000 +-----------------+ <-- 64 KiB aligned    |
+    |               | PRAMIN Window   |                       |
+    |               |    (1 MiB)      |                       |
+    |  0x01234FFFFF +-----------------+                       |
+    |                                                         |
+    |                       ...                               |
+    |                                                         |
+    |  0xFFFFF00000 +-----------------+ <-- 64 KiB aligned    |
+    |               | PRAMIN Window   |                       |
+    |               |    (1 MiB)      |                       |
+    |  0xFFFFFFFFFF +-----------------+                       |
+    +---------------------------------------------------------+
diff --git a/Documentation/gpu/nova/index.rst b/Documentation/gpu/nova/index.rst
index 1783513cbd05..5ebbfd76fdac 100644
--- a/Documentation/gpu/nova/index.rst
+++ b/Documentation/gpu/nova/index.rst
@@ -33,3 +33,4 @@ vGPU manager VFIO driver and the nova-drm driver.
    core/fsp
    core/fwsec
    core/falcon
+   core/pramin

-- 
2.55.0

