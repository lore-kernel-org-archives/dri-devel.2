Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07AEC44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:11:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8DB10E802;
	Mon, 13 Jul 2026 07:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nizZlEdb";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695B110E336
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 12:13:19 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-38096590070so318983a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 05:13:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783771999; cv=none;
 d=google.com; s=arc-20260327;
 b=T+/2fhkPvvMymMrkHUpKrl+v2tgyvkLsR+X/aoClO2EXIRsinWx3v0XfJ0ac7fsEOR
 Pt0wG2LeREJfHVr7sW0VPkTwN1S+piEftJipoUWOKiuqvtfoBij7LK5mEvelI3SaWy6U
 J9tdorzBKtVgdTJBKJgwxgHhJrfAcMc1aXPzr9z1scdPUGKkb26DfEsco3nRUBEGJEWx
 SO/uE5UbNighLy06IVJe1nuxnt/MrewxLgyXEkndS2lghdvDEiZP9vuzs4rhmKEi2bto
 Ge/FKrUkBIkCarnH5ieVVoo2MP1F3CGThv4bGEaNKDM+643BIESeGmDo+IOxN61qdtUN
 Mvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
 fh=EdJIm4OYkdOVFUZwDxwz+k9pIuxwGMQjmTIHRyGrhkI=;
 b=EhXH6DAqTS1CZdwmjMC+ANKRGiEzU0VikMmcTGKYD3R6yeGWIEVQpVoU4eSkha7Bga
 lxC2qNHFfGs9wSEOverev5WfJW2PcB0r8NYs9tmdyVJpInlGsjJkfR8x5Y6i90kOUmuS
 9Ez4woYBOCi4jxzG1DCW84O85nJIDwGnlclC77hiJ3Q3A+hvEtyZVhzBT3tpDaqMDFoF
 L/PqwGBuhIYCGgK0z0eLqlKPAWJn2mo5jBA+o6xGWTyeuctonSi7PQLZhBbdggTaKmzJ
 f9ome596lToYrwiqIDpt/mwOZIiA82cMt+/l9osxw5NC3mnLkulu8XFEWnvrsLoF7Rnd
 /CJA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783771999; x=1784376799; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
 b=nizZlEdber9CHUon31NlLH9MrMlRNJR2uNz9LP6oAIP0DUjMopCXgcgG4lJyA1306c
 hE943bG6CDvLMg6c0gUJW9FVICQGuxp+AzNPn7jw/PLx/bd1DK/JOj3c6M2pGm0PdJcx
 FKibgNhTy9MGJI3p9XVTg68IBKHTD67/5ODVBRTXgt+7i355T6z2mwyUGU5NjL3HL8B8
 B0oJYj51sfkRRnMxBrDjap/KKCSKBiGLZxI3oGR5HVx7YKrb53EQdyFBIdW8HGixem9V
 v4Z14Go4Yf8zGII/iiqa2l5kQqyHfcuZ0UenYqMnTpbLO7qD+RFZ5EFRi85tLzB5bC5D
 2HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783771999; x=1784376799;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=80vo3JIjnCsKn8zo158HX4vkfRXd32w7uPzzJAtLaF0=;
 b=bR+ObobYZjJuPbd2ePzYwWqVxePWars9/N/1Ih4WNz7DGP6D1A6FDFD/KPOtKpjizu
 b835gXGwaUMwzqpFlFleuLjFCGc9hSketh3ngX82495hwRdb71Hsbv10ZixHI6Jmh/mc
 4bENK9HBm7/Oar/VklIftw/PSGqeLHMAvnPIEIhrL7XHfFOf27AZmuFIgH4ZaPI+3uNn
 6nTGkyMtbj5OO8LuQJKOAw2NpcsHaIhNoopgi5HWklb4iK5KufglaHV4eMQzDVZXBCGg
 NgaLEXOzH2/+DkAkdxOwmp9BCxDoWtR6zDPBldBAxXAu3I3XZc8SCljqQYRNWnFNV5Mj
 7Z+g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoM3rAZvxaL6Apx1ZXoIMK5naFmGWSGVV3m2V3Pi2bC50zGPj96nnfLuQNp9ivUtCMRahLOuCUPdVg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxET2xkePjGsGYj5TNBqx8sHiINlO1Zk3GphJvySwcm2nJdaQ/N
 PuxZPqUdDNr7hXyP3hKw2GMV8Gl3zfA21cCsmYxWh4R0qtiBSVN2OhtqAIVPXa3t1Asr28TgE4N
 kJCDeBiiSVi4EDewroqWEaDbhGQf3cUE=
X-Gm-Gg: AfdE7ckYmrZiS4ErqD7Du6/HKvj6UKRCdnGnyGPRWyQIbAQeZlMQkQ0VqGrDDAlHt8H
 JXWiaPLCGNjHsRCX6vB5BJ1EeAgTeEjSnB8YTli1VZMm1ZvbExd3oZJmeUlMFHE/wUGpH8jE0O1
 B2q1t87hqeqCDSUKoynMoHa5+YBtt8CDeRIKthqYSzz3YG4plnB9H8HKcbHO1+pBWCblk1KTk6H
 2miJSRuavHdRbCbFnNBUyF9xxThFDxyI3O3vSe3mayHdbuVPcTxj9Wmk5fJJkJjjsqDWxSB/PZL
 0rzOU44KP7IyBCWHKGDIR+VvQ3LE9ugN9iJjNhTLgpK68zQhvasRI56FIj1dukYSPej8jbVoIwV
 yx83LV0DjHZHl
X-Received: by 2002:a17:90b:4984:b0:380:9cd1:d985 with SMTP id
 98e67ed59e1d1-38dc7c111a8mr1909664a91.6.1783771998816; Sat, 11 Jul 2026
 05:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260706061928.66713-1-byungchul@sk.com>
 <20260706061928.66713-40-byungchul@sk.com>
In-Reply-To: <20260706061928.66713-40-byungchul@sk.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 11 Jul 2026 14:13:05 +0200
X-Gm-Features: AUfX_mwWK6GqFCLIKCx9ivosmcno3i0b64L6R15FyNFXSSwj0HKdZlNefQKWcgc
Message-ID: <CANiq72kEo=bGcHNaSA9JZhv4iuE+YDvu0kN+Z7aopVp3=2C+Wg@mail.gmail.com>
Subject: Re: [PATCH v19 39/40] rust: completion: Add __rust_helper to
 rust_helper_wait_for_completion()
To: Byungchul Park <byungchul@sk.com>, Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com, 
 kernel_team@skhynix.com, torvalds@linux-foundation.org, 
 damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org, 
 adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com, 
 peterz@infradead.org, will@kernel.org, tglx@linutronix.de, 
 rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org, 
 daniel.vetter@ffwll.ch, duyuyang@gmail.com, johannes.berg@intel.com, 
 tj@kernel.org, tytso@mit.edu, willy@infradead.org, david@fromorbit.com, 
 amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com, 
 linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org, 
 minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com, sj@kernel.org, 
 jglisse@redhat.com, dennis@kernel.org, cl@linux.com, penberg@kernel.org, 
 rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org, 
 linux-block@vger.kernel.org, josef@toxicpanda.com, 
 linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org, 
 dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org, 
 dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com, 
 melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com, 
 chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com, boqun.feng@gmail.com, 
 longman@redhat.com, yunseong.kim@ericsson.com, ysk@kzalloc.com, 
 yeoreum.yun@arm.com, netdev@vger.kernel.org, matthew.brost@intel.com, 
 her0gyugyu@gmail.com, corbet@lwn.net, catalin.marinas@arm.com, bp@alien8.de, 
 x86@kernel.org, hpa@zytor.com, luto@kernel.org, sumit.semwal@linaro.org, 
 gustavo@padovan.org, christian.koenig@amd.com, andi.shyti@kernel.org, 
 arnd@arndb.de, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
 rppt@kernel.org, surenb@google.com, mcgrof@kernel.org, petr.pavlu@suse.com, 
 da.gomez@kernel.org, samitolvanen@google.com, paulmck@kernel.org, 
 frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com, 
 josh@joshtriplett.org, urezki@gmail.com, mathieu.desnoyers@efficios.com, 
 jiangshanlai@gmail.com, qiang.zhang@linux.dev, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
 mgorman@suse.de, vschneid@redhat.com, chuck.lever@oracle.com, neil@brown.name, 
 okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, trondmy@kernel.org, 
 anna@kernel.org, kees@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org, 
 mark.rutland@arm.com, ada.coupriediaz@arm.com, kristina.martsenko@arm.com, 
 wangkefeng.wang@huawei.com, broonie@kernel.org, kevin.brodsky@arm.com, 
 dwmw@amazon.co.uk, shakeel.butt@linux.dev, ast@kernel.org, ziy@nvidia.com, 
 yuzhao@google.com, baolin.wang@linux.alibaba.com, usamaarif642@gmail.com, 
 joel.granados@kernel.org, richard.weiyang@gmail.com, geert+renesas@glider.be, 
 tim.c.chen@linux.intel.com, linux@treblig.org, 
 alexander.shishkin@linux.intel.com, lillian@star-ark.net, 
 chenhuacai@kernel.org, francesco@valla.it, guoweikang.kernel@gmail.com, 
 link@vivo.com, jpoimboe@kernel.org, masahiroy@kernel.org, brauner@kernel.org, 
 thomas.weissschuh@linutronix.de, oleg@redhat.com, mjguzik@gmail.com, 
 andrii@kernel.org, wangfushuai@baidu.com, linux-doc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-i2c@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 rcu@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 2407018371@qq.com, dakr@kernel.org, 
 neilb@ownmail.net, bagasdotme@gmail.com, wsa+renesas@sang-engineering.com, 
 dave.hansen@intel.com, geert@linux-m68k.org, ojeda@kernel.org, 
 alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, lossin@kernel.org, 
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
 rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 13 Jul 2026 07:10:39 +0000
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

On Mon, Jul 6, 2026 at 8:22=E2=80=AFAM Byungchul Park <byungchul@sk.com> wr=
ote:
>
> This is needed to inline these helpers into Rust code, which is required
> for DEPT to play with wait_for_completion().
>
> Signed-off-by: Byungchul Park <byungchul@sk.com>

Apart from what Gary said -- why did you need to do this in a separate
patch in the same series?

Cheers,
Miguel
