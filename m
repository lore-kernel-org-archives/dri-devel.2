Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA47CC56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A8EA892A1;
	Thu,  6 Aug 2026 12:09:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="CmAdErMR";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022091.outbound.protection.outlook.com [52.101.101.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F45892A1
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 12:09:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MR6Wr6Upj+c0t+lCVPTajdorU+HsGX9uwmDh2xKuaOSlpTqNbvqmeasbvXC/zXop33yR/b4ZFkTsN90RcTeWS8kc15eWo1mjIpAHfyXiuvqQ+SaSxuMVNAENq62Nne/k5wYucqJ7/afpCirIOYS7989R5hd0XVtu5jHet821ZSDn5IwJ5u16zXZGtmx1dJzI6ClXGuQu1A9EQAln+d2tiS8kNnyyVT/t+adcbJz70SCXRCVBYgNsh7S2Ez5bW57Evzx7KzNEp+l+Zjil2GZ0xQHqPEm82ZdRenDNPTv9p40Ja9BNymI7p8B0C3IpqvZPt3XdNyAS/xeaLhT1jnB6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+24uFCQdVssK1bLvbrwm4YZ+eQhjOZk0bdUdxFwT77g=;
 b=F9aR/5a5CWPUT6JYZkVzqHe2vH4EU//l/nlKeYZPuk7Y0Fc1RJwRlfQQIq87gtmWDuLVzl4BXEX+JRxwUXeC/OZ6C17kokYr3vXrGMzNyCMDHAXZxByJrYc0jQSh9zuKapOzjMqlPEUz7oyDcLYkIFW3ZD6qUjhnZJvwfJ/4zKN4iqYFZ+R0RKRpA44bgaO15a0n+Ml9mq9x74koDnCLdcxIQbdW/BjxS8VJ6HgUHPK64kv/njdJx93syvGp66WYHsZpm2v5S+BG2KxPTVypeP+s1NZM6+gfGfsoVkjsvYOCmVK6qyOJnZ+nbkGzUNipbAOzpsGY72dbf4fK8D9Z7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+24uFCQdVssK1bLvbrwm4YZ+eQhjOZk0bdUdxFwT77g=;
 b=CmAdErMReWpEOQPNkKRTNvo6f2hpT8NJqKANPn6qnAOGpPQh4CPHXG4g2VOGixtm5rq0BMK8PPebNa95EerpOBGJR1zvaYfYYZEtMNMD5uqIB0DN9sHs5Ryhk5mLFwYPkSm6fzbgIpHjKkGagdSGvDB46yMB+f4/PcNyy62TQLE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO4P265MB7111.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:33e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 12:09:30 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 12:09:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 06 Aug 2026 13:09:29 +0100
Message-Id: <DKHULO6LPCRE.2I0PQRNA36LQD@garyguo.net>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <kernel@collabora.com>, "Deborah Brouwer"
 <deborah.brouwer@collabora.com>
Subject: Re: [PATCH v3] drm/tyr: add Job IRQ handling
From: "Gary Guo" <gary@garyguo.net>
To: "Link Mauve" <linkmauve@linkmauve.fr>, "Laura Nao"
 <laura.nao@collabora.com>
X-Mailer: aerc 0.21.0
References: <20260728-tyr-irq-v2-v3-1-9c9bc5c029c5@collabora.com>
 <anHZpHh_5CZhH5N3@desktop>
In-Reply-To: <anHZpHh_5CZhH5N3@desktop>
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO4P265MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb10a33-19f8-4781-1d5c-08def3b391b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|10070799003|23010399003|56012099006|10067099003|6133799003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: jeDELcdTWs4tQPQoj3GZebWj0H5gf6fmslswFRkUXHhIMmihLsfvqbcjEHNiiT08UZuW9rYwHiAaJajxWQbTkWddkvDqs7ELeNIDT1dqVTrF6zrxuXmEj7Cew8bWkyQHc8WabE2TG9FeaADM2KwPZ3Uq2Q6dC0tDlJRrv/IS6429q/DJH2W3gEthIclElJpeygO1FQZ+exE5PifcBDwi6aecIZ/PoB40FNtuPvtMPskScRZoeaRsqsbQA6oNMtUrEXsIuXjYLgL0oSrzoHtbVyR9ogayDH1C0v6hQH2J/05MxUfG0fjVjgqjSkpI+w0wh51KfJptfV0F9cSbsXI87cEDgYVjpNogFKYVYdMvzhl62N5mGLKy6oyCDyQabiQQDp+k6NuxKbzcv14Q2ooTYfhgLmjLIcGmj5lXmgm2LMzodA1i93LY8zGhYQeL9g7V4secPxztCZ5dL6QdZA5x+l5zqiF2brsAAUFCTaKM+3yZzR8wqbqLcPVq89k9lHOYb8AvBKHh727u4+YMQ60GNZhaEGXhgwTgOpLZWCqj9UmtMtu2QGg+u0vZ5/oZF5ExcYH2mMnkzFRTiDvN3SoPYiIWUiSgGNZWkwcaZEIvsk+V4mXRCB21GuxIcn3oSK1+flh6qlTMq2iAigX5A0EyY0nhksl5GXKrp7HSuSykJpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(23010399003)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWtpNGdNenNta0I2Y25YZlhwN2ZIb1VWNW1sWVpDOFp6UEIvcCtrUTZSdWlL?=
 =?utf-8?B?Z3ZVdkJXaTNseSs5VWhmeHlFdE9yQUdQL1dhdzMvVFdUdjJSbThXOFpwUlV4?=
 =?utf-8?B?QkQ2a3kwalZNNVNlNFlVbjMvOEdIL3N0aWtLeFdrdzgvNTl2Rk1xbmthRmlX?=
 =?utf-8?B?ZmVMVWNTVldqRWdnT1dQdEdPNVU0V1lMSDBMOXBMQ1NadzU0RHVsWXJYK2V2?=
 =?utf-8?B?SmZkVytYeVNBdU1EOStDa2tBaDhNRGJXeml1bGRwM0djMmJOcVRnU1h5QmNW?=
 =?utf-8?B?bkdLYmM4Z2x6ZkRPcUpiWGpNU3NvQUM3b2g5MzA4R3BhNFVVTDlYa3QrdWEr?=
 =?utf-8?B?Tno2WEoxbUxvVVUvT3BOQnNRN2JDZlJXQkdBeUtrMEdpcittSzlMWmZkcmlY?=
 =?utf-8?B?U2FxdEE5YW1TMzVpRDcvc0x3ZHRpbyt1cWZrQ0hmbjBoOHZFcElzckdRakdB?=
 =?utf-8?B?TlJwaG1Bd0lZcWRMeXM4MGtoK2VEeFhweUl5aUcwN1VIeVE1OXNTRWtPZlA4?=
 =?utf-8?B?RjFjQlYyUjZORTlzaXFieEtLQkhldEh1MHJMMUhMNlFOeGM5bHpreEZaT2hy?=
 =?utf-8?B?aEZPNVcrYzhTWkhWbE5VMTRCR3pXaDlhejA3aXNqUWxBNGxmQUYzT3NObUM2?=
 =?utf-8?B?ZVI5OGNrR3dIQjJzYkZZMTIzUXhMc09kRFhOeWNmYUJVWThxeHRhSEhReU94?=
 =?utf-8?B?OEM0NUhsSGZQQzhFZExSU2tSTUY0TzFZbFBraE4yZXEwL2t0WFpJbGtrTE5s?=
 =?utf-8?B?eVZJL2xpem5zVWZub0dQV0hOOHB6YzZwQ21HZzJrOGVxQUFESWFpVGJKTm96?=
 =?utf-8?B?UXhwZjFpeTYzelpUbmNadER0SUxKL1MzYXN1L3FBQVpLcThGeDMydDhrRmpx?=
 =?utf-8?B?Lzh1KzRoakllY0tIc05Ud1JLMHNuSHNiRlVMR1NPZVA5UmExeVJuRXJLNmo4?=
 =?utf-8?B?SU01ak93YkNmQzIyWDJMWU1IYUUyNVZ5bkQ4SUJ6alhkSkU4aWtXamxURDJx?=
 =?utf-8?B?ZlNCNHhTeGxhV1ZTNzJoc0UxQm4vNUxwdjFVdHllQnlhVFVWR0lEZzFhQ1Js?=
 =?utf-8?B?ZFphdkFzVGhsN3NsT3VUWi9aeVNBbmVnN0pJd211cENtZEQ5QWRtdmU4anVn?=
 =?utf-8?B?d1prR3hhOWFGTlhYT01jME95eFpMVTJtTGlBTHBqNWg4Ykd4dWhjK1NiTFRB?=
 =?utf-8?B?clBsZmdyUHIxYzdhUW1CR082WVhSSVdTMTNKN1k3azFyR3E4RmpSazFwazJN?=
 =?utf-8?B?ZkQrY2pHVHNOUEVDc0paZGpvTGhMYnI0UGpVTXp6NDhDQWozeGllTWNFcnp4?=
 =?utf-8?B?R0FJb2ZJOERreVBKdStrL0VmTHBiVXZkdE5FQmY0a0hFUS9XdW5jMExYWWRL?=
 =?utf-8?B?TlplbVBkUTQ3YlFGYStENmhyaWV5SkJQTi9ZZlE0NmFhNDZzRFhKdjNUdUpT?=
 =?utf-8?B?U0RKbDlBanY4UkxMcDRNSUJXZ3dhWlR2Q1B5SFo0alhKSFN6Y1NnQUc1VnR0?=
 =?utf-8?B?THlaV3l2N3VkM0RRRWFmRkFuUlZ3b2taczhDUnBNQlJKNXBUNWttc1RMZS9W?=
 =?utf-8?B?QldKajNTdmt4alN3UktQdTF0cEZ0dVNKSGp6S2xoS1lza01idjg0dmVzMlFG?=
 =?utf-8?B?WVpXMG9CYkZ2SWJ0dTl3d0pRZTFMaGZlWVppQlRESGJwWGFHRXFETTA5M2JH?=
 =?utf-8?B?Qnkza284bnpHbHdyY0JiT3dYTXJhbHdITU9CTnp4UFF1clJ3Q01oa2hQdUo4?=
 =?utf-8?B?cVhtaUc1QVdIbmd0VTRXQVhJb0xWenFIbzNJMWFpdzFITmp1QWJyKzE0ZzI4?=
 =?utf-8?B?cy9KOFVZVXVlUDcyaWlNOEp1TUl2V3hTVzFOU0g5d2x1QUx5RnpGL2lHK1RS?=
 =?utf-8?B?ME1oTWkvbFZUNWErcDJHUEQ5Yk5LOXdjNmlNTVdrb1I4VlA3VGkyMzhSWkpm?=
 =?utf-8?B?M1gxblBhTmcvYXFQdmJPSFJnbGhkMEdRLzFBTWlndTVkS3JWREZXUDRMQ0dC?=
 =?utf-8?B?dFcxTFV0U1BYVk15UTlnaDl4b0FoK1YyRVFUUVl2ODJMY2hNaWtYSEY0N21k?=
 =?utf-8?B?OTB0d2MrN2YvTUxSZjQzYW0yYnVsbDlyRTBQL3FJZVZPQ2hQNElwR1ZLaXFp?=
 =?utf-8?B?TVZZeGJyUDluVjhIcVFCVUFEaDM2ZjRGRkNtYWdXR00xQWYrWjdnUWNFV3JK?=
 =?utf-8?B?RW1MQVFvczAwUDJwZ3lwNHFpaEt2NDRPQU5CUkdOY052VzJ5ZWNNQmtnUW5l?=
 =?utf-8?B?Ly90UDJOemVsZldOaXpucVhBQ3RBUFhhdGNtWU11TGQ4aVdLV0VQN2dXdjZ2?=
 =?utf-8?B?cVl3QjVpNE55dHFmUlk4cE1tQ1dRdUFaTytkcTFxYnVFaUI4N1RGQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb10a33-19f8-4781-1d5c-08def3b391b3
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 12:09:30.3200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ij+POm/xTa7SOzkT82NoLtux3vrPBPDx6Ep6yrujM98KZBE9e0XD5iaIiGpPVOWR8K3n+TA8FnSiZlArunrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB7111
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

On Tue Aug 4, 2026 at 1:23 PM BST, Link Mauve wrote:
> Hi,
>
> On Mon, Aug 03, 2026 at 03:34:37PM +0200, Laura Nao wrote:
>> Add a threaded IRQ wrapper for Tyr interrupt sources and use it to
>> handle the firmware Job IRQ.
>>=20
>> The Job IRQ reports requests from the CSF firmware, including global
>> interface requests and CSG attention bits. Only the GLB bit is currently
>> handled, as it will be used to check firmware readiness. CSG bits
>> handling will be added at a later stage. Add a Job IRQ handler that
>> masks the interrupt in the primary IRQ handler, processes pending raw
>> status in the threaded handler, clears the handled bit, and reenables
>> the mask before returning.
>> Add a wait queue and a bool flag so the handler can signal firmware
>> readiness when the GLB bit is set.
> [=E2=80=A6]
>> diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.=
rs
>> new file mode 100644
>> index 000000000000..6eeb1399a7b3
>> --- /dev/null
>> +++ b/drivers/gpu/drm/tyr/fw/irq.rs
>> @@ -0,0 +1,105 @@
> [=E2=80=A6]
>> +/// Requests a threaded IRQ registration for the Job IRQ.
>> +///
>> +/// # Safety
>> +///
>> +/// Callers must not `mem::forget()` the resulting registration or othe=
rwise prevent its
>> +/// [`Drop`] implementation from running.
>> +pub(crate) unsafe fn job_irq_init<'a>(
>> +    pdev: &'a platform::Device<Bound>,
>> +    iomem: Arc<IoMem<'a>>,
>> +    fw_ready: Arc<AtomicBool>,
>> +    job_irq_wait: Arc<WaitQueue>,
>> +) -> Result<impl PinInit<ThreadedRegistration<'a, TyrIrq<JobIrq<'a>>>, =
Error> + 'a> {
>> +    iomem.write_reg(JOB_IRQ_MASK::zeroed().with_glb(true));
>> +    let job_irq =3D JobIrq {
>> +        iomem: iomem.clone(),
>> +        fw_ready,
>> +        job_irq_wait,
>> +    };
>> +    // SAFETY: The caller guarantees the resulting registration will no=
t be leaked.
>> +    unsafe { TyrIrq::request(pdev, c_str!("job"), job_irq) }
>
> Nowadays we use the shorter c"job" way of creating a &CStr, and I think
> the macro will even generate warnings in some configurations (perhaps
> CLIPPY=3D1?).

klint will produce a warning for this, but clippy won't.

Best,
Gary

>
>> +}
>> +
>> +impl TyrIrqTrait for JobIrq<'_> {
>> +    fn read_status(&self) -> u32 {
>> +        self.iomem.read(JOB_IRQ_STATUS).into_raw()
>> +    }
>> +
>> +    fn clear_mask(&self) {
>> +        self.iomem.write_reg(JOB_IRQ_MASK::zeroed());
>> +    }
>> +
>> +    fn reenable_mask(&self) {
>> +        self.iomem.write_reg(JOB_IRQ_MASK::zeroed().with_glb(true));
>> +    }
>> +
>> +    fn read_raw_status(&self) -> u32 {
>> +        self.iomem.read(JOB_IRQ_RAWSTAT).into_raw()
>> +    }
>> +
>> +    fn clear_status(&self, status: u32) {
>> +        self.iomem.write_reg(JOB_IRQ_CLEAR::from_raw(status));
>> +    }
>> +
>> +    fn mask(&self) -> u32 {
>> +        JOB_IRQ_MASK::zeroed().with_glb(true).into_raw()
>> +    }
>> +
>> +    fn handle(&self, status: u32) {
>> +        // TODO: handle other Job IRQ events (e.g. CSG attention bits) =
here once
>> +        // support for them is added.
>> +        if JOB_IRQ_RAWSTAT::from_raw(status).glb() {
>> +            self.fw_ready.store(true, Ordering::Release);
>> +            self.job_irq_wait.wake_ua/rust/macros/module.rsp_all();
>> +        }
>> +    }
>> +}
>>=20
>> ---
>> base-commit: 98ae54f97175c4992b4e5bff53f3c6bc24f0f491
>> change-id: 20260728-tyr-irq-v2-0b3c5022be33
>>=20
>> Best regards,
>> --=20
>> Laura Nao <laura.nao@collabora.com>
>>=20
>>=20

