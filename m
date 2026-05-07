Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EB7CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 19:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C17110E2C3;
	Thu,  7 May 2026 19:22:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MXLYTcCL";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C936710E2C3
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 19:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778181728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mx4HZQb1lpFQW0PBBGUfMhaBB5Wg3WA/cjHCKrVt3LQ=;
 b=MXLYTcCLICoO/da/93OBuvkQZDCFHLPvy1NSgsdkgtYrpMC7q1wLvADd+xd1wrHLEhY3aq
 n82RHDmrR7edR+53GrOho6FeTjpNS2Hl908xJCAJpFPwT1Yjl9Lurp4QKgjF8MlZQOdVZC
 FvPHNfjqs82lu/SK27UzYVaYB/8p9go=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-F99mdSx7MQCsdsJBqB-NYQ-1; Thu, 07 May 2026 15:22:07 -0400
X-MC-Unique: F99mdSx7MQCsdsJBqB-NYQ-1
X-Mimecast-MFC-AGG-ID: F99mdSx7MQCsdsJBqB-NYQ_1778181727
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50d812c898cso29590161cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 12:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778181727; x=1778786527;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h4Z240fQp2pA+4pbLjOL0fSakiiKJZNOCixmjOSCA0s=;
 b=itPytDiq/7KgUWIaCgMt0o545tOKt45CspOqrDJBRKh4uSXIXXGthux/wIIsGhqDeg
 6EvYeRbxczm2d/gOHJjA+K2zyY1+DhEspsNAo8DM3FIDekpi4++2pnLaQQqxV6HeKeNd
 lTBp2URkXkN41kZ49h18V3sdi24fGQyrFS2WjgC03TcpE0maykVGQm45lR/ybskrssfu
 Sn1bmQYPuD+qIxUjRg3Fz+2Z8O4XLS+1/Yi8wZQB0wS7bc/jhxw7u1bOJEaeUAguJO6c
 lZzPV7XS9hlaSaFsFnksbeUj3EABGPBduyrNnirjTJqxAjfC5wEs7+Bex6AvhXlFDDHZ
 IOug==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ng0xtMgpukyPU4i520aFOMz6HWo033gVXJQaksRARFF33S0wnbHzUjanguOErF1cEZbYny890qVk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztrV8VFFl4HeA4O9lRKvJDBf62MjCvG4ybrpQtid8ggf8hCKH+
 /YtxkXZtfV0DFGEYUSOvhH60Vg/zxOjcNPALsJ1z5ie6wcNfcgxu78QMbDemasceRpUTCWR8hcM
 3n0pwpO4/XBvBKxpNsZU2wgNXrVg3rlz7O1VMFB4Lo/kEs0l++s/RU0SA+T00MZ8THX6W9g==
X-Gm-Gg: AeBDietycr2QeZbOL4QUIPrA7s2PJmXiD6957DLw8T82PuvxlUSCZm1Opyzb13Lqpws
 gltfn0hSit1yvDZ14EdV66jbBMfOv3XZlRk2Flbx7jqWMs5UEyiKjYb0MskJgfYfMswpw0EYp6b
 jci2zUqriYfphwgKLigm6p+jHRcMWJ/dBxL2NqtASACG0BAqBZuXUqDFSxCYLq1DkO0p8iKbf5m
 srsr2HXvF5xoF8rPBQl1xUraVm6ILOHb+F2EteGUoGslaXGQs+NXrbNrFHEbrIKW8eTodyz3HLb
 IwE0oi3oDM69Ff7KJQqxumZKkddm9gR+DK+flQMvB4/lJe6PhQMYUdczXSN2qOHJ0AzVcyXMnSO
 euOkO3HbdBS5WQiiRlg==
X-Received: by 2002:a05:622a:1f8a:b0:50f:ccdd:13f1 with SMTP id
 d75a77b69052e-51461c26254mr144206871cf.16.1778181726633; 
 Thu, 07 May 2026 12:22:06 -0700 (PDT)
X-Received: by 2002:a05:622a:1f8a:b0:50f:ccdd:13f1 with SMTP id
 d75a77b69052e-51461c26254mr144206201cf.16.1778181726201; 
 Thu, 07 May 2026 12:22:06 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-514850d0d82sm5922791cf.5.2026.05.07.12.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:22:05 -0700 (PDT)
Message-ID: <3af593e5ff0c3afa7e9e10b06ed9b6c9ab9edad2.camel@redhat.com>
Subject: Re: [PATCH] drm/dp/mst: fix OOB reads on 2-byte fields in sideband
 reply parsers
From: lyude@redhat.com
To: Ashutosh Desai <ashutoshdesai993@gmail.com>, 
 dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, 	airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:22:04 -0400
In-Reply-To: <20260410040026.2436280-1-ashutoshdesai993@gmail.com>
References: <20260410040026.2436280-1-ashutoshdesai993@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r8O9ZwywqzfSGxN003MRRvHklEcbYFZ_pHNZDiNyD54_1778181727
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

Comments down below

On Fri, 2026-04-10 at 04:00 +0000, Ashutosh Desai wrote:
> Three sideband reply parsers read 16-bit fields as:
>=20
> =C2=A0 val =3D (raw->msg[idx] << 8) | (raw->msg[idx+1]);
>=20
> and only check bounds after the fact (idx +=3D 2, then
> if (idx > raw->curlen)).=C2=A0 When idx =3D=3D raw->curlen at the
> point of the read, raw->msg[idx+1] is one byte past the
> received message data, reading into the following struct
> fields (curchunk_len, curchunk_idx, curlen).
>=20
> Affected functions:
> =C2=A0- drm_dp_sideband_parse_enum_path_resources_ack()
> =C2=A0=C2=A0 full_payload_bw_number and avail_payload_bw_number fields
> =C2=A0- drm_dp_sideband_parse_allocate_payload_ack()
> =C2=A0=C2=A0 allocated_pbn field
> =C2=A0- drm_dp_sideband_parse_query_payload_ack()
> =C2=A0=C2=A0 allocated_pbn field
>=20
> Move the bounds check to immediately before each 2-byte read,
> using idx + 2 > raw->curlen, consistent with the fix pattern
> used elsewhere in this file.
>=20
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 17 +++++++---------=
-
> =C2=A01 file changed, 7 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 9cef6c576..f2a7dbc5e 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -931,14 +931,13 @@ static bool
> drm_dp_sideband_parse_enum_path_resources_ack(struct drm_dp_sideband
> =C2=A0=09idx++;
> =C2=A0=09if (idx > raw->curlen)
> =C2=A0=09=09goto fail_len;
> +=09if (idx + 2 > raw->curlen)
> +=09=09goto fail_len;

Same feedback as the other patch - we can just remove the idx check
above and replace it with the idx + 2 > raw->curlen check.

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
> @@ -958,10 +957,9 @@ static bool
> drm_dp_sideband_parse_allocate_payload_ack(struct drm_dp_sideband_ms
> =C2=A0=09idx++;
> =C2=A0=09if (idx > raw->curlen)
> =C2=A0=09=09goto fail_len;
> -=09repmsg->u.allocate_payload.allocated_pbn =3D (raw->msg[idx] <<
> 8) | (raw->msg[idx+1]);
> -=09idx +=3D 2;
> -=09if (idx > raw->curlen)
> +=09if (idx + 2 > raw->curlen)
> =C2=A0=09=09goto fail_len;
> +=09repmsg->u.allocate_payload.allocated_pbn =3D (raw->msg[idx] <<
> 8) | (raw->msg[idx+1]);
> =C2=A0=09return true;
> =C2=A0fail_len:
> =C2=A0=09DRM_DEBUG_KMS("allocate payload parse length fail %d %d\n",
> idx, raw->curlen);
> @@ -977,10 +975,9 @@ static bool
> drm_dp_sideband_parse_query_payload_ack(struct drm_dp_sideband_msg_r
> =C2=A0=09idx++;
> =C2=A0=09if (idx > raw->curlen)
> =C2=A0=09=09goto fail_len;
> -=09repmsg->u.query_payload.allocated_pbn =3D (raw->msg[idx] << 8)
> | (raw->msg[idx + 1]);
> -=09idx +=3D 2;
> -=09if (idx > raw->curlen)
> +=09if (idx + 2 > raw->curlen)
> =C2=A0=09=09goto fail_len;
> +=09repmsg->u.query_payload.allocated_pbn =3D (raw->msg[idx] << 8)
> | (raw->msg[idx + 1]);
> =C2=A0=09return true;
> =C2=A0fail_len:
> =C2=A0=09DRM_DEBUG_KMS("query payload parse length fail %d %d\n",
> idx, raw->curlen);

