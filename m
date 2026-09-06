Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC99C79F85
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 15:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D0B110E3D5;
	Sun,  6 Sep 2026 15:27:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZG1UkXB1";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD77710E3D5
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 15:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pg+l7VJiepHAjAO9tV0AywCBbpYt8O4YEvluX16ESoRxHv09LhJTU+em7J/W+sOzWU8eLxz12piz0C1O6czqdYpHqC2MKpa/7Y2uEqtngIUpRXNXPKd/Ai90B2Cd7jwOC5WKQ1lw2x2KfKaeGJeDT2Q2NO7+bgPMgR3rGBtNTFKBW7bBXG4U79RPFdKTJ0DTrIAaJuAP7lKA5TM+vAApwwtgy9zQeAixyfLKigmWTFk1XGDit+jgYKQaT/l6K/7DSjSj+g9MVs1tv/xkjQQrTewROWs30plx7Yp+Sd9NQ7rmuqLQMHboqi5RmnX3G5sx154UzJyPa7RGUQR7H2mJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=paaEHxz4f6SbB5a0SreFR3ybDajllu/5hnudMgPBrGI=;
 b=h/gKbhef13m4P109xWPJ7D0uEEHjhF0Ci27/Azud/JLzvHcELdDWShjVTQFhCDw9mjDM6nvtzzKfIQ2o8PnP2nrj02yGWKw2O6HMD3Gku0KGZHP3ZU8nWr7bAsZLroLBUFfDx7R2MPhH3E43mF4iy10LTAgxoO2t047CYJWr5bnpnQyzDF4Oo//5SOF88QuxnYirKdOQ7acP+CUiiWsg3EAVXJ8B4+iRTLZtOi6fyE9DCZlauJyXIArFaDo/c51Dw+XB4Wy8o4bjDiu42YOaXKRz1/UDxCwaKvtD29QDkeAbVH3f+x+Mfy180fxesqBk9TXjbFPMN1XzUM142rRdrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=paaEHxz4f6SbB5a0SreFR3ybDajllu/5hnudMgPBrGI=;
 b=ZG1UkXB1rJTlX3k+ygorcsoSPQqszm/98Hcs+AK5aUxNYQCWUq92xFA1aLsEEkDxug+Qt/hQhtmZBENJtJvHna4k5Ii5mg5OQolfLdVfTvcd1VAI1kRFxDLeotnFYCmYR6/TLqXcLduhwJ7Rn8V5K85fByDZKSCZvcc1fir0Kf90avD+TFIPRrMnlLyOl23hQMRWeUw2mcrtEBn3oe0sH9xWazcz45yfHLpcOtAB7ph31XlJtyViRZ6g8ebxrBxdbA7hu6jmzHKCKjWhROeP62RC5mlNlwznGWOJF5+EAbsnq+btmRX14PejzqiFQdn0y464xtPyuPg350R0JfH01A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Sun, 6 Sep
 2026 15:27:23 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0382.007; Sun, 6 Sep 2026
 15:27:23 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 00:27:20 +0900
Message-Id: <DL8C81PZ0XFE.3ASHPUUJJTH7G@nvidia.com>
Subject: Re: [PATCH v3 05/10] rust: io: add static `cast()` method for views
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>
Cc: "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260827-pramin-split-v3-0-24b24d7afc52@nvidia.com>
 <20260827-pramin-split-v3-5-24b24d7afc52@nvidia.com>
In-Reply-To: <20260827-pramin-split-v3-5-24b24d7afc52@nvidia.com>
X-ClientProxiedBy: TY4P301CA0103.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::18) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: dcb9aa7e-8d6e-4f5c-10bb-08df0c2b5958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|23010399003|7416014|1800799024|376014|10067099003|18002099003|22082099003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: JdWLsw5d4uEKL4UBU84uriOu5y59JT7q6vlTzZEWotL0ULUP3EFdFxYRz094w4SkRHJhyCyHyoK1Xl7Ww7Fuev8JqHvPhQtYBjf7Mg5gThxuxk4iconpU0cqQmxEeU34HX2vaR977egY911nEFvmhygei45cMPnhE2oZJSB3DjVAVzXlKkbEy83aFSnapPAwFCrjJwT6pes1Kx2+8HbSGFCrjmWSD/RE8PmyKzGgVYSxGC6Ve3/2Bxh+GDwfKHco2Xs78aqGbhPo+Uh6pY8fregsBwuxKpVyVJYlMOlVD2oCqtT5mU/1oONioSt7oJF4zHfK0gyeMJdL2dFP+cwohQk/+mC0AWoPcRg53bIkWpGrcTri6wGqRqj10CuT3YH9zpI2jnDCmbpBX2vASbMOHULFdKAz6ImlKY3Q7ehitFaPPc3/SDKtIwysDGVkURANwJ2QPPVy4NoSmpg01kywYybMTbosoF0npNoYsXM+EYR6vCRGShRp0vLIVpd9u73ipmXMV4r0Mj5UCBmYjdWArG7y8By06YTj2NeTYC0U//wfAEzq8vSbpp25/MDxteEmG0P4EWQhig3A/xpYLayosNJJVpPiT3F6J+zCk7f84juks4HPcsaREZlk2CGAy5b1ONRFuku3FyZY6i7jk0gqV7SmEA9zQ5rQXfsPmxOt24c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(23010399003)(7416014)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDY3dC81dEVMdjQ3NzdnSnZGR1czQzNTN3NNa2FXREl5TWVMSzk3YnFvdW5Q?=
 =?utf-8?B?ZVdjWjVjOTJNdmFMSXc1NHFJWWlRVmE3OGpmLzZ4YTFvR0pxZnFTdXB5KzNT?=
 =?utf-8?B?aDBkOUU5eFFCZ1lQcXVPUWMrT3NNYk85REFXN0pWb05xcWYxUFgzWVI1UlZk?=
 =?utf-8?B?OHpIWnB6RW1pYlVnalZmOWttcDZSYWNTRFpueldiWEFnMEtlMkhsbnZuc3NC?=
 =?utf-8?B?SlBRUENSWUhUc1FKSFJiZk5xdXBEUW4rdGhsZzF6TkJLNWZkK2dYY2xjVURE?=
 =?utf-8?B?Y09lODBIKys0WjlIUk9jd1lyK1Z0WHpBY2R1eGpMZHFpVTZCUDMyVHR3V0dG?=
 =?utf-8?B?dGdlb0ZVQ0lOSlM1b0t4cVJTSjBnVFBxbjZvWkxKT3JQdEFXL29JRkJmR3lm?=
 =?utf-8?B?WEVScGdjSWYyZzBNODZob0ZiWlRFUndHRGlxSXE4T0RYdytad1BKSUwyWXlp?=
 =?utf-8?B?R2M2S2phM1drbzFHcGU4OGRydElkR2RaNVlkQytxNGVYcWNCU24xNzRiNVRP?=
 =?utf-8?B?KzdQZ3owQ1ZqeFdyeUdGbG9DZDZPcW43WHVPZGViTUVLY1o1Yy95aVh1THRE?=
 =?utf-8?B?U0NrYm1sVFFadGdrOElmdXNnR1h6cXdoL09WQVdZb2UwSC9Ia3lUeUFXdjlh?=
 =?utf-8?B?WTJzSFRXcFZrOFJSZ3k4dlZydytibmkzN1JwYkpnR1FHS29odDBMUUM4Nkgz?=
 =?utf-8?B?aTlLN2JrN1BPRFNzNmxHN0Zxd2JtTzBVL3Myd1hYdzB2T05kK1VQU2EvQ1VV?=
 =?utf-8?B?c1o1YWIvQjVtWm4rU1FHckVmOWxuU01kY0tIRCtHLzdLdUJUY3ByWGUvNVJl?=
 =?utf-8?B?N0V3aWFTTW9OOXQvSEN1aytMQWt4NVQ4Y3RVUGRTUDIxUEVlOXA2enZXUUtj?=
 =?utf-8?B?RklLSjBrbnpVbDlJR3MzY3ZIOTl4bmwyZDh5UW1VMXZURGpkMjY0SWtFM0x4?=
 =?utf-8?B?MGZYMGRJSzdoMWpWeXZkUG4vVVRQYlp6dVFzcDNEUDJRQzRMdDVLdmRCK1Y4?=
 =?utf-8?B?MXhGWGZSVk1lODk2N0NMQWV4dEsydjVKbXJHOHVBNUtwM2p6M3pReHZxcWhH?=
 =?utf-8?B?UVUyNEdJVHNoZUtCTmZ2Q2xmaUNmcUluV0Q3TkRydVNpeC9CVThCb0ZQUHB6?=
 =?utf-8?B?S05zSWtNZzM0TFMwSjIxMEozTU82alFKS0RkUkFwd1pvTE1nSTdiLy90N3dJ?=
 =?utf-8?B?OU9Lc3UxYUMvOUxUUmh1K0dMYTE1UnF5ZkdoOGRqT1Zpa2lhbm8rTy9TR3h3?=
 =?utf-8?B?djVtUklhWW5kWG5Fd3VleVdFT3Urdlk3d0JxRGQrZXhiZHE2dVdUVnVPdDFr?=
 =?utf-8?B?SUpLNjdYc2s0aEc2eGRHLzVUMHIrMXl5UTYyNnFvS2l1MmFGaGoyakVEaHc5?=
 =?utf-8?B?SU85NkJCeEt6UXpQR05nTGlPcFlOZ0FkTjlGWFQwQlhBRk5KY1hwWVdhM2NN?=
 =?utf-8?B?NTZJUmJnN3F6VzdiTURqenc1RUZwRFI3aEFVQVVXZ2RoQTBVd0tsNmlwVyt4?=
 =?utf-8?B?a00vTWs3ZSs1UWNoZG9ocC9Da0FXVEVDUGlHbmc3clhFamphVFVGTW9hVmRP?=
 =?utf-8?B?RWkxVkc5TUUxT3lnRC9LQm9qcXpsb3ZWd21yRGJreXN0eHVXZ0Q0Tm1WaWc2?=
 =?utf-8?B?UjBPT3Fha1lkcXFJWW5VSG9SQlh3eTQ4RktHVThlZHBuTUNZZ0lCNzZWZHNm?=
 =?utf-8?B?UTMxQnhiZnN6UUdESVpsSXNoeWNHR1JzT3BnYm5wT3BRZVkvcWNjVzdCaXFS?=
 =?utf-8?B?bVNPRlN3NXA2dTUzL3ZZcmk2ZGpZbXBoQkN4Z0llT3dzZXVQVzVid0o1Yld0?=
 =?utf-8?B?ZE9WcDRxeWZ6US9tWC96UUU3eng4Z2xSSkZGSGhqaHlMREE3T3hkd1U0S3Ry?=
 =?utf-8?B?clgxbTdiYTJ1OHVSdk5SdCt3V3NXSnk3bThGbzNudndndE1semxYN1lnR3Vo?=
 =?utf-8?B?MDdoL0hpN2xOWkxsbk5Rc2FNTGljVUIyUDlaeDB5UzU1TE1tYlpqZEg4VzYy?=
 =?utf-8?B?NUlOSzVXOWpYTXBxTU8rVjhlOVZVL0g1ajlwUXpHOXp4M2R2d3hMV1FXbk81?=
 =?utf-8?B?NG1UK2N1WjQrNUtsblJCcjNOaXA4N0c1bUt4OUMzSFNTSFMrVU1FUjUrK2Nu?=
 =?utf-8?B?eWtXRnUwY3dHUGY1UDNETkRIMEFqOEtQNmhMUFgzZFBleEtiOHpIRUE5YnJ0?=
 =?utf-8?B?UVJ4aE9uTGE3MDdSS0hSK3JIRU1VRVdHWkFLT3hZcm1BUi9hNUxLeldmRFc3?=
 =?utf-8?B?QlNHM2UxREhSQnVJWnNhMGxRRWpWOUUzclFmc3pqVm9HMVN5REd4TkVKUTE2?=
 =?utf-8?B?eG0vYkhOdGNCWTZMQm5sUWVRVC8waFhxalhpbzhXNHZuNHRiUDFUeG9qWDd1?=
 =?utf-8?Q?LDS7BW8KVOmmYMY2TGLjJOvrzqAGVBCWvY7WiSI1CCfDo?=
X-MS-Exchange-AntiSpam-MessageData-1: rwwJhyX6Qb+/3w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb9aa7e-8d6e-4f5c-10bb-08df0c2b5958
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 15:27:23.4246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrNJPVJ+Il8Vt3s5cUoQIWJOfcXXWn7WcSkyXDC1nmRSiGFBDNfTOFwD247pQDKbTUzmGc/PVufBGj62ROZ2Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771
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

On Thu Aug 27, 2026 at 5:51 PM JST, Eliot Courtney wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Add a compile-time checked variant of `try_cast()` using the minimum size
> and alignment information.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Link: https://patch.msgid.link/20260805-typed_register-v2-1-c3ca142220a0@=
garyguo.net
> [ecourtney: fix the doc example type and doc grammar per v2 review]
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

So I am basically ready to merge this series, but need an ack on this
one patch; I/O maintainers, does this look good to you?
