Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78E3FF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402FD10F367;
	Thu, 30 Apr 2026 14:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="qYEUESZg";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F94010F386
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 14:55:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWypODcfpRu5yxU9cEQD/3PzCvbTvt4PNPvHOGXY+0J8C6QJ/hOQnb0UIH8KByZJOe6nuYyyKSH7BA/3aPsJF5QS6jM1CiBYYF1qCGIKoiLendvt2bsXK7pFygurDP+8XcgGGzcGpPjQbZIlJcfpZq+yRJzZlFYXUG84ZIjYMz3NexPlze03brF3xHsm3oQenPEg1445oD85N4iKJkZxJeSFkYhtCMMflLJV1Eu14MxtdQ91y9QPDTEQ67mdp0x2Kgb9KeKL1NOxnFVVKbs4VxuGMO9ed8aWcfDvfmmZ1i4ZqLfCOu8UJnV5ScABNnBZN52aI4KIZ7AjXGGwc2m6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILLt/4DA1A3fPR/APELOQoTChT05n/0Lf903i6CO73M=;
 b=DFT8Lxiqtk5u7d8Ax+sPVxA2hhDKwICAaJog8WxjhRFuH9A3wDCHwxDEStq5ytq598GFjV/hx//8KqOT3DJuDWSErdQBUH8KRu3sGXU0HbF03UqP48wPkfGBFvqedSferkFVYcDISsjjwf4n+nJqscYdTj+sVS6gK8EMuLhuzaS3zrNQc9nU87MPA+yLyP4w3CVsCS/FTc/XGR6+tqjsVwzxHArEjkFZMxfijpJzD+UIOtfAdNPCp0sOhVYqg+JnF+yAAZnBcyWDQmERMhIMAj/eOZx7S6RXM9+tCQnnOhocTUVeFKnR2OsZXunHWX7vpuuwgsxOFDc/L++1K5fp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ILLt/4DA1A3fPR/APELOQoTChT05n/0Lf903i6CO73M=;
 b=qYEUESZgcB7IwEDXaTYV2uBVBCDJqh0GI0Q9jrgYRpR8GdiU1jJS4dzMlFAaRgXt069ba/NVoezZ2mpL7uIEoEzXTVOPzzGfULR8vNuFd+PpDJXYAvhCFwoV4vKkUrrbQiwODcBcalfQTXcGweModDLBl8i24S3B61as1xns2zM2bVPOVgFxnUhaFLRAiZloDrc7/9jp5hMFQsT5OUYOnC/b3/OtC+I61fKWwN91BGX+mT4XIlj3HBCMAMSptMiws33hldwv3gVAWG+GzEvrim53OrzJfBtSItsG0iISQsn56LqyO3Hx0P3eObulbYIOau306DmgomfeqJXrz1rO1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8501.namprd12.prod.outlook.com (2603:10b6:8:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 14:55:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.013; Thu, 30 Apr 2026
 14:55:33 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 30 Apr 2026 23:55:05 +0900
Subject: [PATCH 2/7] scripts: modpost: increase buf_printf's buffer size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-nova-exports-v1-2-7ca31664e983@nvidia.com>
References: <20260430-nova-exports-v1-0-7ca31664e983@nvidia.com>
In-Reply-To: <20260430-nova-exports-v1-0-7ca31664e983@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0113.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8501:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a16de2c-59b8-4232-072e-08dea6c88763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|18002099003|56012099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: 8NWouFKYgRfq508VMuuGHd8dE2GbcXrFNGoepY1WU/6/TfR11/xwLkUK5m5pby8B0wtHowew91QAXwIW7+/pRZaSrvzp1NJek0i1QPsVxKubGkViujAYtxxdrbSyzvmzhL35q8SRuD9x9Csewic/cV1TkTFBJZi3f+Nhs/l3A3xMEOYXS9QwdvcY6EB27VmY9bASPfcL2gMyVMOiFe1w7DJSlNTsuE0FN0sNqKkNwXtDTjr5Om+GK6CuJJso6XlJ6slgQADE1wxYjmmbCIKZgEERD+vIbLqINWhO3R6BXMGG/JpgjAGi463AtWXsVWxJ0WDBxrfDX/TT5HisXqXuCTn3uWWp6IOIGrtztUPqUDBqEUcsDb/SAwyCjo8zkhHlL7Q690NKnHdLQLbbLM0Q2CjgFaUhDOnWWxwfdGABqtQw2W7n/7TWDIPYkoVFGnu8WL0jAL42XrESI8TwKhyYgX/YkhEC+URrfzv1ea8b44hBhothHqXRig7hmusXCQ/MDKkk9L7QYPaMgN03nnrHPe+QgkkXxYC1mPiqzfH7+ClGZKjwHQeC7BWUXH2vGRtUuv8lDNBGXXNvWdApywLALDSHLchU7UBVNJDZJpsscpGR3kty4nzHw9xcNbp4gAeYuyl7Wcn13wPlTiXE0tSEvwk7jIafkTzkobZujTwIhEPJy9i5UOofhFXWJmtfT/g6p4NAwpDMGwWOuwYk2rxi2EDRs8Deato29EXu95gwJu9QPNGasVf2ZZWEHtO9le9NJwFDVR6mVAZ7bmCYDyNPvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(18002099003)(56012099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RG5kdWZpakV1WFNqOFl3SEl0bE04dURVWHhqVEhCS2R6ZW5ndUJvdjZyanJG?=
 =?utf-8?B?R1FMOTdBVDVaNnJLUUl4M1RBV1Y5VVdRSWZnY3RyVjNscHYzV1E2UEw3VHo0?=
 =?utf-8?B?OERxcjFaSXYvbHlEN3FnS3dKWU5nVGVsam1KUWY3dDNSSGU2b0RSenArdFBy?=
 =?utf-8?B?ekNHQ291SXMvRmtpek5naENqdW1qa3h5MmRzelNqM3ViaVE5bERzZ2xRRXRW?=
 =?utf-8?B?M1B3RWRKeGZLSG9LVGdqaG9IcVNGd200RjNhd0ZVYm1VYXI4VUVFREhJQmQz?=
 =?utf-8?B?Zzdib3lIMkdpaU5WMzl3VHNUVmpnaE5zaGxSbTNSYkUwSDhDTk9uZXExYlNr?=
 =?utf-8?B?d3Fjemk2eStYVFF5YzhndnhvY3U5bzlKQ2ZsR1ZSMG8xb2Y0WlU4a21iaGpN?=
 =?utf-8?B?cSt3UmxQbFRnVU9mL0hDZHQwTHRUdUxYdGFreFBSR1BZalB2Tjd5eStHdkFZ?=
 =?utf-8?B?bEE5a29UMEJzM1BoeitaTlcwVzBuQ1JZMTZhNVEzN2FpMWtUUi96Z0gzY0FJ?=
 =?utf-8?B?TkZ3RlBTN09sSlc5My9xMkVjUkw0d0tyeEl5ZnBLODhDNXRiSGQzb1ZCRjZT?=
 =?utf-8?B?bTBsWW1yZHVIdlkzZGNUN24wcy9aMnlEcnlGdmtxL3hZd0F3bldmTWF1dTZn?=
 =?utf-8?B?U3AwTSt3U3ZnUENLTWtVblJjbEowaUFRS1c0OGl0aC8yak5Ba0oyMTIzcG1r?=
 =?utf-8?B?SVV2T2QwRFY0QjlhWTdwQXVQdzNDZGxrTkx2NmVPMjcyM25PY2tMOHl0Rk1a?=
 =?utf-8?B?UFFmM1Y0N3JEd2svZHNtQnR5Rjk5TmI3N2hDOVN0N2ZNMDFOUzQ4VjR6QWxO?=
 =?utf-8?B?aXgwT2RlSjJYUzYwbTdDQU0zR1FiQkJEM2RHa3MrU2hvYUJmbnlJZGw2T1JL?=
 =?utf-8?B?WW92OGlzZFFXTElFelYzMi9FZVNucE5paitPajFzMU9VSHFzUUZCQk04WDVk?=
 =?utf-8?B?bU5rWHp6VzM5dHh3cW9lVE9UcWI0SVV0Y0RjMkNFMVg2Z0RtNGt3aGRTTE5w?=
 =?utf-8?B?T0tsRktMWnJZU0htVm5ubUVyZUVxdEx1YUVEaE10Q3FnWlVLNllFY29CU0pn?=
 =?utf-8?B?ZSt6NnUzaVlEU1ZNOFZoRitrck9HeTJ3d0ZQZjI1NlMwM2dJeDB0aHRtVThw?=
 =?utf-8?B?N0FtZWlKckdkdVVNVGlOU2k2cG03WEttWVBJQVEzMEphbVFVRkpqd3cwQ3cr?=
 =?utf-8?B?Z0UxNE1Bcmx0MUpyc2lCUDhIWDN5NngzM2ROU1FKa2ZET3VXYVBURWY2UUdC?=
 =?utf-8?B?RWI1N2ZWU2VUNzFjQzhzNnd6VDk1NVBoZGg1cVp0aGxOTkQzdlRkUnd4RUZ2?=
 =?utf-8?B?TDFTMG1XYTdpYU9pVFptM3VCRmlENHVmT3QwRWZQWHVqWjh2Nzd1a1VsRW5F?=
 =?utf-8?B?dkZKMi9HYndFZExFRDhiSmY5YXZraVVQaE16MVI4Tkk0UVh1cWxuMWlxcTFz?=
 =?utf-8?B?dDV2dXdwWnZzYTdWN0wxbksyb2F1ODVRai9DZktvNW1uOW4zdmFBd3hxcERN?=
 =?utf-8?B?eWFSV3puZDg3VkF1a2c2MFZ0YnBnRm1IWkRVNzF3N3FrZUFPNkR2WUZTY1hw?=
 =?utf-8?B?Um1pOHoyWjFkZnY0cUdHNGs2dkdjZ2VMZGNKTEs0UHBJY1Q3WG8wZnFaOVlJ?=
 =?utf-8?B?RUhTSng0U1NwYW13NFZkdmkxWlcxWjBCNFhhbitPNTAyTmxJU0ozVGNLZEFF?=
 =?utf-8?B?VEFsVEJKSTJ2akdVcWNDWGdQcVo5OU85RHFOVk5qY1FSajUvSFIzVWt5eTlw?=
 =?utf-8?B?cmM3KzNzUVB1WXRTcUVPeU1LMHJ2VFZ1OEQ5MVNCVGRMbXNldWt3WFY0Vit2?=
 =?utf-8?B?czJKN1Z5MHY1aWJwYXBBamFVclFwd0NJMExpQXZ2eFJYT1N1Z1orQmVXdGhL?=
 =?utf-8?B?cjRTMENMZEpyaGE0VENOOG5QOGNTOXY2UFo2OHFtY2x4MENOajI4SGNIaHdH?=
 =?utf-8?B?SmhPY21xTjNhRVJKOEo0MnYzT2RkOG1mOUx2Y2FKVTRuYUwxRkNIQkkxV0NM?=
 =?utf-8?B?MEVCUTEvRmxDVXp1aWtmSDJtLzRadFY1a1dUVGRNTnFXYWxob21XZFFpaktz?=
 =?utf-8?B?NXlQT2s3cVRoZlgvYi9mUHJvUGtRUnJFcmpBT0tkUDZ5S1N1RXQwbTN4TWs2?=
 =?utf-8?B?M0l0VE5nYUw3TGozd1plU1N1cy9melJZZjVhOUxhY1R5SU1MQ2J5bE1sS3Jy?=
 =?utf-8?B?ZSs5QlhGRkc0TC9GVERUd25ZS1ptVkRnZC82TWxpT2diMWNXTXNLQWVJcUR0?=
 =?utf-8?B?RFZKRnMrdVUrZTNwVWpqZU94SkI3aHJFM3ZyZTJMZ0haeWg5bm1sOUNLM04v?=
 =?utf-8?B?NVlLb3J6Y1lMOE1Jd2drU2dRRXJJMDhVbFRxMkFWdlBoRjlTSEw4WnBGUHBM?=
 =?utf-8?Q?OAuUzY4AtIl+Kn2aYRtjSoWvFImqcjZzyUQ4XSpWOygW7?=
X-MS-Exchange-AntiSpam-MessageData-1: 4SvyWZKs+BQEAQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a16de2c-59b8-4232-072e-08dea6c88763
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 14:55:32.9987 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNzWC+mO9a22wz1o7Fp1WEtYtRSxrtTMQU7kSbAnVV3+ON30Q6F0TMlJnMaAllrJBOZhuwnHQ8pSLQ2inQ/XXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8501
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

Rust tends to produce long symbol names; when trying to export symbols
from nova-core for nova-drm to link to, the 500 bytes of the internal
buffer used for symbol name formatting are not enough, making modpost
fail.

Fix this by increasing the size of the buffer used to format the symbols
to 1024 bytes. It is a stack buffer, but modpost is a user-space program
so that shouldn't be a problem.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 scripts/mod/modpost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 16f6bc20b058..2ab7aa6edcb4 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1674,7 +1674,7 @@ static void read_symbols_from_files(const char *filename)
 	fclose(in);
 }
 
-#define SZ 500
+#define SZ 1024
 
 /* We first write the generated file into memory using the
  * following helper, then compare to the file on disk and

-- 
2.54.0

