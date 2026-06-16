Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40E7CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 07:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E8D10E896;
	Tue, 16 Jun 2026 07:33:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LLG/NUzY";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0176310E899
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 07:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muRSNqefeSe58keo+hOWaOTcUDRi6JOlFh4rvBPUXS8jxDU9YZWcehcU7yy8Y1nPALYkJ8H5a1UBjFetVLGgSe6RgrRlpkYtOmPJAHDikwnc36OfA75LnvJvbTxwXgUvMeG7o99+Hc7icqI0ZsLnnasY3eAtUVU9FRehzWUTxJsjlj/eh6wYflxiaCFWSYxht6jfmq8HvM4sT3FqpSw/4tJJw6iccMvQwOUZkqJ3dWSPFb5glnaFbbxKcMaXSBMamtm+uv6ojgOHWofbCRMMr8itwSVbnA3bszWCZgXCz4hIKqAI0ar8gqtVUuxiS7zXvKlBnvqPdr+BcCT7f922fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pT+3QEMpNYYVP7QKBmb7WuRzLmB6eNf+yNA8Cf5mclI=;
 b=WiwmoA3BGjkuiGYSv+T0L9HoqHDl6Iu7ZuZLSQZZ8L/Ky8NUzNc+lZS3LXaUWm3vzqsCuvMe2GaTIHWJ/zIbAJrxfJoH1BRQb14MIsCRKT+8Owxm7v1pYIkIZ4KdnP2pTL+pUF82VLOQFDnNFAvPqFejhZE1l6/JdIM0GCLByAdVKZQ55M2FWANxjdpNfHOJt2eURKQjISuJSZYb3Pd/+NErMduMKN0F+04Y6qHeICouDXjnlDj2BbjYC1iVYhfZp/sdMqfWXnx6soa+svN4qe0MTVYFP69RDzn61I7RZTQwq0xbYmDkOa5vBGw+alFFRRSTDhf8+PHC7MTDjyt0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pT+3QEMpNYYVP7QKBmb7WuRzLmB6eNf+yNA8Cf5mclI=;
 b=LLG/NUzYKhYpGJGqaf1DqoLszqHCpFZP3kMpA0vrgS3A/B5f5jY+2DoFozIR7e3vGvhooxBY5a7Hp+CYEF9MP1QdOiXwOrVoO32XQnTg7y5CdQnDE86ZuLK2us2xWjuxR29SVsJpMPlbau5oLONdVlj2mKRcMCLsmvyttTufs2xI6gS1n+4vUdZrfFgIkI0C/LCw/ptY/z9pjT3zH7RVM/tVyhkFoT2hdr/mNMGkjcxv3IY0YWuRV9mG1Y3WjMKkI7nS2bYq2juKsvMyOIsCW81YbJcoqD/l9ChSVnhI6IqpxxxGWDITkMfKzcJXf680z+KR5G9Z9Jq7AJW7SwmWwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 DM4PR12MB7622.namprd12.prod.outlook.com (2603:10b6:8:109::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Tue, 16 Jun 2026 07:33:39 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 07:33:39 +0000
Date: Tue, 16 Jun 2026 17:33:33 +1000
From: Alistair Popple <apopple@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 John Hubbard <jhubbard@nvidia.com>, 
 Timur Tabi <ttabi@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 01/13] gpu: nova-core: fsp: limit FSP receive message
 allocation size
Message-ID: <ajD7wnvZOxfXM7AX@nvdebian.thelocal>
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-1-f2853e49ff7d@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-blackwell-fixes-v1-1-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: SYCPR01CA0004.ausprd01.prod.outlook.com
 (2603:10c6:10:31::16) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|DM4PR12MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: 3309b563-4f9c-44d4-a0d7-08decb79955f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: gbjlE5w5I34huyKtMOawBQKGPgwXil1zmbWkz1U/aMlmruBpcIzJJ70O3LP/cSCPvr9Gq/R7fEzXoNvUWHgQRC6Y7ooyQBdL4YIi1VZQRyencX6Zgc3b3XJvPrPbjOoqTs2RmQ2LEagSFjd3XHJVH0Emxne9+WSBol9lYmPF9OCkQ2ieqQsWgdPBDOHRF+6k/Phs/mKtmOSDJXr8QvvMWc16FFEdTUVRlgsPUfnqVFRFCnUn+IbdPqduRp19bg+A0pxdsitJu64d+XmhG+GtPlexwguUab/sBX8KPz+/9aSdTBozOhzOXKnlhTXMCRvlqJyLQy2w3/KPkvoNseJKS/uR80VdEHPdGlumzBcReOai6TRhuYFB0qA1QbxTEnHktHgRTNkKtZnJ/GrktVBc/lI7lerqw17ze0NqRCl50N+s+FaguIVcsfK8qqp9uYngw/WVelFcl/gbahSNODuSF8CzRJK5OAQ1RC9OBtsbozESH3ja2nwYjHSThWv+Dol1ALF5anz35JqbGswaX2SrwdVFo7QwxDcfmigDvT9t3cj6phHNeQXPghSJhDGtX6+N4Bj4dfa6FnM5+3ZRbkF4cOy3GufVxaRvdzysNWSQia5hFnOoy8ef75qgvyOpTyLsEIHc0KkJuDLHsh8eCifQdySI9S1CqJkSx0PIqN+gbJPUw3cTztsv8TTd6CHqmroh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6nupEtS/e+IFBMUROdd9qDofBTrfQOwBsosOSLF/gEexd7+xP2DcrDITd/5v?=
 =?us-ascii?Q?LSF4pixxhk5X74duB2ADbGd3aYZmPAdtIoVDbG4W4h16+A4hGFI7MEBga+QP?=
 =?us-ascii?Q?cIozVlXU+Zi9ACC09QaOXg2z4vLO0dPDQPLc+diBCfiN7XSJPkjPfk9ZTyAF?=
 =?us-ascii?Q?gmLHLV2esMd1bVbnTEbx6P8TuldaNQ9N1SLw1sZUYZZvvTXiNti9zH3GRSq0?=
 =?us-ascii?Q?3j4ehMtU8G7QjOhXPcrXZw8mytl5V6flgui7PcVia/0vopfZQ808vzV7jP2F?=
 =?us-ascii?Q?5JQ5EtlMhcl4mVDzeJC+REstxUO8m5uBZbzyUGt+FBvh13SOPOJ/ysPScFHL?=
 =?us-ascii?Q?lkjLDIyotOL+l9vT0OtFDinVPlc+aR0VJfnTyhWGBD2nPUQ72S8TpAV2V7aT?=
 =?us-ascii?Q?nIiv+Zyw9HGDGC0NZYpUxhlyWqGlR2tq7XO/N/Ee5x2N8lfCqDJAE3gZ3x/q?=
 =?us-ascii?Q?bOBRZkXfFBq076kSEzOKyhX88w0bxviHeUejbyzjjtcHRAg1oQelZz2SBEbm?=
 =?us-ascii?Q?GC7XnenkFmZVxxDNg/3qKeFTHBiKnxJG6wtcQaxjMrev6qkWqnJqgAZF9NfX?=
 =?us-ascii?Q?iglsFsCwkQsfSvxiN3EGJtW5uKdfl0DeW72a+u/VH2sDcFjC2m6AhMAittPv?=
 =?us-ascii?Q?Qv/VLaWqfa3CSmf3I20DceLvxUUt5Z7cHxKs/kr64kfrADP7lqXglMxDkCrJ?=
 =?us-ascii?Q?DbPem5HjQp+uH2AxHLlc91y1q6tW/NzSTje6E6/c35pkALFfLgB74bSxHoEv?=
 =?us-ascii?Q?z3Iyd2u/t8nD0vWOUkfMAwVI80iRI1y89jocjf9ncNoSI3Sjfehk+NBp8ah/?=
 =?us-ascii?Q?T9hJ9vA3QpajE5YSzX7RxeBOd+782fBhfDCd9tupv3mMYrVOfJ6fJWoUrWX5?=
 =?us-ascii?Q?E+I8YuOZzZDAj7e8IHyrYhA0E82j9Hs0QYXF/XYTuijZmBrG0UkGdsLc1obR?=
 =?us-ascii?Q?ZyzRgWQmUGqzyp5C12EcZ2kGJUW31JbdLwSsswIP14orzRxdgoYBR+w0vU6+?=
 =?us-ascii?Q?UA420xWQls5J9pUhD8bLGtYPbR0HyOWoaOa+ATi1OJdaww57dfLtxwXoTJ4V?=
 =?us-ascii?Q?z1Vi4OGsWk6PRpRN/JEQKbgp+iKVPebgoJ4QbLnSajmoAXt+q1P1YOTbIoel?=
 =?us-ascii?Q?YCPRhlMwblX0UXe0X7hNxLeoweTsKNoFklU+jbSc4QF0cHj3/dceUFzEhZ9F?=
 =?us-ascii?Q?99FfGQXkiN3UFn9q/aJSFs5Mh5c5Ibind8ehPFefVD/nsPmi1OVKjff7MY0B?=
 =?us-ascii?Q?o9vluZL08JeoGesQ9fh3xMbtMC6zq9ODXYzMJpfUps1fyUbJXv5gzEH6B4K0?=
 =?us-ascii?Q?JzPFAhbF6dcCrri3DeKT/Ag4jVZT1w+/5eIkiVlVW8vwgWe4zB5RrmyfE07W?=
 =?us-ascii?Q?g1fWQWIsESAbZGS6QE5yFUMBTbMgXs1EKvZNFOTL7twynBPd40NmL7MO/A9S?=
 =?us-ascii?Q?IAkr4t7vGGNl64u3Ijs8ws88feWnZ+/HEU+2UgL+tg/QfWGssURcHJATf+Hv?=
 =?us-ascii?Q?N1e00ZSnJ94WoscbZGTvHTGO39m9C8Yr3fXAGG1AKqjPmMUdqAH2SyP8CnRO?=
 =?us-ascii?Q?OqKhs8czni1diMxgjP36gwUxltywErBWkdRKPqTtEdDJcaMpUPjJz2pjpSCB?=
 =?us-ascii?Q?5ikhcJXOBAnbL77sghks13jRM1XhzJpSmgkI+7kvIqu61K6ss/TS/iWYiiVx?=
 =?us-ascii?Q?PUtmQHZWfgulGpNwjUQ7SqwtVL9R5krh/awdoScGQN6Yy1LohkCsPlqAthwK?=
 =?us-ascii?Q?IGzD5nTOAQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3309b563-4f9c-44d4-a0d7-08decb79955f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 07:33:39.2624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9wTM6Fg2CV4aFYIQ5ZQBL5RVDI2KqquqFWLCA2AvNe7LLsKlbO0WTRsJnT20ug5EUu4Nw69NqVmehWepw1ETw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7622
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

On 2026-06-16 at 00:40 +1000, Eliot Courtney <ecourtney@nvidia.com> wrote...
> Currently, the FSP receive message code will try to allocate whatever
> was sent without checking it at all. But the actual size allowed is
> limited to 1024 anyway, so discard any messages over that size as bogus.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

I've read through this and it seems reasonable to me, so:

Reviewed-by: Alistair Popple <apopple@nvidia.com>

> ---
>  drivers/gpu/nova-core/falcon/fsp.rs | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/falcon/fsp.rs
> index 52cdb84ef0e8..e7419a6e71e2 100644
> --- a/drivers/gpu/nova-core/falcon/fsp.rs
> +++ b/drivers/gpu/nova-core/falcon/fsp.rs
> @@ -35,6 +35,9 @@
>  /// FSP message timeout in milliseconds.
>  const FSP_MSG_TIMEOUT_MS: i64 = 2000;
>  
> +/// Size of the FSP EMEM channel 0 that we can use.
> +const FSP_EMEM_CHANNEL_0_SIZE: usize = 1024;
> +
>  /// Type specifying the `Fsp` falcon engine. Cannot be instantiated.
>  pub(crate) struct Fsp(());
>  
> @@ -149,23 +152,32 @@ pub(crate) fn send_msg(&mut self, bar: Bar0<'_>, packet: &[u8]) -> Result {
>      /// Returns `ETIMEDOUT` if no message was available until timeout, or a regular error code if a
>      /// memory allocation error occurred.
>      pub(crate) fn recv_msg(&mut self, bar: Bar0<'_>) -> Result<KVec<u8>> {
> -        let msg_size = read_poll_timeout(
> -            || Ok(self.poll_msgq(bar)),
> -            |&size| size > 0,
> -            Delta::from_millis(10),
> -            Delta::from_millis(FSP_MSG_TIMEOUT_MS),
> -        )
> -        .map(num::u32_as_usize)?;
> +        let result = (|| {
> +            let msg_size = read_poll_timeout(
> +                || Ok(self.poll_msgq(bar)),
> +                |&size| size > 0,
> +                Delta::from_millis(10),
> +                Delta::from_millis(FSP_MSG_TIMEOUT_MS),
> +            )
> +            .map(num::u32_as_usize)?;
>  
> -        let mut buffer = KVec::<u8>::new();
> -        buffer.resize(msg_size, 0, GFP_KERNEL)?;
> +            // Don't blindly allocate more than the maximum we expect from FSP.
> +            if msg_size > FSP_EMEM_CHANNEL_0_SIZE {
> +                return Err(EIO);
> +            }
>  
> -        self.read_emem(bar, &mut buffer)?;
> +            let mut buffer = KVec::<u8>::new();
> +            buffer.resize(msg_size, 0, GFP_KERNEL)?;
>  
> -        // Reset message queue pointers after reading.
> +            self.read_emem(bar, &mut buffer)?;
> +
> +            Ok(buffer)
> +        })();
> +
> +        // Reset the message queue pointers regardless of outcome.
>          bar.write(Array::at(0), regs::NV_PFSP_MSGQ_TAIL::zeroed().with_val(0));
>          bar.write(Array::at(0), regs::NV_PFSP_MSGQ_HEAD::zeroed().with_val(0));
>  
> -        Ok(buffer)
> +        result
>      }
>  }
> 
> -- 
> 2.54.0
> 
