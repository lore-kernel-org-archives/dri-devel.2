Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF3606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WC5MDy+9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A952010EFC2;
	Mon, 16 Nov 2026 12:05:42 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA4E10EFC2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:05:36 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6b6f42095bcso4691304a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 04:05:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794830735; cv=none;
 d=google.com; s=arc-20260327;
 b=nXpAl+bnE34MiPGDXX7tE4WSM9gYUWLcfnkHQ8w2QJrfYGj7uJdprpK4NvR+jpSAoA
 RfMGt4TuH1F3wKc8MJP2F5JcwZO8SZsaL4fqPDsxuxrULTF6a1UfNw6T7g05fNkuWpdT
 iKgnETxa7G93PT0r8tfiTArLmMqDtv2G0mfrxffLHAD8CAfSCAYwtbYQ86a4bvtHJ9yO
 BM9A8sq+BU92fizjYxoQ684QYVQR2b4uozHE4sIbW9bx/Uq61q/RuxvJ1gjvALp/Nss+
 LSdSZEudEidv9XgW6QzRXJEhFeKy87u1wnuRAxv4GvJnaRiGz3SoCxy/Ux4n8qchcG8Z
 HDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zMBaHe/FIyAgcxiqNTfBIj7E1ske4IILwI7uGIkaHME=;
 fh=7hjtVDlzhjHzEweVNusgxxmdhb66eSbYh4pV8H97vUI=;
 b=VNbtp1RTFEnS0iQb2leiPKjUb/gJAfPuxP7QoWtgiCmWGq6GDi1dDnqloIgLPNWXbl
 j68lDfcJc9C6H7Dco2qHp8DYIcln63eoUv7im6477z5Bkdv11bk/y4MmcMaFeVQYzkiy
 xGVL8n1tBoyNgGN/pvHkoeUUujk2flBz80sMlzmpGTP58uTIrnNdbXw+VzNkU03SizDO
 5GYGwGf1lBgmLW7/Ho7+90l2zh0yyL/gzBS7gN5OzESa0wSRmAIDCtV57jNKt56UtUUV
 Ep2GZK/6zWqiDcGo1Wl/XmczE0wv+oSna8Jcg6sJ0VKOgGK4V/Vt1CvxOB5/OVQdr9kd
 cE5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794830735; x=1795435535; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zMBaHe/FIyAgcxiqNTfBIj7E1ske4IILwI7uGIkaHME=;
 b=WC5MDy+9f4M2KZQ/y1Aeg6/uyf11N9UTEM/GZSgQHMcXiZe+4z5xc9t7pHYgTmslnh
 JojB+x927I1RQZZk4wNSnQrMHhwypjqu1kVlHEDUukn6Z8KWwB9bhFEe7NFsa30Hk1yG
 LK211EoDXiT5fUpGUmY3cjivAL7dLUsPIPNodnd4hAgoBw1Q9Gin/w9rR7q6qlDuCwai
 MkuebuJtDF11PiJvGU5ZREBCuhtKGgECtmTCkNXg75UnAAqxNCL02GddKP6EIYC5d6n7
 ZsChrrs+TjoaSIhwfK2/WT4tICv7YH/wzr8oBOsc7MuOSPHs8ZZblCJ+npBxA/lVE1MN
 hWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794830735; x=1795435535;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zMBaHe/FIyAgcxiqNTfBIj7E1ske4IILwI7uGIkaHME=;
 b=VLcRhzsSYuR8uaPYzlB4viYh7U2UsGrcZwAI+L8BjYGkk7lMeQcxfg4opmRLqqZVez
 M6EHv9DQ44tQhlx6dKIah/YhrUlo2pWksBJ68Zv1ugpsrwdmLDXT2+yEBTW6xuaNJK5o
 A1hlCxOc0h85Vms/Sn47YizGWTo6zmWP/ule3+QVZl5DW5bAPvsLc4bD15MbwAZLcaOu
 qb2460u6wHqT0AoIiDXamdY9bb7b2W99v4qybzjCWoYBzeZyQrcEHH04jn2bD6GBr3mI
 3aAEkxTM8QKl5AZfdS5Lq++epVUslGSCt8L5EiZCmRnYvEKWlIVYmKoe7shCeU/McdQC
 WeKw==
X-Forwarded-Encrypted: i=1;
 AL+hErHlYyNmbKsfz+pUQDZcEnWB2M2ismE8Fs24cRlE0mOGADwGdoVu54Y0X5oNc/TBsvBtQr5xlOqlEoY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+TAd8blmUpyXWfGHnqobfMLXs7PMTd079iyzWlli7AXDcUF5Z7
 fSIj9wokqEx04S4ySYyCLKpeZPPgk3vAB2SHRcvXr35zeQbOpcmyOUGsGDUV8g5HdCCMHeCCwuw
 dYl1/IgtSjGXHt+ep44xdqyEo4TWcIxE=
X-Gm-Gg: AYBFou3q7W7wtw0QZ46YIBeJKkuch/Z7Hz5cePdRd+IMSyDYRkHdHLxYZquySRvbYnb
 nk2rA134MDjVRA5QgnSbhVO1nh4iXhaWaDJnw807xtzZf60lz+on/0Y7nTnn7QsF9+m/4gUR1we
 DUjq+Veun8mostg9tsI43yZ1GKvykat5SBIEihRdQNKu/pp3vwEXaZQ5n3eisnLftTGCtFMxrXR
 zH7y6KkAbl081o/ynP/FRci1DyYZ0z3XRrI8/S3uYLdKsWrmk9Lf2WjfP7flUy9U0CG92P+Nt0K
 k4AlebTgem+LRxvCb2SidyBh0N/Ba8aHC/jGf89gJL0DuvUA9EcTBoSTnSAJYOez9NhKC3+GF98
 RC0eV+c+bjfvs9vuSIzKvJBx+Y/d6gyS+V7BLYNxjWt0ElrME1A==
X-Received: by 2002:a05:6402:42cb:b0:6b1:d439:5c5 with SMTP id
 4fb4d7f45d1cf-6b7c088fadfmr7399438a12.3.1794830734720; Mon, 16 Nov 2026
 04:05:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
 <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
 <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
 <17f2783e-9157-458b-8463-f98395e391ca@suse.de>
 <CAFGNeagxEcfPuEHFt3TxKhCDoZ0HODpXwXcKpuBxKK=09FkRMw@mail.gmail.com>
 <CAFGNeaiYntE7dQ=-sgaM8gRKuZ+wQ-479ShXKW8v99YVSdHn5w@mail.gmail.com>
 <CAFGNeagfwXZ_MPTaBTGyHacFoKq8PwdXgzWCfkX+R-B63NRfvw@mail.gmail.com>
In-Reply-To: <CAFGNeagfwXZ_MPTaBTGyHacFoKq8PwdXgzWCfkX+R-B63NRfvw@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Mon, 16 Nov 2026 09:05:22 -0300
X-Gm-Features: AclHuK96jAis1ygWm_FuI-PbLYJv445euSO6w0nlAA9UP3JmmHpESo_7YGoU0uk
Message-ID: <CAFGNeagR=WT6NvtrDRwkzJnOqizHWxhTsP9NUX_Ur6M4UtAHKQ@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Joseph Telaak <jttelaak04@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 dri-devel@lists.freedesktop.org, Joseph Telaak <joseph@telaak.dev>
Content-Type: multipart/alternative; boundary="0000000000006006a5066063987e"
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

--0000000000006006a5066063987e
Content-Type: text/plain; charset="UTF-8"

I apologize if my email was too long, I didn't summarize it this time like
I usually do.

>
ty,
Gabriel

--0000000000006006a5066063987e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I apologize if my email was too long, I didn&#39;t summar=
ize it this time like I usually do.<div class=3D"gmail_quote gmail_quote_co=
ntainer" dir=3D"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div=
 class=3D"gmail_quote" dir=3D"auto"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div>
</blockquote></div></div>
</blockquote></div><div dir=3D"auto"><br></div><div dir=3D"auto">ty,=C2=A0<=
/div><div dir=3D"auto">Gabriel</div></div>

--0000000000006006a5066063987e--
