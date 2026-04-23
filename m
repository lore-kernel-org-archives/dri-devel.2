Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E61BFC0342
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 15:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFF4110F19E;
	Thu, 23 Apr 2026 15:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="GdLTWcI8";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022100.outbound.protection.outlook.com [52.101.101.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 534BF10E352
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 15:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXI2ABZx+18xkftNaUyxyfCKpE8WETXIceEh3eJxFoK7Bi37ACfiUUvGC6nM/E0aunVteJjWtEtEEK1tuL/xMGrTi20FkqM3CgvH3tm8AgnSR8JuFgxz4WUvS7C75X92EBgJU+ayfxxgwIz2kBuIDUbedztzCBDP7kqQ3o2ikh4VWRxb5hJgOESv7QY9f4zGGipUqA63caB7MD4LeaZ5yVHDT/UT8SUogLhkJJSFuNqp5Ah6toDUMHQ6VEft4IQPVjRS2i74nGcrXHDioBEJ/QR4GADm5Urge4lVwZcign4fNhr3LTGj3dwS03ZULiwikoTbHs6a5lEDxo/poAZ3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5hNyd2xw5rDpUjA8xSAcZOXq2fvmdD/YxFxGtBoDHM=;
 b=Ss5sJdNZr63e+a/R1avq8G52CHcF0GzQZIF/6w9bNmQlMwNkoxQOlNvIdaf1+F6p493U1Catfw+QSteEALVW3kam6+nv3gZWbRBT/7ZGjds1wqz/DGO8GCgUcbpv0WQ+djZh3xFJr+L0WMGLPScBBTkZ4kpa1N4jtsX6bp/doOKfqtVe6VdccZ6sSuZ4XVO3U0XZJxrbwi0qzaIRXoC/UyqwJgFdF5JHikyVVQ/pF7qgYm2L8w4QT7tEQidRfU+lcJ3w9jZZX9/n+d/I0dvkJlgLCz98m+GBqIXNRYm/fGbSbbp9p62rfgd5u05WsE49PV8eIoMJUeB8dO+Cc8wkXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5hNyd2xw5rDpUjA8xSAcZOXq2fvmdD/YxFxGtBoDHM=;
 b=GdLTWcI8ABOQFOIH3ANEl850ox4KhfpEkCEXEBVitT0cdVqeGdLch5aIyXcskXwYII80vselPVK+OC94rqDJgP+kas2oDmLrl7+VvoJ4Ydc5yU2iDvqlzpTHYURKbQJaxOW5shJC36ehVrh50h4IVwxzZSQE662usJGRTLRUFTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by LO0P265MB7270.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:364::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Thu, 23 Apr
 2026 15:04:12 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 15:04:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Apr 2026 16:04:11 +0100
Message-Id: <DI0MK8FIRCQJ.EQJ2JNX5XBNV@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: simplify and_then with condition to filter
X-Mailer: aerc 0.21.0
References: <20260423-fix-filter-v1-1-b3b197c65daf@nvidia.com>
In-Reply-To: <20260423-fix-filter-v1-1-b3b197c65daf@nvidia.com>
X-ClientProxiedBy: LNXP265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::26) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|LO0P265MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: bfea0db3-501b-4727-2fb8-08dea1499443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|10070799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: ZZTYaY3JMT/ENm/3QRRhfnEUMa6CYx004VCfHvG8g41EnGSjC3biMxRoEF6g62HcTDIQ77rSjIylxH23XPQ3vNSwKJs9119hkGT39/oeKh1AvBkXDrcJ+ECaxhF4Ejv4rOdu8BqUok7ejy2OhLFKTgDrtIPwP9R9ohMdAQgWwQivKK+oAOfDTF1LLRguLk9YsO8bSZYx1Z0H4HEgUnfe40QB+nI83PP5ZqelWn16u3Ak/I9t/IuWO0T9xBknkpCZW4jGmb8YNvxQ3VccRyVkXfZbYxrThMi3pRMLQjeCTQgvYmSkhu0qT2fdypcj4PeAb+KvWB2AzNezDW9kGEJ8DSQvUDlP43rduerYmC+/v34Lw3WD3l+SRPTdwuU/hFqPiOxKzECQbkOHr1vAo8B2fyEfySsERiwtLi5PAUOiquwwpWEg6QHulsRnf2Dv9yV6AfajmVVFYzE1D5gBmRYYyHAO8844aEHZZfDHoxXeqN81Ef2BWrqHDfD8aiL3jv0hV7eM3rIoTjysCtqMdY9zK87Bf7sAushE0T/ZD9J7GjfTdWlMVBmGQVTnDRHkUyjuMw/J7iCOHT+n3lVc4na9408ZEYugGkDOtFs7iW+F4Nzo5hoDlC1yNHgvw+1O/Nm6jrQjoQYNo6IOUu/CBNK1Soic+TzIOIKB7hxPGs8kqMB+O1U7ZqRrqPhKk0g1m5vjh7BAl/nzq+mHbDYksCcpUj5LMkVJUTTbl77++RyQ+4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlNDaVVCNVBLTk9QZHVDUmlXUFcrV050a3V6dXorZTd2RTFVYjZFRTRlMU1T?=
 =?utf-8?B?aDlyMVFnNWZJSGRsN25RUE5Gby9pdm0wOHVYV2grb09BMVc1UDRWQVMwM2I4?=
 =?utf-8?B?bmwrTUI0WHdDMEpJWHZFZlBXd0F4bG5rOEZscjZTNlppaTF6dXBldE9XaDNI?=
 =?utf-8?B?UU00NjUzaG5Pb1hWY295ZTFYcEd0SGhDaFlmUUJvR1NkTmJ6Qjk4MWZEVngw?=
 =?utf-8?B?Y0N5T0JScnMvaVRSb2szaVJlY2V5QVgwKzFnNDdVRm1nUEE3UXErR0Viencx?=
 =?utf-8?B?RTBDb3Vzdm93L1d6ZDJUREpXZDVjSjEyckg5NFNXclZxUGM2aWl1WTJKemJo?=
 =?utf-8?B?SWNQeGh0ODU1aWpLMU84eWo3YmF6L2piOCtQa3dxZ21DbldKYzFIblV1TnJV?=
 =?utf-8?B?eEI5TEx2ZHhYVDRSS1VYTEc5dll3VDBhOFUyY3ZaS1JjZ1JUTTk3ZkE1dXRC?=
 =?utf-8?B?SW03QkREL3V5bnpKTjNram52d09Sb3UzbkRjdjVIZklyNjM0ZE1ZMkpMQ1g5?=
 =?utf-8?B?SFNENmRCMnVZTE5DbUJCeDlDSGYrbFdMclh2NHIrVm01b0hIMGJwMUZaTk0y?=
 =?utf-8?B?WkJWZTlOSHhNVlV4MllmM3JGbW1EY3BDLzIrOS9TN2xkVzRSVll4ZFpvVWJS?=
 =?utf-8?B?UTlNbTlSOUJmR2VqWGRtN0JPeHJ2L3NKQld1MUsyQk96dTYzV2dnVDVtc2RI?=
 =?utf-8?B?ZzZQdDFaazVUVDN4TzdXc29VVytMbE1hSHVwQUdJUnROeXVEbzVhNzloVWVE?=
 =?utf-8?B?ZW9CNWM0dWxYY2pnNTZvSy9XSXhCNkxkVS9mbVRPS1pwRmEyR1h0d1h2UVpj?=
 =?utf-8?B?bW8vMElwZ2loVityUEdQaEtHVm5wemN5WEpoYU9LdldJNkE3dHhzWkdOdXQ3?=
 =?utf-8?B?Nm1VajBVNldZZ3FFWm5aUlJyYzN4RUFxa1ArRnEwNnY1a21VTUdvbHhTZG03?=
 =?utf-8?B?T3ZOVlBXM0NkaXp3eXRxK3kreEE5cnhMdHdZQmRnQ3FnTm9jUFdwdHNxWVdC?=
 =?utf-8?B?cmhVWWQ4R2lCYnNRTUtZbWJxTVVIWjV5REorMjhCNHpWR1lveU1sREttRElv?=
 =?utf-8?B?dFdoQXRML3ZvYmwrUVZxeGlPTk5ueTBWbTVteVpzV3pKVGo4VmlSU2Iyb3Ix?=
 =?utf-8?B?c3YrVUE5bzFIVk5zSHNjTG16NzNkWDgvbWxrUnIvREVzN3JJS1V2NTg2TDJJ?=
 =?utf-8?B?L1RWV0plaS9uWDg1SXVhcWZjRWVHOXpMdXBnMk5QbEdsaEQwQ3NJdkduaFhs?=
 =?utf-8?B?aWM0RVlFVXlyakVSK2UvVWg3Njc1YUpkem5OMFFYVENkMHVlczdwS3lKQVRB?=
 =?utf-8?B?ckxBSVVJaCs5WDhxV0VTdW03WVVCWERFVUc3MnhtUGxyWkR6b3lmRGpvSldw?=
 =?utf-8?B?QWdJU3BEeVZZYS9pWXFIRDd0YnZ1WmRsbklYY3JLNTBROWVnRVUzbHZOT2xI?=
 =?utf-8?B?YXRnS2I5d2l1MUQ2RC9aZ1F3N0RsWmxPTWdmZGJZM0M0RmROSUZ2NFJPS1lh?=
 =?utf-8?B?ekZBaXZ2T0haTXdHRXk5RTh3YWtTNFhLNGFxTDlOd3lHSVJpVzFQSUFqc3cr?=
 =?utf-8?B?c0RmUmwzNklnV29obDNYenBJYnZPV0x3RXB3T0pXYVVYVlYrUjF3ejlNQ2lK?=
 =?utf-8?B?Ui9qOWU3cmFDNkpHLzJrOGtmZlMvL1NzeERoUVM2K0hERGZwZ1NPZyt5VEF5?=
 =?utf-8?B?VzRGbWVSaHhvRnhTTUxxbFNGMGpyaUhTa3AyeGxQMFY0U0Z2elA5Y2VkczhN?=
 =?utf-8?B?SC9JN0RYb3kyU2xjZGE0a0M3Z0xOZjBURk4xV1ZQcmVCc0tKdW1aRXBmWU1S?=
 =?utf-8?B?TXEzdzN3US9UdnN1d0NML3B2eHlUSExVaVJFSzFibDRPV1ZrVDdBd1MvUmRK?=
 =?utf-8?B?dWs5WTBBVkdNNzYrWlZrQ2ZZOUxadkU2UzM0aDkxSnpPcXZtbVNqL2E4VWJm?=
 =?utf-8?B?VktOSERPbUlIa0cyajV4aFNPQjE5bnJBZEdzd2lTQXFobnNLL2NkbWpwbTZN?=
 =?utf-8?B?ajNpWHZaa0czVjVOZmNQbDdlYzNybzJrMy9YM2hHWHhXZ21oajNtdnlYR0Va?=
 =?utf-8?B?TkVQUGxCNzJHSzQxQTZWMmZqOU1oRGgxUGNibTdLdm1lVkVXYkxCbXpkeGFW?=
 =?utf-8?B?cG9LWHliYmRvTVRLckpuOElKVlV5Z0xrVHp3QmRFaitPRDVoOHJHQVlwNUti?=
 =?utf-8?B?LzhmODF2OG5mUEo5MlZYQ1BtSWVYQ0YweU5pUHJHZFUxTWF4RHVjL3R1UXRv?=
 =?utf-8?B?dUE5YXBldytCMUlpZG5rQTRhRVdLRFBxUTEvdi9UYWtjN1VyQkkyN0JUZkQ2?=
 =?utf-8?B?cFdvYVVKTWFlZ3ptVGFQS0xPbDlzdkI5eFdaZnMrMVlqYXNtekJLUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: bfea0db3-501b-4727-2fb8-08dea1499443
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 15:04:12.6620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqoVv97L3ZBkLYYRUtI+kVNdiwkElYxv/BPVJQkguHz3l+9fKak0StHYW+YwKA/gNlvij2udOoDNEzx1m8bJkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB7270
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

On Thu Apr 23, 2026 at 8:11 AM BST, Eliot Courtney wrote:
> This code is more simply expressed using Option::filter instead of the
> and_then with conditional.
>=20
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/firmware.rs | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

