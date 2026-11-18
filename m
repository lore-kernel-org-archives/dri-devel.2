Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81815606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5WFO7tIU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4DAA10E599;
	Wed, 18 Nov 2026 07:18:50 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011070.outbound.protection.outlook.com [52.101.62.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C0910E599;
 Wed, 18 Nov 2026 07:18:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ET6vWB6hZy+N+TUC/ZdiS+bNgvu4zRH6B685Kud+nzz2UJR1TgEb8ajliBkfPiuuKQpaTwxSJma7uIU3zxVyZW+xqfbopx/4Q5Sp2NO/wBPKiQVJuxJdNEHlU9ACiApqK/E7iC7oTfbWpdTRupDebF/JviXZa5SJGQy9IYYh+8uuAKgdoZGGxg5QEXRMrNI3W0RWQg7GmIpv1WduCEnlki0v4kaBVtWM+vzzb290HADIvGFRK58G7lMDtCpXTIdwoZftNYvcmnddNiy5WHek+J//LB/GE7nD5+/+/2JibVXVx2HuFlKv+H5gjC3bWeRdwGgZKQAn/Rxjz96mdsxcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfN+thO3PKORBMfHFxGjU+YT5w5QaVCKVMGwEN9IRp4=;
 b=J/C3F8UU40bEhN/75IfIa6zQZUX47ffXcij6/Ir1D4ubd/ZSYypMAjJRDkAzYqtC8gi290w1YXw0qLH6BzHUiBtHf3uFJti1CACn7UDa5m7otznReBHIACcNw1a438VGdObK7B50rWVDQ6Uhvedvkz3QbC18w63RN+sphIdZD1zptShXRUNknEHcS+q2njlXaRxSJQncdZRVbS/myoevONQllsl87k8nq/L8b54xsgH3RSYenOR3B4sGMuJmH+xeIqq1yej9/joBPrDvViNXwlOouhVSuQE9JtQnT3KPFko9g724nKtreRQL5vWq+5+M+LGw7arTMbGg7Z1lmINbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfN+thO3PKORBMfHFxGjU+YT5w5QaVCKVMGwEN9IRp4=;
 b=5WFO7tIU6VhLsVpG8Pzw71l8/nY1bTp7ZhUOErSFNXmizILglqgzUvt8QKkaFiP0zQlVDYqdqzIV6hmMEhFtaKv89CZaksyW4fZXH0FTTjWq1Y57pVBwI0WcmFW+o7o39YIHR1aTAs8hRdn0kZV1l1Z6GLlXrzBGab1dU7MZgY8=
Received: from MW4SPRMB0025.namprd12.prod.outlook.com (2603:10b6:303:18f::13)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 07:18:03 +0000
Received: from MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3]) by MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3%6]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 07:18:03 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>
Subject: RE: [PATCH RESEND 1/5] drm/client: Make the FBIO_WAITFORVSYNC vblank
 wait interruptible
Thread-Topic: [PATCH RESEND 1/5] drm/client: Make the FBIO_WAITFORVSYNC vblank
 wait interruptible
Thread-Index: AQHdcbp2eCQ9pcVOVEmMkpLxfd2LXLczc9ZQ
Date: Wed, 18 Nov 2026 07:18:03 +0000
Message-ID: <MW4SPRMB00253DCE1D485B12CBA61A6DFB7A2@MW4SPRMB0025.namprd12.prod.outlook.com>
References: <20261111085534.514957-1-Prike.Liang@amd.com>
In-Reply-To: <20261111085534.514957-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: tzimmermann@suse.de
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-18T07:08:44.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4SPRMB0025:EE_|MN2PR12MB4454:EE_
x-ms-office365-filtering-correlation-id: 9cbae5ba-fff6-41b0-3cf7-08df454415a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|38070700021|261102123227099003|10067099003|5023799004|11063799006|56012099006|261021123027099003|261026140227099003|261021121427099003|261026121527099003|261022105027099003|261022115727099003|261022075727099003|261102130727099003|261028144727099003|261009220027099003|261009221227099003|261009221727099003|261009223027099003|261009223327099003|22082099003|18002099003;
x-microsoft-antispam-message-info: Mh3ofgO/LB2t7qaWhQz+CAR0/fdkfBtuyKPUIq20k6vN7p5G/B4OPym+x9VBXAtDe7gMI8u2+lJ4+ff9dpX/V7PJObFJVPdPKUCNGznf/BZbUujPiec7COaxzMoomScWZ66Pzqqa00FtUlurfW4jvl0jSjUbGQy3Ldd5KlwbN+kFZayf9x47PLfT0Eyo2kLdmguRzPPpHWT48gw9KozpW5NzR54yJn1nrObbO5FqnJjC4s1LKmmcJWB9h8hdq7zeu5ml5BEKyI8TKP/W7VymZx3YLCoSePjcO1j2P8rd0FOD8ufls8++EcLoXn4hexJVDfkPmCk2oQreqMGI0MpS9RHQooo/PKh2XPN9db4OnF8jlFL6Mk3dQ3uEf8LAUfoAVvGwGlvEftLsOQvNzBawHMh6wqjVkL2E7ht+j2c9kHCtaWvKMN8jVnBsF2kXPondI13/q04Np4+KOFj22NxuHKs5OIK54bGgEpV+//YFm4Nu6b4gzupN0y56yk7hWX2GTQlwD8KtBGjss/da/0FFlPbTkE5LcQukRDtnS9pwVvPAn+zgHDzct7crhcDhd6vqwJPXicMmz46z6TqyH44ThxE4CpvNjE86QqfnVEvDkUmQ+xAFq6O1x7q70uvsNnxmo1K74p3oFXUnhyL5QCGmdUg4C76rgwCsTN8KkQ5OcAlDV8C0pfBOIjVkHwNF6sMGS6+YfNwuUrO0JLh7maS/0Us5Ujq+FZe4UlPOggYGrHk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4SPRMB0025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(261102123227099003)(10067099003)(5023799004)(11063799006)(56012099006)(261021123027099003)(261026140227099003)(261021121427099003)(261026121527099003)(261022105027099003)(261022115727099003)(261022075727099003)(261102130727099003)(261028144727099003)(261009220027099003)(261009221227099003)(261009221727099003)(261009223027099003)(261009223327099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4vZLyzf9qH9tAxWwVUYLSwOP6Ok2G1+Jqwh0i/eHX5GK3tQbbRe6VvpObWCB?=
 =?us-ascii?Q?uws5MUl91t1V+kPamphLINEc+Jxb5gBFFRsJMxAe5bH/+pedeBOrTPjTQYar?=
 =?us-ascii?Q?ejRcE6hSunVyUD5no/VCrZMTgJriemomG+yPdwdlK8MzeZs+lsWzDvnbjP35?=
 =?us-ascii?Q?KgNeAlEMn3Q/CVNfrIT/AB/KBICmVxFpO0nynRdr0xBjygl+NQ2ksyCaYoPd?=
 =?us-ascii?Q?PZ/Fl/P9rpNXsrXlOLK/Zko5/9kuWJDenJza0Nh6BevZBQBDMIi+KSbL5ltx?=
 =?us-ascii?Q?ywMZSbSWiH9eXYNphNHt7OwCF+tpXUBysonypqIRYGIoUUm1C/bWtAS0DYKq?=
 =?us-ascii?Q?Qsib82ylaNIHf3yt3EIwHmmrbb+naGxKRbvTCS0IbG+OyK59HIvgWKk53GBw?=
 =?us-ascii?Q?Anf98BgWlB8K65WvQUQ85yaAq7SuF6Hc6x0qsBbkbIZTCD5hxUcjZ8jUkNvs?=
 =?us-ascii?Q?Yf47Eg2L1Aeg05+B9jJGHuGBb+utdpHCkn6i8ZjSNd0Vz+QS8BKqwJg3aBBA?=
 =?us-ascii?Q?uJBgF1lokRYePcxDHFOAXTT4dOrsL+NsbZhj11boRDDaBKwMKFcAIkXoLw1w?=
 =?us-ascii?Q?qMsiQU73oXZwqTsWogAubeOqo6DbExFdSmuUlwFlNXQyEq4nXkXQMrI03RKU?=
 =?us-ascii?Q?uII5xpFTjC0PpVn+WNKNKxWpBBGaukTb6Pe6Ur1YtLGi2VKjdYD1aOGTTeXr?=
 =?us-ascii?Q?/JsirhT0m9a4eZ/uI9I5XuDcIJHk4CBAfhztNHMUqeeJZKSsWM6s+y99ADUM?=
 =?us-ascii?Q?BTi8IoYUjJCcEaaUDiTzdtNJPP8ulLxpE9ZAf3F6P/DHoYbtnzPsQEI0FNkV?=
 =?us-ascii?Q?ojbHdmuy54C3r6xOCS6JJFkPaga97F2pTgfS4GO7DY4hNurG8OU9BrZ1TDjb?=
 =?us-ascii?Q?lFlyMt9tKTyDgvAX2objDmKWzNEOvUv+nO2pyu656IySy2zxeBOa41BFQ0pM?=
 =?us-ascii?Q?i9/lHcSbZNc5lKWWBHk4YgNS+0Fu1ItmLg6QH1UrTL9HTVBkJ8pdx2z5jPkd?=
 =?us-ascii?Q?qd2k8ZXFplfb5gTFSoUJg1f4rUm/C3hAAFxtD0SjQ/FeqZp7HtOzW3KjL/ee?=
 =?us-ascii?Q?gVXBq8/e4liXzOtWCjjB+4XgzJds8vFz86Uq9YmkP6q5eGh4O4gPftZW0gul?=
 =?us-ascii?Q?8qYL4cCbiTfUD9taT6eyEjrOo0iH+DURrb2XBokBEc4I6HsiKIR4zJPlIh6e?=
 =?us-ascii?Q?krUTehDIiXvedEKxZz39KP1naQMuqO1jvySFu+68GjHajB/atgUU3ChqyNx7?=
 =?us-ascii?Q?m+8+o+PrTupuMDlL8HWGj07JfrVPhmTbUx9Ag57Bp5hcRShq8uxfWQTclWo8?=
 =?us-ascii?Q?IPduk+o2FjmuSVdVNyOSboyLj4Z0mn1EkYSaZZ50zSgVFmN+CE2iZJX/bX0u?=
 =?us-ascii?Q?zCtV2GAyk+/FoYAL7qGWeZDY/GVFC7vlIUU36zTaBfIQsqNn+0/CZki4ecHG?=
 =?us-ascii?Q?ejE1M4nSYYQcyR5F6mmoUTi/6RDKPWXJVkxvRzdzeBXjEUQscx3Mv9xc3DYZ?=
 =?us-ascii?Q?0E8SuUSPaaQgUzl3RWaaYxbuT7MbUGbF7BNQiwHYx8/st5rpzZ4L5psIZ6zA?=
 =?us-ascii?Q?JAG7iq7BmRTfLRDnnLQ4NxC9WjvRrQoIMvJmtl7lwKmUhajTEi6HSgmSqoSP?=
 =?us-ascii?Q?B7qQ07tLNoAAGRtPpHn+rwqSM8ln6o7bXrkZ2yo2InS/xUXmRxm19iii3O+s?=
 =?us-ascii?Q?sOf2O/Hvfrqyamges/E3xw8zBxexHQL+VRXKFfQPaBGunSJB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4SPRMB0025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbae5ba-fff6-41b0-3cf7-08df454415a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2026 07:18:03.2602 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laSmQl1icEqjnZ7TVLHwDAa1qB85GiWEjQ4FXfypYR1JfJZR9jfEtSmmCggt7WWc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
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

Hi @tzimmermann@suse.de

This patch is based on your suggestion to make drm_crtc_wait_one_vblank() i=
nterruptible to address the vblank blocking issue.

To minimize side effects, this version restricts the interruptible wait spe=
cifically to the FBIO_WAITFORVSYNC ioctl path, keeping all other callers un=
interrupted as before.

Could you please take another look and share your thoughts?

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Wednesday, November 11, 2026 4:56 PM
> To: amd-gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Li,
> Sun peng (Leo) <Sunpeng.Li@amd.com>; tzimmermann@suse.de; Liang, Prike
> <Prike.Liang@amd.com>
> Subject: [PATCH RESEND 1/5] drm/client: Make the FBIO_WAITFORVSYNC
> vblank wait interruptible
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
> Add drm_crtc_wait_one_vblank_interruptible(), a DRM-internal variant of
> drm_crtc_wait_one_vblank() that a signal can interrupt, and use it in
> drm_client_modeset_wait_for_vblank(). Return -ERESTARTSYS when a signal
> interrupts the wait, so that the ioctl returns to userspace or is restart=
ed. Timeouts and
> disabled CRTCs are still not reported.
>
> The fbdev damage worker also calls drm_client_modeset_wait_for_vblank(),
> but it runs in a kernel thread, which doesn't receive signals, so its wai=
t doesn't
> change. Drivers keep using drm_crtc_wait_one_vblank().
>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Assisted-by: Copilot:claude-opus-5.5
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/drm_client_modeset.c | 10 +++--
>  drivers/gpu/drm/drm_internal.h       |  1 +
>  drivers/gpu/drm/drm_vblank.c         | 60 ++++++++++++++++++++--------
>  3 files changed, 51 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_client_modeset.c
> b/drivers/gpu/drm/drm_client_modeset.c
> index 0080a8e9556a..b475b8dbdb17 100644
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
> diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_interna=
l.h index
> f893b1e3a596..2be21c20eb78 100644
> --- a/drivers/gpu/drm/drm_internal.h
> +++ b/drivers/gpu/drm/drm_internal.h
> @@ -115,6 +115,7 @@ void drm_vblank_disable_and_save(struct drm_device
> *dev, unsigned int pipe);  int drm_vblank_get(struct drm_device *dev, uns=
igned int
> pipe);  void drm_vblank_put(struct drm_device *dev, unsigned int pipe);
>  u64 drm_vblank_count(struct drm_device *dev, unsigned int pipe);
> +int drm_crtc_wait_one_vblank_interruptible(struct drm_crtc *crtc);
>
>  /* drm_vblank_work.c */
>  static inline void drm_vblank_flush_worker(struct drm_vblank_crtc *vblan=
k) diff --git
> a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c index
> f90fb2d13e42..c3c9afc08ed2 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -1297,21 +1297,12 @@ void drm_crtc_vblank_put(struct drm_crtc *crtc)  =
}
> EXPORT_SYMBOL(drm_crtc_vblank_put);
>
> -/**
> - * drm_crtc_wait_one_vblank - wait for one vblank
> - * @crtc: DRM crtc
> - *
> - * This waits for one vblank to pass on @crtc, using the irq driver inte=
rfaces.
> - * It is a failure to call this when the vblank irq for @crtc is disable=
d, e.g.
> - * due to lack of driver support or because the crtc is off.
> - *
> - * Returns: 0 on success, negative error on failures.
> - */
> -int drm_crtc_wait_one_vblank(struct drm_crtc *crtc)
> +static int __drm_crtc_wait_one_vblank(struct drm_crtc *crtc, bool
> +interruptible)
>  {
>       struct drm_device *dev =3D crtc->dev;
>       int pipe =3D drm_crtc_index(crtc);
>       struct drm_vblank_crtc *vblank =3D drm_crtc_vblank_crtc(crtc);
> +     long timeout =3D msecs_to_jiffies(1000);
>       int ret;
>       u64 last;
>
> @@ -1322,18 +1313,55 @@ int drm_crtc_wait_one_vblank(struct drm_crtc *crt=
c)
>
>       last =3D drm_vblank_count(dev, pipe);
>
> -     ret =3D wait_event_timeout(vblank->queue,
> -                              last !=3D drm_vblank_count(dev, pipe),
> -                              msecs_to_jiffies(1000));
> +     if (interruptible)
> +             timeout =3D wait_event_interruptible_timeout(vblank->queue,
> +                                                        last !=3D drm_vb=
lank_count(dev,
> pipe),
> +                                                        timeout);
> +     else
> +             timeout =3D wait_event_timeout(vblank->queue,
> +                                          last !=3D drm_vblank_count(dev=
, pipe),
> +                                          timeout);
>
> -     drm_WARN(dev, ret =3D=3D 0, "vblank wait timed out on crtc %i\n", p=
ipe);
> +     drm_WARN(dev, timeout =3D=3D 0, "vblank wait timed out on crtc %i\n=
",
> +pipe);
>
>       drm_vblank_put(dev, pipe);
>
> -     return ret ? 0 : -ETIMEDOUT;
> +     if (timeout < 0)
> +             return timeout;
> +
> +     return timeout ? 0 : -ETIMEDOUT;
> +}
> +
> +/**
> + * drm_crtc_wait_one_vblank - wait for one vblank
> + * @crtc: DRM crtc
> + *
> + * This waits for one vblank to pass on @crtc, using the irq driver inte=
rfaces.
> + * It is a failure to call this when the vblank irq for @crtc is disable=
d, e.g.
> + * due to lack of driver support or because the crtc is off.
> + *
> + * Returns: 0 on success, negative error on failures.
> + */
> +int drm_crtc_wait_one_vblank(struct drm_crtc *crtc) {
> +     return __drm_crtc_wait_one_vblank(crtc, false);
>  }
>  EXPORT_SYMBOL(drm_crtc_wait_one_vblank);
>
> +/**
> + * drm_crtc_wait_one_vblank_interruptible - wait for one vblank,
> +interruptibly
> + * @crtc: DRM crtc
> + *
> + * Like drm_crtc_wait_one_vblank(), but a signal interrupts the wait.
> + *
> + * Returns: 0 on success, -ERESTARTSYS if a signal interrupted the
> +wait,
> + * negative error on other failures.
> + */
> +int drm_crtc_wait_one_vblank_interruptible(struct drm_crtc *crtc) {
> +     return __drm_crtc_wait_one_vblank(crtc, true); }
> +
>  /**
>   * drm_crtc_vblank_off - disable vblank events on a CRTC
>   * @crtc: CRTC in question
> --
> 2.34.1

