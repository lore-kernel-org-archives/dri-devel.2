Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48623606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 04:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=furiosa.ai header.i=@furiosa.ai header.a=rsa-sha256 header.s=google header.b=KpZViYuX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D8B10E056;
	Fri, 20 Nov 2026 04:19:01 +0000 (UTC)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3E8B10E056
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 04:18:55 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-382c3c9671fso620938eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 20:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=furiosa.ai; s=google; t=1795148335; x=1795753135; darn=lists.freedesktop.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GoctuigbNiAnWryXvwISlMEIatHJNqn5fsJYaXm74a4=;
 b=KpZViYuXsr3yxNah5UxH7mGkopEnORH9uOM2CTq2O156r5fqNR3CcfrX/3i+0RC3lT
 t1Y4nCMr/Q0Z7A0c0B33z2Jc8wETIUNUtrp90vG0Axz0kZ+1gV81rYvk1DZXqMzvFsH1
 TLnWyyTzX7dhNDHULsXspAxZs71IkJNtjoyBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795148335; x=1795753135;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GoctuigbNiAnWryXvwISlMEIatHJNqn5fsJYaXm74a4=;
 b=GSiWXsJsUQk7IZ6TjprxuPLkHW6/+aafqeZfCA9HwFDYoPZEFHeqacYDzDqAsszYpt
 LNbaN8MNdmbhyXyvFpXSXJeeEZgkmPVIrVSLEF+qRm6wF0NMsik02bGk/EwPYm+QpwgC
 DMOnd5XEtgNFYZNHK/eSxqXEZIf/JYmPeGk2tj4bfHMpYm6F3Ea8IO1zOD6BUi1whzgq
 2P1aTV9i7pqF2GY+21hFxpWN9Z+tUuF1P/FvKR4KtKO2Wc0Ujko/UGdXM2YtClz0U7/K
 CffrJAZ3A75ud339A9Ss77XLNFe24WAnNlGYrM5URjoJeaq6DCJ/7skSsYqXCg8qCD1C
 Tnnw==
X-Forwarded-Encrypted: i=1;
 AL+hErF8/rtwpkpV7C/Nu2tDNNIVBMryUdifdxUJtE4irAFFCtV7atwmRlIR7YmU4ldpatz9rkPOEKoRY54=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9+fypb4uRM1w88TcNdz7i0VlOX7s3esFkR8Y15l9DTD8tkTVIW
 BBY+Kh739aHJ6+/QI9lj+W8IaPdpBgMH5oR6T/CK8scl3ncjFCO3V/UqshouQCzXT7g=
X-Gm-Gg: AZFdTZeRKRt08PR1fbIX/D6OUxm8IdMj7OOo7RA1Fu8p2i1BK59R2gYrf1uFep5v5RS
 qtyH9s2E4JjeOLgSX+GxK7X74hGfxWJZCPWMyoQBXFX3Vbdi5cwnl3nAWbvdgSoD0t1VrgaUI0o
 QFiVcd2+MAAyQxWDVnIRRsbERmU/aDl/yUg9oiHEXgJmHZAKXwmvvDc/ECcN9FDPTVM5WheJEn+
 Hy9rh0V0qa55cfRAHhmkKBXh/XRKPVZSGo/8fe+GyN8wVsiZ5aX1wLOnvZi/B0vztOJ1jqMRCV1
 vMmbhnaZGiePYKk+saNwqmfdlauE6/LFX5TMdDTuPZBpayHvMcK7togaL39DLzu8WXatUPF8iWL
 mDB+hGy7Fj/XWkvpIca5hQOyebKiLNrGRuhRn7KbQDy/PUQawwUJu3Qc9hePNjqcocqVjUHYoFR
 OHwL2cqpT3V6M/2Oo5thjVapkjnvuRd3uJDDBXgXDbdMTrfZzBMxVyo4M+2H4HrfeRDB7aT3mFd
 F2G8L/pE6c7IXdduo2XHPXZ+fzndjkAyR4W8RXPNH0rtq5zotpJd65KUK0iuxcRIvyphLve6Og5
 2JAuZKBSn8eyQvkhAgrdr6EW5B8CI2ipsJbvi6QXYE5PgU167MFa6TBdsOy+pyX6xELr5YIixx3
 EAhGR40OMyDRX
X-Received: by 2002:a05:693c:8042:b0:379:8df3:d2c9 with SMTP id
 5a478bee46e88-3856f14ca78mr1581379eec.13.1795148334620; 
 Thu, 19 Nov 2026 20:18:54 -0800 (PST)
Received: from rock-5b-plus ([61.83.209.48]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-385665f21aesm4115021eec.4.2026.11.19.20.18.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 20:18:54 -0800 (PST)
Date: Fri, 20 Nov 2026 13:18:34 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Philipp Stanner <phasta@kernel.org>
Cc: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, 
 Oded Gabbay <ogabbay@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Gyeyoung Baek <gye976@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] drm/sched: Add drm_sched_entity_get_runtime()
Message-ID: <av_KEmPdB76gKak0@rock-5b-plus>
References: <20261112171144.3151554-1-sidong.yang@furiosa.ai>
 <20261112171144.3151554-2-sidong.yang@furiosa.ai>
 <34494226eb920bdbd7f3257ef6f9b20f4e8ffd6a.camel@mailbox.org>
 <1b78ef4b-011e-4174-800e-425c94fddf3a@igalia.com>
 <48d9790a8f1d2ca7281907f1c32d7e7759e9eb77.camel@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48d9790a8f1d2ca7281907f1c32d7e7759e9eb77.camel@mailbox.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 08:23:39AM +0100, Philipp Stanner wrote:
> On Wed, 2026-11-18 at 14:39 -0300, Maíra Canal wrote:
> > Maybe we could name it drm_sched_entity_get_runtime_ns()?
>
> Both fine by me. All no big deal.
>
> Acked-by: Philipp Stanner <phasta@kernel.org>

Thanks all. I'll rename it to drm_sched_entity_get_runtime_ns() in v6.

Thanks,
Sidong
