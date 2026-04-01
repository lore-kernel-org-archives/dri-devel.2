Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC6E10F6FD6
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53C010EE51;
	Wed,  1 Apr 2026 15:29:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="B4BM8mOP";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021100.outbound.protection.outlook.com [52.101.95.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB8110EE51
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 15:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sZwl9F4wogMp3oqMhX5L9YkwKRg32FGnC7sZyneku9MQmODZ7//maXJK0RHNSKKIuDsTYYEMw1K0ELbtpXTMnXP3UUD9/onX3DNgPVbP14kTbaAwhUFjI0COI0rHrwif2Oc4xz+RJAlsSzqfPEdpl3t9gZ7UedW6zkZtCx3+HdncY3AS+VN7tEvJsdeZEKxh9H6YZjlzVcHMRFCsIqhjwclsZ840ZlSjCQ8lXUy5u39vZ4SXf1jLE4wEJFgfh+/duAp68Le2DoR1+vYpzdd1TEaHjUFbqm2akmhGd9FWqFW2blU3DJHeAEFoXYKDEOYd7L8ifhySmPifTwfVzsNA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txQTFLO28rI6LfwbciQVzzLi5iUYqRNpEuPzV5vdE1s=;
 b=jadfb+SHmN066efoj95aig9Gbf72c98rYGo1oe1hr8ZWpKGhIBZrR9nksmZqtJhCKff/Gx+kDUDfRdtJ35n95pXn4nlNXkeK+76FfEwBBSvaehtoXfRE+JS8Y8tRuhihsxI77jdZU7cRdf5XMPfNlbp5vq31nhCJoDOvQNRDm/hQC/JS0GNPaPdks84kg0r3jSUjt/giOnuY/FLRIwZysJghCfcpPu86Hd0Udw9imCsdbbHENzXAvDxirXtFcrEb6Y58ME30RXLEYZ0kU/a9qxWQ9AImJ7jJV/3xgpzMfvfrFI7unA1YzDQYSR+VD+rE1Cd7tnLis11SXgCtq9G2zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txQTFLO28rI6LfwbciQVzzLi5iUYqRNpEuPzV5vdE1s=;
 b=B4BM8mOPOTQ/R9VhuV3erUVA/fHKnjIK+vkMX+hewvDwytU1je/G9Tpfknzczx6M0j2JtUYhpHYsoW97hfw4slueOUdRico+665DRHlj/9LHeMiYcCiEHfdiQUoGkhs4RRs5R6Ap9CDjUqJBJt6aWAn52DAn+G/zhDvRdDbyzys=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB3172.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 15:28:58 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 15:28:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 16:28:57 +0100
Message-Id: <DHHXB7LIC81M.2A1JDV6ID6LTE@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] gpu: nova-core: gsp: inline methods providing
 queue range invariants
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260401-cmdq-ub-fix-v4-0-a9a9cf982485@nvidia.com>
 <20260401-cmdq-ub-fix-v4-1-a9a9cf982485@nvidia.com>
In-Reply-To: <20260401-cmdq-ub-fix-v4-1-a9a9cf982485@nvidia.com>
X-ClientProxiedBy: LO4P265CA0088.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB3172:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a286cbc-2e61-48fa-aed1-08de900364cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: wDV2XJkDrM01DrufibM84zt+aBbvzQafk11MXrOzLfhRg5b3+HPh1gOdqQXqs5MiZtzbGnaRZQLEVOY6qrVlxVK+s5IPBE0O+bjRtp1hW+UAdVtkjuRiceAcICA+XWN9IcnORmgFy28V/Z5uxV6lkGMqdT5H8NRSii2Tm0SMTv4PaP6w7zx8o82bV1jplpccVI0aWFLKfZGDJ9d7Vbs3UU6ZLUe8s+Nk2e32euEaKu/Jew01duvybVglHYyX8pD0XdZvGunXoUwCUyU7RW6LCumbyUR9Gv9eg/Mnq3STKUAD71b3F6Fg73hz94YBKS/Lr5t5RRDaczLLOUOjFUwfsvvz1wklCuWFiw+CT3vuoRejPLD/QPgf43U+rwiz5IQVQLIMWmGEaAZLlWRUEHwNpRqF2W1K653h4B3oYV2frD2MLPKkKMx4xbEkMuyOd+hznT6QbPxeMeZKc7f6BSY+F2sgGfR/DpZTKp8wTYjURKeSad+s6MzPAOaim2vP3zbH9o5VJNVoHdaduy6QjgzyPOixFiajpX3zfWG4rtOv5WeBW/b7oDVbN2aOnOdXOdovrkw0f1IqhYreorCZqPu9W/XnOemQ3+OwR4DRcZ39YCzQvXvr5UVKY0pzYpdsUr7pf5glBUH4VFUNJ+xI/OTLy2oOSv7C3BqAR3vvgHZgldfMJ7yIJaGw4I+9RyxL66Wdc0LVmSzf1f8PZQWruuH/ZyiN2rLA7uoqHTNgVUYAF/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkoyQWRFWGo4NFh6UStJVnhWeHRCMWROMnFxT1RyTjNCT2FHOVFhazREbk1K?=
 =?utf-8?B?ZElDdFQzejM1NEt0eklNYndmdWprcnMreDl4NXJreC81bkEvdlJYZHRjaDhn?=
 =?utf-8?B?TWRlLzkzck1ESCs0UEhXbTAxQi9sNnppcE1FZDk4cHl4U2o5RHBMNjhhNUY4?=
 =?utf-8?B?WEJSN0N3TGNySVpMbzNqSUhXZGZDdE5DdmhTTFlJQnUxNEpqTXNKYzVhUXk4?=
 =?utf-8?B?L29oN3RycjlzNG1mNFNMQThtaiswTGx5cWpyRzJhRWRRRDhQUSs2TmhtcFhK?=
 =?utf-8?B?TGdQd3dXb0hoK2YzdVo1M2dUR2MvT2tQNWdia1dGV29UYkM3cDJGaVVrZXFQ?=
 =?utf-8?B?THF3dWRjdmZTejIrbTB2VjR6ckdhSU8rNmcvcG9kVGV3SDdIdHZLTFJYdXpD?=
 =?utf-8?B?djNjZzlvMGNOZHNaY3I0eUdNcjVHdTNBKy8xMXFLeEhiNDN5QjhnMHlMTTF5?=
 =?utf-8?B?VnEyS0Nhb3VacEU3K2x4TDVOOUlSS2NyZkgxS2liV3hDRnZyNkwvV083T1VT?=
 =?utf-8?B?enBYOEZDWnR2K0RrVFAvenF2YUEyWG5RSmI1dXRPTHhlckxhQU1MVkRkZjlt?=
 =?utf-8?B?VEZIQ2JKMGlWUnMwM1hsanZ6ODJYTUhGVzMxL3AyZVBPSjhBcFArVHZxb2lu?=
 =?utf-8?B?cmRGT0NZVTZSanV0dTl2K2dtTXYxSXpYVkJZUkhwQnZ1cEczY0dHbFFyZm9D?=
 =?utf-8?B?bHlaRTN4UWdiM1NtVHZscGx0VlkxSHNuQTZvT01xVzlyUVBwMTlHR2VTbHll?=
 =?utf-8?B?M1F4S2xwYjQ4SkUzWkFKeU5LNzM0VWxuZWxLeGg0ZG9FTW8rbGNxUGlDaElm?=
 =?utf-8?B?emZjM0pBSU5qRnk5MEN4VnNUWGNCQ1J4aENDeFh6TGVhdE01aVJDbm8xTkFV?=
 =?utf-8?B?T3BlOHJsR0UwNkdwS0RCQ0N0WVJqRkNqalNKaFozQ3h0Y3dURkthRXBibzNl?=
 =?utf-8?B?TVVNdUYyMnVzL2Ftayt0VXFMSUl2eDEvMFFnd0dtd2FTYk9NZ3JuWXc1M1V0?=
 =?utf-8?B?cDFhMGZ0ZHZUMjEyV0EvSi90aFFsZ3prYTQ4eE1hU1Q1d0d0MzZTSUpXYW11?=
 =?utf-8?B?dm9INFBnY1V5UXpORTlhMEl6cjUyVVVjaFFQQU4rWUNKVk5TSHQzWkp3SDEy?=
 =?utf-8?B?eG1ENjlRNUVsV2JndW1qZWZLckM5RnRPRUdTUXc4WVowV2k5UXdsdFhGVTE4?=
 =?utf-8?B?eFNPL0sxNzhIMmlyZ1VZaUZsWHlraUF4dnM3RmJLWVRyelZhTTFyaGNsR2Fa?=
 =?utf-8?B?T29UWWlHdkc5Wmg5UjkvV3A1eWlUbFpjM0lPZ1piS2dCeE5EMllRVTkvMFc4?=
 =?utf-8?B?TWdkWncrL2treCswT1FCaWJadWNvQmZUdG1ROGloUXY5ZUVxOWpZYmR0OGhu?=
 =?utf-8?B?NGdYQlNOTFZqRzlVZG1QanFDdHlPSEJnM2FhOGp0RU1uUkpwaW5kZkY5WDQr?=
 =?utf-8?B?UWhlb2Zua1BKRUwyTHZsVmhEejhFUGdxdXlZM2lrTFFRTDl6U3Q3N2hnTXJ2?=
 =?utf-8?B?QmtVQzhCTnh3dXRBTFJkV2ZsRDNhUEYvejBYV2hGZ092UXJPQUUxWWdncHlI?=
 =?utf-8?B?ZlFMYkhKSTJ2d3dkdVhhN1NsOURCdHQzRzNNdDdlbTI4Yi83UzNmbEhhVFcx?=
 =?utf-8?B?WWllT3YwOG12RitZNklnSkIrbnJJeVg0czFzZXF0bThRT2d1eTFpU21ObTRQ?=
 =?utf-8?B?S1ZqWFo2cjdKZnpTY1RqSFV3bTdoYzN3ZWdpZ0FlNVBWekJVUXNacUVsRy9V?=
 =?utf-8?B?bVUwK2MwelF5VWFZSi9Iai93WkJ3WVArQ0hhcFkwbWVKeWZqbjhobVlFN013?=
 =?utf-8?B?bURYbHhZMERFcjY1TDdBbzVRd2wzQ2JXRHhiQUx3cWFjT3I0Ry9wK1JTNHFK?=
 =?utf-8?B?RmhEWTR2TFlIK2ZqZ2Y4Vkl5azY0ZHFjSENuODIyMG9kZ2ZjOFVPRm9MZ3h3?=
 =?utf-8?B?LzNFNEVMT1pOUVIwb1ozU05kSVJTOEVndmp2akxSUkF0WnVhNXFKdm0wdndS?=
 =?utf-8?B?OTFndmNuZVgzTWsyL1pkTFo3d2drbkYwUzVYeklQUnEzY203L1VEdmJGM0ZI?=
 =?utf-8?B?ZDRVSFc4Wm9FK3JvampQSUJ3Sk9mc3dGTDl5SE53ZDZzZlRyZ2lsMDZxSm11?=
 =?utf-8?B?Vzg5cXpTMzVuUGJ3N2pydUtQV0M1OUV0Snp1dVB2R0xvS3JlRDN3eW1yZ3R4?=
 =?utf-8?B?S1Z0aFZMbmRyR2xRVm1QS3hMQkpyUG00cUhEMWI4SW9RMTVTNDFKWGlGM1NQ?=
 =?utf-8?B?L0NDcGYxRXIyUDdXTmZBOEFDRGdPa2dpeFpiZWNuYzlaUnF0M05DUndBbWN2?=
 =?utf-8?B?c0ZseWRmMUV0UFRnVTJkS2VQczQ3U2RjNmVjTVVxa0w5azV1Q0JuZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a286cbc-2e61-48fa-aed1-08de900364cb
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:28:58.4129 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YStJu4v4qt89qbPXGjVs64b9risK5D9tb5yQ1Fw3TslLD88DZVtaTsZt3LTMr/UTEUFogvQYn6MXMc7cMzpLvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3172
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

On Wed Apr 1, 2026 at 3:29 PM BST, Alexandre Courbot wrote:
> These methods hold a range invariant for the read/write pointers
> (namely, that the pointers are always in the `0..MSGQ_NUM_PAGES` range).
>=20
> The calling code depends on these invariants to build properly, so make
> them `#[inline(always)]` to ensure that they are propagated where they
> need to be.
>=20
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 4 ++++
>  drivers/gpu/nova-core/gsp/fw.rs   | 4 ++++
>  2 files changed, 8 insertions(+)

