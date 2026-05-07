Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC9FCD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 19:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48CDA10E29D;
	Thu,  7 May 2026 19:03:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gn3xC8qs";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032CC10E2BA
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 19:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778180628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uKT1nQZUxN9fXiQAjzu9iuep+Yxp4ZZA+R3IIcHJMTM=;
 b=gn3xC8qsH3/3PNtxZkm9yTvSCXEYYmZ89GcBPIct32L8LIdwNlsi9tq7xovoDtHGAogfMF
 x+UM+CGsbmcPoxbB6yAuSdG+90vybu/GgwrNG/aJk/KDed3jOnySqKqniegg9i1UFr4GLR
 IrCxw/X0iTo4PuGOdoXUxJ5zV+bLNiE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-F8rCv90fOGCO9v8N6slskg-1; Thu, 07 May 2026 15:03:46 -0400
X-MC-Unique: F8rCv90fOGCO9v8N6slskg-1
X-Mimecast-MFC-AGG-ID: F8rCv90fOGCO9v8N6slskg_1778180626
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-514551d5f2aso21635061cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 12:03:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778180626; x=1778785426;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Da30zB6qHlYB/8upFKz9PSKeDig+zmAcVMkZYstCps=;
 b=E6SjI26YPNZOQlT5ZkAiqrfPYHbXRnrffAzxFBeNW1dFlW0/fRYTwZmHFFF4weZdua
 mgY0WGf9R0sJsZG/xMw4TIhhgHIuCLTx40Ur7p/yrE0fawP2ccv83KNQBepz86UlytpA
 4MTp4Fu77FhtzXoiXibPam0yTVuX9IhFTTRn7OH4XnG1hGvPzNNh2F2EYojkfZVpVGiD
 QKKwHIw50WX4RuC9I0XV8PQSJKYts66TZberZ4GNgeqUN6En8UkzyAc0hRZophVm5fFM
 FU77hrqEKBgYDsXc7xjRQVJmCVv7jXq+vcHEs2Vi3adXRD713/po8/fY+Kn/6OhDnmyo
 shEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xRqzfMf1YkdyTMeEf0cnrVgyDZwnQeI0bs6JVrwYc/GLzfITEIH5jfDAoxA8Okrt0qrT1ydYYh98=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwX8HcdO+K2EfOy2fZ0PjhzA5czvZ34+Gc7gWCysDYnFEzTy7XN
 cnLyCNbZYUoa/ZF3xCzPSjMslKm27AFXqKSxD0HYjtq4uBGURfYThJYDBwkDju6u+4jf73BVIfp
 RO3zGnpjPsj/71hpBvJOoMRyyF9gRSTqPiB9PVd6hn0YDdhGKc3zDcMI/707iddF5P4KNPg==
X-Gm-Gg: AeBDiesxsYYLVADJUu3owu0aAMzVKS09uvAbHEO3NBMBQiQxBLv00AD4+UoX1Pa9wZZ
 VHKmj2zN1AF0ipW8GkongeT/yezIZREvp1wo7XcmmYOG6rqHX83RYELMCAsr8IUEKhKW+ljrmXj
 x8jIBoKRC/Am25z9/3Aebyugj21cWGgu1gmF+ObEMO9Cmq3LtlaM09K2Ojm8NGEbprGftWTsX5M
 BT3aWue2JzdrgwzNqwo+oOdxr41FnpPPsXJnh8mdXAqwLg3DoIHwyb6NSPk81311GYLIw0/eUVK
 /l1laEiiuONIYFiuB/zQV00i9h/XL4SzYu5KZdRFi4qcVrHB2IDzfLioDHmvE30+xrj58Et78kX
 Kpxzg+MWEdTJG/ErEkQ==
X-Received: by 2002:a05:622a:647:b0:514:5d88:8296 with SMTP id
 d75a77b69052e-514621d0e45mr126050221cf.52.1778180626133; 
 Thu, 07 May 2026 12:03:46 -0700 (PDT)
X-Received: by 2002:a05:622a:647:b0:514:5d88:8296 with SMTP id
 d75a77b69052e-514621d0e45mr126049701cf.52.1778180625477; 
 Thu, 07 May 2026 12:03:45 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-514850cad3csm4919841cf.3.2026.05.07.12.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:03:44 -0700 (PDT)
Message-ID: <d1120aef54d335abf90d7032c9071992bbd7062f.camel@redhat.com>
Subject: Re: [PATCH] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband
 reply parsers
From: lyude@redhat.com
To: Ashutosh Desai <ashutoshdesai993@gmail.com>, 
 dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:03:44 -0400
In-Reply-To: <20260410034123.2433769-1-ashutoshdesai993@gmail.com>
References: <20260410034123.2433769-1-ashutoshdesai993@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 601CLh4WChQGesQVcrBMiTPzZEdirC_iRgcAcHG2RQQ_1778180626
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

Hi - one comment down below:

On Fri, 2026-04-10 at 03:41 +0000, Ashutosh Desai wrote:
> drm_dp_sideband_parse_remote_dpcd_read() reads num_bytes from the raw
> message and then unconditionally does:
>=20
> =C2=A0 memcpy(bytes, &raw->msg[idx], num_bytes);
>=20
> without checking that idx + num_bytes <=3D raw->curlen.=C2=A0 raw->msg[] =
is
> 256 bytes; if a malicious or misbehaving MST hub sets num_bytes
> larger
> than the remaining payload, the memcpy reads past the received data
> into whatever follows in raw->msg[].
>=20
> drm_dp_sideband_parse_remote_i2c_read_ack() has the same flaw and
> also
> lacked the post-increment idx bounds check (noted with a /* TODO
> check */
> comment since the code was introduced).
>=20
> Add the missing bounds checks in both functions, consistent with the
> pattern used throughout the rest of the sideband parser.
>=20
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 8 +++++++-
> =C2=A01 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 170113520..9cef6c576 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -873,6 +873,8 @@ static bool
> drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
> =C2=A0=09idx++;
> =C2=A0=09if (idx > raw->curlen)
> =C2=A0=09=09goto fail_len;
> +=09if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw-
> >curlen)
> +=09=09goto fail_len;

Do we need both checks here? It seems like we could just replace the
first check with the second check.

> =C2=A0
> =C2=A0=09memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx],
> repmsg->u.remote_dpcd_read_ack.num_bytes);
> =C2=A0=09return true;
> @@ -907,7 +909,11 @@ static bool
> drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
> =C2=A0=09=09goto fail_len;
> =C2=A0=09repmsg->u.remote_i2c_read_ack.num_bytes =3D raw->msg[idx];
> =C2=A0=09idx++;
> -=09/* TODO check */
> +=09if (idx > raw->curlen)
> +=09=09goto fail_len;
> +=09if (idx + repmsg->u.remote_i2c_read_ack.num_bytes > raw-
> >curlen)
> +=09=09goto fail_len;

Same here

> +
> =C2=A0=09memcpy(repmsg->u.remote_i2c_read_ack.bytes, &raw->msg[idx],
> repmsg->u.remote_i2c_read_ack.num_bytes);
> =C2=A0=09return true;
> =C2=A0fail_len:

