Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77745606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Nc4DZPCH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F7B910E3B7;
	Mon, 16 Nov 2026 11:40:00 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9366710E3B7
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:39:53 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b704171bc9so4379464a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 03:39:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794829192; cv=none;
 d=google.com; s=arc-20260327;
 b=aNZLNTUp8Y7Mfhlfa6mx53e6iMZFLx3nZLvoJio9gR7MGS3AAetXmVFUKVrmyK9BYS
 a9XJjbNbf1paygweK7Dq0B1V4an8TBuCUZKWNeMzs8b4J+7gFrnnUcFvJjDNO9WxOa8z
 XgxJ1aeJzM8eW0AGNc2Wt9Hlh8EGeyzB6tucNiSMcJGHpimvZBLg2iLaHjnJNmRLLhGD
 rHns3OEuDazoRBiVCNrRpLiWto3a8ehFSyIwS2nvCGLeh2UnDTeeLWto6jtxFGMaza07
 HsPGstYG45Pywe6lOqYRcfwsAjOWkuq4Pn1buxN59JeAPpJdS0TvQohPUFKxYtkLSuC2
 V2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2YL8Nj2lvUOnzRR2IgrFN3Na23UVbM54KMKdevWetcM=;
 fh=teXYxVVixnm1fdNPKl6S4wMP3pWQNpZ/cy1zxqBSZxI=;
 b=rbuvRYMX7rZh0aCo3qfaA1Q+JTMw+fkQGo6hyChyYRIMR2q/XPixdYkzgKlhfUbT/H
 LalbqNBhcbQ2uRwjd43fxeOKQPHprlHIuOqHJHvCijsfwFcgXYPRShtiMOl8/nv3p9Xs
 vYGQ3g57wXLT0g6BdZIYrhZxYN+F69pvyCRzgLNyEzMB7HSwef32eezinVcWp9qJg17q
 j6S3FJ3dHKM/+tCEQD29zR/ouxSihb5lHN/s+FJqrBwSBWHH4lCYH2rzMQvvnRExN6G0
 4dkWjTJ9ZyX9QS2csEkwBbCc3gkPo5tplLQpAPN9eZciv+i2TqSWoClk5iEsV0bMGSa7
 0qKw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794829192; x=1795433992; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2YL8Nj2lvUOnzRR2IgrFN3Na23UVbM54KMKdevWetcM=;
 b=Nc4DZPCHt3Jy1DCqKhbugMh3NPeXHIWxw+G5/khfLm/cDJ/+/P91ItbJh7x5fXIpOV
 dsQ9n2ul+qstHaYfqNnNU8S8A6wSru07HThKdLP0Ac6E4evDWkQgVVAXJQot8ReW3T9x
 5U7HTc/yGIzV4Ti/wBuo6gFLxzcbn2liYd1q80oTGS7mLp9tbzOFL7gdnTIXBMgty26i
 Z5rA404+bsV+wCx1S9dAb8KJobCSlf57zCMMQonZ7sCYN1/llhwb0eZGV2lskYBmZtIc
 ubD6RgMRwBQx0eTU/dgQkM/3+3h+Uc3XXJEmq1TNs78XreipKX0CyGl9EdEdc8/tXQh8
 25uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794829192; x=1795433992;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2YL8Nj2lvUOnzRR2IgrFN3Na23UVbM54KMKdevWetcM=;
 b=G85vAXJff12FCx77BfJJGleuvwedhtpzL+ByoqYgZeprSPNFq50JOmhPsTMq4uNzAW
 Dv0HVzon1tQiiOfVB+gQKNCNGPGSEIW82JMT9xAGNb2NxONMwGUwf7zlMTbOWpcfsFRi
 ssNweszhQEgQMLn1HvrVsBaqFOV7HtpVrQA3S9VsafPMSwCUkIsXvSLRkhOkasRBpYH/
 D24eOyX+MR27u/sqF3ERH0Ome/46j3EXofUMB8HGbvjYXzC+3I2+ZOs2ufzddW1onizx
 xiBVuYAfb4tCFilqkFCanCnKqpqbdtHVk0lMlRGuaY1qECJqDM2zuHhYQiNKXeMDxO6v
 wJww==
X-Forwarded-Encrypted: i=1;
 AL+hErFantWJhv4+SvdnWA9CDZYWzIv470laBVrUxVJEbg3I+8iB2dBbg9TNvFn0G/9FrylTcdWuhiWoFXM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9r/0utK7AUl9Tvn8XSOXd6u0uYe4Y/Ib53fqCsePHvuCEc7iyx
 xi2dn2cGLpQWf14WXa/FWWO5K0KPnLQbCehPqmm72rpEWGVV1uzLy7KjM+ovygxgqAYhwKtROA0
 dt5Ax32S3uxrykZxX97E9QIMeFAL6DR4=
X-Gm-Gg: AYBFou3N6cTQxhgS1SiWLNv4C9rhtw01yNFVz/6Re+ZCqf+DRyEnqEQR7Da6ubSEssy
 FtLEXbBebDlkOp1Kk54qcPh6F1bxrhH3lzM86HfQrhF24KrcXXHFZeJZBffqc1N50hH1meAlK8S
 jfUOpLSrPgyTPwuv0Ny2FIUcbz+Y/tagL2ShwbJleNtPOK0EwtzRPxLEi3JDJWCYsJ8pqH1A0x/
 pSevbfvJna7QdENbPn/3nB/Y5aO7jThNC3L3m4bHLF2v4etEM/Z18mplobe/xLVRisY044kPwNq
 Z7bmNrWENNr/YRlYrG6fwBeSSHKb0640PzojunzFTAvVgo4WeOhTUsY/C2rSxS+XhxDYcwr9ps6
 wYQKER04eMC5PlA5MIx3jlbruVgKX977MgPTXiviVwpBn/f7U51kXhMAa5yf5d3nrA+4M+K8=
X-Received: by 2002:a05:6402:4010:b0:6b7:f9e0:a5bd with SMTP id
 4fb4d7f45d1cf-6b7f9e0a75bmr3424744a12.23.1794829191624; Mon, 16 Nov 2026
 03:39:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAMeQTsZbLYpPKySm9ubYc8pw0t62ZEdKkkzc4h3Hdjq-9pGO6A@mail.gmail.com>
 <20261113085341.61992-1-jttelaak@hotmail.com>
 <CAFGNeajPo8DrqNbM+86AQz0LT98a69_+T7R8DoKAX4Q2LJE0kw@mail.gmail.com>
 <CAFGNeage70+BaM6SP-q7YAgp-tgrATuO7m-eEoN6ERr0mC55aA@mail.gmail.com>
 <17f2783e-9157-458b-8463-f98395e391ca@suse.de>
 <CAFGNeagxEcfPuEHFt3TxKhCDoZ0HODpXwXcKpuBxKK=09FkRMw@mail.gmail.com>
In-Reply-To: <CAFGNeagxEcfPuEHFt3TxKhCDoZ0HODpXwXcKpuBxKK=09FkRMw@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Mon, 16 Nov 2026 08:39:39 -0300
X-Gm-Features: AclHuK9yVVe0yYE0yFlyJN-JSy5LWg-9BnNV9CM7tVVvy-z53hCWrGD5jk1ZDYw
Message-ID: <CAFGNeaiYntE7dQ=-sgaM8gRKuZ+wQ-479ShXKW8v99YVSdHn5w@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Joseph Telaak <jttelaak04@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 dri-devel@lists.freedesktop.org, Joseph Telaak <joseph@telaak.dev>
Content-Type: multipart/alternative; boundary="000000000000663bce0660633c60"
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

--000000000000663bce0660633c60
Content-Type: text/plain; charset="UTF-8"

Hi,

Just wanted to share a quick update on how reMESA is progressing.
The project has made quite a bit of progress on the SGX535 side. I've been
working on the Mesa/Gallium integration, NIR-to-USSE shader compilation,
resource management, and the rendering and presentation paths
On the Dell Inspiron Mini 12, I've successfully executed GPU rendering
tests, including framebuffer readback validation and sampled-texture
workloads. I've also validated a hybrid 2D path combining CPU operations
with GPU-accelerated copies;
The main remaining challenge is getting the normal OpenGL application path
fully working. The experimental rendering paths have produced valid results
on real hardware, but continuous rendering, normal context creation, and
desktop presentation still need further qualification
I've also published an experimental alpha release to make the current
source and development state available. It's not yet a general-purpose
accelerated driver, and I don't want to present it as one.
I'm continuing to work toward a usable Mesa/Gallium implementation, with
the goal of eventually presenting the kernel and userspace sides together,
as suggested in our earlier discussion, I intend to clean up the formatting
code, etc., for MESA, but I see that I might have serious problems using
AI, the provenance shouldn't have any serious problems; I retrieved
everything from open repositories from TI, and reverse-engineered binaries
like xpsb-glx and psb_dri.so

Regarding the AI, I managed to prevent several things before it reached the
repository. I identified and fixed a UAF vulnerability (it literally
generated the UAF code right in front of me), as well as a repository I
call the "bomb repository" full of leaked files, which, if I hadn't been
there, would be in the repository today, None of this content was
consulted; regarding UAF, I reviewed it directly using expand code in the
CLI I use.

I wanted to know about Mesa and its AI restrictions. The best thing is that
Remesa doesn't have its own DRM, but it can have problems precisely because
previous reverse engineering repositories have AI, and almost all of Remesa
code is generated with generative AI (but still revised by me at the time).

I created a provenance file in my repository called PROVENANCE.md where I
put almost all the files I've used. I'll search for more files that I
potentially used; the documentation has many JSON files and such that say
this, but they are obscured by newer documents.

One thing I would greatly appreciate knowing about the use of AI, and
whether this might prevent integration into the MESA. I've been concerned
about this because of past actions of RE projects, blocking AIs, This
really worries me.

Just wanted to keep this discussion updated on the progress. Thanks again
for the feedback and guidance

ty,
gabriel

Em sex., 13 de nov. de 2026 09:30, Gabriel Gama <
operatingsystemsdepression@gmail.com> escreveu:

> The old 2D acceleration code can rest easy; I'm not going to touch it.
> I've been working on my own hybrid 2D approach instead, with good results.
> The CPU was indeed faster for fills and console scrolling, while the GPU
> performed better for large framebuffer copies.
>
> Ty,
>
> Gabriel
>

--000000000000663bce0660633c60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi,<div dir=3D"auto"><br><div dir=3D"auto">Just wanted to=
 share a quick update on how reMESA is progressing.</div><div dir=3D"auto">=
The project has made quite a bit of progress on the SGX535 side. I&#39;ve b=
een working on the Mesa/Gallium integration, NIR-to-USSE shader compilation=
, resource management, and the rendering and presentation paths</div><div d=
ir=3D"auto">On the Dell Inspiron Mini 12, I&#39;ve successfully executed GP=
U rendering tests, including framebuffer readback validation and sampled-te=
xture workloads. I&#39;ve also validated a hybrid 2D path combining CPU ope=
rations with GPU-accelerated copies;</div><div dir=3D"auto">The main remain=
ing challenge is getting the normal OpenGL application path fully working. =
The experimental rendering paths have produced valid results on real hardwa=
re, but continuous rendering, normal context creation, and desktop presenta=
tion still need further qualification</div><div dir=3D"auto">I&#39;ve also =
published an experimental alpha release to make the current source and deve=
lopment state available. It&#39;s not yet a general-purpose accelerated dri=
ver, and I don&#39;t want to present it as one.</div><div dir=3D"auto">I&#3=
9;m continuing to work toward a usable Mesa/Gallium implementation, with th=
e goal of eventually presenting the kernel and userspace sides together, as=
 suggested in our earlier discussion, I intend to clean up the formatting c=
ode, etc., for MESA, but I see that I might have serious problems using AI,=
 the provenance shouldn&#39;t have any serious problems; I retrieved everyt=
hing from open repositories from TI, and reverse-engineered binaries like x=
psb-glx and psb_dri.so</div><div dir=3D"auto"><br></div><div dir=3D"auto">R=
egarding the AI, I managed to prevent several things before it reached the =
repository. I identified and fixed a UAF vulnerability (it literally genera=
ted the UAF code right in front of me), as well as a repository I call the =
&quot;bomb repository&quot; full of leaked files, which, if I hadn&#39;t be=
en there, would be in the repository today, None of this content was consul=
ted; regarding UAF, I reviewed it directly using expand code in the CLI I u=
se.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I wanted to know abo=
ut Mesa and its AI restrictions. The best thing is that Remesa doesn&#39;t =
have its own DRM, but it can have problems precisely because previous rever=
se engineering repositories have AI, and almost all of Remesa code is gener=
ated with generative AI (but still revised by me at the time).</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">I created a provenance file in my re=
pository called PROVENANCE.md where I put almost all the files I&#39;ve use=
d. I&#39;ll search for more files that I potentially used; the documentatio=
n has many JSON files and such that say this, but they are obscured by newe=
r documents.</div><div dir=3D"auto"><br></div><div dir=3D"auto">One thing I=
 would greatly appreciate knowing about the use of AI, and whether this mig=
ht prevent integration into the MESA. I&#39;ve been concerned about this be=
cause of past actions of RE projects, blocking AIs, This really worries me.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Just wanted to keep thi=
s discussion updated on the progress. Thanks again for the feedback and gui=
dance</div><div dir=3D"auto"><br></div><div dir=3D"auto">ty,</div><div dir=
=3D"auto">gabriel</div></div></div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">Em sex., 13 de nov. de 2=
026 09:30, Gabriel Gama &lt;<a href=3D"mailto:operatingsystemsdepression@gm=
ail.com">operatingsystemsdepression@gmail.com</a>&gt; escreveu:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><div dir=3D"auto"><p>The old 2D acceleration c=
ode can rest easy; I&#39;m not going to touch it. I&#39;ve been working on =
my own hybrid 2D approach instead, with good results. The CPU was indeed fa=
ster for fills and console scrolling, while the GPU performed better for la=
rge framebuffer copies.</p><p>
</p><p>Ty,=C2=A0</p><p>Gabriel</p></div>
</blockquote></div>

--000000000000663bce0660633c60--
