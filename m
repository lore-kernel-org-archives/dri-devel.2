Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFBEC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 02:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6E8710E009;
	Mon, 29 Jun 2026 02:52:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="EIaQVX1I";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013061.outbound.protection.outlook.com
 [40.93.201.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F98F10E009
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 02:52:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJVhswnGr3uYLj9zG7tvQv8oWr/4rbN4evBhBPRmWy+vRaO9tMqLSM6sBXnYtC+HU+wPhdzY4JjNAqyNCqQQotRBfI2c7Wn3wS2VZdABLbHcC4u6OyWxtNO7/pSZQaTUlqpG7w0Z2EMCs7mXkvL84VUmClMV1NpxBYrcAKb/OEqsWs7hH9uD2QwG6/9RCNet2fKauEZwksiACNT6o3AFyb+Ds9DLGqIRPlQSQAP6TYGawG0zJ0MnxJoo/V0Xfp5vbKip9oP5a5y8lkgpxvqNho2fKzj+rUIpMnPE7zJ8QHzCC1YxMm484xZ5751hV2WBquwZZDWOyK+d8U9Xt5DEhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUs9ajevj7324qSJ3QjeDbQ6Pk1xYozMBy79lzEP1p4=;
 b=GT7VB2WT8Iz4Mc+9rXbp4EwZNgaPCUK3P+tFff5UsliVdrP/n9xrqoogIn06fktaQluKiZKfm6prelPhFYydeN+56TStAzKfCBB+vzns2SufF+rQfN8tqbj7P82FuY6nAT+NwKOCVC8qglXezNlaocQ8LDs8Ebdv1zlt8c2V7xhkuqHGH2eCrNYUKw85m35tAcOmulV1miaVBxzo7zPRrqvelow0eStdC391dWqan2h3092QIfoyuB/G8Bv3O2l80ZsU6ORKq65QYCIyauR95WM45rnRpoMgsvLCpl8ySmYLvQoKEoQdqcCMw/fNcn1qQZwq/BL5HZizXgX7TRsiTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUs9ajevj7324qSJ3QjeDbQ6Pk1xYozMBy79lzEP1p4=;
 b=EIaQVX1ImfeRLZkWayRyXWqyS92bQBFBvPer6nwBwrYsCODHpCFB3Af3ADnJjH/7dzSkBdNzn6EEpLIFjGAZ1VTMmU9vFPRo0ygVIM3vPuBO5pyBr7i2zb3d++Z7GuDxKj2DTcfxZG9G3iecp4XE0l05IxXMRjkayzp+9VmUj02830z0brSvC+/ZLgqQxmqgASJyvczXUKykuqpZ7RdHUWAyNqdbF/tDjWTQYNux2TOgoQROTmufz/CEmllk3Wg1KE9kYj2p/trAHLxQVy0B++Yc+0cIiXzW9Ip7l+4gsL0ni+Awz7vU81Z4EIBfuVbdKEgIbqwX1vnFMdv1+ijd0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Mon, 29 Jun 2026 02:52:30 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 02:52:30 +0000
From: Alistair Popple <apopple@nvidia.com>
To: acourbot@nvidia.com
Cc: Alistair Popple <apopple@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 "David Airlie" <airlied@gmail.com>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 "Tamir Duberstein" <tamird@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 Pedro Yudi Honda <niyudi.honda@usp.br>,
 SeungJong Ha <engineer.jjhama@gmail.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.de
Subject: [PATCH 0/1] nova-core: Convert bindings to use zerocopy
Date: Mon, 29 Jun 2026 12:52:18 +1000
Message-ID: <20260629025220.1935622-1-apopple@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SYYP282CA0008.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::18) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae13d94-4e05-44ba-3fc5-08ded58975c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: QhiHKsbWDfyL0vsUuLAWoVXT65nuLyKmxpBayeh2LTpJj9kSVihfGIZMGPYt20NqkfNW7AMR9TEUtQIqLZEDCBC3PygFC97g4eTHsQoJALpFrT020KFnR7PJ+TvVscbTb8EB+66edOvswdlB3c1fDzTSYVrk1tgEHmwBOZvlM3dhZPPmMRMDKqrjgn5xn+HYQ/p4/6FhsqilxPvddrugE7/EbdzUbu/0XdD8JGZSuYlKxveJmm0KLSOQrOGBjN0HVFGtqQejssGG0gfPLgGrEhZhiGSSxjIsPzqfDwo5SEqFFCm+/Sf0Iu/nDBkIdhRE57T4IjPVGYAi6eZELNr1fxeM+OqzW05YhvZInUU22MCpwRJaTLdr2Q6LOGwvk6noQjVc0YPKfKj63ghVRMKDFXuZL9MpYQSpGTLkVCT03GMcApALMzF6AkzNKchT1w3brNOOJRfpNQRj9FdFFtHN3e3YK2OWwFsOtdr+uqWwlZksCQgkekQqMLtZSE1Yg1Jme4hKI9qkUzJ6sYRxfN8VSsulrnzKl9RcinS8hK2MznUNb19B/v960WZvvunbLELDneygbk4kGWhOIU2cem13afJFpieRSKFrKSBgY5ksy7bf9whFGEM7QmkZYAtwLt9GplSb0LlS9TgqXd90k+rxhTKoPHM/hjJrnuJWVjQS//Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjdmOU03dWw3d2o4TXRTUnB6WmswQ1lzZlpKTS9WUkx3cm9kQmY4VzQvamQ3?=
 =?utf-8?B?c0piUUpnaTN2T3Y2MURTWmZYdi96NVZUeTZJeW1GM293eXRVQmFYNWFFZjRn?=
 =?utf-8?B?Q1ZLZ0tEVXNlb21ramFVRzYzQjRtcC9MVFNPZUZWS3dUY29RVmFyenkvYVVF?=
 =?utf-8?B?RnZqZmRRMXlyYWhHeXlKaFIxc05xYUdBMVZEaFZwMFFxUlM1QmdOSjNpbGw0?=
 =?utf-8?B?aUgyZzRDRFFtb3pzWHZXa09RV0RJUFZrTkNBSkZOckdISkRvdUxacFpJOW1P?=
 =?utf-8?B?VERmVmI3MXJxRFBNdis1UVBBYThXN3FQejRTY1J6TGxPWU9OaFp4VjFYT1d0?=
 =?utf-8?B?TS9LdG5pa0x2bUQzQW5yRXcyRXVBV1d4RVlIY1UzUTlXZkFaOENmZWNJZHBy?=
 =?utf-8?B?ZnV5WVZuR3VjUVh5MERkZjVTNmJnU3VHeXFUdFJmbWVMWGtiS2dpMDI4bEJN?=
 =?utf-8?B?VkUxdFVxU3RQZUdWYU5aK1lyWC9kSXc2ODJuS1ZRcWdSWHdXQURjQTZ0R09G?=
 =?utf-8?B?cGdUV0dZMkttK25sTmZuWVMxL001WHgxQSs4TXRoVExuV29UalBKZEo4d0pP?=
 =?utf-8?B?Qm51dFVJSjFRV00xc0VqTUhQNnhSQmFVZDVNa3FPSUV5d0ptSEdTYW1qOU1C?=
 =?utf-8?B?aDVlSGR6ODRHdkgxVmlzRHoxRXBhNk9TdDdGUVNnelhpVGdDTTZ6cTNYaTNL?=
 =?utf-8?B?NUo2SVgyeFh6S3RRYTRLazhUV2V6ZzIrdzJaNFRqa3pFdCt0UXRnZnVvL01H?=
 =?utf-8?B?bXJsQitzMUZVWk82a2J0bXhmRXFRTklWKzBBQ1RoWkx5dFdLNlhEQXpHeVZU?=
 =?utf-8?B?VDZiOXZScE9sR3pHTWo1dmlkbFlRZkZ4U1BtNTErY3BVRjhweFpYZnQ0M0NX?=
 =?utf-8?B?bC9PeVljNDM4RFFOWEZKc2Z0cUFacUVabTlPdXk3dTlpaDVqNEJ3TzIvZTNG?=
 =?utf-8?B?Zm5Eck40QzQ4Q2NiRStzUVBSZHJ5L2wvMTJBZEovKzdpZjNLL2krazZYc0t2?=
 =?utf-8?B?SXB3MHNjejQxcDBUeDdmRGpwT1VEZUZXWU1zSVBXSTluY005ZU92b3Fwc0RR?=
 =?utf-8?B?Uy9VbzVrYlZOeU9hUlNJbXZsU2lJb2JEaktqWlVvMktsOVpSRVg3WmhFdjU1?=
 =?utf-8?B?bDEzbnlLOURrZmhiNXIzQ2Y4QUlvTFROME9rKzNoWHZKK2YyYWJHV0IvMHpP?=
 =?utf-8?B?bkhhLzh6d2lzek5vMXhoakVLdTZ1UHl0ZjQzWnJ4Y1o4WTRaTjRJc1AyM0Jw?=
 =?utf-8?B?ZlptYmxlYnlOV0pIelVXY2NFU00vYnhtd3JQYVVCVjlZZjhycTIrL0ppWldO?=
 =?utf-8?B?RVAwT0tHVTlJSElIcUExU3VNUjJmd3hoQmpVSEkvbEg5S3V3ekZxYWswVlE0?=
 =?utf-8?B?bXJCNlpMUmplc2dzNWxUYnZVOHNnZlpIRlZtZ2lXM25kbkZTZFI4aHIrMyt4?=
 =?utf-8?B?UU9SdlJxS0Z6K3BDYVFpN3VxOVBJQ3R3dktqRkswelZzYlIxTFlkc0tGMW8w?=
 =?utf-8?B?YVlQY2hQaVJQZnYrZmlKcklLbS9iTUNMeGNGZWdiQmlNcFlXcyszQnRrcVdH?=
 =?utf-8?B?SXNzTWxNZDg1ZWZwYXRuNW1uUjFRVWVBRHFSb2xVS2h0bjN2RUxTSjlUN29E?=
 =?utf-8?B?cVFHcDR3dmk3bWtHVDgwbWRkUTBlSjE1bVBqbjlkZ1FQUEI1UTNON0R2ODcr?=
 =?utf-8?B?UllPOTc1UE1Fek4ycWhVYkZ0UHhzUXp2cFFHWVRqVTNQY2g2Q1JOVUVDb2Fl?=
 =?utf-8?B?K3RoWWt2d29WM3Z4bXhJMllRZExxMDBHQ2p3WVVwN1FWZFgvRUEvejdKLzJk?=
 =?utf-8?B?NXlmVENCSk1RNm0rVVdoUkdDTnNIcUFubUlCOWJsZC90Mmk2ZWFqbFFIUnRV?=
 =?utf-8?B?YTMvc1d0dW1HL1h6amIwWS9lM3VPTmtvMklvVUQ2WnZRNExyV3VZcm1ieVVJ?=
 =?utf-8?B?VWxqT1B2a0VndFI0aGxkTjh3Qk9PaFM0R2cxeWREYjIwWmJEcjZHU1MxcDVM?=
 =?utf-8?B?VlVTeVplbno5UG5DZnFTUHFwUVFpWFdtU1FWZTdxT2w2U3dDWjFUeFFGbFoz?=
 =?utf-8?B?eUZEMEdhT1hyQlp2TGNJMHNYenI0UDYvZU5UVVdHdmRmbHpLV0NQMlRScHA3?=
 =?utf-8?B?N3UyaU5xZ0VVYktpNGFpd3VUYUFyNHd1MkRHbUwwcEZ4TDRxeWEzUEcrTDZu?=
 =?utf-8?B?NHdVdFhRL1BGZE5ZcDNvVWVDTnNFMm8vRi9zN2FrcVFyVkI3UCtQNkY0VkYw?=
 =?utf-8?B?UFpqRUhMOG5MQk1iempxekRxMEhCL2ZBZTl1bHZ3Tld3Tmdlc3Nnd09IV243?=
 =?utf-8?B?eDlKOVNIZFEzZDZlWFZqTWZNb29TM3JrQjdsT1ZwRnpORnpZZEJjdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae13d94-4e05-44ba-3fc5-08ded58975c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 02:52:29.8637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ViBjJwz3Amk8rafTXEqCc3DivBvisJKSpfrtzopc8Dc2STseuKzrjSEJJUDyXatkTljamBbNdH1EKzbM2M/z9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
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

This patch converts all the bindings to use the new zerocopy library. Bindings
are currently generated using a fairly simple bindgen script[1]. This is a
temporary solution until the bindings have been stablisied but for now upstream
should be kept in sync with the resulting output.

Note that this does not completely remove all users of the transmute
From/AsBytes traits from nova-core, leaving some ambiguity with when referring
to FromBytes. However others have recently posted patches[2][3][4] to remove
the majority of other uses which should allow us to remove transmute::FromBytes
entirely from nova-core.

Given the inevitable conflicts that will arise from trying to merge several
different series doing bits of the same thing I'm happy if someone wants to take
this patch and the others and roll them into a single series. Alternatively I am
happy to take that on - hopefully Alex can provide some guidance here for what
would be preferred.

[1] - https://github.com/apopple-nvidia/nova-gsp-binding-generator/tree/zerocopy
[2] - https://lore.kernel.org/rust-for-linux/20260628-dma-zerocopy-bridge-v1-0-9a2895ebe30d@gmail.com/
[3] - https://lore.kernel.org/rust-for-linux/20260625205146.5047-1-niyudi.honda@usp.br/
[4] - https://lore.kernel.org/rust-for-linux/20260621143647.264770-1-nico.antinori.7@gmail.com/

Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org
Cc: "Nicolás Antinori" <nico.antinori.7@gmail.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "David Airlie" <airlied@gmail.com>
Cc: "Shuah Khan" <skhan@linuxfoundation.org>
Cc: "Simona Vetter" <simona@ffwll.ch>
Cc: "Gary Guo" <gary@garyguo.net>
Cc: "Onur Özkan" <work@onurozkan.dev>
Cc: "Tamir Duberstein" <tamird@kernel.org>
Cc: "Trevor Gross" <tmgross@umich.edu>
Cc: Pedro Yudi Honda <niyudi.honda@usp.br>
Cc: SeungJong Ha <engineer.jjhama@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: rust-for-linux@vger.kernel.org
Cc: nova-gpu@lists.linux.de

Alistair Popple (1):
  nova-core: Update firmware bindings to use zerocopy traits

 drivers/gpu/nova-core/Makefile                |   4 +
 drivers/gpu/nova-core/gsp/cmdq.rs             |  21 +-
 .../gpu/nova-core/gsp/cmdq/continuation.rs    |  16 +-
 drivers/gpu/nova-core/gsp/commands.rs         |  19 +-
 drivers/gpu/nova-core/gsp/fw.rs               |  54 +----
 drivers/gpu/nova-core/gsp/fw/commands.rs      |  50 ++---
 drivers/gpu/nova-core/gsp/fw/r570_144.rs      |  41 ++++
 .../gpu/nova-core/gsp/fw/r570_144/bindings.rs | 185 ++++++++++++------
 drivers/gpu/nova-core/gsp/sequencer.rs        |   5 +-
 scripts/Makefile.build                        |   4 +-
 10 files changed, 223 insertions(+), 176 deletions(-)

-- 
2.54.0

