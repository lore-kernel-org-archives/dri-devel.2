Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A365CD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 11:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD07310EC7A;
	Tue, 19 May 2026 11:58:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="qImMKKku";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022091.outbound.protection.outlook.com [52.101.101.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A088D10EC7A
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 11:58:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWjooaiRFHhpUcLZbZpSCBTaiKEEwexZA/wNkt7V6+CHsJMDgSJ2IcseM+iKV+Kav2NzN7fw/y5nUOed2S4wl/8uRrnRSS9Tuo+5IGGde0kkIc4rjKzKPg6nrpz7uRFwTHZz7xhzYHk7svSUPUZMe8EKwUX3vXdDSAv+xhqVRIMKHDTqkH+3XUGixUFVRGZT5t82SAgU0qhENCa+jdwykvvO2AGqDLUXkxdQMqUzMT2+vP+c6Mp/jHZlFSx3zmU1FM+JdAubUtIUN9rrk+ODCBJXT/GNpURwvT4Q5G8fN5qeQ2TFWwBCQdkf1JVQA5XgcLLiRLPjNEA39MilwBaSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9knb06Hw47mkU6lucodvvYqk/OEyjN7f3VA1uKrtio=;
 b=hBqXJr7//IQlNOxmEvwSiLy59ezUws4CWfuEuuMHpbC6Zjmq4uRFiQgURDuEra70BIbYKqvaAncRaqTSnH3Xe1GQArKEXo37s+6a8FW2gPcgp38oadRv7MCzjBa7Q3YChvKyFfNmE2KZMn8LkJN/TN/BD9UrfOdagMT+MZVSCFcc8upzrZQgEOtXa357EqKREf1A98yeZbfJ3Kkjqf95FwvUaJksZHJw5Wu9cUb2QftGuDheqRWL3cXkwyp2A7l18KGnWbR4yl4Y67x3Hm8/9Dn7Yj8T/oOfPRBXC2zGkVn8t4n4CuU8slXNHcsq9tyBMc1wLpZgUCJnc/w53GaJlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9knb06Hw47mkU6lucodvvYqk/OEyjN7f3VA1uKrtio=;
 b=qImMKKkueZ0vPwkInK3Xq50l4VU1dWZchkXfzdp4iM6bvz0hI2qFTXxdqkiAPsD7HzG0utaEiAJOwHQuGekwajwbkfXT6mVcm5wo36SDsIixGFFmpkjGOefCBlp+HdgBX9nIljTD484+bsI9IaelwAw9+F2HXRkEfcbghj+A4Og=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3708.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 11:58:52 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 11:58:52 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 12:58:51 +0100
Message-Id: <DIMMWHUOLPSH.13JFRHDKDQJGO@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Alvin Sun" <alvin.sun@linux.dev>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Arnd
 Bergmann" <arnd@arndb.de>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>
Subject: Re: [PATCH 3/8] rust: drm: add `ThisModule` associated type to
 `Driver` trait
X-Mailer: aerc 0.21.0
References: <20260519-fix-fops-owner-v1-0-2ded9830da14@linux.dev>
 <20260519-fix-fops-owner-v1-3-2ded9830da14@linux.dev>
In-Reply-To: <20260519-fix-fops-owner-v1-3-2ded9830da14@linux.dev>
X-ClientProxiedBy: LO4P123CA0466.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::21) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3708:EE_
X-MS-Office365-Filtering-Correlation-Id: e9dc19d8-2f0c-4ff9-5d1a-08deb59dfed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|10070799003|366016|1800799024|921020|4143699003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: f4Buitu9mJFGv4blrOtF7HkrFf1/r5r0J4U3Jscudiu4UbS+0Xwj8RMxYNx1OXaxACrtwVnBFaImQMiv+KdVAhZNEuE4zDjXcC/LmXxKMnxcISbqsBeXpCTqZHNCMXMguMrUF9hsZxD0k5jButLW7qpEv5jyBefIqTe8DK0nDrw1aO1Qhi6sP//sGWo1DQGaNGOrXP2rU7c9I4mDKqokKKEo22kRDm7o/SgBe14dzJLtg1KBeOUEtY2ipmKoje2BeAzM0/CgPZhLAtNzvqS/EmpI8V+CIQvlXpUJhGQWCaHqNYkU3HKbsgyfduXow7zMZ1caCsaCGSmCFtPprz1lKCEvQ/SxsGrp6hjiY0fecpCUJfZBZCjvo8sXQx54LyKlmHf8VhccXcO6EZF+RJ6j171g+hC9UMsRuKIogHyxuOwCuA7HczXNC7++OCpaSnrTbASJHiwkTDoBjr5H25oC3CDPsdkx2McEnQ5bdb1IXbYJdkYuohgrESOu66u1akfp7MP3Ho5+PuysqJsZnyr4/hRWArkve5fcev7agZQyCfwS7NjfGubJEKQmUqY7QdRH8Jtjv/AYcISCQfmu+zQHa+pn0kPS+uPQtS8wEXnlPKo+hTz8l1KOaaWZLK2ANr9zO18XqR8yzMKvSkTQwJNp2W5gcw4kSLWFQ7vUNIHSDE4vAfYuyBV8Z3pxm2eJ47DlJzT1cN6u699BM9l8xGut5zqsPlvvkSw+2Jd1ko1p3PQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024)(921020)(4143699003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UW1yVjcrYjJEYXhyaXdFMlViekFLdDg4VnlFbVhQQSsvQlQzeE85aE5RbXNT?=
 =?utf-8?B?Z3lQTG9zL1M3bXRGeEF3S3FWeDUwNWdCMHZHSERYRFNpcVRDcEM0bEhPZlJl?=
 =?utf-8?B?NEhyN0xRM2ZqWTZ4M3ByMGlvNENqQ2hseW9pL1BCMUlSTmo1NGk5TlIrWGRX?=
 =?utf-8?B?RFUwTW5ZbEJLeE9nUVRvQzVVM2wvNDBoS3VkWGM5M2wrc0I0L1BPM2JmUWlJ?=
 =?utf-8?B?UE92blU2cEIzNW9DdnE4Z2RzSlcyTmQwbHVJS2loN2ZKaDJ3TGhET3JmbkVP?=
 =?utf-8?B?RzNScm1IRDRsS1M0ak1meFptbVUzRXBwRENkd3F4citvaXh4YWlxMGduWDhK?=
 =?utf-8?B?aEpkeFE3akdGQVJlL202ZG5ycUN3TE9aNWVkNmxqTFJLS3ZhZmR1dFFhSmVX?=
 =?utf-8?B?QWpJc3JrblRDb3VjQWtiZXpreldCM3RPWTJwVFQzcDR3VHZIWTljTXpqOHpU?=
 =?utf-8?B?anBNRVJkRWZsZUNBMVUrWkdaTHNLbThBM3Njay9iZkJqRm96TzFycUJCcU1N?=
 =?utf-8?B?bzhFNC9iWE4zdC9PMW5jWEZkbGhoOS9ka0FoeW5HRWJmM3JJYXJyeldkQUdv?=
 =?utf-8?B?ckE5aWFtcW1XQzEvaitZcXdla0t0dyt4UGc0Z1UrQ1lTOWE3YlpKb0hzU3Bj?=
 =?utf-8?B?MFJyZTRTSUF6MEhpV0ZQNWp0N01BTmxPNEhwN3M4WkZkY0dodEVVSy83VTBL?=
 =?utf-8?B?V1BPWUVBOXFoQ0cvTm1ueWNNcDNYQTF2b21lZ09zYklnMkUyUC9OS2U2Mmxh?=
 =?utf-8?B?MzBNWmd4Q3pScFdCZlZINjJFeWJRNnRFMi9Ea1NENmpmSHpmMi9RMWl6ZzZp?=
 =?utf-8?B?NVVITThwdHhIU0hHYXllMHJJWURCZjhQMnB4UGlkY05nQWdCNUlDSU9RS0Za?=
 =?utf-8?B?M3JCczhjR3hLSHZYRDNpSkllK1hBcU5yRzZocFFYWUU0aHh0bWlrY3Ezb1o1?=
 =?utf-8?B?cXRRNXJnc1hBZ0dEdEFjdk1iNlQxREUzaGU3ZWpYbW9ibHhNdHd6c01jWHc1?=
 =?utf-8?B?SC9GU0Z4MWpNTHdDNkUrdEpNSGdVc0Q3cFExT0dIUDZ4bzRKbXRINWU5TlQ0?=
 =?utf-8?B?MUlhNE1sY1ZseWNadE9yUE9mRTBtTUdPajV2L1VBSnlhd3UySmswMDlLOFNP?=
 =?utf-8?B?R3lLU00vMFdiQ1AvblJMZ3lYWXBNaUx3aDQ1V2p1L3o4UDg1N0dDTU12Z290?=
 =?utf-8?B?R2xtbTRCdytHNTFvN0hoTFMzU0FmNTM4TVpHenErTHlVaUs4cE5OaWlTSUpT?=
 =?utf-8?B?bFRIOVYvRjlnbW52RVF6V3J6a0Q2Tkt4V1NTdk1WNiszWU1USXgyNmlXQVUx?=
 =?utf-8?B?bjZaQ0diU21wWEJHTFF1N3QrRU8wNm9lWWU3T2t5Smh4d1RQNzF4akFESFNV?=
 =?utf-8?B?TmRxdi9CN05DOXBiU2ZtaEExKzFpeVNmQ0VRTUg5TlQrWFhweU0xNCt6VjhJ?=
 =?utf-8?B?VWlRMW9jaHNkUXRtQTl4V09iQytYM0l4cGc5YVVVODlyck1LWjlmQVhWRFRs?=
 =?utf-8?B?bnVZYzVWeGtuQ25sZlRTZzhPL2NWSi8xUEtnWTdGRzVFYWhSb1dqUXVwcVY0?=
 =?utf-8?B?UXBqY0ZYR3JhWUpXeXVrQ0JFVSt4TU1haDhzcmR6V3o2YlF2N1lzVXNKZERy?=
 =?utf-8?B?eWxjQzRwUW9YZERIYk5EM1BPMnZ1L2VWR1QvTkdLUTBNOWgzdUpCTGR4Sm82?=
 =?utf-8?B?UkgzMCtmUVQyV29TM3JyL0ZVcnRibTNsQUhKc2lIQk9mUjlyYVNWSWJZczZt?=
 =?utf-8?B?eFVIck10cTREUlRKbWN3VU9paktlbEpHNlIvN2tDSExmZE1VdlVaenJXUkdC?=
 =?utf-8?B?NVdDcHEyNWFFTGROU21UNzV6Umw0dlU4bFBTdEdRWmtmcXI1TDZxU1Bjb29J?=
 =?utf-8?B?UzhIc2NpVmVaMy9QTURJWVBBTnU2enoyOHVQM1doMVhCTDEwbkFJZHVCWm4y?=
 =?utf-8?B?TGo2cW5UeVhwRjVlRXRNWlVLOElELzAyTEt1Y3E4WDBYMGdXTkxXRkZtYXpH?=
 =?utf-8?B?Z3d6SnRYOEg1UEo0ZVZjbFNZZks4NXV5TmErUWl1RFBoTjEvUTFzcEtzbUhQ?=
 =?utf-8?B?SXQzSFZJSHd5ZEpqOUhQTjZDM2VGUDRZVFh1cnlHSGxoRTFheTlCTmFXMzhm?=
 =?utf-8?B?OThkTGxWK0NPSjgzM0VOK2x1L0plS0NMTEFiRCtacEJNa2pBd1VvUnFXMDNH?=
 =?utf-8?B?Yk5RRm9SYXIxaFVFdE9yZXlVczRmU3I0RHJwaTNpdDlaNHg0Z05walFHQTBZ?=
 =?utf-8?B?OGhoeFE5YTBKNElFRmtQZGwwaGptL2RGSEgza2U3bzA4cnMwaUlYanRLVDVJ?=
 =?utf-8?B?TmVBUFFKSTBvU1lnQTg4RVB5VlF5UkRyRHBqMUJCU3M4dkpaL2pUQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e9dc19d8-2f0c-4ff9-5d1a-08deb59dfed3
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:58:52.4363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BtotIq5pWhe9P9sgCcgDBU92esnbEBDIXsFWEkc9KJLaxFfvbFEhPhaAyn6sQA9uDKsDqIrdLJi79kneYOhW/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3708
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

On Tue May 19, 2026 at 7:26 AM BST, Alvin Sun wrote:
> Add a `ThisModule` associated type bound by `ModuleMetadata` to the
> `drm::Driver` trait, allowing DRM drivers to expose their module
> pointer for use in file operations.

FWIW, I was considering adding this automatically to the `#[vtable]` macro
(associated types/consts won't have any costs if they're unused anyway).

But requiring an explicit specification isn't too bad either.

Best,
Gary

>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  rust/kernel/drm/driver.rs | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index 5233bdebc9fcd..c798961650c1a 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -115,6 +115,9 @@ pub trait Driver {
> =20
>      /// IOCTL list. See `kernel::drm::ioctl::declare_drm_ioctls!{}`.
>      const IOCTLS: &'static [drm::ioctl::DrmIoctlDescriptor];
> +
> +    /// The module implementing this driver.
> +    type ThisModule: crate::ModuleMetadata;
>  }
> =20
>  /// The registration type of a `drm::Device`.

