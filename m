Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4182ECDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 17:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9427310EFF6;
	Wed, 24 Jun 2026 17:39:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="py2q5jPg";
	dkim-atps=neutral
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE3610EFF6
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 17:39:18 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-6c3a36fa9edso67773137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:39:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782322758; cv=none;
 d=google.com; s=arc-20260327;
 b=aaXBGsuL8hXvNgwJ8xkIZSkMBE2HjfJkL0jbl4Tkp7uL9cX4OQp4viaUPHOXPbxwt8
 7QLep2K5UBM17s+Sc+DlnM1/wSd9sCfMl906WiCggKur/QUkOGRV7a1NxIN7dWC7QI5u
 SVPgjgZfK4PYvEfARtDJ9IMSBQ7NO8Kzma3cJyfr9IEz9m24mFweAhY6+lhlLZdSbTKI
 tQVGORmlLfoDNMkKSH0xbK0KRpqiGRSb5SoOf7QGTRsEX2XhpMEgaKulNp8WJc3Zv3Ub
 lO5/yaQ8R5TP76RLFjRmUTAp6uJ6hGk8B0OTCj/yMZgoC2hPMQWdCufLDe8pWum4JLFh
 pJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6hWKqOfPuiRnnMi6yLqmVDIdJU7mz3ZjAEcCDL1/83E=;
 fh=4acgBDEy157p/zHbAAJvWtIIrlIhAP6jGaKWOU0KOEg=;
 b=UTQECArkBQLFwCnwWqWnQ6JRLtN4vS1JCdPRThm5NnmpX4Ap1nheYgUGZGMtn+FtID
 05bfZqEIZaOHLlgN5+MDw41FL3yFrBuPDrDgqFsVzSlU4kOYHTA5yZpTY4BaK5uxEHE4
 33ctBPfaZV6ob1lW+lfmYI5/c1VJgOtGur86ZbiidCC0pfVF9ZyaNiELj1nXVs4tNWId
 I+fjEt0Yj4+p0Bms2dIot291Y1/R94kh9HdH6ohOP4pkYC4TdwOttz2aMDT1pP9cuSh6
 iIBuFaJqr/GhN5cFdA/H7MQmu1v5/THz1qKu+EUne4n2sPJNNKYA8OSCXgfgF/goX4Ni
 J0mg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782322758; x=1782927558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6hWKqOfPuiRnnMi6yLqmVDIdJU7mz3ZjAEcCDL1/83E=;
 b=py2q5jPghmxZ3tFOwmZHTbjpD7uadoT6fZPw+n/apMFSK8tGtuvaJrodirMH7rSHPJ
 g8Utv/x9tUKOBW4IiPPuaU/+vq03rqAEDZEH3vxX7xGl//nBHnxX46t1ZhP24ea0vk88
 Uf8xoTgtcvtdJEHCqFyk83uqWImAK6aJulSHzrpSdb6LStOSPyby7RZsxaogOaL7Pkua
 nhI6ZQyUMiM5ZtDjepYLzhrdDx5LUJXB3tWFtHdNOi3etOmx5nUT84Q9I5Ef7s/r1fSE
 fJfnUIc5tZeJ9bBYFuYIiQT08heVhOhbD/stucL6HZTJVlJ6wHF4tr2BuEsOciT/0Ib5
 l/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782322758; x=1782927558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6hWKqOfPuiRnnMi6yLqmVDIdJU7mz3ZjAEcCDL1/83E=;
 b=Pk1sO/djiy27juQjTB+o5IlTiVNFSGP824FBHB3s/4KJ5PGPjBFEOA2eRteaANGP6n
 kGBxHpsNoqPGUrkxeiSagH8sQSbt8bKrH4xZg67uCrTEpQqrXEMehwWnEVCLCVytlKS6
 QKaUaa9Xzct4gOcS8NCYvMPCli54NbsHhfCVW2t9b47txBtzktfX27pQkS1byZzRg/Y+
 YjUb7R8wgCVXYI17IO+edoQc8HLDzQ5mD59JF2F6U5sG1pBd9FfvxWV9MTC/qA3OWcgQ
 uAoFwUGwkjvazmb0qKOuJz3LpO9EKtEJP/5ixkxBNgP7NSLNRSye3EOSc5xFeg98tXgO
 +jJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFOFBo8IMu+Rv2uSk+7Y34eQ3+TwRWio35aLUeocZGtU6NFkh+a6rDUL9oeg/kZohqCITvUY89mag=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznDyK3hZhTrmJuZK2iHUMhXABv/uV/oMBYcuyesn0ZhrenR46h
 bwZVnutVQKH11ohLKikeTiHQDlzaAtRyNGHmlSE3SEVeSSo8AnZFMZhk9AuD2xPJUGsAyHc8fQP
 QpLylG/NPWd9/tT66o4PYOyDDiUodW2Y=
X-Gm-Gg: AfdE7ckLEyRY7hMR2tLqVUl1o89wOe7Kup8lCAQKVfusorKuECn1TjriXxHORGVHWSD
 s7mtxptEHrKUG/lIt91KgYR6DoKTFao6A5sUkhSGMORouRjyU0rLpD2wypzWqc/3lsRa7HpZ9xV
 URxY7rjiIBAuI8Yg4MLXkEa+H9ZML4BsXYXpEldy5iBI2qENOFNaj48DxL8Fq0cUoUf2wm9858r
 13t7DnbpO9WZR85pFxV6PXK2laVuR/kU7bxAWpkhUbB80U93NRe9GCCfGOvMGDOGxQ6DKk4FcIH
 bV9k4Ehkp+MS5GbT3uC864nEKS3zqA==
X-Received: by 2002:a05:6102:66dc:b0:726:c671:9b3 with SMTP id
 ada2fe7eead31-72f855e3dc0mr3222433137.11.1782322757780; Wed, 24 Jun 2026
 10:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260623075207.320603-1-damon.ding@rock-chips.com>
In-Reply-To: <20260623075207.320603-1-damon.ding@rock-chips.com>
From: Vicente Bergas <vicencb@gmail.com>
Date: Wed, 24 Jun 2026 19:39:06 +0200
X-Gm-Features: AVVi8Cckb0w5pWDUrgh27biY-MgZVCLr-r2PwE5Q_uYu_NuLMhTaPqkiKFr16Dc
Message-ID: <CAAMcf8BrH39JOKG76ZeEpo3Bn8Od8bq0G_Tey=-ZtLrZg41ggQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bridge: analogix_dp: Apply standard DP training
 delay helpers
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Heiko Stuebner <heiko@sntech.de>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Tue, Jun 23, 2026 at 9:52=E2=80=AFAM Damon Ding <damon.ding@rock-chips.c=
om> wrote:
>
> Replace hardcoded fixed usleep_range() delays during clock recovery and
> channel equalization with drm_dp_link_train_clock_recovery_delay()
> and drm_dp_link_train_channel_eq_delay() helpers.
>
> The original fixed delays are only valid for the case where bit[6:0] of
> DPCD TRAINING_AUX_RD_INTERVAL(0000Eh) is 0x00, while core helpers apply
> spec-compliant timings matching actual receiver capability values.
>
> Additionally, add dpcd buffer to struct analogix_dp_device to cache
> receiver capabilities. Call drm_dp_read_dpcd_caps() at commit entry to
> populate cached DPCD data for subsequent link training steps, and
> prepare for further usage of other DP helper APIs.
>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 10 ++++++++--
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.h |  2 ++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 1d39a354c3d9..30c0c0b41d5a 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -330,7 +330,7 @@ static int analogix_dp_process_clock_recovery(struct =
analogix_dp_device *dp)
>         u8 voltage_swing, pre_emphasis, training_lane;
>         u8 link_status[DP_LINK_STATUS_SIZE];
>
> -       usleep_range(100, 101);
> +       drm_dp_link_train_clock_recovery_delay(&dp->aux, dp->dpcd);
>
>         lane_count =3D dp->link_train.lane_count;
>
> @@ -393,7 +393,7 @@ static int analogix_dp_process_equalizer_training(str=
uct analogix_dp_device *dp)
>         u32 reg;
>         u8 link_status[DP_LINK_STATUS_SIZE];
>
> -       usleep_range(400, 401);
> +       drm_dp_link_train_channel_eq_delay(&dp->aux, dp->dpcd);
>
>         lane_count =3D dp->link_train.lane_count;
>
> @@ -754,6 +754,12 @@ static int analogix_dp_commit(struct analogix_dp_dev=
ice *dp)
>  {
>         int ret;
>
> +       ret =3D drm_dp_read_dpcd_caps(&dp->aux, dp->dpcd);
> +       if (ret < 0) {
> +               dev_err(dp->dev, "failed to read dpcd caps: %d\n", ret);
> +               return ret;
> +       }
> +
>         ret =3D analogix_dp_train_link(dp);
>         if (ret) {
>                 dev_err(dp->dev, "unable to do link train, ret=3D%d\n", r=
et);
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h b/drivers=
/gpu/drm/bridge/analogix/analogix_dp_core.h
> index 94348c4e3623..c7997677a286 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.h
> @@ -169,6 +169,8 @@ struct analogix_dp_device {
>         bool                    fast_train_enable;
>         bool                    psr_supported;
>
> +       u8 dpcd[DP_RECEIVER_CAP_SIZE];
> +
>         struct analogix_dp_plat_data *plat_data;
>  };
>
> --
> 2.34.1

Tested-by: Vicente Bergas

This patch was tested toghether with
[PATCH v2] drm/bridge: analogix_dp: Fix PE/VS value shift mismatch
during link training

Regards,
  Vicente.
