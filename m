Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A71103E195
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:03:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CA8110E864;
	Wed, 18 Mar 2026 15:03:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TDwkupKr";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1C3910E84A
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:03:42 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-660a58841d4so6088a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1773846220; x=1774451020;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVkvfcgaX6pEcJXXNsO/QlCdiPKigbZrNv23AnUGslk=;
 b=TDwkupKrHln175bIPK4lvvE4dXWzzMNZT05UTVAx0+/2NeG2XCztYsH9Apcjx59jo5
 1UDZuc5P413ttdTJj2Bt7I2v1PErc6ch7W+lYwrcRtyi9Gy+Oms4ejpRYLwzfMlDYvYv
 xzON11mb0j/NlQ8mXymVrJvOZ8c9Gl5r0ravY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773846220; x=1774451020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BVkvfcgaX6pEcJXXNsO/QlCdiPKigbZrNv23AnUGslk=;
 b=fmYDhRPPyR05EvHMbUxjIOkaLZaecH0DExwOJXNMfh5EFfSK0QsVDSdhI1YhMgcCDA
 xD0NOZp3eTSV8Rt9uCrM+ah3S52Hj3vIy1Ng6AtE7ePwxjvQHymsgZA6ZZGpYv8cQmSo
 lGiJNgFetdMVF0gPhAcaTlblsgiW0Yic54rJc1nzlCwurnE2tINEw7Rasn79ZBaWvyAV
 gxN5lNbxTX+0yeg6AVSyGCcss40fDPhGrsTvQFOuPX8KBAPeor0mePcTwkiwmbd7BlFK
 vgaSzfOwxgd0jUgOTxPGfM12foJydNZq7fCZX+FTpwMBk4o/DGqukSorfhdMN+694HP3
 aX+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVckerNnUtbcV1Zf6tZ4cHO6W0hdmZzhFrJiXhatvc6ef4Zkcm9I7L3AgFxgfcdGWYf5fES1H3uPAo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykMeDi5gtqBnn8EX92UU/rw8k+3nmN9Qx5x0Fn9pBZYQSkRhlA
 SibTlcwMa3fBCd/PvKzucfVhJ37tiIwb+LH1q7y3P2oh8xLhxLyBB+PiXSw7Lzvksbz2XXilC8/
 ulRv0hQ==
X-Gm-Gg: ATEYQzyO+zMFVLgcYwqPo+MBn+7++5rQ3xR2tvvmERaaNEwBS04eqtnjxyNyz6Qr2HD
 CECldvDSgpQOWMr8jyeWsAAyRTAteXu2neZzu+rKpxv4dogxOCIFmL/MGdVX8WMrTO5WdUkTTg0
 SLuXea5mA7B9u7XP/CvtXpFkzqaFNozkY2DV7+4dXKc2kiy2eZ9nEs7ghzgjmWqzqx+5HV1t7/O
 /fWWQ68O4gzSg2W1sp7DFjPYXJ/uB8SanojnomRwscfaqhaeJBsWHbhzjBkJGE9yiaADl+dJqZ7
 DQ15u5U+7ISnonvcAfGms+sPjDEtv1YSyrwq44hmeXmaELqIZYRhs2K3jbRCP+fuHpnfFYOgQ/P
 YNEUH6+OaOsLcufwA5p1rqt+8MxX3v0R4bXLDVYFfaToskoMZgP8burHMbjDjwMlIU4zFdIZYS0
 xmnPsGbZwvrkueHaC884u/XdB4iTqpjMQ0hlQwBbzH7/MTUV0hdPjr8T/OpnA+hQ==
X-Received: by 2002:a17:907:26c5:b0:b96:e593:fd24 with SMTP id
 a640c23a62f3a-b97f48b9187mr241174366b.15.1773846219472; 
 Wed, 18 Mar 2026 08:03:39 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com.
 [209.85.221.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b97f142cf16sm236474866b.20.2026.03.18.08.03.37
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Mar 2026 08:03:37 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43b4d73463dso1374794f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:03:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCVssCj8CCZQKmWqI9myNP6h3QQbW1wEF6ijGfe7qLOfozxcQY/k8cz72HwNn5mMVlxfCnNJNfQqZb4=@lists.freedesktop.org
X-Received: by 2002:a05:600c:470f:b0:485:3baa:af14 with SMTP id
 5b1f17b1804b1-486f44410acmr62951055e9.18.1773846217096; Wed, 18 Mar 2026
 08:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260318042413.2891692-1-alvin1.chen@lcfc.corp-partner.google.com>
In-Reply-To: <20260318042413.2891692-1-alvin1.chen@lcfc.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 18 Mar 2026 08:03:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VYYHzpTzd12pdvykgtqMZCbxHnqsxNjQZvzHQZNuveEQ@mail.gmail.com>
X-Gm-Features: AaiRm53FHdHrmu7J4L0eNx6_6jWtYMOIqFYYs-B_weCQKmtR_nLCbkOTKwIZsFI
Message-ID: <CAD=FV=VYYHzpTzd12pdvykgtqMZCbxHnqsxNjQZvzHQZNuveEQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add 3 panels used by MT8189 Chromebooks
To: Alvin1 Chen <alvin1.chen@lcfc.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, jesszhan0024@gmail.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi,

On Tue, Mar 17, 2026 at 9:24=E2=80=AFPM Alvin1 Chen
<alvin1.chen@lcfc.corp-partner.google.com> wrote:
>
> Add a few generic edp panels used by mt8189 chromebooks.
>
> BOE: NV153WUM-N42
> CMN: N153JCA-ELK
> CSW: MNF307QS3-2

These days, we've made a habit of including the EDID in the commit
message for panels added here. This can help later if we end up in the
case where a vendor accidentally reuses an ID number, which has
happened in the past.  Please re-post and include this info.

Also, it's preferred to make the SUBJECT of the patch a little more
unique if possible. More descriptive (and still short) in this case
would be:

drm/panel-edp: Add BOE NV153WUM-N42, CMN NV153WUM-N42, CSW MNF307QS3-2

-Doug
