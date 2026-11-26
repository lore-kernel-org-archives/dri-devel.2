Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2450606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4S+3+Y6N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151061121A3;
	Thu, 26 Nov 2026 09:05:08 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F9DA10E815;
 Thu, 26 Nov 2026 09:05:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2YQl2WnzB+4D77iIZ1HQS2CM05Wzu6lSHOThn/OYZw+JXliTv0+ZJIfKNfq4wJFRDOiUGXwJ0urHnOkPvSeNq7CoVh3ITK1pFtXC9FY91+N1wqHlmNspQM8Cxku8jOPOCTMLKyCGqOVXKFVkkylc9Hlix1+7SqvNiOV4h9Xz5V5q3bLIxEO7ShMGOQlNbt3Q39v9ntd0JnvRstpE1Cgc3XEK7hdW2tFcoEK9xuComO0Bzt609X3oo4d+wKo52tnI4QrwJU3uJvgHue6F3+4/Quzho8DFOqYv+k0lHFi1wF3FvbEMo9HB0v0J0plAb3df7Nn/EBiTSx1DQfl14aTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJdOl9YRRzn3CJITIKGskSTiZDYkrd7FBTiGotoBdGw=;
 b=lEi55kWVxaIK7OP2fw4n5ZWfKHmyKeX22L6VgS5WgFsmuVS02jnm3jhzA3L5ryhv7HJq8Sg2g9Odk7vNaVmF2nfEEzCDTveXPJTsfrgNscGOqgW1DsRlbn6LDY5695Aa4dqdZw47av5zy8mKBZ7JfHkoj/xzqid/T75rICqDnUqP+SjfNj3Ur5biercRO1/zCmqCbS0tXa3Hb8E4svB+hk6o1LInBiiBbzzIKFKtISFFr/wzWNf8S9Qs0GK5bh762kaPbsc/+vhvrimf6PHUy6EO+iGYuJF8e0d+DW53y+pEkMyxc3FMTu9qFamE7myRrZ8720n+Zl12txT4DVapjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJdOl9YRRzn3CJITIKGskSTiZDYkrd7FBTiGotoBdGw=;
 b=4S+3+Y6N+FzZ9//1eLse8Rjr8HXZTxD5ONDU52nHtnY6bqCNLeftfL4r4pfIkjHu47os+ERhuOltGbLBtoLcoKPcvqkk9hSvw3CB9vjJ01D4Plg+j7h8hEQq8PneS6039LoLL/2X2hdn3pyk6GLSFwSwlZrFIoC8eBRedUE1fo4=
Received: from MW4SPRMB0025.namprd12.prod.outlook.com (2603:10b6:303:18f::13)
 by MN2PR12MB4160.namprd12.prod.outlook.com (2603:10b6:208:19a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 09:04:59 +0000
Received: from MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3]) by MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3%6]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 09:04:58 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "tzimmermann@suse.de" <tzimmermann@suse.de>,
 =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Wentland, Harry"
 <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>
Subject: RE: [PATCH 3/3] drm/client: Make the FBIO_WAITFORVSYNC vblank wait
 interruptible
Thread-Topic: [PATCH 3/3] drm/client: Make the FBIO_WAITFORVSYNC vblank wait
 interruptible
Thread-Index: AQHdfYPtByua0XpfkkmJGuAo43njz7dADSFA
Date: Thu, 26 Nov 2026 09:04:58 +0000
Message-ID: <MW4SPRMB0025F3B9414DDB25527FF1F6FB422@MW4SPRMB0025.namprd12.prod.outlook.com>
References: <20261126085528.820182-1-Prike.Liang@amd.com>
 <20261126085528.820182-3-Prike.Liang@amd.com>
In-Reply-To: <20261126085528.820182-3-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-26T08:56:52.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4SPRMB0025:EE_|MN2PR12MB4160:EE_
x-ms-office365-filtering-correlation-id: 48bad70c-3225-455f-6051-08df4b9c58ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|38070700021|10067099003|56012099006|11063799006|5023799004|261022105027099003|261022115727099003|261028144727099003|261021123027099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|261102130727099003|261009221227099003|261009223027099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: hJP4TOkPXCKAhSkqC/CTYNJfxkdzN7luR249DKPzVUaxG5O/8RrbbuhevNxwKnJtWOBF2FDAIzL806WJ+4Tskj1ks4gERZnOZ639gF/hNwMHLdCYLQ7ZSppkKNRg9NDygXRKvxrF/EMJExWZF2BgX9trelvff5kdjN4vZkBToq9gHvOtbyAUK9R7VyOpPQpgNmttynPwyPpMRLJLNDReKLi0Xk9NZC0IfmC5z1XHL11xtPXCvDna4SstLr+pI9LTNC9dMw7g/uOkcxROYJSgc1UO3BTz91o+LlE4ahH9IfRQbHXxVr+zEKCO1ktsPoE8bUWn0g1rBpibd7BCJFSvWwwD1xHolCUoAwdOG5nJ+ovSZw4uuXWOqouK27RTmWxVLUoHiyNy/Vl+8lJJm9fSizNwesYGah1cnk5hIg517qyayyBuVoLAk6GyLpq2y2kpeyjOa4bFhd4AFv60PAP6ktBF0ssaqjqm4SAM/Oa5aQqATb/ErcmREIp4B/z6cIrBqY/V7HQoF5Fi38f/QvY6IwO5gbFDsze84KZ+51vsve77Y5zMkzyoGCjwGfdZe1Q9wuGcASW27+DdMHJsvQs9t8HwnAlnKVSluVhd0sqvN22v14DK4onPBLhCrGh1GCufHHp0Fgsm30T9agNLVA92Qh9rnlQ56b3iSTOWVvvMAg4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4SPRMB0025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(38070700021)(10067099003)(56012099006)(11063799006)(5023799004)(261022105027099003)(261022115727099003)(261028144727099003)(261021123027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(261102130727099003)(261009221227099003)(261009223027099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RYE5a8ZwbQIGjqJVIycSKOJxBcqcMjIK4oAOmBiabKRg6pJqs30T28Awcg?=
 =?iso-8859-1?Q?q+uRM7pTqnUoYqiHKvlotwv68bowpHVBZEUk0bDxx042YdOF7855turpkX?=
 =?iso-8859-1?Q?420D8koT1EjvlIceo6FhkSOZ3m9+ErZNDggR2vfQr4ACeE3BCVnaBZJ1Ju?=
 =?iso-8859-1?Q?W+f3bm+MkaXDHmCLJGOS98CJiLzeyjyGS6vOY3cICkzEUbeuRfVX//J4gN?=
 =?iso-8859-1?Q?cVGVvtYDGJAuGx2f/MkN4oKPFpdmx0d9Yhg0KLt4mF8cYpLKDFMmORjPMy?=
 =?iso-8859-1?Q?G+8qnKjiPrX8xz1B/VwqXaOkbdPnwOt2IT3ocEvt7wAmZDDOxTIbbp5Y7r?=
 =?iso-8859-1?Q?w75IMBsnkA4SZFIdAPOUjm6m4nbBvdey1zy9wuO1mhyIwUbhWKy/iTEwOX?=
 =?iso-8859-1?Q?zSLoGWP9rwvsenoGDZwre2dTPeYymxw7WfJeW0wv72c7y3NpnJxHyhBaA9?=
 =?iso-8859-1?Q?XXNYW8fIwXHqwBmDgaVJfZXl23sHDo5crbr+edluMntRVmlRvK1gWW+XzH?=
 =?iso-8859-1?Q?mT0n9mn14DEMe4wCpPsI9bhxEsOE3z3iHPvbpojSfPIRvJ8jDuT1pXBqW3?=
 =?iso-8859-1?Q?CkCV/9GyHqjnc7R2RCuwUFyw5NaB3c8TITirvIoznfw8JR5HReBUozTH8j?=
 =?iso-8859-1?Q?nyATFfBmg37fhuecwWoPs/wc8Qo+zxeAo7wJGRt/OMmxe4StxQVKX3O6Yw?=
 =?iso-8859-1?Q?rx6YjOi40ZNETtdNNKRdnp8/xLAd/660AbLMluZ6fcKHxep7YZOXTvQ3kD?=
 =?iso-8859-1?Q?FKukP+Ax8XC8JuCf+QdF18BQjtmj0mFo3oKI6AYZi4IZf7ox6/kYEjMn+L?=
 =?iso-8859-1?Q?8Fp8G+DwZvfGN80spvH1dqTxcSBkoO07LcH6QZ7Pww2hGZaygtQ/VHB95x?=
 =?iso-8859-1?Q?z10R3e7cm/vjBB036cJxHrQ/m6k4qbwWoRvHcrUzYn6AmYSj9Qr6RlCLz2?=
 =?iso-8859-1?Q?pcn3Q/FiHp/JsGngSHwzO8ZuqkQymb/U4mGpI81iNDICBLdjw4IoCiMTQs?=
 =?iso-8859-1?Q?EMyGbE8CUAacPRBXhieaI2E9zMBVxixYhLQjxHskr1hZEM5vDmlECwg3zX?=
 =?iso-8859-1?Q?qaOxfHZk/A/UklKuf58E9CU5+rduwuW6hdB+Ggnm4zF8cUvHXqutwE0dma?=
 =?iso-8859-1?Q?tfI/HdAeHmQxIwVyeTxkcoppNupiGDwgJz3tQzjys72ftomwuzzvC/eAR4?=
 =?iso-8859-1?Q?s+BvQrSZD2MdbBpkFnZZURYE2FZYzMAcvNzyHg9giTsX8Tars1jb1MMytU?=
 =?iso-8859-1?Q?bM4+XZfj2abhwviHf8+pAnwSWLKCiV9oNursmeoYeTX+Onw8XqyWcCS2pT?=
 =?iso-8859-1?Q?9fa6JPJklbr74T16MGYvPPhtkiNvqOBiHdL0WRb60XCQLVO00CdprYQ93q?=
 =?iso-8859-1?Q?25ecbGACcIASJqIgh+Bxl9KznS8nIXXHe9PtHZ+apRdu5zkyRSL/jz7Ptm?=
 =?iso-8859-1?Q?CfHF6+nvLyIR7CILF8+zW86kl3k9MMS2Iu9eh2asRyza/0K5AX4V03SUa4?=
 =?iso-8859-1?Q?DHzIa6IodnLJ+VDvkNJ2WTD6e7WHOVNcMq6+O5Ea55KBvZlPAEKANGLX+4?=
 =?iso-8859-1?Q?6YOE8LMVxp0rExJfHew/ckCbEI+vRVtIIJsGQpoG7YKXQUCwROUieI7/NK?=
 =?iso-8859-1?Q?KBxtJp6VnGD0Cg7J0dAQEZifBTuKVBcpFZRRjfQwDigSkRkZcKzAmMWhMf?=
 =?iso-8859-1?Q?jcWY1SrYIoDcuAKTpmzreXvE6JqgiISdCNPAORGgkWPLm7qTdF5CYM1Gnk?=
 =?iso-8859-1?Q?q7wNQdZ1r4gMExpD21biJUHid/rr7Ov+LztbsRoSVgreug?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4SPRMB0025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48bad70c-3225-455f-6051-08df4b9c58ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 09:04:58.8744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: doqs7R4Q6oqM80bfX3WBuvsgYe+t00C9Q6xb5fo83OScHxlnDaRCdkzkUzAvGxGw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4160
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

AMD General

This patch series addresses the vblank timeout issue when vblank is off, as=
 well as cases interrupted by userspace signals. If there are no further co=
mments, could someone please help pick these up for drm-misc-next? Thanks!

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Thursday, November 26, 2026 4:55 PM
> To: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
> Cc: tzimmermann@suse.de; Liang, Prike <Prike.Liang@amd.com>; Ville Syrj=
=E4l=E4
> <ville.syrjala@linux.intel.com>
> Subject: [PATCH 3/3] drm/client: Make the FBIO_WAITFORVSYNC vblank wait
> interruptible
>
> FBIO_WAITFORVSYNC calls drm_client_modeset_wait_for_vblank(), which waits
> with drm_crtc_wait_one_vblank(). That wait is uninterruptible and only gi=
ves up after
> one second. If no vblank interrupt arrives, for example while the driver =
resets the
> display hardware, the caller sleeps in D state for the whole second and c=
an't be
> interrupted, not even by SIGKILL.
>
> DRM_IOCTL_WAIT_VBLANK waits interruptibly, and so do fbdev drivers that
> implement FBIO_WAITFORVSYNC themselves, such as atyfb and matroxfb.
>
> Use drm_crtc_wait_one_vblank_interruptible() in
> drm_client_modeset_wait_for_vblank(). Return -ERESTARTSYS when a signal
> interrupts the wait, so that the ioctl returns to userspace or is restart=
ed. Timeouts and
> disabled CRTCs are still not reported.
>
> The fbdev damage worker also calls drm_client_modeset_wait_for_vblank(),
> but it runs in a kernel thread, which doesn't receive signals, so its wai=
t doesn't
> change.
>
> Link: https://lore.kernel.org/r/20261119082424.554841-3-Prike.Liang@amd.c=
om
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> Assisted-by: Copilot:claude-opus-5.5
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_client_modeset.c
> b/drivers/gpu/drm/drm_client_modeset.c
> index 67f90e5d1512..122ca1bf98e6 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -1301,10 +1301,11 @@ EXPORT_SYMBOL(drm_client_modeset_dpms);
>   *
>   * Block the caller until the given CRTC has seen a VBLANK. Do nothing
>   * if the CRTC is disabled. If there's another DRM master present, fail
> - * with -EBUSY.
> + * with -EBUSY. A signal interrupts the wait.
>   *
>   * Returns:
> - * 0 on success, or negative error code otherwise.
> + * 0 on success, -ERESTARTSYS if a signal interrupted the wait, or
> + * negative error code otherwise.
>   */
>  int drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, un=
signed int
> crtc_index)  { @@ -1328,13 +1329,14 @@ int
> drm_client_modeset_wait_for_vblank(struct drm_client_dev *client, unsigne=
d i
>        */
>       ret =3D drm_crtc_vblank_get(crtc);
>       if (!ret) {
> -             drm_crtc_wait_one_vblank(crtc);
> +             ret =3D drm_crtc_wait_one_vblank_interruptible(crtc);
>               drm_crtc_vblank_put(crtc);
>       }
>
>       drm_master_internal_release(dev);
>
> -     return 0;
> +     /* Only report interruption by a signal, not timeouts. */
> +     return ret =3D=3D -ERESTARTSYS ? ret : 0;
>  }
>  EXPORT_SYMBOL(drm_client_modeset_wait_for_vblank);
>
> --
> 2.34.1

