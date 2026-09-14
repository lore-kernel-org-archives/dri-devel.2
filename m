Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6463C88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2371D10E358;
	Mon, 14 Sep 2026 15:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UyQ6NDeu";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC4110E194
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 15:13:36 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-5b8997bc6e6so2179492e87.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789398815; x=1790003615;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fFA7B1Zzm+M6TOI4RFrwiV6L7EFm/dOdjC0+vMkdzrE=;
 b=UyQ6NDeuuxtcbEmP1JGWjaE2BZqSQsBTNGt6nogaleSvy3xeTJosBIE/+g5VLg/yQF
 reAEmA0Uc5BDlHvmKpvkGbFdypn7nZNJr2EN/NHdcfbGMkQNue1B+XRRsXeH+6lAHoa0
 sRLZKStDRIvs7gxYcK0YuAAoW7hmA+ZAHkZ1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789398815; x=1790003615;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fFA7B1Zzm+M6TOI4RFrwiV6L7EFm/dOdjC0+vMkdzrE=;
 b=cVBkpy/kNDNyXIIYml7sQ3GByW1UfhB1CDhMg+ck68egq6LWd5JBDKcHWR7D2aT5QZ
 7QIEiJw1dG0iZK6QkDSvBnFo2i/JGz7bUFWRsSK2JtrwXbjSvmKkgRxw3GBAOMQrkr7S
 cV4DEpqs9eGQ9OdtTgKG1XCzD2CO6CcGOqZP/TTmgiwzu0VuE0F0Dqo+MT7HlbKbpdBk
 8jTCPMh6TC4tRnVamtMxzYXdM6Bylq3ApKOLJS2tT30dBDFdT32rJpro5uKK1nOk5VPw
 w6JQCO6rX+z6Rurt6NJQbH2H8cbSh1thXHtFDT7GFqMDoHWhbN1JjqTJ70FbB7plsl6l
 xYBQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTOwPo7TXqCvwMW2K9BfBQnA8zeKbhFusgSpD4lLbe1CDGrLOG0XVELMOS+JrwZBacbys7rUqb6r4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+y8wCj9Jyk9iwLmtN1aMxyBSmKassl5Fh+UJ+XFbIk2+ZMQuM
 vx71VJsF44X74MXccrktmKVUZxiAqkGxd8LQ64W/zPdupc8EmyV9WFRiYuWq0SBNeV7pbU0F6Y9
 E0zWXog==
X-Gm-Gg: AYBFou2efMBmwzdwhrKt5jY+xJojfnkdngERd3P/hVYvKWMliZQRYmsTvrYh2vnaqcM
 hcedKdbCL83/vOkJhKKFV55xyfK6RTDqilo5WyxeX0QqdXZaGAf+rkGZAdUVtAa7tYSS61Cpbqd
 VrhgQTaaYp+gtrQ6WkmDLrrvn+N2XcrjfeAz/cpghbIwal2N5rcOVrSdr3oeK1NduQ4NiJTuRYZ
 3Kc+9DwTVwWMqw4FpdPoAQsbzXSCBZxr/QAPvqboFcT3uYVLcUwVdOZI+8ZOnqwQ/SIljM4lSj8
 MxX3jFS9wMH3IVwU4eyxlcpjTUQmf3OjjfZU/u4Otxelpy42J6ZXRA1W1c8kcRTqGq1MrHc3K5A
 q0ksUM0wUBTn1EBBYzyLD2VOUPdlh5RveQQAF5oVLQY6ju6NreeHSwm4pj3lu1mZyoYFtzWS2I0
 Yvcf9UZ1Nh0jNYfY1vKnylJP3Ip4c2e2wVBlwif90EZN5gwsdro7Eu26/UUrMmUISkN9fAZ9htj
 lFfdpfXMMS4byZao2h+gQkSBLKN9HSBytQlQg==
X-Received: by 2002:a05:6512:3c94:b0:5ae:b5d7:4b99 with SMTP id
 2adb3069b0e04-5b8abaa6679mr1395238e87.0.1789398814460; 
 Mon, 14 Sep 2026 08:13:34 -0700 (PDT)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com.
 [74.125.225.76]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8a03a88a5sm2506485e87.8.2026.09.14.08.13.32
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 08:13:34 -0700 (PDT)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48449f62b93so661381f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 08:13:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwPA7kIs7D5rCGjKN7ipqMBRTbjtuc/fjkWLwflJ0H9KjfNoTmOQqp9alKELGUtmawSjIHrXsFx+0U=@lists.freedesktop.org
X-Received: by 2002:a05:6000:1acb:b0:484:3147:49c9 with SMTP id
 ffacd0b85a97d-487028be8c5mr4006418f8f.2.1789398811422; Mon, 14 Sep 2026
 08:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260913201835.250085-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260913201835.250085-3-srinivas.kandagatla@oss.qualcomm.com>
 <biywo5isdeagqu323ozaleeakngl4sngps4v7ngwqo23ju2sw7@jn53hxxuccff>
In-Reply-To: <biywo5isdeagqu323ozaleeakngl4sngps4v7ngwqo23ju2sw7@jn53hxxuccff>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Sep 2026 08:13:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X-Te1fieogNaMuyFAa2q33RKUCVXAUFcce_r7csXAwVg@mail.gmail.com>
X-Gm-Features: AcwNN1XNTZvJpFGb6MbsUkQxxgT0-VHyrG0ryskn4Oe6UeBRJylCSlvDiAONe_A
Message-ID: <CAD=FV=X-Te1fieogNaMuyFAa2q33RKUCVXAUFcce_r7csXAwVg@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/panel-edp: add CSOT MNE007QB1-1 entry
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 mpearson-lenovo@squebb.ca, sibi.sankar@oss.qualcomm.com
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

On Mon, Sep 14, 2026 at 12:34=E2=80=AFAM Abel Vesa <abel.vesa@oss.qualcomm.=
com> wrote:
>
> On 26-09-13 21:18:33, Srinivas Kandagatla wrote:
> > 14" 1920x1200 IPS panel used on Lenovo ThinkPad T14s Gen 7 (Mahua).
> > Panel identifies as CSW 0x1465 over eDP AUX; uses conservative
> > delay_200_500_e50 preset in line with sibling MNE007QB/QS panels.
> >
> > Assisted-by: Claude:claude-opus-4-7
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.co=
m>
>
> I think Doug starting asking for EDID dump in the commit message.

Yup, please send a v2 with the EDID in the commit message. See all
recent commits to this file for examples.

It also looks like you are adding the panel without having access to
the datasheet. That's an OK thing to do if you truly can't get access
to it, but I'll at least ask if you could get the datasheet to confirm
the timings...

-Doug
