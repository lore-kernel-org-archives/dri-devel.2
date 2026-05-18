Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765F0CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 17:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FC210E0D5;
	Mon, 18 May 2026 17:51:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="QZ5sYW91";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3451810E0D5
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 17:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779126675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmre1V/nKzaK+ve2LCGOx+cPevp7RxRZtbp1xtA462Q=;
 b=QZ5sYW91bHhqrFMe8PbwXMBZyEeDUzfeV6+lR/4HwzQjBjFX6afhZlksKADnT6Fm2CJy5T
 wpotTy5hdaxdkeIl4V6TLG1QYMOKX+xbJCK+eQeQPMwjAmPVRSlk+fCcLCp4D5UaHohUry
 SQ1IPu2DH2GGaaNZFI+NEXho7aETJDo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-hCgjgj4-OZyw69aB7q0t1w-1; Mon, 18 May 2026 13:51:13 -0400
X-MC-Unique: hCgjgj4-OZyw69aB7q0t1w-1
X-Mimecast-MFC-AGG-ID: hCgjgj4-OZyw69aB7q0t1w_1779126673
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-90f4bdebe77so547622585a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779126673; x=1779731473;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e0D/2lnvFHwbgVt4+FwCYJ0wron62f0hNfGCEfp5oz8=;
 b=FLg98j2fBSlws/Lm9N3Rq/MwQ1kljVDPcGsddVUuw9Wj20a0BaeLzVGiOPk/86wBkn
 F22/cY9NsoQBPNRX8tbcq3Q/9Qy1c0OyGj2TVCtJ5oONI0tfOF1uHkzjOlVqz4sue2oK
 h00ijOc/WpccseaHxPQM1QHApgIJphvjKewse8s4Szs03tcZOv2cZ2ygxkWPFcbQlwZl
 o9HNT3ZutweZzwpDdekna2ZKEM501x63pyCDr1GHzxgN70ISlIWDstVAECeNKiZb5Zju
 b54dj59iXg4B9hWYCYPfe0iOgdC9f2sKVy1+RKS6iHL5/ng3UEr4Jvgp5tpezmwBH6+k
 W5Cw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+URtTpMotzVPVHoOEAD86Nn5NEwVAqCer3O/+Cgr3aXiR2rWlji3BHfjIDUEyGcw4vvQQ3fzX9atE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1sFKtwtAgoZp7Rw+TnsM0+5MSV71bW6Z8J0MQw/zlvE2swkZ0
 /VQId+xIbaxqOFBk1VVvViaz0IpfMYri9OSi68jJoq12Wt4I8BZbEXLpLpDXaTNEhvM4kNWOD8T
 lU6fiAS02m3P7JTL5AiWzMp15uBmO0iNoZzEtdU8YEcvLx+hkUBdAjjSc8qnld221lZPqVVnWYQ
 cOrA==
X-Gm-Gg: Acq92OHk0PqDupVnlN9OhSQq17mdWf5oKquWb5+UW+GVUVgI+G+kijiBdZqRkpFGyid
 2B08TZOT0HW3EY9bqvwLnQb785QPBxYA55mUIwrTLaJyTFCyU51RSb1ZHrhIJkkeMqAtz00yuZw
 LL76bJsIPFDAE7/AOn8JnW0SL2ixLjgQN5jqnq2JL2gRlmiKILAiW1c+pvpQcuoMOLrfhQKPQuy
 KX0pozJJeJs/H4qEP1BKPbZ9ycZedC/qTV81WrDx3mK//H/008zWDvG0ziBffNxdqP7xABNLAtW
 46ILdMVfShjenQGQMaHRdSx0syHOk7sdODVzuizHlqp3+qOcobOZj2oMl32mPt33wJdSHJodqtp
 2xD85y7Vga3yM8chr3w==
X-Received: by 2002:a05:620a:170f:b0:911:5568:364e with SMTP id
 af79cd13be357-911cea09f95mr2541778385a.37.1779126673367; 
 Mon, 18 May 2026 10:51:13 -0700 (PDT)
X-Received: by 2002:a05:620a:170f:b0:911:5568:364e with SMTP id
 af79cd13be357-911cea09f95mr2541772085a.37.1779126672725; 
 Mon, 18 May 2026 10:51:12 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91435ca2855sm449582485a.40.2026.05.18.10.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 10:51:11 -0700 (PDT)
Message-ID: <b8ca839c8561ad301f24921ea4c37b2cb129c4d8.camel@redhat.com>
Subject: Re: [PATCH v2] drm/dp/mst: fix OOB reads in remote DPCD/I2C
 sideband reply parsers
From: lyude@redhat.com
To: Ashutosh Desai <ashutoshdesai993@gmail.com>, 
 dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, airlied@gmail.com, daniel@ffwll.ch, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, linux-kernel@vger.kernel.org
Date: Mon, 18 May 2026 13:51:11 -0400
In-Reply-To: <20260510201733.2882224-1-ashutoshdesai993@gmail.com>
References: <20260510201733.2882224-1-ashutoshdesai993@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oG_W5gcT-rqxss8s_aRwvdBoclRSLYMKxaJcU9T2n4U_1779126673
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

Will push to drm-misc in just a moment

On Sun, 2026-05-10 at 20:17 +0000, Ashutosh Desai wrote:
> drm_dp_sideband_parse_remote_dpcd_read() reads num_bytes from the raw
> message and then unconditionally does:
>=20
> =C2=A0 memcpy(bytes, &raw->msg[idx], num_bytes);
>=20
> without checking that idx + num_bytes <=3D raw->curlen. raw->msg[] is
> 256 bytes; if a malicious or misbehaving MST hub sets num_bytes
> larger
> than the remaining payload, the memcpy reads past the received data
> into whatever follows in raw->msg[].
>=20
> drm_dp_sideband_parse_remote_i2c_read_ack() has the same flaw (noted
> with a /* TODO check */ comment since the code was introduced).
>=20
> Fix both functions by using a single combined check
> (idx + num_bytes > curlen) before each memcpy. Since num_bytes is u8,
> it is always >=3D 0, so this strictly subsumes the simpler idx > curlen
> form and no separate step is needed.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> Changes in v2:
> - Drop separate idx > curlen check; idx + num_bytes > curlen with u8
> =C2=A0 num_bytes (always >=3D 0) strictly subsumes it (Lyude Paul)
>=20
> =C2=A0drivers/gpu/drm/display/drm_dp_mst_topology.c | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> index 170113520a43..9416a48804c8 100644
> --- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
> @@ -871,7 +871,7 @@ static bool
> drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
> =C2=A0=09=09goto fail_len;
> =C2=A0=09repmsg->u.remote_dpcd_read_ack.num_bytes =3D raw->msg[idx];
> =C2=A0=09idx++;
> -=09if (idx > raw->curlen)
> +=09if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw-
> >curlen)
> =C2=A0=09=09goto fail_len;
> =C2=A0
> =C2=A0=09memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx],
> repmsg->u.remote_dpcd_read_ack.num_bytes);
> @@ -907,7 +907,9 @@ static bool
> drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
> =C2=A0=09=09goto fail_len;
> =C2=A0=09repmsg->u.remote_i2c_read_ack.num_bytes =3D raw->msg[idx];
> =C2=A0=09idx++;
> -=09/* TODO check */
> +=09if (idx + repmsg->u.remote_i2c_read_ack.num_bytes > raw-
> >curlen)
> +=09=09goto fail_len;
> +
> =C2=A0=09memcpy(repmsg->u.remote_i2c_read_ack.bytes, &raw->msg[idx],
> repmsg->u.remote_i2c_read_ack.num_bytes);
> =C2=A0=09return true;
> =C2=A0fail_len:

