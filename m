Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C72C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 17:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE78B10E1AA;
	Tue, 30 Jun 2026 17:33:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WvE0LTO6";
	dkim-atps=neutral
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com
 [209.85.219.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D6F410E1AA
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 17:33:21 +0000 (UTC)
Received: by mail-qv1-f51.google.com with SMTP id
 6a1803df08f44-8ea70ca4fc8so9054876d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782840800; x=1783445600;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9uxT2mym3C/aUlpV8JSB66+QaKxZ1e17pgmQR3Lj58=;
 b=WvE0LTO6hcDiSb2tzjtyRoP5vmmXCgT1soH7DyyEhJxgtRPKVCUdmoeat1T+0KH5hA
 DV9IQ1ON40rvb5+jpqsywz5ICS/1MrAkLrOfe0x9TtCtDmIXR2ilyWvxpJVAlx85ajsV
 eMAhpVbQ0qn+x+pchkLaoUezW5NT75CizH/tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782840800; x=1783445600;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q9uxT2mym3C/aUlpV8JSB66+QaKxZ1e17pgmQR3Lj58=;
 b=UU3jxGbSXQ2rvrZChFzQb1snZ8xtIXXWqTQJ2bYFenlbyvwBusN8yZsyVx26Xu1WMX
 nB94op7bWPCX9QAWM1j+/QK0155Xced3693e3Crgl5JR1ELYRQatJLvZ3xMJHng+Yglx
 t4nZ4tcMBcqo733xufbVH3w3Bf8ON1al405h1lLGRhab+l6eODPjLkMybd+rUVeSv1q2
 v5p/S3SJPtJ1kI1qYMy9rYV+m6s+7ZaO1APUIFUsqLHMA0AXrXGXfrh/Baxbwn1T0NmI
 Gql3J4HoZwV9WVwEAIrcr9QVIRRMvIHuNI91zgewD9FfQnR6OGObG/kd3oMGYZgB+d0E
 lXHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpvzmumUFHt+EKr53OHewIhQqJPqfuQtbR0PXljLPE8RLAQPRU36lDszZmyfz0uaod6N1+4JZZGZ+A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyb7HkyTqGtVwExaEGBy9WFzwevdfUm7Gpum0faX/xVF2VQxXCE
 x0hNOmxXf9sDnrNNIcdOMJNqwcbyjpZ903FhOSrMB5JBg16Ipx9v2b3CgGvhqr4bdXMSz2j4lAn
 r6kg=
X-Gm-Gg: AfdE7clt3rK2RcIMGLq7Y30QM/JhzTebgQPvt5ZctlHgBgjhk3RUqEyPmOeqAPvZDAD
 vOYW4YPcYYLy9YjtHcqvfRp8jSCShVPW7R6ZwHAMiEaUPYOBgpsoYJS6U5mjA5Zc8dXzXW1UuJC
 DMiv1ClbqHAKUfZpxG0JTKyWlLa9+f/ncmlk3ANV83hkkmQBFvDNlVghQdr3+4w7vtJHXTbviE0
 o7QMqnhmZVf01C7AAS1KHYSP309aOsn0WrGn0+WLzH9oJPHYYfOlpGV28MqMCofsppSNZNjX/m2
 Atg5MnfXGOVntPoXSbL49b4BIEmSZW1z/WIe2qiqBDEuVL/HFrw7vK/w2A1LEz91VxO2ahvDGmU
 /HvU0JiOQDR+qv6jrxQK2Mkplp7Qq2IKNNepYkB8mKNmCBDYahg38H832ep6m3wR5K0tmnXXwwN
 hvK3rW7II7ZPm/ssg4qaewPkP4/ttv6rnHwtEMecdoxTo4qch2V84=
X-Received: by 2002:a05:6214:478e:b0:8ef:1840:2bd8 with SMTP id
 6a1803df08f44-8f2551a4c92mr34957466d6.33.1782840799937; 
 Tue, 30 Jun 2026 10:33:19 -0700 (PDT)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com.
 [209.85.219.49]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f1a69c32cdsm29911676d6.31.2026.06.30.10.33.18
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 10:33:18 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-8ea70ca4fc8so9054446d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 10:33:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrOKLAde7nqPZTSZo9BPoQtkdJNtYkteI5+tT+JbWVcbDdqxZrUByEeAnVTIbzh3AY5jqJ6JCsTXpY=@lists.freedesktop.org
X-Received: by 2002:a0c:e086:0:b0:8ef:dde7:bd69 with SMTP id
 6a1803df08f44-8f2549e5647mr33545926d6.29.1782840797321; Tue, 30 Jun 2026
 10:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260629030930.379879-1-zhouhaikun5@huaqin.corp-partner.google.com>
In-Reply-To: <20260629030930.379879-1-zhouhaikun5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 30 Jun 2026 10:33:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XoDLOwva_tnUWujgGHCJbe1h6YqX7hO6vdD4f9dbc8UQ@mail.gmail.com>
X-Gm-Features: AVVi8Cfi8w9bBWAsEkfJv1qoQupsdMok5So-7ymv0qMj1Qkq5lpmc_rp--H9FPA
Message-ID: <CAD=FV=XoDLOwva_tnUWujgGHCJbe1h6YqX7hO6vdD4f9dbc8UQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Change the KD116N2930A15 panel enable delay
To: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
Cc: neil.armstrong@linaro.org, sam@ravnborg.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 daniel@ffwll.ch, airlied@gmail.com
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

On Sun, Jun 28, 2026 at 8:09=E2=80=AFPM Haikun Zhou
<zhouhaikun5@huaqin.corp-partner.google.com> wrote:
>
> Due to panel characteristics, when the panel wakes up from the S3, the
> main link data is not yet ready when the backlight turns on, causing
> a garbage appearance on the screen. Delaying the backlight by 1000ms
> can avoid this issue.
>
> Signed-off-by: Haikun Zhou <zhouhaikun5@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

This really doesn't feel right; it seems like a hack papering over a
problem whose root cause hasn't been found. If nothing else, what does
"S3" have to do with anything? The panel isn't left powered on during
S3, right? So, as far as the panel is concerned, S3 should be the same
as S5. Why would you see this noise only coming out of S3?

-Doug
