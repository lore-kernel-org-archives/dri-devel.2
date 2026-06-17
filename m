Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A14CD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 02:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB6410E08A;
	Wed, 17 Jun 2026 02:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="trmZVwmw";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012037.outbound.protection.outlook.com
 [40.93.195.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05E1A10E08A;
 Wed, 17 Jun 2026 02:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuAIk76TT12WL4gTnRgwLsWbi4eD6R4q28dRPJWhgbMDx5ay9RwpY41sTsVfQcTFI8PS/XkafmNbR5BHF17hhakFskUuOGPcXxUGkjtdnf5dirnQtHoLu+y2cbZYy4ozwQt2YTUUyPl/E7q4lnVkhuEFsTBxtVEcVHyMqS5rYk5xuxOxqvfzX4hERZ57dtigWZc3L61xurOwcBwhYV4SAOzbiq2rALuF7F9Ggi/qV8/4QXF6uIKrPvgo0ryGMW3fk8OXB9rwBnkwKyxgyWTA4l49cJAgXE4v0Rwwgq04JYeuyXk7lTPNfxTAU+vlQF/LBmvaSN61xiEf3ZyZyU2QCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkXtsPJnAP9dR3ey4TfFSYrRAO5lVq3pBzPayZcl9y0=;
 b=VNucH2VqnjU2xrzuw7H5IjmIY3kEb3olxmqRdGL2yANk70WfZP55fbFjl6ALMHtTPsOTMNp+BSy4ErKY//qynv4vFstz+NBl7U5Zb9nOYtTih3c253DKHmxUg0BpnNDCzQ2GqVLXE4+kbwQEoXSJOIhhNlYEBiOwEsjW51v/9b340+OMtLipjbiFUWkOP34mHszL9dmFUwuPS/HYOtb4peBK3x3/iH3XvKw2L0IvQtoHdzPP4EGyXMW4Yt2AFlujyD4ogLGiiisg83gZPkb17cT3Z9q5bLbqkm4VoByNrF04+V6R5OQwn9FHsMlko9UpUHWOq08r/svtROa+4058eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkXtsPJnAP9dR3ey4TfFSYrRAO5lVq3pBzPayZcl9y0=;
 b=trmZVwmwNzhXYLu/94KtvabmHr1nm/G1ULfj37oDeWBxkZIkGDVFFb9ChX14/fComBzjioy2kwNyyuw/GGKz89LXpOfD1naT5KbuaxVyYv62Z3c3848g/aqGJzauIAW+pJ6D6NSSnHi8ywKTCgPaqCU2ZY88mq/QPjnJKyBZCNF5xIqA3br1X4mLzZpRs/p4thTwMMpP4QBhMrYL+ydyMrShhxkMsa8PczBvMORQDnvv8UuNk8is6Ne6HnObCqoh7SSYXJPTeT2kCHWf5EdEcNMZ3e0bRCnvd+UQ10+lL/rsYleyLB46gXcLZit9F2WxI24fuj2D+g+YjFTIfRuvZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by CY8PR12MB7291.namprd12.prod.outlook.com (2603:10b6:930:54::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 02:56:17 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 02:56:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jun 2026 11:55:45 +0900
Message-Id: <DJAZIGJQ72A9.1688NC74RA4SY@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 03/13] gpu: nova-core: fsp: try to enforce exclusive
 access to FSP channel
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-3-f2853e49ff7d@nvidia.com>
 <DJ9SKDFB5Z63.JPEV0D1Q60L@garyguo.net>
In-Reply-To: <DJ9SKDFB5Z63.JPEV0D1Q60L@garyguo.net>
X-ClientProxiedBy: TY4P286CA0123.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::13) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|CY8PR12MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 72ea507f-0fb0-4375-58c0-08decc1bf279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|10070799003|7416014|376014|4143699003|18002099003|56012099006|11063799006|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: TajnioH8IKoT2T9S6sV9xCe5HzJX44lEgVdHPi1FXH06QQYBHHGFUXJMgffyTpDNeOY65AkAFa2pziJZHRc+PK79lc53In44DczFj4SYR2E6MO2/9wZzDg8uetNNrwAsGDbXVNpy6Vh09bn5hJymH2cGDqF8WDbkTIS3+OCWakfhtrDTZLMncQIUPDnDcOT2301qL9Xm3WG7q64Zk39dhRJA0A+Buqr9rZdWQgvvDpC+odsBZNYdlNSr4JgWpuxS5fRCApydDaK0FXMo+aBn/RQmFqbugnluQhpyUFfegRc43on9/qAruBLwus3ZqfwwXNanQ603NHyfmKDz2lO3CfNRgQAnWB/e2FPqAN55s7UnCQ8kXuHgJcBEMOcx7pyIQxUog+e9M/el1XicQq2TZ13fOa8fdsXbm0n1FCFxebarjh5Y6L81g55ygrHSpCS87Gr3rWHO5tZT4lBezQjai8TARNknqNklT8GaTPZLqxrZifPdbwOX+gIVDMp5vFsJWfkKD2FSEWJThvBHzY1MKMH6Brdyut17vCf2EfRl866wA0yfZyDt4Th4KDdW3lIu8LfXzGmLEEiSRbqdzu7z/xyoCo/AwCc7NBSuQ75owBGVf6Ic0KKpIPx2s1l5D3TU353Ms0otj8dtgPlPQbVnpqO0WF0+29BAsav6Gs3kFlxHHBvMyBmS9zeQ3Q7H5C22
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(10070799003)(7416014)(376014)(4143699003)(18002099003)(56012099006)(11063799006)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFh0OUpGV3F5TWx4RmtWNzdDOVQ1UW1CMkdHS1h6UWZsKzI0b1NpUWpjckdS?=
 =?utf-8?B?QzlwYTd6b3pVaWM5TUc0ZW9aSDFVaVA2Q21ITjVwRXk1ZHQ3QWVxYzkxMG1K?=
 =?utf-8?B?MGNvL1VmR1ZUYVlGa21GOUVSNEk0ZWVRTWk4WEg4OGwzQmFQdzVCdzAyeXls?=
 =?utf-8?B?OWpXRkxJUEVxYWdnOEZLQ0NncVNsbXFVU0Q3d2Y2dEUzWi9qQXdjS0pNK2NP?=
 =?utf-8?B?QjNzS1ZsS085TzdPTTMvbWQ5NElwVUR4bmhrSS9sQVBGWkFaNUswdFFKRjVU?=
 =?utf-8?B?dmdBcDlQZjcxdWVkazRZUmVjZlBCeXc4RlRpakYraTBwYUxGTGVVMUFDR2I2?=
 =?utf-8?B?SHhZWEhSSzNMbW1wK1paUkNINksrOEh4MEo0T3dyNFBMSEVyU01HTGdQem9l?=
 =?utf-8?B?ejEyS2JEZ1VTQ0xXRGFEUHhSRStxWFllZjF2Ykw4L05xcjgxbFVyZWhpL3lz?=
 =?utf-8?B?Ylp4VlhlZnlBTHBRODNBZk4zaDN1N3hjbVRrYTNobVNiTUEyMW9xQnp1SWlR?=
 =?utf-8?B?NjF2djlsYnZiamZEZFBrL3BISUVndTk1Z3FjN1duQUQxQWVRMlFHbjdUWmNl?=
 =?utf-8?B?eE0xVjhLSWRCRGR4RzFBWHBxQWRxc0lMT0Q5cnpONFp2Z3RMLzl0ckxobFND?=
 =?utf-8?B?dXJyaE95WXczeFAyUU1ENm1ONEZTQ2pyYkVUZ3dDVWpCWDZXYktmL0hoYUhv?=
 =?utf-8?B?Nmg4WWFCS1hqWnoyNzI4VWZnc2tTeHo0aWt0dzJ3VkNJRE0vYzMyZElPcnYy?=
 =?utf-8?B?MXM0cjk1SlY4QVBRelpNWWd6M0tWSzhjbTZvYnFBYTNkWlZMYnI5WVhpQWdk?=
 =?utf-8?B?QzFUMEZ3TGpwV2JZTzlpRjlMK3h1bmpkc1lCNWlFcmh6YnIxQ0ZlaE92empR?=
 =?utf-8?B?VDM3ZnEwdy9IdmIrN1FJQW9MK2xMYW44UmNaN0FzNm5rR3JIMTVseUtrcERx?=
 =?utf-8?B?SEdzUVNPYTA5TlhSalNUMXIwcnNCY2pKRDJBRSs0ZWhtKzI5SEorbFRSYXAw?=
 =?utf-8?B?Rk5ZR2RVSjFnemhoUXhjOGhIcTA1eHlaWGFVYTVVWC96VXRTRFlJc0NkKzV6?=
 =?utf-8?B?dkRFQVV0dTBvc21WY2lIRmZxRnp3V3BiOHRFNUxnL3hZdzBveEdydHY2SzRk?=
 =?utf-8?B?Q3dQR3pHWXRsNXVVdkQzTTBVaTJrc1hGSmJXNXpXcUFrVjlQMTdCUlNUSkV0?=
 =?utf-8?B?b2xMbUkvL0htTHhPSHRVNHhiZTJnSU1xcVpQRWpiczdwMXJtTFYzUDduN1I1?=
 =?utf-8?B?S1F0ZXVraDFVN0VhWk5VaFZHTVkvNHJTREhnUSsyc05ZSlcrNVJlSnNQeHIx?=
 =?utf-8?B?NFRBYWNaUFlVbEkycFd3SHhJeE5HWjNOZ0UvTjhWaU0vMTVPY3VMbHUyZGdD?=
 =?utf-8?B?ak9JSmhqYTFsd0RCL2Y3cDl1OXlySzNDQ2cvRG51N3BBeWRub3YremE4MzR6?=
 =?utf-8?B?SlY2VnczMyt4OTl4eUFSREhOY2xRQWpnWW9vWDAzSG1RcGxLRnBnaFFUeEY1?=
 =?utf-8?B?RVdSYmozWnVEL2NKNXMvY3ZGV0wwYTB4d3J3c3pHVENsQW5LOXU1ajMvbUl2?=
 =?utf-8?B?b0ZPN25jQVloQ1ZaMktRSVhvREVNOFF0T2Rnd0ZQMVdNSXo5bmJvQ0IzajhE?=
 =?utf-8?B?Tks0d1Y0U2Z5Rmt3czdPMkxVeUNKbEp1SDFLeVUwc1kwNG1DTGFtdGY2WEt4?=
 =?utf-8?B?YVFQR0F1bjJuY2FpRTduNTRrclZCS0U5TzMvM0tTVTdDOU11ekoxSGM1VFVy?=
 =?utf-8?B?VzgzeVA0SllOSFJRMGx5bkFYU0JPWmt3eEFLeFBDUFkrSUE2UnQwOUp0TmZ6?=
 =?utf-8?B?RUkrNmgrYmErcFpGMWRudzNGRUNXSFBTMGw0NzdCdzVTeGZOdmJqVkpXNG5W?=
 =?utf-8?B?U1RYcmoxUjd3dzBPWXhwTFZ3RWZ6d2lqOWRuM01XL3ZUb3VXK2YzbzhnbFdB?=
 =?utf-8?B?L1ZJR0RVZG4wL0g5bVorbmp2eGxibUV4RWwyb0RFMFA5WTRFc0xpTFpjTGd1?=
 =?utf-8?B?bkFrQWtIdG92RlJPNWdjOW0wNTgxL0pkTXdwTGk3MEF2amx4OHJ0VXErWDJE?=
 =?utf-8?B?QUpSa0VWQS9MQTdoQm1BNG1rczhmNWZFQXM0blZRTm5MU2YwVStRZ1hBamlO?=
 =?utf-8?B?Z0lFQTMzQTNZcU1FbitDbWdQNW1BdUpKU2Y0WllVMytJNVRaNXlDN0dWeSsy?=
 =?utf-8?B?eE1CYU1ZL1JqOWd5MzkvQWswbDgyblVWMVdLeHNFTVJQZ2VqWTlOcUU2Z3hv?=
 =?utf-8?B?bXkzNFJCQkp3SDRYSDE3ZGV5TitwRFh5U1g0RUdQMVhCMEJEbzlveU1ERGFx?=
 =?utf-8?B?dmhxTGJWRWVHbkhMcU82NzFVWDBsU01zRjUrbXRSWnFSK24vMCtaeTNmY1RN?=
 =?utf-8?Q?ELFIposwkQeb4aue1D6NspWqe2kO+PCteivGOxXGknT17?=
X-MS-Exchange-AntiSpam-MessageData-1: BYQvoOrwf2tETg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72ea507f-0fb0-4375-58c0-08decc1bf279
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 02:56:13.2521 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QNw/OgF8utdwIk4BzHc6CSsrvDdBvInvYYqq6Ew++Hn1x6r4DBKt4WrS4tLaKgeZ8yB7EuHjVKrm/hZ/zPEUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7291
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

On Tue Jun 16, 2026 at 2:16 AM JST, Gary Guo wrote:
> On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
>> Currently, `send_msg` assumes that the channel to FSP is free to write
>> into. But, it might not be. Both the kernel driver and GSP communicate
>> with FSP. The way they should attempt to keep exclusive access to this
>> channel to FSP is by making sure they don't try to start writing if
>> there's pending data until the full round trip has finished.
>>
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/falcon/fsp.rs | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core=
/falcon/fsp.rs
>> index 21eaa8e261ce..cdb476894e1a 100644
>> --- a/drivers/gpu/nova-core/falcon/fsp.rs
>> +++ b/drivers/gpu/nova-core/falcon/fsp.rs
>> @@ -125,6 +125,26 @@ fn poll_msgq(&self, bar: Bar0<'_>) -> Result<u32> {
>>          }
>>      }
>> =20
>> +    /// Both the kernel driver and GSP talk to FSP. Try to ensure exclu=
sive access to the FSP is
>> +    /// enforced by making sure there is not a pending message already =
sent to FSP, and that there
>> +    /// is no pending message from FSP to be read.
>> +    fn wait_until_ready(&mut self, bar: Bar0<'_>) -> Result {
>> +        read_poll_timeout(
>> +            || {
>> +                let qhead =3D bar.read(regs::NV_PFSP_QUEUE_HEAD::at(0))=
.address();
>> +                let qtail =3D bar.read(regs::NV_PFSP_QUEUE_TAIL::at(0))=
.address();
>> +                let mhead =3D bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).=
val();
>> +                let mtail =3D bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).=
val();
>
> How does this prevent race between kernel and GSP when initiating FSP
> communcation?

You are right that it does not prevent it in the general case.

This is the logic that openrm uses and locally, much earlier, I observed
sometimes I did actually need this for reprobe to work. I think the
reason (but it's been a while) is that before we did not wait for GSP to
halt on unload and probe failure, which could mean there's a leftover
message from FSP that is not consumed if you reprobe quickly after a
failure. Now that we wait for GSP to halt it's much harder for this kind
of issue to occur. Actually, it might be impossible currently for this
kind of race to happen without a failure on unload (e.g. timeout of
waiting for GSP to reset).

The reason I thought to add this is more to match what appears to be
the protocol that this transport uses (even if it might not be sound
generally). I am curious what others think, if it's worth keeping this -
IMO it is since it does appear to be part of the way the communication
on the transport is meant to be done.

At least the comments could be better, since it looks like my hedging
"try to ensure" is confusing because it really doesn't in the general
case.

>
> Best,
> Gary
>
>> +
>> +                Ok(qhead =3D=3D qtail && mhead =3D=3D mtail)
>> +            },
>> +            |&ready| ready,
>> +            Delta::from_millis(10),
>> +            Delta::from_millis(FSP_MSG_TIMEOUT_MS),
>> +        )?;
>> +        Ok(())
>> +    }
>> +
>>      /// Writes `packet` to FSP EMEM and updates the queue pointers to n=
otify FSP.
>>      ///
>>      /// Returns `EINVAL` if `packet` is empty or its length is not 4-by=
te aligned.
>> @@ -133,6 +153,9 @@ pub(crate) fn send_msg(&mut self, bar: Bar0<'_>, pac=
ket: &[u8]) -> Result {
>>              return Err(EINVAL);
>>          }
>> =20
>> +        // Try to make sure we have exclusive access to the FSP at this=
 point.
>> +        self.wait_until_ready(bar)?;
>> +
>>          self.write_emem(bar, packet)?;
>> =20
>>          // Update queue pointers. TAIL points at the last DWORD written=
.

