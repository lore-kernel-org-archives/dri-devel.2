Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68123606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KT/HoBKh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90AC710E423;
	Sat, 24 Oct 2026 20:51:06 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com
 [209.85.128.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BAB410E1D6
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 20:50:59 +0000 (UTC)
Received: by mail-yw1-f173.google.com with SMTP id
 00721157ae682-8b0a28a720aso18015387b3.2
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 13:50:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792875058; cv=none;
 d=google.com; s=arc-20260327;
 b=M30na7bEX5KL1RBBS8t06Cj8eqWnglFE/F5l/ewM4m7oeSmztKTl0dLZUPl9eao703
 e3oTBtcVEUZbcyvE0NH6HylYgnp82S/ZvdRq+iXOJ7v2wOWcQi6R4oaJVlBG/6uVoeaQ
 KGTwA5R4y5UBtHKWWm/3PFhXUw+uKxeYnIuzXlBiSGbBKcSt1reMF8fenTE3GlV6kR2D
 AzvQW1VnFtWfvG9y4eNL2bCK/uwvwXq5GGpme35906l+nXG8vPjySaHjTkjcVvxZtNQj
 5lFQ6XKyrXYYoUDYCXWsLwqW0B+JGzSg49njDB1mo8TY7jIMGp5uiuokStmjKsczz6nn
 FCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=THEh2bYqn6+ElVcsARETUL5wY3+9JX2zf4qY49wZ0/k=;
 fh=1Wj45WNCQFbDKDNHEA7HCuvhTNUma3V3vGSVZQbN4Fo=;
 b=IiY2Hw1DukOWDh4m+seOgAmqIKdPc1SI1dIwQynET29gOSae/O+OZPuFALWLji29NI
 qGWQd/PrbfurCJ95EUrqvOVbQyx3cB/3hD4OzPW/qdOW3cGpO9AQmssCxQVP/Pid9BNS
 304c3Ou4O6FLC2I2v98IF2D+TvSpDqxPaR68yQ1xplAi7DHZlT2me9mzzhDnlcbHOFxR
 pV14OxAcAYv5IvFOrXv8ok8X6qdJ/MLCFiceV5cPxfPnRi0wk2YiyG8aZNgmQjpmabC8
 myGdpV9EtHalYkmRSia8tSuWe/IjNJ4iZO6GP6D+tFpFpU1AdrrXoJGiCXC6QPF9ctrw
 /qZg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792875058; x=1793479858; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=THEh2bYqn6+ElVcsARETUL5wY3+9JX2zf4qY49wZ0/k=;
 b=KT/HoBKhubdaUSu2lRSo+DIUmbWxe6AXpMubwx6C+zwPjunSQD2lsqHr2TC8/VFDKn
 GWhhRq6aoJP1WOaQcrat/Q6kM1/pEtAkxAkTBNAAqJQnbzZMkyjtKe0C81pKRJMFX2Ze
 w/qYU47wMIj/cptFdK1qJWjZpobPxIlraqMqFIENd5Yp/AbOJ4RqPs33HygFnRCDGtQg
 A+m1hy3Wxp06+n5HuXPQ8BcBT4/v5SlTCwQDx3yr9VnvS61Pg9b2E1/QZPR3qdCJ4jiB
 Hgq/vvf8dy0ITV5TDtqsDk9BVan7iMqOVheqbw3WCvnB35fZkax1lOvI4uGo62K9YKMo
 1EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792875058; x=1793479858;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=THEh2bYqn6+ElVcsARETUL5wY3+9JX2zf4qY49wZ0/k=;
 b=j2z2TXcURhJ8MSuMfnqpz6CuHJRAX3DSl6nJMkmllp3J4a4hppBXEdwG6qkCW9yF7Z
 8wWXQSsOHyvXSB+idxRW9JC1fuLc8hrZh6ACTD29LsWO84SvtUmwXLk3k5a39YLa0i/5
 5K34CMElDVHlEyV4gztkVtR77SrU3sX8Ra0mWuVqT2F/siPiWuOMXOBrqI56Vs2K1kUC
 KvsuOCeKVTtU4NN3AoHNUDbkBIjieuTwf0ppXcXOkTeZzJWjzlUm7XNeWDW548aq/9eS
 OMm/R/7l6+0xzIuoXOtv8ilxMt5n5RbBma7+O5pAShkBz6Wdkl0IABVpbcRmOKu3Kag4
 BQ9A==
X-Forwarded-Encrypted: i=1;
 AKwUvByiuevghTswVsjrseEysjzWbtBow2baIZ872zqrZbBnPNMN7QY9W5hT9+mli9hNHQOQohXXxwG2Wa0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIOiyr3jhEfk4lxnPNJIQn9mTOK9MnSdGGmoAEw6qirFoDq/Q5q
 /w/Xlms84FxvIrgd0Osmr3P2OQIFFwJt6qNpnP5NQVHB5E14faoShrgEuED20jBJK0gkT9u46oP
 a+H5Ojt2QoMpxFE2HJrawgsidFDtiqKhk2r/a4tW8VQ==
X-Gm-Gg: AYBFou0xSpdA0g8PfzmrlKmyUpKczuGcJ0aw0glzpls9BluzNivmLwSy5FvYtIf8Wfw
 /qGR0EdHWhA1wwWirtY3gN3+Jy2W8U8qJRdg0Zjgkf+Tz1E06wldT4EznSKenWX9M9j6aPCG3bS
 RFks6VzdzKu2+cCL1ELXpjwCybBSKy0+KvJS5N2ElMPFq0uEPQWowUqknJEKsdx31WjdHof7Lsb
 Em/i3IWQ/+2/+XqQHu2v4aKgLCSRYP/lZ3jGFmgS4VaZag+rJC7GMxEw89gehe7wlo4OdFObdYC
 wVhxv9e0aCGvwzt05t/Z7JGfVgfNUH6WqsUgNEiS5cnnVnhAFB8Oxxy5bsrfaTxmBFYZxBLvrX6
 XCQ1w/GxXcYfT0DzRF5XUro5Q2CYhto8c9vA=
X-Received: by 2002:a05:690c:82:b0:8b0:c50c:2547 with SMTP id
 00721157ae682-8b166cbd79amr20873667b3.66.1792875058672; Sat, 24 Oct 2026
 13:50:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260923162839.1368073-1-qwe.aldo@gmail.com>
 <20261009030328.3062630-1-qwe.aldo@gmail.com>
In-Reply-To: <20261009030328.3062630-1-qwe.aldo@gmail.com>
From: Aldo Ariel <qwe.aldo@gmail.com>
Date: Sat, 24 Oct 2026 17:50:47 -0300
X-Gm-Features: AclHuK9AhTwIlzFskjDteU31wyGjNevtnC9D6_ZiZtWl8UdkpewAefbYOk7fI8c
Message-ID: <CAP48Hfv00AnX2ejk9twed6ZVPaHFoCUONKC96EdvFASQQj=nZw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix ATOM parameter space index bounds check
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000ffb84e065e9c40fc"
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
X-Spam-Status: No, score=0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000ffb84e065e9c40fc
Content-Type: text/plain; charset="UTF-8"

Hi Alex, Christian,

Following up on this v2.

Would any additional testing or changes help with the review of
the parameter-space index bounds check? I'm happy to investigate
further or revise the patch if needed.

Thanks,
Aldo



On Fri, 09 Oct 2026 00:03:27 -0300, Aldo Ariel Panzardo <qwe.aldo@gmail.com>
wrote:
> Hi Alex,
>
> Friendly ping on this v2, sent September 23.  It fixes the dword/byte
> mismatch in the ATOM PS index bounds check in atom_get_src_int() and
> atom_put_dst() -- the sibling of the calltable underflow fix you
> already applied.
>
> v2 also corrects the pr_info() messages to print ps_size/4 (dwords)
> instead of ps_size (bytes), per Sashiko review on v1.
>
> Thanks,
> Aldo

--000000000000ffb84e065e9c40fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Alex, Christian,<br>
<br>
Following up on this v2.<br>
<br>
Would any additional testing or changes help with the review of<br>
the parameter-space index bounds check? I&#39;m happy to investigate<br>
further or revise the patch if needed.<br>
<br>
Thanks,<br>
Aldo</div><br>
<br>
<br>
On Fri, 09 Oct 2026 00:03:27 -0300, Aldo Ariel Panzardo &lt;<a href=3D"mail=
to:qwe.aldo@gmail.com" target=3D"_blank" rel=3D"noreferrer">qwe.aldo@gmail.=
com</a>&gt; wrote:<br>
&gt; Hi Alex,<br>
&gt; <br>
&gt; Friendly ping on this v2, sent September 23.=C2=A0 It fixes the dword/=
byte<br>
&gt; mismatch in the ATOM PS index bounds check in atom_get_src_int() and<b=
r>
&gt; atom_put_dst() -- the sibling of the calltable underflow fix you<br>
&gt; already applied.<br>
&gt; <br>
&gt; v2 also corrects the pr_info() messages to print ps_size/4 (dwords)<br=
>
&gt; instead of ps_size (bytes), per Sashiko review on v1.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Aldo

--000000000000ffb84e065e9c40fc--
