Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A40E606A33B
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 05:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aBHkp+uh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AF9610E3FE;
	Thu, 12 Nov 2026 05:26:47 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF9A710E3FE;
 Thu, 12 Nov 2026 05:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxnO6dCYMT5CDczP2MadA7YaQfUylFHjR4C9IGD54sx7rgBS7QM+NdA2BqvmfdaxcRmaG0RAFZVukucfbI+gjJVVScOotTxR5q6FJ3Aq8KGlvM/EdbgFe3ct/VlNSe1PeA50KnIBaMmHZ+YZET9OiZ4H8cMPQbEV4I5lqkS3J9WFg2bTmAI4x7fcwuiJU9eHKsO7b3xFY0lj5p8YJymnBuXE7WDt64fCzFuGC7Ri68jaMbFxmInfSkIBlFmWJVjmKutuY+7Y98D3jyRi53kEnF5Ype/5E8JOZYYx1Q/8S1jYz+FkUpEzZMd8FTpvKFUMNHPU6r3vM2oc34jmRC+Rng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=alZicwkv+RZVPKIPW2MHO3WdlWh/0OARr6KRAyYgEzs=;
 b=seSOtKFHC66KVMIAO99+nRWKGXF8dF1+aEP8fhRYcPEuprSfEI5OW98wc8Fq/8d8miQlzgmLXl5GrHrz1Yf9YSTPOOP51RXkEXl6MNUvEeE+mx7nhoZ+9L+YDd3WJh92LlMeoqVFfvhPawXwUKoMRhNMalZwUm68QjS5HnA4svqQgvPuhwM5JEdnzzLt3NUkFXMNAv7ADqfbWFe0/YyuTJIi2lyNAntNZOxmf6Url5X5miDlFm1QLLHIn1uo3Plr8NK6mQt/aGiyGHvUc78TLZG4A3GBkz2HLl0xb0OWa0h/4t191MvbGmSryPvrsF26TotzTU0WfnRlXoMlv11IIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=alZicwkv+RZVPKIPW2MHO3WdlWh/0OARr6KRAyYgEzs=;
 b=aBHkp+uhMstkn2BjUYLFa7lfbHiIxIt9QIwIYz8wuDyU+52xtBiyfngnuRX/B6ywJX+cFR3fBzI4naKF78dJ0e+GTPDXjkNiaFysGC/uKVdd1BRH6cjv4rIBjQm2nnopxVigBMjUbC8J0dAMNMjfteFfkqbqTjgS5XTSWW2sGTLs9iUltk/J8e6wreCUwj3GUZp9O5kMiHwDC2VxAZieJ7SYZaWvtv/e39QCfIOVTedHUWHWCatbyY58QDAo3XozOKOhk0QymHxGkWU1lA8MIawBvf6Jc53TuS2wStP9f3j91kOkRCsjxisBnw5atdVeHwqt3dL/gnQpHAyDw3v21Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6413.namprd12.prod.outlook.com (2603:10b6:8:ce::10) by
 DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.9; Thu, 12 Nov 2026 05:26:05 +0000
Received: from DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa]) by DS0PR12MB6413.namprd12.prod.outlook.com
 ([fe80::e82a:6673:4142:37fa%5]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 05:26:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 14:26:01 +0900
Message-Id: <DMSZE50AA3RN.3PVIQ5XHXZ05Y@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: gsp: cmdq: increase MSGQ_NUM_PAGES
 to 64
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261111-msgq-64-pages-v1-0-d8c56b6fdd6c@nvidia.com>
 <20261111-msgq-64-pages-v1-2-d8c56b6fdd6c@nvidia.com>
 <DMSGRDMGTD4J.30PUSSFQMZ4YO@nvidia.com>
 <DMSUNELHV29J.3P27BLAEVKTAV@nvidia.com>
 <DMSZ8WDZHACY.1PFMVNJHFRDC8@nvidia.com>
In-Reply-To: <DMSZ8WDZHACY.1PFMVNJHFRDC8@nvidia.com>
X-ClientProxiedBy: TYCPR01CA0185.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::11) To DS0PR12MB6413.namprd12.prod.outlook.com
 (2603:10b6:8:ce::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6413:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dc7cd8e-7a36-4135-020b-08df407d7226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|23010399003|22082099003|18002099003|261009223027099003|3023799007|56012099006|4143699003|11063799006|261028144727099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261022105027099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info: 1aimu+yC9bO7Sj8bBIIuLNclxhauTa9G7p1FKhqtJ0pazXMa+24v/0qWDAFc+HIaxmkSNmfbLl35EShM4LPBKfXCMY7T4lRxsVoWjEBcIDwfw4oFXF+MAHXq7cFJPuUOMJsAgzo7P/063ERnOus6d+nSwdoRsBlX4/ZGcAS8zL7Mij7hQMAyiJaCDPGRCOOLrlzrPxyoWARdyCs3/QTh6mPuPJamed/q272lJ5W5co7ix/7JuVwmDTHVptbeO6GP3dTY1TzShuAXRJFCbizR/mSHQ/IkS3YklfH3tnEcIRNEQ6AkZKfSFvBNM/U3RzB71uf10W/4fQJG7yA/M0WWT4A9LVx1/WSewvWOjwXHSZ6iGl/WAsHa46kUqQ7s3gYHkrnoHi0xLd4+OWk9k8s3DsXy0MMdUmsWb9txWIwZZmzocUN3qbjCpM6cS3IcRm6bMh+RiL23zX0TV/hPu//iRylg1fADhdcWxfMTB03LQxIRim+XIFCcFExzX0hIXvfGwUNfz7vLwJI76USmXtJFKF86GXy84rcPzPXQmOXbOOMH3d2jTSsdVePdUqtxiRW0F8mQXX3HHQu8SKoTTWPlLC2QmdUkAeEbkNPOAVnNGKcPEby+wxrl4VfxQ7m0dpiw+Q9Mevfm49CCwkTDUw/+dAXgv4r+Fs61syNQzwWOoFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6413.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(23010399003)(22082099003)(18002099003)(261009223027099003)(3023799007)(56012099006)(4143699003)(11063799006)(261028144727099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022105027099003)(261021135927099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmdPS3U1anV4dFFvQWRWdytLSTZETm1KQktsaDBYMWFBdVlPMG82N2RJbEw4?=
 =?utf-8?B?VXJ0azRDZW0vclRTQ2dEZG4vSG1WQ2cwcTZtdGZxejlWQjBJcTZjcEFJK1dK?=
 =?utf-8?B?dmFqQUFmbnhUVHdRYjBhUjgvU0tWVGRQcmhIdXFNMis2WWtzaUEyNkxwbmpt?=
 =?utf-8?B?MWFrYnFXaWtOTlgrb3FvN0hEVUNoZElzUEZSRlhSemVnUG1RSDZaWUxDZ3Vk?=
 =?utf-8?B?cnk4NjYrSkZDRnZuYjBtSW1YTWdTSjBwa3VPNnFHYmZ2U3k5NzdmYndBbzlO?=
 =?utf-8?B?dW5tdlFxTHArNHoySEFsYlJUU2orSUNqQkRPZHlBczJrSjNSaW5OYXlQMncy?=
 =?utf-8?B?and2b3BZWlJrVmRDdG1sVTFvZ0l0aFk3RG1NMlByNENhd1ltWnp3Q0lKc2Qr?=
 =?utf-8?B?Ty9CdUtHNzhpNktMVzJnYTFpOGZzbVEvVjFMak0zOHd2b0I0N0JHNmk4QzFD?=
 =?utf-8?B?a2tjeGN0YlBKaWN4RE1NZGh4UjZDWlAyS1k5NnNydFpyOFBxVHN6a2VBMitV?=
 =?utf-8?B?Nk0wdnRkOWJCaTRkK3B5KzF6R3BCemVoZUVvcXpUc3V2ZEFFTTlONXJSby9R?=
 =?utf-8?B?NVFCZnJITkF2TW82ZGlwcUsxWWNYbWpkMkZLd3hBanB0OVRaMFNIcGtydVNZ?=
 =?utf-8?B?MzIxM1VFNWF2ZUpWeWNEb1VxcEo4Rm5mY1E2bEMvbi9LbzVHR1RHTXpEVm1r?=
 =?utf-8?B?MUZKSGhYTkdqalZuZVlzLzdtaXhLMjFtTlNHUzZqa0M1VzduN0FpOUNWZVhZ?=
 =?utf-8?B?bzlJY09nV3plZmk4M3NZeXV1dmxjc2JoUWo3SENOQ3orSXN6cjFqTzVNUVlv?=
 =?utf-8?B?OXA3dGIwU1U3ckhJci82RlFPOGFnL2htN0NyZnkxSk1MbklEdWpvZlJCb0gy?=
 =?utf-8?B?bEZlQy9TMmRaekVQQS9tcEIwL29kM0paM0VuY05LNnNZT0piU3RGRzdaMlRI?=
 =?utf-8?B?MUpNekdSdEN5d0lTYXZDS3U2RDl6emxCS3BEbGt1ekpDUzdoRkNKSlV3dHhs?=
 =?utf-8?B?RS9JR0VMaU9Wb0dvcndYNEY4aGVlWkFLaFdxUC8yZzZMM0VSZGhzK2xPSzBa?=
 =?utf-8?B?K1lUT0UzQWhScGVzZXBzVlJWVXFFMkFpQUNVWmZLQ3dFQ2dWRkRYejBHT0V3?=
 =?utf-8?B?OHRKMjdZTHkvTTJnVlBnb2QxUDc5a0dNczdjQ0tFR3JkRi9SN3U5NnFSVDVB?=
 =?utf-8?B?MzdZZnI3ODNUeUFTUGZlY3JMakJLZ3dDdjZTNWFYUWtHVzZQSEVoRENUa2Ev?=
 =?utf-8?B?OWVobXhqNXFHcU5HSUxkZE1YZU9ycy9VRm52K2tJTUY2bEVYa2FubU5URlZB?=
 =?utf-8?B?ZVkxM1EzUUtCV0M5TEtmSHR1bk1wZzFMYS8xQzlBb29BZ0xhY05KNFo0R0ZY?=
 =?utf-8?B?NTNXTU5CM05lRCthdWZqbjJ4QVg4ZE1qeUFzOWJNWjBubUdIMWl5L1hhUXVa?=
 =?utf-8?B?MVN2aGY4NU9pNlkrb0txZ1pWNllqRFdNaEJzcm0xMjAxUEk4bytVV0EyS2hQ?=
 =?utf-8?B?cUg3WmNSTHVPbFpLWmx0RE1JUkNDcGd4Q0tpN3FFTXFBT0wwWVJBdk9yaWRa?=
 =?utf-8?B?L1BMYWsxTlJrVitMNzZJUEZ5ZU8vaHVoY0JqNlh6V0xtWUcxeWkwT3FJaUg0?=
 =?utf-8?B?SjJ4RzNvbGZjMTY0UU4rS0lCVmtBVm90VG5PYzFLNERYMUxUQWQ0T2IyR3Zm?=
 =?utf-8?B?US9qd1BHNzJTd1ZOQ0k1QWlaZHo2T2lLdnhwaGhpdTRYUk01bEdzN29qc1da?=
 =?utf-8?B?RlhuaS9pT3VYTmpBUHZtY3M2amEwdXp2OFhBdUtvcVhUTXMvRGpLUDl4ZG41?=
 =?utf-8?B?MWREY1A2WE1wRG9PQlM4L25CMlJBMFRhTDdyNmpLMUlCL0RlcWJ2VDhDV3JP?=
 =?utf-8?B?V1o3Z0FBSHBKaTAyL2dNQ3kvQVFuT0Z0SW1IblBuRTRrb1lUcHB5RTJ6cC95?=
 =?utf-8?B?NEQ0SzkzVVlid1ZCR3ZldllIRUxDTXRQY0lGV2Q1c3NpSFhmWjc1dzBQdGNR?=
 =?utf-8?B?eTBIczM5N0NJVUxnZHpodytrQmFrZVBhMzBFWjFVc1Z5YzBFS3NlOEZQL2po?=
 =?utf-8?B?QnNNdW5kQ0prQ3l2ZWNFampxckJXNEpiQ0FDamQ0NlhvRnE4MVBqMlBSVDZ6?=
 =?utf-8?B?cnIraUwvM1V3U0Jmcks1ZHZZc0pzbnhZOTZPeG1yRTVuN1FQUm1OdmdqV1Fp?=
 =?utf-8?B?UG5MbXpiSXF3Mkt4QklLQUFyK3FXMFRKUmxYbVFWc25CcWJrbzA2RUx3WVQ2?=
 =?utf-8?B?K1pvME1MY1IwNk5jdXFBcHpndWtQOTZHZmpINzdndTNyVENoYlpQSHdvOFFK?=
 =?utf-8?B?akwzd2lHZStleGk4aFRBK2VCMXkyMzd2UjMrUnhQQ1NOa29IRFplOHlBRWdJ?=
 =?utf-8?Q?HWOU0HAg3HxGnSvTn2v63x/cxs87Or3eh9oQpZc8tuvt1?=
X-MS-Exchange-AntiSpam-MessageData-1: +Wfcx+ex6drfMA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc7cd8e-7a36-4135-020b-08df407d7226
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6413.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 05:26:04.4233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QATzfqBDPhLV8PXDqZhFVbfZZ3YxMOmN3b0Mrm0dpTNCeAel57StcCgJ5GPNBy8WmU+ZHvK65pN8uAfOcQq3tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 2:19 PM JST, Alexandre Courbot wrote:
> On Thu Nov 12, 2026 at 10:43 AM JST, Eliot Courtney wrote:
>> On Wed Nov 11, 2026 at 11:49 PM JST, Alexandre Courbot wrote:
>>> On Wed Nov 11, 2026 at 10:37 AM JST, Eliot Courtney wrote:
>>>> In the msgq v2 protocol, which the r000 firmware uses, the queue
>>>> pointers are kept in u32 registers and increase monotonically until th=
ey
>>>> wrap at 2^32.
>>>>
>>>> `MSGQ_NUM_PAGES` is currently 63 and does not divide 2^32. This means
>>>> that on msgq v2, the slot can jump backwards when the counters wrap.
>>>> For example:
>>>>
>>>>     (2^32 - 2) % 63 =3D=3D 2
>>>>     (2^32 - 1) % 63 =3D=3D 3
>>>>              0 % 63 =3D=3D 0    (slot 0 instead of slot 4)
>>>>
>>>> The writer can then overwrite slots before the reader has read them.
>>>>
>>>> Increase `MSGQ_NUM_PAGES` to 64 and check at compile time that
>>>> `MSGQ_NUM_PAGES` divides 2^32.
>>>
>>> Have we tested that this was also working on msgq v0?
>>
>> Yerp I tested boot on turing, ampere, ada, blackwell.
>>
>>>
>>>>
>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>>>> ---
>>>>  drivers/gpu/nova-core/gsp/cmdq.rs | 10 +++++++++-
>>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core=
/gsp/cmdq.rs
>>>> index 33074bb53e8c..240ab42db557 100644
>>>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>>>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>>>> @@ -84,7 +84,15 @@ trait CommandElement {
>>>>  }
>>>> =20
>>>>  /// Number of GSP pages making the [`Msgq`].
>>>> -pub(crate) const MSGQ_NUM_PAGES: u32 =3D 0x3f;
>>>> +pub(crate) const MSGQ_NUM_PAGES: u32 =3D 64;
>>>> +
>>>> +// From version 2 of the msgq protocol, the queue pointers increase
>>>> +// monotonically in `u32` counters until they wrap. If `MSGQ_NUM_PAGE=
S` does not
>>>> +// divide `1 << 32`, then the slot, `counter % MSGQ_NUM_PAGES`, can j=
ump
>>>> +// backwards when wrapping, which could overwrite slots that still ne=
ed to be
>>>> +// read. So, require that the last counter value, `u32::MAX`, maps to=
 the last
>>>> +// slot.
>>>
>>> That's a pretty convoluted way to say the number of slots must be a
>>> power of 2 representable as a u32. :)
>>>
>>>> +static_assert!(u32::MAX % MSGQ_NUM_PAGES =3D=3D MSGQ_NUM_PAGES - 1);
>>>
>>> Same here, can't we use `MSGQ_NUM_PAGES.is_power_of_two()`?
>>
>> I actually had this originally but I think that this form expresses the
>> condition more directly. The condition/issue is what happens when you
>> wrap the counter - it should go to the next slot (which necessarily
>> needs to be zero since a wrapped counter is 0). So you want
>> MSGQ_NUM_PAGES to divide 2^32. So if you write
>> MSGQ_NUM_PAGES.is_power_of_two() you are implicitly relying on all
>> divisors being a power of two, which is an extra logical step.
>>
>> But in the end I don't really mind, so lmk wdyt.
>
> The current condition also involves an extra logical step. What you
> ideally would have tested is
>
>   (1 << 32).is_multiple_of(MSGQ_NUM_PAGES)
>
> ... but as `u32::MAX + 1` is not representable using a u32, the one you
> chose is the closest one. It does takes some extra labor to understand
> what it intends to convey though.
>
> Trying to put myself into the shoes of someone looking at this code for
> the first time, this comment and the condition look a bit hard to chew.
> How about using a u64 to test the condition we actually want:
>
>   // The queue pointers are wrapping `u32` counters, and the slot is
>   // `counter % MSGQ_NUM_PAGES`. For slots to remain contiguous when a co=
unter
>   // wraps, `MSGQ_NUM_PAGES` must divide `1 << 32`.
>   static_assert!((1u64 << u32::BITS).is_multiple_of(cv!(MSGQ_NUM_PAGES)))=
;
>
> (I have removed the mention the the msgq v2 detail - it is useful in the
> commit log, but becomes unneeded information in the code as it
> eventually will only support v2 anyway)
>
> WDYT?

Yeah I originally also tried this but I didn't find as nice a form
(w.r.t. the conversions to u64) as you did, so I will go with your
version. Thanks!
