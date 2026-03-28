Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB19910F3DE2
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 14:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1809D10E3D9;
	Sat, 28 Mar 2026 14:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="XLBzZzE3";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F123410E3D9
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 14:53:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hKmPEcNIWfehbUmgbmK4V+u91RdJUSUgszZ0miclnDBgXYR02fGn/TsT23nkUVrB41dlB9BJRYSH9iuycQJOo5x85UR13xXdcx8/owH89ZfY4twpHxISUFQGu60KzxI/89jU7dCw/jx8eCdOyaiwtP1+CZnF0ZC1efsrzTECypGb/TpBnf7Rz+sSv/OPSQpeyzxlhXZFx6xy0szqSRu0qBTnkqYo36wJqUY4UZlqdED4jmh4KBkglXRmrunqJgG8VaAMSulpeRZGF8ccpsGTZO6LquYkX6D5yqrz+19bvgUOAdX7hG0RHrnfHfzedbZ8BCJIHi7h7Wh1aI/MwAZ4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2W6d+7QAk4Wpk+khOLTj28sHTBOwOj+nwUL8weYEsCQ=;
 b=BCT268tUBNdC05MNK8C9cXpxnjHGnk1qvSOvhrECr70uN/pYfKDpBIKQZ70YHpIwTE7HqWCsdgYFgn5ExvsHUP+XQOn6qFo7zqDN/dQo8JLgqbRnvwSQ5b9Kh7qvneepxa5SGySjSj3Zq16l5CKmv8IGYFiH3d92/qQrGKFSFSt0c0yLM7VkFE5jAJD0Mi8cKXIk5tTih5iIgmtOSDrIpXXo+jzUIVJvYUX8rw1u/S5fmBoIIzcw3ewcPT/pv98lqavPJyZZQE5zZzJWFAqo0qUjVbLtitUgCFgPeHCSoWZuXxAiAb08zQpew2xnbhVe+x6fDV/NRb1Iw7PrNGSDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2W6d+7QAk4Wpk+khOLTj28sHTBOwOj+nwUL8weYEsCQ=;
 b=XLBzZzE3z77lC1TV8f1TkG8aOfYSfk/z2GlEXVB8zk3p7DEobLvoaGrzWKdvoAou2GXpMcjcoxt7/EnqeiBJkYPWmUrIijELXkA2cMhtHY90rrALuLA/QMr7dVGFTcNuc97g5crEa9nYKlJZ42Z0ULL68TphP0GkH+SQe+n8I2ODEUUDE6xOkQQZTjh5K0iFtKYtxvOXzwV/elMMoc21k6Lu6zuPydNYdIy16ncl/GP0OyBKqGl3nG3DhEcMQgwi66bP9X0fg/uQbFW2CP0cXIYgBEc98FBG/qsCzVm7qw8klMjdJn7z7U0oM6aSpL2adIqTPJarXKdPyszVHILc4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Sat, 28 Mar
 2026 14:53:50 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9769.004; Sat, 28 Mar 2026
 14:53:50 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 28 Mar 2026 23:53:47 +0900
Message-Id: <DHEI23HSGJRB.15RJSGAFFTMKY@nvidia.com>
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
 <DHCFJSHKE4ZB.3M1FFI3K5R670@nvidia.com>
 <DHCG03J1G63T.1A973DEM7DHQ3@nvidia.com>
 <DHCP6NB4HWXT.2L5XXIX1HNPRY@garyguo.net>
 <DHD5FQ1O1Q60.1C2FZI4A85PQ2@nvidia.com>
 <DHEFUD64AORK.8FOCH0VJAM4B@garyguo.net>
In-Reply-To: <DHEFUD64AORK.8FOCH0VJAM4B@garyguo.net>
X-ClientProxiedBy: TY4P301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bf66ea-07de-41fb-76f6-08de8cd9d291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 25dJPaWtTkwy8f0u3yLI0wWvi1G3UPv2HOhPxRuCwv28/1HY10fRQ46nCkU5t0WaJAXQgPlepWhM/TgNTn2eiqctehlBtCKlayb2HkZPELlR8PQWs1yO/vyJ8gO3QbQsG1ph0h761akeRqAGalijVHwjc+l9JgXZuK+OMkoelbGauhoJBx/7wYAffMUnMr7FPZYVPMWbcktuk19Tx2CirqvELVBkB1l53PxijXP+P2TPfzsIiXGTeSBWkuI+DUgjRVni2XC+CWCCoTq7XoxPi9EZETC1qZrGG/eF8JhvCGhfWoVD9zkXAFX+iTEs9P0XWszOpaz9tizXTcdY7mMiAbADAvbd8wawVfKn7Z7biH9oqIQwOaV47i664PSZMYcI75rfOwJDNP1tqxtPiD3T0P0Wl+8rdD5IKgQmaY94xNBghohF3StL9Hl09E+6xj+fhzUIdq58B/V62hKf3jb8RqRNJ/8bIM0lbnsgQ72hgtiD0ptLFGxebMerhvyMnwI9U8W9YZb+mOl9X2U191WVAEM0lFWc5EP3gy+A38/jyfH1UHorsG/jP/oTXkd76S8FZV17Nu1T31nV7M8iLwpPmiI7XYz8jcQKzRgM6HI5Fpe/T8v9B5vTpsEypnBbBiEurX0BA6z3HLW9lRqb2R1D2+rHzbmQlPJ+2Du2ydggDVFSybfSi8i9TgZdc5t6fJikgOmbpGUCfrauqg0hN3te7lO170+M1P83rnucshxXpjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEZKdVgydXRYZFVKclFiMWNOa2VLRVBlcmFFOFJIRVpFTXNSenY2TEVnRWJs?=
 =?utf-8?B?NWFvMFB6QmwwU3VyaHdvMUhXbTFWUS9Ncm5KSjBnRmh1cEJTNHpETkFjVjRJ?=
 =?utf-8?B?RkgycU5PNnYrRGFpbWxVbFgyTVFWQ3BQblVqd3h4YTZiRUlMTm5kSFBPakVq?=
 =?utf-8?B?RENpNlNHR0dEVSt1eTZSakN5bFhTa29aRmtmaWNmaXlza1ByV2h0bVV5QW9r?=
 =?utf-8?B?SGRPR3BZU3p3UDJPY2JsdVZ4SnlBaUp3WUNobWlNMExLeklrY3loaktEdjlK?=
 =?utf-8?B?bFp4YnVCcWtFWkR6MzhYOWlzNjcxM3dtRmkrSFlHQ3dPT3M0YXErYjdMTjJv?=
 =?utf-8?B?WU0yaHcxbndObkRGRFAvcWo0UHh1TllJRVFmVkFkV1FBbWUvYSsvZm53Y0JO?=
 =?utf-8?B?c0QrYlB1a0F6ZTdiVlgwbnFNS0FIdWNUQThYMTFwOTZuMitKaE4yTkRKRGh3?=
 =?utf-8?B?K3M2eWQrLzk5L283WkFDRzBwWklKejdsS0FhaEp5cXlpYXVST2FOMm5kR00w?=
 =?utf-8?B?M3pSZG5rbUg2TGhyZ2s2ejF1ODFqRzBkMkw4S2hwYVFCU0RoZWM2Mzg1aHU4?=
 =?utf-8?B?QnVTNE1aenYybUNrclBIVXFZbFZXUURaYTIxRW9SU1ZjeGY0QTNJR1dza2xF?=
 =?utf-8?B?REhNZE5LQTR5OHcyNk5CcmlOaFBKNjU2dkt4ZDB3L1JsYTJmNU1kY3JMWDRP?=
 =?utf-8?B?NWRzL2piVGNZUzVrRGd0aU5Ya2QvcFgyalQrM0kwcTd2aVYxbmE2TmRKM3N2?=
 =?utf-8?B?TVRCbmZhQzN1WHR4Sk1udzBqRmZnWTh6WEVveGErSWJIM2RwWFJqSlczY2RG?=
 =?utf-8?B?OUZxV2E5R0tRN0JwT3VqamhWMVZ3TDRDT2VTeUgxanNKdXlrQUEwM2JVWmdv?=
 =?utf-8?B?cDhjWHppQmpZNzNRMUo4NHZLYkc2cGl4a0s4aXpOR0dDRDVMRFM4aU81UTN0?=
 =?utf-8?B?OHlEeXh5R2llKzB5azkzMmVBbVJMaVRQRHpPZ1diYlhrU3NiVFB3Ym1QSFlM?=
 =?utf-8?B?SnFpUjh1dlcrZGduclF6WVl5Tms4VWZyOGtmYnVJMlFqUDVXRXF5U0FUYmpQ?=
 =?utf-8?B?YzV6anJRY2dTZEc3R0FFakF0dEJ3OXlEYzFPZDVXdFBJV1pmdHlqUFlOUC96?=
 =?utf-8?B?OTBsYTBPK3pDTDlYM040eENtMmlHSzc2cWxYOHgrS2VrbEVHUVU3VlJuZW5q?=
 =?utf-8?B?ZEhGZEdQOFVITWc0Uk5QWE9JY1ZKZTlvcElBOEE2czRZYldCTUpPVkhDTys5?=
 =?utf-8?B?QURPUndLMzVIYjgxdThTZUkraXBmTEFuMVEyKzJ6QWxyYyt3Z1BQS3EzNFlI?=
 =?utf-8?B?V1VEUllmaHI4akJIRk1sVWk0ZC9UZ1QzcFU0ZFpiak4wQ2NhN0cxTFlOeFY4?=
 =?utf-8?B?TnNUUDRNekdPeGVOMGtYMXpEZUhXdjN1NFZQS2FuVHo1bWFMczllQ1VodXNQ?=
 =?utf-8?B?dzNURmJXK2pFYUZGUGRuZWRBYlhBdlNvdTBVbGFhVnlrOUwzQVBVMDFSV09t?=
 =?utf-8?B?MzZ5SGVJanpSZVdsc0MwcXR6eWFRcG9wWFNsdW5aVGJVYkkyT0VWd3prT2lk?=
 =?utf-8?B?aFl2eGFybUlXRDhieHR0cjg3aXNmVEd2cFBMNjF2SktuWi9ScE5YR1JQUENL?=
 =?utf-8?B?U1FFbmR0NUo3aU8xbXFMc2pZaStoNlFGL3Y3OFBReGhRT0txTDNLQi9zRjMx?=
 =?utf-8?B?NHQ5N0tPZHg4ZE1lcDNTTEVXMWFlTUR1OWpUdWkya05qRFZWTisxOTZwMWRC?=
 =?utf-8?B?dGRWK281ZUo5MmVJVDkrV2NXNTNkSS90b2xDZTBWVzdsTDdqNVJLN3FpVDlS?=
 =?utf-8?B?MmUyNG5oMXdDL3FSdnBvTmEyTkl4MWZjcDZhTTZEUlI0d3lxVDdVcXFqY0po?=
 =?utf-8?B?K0d5UWh6S0pyMW01T0k0cWlwc2EvUzk5VWtNK3F3bVN2TlBUMXp1VDBYUy9X?=
 =?utf-8?B?RWx1S2FrZVRzYTh2ZlZhOTB5RDk1NGxoOTFmbktlVG9WcDFUUzBtZGZvS29n?=
 =?utf-8?B?YkZqZDVkcjV5eXlxS0hzcFVTa1NLQ1JGVEhtc0k3RzQ5STZNbitJeVdWWDVw?=
 =?utf-8?B?amRJU25CbHZLdnVTZnM1QmcvK2xmbmVRRzExcjM0Y0llL0NQRkRvRk10YmVJ?=
 =?utf-8?B?RXBRZEtERDB0WXphNkhYZHlENTJmK3NqTnhKRm40Sm05KzFzU3pKb2J6SDM1?=
 =?utf-8?B?V3N4M1FzdXNzaTdNQWVCa1NKMEpSL2VRMGhuUWZ4dmFCdE1ldkV3N25tUnZh?=
 =?utf-8?B?VHlFdWlwY245a1ZwaFZQdUh3SDZxNGxWeU5WcGlrM1k0K1RpVUdZb1dJR3Fk?=
 =?utf-8?B?dkhEd3dFRHR4WkFNZ25YdjEwb2FEcTVYa083ZXJZNnNEUmRDd2xkQXBnbHN0?=
 =?utf-8?Q?6H8dXnG3PwgG7O4UXHeldLi+FPxvESwd/q+6UFt782N0O?=
X-MS-Exchange-AntiSpam-MessageData-1: WOmJaw/f90/8Nw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bf66ea-07de-41fb-76f6-08de8cd9d291
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2026 14:53:50.3360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYn/PO9losaC9KQJa94Jjmyr3xQnRkNHAicclFEDOOwGFvSXV8YdoS2xyRKIGTGUxsR8u4ctI9wkfFjoOhajNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754
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

On Sat Mar 28, 2026 at 10:09 PM JST, Gary Guo wrote:
> On Fri Mar 27, 2026 at 12:47 AM GMT, Alexandre Courbot wrote:
>> On Thu Mar 26, 2026 at 9:03 PM JST, Gary Guo wrote:
>>> On Thu Mar 26, 2026 at 4:51 AM GMT, Alexandre Courbot wrote:
>>>> On Thu Mar 26, 2026 at 1:30 PM JST, Alexandre Courbot wrote:
>>>>> On Wed Mar 25, 2026 at 12:15 AM JST, Gary Guo wrote:
>>>>>> On Tue Mar 24, 2026 at 2:44 PM GMT, Alexandre Courbot wrote:
>>>>>>> On Tue Mar 24, 2026 at 1:44 AM JST, Gary Guo wrote:
>>>>>>>> On Mon Mar 23, 2026 at 5:40 AM GMT, Alexandre Courbot wrote:
>>>>>>>>> `driver_read_area` and `driver_write_area` are internal methods t=
hat
>>>>>>>>> return slices containing the area of the command queue buffer tha=
t the
>>>>>>>>> driver has exclusive read or write access, respectively.
>>>>>>>>>
>>>>>>>>> While their returned value is correct and safe to use, internally=
 they
>>>>>>>>> temporarily create a reference to the whole command-buffer slice,
>>>>>>>>> including GSP-owned regions. These regions can change without not=
ice,
>>>>>>>>> and thus creating a slice to them is undefined behavior.
>>>>>>>>>
>>>>>>>>> Fix this by replacing the slice logic with pointer arithmetic and
>>>>>>>>> creating slices to valid regions only. It adds unsafe code, but s=
hould
>>>>>>>>> be mostly replaced by `IoView` and `IoSlice` once they land.
>>>>>>>>>
>>>>>>>>> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue =
bindings and handling")
>>>>>>>>> Reported-by: Danilo Krummrich <dakr@kernel.org>
>>>>>>>>> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@ke=
rnel.org/
>>>>>>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>>>>>>> ---
>>>>>>>>> I didn't apply Eliot's Reviewed-by because the code has changed
>>>>>>>>> drastically. The logic should remain identical though.
>>>>>>>>> ---
>>>>>>>>> Changes in v2:
>>>>>>>>> - Use `u32_as_usize` consistently.
>>>>>>>>> - Reduce the number of `unsafe` blocks by computing the end offse=
t of
>>>>>>>>>   the returned slices and creating them at the end, in one step.
>>>>>>>>> - Take advantage of the fact that both slices have the same start=
 index
>>>>>>>>>   regardless of the branch chosen.
>>>>>>>>> - Improve safety comments.
>>>>>>>>> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-=
0f9f6e8f3ce3@nvidia.com
>>>>>>>>
>>>>>>>> Here's the diff that fixes the issue using I/O projection
>>>>>>>> https://lore.kernel.org/rust-for-linux/20260323153807.1360705-1-ga=
ry@kernel.org/
>>>>>>>
>>>>>>> Should we apply or drop this patch meanwhile? I/O projections are s=
till
>>>>>>> undergoing review, but I'm fine with dropping it if Danilo thinks w=
e can
>>>>>>> live a bit longer with that UB. It's not like the driver is activel=
y
>>>>>>> doing anything useful yet anyway.
>>>>>>
>>>>>> I want to avoid big changes back and forth. We could use raw pointer=
 projection
>>>>>> today, which could be fairly easy to convert to I/O projection:
>>>>>
>>>>> Thanks for the diff. I have adapted it to work on top of Danilo's
>>>>> suggestion to compute the end indices first as it works just as well =
and
>>>>> is cleaner. I have been running into a link error with this conversio=
n
>>>>> applied though - let's discuss that on v3.
>>>>
>>>> Mmm, I guess this was because the optimizer could not prove that the
>>>> slices were within the bounds of the command queue as the expressions
>>>> passed to `ptr::project` were too complex with that version and this
>>>> makes the `ProjectIndex` check fail. I have better luck when doing
>>>> something closer to the diff you pasted.
>>>
>>> I'm considering switching the projectiong `[]` syntax to become panicki=
ng
>>> instead, given that the slicing use case quite often is indeed hard to =
prove
>>> (and also, we already have panicking comments).
>>>
>>> One option is to just change `[]` to do that, another option is adding =
a new
>>> `[]!` syntax to denote panicking projections. I'm more inclined to just=
 the
>>> first one to keep consistency with Rust slicing syntax, but the second =
one is
>>> okay to me too.
>>>
>>> Thoughts?
>>
>> If the slice's validity is hard to prove, then the caller should
>> probably rework their code towards something simpler (like we did with
>> this patch). Allowing a potentially invalid slice to build is just
>> inserting a kernel panic mine, and as you might have noticed from LPC I
>> am not a huge fan of those. :)
>>
>> I think hammering the point about slice validity in the documentation
>> should be enough. We *want* build to fail if the slice can be invalid.
>
> Given the kernel test robot result showing build errors, I am going to ad=
d a
> panicking variant. For the use case here you don't really want to use fal=
lible
> returns (panicking indexing + PANIC comments should be sufficient).
>
> I haven't decided on the syntax yet, I'll put this in the next RfL weekly
> meeting agenda to discuss.

Meanwhile it would be nice to patch that UB though. I'll try and repro
the bot's errors locally to see if we can make it work. (it will have to
land after -rc6 unfortunately).
