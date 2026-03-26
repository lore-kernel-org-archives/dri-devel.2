Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AF2109E543
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 04:30:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E33C10E1B7;
	Thu, 26 Mar 2026 04:30:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="FNmqU7KD";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010020.outbound.protection.outlook.com [52.101.85.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5991210E1B7
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 04:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/pgbXbPet0Zuj7sXinsKVe8YtCny/J55iKrzvX6p3P7FWfV6KyiVfOytkGjOHT0lF0TbNxublnyBDu7711heiBJ5G93zaHBFw2r3uwMY9axrONRvoUsTkHAJEr6MUlVbZ0tofwEQIUilp5ram0mB326QhiNtIhruhKM+1abzqpU82cClR/ag6l4JXFAxvxAA1mMg0q/APnm7DFarOUef3a/9O88aCfEHXgBVuJCRrlXsLckleEjyNQn8ud1Hp50vYtQFxFfxwWOWyX9XccFMgCFVHVTxUy7EMklGY3R0UHGYcBGf/URgDIuWmxpfErC5vJ0iOasiXhar15VEPED0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtkXwQneh1dQ0eNgv9xMQ7DmRBlNJtAkkkro/+S8vq0=;
 b=muhEZbTbW+Qy4NwKOSyIyoAusMy2UUIpB6e1RCzIth8vtoTeAfGMBUjrHZZhSTWQ6SA7eCeRDznt9affBL2Fk4/9KqzP5DZGkLG3ca0/2zuFAhY6nO/4DTih/Tck+Gab/Btp/BaLe9QCNebtFnV01kWAHJTaagl/KIWjX1yuxGrwRryaVww2mhiMJ5OwSPogA9o1xZHv/law/KH92YRUkLXzO70XvYVRYqv36J8KioxYuVQ4hfedzhIIr2+zHdkWnWHzEhEssFF/Bh8PH48Mn04g1rTNJNpGbf9SQtYU8j0F2VxPzj3er+chXxkoQ5GiLlA7iNAnY3MHsxv8qbm16A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtkXwQneh1dQ0eNgv9xMQ7DmRBlNJtAkkkro/+S8vq0=;
 b=FNmqU7KDy4GOoZUVgNZ4tok4DO/aEmFuFXBDQFAe2t1nL52dlSZYJand+0/tkukSDUh9gds6SP7/5IjcHzcaRw6rVRdKhuebqrD/xqkDISCUK9XarKTwfkXRW2ZpJxdcWrtfmsq2jo7dy4QfeAXdxVoAK9X5+JQY/qgP6rBQphXeN+ZQoDosONVxHFo/B1ykD9/yc2J6XaC4rVTxEVdQt9GlWz86SOVEKUZiQYT1okNQhtk2Caxg9iPpabMyCJ3LIGCjQ0YM7ZUK9hNSjWLEwrQWeowxsNo/HswjSTmRRGiOiHwpapis/DdNgzkhnR9BrTKsXk1TSZM22p5eS/p9/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 04:30:34 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.004; Thu, 26 Mar 2026
 04:30:34 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Mar 2026 13:30:30 +0900
Message-Id: <DHCFJSHKE4ZB.3M1FFI3K5R670@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
References: <20260323-cmdq-ub-fix-v2-1-77d1213c3f7f@nvidia.com>
 <DHAB9Z571FPB.25927BK1RGNGL@garyguo.net>
 <DHB3CGY1Z5HF.1KSJV8SP8YD8A@nvidia.com>
 <DHB40HKJD3OC.OMC04LASMS4G@garyguo.net>
In-Reply-To: <DHB40HKJD3OC.OMC04LASMS4G@garyguo.net>
X-ClientProxiedBy: TY4PR01CA0007.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::10) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3feefc-ed4b-41b5-6883-08de8af06bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: /xlxuyA3VLxavzHN3DpcyTZXqLtKOEoa/KZTxYRftlRlxQ00xpoWPfufgq7lmoH6K3wpneIvUhC/MeoCrQthBJ+TIHwLrHhh7stzjpWEo0DMMNTXu4QdDfYvL4R//enyfhFu/qamTblALcNwMtTgJaXCnvuKD5//vAUz5OmUT38OKtz0x4xYxJnrlU+QRNIkFWuecdRcwTqCuvZxGXvl1Frv2BIMYQqoa0mNIcr4LYzHI29hkMp2VaLLruxUT2db+TjfL/9DBUacW1oS+YLjY//Om0tHi8eoLfS/Rt2b9VK5t3/bkghg/hiskckskGgpoCAiKL3yLJ0/PBmuZpNCTcD77LvsuV/VurI5cPK/L8TUylzdtwaX6MMdmEO+iIxyDk/r3W4Dcpu4Gyn8sEUbhBh+MLvNOnWVlYGDpNtQysrRk57Q7WQuvnT9OuzZ8nYF2KXAinZ4ToV4hsM3D8r6TYcqPAV//s7OtJNJHS70498bC89c73WRGpybBNYRh74lGxM1A79ITWwmEnBWnYeaMtbYYovABjw+G7H8L6dci1Eu3rHSi1LQi8tSNC6YzUcR5WjtQC2VqOeGxGdGcM1BUbWSLLw4neaeo9IsMxgKjZjUowrLIUXxnl1DORA8irkqcUgObd1WUKtm3iIMUNDvhZmSuO+GFWMluqU081yLH8ahlRWqqYMpLrGKxXZUaKhQqSeqJzBkfR6WG3FkFS6P8fF1qM2pPlNxZ3Rwy+KjeQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHRjUGxlbXBxSVo2bERxTkcwdkZVa3IyZUh0cXBUaGhuRFBtOU4yWEwrMWdQ?=
 =?utf-8?B?c0EyWXhHT2NDNmFZMEg5aVNsbm45b0VxQ3paR1E2MXV2RSt1UCtzbkNBT2Z6?=
 =?utf-8?B?cXJ5cmJ6VnJpTWhncVFLaXQ1QmI4amJvUmxmS1lsQS9QajV6bjNoRjYwc3A3?=
 =?utf-8?B?NDB6QVJ0blNXYTF2MG4vNWJoL1hjU3oxYXdoQ09KbFpZelQ0T0kxa1h1aVZi?=
 =?utf-8?B?cWhmZVhLM09RelRyeG1hbWUxUmsweHN6NjhXK2Z2MTg0R1pTRXRrWGgzMElP?=
 =?utf-8?B?a0t3NHBreGgybjZJNXNXYUR0Sytad3o4YlpIRkhtaStEeWQzNWNLT0dZdWMw?=
 =?utf-8?B?VHJzUWswOHhJZGNhSFF4T3pLVzBWcWJnNkFYb2Y4L28yeUFZM2RwTHRTTkcz?=
 =?utf-8?B?amtndmZDeVdlOExla1IrWG11VE9KUGsreUpVb2xhRHRnQkZVZDR1ODBWY1Bk?=
 =?utf-8?B?bjNaMnNaMkNXZmRveEZpWFFoVXlEMldFOFFVMGUra01GRWhoYTRXWE15VWFu?=
 =?utf-8?B?c3BDWitGTEZINlptZDB1NmhsYk9USGVKbTR6d2JJQkMvNGVxOXRZMWplK2dS?=
 =?utf-8?B?dHRzTlorQVRzNzd4cEh6Y0FFODhvRHpzelNyYkdReFpFMlh4eWNnOUE4WnMx?=
 =?utf-8?B?SW5OYWhZS2ZMZTRqUlJDdW5Gc1d0R2psdWpzV2tQZkgwS0w0MGF3a0tSbm9y?=
 =?utf-8?B?aVR4d0NTUFpYbjJMV2NnVlRMZkZ1MkdBTW1ndUZjZnV0SS91cDNmdGRaYU1m?=
 =?utf-8?B?L1dobDgxekV1TWs2UjNRbHJVRlFoSWVqcUtDcXFXZjhadWZNQzArN3ZOSkNi?=
 =?utf-8?B?TmlWYTlrMXI1OHhSS2IwWEkxRmo0bHd4ZzIwb203SGlMVFhaczR6eGJTK2cx?=
 =?utf-8?B?c0tKd21tSGVpL2IwMkhkZkVid0MrcFpDbXVzdFFJKzRSb0ZKdG9JMDJRTzMx?=
 =?utf-8?B?Z2cwWGxLV09HWmNObkRhdk5jakZCeWFOdDZhYzhaTm5tbVRvOUg4VGpTVitn?=
 =?utf-8?B?Y3pFZE5XYkJPZXhXZHZLKzFMTUlJai9RNXRaTlZyaHh2d2o5TXd3cnNRcXE3?=
 =?utf-8?B?NTd4MTRGYkJhZTh6bEl4dGszQ29nOS8vNWhsOW83a3BzMHNzaHdkNFY0d0hU?=
 =?utf-8?B?UGYyZjRsVDc3U01sUEdXY0prQnV2L0xQbXV0QTlMaFVHb0tCZ2FjYWJvOUxw?=
 =?utf-8?B?ckFMeUZFL1o4N1NINElrdUNaYmx6V0E3MGxSMjdyZHZTeCsycStQbEJ2YVNT?=
 =?utf-8?B?ZzVZT1F4dFgyb216QkZoVDF2Tkx1T2JrSloralduQ1FNVTNpZW5wN0pOMUhr?=
 =?utf-8?B?YlNRUTBkMmtCeGdGQ1VmdXp1RFU2VURCODRvVkdxbWsrTjZPeWJRcnFRUWUx?=
 =?utf-8?B?R2tuWlZwUzRPTXk3RmNOMXkyQVdMVXU5ci9laTJ6eW9ndmlKVy8zb3YyOTdW?=
 =?utf-8?B?L1Y0MS9paU15SFVqaXhMd3ZTcy8ydUk2VTlPRjB2aHFzL0ZJR2NidFhhVnl2?=
 =?utf-8?B?V1o5UzV5c3dicmhjSFVsVmRLMjY5bFBlclpFVlFnc3R0U1pZNEZ6STdXV2JJ?=
 =?utf-8?B?aEtVMnRtOTN6WWxCRUVhOUJlTlB5SWJkVHdTNzFFZG9UdVZIY1NkQjhINE9E?=
 =?utf-8?B?Nk5nVk9iQTdIS3dwVjZ6UkczNkEwazZCRWkwaXIwZnBTZVBPZjRIamthb0hP?=
 =?utf-8?B?SXNMWkhTSEwwcGh3dDN0b2FHQ0N6NjM2clNld1l4cHV3WXFLL1JtV1lPR0J6?=
 =?utf-8?B?U25vaks1dVRleStGeWFSZDFwempuNGpYclpXcEIrNmlRNTlDQzF1VEpjVzQr?=
 =?utf-8?B?QjlwZ1RUTjMrRkhlRVNwbFNsUnF4WFZ6MFJLUE5YaGJtNUlKZUh5c3J1UjFy?=
 =?utf-8?B?Q1k2OStjZzUvTmk5VzRwSW9vd2NOam91bzA3emR4TkhWbjBDcDk4SUhQNlk2?=
 =?utf-8?B?YmpLWDZiemFCZkF2ME5LV2dyT214OXB5dGFjclIxd1h1cEhNQi82elV0MEpY?=
 =?utf-8?B?UVRKVmFXRUNreDVLZy8rS2hCQkZqSUF3ZnRqRmp0M01NNnJ5WDBSbGM0bjZl?=
 =?utf-8?B?K0xUWWRZVTJxTjFSb0hUVE9kd0NweFJGTEYrLzNrazIyVUZ5dTZoS3g0Nlo4?=
 =?utf-8?B?QWxhZTF3azAwanRhc25keGYyeUg3ZG4zd3MydVpNQjZQUHpnVzliTjF6Y0xi?=
 =?utf-8?B?UDR2bGR5U3ZldStsSFR0bzNlcWdYTWlEV0pFbW0rbC9qN2NoSFNhWEpBeWNC?=
 =?utf-8?B?V2lNRTVtQUt1Z2tUZEtZenkyeHpjZFN0dVV0a0d6ZHB6OTl6WWdqRWVzaHJ3?=
 =?utf-8?B?SFdGZmNxWDJ4WnprcUo0SExQNnlwVUFLbzdtZWxrMjlvYlVYenErQUlQZ1Zl?=
 =?utf-8?Q?CPeG2SwgBpcDsSa4SjbBrjZ6w8pUA/QN5xBp4i3/GmC8/?=
X-MS-Exchange-AntiSpam-MessageData-1: +EkAuzuvOl0TAA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3feefc-ed4b-41b5-6883-08de8af06bc5
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 04:30:34.1254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xu2X/sR7QNWNNRujzwBNMUocSdUx+JYhUESB1sXcAC4O3Q2KF4ev8neO1joeSfg0kk5sc5p662n0x4/811FvGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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

On Wed Mar 25, 2026 at 12:15 AM JST, Gary Guo wrote:
> On Tue Mar 24, 2026 at 2:44 PM GMT, Alexandre Courbot wrote:
>> On Tue Mar 24, 2026 at 1:44 AM JST, Gary Guo wrote:
>>> On Mon Mar 23, 2026 at 5:40 AM GMT, Alexandre Courbot wrote:
>>>> `driver_read_area` and `driver_write_area` are internal methods that
>>>> return slices containing the area of the command queue buffer that the
>>>> driver has exclusive read or write access, respectively.
>>>>
>>>> While their returned value is correct and safe to use, internally they
>>>> temporarily create a reference to the whole command-buffer slice,
>>>> including GSP-owned regions. These regions can change without notice,
>>>> and thus creating a slice to them is undefined behavior.
>>>>
>>>> Fix this by replacing the slice logic with pointer arithmetic and
>>>> creating slices to valid regions only. It adds unsafe code, but should
>>>> be mostly replaced by `IoView` and `IoSlice` once they land.
>>>>
>>>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindi=
ngs and handling")
>>>> Reported-by: Danilo Krummrich <dakr@kernel.org>
>>>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.=
org/
>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>> ---
>>>> I didn't apply Eliot's Reviewed-by because the code has changed
>>>> drastically. The logic should remain identical though.
>>>> ---
>>>> Changes in v2:
>>>> - Use `u32_as_usize` consistently.
>>>> - Reduce the number of `unsafe` blocks by computing the end offset of
>>>>   the returned slices and creating them at the end, in one step.
>>>> - Take advantage of the fact that both slices have the same start inde=
x
>>>>   regardless of the branch chosen.
>>>> - Improve safety comments.
>>>> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f6=
e8f3ce3@nvidia.com
>>>
>>> Here's the diff that fixes the issue using I/O projection
>>> https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-gary@ke=
rnel.org/
>>
>> Should we apply or drop this patch meanwhile? I/O projections are still
>> undergoing review, but I'm fine with dropping it if Danilo thinks we can
>> live a bit longer with that UB. It's not like the driver is actively
>> doing anything useful yet anyway.
>
> I want to avoid big changes back and forth. We could use raw pointer proj=
ection
> today, which could be fairly easy to convert to I/O projection:

Thanks for the diff. I have adapted it to work on top of Danilo's
suggestion to compute the end indices first as it works just as well and
is cleaner. I have been running into a link error with this conversion
applied though - let's discuss that on v3.

