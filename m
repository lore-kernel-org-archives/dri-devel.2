Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46859CD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 18:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07CC10E032;
	Thu,  7 May 2026 18:07:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="VwK0oycC";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F00F10E032
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778177243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IrrI79pacw/kK2y17dUabmRSfQ53U5DgkGSMXM7cHlQ=;
 b=VwK0oycCJSvw2o7umVQOUbi+CTLQo0yV1AzNyy4fB72uPmUD447DaZ2emOfWFOJY7feWfW
 YhEANx6o7FHj51otEaOougy2Jwfo146oV7xMHwQwYdGz6WyJwynZ7qrYAjuOZXwfdW/gLK
 bJKxY/5VzDmsTInpsANwsMHFe5XJcd8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-EIlN7_ZyNliFHFzYqsYeRw-1; Thu, 07 May 2026 14:07:21 -0400
X-MC-Unique: EIlN7_ZyNliFHFzYqsYeRw-1
X-Mimecast-MFC-AGG-ID: EIlN7_ZyNliFHFzYqsYeRw_1778177241
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d8ed08aa4so34612101cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 11:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778177241; x=1778782041;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IMramWm34LJwqXAbzHOSM29JunUaIBH0eWDhplWtOIc=;
 b=c0HyNfV1jFeYrWWSlHT0PS3HZ+vE8tbI7sj19OKB0z4UKnyYldWbGZLmq9KogrH1ak
 fW2a9jYPvzacAPuL9XtJIdLPz350O+y+8EcrGo7GE4nEZbicyatWi068qFUP5k8SpL/X
 dM/Is8QExUE5rBioz6+J/D8QUhU90QKfI95f6YjtFUODkxJxasIc5ueHHbyUwCAGujHE
 bc1eZsKN78PnjYY8mTMn9PYzarltPfQ/JU3cKCt4JBQe9I/WoljSOKFRT/uFUypZOzI9
 cYb3JNEQGgSJ/AR0XxFRtDwGnPvj9rSCeuqV2KwIJ7zKrPBGF6wjWeXLkewnh4lU6IZW
 TiCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Znxiw4uiXJtxvUbFWbAR0V3iQR0MLX+bnv5mHf+FnPPPwWjlV2dBEITkCRgM5kQZ6US2iJf9l0L0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxxh+U1D9z0br8DnU/6kTPJWX1cjXqFcP4JZydxYSuyD+L+aUoe
 Vg3hlNGCpQgWN/FXSBMUjeoCNfQCGkIWgoj7SJdqCqW+v3+P7WSIMd87/ojie/sUp42sCnV4F+q
 sDn4n+m/IY0KJLds7MXRd4KAB2bUISlg1VsVHLlKOrDJFurIC6oWs/64offhrWEEn2LEDbQ==
X-Gm-Gg: AeBDieuAKF1+yxrY2E3KN1TfutQY1eIGlnqZfckgvyMdGoIhlzX6sqHv0tKh8506UOw
 d2VMJtJtIC3Qw8Cf8mf0SadySh/4cP9F0aEViioPQ7SPnHC7kke5GQBbU/0IsQGWGvvNiGVuuaN
 aS7naTGop2i2w99LLt+BJygmvx/oOB0yj4817Kh7QXoLWVSx6B9Aagesqv11e7QOsQWEazMI6uf
 Bx5fy3DCcew8RjaZslAHJwjSnBUM4OtH8IzN80F3gUANrIziEYliqj7eoOppgrihOwFhgn41dvW
 cSLk0UY+WF4CEp77eeQ3O11VPTzj6kOQDhiIDvsIiixAfHsUOMkYjzQQMAX1vxoxdTAVCCqKaMa
 28fYl0u/xOxOLojJZPw==
X-Received: by 2002:a05:622a:18a9:b0:50e:6302:340b with SMTP id
 d75a77b69052e-514621ff185mr135509081cf.53.1778177241249; 
 Thu, 07 May 2026 11:07:21 -0700 (PDT)
X-Received: by 2002:a05:622a:18a9:b0:50e:6302:340b with SMTP id
 d75a77b69052e-514621ff185mr135508241cf.53.1778177240620; 
 Thu, 07 May 2026 11:07:20 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-514850cb131sm3655181cf.2.2026.05.07.11.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 11:07:19 -0700 (PDT)
Message-ID: <02ebf0e092a810cbb61eaab13a0cd6f46881c23f.camel@redhat.com>
Subject: Re: [PATCH] drm/dp/mst: fix buffer overflows in sideband chunk
 accumulation
From: lyude@redhat.com
To: Ashutosh Desai <ashutoshdesai993@gmail.com>, 
 dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, Dave Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>
Date: Thu, 07 May 2026 14:07:19 -0400
In-Reply-To: <20260410041901.2438960-1-ashutoshdesai993@gmail.com>
References: <20260410041901.2438960-1-ashutoshdesai993@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _qa44ODc6MApJooeNkzgQQxKJkTF59XqRasR18Km1co_1778177241
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

Will push to drm-misc in a moment

On Fri, 2026-04-10 at 04:19 +0000, Ashutosh Desai wrote:
> drm_dp_sideband_append_payload() has three related bugs when
> processing
> device-provided sideband reply data:
>=20
> 1. Zero-length curchunk_len underflow: msg_len is a 6-bit field taken
> =C2=A0=C2=A0 directly from the DP sideband header. If a device sends msg_=
len=3D0,
> =C2=A0=C2=A0 curchunk_len is set to zero. The condition (curchunk_idx >=
=3D
> curchunk_len)
> =C2=A0=C2=A0 is immediately true, and curchunk_len-1 wraps to 255 (u8
> underflow).
> =C2=A0=C2=A0 drm_dp_msg_data_crc4() reads 255 bytes from chunk[48], then
> memcpy()
> =C2=A0=C2=A0 writes 255 bytes into msg[], both far out of bounds.
>=20
> 2. chunk[48] overflow: curchunk_len can reach 63 (6-bit field).
> chunk[] is
> =C2=A0=C2=A0 only 48 bytes. Multi-iteration payload assembly appends 16-b=
yte
> blocks
> =C2=A0=C2=A0 until curchunk_idx reaches curchunk_len, writing up to 15 by=
tes
> past
> =C2=A0=C2=A0 the end of chunk[] into msg[].
>=20
> 3. msg[256] overflow: each chunk contributes (curchunk_len-1) bytes
> to
> =C2=A0=C2=A0 msg[]. No check ensures curlen + (curchunk_len-1) stays with=
in
> msg[256],
> =C2=A0=C2=A0 so the memcpy can spill into adjacent struct fields.
>=20
> All three are reachable from any DP MST device that can forge
> sideband
> reply messages on a physical connection.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 9 +++++++++
> =C2=A01 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index f2a7dbc5e..5261a4a54 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -789,6 +789,12 @@ static bool
> drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
> =C2=A0{
> =C2=A0=09u8 crc4;
> =C2=A0
> +=09/* curchunk_len must be >=3D 1 (min 1 CRC byte) and fit in
> chunk[] */
> +=09if (!msg->curchunk_len ||
> +=09=C2=A0=C2=A0=C2=A0 msg->curchunk_len > ARRAY_SIZE(msg->chunk) ||
> +=09=C2=A0=C2=A0=C2=A0 msg->curchunk_idx + replybuflen > ARRAY_SIZE(msg-
> >chunk))
> +=09=09return false;
> +
> =C2=A0=09memcpy(&msg->chunk[msg->curchunk_idx], replybuf,
> replybuflen);
> =C2=A0=09msg->curchunk_idx +=3D replybuflen;
> =C2=A0
> @@ -799,6 +805,9 @@ static bool drm_dp_sideband_append_payload(struct
> drm_dp_sideband_msg_rx *msg,
> =C2=A0=09=09=09print_hex_dump(KERN_DEBUG, "wrong crc",
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DUMP_PREFIX_NONE, =
16, 1,
> =C2=A0=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg->chunk,=C2=A0 =
msg-
> >curchunk_len, false);
> +=09=09/* Guard against accumulated msg[] overflow */
> +=09=09if (msg->curlen + msg->curchunk_len - 1 >
> ARRAY_SIZE(msg->msg))
> +=09=09=09return false;
> =C2=A0=09=09/* copy chunk into bigger msg */
> =C2=A0=09=09memcpy(&msg->msg[msg->curlen], msg->chunk, msg-
> >curchunk_len - 1);
> =C2=A0=09=09msg->curlen +=3D msg->curchunk_len - 1;

