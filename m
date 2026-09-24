Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1625BC98321
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B7A10F632;
	Thu, 24 Sep 2026 15:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="WF48CgyE";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1307010F631
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790262043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKTy1DV5Z8HP/0nQigR4wkQdWVD6m+LzXDtQhSwKE3c=;
 b=WF48CgyE55dtiKGZFTTd4Yx5uK+BVFW3hOpZHlI9D/q72DJQAVRzV/Cm7s5F8jWRVLHZvx
 /Ap7nhVtdZcJYP2ZjR2MyuCIMvbOu8T80OcagizcnHIXoYokifPQtMdRnw47OoOC7PW/I4
 0/Vr2GhBrk4PMRRpdHqaULN36KVRH14=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-KbWdCjngOG6Zpc8GjnS85A-1; Thu, 24 Sep 2026 11:00:41 -0400
X-MC-Unique: KbWdCjngOG6Zpc8GjnS85A-1
X-Mimecast-MFC-AGG-ID: KbWdCjngOG6Zpc8GjnS85A_1790262041
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8461ade272bso18336157b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 08:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790262041; x=1790866841;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YKTy1DV5Z8HP/0nQigR4wkQdWVD6m+LzXDtQhSwKE3c=;
 b=fpA5VGZJQ/rdl6f5un+y2A7DPZDjf7tbw34QvIDIhcNz8nqNyo8ORoMiVqZVYcXEGT
 q1x2K4HpbT7PdOjQZUanqspBsWvNfEW/wsq1jldz0SwqI0NtvNrFvIoLhG3S1EOIl14S
 +YoQoK83ThS1QPNN0YCOEMPAhU8nGpHEmtjPJUBrPsJ0vR+Gw6p8vQ135otmjAuTG4ll
 EGHBAXkmgjTDlFYnLeh91f0vRJxvftOWJ6JvqPN0ivRjifzu34g+9qUNvUf8dQ1mQEVq
 /DAs4F1BoBU4qJxMjc2rgGhf65KRSdv6vqHd3Y32OqFsrHdMEfAk9JqDLglMeuIdcAee
 aJPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNul2v1WAyr8jYAT0beDojJV23wbSPo78dTQdrY0v3hjRxiVMkYsZVWPeAK+6sHdTWi6Or4YF5wcw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kgVlDNAKYF1txo7HqHHRNlbmeRVIU970Hru/FDb/utVURSNe+s
 ByCYxxMeCoJ7tLstrBvfprM7wkjuFYZQypYMKldP/jROBsCanCdqEzvCW1PEhABVNyV8+r0hro0
 PNQ4WmLl9PEO5cYyVTNu6BYeRhvTdlv3T/pIhlWuxlqJQ4JOX8p2z4eJgYDPeL2CSLDHJ3Wr06g
 Rb/LH7liM/pzlNWzheOtTaOMkGy7A94Cc2WaKWh9UJxv5k
X-Gm-Gg: AYBFou3rRGeOUL6+h6Mq5/OgFxq7U9tpBMUMTCfB4UAUelHfTWyPk3ylNg/b9TOEeHA
 vdX+CJnH7Vs2urxszxaiH9CODnGbbGqwC2fRt+P3lmvLLdKD5p5NSTUQOafrQp+FL01kfwL73k5
 dwM3BZqz++hgAQfX2DdsaAWAlso6OcruXzHFatR2DyGfKHTaONlc59+Q==
X-Received: by 2002:a05:690c:f04:b0:8a4:af43:6941 with SMTP id
 00721157ae682-8a64e5d7328mr16132897b3.20.1790262040897; 
 Thu, 24 Sep 2026 08:00:40 -0700 (PDT)
X-Received: by 2002:a05:690c:f04:b0:8a4:af43:6941 with SMTP id
 00721157ae682-8a64e5d7328mr16131377b3.20.1790262038827; Thu, 24 Sep 2026
 08:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260914-scm-device-api-v1-0-3573e2596c51@redhat.com>
 <EKwbCgCnxbNX4p95qJ3xoytzeNBBLc2L_HOVWr-S-y8n7pNOIToj37TyoXRcLyIK1gjq_IvbreQ331gw6jIK9Q==@protonmail.internalid>
 <20260914-scm-device-api-v1-1-3573e2596c51@redhat.com>
 <b1340496-1ff3-4ad7-87c3-36d2162efbfa@kernel.org>
In-Reply-To: <b1340496-1ff3-4ad7-87c3-36d2162efbfa@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 24 Sep 2026 17:00:27 +0200
X-Gm-Features: AclHuK_S1nrFMWot6v8DC6klfULfaNk07isgmJtfP7BYAekyrR84kzWx2Uw9qhE
Message-ID: <CADSE00JhFYhDV2cuVxZwVTX6LTe8zH0-BR=-Fhv+6UXeFxq_Zw@mail.gmail.com>
Subject: Re: [PATCH 1/3] firmware: qcom: scm: pass qcom_scm to internal helpers
To: "Bryan O'Donoghue" <bod@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Russell King <linux@armlinux.org.uk>, 
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Christian Loehle <christian.loehle@arm.com>,
 Maximilian Luz <luzmaximilian@gmail.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>, 
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeff Johnson <jjohnson@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
 Jens Wiklander <jenswi@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Brian Norris <briannorris@chromium.org>, 
 Govind Singh <govinds@codeaurora.org>, Niklas Cassel <niklas.cassel@linaro.org>,
 Kalle Valo <kvalo@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, iommu@lists.linux.dev, 
 linux-media@vger.kernel.org, linux-wireless@vger.kernel.org, 
 ath10k@lists.infradead.org, linux-gpio@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KA8tEs8exXaosevfKzqKQKOSKwmqJqUF00bxj8f6nos_1790262041
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

On Wed, Sep 23, 2026 at 11:00=E2=80=AFPM Bryan O'Donoghue <bod@kernel.org> =
wrote:
>
> On 14/09/2026 13:41, Albert Esteve wrote:
> >   int qcom_scm_pas_auth_and_reset(u32 pas_id)
> >   {
> > -     return __qcom_scm_pas_auth_and_reset(__scm->dev, pas_id);
> > +     struct qcom_scm *scm =3D __scm;
> > +
> > +     return __qcom_scm_pas_auth_and_reset(scm->dev, pas_id);
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_scm_pas_auth_and_reset);
>
> Why make this change at all though ?
>
> It takes a pointer to the file static _scm
>
> The reset of the patch looks straight-forward to me but this change
> caught my eye.

Yeah, this change isn't useful. I aimed to avoid passing __scm to
function calls but it does nothing in this patch, it'd be better to
change it directly in the next patch that changes the signature.

BR,
Albert

>
> ---
> bod
>

