Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5967C606A33B
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGcmHDrA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A2510EF95;
	Mon, 16 Nov 2026 11:49:36 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10AAD10EF95
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:49:31 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c4697404c2bso442242166b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 03:49:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794829769; cv=none;
 d=google.com; s=arc-20260327;
 b=K3H6C/PstH/PUomcfvzWDHEDopZiws/WNbKIsLaEwQdo8a0bMr7meX/5cqCVxW1YvS
 rD4j/0MIXsZkDBYyiSglIfqmrC6hNhPCh7sq+1MFlDoxoaTbZtIqe2Uo51lmvdLIv6SQ
 J+sZVaw9oJNPxv4tAY9LHocreKa8CSo82Lba/8wGdrnILbBqMo9XajO/95u6YlYjTXc6
 oDR55KJSdglzYrWGZPdA78OrIGSr4U+KFyUdFkpp0W29QHw74YQ9jQ3uT/bSVnA6i1q7
 0rpOfc6zYje1sb40dEkStGUhMZdsWGs97gs+4jhq8pVkfFGYj5vby95aQPusI9GcaWwU
 aTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=NpduhABgQz1EiCZx6B5Kln+Huvhgjd7Ot+bN5UIn0HY=;
 fh=6SVR7wGZaRyIDapB+M9voWaBm6+WAUxMiTswI0L0Nk0=;
 b=dSgJYHpIvC8W13gQDprIncaWhEyvDDEmmK5YTVUC1XjQmDwI5nOELKqGPN9yLHfXtx
 RRzU0ivcoi+OMDLLx7OGd4yHw/EWf4Nr18ozp9HNzo0OJrstGnPpqxch11zOkhVQrswS
 9/7G9M0M2sKPZ3NKoRCON0kb3iYxZM+ipc6fdMqhGLG5fdg4UkG2jecNKy8zuqwWjjYN
 4D2RoTRXsN0EZLY1JhP8e7D1ZHVpody/9usFlpZGsZ9829KaPCyJbmkP6XNDDNqg/dbB
 odEBdnRhOu+UmYzWW8G5HIRfKQYu+1fuGJ7so1+1N86ptEGlhzxqs9I/+ZG8My2l5RiY
 OEoQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794829769; x=1795434569; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NpduhABgQz1EiCZx6B5Kln+Huvhgjd7Ot+bN5UIn0HY=;
 b=OGcmHDrA6kRFJaqyVOCxIDkkIR7+GNLFqBRmUbKXYmAmxWeeQoZD3R5i30rrythCeg
 fblzuFwJOag/P/KfSTy8N/WPhFaw2RGN8j/enrxtghgzjYo2B7AgYKa7V9pRVH1wsoms
 PzgQgVFuYnvk4E2mOz3yUG3sgiTx5S7GgzjAiv7R+Yg3g+sE+ftt1JEHpbKvUl4qVOwW
 //pRQUo+nh49dmlnCAzrpxCPn2Pm5+E3ckfxLSQaf51aC8+MAMlFEPh079YwsMHvJDN0
 FJC8TQvoO2L+ZfEVgNu0z7H+q8ij1DzybfGuvJQA8Pv4jSAXVP/VrymL+FFLWtULl849
 KWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794829769; x=1795434569;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NpduhABgQz1EiCZx6B5Kln+Huvhgjd7Ot+bN5UIn0HY=;
 b=LSwq5FyS1ZEXd9vzPYnvNRu8DAc/DUybu/SgQ75E5Jk+rc9c1xHvClhSaM+7/ZThCW
 LCqwlp7z+OF8MF0CDUTuODspXu/JN/NneW6jFuRBivdMn+VE2eXRMQTb4QH15TgxzuRD
 IvrJ0ZJDMtMpklStWJSmUJxbwYsOd+UrubbYTmuiIdPgiuSuu+BL6WVZgJ4gsUFSvqKt
 60CXaFsHlrSl58wT4JyHGoW0zjSmNYitP7lgnc3ceaAMlJ9d2Dfzz2HbmoCjAqHhF5Z3
 1Xq1LvUH3FkmIWLkYhCoeFZlGyjxpEd78KsRqbmPHxU4eCJaNrKX77u1kuwfolSk2sSB
 yj+A==
X-Forwarded-Encrypted: i=1;
 AL+hErEvLwxl3FViToYmJjvbcQdh5Uq+Y1RLbA6fZy1+kAZQFp4gAi1wdvvb4RD6LUTQ8/Mb62jkMjG0Tos=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ynFpdkpq7zaprkZn7kiL/Qbgozb9bM3F316Nas5W+m/B+Fdsr
 tf4xB1bw8wy02oYDJJx5DsojVBCXNGo5wVbk2TjVVf23vgC6Tb6Fe6SIHxsWMNqpxT0xOFKesW0
 thDeCOzi9ziv5dMSXWJ6oDMYLPcs6FUM=
X-Gm-Gg: AYBFou2cxUMmidyT2D3W+6QArVvv0ELY8jOty8N49XfyTd+su01qqqXvNZvs016Q3zy
 bikPnqeF3sDzrkHOC91tW8vDrm6JJaagy50YRvL9VqfVg9KY3VXodsrBH9Qb12ZHe7TfP/LvGaT
 1/8XOM2jdVew4LKcsA51A64WdYGixsuwEqtPD8A8lKRfE1q4dWe198g0SNrjTSCqVWWHDY0aoo5
 KYYVmCh6QPmq86dOQBuGp+U3VkFWYqffbDNP2jmS7lsfY0mUgkw6Zr3j/fT+COQ/tBDJI+Bt5B9
 eAcH0cPiuNbJl7MdWyhBax7mNQh6HBjRiGwQ/G3qNwuHOncBQIS1iZAya5baP7nGHvKSteMEL+t
 5Gcw83bOwQM7lMP9faIYF9ccKDHLO+laBbEXg/KjyZkMP5SAscZvCwKpipQ93B1QLQv5O7q8=
X-Received: by 2002:a17:907:86a6:b0:c42:4750:8d49 with SMTP id
 a640c23a62f3a-c5096427bb2mr808609566b.25.1794829769073; Mon, 16 Nov 2026
 03:49:29 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
 <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
 <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
 <17f2783e-9157-458b-8463-f98395e391ca@suse.de>
 <CAFGNeagxEcfPuEHFt3TxKhCDoZ0HODpXwXcKpuBxKK=09FkRMw@mail.gmail.com>
 <CAFGNeaiYntE7dQ=-sgaM8gRKuZ+wQ-479ShXKW8v99YVSdHn5w@mail.gmail.com>
In-Reply-To: <CAFGNeaiYntE7dQ=-sgaM8gRKuZ+wQ-479ShXKW8v99YVSdHn5w@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Mon, 16 Nov 2026 08:49:17 -0300
X-Gm-Features: AclHuK9WX-oWLkCrPQ2cRyujrZhoBNU7daeFrD7FbTy8maDykBgkJv-yNmO594E
Message-ID: <CAFGNeagfwXZ_MPTaBTGyHacFoKq8PwdXgzWCfkX+R-B63NRfvw@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Joseph Telaak <jttelaak04@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 dri-devel@lists.freedesktop.org, Joseph Telaak <joseph@telaak.dev>
Content-Type: multipart/alternative; boundary="000000000000d165bf0660635e2d"
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

--000000000000d165bf0660635e2d
Content-Type: text/plain; charset="UTF-8"

The AI model did not appear to have any leaked source information (on the
contrary, it struggled to find 0x07000345 and still hasn't found it to this
day)

I still dream about that DWORD  to this day, because even after reverse
engineering it, I haven't figured out what it does; I've only implemented
it mathematically.

This dword has a commit made specifically for it on GitHub (hash starts
with 07000345)

>

--000000000000d165bf0660635e2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">The AI model did not appear to have any leaked source inf=
ormation (on the contrary, it struggled to find 0x07000345 and still hasn&#=
39;t found it to this day)<div dir=3D"auto"><br></div><div dir=3D"auto">I s=
till dream about that DWORD=C2=A0 to this day, because even after reverse e=
ngineering it, I haven&#39;t figured out what it does; I&#39;ve only implem=
ented it mathematically.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">This dword has a commit made specifically for it on GitHub (hash sta=
rts with 07000345)=C2=A0</div><div class=3D"gmail_quote gmail_quote_contain=
er" dir=3D"auto"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
</blockquote></div>
</blockquote></div></div>

--000000000000d165bf0660635e2d--
