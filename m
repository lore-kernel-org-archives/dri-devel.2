Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B998D606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 22:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pGdOUjay
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E08B010F8BB;
	Tue, 24 Nov 2026 22:57:31 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 962EB10F8C1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 22:57:25 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c51373ae637so767462566b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:57:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795561044; cv=none;
 d=google.com; s=arc-20260327;
 b=kHJ344x49qE24e7yQ572TgxFPeAWLK79pU3HnkY9ScTytAVT/RX8F43aNOX58DPTJV
 Hn32V3NTzQL1RjD7Vi8LMRsmDuLFjHQh1zTryMLaaOcV/hXhzlTMqfBWCMX36KP88uU5
 3TDQeTYURuc+TPcId/qrNHqN2lich1Jbkltm6QzZxiMJjfiHUUsbwjFrxDqeQRHXkQXZ
 ufF61l5ioYUv8P/5XOqMw4jgmza1uZ8EMdMpcEnUbEHhgx+UuNVMUyZD5MfE8equG3iM
 js6/3nbO4Gqe5bKw68Uj0Nb1OiVHoAC+tICuvAXI5Um6u89Vt/tvfbe62sUiG7hulEmC
 W5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6iY4YBusSDVcpM/NVEma9F7SFsS0LbQX521gj+wag/0=;
 fh=tXULi6OR9uL75a6zGRwGC9MVF7N9EqNlg5d5spfBD2M=;
 b=XOR9zVPXgI4gsqIo6lLlkTfy3IIKamruCPtojxdoX8kU538XM6JOsrzjs2nKWV+EJq
 BpgiZDKf9m8lmYBet3q+LiRf+2ixW4odqSHqQ/y/Bh5pZQKM2OwEKcCJ1eri5j9BN0Py
 suycV6SYlJ1faZpmf4T5ao0jwlhmKtNEYBW/uV9L0v+25gq4LW+ZnUf1wvXJVx2x3yC+
 Q4OlqGLRcR/7+wglMuuU2Aylo9mU34ATvr7rQfiKt3JXU4G0zAUtfPALQY7pEs40kYdl
 nl8RklK7F6rhZ7003XpBZPN85PkSd/IeiqptONJYAVT3lMsPhYHGZmWmLrQZF47oI9ci
 x+MA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795561044; x=1796165844; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6iY4YBusSDVcpM/NVEma9F7SFsS0LbQX521gj+wag/0=;
 b=pGdOUjayyIG8mvYnsuCSoDZ3IIm1mqNKvQWyCae2mKUHDKvSp4dw7/ssRcTRDP+7YJ
 vehSy84wmGazeEYpvHZoYEfaH0iV0lYkSk5WeVvTMq2iZPCT10QDhrKh+2AMxJciSfXz
 oejCxffcHZyoavtacagFHRnE2yNa+30q/IKjCj9Udgt8Gr55nx3ZZ4MBVi45m+muXG5t
 1875QRk6y5mCmw9mtxNP3wVaPVCQhSg/ErHwXASn+Y7WBonCgExLGi6zWLjychWa4ust
 n16UkBrpL+EVawmoqCSWiyW83OmWI1CkQ+agRpQsYbwLwoY7xBVH6JVczWkF49AObfBp
 AhEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795561044; x=1796165844;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6iY4YBusSDVcpM/NVEma9F7SFsS0LbQX521gj+wag/0=;
 b=Y8KWDtI4gI91ifooiCeuNy0xwp6fYSYLGiOXvjqplQdoIGCAAhIBYASC5hQyvoBUO8
 oj+4qmKvML2fAu6um8ApzxuXvwcgTPMtWzH3hvj0rXdzXvDvmgd7PV9JGdn4Ui0f/Bpm
 05pgMSUpBOIoFzhs474u8vnmktCMTMnToz7cr3/qWTUY3tj6bPH3VPek09IWxjt/kWx6
 RNU8Pkdc9A9Eo8LuoNAyNMmxITtBqCQUjIAM9B810uGy4t2CFgMOS/bKZHcNmjI3e8Qc
 UCWYPlOFUTvU2dysMO96b62YxKHuWW2Vsn2a4EkLM51MCEm/j/6QBBvDjjIXMEcYCoyS
 ZgDg==
X-Forwarded-Encrypted: i=1;
 AL+hErFL+X0mcN/ETMyOlzmaIRb2NXeZTUBNSwNQ0VUJlxhk7lBwI4c/P9rj/D4BdX0Dv8Gl7uuzfQGdOTQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9gkeXyGWAPYARE2IhcrhZqthKv7x73cl3OBw41qchGbG2OM9ip
 gSJDWCKO1KpPLlmu+Y4sxd4GX0VMSLdvMSANyUPu9blywNuTFY6Izt3ikZyGe8o71eSPaz1gE2Y
 mIN2QcGH5t30sCqRlz1nIksDcAv3MxxU=
X-Gm-Gg: AZFdTZewGYLiUUy3bDVPl4s2nqZ1E6/9ZGa2M/OUEdHEE8uMBBOHlVpAWkup5e9lKlp
 04hG/Z9gsaE3SVF+woKi4PYJdl7HTxPzlZ1qAN15ZKcK8GYVh+rctXPUMZw0bqzdScdTTmcZO64
 Eur23HzGZxDZUDh/RitTcil5E3z4MnG/33Ei6C2QxgmdmsjrM2jiljIYzvpwCPTcmYTN4kAQ4NM
 Hoj9huZ505GqBUa8i6ey16fhJY0OajGHr3a5rZvHsSVcN/uoAW9ba4Mjl6nMYsZ7uDxn9xKVDd1
 k8oQzlH/hWZP/eQ2TswcOHX78vBtECZwbFLZGN7NyvXksEG4Wch2mWxBNrOmKRjcQqWKa9abxzU
 5MNFYxRFpyWJSFI+ss5LZaCJUI6ck/6WQ3W6vmNifWTAcIotykQdjW8ly0yVIaAj9NTc=
X-Received: by 2002:a05:6402:4004:b0:6b5:8719:6d51 with SMTP id
 4fb4d7f45d1cf-6ba37e6f76amr12792685a12.32.1795561043818; Tue, 24 Nov 2026
 14:57:23 -0800 (PST)
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
 <CAFGNeajczb-2Xcjfaj82hc-hprJXRHsr8uSudO32j6S17T+YQw@mail.gmail.com>
 <CAMeQTsb-Tjzu6i8Fa4X6Ta-JdRPd6vf--eEePTzZKvPuPX5GGg@mail.gmail.com>
 <CAPY4CJ5=+fXRX=29uS_oxwVQxstAf4WoFNVSYaUiYmWEjar5Kw@mail.gmail.com>
 <CAMeQTsab5H7F5CFvd_XkDndmMiBXRSYBhrMHAf9jynzEqaWp+w@mail.gmail.com>
 <CAPY4CJ4Pq0gXUdGiEp-6srpVUBxYUXPQgOAJr1PJK3SeVn_Rew@mail.gmail.com>
 <CAFGNeahyKxLV1fMp_diNAvXN2JrdRVPt7NRJ5SDuLrfGQ1V3Nw@mail.gmail.com>
 <CAFGNeahDm=GM8J=C0hmVBN5HS0thoMJZNVW4srW6WoAFHaxNdQ@mail.gmail.com>
 <CAFGNeajVapHL-mQUr1=BR-O5cMng_f-YJ6=7g4+_sedUbpXiJg@mail.gmail.com>
In-Reply-To: <CAFGNeajVapHL-mQUr1=BR-O5cMng_f-YJ6=7g4+_sedUbpXiJg@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Tue, 24 Nov 2026 19:57:11 -0300
X-Gm-Features: Aa3M54oCXX06PXRKWxVM0vFZvXH4mjr4ZfKpSyTd0jevi3K_SBerbB7Gh9XTz2k
Message-ID: <CAFGNeagt99cZXXg6i8pi293wN4aD5e33hqrKeLmWmU48BtYqHg@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Joseph Telaak <joseph@telaak.dev>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000307b0d06610da27e"
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

--000000000000307b0d06610da27e
Content-Type: text/plain; charset="UTF-8"

Hello!

Some good news from my side: I finally managed to get Wayland and XWayland
running on the GMA500, including dual-monitor support!

It was quite difficult, but reusing the existing DRM/KMS infrastructure
helped a lot. Both hardware-accelerated 2D and 3D are working in tests, and
I'm still working on their full integration with Wayland

Something that surprised me is that Wayland with CPU rendering feels much
faster than Xorg with CPU rendering on my Mini 12.

It was difficult (very difficult), but definitely worth it! Surprisingly,
getting Wayland working was easier than getting Xorg working.

I'll also start working on atomic modesetting in my experimental driver
soon. Hopefully, this work can benefit other hardware supported by gma500
if it eventually makes it upstream

Thanks, Gabriel

--000000000000307b0d06610da27e
Content-Type: text/html; charset="UTF-8"

<div dir="auto"><p>Hello!</p>
<p>Some good news from my side: I finally managed to get Wayland and XWayland running on the GMA500, including dual-monitor support!</p>
<p>It was quite difficult, but reusing the existing DRM/KMS infrastructure helped a lot. Both hardware-accelerated 2D and 3D are working in tests, and I&#39;m still working on their full integration with Wayland</p>
<p>Something that surprised me is that Wayland with CPU rendering feels much faster than Xorg with CPU rendering on my Mini 12.</p>
<p>It was difficult (very difficult), but definitely worth it! Surprisingly, getting Wayland working was easier than getting Xorg working.</p>
<p>I&#39;ll also start working on atomic modesetting in my experimental driver soon. Hopefully, this work can benefit other hardware supported by gma500 if it eventually makes it upstream</p>
<p>Thanks,
Gabriel</p></div>

--000000000000307b0d06610da27e--
