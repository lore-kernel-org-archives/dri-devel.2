Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338D010F6FBF
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB5B10E229;
	Wed,  1 Apr 2026 15:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="UjiOx/wZ";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022119.outbound.protection.outlook.com [52.101.96.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6776D10ECAB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 15:35:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qKy/UZIlevK5d34LiU8l3hYJEC2D70rkCwlEtcXI0Zecjg9Bq3OPIrIJXXrwFgvmxtxj/DbUaCyfZsMuue3H5UQ2X1FSdAUnkdMmc+oc7yzgzlfEwpe2S5a/AEh+XxzZOyjRerJOTqxP6vium5ViCRmiNXE1/JRohL6A9wMMoC5/eJh5QjB/xfYG8/qZlHDYIdjGsQHVIj6WmODHo6QtKlJ/wW9NnMF7rBvU5PRuJlAocEPJMQtLmGYq+W7iKqEKRPjK4fjxHbiNg7Z5v0NoU1JnKph8aGTzj+/H1ki7N1eW553ehVhFdoQME7lmjKKMymbIsVT8QvQjTfyk6WwiUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrK+S58rm32taAfNqC/iS3SYmJfr2W9S/GJB6CE7HlI=;
 b=xleT+VA89Z9dgYVkvqc4qITtupxLpa35NIWLthwC2+P9JygbB37xbgr1zWebAocCpk6Up0Jz7M10HAW9ldG23PHc1gN8SXvqBq80sFQaFjAvEkxEYDZO517C6TFTaZUEEkpodyqUYWhH70tNd5eioBIT59wTof4XB6hlW4yiq6UJszqLlWzUFog7RFowoj2UB44QoDjEboAxL9zVXnRkUZEWPRv5Sejn7hoo2OvtRu04sWdKpsyaR/VbirbIsW8zr1D5bHFWAOto649dXmSWoZbXtSBFvrhw4x9VxZ4qEC52+13sk5DlARKII33AoapRfiXMC0SMo6GtSic+QCzbYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrK+S58rm32taAfNqC/iS3SYmJfr2W9S/GJB6CE7HlI=;
 b=UjiOx/wZaPIjV8cy/fMN+rgqYGRERQMrS+A1RAdB82c9Z5n/OEx3wQjVNE1JggQJWbiY7BGh4MQiMkD+gWXTXtYfF3+x4BQFZiI16gHlULBWm+sAa4X8R3z/n/FC5535k7p0kVDcGi5FpmD88PlhZse1QBmc0JBC431qjDFub/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWXP265MB2198.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 15:35:17 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 15:35:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Apr 2026 16:35:10 +0100
Message-Id: <DHHXFZ05SBVH.2MK50Q9PMTVDZ@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Lyude
 Paul" <lyude@redhat.com>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: bitfield: fix broken Default
 implementation
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260401-fix-bitfield-v2-1-2fa68c98114a@nvidia.com>
 <DHHJ82YDW7FP.2ZFKZUQUZZ2H7@nvidia.com>
In-Reply-To: <DHHJ82YDW7FP.2ZFKZUQUZZ2H7@nvidia.com>
X-ClientProxiedBy: LO4P123CA0205.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::12) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWXP265MB2198:EE_
X-MS-Office365-Filtering-Correlation-Id: d4eeb3b1-e6a2-430a-982b-08de90044661
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|10070799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: SEtPKbuJwwMEAckjOmyq/uNRxUt6SAp/6osnlDK1POSJrU4oxA4h3VFuW58IyUvpKprhdMvW+GcWbcTlukXWJ3cCr7IpE6rOIxhNIJ82zAWhjEa46KecVY4DCuekmpRyDmI6n4xUP+gY44ZXz3Zy7YqBtnbdvcNzsDlBfUF5Z2qCygni8tGwRAulN7t628+Z5GXYUfDQTjD3Apl2bEu22tO7Ztx0ZcB1uheA0TYQVuQ8/Wiz9kHetWJy7Id7/fUBd4YnYfL89mwqwEM9L1rHYYOmaddGkC8eIGlVv1L8W1dvhj8hMeaPLj78Pp/+rjuPRr/uMrF0dmfk6ivpTqQAogneVizobWTj1Cr0Q+LpkdMh5hG54r3uOb9xcjXNAfeNKuFdcAAIQTtxlgxcfVONGG8+sDq63ax4ulhZAE3yseQtDk1qqOmfPwdpFTLdyKkVMWyAEqBx72B8d07Rj3BPwm2KWcAONP8iOXgDKwWB43+wShzVORguBgS4pY0FxiUyI3ydeghHHza9AnXtyPxNwLBOMh7BIjZq9k+lhnDKMjrhFen0HWAT1R3ugXb3Lehc2FfwE1JSTuCWH0UvxDNltusoaSEcJLq0LSCzdSv0Rp/S3/3GMnjMJAvUxioteJKJ0/dD9t3BoH5CKyS/mHxTA8SR6/hH3biH6T+A7tOsw+IY/2VClbTpZM6NTFGAyUepoZjL/N0i1uvti9ByOzLl+xSHsEtWohdFJpTBE1Og7sA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUw4MFVJWDgrMlNjajVWSE9XaDNJSG1kQ241b016cEhMK3RiUlVlQWhPckNN?=
 =?utf-8?B?SVl5MWZPNUtsb0lYK1ZLRjROL21lUUhKM2sxTDRDWDVLTmljTlIyeXRtWENL?=
 =?utf-8?B?cWY2cHIrNnVjUHFEdXJzRlRONmZRLzBKWG44cUxLV1NEVCs5a25aSW1pSUd6?=
 =?utf-8?B?SFpjQWtla0VyaVhoUEhkdk8yazF0aGRSeERJWVdEY0paYm5ZRkpvREhIaXNE?=
 =?utf-8?B?TVI5WFFJQjJGWHI0cDIzby82bVJGUUFLSVBlTmhRcEVtUjJDNVp2azIyaXc1?=
 =?utf-8?B?aWljU2FtY0RXazdLYUYrV0JZeTJ3clh3bSt3TVFQb1lnV0RKTFRJRHF1d2Zu?=
 =?utf-8?B?ck1pZ1FqakhNdW5mMVlURjVhTnNva1M0NElZa3RoZDBVZ1YvUDIxSXBNMWh5?=
 =?utf-8?B?UDJoUndGNnJtTTd2SEpOYm1GYTRJbUVYZDQwSEp1MUdlKzBFNEtLQmM5dDI1?=
 =?utf-8?B?eFBoUXNTck1pUDdWM0JXLzkrNzZlMFFsUEw4dkhUNnhDQlhDb1hpQzhldjNX?=
 =?utf-8?B?T25RQk1nOUZNaDRBU01SV0Zib0tYWWNZQ1JzWEtlYjc5WEJqL3Q0Yk45cUFw?=
 =?utf-8?B?MmFGMDdPdVYwT3F2dUN4L1RWZURkb1Rwd08wRTlnOVA5Q1JQMk5zK3ZSV0ln?=
 =?utf-8?B?MFVRSVQxMHVLRkh6ejdQdktnbTdSOWZ0SGd5bUpRcXUyY3BaOURyMTQ3SDZW?=
 =?utf-8?B?R0llQWdHSHlxMjFvMFJzaDNRSWlEeTArSnNodWhHNXlzd1R1MW1ZSHo4MGJo?=
 =?utf-8?B?Vm9IZ1RGZjVoald1bElTZzZLbEl5UDBZemt0QnZ1bCtmaldGanJWTCtJcXBl?=
 =?utf-8?B?cWhNa3pkODJscnp3YlVGcTh3RHZlSWNBVWJxNmNLNHJaeDlXcmVhRXRXcGdK?=
 =?utf-8?B?YTRuOEJxUUZRT0VNb3NhSmpWTGY2N3JkVWRkRTlXNTFBK01PbkJPK1JZeHZo?=
 =?utf-8?B?UlVHM24xb0FUaTRxS0o4eXlEb1JXTnhoM0tId3B4amx3YTJqUkdBVnJZRHVo?=
 =?utf-8?B?SUN2a1VZcllqcVNsNlAxcmN3SmRITzhwOThxOUlRMk9oamtlVG12SGw4c0dN?=
 =?utf-8?B?ZnRrdTdTb0tTakdtdkxQWm9lblRXT3dzRWc1NjA4NGRDV2xLTEEzOTVvNk56?=
 =?utf-8?B?RFhmeUNQZVNXdVN6Z1pRUE9TTlIvVGp2QzQwZU5LRzZzQ1U1T3MwUHJoc0Vj?=
 =?utf-8?B?SnhwSDZJYUV5TlBXN1VBSHNIU3RDVWMyUysva0MwWW1mMFRXMEdiVEErc2x5?=
 =?utf-8?B?ZmlXay9qQ1FnMGZlYnR1Y1ZyV0RwaFhWZDlyMDdIK3oyMkhhTnozKzg1N2ZU?=
 =?utf-8?B?R21nY05TbUZQZ05JejM1ZlZRdEFQcHRSSkM0MnRWNktaVm1ncXN6L3dITis0?=
 =?utf-8?B?Z09STWFteUsvL2JERjcrQm54eXNKdUVGejc4Q3cvdkJ5dTJhOTJRUDQrclA0?=
 =?utf-8?B?azlDNEExMDlHZ2dienVZc0NOcENheU5MUzltSVpKWU9rTmtxYkJqQzZZd0tO?=
 =?utf-8?B?WUNFN1VWd3FkRVl5Q1BsNmFtOXlJa0o0NStxVEpzZ0tGUS9IanEwQkU0aHVD?=
 =?utf-8?B?MHhwMUNyRzFwUzBtYlRVTUVYSHJSeFhxa2dDNHAzZUI0SlBpTExjUXpiY2FR?=
 =?utf-8?B?V28wMUlVWXdYejRDS2plUlg2T0J1ZUR6ZTlUYlBhUkp6N1ZDTGJPVlVwWEww?=
 =?utf-8?B?ZW1sL2dBTEZMb0Rrdk9qMkVkeVZhdzFYMnU3SFYzaGc1SkUrSjM2L3Y0b012?=
 =?utf-8?B?VFlGMXpXYlQ1dDNnU291WFhEMWduTktwOFZJQ1FZRXQ0TzZROU5DWmg5MHVF?=
 =?utf-8?B?MS9wWVhpV0pOeDhqc0RCOWViWVV2bVRnazdZd0Y2TFFDVElpM0toL0dBSFFu?=
 =?utf-8?B?WjVWSU1SSU5wZE8rYTZ0UjgxOVpBUjNYWkxjbURJN1pPVHkwSU42TW95SUVQ?=
 =?utf-8?B?OENVUWNkaFpYVlBVN0NQU3FFYWs0K1NCUlFjblNiSEVFQys0WmdtVjNOOXM5?=
 =?utf-8?B?cGEzWHdnclNZWUgyVSt1K0YxbTNibEJMa1orcFB1d2VYK3RRWk03N1hiNHFB?=
 =?utf-8?B?ZHZ4ZUlZTlIyODBwb1BSYkl0TzBTZSs4N3k5WHYvWWNMd2ZHWW9FR29LTmk4?=
 =?utf-8?B?MmVFa2lHVGJiRFNLSkVYYXhmNnlYMmQxQllCRTNvTlhTeVV0MHBGMk5xYWJi?=
 =?utf-8?B?UkhLOUtIT0drMkVyVTVGU1lCdUdIZW1OeFF4U2RET094NTk2UnMvRnY2VUU1?=
 =?utf-8?B?aDZYM1lZK0JxRkVST0NwZ1pJM3BDb09tNCtOMmJvaFlianpKbnF1RXVvMUNQ?=
 =?utf-8?B?eXRVSUZoeHRIK3F4Z3VlNVZ2TzlzWEFUdm9kMjlyTVdGY2xTSFNxQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d4eeb3b1-e6a2-430a-982b-08de90044661
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 15:35:17.1020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYL8VqrbaLmwk3TEKed6VnAD3xkcy3JC3dlcrX5cGm9Biz722Q/WdEEqRdVJyxa3Q1zYurh3s0Y02puaxmlXpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2198
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

On Wed Apr 1, 2026 at 5:26 AM BST, Alexandre Courbot wrote:
> On Wed Apr 1, 2026 at 10:42 AM JST, Eliot Courtney wrote:
>> The current implementation does not actually set the default values for
>> the fields in the bitfield.
>>
>> Fixes: 3fa145bef533 ("gpu: nova-core: register: generate correct `Defaul=
t` implementation")
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>
> Don't forget to collect the tags you received on v1 (I use b4 which will
> do it anyway so no biggie, but not everybody does).
>
>> ---
>> It doesn't actually set the default values for each field. I know that
>> bitfields are being moved soon, so maybe this fix is unnecessary but I
>> saw it and it's a simple fix.
>
> Fixing it is the correct course imho - the common bitfield macro still
> needs to undergo extensive review, and we might hit some hard-to-debug
> issue in Nova because of this bug. I'll apply it as soon as
> drm-rust-next reopens, thanks!

This could go via drm-rust-fixes?

Best,
Gary
