Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C0AC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8812110E551;
	Mon, 14 Sep 2026 13:18:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KqIETNqT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8330610E551
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:18:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B36BB60120;
 Mon, 14 Sep 2026 13:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406A41F000FF;
 Mon, 14 Sep 2026 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789391915;
 bh=HCh6oYdcmoCnweTYNX6rYQ8unITEjVEsPqFCzAG2YmE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KqIETNqT/7svTdT6eqttzDRexsP2V3nIvaJgeNQW39I7GjFi1e7RiNkQk6hPw04o1
 z1ggunUnjm6cHhxaeX+NKaQBcpPHcY1+uOhDNm5pEKjLG0yTgc+n0Lwc8bJmkGI3S6
 KIOIC1ghbg2Ya4OPOJrce04YidNccK6i85b6p51sqskyf5f22AszJgfJqyAEpYvvaS
 1j5yN5VMdK7ewGyNlx+1pvJScE6+JJFJoQtIC6/mD8kg7g+V5ISY67n+Wh62JSYqWD
 +xvr0eroWmceXXRKbP8jbXxeXs28k1NgC3JjPFlpH1nAVeWzhOO9ZeHQE/FVdqHYVq
 +io7dDPvbTXjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] firmware: qcom: scm: drop the __scm global
To: "Albert Esteve" <aesteve@redhat.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260914-scm-device-api-v1-3-3573e2596c51@redhat.com>
References: <20260914-scm-device-api-v1-0-3573e2596c51@redhat.com>
 <20260914-scm-device-api-v1-3-3573e2596c51@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:18:34 +0000
Message-Id: <20260914131835.406A41F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Module parameter updates can silently fail to reach the hardware d=
uring driver probe due to the behavior of driver_find_next_device().

Pre-existing issues:
- [High] Potential Use-After-Free in qcom_scm_get() and its callers due to =
unprotected devres pointers.
--

commit 03814e83233282a25e37723ed4eb68479514c4e0
Author: Albert Esteve <aesteve@redhat.com>

firmware: qcom: scm: drop the __scm global
   =20
Stop publishing a driver-wide singleton. Mark the instance
ready with scm->available, look it up from the platform driver
for module-parameter stores, and use platform_get_drvdata() on
shutdown.

> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index 73e9752e3cca1..68cd8dc622c6f 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c

[ ... ]

> @@ -2657,7 +2658,7 @@ static void qcom_scm_qtee_init(struct qcom_scm *scm)
>  bool qcom_scm_is_available(struct qcom_scm *scm)
>  {
>  	/* Paired with smp_store_release() in qcom_scm_probe */
> -	return scm && scm =3D=3D smp_load_acquire(&__scm);
> +	return scm && smp_load_acquire(&scm->available);

[Severity: High]
This is a pre-existing issue, but does this introduce a new use-after-free
dereference site?

Looking at qcom_scm_get(), it acquires a device reference, retrieves the
devres-managed scm pointer, and immediately drops the reference:

struct qcom_scm *qcom_scm_get(void)
{
	...
	scm =3D dev_get_drvdata(dev);
	put_device(dev);

	if (!qcom_scm_is_available(scm))
		return NULL;
	...
}

If the device is concurrently unbound (e.g., via dynamic DT overlay removal=
),
device_unbind_cleanup() will synchronously free all devres allocations,
including the scm pointer.

Right after this in qcom_scm_get(), calling qcom_scm_is_available(scm)
will now dereference scm->available on the freed pointer. Can the pointer
be safeguarded before dereferencing it here?

>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_is_available);
> =20
> @@ -2817,7 +2818,7 @@ static int set_download_mode(const char *val, const=
 struct kernel_param *kp)
> =20
>  	download_mode =3D ret;
>  	/* Pairs with smp_store_release() in qcom_scm_probe(). */
> -	scm =3D smp_load_acquire(&__scm);
> +	scm =3D qcom_scm_get();

[Severity: High]
Could this cause module parameter updates to silently fail during driver pr=
obe?

If a user or script updates the download_mode module parameter via sysfs wh=
ile
qcom_scm_probe() is executing, set_download_mode() will call qcom_scm_get().

Because qcom_scm_get() uses driver_find_next_device(), which relies on
klist_devices, it will return NULL until driver_bound() adds the device
to the list after probe completes.

Since this skips the hardware update when qcom_scm_get() returns NULL, would
the global download_mode variable become permanently desynchronized from the
hardware state?

>  	if (scm)
>  		qcom_scm_set_download_mode(scm, download_mode);
> =20
> @@ -2858,7 +2859,7 @@ static int set_minidump_dest(const char *val, const=
 struct kernel_param *kp)
>  	minidump_dest =3D minidump_dest_map[i].val;
> =20
>  	/* Pairs with smp_store_release() in qcom_scm_probe(). */
> -	scm =3D smp_load_acquire(&__scm);
> +	scm =3D qcom_scm_get();

[Severity: High]
Similarly to the download_mode parameter, could writing to minidump_dest via
sysfs during probe fail to reach the hardware?

Since qcom_scm_get() will return NULL before driver_bound() finishes, it
appears the minidump_sram write could be completely missed.

>  	if (scm && scm->minidump_sram && (download_mode & QCOM_DLOAD_MINIDUMP))
>  		writel_relaxed(minidump_dest, scm->minidump_sram);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914-scm-device=
-api-v1-0-3573e2596c51@redhat.com?part=3D3
