Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FDCC5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34B3B10F177;
	Thu, 20 Aug 2026 19:21:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Bd85xN5w";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09D0510F178
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787253685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fhaFBj8frGzXeQE938JwPttRSZ/huDZP2vb0SnctFr4=;
 b=Bd85xN5w2oG1XlsDxHI4AUeHPn6kpWJaCr2A3BnclEiL8/1EcXw+dHOzwCW9AvPr7ferRy
 zquZ6FJ8l+a2rXUO/dopt0/I7J6epg5NKKEFUpsXdaNck5hLGOLP+AYtaqfdmBWiIi2MFA
 90VwQLvdEsgeeYOlpL1q/vj/lHP+5aE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-TRcYYl_aMuG35gT3xvVVwQ-1; Thu, 20 Aug 2026 15:21:18 -0400
X-MC-Unique: TRcYYl_aMuG35gT3xvVVwQ-1
X-Mimecast-MFC-AGG-ID: TRcYYl_aMuG35gT3xvVVwQ_1787253678
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f113592bf3so4216536d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 12:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787253678; x=1787858478;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TgFrJA0kGHjEoIJ3Eqsw42ND56xZloAUAzXc6L7b5qs=;
 b=icUHGam3XhTPwSTJIpy0sQ6KzTHscg3p2t2PqT1icebSj/nvNShKRSw11e30Nt3f/F
 hv1qjmwx9c3DsaVnQJJux1QGCfR4eKPX9q/CpKWVXPT++qnw/iuxzAzRrpYRFqPHX+mv
 5rKQnwHQkCUK8mCdpdPdXmVvmxncuEhQPumVvDt+JkC++M1+TwfOByrGozStbhOMlN5Q
 jGk4PeEW9XHh7vBl1qdVv65SJxjA8fT9+JK5U947z6CG0xDxWtk/uufSjW58AmU3vT2G
 4/9oJkc6e0BIBJzn6/cbfIsuUwhI9B7aluXJZZofIPyGmwiIBLRgqJDNcBX/6HE2Ip5g
 r6NQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDlO6wjGrSqf04QWM3C2QX2yW4Sb5uZeQY2lsb3doF+rLgYhSAgum+LFQ868pTcHwBo8czuwoRPlY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m3iiezR6thCbbQFDZawH1cjS9s7DAl2j4EY4ycvocj44YHuHmw
 6oRKC4AsLBkeKu9VHDlZhZWXqMrf/sVDwNqKWKyJyQg8XLTrE5KqTf8ERsFU18s3x9jtCy8zHOQ
 3j5gG+z68WkWw960V3tw7qtJpCd+8cc7VBtDVRcgRjGk68mgY62brUk5gnm/PWveum1o4hg==
X-Gm-Gg: AR+sD13mjwqZQ5i/PW/bzR9PvEjpd3VB45gn7qrfI/Ky2jRxcaueKNShxFFIylS2CzT
 Lw2eudwQUdPHRr1Ddo075k42iB4IxjUitH3j5ntJw/M3TEJJS5BBSbRlGcjQz8v8Uahtp15f5Qe
 rVL1YUetaVQdMNvkwRlXuZDtVY/vaWHBOBs/m5VZd82VPavm+tIg0aQwRqKdyEHj60NR9DadOW+
 FF80QvoyAsdXIZB8mcEZPJkYlIJ7bHpEcl62SkHRp7PfvbcJSStdSt3+hySosDB7hwJIEmtc+86
 gWtZnbwPxOZkVe8B3+LVzw8ZIHB+Mbk759HoZIL7fM5vb22O5SEgxjLaE2pt30GEGbZkctr/
X-Received: by 2002:a05:6214:4b09:b0:8ce:ca7d:b099 with SMTP id
 6a1803df08f44-90c80cabff4mr5132376d6.18.1787253678213; 
 Thu, 20 Aug 2026 12:21:18 -0700 (PDT)
X-Received: by 2002:a05:6214:4b09:b0:8ce:ca7d:b099 with SMTP id
 6a1803df08f44-90c80cabff4mr5131856d6.18.1787253677671; 
 Thu, 20 Aug 2026 12:21:17 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2a2d62sm44581786d6.38.2026.08.20.12.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 12:21:16 -0700 (PDT)
Message-ID: <c07891a66d5373c12b2baf8ef97540b34169955f.camel@redhat.com>
Subject: Re: [PATCH v3 3/4] drm/nouveau/fifo/nv04: filter benign CACHE_ERROR
 from Mesa NV50 bind probe
From: lyude@redhat.com
To: Marek Czernohous <mczernohous@gmail.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Ben Skeggs
 <bskeggs@nvidia.com>
Date: Thu, 20 Aug 2026 15:21:15 -0400
In-Reply-To: <20260812231330.705425-4-mczernohous@gmail.com>
References: <20260812231330.705425-1-mczernohous@gmail.com>
 <20260812231330.705425-4-mczernohous@gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gy9hfEBvOYKu087MRjEK8W0J5reQN6Ix2fhLREcxwh8_1787253678
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

On Thu, 2026-08-13 at 01:13 +0200, Marek Czernohous wrote:
> +=09=09 * chip that reaches this handler, not just on
> Tesla.
> +=09=09 * Demote to debug to keep dmesg clean while still
> catching
> +=09=09 * real CACHE_ERROR events.
> +=09=09 */
> +=09=09if ((mthd & 0x1ffc) =3D=3D 0x0060 &&
> +=09=09=C2=A0=C2=A0=C2=A0 (data & 0xffffff00) =3D=3D 0xbeef0200) {
> +=09=09=09nvkm_debug(subdev, "CACHE_ERROR - ch %d subc
> %d mthd %04x data %08x (benign, skipped)\n",
> +=09=09=09=09=C2=A0=C2=A0 chid, (mthd >> 13) & 7, mthd &
> 0x1ffc, data);
> +=09=09} else {
> +=09=09=09chan =3D nvkm_chan_get_chid(&fifo->engine,
> chid, &flags);
> +=09=09=09nvkm_error(subdev, "CACHE_ERROR - ch %d [%s]
> subc %d mthd %04x data %08x\n",
> +=09=09=09=09=C2=A0=C2=A0 chid, chan ? chan->name :
> "unknown",
> +=09=09=09=09=C2=A0=C2=A0 (mthd >> 13) & 7, mthd & 0x1ffc,
> data);
> +=09=09=09nvkm_chan_put(&chan, flags);
> +=09=09}

I assume this won't break anything, but hindsight is always 20/20 - so,
I think we should probably keep the print of the channel name even when
demoting this to debug in case we have to investigate this someday. We
should also move the nvkm_chan_get_chid(=E2=80=A6) call and nvkm_chan_put(=
=E2=80=A6)
call out of the conditional, and probably move all of the printf
arguments into their own local variables in this function so there's
less to maintain for future changes.

> =C2=A0=09}

