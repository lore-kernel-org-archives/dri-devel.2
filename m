Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53EE3C54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:35:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F18D10E65E;
	Thu, 30 Jul 2026 06:35:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="I1HcmowJ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE8F210E65E
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:35:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmNRN0hb6hzN3G5vSK1ljsvGh+a6XP8j6LZh8DlsgzuHpR2Vym0HCB62HeAfwk8nABwQn1bOOHga0cvcLep9bg+czwBvZCLRuO97dRE49zwNlFOxKMjOKTxOQN1XP7IU7OUyXccMZz4D+DXQF9X1NHuQqT/8XCU2wFYRI/KiN5Ax03KEo00N0y3TSQ0SZI5nIEyi2KT6JabldBEfgPr6A7lGXPZC/81LQiTpVC0LlucaK/Yapyx3skrF4cs1pWG1CubRUaUt5dpY9t3NTldWN8HsfnRJBjvjURoUHCJu0hwVgwo7YunoaNBCpYtDFm2mXbwke5KrpKKPN0rLeQpPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzWu/MXwmH78q8tUO0970bnWFtSaZIt24Nyu2Bcuh+g=;
 b=PJlLu0ez/6O4+7THatPI/sP5SM5WArF4lL90Q7OtkeGiOVE63/eiObyWiVkA1VpSwTsjW9swNynbBYxbo4/XyGr0yQARy1yKzcmRiysXpkCNKI+Gj8b18Pwb1bprKs/uNMpG5ueqFFSdmP48A9fVLMd4IiaV2Kpj8KPoJmc9zBPn3wQyzLLGJ1DGEA5jqRoLOr0jyvvndmQKGA2lvbUnDgvDJn0tFDBpjISZDFuv8CqaJMpZecA382MEKY5PIFeobeHuTYCDBb3ts7MG5MkpuFTeMRgYCVGqikMeRWVDkjbEwk43kG4uCrLhWvfB9TnozBTPClupulMIMcMNYXIIaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzWu/MXwmH78q8tUO0970bnWFtSaZIt24Nyu2Bcuh+g=;
 b=I1HcmowJ6kFRERE6BZvkpCwumw3X3W3s+bLwQF5nJ3gK310lkRzO9kmQyQOrvav4GeldIP7nAcliKhonkvzC66NwwYgxn3DwffT6/btciV80TZDo6bqYObVd3gfRpOPqk1Q4+oV2xfeuYi3aVTLtgEFFSALA7DAZYUO2nYFLf13maFf+SoD8bLjdIa5m6L7RSUH7KZfxTTF61RyWZ0BEbHBllPzySxQYdI+5e8piTklNEDkmaGNRwd7wWuyYiyyo/ieXjtYOtg5a3sRBwO1KhEeymXIN/w8Kl2ge1umJXs7J2dGv4Ubm9kdV+vag1xypPVna3J9iCwnhFAXX5vwz3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SA1PR12MB6918.namprd12.prod.outlook.com (2603:10b6:806:24d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 06:35:26 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 06:35:25 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: dri-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org,
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH 1/6] drm/tegra: Fix syncobj_in wait return value check
Date: Thu, 30 Jul 2026 15:35:21 +0900
Message-ID: <hH7aFhU2QVyf-vHyUmLRaw@nvidia.com>
In-Reply-To: <20260730045831.BEAF31F000E9@smtp.kernel.org>
References: <20260730-b4-host1x-syncobj-wait-v1-0-afa730410392@nvidia.com>
 <20260730-b4-host1x-syncobj-wait-v1-1-afa730410392@nvidia.com>
 <20260730045831.BEAF31F000E9@smtp.kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6P286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SA1PR12MB6918:EE_
X-MS-Office365-Filtering-Correlation-Id: 721b085f-6f8f-44ed-1ca7-08deee04bd32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|10070799003|23010399003|6133799003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DB/oPZfyzwYrh6z9Q2jncqCTONcZcrzQgQvYcc1+OoQxc+0MUnKW3w+8MvkgddfHMEr8WKUaTBbrzJU/r2DucacjjgOvYYBiZNHHUZpuTag9dObsGrtOS/C5hWGj/nZe20qRoZBfYntPAH8ciW/1ZMegjhkYk5CYZCPu//roaNOii6uL3+xlegQv3uPvuyB3s0U8o2Hei01HrPoOzp7WXlzC3wdrgumdcStJ6Tcnrd+ZqrX4d3ApfAMNpMf9ZpCHcjT2a6BJf5JDSpSwKMZ2kz6NHrj4gNKcIPQkvNDaVSPTTHiiOASd13/jqEqATtTOPP1O8T4O1gWZqw/fz+aogzaKhEkWCKyIYr+o5tMqECoGTLrA2ET9PZS50EyD3xLEwAOFEb8ohTy/15TSjpuHM2VyhENEhzBekqqhZ9qwwl7sbna6+U17LF4lc6K4D9zTj1mFcxOjyB/ssGhj6OmeqKhSg63wpjGkvqhfxF4y0LKHzcIeeNXkOyxtCI39tdHJlZzqjMayotFSb8NsilEJtMlprlBKymMFz4aBPCKHn5UtdboNF1EgZzXY39qG7+y8NRWM3OrcxlOUIp+uZy+2dJ5Eis/Cxm6uG0g+AI0F6mniL6UpA0Hu3wlEkvzjaoqvNjWOnh8Phde6zysTaluCgbTfOOaliejNZbmiUgrVhK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(23010399003)(6133799003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDAvQlBIbzQzWitqNzFMZXdvMm5obm83bUt3ZzB1RmI4K3Fjby9KNVJsaEwv?=
 =?utf-8?B?Y1hhbGRkVmgwNDdVbEd1TW4xR2JUTGZMQUIweGY3bDFpaU91NitkOXpzK3N2?=
 =?utf-8?B?TFVXNXU1enJYU0kxVndQSzZ2MDBKYS9kSUZLaUI4em1FUFp4S3BTUXYzMnli?=
 =?utf-8?B?ZEJ2eG5pUC93NEFxQmFXa3J0bnd5dWFBMnowWmx5TTF6VFgxUjJJcXNWMUsy?=
 =?utf-8?B?VFdTUjZSR3NPYTFIejlISUYyaEc0V0x5SEpRT1oxV0xSd3JlSzVoMHpJL0Vv?=
 =?utf-8?B?b3NkbFN4cElPbEFnU2ZvMEsxL09kTnBJSjIvNnVjbDlpQTE2emczZzJMTE9E?=
 =?utf-8?B?MmxYbUhvUXJFWHN5Y3NodE1MSnFLc0VERFp4SThiWDJsNDQrRURKYVpyOTNM?=
 =?utf-8?B?V1FiV0NKR0NXcFVWNWNEcjQ2cWZnNC9GeGZ3OVAxM29nVnZKWVdGdXFpUWlr?=
 =?utf-8?B?RzJwdWlTRjFXSUwvMzd3anltZUt6QlE1Q0pNQWluK2ozS1FTU0tHa1dEKy9F?=
 =?utf-8?B?azBoc1F4V3lPdWZDdjdwRGsvZVJRTDc4N1VBR3hHVzJySEh5TTJDaVNtYVg2?=
 =?utf-8?B?aHQzQ2lLc3hPMG92QXVyWUgxMlBPWktpS1kzSGpncVNCUk9sTnNSaE12anRr?=
 =?utf-8?B?MEpDN1VKQ0ZPRGxMTDhVL2pEOXVzb3hyRVo2RFNnNFlxZHhad2tYRm44TDU1?=
 =?utf-8?B?dnBGWXYzRHBzQmIvUnkrVm9tc2s2M1UrejE4aTZQRzFXZzRITDBsZ3ZCQXlQ?=
 =?utf-8?B?aDZBNmo0SG9qS3g3SzBKMEdvQ0w0V21LcWdETW9SK1VVblhqeUFOM0VMR0Fz?=
 =?utf-8?B?djZjMDFDUW5UUnhYSzA0bDVMQm5RMkhUc1NLN1IwZDNYd2ExcHhLOCtjRjY1?=
 =?utf-8?B?WkIyMjg4MHNzZ2hoaWcvUVkzRzlxUDI5RjR5aWd0QjAyYU03cUxNdEhSRjd2?=
 =?utf-8?B?clVKVW5zZzBhamk2U2swVFFWeVJKZFNCbnVQTmloeHBlNXRJUldpUG9IRGlo?=
 =?utf-8?B?WkYydTQ1ZlZCYklaQkN0ZzZrYnpsUXlMV0pDamtZcVRTR2IyTGtTQ1MxVkwr?=
 =?utf-8?B?eGZQcHYvcjNWYjNoczZuZnJHdkJvS2gxYys1WElPSHprNEVCUlczTXpMaDRo?=
 =?utf-8?B?YWthQXJ1WWlDWkJvYlF1bzNuejZqc0NkcFRLdk52L0tyMldtTVFJWjF0TDFT?=
 =?utf-8?B?U1ljckZJalFGOTh5WUU3bjVwQ0hRVlFzYkdRUnJrditnY0VndFdLdDBVRno0?=
 =?utf-8?B?TXNOUmZ3TVpZeUhBenBWY25wVng5aWkvUStuWm8rMWtxV01kM0k0WGUzVGts?=
 =?utf-8?B?dzVhNUpjejJpTHFOenQwQ3pDcUw1azZzcmxkM3FmYXdRNjhXdE9kZEVYMTQ0?=
 =?utf-8?B?ZEJlWkNLeEgyZWFmMU9nNEZDbVlEYTB6SktNL3lSd0tMNmsrZGlpRDZiek5T?=
 =?utf-8?B?L1pZUVZDVnMvanZ1eG14eUtFUkNjVkZKRGx1RlBoQVlPMFZRRmxYaUlnbUR4?=
 =?utf-8?B?dnpsOUZLVlNibUJkNVYxazhkWjJObXZKSTkzOThtNG1Gc0F4Qlo2WUE1VnhV?=
 =?utf-8?B?eXhlMjNUOXYrNmcwR2t2Z0NhbHdsb3dkczViQk5vWldPbnZ3ZmMyVnlpVGRO?=
 =?utf-8?B?UHM1Y1lhMWIrQzFNR21sdnVobVJPK1k2VUZHUXlmbDRac1YvNG02SHVnaDJj?=
 =?utf-8?B?Rzh5dTdOOC9CejJoUnZBcHFqMWVsdm9pMmt3RFdTYVNkeFNoVDE0SnFyckJP?=
 =?utf-8?B?VHdYUEg5TjUrZUNqdUY4TGRrSGdtdVFXOW5DYjBXaW4yN3U3NFFTNFNtRUdz?=
 =?utf-8?B?dmR6ZEZLRll6aVdabC84ZjNaSllwanZEblI4Y1pOQ3hGM1dDRlZ0c2t5ZGJi?=
 =?utf-8?B?eFR5dnpubnFVZ0Y0MVBIMXN5VThPTzZIRHA5a1lsSlBValQ3endrUEthMnM3?=
 =?utf-8?B?MC9IaVhGRkkrVi9IclVQTy9zRmpGU1ZkZGdKLytPY3loMUhQWUxIaDkvMnNB?=
 =?utf-8?B?L3k2SnBkZHJuSjUvY29kc2N1cTJkVG4wYTcrbHBrcUMxWkdoeDBqSzZnQ3Fz?=
 =?utf-8?B?bTFzUnRPUlA0NCt1SlRlaFRoS2VqcFNtZy9HSVFDdXNGU3JyVlJDeWU1T3lv?=
 =?utf-8?B?S1pycS8xdUJ2WmNyUU5HQ2ZYcis5V0phSWFTU21YK1ZPU0ZVeitPbVgycFBU?=
 =?utf-8?B?aHA0ZEQrY3lrK2RxUkVUNXdKclB5R0hsZkFURWlHdUU2cDZBd3J3NWw4SHMw?=
 =?utf-8?B?aUc2N01ZSUh6bEVSUVZyME5CTG4wR0lvM1pucW1yazRsb3hmODZ5UG9Gb0xl?=
 =?utf-8?B?cnAydnJZdmRTaFVESFVuNkxUV25iZndaMHZQQ3ZsNDVaTThZaE5qYjFadlN2?=
 =?utf-8?Q?sShISA+NykQ11PbsZHPKIcpH/JNID2WA5SiowKCnqrvRf?=
X-MS-Exchange-AntiSpam-MessageData-1: pIPAGkDyyh2QdA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 721b085f-6f8f-44ed-1ca7-08deee04bd32
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 06:35:25.6988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rma9x5p7R3WUgtPEl6OKHhOKxtWuYFQ6hxbGYi8WM3L/81XLUZpw4l4t/J4SWzgDo6eE7aHdrlIwkSNU4wPImQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6918
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

On Thursday, July 30, 2026 1:58=E2=80=AFPM sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [Critical] If `host1x_fence_create()` fails, it returns an error pointe=
r which is passed to `drm_syncobj_replace_fence()` due to a missing early r=
eturn, causing a kernel crash when dereferenced.
> - [High] The initial reference to the `dma_fence` allocated by `host1x_fe=
nce_create()` is leaked on the success path.
> --

Subsequent patches in the thread fix both issues.

Cheers
Mikko

>=20
> --- Patch [1]: [PATCH 1/6] drm/tegra: Fix syncobj_in wait return value ch=
eck ---
> commit 250614410b887862e5e7b49b5d80c8b53c8aa353
> Author: Mikko Perttunen <mperttunen@nvidia.com>
>=20
> drm/tegra: Fix syncobj_in wait return value check
>=20
> dma_fence_wait_timeout() returns the remaining timeout in jiffies on
> success, zero on timeout, and a negative error code if interrupted. The
> return value was assigned to 'err' and checked as if it were an errno,
> the opposite of the correct logic.
>=20
> Fix the code to use a properly typed variable and check each condition
> correctly.
>=20
> Closes: https://lore.kernel.org/all/aJM_te551jUwnRv7@stanley.mountain/
>=20
> > diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/sub=
mit.c
> > index e5841857c9378..5dad6dc4eb8c3 100644
> > --- a/drivers/gpu/drm/tegra/submit.c
> > +++ b/drivers/gpu/drm/tegra/submit.c
>=20
> [ ... ]
>=20
> [Severity: Critical]
> This is a pre-existing issue, but I noticed a potential problem in
> tegra_drm_ioctl_channel_submit() when handling syncobj_out:
>=20
> 	if (syncobj) {
> 		struct dma_fence *fence =3D host1x_fence_create(job->syncpt, job->syncp=
t_end, true);
> 		if (IS_ERR(fence)) {
> 			err =3D PTR_ERR(fence);
> 			SUBMIT_ERR(context, "failed to create postfence: %d", err);
> 		}
>=20
> 		drm_syncobj_replace_fence(syncobj, fence);
> 	}
>=20
> If host1x_fence_create() fails, it returns an error pointer. Since there =
is
> no early return or goto in the error handling block, the error pointer fa=
lls
> through and is passed to drm_syncobj_replace_fence().
>=20
> Looking at drm_syncobj_replace_fence() in drm_syncobj.c, it calls
> dma_fence_get(fence) which checks 'if (fence)'. This would evaluate to tr=
ue
> for an error pointer, causing an attempt to increment the reference count=
 on
> the invalid pointer.
>=20
> Should there be a 'goto put_job' or similar return path inside the
> IS_ERR(fence) block to avoid this panic?
>=20
> [Severity: High]
> This is also a pre-existing issue, but in the same block of code, does
> this leak the fence on the success path?=20
>=20
> host1x_fence_create() returns a new dma_fence with a reference count of 1=
.
> drm_syncobj_replace_fence() then takes its own reference to the fence by
> calling dma_fence_get().
>=20
> However, I don't see a matching dma_fence_put(fence) in this function
> after drm_syncobj_replace_fence(). Will the initial reference to the fenc=
e
> be leaked for every successful ioctl call using syncobj_out?
>=20
> --=20
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-b4-host1=
x-syncobj-wait-v1-0-afa730410392@nvidia.com?part=3D1




