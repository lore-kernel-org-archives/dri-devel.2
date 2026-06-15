Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D473CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:18:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E36EC10E584;
	Mon, 15 Jun 2026 17:18:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="RgU4DauI";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020104.outbound.protection.outlook.com [52.101.196.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5338710E584
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:18:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+AEAz8iqx3Cbdh3WWk2OHvG7A9tBtTIWHd9RtQSsLDvJ11eguyHIqeHsMxn5MEHQ5omgXBNS26GtDsKczN9VBAYG7jOJyAvmlTrv6bLFOqsNeceVBiyToSiTo5kMbF5dRqtlPOJqymyIF0gVJ+565we9bEHGAyHECfvHhhpuI30lYAMO2c8w2yNeSefH76rPU7ORw0Rp5XfAH5NQb5jmhqWYskw6NXvxaw7nMciAGACMdNnIRgBVAShnxkSamydCUSBYMiNba8Bg0VjfnFpzTzjgPhwiofhJRRY7rPbQniiAsKPbeLLlzTV1l5ibYvx8/ucFNWtpfWoO10Zsuv9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSIJCZ8K/vqGWnuj9Yb59YivrSPIBEcSr2q5rkd+MDA=;
 b=BTvIRrZc+jA+1U5OOg+mNBWys6qI6KrFe0BKulgwuxVJjVMi78+a8p5py63Ych5fdaI2Ly+jKLTvIC3g18ZnGpnfPgs2IRuNE7KYDGnMQhaMPeKZK29G7hql+uQr0lMRDDQjrwwwrNaXkxmGjZLGz2Blvyn/9AQKKfyEZ4daczHBe/LUoBZfoo0OLl0zAzWgTnWcw1+7qOZZXF9ng9Fxlm7XSl4QxBP+7fZxAi972XBNsyUJN+uICBgEFX5tRPvqgmZ3jWuIRPXoxFz4oLdEHCrtrXNUpMevigZdFZTblYtWhiBWlb2iNNG6AtOU4ztGGsLcyn+fgq6HE4qeg37+Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSIJCZ8K/vqGWnuj9Yb59YivrSPIBEcSr2q5rkd+MDA=;
 b=RgU4DauIEDEz95Af1hExZfoBftu+GIk2NKtwYbve9OrZaClJsBUy5ZWiIBdAHxvbhArbSKAAaiVr4y/AMCJLzORiE6ysM88OYgjUQi1pl6oYy92zHFnn8fg38C661SZc+Qa8uZ+f7h9ZceF0tClJYXSfrUBqcet5m7rfx551bco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO3P265MB1817.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f5::14)
 by LO0P265MB5143.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:283::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 17:18:05 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f23:4d73:6ff9:2ea3]) by LO3P265MB1817.GBRP265.PROD.OUTLOOK.COM
 ([fe80::2f23:4d73:6ff9:2ea3%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 17:18:05 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 18:17:04 +0100
Message-Id: <DJ9SKUFCWLEE.3T7RIKCM3J7Z1@garyguo.net>
Subject: Re: [PATCH 04/13] gpu: nova-core: falcon: gsp: move PRIV target
 mask constants
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-4-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-4-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: LO4P123CA0120.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO3P265MB1817:EE_|LO0P265MB5143:EE_
X-MS-Office365-Filtering-Correlation-Id: f783a42d-40d9-4150-b0bd-08decb01ec0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10070799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZYn6m0mYT6139fHFbwHUDzEINK/cGWJODwgTSzwosO3okFAWPqrR2zgWm4R+50Xr/xnOAVu2Khcd9ZbntOYewSgwoJ6Gz0Y+lU5mzMHNO7Ei8dSOGMPDm9njFG58BA1HeM72MTxhL63qTPVIHhasf3t89FPjH4gYMknaT46p2CsxlC7iaePTvWLduUK4swASZkIGYXTkFaMnpUCRM0a55cNMTri6oL1PvVO8wh+G+U8RoCYYdRoMAzMNS3RoCMWIdK9BiWBsBpD6de14AI0tS+vy+rYyrJf6E7uL1LUUp4I+UqANY1WycGWZ4Fz2sVb1bzIpjk28VEhsldOfa9pjmte4TabyvGhWTizpkbwHS5cS1gCKVU9OTUf3pUcs5qiJYTTO3/xaxoUasBSKUU7Z14P2Nxh+Gi30UKmERCq9vFcvFXp+c2SgFpd7BYq4Jdd95LVdlhRAv5abmhi4+VDJg2+u1Qd8GxxD/RZ2auroYs+UyX90plPdOldKDWQ3pUu1gQb/4dNiOCRIJSx3z6WevHS8mArCAaGb4H88ERyn/C/Cr3xBg6tnXsvdu+YsgeUjiouvlSKVXwRVvB4ZRgqQj3TW8Z2nKviu0rcsO3HG/wVSL8mVJ6s7S9LuCpCy1fOqA6Jc6CQ6PJRCW/HRIGQfq4sRy4G/1G/IouqbO2kqQVlcnjsu5j+3gepd326z2ySN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO3P265MB1817.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10070799003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVV2aEZ2MCsvTUJyWnZZenZ1aWF4N1dSSWFmRE9lNkRwU3ZMcXhDOUU2OEM4?=
 =?utf-8?B?VFluUlJWby9RTUc0KzhMVWR2bWZLbk1YZFZTT2VuVnh4aU1OVWg4ZFQyeGEz?=
 =?utf-8?B?cjUycVo1VmJxaHJQMGhORENhSXFvejBmZ1hpZDJ1OXh0cVdIalI3bTUxSjM1?=
 =?utf-8?B?S3VsemZpTStDbGgyMmxtaGJ4eWdpb21yUkpNZGlzaXdXWEMwd2NkUDc5emlk?=
 =?utf-8?B?Q29iL3RZdnI4YWRmNWx1QnVoaTRBc3plTEIxOFhhR3VCKzNyMGlrY1g0UnB3?=
 =?utf-8?B?RHdWMzZiaG1rSGRTZjlsYjl3UWdFYkJIV0hYZCttelA1WEx0aEVWbmNMMXQv?=
 =?utf-8?B?Rk5mRml1djRkM3JFN1Q2S2xHQy9QWVJ0dmI1UmZIbkp0by9BaXNhTzhRRlF0?=
 =?utf-8?B?SVBuWit0UnpqSWRyYnRJelpDVzAwbTZZMUFQSk5PMkRoYXVIVU93eFptbjhu?=
 =?utf-8?B?SlkvOUQxS3l1bTFpc0Iyc05sQWZBell5NExPNWJBR3dkSVRDT0pSRXdLZFFw?=
 =?utf-8?B?eUg5SVZKczdNaWdab3UwZ2lDVjEvZE1Da2ZVN0RadmZuVG8razhtc05nbEEv?=
 =?utf-8?B?dkY2dU5qdDBXRysydVVoV3ZmdG1jQ0VxSlJTUElROFQ0c21HSkhtMGxNbFkz?=
 =?utf-8?B?eXdSemNaNGF5d2NpeWVaN0JzYmhxRDh6dEEzRVE1NE8xU09icU02ckxWSVFY?=
 =?utf-8?B?dE1qenlvV3pTMElpbjdyNmV2T1QyTEdkMUlPcEx0eUYrLzlWVEh3VEwvcDBO?=
 =?utf-8?B?emZjeTVlakZBaCtzcDlwL3l6S2NuckpvVXpLc3k4STRUWnBITnpMdzJNUXRp?=
 =?utf-8?B?bHE3VnN5QnJRNSsxMFpnZ0lnUWhibHhJcGRYVXhvWmFCT2dEYUxRL1dudm12?=
 =?utf-8?B?WTRycjYrOUpuaFJ4Z2pvUFZqbHhPc3IyWE5XWlZvdzFKM2MweTR1SklmbnBt?=
 =?utf-8?B?T3FISUEvcll5cEJJTGNMeDlBcFVaRHJKVDFEYXBkbVBWa0JtakZ2c1R1OHhS?=
 =?utf-8?B?cmFraDE2V25CR0o3SHdmTFJLcjVTbEhSSTdCL2gzV3pyZkhza1pENjZDR0VI?=
 =?utf-8?B?ai9vSzlLeU9rNXl2djFYekJuSlB6YjlaRG5wOWViU1FrbktYTzRSQ1AvR0Zl?=
 =?utf-8?B?citsSGt6Z1VCbDRrSVlVWFk3cFE4SFhPODJHZFptZVFONkxZcFlSNHpwSXY1?=
 =?utf-8?B?UlR4UG5ZbWtlZ3Y2aGtib2FXbGpmUGYySENGZFQ4K0FqQjYySzdIaEVBMDJQ?=
 =?utf-8?B?YlFsR3dqYmE4WXVkek44a2xiWFBFa3JFc2N2OFh1bFEyUTFRL1B0VjRkSjJp?=
 =?utf-8?B?R1g1WmNMbXJQNGh4N09qckF4TVhvc0RFV0RtTXBpa2dIRXZFSHZjT3Q3Ri9w?=
 =?utf-8?B?QlU4cmM5djRyelBEQWx4aDY2ZzFDZzk1a0tNKyt4UnY5T3IwaG10SlNvOUor?=
 =?utf-8?B?UHErWmhFQ2VjWVRGdnVLejRmNlQxdXEwZTYzVWRlT1VHQmFURFRzZzRhaWZP?=
 =?utf-8?B?UmVCK2IzMDNDNXFpTFhMRmJaNGdISGRrVkg3eGU3dzlBcTJ6ZGRmSnM0L0Mr?=
 =?utf-8?B?bnNaWFdBemkzTjdjc2NPQWNnRUN5cGVoK3dXL2pDSWdzV2pXaW03M2xWU3Bp?=
 =?utf-8?B?K25HSksxTjVLS3NrenpLbGdZZk1wTFZmRUxXMGxzWkJacy90Vk9pMUd6U3d2?=
 =?utf-8?B?VmFublpqV2RMeThtbGNSQlBjV2pVYjFiTXNycTBrV1puOHpjT2JvS2d3bVRH?=
 =?utf-8?B?VHRUS1dsZjBRbFIxSHh5RCtaZldaMnVqUUVQTWkvdjB1bnl6ZFIra29sbm80?=
 =?utf-8?B?aUFMWFo2ZC9wc0lnL0JtYTgwZHMzSXdwMVpZa2laTHhRVjlkNWt6T3VjbHVS?=
 =?utf-8?B?Yy9QaENmNUNuSm5RRkgzOWU5TGt0TGVIM1ZFNWh6QmlYVkNYYUFVU1lGdU4y?=
 =?utf-8?B?LzB5UExTd2c2TUYwamtZUGNaTm5xV1FBaTJ4cGFlY3hCL3V4b2ZTK2diVmRk?=
 =?utf-8?B?NnhxaTNnTXZFbFBmdWdVeUdsUWdiaEI2Q0JUbDM0U3Z2aHJMV2FWVVNicC9Q?=
 =?utf-8?B?VlVWZURzMVl0R1RqSk5Zc09NWkFVcmhVMzhvL0RNNUpUalVQR2VqdCs3aWh4?=
 =?utf-8?B?YVJCOEFQNUZKUnZ6ZThCb0RacFo3WnFITVhCVGVDOUhHSklZdFBuMFhWTVVD?=
 =?utf-8?B?NWdaSFg4VHFvZHF2N0dPTHdSRnZSUkZGWlB6eGtObkppakRGMU11WkZkNVJj?=
 =?utf-8?B?NHdCaGlyOVU4bFVOYXRGbThxdzdteVIveG5yc3NZbldaVVp6YTJWQS9oTHZ3?=
 =?utf-8?B?VVJLMERxMmFRUlJYK2tuTHY4elFHYURQRWVtYjZhaEFQN05zZVVTdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f783a42d-40d9-4150-b0bd-08decb01ec0e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 17:17:04.9678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxjH4+CrW3DffiX0SV/kDruM2ejyIfhZAzDVuVO6zsmsLAYTX/+ALkb9FcZ4nQNZI+lEr0nRbNoJZFS+n4zCIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5143
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

On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
> Small cleanup to move these constants which are only used once closer to
> their use location.
>=20
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/falcon/gsp.rs | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

