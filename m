Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39236C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:23:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9F910E1FE;
	Mon, 10 Aug 2026 14:23:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="Bje4ZpRy";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022133.outbound.protection.outlook.com [52.101.96.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E62DE10E1FE
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:23:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vxl5kdU1+eHDANKhQA3tAFWbkkBVuffpz9ekawUGJIo7JJO+iUciNriQ1m/Q55DZapHXkEDrgwV0recsJzQrze9N6eO+4eUi6kW4e1i+iNT+nhc4SH/bobpEfuMSpwlt7wtpuo4K61nim9sjsjM1wJYgjxGV3wmzldu3uFqTGzQIsIdQeZlYYI0+p+TVs8Dx7r9Q8a6gUVPmRN0D+HXo8cniQJHRfz2J0kDG/jtUjKBdeZLaE5nGMV2GU3sAkymMBGrZDYWvx+SljW3gtdi9J7syQtn07RfSO7hwLgjiaVPxUgdl+WOgftXYrVCTYoV1Cib9LW71bA2Lm0WKudEajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boKxwboaausqlH7kdv7FqQ1L7ZKREFU5q/YP6FpOeBk=;
 b=SnAsD2hzadZmYy9l4Aioz/SZmHUNaZH9G9zax0O5h+mvki1y1t+9SNJQEmr0trWsST++LsjVlzAHqPWcuMXsNr+GW2kGGN9/h1Fz6NxTnHFXadQMvbLR+hhcd40QkA37vBrVgwODL4Au0GZr84Nc+6UJx/0TOxEtbfL2ZbFPnbKAjLAkImY7DlUe2DiyINAutsJVb9WAI9fMkBWetZYhe6O9xNn2mRtUNFrQcC0oVt8x696X4ErtiJF145GyBcrFHenhuPpxRCV+G59Bc0GYo2JaInpjOpI1E9FARtmxIopfNBuIgVwBz0XcGZ0l7mHVYySoO+oeISAXht+TjuUpbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boKxwboaausqlH7kdv7FqQ1L7ZKREFU5q/YP6FpOeBk=;
 b=Bje4ZpRyRoD7oPV5VuuZ72PnGclcttouAzcvqZcIegOgLuLYPL0+2RGtF2n/Jrhycfv66wHORcOW1ssgHAy9b9IsXySqK5Rnfh8VdGSzjnP6RFGUGGlfG9+tQVU643DTsub5pjqhnb/GEgwPY7HLmOGaD/N50i5x00V9EyJxDQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB2356.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 14:23:39 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 14:23:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Aug 2026 15:23:37 +0100
Message-Id: <DKLBYJYSXN8J.2HGUS0KVWTZP@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 01/12] rust: num: use const_assert! in Bounded
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>
X-Mailer: aerc 0.21.0
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-1-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-1-65a00b3c7309@nvidia.com>
X-ClientProxiedBy: LO4P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::21) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB2356:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a1448c9-161e-4d91-07d8-08def6eaf896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|10070799003|23010399003|22082099003|18002099003|921020|4143699003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: bYlg85Wja960gVp+JjzI5Bfq+QMxx2V+qoQzWsdWSkPbIDB8Y4JtmueQakZOLzNdwdTgAyH/6wCbIlLKKcsXRazFIbTXgqU75J4G3wRL4FT/EZkW0rHN1yxv+qYHZAOflmYNj33jp43pF9pjk16CdHjW8L1NX2j9csTOAE/wOTd/nymMq4URuVhD1MEJN3JO7UGfSUpv96lxDMp3K7WmoV9D8+ilOhs51njowMyUXnVjUUepG4PjsH1J+MJB9G8YTKlV4qmoji1SXgyKP5EWKNFDQiMaWY+N2Sh0i2AE9V+t2uK+3EXQCN1IatreVxtfAt9vSUMvDtNV9Q5tOVi+Gp+w2jFqw6YJqOtQ85IYRnMApmRfKQNDlJ9QWIG0hDmnkcG46bzqNqhCFuTYo3F2SR+BbjZESCOA/WM5uKwnFkug/kiKvz3OESfDuhdus2IxuQ817AQyONz7T6E/nzDuangF/eipQMNA0D91Lz32kEzIeXHxXa35lhkmHcxUe3ihZQ1soYKFrQEKa4K37p3Gw8ZtC4LzoYub8/Ag4LKJ+Bi0GoNmUVUUoirQdYmZ/pYsvIqUwvJyJVUL9Vg0zwAAmyaNUp07CS6TjDUZLOx0I00lhG4XlUPY6rWuA4sOMyQ9KeEmWGVgByCJWWOjLkxVALzgxsXOMq8UN8SpUioKBHf6zDYeIaSCnLTD/K8FPaTiU9Jktf1v7UO2E5ReN6vwpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(23010399003)(22082099003)(18002099003)(921020)(4143699003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0s0YUhnYk9nYWtKSXpOeEtGa21yOGxQUEpRcFNrYWlZQmticjIyNkErb2lH?=
 =?utf-8?B?WkNZN1JZRFJuMjBSdlVGamRZeWxzbkRud3VobS9UN2dCWU0xK1dDSDdDeWUr?=
 =?utf-8?B?ekNHeUFzbW9NTHVUbEJlbVdBNTFGbk1ncW82R1FJbDJ6M0xva2RXcW5WWEFC?=
 =?utf-8?B?VHJvMVJQR2xQbUNZS3lncWljZUZPdUlsejl1MWY0MHMwN0ZvMEdON3RkVW5I?=
 =?utf-8?B?bmNnRGpYY002QVhwQStUNEl5NkUvOXBDTzdaR3FrcHduZ01yWUQ1UUhMYlV0?=
 =?utf-8?B?V00rbFNIc2pGV3B6d2RKdGFvcHF1REtndit4Kzcwb3pSTVdldW9wWmpVbEJ0?=
 =?utf-8?B?b01QR0hKUURCV1NYRkdGK3JSQ0tRUzVDMzBWZ1dnOGlWSk4zRWFlNlJ0emgw?=
 =?utf-8?B?V1RWR09rTXF5Qll4Z3FweVVwbDRrakZoSDVIcEd1VmlpS0tzZjZMTmNEUVdh?=
 =?utf-8?B?dE9UTm5oVWlRbWppWnFPSDY3cjlGRXFQT24zN0YvNzhYZ2Y4RXFLdndvVXVu?=
 =?utf-8?B?YjVLem1IRU5jZUljR00zbXV5N21GZmkvVFY1VUhlQTczQjRsTXRabTVZbmZX?=
 =?utf-8?B?S1VSQVVHNUEwSXh3eVN6SEFFUWF6SVNBeDdTbnBudVp3RkthK1h2dVExM3JW?=
 =?utf-8?B?RWlBeFF0Q1ZuTjRpTUhmRlR1Y2ZmUUtFdndRS3BHVlZRTzFERFdEVEtzazBa?=
 =?utf-8?B?Z2tQWXEyUW11c3lMeFZaME5GT0lMV3hsNzE5RFUxK0ttcDJiVWw3OHI0VzZU?=
 =?utf-8?B?U0lHOEZSUkFjNk9JMTh1MC9OMkR2NHdKakJNai9RbzRNT3R3VUZSMHdtZ2Y3?=
 =?utf-8?B?Zk94RmJUcldoT0ViRTk1WlBnUlloK09ybjRRMUdlUTZMOXBXTkkxSGlHbzBW?=
 =?utf-8?B?TlBOOGdrUzFocktNRG8yQ2tpVFFmR3dORkpGdkRKVDlzTmMwY0ZoNmxGa1dL?=
 =?utf-8?B?aFYrQUwrVHFTMlBHTkVTam5YRzVtR1NCbkpzN25oUkkxZTlmdXcvNVpFeVZN?=
 =?utf-8?B?dXc2Vm9LVmdYQUNDdFZXc2NPd3ZFbmFlV1QvZGFvYzlqUkNFTzZXelZWRjBB?=
 =?utf-8?B?Zk1kN2xEYjBhVGdhRlRyZVZJSHlkbjlINDNCL20xZGxWV0Z2QlRGZXhjVlJH?=
 =?utf-8?B?WC9xQzlzREZLNjN5VEtsSXpKSHVjSmxxZzRiN1ZCWHVrOXNlYVN4UzRxS2o5?=
 =?utf-8?B?QXJhNy9HaUxWM0FrUUhmZDNWN0VzZnU4cmRtbGlIeWNLdEVQSStrSVdWVkxy?=
 =?utf-8?B?Z2FFWWxMRzhSNSs1OUFCRGRYdlpRMWdieDdSRjhRTlMxbW9EdWpTYkVZSmtL?=
 =?utf-8?B?UWxXZmlGZ0hEUGdRVzg3VE5hdVEzSCtxZFo5YlVJTHhycnlINHhGd1lFMFhU?=
 =?utf-8?B?emozdGxTN3hQQ0orNUFKOVQrd3Y0VjBTeVFRL2I3dXN5NnU1SnBMNUc1UndU?=
 =?utf-8?B?djJML1htdW5hd1d3blBnSVo2bEhWMVB2c29pMDNzdlVJTGZyMlRwQWVidzRa?=
 =?utf-8?B?SDc1aStRSUNCNmtrZGszT2hXQzNuS1IxTzdoTXczUUlTb3NEOTZnTlZTcitm?=
 =?utf-8?B?a09TRkNpWkIyakE3cldJZXRkY0tsUjU0Y3VvQ1Vpamt6YkFWYktFSSt4eGNp?=
 =?utf-8?B?V3NsMkJHOFY0RVRzazZYaWd1SVFEU3pjaFlCTGFBdjVYaCtQSDdaRTVLeTlX?=
 =?utf-8?B?cUVVck5OaTJMTGdHZVdpVTA3MVUvcWRuTGxlV2NiVmZvZUtteFJWY3R6R2pZ?=
 =?utf-8?B?eGxhbnF1WS8wSjd2b3R1ckdIRUVYWVlwU3RzQkJnOHB6M1p5NW0wc0p1R3ps?=
 =?utf-8?B?RFRPNzI0Qk53TFJKOGZxVmc2M3RlZ2RCQUpNSmFieXY4TWJUbUViRVRxYVRj?=
 =?utf-8?B?bXJhNmx2anVMdFB2VE1kcXZmUk9DaHJ3RjI4eG4wVFhYNHBWeVhyWmQxN1Bh?=
 =?utf-8?B?TlI4eDFqamc1dTIwdE1EaVQwcmszQ0FlRjFWeldaNWM3Y0hLeDBkeHJOQVhU?=
 =?utf-8?B?STB6SGIyMzVNL3dzYnJSK1JNNjA4a09MN20raGhvRHZ5ODBzMnlaL240K2hQ?=
 =?utf-8?B?QVQ2M3FLUktIVVlEYy9Gck9rbWhSeENUUklEUUpWb01XbUJBVnd1MUZEeVFa?=
 =?utf-8?B?T3k5NGlraXBSaXdxRk1EenhhVWlSNW5zVmVzejBmRDM2VFE5Wm45cFppWXVi?=
 =?utf-8?B?U21ON3FNbVJIc2c1emFSdWdKTDFtalJWREZ5NnNLVktUaXp5L3JVcElrb2Ex?=
 =?utf-8?B?YWRxV3FXTnI0dE11M0RmY1VGckl3RnRkUG1hdXNQZVAzOEZkMVV4Y1BjL3FL?=
 =?utf-8?B?Yjc5T3p6a0VzdktsRUNZdW5Eb3p5OVVCQ3A1QjdtSmhlWFBGZ1VxQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1448c9-161e-4d91-07d8-08def6eaf896
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 14:23:38.8719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QlfM1t1BHuRmumiIUat7UcPeBl8HtoQQ4TIe1+ePu1JiCVuQj2vK/6855NKPrmxYhG9LC9/K8cfAHOaDh/LtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2356
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

On Mon Aug 10, 2026 at 2:55 PM BST, Eliot Courtney wrote:
> Convert the const-block asserts in bounded.rs to const_assert!,
> matching the rest of the file.
>=20
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/num/bounded.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

