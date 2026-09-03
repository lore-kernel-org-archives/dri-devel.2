Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC29C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B84DE10F680;
	Thu,  3 Sep 2026 15:16:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="z1Mj/uER";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021130.outbound.protection.outlook.com [52.101.95.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E307710F680
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 15:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5hrN6jQM63ymD+cUOEnk1vE6bsTJtnIIs19TLksWH72naEh33pWn2YaPyEDqGGmXTPMEKnjbEButM4JYXeuLwuh7lXkCMWtsEXSZCNLrGbKKdlLrMDim6igD91OrvXo+9kdCtW4IgoqCuhHIIJGHeIZrCqTpRBvK6yQDlyZNCoBhGhchYw4cML22dMEXrvcZb7nVu/S6bmwzkE6M6F2mgwB/27XelEritkrDjZrD674mlUbmzIQqeva2Fkws9rCqsadCNrVNOTba2/lsVnPS9nlf5dPJfd9okGEi4Eq/5lUxlI6eHOIvF/V0lJzE+rWyx6BvjFRk6IKITmQ7D63Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zm2wWVsSQ5YUG55eYH6MZLF2Ns6l/0nbprFcwtjEKNo=;
 b=itlFCBuujMhOuYx2q/6JmdstX4fnTmD1LaFJKhl1po2OB9rhRugsH+4iD8x9Y0IHwglgUDMGU1FBAcNZKot2Y28OVH0rTbj+wYfJ40POBPHae+Nk5TFRGGzeksFA2R3RIK79MOx1igM5HnWLFwsD7oAhf2AajzZ4AErGkgnMfYM0nT0eAWdiT2lmM8SadktM38MI8Lcl1rcWdZYjGBOmsoKzjVA0ekbpQls/YImaw9yypunDQeo32n/k6HMgkXSbKSXecnodnd9fAQTz02bDuUUEqWUimEOcyNMLG9cXhLVLDkYLW3rbchzVBV4D5Y2dTt/YJEuAE9CFUHigZ0FKRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zm2wWVsSQ5YUG55eYH6MZLF2Ns6l/0nbprFcwtjEKNo=;
 b=z1Mj/uERrnudvDP+uPIeLm62cKbypMsGlmu6ixYBUW7T16Y/20HvqPqCvmhyFqKJ9zBB5uxwrhOCX2ORg2nrpuMYTnUCIHEatU1lLji8f3hVRDZk1SBtuI1pddrOO9jEFcgE5b2A2ZTMMIWhogkzwAjck1lxG1U65emGuAKb2tA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO4P265MB6982.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 15:16:43 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 15:16:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 16:16:42 +0100
Message-Id: <DL5S49RMWZ8B.MI5VAR7NVSQ3@garyguo.net>
Cc: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <tmgross@umich.edu>,
 <tamird@kernel.org>, <work@onurozkan.dev>, <mmaurer@google.com>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/4] rust: debugfs: drop 'static bound from ScopedDir
 file creation methods
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260830193824.471089-1-dakr@kernel.org>
 <20260830193824.471089-2-dakr@kernel.org>
 <DL5PH2S8AP7E.25CW1PZIQ8BM3@garyguo.net>
 <DL5RXJCC43FY.CACM7A2UNBCI@kernel.org>
In-Reply-To: <DL5RXJCC43FY.CACM7A2UNBCI@kernel.org>
X-ClientProxiedBy: LO2P265CA0481.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::6) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO4P265MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5d9ac0-62de-4ae2-6f86-08df09ce5cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|376014|7416014|366016|3023799007|6133799003|10067099003|56012099006|4143699003|17002099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YsYdp69Uwm5V3wQj3iI7uFPPo8xlvWqtjnSEIKuVjtZneb1hHJ5tLEYwSCJUdHgVVLXGSHW6uM3//qS//GlzvvCmfvSFk/NKpCN3ERsYOOObNlJ1am1TIbDnSHwI0RWEedsPgxVvEyQKh2/lr4tH8j0s3pduF4nmcnC0DjO4PsRwDqLWKttwM9WfybdAJdrMsooZZ/RE2FsXnBqXmV8hE2hAPawBb7b6ii9QHo+f+5BSKsn5ry0RlV5K9G34ZcFAMaZTYJbfvqbsdqVdPzj+P8Vfj1gAbG4Krb0LIDgTLZtZT5L2NY18Q5xMncGdFcRQSNbm50sMXNQQncjNexMJTc6xXkuUQ5AbLWzShKXhFDh9BqF/cdpFiZ5Q4a4rWNcjmzRYJCpyEh6vZzSGJdDacZ7yVcn5osC37tyDiL+cqHK5R3qv2bGlFF5BxSjb/T5Pgst+0L/Yav7iH5ibk3nMPdw/Z1w3GEbWtBjfPE8c5QqtGwrpeqd57iCQclEUxGRKRZaY07an78IehvPW4Mz4a1DTHsIHDM0HQtn9OvzxljPbA+Zu4/NjEldkf8QlsBNG4TrrgX36YvWA6+VGNp9DNgPz/FAQDP6iXmKt/uDbAqnyeqFYFde7302queFI2Snf5GNfVpYENM560P5D2z8+ltCtSJWTlZ6FAiLEeEneNv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(376014)(7416014)(366016)(3023799007)(6133799003)(10067099003)(56012099006)(4143699003)(17002099007)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lzREZySnFzcEJIZkFBb1NQS3Y3Vm16b0p4UmpEWEN3MjgyMFlWN0JVSWlE?=
 =?utf-8?B?Vi9HbzdmWVEwUTRGYVB4dlJaZ0tJSzErb3krODM0WnkyWnBCa2hzNGlBT3pR?=
 =?utf-8?B?eXM5OGRFRGZ0cHU0SjAzTkxNUWx0Y0VJdk5rcEhrdkcyTjVYZUQ5SHRpWUNk?=
 =?utf-8?B?cnMzT1pxMXQyRlUzMG5aSXIyNVQwbnY1M1Z5V0xuNFNITlZMZGRsdGVRdEEz?=
 =?utf-8?B?S2VXdEw5TWhORm5TMGdOWUFqUGd0UnJGOCsyN0FzMTBYaUNkUGVoSUtKTjZz?=
 =?utf-8?B?cUs5eThXZHpZTTF1R1I2czNWZFJEZ3RxRU1BMjVmeWdmWUZkWTFHZlNmeWdX?=
 =?utf-8?B?ZmUvWHhmY3VaSXBaR2d5YUdXa1pwMERzWWVHNW9qQ2t5cittMVdYTk5ncmZB?=
 =?utf-8?B?cURmQlRMNm11MHdOUDJ2UlJ4cGp0Q21ncWZZcVRIRk1nL1dNa0NLWENmcExi?=
 =?utf-8?B?Y3NMZTZkc0xOaFdhZHp6NE95eURnQ0ExQmhDM29yRWg5YzlSZmJyNDFTWDFu?=
 =?utf-8?B?UFBZOHFDdzl1MzVldU9iTDh4YloyVStUODVzblNPMkR2dktBWmdSd1hZZGdQ?=
 =?utf-8?B?V0w3UTBzWHVwRVI3c0hjY2VIZG5iNS9YUVFTODdRY2Q5WmZGREl3QTE3UkV1?=
 =?utf-8?B?cUJjU2JaaDJqdEJzVmhCRWcxeWpsNzdCcVBsdTNoSVFMYWNNSVVYVWhLWDd3?=
 =?utf-8?B?UnFoS3hIVVVuRHBsTlhHd2dzRHpZWmMrMmdUUURReE9hSTIwNVl1VXJueEgv?=
 =?utf-8?B?TFNROHZlbGV0Z1prMHJCWmZIUTcrV0ZBYWJFWHN4cjkrYnBuaFFvY0J2TUVX?=
 =?utf-8?B?S05lbVRqMjBPNXVhV0RXV09GdUxTMHRoYk5XOElIS0ErT3lINXg4VVBhcjdh?=
 =?utf-8?B?VGRybDF2V3JpUVR4VURUVWljQjlOL0pESnpmbTZyVmVLNjdCYlRjZUhiM3hS?=
 =?utf-8?B?eFVhM0NodkZDd3NYbTFJcnQ4Q0xRaVlNaGtOYmpGNGpKaDMwcnZycXpuNTY4?=
 =?utf-8?B?RDRQZWVIa2g2QXpzOFJlc2FNNlhPajNOaENQa1dlT2hQbVZaMjlheXg2bzl3?=
 =?utf-8?B?U0VqVlF0ZXlkUEs4eGFUUDNSRlhVOGpmd1B3bnpVa3R5dFdyajNXUkFBUVB3?=
 =?utf-8?B?WVg5WVZvb2ZQQWk1OE13eG5jbXRjN1lUbURncEVSWjF5YmZyK1FyaW5ST0or?=
 =?utf-8?B?aVlQZmZRYjZjZ2EzUDdBR0hhRmczVS9DaGVwRGZRUTM5RVRKMTVxb2Rad3J4?=
 =?utf-8?B?YkpOcnF0NE1sT1NvdkxUTHhtTUlUMi8rTUlDSkRlWWFOL0w1SnB6U1Fxa3dw?=
 =?utf-8?B?SlBrb2d6MFRpZkpLeUNYMzY2K2NqSk1hUW5PSXppd1FjZE9qZFYrcWg2THIw?=
 =?utf-8?B?bTdwTDJIajlhYjNzZVY1aDF1Z3YvU2tCd1JvTlBudlU3M3JEWGY4ZFJWd3dp?=
 =?utf-8?B?dUc2VVFVeDZicXZUNzcvUjYwdFdIY1Fhc1MxeVcwajBJZDNzNm5LMzdQSXNy?=
 =?utf-8?B?UDVIU09ENVRTSmlmL01VbTNsK1EvcndNcE56bW15aHM0djNWeC9ZUHNGS3R4?=
 =?utf-8?B?SytTcXVjR3NTUE5jakRWcEI1TGg2M1MvNk40c1JRaW9FTnhHWVZRb1F4Tjd6?=
 =?utf-8?B?czhkYlhRL2NTSHVTSlZFRWtzQjZCQXpMMGQ5UG1GTk9JK2o0VDd3MDZFQTM3?=
 =?utf-8?B?QTZWd0MzR0pFd20waE91RnRETjJhM0NEalFGS09xWS8vN2JpYXZ6WUNRcmlD?=
 =?utf-8?B?UmlMK3hBTTJEdlZ2NVFqSGZWWVFXcUpkSUZEUjB6S05LVTY4TFBjRXZyMHJK?=
 =?utf-8?B?L01CRm9meHc5Qys5amsxU2pPR0xVMzdwN0VFenhxeVE2REVCa0xvLzdQTWlv?=
 =?utf-8?B?UWdFeHZCSzBtMU5MQkhmUUZWalFVYnFoT2RwRkRaN1BHZDBEaERmTUZVWm1x?=
 =?utf-8?B?RWt4RDhTNjVpd1MzNHpmL3ZXQ2FkcXpGOEpZd0hRWjhjUzlxenN2RkozdDNw?=
 =?utf-8?B?dEJnQlowWURHL0tKZUFWMnk3N2F1U2JmRGF4dWtaMitBbWY2RzliRU9BQU1B?=
 =?utf-8?B?dkpVVjlLYWdrN00vM3k0Zmk5bGU2MktTTTZySWZjQnM0cWF5cTlOY21oemQ5?=
 =?utf-8?B?ZnZCTTZPdm4zamtjVFltcHdCdTgzR0p3WWVrZDc4R2R5R2VuaXdkNTFseHph?=
 =?utf-8?B?NG92UlRzQWV4MWJmV1VVRDI0bzk5N0RQelEyQklkcnFGcFdEdzR3TGdqNHV3?=
 =?utf-8?B?ckVQVFQyc1hIcXBpOHBleS9oMitUamxWclYzUUN0MTd5bkxjcjVvVUtjbGFI?=
 =?utf-8?B?WW9pblVpOTJha3pyUEFGOGRmVjNJaTBWWUNwUDVoc3NCbFpqR2ZpQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5d9ac0-62de-4ae2-6f86-08df09ce5cc7
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 15:16:43.5597 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jU1jjshPJ/wEx0TURjQOk0Im/z+eJstwtejt5ly8+pfmCOIbWwiTnF6tTUdC4FnZmbHzdclBeZfdn0bjXYeflA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6982
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

On Thu Sep 3, 2026 at 4:07 PM BST, Danilo Krummrich wrote:
> On Thu Sep 3, 2026 at 3:12 PM CEST, Gary Guo wrote:
>> This can be better done by storing `&'static bindings::file_operations` =
in
>> `FileOps<T>` instead of just by value. That is actually better than the =
current
>> impl, IMO, because `mode` for example doesn't have to be in static stora=
ge. (You
>> can also then make `FileOps<T>` `Copy`).
>
> That's a great suggestion, thanks. It simplifies the patch to:
>
> Author: Danilo Krummrich <dakr@kernel.org>
> Date:   Sat Aug 29 14:42:54 2026 +0200
>
>     rust: debugfs: drop 'static bound from ScopedDir file creation method=
s
>
>     Drop the T: 'static bound from ScopedDir's file creation methods
>     (read_binary_file(), read_only_file(), etc.) to support registering
>     debugfs files backed by types that contain non-'static references, su=
ch
>     as dma::Coherent<'a, T>.
>
>     The previous 'static bound existed because ScopedDir::create_file() t=
ook
>     &'static FileOps<T>, and &'static requires T: 'static for well-
>     formedness. However, this was overly conservative: the file_operation=
s
>     pointer passed to the C debugfs API just needs to be 'static, not the
>     entire FileOps<T>.
>
>     Store &'static bindings::file_operations in FileOps<T> instead of the
>     file_operations by value. In each trait impl, take a reference to the
>     file_operations struct within the const block; since
>     bindings::file_operations does not mention T, the reference is promot=
ed
>     to 'static regardless of T's lifetime parameters.
>
>     Replace the Deref impl with an explicit fops() method that returns th=
e
>     stored &'static reference.
>
>     Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

Some nits below.

>
> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
> index d7b8014a6474..2beb55d444ca 100644
> --- a/rust/kernel/debugfs.rs
> +++ b/rust/kernel/debugfs.rs
> @@ -538,7 +538,7 @@ pub fn dir<'dir2>(&'dir2 self, name: &CStr) -> Scoped=
Dir<'data, 'dir2> {
>          }
>      }
>
> -    fn create_file<T: Sync>(&self, name: &CStr, data: &'data T, vtable: =
&'static FileOps<T>) {
> +    fn create_file<T: Sync>(&self, name: &CStr, data: &'data T, vtable: =
&FileOps<T>) {

I suppose this doesn't need to use reference anymore, but you want to keep =
the
diff small.

>          #[cfg(CONFIG_DEBUG_FS)]
>          core::mem::forget(Entry::file(name, &self.entry, data, vtable));
>      }
> @@ -550,7 +550,7 @@ fn create_file<T: Sync>(&self, name: &CStr, data: &'d=
ata T, vtable: &'static Fil
>      /// This function does not produce an owning handle to the file. The=
 created
>      /// file is removed when the [`Scope`] that this directory belongs
>      /// to is dropped.
> -    pub fn read_only_file<T: Writer + Send + Sync + 'static>(&self, name=
: &CStr, data: &'data T) {
> +    pub fn read_only_file<T: Writer + Send + Sync>(&self, name: &CStr, d=
ata: &'data T) {
>          self.create_file(name, data, &T::FILE_OPS)
>      }
>
> [snip]
>
> diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_o=
ps.rs
> index f15908f71c4a..5c16a3196ca2 100644
> --- a/rust/kernel/debugfs/file_ops.rs
> +++ b/rust/kernel/debugfs/file_ops.rs
> @@ -20,9 +20,6 @@
>
>  use core::marker::PhantomData;
>
> -#[cfg(CONFIG_DEBUG_FS)]
> -use core::ops::Deref;
> -
>  /// # Invariant
>  ///
>  /// `FileOps<T>` will always contain an `operations` which is safe to us=
e for a file backed
> @@ -30,7 +27,7 @@
>  /// into a reference.
>  pub(super) struct FileOps<T> {
>      #[cfg(CONFIG_DEBUG_FS)]
> -    operations: bindings::file_operations,
> +    operations: &'static bindings::file_operations,
>      #[cfg(CONFIG_DEBUG_FS)]
>      mode: u16,
>      _phantom: PhantomData<T>,
> @@ -41,7 +38,7 @@ impl<T> FileOps<T> {
>      ///
>      /// The caller asserts that the provided `operations` is safe to use=
 for a file whose
>      /// inode has a pointer to `T` in its private data that is safe to c=
onvert into a reference.
> -    const unsafe fn new(operations: bindings::file_operations, mode: u16=
) -> Self {
> +    const unsafe fn new(operations: &'static bindings::file_operations, =
mode: u16) -> Self {
>          Self {
>              #[cfg(CONFIG_DEBUG_FS)]
>              operations,
> @@ -65,11 +62,11 @@ pub(super) const fn adapt(&self) -> &FileOps<T::Inner=
> {
>  }
>
>  #[cfg(CONFIG_DEBUG_FS)]
> -impl<T> Deref for FileOps<T> {
> -    type Target =3D bindings::file_operations;
> -
> -    fn deref(&self) -> &Self::Target {
> -        &self.operations
> +impl<T> FileOps<T> {
> +    /// Returns a `'static` reference to the inner `file_operations`.
> +    #[inline]
> +    pub(crate) fn fops(&self) -> &'static bindings::file_operations {
> +        self.operations
>      }
>  }
>
> @@ -130,11 +127,11 @@ pub(crate) trait ReadFile<T> {
>
>  impl<T: Writer + Sync> ReadFile<T> for T {
>      const FILE_OPS: FileOps<T> =3D {
> -        let operations =3D bindings::file_operations {
> +        let operations =3D &bindings::file_operations {
>              read: Some(bindings::seq_read),
>              llseek: Some(bindings::seq_lseek),
>              release: Some(bindings::single_release),
> -            open: Some(writer_open::<Self>),
> +            open: Some(writer_open::<T>),

Is this change needed?

Best,
Gary

>              ..pin_init::zeroed()
>          };
>          // SAFETY: `operations` is all stock `seq_file` implementations =
except for `writer_open`.

