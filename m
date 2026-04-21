Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC09F327BF
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 08:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16D3410EBAE;
	Tue, 21 Apr 2026 08:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="rTC4gtwU";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011024.outbound.protection.outlook.com [52.101.52.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90ED410EBAE
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 08:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDHUP7umjvn6+2vR/GCUzffnbx36khtQzZQN9Acr37mAoGiVbvltrCsH3ybDJe0iasSAqM1t4GruOzbed/Dr2YpfRGeeaIgQhBEOtfaMvjI548iu3hrcfLPW/ZFRK+PpFh7RWm+Wlu0/xw7At2ywmsC27dhxm17sv36zuXKVj9qnPjnAqzqeMYi28R/34mqBe1CJt1PSbOiWgoy3Qw+qhLHnnfy5oZ3fDkA0xzCeo+o9qRn0yYPe+PVZkdR7wOeS5tUVEK9Njz6/H8DIKsBvSuUqmz7IhCiJLbSjRTSDSUOztZilNpJ/dsYgXp6FlGlfjTWoFtILyBgWB4RYX8b0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9V4C9v5I2y0HDEtk4sbColYTQ4PjLwikcDolOLWdOaM=;
 b=lZR20VgGCSFt/5NcsSioPxmmeibiDm9PoWHIxpze5pX9NJ5Xy1ELmJcqLZ39ePCuEpPs+WS4aEEr5D90lt55Un7LbnffFXvntImTLBatoPa5RSrdFzySaXjIQMQiR7WwJbNK+lqTNbt12Hi8mhU6o6Fmf22c74bPwMr6wMQPZCyDFeMy/TUNgkbR1pGuws3UgNVYzOmsNZaDKj6Ifu35AYX9Sd6NkD4Tn88iQibNh0TGjwZtCQ3NXJvnSPhvY2Tngnhr73kGVZfCPIKc75AzTUo9R+/46CrVrkUKsTJ0gQcJwzvY1TAMWO0mdwB3N8+Ri2Ntrak4hPxhKis33QbGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9V4C9v5I2y0HDEtk4sbColYTQ4PjLwikcDolOLWdOaM=;
 b=rTC4gtwUcyXgPQu/SDwormxWEhCzbpYllh+NGdmoYO8lims2UxbnUKxyE+sBSNWicbG2o1+4JEYFJ8mXNIuoUV54Du/Jf7crDZ3IKiSkbFwHSQunQGOYX+faxz8RF2sn8NLsQyXmhHgyakfD56ltdz1d4oAuRRpk20Ovwt1vaOJcVNZm3TOgt6plwV81DRfULczGvNlcHz3bbZvffu3PQugMoqy842DZbBK9zs2s5AD3GPeUEWMTcJPfqIZOfYCn9gD5H3bqYWmlQExhJ2Mp+CGYeBX4usspQzTqlMr8W0JCnTsAiyRkqGsF2H3sZ+tzSm0rAj6VXFceX0iS41xLIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:20:56 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 08:20:56 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Tue, 21 Apr 2026 17:20:23 +0900
Subject: [PATCH v3 04/11] gpu: nova-core: vbios: use checked access in
 `FwSecBiosImage::header`
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-fix-vbios-v3-4-8f648aef7a85@nvidia.com>
References: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
In-Reply-To: <20260421-fix-vbios-v3-0-8f648aef7a85@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Joel Fernandes <joelagnelf@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0099.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::15) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e90edf-9782-4df5-d964-08de9f7ee95c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 4Ln3mnnpheKCmOUlhgG5O6xbIQ/gdcV5Dq3z8h+34ELqlqPgJ6IHGJNpblaNBSBcK1JaQxV+ta9HmpopWp5RvJ0vdbsAjbTOewIvRzVfKGHwBvgViNF1gLY5/JM2WTbYx9PDzbw4uXY1hkM5JtyzTBmBxrC4pn7hfDSUEEZQg+QF9rcefvNR4Cts2r0CVM0/yfzQJ70YcZ8+uFnrvQ+sJfFOh4BmK8Wg7OtgjLsgou5hmfpmem38Esaz88IGhriRY15WriCYkbbzg87zMtwyDa3GWwu1R8ZGx6vfQZc8n8fo1MzFGA0WTDpNR04S3LcEzcIRDmKFveA0xfhR/Smm8IXTo+DfHiKQLj+pH4Owc73fPIIL4Kp812PmKbXmxK9KuoCNwNUy3kMyWCUbusYlmin2pGn3hQJNj3EUSqQJvMgU/Bum5SY4G2IST2oNtzhs83Ozvrlcs+rQD51C8NG27qgBUJsWgqKtrtbi2VC/FDIm/z3Ibd7DHEUQDAGMqpcoOSX6lpKV2pCNCk7KxShIiIXs/lgjkGEfCLPdul/4HCx/y7Hkyb/lwEsRoYnTH9dykTORZsmEt/wm5sTZqs8EhXKtjRAIo0fo6SklIo4rQEUP/ctGzHVno0jFUy5ZSLR7HtlO9/g6pkdZkxDxwX3oiEbyK/5HLUMY/OIdCBmcLCmQou4Hd/5uaR09OwoyYIVNVWw2OnXtPWP+smBXhBhnPh+X4cZOyHC+tmEFdfOWjcM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnhEaURMQlpNaUdqZ1NnSVAwTktjSlN3cUtrbG9kY1RXVWhpTitUNE5IZUM1?=
 =?utf-8?B?amllOUcxNXU2cEF2S0Z3SDc0aE9zVi9zNWFCODFZZkdEYnRyOXh3THFWTDFU?=
 =?utf-8?B?UGVyRVVYUm9OMi9Ic0I2TDZNNUZOaEplKzlncUoxOFZsUVhmRWxMVStPdU93?=
 =?utf-8?B?eDFEQmhHTjl0Njhxb202aUh6ZzJ5ZU12M3l0dGFkdUNqb25JQ0M3ZFd3UWx4?=
 =?utf-8?B?aHROUW5yb052OTRmN3hzSStBZng5WEwwdjFoV3VzQndRbEd3YitzTWRRMDl1?=
 =?utf-8?B?dlRnaFo5djVpdVVXUG53dTR5cjVIWWxHWTMvdlZHeDRldHVMNUFWQjJxdkdK?=
 =?utf-8?B?dkZISHZRVmx4TEtCaS9FbHBvOWZnTThGS1AwdkFseVZrT3JjcVE0c2o5eGZy?=
 =?utf-8?B?bDl0K2RxL1daM3locmxNaEJIbWtxK1FWM243RVVGMDVCYWJ5TWpOZ1JVRHZu?=
 =?utf-8?B?L21NT1J0QjdNUlBPbmRNb1NXZFpXdjQ3OFhoTms4TmVxc1JITm16NzRnbDhV?=
 =?utf-8?B?RGtRUFFZa0xjNG11SUhJVkFWMjZiaEdHQmM0eU10RzNWTDlSMFl4elczOXN1?=
 =?utf-8?B?b2hrRTlLQ1pTK25BS1lrQWdLUENvd1ZmbmhwY2RvL0NUQnRZUEpHbFI0bXcx?=
 =?utf-8?B?ZExDOUcxd2tkMVo1MXpXc0taT3g0aFh4OVJ3OWVEV1U5SXlrRlRpMmtQWjZK?=
 =?utf-8?B?V055dVpvMVg0UTZDY1hja2YzNVZjekR0SGU0TDZ0RENpQW5rSUZ2VG5hbHVJ?=
 =?utf-8?B?cTE1TTJISEo5bFJ5M09uZlQwYWR5a1oyVC93SGV0UVZvU0xXQzlxb01BUDcy?=
 =?utf-8?B?Qm1nbExYL1JyNFljTC9uRlo0OGRHRTNaN3NmTlJBSnVyd2JXWHJVZkIreDNk?=
 =?utf-8?B?bC8ycmwzOHRaQ2U1UTVOb2x0SlJPL3pETFBhQkxTeFRqOGFVZmZJUVlTK2hy?=
 =?utf-8?B?U0IzeGUyN3dqenlvVzhFNGNweENIMGJJQzdjRkpZVC9zby9HeTlteTFoKzNl?=
 =?utf-8?B?QStYV3BpaVZJNjluNW00RVBVZFpaYnZIY3UzeEVnb0F1TXpITzlNQktnLzc2?=
 =?utf-8?B?NU1SQWhKVmZaeUxZMnRMN1RjNGFLL2V6SW9ZL0NnV1doUHFIYVRicFhFUXZL?=
 =?utf-8?B?M0NzZVp3U3FxbFNLOXRFWk5NRlBid0hkWXk3TWNlam4rNFhHVzdYVEpSY05o?=
 =?utf-8?B?RkNEcjZCbkdhVkJuOEZDZnNJaGN1SVhIdkg3WGlPT1BiWldLNUNuVTNzMHJX?=
 =?utf-8?B?QU5PUzFsTUs0MTZmdlV6dWZ6TlVUWG1IOHh6bDF6MFhIMG85ZWpmTGl5aldX?=
 =?utf-8?B?c0xVL2Z2dmZGRG1xQjFRZk9iZmVOeDFjZzlQMkIxWnlBMEMvQ3NYanVaN0F3?=
 =?utf-8?B?Vkk5d201RXdCS3krQjVlSHhxYm9ERjVCNjloNkFueVRORlo5TS80RGEweVRz?=
 =?utf-8?B?dHhtUmFFNElTOGNmYWhUUVZQUUxjOEd3enVqZFlCZlFSd25Zd2ZiMTBFSkZV?=
 =?utf-8?B?eXFYSUNQQ0Q0ak5meXA5ZktBM1FyMzdVcHRFQm5ydGtRWGx1akxucFlLRE8v?=
 =?utf-8?B?VGlPUmQ1WXhoaFRVSDlMdk9FUksxaW5DZEovWUVFclpMMTNnNnE4Wm9KOU1M?=
 =?utf-8?B?NlhvTXd1VVlsZ3BlaFJVRThSaDhTWnlGZTZ5V2F2eU1jK09yLzhXSWozQXF5?=
 =?utf-8?B?RzYyVHp6TmZrYzRuNTRIYmxtR0RmNFpibW4yZmRad04xMlRPY1dSNko0TC9L?=
 =?utf-8?B?L0NQZWY0RlVJM1N3dUZwNW1CRWJuSTl5Yld2bTdlbWpRV0xmOGNtWnJ2YUZP?=
 =?utf-8?B?NFg1cFlVSXRWdGVoQjJ5YXFEVmRaa0w2V09YdXMwMkpUM1BwTFdFcUdZNjND?=
 =?utf-8?B?cHhoSmx0M1BQZ25FT0xSMjlKc2lSdlBTUlFNc25md0t0MkVpRFZ6Z1NZN0Yw?=
 =?utf-8?B?QitnUHU2TFM4S0l3V0NQZFhjQ2lWdjUzQTBhTTN2UEV0bkZkRm5UNG5jcnNE?=
 =?utf-8?B?eHM2ME82UHJjQWVjQVRhN1pTNEhLNFIrRHU0Vy9TbHNxNEN5TXBwajhFL2ts?=
 =?utf-8?B?RWhKd3NlSDBsVG41bUc1alF4ZUhuUk53NUc4YUl1dDhLV0xSQVpiVnJ6Lzcz?=
 =?utf-8?B?WVdqS2xpVzUxZkpSRmRmV3M3T1djRHNsVzM4aXdFWnZXOGZodEEyUWdzTUJJ?=
 =?utf-8?B?QzdqWjYwMyttWUFReUF5L3AzZ2tzeXlOaEVrTmp3YlBSUlVIUmp6Q3MvS2U4?=
 =?utf-8?B?UVVHNkRwZGJ0OVpCK0VnU2kxekc5NHZ3aFRXZ2hxQXA0bUI3NVdoYmF2dGtO?=
 =?utf-8?B?eWRSdFB5OHlDTThwcVlSQUxOcmFuaDNCc3k1ZUZPTW9tbUk5UXFRMEZDVDd3?=
 =?utf-8?Q?tdUpGnu2bAfu5HQ79S+5YSHYVRM9VtaCFaFw5ZcPWP30l?=
X-MS-Exchange-AntiSpam-MessageData-1: swTcBMjMfvuQJg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e90edf-9782-4df5-d964-08de9f7ee95c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:20:56.4293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeVpps89AgVvFamXwItObLfonDHc3sfiNuI3xu8HAvSrMghm01ujb9FO6vIlF+a4PFM4Trqpo/J3OgDTPjlctw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
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
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 drivers/gpu/nova-core/vbios.rs | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 632c8a90ea76..bc752d135cbf 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -996,17 +996,14 @@ fn build(self) -> Result<FwSecBiosImage> {
 impl FwSecBiosImage {
     /// Get the FwSec header ([`FalconUCodeDesc`]).
     pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
-        // Get the falcon ucode offset that was found in setup_falcon_data.
-        let falcon_ucode_offset = self.falcon_ucode_offset;
+        let data = self
+            .base
+            .data
+            .get(self.falcon_ucode_offset..)
+            .ok_or(EINVAL)?;
 
-        // Read the first 4 bytes to get the version.
-        let hdr_bytes: [u8; 4] = self.base.data[falcon_ucode_offset..falcon_ucode_offset + 4]
-            .try_into()
-            .map_err(|_| EINVAL)?;
-        let hdr = u32::from_le_bytes(hdr_bytes);
-        let ver = (hdr & 0xff00) >> 8;
-
-        let data = self.base.data.get(falcon_ucode_offset..).ok_or(EINVAL)?;
+        // Read the version byte from the header.
+        let ver = data.get(1).copied().ok_or(EINVAL)?;
         match ver {
             2 => {
                 let v2 = FalconUCodeDescV2::from_bytes_copy_prefix(data)

-- 
2.53.0

