Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41EE2CD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A9710E755;
	Tue, 16 Jun 2026 10:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="aUJi/HMD";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020135.outbound.protection.outlook.com [52.101.196.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4764A10E755
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 10:57:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mph81yW6pgwb4LmmEjA2cE+97BIn4IOcQipXFjvjfG8ZrT99n0GSlI8/lXSmAAokjYlMQtGC9+lvSmaejjcW3J3pWxiTv3veFoJDirpGP3g77vbUtQgNdX5GvXErACDd9sqagLvvP0aA31hRRzrJF95spc6qKYVSmI92h4PDbWbryfQ/wYgne2hAc7ilHLJcQOngAMdkzhPWzQkPIf99MsQ+SfupOtxbDwGwChgjNsPkenUaZWlBaTp/8qf8PBUE8CNdQzGjBDESmOr3E6tVF8VI9Or1jXgEKMXwz4l/i/4KYtI76CHr1BazexeQN2zEuuJ8P/UgL3jYRQyqqa3+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwkCDzs/2lwsDwnr9e1IaDRn+tv6H0VSQnT0bdMlQUk=;
 b=DaKWA3ga+9+N0Ml5TkVxs64gb+qs5+aRNfLpcy4HtFB7J/0xuxTxj1k5iniBGEpCT4La4+TTfEuoksdCe4HyxEYmlJaP6NBowJcdiIfRP7jz+TROhzwcK32aO6BOLCwxn8TMb8wqEuX56VRhNTrrRWqcF00F9C+pezUS+ZZdzpLn5SvaGD91WB+AEPeJKfOI2XyTkIg36w/EeSLAPX8o+ksSceQA+Zaj9cXVDptWRhSHMbtijT4wIwktjtK5yW2GVK6wbTxnml81ZxmU/oF8L09NiJjCZNfJ8egTqbdrpfKA8Xqd3b0iOOlt0v7k7zHIHesUS7IBDIN+ISu2JHTLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwkCDzs/2lwsDwnr9e1IaDRn+tv6H0VSQnT0bdMlQUk=;
 b=aUJi/HMDM6w28yvYpLSOcIU6bkm2tLdRdLfKTyUGG/sDhTO6o9JNxNGY/d4TwYIPiefspCEPrbKqb1E9KAIzk17ntmRCOO9HuBty8XkZ2MC+NQnSZqQOHNq0banLylBIEIYq8ApApGSJI1xjRCYDRqK99dXmw3+Tu+rNsJ1Xv+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO4P265MB6965.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 10:57:04 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 10:57:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jun 2026 11:57:03 +0100
Message-Id: <DJAF4F8GJIWM.14MO2JWGG7OZM@garyguo.net>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 02/13] gpu: nova-core: fsp: catch bogus queue pointer
 issues
From: "Gary Guo" <gary@garyguo.net>
To: "Alistair Popple" <apopple@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-2-f2853e49ff7d@nvidia.com>
 <DJ9SJCIX1XUO.RTFCL56MKU0D@garyguo.net>
 <ajD-8-bp6Usjl56R@nvdebian.thelocal>
In-Reply-To: <ajD-8-bp6Usjl56R@nvdebian.thelocal>
X-ClientProxiedBy: LO4P123CA0389.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO4P265MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ddaccdf-e5cf-419a-18ff-08decb95ffd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|1800799024|366016|6133799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: erZOqNH6EMcwq9GJOFkzUHVgmGwntmZZeKyc3TpfASJcvolaypG//21dHkhfOL3gHFzr36ZxhRJX+mOVUPx+gdzPNyiHpVUwM5vIvD7hJzMoQsaW5OPlTpFsDH1gpdyWZCTfMnPB4EBIQPCDZ07e1iEu2t9HyL+y7fa1YRrdPyTJuHam7rhI9+VKpjHanAzRlAzjxCGrF4FHst18jN9wUohuqVUoSqq7f/VaWo27sf8CpmFnmTPZ5mWuFnBh4GSLOmAFdW2LsH85gNvZ6wsG+JoK/w6UmhFPuPm+j5w5fZlRvPayz/lk/Zb64Ij5OaaQERcg9oPnNtu4cWGTQrlxHTl/C4yv9NsaqFbTRDrmdNPbWcRI8IeBL6H8u7L+Syk+SPln82vyxkxKYt0TZfgA5MALmIfnbpc9ubHHPUcOEr364FZFh0aHeBBmHr0mJD+LRrtun8c7xqIrcCrSKgxkLF/iXv4kB0f0Np6mRijpsaVlG8RNzLupy8xT90sWyHB3rvq76YI++Bpmv6Gz34NanBUsl9jlXRScvIY8BvwObNCNcyneXSmqyOXo8VpmEs/+znZRLTDGRc9cWKPg+mu7ya8fkZLZ65DcmpE7vettmD5bB3ggyQ0X5tfrEOk6/we1IwAAblBrjdFiOb238Y2w1qmPjby2ZAenzpC5Am7rF0juWhiaPBwjltx4RJ1N9f3q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(1800799024)(366016)(6133799003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MU9yNHVLTEQrVmJIRVZsRmxyb2s1VklSK2lOMUtEN2QzcXVCQzlyMmE4ZEF3?=
 =?utf-8?B?V2N2Y2x0RHczb1YxU1RBWWJiNGlPOEx0TU5EcVVKZkJ5WnhDblVXMkV4dkVB?=
 =?utf-8?B?T2dpdnhuSUw2ZzZVbHVXS2NPRngrK3k1OHJMOHhpdFp0MkJiaXlDVGxCSEpm?=
 =?utf-8?B?UEcrdTVoM0F1R2o3aW9SRE9Pa2V2TGRuZGVYRnFmV3dEUzFxN01DK1h4LzI2?=
 =?utf-8?B?K1ZheTRFcHNTYmpwZmt5QXd5VXBuOVFFSHdNSk1md2NmcnYyM2swcWRZUElI?=
 =?utf-8?B?RXZ2a1F6S3loRVVTaXVaQ1Zyb04yVXpsb24zOHdPdHJHTnZydTFJQTdLQ1RY?=
 =?utf-8?B?TE9zWE9jK0hlSVVrT3BlaXlkVHZORStFUnJyZENlLzdaaUJMbU9UUjJ5UHlP?=
 =?utf-8?B?SDJIN29RS2xvMTRBSVZPRnk2Um9ScWtWV0dNZFRQa004czF2cHVzblhuMmpw?=
 =?utf-8?B?Zk1jNVdRRWg3U3J4RTNxSWZBYXF0WmUwMTBGYnVhY0FGUE5IYVFTTlltVHBU?=
 =?utf-8?B?dFpFR0pGMlVxQ3hDVW16NHNOT0NuTGNaNXNPOE1wMHdUUkI2WjdueFg1dEg1?=
 =?utf-8?B?UXhDeFRpRCt1Nm9xcVdla3diRXBvUWxpTlQ2cFdUeWoxNWw1aFQyMDYzQWhJ?=
 =?utf-8?B?TTYvbDlsM0QvSGxYeFEvOHZPaGVtaGJWeGRncWNrMmVZT1ZOWUdwcm94RmlC?=
 =?utf-8?B?b0hFSU5HTS9KcVZWUTIzMlROUWdob01MMFhUMVhpVVcvSUpPaXYwY0RUYXI2?=
 =?utf-8?B?VW9sWHdoZE56eW9vWlAra24vc3JHUHpndXRSVEtnUFNWYlpGR1FOa3hBTXlL?=
 =?utf-8?B?MzZUdy8vNGRsQmQzL2ZIWW1sK3hGbHcwdFNScHJkNTk2QTgwS1V1RU5KUmh1?=
 =?utf-8?B?ZHhHc3g3M0tpUkxkTlR3UkpOQTRhV3hva2hnMU8yaDV4blMwTnFibzhXYUht?=
 =?utf-8?B?cjZNRFhFR3BZc0loeStHZVozQjg4YThUcUh5dVNTK2R4cFFYOUQ4alBOU25a?=
 =?utf-8?B?T1IxcXlBck5QVzQ5am9xWVlrMllGWmlaUVl1ZGJIT21UVUJib2VoRWYxQ05Z?=
 =?utf-8?B?UVNTZ2pVaE5OcG4vcVl6TzdRNVUwdHU2VjJmRDhoeU1sK3ZNemg1enB6ZVZh?=
 =?utf-8?B?NlVPc3R5aWRyQktLSDhUTGVNSGUyY3lqbWJsN0ViNXorenA4cWRET1Rzbytq?=
 =?utf-8?B?VFdpMVJKcmFoMnBXSURPRytmK1RXc2duaDUzNmJmb24rRDBuQTJnQTZYMEhV?=
 =?utf-8?B?dnhzWk9XelVSdktFV2xER1BOa2gxeS8xdXRjWmFMaW9CRndqZ1hEeHVpdXZw?=
 =?utf-8?B?RWRDYjFnYXJ6cE1oek9QNVRQMnU0MkY3TzlWcFFnUXFMNHp6Yy9rVGl4b3Zh?=
 =?utf-8?B?YkJTbFYwUU52bjZOQWdpU1pzTzBYN2VGU0IrM1NHKzNmdzM4VmY2T3AvOUhY?=
 =?utf-8?B?aXkyalNtc2crSk9sNGQ0dU0reWRkRElENlRsblBqVUVVZDJtdzd2QzIwK1Er?=
 =?utf-8?B?a1RTTGpoaXVMZ1U3L2l3NXAyelgrRnJSRHpGd1BJZmozV0RUMmIyZ25XY1c2?=
 =?utf-8?B?dWRNUFovM0FaQlhJMFpUeml1SXJiRWtDOVp5RVBCMk1DYm1ONmlES1d1dis4?=
 =?utf-8?B?N2NmZW5KbW5NV1ZvRVI3V2c2SUdqc3M4T0dpQXBieWpjTWFOTW1KOTFkcmRK?=
 =?utf-8?B?anNWcktBS0NKU3dQZHBmb2JubXVEOVc0RnVUNTVFK3pnYkRUUVFWdHZ2alNu?=
 =?utf-8?B?aXdEOThqRXlBOCtkUkhmZm1PZVkzWkw5Y1JrK24yODVnK0N6dlYvTmQ1M1lv?=
 =?utf-8?B?cGY1WXQ1QzVEU0RhZ0hBbDRTYndLZXlHNlVCKzBRbmxTMHE1TmI1Y0RvbTVD?=
 =?utf-8?B?d29zRUNsRVlkNlIxTnk2WUdGSnBoWTluK1NER214NEp1UFBPUHlPT2lLQ3Mw?=
 =?utf-8?B?aWFlWktnZ056dXNmdnhHSXV0UmdyYkZhWTlOZHF2d2phZnREK0NHNTFKRU1z?=
 =?utf-8?B?d3p1dkNBMG1tVHZqTk8yaFA2WE5XdmxnaGJRK3V4bTJpamNONzNGeFc2QUM5?=
 =?utf-8?B?Y3p3Ym1mcDRBSXdvTkR2UFVPK1NqRFJtWnRDY1FPd0F0US9VcjFSSkkzZXJx?=
 =?utf-8?B?SXJ5dHUzL1ZoYUxhYVlZSmFveWQxeEdORE90UzZyV3VtQXpDVlBTanZoMk0r?=
 =?utf-8?B?VXgyZHYvcHR2OWZJbmxUeXR3Mk1jQ1l2RjdocUxIcWcxM2JZbWdDaFlZd3Zt?=
 =?utf-8?B?N0lqZVdVWDJyb09CaDNQd1d5ek0vbnV2aGNqbDZpaGd6UHE5aHB5N05KTXEx?=
 =?utf-8?B?cUV0Uld2bU5FUkRZcXV2VVVFdXNVOUh4aUhuWmtYaXB4dUNGbWVoQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddaccdf-e5cf-419a-18ff-08decb95ffd6
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 10:57:03.7061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWpOCqG22rijmYNAKzb166mtS30Ob/MIqMcbtOOtwJKtVQ5Mz/CiJzWQ6NOQkJ2i13X3g3+9WNz9hrEM3xpong==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6965
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

On Tue Jun 16, 2026 at 8:57 AM BST, Alistair Popple wrote:
> On 2026-06-16 at 03:15 +1000, Gary Guo <gary@garyguo.net> wrote...
>> On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
>> > Currently, `poll_msgq` will report a message of size 4 if the queue
>> > pointers are broken. It's easy to catch this if it occurs, so have
>> > `poll_msgq` return an error in this case.
>> >
>> > Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> > ---
>> >  drivers/gpu/nova-core/falcon/fsp.rs | 15 +++++++++------
>> >  1 file changed, 9 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-co=
re/falcon/fsp.rs
>> > index e7419a6e71e2..21eaa8e261ce 100644
>> > --- a/drivers/gpu/nova-core/falcon/fsp.rs
>> > +++ b/drivers/gpu/nova-core/falcon/fsp.rs
>> > @@ -107,19 +107,22 @@ fn read_emem(&mut self, bar: Bar0<'_>, data: &mu=
t [u8]) -> Result {
>> >      /// Poll FSP for incoming data.
>> >      ///
>> >      /// Returns the size of available data in bytes, or 0 if no data =
is available.
>> > +    /// Returns an error if the queue pointers are bogus (`tail < hea=
d`).
>> >      ///
>> >      /// The FSP message queue is not circular. Pointers are reset to =
0 after each
>> >      /// message exchange, so `tail >=3D head` is always true when dat=
a is present.
>> > -    fn poll_msgq(&self, bar: Bar0<'_>) -> u32 {
>> > +    fn poll_msgq(&self, bar: Bar0<'_>) -> Result<u32> {
>> >          let head =3D bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).val();
>> >          let tail =3D bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).val();
>> > =20
>> >          if head =3D=3D tail {
>> > -            return 0;
>> > +            Ok(0)
>> > +        } else {
>> > +            // TAIL points at the last DWORD written, so the size is =
`tail - head + 4`.
>> > +            tail.checked_sub(head)
>> > +                .and_then(|delta| delta.checked_add(4))
>> > +                .ok_or(EIO)
>>=20
>> Whenever we fail with this, we should print a message (actually, the sam=
e thing
>> probably should be done for patch 1 as well).
>>=20
>> A plain EIO is going be very difficult to troubleshoot if this is ever h=
it.
>
> I don't disagree with the sentiment - this is a problem through out the k=
ernel
> and I have spent way too long tracing where exactly error codes have come=
 from
> both in C and Rust.
>
> But it seems odd to worry about these particular instances - they _should=
_
> never happen or at least be extremely rare and very unlikely by an end-us=
er.

I think we should either consider it possible and add prints, or consider i=
t a
bug (hardware or driver) and add a `WARN_ON`, or consider it impossible and=
 not
add failure path at all.

> More to the point though there are many other places in nova-core (and I'=
m
> sure other drivers) where this pattern of just returning a fairly generic
> error code exists. So it feels like it would be nicer to deal with this a=
t some
> other layer, eg. some kind of debug option to tag error codes with locati=
on
> or something.

This should happen whenever the information is lost. Creating a generic err=
or
code would be such occasion. Handling it at upper layers is okay if the
information is kept for longer. For example:

    enum NovaError {
        ...
    }

    impl From<NovaError> for Error {
        fn from(err: NovaError) -> Self {
            // Print here
            EIO
        }
    }

Would be fine to me because the information is emitted to user when it is l=
ost
by the concrete error -> error code conversion.

Best,
Gary

>
> So I'm not opposed to the comment, but maybe it would be better addressed=
 as a
> separate question/patch series to figure out how to do this error reporti=
ng in a
> more generic or consistent way across all of Nova at least?
>
>  - Alistair
