Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83845106B528
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 13:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C98D410E1F0;
	Wed, 25 Mar 2026 13:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="KXRpgfRO";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020081.outbound.protection.outlook.com [52.101.196.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26B7C10E1F0;
 Wed, 25 Mar 2026 13:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wl08+20+07gpml/YJnkYIoJAbptFscmAT7c+D+VTxQigk+0kffRrbwHC+H8NdSVYe63xndiQdCEeAwO1ehJz7idNCqLlWCYnT+12VAOXFYhNvhUrradIjkah9JvIMj/MxLKT0/REBgiE56/pY7+c2dW+cmeI+1lD/SOFe9ZRfy6Xz25Ns5FNWqQDzIhgCfTKGdvlqpG5lNDSsszlwj5BGbEdmpCslN8LakQdJsLwspRZ2sUqZ7t9ducUyxDt0hCE/AvMcvWMd3JtMql4bnsahOhyJfYAJRZz9PGyUbz5/Ye+PpK3kdBzW7ySoCcSdVh5Ke//bcvi22Nvi3kj3cP6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6o4Kyo1iuTsBfUbXKMcsdsNSweHBH9UI9HzafawFD8=;
 b=onCSlxHrj53MjlzuJ1pYxtHbGxMnl77Ucl7PHSoyNmeWNjJzwx1QqNw7WrPhSOtzAS38968SaBbCSt9b/H2KVV5pfD6SuoZqwCKLMjP+DMDJ7HusT0cpu9/+tVGrmyyrOvakeuOQMlIKaszvxVJBoeIKd+9Vqw3590l04xePnPuRnqB3QHWCRVHhWe0aFxMELjUOkTaFga0SRXDyhE+/fwYksEAykmsTNE6v5GFDjpsaDR9nYDgQrFDWW9wi5jwKi+oNtjRW4zNWp/X9gOjrKUzp+4EfUjBGkIjDVKvHbjfVLIZFd8KzM9LJkA+CutV5vubddHDWeY8EGFhsNIffUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6o4Kyo1iuTsBfUbXKMcsdsNSweHBH9UI9HzafawFD8=;
 b=KXRpgfROeXViQUeChLZPIOAQCYVUCvOdLpAT+rl9jgg55WdvxBl5HZpU+izCTHCH4NYfxoGYvzyyOmudP1MsrRilZoZnc3X+kr0Kx7jWCFtQFnTO2QvCBfRJRPelR7WN0Wvkc63sM2i16OLq8G1BYBAupg0ReL0pJoofPqsg4YM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB6097.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:24e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 13:01:08 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 13:01:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Mar 2026 13:01:07 +0000
Message-Id: <DHBVS7DX89G2.34ELW7TJAH7M8@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <tmgross@umich.edu>, <ttabi@nvidia.com>
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: uaccess: generalize write_dma() to accept any
 Coherent<T>
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260325003921.3420-1-dakr@kernel.org>
In-Reply-To: <20260325003921.3420-1-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0066.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a991a6-f721-4fa4-280d-08de8a6e94e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|10070799003|7053199007|56012099003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: bBlTFtMptl4qviY3hxjzETjLZTcaviXyBeK1S509/qbX5mK6pXnUxeJSNSzheRDgl+xCfJMwCI5biI/cY66Ug+vFzTpE4FWYP3XTP8lJ/6qPA1ySJ+ZSo37emxc46Bc0v4i+vC2HGuro8O5jCyYIMw20F4jbZNdYxxFvTcohmp0taxisLESL7KSOoLOsb2I+M1+8xO+rHGZ/N9FHidHIQkv/Hq3rELdylWdz+s2sCE/PsOlF2LdPONOA6npNQ19FaQ4LgYRGLCIaYPu4R4MwZt92y9Db5Ts3w0s0vFKaIA1jplt8DKw8580JWeKPI1HFLB9pJdEhsSN1EkucldVvase3bM074aWCOEWba/trJcgNJuV4rllpo9DWlA9azpSw4UA36ukDbyRH3iihQIV25DyyciNTO6pQyGhmT0uph8PnuSR62fZOui9QMDlqYyDEAP6CSE3SyYXNrnF/s0U/G+iU76DM2v2LnG1L4/6VKxraIPURMRWxIjmKdSsUGhn4CTKCvxfBtroMXhKS1DYFo9b1+JrYoMzRETLWXD95tfcIvqgfATFarJnfiweeLKKxB+/gk0k1qyt3fZvPYzODqFCkjemRkqwF1ivtG8FxSy45BcVKWXa1hVip4f8PYvExr4EHhGn4D72y2jcaPK/kkxytYV8I70xZ7p8uGamSDEstB1v3IiBEQisx1rY+pGdKypITRtDEE16WRaYIsiBo1zIEL16KRHCVAbXmGPG1g/nIC19Hzl6uk3tpkTZ5nRm4lY0cVot/YUmmmKPYqb0QnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003)(7053199007)(56012099003)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZTY2Q2TFBaZFUvd2ZjTjJ5eXIxc01ET3Ntb3NDSkpCaWczbnJEMFRWUFBw?=
 =?utf-8?B?eXVEci9xaVRXbzIwM29wKzJzZTQ3MWRKZHdXUG8vNndiM0NxbVVCVEYrcVo0?=
 =?utf-8?B?c0pzT2pZeXFlUHcwMmR5eUc5WU1lZ0JBbDB5V1g5OCszS0dGQlNzbkQwTDlw?=
 =?utf-8?B?TVJVZGhIbjBPQWFteTA2cmFYMVQydlREc1ZYWkFKWk9LSzBWRUwweHRQMXRu?=
 =?utf-8?B?aDhkdEZXeEFzLzVhVEt6UjFucTZKSUQ4ZjAwd1Bad2FYbXAvQWJ6SHkwY1I3?=
 =?utf-8?B?dVlXeld2Ty9zbE9lWXhETlBZWXovQ1pyMmFsTHNmbExzRStIa0xZY01PRW9Q?=
 =?utf-8?B?cFh3Qm05L3BWQitMdWVJVzdOZ0loYmhGR3Yyb0RTMndCYjBCOVhrODY2YjhG?=
 =?utf-8?B?SjA1bDcxQ3BmRURlSHFuVEcrL2l2K0RyNFNMWGU5UTdWc282UnBFZkhqeHA0?=
 =?utf-8?B?Vnp1WnpHRjA1YUVPTFF1Smw1dTJmM0VDU3FCdHQ4NjBwRUFhMmpJY3hZMHNy?=
 =?utf-8?B?QUJRYzlheEJhSWdGQlpkVjdPSzhnTWxSdHRNRWtwR1gxS0dTYjRNY24yS0hO?=
 =?utf-8?B?SlMxdlFkM0VoVEt3T2xWUEdSQU1SRHBJendSWTdJOWpXZ3g4cTVvSWVIdjlx?=
 =?utf-8?B?ZUJKYnhmcHZjZkJXandrMGNKWW9sOUZweGZmbDQ4WVhHbUFOdGI2OTVLbjAr?=
 =?utf-8?B?UGlLOG1FYm14eTUxM0p0OU1idVNIRlpDVFlTTkpjbFFMYTYvMHQ5VjlGZ3M4?=
 =?utf-8?B?cG41d2J1VnB0YlRuT2FBWXVmbWlFejNtU0lyRFpUcmRvVFc5QmRJMmkvYXhm?=
 =?utf-8?B?aG0rYzVXOHFCRTZyTjRlVm91c1dKM0FnTER2cEgrTDRjdUJJODdHUHVIOGJ5?=
 =?utf-8?B?T0FLa21DUlArWEdoQWRVZzBsa0paTWE5dXMrMVdMcXV0RnJ3a3Y0c2NNV0FQ?=
 =?utf-8?B?R3hRak5neXJhYy9MVDNkTmEvMGFSeDM4bGNwNU9Yd1dHeUJQR1ZpdzRKckx1?=
 =?utf-8?B?dXA4N2dTMm1DUnc4a0QvTUpNNUtCbURRWUNGd3VOQzlvVmZOS1E5VlZ6OG1V?=
 =?utf-8?B?MHg4Z0RjeDcxdEtMNEFzSDN5YWtabUxSZHAzYmhzL2xFWWlLZXpicWVISzVY?=
 =?utf-8?B?UTFUeVAxOTlRWmZIM1BzWjl2Nm9HdHM1d1cvb3BNNE56ekE4RUZKblY0MmVM?=
 =?utf-8?B?Y0V2NDZDbExaODJDVW5iRktEU2pVN2MvZlAwTVBDK2RveEdCYjQzS25Rdm5P?=
 =?utf-8?B?Tk54Wm9laHE1MDlDUUgxZmMzaXp1SnVsSU1zRklKU2NIejVvcGM0Mm1TbTdp?=
 =?utf-8?B?Q3FwalVRYjJNdU9LQnZqeTVOTk1UWWR6Yjl5RG1qKzhpcjk1czVHM3lVaURO?=
 =?utf-8?B?aTE3dnhBdWg2MmdUeU9ZZHphVXYwOGVoVUlSOXBPREtiaDJVc0lzMkpYaU1Q?=
 =?utf-8?B?V05BRVcrMHNuVzJONy85MUVwOHJsM1FFOGRrMEJPTVhBeTdISDBNblB0RjdJ?=
 =?utf-8?B?ODhVclE0UlBjWU5RMjNIQjM5UHpGcElFSm9SSDkxb2FocjdCRGJJbngvcUNi?=
 =?utf-8?B?WDdhTEhwK1JEM1lXdmtZSUU2RnNEb1V0US9xanBTczVqUjFzRFRVNDJnb3Iv?=
 =?utf-8?B?VkcwTll0NEVlcDRmVGd4dFpocjBTSkxvZ2xsYlQzNld4eTA2STg4czJIWVZT?=
 =?utf-8?B?cW1PV1JaLzBZekVtVERIYW53aU1OU0FxanFUZ1M0SmFvNnNzMElEV0h6TW1z?=
 =?utf-8?B?SGJmaGVzZHhMNjd6eExneHk4MFpub2YxRnZZa1lRUEowbTIxYjFuMXNkcC8r?=
 =?utf-8?B?UXJDUWxjSzlEaEV6aWMwRmlZQkVjQ2tNNTY0clp6WVNLNlRJa1pHS2xwRXRj?=
 =?utf-8?B?dkhhUVZMMUNZeEpoRlNDTkMrUFVhS2o5NnZkNGtWV3BDWThXVWx6dEVpeHdj?=
 =?utf-8?B?UFhVT1VUK084Q3NZMTJ5WE1vY2lOckwydWovZllYS3JESG4xSVJVV1VCSFYw?=
 =?utf-8?B?UC9jcHpDN2V1c1pjQnI1WHB2Z0t2M0dURkdtVkNJSHRDY0o5dGt1T3MyS0lo?=
 =?utf-8?B?U1V6b2VNdEJZMExJdkdSQ3VoSWtWckpUWWtmb3NwVC9XU1hCZC90SEJhWGRR?=
 =?utf-8?B?TXR3YzM4UlJjdXJpRE5veDFNQmtZZWZmMHVsb0dkRVYyL2dZVmJCakx0RFZo?=
 =?utf-8?B?L0c5U1kzMm12VTR1cXlMU3g3dzB0VjE5a01CaVQ4Uk8zaE1OcXJwWUwrNitG?=
 =?utf-8?B?THIydnMwYkM4MWN3WUR5dDhKQjJ4Yi9oek9EeHZvR1BsZGdPbVNDQlNURjhX?=
 =?utf-8?B?YU1zT2dOSVA0R0ZtZk9HSlE5ZGlkUDBINDZHM1BtaHB2YSttMEJnUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a991a6-f721-4fa4-280d-08de8a6e94e4
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:01:08.3186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5f0EO4aa6RyfKodscHIFqum/4B6j3WTDsEOqJNRrjfJRe+9klsERsDXka6g46wO0pFi3xR4yHAWC/RmRhB+Eqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6097
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

I think there is a reason, which is that it weakens the strong typing that =
we
have. I think it'll be better to have this be

    fn write_dma<T>(&mut self, view: View<'_, Coherent<T>, [u8]>, offset: u=
size) -> Result

once we have I/O view and expect people to create cast views into bytes
explicitly.

Although, given that we already have APIs like

    fn write<T: AsBytes>(&mut self, value: &T)

I'm okay with putting this in until we have a replacement solution.

The fact that our current uaccess mechanism is untyped itself is something =
that
I dislike (it feels a step back that C can represent `arbitary_type __user*=
` and
we just have a `void __user*`). It's on my list of things to fix to make a
generic `UserPtr<T>`.

Best,
Gary

>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
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

