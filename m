Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBCB110A62CF
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB1E210EA38;
	Thu, 26 Mar 2026 13:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="fiYnFbsz";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020095.outbound.protection.outlook.com [52.101.196.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3553110EA3E;
 Thu, 26 Mar 2026 13:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Snr7iw+EhoJorsOdU05G2DqpwS//R2VI0C0OF3C/29pBT6vsh0x4LGLCTTyM3U9yN98F1sCMOPne26AH/x8O1ofqa0xLBbXlfXp0a2tyJXlXrhnlkGIduxXAlswTBWltjYwHl85NT7VrGTk6k2M9C7rzi59YUx7J8lhBs9jNLRc/M3F+d+vVaikzZV86di24KHLM6inVjy7lW73n6j50AaPSt97sOeQSEwUHsfe/mvy5Ivf7K8UHMCZGRTKHoPSVOGa9J4XZBDBitk8CXYoSXEtILzfyKNRHmGtSp6/jXhqL6FpcbgDN3FG3jSJZxMjbL/QbPl7EQIWYOPMQJkaiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EygOYy60IOb/rai5mtFqMJKO19VeitLtpCaP4jBI6c=;
 b=xftPvOrUzjVVlqHiZ+43VTITTuDt+l8u+oTrBWDfVtkcog34o109ySJ9pbLYhp75HZAjnoNuKQmqHrc+CtWkFB+Knsoht7LNSbKS6j3Qyf4o+LOb9YId0P+YCFg0m1l3kZ77x754mQoCkRtWEks4B9GuBsBhSlJy48fjCEC/kBsdgbdHabt8zQ+O3zFqlCjNGRBRZ1hrkI9kjzS7e2j5+dM2CFr2ItvIF0SwIw929/kkfMtCHxqZfv8hcYnNf1mOwOpurulMwBkEIfQUJ1MAMkkWeI4p5qLrtI/Bf1DDxJIZSmTzjRWHVZ3EJ+jyq4rjrIzrDWkHYw9S8uqxbpTIaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EygOYy60IOb/rai5mtFqMJKO19VeitLtpCaP4jBI6c=;
 b=fiYnFbszOaCexWwOrN/NXablkonK8f0Tw+FMTXUnOFZbvkCJOiNlax/s3JyIr1d6Z5e9o9GCzrdNmFuL72tqgU/hmyNDMp1qXlY8BTYyZZ6ni5ZXn5k8vyJaL77O/9mWVPdtf0u8qXgUZ/3lTYPaW/KcHy5n+hRB6mg4imoOewM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3114.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:15f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 13:33:25 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9745.022; Thu, 26 Mar 2026
 13:33:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 13:33:25 +0000
Message-Id: <DHCR3H0O6R4N.CACOHQE39XEW@garyguo.net>
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: uaccess: generalize write_dma() to accept any
 Coherent<T>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <tmgross@umich.edu>, <ttabi@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260325003921.3420-1-dakr@kernel.org>
In-Reply-To: <20260325003921.3420-1-dakr@kernel.org>
X-ClientProxiedBy: LO6P123CA0027.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3114:EE_
X-MS-Office365-Filtering-Correlation-Id: 528fe0ab-6b4c-4291-11a4-08de8b3c4205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: eWzLwIwlb2+VrpRXgb3ZL1Lmd1M6bVD6xQcPbCWN53jZiUGWSJvwzY13rHGqhG6hv2DEbm85BHyw5hvE184HpX/koyi3iCw/UrOljHhcQvh3MpaCTzsAbOlnX2oonwBGDza+opnll/6EhAXnS/Si35KFDeWh8GoB5+zZgOku/iUJ8ML0ak/WU8DnDJCcDp9nZswE/0tNh2euP6VnbeHiLRrflo14hAUF1fKHKeapACAI7BXUJyB4fqP+QXDbGuy71YqebLycJgPtoXvg9N2f+4Lhav843CHw0dNnVGJYkU5+mA5+UCh97ppEis4AZybpE1vSB+Mu/e7mGTjz3e3gYo/YEjtpQIXf6/98lG3hOYS9GGP4xbIHaDQZxk5c3rHEBkyOLD+5iVjLfdiC0wJ/VypFvC/Ax6GqysHk1AEs5411t2ANJdaMNUe5lioeDp1h9dZywerW/OEFRHyWs36mG38g5vA5UXIuiZcw5E61mTWATCR2fAat5HHsvUzehBs71ijenTRxVxZTMOs4CWf+7TK0rFiIsOfg18HvwzWMRzfPsQGHuQlFLxBto1OqP/NLhUiJXbQHnJEiuhojUVG8pymRCrv9ZsYeiu/v8Jk5aq3LQDrAIy1LKCezqzlqA5m0BVFDob4SjX2K2M0Y0TiA7/U77KpHNdj7noJpSnvNrYhee78PsbabuGXTxlt9/EqLpC4Q9MYLuWG6FgPesd7QPllbIa1wzgbR/hfqInvlmg3MKzlxA1Nj1ZgG75yEeug/03t9d41XeQ3fDGQx7Nj5mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRqb2JOeWdDODZRK1NJRzR6c3Z6NzVWTEYwR2tzanJOZzFwNG1KOW9YQ2VI?=
 =?utf-8?B?L0QvQlRLV2kzYk9ZZHZnN0RZak9iUXA1N2luNFNqMG5lRlBKOExnVHU5MTBa?=
 =?utf-8?B?QWxYT013eWhKKzI0UUJTNmFTYVdFVUpNUmk0Tmptb1EzQlJ5SEVHWndOOVdC?=
 =?utf-8?B?Z1k4WWg0a2U1dVFnTjMxeWZIUW1zdnJqbUV4OTZ4b2V6RC84dHdJM3YwTzJO?=
 =?utf-8?B?QmdWL2ltQUdGbkxnOHlhMW9XK0VoeWVleFRCWkZJcmpaK0FqSWRONmRmTXhM?=
 =?utf-8?B?WFhGVjREcFhIYWpDQ3RhZE9Eejd5em53dTRBNWNZbkVpUkNud3hCTkJMam56?=
 =?utf-8?B?U2FkSkZQdDBwekd3TVJqRmZKUlplcnhxSW1kOUNnTnVrbFhXamdGTjY5MXR1?=
 =?utf-8?B?VFM2a2VtWkR0WEwzRENxMDNEMnVZaDIwUU5VS08rWndkUEJuUXhwRm5KMGJv?=
 =?utf-8?B?cU93Uzh6L3B3R25uNmZJZUNsQko0TnpPckdVUVFkRjFoZ09PTHUyV0pHTmp0?=
 =?utf-8?B?Z3kyanQzY3o1cDhRdWJNOGkzaGZwc2NhQXdDaFB5aHNpTG0vTk1vQ3BWWjFk?=
 =?utf-8?B?c1BPVldZRTI4MVdmT3pKWnBEVndrcjcySUhsWkxSVjh1UVRIVjFJSWxEVDI0?=
 =?utf-8?B?emNnWVIyRXlmTEVWUG56VFVvWEIyM1g5Q0ZUUUt4Wk92dkxoN3gwYXNKeERY?=
 =?utf-8?B?NENUMU5HUlVaVEtZdVZ0b1lHdEU0bEVoV2xjSzV1dElLeEZid0hZZEV0Vllq?=
 =?utf-8?B?WHU0a3ZhTkx6d1NZaWpiRGpUenQwT2hqeE9qWmNrckhMdkxmeDFTVnMyTzJP?=
 =?utf-8?B?bjJHb3NCUTczRkZtZGo3VzZVak81UkdIS3c2OXJZMU1BUVZhTUEycE4rY3FV?=
 =?utf-8?B?UEVKOWd6Uk0wSnIybmN2UGFBMEE3TFJoamxyZTB6ek91MmJTci9mYlVtL2ph?=
 =?utf-8?B?MVR2dExmb3Jibk13K3Vxc25LdDJqVTdBTWNaM3ZXKy8vSkVyN3BJT2JoMzFo?=
 =?utf-8?B?VFl4WHJvRzB6WUNINnhsR3hMbThqK3FRQ0liUm5ad09KTTNuMythV0NvUG5Z?=
 =?utf-8?B?V09EcHJzMEFZcUlKTWhHS0tabEpnajV5YU1VMUE3ZU81U1R0RjRpa2V2aE9M?=
 =?utf-8?B?RS9YQitYTkJVWnNmOXBSWHQ5SGtLYzJLeU9vSjJINWQzOXp0ZW54VDBUdjFL?=
 =?utf-8?B?Q1BQQVI0T0RmS1RHUVBvRXlNQmFlYjlVd3RNbUFkc2Z6YUFCckxLNUJRMzla?=
 =?utf-8?B?U1BFeWhzcU1NeSs0bGd2azlLTkJoTzRsNjUrNWQxajdlRGhrS3dObmFwQ1Fj?=
 =?utf-8?B?UjJlZHBvZzZOZHhENFVzSkpKbFdNVkV6SXNFdlJLU2JLOVhkbFh4UjcwYzFm?=
 =?utf-8?B?TmV3RFBxN3luMzlPOG4wdzY2K1k3U0VBb1kzdFh6WWJlckMwa3orZmZrM2sr?=
 =?utf-8?B?VmVmbndYdDJDQVdVRVNjT2U4VjlhelpFb2ptMjc0Zkx0V01ZL2JISndHTEdF?=
 =?utf-8?B?N0lMSTM1Mjdxclc4Q3dUcmh3YnV6Y1hLTGpGWjM0YjFveWNSU1hLQjJsY045?=
 =?utf-8?B?L05JMVl2clF4aTM5Slo4TDNDb0ZFUHRjWlp5dk9VZ1F2OGZzMlYrTkw2eDVE?=
 =?utf-8?B?YTVDK1gzc2k1THlnMFErdGdqbkI1b1NySlNjL3NyWGtzQklYODQ2U3ZJS0h3?=
 =?utf-8?B?YjBIOEJiU3RZbmJWVjJDa0IvSkQ1TXQyWGdKZ0kxRFluL0FFSzlMWmdndThM?=
 =?utf-8?B?ZVFiSFhlTlNlZTY5UGYxaUlCNVovQ0ZZZldGVHJSTk9jOTVLdGFubzVjWkFC?=
 =?utf-8?B?alNRSnU5Vk9RSnJER3dOMzhnb0FvLzhubEJScndqdzZaSUMzajRNLzhHZjFl?=
 =?utf-8?B?ckttaE82TWV5Nng1U1RkVXc0TjBRWFNIR2R1bnA1RGpXNWcvTi93UjVVM2ha?=
 =?utf-8?B?QVZkVi9RTVVKbGlab3VhRHBCNExiSU54WmNZdHF3VTgrYlUyOWs4SDdXV0tr?=
 =?utf-8?B?d01wdXB3aWdvaW5mS0FCa1VpMVpoMUpQSW9sZlBZWXVPTVVUZG5GR091aTha?=
 =?utf-8?B?aEl1MWdpTDVRbEJON3dzZFpoOXE2VkdTcFhnSUZ5NEpiRG1yMWxBdDYwQ3h1?=
 =?utf-8?B?eWhtMjJEek1wbUFvall6eUdXR05JOG1LaGFXaHhWSHAvZ3pxbnZVMUxXYktu?=
 =?utf-8?B?VEVDaFFxZEg0eXArcnBPYkRqb1VlY05YOGJWQ1E4a2pYaE5BbytSSGhnZmRM?=
 =?utf-8?B?WWJQb2RCYStFS2FsYXJ5MXZvR0JQYnptSW5BelF1Rkk0M3JTZlltMFVRVU1t?=
 =?utf-8?B?N0ZLWEtNODQ5eGc1Qll6NVZSdlNaM1Jwc1FLWnh1MEpCemcxMjJpUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 528fe0ab-6b4c-4291-11a4-08de8b3c4205
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 13:33:25.6136 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oe5nWLSjnTvlLzo5evOV2rq/7DIvhMHsRi0GSuKl+Hr66fCUTrOOPxaH87qYq4CrBlY0pswcnmF+dWxOzqQXPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3114
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

On Wed Mar 25, 2026 at 12:39 AM GMT, Danilo Krummrich wrote:
> Generalize write_dma() from &Coherent<[u8]> to &Coherent<T> where
> T: KnownSize + AsBytes + ?Sized. The function body only uses as_ptr()
> and size(), which work for any such T, so there is no reason to
> restrict it to byte slices.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

For the series:

Acked-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/uaccess.rs | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index e26ef90ba8ad..6c9c1cce3c63 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -12,6 +12,7 @@
>      ffi::{c_char, c_void},
>      fs::file,
>      prelude::*,
> +    ptr::KnownSize,
>      transmute::{AsBytes, FromBytes},
>  };
>  use core::mem::{size_of, MaybeUninit};
> @@ -524,7 +525,12 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result=
 {
>      ///     writer.write_dma(alloc, 0, 256)
>      /// }
>      /// ```
> -    pub fn write_dma(&mut self, alloc: &Coherent<[u8]>, offset: usize, c=
ount: usize) -> Result {
> +    pub fn write_dma<T: KnownSize + AsBytes + ?Sized>(
> +        &mut self,
> +        alloc: &Coherent<T>,
> +        offset: usize,
> +        count: usize,
> +    ) -> Result {
>          let len =3D alloc.size();
>          if offset.checked_add(count).ok_or(EOVERFLOW)? > len {
>              return Err(ERANGE);
>
> base-commit: dff8302ca1d0e773c90dbeeb05e759f995c95482

