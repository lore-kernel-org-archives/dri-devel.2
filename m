Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BAFCD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:04:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D69B610E15E;
	Tue,  9 Jun 2026 08:04:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pjgSKgl3";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5105610E15E
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ml/7Ryqlq3O3xHDpQ2Yth66XDXDgFtZhQPAsbNYOPn3/Mg3p3N4Vkk0/tkXuf4PXBupuk4P3GoGeNII/P1xGwgdOfpI/dxW2whV3uTfWvmuVBE81FQRWLrspRqDF0k4uDMBa9oClmZS2n54NBmto9s3hPUviofpVoYjZG26oe+ojuOU1SzMLMeEh1KQp1jT7X5UKBZUTvuuZtZztCG+eVpZKH+PSEb9geSs6ipOssow62ket7vs71cmUiLyW41NHOs2hErCzg1RWTXEFgr781/hUMyBTc3c/Kn7G1X5glNCMdla0Ky2FDVV56B07TtOHXNU4IUGivbD8b8gnFaE24w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbhWTdChncETU33rs0FbTA4wHX3/1u7JXAECFXsQUwQ=;
 b=SkymgmfzrzSaDAKWAzSTI5rfs+8kDKG4hkZ0SzkhaIi/wT0wA6ocPhDW6WlZXrdOfkpPneelBzziBXqH5crFlYsDqFdQiMu4zCt9pRL9TpdnzllgwEljlNLIcuLAgSubWhqxprUdn5/eio9LIXXBKJ1beAjgIo6RT0xCfHDZRlkULS99DWk/J01QIyE7qCPhb8XtX+YuP6d65Bxou0f5uoNcYWsVC6v8oivxVZ0dV17OGoct4XlTD1dg54Ha9d78z4+BUfYdyGDPWJBR+wUBSuvyE1yVSQdbUTbeoSeDjIR1NC+GyuCXqA7znlf8frL+c58t4Z1ZUbrnaXMF2hAEsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbhWTdChncETU33rs0FbTA4wHX3/1u7JXAECFXsQUwQ=;
 b=pjgSKgl3/1Mp0san9ih00H7R8QupmvBXup1YIY4N7JCbN/nDAfqW/C0n3MoDk6WWkQaV2Z6J4x/hwIimvCPW3PwxHyjJjGyzvUDfujfn5jLOI9ER5+quJT/D9cWUP5btdOg0VjLhWI9Jk/rOnOJOfhyGImtfuIbuwL93wBjpE87gdH7jNKZf6Paq4+Oe7Q+6wsuT09OVWsgFDvg1A9FK+JkTnIug4NPMbZ+mGOoqAWG4gG8E6DX/7RQsT3fe30qtPLe7MC7KmFoyHOrn93dUPL/OVYtqG2rk0EwDjuXdyNykjCHjJeaxGPmP0jnAWMfDNETn54VdVxEOz078yaqwyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB5616.namprd12.prod.outlook.com (2603:10b6:806:22a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 08:04:05 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 08:04:05 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH 0/4] gpu: nova-core: obtain and display VRAM amount
Date: Tue, 09 Jun 2026 17:03:58 +0900
Message-Id: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBSA4VfRubY6Vpt4FbnADo5i2lhKe3fD5
 Vd//w2eHJOHOrvBUWDPdkso8gyGudsmEmySQaLUqLESvbWHCK5bBaJRqMoCpVGQ+t3RyNf3atr
 f/uwXGo53ADE+2JfaHW0AAAA=
X-Change-ID: 20260609-boot-vram-00d5057102d5
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, John Hubbard <jhubbard@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: OS3P286CA0070.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:201::11) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 3026ddfd-046e-47c8-ebaa-08dec5fdacbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|7416014|376014|18002099003|6133799003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: AjVlewtkZSVI0ykSPcU06SkDgbXcwlNJLAGZlNBfxmqScQBemIBLr/svioPCAMHIveut7U96bE0m3HNpdwb76KRvQb5ZoufHpw1TuE1LZgRMWVKRT8XObckEnyg17+kfOZ037DcjR/oyUwCDTMNtAQs66IEh5C6lGTrwDMHd+qxNGrIXs51J6hYLcubaIFB6y9PUkMhvlLyC45Jq4BqvU9o8xboF99aBFXQKFfp0uv7VDi/fNQPWt8gLL4jSk7azcjkjMQXrMn5lJ429sqmAr1d2PC9AU/fpjz8WXplo93p8mpkPFhn6Dw/jERJpfTQGa3NxaC7tYSSxKrcNGU7Dz6Fv7xgPt68h9WGf1DjNsmv5ZnoGAwIPiJywKSB4w3rKWvKnvX77AqW75TdbL56TU6rymYxty2xL2TM8nV82fxx+mwXcSLUbujLAm8Wu8fllZXpNeUAAv6uFnqQvg8SOW26W4D9AD7ScQmPnMJxLO8J04rgsW8dBtwgETtMApCRE2VqiE+TTodKa9Cusqzvlynq9PfUzX9X1CVgMNMifFx2sknaYlsiIATzftAgxg3CdHAkUIGblsRwuoQ0rVnU/QQ0YUNsIPACekx/pig4PAGZ8mmF8RRkLFkIWRQifyuUkdqu7np/QxZjsqxkuO1Lzp+pbCDMJyQ368uflw1tTFXi9tOmclf6+sWjno1W4jWmQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(18002099003)(6133799003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFdKMVAzTjI3RFRVT1AyQWxidktJd2FIRzFrM25PaGFaMngxTk9iMmU2YkZy?=
 =?utf-8?B?OUpsQi9rWHBuNDJSL1BLcUJmMzVzc01mLzdFYVl4OVN5c2dDREx1Ym52bC9u?=
 =?utf-8?B?eTE1M3d6c3FiQ3N2dUhkVVp5YzZKSHdOQjNQU1BmKy9JOTZqc0tIOEVLZmFx?=
 =?utf-8?B?UnlhZ0lRZ3B5RUh1Ly80MXdMWHowZ09pS0lKMGhkTUJ2SUF4ZTJIWExsTnd4?=
 =?utf-8?B?K3c0cDh5ays3bUtka1ZBUzlaTW5ub1VkODVNdzNMZDVsaVNpSWVvTklBQmlH?=
 =?utf-8?B?R3p0ZVNlVlpIYzRnTEMzMzZpSDVXamtIdzFzVVVIYWlEeWJzU2hQczFHY0xq?=
 =?utf-8?B?dVBvMlI3VGo3Vjg1cHBvekhMUnovQnRBVmpCN2dmbERxZ0NUMml1aXkrTUhj?=
 =?utf-8?B?enRNT2o1UG1UZXZ0eXBOcS9RWjNCYWhySEZFYk1oSElROHpmZjlqVUk3WThM?=
 =?utf-8?B?K09zTzY2clJ2VEdLWkFOVnhwT2JiNi85TnU3ZlNHUnpFZ2VqenJ4Z0doV3hN?=
 =?utf-8?B?TXNpQzZ2ZjBzUHU1RUIzSDBJeXhraXZGbGFNMHh2UzU5aEQyZFErOWF0T1dJ?=
 =?utf-8?B?RmRoaXhrT05Wd3Y1UHpVMGkxOGF6Umo4d2RPUUc2dmk0VDRBZFY3aVBHbHgz?=
 =?utf-8?B?SFlpTEtJVm0xTmZoR3d2RDZkTys2VXdMamNWM0dCR1NndVVQL3REdjhWMHYz?=
 =?utf-8?B?UWhXTTF5bFhZQkxXMjdSYUhCNjhsSTMzcXhXQ1FQenIycnlSRjdvNDZxeGVt?=
 =?utf-8?B?QWVpTVVhZ2h2VGVxRWt1THF4WUhXTDhYRERvYktubDRJeXl6Z09RZ2xwcVRj?=
 =?utf-8?B?enIrRjhpeWFIb01YTG5EOVIvY2NCZFUvQlpTdzRaMXgyMGh6bHZLdDRTdDYz?=
 =?utf-8?B?cmJSM0Z4UUlFRkEwYWIwRTQrNFBzTXNlSzlhYmRwRTVacHlndUNVc1BhNk1h?=
 =?utf-8?B?MGhPK2IwTlR0aFBaaXFLRm4vSk0rRGNyeklJSzI2T2R5R2xydm1JeVVBcWp6?=
 =?utf-8?B?T2RlQlQwMURPS0ZYaG9NdlFwQnBEK3BOWFAwc3huRElpcjdBOWFTdTRHU3BY?=
 =?utf-8?B?SXpvN1piVWJxd1ZHOUwvdjQydzh1MW9QMHlqWUh5NVB6UWZhRVN0aGs2RWJI?=
 =?utf-8?B?ZHcwT1kwOGMwRC9VQXQyV0xCUFAxSzc0YkRuZW5DK0ZWQjd4NE1UWmVNb1kv?=
 =?utf-8?B?M3RUaWZYd2pvSDRPU04zOFB2UHVqcFVuWnRHN05hdWU5dGtXNVNuN005TXM2?=
 =?utf-8?B?NkFwZmlJKy9taEFKN09UdHpnUWNNYW1oSzUxM0Roa3V0RElnc2lmcFpqeHRT?=
 =?utf-8?B?a1c5bXZXaU9LVU05M2pDM2dqcnpmRndiWXNJaU1CQVg2OXN3M0JoMFFVdUdC?=
 =?utf-8?B?Q1d0TUdTLzBPWDZIbmhRb3BKKzVRQXZWakdKTnFuanlQSk05R2doK3o1SVlq?=
 =?utf-8?B?R2VUN2FjMFE0RWxhRVQrb0h0ZDRWMHAzTFFSM2dxb1hEb1NHYTJKZ2IrUi93?=
 =?utf-8?B?dGNhbUtRRFlpMXIrRERYRFRiY1V3dkh3NVRaU2FoTldwK2ZzZVU5TnFsd0J4?=
 =?utf-8?B?cHlVRWhKcERBTzZXdlFMZUlsT1dMQi9Ic2pldUxkcW9FRU1EVHVCbEE4cnZJ?=
 =?utf-8?B?elNOeDRBdVYvWTE0dVpNTnlzRmxzb2l2N1NDNWQrd3pVYU1oV3hiZ3o2eGMr?=
 =?utf-8?B?UmN1V2xqeW1RWlR3azdjOUh1dUlpWTI2ak8ydThON1dnMkhoRS85N29IaDlO?=
 =?utf-8?B?Nkh4T3ZOdTBVNllHNyt0MXlXS01IaTd4NjNUY09BTUUvSGxqcGhBKzE0NWtx?=
 =?utf-8?B?SG5LL2lpWTRacUUvZlY4RXY4UVdFSUVjZDFLQmorZDJaYkhyS240RFFDcWJ6?=
 =?utf-8?B?ci8rbkNoekJ0TkR2czF0ejZrWmt6azJVcVpNZFpNTVBqM1lmdDZHV2F0cGEz?=
 =?utf-8?B?VUpYbVpuUVgwNXdnT3VDQlcwMktRMkROdllER21MNkQ5N0YxUFoxMEI0TUJX?=
 =?utf-8?B?UVZGcitQb0ZWN25oNEp1Ri83QWdaNXRMa05ORkY0dVdHL1BmWjFlRDlyTFBV?=
 =?utf-8?B?Si9MZDh6dkdnbVRud0VvY3JBWWxQQkhvQTVVbGpCMTlveGdtMkd5NXd0ai9Z?=
 =?utf-8?B?ZForTG5pUTB1OGplZGc3dGRINlBucWFrTWE2M0w2bXZwT25TMUtjdE9TTnUv?=
 =?utf-8?B?dDZrbXpTdjA4YVJqR243bnhaa2F0L0xrSE1rVFFmb1J1c084eFBIK3h3QUtX?=
 =?utf-8?B?eXNNVDd1bnN5Vm04dnd6YVB5R0xTYitWa05oQkJGa3lVZElFYXhyWXFCd29u?=
 =?utf-8?B?RjVPVjBGZnA5dnFET2RpL01Jbit0SDdQQ1F4ZjVBRnAxai9oL2E1amdXU29j?=
 =?utf-8?Q?qtRd1LUHXaX1qr4fe8bNCGuNeOGMg3jm5stlzD8Vh8RMG?=
X-MS-Exchange-AntiSpam-MessageData-1: chNpb8cj8WtvIQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3026ddfd-046e-47c8-ebaa-08dec5fdacbd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 08:04:05.1143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VkDhbMZ4TaGPZzi8nrPxBf4dJ5R/yqEF3xLG/mZgFmV4+czfSK6LapBpPv3mAyooI2JAuf6w/ZJiqrI+W/iYMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5616
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
Alexandre Courbot (2):
      gpu: nova-core: move GSP unload state to a pinned Gpu subobject
      gpu: nova-core: move GPU static information acquisition to a GSP method

Joel Fernandes (2):
      gpu: nova-core: gsp: Extract usable FB region from GSP
      gpu: nova-core: gsp: Expose total physical VRAM end from FB region info

 drivers/gpu/nova-core/gpu.rs             | 107 ++++++++++++++++++++-----------
 drivers/gpu/nova-core/gsp.rs             |  15 +++--
 drivers/gpu/nova-core/gsp/boot.rs        |   7 --
 drivers/gpu/nova-core/gsp/commands.rs    |  14 +++-
 drivers/gpu/nova-core/gsp/fw/commands.rs |  47 +++++++++++++-
 5 files changed, 138 insertions(+), 52 deletions(-)
---
base-commit: bfd90545ad9ef8bed2ac7c157fa9db7604befb27
change-id: 20260609-boot-vram-00d5057102d5

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

