Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169F6C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 07:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E15910E693;
	Mon, 17 Aug 2026 07:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fSsM4nhq";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012045.outbound.protection.outlook.com
 [40.107.200.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5613310E693
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 07:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlWFiJYQ582Ev75r2bZVaJlkU+emzqaSJfYKKS8zeqbRTv5mek8LrsQPp198ZWLA0wA7dyV2FVjzOuG9hEij5ShdsPumbtAsrr8M4EfC3yy3m4AoGegcNjq6uHC+UeY+4NSlLEukVKnOMyYOCYLua5c/6SBRN/cZkngpyJY4VGWBoZXg/tJ1qV5beAF62NdS6jeWrcimAnGeO3TyjNq8RQpZ//HyIEd4bGDa191rwD7ilM24QM2pOMKifxcvZcTjrxaguWudDCejm1YAyzOA5AzbrDWFoXVCObxLTdrnFITVLT9BX30k57lzxTyQRWZKZk8tvtQSicPjyr9tNW8svg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9be2eN/JX2gxo4V1KKN5kUjWbyScz93OTD/kjE0nR3M=;
 b=fUBZ/+fLAN28hH73Kvi0tkl1kiJ98Gl5PtPQgCNTTWeRYJnUFVQyCZ9DKzsA+G3EQyaPOrgUHP6z+OvO9bEb9LBFKODgcRG06cMaNctdlgdeDM17PaJ012sSpOiB63/e2g27iN0fGiSSg0zE6Ln3P5tNFlgnCi1uzN7/zoSeSD88WI2yrvOwDZUCDx4YYrCyyVtoANkUE+zKMUDnwzShPNvlUhRQN9h50yswLbEVqIzCjb6bVBPMaeQhHCdValRfMnyAU0yWXvfe9gYbkNubIBt259oSyDT8r3YAB8gPNuq6oJWSGOP74F6/W83mnsPQNu9lL/J2jwMUYgEoXh6zjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9be2eN/JX2gxo4V1KKN5kUjWbyScz93OTD/kjE0nR3M=;
 b=fSsM4nhqJ7EaVDG1/eULToOzNnWddOAXNSAi6yhNs5hkI2I8iXaylj8S1rS7bKYArr8K5IQctLdEYlwT2V1YNpdIOgYouMCmR42Hl9BBBRLkM1Pq3TUqNsmqW3gre5wRu74WQeNAHZAPKliVgjT16VU126/BgHU7nm2gK7gWTF7MW+mztopRisqeNUxxkGeiyyDJGDCy6+vRIv35XVTS8cSGR7imj6s0HVjy+HWySgE4B0pxfS+0b6n0HcP6ZEh40d74snrknUZynC7w8PuJCDPvE6Fzw6Hy3Hy6SWr640EvfBd/Y+YKKbCEUHklekFgq57Fnc8ARaLs7E/A9WmitA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Mon, 17 Aug
 2026 07:04:55 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 07:04:55 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Mon, 17 Aug 2026 16:04:22 +0900
Subject: [PATCH v7 08/10] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-chid-v7-8-a5872e64d8f4@nvidia.com>
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
To: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Eliot Courtney <ecourtney@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0059.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: c20c197f-df65-41a1-5482-08defc2dd74b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|366016|10070799003|376014|921020|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6k7jOzyqsClgLlVSLaQz9UxMuXcInEiZ+QToPREhr9h5FmQx55JU3s63bDjagvcN4Om8z8FtBqheDAhqABe2v1Pqt9siTtYgbuuObVkL9JqX75ec3LN39RRSXNhyR1LR7XP19QRSJQMZTQMAEeP9vGZHKfs+Y+zv6s3fzrrKgD/8bnhQUm47xKr3eb6rDEww6A7ewVWtHbNuG9/36kwUACiSw/j5MlmkCJkigi1/dqSHcNZezXcXHYXyxCSDnXk7B0QkZVnYIwtlWmLT46Tl2HJNTjBwTMezkAaNlqpmicSiTsqWWWVfoIY1/TDgN2KmP5RHLRxAWMVYF5Guubjb5SDwWA3ucp17aMki6E0Z6jgSeKS8eG7KviKPjnjsNMK/buzlqaq+h1Zlt3lLgnRJsh4v/ErfTwYzic9ckr3edtyoSipdSnNqf9xedMVfmYo9ENs0kc2yCvi0SLeNoH7dyIqbYQ8esmq3ciRivJ5gg/MFxpnZ3u2W2KiaPKkPE2Jjb4m5URtTDfeSHRwvo4Bj+DlOiCzhPCqwfIrtfxH1cPAxScemqcWvQ77IHfpXtl2fACA6WXQ7yI1d6TxXy5dNM29L1eFSqhoDR+eL7Ut09K039CAuA+VnH+2TEPk5v6i8D6FBdIAg4iObPt7zjecNrijKG0iksvsmOEgWJnzHD8A64+K/aMHWu9j5NmLJolNo3GdN2jFyP3AJRZlgWuWACg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(366016)(10070799003)(376014)(921020)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dCtqbnhpWUVabDlDMmhwOGZxVzUxS2FmT0lmbE5TamljNDJxbE1heEhXU1hk?=
 =?utf-8?B?Snc4RUNHTGJObE16VFNhMGxocWhYVE9CaTc2MjMxKytFTUtKSkFhd05CdW13?=
 =?utf-8?B?SStER1Jqaiswbll2M2FoVURHa0NqYmFSR3cyVk1UZExWWE9KQytEV09ZWDI0?=
 =?utf-8?B?em1yYjJBeGx3YzZGVmdnSXRxclllQnRPd1VvTVV2cDJMb1RXck9aWFNUWVZ4?=
 =?utf-8?B?M3lrdEoxelE5Q3JBMzc4cUl5ZHByUG9VMW5PRlNlcGpTV09RdkRrS0FaRjFp?=
 =?utf-8?B?OFcvbWVmM0ZWZ3c0OGdBS0hDQ1Q3d3FLV0N4ZCtEUDZJMnN4SW8zelhKRlRM?=
 =?utf-8?B?bWxWMXFWVU5JMC9KbDhvblJ0S0FvUU5VdnNReUZRNkZjRGFhbG93NllmeDli?=
 =?utf-8?B?bGxjRE1QQzRQUzBQdkUxZ3VIOENmQVVicEJaN3lBQjlMTE5BQ2VnN1BvSWpG?=
 =?utf-8?B?Smp4L3lTaGdLUmZESFMxa1VBb0ducitDUU0ycC9aQS93NWJPNGxuT1NzblE4?=
 =?utf-8?B?UDZuV3pQOFhFbWh3N215VUlFaWRtNWQ5VFRDSDVFNEQ0aTJIN25XNUxqWkhl?=
 =?utf-8?B?Y3BQelZwdzkwYW9qdkpidU1kOVhmTDhnYnp2WDIyUVFaa28rY3B6Qkk0VDdr?=
 =?utf-8?B?YlZPVlcyYWdqOWlRbkQxVnJ4bkJmTmF4dHV0eTNxZ2lvOTZyUi9Zd2Z5ODRs?=
 =?utf-8?B?eS9va3NHWWRBdTIxbzN6MmZlUmVkQ0RNK0VqWlpTUG5jeTRwRnVuYUtnK1BX?=
 =?utf-8?B?WTZodmVjMTNzOTF2RjdVUFMvZTNNak05VG1iT0U4czhjcDlxVlYwL1dzNEVD?=
 =?utf-8?B?anFzMWJvbGx2NER1akludGF6LzJ2VGpsMUtobWl1WHhHTW8rc2NzRjl1WkRv?=
 =?utf-8?B?eWlWWitvczhMVlZ2cnVrYmRVb3Z2citFNXlYQTZVbis5MnpseS9Qb1dxdy82?=
 =?utf-8?B?dVR0N1YzSU14UFpDU29zV0svNmNZbWpXREt5aG5NYk9MdmJmeEhUaG1NTlRU?=
 =?utf-8?B?dnFyODBHQXlZNlBWZzYyT25FY1ZvQy9sSTdqZGw1OFM3Sy81OUREeStacit4?=
 =?utf-8?B?VU0yaUM5cHdxeVdNcDVLT2RWOXlYQ1Rka1R3c3NtOW1wMUdMTXpTZmR5VXhP?=
 =?utf-8?B?V3RBRyt6VnB0RWhRdjJjUG1HVFB1SmFnc1dGaFFITHlQZTRDTlcrS0Rhbk5T?=
 =?utf-8?B?dncxVVA2L3RBNFljUkpnbDVuYWhxSWxkYlRTdElKanlYMGlGZ2s3eTFGUWVH?=
 =?utf-8?B?dDU0MWNmZW1hZU55TTl3dS95NFA0eUhtdlZzN3dtVUZDeERDZGdsWWk3Rk1R?=
 =?utf-8?B?QjNhUjY5V2k3WnEwSUdrSllOdTJwMWs1Z2k1c0Z0Z1RyeGU1ejhiYWJtQmJB?=
 =?utf-8?B?Z0hvTDhiRzNNcmdjbUMyZmFqZlNGT1doR05xMjlZT3drYnhtUTZqR2RJSEdT?=
 =?utf-8?B?eFF6RXNKRko1T3BhYVZsVnl6cnZxMGNSUjJCek5WUE01aW8wM3kyVHlsUW9K?=
 =?utf-8?B?V1RnTWdJeTlLSmxrcnhqOHV4d2dDOWViMGVDL0hZNGtzMERCcHJQaDZ5ckor?=
 =?utf-8?B?QzU1MWxPa3VaNkdGZWpnYkl2SkxLMnFrL2Z4dTZQbkhTY1hoYm00aVdSNkNr?=
 =?utf-8?B?UkM1czNranQzNnk1a2lFQmN3QXdYTk55QWRFZ3JaeDJ3ZzZ4Rk1vb3IwaTFx?=
 =?utf-8?B?RmZJOWZNWGpUYnZtWGZlN214bG8ydjRZcGQ4UmZBTy91SGFxVDlVazdYbWh3?=
 =?utf-8?B?MzhDNHI2NlJiYkRldEw0aXcyRmo2eEpUb3A5eWpockdCbmRSMmdmRGEzT2N6?=
 =?utf-8?B?MHdSc2ZWSEdLeFJmaDJrNHpKTFdjbWZIaysveno5ZWE0aVJvRkxZTzUxbks5?=
 =?utf-8?B?K3JqamFQQWJaektMU3RCcUtXRTBVZmpZbUpEWldVUmYwVTk4cjNCd1M1K1NJ?=
 =?utf-8?B?dFFKZVlJc0p5RFd5dGNCdGoremkvK3FNRmNPczNPZXZXeDZCZVVCNFZYSEFC?=
 =?utf-8?B?aXBqUG5UZktqMHRGNmFOZXlDS0ZLSzNaaUhnc1BNVW9UREQzZzBPRXJFeDBn?=
 =?utf-8?B?WU5zU1ZwZE16VU5rdTJDaDhuTmpFMzVrTVgyTVNFd3BSUCtGckhoR0NPeGtr?=
 =?utf-8?B?WERtZUt4ZTZHREhNcWFHZXJiSDFvMTF0V3I5L0pXNFE3a1JsWUs3TGU0NXFu?=
 =?utf-8?B?STJkNHVhYmlwSjZ6VVpXcmVWb3c3MjBOVVBSaHc0eExwdmM3TnNCMHIyVTBs?=
 =?utf-8?B?UW4xT29RY0srRks3ZFcwbS9NMWRMd29DM1RGQzIySHB1MlY0Z1dhT3pPODhr?=
 =?utf-8?B?OWlUbXBxYjFFTmJmb00vSHczK01ScGIvU0JjS2xKdWZ2OFZEY0Ixc0ZiNzRp?=
 =?utf-8?Q?gM2esxDPsnWjwdj0Jg5nLFJOdpe6dvqajkk8LCgjjvOgh?=
X-MS-Exchange-AntiSpam-MessageData-1: jcg8399N/A6BGQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20c197f-df65-41a1-5482-08defc2dd74b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 07:04:55.0029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVjlkU2JYWznhZ5ubJ12KR+FayMVTBCutGdjT9Luh6fiK3+BKPJJPYKTKzknr5UNOQtWes4DAJuddJ6CoEtwkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732
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

Current code in IdPool::with_capacity rounds the capacity up to
BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
smaller than this and still uses an inline representation. Remove this
behaviour.

Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
---
 rust/kernel/id_pool.rs | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 382a5645767f..3e7c3d0c9dd9 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -115,14 +115,9 @@ pub fn new() -> Self {
     }
 
     /// Constructs a new [`IdPool`] with space for a specific number of bits.
-    ///
-    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE_LEN`].
-    ///
-    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
     #[inline]
     pub fn with_capacity(num_ids: NonZero<usize>, flags: Flags) -> Result<Self, AllocError> {
-        let num_ids = usize::max(num_ids.get(), BitmapVec::MAX_INLINE_LEN);
-        let map = BitmapVec::new(num_ids, flags)?;
+        let map = BitmapVec::new(num_ids.get(), flags)?;
         Ok(Self { map })
     }
 

-- 
2.55.0

