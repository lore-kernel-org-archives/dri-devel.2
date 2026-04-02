Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE938CC6B1D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 07:52:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A1B10F162;
	Thu,  2 Apr 2026 07:52:49 +0000 (UTC)
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazon11020128.outbound.protection.outlook.com
 [52.101.152.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91ED010F14D
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 07:52:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oL3Hm+wfWE7VzlYpqMGgeO7D058YCdZXnFpz7YlDJCIhqyBlb08oDfHt3v+YqEB1t/BkCu7V30j/fxAZkdY4nbkZMuVTf2GurdPsI1+6/B25pAunjmjZVA1UIJQ99CAjSZLp7uaU4rFlcGXeNprTJfcx9X/upumXtJDvzwlgvUbI5Wr6ykT1O9OXsbNil/Yn6k75Em5/afaNCwwY35NuCfpQamJlwOVc+T7wPod6h4fz45JY0Q3AFvA6ZuPC9woyXksPTtmbnrJRah+1DhMQLh+cgasDmx3+y7Iz9GGOa7x65whVBGxsBJXZe7Z3G01UlrbHCZ1ohcU9X9oDRQtdIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PHtcDmQ6D+SrnjgkNxZKtBFWgGs/5mFjGAooac/Vak=;
 b=qZ3rVbHSW5JeaHT5OIsLOqkVX6o15IHMVj50cVecppM/UqA4n8S1JgIrbSf6+nn0csZcKXDPWyDR3FR9MFssXhAgS54RfiCI/0FM4JkBMQgnxv/abNfV+iD8qehmYsydBGmohqxhEvRlC6IxYoye1PwuF0tKvBlJ8uGtVMQAl22DMWV7/aOqU3OB4u6I6hBFi0p17tFSV7j4dU79a4SrWu7Sksr8Vpk8nbMVwt9fmOvm8KZlUns0vB6yCu5j66wzvQ/gTPblSuXB/izNM6OvGDrK0MueE/QzFFoEAtGU5/HXVjqVfRJr1CWs3p8mnoinudAz5OJQxdZFNR+WskfB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:279::22)
 by ME0P282MB4413.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 07:52:42 +0000
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd]) by SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd%5]) with mapi id 15.20.9745.031; Thu, 2 Apr 2026
 07:52:41 +0000
Date: Thu, 2 Apr 2026 07:52:27 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: dri-devel@lists.freedesktop.org
Cc: rudi@heitbaum.com
Subject: [PATCH libdrm] drm: handle asprintf() allocation failures in format
 modifier name functions
Message-ID: <ac4gO95kLFfF29cJ@b22fc13bbf9b>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ME3P282CA0152.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1c9::9) To SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:279::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB4909:EE_|ME0P282MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbdcf6a-fd0a-4c4f-00d6-08de908cd145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: lwCma7Fw2vJ26PcREC1QjI3pIM5MN5hiJTVWNMLhfiBkYzz319K3ffx8/WMYAwJeZOmzJAbppPUxpCMceUMGUfzrB6BlscoqOfvdmTmARrGThVq71MjuorhjZ9K59fc+HoL3HnzWMAkhZb98YU+MuwKG5ALXj6tEWZgscD+3CDZo4NLBKDz/ZZCxa+bfgczyPyBMn4FOFGH9Xceeg3INf9ZyCjCK7n0LEPcPGtg24LgcMhRbuXw1Pmp4pbdVUeZ477fJXtCNcN6K9HoCMdsANNhGWXbrMuZJYVzPJ6fzOtQbmdhDMAk/4hr3w//8yN7CbPr5SiT1eZ+ItoGZYqKXiitw7vFagTs6N+1LoXmNNUvC1yMWJ7uSx/6kiH+ITOpYSSo+Uk5DJvwhOC2mxKA8jueNT2JHPksfbyAQF3P5/6z+77AfS3LFsQlOmG2YljtdnrC9fFveimo+U/lqcA3EsqLF0O7hAKDh7zPTImZr9wv2/A5de5LoQw4/g5Zt11f1DE/HF4mIYwP9uEGIss/xtq4qmCmpk+KhgqkKCsw8bET/q8GThxRy+BARJcrdfDJGE6mIg1IdXtsLS0KZ+MtD+M8PT0+hGRt/kELMa5cViMrwGr8hcYlgj0XEbN82Ysv9DOSlM8ux8ANbVnaCGCd5S7H87AvbVhxkJzLb598EK5YdMpuaAyTpSRfI+qVrRWY1JG90Ie0OpMIwb4L3JY0xd/TRmrxp/tJScm+srinMmek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KG+ugo30tYt6jjwhZS6zNLXN13LpF4uLCHEC0rbaPKj8CAxpLVzAnH7FnY7G?=
 =?us-ascii?Q?MoitcF92XvnD7wKZEFpC9KxRkjZmb8qSnS5JyYuc7MqTfaXwcRc8j4YJFmzQ?=
 =?us-ascii?Q?Gp9otSDj5lAM39vzRZ2kJlDgEbLtEzeRhKW0Gpq3TjoiQd/5zZcrYGkV69YR?=
 =?us-ascii?Q?/e4hmzjsKmyp2wP18jrO5SrSXa/qCEUa/P1pFv8GeuO1++YrorLzO15wkK0Z?=
 =?us-ascii?Q?Ioctf1hJAmJdRgU8Dbqamt3LOqmCCJllZZn12ALENbNGEK87oYeYensxBig1?=
 =?us-ascii?Q?KVjos3dWzg4Py5oJEO/jf1Dzf0Axjutt9yl9HQj3yrnKJ/ZAEHkE5A8+Tkmf?=
 =?us-ascii?Q?E7byNkDdeCsYc31S+4T4pH7jCWPUPBVMCebzrBsKZG12SBBhSTjKBTEGLv0p?=
 =?us-ascii?Q?tpb17cjkkgf6lUjsiGq3amUOotBMmh+CF5RXmJq3N7Oyxyw/fMqKPSBRJ/QE?=
 =?us-ascii?Q?oUKuZg01MXFkNJnHcznIw+fMRsnK4ngnNCMHyr3gXfyInTyW3AqI/G82qz3T?=
 =?us-ascii?Q?pJiOT0iSC/eEsd/FpBQCK0Un6Qblks0clXbnQ0fZer09E2MYM+yI+tYHArsY?=
 =?us-ascii?Q?VJWoE9m6gxsgNW9S05XyUHtJHgBgb5BtAyN8g9xTSED6Xku4lf0jdcW0T9UF?=
 =?us-ascii?Q?PF8pSJ/Gmxlqq9WI62ECZ0Epg74pa9cvhZictJPZPp0ERU48He1Shiq7m8FD?=
 =?us-ascii?Q?0tpZMUtH/QcjrEkMttJTyAdzd7SzOSkqALvxxTPUQZ3hP1/G8kYRPKVOKiCJ?=
 =?us-ascii?Q?ANlcPvPaAhxLiOGqw35ocNkRVDgB4PUN5TrnNNNNEFXvUzmzW1lsd/EagvTs?=
 =?us-ascii?Q?Bq8Qwj/NFCFSJUzwWtLBkfByQWZQO0hTtpehpCRkN//d/Jpp2t3+6pKwRdhp?=
 =?us-ascii?Q?7ahK95TvajYS4y5xYvIt4jz8hoibugS9LpwgaABV0tWg+4idnh+l5HplMUVf?=
 =?us-ascii?Q?OEG0hPIiTld5htgCVh89sJFG5oleZrmPLfH3leMRPGp2nne19yXD5HjetAse?=
 =?us-ascii?Q?E2IgAFrEM9+WL8PfQvFkPB7DpVzfyLOPvRa5N4uuaVzezKiUdBLMWbD77WoL?=
 =?us-ascii?Q?NJ/IHkEco156ZjttUKm1wW2WJv9dyWt3Lc5R0XTQEwOfkhktlU2Mjszv2Ceb?=
 =?us-ascii?Q?m0yRoqlzmc0GOkdSIdZNpg1KqRhYgG8NnR/tdBxYM4FB6fnVlCJnn1sJ7ylc?=
 =?us-ascii?Q?71yIv4lyJHHg9HeVDnUvLbEqh+NSMK3fWAVidFjHtV/vniTaInWqG5ZYyb0s?=
 =?us-ascii?Q?0O38TTGqEFMUJPBniEq/E0+uKUJBlKaMN7cfkDfxyEekN20plpXaPOwux1Jj?=
 =?us-ascii?Q?pNtQLZCDssh4w373DbJlPYGzsFqEvAmtizEmJpw5lexqeI5FJA8Zc/BLYbn6?=
 =?us-ascii?Q?jFX5hmBVB28lz6zYlFRSCv3j5h8I1FSk7KiBaFB6vvDqcUSQkA4e/nBxr27P?=
 =?us-ascii?Q?LDEzjH13ISCIsGiKtnZiujpPJvD2RTh4XYmSSN536okPtV3RHna1Nuj5AYOT?=
 =?us-ascii?Q?OkUhPyf96beS4FtVWjl1ZAIeiehCoFQpoB2clHF+k2uPWZY4xSX/DmIPluOr?=
 =?us-ascii?Q?Vg9koL8L1L4WL+xKHR3TKLb3UEIntIEhBafwVfYXfEn/Vfgele7+zoswF2eF?=
 =?us-ascii?Q?X/sXWAOZ9Bo2+EINK+hBR96MX9IP8x83MWGk+2JTsJZRaYQ4ThhK+caA5O45?=
 =?us-ascii?Q?39Q+3M59B8Vmqm7t581b/+E8RR02I3CYKpltQS1B1Fc0ga7rShyX70M5zJgJ?=
 =?us-ascii?Q?pLoFO2HCgA=3D=3D?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbdcf6a-fd0a-4c4f-00d6-08de908cd145
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:52:41.4937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFZDChwUFfaTnWl41wglzPygl8iHwJzG4LoZtjcJuo2dWPr0Y3Bf9wqXoyi+CZifqj3dVYyGPtvyEqvO00rHWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P282MB4413
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

Check the return value of asprintf() in drmGetFormatModifierNameFromNvidia(),
drmGetFormatModifierNameFromAmlogic(), and drmGetFormatModifierNameFromVivante()
to avoid leaving pointers uninitialized on allocation failure.

asprintf() returns -1 on failure and does not guarantee the output pointer
is set to NULL, which could lead to undefined behavior if the pointer is
used subsequently. Set the pointer to NULL explicitly on failure.

Fixes: -Wunused-result warnings from GCC
Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 xf86drm.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/xf86drm.c b/xf86drm.c
index d4bfec8a..3199715e 100644
--- a/xf86drm.c
+++ b/xf86drm.c
@@ -348,9 +348,10 @@ drmGetFormatModifierNameFromNvidia(uint64_t modifier)
      * testing against TEGRA_TILE */
     if ((modifier & 0x10) == 0x10) {
         char *mod_nvidia;
-        asprintf(&mod_nvidia, "BLOCK_LINEAR_2D,HEIGHT=%"PRIu64",KIND=%"PRIu64","
+        if(asprintf(&mod_nvidia, "BLOCK_LINEAR_2D,HEIGHT=%"PRIu64",KIND=%"PRIu64","
                  "GEN=%"PRIu64",SECTOR=%"PRIu64",COMPRESSION=%"PRIu64"", height,
-                 kind, gen, sector, compression);
+                 kind, gen, sector, compression) < 0)
+            mod_nvidia = NULL;
         return mod_nvidia;
     }
 
@@ -542,7 +543,8 @@ drmGetFormatModifierNameFromAmlogic(uint64_t modifier)
     else
         opts_str = "0";
 
-    asprintf(&mod_amlogic, "FBC,LAYOUT=%s,OPTIONS=%s", layout_str, opts_str);
+    if(asprintf(&mod_amlogic, "FBC,LAYOUT=%s,OPTIONS=%s", layout_str, opts_str) < 0)
+        mod_amlogic = NULL;
     return mod_amlogic;
 }
 
@@ -606,7 +608,8 @@ drmGetFormatModifierNameFromVivante(uint64_t modifier)
 	break;
     }
 
-    asprintf(&mod_vivante, "%s%s%s", color_tiling, tile_status, compression);
+    if(asprintf(&mod_vivante, "%s%s%s", color_tiling, tile_status, compression) < 0)
+        mod_vivante = NULL;
     return mod_vivante;
 }
 
-- 
2.53.0

