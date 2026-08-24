Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDACC5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:27:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8921E10E551;
	Mon, 24 Aug 2026 15:27:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PZMjVGFj";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F74F10E551
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 15:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfGWq7lewnX4nrDhXhwEKqtXvjzwkVAiFPZnS0JWm/FJz/6tt2evFRlE8oLMpsBFDmvSVPM0MTvkhWRIKxlh119hEwfev94j88XQugDZfiI6x0bB6VyELEV4zHKuGg/LoWgYmvQU6ekYnAROTEaPn1el0M0odfk9KpN6UuRci2jmZCs1gN7Ts+CZRW1FUxjGKNW3DEVaEqlielwi4L09bg14roOmYWGoABdYSvI32n8xI26nqEDetZQCaB10yarmljmukvR4AEC813byZw8+pjgH5m1EThlLzViFR3QcAo0W6f6Gi9OYd2wG4Nr1bK4jEaNfWzl9M2OdBUx1n8GmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlnKj2UlGGHtzRsWjq+HAaFjBDDvAI+Q2Gs03sf+HN0=;
 b=V1sl/y/Baw/0XL9CDtEKRywPYAxvLmhyxXcOfgnLJBEXDX7PKxGvF8NuGrWgsy12Df+r/GVJJ6FrGXqTgYtyR+4xjbW+DvJJOV0C7Y+FDjP8ha2gs61eU0bcB2PJM3BzoYJQ8hcFqlbOOg0l4YWw5lhWluJOK8uJohh/2rPHyFiHnX3a9TH81+yN7t2FGRooi1qNT6zFxWZY9dOeV9oxIQXHZjTC22+RVB3sp81m9R45hYa+g2LfwL8Wy6386pWR0wm+MtK2xd5c6X0toYlayXQhnnbeOszX4iOM2uJrDw3K7JN2A2axAbj9UIE2J0KmscZIP0nqbVU14uh9UzgMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlnKj2UlGGHtzRsWjq+HAaFjBDDvAI+Q2Gs03sf+HN0=;
 b=PZMjVGFj0952+8A59LX3l8OVkcNRAD+XkioYw0zd44d9425YqOBNWgypV36OpeY2GM/y+/SgoxCsCfcUssZUMdhpn1dOyEmY4zc6S+Bjm6j9ADu7g1gfp2ux6YChE5eWmcBvLyUxLh9QDFMRU/N+yGv5/THbeF1ACBmXfdXuc5d/b4f4OxXhdhwDE9EANmRrwzgMOFNHRiDVWY+uk2EWC1Sxwurf/US9lAPltbdtQSRPcNxX5Gp0vfRaRZTWCFwW8pI/oJsD6j/ELArIjsKdaPBHozW4cnMapc8YePwo2aPHtHZGnLUUwwcscyOtVaap6OCL7AnxkRf5uoxcBb8JaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ5PPFB332093D3.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::99f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:26:59 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0315.014; Mon, 24 Aug 2026
 15:26:59 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 00:26:56 +0900
Message-Id: <DKXA2NLQB1K8.1XDE2JYIJTQ25@nvidia.com>
Cc: "Antonin Malzieu Ridolfi via B4 Relay"
 <devnull+dev.nanonej.com@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: Extract FUSE registers definitions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Nanonej Dev" <dev@nanonej.com>
References: <20260817-b4-extract-fuse-registers-to-gpu-mod-v1-1-c4924070bbb0@nanonej.com>
 <DKWTK2FWW5PT.13WXH8LCISUT7@nvidia.com>
 <1COg2hERAjDijZlXX0uknmkpjlWBxyXWaxdvBX2tGZgcaYyhUhe25d5WGeosMVh_Tri5YELYViaNEl0PHR_Z01L6IdvfuZdjRZtc2TQj_Kw=@nanonej.com>
In-Reply-To: <1COg2hERAjDijZlXX0uknmkpjlWBxyXWaxdvBX2tGZgcaYyhUhe25d5WGeosMVh_Tri5YELYViaNEl0PHR_Z01L6IdvfuZdjRZtc2TQj_Kw=@nanonej.com>
X-ClientProxiedBy: TY6P286CA0005.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::13) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ5PPFB332093D3:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adbfc77-bf8d-47cf-02f4-08df01f423be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|23010399003|1800799024|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0wKyP2Wh1wPkuPR0A3ZkqijhKoKU9UJKZCv4zFSi+8JcEgstm5DjBXq8yQQunn0mPcPejF1KHPp4VjrTbri67AxHkUcrZ7Bic7vlcv95MNzHMi4AtAx42XxuN2zf5h5KpkqsPghyWoz1+3hZdWL2aDVPZ+94w2ZzZiWOTzh3K2amzA/iKcK4/qrelehCQRrtQPnC1CNE8jTh/Odo8ClZPJWuyt1f0kOt/ft8yRMhhaetTkoY904i/lU/7oBEPtQ4hBY/waUiL3XcpKCnf6TdWuiq6gx1bBgG7YAxP8LrJ0N8+/sMZgLA5wnQiqfFO3Mf2GakeC5Bw58AHW9bktz3jW5JXOcEn1AL54ByzoE4qvXmFwpJPI0gd1w4qahuI/UHsxIuRDtP8NgkGrCgfPtb57baATWjl5EJ7Ocd4OrqnkfeVaTkpj6fTpJ5TRwkfYyacxWPN2Aiq1YewAf41/2oXnbOXG2EpTlD5DbaGQjm0sNLCkjUtvKeqyJUWpAq/98yVbyYQ/FxAXfj20V/wtGbp10yiXFUNt2PkzihV8QYOD+3VcAiABXL+WWP+Xb7RYQClIl9wVChcZMNr1UuiOG7Q9n2ni0c1RNWZwTfGv/WtvbX5YMFMELh63Dqq/+MaO2EBC4WCvT7Uui6XvKPnPgt5FGdm4zBtyXrVx96AFFBSzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDlJRGI0TTA2Vk5wb2s4dG1RSnhzWUUvQmh6RGRsNTVNZ3luL3hsUTF0U3pl?=
 =?utf-8?B?bmo3YkVSeVFDajZ6ZE9pYm1EK1h6cnd2Mlh2WmRSNDBWdFdQNUJGd1RCNExp?=
 =?utf-8?B?bE9FU2F1RnZQQzEwakZoRDYzeXl4eWE4S3daVXU1V3ZmSzIwalQ3RzRFRmpt?=
 =?utf-8?B?OGVQNFNzeWxBd2lOVndiNDNIbTdjZnpkL2dVUUFLMVFNTFRTM0tua1VpTWc4?=
 =?utf-8?B?aTV5emRPUTZpNjc1d3dNc2gwRXpYTHUvYWNjcHdBenhVekhaNGk2dlZxM2ZB?=
 =?utf-8?B?ZzBRdUxLaDhMVnN4S2x1VkhwUEhMUHkxYlo4ZzhML2E1QW4yeTBrNnFEWHMy?=
 =?utf-8?B?RGh3TnBNRWdGcDg3NFI4MjkzMFBYR0dxS2Z2Qi9VZ2VnbUhqbVNEc1pNdkMv?=
 =?utf-8?B?eEhydlBRU2Q4a25TV1o2TTJBOXVRVTdyMlFrNThFbVFUL0N4ZVFQYUlZSHJp?=
 =?utf-8?B?NGtTeDZTQTM5bG9wOUpZMVlPWlo4Z1N5NEtDU0k4SWx3ejRqOHJVNjFhYTBV?=
 =?utf-8?B?QWdXekpuZXJlemlFVTlhdlFwWDk4dWRNeFFNQWxFeGF5bll4YzNPSHVNTytq?=
 =?utf-8?B?ai9Xa0tCRGp1eGJ0NlI2MjBHK1FqUnJZOVY0T0ZqQUdBb1FVWjlSV2NUNnFG?=
 =?utf-8?B?YjdNaFpNbWFZRlIyWmVSNXVvVzd0eWFrNFdDZkJiWHNTWjdhcGlQQTF4TVhD?=
 =?utf-8?B?V01Bak9DRmVwSExrYmtYeGoyalB5WTNabDBYMkVhUFBlM1Mwb0FGMHJ4aWpV?=
 =?utf-8?B?S2hJYWwyNEJQcnNPRFJtK0RjWVlKbXNwcVhWTHFMSEQ3cTNVWnlNQWhxeEhD?=
 =?utf-8?B?MERBbS96SnVaRUFtb1NQbEgxM3pnS0kzd2kzOStWWWpNTkJpU0d5RWZ5NU9X?=
 =?utf-8?B?dkVTcmVCelZXTWZvWWtSanBoWW9YT3Jxd2VVUU9XSkNzTngwdk5QbUZTVXlo?=
 =?utf-8?B?MitXSXpMQ2VPWGR5WklIc0daRkhCOUJHcXBVc3N6dUgzdFlRdndOSEVycHFk?=
 =?utf-8?B?Mjl6SlhudFVLa1UrNVQ1MzBXaFYwNE1UVU0zdDAzblBGcTh3MjQwMUhMUUo1?=
 =?utf-8?B?L00zWWpOR1BpR1gvc2ZrRTZobzQycmVBTzZjYm9mU1BSOW1qQVc3SGpYNndv?=
 =?utf-8?B?bDV0WWhEMTFFcHdBcGtqMUlhNi9qSVFKWnJiQjdBaFExZUtSd3dpR1FwRXpm?=
 =?utf-8?B?WnlLdjNraW43eXR3N3pSY1JheTlRT1ByVHU1N1Bod0kzdzhpaThibklleHlK?=
 =?utf-8?B?ZTFja1A0VzlxV3BVNUU2amxlNUtIMzVxeFlEc1RqMnJPNDRDVTMvb3hzM0VZ?=
 =?utf-8?B?VndwNXptOHh0QjBrUkhuNjZSSWpaWXE2RjhibDA1SVluVnJlQWxxUlNqSXIz?=
 =?utf-8?B?TEpKTXZ2WGhQSFRScXd6M0NJa3ZhOWZUU3gwcjYvbVczMFJSTzF6UnkvdDJU?=
 =?utf-8?B?WFluODJPY3ExRjF1bmw5amdQZFhyTGpIT204VjFtTFB6NHJpYThsY2FkYnFP?=
 =?utf-8?B?bXpDNk9VNUhLVmlNcGYwZURyakVQR010MkZRN0daZUd4YXJBeW9lVDlzc3VM?=
 =?utf-8?B?ckE1YzFqZkRUajlCb1J1WjdZMjlMRVUzeGhlVDdPZGVvR2ptN0ZVYkZOYVlq?=
 =?utf-8?B?MGh6UFYyWFp5dDd2R0s3KzFLNzNEcElqZ2QreWhaLzJXYVVVOWcwQ2w3TmZh?=
 =?utf-8?B?VTZxbGpBcFdGMlV2Yi9aeTNnMHk0bGxUSnJtNUVNRnNMeU1DV1pzczE2citV?=
 =?utf-8?B?SlZYYkJXL1YzUjR5QVU1dlgxc2ZOVlNVZmpnK2ozOXNGdElPY0g3bTZiQjJ1?=
 =?utf-8?B?WUtUNnlWcjRJMWxQRjJPd1JOeUxjaVNnQjJSWTIwenUreFlDWVEwWHNVR1dB?=
 =?utf-8?B?L3pod1ZpQXpDNkUrb1lEa0dNTnA3MjhnNEZ2cnE2QnJ2UExVK0lPV1ZSMnJo?=
 =?utf-8?B?UHZTZk9wMWZjN3BGV2VrWGVLVDh3L2pZMDR6cWRxZ2dHZCsyM29hZ0FuQVRa?=
 =?utf-8?B?VDVZRjNyT25tV01WQ2szSDJxVHhBeGY3UkNyT2RKbkFwOU1Ya0U3VjZhYnZ4?=
 =?utf-8?B?cEM5cDZSMmdsZjdCME56YXhiL3cxOFdVWDNDK2RkNHArQkQ4YXUwS3dLbFBZ?=
 =?utf-8?B?aUpkMTRiajZTekxuQmVNMnN0M1loUFVhQ09VeHlDNm9Ja0xiQUVZei82bWJB?=
 =?utf-8?B?b0VvSnNNeG15TnRWM0E3VjJ6WDRzejluZGZFd0pFMFF5emFBYldHVEFrTWJS?=
 =?utf-8?B?M1dqaDhMaHY0YTNxV2h2R0tEeCtBL1REeXo2dWhMWjlWcVRGOWc2eHY0WTJm?=
 =?utf-8?B?cTRPTm5lUFJ3aGlYaVAxSXcxNGw3WkFaN0x6WmpQQ2JJbXYrNm1vNmZYZ1Fy?=
 =?utf-8?Q?/4CbyypAm1JK51s8AUf/ys9MqBVWUGZ6PDKcyhjGts71o?=
X-MS-Exchange-AntiSpam-MessageData-1: WvfTP3fnPhSaNw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adbfc77-bf8d-47cf-02f4-08df01f423be
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:26:59.4614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +S3DDPxaZ2+tWObC7/naNpOrZO/V+qfLXETxJx6KZNDLlypRltQQaYFfFwAtOrAU+KEuybFFqoJvt9KNs2mimA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB332093D3
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

On Mon Aug 24, 2026 at 6:23 PM JST, Nanonej Dev wrote:
> On Monday, August 24th, 2026 at 04:30, Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>> I am also a bit hesitant to apply this patch as-is. As defined, it only
>> adds an indirection through the `gpu` module for FUSE registers that are
>> only accessed by `falcon` (actually, the `ga102` HAL of `falcon`).
>>=20
>
>> `fuse_ucode_version` does some falcon-specific processing (notably with
>> the engine ID mask), so it looks out-of-place in `gpu.rs`.
>>=20
>
>> Also, the patch doesn't move all the FUSE registers -
>> NV_FUSE_STATUS_OPT_DISPLAY is still in the root's `regs.rs`. That's
>> probably because the destination chosen by this patch is not a good fit
>> to contain them all.
>>=20
>
>> Now I am not quite sure there is a single, good destination for all
>> these registers. We could move these to `falcon` (and
>> NV_FUSE_STATUS_OPT_DISPLAY to `fb`), but this just happens to match what
>> we are doing right now and if another module needs to use them we carry
>> the risk that it will redefine them locally. Or we could have a
>> dedicated `fuse` module only to carry these registers, and some
>> functions to provide the services needed by other modules, including a
>> HAL to read the correct NV_FUSE_STATUS_OPT_DISPLAY register depending on
>> architecture. But that looks a bit overkill so I'd suggest wait-and-see
>> for now. :)
>
> Ok I see, I actually spent the last few days trying to understand better =
what the different parts of the project code was doing and what part of the=
 NVIDIA GPUs it was interacting with.a
> And indeed FUSE, as I understand, doesn't seems to belong tightly to FALC=
ON neither with the future micro-architectures relying more on GSP.
>
> No problem, I learned things and it forced me to finally try to deep-dive=
 more on the driver.

Now to be fair, this is a difficult problem: GPU registers were not
exactly designed to be confined to driver sub-modules, we are trying to
do it because it makes the driver cleaner but the case of FUSE is a bit
specific as these are used all over the place. So the answer might also
very well be that there is not good solution for this particular family
of registers.

>
>> There is also a more insidious issue below.
>>=20
>
>> <...>
>> > @@ -419,3 +424,27 @@ pub(crate) fn new(
>> >  pub(crate) fn boot_0_raw(bar: Bar0<'_>) -> u32 {
>> >      bar.read(regs::NV_PMC_BOOT_0).into_raw()
>> >  }
>> > +
>> > +/// Returns the fuse version matching `engine_id_mask`,
>> > +/// at the given `ucode_idx`.
>> > +/// Returns `None` if no engine matches `engine_id_mask`.
>> > +pub(crate) fn fuse_ucode_version(
>> > +    bar: Bar0<'_>,
>> > +    engine_id_mask: u16,
>> > +    ucode_idx: usize,
>> > +) -> Option<u16> {
>> > +    let version =3D if engine_id_mask & 0x0001 !=3D 0 {
>> > +        bar.read(regs::NV_FUSE_OPT_FPF_SEC2_UCODE1_VERSION::at(ucode_=
idx))
>> > +            .data()
>> > +    } else if engine_id_mask & 0x0004 !=3D 0 {
>> > +        bar.read(regs::NV_FUSE_OPT_FPF_NVDEC_UCODE1_VERSION::at(ucode=
_idx))
>> > +            .data()
>> > +    } else if engine_id_mask & 0x0400 !=3D 0 {
>> > +        bar.read(regs::NV_FUSE_OPT_FPF_GSP_UCODE1_VERSION::at(ucode_i=
dx))
>> > +            .data()
>> > +    } else {
>> > +        return None;
>> > +    };
>> > +
>> > +    Some(version)
>> > +}
>>=20
>
>> This is moot due to the comments above, but this function should be
>> `#[inline(always)]`. The reason is that it uses `at`, which performs a
>> `build_assert!` using `ucode_idx`. If this function is not inlined into
>> its caller, then the range properties asserted by
>> `signature_reg_fuse_version_ga102` won't be visible to the compiler and
>> the `build_assert!` will fail.
>
> Ok! I didn't realize that and it make perfect sense now that you point it=
 out!
> But I'm surprised: How come it's compiling on my side then?! :O

It compiles on mine as well, but we had issues with `build_assert!`
failing with `CONFIG_CC_OPTIMIZE_FOR_SIZE` (see for instance [1]). So
while I cannot prove that there is an actual issue, it remains a
theoretical landmine (like anything that uses `build_assert`) that tends
to trigger on the weirdest possible configs and ends up with you
installing an obscure cross-compiler late at night to try and reproduce
the issue. :P

[1] https://lore.kernel.org/all/20251122-bounded_ints_fix-v1-1-1e07589d4955=
@nvidia.com/
