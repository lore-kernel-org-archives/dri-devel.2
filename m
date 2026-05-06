Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5037ACD3427
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 00:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B134310E217;
	Wed,  6 May 2026 00:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="eiZCOkCG";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA2010E217
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 00:47:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7ntsKKPlAj04q08/Nkh1/GkUp9MpM9CRtnF+/0lz1Hhp+L/D6Io06hgpNOz6kVXauXPUYOPNneA+MTVJFFZ+fIOMFuRjAYBOyR57AMAxU/cv+0z1Em2Cc12ZzslIzjcIhptNFUqPe5AxRd55aijK79JYJP0c6eHmiyya0DsIM812n9lEHs6QjXLsf4BZLvFea4Be8KJZxWBmXp7dSPUIz8wNsNvTDryovZ78v6fYI90eFYoWgRmuFZJ4IouB3lghjAAyKGaRPnkhA0tWQWKTg4UWeo+gA48MHpdI1mRAdUrryMuY1hQOodSuXpHd4jRSgCEltE1/QhuhnvO8X3dNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPHmiT5FWmdbxAwvh6a7PLH3Qkgwu6mILnR8W4ybM/Y=;
 b=jXZfgj3aF2xbJtpDvWHEpvKQJ0iV8NjFPmoD8key1B73vnM2S7lIc4550/Vfg/yGhgt0ysrbhwVJfEF3qHEAyJFB5niIxtV1jtCtrPZNAF89EWwP28MXEV0qQhSawmf155J0IRWZQAPZ6tH42qYqJoTnaJW3NRx/upugkJfG8+bT/e2N7ZbZOq2+sMo/GnZrOwqJTVHPZ9GMOn0c6VqKoMlg1VRQw5X6CBoLuO8Zbro06p5mdQjsqtMEfhsCa1p/FmXB5/TsD2racMuilS7+aW5XcPs7cDDxO+CzQhNVsWXoM+nUQffMobg14LBC6GPFjt9XBJMRJORfM50vcEzocw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPHmiT5FWmdbxAwvh6a7PLH3Qkgwu6mILnR8W4ybM/Y=;
 b=eiZCOkCGQqCzLA6Wz/S+7p1TNJNPxxQ2r2Ujm/o2Ci+wZK8e+nylszHen40HW73lD6Aafj0q57tZs3f5SX9BNtwG9Ho0wGQ7X0kidbkhPHWUrBWvkLy5BJtraXL1E4DVQVfb+D+DtvjuUJKJZRtt8PXPYbeUVBnzhFRAulTyuKJyzXfEo3aDEHn9mBftF96UHD50Fm/1Ed3zEkxd1qX4imwoKY8V9p+7n0WlDaOpd2YzoypvY+GAOUOLu1VjX19Q23i0wtpsdnvEOYxA9G73K3nwP9wDzCi59aS7OGBuLHeWfOGKpSG7g1SefPPKx1Se+zNzVAOpM3FbvxiKitWUng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 00:47:19 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.023; Wed, 6 May 2026
 00:47:19 +0000
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 May 2026 09:47:14 +0900
Message-Id: <DIB6H6HHFW29.816CGQFBOGWC@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Bjorn Roy Baron" <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
 "nova-gpu@lists.linux.dev" <nova-gpu@lists.linux.dev>, "Nikola Djukic"
 <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Edwin Peer"
 <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy Ritger"
 <ARitger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>, "Alexey
 Ivanov" <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "joel@joelfernandes.org" <joel@joelfernandes.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v12 04/22] gpu: nova-core: mm: Add support to use PRAMIN
 windows to write to VRAM
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-5-joelagnelf@nvidia.com>
 <DI8B0103X0HQ.7C99YLBMS2X5@nvidia.com>
 <DA4303E1-F49E-42BD-99B6-C7472C3BB12F@nvidia.com>
In-Reply-To: <DA4303E1-F49E-42BD-99B6-C7472C3BB12F@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0127.jpnprd01.prod.outlook.com
 (2603:1096:405:379::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|MN0PR12MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 1586a5ef-3004-4834-0fca-08deab09069c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|10070799003|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: AYW3JT56KpANaSPOXVxzb2YHNq7PMpDM3rQp5hPkuEIii29wqc6Lh+2HskFulrG07Xg4pHOrtAU6nLdM1H5ewb6DEhCP2rTmzQMAjFAmmsTFXMRzUOfJ2gf6RBHtT/ekq+HtQEs8i2p75EkWYiteitJf5mVwM8nc7pp6iz7stuioKuMN42Mvg7oYnZvVmlfwL01VXjjY1ISxXdvgxBdquYAmdHME8AfJ90/naRFPs+K6jcke0s1kpP/tWG1Nadb/h9MUZeygCrUVZPL6hmtPTou2Hck/E/1+78SXpKEkidCSB5aFUhqwYt3WYa90nIYGeA6RkNACGdNkV1Zrm0ROBjcBqUuKBAlaAui2F8O7BY0s5YSfvJKJxnJM/bWjX9e93phH2hfUYUjbT1t+LZw3octTios56Fu1BCYKjyIlD792MM8MXKhpxnfSz6ZXDk6pUAjihrd1bpqZE/8DbdMmaa3w0xn/CKLThQliVgwkSJIIxgaLVEb9AOcuDoMm0fb+yytkmpQ0a1Sltg32CmzM0QEvK5wG9M8pzg6MxA2C3eHsVaDr+NCAUEmsUfUTDoqFw2QdiP2K4wzbvv49sOoqditElUNeA7LdqTi6NFD+DGDb4eZvfmpFHPfZs/xO3Kw50dJtIJb1nDBTj7VD94YKx0shPNtHl+F77cIEXuq8PhMrQ3cRVEAwE5+Bb0dlGvMW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHhPK3R3aWxCMWtVQUR1eXV5UEFIUUE1TlF6dWxGOVJWeDBZRDlkYUl4ZFdG?=
 =?utf-8?B?K1dCRUtQUUx2dlFSdm1sNlhWbkNQejFNK1l2MWFrWG9lWTMzU2hPUWdaM1p0?=
 =?utf-8?B?SHgybXdSY2dydUhwRU42cWV1bllmWVd6bkZHbUNUNjlsaWRnMG5HbFdqT05q?=
 =?utf-8?B?Z2pmVWJRdXdUdzdCNWoxTS8vRm9PY0tWa2JXWC81ZjVZYkFkVFZNVjBiRjNU?=
 =?utf-8?B?WjlXWGxRelhLQU92MkVHVlZsajRhMDJCYlRSRWlhRFNUWjB6WDlWNktSd1BI?=
 =?utf-8?B?SG1GZ1grTkRqS3BrOElkdEFJaEFYeFFPZVo2WXN5WlVNQi9hOGdLMGI2aEdv?=
 =?utf-8?B?WWUvUGU1UUtqN29WTUhmOFI3eWlqaXBQNXlUdG85Z2d2K1Q3ZEUwdndiMnhI?=
 =?utf-8?B?dCtWTkNSeDZuOVRPRS9DaUcrdURUNTJDeEZOVmEzYnR0dXdqK1lBQVdpaXFP?=
 =?utf-8?B?TUV5VVdLVURRci9QK2NrU0ZGWUtrSlVpMVFxWnFTYXBtVnJreVIzUTM5bzRI?=
 =?utf-8?B?elcrcDRFWVhpZ3FTcTZpL1ZSVnd5ak5LTjJXZDVwQVNWZGtSMS9rSGpCQWM5?=
 =?utf-8?B?aGhoQU5ZaHZjQVBiUkVnRnVYQTk1ZUNMOEcyZ3VvdExVbFQrL2h1NjA4bi9n?=
 =?utf-8?B?QTNBSm5qZWIzWHJkTTAwOVVCb2E1eTc4NGcySUFMaXBrWDczTFoyZXNVbW1X?=
 =?utf-8?B?NHpJSjdPTWtPbWVaUXQyS3JwOGk1aWtHQWRpMDZQUWhNOFNlVU9QT015Um9v?=
 =?utf-8?B?ejdPeWRoNmtiSnhwR3dHUXc0cGUrdWVETG1qVzFOMGkreTFCTTBxSTlza052?=
 =?utf-8?B?MThmZ09IbWNielNnV2pEdGl4Z212WWg4SDNUanMzTmVWQUwrTWhCb2NkSjJG?=
 =?utf-8?B?SXlPMTRzVno5M0xSSDN4Wm41WTlxVnNNekJNTHNBSE55emRTNm9rR3pCZFV1?=
 =?utf-8?B?NHFoVGIzalVKQkFIeDBVT3g5SWR3QUxqa2lsVlRjUDRNOVgyUERYUTMyRW80?=
 =?utf-8?B?ZTZGUTVPMWU0SnA1ekxLNEJHM0FxbXlNM25sSHNnY3ZIVDQyUHJzM2llemJO?=
 =?utf-8?B?ZDVEUzh3ajJKemlxT25halZVcFlWWVpSYkh3SlVjT1l2TW1zVzNJTSt0UG1q?=
 =?utf-8?B?TlMwY2ZhN0diY0lyOXFFZnRkTXhZKzRRTUh6OHcwWngyZ1Ywa01YYWJZeWlo?=
 =?utf-8?B?aHAyZm9VMzZEckk4OEYyeGQ3c3R0SkRaTU5zekJ3YmJBTFY5OU1qMU5Xelo2?=
 =?utf-8?B?Z1NreDhoOWxlVmVwQ3VjSkxSczd4T0lzRmhzMFZBcUZObTdXM0M0Ky91ejVk?=
 =?utf-8?B?enF2UUlSWnBUQkhPTkd4ZWZCRmVQZzhrQUtxNFVkZmZVQkZlajBJQzFEb1E1?=
 =?utf-8?B?OUF3b0swV1FUdW04RU1uK1kyM1ZCb1BzQ2hwalNBQVBJazlsV0FDdFc1Zksv?=
 =?utf-8?B?WW41V1RlYzQ2VVBUbXVyNUd0eTJUVXg2VzEzUENKUjg3ZHJNN1ZHREY1VFkz?=
 =?utf-8?B?TkVIakRZbEgwR3VnOHZZUW14Y2dXTi9yaFNoeFV5alJFUHN4TU1VSWppUk16?=
 =?utf-8?B?YkJ1b213Ukl1SkJTSjRwdlV2ZlhEMmFEVHdmZVNaS0VPeGFET2ZZS0Rmc2F0?=
 =?utf-8?B?dUR2S2NqQjZiSHhtalo4ZUZuRmxvQmYrT1E5N3VqZ1ZpQm1WSDllTDl1NllX?=
 =?utf-8?B?cFpHTW92cEpha3dJTEU0c1VaQlFEQVZvWUJxbnFNcFRzdjlva0hmWTJSUWRU?=
 =?utf-8?B?VnFIejNBMjU4RVNJanF5eFRGTVRoY2JNY2Z0RnNLdWVVbUlMKzBTeklibi9z?=
 =?utf-8?B?T05VaEs4Wm8zaE5Ed0VNeTREK3VHQkJ4d0U5OG5LSzZPYVdtcWtRZkJQcURO?=
 =?utf-8?B?S3h6dW9FbHBxVGw5cGJHVWxoYW1aQVlzOHVOd1VOeUQ5aDF2bWRtdDBjQi92?=
 =?utf-8?B?eDhoL2lYOWpvMEVEY1dhWWN0Q29nS24wc0xwcndqRCtORlM5T09XSGNUZ1BC?=
 =?utf-8?B?UTQwSXpVNU14WWxZYytIRS9paFFQem9INmQrdGpyU0RFcS9mY3o0T3lpeEg1?=
 =?utf-8?B?OFd4Y29td3NqaUZKNWFOUFRFclZuSWRNeUFHeHZqanEyTng2K3JhUmxpems0?=
 =?utf-8?B?NmM4REwvYmpxQURPUTBIVEdyRUZNejhFQ0RLOTE0cTNGZ3N3d3U0TmlvcTdR?=
 =?utf-8?B?a0RhdEJ3Rlg4ZWV2SSt0YmpUdzNqQ2V1ZGsvVjdZaitDRUt4YjUzQkVSNCt1?=
 =?utf-8?B?UUlTQ0RiOWREMTJBTkZVL0RJZElWMU5LMGxIQWMwcndZYk1xWks0Z1I0YVRm?=
 =?utf-8?B?ekJKMmxQVFp0cTZaaGF1dEVHTHlhV1VBVVRseGUxeFJpdW5GeUZyeXlrblVC?=
 =?utf-8?Q?Au9RmSxoKtulHBWzIZB+JLq6U0qKhCv0dvzLFvyNZCs/7?=
X-MS-Exchange-AntiSpam-MessageData-1: tzjB6zbqFfx6ow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1586a5ef-3004-4834-0fca-08deab09069c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 00:47:18.9206 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRLQau0zzvJawhpMbGZPEP6ZrbutjXsSh2OU+wUYkXbtusswMlJwJ0ZfGC9qTf189ovnJFLMkN5whvtFEQxD9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
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

On Wed May 6, 2026 at 7:59 AM JST, Joel Fernandes wrote:
>
>
>> On May 2, 2026, at 11:42=E2=80=AFAM, Alexandre Courbot <acourbot@nvidia.=
com>
>
>>> +
>>> +/// PRAMIN aperture manager.
>>> +///
>>> +/// Call [`Pramin::get_window()`] to acquire exclusive PRAMIN access.
>>> +#[pin_data]
>>> +pub(crate) struct Pramin {
>>> +    bar: Arc<Devres<Bar0>>,
>>=20
>> The HRT series [1] will allow you to greatly simplify all this by
>> storing a `&'a Bar0` directly in this structure. It will most likely
>> land this cycle, so I think it's a good idea to proactively depend on
>> them. It should apply cleanly (modulo the Tyr patches IIRC, but you can
>> skip them if you don't build the driver) on top of `drm-rust-next` - on
>> top of which this should also be rebased anyway.
>>=20
>> [1] https://lore.kernel.org/all/20260427221155.2144848-1-dakr@kernel.org=
/
>>=20
>
> I tried to apply it but had a lot of conflict.
>
> Danilo, do you have a tree of these patches somewhere that applies on drm=
-rust-next?

I have a tree here, it should build fine as long as Tyr is not enabled:

https://github.com/Gnurou/linux/tree/drm-rust-next-hrt
