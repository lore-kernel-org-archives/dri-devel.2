Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2732C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 989C810F1FD;
	Thu, 16 Jul 2026 08:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PIkVPbwU";
	dkim-atps=neutral
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AA1310F003
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 11:22:12 +0000 (UTC)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-39ca300db70so32824041fa.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 04:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784114531; cv=none;
 d=google.com; s=arc-20260327;
 b=JnzjKcOr1zK75DYk5bYrGo6Shqdn2UUxFGwyoPYJzu1oF+qw9TcobKosxHrlK0STJN
 JnLCQKl/bDzp8mzYORIlGmwV/EgTQL2KfNTScS0LRjge39ux6k7XaFqhq8bsJp1lk9B0
 UM+ZuWMsB3dvIHCFMBG047Wis3Vm9PfCS/gVo6LleQmSB/NsAsKl/EN9Ks85GBvWYf8u
 nxEuAQQ+Ae6vYxnUs5oUKoEMhdu8+xCdzrjG7j2s3rGbTLdNPlgwy3WG6jcgNk3yTZcp
 s6cFrADUL0HUftvU6ttqW2KhXT2vhIlKOsZwk4Q4nkk1DcmJTO+DQ/YKhA0Js2mzGe3q
 SgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=HSNopsWSiECqSXyfNChsyxj+46JLgwEa7tAhtX18hkU=;
 fh=mLBTF2JUOEw/Gq8msof0OzDSz6GohWRGxaHsdmfIj5Q=;
 b=qlAxDmtUpmceC4/O8g6fRKQAYeOGe/WPN0VgJHdbR0+94ekz+USGfCyuPMO0OLdgLi
 4JDOCTbC01FqreD9kvJYyTCGAQ7fBtaEhmJuatfBTtDAdfkP2l/GDH6UFg6Q7TzcIywM
 fkiaoMvuh/HUSJOUjwOOzTQIGJ0ExfoYggB8MEIWrH5sRpBGjIYYOu8qLk2VIIEjR7w3
 6i5blONd3n4DOPyw/yv2rWwHqs0LLu2snU5xMk6pEOduKETc8l8KaqRwWe4MOaGJCP8V
 1MjNXW9T1+6uS7+wpowhoBWy/W5wvO+KaKooYy1cxpN+e5gh83ylagcheGNRiB5ay4RN
 TE4w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784114531; x=1784719331; darn=lists.freedesktop.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HSNopsWSiECqSXyfNChsyxj+46JLgwEa7tAhtX18hkU=;
 b=PIkVPbwUT3TTrHNR0E5F1474t7+S05DcPAS53OgtWvqQTfPeaxD03irJHAIWeUUJMn
 qIPrCB8YWQrPk+A3dHjKtYw21PEw/gRHw4tW+tHSMsXr7vkiQ6fLJnKviGpPoykYlPwN
 W6TSiiCCZW6zkQsG0wFjdTuDypRNv/HhV4xvNUyOSH1pmkaKQm5FbuHhVpmmxTQiUnn8
 QlLKfG1feDKHUrexczPYdGkSwX4kBmvZY3E4RHFm3ClWyTU5czev5hFrnakvKShpSWLJ
 s+806zhW/HztYFk9GjHetXcuC//5h/nJ7Uri3IxgA1jYXM+IrHjwr0hEGfj1nZNuKGRa
 1ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784114531; x=1784719331;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HSNopsWSiECqSXyfNChsyxj+46JLgwEa7tAhtX18hkU=;
 b=k9dsv/qkE9rywxoAX+8/2KPRaAgnGfoj/ulVFP/LpXZ5TVzvYwIQ3WlloOlMu29OS7
 XOgkWYCYqTSvtjaOjMpX/oMGwk/74hqgVgcxvLTJLy2SKQDPNf6cvT1/kqFvJeFe6+Dk
 i8rY25xq1OhWoxjnVHmRFzmKUkP7rxHcfHZepvgX6PzpoS5tmUGo6uYW/BGkFd46VmhY
 7N1iYIzrjkQH3/u0JYAizutsiHdXY0lOUkQURRqWYm32nB33tt+nxUhNTcV5vrVlI51q
 Kcww4tUcGLKD6zRrYI10qFojN6k6zfzQbNXlE66uVh3J4wjd9RwIfQH8OOD2z9sCJD7/
 utsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoHx7Inw/YUNhCjYN7+cRoYl4oB1jt+U1tu+bI1uSbcQ30iYJl75QGFazDJfr9VQGsg1fx4TSiOttI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzCkDgwIPlY+vhguXhaZg1S9IbefJjpQN/9VB7Jm1dCuAEhak1
 6dMmXElUHJF+DQ0y+ouO1sDLCuS4E9UfhyLITYzlxj0EgKVzZLWOhdxoyi6SfEFMRcwvkUuIwj2
 d+yXCQPgCQUqBNa7snbWEAqcByfCCI1E=
X-Gm-Gg: AfdE7clFI2DvVa+S5+dL1N/wEApuSdw3ouzi+gIvV82I2Mxv73yZofyekZmd3dQELPo
 WYysXsIkcvW0LligxGWg9XCwVndPaJ9Hs7Ysbqi9bH8zjTm74vzwCZRJ1vwivDIw+GsoLX4UFUM
 KO/PfNnun8BtxkiFg8UQaJ+JAXcxAHvUQy/j9UoFXx3URlLIXjWN3bI+LArp8zvzgHJFK8dl0ex
 n6SvTQGSv+jwFM2sxUWA+j1pshUU/tpzlkok3cX7HcTArDN3gifQ91mMh7XvZ7/RwOBH2lYgPEK
 7tK8xzH3fCNYML1haEaib/e0CNYlcw==
X-Received: by 2002:a2e:a888:0:b0:39a:f5f7:2e0d with SMTP id
 38308e7fff4ca-39db6bea8bamr5432401fa.16.1784114530281; Wed, 15 Jul 2026
 04:22:10 -0700 (PDT)
MIME-Version: 1.0
From: Luca Frondoni <luca.frondoni@gmail.com>
Date: Wed, 15 Jul 2026 12:21:57 +0100
X-Gm-Features: AUfX_mw57gkidR8r3u8MMOJEgnnVykbjo19TDoyNKmlKpdDzAtvhoflx0kawNys
Message-ID: <CANj_zjACKuDMqaazEMdpazcxVva5J5g4LzQD+D333CpqDK4kbw@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] drm: panel-orientation-quirks: Add various
 handheld quirks
To: airlied@gmail.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, philm@manjaro.org, simona@ffwll.ch, tzimmermann@suse.de
Content-Type: multipart/alternative; boundary="000000000000d0ec770656a48845"
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:19:15 +0000
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

--000000000000d0ec770656a48845
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I=E2=80=99d appreciate a review of the patch series referenced by <
20260216204547.293291-1-kml@antheas.dev>.

https://lore.kernel.org/all/20260216204547.293291-1-lkml@antheas.dev/

I'm part of multiple discord servers for these handhelds, and all of these
owners are interested in getting this merged.

Many thanks for your time.

Best regards,

Luca

--000000000000d0ec770656a48845
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi all,<br><br>I=E2=80=99d appreciate a review of the=
 patch series referenced by &lt;<a href=3D"mailto:20260216204547.293291-1-k=
ml@antheas.dev">20260216204547.293291-1-kml@antheas.dev</a>&gt;.<br><div><b=
r></div><div><a href=3D"https://lore.kernel.org/all/20260216204547.293291-1=
-lkml@antheas.dev/">https://lore.kernel.org/all/20260216204547.293291-1-lkm=
l@antheas.dev/</a></div><div><br></div><div>I&#39;m part of multiple discor=
d servers for these handhelds, and all of these owners are interested in ge=
tting this merged.</div><br>Many thanks for your time.<br><br>Best regards,=
<br><br></div>Luca</div>

--000000000000d0ec770656a48845--
