Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD082E9D800
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 14:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8395B10E13C;
	Sun,  5 Apr 2026 14:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bbCuJ3yd";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4391510E1D1
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 12:36:57 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-43ba1f3fa7eso3358779f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Apr 2026 05:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775392615; x=1775997415; darn=lists.freedesktop.org;
 h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=43AI/uEwV09xDA495oWjYagS+R6tdTi+zC5+6mZ4pUE=;
 b=bbCuJ3ydgqMrz3Ebhuf9fY6n+Mtvhu8Sxh0n9S8rxPO/hFKvHegWExtOKY5mqQRHd5
 2zSNCGUScUbyV/m0zNb+nAyOXUrPVL2pagz2jbi564CeO1HDtf8aEjNwjOzKo0MCLb2c
 dsgWWq5H6foAqZ/dVDKFDhbgNLd91Qe+2qtulKZimD/9BpduZTwFWJGLcnpfNquhmOuI
 j4Y01mJeVoVpzzEr2nRfQISdAfW+9dMti8AbNKwe1uHkIsu8yvl1f07hr7Xt/w35gIXi
 TO+6CCqA7El1TuBbzcLIWr1ZfMZUnHz0bQVmfcj/MmgQ3qX4APDKw6TFHtihYske0Mi8
 Ll8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775392615; x=1775997415;
 h=mime-version:subject:references:in-reply-to:message-id:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=43AI/uEwV09xDA495oWjYagS+R6tdTi+zC5+6mZ4pUE=;
 b=GCD3lj6ijMbEYNKb6gPMpJEogNBtTey8r5xbiCWsk3zO8S4G16XVBFM8IP2yr2+3Wa
 xzkwaDUTvbGRnrGvCf7Kbc7Ym+9e6yue7lxR94wyNX+HjarvfKbLHlMGKuVOE3TBR9uN
 HQkT9huxpF1H9jF8rYDdUeYQ1kPU146jPEkBKyrBZOCilLxsYicXpnUL/3EX3G5DmBPG
 Wyb49qOMBa+tb5Xz+HHyRQzQz6RdoEeK/qbLkIfMybS6eOMwsodwPB//cn1MWqCJP3to
 nyzzqgvx6rvy3LYN3hbwIU9Yj+VJ+bZuBskY89BmGqHttNOo8SEi6LKgYnD1+U9F3LzP
 1P/Q==
X-Gm-Message-State: AOJu0YzqxCvVeKxrpWWT0PkdpvpD27p4qqRTt0TZyBuu7O4yo6pTA/kT
 I/D3nu/HSPFYH1OWAFafGbRavA98U/YtptBQV2E+Nb6k044DDhAsksxtPexn3g==
X-Gm-Gg: AeBDieuV9EBK4dqZv1ljtakiaCkvVWkLS68I6/kSt5s0OyDMxZKQ3GgIx/Vm+S1lA/W
 17G7Xea0hDkxk5QtHzdXxgHU7m4ZDCffsn6NNtiVuyjMJR3pu4RL43C1Z5jDsbTtGfoGNLlWxa6
 YzwSr7MhfPRolRzyRyHq31m13smEB2T10mB44xDNMG2P76fiSpB8s7DiaOLUEOItE7wU4YHdp4M
 bbbJiO45VoJiTjxuJaIUCt6mdGvbzVysBf3HkwrbRSUet9MBxy4F/UKDdTPFA253+ITqqZhTDGc
 Nfk3aA5RcdTy7jKjhDEq12GhRHcwX0qqUTqnXFuYul87cu4UTYbX1EjmWl8xbu2s88c7RX3mK28
 UvQLgE0WDoQct6xvAEDhmPreOKdNlVZT2R4HT+ZAB7GwCM/TETIWaQUlJsLIt+uui4Ci4DIxRLM
 dHZtzJzMXxLDkEfE8+oV/k+LrhGsjYd4z7IBf4YM8q9mDbRuLoylZ2WS+dCAZC9Q==
X-Received: by 2002:a05:6000:4305:b0:43c:f925:8fc0 with SMTP id
 ffacd0b85a97d-43d29304ef8mr15846765f8f.50.1775392614808; 
 Sun, 05 Apr 2026 05:36:54 -0700 (PDT)
Received: from [10.0.1.4] (host-176-37-45-227.b025.la.net.ua. [176.37.45.227])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2a720dsm32259353f8f.4.2026.04.05.05.36.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 05 Apr 2026 05:36:54 -0700 (PDT)
Date: Sun, 5 Apr 2026 15:36:47 +0300
From: max graey <maxgraey@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <e507997d-e019-44a5-adc8-069b9e1413d8@Spark>
In-Reply-To: <814c998c-e63e-4a33-b152-4f3b8ed6dae2@Spark>
References: <814c998c-e63e-4a33-b152-4f3b8ed6dae2@Spark>
Subject: [RFC] drm/panic: reconsider manual div_by_10 implementation in
 drm_panic_qr.rs
X-Readdle-Message-ID: e507997d-e019-44a5-adc8-069b9e1413d8@Spark
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="69d25764_216231b_525"
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

--69d25764_216231b_525
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

--69d25764_216231b_525
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
<br />
Reference:<br />
<a href=3D=22https://github.com/MatthewCroughan/linux/commit/33429daec773=
809c01be492b46a6210ab1473851=22 target=3D=22=5Fblank=22>https://github.co=
m/MatthewCroughan/linux/commit/33429daec773809c01be492b46a6210ab1473851</=
a><br />
<br />
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
<br />
Godbolt proof:<br />
<a href=3D=22https://godbolt.org/z/fonv1MEhT=22 target=3D=22=5Fblank=22>h=
ttps://godbolt.org/z/fonv1MEhT</a><br />
<br />
<br />
Given this, I was wondering whether it makes sense to remove the&=23160;<=
br />
platform-specific&=23160;&=23160;manual division path, and rely on the co=
mpiler for&=23160;<br />
optimal code generation.<br />
<br />
<br />
Thanks=21</div>
</div>
</body>
</html>

--69d25764_216231b_525--

