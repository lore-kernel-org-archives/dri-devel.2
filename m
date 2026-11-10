Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ADA606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=p4/88YI3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA5610E013;
	Tue, 10 Nov 2026 13:56:35 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013067.outbound.protection.outlook.com
 [40.107.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915C510E1C0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:56:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/SnCo9AC4ecv66mZ6ONmbzEWe8CCvDdPXHeqe/bn8Osb5plXimvm7XFEiUTPLwctBhdZ8nc+Ftop1ixsOg9McKnSAxBUVlrH5124lls3lhDKhM03KtNGfYzes8QBlZ3E6fK5Ag2Dzbu86ToQorNYioQoueXTDFXoIN6N8a+n6IYhSCrqbE1k4bFtf3+8YuQAQuVq3sjrnc2+Aha5zmhwmZcDN7upkSAgWG3TaX+qwz9d+Rt5PJcUylxOf6ab2gEdM+eEU5YwS7flT95eit24PIDMxSAN6y3iljvwxRkmV5jS89sl+H4rhx1PqIsL3/Tu4LJZuhFMGi7qhSzILVXyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSpZ7/aVFLD2m1+7G/z0MNYgEtX4o9EBaEf52mmwbBA=;
 b=hw8yFVvm1n4v/47OjkFdB74NVDT0tDypFbHjk6CfH0DyBiMNNQWEFKIQkZ+CRCGzM04j8iF+kOv75PbnxitphvZSvHx1huNs+RaxpJWbBtOhq/+S+eogVvk2sCoupbxswL0IKJnbEGPwNGaSdAL5k/41VqUTIJI9S3b6pe13Lq1zKyMAqdrvMKqKrRl1OzlzbyUH5huMVtyKUli2uApF/Kijk+XdsUIMADOQtpVvzwtIivczP49+XNvA+xUwXzsh7w6GRb+0EzhCahCs9OqQJimI9UQdt2IP0QEW+fyPNTKjZb0cZmWjCFf14/3UzKhub+mEFRrY6/zx/KMiIwLHoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSpZ7/aVFLD2m1+7G/z0MNYgEtX4o9EBaEf52mmwbBA=;
 b=p4/88YI3QjHuK7C4+S2c41lfM/yN+2vLQObkTp42AWc8SwxNqFjZNlF5YL8LVdI/EyzjCBWfbfqn196jGSnE63JM4u0bywl9MLUbXXy4x8aZ03aYxwNnl+lPExy/2xlCKnNvCB0wBrLPt2Q/AUfdkYRpwaiQ9IrVaGPo18CgyR0lji3olj6pzzRZ/DSVbcMlbsFVjM2cAQjFGFVgXcbf75wHgdwoZI9V7Ox1k26HmVWSAdK5UQw1VD57EAqvE2HMlzWhaRJIlsCMhS/UB5Ys2+o5uxa55gIgSsPj5rQPbrBE/nDlU54DrXdyzCg/GANmcSHDX6Vh2uCP3l3QWeyTZw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DS0PR12MB999287.namprd12.prod.outlook.com (2603:10b6:8:424::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 13:56:23 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 13:56:23 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 22:56:20 +0900
Message-Id: <DMRKZS5DW48A.20UQK8GL5PRBG@nvidia.com>
Cc: <airlied@redhat.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v6 2/2] gpu: nova-core: add support for GPU timer block.
 (v6)
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20261109-nova-timer-v6-0-5544a3bd8b28@redhat.com>
 <20261109-nova-timer-v6-2-5544a3bd8b28@redhat.com>
In-Reply-To: <20261109-nova-timer-v6-2-5544a3bd8b28@redhat.com>
X-ClientProxiedBy: TYCP286CA0293.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DS0PR12MB999287:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e0be577-a513-4401-c3fb-08df3f3267e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|23010399003|376014|366016|1800799024|11063799006|4143699003|56012099006|261022105027099003|261022075727099003|261021121427099003|261021135927099003|261026121527099003|261028144727099003|261102123227099003|261009223027099003|261026140227099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 9rCXP+YFJad+GybXfCP5IVE0aeUKECGoXnjawjTeJKoJNw9kguJuRq/4f8cjJSF/RbphAYzxFviRohXMZIiOPd4Xtg9pcvLkSGbqF0YpMqevAJgoeUpbwXu8McFf5r7FHojLGgXvB/vOCZ5j40AEmMVHgTjDTQZsF7Y59rz4B0/o6PiCunEsuz5a4rfclZECLonMjGZe4pd+E/yURV+PfL5jppRwwumHJDnjHuXt3i483M7vrJh1qw2LA4wYnYlz/GC9nUC1RahMSwCfSxw0FXuPLkwknwK7W5mE3kA9XFGhAOLoib4VWl90OFk/XLnGXy86LbHOOAr1LWdPj4RYmI8C6uPs5UY/2Ke+MnSwvy33fLQEE6fhUr4QpHYZ6lDzn0peEev/znj8AQt6+b8W31qVzDMGPA9UVoBsVAk/yWo/XXJbKzFgEwi7mmjKrt87fQXY4SSL0lV+TJSzbt4DXnD1H63O8CnMWRsG9l3UjeNqYa0CnpIl9/DfE3iKvyrMArOfGvSVRxEGfq5j9qLjj5ncNdsekxQrq3ilU8EGpqZMrkdYeeJpRzZ3pzIlMv53qtdT19hIlT7yXKb/VheK6lI10hd7YhaNjlNIRgUcH9E8pdRc5s8WlILjDjyQ95ghv2BU+xV1BxyhCcNP8mNVhgm4a4wg5a0VTwu+YYV0yQw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261022105027099003)(261022075727099003)(261021121427099003)(261021135927099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009223027099003)(261026140227099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzRpaDZ3NXZnTm5lNlpYQ1RvNDg4VWhOWSthU0xhWXhXdFo0QzJxbDl1Y0hO?=
 =?utf-8?B?M05jejhMaGJSL0IyN2NmeFNoMDMwN01hNjlodFdXME8vWk5sVVFUOTVmZ1lz?=
 =?utf-8?B?NXIzdjZjcEE1WXg4cy85R1djdSthSzFNSzhMby9icEFhSHYxNFJ0QWxsampC?=
 =?utf-8?B?VXgvdERrTlNxbE83ZnhqdVFqVkxNdERUbkxJRTFTYTUxVSttN2xURDFTVSts?=
 =?utf-8?B?TWw2SERRNDNDaWJsUnV0YjhPNWRTRWxwUHM1d1lkOUQ4Z1ZIWFB3TmpiNWxy?=
 =?utf-8?B?N1ByS01TcEFmWXFpeHpXYUs4MVNYVUMvdHkrNEJaVGd3V25ndXhiTGdKNG1V?=
 =?utf-8?B?clBTZ0ZqSUFPZzdkbnZESmJEUTdEcm9IWTNUbVRrcWJheUQxcVB5bHBwaWxF?=
 =?utf-8?B?RmhkT2p6SDJaaGhQdlJBMnBNbDZKTkYzOE1IMnFVODF0MmlzSHJiZ05MY3hz?=
 =?utf-8?B?UENxZFY1UlNqWE1pa2lwNDAxbG10MzJDWnFyL0tHNFU1WjVKZk95L0VBS1Nh?=
 =?utf-8?B?cHVJTkJ5L3hMQ25CR2o5MXJSV3ZMeWJkMGc0ZS80RTJmS1RJaW0xWk5ZZ2FD?=
 =?utf-8?B?TlRYN0JYOStFMSt5anpHNTBDVjBwWDhZK3QyWEJBbElhZG9jaVd6dzZpQ2p0?=
 =?utf-8?B?Y09vRkFhMnR1SDlEeHVpS2h0emhVQ2kvaTRZTHBTbzlOZ0xOS09wVUdPa0xk?=
 =?utf-8?B?T3FQckJZWDVKRHN3ZnNucnF1SFprWk10Z1FvQnlReVd5NEZBalBJa1Nrc2F6?=
 =?utf-8?B?c01YWEFuMDRqaG5kRTRWa0RDU2Uxb2p5dWRNMzdMTXV5SmlvOXNEQVhSUU9y?=
 =?utf-8?B?Z3JDRDBVbDhDNkhiUmJ2ZE5vaFJpSDU3MWl2UG8zUHUvbDJqbkdudi85em9P?=
 =?utf-8?B?R3liL1Z6QkQ3KzhXbGRUdnBRZnJJS042NStYcjFvSjV4Z1A4Nzg0d05yK2FY?=
 =?utf-8?B?aU1oejRNWHFHZ3c1eXY4bmhpei9Za09ROGxUTmdVUGxKdWdsWVJrUHc3cmd6?=
 =?utf-8?B?SWp2bkg5aThhMGlkY09mRzZTSC9FT2Z0L0hWNEJhdThFck0rdnZJYnBkeUFj?=
 =?utf-8?B?T1FmZndWQmpKaTJBMng4eFMycXRlNXk2NXNHam05QWtKZlpGeVluNURJUWFu?=
 =?utf-8?B?bUdDeWVoZFlxYUR1clI2UXVEOThqVFl4SDE4SlJub2d3VldJZndoTjJ3Ykxk?=
 =?utf-8?B?TFpCbENlR0FreFlKZEZBcUZQdEd3M0IyNnpDenF2Q3dCa3htbDlFeUdBYTd0?=
 =?utf-8?B?ZXNSdnRKREJkdCtaMDE4VU1McEdtZEdRTmdvVm1GYkdLQTdaRjhUQVpxT3Vj?=
 =?utf-8?B?TU5QK3dBbGh0MGNueS96b1hWdUNvQnR2YUcxZERUQmh6ZUpURlg1dDd2d2xG?=
 =?utf-8?B?SlU0TWdKMENOWVJma1pEZjVBLzY1QTRIYkxBS2JXY2NIMWFFaU13RDYyR0VG?=
 =?utf-8?B?ZXZQNFpsZU83TzNSVmdtdzVkSENDaFlHdWpWUUNacjhjcXVQaG8zRzhwTU1a?=
 =?utf-8?B?WnFwVnVxRFVZcDY4RmlkdnNuYk1VZTM3Zi82RmFBOWlVbUVEUUJNYWhJUG5C?=
 =?utf-8?B?NFBSb05TRklqOTRScnJUa1VHZEp6eGNyS201MHJDREN0TllRODdKQWF5ekdU?=
 =?utf-8?B?b1lWRGF5UXJVL1lLNjlTdldGQ2JGYlFGTFJtZTZPcXpScVRiQ3ZSSjFrRFY2?=
 =?utf-8?B?UGVTQVRrdUs5cW1RclBrT3pkTTZWVGJDaUl6bkZPUHF2YTcrQjNDRzRsOUd2?=
 =?utf-8?B?RC8rNnhjaHE0clhITy9rZkoyTGZXUFo0QzA5YUNHWFRPWnRRUExTZGM3TFBp?=
 =?utf-8?B?ZTRleXNlMkNYZlNVd0xienFmOWZvWU1ER3IzSVk0NDBwZzJYb1lHbW9ZYnJa?=
 =?utf-8?B?V2dOempJZEtwVTQySUdjdDRrNm5BcGdMN2V3bWVaUU1sV2FBSHhPWVNmLzhW?=
 =?utf-8?B?dmdNNXpiOS9HVXg4WUplYVUycFp6MzZjUUpmTWhoTFlCZk9KVG5OUEVQSmFN?=
 =?utf-8?B?dUZDMjl6aDR6b3RybHZWWWYzY1pLK29nMUpmWFROemZaQ3dMUUJTa1RvUjd4?=
 =?utf-8?B?WStZaTYvL2VnTGN0ZFNuUVhKRUh6UzRLSGdReVJsMmNwaGUwZmNRbTh4VGlq?=
 =?utf-8?B?bWl0Rzc4bVR5bWM3Tm0vTHg4SDN4M0FlZ1lSOXErdE5HdmVoWDVYMm5rOXhW?=
 =?utf-8?B?MFRUVjh6M214ZnNRRnBJbU9UTFMwU1RVZWMyTGdubVMzczI0V25YR3dobnky?=
 =?utf-8?B?V3JCWHRnQmU0eXBKSXB2WjZvV005ak5qUFZhREhQQ09rbzExa2JLZDI3MkR3?=
 =?utf-8?B?UWtLME9VZHBuZ1k2YUNielhwUVdXWk9VcTQrb25pbGlqejZRN2FlZnJ5WEpQ?=
 =?utf-8?Q?Li6YHfsqjU9GLjX8j+E0WELb4mx6AUorz61BsM9T59gx6?=
X-MS-Exchange-AntiSpam-MessageData-1: JNN0llJfNP1cLA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0be577-a513-4401-c3fb-08df3f3267e5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:56:23.5036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ld7YngCKX35yVhPLuHEAFdbTUewJNIHRmJDZ+C5nY9oZdNmXI9immyRSmg2SLHJFv4H00z6F/P5i+7TaRikCCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999287
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 9, 2026 at 10:55 AM JST, Dave Airlie via B4 Relay wrote:
<...>
> diff --git a/drivers/gpu/nova-core/timer/hal/gh100.rs b/drivers/gpu/nova-=
core/timer/hal/gh100.rs
> new file mode 100644
> index 000000000000..154c7a301a0c
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal/gh100.rs
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::TimerHal;
> +
> +use kernel::{
> +    io::Io,
> +    prelude::*,
> +    time::*, //
> +};
> +
> +use crate::{
> +    driver::Bar0,
> +    fsp::Fsp,
> +    timer::regs::gh100::*, //
> +};
> +
> +/// Timer HAL for Hopper and Blackwell.
> +struct Gh100;
> +
> +fn sec_timer_read(bar: Bar0<'_>) -> u64 {
> +    let mut hi2 =3D bar.read(NV_PGC6_SCI_SEC_TIMER_TIME_1);
> +    loop {
> +        let lo =3D bar.read(NV_PGC6_SCI_SEC_TIMER_TIME_0);
> +        let hi =3D bar.read(NV_PGC6_SCI_SEC_TIMER_TIME_1);
> +        if hi =3D=3D hi2 {
> +            return u64::from(u32::from(hi)) << 32 | u64::from(u32::from(=
lo));
> +        }
> +        hi2 =3D bar.read(NV_PGC6_SCI_SEC_TIMER_TIME_1);
> +    }
> +}
> +
> +fn set_sys_timer_offset(bar: Bar0<'_>, fsp: &Fsp<'_>, time_ns: u64) -> R=
esult<u64> {

This method cannot fail, so it should return just `u64`.

> +    let sec_timer_ns =3D sec_timer_read(bar);
> +
> +    let sys_timer_offset_ns =3D time_ns.wrapping_sub(sec_timer_ns);

As discussed in my other response, wrapping here is defensible, but I'd
like to have a comment explaining why this is so, i.e. that even if we
wrap after an underflow the SEC_TIMER + OFFSET value module 61 bits will
match the system clock.

> +
> +    // Don't set the timer offset registers on buggy firmware
> +    if !fsp.is_bug_3957833_affected(bar) {
> +        bar.write_reg(NV_PGC6_SCI_SYS_TIMER_OFFSET_1::from_nsec(
> +            sys_timer_offset_ns,
> +        ));
> +        bar.write_reg(
> +            NV_PGC6_SCI_SYS_TIMER_OFFSET_0::from_nsec(sys_timer_offset_n=
s).with_update(true),
> +        );
> +    }
> +    Ok(sys_timer_offset_ns)
> +}
> +
> +impl TimerHal for Gh100 {
> +    fn setup(&self, bar: Bar0<'_>, fsp: Option<&Fsp<'_>>) -> Result<u64>=
 {
> +        // The OpenRM driver uses wall clock time here not monotonic
> +        let sys_time_ns =3D Instant::<RealTime>::now().as_nanos();
> +
> +        // fsp is required on gh100 - return error if not available.
> +        let fsp =3D fsp.ok_or(EINVAL)?;
> +
> +        // CAST: realtime system time can't be negative.
> +        set_sys_timer_offset(bar, fsp, sys_time_ns as u64)
> +    }
> +}
> +
> +const GH100: Gh100 =3D Gh100;
> +pub(super) const GH100_HAL: &dyn TimerHal =3D &GH100;
> diff --git a/drivers/gpu/nova-core/timer/hal/tu102.rs b/drivers/gpu/nova-=
core/timer/hal/tu102.rs
> new file mode 100644
> index 000000000000..064f9b92666e
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal/tu102.rs
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::TimerHal;
> +
> +use kernel::{
> +    io::Io,
> +    prelude::*,
> +    time::*, //
> +};
> +
> +use crate::{
> +    driver::Bar0,
> +    fsp::Fsp,
> +    timer::regs::*, //
> +};
> +
> +/// Timer HAL for Turing, Ampere, Ada
> +struct Tu102;
> +
> +fn set_time(bar: Bar0<'_>, time_ns: u64) -> Result {
> +    if !bar.read(NV_PTIMER_TIME_PRIV_LEVEL_MASK).level0() {
> +        return Err(EINVAL);
> +    }

I don't think we want to make probe fail on this since the GPU should
still be usable (I don't know of a pre-GH100 platform that requires the
timer registers to be set in order to work). Let's log in the caller
(which should take a device::Device as argument for that) if this method
returns and error, and continue.

> +    bar.write_reg(NV_PTIMER_TIME_1::from_nsec(time_ns));
> +    bar.write_reg(NV_PTIMER_TIME_0::from_nsec(time_ns));
> +    Ok(())
> +}
> +
> +impl TimerHal for Tu102 {
> +    fn setup(&self, bar: Bar0<'_>, _fsp: Option<&Fsp<'_>>) -> Result<u64=
> {
> +        // The OpenRM driver uses wall clock time here not monotonic
> +        let sys_time_ns =3D Instant::<RealTime>::now().as_nanos();
> +
> +        // CAST: realtime system time can't be negative.
> +        set_time(bar, sys_time_ns as u64)?;
> +        Ok(0_u64)
> +    }
> +}
> +
> +const TU102: Tu102 =3D Tu102;
> +pub(super) const TU102_HAL: &dyn TimerHal =3D &TU102;
> diff --git a/drivers/gpu/nova-core/timer/regs.rs b/drivers/gpu/nova-core/=
timer/regs.rs
> new file mode 100644
> index 000000000000..229babc2c296
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/regs.rs
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use kernel::io::register;
> +use kernel::num::Bounded;

nit: `kernel` imports should be grouped.

> +
> +use crate::driver::NovaRegisters;
> +use pin_init::Zeroable;
> +
> +/// Field value for the NSEC field (31:5) of the `_0` registers: `nsec[3=
1:5]`.
> +///
> +/// The GPU timer counts nanoseconds with 32 ns granularity, so `nsec[4:=
0]` is dropped.
> +fn nsec_lo(nsec: u64) -> Bounded<u32, 27> {
> +    Bounded::<u32, 32>::from(nsec as u32).shr::<5, _>()

Since this uses `as`, this needs a `CAST:` comment. Something like:

    // CAST: we want to take the lowest 32 bits of `nsec`.

(we may turn a linter on in the future that warns if such comments are
missing, so I'd like to make sure we set them ahead-of-time even if they
are trivial)

> +}
> +
> +/// Field value for the NSEC field (28:0) of the `_1` registers: `nsec[6=
0:32]`.
> +///
> +/// The GPU timer is 61 bits wide, so `nsec[63:61]` is not representable=
 and is
> +/// truncated - the same bits the hardware discards on a raw register wr=
ite.
> +fn nsec_hi(nsec: u64) -> Bounded<u32, 29> {
> +    Bounded::<u32, 29>::from_expr((nsec >> 32) as u32 & 0x1fff_ffff)

And for this one it can be:

    // CAST: we are shifting a 64-bit number by 32 bits, leaving 32 bits of=
 value.

Also, instead of the `0x1fff_ffff` mask, can you use
`bits::genmask_u32(0..=3D28)` (after importing `kernel::bits`)? It makes
it easier to understand what we are masking.

> +}
> +
> +// PTIMER
> +
> +register! {
> +    base: NovaRegisters;
> +
> +    pub(super) NV_PTIMER_TIME_PRIV_LEVEL_MASK(u32) @ 0x00009430 {
> +        4:4 level0 =3D> bool;
> +    }
> +
> +    pub(super) NV_PTIMER_TIME_0(u32) @ 0x00009400 {
> +        31:5 nsec;
> +    }
> +
> +    pub(super) NV_PTIMER_TIME_1(u32) @ 0x00009410 {
> +        28:0 nsec;
> +    }
> +}
> +
> +impl NV_PTIMER_TIME_0 {
> +    pub(super) fn from_nsec(nsec: u64) -> Self {
> +        Self::zeroed().with_nsec(nsec_lo(nsec))
> +    }
> +}
> +
> +impl NV_PTIMER_TIME_1 {
> +    pub(super) fn from_nsec(nsec: u64) -> Self {
> +        Self::zeroed().with_nsec(nsec_hi(nsec))
> +    }
> +}
> +
> +pub(super) mod gh100 {
> +    use kernel::io::register;
> +
> +    use super::{
> +        nsec_hi, //
> +        nsec_lo,

nit: `//` should be on the last import.
