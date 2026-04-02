Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EB4CC6B1E
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 07:57:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 596C310F16D;
	Thu,  2 Apr 2026 07:57:21 +0000 (UTC)
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazon11020080.outbound.protection.outlook.com
 [52.101.152.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098A410F16D
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 07:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGBaDSBGg2mc+wvY5tXJGPM9g88vsc8/Vd3YgWkiIbVlv8IC+Kit+PRA6qNDxCUWkgcGPryLLyrOUzpTTothIt7ENjxV308scdilsC8cOo/6X7odOZyoVN/rjag+g4TIaO4djsBrBIqgyuLuR8Typb397Y9zOiZZbnpkfuOihhCBYPAYiTZDr4ZEC5nV30IsL9fDDqOJu1cWjxDRDihKA07xBcSmUZUZ2b7M2kdDuirkpQLaeJtESW0tRWdUHwzC/4bb1yXneTTsBZXbogzSB0q5bd35axYf8N3ZU0IYosvM+rSR2tzrioAJUPhfOMMzfeflyjSQedU0pku0WlLcMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM+Cp73eM0b4DeVMewe5Pbwyr0nhCEFAgw+Ffoedf+Y=;
 b=ftIDIpPaEqd84uE0A06/8DCztjdOUnWwAIhkJrzS9oe9B1CYSGguGKSjVObbE9o0bd1Err/2K6If3pjsQ7A0ajfnXugQ+YXueCaBLHjm/0mBcQfc8VghiD2ME2eaTOUgsCbmjJu/lACsokUnTVHDCz8L9CTNsbINGYzOrIR+tTXlSC+Dv7s9bgzAJM0VSXbZDilg/sYtEnkOj1zCstp6qzRolMv4esiVgXRVPElCgteLIHgpV+CfknyC+gfm1lRYMNb5Bmi/dfx7JyptNEcgZH7c+AbLEWYBdSo2W1e0ANbjvDuhj041blgPHYkegO1i1Z5nvNr31MbsPMJkatRfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:279::22)
 by SY8P282MB5001.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 07:57:17 +0000
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd]) by SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd%5]) with mapi id 15.20.9745.031; Thu, 2 Apr 2026
 07:57:17 +0000
Date: Thu, 2 Apr 2026 07:57:03 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: dri-devel@lists.freedesktop.org
Cc: rudi@heitbaum.com
Subject: [PATCH libdrm 2/2] amdgpu: fix discards 'const' qualifier from
 pointer target type
Message-ID: <ac4hTyaeUHRTfTi2@b22fc13bbf9b>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: MEAPR01CA0064.ausprd01.prod.outlook.com
 (2603:10c6:201:30::28) To SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:279::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB4909:EE_|SY8P282MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: 9340a5cc-1fb1-4a11-27b4-08de908d75b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: zDVI3X48k+1nWJsTTAxSvjjiPU1s1lLowCkfdcdj2Lk41S30/ZyyCffym+Xx5RxeNhRqVGy/j4z63PohJ+1stLQPONU9hmKO3bzq1BMF3GlcCsQWN6agMB+ZMmiogigCCsSBN9aMUnh4325VlNORCkFqu4ypvuFBbQqW3VCzFgnom9GtuNMhxkn0U0S48vS6v8xsnAe1v+3AUNaqovx/goaxFQz6to9i2VlLxqwHSM/BQbXmAsmBFYRjbKPCpyng0nyFhKwOWN7u+7xybjl5bdTSfaaZGnWrpGrLGsqI2bzYYBQcaYrnyiKybh7hu8iKpLgfSBmUVBF0dHLRDQknz7j4nl8sC8D6rlEBD2X21sI06R+XBZOgogmDHOXbBey/dWkJS4rRVH1OlZS0QDCw/7IlexILiptxGJagJViCyR6oiYpOPo8K5chwY2it9SZ///hlkA7/yzImBo2UdOMXSjgq7o3wPE4XwXMXHO6/VIA8M3gAr2ZJ6/Cme+86PUjReZXMrGKz23PH6VQBjgLyKLcqlvTsRTYP0y7TYsaLC5ouZkkl9F9twMR0Rc1BhJELdFnzfqN9vqLVWBvJ2+Uef81pLTy6o9aZI107ncOC1vIZM0Znp7DuXPXdOdBQNqK0+jUa6wJu+T0ohgySUuIFeMuwEebR6kdrP8Ra7/4MdpZWoBE3jPOxKXXWNxc+lKYOdlGI1ILe+UOC+HW14+ei0hMIhmdUEex94lcEaiWjFy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2Rd/h5spAqVfw+Um+5f3XoeJvOB0Gmn3zC3kjiqa+J4eT5WFUbDIqLFKDLR?=
 =?us-ascii?Q?Td1UeoGqCqVRsINFza7QpF0HVwVSzpLBEBErCSP9dBzNFJbgf8udgN70sPKE?=
 =?us-ascii?Q?tEJAwgxqXoHwUPZbAGfGzetuEW0YfRkgXXyo7M+FgvW/KSnZbmVeQVEEbe6O?=
 =?us-ascii?Q?DTZS/j5ktMN081MYmtodzOgCx0eOu1dbvEQDbDjgjGDz23MbmHjl9gqUos2Y?=
 =?us-ascii?Q?4BvVkJiuOd3yl6ZKkruKcq72WtFjHd4lKq2PQiL31fWr8eXhhlVUSG4xl0hn?=
 =?us-ascii?Q?aGxR1Q/HdJojy5qv8Mea0wDzh4/lqyGs57sX2g2DrXna8TpnojPEA5YUDhUl?=
 =?us-ascii?Q?ez/qjFLCxHjGd5nrXdk3UM8BrBPpgiYY7lAXwSjCLY2rd317eToE+zQuxgO3?=
 =?us-ascii?Q?lb22iZtKYl91DieFSwirlqrrPhgUNARV9l3mx4QfxFi6bQvQmEZztUtf8oA2?=
 =?us-ascii?Q?4nlpKBXXVBA+YQWZW+Zvps1JZIGolfWJ1JC+bg/E/BKTOvAMO28KPpJKNTH3?=
 =?us-ascii?Q?abyxu93dQuZHcNkllHTkAhsbJf7EKgqPWg0Fou7rOrjw0jSVDGIlEcP/Ilvi?=
 =?us-ascii?Q?ufcAi7ZpIhyzGha/MOb9LwABtXTsLZyXE1jAXjmPhXKgxE4NwfPfiivtuPRL?=
 =?us-ascii?Q?8qgRvOf+oVI4wwJuv48J2RgR8ely53Mh+9eNQjaOocgGTlG08ybEBFkUgUOP?=
 =?us-ascii?Q?/8oOcwrz6XjQ5l/zW40FFa61yVKUjXjngS/EkmcFgaS7M2pt39cqx6wBY6C3?=
 =?us-ascii?Q?dsjLeeUb1QBfQHPeUUxGM4cTTgzJgwY6UOk51wr/gRR+QgTUCVuD4A0huByR?=
 =?us-ascii?Q?Sal4HrUyDJGzOdPR9rxKsOo148sL7KC1/Kod7T2W+KJ5BQ0N+a0WTxYURI68?=
 =?us-ascii?Q?ycyXS55kP+MeU2ZYLGcYWmlhCtr5aYOXkQdXsv5S2snGCCX16hAo630jQx4P?=
 =?us-ascii?Q?LczGA7OBtTsw3mbhgZYJ36Ii3dvXENXEqmPwNBXxirSoz9JhrKzeQnxZu6Sx?=
 =?us-ascii?Q?sWD4RPluicdh1xaGpXKt5M/Jf/b2fNwhkESMoiUTEcSfBR0hE8Rwz8T1YYe3?=
 =?us-ascii?Q?cGBPjrFsaq5kc2To/AObf9QmP40Fc+v04JgDJzyYLvMt/0zR0OkM6nr3pbvv?=
 =?us-ascii?Q?Oy+u6H6t8WPrAQwia83oZ4bsuwjYlF5bFDBV2y/VFVij7QJOvyvhOPlOVYBY?=
 =?us-ascii?Q?S0wZ7UuaMKtHPySX12NzWzhux3KIZOVXzhuugNfK2LNYFblU8ozKkcC1q+Su?=
 =?us-ascii?Q?dSSaHkutaN9YeNj0RflGflMge0viFkeS209CG88TEJe2bIgQaLKHruY2rFaQ?=
 =?us-ascii?Q?2RMKYaEd0oaKIidibujyVv2dqAHNMZsT8WAQgHwBl5hYldWJz8PBy28j6E/I?=
 =?us-ascii?Q?UJfDwnGASqWScLNuHI28uBRCs1Qa8NltIj+5YptuS8cpRS8sxDv/khzsh2Bg?=
 =?us-ascii?Q?W6Idkvhr/dbfDehY4LIsmm8+K7FN0RM0glPKNDleSyIhiAmDFQffmfkCadpY?=
 =?us-ascii?Q?VJI47+sWKilZmceapq9Oa7r2y2B+5aXE8T5EBUSAshi3CozfDmP8flbgMuNh?=
 =?us-ascii?Q?sRYsfE8rV6ihqWwPo47eCdUQpauO7sl4qMIdLn/4NfSmpN/pAYsrekzZtFyx?=
 =?us-ascii?Q?EzUmL+K8yDlfFnglTuQqwUH0QwxMbl7pF+Rf/Iz66xTn8GMm6kgLoUv4JXPF?=
 =?us-ascii?Q?DDrFKZx5GntG0zCkyc38uVlHKplTcmECUDHFpMU19SnKtFJkY0qKTS/ncWrg?=
 =?us-ascii?Q?PkBVJySifA=3D=3D?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9340a5cc-1fb1-4a11-27b4-08de908d75b0
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:57:17.3215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Rb9Fr80bRaj69Rm18YGvWJ28aaUSbHMLMgo0RSDZud+FWsFyepxCAs4KLbQqwOItxdvK9lx2ZNsUojZnjPrVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P282MB5001
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

Since glibc-2.43:

For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return pointers
into their input arrays now have definitions as macros that return a
pointer to a const-qualified type when the input argument is a pointer
to a const-qualified type.

fixes:
    amdgpu/amdgpu_asic_id.c: In function 'find_asic_id_table':
    amdgpu/amdgpu_asic_id.c:249:19: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
      249 |         file_name = strrchr(AMDGPU_ASIC_ID_TABLE, '/');
          |                   ^

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 amdgpu/amdgpu_asic_id.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/amdgpu/amdgpu_asic_id.c b/amdgpu/amdgpu_asic_id.c
index cd8ee596..fed3a531 100644
--- a/amdgpu/amdgpu_asic_id.c
+++ b/amdgpu/amdgpu_asic_id.c
@@ -238,7 +238,7 @@ static char *find_asic_id_table(void)
 {
 	// first check the paths in AMDGPU_ASIC_ID_TABLE_PATHS environment variable
 	const char *amdgpu_asic_id_table_paths = secure_getenv("AMDGPU_ASIC_ID_TABLE_PATHS");
-	char *file_name = NULL;
+	const char *file_name = NULL;
 	char *found_path = NULL;
 	char **paths = NULL;
 
-- 
2.53.0

