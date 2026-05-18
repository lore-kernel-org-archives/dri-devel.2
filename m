Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DE17CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 17:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BF110E958;
	Mon, 18 May 2026 17:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="J+AcTKlf";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3E310E958
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 17:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779127185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4sNqFFdBJ8b21DSexy1vR9Tkhrd1gBVC1evlaHSZRo=;
 b=J+AcTKlfhmg1ndbxWzfX6hcYMT7X8ocr6KV7VDZPxx1+Fx4xm7Nk1XAq3EWJYrp9OZBxgn
 k3PsSkA4Cn1mA+OUl/YJuQhRw2OA7ZtL8ff0s11pia2XveFyGKru8IJ7TCYdpDuL57BiT9
 CV8eejCbzTv0SunJJjb3ikIffezfn8M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-EUKwTF3QO8K58MsCq1IxEA-1; Mon, 18 May 2026 13:59:44 -0400
X-MC-Unique: EUKwTF3QO8K58MsCq1IxEA-1
X-Mimecast-MFC-AGG-ID: EUKwTF3QO8K58MsCq1IxEA_1779127183
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8acafc224a8so88336626d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:59:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779127183; x=1779731983;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u8nJotCS5ieH4qI/fVkCf7erQnf4wXUQWNAiQ92BJeI=;
 b=jzKYvcGYAJsxiGFzFRpAdYvSI+tEERRFU76++FHw3dQVDed4Z0xTqi0JfzYU6tOsr8
 Raq3oQOSGWyQx3YHOHBtWgOmFUq2MQ36WUd1PE1gnfgJEKwtWmjJRke2LgrslavM/CT8
 xnLM/dP1L3kwHwKwvUEAx6v5E0GEexgwo7G/P1PmpODhTsgdwggPJmNqiTD7cA6yRNKh
 LUhIMGlQh79evB2F92/CuyAD5J/E27DGWdL7j2DFno0Mr4/p7xRIsX1whWaAiFMCCS2i
 sSopJO1i4qopfc/EF378s7s7bnREaDvTy87TobYunugSHoL0LsNmN4cA1e/JkcIXYmSD
 acgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DTs/6YqgQIDMggIwGLASfkef3nBYZuuRV0a/VqZPcs9l4E94Xwy5IkOxdxN84eE5cHWacO+jtScU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNteLfZrLOJbBuP/F9kzg6kfdb0HEHB6jPC2/YQDhuIN/jkai+
 80s+fnF+9S77d53PDZ7M3DlFzbJ1yAnvjFxoslkTkJVBmLeYi+BYyjh44eaF+dkHvkqgYPPqpCi
 6B5rTTZiG+qm5BAFlYAplzDQRi35aXsLGJInJQZ2HyFwGkFQDaxm5ArHmZYH9QPcgKw8VBw==
X-Gm-Gg: Acq92OEWC/38PPHp8sF1iykzw39gBpZGO6uF+Ao8D6yfIHqfj8I4SdcKpffZND/HxP/
 3PcEAQdBkUkLkUd6fOdEBB49buL+6O3BSdvjGk9RABL9tivgB6PcjAfRdI80y7r3P6fPcKMWIPl
 T4ZUI+kI5aesGAmuCZAwLfHmmPnlrtkrvRoqx1sLDXwJhq/p/ts0lFzVtnOCTW7Gu2kKWNHfnfi
 kLc+ai7dYqyEIgY/uWlT3Oo6RdYnX24fE0R6qsjfIzFl6D5MT4CCnd1nB6/xgMfYD+x9mZkMYXv
 mvmtDhVY6qxRGbvTsdPzSVG8eA+8nQMmLFZjhlgVl+aJ02Pppz2f+7tbw3Izi5R0Nc9kMx/bLs2
 Nl7lkzzpdZPOsx5SS+A==
X-Received: by 2002:a05:6214:5e06:b0:8ca:1f6b:a27d with SMTP id
 6a1803df08f44-8ca1f6ba690mr181285006d6.20.1779127183530; 
 Mon, 18 May 2026 10:59:43 -0700 (PDT)
X-Received: by 2002:a05:6214:5e06:b0:8ca:1f6b:a27d with SMTP id
 6a1803df08f44-8ca1f6ba690mr181284626d6.20.1779127183069; 
 Mon, 18 May 2026 10:59:43 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca3619c7d9sm62373116d6.36.2026.05.18.10.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:59:42 -0700 (PDT)
Message-ID: <04a87b5cebc6aeea103997c453e0487ffee70022.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp/mst: fix OOB reads on 2-byte fields in
 sideband reply parsers
From: lyude@redhat.com
To: Ashutosh Desai <ashutoshdesai993@gmail.com>, 
 dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, airlied@gmail.com, daniel@ffwll.ch, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, linux-kernel@vger.kernel.org
Date: Mon, 18 May 2026 13:59:41 -0400
In-Reply-To: <20260510203128.2884846-1-ashutoshdesai993@gmail.com>
References: <20260510203128.2884846-1-ashutoshdesai993@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wJI3_QFBmf91QGZ_kaBwopFvpX2LMwBnb7vrcav5n8A_1779127183
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-next in just a moment

On Sun, 2026-05-10 at 20:31 +0000, Ashutosh Desai wrote:
> Three sideband reply parsers read 16-bit fields as:
>=20
> =C2=A0 val =3D (raw->msg[idx] << 8) | (raw->msg[idx+1]);
>=20
> and check bounds only after the fact. When idx =3D=3D raw->curlen,
> raw->msg[idx+1] reads one byte past the received message data into
> the following struct fields (curchunk_len, curchunk_idx, curlen).
>=20
> Affected functions:
> =C2=A0- drm_dp_sideband_parse_enum_path_resources_ack()
> =C2=A0=C2=A0 full_payload_bw_number and avail_payload_bw_number fields
> =C2=A0- drm_dp_sideband_parse_allocate_payload_ack()
> =C2=A0=C2=A0 allocated_pbn field
> =C2=A0- drm_dp_sideband_parse_query_payload_ack()
> =C2=A0=C2=A0 allocated_pbn field
>=20
> Fix by using a single combined check (idx + 2 > curlen) before each
> 2-byte read. Since the check is strictly tighter than idx > curlen,
> no separate step is needed.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> Changes in v2:
> - Drop separate idx > curlen check immediately before idx + 2 >
> curlen;
> =C2=A0 the combined check strictly subsumes it (Lyude Paul)
>=20
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 17 ++++------------=
-
> =C2=A01 file changed, 4 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 9416a48804c8..6e7896193772 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -925,16 +925,13 @@ static bool
> drm_dp_sideband_parse_enum_path_resources_ack(struct drm_dp_sideband
> =C2=A0=09repmsg->u.path_resources.port_number =3D (raw->msg[idx] >> 4)
> & 0xf;
> =C2=A0=09repmsg->u.path_resources.fec_capable =3D raw->msg[idx] & 0x1;
> =C2=A0=09idx++;
> -=09if (idx > raw->curlen)
> +=09if (idx + 2 > raw->curlen)
> =C2=A0=09=09goto fail_len;
> =C2=A0=09repmsg->u.path_resources.full_payload_bw_number =3D (raw-
> >msg[idx] << 8) | (raw->msg[idx+1]);
> =C2=A0=09idx +=3D 2;
> -=09if (idx > raw->curlen)
> +=09if (idx + 2 > raw->curlen)
> =C2=A0=09=09goto fail_len;
> =C2=A0=09repmsg->u.path_resources.avail_payload_bw_number =3D (raw-
> >msg[idx] << 8) | (raw->msg[idx+1]);
> -=09idx +=3D 2;
> -=09if (idx > raw->curlen)
> -=09=09goto fail_len;
> =C2=A0=09return true;
> =C2=A0fail_len:
> =C2=A0=09DRM_DEBUG_KMS("enum resource parse length fail %d %d\n",
> idx, raw->curlen);
> @@ -952,12 +949,9 @@ static bool
> drm_dp_sideband_parse_allocate_payload_ack(struct drm_dp_sideband_ms
> =C2=A0=09=09goto fail_len;
> =C2=A0=09repmsg->u.allocate_payload.vcpi =3D raw->msg[idx];
> =C2=A0=09idx++;
> -=09if (idx > raw->curlen)
> +=09if (idx + 2 > raw->curlen)
> =C2=A0=09=09goto fail_len;
> =C2=A0=09repmsg->u.allocate_payload.allocated_pbn =3D (raw->msg[idx] <<
> 8) | (raw->msg[idx+1]);
> -=09idx +=3D 2;
> -=09if (idx > raw->curlen)
> -=09=09goto fail_len;
> =C2=A0=09return true;
> =C2=A0fail_len:
> =C2=A0=09DRM_DEBUG_KMS("allocate payload parse length fail %d %d\n",
> idx, raw->curlen);
> @@ -971,12 +965,9 @@ static bool
> drm_dp_sideband_parse_query_payload_ack(struct drm_dp_sideband_msg_r
> =C2=A0
> =C2=A0=09repmsg->u.query_payload.port_number =3D (raw->msg[idx] >> 4) &
> 0xf;
> =C2=A0=09idx++;
> -=09if (idx > raw->curlen)
> +=09if (idx + 2 > raw->curlen)
> =C2=A0=09=09goto fail_len;
> =C2=A0=09repmsg->u.query_payload.allocated_pbn =3D (raw->msg[idx] << 8)
> | (raw->msg[idx + 1]);
> -=09idx +=3D 2;
> -=09if (idx > raw->curlen)
> -=09=09goto fail_len;
> =C2=A0=09return true;
> =C2=A0fail_len:
> =C2=A0=09DRM_DEBUG_KMS("query payload parse length fail %d %d\n",
> idx, raw->curlen);

