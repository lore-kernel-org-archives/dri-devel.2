Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B37F8E4AF
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:50:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A23110E95D;
	Fri, 17 Apr 2026 06:50:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T7/Ur5kb";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC43310E95A;
 Fri, 17 Apr 2026 06:50:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qK084BkDi4g3Hf3FKrWG8E5YwbTAGukuhNBbpER9m1zRvScM4/Zt7hLc/DK1/vG9d6vyUYTm+V+vh+az5YmA9ceJ01XlaHqzpnHBZhCIvXcgEsSeKOiYJWlCmIsfeEqjtis3k8dGK+bT8K5C44IOTWNZpZQsXaRcat3T6tXzkIAp7tU6hDWnKqt6cCgYwmRXVZ2UzF8O9APAZw01aOmM5pPaM2pYnY8w+lWhuOhr3xmxa9xE9xYcyvq13D1+xBcCoBNR/xDI5xUvzXoyRtrq73Doh7x+Xp0Ksv+LqU4yFuvuHRpQeXs3SIEWmhj0NzAUNk50Vv8Tzf8DII6776rrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUYBkIgxtAxOVqVEGEyCm7yxQIaj3q1F5K7IZH8lXpo=;
 b=DzrFAqpk+rGhsrS+qCQHgxgaYhqaI+2WxqTSW7WlTFuAW4Jsi4daIMO6TZpi2mAWjdFjWOg7J7oL4ZDV67tR5t1UO5z5UOiyu+l74NAwlMqQprL9WTdhaV4+tFBErTV997BjqMTOH+SnmHTCP3cdTAMNg4zwQCg2jhcMIRQR3IAOna9fzqKcflmC2k9qcMD2mt+DJTk7Pq2HqMaxptsQ0Hco+bt5xFPlGtyRVTacNtsA4wxnk7LQZkbxJ+54WMvWJWPjE05qnXSY0jChXPDzDWDjPQhgW07wn9IXonnqvURLNaMejYdtrgP84Ikicu6OM583XICDy6EdZBAqLq4t2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUYBkIgxtAxOVqVEGEyCm7yxQIaj3q1F5K7IZH8lXpo=;
 b=T7/Ur5kbm1qccLRF6KFXTO3+ef9PHKnFaPuPEx8GjYLF9v/108M8YPuvgA4spIjwWsPDcUzr7HuLvbjCDEr3GIgiUw1pomJzuUzDmnF6Lv/jBqcfPa6PlUqF5URlQ4itzpKQQrC9VTDFLHFXNatAxYyUxNANQkVSEFKTtCEkaTY=
Received: from IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 17 Apr
 2026 06:49:59 +0000
Received: from IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2]) by IA1PR12MB6307.namprd12.prod.outlook.com
 ([fe80::4739:b181:8a2b:89b2%3]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 06:49:58 +0000
From: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Zheng, Austin" <Austin.Zheng@amd.com>, "Lei, Jun"
 <Jun.Lei@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
CC: Rodrigo Siqueira <siqueira@igalia.com>, "Hung, Alex" <Alex.Hung@amd.com>, 
 "Varone, Dillon" <Dillon.Varone@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/amd/display: Add FPU guards around dcn31/315/316
 update_bw_bounding_box
Thread-Topic: [PATCH] drm/amd/display: Add FPU guards around dcn31/315/316
 update_bw_bounding_box
Thread-Index: AQHczf9IffLgUYQMxUOAoFws0FPyp7Xiz3cf
Date: Fri, 17 Apr 2026 06:49:58 +0000
Message-ID: <IA1PR12MB63074B99C20B81C7D5DFD7C5F8202@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <20260417001503.26147-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260417001503.26147-1-mikhail.v.gavrilov@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-17T06:49:58.877Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB6307:EE_|DS7PR12MB5765:EE_
x-ms-office365-filtering-correlation-id: 6171ec7d-95b6-40f8-1e6a-08de9c4d8ad2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: mTMisTdEp57JQMg/8lsGVjh715UiyVr6666fzk6X2mU7LXv0qJqGXLf3iSLnE2iTsKbfLZ0kPu7qMkCTkzGl7FpvUIhqhQD4tjuAXtaB3qE67HBbKYSlRijb9KxvKkWyRN81mVhW+v93PnnPtb+qcH8kN1a7siJaCR80eaUZ9FUXs1jcORg3gVLD0aNsn2e5jYuDPXl8hoYsCrZZb1zs3663orHqt8OToZXdtrKoWWRo3hZGNKmgB2I3NajPa7yhBB3NZCkUMoorOhxumf5otx1KaXEa5Gb9D8BiiPZRu4OTN1YgzGFAjaOWSFnUnZmZ9RqaBXU+k1Z+UdjHIYkQGue2qLJ5ayTvPum1mSyIVTe7QdCMgj/+HV9zxQ9Wiy0JYf6gWF6Ao0tuzVuWTinE5EMbKp+d0IiG0LnpE3Ui4vNUux/SiCkAE32DWexNriYfIfq3PxYPMHfUvVuRqVZg8eGtVPqgsQbBd1lXElyKVV8CsMm5S3ccJ43ZTkSmFOt1f9INKtgXLEhBKnvOu8JPzlv3KozK16NLhw6bhcnYwh38/TptDygG5emxFnmDyrMPjYh1+6GNulADLFft8lJBOsnVdDkRUrl04TrFad+/g5yYCcPBQZUFmGU7C0P+ZatXo+4/swyQRAaMy4jDVh5UyuE+OWGjYs1eEwIydACElo19BWEfShd4o/GcCgdJ+8cFmJ5fROoKjVgGBj656kQFVgCE3UxMe6qV7JIbZ+fikrcAl8/CEjB/FXF9Ev6KGcPb
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6307.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5ZRPfaCbWIAPSB2rCBOg95o9rTegHnZC5nyizRqIvZSJR5DMD/LIqqc61b?=
 =?iso-8859-1?Q?HedmGgZwiSFyQar8Y4+FVKTcJ7WHSJ+HuMo4JosPWZW+H14Isa0UU+Jo9O?=
 =?iso-8859-1?Q?z4IzxlMyQ5f8ZroV6dS78X9AvyHsZ62De8CGftLuWpg19Y1qk31bpv8EPf?=
 =?iso-8859-1?Q?P8X5HR/BoS9b0dG/UY6sXrjn4bRmBzJAc0srsvtkq0pXEX+atELFeNxRn6?=
 =?iso-8859-1?Q?TUc/1f99iKcHK0HC8HjXYHyamZoWglhaWlglCHZ44wEvXAWCR5fifnZvi4?=
 =?iso-8859-1?Q?eZ2zef2DiAfmKWATqcj4+zbkoGt3zjhRGKQUBIygYPvIY65W+e1tEjZH/Q?=
 =?iso-8859-1?Q?hcKdTY3LBt0SG1XkXXzjcqfHXVxITi1j1O6T1hi6j+g/nN4zqHZ3juI7uv?=
 =?iso-8859-1?Q?xq1gduVEr+qo6GKUnYfk4Etl1F7ew1chDPFa2k/EY8itnvLBg3TZFw/u54?=
 =?iso-8859-1?Q?c982sjNp9jFDmQllsW8YbWI3slm3EoFShxVXidFWfBmmtR/kge+qWELUW8?=
 =?iso-8859-1?Q?a+7b9izIrEEDwiI/rfzhoFPz8BxlLBqjmFHstzI/iodT5f5Q8CDuw2Vc8r?=
 =?iso-8859-1?Q?azsU02rzlicOU8TgypYVqf3CCL40bg6ogumFS1j0vOu/LA1tJoZTBjqB7z?=
 =?iso-8859-1?Q?q4HmuQ/9toyFsErl0lGXXRmDV9iPfJKosYxBxPoelINCGBT+l1JcQmU9fz?=
 =?iso-8859-1?Q?0e5TotS0/DuKWsaSSUicBFpCGMT3xz46eOujV7iUJYyFFF2/EWmtoDuf5W?=
 =?iso-8859-1?Q?J1RJhEdJt6ji1rDUgnjMB0jF22+REY/27snvxO2ufgR17rBWoPiBazTHWR?=
 =?iso-8859-1?Q?gu8Zud608DV03ZTr33jPqQUOx3GQ/+KpBx8li+NxYmii8VMcK/9+DY95FJ?=
 =?iso-8859-1?Q?6a6ldO3TBEbwsey76UekQKOjjjzz0zpx1AIhDBvnSAMEpiSet57OTMCMCb?=
 =?iso-8859-1?Q?qSxwInx8h/3+giZGBNY3baGvkjVff728ek1GE2cBJeEGYddY6rJPZivEx/?=
 =?iso-8859-1?Q?nLpjvTGmK23YAbpH4UWSV0mpmYNuvAL0LPnz8x2F7KrWbRlxyBa9aiavMn?=
 =?iso-8859-1?Q?tLuPoUY/IIZ2Oos4H9y8PjiPo5lxA6iGL4CGtw5NxQ5o4EhyKW7XhKHbGr?=
 =?iso-8859-1?Q?nNzoh6AoK5j1G6vG00nFXiC2j6upTZ79uhqRd1EHHxajRAugNeYprXF6LO?=
 =?iso-8859-1?Q?/SxMlzJPlfEAUV2EU7Jry7zKDpYat5VkUIcoi+9guE7MR7GPZK1my+UWsu?=
 =?iso-8859-1?Q?2M2G7LQaa2jA9S9JagJc1ubMXBKFB6ckK14Z3y+EpcHNzefQrdzQHvnP35?=
 =?iso-8859-1?Q?BVQYFt26bgvIIvKNi9o+5KylkfNh8bsaU/4uBdzNd3nkoqrIfZV+RQMvtV?=
 =?iso-8859-1?Q?w2PV8OHLXspp0BUlvFJd7z8N6A9Y7QerMVQlV7sIR67nLxyIx1/80ETFG9?=
 =?iso-8859-1?Q?yDCPOxVJDIJkE+SAUmtW5VzAxgZZ4SuVkpvzv/e7hVcV9JTjVkC4bp1nkF?=
 =?iso-8859-1?Q?Qckd3xu0w3zrELkQ2UyfdqqWaQqiqNrfjC1yAaR4dDdWCT31tM1qGUtmSs?=
 =?iso-8859-1?Q?n/XoSYIre1v/+5lEC5tQ4mYGODVZHb+Wb+zexT01Pk0NU0gQdn+XsirKbj?=
 =?iso-8859-1?Q?pVDyUF2Y3eAmsg2k4ZT0LAqTN91hJ5CqmgYj7YSa32lOZkUu47UUTf9ChB?=
 =?iso-8859-1?Q?uv1sTEU5pjBgxiDLxnYrb6mcyJmBLGhXTTNdI2dxbXmLCmB74IWjQxblSe?=
 =?iso-8859-1?Q?bg+ursyWJbIJYFGxdtNj3IxsJej95pqjiNsSAJfQiRj5Dr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6307.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6171ec7d-95b6-40f8-1e6a-08de9c4d8ad2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 06:49:58.8152 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbaiH0rrIQ3nUyJb+L7Eb8Huah8jN1tV8pv01oqbqKBG9tvQq8CqqgRZqgLUr67Am6nAHzqRISNtrAXxoDRlWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765
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

Hi Mikhail,=0A=
=0A=
Sorry for problems that occured on your platform.=0A=
This issue is correctly fixed as part of this change: https://patchwork.fre=
edesktop.org/patch/718415/=0A=
Your change seems to be duplicate of above change.=0A=
Please retest using mentioned patch. If it works correctly, please discard =
your change. If problem still occurs please share me details and I will wor=
k on resolving it.=0A=
=0A=
Kind Regards,=0A=
Rafal Ostrowski=0A=
=0A=
> From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>=0A=
> Sent: Friday, April 17, 2026 2:15 AM=0A=
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun =
peng (Leo) <Sunpeng.Li@amd.com>; Zheng, Austin <Austin.Zheng@amd.com>; Lei,=
 Jun <Jun.Lei@amd.com>; David Airlie <airlied@gmail.com>; Simona Vetter <si=
mona@ffwll.ch>=0A=
> Cc: Rodrigo Siqueira <siqueira@igalia.com>; Ostrowski, Rafal <Rafal.Ostro=
wski@amd.com>; Hung, Alex <Alex.Hung@amd.com>; Varone, Dillon <Dillon.Varon=
e@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; =
dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; linux-ke=
rnel@vger.kernel.org <linux-kernel@vger.kernel.org>; Mikhail Gavrilov <mikh=
ail.v.gavrilov@gmail.com>=0A=
> Subject: [PATCH] drm/amd/display: Add FPU guards around dcn31/315/316 upd=
ate_bw_bounding_box=0A=
> =0A=
> =0A=
> [You don't often get email from mikhail.v.gavrilov@gmail.com. Learn why t=
his is important at https://aka.ms/LearnAboutSenderIdentification ]=0A=
> =0A=
> Commit 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC -=
=0A=
> Part 1") moved DC_FP_START/DC_FP_END out of the DML FPU units into the=0A=
> DC resource layer for dcn35, dcn351, dcn36, dcn401 and dcn42, but missed=
=0A=
> the dcn31 family: the dcn31, dcn315 and dcn316 resource pools still wire=
=0A=
> their .update_bw_bounding_box callback directly to the FPU-unit=0A=
> functions dcn31_update_bw_bounding_box(), dcn315_update_bw_bounding_box()=
=0A=
> and dcn316_update_bw_bounding_box() defined in dml/dcn31/dcn31_fpu.c.=0A=
> Those functions call dc_assert_fp_enabled() on entry, which now fires=0A=
> on every amdgpu probe on affected parts because no caller wraps them in=
=0A=
> DC_FP_START/DC_FP_END anymore.=0A=
> =0A=
> Triggered on amdgpu probe on a Ryzen 7000 (Raphael) iGPU, which uses=0A=
> dcn315:=0A=
> =0A=
> =A0WARNING: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/dc_fpu.c:58=
=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0 at dc_assert_fp_enabled+0x14/0x20 [amdgpu]=0A=
> =A0RIP: 0010:dc_assert_fp_enabled+0x14/0x20 [amdgpu]=0A=
> =A0Call Trace:=0A=
> =A0 dcn315_update_bw_bounding_box+0x1c/0x17a0 [amdgpu]=0A=
> =A0 dc_create_resource_pool+0x4a0/0x770 [amdgpu]=0A=
> =A0 dc_construct+0xa0a/0x13b0 [amdgpu]=0A=
> =A0 dc_create+0x6f/0x8b0 [amdgpu]=0A=
> =A0 amdgpu_dm_init+0x740/0xc80 [amdgpu]=0A=
> =A0 dm_hw_init+0x45/0x150 [amdgpu]=0A=
> =A0 amdgpu_device_ip_init+0xe21/0x11e1 [amdgpu]=0A=
> =A0 amdgpu_device_init.cold+0xc03/0x1819 [amdgpu]=0A=
> =A0 amdgpu_driver_load_kms+0x19/0xa0 [amdgpu]=0A=
> =A0 amdgpu_pci_probe+0x371/0xbc0 [amdgpu]=0A=
> =0A=
> Apply the same pattern the offending commit used for dcn35 (and that=0A=
> dcn314 already followed before the commit): rename the FPU-unit entry=0A=
> points with an _fpu suffix and add non-FPU static wrappers in the=0A=
> resource files which provide DC_FP_START/DC_FP_END around the call.=0A=
> =0A=
> Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - P=
art 1")=0A=
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>=0A=
> ---=0A=
> =0A=
> Tested on Ryzen 7000 (Raphael) with RX 7900 XTX discrete GPU, debug=0A=
> kernel (KASAN + LOCKDEP + PREEMPT_FULL). Without the patch, the WARN=0A=
> fires on every boot during amdgpu probe for the iGPU (dcn315). With=0A=
> the patch applied, amdgpu probes cleanly and no dc_assert_fp_enabled=0A=
> warnings occur.=0A=
> =0A=
> =A0drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c=A0=A0=A0=A0=A0=A0=
 | 6 +++---=0A=
> =A0drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h=A0=A0=A0=A0=A0=A0=
 | 6 +++---=0A=
> =A0.../gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c | 7 +++++++=
=0A=
> =A0.../drm/amd/display/dc/resource/dcn315/dcn315_resource.c=A0=A0 | 7 +++=
++++=0A=
> =A0.../drm/amd/display/dc/resource/dcn316/dcn316_resource.c=A0=A0 | 7 +++=
++++=0A=
> =A05 files changed, 27 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c=0A=
> index 1a28061bb9ff..ad23215da9f8 100644=0A=
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c=0A=
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c=0A=
> @@ -587,7 +587,7 @@ void dcn31_calculate_wm_and_dlg_fp(=0A=
> =A0=A0=A0=A0=A0=A0=A0 context->bw_ctx.bw.dcn.compbuf_size_kb =3D context-=
>bw_ctx.dml.ip.config_return_buffer_size_in_kbytes - total_det;=0A=
> =A0}=0A=
> =0A=
> -void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b=
w_params)=0A=
> +void dcn31_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_param=
s *bw_params)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0 struct _vcs_dpi_voltage_scaling_st *s =3D dc->scrat=
ch.update_bw_bounding_box.clock_limits;=0A=
> =A0=A0=A0=A0=A0=A0=A0 struct clk_limit_table *clk_table =3D &bw_params->c=
lk_table;=0A=
> @@ -665,7 +665,7 @@ void dcn31_update_bw_bounding_box(struct dc *dc, stru=
ct clk_bw_params *bw_params=0A=
> =A0=A0=A0=A0=A0=A0=A0 dml_init_instance(&dc->dml, &dcn3_1_soc, &dcn3_1_ip=
, DML_PROJECT_DCN31);=0A=
> =A0}=0A=
> =0A=
> -void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *=
bw_params)=0A=
> +void dcn315_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_para=
ms *bw_params)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0 struct clk_limit_table *clk_table =3D &bw_params->c=
lk_table;=0A=
> =A0=A0=A0=A0=A0=A0=A0 int i, max_dispclk_mhz =3D 0, max_dppclk_mhz =3D 0;=
=0A=
> @@ -726,7 +726,7 @@ void dcn315_update_bw_bounding_box(struct dc *dc, str=
uct clk_bw_params *bw_param=0A=
> =A0=A0=A0=A0=A0=A0=A0 dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_=
ip, DML_PROJECT_DCN315);=0A=
> =A0}=0A=
> =0A=
> -void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *=
bw_params)=0A=
> +void dcn316_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_para=
ms *bw_params)=0A=
> =A0{=0A=
> =A0=A0=A0=A0=A0=A0=A0 struct _vcs_dpi_voltage_scaling_st *s =3D dc->scrat=
ch.update_bw_bounding_box.clock_limits;=0A=
> =A0=A0=A0=A0=A0=A0=A0 struct clk_limit_table *clk_table =3D &bw_params->c=
lk_table;=0A=
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h=0A=
> index dfcc5d50071e..0b7fcbbfd17b 100644=0A=
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h=0A=
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h=0A=
> @@ -44,9 +44,9 @@ void dcn31_calculate_wm_and_dlg_fp(=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int pipe_cnt,=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int vlevel);=0A=
> =0A=
> -void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b=
w_params);=0A=
> -void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *=
bw_params);=0A=
> -void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *=
bw_params);=0A=
> +void dcn31_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_param=
s *bw_params);=0A=
> +void dcn315_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_para=
ms *bw_params);=0A=
> +void dcn316_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_para=
ms *bw_params);=0A=
> =A0int dcn_get_max_non_odm_pix_rate_100hz(struct _vcs_dpi_soc_bounding_bo=
x_st *soc);=0A=
> =A0int dcn_get_approx_det_segs_required_for_pstate(=0A=
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct _vcs_dpi_soc_boundin=
g_box_st *soc,=0A=
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c=0A=
> index ee4bc2c2e73a..d5215a028626 100644=0A=
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c=0A=
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c=0A=
> @@ -1854,6 +1854,13 @@ static struct dc_cap_funcs cap_funcs =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0 .get_dcc_compression_cap =3D dcn20_get_dcc_compress=
ion_cap=0A=
> =A0};=0A=
> =0A=
> +static void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_pa=
rams *bw_params)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 DC_FP_START();=0A=
> +=A0=A0=A0=A0=A0=A0 dcn31_update_bw_bounding_box_fpu(dc, bw_params);=0A=
> +=A0=A0=A0=A0=A0=A0 DC_FP_END();=0A=
> +}=0A=
> +=0A=
> =A0static struct resource_funcs dcn31_res_pool_funcs =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0 .destroy =3D dcn31_destroy_resource_pool,=0A=
> =A0=A0=A0=A0=A0=A0=A0 .link_enc_create =3D dcn31_link_encoder_create,=0A=
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c=0A=
> index 2ca673114841..c48ac609ce7c 100644=0A=
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c=0A=
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn315/dcn315_resource.c=0A=
> @@ -1849,6 +1849,13 @@ static struct dc_cap_funcs cap_funcs =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0 .get_dcc_compression_cap =3D dcn20_get_dcc_compress=
ion_cap=0A=
> =A0};=0A=
> =0A=
> +static void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_p=
arams *bw_params)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 DC_FP_START();=0A=
> +=A0=A0=A0=A0=A0=A0 dcn315_update_bw_bounding_box_fpu(dc, bw_params);=0A=
> +=A0=A0=A0=A0=A0=A0 DC_FP_END();=0A=
> +}=0A=
> +=0A=
> =A0static struct resource_funcs dcn315_res_pool_funcs =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0 .destroy =3D dcn315_destroy_resource_pool,=0A=
> =A0=A0=A0=A0=A0=A0=A0 .link_enc_create =3D dcn31_link_encoder_create,=0A=
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resour=
ce.c b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c=0A=
> index 2242df112a3f..914d91df174c 100644=0A=
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c=0A=
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn316/dcn316_resource.c=0A=
> @@ -1725,6 +1725,13 @@ static struct dc_cap_funcs cap_funcs =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0 .get_dcc_compression_cap =3D dcn20_get_dcc_compress=
ion_cap=0A=
> =A0};=0A=
> =0A=
> +static void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_p=
arams *bw_params)=0A=
> +{=0A=
> +=A0=A0=A0=A0=A0=A0 DC_FP_START();=0A=
> +=A0=A0=A0=A0=A0=A0 dcn316_update_bw_bounding_box_fpu(dc, bw_params);=0A=
> +=A0=A0=A0=A0=A0=A0 DC_FP_END();=0A=
> +}=0A=
> +=0A=
> =A0static struct resource_funcs dcn316_res_pool_funcs =3D {=0A=
> =A0=A0=A0=A0=A0=A0=A0 .destroy =3D dcn316_destroy_resource_pool,=0A=
> =A0=A0=A0=A0=A0=A0=A0 .link_enc_create =3D dcn31_link_encoder_create,=0A=
> --=0A=
> 2.53.0=
