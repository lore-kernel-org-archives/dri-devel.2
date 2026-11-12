Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919E606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=PeMws9Gi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A9E610E5DD;
	Thu, 12 Nov 2026 13:30:12 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011014.outbound.protection.outlook.com [52.101.62.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A76810E5DD
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 13:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHDWg5t+I+nJChtW2MJhR9SSt9R8fgMmFd3L5fWf+R6ERb/LKKFZmjHjWABGPE8wlJKbS2jsvh+XjexYCbH7Rsq/PKbcNjMy+5gUbsTcXrcGMYulOHqgnziNAAe3sYsEkS8zCLAFVAZDhtWbAgePgMHSya9EH7NkHABHeh8y7KRC4Ko2DxMqe4ESx4ijhxRTvW/ztMjigEufev0GzmgG34kfGjqbwL/FGGHLHv5J6ZaNvI/FI9oD3uMBAVq3MmzGHAUkwMRkl/dXTcwAn336gDQscUhWmJviEtFQ6R+/6V06cXAZQDlhGzydUTUh7gSi8d9l5Z7wdE/BdsraTBhkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgYntiybdOLdS7HWpvNHHgopj3PTyUyg7foicxI5gRY=;
 b=LmWyyuP8s/Yr16GAWXaaBWW7nBhh1ObR+2oYPsTqiKcwav4n4jYMkkb/YGwwCwz4r8HxbdihUxmIoL2lwiwMdlF9uzbIHrm8Nb4zlZ3hs1tEvKuIOcijvOcsd32RZu/WhTzFHaYDMOWbxXHlxAX3pn0SvdnIA6HwBbjPozRoXnyDswemotHNQAABU/bgLcH3TTIrw3Ryr3VO/IKz6LAaG862qlaswPqRYIlG9LLPochSDdxcu89xzk0Ipl6CFUZz62DF4C1x2TYhqqFZdAKKdW9O00JtifPPZ9TwjtObUK5sTIvESXTEl9CROVKqS522l1W3Q80HVWDteyo2Vivh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgYntiybdOLdS7HWpvNHHgopj3PTyUyg7foicxI5gRY=;
 b=PeMws9Gi37OUxTKpsZm7xsnPZ6R3lpQGHFex0g1Vj5drLk5sApB0cK3lBG84SRiTfgVsEuYhgpuYc9sszegST4QwM5oEOQq10nJZO0iaSzBMg+9ZxVaHY8zNjNQCCoc/CY9AHRoiCXwRYr6Vy6MSqvQQoIvq4R1nhk9eStmAb6DiHJ9+vehD7wDPa2A3cbG8LqtzXUQAPALwEfey+W+O6xblqlADc6Gc24NINlUgb3NR3A58hEsEunrBaWeVxI/M9Pt9hzWW2AwACGF1F05qzlfj/M4Ed6OxW67CXEYNLOr5oPEawAmZKARm8iUkqA7WnFyD8WqVLIdvgRz0il6sJw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 13:29:00 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0592.010; Thu, 12 Nov 2026
 13:29:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 12 Nov 2026 22:28:57 +0900
Message-Id: <DMT9NWCA0XW1.936X5AXCNUE3@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>
Cc: <airlied@redhat.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v7 2/2] gpu: nova-core: add support for GPU timer block.
 (v7)
References: <20261111-nova-timer-v7-0-3031c2476551@redhat.com>
 <20261111-nova-timer-v7-2-3031c2476551@redhat.com>
In-Reply-To: <20261111-nova-timer-v7-2-3031c2476551@redhat.com>
X-ClientProxiedBy: TY4P301CA0102.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::12) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|DM6PR12MB4401:EE_
X-MS-Office365-Filtering-Correlation-Id: edd85fcb-2227-4538-1e3e-08df40c0e92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|10070799003|1800799024|366016|18002099003|22082099003|6133799003|4143699003|11063799006|261022105027099003|261026140227099003|261009223027099003|261028144727099003|56012099006|261021121427099003|261021135927099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: 7frOzvgasl2I75LY0CPLAG7BmpVtuIvs1ZfIswo3pnBe+EFVBhVhEfgA8HwcS/3ToLWjEr0+j/UZP60u292aXw7bTidRE7EYay4+CVDMzNEweDXSJLEiZqLQ+Q0oTGjatSoWEzmGElAt9Fi8dGRyoKbOCppRjgZjI+2HLxCEImsVGNE2/kGitHC9lu6Lu13jHT8dhXmXDDyeC8lJ4y9Pfnni8f8I+EHPzBSypyIlqQFcOYNJagtIXMBuV12fRN5bmFEmti4yXY+eVgiJNpP5ka85vLgoL6rcWVhElQSZjmYyx+R2OOGJ1QpqHFffRGRkoXu59soe4IzeuwZjWeVO/3plSx8kEjA9fE5PiY3yFjDEPcFDvX+MYjQcPs0pijUwClT77zik9PDsMMcjvIC/7DXQZIriMs9SyZ3xkXLmuQUY+VNIZy8BVJu1Rf+uTzp0TIgbzDaC4ezA31Toeim/cT3Vc+EdAntyaaAewrsyRy+X0KFner8mNEzqg+myfomYwl9xJkNid/xPC9gjrHwz3NT+4x0LHli1QX3/yNJRwL5H2KhnYsWyPbFPSxfRfwSkFjtSdyd2jCNOH8aO2/4XvXmRpjZGfa8dmtcfyOqoBkp4dJiMFfIhL2cm5gduWzwhwQGs0PJx6hwatjaYHTtJ/Ckc7UCgmHk93Rqby4669TY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(10070799003)(1800799024)(366016)(18002099003)(22082099003)(6133799003)(4143699003)(11063799006)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(56012099006)(261021121427099003)(261021135927099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUNLRGQ4ZnRZYUtjcnZCWkw5NktPOW9MY0hXcStrN3hhVzhxU2ZWQklpZk9U?=
 =?utf-8?B?cjhQck4zU2tGTm1CTC9mR0RYNEpVd1JMbHV6RTZXOVB1NHI2UlJqM1cySkZj?=
 =?utf-8?B?YURLUktZSVo1OVdxZWxlZGU1TDErdFhDdzlTWEcySkc3Y0R6UGZtVlJ4U21Z?=
 =?utf-8?B?QWpuOUtFVDlON1dWVWQzOFg1Y3JCYW8ycVl4MHdKUVRybVQ1TW4rM2RFcFBo?=
 =?utf-8?B?SGZCOTZEM0l6Q3BqOTc1UmFKcGFKV0RTWVRhaW1kd0Z0bUZHckhoWWxDSmIy?=
 =?utf-8?B?UTdzWWdRVGd3V3RIRVk4M3NSSHRuQ05KR2xTK0Z3SEhMMFlhTkpnM1pudXEr?=
 =?utf-8?B?YVdhd0JVaXh3T00vaW1adzVJOVVwK1RNN3Fvd0NlZ0xiaEVKZFN5RDNFTnRG?=
 =?utf-8?B?RlF3ODdxcFZycFJLQWZ2enpFSllnMGxQUXozdS9Hc0dJTi9Edm0xc1hWUVZW?=
 =?utf-8?B?Z3pPRVFEUVo5MUY0aDZ2S0M3K3BZZzhkTlRPUUd5cFNzbzZMa3dXVERCUXVQ?=
 =?utf-8?B?OVZLL3VVT1pMSVRzeDBTR2hzSkNDQ3Q1YkNUTkdjVmxnU1RRMjVEUlVTcTht?=
 =?utf-8?B?YUcrZ3pVK05aV01QL0lwT2RpZGU2SGlBYTlHcStOTUdHK2ZEWDB2enNSaWtQ?=
 =?utf-8?B?Z0ZsandRdTN2MDRyKzJMTkJ1OGxic3ROMGZRd3dnamVkQ01rU3krYXI4TDY1?=
 =?utf-8?B?SVdpMmxHL0Z5Kzc2d2ZFM040QWxXVXRoM1hmZVBVdUQrVVdvMHMwZ0xmQjVx?=
 =?utf-8?B?UVlRRE9UN0RSbGdRKzNUNWR1dU9mM0pUTW90MUxBTjZseEZ5ZGZZek1janNL?=
 =?utf-8?B?a3VteWFxaS90WHpLWjVMdnNYeUp1MHovMlJtUVlWejNMeHhuWDFMcnRhc3M5?=
 =?utf-8?B?cmFTc3FlKytOL2ZOMCsxQ0UyNk1IQlQySlNMdGpPTVBHK21GYlBFWi9qcytL?=
 =?utf-8?B?Mm1WVzNUNzBlVG12SHMxUVhTd0pETnJNWThVeXhrMjNoekRCbk13OWR3c3p1?=
 =?utf-8?B?VC81dVlzbnJibFFMcGJXZHNocGN2OWNXclZaa0RiaHFZUlJpamRKMFNBcDhE?=
 =?utf-8?B?UlJSM1FUckZuSDNhOHpBbUptZkNhc21PRm1uSUV2YXpwV2ovRjlIMG93eVlW?=
 =?utf-8?B?c0tsTy9ZRktyb3lHazNQNU9ZREFUZVN0UWlycWdUWXpySERZalY3YmIvckVq?=
 =?utf-8?B?aTd0WURuQ0VHMmRZODl0dkZubittQ2NzZytvZjgybHk1aUJaSWZlWHRicjZz?=
 =?utf-8?B?aUx6N0g1SWV2b1N5U01PQ1ZMa2UrSm5oWkFHWTlINm90dCt1ek5Jd25zbjBo?=
 =?utf-8?B?YWJmRkRnWTVTQ2kwbmd4RUtqbUhsMHN6UXgva0Q0UWZLTUNQZlV1KzdJVHI4?=
 =?utf-8?B?dE5MQVlGcWZkSkVFVDJ6SVluUTNENk1PaWZ3N2NqNlN1OEliRTQzT1ZZREdL?=
 =?utf-8?B?WUZvbkE1cVQ0MVVSejJHcTdvU1E3QjhTUDJzcU5NcktEa0pXSCszd1NwKzdp?=
 =?utf-8?B?b2c4TVRvUlYxbThSRnA4cnQyVm1xcERmN296TU93RU9Wa3lZcnFFWVVQekNT?=
 =?utf-8?B?cC96USt5SWFoSmpyMzF6amJ4SkQvMEZyRnBzc3Z3NUtMTHFoVUNlOUtMUjB3?=
 =?utf-8?B?TG8yM0dUYXdHa2lYdlRkaHFhV2Z5OVJYNERkS1NCK0dZblFPUm5LVzRpbkxZ?=
 =?utf-8?B?YmsydkZSU1h4c1o5YmNFTlNzOGgrQUc2TXVuM1pjVnY0NGtGMkR0eTFzelda?=
 =?utf-8?B?S1BvZGpsc2xNYnJKM044bGJQT0dEYlpMZUZzR011V0FMY1dCK1R3VXV6cHFO?=
 =?utf-8?B?eVowNSszaWdnS043Qyt3cWJ1S3hVaWRGbk5obG5tWFZzL1FCU280M0N4Y2Nn?=
 =?utf-8?B?V0VTanJCNmNGUU9EWmg5V1BzVXdDc1NWRllubzRqa3hNVkVWUHJyUCtGN3hs?=
 =?utf-8?B?MFN2Vk9rNXdOcFBrT2ZPR1QwaE9QTW92a3VDY01oem10WFltdEdCSFlsQzlZ?=
 =?utf-8?B?VzJKVldLVjJDbTJydzh3dUFVSzVnVlNhN2xiZlN1emdTdkovQXNQV2M5b2Mx?=
 =?utf-8?B?aE1PdUl3Zy8yTTlGcnBEVnNEMjM2bVJScU94TllsbHV1MURWTWtqT0pjRFZK?=
 =?utf-8?B?VXYrc1ppOUpKeEFMODJXbktOZTZBaTJQQkdZZnc3eWNQSk9zUlR6b1FJemV2?=
 =?utf-8?B?VW12a0lBVnNza2w4Q2xYaGF1RnA5RjRDQ1hEc09jK3JpMUdFVnBzY1drc0dJ?=
 =?utf-8?B?bG0zZHZIV05JYUU0VEUzdzlZbW1md2JEazIxV0l5M2V5MDVDZzdtZVZOR1Vw?=
 =?utf-8?B?blpMSElWc2ljVnlYMGQ3amM0Z1FjY0JTSDJzYXc3eCtzcTVjYk1hbTFJQmxP?=
 =?utf-8?Q?32ggupXUeOas3ukL7sNVnsE6bn/YHfJnxoemMkcxjSTsE?=
X-MS-Exchange-AntiSpam-MessageData-1: FOUD07Jx+AI/tA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd85fcb-2227-4538-1e3e-08df40c0e92b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:29:00.2015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLOz3rakicEmADEd1jIsqj9pkUQG3NzpVpw8CLRWau/TgjHfTx/hEEl9uXPAdvXT5U2bDvyuN/F4Pi5/rFXhIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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

On Wed Nov 11, 2026 at 2:23 PM JST, Dave Airlie via B4 Relay wrote:
> From: Dave Airlie <airlied@redhat.com>
>
> This is needed to calculate the system timer offset that is passed
> to GSP init.
>
> 2 HALs exist:
>
> a) tu102 is the gv100 path from open-gpu, the priv level is checked
> and the cpu time is written to the gpu timer. no offset is used.
>
> b) gh100 is for hopper+
> This is the gh100 path from open-gpu, where the secure system
> timer is read, the offset is calculated.
> The offset is written to hw offset registers, except on the
> original gh100 where a workaround is needed for older FSP versions.
>
> Signed-off-by: Dave Airlie <airlied@redhat.com>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

One last nit (which can be addressed upon applying) below.

<...>
> diff --git a/drivers/gpu/nova-core/timer/hal/tu102.rs b/drivers/gpu/nova-=
core/timer/hal/tu102.rs
> new file mode 100644
> index 000000000000..93fe17990ec8
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal/tu102.rs
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::TimerHal;
> +
> +use kernel::{
> +    device,
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
> +    bar.write_reg(NV_PTIMER_TIME_1::from_nsec(time_ns));
> +    bar.write_reg(NV_PTIMER_TIME_0::from_nsec(time_ns));
> +    Ok(())
> +}
> +
> +impl TimerHal for Tu102 {
> +    fn setup(
> +        &self,
> +        dev: &device::Device<device::Bound>,
> +        bar: Bar0<'_>,
> +        _fsp: Option<&Fsp<'_>>,
> +    ) -> Result<u64> {
> +        // The OpenRM driver uses wall clock time here not monotonic
> +        let sys_time_ns =3D Instant::<RealTime>::now().as_nanos();
> +
> +        // CAST: realtime system time can't be negative.
> +        // not setting the timer isn't fatal, just log.
> +        let _ =3D set_time(bar, sys_time_ns as u64)
> +            .inspect_err(|e| dev_err!(dev, "timer block failed to initia=
lise: {:?}", e));

Missing `\n` at the end of the error message.
