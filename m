Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC7606A328
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ue0Iyl6s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3DD112C31;
	Fri,  6 Nov 2026 09:18:42 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com
 [209.85.128.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AE1410F055
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:00:22 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id
 00721157ae682-8b315dd057bso1272487b3.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 01:00:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793782821; cv=none;
 d=google.com; s=arc-20260327;
 b=fS+jgQV/2NQYoRZD1ItGqfJWom4oWyM9SZTPgvRlDH4/gkp4otABEpQRpAlshzD5O5
 GW2d/qnGzIRBE3P8jej/sBe7n/4f82JO7uYOAaGXLBME6vDsBI2IsvRysG/YdLEGIgNq
 DK3DSX3o1gSZpL54oNdLsPLCWq1yqmZX414ui+ZUFCPenoI+dcIMjxFpjO8esz9Iv9+c
 UZSdG/yofgTnetQ5RIVHPOn+Ywi3g/y+s/I3Aj9HzGFcCpLLlXmoYfvjLSvdMYYtMnPb
 EK2WyEl7S5clf/UJu1B9Svb9TD0+5mZqZzqbM3vkl09l+pjWGV8gwb4mQtJ4H6oj/PPA
 XxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jTRnpEDN+KWb3ei+FUpJVOT/UTcJwtCB9oaH08vzv9M=;
 fh=wQyt+tH7F3iEALlC6Wn74YNWutMU8Pf9jz7/05aJbt8=;
 b=p2IhQwLDxRExfOUsDLNikTY1xUYMBOHLfep2nkAkNYQtyw2T3opYGktpr8t/d/ufxE
 gP6mYA8N6Vqd2/4c/IaXgIlZ6u4hEH2bn7tffFOJKI1E9iZBrvsdhQNPZ2ruDjYKkd0z
 CMK44JypdHVePB86naGXRitHwhD666v2JQPv+uw/3Knv8t00htuBbIw3jOStSKX1FDOS
 ddUJoj8GoHS5LX7RmvRZF8Sm+y/DvAI4+OT8AlZ+itiJOgdfIwC9ELnoRrJKbORerwii
 yZSj4Reh0GleKK8tOG01VtrJzfSdKy8QEuf7F5fnW6duOZ0/t+qsQk8Oqf/um3iiKmKq
 UonA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793782821; x=1794387621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jTRnpEDN+KWb3ei+FUpJVOT/UTcJwtCB9oaH08vzv9M=;
 b=ue0Iyl6sYIrYBoyQZx1C/1fR9H7cbpDdBFXCheHPpwGSk8Bjd8Z6Vd/gFS6bIIqJSx
 dJauAqQAMpGfdLPRlz799X7Pr7v4XvZliEcjgLuRLAv+qQ61j0Ddx1Dg64xe0n8NW1bw
 Xm71+T1UEUPT0dkMNXJzNd3vtvOgPT/p2bdawIbGSPQUxg9ToN802XRLXv7au2RKI/UH
 SzZHnUaFobQ+Ouy/uyW4UMPicVzW/9Kk69H4dlhYFA7zpF9bCvpCpJXpGAyuoGQTCu47
 mK+6tCpbSOh+V9a+4wkjCeQ1lcZhIamCKWkf3awTUxuSLbyWsCGmgAGKxNYVk7+ueVcQ
 dT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782821; x=1794387621;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jTRnpEDN+KWb3ei+FUpJVOT/UTcJwtCB9oaH08vzv9M=;
 b=l6U31UCl0iepUp85MqYreiEFt7J0cFJ6jKsUPFmFra4KMJL1zPYJ77KZCXquc+4PEn
 GPZsIWcM2xZ8wmIXDwRN3gM9apgQyIyVo8faFyk4Inha+8GSMspG8roWUyV6PQfOnngA
 AHSGU2/4vwlCCuCdVNFB68qJvN+T56tGnfLnuu3EMqwe3iXyyXZ94RdXVr0m5UG+pe5C
 A9FE9lwB5MVtqvF5YYeSAkDrXR75UxI16GTgsMaXNRd6qqxMYzA7ysuCTy/ESfaRR7LA
 V9LX+krE35nYlpor+J6vYuHR8QlYbOUoObJzg+VunJWI18fndc1MmbD688uOvZf4s4DE
 tfKg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxBa1YoKl94++VsSfCvnI7/ajB+Lk80hqxBLJGE0qJB0NPu3TeAgPbVqr5ZnKVTdpajis5PM7HkkrY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z94dtHpnLBY8/28K88pLxEEiGo6z59dXK7eOZprI+gqYRVufQNJ
 4+FFGzdnhvEEO37w829TxgRlrlJE/jXu/jNgpjAFQbZQw13v9G0fRWN4h+SmOUmyBmgayIP/tTN
 APzPQIKEf+Y5IijmHjbEhNKYNkUyYnKc=
X-Gm-Gg: AYBFou1/Kv0FB7EJO0KZO8FDCwd/RQg5F57ok1CYSag/IWbGJw7TVehPaTMMSlD9hBv
 FAQx0kKl6unUQ4zE+7niHdCpwZC0/tx8CbC1m41LYYpglCLfEqGi53p4PWMIO13/soqPFtWMTyP
 Rm1pDU0bK3ak+GqXquxpun+zmjPrneYBfDmjk6qEIExN888du45YyhiL9AER6Zn1QOiNM1WouYO
 O039FJNq8LaYifixWx8l3Q1N35HI6nY3ksRJ8yfa9KZY38K8ZhNrbKs73nMQciHRyJAlSAV39K3
 +lwRF+ks+g5hBwysdLxg3AGGuikkZtSN9PrByq8fcL3ymauAMOb+OsyIXSCSorBUErzFjcwlQJW
 +upP8xq73QifgaO7kXr0CnoDwkZUKpkRPHr22NdgAeV/IiVp190/p8ObxmRIatbN18wYj
X-Received: by 2002:a05:690c:f05:b0:8a1:781f:4aa0 with SMTP id
 00721157ae682-8b2b67f1889mr109610237b3.56.1793782820885; Wed, 04 Nov 2026
 01:00:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261031-dp-tunnel-bwa-flag-v1-1-f94ed3179349@gmail.com>
 <20261102130145.GU158991@black.igk.intel.com>
In-Reply-To: <20261102130145.GU158991@black.igk.intel.com>
From: Diego C N <diego.sure@gmail.com>
Date: Wed, 4 Nov 2026 10:00:08 +0100
X-Gm-Features: AclHuK-KTLDrGi9C8ZMZKwzhArkycX_ZxWgS8iSAY08wiND5eYgccYF5_KZeB0A
Message-ID: <CACPnnOZHhdwOSDhsnG22SyPD1JsrcgM4Y26QYORd=xoUzhXuVw@mail.gmail.com>
Subject: Re: [PATCH RFC] drm/dp_tunnel: Allow BWA when the DP IN adapter does
 not advertise it
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Imre Deak <imre.deak@intel.com>, dri-devel@lists.freedesktop.org, 
 Uma Shankar <uma.shankar@intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Mika Westerberg <westeri@kernel.org>, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mika,

Oh, I see. Well, thanks anyway for taking time to check this patch and
for answering it.
I'll keep it as my personal patch since it's been working very well
for the past weeks.

On Mon, Nov 2, 2026 at 2:02=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Sat, Oct 31, 2026 at 01:18:18AM +0100, Diego Nogu=C3=AAs via B4 Relay =
wrote:
> > From: Diego Nogu=C3=AAs <diego.sure@gmail.com>
> >
> > On an Alder Lake host (i7-1265U) with a Thunderbolt 4 dock (Dell WD22TB=
4,
> > Goshen Ridge) driving two 4K@60 monitors through two DP tunnels, the
> > monitor whose tunnel is created second is limited to 4K@30. Which monit=
or
> > is affected depends only on the order in which they are powered on.
> >
> > The thunderbolt driver enables the BW allocation mode (BWA) on both DP =
IN
> > adapters: it sets the CM BWA support (DP_USB4_DRIVER_BW_CAPABILITY), a
> > group ID and the estimated BW. The DP IN adapter, however, never sets
> > DP_IN_BW_ALLOCATION_MODE_SUPPORT in DP_TUNNELING_CAPABILITIES (0xe000d
> > reads 0x01), so tunnel_regs_are_valid() rejects the tunnel with:
>
> Alder Lake firmware really does not support this and by forcing it to be
> enabled you may end up in untested code paths and interesting behavior :)
> BWA was only officially supported starting from Meteor Lake.



--=20
Diego C. N.
