Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089F6606D819
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sHiDsXHq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65442112E02;
	Fri,  6 Nov 2026 14:10:02 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99CA4112E01
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:09:53 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c4cdc606b47so94899766b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 06:09:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793974192; cv=none;
 d=google.com; s=arc-20260327;
 b=fTkc2xml7QHri9dRhlHcPzOwLcHDV/PzWDSJoQbf7IJ9IlZOYERN6zyppH6+4xyO4T
 2eWCioiNmr6yg4erfFz/godY/QiduAYwgr7APZCsC+zXzepMYIS0d3D1j1CCV9fQ2jVL
 PxeYSti1QoESDX+kHqxRPC0GcviGLwKlrOEPWR+b+wKZNr6fboY+ejEKpeyP3ZXvkX/U
 1sCKaEntjJdXmJnM1jEubEYSgg0wHw2GRPVE2uDID3wQ6u9mhhSjl/Mgc4nww4URK85/
 uL/P7smvDP176VqTwLND32KGiB1KQCeYjc4F9Qf47OlDs2v8P/0NnAeg0UNhq5zOIwYv
 NBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ziCxpeJuEuP3+fM2uEf4yqPzKab2VX2n4iM7IOvJP5g=;
 fh=FHDXZy6rWbOQfLHFtXnfPUXanIQPAhr4XZ2fmWjqIzQ=;
 b=cWgMFQQE6xPtktj4G3ofW9Mdy5QKDD4GwJ2GYB+iJWpP0hByuBWlL4wcu1QdnBwvFF
 IwQJ2uTTyadhQo3rvxX1MHoXIbC2muXENy1xzOJ7GOixiIGJL8DOfMKVHH94meYKvOtS
 lvcmbAtQtgJzQ6ia2ee79X/2THB7mySB/Qv7JatAz2nPtEcCqnN1TVZgj3lxdW2oeRWR
 qDs7HWfSLVrLgdHdI7CXfimTDZ6qNIUpOv5Xozlmra79mtY8fswlu3Nu/cjc9s7HDAjv
 esnPgjc8VG1IuW8XULE7ngYwlW/r001qnM98DPu0YZTATv76fhN3jB2qhlKEgtmbyNr2
 ggRg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793974192; x=1794578992; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ziCxpeJuEuP3+fM2uEf4yqPzKab2VX2n4iM7IOvJP5g=;
 b=sHiDsXHqaCTcK/b32g2XBtw1SRn/AZqFqSvXDuHYJK8fAMt/M8PLhW0Sii5eRTvwzy
 Ksj2tAhDii9mCrzSWf0WJu0QQpSxu9yekSDglnA++VHRowrkkgGP9Kf65zlpdWB1lGmz
 4AfyDl68VQiF4nOc6DpEKrY+uGdDYFqFNBfuCcX7PlsHpXahL21V4JexiDS60p4izM5Q
 06LaACx+CxF2U/jQFdXybSRf/jUPuHbbdrxjOo78Cy1jBm1BZfShK2p5f1RaI2yEj4/W
 LJx5/NPyZd7x54nZQpg07fPxQWHXqPZAoimgPBLF+zjCeX4j27asb8TjNxZ7vfTQ3DnQ
 6gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793974192; x=1794578992;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ziCxpeJuEuP3+fM2uEf4yqPzKab2VX2n4iM7IOvJP5g=;
 b=gqUmxFDGHb/Z0oaPCVvp8ZkOqC4V4/B+CkI+RmKy+/ViDm36o3+ht5otK5yfSPKyoh
 BLlrTbQKeF058fzLY51Y3akzP7YGCRduA0WKGOnHNdcRdyAnanXTC7VpxUuu90tojhO/
 73f/OGLyH3Wtw9vcOR0PHUhBY7xjTorFoisk2LOoiidZYJdkhxv+CHLT/hf3BE+kkXYe
 kEsGh6+eA0/ZeLJI64nc3/0mjwnyPBLqfIArTGxB73lvzOvhn0oQ1mPHvJjyc3X9XU4v
 pYJ0NHahJaG3OFwB09lxXcITEW4L1ydY7xaipo/LA78vm4svJTN/hYBJmzWOBDIjwKmZ
 8ROQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx61pmoCjoFm/gqnVlxT5chqbmE70lV+Ei1qbkMKK83wgNpmdktd9ZVJsFkW5l3lT7olMcCj/eHns8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+tl9UZQuHeiWZxLjB9PSAXvsO/Uy5d2JrLyjPA+6B8l+IELTzx
 sULFlrSQG9v0aQ3phBkZ7l3XL+i9KmIHvx1Z1+cHMMyTTrj21m6uYyu7SXAZxj8dRhYhcwI6MOU
 /g/JAaoleTtwwJ0woKqSgdc468sxkglw=
X-Gm-Gg: AYBFou2AzJD9OerApN5nO8Kt2lc523RWCyNFXpfyBSLitYIYH8fyUGe16PJAql/oS45
 kZEWwxM40ue10cBZhIQJJy5fqr9iY8Gfug7Sr+gg4jNBlJ5I3+pglt1A7a4eoIVezf2oicE/7Pl
 rIW/QjOZfMsHKPrSYAj7BX/Lblx94jpDhsMYuLcCRnxVamqhDyau8YUQfqiEMG1LEVf/wv6BrNb
 6MtAHB4NxCOyfpj5AHSTJKAcgkZsj2EzAjuQz/W5IqBj6U5Yyux1rQnq+W4TS6stxnlqqyFGxyO
 D2oGxvltyVzsmyN/RyTXnFrKCy+YoZzZaeQnO2tVKViYMwPvcI0NXE51ik8vnvAoOnsAVOqiQHt
 iDeNTFr/x1q8qubWtpM8mHeq3RS4kPHoTd/5JAxWTHcoK9mrH1ztTBtRI5t3qvmpW7d7cQZVgJs
 feorKjZ0qqv4ZGEdtwdGgRFp5bxrJipl8=
X-Received: by 2002:a17:907:c0b:b0:c41:731c:534 with SMTP id
 a640c23a62f3a-c4d352c83c7mr245800666b.24.1793974191437; Fri, 06 Nov 2026
 06:09:51 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-7-clamor95@gmail.com>
 <au3dMlmsLEOUqan9@orome>
In-Reply-To: <au3dMlmsLEOUqan9@orome>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 6 Nov 2026 16:09:36 +0200
X-Gm-Features: AclHuK_cVVXjJEkd02nCSMWJMQCoAmARR5pIv9xMRuv91xrb2JMaT2_t676ijeQ
Message-ID: <CAPVz0n3=R1UhyTw1o-ZR2hMyXwKAomNkb5O-cQbG+TBFJi5=JQ@mail.gmail.com>
Subject: Re: [PATCH v6 06/10] drm/tegra: Make panel parsing by
 tegra_output_probe() optional
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:00=
 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Nov 05, 2026 at 04:05:06PM +0200, Svyatoslav Ryhel wrote:
> > The tegra_output_probe() performs panel parsing unconditionally, even f=
or
> > devices that do not require it (such as HDMI) or that handle panel pars=
ing
> > on their own (like DSI). Make panel parsing configurable.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/drm.h    |  2 +-
> >  drivers/gpu/drm/tegra/dsi.c    |  2 +-
> >  drivers/gpu/drm/tegra/hdmi.c   |  2 +-
> >  drivers/gpu/drm/tegra/output.c | 52 ++++++++++++++++++----------------
> >  drivers/gpu/drm/tegra/rgb.c    |  2 +-
> >  drivers/gpu/drm/tegra/sor.c    |  2 +-
> >  6 files changed, 32 insertions(+), 30 deletions(-)
>
> Does it break anything to try and parse this even when it's not needed?
> In all cases we error out early, so there shouldn't be a whole lot of
> extra overhead either.
>
> Adding this extra parameter just adds extra complexity for seemingly no
> benefit.
>

Dual DSI panel fail for Xiaomi Mi Pad. Maybe you should check your
email a bit more often?
https://lore.kernel.org/lkml/20260305161035.64548-1-clamor95@gmail.com/#t

> Thierry
