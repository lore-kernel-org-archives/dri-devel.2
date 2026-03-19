Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0AD1088E63
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 02:18:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96CD610E7FF;
	Thu, 19 Mar 2026 02:18:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DHW388T7";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3595F10E7FF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 02:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2FHYA4L9cmj4PLcMabfKRJI9+Tul9VuOntbnl/W7yQm7DvQmtPLeTPb9GDcrqEXPjkTCzuvM3ktfgNv/I8GBsTYtuWKp/FE6d79AZlokYXqVShP+vViogo86btH5KKsmhQE325yD5MYqTNGjayskWyBPilsmiUx6T3OjaW5XOT39ukvqx99Z+Z1GXGYyzka9s6jWjEnhyQXcqt+7e83xjnq3WFmAa+f0rdGdlPMRN+HlbOsJ868HiqTFWs9iwXcy/8y+HXxjkmqpxMvLZqYbxRrp8H6N1U16dG+V/CULhxSmnl0/rly+bKvdMeI7A2x0QTdcniG/iSc125VtwFhKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ek28bp2pAPWAJn0XpIql9gaimWhI6BedASxTiKaQ6ZQ=;
 b=ggLQB/zwVPO4wK1PG9ISnb4bmfMTWXfyc1oe4l0M6ZXjdTWSqoS3nqYu49CN9+9uTdx7P1i0i2BlgfQhrw84mf9YzhbOl3SkCG5usbY93W2t48wipUlY++03PQF3T8/YvVyUxW/kT6IXXN0iMqbU+abELfA0HVm8d8S4932aa7iBYzlHeVS6vcvxCLQ8V7x/Ib4I3OtgytreNsljdxugU0D9HeghqttQJJgP3+ukB4aKLMI1irumwdHmylYIlCbmCtiGQBnztvL9/Oxyhue7dtaeKNGsHhwWWpA3GaXYrcAs/kRtTvDPTAV/Cerxf28S8bky00o8Tj504belR38Tdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ek28bp2pAPWAJn0XpIql9gaimWhI6BedASxTiKaQ6ZQ=;
 b=DHW388T7mQqBh7d+UivFjY3AUzNgCu6iOH289YSQd4lurBHknCTbTBj+ooX5GcHoZtqld1CzsABtgduipXHA0pGN3CDcDNb6wZ4eBvp2xlBhMfxyhZjGLSk5XFaYXcx6t5ZMbdlzFmZCZeoQZ06b9ZrSpxWfFzK0FeOhFWT1kCDq9DclPHB9Vx955UMtcX7MxITfBio8qgKxG+xidWcbD/P6v25RoQqk379pK1cE7/d3tIKdn83OAShQgzztsq4yx7j30QdqDxZwRWUBwJHFnfEQpCXSHyxpwWcdAdmD3lul6Q+ln5jCCB8gXW3S5ob1+MsBtwEENqSIHQtYzhD4yA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 02:18:39 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 02:18:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Mar 2026 11:18:35 +0900
Message-Id: <DH6ECZ9ONECQ.3O0CF9230AN91@nvidia.com>
Subject: Re: [PATCH 6/8] gpu: nova-core: convert PDISP registers to kernel
 register macro
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
 <linux-doc@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260318-b4-nova-register-v1-0-22a358aa4c63@nvidia.com>
 <20260318-b4-nova-register-v1-6-22a358aa4c63@nvidia.com>
In-Reply-To: <20260318-b4-nova-register-v1-6-22a358aa4c63@nvidia.com>
X-ClientProxiedBy: TY4P301CA0072.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::19) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 898bd2b0-2dff-402f-91a8-08de855dd599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|10070799003|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info: EorSAiW/I1+F1QKGxaV55DAPyWrmD3p5YndHLk1gGumBdcVqkHmHjcD24bFPO0HMZ4XDigITFgLzbJzh9jjcdBq7BhfWzyDYNrwc6TqInH6avg1GiBr8PN1Bg7OP5bP1kO7FRfccopKx2VxAy6Kfb12LlxMIq7b3/usaZxwZXjNVlbx1F+CCkWSc8JhZ2tnivP+Vu7Xb/gwak+vFNZgxPKm18WUKVtTJgBVxSrAeTct09ocvjbUJNqvIG5i8jlzNZMBCxpdyXqyOiZY21otXrSwAbDHbTyF4V6nH9wGPYSQfoY8Yw3EGU6GAB97I7Sm+pLiY4K61FkFt4spvU3GV18//lR6Mhf5jxq3ElXjdetSE/F/MhxdFWAW62raCjABj2EQBBFrLQVV8jQOEAWx6T5ARpWRv+shhePj9Ii8IAv53ZQCtkSAhV7s2YIh3YGSXZfjCObgzp5Z7G90Vor0l58sqDmofh6Y0NI1j6ikMFyAzDtnblWDaDsYMVeYNzNluEs5zv7OdDu5w2DsQs3Sdw+mCvo1h3BEt+ArQnrGc9ohGCfNwFRmB4992iyKWh+rVFN9Tje3SWFJjT4BDlLUjIzj5GaYLDkpJdA1GX4/hgEqMqkzNTcoa4GjBU8iqs0P5xwLJZgMKz7VPgLZRbI6UGN/YGYc8NRSqfh2l/JfKTUfrTfjKWa76RDTTDK6ezn6kEIM7KGS9921vptP1+WcG3kpLO9vkjg2o49rT2ux5P50hj3xrCXZvICGjaVsnmOCScd5YffGZ7X3kgTsyDvvPUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2353.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(18002099003)(22082099003)(56012099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1o5dm1MOUlYUGlJbHBkbXA1SjlNZjlnZGpsRzVHZHRwL3M3dEZpY3RxSTU4?=
 =?utf-8?B?OHRsK1lEYmtUdjhGSVZWWE1hc2VJNXRpeWJDU3VSeExmVDYwQldNTzM5QU9L?=
 =?utf-8?B?dHFvcDZzVUFwNi9GQ3U0Umx2OVpFS29SZldwUjJkaVh1SWNKcXB3Tkd5NkdZ?=
 =?utf-8?B?TGJob2Y4VU5LdVBkaTJyMjAvM3FXYkkvMFU3LzlxZlNENGxkWGhCemZlSUEr?=
 =?utf-8?B?bjA2ZkZJZDYyNTR2bXdJZ2xyc1I2QUZLdTVtamtPcFl2QXVyc0lKcUhwUWx4?=
 =?utf-8?B?MTFMOHVZd3l2RHBkdG5nNVhWYSs1QjJFZUpuRjdMZTNMSSt3MXlRN3UvN0U2?=
 =?utf-8?B?d21VQjdVN0tPbXlLVDdlZFE3azU0YmVBU25RRUp5Q0VWWkk0SThCYXVXZmNK?=
 =?utf-8?B?ZHR4RG84NUQ3d2paUHoyNXp6bUw3czF2eDVUYUZNQVFEcnBmY216UENhbXNW?=
 =?utf-8?B?UWNwbjJrNTJWaWp5MEpKZm8yQzRwY1dNbVdrZGpQT0QxTCs1MkRkMnVmN1BX?=
 =?utf-8?B?cWN1NjVUS3NXdVRJNXBiSTJDOXc0TnNqRi90R0U2aTR4TlAzaE15VDk3S2tq?=
 =?utf-8?B?QkFIUTZhdjc1d3Y3WDlteGR4YVdMNTZwM3hTNkxjZ0sxOEJydW4vcXI2NnJu?=
 =?utf-8?B?bUJ5WFFUZ2tLZGkyb1JyRFhGL3ZPbk5HYm51eTlsaE9uQ3J6VHNocDNGYWpX?=
 =?utf-8?B?aW9zL1VqMzVuKzFPSzBXdTlmcjV0bC9TWklqVUpQUVZ3NjZ3VW16VTN5Skk1?=
 =?utf-8?B?WlJPb2wxeE1mUzJKL28rNjM4MlZBWGFWMEVoQVFzKzFyVHZOK0lBYm5UdEJJ?=
 =?utf-8?B?RWwwcUpCc096RlQydTRTQVZKOGt2ZVdINmIrUG9Vd3lvRkQza2JiZS8wN3Zt?=
 =?utf-8?B?L3Bwd0pldC9UZkdQR0VQQ2VrcVI3NmFqd1Z2aE5CVU5OZUxDWVJZWW91R2ZB?=
 =?utf-8?B?QTE1VmpMVjVLU1FWY2VSUlJ5ZDlMRG5MeVIzbjc2QXZUYmM1UUpia1l4ZU02?=
 =?utf-8?B?YlhIcWFFTzZaejZPaWprM01UL2Fjd1lWTkNJbXAwdkJ3eTBOdDlqOTZha2RV?=
 =?utf-8?B?NkZ0ZlVKYWJ6VTVBK0Q4cFNMKzRjZ2poVmd2SFk1RHZwSEI0Y1RZREhBSit0?=
 =?utf-8?B?My9xSHMzU1BTRkRubFVxVWM2b3FPQmVueXZqMkkwVkFOOWlMSnd3VWw4Zmw5?=
 =?utf-8?B?NjZQbzRFaWJ3QjdkY1lZd0Q3eld0czZ6OWFVY1I0a1hNWHEyK2wyWGROZTJy?=
 =?utf-8?B?eEhGbUlkOEkrWFJpcVlGVVNvZ2pPZksxL3hnaUtaQmFRSG9YR2J6VGdGN1Q2?=
 =?utf-8?B?UXpqMDhUUkVtaXZOVnZTb0xZTTY0YXJCMzFhVGg3bTRPdlJjRGVOa2Nla1hp?=
 =?utf-8?B?azFQeHBldXhRMWExcXBWbTFJaWpsbVo2bmlieGVFbXk3ZURlNE9HN2c4bEo3?=
 =?utf-8?B?OGViWTJuQ2dGajYwalN1dWE0NFN1K3EyUXdZQ2tYQ2RKWFp6WXZSMGs4b2g3?=
 =?utf-8?B?cW56aytYVnZBTlA5L3o5K3NDN1NmSlI3SGtEUHBkVmQ0MGNKQk02NWZQU1FB?=
 =?utf-8?B?OUtEZG9SUGk3V01ja094dkNQOTNVUlg1N2lUTkUrR1RtQ0h3U1pra1dWN0Fx?=
 =?utf-8?B?S2MzQTBzWmQ0REZaanFjUnA1M1kxdHFWNHpvTVplMGV6OGlNdHU1NENDdWt3?=
 =?utf-8?B?S01SMldPM1hHUnNxQnZQU3Y0Uk5XN0hqeWhqMWtrU2V2M1hFbjRITFZZdUdI?=
 =?utf-8?B?NnJrYVp6MDF2djVVR1I4K0drUGNTVUcwclJkSUhIYVp3MVovWlBGZjhVVzg5?=
 =?utf-8?B?b3ZheE9YUG4zSlRtRlR4Z09qVEg5M0NkaWRjNFNnUDk1TVlhbm9jaUVySjZt?=
 =?utf-8?B?eXA0RUdvUU9IYlFNbWtmclpEdWx5bkRkZnIrTE9HUWI3L3gySjMzTnY2ZU9R?=
 =?utf-8?B?dDB4OGg1RE5qSkdrdStQNHhiYVVQanFRRWpuNHVLbWcrRUZDKytrSDhQZG9v?=
 =?utf-8?B?Z3ZaUFAyaEVhbGQ1WThUUTVTb3JsZGxlYXhOMU9rLy9WWDZsMnFuc3VvcEFK?=
 =?utf-8?B?K2s4MVZ5N3ZxMGRaV1h1RkRlY3VsWmJreGlFNjhhMHFSbXF6SkZGQVBPMVgx?=
 =?utf-8?B?UmZocWo2S292alYvYnNTY1IrMlRsQVBuL3pwR3N2OEpJeExka3dQaXpYVmlY?=
 =?utf-8?B?SUo4L1M3cVM2UlNkdnRMUGJlOWs0T3g3OEovb3NPOVNnVnFnU2FYU0JYSzQy?=
 =?utf-8?B?ZWZrUGcxUjZPNWhsbnh6N2YrbjBBL0hpMUYxTmJlVmhVMi9LejJ1V2dCaklK?=
 =?utf-8?B?V3ZaRUh1MlM3dU9aV2hRNTJ6UnJWUE9vVVpycGJsSUY3c1lzdG00dURBYzlX?=
 =?utf-8?Q?5owqqu4bgosxMYZmkkeZRNKssch0smvYhZJER9iuJyV4b?=
X-MS-Exchange-AntiSpam-MessageData-1: B7D+y7URo6DQRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 898bd2b0-2dff-402f-91a8-08de855dd599
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:18:39.6964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCQRkQw77Xkuq2vRy5dJ6v5pF4ICxqK98UQARUBpfwkrD8n9NlK7ExSvwqMlSV805Auz4K3qUcxjGwDQu3pWNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
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

On Wed Mar 18, 2026 at 5:06 PM JST, Alexandre Courbot wrote:
> Convert all PDISP registers to use the kernel's register macro and
> update the code accordingly.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
