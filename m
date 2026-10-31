Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6494C606A31C
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 11:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fnu2kLH3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB06310E07A;
	Sat, 31 Oct 2026 11:56:01 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0188510E07A
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 11:55:54 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-7f84a55e31aso1062826a34.2
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 04:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793447754; cv=none;
 d=google.com; s=arc-20260327;
 b=RW8pw5bc+8O/vlPZYid3Nw2Km2Xs/q2jzqmifYvILZ6oV1nfXiHCKonU8lBTxqYK27
 nQNvn10MoAfzPbnqWn73Ms994RQ88//PjO3RrkyIG1RLghcd/7Zv3/YZPlY1ojQpatJa
 gaXTlF0LYhF9nd+c0xyrSO7rgcVf0c84imxIQcSMxaH6OnoJNcQb4dS66cY8dWNgNjyn
 ImCG5AHtNEKkmwS2Uusvju0i68Qg19BQtjWYWnM8yYagi3BP6pUkYuOnTyd9dajqN6s9
 wxMLcfmHnDVuQriSlBdBv4VfCIufuy9w8cRpN+qN7ycIn2HR5KZe2uZEwQ1N3OUpTZ38
 0WxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L3x/YuVDEAhtU0De0l9xtSKaA6j4KOr096Zh7WSUTJA=;
 fh=cNbBt7jzelvF0RBaB68Ltj1x3fB77YMDDaw2sZx4+pE=;
 b=lSGMMO9oMgsniW5OXe6s/JeuVUqTnXAA8pJqfzJr7BBonsd66AvBeP0o0hbzuuWO+N
 1YuF9GDY3eERtqYsFeXtGujSQMpUi0sf+IlOHzRPkoYxB73ItpolYY9DyszgTzCJJPmp
 gP9MO7SyBT69d9DHacrDQ7iwhUnYzV27iF10m8QaTs1JpIfo/2xslhiyzF+1CfhKp/PR
 TfLG6GBFkM/UwR09HqE0X363nX942FctHpRzXGgPXcI3Nbh17xxoPVig1LjTV8xbudJk
 evy6OScnvPU/97oq2YRPNLatUv3h5sMIdihUSGw4flIniMe/hdWchBjMvWo97xhfJ4Xu
 5mBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793447754; x=1794052554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L3x/YuVDEAhtU0De0l9xtSKaA6j4KOr096Zh7WSUTJA=;
 b=Fnu2kLH3+2QJe3IbDYzmaOdayoekjUzBI65QahLjevY4DOY54gadIHTAkMXIwS3lXs
 B48Lb9vx4llAuljHiBiNrdlKgkV2+k4L4p/FzMeGjpXQCnDcjLeuhxDxxBIFpBzqU13X
 DLFpmgY9qVROy06iTcyOhHGhlDYmaWysCWtMC3NKuxwnuqSXDKgFOAiRlHw4o3CENP1H
 NFSfKgQP0Gk2XsIwiL5jNDTBvya0/vMO6Ewem0wT7kDEreSfvPrfPKmow5PpySLDP9bj
 AYtPMJAzKOfVkMUUiur2krvnA2KBb5MrD99xK/zFjyln3bOIceYQIL3cYc69BA6g7r8C
 gCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793447754; x=1794052554;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L3x/YuVDEAhtU0De0l9xtSKaA6j4KOr096Zh7WSUTJA=;
 b=kAflUrcg0eJ+SgQgLsVYhLPBONfamlxWkBDJ35PaFuEetcLnyqB476sdjL4zeHM+Pe
 qqoIQTsqNUmwOBr1ATY7dPFYNkpZKubAxebwoLzoHt5Em8MIGRsLdr7lTqcFw5VKBRTr
 3cc3CGi/aZVjE07fkcjr0quEk5OesUFB06eV4j5gOPk9AVDCCBcaprjgnk2WvubbkMEn
 69+iYH8T0nkgY9kp8XW3Vz1SMisV/sTipcXLkuyrxPaMVi0HNYiLgZK2Gls6Ej6o4fho
 Xo/5+49cXlvIcN5O6ZNiBlbWg0z+Oxjy4aV1ghkbEKHQIFxHunsMp2sKbhi95BWjx3fR
 +Vuw==
X-Gm-Message-State: AFq9FYJeqPJoJrAd/8I4D0Z2gB2x1mJaOs0P4BDU6linRpJNmp9y1AlB
 zI/gi89n//w38BumeTiLThQqUh+8PQu7veKVNxWtVcJOcdqXuuNLrOf4qVwTK/A4mL+SYsKkQLU
 NTiqd1RrbMIWPIfyTyg5LaRwlBF3kkzQ=
X-Gm-Gg: AYBFou38CsKIzyfO29/K/5jzkCMe6ei9tW4Gz2NhWIKL8yBkxS1Cki8EPIFqejQ6zB0
 IJsNAWryQwcsCZeK2z0GLDW0T1mNsUVwbqHgzSPFhEnvJgI49BH6jUGmlxa8I+KVljpVktqiGKW
 YVKWstMBpNwy32qgimu9eUobWGTUqFmFTViIlhPrbLlIW0d9FbfEdGQl2j/kbChPgRGQw/hZ24e
 PXqw3p0PzoO4al2w5ViH8XmzR+Wouh5AxFdzlqriPufQQ7pZJaNCUiiMb+4ftQ90pNjeZd8DWVq
 q+0evsmJ+ovfoZkLeseB0fPKuXOO4icOqlqQZ9ClkW5FjrxcjwLv69My3sYX+zcuRbc87bjfkN1
 QZ4R6houTBGb1HvfmfINyuugi8Su6/plHDo0=
X-Received: by 2002:a05:6808:1995:b0:4dd:18c7:5448 with SMTP id
 5614622812f47-5640de57273mr3442963b6e.56.1793447753718; Sat, 31 Oct 2026
 04:55:53 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029101826.72773-1-dmitrymalovanyy@gmail.com>
 <20261029101826.72773-5-dmitrymalovanyy@gmail.com>
In-Reply-To: <20261029101826.72773-5-dmitrymalovanyy@gmail.com>
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date: Sat, 31 Oct 2026 12:55:42 +0100
X-Gm-Features: AclHuK-b8gKFoUWpyTo444rLzOgzwu65XdKwpgADL5v7IbA6k1YL_6vO__BFY74
Message-ID: <CAMeQTsaRxZkd7Pawwj-DtZKkRazVUmBM5=DGOQs=y5Yohqt85g@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] drm/gma500: Use drm_dp_enhanced_frame_cap()
To: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>
Cc: dri-devel@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 nouveau@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 11:18=E2=80=AFAM Dmytro Malovanyi
<dmitrymalovanyy@gmail.com> wrote:
>
> Use the helper instead of open coding the check, so enhanced framing is
> used for all DPCD r1.2+ sinks as the spec requires.
>
> The helper takes DP_RECEIVER_CAP_SIZE bytes and gcc warns about reading
> past dpcd[4] (-Wstringop-overread), so read the full receiver caps like
> the other drivers do. That is 15 bytes, it fits in one AUX transfer.
>
> Compile tested only.
>
> Signed-off-by: Dmytro Malovanyi <dmitrymalovanyy@gmail.com>

Acked-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>

> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma5=
00/cdv_intel_dp.c
> index 8d0626ddf..0973598c7 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -262,7 +262,7 @@ struct cdv_intel_dp {
>         uint32_t color_range;
>         uint8_t link_bw;
>         uint8_t lane_count;
> -       uint8_t dpcd[4];
> +       uint8_t dpcd[DP_RECEIVER_CAP_SIZE];
>         struct gma_encoder *encoder;
>         struct i2c_adapter adapter;
>         struct i2c_algo_dp_aux_data algo;
> @@ -1070,11 +1070,7 @@ cdv_intel_dp_mode_set(struct drm_encoder *encoder,=
 struct drm_display_mode *mode
>         intel_dp->link_configuration[0] =3D intel_dp->link_bw;
>         intel_dp->link_configuration[1] =3D intel_dp->lane_count;
>
> -       /*
> -        * Check for DPCD version > 1.1 and enhanced framing support
> -        */
> -       if (intel_dp->dpcd[DP_DPCD_REV] >=3D 0x11 &&
> -           (intel_dp->dpcd[DP_MAX_LANE_COUNT] & DP_ENHANCED_FRAME_CAP)) =
{
> +       if (drm_dp_enhanced_frame_cap(intel_dp->dpcd)) {
>                 intel_dp->link_configuration[1] |=3D DP_LANE_COUNT_ENHANC=
ED_FRAME_EN;
>                 intel_dp->DP |=3D DP_ENHANCED_FRAMING;
>         }
> --
> 2.50.1 (Apple Git-155)
>
