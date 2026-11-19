Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B920B606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 02:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pLwWXaVE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 291E910E55A;
	Thu, 19 Nov 2026 02:06:58 +0000 (UTC)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E8F410EC3F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:06:51 +0000 (UTC)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-679aeeddc6bso1541554d50.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:06:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795054010; cv=none;
 d=google.com; s=arc-20260327;
 b=c+EIQH+Vg16l6pgeu66xIaWlo+oHrO1i6VhMgQHNKK/NOojdmU979y6OrgvOHhCnFq
 DEn0IQPVBc8sAcpmYBK/yfk43q/2G2HKOARuTyj3yyRl8ct0CN1obpOtVj23XWbQJ+PT
 HXVVgPdhf+qyosF49drCCbU6jJP0EtdXXr2hb1I7DmkxHUdu8/CdNiRozN9hcrYo+QCn
 RUSBMcbDaLXz6/hhNei2Mh+TMwpAJiY5AZUxDk6eA6MQ520VqS+Sa0ZpohjcDo6R/zy6
 oQv8U/48UARcPlYjs8Tw4jSv/b+/AUE2hkup3xvzMaAUwIzP6uX44hlPqUx4q9WI695p
 Nxww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NCO/dWkf50AZTb5CSt4Ge8e/B88cMhBm74UQ+F1PYOU=;
 fh=OsDLTjTsrRtZAqcw+XpfKPpSeh4VY/7W9PQ3ryiAqlg=;
 b=Fy48q1aIf0/2SMaaSCd3V7M8ZX9mlqFI6QRCbHOEapkrXH+vTj2OjW9ZjuqCuQbaVv
 f3hqDyc0fY9/TPs6oAuoz1Gjusi+Qy2yzy/kWRR4ZicaiyrFB+Tp4kaBwMRtQahaX2nq
 itWQIZ8jFtO0+QCn+BS3NdYQt/iNtFGSxjjjyH5Z0ZH5mWtXo9T30DE1A6pmrCa9D/8F
 J/7J9UX8Xe7MWyQNcVJe3/yzHp3rWTCjTEVeozLh1zI4piXGG6lnKNhOQXbW7lOZrENJ
 2eXqzlzXKtLbLGBqYFfYFtJE9zA+UQVG0R7llbygX2AokQAuepfqLnxICM7pUeD0NX/L
 hGhw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795054010; x=1795658810; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NCO/dWkf50AZTb5CSt4Ge8e/B88cMhBm74UQ+F1PYOU=;
 b=pLwWXaVEhCq0k0ig5ZWD9ZJ6SEuNu7F+WbcS9par0Thy11eIIzfUzINhDqDPxHud8V
 r24WwEzc34/kSNyVdT95+5oF1esd9A9qXftWds9+jcZf+wGnPk6qKKYT5liu/yM4h5NH
 b9QfmOa+iU1tJiO8+tlM8dPGoAG+sNt3T++wuA5x/Q+zEmuLbhAPWuGuPrE45bovr8Ef
 kfGjC8tdwJRirHpXCm60kzw2Ws9dRQsItX/cl+VMIKBFSsyOEqCI8Hlftnx39dN6lTwS
 70ccjD8ClGlNh1A/b867z04NzWvwk3DmreXeGm4eP8DrQ7n45X6V8sFm+ClbZZqhXN+a
 4c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795054010; x=1795658810;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NCO/dWkf50AZTb5CSt4Ge8e/B88cMhBm74UQ+F1PYOU=;
 b=c2bBFEicUx/NL+XANNjYnFYL7Gh53NsvWU6TfRmERrnDAdOsqnLOiRiU+/iAceStcE
 HPqdMcDNWjE6gEOvWF6ye857C8r7iuYZO59wzprVzFJYU9c2LCFBzAotdcTk6dWExNYL
 bgHx105W7kk08UDTtR5E50N5TXgw02OTq7Ws4o5D8g915105nq/kvdza75DMzehsSBNi
 SLwC92l8Z3Pq9qN/Ycpwtp7cci+TWh/abI+igA8P2RYe2Nf6a5DNATTTcsVJeKZzyKfE
 C7+fTb7LqCUR8m0uoWT7qAZVXGnqE9NfFPdmrv5FJAzovgc8pAFA2rMt05Ftzz/KJsqh
 aXcQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGBBMXLIlqbDRCjrExahciyKNcH2BrFJgpvD0t2RBHa8ZrHkJ4aVo/BfOsEcoG7o2IT35R2SH5E2N8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9yXzjN1tkF0gacLfm5Q6Gr5sUK+8jJ8QLpj9wjFG4FrtdV6tiW
 IU93jrXIZEaHzOQnsTUT6o/dzSTMHQx/wcfEg/dNL09F3MNmi1X/i87ioOqfKXwpv+AqH60sgHX
 5XBmwuvgBjAvMQLrSOtcYAJs1oEtHZAo=
X-Gm-Gg: AZFdTZdaCxlqZCMjsoCdpT83o3GpR2hGyqhEYdiRRw+P2CzMe7gvmbcM+aG61lCeKxd
 FlMvHkx2Cc3Jh3ObK/M1XjVwujiOPBMaUumFFcYsjhnELBuF4aK9tivgW65DolY1EPr5pz7xw9X
 zSEG2zQtP1eLLS2z7pMrPqcECwI60wrMXYmNBT7KZDFMYpTYFnOtwLO0N9kHSnG2tdITLTwgHwQ
 QkoNEcknofhil1s8/dg+V6s1No7Vkjr+QlLZ5+mv0ojcpgoabfzjz+esnC2/T5kWmMlSXZo20Pa
 0p6mXN5xggq8UXccIuQIHoJ4a88tssINl8lNSRZungyaXwNhirL+fRFrwHu1yvZ7lmd4L59IJE2
 JloCU7JvQgj5iBAlM4J1P9uIUL2oyHlH56izdIWoJ+91QENGvtyKyBjZmA5k=
X-Received: by 2002:a05:690c:799:b0:8b4:ef8d:88a9 with SMTP id
 00721157ae682-8b4febd6644mr15765197b3.12.1795054010454; Wed, 18 Nov 2026
 18:06:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261101073700.1261966-1-gye976@gmail.com>
 <179490829262.50223.600134266125251477.b4-ty@b4>
In-Reply-To: <179490829262.50223.600134266125251477.b4-ty@b4>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Thu, 19 Nov 2026 11:06:39 +0900
X-Gm-Features: AclHuK95wjyOSL3USWJSLiddXMHlAMqUxucxyJ8PocUeHdqhrsCSx-8gPf2yb_w
Message-ID: <CAKbEzntg_+A6rERcgBmYNwDEz0_Ta6F_N8YGQP1uH1ETNgYiUg@mail.gmail.com>
Subject: Re: [PATCH v2] accel/rocket: Fix drm_mm UAF on close vs in-flight job
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Thanks!
(Re-adding the lists)

On Tue, Nov 17, 2026 at 10:05=E2=80=AFPM Tomeu Vizoso <tomeu@tomeuvizoso.ne=
t> wrote:
>
>
> On Sun, 01 Nov 2026 16:37:00 +0900, Gyeyoung Baek wrote:
> > The drm_mm and its mutex live in rocket_file_priv, which
> > rocket_postclose() frees on fd close.  But a BO held by an
> > in-flight job is only freed after close, from the drm_sched
> > free_job worker, and its destructor then accesses the already
> > freed drm_mm and mutex.
> >
> >   BUG: KASAN: slab-use-after-free in __mutex_trylock_common+0x90/0x1e8
> >   Workqueue: <NPU>.npu drm_sched_free_job_work [gpu_sched]
> >   Call trace:
> >     __mutex_lock
> >     rocket_gem_bo_free
> >     rocket_job_cleanup
> >     rocket_job_free
> >     drm_sched_free_job_work [gpu_sched]
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] accel/rocket: Fix drm_mm UAF on close vs in-flight job
>       commit: c3fe8795ecd844d0bf76102217bec01cce01b715
>
> Best regards,
> --
> Tomeu Vizoso <tomeu@tomeuvizoso.net>



--
Thanks,
Gyeyoung
