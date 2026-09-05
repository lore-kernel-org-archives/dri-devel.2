Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E90BAC79F85
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 23:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 135B610E1B8;
	Sat,  5 Sep 2026 23:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="rZenkSQT";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020085.outbound.protection.outlook.com [52.101.195.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E2610E1B8;
 Sat,  5 Sep 2026 23:41:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkauZ6UXaIrUEKJpjN3FOh3vq9pp+PHxIGqBYDKJh6R6uC6+2aa5cHrzgrH3/kjelNVdb7zUcE4m0OUxME75V06PBRMEykj9UA3YP0AImPil7NZr8iIwa+6WH7JmyVJw7o4rdlduKPW7QSwvJO7JqwWFEi5PGHrFNSEeqY2vOVU4ytbeV9chdQhl+Epear264U3twtAXAAnE4uOsCsdvl8DmqxDlUmn7pSgOLZFOJZ20t8Jfr9+m4Jekgv7MHq1rJzNvVXZcPFMt2k0UANxiw9hpABknlPMw9sc1zgRY7sAgM0T3sa0iVwoST4Kg3+Prkh8NFAsyp/ldmtlH+mkQSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIB0AbbOiizT+k/SU1OhIONYhQFtqMGet282QJiBN68=;
 b=XigSSyoOSBlCoTDXr9k2tcHvJai38rmYNsnrkqS6IdkBaoLqzIKZ/s822wGfep1dQx80/+m/Vzh/8AAyMLGNKo6xnZ3tNcpoOhOfaI02qsm59JuOAm6Uxx2yJ+7d0iVkf6hXfLsJmjt0iGvBy01sx7SvB5YmcjOHVupqonPDnsHtUT0YQkeXVV2WljZFrxQD63vzvmSh/fwg5ESNqzOzXiPTmT9jWv/nWjDQjgY6k7by8UGyxttb36f9kbmYbX7Mp1cWF+bsV70rkqMXcBpvTRxdDULiG45KJX8MsnK82HyJl4dXH4gLmwHa955CAnEsz9vhAfR1OMWQW2PDh4YqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIB0AbbOiizT+k/SU1OhIONYhQFtqMGet282QJiBN68=;
 b=rZenkSQTPK73cjk1t/wLA58YYsMqn07nxqzg70xglZXzaECrX6FiXGBGNuSF4vXTMa5q6ZXeuLOaBXH0upBHJ5HEfsUSeOOpM9fLIO2JUCWZJgS4TLYOq3Zunr2dMvD0eY8JLC0xi0PViY2zM7S2GcbHIksfd+jhw28Op6SH3Vc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO5P265MB9367.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 23:41:44 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0382.014; Sat, 5 Sep 2026
 23:41:44 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 00:41:43 +0100
Message-Id: <DL7S4168J4I2.1OPCZMLQX9NA1@garyguo.net>
Cc: "Thorsten Leemhuis" <linux@leemhuis.info>, "Alex Deucher"
 <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <Felix.Kuehling@amd.com>, "Mukul Joshi"
 <mukul.joshi@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Mark Brown" <broonie@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>, "Linux Next
 Mailing List" <linux-next@vger.kernel.org>
Subject: Re: [PATCH 1/3] drm/gem: Add callback for when handle count goes to 0
From: "Gary Guo" <gary@garyguo.net>
To: "Klara Modin" <klarasmodin@gmail.com>, "Manuel Ebner"
 <manuelebner@mailbox.org>
X-Mailer: aerc 0.22.0
References: <20260831183311.1090131-1-alexander.deucher@amd.com>
 <20260831183311.1090131-2-alexander.deucher@amd.com>
 <aaef18cd-ab55-4fb8-8563-ca3a5ea9cbc6@leemhuis.info>
 <e8a53eb241b2cc912e9cfad5f6a0120aa9683481.camel@mailbox.org>
 <apyTR-f8W6Jt7uP5@soda.int.kasm.eu>
In-Reply-To: <apyTR-f8W6Jt7uP5@soda.int.kasm.eu>
X-ClientProxiedBy: LO4P123CA0182.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::7) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO5P265MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: 13585489-bb47-466f-425b-08df0ba73e71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|10070799003|366016|376014|7416014|10067099003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /1u6GwNKHa8jxRZhG/4IsbqYrf/CbOL1qLaXTxqbcZwcgB4dAKNfLa1ZG4kPblHqaKl/zqf/tykI/uHJbav8izhk6HHFgPzeaXLOIL0I/86dL2VLJZK4juFMgTQUl1YwWgWlSTE1OsmU2k4Z6An6E5Ssv3E15JNfmsr0nEhO98yURjWtqpW7fCLAM/ls4gc4KMqdWhbGMBkVcmxtMGLukeyZD8GigJwOKDVbEbPZd1o+b4nbTeddGDZJab26D/JSVAbqSVyhMXgZ80877r+1MP1/1euTouB6+eXrJMV8020vgHHewivmFbvMP8IR844+qfWO4dvQL3AI8NMQ+TUT7sMlj40pS4pzQt4SqcwjDFeuaML33kP6fSvD0utKC1yYJ2oxwC7WcWYbjcQ+CczyB/3px3qldRGXoSUuL7k/icgRTEJnf+124pY7e36frA9LQP1RUNov/AIDCWhd9z2EUmfXVQCSZo/QOj6/CSrAjhW0zQ69q4557Eq1oKIVMDHBS9o1eAaD2EgbwgqBT8OKWfxbrCNhCKXbayQZwTCI0LaLII6CUCcOZXqiRW5Kn0qW2iw9zl8Hj5+mAcGpC9JrQmgZEzDpn2z3qXcRHkjE80V8In+6LxqaPbV1G1SQsQWh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(7416014)(10067099003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1RhVXNvMVBjN2ltNFBma0QrWW90eXdRbzlZQUFtdHRRYkx0T2ExS0RxUGhS?=
 =?utf-8?B?VkRSaGVFS25STmxiejFTREViWThJY1pmZ2ZxU3l6QlozOHpnZ201Q1E2Q1VH?=
 =?utf-8?B?dEZFaXVKa3RoWVBzS09vWDZHcFVFempDNitMbjlhekdDUzNzR1FYVGx1elpa?=
 =?utf-8?B?VnB2Z3d6UXY3bUlMbUxQVWhCL1dNSnUzSHUxZW5HMTlCT0JxWkw0K0hqeGV5?=
 =?utf-8?B?dllTRGNWRjFhK09UaktRckE2cmRKUkprUEV0VSt4ODl5STdZRjdndlZ6di9k?=
 =?utf-8?B?ZFVzSCtRWURSVlpSQzE3UkowOS84MjJmQUxJbkU3S1JrTkdrMlgvT2dGbVVj?=
 =?utf-8?B?V1lEdHZueU0vS2VYODQrU3lZN1hCYmlCdW1wSFBTZDZaSERKaGRqbkxVbHg0?=
 =?utf-8?B?ZDZQZmxsK2dpd3M5bksrMXMrcm5reEJyR3U2VldWcjhoRXM4M1NLcTduN20y?=
 =?utf-8?B?TFJLRHVDMy9ONHB0Wjc2TVpsMnh0c0dkbVJKNlpjeWdEeGhuOHNKVWtnOVZh?=
 =?utf-8?B?K29HUjhpaWV1dWJtcVVJeTdZNElyLzJvT0JaWVVJTDFIaWFLeDdOdnJ4TzFr?=
 =?utf-8?B?aFg2WmcyOW1vYXpEejY0TFFENmk4QWhiZGtHUDd3L3N2MVVCYXo2cEpNOEo3?=
 =?utf-8?B?VUVvVzJFVzIzYjdnczJIQm4vdHIwSzhOeUF3LzFJYkxxekpGY0d1aWRVMTFO?=
 =?utf-8?B?L3BISjEzdEk5R1BVbFhMMW50UW00OG91dW13RjlKYnZkQmpBU29ROVY4R25Y?=
 =?utf-8?B?eFNhcFhINmRHUGl4N2VRZmQrNWd1TURVS1kvZTdpYUV2L0tiSndyN291NEx3?=
 =?utf-8?B?VVNYK1d1eDhtNUZZOU9LaWdlMGdUalREL0ZuaVYrMktESHNaZlVObk9iYm5I?=
 =?utf-8?B?UXZJakt3ZnVQRmtWQ3EzT05iM3ZlZ0xOZWhtYXpGZ25QSmZXTmdYbUpPaHl3?=
 =?utf-8?B?RVhzKzRlTjcvWjFDUWJjd3hzWnVETmFCa1J4TWhBYVN6bzd6UzFCeE16VWp6?=
 =?utf-8?B?cTVqVGkzTWxPNERPb2thUk40SVBmb3BUSkFocE1NM1Q4Q0ZHZTlwNWZSbll6?=
 =?utf-8?B?NHJYU3ZTUVAwWVBhWkZ4cGo2dVg4NmhQZ1pHT2VoUUluWGtoZlloYk4xYVJu?=
 =?utf-8?B?czQrcXJaZWFXekxFenZiZTladnBMSXFNWFNLb3FiM3Vxd1VFbk9oRGtoN0Y1?=
 =?utf-8?B?MmVQc09UbENSeEpsck9hbCtDN1dHMitKMTVla01rUVRmTWMzU0JpVkFtcWRo?=
 =?utf-8?B?Q2RaSHpOOWM2ejFiSVRqZkxubkg1aTF2ajkvNmdmS2lRcTQ3RnNML1RZSVpV?=
 =?utf-8?B?d2MxY3pkT2FEelZmUmJza2ZVTTZGTkdzMXU5OW5MMmE3Z0xJUEpvak9uT0Yv?=
 =?utf-8?B?QUpTcDdrRGFpblIwRzROYjRuZW0vMDQ1bUJRQ3RBeFRab2RJVS9BWkxrV1Ro?=
 =?utf-8?B?SGtVRG5sVW9VQUV4TERLYlcwMnlFTm1VZ2dnbTRRclA2OWF3UEpFalFiNG85?=
 =?utf-8?B?a0E4cmxxbnFRZDZtR1JqeGpDeVVVYXdhcXhKSWMvbmtRbVpEdkFaTXpSUFlw?=
 =?utf-8?B?NEkxWm1sOWRjd0FYcnNPQ2ZqMWNoSERLSDVTbWd2ZytBREFFNnFWbjJ3eXU5?=
 =?utf-8?B?QnM2VkZRd0h4OFYyYWV4cnBkVEtZZXFRWWF0MEQ0enpMTkxLZ0FPOXJPWjhs?=
 =?utf-8?B?MHUyRFhZTTJlR3NVS2VteHVtNEpVUGFNNHAxemV6bHk1anE0eXpWU0lYTzE2?=
 =?utf-8?B?MEpjaUFzQkxNYndwQ0taTG0yaVdweWdVckwzTmc0Mm96bmNKdzlhczVHdmgx?=
 =?utf-8?B?MVZkL0x0Z1lHaUdJQURla1NOL1BvRlRQcEZlRTU3aU56djRRQkozMnpZbFlw?=
 =?utf-8?B?SWd2SU9NQTQvdVZlbkFMbTViY1pDTzNOaUlhYkpnTFMrcGVZL0ZtUmQ2YXpO?=
 =?utf-8?B?UzNKSElwQm5aeWdScVhDMmhDVm1hN3RZTy9HLzlFZ0VQNkFIZ2NtTUdzWjk2?=
 =?utf-8?B?QzlpalJlQkg3ai9GVWQvWWM3M0hlRHQvWGNXUkUwVG16OVAzWGZ6RkdMZENn?=
 =?utf-8?B?RUNSVEJkZEpTajdKM0UydHhRL0pQNzFUanZ2YTNCV0RuTkkwUHhudjhLODlk?=
 =?utf-8?B?RHQvMVFFbitsaHBGZm9EWXg1Z3dXSlJOcmNtV0VVY1dXTGZYZHBCYmxGT1o2?=
 =?utf-8?B?MGs2TWlmZ2tSallLUVNBZEszdzRSRFRWM25VTGhKNVlvTVJIY01ScWFXTTlT?=
 =?utf-8?B?Nmg2S1RwZXJ4TldYa2xKSDhGZCtzS05LZTRKVGZKVlRhN3JSalkxdzZxaDd3?=
 =?utf-8?B?TTdKRFJvaXFNTitPMXNwWUpUZElWeE8zOUphRWVHMWczQ2tkWjg1UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 13585489-bb47-466f-425b-08df0ba73e71
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 23:41:44.5636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ph4F6JalFVLreOg9uEAyS2mPGQ4C5x1juU4VtjjgMXs9Geyelx9PaUfHw0QXrIKYzqJlIfXIZHrk6ehjWNm4wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO5P265MB9367
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

On Sat Sep 5, 2026 at 11:25 PM BST, Klara Modin wrote:
> On 2026-09-05 11:31:41 +0200, Manuel Ebner wrote:
>> On Sat, 2026-09-05 at 07:36 +0200, Thorsten Leemhuis wrote:
>> > On 8/31/26 20:33, Alex Deucher wrote:
>> > > From: Mukul Joshi <mukul.joshi@amd.com>
>> > > ...
>> > ...
>> >=20
>> > > > error[E0063]: missing field `handle_free` in initializer of `drm_g=
em_object_funcs`
>> > > > =C2=A0=C2=A0 --> rust/kernel/drm/gem/mod.rs:265:58
>> > > > =C2=A0=C2=A0=C2=A0 |
>> > > > 265 |=C2=A0=C2=A0=C2=A0=C2=A0 const OBJECT_FUNCS: bindings::drm_ge=
m_object_funcs =3D bindings::drm_gem_object_funcs {
>> > > > =C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^=
^^^^^^^^^^^^^^^^^^^^^^^^^^^^ missing `handle_free`
>> > > >=20
>> > > > error: aborting due to 1 previous error
>> > > >=20
>> > > > For more information about this error, try `rustc --explain E0063`=
.
>> > > > make[2]: *** [rust/Makefile:799: rust/kernel.o] Error 1
>> > > > make[1]: *** [/builddir/build/BUILD/kernel-7.3.0-build/kernel-next=
-20260904/linux-7.3.0-0.0.next.20260904.221.vanilla.fc43.aarch64/Makefile:1=
442: prepare] Error 2
>> > > > make: *** [Makefile:256: __sub-make] Error 2
>> > """
>> > Full log:
>> > https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/nex=
t/fedora-43-aarch64/10951622-next-next-all/builder-live.log.gz
>> >=20
>> > Reverting this change and 2/3 from this set fixed the problem for me.
>
> That leaves only the documentation without the feature so might as well
> drop 3/3 too in that case?
>
> Otherwise, the following also fixes it for me:
>
> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index e1ebad77ebe2..847e0ee38863 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -278,6 +278,7 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, C=
tx> {
>          vm_ops: core::ptr::null_mut(),
>          evict: None,
>          rss: None,
> +        handle_free: None,

IMO this should use

    ..pin_init::zeroed()

to set all other fields as zero rather than explicitly listing all of them.

Best,
Gary

>      };
> =20
>      /// Returns the `Device` that owns this GEM object.
>
>>=20
>> Verified.
>>=20
>> Thanks
>>  Manuel
>> >=20
>> > Ciao, Thorsten
>> > > ...
>
> Regards,
> Klara Modin


