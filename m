Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45E14F33804
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 07:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D59510E34C;
	Tue, 17 Mar 2026 07:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eNcBzaHS";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E1310E356
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 07:17:41 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-127148c2112so215731c88.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 00:17:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773731860; cv=none;
 d=google.com; s=arc-20240605;
 b=Qcv3vIHFYKBS9tKk0k51CdXtJxWWlyaqiZ4cAPt1YVjuEfImPLh0kncbqokQFM2322
 kKJnAtbyjXyHdw8sn9T3g37RifTUq1B1RfAiAFdS570Y5WyB1kMzqr/m+7WSQaI9yq4Z
 bsGLuwXE2db1YRIDyAgvaxGpDkro3vqV9EYQDIis79ttX1LXLf4yfIU8D2kObeyRF1o+
 uE6TNX1JIWsivNXrS7+P2p677ENbdOd5sx6xjxJWRvmZoTP+vP7GdIvf9V+X966pN7cX
 wZf0YP7y7WODfGnQOj18YWG2tnopscOk1/YgEv2xTLw/+UAtyUoWBlS2LDvpV/4O1D+p
 5ACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JRjFojoQ+ay0ef4If4kUCgywrpzkrXMMzGRlp08g/yk=;
 fh=RWyMKcPXBrWwvkWa8ZxBoWoZthXiRvCfhTLiZm3omnE=;
 b=MsS/PAqVScFXah7CUJ7LMGuZbxP6NXPGZ2LeuHut1O/WLu1f/dBm4WDEc2CLJVNQ9h
 6nJ3kx5H9/qinVf0J6Tu7Gk5/QqGMqdlNECnn4vKnodZJEBUmx6XPT3kVpaf1w4PdAgt
 chpIjB1MoflPJxvC+XDyJ1axVhN4aWL9XJLOD9ZsmcTq78g3FwTKPsnwyPST/3d2+CNn
 2+se38GWtVEiS4667SRQuc4fBmQUVDqAZKIk4cD+2vODy2IcKz3/0CK9WTHukPM4/XIY
 2HObf4zSK3T6+NHoCLzz+9g66PsMvYAQ+fpiCM06mC+3+Y4Kmt9SBd3+vkT/bXlPZV69
 jK1Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773731860; x=1774336660; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JRjFojoQ+ay0ef4If4kUCgywrpzkrXMMzGRlp08g/yk=;
 b=eNcBzaHSXi12uck3uK7rd1qtEWdT1GBouy444mwDFT7j9oAPJl2vpAseB0cOVhA42x
 +9gmsGnqLkyZhtFdXEvmu7yOLCxdkTSCQPY1ZYVrgTgzAIL9I3GtrBTRn0QE1cHVbMKV
 n1xN7IdAuAqeAIdEbIi5PC7zvh630eaW+IJ8MGITiylQvoRGmxZEftq7ZMPTR8tym57x
 u3ufufPoSMGTArwXNQD0NZjaG9iP6PdLkYdeGTLIgONYR9y7Be7HhB3+CyQJWrNrXU9E
 cofOcI2mQP71B+duyYnsKHNhJkNKU/xcKpiVkqc1UwYpJcOvKVMyFl4qGOqVkQzsgcpV
 XSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773731860; x=1774336660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JRjFojoQ+ay0ef4If4kUCgywrpzkrXMMzGRlp08g/yk=;
 b=h3skfU5f9ApTCjF20WcJXBqJo+4Xwl18DsFwjkoNPANnGnb3j1Qsv1YI6p248n+qcZ
 J8I9fMUm+2MZqnQRAHprPRS6oT15sXIBXyb9ZPEuKByqdEN33P70JCOfdPlofQPZQAes
 /o7PEtV347d0qqfc/EFyy3SgdinY7b8prD77trYRLxq6viWMA/+lLaFCYPKlp/h3DSZK
 mXZaxCLkYlwIz41sNYwMpy1kPqsMOt8a94BV/LpZ3NDl9rG+K6uxocLjCPrvATjmCZuA
 oLtygG1Cv1yvNNGjU6nM3xmAkVGIb8muXAqjfXpJ8EmzhiBBDYKGXOalEteEG1ImR7G/
 c/ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaUbKbVQUHUo5WHRqd3MGhEk6KmQKnxlTWxiVEsbaRolDKOofqXKsZSWD9vKpomuXkiWLy9CgPP1U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySxew1OCC4R5CfYeAlf4x2tEp29uelonBxUiSTNE4ZckX1fb0g
 km/qMTYh4hRaiKhARPwUQ11lqZ8LiSDnGnyEhO0SRjkFL27BtrvxHFCz5FkYnXd6cEFt7y/oZkC
 mBv/48IYg8IeYhogi3dhZbbncuCMAP7c=
X-Gm-Gg: ATEYQzz16h3CrnyrlvX694ZvBlUJ4ayhtawAoSEskdCKo6oG19jXFD9gzHvSkMRAfcV
 i58f1iJr6ngyw6s6l2Xk2ge+azMN3iXML/PZx5JrQl6F7NfA9YJkrin2YzSBne8vIuZJipGMp8+
 Rt6E0AS/3A3LBBePAHQWOONh1gItvGb9woFXgJujGitfrIURZU5eopktquzWyP5SUzKzaUuzF/B
 ZEsn2VrTOoLQlqAReEQl0akccb1k9VGolIW2uGZ3ZP+IGwCt26/m9ItimgKzSL0E4+Hxd7LD91b
 ntoB09aBUpZLOU0v7qwC3l7MweaklppSmgeKVa9UmgWn8Y/pq1u0UYLSCV3BYGsmoJXNU13Hfkh
 HLLaYnU89tZh1frOTDb92vsY=
X-Received: by 2002:a05:693c:2b17:b0:2be:6e6:e479 with SMTP id
 5a478bee46e88-2bea539710emr3854426eec.2.1773731860241; Tue, 17 Mar 2026
 00:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <7A8108C7-7CF0-4EA4-95ED-8003502DC35A@collabora.com>
 <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
In-Reply-To: <abjqfXERS6Xk4FAQ@lstrano-desk.jf.intel.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 17 Mar 2026 08:17:27 +0100
X-Gm-Features: AaiRm53oFtZ4LcqzAMb48PPD1CPMNBFJZZjv3_kfdhsd5ZRjk5fQUoV8uzzbJKY
Message-ID: <CANiq72=Y2g_5=iEzU1L07pMPYD+wVapJXpp9rvYXEzCKEs59Zw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
To: Matthew Brost <matthew.brost@intel.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
 Jeffrey Vander Stoep <jeffv@google.com>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Stone <daniels@collabora.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 John Hubbard <jhubbard@nvidia.com>, shashanks@nvidia.com, jajones@nvidia.com, 
 Eliot Courtney <ecourtney@nvidia.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Mar 17, 2026 at 6:46=E2=80=AFAM Matthew Brost <matthew.brost@intel.=
com> wrote:
>
> You can do RAII in C - see cleanup.h. Clear object lifetimes and
> ownership are what is important. Disciplined coding is the only to do
> this regardless of language. RAII doesn't help with help with bad object
> models / ownership / lifetime models either.

"Ownership", "lifetimes" and being "disciplined" *is* what Rust helps
with. That is the whole point (even if there are other advantages).

Yes, the cleanup attribute is nice, but even the whole `CLASS` thing
is meant to simplify code. Simplifying code does reduce bugs in
general, but it doesn't solve anything fundamental. Even if we had C++
and full-fledged smart pointers and so on, it doesn't improve
meaningfully the situation -- one can still mess things up very easily
with them.

And yes, sanitizers and lockdep and runtime solutions that require to
trigger paths are amazing, but not anywhere close to enforcing
something statically.

The fact that `unsafe` exists doesn't mean "Rust doesn't solve
anything". Quite the opposite: the goal is to provide safe
abstractions where possible, i.e. we minimize the need for `unsafe`.
And for the cases where there is no other way around it, the toolchain
will force you to write an explanation for your `unsafe` usage. Then
maintainers and reviewers will have to agree with your argument for
it.

In particular, it is not something that gets routinely (and
implicitly) used every second line like we do in C.

Cheers,
Miguel
