Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F603C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA92E10F77D;
	Fri,  3 Jul 2026 10:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CZJV1MoC";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A45810F783
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 10:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A63Zm7Ws6B0OTf3VGp/iHzqqKojnDi3/XiH5O3m9a+/dNuNBpIQTv4z2E/r/GGFRZPwjhjpoTcBIDysZ+OmZPI4s36h5MQabAtT1jPB8lp8Nr6ewEiDzv0zyzI7O7BmR7wZphHlIoJgeUITcvlV52E5I+QGW3PYudNHlnt/wtCe1nU4acrYyIgWcZGYKLVJgmn8k5PaOSko8zLNzTVpSuck84ffzC9gRyGjgxdwbOqmpM7PexkIdY3qz6sF74O0/t7O80nIoQNK9vIWYIYvXF/ObnfYtkr959iamnj6V67xuhjXSJ9O4vzppyyYczOphTRCd7kygaCKFP9ddZd/6kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnzU6B6iBzP7opt2DfncrSXfk0sJ8oHvBAcmPLxM4b4=;
 b=cv2AaQ42rGkHjK020qiyEymknYsSvUlpWFggGJ8HagEEbT+N0mKiaNWBz7XVVFH8XcMqdGSFhvVmmvOtAbmiWU3gEjKxDI6Q7+8eePMhyloyI3yAHf9G0w4Nw8PUtVjqM4wxAHx6y4LUuXAaV0v31jCsWkVg/yeM066frr25rAI7VekSrnZd21LgrCb9efHLnH6yLvF1sMYhmSu41C4VxhYDuraGAufupp0omIbjyEsQormlLMWwtcOqKoR3rxQat8IVDfraBhFLdPN+svw08JwyFQuV4W7LWkxAP/lNrmQpmDpXt6/FPZq1xUQNMnzvhxLC2gBKN54BcNdM3Lynuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnzU6B6iBzP7opt2DfncrSXfk0sJ8oHvBAcmPLxM4b4=;
 b=CZJV1MoCrbhLIWSBN9bgIfcOydvWr9FWEXlN5gVz7OmOGLuIjk8wNyeaDHa7P5U/Sbkq79Q4+YvLhhso3Ci0i809jQ6do0eDC/RQJK/1O7obn4xrLjMraWC4lgbvhmDG08qK2gSkZn4EfKyONfi+iveKmugtO8ghd1nOBQePItWVF8/ogxtgh+4mIVZcyyEnv2R3ObA3gzupSkprhvS+/n5Bv/BK3+3t/5RD4TSzT0g8GLIVk+gIUV1Y1RzWtfLpZzMzc1/PKmWCn39lHNqwxGxX3eVbGpMl3UHvcPPynENfrTNSeE05Fo6MTC98aWCcug564TAgH6d5mbzDtspqmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CH8PR12MB9743.namprd12.prod.outlook.com (2603:10b6:610:27a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 10:22:59 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0181.010; Fri, 3 Jul 2026
 10:22:59 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 03 Jul 2026 19:22:13 +0900
Subject: [PATCH v2 09/10] gpu: nova-core: correct RISC-V HALTED field
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-blackwell-fixes-v2-9-8e3d8bc32bb9@nvidia.com>
References: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
In-Reply-To: <20260703-blackwell-fixes-v2-0-8e3d8bc32bb9@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCPR01CA0166.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CH8PR12MB9743:EE_
X-MS-Office365-Filtering-Correlation-Id: 88acaf62-6fdc-4b68-f2dc-08ded8ed0e30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|376014|23010399003|1800799024|366016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NOcilniljPJbIWH0Zv3clmLw7Pi7Qnx5OVK2JRyiG9QhIJMxKeWlzIXtyYax01owM0xh7J6HCouuIGE6TWs+zRYqFB2NISC3BhlCsPCqnatwJym24QVrMWPnHmjplXJhy60GyS6XAW2SCUjRLkCcsLHFKAzEuyAfzlyJCpRA4uB3juZsbogmhKb/Lqo4QgPH9pLramh4yEwya91aDLXgSpfVBTakjmwPxMT07aLTjuyKEgKFZtEenmOCnAjsZDvuX0axGZB/HBD/qJJC2erHwr6nta7nZ064WfgQvnHWZQLvSU3LIB6yURaRRTWhqhLxgm1Xwt3KXUoKBY3xgUtOpm/ETElxycJicqsfSOj0vtDd+KGNR+659GyGL8Z46lSD3EGNaV7h4FLJAuNjt7dvnZR4OtR3KxgZ1rQwIjN3GTmRUkwrGIsz2qbKou1j6Yz8VtnzfomgMsNRITLf8Anzwg/VKHi8Z9EVcEud3Sgu09igzusa0KMNGk0RsbKShg+Y3Ds4EkX3616t1UqZAtksWOYgiWRPP8w7ugePKk26pCfQIrN1RDvLUiije8IJp61oxrtKob5k4+5yTGNSPfjEEoyYnRaNf2XPbG8kHtYMHbARRXzKnJpSL2aVCGujorrXp2l3zffwCD+HyftrQtp6FPbHvJv6lytFl9SOACQTqAQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmlyVy9PZEM5dktRWnVGU3ZkZkxwcDA4Q1VkL0tTWitxWVd2RVp3YUFjanlW?=
 =?utf-8?B?c3FGODJnY1QycXVLOFo0c2FJeWJxemlPTWpGQU15L3Z0SU5uNHNFbTRyT210?=
 =?utf-8?B?bXN6ME9aa2ZQSE1NazdCNU0zVWJCTHNJbUNVditaZlJoUkZzWnhSaGFPWWpr?=
 =?utf-8?B?SGVad1c2dEphRUYvSElWTUFkbGxSTmhNUnA2d3phSlkvc2RDZElqbS9DMmNF?=
 =?utf-8?B?UnZGZ0lUWHc2RUhpRFgyWlBEenlmdFJ0emhMTlhGOHAyTi9rWGUyRXV6K2ZR?=
 =?utf-8?B?Q3VxclBidjdaQlk0SVVVRnBuRDIvY3lKQXpkVThvY0tIME5CS2NlZDJlOFdI?=
 =?utf-8?B?OXBHeElHczNZZmwxYnFZT2g0WGVkRjhkM0R1NTlKRnBtbWhpT1ZVOFQrWTUz?=
 =?utf-8?B?UU9aQitPTFVKdG01bW1QZVRmT1BIOTZoR0lYMk1nRmVGWW5CbEJocXYzRlc2?=
 =?utf-8?B?eGpTSDk2Um5JMEJhK1BzYzNjWjRvQU5WRXVLMHh6RnBQRkM4QVhTTVNDWW94?=
 =?utf-8?B?Vkdtb2hqVGFWSmx5YVRNNXk2eWtaczRkTTc3SUVYaXJELyszVlBiOEJOQ0xU?=
 =?utf-8?B?ckZNN054bzY1Nlh1eGo3dGxEWHpJVkQzV0xuWE1Hd3dHSmhhVWpzS0lud00x?=
 =?utf-8?B?cDlzNlVXdHFJVFRIbWVvSi90TzdYM2xtTWdWWHlsV1FObGI2a2RKeVBFUnZq?=
 =?utf-8?B?K3JvalQwWU56ZnBUNWVabndjSExEdXRIYUY2ck43b29jVk5KY0hNK3NiVisr?=
 =?utf-8?B?aWdtVUhjWStVUFF0YzY0MmFGVUNJbktjQm5ybUZDelJlWmRISm9pN0kvRUVk?=
 =?utf-8?B?WkVlMXN2STI4WnV1Q0I3a1RZRnJvSWxvWGRBaFJONXRWMXppdlhHb1dYSG5t?=
 =?utf-8?B?d3hXZzFuYkdkU010MDhRRW0wbytRRzBUb2ljNHI5QXh0TlR2L29WTGo5VkxL?=
 =?utf-8?B?aE4vMUpUNGZ3aTV6MmpVUzVDMzIwUlliR0pmTWhkTUpWdnYyNzlDQWliRXVu?=
 =?utf-8?B?WjlQK004ckxheTJPMXJMRXFkOVdObm83VjI0MzR1Q2lWeWJZSHEwZUdOZk4z?=
 =?utf-8?B?RHZ3b1U2MkVvSUtQaXRiSlNRanl6TmU1c2hhK3BhVDhKM2lYNGxHVzRPaUJa?=
 =?utf-8?B?MEtMNy9YQ25UTEtRL0FjN21Ic2FCQlZnb2MvaWdncXhNcFBEeU9qV2VZREs2?=
 =?utf-8?B?NmNwU1Y0TjJwdTIwTVdma1E5TkNETnUzTnBXQVRiKzlYTzBYVUk3WW1QaGpX?=
 =?utf-8?B?TzJ3RXZKbSt4VlRVdlFrT1pSSTc5Q29nbUlOUmhPeloxZm5DaHZrRDlUcnRk?=
 =?utf-8?B?NVF6OVVaakJOUmMyU2cvRFBCUDRFZXNZcWNraC8rTC8yS05PRVFORzJDK1ph?=
 =?utf-8?B?YzlBcVoyM1R6dUUxOTl5M1lzZEdiVzRtVmtvbWNkc1k2U1U3Qko5NUk3WVBj?=
 =?utf-8?B?RWprOVJzRU1wazMwQWMzcnh5K0xXUzhMUWc0Rmc4V2ZQRW52TVRJWG9MTG5p?=
 =?utf-8?B?THkwejI4SEJlSmxpSzdQdlBHQSt5TW4wT1dLczlBcXJEMFhxLzRvV0RVOVJT?=
 =?utf-8?B?bHZqaGNXLzdwa0pWQURVMTQ5ZmQwWDV2OForVlMvL3JUMWlVdTB1WTJ3MGdS?=
 =?utf-8?B?ZWswMzVaQ2hNMDBvU1NodFNRRGszR05rMjNuSzVEYlVxS2J2MGROMXdUejBz?=
 =?utf-8?B?WDVoVzV3aUdNQU40YURCZVlHMHMyMlIzdko3cUJPc3NrUkxPVlRPWU1QTE13?=
 =?utf-8?B?NndweWZGc0R2dEE5N1Btb3ljWWwxZTROK2x6ZmZQTXI4U2ZnMXVvTWNVRXdU?=
 =?utf-8?B?MHN4TG9WL1pGTGpRelhyQmI2Nmp2UDFMSWt4Zk9SZXB2ckttZWtWNjV5d0hw?=
 =?utf-8?B?bnd3S3hVcGpDYWl5akhmejA0eEhpb2VpSnBXL0JEaDZHcU1vNzd4OTdibDBx?=
 =?utf-8?B?SXYveC9NTXYwc3pZaTFCamxPQWtESitBSm9aNk1rQ0sxaXc4Z2owWE1LRGhO?=
 =?utf-8?B?OGZpN3RSVmFGVVFTSlNYYlJIWnhjTkNVREtVWFVIemc5YUl5WWgydFMxS1dH?=
 =?utf-8?B?bGJtcUh2QzRGQTFrSHBSd1dockN5YkMxNHdJdmVJZDd5NmtzNHFMS2NkQUcw?=
 =?utf-8?B?aUN1UkhvOWZmNG1qMjczWmg5enJhOEFyaW1Yanlvek80WGc5eEwvb2p1Vi9i?=
 =?utf-8?B?SUpleFJab3dpbHFETyt5akx4eHVSMmc2bEJOeGwzSitwVDdMMjVIWlloVm1K?=
 =?utf-8?B?SFVoOUhoS1V5MGlmV1JLUU1yQ0tEMVpFUnhIaGFtZTNFdUNkOTkzc2w5aVVp?=
 =?utf-8?B?cnpNUFQwRElIUUhxMlVRS2RJN290YjlMdkNIcm1TQUZmM3V4aFI2b2R6Ync2?=
 =?utf-8?Q?+SfWyvK5EqHqBy5y8RyKLxgcIKzsYXb66d7+lzfbRMdfm?=
X-MS-Exchange-AntiSpam-MessageData-1: drhEO3n6KWQBuQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88acaf62-6fdc-4b68-f2dc-08ded8ed0e30
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 10:22:59.1112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcUTksiJUGv4TJycRtIGP0RejYwnUTcSFqzV/Z1jNTifce9UFJPywP3+oXubQyrOjWkiBDHbS3um8CCnkNAQbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9743
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

This uses the incorrect value, so update it.

Fixes: bb58d1aee608 ("gpu: nova-core: falcon: Add support to check if RISC-V is active")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/regs.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 397124f245ee..49591c3dcfa7 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -556,7 +556,7 @@ pub(crate) fn mem_scrubbing_done(self) -> bool {
     /// GA102 and later.
     pub(crate) NV_PRISCV_RISCV_CPUCTL(u32) @ PFalcon2Base + 0x00000388 {
         7:7     active_stat => bool;
-        0:0     halted => bool;
+        4:4     halted => bool;
     }
 
     /// GA102 and later.

-- 
2.54.0

