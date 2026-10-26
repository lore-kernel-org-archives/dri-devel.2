Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAE0606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mWT0F+4M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D301C10F334;
	Tue, 27 Oct 2026 09:32:05 +0000 (UTC)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C68AF10ED15
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 09:28:28 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-6fe4372c5f3so1985109eaf.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 02:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793006908; cv=none;
 d=google.com; s=arc-20260327;
 b=nDice6rmzb1cahMlz24L7n7MvVdKDOjroVBHNoMBz+JpdSuKpTQrni9uMAghkCx3bI
 Ikl+X3gzSYtg6ljl4J7Q0mdbOiM3XlL3z0+1AoTiWRTWjrKB2dogVE2rUY4OkFnEKVHk
 LmVLeh0F9eTNaZcsUP9ZowtZJsDvDsUGb4Pug1rAeYeMBp4sYPZhmUBaLhEyay6pnpsl
 5gVxnwZ2U1oJ7WBlrvlcFZs1e0nIViBE+60rJ58mfUOaIXR5N0L43pyih0dQrBi+dcst
 3iC4/1BVsZ+TigqeApqsxVsSsSMx5xM/gy8FLec5iNblHwwFuHknE62u32KTpb1QzhUv
 dE2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F1xftn2ZvPwDxNIeM5ddTo25mlnOFwkbcYBiWLFaU5c=;
 fh=mNOC3dXW7SLcALZoHx4HT4QlBzW4grmni6p857TmxWc=;
 b=UdrT2F/9uy44r7pP7gIb6IZXvLg0eMwr34pbJ2LlDtP5Gk88vtvO7rNGBEg63Rnr4u
 dzl3WA1/tPlVY9NAbInKW7xX+8CqXKQ+X/Ng2FcoTjMx4Shor5mOlNRd+uob9sQ0KXn+
 9x2JVu+8Pt58QTHKulCHLh2FqOjBPhTGRLII9O7u0SyKFRczNcC/2LndQ3o+nuuBrQXl
 4ddnTOdSuN0cpaGm7cfhXm4PWL62nQe2re6R5hsdQS6iI6gHUwoC94HagrMyBe8C0n1K
 y7WTWL98MIb9PSBmsaF5n0WxQ4FVEWZmnN1OdlcmirbRMX8NpGBJptiV57QYrH/FhF3E
 qCQg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793006908; x=1793611708; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F1xftn2ZvPwDxNIeM5ddTo25mlnOFwkbcYBiWLFaU5c=;
 b=mWT0F+4MQRF+6GfqTw20DfvzNF8TwhRxFgY59dQd892/EZB0dgYOQSrrNb1ejoIYeO
 taAi5S5gvr10mMibb4kethwNqQIyu7At5J7YTGV4XHaiZQ3R5Rubj3s2l/mow5If5j9Z
 utaN5wYgl1u5sMLgvF/HynnYO09JetItPORmTS7OllgzCsk9tVASDLMLuYluY9Ce47UW
 GvJUq/sdFMKHbkl5sd64pByUEpMHFoKNOlBXrlkzAcSM0fE8mLi1PW3Y3ugZoEItCqy+
 /aG7XuL7y63uMiBuU1trl+effBavBBThP+iu+y0cpsVIQ63zGObyDg4P/SRM9rwuDU7F
 8WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793006908; x=1793611708;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F1xftn2ZvPwDxNIeM5ddTo25mlnOFwkbcYBiWLFaU5c=;
 b=hhFMjr5jg9kgLrrtA0PbeVYvFhDVO9MgxrjHpJGZBKv+RH2ywGY1PUDpqQ5L5DzynF
 uCIRE8tncatHSH5xmMsuyqqEgDi5mNtVADRsud+tK7NUZtP/ewmKDmM1meRkoOUvBFPg
 CyOKqizS5keWtF8cpiTW4MJZUf71gkb/88W0eekemjGjhLdQACE2qv299UQIY7iT72z5
 uvkgka8EiEHJQ5vvZiNLs70Ek0FqVWxpEDg6iN07QXv1QpbcUZtohg9zW4ykWLeCsulz
 Ju3P3g2ocQdqX8x9TXrwwx0n6xU6UBdtuhyjsfkUnlpI4qsOoonR3UhTkYnztSJLTFLt
 O2yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzPnXaUmcN872HbxAfXW+RtT9bI+kGqheL6W3OWDuJpa1ya6zXiSU4CrubX+qADt8xUIquiWPM+5A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIHb4Ou+aBqPVy/Qb/+E0bPW31Uu0FL/ZCTiwzEYloUZg4IKJ7k
 4HKyHMSfGV+51gbJQjsWysFklLIXEuhMBiIu3loHs2iAQt2cGm7a3k7Gum+sTQ7D3eIaYjSb+nY
 VD+5umtAWSoX21q460nn50aa2xzLEG9MjSHpc
X-Gm-Gg: AYBFou31OOxeqX7LL3Q/Ydzzc8MAvzPOSD8UJRomeqAT80kv6olEItQMih4pTfZKc4F
 hPe2FB0xa43YLbZH2ohOKz6R0IW0lwhbIxg/gNxvQbLiqob4zKIXyBmN8/aTe5tqnrRDH1vMLUe
 OsRYstdnPU+CmH/g+CiijNhOa3MCTejJNuIYfweJ0ktknbUKT78YYNeZFCinknoOZ5ARKoWMaGX
 oYaywYCkeOG/JLv7/jHFiAM3VdjdmHJjk+6lk9jrMj3yeQq/H8hHXWHpevTaMsf3AzYpUdbw+Ah
 a0d1S4Lo8EaSVmpSkfgJgayjT+Ztn8C0lkNosHxk6tmfcsBQDZERiCNmZkSLfW0uo65lnCOnaJP
 W6aTUTfSA0a0n/gT18h33Tege3WtIC60FQpdAc75Vv0ykPjBd82P4DaYiqMn+OzlAGYFpNqI=
X-Received: by 2002:a05:6820:a502:10b0:6f5:467a:aedb with SMTP id
 006d021491bc7-70ba0b235acmr2055206eaf.6.1793006908009; Mon, 26 Oct 2026
 02:28:28 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026044523.18516-1-himanshu.bakshi478@gmail.com>
 <at8bT7NCQb9XvGoS@ashevche-desk.local>
In-Reply-To: <at8bT7NCQb9XvGoS@ashevche-desk.local>
From: Himanshu Bakshi <himanshu.bakshi478@gmail.com>
Date: Mon, 26 Oct 2026 14:58:15 +0530
X-Gm-Features: AclHuK-u4NA6gcabskiGpw2QnFryhGCL2JKlsnkWAJ3_x92psReB-EPZC8UQQiw
Message-ID: <CAGLmz9LqD50zU-BGhaVQagJWTtGiEZ3ucDxbSVSbnd5_=6Y_dw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: fbtft: Fix line length warning
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: andy@kernel.org, gregkh@linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 27 Oct 2026 09:31:59 +0000
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 2:50=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Where is the changelog?
> Why do you think this patch is anyhow useful (based on the previous discu=
ssion
> and your observations)?

Based on the discussion with Dan Carpenter (error27@gmail.com)
It was decided that since this macro is not being used throughout
the whole kernel, the macro itself be deleted since it has the
replacement being used.
