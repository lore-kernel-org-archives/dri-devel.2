Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464D606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c0+BQ7MB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D14C110EA0B;
	Mon, 16 Nov 2026 14:09:11 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B8410EA0B
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 14:09:05 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so6210733a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 06:09:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794838143; cv=none;
 d=google.com; s=arc-20260327;
 b=jNhcLB4Urx/PHaGSVoi1oQeUb4+oGEagSQVATOSbFhA0kRXxdALzcP0v5ZyNCXRuCY
 iR5tPy9wcJhSpNez8WnqYbzdZOt3UsVIQ3kI3Rkvuj4ybBP/ElPYG+zfgriK/qEE1646
 i3/9MAoOQkbfvGnCeXjRYst1dp7ODePxAkp7Ct9YLjuFpDQ2v7jdu8XGcL1WgGnbI9g4
 etN3g5jjVosymEioaOocphFTLcmMeAgQ8dlRCBGPFM4ClNukF00pTS4GxbkLPjYZ2oCj
 rx9kX7O+Sg0FF1Hx3a+OKh2Lf53LN7RsWqLc76kgJk9gyrRGyFvYk67QECJvvYxbNMUS
 WOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4hKevxP5Z/lSUazobwW68qRBBwY7gSBePYG2tqVcXNw=;
 fh=fPSMNTCGdZfsIsm5fa1cOLf2fkW1DHAR0FITBTI8U6w=;
 b=YcLz5iLgDbjoGC/DNKkGhrshxErEyhKX6S1iYTN2d91u6CYXf/99kYWzf2m1QtF9Q2
 aasorZLLlHZ7ybLCI/i2bY3Xh0+aIErbNVCBb6bddFu590oKLP3s2wcEdpRFVRN3pQam
 LnmuoP2BhOhF2Ogfgc93DtEWJjLRJPuwWLWna2dIwvvVRUhQ21wtG7JHUF7YRib/xx4J
 LC77QjgIQ12PQwGlz3vZ5TqK1bbxlm1YrAtHNkpj/egtjdwd2f3kV/eUoaqtWtdIeY3E
 r4qYCSkCpq3LANFsRxFbY428BEknGzy01Y0fmAu9IorGo3cFplW4xviLr3ElptqbeftL
 nBtA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794838143; x=1795442943; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4hKevxP5Z/lSUazobwW68qRBBwY7gSBePYG2tqVcXNw=;
 b=c0+BQ7MBQTMl6hrQRipyh6Cmx1GYcH/XEP/rtU475uBfh9luB2l1kfuEn1fKGYikVt
 xP0qM8qIF6wgKnQiOc2y+MDvZjw5TI4G8OayTCPbcZqo4dbOl0RhJftMYqc+PVZw9kQP
 7Q4MoJDs0W7D4m6vQ1f3I0SZFA3kkDHK8LDZXD0harEXz0e+YCo4AlPBlwItYzVHBBFE
 LE1PfbMCIhXDzu7USPe9T8PWFrqSF9/ZeYqq7dKvhkiot2+VaL2HrtrWWAqZrTjh+CZq
 agZtxQifHKu+k2fT2Gx3Ugqp5slCYgANrDOqVsbGwVIsRMlNMPp7Y1Sc4DqMAupo43kL
 sspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794838143; x=1795442943;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4hKevxP5Z/lSUazobwW68qRBBwY7gSBePYG2tqVcXNw=;
 b=1ybrDjdoKCF5cueIXABLEaiuuh7wuZdteHHkXRWq+69+72PjPLbtGzW2c49xhYLYkf
 kKltImQE8MnyEAz3Qujrq/yWaoiumvaNIeyW7JJ5FWVExsqcQLI57l3kUQAQTfreg8yf
 GcVrtumT2tfVUcbBomme7ncdTAcuiNI3X1Js0Q0FBHlPga8JiQW7gub2Z6RbUetH4mcO
 z/2pN/La/TltdOkN8S8rbBAbQjBWJIrzX2EekhURBnz8Vmc/niCMwdfMrnpC3ZtUJ5oe
 q3axPY87AhQuBMlLgLBvbsY1tgCBhkPW+v9HYzN7za2yC+7L5R+/g3ZoKm+xLi8d06tC
 8T0A==
X-Forwarded-Encrypted: i=1;
 AL+hErHAtKATZohEEc3A6y640wla+pCTlTdlx5It4ihXk1bx4Xgh7Go5OHU6spOQSwBmswFTxiA3P7/XPj8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+o1t3md32L3vjd4YAxMYzsaGADDrxFh959kfCACSb3EVRkQXtF
 znlSdefeJ+o+H8Aa/wDYIK6aARCQ7TZHi9zhEIbRk09zdXi4tU6WpApTuOuQVK+3yhoDkTavrr0
 cH9TGfgQ0H2nf+l7U7rmPdpUDR3eDutM=
X-Gm-Gg: AYBFou13haPuIDB1LPf3deF9rFwjofGGj0iYPbM3yR1vHin+ynaxzNhsGI/Z5u29qWi
 ITdx/K1h3J1oOLuQQ2P+2Tsqnw0ZyJg9gwrnpu6yTNk5SccTXZAfPZNVxamjMOzECkvVTc+Z8cG
 6bcmu6E3UXREfDURGkiFu3qEBxM6L9xHwpP8GKQBI8o27mxO2V5Az6Hnd9eFqDhwtpPV/y8qz/g
 tAHp1W485k1AWu2tZjGITEx8ub4RtJBYWI4v0WL8iUIs+xqYEACSFSQHm/go+2RifdZjy+P1Pae
 vvE1Rx6hv+47aczlGY4ZknMUCpkI7BDET0aus2UK6VrOLP0Px4I159j3kZXHSb5uchL96Z5Z4Fz
 ZS55+QXg9mXbW7jNKi9GjQMvsAI0J5JOoajI3yZzSzTlfwvHGtA==
X-Received: by 2002:a05:6402:c517:10b0:6b3:d0e9:2e87 with SMTP id
 4fb4d7f45d1cf-6b7c08b0a8cmr5365382a12.5.1794838143218; Mon, 16 Nov 2026
 06:09:03 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
 <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
 <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
 <17f2783e-9157-458b-8463-f98395e391ca@suse.de>
 <CAFGNeagxEcfPuEHFt3TxKhCDoZ0HODpXwXcKpuBxKK=09FkRMw@mail.gmail.com>
 <CAFGNeaiYntE7dQ=-sgaM8gRKuZ+wQ-479ShXKW8v99YVSdHn5w@mail.gmail.com>
 <CAMeQTsazkHgYiCnSEC67useW++0WEY8E0RS1ShssWybrWCGuiw@mail.gmail.com>
In-Reply-To: <CAMeQTsazkHgYiCnSEC67useW++0WEY8E0RS1ShssWybrWCGuiw@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Mon, 16 Nov 2026 11:08:51 -0300
X-Gm-Features: AclHuK8D8s812Gl24IAkZcrWISvAra_KalwIH0VrKm7xxpebhC_-rS2Q1DH73vg
Message-ID: <CAFGNeajczb-2Xcjfaj82hc-hprJXRHsr8uSudO32j6S17T+YQw@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Joseph Telaak <jttelaak04@gmail.com>, 
 dri-devel@lists.freedesktop.org, Joseph Telaak <joseph@telaak.dev>
Content-Type: multipart/alternative; boundary="000000000000f4b89106606551df"
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
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000f4b89106606551df
Content-Type: text/plain; charset="UTF-8"

Hi,

If I'm not mistaken, Joseph removed his kernel RFCs (This is in his GitHub
repo)
For Poulsbo I'll stick with the GMA500 drm, it makes much more sense;
Once I finish reverse-engineering the SGX544MP2, I plan to develop a
separate DRM driver for it.

Thanks for taking the time to look into my patches!

ty,
gabriel

--000000000000f4b89106606551df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi,=C2=A0<div dir=3D"auto"><br><div dir=3D"auto">If I&#39=
;m not mistaken, Joseph removed his kernel RFCs (This is in his GitHub repo=
)=C2=A0</div><div dir=3D"auto">For Poulsbo I&#39;ll stick with the GMA500 d=
rm, it makes much more sense;</div><div dir=3D"auto">Once I finish reverse-=
engineering the SGX544MP2, I plan to develop a separate DRM driver for it.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks for taking the ti=
me to look into my patches!</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">ty,</div><div dir=3D"auto">gabriel</div></div></div>

--000000000000f4b89106606551df--
