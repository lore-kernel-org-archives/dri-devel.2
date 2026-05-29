Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36158CD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 01:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7605610F7AA;
	Fri, 29 May 2026 01:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="giQmYXLx";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azolkn19012017.outbound.protection.outlook.com [52.103.10.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21FB410F79F
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 01:44:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GD7w1kCAooR/sIOSbHaAt3L1ZtA+TFCJWyUmcrtxvfvWR7gD+VntcZGy6MvhnBrTYTgLO/OBhZKvKQTUycdT56hRGzoWHUamaXevVwigThnlOzYDCj/eqGGv7w2YuQJ4fZczoKYehTQXKCgyxEuK3dQT/Ykxr8c3xmES32Yf4v/KEmtz5pLtANQ4vCn29zV7ZNyjkkH4iqlwb0jZK75F9DUzO//s12NfA+vL18mCsRyF6co56QwPN28F1VTBp8HvItc6Y4XqpETW+R8xPqK+Dd80DujuQ16pNoZS6nZGUvWMBScvt/7FAUnBI9S+u83nmO0HZtIhqHnmm2XR3Jsy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWCUuZozPI2Hh/oG+/z3+c4gz50gyNsHgihsRZqlOwc=;
 b=Nv2I8NPHPn3fV/6kgZfuLfp95QrBsO+4TeMgRoX42cU5GYIzBpb+9TulCtWjkag9VZyWLHm5Yi+kPfyXkRXQbYpqNtv/PSrJ3ncm8NfW/4Ws1+L145P3vi0vIQqqd3HQ990v4v3DMQeE/n6RxUCzw/RBx6efq9z2bSLeXKG0nRw/qEgkyDWVkFIqOBIav4zCFxNYl9YyoKIdxsWaRFZ76Ti+cOGqDnjofMDbh7DAFyfmOIhMaVpwJMKgYH5/rYLrotucaSpVLl40O6PJVnUECw4qua+nF+o/iTVb0XszSJhLyUclqb8qOGr088MCuY5vU9bPROsIZyuHvhuz/TCZFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWCUuZozPI2Hh/oG+/z3+c4gz50gyNsHgihsRZqlOwc=;
 b=giQmYXLx41gU5MasWgeI7ERcsRadm4JKMoWMxgK1fulcyORbgb9eytNmHNekUyMRErOiw8lUl7ZlEBxPmPflYg7Kq8sjzuneOPatzDC5KEfZoESZzNcbwF+Wm4i+sS/kOpI6Cx2WOV4DvQi4yoc4umAsMPDg25N1XY4JWdl0Zaer4aFzLWQvc9zkZGj3qEZoJ4EJy0Oq4ETJA3SX2Eu/Mey1xQKAGyAQeegESeZm/NjKgFBhu5EH4QzcsTU+M+8EXWtxJ1eiC3e4/UPsgKE8lcwUrqDi5XYPOOUpP4VZU+3prEEKZw5waYmVO1zqdj3g8FHznEmpFdgpU7Megy8Dnw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW4PR02MB7281.namprd02.prod.outlook.com (2603:10b6:303:66::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 01:44:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%3]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 01:44:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <DECUI@microsoft.com>, Michael Kelley <mhklinux@outlook.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>, Long Li <longli@microsoft.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] [PATCH v2 1/1] drm/hyperv: Replace "hyperv_" with
 "hv_drm_" as symbol name prefix
Thread-Topic: [EXTERNAL] [PATCH v2 1/1] drm/hyperv: Replace "hyperv_" with
 "hv_drm_" as symbol name prefix
Thread-Index: AQJhDQVvodyfeJ8O5aYDG3q+5qsPG7Ubas6AgACUnhA=
Date: Fri, 29 May 2026 01:44:52 +0000
Message-ID: <SN6PR02MB4157EB709529A6D778120883D4162@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260528135108.1787-1-mhklkml@zohomail.com>
 <SA1PR21MB6921E2BE7D0F3B804877427CBF092@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB6921E2BE7D0F3B804877427CBF092@SA1PR21MB6921.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW4PR02MB7281:EE_
x-ms-office365-filtering-correlation-id: 9329f347-0af6-46d4-1d25-08debd23e0b6
x-ms-exchange-slblob-mailprops: laRBL560oLQbNG76+pftT4GS1UkmHmyN8OI6SjfYswhvMbesqZ9JrxqssipQjXhrw+CU8ZS/KhZsHy1yTTeA4Sc71TTVTph0kYrEBGqCA+6l8mt7vUAVPHPT6XS2B6Pyv8tbRhKpGrM4mWOAEE8V6QVgUqfTIcJz6huZFZO6KWMeI6Ev6YEh8kZZC1FDqD7jyh+45EeyWrr6Vqtk4vGmmvJlxcNxVbq0WI8O7gisrukvy/rLiHoROWz4oPrICTxCIgumBfLloSXOrWfmChEp1sslxsTvP3RElnBhcOxv+qSyLnlc3mxWRDLRIOTTUvlnr8ZS96IwIZmWTwV7h0wka+nqZmf92QRQ3aKvw//y1KKBFnxY0ABV46SFkPK8tuECAa8YQ8G1mkwvytEd2NVymDgq/T6F+buzWjl9Rr1QvuNnd9O9z+hcJVf9BjCDhSvX8dwCVh2yK/HXsM6pyIQhmQ8yKbjGlcxKxdrWTmyFQlnCHhAjShCKcBBdwcwO4LB8sDKGByR2usbc3YyOqjN7ZK8eDqmxMWL0RKq+KJsxvCXO2pT7naaSwp5LJ0YLj1SGBJSsHetlnCZeaQLwz2Iy45PkxCslf4HnB0brEYG0/BEhrHMoSSHpKpr100n7QoP0n08DUHSNeHQp3ZgbzK5/oSFlyUMND/ow6W0hJ+5XIG7WDHSrOnZrlxKBCvvBL2ta7b1CH4ePMJDKZ9TmfZD8VKcnQgHwLwdeL/ne/bM2EQwd0uIzRTdlAaHMvT0hslQ6JpyH0e3HtSl9h9L87Ck8wJgFK5B776Ke
x-microsoft-antispam: BCL:0;
 ARA:14566002|31061999003|19110799012|15080799012|51005399006|37011999003|19101099003|13091999003|8062599012|8060799015|440099028|3412199025|102099032|40105399003|1710799026;
x-microsoft-antispam-message-info: =?us-ascii?Q?o8NgAbcg/MCObdZjEK5Jwg59Q+HEAR0cxbnzjkhxvLbShuiakrRpI5Dk7bIa?=
 =?us-ascii?Q?0zqOqKLOy26m5HaKh8jDb1lMOoPDQhezeT9fWI2ZWD4XFVz4f2+NMgXv0j+5?=
 =?us-ascii?Q?94qOJWS+/Ety1/KBFXpifUbJUsRoVd1XpzA0YKSIb+mrcTYV8tYCpBm+hY+4?=
 =?us-ascii?Q?m+WNccn1G8n9LfXVfuqSj0kVJNyQPdHeUfBv4j1lKld6oJQmTmR7jNOMbNCZ?=
 =?us-ascii?Q?Hc1GECu6q46I1RTZaT89lr+7xyBxtmOCYyWKT9km2Mst060L09RW4Nmd18XO?=
 =?us-ascii?Q?u1rrPcXLSGHZpXAMNi3cnKnZMUKGcONcHGkavv1+gZxCZPaItBIDnefdz3G1?=
 =?us-ascii?Q?qhO0019y1mC6Eoa+nczkYII5BpfkAZVab4fxiEywoyTJ/v44zVPIQxKebs0J?=
 =?us-ascii?Q?Y0IplAb/PeAs3NgnZEHAr0r0widKhutjc/SjmpEZg72iBXCQJAEeSg5Iqgzh?=
 =?us-ascii?Q?LK41rFzXT0G83cWEVvSJkWQpb/wZDop6yuWMadW3CLgJrd6S8d3hjzNf6RAt?=
 =?us-ascii?Q?s9tZqIGEDWE6sQDQu7/Pu6f3tbG878LLhjgIwOpRC6VmsoOJUm2n/lyob4GI?=
 =?us-ascii?Q?rVbJcos76AiWF2sPgxrL/sXHs4pz6lW7uDqxkWZbg6PDkyb8CUv6oUGs4bww?=
 =?us-ascii?Q?k1vOOf/r6rWYyvMhjxmNXmMo6OXFzSqxPkZigF5VnNfk4cqeeSU9oqrnGcG/?=
 =?us-ascii?Q?yjOa7TooQKrrE8XCRzw+GKCuJmWkNQv0CoIQRsrU/hEpb5ZyzbRWwUvpxwJB?=
 =?us-ascii?Q?NfCPwjlO5q4iDhsheog6Ew+6ilQJ/o77/A79x+7f/fg1VGYJMpKcOG9R9FHJ?=
 =?us-ascii?Q?KoFMNCtqVfocvqksOwuhxkglDuYhUqNjMkJ9rGvTlQBV0OSN2bfh62q6EeqN?=
 =?us-ascii?Q?cUy6EJU2pYltHugTOz0V/azfimpaShPCUNz/abJZTbgoaX2kmct0htgY+LDv?=
 =?us-ascii?Q?+1XNtzMKp7zspAX2pq1NzQsPwp4JVIsNzxncTq7YXiqAkCqKxkmpmcSoA5Gn?=
 =?us-ascii?Q?gn1jMD6Ex4RKljoWjnEYoD6HbQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tl/qmogPOI6MtExf8NyjhHird7NL70cASxY4x064kPHuAGZ5uSaHKUquNcC1?=
 =?us-ascii?Q?hVaFsW5Q0c7ff0Fqo6sfw0fn3NLPDVtx8QRP2gTHtQeP7tT+Bi7WZmO0gRNZ?=
 =?us-ascii?Q?VpzUzLmbhmP3zDWfmyXoQrx9JRgGP0Y8OPN8VffFKY7wp4/apbXArhFEuU64?=
 =?us-ascii?Q?bRRsR6Dz8aSRYK90KpKfHCjlai3N3ivhDc6twlAK+f4y4/ZdVZZjXe9RAyy2?=
 =?us-ascii?Q?qAlgWGVBO6V+Q6m+3zht2lRW3+DSw+cY/8TfV3qXFb91sa/nU/v/4QzmTrhV?=
 =?us-ascii?Q?sHfDm4iDlc/duuDTiXYAn8vrg4o0B7Ee3MOsIskWIBALPZP9aXzvjtg93JCm?=
 =?us-ascii?Q?nxQOgx8mT51Nq7VQlN121CR9hOoksQzuwKTnODEjlm4hQIfCoiO/jKrSVAJH?=
 =?us-ascii?Q?zfyl8gw7upSaaRAc5pxzPO0YxWtw5qWXKMYfMbbWfj2xf8+iBihm++AcHe5d?=
 =?us-ascii?Q?SH5LN5KGYiYENlDt7ffmsQV8vnNVVyNoUwIKiEJ8fY4DJyu7DF4izl+x0hhO?=
 =?us-ascii?Q?HO5NH9D0gTwFrMbgtJuiCs9IRE4C6H6EFg0wZUdzAodRixWJMr+ph4rSlcX5?=
 =?us-ascii?Q?hyn9rIF1izPAByIhJL/Gp+R2hOWwU/7JaN5B34AxcukYXR/L08LYHIwisKEN?=
 =?us-ascii?Q?/G20Z2iYVXCSj/PZIk7eV5ztNnjUZ88DFl2cIujEdSnalqB0lxWzM34DO7cv?=
 =?us-ascii?Q?Qoy6xEmbEsbIi1wqyMXZzEDwPDjDStOv7Uqy3tnZ7sYWPy/gyUf1SV05V07v?=
 =?us-ascii?Q?/P5SiLGXLGgy8O15/5m29PbTvnf5OJwRm+yOxGJiJUnRBHJ0ORs1TOT3Cb4m?=
 =?us-ascii?Q?3v2XJJEbVfAq9vq5tTvtbPm5/asUAuXfI2cXBqOB5D7hgjArbkCN7x0YwP1J?=
 =?us-ascii?Q?wfqPHDPmzymzCfzeNvVhUy1mPqVWTvUu+clk+MUYqBTzpmpUyFvjvKkN0ALr?=
 =?us-ascii?Q?NXanFyJxbh4Gnkn/4Q+u+ibClYSiceWhUKyCRellptHI3tMVrfLsuCPA+J0k?=
 =?us-ascii?Q?ObdSzcBPhMG9SkebjU+d1gY+gLUUHaonapQClNZ2A+K2ZNmkcJLuFG7eX6+v?=
 =?us-ascii?Q?68t3HElzvagi3mBhac8Xf0HyrHQa4X7eNKwzdrC3PCKVfV/KeJIz7yiLRpmJ?=
 =?us-ascii?Q?nzbIEh4Pg420BFUi2Khebh9XdKJgOdFNwKXMBPrEOAAqKXdA1Zb6eEzwZEvV?=
 =?us-ascii?Q?qCyuukmrhxzBLb72DfuNjR/ag2ug3DIdD8qixfu2fOMdMPbGoUmkF6j126XE?=
 =?us-ascii?Q?c7okQUTFZKivT7rVI6bdk4nKuCIeP27gjYIPkIfdVn3c8H2j/1CLzyadgR25?=
 =?us-ascii?Q?XULArXnox9Khv3JEv7sBBH0b66x2MeYt9Mvh8dCzS4XLS+ifRp5Ni+bEG9kZ?=
 =?us-ascii?Q?DgwKrN4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9329f347-0af6-46d4-1d25-08debd23e0b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 01:44:52.4244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7281
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

From: Dexuan Cui <DECUI@microsoft.com> Sent: Thursday, May 28, 2026 9:53 AM
>=20
> > From: Michael Kelley <mhklkml@zohomail.com>
> > Sent: Thursday, May 28, 2026 6:51 AM
> >  ...
> > -#define to_hv(_dev) container_of(_dev, struct hyperv_drm_device, dev)
> > +#define to_hv(_dev) container_of(_dev, struct hv_drm_device, dev)
>=20
> A minor nit:  change "to_hv" to "to_hv_drm"? Otherwise, LGTM.

Yes, that makes sense. It's not a symbol that would appear in, and cause
confusion in, a global symbol list. But the "hv" in "to_hv" is effectively
the prefix, so for completeness change it as well.

I'll send a v3 shortly.

>=20
> Reviewed-by: Dexuan Cui <decui@microsoft.com>

Thanks for reviewing.

Michael

