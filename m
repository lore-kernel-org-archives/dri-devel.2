Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5DF3CA5FDD
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 01:01:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 179A610E1A1;
	Sun,  4 Oct 2026 01:01:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XKtR2OWe";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB59D10E1A1
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 01:01:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1bJaTLcWWx/WqjHjVCkNY2QW23Ue0Vw4NpPHiuJM5a+tUcyQ32YruVW6X/6LK3RguaKTpml0CyoJMKq7gXyLAGlkIBlRQ/BfpZFL2vx+/c3FkY7rYCM/u/FyBt+tCoDYnhyP9WYUkaAWpN+ungCI5ZUr+9A15PNtXAOFCAp3mED9Zf9mpshBvfGg2Zqqk4GPW7zU4xXn+JZ/ll0FkwDPsTx4cMg7S0KgqmHVGT2t85MGAKTEh1ryXa2aCmSY23eUqnFQbmjWaFcNY9aIsK90vIxjqDgXO6VNpY46Lj/n/VK6tG37QwEj71XeSivPHES7gABK4WyZrqpI+uUQ89nlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQzQ941oaFPl6LTxnedIisOmyjiYXk4ngUIMWFBN0Ak=;
 b=sDIDCJFqlsDK7V5vgzw8heSMmuGHIijgElkMN/iXcifVKwozJEInFfyatxVmKCAlXm52ubKkCNNIlj9eKNZ+LCZq9upwEwgdhSIgBQXFQRBfk202TLFYNqTV2m93L8/mRO2cSh+tizJwjmoidZZ7AFV55P5lbuwNO/7eXY3zedF+VJ5mCD1kzHLRlyedZPx8i08QeflAs93A8njdxoRbEKivQu48uD5Lxymp51RuGMJEkECDA3nmD4RCXJjs/qEcXxqxa1+w6BhXZ0hOQQ/QAPPZPrgcRQgpJ3IxNkQB7vvXU1SOuhBqVY1OxsbUQEK4OhzGMrz+Be2DoaTQqjP8cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQzQ941oaFPl6LTxnedIisOmyjiYXk4ngUIMWFBN0Ak=;
 b=XKtR2OWeGVRxT/2TXA7nXBVVeXD/iss1wj47pJ0v9bWTcuL5mNwrhnt6bJ2G/F7uge31bFz7pep+46goi88J6MlgkCjdGU7fos9hPoW844cTHm0eBLdZaMuh7PV5e5NkYB3UU1+gJUbh2cChng7i75XRF89qH+NxiQEw7KzO74Sci7GuoDlKDGeoFYXmCpcibzoP1q3nOExEead+sKl1KTyF6XTBeDj8oTwNmPh7pBK1mGrpYmZnG1V/YAruQZdToy52HmG49JScIMij+B0uM3y1uZXqxrSZ9htuNrTaTmCzBoYnAi7YWDni6pN/LCrcmQvypQkTutOIysK08E6SWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Sun, 4 Oct
 2026 01:01:04 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 01:01:03 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Sun, 04 Oct 2026 10:00:49 +0900
Subject: [PATCH] gpu: nova-core: fix warning with NOVA_CORE_SELFTESTS disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-nova-int-fixup-v1-1-9e4bce097f94@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ5AMBAAvyJ7tklRgq+IA7VYh5IWkUj/bnGcT
 GZu8OSYPNTRDY5O9rxagSSOwMydnQh5EIZUpUWilEa7nh2y3XHk69hQ51XW60FcqUGizZGIb9i
 0P/ujX8js7wVCeAD+3cpgcgAAAA==
X-Change-ID: 20261004-nova-int-fixup-4593b4d61084
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>
Cc: nova-gpu@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0116.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::8) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: a3402f7c-e865-4e67-9127-08df21b2f6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|23010399003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: vdPhijtgK3/9PBQVYefNMlzjWFkoHhslIdJ6CZJBX04UFPgC9qYqxn8aLyCFSzT/VBsr0S+J+yTnmdNxSt4F7U/9CVdvZ+9weps4jy2NE3Otwh+lPTTxqlnCYo9wkzir3d4Z1r9ZjLk6dWFMuniqK549jWmY/V64kBAkHAMO1586Ct/bUI6pi9/BjUfob/Q2g4zKgHzaf4Lwbbxfm5nmeSKPUSr0GsC+pVwih5WjOTzYxG1IJiw4r2XxP6M+Fx2XsXsTvf+TJj5+VMMAW3lgiF4k6nYZ9CUN9cA7PdFTrl5WGNek/dVTEotQohLvy7hWe/N6jDYTvEwt72m4bLNuQ1gx6843IMHUvFynjcMM07AOiDVhPPtEPHenp11xxWV/R5v185XoDbCqahwAiM6/CF+lgpdGrKMrJRNvvu7X6BXb1RK3mlHHII71ybRT6fMDP9XkOMiYl6DOcy0bs2Z/FZPCk9oRYD8aawluEt7bgMQ6/AOtd7iBssOXX5V025Kf7jlBtFbS8+O8TKWvMV/9hlzFyrLl8jCH1nus8jcehv0PLgavsfYzxhXYuoUDYYI6N4DFpTqiwzrCpIQUr/wjEPgMiaBrZgLN2bhS9xoYS3XV86oJgOnmNy8MMyS1JcucstdJgVs1H/WHW/zSLftynJdjLdwp64ZYB8b8wgslniY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWVCVjFFNlVINTN2aVBJQldzTzFWc3Q1Qnp4eVJGOGlnKzZ6VnQ1UzNyK1Ur?=
 =?utf-8?B?TDQwVUpSdjh1ejlLZ2pRVWVvVlRKcStiKzNTZGhmK05Sdk9pd0dMY0dST2wy?=
 =?utf-8?B?QzBoK3V2c0JWTUVqUmRoQTIybkhvQng2S00reXl1Vld6ZTBCODlUN2JJTlpZ?=
 =?utf-8?B?UktQdWVvNGFVL1R5YTVWdzJVTm9PVXF4ZCtMTWVuUCtyWU1zSEVGbDFHSi9L?=
 =?utf-8?B?TEl1V3BuVUcvZ2JwOEEzNXlpWVJCUHBmWTZIMjY4bFludDgxSzFBaXdrZ0F2?=
 =?utf-8?B?RDdvVi81L0RQVlhISkl2RlRROURXcUtwY3JOeFp4YlhhYmpobU9RM2NFYXVx?=
 =?utf-8?B?R05VNlNLR0pTYzNFakIxMkVNUHZtV2NtSVE5dC82N3pDT2MxbUZnWU9MeUpF?=
 =?utf-8?B?VElPeWpEc0taZ1E2VjM1ZGl1SFFmelY1U2psdEhKVXNVOFRFTzhHaFdnOEhx?=
 =?utf-8?B?M00rM3lPTjBKRmhybWxkYk5iaHdMc1RjN1Ezd1RrSG5YeXRjMTV0VWJpZllI?=
 =?utf-8?B?b0xYc29WY3JvNU04ZlIzNmlyYXFTUHd4ZC9QOG4xSTRJVkhWUWIvOE9qeXdR?=
 =?utf-8?B?VWROMWJsUUFsd2tERS9zdSthQWU0U0paZjk5QWV0VzM0SXhyKzBrWmpGdnl2?=
 =?utf-8?B?ZkY4cGR1dWE2cVJ1aysxaEV6M2JPcXFRU2dMZGNrdWllMUI0T1d4dEhMclJu?=
 =?utf-8?B?a3c0bjlKbGlXdDBMNktYSFNyM3U2OUR6dFIvamZuWHhyRzgzeDVxOXJHZU9E?=
 =?utf-8?B?T0R4bHM0eEhHNDNwWHRTWnNRczJaSEttVWV1ZENPbFVjVkNPRHNjbVdTdnFJ?=
 =?utf-8?B?M2dmZ1FsMDdnQjQ5WGU4TnQveWR2ZnZTOC9PTmE3L1F0dWRCKytVTEgzalV2?=
 =?utf-8?B?bCs1S2EzMW9yc3pSK0xMNUdTNGFOUEF4WmhRWEFGSFhJYjdmb1dkbnI4WE5Y?=
 =?utf-8?B?TnJLcGpmcnc4eVRGY3FKcEVrS1lOVEN6L2FCL0UrNGdwM2xRd1hyS0JLVlBw?=
 =?utf-8?B?bytwMkJSVlRoOEpPMmc3c1JOSDNsdVBYaW9objQ1L0Y1eFcxNnUvUksvZ0Rs?=
 =?utf-8?B?QzE4TmtKdC8xNy84VmhGWU9vTHdoVWl2QzMxbU5JTzJta1h0YzRTMk9ZUmNI?=
 =?utf-8?B?N2hZSkc2MGlrRDB0R2xGU1ZIUm5rTDdGblA3TWxGb1ZJWlllOEcxUnJ3ZFp2?=
 =?utf-8?B?cmZZZWtLam0xMkxiMkd6bURQdzl4YTNYdXhMZXp2MTNJcmgza1RDanZQdkls?=
 =?utf-8?B?OWtKMlJNK0xhNnplbm4ybVZqV0NHTlgrcUs1V2ZrZU8zbFpHOVg0R3R3N3kz?=
 =?utf-8?B?ZndseHBLVy9MOTgvUWJHWkRpQVRrMWxSMHlyTFdFUkc3SVlhVXFIc2R6Zlpp?=
 =?utf-8?B?QjB3K21NK0JFOUs5RnNDV0ZxYWlHbklaWVh2dDFYVHQrUXBqL2YwZXpuZ0d3?=
 =?utf-8?B?OGMxOHJGc2JUVU1lQ0tzMWowYW01OE85eTNLVnBYbW1Wd2cxSlNqWEFndzBu?=
 =?utf-8?B?UXExODRqc2xpVkcraHpuMDRLdWtTaWtYVk9SdHhPdHlibWdvYi95TGZucjB1?=
 =?utf-8?B?Z2FFTGw0aGJnYXlFWUM0L21xRVJiOFpuR2lqUE1zZm1iekVtVTdaT25sOUdk?=
 =?utf-8?B?cEQ5bWJuM3VvOGVDT2I2eC9qcjIxbTc4M3RMckNJZm1XUGRaOEtOWGtiNlBL?=
 =?utf-8?B?MkdTRW04b1Azb2ZXclRDTzFTSmRtRVpPb0FvSlVJTXp6bDZmazU0QzU4aHdz?=
 =?utf-8?B?MnNDUG5ZV2JSbThFa2pJUmp1cE53akkybHZWOXBiclY0Zmk1MW1wU2RZWmtL?=
 =?utf-8?B?WDJPVGdDVDBkWmloSFRQRlNmUFN1Zm9PR1M2eVhIU0dNOGIxQW5qSXNZUlY3?=
 =?utf-8?B?WEx3ZSthOEpnVjk2WUo4NXRXa01CUXZaai9zckNpSmxYSnp1RE1iTDhNZ1A0?=
 =?utf-8?B?UWpEREhPZ0hpTlpxbHdoQTgxYnJ0Y1NEVnUvVWNyWFpoaHNwRXdQMW4xNXAy?=
 =?utf-8?B?QTNCTEFvOUdtakx1YThGZFM5ZTRkL0lBb1RuYzkvU2tuK3o4L0pVZDdPbi9K?=
 =?utf-8?B?Wmg1REt1SWxQcDF6Ym4yWW02ZiszRUNoVnBaR0ZPME5XZXcwWmpkQUM1RmN5?=
 =?utf-8?B?N2FoQTloS3dmaHZVdm9EQjNtTnBZVDNXRzM5RDNlTWxBb2JhT1VBVWF6YzJm?=
 =?utf-8?B?OVV5Z0Q4T2FqNzEwYzYzZTNrTmIwYVJIL2xxNGhod09pR3hBbWJJbkhzWW1z?=
 =?utf-8?B?OFREc3lOcGFjN0M2RkFibk5kRFhRRzR3R2lDbVA5czlDU25xcjJ2OHpBbGNk?=
 =?utf-8?B?a1pLQTRRZEh5dU5acHRhWUQrc2NDdVVvTFJxTXV1ZWFRQVpWNDZBckZPdkNP?=
 =?utf-8?Q?uwLXlFwMKg1VdwofE2YW6/eZTmWf2IoElkVIexg/jfKUa?=
X-MS-Exchange-AntiSpam-MessageData-1: wtdU7V4hQ/DgPA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3402f7c-e865-4e67-9127-08df21b2f6ab
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 01:01:03.8584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dwc2MHSGd8MwGQn2HqehhphqI2qkgF38rJnFgJz3xP4QIUxEsaCPLFmJXxWmsE8xlbIccvDFJnS4C5g7ln3+JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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

A module-wide new import becomes unused if the `NOVA_CORE_SELFTESTS`
config option is disabled:

    warning: unused import: `Spec`
      --> ../drivers/gpu/nova-core/driver.rs:29:9
       |
    29 |         Spec, //
       |         ^^^^
       |

Fix this by fully qualifying the unique use of `Spec` when the tests are
enabled.

Fixes: 9cb3f5d56e81 ("gpu: nova-core: add an interrupt delivery self-test")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610031630.JOlyp48X-lkp@intel.com/
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/nova-core/driver.rs | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index d195fd2bcf8c..560a70c4f5a7 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -24,10 +24,7 @@
 
 use crate::{
     api::NovaCoreApi,
-    gpu::{
-        Gpu,
-        Spec, //
-    }, //
+    gpu::Gpu, //
 };
 
 /// Counter for generating unique auxiliary device IDs.
@@ -121,7 +118,7 @@ fn probe<'bound>(
             // Run self-tests that do not depend on the `Gpu` instance.
             #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
             _: {
-                let spec = Spec::new(pdev.as_ref(), bar)?;
+                let spec = crate::gpu::Spec::new(pdev.as_ref(), bar)?;
 
                 // We must wait for GFW_BOOT completion before doing any significant setup on
                 // the GPU.

---
base-commit: df718311a84188e26d499301c3921e4c392d557e
change-id: 20261004-nova-int-fixup-4593b4d61084

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

