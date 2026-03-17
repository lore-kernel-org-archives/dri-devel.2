Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E3FFD875E
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0B410E35E;
	Tue, 17 Mar 2026 13:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="WF6B3iRR";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A1710E35E;
 Tue, 17 Mar 2026 13:20:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l55nx0fu4Jiud2oGKCJaoeET2f1BfOidia1Pf3xorYjNmROt4zT8cWMRV3b1ErwnLzQXPkCSqmNGgxFwdXl1ynmCYE+iHF1syMw/qYLXWc3E3W4obXjZQNgnAJQ3e40ho/Qb0dbjJmvXzsAhJCKz2Nhle/MZaIxMCazUxs+7XiavdfKMmO51qFDdcrnW7uL16qgfxcHP5UpFKs8zJDTVfrIlaS2NHR83Q++brp+VWwcbg8LfKl6cMKRQfOWytPjfPlQjWdy+1BaZ3OcQjjh1xfJLTsnb7slrqN58Db69YZ9oDBp8LzyM03tHLJ+jqTeBlgxNNK0THq9jmXkDVOZNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE445t5xQvZrlIzb0YDH2u/gCpj+H6oqQUUMDGIC4fw=;
 b=YQ3CkS/m6KIHzMF18ggMMI2MFRDrVqjGWZ+N0TqKBHUZK8XPbHJdSAaUwJ2nvh54wYVkMatZTRUVVCwl3r5BUEK8kGJRL17ZlETajvXejruzOqZUmhKlfPxBhaAz8eFxqXZ0ZBQCyeqHkeYEM4shm1ASR2+8URoRG9t+GvGoAwqR00ESGZ7cBSOF+wOz3+pkqx9GU8WQQLVEWJJmerU0Thd8qey9wzYeO3LArZrbby7b2RF8Ess8jZLl3jJ+Us3aCoM6E2jXmem9cS2m+TiWbGbKzIbpp54hBNuHU8/jAVtVdOGsS1V0RqPPOYRSJ8gttXZsYsoihGzymjW8tPbAlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE445t5xQvZrlIzb0YDH2u/gCpj+H6oqQUUMDGIC4fw=;
 b=WF6B3iRRUxbBEcpO5k5NQxDucY/BxGMwVYlKrtDRyiQHgrtXLUg3vvvyLl/h7b3Io5LMl7F/KPswSJr0iBiomqTmTUmF8Fuxq6d72qpaTKt8K+yNsIQfGBssp2DQNBNaEPJgVwCZh8fCt5PxAMuiKHip07VneVyQucO2fpq0cKDN4DyBTVZJ1nQdeCdlIhak8Y19Qlseg4rHJYYUpVOTq39jX8KuoKk4Fcn9NYmPny0RKJl2ZGXNYbGpqhYmkztpxLZtli+ThAZcM+GW/dVuuXq3rTWapWFXMVzOky19TYmicpiZGxJCWsNLFTWv3sTMEyPmOJB+sg/hOJEZhG0hWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA5PPF80B25317E.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d2) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 13:20:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 13:20:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 22:20:17 +0900
Message-Id: <DH536IWQDX23.22R0P6FT091LH@nvidia.com>
Cc: <jhubbard@nvidia.com>, <aliceryhl@google.com>, <chia7712@gmail.com>,
 <dakr@kernel.org>, <dri-devel@lists.freedesktop.org>, <gary@garyguo.net>,
 <jserv@ccns.ncku.edu.tw>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <simona@ffwll.ch>
Subject: Re: [PATCH v3 2/2] gpu: nova-drm: rename nova to nova-drm
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>
References: <e7539fd5-9a0d-4a06-aa02-ec3dcd235926@nvidia.com>
 <20260317092304.424377-1-yphbchou0911@gmail.com>
In-Reply-To: <20260317092304.424377-1-yphbchou0911@gmail.com>
X-ClientProxiedBy: TYCP301CA0054.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::12) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA5PPF80B25317E:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6ae31e-6fc0-450d-9cfa-08de8427f4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: 7fCksSmrIwK7wTY3QJF84aQ9e2Gyz87ylVn97a8D9AD6VaSJHQ3hHAF/+JBJkKJFaOWgOWg679s7af3D8O6vNwfmV1KXaiizhglLvMsidD0b9mXBirD/rT/VngaGt6O+bXITKg4bmHKxghsQEhdxx7EuNgWTe+0PHn3w9Dt466pquwOptFtFYkytZ8HK/MvRrDlX6VVQdcz7jbXgy3BjblRCx1E64ZWRFtPmkviQOnKQXD+vKvTtehTVlQzj/omqk6WJqYgYRwj46IktiX8zPrfk6EGhGDDLhr9QZLG6bvKlirnwE2ywrDP58jPo53vG73W7ZlR4B5RjHKycJAczeGX7tKRabT4wRxAhEWo73LCymzVK6hzuK84JKnpFEHnRGzpx5DWDpanI29mMiwVPa+d5395RpBkeWInAnsN5qhJhb/VzC79pDJ/ZRpTtLJ9uXRlTgxYNsW/YEllPS2RXGRCEgCRhInjpHn3w+Uur6DRFGtZoAsbnDeVqPf73XgcFkRFgKBnBYgPEM4MBs3wA+2EYf0L6eUEBFaixsuAluYfFs+Nd7HUjFkMNu9RsjMRcXNzT+ai98FfVK7RuX5E50PCxpbpbYlpvTX3JhQe+q5P3s8rvnNRWKd9kBMmKQh6Iq0Jhhx/lod41gfEYGBu/ty/Q7T6suGzqnXhgOPtpj7BC4/tzsnfXEBHvCQAS3qyJ2j3D5Wy9zYWmoyhKDmlvRXu+wpmasb3tNh/SaS2uKk8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjdNK0VLaTVGY2IrYy9CRU5ob3JrQzdpamFjd3VROWE3eWd4K084ZmZlckVO?=
 =?utf-8?B?akJGdXFwQUpXWnRzM0hMcjRMb3RNSm9LVWFzNzROakVFVTVvL2l2SWwzKzJa?=
 =?utf-8?B?TG5OWHd1QThuVmp6Si8vb0t3eG9NNzNlMFZ6SWVJWHowcGdGUCtub09hUnVy?=
 =?utf-8?B?dFdxV3pxQ3VrUml6d1FHcktOcnVxRkZ4dXRkWTgzRlFTdmJneFZQM2RNQXFR?=
 =?utf-8?B?TnRkTk9IdDZTQ3JLdW9XZ3JNTFRPVjJ5dVRlbzI4cjM2TFl5Ky9EZnIzaUJt?=
 =?utf-8?B?UEJRNFdyY09DSFVZT2FZSFp1UEUwZHNvNzJxdXBTSVlBZWllTWNpeW5FNmFT?=
 =?utf-8?B?SCsybmY1cHFMSW12S3FMSGk0WVlvR0VIU2ZHczVDZm8yQlZoOExKUTlNYlBz?=
 =?utf-8?B?YXhQVHkzVXQ4NXVzMHdKekZEVGZtSE1Bc1FPWjdnSE90MkNoQTY0Y2RuQkFh?=
 =?utf-8?B?dW9ISGNRRGI2b3Qwd0VodzA0QjkxNFZ0L2VyUC8xR0l5SGQzU0krMm4xOW9G?=
 =?utf-8?B?aGE2R004YVhnK2cvUVYxUE11amxuZFZPN3ZXOWRMeXI5WG1DQnNCWWdlYTZz?=
 =?utf-8?B?TmRrSHUrTHJjZnhWV2JBUlUybFE3dWowRE9xcnIwNlZxU2lwRU0zcmJJcVZj?=
 =?utf-8?B?RjluQzByZkgyUVR1U3gxVkViTERMTlJOc2tnaU00ZGlScVY4S2Ywb2Q0OUNj?=
 =?utf-8?B?a210VjBEeGQ3bXVDbHh1TkczWmVJcVVJY3RjZXQyRnZnSjR0bDQwMHpBKy9w?=
 =?utf-8?B?NnhLeDZNS0U1dlQ0YlpKRWhUMkxwaFlzU3ZKaFNsbjJFdVNsb2RpOXdjYm9U?=
 =?utf-8?B?QWJ6Y2xwbzROTFVZS2N1emg0UHBLVDRVRXJKQzlPRDFJVkF0b05iWSsxYThv?=
 =?utf-8?B?ZXFlYjlOVVdkd3kvR3JLdHJvRWpwUlVCdVVoODdLVXlWelJzMERpL2pnWUxI?=
 =?utf-8?B?M1NicVVUT2xJSGx1RVNqdnV6dnR0S0FDY3l2cFMycG1wZ2FuZ3o2OTZ5ak9J?=
 =?utf-8?B?N3lGMjJseXFMdWN4TXhKdWk2UjBoSldCNW1UR3JNb05ibFdMbzU2dHpuY3FZ?=
 =?utf-8?B?a200YWxWanlKZnVUYmxLNDBrb1NTWm1NM1d5TDFXT20xK3Juamk4ZWlMdGU3?=
 =?utf-8?B?clFMb3pYYmQ4WkxGRGlJaStSdFRtb25qMVJ4Vk1yL3B6K2NHb0Q4Q2U2dTdM?=
 =?utf-8?B?OVgvTjhQa3hiRGtVbHdpU3h4TWR6N0s2dzJuZ1RHaGhUdU5BZld1cEpuRGNV?=
 =?utf-8?B?YU5YQWtNZ1lobk1hSW9mRWdWR1JnbWZ2TUxXZjl6Qk5kcUZ5R0R3cWRXRjRl?=
 =?utf-8?B?QTQydy9EQS9iMEg5QVFmWkVWcEllQnBnZXQ1MS9BNTRDdXVmYnRKbDR4SExJ?=
 =?utf-8?B?bEVNdUdWSkc3ZzNJYnNubW44VU9aNHQ1VXMzU0s4TG12aERqRGdYNW5PYzZP?=
 =?utf-8?B?V2lhQi8zamo3NDhIWlJBYkdnSDRPNnBEWE12cFVqYkNKcjNTOXlNR2c1RWN5?=
 =?utf-8?B?SHlIVDdvWmpSNWx5TG1QUnpNd2JzOFhaMGZFaXQyUW43cWkyOXYwdzFVTVdm?=
 =?utf-8?B?S0crbGVzdkovTzBrR3NBZyswMy9vVUhscG1SZUNxdDM2WVREc2h4VGFSZFVN?=
 =?utf-8?B?U1dmMTVRR0dZcmdZQmlkR0w0MkZKWlNWeEJYSWljdWdadE42U3EvTndBYk9v?=
 =?utf-8?B?d25pN0sxUnl3UnlNd3luNzlVZ2RsYTl6bFVpUkk4dGczTjUvTHhPendSTFhu?=
 =?utf-8?B?VkR6cDQ2RmVtdlBhbjJCTjFYeEJZd0JqSkpxWjZYaDZPZTJVUjVlTmNLS01m?=
 =?utf-8?B?SFB3YnR3dERaNllTK1RmODN6OGZBdUNtY3pvMmpRR0s0dGhZY1gveFpGNXIy?=
 =?utf-8?B?UHJFbGViWWVxb3duVDNPVXhLVVdTVXlURnRYNkRYWWNQUGl1MFEzQXE5Q3Ax?=
 =?utf-8?B?dHhMaWtlTWJ2Z1BaQ3I0TXI3bURvUVBBb0lLcVFiVzdxZ0x6aEltTWpTMlA1?=
 =?utf-8?B?TmVFNGNxTmljYjJhdFgrclpKTTVDamhWUHJVRVY3Z0l0WFliUmtvY3JRNXQ1?=
 =?utf-8?B?enlQWTBHdjNHbWFOUkxoQ0hubkFkaDZmY3o1ZnRwdmgyOGJhRENxSmIvdEp6?=
 =?utf-8?B?c0FlUThYUW5UNThCQTg5RnphZ2ZxWlRCbnloU25rY0NHTzJqYStiL1BBUUJM?=
 =?utf-8?B?SlRGYlhrTVU3dncyK3Z6N3dncW8yRWZ6UjE3cDRkYkdqbElTUkdzeDQ5TkJa?=
 =?utf-8?B?RDFma2lXcmp0THMvalVxNklJbXVZRUtNdDVPWDlld3R4WmNaWTcyNTU0TzhZ?=
 =?utf-8?B?YkttRUNkSVhiQ3VBSFMxeGFIRDJQSTRJamVMT0NCcXIvbjlCVlkyQUVTZ0lU?=
 =?utf-8?Q?Hjv52bF4dpoEd42dsaR7wuHbw7DDLw6w5mt1CrGt2yTjB?=
X-MS-Exchange-AntiSpam-MessageData-1: NCy0oE5+fmFNIg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6ae31e-6fc0-450d-9cfa-08de8427f4bd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 13:20:32.1294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq6zcAgklnn4EYjIrYESrmKJfRfEc755UmsbQ4Ki1cckQeC9Yeek1G9h3HmzTjfptx8pcw3bl8QjWgCRMFaSKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF80B25317E
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

On Tue Mar 17, 2026 at 6:23 PM JST, Cheng-Yang Chou wrote:
> Rename the nova-drm driver directory from drivers/gpu/drm/nova/ to
> drivers/gpu/drm/nova-drm/ and the top-level source file from nova.rs
> to nova_drm.rs (matching the object name nova_drm.o) to follow the
> kebab-case naming convention already used by the auxiliary device name.
>
> Update MAINTAINERS, Kconfig, and Makefile references accordingly.
> Update the Kconfig help text to reflect the new module name nova-drm.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1228
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
> Changes in v3:
> - Rename subject line (John Hubbard)
>
>  MAINTAINERS                                            | 6 +++---
>  drivers/gpu/drm/Kconfig                                | 2 +-
>  drivers/gpu/drm/Makefile                               | 2 +-
>  drivers/gpu/drm/{nova =3D> nova-drm}/Kconfig             | 2 +-
>  drivers/gpu/drm/nova-drm/Makefile                      | 3 +++
>  drivers/gpu/drm/{nova =3D> nova-drm}/driver.rs           | 0
>  drivers/gpu/drm/{nova =3D> nova-drm}/file.rs             | 0
>  drivers/gpu/drm/{nova =3D> nova-drm}/gem.rs              | 0

That `drm/nova-drm` reads a bit awkwardly to me and feels unnecessary.
Even `tegra-drm` is in `drm/tegra`.
