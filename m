Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08906C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 06:56:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E6210F3AD;
	Thu,  9 Jul 2026 06:56:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZLokRIUh";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012056.outbound.protection.outlook.com [52.101.43.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B08F310F3AD
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:56:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/e4Uw+3rZXeg5tDxgPcM08UVwkoULHSV01lYYMavfO44wfcoi1DpsbTAtmgzmN4b5a4PTP3kCESoDLmzVQFwcTX24F48qe+iVtGHdZQO3HM4tsDeGJZhC6tlmf7p/7/4BeSb4WsNE9TjH4WSPmxPeJXuIzfjLRGPfUgCMHO9xKzPajeeSz0bsgp3TiI63bP7lr+4qnyF+ZIt41rNM13aU42jFfZ+j+8zD1DrO5pe4aqRO1kfdTcI8mx+tc/o6IvQNBwx+n3yNeyQlyv1NdA5dPjf7fNiVFqaI+vn1odMaV73gAHUu2r5nx/UcQZig9p1/uMzu4gucw/FXn6LZR58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/drE/PP8UAxmsNm2SRu14/Oaa6y2YsL2mj6ket6enzo=;
 b=YWCowEqyxDdBEZLOAF0uTsXDliT+gFXWeo3p5gzFiPZ7CSuvsks08Apj9D9dFmPZsQlYoD2Y5CPVbm3pbFTZFbdmObPigX11poYDgfXTncPw74LvI5Bb7mmyeoGXFI8klKG6DPyP1SBlbBIOMs7BWRgvg2eJ99cFK55YinFMQhozKVdXMn0aiWvYuYpD65qn+8LhRV4MJoS7j3w7YFY5wVxXvK0NcN+1j0hnFQlblzjZMbgM8vQZ+55h32I/39nojiMStdTed5aEkLOMq0Gt731XJ0IEMfhATuyzFsbm0Ofjy2fhXYoSlph2Wa7ruXlZuXtZRXtuGB0lApWLex1yWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/drE/PP8UAxmsNm2SRu14/Oaa6y2YsL2mj6ket6enzo=;
 b=ZLokRIUhn5IERUj0DXJVuUAzE+7YCT0HlgYJIrN0Gwl73IjEMqwAg3f77fr7tP7QG1vY5icR3Abp/6oUzA0sazZT/BQz5nCHYkjAcj6xVFlaWI44pGtiOxcI1Jk+K10RQV2svkEyHu8fxvOjKkXglt6EHaaDpLwfdy1McrpnqndkvHNpGJA0yGQ/YtfNzPP5yLf2qJYCitC3enmcVrRszXseReYGDLpOyqFVAUMTs/EoYdTtn616svGMEgM10DKwPEzIiFbWUKyJK5aJAD08UAkHcKljgnOI8/pQQxy87LdgtkGvnRQErpnsQrkJqkAzuEjq3K9QoRu4XpVE/Iqr/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 06:56:32 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 06:56:32 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v6 00/13] gpu: nova-core: consolidate and streamline GSP
 boot process
Date: Thu, 09 Jul 2026 15:52:53 +0900
Message-Id: <20260709-nova-bootcontext-v6-0-520cbf8b9b50@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XO3U4DIRAF4FdpuBbD/y5e+R7GCxaGFhNBgZKaZ
 t9dtpq0Zjf18kxmvjlnVCAHKOhpd0YZWighxR7Uww7Zg4l7wMH1jBhhiiiqcUzN4CmlalOscKp
 YEOoUJQOMfkL97CODD6cL+fL6k8txegNbF+d3I8Pnsf+q17VDKDXlr0uRRpfpnZ+NYoKFpJpbR
 wwD+RxbcME82vSOFq2xG4GxDYF1gTgHxluivHQrgd8KWx14F5iyE9MAowNYCeI/QXRBSq7dKJS
 WmqwEeRUGMmwIsgtgjdNcKD4O/o8wz/M3yxK7fuABAAA=
X-Change-ID: 20260619-nova-bootcontext-401d6107e8fb
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TY4P301CA0103.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::18) To MN2PR12MB3997.namprd12.prod.outlook.com
 (2603:10b6:208:161::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: 424376bd-0431-45df-8125-08dedd873595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|10070799003|1800799024|11063799006|56012099006|921020|18002099003;
X-Microsoft-Antispam-Message-Info: 2NgP5fthZmp1uaPTDgqx0GxWAelZZlclVyi3YcZJR4YsJj7uEuXjTuavbbgg0jsDzddStslK62Mkb+cXsvwlDv1SrTNTBHIzltrn85rmu5i10NHcjLO2pf1gNHJlBMPkM43fjUM9jWHL1EapozlxtzRFR5WVcCDD+YWO78DHS+fE5Ltm9pBGNIPK2QkRKmL5urDC3X7oRy0tuCXX9+tN/K0djRG4nqIETBMT4r1qEBMeDz8GFtEJPV4wqXn/dd3+Fz3TD3aMKclvFcgEnntFeUJN+eWz3OpFJWCCXpjx63gcNmS7LwzoMfsc4CACshIhDITVgDvR+QDZWt2MpeJ+rTu9WWc7bpO1RgkcHt7Gp6zP8k7/JXQe+20PPW1U5Cr5ONLeDfGzIFaT8yFa/Ek9KEk/z+Nba2FYcD9Q51uuOcJvuU7sqd7tYdWQYBAVoboQp90UOGOiDUhvBOfR3ZM9tUNq9Dc1IPpzPy8XyAE/gtLG71BErH64rRgwiaIR1lLzJoHo6GYG/+MLly8hg53lQuCNsQed8noVYZWDgVDYsVD+iHzvxPBzHjPyKJcEa39vXJA2n2cMH5fhXCS8QQbGTwecGi+9oD5YqyflBHiG3FMTVKv4n3JG+undVy2CJYxxjromyim8M7u/gyFEcfeUl6x6MzmPPmnIWPhCbWqobmDwK3pOmHzBE9imOIMM8BUYG/gqGmPC4INCCm9fJA9M+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(10070799003)(1800799024)(11063799006)(56012099006)(921020)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkVCRUo5ZFgrNEZYUE1PNm5vZlY5VXpRUENhTURacHhqRFZCb0xSOUlVNkJ3?=
 =?utf-8?B?TWtWcDhwQitzQU1uU3R0Z2piNDdNUlNjZzYvY3h2NzlrSTl3SjdnVWFBMmFV?=
 =?utf-8?B?YmhNMVRlQVhTOEhEVWVDeUhYaUh6cWhSdFJjd3lMaW5UY3R4SzNobmlkSS8y?=
 =?utf-8?B?cTJEZFlMN1hydFlUVW9xdFd6T1JXZTM5OEI5ejhVMjFRWDhBLzRhdDRibkFp?=
 =?utf-8?B?VGpxMUhBZXZRb016VTlqMjV4bkMyZmdydi9xbW1oNitUd1BKSWlsTEhXUG5E?=
 =?utf-8?B?ZG1Hd3RXZlZYZ2VQSkFkWjBrTyt5Szh1Q3l2MUpXUE9hVDJGOGJQYVJGOXQ1?=
 =?utf-8?B?clY0a3BzWExWL3RqYWx3MFlEWGE4UmhVc3pUWlFOV0N0Uyt1TWVCNTlhZXlz?=
 =?utf-8?B?Z01DQytvMjFNYWt6SWJ2V0hqbDZIMzNIZlMySzRTOXhWWGpaTk5JZVdteU9i?=
 =?utf-8?B?UmNZbGpuNUhYeEpWMGNrSmEvL2R3SEw4bTFKUVhTMCtDU0dyajZZYVhWcVRL?=
 =?utf-8?B?WVZRTVV5RTZiYXZzZjhadHpNWlBZbk53cTRMbm84Uklab1VsUkhMaVlNem5S?=
 =?utf-8?B?SVU4T0dxOHoyb3A5NTBGRjY1QWpQVUY2VE1MNFBkT2d4cjR1Um13Q0krWFZ3?=
 =?utf-8?B?dThnb09uQXJndTNSMFVoZGdRd1o3WllJbHJBbTlXTGRWQWQ2THFpaXdTQ245?=
 =?utf-8?B?cXpEaXlNcHUyWkVJbytrUHM4Z0ZoaktpZmdOcFFkUzUrc3UwbTlUdUZGc0RR?=
 =?utf-8?B?blJveXU5OE5lSFQ0VGZPazBxN1NYbE5PUUIyb1dUaC9zVzgxbEZ2Z1ljM3ZB?=
 =?utf-8?B?UVZya0tMSUNnMDNGeW1SUFp0aWd6WERjUjErcEJEemN1S3YrNnVpOXQrTDlJ?=
 =?utf-8?B?eVdKNUp5WjRlQ1Y0aTdHbVo5QjJzZHluSkxSQng3L0pkU3NYZEUzT0JueFpa?=
 =?utf-8?B?aC9sYWRVY3ZIR1p5cnZrS2lKRDRVUlRhT1JhVVBIQzVNZEE1OHgreWlxN3RG?=
 =?utf-8?B?UnVBR0tFODQ4Z0FCUE52aGxEc2NaUTBNRUxHUG4vUVhONUIyZ1dMWS94TDFJ?=
 =?utf-8?B?dzN2TnM4TUx2aWVldlhyd1VnOGZISktjclo5VklQZkJuWXg2c09BL3dGUTR3?=
 =?utf-8?B?aWgvdUk5aG02ak1RQ3ZMelVIVmxERGNOQ0V2dUU5YTVsVnkxek5jRFE5aFZ6?=
 =?utf-8?B?Z3lKU2ZtMkg2czFDTUpJYUxEQzg5aG80eWwybTFTbHRPS1Q4eEJjeTU1RTN1?=
 =?utf-8?B?Wm9nM0NkOGZSR3FqMXpqRzE4VlVlMTBQNkFMMCtMLzRKMC9WSDNYK1ZyUU00?=
 =?utf-8?B?VC81anZibTAxZ2Ntai9qS1FaMW5NcHhQaUxYM3Aya2ZmdjFqV3Y0RVhTT1dC?=
 =?utf-8?B?NXozTTFmL3Via29nM1lVZ2FNVGRiNWVjZU5FUkloQjdRaWRwNHZvR0lHNWhp?=
 =?utf-8?B?YUk1Nm8wYm9HNS9FdmdpZllDRmVOVllQeDlnRVFqdkJSeHhnRmlSSmhDSkdB?=
 =?utf-8?B?YithVm12ZjBnYWVDdnFZWXBsZTJWMmJpYm0zUG9nc2RFcFJzaEh6QytoczZN?=
 =?utf-8?B?YjU0aEE0VGR3dytBcTdWMTBuUTg0QVh1WmxQdDUwVFFseXdDdU0wRzgzOERs?=
 =?utf-8?B?WHI4R1Uxb0FSVUd1R3dsVHRteVNlS0Zla3JDSTR1Zi9MdGtHOHdvZDJ2RlNP?=
 =?utf-8?B?U3pMT3BRaEp1WmxKNHdia3gyWmdqVHBPcEU2RFgvMDJhb0N4NTk1WDhQcVp3?=
 =?utf-8?B?bDdUOENJQW55VEVLbHlJV0lZVVFFejd0K3dYL2JtWFdkeWV3Mk81S3lVQVR0?=
 =?utf-8?B?czBtOStvaFRHYUtTcVduVWM4cmFiblJMN05wa1NOeVRoc29NRm45bmx5TGd5?=
 =?utf-8?B?SVZSaVkyMitMakMyanQwWVZzS01TRmQ1ODBuY2RqdEd1dFZxSDRCbU5sNWNi?=
 =?utf-8?B?azNFVE95SVFBVUVGdlhIdllGWUxpMFpTNCtsK2xnMmV1YWxsYnBEWnQvTUtF?=
 =?utf-8?B?RUJBWkFKOXRWNEFYQVFPcm5RdU0zUUdCeUZVMVZZTmZ4SVRUY2VHQ2xSeUFv?=
 =?utf-8?B?UElkZWpwZXBtenlNRG5rSFZuaE5PeTQ0aVBnY1NIVVpaNWRBQVIzQWd0Qzkz?=
 =?utf-8?B?enZrZ1A0bEo3NVpDOXR4MXZ3ZWExcmtyb2lkU08vZ253WWZlQzFGcThVN3pK?=
 =?utf-8?B?THp2Tm5pcUhNbnJaZElVR09qcVVlTy9lcU1JeU5rejByMkNSWUVZUjF4Tm5u?=
 =?utf-8?B?UGFUdVlwTmc5bVRsV3I5RURhTGtLQTFoZ2xDQlBJdmE0Zlk0TWp5clBBNFNz?=
 =?utf-8?B?S2dmSkJQdDZ5eEFMaG9rRWhVTTIwa1BYRVRCQThWbjJvdVRoeS9oN04zcjk1?=
 =?utf-8?Q?kcroKdBCoqb0yQn9PV/WhvU1yNRvGzYWVCtQMjp75LJtA?=
X-MS-Exchange-AntiSpam-MessageData-1: rAtvu8a+FHr1TA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424376bd-0431-45df-8125-08dedd873595
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:56:32.3603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjgID/tqJcBnK/XzusPg7cfUQ/sNX4K91zKrUwET+79hNE7dAbmnp07miovLbotoyEU+Ooh6GZcBeNQ+JkY3zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668
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

The recently introduced `GspBootContext` is useful in at least two
other places:

- As a replacement for the sequencer's `GspSequencerParams`,
- As the main parameter of `Gsp::unload`, for symmetry with `Gsp::boot`.

This symmetry can be further exploited to make `Gsp::boot` and
`Gsp::unload` generic over the exact boot context required for the
current chip. Doing so requires some more preliminary work that goes
beyond this series, but this groundwork is needed regardless.

Another cleanup that can be performed as a consequence is the removal of
the `BootUnloadGuard`. This type is cumbersome as it holds extra
references to the boot context, making it difficult to make some of
these references mutable (as we want to do with the `Falcon`s that
should require exclusive access to load and run firmware). Furthermore,
it is only needed a single time in `Gsp::boot`, and is inadequate for
handling errors occurring in HALs.

Based on Eliot's feedback on v4, the series then removes the last
remnants of the boot procedure leaking outside of the HALs, and
consolidates everything within the GSP and FSP HALs.

This series applies on the latest `drm-rust-next`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v6:
- Use `ScopeGuard` in GH100 HAL and do not wait for lockdown release on
  the error path. (thanks Eliot!)
- Link to v5: https://patch.msgid.link/20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com

Changes in v5:
- Make GH100's HAL wait on both GSP lockdown release and GSP RISC-V halt
  in case of error.
- Drop `GspBootMethod` and use HAL abstractions to cover differences in
  boot procedures. (thanks Eliot!)
- Stylistic improvement in TU102 HAL.
- Convert more pdev -> dev in `gpu.rs`.
- Link to v4: https://patch.msgid.link/20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com

Changes in v4:
- Rebase on top of latest `drm-rust-next`.
- Add preparatory patch to separate the different lifetimes at play in
  `GspBootContext`.
- Link to v3: https://patch.msgid.link/20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com

Changes in v3:
- Drop the preparatory closure-only patch.
- Use ScopeGuard for GSP boot-error cleanup.
- Keep TU102 boot-error cleanup local to the HAL.
- Avoid spurious unload-bundle warnings on early failures.
- Keep GH100 FMC boot arguments alive through lockdown release.
- Link to v2: https://patch.msgid.link/20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com

Changes in v2:
- Replace nonexistent `ENODATA` with the more appropriate `EAGAIN`.
- Add patches introducing `GspBootMethod`.
- Add patches moving `Fsp` to `Gpu`.
- Link to v1: https://patch.msgid.link/20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com

---
Alexandre Courbot (12):
      gpu: nova-core: gsp: sequencer: use GspBootContext
      gpu: nova-core: gsp: sequencer: do not store sequence into GspSequencer
      gpu: nova-core: gsp: replace BootUnloadGuard with local handlers
      gpu: nova-core: gsp: pass GspBootContext to unload methods
      gpu: nova-core: gsp: centralize missing unload bundle warnings
      gpu: nova-core: gsp: fold TU102 unload bundle construction into HAL method
      gpu: nova-core: gsp: turn FWSEC execution into HAL method
      gpu: nova-core: gsp: make use of FWSEC bootloader a property of the TU102 HAL
      gpu: nova-core: avoid repeated calls to pci::Device::as_ref
      gpu: nova-core: gsp: pass GspBootContext mutably
      gpu: nova-core: gsp: separate context and GPU lifetimes in GspBootContext
      gpu: nova-core: store Fsp instance in Gpu

Eliot Courtney (1):
      gpu: nova-core: move GSP firmware files decision to GSP HAL

 drivers/gpu/nova-core/firmware.rs       |  25 ++-
 drivers/gpu/nova-core/firmware/fwsec.rs |   5 +-
 drivers/gpu/nova-core/fsp.rs            |  21 +-
 drivers/gpu/nova-core/gpu.rs            |  68 ++++---
 drivers/gpu/nova-core/gsp.rs            |  22 ++-
 drivers/gpu/nova-core/gsp/boot.rs       |  99 +++-------
 drivers/gpu/nova-core/gsp/hal.rs        |  59 +++---
 drivers/gpu/nova-core/gsp/hal/ga102.rs  |  14 ++
 drivers/gpu/nova-core/gsp/hal/gh100.rs  |  53 +++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs  | 330 ++++++++++++++++----------------
 drivers/gpu/nova-core/gsp/sequencer.rs  |  71 +++----
 11 files changed, 374 insertions(+), 393 deletions(-)
---
base-commit: d85845b64c0020b2812243a22fa79d57cc1c1e38
change-id: 20260619-nova-bootcontext-401d6107e8fb

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

