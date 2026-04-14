Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD3DF9D0ED
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 18:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F56110E616;
	Tue, 14 Apr 2026 18:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mechasystems-com.20251104.gappssmtp.com header.i=@mechasystems-com.20251104.gappssmtp.com header.b="y+rvV35i";
	dkim-atps=neutral
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A60810E069
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 06:35:17 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-38e7b0903cdso15250981fa.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 23:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776148515; cv=none;
 d=google.com; s=arc-20240605;
 b=ezzhVelYJ8owkVK8HV++QuaT1TzRAl2j0yhv0PFesKe5GBUBpoqDwzHWe0J2WSf5DF
 buAvYj/OQuIjdGBG/zcGmlhXjUcHZr8/E1Pa0FBh71HSZPgzAaWbgeos+C5gK12tdlB2
 /R/Ry6xnxAo2HGVHATgbEggArO9yjg2BJxm6a64JDAsEtZ5N8Rm3ndIB3BRzuxa7jyZW
 KRI/DcOWRfbkI6jhm0uRg1L4rttnKzzmqrNFOTFRDutWfKW62uzPV0sDGqU0Mulmt8mn
 OrBqlZkjDFtaao962UlDt8H2w3GPb+DwM7gtxu7FopjoYtLNUSNqGCswISXf5pikdOka
 txSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7O5b4cGVPKsvcNPmXRaJvLz/LMUgaIpEgEY1d8OANag=;
 fh=C9x8O3ZKICJZ/jGpqtv4nYVMgAVNcg91y+ZMkH1GyW4=;
 b=QRBUn2v8HfaeY2A6btnQ8oGVOV77IDEMJSL12O7S80orTJJKCzWitKk6dGsObryzmL
 OlGDsT5/8yKoeu/B4HffhgaMv+xFf/ghOLw4XhsWGNd5Uu9VKvH6uiskIZqVPfsVOuDd
 nvvX4/ZohtlSUeAanEK7s1/UGLps2WkSmUzWks0hvYeLKsm6GN9RP20rqstVRd1n2c8C
 Z5+abG8X29p9qepDkEUCViiIxmdhJoPlrVIh52o4wUhR/nFAR8ZBd732kFQS7k/FPX/l
 n0gCKxqzg1f6kSQKUVqoU+O8VDJgMjF1JvE6FWoS7P+TuVK0LoGIVXmdOM2U8PQLWE3S
 zGGw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mechasystems-com.20251104.gappssmtp.com; s=20251104; t=1776148515;
 x=1776753315; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7O5b4cGVPKsvcNPmXRaJvLz/LMUgaIpEgEY1d8OANag=;
 b=y+rvV35iTRs1Z2lEYjXzkPc93SXIDbU51Vjmoy4whJMWVDubRQppUGyq15AfB3b+/b
 Aw/I2oI9OBp9wffR0m8YhJGj2iVYlNB4MRK0Q83eXSfXYVTS88B3lq2i1Ua+88vODwB8
 qC0KX47a40qjJKGZiZJXoJs3Kct9cUh64JFvZDrQfGBS1sYQCcHGHKDkwvmPW7R9qHIu
 z/jKwnVwNqYcsrghmcJmI2QS7oRdkoYN1QVJaS2hLdADrVJ6PmL8zfybIfFYZ5YHnXna
 aXE6ys4t6kec+PhcBvT5Pb9DWWE++2H2iy5xIapXg1wAwOSMV8BfcpcDXMxoRU4JuHGG
 wJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776148515; x=1776753315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7O5b4cGVPKsvcNPmXRaJvLz/LMUgaIpEgEY1d8OANag=;
 b=AaJD/CnkHLEXGW5gGaWAvlu74cupxkLklaBcWsEhgwRyeNEwXHbTIGozWKGpBQ9rRG
 NWgrxoeyLXZQ5S5qc9mtDiZW3STd+au5Q97/Yw+Py6K9CaGdLPz41EgECWsu/M3kgzpZ
 jJ6QCtYaQj/lb5nIuJmTn9hPIZ20jIoWdyOdT7qIILNROKd+8dT1wueP8TBtsgRlSMxe
 TeJqFIEUtJ5yQQc75u2gMJtrfMy5QeVhcFtbCp53YLJJzkq+IPXrT+glgmWjHvx9T1ub
 3BD2SNWSaPkGqNbQFBOZAiu4/DM2UMacMr20ahEoD18BGdm6OpoSgO8booRJWU6HkJCM
 FoCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ93Ccgpuayov/vU5hEZj1SMaBdz2R8uByVvE/RhlwgNpWVfSoufYYg2/OBRxgVLf1shkO6dYOyhm0U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyv4koKALQcyBsgQ5ccL2xEjERRmdfOcjpvJ1vaYpgjuXSoyJ+B
 +W1nWvfpOxZbeRchucuL81grz3hgBoNOvOAVgoJQOIBYeQpeSKnFDPDD5+D0W4WtskE0pHlBnNO
 6b+j6HYs1xCRV5keR1A8o3TVksRpdEthWVKDv0XIaqQ==
X-Gm-Gg: AeBDieug51x2EWYl9Vi5/tsrfPAlw4zgaxRHMXYUQ9d1T1diciIvZplzMe3lTOaeqx3
 ZvcA5NBHYwB5JXfUIWC0fx6dkwtcyZXb5PjzES3es5IdLjnay3wc9TQ94dQe2hK+uhTK9QFxhPi
 3aCYUk8JmH4L/VhSbCi/vTkMBlq+IdA8PjwKPxYZyoLUbemn9SFiAsiK90F1tepmskGJr99uz31
 OuFuyeL4KK84uN7FVJuiWFg2eYHE87zFM9nDvAyAGPlAjqbmqbeabrS/WcNldsx2bGxPjEIks64
 jwfAPZ23ZehihBPgbt3u8WWQ0NtHDnR+2gLiaOK+
X-Received: by 2002:a2e:8a88:0:b0:38e:7b10:fdca with SMTP id
 38308e7fff4ca-38e7b11028amr23413361fa.18.1776148515199; Mon, 13 Apr 2026
 23:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260413114456.173485-1-advaitd@mechasystems.com>
 <99fdddde59e1b0fe13d5014182b1c97de4fbec86.camel@pengutronix.de>
In-Reply-To: <99fdddde59e1b0fe13d5014182b1c97de4fbec86.camel@pengutronix.de>
From: Advait Dhamorikar <advaitd@mechasystems.com>
Date: Tue, 14 Apr 2026 12:05:02 +0530
X-Gm-Features: AQROBzASMMowUHpiQY8V3AZzIF8UFIDuQygsDzeqZIIv6U3TInzAp3bBuMtO9xM
Message-ID: <CAAPs2HRQ12Y18y1JGRE+8htegjUiKN9S5JP14rkAye=pdoxt-A@mail.gmail.com>
Subject: Re: [PATCH] drm: mxsfb: lcdif: enforce 64-byte pitch alignment for
 scanout
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: marex@denx.de, simona@ffwll.ch, imx@lists.linux.dev, festevam@gmail.com, 
 kernel@pengutronix.de, dri-devel@lists.freedesktop.org, Frank.Li@nxp.com, 
 s.hauer@pengutronix.de, maarten.lankhorst@linux.intel.com, 
 linux-kernel@vger.kernel.org, mripard@kernel.org, stefan@agner.ch, 
 tzimmermann@suse.de, airlied@gmail.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 14 Apr 2026 18:48:22 +0000
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

Hello Philipp,

> I wonder if setting 4320 bytes stride works if you reduce the burst
> size, for example by reverting commit 2215cb3be5c2 ("drm: lcdif: change
> burst size to 256B") to test.

Unfortunately, reverting the commit doesn't seem to fix the issue.
I tested with the reduced/default burst size as well as explicitly
setting it to 128 bytes, but a pitch of 4320 bytes still results in a
corrupted output(stretched and choppy display).

However, using a 64 byte aligned pitch works in all cases without having
to alter the burst size.

Best regards,
Advait

On Mon, Apr 13, 2026 at 7:16=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix.=
de> wrote:
>
> Hi,
>
> On Mo, 2026-04-13 at 17:14 +0530, Advait Dhamorikar wrote:
> > The LCDIF controller expects framebuffer pitch to be aligned to a
> > 64 byte boundary for reliable scanout.
> >
> > While byte-granular pitches are
> > supported by the interface, the i.MX8MP reference manual
> > recommends 64-byte alignment for optimal operation.
> >
> > Corrupted output was observed with XR24 framebuffers where a pitch of
> > 4320 bytes caused visible corruption and choppy display, while an align=
ed
> > pitch of 4352 bytes worked correctly.
>
> This happens to be divisible by 256, which is is the burst size
> currently set in the undocumented CTRLDESCL0_3 register fields,
> according to the comment in lcdif_set_mode().
>
> I wonder if setting 4320 bytes stride works if you reduce the burst
> size, for example by reverting commit 2215cb3be5c2 ("drm: lcdif: change
> burst size to 256B") to test.
>
> If that is the case, it might be better to allow unaligned pitches but
> configure the burst size depending on pitch alignment.
>
> regards
> Philipp
