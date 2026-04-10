Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A37E99055
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66AB210E8EF;
	Fri, 10 Apr 2026 08:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="CXyoaewC";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012023.outbound.protection.outlook.com
 [40.93.195.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C077B10E8EF
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 08:39:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYhFmIxWOSq36zJCc3Pobhr7p5BYaGrwAwH+3j/IGLvHrmH13RbAEqpEgbkNCgdc2N+4fvqyCu9qknMv+qUkEQ7U4UivbSqXMR69EvivEUeJUhfnR0QhN+/Or3fTRJgzvoJCe9o+jHHGza+M2SRALkZBRUuWqujbznJdB52361UpBM6VKvcA37zcV3d3gKmbwTeQME6Ok7si3UHezqQz25CrMAS+lVRClrZ8wDBO7TIq3meM9fNuexUQNoM/u4c8rV/MFmAdtylWETufLSMs+CQLPK44YN08YSmYTWkU9WTB0jRrfqpLSiBVgseh7Dj6jS0Nv474uiwfeSqlHBeVIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1ZcVTMHbLandu8LRIBJAGQpcSfyeXMEvJnXiD7UwsA=;
 b=KCoKdRG13XlEG8PLqfty9NWIKfSzUUYGQqk6ngD0OEYM2qTKgjXpxml+6T/tGL5rqb55Nrmkoxp4BVBVNZ3C2cWa5gfIMZjSbSAOHO811Ufi7GP1dctEGyOv5h1e2DLnKmj1onvL1QeqpTw40oCDDQwx3PZ9LxXSYUEGcVMFmdaJjzLlotEciWmExR1Jd9UG8PcBhmpJlPKU0p34gbJ6eXScUEYCpf695ppw51/+8jK7mdxf9x80ulB4emek1Q/eE/yKLyrOh4NeUI/6pHPagWb8otnB9AO/yCqmwytLmg3ivA9fZ6o5QbUb4OBsCiG59yyS1YiABlbgqcB3niVCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L1ZcVTMHbLandu8LRIBJAGQpcSfyeXMEvJnXiD7UwsA=;
 b=CXyoaewCKfVC/x69E/+pHns68Upv0iz+VKvsZS8WJAW+S4SXg6HKUkD1QCDYfNzh7yI9zqDPSipk17zGm2Zcvd0WTBfFbKPPnd/BHtEnN7AingcpAOfgD6qN0cKganiBbKAkSXzvPN/54sNqsq5akbbtIRzDXuayyxDn7HLvPgyTCS7vwL2vjrsPy16qson2XBTurj3Nru+EfemY+cWKKV/XTuZqkFLDHh6bGp76cChLhuKbFjhEpkmteEJiUVNrgBCllhBZD7h6glK0zMTx7JVPDyHYnElbXnh4xENLaE2rfWeOzVApq1XWKYkhQP0zrVDD1ueRaxrPutnfVq60Hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 08:39:26 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 08:39:26 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Fri, 10 Apr 2026 17:38:53 +0900
Subject: [PATCH 4/5] gpu: nova-core: vbios: use checked access in
 `FwSecBiosImage::header`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-fix-vbios-v1-4-bc6f71d153d6@nvidia.com>
References: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
In-Reply-To: <20260410-fix-vbios-v1-0-bc6f71d153d6@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: TYCPR01CA0189.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::14) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b51e39-487b-4276-705e-08de96dcac52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Aug601WM7HHNp1AgdgDccAQ3xbK+Sh9rE3zVEns+tyU71k9gFG4c8UUSAbQlqoyJP/EM0HPP/M1OtnStrRyuy3PIhQw35dOKFKYW2YsnzkbSvhRWCbpVbcABi5se5759p+ghBpKXvJM7XzgvlrPDwhxWIBYJwAqa0tZrtRbmc1KzUHkeo2xL2L2J/Vome88bYUn9ZQoDtf5auISE/kNDtG9nSFzCsAbVM+pDj8XCE17D9KThvUgJZX7G6drqPqUpqGJsEtZsyhTbLRjzG6QYXQXDpUqPPhS6QHo8tNbUXcI+186b01fJU/PibhYA8JjcJLsVQWy875q6WNXNGksBJTH36mvYQGZ47bqmNuHASaofPH3kWqhSj9L1Ijz25F3191F8DfsUKE6sDL4L+q43HjlDHoTr1nUg2ol9ZvEYeo9eXHuxKIdi40JUAJzmXy5Ty+JlYcG+d/X0Db/00tXbYW4AVEPTfLV65OO5Cq45c2kG+S/Np6hZpzKBPINwdlaAaJTtjiyguYO0J9VPVM2EyDJN4uXUiWDtkKf0ZjPdPKpd96dvlzmcz75o1IOy5ys9pi+s4RbaY6SpzHpuNVe3rnzCVGtvLUCJJD4nvb/Pjxmf4770obpB7x62m60DwaGIrYJBz3R2COLO/5np8LuOrSECrq/JoTgnAZxurjOLO//h5ZxopPXAQ44Lxl7pxSTmKxrf5rBKLVsh6PLYpam4RPzFftFq33kcmWQJjHeyRwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlltQWxBSW9lNkE4ZlhZby9wbDdvMjYvSzI0a2daajVwb2ZwbEw5dXVJT3Mr?=
 =?utf-8?B?b1dOSE9pL0xtOVE2ZUFqTGNBdEE3ajNMVVZXYkNCV1dveUpUa0p2ODExTm5E?=
 =?utf-8?B?SmN3WXhMeG5wTXlQa2JlVkpuSUxVWVcrK0pQOHNhVnVBMVZyaFZEelBMVzlw?=
 =?utf-8?B?V0VKbW9kK1lCeFFZYnh2dHhNdEJNdDFyMVhlT1Z0SHc5d1lvZXFjVVlxaWE1?=
 =?utf-8?B?RENDZ3ZaazVoWGorSUlxTDkzQWN4dlFNZ3hsMVY4S2x0YW1yWE1RaDhqOExx?=
 =?utf-8?B?N3RVYkJPZTFHd0xFaldUV25iMUYxMmxMRXJ3QlNFY3RkaC9ocUpqaUh4Y1pl?=
 =?utf-8?B?dkV2Y0R6bVUrL1Y4STlKYi9zVkVSZUcyczNqRlUxanFxZUNCZXl0aWpZNUZI?=
 =?utf-8?B?MnMzYTJreHJxYW1IT2dDSlJacjlpVDBUeUEzWXUxaVQ4M1RLQWNvZmpUYzJ6?=
 =?utf-8?B?NzlQTmlsbldYVmhKcmVUcGcrVXh0Tmw0amdITlFVV0IzZ0tQc3hCQlNYaUx4?=
 =?utf-8?B?dERNWWVvNWtERUlLWmROR3lRbGIvbXBCSmdKUHVmMkZNZ1BCMEV3eHYxZEZZ?=
 =?utf-8?B?OVVBU0Y2ano3RFI2SzZ6K0dlamRQamlKYmdYN2IzNE1aT0Y0SHVXcDJjcjF3?=
 =?utf-8?B?U05xOWxEN21ML1U0QlhQSDVDdVFyZTdnMFV4V2cvSER6dkZtcmw2QTk2TkF6?=
 =?utf-8?B?c0oxWGRBZFFjSWZsMDIvOGNMM0kySWZES2NRQXJmbW1LcWJ1WCtYN1BtZzVF?=
 =?utf-8?B?T0theVo1NVh5YjNDQnNPYmhSUmR4S0VyMUJkcDlEQUVtV2ZVWE12R0tRQUtK?=
 =?utf-8?B?MXdoNnRQWFhPT1JmTTJvaFlNRzFEa0JJbzNNaUN6ejc4OC9QZ0pHMHdzalZ3?=
 =?utf-8?B?TGhrTXFsR2xtLzRlSHdMYlBQZTR5MDBrY3RBVGpYWkt5RmtJbGM1VkNHa094?=
 =?utf-8?B?MFlmMG95eDNYOUhaZVV5cHNoRWZkaWxLOFcrNEVLRlQ1Zmd0Y282VDRDTDk2?=
 =?utf-8?B?djRTKzNBUm1sZkN3YmFYODVvMzc2Qlp6OCs4aWttTVdwT2Uyc0tndERxV2Vv?=
 =?utf-8?B?NHRnc1l0RjM0UTVwR1dONE9LaXdVMHlVaGg0a0UyNjF4WHFlU1VyejVOVnQv?=
 =?utf-8?B?UHQwNlpMenRlZXRIR2VVdlkxajJQcy9nckhhVkRhcGF6T0Vsa2NDVGR3STdF?=
 =?utf-8?B?SFN2MmVTRmJReGRGeVk1VHY0TDBxVUlIRUt2OWY5cFRSSXhLTGkrc3Examkv?=
 =?utf-8?B?TTJyaHhNTEhRanhvVFc2Qk9KZ21tT291YUtva05Ma3FYSEtBMEszc1dub2tH?=
 =?utf-8?B?ZE5ZbDdBb3IwaFJ3Q0ZNVnZqdFoxM3ZIcllxU0M1dUVkck5leVFVaTNzMlpk?=
 =?utf-8?B?a0E4Vk5rQ1NQTmxIbTRNa0k0V1MrL0pIZ0xoRlpWZjg4bDY1ZW9aeVI1VWZY?=
 =?utf-8?B?UTAxSy8wdFo3aSsxMSthRXJUQ1hoTzA1ZWNyTFdhdHpXejZ2ZXpaMkhHVkMz?=
 =?utf-8?B?cE52RWZDU1o2OTFPN05za3IrMURaWkpUNk5OaXpBMGpFbmlTQzZiQ3NhR08w?=
 =?utf-8?B?M3ZtcWZvc1FqWFRxMmsxVjhheFdBZmRyLzU5SU43ZzhTTW1RbGFQMVQzdmF1?=
 =?utf-8?B?SnRCSXNQZzIwM1ZocDJyUHozbUpPUUJDb0lRVU1KclA0eUxjM1dEM3BDK2Z5?=
 =?utf-8?B?UCtUcklDM202cWVIejNUZklkeTlNUDFLSWk2aXNlWWx2bXNVYWdaMEJ0SGpt?=
 =?utf-8?B?T2Q1d3o3ck1iY0V3NVZJWWpCeXM0MklCMDhXSXYzUWNsYW9GVklDeE9JeDEy?=
 =?utf-8?B?Y0ZwOFRJVkI4Mnp3Q0kybGo3UU9MWGZKU1JGdGM4bzdSU1RrRHVUZWxoL2FT?=
 =?utf-8?B?bFNiRGxsa0ZSTmJML1FvSVlWeVhlb0hQcUI0VzQ1MFE1QVBIWWxjcTZTTUFt?=
 =?utf-8?B?Tml6NUFSS0F4UFVzSDlnQnAyaFZIRVV5bWtXMDlkZGc4d2g5a1FtN3FZN2Y2?=
 =?utf-8?B?bmphL0ludm11VXlaakNqQWxrMUJWTWwwQ0hwMTI2SlVtdENwVThlT2l2V0c4?=
 =?utf-8?B?aWRUN2dSeU1IZHpSbEREaWlVejBZR29ISVhqM2xkb1hNdEIwTkVJMWF0RXY1?=
 =?utf-8?B?UHVSL0JGdnVjcE0rL2RLQkpVZGtuVjI2ajcxQk9KK1BaMGN2bFhQSDZMRUFT?=
 =?utf-8?B?VHp4UWNZelhQWU9RRXFzTUFZMTN6aExaYVJSdXJocXM1aXVCelpvSmNYN3VD?=
 =?utf-8?B?eTFZdjlGcjJPSXVZR0JITmhiVlIveWZ2eWJscFdSWlp6YktVdGxybEhPd2RH?=
 =?utf-8?B?OUdCWmVyYzk1Q0h0bEdBalc2SVdobXVGSEdsUkR5NHB5K0lXOE5UaVkyclpv?=
 =?utf-8?Q?cHtLq+zxm2nJW/p01NIDpBQL7nog2N0Sn8sDO62Ryxwru?=
X-MS-Exchange-AntiSpam-MessageData-1: ZGhtgNKsNDr8Qg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b51e39-487b-4276-705e-08de96dcac52
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 08:39:26.3007 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uqhw8uzh/wgllKrL5jhx3+y5CbRGfsMBhJt4tUIuqIe4t5F8EQOs6CN2MjLnwhaDc8h7KhN53FLwP0njnHqi3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
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

Use checked access in `FwSecBiosImage::header` for getting the header
version since the value is firmware derived.

Fixes: 47c4846e4319 ("gpu: nova-core: vbios: Add support for FWSEC ucode extraction")
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 2b0dc1a9125d..3bd3ac3a69f2 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -995,14 +995,16 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
         // Get the falcon ucode offset that was found in setup_falcon_data.
         let falcon_ucode_offset = self.falcon_ucode_offset;
 
+        let data = self.base.data.get(falcon_ucode_offset..).ok_or(EINVAL)?;
+
         // Read the first 4 bytes to get the version.
-        let hdr_bytes: [u8; 4] = self.base.data[falcon_ucode_offset..falcon_ucode_offset + 4]
+        let hdr_bytes: [u8; 4] = data
+            .get(..4)
+            .ok_or(EINVAL)?
             .try_into()
             .map_err(|_| EINVAL)?;
         let hdr = u32::from_le_bytes(hdr_bytes);
         let ver = (hdr & 0xff00) >> 8;
-
-        let data = self.base.data.get(falcon_ucode_offset..).ok_or(EINVAL)?;
         match ver {
             2 => {
                 let v2 = FalconUCodeDescV2::from_bytes_copy_prefix(data)

-- 
2.53.0

