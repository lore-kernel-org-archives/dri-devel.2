Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE74606A33F
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=s/8V5e1T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D42110E893;
	Mon,  9 Nov 2026 11:53:39 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 915BB10E893
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 11:53:33 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so6766025e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 03:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794225212; x=1794830012; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zLTgbg+UpD4d4gieUiuEMrVcZ8oV4X6SKoeOC1j2dCA=;
 b=s/8V5e1TlY4lesvzlFkTu+VjWcMu6T5QTCzopjF0cDsPaICw+4/+4TiyDyhgrB05D1
 WUsP/Kv3OXl9JmufiMgD4EnCoAi4OQf+No/zsJBauAJRZ9SzPU7Wm8jF8I8XmaWqZFSw
 /juzs4gf0dam4vfU+AnRPswYAgLvBNmcwMxL7f7w2zYz6Ts39sKRdF3dpPYZ4lwbf9NK
 5yMPvnWyUS2rnkv2wc3qZMAEsVbFiNIVCBiLLU7RnMbQH4JxLB0mOWvweTOZwQTz4uKt
 r2BUDZ+HIRQCjn9/6ZQu+bjD0IgGDwW5taiOsxutcAWmF+SXkPK5+3BASlnIpm5QzE2j
 zs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794225212; x=1794830012;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zLTgbg+UpD4d4gieUiuEMrVcZ8oV4X6SKoeOC1j2dCA=;
 b=XS8GMfKFUIbOTK9vKAdfQQJreOyLU9FAuQeEEo1vjoPzDXDAKCx8fUdlK6/VPLMlmh
 a4Uez3WeZ08e84l3pbOMUe501lOEtAm1aJ+jlMHG3/dtDsU+R/DtsaTbEPfUbf85Zm6N
 T1i76DvJYFKIOLumeAT1fWt7jThUZc5Hiuk57TjHC7pocGj47uxhWrKX/N/VqtsKLC3j
 kgNbt+ju8oF8+fvjh1+hWIOZNfd5UEGDGLDTXWBQH5F13SjUxX5bpbBon1cLaS58prAl
 gpjOd//5p2petN4ZZT+jwSkrV4vDD1iR+b+IAzWUecxL54PKGV5Xmm2jN6d2J2t6co09
 FLnQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFEI6vmg54/Y8gos0CdP7CCSFzvq8pOofgu825Hn10z44rW5k1QS9M5z0E5HDdQx0EZP5/WL3fQ6p8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8dpGOAn5oBscF89K1v2/rt7vecez0FHPj9EKVi3L/ld7Erc/wN
 jV+qgJihM4bVOP2idzgnxuB7aPRhPG1qK0RaMd66rqDrXoxosNXbeL+JEo8OYQx/gvg=
X-Gm-Gg: AYBFou256E4daUCW3iXjS8qisg244obkM4AiZF0iDeZFttqWtAPt9wF/LApJ0eiJnM4
 73Pav498sN7kMMZw/3RhbML7RJDUwNcFFiFZ3saLt0Mx6yL+/NTdbnGMiMg8PtI5MRQw6Ts/Ymz
 2/IpRdVzrzmKkutdNr5mJtOYol+9nDnVh74NulViheWsf53d4PV1WyO0IyB3f/2isJ1abUnoaIO
 sCcMGGuQEgfp42jQY0dNnmHy9UjYdUYJVMZcsQdoSmrIzjjiEArluFECIOMGcX780H6QUAeeVtH
 71RmHEBylos3tPZZytmqsBiMxzYthuRxoQnblYOvkt+SEGQlf12dpFh6Za+Yq5nksjf0/hcXK3n
 CoKNR2JUdP+mlBgyiQf6NuWy6+Z+R897SR7s7PnbvtH1acQ0KS10WHnsqtPmEf4pqYkxxj5dH7R
 WF9tJS5THjBqXbIWK+Z5zdK2vBNAuqSj+JcfbhZ8lWGVuEuwO9xBFJIbvmgKKfD5TecJ4OPqQqc
 124eN1dWKJ4R/vgHv8tluFYWbkD8HtVxRQUUSFd447H7x6E1ADVioXbcMySwrhpwlq4d3EeseAy
 O0kN4l09dZkrOMlguR2hY4EY9UhIcBNfMVXpoHDUp9o=
X-Received: by 2002:a05:600c:4f42:b0:4b7:6a8b:9df2 with SMTP id
 5b1f17b1804b1-4b963c7ceccmr86905045e9.25.1794225211847; 
 Mon, 09 Nov 2026 03:53:31 -0800 (PST)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea5008sm9527362f8f.26.2026.11.09.03.53.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 03:53:31 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, Jose Nieto <jnieto.alaber@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, 
 Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261104155119.284708-1-jnieto.alaber@gmail.com>
References: <20261104155119.284708-1-jnieto.alaber@gmail.com>
Subject: Re: [PATCH] drm/meson: plane: add pixel blend mode property
Message-Id: <179422521075.1645559.4574757378913663782.b4-ty@b4>
Date: Mon, 09 Nov 2026 12:53:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Wed, 04 Nov 2026 16:51:19 +0100, Jose Nieto wrote:
> The primary plane exposes ARGB8888, a format with alpha, but never set up
> the pixel blend mode property. This makes the DRM core warn at boot:
> 
>   [PLANE:...:meson_primary_plane] pixel format with alpha exposed but
>   blend mode not setup. Please fix.
> 
> Advertise PIXEL_NONE and COVERAGE and derive OSD_REPLACE_EN from the
> requested blend mode. Formats without alpha (e.g. XRGB8888) keep the
> previous opaque behaviour.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/meson: plane: add pixel blend mode property
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/f001f3ff2e0a81b934e7b14cf7a695ea668494a6

-- 
Neil

