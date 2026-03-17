Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E3DFB5EBC
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 04:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F4A10E0CC;
	Tue, 17 Mar 2026 04:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V6DtoO0k";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013054.outbound.protection.outlook.com
 [40.107.201.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7AC10E0CC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 04:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEy9Z5TR9Vq6ei2Qee+MhNA5TCye7/1UYZeHaNsl6r9N+lAmsvbpPtjepVEaPPyI689rGRe0AVynCmwLlWuPzd2bgbcunTwybWGm4mmEeO1Ag0El8sFGQZUoimX2PzL+uySHOthd3LZAuf4HwU8TNZO8ViM4udJTx6j5yMvT71FH9WlBY1fHn0x3o3nM6tSI8Y21dPM8qiyTpmaWot+k+waaLiIlcCVRNbhFWyZ12dUbjSa9zGeuUdVys5f/BwMNWoFBFZ3iQ65D7l2roOA/FlSQKm7X2xYjcjQFSUu9wPEwSPAwx3J9HSMwJAaeoYune0xQYV/yJ9eqxASc9C6pWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqSaHHtKjoroCIfuaCfWWCYYS14ktroHhY1Z7dpFBB0=;
 b=LdNLZs6gbQzFeKIWNW7Qk0tf7+l0CvoycixS1VWMjVd0mtGm3QkyDrMxrntufKQFhLtAvU+GOu8QcGaHQix+DACURCklGE8THoJ0p55GLfAoXTCLeEiOD3CMEK+Al04RNMtFqAnqRD/ouMSMPirSjXCfJCQ5ghYi5JjjsnxXTOw6FbsBGqhIXinf8d7D/7WK4j4ukpAcBzt4fv+ghxLXoUHWVDp1e6KPqJGNlbkifa3VCvmJqLjdh2y3iFd8irOnMV11NTEyOwP9fpxAcwfK/h5wFlv+AxLs/tYGieNWOM8ySiFFMxZhuvUa+jsxZSoY93NmdZpAJJ0KN2ET64kycg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqSaHHtKjoroCIfuaCfWWCYYS14ktroHhY1Z7dpFBB0=;
 b=V6DtoO0keyeJ830aAxzkJHtwtBmitRCwjXh1zXlRuS+/zYVMnsIECgs9gZ2FfuE06Ost67KVcd6QgrTcEaxpo5cqHPiAEToxiIZ7mvcL7v/Vf9+4ROCqD7o6GqdKkoq1N/YH5NJa7/6WNstssBfCDKzOOyPzGZTuVWn1TAZbRbg=
Received: from IA0PR12MB8208.namprd12.prod.outlook.com (2603:10b6:208:409::17)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 04:47:14 +0000
Received: from IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e]) by IA0PR12MB8208.namprd12.prod.outlook.com
 ([fe80::dbd3:cc22:a850:dc1e%5]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 04:47:14 +0000
From: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/gem: Improve drm_gem_objects_lookup() kerneldoc
Thread-Topic: [PATCH] drm/gem: Improve drm_gem_objects_lookup() kerneldoc
Thread-Index: AQHctSih2BeDmlYHSE+ztT9gQA9W/LWyJkgQ
Date: Tue, 17 Mar 2026 04:47:14 +0000
Message-ID: <IA0PR12MB82088F22175D8ED964A165669041A@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260316093809.97267-1-tvrtko.ursulin@igalia.com>
In-Reply-To: <20260316093809.97267-1-tvrtko.ursulin@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-03-17T04:41:19.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8208:EE_|IA0PR12MB7650:EE_
x-ms-office365-filtering-correlation-id: e24f00bc-9522-4d89-a33d-08de83e0426a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: ipops3oWXOLVEK9E9cQhiKaIc7a7CgIfgWDPb5Rv1wlGL3I/aw1TnMeEja3fbUfKjKCs7+DfpIaM+gTubj8g/vihnTYYpCSlK2jugAnrAKqYY44/uB6QW6qgKNXWioGqBKzzCaIy9daKcW5mtkfB8XYmVzDnyRnflXMoI4XDvm+TUyt4qxgABI910CWHtRARbneA+qnxcpZOPZRYzt+pnuN9jNK9AHJS1U/WWT1moABfRisDmo/BKz7TkCO0FmYSPYavsL3cmRpkb6ljuRKpDtALF1KzEUhaaXm4la2Z5I9o6vW/SmABxKTKIJtkvrP7iq6r89aoW+vEAUxp9beFYSOff/1C+UQ89nEV7XMXiwYxuIBuF7/YfqSrR5gOAnps6dYgsrvfUohQoKwGH6ZHU8iyeZPYgzLVDay8lmcyh6Rk1l9AA4wV6Kx/dztPxwNNqZwKRUAESUzURWZFvq1Kf1hOHfG1Q8H8wLLl5e6FWAbwy2y+vvi/oBlKZq/mr1xi5zhAnmuZPyrmMuoO52IUwY6iPA4zxBWZJf4jvhUvewEYpOkFJ57ZCsBp2cAdcEImPwKbgQeuFzwYx1shHlrjtf+KV0jo9Z7R+kz7RjS4c4n0w9uJImN+azU79guVCkjkMlD5qx86DvfZ/RTclMUy+rAhldNbM9c0FPFprIUKLDQWSSrYyRiZk0OSCx70tTr8y/Izxej/MykuKzpRbZbLLBFOMxu3yualbX2U9HRVUll6CIYKiewvUvVw16KkHrf2k9ATAzQ3Xvfhu4BeHuX3Pg4aU8qluOLzJw7foG3sWfQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR12MB8208.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9jxBYj05JM41qh3TtlKHmx7sXStm/XGP336vSMCNnu3JNMQL+o8wVHIBP0sx?=
 =?us-ascii?Q?djpt2xDvzzNMPPU9xUn7HSYS67gvrBFiIUmQwBBnodr+XJsgYANyD4GOATVy?=
 =?us-ascii?Q?LEdHU+8AyOpicS91vZ7lCBqsEZXdMcRQPFMxsfhND9RsbGkzoVdI/pqwzZLy?=
 =?us-ascii?Q?2fl1YfziR5jOiRDA6bV6O02mUOnC1X1XnBMBlSNUzF9eMtt1d9FjE7yuDOZB?=
 =?us-ascii?Q?4pesC9Xkm03K8I7fqRaWba4Zd38ctlIj4/hv6cIw+a4i9blKndySEaOsHnNi?=
 =?us-ascii?Q?hM5GHtlVuIbKd4Jngv7EdbSIQMEbQrrODnAqK1DYL3Em34632G2JKHCKFSZ0?=
 =?us-ascii?Q?XwMI9YRowyKTiZyIlbKuBVilIbucmNdPRm/NvF+AwcAWPxOMOGBcTiRfUIOF?=
 =?us-ascii?Q?mqAifqXUhHBeI2N0YX0eIKKKhwmmIaTJIYx3ks6fvIsbEpENMJtoBQHwMWNu?=
 =?us-ascii?Q?LFoCJTdRgcEKVjpyL+Af2DjsxsP1zocttEUL40SoU/FV+UIIxmDk6YEYx3tg?=
 =?us-ascii?Q?Jp9RgUfNCGdUwW7hmPGNZVZ34GtNV+89RhBrnz2l1/PK0SKx1UFKbpU0kSzA?=
 =?us-ascii?Q?Tupj7zwc8HwBuXUmKeA4qjJUH183vTlZ3+U2nrMaUp+fUwUr4+q6rmWogTUO?=
 =?us-ascii?Q?2xHy8oDhpmmoRyRHSk9WecV6yN7yBxGR2Fps/a9vFhUm9UiKRR6gPcn4fgwt?=
 =?us-ascii?Q?N2qKi94updjs/CLvr+0/gzwdgchf3/Lg3pdehtWwovhLwOV8jhiMqofm0S63?=
 =?us-ascii?Q?ZA7o5n0ibDNjSMMsjpwZajUJwXhbx9yOqPPH9yRCJFMqi0JjmVcdOHBLtJTS?=
 =?us-ascii?Q?qJMR+eJ6Kx707N1o6xwszpr9Hym4L3iyXzwVkhRq5l87ERvSr5bn71+76yFp?=
 =?us-ascii?Q?thOblaLkqmxMgQHVPLF43ToT1q37wrVvusqI+2SP+EERfTn9Tzm7OAh/Fbn0?=
 =?us-ascii?Q?dFNU4b3sw79DupSRQZS0lwscysubIT4eNRefLkh6oNTF8tMH60nFq4O3vvEC?=
 =?us-ascii?Q?4VgiH35XhlTov+wGiKz+i7IDkeCeCP4Y6SnuRYp1+635uJqeg+JtSnPlkjrv?=
 =?us-ascii?Q?4LJCxkRRZ/a5m7f6ZaugPAXQJ0IV2OU1ktrcGpk4VHoik9UVmcrCBss6/sZz?=
 =?us-ascii?Q?9nXYvcR/QuYTZ8gIdh6u3tMyseptLCI/6xemCKEQemAdrdueHsMmPCbUPywf?=
 =?us-ascii?Q?Qc7nsgmPNBM8DS/LyJWp+wQQ3qN0vJGspr6d8ZURUcbEJA67BRd5Lb5XkYxM?=
 =?us-ascii?Q?xqyP8c/fZ/n6Zib8bzlEZoFthlmZRGsZM+1RUKAdDlsdet6Ylw34gNj+ndHl?=
 =?us-ascii?Q?kz6/n5Yvu7lqdLi6k0J4MwrLWd1yr9Qz50pamElVNWzsW0D29a8XXMa44Jg+?=
 =?us-ascii?Q?e33pIoYKeEituS8Di6TPiMV3XMpMdwI0bD4O2ZBrl82ghTR1Ukdic/f0qSK7?=
 =?us-ascii?Q?SEzgHrA7np0WVKKsJDbXasMFQVer2+ocj9mciffuMk/hLiyn0BbhoXEYRK+z?=
 =?us-ascii?Q?2jJvGyVGtr7M1FeK6WdY37FjOOVcICVZzSLHBO2YC0tRmTAIvRZBCQqHClyO?=
 =?us-ascii?Q?8F1l0QkAuX1yGbTh7HlOV/HlPBZV67dSzBv7rSYeAeYUiSjvG5guiqBWjESr?=
 =?us-ascii?Q?ORie2JMzYAGBIvAY9jEFFLOR8ov+A96xby5MUIP2eON88EsnKOpf2vQlzoMS?=
 =?us-ascii?Q?ow9/V57w/J+kEX9QJeYDUMbOselvIs7dzfiXyNixM5XXbRMI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8208.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24f00bc-9522-4d89-a33d-08de83e0426a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 04:47:14.3325 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FezYobYcl3SyqYr+Zu9wA9JYR8Pg052Sv3CY2gTW6HJT3cszVet+foSZYibPNdH/2AyppPjgWJD87DwRyhCq4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Sent: Monday, March 16, 2026 3:08 PM
> To: dri-devel@lists.freedesktop.org
> Cc: kernel-dev@igalia.com; Tvrtko Ursulin <tvrtko.ursulin@igalia.com>;
> SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Khatri,
> Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH] drm/gem: Improve drm_gem_objects_lookup() kerneldoc
>
> Make clear that the returned array has to be free using kvfree().
>
> While at it, fix broken reference to non-existant @objs and allow for mor=
e error
> codes on failure.
>
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/drm_gem.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c index
> fdf08cae1c5b..124cc5f3d9ff 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -821,13 +821,14 @@ static int objects_lookup(struct drm_file *filp, u3=
2
> *handle, int count,
>   * Takes an array of userspace handles and returns a newly allocated arr=
ay of
>   * GEM objects.
>   *
> + * After a successul lookup GEM objects need to be released using

Reflects the function contract, especially documenting ownership of the ret=
urned
@objs_out array and that it must be freed with kvfree(),

This helper is important as it converts userspace GEM handles into
referenced kernel GEM objects, ensuring they remain valid while used by
the caller (for example, when operating on multiple buffer objects in a
single request, such as GPU submissions).

Minor nit:
s/successul/successful/

Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>


> + * drm_gem_object_put() and the array returned in @objs_out must be
> + freed using
> + * kvfree().
> + *
>   * For a single handle lookup, use drm_gem_object_lookup().
>   *
> - * Returns:
> - * @objs filled in with GEM object pointers. Returned GEM objects need t=
o be
> - * released with drm_gem_object_put(). -ENOENT is returned on a lookup
> - * failure. 0 is returned on success.
> - *
> + * Return:
> + * Zero on success or a negative error code.
>   */
>  int drm_gem_objects_lookup(struct drm_file *filp, void __user *bo_handle=
s,
>                          int count, struct drm_gem_object ***objs_out)
> --
> 2.52.0

