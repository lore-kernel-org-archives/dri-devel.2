Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A0BE9D804
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:51:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584CA10E0D1;
	Sun,  5 Apr 2026 14:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ayxtk835";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58F5110E0E2
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 12:47:18 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so1045535e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775393237; x=1775998037; darn=lists.freedesktop.org;
 h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=rWXvruxydWCE165D1X/rsTWP12iJIYJjDPOd90sWaLk=;
 b=Ayxtk835VBmIvjLgkmk48qZf3zO/AnTwesz9GXsDjTmmS8spYmfUYmEKNGq8rLlBbj
 eMpQpi9nNr9iXGtpJYyFo1G6+PWrGaOIBDEo4mHhfUD9MauxqexbPVyT/vPLxUxfTmy1
 /+ClGpOvqTc76DuEANFOSfFs5Dw1qshNMThczwSPvKA74xUnToAl33O4mZozPkMF0y20
 7zS1FZYdu9ZPZybZyjDPhnh4nson7tMvYqZU6Lzjcnzf1qvF3PQlHHCXHKbt6qX69HZm
 bPy4XvsUs+eaFxZYC+o1l9YQby/haK4fJZAOgarLsRf20AuHvnXUeDx42vbLflUdppOl
 JeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775393237; x=1775998037;
 h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rWXvruxydWCE165D1X/rsTWP12iJIYJjDPOd90sWaLk=;
 b=HFUITAr/jBwup/L0UU3qgaTexjiSRX/iGA+PTsVioGcDjeDLe3cqy/brBiava/fLxM
 8fHeDK2hdQY8FtFgSG/IirSgElCI4az7eWFsg2yrEaX5xdZwFtbRMRJbHqc6Iu97aHZv
 iyj76AwytYaPlHufr/z1UqKDWErkGVd4MVhRHKSQNSph3nkx8uwZK8kej5tlkhE1n+Vz
 lvNigtLcgf3zj15gi6ynDTJ88t12xZc59Vmd2g0TAQQZzL3DDm72yXXTcTVbxQuSND4n
 2A9uGRt178Q5kbswTnL4HtJbJeOiLoaHK6JWf93NrVHUv3QctystzVcwfmVTvK+vJExi
 i4ow==
X-Gm-Message-State: AOJu0YyKfKzE9hPMLi0fzssbpFZbk/tf29p1TNWrPcYdhftFjxejd+wG
 LgpAiaC6eCdtqDi9GbC+bTTzqUwnlXPdyCPXrCdhVJ14AX2z2rddr2gYQ6qEsg==
X-Gm-Gg: AeBDieuj3JjPU/sa2bfinoEKIUeq5mlUwK62FR3hWKpDukGgT29BUZJCzE41P8ZWZUo
 ccEgmowPxSEHsPhkbB1jjY/omockUTZt/xZw+6EX8v+XR0N2XAIcNh/kL3hTb2veZJPI55PB2Ly
 K/KH6KLfPuDVkdLG487IGt8fjVEvNGQVNqhrcwIfAUhPdcs+CTRcrHQFUreBanX8EH/yqlMq246
 IyymWMKHXRJX6L3hVW/sl77HbPXjjoUhhV+9RsoJ1VbMHmq+MTDrUIPh7y0LCJZ07S0XbPqNrn8
 37btf5U1XbTvwWpyFmJClstx1p4BJZkaB0tM34TFodyCjXOTyZcRsmH7/UvqCSpQeGPXIclnkNB
 CSmvitUpBgoCFiMrNMnVkzGASw/NJH/OOcuKFwU0RQDgjT26+OxNrLBU8X81djciG3R8x0qvKEB
 ftoRvWN0usi/5RaCgCs2XyPw7Y2EwWCsU9um7Rt02QyN32HNLp469aFLW4XwkghA==
X-Received: by 2002:a05:600c:3b1e:b0:485:3f1c:d8a1 with SMTP id
 5b1f17b1804b1-488996e728cmr133535015e9.9.1775393236428; 
 Sun, 05 Apr 2026 05:47:16 -0700 (PDT)
Received: from [10.0.1.4] (host-176-37-45-227.b025.la.net.ua. [176.37.45.227])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488a8d6e27csm120540955e9.6.2026.04.05.05.47.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 05 Apr 2026 05:47:16 -0700 (PDT)
Date: Sun, 5 Apr 2026 15:47:10 +0300
From: max graey <maxgraey@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <a00d30f2-7a25-4109-bede-b5b1cbb71f38@Spark>
In-Reply-To: <69c9da12-4895-414e-85e7-5d7c4e7bab7c@Spark>
References: <69c9da12-4895-414e-85e7-5d7c4e7bab7c@Spark>
Subject: [RFC] drm/panic: reconsider manual div10 for 32-bit ARM
 implementation in drm_panic_qr.rs
X-Readdle-Message-ID: a00d30f2-7a25-4109-bede-b5b1cbb71f38@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="69d259d3_41a7c4c9_525"
X-Mailman-Approved-At: Sun, 05 Apr 2026 14:51:35 +0000
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

--69d259d3_41a7c4c9_525
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

while looking at drivers/gpu/drm/drm=5Fpanic=5Fqr.rs, I noticed that
div10() uses special manual implementation for 32-bit ARM.
As far as I understand, this was introduced due to older LLVM behavior,
where 64-bit division on 32-bit targets could lower into a call to
=5F=5Faeabi=5Fuldivmod, which in this context could lead to a panic.

Reference:
https://github.com/MatthewCroughan/linux/commit/33429daec773809c01be492b4=
6a6210ab1473851

However, starting from rustc 1.70.0 (and corresponding LLVM versions),
this no longer seems to be an issue. The compiler now lowers constant
division by 10 into a multiplication + shift sequence, avoiding runtime
helper calls.
Additionally, the generated code appears to be at least as efficient,
if not better, than the current manual implementation.

Godbolt proof:
https://godbolt.org/z/fonv1MEhT

Given this, I was wondering whether it makes sense to remove the
platform-specific=C2=A0=C2=A0manual division path, and rely on the compil=
er for
optimal code generation.

Thanks=21



--69d259d3_41a7c4c9_525
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<html xmlns=3D=22http://www.w3.org/1999/xhtml=22>
<head>
<title></title>
</head>
<body>
<div name=3D=22messageBodySection=22>
<div dir=3D=22auto=22>Hi,<br />
<br />
while looking at drivers/gpu/drm/drm=5Fpanic=5Fqr.rs, I noticed that<br /=
>
div10() uses special manual implementation for 32-bit ARM.<br />
As far as I understand, this was introduced due to older LLVM behavior,<b=
r />
where 64-bit division on 32-bit targets could lower into a call to<br />
=5F=5Faeabi=5Fuldivmod, which in this context could lead to a panic.<br /=
>
<br />
Reference:<br />
https://github.com/MatthewCroughan/linux/commit/33429daec773809c01be492b4=
6a6210ab1473851<br />
<br />
However, starting from rustc 1.70.0 (and corresponding LLVM versions),<br=
 />
this no longer seems to be an issue. The compiler now lowers constant<br =
/>
division by 10 into a multiplication + shift sequence, avoiding runtime<b=
r />
helper calls.<br />
Additionally, the generated code appears to be at least as efficient,<br =
/>
if not better, than the current manual implementation.<br />
<br />
Godbolt proof:<br />
https://godbolt.org/z/fonv1MEhT<br />
<br />
Given this, I was wondering whether it makes sense to remove the<br />
platform-specific&=23160;&=23160;manual division path, and rely on the co=
mpiler for<br />
optimal code generation.<br />
<br />
Thanks=21</div>
</div>
<div name=3D=22messageSignatureSection=22><br />
<div class=3D=22match=46ont=22><br /></div>
</div>
</body>
</html>

--69d259d3_41a7c4c9_525--

