Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8358606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eEYapr60
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE40510E3C0;
	Sun, 22 Nov 2026 11:55:19 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0EBF10E3C0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 11:55:13 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-5365f9a04c5so8071891cf.1
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 03:55:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795348512; cv=none;
 d=google.com; s=arc-20260327;
 b=Hxb+KKV5KqqNfxJhHPBl0WSbZ4ZjhuVtKtc8cxudl/nXOzlcZPXM+7KlUoKuUe42vy
 /Yg77pNxu3UuXOUNf9U9dOHaamr1YYl/HgB64nEE2G7kLiLmBhZbxCohnUfGzMhMtSJY
 0BiJ5BWraK/JaGzOkJxBvPhdzyufH0nBrkNfskFAglXs7JM20lzKB29N2B34XfEOc5jQ
 VvC8QkbJc8F1v2DKH5qVKhEW89i1CwzTqFerCJYuYEuxJJ40LfOMzSQeDCLeDaTbolgq
 ZWoyz8fUnnrTPUc2178Nt41vzse4i2Xmim1aPOQJHsrHjhcrPa0qtuoMeJZn35hIIKh2
 zvhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=PEBvudlYGM9SyuS/eii/q1QlyLvQOf/trD6vSUj2gqw=;
 fh=B8NDqZpZTs72jrcJ9fQSk9twoMj8x3UyG9FdPRLNdtE=;
 b=mqfmco+g/WtRBb/5/7ApJVSoIN4eJ2lzc4W8hzOIeusUTmabiiaNB6DNH2iuFEO4Um
 L6hr3/CSu5oySGNdIEqUInl1EDWAm43Gm0v8+fJv1lmGlsjJzVhIpCWVNyzmm95v6OL0
 n6GWF/GTPQ8fjg2DcA+ekJPEkwFinBh2EjbI9j/BzaosYhYsEFKhFd9v9CDAiz/PtFdC
 Zv5S/sCB4GylQxqZKUmZCSeyCFRmLacJFyoFywlE6tGM6Z1yZtogab3ItJOMyOV01Wj7
 zusaxPxJNC51jd5lq7MU5dZsrK+a0SxJMijX9V+RumpYFNcSxEKAqtAjv1F+1E+BT+zB
 GSgw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795348512; x=1795953312; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PEBvudlYGM9SyuS/eii/q1QlyLvQOf/trD6vSUj2gqw=;
 b=eEYapr60QfuMpyF8p23z2Wpa+OazO1IoGTAOMgsyePgpD4VV+eIZ8KAffz+GQTXafC
 k4pwBXk68BUuussjK5eR+hQC99SU/Q3GSnjJ0widOLnvLDXFWDaFzq83zWIJdN33irJG
 AbZuk23HyfL/VbUd0DFFJ5ZoalPbl9t9IftL/cDw18nj3blY0U/9A6XOHDwnWevzltuJ
 fy3O/lvF6rfZCQaYB8Wjy6sHrCFt/yrAJRqGPCBKMvkjOX5Ihi6qpM4IMiaKfzEPhpLU
 w6K1HdXDwkbZulcr/qTInkk6eyPtv23VBfb6AmJJOutzc8axf4qTEr3oPujKiCxkuJRp
 ZK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795348512; x=1795953312;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PEBvudlYGM9SyuS/eii/q1QlyLvQOf/trD6vSUj2gqw=;
 b=VFDRuCUicPbN4B6Z7slj3gUK0M2G+fURgL3rmH1wz2mJAKzn2hpsdhvPAnk7IxkC7v
 gQ7NEpddpZalMAD+0nO0S9ycDTCFVYaSXXKZbQU9NimGEZks2ZaBccPvsr3szl2szCdz
 viYTp4MExuTfbeFvZgIybCpMIi690idL8TdW0dEayYxIP/h0PxS7ckVNywu99JhB03sZ
 bOyvMscuPrSlAaskOUwsh7MPPz+wao0WonU1ogXxJZ27k6yXqNFIWbATcLmzecT1zGjN
 Gl3FvNV4Lk36M/5+72bSdaozkNdK8pjg3WlKfBLaSIdfv9LNpT/kb9V7qdtdQVCwQdB1
 KjdQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGxefqJknUZX6peWBK6zHmWFdDIKZ91+LD/yQASywvIWXRMKOnpMA3kQzK7cLlZvGrF923UzUYYRwM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9N7Bw16tvmrv0HxHxaCakYBoawFWZZv3Fan1eP7TZOtMpCFdMs
 8PUH7Cu29ToDFyXI1Cj1vqmuby8rp6tCTASzhHcr3vjAF0oEsRU/IyXfBIqrChmGq1zTEMfbAX2
 RbUiWrm7PQFxJxeMsz/kjnXy7vFXFZN4=
X-Gm-Gg: AZFdTZfLFV89EzAcg1U50Z1u830wLnZCWchfE3blsUTtQ55fFwaX7Nk4ap+HSgJiBJe
 QvoW5/nQNPIfUfY+LmREP0TzzvNaz9kjwJL9aaHSkg9MQih+yvERLVy7Bx572qx5r/EFSzVX2aY
 GQ5A4rfPybWeNs5vBaQkSGEpbqRLl0sDTd3bC53IsUXy8JjlPLG4GvWh9jR7U1teXZV20zKfNCT
 P14pOe7TfX9KDceaje7gbPpoZH6qbIuhUkXVVjzcqT4JfVGhRJmvdP4xnKOrUHK/goC6ypxuUby
 O2GMrbfvLBnTxILgarivq2eraEwRA6pdVhDrd41154heF2R5QhXg0870Kh1pbEKesYjGSaEQ0h4
 YtPww7moyPYr9FYoYQlpO52M/azsRE7yedRfsUDGz3gpc0Va3AODUpeL9eA==
X-Received: by 2002:a05:622a:5e16:b0:55c:216f:38bb with SMTP id
 d75a77b69052e-55d76a5af75mr155172321cf.36.1795348512352; Sun, 22 Nov 2026
 03:55:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261122072007.14685-1-mbkchelofficialdev@gmail.com>
 <CANiq72kV0YwG54i6fLSv1Rwtu+3Ks8XUzpdkZohY5tiH6LzhRA@mail.gmail.com>
In-Reply-To: <CANiq72kV0YwG54i6fLSv1Rwtu+3Ks8XUzpdkZohY5tiH6LzhRA@mail.gmail.com>
From: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
Date: Sun, 22 Nov 2026 13:55:00 +0200
X-Gm-Features: Aa3M54oprG3AdU72C_-xhfZchFZcgvasoQm4vceuI-WEz9WzrsolDK7mnQWZ6K4
Message-ID: <CA+YDrKBYCB+AzOgDY6M6cczSyVNkY8me9UiYB-tZNz1bbanPnQ@mail.gmail.com>
Subject: Re: [PATCH v3] rust: gpu: buddy: store the allocator inside the Mutex
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Joel Fernandes <jfern@kernel.org>, 
 Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000053add50660dc2697"
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

--00000000000053add50660dc2697
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miguel,

No reason at all, I accidentally dropped the brackets. Keeping [`Opaque`]
when applying sounds good, thanks!

Best regards,
Ivan


=D0=B2=D1=81, 22 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3., 12:48 Migu=
el Ojeda <miguel.ojeda.sandonis@gmail.com>:

> On Sun, Nov 22, 2026 at 8:20=E2=80=AFAM Ivan Tverdokhleb
> <mbkchelofficialdev@gmail.com> wrote:
> >
> > -/// The inner [`Opaque`] contains an initialized buddy allocator.
> > +/// The `inner` field contains an initialized buddy allocator wrapped
> in `Opaque`.
>
> No need for a new version (I just noticed this skimming around), but
> please keep the intra-doc link when applying the patch. Or is there a
> reason why it is removed?
>
> Thanks!
>
> Cheers,
> Miguel
>

--00000000000053add50660dc2697
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Miguel,<div dir=3D"auto"><br></div><div dir=3D"auto">N=
o reason at all, I accidentally dropped the brackets. Keeping [`Opaque`]</d=
iv><div dir=3D"auto">when applying sounds good, thanks!</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Best regards,</div><div dir=3D"auto">Ivan</=
div><div dir=3D"auto"><br></div></div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=81, 22 =D0=
=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3., 12:48 Miguel Ojeda &lt;<a href=
=3D"mailto:miguel.ojeda.sandonis@gmail.com">miguel.ojeda.sandonis@gmail.com=
</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">On Sun, Nov 22, 2026 at 8=
:20=E2=80=AFAM Ivan Tverdokhleb<br>
&lt;<a href=3D"mailto:mbkchelofficialdev@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">mbkchelofficialdev@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; -/// The inner [`Opaque`] contains an initialized buddy allocator.<br>
&gt; +/// The `inner` field contains an initialized buddy allocator wrapped=
 in `Opaque`.<br>
<br>
No need for a new version (I just noticed this skimming around), but<br>
please keep the intra-doc link when applying the patch. Or is there a<br>
reason why it is removed?<br>
<br>
Thanks!<br>
<br>
Cheers,<br>
Miguel<br>
</blockquote></div>

--00000000000053add50660dc2697--
