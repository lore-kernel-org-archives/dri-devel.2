Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27A606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=fF3WcN/n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB7C410E3A8;
	Wed, 18 Nov 2026 17:46:10 +0000 (UTC)
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022128.outbound.protection.outlook.com [52.101.101.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D322F10E3A8
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 17:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E50jPOdBgVI64eSpuI2flpkUAUniaSEZwnhfUV8s22KFaUee+NYF7wlwJ1duHu/YuxzUNQBclSuFumsFZP9QDnT7Bx7K2asIbpBnWe/jIw2aeAYrAneEF1eScRvMP8GMO1ETbS98I96RFD4QZJ7sxyspA9jbbVo9zIrnUHB1J0e31rsOQa9+LpBVH1btmvuIoklwqF+VguMj0QzvNCfVLcC9xBkD/lk4Nz4HKckZxh6WFV+Ah6DSAkmCs4P9vEa18OpYdCQOIzZswId/CBrxrCuyyrSWOagLz1s0wmB/GboljK82qKEGxeOG7Dn8MZbkYD3OX/glfdXgCuvljNT6dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSQI2vPYhY6POiQOBR71h9LSktkkZyjQPoU0G54FugU=;
 b=sAjNXB48QRmIWovohRJaVBjXyXSlnv8/hpEB+t52Khuv9rqGgojuJu0A4qH5V5xGm1/x212XEUorqPMApYTjpJSm7TkUiaofr0n8TEG199UNs3BJAHNSZoQbiK+9HArIs9vuRO0kJz7sIIGB83ZaT6vuvwYGHxFrXqLSP9P7RKzo67maCV62BFzn7Ca7MLZT3y5s+n+YpFA5Iv2zlf3wB8cu+x2+AUlyanigou4GSxOhqgXpqOgPU9UclOUygMHV9z/S3g0anqSmLnaORAH+54UIcHj6XmOM9PSg78MT04/QHx8qr45bTZwN3/+q4hCzsf3F7aqzV5mxbdOND+AGPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSQI2vPYhY6POiQOBR71h9LSktkkZyjQPoU0G54FugU=;
 b=fF3WcN/n0xs6kPYKye4w6HOJCjKz67MXw0FaMmsP4UgtmrIRExm3LW3cHhzRgf1lCGR/b7JLYzP/rThxFc0LRDzx3Eb9dfhSogAoWSJnFZbW3iviRb2M6NGJprmPEpvHcDu4rLdKVRgjmJC9GzAtbRueQ2Mhd9MuvX9bcrBX/1Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO0P265MB6054.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:289::10)
 by LODP265MB197788.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4f0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:45:59 +0000
Received: from LO0P265MB6054.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ebd6:df88:f3f2:ddb1]) by LO0P265MB6054.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ebd6:df88:f3f2:ddb1%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:45:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 17:45:57 +0000
Message-Id: <DMYIVY6SNRZ1.2SWH1M60IQ3QT@garyguo.net>
To: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Asahi Lina" <lina+kernel@asahilina.net>, "Lyude
 Paul" <lyude@redhat.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: drm: ioctl: fix call to unsafe function
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261118133232.48603-1-vishal.moola@gmail.com>
 <DMYH0CXPUTMP.J3AKN619TL34@kernel.org>
 <av3Y8mTaRi7l-5iy@C422HJQPQG-Fractile>
In-Reply-To: <av3Y8mTaRi7l-5iy@C422HJQPQG-Fractile>
X-ClientProxiedBy: LO4P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::11) To LO0P265MB6054.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:289::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO0P265MB6054:EE_|LODP265MB197788:EE_
X-MS-Office365-Filtering-Correlation-Id: df59ade1-c26f-45b5-d130-08df459bcdbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|10070799003|376014|7416014|10067099003|56012099006|4143699003|261022115727099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: LdST7fepqlqzCCruLFHlgkOxGH0zjmG0ozlBGygTvNU/IXCgqcjA7zGIJHEApW5LaloqLvKE117Ia0if5b7X3YtNaXAZ4DhIICMfuLjPMWOf9Dh2kYy6pzdkvsr1gh08hKMKSZJGGZ9lQHF9FE2CpAyEx4JOmfQJRjWwzcONKIZaaicnXjBpaU8dS1j09bj9pACQBwYio2oWCBVWIa2ydXUxy6HL713KJDalFKtV+ZO3GbQzqq7Get4F0YnLchyuCDOmF2Xn+Tv7xft00MvURnajQ4J9g9glPTVJKnNsOzYaF9PeE6Ngj7pyBj+UQHrSppH7CSe+qio9IiSDO+3KOZsY/hJEs44ZfAHY4bl3N6DZdA3StjQGP8elmPgzMFazovFKeP9huXhICcXrCFlHIArzjrvvvlLDGZHiCrTVQVR4acTtkA1Q6jPjr0um43+bmS03Rd0x23masou3NXMmO5AR0PMNK/VLGEbQIXoMdA64m77tuwtb+Il1jsK+6yA5E/vixbVmHtleLPxx6kZvDdsJpz+/Yoh3M/6r5DleZxa8LuogubB4kSXstg0dVscniO9TBdtodi0hX1rMKYTWyJMcpIRGbjbK7SGzNeThDcvduLCzmEhELG51/ljDjq+LGGnzvtriAfzue6bSQBz2bcY9LV+f111J5nUVKT1cISY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO0P265MB6054.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(7416014)(10067099003)(56012099006)(4143699003)(261022115727099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUdXeTVHVVhRdUZMM05HU1dVeUZmT2tjUmRsZitOSmxwNG9xb0VGcU1GM0lt?=
 =?utf-8?B?WXlqMFIxTWZCMEt2Q2RpUEg0VGNjKzY1dThQODl0enl5Y09DMnBCdHlETnFh?=
 =?utf-8?B?dTlGeEdSRzUrRnpKcFl6Zi91amR0VzlpZzZNMUpSUWpoWkI2aW1DWGpKZUxI?=
 =?utf-8?B?OFd6Zmk4dWhWakxhWm5UZHZUU1gyRzJFZ2RFYUNWYmhQUjRoeVdueWQrVFR3?=
 =?utf-8?B?SHV6aFE1UjRwYTEweFVjWXdwMmo3d2pwNFpGYU5oM2dvczJ3YVVFVzJVM3lR?=
 =?utf-8?B?b1hISVF6Y3FpRTFEVys0NmxwREJINEZVMnlOdVhsNkY0eTBTKzFjZDkwY0p6?=
 =?utf-8?B?RmtIeU1hNkdMMDdQNmRVU2Q2SFhoUU96enpnVjFEbFBZTEVuTTRiYXhZTFgv?=
 =?utf-8?B?dWJVeGpaNWdoTVVzaVdOTEtObmVSUXBzS2V3ajQzMWo1Zk44TmtNdDNsVVBM?=
 =?utf-8?B?YklhbUYwOXEyckNVeWFFa0E0UUk2NktHZXVCcXlIWU1jOHRYV2RGeGUwRDhQ?=
 =?utf-8?B?eHpXZUFLd1NHZGM0MEFMRnQrSnIyYWpkaFFZNi9TTGFKY0U5aUdqL1F3NmxQ?=
 =?utf-8?B?QjNlcnE0T2RlQWU3WUtMSTlqeDAxREJiYVhqeGV2T0VJcmRVbStGQXVUbHBn?=
 =?utf-8?B?elM4YUdBUmxtai9KR1dTZGVYS2JWV2ZvK2wxOHI1NTBVUUhQU1NmSEsrTzN6?=
 =?utf-8?B?OFpkY3ArQ2RnbkV0SnhONXhVV2xlNjY5SmhDVFNBdUFaaE8wNXIzN2Q2U1Z4?=
 =?utf-8?B?cUZCWWxUUnFFeGtKSEVXWHY0d1RSMm54Y3RnWW9POERlV0xYcE1WZHpNamtS?=
 =?utf-8?B?OVk5Q3JwOUdycUIwTllRdjNNdGR1SG5UR3VHV0E2OWdwV3dXT1pCWVJ4TzZp?=
 =?utf-8?B?QzFrTmJTYzIvaW1sYk1DTVdTYkZKSDI3Y3F5M1pzRkhoclI4U05RUTNIaXRm?=
 =?utf-8?B?cEZaTFo5Uzh1N3lOM1JsTUxSbXowZUpqSWVWVHNjYVk5Ryt2OU9mTmd4MHBQ?=
 =?utf-8?B?OWRKMG8zU0dvTFNSeWN0MEhXVkZGMGM4MGtKU2ZVK1VGWEU5RkhPdXhwSmN0?=
 =?utf-8?B?L2ZLbkwvdHNuVjl6VWdVamd0N1BMVmh3S2lHRUFSSUdwVmZCTnBQb2VtR3Ur?=
 =?utf-8?B?cEdsUmpKUHRGZjNSZGg3ajZPTkxXbGRBYVI2VU9lTmhzYVFRKzJEalQ3eHIz?=
 =?utf-8?B?UVpRTnFHcFkwR0J2T3prT1dzNjI2OEMzV3l1L0lhekJCd0RuR0hiMEQyVlJ1?=
 =?utf-8?B?U0s4ektUNFV2cWdzQzFsV1BiYVpHLzJQNGZyTVFRVlN1TnJCWDdkdjdDUmhs?=
 =?utf-8?B?cjF3WTBvRGl0Y0hqVmRKdTB2b2l3UmxoNlVoeFVsSkdSc3lKYVZkNHI2eUtl?=
 =?utf-8?B?VUJiY3orMUFhRDVWTUF4eVNkSkxkZVZnWG5KdFRxQjNKU2RQUFR1MUlJZjlN?=
 =?utf-8?B?bEpYU3RsbmQ1cDVoZGhnOGhhRm9Qc056K0c3TDZFS25qeEhHakxsdElZSGZT?=
 =?utf-8?B?eGlDcGJNSll1RFhYQ1VBN25xTXRFczJaZ3pJV3JWWUVFMHMvRHFrc1EvTHhU?=
 =?utf-8?B?VzZ0M1ZpaGJTNkIwdG1yU2Q2TTd4azJGK0x2NXVXaG5MZVdZS2tkeVdCZ2dD?=
 =?utf-8?B?d00rUTNldHN2SE5qUnJWYlkyZzNGZDZUQnBlVEJpMlZrMFJENjNNdzY0b0ZK?=
 =?utf-8?B?Wlo2bTRuWSt0VVljUVZPWHdIZm42N0lRcEY1ZGlyOXVpbklvbCtSellaWWpm?=
 =?utf-8?B?N1ZCcElVNzFXOHZIS29rMkM1MWZIU1gxNUN2K1NQNktNZjlGc00ydnBpMDIr?=
 =?utf-8?B?c2hwMkRuT2VNWjBIaUljd3h4OGFrOWFIZ1NPWFN0eWFNU05lNlk0NlZ1czgr?=
 =?utf-8?B?eGhKcWdoWkxiK0tsdVR4M1V5cXpaYitzbnVRY2kweVJJS2FVSFExdUprN3N5?=
 =?utf-8?B?aDlYNUlVWStBblZOdnE1T2tMZlpIQWdMcFFDQjZrbWREQ3ZTTmw0RllXUzhK?=
 =?utf-8?B?cjNWeXc3RkNWczBIYjhFRmlSS2hZU0Y5eXlNaXNEbE5QN0RLbHlJNW1oeG9o?=
 =?utf-8?B?ZVJDYkIyeWhIK0RuTTBOL3Q1TlRvbjEwYWdRQk9xeHYzcUxSTmljNklpb3dr?=
 =?utf-8?B?Y0V6MWltVEJaNi9seHJKSWZLbnN1ek04YnRtMzBFajhuUXc2bXl0MGUyUDJh?=
 =?utf-8?B?MFh4VlJCN0RnckYzbHdhQ2wxSVRQTjBBWnFCQWNIUU0xenU2VnFEdEdINXZN?=
 =?utf-8?B?VXlITEhTUUVIcmJqdXI2MkVOaXFycGFEUWxGYTA3OEZUWXl3eVZLWUtTMzAx?=
 =?utf-8?B?dk9vd0x6eitMUEYybllwdXpyVElGNUwrTHBsNFVEdGxUUHRmWmpTdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: df59ade1-c26f-45b5-d130-08df459bcdbc
X-MS-Exchange-CrossTenant-AuthSource: LO0P265MB6054.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:45:58.5115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OuKlMVOu3A4w79gr+4/glKJBsKmSHPmfKhd/m9mmx5C9zAowGNwKGOvt40VTw6j+3/W+kATWXWCiC+59lPB4Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LODP265MB197788
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Nov 18, 2026 at 4:57 PM GMT, Vishal Moola (Fractile) wrote:
> On Wed, Nov 18, 2026 at 05:17:41PM +0100, Danilo Krummrich wrote:
>> On Wed Nov 18, 2026 at 2:32 PM CET, Vishal Moola (Fractile) wrote:
>> > diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
>> > index 64af9eacc306..5a2e2f4f0e91 100644
>> > --- a/rust/kernel/drm/ioctl.rs
>> > +++ b/rust/kernel/drm/ioctl.rs
>> > @@ -152,7 +152,7 @@ macro_rules! declare_drm_ioctls {
>> >                              // dev/file match the current driver thes=
e ioctls are being declared
>> >                              // for, and it's not clear how to enforce=
 this within the type system.
>> >                              let dev: &$crate::drm::device::Device<_, =
$crate::drm::Ioctl> =3D
>> > -                                $crate::drm::device::Device::from_raw=
(raw_dev);
>> > +                                unsafe { $crate::drm::device::Device:=
:from_raw(raw_dev) };
>>=20
>> I remember there has been at least one compiler version in the supported=
 range
>> that complained when the safety comment isn't directly above the unsafe =
block.
>> Has this been fixed in the meantime?
>
> I'm not sure? I'm compiling with rustc 1.98.1 (48a229cea 2026-09-01) (Fed=
ora 1.98.1-1.fc44)
> which gives me no errors like this.
>
> Hopefully the build-bots catch it if there's a specific compiler version
> that still dislikes it.
>
> The following command shows a few other occurences in the kernel like thi=
s,
> so if its still an issue I imagine it'd likely be caught somewhere:
>
> 	grep -rn -B1 '^\s*unsafe {' rust/kernel | grep '=3D$'

In this particular case, Clippy 1.85 doesn't complain even if SAFETY commen=
t is
removed, so we are all good.

Old version of clippy (the minimum version we require is 1.85) have both fa=
lse
positive and false negatives and sometimes things just cancel out :)

Best,
Gary
