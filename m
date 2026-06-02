Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931F3CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 06:10:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D774E10EBFE;
	Tue,  2 Jun 2026 06:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tj3r8a69";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46F1110EBFC;
 Tue,  2 Jun 2026 06:10:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nr9eUG4WWQeN/76YjCuy7XGP7KDArkmV54w8vsECkSUIcbSokpmMYAVp9wCPhAVmPUuZIOLl/sYv3Pw7NJjHzBmczvwt4+JSxnuAIu+v/+sh+Y11/ZQX9OZwZ0+8OQvzP9XYhDD7trEjBfWKbZ06O/p5mfwUyp9yZHejTF0YiR7qHOdzpYLR+OKRNRZUggyuCrijib2ybQ9BM/EBgCgg/X2cZDDovQbzPJ79MEMAbYLBNUx8pzSMS7jXbGlKMo9T+laf/kUsdf0urax5p2ivdn15tcD4jpLFUh8z667/gVlXij98fZvhQNXRQxv94aa8JNMlT7Usid1Qh5djAhCstQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0bcUDBh1kASgYKV50zPWIuiy4gVneMRuavGwvm+9as=;
 b=m3lC3bpWoiHLohkiNqWO2BrotZzq0xKGBdrpFPhBmtpETaQezBwX0ieXUhppL0MWabO31FW62SYgMR9jcoKIIQZVUfq7HH238glcB0m9qQu0WuNRNJLjvVKQMaf+hKG9Mahzl64JbBart5cxMOA1hv5XXgmZpVVnbWuYiuBIAmjsquUbhwmGpyMNgFsW9kpW0YJZK7AF07kgEx3YcMt2cEhLgywyJ+qrHdtZUYUOurhCULEHzDbu0P2YfvD8o8DbPhmmFsiagk0sLSvs0nFqCmbfuffkMN1Joq5QWj4b1hMKWYnrT44GLyf+CntHfEPsAh9UblTfkWH8Q5xsjiZBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0bcUDBh1kASgYKV50zPWIuiy4gVneMRuavGwvm+9as=;
 b=tj3r8a69Oy2R0kG+xXEGUf4UBhzGG3vzM9cAscBEtzuUTtFEv1ZVqKxDmPiA8DzOLdku9ETIO0+mG/KtL607jNx+OHUIk3+Hu6N14kR6xxKImlTRswAA1oGsAt91/BQ747jSi7pQzX/cioaELp68mKtXsyHuXzK/4XpQjOjpQtM=
Received: from CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) by
 DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Tue, 2 Jun 2026 06:10:10 +0000
Received: from CY5PR12MB6276.namprd12.prod.outlook.com
 ([fe80::971:7b52:1106:dd41]) by CY5PR12MB6276.namprd12.prod.outlook.com
 ([fe80::971:7b52:1106:dd41%4]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 06:10:10 +0000
From: "Devanand Zodape, Kunal" <Kunal.DevanandZodape@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, "Kumar1, Rahul" <Rahul.Kumar1@amd.com>, "Gupta, Prateek1"
 <Prateek1.Gupta@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: use ACK polling for page-write completion
Thread-Topic: [PATCH v2] drm/amdgpu: use ACK polling for page-write completion
Thread-Index: AQHc8bkdO4Q1NJ7VQ0mVeIq5/ule2bYpqxEAgAEXoVA=
Date: Tue, 2 Jun 2026 06:10:10 +0000
Message-ID: <CY5PR12MB627679B46FC0317E69C047F298122@CY5PR12MB6276.namprd12.prod.outlook.com>
References: <20260601093226.1255621-1-kunal.devanandzodape@amd.com>
 <20260601112336.2277724-1-kunal.devanandzodape@amd.com>
 <7237b5c9-f97d-408f-8fd5-15ccbc9c08d8@amd.com>
In-Reply-To: <7237b5c9-f97d-408f-8fd5-15ccbc9c08d8@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-02T05:45:51.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6276:EE_|DS7PR12MB6006:EE_
x-ms-office365-filtering-correlation-id: c309841e-24d3-4e53-69e1-08dec06d9a20
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|18002099003|22082099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info: piO5NySfkyibcv78tmL4MXN55HJXzr8ZwRXF4ZaWhhFWl9vC/U6w//CN1nFmHn6Xc33hwdshhHIXAVs8sPoV9jvnTRuvk0u/guq/7FR1DzKqXg0CxgazfL2ezC8b3IULPnPQqV+T7N+eSFeqGOvEP5CL7oUaPB9Veapj3tAm2U0fnEffc5Z0N40JWpGZolwj/fEyd916kpH9XO2rZ+yeQvSK9rVMRtGIVbToWRQB4mKJMu6kqR8gz4NJkomIXzTVbDg76au5PxHE2sffzjPy91FoYfEOvRqQm98QtwaH/y5pIHqbOspQueY1LoKigmtu7TQiGzR0OV+27pwbFOgT5w3ym+BBt/T93qaeMAD8eg0WBBXudIMHG47qNJt4u3TKlbAxqRqdDDIbs2/kcEwAICJ4x98JurtkAIfcmEx/wUI+s/grK+l827TuYD2KjJIhIIetY4wb/kxEbS7Z4SWQqD9Y434e5iPacbsE2Dy2Lhv60uewRs7cwbvdtzZdMw78pBNnBJlroByvvyWA8StBA/M/1iuDbXUvmXX+XjVJPfIc7GYCpQiSADYN3VHOsMSQT7VfD3X+UY8+Q0rS7dgNH+jci2kYokY8XmpDYa+cA5f1bLZSPr2FFXzzCylDAlM1Z2kyGp8TAVMEW+HDZpoTRW0TsJ3f9z4IiIPlhuq6eAMhJEreO3+E8nR7M2QFAqkKepRph1hyj5wNs8cFqI+yT+rMDSlzf+cgHXWmM4SH4tZOTerOgP9KiICi/FCmsH1w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6276.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3VEs1iq2REfEqoDhuT68fGdu93HHqU2gnh+JKd7BCFgyVW89327sBX1z+9yB?=
 =?us-ascii?Q?L00sT1OQ+lFHyF9ERDxEckaKJehw/Rj9SpzrwkYQHz3vbDwwYbpm+LZuBK+Q?=
 =?us-ascii?Q?z9+sJkGoDoy9zeYgzopS+XsRSSLGo5OSVJ2HrKLHVdKNnwyYmkBx9KoSEMjU?=
 =?us-ascii?Q?CVL4gwjQHMcjalfHU0h+ts9luY1ZYjNdoF4FJf+r739/p5omt7zH6izi0qpH?=
 =?us-ascii?Q?QZ640WR6xU/39AEEfueRaX2TwCxdTXkQULtFS+zobh/oIKyYTHXVnPMb3O6+?=
 =?us-ascii?Q?/koeOe6tJ4Pujh584dR6k1K2nsdPIign7jHUfLXSkS8N0Ng8oY9YdidGDYrJ?=
 =?us-ascii?Q?oxwLPbPMLCLtWjagrVM7ef1MtdJAtfSWI+5W31QDIaE53+EYvZouykHvvgxm?=
 =?us-ascii?Q?YTVlk0ad09s4b71WVaLobW4xJvuwJRi16odSYUwPQ2Mex7iWhQFhExecoUN9?=
 =?us-ascii?Q?km+PuEOc0hO4w0oIqsqPeN+0TuRMij4XVIF7iO5TmGXwhiM0Vie0rXOd3L0R?=
 =?us-ascii?Q?FOCTj7aRgJzy+JRHu64fdOafJAhWkCakmDjy6Cs7sPyllOxdcbsnQQ3BtufN?=
 =?us-ascii?Q?sdFceT2iuniQFieOY4565b39UA/NP2NYJvKDHuVmfxFCKK6qJ77sidQ7IyeW?=
 =?us-ascii?Q?WBXOsl/xbbW/PS8mCZd5z67tY5+q/3JZ2F+dHNuIqruFVXY3VB9ZIox9z3Nr?=
 =?us-ascii?Q?fO27DxSq3y5koPAWQ5YQ4QKqrNfgs9yTn8XQrSRGfe68SdH0xum+4fe42Mmf?=
 =?us-ascii?Q?02H+3T37FX+s+kbqhI+Xzntrl4Q6jgJwwtTgA21XPkg4QIlTWkK2GiAMrlCf?=
 =?us-ascii?Q?RP8P9hFdnCQziU6gYdSTQ0CK/mEAUUVfZhAivBLbkDMCb6Je6JIn1tcJd/oG?=
 =?us-ascii?Q?T+4dZjxtpdbNm7tRMANx3VVk0m5w29tcw5ohVFY2P/OYy+YIsSAqDjXRrsm9?=
 =?us-ascii?Q?WRip3d1yJkQk9vMfvROfwR2WgEDXc9wUUYenS7uLhRyOV3v4nKBFRaAGEvEY?=
 =?us-ascii?Q?sYhu9sKh5SAYJWXkc52ERsC9vZeVXgnXc9h09nmTqr4bO8cfl42cEMEmA3wq?=
 =?us-ascii?Q?H3mw5YOhzpfPFrRpigwPbunygXLXXC6Qa3J0iwAiva8L1tKvTf+W7gE4GGvb?=
 =?us-ascii?Q?4HgD8WmOJVosn75JTdNsKjXFun8xOiEZkZKZVI4H+r7pR+lzPZL++B1c5N+K?=
 =?us-ascii?Q?YMslIrqnaWAG2eTixPOWyvs3ADliHiM3qlm47wOXBKpSDH3wZLhpliOnFBz1?=
 =?us-ascii?Q?Hy2S6GN+llDxQCRYXPmRpYzpWCEpiWEOrGe/UOVFQWPKAvx1syq+RWbCsWmc?=
 =?us-ascii?Q?GDhS2WI4RtUwxKCZxXaCtdc/tnBHBi6Xv7aNApm5FfKsQ7AhQRyHJUZhbRrd?=
 =?us-ascii?Q?gf+mzXcFarGfJ3PyyToQe5nJJ9Tjkv/U+3adeo/sHuMo04UBI8ltWTJBzQzd?=
 =?us-ascii?Q?1Gw+XSnvM2NTM9R2UdcPR9fT8tFgNoO/x1VnomFoVS4hSY3vwCxSBgtOwW0F?=
 =?us-ascii?Q?ZHt8tf0UUNJlgMJUO7f/H3y8Mats+sVWxaAJeF3+lZhySeXuaL6WnK+ttUCO?=
 =?us-ascii?Q?3h64xKLiyN8kR9Sc6rma/qIqMtBNemVMREetEEXXYuxg3XZVKD7CUDplh4Rp?=
 =?us-ascii?Q?MKOksscg8j8Lhm4G1I5culL7y66zy7O2lNC08Xg8Xj3hqewMUeceJH1b5NzE?=
 =?us-ascii?Q?kPAdRdX0czTZMiDCxDXUSmf9BOLkSMqwKX7sCSZo3tE0NQLM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6276.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c309841e-24d3-4e53-69e1-08dec06d9a20
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 06:10:10.2770 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: joz/8qb4iWGfB8KOmBJfJHYXplP0z4RqJo2zHlvUM3O2I4RzVxoHAqUzA0ws4oHHy8moE9YqqvKat+lnvahIvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
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

AMD General

Hi Lijo,

Thanks for the review. I want to make sure the trade-off is genuinely favou=
rable before standing by the patch.

The case for ACK polling rests on a couple of assumptions:

- The AT24CM02 datasheet specifies a maximum write-cycle time of 10 ms, but=
 the typical time is considerably shorter (often in the 2-5 ms range). With=
 a fixed msleep(10), we always pay the worst-case cost, whereas ACK polling=
 allows the write path to proceed as soon as the device is ready.

- With sleep_us =3D 200, the polling loop runs at most ~50 times over the f=
ull 10 ms window. If the write typically completes around ~3 ms, this reduc=
es to ~15 polling attempts. Whether this is beneficial depends on the per-t=
ransaction FW overhead, as you pointed out.

That said, if the firmware I2C path has non-trivial per-message overhead (e=
.g., > ~100 us per round-trip), or if bus contention is a concern on these =
platforms, then the fixed delay could indeed be the better choice.

Do you have a sense of the typical FW round-trip latency on this path? That=
 would help settle this.

Thanks,
Kunal

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: 01 June 2026 18:35
To: Devanand Zodape, Kunal <Kunal.DevanandZodape@amd.com>; amd-gfx@lists.fr=
eedesktop.org
Cc: dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>; David Airlie <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch=
>; Kumar1, Rahul <Rahul.Kumar1@amd.com>; Gupta, Prateek1 <Prateek1.Gupta@am=
d.com>
Subject: Re: [PATCH v2] drm/amdgpu: use ACK polling for page-write completi=
on



On 01-Jun-26 4:53 PM, Kunal Zodape wrote:
> [Some people who received this message don't often get email from
> kunal.devanandzodape@amd.com. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>
> The EEPROM write path currently waits a fixed 10 ms after each page
> write to cover the maximum write-cycle time.
>
> Replace the fixed delay with ACK polling so the driver can continue as
> soon as the EEPROM finishes its internal write cycle. Since the SMU
> I2C adapter used for these EEPROM accesses does not support
> zero-length transfers, poll readiness with an offset-only dummy write.
>
> Keep the existing 10 ms timeout as the upper bound for the polling loop.
>
> Tested on MI200 (ALDEBARAN) with ras_eeprom_reset confirming clean
> write/read-back with no I2C errors.

The current sleep logic may be better than sending a dummy transfter throug=
h firmware. That has the overhead of FW message logic and other clients acc=
essing i2c bus.

The original comments in the code logic are valid for optimization only if =
driver has direct access to the i2c bus.

Thanks,
Lijo

>
> Suggested-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Kunal Zodape <kunal.devanandzodape@amd.com>
> ---
> v2: Use read_poll_timeout() instead of open-coded ktime + do-while loop
>      as suggested
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 27 +++++++++++++++-------
>   1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> index 8cd69836dd99..9dc538073bb8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
> @@ -21,6 +21,7 @@
>    *
>    */
>
> +#include <linux/iopoll.h>
>   #include "amdgpu_eeprom.h"
>   #include "amdgpu.h"
>
> @@ -153,15 +154,25 @@ static int __amdgpu_eeprom_xfer(struct i2c_adapter =
*i2c_adap, u32 eeprom_addr,
>                          break;
>
>                  if (!read) {
> -                       /* According to EEPROM specs the length of the
> -                        * self-writing cycle, tWR (tW), is 10 ms.
> -                        *
> -                        * TODO: Use polling on ACK, aka Acknowledge
> -                        * Polling, to minimize waiting for the
> -                        * internal write cycle to complete, as it is
> -                        * usually smaller than tWR (tW).
> +                       int ret;
> +
> +                       /* Poll for ACK to detect when the self-timed
> +                        * internal write cycle has completed, as per
> +                        * Acknowledge Polling described in the AT24CM02
> +                        * datasheet, Section 7.4. The SMU I2C adapter
> +                        * used by these EEPROM paths does not support
> +                        * zero-length messages, so use an offset-only
> +                        * dummy write to probe for the ACK. The address
> +                        * pointer update is harmless because each real
> +                        * transfer reprograms it before use.
>                           */
> -                       msleep(10);
> +                       ret =3D read_poll_timeout(i2c_transfer, r,
> +                                                r =3D=3D 1,
> +                                                200, 10 * USEC_PER_MSEC,
> +                                                false,
> +                                                i2c_adap, &msgs[0], 1);
> +                       if (ret)
> +                               break;
>                  }
>          }
>
> --
> 2.17.1
>

