Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA0ECC6B1D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 07:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C6410EF76;
	Thu,  2 Apr 2026 07:54:35 +0000 (UTC)
Received: from SY8PR01CU002.outbound.protection.outlook.com
 (mail-australiaeastazon11020122.outbound.protection.outlook.com
 [52.101.150.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D575A10EF76
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 07:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHgwB8jsgrDYsiZtQ6r+PtfgA4KHSnZlUHMLBG1Lz79smnsK5EbPlV0u+RBuSu2UG1aPuAoyz8c/iuHw6i0LhvYSToufIAHzyZ0MZRcMA+PNmtU2U2cfUMUgDiXilndl9Qw1BmsD8JCmBU1red4b6UE3LpzVISMZno6YAW7GHoR1KaHxSFeF4WEoSgFQt/tEyLsQQzyy2nxN3DGWkChWgcIoGE0qi3NAPuEWypjvxe7FiKgyrj/kEsZ8zx6rJp1jAkilq8PCBxF8as2/FUK5SmmybT7J6y2ycSwy61UJXAjYlKtXSe+cZVATV6Dv4NJe0xjKwaaC8/0DXEOjUxBKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lotcbDZVLVnJhc7lHaMtgvpwpqhKKo99EZa+/5k2BLU=;
 b=wtA7S+mrTXhTUQYnjmxpghdJyf1u8tx6Z1whEvOCKtHFG8oF2HNR8XZb0WNO7NhpmIalMJJoEy0WNOmkt0FKMXir/wXl8A3XnGh8YXhAODdgNKaTivsisS6cII1Q0jyIkBzAtFO3nZGRPgGdIITYx2p7rkByXpxG3+mMoM8rYC8NKo6VuUNTWiercZqS4JtFgJVOv3DTnqKNj4tTuqcnE/HRgY+HjOxuyQKC7tiCK13MgNFXHPT52Vv4fKQZNObT2mpxZ2hXPVeoU/ZCd+PlxbdqY2T7MEZ8ycwJ6Esffq+qKLptr8DTXC28ZBn1b+oInQwWgkVOBgKEwwSYT3rSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=heitbaum.com; dmarc=pass action=none header.from=heitbaum.com;
 dkim=pass header.d=heitbaum.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=heitbaum.com;
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:279::22)
 by SY8P282MB5001.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:2b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 07:54:27 +0000
Received: from SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd]) by SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 ([fe80::21b6:91f8:614d:1fdd%5]) with mapi id 15.20.9745.031; Thu, 2 Apr 2026
 07:54:27 +0000
Date: Thu, 2 Apr 2026 07:54:13 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: dri-devel@lists.freedesktop.org
Cc: rudi@heitbaum.com
Subject: [PATCH libdrm 1/2] modetest: fix discards 'const' qualifier from
 pointer target type
Message-ID: <ac4gpTvlnCiZJKN5@b22fc13bbf9b>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ME3P282CA0058.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:f3::9) To SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:279::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY7P282MB4909:EE_|SY8P282MB5001:EE_
X-MS-Office365-Filtering-Correlation-Id: cd7f8f42-2f7b-408b-68bb-08de908d1042
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: zC7y5PFr3O0QHpc+bJkr+vHFjqaupIPnMHlQJlu0fFfJUfa9SgKz6NSocRtd0qc7qpYoZatOJBc9FSeYzkYsCAoIlmptW70HEHGfkw6KhZXehXTQCcd4WzrPmFSpRGt2wm8LRV5g4RYw6SKl6hOpRzW7X8Ffj6rN4EXF9Tg9Xij697f3wzg4fWECQ/okQJHDE8ZInW+nzWgfD1Rwx0AtM2PNVEK2X9mnxOoHuKBHPAq91zlxVOLrH/yeUbcU1+DJx0rHOjYwGWRNbxeywZ6W7Sp+Jl85ged/RL4CaYbbP06mU8xvG5fLqNK0+RoCAf6PMuCMkQ1nc7GsMh4KxR7b4vlDezDrqbn0PLQ3iapPENYUS7i4MNAWBiBK3z78PY+1XpfnjuT3J8HXsDwmsKJeMoB+ijSgxKz9zHO+UwJg87pcVbhoqz6dLZezcFduQgjjbaJyOmzn9eFMjAJa+TzGfcE4CNYj0Epwz4otVz3VO++rcaNM0QL0AaHY7NiIU5pAnJJjcPfUg+pq0BVtw0rTv7Bh+b+0Di5voGTmKT8hp5BMUAv2+imOKUU3lyx0jr68JTyQCL58IX7rfmC/ax2sd3BXStwVlRpFGQgXl7mv24TOa/VYHjuqlAeatrGlc0TWpgMvTVl506aWxgO22bobYphX84QUj/rUKgsOd8BIKNOMqyftsYcRIcg+JTVg0OW60lRHtP+nxm82ZnKJslL+luwy+bR9ZHf+HoU5lergWy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XlWXNq6y4Xf9sDlcrvu+9et8bzGxjYVUUn1yFyn3MZNZ84kVCEirHJHoAoNC?=
 =?us-ascii?Q?P6L7uM35/zo1j3p8kncqWTLphXomJ08t6KUDyUm3Lg7X+4uxd5pw9wSg9OPM?=
 =?us-ascii?Q?3U4Ix51vJDzvBrdku8MfFts8S776gIfNPonFITgg6QuwChpZTXOayt3LrutP?=
 =?us-ascii?Q?j9WIeAPVav1Ld/fYMCaAGA96qeVUgdYCKlsXFHsPeJdU1rGOm+ulZffKOwGy?=
 =?us-ascii?Q?uF989W1Hb/sf0jraIp/s5jzn2wICcB/PULo+wyRROYdv3c+s2l8QDNiPjSHV?=
 =?us-ascii?Q?Tsuwt/d9D72UQby0gtsvYw7RdRq+9zB2FTPJC2VshRSdeZMsVizz4QaM2m6p?=
 =?us-ascii?Q?O6wEB5adDPzkQny4oBdN0W2PSXKuuD/FUs4jYjsYVlh5hs0MvJ1SOnyyHpk4?=
 =?us-ascii?Q?plZSDYYMNxeqV9+9NlLFuRuaNDKLCBBWUOp0foFHCx6NzU5vb6UMkKrKP08l?=
 =?us-ascii?Q?1qsQL6kwZQ8FWZyu1BJaVJ+/DRpXJ/2qH8jyPKnzCBWxQE55ltc0voNzQGSE?=
 =?us-ascii?Q?6oQY8UgRWl6hS58FZ0Uty2b6pmT237BFaz5zmrGJ4Zfu6DHZaalPprxv2n/M?=
 =?us-ascii?Q?LePBGMzPwKZ98FEVSDMDt6TtFzb2CTxmZ0MUmE4+AN7gzt3EG6F0Mt7FvlnE?=
 =?us-ascii?Q?BBc4ZqbVvvHuzBsW4LmAaE+PGtK94e5kDLddy+O/f4Lhe92X8Y/6RzRaeiIG?=
 =?us-ascii?Q?fwYtj86vGCySt7lmTZRmViptv/ZZtSRG31R+b5IdWRXNoyW292RNZH4Q3iFo?=
 =?us-ascii?Q?suNoOzEtsbLyOvJx7hl4OLJ1IXqqLD5to/xwtqfwJWdaU3LBlbWUqN7zkmjx?=
 =?us-ascii?Q?Fjum4Cip8QhouFnRzTXMoINYzg/pB25CMJ+A/R5m5w7sA3f6qp0AJqH0gG+Q?=
 =?us-ascii?Q?5bt6dREBB08LSTwkn3GWJ8Rxk+fE+17fTWOEiC7pCRUB8gujpjOpaQjDJtzi?=
 =?us-ascii?Q?HJh/1QENYTFY/PJX5YWCIKc9yxkJZ9JS9wWiBoCn9rpdgqmBtoUr0YcbEeZq?=
 =?us-ascii?Q?Dxn6L9gNmSoB5O4ielEko9uLwh6BZOZvYPj1gDOoFCbZuKsBi2DNziwzF43b?=
 =?us-ascii?Q?Rj1SGIPdVuI/Rh4+AmxxPvk9a+b5D/bbF9SYb10PxEuqAXyRLTrQatcFaQxF?=
 =?us-ascii?Q?txWVIjNVlT/0pYJK+PkP4zUJ4e92tEK6QSL+V00jPeVZ/ELAofLtNEga/+DN?=
 =?us-ascii?Q?87TbxzDEBkwVYwlNcHBd/6Y6ve7s+o2b1qTCZzOiSRf/Emt4028qTypcUDg4?=
 =?us-ascii?Q?YfCmKfINgtd9Nmk43E6wFIfcOFG9ksJGsi60Vv0+bItHmD7Vt73kRvWk5prZ?=
 =?us-ascii?Q?kSnAc4rmPodXsKZkAcmf+6Xn5SE2TNk82BJnbhNJtkvPaKpqkij3PssfHbMM?=
 =?us-ascii?Q?L34O0USKevT13MV6dlopo7INrjL+CIG+pHxO/m3y+7jyRcT8g+KN2kEyqOjb?=
 =?us-ascii?Q?XcZIQvz5DsEJWaInSLtHE8rd2CUmHeqlQPPfss0oKUCXltFtwsae3Ny562R+?=
 =?us-ascii?Q?L16CPPrfif/qVPW1I1rz2GaRTBKJ+kHjj/p4Ib+0L/yCgV0eIMq6FjtKGC1g?=
 =?us-ascii?Q?YnBhtQqyDPbqXLcFlnREi++8S6abeB7WhXmnwD143xTNG0iYV2w7bCUrO1jZ?=
 =?us-ascii?Q?eovkIV1K3xU6GkTA4nRqcsEREyvA5tT5XHheaRB3hNzXJN2XCLhuT6HVfiKE?=
 =?us-ascii?Q?vu2Q+U+HcfIucq2FTII7JcuSBJFUSriUTk2vL+bIxLySG+dd1Qxt26Mj5Bhq?=
 =?us-ascii?Q?O/9waF07EA=3D=3D?=
X-OriginatorOrg: heitbaum.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd7f8f42-2f7b-408b-68bb-08de908d1042
X-MS-Exchange-CrossTenant-AuthSource: SY7P282MB4909.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 07:54:27.1584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 35ffebb5-7282-4da6-8519-efab29b0108e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5T9GG75T4q/b63XzCVCaotYYi9i7tkoNTN7TVEnxKiOET0qCXy7a36rufz5aLneZqB22bHNBI/+S4V2U6x3Og==
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
    tests/modetest/modetest.c: In function 'parse_connector':
    tests/modetest/modetest.c:1997:22: warning: assignment discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     1997 |                 endp = strpbrk(p, ",@:");
          |                      ^

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 tests/modetest/modetest.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tests/modetest/modetest.c b/tests/modetest/modetest.c
index 24c0e2dc..3c0a8803 100644
--- a/tests/modetest/modetest.c
+++ b/tests/modetest/modetest.c
@@ -1974,7 +1974,8 @@ static int parse_connector(struct pipe_arg *pipe, const char *arg)
 	unsigned int len;
 	unsigned int i;
 	const char *p;
-	char *endp;
+	const char *endp;
+	char *endp_tok;
 
 	pipe->vrefresh = 0;
 	pipe->crtc_id = (uint32_t)-1;
@@ -2012,7 +2013,8 @@ static int parse_connector(struct pipe_arg *pipe, const char *arg)
 		return -1;
 	if (*endp == '@') {
 		arg = endp + 1;
-		pipe->crtc_id = strtoul(arg, &endp, 10);
+		pipe->crtc_id = strtoul(arg, &endp_tok, 10);
+		endp = endp_tok;
 	}
 	if (*endp != ':')
 		return -1;
@@ -2028,8 +2030,8 @@ static int parse_connector(struct pipe_arg *pipe, const char *arg)
 	pipe->mode_str[len] = '\0';
 
 	if (*p == '-') {
-		pipe->vrefresh = strtof(p + 1, &endp);
-		p = endp;
+		pipe->vrefresh = strtof(p + 1, &endp_tok);
+		p = endp_tok;
 	}
 
 	if (*p == '@') {
-- 
2.53.0

