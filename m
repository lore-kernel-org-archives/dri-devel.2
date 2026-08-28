Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEF4C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 03:36:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92A310F22A;
	Fri, 28 Aug 2026 03:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="BlCHbWHI";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013008.outbound.protection.outlook.com
 [40.107.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5BA510F21B
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 03:36:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnoT6mSng559QeX0xe+98cHAK2avah9mjaGw8xFniGWX1z3UJpjLL+f4Zp+8YhuhLTuebS/zhqSSe7UGpIPsog13h8CGDslMz5TTXmy8A8oZzfxHFKfZiFmaHdQpUK6pGaj2dYNHlLQq7FaZjN41yC7ks2lIRWToy0VQ4VesnH9aGTAzomXnvwI4Ke9WUB/RysCWdfR9EA/ssh238xU6jOUSVqZahRWlrdswKSTmdpdkJ62Vsw4AIqAcVQV9CKEabaJ7t9+ffi5vQGFgQhqdb3RynH+M3Wb85gwRv0nFhDd6GUDVvTPkPdmz8TE2f6q5W+WVPzi3/sL5Qf9TfzZgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0woBO6B8QzgHB+sK9UD+G+UjT0oOyBmJaCPdBMUuORU=;
 b=fdUF+7FeLexTjmTc6Kitg1W6asiqLmv6OsBQVpUHciB0QxYz7hDBs9c1t8Imz04evqiSblFaegCu3UJL/M1Tw96PEJfwEJztZ3DE9b93/5XAY20JD+HGxyRTj5iHNhO8q8gl6wK8UftEGlAlJbZqGfgh166f9UUbi7CEWeM5mQPx4OE4PwV8L6XQOwfAlRaxMHxgNUveob3u2i5i5vixdr048DlxSyHuilCTlZ8scfIxQzUTgR1ILTNqkC2nygHGYURthO6dM7UfeImbDYOUNuXEHBpKSiP8utMLzcv5kroG6FhU7z5Fh36snxWz4WrBO4ljFA28Rm+1XCbpW1OJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0woBO6B8QzgHB+sK9UD+G+UjT0oOyBmJaCPdBMUuORU=;
 b=BlCHbWHIDGqCFzYdIs/LlssAPrgu5JMI23ISReG0V95YTTwqcey2KbeGz+TsEqG+BMhsPPCVxierw/61In9upC9T2JbnPSzmv8Fm4rUGROeIG7jnYhAHCeWwqDSMxakHQGZ7oKI8mqhdA3yHCsjhDYfjx4fA600gb6LKgU39GrxAUUGo6pRHutyJvsKBlUgXMndJGfDK3OLkvdXwqa3tgaX0ILo1pU5msIt9EMLh0jfrYIhS5bQ+wh3pGBMrxKO2qF3uKMhCZVQktokOni3Owz5dgjPecJZMY1tn6FzNzMBsQCIohgLVeUEX4UiJ3/6VyuT7tmqJ2VWNJwdUMWA3RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 by SA1PR12MB6919.namprd12.prod.outlook.com (2603:10b6:806:24e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 28 Aug
 2026 03:36:32 +0000
Received: from MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28]) by MN0PR12MB5977.namprd12.prod.outlook.com
 ([fe80::d8:f725:258:2f28%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 03:36:32 +0000
From: Alistair Popple <apopple@nvidia.com>
To: nova-gpu <nova-gpu@lists.linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>,
 M Henning <mhenning@darkrefraction.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Eliot Courtney <ecourtney@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v5 08/11] drm: nova: Expose a render node
Date: Fri, 28 Aug 2026 13:35:28 +1000
Message-ID: <20260828033531.1117754-9-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260828033531.1117754-1-apopple@nvidia.com>
References: <20260828033531.1117754-1-apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5PR01CA0046.ausprd01.prod.outlook.com
 (2603:10c6:10:1fc::6) To MN0PR12MB5977.namprd12.prod.outlook.com
 (2603:10b6:208:37c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5977:EE_|SA1PR12MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 072031c5-d26e-4484-510f-08df04b58da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|366016|23010399003|6133799003|11063799006|56012099006|10067099003|10063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Scte7MaLe9uAlDZInhSjxM2IlUA7z96cF/rQrgTi9OFhd7hxuUYKuvRiSurc2ewpM9Qi79oCJY9/iJHr4+6p6L2ajHi7Zl1kB638mU39ZOItncoihDwXQAuX2eowtMShHap22O941Yd07pSMpqIawa2gETyjAXJpFh6602EM2Yz/4l1a2Cy6URp5+KrqGGS8u74BWr5JZpDSqxSPZEf266WbXZkMLhpvO5aE+Cnq9KCdkGX4RX7/qK2ns9rj9uA8kJXVPpFyW82atBrA7bzbdRl909w4aCEfNk+/fqbZvmeroIDK/tAmV0ZUIQLVHAD5SfcZXWt/04JKk9VOALgFrpM6pv57Z3SzWn9YEJYzIrEOazvg/+g4cOgh2dFq9e70B4x2tTrZM9IrhMkyv53rsfYcf8by/E3Bih73Yp6OKLr+BtthGfOHU7R0YW0l3PB21Ycc0X3jd5VnnMYE8oaC0O72a6X2LITMRrPSg91sg03rBlJkxAiB0A0rD8/mTbO29D+SUwBhPGeTlislL8i4SO4adOT1fZYyQj1yelUBq4HQ4QSIrAC1Q4vi5zBf1DXmBDXbIf2Fm4c1AsOBq1wU8jpmbFsPvQTbATZEi5ddmDtecdmKhApdtz8Set3Dsw2u/pdVIofVgWrKXcL3VcHL7AaiSBQtHKuiO44y1Ab3sBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB5977.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(366016)(23010399003)(6133799003)(11063799006)(56012099006)(10067099003)(10063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RMR9anvnJsli3vIqHsIbN342ZmAvDTLi23zGdAjmcnpuoivh7hA4YJ8FLysR?=
 =?us-ascii?Q?V6rnkvjYTXjqVpYIozxkQAAzwrowZRG6EHNjFx6KjPGgwUlYPiBwsNnVR8iQ?=
 =?us-ascii?Q?sDqs9d9WJL8sG3MsrAFG8NiIxtJjpkLHxH+UwUKMfeDauYINgpk/8z9iDWhu?=
 =?us-ascii?Q?1oGE6oDG7p1VT+X30Evxfgulr2m6FcASwUOCwYVCXNQvXEGW39xiBabdseY6?=
 =?us-ascii?Q?n4FW/QEOvzDgKLC8R2405fAnXnYmAgeJ/pnu0iBY7q4KovM9zHpauNfImmVN?=
 =?us-ascii?Q?H6NeEPvJKQOcrB/LgOr5tHkG6pwawDm6OVBVjy4njls8Tsowk4vQhkEQEJtL?=
 =?us-ascii?Q?fpxVozX/fwTxUjRsYjQ6LjEHixS1g95ZajFSpt5lI5jUxCOvAO4Vl6qslHUy?=
 =?us-ascii?Q?KYA9B5ROhvXqein+9uuRxcvvQhVJ5dEhYcuSk1ytwlVQUAyLrkaBDTomn7Bd?=
 =?us-ascii?Q?BsWNe17QbctT4Ah0HiO4rXBcMzhHVYCDJWc/DNL97wuXm36flMLh/NsoEEzc?=
 =?us-ascii?Q?Z67LhWCKI1z8f6a4+nZd+a6iLavZ0Ti0EFAaQg13+GWY9gONUCPQ+UHe0s7u?=
 =?us-ascii?Q?eS5+aLPuT4snhzLRLlv06Kb66TThakDuDQ9hBWUuLmu8gEO5T+Tt2ZOlpgGf?=
 =?us-ascii?Q?HcmzMBiBCwRjuZCS0q8OWPY9WvVy+tZj18+RcSWIq0jF8+BmYJqJ6KkxSVd+?=
 =?us-ascii?Q?k/PaaMqj7cC7z0VrFxxwcDP39HA3oQzPe1gkKKNwx8HwL7nhJfv+XwWXz0r8?=
 =?us-ascii?Q?fZWr7XFXKGJcnUO0tRBu6IsVB2N9OWj5TRGL7DVi9Nq+cRSoC+8RzmBrVbMF?=
 =?us-ascii?Q?toLaPYwpBhdALLNhsR6Yf8NkDTSHeKAgiuv50AhQzrrDrXlQCFL9rGpnk2SX?=
 =?us-ascii?Q?6PnQvLMuFvHA5FA/FEtillHhV7nm4pGR0dFMBbClha2ZdVaXNq0XDwwW6ljN?=
 =?us-ascii?Q?o/6J5ggW460D3B10fRExMbOl/9usIzSmxYwK1+t3TTjEMDBfBdSp4U+byqqW?=
 =?us-ascii?Q?IN7JPJo0d75fkRnQIHXDOlwT1EADoppI4sz54VkLupHbxTTDZrzlKDaNIM6a?=
 =?us-ascii?Q?MX4mjAB7+ESsULem3hTMWsZ59Y8ZLZCJaOArPNxzxMEA3fzP3G/yeHy592zS?=
 =?us-ascii?Q?TcEYf/15RCeeq3q2SRgYe7pP0BehHogAKtjcJ0Czsrw/+TqQxJ/tflRHnlH+?=
 =?us-ascii?Q?Am33cK7JGz+a7JKq7fuMPRYmEy8CvDJ+mJgrnBs55m3gKkFQpMPdPRBGM39S?=
 =?us-ascii?Q?GL8FXvj4ZzvgoKfryRpOLTY98i80FU8UZGIUx1jSO2fiJkAnTb4eXJBpgkhj?=
 =?us-ascii?Q?m3zQqheXEbFfomRioz23m8Pzd3voakT/b7YKOUFteg6Xj4RpZhTZ4ccmLxQp?=
 =?us-ascii?Q?Jry1cU42hriUtFqIe6K9OeXvh4R5Ti5j8XYaTsUsCGoC2To15aEsBRuaAryU?=
 =?us-ascii?Q?Bcf/TRDadOR3NOBm+ilDkxb/YKhbZvMD8/bIh8MYvJrrf5SfqpsxOBu4oVKo?=
 =?us-ascii?Q?h09onF9USc+t4YGuPJmqTJ+Hd+R2AaVrx9l/77QQBh7UaxLqCaf4gjeISCGC?=
 =?us-ascii?Q?YbkUtqMeBF+22kA625kJ6h5zSkefUvI+Y6niqKMDQ3gg+u2NsMLv0PVw1x5f?=
 =?us-ascii?Q?+1fbjYQtRsVIN3mtLI3QUG2voLGuTBGRcWVxjhMJ7l8/93TWIbsp+eHIsKWb?=
 =?us-ascii?Q?JIgWdZ7mgYKfySD7W4Lc/zqutv3wWbv7+K2eOJQzLWa/8Y7ywHLOzmRP1WER?=
 =?us-ascii?Q?rrE+2M+4mw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 072031c5-d26e-4484-510f-08df04b58da7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5977.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 03:36:32.2889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o32qYM9YeNq/BGVg/UipKds8iOz4NgtDf6CSp9YoeyqwZNgBB1fiZ3hLOFH1PS2m01Vac3wQVfFbS5K9mGSP4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6919
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

nova-drm currently only exposes a primary node even though all of its
ioctls are already marked DRM_RENDER_ALLOW. Set the DRIVER_RENDER
feature so that a render node (/dev/dri/renderDXX) is created as well.

This is required to allow render and compute clients to interact with
nova-drm.

Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes since v2:

 - New for v3.
---
 drivers/gpu/drm/nova/driver.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 38f82a7e1738..296fc3c49806 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -92,6 +92,7 @@ impl drm::Driver for NovaDriver {
     type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
 
     const INFO: drm::DriverInfo = INFO;
+    const FEAT_RENDER: bool = true;
 
     kernel::declare_drm_ioctls! {
         (NOVA_GETPARAM, drm_nova_getparam, ioctl::RENDER_ALLOW, File::get_param),
-- 
2.54.0

