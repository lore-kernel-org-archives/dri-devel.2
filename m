Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C038606EE87
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jzNGth3D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B325A10E10A;
	Mon,  9 Nov 2026 12:23:35 +0000 (UTC)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A3E410E279
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:23:29 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6b6f806f147so804702a12.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 04:23:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794227008; cv=none;
 d=google.com; s=arc-20260327;
 b=p0hF3PHeB4XiyymQkRGpaQ4wEfyq5O31H9ZH6x22d1gtfXIZseo9u6opoBqKiWvg9l
 EOUSi3fwN2E2m20bNcFx3Bz/mpmHnpyPSXrld4sCXZhhjmTbohbrpXotL8jx8Yoxxr53
 /RFxUWj+bhM409+SNXxVWnffs6+HEZcDcPpxomFlhQ3HvTncBryTXcWCFs5L89qwaVLM
 mzKa3dBWwxI52qswAr1yTxvlOp5UZJZXbvsvoamEtk3Rf0zzKSDxpJ2k+ybiZSEr4Ns7
 Oa+fQpcAsxZXXAULCL4rpUqrge0E4Oj+S4TsSaFCYqcy+Z9rlQp9JXOp7eduajP7uuk3
 63sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dQSf0zeUiIdb0tbmZIZxwDnEEFab0lP/hCTCfuyfZIs=;
 fh=Pen6Qne+/uWBAhltzJvlaz2LztTkM2iI4Ztn0VgnRb4=;
 b=BRWhSO3VT2FFJMRADCsFGsr69Fd1e6+e4I5YFdS4iLo6QitCzs58rhUtrG/M8ED2Wi
 KYNaa68GjTSTfvpP30G6TPQhlYACA7U4sqiyIIH+wA1+q2QfzW72LmF2VfgWh8AkzC3u
 k50QnCy7zc2pqSMYEqkrqx71UQaMLRBr4OV1giJU19mbs3fO/EMyf9Xz8ORXBcCZ9VNu
 rqtv6FnruxlILn9BsI6GH8pqU8iyWU6ssatjZWSbPaQTGgPQGtOX9k8wB/nAQ9PwMuAe
 Ij11pteP9Zb9aYXSdzpBEPVgVQnXeYwQpBYDiLSXBpTJqo6244T78m3ac+WyUUywSs4H
 XbnQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794227008; x=1794831808; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dQSf0zeUiIdb0tbmZIZxwDnEEFab0lP/hCTCfuyfZIs=;
 b=jzNGth3DqR+yoW7eFM5mFSD/UvWF1hSiLlLt+hiset9WC2R6tiJdm3U/8QLdMaOVGl
 y+ToE+ZQ+z4+NRH0ewY7n4FP/eiase5oK6BFiVdhZrTnKKmo3zRmRO2RbarJfX+VDCV4
 wewqXwgK77vCWWtcd1dCkuKu7bsuABS7newwW/Y1tNRq15Fe7gbWnp1TekpvKsyb+3Bw
 E/mFJ/3iliRwkKJ2QsgtBt5OSkr27j0UBlbqKqkWQ9RaHlIkeUlBFsEY1170+Jd2Cyxz
 D5GSzUUjnEr5v98IS2BWgW1yyzJzhZPmFI/Kv0pkqJO9aB9u1erJ7nEw9ZBCOfGC8wRu
 Fydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794227008; x=1794831808;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dQSf0zeUiIdb0tbmZIZxwDnEEFab0lP/hCTCfuyfZIs=;
 b=OQzdU44o+OpbYi59u2vLskhRMdx/XB2bJXk3iixZN0J/4QPqljqZFuc9PLIavLBZc7
 5xUi0aHzM1qKqK7ZcGJ9hfhJj0S/qoASukGm0UT1KB0h/Qe5poNU41YpBGcnw1TFLXhX
 fYJTCqDHH5No/LnMFm9Wcsdj92ZRwtEYaJHMN4wm1KKOR9jcswWKVVWiMjaDNAEWPoNN
 teTJV3bSX5U210ft/wRW2BcC9FaiqLZLNL+UYt+SxGIOEuCqYIYfhxgnS9lvGaHtStNz
 ys9VO8WvSAyWFZ1uVj1zNLHkBlRqcbQ6TSS3HOnh3Gg6pYxGKleE8heNzc5Qrom8QqRI
 vp0g==
X-Forwarded-Encrypted: i=1;
 AL+hErFCjQ2e2OfezWik/L4zDQDfE4o7vA2ln30R6RIJkuhXS0yyR7Vw/asjExepvx6AZzhZG8q0uCkq0ms=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8PouG7WI3FdtL1MEIl+ETMdMzbAKNoBwZ9qkUg/KU2Ve4YkuCV
 pdkrfbZjXkzkC2AeNc77ueLPyiSNd5gp0bsZ2N0yrdQFlBVtlha4Zv1PkWL3jQQ+04k1UAIFvOL
 q0ATtLKxr+6T0TisnuDaDlZOYPpfCaPY=
X-Gm-Gg: AYBFou3UVk0aRiC/GdJW26TbvkwwKgqQQwMIk2mAH0zM1eotvZ5vjzwZQf3pNxeZMUS
 25uLqqjNIgsa0b2MTazDcfWY4QEWj7oUpD2PCIjHxkGHVfKyKafGQ2OYMohIyAfr77eHpxKtvoI
 yePhikyy8G3wt120f4+OT9S/d4XNi1TJXXu7wjQV6D5FF8qQ3Ms2s42PZsPYEIcFEHQPUR5Qcxg
 Xc1YD463ADHSAbNwPTRa/4cd9E/3HsR3KIBmxB28/T+XmscyDesEFnwCoZwIdfWwq+b45KHJ/iv
 S13YDiTH2ft5fsM7a1HTQN4Eei0TU29Q7JtGTzTpoTrIWrStik6/V+tZOmJMiwO1i2fMtW6OVG/
 e8uVe4bqqw+nQs1GLiW5a53NcIdNLuItB1k17kL2DuPuSLcsJrb7FLjSKPJjTdv7DNR+k
X-Received: by 2002:a05:6402:280f:b0:6b4:2aa6:2bf7 with SMTP id
 4fb4d7f45d1cf-6b722422288mr2399267a12.17.1794227007410; Mon, 09 Nov 2026
 04:23:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
 <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
 <CAMeQTsZEwmb3iCPWUa7H2J00x2QBsaCG9GmKMn3U7iJgcHb_RQ@mail.gmail.com>
 <CAFGNeahsXsKQLoGkxTyX+-c44PnXDS-OWOQ3Y-K_T+2M4Derrg@mail.gmail.com>
 <CAFGNeajahc1Amwqg_hX43CfcJEq1E0xQK8Grv0sCukjT1TK0bA@mail.gmail.com>
 <f245aa61-ea8c-4d65-8801-f90a492d5dbd@suse.de>
 <CAFGNeagv2Lc0L_4r28k5N7Exh=pkNTESh3agUp+3NkLp0YF8VA@mail.gmail.com>
 <CAFGNeaghfuFwWMetu1D3+bnW++cC3VJo_8YcPZ8ToLO58jxwng@mail.gmail.com>
 <CAMeQTsb6CESYugWG32JHiNOVVHUUqTY1JdKCCd4Wf0Uf3T9XFw@mail.gmail.com>
In-Reply-To: <CAMeQTsb6CESYugWG32JHiNOVVHUUqTY1JdKCCd4Wf0Uf3T9XFw@mail.gmail.com>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Mon, 9 Nov 2026 09:23:14 -0300
X-Gm-Features: AclHuK_dPwiErf3_hOkGaqGfKUY_Vwxi9TGA798AYRy0TR1NbMe3_QKLplZ3p68
Message-ID: <CAFGNeahpZCnGHy8iC0FS_oALcsU7YrW6afxOe=xJi+407Q0MVQ@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Patrik

Good question! reMESA doesn't need the original SGX firmware at all.

I've been building my own implementation through reverse engineering,
including the PDS and USSE parts, so there's no proprietary firmware
involved or anything that needs redistribution

I managed to do this without needing to look at the old Ubuntu 11.04
with proprietary drivers (Real-time operational analysis has never
been performed); it was all static RE at old drivers (To this day I
wonder why I never needed it lol)
