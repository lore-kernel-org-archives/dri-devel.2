Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A99606A335
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s5+dOIy0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56B5E10E5C4;
	Sun, 22 Nov 2026 13:09:42 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB3810E5C4
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 13:09:36 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6ba380cd8dbso3044968a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 05:09:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795352974; cv=none;
 d=google.com; s=arc-20260327;
 b=KURRYw2UIQ/miRUmBjVo41Iyq5iKZYoECNvs783BXlCQSbNzq36bADibNY+KdMEllz
 lsHGmKS/X+vMvZeHjGGYrycyQGi3kvn9Qp7J1ZOcrAe2AnPZLnNm2p/9PPB7VnvhDp1p
 2gl7h14RFWLv+PMOepojlycClAirNLkAV+/4NgwHeUi8/oI7hOc4RoAOf9RNC0TGRCZ5
 Lbafe+c+OYVI9iJXKOk7rICzCR02tj/fA/QcyteKnRohXVC4jheQ10k15Rv6lE+/xOZc
 g1wAwM/5oZc3h8+QR/XwHgTUHg3p4YIreaaR8iv4LHcZevE88EYOeTq5JlncaCaM5u48
 jaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Vf0F97qgmGw6KuAljeaJFgTLPZKqENLieaFQ+i06+hc=;
 fh=jD40jQRuD5FM5W3Of8Z4Xkgf4rRu6tCAKTIZ24J5qDs=;
 b=dhG0KX7s7NzDv2Koe3qHPltULMZYk27cGf2LTSVSsJZ6Jfrn0TldcnHkbG3McIVzMn
 iexpAmvL007KRV0ZqsftbbpI494hsOdyrbVnHF+INBIbdS9L9x0QF86AOx1zlNViWr1W
 y7ZzeZlVh8pXlbu5vlsq+TTrjduNt2zUrQYwfljWD9uot0vuKme+8oICn0hEdv/tNidZ
 Co+GAIJbdALu82Z5ifKG/9JbqyVaETdMMm8/2aGrLBvFLNoku/HUVXPVUJpDg+EXcX5m
 EBpD9oHpqPoFTBmDLEmpl/AOA+mONa2u2oL+9nDsNAGmKzVBBvD4xE1nynfM56fiLQPA
 UVpQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795352974; x=1795957774; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Vf0F97qgmGw6KuAljeaJFgTLPZKqENLieaFQ+i06+hc=;
 b=s5+dOIy0OM6WhZapk+mu1TdY6uP3RHDzX0xC4Ax0h+hTwyuHbaEJHuJSbNW+H5VKrX
 rGPtLEuhZxn+CCWTQl1h4y78aF3cO8ZBMdhD6Opu+Sl8bwVc2dFPl+QO+FLqUmcjxs8r
 FANdO1t+qd26pNC+krTEdXJtFfeHoEA+Of0WH4+joarAYQq2+1o+L7PsVQ8n1cJKw2/Y
 Q80tG4ZX/HVTaK9bEzuY2GyfPwia7bmFeRubpKpzw4Fdgt9DKgsQzJo3TsxpEEzXK9aX
 YRDE0GcyCEOdSh1RPfU24QUcH0yJtscqFgSooMxVxtONL9cNRHs/6zXzSLAcL+ztLi8f
 2bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795352974; x=1795957774;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Vf0F97qgmGw6KuAljeaJFgTLPZKqENLieaFQ+i06+hc=;
 b=wOPiLliJdQe947tw3i+nAzOZpZS+lxqbT6t4vA1fOB9rJ04kS4Xpkew3eHnZ14MSHk
 mVBITvuS2YI3dAuRY1KRHCd6aZQ9Dqr+Ww+UYbRoUDloOh8JbvcTmkXHvq5UuVKO7esQ
 Y72B20EhLxEK6+0wOXCxBzkouP4lNEQUN7t4CIwNH5GwqFhG//A3EuGErYLxgllR/ug7
 mHZgP6Gd1Nf7Vb9LlEbta8+csqYFy8xU27qDeJmAhkGbS7BSnPuaSq4ZEYQdCdEt1tej
 DyskwQA5frJfRoZq7HLAkUcFWNDhdxwsgWzDnCWXuz5BtZIVtBntxl8RyR7v3vimRbio
 xw+w==
X-Forwarded-Encrypted: i=1;
 AL+hErEk6pBQqagDGrBfjM5ggf8sJy9W9YhqG0HlfyHjlEIAVcDtPEWQDD2ioulRVEYdzKBjrzSecRtG+IA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+dM2c9A1dY0qoM+NlxtAVBYo0hq95z7v5Huh3hh1rLObK2G1wz
 8doeb9Ga1BcTt57K6+gu+cipK4T6tmsFKPtR+j6tFAQooKrUY+03YV/KZ71RJ7L7D9es9Y9bKIC
 rEEYD8FGO3gip7MvKP+HRI0O273fzFys=
X-Gm-Gg: AZFdTZcXCGWt5oC4tn17TWLbMcVXjMMiCuWLG6RvxUlPGHzsxnyYIfTn5GbP8ipd301
 60lHXv8LBYaiaonxet4M84M6Ds7ZwW6RznhWX2IbgDOE0Gji0C4u4iqO1Q2KH3o+f/DgosXjTXx
 wL8+yT+9CmvNIVX0wxaAsII0+Uy3JIAuKB84PaGXRWa/bEyD6fyq1DXlRLoCvYz+fV+pUEAWun5
 KzB1zfU7YLMIoOF4IgMS9/ezvnCsHoWmIpbGxM+VYSU+nGOS0BFXsHLMg2CHioszKJ8dGQLz2Pl
 /u8DE9/lmdVk3hPaxteFfccb9sbuxCrV+AGy2rZN1qY+mlltqhodXaz5e4pfzMmQvpRqdB+iSE6
 mZ/AyhH5W5negQfnjxlfqgGCJutvxrYKG9TSX2UPx1kjo/7C0JgRJhvapxMZv9hwMaHMLNg==
X-Received: by 2002:a05:6402:454d:b0:6ba:139c:47b2 with SMTP id
 4fb4d7f45d1cf-6ba37eb1950mr5077385a12.25.1795352974368; Sun, 22 Nov 2026
 05:09:34 -0800 (PST)
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
In-Reply-To: <CAFGNeahDm=GM8J=C0hmVBN5HS0thoMJZNVW4srW6WoAFHaxNdQ@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Sun, 22 Nov 2026 10:09:21 -0300
X-Gm-Features: Aa3M54qJ7oVvMK14_-OzUV_Wyfmg6jk8z1UpaT01ZsUBbpiDZp4JY7EZhSWRwl0
Message-ID: <CAFGNeajVapHL-mQUr1=BR-O5cMng_f-YJ6=7g4+_sedUbpXiJg@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Joseph Telaak <joseph@telaak.dev>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000048a59c0660dd30a8"
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

--00000000000048a59c0660dd30a8
Content-Type: text/plain; charset="UTF-8"

Does the current gma500_gfx driver support PRIME/DMA-BUF?

It seems not, based on my testing of the hybrid 2D path with Xorg (hybrid
2D is functional too, by the way).

I think we'll need to add PRIME/DMA-BUF support

It's been a very productive week!

--00000000000048a59c0660dd30a8
Content-Type: text/html; charset="UTF-8"

<div dir="auto"><p>Does the current gma500_gfx driver support PRIME/DMA-BUF?</p><p>It seems not, based on my testing of the hybrid 2D path with Xorg (hybrid 2D is functional too, by the way).</p><p>I think we&#39;ll need to add PRIME/DMA-BUF support</p><p>


</p><p>It&#39;s been a very productive week!</p></div>

--00000000000048a59c0660dd30a8--
