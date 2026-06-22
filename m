Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0524ACDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F32B10E6E8;
	Mon, 22 Jun 2026 13:30:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PaxQmfVJ";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A212110E6E8
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 13:30:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q86FsXAGzJPHy4YvZFO57q9ZKHNeNcXFsG6XxpP+PBcc5I7vP43MW7AJuE+OfyNyqeaJUrVDjKr8/x1rNd/bjirultacjxUj/XH6LToz6K6/1CxPdD8tnZLnQDw1kKXdOSBOt2o/P/gxyjb1r7W1O56p3OGNM9sxfVhoTZocksNcXMEUaPn8WXA/5pP2e26iXMLciZr1HTUkLkdmExlZwduztwAUNb9IFIrMXcubLVwUI7mP6yXga2vCEL9nkOnzEeqPa/wuJn5xzzSLfwu2xLb21XBHfv4b/QZEKdj4Kr0kLVUFqN7L/A777U6kJEqCv2UAlKJ5MFwU2oPiZS6LVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv7Z8pHSZpNc2t5ICM3HEt2JzcbUkHbX9MP53IT1SWU=;
 b=UstFx6oPISPdzagOy7r2BqHZfn8F+iOBcZSMszjPmYUxzz6XYxuS83bRd1YFbPOgrbEAFpkiQ4vDF3JznhuZ/0y0txf1/zRC8M/TWxsOj1wtpNVT7Q1nxsS6JgsxFLF7ZTzlUZ1vZpenk/ADjv3AjdjF5IPlU83RIjY1uKlydbz3Wc8SnvlHcX1NRKTcoswXlP8Aqwj4G8VQpDVqg4BzjigyX+E41MbEe3i2LjWBqPn+PtyMdThvGAOMdI96E8KvsmJ1HC3h3+vNnxHdrwmYMTQrE3PMkmZ7alsqu/3KyCfg5vBmpowiWHruQ1JjSvQWHdwagkS7I5s//ADFdwBpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv7Z8pHSZpNc2t5ICM3HEt2JzcbUkHbX9MP53IT1SWU=;
 b=PaxQmfVJFFMfEBGvJFKg5q8mm9/pnq1pLj19KqW6RL0gkoHD1Ge0tKfbDxLo9feNVAnQCkROwv8F1aprcb3/45eIPjQOhT98zLIWWytv5WCcQm3N24+71giXi3+TITw16Np0J2J9RGejDEhZ51XqxvyUe2rD8OpTEUUqj5+wojrl9gzMMNsYCoF85zWyuUi+4ZcLyISqjfz7L+PVxDtHBglM4c7hL+S5d7GeC1p0LIPOGmoSGEvU6SusCKwev1fKoCqeJbBnl2japUrY4WiaR65Mgy8eMILgSy/YZRF5C//BpP1Fj/SHmWg8qQ/toPWRBCm6deIvUK7iNLWYixo7Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9774.namprd12.prod.outlook.com (2603:10b6:8:270::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 13:30:46 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 13:30:46 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Mon, 22 Jun 2026 22:30:09 +0900
Subject: [PATCH v5 3/5] gpu: nova-core: emit Rust metadata for nova-drm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-nova-exports-v5-3-6191773fc977@nvidia.com>
References: <20260622-nova-exports-v5-0-6191773fc977@nvidia.com>
In-Reply-To: <20260622-nova-exports-v5-0-6191773fc977@nvidia.com>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY6P286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9774:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4057b7-fe88-4ec9-3fda-08ded0627744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|10070799003|376014|366016|1800799024|3023799007|921020|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YMz27WX4TyYMXm9W81urLp2CWB2YlB8wiZgKG/vN+NEkzOTMzyry7tFrjzpTHJkkS/yN0LC51VaiFIssLVCUoMANDUUI6qqB0nxsWF086dZVh7jgjFRi1VkmWHk+jW/NimIid0GeM3JBBWeVhzDwhN1KEkfwhkxNWCKqCniwFz7qQgErgzzu7UPb1mLuC8rniENPEKjuUSdbD+OlN8l+6vpBRCoCtYuPw7T0HdNq+2QQRMYbdeGiFk31gv5dD1wTYDSoH0fJVmRRkjML9ixN/MQ9ODQgQQp+INfxqfuCAoywU3/2AtxFoGFVsniAj8fxic8PyqQDO47Q3pE22hI52rkE4LJ56XR4P5F3I6pMj4P06aBrbnI/DGx9l0Jp1IcRnP0XXmyfigYaKoyp4cyiIP4Ah6tlEII7LOvcD72CiUqSlh4gdXehBAbl0OnqcxrCS0Ex/Sk0F1uZRyCcXCiheGzmv6Anw/TTF/XR2TQ6YuX5E0RBVuYxD2292IinFt1a4RLgqZCNdEWPWQt9+Ug2gRFkrkSdEhQWX6CtZC02D/JvW4WI1bKyorLSezJwjOtjnZ487x5vkvXNBMzV0KmgxED4VzACaiTaJZC6CK2+LpzvvsizXfjnRlhIBnbk7laR5xKVKLPSPvrFcb6t2/su5D/XAIobkPCfK6g3zmeLpmJbTZb58q0IEOUVEpushdP+beA6qaMnm+hyhfk54Htpqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(10070799003)(376014)(366016)(1800799024)(3023799007)(921020)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGNQUG9zRkRWUjhsVUZmclVkczBGbjNGa2w3WlN4M3BwNGhpcWRaNDRreVBX?=
 =?utf-8?B?NTJNdTJBdUJDUk1FSFQ5QStUSmQ4dWtGZ3kvY25UdnZUdEZ0ZGNGaVlSK3Mx?=
 =?utf-8?B?NjVTSU5RanNxM2RCS3VTY2QvVnQ2SjdjV1k5MlI3TlZlR0dUaEtnV0p2Y3dv?=
 =?utf-8?B?N2JVSnlORXQ2Nm5QMjVKYlBJY3ZaUXI1UFNzcDdDeksvakI3bDRBVVcxeno0?=
 =?utf-8?B?MmJiT0x4dWQ5a29NQnRpTWxBdkJRaDZNNWc2VVVjeUFCSDJCL1pVenY0VTU5?=
 =?utf-8?B?b29mdzlOTkpQcDNJQnpmL3RVT2RITExERE0wSnZJVzBhcUZybzJqclFub3RT?=
 =?utf-8?B?WXI0eU5reTVsdnMxZFZUTkVMTlJXUkNOVm9TcmQzQ1AvSXluVnNuQm00RkVE?=
 =?utf-8?B?aFRHcU9GOFR5M1VnVzB4V092bDlVbDBHUno4OW9MSitxUERnMW8wQkZ1bXov?=
 =?utf-8?B?MnhIYkxOenllcEUxVXZtK0YzWWtWVmZGYytidldvdlQ5MG91dEEyRDE4N3Q5?=
 =?utf-8?B?cHBQSWl2RnhtVzc4L0JVejc1aThzKzdhck1oYXpKMGZZQnovMmUwaVZJc2o2?=
 =?utf-8?B?YjVoVTliNWU3WWIyMEhYTEIwUGpsU0NvNzVmWjN2MzQ3ZVpJeWtya0JZZXBG?=
 =?utf-8?B?M1ZoWURUcldKbTZ4TDhqOStLaEtaa3hBK3pxaDZ4Q3FTS0xXbm9YZFMwMEJN?=
 =?utf-8?B?WHJFc1NXNm0waHpMTzFuMnZKdXpqOHVTckVUdlBWN2NrdERXT3lvaDNxRnRV?=
 =?utf-8?B?bE5weWVUYVVZWm5oRkNIRi82R2RLelVQRlFIcmRRa2tLR3dwVmVETWQ1MVly?=
 =?utf-8?B?MksrODFtMnlFdWcwa0N5bmNLOW5CNUFvbEI2cDFmYWx0dXdEcmNVcVd5bkpP?=
 =?utf-8?B?Um5ha29XdXh6SWdOQmhxRXNneGx5Q1lOS29WNE1VbEVqRzA0NWNGU2NoVWJi?=
 =?utf-8?B?RzF4N3FWa1l5ZXJIak93YTZXeUpnbCtVQ2FNc2c5YitoK29YUE9maEpuUU8v?=
 =?utf-8?B?OFFFYTM4eWtIalhvcTR0NFRNRDhsRFBYejRiWmhqQ1BxZGJncTVZOFJTQnNJ?=
 =?utf-8?B?TTFDU3p1SzVOMjJqUGtxdjlSZWNyNjFGY3FvL3YxTk9wS1ZBcTUyNXRxRHlC?=
 =?utf-8?B?REhNdFVvYTZHNEFYV1IwOGdWL0lUdHkreFloMk53MW9DbnNkekV2ZnFjT1NX?=
 =?utf-8?B?b3BjVEJJY3lWSnFINk1JKzVXaU5ybTNzRU1ZaVhySGN5U2J0YTZaeEVKRWtR?=
 =?utf-8?B?MVdZdS9mdk4rRlFjWGpkZVZWUURwTGVzNkdPSXdGaGpCWmtKaGlTcCtjTXB5?=
 =?utf-8?B?c2lXaGhJK05uRG9TYzN2QkY2ZWxTTXpvbUJIOHBKbm5BV2tSejZCSmlZR1ZQ?=
 =?utf-8?B?dGxWajNmaUpnVUpwSkdDaWljUHVyY0lCU3BsVmpqWHRnNWJWS3FFank3UkJ0?=
 =?utf-8?B?N1lrMmh4cVVKTHN2VVdjMkhaZGxaTVIwbG9ndkNLWWk3SFZXU2tnMVdTTlhW?=
 =?utf-8?B?Q3pIUWJpU0RnKy9YTkxPdnhJS01adHN6ZGZ1QjFsclFWWGtvOG90emxFZzMz?=
 =?utf-8?B?TmR3bkM1RHdMcjV1T2Z2R2w0aC84dlBMQWg2MGF5WjB5OFFxUFpCWFQwUGpD?=
 =?utf-8?B?SEQ1RWo1UlNxOTJqeDgwVjFIMFdsSWtZZ3pJV0U3bEl4M21IWjNKWkpGOGk5?=
 =?utf-8?B?Z2QxT2ZPRkh6UnpWQWQ1ZWZjeTYrWko0VXZ2bU1aSEswWjlySUpMRW1qNHA4?=
 =?utf-8?B?bUpSdnQ3c2dWcXBVUzdBeFdud0t1ckRRZ0ZDMy9UTitqT05aTmd6VXFVSzFl?=
 =?utf-8?B?UnFNUjV6TldkMzdMQWQvSnBTajgzUVBwdEN6TVpQMzIxbUUyN2hnRHIzVTF4?=
 =?utf-8?B?ZlE5OTZZeVpjZDJjQUNSbXJZSmllNWd5QnRmd20wSjBNTytXaFR1L1Jlckpt?=
 =?utf-8?B?YmU4d3FFWGZ6MEpSNVpGZWxrUkVSYWMza1AwbXorNVlYeWx6elRaUVgycEgx?=
 =?utf-8?B?WXhmRzRVd1ZId3F0YUN3S2hUQXlwUjlLSnd3cGdla2dISC9pQUoyaHE2eXZa?=
 =?utf-8?B?NjF6YzR3dWoyNE9lOVF0YTFST2EyRFNLQUNNcmo1QkU0M0g2bXhzaytrLzBM?=
 =?utf-8?B?WWRXVkhaMGRoa1IzdUN0alVycjM5NEFTRUR5bE1YczRUMzRhckhKZ0M5YmJB?=
 =?utf-8?B?UWg5UTcwMnVyY2dEQkhmWEpKdml6TG5yN01YcHJDYk81TVVKRjRnQkNzR01V?=
 =?utf-8?B?ZHhpVWs2QzI3MXZGVFVVNWhDR3FURWJ3enl6OUZuNVRyblp1ZlJxaFdER203?=
 =?utf-8?B?a2hFYU5yT1Q0aHdFYU1kODV1Z3pEZ2c5NVFJRDJZV1VzakQ2RFl4ZFpWQXJr?=
 =?utf-8?Q?hv0z5TDs4TPKyhXzbwwQ2uTJBF5AgRJOybAQFLnjkW0X4?=
X-MS-Exchange-AntiSpam-MessageData-1: 7cQFM5sULB+1qA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4057b7-fe88-4ec9-3fda-08ded0627744
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 13:30:46.1105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0okL2MCITuZsI2fSlEDLr6jLdGUtuwuYYiYZJcS2MG4s41cixLvxEKqShtv90N3kSZIweH92QvPOxQvpdanZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9774
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

Emit nova-core's crate metadata (libnova_core.rmeta) so that nova-drm
can import nova-core's types and functions at compile time.

This is intended to be a workaround until the build system supports Rust
cross-crate dependencies natively.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/gpu/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 67d51b7f3f55..13c96aa57033 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -56,3 +56,7 @@ $(obj)/nova-core/nova_core_exports.o: private cmd_gensymtypes_c = \
 		$(if $(KBUILD_SYMTYPES), --symtypes $(@:.o=.symtypes),) \
 		$(obj)/nova-core/nova_core.o
 endif
+
+# Output nova-core's crate metadata for use by nova-drm at compile time.
+RUSTFLAGS_nova-core/nova_core.o += \
+	--emit=metadata=$(objtree)/$(obj)/nova-core/libnova_core.rmeta

-- 
2.54.0

