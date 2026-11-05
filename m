Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7E5606A33E
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fWuEFlio
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75FCD10F08B;
	Thu,  5 Nov 2026 19:36:07 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22ECA10E729
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 19:36:00 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so15908305e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 11:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793907358; cv=none;
 d=google.com; s=arc-20260327;
 b=Nc8Eo5p/Lp/byEdnq12trIuZlXVBNbCzv0B2HTBrPzg0dhIHFu97emBAnEbTkgCJ4W
 he51MUEFyFAzz33ujev+mTQmCuVGXH9uI01WmhrbUClJUpGcVMq4GCUWQHgyFA+y8fiU
 pDCb4rwvCb7a5WjEyOWClgMbjF8y90pArw2p5aMGfyvwZoT50ysdPXVv71DNiYDB+2g3
 XEEAb9WkErx+qLWYky7seQ6vikZiM5AlF0VVx8Mmx3BBOr4Uiyacw3u9yP9xw+jKWwV0
 iRzXVlUyQwloePgAAUvtdYO4KyJz8mtsz3IWsIDW5k0C4ehT8nzffgKQhlW3JSjpe/1W
 qhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TT16yiNSMhQ2WLe6YgEjHp++F5KnwVX2DUvK61E+hlk=;
 fh=BtXJY24CsLGdtPT/TadI/ND6qxg3KJZI85anZBNIwVw=;
 b=MXmrc3/cRk5NJ6qP1/wTh8tXJOiPiaHfuk4pDIi+nkz8g9RSHnza35r6CfHd4dF7gW
 CVYw3q+I2te9bGRZ7BJOau73PxojzMKcuCwp6QHNaoWJXR9LORQne16QCWWFUEWXo7nh
 dLPk4BHEOAOwUoWe6L3kL78GT7tE9yBa26CsAWj8JNgagbQVzb7V/rwV35/tMb4QvHIb
 MXe8+Pfb00vpxCM4T/6tbdrUWVqpBDRsu5M6+0fgnFFYuNxPBJRxh7itCH/cxri92H65
 6yBzPaHFG1PiqAszlLD3+D7ZPZYYUVl8Pa19wZfinOKwN9gc1aLHYJ3Thpq1iK2uyOuk
 QYHw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793907358; x=1794512158;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TT16yiNSMhQ2WLe6YgEjHp++F5KnwVX2DUvK61E+hlk=;
 b=fWuEFlio9X56z1AYI+1/BVdFG7/W1RCx7I0ryxTc1rrSQupNQpCe2l6cXp4f5lO7un
 aPqqfRsu6a4EpWJkyb2zQ61riL+/rrk86g5xBsgcLjszDBh1W8kuODhosBOuSSeD5Osd
 8FGWcwngP7/10pRSVFTrVCUAySkNWJC8n8iLL/ghEu6/R2KmhbevdcEULqfOLATpcKSd
 XwMmULQoz+PkSxc7IUuJzHjRnqqTWVI+bmioPgfYVnGF1utwWOnbvKkuLWHAgb77Lanp
 60sdvqXDyv2gdRV9n7dBGUuXvtwWKlOtuzodVfPJVrBMG8BN52tIUWBXWtPIqdFxBoaj
 jkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793907358; x=1794512158;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TT16yiNSMhQ2WLe6YgEjHp++F5KnwVX2DUvK61E+hlk=;
 b=DTEamudD4CDZxNaCSIG4F40IjY7/HVfoYFs/QPJuyh/Db6gAFhrxNy/PsbclAIsr2A
 h/brJWZZZncPXj1bp1IbXsME78BupR/SaFdsmwdfdXZyAccm/bSgVHMM9smRI/BhW4V8
 cbqVjrBMNpoWLm2ue4l30cvbv15L8Ufhp/ECai3A706/ldxYTL8o/mxdJKoZIkMOIDeo
 TcovBh4gI0/tyE17SFfm88V5N8XPetLTh9K/IsUzyknJnQq4DkP4OoOgzfmihezksRKo
 EePAgcebA6uhEQBe7vhjMD1H11d0iarXOiMoAOz/fsTV+aD/aJ1OXj2LPto13gMr6bB6
 O/eg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+EoGY4TtoyxMjACLpfnOzT7PYFpADu16VQWbWTBX/cE6cNZoaIijhRDID0MWR+NCul5nZJG1Mzfo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9KQT7D1qVJ/KGgzbIdeCCBqEB7r68s56m87xnuXJTG21pu5V8t
 Sdc/JMnMQeu2xWf6wm/uT4JGQbq4KREBTV63tX00utGnaEWU9H56wEEOxJnRSTzS6TFVrGXR8F7
 HW029TR1Jj1Bt7wD8iiKALmxH1ehDOTGbpu3KIz4=
X-Gm-Gg: AYBFou2MqVha5M5dpgH1RiUZzbuyw2VFsRDVLrhtNvoIcP+ag1IHtko0lozHceEDXAt
 IostniWfW34MMIQXbP9HdUJsaG0qlRf6rORzN9NXpZYlXJwhXlfTp5GpctHw2Z1OWlPLIZueZJb
 iaJ9McqC1SOhRH/jmoHHQ1gIdWio1NpUNYum2JjEI4KgDi9YxSlLPfbg/oFfb9eQgjkiGCoE+gM
 CH6fPMLIZgL4D9MNa6NTpmr66RHpRNg8hk6ab6GzczbHgsD/+sf6ZK7UZvSiakjTfR23OP0i1ug
 Hpihi7PpI6v616S1oBtDlvJInpWEEZ3mWyOivF8wXvjHFNc0XJfjKHh3oWTRrO8C3LODS3nMUzg
 dBCywr0kFI6QMzFXIawVg6XaI1LaUvrRyQcWTQeqT52uIiAk/Zpo0llnMWjWAaJbnLh5BkQKxyn
 Zzpk6ba715rN6gtzmnAl2CpS+qF+bpGmNBbNcGoOkuOlSb4Fdrdw5275ITJ9A88/vMkkxftNlww
 FcyXj7SOy9JDRzlOM2gisq27Rga2Oo37YQD0I78Wuiq63pISbXuxg==
X-Received: by 2002:a05:600c:860b:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4b6e01726f9mr1850925e9.27.1793907357775; Thu, 05 Nov 2026
 11:35:57 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-15-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-15-1f58d1e33380@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Thu, 5 Nov 2026 11:35:45 -0800
X-Gm-Features: AclHuK9pktxzquo8ni3wksTdcQ36g7p_Mb5rrk6cHXIBWJkn6Z0ADQzVKVwOSHw
Message-ID: <CANDhNCqaV-unTkF5nxRHAyFAKj5__Tv05Q-RKfwmB_CuCn7hSQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 15/83] drm/hisilicon/kirin: Switch to
 drm_mode_config_create_initial_state
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Sumit Semwal <sumit.semwal@linaro.org>, Xinliang Liu <xinliang.liu@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 7:31=E2=80=AFAM Maxime Ripard <mripard@kernel.org> w=
rote:
>
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>
> Switch to drm_mode_config_create_initial_state().
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

No objections from me, though I don't have the hardware anymore to test.
Acked-by: John Stultz <jstultz@google.com>
