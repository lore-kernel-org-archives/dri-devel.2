Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4622C54F4D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E2410E24A;
	Tue, 28 Jul 2026 17:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bhMmEIxM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3FC10E24A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 17:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785261451; x=1816797451;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=08GOUG1DRD7jG2RJDUWUWRL5nA7DqEQ0wel6pbzah/0=;
 b=bhMmEIxMjYNyR6cwRchaQESQm4HbLTg95D/rBApGr7vW8DfvwfuIe78V
 om+t2nvkkgMUTQRSfD/Ncs3vyqI4alTBztsyd1bn8hHt2pd5JlCkxg+dc
 QL3mxu8cDAG4MnzGGGCc8HbEuyPieXpc5lJqmijW4qSr3VuS27M58XeRX
 rNdaQeEwXFIVK/hq+cP8mYadGSWXRuZtomU+EE6ntQCWS+g7Q7sxn//3J
 aYXLu2hJeIiVb5Hu+Pp/Iq/b4m+3Ah25EYQVnaRuraJGuIhkGMnVlGs0h
 k9kGJ9NugBIPHP1JycjOnO3NZjk0FfbenSFuc5gNJo5z8MS28HQOhn8y9 A==;
X-CSE-ConnectionGUID: wNKC0tvyRAGu328+9t9xBA==
X-CSE-MsgGUID: wj1bFb2sQNqRPDFcVXgMzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85731556"
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="85731556"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 10:56:55 -0700
X-CSE-ConnectionGUID: SfJcc5M/QDeVnlxiFW6sIg==
X-CSE-MsgGUID: 505xIfEvRrymIwRqDhtdgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,190,1779174000"; d="scan'208";a="298005961"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.76])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2026 10:56:51 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mallesh Koujalagi <mallesh.koujalagi@intel.com>,
 dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: Re: [PATCH v3] drm/drv: Convert wedged event string building to
 seq_buf
In-Reply-To: <20260728140630.891508-2-mallesh.koujalagi@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260728140630.891508-2-mallesh.koujalagi@intel.com>
Date: Tue, 28 Jul 2026 20:56:48 +0300
Message-ID: <ecdd45e4b366ed7a9680bda5b948223c4208a942@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 28 Jul 2026, Mallesh Koujalagi <mallesh.koujalagi@intel.com> wrote:
> event_string[] has a fixed size of WEDGE_STR_LEN (32) bytes.
> The original scnprintf()-based loop required a manual pre-flight
> bounds check.
>
> Replace the manual bookkeeping with seq_buf, which tracks overflow
> internally. seq_buf_printf() writes each "method," token into the
> buffer, and seq_buf_has_overflowed() detects truncation immediately
> after the write that caused it =E2=80=94 using drm_WARN_ONCE() to report =
it.
>
> On overflow, len retains the position of the last
> successful write, so the trailing comma is stripped cleanly without
> including any partial method name in the uevent payload.
>
> Fixes: b7cf9f4ac1b8 ("drm: Introduce device wedged event")
> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
> ---
> v2:
> - Add proper logic to handle recovery string. (Raag)
>
> v3:
> - Convert manual bounds check to seq_buf. (Jani Nikula)
> - Use drm_WARN_ONCE() instead of drm_WARN_ON() for overflow. (Raag)
> ---
>  drivers/gpu/drm/drm_drv.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index e51ed959da89..6a5e3fa1350c 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -36,6 +36,7 @@
>  #include <linux/mount.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/sched.h>
> +#include <linux/seq_buf.h>
>  #include <linux/slab.h>
>  #include <linux/sprintf.h>
>  #include <linux/srcu.h>
> @@ -578,15 +579,22 @@ int drm_dev_wedged_event(struct drm_device *dev, un=
signed long method,
>  	char *envp[] =3D { event_string, NULL, NULL, NULL };
>  	const char *recovery =3D NULL;
>  	unsigned int len, opt;
> +	struct seq_buf buf;
>=20=20
> -	len =3D scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=3D"=
);
> +	seq_buf_init(&buf, event_string, sizeof(event_string));

See DECLARE_SEQ_BUF(). Remove event_string altogether (or make that the
seq_buf name).

> +	seq_buf_puts(&buf, "WEDGED=3D");
> +	len =3D seq_buf_used(&buf);

Why do you need to keep len around?

>=20=20
>  	for_each_set_bit(opt, &method, BITS_PER_TYPE(method)) {
>  		recovery =3D drm_get_wedge_recovery(opt);
>  		if (drm_WARN_ONCE(dev, !recovery, "invalid recovery method %u\n", opt))
>  			break;
>=20=20
> -		len +=3D scnprintf(event_string + len, sizeof(event_string) - len, "%s=
,", recovery);
> +		seq_buf_printf(&buf, "%s,", recovery);
> +		if (drm_WARN_ONCE(dev, seq_buf_has_overflowed(&buf),
> +				  "WEDGED event string truncated\n"))
> +			break;

Nah, you can keep printing to seq_buf, and only check at the end once
instead of looping.

> +		len =3D seq_buf_used(&buf);
>  	}
>=20=20
>  	if (recovery)

--=20
Jani Nikula, Intel
