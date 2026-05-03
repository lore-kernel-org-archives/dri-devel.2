Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D113FF886F
	for <dri-devel@archiver.kernel.org>; Sun,  3 May 2026 18:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E66DE10E5C7;
	Sun,  3 May 2026 18:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XxAavP/o";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19E7A10E353
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 18:37:03 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2ef8d6ba48bso931188eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 11:37:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777833422; cv=none;
 d=google.com; s=arc-20240605;
 b=Gp41rLyzRPKVPuM1KAdmbqjRk/n+Jtv/9hHBqdVuyOCH7Z+Tdpu/FtnMJT49QQUY1n
 76K+lNrglUszEHGrmOGu84gFo5or68XuPgav99W865wFtzdg8fUqiUx2DsOuMnUuEpFv
 5UVLSvE8XPGSdEAS80hc+c9NzFF/tGI2nKsPoGUfv3buE9XEwZ5aHxIethDTncr7ZtdW
 VqHfFJWZU9g/p2KfV9f2qG5pV3lZtSayYkdCKwNSzbUZp0Fs2m3PtufDwijMcpYucKfs
 uZ8eLsMjTJYClT1afV+hQ+wLWkmX53OAQEtlxJFHKfzixOMjNV50i/MZU2jsYoO2yObn
 sNBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z8DagsZ0dzvLRGip3yJmsVrNVksXrv0ekQfgv6AKROE=;
 fh=iwJvRsVvz6O6IhMFPSgwalu4ScE4+HxMzFRxfq04syU=;
 b=RlPYSnxj+JnmDpAFEIHEVKle7WBvQ4+E2orozb6m/9sb60fsK8YuSK/TGdwz/H7m/O
 uGcvM8njD87I/Z/Xb0aAuwsHtxOZc7wAPNaQH8WYic6zCMhhV3N1HrhcsBglwQEzzNOZ
 0cruZU6QA2DeNlcjYe0AEns5EPWnAbXRuQ+HGEAv0P7PVlo8U73topPh4llC+Yu3XEQA
 TjbTuNVYFqvqqXUeNdRQ/htJ+Ymr7nOSI+0Hz2FMSeCec7Eiy9pNOxWHCmxQ+CzgdKuR
 zIbtEyhUFJfFQ4RP0e6pGz9Oog2tHfiSXfHU5wDRjv1mCNOVGwkAbW2fayloFBIlOSKG
 8bCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777833422; x=1778438222; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8DagsZ0dzvLRGip3yJmsVrNVksXrv0ekQfgv6AKROE=;
 b=XxAavP/oMhNtmHRdNKHF+wzSPuDzH4qeM6ndEH/pO4xV5zo+/0o4j/YaBwRJS3rbpL
 9xH/f9yNQevyEoqk3yPHgI44AqxW+CdO0Vpy4wesst/1r2MAHLPQNlPGOTjQMTbf+eQb
 L3TSnHot9EG1u7fl5T9dlu3f3ML4fxtx/Pb193qxWR1sAR4ERUuTmI986s93KoTgLaGC
 Y5lZVh0miCbU27cd09MkO9z2B2crq4LSGVu3MaopGP9dWecVfKwtPTpUi3CIp1whVThd
 0QZyu+77gw5P7AHXXwqu7VqxC2tPBwKBberO/oD2YTe+hVkaIP9r8FuPwtd/qxXisFDx
 yr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777833422; x=1778438222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z8DagsZ0dzvLRGip3yJmsVrNVksXrv0ekQfgv6AKROE=;
 b=ULKrASCt09YXnzHF41NY4ZpmI9LxEO0S5Q5HmpkaYx4vTdNZnUG8P2uQAzYJ//UAV6
 XRTV8YLb1viNZpel+R1JvqtNqq9nQfoqKeMuQ4d5VrdE4/DtBJe3/ft6vtJZJuxUrB9x
 5JH2M5enTon5I8fLPyyBsbV7j7o2PBw0bhmFL2Tpaiss380bRUawfQVJ6ILEqw98Yrut
 QVEV9PnKlPX7QJM+z7oH3ENW3jY0QB2q2GXOoei5KcdsI6CpO6mXLHnFDKl8p4VuqV5D
 hhFjf+jwF2xa6iK6ROqS/akZb4OE+/5QBKm1sIPFXUZX5qRNGg3xWkA1oMrTp+J/ykDm
 yL3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/n77IGEjeoL795AgbAKG9DToelBBiSW7E188MF3mmPwIUcIX8zeIWrfNKOmmQfyMtT0aIB+ZXNn60=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxM6Rsu3vG1iLJGHun3npoD028BiqwS2gCCPE3UA2ro677aNmXb
 BZQ769A5k98BizJcNIc08vRONgJRLsgLFNTK/2H9ZMHTE3iWQ9bfZVSDjU3RcEQBBdqFzoLg0B3
 9SAvxdKL39ZII0LSIsjJak27MsYVDZ4w=
X-Gm-Gg: AeBDievpsal43j9r2uo1igPToJFMCXW8/gsO3GsOzml11Qr7AH4aamAG4BQOeMQ1gsW
 SFbolsFL0A3ttr5K31RwnUeebHKy7ffnnf0/QSdm+g/bT33dXDi4gNld4Syz1JpVXjtVsdRu1u9
 600gvDqnuVdAOvRmefZFynUgt5wQ9fBkCzBfNqpYW4VfX72/6N2JrylGEEoUz3Xs0HdmXDgqJvq
 +o17zk6+W0Azu+rlwSO7W/TwU/+ILsgGPrwMQuaJXpvb/kc6lJT+mlVUQnfk/NZ31BBT5+0P5vY
 Fj//eX4xUkau6DblstE=
X-Received: by 2002:a05:7301:2f8f:b0:2c9:ee15:a0ee with SMTP id
 5a478bee46e88-2efb1ea49b4mr2558521eec.12.1777833422205; Sun, 03 May 2026
 11:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260503163842.213489-1-clamor95@gmail.com>
 <20260503163842.213489-3-clamor95@gmail.com>
In-Reply-To: <20260503163842.213489-3-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sun, 3 May 2026 21:36:50 +0300
X-Gm-Features: AVHnY4IxuDT5wqlWTthor6a-YxW_u6JTlPuE1JJHX5m6jXfJ3pVQZVYx5UnP4ak
Message-ID: <CAPVz0n1N4YHDPW=gsUZWZmRZbt8xQB1V8JWn6cyM75fo7H020w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/tegra: gr2d/gr3d: Contain PM in the
 gr*d_probe/gr*d_remove
To: Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Ion Agorria <ion@agorria.com>, 
 Thierry Reding <thierry.reding@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D0=BD=D0=B4, 3 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 19:38=
 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Ion Agorria <ion@agorria.com>
>
> The current power management configuration causes GR2G/GR3D to malfunctio=
n
> after resume. Reconfigure all PM actions to be handled within the GR*D
> probe and remove operations to address this.
>
> Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
> Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/gr2d.c | 11 ++++-------
>  drivers/gpu/drm/tegra/gr3d.c | 11 ++++-------
>  2 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
> index e4148b034af7..ffcd076b5831 100644
> --- a/drivers/gpu/drm/tegra/gr2d.c
> +++ b/drivers/gpu/drm/tegra/gr2d.c
> @@ -100,9 +100,6 @@ static int gr2d_exit(struct host1x_client *client)
>         if (err < 0)
>                 return err;
>
> -       pm_runtime_dont_use_autosuspend(client->dev);
> -       pm_runtime_force_suspend(client->dev);
> -
>         host1x_client_iommu_detach(client);
>         host1x_syncpt_put(client->syncpts[0]);
>         host1x_channel_put(gr2d->channel);
> @@ -286,6 +283,10 @@ static int gr2d_probe(struct platform_device *pdev)
>                 return err;
>         }
>
> +       pm_runtime_enable(dev);
> +       pm_runtime_use_autosuspend(dev);
> +       pm_runtime_set_autosuspend_delay(dev, 500);
> +

Hello Mikko!

I have used same setup as in VIC. May you please take a look to sashiko's c=
heck
https://sashiko.dev/#/patchset/20260502124055.22475-1-clamor95%40gmail.com

I do agree with statement that pm_runtime_enable should be before
host1x_client_register since this same approach is widely used in the
media subsystem too.

But I am more interested in your thoughts regarding sashiko's
gr2d_exit situation reasoning.

Thank you!

>         return 0;
>  }
>
> @@ -367,10 +368,6 @@ static int __maybe_unused gr2d_runtime_resume(struct=
 device *dev)
>                 goto disable_clk;
>         }
>
> -       pm_runtime_enable(dev);
> -       pm_runtime_use_autosuspend(dev);
> -       pm_runtime_set_autosuspend_delay(dev, 500);
> -
>         return 0;
>
>  disable_clk:
> diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
> index 47b0c6c56bfd..cd5554e2117f 100644
> --- a/drivers/gpu/drm/tegra/gr3d.c
> +++ b/drivers/gpu/drm/tegra/gr3d.c
> @@ -109,9 +109,6 @@ static int gr3d_exit(struct host1x_client *client)
>         if (err < 0)
>                 return err;
>
> -       pm_runtime_dont_use_autosuspend(client->dev);
> -       pm_runtime_force_suspend(client->dev);
> -
>         host1x_client_iommu_detach(client);
>         host1x_syncpt_put(client->syncpts[0]);
>         host1x_channel_put(gr3d->channel);
> @@ -517,6 +514,10 @@ static int gr3d_probe(struct platform_device *pdev)
>                 return err;
>         }
>
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> +
>         return 0;
>  }
>
> @@ -578,10 +579,6 @@ static int __maybe_unused gr3d_runtime_resume(struct=
 device *dev)
>                 goto disable_clk;
>         }
>
> -       pm_runtime_enable(dev);
> -       pm_runtime_use_autosuspend(dev);
> -       pm_runtime_set_autosuspend_delay(dev, 500);
> -
>         return 0;
>
>  disable_clk:
> --
> 2.51.0
>
