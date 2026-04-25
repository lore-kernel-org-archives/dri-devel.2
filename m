Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8FCFF885C
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:16:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE7810E48C;
	Sat, 25 Apr 2026 21:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="YzBU+q3+";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010004.outbound.protection.outlook.com [52.101.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51DD610E492
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:15:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCfBgBntRwDuBTQxvd5ccutPFvPrwpcRyU6OQGjycch50opyrAU0nj7Zkfn12qMixcfL4CothK9WXfhCmtluk/uFT/9VXj8zM4DJaoMnZo1hlnQeNxN4UyoKQvwtGSOn238jUWnuCidJvmG2wzGHnG7lk2c/sYmAnG7m7+TtFR+9gF9VPT2y34Ho4Y2BR4o3oUpqtbzBGJj6rII5YmJIlMLCPmVz7kYhcsB0YXeNyyn5137zduVrcnb96Q7cw20t0cnQ4PH5sgP2B6V1dcIeiN+Z8PRtHsAcu0PDgP/Jik4oiakq6Q6RS/t6LoJN3aSOmKptwlp1RfUJgWOwWDF0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xsHouHAeioss9f2QVGXa1H4pjMIx0HBplIcDNYAakKw=;
 b=a6Bq+RNt8ZjbXUjQrgX+I0mckEX3vRb7tS0Pg7882/gBFsxmSuj3iNEUwIFtOlQNQ99T3ezxK32wlGkTahL1rwPizm8W1bkkc2+VYZa5fSd/CjBlMC3k025t590sxrEI3P1tWY3SnCl+t27eHdb9RQSpHn/sFYRTCahf0823PKhINtRrHEiAsyuqD3wpp4OuE2t3aI+ERsacixYMZnQdQ+9WlOcZOURW7OEOfPe4FMCyV+0SpuQRqUGES6Rhlylu1GOcjpweO66ROHkE9yiu9ra8qGczoekBn+7PZD/KvNr+WoOdlOVSP4AdFB0Tr6DqlEN1BKQxOdn4noq9CF5m9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsHouHAeioss9f2QVGXa1H4pjMIx0HBplIcDNYAakKw=;
 b=YzBU+q3+D508yrY9iV6fKVYDCp6pIx1qryYeC21hiuNXFoxof5sCHCnhfqFsMYw145JQcc5tbM+GQ495FrMOOkaDirH8HQZD67xhjIukK6HiwmfcGu+JyeIafSaUpyMximzScekE57y3ceECRJx863eo0pyJM5CruP/DCAorPhgeR9zwXX342pBO8o+DpV6SVIOPjlth+/fKaa4BUSD52IvFFVdzHboI0re13lEQPkX9roTh3+eqYLQS3W+1dLSbZf0fNMdUUcpCT8y/wVOdWMmWb3B6PZcjNyOZjPaVughRHshS/pN8tS5PnbDzT8/gregtFtamKBJOD/eJjqGgsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.13; Sat, 25 Apr 2026 21:15:53 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:53 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v12 21/22] gpu: nova-core: mm: pramin: drop useless as_ref()
 in run_self_test
Date: Sat, 25 Apr 2026 17:14:53 -0400
Message-Id: <20260425211454.174696-22-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0042.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:5b5::7) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: e43af781-8883-4688-2223-08dea30fd592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: g8MSPYetj7OvIvokO/zy3c8TD5abeOB49JXhrbd1oK+ebffD8a2wjXEJ9Kz23VbIkCEuWV5Nc+NtwVhoMwJpESVILzGsiBqAP4NsaXSNSLhEtzfV7GEaCfi9wz6a1ny3gqZfs1syNIkerXQ2mNSVmP9rdnw5C+JqWuUJt8JHzRfuBg/ZJ4fVIVrIiZ3pDioqa2Vo/rnO5v03V3uq7VifUXwVgof+In/ar4E9mHt4XrrEInV7STTm/74R/HoMWXsBioues/+xxwd/ddAGmnwMBW9rE65m0L0ESJs8MKxQRqLmAzFxGPzZkbhxDOHNyfU7JT9JYN26eVWpYnI3HSAs7/jteEmrvURelWLAtuq9o6U75nhg9sriqJ/8XOY97/sROJNgG3VSisYLUafL6d/35jyCVIznV5A55jvLErxbPu88NGHKLlaC8NuqtGLKbcjOEb5lhDqNZ6FVXR+TWgIqz7i9ubsNbp6E1LjeLwvNIjZin3BbBRaFlfjtZvJilSOfFVpT066tKu/VPGmi0VxjgeLxe3wstjJ93z8yp9t09WS8jpgbyj//yuODd1N47ZiaOdjj+hHkgeBgE7/95sL+bZkDlfqMLnqMVoAEBJ9boySApHUQOizwc5pF3isUsfqjQkPCpLM7OAdMKaXwOL7YKruv3iz1A53KNPugEWgSG+l8AHviQWEszDa46/ymObnAWPnWoiNJiaFxB2Xfy5DffJaa1oJoeo3+CtQkQjY20h4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wZ5/Ycl3ZfjIYrr+qNoelblcaE/petR1hao7YNpB6mIrZIbILPLO/uUfjiVE?=
 =?us-ascii?Q?6yPlSl/XKhLXGvrpwTVHBBGRuNg/N64II0/KxHjukdiTSpud3sa4nmnHzUCK?=
 =?us-ascii?Q?6cEvGmLW5wmQe4wGE0D/kvPoC/9UGQ2q46pARNZoYTZWmLOtBvLcl2rou3YY?=
 =?us-ascii?Q?HIf7SKtaAAhj/JxCN8a1QvxGK7EfqiNXwR0U0bmX/9+BSyk6n8GtEiOif4q9?=
 =?us-ascii?Q?wUL5/NRXn2pSxGE62vbLcFpP1C2orN2e/WizyNe30442B7cu2n5TXuqGVO5+?=
 =?us-ascii?Q?Gfy1zZsWFtC8h2qVTcni1ve20xYnIL6GyL4c1utLkMKxRkUhVtsvq0mtqN9u?=
 =?us-ascii?Q?X46s5Q73FYVQ8knv1snwvsBa6vdQRHzj9vepMQMQgdq1ZvH/Tn2mNZq9PaPG?=
 =?us-ascii?Q?ui3LUIQ7IdZUzSm/ZomjVwz7e41n2KACvVBjCMYxvI3ET3D+Y8GnPCGssP4k?=
 =?us-ascii?Q?EzZbYFwV4UvCldpqUyk74bERSr/Kv6trdmiDgWyyIZQOr4gofs1Mki9yI3/s?=
 =?us-ascii?Q?VPNJ0XDmKlogAdXizGI651AZ2quXB/zcukKQZlhm3jz5vk2X/dGYCN+FTmzC?=
 =?us-ascii?Q?MEh4yakOPspo/efp7rK7RrIuavk8mVA1oTr9C9MRHNUzn9LlEvnIa3SrVjqD?=
 =?us-ascii?Q?6OtBNUNc6d/9rr28foK9gCRIV+wlBxLucpZH3mLoTAnRBngiliGhKlZQhzB3?=
 =?us-ascii?Q?k5FypGNgg1pWcY/9LUs5wtGj1Pai5v8jVAYlzx/y8zYpJtF3aCC4S+WnMF7z?=
 =?us-ascii?Q?p/VdH3eF6XsrBN7HSjBL8sosd8E/Z8obOTvI8Emec+YI07yiOSKLI9s16x0b?=
 =?us-ascii?Q?6K9Geb9QgI0+PRV5XZVQnajcqta3KclRo4NJ0952vHYQJJ1hfQMbg1bkmKMZ?=
 =?us-ascii?Q?Q/eHh4tdtsaMGyZgyadOKSclediI/4n81ekSt+RvyogQfVYG3cY3le7ri9iM?=
 =?us-ascii?Q?HTOO7ldeZ4lT9nwe5GhdfFesu98ENRm6uMa8lv8wPX9Gek0J2uvI5TgeiNOk?=
 =?us-ascii?Q?qbcv/cNDmn/ffmLvTBkKuyU32MPLHj+bT30puFNc8BbnqAONS15Fh5sSWWXe?=
 =?us-ascii?Q?Ld8z37Q03DfJNbQtec54RVlc/LmGG8e80Ab1j9LC0GIVvlIro18V2Eapq2QK?=
 =?us-ascii?Q?yzgj5m5C/vFyELxQR2IOTRfasMGgQTWQv6lfzYITIrtFJZbxM39wmK/fRbcx?=
 =?us-ascii?Q?qF3cb7mGKDwv2hi0WMuI8Rb15B16OaFIz3scq3yBLgxsuviqfOkScoxr6rtK?=
 =?us-ascii?Q?Nb2De13coc8+FX/t1YFlNJdgIGq+N5FPRuAlg2n6tsnv+NALAJfCfXqG+fKC?=
 =?us-ascii?Q?Hrh5DuA1pWtfoqQI/DG6GEkXr/0QZLIJQUwab0RcS+MWArt3zYrPRfNvzlD/?=
 =?us-ascii?Q?uXNZh4Ww/kzQ7fLTni57XX3X5mYcxmOBUYc1QasXg+G4KGNgPuDRCsS1DPKf?=
 =?us-ascii?Q?/IB35X2hXGzGOWslBXq9tilDd9nI+7acMR1lOmxxDff0AOcLb+Wg76+/VIIY?=
 =?us-ascii?Q?SG9mo3PPQCRrlKetFbgYtlf2dwJhNNDniBINYnII2qmxTOwuygVtbkBPJESN?=
 =?us-ascii?Q?Qfi5a6to+cewe4i5widDV22E8QlrCwTL3xE3enkLsV85MVZtnuvlwFssNAZQ?=
 =?us-ascii?Q?nyXGkz9iV3Mp9rObYI+2iCDcnayDzcixr5colp/OgvWeJp8/EGn2W2WtvQhc?=
 =?us-ascii?Q?C7hnUdxsh7Z782viCVkGb/Rq994Mf8HZEH98PNY+nD5cvm7zPGQsF8mOdMU4?=
 =?us-ascii?Q?ZPShKc1N4g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43af781-8883-4688-2223-08dea30fd592
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:53.7956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8xwDcFw8fI8w5k5frnfbvU9f2o1DJFfecITPCuhgzf2V2ygpoJILul/1C+PkVhfGWGgqT/UABA/bhFtqkmP3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
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

`pdev` is already `&device::Device<device::Bound>`, so calling `.as_ref()`
on it just returns the same reference. Bind `dev` to `pdev` directly to
silence the `clippy::useless_asref` warning.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 drivers/gpu/nova-core/mm/pramin.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/mm/pramin.rs b/drivers/gpu/nova-core/mm/pramin.rs
index 6a62cb5aaf53..e967cababac2 100644
--- a/drivers/gpu/nova-core/mm/pramin.rs
+++ b/drivers/gpu/nova-core/mm/pramin.rs
@@ -479,7 +479,7 @@ pub(crate) fn run_self_test(
 ) -> Result {
     use crate::gpu::Architecture;
 
-    let dev = pdev.as_ref();
+    let dev = pdev;
 
     // PRAMIN uses NV_PBUS_BAR0_WINDOW which is only available on pre-Hopper GPUs.
     // Hopper+ uses NV_XAL_EP_BAR0_WINDOW instead, requiring a separate HAL that
-- 
2.34.1

