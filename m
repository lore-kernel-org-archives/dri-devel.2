Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627A3F459FC
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 17:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B423E10E9A6;
	Fri, 10 Apr 2026 17:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LT236VYx";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1950B10E9A6
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 17:40:42 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-b9c11eba219so281761366b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 10:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775842840; cv=none;
 d=google.com; s=arc-20240605;
 b=Kq4CZMP5zTWK9QUvkSkMxxDXK+5nScBs5S2K2J12iRxqYVTnBtCRTojUPBG85+dQEl
 nwLKux4h2M2zunJb9MLgwX2dwU6wNt5wSfxPOf6cLdsqh+cQRexiMOBd3fRv45TOCXH0
 Da/Oq9lTqmjc1fXforNNIp/RcYymIYntAyqJH8mTbo/If5X/iLZaGIfDa58b/vs9hkgw
 Hs/k/BW5YcLYuGkp22wvwvHa8HxLWMqZkylP14/nAipbZ1hnZhPLOG630bbbPDOTUnEU
 wLGofEoKwr2SLUg3hlXv9zDZfm7w8pajrEFbrENMD7gimdON0EGct3UV7bzpW3WhCO1f
 0Jrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dN6OHHDaiTfVdHomxkKXHWudndDr0TAk+XE4EiflmuI=;
 fh=equZ4F3a2c3Rq5Auo1Jv8SaaBGIWhYi0nRqYpYGUxEQ=;
 b=G5I4Ul7fnGEKyzr8JOU9pDR8FgTKrd8rGqEiP6xYXEOPTLYRbC+pK8ttEbRPaF9bD1
 L1NiBPqxAKtqCbcwHB8qWBBUQse5nhkZnIXo4pxG3zQcNEpK2dHuJo6N8YFSOMTvafBr
 93f8wrL0q7YaLaXUC1Z56qzxkn5gVdUKRqQYM5eljJeQOX9zTW6Gj2zU2BHAsJyh0DG/
 1T0SCdatKnGJxb8oJOkocStRm34akO6bvYTLmoE8zjHILTugm4WLRASNqk1oKpnN0ENx
 GJNZN3kUNVbBBnYWVAMfyuE0KUOL745s9XnWUeORrIV1QJSFtYia91goboUwQNnxEtun
 sMTQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775842840; x=1776447640; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dN6OHHDaiTfVdHomxkKXHWudndDr0TAk+XE4EiflmuI=;
 b=LT236VYxJgqs35x1yUPg3TW3JYPl2LB4xxJESAHmeBDFQj515n5TDrCvzbnjQ0hTyI
 SHw4ed2QL6zFbN02Z/pJj4wHMUUmh0xvPa9rjipYsI0onycUoUT79aQXZyynv7wg6H79
 +Cn5XxeLaf9i3/pc/i00gQduOU7qp4tBguXT9B1SImL4c/WDf7dzsk5D87NQzfT31DdU
 EbsshaQ8izI+c5ERNAZE+ABKKC9d9d20kolsufse8UNzqfvsKBAkKPS5mpE2bYS3+I8M
 HuCzNVev2OFb1otojJ2bvg+93zCQCGR62a/Q4wcZYY3K7VOyooU/mS9MXfdCfo9TAX6K
 aImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775842840; x=1776447640;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dN6OHHDaiTfVdHomxkKXHWudndDr0TAk+XE4EiflmuI=;
 b=nfRwV//1dVbVKuG9fTkB2jAE707tiUbjTeSAEAcu+DNCVwZAweIP67q3yk7rmL+7mE
 P3jhitT2NMPnjgo2T0gADAtv3EH2atI1+lEc1d/Lu9Hjq9q0XG/t+4pqFzXKQJJS+NpN
 9P7+Eg7ErHEfcZ0Sil4f9A4t/E+g/b8duCSzJivyw5x+kcX83tgkqojT9arsjZpIlemT
 lZbq8VOzS8NvflI/OF4rb82d++qwUF4xda4fD3oeSsNJNSUohD5RNVXKRiP0Q1nZ0SdG
 fpnIzXa3h49Y+aqmSIE9A2dpwR4AGpd4LOy41PQur+Y2EoPChb/3z3MowkDN4zz63Se3
 KqwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDz+0ii9+2SmwnEvm+BpBpAOETL5d65pW6aOP/53puMDBzTyfVT4bifr2IElYWHXYwlextNQ6ivls=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTOaPsQfQ/pwULKaX2umgkQspwvlxPGYyjs9su8cXPpUNTK1hT
 xyM+IEe0ahFJF90+raTifWHZa+glMacypl+HfMbpgErPZn1kBA3qup5joDDOFCQOPlmlznmwEE4
 8K7gHJ2wJP7vXJYMcebETDHSWiD3lY38=
X-Gm-Gg: AeBDieumUmFzdvbZLWioKtS3pwWeWyhVsYqL37LSCJjPXxscm44eFOWjIxm2ky7aB5G
 6uidNit21HXedp/WO3DmIgk2BMBmYdJP6VDeLpyIegiW+oI+Pb/Vn8r+nwSkE7+620mHH7m3yXq
 +S7qfKHawICP15qQykmmKvhSjcJWiI4MSchGM+rDNcwiYaq+yaFKgEL5h46tUtavFU2RGannvZN
 1D5lmGiCk5Hk3Szqt8pe6kIoJg3IrnjD09r5w+oS9CBljM8h2OrwzmSh9HTrs4M6SMzT2THpdcx
 UoodVCPa2a4l9oM4eAuvlRwBqI9ycqhjt0QXZpRR/usn/nyqsVRfMbEX5o0uVhlPImVhhtoehgA
 dQLbnvPmlqcTgNULT
X-Received: by 2002:a17:906:eece:b0:b9c:350b:f849 with SMTP id
 a640c23a62f3a-b9d7297e205mr254084166b.24.1775842840105; Fri, 10 Apr 2026
 10:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260401220643.12802-1-rosenp@gmail.com>
 <b772c81c-3628-45c5-ab11-a0737a94b812@oss.qualcomm.com>
In-Reply-To: <b772c81c-3628-45c5-ab11-a0737a94b812@oss.qualcomm.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 10 Apr 2026 10:40:28 -0700
X-Gm-Features: AQROBzAGbFQNHO1NpZGhgy_hzsDylIa-uvfdzOOR1DS2GBgDZwb6wKvs4Zz0Xlg
Message-ID: <CAKxU2N96X31nsB-Vyt-Sm1rQMTo8cuZG+UDN=37av8c_5n-EcQ@mail.gmail.com>
Subject: Re: [PATCHv2] accel/qaic: kcalloc + kzalloc to kzalloc
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, 
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 "open list:QUALCOMM CLOUD AI (QAIC) DRIVER" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>, 
 "open list:KERNEL HARDENING (not covered by other
 areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
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

On Fri, Apr 10, 2026 at 10:01=E2=80=AFAM Jeff Hugo <jeff.hugo@oss.qualcomm.=
com> wrote:
>
> For future reference, $SUBJECT should have a space between "PATCH" and
> the version. git format-patch will do it correctly for you if you use
> the -v option.
>
> On 4/1/2026 4:06 PM, Rosen Penev wrote:
> > Consolidate the two-element allocation into a single allocation using a
> > flexible array member. This reduces memory fragmentation and simplifies
> > the error path by eliminating the need to check for allocation failure
> > between the two allocations.
> >
> > Add __counted_by for runtime bounds checking.
>
> This reword addresses my "why" comment on v1.  However I don't see that
> you responded to my question about how this was validated. I don't
> require a v3 of this patch, nor do I really want one. I want you to
> reply to this message and detail what validation you performed on this
> patch.
None. This is a straightforward conversion to a flexible array member
(and future devm_kzalloc_flex).
>
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   v2: use macro for number of elements. reword commit message.
>
> Also for future reference, a blank line to separate the change log from
> the patch diff here makes the change log easier to find and read.
>
> >   drivers/accel/qaic/qaic.h     | 4 ++--
> >   drivers/accel/qaic/qaic_drv.c | 8 +++-----
> >   2 files changed, 5 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/accel/qaic/qaic.h b/drivers/accel/qaic/qaic.h
> > index fa7a8155658c..e237020f6aa9 100644
> > --- a/drivers/accel/qaic/qaic.h
> > +++ b/drivers/accel/qaic/qaic.h
> > @@ -152,8 +152,6 @@ struct qaic_device {
> >       struct list_head        cntl_xfer_list;
> >       /* Synchronizes MHI control device transactions and its xfer list=
 */
> >       struct mutex            cntl_mutex;
> > -     /* Array of DBC struct of this device */
> > -     struct dma_bridge_chan  *dbc;
> >       /* Work queue for tasks related to MHI control device */
> >       struct workqueue_struct *cntl_wq;
> >       /* Synchronizes all the users of device during cleanup */
> > @@ -206,6 +204,8 @@ struct qaic_device {
> >       void                    *ssr_mhi_buf;
> >       /* DBC which is under SSR. Sentinel U32_MAX would mean that no SS=
R in progress */
> >       u32                     ssr_dbc;
> > +     /* Array of DBC struct of this device */
> > +     struct dma_bridge_chan  dbc[] __counted_by(num_dbc);
> >   };
> >
> >   struct qaic_drm_device {
> > diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_dr=
v.c
> > index 63fb8c7b4abc..1dda8dfea5a4 100644
> > --- a/drivers/accel/qaic/qaic_drv.c
> > +++ b/drivers/accel/qaic/qaic_drv.c
> > @@ -43,6 +43,7 @@ MODULE_IMPORT_NS("DMA_BUF");
> >   #define QAIC_DESC                   "Qualcomm Cloud AI Accelerators"
> >   #define CNTL_MAJOR                  5
> >   #define CNTL_MINOR                  0
> > +#define DBC_NUM                              16
> >
> >   struct qaic_device_config {
> >       /* Indicates the AIC family the device belongs to */
> > @@ -405,15 +406,12 @@ static struct qaic_device *create_qdev(struct pci=
_dev *pdev,
> >       struct drm_device *drm;
> >       int i, ret;
> >
> > -     qdev =3D devm_kzalloc(dev, sizeof(*qdev), GFP_KERNEL);
> > +     qdev =3D devm_kzalloc(dev, struct_size(qdev, dbc, DBC_NUM), GFP_K=
ERNEL);
> >       if (!qdev)
> >               return NULL;
> >
> > +     qdev->num_dbc =3D DBC_NUM;
> >       qdev->dev_state =3D QAIC_OFFLINE;
> > -     qdev->num_dbc =3D 16;
> > -     qdev->dbc =3D devm_kcalloc(dev, qdev->num_dbc, sizeof(*qdev->dbc)=
, GFP_KERNEL);
> > -     if (!qdev->dbc)
> > -             return NULL;
> >
> >       qddev =3D devm_drm_dev_alloc(&pdev->dev, &qaic_accel_driver, stru=
ct qaic_drm_device, drm);
> >       if (IS_ERR(qddev))
> > --
> > 2.53.0
> >
>
