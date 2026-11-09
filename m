Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3912606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vh/4l6ub
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D02410E887;
	Mon,  9 Nov 2026 10:24:18 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD2510E887
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 10:24:11 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so1020519a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 02:24:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794219850; cv=none;
 d=google.com; s=arc-20260327;
 b=ZKbZ+C7sOpwtlcayoxBJmTCMFBF4e7GHPqSQHmmfwY2EadEfXVM+XZyFlt1qhFrPhx
 X9efqlI9/1u/7d1L/2snnTULlz0NQ6YflM0uSBfid0ZNpI09FNaCYpQ829dRLVzqvTQk
 zSWZhO2nUM0oLmtwyLj5udjaQpVUQp+loLD9w96J9quWNETNW7jMTb+f7PZ6ae1KSBwZ
 52HT1jft3hsD9gvKx8YsivCSPl00fFcgbWoaAaQfmp2EQkALCx1hQsabi9WIwC9vIip7
 v1J1qehRPvNRULi0drPoH5e1hgSjSyTFncrnpWya2DVAMEgLHDJM1Mw08C+vYfUFmLBm
 b+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EjD6oUfTTnBasqCu3JZeOLG5W0Q/TglrURlCXYrvep4=;
 fh=9Nz8g22g6KVw+xvj8H5diCADBM6oMzaTHwykEFUbCaw=;
 b=ay5rFIV4Io3ZmMNO0Y4CSBz2EBwWH7H+AUd+x0VhPeQsqiqFMxh9UDdUZTaY+3+LVl
 6pPALmfOVTGn8nMZaqrsVp0wpZFVWqMCjzkhm7yyKBvUE+IDqqKEArphCEn7+Tvm+Y2d
 Nc1Zuiu3+3jZKM+NlTg+y3pZaJ3UooDZUyy6on0aNCLYVZ0ws62VDS8uQhSXkmNlfr2C
 poIUlj1p6t0jyS0kFOQhazrj7ND5P166diVDpaCwAq+fi5Ef5EcvPsfNyBlJbGfzg8S4
 zSLg6UUnDClF8P0LaHjXoOo7dNspISRXYJE30YfC/EBBbYRImzwWsu2PBWtqk/kF7meg
 iwTA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794219850; x=1794824650; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EjD6oUfTTnBasqCu3JZeOLG5W0Q/TglrURlCXYrvep4=;
 b=vh/4l6ubhNNQLkteXG8AQZXHQq6EGQ91JrMDvL2jxhRocw765hDdYFXk5Encu1lNmz
 bZLYCEclTvSV46PAeFbWAGLgLZPvDg357uzS/hMEMpchdCJhwOU0Zzfn3lcvJCK5efjj
 /a/rl0lfhvWVrWk9u6jkcsdiTuaeXUBYFuHqllp4gE3zMmQOERpqI9RlliZXhQg0IZVX
 UQmi3WVkFVHJuIel9aBpX6NdurXAGxZ6W9QKeu3G9wovNGtd9an+NizOPivPFWxlg49d
 Rwmp/NiGWxv6z8qT1cgttsCrYtFVfOqjLLNYYrby9TZnN1tMMRqUQi5513V1khd8H00G
 2Wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794219850; x=1794824650;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EjD6oUfTTnBasqCu3JZeOLG5W0Q/TglrURlCXYrvep4=;
 b=Qs8JPWLU5zBfxGuD9TpMvRiuHkCwZvfUP373csYvpr1kbgRjUHNMQSgW49DEDFihGR
 8qfTrdYt5TJzn1ZJEVhFg6LCtsnA0RDjSNy8nMOVjhpBRqmys8JBVUviBGLPO7r1xnbo
 bZotTHLOSg1ZAnLYi226YK9HFlN7dqb7VKm3Pa3MCP1LYjrM8pT/rLmvuPRIC5FA5Znd
 NhV/xZzivrs9kprAHrM6QZfFLAM+ODSVQ91k/p0aUP44E6hOPTqS+Uoqd7ftTGBEmaDB
 S428nrr/XIZrJOis+7tp0DOy8R/xN5xPurhyjqIVrWRXNdaym0kQ08qOymlMZ1emEfcJ
 ETkQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEPeaLgwY/Lolyf4dBMCT7JW/QTyp/ol4cFfybRkdkLv4SFRXrWvTn4vdj/LVh8DDQaLvV7fzmXFD4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ZvgZEuleMdp6wAi83an84W5LIuv20G7TyKUS9uwsRsAILj6My
 XlxzWSXCSk/JDWXqceAlFJhFw/eyBVRXm1jnlS+vjzLSq9zzeQKt4CN1wCh/Ze9NqNvZ/8IHF4l
 gwOqO63o5Gh5JHUpQec5NdKF5+E7vwwk=
X-Gm-Gg: AYBFou04smCuwaYDzqjHl6v2rYnFK9NneSiiC89GSSP97OPnC5YTsjr0SulTlbqcqMS
 EXS/FvdrERxCGvyQOLvOmMtcDwOdsgCKiLz4zSJE+HeT09QfRJ0Vghl62AK5KtM4ow0RimlMnk1
 dU6XWF8ULzqw+YduIKoP3Yj6POyz/WDkTNrxvIlBuv91/1dBgrplDRLGvHlBAKjUZK80uVv7miQ
 ZZCBtRF5SfkGqoopjovBTkutwd6Shlk65HihEs+nNqQFXhTVhztKt8HAhv88f6J29+SKeKQcEEc
 GdJ+zT1KzSYEuMlyVjs5+tFhAvBMXNMhtzUtGrQ+mvYZkQhyzZ/d7rwN4pu8AYT/05ISfNYYXJB
 sRsfLYAZU87zxKVtFrvqTjdsl25X4/cMcZ72xkKXUp9obrn1BxTBDWFBUyX5ueqgt6b9lEI4=
X-Received: by 2002:a05:6402:270a:b0:6b7:81c:64b4 with SMTP id
 4fb4d7f45d1cf-6b7223755bemr2488079a12.6.1794219849459; Mon, 09 Nov 2026
 02:24:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CAFGNeajNF_VMAvtDDVZPxdzskUR7Y6HPNQp+sH6eihf3PLviXw@mail.gmail.com>
 <CAFGNeaih0pByA9harSnSd4opyCu4EFKmSR9quD3cNzXEEp+0kw@mail.gmail.com>
 <CAMeQTsZEwmb3iCPWUa7H2J00x2QBsaCG9GmKMn3U7iJgcHb_RQ@mail.gmail.com>
 <CAFGNeahsXsKQLoGkxTyX+-c44PnXDS-OWOQ3Y-K_T+2M4Derrg@mail.gmail.com>
 <CAFGNeajahc1Amwqg_hX43CfcJEq1E0xQK8Grv0sCukjT1TK0bA@mail.gmail.com>
 <f245aa61-ea8c-4d65-8801-f90a492d5dbd@suse.de>
In-Reply-To: <f245aa61-ea8c-4d65-8801-f90a492d5dbd@suse.de>
From: Gabriel Gama <operatingsystemsdepression@gmail.com>
Date: Mon, 9 Nov 2026 07:23:55 -0300
X-Gm-Features: AclHuK9YiHmHRW1A5PyBg74Pq72BRjN4wsgS-3PAUctpZ4mln02XVm9Jq8h5UtA
Message-ID: <CAFGNeagv2Lc0L_4r28k5N7Exh=pkNTESh3agUp+3NkLp0YF8VA@mail.gmail.com>
Subject: Re: [RFC] drm/gma500: SGX535 render ownership,
 MMU and failure handling
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 dri-devel@lists.freedesktop.org
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

Hi Thomas,
Thanks for the feedback!
My real name is Gabriel Gama. I believe the confusion came from my
email display name, "Operating Systems Depression", rather than the
patch authorship.
I've now updated my email display name and will make sure my real name
is used consistently in future submissions
