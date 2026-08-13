Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12F3C5DF64
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 07:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9B610F1C8;
	Thu, 13 Aug 2026 07:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTsHGvh6";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D966610F190
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 07:36:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xrh3DzAOq5HInp/t3lkfj/KCF3NJeRqZ8/CO046h2mANrVfxKAQPC80vwOqJQ3paWe0XAxXxA+QhqQwmR0OWDsIOrDzWOwst0OdIZt1r3QSoRdAY3KT8mixtZlCYRQUfMFasQPoFyVsCG565vCUH8todxjsA3ZkG1wTI6BAEJafqwlzfIOxla42I2wGXf5BLseGBO6bJ0ugcMWcQRnmym2Pe3yuRqV2ROUB1rZdJOdJuQcI1KXZUlZgFWQ2Js8Oc8FJ0jVOuEGJiijyqVQxwCcLkusdZiJBr+VifpE7k7iqSfgSrJUsbcvpVw4lHNvKq+/V28Tzj+wuySSZUzxXulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1uH0XnL0+nkCPP1QXGB7TtERVcdUk8O+8aV6JI2O9Q=;
 b=zNbZGljRrTy0KQ4F+4Gam5xJq8YdYYvQlTV4O5m25A9gmg5fGnUi3Bk8fRXccyWUtoE6xFqDDTWjXCB67lU+Ct5iyCBhDXIXoW1H6No2bY5+LuK1EX44Y8nmwroU9GePgG4phWZQBieEKWHhMLNvNvZIX/fhOTaqiD3kQsE2B9GUSbTUpP95jmtr1pc8y6sq48gTV9f73KxT0HRlWmDW/j0An0sNBlJUaEetfB4CFmh5ibG+3pjW+QvgNtZvBhkHUXmPAwipRrUBMQsAP8vpFiOcmo+tZTkSL6uWH6I2nXNUvzYjaMhjwx1A+RjcxPY3JXHVNVwC6wgLUvD19lANkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1uH0XnL0+nkCPP1QXGB7TtERVcdUk8O+8aV6JI2O9Q=;
 b=fTsHGvh6CvK+M+0uD/8QEW6RCRF1gpNikp06sEVb270mIu+ZLaGSdaGKohlfcZGlncEtf8m5uplEOBLGl1XzhbfZsTF84dQsRat/1J2nbNyX80eyqz3H91NYHmM3ftrGIxaZ4NvTL8jAx5tNMxSZTJL9iugfg7ALxNak5DO+30bAP5epT9oL2rxsY333qgA3j3UXDRU2BSkA1nSM+h9mzwj36wmJBrdvYxqAXztpfc0390CRXpsdeqwDxXB8sBnICkXfzLj9yRgIAWkW/ZTn+sZ2e8qZ5jaALSB54H4ZDgmPVQlJqlF3rHLHoFvHEjKw+VJRTOVi67HNO+tVaLlOKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SAVPR12MB999144.namprd12.prod.outlook.com (2603:10b6:806:4e6::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 07:34:59 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 07:34:59 +0000
From: Eliot Courtney <ecourtney@nvidia.com>
Date: Thu, 13 Aug 2026 16:34:30 +0900
Subject: [PATCH v6 6/7] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-chid-v6-6-160be5dfb5bd@nvidia.com>
References: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
In-Reply-To: <20260813-chid-v6-0-160be5dfb5bd@nvidia.com>
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
X-ClientProxiedBy: TYCP286CA0366.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::6) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SAVPR12MB999144:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f949697-2934-467c-958f-08def90d6160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|921020|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bbK0rafUgDjAmsCtIyxn0hzCk8qgchtBRCq/2ctjtrBV5xtyowXTD0XflOP74KMOWKIxgSVOA24N1isgQFTYcxfv8UUmzB1xX+oJyotuA6ulQ6i1BfIrpfVzEszDKwbW/lgTZMieHJwxAi6IYMtX22BZljvlAm1P8I8MlwMuHyRSo/sofaTvMBXsPV5QMTFVY12vo7wh+JEwqv5meFWQ40NV/wlPZtSe3YEkaNC1A1ANi+C5sMywE4Ud6X0Zd5OzPZDSuA954F30ZUD/A5GylWxdXoeffWmiZkLXEQUyJyEpJ+KzdRz6VSJYR9FVIIoTEntePUbBoxCozkb+rDBpeMmVHQJa0Iyd7geCLgbTmNzlN85EkFHXfHJ7njxgI2EyAtE03470IzKaa7dKOUGyVSJG3HWbKXURWdFaCm4IopAJbpseSQpst5+GWGla08e070Y9YD1lwowmFw4M26V9XFwJx3RVafCqn/UvVa7aIOiv9rfxvMVRI0eNf9Wpo4bTWTxMRs10dG+lotj7HX6pyypWRtZIbDPBhzRrV2eNJL+X520A5zx0WXL3ovPdx+dHrT2uEsq88qXj9yPZS9AqeiNDbZBG9NZWgkCDT1l4WyHb4csmSCem1BdGdwJqfsszx7xdh4RlkqrVrMJy7Kp9QbWIgu7GWs09OailIWcvZ9OTw7DsoimZscs3aKCkkeQXbDXSijwIf1BeXNCj4LFzGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(921020)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVlHeGJnN05TWDIyTCtkbnl6dmhvMFBkU2dXWDkyUFEvMGdJSjJpeGtsVllI?=
 =?utf-8?B?K3hoNFBJNEVBZmg3VFRGdUdNK0xyQitWejJ4YUE1QndONERLbTNqMTFIZ1hi?=
 =?utf-8?B?U1FqSEdYbGg5YjhFTEZMaHhEczdpL2Yya1pRN0o5aUFZNUF2emxzYm82em9L?=
 =?utf-8?B?Q080ZHFZcXFoRnAwL3lDVCtoZXpEejQ1cXJHOFg5c29UcGJTcUpidUY0NHAv?=
 =?utf-8?B?OHZQdzljYm1ReXZ2UVA5NjdyRUwvbFRINU5laHQ4UWJYMkhOQmZONm9LOXRl?=
 =?utf-8?B?UnpUTWtEc2lNazk2RmtHZTVZTFhjUVZSSERlbmhtU2dDeS9HQWd1ZStHemVG?=
 =?utf-8?B?SnRNSFZvRmhpakxDTDhJemZndlljZ0liQ2paeDVrTG5vWGJrYzk2d29PNTNF?=
 =?utf-8?B?Z0FVL255RHBpWDhwTnlUeHdyTldKTThrekRCcWJZR2Nnak14bEZWNE1qTDJl?=
 =?utf-8?B?bms4cXhSS3F3M0NsdWlBbkxLZU42Um5KWklrU2xBSDVYWUFRQ09pWllzRXZJ?=
 =?utf-8?B?WkxFY3BuSGx6NnFPaUtWQXpkWDk3c0owSTJ6RXlyRlVOUWd5SVdZdEJvZmpR?=
 =?utf-8?B?OWRsWG1SaTRuaUNRb0dVZGJRSmhUL3NTaVdVSDJoR25GOVJOUDB2ck1IcGF3?=
 =?utf-8?B?VTBmRFZGNmo4ekc1emtkcDc2RFhYR3NQMU11Zjh1QXlseXJqK0tESElnTzdi?=
 =?utf-8?B?d3BPQVI4L3MzeEh3V3h5ZkwyRGRmdFJpNlphd2Uxakd2MEFaTXhVY09jVDJH?=
 =?utf-8?B?ZDdpc25OZ291MG54NzZ0eEltVmlrM1lrWDkyd3IxSFk3cU9Hak5GdmZRa0oy?=
 =?utf-8?B?UmNrK1VhZzEvVWY4aGlqclloYUd3YkRNMXVUTWgvbmV4b0RJY0kxeTFxMEZ0?=
 =?utf-8?B?eGd1eVRYZXQ1aWpXZFRkVVJUQjFxbS9XVC9ic3ZCcUtPbkJWOXNlV0hFV3pX?=
 =?utf-8?B?Z3ZVeXJzeTYwVEVyZ3F3Wm1ST2t3OWZIZ1BnWldJN1ZPdEwvenBFSHdaZFlr?=
 =?utf-8?B?QWpsMUtxRUZMQVV3MEZSTXV0U045b3ppN290WURIZVg5cTlWRSs3ZnRGTU1H?=
 =?utf-8?B?dGQxVGVXWnNaZW40UUlYcXphb2J0ZEM1eG8wTlFKb2RKRTVXUE5BUXVnK2dS?=
 =?utf-8?B?YW14K0VSV28yWWZtRlJDNU9WeEl2ZVFLcCtvbXN4Ni9leFVFcVBOaHNZQWoz?=
 =?utf-8?B?KzZvb0tKWThSTHU4QW14WFFKdGtLenFxcTQyR0xJcFVxQktBVWtjazgxYlpC?=
 =?utf-8?B?TFpDUWNXL1pHVUJZanJOQk5KYXRtM29ycnhGSmYyaXBCYnNWWVF3Zy9GVUlU?=
 =?utf-8?B?RVF2Y05jWVBGaG1Bc1RUeDFjTE1WYjFvOExRcDR6c1BNNExYOTV1c0NiS3F3?=
 =?utf-8?B?VFFDU25QaWpxUEZobVFmUGROb1IyMUVMYVpmTWNFTytkd013UHJVOVVLSlpH?=
 =?utf-8?B?ZFV0eXkram9INmE5ZGprTE1WZkYxSGNuZFFMRkxTNDIwZ3dRaXRhbWRDazdx?=
 =?utf-8?B?Z1Z2ZlpIdkhQWitvNmljMDA1azEySUZCSEd2Wk1jdjB3bEdlbzZSZGR5OEI4?=
 =?utf-8?B?TnRSMjhTbDN4ZHgrVldOZ2hxRFNObFliNVNHek5abGxib01URVQzSmg2THBO?=
 =?utf-8?B?eno0Rmd5ZE1hTFR0YU5OWTlEQnF5dkd0WG4zOVNhVnM0T29saHJEbnBzaXJP?=
 =?utf-8?B?NUxXdjdCaTB6MkJkTWdSSzR0S3lvNlFrbFNIdWRJRFNzL3d3T2wvVVNmM0U1?=
 =?utf-8?B?UkVUMzAxdENoR2RTRC9sWTlnbDdyaER6N0pzQmI3YzNhM3J6YS9jcWgwU0hs?=
 =?utf-8?B?M3dNdU1CTEFLR3RHWDJ0Y2NyakpScEdYY2FXdzZyOS9GK2VJUFlpcGJWeXdW?=
 =?utf-8?B?Sm5Gajh5WUdjMDBVc3JrMnQ1UWRwaEoyMWN5dVlkTTRSQWF3ajJBNE1GazFk?=
 =?utf-8?B?bUNuanpPMG5McU1OeWVrWlFNTVYwa2xCazNzelQ3QVBTV0poTUx4NEhBUU9O?=
 =?utf-8?B?d2VlSUNSd1lRTnVzUjEyVCsxT0tST0wydk0zMUt6Qlk5cU9KMG90ZDc1cktZ?=
 =?utf-8?B?S1lsUmpyTEYyblN5N1c5V3MvVG9ndkN5QjdzVnV0T2NtRlFQclY3ZDJ2ekFN?=
 =?utf-8?B?QlRhenVDdE1GWDZ0UUFBU3c5a0VBYWJ4ZHFyQ05BUUZ4emhLdVcxbllNRU93?=
 =?utf-8?B?U3U4eEJUZDV6UU9OR3QrWDMzUlJrWjV1RncxdzNpMXozUHBhUEljeWdyMHVp?=
 =?utf-8?B?NUo3OHRCYXgvdVdnU005T1pRQmdLNXpSdTJZWUFqRURUSmtZa1pmV0hsRlJi?=
 =?utf-8?B?U2txME9uN0t6dk1uYjl6bVRBMmZJS2NJL0JEMytxYnlGYzF0ZkdBWHRkN1Y0?=
 =?utf-8?Q?0R+O7f/3Zs10Q5862fAkXi4jyAKwisEfgkdM8lPx+5brf?=
X-MS-Exchange-AntiSpam-MessageData-1: /wQInR/kE0ZeWg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f949697-2934-467c-958f-08def90d6160
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:34:59.7829 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z72gI8Tx6wROgQGednegA4FQsRL7rmUs7jKy67OaR+uKeDb7uAccYw8hllpAD6oQMlMI/EZxfGy88eyxQv+ymA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999144
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
index 1423a5fbca69..9baafc1732be 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -113,14 +113,9 @@ pub fn new() -> Self {
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

