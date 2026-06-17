Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A6DCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:43:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79C2A10EE12;
	Wed, 17 Jun 2026 06:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="QYoJN5XQ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E125210EE12
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 06:43:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Svlzfx6G/a0Cetqoe6uSZSKd9A1vwZIqOvQDzfnj0TpZs9Ay5m0cDjmjv6OQ+c8xxD+zpIS7vHjr7zCLy5R5fPYn42/jj58/AkrzwfjGvxTSDuVq5YXZL/GMhXajg40nwcbLcKqN0Dtos7itADC+uT0dKiDWFzYe4OegHUp/h9zBzwxYT9gaR8udRiuEsQwVR+kvTR+Zzz/liSHT0ntI0cBpng6Oj/bvBwMb1a8KNua5olJkIvNqgmygT7wBQb9WgyD+OdocGV9gc7ASfJEjH8F+Mg2G//+qj5SC7z0kGY592xYOykFsJDtiRdUGXqB+x5GXCtjZIDhWIw4OiqAKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhVY+xmUgR3yK/8/rMuOjoquYIEQ8bY538eY/coNzRw=;
 b=rXnAFMoqyfyxvg/WFITFdV7X3d0jfTB3C56BO9EKrtoBOiyRcdyr7ewQfcQqCnbjQQi46XOI0UMgUntZWEFMDqP8zu466Q1yZjfZqDynE7Uv9m8VMA7pXw3wMSRcK8LI9sVk1r4cWNXPac0EF2J8FAKyBz5qRlgAEvVVNKrGBnYYOhK6Ut05JRB1UbIPOF4UE5N1VVWyT3GWPIB/qY/LwqnV1YRng95hmIRxJ4nKCB266Xw9scfhAAqcygXFZfBfNaqKw34eMwhCRS4OZx9mG0LP5ozO2ozsV4FfD/hwN9sY80iyk14svwXtoc+J3iI6YKoAAxjt6OigGARBEe9j3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhVY+xmUgR3yK/8/rMuOjoquYIEQ8bY538eY/coNzRw=;
 b=QYoJN5XQ/UqCHm070gdnXO0FeOC3FDhUbqaclmboFnUO+b6mbuinW2XjtAzLM2c0iUFXoW2euEnMU3vD7T6mhHJLL2VTuZMlL4DUBDtXP/99kYyxIr4T+Gm4O2tji1qt/FkSwlDT3geaZ/WAJa/uqKkY49t8e6A+FbX9WtpXvWaen/zYQFtGmDaicRhH5u2JGARsaxOQzgvy3zZWzf9OocF8q0AJZX9eM5Kftzj2DOkYJM/RGgE/8sSQjSrf8msG1kkdcmsbE17p0UxJM+FrcyPYbaFS77FziHiBjWuigmrEjScMyTkLZ0fisbc/3i4uS5ytjXawX4TvMX+KIwPrZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Wed, 17 Jun 2026 06:43:16 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 06:43:16 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 0/3] gpu: nova-core: obtain and display VRAM amount
Date: Wed, 17 Jun 2026 15:43:10 +0900
Message-Id: <20260617-boot-vram-v2-0-15c979001c70@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBAAv0L2bM22pkU8+Q/DodBV1oSWtNhoS
 P8u4NXjJJOZBRJFpgSXaoFImRMHv4I6VNAP1j9IsFsZFCqDBhvRhTCLHO0oEJ1GXUtUTsPqT5H
 u/N5bt/bH6dU9qZ+3wGYMnOYQP/ssy837181SoHDN6ayMRI21vfrMju2xDyO0pZQvp8OCbrUAA
 AA=
X-Change-ID: 20260609-boot-vram-00d5057102d5
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS0P286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:b1::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 35cb4997-364d-4cd8-4f7b-08decc3bb5e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|10070799003|1800799024|56012099006|11063799006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: GtqEHTr+91azg0V8vJ3NMJ72/6wPp0v75/O50u8PkTvWOo7fRp7WXTqSwUrBJlQ4r3LfraPO3BCMt69WkdY3vrKP9Wfucsh1ua1mjGiApzFziMO5QpyYcn50lU5EDxVtZP7+xHYSYzXnVhQ5Yk/j7rQktAV5XEfVkz3T/v8KIpXirYSoABV9L9E9sgqdI6XODQc1RbfnueLJO03HX3ddvr7twRjFPFaO+UtDrvCmApnLrgy4xiSfnmKJwsswwU5G2npR7kZ6InRsjanfDMDofmkixG1RDco2akO9ulJfGrKm6VLKYB9+Tzh37sa4yMzpwCZhlwbU6+Ra3skFIedWQ20i6vFN4KR2n7V4kKDc2iFyAjr8UHlpjjgaJsSj0sqrozld2Y4RA/9xyWh/jL2be7CPqttQbdgi9FpAeNvMTdSh8j+BOQdggao0vTyd6sLFqeC58YE1/Fza6NhgFttfENzsb62ovAV1nY9KR/MJtboP9Hu2RI9npab05NSW4vRXZnO1x9UV5/sVObx81gVFh1/69aGNED61N+hb3bFwyZX12X3WNriSPKWTyybTq5Tkve0TXoFZeM/CSRVcnSQzpsSQp9QNMtgsfiP+GWrMqZ3V7Gp8AO97fBk7+BylVsLhHWf+Ct1iaKwF6ELSj0WNhi5LaN8GWRTo0M4hXSnOmleGwufNWr7g4qkqhGsj19N+snDJDL94tWjhbhHDGVC47g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(11063799006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZW1UcE1jQktMMW1xUjdpaThIQzEvVzFsMFE2bjlybWxMa09wMThrTHY0bmZ0?=
 =?utf-8?B?YitmMVNBU1BjKzlhN3ova1Vyc0d4RjBRdWRrQlp6UjBGQXZiRFRqT2gxU0JF?=
 =?utf-8?B?K0MzZElWbXpRcHJhaXB4aEgzTVZObXZoSnBncmdiTm9kTUJXZ3lSa0dTZ1lQ?=
 =?utf-8?B?bkRRNk4vbjNmTjNlajJURWhBditMb3FJcGQyenE4UmQyQk0wSCtVc0VBbk9Z?=
 =?utf-8?B?WTZtWE94YVgyWG9JVTJSSEFJcXF3WE9MZGphZ0FqOTY3Z2JVTHVjVkErQVRi?=
 =?utf-8?B?aDlMeUl0UGt3WDBjVGQrMlUyQ1RmNmNvZ3FIS2ZXSkV3WStocG0ybWlUT3Ax?=
 =?utf-8?B?MjNOQlNtZ3Jpc0lpQ0xPdDBDWWlQMGZOcCtFeDRvcEdLWFVoNjh0cGpjeUgv?=
 =?utf-8?B?RGJqYWErZTRxVFdsM2JrQktGaTYxT1BmbGdVZlI5SEw2bG9BQ3owamhQb1pI?=
 =?utf-8?B?S1ZWUW9aSThJT0ViU1dsQm5oRTNWR0VOUG9yRUJ3VHhCS1FVUWFMMXpacUNQ?=
 =?utf-8?B?dTVzb0ZQdWxxemVnYXQwT1NLQUJQS2ZHeDExOFB3aGJCaTdteUtrR3dNTnl3?=
 =?utf-8?B?ZXJTZEVQbTBicDdiNGIvd2tKUmJmY3A2M3NldGdCTVA3YVRsK0tTbmlCSUVO?=
 =?utf-8?B?Ny8wdlQ3SmNrK1JyOUkxQlJaNFBZODlPRm5IaWJHYjJKWWROTzFHN0F2RTJ0?=
 =?utf-8?B?ZCs1NE8yM1BEdkVNbmxheEMxa09GRFJWbUR5S1FzemVjaU9WVDY0d1ovcTVm?=
 =?utf-8?B?YUZmcGVOazB3Q0hQNi90eU1LUzlCOGRsNFRRcW1zWGxxc0hrMkltdXNGeTJv?=
 =?utf-8?B?S1FGc3FIaWc4bjY2aUN1SEZyTnNUNHZuaDc5cVM0MXE4Wld6ellMR0pyY2da?=
 =?utf-8?B?R1Z2eHBQMVlkWTFETjhFcU14bnZHOFJoa0lsd0k2YjRNU2RDUElBanB2REEy?=
 =?utf-8?B?eDJ4SUNtSm1TeFlrVU5zb2V1TDQ5WE13Z0FESGdUMUNnWUlrdm9yMUR3K2gr?=
 =?utf-8?B?UUxQK2NSamFyMGppeUFTajVpeTAyN1Y1U1hxRnFaYUlXU2hLVk1PS09IdlZp?=
 =?utf-8?B?K2gxdEN4aUdNM0pDaVZIYWxreFNkTFE1YnFNUmZ6emRSaFZtc3RoZ1czU3BF?=
 =?utf-8?B?YlRYUHRoZlVYVEhFZlljZFFVenF6UVk2RU00REpqdEt6c2o0RlA0WnF4WjN2?=
 =?utf-8?B?K1FLazFXZFBIV2ZOSFV1VDB1KzRwOE9LL1BrZi9ueXFpVjlwUXRQUGFvSjFG?=
 =?utf-8?B?N2ZYRTc0b2dkRlY4KytFSW9YRENtRXNVOXZ1OWlpU3lSOHE3eGd2OUtiWlJX?=
 =?utf-8?B?NFM0WGthM2ZCdGQwNjBOWFU3Qlk5TEdySXlFKzdpcG81NDdyS1o4c0JvOTVH?=
 =?utf-8?B?SjNtbG01VWtpd0tFYjB2UmtOWDhQemRlaCtpOHZ0Qnp5VFJFUjVrdVF2WThn?=
 =?utf-8?B?MnFuL3RKL1VtQktyQTR2Yi96bnhHbmFiZHVpNFRkejBHbmRQaWk0N1lwVi9m?=
 =?utf-8?B?SkJFN1dRSFJiNzdEekdqMHNDMUxpV1hKOGFqUTI3Q3lmWjNweXkwWmloeTNW?=
 =?utf-8?B?aUFBQ0FZQ0dwdkViajFUS0I4dC8xUG80SUVIM0x1c29JODg0MktzZStJZk9J?=
 =?utf-8?B?UGkvL2M3cFNEUW9YRDZLNC9hODZxWTA4OHFEQlJicmlUamM0eDFxTnpqelZl?=
 =?utf-8?B?WVBoMk5VclJQaUhTTjh0ZkZlSThWcGRmbDh6TTJNeTJWSVZJcXM1QjQ4RWNw?=
 =?utf-8?B?dktUbEIrQzR0L0cyUnpRL2ViNTlpejJYTjh4MmNoODZsUS9taXlzQlNvYnox?=
 =?utf-8?B?TEsxUEJNYlFtNnlkelhKKzZzY2VIdG4rQmMrSytQMVBCemhuUnpRN3NqZitq?=
 =?utf-8?B?c1BlSmYvNXp5QmVMa01hMDgzVzJLVVdVS2xKUDV0TmZNdFRGMmNVVFNXaHdn?=
 =?utf-8?B?ckRDeC96RGdjczcxWDlpZnQ2bGJsejFCN0ZRL1BDZWlRQklLV0lBcDEyRFFY?=
 =?utf-8?B?OC9pcW1BVXg2T3dteFRCcy90UmNtcWV2dnBWeGVscTBid0ZGZ0Q3cXlrLzBn?=
 =?utf-8?B?ZklET2F6Y05SNjRkVjF5YTRoWGhqclk4T1dtVURuVTdudkdPYUxjTkRFVVBH?=
 =?utf-8?B?bHdLUElkVjdqb3JpVENCNHRUWExOMGRwaGF6Wkp1Y3E5MlhPN2JYWndobFZa?=
 =?utf-8?B?TmNRanVEN1JxTUZFWVdWcGNnR1did3ZiUFMvV1QzcUpqSWZHZWJVTHF1VjdB?=
 =?utf-8?B?RUVUOWY5djEwYXppd0hUL2hCdHNPL3h1OWRoYlJ3QzR0K0w2K1puK1h5Y1N2?=
 =?utf-8?B?bERoeFpPbklzNXFGTy8wYVJSN3ZIVUkyMnhRMk9ZUVpzMkJGZDJ1QTVpOEJZ?=
 =?utf-8?Q?T/k+Twp4c54nKOgO16Y1a0unRWUDODjbxo4vSYG+t8b/S?=
X-MS-Exchange-AntiSpam-MessageData-1: yVwo3ZGAsLQ+1Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cb4997-364d-4cd8-4f7b-08decc3bb5e2
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 06:43:16.3778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCSj6SuSbj59iRfJbyr0SVEUZRQF/cw3aLOjLsWYsAkDJk88M3XzSUqF6JFGwAOOvUdHyNzJyHJPmyPVXS8A/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
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

This series performs some light refactoring required to be able to
initialize members of the `Gpu` struct from GSP commands, and makes use
of that refactoring to obtain and store the amount of VRAM on the
device.

This is useful as probe-time information to be displayed, but will also
become a parameter that can be queried from user-space once the nova-drm
to nova-core bridge is established.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Move `sysmem_flush` after `gsp_resources` to avoid use-after-drop.
  (Eliot and Sashiko)
- Rename `usable_fb_regions_iter` to `usable_fb_regions`.
- Return all usable regions as a `KVec`.
- Let the caller compute the usable VRAM size instead of storing it as a
  `GetGspStaticInfoReply` property.
- Dropped `Reviewed-by` tags on patch 3 as code has changed
  considerably.
- Link to v1: https://patch.msgid.link/20260609-boot-vram-v1-0-d9382610507a@nvidia.com

To: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Alexandre Courbot <acourbot@nvidia.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Benno Lossin <lossin@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org

---
Alexandre Courbot (2):
      gpu: nova-core: move GSP unload state to a pinned Gpu subobject
      gpu: nova-core: move GPU static information acquisition to a GSP method

Joel Fernandes (1):
      gpu: nova-core: gsp: Extract and display usable FB regions from GSP

 drivers/gpu/nova-core/gpu.rs             | 122 +++++++++++++++++++++----------
 drivers/gpu/nova-core/gsp.rs             |  15 +++-
 drivers/gpu/nova-core/gsp/boot.rs        |   7 --
 drivers/gpu/nova-core/gsp/commands.rs    |  13 +++-
 drivers/gpu/nova-core/gsp/fw/commands.rs |  40 +++++++++-
 5 files changed, 145 insertions(+), 52 deletions(-)
---
base-commit: 5f7410aa26524101d34b627fbe16670b1514962c
change-id: 20260609-boot-vram-00d5057102d5

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

