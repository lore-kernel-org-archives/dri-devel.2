Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3202ACD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9044110E6B6;
	Wed, 10 Jun 2026 17:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="PByJtvA7";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020113.outbound.protection.outlook.com [52.101.195.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B46310E6B6
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 17:45:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaionnMH6uE/X733Is7Z7mHbeHuPuH39DY88a/Exvsa/3H7as/Y0U8kgKXd8FpBE92Tp/sAoFLeGO8sBSiMjubIBrbhqVgtDq911SXCOzDydV5lExxHllmoPBI7inlCAQtyNZE0DoI6VvEkBdhgMMzIYf/tdyTJFIAzhoGA3v4U1tGYyOxNhUCVZ6VzZDLHvxui0qMkBn18cvs1f6mDsrTz7NRvGLmMRzApt0z8jl4l+ZVcB57Su29yWxZoFS9fqvEYxbAxNhJLYHjtVQkIGyWet3BRd6xOSsR3mOoWeOYKPSQsP3gqJazDJBHdX8PZZb0oFr35hPs0fP4RVUHstAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSqqkK5oePaebfrqX2UyhFv1D+oY56hkm2z3mXOid3U=;
 b=KPSDFA5lC7lgxChh4+iU8auJCM1PzijFtc1Ifbgf1Q/FVvYCF6pY9ixs6g5RyyCn0Iw5jQ5vkulWvhrSIctraCTd2FdpWze0LK2jLDhpp+6R0BqCjggHhD3MD2UsQWIRD7MGOyZMeyPn7+Hswq8ByPgWDrY5Zj7aNb/OprTUMdJwBh1lC6qscnE0NkOQUjsvDMmisFZtH+AbftbSnUfiTTgLC2xYAxNvYjy8UdenmOv4BdUjx5aytRTaxy9Y/nvEOdvifx3CXohf5SErVmFLUuN5AKlD3slKpWorgOg7BoGMpIvFPEjXKk9fAFGyyoV0vOy+Yigo1SDEaDbPekS8gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSqqkK5oePaebfrqX2UyhFv1D+oY56hkm2z3mXOid3U=;
 b=PByJtvA73avPyCm4MoJbZl9aCiYdOliCTAwUUi9kkhTr71+z4G523DsaY5fqnlTyFlkXBSAa4L53PuQQzc/PdmX2D91RYln5qoWF3J3rjpie4QlwiNFQTsUjIcre8vh77etwDIKCa5szPj6U5O4jS7s8GZ5//Ao6cJKbT+YinSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWLP265MB6403.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 17:45:49 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 17:45:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 18:45:48 +0100
Message-Id: <DJ5K24CQEBEV.2P4DD375FMQH7@garyguo.net>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno
 Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] drm/tyr: remove imports available from prelude
From: "Gary Guo" <gary@garyguo.net>
To: =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Gary Guo"
 <gary@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260610141359.1033755-1-gary@kernel.org>
 <20260610174352.7818-1-work@onurozkan.dev>
In-Reply-To: <20260610174352.7818-1-work@onurozkan.dev>
X-ClientProxiedBy: LO4P123CA0303.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::20) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWLP265MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d65e68-5d42-4892-e015-08dec7181ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|10070799003|366016|6133799003|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: xMdmaMWQ3zdpEx1jjTzW41wn1igdAi8De5S12TBPnLYN9KnIKVbyzp1tfqpw8x+hOnPZ0SnAPa48UmfVtaft7UXgFtq3frl8f1/8gcxsVCx7YDk5j+sP9z2W4As82BQ53LR80Z3Qz5CWCROTnFUatiAcbAPlOhNYVYMZTZj6YUvtnLxLnEwL2eQr/0BJLwZ0NxesnmRIckJdpdMIOc7uEGZczZhy7jgwLjOwKuL6HArwqE7a9ywQhrISEM2RTLLcrvslCMmagYAvpLc0rG703f6j8XQGlSV0sBmkbfHQ+LSjtL/siwVvxi/SJb9DGDPxqrGoQHUUptxxAPqMWQMQk0GeEu1Ut3RfVZpPyZBrdigkk1wMe45PX9JiQhtj2j+s+vi57YEdeQPHu4IMxdsHw1t9TMOcE5RiHAAdFH5JnYVmU/6tRO1rRNQswtd8Re4n0AKQKC/frwkn9p7y1xMGEo7TOAIHFg8TOG8wINmV2QwKmcjawD3O3elxtBbzsvEyIRgtM4GSW2QpUOBo3T0jB6+Qw/WZ1W1QQOBj0hwuWMcyZNXILUf0e9vCp4z/nZT6mN8lUT3JUTfuX5AWq0LXhayCwtCr52ZsH0Cw9I+K4DBAAX0wDayiwxWO8Me7XkzecCJ5Zkv/LFPxfnC3dj9ENXJ1ooC8Sc7b6Y+lmaJZkne1FUevdR7aGQiGB0vcgMpq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(10070799003)(366016)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmoxUVlFU0xSNmMyUFZ6MUtqSHNSQTJPWVI5QW5rV0RNRTg0SG4vbllGTUJi?=
 =?utf-8?B?OG43UitkUVpoclpXMG1UcVpNclM1TlY2N0lJZG9rdDFENjNEbyttZkIxTGpC?=
 =?utf-8?B?c00zMUdpb3hGMkVid01DUVBVRXhnYUpOOHpLR0JaM0lyYVBFSEZhZnVrZkZ0?=
 =?utf-8?B?R2MyQituUlg1MXViVzBOL3RLbnY1bzFBTWZIcG1lb3RUa2VtNFZCMFBxUTht?=
 =?utf-8?B?ZGV3WUZJbnE2T3NKVk9vK2VCUTJrVG5SeGpoN3IyNU9IOUd4SW50eDBjQzA3?=
 =?utf-8?B?VHJ3a2FhTm1JbzJrclpHdzZxS2F3b2NOZzQvMElObEhNWmdxd05TalNKdTYv?=
 =?utf-8?B?dWpBaGZCUUhwRWltSFBIMEZhandNeEo5aUtLcHBmdFlzbGh2ejNCSTVsRThl?=
 =?utf-8?B?emlnYTlTRWlQN3FxMEFwN1EyRUMwZjV1bVBpdERCZkJNS1lXNml2R3p3ZkxI?=
 =?utf-8?B?QlFyc3pIcmRVUGN6M1VteDFmU1U4OXp6bDdpRWZjRHVCdkY0emRRbC9IL3g2?=
 =?utf-8?B?aEhnUkI5ZUdqWUp4bXNHRnZWS2Zxc096ekRlakR3Z0ZwZ1NBRTRvcEh0VGtK?=
 =?utf-8?B?UnRudEVINzJNOS9ORWVwNW9JelV0QlYwdHk2WDVEdDFqdHFJajlsSDU0dHJD?=
 =?utf-8?B?V09WTDdQYVFHWDkzb0drU1VIRjErOGlub204b1E3UmhSVktzNzREYlF1ZVBF?=
 =?utf-8?B?c0RSQVorN0tyMituenNNQUVGTUMrZjJDZVRNaEQxN1JmUWJUenRuQVdwZHha?=
 =?utf-8?B?aXhsRWpwckdTV2xHWEFLNUxJbzdOY3l4a20zNjBHZG12VEJYcUhIZXlaOTJE?=
 =?utf-8?B?VUNaZXZTeFhnUG16VW1wT05GdUJiL0dZY1l4Q1FlNWlzRmZoNDhyNDB2WXJT?=
 =?utf-8?B?Q2ZPeGcvcytGZEwwL0tMUVBKYjRHVlFsUHpKME45TmZqWS90WlF1am1pZU45?=
 =?utf-8?B?NEpqU2FMQnBJRHl2ZDJVWTh3ZVZJVWF5RnpYQWxNKzJNeEt1a3Y4Uk1XV0JE?=
 =?utf-8?B?MElNUjAxNDRNUngvN0kxdDVvQmQwTHdYSjM4UVluamRhOW5tT0pPVDRqVkZN?=
 =?utf-8?B?WDBwMXFPL2V3bWZ1QXpSV1NHUVV5M3ZoZWNpdnd0d2dWM3FwYTlmMHdxRDZz?=
 =?utf-8?B?QlI2RnZyQ0tFdjF3VjBTUENrNTRNVE5WV1FqVit4THlCUWVhRkVGQWh5a1Zx?=
 =?utf-8?B?bXltYU5XZkhIQmRUWkZFRjh3eUljVkpWaVhDQ0o2eU1IdWFwakMydDVQOHds?=
 =?utf-8?B?bjNLUmNrWm5GUlRUaVdKUXFWNEwvRUNHTXREdmQzUUIrQzZVRDM3SklvamN0?=
 =?utf-8?B?SktuOFV6Nkt6VlFVc0JPeVRiNmxkSjh4anQ5L3VKZElUWUVCaFcrSUZwS0hw?=
 =?utf-8?B?ZTRKcE5IS1FYVlQwRGQ3anFOSnhWak1PcVdsYVNwTHVFVzdhZ0MyRmNCeXVG?=
 =?utf-8?B?L3Jjbi9lRzA3T1JSOTIzU2IzcVBQcFFlNWRpS3lOOEpQdERqbUhrMmY0UG90?=
 =?utf-8?B?ZnZ4SjgvaEhEK216QlBqNjkvTGFWOS9taU1rajQzbTcwN2dOV1AwOFpsbjV6?=
 =?utf-8?B?Qy9qcnh4dmNTRXVmMFVWOEJmNEI0ZGE1UU5iTklKWTdjZ0dTTGh3eXJVVnd4?=
 =?utf-8?B?QzhScW8vUEVBR3RvdFBkN3NQQmI5cHB5QWhqdlVTTmpHOHRVdFBIaWh6eGVj?=
 =?utf-8?B?UHJ0WUFBajV0RkJNVW5tOEtnWXUzdVhjbHJKQXBEQWt5S2dLUlhYeC9tMyt4?=
 =?utf-8?B?YlJtTGFKbm0rU1VpalBlMXJvZHhXMlRycjlQTVE5SlFZdjYyd3ZINHJNQU9h?=
 =?utf-8?B?dzZCQkY2aFNhS2dqbVMwRFFkdG1heTkweGJjbGMrQkNmV1hWVE9HRVdoNTNY?=
 =?utf-8?B?M1NsQ0VSV3p6eWJza1RhUCtDVXovMDdQR1V2U3hFRjkwdzhJRDdHeERtTlZO?=
 =?utf-8?B?REJjMlBTK284UzhvZitNZUtkZ2RiM056dXhZdWJweUZweUxRQXpDbUFlUkFp?=
 =?utf-8?B?TnBHVEVDc0RCVWlXU00walNtdlR2OFBuVFZYOStDUVNCU3JRcXRJNnlkZkpC?=
 =?utf-8?B?c2c5OHRFaVhGVjBnYWwzNFAwbkRtblBadUplVUVNbHpzc01NcllVSzY0Q3hU?=
 =?utf-8?B?dVFRSUJlalFVV0Mybzg0WkhRajZLQmZmc1ZNT1U5TU5DS3UvQlAva3RtbE96?=
 =?utf-8?B?OG9wUFlKOHZ6M3ROUVBGUlErRmpIcXRmdmhhOFhHQVpUTW0yOVg4dlpMWXdW?=
 =?utf-8?B?MHo5WTNBRWFYVGxHdjg4NVlvcVY0cEx6bGVGTlZEVEpwbTlJQWk4MHZOWFJC?=
 =?utf-8?B?RlJvUkJscEhIQXM3bkMrbVRoL0wzQVA0OHV2am10cnVJb1FlUGdyUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d65e68-5d42-4892-e015-08dec7181ba3
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:45:49.1061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfIaTXhjEESgmKwL2lAII59KCTI2e3unrwNudymffk/WwzpSw3dNs75TDb3HD8LJ29KX23xcbcRVB6NBTMNpWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6403
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

On Wed Jun 10, 2026 at 6:43 PM BST, Onur =C3=96zkan wrote:
> On Wed, 10 Jun 2026 15:13:58 +0100
> Gary Guo <gary@kernel.org> wrote:
>
>> From: Gary Guo <gary@garyguo.net>
>>=20
>> No functional changes intended.
>>=20
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>> ---
>>  drivers/gpu/drm/tyr/regs.rs | 14 ++------------
>>  1 file changed, 2 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
>> index 562023e5df2f..831357a8ef87 100644
>> --- a/drivers/gpu/drm/tyr/regs.rs
>> +++ b/drivers/gpu/drm/tyr/regs.rs
>> @@ -48,17 +48,12 @@ pub(crate) fn read_u64_no_tearing(lo_read: impl Fn()=
 -> u32, hi_read: impl Fn()
>>  /// These registers correspond to the GPU_CONTROL register page.
>>  /// They are involved in GPU configuration and control.
>>  pub(crate) mod gpu_control {
>> -    use core::convert::TryFrom;
>>      use kernel::{
>> -        error::{
>> -            code::EINVAL,
>> -            Error, //
>> -        },
>>          num::Bounded,
>> +        prelude::*,
>>          register,
>>          uapi, //
>>      };
>> -    use pin_init::Zeroable;
>> =20
>>      register! {
>>          /// GPU identification register.
>> @@ -964,14 +959,9 @@ pub(crate) mod mmu_control {
>>      ///
>>      /// This array contains 16 instances of the MMU_AS_CONTROL register=
 page.
>>      pub(crate) mod mmu_as_control {
>> -        use core::convert::TryFrom;
>> -
>>          use kernel::{
>> -            error::{
>> -                code::EINVAL,
>> -                Error, //
>> -            },
>>              num::Bounded,
>> +            prelude::*,
>>              register, //
>>          };
>> =20
>>=20
>> base-commit: 7d570075805918f5ec33f03949c6a7c610397340
>> --=20
>> 2.54.0
>>=20
>
> We will probably run into this again in the future. I wonder whether ther=
e is
> any way to catch this kind of issues automatically. If not, I feel like t=
his
> prelude pattern is not doing a good job on helping.
>
> Thanks,
> Onur

This is all caught by klint.

Best,
Gary
