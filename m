Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F74FC4452D
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 20:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 744C810E3C3;
	Tue, 21 Jul 2026 20:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gHW+XIjd";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF78C10E3C3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 20:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784666202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zux0FQwqS5dqbu+u3nZlsMBVqV5QPwfWD3UCTLe1nKU=;
 b=gHW+XIjdr3Z3jFdEEBBWx/L3MJ5mj26agwL2i1DXZWeBPx9KbWTSK0iEIcyPUS4fNAbVBi
 NcwtEcCH4dWpfQl5wuAYzm9wtc1J3gp/m3/zE+utsU+Xn4CjOTwqZnHbHmp9h+33pQy/QV
 awlbLLshwlSxfQBkIidQbH2LSn7+EMU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-cSoJWNaNNKSLK19ar6bY0Q-1; Tue, 21 Jul 2026 16:36:39 -0400
X-MC-Unique: cSoJWNaNNKSLK19ar6bY0Q-1
X-Mimecast-MFC-AGG-ID: cSoJWNaNNKSLK19ar6bY0Q_1784666198
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c01ff996dso94443161cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 13:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784666198; x=1785270998;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zux0FQwqS5dqbu+u3nZlsMBVqV5QPwfWD3UCTLe1nKU=;
 b=ez3u29ifWOeTFj4XBwISqqbIhx7S7POrtcIWpesUPc6vRZdmdf92Wbe61Uj7Au70Tf
 ZxbQOiPJ3+7NMSMIVT1HDf/uo+iGl+3PfAOBzM+7H6B8xs2m+Oc1GTstZ4ioBjrU7MiK
 5VaQ9EqE9PZM5OSotClVUfkxPN424MmAGa1P/OR46hDaE07ttKv9c5k/eQjrRcC3Qsvh
 vBzJy68VVVvbJntKLFCP5JsfI2v+SvT02t0dZFU/64M1q+zLTRs9B4iX3FstfyTL4+it
 xidsq9YXTil8qGIVOGtuqYGoM/Yczdvd1JgGZl9oYyA+vTA7gPGEmKT1nKNM7wBQ5t0j
 w4HA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqicJVsjBkpM66Mlz14mE1eVbSpKCvtm9CuC10zpGzTv0vZCaqB4Fn8NvoSD8JuNsWqeS1wyNO3lWc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwuxMMplGqOBQ+rfCGnbAuMngBQCJNIBKG5ndme62DnK3wU0dp+
 S33J/T7NUviiIV0rFsUHPryNFj+Nxv7WwS55cW7xEJ6NPYXQshgmiK64tJqQWOl2mwODwqXWWu+
 2KBZXF0/OW8ZkKT0hhxh+ryW1OLo4//7Xmy1CwvIPsii//C2Wt9Z2DMqnzoEmb+68n9C1vg==
X-Gm-Gg: AfdE7ckfotwgi2t+WCfhDtopAOiLAcWy2v4PYOXS7dqTLFZ7ocEaYniC+lq0NbhEGqP
 BOegzFXU/MLKHk321yE9H3Er89PeJ3wVbWuKA/ZwUHdRWDrn/8ilTcncPNyhmvbkDNf9sOnaR/H
 nHhrJSWJLInDHSGbUxLGzTvqii9AAbTKphz+OtVzoOnGiWJvlCAPKNgFMz+ZR4SGH1Beqf5n91l
 8uMB5sZKC4Pm3+FTWF4H+bD6tD/sG3DjIPZLPN1AIlv2BnqM4xS+Q1phI23fmgpQVkysMctKVu/
 p8nTgYRW6SCgFFYzoabIWzD7dOW3wy4p5aWLQaoxk0IO3HWvLFxO5+anN1luVarpw17E4yy0
X-Received: by 2002:a05:622a:1825:b0:51c:1d18:2fe9 with SMTP id
 d75a77b69052e-5213c10a2bdmr202739411cf.5.1784666198592; 
 Tue, 21 Jul 2026 13:36:38 -0700 (PDT)
X-Received: by 2002:a05:622a:1825:b0:51c:1d18:2fe9 with SMTP id
 d75a77b69052e-5213c10a2bdmr202739041cf.5.1784666198087; 
 Tue, 21 Jul 2026 13:36:38 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-527cda3c2ddsm2829911cf.0.2026.07.21.13.36.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 13:36:37 -0700 (PDT)
Message-ID: <37f6625f23cc0c041d5d079dbca683d47fe9b4fa.camel@redhat.com>
Subject: Re: [PATCH 3/6] drm/nouveau: add GSP hwmon support
From: lyude@redhat.com
To: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Danilo
 Krummrich <dakr@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard	 <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie	 <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard	 <mary@mary.zone>, Milos
 Tijanic <mtijanic@nvidia.com>, 	nouveau@lists.freedesktop.org
Date: Tue, 21 Jul 2026 16:36:36 -0400
In-Reply-To: <CAA+WOBuLgkKy_BAgEWgN7jgxDrJYchO1D+B44u6VVMPsGJ-AEA@mail.gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
 <20260714211429.238355-4-mohamedahmedegypt2001@gmail.com>
 <78ca5c308ce81465956e839c82e1bba46a9f0686.camel@redhat.com>
 <CAA+WOBuLgkKy_BAgEWgN7jgxDrJYchO1D+B44u6VVMPsGJ-AEA@mail.gmail.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AQomnzpQF00TwL3RJ-gIyPLwU-V0VmsxoTN3kSJ86LM_1784666198
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

On Tue, 2026-07-21 at 23:36 +0400, Mohamed Ahmed wrote:
> It can work but it's strictly worse than this. nvif_msec() does busy
> looping, which would be overkill for this as it would be doing a lot
> more reading for something that changes at most once per 500ms poll
> cycle, and it keeps the CPU fully occupied with every read. It also
> couples us to GPU timing while the main thing we are waiting here on
> is whether the GSP's buffer writes are now visible in RAM so GPU side
> time doesn't offer us anything. I actually wasn't sure at first how
> to
> properly wait and did go over all the possible timing alternatives
> and
> jiffies looked to be the best here.
>=20
> That said, to address what Milos mentioned (the weirdness of files
> being -ENODATA), I am going to have to move this into nvkm/rusd,
> inside r570_rusd_supported()/r570_rusd_read() which doesn't have any
> other alternative available to do a similar style waiting loop.

Gotcha, sgtm

