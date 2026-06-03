Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918ABCD6E64
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:38:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED2510FA4C;
	Wed,  3 Jun 2026 08:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="VTAwohj5";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5212010FA4C
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 08:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEZ9qmYVtCqOK4poUGwvJzkqRgRSUhCC6bmcpqCx/wabyMWXcf+jc51ZQVW8mSrZR36qGrh05OQrhRH52Y/oEkcmrT62A5/hQNPo0zdntCErbCMlzvhrLElcBnnYUFG1vG4/lE2ylSDcv0zVsni9HJMwduFYXGooow6Og/AcFWZchqxppy79gyPXuCEphcHjFOaedodEUnL3urgjcd1ifsrFR/s3YCfyYuEuQgkt7fBuFFq5eUasT4g3qO40YJDWxOnChcnO3+IvOt0LnrxjDryQbb5eFeONfz4W0JL6WSomcn22mDAg4BsFunkJQQJ79Kz1P9KwcRyAD2MfOBabOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiEaNbf1nsh15DdabbpsIOu1OKgfsbEtnLZAboAvDIY=;
 b=xxlJvA0ZM47lu5Do8UBgaI9d6ok3WXoZYmVTMpDq10CboGJ8BnevydAq52wtaeYjqOqFDABC6Z2+xKN3ICEKhrKcUx/tfbPjVHrvwyEm9xDxTF7BsXW1iJzo/PILQ+pS4cbA+1uBPoTF2AbAX6+Fys5IagIw3qh6GXCXnSW5ZMUN5Cb2ODYCQ48psvYhZS//je0F2yV92ts/17/OHssRROOF30p6uBh1iIO/iVmE8N/I88Qd2N1R4TYzoHHwhvxJsKOyW8k4ognxM34D6+Ls7wbYNwWIn1cf62DNurUAAQvROlyX7SIHSKV6DBUb9JlaON0cUUTL8nC0Sl1wueaL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiEaNbf1nsh15DdabbpsIOu1OKgfsbEtnLZAboAvDIY=;
 b=VTAwohj5TgO85ybqbj2pz0652jsvlJHZiznAxy31/U+G2g3F3UbPASQAumh51Lm+WgQVZUAeH/ph5TuVEi03cLeCmLrWyQP+PxaX+/gau0ROL8oWLruxgxDjC0ha69dJPlU3fJvOGCKQwe/nN0CtD4anBD02oUMLxTSdtSaVwnfDTpKdY7T4aJVVcP0IR5vYhOFOfQ35kEB2mK48bOBwIM9OgXdGVDULTTC7p334L90kaq51c7oZm1ALqxLsQ8UJWux52shQqLkv8il7qMZAgQRjNLGh54l3Nbloyk49sppUSlrbkdo/1ZkYkYGq7Bps4ZAIY76aVnz+R6+FXx5S5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB9201.namprd12.prod.outlook.com (2603:10b6:510:2e8::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:38:01 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0071.014; Wed, 3 Jun 2026
 08:38:01 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 03 Jun 2026 17:37:49 +0900
Subject: [PATCH] gpu: host1x: Fix use-after-free in
 host1x_bo_clear_cached_mappings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-host1x-bocache-leak-fix-v1-1-494101dbfd30@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NzQ6CMBAGX6Xp2ZryW+mrGA7tskhVqLaFkBDe3
 QImXjzO5tuZhXp0Bj2VZKEOJ+ONHSIkJ0KhU8MNmWki05SnJS95xjrrQzIzbUFBh+yJ6sFaMzM
 u2qwCaHSbA43fL4fxvJuv9cF+1HeEsOm+C4fvMSbDMfsVJdl7RfK/l4uiyi45alGlcko2mVYeG
 di+N0GSSZw5rdf1AxCXlhTeAAAA
X-Change-ID: 20260603-host1x-bocache-leak-fix-07f39ccdbf4c
To: Thierry Reding <thierry.reding@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: OS7PR01CA0127.jpnprd01.prod.outlook.com
 (2603:1096:604:24e::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d03fa96-a21f-4b98-31a0-08dec14b6bf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: SsK8kRm8U3ZG/x6XXzbFoUfH3gsowO7MHTNvoW0t42sX2xOmGW4xLrHGLUbUPzPAFdRQp1cA1ML+bt0A53l29exNWx9zkFQOMaMT5+58BdqDO4EnJcGFxl6OhVfgePhgUd0yFFZG7WWbF9ru5D/0PbA5bWt6TcNxUpOqx7OWfNFnq/8wUUS3guBnX34QF74fDHbhpwaTlN4X5smd/IWGnjKLVF1cG7xOZ5pIf/SLKzKfpFPLJDAkJdie957akXCm2oF9LFgXXHkKU/A483dL8JFXFAakvvlxkq+ogRKaS4k9aVbAOqaiBMcsecYIxs0twT1xkPBOk1LGqwtzhaF/zfzrIN0T14tE1oTmpW9FdpG3T0oqKJFJCoCa1IkjaevAsx2GftvoenL8PZ0yHbET33bCt3TrVV0+1rWms5X3OyKaJlG5ygDEtQewdyaf45+Uv0oTKGT7oxRuI1ht5R6iDHdTd8R8T+5OzzWwNJIXNW9pc+I6SpJyXXsg1Y+LH06KZKoBE3ZYdAT35xtVGqXlNel/hXQflAs2Za0aop0rREW+UkCyqS8AxGtpF3bpaYPEKkIsBPFjC81m/lAf2Ubq5ckz5qSpm63g/JG8y5ywNGgQ07plY4g0T/brEnKDf5W8AZJPn+pOp02f/XGLUUNT0FyTzYgkV5BdzMD+HTtqp4pIL2sW2n15uwTBMQUM0sY2O5QeUIqJKFyap9B01BoBxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWpvWWpTb2tkL2FiT3BIRG1GQmd5NDBGMkFKeVJoalFoU2RzdERKVXZWbWVx?=
 =?utf-8?B?ZTJOU3ZScU9IK1JSMHJkY1dQNlpvOFJGMUJSaXhDYWU4ZHNnNzYwSlBBSmVE?=
 =?utf-8?B?QUFKaUhLMnVPZEhpUm9iR2pVR0tpb0xuaTU5MG9SR3ZvY29QZU9rM1FPOHdK?=
 =?utf-8?B?SGcvT3dsekh5QTEwUDlEY1lLYncrNWN6cm1PR1RCOXpPYmFMQlU5dEQ3bVRR?=
 =?utf-8?B?bVNoaUtqeVpuS21FQXVuM09jNndMbnlzUjViS1dLaFIwYkhyOGtQZlEzS3RJ?=
 =?utf-8?B?cHFjWTZ2Zmh4VnpyUWRoeW1ITlMwWDh6NllZd2tHQ1lXYURRU0d6dy92Vk9M?=
 =?utf-8?B?cWM2N1JuYkFKbzVoY1NoTFBDZS9XM1c0U2p5dW0vQjRkK3NrakRINzNLUjM3?=
 =?utf-8?B?b1laS05OUnVzYlBhVmxTMTAxSVJMZjF0enRkVyt3c2pJQ01xeGJ6L3JaQjZC?=
 =?utf-8?B?Ymh5QS81ZEdWbTFYbzM4V2Q4aTExWHlwb3pRRlZqcUtMQU14N2J6RUl5MGZx?=
 =?utf-8?B?cjN4U2Q1eGRMSlBWVW9pNERVbEVWYS9iVjNjQ2puYWdwdThlS09SekpiY0JS?=
 =?utf-8?B?NDRodjBZZEpOVys1enRFb2pHSTJOOHFtSUdQc0NRcEVyckZIU1doUFBBSHlG?=
 =?utf-8?B?KytDMTBlcUhkVnF1bzlxT0JHcjJHMWZiTGVYdHJvVXV4LzlYbEVWRUJURUxD?=
 =?utf-8?B?M2xZdHBxQU1CTUxiSjI2WnVyUGtWTW9yZmJ3YnFGK2hKa0gxMU1QaFJKQ1dq?=
 =?utf-8?B?c1dyZThpbVNmMitHU20vdTF1Q2ZaV1NIaUpJVUlZcUN2c1djR3p1ZEZPVm1X?=
 =?utf-8?B?bDBmVFJMMm5LMGtTTktuYlBmK0FsdTFJVExwY2RLbis2cExtSzhMNDJWZUs3?=
 =?utf-8?B?cG5lMTVZMHdZd3pZa0FOV05vcWRpYVZwVGFVL2NqSXJrSDZLT3BNZ1loMCtp?=
 =?utf-8?B?dDdtSnhxaUorc2YvNk1raDhHa0cvYXZOZ1ZhYmdtOFdJL0s2L1VieVFxeE8w?=
 =?utf-8?B?Q3RLTlJhNEY2eGVWd3JvbzdzOGhYVVUraGU0QU1CVGdhTlRBRnM4Q3BlQW9h?=
 =?utf-8?B?SVhlK2hRRW5IYVFJUEZFbmxKdFFNcDJaaTFQdmhUMUdqY1gzek01K2QxZS9N?=
 =?utf-8?B?VmEyWXlDaEVTU1RFOU0wS1FCc1hZcVJGeEhrL0VuTXI2TkVTc2V4VkRnQkpt?=
 =?utf-8?B?K2JkcjhuazhLcitESGMzYTF0TnptSDcxY2VWbmNXeTR3OUVsUGF0K1cySmo0?=
 =?utf-8?B?TkdDT3ZoUTJGN2crUFlsSVh5OGJQeGhxNTNJaFdXVkFnclZSaXRlby9rbU1G?=
 =?utf-8?B?aTQ4S2FYZ1FualRKbFV6eXBFYVJMa2YwV0laQjBHOWtyaHVxNG9VYzBxeEwz?=
 =?utf-8?B?S0hHMng4Z1Q1N3RjTjhnbU96dUo1M2FDSHU5aS9Ha0hiSGkrZ2VBcjBvU1M2?=
 =?utf-8?B?VE40S3p2UDErOER4WEMrbzdQT25nd1NXMGtRU04wOXp4M0ZBU1o0K2FCQWND?=
 =?utf-8?B?dnNlMHRvMG5xU1BYVzcvNkl6V1h2N2VUZXlnTU5lWlJrbzhUSHJacUdMZVVo?=
 =?utf-8?B?eC9CUndkQnFzNCs3K2x4Z1pIK2tHRkw5ZUFLY3JHbGJXR3M1a2ErOXFMRUVk?=
 =?utf-8?B?TlMzMkt4N3ZxRGpWaE1RZ00xR0lvcW5DMS8wRlBacGpLckU1RHd3YVZUbCtr?=
 =?utf-8?B?aDc0Z2xjMXRRVENzNzVMZnhiY2k1VGZYYzlJck1zbFFsYWhwcHlUSWhYLzBJ?=
 =?utf-8?B?QWpYTUN3M0hOVHhFRjR6UlpTTzFJZTVUZm5ld0JGWGVWQTFtWEpJd1pLUjly?=
 =?utf-8?B?WngxL3haL3FlenQ4SmtvemxhVldSTm5KcVJIYVd6UGlQa1lhQ0pzSVcyTU50?=
 =?utf-8?B?eEhnOHZWVjVySmNIK05UZzhTL2NtVjhQblUrdmZ5MGJKWFZZUHlvSmloeHlD?=
 =?utf-8?B?QmNONWluRW9aSElJK1NoQ3JBaEgvTjcyeGRWSWFjZFd4RFdJWi91bUhXSFpC?=
 =?utf-8?B?U01MVnJML2FmWEk5akhrL1NRdFpMSEphVVdmNCt2NDE3cVFuTWxvU0c2MHdK?=
 =?utf-8?B?d04wN3hSRHJJZUU5VWVpUEpqVWVjUVduUTVVUkpOd1U4TkdHUTNtdHA3TVBx?=
 =?utf-8?B?T2hlMlhWL3JsZXN6QlJ4VENsZ3JCdko3R3hPL3pMbkR1bVBteEVMYVlid1du?=
 =?utf-8?B?SzN1enBwR2NqMnFQUHh1VllsRmFiVlN1eDF5bHBBMW1SVUtGWFlJeXo0N3RI?=
 =?utf-8?B?dFhhdlJ6MTBaQTVSM1FheUl5S0RDUHRoSVl5eTJPTDUwd0RyNFVhRHFNT0ti?=
 =?utf-8?B?amgxV3E4TDNPU2gxbDU2bE41VTRxNWdLV2Z3SnJlQktXWnk1R01WdjBUeERh?=
 =?utf-8?Q?V04cRXA6ZCH+ft4qqQIuKSeZ1SMkyYJ6Z6lwkVEFLgrZL?=
X-MS-Exchange-AntiSpam-MessageData-1: BHU6/2BxSn8bAg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d03fa96-a21f-4b98-31a0-08dec14b6bf0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:38:01.2377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNCHamJ0wBvcC4i9VbXge2sPFAmw2Na3wPcHGB5vyonVMfy+WGilvCaMLzpILDjepELEAP6F7yCzpdCQo/8dcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9201
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

__host1x_bo_unpin() drops the last reference to the mapping and frees
it, so we can't dereference mapping afterwards. The cache itself
outlives the mapping, so use the cache local variable instead.

Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/linux-tegra/ah6ErK6f4kVudVIA@stanley.mountain/T/#u
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
This is a fix for the commit

	'gpu: host1x: Allow entries in BO caches to be freed'

that has already been applied by Thierry.
---
 drivers/gpu/host1x/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 772e05a7b45b..a0f39814ab11 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -1012,10 +1012,10 @@ void host1x_bo_clear_cached_mappings(struct host1x_bo *bo)
 		if (WARN_ON(!cache))
 			continue;
 
-		mutex_lock(&mapping->cache->lock);
+		mutex_lock(&cache->lock);
 		WARN_ON(kref_read(&mapping->ref) != 1);
 		__host1x_bo_unpin(&mapping->ref);
-		mutex_unlock(&mapping->cache->lock);
+		mutex_unlock(&cache->lock);
 	}
 }
 EXPORT_SYMBOL(host1x_bo_clear_cached_mappings);

---
base-commit: 3131ff5a117498bb4b9db3a238bb311cbf8383ce
change-id: 20260603-host1x-bocache-leak-fix-07f39ccdbf4c
prerequisite-change-id: 20260513-host1x-bocache-leak-4759384eb792:v1
prerequisite-patch-id: 37f7eca9233a3163f077161c342071a4ac657f74
prerequisite-patch-id: 11b8f242c122eb03bde9c5a308e8b09a0e75e062

