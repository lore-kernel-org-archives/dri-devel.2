Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA0DF436B8
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 15:33:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFCE410EA7A;
	Fri, 17 Apr 2026 15:33:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pkYkMAzy";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 715B310EA7A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 15:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9UUMZUHyMAu6PfjohiK68IGXbVhay3gVQcvbRtkaFlidhCLyMzGEXQPu1jm24vx/S4NOiqGd6Ml0JHZ7Rije4uREG8uK+gK7sZl0/VZ+ljDcbznYMIC/JNtC28vfWhDHSpWddia1XDSf0y6oCJhMMkxQ4iQnR76n8H2DV+G19hRdPTBT1XVUiTUh/MQrBMM8Faq6ZJG7LkhENFTaLqsfqvrsrIPzZcLnnbbqnNJvN3Cdi5QG+NyjAGut1m8yzEljGfClqLCjJR0Tt5VsMwERhhf08gWTqBAjshQfbVoGXxtwKNSQtVZGkuHwZ+9QDFSSuLRmQXquhPGJaMjq1h9Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjXzuZYc5YKdS0JH7/rOa2zGw8esB22OxK2M4uT+qe8=;
 b=K+F/KlLWe6W7gZV6vtE797t7mlQ3fp8iVZyqHu6ebK5QE8FdYbwFSLj/sqAP41UkQqFqaE304FCUeLw9zld67Re7wJiqHqf3qGq9lXrWVLrGejXRigQKF6x/nm5IKrlcYekmWvK90tVf1W3tve+V18PSzN7la5LoxKKH3dgacuYzl44LQUqUTqcH/aUsFi3O695IeqKZknHpBGUugLbzR8zRc9SKwoIFCIO8HoQFuRjAMmuQOlRCgbxrolarvsQg5wZYAr93x9UjpvIF7q/b95ee5t4fOtai9yXFkD5N9+I3YHnGndyAUn6aFBbI7BixCezVp7/tWT1ZWNqCFApNdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjXzuZYc5YKdS0JH7/rOa2zGw8esB22OxK2M4uT+qe8=;
 b=pkYkMAzy59eANOCwncMK7KT7SQ1MppTfP7HHt3cjWPLYrB2uv8KLqPcg736B8YnJltpkimTxwbHaGzZMAPrtk7UtzYukGPkmFxOrKjxDvIn4l1DgRbT0/TWTrHtltHpPYGJbtHgHuDIwY6Ng1r93YZmRItjQat5c4+UyPNW8PlgJM0r28MLALN8MlngygJ7ljCepQ0K50HAPEEzB1nSXMi6RL40YGh9BRjEOWwi0ZWfNOptVYpe+iCvK23UNiIrRmxKfXDRgwsrRTYT74ecQFTMOPTltiHLGtZYzlwVkyHX9/WSUsY+fo9NCFh/ulMBh/2jySVQmIV9XaIuwLuF89Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by DM3PR12MB9389.namprd12.prod.outlook.com (2603:10b6:0:46::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.25; Fri, 17 Apr 2026 15:33:52 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 15:33:52 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Sat, 18 Apr 2026 00:29:23 +0900
Subject: [PATCH v4 5/8] gpu: nova-core: gsp: add RM control RPC structure
 binding
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-rmcontrol-v4-5-fda8c76dbb95@nvidia.com>
References: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
In-Reply-To: <20260418-rmcontrol-v4-0-fda8c76dbb95@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP286CA0260.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::18) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|DM3PR12MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e32e25-e082-4f04-b3cf-08de9c96ba66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: VafsnPSUoAehz5bPul0XHAKWK1JpIFF3nKm5/QglppTzyEcqNHGrdsGXCi/twfOYNGJPNgPM4pNBCvpkNC/npLZ2lstjukEGPyYS/xoRZYyxDEP0DcE2XKdBQAxzLRSaIfpwjAEIaGlIhGIJPXo/Z24tP4JZVc/FlmvAs88J9z7kgqfyUtovSRju56JIpdUmZm2rK/8nhoo1SVo2kjIlNV9bBxeU5w3kYkvhbn4gNQPPpJVFnMMKiVf/RBcp0Cp15aoN9VdAvL8s9QSOYvet/NxTYc3uhI86jSjol199C9vIDlMd5C+SRYzgbHpYW35r790u2MRTJftLpI9pCNeOorcAy9WvEBYXMhziWEtbl+zQY9OqbKkW8rh3WD+Zh22RoBIt2OmoRVehC+8ulthOFETqUrp1uGNPCMZa73LRzij0djoHIRmcIVzND8Wfuvkjtehmg+wnSHKhAEsGJ7ybwvtadCGZzu6fFeEETPpcqsImPPXGL/515xmHJwPh2B+6tag8DeeMFID6QUghBJf+TtpuqRBH1yGNncNPBAU6L+aWWyQ6QabD2prLAT6V+xJQJKT8/uhe2sMsFaauOAwjvlYq0XgyRrH9qXXOyqdkDHcGHe7+UIcw5TUPs5Y3ITjTcZVoT3NBzTDzUjFvJ2pj5Co1tcsnH0e7+QHptgGGpFWngYIafrRgw0CYoElTJxg5Jo+VP/s3alSm3PyDaX3FEyQVSxnadb1yJBaSOQd5Lo4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGhrUGd1WnA4NndPb0lkaVU0b3lGUkpKTEhqZnRad2RKeHRwVytPYWw3eFg5?=
 =?utf-8?B?dGsvV2hiZVFjNU1TSEtKQVBXblQ0eEtGY1lTaW9SaGlBb0E0QlZJRHRrZ1c3?=
 =?utf-8?B?VFNEMU5YbWhLSDIwWVZES2hwdStXbys0a2xHV1J0NXY2ckdRRGJodis2MmZX?=
 =?utf-8?B?QjhYWTlKMDNYcjNRbUJkd3NWZVY5KzNzRGtHVVdBRjhkVzc0cDRXMlRnQXBN?=
 =?utf-8?B?cktVQ3kzZmhkM3JvZkozOFBMNnNiMGJGTDJiYjBoWU1zcTlXWU1EdHBrL2dl?=
 =?utf-8?B?NVVZeE9yeEt1QkxDbXVGNFhxWVcvSVJ1NHpNTjNYL3VRWHlDT1owMkxseVNT?=
 =?utf-8?B?WlptZFc1MWM0Z3NKVmFuWi9aWk96SFM1Y1RUaTdqLzluenZJSGVycG40UytD?=
 =?utf-8?B?NkRTYXNOaS9RZktTcGZNYjJWYkxwSk83MUc4RzJOaGVPZlZzd25QVHlCT2Nr?=
 =?utf-8?B?VEVYdUVJdDNCdTJiZktxaFFsSVRnU3ZORUNTN05iREhuZVJoT0MzbldmZnYv?=
 =?utf-8?B?ZEt2M3FtT283QjJJVlZ1WUd6WnRNbm5KdWJrME5McS85RFZ2NERpU3RBdzlr?=
 =?utf-8?B?M1dkanJtbzIyeTNjdFZKaUpxYmlPMFJUS1JTV2F0ckdhLzRPb2ZYUXVkVTRo?=
 =?utf-8?B?ZUJaVE05R2FtWHg5Tk1mM2QzcEhsbDl5SmsvUXlBYkVpZHNHb2ZUU2xpVlEx?=
 =?utf-8?B?Qkp4MmhpREtYS3hLSVNRbDNJckI1MVp4YzhPYWdGd09aR3dHQWZCNG9ScDdH?=
 =?utf-8?B?N2xYQUR6STM5aGhEZnU1b092bGVNeHFDRnE3VWcranFlbm9tUGkvbVNGTzho?=
 =?utf-8?B?UlpSb1dxU3NwczR2WEZyRnE5aXdSOUIzUzBkcGp5bVFjSE9qdzhnS3UvaVUz?=
 =?utf-8?B?bDRNQUJDM1l4UXZsOGM5ekk2T1dMWmdIOFFUaHR5NDJrc0UzNE1qWHE2WUlt?=
 =?utf-8?B?VTJqWXJnYjNoL2d0b20rdUVIc3lKWDN5QlZGL2k4aHFKYVBWU3h0TkRydUZi?=
 =?utf-8?B?YjdiMVdpY2JqOGx3Z3FFRmN4NkJqV094WDR0c2VmbjhXU1VaQk1pTTlnYXlt?=
 =?utf-8?B?QXh3WE5UKy9HZlV5YjdYaHBpRVFaUEN2TkgzZkNickFROFVjRXpRdGR3dlcz?=
 =?utf-8?B?WWw1V09neW9RNm95WXhOUE1odis0aytIUzJUNFIrQ2IxMG0xS3FWRlFiZzZ4?=
 =?utf-8?B?TjNCZ25idnF6M3VwZDZ0MmFtODRzTVpzWFJwbkZwM3NzUHhUc3JINjc2aU0y?=
 =?utf-8?B?aUc1Z0x1SEVnV2dkb3ZqalBhR0dFVVBVaXpBdkh2SUxUTmFWNVROQXR3d1RV?=
 =?utf-8?B?SHJtL0p4ZDlScXBOQTIrWDE1TysvcHBCT2wwSTg5bFlvUkI3ZnlkS1RLK0g3?=
 =?utf-8?B?emJiK2VQUGxwVFNJSk9BVU1zS0RaSVVOWGdXSXpYMDN3T0RMSFB1eTIzekJC?=
 =?utf-8?B?SFFmaUNqaVdnUlBlRC9JNkNZSFAvWDU2QkJyTHlBdmgzU1FQSE9HZkx1RGZW?=
 =?utf-8?B?UDRDVjJDWEZXUzBNcXBqVmpNQk5lMVFMbk16UVhNQ0JBNzJscytWVkl4ZFRQ?=
 =?utf-8?B?UUdEanlBbXY0Q1ljK2REdERhV0JQTGhWNWhpT0IyZHhUR29JMEJaeTZNM2pt?=
 =?utf-8?B?OWwwQ05ZOTV4Y2cxQzdsMS9qTzZoZm5URUxNTUhPS01IS2RnMDBZN2YwUWxy?=
 =?utf-8?B?cUViVG43c2p0L1UzZU4vTnE5ZWZPTDYyRkxCMit1UDhsei80bGJ3TkhKRzZT?=
 =?utf-8?B?OFdzanNmVFVUMGFYMytVSXdDVHRQZkp6MXJPa1Y0OCtDb0hER3ZvQVFqaDJs?=
 =?utf-8?B?NG9rOVJnbTBnMCthY2tHcVdidGFabzZBRFk2SzRpUGk1ampoSzdpejZaQ2FV?=
 =?utf-8?B?TUZCUEpYdmFPQVozZGljRVl2SkU2ci8wT1lVbmdHaGNzOUJhYTFmNHF2ZVBN?=
 =?utf-8?B?bnA2UHlsN0dubE5uc0NOQkpHZ3g1dVVTa3hURTg0aXZyUkJHUzZudXI5M0oz?=
 =?utf-8?B?RUx2RGgzNzQ5SEFsSUFWYmVkR1JqRHVHbWxEekRRTU9NYU93N3hzTkhrNzFk?=
 =?utf-8?B?WjNGRXRjOXFDR2FHNVdJSlR5RC9BNnFmUlRJcS8wUlRCRmJKaE9BMW11UUpD?=
 =?utf-8?B?NEwvV1A3TGd0anVnRWlmVUJxb3R2NytmUVJYMVo3a0twcUZzaUt4dWN1UUpS?=
 =?utf-8?B?QTZwNDJJeWxtN0xhN2pLTS9tdndrUW1FSGRtRTNnNGdhQlEvWDRIZjJ1d0xp?=
 =?utf-8?B?eWJtTDZVNmRNT2prcWdVOFlPRzFhaUVQMjZvVzNMeFJxVXFBRTI5UGhLeHBZ?=
 =?utf-8?B?bSsrV1hnL2lpbjRFRG9tUGRWKzVwSi9UOGVVNFhRVytzd3NYK2lzeW5CTDBP?=
 =?utf-8?Q?Nx7N3jnBpBY/rRllIeZgcG+yY2n4RrZls2j7sZ8AmMAO8?=
X-MS-Exchange-AntiSpam-MessageData-1: 0XJcM7bBLR+7qQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e32e25-e082-4f04-b3cf-08de9c96ba66
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 15:33:52.0423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1iiKs2+7FRwjB8Qcpyk1hu0O0Mp2buvXCicKn040zkqcNqsQo0oNZTGU+hMZaTBC+mDBO0pFqByjKSGVYIn29Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9389
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

Add the bindgen rpc_gsp_rm_control_v03_00 structure. This is the
structure for sending RM control commands.

Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
index dd37a7fd58c6..05e205e6dc58 100644
--- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
+++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
@@ -1025,6 +1025,17 @@ fn default() -> Self {
 }
 #[repr(C)]
 #[derive(Debug, Default, MaybeZeroable)]
+pub struct rpc_gsp_rm_control_v03_00 {
+    pub hClient: u32_,
+    pub hObject: u32_,
+    pub cmd: u32_,
+    pub status: u32_,
+    pub paramsSize: u32_,
+    pub flags: u32_,
+    pub params: __IncompleteArrayField<u8_>,
+}
+#[repr(C)]
+#[derive(Debug, Default, MaybeZeroable)]
 pub struct rpc_run_cpu_sequencer_v17_00 {
     pub bufferSizeDWord: u32_,
     pub cmdIndex: u32_,

-- 
2.53.0

